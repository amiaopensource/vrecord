# Vrecord Documentation

This documentation is up to date as of vrecord version 2020-02-10.

## Table of Contents

1. [Summary](#summary)
    1. [Contributing to vrecord](#contributing)
    1. [License](#license)
1. [Installation and Basic Use](Resources/Documentation/installation_and_setup.md)
    1. [Installing vrecord](Resources/Documentation/installation_and_setup.md#installing-vrecord)
    1. [Installing on Linux](Resources/Documentation/linux_installation.md)
    1. [Using vrecord](Resources/Documentation/installation_and_setup.md#using-vrecord)
        1. [Setting Up vrecord for the First Time](Resources/Documentation/installation_and_setup.md#setting-up-vrecord-for-the-first-time)
        1. [Basic Usage](Resources/Documentation/installation_and_setup.md#basic-usage)
        1. [Ending a Capture](Resources/Documentation/installation_and_setup.md#ending-a-capture)
1. [The vrecord Window](Resources/Documentation/vrecord_window.md)
1. [Passthrough](Resources/Documentation/passthrough.md)
    1. [Passthrough Mode](Resources/Documentation/passthrough.md#passthrough-mode)
    1. [Audio Passthrough Mode](Resources/Documentation/passthrough.md#audio-passthrough-mode)
1. [Editing Settings](Resources/Documentation/settings.md)
    1. [Options for Video Capture](Resources/Documentation/settings.md#options-for-video-capture)
    1. [Video Capture Views](Resources/Documentation/settings.md#video-capture-views)
    1. [Clearing the Configuration File](Resources/Documentation/settings.md#clearing-the-configuration-file)
1. [GUI Mode](Resources/Documentation/gui_mode.md)
1. [DV Capture](Resources/Documentation/dv_info.md)
1. [Analog Digitization Tips](Resources/Documentation/analog_digitization.md)
1. [Help and Troubleshooting](Resources/Documentation/troubleshooting.md)
   1. [Testing Your Equipment](Resources/Documentation/troubleshooting.md#testing-your-equipment)
   1. [Known Issues](Resources/Documentation/troubleshooting.md#known-issues)
      1. [Timing of Recording](Resources/Documentation/troubleshooting.md#timing-of-recording)
      1. [FFmpeg Error Message](Resources/Documentation/troubleshooting.md#ffmpeg-error-message)
   1. [Common Questions](Resources/Documentation/troubleshooting.md#common-questions)
   1. [Other Issues](Resources/Documentation/troubleshooting.md#other-issues)

---

## Summary

Vrecord is open-source software for capturing a video signal and turning it into a digital file. Its purpose is to make videotape digitization or transfer easier. Vrecord can capture analog and digital signals through a variety of inputs and can create digital video files in a variety of formats and codecs. Vrecord has been designed with needs of audiovisual archivists in mind. 

Vrecord uses AMIA Open Source’s [ffmpegdecklink](https://github.com/amiaopensource/homebrew-amiaos/blob/master/ffmpegdecklink.rb) to do its dirty work. Other dependencies are: cowsay, [decklinksdk](https://github.com/amiaopensource/homebrew-amiaos/blob/master/decklinksdk.rb), [gtkdialog](https://github.com/amiaopensource/homebrew-amiaos/blob/master/gtkdialog.rb), freetype, sdl and xmlstarlet. Optional dependencies are: deckcontrol, gnuplot, mediaconch, mkvtoolnix, mpv and qcli.

Currently vrecord supports macOS or Linux, and Blackmagic Design capture cards with the Blackmagic driver installed or
AVFoundation for DV capture on macOS. Some notes on [needed hardware](Resources/Documentation/hardware.md) are provided.

If you want to see a more detailed description about how to digitize analog videotape see our document on [analog digitization](Resources/Documentation/analog_digitization.md).


## Contributing

We want vrecord to be a helpful tool for audiovisual archivists and others. Anyone can contribute to vrecord! If you experience any problems with vrecord you can open a new issue with our GitHub [issue tracker](https://github.com/amiaopensource/vrecord/issues). Try to see if you can replicate the issue yourself first and describe in detail what factors led to it. Please let us know if you were able to successfully replicate the issue.

For more tips on using GitHub and contributing directly to vrecord, please see our [Contribution Guide](CONTRIBUTING.md), but feel free to contribute to vrecord by creating a fork and sending pull requests.

Enjoy!

The vrecord Team

## License

<a rel="license" href="https://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/80x15.png"></a><br>Vrecord is licensed under a <a rel="license" href="https://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.

## Installing vrecord

### macOS

If you use macOS, you can easily install vrecord using a package manager called Homebrew. To install Homebrew, follow [these instructions](https://brew.sh/).

To install vrecord, run the following two commands in a [Terminal window](https://en.wikipedia.org/wiki/Terminal_%28macOS%29):
```
brew tap amiaopensource/amiaos
brew install vrecord
```
(The first taps the homebrew recipes of the amiaopensource account; the second installs vrecord and the other programs that it requires.)

Once vrecord has been successfully installed, you can update it to the latest release by first running:
```
brew update
```
(This updates all of your Homebrew recipes to the latest versions.)

Then running:
```
brew upgrade vrecord
```
(This downloads the latest release of vrecord and the latest releases of any other packages it depends on.)

Alternatively, you can run:
```
brew upgrade
```
(This command will upgrade all of the programs you've installed through Homebrew.)

### Linux

As of version 2019-01-19, vrecord can now be installed on select Linux distributions, also via [Homebrew](https://docs.brew.sh/Homebrew-on-Linux), using the same Terminal commands:
```
brew tap amiaopensource/amiaos
brew install vrecord
```
If you experience installation issues, however, it may be beneficial to first install vrecord's core dependencies, and then install vrecord without dependencies:
```
brew install decklinksdk && brew install ffmpegdecklink && brew install gtkdialog
brew install --ignore-dependencies vrecord
```
Note: these commands only cover vrecord's core capture functionality. If you're interested in the full vrecord experience, you'll need to install a number of other [dependencies](https://github.com/amiaopensource/homebrew-amiaos/blob/master/vrecord.rb) individually. 

## Using vrecord

### Setting up vrecord for the First Time

In macOS, open System Preferences and click on the icon for Blackmagic Design. If you do not see this icon in System Preferences you may not have installed the Blackmagic driver. 

Open up the Blackmagic Design preferences and click on the "Settings" tab. Select your input and output from the dropdown menu depending on what cables you have connected to the capture device. 

Once your capture device is set up you can start vrecord by simply opening up a [Terminal window](https://en.wikipedia.org/wiki/Terminal_%28macOS%29) and typing 
```
vrecord 
```
The first time you use vrecord you will be asked to make some initial choices about how you want to capture. Any decisions you make will be saved in a configuration file. But don't worry, you will be able to alter these decisions later. 
Vrecord will ask you for video and audio inputs. These should agree with your settings for the Blackmagic capture device. Vrecord's other settings can be tailored to your liking. See the section on [Options for Video Capture](settings.md#options-for-video-capture) which explains all of the settings in detail.

### Basic Usage

For those who want the simplest possible explanation on how to use vrecord:

1. Run `vrecord -p`.
1. Choose the appropriate options when prompted.
1. Play your tape in the connected VTR and set up to color bars and audio on the tape (if possible).
1. Close the vrecord window to end passthrough mode.
1. Now run `vrecord -e` and make sure all options are correct in vrecord's GUI window.
1. Type in a unique identifier for your video file when prompted.
1. Press "enter" to start recording.
1. Let 'er rip! Play your tape!
1. Let vrecord do its thing. Don't type any keys while the vrecord window is open, do not click the mouse inside the vrecord window, and do not start another instance of vrecord on the same computer. In fact it's best not to open or use any other programs on the computer that is capturing. Overtaxing the computer could cause errors in the capture. 
1. If you are finished recording and the vrecord window hasn't already closed, close the window.
1. Check the Terminal window for any error messages. Hopefully you don't see any cows. (See [Ending a Capture](#ending-a-capture) below for more details)
1. Check to make sure that your video and metadata files were successfully created. 
1. Repeat steps 1–12 as needed.

### Ending a Capture

If you are finished recording and the player window hasn't already closed, close the window. You can also press `q` or `esc` while the player window is active.

After the transfer is finished, vrecord will automatically check for the following transfer errors:

* Presentation timestamp discontinuities in the frame MD5s (if they were created), or missing frames in the FFmpeg log (if frame MD5s were not created).
  * Error message: "WARNING: There were presentation timestamp discontinuities found in the framemd5s. This error may indicate frames dropped by FFmpeg or vrecord. The file may have sync issues." The message may give the frame numbers that are missing. Check the file immediately at these points and throughout the video to make sure there are no sync issues.
  * These errors are caused by digital encoding/decoding issues that lead to missing information.
* Frames dropped because of a disconnected signal.
  * Error message: "WARNING: FFmpeg Decklink input reported dropped frames in the following ## locations. This error may indicate an interrupted signal between hardware components. The file may be missing content." The message will give the timestamps where content may be missing. Check the file at these points and throughout the video to make sure it is complete.
  * These errors are caused when no signal reaches the computer, and could be caused by a disconnect (e.g. unplugged cable) between the video deck and Blackmagic hardware, or Blackmagic and computer.
* File conformity to codec standards.
  * If the video codec is Uncompressed Video or FFV1, vrecord will validate file against a vrecord MediaConch policy to ensure the file conforms to those standards. Conformance to these standards is important for long-term digital preservation.
  * If the file doesn't conform to these policies, it is probably because of a bug in vrecord itself or the tools it relies on. Please let us know if this happens by filing an issue in our GitHub [issue tracker](https://github.com/amiaopensource/vrecord/issues)!

Check the Terminal window for any error messages. If you get these messages, the tape may need to be redigitized in order to ensure all information is encoded.

If you [chose](settings.md#options-for-video-capture) to generate a QCTools file or embed logs from digitization, vrecord will start those processes as well.

# Steps for a successful install of Vrecord on Linux

## About
There are many possible ways to install the various dependencies of Vrecord on Linux. 

## via Linuxbrew (tested Ubuntu 18.04)
The following instructions aim to minimize use of linuxbrew installs for packages that can otherwise be installed via native Linux methods. When followed in order, these commands should result in a fully functional install of vrecord (tested on Ubuntu 18.04)

### Programs to be installed manually

* Download and install the latest Linux version of 'Blackmagic Desktop Video' from the [Blackmagic website](https://www.blackmagicdesign.com/support/)
* Download and install the latest version of the QC Tools CLI tool from the [MediaArea](https://mediaarea.net/QCTools/Download/Ubuntu)
* Optional: If DV wrapping and splitting is desired, download and install [DVRescue](https://mediaarea.net/DVRescue) from the MediaArea website.

### Programs to be installed via PPA

* Install MPV with the following steps:
  - Add the MPV PPA with: `sudo add-apt-repository ppa:mc3man/mpv-tests`
  - Update package manager with: `sudo apt-get update`
  - Install MPV with `sudo apt-get install mpv`

### Programs to be installed via standard package manager

* Use the following commands to install additional dependencies for full vrecord use:
  - `sudo apt-get install curl`
  - `sudo apt-get install gnuplot`
  - `sudo apt-get install xmlstarlet`
  - `sudo apt-get install mkvtoolnix`
  - `sudo apt-get install mediaconch`
* Install the following dependencies for enabling DV capture in vrecord's FFmpeg build:
  - `sudo apt-get install libiec61883-dev`
  - `sudo apt-get install libraw1394-dev`
  - `sudo apt-get install libavc1394-dev`
  - `sudo apt-get install libavc1394-tools`
* If `make` and `gcc` are not already installed, install them with
  - `sudo apt-get install gcc`
  - `sudo apt-get install make`
  
### Install Homebrew for Linux (Linuxbrew)
* Use the following commands, (sourced from the [Homebrew docs](https://docs.brew.sh/Homebrew-on-Linux)) to install and configure Homebrew on Linux:
 - Install linuxbrew with: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"`
 - Add linuxbrew to path with: 
~~~
 test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)

 test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

 test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >> ~/.bashrc
 ~~~

  - Alternately some issues (such as the sdl2 conflict) have been avoided by adding Linuxbrew lower down in the path order than the Linuxbrew instructions call for (Such as by editing `/etc/environment` to include `/home/linuxbrew/.linuxbrew/bin` after the other $PATH directories.) Your mileage may vary!
 * Add the AMIA Open Source tap for Homebrew:
   - `brew tap amiaopensource/amiaos`

### Install additional vrecord dependencies via Brew
* `brew install decklinksdk && brew install ffmpegdecklink --with-iec61883 && brew install gtkdialog`
* `brew install vrecord`

### Fix conflicting SDL2 dependencies
* `brew uninstall --ignore-dependencies sdl2`
* `sudo apt install libsdl2-dev`
* This step may not be required if Brew has been configured lower in $PATH than standard system directories.

## via RPM (tested on CentOS 7/8 and Fedora 31)
This method is maintained by [Jonáš Svatoš](mailto:jonas.svatos@nfa.cz) at [Národní filmový archiv](https://github.com/NFAcz)
and contains patches which modify Vrecord source to bypass some hardcoded Homebrew-specific variables. It also adds a nice menu entry.

### Install RPM from COPR repository
Follow the instructions on https://copr.fedorainfracloud.org/coprs/lsde/vrecord/

### Build the RPM yourself
```
$ git clone https://github.com/NFAcz/vrecord-rpm.git
$ spectool -g -R vrecord.spec
$ cp *.patch ~/rpmbuild/SOURCES/
$ rpmbuild -bb vrecord.spec
```

## The vrecord Window

![Alt text](../vrecord_broadcast_range_visual_2016-11-22.jpg "Vrecord in Broadcast Range Visual Mode")

Shown above is the default layout of the vrecord window in "Broadcast Range Visual" mode. Vrecord also includes several other display modes discussed in [Video Capture Views](settings.md#video-capture-views).

1. **Video feed** — Displays the entire 720 x 486 video signal coming through. The image will appear a bit more stretched than it does on a television monitor. 
1. **Video feed with broadcast-safe indicator** — Displays a feed of an underscanned version of the video signal. Pixels whose luminance or chrominance is outside of broadcast range are colored yellow. Due to space constraints in the vrecord window this feed will appear slightly squeezed.  
1. **Waveform monitor** — Displays luminance values for each field of the signal separately.
1. **Vectorscope** — Displays chrominance values for the signal. The boxes represent the values for yellow, red, magenta, blue, cyan, and green. The boxes furthest from the center represent the broadcast limits for those colors.

## Passthrough Mode

Passthrough mode means that the vrecord window will appear with video feeds and scopes, but the incoming video signal will not be recorded to a file. Passthrough mode is best used for tasks like testing equipment or setting up a tape to bars before actually recording. When you are finished using passthrough mode, simply close the vrecord window.

Run passthrough mode by typing:
```
vrecord -p
```
If you haven't already set up vrecord it will prompt you to make some selections related to your audio and video inputs. Otherwise the vrecord window will open up and start displaying any video signal coming through from the capture device. 

## Audio Passthrough Mode

Audio passthrough mode is the same as passthrough mode with the addition of audio bars to monitor levels. It can be used to check audio track layout and confirm input levels before starting a transfer. Audio passthrough mode can be used to check audio track layout and confirm input levels before starting a transfer. Each bar represents a different audio track: the top bar is track 1, the second bar is track 2, the third bar is track 3, and the fourth bar is track 4. The numbers next to the bars are decibels in dBFS.

Currently audio passthrough mode does not support the Visual + Numerical view option.

Run audio passthrough mode by typing:
```
vrecord -a
```

### Edit Mode

Running vrecord in edit mode opens a GUI window that allows you to change your recording options and then start digitizing a tape. 

Run edit mode by typing:
```
vrecord -e
```
![vrecord window](../vrecord_settings.png)

After selecting all of your options and clicking "OK," you will be prompted to enter a unique ID for the file. After the ID is entered, the incoming video signal will be recorded to a file with some associated metadata files. When you are finished recording, you can close the vrecord window. If you've set a time limit for capture, the vrecord window will automatically close when the time limit has been reached.

By default, vrecord will create a video file, a framemd5 file (which creates an MD5 hash value [AKA a checksum] for every frame of video), an ffmpeg log, and a capture options log (which records the options that you selected in the GUI like codec and video bit depth). Vrecord will check all FFV1 and uncompressed video files in QuickTime or Matroska wrappers against local [MediaConch](https://mediaarea.net/MediaConch/about.html) policies, and will alert the user if the file does not conform to vrecord and archival standards. Vrecord can also create a [QCTools](https://github.com/bavc/qctools) XML file, which measures characteristics of the video signal, and a PNG file, which provides an easy-to-assess, overarching view of the video signal across time. The QCTools XML can be imported into QCTools for further analysis. 

#### Options for Video Capture

All of the options in the vrecord GUI (which appears when running `vrecord -e`), or otherwise in terminal prompts, are explained below. If you want to feel like a college freshman, you can choose "Undeclared" for any of the options below. You will be prompted later to make a choice before the software actually begins recording:

**Select a recording directory** — Choose the location (on an internal or external hard drive) where you want your resulting video files and logs to be saved.

**Select video input** — Choose how the video signal will be entering the capture device. You can receive the video signal through Composite, SDI, Component, or S-Video cables.

NOTE: Setting the video input in Desktop Video Setup to match this option will reduce the likelihood of some dropped frames at the beginning of the capture.

**Select audio input** — Choose how the audio signal will be entering the capture device. You can receive the audio signal through Analog (such as XLR), SDI, or other digital audio cables.  

**Select file format** — Choose the file format that you want the video to be saved in. This is also often called the container.

**Select codec for video** — Choose how you would like the video signal to be encoded digitally. You can choose from some uncompressed, lossless, and lossy codecs.

**Select bit depth for video** — Choose the level of bit depth you would like for your video file. Vrecord supports 10 and 8-bit video capture.

**Select FFV1 slice count** - If you select FFV1 as your video codec, you will be prompted to choose between a number of "slice count" options. An error detection/correction mechanism specific to FFV1, slices allow for each frame of video to be split into sub-sections, which will, in turn, each receive their own CRC checksum value. Keep in mind that the higher the slice count, the larger the resulting file.

**Select codec for audio** - Choose how you would like the audio signal to be encoded digitally. You can choose between uncompressed or lossless codecs.

**Select audio channel mapping** — Choose how you want the audio to be captured. Currently vrecord captures audio at 24-bits and can only capture 4 tracks. The options are: 
* "2 Stereo Tracks" — For capturing videotape formats that have four tracks which are arranged as stereo pairs.
* "1 Stereo Track (From Channels 1 & 2)" — For capturing videotape formats that have two channels of audio which were recorded as a stereo pair.
* "1 Stereo Track (From Channels 3 & 4)" — Same as above, but creates stereo track from second pair of inputs.
* "Channel 1 -> 1st Track Mono, Channel 2 -> 2nd Track Mono" — For capturing videotapes with audio recorded on Channel 1 only. Vrecord will capture the audio from Channel 1 and create a mono track. 
* "Channel 2 -> 1st Mono, Channel 1 -> 2nd Track Mono" — For capturing videotapes with with audio recorded on Channel 2 only. Vrecord will take the audio from Channel 2 and place it in a Channel 1 mono track. 

**Select timecode format** - vrecord now offers limited timecode support by (1) storing a correct first timecode value within your file, and (2) creating a sidecar .txt that will contain the timecode values, continuous or not, for all video frames. If you are uncertain about the type of historical timecode recorded on your tape, the "Scan timecode formats" button located below this drop-down menu will test your tape and provide useful information. The options for timecode include:
* rp188vitc
* rp188vitc2
* rp188ltc
* rp188any
* vitc
* vitc2
* serial

**Select standard** — Select the television standard of the tape you are digitizing. Currently vrecord only supports NTSC and PAL.

**Select view (for recording)** — Select the display you want to see as you digitize your tape. See [Video Views](#video-views) below for more details.

**Select view (for passthrough)** — Select the display you want to see as you preview your tape before capture. See [Video Views](#video-views) below for more details.

**Create QCTools XML?** — vrecord can create an XML file that contains a measurement of the characteristics of the video signal (such as luminance, color saturation, audio levels, etc.). vrecord can create this file either during capture, or as a post process. The XML will then be compressed using [gzip](https://www.gnu.org/software/gzip/).
* Choosing to create a QCTools XML is highly recommended. These files can be easily imported into QCTools for further analysis and, if you choose this option, vrecord will also (1) analyze the video for potential errors (reporting in your terminal window, post-capture, about the signal's adherence to broadcast range specifications), and (2) use this QCTools data to generate a easy-to-review [image file](https://github.com/amiaopensource/vrecord/blob/master/Resources/Documentation/analog_digitization.md#qc-graphs).

**Frame MD5s** — You can choose to create an MD5 hash value (AKA a checksum) for each frame of video captured. Frame MD5s are strongly recommended, as some dropped-frame errors will not be caught without the hash values. A separate .md5 file with all the hash values will be created along with the video file. Generally choosing to create frame-level MD5s will not slow down or hinder the capture of your video. To read more about the value of frame-level MD5s see this article: http://dericed.com/papers/reconsidering-the-checksum-for-audiovisual-preservation/ 

**Embedding logs** — If you select the Matroska file format, vrecord can embed the logs it generates into the Matroska container. Preservation metadata will then be available to the user both as sidecar logs (the vrecord default) and within the file itself. After logs have been attached, you can extract and read them as follows:
* To show a list of attachments to a video file and their IDs, type: `mkvmerge -i [video filename]`
* To extract attachments with IDs 1 through 4, type: `mkvextract [video filename] attachments 1 2 3 4`
* The logs will then be extracted into the directory you're in, where they can be opened with a text editor.

**Set recording time** — Set the amount of time (in minutes) that you would like vrecord to capture for, or leave it blank to capture indefinitely. For example, if you are digitizing a tape with a capacity of 30 minutes of video, you might want set vrecord to capture for 33 minutes. After 33 minutes vrecord will automatically stop recording and shut down. You may select a preset length from the dropdown menu, or type a different number. If you enter a number, it should be an integer or decimal in minutes (e.g. `15` will record for 15 minutes, and `15.75` will record for 15 minutes and 45 seconds).

**Enter the name of the person digitizing this tape** — This field is optional. You can enter the name of the technician digitizing the tape. The name will be written to the capture options log produced at the end of the transfer.

**Invert Second Channel of Audio** — This option allows you to invert the phase of the second channel of audio on ingest. This option is only for rare cases. Use only if you are positive that the audio channels are 180 degrees out of phase!

Click "OK" when you are finished with your selections. Vrecord will save all of your selections to a configuration file. If any selections are "Undeclared" vrecord will prompt you in the terminal window to make a choice. 

Vrecord will then prompt you for a unique ID. The ID that you type in will become a prefix for the filename of all the resulting files in that recording session. After entering your unique ID you will be asked to press enter to start recording. Press enter and start playing your tape. The vrecord window will appear. Do not type any keys or click the mouse inside the window while the vrecord is working. 

#### Video Views

**Unfiltered mode** — Unfiltered mode display only the playback image in the vrecord window. This option works well to aviod buffer overruns, PTS discontinuties, and crashing for setups that cannot handle the additional processing during capture.

**Broadcast Range Visual mode** — Broadcast Range Visual mode displays the video feed, the video feed with pixels out of broadcast range highlighted, the waveform monitor, and the vectorscope in the vrecord window.

**Full Range Visual mode** — Full Range Visual mode displays the video feed, the video feed with pixels at full range extremes highlighted, the waveform monitor, and the vectorscope in the vrecord window.

**Visual + Numerical mode** — Visual and Numerical mode displays your favorite video feeds and scopes as well as numerical values for the characteristics of the video signal in the left sidebar. 

![Alt text](../vrecord_visual_numerical_2016-11-22.jpg "Vrecord in Visual + Numerical Mode")

* The numerical values are as follows:

    * Y — Low, high, and average luminance of the video signal. "Diff" means the difference of the luminance between successive frames.
    * U — Low, high, and average of the U channel value of the video signal. "Diff" means the difference of the U value between successive frames.
    * V — Low, high, and average of the V channel value of the video signal. "Diff" means the difference of the V value between successive frames.
    * SAT — Low, high, and average saturation values (sometimes called chroma) of the video signal.
    * HUE — Low, high, and average hue values of the video signal.
    * TOUT — The percentage of pixels that are temporal outliers. Temporal Outliers are pixels which have different values from the pixels above or below them. This is useful for detecting noise in the video signal or other artifacts. However, the number will also increase with fast motion, camera movement, or cuts to different shots.  
    * VREP — The amount of vertical line repetitions in the video. The VREP reading can be useful for detecting video artifacts, dropout, and especially head clogs.
    * BRNG — Percentage of pixels that are in broadcast range. This may be helpful for detecting problems with the video signal such as dropout or if the signal has not been calibrated properly. If BRNG is 0.1 or greater, you probably have an issue.

**Color Matrix mode** — Color Matrix mode displays the video feed as seen through a matrix with hue and saturation differences to aid in calibrating hue and chroma. If the preferred image is not seen in the center square of the matrix, hue and chroma levels may need to be adjusted.

![Alt text](../vrecord_color_matrix_2016-11-22.jpg "Vrecord in Color Matrix Mode")

**Bit Planes mode** — Bit Planes mode allows to display the video according to the bit position of each plane.

**Quality Control View mode** — Quality Control View mode can display all the views above, as well as several other quality control tools (waveforms, vectorscopes, and histograms). The menu in QC View shows options tied to keystrokes; pressing the key listed next to the name of the view you want will display that view. This feature means you can switch between several different views during the same transfer. QC View key bindings are as follows:

* Views
  * 1 — Broadcast Range Visual
  * 2 — Full Range Visual
  * 3 — Visual + Numerical
  * 4 — Color Matrix
  * 5 — Bit Planes
  * 6 — Split Fields: Splits a video frame into its two fields (odd lines appear in the top half of the image, even lines in the bottom half). QC View shows these fields in four pairs. Clockwise from top left: entire image, Y-values only, V-values only, U-values only.

  ![Alt text](../vrecord_qcview_splitfields.png "Vrecord: Split Fields view in QC View Mode")

* Other tools to monitor video transfer
  * 7 — Color waveform: Full-screen waveform rendered in the actual color values of the signal.
  * 8 — Overlaid waveform: The above, but overlaid on the video signal.
  * 9 — Color vectorscope: Full-screen vectorscope rendered in the actual color values of the signal.
  * 0 — Overlaid vectorscope: The above, but overlaid on the video signal.
  * o — Oscilloscope: Displays luma and two chroma values for one line in the frame (line is indicated by white dots).
  * h — Histogram: Displays frequency with which values in each channel occur, with one graph per channel (YUV or RGB, depending on input).
  * H — Overlaid histogram: The above, but laid end-to-end and overlaid on the video signal.
* Toggling the display
  * d — Toggle display filter: Switches between Y-only and YUV waveform displays (in views 1-3).
  * w — Toggle waveform filter: Switches between different waveform filters (in views 1-3): "lowpass," "flat," "aflat," "chroma," "color," "acolor." For more information, see [FFmpeg waveform filter documentation](https://ffmpeg.org/ffmpeg-filters.html#waveform).
  * g — Toggle graticule: Switch graticule (the lines and targets on waveforms and vectorscopes) on and off. (Applies in views 1-3 and 7-0.)
  * p — Toggle peak envelope: Switch between options to display the minimum and maximum values recorded by the waveform and vectorscope (in views 1-3). "None" means you won't see the peak values; "instant" means peak values will be highlighted as they occur; "peak" holds peak values across the full transfer for reference; and "peak+instant" combines the two.
  * i — Increase image intensity.
  * I — Decrease image intensity.
  * = — Refresh onscreen display. Useful if menu options disappear.
  * f — Make window fullscreen. (Press 'f' again to exit.)
  * ctrl + s — Turn off the above key assignments to use default mpv key bindings.
  
#### Clearing the Configuration File

  By default vrecord saves the choices you made the last time you used the program in a configuration file so that these options are selected the next time you use vrecord. If you would like to clear this configuration file and create a new one type:

  ```
  vrecord -x
  ```
  Vrecord will then prompt you to make selections for video capture and proceed to start recording a new tape. If you want to interrupt vrecord hold down `ctrl + c`.

  ## GUI Mode

Running vrecord in GUI mode opens a window that allows you to access any of vrecord's other modes (Record, Passthrough, Audio Passthrough, and Edit) via a friendly GUI. 

Run GUI mode by typing:
```
vrecord -g
```
Click the buttons to run Vrecord in your chosen mode. The documentation button brings you to this website!

![Alt text](../vrecord_gui_mode.png "Vrecord in GUI Mode")

# DV Capture

To capture DV formats in vrecord (when installed in macOS), you will need to have your DV deck connected directly to your computer via FireWire input. Make sure your deck is in “Local” mode.

## DV Settings

1. To select the deck you would like to use, go into the configuration mode either by:
   - run `vrecord -e`
   - clicking on the "Edit Settings" button in the GUI (run `vrecord -g`)

![Decklink](../dv_vrecord_decklink.jpg "DV Capture") 

1. Switch from the "Decklink" tab to the "DV" tab under "Input Options" at the top of the configuration window.

![DV Capture](../dv_vrecord_configuration.jpg "DV Capture") 

1. Select the name of the DV device you want to use from the list.

1. Specify the playback, sidecar, file naming, recording event and directory options as you normally would for vrecord. For details see [Editing Settings](Resources/Documentation/settings.md)

1. Click "OK" to save.

You can then run passthrough and record modes the same as you would with analog videotape. Please note that if the timecode does not start at the very beginning of the tape, the record mode viewer will not open until the timecode is detected (as soon as the counter starts moving on your deck, the viewer window should pop-up)

When using the GUI, environment parameters can be adjusted in the Config tab.

![DV Capture config](../dv_vrecord_configuration2.jpg "DV Capture")  

## Bitstream Error Concealment

If vrecord detects that the DV device is concealing bitstream errors, this will be noted in the Terminal.
![Alt text](../dv_vrecord_bitstream_concealment.png "Detection of Bitstream Error Concealment")

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
1. Bmdcapture log (filename\_bmdcapture.log)
1. FFmpeg log (filename\_ffmpeg\_date\_time.log)
1. FFplay log (filename\_ffplay\_date\_time.log)
1. Frame MD5 file (filename.framemd5) if you chose to record frame MD5s, which you should do
1. A capture options log (filename\_capture\_options.log)
1. A QCTools XML file, if you chose to create it (filename.qctools.xml.gz)
1. An image file of QC graphs (filename\_QC\_output\_graphs.jpeg) if you chose to create the QCTools XML file

Scroll through the video file to make sure it is complete; in other words, you've captured the entire tape. If all these files exist and the video file looks complete you can move on to further QC.

### QC Graphs
Vrecord can now create an image that contains seven graphs of the data collected during the QCTools analysis. These graphs include the min/max audio levels, the peak audio levels the audio phase, the percentage outside of broadcast range, percentage of temporal outliers, the saturation levels (avg and max), and the structural similarity metric (Y,U,V). These characteristics are plotted and colored to highlight values that fall outside acceptable ranges. This feature was introduced to help with the rapid assessment of a recording immediately after it has been generated. The characteristics selected and the highlighted values are intended to clearly illustrate the general success or failure of a recording without the need for additional QC. For example, if a recording is far too loud or the blacks are too dark, that will be immediately apparent and the recording can be redone without having to be extensively reviewed.   

Version 2 introduces the following updates: 

1. The version number is now included into the Graph’s title
1. The color range for the plot of %Outside of Broadcast Range was widened from 0-3% to 0-5%. The new range defines 0 as green, 2% as yellow, and 5% as red
1. The label of for each plot has been moved to the top center of each plot and displayed over the plotted data
1. Minor changes have been made to fonts, size, and position of scales and keys

**Example of QC Graphs Version 2**

<img src="../vrecord_QC_output_graphs_ver2.jpeg" alt="vrecord_QC_output_graphs_ver2" width="1024px" height="576px" alt=text text="QC Graphs" title="QC Rapid Assessment Graphs"/>

## Help and Troubleshooting

### Testing Your Equipment

If you want to test and adjust your monitor without a test tape, whether to avoid overuse of a deck or because you don't have a test tape, you can pipe preset bars and tone, a local combination of test sources, or your own test file through your BlackMagic card.

To pipe NTSC bars and tone through your BlackMagic card to your monitor, run:
```
vtest -n
```

To pipe PAL bars and tone through your BlackMagic card to your monitor, run:
```
vtest -p
```

To pipe an audio test with visuals to distinguish left and right channels, run:
```
vtest -a
```

To set a local combination of video and audio test sources, run:
```
vtest -e
```

To run the most recently set combination of video and audio test sources, run:
```
vtest -l
```

To play your own test file, run:
```
vtest -f [TESTFILE]
```
This test file must be in a format (frame size/frame rate combination) compatible with your BlackMagic device. To see a list of accepted formats, run `[ffmpegdecklink location] -f decklink -list_formats 1 -i [BlackMagic device name]` (for example, `/usr/local/opt/ffmpegdecklink/bin/ffmpeg-dl -f decklink -list_formats 1 -i 'UltraStudio 3D'`)

To see this options in the command line interface, run `vtest -h`.

### Known Issues

##### Timing of Recording
When you start recording there may be several seconds of delay before the vrecord window actually appears. But don't worry, once you've pressed enter, vrecord is already capturing the signal and encoding it into a file. 

If you are watching the videotape output on a separate monitor and the video feeds on vrecord appear to be slightly behind the monitor, don't panic; all of your video has still been captured. 

##### FFmpeg Error Message

At the end of your capture you may see a warning in the Terminal that looks similar to this:

```
[v210 @ 0x7fad3c800000] packet too small
Error while decoding stream #0:0: Invalid data found when processing input
[v210 @ 0x7fe62301c000] packet too small
```

You can safely ignore this warning, it's just FFmpeg complaining that it didn't receive a full frame of video when vrecord stopped.

Or you may see

```
av_interleaved_write_frame(): Broken pipe
Error writing trailer of pipe:: Broken pipe
```

This happens when vrecord stops because the ffplay playback window is closed, this stops ffplay but ffmpeg is still writing video data out but ffplay is no longer running, so ffmpeg provides this warning. This is a part of how vrecord is designed to end recordings and is expected.

### Common Questions

**Q: I ran `vrecord -p` and no video is showing up in the vrecord window!**

A: Check to make sure all of your cables are routed properly. Also check macOS System Preferences to make sure that the Black Magic capture device is set up properly. If you are using SDI for your input on vrecord, the output of the Blackmagic should be set to SDI.

**Q: My tape finished early, how do I stop vrecord?**

A: Simply close the vrecord window and the program will automatically stop. You should then examine your video file to make sure it's complete.

### Other Issues

If you are otherwise stuck and want to see vrecord's help menu run:
```
vrecord -h
```
or check the man page:
```
man vrecord
```

Please also consult and contribute to vrecord's [Issue Tracker](https://github.com/amiaopensource/vrecord/issues) on GitHub. Other users may be having the same problems, and developers can offer tips, troubleshooting and guidance!