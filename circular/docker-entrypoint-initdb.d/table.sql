CREATE DATABASE IF NOT EXISTS default;
CREATE TABLE IF NOT EXISTS default.tbl1
(
    EventDate DateTime,
    UserID UInt32,
    CounterID UInt32
) ENGINE = ReplicatedReplacingMergeTree('/clickhouse/tables/{mainshard}/tbl1', '{mainreplica}')
PARTITION BY toYYYYMM(EventDate)
ORDER BY (CounterID, intHash32(UserID));

CREATE TABLE default.tbl1_dist AS default.tbl1 ENGINE = Distributed('lr', '', tbl1, rand());

CREATE DATABASE IF NOT EXISTS replica;
CREATE TABLE IF NOT EXISTS replica.tbl1
(
    EventDate DateTime,
    UserID UInt32,
    CounterID UInt32
) ENGINE = ReplicatedReplacingMergeTree('/clickhouse/tables/{replicashard}/tbl1', '{secondaryreplica}')
PARTITION BY toYYYYMM(EventDate)
ORDER BY (CounterID, intHash32(UserID));

CREATE TABLE replica.tbl1_dist AS replica.tbl1 ENGINE = Distributed('lr', '', tbl1, rand());
