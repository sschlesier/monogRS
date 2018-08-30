#! /bin/bash

echo "Pausing for a bit"
sleep 5
echo "Setting up mongo replicaSet now....."

mongo --host mongo1:27020 <<EOF
    var cfg = {
        "_id": "rs",
        "version": 1,
        "members": [
            {
                "_id": 0,
                "host": "mongo1:27020",
                "priority": 2
            },
            {
                "_id": 1,
                "host": "mongo2:27021",
                "priority": 0
            },
            {
                "_id": 2,
                "host": "mongo3:27022",
                "priority": 0
            }
        ]
    };
    rs.initiate(cfg, {force: true});
    rs.reconfig(cfg, {force: true});
EOF
