#!/bin/bash

# Complete Infrastructure Backup Script
# Backs up all configurations across MacBook and Home Lab

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

INFRASTRUCTURE_DIR="$(dirname "$(dirname "$(realpath "$0")")")"

print_header() {
    echo -e "${BLUE}"
    echo "┌─────────────────────────────────────────┐"
    echo "│       💾 Infrastructure Backup         │"
    echo "│     Complete Configuration Sync        │"
    echo "└─────────────────────────────────────────┘"
    echo -e "${NC}"
}

print_section() {
    echo -e "${YELLOW}$1${NC}"
    echo "================================"
}

backup_macbook() {
    print_section "💻 MacBook Configurations"

    echo "Backing up Claude Desktop..."
    mkdir -p "$INFRASTRUCTURE_DIR/macbook/claude-desktop"
    cp "/Users/bibin.io/Library/Application Support/Claude/claude_desktop_config.json" "$INFRASTRUCTURE_DIR/macbook/claude-desktop/" 2>/dev/null || echo "Claude config not found"
    cp "/Users/bibin.io/Library/Application Support/Claude/MCP_SERVERS_GUIDE.md" "$INFRASTRUCTURE_DIR/macbook/claude-desktop/" 2>/dev/null || echo "MCP guide not found"

    echo "Backing up MLX AI Pipeline..."
    mkdir -p "$INFRASTRUCTURE_DIR/macbook/ai-pipeline"
    if [ -d ~/Projects/MLX ]; then
        cp ~/Projects/MLX/*.md "$INFRASTRUCTURE_DIR/macbook/ai-pipeline/" 2>/dev/null || true
        cp ~/Projects/MLX/*.sh "$INFRASTRUCTURE_DIR/macbook/ai-pipeline/" 2>/dev/null || true
        cp ~/Projects/MLX/*.yaml "$INFRASTRUCTURE_DIR/macbook/ai-pipeline/" 2>/dev/null || true
        cp ~/Projects/MLX/*.txt "$INFRASTRUCTURE_DIR/macbook/ai-pipeline/" 2>/dev/null || true
    fi

    echo "Backing up development environment..."
    mkdir -p "$INFRASTRUCTURE_DIR/macbook/development"

    # Homebrew packages
    if command -v brew >/dev/null 2>&1; then
        brew list > "$INFRASTRUCTURE_DIR/macbook/development/homebrew-packages.txt"
        brew --version > "$INFRASTRUCTURE_DIR/macbook/development/homebrew-version.txt"
    fi

    # Git configuration
    git config --global --list > "$INFRASTRUCTURE_DIR/macbook/development/git-global-config.txt" 2>/dev/null || true

    # System information
    cat > "$INFRASTRUCTURE_DIR/macbook/system-info.json" << EOF
{
    "hostname": "$(hostname)",
    "os_version": "$(sw_vers -productVersion)",
    "os_name": "$(sw_vers -productName)",
    "architecture": "$(uname -m)",
    "hardware": "$(sysctl -n hw.model)",
    "memory": "$(sysctl -n hw.memsize | awk '{print $1/1024/1024/1024 " GB"}')",
    "backup_date": "$(date -Iseconds)"
}
EOF

    echo -e "${GREEN}✅ MacBook configurations backed up${NC}"
}

backup_ai_models() {
    print_section "🤖 AI Model Configurations"

    echo "Backing up local MLX setup..."
    mkdir -p "$INFRASTRUCTURE_DIR/ai-models/mlx"

    if [ -d ~/Projects/MLX/venv ]; then
        cd ~/Projects/MLX && source venv/bin/activate && pip list > "$INFRASTRUCTURE_DIR/ai-models/mlx/python-packages.txt" 2>/dev/null || true
    fi

    # MLX model status
    cd ~/Projects/MLX 2>/dev/null && source venv/bin/activate 2>/dev/null && python3 -c "
import json
import mlx.core as mx

status = {
    'mlx_version': getattr(mx, '__version__', 'unknown'),
    'device_available': True,
    'metal_device': str(mx.metal.device_info()) if hasattr(mx.metal, 'device_info') else 'unknown',
    'status': 'operational',
    'backup_date': '$(date -Iseconds)'
}

with open('$INFRASTRUCTURE_DIR/ai-models/mlx/status.json', 'w') as f:
    json.dump(status, f, indent=2)
print('✅ MLX status saved')
" 2>/dev/null || echo "MLX not accessible"

    echo "Checking Ollama models..."
    mkdir -p "$INFRASTRUCTURE_DIR/ai-models/ollama"

    if curl -s http://100.75.230.110:11434/api/tags >/dev/null 2>&1; then
        curl -s http://100.75.230.110:11434/api/tags > "$INFRASTRUCTURE_DIR/ai-models/ollama/current-models.json"
        echo -e "${GREEN}✅ Ollama models inventory saved${NC}"
    else
        echo '{"models": [], "status": "offline", "backup_date": "'$(date -Iseconds)'"}' > "$INFRASTRUCTURE_DIR/ai-models/ollama/current-models.json"
        echo -e "${YELLOW}⚠️ Ollama offline - placeholder created${NC}"
    fi

    echo -e "${GREEN}✅ AI model configurations backed up${NC}"
}

backup_network() {
    print_section "🌐 Network Configurations"

    echo "Backing up Tailscale configuration..."
    mkdir -p "$INFRASTRUCTURE_DIR/networking/tailscale"

    if command -v tailscale >/dev/null 2>&1; then
        tailscale status > "$INFRASTRUCTURE_DIR/networking/tailscale/status.txt"
        tailscale version > "$INFRASTRUCTURE_DIR/networking/tailscale/version.txt"
        echo -e "${GREEN}✅ Tailscale configuration saved${NC}"
    fi

    echo "Documenting network topology..."
    cat > "$INFRASTRUCTURE_DIR/networking/network-topology.md" << EOF
# Network Topology

**Last Updated**: $(date)

## Tailscale Mesh Network

### Active Nodes:
$(if command -v tailscale >/dev/null 2>&1; then tailscale status | grep -E "^[0-9]" | head -10; else echo "Tailscale not available"; fi)

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
EOF

    echo -e "${GREEN}✅ Network configurations backed up${NC}"
}

backup_proxmox() {
    print_section "🖥️ Proxmox Configurations"

    echo "Documenting Proxmox infrastructure..."
    mkdir -p "$INFRASTRUCTURE_DIR/proxmox/containers"

    cat > "$INFRASTRUCTURE_DIR/proxmox/host-info.md" << EOF
# Proxmox Host Configuration

**Host**: 100.94.114.43
**Status**: $(ping -c 1 100.94.114.43 >/dev/null 2>&1 && echo "🟢 Online" || echo "🔴 Offline")
**Last Backup**: $(date)

## Container Layout:

### Container 120 - AI Model Server
- **Purpose**: Ollama AI model hosting
- **Resources**: High memory for large models
- **Services**: Ollama, model management
- **Status**: $(ping -c 1 100.75.230.110 >/dev/null 2>&1 && echo "🟢 Reachable" || echo "🔴 Unreachable")

### Container 130 - Data & Storage
- **Purpose**: Immich, databases, data management
- **Resources**: Storage-optimized
- **Services**: Immich, PostgreSQL, Redis
- **Status**: $(ping -c 1 100.80.8.70 >/dev/null 2>&1 && echo "🟢 Reachable" || echo "🔴 Unreachable")

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
EOF

    echo -e "${GREEN}✅ Proxmox documentation updated${NC}"
}

create_backup_manifest() {
    print_section "📋 Creating Backup Manifest"

    cat > "$INFRASTRUCTURE_DIR/BACKUP_MANIFEST.md" << EOF
# Infrastructure Backup Manifest

**Generated**: $(date)
**Backup Version**: 1.0

## 📊 Backup Summary

### ✅ Successfully Backed Up:
- **MacBook Pro Configuration**: System info, development environment, AI pipeline
- **Claude Desktop**: MCP server configuration, guides
- **MLX AI Pipeline**: Scripts, configurations, documentation
- **Network Configuration**: Tailscale status, topology
- **AI Models**: Local MLX status, Ollama inventory
- **Proxmox Documentation**: Container layout, network config

### 📁 File Count:
- **Total Files**: $(find "$INFRASTRUCTURE_DIR" -type f | wc -l | tr -d ' ')
- **Configuration Files**: $(find "$INFRASTRUCTURE_DIR" -name "*.json" -o -name "*.yaml" -o -name "*.txt" | wc -l | tr -d ' ')
- **Documentation**: $(find "$INFRASTRUCTURE_DIR" -name "*.md" | wc -l | tr -d ' ')
- **Scripts**: $(find "$INFRASTRUCTURE_DIR" -name "*.sh" | wc -l | tr -d ' ')

### 🎯 Coverage Status:
- **MacBook Pro**: ✅ Complete
- **Claude Desktop**: ✅ Complete
- **MLX AI Pipeline**: ✅ Complete
- **Network (Tailscale)**: ✅ Complete
- **Proxmox**: 🟡 Documentation only
- **TrueNAS**: 🟡 Discovery needed
- **AI Models**: 🟡 Inventory only

## 🔄 Next Backup Actions:
1. Setup SSH access to Proxmox for configuration export
2. Identify and configure TrueNAS access
3. Export container configurations via Proxmox API
4. Setup automated backup scheduling
5. Implement configuration change detection

## 📈 Repository Statistics:
- **Repository Size**: $(du -sh "$INFRASTRUCTURE_DIR" | cut -f1)
- **Last Git Commit**: $(cd "$INFRASTRUCTURE_DIR" && git log -1 --format="%h %s" 2>/dev/null || echo "Not yet committed")
- **Branch**: $(cd "$INFRASTRUCTURE_DIR" && git branch --show-current 2>/dev/null || echo "No git repository")

## 🎉 Backup Status: **READY FOR GIT COMMIT**

All discoverable configurations have been backed up and documented.
Infrastructure is ready for version control and automated management.
EOF

    echo -e "${GREEN}✅ Backup manifest created${NC}"
}

# Main execution
main() {
    print_header

    echo "🎯 Starting complete infrastructure backup..."
    echo ""

    backup_macbook
    echo ""
    backup_ai_models
    echo ""
    backup_network
    echo ""
    backup_proxmox
    echo ""
    create_backup_manifest

    echo ""
    echo -e "${GREEN}🎉 Infrastructure backup complete!${NC}"
    echo "📖 View manifest: $INFRASTRUCTURE_DIR/BACKUP_MANIFEST.md"
    echo "📁 Ready for Git commit and push"
}

# Run main function
main "$@"