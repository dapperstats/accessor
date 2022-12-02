mkdir data
wget "https://filelib.wildlife.ca.gov/Public/salvage/Salvage_data_FTP.accdb" -nv -q -O "data/local.accdb" --show-progress
mkdir "data/Salvage_data_FTP" -p
echo "Converting to csvs..."
mdb-tables -1 $DATA_DIR/$TEMP_DB_FILE | xargs -L1 -d '\n' -I{} bash -c 'mdb-export "$1" "$2" > "$3"' -- "data/Salvage_data_FTP.accdb" {} "data/Salvage_data_FTP"/{}.csv
 