# Beego Notes App - Secure Enterprise Edition

A minimalist, high-security Fullstack Notes application built with Go (Beego) and SQLite. Optimized for internal deployment with HTTPS and Docker.

## Key Features
- **Security Hardened**: 
    - **HTTPS Strictly Enforced**: Custom self-signed SSL certificate for **Banco Caja Social**.
    - **XSS Protection**: Automatic template escaping and security headers (CSP, HSTS).
    - **SQL Injection Defense**: Uses Beego ORM with parameterized queries.
    - **XSRF Protection**: Secure token validation on all forms.
- **Enterprise Ready**:
    - **Dockerized**: Multi-stage lightweight Alpine build (~20MB).
    - **Persistence**: Managed via Docker volumes.
    - **Non-Root Execution**: Runs under a dedicated `appuser` for maximum isolation.

## Prerequisites
- **Docker** and **Docker Compose**

## Quick Start (Docker)

1. **Build and Start**:
   ```bash
   docker compose up -d
   ```
2. **Access the App**:
   - URL: `https://localhost`
   - *Note: Since we use a self-signed certificate, you will see a security warning. Click "Advanced" and "Proceed to localhost".*

## Environment Configuration
The application uses environment variables for flexibility. See `.env.example` for reference:
- `DB_PATH`: Path to the SQLite database.
- `HTTPS_PORT`: Internal HTTPS port.
- `HTTPS_CERT`: Path to the SSL certificate.
- `HTTPS_KEY`: Path to the SSL private key.

## Development Setup
If you wish to run locally without Docker:
1. `go mod tidy`
2. `go run main.go`
3. Access via `https://localhost:8443` (ensure certs exist in `conf/`).

## Project Cleanup
The repository has been audited for production. Local development logs and databases are moved to `logsDevelop/` and are ignored by version control.
