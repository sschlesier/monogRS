#! /bin/bash

MONGODB1=`ping -c 1 mongo1 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGODB2=`ping -c 1 mongo2 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`
MONGODB3=`ping -c 1 mongo3 | head -1  | cut -d "(" -f 2 | cut -d ")" -f 1`

echo "1" ${MONGODB1}
echo "2" ${MONGODB2}
echo "3" ${MONGODB3}

echo "Pausing for a bit"
sleep 5
echo "Here we go......"
# echo "Waiting for startup..."
# until curl http://mongo1:28017/serverStatus\?text\=1 2>&1 | grep uptime | head -1; do
#     printf '.'
#     sleep 5
# done

# echo curl http://mongo1:28017/serverStatus\?text\=1 2>&1 | grep uptime | head -1;
# echo "Started.."

mongo --host ${MONGODB1}:27017 <<EOF
    var cfg = {
        "_id": "rs",
        "version": 1,
        "members": [
            {
                "_id": 0,
                "host": "${MONGODB1}:27017",
                "priority": 2
            },
            {
                "_id": 1,
                "host": "${MONGODB2}:27017",
                "priority": 0
            },
            {
                "_id": 2,
                "host": "${MONGODB3}:27017",
                "priority": 0
            }
        ]
    };
    rs.initiate(cfg, {force: true});
    rs.reconfig(cfg, {force: true});
EOF
