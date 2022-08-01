#!/usr/bin/env bash

## Config
FOLDER_ID=""
MINECRAFT="/var/minecraft"
BACKUP="$MINECRAFT/backup"

##############################
# DONT CHANGE THE CODE BELOW #
##############################

## Config World
WORLD="$MINECRAFT/world"
WORLD_NETHER="$MINECRAFT/world_nether"
WORLD_THE_END="$MINECRAFT/world_the_end"
WORLD_OUTPUT="$BACKUP/world"
PLUGINS="$MINECRAFT/plugins"

## preparing folder & backup log for the backup world
mkdir -p $WORLD_OUTPUT
touch "$WORLD_OUTPUT/backup.log"

## backup world
echo "backing up world $(date +%F_%H-%M-%S)"
$BACKUP/backup.sh -c -i $WORLD -i $WORLD_NETHER -i $WORLD_THE_END -i $PLUGINS -o $WORLD_OUTPUT -s minecraft -p Attention -m 3 -d sequential

## upload ke drive
echo "uploading to drive"
RECENT_BACKUP=$(ls $WORLD_OUTPUT -Art | tail -n 1)
/usr/local/bin/drive upload -p $FOLDER_ID "$WORLD_OUTPUT/$RECENT_BACKUP"

echo "backup complete"
