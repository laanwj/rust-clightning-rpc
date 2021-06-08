#!/bin/bash
./run-bitcoin.sh
./generate-block-bitcoin.sh
./run-clightning.sh
sleep 0.5m # Give the time to c-lightning to sync the network
cd code
echo "Running test with Cargo"
RESULT_TEST=$(cargo test)
cd ..
./stop-clightning.sh
./stop-bitcoin.sh
rm -rf **/*.pid **/regtest
echo "Result test is $RESULT_TEST"
if [ "$RESULT_TEST" -eq "0" ] ; then
    exit 0
else
    exit 1
fi
