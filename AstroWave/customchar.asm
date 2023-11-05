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
080e : 8e 10 0b STX $0b10 ; (spentry + 0)
0811 : a9 55 __ LDA #$55
0813 : 85 19 __ STA IP + 0 
0815 : a9 0b __ LDA #$0b
0817 : 85 1a __ STA IP + 1 
0819 : 38 __ __ SEC
081a : a9 0b __ LDA #$0b
081c : e9 0b __ SBC #$0b
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
0830 : a9 5f __ LDA #$5f
0832 : e9 55 __ SBC #$55
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
0b10 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
main:
.s0:
0880 : a9 00 __ LDA #$00
0882 : 85 11 __ STA P4 
0884 : a9 14 __ LDA #$14
0886 : 85 12 __ STA P5 
0888 : a9 28 __ LDA #$28
088a : 85 13 __ STA P6 
088c : a9 04 __ LDA #$04
088e : 85 14 __ STA P7 
0890 : a9 55 __ LDA #$55
0892 : 85 0d __ STA P0 
0894 : a9 0b __ LDA #$0b
0896 : 85 0e __ STA P1 
0898 : a9 00 __ LDA #$00
089a : 85 0f __ STA P2 
089c : a9 c0 __ LDA #$c0
089e : 85 10 __ STA P3 
08a0 : 20 4a 09 JSR $094a ; (cwin_init.s0 + 0)
08a3 : 20 a0 09 JSR $09a0 ; (mmap_trampoline.s0 + 0)
08a6 : a9 31 __ LDA #$31
08a8 : 85 01 __ STA $01 
08aa : a9 08 __ LDA #$08
08ac : 85 12 __ STA P5 
08ae : a9 00 __ LDA #$00
08b0 : 85 0d __ STA P0 
08b2 : a9 c8 __ LDA #$c8
08b4 : 85 0e __ STA P1 
08b6 : ad 43 0b LDA $0b43 ; (romp + 0)
08b9 : 85 0f __ STA P2 
08bb : ad 44 0b LDA $0b44 ; (romp + 1)
08be : 85 10 __ STA P3 
08c0 : 20 ea 09 JSR $09ea ; (memcpy.s0 + 0)
08c3 : a2 10 __ LDX #$10
.l1002:
08c5 : bd 44 0b LDA $0b44,x ; (romp + 1)
08c8 : 9d ff cb STA $cbff,x 
08cb : ca __ __ DEX
08cc : d0 f7 __ BNE $08c5 ; (main.l1002 + 0)
.s1003:
08ce : a9 37 __ LDA #$37
08d0 : 85 01 __ STA $01 
08d2 : a9 00 __ LDA #$00
08d4 : 85 44 __ STA T0 + 1 
08d6 : 85 1b __ STA ACCU + 0 
08d8 : a8 __ __ TAY
.l1008:
08d9 : 18 __ __ CLC
08da : a9 c0 __ LDA #$c0
08dc : 65 44 __ ADC T0 + 1 
08de : 85 1c __ STA ACCU + 1 
08e0 : a9 20 __ LDA #$20
08e2 : 91 1b __ STA (ACCU + 0),y 
08e4 : c8 __ __ INY
08e5 : d0 02 __ BNE $08e9 ; (main.s1013 + 0)
.s1012:
08e7 : e6 44 __ INC T0 + 1 
.s1013:
08e9 : a5 44 __ LDA T0 + 1 
08eb : c9 03 __ CMP #$03
08ed : d0 ea __ BNE $08d9 ; (main.l1008 + 0)
.s1009:
08ef : c0 e8 __ CPY #$e8
08f1 : d0 e6 __ BNE $08d9 ; (main.l1008 + 0)
.s9:
08f3 : 84 11 __ STY P4 
08f5 : a9 07 __ LDA #$07
08f7 : 85 0f __ STA P2 
08f9 : a9 00 __ LDA #$00
08fb : 85 10 __ STA P3 
08fd : 85 0d __ STA P0 
08ff : a9 03 __ LDA #$03
0901 : 85 12 __ STA P5 
0903 : a9 d8 __ LDA #$d8
0905 : 85 0e __ STA P1 
0907 : 20 19 0a JSR $0a19 ; (memset.s0 + 0)
090a : a9 00 __ LDA #$00
090c : 8d 20 d0 STA $d020 
090f : 8d 21 d0 STA $d021 
0912 : 85 0d __ STA P0 
0914 : 85 0e __ STA P1 
0916 : a9 c0 __ LDA #$c0
0918 : 85 0f __ STA P2 
091a : a9 00 __ LDA #$00
091c : 85 10 __ STA P3 
091e : a9 c8 __ LDA #$c8
0920 : 85 11 __ STA P4 
0922 : 20 3d 0a JSR $0a3d ; (vic_setmode.s0 + 0)
0925 : a2 00 __ LDX #$00
.l1010:
0927 : 8a __ __ TXA
0928 : 9d 00 c0 STA $c000,x 
092b : e8 __ __ INX
092c : e0 ff __ CPX #$ff
092e : 90 f7 __ BCC $0927 ; (main.l1010 + 0)
.s1011:
0930 : a9 80 __ LDA #$80
0932 : 85 15 __ STA P8 
0934 : a9 01 __ LDA #$01
0936 : 85 16 __ STA P9 
0938 : a9 55 __ LDA #$55
093a : 85 13 __ STA P6 
093c : a9 0b __ LDA #$0b
093e : 85 14 __ STA P7 
0940 : 20 94 0a JSR $0a94 ; (cwin_put_char_raw.s0 + 0)
0943 : a9 00 __ LDA #$00
0945 : 85 1b __ STA ACCU + 0 
0947 : 85 1c __ STA ACCU + 1 
.s1001:
0949 : 60 __ __ RTS
--------------------------------------------------------------------
cwin_init:
.s0:
094a : a9 00 __ LDA #$00
094c : a0 04 __ LDY #$04
094e : 91 0d __ STA (P0),y ; (win + 0)
0950 : c8 __ __ INY
0951 : 91 0d __ STA (P0),y ; (win + 0)
0953 : a5 11 __ LDA P4 ; (sx + 0)
0955 : a0 00 __ LDY #$00
0957 : 91 0d __ STA (P0),y ; (win + 0)
0959 : a5 12 __ LDA P5 ; (sy + 0)
095b : c8 __ __ INY
095c : 91 0d __ STA (P0),y ; (win + 0)
095e : a5 13 __ LDA P6 ; (wx + 0)
0960 : c8 __ __ INY
0961 : 91 0d __ STA (P0),y ; (win + 0)
0963 : a5 14 __ LDA P7 ; (wy + 0)
0965 : c8 __ __ INY
0966 : 91 0d __ STA (P0),y ; (win + 0)
0968 : a5 12 __ LDA P5 ; (sy + 0)
096a : 0a __ __ ASL
096b : a8 __ __ TAY
096c : b9 11 0b LDA $0b11,y ; (mul40 + 0)
096f : 85 1b __ STA ACCU + 0 
0971 : 18 __ __ CLC
0972 : 65 11 __ ADC P4 ; (sx + 0)
0974 : aa __ __ TAX
0975 : b9 12 0b LDA $0b12,y ; (mul40 + 1)
0978 : 85 1c __ STA ACCU + 1 
097a : 69 d8 __ ADC #$d8
097c : a0 09 __ LDY #$09
097e : 91 0d __ STA (P0),y ; (win + 0)
0980 : 8a __ __ TXA
0981 : 88 __ __ DEY
0982 : 91 0d __ STA (P0),y ; (win + 0)
0984 : 18 __ __ CLC
0985 : a5 0f __ LDA P2 ; (screen + 0)
0987 : 65 1b __ ADC ACCU + 0 
0989 : aa __ __ TAX
098a : a5 10 __ LDA P3 ; (screen + 1)
098c : 65 1c __ ADC ACCU + 1 
098e : 85 10 __ STA P3 ; (screen + 1)
0990 : 8a __ __ TXA
0991 : 18 __ __ CLC
0992 : 65 11 __ ADC P4 ; (sx + 0)
0994 : a0 06 __ LDY #$06
0996 : 91 0d __ STA (P0),y ; (win + 0)
0998 : a5 10 __ LDA P3 ; (screen + 1)
099a : 69 00 __ ADC #$00
099c : c8 __ __ INY
099d : 91 0d __ STA (P0),y ; (win + 0)
.s1001:
099f : 60 __ __ RTS
--------------------------------------------------------------------
mul40:
0b11 : __ __ __ BYT 00 00 28 00 50 00 78 00 a0 00 c8 00 f0 00 18 01 : ..(.P.x.........
0b21 : __ __ __ BYT 40 01 68 01 90 01 b8 01 e0 01 08 02 30 02 58 02 : @.h.........0.X.
0b31 : __ __ __ BYT 80 02 a8 02 d0 02 f8 02 20 03 48 03 70 03 98 03 : ........ .H.p...
0b41 : __ __ __ BYT c0 03                                           : ..
--------------------------------------------------------------------
cwt:
0b55 : __ __ __ BSS	10
--------------------------------------------------------------------
mmap_trampoline:
.s0:
09a0 : a9 b5 __ LDA #$b5
09a2 : 8d fa ff STA $fffa 
09a5 : a9 09 __ LDA #$09
09a7 : 8d fb ff STA $fffb 
09aa : a9 d3 __ LDA #$d3
09ac : 8d fe ff STA $fffe 
09af : a9 09 __ LDA #$09
09b1 : 8d ff ff STA $ffff 
.s1001:
09b4 : 60 __ __ RTS
--------------------------------------------------------------------
NMITrampoline:
09b5 : 48 __ __ PHA
09b6 : 8a __ __ TXA
09b7 : 48 __ __ PHA
09b8 : a9 09 __ LDA #$09
09ba : 48 __ __ PHA
09bb : a9 cc __ LDA #$cc
09bd : 48 __ __ PHA
09be : ba __ __ TSX
09bf : bd 05 01 LDA $0105,x 
09c2 : 48 __ __ PHA
09c3 : a6 01 __ LDX $01 
09c5 : a9 36 __ LDA #$36
09c7 : 85 01 __ STA $01 
09c9 : 6c fa ff JMP ($fffa)
--------------------------------------------------------------------
DoneTrampoline:
09cc : 86 01 __ STX $01 
09ce : 68 __ __ PLA
09cf : aa __ __ TAX
09d0 : 68 __ __ PLA
09d1 : 40 __ __ RTI
09d2 : 60 __ __ RTS
--------------------------------------------------------------------
IRQTrampoline:
09d3 : 48 __ __ PHA
09d4 : 8a __ __ TXA
09d5 : 48 __ __ PHA
09d6 : a9 09 __ LDA #$09
09d8 : 48 __ __ PHA
09d9 : a9 cc __ LDA #$cc
09db : 48 __ __ PHA
09dc : ba __ __ TSX
09dd : bd 05 01 LDA $0105,x 
09e0 : 48 __ __ PHA
09e1 : a6 01 __ LDX $01 
09e3 : a9 36 __ LDA #$36
09e5 : 85 01 __ STA $01 
09e7 : 6c fe ff JMP ($fffe)
--------------------------------------------------------------------
memcpy:
.s0:
09ea : a6 12 __ LDX P5 
09ec : f0 10 __ BEQ $09fe ; (memcpy.s0 + 20)
09ee : a0 00 __ LDY #$00
09f0 : b1 0f __ LDA (P2),y 
09f2 : 91 0d __ STA (P0),y ; (dst + 0)
09f4 : c8 __ __ INY
09f5 : d0 f9 __ BNE $09f0 ; (memcpy.s0 + 6)
09f7 : e6 10 __ INC P3 
09f9 : e6 0e __ INC P1 ; (dst + 1)
09fb : ca __ __ DEX
09fc : d0 f2 __ BNE $09f0 ; (memcpy.s0 + 6)
09fe : a4 11 __ LDY P4 
0a00 : f0 0e __ BEQ $0a10 ; (memcpy.s0 + 38)
0a02 : 88 __ __ DEY
0a03 : f0 07 __ BEQ $0a0c ; (memcpy.s0 + 34)
0a05 : b1 0f __ LDA (P2),y 
0a07 : 91 0d __ STA (P0),y ; (dst + 0)
0a09 : 88 __ __ DEY
0a0a : d0 f9 __ BNE $0a05 ; (memcpy.s0 + 27)
0a0c : b1 0f __ LDA (P2),y 
0a0e : 91 0d __ STA (P0),y ; (dst + 0)
0a10 : a5 0d __ LDA P0 ; (dst + 0)
0a12 : 85 1b __ STA ACCU + 0 
0a14 : a5 0e __ LDA P1 ; (dst + 1)
0a16 : 85 1c __ STA ACCU + 1 
.s1001:
0a18 : 60 __ __ RTS
--------------------------------------------------------------------
romp:
0b43 : __ __ __ BYT 00 d0                                           : ..
--------------------------------------------------------------------
Smiley:
0b45 : __ __ __ BYT 7c fe 92 fe 82 c6 7c 00 7c fe 92 fe c6 ba 7c 00 : |.....|.|.....|.
--------------------------------------------------------------------
memset:
.s0:
0a19 : a5 0f __ LDA P2 
0a1b : a6 12 __ LDX P5 
0a1d : f0 0c __ BEQ $0a2b ; (memset.s0 + 18)
0a1f : a0 00 __ LDY #$00
0a21 : 91 0d __ STA (P0),y ; (dst + 0)
0a23 : c8 __ __ INY
0a24 : d0 fb __ BNE $0a21 ; (memset.s0 + 8)
0a26 : e6 0e __ INC P1 ; (dst + 1)
0a28 : ca __ __ DEX
0a29 : d0 f6 __ BNE $0a21 ; (memset.s0 + 8)
0a2b : a4 11 __ LDY P4 
0a2d : f0 05 __ BEQ $0a34 ; (memset.s0 + 27)
0a2f : 88 __ __ DEY
0a30 : 91 0d __ STA (P0),y ; (dst + 0)
0a32 : d0 fb __ BNE $0a2f ; (memset.s0 + 22)
0a34 : a5 0d __ LDA P0 ; (dst + 0)
0a36 : 85 1b __ STA ACCU + 0 
0a38 : a5 0e __ LDA P1 ; (dst + 1)
0a3a : 85 1c __ STA ACCU + 1 
.s1001:
0a3c : 60 __ __ RTS
--------------------------------------------------------------------
vic_setmode:
.s0:
0a3d : a6 0f __ LDX P2 ; (text + 1)
0a3f : a4 0d __ LDY P0 ; (mode + 0)
0a41 : c0 02 __ CPY #$02
0a43 : d0 07 __ BNE $0a4c ; (vic_setmode.s15 + 0)
.s6:
0a45 : a9 5b __ LDA #$5b
0a47 : 8d 11 d0 STA $d011 
0a4a : d0 0d __ BNE $0a59 ; (vic_setmode.s23 + 0)
.s15:
0a4c : c0 02 __ CPY #$02
0a4e : 90 39 __ BCC $0a89 ; (vic_setmode.s17 + 0)
.s16:
0a50 : a9 3b __ LDA #$3b
0a52 : 8d 11 d0 STA $d011 
0a55 : c0 03 __ CPY #$03
0a57 : d0 04 __ BNE $0a5d ; (vic_setmode.s1009 + 0)
.s23:
0a59 : a9 08 __ LDA #$08
0a5b : d0 02 __ BNE $0a5f ; (vic_setmode.s1 + 0)
.s1009:
0a5d : a9 18 __ LDA #$18
.s1:
0a5f : 8d 16 d0 STA $d016 
0a62 : ad 00 dd LDA $dd00 
0a65 : 29 fc __ AND #$fc
0a67 : 85 1b __ STA ACCU + 0 
0a69 : 8a __ __ TXA
0a6a : 0a __ __ ASL
0a6b : 2a __ __ ROL
0a6c : 29 01 __ AND #$01
0a6e : 2a __ __ ROL
0a6f : 49 03 __ EOR #$03
0a71 : 05 1b __ ORA ACCU + 0 
0a73 : 8d 00 dd STA $dd00 
0a76 : 8a __ __ TXA
0a77 : 0a __ __ ASL
0a78 : 0a __ __ ASL
0a79 : 29 f0 __ AND #$f0
0a7b : 85 1b __ STA ACCU + 0 
0a7d : a5 11 __ LDA P4 ; (font + 1)
0a7f : 4a __ __ LSR
0a80 : 4a __ __ LSR
0a81 : 29 0e __ AND #$0e
0a83 : 05 1b __ ORA ACCU + 0 
0a85 : 8d 18 d0 STA $d018 
.s1001:
0a88 : 60 __ __ RTS
.s17:
0a89 : a9 1b __ LDA #$1b
0a8b : 8d 11 d0 STA $d011 
0a8e : 98 __ __ TYA
0a8f : d0 cc __ BNE $0a5d ; (vic_setmode.s1009 + 0)
0a91 : 4c 59 0a JMP $0a59 ; (vic_setmode.s23 + 0)
--------------------------------------------------------------------
cwin_put_char_raw:
.s0:
0a94 : a5 13 __ LDA P6 ; (win + 0)
0a96 : 85 0d __ STA P0 
0a98 : a5 14 __ LDA P7 ; (win + 1)
0a9a : 85 0e __ STA P1 
0a9c : a0 04 __ LDY #$04
0a9e : b1 13 __ LDA (P6),y ; (win + 0)
0aa0 : 85 0f __ STA P2 
0aa2 : c8 __ __ INY
0aa3 : b1 13 __ LDA (P6),y ; (win + 0)
0aa5 : 85 10 __ STA P3 
0aa7 : a5 15 __ LDA P8 ; (ch + 0)
0aa9 : 85 11 __ STA P4 
0aab : a5 16 __ LDA P9 ; (color + 0)
0aad : 85 12 __ STA P5 
0aaf : 20 d0 0a JSR $0ad0 ; (cwin_putat_char_raw.s0 + 0)
0ab2 : 18 __ __ CLC
0ab3 : a0 04 __ LDY #$04
0ab5 : b1 13 __ LDA (P6),y ; (win + 0)
0ab7 : 69 01 __ ADC #$01
0ab9 : 91 13 __ STA (P6),y ; (win + 0)
0abb : a0 02 __ LDY #$02
0abd : d1 13 __ CMP (P6),y ; (win + 0)
0abf : d0 0e __ BNE $0acf ; (cwin_put_char_raw.s1001 + 0)
.s1:
0ac1 : a9 00 __ LDA #$00
0ac3 : a0 04 __ LDY #$04
0ac5 : 91 13 __ STA (P6),y ; (win + 0)
0ac7 : 18 __ __ CLC
0ac8 : c8 __ __ INY
0ac9 : b1 13 __ LDA (P6),y ; (win + 0)
0acb : 69 01 __ ADC #$01
0acd : 91 13 __ STA (P6),y ; (win + 0)
.s1001:
0acf : 60 __ __ RTS
--------------------------------------------------------------------
cwin_putat_char_raw:
.s0:
0ad0 : a5 10 __ LDA P3 ; (y + 0)
0ad2 : 0a __ __ ASL
0ad3 : aa __ __ TAX
0ad4 : bd 11 0b LDA $0b11,x ; (mul40 + 0)
0ad7 : 18 __ __ CLC
0ad8 : 65 0f __ ADC P2 ; (x + 0)
0ada : 85 1b __ STA ACCU + 0 
0adc : bd 12 0b LDA $0b12,x ; (mul40 + 1)
0adf : 69 00 __ ADC #$00
0ae1 : 85 1c __ STA ACCU + 1 
0ae3 : a0 06 __ LDY #$06
0ae5 : b1 0d __ LDA (P0),y ; (win + 0)
0ae7 : 18 __ __ CLC
0ae8 : 65 1b __ ADC ACCU + 0 
0aea : 85 43 __ STA T3 + 0 
0aec : c8 __ __ INY
0aed : b1 0d __ LDA (P0),y ; (win + 0)
0aef : 65 1c __ ADC ACCU + 1 
0af1 : 85 44 __ STA T3 + 1 
0af3 : a5 11 __ LDA P4 ; (ch + 0)
0af5 : a0 00 __ LDY #$00
0af7 : 91 43 __ STA (T3 + 0),y 
0af9 : a0 08 __ LDY #$08
0afb : b1 0d __ LDA (P0),y ; (win + 0)
0afd : 18 __ __ CLC
0afe : 65 1b __ ADC ACCU + 0 
0b00 : 85 1b __ STA ACCU + 0 
0b02 : c8 __ __ INY
0b03 : b1 0d __ LDA (P0),y ; (win + 0)
0b05 : 65 1c __ ADC ACCU + 1 
0b07 : 85 1c __ STA ACCU + 1 
0b09 : a5 12 __ LDA P5 ; (color + 0)
0b0b : a0 00 __ LDY #$00
0b0d : 91 1b __ STA (ACCU + 0),y 
.s1001:
0b0f : 60 __ __ RTS
