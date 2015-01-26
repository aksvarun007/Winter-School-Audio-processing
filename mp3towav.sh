#!/bin/sh
directory=$1;
output=$2
i=1
for filename in $directory/*
do
ffmpeg -i $filename $output/m$i.wav
i=$((i+1))
done
