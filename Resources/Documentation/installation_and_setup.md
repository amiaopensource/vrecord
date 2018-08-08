## Installing vrecord

If you use macOS, you can easily install vrecord using a package manager called Homebrew. To install Homebrew, follow [these instructions](https://brew.sh/).

To install vrecord, run the following two commands in a [Terminal window](https://en.wikipedia.org/wiki/Terminal_%28macOS%29):
```
brew tap amiaopensource/amiaos
brew install vrecord
```
(The first taps the homebrew recipes of the amiaopensource account; the second installs vrecord and the other programs that it requires.)

Alternatively, you can run the following command:
```
brew install amiaopensource/amiaos/vrecord
```

Gnuplot is the program that vrecord uses to generate the jpeg of the QC graphs. It must be installed separately due to a conflicting dependency on a newer version of lua. You will be prompted to install by running the following command:
```
brew install gnuplot --without-lua
```

(This will install gnuplot without lua and allow vrecord to produce an image of the QC graphs along with the qctools report)

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

Thus far installing vrecord on Linux using Linuxbrew has not been successful.

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
