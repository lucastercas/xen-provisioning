variable "do_token" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_ssh_key" "default" {
  name       = "hyperion ssh key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "digitalocean_droplet" "loadbalancer" {
  count    = 1
  name     = "loadbalancer-${count.index}"
  image    = "debian-10.3-x64"
  size     = "s-1vcpu-1gb"
  region   = "lon1"
  ssh_keys = ["${digitalocean_ssh_key.default.fingerprint}"]
}

resource "digitalocean_droplet" "master" {
  count    = 3
  name     = "master-${count.index}"
  image    = "debian-10.3-x64"
  size     = "s-1vcpu-1gb"
  region   = "lon1"
  ssh_keys = ["${digitalocean_ssh_key.default.fingerprint}"]
}


resource "digitalocean_droplet" "worker" {
  count    = 0
  name     = "worker-${count.index}"
  image    = "debian-10.3-x64"
  size     = "s-1vcpu-1gb"
  region   = "lon1"
  ssh_keys = ["${digitalocean_ssh_key.default.fingerprint}"]
}
