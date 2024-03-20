#!/bin/sh

set -eux

URL=http://localhost:8545;

get_current_block() {
    data='{"jsonrpc":"2.0","method":"eth_blockNumber","params":[],"id":1}';
    response=$(curl -s -X POST -H "Content-Type: application/json" --data "$data" $URL);
    echo "response: $response";
    hex=$(echo "$response" | jq -r '.result');
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
block=$(get_current_block);
echo "block: $block";

if [ "$block" -eq 0 ]; then
  echo "Block height is 0.";
  exit 1;
fi;

echo "RPC endpoint at $URL is healthy.";