# Defined in /tmp/fish.wgvw4A/gi.fish @ line 2
function gi
    if test (count $argv) = 0
        git
        return
    end

    set -l args $argv

    if string match --regex \^t $args[1] > /dev/null
        # starts with t
        set args[1] (string sub --start 2 $args[1])
    end

    git $args
end
