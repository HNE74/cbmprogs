--------------------------------------------------------------------
startup:
0801 : 0b __ __ INV
0802 : 08 __ __ PHP
0803 : 0a __ __ ASL
0804 : 00 __ __ BRK
0805 : 9e __ __ INV
0806 : 32 __ __ INV
0807 : 30 36 __ BMI $083f ; (startup + 62)
0809 : 31 00 __ AND ($00),y 
080b : 00 __ __ BRK
080c : 00 __ __ BRK
080d : ba __ __ TSX
080e : 8e e0 08 STX $08e0 ; (spentry + 0)
0811 : a9 e1 __ LDA #$e1
0813 : 85 19 __ STA IP + 0 
0815 : a9 08 __ LDA #$08
0817 : 85 1a __ STA IP + 1 
0819 : 38 __ __ SEC
081a : a9 08 __ LDA #$08
081c : e9 08 __ SBC #$08
081e : f0 0f __ BEQ $082f ; (startup + 46)
0820 : aa __ __ TAX
0821 : a9 00 __ LDA #$00
0823 : a0 00 __ LDY #$00
0825 : 91 19 __ STA (IP + 0),y 
0827 : c8 __ __ INY
0828 : d0 fb __ BNE $0825 ; (startup + 36)
082a : e6 1a __ INC IP + 1 
082c : ca __ __ DEX
082d : d0 f6 __ BNE $0825 ; (startup + 36)
082f : 38 __ __ SEC
0830 : a9 e1 __ LDA #$e1
0832 : e9 e1 __ SBC #$e1
0834 : f0 08 __ BEQ $083e ; (startup + 61)
0836 : a8 __ __ TAY
0837 : a9 00 __ LDA #$00
0839 : 88 __ __ DEY
083a : 91 19 __ STA (IP + 0),y 
083c : d0 fb __ BNE $0839 ; (startup + 56)
083e : a2 f7 __ LDX #$f7
0840 : e0 f7 __ CPX #$f7
0842 : f0 07 __ BEQ $084b ; (startup + 74)
0844 : 95 00 __ STA $00,x 
0846 : e8 __ __ INX
0847 : e0 f7 __ CPX #$f7
0849 : d0 f9 __ BNE $0844 ; (startup + 67)
084b : a9 fe __ LDA #$fe
084d : 85 23 __ STA SP + 0 
084f : a9 9f __ LDA #$9f
0851 : 85 24 __ STA SP + 1 
0853 : 20 80 08 JSR $0880 ; (main.s0 + 0)
0856 : a9 4c __ LDA #$4c
0858 : 85 54 __ STA $54 
085a : a9 00 __ LDA #$00
085c : 85 13 __ STA P6 
085e : a9 19 __ LDA #$19
0860 : 85 16 __ STA P9 
0862 : 60 __ __ RTS
--------------------------------------------------------------------
spentry:
08e0 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
main:
.s0:
0880 : a9 ff __ LDA #$ff
0882 : 8d 18 d4 STA $d418 
0885 : a9 0a __ LDA #$0a
0887 : 8d 00 d4 STA $d400 
088a : a9 00 __ LDA #$00
088c : 8d 01 d4 STA $d401 
088f : a9 35 __ LDA #$35
0891 : 8d 05 d4 STA $d405 
0894 : a9 f1 __ LDA #$f1
0896 : 8d 06 d4 STA $d406 
0899 : a9 81 __ LDA #$81
089b : 8d 04 d4 STA $d404 
089e : a9 00 __ LDA #$00
08a0 : 85 1c __ STA ACCU + 1 
.l7:
08a2 : ad 11 d0 LDA $d011 
08a5 : 30 fb __ BMI $08a2 ; (main.l7 + 0)
.l10:
08a7 : ad 11 d0 LDA $d011 
08aa : 10 fb __ BPL $08a7 ; (main.l10 + 0)
.s6:
08ac : a5 1c __ LDA ACCU + 1 
08ae : 0a __ __ ASL
08af : 85 1b __ STA ACCU + 0 
08b1 : a9 00 __ LDA #$00
08b3 : 2a __ __ ROL
08b4 : 06 1b __ ASL ACCU + 0 
08b6 : 2a __ __ ROL
08b7 : aa __ __ TAX
08b8 : a5 1b __ LDA ACCU + 0 
08ba : 65 1c __ ADC ACCU + 1 
08bc : 85 1b __ STA ACCU + 0 
08be : 8a __ __ TXA
08bf : 69 00 __ ADC #$00
08c1 : 06 1b __ ASL ACCU + 0 
08c3 : 2a __ __ ROL
08c4 : 8d 01 d4 STA $d401 
08c7 : a5 1b __ LDA ACCU + 0 
08c9 : 8d 00 d4 STA $d400 
08cc : e6 1c __ INC ACCU + 1 
08ce : a5 1c __ LDA ACCU + 1 
08d0 : c9 64 __ CMP #$64
08d2 : 90 ce __ BCC $08a2 ; (main.l7 + 0)
.s5:
08d4 : a9 10 __ LDA #$10
08d6 : 8d 04 d4 STA $d404 
08d9 : a9 00 __ LDA #$00
08db : 85 1b __ STA ACCU + 0 
08dd : 85 1c __ STA ACCU + 1 
.s1001:
08df : 60 __ __ RTS
