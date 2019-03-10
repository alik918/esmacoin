
Debian
====================
This directory contains files used to package esmacoind/esmacoin-qt
for Debian-based Linux systems. If you compile esmacoind/esmacoin-qt yourself, there are some useful files here.

## esmacoin: URI support ##


esmacoin-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install esmacoin-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your esmacoin-qt binary to `/usr/bin`
and the `../../share/pixmaps/esmacoin128.png` to `/usr/share/pixmaps`

esmacoin-qt.protocol (KDE)

