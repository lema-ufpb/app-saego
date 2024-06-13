#!/bin/bash
PARAMS=""
# handle params
while (( "$#" )); do
  case "$1" in
    -a|--action)
      shift
      ;;
    *)
      PARAMS="$1"
      shift
      ;;
  esac

done
# set positional arguments in their proper place
eval set -- "$PARAMS"

if [ "$PARAMS" == "Run APP - NodeJS Enviroment" ]; then
  echo "Run APP - NodeJS Enviroment"
  npm run dev
fi

