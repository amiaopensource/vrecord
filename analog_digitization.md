# Digitizing Analog Videotapes with vrecord

## Digitizing Betacam Tapes

There are several steps in digitizing a Betacam 

1. Route the video signal from the Betacam deck to the Black Magic capture card for the computer that you are using. [[[available computers at CUNY are ING 14, 15, and 16 ]]]
2. Start by testing the signal to make sure that everything is routed properly. Play the tape in the deck. Run `$ vecord -p` and watch the vrecord window to make sure the video signal from the tape is coming through. If it's not coming through, there may be some issues with your settings or how your equipment is routed. See the Troubleshooting section below.  
4. If bars exist on the tape, set the tape to the bars. Otherwise you will have to adjust the levels by eye. 

### How to Set Up the Equipment to Color Bars on a Tape ###
First, play the tape with the color bars. Now take a look at your waveform monitor.

** Using the Waveform Monitor **

The waveform monitor is generally used to measure the lumaniance (brightness) levels of the signal. SMPTE color bars should look something like this on a waveform monitor:

![alt text](http://www.experimentaltvcenter.org/sites/default/files/history/images/preservationcom/waveform2.jpg "Color Bars in Waveoform Monitor")

Start by setting up the black level in the waveform monitor. The lowest black level should be at 7.5 IRE on the waveform monitor usually represented by a dotted line. [[[Information TK about how to find the black level line that you need to line up]]]

Now set the luminance level, the bar all the way on the left should hit the 75 IRE mark on the waveform monitor usually represented by a dotted line.

There may also be another bar with a flat top to the right of the 75 IRE bar. Make sure this bar is at 100 IRE. Your black and luma levels should now be correctly set up.

**Using the Vectorscope**

The vectorscope is used to measure the chrominance (color) levels of the video signal. Correctly adjusted color bars should look like this in the vectorscope:
![alt text](http://www.bhphotovideo.com/explora/sites/default/files/vectorscope.JPG "Color Bars in a vectorscope")

The vectorscope has a few square target boxes. Inside of the larger box is a smaller box with a crosshair inside of it. These boxes represent standard values for primary and secondary colors (R stands for "red," B stands for "blue," YL stands for "yellow" and so on). Ideally the points where lines intersect on the vectorscope should hit all of those targets.  

Start adjusting the hue or phase. There should be one line that is on the left half of the vectorscope that is shorter than the others. This is the color reference signal. Adjust the hue by turning the knob so that the color reference line is at 0 degrees on the vectorscope (or 9 o'clock). This should move the other lines closer to their targets. 

Now adjust the chrominance (or chroma). If the lines continue past the target, reduce the chroma. If the lines end before the target, increase the chroma. Try to get all of the points as close to the middle of the crosshairs as possible. Sometimes it is not possible to get all of the colors exactly inside of their respective crosshairs. If so, try to line up the yellow point with its target as closely as possible and let the other colors fall where they may.   

5. You may have to rewind and replay the tape several times in order to set up the bars properly especially if the color bars are onscreen for a short time. Be aware that sometimes the color bar signal can change on a tape. Check for excessive jumping of the levels on the vectorscope or waveform monitor. [[[[[If the levels change use the levels that come later?]]]]  

4. Now adjust the audio levels. With two-channel stereo audio make sure the volume of both tracks is at an equal level. You may need to adjust the left or right audio level to make both sides even. You will need to monitor the left and right audio channels as they are being picked up by the capture card.

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

## Troubleshooting ##

I ran `$ vrecord -p` and no video is showing up in the vrecord window!

I can't set up the lumaniance properly!

