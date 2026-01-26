##  Copyright (c) MediaArea.net SARL. All Rights Reserved.
 #
 #  Use of this source code is governed by a BSD-style license that can
 #  be found in the License.html file in the root of the source tree.
 ##

#!/bin/bash

# This script uses the following environment variables:
# - MACOS_CODESIGN_IDENTITY: The subject and ID part of the Apple development certificate (optional).
# - BMSDK: The path to the Blackmagic DeckLink SDK include directory (if not in the standard include path).

set -e

#-----------------------------------------------------------------------
# Setup
release_directory="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"
version="$(sed -nE 's/^VERSION="([0-9.-]+)"/\1/p' "${release_directory}/../vrecord")"

export MAKEOPTS=-j$(($(sysctl -n hw.logicalcpu)+1))

export CXXFLAGS="-mmacosx-version-min=11.0 -arch x86_64 -arch arm64 $CXXFLAGS"
export CFLAGS="-mmacosx-version-min=11.0 -arch x86_64 -arch arm64 $CFLAGS"
export LDFLAGS="-mmacosx-version-min=11.0 -arch x86_64 -arch arm64 $LDFLAGS"

#-----------------------------------------------------------------------
# Cleanup
rm -f "${release_directory}/vrecord_${version}_Mac.dmg"
rm -f "${release_directory}/vrecord.unsigned.pkg"
rm -f "${release_directory}/vrecord.pkg"

rm -f "${release_directory}/FFmpeg_Bin_Latest_Mac_Static_x64.zip"

rm -fr "${release_directory}/mediaconch_ROOT"
rm -f "${release_directory}/MediaConch.dmg"
rm -f "${release_directory}/mediaconch.pkg"

rm -fr "${release_directory}/qcli_ROOT"
rm -f "${release_directory}/qcli.dmg"
rm -f "${release_directory}/qcli.pkg"

rm -fr "${release_directory}/dvrescue_ROOT"
rm -f "${release_directory}/dvrescue.dmg"
rm -f "${release_directory}/dvrescue.pkg"

rm -fr "${release_directory}/libxml2"
rm -fr "${release_directory}/libxslt"
rm -fr "${release_directory}/xmlstarlet"

rm -fr "${release_directory}/deckcontrol"

rm -fr "${release_directory}/gnuplot_ROOT"
rm -f "${release_directory}/gnuplot-qt5-universal.pkg"

rm -fr "${release_directory}/vrecord_ROOT"

mkdir -p "${release_directory}"/vrecord_ROOT/usr/local/{bin,share/{vrecord/Resources,man/man1},lib/vrecord/{app,bin,lib}}

#-----------------------------------------------------------------------
# Get cowsay
pushd "${release_directory}/"
    mkdir -p vrecord_ROOT/usr/local/lib/vrecord/share/cowsay/cows
    curl -L "https://raw.githubusercontent.com/cowsay-org/cowsay/refs/heads/main/share/cowsay/cows/default.cow" -o vrecord_ROOT/usr/local/lib/vrecord/share/cowsay/cows/default.cow
    curl -L "https://raw.githubusercontent.com/cowsay-org/cowsay/refs/heads/main/bin/cowsay" -o vrecord_ROOT/usr/local/lib/vrecord/bin/cowsay
    chmod +x vrecord_ROOT/usr/local/lib/vrecord/bin/cowsay
popd

#-----------------------------------------------------------------------
# Get ffmpeg-ma 
pushd "${release_directory}/"
    curl -LO "https://mediaarea.net/download/snapshots/binary/ffmpeg/latest/FFmpeg_Bin_Latest_Mac_Static_x64.zip"
    unzip -d vrecord_ROOT/usr/local/lib/vrecord -x FFmpeg_Bin_Latest_Mac_Static_x64.zip bin/ffmpeg bin/ffplay
    mv vrecord_ROOT/usr/local/lib/vrecord/bin/ffmpeg vrecord_ROOT/usr/local/lib/vrecord/bin/ffmpeg-ma
    mv vrecord_ROOT/usr/local/lib/vrecord/bin/ffplay vrecord_ROOT/usr/local/lib/vrecord//bin/ffplay-ma 
popd


