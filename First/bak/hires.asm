*=$C000

SCRSET = $D011  ; SCREEN SETUP REGISTER 
MEMSET = $D018  ; MEMORY SETUP REGISTER
SCRRAM1 = $0400  ; SCREENRAM FOR COLORS
SCRRAM2 = $04FF  
SCRRAM3 = $05FE  
SCRRAM4 = $06FD 
HIRES1 = $2000  ; HIRES MEMORY
HIRES2 = $2100
HIRES3 = $2200
HIRES4 = $2300
HIRES5 = $2400
HIRES6 = $2500
HIRES7 = $2600
HIRES8 = $2700
HIRES9 = $2800
HIRES10= $2900
HIRES11= $2A00
HIRES12= $2B00
HIRES13= $2C00

;10 POKE 53272,PEEK(53272)OR8:POKE 53265,PEEK(53265)OR32
;15 FOR I=1024TO2034:POKE I,29:NEXT
;20 FOR I=8192 TO 16191 STEP 8
;30 POKE I,240:POKE I+1,240:POKE I+2,240:POKE I+3,240
;40 POKE I+4,15:POKE I+5,15:POKE I+6,15:POKE I+7,15
;50 NEXT
;60 REM FOR I=1024TO2034:POKE I,251:NEXT

        LDA MEMSET      ; HIRES MEMORY AT $2000
        ORA #08
        STA MEMSET

        LDA SCRSET      ; ACTIVATE HIRES GRAPHICS
        ORA #32
        STA SCRSET

        LDX #0          ; SET COLOR ON SCREEN RAM
        LDA #251
@L1     STA SCRRAM1,X
        INX
        CPX #0
        BNE @L1

        LDX #0
        LDA #251
@L2     STA SCRRAM2,X
        INX
        CPX #0
        BNE @L2

        LDX #0
        LDA #251
@L3     STA SCRRAM3,X
        INX
        CPX #0
        BNE @L3

        LDX #0
        LDA #251
@L4     STA SCRRAM4,X
        INX
        CPX #235
        BNE @L4

        LDX #0                   
@H1     LDA #240
        STA HIRES1,X
        STA HIRES1,X+1
        STA HIRES1,X+2
        STA HIRES1,X+3
        LDA #15
        STA HIRES1,X+4
        STA HIRES1,X+5
        STA HIRES1,X+6
        STA HIRES1,X+7
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        CPX #0
        BNE @H1

        LDX #0                   
@H2     LDA #240
        STA HIRES2,X
        STA HIRES2,X+1
        STA HIRES2,X+2
        STA HIRES2,X+3
        LDA #15
        STA HIRES2,X+4
        STA HIRES2,X+5
        STA HIRES2,X+6
        STA HIRES2,X+7
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        CPX #0
        BNE @H2

        LDX #0                   
@H3     LDA #240
        STA HIRES3,X
        STA HIRES3,X+1
        STA HIRES3,X+2
        STA HIRES3,X+3
        LDA #15
        STA HIRES3,X+4
        STA HIRES3,X+5
        STA HIRES3,X+6
        STA HIRES3,X+7
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        CPX #0
        BNE @H3

        LDX #0                   
@H4     LDA #240
        STA HIRES4,X
        STA HIRES4,X+1
        STA HIRES4,X+2
        STA HIRES4,X+3
        LDA #15
        STA HIRES4,X+4
        STA HIRES4,X+5
        STA HIRES4,X+6
        STA HIRES4,X+7
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        CPX #0
        BNE @H4

        LDX #0                   
@H5     LDA #240
        STA HIRES5,X
        STA HIRES5,X+1
        STA HIRES5,X+2
        STA HIRES5,X+3
        LDA #15
        STA HIRES5,X+4
        STA HIRES5,X+5
        STA HIRES5,X+6
        STA HIRES5,X+7
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        CPX #0
        BNE @H5

        LDX #0                   
@H6     LDA #240
        STA HIRES6,X
        STA HIRES6,X+1
        STA HIRES6,X+2
        STA HIRES6,X+3
        LDA #15
        STA HIRES6,X+4
        STA HIRES6,X+5
        STA HIRES6,X+6
        STA HIRES6,X+7
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        CPX #0
        BNE @H6

        LDX #0                   
@H7     LDA #240
        STA HIRES7,X
        STA HIRES7,X+1
        STA HIRES7,X+2
        STA HIRES7,X+3
        LDA #15
        STA HIRES7,X+4
        STA HIRES7,X+5
        STA HIRES7,X+6
        STA HIRES7,X+7
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        CPX #0
        BNE @H7

        LDX #0                   
@H8     LDA #240
        STA HIRES8,X
        STA HIRES8,X+1
        STA HIRES8,X+2
        STA HIRES8,X+3
        LDA #15
        STA HIRES8,X+4
        STA HIRES8,X+5
        STA HIRES8,X+6
        STA HIRES8,X+7
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        CPX #0
        BNE @H8

        LDX #0                   
@H9     LDA #240
        STA HIRES9,X
        STA HIRES9,X+1
        STA HIRES9,X+2
        STA HIRES9,X+3
        LDA #15
        STA HIRES9,X+4
        STA HIRES9,X+5
        STA HIRES9,X+6
        STA HIRES9,X+7
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        CPX #0
        BNE @H9

        LDX #0                   
@H10    LDA #240
        STA HIRES10,X
        STA HIRES10,X+1
        STA HIRES10,X+2
        STA HIRES10,X+3
        LDA #15
        STA HIRES10,X+4
        STA HIRES10,X+5
        STA HIRES10,X+6
        STA HIRES10,X+7
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        CPX #0
        BNE @H10

        LDX #0                   
@H11    LDA #240
        STA HIRES11,X
        STA HIRES11,X+1
        STA HIRES11,X+2
        STA HIRES11,X+3
        LDA #15
        STA HIRES11,X+4
        STA HIRES11,X+5
        STA HIRES11,X+6
        STA HIRES11,X+7
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        INX
        CPX #0
        BNE @H11

  
        RTS

