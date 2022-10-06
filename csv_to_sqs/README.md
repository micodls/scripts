# How to extract:

## PSR

```
aws logs filter-log-events --log-group-name sirius.promo-sqs-reader.production --start-time 1664840130000 --end-time 1665035247000  --filter-pattern 'Received' --output text > prfc11173.txt
```

## PES

```
aws --profile=core logs filter-log-events --log-group-name sirius.promo-event-subscriber.production --start-time 1663855200000 --end-time 1663866000000  --filter-pattern 'Retrieved message' --output text > prfc10864.txt
```

# How to format:

## PSR

1. Run the following
    ```
    sed -i -e "s/^.*messageName.*$//" prfc11173.txt -- depends on what you need
    sed -i -e "s/^.*dossier.*$//" prfc11173.txt -- depends on what you need
    sed -i -e "s/^.*shop-service-order-events.*$//" prfc11173-1.txt -- depends on what you need
    sed -i -e "/^$/d" prfc11173.txt -- removes empty lines
    sed -i -e "s/^.*EVENTS.*Received //" prfc11173.txt -- removes excess logs
    sed -i -e "s/\t.*$//" prfc11173.txt -- removes excess logs
    sed -i -e "s/^.*Body\"\:\"//" prfc11173.txt -- removes excess logs
    sed -i -e "s/\\\\n  //g" prfc11173.txt -- removes excess logs
    sed -i -e "s/\\\\n//g" prfc11173.txt -- removes excess logs
    sed -i -e "s/,\"Attributes\":{\"ApproximateReceiveCount\":\"1\"}//" prfc11173.txt -- removes excess logs
    split -l 100000 prfc11173.txt
    ```
2. manually replaced \" to "
3. manually replaced \\" to \"
4. manually removed "} from last part of line


# How to test:

## Locally

```
./csv_to_sqs.sh test.csv https://sqs.ap-southeast-1.amazonaws.com/644947453434/promo-events
```

## Staging

```
./csv_to_sqs.sh test.csv https://sqs.ap-southeast-1.amazonaws.com/445417093929/promo-event-queue-staging
```


# Example

1. PSR - https://mayaph.atlassian.net/browse/PRFC-11173
2. PES - https://mayaph.atlassian.net/browse/PRFC-10900