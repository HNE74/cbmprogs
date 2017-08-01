*=$C000

;*** VIC-II CONSTANTS
VICBANKNO               = 0
VICSCREENBLOCKNO        = 1
VICCHARSETBLOCKNO       = 7
VICBITMAPBLOCKNO        = 0
VICBASEADR              = VICBANKNO * 16384
VICCHARSETADR           = VICCHARSETBLOCKNO * 2048
VICCHARSETADR           = VICCHARSETADR + VICBASEADR

CHARROMADR              = $D000

ZP_HELPADR1             = $FB
ZP_HELPADR2             = $FD

@MAIN   
        ; DETERMINE CHARSET START
DUMMY = VICSCREENBLOCKNO * 16
DUMMY2 = VICCHARSETBLOCKNO * 2
        LDA #DUMMY+#DUMMY2
        STA $D018       ; SET ADRESS FOR SCREENRAM AND CHARSET

        SEI             ; BLOCK INTERRUPTS
        LDA $01         ; ROM-KONFIG
        PHA             ; RESCUE ROM-KONFIG
        AND #%11111011  ; FADE OUT IO-AREA
        STA $01
        JSR @CHRCPY     ; COPY CHARSET
        PLA             ; RESTORE ROM SETTINGS
        STA $01
        CLI             ; UNBLOCK INTERRUPTS

        LDX #42         ; CHARACTER TO REPLACE
        JSR @DEFCHR
        RTS

;****************************************************
;***  COPY THE CHARACTER ROM TO RAM
;****************************************************
@CHRCPY LDA #<CHARROMADR ; CHAR ROM SOURCE TO ZP_HELPADR1
        STA ZP_HELPADR1
        LDA #>CHARROMADR
        STA ZP_HELPADR1+1

        LDA #<VICCHARSETADR ; CHAR RAM DEST TO ZP_HELPADR2
        STA ZP_HELPADR2
        LDA #>VICCHARSETADR
        STA ZP_HELPADR2+1

        LDX #$08            ; COPY LOOP
@CHRC1  LDY #$00
@CHRC2  LDA (ZP_HELPADR1),Y
        STA (ZP_HELPADR2),Y
        DEY
        CPY #0
        BNE @CHRC2
        INC ZP_HELPADR1+1
        INC ZP_HELPADR2+1
        DEX
        CPX #0
        BNE @CHRC1
        RTS

;****************************************************
;***  DEFINE CHARACTER
;****************************************************
@DEFCHR TXA                    ; SCREENCODE * 8
        AND #%00011111
        ASL
        ASL
        ASL
        CLC
        ADC #<VICCHARSETADR     ; LZP DESTCHAR TO ZP
        STA ZP_HELPADR2

        TXA                     ; SCREENCODE TO AKKU
        LSR                     ; TOP 3 BYTES TO CALC PAGE
        LSR
        LSR
        LSR
        LSR
        CLC
        ADC #>VICCHARSETADR     ; MSB DESTCHAR TO ZP
        STA ZP_HELPADR2+1

        LDY #$07                ; COPY DEFINITION
@DFCHR1 LDA TESTCHAR:,Y
        STA (ZP_HELPADR2),Y
        DEY
        BPL @DFCHR1
        RTS

TESTCHAR:
        BYTE %00000000
        BYTE %00111100
        BYTE %01011110
        BYTE %10111111
        BYTE %10111111
        BYTE %10011111
        BYTE %01000110
        BYTE %00111100


