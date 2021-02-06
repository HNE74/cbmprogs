SID_SURELI = $D406      ; hold, decay
SID_SIGVOL = $D418      ; volume

;*** channel 1
SID_CHANNEL1_FRELO = $D400      ; frequency lo byte
SID_CHANNEL1_FREHI = $D401      ; frequency high byte
SID_CHANNEL1_PWLO = $D402       ; pulse width lo byte
SID_CHANNEL1_PWLH  = $D403      ; pulse width high byte
SID_CHANNEL1_VCREG = $D404      ; waveform
SID_CHANNEL1_ATDCY = $D405      ; attack decay

; 10 SYS2064
*=$0801
        BYTE $0B, $08, $0A, $00, $9E, $32, $30, $36, $34, $00, $00, $00

start
        rts

