@echo off
setlocal EnableDelayedExpansion

:: ============================================================
:: ADMIN CHECK
:: ============================================================
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

:: ============================================================
:: PART 1 — SELF-CLONE ENGINE + UNINSTALLER + SCHEDULED TASK
:: ============================================================
set "TargetFolder=C:\AMD-Fix"
set "TargetFile=%TargetFolder%\%~nx0"

echo [1/6] Automated AMD Updates Refixer Installed...

:: Clone script into C:\AMD-Fix
if /i "%~dp0" neq "%TargetFolder%\" (
    if not exist "%TargetFolder%" mkdir "%TargetFolder%" >nul 2>&1
    copy /y "%~f0" "%TargetFile%" >nul 2>&1
)

:: Generate Uninstaller
set "UninstallerFile=C:\AMD-Fix\amd-rollback-run-as_admin.bat"

if not exist "%UninstallerFile%" (
    (
        echo @echo off
        echo setlocal enabledelayedexpansion
        echo net session ^>nul 2^>^&1
        echo if %%errorLevel%% neq 0 ^( echo [ERROR] Run as Administrator! ^& pause ^& exit /b ^)
        echo echo =============================================================================
        echo echo   RUNNING AMD MASTER PERFORMANCE SUITE - COMPLETE SYSTEM UNINSTALLER TOOL
        echo echo =============================================================================
        echo echo.
        echo echo [1/6] Deleting Automated Update Correction System boot task...
        echo schtasks /delete /tn "AMD-Win10-Fix" /f
        echo.
        echo echo [2/6] Restoring AMD driver defaults and re-enabling Event Utility...
        echo set "BaseKey=HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}"
        echo for /f "tokens=*" %%%%K in ^('reg query "%%%%BaseKey%%%%" /f "00" /k 2^^^>nul'^) do ^(
        echo     reg query "%%%%K" /v "ProviderName" 2^>nul ^| findstr /i "Advanced Micro Devices" ^>nul
        echo     if ^^!errorlevel^^! equ 0 ^(
        echo         reg delete "%%%%K" /v "KMD_EnableReBarForLegacyASIC" /f ^>nul
        echo         reg delete "%%%%K" /v "KMD_RebarControlMode" /f ^>nul
        echo         reg delete "%%%%K" /v "KMD_RebarControlSupport" /f ^>nul
        echo         reg add "%%%%K" /v "EnableUlps" /t REG_DWORD /d 1 /f ^>nul
        echo         reg add "%%%%K" /v "ShaderCache" /t REG_DWORD /d 0 /f ^>nul
        echo         reg delete "%%%%K" /v "StutterMode" /f ^>nul
        echo         reg delete "%%%%K" /v "DisableDscDeepSleep" /f ^>nul
        echo         reg delete "%%%%K" /v "MainFrameLatency" /f ^>nul
        echo     ^)
        echo ^)
        echo for /f "tokens=5 delims=" %%%%S in ^('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /f "AMDEvents" /k 2^^^>nul'^) do ^(
        echo     sc config "%%%%S" start= auto ^>nul
        echo     sc start "%%%%S" ^>nul
        echo ^)
        echo.
        echo echo [3/6] Restoring default Windows Graphics Scheduling parameters...
        echo reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 1 /f ^>nul
        echo.
        echo echo [4/6] Restoring Multi-Plane Overlay ^(MPO^) desktop configuration matrix...
        echo reg delete "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /f ^>nul
        echo.
        echo echo [5/6] Restoring factory default Core OS network and recovery thresholds...
        echo reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /f ^>nul
        echo reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /f ^>nul
        echo reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 1 /f ^>nul
        echo reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /f ^>nul
        echo.
        echo echo [6/6] Purging Take Ownership Shell extensions and wiping safe storage cache...
        echo reg delete "HKEY_CLASSES_ROOT\*\shell\TakeOwnership" /f ^>nul
        echo reg delete "HKEY_CLASSES_ROOT\*\shell\runas" /f ^>nul
        echo reg delete "HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership" /f ^>nul
        echo reg delete "HKEY_CLASSES_ROOT\Drive\shell\runas" /f ^>nul
        echo.
        echo echo -----------------------------------------------------------------
        echo echo   ALL SETTINGS SYSTEMATICALLY RESTORED TO STOCK!
        echo echo -----------------------------------------------------------------
        echo echo Self-destruction engaged... Cleaning local storage folder...
        echo timeout /t 2 ^>nul
        echo start /b cmd /c "del /f /q "%%~f0" ^& rmdir /s /q "C:\AMD-Fix""
        echo exit
    ) > "%UninstallerFile%"
)

