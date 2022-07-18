#!/bin/bash

# ENV VAR COLORS
COLOR_BLACK=0
COLOR_RED=1
COLOR_GREEN=2
COLOR_YELLOW=3
COLOR_BLUE=4
COLOR_MAGENTA=5
COLOR_CYAN=6
COLOR_WHITE=7

# Colored Print Command
color_print() {
    text=$1
    color=$2

    tput setaf "$color"
    echo "$text"
    tput sgr0
}

# Different Colors Print
black_print() {
    text=$1
    color_print "$text" "$COLOR_BLACK"
}

red_print() {
    text=$1
    color_print "$text" "$COLOR_RED"
}

green_print() {
    text=$1
    color_print "$text" "$COLOR_GREEN"
}

yellow_print() {
    text=$1
    color_print "$text" "$COLOR_YELLOW"
}

blue_print() {
    text=$1
    color_print "$text" "$COLOR_BLUE"
}

magenta_print() {
    text=$1
    color_print "$text" "$COLOR_MAGENTA"
}

cyan_print() {
    text=$1
    color_print "$text" "$COLOR_CYAN"
}

white_print() {
    text=$1
    color_print "$text" "$COLOR_WHITE"
}
