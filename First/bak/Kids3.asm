*=$C000

      ;  jsr     $E544
      ;  ldx     #12
      ;  ldy     #19
      ;  clc
      ;  jsr     $FFF0
      ;  lda     #88
      ;  jsr     $E716
      ;  rts

;        jsr     $E544
;        ldx     #$54
;        txa
;        jsr     $E716
;        ldx     #$41
;        txa
;        sta     49200
;        ldy     49200
;        tya
;        jsr     $E716
;        ldy     #$58
;        tya     
;        jsr     $E716
;        rts

        jsr     $E544
        ldx     #90
        ldy     #65
        txa
        jsr     $E716   ; Output to screen
        tya
        jsr     $E716
        dex             ; Subtract 1 from x register
        txa
        jsr     $E716
        iny             ; Add 1 to y register
        tya
        jsr     $E716
        rts



