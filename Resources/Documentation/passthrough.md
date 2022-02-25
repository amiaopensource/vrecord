## Passthrough Mode

Passthrough mode means that the vrecord window will appear with video feeds and scopes, but the incoming video signal will not be recorded to a file. Passthrough mode is best used for tasks like testing equipment or setting up a tape to bars before actually recording. When you are finished using passthrough mode, simply close the vrecord window.

Run passthrough mode by typing:
```
vrecord -p
```
If you haven't already set up vrecord it will prompt you to make some selections related to your audio and video inputs. Otherwise the vrecord window will open up and start displaying any video signal coming through from the capture device. 

## Audio Passthrough Mode

Audio passthrough mode is a quick way to check audio characteristics of an input without needing to modify any settings in your configuration file - it will automatically open a passthrough window in 'Audio + Video' mode.

Note: If in audio capture mode there is no difference between the standard preview window and audio passthrough.

Run audio passthrough mode by typing:
```
vrecord -a
```
