#!/bin/bash

# Infrastructure Discovery Script
# Scans and documents current infrastructure state

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Configuration
PROXMOX_HOST="100.94.114.43"
OLLAMA_HOST="100.75.230.110"
IMMICH_HOST="100.80.8.70"
MEDIAGW_HOST="100.121.178.110"

INFRASTRUCTURE_DIR="$(dirname "$(dirname "$(realpath "$0")")")"

print_header() {
    echo -e "${BLUE}"
    echo "┌─────────────────────────────────────────┐"
    echo "│       🔍 Infrastructure Discovery      │"
    echo "│     Scanning bibin.io Home Lab         │"
    echo "└─────────────────────────────────────────┘"
    echo -e "${NC}"
}

print_section() {
    echo -e "${YELLOW}$1${NC}"
    echo "================================"
}

scan_network() {
    print_section "🌐 Network Discovery"

    echo "Checking Tailscale network..."
    if command -v tailscale >/dev/null 2>&1; then
        mkdir -p "$INFRASTRUCTURE_DIR/networking/tailscale"
        tailscale status > "$INFRASTRUCTURE_DIR/networking/tailscale/current-status.txt"
        echo -e "${GREEN}✅ Tailscale status saved${NC}"
    else
        echo -e "${RED}❌ Tailscale not found${NC}"
    fi

    echo ""
    echo "Scanning home lab hosts..."

    local hosts=(
        "$PROXMOX_HOST:Proxmox"
        "$OLLAMA_HOST:Ollama"
        "$IMMICH_HOST:Immich"
        "$MEDIAGW_HOST:MediaGW"
    )

    for host_info in "${hosts[@]}"; do
        local host=$(echo "$host_info" | cut -d: -f1)
        local name=$(echo "$host_info" | cut -d: -f2)

        if ping -c 2 "$host" >/dev/null 2>&1; then
            echo -e "${GREEN}✅ $name ($host) - Reachable${NC}"
        else
            echo -e "${RED}❌ $name ($host) - Unreachable${NC}"
        fi
    done
}

scan_proxmox() {
    print_section "🖥️ Proxmox Infrastructure"

    if ping -c 2 "$PROXMOX_HOST" >/dev/null 2>&1; then
        echo "Proxmox host is reachable, attempting to gather information..."

        # Try to gather basic info via API or SSH
        cat > "$INFRASTRUCTURE_DIR/proxmox/host-info.md" << EOF
# Proxmox Host Information

**Host**: $PROXMOX_HOST
**Status**: $(ping -c 1 "$PROXMOX_HOST" >/dev/null 2>&1 && echo "🟢 Online" || echo "🔴 Offline")
**Last Scan**: $(date)

## Known Containers:
- **120**: AI Model Server (Ollama planned)
- **130**: Data & Storage (Immich, databases)
- **200**: Processing & Workflows (Home Assistant, n8n)
- **230**: Development & Monitoring (Code Server, Grafana)

## Access:
- Web UI: https://$PROXMOX_HOST:8006
- SSH: root@$PROXMOX_HOST

## Next Steps:
1. Configure SSH key access
2. Backup container configurations
3. Document storage setup
4. Setup monitoring
EOF

        echo -e "${GREEN}✅ Proxmox information documented${NC}"
    else
        echo -e "${RED}❌ Proxmox host unreachable${NC}"
    fi
}

scan_ai_services() {
    print_section "🤖 AI Services"

    # Check Ollama
    if curl -s "http://$OLLAMA_HOST:11434/api/tags" >/dev/null 2>&1; then
        echo -e "${GREEN}✅ Ollama server responding${NC}"
        curl -s "http://$OLLAMA_HOST:11434/api/tags" > "$INFRASTRUCTURE_DIR/ai-models/ollama/current-models.json"
    else
        echo -e "${YELLOW}⚠️ Ollama server not responding${NC}"
        echo "null" > "$INFRASTRUCTURE_DIR/ai-models/ollama/current-models.json"
    fi

    # Check local MLX
    cd ~/Projects/MLX 2>/dev/null && source venv/bin/activate 2>/dev/null && python3 -c "
import mlx.core as mx
import json
import os

status = {
    'mlx_version': 'unknown',
    'device_info': 'unknown',
    'status': 'working'
}

try:
    status['device_info'] = str(mx.metal.device_info())
    status['mlx_version'] = mx.__version__ if hasattr(mx, '__version__') else 'installed'
    print('✅ MLX operational')
except Exception as e:
    status['status'] = f'error: {e}'
    print(f'❌ MLX issue: {e}')

with open('$INFRASTRUCTURE_DIR/ai-models/mlx/status.json', 'w') as f:
    json.dump(status, f, indent=2)
" 2>/dev/null || echo -e "${RED}❌ MLX environment not accessible${NC}"
}

scan_storage() {
    print_section "💾 Storage Systems"

    echo "Checking TrueNAS connectivity..."
    # Note: TrueNAS IP needs to be determined
    echo "TrueNAS discovery needed - will update when accessible"

    cat > "$INFRASTRUCTURE_DIR/truenas/discovery-notes.md" << EOF
# TrueNAS Discovery Notes

**Status**: IP address needs to be determined
**Last Check**: $(date)

## Next Steps:
1. Identify TrueNAS IP address
2. Configure SMB/NFS shares access
3. Document dataset structure
4. Setup backup schedules

## Expected Features:
- Dataset management
- SMB shares for media
- NFS shares for containers
- Snapshot schedules
- Backup storage
EOF
}

