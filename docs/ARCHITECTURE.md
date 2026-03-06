# Architect-AI System Architecture

## Overview

Architect-AI uses a hybrid cloud architecture with AWS for backend services and Vercel for frontend hosting, optimizing for both performance and cost.

## Deployment Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         GitHub                               │
│                    (Source Control)                          │
└────────────┬────────────────────────────┬───────────────────┘
             │                            │
             │ Push to main               │ Push to main
             │                            │
    ┌────────▼────────┐          ┌───────▼────────┐
    │  GitHub Actions │          │ GitHub Actions  │
    │  (Backend CI/CD)│          │ (Frontend CI/CD)│
    └────────┬────────┘          └───────┬─────────┘
             │                            │
             │ Deploy                     │ Deploy
             │                            │
    ┌────────▼────────────────┐  ┌───────▼──────────┐
    │      AWS Lambda         │  │     Vercel       │
    │   (Flask Backend)       │  │  (React Frontend)│
    │                         │  │                  │
    │  - API Gateway          │  │  - Global CDN    │
    │  - Lambda Functions     │  │  - Edge Network  │
    │  - CloudWatch Logs      │  │  - Auto Scaling  │
    └────────┬────────────────┘  └──────────────────┘
             │
             │ Queries
             │
    ┌────────▼────────────────┐
    │   Amazon Bedrock        │
    │  (Claude 3.5 Sonnet)    │
    │                         │
    │  - Knowledge Bases      │
    │  - Vector Search        │
    │  - OpenSearch Serverless│
    └─────────────────────────┘
```

## Component Details

### Frontend Layer (Vercel)

**Technology**: React + Vite + Tailwind CSS

**Hosting**: Vercel Edge Network
- Global CDN distribution
- Automatic HTTPS
- Edge caching
- Zero-config deployments

**Key Features**:
- Client-side encryption (tweetnacl)
- Mermaid.js diagram rendering
- Responsive design
- Real-time streaming responses

**Build Process**:
```bash
npm install
npm run build  # Creates optimized production build
```

**Environment Variables**:
- `VITE_API_URL`: Backend API Gateway URL

### Backend Layer (AWS Lambda)

**Technology**: Flask + Python 3.11

**Hosting**: AWS Lambda + API Gateway
- Serverless compute
- Auto-scaling
- Pay-per-request pricing
- Built-in monitoring

**Key Components**:
1. **API Gateway**: RESTful API endpoints
2. **Lambda Function**: Flask application handler
3. **CloudWatch**: Logging and monitoring
4. **X-Ray**: Distributed tracing

**Deployment Process**:
```bash
sam build    # Packages application
sam deploy   # Deploys to AWS
```

**Environment Variables**:
- `AWS_REGION`: AWS region
- `BEDROCK_MODEL_ID`: Claude model identifier
- `BEDROCK_KB_ID`: Knowledge Base ID
- `FRONTEND_URL`: CORS configuration

### AI Layer (Amazon Bedrock)

**Model**: Claude 3.5 Sonnet (anthropic.claude-3-5-sonnet-20240620-v1:0)

**Components**:
1. **Knowledge Bases**: RAG pipeline
2. **OpenSearch Serverless**: Vector database
3. **S3**: Textbook storage
4. **Titan Embeddings**: Text vectorization

**Data Flow**:
```
User Query → Lambda → Knowledge Base → Vector Search → 
OpenSearch → Retrieve Context → Claude → Generate Answer → 
Lambda → API Gateway → Frontend
```

## Security Architecture

### Authentication & Authorization
- Amazon Cognito (planned)
- JWT tokens
- API Gateway authorization

### Data Protection
- **In Transit**: TLS 1.2+
- **At Rest**: AWS KMS encryption
- **Client-Side**: libsodium encryption

### Network Security
- Private S3 buckets
- VPC endpoints (optional)
- API Gateway throttling
- CORS restrictions

### IAM Policies
```yaml
Lambda Execution Role:
  - bedrock:InvokeModel
  - bedrock:RetrieveAndGenerate
  - s3:GetObject (textbook bucket only)
  - logs:CreateLogGroup
  - logs:PutLogEvents
