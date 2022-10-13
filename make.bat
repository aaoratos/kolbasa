@echo off

if not exist rsrc.rc goto over1
\masm32\bin\rc /v rsrc.rc
\masm32\bin\cvtres /machine:ix86 rsrc.res
 :over1

if exist "kolbasa.obj" del "kolbasa.obj"
if exist "kolbasa.exe" del "kolbasa.exe"

\masm32\bin\ml /c /coff "kolbasa.asm"
if errorlevel 1 goto errasm

if not exist rsrc.obj goto nores

\masm32\bin\Link /SUBSYSTEM:WINDOWS /OPT:NOREF "kolbasa.obj" rsrc.res
 if errorlevel 1 goto errlink

dir "kolbasa.*"
goto TheEnd

:nores
 \masm32\bin\Link /SUBSYSTEM:WINDOWS /OPT:NOREF "kolbasa.obj"
 if errorlevel 1 goto errlink
dir "kolbasa.*"
goto TheEnd

:errlink
 echo _
echo Link error
goto TheEnd

:errasm
 echo _
echo Assembly Error
goto TheEnd

:TheEnd

pause