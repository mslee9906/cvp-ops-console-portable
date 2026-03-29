@echo off
setlocal EnableExtensions
set "ROOT=%~dp0"
set "OPS_CONSOLE_USE_MOCK=true"
set "OPS_CONSOLE_CVP_LIBRARY_ROOT=%ROOT%cloudvision-python-trunk"
set "PYTHONUTF8=1"

if not defined OPS_CONSOLE_BIND_HOST set "OPS_CONSOLE_BIND_HOST=127.0.0.1"
if not defined OPS_CONSOLE_BIND_PORT set "OPS_CONSOLE_BIND_PORT=8000"

pushd "%ROOT%"
"%ROOT%python\python.exe" -m uvicorn app.main:app --app-dir "%ROOT%backend" --host %OPS_CONSOLE_BIND_HOST% --port %OPS_CONSOLE_BIND_PORT%
popd

endlocal
