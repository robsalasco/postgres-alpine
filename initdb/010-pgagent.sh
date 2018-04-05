#!/bin/sh
set -e
IFS=","
if [ -z "$initdb_file" ]
then
   initdb_file="$(/usr/bin/lsof +p $$ | /bin/grep "initdb" | /usr/bin/awk -F "\t" '{print $3}')"
fi
sql_file="$initdb_file.sql"
>"$sql_file"
readonly CREATE_EXTENSION_PGAGENT
if [ "$CREATE_EXTENSION_PGAGENT" == "yes" ]
then
   CREATE_LANGUAGE_PLPGSQL="yes"
   echo "CREATE EXTENSION pgagent;" >> "$sql_file"
fi
readonly CREATE_LANGUAGE_PLPGSQL
if [ "$CREATE_LANGUAGE_PLPGSQL" == "yes" ]
then
   echo "CREATE LANGUAGE plpgsql;" >> "$sql_file"
fi
rm -f "$initdb_file"