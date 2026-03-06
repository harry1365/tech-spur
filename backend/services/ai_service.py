import json
import random

def query_bedrock(question: str, context: str) -> str:
    """Mock offline LLM Response since AWS is unavailable."""
    return f"This is an offline mock answer for your question: '{question}'. Based on the syllabus context provided: {context[:50]}..."

def generate_diagram(topic: str) -> str:
    """Mock diagram generator since AWS is unavailable."""
    return f"graph TD;\n  Start-->{topic.replace(' ', '_')};\n  {topic.replace(' ', '_')}-->End;"

