# Define the Google Cloud provider and the region where the resources will be provisioned
provider "google" {
  project = "<your_project_id>"
  region  = "us-central1"
}

# Create a virtual network
resource "google_compute_network" "vnet" {
  name = "vnet"
}

# Create subnets for the web, application, and database tiers
resource "google_compute_subnetwork" "web_subnet" {
  name          = "web_subnet"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.vnet.self_link
}

resource "google_compute_subnetwork" "app_subnet" {
  name          = "app_subnet"
  ip_cidr_range = "10.0.2.0/24"
  network       = google_compute_network.vnet.self_link
}

resource "google_compute_subnetwork" "db_subnet" {
  name          = "db_subnet"
  ip_cidr_range = "10.0.3.0/24"
  network       = google_compute_network.vnet.self_link
}

# Create a firewall rule to allow traffic to the web tier
resource "google_compute_firewall" "web_firewall" {
  name    = "web_firewall"
  network = google_compute_network.vnet.self_link

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# Create a VM running a web server in the web tier subnet
resource "google_compute_instance" "web_instance" {
  name         = "web_instance"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.web_subnet.self_link
    access_config {
      //<ephemeral IP address to the instance>
    }
  }
  metadata_startup_script = "sudo apt-get update && sudo apt-get install -y apache2 && sudo service apache2 restart"
}

# Create a VM running an application server in the application tier subnet
resource "google_compute_instance" "app_instance" {
  name         = "app_instance"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.app_subnet.self_link
    access_config {
      // <ephemeral IP address to the instance>
    }
  }
  metadata_startup_script = "nodejs_startup_script.sh"
}

# Create a VM running a database server in the database tier subnet
resource "google_compute_instance" "db_instance" {
  name         = "db_instance"
  machine_type = "db-n1-standard-1"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.db_subnet.self_link
    access_config {
      //<ephemeral IP address to the instance>
    }
  }
  metadata_startup_script = "mysql_startup_script.sh"
}
