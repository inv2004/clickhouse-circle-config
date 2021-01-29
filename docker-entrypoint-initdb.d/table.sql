CREATE DATABASE IF NOT EXISTS fst;
CREATE TABLE IF NOT EXISTS fst.tbl1
(
    EventDate DateTime,
    UserID UInt32,
    CounterID UInt32
) ENGINE = ReplicatedReplacingMergeTree('/clickhouse/tables/{firstshard}/tbl1', 'replica_1')
PARTITION BY toYYYYMM(EventDate)
ORDER BY (CounterID, intHash32(UserID));

CREATE TABLE fst.tbl1_dist AS fst.tbl1 ENGINE = Distributed('lr', '', tbl1, rand());

CREATE DATABASE IF NOT EXISTS snd;
CREATE TABLE IF NOT EXISTS snd.tbl1
(
    EventDate DateTime,
    UserID UInt32,
    CounterID UInt32
) ENGINE = ReplicatedReplacingMergeTree('/clickhouse/tables/{secondshard}/tbl1', 'replica_2')
PARTITION BY toYYYYMM(EventDate)
ORDER BY (CounterID, intHash32(UserID));

CREATE TABLE snd.tbl1_dist AS snd.tbl1 ENGINE = Distributed('lr', '', tbl1, rand());
