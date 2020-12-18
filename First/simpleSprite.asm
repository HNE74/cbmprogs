; 10 SYS (2064)

; *** include sprite definition file
*=$2000
incbin "sprite1.bin"

*=$0801
        BYTE    $0E, $08, $0A, $00, $9E, $20, $28,  $32, $30, $36, $34, $29, $00, $00, $00

        ; *** set border and background color
        lda #0
        sta $d020
        sta $d021

        ; *** enable sprite 
        lda #$01
        sta $d015

        ; *** set sprite data pointer
        lda #$80 ; $2000 / $40 (Dec 64)
        sta $07f8

        ; *** set sprite position
        lda #$60
        sta $d000
        sta $d001

        ; *** set sprite color
        lda #$01
        sta $d027

@spritemovement
        ldx $d000
        ldy $d001
        inx
        iny
        stx $d000
        sty $d001
@rasterwait
        lda #255
        cmp $d012
        bne @rasterwait
        jmp @spritemovement

        rts