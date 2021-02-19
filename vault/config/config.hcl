storage "file" {
  path = "/var/lib/vault/data"
}

listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_disable   = true
}
