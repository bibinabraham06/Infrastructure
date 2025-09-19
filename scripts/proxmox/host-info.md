# Proxmox Host Configuration

**Host**: 100.94.114.43
**Status**: 🟢 Online
**Last Backup**: Thu Sep 18 23:45:16 EDT 2025

## Container Layout:

### Container 120 - AI Model Server
- **Purpose**: Ollama AI model hosting
- **Resources**: High memory for large models
- **Services**: Ollama, model management
- **Status**: 🟢 Reachable

### Container 130 - Data & Storage
- **Purpose**: Immich, databases, data management
- **Resources**: Storage-optimized
- **Services**: Immich, PostgreSQL, Redis
- **Status**: 🔴 Unreachable

### Container 200 - Processing & Workflows
- **Purpose**: Home Assistant, n8n, automation
- **Resources**: CPU-optimized for workflows
- **Services**: Home Assistant, n8n, workflow engine
- **Status**: Planned

### Container 230 - Development & Monitoring
- **Purpose**: Code Server, Grafana, monitoring
- **Resources**: Development environment
- **Services**: VS Code Server, Grafana, Prometheus
- **Status**: Planned

## Network Configuration:
- **Management**: 100.94.114.43:8006
- **Internal Bridge**: vmbr0
- **External Network**: Tailscale integration
- **Storage**: Local ZFS + TrueNAS integration

## Next Steps:
1. Configure SSH key access for automation
2. Backup container configurations via API
3. Document storage layout
4. Setup monitoring and alerting
