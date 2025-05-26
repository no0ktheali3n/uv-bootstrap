# 🧬 UV Bootstrap

A lightweight, reproducible Python development environment using [`uv`](https://github.com/astral-sh/uv) for dependency management and virtual environments.  Includes QoL profiles compatibile with Powershell 5 and 7.1+.  This setup also makes use of Just commands and will likely implement FZF in a later version. 

---

## 📁 Project Structure

\`\`\`plaintext
my-uv-project/
├── .gitignore                  # Ignore venv, lockfiles, cache
├── pyproject.toml              # Project metadata (optional)
├── requirements.in             # Top-level editable dependencies
├── .env.example                # Environment variable template
├── README.md                   # Project overview

├── powershell/                 # Shell enhancements, autoenv, profiles
│   ├── autoenv_ps5.ps1         # manual trigger script, Enable-VenvAutoActivate from project root directory (PS 5.1+ compatible)
│   ├── autoenv_ps7.ps1         # profile loader that autochecks for venv, executes venv/Scripts/activate if present. (PS7.1+)
│   └── install.ps1             #detects PowerShell version and installs appropriate autoenv as PowerShell profile.

├── templates/                  # Starter boilerplates or scaffolds
│   └── main_template.py

├── utils/                      # local Python workflow tools/scripts
│   └── justfile
\`\`\`

---

## ⚙️ Setup Instructions

1. **Clone the repo**
   \`\`\`bash
   git clone https://github.com/no0ktheali3n/dev-bootstrap.git
   cd dev-bootstrap
   \`\`\`

2. **Create the virtual environment (first time only)**
   \`\`\`bash
   uv venv
   \`\`\`

3. **Install top-level dependencies**
   \`\`\`bash
   uv pip install -r requirements.in
   \`\`\`

4. **Compile lockfile from .in**
   \`\`\`bash
   uv pip compile requirements.in > requirements.lock.txt
   \`\`\`

5. **Sync from lockfile (recommended for reproducibility), ensures environment dependencies synced**
   \`\`\`bash
   uv pip sync requirements.lock.txt
   \`\`\`


## Manual Setup Steps (now automated with \`just init-projectfiles\`)

```powershell

#Step 0 if not using GitHub GUI
mkdir my-uv-project
cd my-uv-project
# Step 1: Create .gitignore
@"

#Python
__pycache__/
.uv/
.venv/
.env
*.lock
*.pyc
*.pyo
*.pyd

#OS
.DS_Store
*.sqlite3
*.log
*.db

#IDEs
.idea/
.vscode/
"@ > .gitignore

# Step 2: Create pyproject.toml (optional, uv doesn't use it *yet*, but good future-proofing).  Currently not automated; update name and version updating with project
@"

[project]
name = "my-uv-bootstrap"
version = "0.1.0"
description = "Template Python project using uv"
authors = [{ name = "Your Name", email = "you@example.com" }]
requires-python = ">=3.10"

lockfile = "requirements.lock.txt"
"@ > pyproject.toml

# Step 3: Create requirements.in
@"
requests
python-dotenv
"@ > requirements.in

# Step 4: Create empty env file
@"

# Example env vars
API_KEY=your-api-key
DEBUG=true
"@ > .env.example

# Step 5: Create README
@"

# My UV Project

## Setup

1. Create environment (first time only):
    uv venv

2. Install dependencies:
    uv pip install -r requirements.in

3. Lock dependencies:
    uv pip compile requirements.in > requirements.lock.txt

4. Sync (reproducible install):
    uv pip sync requirements.lock.txt

"@ > README.md

```

# 🛠️ Developer Setup (Optional Utilities and QoL enhancements)

## 🧪 To enable auto-activation of `.venv` or `.uv` environments in PowerShell 5 or 7:

```powershell
irm https://raw.githubusercontent.com/no0ktheali3n/dev-bootstrap/main/powershell/install.ps1 | iex
```

or if installing locally (after clone)...
Inspect and Run
```powershell
notepad powershell\install.ps1
powershell -File powershell\install.ps1
```

..or if locally restricted or remote-signed script execution policy..
```powershell
powershell -ExecutionPolicy Bypass -File powershell\install.ps1
```



## 🧪 To enable streamlined command execution with [`just`](https://github.com/casey/just) and fuzzy task selection with [`fzf`](https://github.com/junegunn/fzf), run the following in PowerShell:


```powershell
# Install Scoop (safe, no admin required)
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
irm get.scoop.sh | iex

# Install core dev tools
scoop install git     # Required for Scoop bucket management
scoop install just    # Task runner (like make, but better)
scoop install fzf     # Fuzzy finder (for optional interactive command selection)
```

- \`justfile\` for simplified task runners: 
(\`just compile\`,\`just sync\`, \`just upgrade\`, \`just init-projectfiles\`, \`just init-env\`, \`just activate\`, \`just run\`)

-compile:            compiles lockfile from requirements.in
-sync:               syncs environment to match lockfile dependencies
-upgrade:            upgrades all dependencies and syncs environment
-init-projectfiles:  sets up .gitignore, pyproject.toml, requirements.in, example.env, README.md
-init-env:           sets up .env from example.env
-activate:           activates venv container(only necessary if using PS5.x)
-run:                syncs the environment dependencies and runs main app (doesn't run anything by default)

---

## 🔄 Workflow

### ➕ Add a new dependency
1. Append it to \`requirements.in\`  
2. Run (or use \`just compile\` then \`just sync`\):
   ```bash
   uv pip compile requirements.in > requirements.lock.txt
   uv pip sync requirements.lock.txt
   ```

### 🔼 Upgrade all dependencies (or use \`just upgrade\`)
```bash
uv pip compile --upgrade requirements.in > requirements.lock.txt
uv pip sync requirements.lock.txt
```

---

## 📦 Environment Variables

Copy the \`.env.example\` and customize (or use \`just init-env\` for this step):
```bash
cp .env.example .env
```

Use a library like \`python-dotenv\` to load them into your Python runtime.

---

## 🧠 Philosophy

This project structure emphasizes:
- Clean reproducibility
- Explicit dependency control
- Minimal tooling friction