*=$C000

;*** VIC-II CONSTANTS
VICBANKNO               = 13
VICCHARSETADR           = $3000
CHARROMADR              = $D000
VICMEMCONTROL           = $D018
ZP_HELPADR1             = $FB
ZP_HELPADR2             = $FD

CHARDEF                 = $CF00

@MAIN   
        LDA $DD00
        ORA #%00000001
        STA $DD00

        ; DETERMINE CHARSET START
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

        lda #$05        ; ENABLE MULTICOLOR
        sta $D022
        lda #$02
        sta $D023
        lda $D016
        ora #%00010000
        sta $D016

        LDA VICMEMCONTROL  ; SWITCH BANK FOR NEW CHARSET
        AND #240
        ORA #13
        STA VICMEMCONTROL

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
        LDA CHARDEF
        CMP #1
        BEQ @DFCHR1
        CMP #2
        BEQ @DFCHR2
        JMP @DFCHR3

@DFCHR1 LDA CHARDEF1:,Y
        STA (ZP_HELPADR2),Y
        DEY
        BPL @DFCHR1
        RTS

@DFCHR2 LDA CHARDEF2:,Y
        STA (ZP_HELPADR2),Y
        DEY
        BPL @DFCHR2
        RTS

@DFCHR3 LDA CHARDEF3:,Y
        STA (ZP_HELPADR2),Y
        DEY
        BPL @DFCHR3
        RTS

CHARDEF1:
        BYTE    0,40,130,20,20,130,40,0

CHARDEF2:
        BYTE    0,195,195,40,40,195,195,0

CHARDEF3:
        BYTE    130,130,20,125,125,20,130,130



