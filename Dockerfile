# Base image is r-base
FROM r-base

# Add libraries
RUN apt-get update \
    && apt-get install -y \
       mdbtools \
       unixodbc-dev

# Move the scripts folder into the container
COPY scripts scripts

# Default values for arguments passed to environment variables
ARG r="ftp://ftp.wildlife.ca.gov/salvage/Salvage_data_FTP.accdb" 
ARG l=local.accdb 
ARG d=data 
ARG k=n
ARG i=n

# Set environment variables to pass to container_start.bash
ENV REMOTE_DB_FILE=$r \
    LOCAL_DB_FILE=$l \
    DATA_DIR=$d \
    KEEP_TEMP_DB_FILE=$k \
    INTERACTIVE_R=$i

# When the container is built, execute container_start.bash
CMD bash scripts/container_cmd.bash -r $REMOTE_DB_FILE -l $LOCAL_DB_FILE -d $DATA_DIR -k $KEEP_TEMP_DB_FILE -i $INTERACTIVE_R
