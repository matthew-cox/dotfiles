#!/bin/bash
#
# Find recently added music and rsync to thumbdrive for the car
#
THUMB_DRIVE="/Volumes/VW_MUSIC"
MUSIC_DIR="${HOME}/Music/iTunes/iTunes Music"
MAX_DIRS="25"
MAX_COMPS="5"

if [ ! -d "${THUMB_DRIVE}" ]; then
  echo "*** Thumb drive isn't mounted!"
  exit 1
fi

COMPS=0

for X in $(ls -Frt "$MUSIC_DIR" | grep -vE '^(Downloads|Automatically Add|Podcasts|Tones)' | tail -${MAX_DIRS} | sed -e 's/ /==/g'); do
  
  if [ "$X" = "Compilations/" ]; then
    COMPS=1
    break
  fi
  
  NEW=$(echo "$X" | sed -e 's/==/ /g' -e 's|/$||')
  echo "$NEW"
  rsync --exclude '.DS_Store' -av "${MUSIC_DIR}/${NEW}" "${THUMB_DRIVE}"/
done

if [ $COMPS -eq 1 ]; then
  
  for X in $(ls -Frt "$MUSIC_DIR/Compilations" | grep -vE '^(Downloads|Automatically Add)' | tail -${MAX_COMPS} | sed -e 's/ /==/g'); do
  
    NEW=$(echo "$X" | sed -e 's/==/ /g' -e 's|/$||')
    echo "$NEW"
    rsync --exclude '.DS_Store' -av "${MUSIC_DIR}/Compilations/${NEW}" "${THUMB_DRIVE}"/
  done
  
fi