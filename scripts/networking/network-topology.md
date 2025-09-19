# Network Topology

**Last Updated**: Thu Sep 18 23:45:16 EDT 2025

## Tailscale Mesh Network

### Active Nodes:
100.116.44.26   macbook-pro          bibinabraham06@ macOS   -
100.80.8.70     immich               bibinabraham06@ linux   active; relay "mia"; offline, tx 3120 rx 0
100.99.71.128   iphone-localhost     bibinabraham06@ iOS     -
100.121.178.110 mediagw              bibinabraham06@ linux   idle, tx 468 rx 348
100.75.230.110  ollama               bibinabraham06@ linux   active; direct 104.58.70.192:41641, tx 1924 rx 1628
100.94.114.43   pve                  tagged-devices linux   active; direct 104.58.70.192:1070, tx 340052 rx 3422620

### Key Services:
- **Proxmox Host**: 100.94.114.43:8006 (Web UI)
- **Ollama Server**: 100.75.230.110:11434 (AI Models)
- **Immich**: 100.80.8.70 (Photo Management)
- **MediaGW**: 100.121.178.110 (Media Gateway)

### Network Features:
- End-to-end encryption
- NAT traversal
- Subnet routing
- ACL-based access control

## Local Network:
- **MacBook Pro**: Dynamic IP (WiFi)
- **Internet Gateway**: Router/Firewall
- **WiFi Network**: Encrypted WPA3

## Security:
- Tailscale ACLs configured
- Firewall rules on Proxmox
- SSH key authentication
- Certificate-based services
