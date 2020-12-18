@echo off

set audio-quality=1

set scriptpath=%~dp0
cd %scriptpath%

IF NOT EXIST "Repack\FSB5" mkdir "Repack\FSB5"
IF NOT EXIST "Extracted\Soundbank\soundbank.bank" echo The original Soundbank file is missing! &echo. &pause &exit
IF NOT EXIST "Extracted\SFX\SFX.lst" echo The extracted SFX's .lst file is missing! &echo. &pause &exit
IF NOT EXIST "Extracted\MUSIC\MUSIC.lst" echo The extracted MUSIC's .lst file is missing! &echo. &pause &exit

:AUDIOFILES-CHECK
REM Checking if all audio files listed in both sfx and music .lst exist inside the extracted folders

set missing-sfx=0
set missing-music=0

pushd "Extracted\SFX"
echo Checking SFX files inside "Extracted\SFX"... &echo.
for /f "delims=" %%A in (SFX.lst) do (IF NOT EXIST %%A echo The file "%%A" is missing! &set missing-sfx=1)
IF %missing-sfx% EQU 1 echo. &echo Some SFX files are missing inside "Extracted\SFX" &echo You need to have all the files to be able to repack! &echo. &pause &exit
popd

pushd "Extracted\MUSIC"
echo Checking MUSIC files inside "Extracted\MUSIC"... &echo.
for /f "delims=" %%A in (MUSIC.lst) do (IF NOT EXIST %%A echo The file "%%A" is missing! &set missing-music=1)
IF %missing-music% EQU 1 echo. &echo Some MUSIC files are missing inside "Extracted\MUSIC" &echo You need to have all the files to be able to repack! &echo. &pause &exit
popd

:REPACK-SFX
REM Use Fsbank to generate a new .fsb file from the sfx files list created during the extraction process
REM The optimize parameter will compress the sfx .fsb file to allow more space for the modified sound files

IF EXIST "Repack\FSB5\00000000.fsb" echo Warning, this will override the old repacked SFX! &timeout /T 10

API-Fmod\fsbankcl.exe -rebuild -format vorbis -quality %audio-quality% -o "Repack\FSB5\00000000.fsb" "Extracted\SFX\SFX.lst"

REM Making sure that the new sfx .fsb file is not bigger than the extracted one
FOR %%I in (Extracted\FSB5\00000000.fsb) do set size-sfx-ext=%%~zI
FOR %%I in (Repack\FSB5\00000000.fsb) do set size-sfx-rep=%%~zI
IF %size-sfx-rep% GTR %size-sfx-ext% echo. &echo THE NEW SFX .FSB FILE IS TOO BIG! &echo You need to reduce the size of your modified sfx files! &echo. &pause &exit

:REPACK-MUSIC
REM Use Fsbank to generate a new .fsb file from the music files list created during the extraction process
REM The music files are compressed to vorbis, you can lower the quality value to make the music .fsb file smaller (71 will get it just under the original size)

IF EXIST "Repack\FSB5\00000001.fsb" echo. &echo Warning, this will override the old repacked MUSIC! &timeout /T 10

API-Fmod\fsbankcl.exe -rebuild -format vorbis -quality %audio-quality% -o "Repack\FSB5\00000001.fsb" "Extracted\MUSIC\MUSIC.lst"

REM Making sure that the new music .fsb file is not bigger than the extracted one
FOR %%I in (Extracted\FSB5\00000001.fsb) do set size-music-ext=%%~zI
FOR %%I in (Repack\FSB5\00000001.fsb) do set size-music-rep=%%~zI
IF %size-music-rep% GTR %size-music-ext% echo. &echo THE NEW MUSIC .FSB FILE IS TOO BIG! &echo You need to reduce the size of your modified music files! &echo. &pause &exit

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