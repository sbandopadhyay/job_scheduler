#!/bin/bash
if [[ -z "$1" ]]; then
    echo "❌ Specify a job ID or 'all' (e.g., job_scheduler kill job_001)."
    exit 1
fi

if [[ "$1" == "all" ]]; then
    for folder in "$JOB_DIR"/job_*; do
        if [[ -f "$folder/job.pid" ]]; then
            JOB_PID=$(cat "$folder/job.pid")
            kill "$JOB_PID" 2>/dev/null
            echo "🚫 Stopped $(basename "$folder")"
        fi
    done
else
    JOB_PATH="$JOB_DIR/$1"
    if [[ -f "$JOB_PATH/job.pid" ]]; then
        JOB_PID=$(cat "$JOB_PATH/job.pid")
        kill "$JOB_PID" 2>/dev/null
        echo "🚫 Stopped job '$1'"
    else
        echo "❌ No active job found for '$1'."
    fi
fi

