# Audio Capture

## Audio Settings

1. To select the audio input you would like to use, go into the configuration mode either by:
   - run `vrecord -e`
   - clicking on the "Edit Settings" button in the GUI (run `vrecord`)

1. Switch from the "Decklink" tab to the "AUDIO" tab under "Input Options" at the top of the configuration window.

![Audio Mode](../audio_mode.png "Audio Mode") 

1. Select the name of the Audio device you want to use from the list.

1. Select desired capture settings. __IMPORTANT NOTE:__ These settings will behave slightly differently depending on what system you are on and/or your device.

* macOS: These settings all relate to the __OUTPUT__ file and do not control the capture settings of your device. It is necessary to set the desired capture sample rate and bit depth either via your device's dedicated software, or through the [Audio MIDI Setup](https://support.apple.com/guide/audio-midi-setup/set-up-audio-devices-ams59f301fda/mac) configuration panel.
* Linux: The sample rate selected in this window will be passed to your device and is both the input sample rate for controlling the device as well as applied to the output file. The bit depth selected here will be used for the output file, with vrecord's input defaulting to PCM signed 32-bit little-endian audio (subject to limitations of your device).
* Blackmagic device: Using a Blackmagic device will always lock output (and input) to 48kHz. Desired bit depth of output file can still be specified.

1. Specify the playback, sidecar, file naming, recording event and directory options as you normally would for vrecord. For details see [Editing Settings](Resources/Documentation/settings.md)

1. Click "OK" to save.