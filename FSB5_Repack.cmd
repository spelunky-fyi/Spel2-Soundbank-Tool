@echo off

set spel2expath=C:\Program Files (x86)\Steam\steamapps\common\Spelunky 2\Mods\Extracted\
set scriptpath=%~dp0
cd %scriptpath%

:COPYBANKFILE
REM Copy the soundbank from Spelunky 2's extracted resources into the workspace

IF NOT EXIST "Extracted\Soundbank" mkdir "Extracted\Soundbank"
IF EXIST "Extracted\Soundbank\soundbank.bank" goto REPACK-SOUNDBANK

IF EXIST "%spel2expath%soundbank.bank" echo Copying the extracted soundbank to the workspace... &copy "%spel2expath%soundbank.bank" "%scriptpath%Extracted\Soundbank\" /Y &timeout /T 5 >NUL
IF NOT EXIST "Extracted\Soundbank\soundbank.bank" echo Soundbank file not found inside the workspace! &pause &exit

:REPACK-SOUNDBANK
REM Use QuickBMS to reinject the new .fsb files into the original soundbank
REM Both .fsb files need to be smaller or the same size than before, otherwise QuickBMS cannot inject them back

echo.
IF NOT EXIST "Repack\Soundbank" mkdir "Repack\Soundbank"
IF EXIST "Repack\Soundbank\soundbank.bank" echo Warning, this will override the old repacked soundbank! &timeout /T 10 &echo.

copy "%scriptpath%Extracted\Soundbank\soundbank.bank" "%scriptpath%Repack\Soundbank\" /Y &timeout /T 5 >NUL
quickbms.exe -w -r FSB5.bms Repack\Soundbank\soundbank.bank Repack\FSB5\

:END
echo. &pause