#!/bin/bash

get_ip_asn() {
    while read -r input || [[ -n "$input" ]]; do
        target=$(echo "$input" | xargs)

        # If input is a domain, resolve to IP
        if [[ "$target" =~ ^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
            ip=$(dig +short "$target" | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | head -n 1)
        else
            ip="$target"
        fi

        # Validate IP
        if [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
            response=$(curl -s "https://api.bgpview.io/ip/$ip")
            if [[ $(echo "$response" | jq -r '.status') == "ok" ]]; then
                asn=$(echo "$response" | jq -r '.data.prefixes[0].asn.asn')
                name=$(echo "$response" | jq -r '.data.prefixes[0].asn.name')
                desc=$(echo "$response" | jq -r '.data.prefixes[0].asn.description')
                echo "IP: $ip | ASN: $asn | Name: $name | Description: $desc"
            else
                echo "No ASN data found for IP: $ip" >&2
            fi
        else
            echo "Invalid IP or domain: $target" >&2
        fi
    done
}

# Entry point
if [[ -t 0 && -n "$1" ]]; then
    echo "$1" | get_ip_asn
else
    get_ip_asn
fi
