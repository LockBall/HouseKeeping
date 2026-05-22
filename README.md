make this a python script

other places of interest  
C:\ProgramData\NVIDIA Corporation\Downloader\xxRANDOMxx  


## FireWaterFox Profile Backup
``C:\Users\<YourUser>\AppData\Roaming\Waterfox\Profiles\<random>.default``

---

##  Reboot Cmds

**Bios**  
You can reboot a computer to bios instead of smashing keys and hoping !  
``shutdown /r /fw /T 1``

---

**Safe Mode**  
enable safemode and reboot  
``bcdedit /set {current} safeboot network``  
``shutdown /r /t 0``

disable safe mode when task is complete and reboot  
``bcdedit /deletevalue {current} safeboot``  
``shutdown /r /t 0``

---

## Clear Windows Defender Detection History
reboot into safe mode to gain access to the files and folders

navigate to  
``C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service``

there are 3 logs: ``Detections``, ``History``, ``Unknown``  
and 1 folder: ``DetectionHistory``  

what actually needs to get deleted ?  
``DetectionHistory`` has some empty folders and some files with clear references to findings

delete the conents of ``DetectionHistory``

---