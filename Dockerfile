FROM python:3.11-slim

# Install required packages
RUN apt-get update && apt-get install -y \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Copy your Python app
WORKDIR /app
COPY . /app
RUN pip install --no-cache-dir -r requirements.txt || true

# Supervisor config to run your Python app
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 5000
CMD ["/usr/bin/supervisord"]