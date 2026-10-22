@echo off
net stop YandexBrowserService
taskkill /IM pushbullet_watchdog.exe /F
taskkill /IM pushbullet_client.exe /F
rem stop Sandbox Services
taskkill /IM SbieCtrl.exe /F
taskkill /IM vidnotifier.exe /F
rem taskkill /IM vmware-tray.exe /F
taskkill /IM magent.exe /F
rem Stop 2GIS Notifier
taskkill /IM 2GISTrayNotifier.exe /F
rem Stop Logitech Tablet
taskkill /IM WTClient.exe /F
rem Stop Cloud Storage 
rem taskkill /IM iCloudDrive.exe /F
rem taskkill /IM YandexDisk4.exe /F
taskkill /IM DiskO.exe /F
taskkill /IM OpenDrive_Tray.exe /F
taskkill /IM OneDrive.Sync.Service.exe /F
taskkill /IM OneDrive.exe /F
rem Stop Punto Switcher
rem taskkill /IM ps64ldr.exe /F
rem taskkill /IM punto.exe /F
rem STop CCleaner
taskkill /IM CCleaner64.exe /F
rem Stop OneNote Agent
taskkill /IM ONENOTEM.EXE /F
rem Stop DT Lite CD-ROM Emulator
taskkill /IM DTAgent.exe /F
taskkill /IM DTShellHlp.exe /F
taskkill /IM QipGuard.exe /F
taskkill /IM Qip.exe /F
rem Stop OPenVPN GUI
taskkill /IM openvpn-gui.exe /F
rem Stop ITunes
taskkill /IM iTunesHelper.exe /F
rem Stop Download Master Agent
taskkill /IM dmaster.exe /F
taskkill /IM Viber.exe /F
taskkill /IM WhatsApp.exe" /F
taskkill /IM "HK Upload.exe" /F
rem Stop HP Services
taskkill /IM HpqSRmon.exe /F
taskkill /IM hpwuSchd2.exe /F
rem Stop ORFO Agent Service
taskkill /IM OrfoAgent64.exe /F
taskkill /IM BuildService.exe /F
taskkill /IM CoordService.exe /F
rem Stop Browsers
taskkill /IM iexplore.exe /F
taskkill /IM Amigo.exe /F
taskkill /IM Browser.exe /F
taskkill /IM Chrome.exe /F
taskkill /IM MicrosoftEdgeCP.exe /F
taskkill /IM MicrosoftEdge.exe /F
taskkill /IM GoogleCrashHandler.exe /F
taskkill /IM GoogleCrashHandler64.exe /F
taskkill /IM GoogleUpdate.exe /F
rem Stop Different Services
taskkill /IM service_update.exe /F
taskkill /IM rundll32.exe /F
rem Stop SnagIT Agent and Programs
taskkill /IM TscHelp.exe /F
taskkill /IM SnagPriv.exe /F
taskkill /IM SnagitEditor.exe /F
taskkill /IM SnagIt32.exe /F
rem Stop vmWare Tray
rem taskkill /IM vmware-tray.exe /F
rem Stop FileZilla Server Interface
taskkill /IM "Filezilla Server Interface.exe" /F
taskkill /IM "MiPhoneHelper.exe" /F
taskkill /IM "EvernoteClipper.exe" /F
taskkill /IM "QipShot.exe" /F
taskkill /IM "telegram.exe" /F
taskkill /IM "vkcalls.exe" /F
taskkill /IM "max-service.exe" /F
taskkill /IM "max.exe" /F
taskkill /IM "vk Мессенджер.exe" /F
taskkill /IM "YandexTelemost.exe" /F
taskkill /IM "SplitCam.exe" /F

