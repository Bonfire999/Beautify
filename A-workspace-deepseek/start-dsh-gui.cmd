@echo off
setlocal
title DSH GUI - DeepSeek Harness Web
cd /d "%~dp0"

echo ============================================================
echo   DeepSeek Harness Web GUI
echo   URL : http://127.0.0.1:3080
echo   Stop: press Ctrl+C in this window
echo ============================================================
echo.

rem --- already running? then just open the browser ---
powershell -NoProfile -WindowStyle Hidden -Command "$c=New-Object Net.Sockets.TcpClient;try{$c.Connect('127.0.0.1',3080);exit 0}catch{exit 1}finally{if($c){$c.Close()}}"
if not errorlevel 1 (
    echo The Harness is already running - opening the browser...
    start "" "http://127.0.0.1:3080"
    goto :end
)

rem --- open the browser automatically once the server is up ---
start "" /b powershell -NoProfile -WindowStyle Hidden -Command "$c=$null;$n=0;while($n -lt 90){try{$c=New-Object Net.Sockets.TcpClient;$c.Connect('127.0.0.1',3080);Start-Process 'http://127.0.0.1:3080';break}catch{Start-Sleep -Seconds 1;$n++}finally{if($c){$c.Close()}}}"

rem --- launch the harness web server ---
rem Node.js is at D:\node, dsh is in the npm global bin
set "PATH=D:\node;C:\Users\PYH\AppData\Roaming\npm;%PATH%"

call dsh web
if errorlevel 1 (
    echo.
    echo [dsh failed] trying npx fallback...
    call npx @deepseek-ai/dsh web
)

:end
echo.
echo Press any key to close this window.
pause
