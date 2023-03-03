# Steps for a successful install of Vrecord on Linux

## About
There are many possible ways to install the various dependencies of Vrecord on Linux. The main body of this documentation is oriented towards installing on Ubuntu LTS. For Some information about installing on additional distributions see the section at the bottom of this document. 

## via Homebrew
The following instructions aim to minimize use of Homebrew installs for packages that can otherwise be installed via native Linux methods. When followed in order, these commands should result in a fully functional install of vrecord.

### Programs to be installed manually

* Download and install the latest Linux version of 'Blackmagic Desktop Video' from the [Blackmagic website](https://www.blackmagicdesign.com/support/)
* Download and install the latest version of the [QCTools CLI tool](https://mediaarea.net/QCTools/Download/Ubuntu) from the MediaArea website
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
* Installing a standard version of FFmpeg is highly recommended as a fallback in case of issues with the Homebrew controlled build:
  - `sudo apt-get install ffmpeg`
  
### Install Homebrew
* Use the following commands, (sourced from the [Homebrew docs](https://docs.brew.sh/Homebrew-on-Linux)) to install and configure Homebrew on Linux:
 - Install Homebrew with: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
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
* `brew install decklinksdk && brew install ffmpegdecklink --with-iec61883 && brew install gtkdialog` _Note:_ Some users on Ubuntu have reported installation problems with `gtkdialog` at step. See [this note](https://github.com/amiaopensource/homebrew-amiaos/blob/master/TROUBLESHOOTING.md#vrecord)  at the AMIA Open Source Homebrew repository for a possible fix.
* `brew install vrecord`

### Fix conflicting SDL2 dependencies
* `brew uninstall --ignore-dependencies sdl2`
* `sudo apt install libsdl2-dev`
* This step may not be required if Brew has been configured lower in $PATH than standard system directories.

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
