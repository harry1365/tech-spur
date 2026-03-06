# API Specification

## Base URL
`/api/v1`

## Endpoints

### `POST /query`
Queries the Knowledge Base using RAG and returns an answer bounded by the syllabus.

**Request Body:**
```json
{
  "question": "Explain the Von Neumann architecture."
}
```

**Response:**
```json
{
  "answer": "Von Neumann architecture consists of a CPU, memory, and I/O devices with a shared bus... (based on textbook X)."
}
```

### `POST /diagram`
Generates a Mermaid.js diagram definition for a given topic.

**Request Body:**
```json
{
  "topic": "Linked List insertion process"
}
```

**Response:**
```json
{
  "mermaid_code": "graph TD; A[Node 1]-->B[Node 2]; C[New Node]-->B;"
}
```
