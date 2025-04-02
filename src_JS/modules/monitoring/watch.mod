#!/bin/bash
if [[ -z "$1" ]]; then
    echo "❌ Specify a job ID or 'all' (e.g., job_scheduler -watch job_001)."
    exit 1
fi

while true; do
    clear
    echo "🔍 Monitoring jobs (Updated: $(date))"
    for folder in "$JOB_DIR"/job_*; do
        if [[ -d "$folder" && -f "$folder/job.pid" ]]; then
            JOB_PID=$(cat "$folder/job.pid")
            if ps -p "$JOB_PID" > /dev/null 2>&1; then
                echo "✅ $(basename "$folder") (PID: $JOB_PID) is running."
            fi
        fi
    done
    echo "Queued Jobs:"
    for queued in "$QUEUE_DIR"/*.run; do
        if [[ -f "$queued" ]]; then
            echo "⏳ $(basename "$queued" .run)"
        fi
    done
    sleep "$WATCH_REFRESH_INTERVAL"
done