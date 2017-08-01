*=$C000

SIGVOL          = $D418
ATDCY1          = $D405
SUREL1          = $D406
VCREG1          = $D404
FRELO1          = $D400
FREHI1          = $D401

        LDA #15
        STA SIGVOL      ; VOLUME
        LDA #30      
        STA ATDCY1      ; ATTACK - DECAY
        LDA #30
        STA SUREL1      ; SUSTAIN - RELEASE
        LDA #195
        STA FRELO1      ; FREQUENCY LOW
        LDA #255
        STA FREHI1      ; FREQUENCY HIGH
        LDA #129
        STA VCREG1      ; WAVEFORM
        
        LDY #0
@PLAY   INY
        JSR @WAIT
        CPY #255
        BNE @PLAY

        LDA #0
        STA SIGVOL      ; VOLUME
        LDA #0      
        STA ATDCY1      ; ATTACK - DECAY
        LDA #0
        STA SUREL1      ; SUSTAIN - RELEASE
        LDA #0
        STA FRELO1      ; FREQUENCY LOW
        LDA #0
        STA FREHI1      ; FREQUENCY HIGH
        LDA #0
        STA VCREG1      ; WAVEFORM

        RTS

        ; WAIT ROUTINE
@WAIT   LDX     #0
@W1     NOP
        NOP
        NOP
        NOP
        INX
        CPX     #200
        BNE     @W1
@W2     NOP
        NOP
        NOP
        NOP
        INX
        CPX     #200
        BNE     @W2
        RTS