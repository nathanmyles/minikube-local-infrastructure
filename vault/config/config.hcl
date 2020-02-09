storage "file" {
  path = "/var/lib/vault/data"
}

listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_cert_file = "/var/lib/vault/certs/certificate.crt"
  tls_key_file  = "/var/lib/vault/certs/private_key.key"
}

listener "tcp" {
  address       = "0.0.0.0:8300"
  tls_disable   = true
}
