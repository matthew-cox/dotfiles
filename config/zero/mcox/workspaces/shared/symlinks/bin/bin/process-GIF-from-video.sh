#!/usr/bin/env bash

readonly RESOLUTIONS=(
"480"
"720"
"1080"
"1920"
)

function join_by {
  local IFS="$1";
  shift;
  echo "$*";
}

# Usage
function usage() {
    echo -n "
Take a valid video file and convert it into an animated GIF.

Usage:
$0 --input path/to/input.mp4 --output path/to/output.gif --resolution <$(join_by ", " "${RESOLUTIONS[@]}")>

Arguments:
    -i, --input       Provide path to the input movie file
    -o, --output      Provide path to the output gif file
    -r, --resolution  Choose a resolution for the GIF. Provide ALL to output all resolutions.

    -h, --help        Displays this message.
"
}

TEMP_OPTS=$(/usr/local/opt/gnu-getopt/bin/getopt -o hi:o:r: --long help,input:,output:,resolution: -- "$@")

if [[ $? != 0 ]] ; then
  usage
  exit 1
fi

# Note the quotes around `$TEMP_OPTS': they are essential!
eval set -- "$TEMP_OPTS"

INPUT_FILE=
OUTPUT_FILE=
RESOLUTION="ALL"

while true; do
  case "$1" in
    -h | --help )
      usage
      exit 0
      ;;

    -i | --input )
      INPUT_FILE="$2"
      shift 2

      if [[ ! -r "${INPUT_FILE}" ]]; then
        echo "*** Unable to read '${INPUT_FILE}', exiting" >&2
        exit 7
      fi
      ;;

    -o | --output )
      OUTPUT_FILE="$2"
      shift 2
      ;;

    -r | --resolution )
      RESOLUTION="$2"
      shift 2

      if [[ "$RESOLUTION" == "ALL" ]]; then
        OUTPUT_RESOLUTIONS=(${RESOLUTIONS[@]})
      else
        OUTPUT_RESOLUTIONS=("$RESOLUTION")
      fi
      ;;
    -- )
      shift
      break
      ;;
    * )
      echo "Unknown argument '$1'"
      break
      ;;
  esac
done

readonly IN_NAME="$(basename "$INPUT_FILE" | cut -d'.' -f1)"

echo -n "*** ${IN_NAME}...color palette..."
yes | ffmpeg -i "${INPUT_FILE}" -filter_complex "[0:v] palettegen" \
    "${IN_NAME}_palette.png" >/dev/null 2>&1

OUT_DIR="$(dirname "$OUTPUT_FILE")"
if [[ -z "${OUT_DIR}" ]]; then
  OUT_DIR="."
fi
readonly OUT_DIR
readonly OUT_NAME="$(basename "$OUTPUT_FILE" '.gif')"

for RES in "${OUTPUT_RESOLUTIONS[@]}"; do
    echo -n "${RES}..."
    ffmpeg -i "${INPUT_FILE}" -i "${IN_NAME}_palette.png" \
        -filter_complex "[0:v] fps=15,scale=${RES}:-1,split [a][b];[a] palettegen [p];[b][p] paletteuse" \
        "${OUT_DIR}/${OUT_NAME}-${RES}.gif" >/dev/null 2>&1
done

echo "done"
rm -f "${IN_NAME}_palette.png"

