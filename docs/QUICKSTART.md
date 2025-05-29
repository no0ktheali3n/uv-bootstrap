# ⚡️ Quickstart Guide — `uv-bootstrap`

Set up a portable, reproducible Python dev environment using [uv](https://github.com/astral-sh/uv), [just](https://github.com/casey/just), and PowerShell automation.

---

## 1. Install Core Tools (Windows)

### Step 1: Install [Scoop](https://scoop.sh)

No admin rights needed:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
irm get.scoop.sh | iex

#if that throws an error try irm get.scoop.sh | iex by itself
```

### Step 2:  Install git, uv, just, fzf*

```powershell
scoop install git       # necessary to clone repos
scoop install uv
scoop install just      # simplified task runner
scoop install fzf       # [Optional] Fuzzy finder for interactive command selections
```
*You can skip 'fzf' if you don't need interactive selection with 'just'

## 2. Development Environment Setup

### Step 3:  Clone Repo

```powershell
git clone https://github.com/no0ktheali3n/uv-bootstrap.git
cd uv-bootstrap
```

### Step 4: Init venv (first time only)

** in project root (uv-bootstrap/)
```powershell
uv venv
```

### Step 5: Run install script (sets up local powershell profile and generates git project files)

```powershell
powershell -ExecutionPolicy Bypass -File powershell/install.ps1
```

If justfile is copied to your project root and you installed fzf*, you can now run

```powershell
just
```
..and an interactive menu will show all just tasks

## Available Just Tasks
```powershell
just menu                   # brings up interactive fzf* menu
just compile                # Generate lockfile from requirements.in
just sync                   # Sync your venv with pinned lockfile
just upgrade                # Recompile and sync with updated deps
just init-projectfiles      # Create .gitignore, pyproject.toml, requirements.in, .env.example README.md
just init-env               # Generate .env from .env.example
just activate               # Activate the venv (PS 5 only)
just run                    # Runs the main app logic (does nothing by default, will throw error)
```
*without fzf using 'just' will throw an error without specifying task or if using "just menu"


** If you need local environment variables, generate .env from .env.example:
```powershell
just init-env               # creates .env with contents of .env.example
```

** Generate lockfile and sync environment dependencies
```powershell
just compile                # generates requirements.lock.txt
just sync                   # syncs environment with lockfile
```

### Congratulations, your uv Python environment is now setup!

** Add dependency requirements to requirements.in as necessary and run (must be compiled AND synced with any newly added requirements):
```powershell
just compile                # generates requirements.lock.txt
just sync                   # syncs environment with lockfile
```