; sys 12288,"hello world"
*=$3000

CHKCOM = $AEFD
SCREEN = $0400

        lda #$00
        ldy #$00

        jsr CHKCOM
        jsr OUTPUT
        rts

OUTPUT
        lda ($7A),y
        beq END
        sta screen,y
        iny
        jmp OUTPUT
END
        sty $FB
        lda $7A
        clc
        adc $FB
        sta $7A
        lda $7B
        adc $00
        sta $7B
        
        rts

        

