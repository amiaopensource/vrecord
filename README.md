# Vrecord Documentation

## Summary

Vrecord is open-source software for capturing a video signal and turning it into a digital file. Vrecord can capture analog and digital signals through a variety of inputs and can create digital files in a variety of formats and codecs. Vrecord is designed with needs of audiovisual archivists in mind. 

Vrecord uses [ffmpeg](http://ffmpeg.org), [ffplay](http://ffmpeg.org/ffplay.html), and [bmdcapture](https://github.com/lu-zero/bmdtools) to do its dirty work.

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
$ vrecord -e
```
The first time you use vrecord you will be asked to make some choices...
[[[More description on setting up vrecord TK]]]

###Basic Use

For those who want the simplest possible explanation:

1. Run `$ vrecord -p`.
2. Choose appropriate options when prompted.
3. Play your tape in the connected VTR and setup bars and audio.
4. Close the vrecord window.
5. Run `$ vrecord -e` and make sure all options are correct in the GUI window.
6. Type in a unique identifier for your file when prompted.
7. Press "enter" to start recording.
8. Let 'er rip! Play your tape!
9. If you are finished recording and the vrecord window hasn't already closed, close the window.
10. Check to make sure your video and metadata files were successfully created. 
11. Repeat steps 1–10 as needed.

###The vrecord Window

[[[A full description of all the elements of the vrecord window along with an image of the window TK]]]

This is the default setup of the vrecord window in "Visual" mode. Vrecord also includes a "Visual + Numerical" mode, which is discussed in the "vrecord's Options for Video Capture" section.

1. **Video feed** — [[[Description TK]]]
2. **Video feed with broadcast-safe indicator** — Displays a feed of an underscanned version of the video signal with the proper aspect ratio. Pixels whose luminance is outside of broadcast range are colored yellow. 
3. **Vectorscope** — Displays chrominance values for the signal. The boxes represent the standard values for each color. 
4. **Waveform monitor** — Displays luminance values for the signal. The bottom of the green bar represents the limit for a broadcast safe white level. The top of the red bar represents the broacast safe limit for a black level. 

###Passthrough Mode

Passthrough mode means that the vrecord window will show up with video feeds and scopes, but the video signal will not be recorded to a file. Passthrough mode is used for tasks like testing equipment or setting up a tape to bars before actually recording. When you are finished using passthrough mode simply close the vrecord window.

Run passthrough mode by typing:
```
$ vrecord -p
```
Vrecord will prompt you to press enter. When you press enter the vrecord window will open up and start displaying any video signal that is coming from the capture card.

###Edit Mode

This mode opens a GUI window that allows you to change the options for recording the video signal. After selecting all of your options and pressing "OK" the video signal will be recorded to a file with some associated metadata files. When you are done recording, close the vrecord window. If you've set a time limit for capture the vrecord window should automatically close when the time limit has been reached.

Run edit mode by typing:
```
$ vrecord -e
```

By default vrecord will create a video file, a bmdcapture log, a framemd5 file (which creates an MD5 hash value for every frame of video), an ffmpeg log, and an ffplay log. 

#### Options for Video Capture

All of options in the vrecord GUI (which appears when running `vrecord -e`) are explained below. If you want to feel like a college freshman you can choose "Undeclared" for any of the options below. You will be prompted later to make a choice before the program actually starts recording:

**Select a recording directory** — Choose the location where you want your video files and metadata files to be saved. Vrecord will work with an internal or external hard drive.

**Select video input** — Choose how the video signal will be entering the capture card.

**Select audio input** — Choose how the audio signal will be entering the capture card.

**Select file format** — Choose the file format that you want the video to be saved in. This is also often called the container.

**Select codec for video** — Choose how you would like the video signal to be encoded digitally. You can choose from some uncompressed, lossless, and lossy codecs. 

**Select bit depth for video** — Choose the amount of bit depth you would like for your video file. Vrecord currently supports 8 and 10-bit video capture.

**Select audio channel mapping** — Choose how you want the audio to be captured. Currently vrecord captures audio at 24-bits and can only capture 4 tracks. The options are: 
* "2 Stereo Tracks" — For capturing videotape formats that have four tracks which are arranged as stereo pairs.
* "1 Stereo Track" — For capturing videotape formats that have two channels of audio which were recorded as a stereo pair.
* "Channel 1 -> 1st Track Mono, Channel 2 -> 2nd Track Mono" — For capturing videotapes with audio recorded on Channel 1 only. Vrecord will capture the audio from Channel 1 and create a mono track. 
* "Channel 2 -> 1st Mono, Channel 1 -> 2nd Track Mono" — For capaturing videotapes with with audio recorded on Channel 2 only. Vrecord will take the audio from Channel 2 and place it in a Channel 1 mono track. 

**Select standard** — Select the proper television standard for the tape you are digitizing. Currently vrecord only supports NTSC and PAL.

**Visual mode** — Visual mode displays the two video feeds, the waveform monitor, and the vectorscope in the vrecord window.

**Visual + Numerical mode** — Visual and Numerical mode displays your favorite video feeds and scopes as well as numerical values for the characteristics of the video signal on the left sidebar. The numerical values are as follows:

* Y — Low, high, and average luminance of the video signal. "Diff" means the difference of the luminance between successive frames.
* U — Low, high, and average of the U channel value of the video signal. "Diff" means the difference of the U value between successive frames.
* V — Low, high, and average of the V channel value of the video signal. "Diff" means the difference of the V value between successive frames.
* SAT — Low, high, and average saturation values (sometimes called chroma) of the video signal.
* HUE — Low, high, and average hue values of the video signal.
* TOUT — The percentage of pixels that are temporal outliers. Temporal Outliers are pixels which have different values from the pixels above or below them. This is useful for detecting noise in the video signal or other artifacts. However, the number will also increase with fast motion, camera movement, or cuts to different shots.  
* VREP — The amount of vertical line repititions in the video. The VREP reading can be useful for detecting video artifacts, especially head clogs.
* BRNG — Percentage of pixels that are in broadcast range. This may be helpful for detecting problems with the video signal such as dropout or if the signal has not been calibrated properly. If BRNG is 0.1 or greater, you probably have an issue.

**Frame MD5s** — You can choose to create an MD5 hash value for each frame of video captured. A seperate .md5 file with all the hash values will be created along with the video file.

**Set Recording time** — Set the amount of time (in minutes) that you would like vrecord to capture for. This needs to be an integer or decimal. For example, if you are digitizing a tape with a capacity of 30 minutes of video, you might want set vrecord to capture for 32 minutes. After 32 minutes vrecord will automatically stop recording and shut down.

Click "OK" when you are finished with your selections. Vrecord will save all of your selections to a cofiguration file. If any selections are "Undeclared" vrecord will prompt you to make a choice. 

Vrecord will then prompt you for a unique ID. The ID that you type in will become a prefix for the filename of all the resulting files in that recording session. After entering your unique ID you will be asked to press enter enter to start recording. Press enter and start playing your tape. The vrecord window will appear. 

#### A Few Quirks
When you start recording there may be several seconds of delay before the vrecord window actually appears. But don't worry, once you've pressed enter, vrecord is already capturing. 

If you are watching the videotape on a separate monitor and the video feeds on vrecord appear to be slightly behind the monitor, don't panic; all of your video has still been captured. 

### Clearing the Configuration File

By default vrecord saves the choices you made the last time you used the program in a configuration file so that these options are selected the next time you use vrecord. If you would like to clear this configuration file and create a new one type:

```
$ vrecord -x
```
Vrecord will then prompt you to make selections for video capture.

##Help and Issues 

If you are stuck and want to see vrecord's help menu run:
```
$ vrecord -h
```

We want vrecord to be a helpful tool for audiovisual archivists and others. If you experience any problems with vrecord you can open a new issue with our Github [issue tracker](https://github.com/amiaopensource/vrecord/issues). Try to see if you can replicate the issue yourself first and describe in detail what factors led to it. Let us know if you were able to succesfully replicate the issue. 

Feel free to contribute to our github project by creating a fork and sending pull requests.
