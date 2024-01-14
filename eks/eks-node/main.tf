//data "aws_ami" "eks_worker" {
//  filter {
//    name   = "name"
//    values = ["amazon-eks-node-${var.eks_version}-v*"]
//  }
//  most_recent = true
//  owners      = ["602401143452"] # Amazon EKS AMI Account ID
//}

locals {
  eks_node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${var.eks_endpoint}' --b64-cluster-ca '${var.eks_certificate_authority}' '${var.eks_name}'
yum install -y iptables-services
iptables --insert FORWARD 1 --in-interface eni+ --destination 169.254.169.254/32 --jump DROP
iptables-save | tee /etc/sysconfig/iptables
systemctl enable --now iptables
USERDATA
}

resource "aws_launch_configuration" "eks_lc" {
  associate_public_ip_address = false
  iam_instance_profile        = var.eks_node_instance_profile_name
  //  image_id                    = data.aws_ami.eks_worker.id
  image_id         = var.image_id
  instance_type    = var.eks_node_instance_type
  key_name         = var.eks_node_instance_key_name
  name_prefix      = "eks"
  security_groups  = var.eks_node_security_groups
  root_block_device {
    encrypted = true
  }
  user_data_base64 = base64encode(local.eks_node-userdata)
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "eks_asg" {
  desired_capacity     = var.eks_asg_desired_capacity
  launch_configuration = aws_launch_configuration.eks_lc.id
  max_size             = var.eks_asg_max_size
  min_size             = var.eks_asg_min_size
  name                 = "eks-asg-${var.eks_node_name}"
  vpc_zone_identifier  = [var.eks_node_vpc_zone_identifier]
  tag {
    key                 = "Name"
    value               = "eks_node-${var.eks_node_name}"
    propagate_at_launch = true
  }
  tag {
    key                 = "kubernetes.io/cluster/${var.eks_name}"
    value               = "owned"
    propagate_at_launch = true
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/enabled"
    value               = "true"
    propagate_at_launch = true
  }
  tag {
    key                 = "k8s.io/cluster-autoscaler/${var.eks_name}"
    value               = "owned"
    propagate_at_launch = true
  }
  tag {
    key                 = "Environment"
    propagate_at_launch = true
    value               = var.environment
  }
  tag {
    key                 = "Terraform"
    propagate_at_launch = true
    value               = "true"
  }
}
