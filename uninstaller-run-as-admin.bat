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
echo   RUNNING AMD MASTER PERFORMANCE SUITE - COMPLETE SYSTEM UNINSTALLER TOOL  
echo =============================================================================
echo.

:: 1. Purge Windows Task Scheduler Automation Engine
echo [1/6] Deleting Automated Update Correction System boot task...
schtasks /delete /tn "AMD-Win10-Fix" /f 2>&1
echo [+] Automation boot engine successfully removed from system.
echo.

:: 2. Revert RDNA Registry Framework and Re-enable AMD Event Services
echo [2/6] Restoring AMD driver defaults and re-enabling Event Utility...
set "BaseKey=HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}"

for /f "tokens=*" %%K in ('reg query "%BaseKey%" /f "00*" /k 2^>nul') do (
    reg query "%%K" /v "ProviderName" 2>nul | findstr /i "Advanced Micro Devices AMD" >nul    
    if !errorlevel! equ 0 (
        :: Purge custom ReBAR software configuration entries
        reg delete "%%K" /v "KMD_EnableReBarForLegacyASIC" /f >nul 2>&1
        reg delete "%%K" /v "KMD_RebarControlMode" /t REG_DWORD /d 1 /f >nul 2>&1
        reg delete "%%K" /v "KMD_RebarControlSupport" /t REG_DWORD /d 1 /f >nul 2>&1
        
        :: Reset ULPS back to factory standard (Enabled)
        reg add "%%K" /v "EnableUlps" /t REG_DWORD /d 1 /f
        
        :: Reset AMD Driver Shader Cache back to standard automatic optimization mode
        reg add "%%K" /v "ShaderCache" /t REG_DWORD /d 0 /f
        
        :: Clear core power optimization registers
        reg delete "%%K" /v "StutterMode" /f >nul 2>&1
        reg delete "%%K" /v "DisableDscDeepSleep" /f >nul 2>&1
        reg delete "%%K" /v "MainFrameLatency" /f >nul 2>&1
    )
)

:: Restore AMD Event Service states natively found via query filters
for /f "tokens=5 delims=\" %%S in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /f "AMD*Events*" /k 2^>nul') do (
    sc config "%%S" start= auto
    sc start "%%S"
)
echo [+] AMD RDNA hardware configuration profiles restored to vanilla stock.
echo.

:: 3. Revert Hardware-Accelerated GPU Scheduling (HAGS)
echo [3/6] Restoring default Windows Graphics Scheduling parameters...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /t REG_DWORD /d 1 /f
echo.

:: 4. Re-enable Multi-Plane Overlay (MPO)
echo [4/6] Restoring Multi-Plane Overlay (MPO) desktop configuration matrix...
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /f 2>&1
echo.

:: 5. Revert Core OS Settings, GameDVR, and Network Priority Engines
echo [5/6] Restoring factory default Core OS network and recovery thresholds...
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDelay" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "TdrDdiDelay" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v "HiberbootEnabled" /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d 10 /f
reg delete "HKEY_CLASSES_ROOT\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /f >nul 2>&1
echo.

:: 6. Wipe Take Ownership Context Extensions & Clean Safe Storage Repository
echo [6/6] Purging Take Ownership Shell extensions and wiping safe storage cache...
reg delete "HKEY_CLASSES_ROOT\*\shell\TakeOwnership" /f 2>&1
reg delete "HKEY_CLASSES_ROOT\*\shell\runas" /f 2>&1
reg delete "HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership" /f 2>&1
reg delete "HKEY_CLASSES_ROOT\Drive\shell\runas" /f 2>&1
echo.

echo =================================================================
echo   		ALL SETTINGS SYSTEMATICALLY RESTORED TO STOCK!
echo =================================================================
echo.
echo [+] UNINSTALL CLEANUP LIST SUMMARY:
echo -----------------------------------------------------------------
echo  [-] Automated Update Correction System boot task terminated.
echo  [-] AMD hardware profile power maps reverted to factory standard.
echo  [-] AMD External Events Utility startup flags unlocked and started.
echo  [-] Windows Hardware-Accelerated GPU Scheduling set to stock.
echo  [-] Desktop Window Manager MPO structural rendering re-enabled.
echo  [-] Kernel Timeout Detection and Recovery (TDR) safety bounds reset.
echo  [-] Windows Hybrid Fast Startup hibernation re-enabled.
echo  [-] Network Throttling Index priority allocation normalized.
echo  [-] Xbox GameDVR background tracking processes unblocked.
echo  [-] Take Ownership Right-Click context menus completely uninstalled.
echo -----------------------------------------------------------------
echo.
echo Self-destruction pipeline engaged... Cleaning safe local repository storage folder...
rmdir /s /q "C:\AMD\Fix" >nul 2>&1
echo.
echo Please REBOOT your system immediately to finalize the rollback configuration.
echo Press any key to exit...
echo =================================================================
echo.
pause >nul
exit
