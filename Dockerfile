FROM debian:12-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates gnupg2 iptables ipset lsb-release \
    && curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.deb.sh | bash \
    && apt-get install -y --no-install-recommends crowdsec-firewall-bouncer-iptables \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/crowdsec-firewall-bouncer"]
