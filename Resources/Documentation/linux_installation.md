# Steps for a successful install of Vrecord on Linux

## About
There are many possible ways to install the various dependencies of Vrecord on Linux. The main body of this documentation is oriented towards installing on Ubuntu LTS. For Some information about installing on additional distributions see the section at the bottom of this document. When followed in order, these commands should result in a fully functional install of vrecord.

### Programs to be installed manually

* Download and install the latest Linux version of 'Blackmagic Desktop Video' from the [Blackmagic website](https://www.blackmagicdesign.com/support/)
* Activate the [Media Area repositories](https://mediaarea.net/en/Repos) with their provided instructions for deb based distributions
   - Download and install the latest version of the [QCTools CLI tool](https://mediaarea.net/QCTools/Download/Ubuntu) from the MediaArea website
   - Optional: If DV capture is desired, download and install the CLI version of [DVRescue](https://mediaarea.net/DVRescue) from the MediaArea website.

### Programs to be installed via standard package manager

* Use the following commands to install additional dependencies for full vrecord use:

  
### Install Homebrew
* Use the Homebrew install script from [brew.sh](https://brew.sh/) to install Homebrew. As of writing, this can be run with:

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

__Important:__ After installing Homebrew you must add it to your [PATH](https://en.wikipedia.org/wiki/PATH_(variable)) so that it can be found by your system to install programs such as Vrecord. After downloading Homebrew, the install script should provide some commands that must be run to do this. Run these commands, otherwise Homebrew will not be functional! Alternatively, see the [Homebrew linux documentation](https://docs.brew.sh/Homebrew-on-Linux#install) post-install steps.

### Tap the necessary repositories in Homebrew for vrecord:
Run the following commands:

`brew tap amiaopensource/amiaos`
`brew tap mediaarea/mediaarea`

### Install additional vrecord dependencies via Brew
* `brew install decklinksdk && brew install ffmpeg-ma --with-iec61883 && brew install gtkdialog` _Note:_ Some users on Ubuntu have reported installation problems with `gtkdialog` at step. See [this note](https://github.com/amiaopensource/homebrew-amiaos/blob/master/TROUBLESHOOTING.md#vrecord)  at the AMIA Open Source Homebrew repository for a possible fix.
* `brew install vrecord`


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
