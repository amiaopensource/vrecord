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

**Q: The decklink input is not working in vrecord on macOS Big Sur?**

A: First, try updating Desktop Video at the [Blackmagic site](https://www.blackmagicdesign.com/support/) and seeing if Media Express will see your decklink input. If still not working, the advise to uninstall and reinstall Desktop Video at https://github.com/amiaopensource/vrecord/issues/650#issuecomment-770501964 has stepped some.

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
