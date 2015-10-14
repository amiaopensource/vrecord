# vrecord Readme

## Summary

Vrecord is open-source software for capturing a video signal and turning it into a digital.

## Installing vrecord

Here's how you install vrecord...

## Using vrecord

###Passthrough Mode

Run passthrough mode by typing:
```
$ vrecord -p
```

Passthrough mode means that the vrecord scopes and video windows will show up, but the video signal will not be recorded to a file. This is used for things like testing your equipment or setting up a tape to bars before actually recording. When you are finished using passthrough mode simply close the vrecord window.

###Edit Mode

This mode opens a GUI window that allows you to set up all the options for recording the video signal. After selecting all of your options the video signal will be recorded to a file with some associated metadata files. When you are done recording, close the vrecord window.

Run edit mode by typing:
```
$ vrecord -e
```

#### The vrecord GUI in Edit Mode

All of options in the vrecord GUI are explained below

"Select

"Visual" mode

"Visual + Numerical" — Visual and Numerical mode includes your favorite video windows and scopes as well as numerical values for the characteristics of the video signal on the left sidebar. The numerical values are as follows:


Frame MD5s — You can choose to create an MD5 hash value for each frame of video. A seperate .md5 file with all the hash values will be created along with the video file.

"Set Recording time" — Set the amount of time (in minutes) that you would like vrecord to run for. For example, if you are digitizing a 30 minute tape, you might want to record for 32 minutes. 




