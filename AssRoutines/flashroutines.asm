;******************************************************
;*** Screen and color flash routines
;***
;*** Inspired by the book "40 best machine code routines for the Commodore 64" 
;*** by Noltisoft in 2021/2022
;*** The code is GNU General Public License v3.0 and might be used and/or
;*** modified by any interested parties.
;*****************************************************

incasm "mem_c64.asm"
incasm "mem_vic2.asm"


*=$C000
        jsr BASIC_ROM_CHKCOM    ; fetch flash memory position
        jsr BASIC_ROM_FRMNUM
        jsr BASIC_ROM_FACTOINT
        lda $14
        sta ZERO_PAGE_PTR1
        lda $15
        sta ZERO_PAGE_PTR1+1

        jsr BASIC_ROM_CHKCOM    ; fetch value 1 param
        jsr BASIC_ROM_FRMNUM
        jsr BASIC_ROM_FACTOINT
        lda $15
        beq MORE
        jmp BASIC_ROM_QTTYERROR
MORE    
        lda $14
        sta TEMP
        
        jsr BASIC_ROM_CHKCOM    ; fetch value 2 param
        jsr BASIC_ROM_FRMNUM
        jsr BASIC_ROM_FACTOINT
        lda $15
        beq MORE1
        jmp BASIC_ROM_QTTYERROR
MORE1
        lda $14
        sta TEMP+1

        jsr BASIC_ROM_CHKCOM    ; fetch rate param
        jsr BASIC_ROM_FRMNUM
        jsr BASIC_ROM_FACTOINT
        lda $15
        beq MORE2
        jmp BASIC_ROM_QTTYERROR
MORE2
        lda $14
        sta TEMP+2

        sei                     ; adjust irq vector
        lda #<MAIN
        sta $0314
        lda #>MAIN
        sta $0315
        cli

        lda TEMP+2              ; leave init routine
        sta TEMP+3
        rts
MAIN    
        ldy #$00
        dec TEMP+3      
        bne FINISH              ; check no flash
        lda (ZERO_PAGE_PTR1),y  ; do flash
        and #$0F
        cmp TEMP+1
        beq DO0
        lda TEMP+1
        sta (ZERO_PAGE_PTR1),y
        lda TEMP+2
        sta TEMP+3
        jmp FINISH
DO0
        lda TEMP
        sta (ZERO_PAGE_PTR1),y
        lda TEMP+2
        sta TEMP+3
FINISH
        jmp KERNEL_ROM_CLOCKINC
RESET                           ; inactivate flash
        sei
        lda #<KERNEL_ROM_CLOCKINC
        sta $0314
        lda #>KERNEL_ROM_CLOCKINC
        sta $0315
        cli
        rts
        

TEMP BYTE $00,$00,$00,$00



