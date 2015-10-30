# Digitizing Analog Videotapes with vrecord #

## Digitizing Betacam Tapes ##

There are several steps to digitizing a Betacam tape. 

1. Route the video signal from the Betacam deck to the Black Magic capture card for the computer that you are using. [[[The available computers at CUNY are ING 14, 15, and 16. So you would use the switching panel to route VR-20 to ING-15 ]]]
2. Start by testing the signal to make sure that everything is routed properly. Play the tape in the deck. Run `$ vecord -p` and watch the vrecord window to make sure the video signal from the tape is coming through. If it's not coming through, there may be some issues with your settings or how the signal is routed. See the "Troubleshooting" section below.  
3. If color bars exist on the tape, set the tape to the bars. Otherwise, you will have to adjust the levels by eye as well as using the vectorscope and waveform monitor. 

### How to Set Up the Equipment to Color Bars on a Tape ###

First, play the tape with the color bars. Now take a look at your waveform monitor to examine the signal. At CUNY-TV you will need to route the signal to a monitor called QC-ING32. This monitor is connected to the combination  waveform monitor, vectorscope, and audio monitor.

**Using the Waveform Monitor**

The waveform monitor is generally used to measure the lumaniance (brightness) levels of the signal. SMPTE color bars should look like this on a waveform monitor, similiar to a staircase:

![alt text](http://www.experimentaltvcenter.org/sites/default/files/history/images/preservationcom/waveform2.jpg "Color Bars in Waveoform Monitor")

Start by setting up the black level in the waveform monitor. The lowest step in the color bars (the black level) should be set to 7.5 IRE on the waveform monitor usually represented by a dashed line near the bottom of the monitor.

Now set the luminance level, this could be the step all the way on the left, or it could be the second step from the left. One of these steps should hit the 75 IRE mark on the waveform monitor usually represented by a dotted line.

There may also be another step to the left of the 75 IRE bar. Make sure this line is at 100 IRE. Your black and luma levels should now be correctly set up. 

**Using the Vectorscope**

The vectorscope is used to measure the chrominance (color) levels of the video signal. Correctly adjusted color bars should look like this in the vectorscope:
![alt text](http://www.bhphotovideo.com/explora/sites/default/files/vectorscope.JPG "Color Bars in a vectorscope")

The vectorscope has a few square target boxes. Inside of the larger box is a smaller box with a crosshair inside of it. These boxes represent standard values for primary and secondary colors (R stands for "red," B stands for "blue," Y stands for "yellow" and so on). Ideally the points where lines intersect on the vectorscope should hit all of those targets.  

Start by adjusting the hue or phase. There should be one line that is on the left half of the vectorscope that is shorter than the others. This is the color reference signal. **Adjust the hue by turning the knob so that the color reference line is at 0 degrees on the vectorscope (or 9 o'clock).** This should move the other lines closer to their targets. If there is no color reference signal, adjust the hue dial so that the yellow dot is in line with its target. 

Now adjust the chrominance (or chroma). If the points are past their targets, reduce the chroma. If the dots are closer to the center than the target, increase the chroma. **Try to get all of the points as close to the middle of the crosshairs as possible.** Sometimes it is not possible to get all of the colors exactly inside of their respective crosshairs. If so, try to line up the yellow point with its target as closely as possible and let the other colors fall where they may.   

4. You may have to rewind and replay the tape several times in order to set up the bars properly especially if the bars are onscreen for a short time. Be aware that sometimes the color bar signal can change on a tape. Check for excessive jumping of the levels on the vectorscope or waveform monitor. Try to find the most consistent levels and line them up as best you can.

### Setting up the Tape Without Color Bars ###

Ideally, set up the your time based corrector or processing amplifier to the color bars on a test tape beforehand.

Fast forward to some of the content, ideally a shot that has white and black in it. Check the waveform monitor to make sure that both the whites and blacks are within "broadcast range" (black is at 7.5 IRE and white at 75 IRE). If you can find a close up shot of person use this in combination with the vectorscope to try to set up hue and chroma. Make sure that the chroma is within broadcast range. The lines in the vectorscope should not be going past the color target boxes. If they are, reduce the chroma. In general, the color of skintones should fall on the line between the red and yellow target boxes (about 10:30–11 o'clock) on the vectorscope. Some people call this the "skin tone line." Adjust the hue until the color is centered around this line.     

### Setting the Audio Levels ###

You will need to watch an audio monitor for the left and right audio channels. The test tone that accompanies the color bars should be set to hit the 0 db mark. Now, fast forward to the tape so that you can watch some of the content. If the content has stereo audio make sure the volume of the left and right channels is at an equal level. You may need to raise or lower the left or right audio level to make both sides even.

Now your tape is set up properly and you are ready to actually digitize. 

### Digitizing the Tape ###

Run `$ vrecord -e` and check the window that pops up to make sure your settings are correct. We use the following settings for digitizing Betacam tapes at CUNY-TV: 

**Video input** — SDI 

**Audio input** — SDI embedded audio 

**Bit depth** — 10 bit

**File format** — Quicktime 

**Codec for video** — FFV1 version 3

**Audio channel mapping** — 2 Stereo tracks or 1 stereo track

**Standard** — NTSC

**Recording Time** — For a 30 minute tape set the recording time to 32. For a 60 minute tape set the recording time to 62. Usually tapes have the number 30 or 60 on them somewhere so you can figure out which kind of tape you have.

As the color bars play, monitor your waveform, vectorscope, and audio levels. Make sure that all of the levels are still correct. If any of the levels are not correct, you will have to stop the recording (by closing the vrecord window), rewind the tape back to the beginning of the bars and then set them up again using passthrough mode. When they are properly set up, try recording again.

## Digitizing U-matic Tapes ##
1. Inspect the tape to make sure that it does not already have sticky shed syndrome.

CUNY-TV uses the following settings for U-matic tapes:

**Video input** — SDI 

**Audio input** — SDI embedded audio 

**Bit depth** — 10 bit

**File format** — Quicktime 

**Codec for video** — FFV1 version 3

**Audio channel mapping** — 1 stereo track

**Standard** — NTSC

**Recording Time** — For a 30 minute tape set the recording time to 32. For a 60 minute tape set the recording time to 62. Usually tapes have the number 30 or 60 on them somewhere so you can figure out which kind of tape you have.

## Checking the Files ##

Check to make sure vrecord produced the correct files. These are:

1. The video file itself 
2. Bmdcapture log (filename_bmdcapture.log)
3. FFmpeg log (filename_ffmpeg_date_time.log)
4. FFplay log (filename_ffplay_date_time.log)
5. Frame MD5 file (filename.framemd5)
6. An ingest log (filename.log)

Scroll through the video file to make sure it is complete; in other words, you've captured the entire tape. If all these files exist and the video file looks complete you can move on to further QC.

## Troubleshooting ##

**I ran `$ vrecord -p` and no video is showing up in the vrecord window!**

**I can't set up the lumaniance properly!**

**My tape finished early, how to do stop vrecord**
