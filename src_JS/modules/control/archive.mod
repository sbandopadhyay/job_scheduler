#!/bin/bash
get_next_archive_index() {
    last_archive=$(ls "$ARCHIVE_DIR" | grep -Eo '[0-9]+' | sort -n | tail -1)
    if [[ -z "$last_archive" ]]; then
        echo "001"
    else
        printf "%03d" $((last_archive + 1))
    fi
}

ARCHIVE_BATCH=$(get_next_archive_index)
ARCHIVE_PATH="$ARCHIVE_DIR/$ARCHIVE_BATCH"
mkdir -p "$ARCHIVE_PATH"

echo "📦 Archiving completed jobs to batch $ARCHIVE_BATCH..."
archived_jobs=0

for folder in "$JOB_DIR"/job_*; do
    if [[ -d "$folder" && ! -f "$folder/job.pid" ]]; then
        mv "$folder" "$ARCHIVE_PATH/" || { echo "❌ Failed to archive $(basename "$folder")"; exit 1; }
        echo "✅ Moved $(basename "$folder") to archive batch $ARCHIVE_BATCH."
        archived_jobs=$((archived_jobs + 1))
    fi
done

if [[ "$archived_jobs" -gt 0 ]]; then
    echo "🎯 Archive complete! View old jobs in $ARCHIVE_PATH/"
    log_action "Archived $archived_jobs jobs to $ARCHIVE_PATH"
else
    echo "ℹ️ No completed jobs found to archive."
fi