; AutoHotKey Retrobat Theme Randomizer
; Version 1.0
; David Marti
;
; This script is for launching Retrobat and have it randomly load with a
; different installed theme.
;
; The script will read all of the directory names in the themes folder and randomly
; choose one to use.
; 
; Usage:
;
; Place the compiled start_retrobat_random.exe file into the same folder as the
; existing retrobat.exe file.
;
; Double click on the new start_retrobat_random.exe file to start Retrobat.


#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

FileDelete, %A_ScriptDir%\emulationstation\.emulationstation\temp.cfg
FileDelete, %A_ScriptDir%\emulationstation\.emulationstation\es_settings.cfg.bak

FileName := ""
FileList := ""
Loop, Files, %A_ScriptDir%\emulationstation\.emulationstation\themes\*.*, D
{
  FileList .= A_LoopFileName "`n"
}
Sort, FileList, Random

Loop, parse, FileList, `n
{
  if (A_LoopField = "")
    continue
  if (A_Index = 1)
    FileName := A_LoopField	
}

Loop, Read, %A_ScriptDir%\emulationstation\.emulationstation\es_settings.cfg, %A_ScriptDir%\emulationstation\.emulationstation\temp.cfg
{
  line := a_LoopReadLine
  If (InStr(line, "ThemeSet"))
  line := "<string name=""ThemeSet"" value=""" . FileName . """ />"
  FileAppend, %line%`r  
}

Filemove, %A_ScriptDir%\emulationstation\.emulationstation\es_settings.cfg, %A_ScriptDir%\emulationstation\.emulationstation\es_settings.cfg.bak
Filemove, %A_ScriptDir%\emulationstation\.emulationstation\temp.cfg, %A_ScriptDir%\emulationstation\.emulationstation\es_settings.cfg

FileDelete, %A_ScriptDir%\emulationstation\.emulationstation\temp.cfg

Run, retrobat.exe
