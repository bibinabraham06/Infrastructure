# 🔌 Claude Desktop MCP Servers Guide

**Complete setup for enhanced Claude Desktop capabilities**

## 🎯 **What You Now Have**

Your Claude Desktop is now connected to **5 powerful MCP servers** that dramatically expand Claude's capabilities:

### **✅ Active MCP Servers:**

1. **🎨 Blender MCP** - 3D modeling and rendering
2. **📁 Filesystem MCP** - Advanced file operations
3. **🔧 Git MCP** - Repository management
4. **🐳 Docker MCP** - Container management
5. **🗄️ SQLite MCP** - Database operations

---

## 📋 **Server Details & Capabilities**

### **1. 🎨 Blender MCP**
**Command:** `uvx blender-mcp`
**Purpose:** AI-powered 3D modeling

**What it does:**
- Create 3D objects from text descriptions
- Apply textures and materials automatically
- Set up lighting and camera angles
- Render scenes and animations
- Export models for 3D printing

**Example use:** *"Create a medieval castle model with stone textures"*

---

### **2. 📁 Filesystem MCP**
**Command:** `npx @modelcontextprotocol/server-filesystem`
**Scope:** `/Users/bibin.io` (your entire home directory)

**What it does:**
- Read, write, and edit any file in your system
- Navigate directory structures
- Search for files and content
- Create, move, copy, and delete files
- Monitor file changes

**Example use:** *"Find all Python files containing 'machine learning' in my Projects folder"*

---

### **3. 🔧 Git MCP**
**Command:** `uvx mcp-server-git`
**Scope:** `/Users/bibin.io/Projects` (all your git repositories)

**What it does:**
- Check repository status and history
- Create commits with meaningful messages
- Manage branches and merges
- Handle pull requests and issues
- Analyze code changes and diffs

**Example use:** *"Create a new branch, implement the user authentication feature, and commit the changes"*

---

### **4. 🐳 Docker MCP**
**Command:** `uvx docker-mcp`

**What it does:**
- Manage Docker containers and images
- Start, stop, and monitor containers
- Build images from Dockerfiles
- Handle volumes and networks
- View logs and container statistics

**Example use:** *"Start a PostgreSQL container and connect my app to it"*

---

### **5. 🗄️ SQLite MCP**
**Command:** `uvx mcp-server-sqlite`
**Database location:** `/Users/bibin.io/databases`

**What it does:**
- Create and manage SQLite databases
- Execute SQL queries and commands
- Design database schemas
- Import/export data
- Analyze database performance

**Example use:** *"Create a database for my project tracking app with tables for projects, tasks, and users"*

---

## 🚀 **Real-World Usage Examples**

### **🎯 Development Workflow:**
```
You: "Set up a new Python project with Docker, create a git repo,
     and design a database schema for a task manager"

Claude can now:
1. Use Filesystem MCP to create project structure
2. Use Git MCP to initialize repository
3. Use Docker MCP to create development environment
4. Use SQLite MCP to design database schema
5. Use Blender MCP to create 3D assets if needed
```

### **🏠 Home Lab Integration:**
```
You: "Help me organize my home lab documentation and
     create 3D diagrams of my server rack"

Claude can now:
1. Use Filesystem MCP to organize documentation
2. Use Git MCP to version control configs
3. Use Docker MCP to manage containers
4. Use Blender MCP to create 3D rack diagrams
5. Use SQLite MCP to track hardware inventory
```

### **🎨 Creative Projects:**
```
You: "Build a web app that generates 3D models from user descriptions"

Claude can now:
1. Use Filesystem MCP to create app structure
2. Use Git MCP to manage source code
3. Use Docker MCP to containerize the app
4. Use Blender MCP to generate 3D models
5. Use SQLite MCP to store user projects
```

---

## 🔧 **Configuration Details**

**Current config location:**
`/Users/bibin.io/Library/Application Support/Claude/claude_desktop_config.json`

**Configuration:**
```json
{
  "mcpServers": {
    "blender": {
      "command": "uvx",
      "args": ["blender-mcp"]
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/Users/bibin.io"]
    },
    "git": {
      "command": "uvx",
      "args": ["mcp-server-git", "--repository", "/Users/bibin.io/Projects"]
    },
    "docker": {
      "command": "uvx",
      "args": ["docker-mcp"]
    },
    "sqlite": {
      "command": "uvx",
      "args": ["mcp-server-sqlite", "--db-path", "/Users/bibin.io/databases"]
    }
  }
}
```

---

## 🎛️ **How to Use MCP Servers**

### **In Claude Desktop:**

1. **Direct commands:**
   - *"Create a file called notes.txt with today's tasks"* (Filesystem)
   - *"Show me the git status of my MLX project"* (Git)
   - *"List all running Docker containers"* (Docker)

2. **Complex workflows:**
   - *"Help me deploy my app: containerize it, commit changes, and create deployment docs"*

3. **Creative tasks:**
   - *"Design a 3D logo for my company and save it as both a Blender file and STL"*

### **Pro Tips:**
- **Be specific** about which server capability you need
- **Combine servers** for complex workflows
- **Ask for explanations** when Claude uses MCP tools
- **Reference file paths** relative to the configured directories

---

## 🔍 **Troubleshooting**

### **If MCP servers don't work:**

1. **Restart Claude Desktop** after configuration changes
2. **Check dependencies:**
   ```bash
   # Check if uvx is working
   uvx --version

   # Check if npx is working
   npx --version

   # Test individual servers
   uvx mcp-server-git --help
   ```

3. **Verify paths exist:**
   ```bash
   ls -la "/Users/bibin.io/Projects"
   ls -la "/Users/bibin.io/databases"
   ```

4. **Check Docker is running:**
   ```bash
   docker ps
   ```

### **Common Issues:**
- **Permission errors**: Ensure directories are accessible
- **Command not found**: Install missing dependencies
- **Blender MCP issues**: Make sure Blender app is running and addon is enabled

---

## 📈 **What's Next**

### **Potential Additional MCP Servers:**
- **GitHub MCP** - Direct GitHub API integration
- **Slack/Discord MCP** - Team communication
- **Calendar MCP** - Schedule management
- **Email MCP** - Email automation
- **Home Assistant MCP** - Smart home control

### **Advanced Integrations:**
- Connect MCP servers to your home lab
- Set up automated workflows
- Create custom MCP servers for specific needs
- Integrate with your existing tools and services

---

## 🎉 **Summary**

You now have a **supercharged Claude Desktop** with capabilities far beyond basic text generation:

✅ **File system mastery** - Complete control over your files
✅ **Development workflows** - Git, Docker, and database management
✅ **3D creation** - AI-powered Blender integration
✅ **Data management** - SQLite database operations

**Your AI assistant can now truly help with complex, real-world tasks across your entire development and creative workflow!**

---

*🔧 Need to add more servers or modify configurations? Edit the config file and restart Claude Desktop.*