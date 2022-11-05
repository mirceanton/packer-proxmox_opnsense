Packer Template: PVE opnSense
=============================

A Packer template that creates an opnSense VM template on a Proxmox VE host.

Requirements
------------

- A Proxmox VE Host
- A machine with Hashicorp Packer
- A network connection between the PVE host and the builder machine

Getting Started
---------------

- Clone this repo
- Downlod the opnSense 22.7 ISO and upload it to your Proxmox server
- Create a `.auto.pkrvars.hcl` file and customize it
- Run the `packer build` command

Variables
---------

Here's an empty sample for the `.auto.pkrvars.hcl` file, for you to customize:

```hcl
# ===============================================
# PROXMOX API CONNECTION
# ===============================================
proxmox_api_url          = ""
proxmox_api_token_id     = ""
proxmox_api_token_secret = ""
proxmox_node             = ""

# ===============================================
# ISO FILE CONFIGURATION
# ===============================================
iso_file = ""

# ===============================================
# OPNSENSE CONFIGURATION
# ===============================================
opnsense_root_password = ""

# ===============================================
# VM TEMPLATE CONFIGURATION
# ===============================================
vm_id   = ""
vm_name = ""

storage_pool      = ""
storage_pool_type = ""

wan_vmbridge = ""
lan_vmbridge = ""
```

License
-------

MIT

Author Information
------------------

A template developed by [Mircea-Pavel ANTON](https://www.mirceanton.com).
