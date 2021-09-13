#!/bin/sh
errormessage=`cl65 -o prog.prg $1 -t c64 2>&1`

if [ -z "$errormessage" ]
then
    x64 prog.prg 
else
    echo "$errormessage"
    echo "Abort due to compile errors."
fi

rm -f *.o



