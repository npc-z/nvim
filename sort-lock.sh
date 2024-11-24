#!/bin/bash

# 输入的 JSON 文件路径
input_file="./lazy-lock.json"

# 检查 jq 是否安装
if ! command -v jq &>/dev/null; then
    echo "jq 未安装，请先安装 jq 工具"
    exit 1
fi

# 检查输入文件是否存在
if [ ! -f "$input_file" ]; then
    echo "输入文件不存在：$input_file"
    exit 1
fi

# 使用 jq 递归排序所有嵌套层级的键，并覆盖原文件
jq 'def sort_keys: . as $in |
    if type == "object" then
        $in | to_entries | sort_by(.key) | from_entries | map_values(sort_keys)
    elif type == "array" then
        map(sort_keys)
    else
        .
    end;
    sort_keys' "$input_file" > "$input_file.tmp" && mv "$input_file.tmp" "$input_file"

# 检查操作是否成功
if [ $? -eq 0 ]; then
    echo "JSON 文件已成功按字母顺序排序所有嵌套层级的键，并保存到原文件：$input_file"
else
    echo "排序过程中出现错误"
    exit 1
fi

