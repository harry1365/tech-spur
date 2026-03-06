# Architect-AI: The Curriculum-Locked Study Engine

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Status](https://img.shields.io/badge/status-active-success.svg)
![AWS](https://img.shields.io/badge/AWS-Powered-orange.svg)

## 🚀 Mission

**Architect-AI** is a curriculum-locked study engine specifically designed for the Indian technical education landscape (initially targeting MSBTE). Our mission is to eliminate AI hallucinations and "out-of-syllabus" noise by grounding a Large Language Model (Claude 3.5 Sonnet) directly in official board textbooks via a robust Retrieval-Augmented Generation (RAG) pipeline.

## 💡 The Problem

Students often struggle with generic AI answers that include concepts outside their specific syllabus, leading to confusion and lower exam scores. Traditional LLMs lack context about local curriculum constraints.

## ✨ Key Features

- **Syllabus-Grounded RAG**: Retrieves answers strictly from approved textbooks stored in Amazon S3, indexed via Amazon OpenSearch Serverless.
- **Smart Sprint Study Maps**: Generates personalized learning paths based on exam weightage and student progress.
- **Visual Logic Engine**: Converts complex technical text into clear, visual flowcharts using Mermaid.js, rendered in real-time on the client side.
- **Hallucination Guardrails**: Strictly limits responses to the provided source context.

## 🏗️ Architecture Overview

The system follows a scalable, serverless microservices architecture hosted on AWS.

```mermaid
graph TD
    User[Student] -->|HTTPS| CF[Amazon CloudFront]
    CF -->|Static Content| Amp[AWS Amplify Console]
    CF -->|API Requests| APIG[Amazon API Gateway]
    
    subgraph "Auth Layer"
        Cognito[Amazon Cognito]
    end
    User -.->|Auth| Cognito
    
    subgraph "Backend Tier (Serverless)"
        APIG -->|Invoke| Lambda[AWS Lambda (Python Orchestrator)]
        Lambda -->|Trace| XRay[AWS X-Ray]
        Lambda -->|Logs| CW[Amazon CloudWatch]
    end
    
    subgraph "Data & AI Layer"
        Lambda -->|Query| KB[Amazon Bedrock Knowledge Bases]
        KB -->|Vector Search| OSS[Amazon OpenSearch Serverless]
        KB -->|Retrieve Context| S3[Amazon S3 (Textbooks)]
        KB -->|Inference| Claude[Claude 3.5 Sonnet]
    end

    Lambda -->|Generate Diagram Code| VisualEngine[Visual Logic Engine]
```

## 🛠️ Technology Stack

| Component | Technology | Rationale |
|-----------|------------|-----------|
| **Frontend** | React.js, Tailwind CSS | Responsive, component-based UI |
| **Hosting** | Vercel | Global CDN, automatic deployments |
| **Auth** | Amazon Cognito | Secure user management & authentication |
| **API** | Amazon API Gateway | RESTful endpoints for backend connection |
| **Compute** | AWS Lambda (Python) | Serverless execution, cost-effective scaling |
| **AI Model** | Claude 3.5 Sonnet | High reasoning capability for technical content |
| **Vector DB** | Amazon OpenSearch Serverless | Fast semantic search for RAG context |
| **Storage** | Amazon S3 | Durable storage for textbook PDFs |
| **Observability** | CloudWatch, X-Ray | Monitoring, logging, and distributed tracing |

## 🚀 Quick Start

### Prerequisites
- Node.js 18+
- Python 3.11+
- AWS CLI configured
- AWS SAM CLI
- Vercel CLI

### Local Development

```bash
# Clone the repository
git clone https://github.com/harry1365/tech-spur.git
cd tech-spur

# Run local development environment
bash scripts/local-dev.sh
```

Frontend: http://localhost:5173  
Backend: http://localhost:5000

### Deploy to Production

**Backend (AWS Lambda):**
```bash
bash scripts/deploy-backend.sh
```

**Frontend (Vercel):**
```bash
bash scripts/deploy-frontend.sh
```

For detailed deployment instructions, see [DEPLOYMENT.md](DEPLOYMENT.md)

## 📁 Project Structure

```
architect-ai/
├── backend/              # Flask API + AWS Lambda
│   ├── api/             # API routes
│   ├── services/        # Business logic (AI, RAG, Crypto)
│   ├── app.py           # Main Flask application
│   └── requirements.txt
├── frontend/            # React + Vite
│   ├── src/
│   │   ├── components/  # React components
│   │   ├── hooks/       # Custom React hooks
│   │   └── utils/       # Utility functions
│   └── package.json
├── infrastructure/      # AWS SAM templates
│   └── template.yaml
├── blockchain/          # Smart contracts
│   └── contracts/
├── docs/               # Documentation
│   ├── DESIGN.md
│   └── API_SPEC.md
└── scripts/            # Deployment scripts
```

## 💰 Financials & Scaling

- **Development Cost**: **$0.00** (Leveraging AWS Free Tier & promotional credits).
- **Projected Production Cost**: Est. **$50.00/month** for ~500 active students.
    - *Breakdown*: OpenSearch (indexed data), Bedrock (input/output tokens), Lambda (request duration).
    - *Efficiency*: Creating a low cost-per-user ratio through serverless "pay-for-value" usage.

## 🔐 Security Features

- Client-side encryption using libsodium (tweetnacl)
- AWS KMS for data at rest
- TLS 1.2+ for data in transit
- IAM least privilege access
- Private S3 buckets
- API Gateway throttling

## 🗺️ Roadmap & Vision

1.  **Multi-Board Expansion**: Integrate CBSE and ICSE curriculums.
2.  **Multilingual Support**: Enable support for regional Indian languages (Hindi, Marathi, Tamil) to democratize technical education.
3.  **Offline Learning**: Deploy lightweight models to edge devices using **AWS IoT Greengrass** for students in low-connectivity areas.

## 📊 Monitoring

- **CloudWatch Logs**: Real-time application logs
- **X-Ray Tracing**: End-to-end request tracing
- **CloudWatch Metrics**: Performance and error monitoring

## 🤝 Contributing

We welcome contributions! Please see `CONTRIBUTING.md` for details on how to get started.

## 📜 License

This project is licensed under the MIT License - see the `LICENSE` file for details.

## 🔗 Links

- **Documentation**: [DEPLOYMENT.md](DEPLOYMENT.md)
- **API Specification**: [docs/API_SPEC.md](docs/API_SPEC.md)
- **Technical Design**: [docs/DESIGN.md](docs/DESIGN.md)
- **GitHub**: https://github.com/harry1365/tech-spur

## 📧 Support

For issues or questions, please open an issue on GitHub or contact the development team.
