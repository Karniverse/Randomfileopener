@echo off
setlocal enabledelayedexpansion

:Start
:: Seed the random generator with the milliseconds from the time
for /F "tokens=2 delims==." %%G in ('echo %time%') do set /a "SEED=%%G"
set /a "RANDOM=%RANDOM% + SEED"

:: Count the number of files in the current directory, excluding directories
set /a COUNT=0
for /f %%x in ('dir /b /a-d') do set /a COUNT+=1

:: Check if there are files in the directory
if %COUNT% lss 1 (
    echo No files found in the directory.
    goto :eof
)

:: Generate a random number within the range of 1 to COUNT
set /a RAND=(%RANDOM% %% COUNT) + 1

:: Get the random file
set /a INDEX=0
set "RANDOMFILE="
for /f "delims=" %%f in ('dir /b /a-d') do (
    set /a INDEX+=1
    if !INDEX! equ !RAND! (
        set "RANDOMFILE=%%f"
    )
)

:: Validate the RANDOMFILE variable
if not defined RANDOMFILE (
    echo Failed to select a valid file, retrying...
    goto Start
)

:: Verify it's not a directory just in case
if exist "%RANDOMFILE%\" (
    echo Error: Selected item is a directory, not a file.
    goto Start
)

:: Debug: Output the selected file
echo Selected file: %RANDOMFILE%

:: Open the random file and wait for the application to close
start "" /wait "%RANDOMFILE%"

endlocal
