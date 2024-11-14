set FRKNPath=%~dp0
echo %FRKNPath%

"%FRKNPath%\FRKN.exe" -c
timeout /t 1
sc stop FRKN-service
sc delete FRKN-service
sc stop AmneziaWGTunnel$AmneziaVPN
sc delete AmneziaWGTunnel$AmneziaVPN
taskkill /IM "FRKN-service.exe" /F
taskkill /IM "FRKN.exe" /F
exit /b 0
