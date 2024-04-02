#!/bin/sh

set -eux

URL=http://localhost:8545;
SLEEP_DURATION=${1:-10}  # Default sleep duration is 10 seconds, can be overridden by passing an argument

get_current_block() {
    data='{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}';
    hex=$(curl -s -X POST -H "Content-Type: application/json" --data "$data" $URL | jq -r '.result');
    trimmed_hex=${hex#0x};
    echo $((16#$trimmed_hex));
}

check_syncing_status() {
    data='{"jsonrpc":"2.0","method":"eth_syncing","params":[],"id":1}';
    response=$(curl -s -X POST -H "Content-Type: application/json" --data "$data" "$URL");
    echo "response: $response";
    syncing=$(echo "$response" | jq -r '.result');
    if [ "$syncing" != "false" ]; then
      echo "$URL is syncing." exit 1;
    fi;
    echo "Replica is synced.";
}

check_syncing_status;
block_first_query=$(get_current_block);
echo "block_first_query: $block_first_query";
if [ "$block_first_query" -eq 0 ]; then
  echo "Block height is 0.";
  exit 1;
fi;

sleep $SLEEP_DURATION
block_second_query=$(get_current_block);
echo "block_second_query: $block_first_query";
if [ "$block_first_query" -eq "$block_second_query" ]; then
  echo "Block is not in syncing.";
  exit 2;
fi;

echo "RPC endpoint at $URL is healthy.";