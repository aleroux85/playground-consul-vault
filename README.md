# playground-consul-vault

Built using https://testdriven.io/blog/managing-secrets-with-vault-and-consul

## Startup

`docker-compose build`

`docker-compose up`

Unseal Vault and install certs

## Unseal and make certs

follow https://learn.hashicorp.com/vault/secrets-management/sm-pki-engine

```
vault secrets enable pki

vault secrets tune -max-lease-ttl=87600h pki

vault write -field=certificate pki/root/generate/internal \
    common_name="example.com" \
    ttl=87600h > CA_cert.crt

vault write pki/config/urls \
    issuing_certificates="http://127.0.0.1:8200/v1/pki/ca" \
    crl_distribution_points="http://127.0.0.1:8200/v1/pki/crl"
```

```
vault secrets enable -path=pki_int pki

vault secrets tune -max-lease-ttl=43800h pki_int

vault write -format=json pki_int/intermediate/generate/internal \
    common_name="example.com Intermediate Authority" ttl="43800h" \
    | jq -r '.data.csr' > pki_intermediate.csr

vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr \
    format=pem_bundle ttl="43800h" \
    | jq -r '.data.certificate' > intermediate.cert.pem

vault write pki_int/intermediate/set-signed certificate=@intermediate.cert.pem
```

```
vault write pki_int/roles/example-dot-com \
    allowed_domains="example.com" \
    allow_subdomains=true \
    max_ttl="720h" \
    ext_key_usage="ClientAuth"
```

```
vault write pki_int/issue/example-dot-com \
    common_name="test.example.com"\
    ttl="24h"
```