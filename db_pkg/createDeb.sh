#!/bin/bash

BASE_DIR="/tmp/fun-scripts"
BASE_DIR_DEBIAN=$BASE_DIR/debian
SCRIPT_DIR="./funpy/"

mkdir -p $BASE_DIR
mkdir -p $BASE_DIR_DEBIAN

mkdir $BASE_DIR/scripts
cp $SCRIPT_DIR/* $BASE_DIR/scripts

cat <<EOF >> $BASE_DIR/scripts/affe.share
#!/bin/sh
echo "abc"
EOF

# Create Copyright
cat <<EOF >> $BASE_DIR_DEBIAN/copyright
Format: http://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: fun-scripts
Upstream-Contact: Sebastian Chlan, <sebastian.chlan@gmail.com>

Files: *
Copyright: 2015, Name, <email@address>
License: (GPL-2+ | LGPL-2 | GPL-3 | whatever)
 Full text of licence.
 Unless there is a it can be found in /usr/share/common-licenses
EOF

# Compat
cat <<EOF >> $BASE_DIR_DEBIAN/compat
7
EOF

# Rules
cat <<EOF >> $BASE_DIR_DEBIAN/rules
#!/usr/bin/make -f

%:
	dh \$@
EOF

# Control
cat <<EOF >> $BASE_DIR_DEBIAN/control
Source: fun-scripts
Section: python
Priority: optional
Maintainer: Sebastian Chlan, <sebastian.chlan@gmail.com>
Build-Depends: debhelper (>= 7),
               python (>= 2.6.6-3~)
Standards-Version: 3.9.2
X-Python-Version: >= 2.6


Package: fun-scripts
Architecture: all
Section: python
Depends: ${misc:Depends}, ${python:Depends}
Description: short description
 A long description goes here.
 .
 It can contain multiple paragraphss
EOF

# Install
cat <<EOF >> $BASE_DIR_DEBIAN/install
scripts/* usr/bin/
EOF

# Changelog
cat <<EOF >> $BASE_DIR_DEBIAN/changelog
fun-scripts (1.0.0) UNRELEASED; urgency=low

  * Initial release. (Closes: #XXXXXX)

 -- root <root@bastel.chlan.local>  Mon, 29 Jun 2015 00:19:51 +0200
EOF


cd /tmp/fun-scripts
debuild -i -us -uc -b