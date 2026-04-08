# --- Stage 1: Build & Security Setup ---
FROM golang:1.24-alpine AS builder

# Install build-base for CGO (SQLite) and openssl for HTTPS certs
RUN apk add --no-cache build-base openssl

WORKDIR /app

# Copy dependencies first for caching
COPY go.mod go.sum ./
RUN go mod download

# Copy source code
COPY . .

# Build step with CGO enabled for SQLite and static linking for Alpine
RUN CGO_ENABLED=1 GOOS=linux GOARCH=amd64 \
    go build -ldflags="-s -w -extldflags '-static'" -o notes-app .

# Generate self-signed certificate for "Banco Caja Social"
RUN openssl req -x509 -newkey rsa:4096 -keyout conf/key.pem -out conf/cert.pem -days 365 -nodes \
    -subj "/C=CO/ST=DC/L=Bogota/O=Banco Caja Social/CN=Banco Caja Social/emailAddress=alsalejopa@unal.edu.co"

# --- Stage 2: Minimalist Runtime ---
FROM alpine:latest

# Security: Install CA certificates and create a non-root user
RUN apk add --no-cache ca-certificates && \
    addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Create data directory for SQLite persistence
RUN mkdir -p /data && chown appuser:appgroup /data

# Copy binary and required folders from builder
COPY --from=builder /app/notes-app .
COPY --from=builder --chown=appuser:appgroup /app/conf ./conf
COPY --from=builder --chown=appuser:appgroup /app/views ./views
# COPY --from=builder --chown=appuser:appgroup /app/static ./static

# Set environment variables for flexibility
ENV DB_PATH=/data/notes.db \
    HTTPS_PORT=8443 \
    HTTPS_CERT=conf/cert.pem \
    HTTPS_KEY=conf/key.pem \
    BEEGO_RUNMODE=prod

# Expose port 8443 strictly (non-root)
EXPOSE 8443

# Run as non-root user for maximum security
USER appuser

CMD ["./notes-app"]
