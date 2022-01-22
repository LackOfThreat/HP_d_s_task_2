#!/bin/bash

set -e

sleep 10
docker exec config1number1 /bin/bash -c "
mongosh <<EOF
var config = {
  _id: \"configrs\",
  configsvr: true,
  members: [
    {_id: 0, host: \"config1number1:27017\"},
    {_id: 1, host: \"config1number2:27017\"},
    {_id: 2, host: \"config1number3:27017\"}
  ]
}
rs.initiate(config, {force: true});
rs.status();
EOF
"

sleep 10
docker exec shard1number1 /bin/bash -c "
mongosh <<EOF
var shard1rs = {
  _id: \"shard1rs\",
  members: [
    {_id: 0, host: \"shard1number1:27017\"},
    {_id: 1, host: \"shard1number2:27017\"},
    {_id: 2, host: \"shard1number3:27017\"}
  ]
}
rs.initiate(shard1rs, {force: true});
rs.status();
EOF
"

sleep 10
docker exec shard2number1 /bin/bash -c "
mongosh <<EOF
var shard2rs = {
  _id: \"shard2rs\",
  members: [
    {_id: 0, host: \"shard2number1:27017\"},
    {_id: 1, host: \"shard2number2:27017\"},
    {_id: 2, host: \"shard2number3:27017\"}
  ]
}
rs.initiate(shard2rs, {force: true});
rs.status();
EOF
"

sleep 10
docker exec shard3number1 /bin/bash -c "
mongosh <<EOF
var shard3rs = {
  _id: \"shard3rs\",
  members: [
    {_id: 0, host: \"shard3number1:27017\"},
    {_id: 1, host: \"shard3number2:27017\"},
    {_id: 2, host: \"shard3number3:27017\"}
  ]
}
rs.initiate(shard3rs, {force: true});
rs.status();
EOF
"

sleep 10
docker exec shard4number1 /bin/bash -c "
mongosh <<EOF
var shard4rs = {
  _id: \"shard4rs\",
  members: [
    {_id: 0, host: \"shard4number1:27017\"},
    {_id: 1, host: \"shard4number2:27017\"},
    {_id: 2, host: \"shard4number3:27017\"}
  ]
}
rs.initiate(shard4rs, {force: true});
rs.status();
EOF
"

sleep 10
docker exec mongos /bin/bash -c "
mongosh <<EOF
sh.addShard(\"shard1rs/shard1number1:27017,shard1number2:27017,shard1number3:27017\");
sh.addShard(\"shard2rs/shard2number1:27017,shard2number2:27017,shard2number3:27017\");
sh.addShard(\"shard3rs/shard3number1:27017,shard3number2:27017,shard3number3:27017\");
sh.addShard(\"shard4rs/shard4number1:27017,shard4number2:27017,shard4number3:27017\");
sh.status();
EOF
"

sleep 10
docker exec mongos /bin/bash -c "
mongosh <<EOF
use admin;
db.createUser(
  {
    user: \"admin\",
    pwd: \"secret\",
    roles: [ { role: \"userAdminAnyDatabase\", db: \"admin\" },
     { role: \"readWriteAnyDatabase\", db: \"admin\" },
     { role: \"dbAdminAnyDatabase\", db: \"admin\" },
     { role: \"clusterAdmin\", db:\"admin\" }  ]
  }
);
EOF
"

exec "$@"
