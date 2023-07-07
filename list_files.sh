#!/bin/bash

# 检查参数个数
if [ $# -ne 1 ]; then
  echo "Usage: $0 directory_path"
  exit 1
fi

# 检查目录是否存在
if [ ! -d "$1" ]; then
  echo "Error: $1 is not a directory"
  exit 2
fi

# 计算目录总大小
total_size=$(du -s "$1" | cut -f 1)

# 列出目录下的所有文件，并按照大小排序
du -ah --max-depth=1 "$1" | sort -hr | while read line; do
  # 提取文件名、大小和占总大小的百分比
  size=$(echo "$line" | cut -f 1)
  path=$(echo "$line" | cut -f 2-)
  percent=$(du -s "$path" | cut -f 1)
  percent=$(printf "%.2f" $(echo "scale=4; $percent*100/$total_size" | bc))

  # 输出文件名、大小和百分比
  filename=$(basename "$path")
  echo -e "$filename\t$size\t$percent%"
done
