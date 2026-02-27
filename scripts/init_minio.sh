#!/bin/sh
# Runs inside the minio/mc container on first stack start.
# Creates the required buckets in the local MinIO instance.

set -e

# Wait for MinIO to be ready
echo "Waiting for MinIO to be ready..."
until mc alias set local http://minio:9000 "${MINIO_ROOT_USER}" "${MINIO_ROOT_PASSWORD}" > /dev/null 2>&1; do
  sleep 1
done
echo "MinIO is ready."

# Create warehouse bucket (Bronze / Silver / Gold Delta tables)
mc mb --ignore-existing local/warehouse
echo "Bucket 'warehouse' ready."

# Create spark-logs bucket (reserved for future S3-based event logging)
mc mb --ignore-existing local/spark-logs
echo "Bucket 'spark-logs' ready."

echo "MinIO initialisation complete."
echo "  Warehouse:   s3a://warehouse/"
echo "    Bronze:    s3a://warehouse/bronze/"
echo "    Silver:    s3a://warehouse/silver/"
echo "    Gold:      s3a://warehouse/gold/"
