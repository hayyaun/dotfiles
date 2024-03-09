#!/bin/bash

set -e

API="https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum&vs_currencies=usd"

resp=$(curl -s --request GET --url $API)
btc=$(echo "$resp" | jq -r ".bitcoin.usd" 2>&1)
btc=$(LANG=C printf "%.0f" "$btc" 2>&1)
eth=$(echo "$resp" | jq -r ".ethereum.usd" 2>&1)
eth=$(LANG=C printf "%.0f" "$eth" 2>&1)

echo -n ""

overwrite() { echo -e -n "\r$@"; }

if [ -n "$btc" ]; then
    overwrite "BTC: \$$btc"
fi

if [ -n "$eth" ]; then
    overwrite " ETH: \$$eth"
fi
