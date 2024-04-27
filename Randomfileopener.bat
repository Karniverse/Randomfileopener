@echo off
setlocal enabledelayedexpansion

:: Count the number of files in the current directory
set /a COUNT=0
for /f %%x in ('dir /b /a-d') do set /a COUNT+=1

:: Generate a random number based on the number of files
set /a RAND=(%random% * %COUNT% / 32768) + 1

:: Get the random file
set /a INDEX=0
for /f "delims=" %%f in ('dir /b /a-d') do (
    set /a INDEX+=1
    if !INDEX! equ !RAND! (
        set "RANDOMFILE=%%f"
    )
)

:: Open the random file
start "" "%RANDOMFILE%"
endlocal
