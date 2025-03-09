#!/bin/bash

awk '
BEGIN {
    FS = "\t";
    OFS = "\t";
    # 加载 FTP 路径数据
    while ((getline < "fna-ftp.txt") > 0) {
        sub(/\/$/, "", $0);  # 移除末尾斜杠
        n = split($0, parts, "/");
        basename = parts[n];
        # 匹配标准 GCA 编号（如 GCA_123456789.1）
        if (match(basename, /GCA_[0-9_]+[.][0-9]+/)) {
            gca = substr(basename, RSTART, RLENGTH);
            ftp_map[gca] = $0;
        }
    }
    close("fna-ftp.txt");
}

# 处理 rename.tsv
{
    if (NF < 2) {
        printf "警告: 跳过无效行: %s\n", $0 > "/dev/stderr";
        next;
    }
    gca = $1;
    species = $2;
    gsub(/ /, "_", species);
    if (gca in ftp_map) {
        print species, ftp_map[gca];
    } else {
        printf "警告: 未找到 %s 的FTP路径（检查 fna-ftp.txt 或编号格式）\n", gca > "/dev/stderr";
    }
}
' rename.tsv > download.txt

