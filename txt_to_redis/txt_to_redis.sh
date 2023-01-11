#!/bin/sh
# Run the script to server with access to promo-event-production.uu0lif.0001.apse1.cache.amazonaws.com
# time cat mem_ver_failed.txt | awk -F ";" '{print $1" "$2" "$3}' | xargs -n3 sh -c 'redis-cli -h promo-event-production.uu0lif.0001.apse1.cache.amazonaws.com -n 0 zadd $2 $1 "$3"' sh > mem_ver_failed-results.txt

time cat ./format/413-reprocess.txt | awk -F ";" '{print $1" "$2" "$3}' | xargs -n3 sh -c 'redis-cli -n 3 zadd $2 $1 "$3"' sh > 413-reprocess-results.txt
time cat ./format/4223-nov-1-reprocess.txt | awk -F ";" '{print $1" "$2" "$3}' | xargs -n3 sh -c 'redis-cli -n 3 zadd $2 $1 "$3"' sh > 4223-nov-1-reprocess-results.txt
time cat ./format/4223-nov-2-reprocess.txt | awk -F ";" '{print $1" "$2" "$3}' | xargs -n3 sh -c 'redis-cli -n 3 zadd $2 $1 "$3"' sh > 4223-nov-2-reprocess-results.txt
time cat ./format/4223-nov-3-reprocess.txt | awk -F ";" '{print $1" "$2" "$3}' | xargs -n3 sh -c 'redis-cli -n 3 zadd $2 $1 "$3"' sh > 4223-nov-3-reprocess-results.txt
time cat ./format/4223-dec-1-reprocess.txt | awk -F ";" '{print $1" "$2" "$3}' | xargs -n3 sh -c 'redis-cli -n 3 zadd $2 $1 "$3"' sh > 4223-dec-1-reprocess-results.txt
time cat ./format/4223-dec-2-reprocess.txt | awk -F ";" '{print $1" "$2" "$3}' | xargs -n3 sh -c 'redis-cli -n 3 zadd $2 $1 "$3"' sh > 4223-dec-2-reprocess-results.txt
time cat ./format/4223-dec-3-reprocess.txt | awk -F ";" '{print $1" "$2" "$3}' | xargs -n3 sh -c 'redis-cli -n 3 zadd $2 $1 "$3"' sh > 4223-dec-3-reprocess-results.txt
time cat ./format/4223-jan-1-reprocess.txt | awk -F ";" '{print $1" "$2" "$3}' | xargs -n3 sh -c 'redis-cli -n 3 zadd $2 $1 "$3"' sh > 4223-jan-1-reprocess-results.txt