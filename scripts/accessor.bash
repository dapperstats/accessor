#!/bin/bash
# requirements: curl, mdbtools, unixodbc-dev

# Default values
KEEP_TEMP_DB_FILE=n

# Set values from options and fill if needed
while getopts ":r:l:t:d:k:" option
  do
    case "${option}" 
      in
        r ) REMOTE_DB_FILE=$OPTARG;;
        l ) LOCAL_DB_FILE=$OPTARG;;
        t ) TEMP_DB_FILE=$OPTARG;;
        d ) DATA_DIR=$OPTARG;;
        k ) KEEP_TEMP_DB_FILE=$OPTARG;;
        \? ) echo "Invalid option: $OPTARG" 1>&2;;
        : ) echo "Invalid option: $OPTARG requires an argument" 1>&2;;
    esac
done
if [ ! "$REMOTE_DB_FILE" ] && [ ! "$LOCAL_DB_FILE" ] 
  then
    echo "error: must supply -r (remote db file address) or -l (local db file address)"
    exit 1
fi
if [ ! "$TEMP_DB_FILE" ] 
  then
    TEMP_DB_FILE="${REMOTE_DB_FILE##*/}"
fi
if [ ! "$DATA_DIR" ]
  then
    DATA_DIR=data
fi


# If pointing to a remote DB, use wget
if [ "$REMOTE_DB_FILE" ]
  then
     bash scripts/retrieve_remote_db.bash  -r $REMOTE_DB_FILE -t $TEMP_DB_FILE -d $DATA_DIR
  else
    TEMP_DB_FILE=$LOCAL_DB_FILE
fi

# Convert database to csvs 
bash scripts/msdb_to_csvs.bash -t $TEMP_DB_FILE -d $DATA_DIR

# Remove temporary DB file (if desired)
if [ "$KEEP_TEMP_DB_FILE" == n ]
  then
    rm -rf $DATA_DIR/$TEMP_DB_FILE
fi 
