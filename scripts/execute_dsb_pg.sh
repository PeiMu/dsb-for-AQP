#!/bin/bash

dir_1="${PWD}/../code/tools/out/1/"
dir_2="${PWD}/../code/tools/out/2/"
iteration=1

rm -f dsb_result/*
mkdir -p dsb_result/

for i in $(eval echo {1.."${iteration}"}); do
  for sql in $(find "$dir_1" "$dir_2" -type f -name "*.sql"); do
    echo "execute ${sql}" 2>&1|tee -a pg_dsb.txt;
    psql -U postgres -d dsb -f "${sql}" 2>&1|tee -a pg_dsb.txt;
  done
done

mv pg_dsb.txt dsb_result/.
