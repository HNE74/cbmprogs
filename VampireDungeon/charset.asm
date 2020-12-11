VICCHARSETADR           = $C000
CHARROMADR              = $D000
VICBANKCONTROL          = $DD00
VICCIACONTROL           = $DD02
VICMEMCONTROL           = $D018
KERNALSCREENRAM         = $288
ZP_HELPADR1             = $FB
ZP_HELPADR2             = $FD
CHARPTR                 = $CF1C
CHARDEFPTR              = $CF1D
CHARBYTE                = $CF1E

*=$CC00; DEC: 52224
@CHREDEF

        ; *** DETERMINE CHARSET START
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

        ; *** SET VIC VIDEOBANK
        lda #%00000011                     ;Datenrichtung für Bit 0 & 1 des Port-A
        sta VICCIACONTROL                  ;zum Schreiben freigeben
        lda #%00000000                     ;Bank-3
        sta VICBANKCONTROL                 ;auswählen

        ; *** SET SCREENRAM PAGE
        lda VICMEMCONTROL                  ;VIC-II Register 24 in den Akku holen
        and #%00001111                     ;Über Bits 7-4 
        ora #%00100000                     ;den Beginn des
        sta VICMEMCONTROL                  ;Bildschirmspeichers festlegen

        ; *** ADJUST KERNAL POINTER TO SCREENRAM
        lda #$C8                           ; $C800 / 256
        sta KERNALSCREENRAM

        ; SET CHARRAM PAGE
        lda VICMEMCONTROL                  ;VIC-II Register 24 in den Akku holen
        and #%11110001                     ;Über Bits 3-1 
        ora #%00000000                     ;den Beginn des
        sta VICMEMCONTROL                  ;Zeichensatzes festlegen $C000
        RTS

        ; *** COPY CHARSET
@CHRCPY LDA #<CHARROMADR ; CHAR ROM SOURCE TO ZP_HELPADR1
        STA ZP_HELPADR1
        LDA #>CHARROMADR
        STA ZP_HELPADR1+1

        LDA #<VICCHARSETADR ; CHAR RAM DEST TO ZP_HELPADR2
        STA ZP_HELPADR2
        LDA #>VICCHARSETADR
        STA ZP_HELPADR2+1

        LDX #$08            ; COPY CHAR ROM TO RAM LOOP
@CHRC1  LDY #$00
@CHRC2  LDA (ZP_HELPADR1),Y
        STA (ZP_HELPADR2),Y
        DEY
        BNE @CHRC2
        INC ZP_HELPADR1+1
        INC ZP_HELPADR2+1
        DEX
        BNE @CHRC1
        RTS

        ; **** REDEFINE CHARACTERS
@DEFCHR LDX #0
        STX CHARPTR
        STX CHARDEFPTR
@DFCH1  LDY CHARPTR     ; FOR EACH ENTRY IN CHRDEF
        LDX CHRDEF,Y   ; CARRY OUT CHARACTER REDEFINITION 
        JSR @RECHR              
        INC CHARPTR
        LDX CHARPTR
        CPX #6
        BNE @DFCH1
        RTS

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
        LDA CHRDATA,Y
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

CHRDEF
        BYTE 65,87,88,91,94,102
CHRDATA
        BYTE    24,60,24,60,255,189,36,102        
        BYTE    255,213,171,255,249,249,255,255
        BYTE    24,24,126,126,24,24,60,126
        BYTE    24,60,24,60,126,126,60,24
        BYTE    60,126,255,253,249,251,118,60
        BYTE    221,221,0,182,182,0,237,237
