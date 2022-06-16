# VPC Network ACLs Module

This module is used to create any number of Network Access Control Lists in a single VPC.

# Module Variables

Name         | Type                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Description                                                                                                                                                                                                                                                                                                                                                                          | Sensitive | Default
------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
prefix       | string                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | The prefix that you would like to append to your resources                                                                                                                                                                                                                                                                                                                           |           | 
vpc_id       | string                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ID of the VPC where address prefixes will be created                                                                                                                                                                                                                                                                                                                                 |           | 
tags         | list(string)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | List of Tags for each resource                                                                                                                                                                                                                                                                                                                                                       |           | []
network_cidr | string                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | OPTIONAL - Network CIDR for add cluster rules. If null, will default to 0.0.0.0/0                                                                                                                                                                                                                                                                                                    |           | null


## Network ACL Variable

The type of the network ACL variable is the following:

```terraform
  type = list(
    object({
      name              = string                 # Name of the ACL. The value of `var.prefix` will be prepended to this name
      add_cluster_rules = optional(bool)         # Dynamically create cluster allow rules
      resource_group_id = optional(string)       # ID of the resource group where the ACL will be created
      tags              = optional(list(string)) # List of tags for the ACL
      rules = list(
        object({
          name        = string # Rule Name
          action      = string # Can be `allow` or `deny`
          destination = string # CIDR for traffic destination
          direction   = string # Can be `inbound` or `outbound`
          source      = string # CIDR for traffic source
          # Any one of the following blocks can be used to create a TCP, UDP, or ICMP rule
          # to allow all kinds of traffic, use no blocks
          tcp = optional(
            object({
              port_max        = optional(number)
              port_min        = optional(number)
              source_port_max = optional(number)
              source_port_min = optional(number)
            })
          )
          udp = optional(
            object({
              port_max        = optional(number)
              port_min        = optional(number)
              source_port_max = optional(number)
              source_port_min = optional(number)
            })
          )
          icmp = optional(
            object({
              type = optional(number)
              code = optional(number)
            })
          )
        })
      )
    })
  )
```