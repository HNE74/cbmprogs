; sys 49152,"hello world"
; see youtube video nerdroom: 
; https://www.youtube.com/watch?v=c043uy-_RRU&t=1943s
*=$C000

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
        jsr CONVERT
        sta SCREEN,y
        iny
        jmp OUTPUT
END
        sty $FB
        lda $7A
        clc
        adc $FB
        sta $7A
        lda $7B
        adc #$00
        sta $7B
        rts

CONVERT
        cmp #$FF        ; deduct FF from accumulator
        beq PI          ; check if zero flage set -> pi char
        pha
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        tax
        pla
        eor TAB,x
        rts
PI
        lda #$5E
        rts

TAB     
        BYTE $80,$00,$40,$20,$40,$C0,$80,$80

        

