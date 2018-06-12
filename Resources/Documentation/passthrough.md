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
