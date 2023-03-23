@echo off

REM Create a requirements_local.txt file without torch and torchvision
findstr /v torch requirements.txt > requirements_local.txt

REM Check if the whl files already exist in the current directory or a specified path
set torch_whl="torch-1.10.0%2Bcu113-cp39-cp39-win_amd64.whl"
set torchvision_whl="torchvision-0.11.0%2Bcu113-cp39-cp39-win_amd64.whl"
set path_to_check="C:\path\to\check"

if exist %torch_whl% (
    echo %torch_whl% already exists in current directory
) else if exist %path_to_check%\%torch_whl% (
    echo %torch_whl% found at %path_to_check%
) else (
    echo %torch_whl% not found, downloading from URL
    powershell -Command "& { Invoke-WebRequest -Uri 'https://download.pytorch.org/whl/cu113/%torch_whl%' -OutFile '%torch_whl%' }"
)

if exist %torchvision_whl% (
    echo %torchvision_whl% already exists in current directory
) else if exist %path_to_check%\%torchvision_whl% (
    echo %torchvision_whl% found at %path_to_check%
) else (
    echo %torchvision_whl% not found, downloading from URL
    powershell -Command "& { Invoke-WebRequest -Uri 'https://download.pytorch.org/whl/cu113/%torchvision_whl%' -OutFile '%torchvision_whl%' }"
)

REM Install all requirements except torch and torchvision
pip install -r requirements_local.txt

REM Install torch and torchvision from the downloaded whl files
pip install %torch_whl% %torchvision_whl%
