#!/bin/bash

echo "shcli code defference test"

#old_path="C:\\Users\\comar\\SHIntegration_new\\SHCoreConsole"
#new_path="C:\\Users\\comar\\SHIntegration_old\\SHServers\\SHCoreConsole"

old_path="C:\\Users\\comar\\SHIntegration_new\\IPAnalyzer\\Kernel\\ReportMaker.cs"
new_path="C:\\Users\\comar\\SHIntegration_old\\SHServers\\IPAnalyzer\\Kernel\\ReportMaker.cs"

echo "old path : ${old_path}"
echo "new path : ${new_path}"

diff -p ${old_path} ${new_path}
