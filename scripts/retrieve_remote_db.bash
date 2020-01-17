#!/bin/bash
# requirements: wget, mdbtools, unixodbc-dev

# Pull values from options and fill if needed
while getopts ":r:t:d:" option
  do
    case "${option}" 
      in
        r ) REMOTE_DB_FILE=$OPTARG;;
        t ) TEMP_DB_FILE=$OPTARG;;
        d ) DATA_DIR=$OPTARG;;
        \? ) echo "Invalid option: $OPTARG" 1>&2;;
        : ) echo "Invalid option: $OPTARG requires an argument" 1>&2;;
    esac
done
if [ ! "$REMOTE_DB_FILE" ]  
  then
    echo "missing -r (remote db file address)"
    exit 0
fi
if [ ! "$TEMP_DB_FILE" ] 
  then
    TEMP_DB_FILE="${REMOTE_DB_FILE##*/}"
fi
if [ ! "$DATA_DIR" ]
then
  DATA_DIR=data
fi

# Create the data directory 
mkdir $DATA_DIR -p

# Download the database
echo "Downloading remote database..."
wget $REMOTE_DB_FILE -nv -q -O $DATA_DIR/$TEMP_DB_FILE --show-progress
