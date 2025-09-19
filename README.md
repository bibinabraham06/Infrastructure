# 🏠 Infrastructure Configuration Repository

**Complete backup and version control for bibin.io home lab infrastructure**

## 🎯 **Infrastructure Overview**

### **💻 Local Systems:**
- **MacBook Pro M4** - Development workstation, MLX AI pipeline
- **Claude Desktop** - AI assistant with MCP servers
- **Local AI Models** - MLX optimized models for real-time work

### **🏠 Home Lab Network (Tailscale):**
- **Proxmox Host** - `100.94.114.43` (pve)
- **TrueNAS Storage** - Network attached storage
- **Container Infrastructure** - 120, 130, 200, 230
- **Ollama Server** - `100.75.230.110` (AI model hosting)
- **Immich** - `100.80.8.70` (photo management)
- **MediaGW** - `100.121.178.110` (media gateway)

---

## 📁 **Repository Structure**

```
Infrastructure/
├── README.md                    # This file
├── docs/                        # Documentation
│   ├── network-topology.md      # Network layout
│   ├── service-inventory.md     # All services
│   └── backup-procedures.md     # Backup strategies
├── proxmox/                     # Proxmox VE configurations
│   ├── containers/              # LXC container configs
│   ├── vms/                     # VM configurations
│   ├── networking/              # Network configs
│   └── storage/                 # Storage configurations
├── truenas/                     # TrueNAS configurations
│   ├── datasets/                # Dataset configurations
│   ├── shares/                  # SMB/NFS share configs
│   └── snapshots/               # Snapshot schedules
├── ai-models/                   # AI model configurations
│   ├── ollama/                  # Ollama server configs
│   ├── mlx/                     # Local MLX setups
│   └── model-inventory.md       # Model tracking
├── macbook/                     # MacBook configurations
│   ├── claude-desktop/          # Claude Desktop MCP configs
│   ├── development/             # Dev environment configs
│   └── ai-pipeline/             # MLX 3D pipeline configs
├── networking/                  # Network configurations
│   ├── tailscale/               # VPN configurations
│   ├── unifi/                   # UniFi network configs
│   └── firewall/                # Security configurations
├── monitoring/                  # System monitoring
│   ├── grafana/                 # Dashboard configs
│   ├── prometheus/              # Metrics collection
│   └── alerts/                  # Alert configurations
└── scripts/                     # Automation scripts
    ├── backup/                  # Backup automation
    ├── deployment/              # Deployment scripts
    └── maintenance/             # Maintenance tasks
```

---

## 🚀 **Quick Start**

### **📥 Initial Setup:**
```bash
# Clone this repository
git clone https://github.com/bibinabraham06/Infrastructure.git
cd Infrastructure

# Run infrastructure discovery
./scripts/discovery/scan-infrastructure.sh

# Generate current configurations
./scripts/backup/backup-all-configs.sh
```

### **🔄 Regular Updates:**
```bash
# Update all configurations
./scripts/update-all.sh

# Commit changes
git add . && git commit -m "Infrastructure update $(date)"
git push
```

---

## 📊 **Service Status Dashboard**

| Service | Host | Status | Purpose |
|---------|------|--------|---------|
| Proxmox | 100.94.114.43 | 🟢 Active | Virtualization host |
| TrueNAS | TBD | 🟢 Active | Network storage |
| Ollama | 100.75.230.110 | 🟡 Offline | AI model server |
| Immich | 100.80.8.70 | 🟡 Offline | Photo management |
| MediaGW | 100.121.178.110 | 🟢 Active | Media gateway |
| MLX Pipeline | Local | 🟢 Active | AI 3D generation |
| Claude Desktop | Local | 🟢 Active | AI assistant |

---

## 🔧 **Configuration Management**

### **Automated Backups:**
- **Daily**: Critical configurations
- **Weekly**: Complete system snapshots
- **Monthly**: Archive and cleanup

### **Version Control:**
- All configurations tracked in Git
- Automated commit on changes
- Rollback capabilities
- Change history tracking

### **Deployment:**
- Infrastructure as Code
- Automated deployment scripts
- Configuration validation
- Rollback procedures

---

## 📚 **Documentation**

- **🏗️ Architecture**: [docs/architecture.md](docs/architecture.md)
- **📋 Services**: [docs/service-inventory.md](docs/service-inventory.md)
- **🔧 Procedures**: [docs/procedures/](docs/procedures/)
- **🚨 Troubleshooting**: [docs/troubleshooting.md](docs/troubleshooting.md)

---

## 🎯 **Recent Updates**

### **2025-09-18 - MLX + Home Lab Integration**
- ✅ Added MLX 3D pipeline configurations
- ✅ Integrated Claude Desktop MCP servers
- ✅ Configured hybrid AI model distribution
- ✅ Enhanced Tailscale network setup

### **Next Planned Updates**
- 🔄 Ollama server restart and model sync
- 📊 Grafana monitoring dashboard
- 🤖 Home Assistant integration
- 🔒 Security configuration audit

---

## 🛠️ **Maintenance**

### **Weekly Tasks:**
- Review service status
- Update configurations
- Test backup procedures
- Security updates

### **Monthly Tasks:**
- Infrastructure audit
- Performance optimization
- Documentation updates
- Disaster recovery testing

---

## 🚨 **Emergency Procedures**

### **Service Recovery:**
1. Check service status: `./scripts/status/check-all.sh`
2. Restart services: `./scripts/recovery/restart-service.sh <service>`
3. Restore from backup: `./scripts/backup/restore-config.sh <service>`

### **Complete Infrastructure Recovery:**
1. Deploy base infrastructure: `./scripts/deployment/deploy-base.sh`
2. Restore configurations: `./scripts/backup/restore-all.sh`
3. Validate services: `./scripts/validation/validate-all.sh`

---

**🎉 This repository ensures your entire infrastructure is backed up, versioned, and recoverable!**