#!/bin/sh

# show conflicts
# report how many files updated/patched/merged/conflicted
# hell, show all the cvs activity, just dump final stats and 
# conflicted files afterwards

UPDATES=""	
PATCHED=""
MERGED=""
CONFLICTED=""	
CONFLICTED_FILES=""

while read operation file; do
	case $operation in
		"U")
			UPDATES=$((UPDATES + 1))
			;;
		"P")
			PATCHED=$((PATCHED + 1))
			;;
		"M")
			MERGED=$((MERGED + 1 ))
			;;
		"C")
			CONFLICTED=$((CONFLICTED + 1))
			CONFLICTED_FILES="${CONFLICTED_FILES} $file"
			;;
	esac
	echo $operation $file
done

echo "$UPDATES files added, $PATCHED files patched, $MERGED files merged" 
if [ ! -z "$CONFLICTED_FILES" ]; then 
	echo "$CONFLICTED conflicts found:"
	for f in $CONFLICTED_FILES; do
		echo -e "$f\n"
	done
fi
