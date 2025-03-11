resource "esxi_guest" "webservers" {
  count = 1
  ovf_source = "https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-24.04-server-cloudimg-amd64.ova"
  guest_name = "webserver_${count.index + 1}"
  disk_store = var.datastore

  memsize    = "2048"
  numvcpus   = "1"

  network_interfaces {
    virtual_network = "VM Network"
  }

  guestinfo = {
    "metadata"          = base64encode(templatefile("../../../vm-specifications/skylab/week_one/webserver/metadata.yaml", { HOSTNAME = "webserver" }))
    "metadata.encoding" = "base64"
    "userdata" = base64encode(templatefile("../../../vm-specifications/skylab/week_one/webserver/userdata.yaml", {} ))
    "userdata.encoding" = "base64"
  }
}

resource "esxi_guest" "database_servers" {
  count = 1
  ovf_source = "https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-24.04-server-cloudimg-amd64.ova"
  guest_name = "database_server_${count.index + 1}"
  disk_store = var.datastore

  memsize    = "2048"
  numvcpus   = "1"

  network_interfaces {
    virtual_network = "VM Network"
  }

  guestinfo = {
    "metadata"          = base64encode(templatefile("../../../vm-specifications/skylab/week_one/database-server/metadata.yaml", { HOSTNAME = "database_server" }))
    "metadata.encoding" = "base64"
    "userdata" = base64encode(templatefile("../../../vm-specifications/skylab/week_one/database-server/userdata.yaml", {} ))
    "userdata.encoding" = "base64"
  }
}


resource "local_file" "vm_ips" {
  # Heredoc STRING based on https://developer.hashicorp.com/terraform/language/expressions/strings#heredoc-strings
  content = <<EOT
[webservers]
${join("\n", esxi_guest.webservers[*].ip_address)}
[database_servers]
${join("\n", esxi_guest.database_servers[*].ip_address)}
  EOT
  filename = "inventory.ini"
}
