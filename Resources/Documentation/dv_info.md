# DV Capture

To capture DV formats in vrecord (when installed in macOS), you will need to have your DV deck connected directly to your computer via FireWire input. Make sure your deck is turned on and in “Remote” mode. Additional settings for your DV device may apply. To view manuals and settings notes for specific decks, players and camcorders, please see the [DV Deck Guide]([url](https://mipops.github.io/dvrescue/sections/deck_guide.html)).

## DV Settings

1. To select the deck you would like to use, go into the configuration mode either by:
   - run `vrecord -e`
   - clicking on the "Edit Settings" button in the GUI (run `vrecord`)

![Decklink](../dv_vrecord_decklink.jpg "DV Capture") 

2. If using vrecord to capture DV for the first time, you will need to switch from the "Decklink" tab to the "DV" tab under "Input Options" at the top of the configuration window. All of the devices you have connected via FireWire will be listed under the "DVRescue input options" at the top of the window.

![dv_vrecord_configuration](https://github.com/user-attachments/assets/3882dfd6-b441-4821-8676-2c5240e808c5)

3. If no devices are listed, click the "rescan" button below the list. If this doesn't work, make sure your device is connected and turned on. For additional troubleshooting related to device connectivity, please see the [DVRescue Troubleshooting]([url](https://mipops.github.io/dvrescue/sections/troubleshooting.html)) documentation page.

4. Select the name of the DV device you want to use from the "Select a DV Device" list.

5. Specify the playback, sidecar, file naming, recording event and directory options as you normally would for vrecord. For details see [Editing Settings](Resources/Documentation/settings.md)

6. Click "Save Settings" to save.

7. You can then run passthrough and record modes the same as you would with analog videotape. Make sure you have a tape inserted before attempting playback or recording.

8. When using the GUI, environment parameters can be adjusted in the "Config" tab.

![dv_vrecord_configuration2](https://github.com/user-attachments/assets/aebdf1d8-4cfa-4866-8f09-eae68cccb0c8)



## Playback

![dv_vrecord_playback_NEW](https://github.com/user-attachments/assets/7624a24f-8f20-43f4-b937-c143355782ec)


1. Select the name of the DV device you want to use from the "Select a DV Device" list.

2.  Click the "deck control" button to allow vrecord to control your device. The status should switch to display "stopped" in status field (the status will "disabled" if "deck control" is selected). 

3.  Use the cooresponding buttons under "status" to fast forward, rewind, play and stop the tape. These buttons will not respond if "deck control" is disabled. The status of the deck (i.e. stopped, rewinding, play, etc.) will be displayed in the "status" field.

4. Click the "repack" to repack your tape (fast forward the tape all the way and then rewind it). This button will not respond if "deck control" is disabled.

5. To view the tape, click on the "Playback" button in the bottom right of the "Settings" window. The settings menu will close and the Terminal window will display the settings you have entered.

6. A mpv window will open displaying the playback of the tape once dvrescue starts the recording. Please note that if the timecode does not start at the very beginning of the tape, the record mode viewer will not open until the timecode is detected (as soon as the counter starts moving on your deck, the viewer window should pop-up).

[insert dv_vrecord_timecode-record-start.gif here]

7. To end playback, click the x in the playback window or hit the "esc" key.


## Recording

[insert dv_vrecord_record-instructions.gif here]

1. Select the name of the DV device you want to use from the "Select a DV Device" list.

2. Click the "deck control" button to allow vrecord to control your device.

3. To record, select the recording directory (location where you want to save the file) and enter the recording name, name of the person digitizing this tape, recording time in minutes (if applicable) and any other options you would like applied to your file.

4. Click the "Record" button. The settings menu will close and the Terminal window will display the settings you have entered.

5. When you are ready hit the "Return" button to begin the recording.

6. A mpv window will open displaying the playback of the tape once dvrescue starts the recording. Please note that if the timecode does not start at the very beginning of the tape, the record mode viewer will not open until the timecode is detected (as soon as the counter starts moving on your deck, the viewer window should pop-up).

7. When dvrescue encounters an error, the software will automatically rewind and attempt to recapture the problematic frames.

8. To begin another capture on a separate deck, open a new Terminal window and run vrecord -e.
   - Select a different device from the list in the "DV" tab.
   - Repeat steps 2-7 listed above.  

9. To end the recording, click the x in the playback window or hit the "esc" key.

10. The Terminal window will display how the frames were merged for any moments when dvrescue reattempted to recapture problematic frames and how many frames remain with errors in the final recording. 

11. Close the Terminal window.

12. Depending on the settings you selected, a set of logs and the video file should all be saved at the location you selected in the settings.

![dv_vrecord_check-files](https://github.com/user-attachments/assets/c31785b5-f123-4543-a0c2-1a4b88e7c42e)


13. Review your files and logs to ensure they were captured correctly. 


## Bitstream Error Concealment
If vrecord detects that the DV device is concealing bitstream errors, this will be noted in the Terminal.
![Alt text](../dv_vrecord_bitstream_concealment.png "Detection of Bitstream Error Concealment")


## Known Issues

### No Audio During Playback
Currently, no audio will play during record mode, but dvrescue will record the audio stream. You will need to monitor the audio directly on the deck. 
