#!/bin/sh

# Listen address for the Docker image.
# BIND_ADDRESS empty: all IPv4 addresses, plus [::] unless IPV6_DISABLE=1.
# BIND_ADDRESS set: that address only. Bracket IPv6 literals — lighttpd accepts
# server.bind = "[::1]" and rejects a bare "::1" (getaddrinfo: Name has no
# usable address). Both forms are accepted here; IPv4 and hostnames are unchanged.
# Keep this bracketing in sync with lighttpd-healthcheck.sh.
if [[ -n "${BIND_ADDRESS}" ]]; then
	case "${BIND_ADDRESS}" in
	\[*\]) addr="${BIND_ADDRESS}" ;;
	*:*) addr="[${BIND_ADDRESS}]" ;;
	*) addr="${BIND_ADDRESS}" ;;
	esac
	printf 'server.bind = "%s"\n' "${addr}"
elif [[ "${IPV6_DISABLE}" != "1" ]]; then
	# Enable IPV6 if needed
	echo '$SERVER["socket"] == "[::]:" + env.PORT {  }'
fi
