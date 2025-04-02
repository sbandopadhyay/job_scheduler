#!/bin/bash
JOB_FILE="$1"
FROM_QUEUE="$2"

if [[ -z "$JOB_FILE" ]]; then
    echo "❌ Please specify a job file (e.g., job_scheduler -qrun myjob.run)."
    exit 1
fi

if [[ ! -f "$JOB_FILE" ]]; then
    echo "❌ Error: Job file '$JOB_FILE' does not exist!"
    exit 1
fi

CMD=$(cat "$JOB_FILE")
if [[ -z "$CMD" ]]; then
    echo "❌ Error: The job file '$JOB_FILE' is empty!"
    exit 1
fi

# Count running jobs
running_jobs=0
for folder in "$JOB_DIR"/job_*; do
    if [[ -d "$folder" && -f "$folder/job.pid" ]]; then
        JOB_PID=$(cat "$folder/job.pid")
        if ps -p "$JOB_PID" > /dev/null 2>&1; then
            running_jobs=$((running_jobs + 1))
        else
            rm -f "$folder/job.pid"
        fi
    fi
done

# Queue if limit reached and not from queue
if [[ "$running_jobs" -ge "$MAX_CONCURRENT_JOBS" && "$FROM_QUEUE" != "from_queue" ]]; then
    JOB_INDEX=$(find "$JOB_DIR" -maxdepth 1 -type d -name 'job_*' -exec basename {} \; | sed 's/job_//' | sort -n | tail -1)
    JOB_INDEX=${JOB_INDEX:-0}
    JOB_INDEX=$((JOB_INDEX + 1))
    QUEUED_FILE="$QUEUE_DIR/job_$(printf "%03d" $JOB_INDEX).run"
    cp "$JOB_FILE" "$QUEUED_FILE"
    echo "ℹ️ Job queued as 'job_$(printf "%03d" $JOB_INDEX)' (Running: $running_jobs/$MAX_CONCURRENT_JOBS)"
    log_action "Queued job: $QUEUED_FILE"
    exit 0
fi

# Start the job
JOB_INDEX=$(find "$JOB_DIR" -maxdepth 1 -type d -name 'job_*' -exec basename {} \; | sed 's/job_//' | sort -n | tail -1)
JOB_INDEX=${JOB_INDEX:-0}
JOB_INDEX=$((JOB_INDEX + 1))
JOB_NAME="job_$(printf "%03d" $JOB_INDEX)"
JOB_PATH="$JOB_DIR/$JOB_NAME"

mkdir -p "$JOB_PATH"
echo "$CMD" > "$JOB_PATH/command.run"

LOG_FILE="${LOG_FILE_NAME/XXX/$JOB_INDEX}"
nohup bash -c "$CMD" > "$JOB_PATH/$LOG_FILE" 2>&1 &
PID=$!

echo "$PID" > "$JOB_PATH/job.pid"

echo "✅ Job '$JOB_NAME' started (PID: $PID)"
echo "🔍 Check status: job_scheduler -status"
log_action "Started queued job $JOB_NAME with command: $CMD"