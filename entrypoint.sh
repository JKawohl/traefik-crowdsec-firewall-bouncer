#!/bin/sh
set -eu

iptables -nL CROWDSEC_CHAIN >/dev/null 2>&1 || iptables -N CROWDSEC_CHAIN
ip6tables -nL CROWDSEC_CHAIN >/dev/null 2>&1 || ip6tables -N CROWDSEC_CHAIN
iptables -C INPUT -j CROWDSEC_CHAIN 2>/dev/null || iptables -I INPUT -j CROWDSEC_CHAIN
iptables -C FORWARD -j CROWDSEC_CHAIN 2>/dev/null || iptables -I FORWARD -j CROWDSEC_CHAIN
if iptables -nL DOCKER-USER >/dev/null 2>&1; then
  iptables -C DOCKER-USER -j CROWDSEC_CHAIN 2>/dev/null || iptables -I DOCKER-USER 1 -j CROWDSEC_CHAIN
fi
ip6tables -C INPUT -j CROWDSEC_CHAIN 2>/dev/null || ip6tables -I INPUT -j CROWDSEC_CHAIN
ip6tables -C FORWARD -j CROWDSEC_CHAIN 2>/dev/null || ip6tables -I FORWARD -j CROWDSEC_CHAIN

exec /usr/bin/crowdsec-firewall-bouncer -c /etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml
