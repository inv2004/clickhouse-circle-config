#!/bin/bash

H=$(clickhouse-client -q "select substitution from system.macros where macro='host'")
echo $H

case $H in
  ch1)
    clickhouse-client -n <<EEE
      CREATE DATABASE db1;
      CREATE DATABASE db3;
EEE
    ;;
  ch2)
    clickhouse-client -n <<EEE
      CREATE DATABASE db2;
      CREATE DATABASE db1;
EEE
    ;;
  ch3)
    clickhouse-client -n <<EEE
      CREATE DATABASE db3;
      CREATE DATABASE db2;
EEE
    ;;
esac
