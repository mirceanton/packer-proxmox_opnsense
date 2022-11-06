source "proxmox" "opnsense" {
  # ============================
  # Proxmox Connection Settings
  # ============================
  proxmox_url              = "${var.proxmox_api_url}"
  username                 = "${var.proxmox_api_token_id}"
  token                    = "${var.proxmox_api_token_secret}"
  insecure_skip_tls_verify = true # ignore self signed certs

  # ============================
  # General Settings
  # ============================
  node       = "${var.proxmox_node}"
  vm_id      = "${var.vm_id}"
  vm_name    = "${var.vm_name}"
  qemu_agent = false # Disable guest agent

  # ============================
  # ISO Settings
  # ============================  
  iso_file    = "${var.iso_file}"
  unmount_iso = true # Unmount the iso from the CD drive

  # ============================
  # Resource Settings
  # ============================
  cores  = "1"    # Minimum cpu requirement as per the official doc
  memory = "2048" # Minimum ram requirement as per the official doc

  # ============================
  # Disk Settings
  # ============================
  scsi_controller = "virtio-scsi-pci"
  disks {
    disk_size         = "16G"
    storage_pool      = "${var.storage_pool}"
    storage_pool_type = "${var.storage_pool_type}"
  }

  # =============================================
  # NETWORK
  # =============================================
  network_adapters { # LAN
    bridge   = "${var.lan_vmbridge}"
    firewall = false
    model    = "virtio"
  }
  network_adapters { # WAN
    bridge   = "${var.wan_vmbridge}"
    firewall = false
    model    = "virtio"
  }

  # ============================
  # Boot Settings
  # ============================
  boot      = "c"
  boot_wait = "150s"
  boot_command = [
    # Log in as the 'installer' user
    "installer", "<enter>",
    "<wait1>",

    # With the 'opnsense' password
    "opnsense", "<enter>",
    "<wait1>",

    # Continue with default keymap
    "<enter>",
    "<wait1>",

    # Insall (ZFS)
    "<down>", "<wait1>", "<enter>", "<wait5>",
    "<wait1>",

    # Select 'Stripe'
    "<enter>",
    "<wait1>",

    # Select 'da0' disk
    "<spacebar>", "<wait1>", "<enter>",
    "<wait1>",

    # Confirm selection
    "<left>", "<wait1>", "<enter>",

    # Wait for OS install
    "<wait90>",

    # Select 'Root Password"
    "<enter>",
    "<wait1>",

    # Set root password
    "${var.opnsense_root_password}", "<wait1>", "<enter>",
    "<wait1>",

    # Confirm password
    "${var.opnsense_root_password}", "<wait1>", "<enter>",
    "<wait1>",

    # Select 'Complete Install'
    "<down>", "<wait1>", "<enter>",
    "<wait1>",
    "<leftCtrlOn>c<leftCtrlOff>",
    "root", "<enter>",
    "<wait1>",
    "opnsense", "<enter>",
    "<wait1>",
    "8", "<enter>",
    "<wait1>",
    "echo 'openssh_enable=\"YES\"' >> /mnt/usr/local/etc/rc.conf", "<enter>",
    "<wait1>",
    "echo 'openssh_enable=\"YES\"' >> /mnt/etc/rc.conf", "<enter>",
    "<wait1>",
    "sed -i '' 's/<ssh>/<ssh>\\n\\t\\t<enabled>enabled<\\/enabled>/g' /mnt/conf/config.xml", "<enter> ",
    "<wait1>",
    "sed -i '' 's/<ssh>/<ssh>\\n\\t\\t<permitrootlogin>1<\\/permitrootlogin>/g' /mnt/conf/config.xml", "<enter> ",
    "<wait1>",
    "sed -i '' 's/<ssh>/<ssh>\\n\\t\\t<passwordauth>1<\\/passwordauth>/g' /mnt/conf/config.xml", "<enter> ",
    "<wait1>",
    "sed -i '' 's/<ssh>/<ssh>\\n\\t\\t<noauto>1<\\/noauto>/g' /mnt/conf/config.xml", "<enter> ",
    "<wait1>",
    "sed -i '' 's/<ssh>/<ssh>\\n\\t\\t<interfaces \\/>/g' /mnt/conf/config.xml", "<enter> ",
    "<wait1>",
    "sed -i '' 's/192.168.1.1/${var.opnsense_lan_ip}/g' /mnt/conf/config.xml", "<enter> ",
    "<wait1>",
  ]

  ssh_username = "root"
  communicator = "none"
}

build {
  name    = "opnsense-22.7"
  sources = ["source.proxmox.opnsense"]
}