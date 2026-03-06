# Architect-AI: Technical Design Document (TDD)

**Version:** 1.0  
**Date:** 2026-02-15  
**Author:** Antigravity (Senior Cloud Architect)  
**Status:** Draft

---

## 1. Executive Summary

**Architect-AI** is a cloud-native, serverless educational platform designed to provide curriculum-locked, hallucination-free study assistance to technical students in India (starting with MSBTE). By leveraging AWS's generative AI capabilities, specifically Amazon Bedrock and Claude 3.5 Sonnet, the platform grounds all responses in official textbook material via a Retrieval-Augmented Generation (RAG) pipeline. This document outlines the technical architecture, component design, security posture, and financial model for the system.

## 2. System Architecture

The solution utilizes a microservices-based serverless architecture to ensure high scalability, low operational overhead, and cost efficiency.

### 2.1 High-Level Architecture Diagram


graph TD
    subgraph User_Space [Frontend - React + Libsodium]
        A[Student Uploads PDF/Query] -->|Encrypt Sensitive Data| B(Local Encryption)
        B --> C{API Gateway}
    end

    subgraph AWS_Cloud [Backend - AWS Bedrock & Lambda]
        C --> D[AWS Lambda]
        D --> E[S3 Bucket - PDF Storage]
        E --> F[Amazon Titan - Embedding Engine]
        F --> G[(Vector DB - ChromaDB)]
        G --> H[Amazon Bedrock - Claude 3.5 Sonnet]
    end

    subgraph Trust_Layer [Decentralized Layer]
        H --> I[Generate Proof of Learning]
        I --> J[[Antigravity L1 Blockchain]]
    end

    H -->|Syllabus-Specific Answer| A
    

Data Ingestion: We use pypdf within an AWS Lambda function to extract text from MSBTE syllabi. The text is chunked into 500-token segments with a 50-token overlap to maintain context.

Vector Search: We use Amazon Titan Text Embeddings to convert text into 1536-dimensional vectors. When a student asks a question, we perform a cosine similarity search against the Vector DB to find the exact syllabus constraints.

Security (Zero-Knowledge): Personal project notes are encrypted using libsodium’s secretbox on the client side. The AWS environment only stores the ciphertext, ensuring the student's unique ideas are never visible to the AI provider.

On-Chain Verification: To prevent "Resume Padding," every completed learning module triggers a smart contract call on Antigravity L1, storing a hash of the student’s achievement.

## 3. Component Details

### 3.1 Frontend Tier
- **Framework:** React.js with Tailwind CSS for rapid, responsive UI development.
- **Hosting:** AWS Amplify manages the CI/CD pipeline, building and deploying the frontend to a globally distributed CDN via Amazon CloudFront.
- **Key Features:**
  - Real-time rendering of Mermaid.js diagrams.
  - Streaming responses for lower perceived latency.
  - Optimistic UI updates for smooth interactions.

### 3.2 Backend Tier
- **API Gateway:** Acts as the entry point, handling throttling, validation, and CORS. It integrates with AWS Lambda via proxy integration.
- **AWS Lambda (Python Orchestrator):**
  - **Runtime:** Python 3.11+.
  - **Responsibility:**
    - Validates incoming requests.
    - Orchestrates calls to Amazon Bedrock.
    - Post-processes standard text responses vs. diagram generation requests.
    - Handles error scenarios and custom logic (e.g., "Smart Sprint" calculations).
  - **Concurrency:** Auto-scaling to handle burst traffic during exam seasons.

### 3.3 RAG Pipeline (The "Brain")
- **Amazon S3:** Stores the "Gold Standard" knowledge source - official board textbooks (PDFs).
- **Amazon Bedrock Knowledge Bases:** Managed RAG service that handles the ingestion, chunking, and embedding of textbook data.
- **Amazon OpenSearch Serverless:** Acts as the vector database backend for the Knowledge Base. It stores vector embeddings of the textbook content, enabling semantic search.
- **Model:** **Claude 3.5 Sonnet** on Bedrock. Chosen for its superior reasoning capabilities and ability to adhere to strict system prompts (crucial for "curriculum-locking").

### 3.4 Visual Logic Engine
The core innovation, transforming text into visual learning aids.
1.  **Trigger:** User requests a diagram or the system detects a complex logic flow.
2.  **Prompt Engineering:** The Lambda orchestrator injects a specific system prompt instructing Claude to output **only** valid Mermaid.js syntax for the given context.
3.  **Generation:** Claude generates the code string (e.g., `graph TD; A-->B;`).
4.  **Rendering:** The frontend receives the raw string and uses the `mermaid` JavaScript library to render an interactive SVG diagram in the browser.

## 4. Security & Compliance

### 4.1 Authentication & Authorization
- **Amazon Cognito:** Manages user sign-up, sign-in, and access control. Supports MFA and social identity providers if needed.
- **AWS IAM:** Implementation of Least Privilege access.
  - Lambda execution roles have strictly scoped permissions to invoke specific Bedrock models and write to specific CloudWatch log groups.
  - S3 buckets are private, accessible only via the Knowledge Base service role.

### 4.2 Data Protection
- **Encryption at Rest:** All data in S3 and OpenSearch Serverless is encrypted using AWS KMS.
- **Encryption in Transit:** All API traffic is secured via TLS 1.2+.

### 4.3 Monitoring & Observability
- **Amazon CloudWatch:** 
  - **Logs:** Captures all Lambda execution logs and API Gateway access logs.
  - **Metrics:** Monitors error rates, latency, and concurrent executions.
- **AWS X-Ray:** Provides end-to-end tracing of requests. This is critical for identifying bottlenecks in the RAG pipeline (e.g., is latency coming from the vector search or the model inference?).

## 5. Financial Analysis

### 5.1 Development Phase (Current)
- **Cost:** **$0.00**
- **Strategy:** Utilizing AWS Free Tier (1M Lambda requests/month, 25GB DynamoDB, etc.) and promotional credits for Bedrock/OpenSearch trials.

### 5.2 Production Phase (Projected for 500 Students)
**Estimated Monthly Cost: ~$50.00**

| Service | Metric Estimate | Approx. Cost |
| :--- | :--- | :--- |
| **Amazon Bedrock** | 1M input / 500k output tokens | ~$15.00 |
| **OpenSearch Serverless** | 0.5 OCU (Storage & Search) | ~$24.00 |
| **AWS Lambda** | 500k invocations, 3s duration | ~$2.00 |
| **CloudFront & Data Transfer** | 50GB transfer | ~$4.00 |
| **API Gateway** | 1M requests | ~$1.00 |
| **Cognito** | 500 MAU | Free Tier |
| **Total** | | **~$46.00** |

*Note: Costs are estimates based on us-east-1 pricing and standard usage patterns.*

## 6. Vision & Roadmap

### Phase 1: Foundation (Current)
- Complete RAG pipeline implementation for MSBTE Computer Engineering curriculum.
- Deploy MVP with Visual Logic Engine.

### Phase 2: Expansion (Q3 2026)
- **Multi-Board Support:** Ingest CBSE and ICSE textbooks into separate Knowledge Base data sources.
- **Multilingual Beta:** Test prompts for Hindi and Marathi translation of technical concepts.

### Phase 3: Offline & Edge (2027)
- **AWS IoT Greengrass:** Deploy quantized, smaller models (e.g., Llama-based) to local edge devices for schools with limited internet connectivity, syncing progress when online.

---
**Confidentiality:** This document is internal implementation guidance for the Architect-AI team.
