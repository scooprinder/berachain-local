CNT=0
ITER=$1
SLEEP=$2
NUMBLOCKS=$3
NODEADDR=$4

if [ -z "$ITER" ] || [ -z "$SLEEP" ] || [ -z "$NUMBLOCKS" ] || [ -z "$NODEADDR" ]; then
  echo "Invalid argument: missing or incomplete input"
  echo "Usage: sh check_liveliness.sh <iterations> <sleep> <num-blocks> <node-address>"
  exit 1
fi

docker_containers=($(docker ps -q -f name=berad --format='{{.Names}}'))

while [ $CNT -lt $ITER ]; do
  curr_block=$(curl -s "$NODEADDR:26657/status" | jq -r '.result.sync_info.latest_block_height')

  if [ -n "$curr_block" ]; then
    echo "Current block: $curr_block"
  fi

  if [ -n "$curr_block" ] && [ $curr_block -gt $NUMBLOCKS ]; then
    echo "Success: number of blocks reached"
    exit 0
  fi

  sleep $SLEEP
  CNT=$((CNT + 1))
done

echo "Failed: timeout reached"
exit 1
