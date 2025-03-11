#!/bin/bash

csv_dir=../code/tools/out/csv
rm -rf ${csv_dir}
mkdir ${csv_dir}

for table in customer_address customer_demographics date_dim warehouse ship_mode time_dim reason income_band item store call_center customer web_site store_returns household_demographics web_page promotion catalog_page inventory catalog_returns web_returns web_sales catalog_sales store_sales
do
  psql -U postgres -d dsb -c "\\copy ${table} to '${PWD}/${csv_dir}/${table}.csv' csv";
done

echo "Finish exporting to csv files in ${csv_dir}!!!"
