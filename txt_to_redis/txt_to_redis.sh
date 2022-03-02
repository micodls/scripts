#!/bin/sh

time cat test.txt | awk -F ";" '{print $1" "$2" "$3}' | xargs -n3 sh -c 'redis-cli -n 3 zadd $2 $1 "$3"' sh > test-results.txt