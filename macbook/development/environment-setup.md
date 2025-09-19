# MacBook Pro M4 Development Environment

## 🖥️ **System Information**
- **Model**: MacBook Pro M4
- **OS**: macOS Sequoia
- **Architecture**: Apple Silicon (ARM64)
- **Primary Use**: AI/ML development, 3D pipeline, Creative work

## 🛠️ **Development Tools**

### **Core Tools:**
- **Homebrew**: Package manager
- **Git**: Version control (2.51.0)
- **Python**: 3.13.7 (via Homebrew)
- **Node.js**: Latest LTS
- **uvx**: Python application runner

### **AI/ML Stack:**
- **MLX**: Apple's ML framework for M-series chips
- **PyTorch**: With Metal Performance Shaders (MPS)
- **Stable Diffusion**: Text-to-image generation
- **Transformers**: HuggingFace model library

### **3D/Creative Tools:**
- **Blender**: 3D modeling and rendering
- **Blender MCP**: AI integration for automated 3D workflows

### **AI Assistant:**
- **Claude Desktop**: With 5 MCP servers configured
  - Blender MCP (3D modeling)
  - Filesystem MCP (file operations)
  - Git MCP (repository management)
  - Docker MCP (container management)
  - SQLite MCP (database operations)

## 📁 **Project Structure**
```
~/Projects/
├── MLX/                         # AI-powered 3D pipeline
│   ├── ai_3d_pipeline.sh        # Main pipeline launcher
│   ├── blender_mlx_bridge.py    # Blender integration
│   ├── setup_home_lab_models.sh # Model setup script
│   └── venv/                    # Python virtual environment
└── Infrastructure/              # This repository
```

## 🌐 **Network Configuration**
- **Tailscale**: VPN for home lab connectivity
- **Local IP**: Dynamic (WiFi)
- **Tailscale IP**: 100.116.44.26
- **Home Lab Access**: Secured via Tailscale mesh network

## 🎯 **Key Capabilities**
- **Real-time AI**: MLX-optimized models for interactive work
- **3D Pipeline**: Text → Texture → 3D Model → Render
- **Home Lab Integration**: Hybrid local/remote AI processing
- **Version Control**: All configurations tracked in Git
- **Automation**: Scripted workflows for common tasks

## 🔧 **Configuration Files**
- **Claude Desktop**: `/Users/bibin.io/Library/Application Support/Claude/`
- **MLX Models**: Cached in `~/.cache/huggingface/`
- **Virtual Environments**: `~/Projects/MLX/venv/`
- **Git Configuration**: Global user settings configured

## 🚀 **Quick Commands**
```bash
# Activate MLX environment
cd ~/Projects/MLX && source venv/bin/activate

# Generate 3D model
./ai_3d_pipeline.sh full "ancient stone wall" --object cube

# Check home lab connectivity
tailscale status

# Update infrastructure configs
cd ~/Infrastructure && ./scripts/backup/backup-macbook.sh
```