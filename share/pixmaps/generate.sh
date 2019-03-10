#!/bin/sh

for size in 256 128 64 32 16; do
    convert esmacoin.png -resize "${size}x${size}" "esmacoin${size}.png"
    convert esmacoin.png -resize "${size}x${size}" "esmacoin${size}.xpm"
done
