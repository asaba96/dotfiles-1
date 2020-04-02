# Defined in /tmp/fish.EiZ6LW/latex_reverse_copy.fish @ line 2
function latex_reverse_copy
	pushd ~/Developer/latex-homework-template
    git diff-index --quiet HEAD \*.sty
    if test $status -ne 0
        echo 'Changes in latex-homework-template, please stash' >&2
        popd
        return
    end
    popd

    cp *.sty ~/Developer/latex-homework-template/

    git -C ~/Developer/latex-homework-template diff >&2
end
