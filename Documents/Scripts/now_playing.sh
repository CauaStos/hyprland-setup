#!/bin/bash

song_author=$(playerctl metadata artist)
song_name=$(playerctl metadata title)

echo "${song_author} - ${song_name}"
