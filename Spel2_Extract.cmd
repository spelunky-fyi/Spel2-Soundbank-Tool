@echo off

set spel2expath=C:\Program Files (x86)\Steam\steamapps\common\Spelunky 2\Mods\Extracted\
set scriptpath=%~dp0
cd %scriptpath%

:COPYBANKFILE
REM Copy the soundbank from Spelunky 2's extracted resources into the workspace

IF NOT EXIST "Extracted\Soundbank" mkdir "Extracted\Soundbank"
IF EXIST "Extracted\Soundbank\soundbank.bank" echo The soundbank already exists inside the workspace. &echo. &timeout /T 5 >NUL &goto EXTRACT-FSB5

IF EXIST "%spel2expath%soundbank.bank" copy "%spel2expath%soundbank.bank" "%scriptpath%Extracted\Soundbank\" /Y &timeout /T 5 >NUL
IF NOT EXIST "Extracted\Soundbank\soundbank.bank" echo Soundbank file not found inside the workspace! &pause &exit

:EXTRACT-FSB5
REM Extract the 2 .fsb files from the soundbank with QuickBMS

IF NOT EXIST "Extracted\FSB5" mkdir "Extracted\FSB5"
IF EXIST "Extracted\FSB5\*.fsb" echo The .fsb files have already been extracted inside the workspace. &echo. &timeout /T 5 >NUL &goto EXTRACT-SFX

quickbms.exe FSB5.bms Extracted\Soundbank\soundbank.bank Extracted\FSB5\

:EXTRACT-SFX
REM Extract all sfx from the first .fsb file with fsb_aud_extr
REM Then create a .lst file containing the list of all extracted sfx files in the right order
REM If the order is changed all sounds will be srambled in the game after the repack (which can be pretty fun)

IF NOT EXIST "Extracted\SFX" mkdir "Extracted\SFX"
IF EXIST "Extracted\SFX\*.wav" echo Some SFX files have already been extracted inside the workspace. &echo If you need to extract them again please remove the old ones! &echo. &timeout /T 5 >NUL &goto EXTRACT-MUSIC
pushd "Extracted\SFX" &echo.

echo Extracting SFX files... (this will take around 5 minutes)
"%scriptpath%fsb_aud_extr_1_10.exe" "%scriptpath%Extracted\FSB5\00000000.fsb" >sfx_extract.log

IF EXIST SFX.lst type nul >SFX.lst
for /f "delims=" %%A in (sfx_extract.log) do (echo %%A.wav>>SFX.lst)
popd

:EXTRACT-MUSIC
REM Extract all music from the first .fsb file with fsb_aud_extr
REM Then create a .lst file containing the list of all extracted music files in the right order
REM If the order is changed all music tracks will be srambled in the game after the repack (which can also be pretty fun)

IF NOT EXIST "Extracted\MUSIC" mkdir "Extracted\MUSIC"
IF EXIST "Extracted\MUSIC\*.wav" echo Some MUSIC files have already been extracted inside the workspace. &echo If you need to extract them again please remove the old ones! &echo. &timeout /T 5 >NUL &goto END
pushd "Extracted\MUSIC" &echo.

echo Extracting MUSIC files... (this will take around 5 minutes)
"%scriptpath%fsb_aud_extr_1_10.exe" "%scriptpath%Extracted\FSB5\00000001.fsb" >music_extract.log

IF EXIST MUSIC.lst type nul >MUSIC.lst
for /f "delims=" %%A in (music_extract.log) do (echo %%A.wav>>MUSIC.lst)
popd &echo.

:END
pause