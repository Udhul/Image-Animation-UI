@echo off

set venv_default=%cd%\.venv
set repository_default=%cd%\Thin-Plate-Spline-Motion-Model-main

REM Parse named arguments
setlocal enabledelayedexpansion
for %%i in (%*) do (
  set arg=%%i
  if "!arg:~0,1!" == "-" (
    set name=!arg:~1!
    set value=
  ) else (
    set value=!arg!
    if defined name (
      set "arg_!name!=!value!"
      set "name="
    )
  )
)

REM For debugging: Show parsed arguments
echo arg_venv: !arg_venv!
echo arg_repository: !arg_repository!

REM Set the virtual environment location from the argument, or use the default value
if defined arg_venv (
  set venv_location=!arg_venv:"=!
  echo Using specified virtual environment location: !venv_location!
) else (
  set venv_location=!venv_default!
  echo Using default virtual environment location: !venv_location!
)

REM Set the repository location from the argument, or use the default value
if defined arg_repository (
  set repository_location=!arg_repository!
) else (
  set repository_location=!repository_default!
)

REM Check if Python 3.9 is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
  echo Python 3.9 is not installed. Please install it and try again.
  exit /b 1
)

REM Check if pip is installed
pip --version >nul 2>&1
if %errorlevel% neq 0 (
  echo pip is not installed. Please install it and try again.
  exit /b 1
)

REM Check if the repository is already cloned
if not exist "%repository_location%\.git" (
  echo Cloning repository...
  git clone https://github.com/yoyo-nb/Thin-Plate-Spline-Motion-Model.git "%repository_location%"
) else (
  echo Repository is already cloned.
)

REM Check if the virtual environment already exists
if not exist "%venv_location%\Scripts\activate.bat" (
  echo Creating virtual environment...
  py -3.9 -m venv "%venv_location%"
) else (
  echo Virtual environment already exists.
)


echo venv_location is: %venv_location%\Scripts\activate.bat
echo repository_location is: %repository_location%

REM Activate the virtual environment
call %venv_location%\Scripts\activate.bat

REM Run the script
python webui.py