```

## Scalability

### Frontend (Vercel)
- **Automatic**: Scales with traffic
- **Global**: Edge network distribution
- **Cost**: Free tier → $20/month (Pro)

### Backend (AWS Lambda)
- **Concurrent Executions**: 1000 (default)
- **Memory**: 512 MB (configurable)
- **Timeout**: 30 seconds (configurable)
- **Auto-scaling**: Built-in

### Database (OpenSearch Serverless)
- **OCU**: 0.5 minimum (configurable)
- **Storage**: Auto-scaling
- **Cost**: ~$24/month base

## Monitoring & Observability

### CloudWatch Metrics
- Lambda invocations
- Error rates
- Duration
- Throttles

### CloudWatch Logs
- Application logs
- API Gateway access logs
- Lambda execution logs

### X-Ray Tracing
- End-to-end request tracing
- Performance bottleneck identification
- Service map visualization

### Alarms (Recommended)
```yaml
- Lambda errors > 5% in 5 minutes
- API Gateway 5xx errors > 10 in 5 minutes
- Lambda duration > 25 seconds
- Bedrock throttling events
```

## Cost Optimization

### Current Estimates (500 users)

| Service | Usage | Monthly Cost |
|---------|-------|--------------|
| Lambda | 500k invocations, 3s avg | $2.00 |
| API Gateway | 1M requests | $1.00 |
| Bedrock | 1M input, 500k output tokens | $15.00 |
| OpenSearch | 0.5 OCU | $24.00 |
| S3 | 10GB storage, 100k requests | $0.50 |
| CloudWatch | Logs & metrics | $2.00 |
| Vercel | Pro plan | $20.00 |
| **Total** | | **~$64.50** |

### Optimization Strategies
1. **Lambda**: Use ARM architecture (Graviton2)
2. **Bedrock**: Implement response caching
3. **OpenSearch**: Use minimum OCU during off-peak
4. **S3**: Lifecycle policies for old data
5. **API Gateway**: Enable caching

## Disaster Recovery

### Backup Strategy
- **S3**: Versioning enabled
- **Code**: GitHub repository
- **Infrastructure**: SAM templates (IaC)

### Recovery Procedures
1. **Lambda**: Redeploy from SAM template
2. **Frontend**: Redeploy from Vercel
3. **Data**: Restore from S3 versions

### RTO/RPO
- **RTO**: < 1 hour (automated redeployment)
- **RPO**: < 5 minutes (S3 versioning)

## Development Workflow

```
Developer → Git Push → GitHub → Actions → Deploy

Local Development:
  - Frontend: localhost:5173
  - Backend: localhost:5000
  - Mock AI services (no AWS required)

Staging (Optional):
  - Separate AWS stack
  - Vercel preview deployments

Production:
  - Main branch auto-deploys
  - Manual approval (optional)
```

## Future Enhancements

### Phase 1 (Current)
- ✅ Basic RAG pipeline
- ✅ Visual Logic Engine
- ✅ Serverless deployment

### Phase 2 (Q3 2026)
- [ ] Multi-board support (CBSE, ICSE)
- [ ] User authentication (Cognito)
- [ ] Progress tracking
- [ ] Blockchain integration

### Phase 3 (2027)
- [ ] Multilingual support
- [ ] Offline mode (IoT Greengrass)
- [ ] Mobile applications
- [ ] Advanced analytics

## References

- [AWS Lambda Best Practices](https://docs.aws.amazon.com/lambda/latest/dg/best-practices.html)
- [Amazon Bedrock Documentation](https://docs.aws.amazon.com/bedrock/)
- [Vercel Documentation](https://vercel.com/docs)
- [React Best Practices](https://react.dev/learn)
