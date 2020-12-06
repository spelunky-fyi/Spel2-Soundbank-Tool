# Spelunky 2 Soundbank Tool

This is a tool that allows to extract all Spelunky 2 sound files & music, then repack them into the soundbank after modification.

It's mostly a combination of 3 different tools to make both extract and repack possible without having to do everything manually.

# How to use

Just copy the tool somewhere you'll want to keep the extracted sound files, then run Spel2_Extract.cmd !

The script will automatically try to get the extracted Soundbank from the following path "C:\Program Files (x86)\Steam\steamapps\common\Spelunky 2\Mods\Extracted\"
If your extracted Soundbank is not there, you can just manually copy the "soundbank.bank" file into the tool's workspace : "Spel2-Soundbank-Tool\Extracted\Soundbank\"
After providing the Soundbank the extraction process should begin and will take around 10 minutes in total (the .wav extractor tool is pretty slow)

When it's finished, you'll find the SFX files in "Spel2-Soundbank-Tool\Extracted\SFX\" and the MUSIC files in "Spel2-Soundbank-Tool\Extracted\MUSIC\"
There is no override folder at the moment so you'll want to replace the sound files directly in these two folders when you need to. 

When you are done modifying the sound files you can just run Spel2_Repack.cmd !
You can run the repack script every time you make a sound modification. The repack process is pretty fast, so it should take less than a minute.

A modified "soundbank.bank" file will finally be created in "Spel2-Soundbank-Tool\Repack\Soundbank\"
You can then copy it into your favorite Spelunky 2 Override folder and repack it into the game with Modlunky2 or s2-Data

# External tools used in this project

•	FMOD SoundBank Generator from FMOD Studio API (included in FMOD Engine)

The FMOD Studio API allows programmers to interact with the data driven projects created via FMOD Studio at run time. It is built on top of the Core API and provides additional functionality to what the Core API provides.

It can be downloaded here (you will need an Fmod account): https://www.fmod.com/download

•	QuickBMS

Tool created by Luigi Auriemma https://aluigi.altervista.org/quickbms.htm
Files extractor and reimporter, archives and file formats parser, advanced tool for reverse engineers and power users, and much more.

The "FSB5.bms" script used to extract the .fsb files from the soundbank was downloaded from the ZenHAX forum (Official QuickBMS support).

•	fsb_aud_extr

Tool created by id-daemon on the ZenHAX forum to convert the fsb to wav, is great for CELT and ogg vorbis audios.

Last version’s download link (2018): https://zenhax.com/download/file.php?id=5808 
