function boom
	set -l terminators
for i in (seq 100)
set terminators $terminators terminator
end
eval (string join ' -x ' $terminators)
end