#-----------------------------------------------------------------------
# Get MediaConch CLI 
pushd "${release_directory}/"
    mc_version=$(curl -Ls https://mediaarea.net/download/binary/mediaconch | grep -Eo 'href="[0-9.]+/"' | head -n1 | grep -Eo '[0-9.]+')
    curl -L "https://mediaarea.net/download/binary/mediaconch/${mc_version}/MediaConch_CLI_${mc_version}_Mac.dmg" -o MediaConch.dmg

    hdiutil attach -noverify mediaconch.dmg
    cp "/Volumes/MediaConch/mediaconch.pkg" .
    hdiutil detach "/Volumes/MediaConch"

    pkgutil --expand-full mediaconch.pkg mediaconch_ROOT
    cp -a mediaconch_ROOT/Payload/usr/local/bin/mediaconch vrecord_ROOT/usr/local/lib/vrecord/bin
popd

#-----------------------------------------------------------------------
# Get QCTools CLI 
pushd "${release_directory}/"
    qc_version=$(curl -Ls https://mediaarea.net/download/binary/qcli | grep -Eo 'href="[0-9.]+/"' | head -n1 | grep -Eo '[0-9.]+')
    curl -L "https://mediaarea.net/download/binary/qcli/${qc_version}/qcli_${qc_version}_mac.dmg" -o qcli.dmg

    hdiutil attach -noverify qcli.dmg
    cp "/Volumes/qcli/qcli.pkg" .
    hdiutil detach "/Volumes/qcli"

    pkgutil --expand-full qcli.pkg qcli_ROOT
    cp -a qcli_ROOT/Payload/usr/local/bin/qcli vrecord_ROOT/usr/local/lib/vrecord/bin
popd

#-----------------------------------------------------------------------
# Get dvrescue CLI 
pushd "${release_directory}/"
    dv_version=$(curl -Ls https://mediaarea.net/download/binary/dvrescue | grep -Eo 'href="[0-9.]+/"' | head -n1 | grep -Eo '[0-9.]+')
    curl -L "https://mediaarea.net/download/binary/dvrescue/${dv_version}/dvrescue_CLI_${dv_version}_Mac.dmg" -o dvrescue.dmg

    hdiutil attach -noverify dvrescue.dmg
    cp "/Volumes/dvrescue/dvrescue.pkg" .
    hdiutil detach "/Volumes/dvrescue"

    pkgutil --expand-full dvrescue.pkg dvrescue_ROOT
    cp -a dvrescue_ROOT/Payload/usr/local/bin/* vrecord_ROOT/usr/local/lib/vrecord/bin
popd

#-----------------------------------------------------------------------
# Get gnuplot 
pushd "${release_directory}/"
    curl -L https://csml.northwestern.edu/Download/Gnuplot/gnuplot-6.0.3-qt5-universal.pkg -o gnuplot-qt5-universal.pkg  
    pkgutil --expand-full gnuplot-qt5-universal.pkg gnuplot_ROOT
    cp -a gnuplot_ROOT/gnuplot-package-*-qt5-universal.pkg/Payload/* vrecord_ROOT/usr/local/lib/vrecord
popd

#-----------------------------------------------------------------------
# Get MKVToolNix 
pushd "${release_directory}/"
    curl -L https://mkvtoolnix.download/macos/MKVToolNix-42.0.0.dmg -o MKVToolNix-42.0.0.dmg

    hdiutil attach -noverify MKVToolNix-42.0.0.dmg
    cp -a "/Volumes/MKVToolNix-42.0.0/MKVToolNix-42.0.0.app/Contents/MacOS/mkvextract" vrecord_ROOT/usr/local/lib/vrecord/bin
    cp -a "/Volumes/MKVToolNix-42.0.0/MKVToolNix-42.0.0.app/Contents/MacOS/mkvinfo" vrecord_ROOT/usr/local/lib/vrecord/bin
    cp -a "/Volumes/MKVToolNix-42.0.0/MKVToolNix-42.0.0.app/Contents/MacOS/mkvmerge" vrecord_ROOT/usr/local/lib/vrecord/bin
    cp -a "/Volumes/MKVToolNix-42.0.0/MKVToolNix-42.0.0.app/Contents/MacOS/mkvpropedit" vrecord_ROOT/usr/local/lib/vrecord/bin
    hdiutil detach "/Volumes/MKVToolNix-42.0.0"
popd

#-----------------------------------------------------------------------
# Get mpv
pushd "${release_directory}/"
    curl -LO https://laboratory.stolendata.net/~djinn/mpv_osx/mpv-0.39.0.tar.gz
    tar -xf mpv-0.39.0.tar.gz
    cp -a mpv.app vrecord_ROOT/usr/local/lib/vrecord/app
    ln -s ../app/mpv.app/Contents/MacOS/mpv vrecord_ROOT/usr/local/lib/vrecord/bin/mpv
popd

#-----------------------------------------------------------------------
# Get gtkdialog
# TODO: Build or get from any other source
pushd "${release_directory}/"
    curl -LO https://mediaarea.net/download/binary/gtkdialog/0.8.5/gtkdialog-0.8.5_mac.zip
    unzip gtkdialog-0.8.5_mac.zip
    cp -a gtkdialog/bin/gtkdialog vrecord_ROOT/usr/local/lib/vrecord/bin
    cp -a gtkdialog/lib/* vrecord_ROOT/usr/local/lib/vrecord/lib
popd

#-----------------------------------------------------------------------
# Build xmlstarlet
pushd "${release_directory}/"
    mkdir libxml2 libxslt xmlstarlet
    curl -LO https://download.gnome.org/sources/libxml2/2.15/libxml2-2.15.1.tar.xz
    tar -C libxml2 --strip-components 1 -xvf libxml2-2.15.1.tar.xz
    curl -LO https://download.gnome.org/sources/libxslt/1.1/libxslt-1.1.43.tar.xz
    tar -C libxslt --strip-components 1 -xvf libxslt-1.1.43.tar.xz
    curl -LO https://sourceforge.net/projects/xmlstar/files/xmlstarlet/1.6.1/xmlstarlet-1.6.1.tar.gz
    tar -C xmlstarlet --strip-components 1 -xvf xmlstarlet-1.6.1.tar.gz

    pushd libxml2
        ./configure --without-python --without-modules --without-iconv --without-icu --without-iso8859x --without-mem_debug --without-run_debug --with-regexps --with-tree --with-writer --with-pattern --with-push --with-valid --with-sax1 --with-legacy --enable-static --disable-shared
        make
    popd

    pushd libxslt
        ./configure --with-libxml-src="${release_directory}/libxml2" --without-python --without-modules --without-crypto --enable-static --disable-shared
        make
    popd

    pushd xmlstarlet
        # Apply Gentoo patch to fix build with libxml2 >= 2.14
        curl -L "https://raw.githubusercontent.com/gentoo/gentoo/refs/heads/master/app-text/xmlstarlet/files/xmlstarlet-1.6.1-libxml2-2.14.0-compile.patch" | patch -p1
        curl -L "https://raw.githubusercontent.com/gentoo/gentoo/refs/heads/master/app-text/xmlstarlet/files/xmlstarlet-1.6.1-libxml2-2.13-stdin.patch" | patch -p1
        curl -L "https://raw.githubusercontent.com/gentoo/gentoo/refs/heads/master/app-text/xmlstarlet/files/xmlstarlet-1.6.1-clang16.patch" | patch -p1
        curl -L "https://raw.githubusercontent.com/gentoo/gentoo/refs/heads/master/app-text/xmlstarlet/files/xmlstarlet-1.6.1-clang17.patch" | patch -p1
        ./configure --enable-static-libs --disable-build-docs --with-libxml-src="${release_directory}/libxml2" --with-libxslt-src="${release_directory}/libxslt"
        make || true # Build fails on docs despite --disable-build-docs, force the build to be marked as successful
    popd
    cp -a xmlstarlet/xml vrecord_ROOT/usr/local/lib/vrecord/bin/xmlstarlet
popd

#-----------------------------------------------------------------------
# Build deckcontrol
pushd "${release_directory}/"
    git clone --depth 1 https://github.com/bavc/deckcontrol.git
    pushd deckcontrol
        make BMDSK="${BMSDK}"
    popd
    
    cp -a deckcontrol/deckcontrol vrecord_ROOT/usr/local/lib/vrecord/bin
popd

#-----------------------------------------------------------------------
# Bundle vrecord
pushd "${release_directory}/"
    cp -a ../vtest vrecord_ROOT/usr/local/bin
    cp -a ../vplay vrecord_ROOT/usr/local/bin
    cp -a ../vrecord vrecord_ROOT/usr/local/bin

    cp -a ../vtest.1 vrecord_ROOT/usr/local/share/man/man1    
    cp -a ../vrecord.1 vrecord_ROOT/usr/local/share/man/man1

    cp -a ../Resources/audio_mode.gif vrecord_ROOT/usr/local/share/vrecord/Resources
    cp -a ../Resources/dvrecord.png vrecord_ROOT/usr/local/share/vrecord/Resources
    cp -a ../Resources/qcview.lua vrecord_ROOT/usr/local/share/vrecord/Resources
    cp -a ../Resources/vrecord_functions vrecord_ROOT/usr/local/share/vrecord/Resources
    cp -a ../Resources/vrecord_logo.png vrecord_ROOT/usr/local/share/vrecord/Resources
    cp -a ../Resources/vrecord_logo_playback.png vrecord_ROOT/usr/local/share/vrecord/Resources
    cp -a ../Resources/vrecord_logo_audio.png vrecord_ROOT/usr/local/share/vrecord/Resources
    cp -a ../Resources/vrecord_logo_edit.png vrecord_ROOT/usr/local/share/vrecord/Resources
    cp -a ../Resources/vrecord_logo_help.png vrecord_ROOT/usr/local/share/vrecord/Resources
    cp -a ../Resources/vrecord_logo_documentation.png vrecord_ROOT/usr/local/share/vrecord/Resources
popd

#-----------------------------------------------------------------------
# Sign binaries

cat - > "${release_directory}/vrecord.entitlements" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>com.apple.security.cs.disable-library-validation</key>
    <true/>
</dict>
</plist>
EOF

pushd "${release_directory}/"
    if [ -n "${MACOS_CODESIGN_IDENTITY}" ] ; then
        find  vrecord_ROOT/usr/local -type f -print0 | while IFS= read -r -d '' f ; do
            if file "$f" | grep -q 'Mach-O.*\(executable\|dynamically linked shared library\)' ; then
                codesign --force --options runtime --timestamp --entitlements vrecord.entitlements --sign "Developer ID Application: ${MACOS_CODESIGN_IDENTITY}" "$f"
            fi
        done
        codesign --force --options runtime --timestamp --sign "Developer ID Application: ${MACOS_CODESIGN_IDENTITY}" --identifier "com.github.amiaopensource.vrecord" vrecord_ROOT/usr/local/lib/vrecord/app/mpv.app
    fi
popd

#-----------------------------------------------------------------------
# Package .pkg
pushd "${release_directory}/"
    pkgbuild --root vrecord_ROOT --identifier "com.github.amiaopensource.vrecord" --version "${version}" "vrecord.unsigned.pkg"
popd

#-----------------------------------------------------------------------
# Sign .pkg
pushd "${release_directory}/"
    if [ -n "${MACOS_CODESIGN_IDENTITY}" ] ; then
        productsign --sign "Developer ID Installer: ${MACOS_CODESIGN_IDENTITY}" "vrecord.unsigned.pkg" "vrecord.pkg"
    else
        mv -f "vrecord.unsigned.pkg" "vrecord.pkg"
    fi
popd


#-----------------------------------------------------------------------
# Package .dmg
pushd "${release_directory}/"
    tmp_path="$(mktemp -d)"
    trap "rm -rf ${tmp_path}" EXIT

    tmp_files="tmp-vrecord"
    tmp_dmg="tmp-vrecord.dmg"

    mkdir -p "${tmp_path}/${tmp_files}"
    cp -a "vrecord.pkg" "${tmp_path}/${tmp_files}/"

    hdiutil create "${tmp_path}/${tmp_dmg}" -ov -fs HFS+ -format UDRW -volname "vrecord" -srcfolder "${tmp_path}/${tmp_files}"
    hdiutil attach -readwrite -noverify "${tmp_path}/${tmp_dmg}"

    sleep 1

    echo '
        tell application "Finder"
            tell disk "vrecord"
                open
                set current view of container window to icon view
                set toolbar visible of container window to false
                set the bounds of container window to {400, 100, 950, 600}
                set viewOptions to the icon view options of container window
                set arrangement of viewOptions to not arranged
                set icon size of viewOptions to 72
                set position of item "vrecord.pkg" of container window to {125, 175}
                close
            end tell
        end tell
    ' | osascript

    hdiutil detach "/Volumes/vrecord"
    hdiutil convert "${tmp_path}/${tmp_dmg}" -format UDBZ -o "vrecord_${version}_Mac.dmg"
popd

#-----------------------------------------------------------------------
# Sign .dmg
pushd "${release_directory}/"
    if [ -n "${MACOS_CODESIGN_IDENTITY}" ] ; then
        codesign --force --options runtime --timestamp --sign "Developer ID Application: ${MACOS_CODESIGN_IDENTITY}" --identifier "com.github.amiaopensource.vrecord" "vrecord_${version}_Mac.dmg"
    fi
popd
