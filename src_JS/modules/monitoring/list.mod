#!/bin/bash
echo "📜 Listing all jobs..."
echo "Running Jobs:"
for folder in "$JOB_DIR"/job_*; do
    if [[ -d "$folder" && -f "$folder/job.pid" ]]; then
        echo "✅ $(basename "$folder") (Active)"
    fi
done
echo "Queued Jobs:"
for queued in "$QUEUE_DIR"/*.run; do
    if [[ -f "$queued" ]]; then
        echo "⏳ $(basename "$queued" .run) (Queued)"
    fi
done
echo "Completed Jobs:"
for folder in "$JOB_DIR"/job_*; do
    if [[ -d "$folder" && ! -f "$folder/job.pid" ]]; then
        echo "❌ $(basename "$folder") (Completed)"
    fi
done