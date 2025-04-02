#!/bin/bash

# Count running jobs
count_running_jobs() {
    local count=0
    for folder in "$JOB_DIR"/job_*; do
        if [[ -d "$folder" && -f "$folder/job.pid" ]]; then
            JOB_PID=$(cat "$folder/job.pid")
            if ps -p "$JOB_PID" > /dev/null 2>&1; then
                count=$((count + 1))
            else
                rm -f "$folder/job.pid"
            fi
        fi
    done
    echo "$count"
}

# Process queue
running=$(count_running_jobs)
if [[ "$running" -lt "$MAX_CONCURRENT_JOBS" ]]; then
    queued=$(ls "$QUEUE_DIR"/*.run 2>/dev/null | head -1)
    if [[ -n "$queued" ]]; then
        source "$MODULES_DIR/core/qrun.mod" "$queued" "from_queue"
        mv "$queued" "$queued.processed"
        log_action "Started queued job: $(basename "$queued")"
        source "$MODULES_DIR/utilities/queue.mod"  # Recursive call
    fi
fi