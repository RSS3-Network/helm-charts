#!/bin/sh
set -exu

GETH_CHAINDATA_DIR="$GETH_DATADIR/geth/chaindata"
GENESIS_FILE_PATH="${GENESIS_FILE_PATH:-/config/genesis.json}"

echo "================================================"
echo "Chain ID: $GETH_NETWORKID"
echo "================================================"

if [ ! -d "$GETH_CHAINDATA_DIR" ]; then
	echo "$GETH_CHAINDATA_DIR missing, running init"
	echo "Initializing genesis."
	geth --verbosity=4 init \
		--datadir="$GETH_DATADIR" \
		"$GENESIS_FILE_PATH"
else
	echo "$GETH_CHAINDATA_DIR exists."
fi

# Warning: Archive mode is required, otherwise old trie nodes will be
# pruned within minutes of starting the devnet.

exec geth --networkid=$GETH_NETWORKID "$@"
