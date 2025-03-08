# job_scheduler
A **lightweight, modular job scheduler** for managing background jobs on a **single workstation**.  
Designed as a simple alternative to complex schedulers like **Slurm** or **PBS**, `job_scheduler` provides **job tracking, logging, monitoring, and easy execution**.

## 🚀 Features
✅ **Start & track jobs** (`-run <job>.run`)  
✅ **List running & completed jobs** (`status`, `list`)  
✅ **Kill jobs easily** (`kill <job_id/all>`)  
✅ **Monitor jobs in real-time** (`-watch <job_id/all>`)  
✅ **Automatic job logging** (`job_001.log`, `job_002.log`, etc.)  
✅ **Auto-archive completed jobs** (`archive` command)  
✅ **Fully modular** (`modules/` folder for each command)  
✅ **Configurable settings** (`job_scheduler.config`)  

## 📂 Folder Structure

- job_scheduler/             # Main directory
- ├── job_scheduler          # Main script
- ├── job_scheduler.config   # Config file (user settings)
- └── modules/               # Stores individual command scripts
- -   ├── 001-run.mod
- -   ├── 002-status.mod
- -   ├── 003-list.mod
- -   ├── 004-kill.mod
- -   ├── 005-archive.mod
- -   ├── 006-watch.mod
- -   └── 007-help.mod


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
   echo 'export PATH="$HOME/job_scheduler:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   ```


## 🔧 Usage
1. **Running a Job**
   
   - Create a .run file with the command:
   ```bash
   echo "mpirun -np 4 ./mpi_test" > myjob.run
   ```

   - Start the job:
   ```bash
   job_scheduler -run myjob.run
   ```

2. **Checking Job Status**
   - Check status with :
   ```bash
   job_scheduler status
   ```
   
   - Example Output:
   ```scss
   🔍 Checking running jobs...
   ✅ job_001 is running (PID: 12345)
   📌 Log file: job_logs/job_001/job_001.log
   ```

3. **Listing All Jobs**
   - List all jobs with :
   ```bash
   job_scheduler list
   ```
   
   - Example Output:
   ```scss
   📜 Listing all jobs...
   ✅ job_001 (Active)
   ❌ job_002 (Completed)
   ```

4. **Killing a Job**
   - Kill any one or all jobs with :
   ```bash
   job_scheduler kill job_001  # Kill a specific job
   job_scheduler kill all       # Kill all running jobs
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
   job_scheduler archive
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


