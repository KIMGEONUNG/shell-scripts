block="/dev/nvme0n1"
file_result="gpt-dump"
size_gpt=$((512 * 34))

sudo dd if=$block of=$file_result count=$size_gpt bs=1
