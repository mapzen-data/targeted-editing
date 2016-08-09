#!/bin/bash

set -e

dir="$(dirname $0)"

data_dir=$1
shift

for pbf in $data_dir/*.osm.pbf; do
	dbname=`echo "$(basename $pbf)" | sed 's,\.osm\.pbf,,'`
	$dir/import_db.sh $dbname $pbf $*
done

cat *.txt > query_output.csv
