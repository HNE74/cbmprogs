; sys 49152,"hello world"
; see youtube videos nerdroom: 
; https://www.youtube.com/watch?v=c043uy-_RRU&t=1943s
; https://www.youtube.com/watch?v=olqjsi6U-mw
*=$C000

CHKCOM = $AEFD          ; puts basic pointer to char after first comma
SCREEN = $0400          ; screenram 

        lda #$00
        ldy #$00

        jsr CHKCOM      
        cmp #$22        ; ignore first quote
        beq INIT
        rts
INIT
        iny
OUTPUT
        lda ($7A),y
        cmp #$22
        beq END
        jsr CONVERT
        sta SCREEN,y
        iny
        jmp OUTPUT
END
        inc $7A
        tya
        clc
        adc $7A
        sta $7A
        bcc NOHIGH
        inc $7B
NOHIGH
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

        

