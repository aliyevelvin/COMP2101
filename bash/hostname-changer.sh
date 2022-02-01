#!/bin/bash
#
# This script is for the bash lab on variables, dynamic data, and user input
# Download the script, do the tasks described in the comments
# Test your script, run it on the production server, screenshot that
# Send your script to your github repo, and submit the URL with screenshot on Blackboard

# Get the current hostname using the hostname command and save it in a variable
myhostname=$(hostname)
# Tell the user what the current hostname is in a human friendly way
cat <<EOF
Your current host name is: $myhostname
EOF

# Ask for the user's student number using the read command
echo "Enter your student number"
read studnum
# Use that to save the desired hostname of pcNNNNNNNNNN in a variable, where NNNNNNNNN is the student number entered by the user
newhostname=pc$studnum
echo $newhostname
# If that hostname is not already in the /etc/hosts file, change the old hostname in that file to the new name using sed or something similar and
#     tell the user you did that
#e.g. sed -i "s/$oldname/$newname/" /etc/hosts
grep -q $newhostname /etc/hosts && echo "hostname exists in file" || sudo sed -i "s/$myhostname/$newhostname/" /etc/hosts && echo "string $myhostname was replaced by $newhostname in file /etc/hosts"

# If that hostname is not the current hostname, change it using the hostnamectl command and
#     tell the user you changed the current hostname and they should reboot to make sure the new name takes full effect
#e.g. hostnamectl set-hostname $newname
[ "$HOSTNAME" != "$newhostname" ] && sudo hostnamectl set-hostname $newhostname && echo "hostname has been changed, you need to reboot"
