#!/bin/sh
set -e

(>&2 echo "Remediating: 'xccdf_org.ssgproject.content_rule_configure_crypto_policy'")

var_system_crypto_policy="FIPS:OSPP"

update-crypto-policies --set ${var_system_crypto_policy}
