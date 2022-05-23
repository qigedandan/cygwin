@echo off
@echo Using KEIL to compile TinyOS files to binary

SET C51INC=C:\Keil\C51\INC\Chipcon\;C:\Keil\C51\INC\
SET C51LIB=C:\Keil\C51\LIB
SET CPU_TYPE=CC2430-F128
SET CPU_VENDOR=Chipcon
SET UV2_TARGET=Target 1
SET CPU_XTAL=0x016E3600

SET LINKOBJECT="startup.obj","app.obj"

FOR %%c IN (%1 %2 %3 %4 %5 %6 %7 %8 %9) DO IF NOT "%%c"=="" SET LINKOBJECT=%LINKOBJECT%,"%%c.obj"


echo Compiling TinyOS files
@C:\Keil\C51\BIN\C51.EXE "app.c" LARGE OMF2 PRINT(.\app.lst) OBJECT(.\app.obj) WARNINGLEVEL (0) 

echo Linking all files to binary
@C:\Keil\C51\BIN\LX51.EXE %LINKOBJECT% TO "app" PRINT (app.map) CLASSES( XDATA(X:0xE000-X:0xFD53), IDATA(I:0-I:0xFF)) REGFILE(app.reg) DISABLEWARNING (15) 
@C:\Keil\C51\BIN\OHX51.EXE "app" 



