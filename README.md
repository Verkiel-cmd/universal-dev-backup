# Universal Dev Backup Utility (Strict Guardrail System)

A lightweight, lightning-fast, zero-dependency DevOps utility for Windows that safely mirrors active development environments to cloud storage. 

Built specifically to solve the "Node Modules Nightmare" and eliminate human error during manual backups, this script features a real-time path verification engine and a risk-free simulation mode.

---

## 🚀 The Core Problems This Solves

1. **The Node Modules Nightmare:** Dragging web development projects manually into Google Drive or OneDrive can freeze your system or take hours because cloud clients struggle to parse tens of thousands of tiny dependency files inside `node_modules`. This tool skips the garbage and completes backups in **seconds**.
2. **Accidental Cloud Overwrites:** Running a mirror automation script blindly can wipe out cloud files if your local target is incorrect. The **Safe Mode Simulation** lets you preview changes before a single byte is altered.
3. **Broken Automation Paths:** Most automation scripts crash silently or break if a directory is missing or misconfigured. This tool utilizes strict guardrails to intercept errors and halt execution before any data corruption happens.

---

## ✨ Features

* **Zero Dependencies:** Built entirely on native Windows Batch processing and `robocopy`—no installation or external packages required.
* **Dual Environment Syncing:** Simultaneously manages and segments both your `PRODUCTION` and `LOCALHOST` project frontends.
* **Interactive Initialization Wizard:** Dynamically updates the application interface, menus, and window titles to match any project name and folder directory inputted by the user.
* **Smart String Sanitation:** Automated guardrail that automatically strips out double-quotes (`"`) if a developer accidentally drags-and-drops or copy-pastes directory paths containing spaces.
* **Automated Exclusions:** Native multi-threaded exclusion of heavy or redundant build directories (`node_modules`, `dist`, `.git`).

---

## 🛠️ Installation & Setup

1. **Download the Script:** Clone or download `Master_Backup.bat` into your local machine.
2. **Run as Administrator (Optional but Recommended):** Double-click the file to boot up the system wizard.

---

## 🎮 How to Use

### Option 1: Developer Default Setup (Quick Launch)
For the main repository maintainer, pressing `1` instantly loads the hardcoded, pre-verified local and cloud configurations for immediate project syncing without typing a single word.

### Option 2: Custom Project Setup (For Team Members / Other Repositories)
For external developers or alternative workflows:
1. Select **Option [2]** at the launch gate.
2. Enter your custom **Project Name** (the entire UI will dynamically re-brand itself to your project).
3. Right-click or drag-and-drop your custom local sources and cloud backup destination paths.
4. Run a **Safe Simulation** to test integrity, then execute your live synchronization safely.

---

## 🟢 Recent Updates

### 📐 Dynamic Configuration Architecture
The script features an interactive routing step inside Option 2 that asks for your project's precise structural footprint before demanding folder paths, allowing the core engine to dynamically re-scale its lane constraints:

* **Single Environment Pipeline:** Allocates and monitors exactly **2 paths** (1 local Source and 1 cloud Destination), making it perfect for rapid single-component sync setups.
* **Frontend Only Structure:** Dynamically isolates and requests exactly **4 active Frontend paths** (Production and Localhost profiles).
* **Backend Only Structure:** Dynamically isolates and requests exactly **4 active Backend paths** (Production and Localhost profiles).
* **Full-Stack Combo Layout:** Unlocks the full automated tracking array for all **8 project paths** simultaneously.

* ### 💾 Dynamic Profile Manager Features
* **Save / Update Profiles:** Complete a custom path wizard run once, and optionally save the entire session memory block to disk as a persistent profile. Re-saving to an existing profile name seamlessly updates its mapped paths.
* **Instant Load:** Read the profile manifest on startup, select your project name, and drop straight into the backup execution engine in under 5 seconds.
* **Disk Clean Up:** Safely scrub and delete retired profile strings from records without affecting other configurations.

---

## ⚠️ Crucial Folder Renaming Rules (How it Behaves)

When renaming project directories on your local computer, the utility relies on Windows file system architecture. Please note the following behaviors:

### 1. Total Folder Renames (e.g., `project2` ➡️ `assets34`)
* **What it does:** The engine tracks this perfectly. Because the old folder name no longer exists, the script flags the old cloud copy as an **"Extra"** directory and completely **purges/deletes it** from Google Drive to protect your storage limits. It then treats the new name as a brand-new directory and **uploads everything from scratch**.
* **Action Required:** You must run **Option 2** to type in the new paths and overwrite your old saved profile so the script doesn't throw a `❌ CRITICAL CONFIGURATION ERROR`.

### 2. Capitalization-Only Renames (e.g., `my-project` ➡️ `My-Project`)
* **What it does:** **The script cannot detect this automatically.** Windows is *case-insensitive* and will report to `robocopy` that the folder path has not changed, causing the cloud copy to remain lowercase.
* **Action Required:** To force Windows to recognize the casing change, temporarily rename your local folder to something else (e.g., `my-project-temp`), then rename it to your preferred capitalized title (`My-Project`). Once done, update your profile paths!

### 🛡️ Adaptive Gatekeeper Integration
The strict **All-or-Nothing Rule** now maps selectively against your chosen footprint. If you declare a "Single Environment" or "Frontend Only" scope, the verification engine isolates its focus exclusively to those specific paths. It intentionally bypasses unselected paths, completely eliminating false-positive folder errors or input crashes on empty rows while keeping the core flashing red safety locks running at 100% on active channels.

---

## 🛡️ Applied Safety Guardrail Matrix

| Security Check | Trigger Mechanism | Action Taken |
| :--- | :--- | :--- |
| **Path Exist Verification** | `if not exist "%TARGET%"` | Flashes UI bright red, halts all execution, prints the exact broken path string, resets to setup gate. |
| **Data Integrity Simulation** | Robocopy `/L` Flag | Runs a dry run "scout mode" log breakdown to list files that would be modified without executing a write action. |
| **Quote-Flooding Prevention** | Script Parsing Variable Stripping | Erases accidental encapsulation characters (`"`) to keep systemic directory queries perfectly valid. |
| **Universal Cloud Interceptor:** | Automatically detects and halts execution if any major cloud service path (Google Drive, OneDrive, Dropbox, iCloud) is accidentally used as a local source directory. | Your `src` was protected by scanning the `PATH` directory and blocking wrong inputs/prompts. |

---

## 🧑‍💻 Credits & Architecture

* **System Architect & Designer:** Verkiel-cmd
* **Engine:** Windows Scripting Architecture (`Robocopy` / `CMD Shell`)

*Feel free to fork this repository, submit issues, or request feature enhancements!*
