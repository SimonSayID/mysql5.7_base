#!/bin/bash

for i in $1 $2; do
	if ! echo $i | grep -E '*[0-9]' > /dev/null; then
		echo "${0#./} :\"$i\" not a number."
		echo "${0#./} Usage: chapter-number section-number 
 			(both need to be positive decimal)."
	fi
done

cd chapter$1

if [[ ! -e "ch$1-$2.sql" ]]; then
	echo "${0#./}: ch$1-$2.sql file doesn't exist."
	exit 1
else
	if [[ -e ch$1-$2.result ]]; then
		mysql -u cbuser -p -t < ch$1-$2.sql > ch$1-$2.result
	else
		mysql -u cbuser -p -t < ch$1-$2.sql
	fi
fi

