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
.var BORDER_COLOR = $D020
.var green = $5
.var yellow = $7
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
    lda #<irq1
    sta INTERRUPT_EXECUTION_LOW
    lda #>irq1
    sta INTERRUPT_EXECUTION_HIGH
    cli

start:
    // Init SID music
    lda #music.startSong-1
    jsr music.init

    rts

irq1:
    // Rescue registers
    pha
    txa
    pha
    tya
    pha

    // Play music
    jsr music.play

    // Set border color to green
    lda #green
    sta BORDER_COLOR

    // Trigger interrupt on raster line 150
    lda #150
    sta RASTER_LINE

    // Change interrupt routine vector to second handler
    lda #<irq2
    sta INTERRUPT_EXECUTION_LOW
    lda #>irq2
    sta INTERRUPT_EXECUTION_HIGH
    jmp ack

irq2:
    // Rescue registers
    pha
    txa
    pha
    tya
    pha

    // Enable bitmap mode
    lda #$3b
    sta RASTER_LINE_MSB

    // Set border color to yellow
    lda #yellow
    sta BORDER_COLOR

    // Trigger interrupt on raster line 200
    lda #200
    sta RASTER_LINE

    // Change interrupt routine vector to third handler
    lda #<irq3
    sta INTERRUPT_EXECUTION_LOW
    lda #>irq3
    sta INTERRUPT_EXECUTION_HIGH
    jmp ack

irq3:
    // Rescue registers
    pha
    txa
    pha
    tya
    pha

    // Disable bitmap mode
    lda #$1b
    sta RASTER_LINE_MSB

    // Trigger interrupt on raster line zero
    lda #0
    sta RASTER_LINE

    // Change interrupt routine vector to first handler
    lda #<irq1
    sta INTERRUPT_EXECUTION_LOW
    lda #>irq1
    sta INTERRUPT_EXECUTION_HIGH
    jmp ack

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