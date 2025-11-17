@echo off
echo Running Assembly code...
echo.

REM Assemble the file
echo Assembling %1.asm...
masm %1.asm;

REM Link the object file
echo Linking %1.obj...
link %1.obj;

REM Run the executable
echo Running %1.exe...
echo.
%1.exe

echo.
echo Done!
pause