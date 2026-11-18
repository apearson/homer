#!/bin/sh

# Probe the address lighttpd is bound to. An empty BIND_ADDRESS keeps the
# historical check of http://127.0.0.1:$PORT/. Bracket bare IPv6 literals so
# the URL is http://[::1]:$PORT/ (wget and lighttpd both require the brackets).
# Keep this bracketing in sync with lighttpd-ipv6.sh.
addr="${BIND_ADDRESS:-127.0.0.1}"
case "${addr}" in
\[*\]) ;;
*:*) addr="[${addr}]" ;;
esac

exec wget --no-verbose -Y off --tries=1 --spider "http://${addr}:${PORT}/"
