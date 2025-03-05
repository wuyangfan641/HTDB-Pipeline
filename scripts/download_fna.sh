#!/bin/bash

# 检查输入参数
if [[ $# -ne 1 ]]; then
    echo "用法: $0 <输入文件>"
    echo "输入文件格式：每行包含物种名和FTP链接，用空格或制表符分隔"
    exit 1
fi

input_file="$1"

# 检查输入文件是否存在
if [[ ! -f "$input_file" ]]; then
    echo "错误：输入文件 $input_file 不存在"
    exit 1
fi

# 读取并处理每一行
while IFS=$' \t' read -r species url || [[ -n "$species" ]]; do
    # 跳过空行和注释行
    [[ -z "$species" || "$species" == \#* ]] && continue
    
    # 提取文件名并处理扩展名
    filename=$(basename "$url")
    if [[ "$filename" == *.* ]]; then
        extension="${filename: -6}"
        new_name="${species}.${extension}"
    else
        new_name="$species"
    fi

    # 下载文件
    echo -n "下载 $species... "
    if wget -q --show-progress -O "$new_name" "$url"; then
        echo "保存为 $new_name"
    else
        echo "失败！删除残留文件"
        rm -f "$new_name"
    fi
done < "$input_file"

echo "所有任务完成"
