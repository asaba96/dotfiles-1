alias aptup='sudo apt update && sudo apt upgrade'
alias gitstashrecover=$'git log --graph --oneline --decorate $(git fsck --no-reflog | awk \'/dangling commit/ {print $3}\')'
alias moptirun='optirun -s /run/bumblebee/bumblebee.socket'
alias rm_hiberfile='mkdir /mnt/hdd && \
                    mount -r /dev/sda5 /mnt/hdd && \
                    mount -o remount rw /mnt/hdd && \
                    ls /mnt/hdd && \
                    rm /mnt/hdd/hiberfil.sys && \
                    ls /mnt/hdd && \
                    umount /mnt/hdd && \
                    rm -r /mnt/hdd'
alias bat_info="upower -i /org/freedesktop/UPower/devices/battery_BAT1"
alias pingip="ping 8.8.8.8"
alias pingo="ping google.com"

alias vi="vim"
alias bim="vim"
alias vin="vim"

# Schroot stuff
alias schumount='/usr/lib/x86_64-linux-gnu/schroot/schroot-listmounts -m /run/schroot/mount | xargs -n 1 sudo umount'
alias schclean='schumount && \
                sudo rm -r /run/schroot/mount/* && \
                sudo rm -r /var/lib/schroot/session/*'

# ROS stuff
alias rosme='export ROS_MASTER_URI=http://localhost:11311; \
             unset ROS_HOSTNAME'
