set CC65_HOME=C:\MyProgs\CC65\cc65
set VICE_HOME=C:\MyProgs\WinVICE-3.0-x64
set CC65_INC=%CC65_HOME%\include
set path=%PATH%;%CC65_HOME%\bin;%VICE_HOME%

::cc65 -t c64 colors.c
::ld65 -t c64 -o colors colors.o c64.lib --start-addr $C000
::x64 colors.c.prg

::cl65 -o colors.c.prg -t c64 -C C:\\MyProgs\\CC65\cc65\\cfg\\c64-asm.cfg colors.s
::cl65 -C c64-asm.cfg -t c64 --start-addr $C000 colors.s

cl65 -O -t c64 -o %1.prg %1 && (
x64 %1.prg
) || (
  echo Compiling failed
)