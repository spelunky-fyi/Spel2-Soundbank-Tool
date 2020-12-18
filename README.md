# Spelunky 2 Soundbank Tool

This tool allows you to extract all Spelunky 2 sfx & music, then repack them into the Soundbank after making modifications.

It's mostly a combination of 3 different tools to make sound extract and repack possible without having to do many tedious things manually.

# How to use

Just extract the .zip file somewhere you'll want to keep the extracted sound files, then run Spel2_Extract.cmd!

The script will automatically try to get the extracted Soundbank from the following path:
"C:\Program Files (x86)\Steam\steamapps\common\Spelunky 2\Mods\Extracted\".

If your extracted Soundbank is not there, you can just manually copy the "soundbank.bank" file into the tool's workspace : "Spel2-Soundbank-Tool\Extracted\Soundbank\". 
After providing the Soundbank, the extraction process can begin and will take around 10 minutes in total (the .wav extractor tool is quite slow).

When it's finished, you'll find the SFX files inside "Spel2-Soundbank-Tool\Extracted\SFX\" and the MUSIC files in "Spel2-Soundbank-Tool\Extracted\MUSIC\". 
There is no override folder at the moment so you'll want to replace the sound files directly in these two folders when you need to.

YOU NEED TO BE CAREFULL ABOUT THE SIZE OF YOUR NEW SOUND FILES!

With the current compression levels, you can add around 35Mb for SFX and 120Mb for MUSIC. 
If you go beyond these limits you will get the following error : "THE NEW SFX / MUSIC .FSB FILE IS TOO BIG!"

When you are done modifying the sound files you can just run Spel2_Repack.cmd! You can run the repack script every time you make a sound modification, it will fully rebuild the Soundbank every time. This process is pretty fast so it should take less than a minute.

A modified "soundbank.bank" file will finally be created in "Spel2-Soundbank-Tool\Repack\Soundbank\"
Then, you can copy it into your favorite Spelunky 2 Override folder and repack it into the game with Modlunky2 or s2-Data.

# SuperCompressed mode and FSB Repack

You can use the Spel2_Repack_SuperComp.cmd script to repack everything in supercompressed mode.
This way you will get .FSB files with the following sizes : around 10Mb for SFX & 50Mb for MUSIC !

Then can find your custom FSB files inside "Spel2-Soundbank-Tool\Repack\FSB5"
The FSB_Repack.cmd script will allow you to inject one or both files inside the soundbank

You just need to get the 00000000.fsb file for SFX and/or 00000001.fsb for MUSIC.
They need to be placed inside "Spel2-Soundbank-Tool\Repack\FSB5" before using FSB_Repack

# External tools used in this project

•	FMOD SoundBank Generator from FMOD Studio API (included in FMOD Engine)

The FMOD Studio API allows programmers to interact with the data driven projects created via FMOD Studio at run time. It is built on top of the Core API and provides additional functionality to what the Core API provides.

It can be downloaded here (you will need an Fmod account): https://www.fmod.com/download

•	QuickBMS

Tool created by Luigi Auriemma https://aluigi.altervista.org/quickbms.htm
Files extractor and reimporter, archives and file formats parser, advanced tool for reverse engineers and power users, and much more.

The "FSB5.bms" script used to extract the .fsb files from the Soundbank was downloaded from the ZenHAX forum (Official QuickBMS support).

•	fsb_aud_extr

Tool created by id-daemon on the ZenHAX forum to convert the fsb to wav, is great for CELT and ogg vorbis audios.

Last version’s download link (2018): https://zenhax.com/download/file.php?id=5808
