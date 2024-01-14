resource "aws_ses_template" "template" {
  count = var.create_ses_templates ? 1: 0
  name    = var.ses_template_name
  subject = var.ses_template_subject
  html = var.ses_template_html
  text    = var.ses_template_text
}
