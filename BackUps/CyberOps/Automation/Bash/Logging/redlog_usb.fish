#!/usr/bin/env fish

# -----------------------------
# VeraCrypt Red Team Log Transfer
# -----------------------------

# CONFIG
set default_vc_container_name "redteam_logs.hc"
set vc_mount "/mnt/veracrypt1"
set local_logdir "$HOME/.redlogs"
set archived_logdir "$HOME/.redlogs/archived"

echo "==== VeraCrypt Logging Transfer ===="

# -----------------------------
# Prompt for external HDD mount point
echo -n "Enter path where your external USB is mounted: "
read USB_mount

sudo mkdir -p /mnt/tmp
sudo mount "$USB_mount" /mnt/tmp

# Build full path to the VeraCrypt container
set vc_container "/mnt/tmp/$default_vc_container_name"

# Check VeraCrypt container exists
if test ! -f $vc_container
    echo "ERROR: VeraCrypt container not found at $vc_container"
    exit 1
end

# Ensure archived folder exists
mkdir -p $archived_logdir

# Mount VeraCrypt volume
echo "Mounting VeraCrypt container..."
veracrypt --text --mount $vc_container $vc_mount
if test $status -ne 0
    echo "ERROR: Failed to mount VeraCrypt volume."
    exit 1
end

echo "Mounted VeraCrypt volume at $vc_mount"

# Process all client folders
for clientdir in $local_logdir/*
    if test -d $clientdir
        set client (basename $clientdir)
        echo "Processing client: $client"

        # Create client folder in VeraCrypt volume
        mkdir -p $vc_mount/$client
        mkdir -p $archived_logdir/$client

        # Copy all session logs
        for logfile in $clientdir/session_*.log
            if test -f $logfile
                echo "  -> Transferring $logfile"
                cp $logfile $vc_mount/$client/
                mv $logfile $archived_logdir/$client/
            end
        end
    end
end

echo "All logs transferred successfully."

# Dismount VeraCrypt volume
echo "Dismounting VeraCrypt volume..."
veracrypt -d $vc_mount

echo "Done!"

