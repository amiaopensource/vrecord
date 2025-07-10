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
    1. [Video Capture Views](Resources/Documentation/settings.md#video-views)
    1. [Clearing the Configuration File](Resources/Documentation/settings.md#clearing-the-configuration-file)
1. [DV Capture](Resources/Documentation/dv_info.md)
1. [Audio Capture](Resources/Documentation/audio_info.md)
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

Vrecord uses MediaArea’s [ffmpeg-ma](https://github.com/MediaArea/homebrew-mediaarea/blob/master/ffmpeg-ma.rb) to do its dirty work. Other dependencies are: cowsay, [decklinksdk](https://github.com/amiaopensource/homebrew-amiaos/blob/master/decklinksdk.rb), [gtkdialog](https://github.com/amiaopensource/homebrew-amiaos/blob/master/gtkdialog.rb), freetype, sdl and xmlstarlet. Optional dependencies are: deckcontrol, gnuplot, mediaconch, mkvtoolnix, mpv and qcli.

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

## Maintainers
The vrecord maintainers are:

Dave Rice (@dericed)

Ben Turkus (@bturkus)

Annie Schwiekert (@aeschweik)

Andrew Weaver (@privatezero)
