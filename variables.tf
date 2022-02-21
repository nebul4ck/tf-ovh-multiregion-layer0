# Define OVHCloud authentication variables #
variable "application_key" {
  description = "OVHCloud Application Key"
  type        = string
  default     = "0ti15LkhYZWG5jqY"
}

variable "application_secret" {
  description = "OVHCloud Application Secret"
  type        = string
  default     = "7RuqvPIAG3CC3uFNuwL8Nihzyp5t7P5o"
}

variable "consumer_key" {
  description = "OVHCloud Consumer Key"
  type        = string
  default     = "l7IlW67P6dyMDwSKnuSrIJksdQZ0f9tw"
}
##


# Define application variables #
variable "tenant_id" {
  description = "The ID of the Tenant (Identity v2) or Project (Identity v3) to login with."
  type        = string
  default     = "8e619c5c3aee47b093057b64081a3d75"
}

variable "regions" {
  description = "The regions over the private network operates."
  type        = list(string)
  default     = ["GRA11", "BHS5"]
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  default     = "intranet-67"
}

variable "default_ovh_pub_net" {
  description = "The name of the external ovh public network."
  default     = "Ext-Net"
}

variable "create_virtual_router" {
  description = "Are you interesing on virtual router deployment?, Remember only GRA9 let us to deploy virtual routers."
  default     = false
}
##