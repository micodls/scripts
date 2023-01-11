// extracted from cloudwatch logs
// formatted manually - remove first column, remove unwanted logs, remove unwanted fields, replace double double quotes to single double quotes

const fs = require('fs');
const moment = require('moment');

const main = async () => {
    const lineReader = require('readline').createInterface({
        input: fs.createReadStream('./logs-insights-results.txt')
    });
    lineReader.on('line', (line) => {
        const _line = JSON.parse(line);
        const { headers: { 'X-Boost-Member-Uid': uid }, data, amount } = _line;
        const unixTs = moment.utc(data.ts).valueOf();
        const index = parseInt((Number(uid.slice(-2))/5) + 1);
        const payload = { identity: { uid, msisdn: uid }, body: { ...data } };
        if (amount !== undefined) {
            payload.body.amount = amount;
        }
        console.log(`${unixTs};production:paymaya:legacy:messages:${index};'${JSON.stringify(payload).replace(/'/g, "")}'`);
    });
}

main();