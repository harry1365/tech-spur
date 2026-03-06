import os
from flask import Flask, request, jsonify
from flask_cors import CORS
from api import register_routes

app = Flask(__name__)

# Configure CORS based on environment
if os.getenv('FLASK_ENV') == 'production':
    frontend_url = os.getenv('FRONTEND_URL', '*')
    CORS(app, origins=[frontend_url])
else:
    CORS(app)  # Allow all origins in development

# Register modular routes
register_routes(app)

import awsgi

@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({"status": "ok", "message": "Architect-AI Backend is running"}), 200

def handler(event, context):
    """AWS Lambda handler for the Flask app"""
    return awsgi.response(app, event, context)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
