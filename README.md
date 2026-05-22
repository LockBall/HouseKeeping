make this a python script

other places of interest  
C:\ProgramData\NVIDIA Corporation\Downloader\xxRANDOMxx  

##  Reboot Cmds

**Bios**  
You can reboot a computer to bios instead of smashing keys and hoping !  
shutdown /r /fw /T 1

---

**Safe Mode**  
bcdedit /set {current} safeboot network
shutdown /r /t 0

disable safe mode when task is complete
bcdedit /deletevalue {current} safeboot
shutdown /r /t 0

---

## Clear Windows Defender Detection History
reboot into safe mode to gain access to the files and folders

C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service

there are 3 logs: Detections, History, Unknown
and 1 folder: DetectionHistory

what actually needs to get deleted ?

DetectionHistory has some empty folders and some files with clear references to findings
lets start by emptying that
that worked

---