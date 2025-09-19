# 🤖 AI Model Inventory

**Complete tracking of AI models across MacBook and Home Lab**

## 📊 **Model Distribution Strategy**

### **🖥️ Local MLX Models (MacBook Pro M4)**

**Current Status**: ✅ Environment Ready, Models Download on Demand

**Recommended Models:**
| Model | Size | Purpose | Status | Location |
|-------|------|---------|--------|----------|
| Meta-Llama-3.1-8B-Instruct-4bit | ~4GB | Coding assistance | 🔄 Auto-download | `~/.cache/huggingface/` |
| stable-diffusion-xl-base-1.0-4bit | ~3GB | Texture generation | 🔄 Auto-download | `~/.cache/huggingface/` |
| CodeLlama-7B-Instruct-4bit | ~4GB | Real-time coding | 🔄 Auto-download | `~/.cache/huggingface/` |
| depth-anything-v2-small | ~1GB | Depth estimation | 🔄 Auto-download | `~/.cache/huggingface/` |

**Usage Patterns:**
- ⚡ **Real-time 3D pipeline** (< 5 second response)
- 🎨 **Interactive texture generation**
- 💻 **Live coding assistance**
- 🔍 **Immediate depth map generation**

---

### **🏠 Home Lab Models (Ollama Server: 100.75.230.110)**

**Current Status**: 🟡 Server Offline - Needs Restart

**Target Models:**
| Model | Size | Purpose | Status | Download Command |
|-------|------|---------|--------|------------------|
| llama3.1:70b | ~40GB | Complex reasoning | ⏳ Pending | `ollama pull llama3.1:70b` |
| codellama:34b | ~20GB | Advanced coding | ⏳ Pending | `ollama pull codellama:34b` |
| qwen2.5:72b | ~40GB | Multimodal tasks | ⏳ Pending | `ollama pull qwen2.5:72b` |
| mistral:7b | ~4GB | Fast responses | ⏳ Pending | `ollama pull mistral:7b` |
| llama3.1:8b | ~4GB | General purpose | ⏳ Pending | `ollama pull llama3.1:8b` |

**Usage Patterns:**
- 🧠 **Complex reasoning tasks**
- 📚 **Large-scale code generation**
- 🔄 **Batch processing workflows**
- 🏠 **Home automation intelligence**

---

## 🔧 **Model Management**

### **Local MLX Management:**
```bash
# Check MLX installation
cd ~/Projects/MLX && source venv/bin/activate
python -c "import mlx.core as mx; print('MLX Ready')"

# List cached models
ls -la ~/.cache/huggingface/transformers/

# Clear model cache (if needed)
rm -rf ~/.cache/huggingface/transformers/
```

### **Home Lab Model Management:**
```bash
# Check Ollama server status
curl http://100.75.230.110:11434/api/tags

# Download essential models
ollama pull llama3.1:8b
ollama pull mistral:7b
ollama pull codellama:7b

# List installed models
ollama list

# Remove model (if needed)
ollama rm model_name
```

---

## 📈 **Performance Metrics**

### **Local MLX Performance (M4 Chip):**
- **Texture Generation**: 3-8 seconds (512x512)
- **Code Completion**: < 1 second
- **Depth Map Generation**: 2-5 seconds
- **Memory Usage**: 4-8GB RAM per model

### **Home Lab Performance (Expected):**
- **Large Model Inference**: 10-30 seconds
- **Batch Processing**: Parallel execution
- **Memory Usage**: 16-64GB RAM for large models
- **Concurrent Users**: Multiple simultaneous requests

---

## 🔄 **Hybrid Workflow Examples**

### **3D Creation Pipeline:**
```
1. Local MLX: Generate texture (3 sec)
2. Local MLX: Create depth map (3 sec)
3. Local Blender: Apply to 3D model (instant)
4. Home Lab: Enhance with large model (30 sec)
5. Local Blender: Final render (varies)
```

### **Development Workflow:**
```
1. Local MLX: Quick code suggestions (< 1 sec)
2. Home Lab: Complex architecture design (30 sec)
3. Local MLX: Real-time debugging (< 1 sec)
4. Home Lab: Code review and optimization (60 sec)
```

---

## 🎯 **Optimization Strategies**

### **Model Caching:**
- **Local**: Keep frequently used models in memory
- **Home Lab**: Implement model loading queue
- **Network**: Cache model outputs for repeated queries

### **Load Balancing:**
- **Real-time tasks**: Always use local MLX
- **Complex tasks**: Route to home lab
- **Fallback**: Local MLX if home lab unavailable

### **Storage Optimization:**
- **Local**: 32GB allocated for model cache
- **Home Lab**: Dedicated model storage volume
- **Backup**: Critical model configurations versioned

---

## 📊 **Model Update Schedule**

### **Weekly:**
- Check for model updates
- Update local MLX models if needed
- Verify home lab model integrity

### **Monthly:**
- Evaluate new model releases
- Performance benchmarking
- Storage usage optimization

### **Quarterly:**
- Model architecture review
- Infrastructure scaling assessment
- Backup and recovery testing

---

## 🚨 **Troubleshooting**

### **Local MLX Issues:**
```bash
# Reinstall MLX
pip install --upgrade mlx mlx-lm

# Clear model cache
rm -rf ~/.cache/huggingface/

# Check M4 optimization
python -c "import mlx.core as mx; print(mx.metal.device_info())"
```

### **Home Lab Connectivity:**
```bash
# Check network
ping 100.75.230.110

# Test Ollama
curl http://100.75.230.110:11434/api/tags

# Restart service (if accessible)
ssh root@100.75.230.110 "systemctl restart ollama"
```

---

## 📝 **Configuration Files**

- **MLX Config**: `~/Projects/MLX/hybrid_config.yaml`
- **Ollama Config**: `/etc/ollama/config.json` (on home lab)
- **Model Cache**: `~/.cache/huggingface/transformers/`
- **Usage Logs**: `~/Infrastructure/logs/model-usage.log`

---

**🎯 Total Model Storage:**
- **Local MLX**: ~20GB (active models)
- **Home Lab**: ~200GB (planned full deployment)
- **Network Traffic**: Optimized for 10Gbps Tailscale mesh

**Status**: Infrastructure ready, awaiting home lab Ollama restart for full deployment.