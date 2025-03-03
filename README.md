# IxodoideaDB-annotation-pipeline

### 01 Prerequisites
#### 1.1 Software
+ BUSCO (https://busco.ezlab.org/) (compleasm(https://github.com/huangnengCSU/compleasm), compleasm: a faster and more accurate reimplementation of BUSCO)
+ HiTE (https://github.com/CSU-KangHu/HiTE)
+ Bakta (https://github.com/oschwengers/bakta)
+ geNomad (https://github.com/apcamargo/genomad)


#### 1.2 Database
+ arachnida_odb10 (https://busco-data.ezlab.org/v5/data/lineages/arachnida_odb10.2024-01-08.tar.gz)
+ db-light (https://zenodo.org/record/7669534/files/db-light.tar.gz?download=1)
+ genomad_db (https://portal.nersc.gov/genomad/__data__/genomad_db_v1.9.tar.gz)


### 02 Genome assessment
#### BUSCO v5.6.0
- genome.fna
- arachnida_odb10
```bash
busco -i ./tickdb/genome.fna -l ./arachnida_odb10 -o output_dir -m genome --cpu 12 --offline
```
