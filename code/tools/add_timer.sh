timer_begin='
DO
$do$
DECLARE
   _timing1  timestamptz;
   _start_ts timestamptz;
   _end_ts   timestamptz;
   _overhead numeric;     -- in ms
   _timing   numeric;     -- in ms
BEGIN
   _timing1  := clock_timestamp();
   _start_ts := clock_timestamp();
   _end_ts   := clock_timestamp();
   -- take minimum duration as conservative estimate
   _overhead := 1000 * extract(epoch FROM LEAST(_start_ts - _timing1 , _end_ts - _start_ts));
   _start_ts := clock_timestamp();
'

timer_end='
   _end_ts   := clock_timestamp();
   
-- RAISE NOTICE '\''Timing overhead in ms = %'\'', _overhead;
   RAISE NOTICE '\''Execution time in ms = %'\'', 1000 * (extract(epoch FROM _end_ts - _start_ts)) - _overhead;
END
$do$;
'

# Convert newlines in insert_code to literal "\n" for sed
insert_code_begin=$(echo "${timer_begin}" | sed ':a;N;$!ba;s/\n/\\n/g')

# Escape special characters in insert_code
# shellcheck disable=SC2034
# shellcheck disable=SC2001
insert_code_end=$(echo "${timer_end}" | sed "s/'/\\\\'/g")

# shellcheck disable=SC2043
for dir in out/*; do
  if [ -d "${dir}" ]; then
    echo "${dir}"
    # shellcheck disable=SC2231
    for sub_dir in ${dir}/*; do
      if [ -d "${sub_dir}" ]; then
        echo "${sub_dir}"
        for file in ${sub_dir}/*.sql; do
          # Check if the file is a regular file
          if [ -f "$file" ]; then
            echo "${file}"

            ### add timer_begin
            sed -i "1s/^/${insert_code_begin}/" "${file}"

            ### add timer_end
            # sed -i -e "\$a\\${insert_code_end}" out/queries/${i}.sql
            echo "${timer_end}" >> ${file}

            ### replace first `select` by `perform`
            # sed -i '0,/select/{s//perform/}' "${file}"
	    # sed -i -e '0,/[(]select/{/(select/!s/select/perform/}' "${file}"
	    # sed -i '/(select\|intersect\|union\|except\|intersect all\|union all\|except all)/!{s/select/perform/1}' "${file}"
	    sed -i 's/select/perform/g' "${file}"
	    sed -i 's/(perform/(select/g' "${file}"
	    sed -i '/perform/{:a;N;/intersect\|union\|except\|intersect all\|union all\|except all/s/\bperform/select/g;Ta}' "${file}"
          fi
        done
      fi
    done
  fi
done

