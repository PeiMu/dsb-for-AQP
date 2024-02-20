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
	    psql < "${file}"
	  fi
        done
      fi
    done
  fi
done