scan_local_system() {
    print_section "💻 Local System (MacBook)"

    echo "Documenting local system configuration..."

    # System info
    cat > "$INFRASTRUCTURE_DIR/macbook/system-info.json" << EOF
{
    "hostname": "$(hostname)",
    "os": "$(sw_vers -productName) $(sw_vers -productVersion)",
    "architecture": "$(uname -m)",
    "uptime": "$(uptime)",
    "scan_date": "$(date -Iseconds)"
}
EOF

    # Homebrew packages
    if command -v brew >/dev/null 2>&1; then
        brew list > "$INFRASTRUCTURE_DIR/macbook/development/homebrew-packages.txt"
        echo -e "${GREEN}✅ Homebrew packages listed${NC}"
    fi

    # Python environments
    if [ -d ~/Projects/MLX/venv ]; then
        cd ~/Projects/MLX && source venv/bin/activate && pip list > "$INFRASTRUCTURE_DIR/macbook/development/python-packages.txt"
        echo -e "${GREEN}✅ Python packages listed${NC}"
    fi

    # Git repositories
    find ~/Projects -name ".git" -type d 2>/dev/null | sed 's|/.git||' > "$INFRASTRUCTURE_DIR/macbook/development/git-repositories.txt"
    echo -e "${GREEN}✅ Git repositories listed${NC}"
}

generate_summary() {
    print_section "📊 Infrastructure Summary"

    cat > "$INFRASTRUCTURE_DIR/docs/infrastructure-summary.md" << EOF
# Infrastructure Summary

**Generated**: $(date)
**Scan Version**: 1.0

## 🎯 Overview
- **Local System**: MacBook Pro M4 with MLX AI pipeline
- **Home Lab**: Proxmox-based virtualization with Tailscale networking
- **AI Services**: Hybrid local/remote model deployment
- **Storage**: TrueNAS network storage (discovery pending)

## 🌐 Network Status
$(if ping -c 1 "$PROXMOX_HOST" >/dev/null 2>&1; then echo "- **Proxmox**: 🟢 Online"; else echo "- **Proxmox**: 🔴 Offline"; fi)
$(if curl -s "http://$OLLAMA_HOST:11434/api/tags" >/dev/null 2>&1; then echo "- **Ollama**: 🟢 Online"; else echo "- **Ollama**: 🟡 Offline"; fi)
$(if ping -c 1 "$IMMICH_HOST" >/dev/null 2>&1; then echo "- **Immich**: 🟢 Online"; else echo "- **Immich**: 🔴 Offline"; fi)
$(if ping -c 1 "$MEDIAGW_HOST" >/dev/null 2>&1; then echo "- **MediaGW**: 🟢 Online"; else echo "- **MediaGW**: 🔴 Offline"; fi)

## 🤖 AI Infrastructure
- **Local MLX**: $(cd ~/Projects/MLX 2>/dev/null && source venv/bin/activate 2>/dev/null && python3 -c "import mlx.core as mx; print('🟢 Ready')" 2>/dev/null || echo "🟡 Setup needed")
- **3D Pipeline**: $([ -f ~/Projects/MLX/ai_3d_pipeline.sh ] && echo "🟢 Configured" || echo "🔴 Missing")
- **Claude Desktop**: $([ -f "/Users/bibin.io/Library/Application Support/Claude/claude_desktop_config.json" ] && echo "🟢 5 MCP servers" || echo "🔴 Not configured")

## 📝 Next Actions
1. 🔄 Restart Ollama server for AI model deployment
2. 🔍 Identify and configure TrueNAS access
3. 🔧 Setup SSH access to Proxmox for automation
4. 📊 Deploy monitoring dashboard
5. 🤖 Configure Home Assistant integration

## 📁 Repository Status
- **Configurations**: $(find "$INFRASTRUCTURE_DIR" -name "*.md" -o -name "*.json" -o -name "*.yaml" -o -name "*.txt" | wc -l) files documented
- **Scripts**: $(find "$INFRASTRUCTURE_DIR/scripts" -name "*.sh" | wc -l) automation scripts
- **Coverage**: MacBook (✅), Proxmox (partial), AI Models (✅), TrueNAS (pending)
EOF

    echo -e "${GREEN}✅ Infrastructure summary generated${NC}"
}

# Main execution
main() {
    print_header

    echo "🎯 Scanning infrastructure components..."
    echo ""

    scan_network
    echo ""
    scan_proxmox
    echo ""
    scan_ai_services
    echo ""
    scan_storage
    echo ""
    scan_local_system
    echo ""
    generate_summary

    echo ""
    echo -e "${GREEN}🎉 Infrastructure discovery complete!${NC}"
    echo "📖 View summary: $INFRASTRUCTURE_DIR/docs/infrastructure-summary.md"
    echo "📁 All data saved in: $INFRASTRUCTURE_DIR"
}

# Run main function
main