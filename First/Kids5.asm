*=$C000

; Indirect addressing using the x register
;        JSR     $E544   ; CLS

;        LDY     #65     ; STORE VALUE TO BE DISPLAYED
;        STY     $C100

;        LDA     #$00    ; LOAD ZERO PAGE REGISTERS FOR INDIRECT
;        STA     $FB     ; ADDRESSING
;        LDA     #$C1
;        STA     $FC
;        
;        LDX     #$0     ; DISPLAY VALUE USING INDIRECT ADDRESSING
;        LDA     ($FB,X)
;        JSR     $E716

;        RTS

; INDIRECT ADDRESSING USING THE Y REGISTER
        JSR     $E544   ; CLS

        LDX     #$D1    ; PREPARE ZERO PAGE REGISTER 
        STX     $FB
        LDX     #$C0
        STX     $FC

        LDX     #65     ; STORE VALUES TO BE SHOWN
        STX     $C0D1
        INX
        STX     $C0D3
        INX
        STX     $C0D5

        LDY     #$0     ; SHOW VALUES USING INDIRECT ADDRESSING
        LDA     ($FB),Y
        JSR     $E716

        INY
        INY    
        LDA     ($FB),Y
        JSR     $E716
        
        INY
        INY
        LDA     ($FB),Y
        JSR     $E716

        RTS