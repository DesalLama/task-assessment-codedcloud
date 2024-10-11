variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "project-a"
}

variable "suffix" {
  description = "Suffix for resources"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

