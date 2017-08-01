*=$C000

; VARIABELES USED FOR CHARACTER REDEFINITION
VICSCREENBLOCKNO        = 1
VICCHARSETBLOCKNO       = 7
VICBITMAPBLOCKNO        = 0
VICBANKNO               = 13
VICCHARSETADR           = $3000
CHARROMADR              = $D000
VICMEMCONTROL           = $D018
ZP_HELPADR1             = $FB
ZP_HELPADR2             = $FD
CHARPTR                 = $CF22
CHARDEFPTR              = $CF23
CHARBYTE                = $CF24

;****************************************************
;***  COPY THE CHARACTER ROM TO RAM
;****************************************************
@CHREDEF
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

        JSR @DEFCHR     ; CHARACTER REDEFINITION

        LDA VICMEMCONTROL  ; SWITCH BANK FOR NEW CHARSET
        AND #240
        ORA #13
        STA VICMEMCONTROL
        RTS

;****************************************************
;***  CALL SUBROUTINES FOR CHARACTER DEFINITION
;****************************************************
@DEFCHR LDX #0
        STX CHARPTR
        STX CHARDEFPTR
@DFCH1  LDY CHARPTR             ; FOR EACH ENTRY IN CHRDEF
        LDX CHRDEF:,Y           ; CARRY OUT CHARACTER REDEFINITION 
        JSR @RECHR              
        INC CHARPTR
        LDX CHARPTR
        CPX #4
        BNE @DFCH1
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
;***  DEFINE CHARACTER SHIP LEFT
;****************************************************
@RECHR  TXA                    ; SCREENCODE * 8
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

        LDX #$00                ; COPY DEFINITION STARTING AT
@RECHR1 LDY CHARDEFPTR          ; CHRDATA PLUS CHARDEFPTR
        LDA CHRDATA:,Y
        STA CHARBYTE
        TXA
        TAY
        LDA CHARBYTE
        STA (ZP_HELPADR2),Y
        INX
        INC CHARDEFPTR
        CPX #8
        BNE @RECHR1
        RTS


CHRDEF:
        BYTE    1,2,3,4

CHRDATA:        
        BYTE    126,255,219,255,165,189,24,24
        BYTE    0,0,0,0,120,252,174,255
        BYTE    0,0,0,0,30,63,117,255
        BYTE    24,24,60,60,126,231,255,231
