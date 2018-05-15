function jpid
	set -l j (jobs)
for job in $j
set -l job_parts (string split \t $job)
if test $job_parts[1] = $argv[1]
echo $job_parts[2]
end
end
end
