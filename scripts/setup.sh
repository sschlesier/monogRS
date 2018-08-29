#! /bin/bash

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

mongo --host mongo1:27017 <<EOF
    var cfg = {
        "_id": "rs",
        "version": 1,
        "members": [
            {
                "_id": 0,
                "host": "mongo1:27017",
                "priority": 2
            },
            {
                "_id": 1,
                "host": "mongo2:27017",
                "priority": 0
            },
            {
                "_id": 2,
                "host": "mongo3:27017",
                "priority": 0
            }
        ]
    };
    rs.initiate(cfg, {force: true});
    rs.reconfig(cfg, {force: true});
EOF
