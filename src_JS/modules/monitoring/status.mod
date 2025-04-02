#!/bin/bash
echo "🔍 Checking job status..."
echo "Running Jobs:"
for folder in "$JOB_DIR"/job_*; do
    if [[ -d "$folder" && -f "$folder/job.pid" ]]; then
        JOB_PID=$(cat "$folder/job.pid")
        if ps -p "$JOB_PID" > /dev/null 2>&1; then
            echo "✅ $(basename "$folder") is running (PID: $JOB_PID)"
        else
            echo "❌ $(basename "$folder") is NOT running."
            rm -f "$folder/job.pid"
        fi
    fi
done
echo "Queued Jobs:"
for queued in "$QUEUE_DIR"/*.run; do
    if [[ -f "$queued" ]]; then
        echo "⏳ $(basename "$queued" .run)"
    fi
done