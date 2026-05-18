# Sample Twilio settings are loaded from environment variables.
# Do not commit actual credentials to source control.

import os
from pathlib import Path
from flask import Flask, request, jsonify
from twilio.rest import Client
from flask_cors import CORS
import random


def load_dotenv(dotenv_path=None):
    if dotenv_path is None:
        base_dir = Path(__file__).resolve().parent
        dotenv_path = base_dir / ".env"
        if not dotenv_path.exists():
            cwd = Path.cwd()
            for parent in [cwd] + list(cwd.parents):
                candidate = parent / ".env"
                if candidate.exists():
                    dotenv_path = candidate
                    break

    if dotenv_path and dotenv_path.exists():
        for line in dotenv_path.read_text().splitlines():
            line = line.strip()
            if not line or line.startswith("#") or "=" not in line:
                continue
            key, value = line.split("=", 1)
            if key not in os.environ:
                os.environ[key] = value.strip().strip('"').strip("'")


load_dotenv()

app = Flask(__name__)
CORS(app)  # Allows Flutter to call this API

# Twilio Credentials (Keep Secure)
ACCOUNT_SID = os.getenv("TWILIO_ACCOUNT_SID")
AUTH_TOKEN = os.getenv("TWILIO_AUTH_TOKEN")
TWILIO_WHATSAPP_NUMBER = os.getenv("TWILIO_WHATSAPP_NUMBER")

# Store OTPs temporarily
otp_store = {}

def generate_otp():
    return str(random.randint(1000, 9999))  # Generates a 4-digit OTP

def format_phone_number(phone_number):
    if not phone_number.startswith("+91"):
        return f"+91{phone_number}"
    return phone_number

@app.route("/send_otp", methods=["POST"])
def send_otp():
    data = request.json
    phone_number = data.get("phone")

    if not phone_number:
        return jsonify({"error": "Phone number is required"}), 400

    phone_number = format_phone_number(phone_number)  # Ensure proper format
    otp = generate_otp()
    otp_store[phone_number] = otp  # Store OTP temporarily

    print(f"Generated OTP for {phone_number}: {otp}")  # 🔐 PRINT OTP TO CONSOLE

    # Send OTP via WhatsApp using Twilio
    client = Client(ACCOUNT_SID, AUTH_TOKEN)
    message = client.messages.create(
        from_=TWILIO_WHATSAPP_NUMBER,
        to=f"whatsapp:{phone_number}",
        body=f"Your OTP code is: {otp}"
    )

    return jsonify({"success": True, "message_sid": message.sid, "otp": otp})

@app.route("/verify_otp", methods=["POST"])
def verify_otp():
    data = request.json
    phone_number = data.get("phone")
    user_otp = data.get("otp")

    if not phone_number or not user_otp:
        return jsonify({"error": "Phone number and OTP are required"}), 400

    phone_number = format_phone_number(phone_number)  # Ensure proper format
    
    if phone_number in otp_store and otp_store[phone_number] == user_otp:
        return jsonify({"success": True, "message": "OTP Verified!"})
    else:
        return jsonify({"success": False, "message": "Invalid OTP!"}), 400

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001, debug=True)

