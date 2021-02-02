#!/bin/bash

H=$(clickhouse-client -q "select substitution from system.macros where macro='host'")
echo $H

sleep 5  # waiting for zookeeper up

