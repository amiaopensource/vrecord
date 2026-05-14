# Steps for a successful install of Vrecord on Linux

## About
There are many possible ways to install the various dependencies of Vrecord on Linux. The main body of this documentation is oriented towards Ubuntu LTS, and has been tested to work on fresh installations of Ubuntu 24.04 LTS and 26.04 LTS.

### Install non-homebrew core dependencies
1) If working on a fresh installation of Ubuntu, it is recommended to run `sudo apt-get update && sudo apt-get upgrade -y` prior to installing vrecord to make sure that all packages are their latest versions.
2) Download and install the latest Linux version of 'Blackmagic Desktop Video' from the [Blackmagic website](https://www.blackmagicdesign.com/support/)
3) Install dependencies required for a successful build. These can be installed one-by-one from the list in [this script](https://github.com/amiaopensource/vrecord/blob/main/Release/linux-dependencies.sh), or (recommended) that script can be run remotely with the following command.

__Vrecord dependency install command:__ 

`wget -O - https://raw.githubusercontent.com/amiaopensource/vrecord/refs/heads/linux-doc-updates/Release/linux-dependencies.sh | bash`
  
### Install Homebrew
4) Install Homebrew via the command on [its homepage](https://brew.sh/). As of writing, this is: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

 __Important:__ After this command runs, Homebrew will print several more required commands that must be run to make brew functional. Run these commands! They should look something like:
  ```
  echo >> /home/your-user-name/.bashrc
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"' >> /home/your-user-name/.bashrc
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"
  ```
For changes to take effect, either run `reset` or open a new terminal window.

5) Add the AMIA Open Source and MediaArea taps for Homebrew with: `brew tap amiaopensource/amiaos && brew tap mediaarea/mediaarea`

  ### Install vrecord
6) You now should be able to install vrecord by running: `brew install vrecord`

  ### Install optional dependencies
  
If DV functionality is desired, download and install the [DVRescue](https://mediaarea.net/DVRescue) command line tools from the MediaArea website.

The FFmpeg DV device can also be used for some DV features; this requires ffmpeg-ma to be compiled with the IEC61883 device. This can be done with `brew install ffmpeg-ma --with-iec61883` for a new installation or `brew reinstall ffmpeg-ma --with-iec61883` if ffmpeg-ma is already installed.

# Instructions/Tips for other Linux Distributions
## Linux Mint
Installation on Linux Mint (20.1) it was necessary to run `apt install libc6-dev texinfo` for additional dependencies.
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