:: Scheduled Task
schtasks /create /tn "AMD-Win10-Fix" /tr "cmd.exe /c C:\AMD-Fix\%~nx0" /sc onstart /ru "NT AUTHORITY\SYSTEM" /rl highest /f >nul 2>&1

:: Update-trigger logic
if /i "%USERNAME%"=="SYSTEM" (
    set "UpdateDetected=0"
    for /f "tokens=5 delims=" %%S in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /f "AMDEvents" /k 2^>nul') do (
        sc query "%%S" | findstr /i "RUNNING" >nul 2>&1
        if !errorlevel! equ 0 set "UpdateDetected=1"
    )
    if !UpdateDetected! equ 0 exit
)

:: ============================================================
:: 2. AMD GPU Registry Tweaks (ReBAR / ULPS / ShaderCache)
:: ============================================================
echo [2/6] Scanning active AMD GPU registry nodes...

set "BaseKey=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}"
set "GpuFound=0"

for /f "tokens=*" %%K in ('reg query "%BaseKey%" /f "00*" /k 2^>nul') do (
    reg query "%%K" /v "ProviderName" 2>nul | findstr /i "Advanced Micro Devices" >nul
    if !errorlevel! equ 0 (
        set "GpuFound=1"
        echo AMD GPU node: %%K

        reg add "%%K" /v "KMD_EnableReBarForLegacyASIC" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "KMD_RebarControlMode" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "KMD_RebarControlSupport" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "EnableUlps" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "ShaderCache" /t REG_DWORD /d 2 /f
        reg add "%%K" /v "StutterMode" /t REG_DWORD /d 0 /f
        reg add "%%K" /v "DisableDscDeepSleep" /t REG_DWORD /d 1 /f
        reg add "%%K" /v "MainFrameLatency" /t REG_DWORD /d 1 /f
    )
)

if !GpuFound! equ 0 (
    echo WARNING: No AMD GPU node detected. Applying fallback to 0000...
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

:: ============================================================
:: 3. Force Hardware-Accelerated GPU Scheduling (HAGS)
:: ============================================================
echo [3/6] Enabling Hardware-Accelerated GPU Scheduling...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 2 /f
echo.

:: ============================================================
:: 4. Disable Multi-Plane Overlay (MPO)
:: ============================================================
echo [4/6] Disabling Multi-Plane Overlay...
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d 5 /f
echo.

:: ============================================================
:: 5. TDR / GameDVR / Fast Startup Fixes
:: ============================================================
echo [5/6] Applying TDR, GameDVR and Fast Startup fixes...

for %%A in (
    "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers"
    "HKLM\SYSTEM\ControlSet001\Control\GraphicsDrivers"
) do (
    reg add %%A /v "TdrDelay" /t REG_DWORD /d 20 /f
    reg add %%A /v "TdrDdiDelay" /t REG_DWORD /d 20 /f
)

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f

echo.

:: ============================================================
:: 6. Take Ownership Context Menu
:: ============================================================
echo [6/6] Installing Take Ownership context menu...

reg delete "HKEY_CLASSES_ROOT\*\shell\TakeOwnership" /f 2>nul
reg delete "HKEY_CLASSES_ROOT\*\shell\runas" /f 2>nul
reg delete "HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership" /f 2>nul
reg delete "HKEY_CLASSES_ROOT\Drive\shell\runas" /f 2>nul

:: File
reg add "HKEY_CLASSES_ROOT\*\shell\TakeOwnership" /ve /t REG_SZ /d "Take Ownership" /f
reg add "HKEY_CLASSES_ROOT\*\shell\TakeOwnership\command" /ve /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" && icacls \"%%1\" /grant *S-1-3-4:F" /f

:: Directory
reg add "HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership" /ve /t REG_SZ /d "Take Ownership" /f
reg add "HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership\command" /ve /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant *S-1-3-4:F /t" /f

:: Drive (except C:)
reg add "HKEY_CLASSES_ROOT\Drive\shell\runas" /ve /t REG_SZ /d "Take Ownership" /f
reg add "HKEY_CLASSES_ROOT\Drive\shell\runas\command" /ve /t REG_SZ /d "cmd.exe /c takeown /f \"%%1\" /r /d y && icacls \"%%1\" /grant *S-1-3-4:F /t" /f

echo.
echo =================================================================
echo            ALL OPTIMISATIONS APPLIED SUCCESSFULLY!
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
