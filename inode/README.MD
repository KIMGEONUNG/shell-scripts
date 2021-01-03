# Overview

 This is analysis for inode data structure in EXT4 filesystem used in linux

## Examples

 The _dump.hex.inode-table.sh_ script dumps inode table data as binary into file naming _node-table.bin_.
The first arguement of script is target device block path.

``` bash
sudo ./dump.hex.inode-table.sh "/dev/nvme0n1p5"
```

``` bash
sudo ./extract-inode-entry.sh /dev/nvme0n1p5 793574
```
