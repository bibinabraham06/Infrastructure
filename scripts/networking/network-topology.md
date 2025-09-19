# Network Topology

**Last Updated**: Fri Sep 19 06:45:13 EDT 2025

## Tailscale Mesh Network

### Active Nodes:
100.116.44.26   macbook-pro          bibinabraham06@ macOS   -
100.80.8.70     immich               bibinabraham06@ linux   offline
100.99.71.128   iphone-localhost     bibinabraham06@ iOS     -
100.121.178.110 mediagw              bibinabraham06@ linux   -
100.75.230.110  ollama               bibinabraham06@ linux   active; relay "mia", tx 260 rx 264
100.94.114.43   pve                  tagged-devices linux   idle, tx 582516 rx 4940076

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
