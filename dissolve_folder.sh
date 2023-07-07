#!/bin/bash

# 检查参数个数
if [ $# -ne 1 ]; then
  echo "Usage: $0 folder_name"
  exit 1
fi

# 检查目标文件夹是否存在
if [ ! -d "$1" ]; then
  echo "Error: $1 is not a directory"
  exit 2
fi

# 备份目标文件夹的路径和名称
folder_path=$(dirname "$1")
folder_name=$(basename "$1")

# 移动目标文件夹中的文件到父文件夹中
mv "$1"/* "$folder_path"

# 删除目标文件夹及其子文件夹
rm -rf "$1"

echo "Folder $folder_name has been dissolved."
