# Architect-AI: Project Summary

## What is Architect-AI?

Architect-AI is a curriculum-locked AI study assistant designed specifically for Indian technical education (MSBTE, CBSE, ICSE). It uses Amazon Bedrock's Claude 3.5 Sonnet with a Retrieval-Augmented Generation (RAG) pipeline to provide accurate, syllabus-specific answers grounded in official textbooks.

## Key Innovation

Unlike generic AI chatbots, Architect-AI:
- ✅ Only answers from approved curriculum materials
- ✅ Eliminates hallucinations and out-of-syllabus content
- ✅ Generates visual diagrams for complex concepts
- ✅ Provides personalized study roadmaps

## Technology Stack

### Frontend
- **Framework**: React 18 + Vite
- **Styling**: Tailwind CSS
- **Deployment**: Vercel (Global CDN)
- **Features**: Mermaid.js diagrams, client-side encryption

### Backend
- **Framework**: Flask (Python 3.11)
- **Deployment**: AWS Lambda + API Gateway
- **AI**: Amazon Bedrock (Claude 3.5 Sonnet)
- **Vector DB**: Amazon OpenSearch Serverless
- **Storage**: Amazon S3

### Infrastructure
- **IaC**: AWS SAM (Serverless Application Model)
- **CI/CD**: GitHub Actions
- **Monitoring**: CloudWatch + X-Ray
- **Security**: AWS KMS, TLS 1.2+, libsodium

## Project Structure

```
architect-ai/
├── backend/              # Flask API (AWS Lambda)
│   ├── api/             # API routes
│   ├── services/        # AI, RAG, Crypto services
│   └── app.py           # Main application
├── frontend/            # React application (Vercel)
│   ├── src/
│   │   ├── components/  # UI components
│   │   ├── hooks/       # React hooks
│   │   └── utils/       # Utilities
│   └── package.json
├── infrastructure/      # AWS SAM templates
│   └── template.yaml    # CloudFormation template
├── blockchain/          # Smart contracts (future)
├── docs/               # Documentation
│   ├── DESIGN.md       # Technical design
│   ├── API_SPEC.md     # API documentation
│   ├── ARCHITECTURE.md # System architecture
│   └── GITHUB_SETUP.md # GitHub configuration
├── scripts/            # Deployment scripts
│   ├── deploy-backend.sh/.bat
│   ├── deploy-frontend.sh/.bat
│   └── local-dev.sh/.bat
└── .github/workflows/  # CI/CD pipelines
    ├── deploy-backend.yml
    └── deploy-frontend.yml
```

## Deployment Architecture

```
GitHub → GitHub Actions → AWS Lambda (Backend)
                       → Vercel (Frontend)

User → Vercel CDN → React App → API Gateway → Lambda → Bedrock
```

## Cost Structure

### Development: $0/month
- AWS Free Tier
- Vercel Free Tier
- Bedrock promotional credits

### Production (500 users): ~$65/month
- Lambda: $2
- API Gateway: $1
- Bedrock: $15
- OpenSearch: $24
- S3: $0.50
- CloudWatch: $2
- Vercel Pro: $20

**Cost per user**: ~$0.13/month

## Getting Started

### Quick Start (Local Development)
```bash
# Clone repository
git clone https://github.com/harry1365/tech-spur.git
cd tech-spur

# Windows
start.bat

# Linux/Mac
bash scripts/local-dev.sh
```

### Deploy to Production
```bash
# Backend (AWS)
bash scripts/deploy-backend.sh

# Frontend (Vercel)
bash scripts/deploy-frontend.sh
```

See [DEPLOYMENT.md](DEPLOYMENT.md) for detailed instructions.

## Key Features

### 1. Curriculum-Locked RAG
- Textbooks stored in S3
- Vector embeddings in OpenSearch
- Semantic search for relevant context
- Claude generates answers from context only

### 2. Visual Logic Engine
- Converts text to Mermaid.js diagrams
- Flowcharts, sequence diagrams, class diagrams
- Real-time rendering in browser
- Interactive and exportable

### 3. Smart Sprint Study Maps
- Personalized learning paths
- Based on exam weightage
- Progress tracking
- Adaptive recommendations

### 4. Zero-Knowledge Privacy
- Client-side encryption (libsodium)
- Personal notes never visible to AI
- AWS KMS for data at rest
- TLS for data in transit

## Security Features

- ✅ Client-side encryption (tweetnacl)
- ✅ AWS KMS encryption at rest
- ✅ TLS 1.2+ in transit
- ✅ IAM least privilege
- ✅ Private S3 buckets
- ✅ API Gateway throttling
- ✅ CORS restrictions
- ✅ No hardcoded credentials

## Monitoring & Observability

- **CloudWatch Logs**: Application logs
- **CloudWatch Metrics**: Performance metrics
- **X-Ray Tracing**: Request tracing
- **Alarms**: Error rate, latency, throttling

## Documentation

- [README.md](README.md) - Project overview
- [QUICKSTART.md](QUICKSTART.md) - 5-minute setup
- [DEPLOYMENT.md](DEPLOYMENT.md) - Full deployment guide
- [DEPLOYMENT_CHECKLIST.md](DEPLOYMENT_CHECKLIST.md) - Step-by-step checklist
- [CONTRIBUTING.md](CONTRIBUTING.md) - Contribution guidelines
- [docs/DESIGN.md](docs/DESIGN.md) - Technical design document
- [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) - System architecture
- [docs/API_SPEC.md](docs/API_SPEC.md) - API specification
- [docs/GITHUB_SETUP.md](docs/GITHUB_SETUP.md) - GitHub configuration

## Roadmap

### Phase 1: Foundation (Current)
- ✅ RAG pipeline implementation
- ✅ Visual Logic Engine
- ✅ Serverless deployment
- ✅ CI/CD pipelines

### Phase 2: Expansion (Q3 2026)
- [ ] Multi-board support (CBSE, ICSE)
- [ ] User authentication (Cognito)
- [ ] Progress tracking
- [ ] Blockchain integration

### Phase 3: Scale (2027)
- [ ] Multilingual support (Hindi, Marathi, Tamil)
- [ ] Offline mode (IoT Greengrass)
- [ ] Mobile applications
- [ ] Advanced analytics

## Success Metrics

- **Performance**: API response < 3s
- **Accuracy**: 95%+ curriculum-aligned answers
- **Availability**: 99.9% uptime
- **Cost**: < $0.15 per user per month
- **Scalability**: Support 10,000+ concurrent users

## Team & Contact

- **Repository**: https://github.com/harry1365/tech-spur
- **Issues**: https://github.com/harry1365/tech-spur/issues
- **License**: MIT

## Quick Links

- [Get Started](QUICKSTART.md)
- [Deploy to Production](DEPLOYMENT.md)
- [Deployment Checklist](DEPLOYMENT_CHECKLIST.md)
- [GitHub Setup](docs/GITHUB_SETUP.md)
- [Architecture Details](docs/ARCHITECTURE.md)
- [Contribute](CONTRIBUTING.md)

---

**Status**: ✅ Production Ready

**Last Updated**: 2026-03-06

**Version**: 1.0.0
