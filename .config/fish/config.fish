set fish_greeting

# enable powerline
if [ $TERM != "screen" ]
    set -x LANG en_US.UTF-8
    #powerline-daemon -q # ${POWERLINE_COMMAND_ARGS}
    set PYTHON_VERSION 3.6
    set POWERLINE_COMMAND powerline
    set fish_function_path $fish_function_path "/usr/local/lib/python$PYTHON_VERSION/dist-packages/powerline/bindings/fish"
    powerline-setup
end

function fish_user_key_bindings
    bind \e\[1\;4C nextd-or-forward-word
    bind \cs nextd-or-forward-word

    bind \e\[1\;4D prevd-or-backward-word
    bind \ca prevd-or-backward-word
end

##### ALIASES #####
alias aptup='sudo apt update; and sudo apt upgrade'

function gitstashrecover
    git log --graph --oneline --decorate (git fsck --no-reflog | awk '/dangling commit/ {print $3}')
end

alias moptirun='optirun -s /run/bumblebee/bumblebee.socket'

function rm_hiberfile
    mkdir /mnt/hdd; and \
    mount -r /dev/sda5 /mnt/hdd; and \
    mount -o remount rw /mnt/hdd; and \
    ls /mnt/hdd; and \
    rm /mnt/hdd/hiberfil.sys; and \
    ls /mnt/hdd; and \
    umount /mnt/hdd; and \
    rm -r /mnt/hdd
end

alias bat_info="upower -i /org/freedesktop/UPower/devices/battery_BAT1"
alias pingip="ping 8.8.8.8"
alias pingo="ping google.com"

alias vi="vim"
alias bim="vim"
alias vin="vim"

# Schroot stuff
function schumount
    /usr/lib/x86_64-linux-gnu/schroot/schroot-listmounts -m /run/schroot/mount | xargs -n 1 --no-run-if-empty sudo umount
end

function schclean
    schumount; and sudo rm -r /run/schroot/mount/*; and sudo rm -r /var/lib/schroot/session/*
end

# Find things in source code files
set src_file_exts cpp hpp h c py ino js java

function src_files
    set -l regex_parts
    for s in $src_file_exts
        set regex_parts $regex_parts '.*\.'$s
    end
    set -l regex (string join '\|' $regex_parts)
    if test (count $argv) = 1
        find $argv[1] -name '\.git' -prune -o -regex "$regex" -print
    else
        find . -name '\.git' -prune -o -regex "$regex" -print
    end
end

function src_grep
    if test (count $argv = 2)
        src_files $argv[2] | xargs grep --color $argv[1]
    else
        src_files | xargs grep --color $argv[1]
    end
end

function grep_src_ext
    set -l files (string join '|' $src_file_exts)
    grep -E "\.($files)\b"
end

# ROS stuff
function roshostname
    set -xg ROS_HOSTNAME (hostname -I | grep -o "^[^ ]\+")
end

function rosme
    set -xg ROS_MASTER_URI http://localhost:11311
    roshostname
end
