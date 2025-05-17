# Base image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Copy app source code
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Create necessary folders as mount points (marked as volumes later)
RUN mkdir -p instance logs static tmp uploads

# Set permissions (OpenShift often runs containers as random UID)
RUN chmod -R 777 instance logs static tmp uploads

# Expose port (Flask default)
EXPOSE 5000

# Volume declarations (informational for Docker)
VOLUME ["/app/instance", "/app/logs", "/app/static", "/app/tmp", "/app/uploads"]

# Default command using Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
