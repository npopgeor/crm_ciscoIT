import os
from dotenv import load_dotenv

# === Load environment variables from .env ===
load_dotenv()

# === Get the absolute path to the folder where config.py resides
BASE_DIR = os.path.abspath(os.path.dirname(__file__))

# === Environment-derived constants ===
DATABASE_PATH = os.path.join(BASE_DIR, "instance", "account_team.db")
SQLALCHEMY_DATABASE_URI = f"sqlite:///{DATABASE_PATH}"
SQLALCHEMY_TRACK_MODIFICATIONS = False

# === Derived paths and config constants ===
BACKUP_LOCAL_DIR = os.path.join(BASE_DIR, "instance", "backup")
UPLOAD_FOLDER = os.path.join(BASE_DIR, "uploads")
LOGO_UPLOAD_FOLDER = os.path.join(BASE_DIR, "static", "logos")
LOCK_FILE = "/tmp/db.lock"

# === Ensure required folders exist ===
os.makedirs(LOGO_UPLOAD_FOLDER, exist_ok=True)
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
os.makedirs(BACKUP_LOCAL_DIR, exist_ok=True)

# === Heatmap columns ===
COLUMNS = [
    "Enterprise Switching",
    "Internet Infra",
    "DC Networking",
    "Enterprise Routing",
    "Security",
    "Wireless",
    "Compute",
    "Assurance",
    "Collab",
    "IOT",
    "Meraki",
]

# === Users ===
USERS = {
    "nik": "cisco123",
    "gary": "cxrocks",
}
