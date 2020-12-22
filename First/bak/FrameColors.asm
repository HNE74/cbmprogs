;*** Startadresse BASIC-Zeile
*=$0801
 BYTE $0B, $08, $DD, $07, $9E, $20, $32, $30, $36, $32, $00, $00, $00
 
;*** Start des Assemblerprogrammes
loop:
        inc $D020      ;Rahmenfarbe um eins erhöhen
        nop            ;zwei Taktzyklen Verzögerung
        nop
        jmp (jmptable:)      ;Endlosschleife zum Label loop:

jmptable:
        BYTE <loop:, >loop: