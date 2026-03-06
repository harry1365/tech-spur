# Contributing to Architect-AI

Thank you for your interest in contributing to Architect-AI! This document provides guidelines and instructions for contributing.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/harry1365/tech-spur.git`
3. Create a feature branch: `git checkout -b feature/your-feature-name`
4. Make your changes
5. Test your changes locally
6. Commit with clear messages: `git commit -m "Add: feature description"`
7. Push to your fork: `git push origin feature/your-feature-name`
8. Open a Pull Request

## Development Setup

### Prerequisites
- Node.js 18+
- Python 3.11+
- AWS CLI (for backend development)
- Git

### Local Development

**Windows:**
```bash
scripts\local-dev.bat
```

**Linux/Mac:**
```bash
bash scripts/local-dev.sh
```

## Code Style Guidelines

### Python (Backend)
- Follow PEP 8 style guide
- Use type hints where applicable
- Write docstrings for functions and classes
- Keep functions focused and small

### JavaScript/React (Frontend)
- Use functional components with hooks
- Follow React best practices
- Use meaningful variable names
- Keep components small and reusable

## Testing

Before submitting a PR:
- Test locally with both frontend and backend running
- Ensure no console errors
- Verify API endpoints work correctly
- Test responsive design on different screen sizes

## Pull Request Process

1. Update README.md if you add new features
2. Update documentation in docs/ if needed
3. Ensure your code follows the style guidelines
4. Write clear PR descriptions explaining your changes
5. Link any related issues

## Areas for Contribution

- **Frontend**: UI/UX improvements, new components
- **Backend**: API enhancements, performance optimization
- **Documentation**: Tutorials, guides, API docs
- **Testing**: Unit tests, integration tests
- **DevOps**: CI/CD improvements, deployment scripts
- **Blockchain**: Smart contract enhancements

## Reporting Bugs

Use GitHub Issues and include:
- Clear description of the bug
- Steps to reproduce
- Expected vs actual behavior
- Screenshots if applicable
- Environment details (OS, browser, versions)

## Feature Requests

Open a GitHub Issue with:
- Clear description of the feature
- Use case and benefits
- Potential implementation approach

## Questions?

Feel free to open a GitHub Discussion or reach out to the maintainers.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.
