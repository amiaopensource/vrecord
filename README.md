# vrecord Readme

## Summary

Vrecord is open-source software for capturing a video signal and turning it into a digital file. Vrecord can capture analog and digital signals through a variety of inputs and can create digital files in a variety of formats and codecs. Vrecord is designed with needs of audiovisual archivists in mind. 

Currently vrecord only supports Blackmagic Design capture cards with the Blackmagic driver installed. 

## Installing vrecord

If you use a Mac, you can easily install vrecord using a package manager called Homebrew. To install Homebrew, follow the instructions here: http://brew.sh/

To install vrecord, run the following commands:

`$ brew tap amiaopensource/amiaos` { this taps the homebrew recipes of the amiaopensource account }

`$ brew install vrecord`{ this installs vrecord and the other programs that it requires }

You can update vrecord by first running:

`$ brew update` {this updates all of your Homebrew recipes to the latest versions}

Now run:

`$ brew upgrade vrecord`

Alternatively you can run:

`$ brew upgrade` {this will upgrade all of the programs you've installed through Homebrew}

## Using vrecord

###Setting up vrecord

Start by typing 
```
$vrecord
```
The first time you use vrecord you will be asked to make some choices...

[[[More description on setting up vrecord TK]]]

###The vrecord Window

[[[A full description of all the elements of the vrecord window along with an image of the window TK]]]

This is the default setup of the vrecord window in "Visual" mode. Vrecord also includes a "Visual + Numerical" mode, which is discussed in [[[insert link to section]]]
**Video feed**
**Video feed with broadcast-safe indicator**
**Vectorscope**
**Waveform monitor**

###Passthrough Mode

Passthrough mode means that the vrecord scopes and video windows will show up, but the video signal will not be recorded to a file. Passthrough mode is used for things like testing equipment or setting up a tape to bars before actually recording. When you are finished using passthrough mode simply close the vrecord window.

Run passthrough mode by typing:
```
$ vrecord -p
```
and then pressing "return". Vrecord will prompt you to press enter. When you press enter the vrecord window will open up and start displaying the video signal

###Edit Mode

This mode opens a GUI window that allows you to set up all the options for recording the video signal. After selecting all of your options the video signal will be recorded to a file with some associated metadata files. When you are done recording, close the vrecord window.

Run edit mode by typing:
```
$ vrecord -e
```

By default vrecord will create a video file, a bmdcapture log, a framemd5 file (which creates an MD5 hash value for every frame of video), an ffmpeg log, and an ffplay log. 

#### The vrecord GUI in Edit Mode

All of options in the vrecord GUI are explained below:

"Select

**Visual mode** — Visual mode displays the two video feeds, the waveform monitor and the vectorscope in the vrecord window.

**Visual + Numerical mode** — Visual and Numerical mode displays your favorite video feeds and scopes as well as numerical values for the characteristics of the video signal on the left sidebar. The numerical values are as follows:

* Y — Low, high, and average luminance of the video signal. "Diff" means the difference of the luminance between successive frames.
* U — Low, high, and average of the U channel value of the video signal. "Diff" means the difference of the U value between successive frames.
* V — Low, high, and average of the V channel value of the video signal. "Diff" means the difference of the V value between successive frames.
* SAT — Low, high, and average saturation values (sometimes called chroma) of the video signal
* HUE — Low, high, and average hue values of the video signal
* TOUT — The percentage of pixels that are temporal outliers. Temporal Outliers are pixels which have different values from the pixels above or below them. This is useful for detecting noise in the video signal or other artifacts. However, the number will also go up with fast motion, camera movement, or cuts to different shots.  
* VREP — The amount of vertical line repititions in the video. The VREP reading can be useful for detecting video artifacts, especially head clogs.    
* BRNG — Percentage of pixels that are in broadcast range. This may be helpful for detecting problems with the video signal such as dropout or if the signal has not been calibrated properly. If BRNG is 0.1 or greater, you probably have an issue.

**Frame MD5s** — You can choose to create an MD5 hash value for each frame of video. A seperate .md5 file with all the hash values will be created along with the video file.

Set Recording time — Set the amount of time (in minutes) that you would like vrecord to run for. For example, if you are digitizing a tape with a capacity of 30 minutes of video, you might want set vrecord to capture for 32 minutes. 

##Issues 

We want vrecord to be a helpful tool for audiovisual archivists and others. If you experience any problems with vrecord you can open a new issue with our Github [issue tracker](https://github.com/amiaopensource/vrecord/issues). Try to see if you can replicate the issue yourself first and describe in detail what factors led to it. Let us know if you were able to replicate the issue. 
