#!/bin/bash

echo "Start clone file generator"

echo "make clones.bs file"
touch clones.bs
echo "#!/bin/bash" > clones.bs

echo "get directory list"
pwd=$(pwd)
sub_path=".git/config"

for entry in "$pwd"/*/
do
    echo "Target file name"
    target_path="$entry""$sub_path"
    echo "$target_path"
    if [ -f "$target_path" ]; then
	git_url="$(cat $target_path | grep url | sed 's/.* = //')"
	clone_cmd="git clone $git_url"
	echo "$clone_cmd" >> clones.bs 
    fi
    echo ""
done

