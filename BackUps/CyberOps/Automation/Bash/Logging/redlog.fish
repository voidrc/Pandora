#!/usr/bin/env fish

# ------------------------
# Red Team Session Logger
# ------------------------

# Ask for client / engagement name
if test (count $argv) -eq 0
    echo -n "Enter client/engagement name: "
    read client
else
    set client $argv[1]
end

# Sanitize folder name
set client (string replace -a ' ' '_' $client)

# Directory to save logs
set logdir "$HOME/.redlogs/$client"
mkdir -p $logdir

# Timestamped filename
set ts (date "+%Y:%m:%d_%H:%M:%S")
set logfile "$logdir/session_$ts.log"

echo "---------------------------------------------"
echo "Starting Red Team logging session"
echo "Client/Engagement : $client"
echo "Log File          : $logfile"
echo "---------------------------------------------"

# Run the terminal logging session
script -q -f --command "fish" $logfile

echo "---------------------------------------------"
echo "Session ended. Log saved to $logfile"
echo "---------------------------------------------"

