if [ $TERM != "screen" ]
    set -x LANG en_US.UTF-8
    set -x TERM xterm-256color
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
alias power="bat_info | grep energy-rate"
alias pingip="ping 8.8.8.8"
alias pingo="ping google.com"

alias vi="vim"
alias bim="vim"
alias vin="vim"
alias qgit="git"
alias ggit="git"

# Misc functions
function find_workspaces --description "Find CtrlSpace workspaces"
    if test (count $argv) = 0
        set argv .
    end
    find $argv[1] -name .cs_workspaces | xargs --no-run-if-empty dirname
end

# Schroot stuff
function schumount
    /usr/lib/x86_64-linux-gnu/schroot/schroot-listmounts -m /run/schroot/mount | xargs -n 1 --no-run-if-empty sudo umount
end

function schclean
    schumount; and sudo rm -r /run/schroot/mount/*; and sudo rm -r /var/lib/schroot/session/*
end

# Find things in source code files
set src_file_exts cpp hpp cc hh h c py ino js java

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
    if test (count $argv) = 1
        src_files | xargs grep --color $argv[1]
    else
        src_files $argv[2] | xargs grep --color $argv[1] $argv[3..-1]
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

function bitcraze-toolbelt
    docker run --rm -it \
       -e HOST_CW_DIR=$PWD \
       -e CALLING_HOST_NAME=(hostname) \
       -e CALLING_UID=(id --user) \
       -e CALLING_OS=(uname) \
       -v $PWD:/tb-module \
       -v $HOME/.ssh:/root/.ssh \
       -v /var/run/docker.sock:/var/run/docker.sock \
       bitcraze/toolbelt $argv
end

# Git helpers
function git_changes --description "print the number of additions + deletions in a hash"
    git show --shortstat $argv[1] | grep -E "fil(e|es) changed" | awk '{print $4 + $6}'
end

function git_all_hashes
    git log --format=%H $argv
end

function git_all_hashes_with_changes
    for hash in (git_all_hashes $argv)
        echo -- (git_changes $hash) $hash
    end
end

function git_hashes_sorted_by_size
    set -l all_hashes (git_all_hashes_with_changes $argv)
    string join \n $all_hashes | sort --numeric-sort --reverse -
end

# bobthefish theme settings
set -g theme_show_exit_status yes
set -g fish_prompt_pwd_dir_length 3
set -g theme_color_scheme base16-light
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_stashed_verbose yes
set -g theme_display_git_staged_verbose yes
set -g theme_display_git_untracked_verbose yes
set -g theme_nerd_fonts yes
set -g theme_date_format "+%X %Z"

function fish_greeting; end

    # Source computer-specific stuff
    source (dirname (status --current-filename))/config-local.fish
