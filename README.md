AMD-REBAR-FIX-WIN10
AMD's newer drivers changed how some Windows 10 AMD GPU features are handled by removing certain legacy driver-side components and altering how system-level features such as ReBAR configuration are applied. This can leave Windows 10 users with hardware capable of features that are no longer exposed correctly through newer driver packages.

This fix restores the missing software-side configuration paths through supported AMD driver registry parameters and Windows graphics configuration settings.

This works with full AMD Adrenalin installs. It also works with Hellm's MoreClockTool2 and AMD driver-only installs for a cleaner, lower-bloat setup. If using MoreClockTool, you must manually configure Windows startup (details at the bottom). Use at your own risk.

🚀 How to Run the Bloody Thing
Extract amd-win10-rebar-fix-run-as-admin.bat anywhere on your PC.

Right-click → Run as Administrator (required for registry, service, and scheduled task changes).

The script applies AMD GPU registry configuration, Windows graphics scheduler settings, recovery parameters, creates C:\AMD-Fix\, generates the rollback utility, and registers the background driver update monitor.

Reboot immediately to allow all changes to apply.

AMD RDNA Master Kernel & Hardware Performance Injector
THIS SCRIPT ONLY AFFECTS GPU-FOCUSED REGISTRY FILES AND WINDOWS GRAPHICS SETTINGS FOR AMD GPUS ON WINDOWS 10
⚡ What This Script Actually Does
Redundant Repository & Silent Driver Update Monitor
Self-Cloning Storage Engine: Copies the active script into C:\AMD-Fix\ and generates a rollback utility for recovery or removal.

Automated Update Correction System: Creates a Task Scheduler entry (AMD-Win10-Fix) running under NT AUTHORITY\SYSTEM at logon to detect AMD driver changes and restore configuration when needed.

Silent Driver Version Monitor: Stores the installed AMD driver version in amd_driver_version.txt and compares it during scheduled execution. If the driver version changes, the optimization profile is reapplied. If unchanged, the script exits immediately.

AMD External Events Utility Handling
Automatic AMD Service Detection: Locates AMD External Events Utility via registry instead of relying on fixed service names.

Driver Recovery Support: Re-enables and starts the service during rollback to restore default AMD driver behaviour.

Driver Package Compatibility: Registry-based discovery ensures compatibility across AMD driver naming variations.

RDNA Architecture Tuning & Software ReBAR Configuration
Hardware Profile Mapping Matrix: Scans AMD display driver registry class keys ({4d36e968-e325-11ce-bfc1-08002be10318}) to locate active AMD GPU nodes without relying on slot numbering.

Software Resizable BAR Configuration: Applies AMD registry flags:

KMD_EnableReBarForLegacyASIC

KMD_RebarControlMode

KMD_RebarControlSupport  
These restore the software-side ReBAR configuration path for supported AMD hardware on Windows 10.

ULPS Deactivation: Sets EnableUlps=0 to disable Ultra Low Power State transitions.

Forced Shader Cache: Sets ShaderCache=2 to enable driver shader caching.

Display Power State Adjustments: Applies StutterMode=0 and DisableDscDeepSleep=1 to reduce aggressive display power transitions.

Frame Latency Alignment: Sets MainFrameLatency=1.

Hardware-Accelerated GPU Scheduling (HAGS)
Hardware Scheduling Enforcer: Forces Windows Hardware-Accelerated GPU Scheduling through:

HwSchMode=2

This enables the Windows GPU hardware scheduling path where supported.

Multi-Plane Overlay (MPO) Configuration
DWM Overlay Override: Applies:

OverlayTestMode=5

to disable Windows Multi-Plane Overlay behaviour, resolving flickering, browser acceleration issues, and overlay conflicts.

Core OS Driver Recovery & System Optimizations
TDR Extension Parameters: Extends GPU recovery timing with:

TdrDelay=20
TdrDdiDelay=20

Hybrid Fast Startup Termination: Applies:

HiberbootEnabled=0

to disable Windows Fast Startup for cleaner initialization.

GameDVR Hook Blocking: Applies:

AllowGameDVR=0

to disable Xbox GameDVR background hooks.

Take Ownership Context Extensions
Universal Owner Rights Mapping: Adds right-click ownership options using:

*S-1-3-4:F

This avoids language-specific permission issues.

Supports:

Files

Folders

Drives

Manual MoreClockTool Startup Setup
IF YOU WANT TO USE MORECLOCKTOOL WITH THIS
MoreClockTool is a paid Microsoft Store application.

For the cleanest setup:

Use DDU to remove previous drivers.

Install the latest AMD driver using driver-only installation.

Once MoreClockTool is installed:

Open the hidden AppsFolder:
Win + R → shell:AppsFolder

Find MoreClockTool → Right-click → Create shortcut

Move the shortcut into Startup:
Win + R → shell:startup  
Move the shortcut into the folder.

This launches MoreClockTool using its correct UWP activation path every startup.
