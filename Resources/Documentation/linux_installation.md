# Steps for a successful install of Vrecord on Linux (Ubuntu 18.04)

## About
There are many possible ways to install the various dependencies of Vrecord on Linux. The following instructions aim to minimize use of linuxbrew installs for packages that can otherwise be installed via native Linux methods. When followed in order, these commands should result in a fully functional install of vrecord (tested on Ubuntu 18.04)

## Programs to be installed manually

* Download and install the latest Linux version of 'Blackmagic Desktop Video' from the [Blackmagic website](https://www.blackmagicdesign.com/support/)
* Download and install the latest version of the QC Tools CLI tool from the [MediaArea](https://mediaarea.net/QCTools/Download/Ubuntu)

## Programs to be installed via PPA

* Install MPV with the following steps:
  - Add the MPV PPA with: `sudo add-apt-repository ppa:mc3man/mpv-tests`
  - Update package manager with: `sudo apt-get update`
  - Install MPV with `sudo apt-get install mpv`

## Programs to be installed via standard package manager

* Use the following commands to install additional dependencies for full vrecord use:
  - `sudo apt-get install curl`
  - `sudo apt-get install gnuplot`
  - `sudo apt-get install xmlstarlet`
  - `sudo apt-get install mkvtoolnix`
  - `sudo apt-get install mediaconch`

## Install Homebrew for Linux (Linuxbrew)
* Use the following commands, (sourced from the [Homebrew docs](https://docs.brew.sh/Homebrew-on-Linux)) to install and configure Homebrew on Linux:
 - Install linuxbrew with: `sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"`
 - Add linuxbrew to path with: 
~~~
 test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
 test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
 test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >> ~/.bashrc
 ~~~

## Install additional vrecord dependencies via Homebrew
* `brew install decklinksdk && brew install ffmpegdecklink && brew install gtkdialog`
* `brew install --ignore-dependencies vrecord`

## Fix conflicting SDL2 dependencies
* `brew uninstall --ignore-dependencies sdl2`
* `sudo apt install libsdl2-dev`

