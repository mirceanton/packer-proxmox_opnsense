# ===============================================
# PROXMOX API CONNECTION
# ===============================================
variable "proxmox_api_url" {
  type = string
  description = "The URL for the Proxmox API (https://ip:port/api2/json)."
}

variable "proxmox_api_token_id" {
  type = string
  sensitive = true
  description = "The ID for the PVE token."
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
  description = "The secret for the PVE token."
}

variable "proxmox_node" {
  type = string
  description = "The name of the node on which to deploy the VM."
}

# ===============================================
# ISO FILE CONFIGURATION
# ===============================================
variable "iso_file" {
  type = string
  description = "The path (including storage device) to the ISO file. (ex.: local:iso/OPNsense-22.7.iso )"
}

# ===============================================
# VM TEMPLATE CONFIGURATION
# ===============================================
variable "vm_id" {
  type = string
  description = "The ID of the VM template."
}

variable "vm_name" {
  type = string
  description = "The name of the VM template."
}

variable "storage_pool" {
  type = string
  description = "The storage pool for the VM template."
}

variable "storage_pool_type" {
  type = string
  description = "The storage pool type for the VM template."
}

variable "wan_vmbridge" {
  type        = string
  description = "The vmbr interface on which the VM should bind."
}

variable "lan_vmbridge" {
  type        = string
  description = "The vmbr interface on which the VM should bind."
}

# ===============================================
# OPNSENSE CONFIGURATION
# ===============================================
variable "opnsense_root_password" {
  type      = string
  sensitive = true
  description = "Password for the root account on opnSense."
}
