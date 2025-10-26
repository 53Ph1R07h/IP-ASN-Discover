# GetIPAsn.sh

**GetIPAsn.sh** is a simple and powerful Bash script to fetch the **ASN (Autonomous System Number) information** for any IP address or domain using the [BGPView API](https://bgpview.io/). It works with both **direct IPs** and **domain names**, making it ideal for penetration testing, network reconnaissance, or general network research.

---

## Features

- Resolve **domains to IPv4 addresses** automatically
- Retrieve **ASN number, ASN name, and description** for any IP
- Supports **single IP/domain lookup** or **batch lookup via stdin**
- Lightweight, **no installation required** except `bash`, `curl`, `dig`, and `jq`
- Easy to integrate into scripts or pipelines

---

## Requirements

- Bash (`>=4.x`)
- `curl`
- `dig` (from `dnsutils`)
- `jq`

Install dependencies on Debian/Ubuntu:

```bash
sudo apt update
sudo apt install -y curl dnsutils jq
```

---

## Usage

### Single IP or Domain

```bash
./GetIPAsn.sh 8.8.8.8
./GetIPAsn.sh example.com
```

**Example Output:**

```
IP: 8.8.8.8 | ASN: 15169 | Name: GOOGLE | Description: Google LLC
```

### Multiple Inputs from a File

```bash
cat targets.txt | ./GetIPAsn.sh
```

Where `targets.txt` contains:

```
8.8.8.8
1.1.1.1
example.com
```

### Using Command-Line Arguments and STDIN

- If you provide an argument, it will use that single target.
- If no argument is provided, it reads from **stdin**, allowing batch processing.

```bash
echo "example.com" | ./GetIPAsn.sh
```

---

## How It Works

1. Checks if the input is a **domain**; if so, resolves it to an IPv4 address.
2. Validates the IP format.
3. Queries the [BGPView API](https://bgpview.io/) to fetch ASN information.
4. Prints the ASN number, ASN name, and ASN description for the IP.
5. If multiple prefixes exist, only the first is displayed (for simplicity).

---

## Error Handling

- Invalid IPs or domains will show an error:

```
Invalid IP or domain: invalid-input
```

- If the API has no ASN data for the IP:

```
No ASN data found for IP: 1.2.3.4
```

---

## Example

```bash
./GetIPAsn.sh google.com
# Output:
IP: 142.250.190.14 | ASN: 15169 | Name: GOOGLE | Description: Google LLC
```

---


## License

This project is **MIT licensed**. Free to use, modify, and share.

---

## Author

**sephiroth** – Network researcher / pentester / Bash enthusiast
