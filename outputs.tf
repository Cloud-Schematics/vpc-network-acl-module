##############################################################################
# ACL Outputs
##############################################################################

output "acls" {
  description = "List of Network ACL names and ids"
  value = [
    for network_acl in ibm_is_network_acl.acl :
    {
      id   = network_acl.id
      name = network_acl.name
    }
  ]
}


##############################################################################