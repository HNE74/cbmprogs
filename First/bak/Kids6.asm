*=$C000
        
;        JSR     $E544   ; CLS
;        
;        LDX     #65     ; INIT X REG WITH ASCII A

;LOOP    TXA
;        JSR     $E716   ; PRINT CHARACTER
;        
;        INX             ; INCREMENT X AND COMPARE IF LAST 
;        CPX     #91     ; CHARACTER OF ALPHABET HAS BEEN REACHEDD
;        BNE     LOOP    ; IF NOT GO TO LOOP LABEL

;        RTS             ; IF END PROGRAM

SCREENCOLOR = 55296
SCREENCHAR = 1024


        JSR     $E544   ; CLS
        LDX     #0      ; COLOR
        LDY     #1      ; CHARACTER

; FILL FIRST 255 POSITION OF SCREEN
@START  TYA
        STA     SCREENCOLOR,X
        TXA
        STA     SCREENCHAR,X
        INX
        CPX     #255
        BNE     @START

        RTS

