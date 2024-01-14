variable "create" {
  description = "Whether cluster should be created (affects nearly all resources)"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# RDS Proxy
################################################################################

variable "name" {
  description = "The identifier for the proxy. This name must be unique for all proxies owned by your AWS account in the specified AWS Region. An identifier must begin with a letter and must contain only ASCII letters, digits, and hyphens; it can't end with a hyphen or contain two consecutive hyphens"
  type        = string
  default     = ""
}

variable "auth" {
  description = "Configuration block(s) with authorization mechanisms to connect to the associated instances or clusters"
  type        = any
  default     = {}
}

variable "debug_logging" {
  description = "Whether the proxy includes detailed information about SQL statements in its logs"
  type        = bool
  default     = false
}

variable "engine_family" {
  description = "The kind of database engine that the proxy will connect to. Valid values are `MYSQL` or `POSTGRESQL`"
  type        = string
  default     = ""
}

variable "idle_client_timeout" {
  description = "The number of seconds that a connection to the proxy can be inactive before the proxy disconnects it"
  type        = number
  default     = 1800
}

variable "require_tls" {
  description = "A Boolean parameter that specifies whether Transport Layer Security (TLS) encryption is required for connections to the proxy"
  type        = bool
  default     = true
}

variable "role_arn" {
  description = "The Amazon Resource Name (ARN) of the IAM role that the proxy uses to access secrets in AWS Secrets Manager"
  type        = string
  default     = ""
}

variable "vpc_security_group_ids" {
  description = "One or more VPC security group IDs to associate with the new proxy"
  type        = list(string)
  default     = []
}

variable "vpc_subnet_ids" {
  description = "One or more VPC subnet IDs to associate with the new proxy"
  type        = list(string)
  default     = []
}

variable "proxy_tags" {
  description = "A map of tags to apply to the RDS Proxy"
  type        = map(string)
  default     = {}
}

# Proxy Default Target Group
variable "connection_borrow_timeout" {
  description = "The number of seconds for a proxy to wait for a connection to become available in the connection pool"
  type        = number
  default     = null
}

variable "init_query" {
  description = "One or more SQL statements for the proxy to run when opening each new database connection"
  type        = string
  default     = ""
}

variable "max_connections_percent" {
  description = "The maximum size of the connection pool for each target in a target group"
  type        = number
  default     = 90
}

variable "max_idle_connections_percent" {
  description = "Controls how actively the proxy closes idle database connections in the connection pool"
  type        = number
  default     = 50
}

variable "session_pinning_filters" {
  description = "Each item in the list represents a class of SQL operations that normally cause all later statements in a session using a proxy to be pinned to the same underlying database connection"
  type        = list(string)
  default     = []
}

# Proxy Target
variable "target_db_instance" {
  description = "Determines whether DB instance is targeted by proxy"
  type        = bool
  default     = false
}

variable "db_identifier" {
  description = "DB instance identifier"
  type        = string
  default     = ""
}

variable "target_db_cluster" {
  description = "Determines whether DB cluster is targeted by proxy"
  type        = bool
  default     = false
}

# Proxy endpoints
variable "endpoints" {
  description = "Map of DB proxy endpoints to create and their attributes (see `aws_db_proxy_endpoint`)"
  type        = any
  default     = {}
}