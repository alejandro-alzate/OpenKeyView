@echo off
echo Starting the server app...
start /min KeystrokeServer.exe
echo *Don't touch the keyboard or mouse before okw is opened*
echo since this spams the server and gets DoS'ed making it
echo eating 99% of your cpu makin the pc laggy and very
echo unresposive for about a second or two before the
echo task management catch it and makes it crash 
echo I dont really know how to fix it and its cringy and lame
echo that i had to put a note about it in here.
timeout /t 3
"C:\Program Files\LOVE\love.exe" .\
cls
echo All components running if you see this you can close this window.
exit /b