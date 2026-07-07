# AMD-REBAR-FIX-WIN10
AMD's new drivers cut Windows 10 ReBAR by decoupling system-level amdkmpfd files to fix install bugs, ditching optimizations for an aging OS. It’s incredibly insulting to be forced onto a worse gaming experience or pushed toward Windows 11 bloatware just for artificial feature locking. Total dick move to hardware owners who have preference. So heres my fix.

## 🚀 How to Run the Bloody Thing

1. Extract amd-win10-rebar-fix-run-as-admin.bat from the release zip to anywhere on your pc
2. Right-click the file and select **Run as Administrator** (Windows will throw a fit if you don't give it admin tokens).
3. The live logger screen will spit out verification receipts for all six optimization blocks before creating the silent background clone.
4. **Reboot your system immediately** to let the graphics hardware scheduler, network stack, and kernel registry hooks successfully bind.

# AMD RDNA Master Kernel & Hardware Performance Injector
### Automated Windows 10 Pro Performance Restoration & Latency Optimization Suite
# !THIS SCRIPT ONLY AFFECTS GPU FOCUSED REGISTRY FILES SPECIFICALLY FOR AMD GPUS ON WINDOWS 10!

## ⚡ What This Script Actually Does

### Redundant Repository & Silent Canary Monitor
* **Self-Cloning Storage Engine:** Automatically clones the script and an uninstaller script straight into `C:\AMD\Fix\` on the first run so your mates can't accidentally delete it.
* **Automated Update Correction System:** Deploys a hidden, background startup automation task (`AMD-Win10-Fix`) via Windows Task Scheduler to run silently under maximum kernel authority (`NT AUTHORITY\SYSTEM`).
* **Silent Canary Monitor:** Every single boot, an invisible thread runs a sub-millisecond check via dynamic wildcard filters (`AMD*Events*`). If a recent AMD driver update has sneakily flipped the event utility back to `RUNNING`, it trips a silent alarm and re-injects your entire optimization profile. If everything is already sweet, it exits instantly to preserve CPU cycles.

### AMD External Events Utility Suppression
* **Dynamic Wildcard Interception:** Uses a `for` loop to scan the services registry, catching any of the four known naming variations AMD uses (spaces included), completely bypassing hardcoded script failures. 
* **Service Halting & Hard-Locking:** Slams the brakes on running background threads via `sc stop` and sets startup parameters to `DISABLED`. This permanently kills legacy display polling loops, which completely fixes alt-tab black screens, hotkey input lag, and sudden display refresh-rate drops.

### RDNA Architecture Tuning & Software ReBAR Handshake
* **Hardware Profile Mapping Matrix:** Loops through the master hardware class subkeys (`{4d36e968-e325-11ce-bfc1-08002be10318}`) to intercept your live AMD GPU configuration path, even if Windows tries to shuffle your card's slot location.
* **Software Resizable BAR Handshake:** Manually forces Resizable BAR software flags (`KMD_EnableReBarForLegacyASIC`, `KMD_RebarControlMode`, `KMD_RebarControlSupport`). This forces the driver engine to request wide CPU-to-VRAM address mapping, entirely bypassing the missing `amdkmpfd` filter file that AMD decoupled from the Win10 installer and mimics windows 11.
* **ULPS Deactivation:** Injects `EnableUlps=0` to shut down AMD Ultra Low Power State. This locks your GPU voltage rails open, stopping your card from dropping clocks mid-game and wrecking your ReBAR synchronization.
* **Forced Universal Shader Caching:** Locks the global shader compiler array to `ShaderCache=2` to force the driver to keep shader compilation universally active, completely eradicating sudden micro-stutters and hitching when entering heavy game zones.
* **Micro-Sleep Core Drops Disabled:** Overrides Display Stream Compression deep sleep states (`StutterMode=0`, `DisableDscDeepSleep=1`) to stop your compute units from downclocking during lighter rendering scenes.
* **Frame Latency Alignment:** Syncs engine frame latency (`MainFrameLatency=1`) symmetrically with the hardware scheduling core.

### Hardware-Accelerated GPU Scheduling (HWSCH / HAGS)
* **Hardware Scheduling Enforcer:** Forces Windows Graphics Drivers into mode `2` (`HwSchMode=2`). This completely offloads thread allocation queues from your CPU and hands frame scheduling straight to the dedicated hardware processor on your graphics card for maximum performance.

###: Multi-Plane Overlay (MPO) Annihilation
* **DWM Overlay Test Override:** Injects `OverlayTestMode=5` into the Desktop Window Manager to completely blow Windows Multi-Plane Overlay scaling out of existence. This is the ultimate, definitive fix for desktop flickering, Chromium browser stuttering, and Discord hardware-acceleration lag.

### Core OS Driver Recovery & Network Optimizations
* **TDR Extension Parameters:** Extends Timeout Detection and Recovery values (`TdrDelay=10`, `TdrDdiDelay=10`) from 2 seconds to 10 seconds. Windows will actually wait for heavy shader caching loops to finish instead of throwing a total tantrum and crashing your game straight back to the desktop.
* **Hybrid Fast Startup Termination:** Disables `HiberbootEnabled=0` to stop Windows from hibernating dirty kernel states on shutdown, making sure a clean registry map loads on every cold boot.
* **Multimedia Network Throttling Elimination:** Adjusts `NetworkThrottlingIndex` to the absolute maximum integer (`4294967295`) to terminate the Windows multimedia network streaming throttle limit, allowing raw, uninterrupted packet priority for lower competitive online ping jitter.
* **GameDVR Hook Blocks:** Disables Xbox background recording hooks (`AllowGameDVR=0`) to claw back lost memory bandwidth.

### Safety-Hardened Take Ownership Context Extensions
* **Universal Owner Rights Mapping:** Deploys file, directory, and drive right-click extensions using the universal language-agnostic security identifier (`*S-1-3-4:F`), completely avoiding hardcoded text string path bugs.
* **Advanced Query Syntax (AQS) Guardrails:** Implements an explicit exclusion script block (`"AppliesTo"="NOT..."`). The right-click context option is automatically hidden when interacting with your main C-drive root or critical folders like `C:\Windows`, `System32`, `Program Files`, `Program Files (x86)`, `C:\Users`, or `C:\ProgramData`. This makes it completely foolproof so you or your mates can't accidentally brick the entire operating system with a bad click.

---
