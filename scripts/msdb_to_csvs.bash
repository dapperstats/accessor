#!/bin/bash
# requirements: curl, mdbtools, unixodbc-dev

# Pull values from options and fill if needed
while getopts ":t:d:" option
  do
    case "${option}" 
      in
        t ) TEMP_DB_FILE=$OPTARG;;
        d ) DATA_DIR=$OPTARG;;
        \? ) echo "Invalid option: $OPTARG" 1>&2;;
        : ) echo "Invalid option: $OPTARG requires an argument" 1>&2;;
    esac
done
if [ ! "$TEMP_DB_FILE" ] 
  then
    echo "error: must supply -l (local db file address)"
    exit 1
fi
if [ ! "$DATA_DIR" ] 
then
  DATA_DIR=data
fi
DB_DIR=$DATA_DIR/"${TEMP_DB_FILE%%.*}"

# Create the data directory with a database subdirectory
mkdir $DB_DIR -p

# Convert the database tables to csv files
echo 
echo "Converting to csvs..."
echo 
mdb-tables -1 $DATA_DIR/$TEMP_DB_FILE | xargs -L1 -d '\n' -I{} bash -c 'mdb-export "$1" "$2" > "$3"' -- $DATA_DIR/$TEMP_DB_FILE {} $DB_DIR/{}.csv
