from flask import Blueprint, jsonify, request
from services.ai_service import generate_diagram, query_bedrock
from services.rag_service import query_knowledge_base

api_bp = Blueprint('api', __name__, url_prefix='/api/v1')

@api_bp.route('/query', methods=['POST'])
def handle_query():
    data = request.json
    question = data.get('question', '')
    
    # 1. Retrieve Context from RAG (Knowledge Base)
    context = query_knowledge_base(question)
    
    # 2. Query Bedrock Claude 3.5 Sonnet
    answer = query_bedrock(question, context)
    return jsonify({"answer": answer})

@api_bp.route('/diagram', methods=['POST'])
def handle_diagram():
    data = request.json
    topic = data.get('topic', '')
    
    # Generate Mermaid.js diagram
    mermaid_code = generate_diagram(topic)
    return jsonify({"mermaid_code": mermaid_code})

def register_routes(app):
    app.register_blueprint(api_bp)
