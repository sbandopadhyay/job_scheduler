# Job Scheduler

A **lightweight, modular job scheduler** for managing background jobs on a **single workstation**. Designed as a simple alternative to complex schedulers like **Slurm** or **PBS**, `job_scheduler` provides **job tracking, logging, monitoring, queuing, and easy execution**.

## 🚀 Features
✅ **Immediate Job Execution** (`-srun <job>.run`)  
✅ **Queued Job Execution** (`-qrun <job>.run`, respects concurrent job limits)  
✅ **Track Running & Queued Jobs** (`-status`)  
✅ **List All Jobs** (`-list`, shows running, queued, and completed jobs)  
✅ **Kill Jobs Easily** (`-kill <job_id/all>`)  
✅ **Monitor Jobs in Real-Time** (`-watch <job_id/all>`)  
✅ **Automatic Job Logging** (`job_001.log`, `job_002.log`, etc.)  
✅ **Auto-Archive Completed Jobs** (`-archive` command)  
✅ **Fully Modular Design** (`modules/` folder for each command)  
✅ **Configurable Settings** (`job_scheduler.config`)  

## 📂 Folder Structure
   ```bash
  job_scheduler/             # Main directory
  ├── job_scheduler          # Main script
  ├── job_scheduler.config   # Config file (user settings)
  └── modules/               # Stores individual command scripts
     ├── help.mod           # Help command
     ├── core/              # Core execution modules
     │   ├── srun.mod       # Immediate job execution
     │   └── qrun.mod       # Queued job execution
     ├── utilities/         # Utility modules
     │   └── queue.mod      # Queue management
     ├── monitoring/        # Monitoring modules
     │   ├── status.mod     # Job status
     │   ├── list.mod       # Job listing
     │   └── watch.mod      # Real-time monitoring
     └── control/           # Control modules
         ├── kill.mod       # Job termination
         └── archive.mod    # Job archiving
   ```




## 🛠 Installation & Setup
1. **Clone the Repository**
   ```bash
   git clone <your-private-repo-url>
   cd job_scheduler
   ```

2. **Make job_scheduler executable**
   ```bash
   chmod +x job_scheduler
   ```

3. **(Optional) Add to your ~/.bashrc for easy access**
   ```bash
   echo 'export PATH="$HOME/<PATH TO src_JS Folder>/job_scheduler:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   ```


## 🔧 Usage
1. **Running a Job**
   
   - Create a .run file with the command:
   ```bash
   echo "mpirun -np 4 ./mpi_test" > myjob.run
   ```

   - Start immediately:
   ```bash
   job_scheduler -srun myjob.run
   ```

   - Start with queuing:
   ```bash
   job_scheduler -qrun myjob.run
   ```

2. **Checking Job Status**
   - Check status with :
   ```bash
   job_scheduler -status
   ```
   
   - Example Output:
   ```scss
   Running Jobs:
   ✅ job_001 is running (PID: 12345)
   Queued Jobs:
   ⏳ job_002
   ```

3. **Listing All Jobs**
   - List all jobs with :
   ```bash
   job_scheduler -list
   ```
   
   - Example Output:
   ```scss
   📜 Listing all jobs...
   Running Jobs:
   ✅ job_001 (Active)
   Queued Jobs:
   ⏳ job_002 (Queued)
   Completed Jobs:
   ❌ job_003 (Completed)
   ```

4. **Killing a Job**
   - Kill any one or all jobs with :
   ```bash
   job_scheduler -kill job_001  # Kill a specific job
   job_scheduler -kill all       # Kill all running jobs
   ```

5. **Monitoring Jobs Live**
   - Monitor any one or all jobs with :
   ```bash
   job_scheduler -watch job_001  # Monitor one job
   job_scheduler -watch all      # Monitor all jobs
   ```

6. **Archiving Completed Jobs**
   - Archive the completed jobs with :
   ```bash
   job_scheduler -archive
   ```
   
   - Example Output:
   ```pgsql
   📦 Archiving completed jobs to batch 001...
   ✅ Moved job_002 to archive batch 001.
   🎯 Archive complete! View old jobs in /home/user/job_logs/archive/001/
   ```


## 📊 Comparison with Other Job Schedulers

| **Feature**                | **job_scheduler**  | **tmux + bash**  | **GNU Parallel** |
|----------------------------|-------------------|------------------|------------------|
| 🟢 **Tracks jobs**          | ✅ Yes  | ❌ No | ❌ No |
| 🟡 **Auto logs each job**   | ✅ Yes  | ❌ No | ✅ Yes |
| 🔴 **Auto-indexed job IDs** | ✅ Yes  | ❌ No | ❌ No |
| 🔥 **Easy job termination** | ✅ Yes | ❌ No | ❌ No |
| 🟢 **Live monitoring**      | ✅ Yes | ❌ No | ❌ No |
| 🟠 **Auto-archives jobs**   | ✅ Yes | ❌ No | ❌ No |
| 🟠 **Queue management**     | ✅ Yes | ❌ No | ❌ No |





## 🔮 To-do List

   - Add job priority levels (low, normal, high)
   - Implement a web-based dashboard for job management
   - Python API integration
   - More detailed resource monitoring (CPU, RAM, Disk)



## 🤝 Suggestions
Feel free to suggest improvements or feature ideas! 😊
