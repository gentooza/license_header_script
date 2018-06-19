#!/bin/bash
 #
 # license header script v2
 #
 # Copyright (C) 2017-2018 Joaquín Cuéllar <joa.cuellar (at) riseup.net>
 #
 # license header script is free software: you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.
 #
 # license header script is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
 # along with the program.  If not, see <http://www.gnu.org/licenses/>.
 #
 #

#number of lines to remove from previous licensed code
lines_to_remove=22
appName="our Program"
appOwner="our collective"
sourceCode="https://ourRepository.git"
actualYear=$(date +'%Y')

echo "C and C++ code..."

echo "/*" > head
echo $appName >> head
echo "" >> head
echo "Copyright("$actualYear"): " $appOwner >> head
echo "" >> head
echo "Source code:" >> head
echo $sourceCode >> head
echo "" >> head

echo "*/" > closeHead
echo "" >> closeHead

# cleaning
for i in *.h *.cpp *.c *hpp *cxx # or whatever other pattern...
do
    [ -f "$i" ] || continue  #guard against working with *.XXX files
    if grep -q Copyright $i
    then
	echo "   removing old license header to $i"
	count=`head -$lines_to_remove "$i" |wc -c`
	dd if="$i" bs="$count" skip=1 of="$i" conv=notrunc
	truncate -s "-$count" "$i"
    fi
done

# writting
for i in *.h *.cpp *.c # *.py # or whatever other pattern...
do
    [ -f "$i" ] || continue    
    if ! grep -q Copyright $i
    then
	echo "   adding license header to $i"
	cat   head License_header closeHead $i >$i.new && mv $i.new $i
    fi
done

echo "Python code..."

echo "'''" > head
echo $appName >> head
echo "" >> head
echo "Copyright("$actualYear"): " $appOwner >> head
echo "" >> head
echo "Source code:" >> head
echo $sourceCode >> head
echo "" >> head

echo "'''" > closeHead
echo "" >> closeHead

# cleaning
for i in *.py # or whatever other pattern...
do
    [ -f "$i" ] || continue  
    if grep -q Copyright $i
    then
	echo "   removing old license header to $i"
	count=`head -$lines_to_remove "$i" |wc -c`
	dd if="$i" bs="$count" skip=1 of="$i" conv=notrunc
	truncate -s "-$count" "$i"
    fi
done
# writting
for i in *.py # or whatever other pattern...
do
    [ -f "$i" ] || continue
    if ! grep -q Copyright $i
    then
	echo "   adding license header to $i"
	cat   head License_header closeHead $i >$i.new && mv $i.new $i
    fi
done
#removing auxiliar files
rm head closeHead

