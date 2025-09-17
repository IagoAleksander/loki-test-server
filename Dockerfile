FROM grafana/loki:2.9.2

# Create necessary directories
RUN mkdir -p /tmp/loki/chunks /tmp/loki/rules

# Copy config file
COPY loki-config.yaml /etc/loki/local-config.yaml

# Expose port
EXPOSE 3100

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3100/ready || exit 1

# Start Loki
CMD ["-config.file=/etc/loki/local-config.yaml"]
