#!/bin/sh

# usage: ./parser.sh <FILENAME> <SQS URL>
# example: ./parser.sh file.csv https://sqs.ap-southeast-1.amazonaws.com/853765034474/vcm-apn-dev
FILENAME=$1
URL=$2
RESULTFILE="${FILENAME}-result.txt"

echo "" > $RESULTFILE

while IFS=, read -r body || [ -n "$body" ]
do
    echo "Processing:\n\body: $body" >> $RESULTFILE
    aws sqs send-message --queue-url $2 --message-body "$body" >> $RESULTFILE
    # done
done < $FILENAME