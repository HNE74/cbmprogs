
*=$C000

SID_SURELI = $D406      ; hold, decay
SID_SIGVOL = $D418      ; volume

;*** channel 1
SID_CHANNEL1_FRELO = $D400      ; frequency lo byte
SID_CHANNEL1_FREHI = $D401      ; frequency high byte
SID_CHANNEL1_PWLO = $D402       ; pulse width lo byte
SID_CHANNEL1_PWLH  = $D403      ; pulse width high byte
SID_CHANNEL1_VCREG = $D404      ; waveform
SID_CHANNEL1_ATDCY = $D405      ; attack decay
VIC_SCREEN_RASTER = $D012

;*** noten 3rd octave
NOTE_C_H = #8 
NOTE_C_L = #180
NOTE_CQ_H = #9
NOTE_CQ_L = #56
NOTE_D_H = #9 
NOTE_D_L = #196
NOTE_DQ_H = #10
NOTE_DQ_L = #89
NOTE_E_H = #10
NOTE_E_L = #247
NOTE_F_H = #11
NOTE_F_L = #158
NOTE_FQ_H = #12
NOTE_FQ_L = #78
NOTE_G_H = #13
NOTE_G_L = #10
NOTE_GQ_H = #13
NOTE_GQ_L = #208
NOTE_A_H = #14
NOTE_A_L = #162
NOTE_AQ_H = #15
NOTE_AQ_L = #129
NOTE_H_H = 16
NOTE_H_L = 109

;*** waveforms
WAVE_DREIECK   = $11
WAVE_SAEGEZAHN = $21
WAVE_RECHTECK  = $41
WAVE_RAUSCHEN  = $81

start
        lda #00
        sta songCnt
        jsr PlaySong
        jmp start
        rts

PlaySong
        ldx songCnt
        lda songLow,x
        sta noteLow
        lda songHigh,x
        sta noteHigh
        jsr PlayNote
        ldx songCnt
        lda songWait1,x
        sta noteWait1
        lda #40
        sta noteWait2
        jsr WaitNote
        ldx songCnt
        inx
        stx songCnt
        ldx songCnt
        cpx songLength
        bne PlaySong
        rts

PlayNote
        lda #25
        sta SID_SIGVOL
        lda noteLow
        sta SID_CHANNEL1_FRELO
        lda noteHigh
        sta SID_CHANNEL1_FREHI
        lda #5
        sta SID_CHANNEL1_ATDCY
        lda #10
        sta SID_SURELI
        lda #0
        sta SID_CHANNEL1_VCREG
        lda #WAVE_SAEGEZAHN
        sta SID_CHANNEL1_VCREG
        rts

WaitNote 
        ldy #0
@wait0
        ldx #0
@wait1  nop
        nop
        nop
        nop
        inx
        cpx noteWait1
        bne @wait1
        iny
        cpy noteWait2
        bne @wait0
        rts

noteLow byte $00
noteHigh byte $00
noteWait1 byte $00
noteWait2 byte $00

songLength byte 32
songCnt byte $00
songLow byte NOTE_C_L, NOTE_E_L, NOTE_G_L, NOTE_C_L, NOTE_E_L, NOTE_G_L, NOTE_C_L, NOTE_E_L
        byte NOTE_C_L, NOTE_E_L, NOTE_G_L, NOTE_C_L, NOTE_E_L, NOTE_G_L, NOTE_C_L, NOTE_E_L
        byte NOTE_C_L, NOTE_D_L, NOTE_A_L, NOTE_D_L, NOTE_F_L, NOTE_A_L, NOTE_D_L, NOTE_F_L
        byte NOTE_C_L, NOTE_D_L, NOTE_A_L, NOTE_D_L, NOTE_F_L, NOTE_A_L, NOTE_D_L, NOTE_F_L
songHigh byte NOTE_C_H, NOTE_E_H, NOTE_G_H, NOTE_C_H, NOTE_E_H, NOTE_G_H, NOTE_C_H, NOTE_E_H
         byte NOTE_C_H, NOTE_E_H, NOTE_G_H, NOTE_C_H, NOTE_E_H, NOTE_G_H, NOTE_C_H, NOTE_E_H
         byte NOTE_C_H, NOTE_D_H, NOTE_A_H, NOTE_D_H, NOTE_F_H, NOTE_A_H, NOTE_D_H, NOTE_F_H
         byte NOTE_C_H, NOTE_D_H, NOTE_A_H, NOTE_D_H, NOTE_F_H, NOTE_A_H, NOTE_D_H, NOTE_F_H
songWait1 byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
          byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
          byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
          byte $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF
songWait2 byte $64, $64, $64, $64, $64, $64, $64, $64
          byte $64, $64, $64, $64, $64, $64, $64, $64
          byte $64, $64, $64, $64, $64, $64, $64, $64
          byte $64, $64, $64, $64, $64, $64, $64, $64