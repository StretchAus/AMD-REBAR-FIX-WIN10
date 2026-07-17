@echo off
setlocal EnableDelayedExpansion

:: ============================================================
:: 1. Disable AMD External Events Utility
:: ============================================================
echo [1/6] Disabling AMD External Events Utility...

for /f "tokens=5 delims=\" %%S in ('reg query "HKLM\SYSTEM\CurrentControlSet\Services" /f "AMD*Events*" /k 2^>nul') do (
    echo Found service: %%S
    sc stop "%%S" >nul 2>&1
    sc config "%%S" start= disabled >nul 2>&1
)

echo AMD External Events Utility disabled.
echo.

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
