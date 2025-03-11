#!/bin/bash

rm -f ./dsb.db

# create schema
echo "create dsb schema"
echo -ne ".read create_tables.sql" | duckdb ./dsb.db

# load dsb
for table in customer_address customer_demographics date_dim warehouse ship_mode time_dim reason income_band item store call_center customer web_site store_returns household_demographics web_page promotion catalog_page inventory catalog_returns web_returns web_sales catalog_sales store_sales 
do
  echo "duckdb load table from ${table}.tbl"
  command="copy ${table} from '${PWD}/../code/tools/out/csv/${table}.csv' (quote '\"', escape '\\');"
  echo $command
  echo -ne "${command}" | duckdb ./dsb.db
done

# execute queries
dir_1="${PWD}/../code/tools/out/1/"
dir_2="${PWD}/../code/tools/out/2/"
iteration=1

rm -rf job_result/
mkdir -p job_result/

for i in $(eval echo {1.."${iteration}"}); do
  for sql in $(find "$dir_1" "$dir_2" -type f -name "*.sql"); do
    echo "execute ${sql}" 2>&1|tee -a duckdb_dsb.txt;
    echo -ne ".read ${sql}" | duckdb ./dsb.db 2>&1|tee -a duckdb_dsb.txt;
  done
done

mv duckdb_dsb.txt job_result/.

