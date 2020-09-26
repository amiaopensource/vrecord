# Steps for a successful install of Vrecord on Linux

## About
There are many possible ways to install the various dependencies of Vrecord on Linux. 

## via Linuxbrew (tested Ubuntu 18.04)
The following instructions aim to minimize use of linuxbrew installs for packages that can otherwise be installed via native Linux methods. When followed in order, these commands should result in a fully functional install of vrecord (tested on Ubuntu 18.04)

### Programs to be installed manually

* Download and install the latest Linux version of 'Blackmagic Desktop Video' from the [Blackmagic website](https://www.blackmagicdesign.com/support/)
* Download and install the latest version of the QC Tools CLI tool from the [MediaArea](https://mediaarea.net/QCTools/Download/Ubuntu)

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
* If `make` and `gcc` are not already installed, install them with
  - `sudo apt-get install gcc`
  - `sudo apt-get install make`
  
### Install Homebrew for Linux (Linuxbrew)
* Use the following commands, (sourced from the [Homebrew docs](https://docs.brew.sh/Homebrew-on-Linux)) to install and configure Homebrew on Linux:
 - Install linuxbrew with: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"`
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
* `brew install decklinksdk && brew install ffmpegdecklink --with-iec61883 && brew install gtkdialog`
* `brew install vrecord`

### Fix conflicting SDL2 dependencies
* `brew uninstall --ignore-dependencies sdl2`
* `sudo apt install libsdl2-dev`
* This step may not be required if Brew has been configured lower in $PATH than standard system directories.

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
