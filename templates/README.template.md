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