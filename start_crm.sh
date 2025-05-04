#!/bin/bash
set -e

echo "🧪 Starting CRM app..."

# ✅ Step 1: Make sure virtualenv exists
if [ ! -d "venv" ]; then
  echo "❌ venv folder not found. Please run install_crm.sh first."
  exit 1
fi

# ✅ Step 2: Activate virtual environment
source venv/bin/activate
echo "✅ Virtual environment activated."

# ✅ Step 3: Set Flask environment variables
export FLASK_APP=app.py
export FLASK_ENV=production

# ✅ Step 4: Load .env variables safely
if [ -f .env ]; then
  echo "📦 Loading environment variables from .env..."
  set -a
  source .env
  set +a
else
  echo "⚠️  .env file not found. Proceeding without environment overrides."
fi

# ✅ Step 5: Check that app.py exists
if [ ! -f "app.py" ]; then
  echo "❌ app.py not found. Are you in the correct folder?"
  exit 1
fi

# ✅ Step 6: Prevent duplicate background instances
if pgrep -f "python3 app.py" > /dev/null; then
  echo "⚠️  CRM app is already running. Aborting duplicate start."
  exit 1
fi

# ✅ Step 7: Start Flask app in background
echo "🚀 Starting CRM app in background..."
nohup python3 app.py > crm_log.txt 2>&1 &
sleep 2  # Give it time to initialize

# Check if Flask is listening on port 5000
if lsof -i :5000 | grep LISTEN > /dev/null; then
  echo "✅ CRM app started successfully. Visit: http://localhost:5000"
else
  echo "❌ CRM app failed to start. Check crm_log.txt for errors."
fi
