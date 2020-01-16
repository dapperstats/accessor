#!/bin/bash

# Default values
KEEP_TEMP_DB_FILE=n
INTERACTIVE=n

# Pull values from options and fill 
while getopts ":r:l:d:k:i:" option
  do
    case "${option}" 
      in
        r ) REMOTE_DB_FILE=$OPTARG;;
        l ) LOCAL_DB_FILE=$OPTARG;;
        d ) DATA_DIR=$OPTARG;;
        k ) KEEP_TEMP_DB_FILE=$OPTARG;;
        i ) INTERACTIVE_R=$OPTARG;;
        \? ) echo "Invalid option: $OPTARG" 1>&2;;
        : ) echo "Invalid option: $OPTARG requires an argument" 1>&2;;
    esac
done
if [ ! "$REMOTE_DB_FILE" ] && [ ! "$LOCAL_DB_FILE" ] 
  then
    echo "error: must supply -r (remote db file address) or -l (local db file address)"
    exit 1
fi
if [ ! "$REMOTE_DB_FILE" ]
  then
    REMOTE_DB_FILE="na"
fi
if [ ! "$LOCAL_DB_FILE" ]
  then
    LOCAL_DB_FILE="na"
fi
if [ ! "$TEMP_DB_FILE" ] 
  then
    TEMP_DB_FILE="${REMOTE_DB_FILE##*/}"
fi
if [ ! "$DATA_DIR" ]
  then
    DATA_DIR=data
fi

# Download and unpack the remote database into csv files
bash scripts/accessor.bash -r $REMOTE_DB_FILE -l $LOCAL_DB_FILE -t $TEMP_DB_FILE -d $DATA_DIR -k $KEEP_TEMP_DB_FILE

# For an interactive R session, run and save the r_script then open a session
if [ "$INTERACTIVE_R" == y ]
  then 
    R < scripts/r_script.R --save
    R --silent
fi 

