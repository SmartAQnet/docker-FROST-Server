#!/bin/bash

SCRIPT=$(realpath -s "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

"$SCRIPTPATH/docker-stop.sh"
"$SCRIPTPATH/docker-clean.sh"

