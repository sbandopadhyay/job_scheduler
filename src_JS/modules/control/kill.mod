#!/bin/bash
if [[ -z "$1" ]]; then
    echo "❌ Specify a job ID or 'all' (e.g., job_scheduler -kill job_001)."
    exit 1
fi

if [[ "$1" == "all" ]]; then
    for folder in "$JOB_DIR"/job_*; do
        if [[ -f "$folder/job.pid" ]]; then
            JOB_PID=$(cat "$folder/job.pid")
            kill "$JOB_PID" 2>/dev/null && rm -f "$folder/job.pid"
            echo "🚫 Stopped $(basename "$folder")"
            log_action "Killed job $(basename "$folder") (PID: $JOB_PID)"
        fi
    done
    for queued in "$QUEUE_DIR"/*.run; do
        if [[ -f "$queued" ]]; then
            rm -f "$queued"
            echo "🚫 Removed queued job $(basename "$queued" .run)"
            log_action "Removed queued job $(basename "$queued")"
        fi
    done
else
    JOB_PATH="$JOB_DIR/$1"
    QUEUE_PATH="$QUEUE_DIR/$1.run"
    if [[ -f "$JOB_PATH/job.pid" ]]; then
        JOB_PID=$(cat "$JOB_PATH/job.pid")
        if ps -p "$JOB_PID" > /dev/null 2>&1; then
            kill "$JOB_PID" && { echo "🚫 Stopped job '$1'"; rm -f "$JOB_PATH/job.pid"; }
            log_action "Killed job $1 (PID: $JOB_PID)"
        else
            echo "ℹ️ Job '$1' already stopped."
            rm -f "$JOB_PATH/job.pid"
        fi
    elif [[ -f "$QUEUE_PATH" ]]; then
        rm -f "$QUEUE_PATH"
        echo "🚫 Removed queued job '$1'"
        log_action "Removed queued job $1"
    else
        echo "❌ No active or queued job found for '$1'."
    fi
fi