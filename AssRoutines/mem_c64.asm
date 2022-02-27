;*****************************************************
;*** Memory locations defined C64 (kernal, CIA etc.)
;***
;*** by Noltisoft in 2021/2022
;*** The code is GNU General Public License v3.0 and might be used and/or
;*** modified by any interested parties.*
;*****************************************************

ZERO_PAGE_PTR1 = $FB ; zero page pointer address
ZERO_PAGE_PTR2 = $FD ; zero page pointer address

BASIC_ROM_CHKCOM=$AEFD   ; check for komma
BASIC_ROM_FRMNUM=$AD8A   ; fetch value and check if numeric
BASIC_ROM_FACTOINT=$B7F7 ; convert FAC value to 2 byte integer
BASIC_ROM_QTTYERROR=$B248; print illegal quantity error

KERNEL_ROM_CLOCKINC=$EA31; increment kernel clock

