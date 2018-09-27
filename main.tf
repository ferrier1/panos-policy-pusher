data "external" "csv_file" {
  program = ["python", "${path.module}/parser.py"]

  query = {
    names = "names"
    source_zones = "source_zones"
    source_addresses = "source_addresses"
    source_users = "source_users"
    hip_profiles = "hip_profiles"
    destination_zones = "destination_zones"
    destination_addresses = "destination_addresses"
    applications = "applications"
    services = "services"
    categories = "categories"
    action = "action"
  }

}


provider "panos" {
    hostname = ""
    username = ""
    password = ""
}

resource "panos_security_policy" "example" {
  count = "${length(split(",", data.external.csv_file.result.names))}"
  rule = {
    name = "${element(split(",", data.external.csv_file.result.names), count.index)}"
    source_zones = ["${element(split(",", data.external.csv_file.result.source_zones), count.index)}"]
    source_addresses = ["${element(split(",", data.external.csv_file.result.source_addresses), count.index)}"]
    source_users = ["${element(split(",", data.external.csv_file.result.source_users), count.index)}"]
    hip_profiles = ["${element(split(",", data.external.csv_file.result.hip_profiles), count.index)}"]
    destination_zones = ["${element(split(",", data.external.csv_file.result.destination_zones), count.index)}"]
    destination_addresses = ["${element(split(",", data.external.csv_file.result.destination_addresses), count.index)}"]
    applications = ["${element(split(",", data.external.csv_file.result.applications), count.index)}"]
    services = ["${element(split(",", data.external.csv_file.result.services), count.index)}"]
    categories = ["${element(split(",", data.external.csv_file.result.categories), count.index)}"]
    action = "${element(split(",", data.external.csv_file.result.action), count.index)}"
  }
}
