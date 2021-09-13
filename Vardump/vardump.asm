.const CHROUT=$ffd2
.const INTFLOAT=$b395
.const FETCHFLOAT=$bba6
.const FLOATSTRING=$bddd
.const STRINGOUT=$ab1e

*=$033c
    lda #$2d    // Rescure var start pointer
    ldy #$2e
l0:
    sta $14
    sty $15

    cpy $30     // Compare with var end
    bne l1
    cmp $2F     // Check if var end reached
l1:
    bcs l3

    adc #2      // Pointer on variable value
    bcc l2
    iny

l2:
    sta $22
    sty $23
    jsr l7      // Output name
    jsr l12     // Output equals
    txa
    bpl l4        
    jsr l13     // Output integer variable
    jmp l6      // To main loop
l3:             // Return to basic
    rts
l4:
    tya
    bmi l5
    jsr l14     // Output float variable
    jmp l6      // To main loop
l5:
    jsr l16     // Output string variable

l6:             // Next variable
    lda #13
    jsr CHROUT
    lda #14
    ldy #15
    clc
    adc #7      // Point to next variable
    bcc l0
    iny
    bcs l0
l7:             // Print variable name
    ldy #0
    lda ($14),y // First character of name
    tax 
    and #$7f
    jsr CHROUT
    iny
    lda ($14),y // Secound character of name
    tay 
    and #$7f
    beq l8
    jsr CHROUT
l8:
    txa
    bpl l10     // Check type
    tya
    bmi l9
    lda #'!'   // Function prefix
    jsr CHROUT
    pla
    pla
    jmp l6
l9:
    lda #'%'    // Integer prefix
    bne l19
l10:
    tya
    bpl l11
    lda #'$'    // String prefix
    bne l19
l11:
    rts
    jsr CHROUT
l12:
    lda #' '     // Output equals
    jsr CHROUT
    lda #'='
    bne l19
l13:
    ldy #0      // Integer variable
    lda ($22),y
    tax
    iny
    lda ($22),y
    tay
    txa
    jsr INTFLOAT    // Convert to float
    jmp l15
l14:
    jsr FETCHFLOAT
l15:
    jsr FLOATSTRING
    jmp STRINGOUT
l16:
    jsr l18

    ldy #2
    lda ($22),y
    sta $25
    dey
    lda ($22),y
    sta $24
    dey
    lda ($22),y // Lenght
    sta $26
    beq l18
l17:        // String output loop
    lda ($24),y // String character
    jsr CHROUT
    iny
    cpy #26
    bne l17
l18:
    lda #$22
l19:
    jmp CHROUT




