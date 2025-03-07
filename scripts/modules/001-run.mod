#!/bin/bash
if [[ -z "$1" ]]; then
    echo "❌ Please specify a job file (e.g., job_scheduler -run myjob.run)."
    exit 1
fi

JOB_FILE=$1
CMD=$(cat "$JOB_FILE")

if [[ -z "$CMD" ]]; then
    echo "❌ Error: The job file '$JOB_FILE' is empty!"
    exit 1
fi

JOB_INDEX=$(ls "$JOB_DIR" | grep -Eo '[0-9]+' | sort -n | tail -1)
JOB_INDEX=$((JOB_INDEX + 1))
JOB_NAME="job_$(printf "%03d" $JOB_INDEX)"
JOB_PATH="$JOB_DIR/$JOB_NAME"

mkdir -p "$JOB_PATH"
echo "$CMD" > "$JOB_PATH/command.run"
echo "$(pwd)" > "$JOB_PATH/workdir.info"

LOG_FILE="${LOG_FILE_NAME/XXX/$JOB_INDEX}"
nohup $CMD > "$JOB_PATH/$LOG_FILE" 2>&1 &

echo $! > "$JOB_PATH/job.pid"

echo "✅ Job '$JOB_NAME' started (PID: $(cat "$JOB_PATH/job.pid"))"
echo "🔍 Check status: job_scheduler status"

