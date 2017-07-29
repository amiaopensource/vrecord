# Digitizing Analog Videotapes with vrecord

## Digitizing Betacam Tapes

There are several steps to digitizing a Betacam tape. This procedure assumes you already have vrecord and a Blackmagic capture card installed. 

1. Route the video signal from the Betacam deck to the Blackmagic capture card for the computer that you plan to use.
2. Start by testing the signal to make sure that everything is routed properly. Play the tape in the deck. Run `vecord -p` and watch the vrecord window to make sure the video signal from the tape is coming through. If it's not coming through, there may be some issues with your settings or how the signal is routed. See the "Troubleshooting" section below.  
3. If color bars exist on the tape, set the tape to the bars. Otherwise, you will have to adjust the levels by eye as well as using the vectorscope and waveform monitor. 

### How to Set Up the Equipment to Color Bars on a Tape

First, play the tape with the color bars. Now take a look at your waveform monitor to examine the signal. At CUNY TV you will need to route the signal to a monitor called QC-ING32. This monitor is connected to the combination waveform monitor, vectorscope, and audio monitor.

**Using the Waveform Monitor**

The waveform monitor is generally used to measure the luminance (brightness) levels of the signal. SMPTE color bars should look like this on a waveform monitor, similar to a staircase:

![alt text](http://www.experimentaltvcenter.org/sites/default/files/history/images/preservationcom/waveform2.jpg "Color Bars in Waveform Monitor")

The color bars in the picture above are set up properly. Start by setting up the black level in the waveform monitor. The black level could also be called "Set up" or "Black" depending on your model of the time base corrector (TBC) or processing amplifier (proc amp). Adjust this dial until the second lowest line in the color bars (the black level), which runs along the bottom of the staircase is set to 7.5 IRE on the waveform monitor. This is usually represented by a dashed line near the bottom of the monitor. The black line should intersect the dashed 7.5 IRE line.

Now set the luminance level so that the highest plateau of your bars reaches the 100 IRE mark on the waveform monitor. The luminance level could be represented on a TBC or proc amp by a dial labeled "Luma" or "Video" again, depending on your model of TBC or Proc Amp. 

Your black and luma levels should now be correctly set up. 

**Using the Vectorscope**

The vectorscope is used to measure the chrominance (color) levels of the video signal. Correctly adjusted color bars should look like this in the vectorscope:
![alt text](http://www.bhphotovideo.com/explora/sites/default/files/vectorscope.JPG "Color Bars in a vectorscope")

The vectorscope has a few square target boxes. Inside of the larger box is a smaller box with a crosshair inside of it. These boxes represent standard values for primary and secondary colors (R stands for "red," B stands for "blue," Y stands for "yellow" and so on). Ideally the points where lines intersect on the vectorscope should hit all of those targets.  

Start by adjusting the hue or phase. There should be one line that is on the left half of the vectorscope that is shorter than the others. This is the color reference signal. **Adjust the hue by turning the knob so that the color reference line is at 0 degrees on the vectorscope (or 9 o'clock).** This should move the other lines closer to their targets. If there is no color reference signal, adjust the hue dial so that the yellow dot is in line with its target. 

Now adjust the chroma which could also be labelled "color." If the dots are past their targets, reduce the chroma. If the dots are closer to the center than the target, increase the chroma. **Try to get all of the points as close to the middle of the crosshairs as possible.** Sometimes it is not possible to get all of the colors exactly inside of their respective crosshairs. If so, try to line up the yellow point with its target as closely as possible and let the other colors fall where they may.   

4. You may have to rewind and replay the tape several times in order to set up the bars properly especially if the bars are onscreen for a short time. Be aware that sometimes the color bar signal can shift on a tape. Check for excessive jumping of the levels on the vectorscope or waveform monitor. Try to find the most consistent bars and line them up as best you can.
5. Be aware that the bars on a tape may not accurately represent the actual levels of the content. After you have successfully set up the bars fast forward and play some of the content. Make sure that large areas of the image are not falling outside of the broadcast range. You can see this in the vrecord window by seeing how much of the image on the right is yellow. If a significant portion of the image is yellow, the bars may not incorrect. You may need to ignore the bars and adjust the tape to the content. See the section below on setting up a tape without color bars.  

### Setting up the Tape Without Color Bars

Sometimes tapes you are digitizing do not include color bars at the beginning. If this is the case, and you have a test tape with color bars on hand, first set up your time base corrector (TBC) or processing amplifier (proc amp) to the color bars on a test tape. If you do not have a test tape, move on to the next step. 

Fast forward to some of the content, ideally a shot that has both pure white and black in it. Check the waveform monitor to make sure that both the white and black levels are within "broadcast range" (pure black in the image should be just above 7.5 IRE and pure white should be just below 100 IRE). 

If you can find a close up shot of person use this in combination with the vectorscope to try to set up hue and chroma. First, make sure that the chroma is within broadcast range. In other words, the lines in the vectorscope should not be going past the color target boxes. If they are, reduce the chroma. In general, the color of all human skin tones should fall on the line between the red and yellow target boxes (about 10:30–11 o'clock) on the vectorscope. Some people call this the "skin tone line." Adjust the hue until the levels in the vectorscope are centered around this line.     

You may want to fast forward to a few sections of the content to make sure that the adjustments you made are good for the entire tape. Sometimes shots and segments may be inconsistent. Sometimes you will need to compromise on the levels; one shot may need to be slightly out of broadcast range so that another shot is ok. 

### Setting the Audio Levels

You will need to watch an audio monitor to see the levels for the left and right audio channels. The test tone that accompanies the color bars on a tape should be set to hit either the -20 db or -12db mark depending on the tone. Now, fast forward the tape so that you can watch some of the content. If the content has stereo audio make sure the volume levels of the left and right channels are equal. You may need to raise or lower the left or right audio level to make both sides even. Make sure the audio levels are not peaking too high. 

Also note whether audio is coming in on both channels or just one channel. This will determine the vrecord settings that you will use later. 

**Now your tape is set up properly and you are ready to actually digitize.**

### Digitizing the Tape

Run `vrecord -e` and check the window that pops up to make sure your settings are correct. We use the following settings for digitizing Betacam tapes at CUNY-TV: 

**Video input** — SDI 

**Audio input** — SDI embedded audio 

**Bit depth** — 10 bit

**File format** — QuickTime 

**Codec for video** — FFV1 version 3

**Audio channel mapping** — The channel mappings can vary from tape to tape. For a Betacam tape that has audio coming in through both tracks use the "2 Stereo Tracks" setting. If the tape only has audio coming in through one side you will have to use the Channel 1 or Channel 2 mono mappings depending on which channel you determine is carrying the audio.

**Standard** — NTSC

**Recording Time** — For a 30 minute tape set the recording time to 33. For a 60 minute tape set the recording time to 63. Usually tapes have the number 30 or 60 on them somewhere so you can figure out which kind of tape you have.

As the color bars play, monitor your waveform, vectorscope, and audio levels. Make sure that all of the levels are still correct. If any of the levels are not correct, you will have to stop the recording (by closing the vrecord window), rewind the tape back to the beginning of the bars and then set them up again using passthrough mode. When they are properly set up, try recording again.

## Digitizing U-matic Tapes
Before playing the tape it's a good idea to inspect it to make sure that it does not already have sticky shed syndrome.

CUNY-TV uses the following settings for U-matic tapes:

**Video input** — SDI 

**Audio input** — SDI embedded audio 

**Bit depth** — 10 bit

**File format** — QuickTime 

**Codec for video** — FFV1 version 3

**Audio channel mapping** — 1 stereo track is generally used unless audio is only coming in through one channel. If so, you will have to use the Channel 1 or Channel 2 mono options.

**Standard** — NTSC

**Recording Time** — For a 30 minute tape set the recording time to 33. For a 60 minute tape set the recording time to 63. Usually tapes have the number 30 or 60 on them somewhere so you can figure out which kind of tape you have.

## Checking the Files

Check the terminal window for an error messages from vrecord. You may see a cow issuing a warning about your video file. If you get a cow warning you should examine the video file carefully to determine if there are any errors.  
You may also see a warning that says "packet too small." You can safely ignore this, it's just ffmpeg complaining that it didn't receive a full frame of video when vrecord stopped.

Next, check to make sure vrecord produced the correct files. These are:

1. The video file itself 
1. Bmdcapture log (filename_bmdcapture.log)
1. FFmpeg log (filename_ffmpeg_date_time.log)
1. FFplay log (filename_ffplay_date_time.log)
1. Frame MD5 file (filename.framemd5) if you chose to record frame MD5s, which you should do
1. A capture options log (filename_capture_options.log)
1. A QCTools XML file, if you chose to create it (filename.qctools.xml.gz)

Scroll through the video file to make sure it is complete; in other words, you've captured the entire tape. If all these files exist and the video file looks complete you can move on to further QC.

## Troubleshooting

**Q: I ran `vrecord -p` and no video is showing up in the vrecord window!**

A: Check to make sure all of your cables are routed properly. Also check macOS System Preferences to make sure that the Black Magic capture device is set up properly. If you are using SDI for your input on vrecord, the output of the Blackmagic should be set to SDI.

**Q: My tape finished early, how do I stop vrecord?**

A: Simply close the vrecord window and the program will automatically stop. You should then examine your video file to make sure it's complete.

## License

<a rel="license" href="https://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/80x15.png"></a><br>Vrecord is licensed under a <a rel="license" href="https://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.
