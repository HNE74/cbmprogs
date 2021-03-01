/**
See: Jim Jim Codes Assembly #3 
https://www.youtube.com/watch?v=VvOyyhdi2Ps&t=421s 
 **/
.var SCREEN_MEM = $0400
.var CHR_IN = $FFE4
.var CHR_OUT = $FFD2
.var CLS = $E544

.var INTERRUPT_REG = $DC0D
.var RASTER_SPRITE_INT_REG = $D01A
.var RASTER_LINE_MSB = $D011
.var SCREEN_MULTICOLOR = $D016
.var RASTER_LINE = $D012
.var INTERRUPT_EXECUTION_LOW = $0314
.var INTERRUPT_EXECUTION_HIGH = $0315
.var INTERRUPT_STATUS = $D019
.var SYS_IRQ_HANDLER = $EA31
.var music = LoadSid("Cheese.sid")
BasicUpstart2(irqinit)
*=$3000
irqinit:
    // Disable CIA interrupt
    sei
    lda #%01111111
    sta INTERRUPT_REG

    // Enable raster interrupt
    lda RASTER_SPRITE_INT_REG
    ora #%00000001
    sta RASTER_SPRITE_INT_REG

    // Trigger interrupt on raster line zero
    lda RASTER_LINE_MSB
    and #%01111111
    sta RASTER_LINE_MSB
    lda #0
    sta RASTER_LINE

    // Change interrupt routine vector
    lda #<irq
    sta INTERRUPT_EXECUTION_LOW
    lda #>irq
    sta INTERRUPT_EXECUTION_HIGH
    cli

start:
    // Init SID music
    lda #music.startSong-1
    jsr music.init

    rts

irq:
    // Rescue registers
    pha
    txa
    pha
    tya
    pha

    // Play music
    jsr music.play

ack:
    // Acknowledge raster interrupt
    dec INTERRUPT_STATUS

    // Restore registers
    pla
    tay
    pla
    tax
    pla

    // Call system interrupt handler
    jmp SYS_IRQ_HANDLER

*=music.location "Music"
.fill music.size, music.getData(i)