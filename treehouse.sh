#!/bin/bash

matches=$(curl -s '<airbnb-calendar-request>'| grep -ohP \"available\":true,\"date\":\".*?\")
if [ "$matches" != "" ]
then
    echo "availability!!!"
    first_date=$(echo "$matches" | grep -ohP \"date\":\".*?\" | head -1)
    echo $first_date

    curl 'https://api.twilio.com/2010-04-01/Accounts/<some-hash>/Messages.json' -X POST \
    --data-urlencode 'To=+<cassies-phone-number>' \
    --data-urlencode 'From=+<twilio-number>' \
    --data-urlencode "Body=check the treehouse airbnb, something is available on $first_date" \
    -u <some-hash>:<probably-the-twilio-secret>

else
    echo " no availability"
fi
