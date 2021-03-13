.var SCREEN_MEM = $0400
.var CHR_IN = $ffe4
.var CHR_OUT = $ffd2
.var CLS = $e544

.var INTERRUPT_REG = $dc0d
.var RASTER_SPRITE_INT_REG = $d01a
.var RASTER_LINE_MSB = $d011
.var SCREEN_MULTICOLOR = $d016
.var RASTER_LINE = $d012
.var INTERRUPT_EXECUTION_LOW = $0314
.var INTERRUPT_EXECUTION_HIGH = $0315
.var INTERRUPT_STATUS = $d016
.var SYS_IRQ_HANDLER = $ea31
BasicUpstart2(irqinit)
*=$3000
irqinit:
    sei
    lda #$7f     // disable bit 7 -> cia interrupts disabled
    sta INTERRUPT_REG



rts


