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

## 🔄 Recent Updates

### 📐 Dynamic Configuration Architecture
The script features an interactive routing step inside Option 2 that asks for your project's precise structural footprint before demanding folder paths, allowing the core engine to dynamically re-scale its lane constraints:
* **Frontend Only Structure:** Dynamically isolates and requests exactly **4 active Frontend paths** (Production and Localhost profiles).
* **Backend Only Structure:** Dynamically isolates and requests exactly **4 active Backend paths** (Production and Localhost profiles).
* **Full-Stack Combo Layout:** Unlocks the full automated tracking array for all **8 project paths** simultaneously.

### 🛡️ Adaptive Gatekeeper Integration
The strict **All-or-Nothing Rule** now maps selectively against your chosen footprint. If you declare a "Frontend Only" scope, the verification engine bypasses backend checks completely, effectively eliminating false-positive folder errors or input crashes on empty rows while keeping safety locks running at 100% on active channels.

---

## 🛡️ Applied Safety Guardrail Matrix

| Security Check | Trigger Mechanism | Action Taken |
| :--- | :--- | :--- |
| **Path Exist Verification** | `if not exist "%TARGET%"` | Flashes UI bright red, halts all execution, prints the exact broken path string, resets to setup gate. |
| **Data Integrity Simulation** | Robocopy `/L` Flag | Runs a dry run "scout mode" log breakdown to list files that would be modified without executing a write action. |
| **Quote-Flooding Prevention** | Script Parsing Variable Stripping | Erases accidental encapsulation characters (`"`) to keep systemic directory queries perfectly valid. |

---

## 🧑‍💻 Credits & Architecture

* **System Architect & Designer:** Ezeki
* **Engine:** Windows Scripting Architecture (`Robocopy` / `CMD Shell`)

*Feel free to fork this repository, submit issues, or request feature enhancements!*
