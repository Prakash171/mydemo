provider "aws" {
    region = "us-west-2"
#    region = "${var.region}"
#    access_key = "${var.access_key}"
#    secret_key = "${var.secret_key}"
    access_key = "$access_key"
    secret_key = "$secret_key"
}
