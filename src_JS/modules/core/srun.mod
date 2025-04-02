#!/bin/bash
JOB_FILE="$1"

if [[ -z "$JOB_FILE" ]]; then
    echo "❌ Please specify a job file (e.g., job_scheduler -srun myjob.run)."
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

# Start the job immediately (no queue check)
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

echo "✅ Job '$JOB_NAME' started immediately (PID: $PID)"
echo "🔍 Check status: job_scheduler -status"
log_action "Started simple job $JOB_NAME with command: $CMD"