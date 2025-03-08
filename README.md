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

2. **Make job_scheduler executable**
   ```bash
   chmod +x job_scheduler

3. **(Optional) Add to your ~/.bashrc for easy access**
   ```bash
   echo 'export PATH="$HOME/job_scheduler:$PATH"' >> ~/.bashrc
   source ~/.bashrc


## 🔧 Usage
1. **Running a Job**
   Create a .run file with the command:
   ```bash
   echo "mpirun -np 4 ./mpi_test" > myjob.run
