#!/bin/bash
echo "📜 Listing all jobs..."
for folder in "$JOB_DIR"/job_*; do
    if [[ -d "$folder" ]]; then
        JOB_NAME=$(basename "$folder")
        if [[ -f "$folder/job.pid" ]]; then
            echo "✅ $JOB_NAME (Active)"
        else
            echo "❌ $JOB_NAME (Completed)"
        fi
    fi
done

