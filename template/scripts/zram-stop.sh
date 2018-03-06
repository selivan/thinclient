#!/bin/sh

if DEVICES=$(grep zram /proc/swaps | awk '{print $1}'); then
  for i in $DEVICES; do
    swapoff $i
  done
fi
rmmod zram
