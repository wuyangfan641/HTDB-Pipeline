import re
import csv

def extract_gca(ftp_link):
    """从FTP链接中提取GCA_xxxx格式的编号"""
    match = re.search(r'GCA_[^/_]+', ftp_link)
    return match.group() if match else None

# 构建GCA编号到FTP链接的映射字典
gca_mapping = {}
with open('fna_ftp.txt', 'r') as f:
    for line in f:
        ftp_link = line.strip()
        gca_number = extract_gca(ftp_link)
        if not gca_number:
            print(f"警告：无法从链接提取GCA编号: {ftp_link}")
            continue
        gca_mapping[gca_number] = ftp_link

# 生成两个输出文件
with open('rename.tsv', 'r') as infile, \
     open('download.txt', 'w', newline='') as download_file:

    reader = csv.reader(infile, delimiter='\t')
    writer = csv.writer(download_file, delimiter=' ')  # 使用空格分隔

    for row in reader:
        if len(row) < 2:
            continue  # 跳过无效行

        original_gca, species = row[0], row[1]
        modified_species = species.replace(' ', '_')

        # 查找匹配的FTP链接并交换列位置
        matched_ftp = gca_mapping.get(original_gca)
        
        if matched_ftp:
            writer.writerow([modified_species, matched_ftp])  # 物种名在前
        else:
            print(f"警告：未找到 {original_gca} 的FTP链接，跳过记录")
