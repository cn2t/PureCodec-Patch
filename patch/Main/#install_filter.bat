@echo off
cd /d "%~dp0"

:: regist madVR
cd Codecs
REM use "@echo | " to skip pause
@echo | call uninstall.bat
@echo | call install.bat
cd /d "%~dp0"

:: regist xySubFilter
cd Codecs
@regsvr32 /s xysubfilter.dll
cd /d "%~dp0"

:: regist HEVC codec
@regsvr32 /s FLVSplitter.ax
cd Codecs
@regsvr32 /s hevcdecfltr.dll
@regsvr32 /s hevcsrc.dll
@regsvr32 /s mp4demux.dll
cd /d "%~dp0"
