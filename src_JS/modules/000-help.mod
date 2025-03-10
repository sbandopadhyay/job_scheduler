#!/bin/bash
echo "🔹 Usage: job_scheduler [COMMAND] [ARGUMENT]"
echo ""
echo "Commands:"
echo "  -run <job_file>.run   Start a new job"
echo "  -status                Show running jobs"
echo "  -list                  Show all jobs (running & completed)"
echo "  -kill <job_id/all>     Stop a job or all jobs"
echo "  -archive               Move completed jobs to archive"
echo "  -watch <job_id/all>   Monitor jobs in real-time"
echo "  --config <path>       Use a custom config file"
echo "  --help                Show this help message"

