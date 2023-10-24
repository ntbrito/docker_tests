ui = true

storage "consul" {
  address = "10.100.1.68:8500"
  path    = "vault/"
}

seal "awskms" {
  region     = "eu-west-1"
  kms_key_id = "edab83b8-c1fc-4350-9b98-434b6c6ae5c7"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}