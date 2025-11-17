@echo off
echo Running Assembly code with NASM...
echo.

if "%1"=="" (
    echo Usage: run_nasm.bat filename
    echo Example: run_nasm.bat sher
    pause
    exit /b 1
)

set filename=%1

echo Assembling %filename%.asm...
".\nasm-2.16.03\nasm.exe" -f win32 %filename%.asm -o %filename%.obj

if errorlevel 1 (
    echo Assembly failed!
    pause
    exit /b 1
)

echo Linking %filename%.obj...
link /subsystem:console /entry:main %filename%.obj kernel32.lib user32.lib

if errorlevel 1 (
    echo Linking failed!
    pause
    exit /b 1
)

echo Running %filename%.exe...
%filename%.exe

echo.
echo Done!
pause