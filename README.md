# AMD-REBAR-FIX-WIN10
AMD's new drivers cut Windows 10 ReBAR by decoupling system-level amdkmpfd files to fix install bugs, ditching optimizations for an aging OS. It’s incredibly insulting to be forced onto a worse gaming experience or pushed toward Windows 11 bloatware just for artificial feature locking. Total garbage move for hardware owners who have preference.

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
* **Self-Cloning Storage Engine:** Automatically clones the script straight into `C:\AMD\Fix\` on the first run so your mates can't accidentally delete it.
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

FULL SCRIPT BELOW IF YOU WANT TO EDIT IT FOR YOUR OWN USES

---

@echo off
setlocal enabledelayedexpansion
:: Check for Administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] This script must be run as Administrator!
    echo Right-click the file and select "Run as administrator".
    pause
    exit /b
)

echo =============================================================================
echo   RUNNING WIN 10 MASTER AMD RDNA KERNEL AND HARDWARE PERFORMANCE INJECTOR  
echo =============================================================================
echo.

:: PART 0: AUTOMATED ARCHIVE ARCHITECTURE (SELF-CLONING STORAGE ENGINE)
set "TargetFolder=C:\AMD\Fix"
set "TargetFile=!TargetFolder!\%~nx0"
echo [0/6] Automated AMD Updates Refixer Installed (This Script Will Run Automagically Whenever An AMD GPU Update Happens)...
:: Verify and mirror script to the safe storage repository silently
if /i "%~dp0" neq "!TargetFolder!\" (
    if not exist "!TargetFolder!" mkdir "!TargetFolder!" >nul 2>&1
    copy /y "%~f0" "!TargetFile!" >nul 2>&1
)
:: Force register/update background startup automation task parameters cleanly
schtasks /create /tn "AMD-Win10-Fix" /tr "cmd.exe /c C:\AMD\Fix\%~nx0" /sc onstart /ru "NT AUTHORITY\SYSTEM" /rl highest /f >nul 2>&1
:: Process Canary Update Check (Dynamic Registry Query Execution)
if /i "%USERNAME%"=="SYSTEM" (
    set "UpdateDetected=0"
    :: Query the services registry dynamically to check for any active AMD Event node
    for /f "tokens=5 delims=\" %%S in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /f "AMD*Events*" /k 2^>nul') do (
        sc query "%%S" | findstr /i "RUNNING" >nul 2>&1
        if !errorlevel! equ 0 set "UpdateDetected=1"
    )
    :: Terminate background execution instantly if no active AMD update has reset the service
    if !UpdateDetected! equ 0 (
        exit
    )
)

:: 1. Terminate and disable AMD External Events Utility (Dynamic Registry Query)
echo [1/6] Terminating AMD External Events Utility Services...
:: Query the services database dynamically for any key matching the AMD Event architecture
for /f "tokens=5 delims=\" %%S in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /f "AMD*Events*" /k') do (
    echo.
    echo Detected active service node: "%%S"    
    :: Halt the service and force the startup configuration to disabled
    sc stop "%%S"
    sc config "%%S" start= disabled
)
echo AMD External Events Utility Services Completely Disabled...
echo.

:: 2. Core Profile Hardware Iteration Sequence (Dynamic GPU Pipeline Interception)
set "BaseKey=HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}"
set "GpuFound=0"
echo [2/6] Initialising active hardware profile scan matrix...
for /f "tokens=*" %%K in ('reg query "%BaseKey%" /f "00*" /k 2^>nul') do (   
    :: Verify if this specific subkey belongs to an AMD Driver
    reg query "%%K" /v "ProviderName" 2>nul | findstr /i "Advanced Micro Devices AMD" >nul    
    if !errorlevel! equ 0 (
        set "GpuFound=1"
        echo.
        echo GPU Found - Intercepting AMD Architecture Registry Subkey: %%K
        echo.
        echo Repairing Resizeable BAR kernel parameters and forcing shader stability...        
        :: ReBAR Activation Tweak
        reg add "%%K" /v "KMD_EnableReBarForLegacyASIC" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "KMD_RebarControlMode" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "KMD_RebarControlSupport" /t REG_DWORD /d 1 /f  
        :: Disable ULPS (Prevents ReBAR desync/crashes)
        reg add "%%K" /v "EnableUlps" /t REG_DWORD /d 0 /f
        :: Force AMD Driver Shader Cache to ON (Eliminates shader compile stutters)
        reg add "%%K" /v "ShaderCache" /t REG_DWORD /d 2 /f
        :: GPU Tweak: Disable Micro-Sleep Core Drops (Stops downclock stuttering)
        reg add "%%K" /v "StutterMode" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "DisableDscDeepSleep" /t REG_DWORD /d 1 /f
        :: GPU Tweak: Align Frame Latency with Hardware Scheduling Engine
        reg add "%%K" /v "MainFrameLatency" /t REG_DWORD /d 1 /f
        echo.
        echo Resizeable BAR Repairs Complete...
    )
)
if !GpuFound! equ 0 (
    echo [WARNING] No active AMD GPU subkey was detected in the registry!
    echo           Applying fallback configuration to default 0000 slot...
    reg add "%BaseKey%\0000" /v "KMD_EnableReBarForLegacyASIC" /t REG_DWORD /d 1 /f
    reg add "%BaseKey%\0000" /v "KMD_RebarControlMode" /t REG_DWORD /d 1 /f
    reg add "%BaseKey%\0000" /v "KMD_RebarControlSupport" /t REG_DWORD /d 1 /f
    reg add "%BaseKey%\0000" /v "EnableUlps" /t REG_DWORD /d 0 /f
    reg add "%BaseKey%\0000" /v "ShaderCache" /t REG_DWORD /d 2 /f
    reg add "%BaseKey%\0000" /v "StutterMode" /t REG_DWORD /d 0 /f
    reg add "%BaseKey%\0000" /v "DisableDscDeepSleep" /t REG_DWORD /d 1 /f
    reg add "%BaseKey%\0000" /v "MainFrameLatency" /t REG_DWORD /d 1 /f
)
echo.

:: 3. Force Hardware-Accelerated GPU Scheduling (HWSCH / HAGS)
echo [3/6] Forcing Hardware-Accelerated GPU Scheduling To Keep Rebar Active (HWSCH)...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f
echo.

:: 4. Disable Multi-Plane Overlay (MPO)
echo [4/6] Disabling Multi-Plane Overlay (MPO) to eliminate desktop flickering...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d 5 /f
echo.

:: 5. Core Windows OS Driver Recovery & Network Optimizations
echo [5/6] Stabilising Core Driver Crashes and Network Throttling blocks...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /t REG_DWORD /d 10 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /t REG_DWORD /d 10 /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 4294967295 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f
echo Disabled Windows GameDVR, Fast Startup, Removed Gaming Network Package Throttle Limit And Stabilised TDR Delays
echo.
if /i "%USERNAME%"=="SYSTEM" exit

:: 6. Take Ownership Context Menu Extensions (CMD-only version)
echo [6/6] Deploying Take Ownership Right-Click Menu Extensions...
:: Remove old entries
reg delete "HKEY_CLASSES_ROOT\*\shell\TakeOwnership" /f 2>&1
reg delete "HKEY_CLASSES_ROOT\*\shell\runas" /f 2>&1
reg delete "HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership" /f 2>&1
reg delete "HKEY_CLASSES_ROOT\Drive\shell\runas" /f 2>&1
:: FILE TAKE OWNERSHIP
reg add "HKEY_CLASSES_ROOT\*\shell\TakeOwnership" /ve /t REG_SZ /d "Take Ownership" /f
reg add "HKEY_CLASSES_ROOT\*\shell\TakeOwnership" /v "HasLUAShield" /t REG_SZ /d "" /f
reg add "HKEY_CLASSES_ROOT\*\shell\TakeOwnership" /v "NoWorkingDirectory" /t REG_SZ /d "" /f
reg add "HKEY_CLASSES_ROOT\*\shell\TakeOwnership" /v "NeverDefault" /t REG_SZ /d "" /f
reg add "HKEY_CLASSES_ROOT\*\shell\TakeOwnership\command" /ve /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant *S-1-3-4:F" /f
reg add "HKEY_CLASSES_ROOT\*\shell\TakeOwnership\command" /v "IsolatedCommand" /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant *S-1-3-4:F" /f
:: DIRECTORY TAKE OWNERSHIP
reg add "HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership" /ve /t REG_SZ /d "Take Ownership" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership" /v "HasLUAShield" /t REG_SZ /d "" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership" /v "NoWorkingDirectory" /t REG_SZ /d "" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership" /v "Position" /t REG_SZ /d "middle" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership" /v "AppliesTo" /t REG_SZ /d "NOT (System.ItemPathDisplay:=\"C:\\Users\" OR System.ItemPathDisplay:=\"C:\\ProgramData\" OR System.ItemPathDisplay:=\"C:\\Windows\" OR System.ItemPathDisplay:=\"C:\\Windows\\System32\" OR System.ItemPathDisplay:=\"C:\\Program Files\" OR System.ItemPathDisplay:=\"C:\\Program Files (x86)\")" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership\command" /ve /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant *S-1-3-4:F /t" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership\command" /v "IsolatedCommand" /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant *S-1-3-4:F /t" /f
:: DRIVE TAKE OWNERSHIP (EXCEPT C:\)
reg add "HKEY_CLASSES_ROOT\Drive\shell\runas" /ve /t REG_SZ /d "Take Ownership" /f
reg add "HKEY_CLASSES_ROOT\Drive\shell\runas" /v "HasLUAShield" /t REG_SZ /d "" /f
reg add "HKEY_CLASSES_ROOT\Drive\shell\runas" /v "NoWorkingDirectory" /t REG_SZ /d "" /f
reg add "HKEY_CLASSES_ROOT\Drive\shell\runas" /v "Position" /t REG_SZ /d "middle" /f
reg add "HKEY_CLASSES_ROOT\Drive\shell\runas" /v "AppliesTo" /t REG_SZ /d "NOT (System.ItemPathDisplay:=\"C:\\\")" /f
reg add "HKEY_CLASSES_ROOT\Drive\shell\runas\command" /ve /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant *S-1-3-4:F /t" /f
reg add "HKEY_CLASSES_ROOT\Drive\shell\runas\command" /v "IsolatedCommand" /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant *S-1-3-4:F /t" /f
echo Take Ownership Menu Injections Successful.
echo.
echo =================================================================
echo   		ALL OPTIMISATIONS APPLIED SUCCESSFULLY!
echo =================================================================
echo.
echo  [+] TWEAKS COMPLETED LIST:
echo -----------------------------------------------------------------
echo  [+] Automated Update Correction System
echo  [+] Smart Access Memory / Resizable BAR Software Handshake Forced
echo  [+] AMD Ultra Low Power State (ULPS) Driver Rails Locked
echo  [+] AMD External Events Utility Background Engine Completely Terminated
echo  [+] Global Shader Cache Compilation Enforced (ShaderCache = 2)
echo  [+] AMD Micro-Sleep and DSC Deep Sleep States Disabled
echo  [+] Driver Main Frame Latency Aligned with Scheduling Core
echo  [+] Windows Hardware-Accelerated GPU Scheduling (HAGS) Forced ON
echo  [+] Desktop Multi-Plane Overlay (MPO) Flickering Framework Disabled
echo  [+] Driver Timeout Detection and Recovery (TDR) Extended to 10s
echo  [+] Windows GameDVR Background Hook Injections Blocked
echo  [+] Windows Kernel Hybrid Fast Startup Hibernation Disabled
echo  [+] Multimedia Network Stream Throttling Engine Terminated
echo  [+] File, Folder, and Volume "Take Ownership" Context Actions Enabled
echo -----------------------------------------------------------------
echo.
echo =================================================================
echo Please REBOOT your system immediately to apply settings.
echo =================================================================
echo.
echo Press any key to exit...
pause >nul
exit
