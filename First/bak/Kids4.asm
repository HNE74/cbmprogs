*=$C000

;        ldx     #0
;        txa
;        sta     $400,X
;        inx
;        txa
;        sta     $400,X
;        rts

        JSR     $E544
        LDA     #4
        STA     $D021   ; BACKGROUND COLOR
        
        LDA     #1
        LDX     #0
        STA     $D800,X ; BASE COLOR ADDRESS + X
        STA     $400,X ; BASE SCREEN ADDRESS + X
        
        INX
        STA     $D800,X ; BASE COLOR ADDRESS + X
        STA     $400,X ; BASE SCREEN ADDRESS + X
        
        INX
        STA     $D800,X ; BASE COLOR ADDRESS + X
        STA     $400,X ; BASE SCREEN ADDRESS + X
        RTS
