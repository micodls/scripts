#!/bin/sh

time cat mem_ver_failed.txt | awk -F ";" '{print $1" "$2" "$3}' | xargs -n3 sh -c 'redis-cli -n 4 zadd $2 $1 "$3"' sh > mem_ver_failed-results.txt