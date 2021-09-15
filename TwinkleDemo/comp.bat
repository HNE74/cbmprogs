:: Compile Twinkledemo to prg file and execute it in Vice x64 emulator.
set CC65_HOME=C:\MyProgs\CC65\cc65
set VICE_HOME=C:\MyProgs\WinVICE-3.0-x64
set CC65_INC=%CC65_HOME%\include
set path=%PATH%;%CC65_HOME%\bin;%VICE_HOME%

cl65 -O -t c64 -C comp.cfg -o %1.prg twinkledemo.c chardef/chardef.c sound/sound.c && (
x64 %1.prg
) || (
  echo Compiling failed
)