#!/bin/bash

# this causes the script to exit if any line causes an error. if there are badly-behaved bits of script that you want to ignore, you can run "set +e" and then "set -e" again afterwards.
set -e

# setting the variable stylefile to be the string on the RHS of =. you can't have spaces around the =, annoyingly.
# strings are either with double-quotes "" or single quotes ''. the difference is that the double quotes will substitute variables, e.g: if stylefile="x" then "foo_${stylefile}" is "foo_x", but 'foo_${stylefile}' is just 'foo_${stylefile}'
stylefile="targeted-editing/scripts/default.style"

# what i'm trying to do here is make it so that we can run the script as if we typed: import_db.sh database input query1 query2 ... queryN
# and the variables in the script get set as: dbname="database" inputfile="input" and $*="query1 query2 ... queryN"
# $1, $2, etc... are the first, second ... arguments to the script
dbname=$1 # array[1]
inputfile=$2 # array[2]
# shift offsets the arguments, so that after running "shift 2", what used to be $3 is now $1, what used to be $4 is now $2, and so forth
shift 2

# these are totally equivalent:
#   dropdb --if-exists $dbname;
#   dropdb --if-exists "$dbname";
#   dropdb --if-exists ${dbname};
#   dropdb --if-exists "${dbname}";
dropdb --if-exists $dbname; 
#	replace "user" below with your user name
createdb -E UTF-8 -O user $dbname; 
psql -c "create extension postgis; create extension hstore; create extension btree_gist" $dbname; 
#	replace "user" below with your user name and adjust the amount of RAM you wish to allocate up or down from 12000(MB)
osm2pgsql -S $stylefile -d $dbname -C 12000 -s -G -x -k -K -U user -H /tmp $inputfile; 

# for (var i = 0; i < array.length; i++) {
#   var query = array[i];
for query in $*; do
	echo "QUERY $query against database $dbname";
	# `` is like a subselect, everything between the `` characters gets executed and replaced by whatever they output
	# basename is a function which returns the file part of the filename, rather than the full path. so we can write "$(basename /very/long/path/with/lots/of/slashes.txt)" and it returns "slashes.txt"
	query_base=`echo "$(basename $query)" | sed 's/\.sql//'`;
	# execute the query and put its results ('>') in the file called "${dbname}_${query_base}.txt", so for a database called "new_york" and a query file called "fitness.sql", the output file would be "new_york_fitness.txt"
	psql -f $query --quiet -t --no-align -F , $dbname | sed "s/^/${dbname},${query_base},/" > ${dbname}_${query_base}.txt; 
done
