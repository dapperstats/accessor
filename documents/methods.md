## Data Conversion
Juniper L. Simonis, 2020-01-17

This document outlines the processes by which an Access<sup>&reg;</sup> database is converted into local files and data objects.

Here we show usage under default settings for `accessor` which are set for working with the [California Delta](https://en.wikipedia.org/wiki/Sacramento%E2%80%93San_Joaquin_River_Delta) [fish salvage monitoring database](https://wildlife.ca.gov/Conservation/Delta/Salvage-Monitoring) as implemented in the [`dapperstats/salvage` repo](https://github.com/dapperstats/salvage/blob/master/)

### `accessor.bash` script: remote or local Acess<sup>&reg;</sup> database to local `.csv`s 

The main conversion is from an `.accdb` or `.mdb` database that may be remote or local to a local set of `.csv` files named by the tables in the database.
This is accomplished by the `accessor.bash` script, which combines two other scripts:
1. `retrieve_remote_db.bash` is used to retrieve a remote db (if needed)
   * `wget` is used to robustly download the database
2. `msdb_to_csvs.bash` converts a local Microsoft db to a set of `.csv`s within a folder
   * The `mdbtools` and `unixodbc` libraries are leveraged
   * `mdb-tables` retrieves the table names
   * `mdb-export` converts and exports the database to `.csv`s
   * `mdb-tables` and `mdb-export` are connected via `xargs` and `bash`
   * This code is based on a reply by Eduard Florinescu on the [Ask Ubuntu Stack Exchange](https://askubuntu.com/questions/342925/opening-an-accdb-file-in-ubuntu)

`accessor.bash` can be run as a `bash` command, but needs to be given a path to either a remote (option `-r`) or local (option `-l`) database, as in
```
sudo bash scripts/accessor.bash -r ftp://ftp.wildlife.ca.gov/salvage/Salvage_data_FTP.accdb  
``` 
or
```
sudo bash scripts/accessor.bash -r path/to/local.mdb
```

In total, there are 5 options to the `accessor.bash` script:
1. `-r`: path to a **r**emote database
2. `-l`: path to a **l**ocal database
3. `-t`: name for the **t**emporary file when a remote database is downloaded
   * Default value is the name of the file on the remote server
4. `-d`: path to the **d**ata directory where the database's folder of `.csv`s will be located
   * Default value is `data`
5. `-k`: `y` or `n` as to whether or not to **k**eep the temporary db file
   * Default value is `n`

### Packaging into a `Docker` image

We package `accessor` into a stable [`Docker`](https://www.docker.com) [software container](https://www.docker.com/resources/what-container), as written out in the [`Dockerfile`](https://github.com/dapperstats/accessor/blob/master/Dockerfile) for the salvage database.
The associated [accessor Docker image](https://hub.docker.com/r/dapperstats/accessor) is freely available on [Docker Hub](https://hub.docker.com/).

To use the current image to generate an up-to-date container with data for yourself:
1. (If needed) [install Docker](https://docs.docker.com/get-docker/)
   * Specific instructions vary depending on OS
2. Open up a docker-ready terminal
3. Download the image
   * `sudo docker pull dapperstats/salvage`
4. Build the container
   * `sudo docker container run -ti --name salvage dapperstats/salvage`
5. Copy the data out from the container 
   * `sudo docker cp salvage:/data .`

### `R` script: local `.csv`s to `R` `list` object 

An additional conversion makes the data available in [`R`](https://www.r-project.org/) by reading in the folder of `.csv`s as a `list` of `data.frames` that is directly analagous to the `.accdb` or `.mdb` database of tables.

Within an instance of `R`, navigate to the folder where you have this code repository located, source the functions script, and read in the database:
```
source("scripts/r_functions.R")
database <- read_database()
```
The resulting `database` object is a named `list` of the database's tables, ready for analyses.

The default arguments to `read_database` assume that you have also either run `accessor.bash` or copied the data out from the `Docker` container in the directory where this code repository is located. 
However, the four arguments are flexible and general:
1. `database` is the name of the database folder (no extension) containing the `.csv`s
   * Default is `Salvage_data_FTP` as with other functionality
2. `tables` is a vectory of the database tables (`.csv`s) to read in
   * Default is `NULL`, which translates to "all tables"
3. `data_dir` is the directory where the `database` folder is located
   * Default is `data`
4. `quiet` simply toggles on/off messaging
   * Default is `FALSE`

