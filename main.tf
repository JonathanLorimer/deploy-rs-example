provider "google" {
  project = "nix-equipment"
  region  = "us-east1"
}

# Networking

resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

# Image Storage

resource "google_storage_bucket" "image_store" {
  name          = "nix-equipment-nixos-images"
  location      = "US-EAST1"
  force_destroy = true

  versioning {
    enabled = true
  }
}

locals {
  nixos_latest_image_path = tolist(fileset(path.root, "build/**.raw.tar.gz"))[0]
  nixos_latest_image_name = regex("^build/(?P<image_name>nixos\\-image\\-\\d{2}\\.\\d{2}).*$", local.nixos_latest_image_path).image_name
}

resource "google_storage_bucket_object" "nixos_latest_raw_disk" {
  name   = "${local.nixos_latest_image_name}.raw.tar.gz"
  source = "${path.root}/${local.nixos_latest_image_path}"
  bucket = "nix-equipment-nixos-images"
}

# GCE

resource "google_compute_image" "nixos_latest_image" {
  name = replace(local.nixos_latest_image_name, ".", "")
  raw_disk {
    source = google_storage_bucket_object.nixos_latest_raw_disk.self_link
  }
}

resource "google_compute_instance" "node1" {
  name         = "node1"
  machine_type = "n1-standard-1"
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = google_compute_image.nixos_latest_image.self_link
    }
  }

  network_interface {
    network = "default"
    access_config {
      network_tier = "STANDARD"
    }
  }
}
