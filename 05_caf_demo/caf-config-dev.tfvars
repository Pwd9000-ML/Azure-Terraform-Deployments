global_settings = {
  default_region = "region1"
  regions = {
    region1 = "uksouth"
  }
  prefixes = ["demo"]
  resource_defaults = {
    virtual_machines = {
      use_azmanaged_storage_for_boot_diagnostics = true
    }
  }
}

resource_groups = {
  vm_region1 = {
    name = "brainboard-demo-rg1"
  }
}

# Virtual machines
virtual_machines = {

  # Configuration to deploy a bastion host linux virtual machine
  example_vm1 = {
    resource_group_key = "vm_region1"
    provision_vm_agent = true
    os_type            = "linux"

    # the auto-generated ssh key in keyvault secret. Secret name being {VM name}-ssh-public and {VM name}-ssh-private
    keyvault_key = "example_vm_rg1"

    # Define the number of networking cards to attach the virtual machine
    networking_interfaces = {
      nic0 = {
        # Value of the keys from networking.tfvars
        vnet_key                = "vnet_region1"
        subnet_key              = "example"
        primary                 = true
        name                    = "0"
        enable_ip_forwarding    = false
        internal_dns_name_label = "nic0"
        public_ip_address_key   = "example_vm_pip1_rg1"

      }
    }

    virtual_machine_settings = {
      linux = {
        name                            = "example_vm1"
        size                            = "Standard_F2"
        admin_username                  = "adminuser"
        disable_password_authentication = true

        # Spot VM to save money
        priority        = "Spot"
        eviction_policy = "Deallocate"

        # Value of the nic keys to attach the VM. The first one in the list is the default nic
        network_interface_keys = ["nic0"]

        os_disk = {
          name                 = "example_vm1-os"
          caching              = "ReadWrite"
          storage_account_type = "Standard_LRS"
        }
        identity = {
          type = "SystemAssigned"
        }
        source_image_reference = {
          publisher = "Canonical"
          offer     = "UbuntuServer"
          sku       = "18.04-LTS"
          version   = "latest"
        }

      }
    }
    data_disks = {
      data1 = {
        name                 = "server1-data1"
        storage_account_type = "Standard_LRS"
        # Only Empty is supported. More community contributions required to cover other scenarios
        create_option = "Empty"
        disk_size_gb  = "10"
        lun           = 1
        zones         = ["1"]
      }
    }
  }
}


keyvaults = {
  example_vm_rg1 = {
    name                        = "vmlinuxakv"
    resource_group_key          = "vm_region1"
    sku_name                    = "standard"
    soft_delete_enabled         = true
    purge_protection_enabled    = true
    enabled_for_disk_encryption = true
    tags = {
      env = "Standalone"
    }
    creation_policies = {
      logged_in_user = {
        secret_permissions = ["Set", "Get", "List", "Delete", "Purge", "Recover"]
      }
    }
  }
}


vnets = {
  vnet_region1 = {
    resource_group_key = "vm_region1"
    vnet = {
      name          = "virtual_machines"
      address_space = ["10.100.100.0/24"]
    }
    subnets = {
      example = {
        name = "examples"
        cidr = ["10.100.100.0/29"]
      }
    }

  }
}

public_ip_addresses = {
  example_vm_pip1_rg1 = {
    name                    = "example_vm_pip1"
    resource_group_key      = "vm_region1"
    sku                     = "Standard"
    allocation_method       = "Static"
    ip_version              = "IPv4"
    idle_timeout_in_minutes = "4"

  }
}