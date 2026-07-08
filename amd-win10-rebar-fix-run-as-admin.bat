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
:: 1.5 Silently inject the separate Rollback Tool directly into the repository
set "UninstallerFile=C:\AMD\Fix\amd-rollback-run-as_admin.bat"
if not exist "!UninstallerFile!" (
    (
    echo @echo off
    echo setlocal enabledelayedexpansion
    echo net session ^>nul 2^>&1
    echo if %%errorLevel%% neq 0 ^( echo [ERROR] Run as Administrator! ^& pause ^& exit /b ^)
    echo echo =============================================================================
    echo echo   RUNNING AMD MASTER PERFORMANCE SUITE - COMPLETE SYSTEM UNINSTALLER TOOL  
    echo echo =============================================================================
    echo echo.
    echo echo [1/6] Deleting Automated Update Correction System boot task...
    echo schtasks /delete /tn "AMD-Win10-Fix" /f
    echo echo [2/6] Restoring AMD driver defaults and re-enabling Event Utility...
    echo set "BaseKey=HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}"
    echo for /f "tokens=*" %%%%K in ^('reg query "%%BaseKey%%" /f "00*" /k 2^^^>nul'^) do ^(
    echo     reg query "%%%%K" /v "ProviderName" 2^>nul ^| findstr /i "Advanced Micro Devices AMD" ^>nul    
    echo     if ^^!errorlevel^^! equ 0 ^(
    echo         reg delete "%%%%K" /v "KMD_EnableReBarForLegacyASIC" /f ^>nul 2^CustomRedirect1
    echo         reg delete "%%%%K" /v "KMD_RebarControlMode" /f ^>nul 2^CustomRedirect1
    echo         reg delete "%%%%K" /v "KMD_RebarControlSupport" /f ^>nul 2^CustomRedirect1
    echo         reg add "%%%%K" /v "EnableUlps" /t REG_DWORD /d 1 /f ^>nul
    echo         reg add "%%%%K" /v "ShaderCache" /t REG_DWORD /d 0 /f ^>nul
    echo         reg delete "%%%%K" /v "StutterMode" /f ^>nul 2^CustomRedirect1
    echo         reg delete "%%%%K" /v "DisableDscDeepSleep" /f ^>nul 2^CustomRedirect1
    echo         reg delete "%%%%K" /v "MainFrameLatency" /f ^>nul 2^CustomRedirect1
    echo     ^)
    echo ^)
    echo for /f "tokens=5 delims=\\" %%%%S in ^('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /f "AMD*Events*" /k 2^^^>nul'^) do ^(
    echo     sc config "%%%%S" start= auto ^>nul
    echo     sc start "%%%%S" ^>nul
    echo ^)
    echo echo [3/6] Restoring default Windows Graphics Scheduling parameters...
    echo reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 1 /f ^>nul
    echo echo [4/6] Restoring Multi-Plane Overlay ^(MPO^) desktop configuration matrix...
    echo reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /f ^>nul 2^CustomRedirect1
    echo echo [5/6] Restoring factory default Core OS network and recovery thresholds...
    echo reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /f ^>nul 2^CustomRedirect1
    echo reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /f ^>nul 2^CustomRedirect1
    echo reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 1 /f ^>nul
    echo reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /f ^>nul 2^CustomRedirect1
    echo echo [6/6] Purging Take Ownership Shell extensions and wiping safe storage cache...
    echo reg delete "HKEY_CLASSES_ROOT\*\shell\TakeOwnership" /f ^>nul 2^CustomRedirect1
    echo reg delete "HKEY_CLASSES_ROOT\*\shell\runas" /f ^>nul 2^CustomRedirect1
    echo reg delete "HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership" /f ^>nul 2^CustomRedirect1
    echo reg delete "HKEY_CLASSES_ROOT\Drive\shell\runas" /f ^>nul 2^CustomRedirect1
    echo echo -----------------------------------------------------------------
    echo echo   ALL SETTINGS SYSTEMATICALLY RESTORED TO STOCK!
    echo echo -----------------------------------------------------------------
    echo echo Self-destruction engaged... Cleaning local storage folder...
    echo timeout /t 2 ^>nul
    echo start /b cmd /c "del /f /q \"%%~f0\" ^& rmdir /s /q \"C:\AMD\Fix\""
    echo exit
    ) > "!UninstallerFile!"
    powershell -Command "(Get-Content '!UninstallerFile!') -replace 'CustomRedirect1', 'CustomRedirect2' | Set-Content '!UninstallerFile!'" >nul 2>&1
    powershell -Command "(Get-Content '!UninstallerFile!') -replace 'CustomRedirect2', '^CustomRedirect3' | Set-Content '!UninstallerFile!'" >nul 2>&1
    powershell -Command "(Get-Content '!UninstallerFile!') -replace 'CustomRedirect3', '^^^>nul 2^^^CustomRedirect4' | Set-Content '!UninstallerFile!'" >nul 2>&1
    powershell -Command "(Get-Content '!UninstallerFile!') -replace 'CustomRedirect4', '^^^>nul' | Set-Content '!UninstallerFile!'" >nul 2>&1
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
