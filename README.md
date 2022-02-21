# Distributed layer-0 networking deployment

This Terraform module creates a private network along differents OVH regions.

Also, you can decide if create a Virtual Routers and Floatting IPs. Only supported by GRA9 region. **(TODO)**

## How to deploy

1. Clone the terraform multiregion network layer-0 repository:

```
$ git clone git@github.com:LINEA-GRAFICA/tf-ovh-multiregion-layer0.git
```

2. Create a secure.yaml file in order to define the openstack provider authentication credentials.

ie:
```
$ cd tf-ovh-multiregion-layer0/modules/intranet
$ vi secure.yaml
clouds:
  openstack:
    auth:
      username: "XXXXXXX"
      password: "XXXXXXX"
```

3. Define the OVH authentication and application variables value 

ie:
```
$ vi variables.tf
# Define OVHCloud authentication variables #
variable "application_key" {
  description = "OVHCloud Application Key"
  type        = string
  default     = "XXXXXXX"
}

variable "application_secret" {
  description = "OVHCloud Application Secret"
  type        = string
  default     = "XXXXXX"
}

variable "consumer_key" {
  description = "OVHCloud Consumer Key"
  type        = string
  default     = "XXXXXX"
}
##
```

4. Test the files

```
$ terraform init; terraform fmt; terraform validate
```

5. Create a deployment plan

```
$ terraform plan -out multiregion-layer-0
```

6. Deploy the networks

```
$ terraform apply multiregion-layer-0
```