#!/bin/bash

NUM_SERVERS=${NUM_SERVERS:-4}

if [ ! "$(ls -A /samples)" ]; then
    echo "ERROR: An samples directory must be volume mounted on /samples"
    exit 1
fi

for ((i = 0; i < $NUM_SERVERS; i++)); do
    port=40$(printf "%02d" $i) # Port number, starting at 4000
    echo "    server radamsa${i} 127.0.0.1:40${i} check" >> /etc/haproxy/haproxy.cfg
    radamsa -o :40${i} /samples/* -n inf &
done

echo "Starting ${NUM_SERVERS} Radamsa servers on port $PORT"

exec haproxy -W -db -f /etc/haproxy/haproxy.cfg

