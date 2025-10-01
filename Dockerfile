# Use official Python 3.13 slim image
FROM python:3.13-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy application code
COPY . /app

# Upgrade pip and install dependencies
RUN pip install --upgrade pip setuptools wheel \
    && pip install fastmcp \
    && pip install -r requirements.txt

# Expose port 8000 for SSE transport
EXPOSE 8000

# Environment variable for Red Hat API offline token
ENV RH_API_OFFLINE_TOKEN=""

# Run the MCP server using SSE transport on all network interfaces
CMD ["python", "redhat_mcp_server.py"]
