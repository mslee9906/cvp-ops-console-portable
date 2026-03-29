@echo off
setlocal EnableExtensions
set "ROOT=%~dp0"
set "ENV_FILE=%ROOT%config\live.env"

if not exist "%ENV_FILE%" (
  echo Missing config\live.env
  exit /b 1
)

for /f "usebackq tokens=1,* delims==" %%A in ("%ENV_FILE%") do (
  if not "%%A"=="" (
    if /I not "%%A:~0,1%"=="#" (
      set "%%A=%%B"
    )
  )
)

set "OPS_CONSOLE_USE_MOCK=false"
set "OPS_CONSOLE_CVP_LIBRARY_ROOT=%ROOT%cloudvision-python-trunk"
set "PYTHONUTF8=1"

if not defined OPS_CONSOLE_BIND_HOST set "OPS_CONSOLE_BIND_HOST=0.0.0.0"
if not defined OPS_CONSOLE_BIND_PORT set "OPS_CONSOLE_BIND_PORT=8000"

pushd "%ROOT%"
"%ROOT%python\python.exe" -m uvicorn app.main:app --app-dir "%ROOT%backend" --host %OPS_CONSOLE_BIND_HOST% --port %OPS_CONSOLE_BIND_PORT%
popd

endlocal
