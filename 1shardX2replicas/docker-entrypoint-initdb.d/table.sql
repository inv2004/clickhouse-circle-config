CREATE DATABASE IF NOT EXISTS default;
CREATE TABLE IF NOT EXISTS default.tbl1
(
    EventDate DateTime,
    UserID UInt32,
    CounterID UInt32
) ENGINE = ReplicatedReplacingMergeTree('/clickhouse/tables/{shard}/tbl1', '{replica}')
PARTITION BY toYYYYMM(EventDate)
ORDER BY (CounterID, intHash32(UserID));

CREATE TABLE default.tbl1_dist AS default.tbl1 ENGINE = Distributed('lr', '', tbl1, rand());

