#!/bin/bash

if [ -z "$1" ]; then
  echo "Please enter scale factor to choose the correct database!"
  exit 1
fi

csv_dir=../code/tools/out_$1/csv
rm -rf ${csv_dir}
mkdir -p ${csv_dir}

for table in customer_address customer_demographics date_dim warehouse ship_mode time_dim reason income_band item store call_center customer web_site store_returns household_demographics web_page promotion catalog_page inventory catalog_returns web_returns web_sales catalog_sales store_sales
do
  psql -U postgres -d dsb_$1 -c "\\copy ${table} to '${PWD}/${csv_dir}/${table}.csv' csv";
done

echo "Finish exporting to csv files in ${csv_dir}!!!"
