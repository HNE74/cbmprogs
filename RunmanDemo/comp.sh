#!/bin/sh

rm -f prog.prg
errormessage=`cl65 -O -t c64 -C comp.cfg -o prog.prg runman.c chardef/chardef.c 2>&1`

if test -f "prog.prg"; then
    x64 prog.prg 
else
    echo "$errormessage"
    echo "Abort due to compile errors."
fi

rm -f ./chardef/*.o
rm -f ./sound/*.o
rm -f *.o
rm -f *.prg
rm -f vardump*



