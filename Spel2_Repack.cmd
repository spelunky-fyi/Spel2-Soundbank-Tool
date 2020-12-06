@echo off

set sfx-optimize=-optimize_samplerate
set music-compress=65

set scriptpath=%~dp0
cd %scriptpath%

IF NOT EXIST "Repack\FSB5" mkdir "Repack\FSB5"
IF NOT EXIST "Extracted\Soundbank\soundbank.bank" echo The original Soundbank file is missing! &echo. &pause &exit

:REPACK-SFX
REM Use Fsbank to generate a new .fsb file from the sfx files list created during the extraction process
REM The optimize parameter will compress the sfx .fsb file to allow more space for the modified sound files

IF NOT EXIST "Extracted\SFX\SFX.lst" echo The extracted SFX's .lst file is missing! &echo. &pause &exit
IF EXIST "Repack\FSB5\00000000.fsb" echo Warning, this will override the old repacked SFX! &timeout /T 10

API-Fmod\fsbankcl.exe -rebuild -format pcm %sfx-optimize% -o "Repack\FSB5\00000000.fsb" "Extracted\SFX\SFX.lst"

:REPACK-MUSIC
REM Use Fsbank to generate a new .fsb file from the music files list created during the extraction process
REM The music files are compressed to vorbis, you can lower the quality value to make the music .fsb file smaller (71 will get it just under the original size)

IF NOT EXIST "Extracted\MUSIC\MUSIC.lst" echo The extracted MUSIC's .lst file is missing! &echo. &pause &exit
IF EXIST "Repack\FSB5\00000001.fsb" echo. &echo Warning, this will override the old repacked MUSIC! &timeout /T 10

API-Fmod\fsbankcl.exe -rebuild -format vorbis -quality %music-compress% -o "Repack\FSB5\00000001.fsb" "Extracted\MUSIC\MUSIC.lst"

:REPACK-SOUNDBANK
REM Use QuickBMS to reinject the new .fsb files into the original soundbank
REM Both .fsb files need to be smaller or the same size than before, otherwise QuickBMS cannot inject them back

echo.
IF NOT EXIST "Repack\Soundbank" mkdir "Repack\Soundbank"
IF NOT EXIST "Repack\FSB5\00000000.fsb" echo The SFX .fsb file is missing! &echo. &pause &exit
IF NOT EXIST "Repack\FSB5\00000001.fsb" echo The MUSIC .fsb file is missing! &echo. &pause &exit
IF EXIST "Repack\Soundbank\soundbank.bank" echo Warning, this will override the old repacked soundbank! &timeout /T 10 &echo.

copy "%scriptpath%Extracted\Soundbank\soundbank.bank" "%scriptpath%Repack\Soundbank\" /Y &timeout /T 5 >NUL
quickbms.exe -w -r FSB5.bms Repack\Soundbank\soundbank.bank Repack\FSB5\

:END
echo. &pause