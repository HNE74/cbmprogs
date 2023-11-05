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
080e : 8e fc 09 STX $09fc ; (spentry + 0)
0811 : a9 4e __ LDA #$4e
0813 : 85 19 __ STA IP + 0 
0815 : a9 1d __ LDA #$1d
0817 : 85 1a __ STA IP + 1 
0819 : 38 __ __ SEC
081a : a9 1d __ LDA #$1d
081c : e9 1d __ SBC #$1d
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
0830 : a9 58 __ LDA #$58
0832 : e9 4e __ SBC #$4e
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
084b : a9 cc __ LDA #$cc
084d : 85 23 __ STA SP + 0 
084f : a9 9f __ LDA #$9f
0851 : 85 24 __ STA SP + 1 
0853 : 20 80 08 JSR $0880 ; (main.s1000 + 0)
0856 : a9 4c __ LDA #$4c
0858 : 85 54 __ STA $54 
085a : a9 00 __ LDA #$00
085c : 85 13 __ STA P6 
085e : a9 19 __ LDA #$19
0860 : 85 16 __ STA P9 
0862 : 60 __ __ RTS
--------------------------------------------------------------------
spentry:
09fc : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
main:
.s1000:
0880 : 38 __ __ SEC
0881 : a5 23 __ LDA SP + 0 
0883 : e9 08 __ SBC #$08
0885 : 85 23 __ STA SP + 0 
0887 : b0 02 __ BCS $088b ; (main.s0 + 0)
0889 : c6 24 __ DEC SP + 1 
.s0:
088b : a9 00 __ LDA #$00
088d : 85 11 __ STA P4 
088f : a9 14 __ LDA #$14
0891 : 85 12 __ STA P5 
0893 : a9 28 __ LDA #$28
0895 : 85 13 __ STA P6 
0897 : a9 04 __ LDA #$04
0899 : 85 14 __ STA P7 
089b : a9 4e __ LDA #$4e
089d : 85 0d __ STA P0 
089f : a9 1d __ LDA #$1d
08a1 : 85 0e __ STA P1 
08a3 : a9 00 __ LDA #$00
08a5 : 85 0f __ STA P2 
08a7 : a9 c0 __ LDA #$c0
08a9 : 85 10 __ STA P3 
08ab : 20 87 09 JSR $0987 ; (cwin_init.s0 + 0)
08ae : 20 dd 09 JSR $09dd ; (mmap_trampoline.s0 + 0)
08b1 : a9 31 __ LDA #$31
08b3 : 85 01 __ STA $01 
08b5 : a9 08 __ LDA #$08
08b7 : 85 12 __ STA P5 
08b9 : a9 00 __ LDA #$00
08bb : 85 0d __ STA P0 
08bd : a9 c8 __ LDA #$c8
08bf : 85 0e __ STA P1 
08c1 : ad fd 09 LDA $09fd ; (romp + 0)
08c4 : 85 0f __ STA P2 
08c6 : ad fe 09 LDA $09fe ; (romp + 1)
08c9 : 85 10 __ STA P3 
08cb : 20 2e 0a JSR $0a2e ; (memcpy.s0 + 0)
08ce : a2 10 __ LDX #$10
.l1002:
08d0 : bd e4 1c LDA $1ce4,x ; (divmod32 + 149)
08d3 : 9d ff cb STA $cbff,x 
08d6 : ca __ __ DEX
08d7 : d0 f7 __ BNE $08d0 ; (main.l1002 + 0)
.s1003:
08d9 : a9 37 __ LDA #$37
08db : 85 01 __ STA $01 
08dd : a9 00 __ LDA #$00
08df : 85 1c __ STA ACCU + 1 
08e1 : 85 43 __ STA T1 + 0 
08e3 : a8 __ __ TAY
.l1008:
08e4 : 18 __ __ CLC
08e5 : a9 c0 __ LDA #$c0
08e7 : 65 1c __ ADC ACCU + 1 
08e9 : 85 44 __ STA T1 + 1 
08eb : a9 20 __ LDA #$20
08ed : 91 43 __ STA (T1 + 0),y 
08ef : c8 __ __ INY
08f0 : d0 02 __ BNE $08f4 ; (main.s1013 + 0)
.s1012:
08f2 : e6 1c __ INC ACCU + 1 
.s1013:
08f4 : a5 1c __ LDA ACCU + 1 
08f6 : c9 03 __ CMP #$03
08f8 : d0 ea __ BNE $08e4 ; (main.l1008 + 0)
.s1009:
08fa : c0 e8 __ CPY #$e8
08fc : d0 e6 __ BNE $08e4 ; (main.l1008 + 0)
.s9:
08fe : 84 11 __ STY P4 
0900 : a9 07 __ LDA #$07
0902 : 85 0f __ STA P2 
0904 : a9 00 __ LDA #$00
0906 : 85 10 __ STA P3 
0908 : 85 0d __ STA P0 
090a : a9 03 __ LDA #$03
090c : 85 12 __ STA P5 
090e : a9 d8 __ LDA #$d8
0910 : 85 0e __ STA P1 
0912 : 20 5d 0a JSR $0a5d ; (memset.s0 + 0)
0915 : a9 00 __ LDA #$00
0917 : 8d 20 d0 STA $d020 
091a : 8d 21 d0 STA $d021 
091d : 85 0d __ STA P0 
091f : 85 0e __ STA P1 
0921 : a9 c0 __ LDA #$c0
0923 : 85 0f __ STA P2 
0925 : a9 00 __ LDA #$00
0927 : 85 10 __ STA P3 
0929 : a9 c8 __ LDA #$c8
092b : 85 11 __ STA P4 
092d : 20 81 0a JSR $0a81 ; (vic_setmode.s0 + 0)
0930 : a2 00 __ LDX #$00
.l1010:
0932 : 8a __ __ TXA
0933 : 9d 00 c0 STA $c000,x 
0936 : e8 __ __ INX
0937 : e0 ff __ CPX #$ff
0939 : 90 f7 __ BCC $0932 ; (main.l1010 + 0)
.s1011:
093b : a9 e8 __ LDA #$e8
093d : a0 06 __ LDY #$06
093f : 91 23 __ STA (SP + 0),y 
0941 : a9 03 __ LDA #$03
0943 : c8 __ __ INY
0944 : 91 23 __ STA (SP + 0),y 
0946 : a9 ce __ LDA #$ce
0948 : a0 02 __ LDY #$02
094a : 91 23 __ STA (SP + 0),y 
094c : a9 9f __ LDA #$9f
094e : c8 __ __ INY
094f : 91 23 __ STA (SP + 0),y 
0951 : a9 f9 __ LDA #$f9
0953 : c8 __ __ INY
0954 : 91 23 __ STA (SP + 0),y 
0956 : a9 09 __ LDA #$09
0958 : c8 __ __ INY
0959 : 91 23 __ STA (SP + 0),y 
095b : 20 d8 0a JSR $0ad8 ; (sprintf.s1000 + 0)
095e : a9 ce __ LDA #$ce
0960 : 85 16 __ STA P9 
0962 : a9 9f __ LDA #$9f
0964 : 85 17 __ STA P10 
0966 : a9 01 __ LDA #$01
0968 : 85 18 __ STA P11 
096a : a9 4e __ LDA #$4e
096c : 85 14 __ STA P7 
096e : a9 1d __ LDA #$1d
0970 : 85 15 __ STA P8 
0972 : 20 9f 17 JSR $179f ; (cwin_put_string.s0 + 0)
0975 : a9 00 __ LDA #$00
0977 : 85 1b __ STA ACCU + 0 
0979 : 85 1c __ STA ACCU + 1 
.s1001:
097b : 18 __ __ CLC
097c : a5 23 __ LDA SP + 0 
097e : 69 08 __ ADC #$08
0980 : 85 23 __ STA SP + 0 
0982 : 90 02 __ BCC $0986 ; (main.s1001 + 11)
0984 : e6 24 __ INC SP + 1 
0986 : 60 __ __ RTS
--------------------------------------------------------------------
cwin_init:
.s0:
0987 : a9 00 __ LDA #$00
0989 : a0 04 __ LDY #$04
098b : 91 0d __ STA (P0),y ; (win + 0)
098d : c8 __ __ INY
098e : 91 0d __ STA (P0),y ; (win + 0)
0990 : a5 11 __ LDA P4 ; (sx + 0)
0992 : a0 00 __ LDY #$00
0994 : 91 0d __ STA (P0),y ; (win + 0)
0996 : a5 12 __ LDA P5 ; (sy + 0)
0998 : c8 __ __ INY
0999 : 91 0d __ STA (P0),y ; (win + 0)
099b : a5 13 __ LDA P6 ; (wx + 0)
099d : c8 __ __ INY
099e : 91 0d __ STA (P0),y ; (win + 0)
09a0 : a5 14 __ LDA P7 ; (wy + 0)
09a2 : c8 __ __ INY
09a3 : 91 0d __ STA (P0),y ; (win + 0)
09a5 : a5 12 __ LDA P5 ; (sy + 0)
09a7 : 0a __ __ ASL
09a8 : a8 __ __ TAY
09a9 : b9 00 1d LDA $1d00,y ; (mul40 + 0)
09ac : 85 1b __ STA ACCU + 0 
09ae : 18 __ __ CLC
09af : 65 11 __ ADC P4 ; (sx + 0)
09b1 : aa __ __ TAX
09b2 : b9 01 1d LDA $1d01,y ; (mul40 + 1)
09b5 : 85 1c __ STA ACCU + 1 
09b7 : 69 d8 __ ADC #$d8
09b9 : a0 09 __ LDY #$09
09bb : 91 0d __ STA (P0),y ; (win + 0)
09bd : 8a __ __ TXA
09be : 88 __ __ DEY
09bf : 91 0d __ STA (P0),y ; (win + 0)
09c1 : 18 __ __ CLC
09c2 : a5 0f __ LDA P2 ; (screen + 0)
09c4 : 65 1b __ ADC ACCU + 0 
09c6 : aa __ __ TAX
09c7 : a5 10 __ LDA P3 ; (screen + 1)
09c9 : 65 1c __ ADC ACCU + 1 
09cb : 85 10 __ STA P3 ; (screen + 1)
09cd : 8a __ __ TXA
09ce : 18 __ __ CLC
09cf : 65 11 __ ADC P4 ; (sx + 0)
09d1 : a0 06 __ LDY #$06
09d3 : 91 0d __ STA (P0),y ; (win + 0)
09d5 : a5 10 __ LDA P3 ; (screen + 1)
09d7 : 69 00 __ ADC #$00
09d9 : c8 __ __ INY
09da : 91 0d __ STA (P0),y ; (win + 0)
.s1001:
09dc : 60 __ __ RTS
--------------------------------------------------------------------
mul40:
1d00 : __ __ __ BYT 00 00 28 00 50 00 78 00 a0 00 c8 00 f0 00 18 01 : ..(.P.x.........
1d10 : __ __ __ BYT 40 01 68 01 90 01 b8 01 e0 01 08 02 30 02 58 02 : @.h.........0.X.
1d20 : __ __ __ BYT 80 02 a8 02 d0 02 f8 02 20 03 48 03 70 03 98 03 : ........ .H.p...
1d30 : __ __ __ BYT c0 03                                           : ..
--------------------------------------------------------------------
cwt:
1d4e : __ __ __ BSS	10
--------------------------------------------------------------------
mmap_trampoline:
.s0:
09dd : a9 00 __ LDA #$00
09df : 8d fa ff STA $fffa 
09e2 : a9 0a __ LDA #$0a
09e4 : 8d fb ff STA $fffb 
09e7 : a9 17 __ LDA #$17
09e9 : 8d fe ff STA $fffe 
09ec : a9 0a __ LDA #$0a
09ee : 8d ff ff STA $ffff 
.s1001:
09f1 : 60 __ __ RTS
--------------------------------------------------------------------
NMITrampoline:
0a00 : 48 __ __ PHA
0a01 : 8a __ __ TXA
0a02 : 48 __ __ PHA
0a03 : a9 09 __ LDA #$09
0a05 : 48 __ __ PHA
0a06 : a9 f2 __ LDA #$f2
0a08 : 48 __ __ PHA
0a09 : ba __ __ TSX
0a0a : bd 05 01 LDA $0105,x 
0a0d : 48 __ __ PHA
0a0e : a6 01 __ LDX $01 
0a10 : a9 36 __ LDA #$36
0a12 : 85 01 __ STA $01 
0a14 : 6c fa ff JMP ($fffa)
--------------------------------------------------------------------
DoneTrampoline:
09f2 : 86 01 __ STX $01 
09f4 : 68 __ __ PLA
09f5 : aa __ __ TAX
09f6 : 68 __ __ PLA
09f7 : 40 __ __ RTI
09f8 : 60 __ __ RTS
--------------------------------------------------------------------
IRQTrampoline:
0a17 : 48 __ __ PHA
0a18 : 8a __ __ TXA
0a19 : 48 __ __ PHA
0a1a : a9 09 __ LDA #$09
0a1c : 48 __ __ PHA
0a1d : a9 f2 __ LDA #$f2
0a1f : 48 __ __ PHA
0a20 : ba __ __ TSX
0a21 : bd 05 01 LDA $0105,x 
0a24 : 48 __ __ PHA
0a25 : a6 01 __ LDX $01 
0a27 : a9 36 __ LDA #$36
0a29 : 85 01 __ STA $01 
0a2b : 6c fe ff JMP ($fffe)
--------------------------------------------------------------------
memcpy:
.s0:
0a2e : a6 12 __ LDX P5 
0a30 : f0 10 __ BEQ $0a42 ; (memcpy.s0 + 20)
0a32 : a0 00 __ LDY #$00
0a34 : b1 0f __ LDA (P2),y 
0a36 : 91 0d __ STA (P0),y ; (dst + 0)
0a38 : c8 __ __ INY
0a39 : d0 f9 __ BNE $0a34 ; (memcpy.s0 + 6)
0a3b : e6 10 __ INC P3 
0a3d : e6 0e __ INC P1 ; (dst + 1)
0a3f : ca __ __ DEX
0a40 : d0 f2 __ BNE $0a34 ; (memcpy.s0 + 6)
0a42 : a4 11 __ LDY P4 
0a44 : f0 0e __ BEQ $0a54 ; (memcpy.s0 + 38)
0a46 : 88 __ __ DEY
0a47 : f0 07 __ BEQ $0a50 ; (memcpy.s0 + 34)
0a49 : b1 0f __ LDA (P2),y 
0a4b : 91 0d __ STA (P0),y ; (dst + 0)
0a4d : 88 __ __ DEY
0a4e : d0 f9 __ BNE $0a49 ; (memcpy.s0 + 27)
0a50 : b1 0f __ LDA (P2),y 
0a52 : 91 0d __ STA (P0),y ; (dst + 0)
0a54 : a5 0d __ LDA P0 ; (dst + 0)
0a56 : 85 1b __ STA ACCU + 0 
0a58 : a5 0e __ LDA P1 ; (dst + 1)
0a5a : 85 1c __ STA ACCU + 1 
.s1001:
0a5c : 60 __ __ RTS
--------------------------------------------------------------------
romp:
09fd : __ __ __ BYT 00 d0                                           : ..
--------------------------------------------------------------------
Smiley:
1ce5 : __ __ __ BYT 7c fe 92 fe 82 c6 7c 00 7c fe 92 fe c6 ba 7c 00 : |.....|.|.....|.
--------------------------------------------------------------------
memset:
.s0:
0a5d : a5 0f __ LDA P2 
0a5f : a6 12 __ LDX P5 
0a61 : f0 0c __ BEQ $0a6f ; (memset.s0 + 18)
0a63 : a0 00 __ LDY #$00
0a65 : 91 0d __ STA (P0),y ; (dst + 0)
0a67 : c8 __ __ INY
0a68 : d0 fb __ BNE $0a65 ; (memset.s0 + 8)
0a6a : e6 0e __ INC P1 ; (dst + 1)
0a6c : ca __ __ DEX
0a6d : d0 f6 __ BNE $0a65 ; (memset.s0 + 8)
0a6f : a4 11 __ LDY P4 
0a71 : f0 05 __ BEQ $0a78 ; (memset.s0 + 27)
0a73 : 88 __ __ DEY
0a74 : 91 0d __ STA (P0),y ; (dst + 0)
0a76 : d0 fb __ BNE $0a73 ; (memset.s0 + 22)
0a78 : a5 0d __ LDA P0 ; (dst + 0)
0a7a : 85 1b __ STA ACCU + 0 
0a7c : a5 0e __ LDA P1 ; (dst + 1)
0a7e : 85 1c __ STA ACCU + 1 
.s1001:
0a80 : 60 __ __ RTS
--------------------------------------------------------------------
vic_setmode:
.s0:
0a81 : a6 0f __ LDX P2 ; (text + 1)
0a83 : a4 0d __ LDY P0 ; (mode + 0)
0a85 : c0 02 __ CPY #$02
0a87 : d0 07 __ BNE $0a90 ; (vic_setmode.s15 + 0)
.s6:
0a89 : a9 5b __ LDA #$5b
0a8b : 8d 11 d0 STA $d011 
0a8e : d0 0d __ BNE $0a9d ; (vic_setmode.s23 + 0)
.s15:
0a90 : c0 02 __ CPY #$02
0a92 : 90 39 __ BCC $0acd ; (vic_setmode.s17 + 0)
.s16:
0a94 : a9 3b __ LDA #$3b
0a96 : 8d 11 d0 STA $d011 
0a99 : c0 03 __ CPY #$03
0a9b : d0 04 __ BNE $0aa1 ; (vic_setmode.s1009 + 0)
.s23:
0a9d : a9 08 __ LDA #$08
0a9f : d0 02 __ BNE $0aa3 ; (vic_setmode.s1 + 0)
.s1009:
0aa1 : a9 18 __ LDA #$18
.s1:
0aa3 : 8d 16 d0 STA $d016 
0aa6 : ad 00 dd LDA $dd00 
0aa9 : 29 fc __ AND #$fc
0aab : 85 1b __ STA ACCU + 0 
0aad : 8a __ __ TXA
0aae : 0a __ __ ASL
0aaf : 2a __ __ ROL
0ab0 : 29 01 __ AND #$01
0ab2 : 2a __ __ ROL
0ab3 : 49 03 __ EOR #$03
0ab5 : 05 1b __ ORA ACCU + 0 
0ab7 : 8d 00 dd STA $dd00 
0aba : 8a __ __ TXA
0abb : 0a __ __ ASL
0abc : 0a __ __ ASL
0abd : 29 f0 __ AND #$f0
0abf : 85 1b __ STA ACCU + 0 
0ac1 : a5 11 __ LDA P4 ; (font + 1)
0ac3 : 4a __ __ LSR
0ac4 : 4a __ __ LSR
0ac5 : 29 0e __ AND #$0e
0ac7 : 05 1b __ ORA ACCU + 0 
0ac9 : 8d 18 d0 STA $d018 
.s1001:
0acc : 60 __ __ RTS
.s17:
0acd : a9 1b __ LDA #$1b
0acf : 8d 11 d0 STA $d011 
0ad2 : 98 __ __ TYA
0ad3 : d0 cc __ BNE $0aa1 ; (vic_setmode.s1009 + 0)
0ad5 : 4c 9d 0a JMP $0a9d ; (vic_setmode.s23 + 0)
--------------------------------------------------------------------
sprintf:
.s1000:
0ad8 : a5 53 __ LDA T0 + 0 
0ada : 8d d8 9f STA $9fd8 ; (sprintf@stack + 0)
0add : a5 54 __ LDA T0 + 1 
0adf : 8d d9 9f STA $9fd9 ; (sprintf@stack + 1)
.s0:
0ae2 : a9 00 __ LDA #$00
0ae4 : 8d ff 9f STA $9fff ; (sstack + 7)
0ae7 : a0 03 __ LDY #$03
0ae9 : b1 23 __ LDA (SP + 0),y 
0aeb : 85 54 __ STA T0 + 1 
0aed : 8d fa 9f STA $9ffa ; (sstack + 2)
0af0 : 88 __ __ DEY
0af1 : b1 23 __ LDA (SP + 0),y 
0af3 : 85 53 __ STA T0 + 0 
0af5 : 8d f9 9f STA $9ff9 ; (sstack + 1)
0af8 : a0 04 __ LDY #$04
0afa : b1 23 __ LDA (SP + 0),y 
0afc : 8d fb 9f STA $9ffb ; (sstack + 3)
0aff : c8 __ __ INY
0b00 : b1 23 __ LDA (SP + 0),y 
0b02 : 8d fc 9f STA $9ffc ; (sstack + 4)
0b05 : 18 __ __ CLC
0b06 : a5 23 __ LDA SP + 0 
0b08 : 69 06 __ ADC #$06
0b0a : 8d fd 9f STA $9ffd ; (sstack + 5)
0b0d : a5 24 __ LDA SP + 1 
0b0f : 69 00 __ ADC #$00
0b11 : 8d fe 9f STA $9ffe ; (sstack + 6)
0b14 : 20 2f 0b JSR $0b2f ; (sformat.s1000 + 0)
0b17 : 38 __ __ SEC
0b18 : a5 1b __ LDA ACCU + 0 
0b1a : e5 53 __ SBC T0 + 0 
0b1c : 85 1b __ STA ACCU + 0 
0b1e : a5 1c __ LDA ACCU + 1 
0b20 : e5 54 __ SBC T0 + 1 
0b22 : 85 1c __ STA ACCU + 1 
.s1001:
0b24 : ad d8 9f LDA $9fd8 ; (sprintf@stack + 0)
0b27 : 85 53 __ STA T0 + 0 
0b29 : ad d9 9f LDA $9fd9 ; (sprintf@stack + 1)
0b2c : 85 54 __ STA T0 + 1 
0b2e : 60 __ __ RTS
--------------------------------------------------------------------
sformat:
.s1000:
0b2f : a2 05 __ LDX #$05
0b31 : b5 53 __ LDA T1 + 0,x 
0b33 : 9d da 9f STA $9fda,x ; (sformat@stack + 0)
0b36 : ca __ __ DEX
0b37 : 10 f8 __ BPL $0b31 ; (sformat.s1000 + 2)
.s0:
0b39 : a9 00 __ LDA #$00
0b3b : 85 50 __ STA T0 + 0 
0b3d : ad fb 9f LDA $9ffb ; (sstack + 3)
0b40 : 85 53 __ STA T1 + 0 
0b42 : ad fc 9f LDA $9ffc ; (sstack + 4)
0b45 : 85 54 __ STA T1 + 1 
0b47 : ad f9 9f LDA $9ff9 ; (sstack + 1)
0b4a : 85 55 __ STA T2 + 0 
0b4c : ad fa 9f LDA $9ffa ; (sstack + 2)
0b4f : 85 56 __ STA T2 + 1 
.l1:
0b51 : a0 00 __ LDY #$00
0b53 : b1 53 __ LDA (T1 + 0),y 
0b55 : d0 38 __ BNE $0b8f ; (sformat.s2 + 0)
.s3:
0b57 : a4 50 __ LDY T0 + 0 
0b59 : 91 55 __ STA (T2 + 0),y 
0b5b : 98 __ __ TYA
0b5c : f0 28 __ BEQ $0b86 ; (sformat.s1061 + 0)
.s112:
0b5e : ad ff 9f LDA $9fff ; (sstack + 7)
0b61 : d0 18 __ BNE $0b7b ; (sformat.s115 + 0)
.s116:
0b63 : 18 __ __ CLC
0b64 : a5 55 __ LDA T2 + 0 
0b66 : 65 50 __ ADC T0 + 0 
0b68 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0b6a : a5 56 __ LDA T2 + 1 
0b6c : 69 00 __ ADC #$00
.s1001:
0b6e : 85 1c __ STA ACCU + 1 ; (fmt + 0)
0b70 : a2 05 __ LDX #$05
0b72 : bd da 9f LDA $9fda,x ; (sformat@stack + 0)
0b75 : 95 53 __ STA T1 + 0,x 
0b77 : ca __ __ DEX
0b78 : 10 f8 __ BPL $0b72 ; (sformat.s1001 + 4)
0b7a : 60 __ __ RTS
.s115:
0b7b : a5 55 __ LDA T2 + 0 
0b7d : 85 0d __ STA P0 
0b7f : a5 56 __ LDA T2 + 1 
0b81 : 85 0e __ STA P1 
0b83 : 20 73 0f JSR $0f73 ; (puts.s0 + 0)
.s1061:
0b86 : a5 55 __ LDA T2 + 0 
0b88 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0b8a : a5 56 __ LDA T2 + 1 
0b8c : 4c 6e 0b JMP $0b6e ; (sformat.s1001 + 0)
.s2:
0b8f : c9 25 __ CMP #$25
0b91 : f0 3f __ BEQ $0bd2 ; (sformat.s4 + 0)
.s5:
0b93 : a4 50 __ LDY T0 + 0 
0b95 : 91 55 __ STA (T2 + 0),y 
0b97 : e6 53 __ INC T1 + 0 
0b99 : d0 02 __ BNE $0b9d ; (sformat.s1090 + 0)
.s1089:
0b9b : e6 54 __ INC T1 + 1 
.s1090:
0b9d : c8 __ __ INY
0b9e : 84 50 __ STY T0 + 0 
0ba0 : 98 __ __ TYA
0ba1 : c0 28 __ CPY #$28
0ba3 : 90 ac __ BCC $0b51 ; (sformat.l1 + 0)
.s106:
0ba5 : 85 57 __ STA T5 + 0 
0ba7 : a9 00 __ LDA #$00
0ba9 : 85 50 __ STA T0 + 0 
0bab : ad ff 9f LDA $9fff ; (sstack + 7)
0bae : f0 14 __ BEQ $0bc4 ; (sformat.s110 + 0)
.s109:
0bb0 : a5 55 __ LDA T2 + 0 
0bb2 : 85 0d __ STA P0 
0bb4 : a5 56 __ LDA T2 + 1 
0bb6 : 85 0e __ STA P1 
0bb8 : a9 00 __ LDA #$00
0bba : a4 57 __ LDY T5 + 0 
0bbc : 91 0d __ STA (P0),y 
0bbe : 20 73 0f JSR $0f73 ; (puts.s0 + 0)
0bc1 : 4c 51 0b JMP $0b51 ; (sformat.l1 + 0)
.s110:
0bc4 : 18 __ __ CLC
0bc5 : a5 55 __ LDA T2 + 0 
0bc7 : 65 57 __ ADC T5 + 0 
0bc9 : 85 55 __ STA T2 + 0 
0bcb : 90 84 __ BCC $0b51 ; (sformat.l1 + 0)
.s1092:
0bcd : e6 56 __ INC T2 + 1 
0bcf : 4c 51 0b JMP $0b51 ; (sformat.l1 + 0)
.s4:
0bd2 : a5 50 __ LDA T0 + 0 
0bd4 : f0 27 __ BEQ $0bfd ; (sformat.s9 + 0)
.s7:
0bd6 : 84 50 __ STY T0 + 0 
0bd8 : 85 57 __ STA T5 + 0 
0bda : ad ff 9f LDA $9fff ; (sstack + 7)
0bdd : f0 13 __ BEQ $0bf2 ; (sformat.s11 + 0)
.s10:
0bdf : a5 55 __ LDA T2 + 0 
0be1 : 85 0d __ STA P0 
0be3 : a5 56 __ LDA T2 + 1 
0be5 : 85 0e __ STA P1 
0be7 : 98 __ __ TYA
0be8 : a4 57 __ LDY T5 + 0 
0bea : 91 0d __ STA (P0),y 
0bec : 20 73 0f JSR $0f73 ; (puts.s0 + 0)
0bef : 4c fd 0b JMP $0bfd ; (sformat.s9 + 0)
.s11:
0bf2 : 18 __ __ CLC
0bf3 : a5 55 __ LDA T2 + 0 
0bf5 : 65 57 __ ADC T5 + 0 
0bf7 : 85 55 __ STA T2 + 0 
0bf9 : 90 02 __ BCC $0bfd ; (sformat.s9 + 0)
.s1087:
0bfb : e6 56 __ INC T2 + 1 
.s9:
0bfd : a9 0a __ LDA #$0a
0bff : 8d e3 9f STA $9fe3 ; (si + 3)
0c02 : a9 00 __ LDA #$00
0c04 : 8d e4 9f STA $9fe4 ; (si + 4)
0c07 : 8d e5 9f STA $9fe5 ; (si + 5)
0c0a : 8d e6 9f STA $9fe6 ; (si + 6)
0c0d : 8d e7 9f STA $9fe7 ; (si + 7)
0c10 : a0 01 __ LDY #$01
0c12 : b1 53 __ LDA (T1 + 0),y 
0c14 : aa __ __ TAX
0c15 : a9 20 __ LDA #$20
0c17 : 8d e0 9f STA $9fe0 ; (si + 0)
0c1a : a9 00 __ LDA #$00
0c1c : 8d e1 9f STA $9fe1 ; (si + 1)
0c1f : a9 ff __ LDA #$ff
0c21 : 8d e2 9f STA $9fe2 ; (si + 2)
0c24 : 18 __ __ CLC
0c25 : a5 53 __ LDA T1 + 0 
0c27 : 69 02 __ ADC #$02
.l14:
0c29 : 85 53 __ STA T1 + 0 
0c2b : 90 02 __ BCC $0c2f ; (sformat.s1074 + 0)
.s1073:
0c2d : e6 54 __ INC T1 + 1 
.s1074:
0c2f : 8a __ __ TXA
0c30 : e0 2b __ CPX #$2b
0c32 : d0 08 __ BNE $0c3c ; (sformat.s17 + 0)
.s16:
0c34 : a9 01 __ LDA #$01
0c36 : 8d e5 9f STA $9fe5 ; (si + 5)
0c39 : 4c 66 0f JMP $0f66 ; (sformat.s224 + 0)
.s17:
0c3c : c9 30 __ CMP #$30
0c3e : d0 06 __ BNE $0c46 ; (sformat.s20 + 0)
.s19:
0c40 : 8d e0 9f STA $9fe0 ; (si + 0)
0c43 : 4c 66 0f JMP $0f66 ; (sformat.s224 + 0)
.s20:
0c46 : e0 23 __ CPX #$23
0c48 : d0 08 __ BNE $0c52 ; (sformat.s23 + 0)
.s22:
0c4a : a9 01 __ LDA #$01
0c4c : 8d e7 9f STA $9fe7 ; (si + 7)
0c4f : 4c 66 0f JMP $0f66 ; (sformat.s224 + 0)
.s23:
0c52 : e0 2d __ CPX #$2d
0c54 : d0 08 __ BNE $0c5e ; (sformat.s15 + 0)
.s25:
0c56 : a9 01 __ LDA #$01
0c58 : 8d e6 9f STA $9fe6 ; (si + 6)
0c5b : 4c 66 0f JMP $0f66 ; (sformat.s224 + 0)
.s15:
0c5e : 86 57 __ STX T5 + 0 
0c60 : e0 30 __ CPX #$30
0c62 : 90 53 __ BCC $0cb7 ; (sformat.s31 + 0)
.s32:
0c64 : e0 3a __ CPX #$3a
0c66 : b0 4f __ BCS $0cb7 ; (sformat.s31 + 0)
.s29:
0c68 : a9 00 __ LDA #$00
0c6a : 85 44 __ STA T6 + 0 
0c6c : 85 45 __ STA T6 + 1 
0c6e : e0 3a __ CPX #$3a
0c70 : b0 40 __ BCS $0cb2 ; (sformat.s35 + 0)
.l34:
0c72 : a5 44 __ LDA T6 + 0 
0c74 : 0a __ __ ASL
0c75 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0c77 : a5 45 __ LDA T6 + 1 
0c79 : 2a __ __ ROL
0c7a : 06 1b __ ASL ACCU + 0 ; (buff + 1)
0c7c : 2a __ __ ROL
0c7d : aa __ __ TAX
0c7e : 18 __ __ CLC
0c7f : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0c81 : 65 44 __ ADC T6 + 0 
0c83 : 85 44 __ STA T6 + 0 
0c85 : 8a __ __ TXA
0c86 : 65 45 __ ADC T6 + 1 
0c88 : 06 44 __ ASL T6 + 0 
0c8a : 2a __ __ ROL
0c8b : aa __ __ TAX
0c8c : 18 __ __ CLC
0c8d : a5 44 __ LDA T6 + 0 
0c8f : 65 57 __ ADC T5 + 0 
0c91 : 90 01 __ BCC $0c94 ; (sformat.s1084 + 0)
.s1083:
0c93 : e8 __ __ INX
.s1084:
0c94 : 38 __ __ SEC
0c95 : e9 30 __ SBC #$30
0c97 : 85 44 __ STA T6 + 0 
0c99 : 8a __ __ TXA
0c9a : e9 00 __ SBC #$00
0c9c : 85 45 __ STA T6 + 1 
0c9e : a0 00 __ LDY #$00
0ca0 : b1 53 __ LDA (T1 + 0),y 
0ca2 : 85 57 __ STA T5 + 0 
0ca4 : e6 53 __ INC T1 + 0 
0ca6 : d0 02 __ BNE $0caa ; (sformat.s1086 + 0)
.s1085:
0ca8 : e6 54 __ INC T1 + 1 
.s1086:
0caa : c9 30 __ CMP #$30
0cac : 90 04 __ BCC $0cb2 ; (sformat.s35 + 0)
.s36:
0cae : c9 3a __ CMP #$3a
0cb0 : 90 c0 __ BCC $0c72 ; (sformat.l34 + 0)
.s35:
0cb2 : a5 44 __ LDA T6 + 0 
0cb4 : 8d e1 9f STA $9fe1 ; (si + 1)
.s31:
0cb7 : a5 57 __ LDA T5 + 0 
0cb9 : c9 2e __ CMP #$2e
0cbb : d0 51 __ BNE $0d0e ; (sformat.s39 + 0)
.s37:
0cbd : a9 00 __ LDA #$00
0cbf : 85 44 __ STA T6 + 0 
.l203:
0cc1 : 85 45 __ STA T6 + 1 
0cc3 : a0 00 __ LDY #$00
0cc5 : b1 53 __ LDA (T1 + 0),y 
0cc7 : 85 57 __ STA T5 + 0 
0cc9 : e6 53 __ INC T1 + 0 
0ccb : d0 02 __ BNE $0ccf ; (sformat.s1076 + 0)
.s1075:
0ccd : e6 54 __ INC T1 + 1 
.s1076:
0ccf : c9 30 __ CMP #$30
0cd1 : 90 04 __ BCC $0cd7 ; (sformat.s42 + 0)
.s43:
0cd3 : c9 3a __ CMP #$3a
0cd5 : 90 0a __ BCC $0ce1 ; (sformat.s41 + 0)
.s42:
0cd7 : a5 44 __ LDA T6 + 0 
0cd9 : 8d e2 9f STA $9fe2 ; (si + 2)
0cdc : a5 57 __ LDA T5 + 0 
0cde : 4c 0e 0d JMP $0d0e ; (sformat.s39 + 0)
.s41:
0ce1 : a5 44 __ LDA T6 + 0 
0ce3 : 0a __ __ ASL
0ce4 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0ce6 : a5 45 __ LDA T6 + 1 
0ce8 : 2a __ __ ROL
0ce9 : 06 1b __ ASL ACCU + 0 ; (buff + 1)
0ceb : 2a __ __ ROL
0cec : aa __ __ TAX
0ced : 18 __ __ CLC
0cee : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0cf0 : 65 44 __ ADC T6 + 0 
0cf2 : 85 44 __ STA T6 + 0 
0cf4 : 8a __ __ TXA
0cf5 : 65 45 __ ADC T6 + 1 
0cf7 : 06 44 __ ASL T6 + 0 
0cf9 : 2a __ __ ROL
0cfa : aa __ __ TAX
0cfb : 18 __ __ CLC
0cfc : a5 44 __ LDA T6 + 0 
0cfe : 65 57 __ ADC T5 + 0 
0d00 : 90 01 __ BCC $0d03 ; (sformat.s1082 + 0)
.s1081:
0d02 : e8 __ __ INX
.s1082:
0d03 : 38 __ __ SEC
0d04 : e9 30 __ SBC #$30
0d06 : 85 44 __ STA T6 + 0 
0d08 : 8a __ __ TXA
0d09 : e9 00 __ SBC #$00
0d0b : 4c c1 0c JMP $0cc1 ; (sformat.l203 + 0)
.s39:
0d0e : c9 64 __ CMP #$64
0d10 : d0 05 __ BNE $0d17 ; (sformat.s45 + 0)
.s44:
0d12 : a9 01 __ LDA #$01
0d14 : 4c 2a 0f JMP $0f2a ; (sformat.s221 + 0)
.s45:
0d17 : c9 75 __ CMP #$75
0d19 : d0 03 __ BNE $0d1e ; (sformat.s48 + 0)
0d1b : 4c 28 0f JMP $0f28 ; (sformat.s250 + 0)
.s48:
0d1e : c9 78 __ CMP #$78
0d20 : d0 0d __ BNE $0d2f ; (sformat.s51 + 0)
.s50:
0d22 : a9 10 __ LDA #$10
0d24 : 8d e3 9f STA $9fe3 ; (si + 3)
0d27 : a9 00 __ LDA #$00
0d29 : 8d e4 9f STA $9fe4 ; (si + 4)
0d2c : 4c 28 0f JMP $0f28 ; (sformat.s250 + 0)
.s51:
0d2f : c9 6c __ CMP #$6c
0d31 : d0 03 __ BNE $0d36 ; (sformat.s54 + 0)
0d33 : 4c a3 0e JMP $0ea3 ; (sformat.s53 + 0)
.s54:
0d36 : c9 66 __ CMP #$66
0d38 : f0 08 __ BEQ $0d42 ; (sformat.s65 + 0)
.s69:
0d3a : c9 67 __ CMP #$67
0d3c : f0 04 __ BEQ $0d42 ; (sformat.s65 + 0)
.s68:
0d3e : c9 65 __ CMP #$65
0d40 : d0 4d __ BNE $0d8f ; (sformat.s66 + 0)
.s65:
0d42 : a5 55 __ LDA T2 + 0 
0d44 : 85 13 __ STA P6 
0d46 : a5 56 __ LDA T2 + 1 
0d48 : 85 14 __ STA P7 
0d4a : a5 57 __ LDA T5 + 0 
0d4c : 8d f8 9f STA $9ff8 ; (sstack + 0)
0d4f : a9 e0 __ LDA #$e0
0d51 : 85 11 __ STA P4 
0d53 : a9 9f __ LDA #$9f
0d55 : 85 12 __ STA P5 
0d57 : ad fd 9f LDA $9ffd ; (sstack + 5)
0d5a : 85 57 __ STA T5 + 0 
0d5c : ad fe 9f LDA $9ffe ; (sstack + 6)
0d5f : 85 58 __ STA T5 + 1 
0d61 : a0 00 __ LDY #$00
0d63 : b1 57 __ LDA (T5 + 0),y 
0d65 : 85 15 __ STA P8 
0d67 : c8 __ __ INY
0d68 : b1 57 __ LDA (T5 + 0),y 
0d6a : 85 16 __ STA P9 
0d6c : c8 __ __ INY
0d6d : b1 57 __ LDA (T5 + 0),y 
0d6f : 85 17 __ STA P10 
0d71 : c8 __ __ INY
0d72 : b1 57 __ LDA (T5 + 0),y 
0d74 : 85 18 __ STA P11 
0d76 : 20 bf 12 JSR $12bf ; (nformf.s0 + 0)
0d79 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0d7b : 85 50 __ STA T0 + 0 
0d7d : 18 __ __ CLC
0d7e : a5 57 __ LDA T5 + 0 
0d80 : 69 04 __ ADC #$04
0d82 : 8d fd 9f STA $9ffd ; (sstack + 5)
0d85 : a5 58 __ LDA T5 + 1 
0d87 : 69 00 __ ADC #$00
0d89 : 8d fe 9f STA $9ffe ; (sstack + 6)
0d8c : 4c 51 0b JMP $0b51 ; (sformat.l1 + 0)
.s66:
0d8f : c9 73 __ CMP #$73
0d91 : f0 4c __ BEQ $0ddf ; (sformat.s70 + 0)
.s71:
0d93 : c9 63 __ CMP #$63
0d95 : f0 1f __ BEQ $0db6 ; (sformat.s100 + 0)
.s101:
0d97 : 09 00 __ ORA #$00
0d99 : d0 03 __ BNE $0d9e ; (sformat.s103 + 0)
0d9b : 4c 51 0b JMP $0b51 ; (sformat.l1 + 0)
.s103:
0d9e : 18 __ __ CLC
0d9f : a5 55 __ LDA T2 + 0 
0da1 : 65 50 __ ADC T0 + 0 
0da3 : 85 44 __ STA T6 + 0 
0da5 : a5 56 __ LDA T2 + 1 
0da7 : 69 00 __ ADC #$00
0da9 : 85 45 __ STA T6 + 1 
0dab : a5 57 __ LDA T5 + 0 
.s1059:
0dad : a0 00 __ LDY #$00
0daf : 91 44 __ STA (T6 + 0),y 
0db1 : e6 50 __ INC T0 + 0 
0db3 : 4c 51 0b JMP $0b51 ; (sformat.l1 + 0)
.s100:
0db6 : ad fd 9f LDA $9ffd ; (sstack + 5)
0db9 : 85 57 __ STA T5 + 0 
0dbb : 18 __ __ CLC
0dbc : 69 02 __ ADC #$02
0dbe : 8d fd 9f STA $9ffd ; (sstack + 5)
0dc1 : ad fe 9f LDA $9ffe ; (sstack + 6)
0dc4 : 85 58 __ STA T5 + 1 
0dc6 : 69 00 __ ADC #$00
0dc8 : 8d fe 9f STA $9ffe ; (sstack + 6)
0dcb : 18 __ __ CLC
0dcc : a5 55 __ LDA T2 + 0 
0dce : 65 50 __ ADC T0 + 0 
0dd0 : 85 44 __ STA T6 + 0 
0dd2 : a5 56 __ LDA T2 + 1 
0dd4 : 69 00 __ ADC #$00
0dd6 : 85 45 __ STA T6 + 1 
0dd8 : a0 00 __ LDY #$00
0dda : b1 57 __ LDA (T5 + 0),y 
0ddc : 4c ad 0d JMP $0dad ; (sformat.s1059 + 0)
.s70:
0ddf : ad fd 9f LDA $9ffd ; (sstack + 5)
0de2 : 85 57 __ STA T5 + 0 
0de4 : 18 __ __ CLC
0de5 : 69 02 __ ADC #$02
0de7 : 8d fd 9f STA $9ffd ; (sstack + 5)
0dea : ad fe 9f LDA $9ffe ; (sstack + 6)
0ded : 85 58 __ STA T5 + 1 
0def : 69 00 __ ADC #$00
0df1 : 8d fe 9f STA $9ffe ; (sstack + 6)
0df4 : a0 00 __ LDY #$00
0df6 : b1 57 __ LDA (T5 + 0),y 
0df8 : aa __ __ TAX
0df9 : c8 __ __ INY
0dfa : b1 57 __ LDA (T5 + 0),y 
0dfc : 86 57 __ STX T5 + 0 
0dfe : 85 58 __ STA T5 + 1 
0e00 : a9 00 __ LDA #$00
0e02 : 85 52 __ STA T3 + 0 
0e04 : ad e1 9f LDA $9fe1 ; (si + 1)
0e07 : f0 0c __ BEQ $0e15 ; (sformat.s75 + 0)
.s1065:
0e09 : 88 __ __ DEY
0e0a : b1 57 __ LDA (T5 + 0),y 
0e0c : f0 05 __ BEQ $0e13 ; (sformat.s1066 + 0)
.l77:
0e0e : c8 __ __ INY
0e0f : b1 57 __ LDA (T5 + 0),y 
0e11 : d0 fb __ BNE $0e0e ; (sformat.l77 + 0)
.s1066:
0e13 : 84 52 __ STY T3 + 0 
.s75:
0e15 : ad e6 9f LDA $9fe6 ; (si + 6)
0e18 : d0 19 __ BNE $0e33 ; (sformat.s81 + 0)
.s1069:
0e1a : a6 52 __ LDX T3 + 0 
0e1c : ec e1 9f CPX $9fe1 ; (si + 1)
0e1f : a4 50 __ LDY T0 + 0 
0e21 : b0 0c __ BCS $0e2f ; (sformat.s1070 + 0)
.l83:
0e23 : ad e0 9f LDA $9fe0 ; (si + 0)
0e26 : 91 55 __ STA (T2 + 0),y 
0e28 : e8 __ __ INX
0e29 : ec e1 9f CPX $9fe1 ; (si + 1)
0e2c : c8 __ __ INY
0e2d : 90 f4 __ BCC $0e23 ; (sformat.l83 + 0)
.s1070:
0e2f : 86 52 __ STX T3 + 0 
0e31 : 84 50 __ STY T0 + 0 
.s81:
0e33 : ad ff 9f LDA $9fff ; (sstack + 7)
0e36 : d0 37 __ BNE $0e6f ; (sformat.s85 + 0)
.l91:
0e38 : a0 00 __ LDY #$00
0e3a : b1 57 __ LDA (T5 + 0),y 
0e3c : f0 0f __ BEQ $0e4d ; (sformat.s211 + 0)
.s92:
0e3e : a4 50 __ LDY T0 + 0 
0e40 : 91 55 __ STA (T2 + 0),y 
0e42 : e6 50 __ INC T0 + 0 
0e44 : e6 57 __ INC T5 + 0 
0e46 : d0 f0 __ BNE $0e38 ; (sformat.l91 + 0)
.s1079:
0e48 : e6 58 __ INC T5 + 1 
0e4a : 4c 38 0e JMP $0e38 ; (sformat.l91 + 0)
.s211:
0e4d : ad e6 9f LDA $9fe6 ; (si + 6)
0e50 : d0 03 __ BNE $0e55 ; (sformat.s1067 + 0)
0e52 : 4c 51 0b JMP $0b51 ; (sformat.l1 + 0)
.s1067:
0e55 : a6 52 __ LDX T3 + 0 
0e57 : ec e1 9f CPX $9fe1 ; (si + 1)
0e5a : a4 50 __ LDY T0 + 0 
0e5c : b0 0c __ BCS $0e6a ; (sformat.s1068 + 0)
.l98:
0e5e : ad e0 9f LDA $9fe0 ; (si + 0)
0e61 : 91 55 __ STA (T2 + 0),y 
0e63 : e8 __ __ INX
0e64 : ec e1 9f CPX $9fe1 ; (si + 1)
0e67 : c8 __ __ INY
0e68 : 90 f4 __ BCC $0e5e ; (sformat.l98 + 0)
.s1068:
0e6a : 84 50 __ STY T0 + 0 
0e6c : 4c 51 0b JMP $0b51 ; (sformat.l1 + 0)
.s85:
0e6f : a5 50 __ LDA T0 + 0 
0e71 : f0 22 __ BEQ $0e95 ; (sformat.s90 + 0)
.s88:
0e73 : a5 55 __ LDA T2 + 0 
0e75 : 85 0d __ STA P0 
0e77 : a5 56 __ LDA T2 + 1 
0e79 : 85 0e __ STA P1 
0e7b : a9 00 __ LDA #$00
0e7d : a4 50 __ LDY T0 + 0 
0e7f : 91 0d __ STA (P0),y 
0e81 : 20 73 0f JSR $0f73 ; (puts.s0 + 0)
0e84 : a5 57 __ LDA T5 + 0 
0e86 : 85 0d __ STA P0 
0e88 : a5 58 __ LDA T5 + 1 
0e8a : 85 0e __ STA P1 
0e8c : 20 73 0f JSR $0f73 ; (puts.s0 + 0)
0e8f : a9 00 __ LDA #$00
0e91 : 85 50 __ STA T0 + 0 
0e93 : f0 b8 __ BEQ $0e4d ; (sformat.s211 + 0)
.s90:
0e95 : a5 57 __ LDA T5 + 0 
0e97 : 85 0d __ STA P0 
0e99 : a5 58 __ LDA T5 + 1 
0e9b : 85 0e __ STA P1 
0e9d : 20 73 0f JSR $0f73 ; (puts.s0 + 0)
0ea0 : 4c 4d 0e JMP $0e4d ; (sformat.s211 + 0)
.s53:
0ea3 : ad fd 9f LDA $9ffd ; (sstack + 5)
0ea6 : 85 57 __ STA T5 + 0 
0ea8 : 18 __ __ CLC
0ea9 : 69 04 __ ADC #$04
0eab : 8d fd 9f STA $9ffd ; (sstack + 5)
0eae : ad fe 9f LDA $9ffe ; (sstack + 6)
0eb1 : 85 58 __ STA T5 + 1 
0eb3 : 69 00 __ ADC #$00
0eb5 : 8d fe 9f STA $9ffe ; (sstack + 6)
0eb8 : a0 00 __ LDY #$00
0eba : b1 53 __ LDA (T1 + 0),y 
0ebc : 85 52 __ STA T3 + 0 
0ebe : e6 53 __ INC T1 + 0 
0ec0 : d0 02 __ BNE $0ec4 ; (sformat.s1078 + 0)
.s1077:
0ec2 : e6 54 __ INC T1 + 1 
.s1078:
0ec4 : c9 64 __ CMP #$64
0ec6 : d0 04 __ BNE $0ecc ; (sformat.s1019 + 0)
.s1018:
0ec8 : a2 01 __ LDX #$01
0eca : d0 02 __ BNE $0ece ; (sformat.s1020 + 0)
.s1019:
0ecc : a2 00 __ LDX #$00
.s1020:
0ece : b1 57 __ LDA (T5 + 0),y 
0ed0 : 85 46 __ STA T7 + 0 
0ed2 : a0 01 __ LDY #$01
0ed4 : b1 57 __ LDA (T5 + 0),y 
0ed6 : 85 47 __ STA T7 + 1 
0ed8 : c8 __ __ INY
0ed9 : b1 57 __ LDA (T5 + 0),y 
0edb : 85 48 __ STA T7 + 2 
0edd : c8 __ __ INY
0ede : b1 57 __ LDA (T5 + 0),y 
0ee0 : a8 __ __ TAY
0ee1 : 8a __ __ TXA
0ee2 : f0 04 __ BEQ $0ee8 ; (sformat.s57 + 0)
.s56:
0ee4 : a9 01 __ LDA #$01
0ee6 : d0 16 __ BNE $0efe ; (sformat.s222 + 0)
.s57:
0ee8 : a5 52 __ LDA T3 + 0 
0eea : c9 75 __ CMP #$75
0eec : f0 0f __ BEQ $0efd ; (sformat.s251 + 0)
.s60:
0eee : c9 78 __ CMP #$78
0ef0 : f0 03 __ BEQ $0ef5 ; (sformat.s62 + 0)
0ef2 : 4c 51 0b JMP $0b51 ; (sformat.l1 + 0)
.s62:
0ef5 : 8e e4 9f STX $9fe4 ; (si + 4)
0ef8 : a9 10 __ LDA #$10
0efa : 8d e3 9f STA $9fe3 ; (si + 3)
.s251:
0efd : 8a __ __ TXA
.s222:
0efe : 84 14 __ STY P7 
0f00 : 85 15 __ STA P8 
0f02 : a5 55 __ LDA T2 + 0 
0f04 : 85 0f __ STA P2 
0f06 : a5 56 __ LDA T2 + 1 
0f08 : 85 10 __ STA P3 
0f0a : a5 46 __ LDA T7 + 0 
0f0c : 85 11 __ STA P4 
0f0e : a5 47 __ LDA T7 + 1 
0f10 : 85 12 __ STA P5 
0f12 : a5 48 __ LDA T7 + 2 
0f14 : 85 13 __ STA P6 
0f16 : a9 e0 __ LDA #$e0
0f18 : 85 0d __ STA P0 
0f1a : a9 9f __ LDA #$9f
0f1c : 85 0e __ STA P1 
0f1e : 20 27 11 JSR $1127 ; (nforml.s0 + 0)
.s1062:
0f21 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0f23 : 85 50 __ STA T0 + 0 
0f25 : 4c 51 0b JMP $0b51 ; (sformat.l1 + 0)
.s250:
0f28 : a9 00 __ LDA #$00
.s221:
0f2a : 85 13 __ STA P6 
0f2c : a5 55 __ LDA T2 + 0 
0f2e : 85 0f __ STA P2 
0f30 : a5 56 __ LDA T2 + 1 
0f32 : 85 10 __ STA P3 
0f34 : ad fd 9f LDA $9ffd ; (sstack + 5)
0f37 : 85 50 __ STA T0 + 0 
0f39 : ad fe 9f LDA $9ffe ; (sstack + 6)
0f3c : 85 51 __ STA T0 + 1 
0f3e : a0 00 __ LDY #$00
0f40 : b1 50 __ LDA (T0 + 0),y 
0f42 : 85 11 __ STA P4 
0f44 : c8 __ __ INY
0f45 : b1 50 __ LDA (T0 + 0),y 
0f47 : 85 12 __ STA P5 
0f49 : 18 __ __ CLC
0f4a : a5 50 __ LDA T0 + 0 
0f4c : 69 02 __ ADC #$02
0f4e : 8d fd 9f STA $9ffd ; (sstack + 5)
0f51 : a5 51 __ LDA T0 + 1 
0f53 : 69 00 __ ADC #$00
0f55 : 8d fe 9f STA $9ffe ; (sstack + 6)
0f58 : a9 e0 __ LDA #$e0
0f5a : 85 0d __ STA P0 
0f5c : a9 9f __ LDA #$9f
0f5e : 85 0e __ STA P1 
0f60 : 20 c8 0f JSR $0fc8 ; (nformi.s0 + 0)
0f63 : 4c 21 0f JMP $0f21 ; (sformat.s1062 + 0)
.s224:
0f66 : a0 00 __ LDY #$00
0f68 : b1 53 __ LDA (T1 + 0),y 
0f6a : aa __ __ TAX
0f6b : 18 __ __ CLC
0f6c : a5 53 __ LDA T1 + 0 
0f6e : 69 01 __ ADC #$01
0f70 : 4c 29 0c JMP $0c29 ; (sformat.l14 + 0)
--------------------------------------------------------------------
puts:
.s0:
0f73 : a0 00 __ LDY #$00
0f75 : b1 0d __ LDA (P0),y 
0f77 : f0 0b __ BEQ $0f84 ; (puts.s1001 + 0)
0f79 : 20 85 0f JSR $0f85 ; (putpch + 0)
0f7c : e6 0d __ INC P0 
0f7e : d0 f3 __ BNE $0f73 ; (puts.s0 + 0)
0f80 : e6 0e __ INC P1 
0f82 : d0 ef __ BNE $0f73 ; (puts.s0 + 0)
.s1001:
0f84 : 60 __ __ RTS
--------------------------------------------------------------------
putpch:
0f85 : ae ff 09 LDX $09ff ; (giocharmap + 0)
0f88 : e0 01 __ CPX #$01
0f8a : 90 26 __ BCC $0fb2 ; (putpch + 45)
0f8c : c9 0a __ CMP #$0a
0f8e : d0 02 __ BNE $0f92 ; (putpch + 13)
0f90 : a9 0d __ LDA #$0d
0f92 : c9 09 __ CMP #$09
0f94 : f0 1f __ BEQ $0fb5 ; (putpch + 48)
0f96 : e0 02 __ CPX #$02
0f98 : 90 18 __ BCC $0fb2 ; (putpch + 45)
0f9a : c9 41 __ CMP #$41
0f9c : 90 14 __ BCC $0fb2 ; (putpch + 45)
0f9e : c9 7b __ CMP #$7b
0fa0 : b0 10 __ BCS $0fb2 ; (putpch + 45)
0fa2 : c9 61 __ CMP #$61
0fa4 : b0 04 __ BCS $0faa ; (putpch + 37)
0fa6 : c9 5b __ CMP #$5b
0fa8 : b0 08 __ BCS $0fb2 ; (putpch + 45)
0faa : 49 20 __ EOR #$20
0fac : e0 03 __ CPX #$03
0fae : f0 02 __ BEQ $0fb2 ; (putpch + 45)
0fb0 : 29 df __ AND #$df
0fb2 : 4c d2 ff JMP $ffd2 
0fb5 : 38 __ __ SEC
0fb6 : 20 f0 ff JSR $fff0 
0fb9 : 98 __ __ TYA
0fba : 29 03 __ AND #$03
0fbc : 49 03 __ EOR #$03
0fbe : aa __ __ TAX
0fbf : a9 20 __ LDA #$20
0fc1 : 20 d2 ff JSR $ffd2 
0fc4 : ca __ __ DEX
0fc5 : 10 fa __ BPL $0fc1 ; (putpch + 60)
0fc7 : 60 __ __ RTS
--------------------------------------------------------------------
giocharmap:
09ff : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
nformi:
.s0:
0fc8 : a9 00 __ LDA #$00
0fca : 85 43 __ STA T0 + 0 
0fcc : a5 13 __ LDA P6 ; (s + 0)
0fce : f0 15 __ BEQ $0fe5 ; (nformi.s159 + 0)
.s4:
0fd0 : a5 12 __ LDA P5 ; (v + 1)
0fd2 : 10 11 __ BPL $0fe5 ; (nformi.s159 + 0)
.s1:
0fd4 : 38 __ __ SEC
0fd5 : a9 00 __ LDA #$00
0fd7 : e5 11 __ SBC P4 ; (v + 0)
0fd9 : 85 11 __ STA P4 ; (v + 0)
0fdb : a9 00 __ LDA #$00
0fdd : e5 12 __ SBC P5 ; (v + 1)
0fdf : 85 12 __ STA P5 ; (v + 1)
0fe1 : a9 01 __ LDA #$01
0fe3 : 85 43 __ STA T0 + 0 
.s159:
0fe5 : a9 10 __ LDA #$10
0fe7 : 85 44 __ STA T2 + 0 
0fe9 : a5 11 __ LDA P4 ; (v + 0)
0feb : 05 12 __ ORA P5 ; (v + 1)
0fed : f0 61 __ BEQ $1050 ; (nformi.s7 + 0)
.s45:
0fef : a5 0d __ LDA P0 ; (si + 0)
0ff1 : 85 45 __ STA T4 + 0 
0ff3 : a5 0e __ LDA P1 ; (si + 1)
0ff5 : 85 46 __ STA T4 + 1 
.l6:
0ff7 : a0 03 __ LDY #$03
0ff9 : b1 45 __ LDA (T4 + 0),y 
0ffb : 85 47 __ STA T5 + 0 
0ffd : 85 03 __ STA WORK + 0 
0fff : c8 __ __ INY
1000 : b1 45 __ LDA (T4 + 0),y 
1002 : 85 48 __ STA T5 + 1 
1004 : 85 04 __ STA WORK + 1 
1006 : a5 11 __ LDA P4 ; (v + 0)
1008 : 85 1b __ STA ACCU + 0 
100a : a5 12 __ LDA P5 ; (v + 1)
100c : 85 1c __ STA ACCU + 1 
100e : 20 14 1b JSR $1b14 ; (divmod + 0)
1011 : a5 06 __ LDA WORK + 3 
1013 : 30 10 __ BMI $1025 ; (nformi.s9 + 0)
.s1019:
1015 : d0 06 __ BNE $101d ; (nformi.s8 + 0)
.s1018:
1017 : a5 05 __ LDA WORK + 2 
1019 : c9 0a __ CMP #$0a
101b : 90 08 __ BCC $1025 ; (nformi.s9 + 0)
.s8:
101d : 18 __ __ CLC
101e : a5 05 __ LDA WORK + 2 
1020 : 69 37 __ ADC #$37
1022 : 4c 2a 10 JMP $102a ; (nformi.s10 + 0)
.s9:
1025 : 18 __ __ CLC
1026 : a5 05 __ LDA WORK + 2 
1028 : 69 30 __ ADC #$30
.s10:
102a : c6 44 __ DEC T2 + 0 
102c : a6 44 __ LDX T2 + 0 
102e : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1031 : a5 11 __ LDA P4 ; (v + 0)
1033 : 85 1b __ STA ACCU + 0 
1035 : a5 12 __ LDA P5 ; (v + 1)
1037 : 85 1c __ STA ACCU + 1 
1039 : a5 47 __ LDA T5 + 0 
103b : 85 03 __ STA WORK + 0 
103d : a5 48 __ LDA T5 + 1 
103f : 85 04 __ STA WORK + 1 
1041 : 20 14 1b JSR $1b14 ; (divmod + 0)
1044 : a5 1b __ LDA ACCU + 0 
1046 : 85 11 __ STA P4 ; (v + 0)
1048 : a5 1c __ LDA ACCU + 1 
104a : 85 12 __ STA P5 ; (v + 1)
104c : 05 11 __ ORA P4 ; (v + 0)
104e : d0 a7 __ BNE $0ff7 ; (nformi.l6 + 0)
.s7:
1050 : a5 0d __ LDA P0 ; (si + 0)
1052 : 85 11 __ STA P4 ; (v + 0)
1054 : a5 0e __ LDA P1 ; (si + 1)
1056 : 85 12 __ STA P5 ; (v + 1)
1058 : a0 02 __ LDY #$02
105a : b1 0d __ LDA (P0),y ; (si + 0)
105c : c9 ff __ CMP #$ff
105e : d0 04 __ BNE $1064 ; (nformi.s76 + 0)
.s77:
1060 : a9 0f __ LDA #$0f
1062 : d0 05 __ BNE $1069 ; (nformi.s1026 + 0)
.s76:
1064 : 38 __ __ SEC
1065 : a9 10 __ LDA #$10
1067 : f1 0d __ SBC (P0),y ; (si + 0)
.s1026:
1069 : a8 __ __ TAY
106a : c4 44 __ CPY T2 + 0 
106c : b0 0d __ BCS $107b ; (nformi.s13 + 0)
.s12:
106e : a9 30 __ LDA #$30
.l1027:
1070 : c6 44 __ DEC T2 + 0 
1072 : a6 44 __ LDX T2 + 0 
1074 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1077 : c4 44 __ CPY T2 + 0 
1079 : 90 f5 __ BCC $1070 ; (nformi.l1027 + 0)
.s13:
107b : a0 07 __ LDY #$07
107d : b1 0d __ LDA (P0),y ; (si + 0)
107f : f0 20 __ BEQ $10a1 ; (nformi.s16 + 0)
.s17:
1081 : a0 04 __ LDY #$04
1083 : b1 0d __ LDA (P0),y ; (si + 0)
1085 : d0 1a __ BNE $10a1 ; (nformi.s16 + 0)
.s1013:
1087 : 88 __ __ DEY
1088 : b1 0d __ LDA (P0),y ; (si + 0)
108a : c9 10 __ CMP #$10
108c : d0 13 __ BNE $10a1 ; (nformi.s16 + 0)
.s14:
108e : a9 58 __ LDA #$58
1090 : a6 44 __ LDX T2 + 0 
1092 : 9d e7 9f STA $9fe7,x ; (si + 7)
1095 : 8a __ __ TXA
1096 : 18 __ __ CLC
1097 : 69 fe __ ADC #$fe
1099 : 85 44 __ STA T2 + 0 
109b : aa __ __ TAX
109c : a9 30 __ LDA #$30
109e : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s16:
10a1 : a9 00 __ LDA #$00
10a3 : 85 1b __ STA ACCU + 0 
10a5 : a5 43 __ LDA T0 + 0 
10a7 : f0 06 __ BEQ $10af ; (nformi.s19 + 0)
.s18:
10a9 : c6 44 __ DEC T2 + 0 
10ab : a9 2d __ LDA #$2d
10ad : d0 0a __ BNE $10b9 ; (nformi.s1025 + 0)
.s19:
10af : a0 05 __ LDY #$05
10b1 : b1 0d __ LDA (P0),y ; (si + 0)
10b3 : f0 09 __ BEQ $10be ; (nformi.s141 + 0)
.s21:
10b5 : c6 44 __ DEC T2 + 0 
10b7 : a9 2b __ LDA #$2b
.s1025:
10b9 : a6 44 __ LDX T2 + 0 
10bb : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s141:
10be : a0 06 __ LDY #$06
10c0 : b1 0d __ LDA (P0),y ; (si + 0)
10c2 : d0 37 __ BNE $10fb ; (nformi.s27 + 0)
.l33:
10c4 : a0 01 __ LDY #$01
10c6 : b1 11 __ LDA (P4),y ; (v + 0)
10c8 : 18 __ __ CLC
10c9 : 65 44 __ ADC T2 + 0 
10cb : b0 04 __ BCS $10d1 ; (nformi.s34 + 0)
.s1006:
10cd : c9 11 __ CMP #$11
10cf : 90 0e __ BCC $10df ; (nformi.s36 + 0)
.s34:
10d1 : c6 44 __ DEC T2 + 0 
10d3 : a0 00 __ LDY #$00
10d5 : b1 11 __ LDA (P4),y ; (v + 0)
10d7 : a6 44 __ LDX T2 + 0 
10d9 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
10dc : 4c c4 10 JMP $10c4 ; (nformi.l33 + 0)
.s36:
10df : a6 44 __ LDX T2 + 0 
10e1 : e0 10 __ CPX #$10
10e3 : b0 11 __ BCS $10f6 ; (nformi.s26 + 0)
.s1022:
10e5 : 88 __ __ DEY
.l1031:
10e6 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
10e9 : 91 0f __ STA (P2),y ; (str + 0)
10eb : e6 44 __ INC T2 + 0 
10ed : a6 44 __ LDX T2 + 0 
10ef : e0 10 __ CPX #$10
10f1 : c8 __ __ INY
10f2 : 90 f2 __ BCC $10e6 ; (nformi.l1031 + 0)
.s1032:
10f4 : 84 1b __ STY ACCU + 0 
.s26:
10f6 : a9 00 __ LDA #$00
10f8 : 85 1c __ STA ACCU + 1 
.s1001:
10fa : 60 __ __ RTS
.s27:
10fb : a6 44 __ LDX T2 + 0 
10fd : e0 10 __ CPX #$10
10ff : b0 12 __ BCS $1113 ; (nformi.l30 + 0)
.s1020:
1101 : a0 00 __ LDY #$00
.l1029:
1103 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
1106 : 91 0f __ STA (P2),y ; (str + 0)
1108 : e6 44 __ INC T2 + 0 
110a : a6 44 __ LDX T2 + 0 
110c : e0 10 __ CPX #$10
110e : c8 __ __ INY
110f : 90 f2 __ BCC $1103 ; (nformi.l1029 + 0)
.s1030:
1111 : 84 1b __ STY ACCU + 0 
.l30:
1113 : a5 1b __ LDA ACCU + 0 
1115 : a0 01 __ LDY #$01
1117 : d1 11 __ CMP (P4),y ; (v + 0)
1119 : b0 db __ BCS $10f6 ; (nformi.s26 + 0)
.s31:
111b : 88 __ __ DEY
111c : b1 11 __ LDA (P4),y ; (v + 0)
111e : a4 1b __ LDY ACCU + 0 
1120 : 91 0f __ STA (P2),y ; (str + 0)
1122 : e6 1b __ INC ACCU + 0 
1124 : 4c 13 11 JMP $1113 ; (nformi.l30 + 0)
--------------------------------------------------------------------
nforml:
.s0:
1127 : a9 00 __ LDA #$00
1129 : 85 43 __ STA T0 + 0 
112b : a5 15 __ LDA P8 ; (s + 0)
112d : f0 23 __ BEQ $1152 ; (nforml.s159 + 0)
.s4:
112f : a5 14 __ LDA P7 ; (v + 3)
1131 : f0 1f __ BEQ $1152 ; (nforml.s159 + 0)
.s1032:
1133 : 10 1d __ BPL $1152 ; (nforml.s159 + 0)
.s1:
1135 : 38 __ __ SEC
1136 : a9 00 __ LDA #$00
1138 : e5 11 __ SBC P4 ; (v + 0)
113a : 85 11 __ STA P4 ; (v + 0)
113c : a9 00 __ LDA #$00
113e : e5 12 __ SBC P5 ; (v + 1)
1140 : 85 12 __ STA P5 ; (v + 1)
1142 : a9 00 __ LDA #$00
1144 : e5 13 __ SBC P6 ; (v + 2)
1146 : 85 13 __ STA P6 ; (v + 2)
1148 : a9 00 __ LDA #$00
114a : e5 14 __ SBC P7 ; (v + 3)
114c : 85 14 __ STA P7 ; (v + 3)
114e : a9 01 __ LDA #$01
1150 : 85 43 __ STA T0 + 0 
.s159:
1152 : a9 10 __ LDA #$10
1154 : 85 44 __ STA T2 + 0 
1156 : a5 14 __ LDA P7 ; (v + 3)
1158 : f0 03 __ BEQ $115d ; (nforml.s1018 + 0)
115a : 4c 41 12 JMP $1241 ; (nforml.l6 + 0)
.s1018:
115d : a5 13 __ LDA P6 ; (v + 2)
115f : f0 03 __ BEQ $1164 ; (nforml.s1019 + 0)
1161 : 4c 41 12 JMP $1241 ; (nforml.l6 + 0)
.s1019:
1164 : a5 12 __ LDA P5 ; (v + 1)
1166 : f0 03 __ BEQ $116b ; (nforml.s1020 + 0)
1168 : 4c 41 12 JMP $1241 ; (nforml.l6 + 0)
.s1020:
116b : c5 11 __ CMP P4 ; (v + 0)
116d : b0 03 __ BCS $1172 ; (nforml.s7 + 0)
116f : 4c 41 12 JMP $1241 ; (nforml.l6 + 0)
.s7:
1172 : a0 02 __ LDY #$02
1174 : b1 0d __ LDA (P0),y ; (si + 0)
1176 : c9 ff __ CMP #$ff
1178 : d0 04 __ BNE $117e ; (nforml.s76 + 0)
.s77:
117a : a9 0f __ LDA #$0f
117c : d0 05 __ BNE $1183 ; (nforml.s1039 + 0)
.s76:
117e : 38 __ __ SEC
117f : a9 10 __ LDA #$10
1181 : f1 0d __ SBC (P0),y ; (si + 0)
.s1039:
1183 : a8 __ __ TAY
1184 : c4 44 __ CPY T2 + 0 
1186 : b0 0d __ BCS $1195 ; (nforml.s13 + 0)
.s12:
1188 : a9 30 __ LDA #$30
.l1040:
118a : c6 44 __ DEC T2 + 0 
118c : a6 44 __ LDX T2 + 0 
118e : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1191 : c4 44 __ CPY T2 + 0 
1193 : 90 f5 __ BCC $118a ; (nforml.l1040 + 0)
.s13:
1195 : a0 07 __ LDY #$07
1197 : b1 0d __ LDA (P0),y ; (si + 0)
1199 : f0 20 __ BEQ $11bb ; (nforml.s16 + 0)
.s17:
119b : a0 04 __ LDY #$04
119d : b1 0d __ LDA (P0),y ; (si + 0)
119f : d0 1a __ BNE $11bb ; (nforml.s16 + 0)
.s1013:
11a1 : 88 __ __ DEY
11a2 : b1 0d __ LDA (P0),y ; (si + 0)
11a4 : c9 10 __ CMP #$10
11a6 : d0 13 __ BNE $11bb ; (nforml.s16 + 0)
.s14:
11a8 : a9 58 __ LDA #$58
11aa : a6 44 __ LDX T2 + 0 
11ac : 9d e7 9f STA $9fe7,x ; (si + 7)
11af : 8a __ __ TXA
11b0 : 18 __ __ CLC
11b1 : 69 fe __ ADC #$fe
11b3 : 85 44 __ STA T2 + 0 
11b5 : aa __ __ TAX
11b6 : a9 30 __ LDA #$30
11b8 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s16:
11bb : a9 00 __ LDA #$00
11bd : 85 1b __ STA ACCU + 0 
11bf : a5 43 __ LDA T0 + 0 
11c1 : f0 06 __ BEQ $11c9 ; (nforml.s19 + 0)
.s18:
11c3 : c6 44 __ DEC T2 + 0 
11c5 : a9 2d __ LDA #$2d
11c7 : d0 0a __ BNE $11d3 ; (nforml.s1038 + 0)
.s19:
11c9 : a0 05 __ LDY #$05
11cb : b1 0d __ LDA (P0),y ; (si + 0)
11cd : f0 09 __ BEQ $11d8 ; (nforml.s141 + 0)
.s21:
11cf : c6 44 __ DEC T2 + 0 
11d1 : a9 2b __ LDA #$2b
.s1038:
11d3 : a6 44 __ LDX T2 + 0 
11d5 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s141:
11d8 : a0 06 __ LDY #$06
11da : b1 0d __ LDA (P0),y ; (si + 0)
11dc : d0 37 __ BNE $1215 ; (nforml.s27 + 0)
.l33:
11de : a0 01 __ LDY #$01
11e0 : b1 0d __ LDA (P0),y ; (si + 0)
11e2 : 18 __ __ CLC
11e3 : 65 44 __ ADC T2 + 0 
11e5 : b0 04 __ BCS $11eb ; (nforml.s34 + 0)
.s1006:
11e7 : c9 11 __ CMP #$11
11e9 : 90 0e __ BCC $11f9 ; (nforml.s36 + 0)
.s34:
11eb : c6 44 __ DEC T2 + 0 
11ed : a0 00 __ LDY #$00
11ef : b1 0d __ LDA (P0),y ; (si + 0)
11f1 : a6 44 __ LDX T2 + 0 
11f3 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
11f6 : 4c de 11 JMP $11de ; (nforml.l33 + 0)
.s36:
11f9 : a6 44 __ LDX T2 + 0 
11fb : e0 10 __ CPX #$10
11fd : b0 11 __ BCS $1210 ; (nforml.s26 + 0)
.s1035:
11ff : 88 __ __ DEY
.l1044:
1200 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
1203 : 91 0f __ STA (P2),y ; (str + 0)
1205 : e6 44 __ INC T2 + 0 
1207 : a6 44 __ LDX T2 + 0 
1209 : e0 10 __ CPX #$10
120b : c8 __ __ INY
120c : 90 f2 __ BCC $1200 ; (nforml.l1044 + 0)
.s1045:
120e : 84 1b __ STY ACCU + 0 
.s26:
1210 : a9 00 __ LDA #$00
1212 : 85 1c __ STA ACCU + 1 
.s1001:
1214 : 60 __ __ RTS
.s27:
1215 : a6 44 __ LDX T2 + 0 
1217 : e0 10 __ CPX #$10
1219 : b0 12 __ BCS $122d ; (nforml.l30 + 0)
.s1033:
121b : a0 00 __ LDY #$00
.l1042:
121d : bd e8 9f LDA $9fe8,x ; (buffer + 0)
1220 : 91 0f __ STA (P2),y ; (str + 0)
1222 : e6 44 __ INC T2 + 0 
1224 : a6 44 __ LDX T2 + 0 
1226 : e0 10 __ CPX #$10
1228 : c8 __ __ INY
1229 : 90 f2 __ BCC $121d ; (nforml.l1042 + 0)
.s1043:
122b : 84 1b __ STY ACCU + 0 
.l30:
122d : a5 1b __ LDA ACCU + 0 
122f : a0 01 __ LDY #$01
1231 : d1 0d __ CMP (P0),y ; (si + 0)
1233 : b0 db __ BCS $1210 ; (nforml.s26 + 0)
.s31:
1235 : 88 __ __ DEY
1236 : b1 0d __ LDA (P0),y ; (si + 0)
1238 : a4 1b __ LDY ACCU + 0 
123a : 91 0f __ STA (P2),y ; (str + 0)
123c : e6 1b __ INC ACCU + 0 
123e : 4c 2d 12 JMP $122d ; (nforml.l30 + 0)
.l6:
1241 : a0 03 __ LDY #$03
1243 : b1 0d __ LDA (P0),y ; (si + 0)
1245 : 85 03 __ STA WORK + 0 
1247 : 85 45 __ STA T6 + 0 
1249 : c8 __ __ INY
124a : b1 0d __ LDA (P0),y ; (si + 0)
124c : 85 46 __ STA T6 + 1 
124e : 85 04 __ STA WORK + 1 
1250 : a5 11 __ LDA P4 ; (v + 0)
1252 : 85 1b __ STA ACCU + 0 
1254 : a5 12 __ LDA P5 ; (v + 1)
1256 : 85 1c __ STA ACCU + 1 
1258 : a5 13 __ LDA P6 ; (v + 2)
125a : 85 1d __ STA ACCU + 2 
125c : a5 14 __ LDA P7 ; (v + 3)
125e : 85 1e __ STA ACCU + 3 
1260 : a9 00 __ LDA #$00
1262 : 85 05 __ STA WORK + 2 
1264 : 85 06 __ STA WORK + 3 
1266 : 20 4f 1c JSR $1c4f ; (divmod32 + 0)
1269 : a5 08 __ LDA WORK + 5 
126b : 30 10 __ BMI $127d ; (nforml.s9 + 0)
.s1023:
126d : d0 06 __ BNE $1275 ; (nforml.s8 + 0)
.s1022:
126f : a5 07 __ LDA WORK + 4 
1271 : c9 0a __ CMP #$0a
1273 : 90 08 __ BCC $127d ; (nforml.s9 + 0)
.s8:
1275 : 18 __ __ CLC
1276 : a5 07 __ LDA WORK + 4 
1278 : 69 37 __ ADC #$37
127a : 4c 82 12 JMP $1282 ; (nforml.s10 + 0)
.s9:
127d : 18 __ __ CLC
127e : a5 07 __ LDA WORK + 4 
1280 : 69 30 __ ADC #$30
.s10:
1282 : c6 44 __ DEC T2 + 0 
1284 : a6 44 __ LDX T2 + 0 
1286 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1289 : a5 11 __ LDA P4 ; (v + 0)
128b : 85 1b __ STA ACCU + 0 
128d : a5 12 __ LDA P5 ; (v + 1)
128f : 85 1c __ STA ACCU + 1 
1291 : a5 13 __ LDA P6 ; (v + 2)
1293 : 85 1d __ STA ACCU + 2 
1295 : a5 14 __ LDA P7 ; (v + 3)
1297 : 85 1e __ STA ACCU + 3 
1299 : a5 45 __ LDA T6 + 0 
129b : 85 03 __ STA WORK + 0 
129d : a5 46 __ LDA T6 + 1 
129f : 85 04 __ STA WORK + 1 
12a1 : a9 00 __ LDA #$00
12a3 : 85 05 __ STA WORK + 2 
12a5 : 85 06 __ STA WORK + 3 
12a7 : 20 4f 1c JSR $1c4f ; (divmod32 + 0)
12aa : a5 1b __ LDA ACCU + 0 
12ac : 85 11 __ STA P4 ; (v + 0)
12ae : a5 1c __ LDA ACCU + 1 
12b0 : 85 12 __ STA P5 ; (v + 1)
12b2 : a5 1d __ LDA ACCU + 2 
12b4 : 85 13 __ STA P6 ; (v + 2)
12b6 : a5 1e __ LDA ACCU + 3 
12b8 : 85 14 __ STA P7 ; (v + 3)
12ba : d0 85 __ BNE $1241 ; (nforml.l6 + 0)
12bc : 4c 5d 11 JMP $115d ; (nforml.s1018 + 0)
--------------------------------------------------------------------
nformf:
.s0:
12bf : a5 15 __ LDA P8 ; (f + 0)
12c1 : 85 43 __ STA T1 + 0 
12c3 : a5 16 __ LDA P9 ; (f + 1)
12c5 : 85 44 __ STA T1 + 1 
12c7 : a5 17 __ LDA P10 ; (f + 2)
12c9 : 85 45 __ STA T1 + 2 
12cb : a5 18 __ LDA P11 ; (f + 3)
12cd : 29 7f __ AND #$7f
12cf : 05 17 __ ORA P10 ; (f + 2)
12d1 : 05 16 __ ORA P9 ; (f + 1)
12d3 : 05 15 __ ORA P8 ; (f + 0)
12d5 : f0 21 __ BEQ $12f8 ; (nformf.s2 + 0)
.s1005:
12d7 : a5 18 __ LDA P11 ; (f + 3)
12d9 : 10 1d __ BPL $12f8 ; (nformf.s2 + 0)
.s1:
12db : a9 2d __ LDA #$2d
12dd : a0 00 __ LDY #$00
12df : 91 13 __ STA (P6),y ; (str + 0)
12e1 : a5 18 __ LDA P11 ; (f + 3)
12e3 : 49 80 __ EOR #$80
12e5 : 85 18 __ STA P11 ; (f + 3)
12e7 : 85 10 __ STA P3 
12e9 : a5 15 __ LDA P8 ; (f + 0)
12eb : 85 0d __ STA P0 
12ed : a5 16 __ LDA P9 ; (f + 1)
12ef : 85 0e __ STA P1 
12f1 : a5 17 __ LDA P10 ; (f + 2)
12f3 : 85 0f __ STA P2 
12f5 : 4c 78 17 JMP $1778 ; (nformf.s189 + 0)
.s2:
12f8 : a5 15 __ LDA P8 ; (f + 0)
12fa : 85 0d __ STA P0 
12fc : a5 16 __ LDA P9 ; (f + 1)
12fe : 85 0e __ STA P1 
1300 : a5 17 __ LDA P10 ; (f + 2)
1302 : 85 0f __ STA P2 
1304 : a5 18 __ LDA P11 ; (f + 3)
1306 : 85 10 __ STA P3 
1308 : a0 05 __ LDY #$05
130a : b1 11 __ LDA (P4),y ; (si + 0)
130c : f0 09 __ BEQ $1317 ; (nformf.s3 + 0)
.s4:
130e : a9 2b __ LDA #$2b
1310 : a0 00 __ LDY #$00
1312 : 91 13 __ STA (P6),y ; (str + 0)
1314 : 4c 78 17 JMP $1778 ; (nformf.s189 + 0)
.s3:
1317 : 20 90 17 JSR $1790 ; (isinf.s0 + 0)
131a : aa __ __ TAX
131b : a9 00 __ LDA #$00
131d : 85 48 __ STA T3 + 0 
131f : 8a __ __ TXA
1320 : f0 0b __ BEQ $132d ; (nformf.s8 + 0)
.s160:
1322 : a9 01 __ LDA #$01
1324 : 85 4a __ STA T5 + 0 
1326 : a9 02 __ LDA #$02
1328 : a0 00 __ LDY #$00
132a : 4c 5c 17 JMP $175c ; (nformf.s7 + 0)
.s8:
132d : a0 02 __ LDY #$02
132f : b1 11 __ LDA (P4),y ; (si + 0)
1331 : c9 ff __ CMP #$ff
1333 : d0 02 __ BNE $1337 ; (nformf.s128 + 0)
.s129:
1335 : a9 06 __ LDA #$06
.s128:
1337 : 86 4a __ STX T5 + 0 
1339 : 86 4b __ STX T5 + 1 
133b : 85 49 __ STA T4 + 0 
133d : 85 47 __ STA T2 + 0 
133f : a5 18 __ LDA P11 ; (f + 3)
1341 : 85 46 __ STA T1 + 3 
1343 : 29 7f __ AND #$7f
1345 : 05 17 __ ORA P10 ; (f + 2)
1347 : 05 16 __ ORA P9 ; (f + 1)
1349 : 05 15 __ ORA P8 ; (f + 0)
134b : f0 03 __ BEQ $1350 ; (nformf.s12 + 0)
134d : 4c 5d 16 JMP $165d ; (nformf.s13 + 0)
.s12:
1350 : ad f8 9f LDA $9ff8 ; (sstack + 0)
1353 : c9 65 __ CMP #$65
1355 : d0 04 __ BNE $135b ; (nformf.s1007 + 0)
.s1006:
1357 : a9 01 __ LDA #$01
1359 : d0 02 __ BNE $135d ; (nformf.s1008 + 0)
.s1007:
135b : a9 00 __ LDA #$00
.s1008:
135d : 85 4e __ STA T9 + 0 
135f : a6 49 __ LDX T4 + 0 
1361 : e8 __ __ INX
1362 : 86 4c __ STX T8 + 0 
1364 : ad f8 9f LDA $9ff8 ; (sstack + 0)
1367 : c9 67 __ CMP #$67
1369 : d0 13 __ BNE $137e ; (nformf.s24 + 0)
.s22:
136b : a5 4b __ LDA T5 + 1 
136d : 30 08 __ BMI $1377 ; (nformf.s25 + 0)
.s1050:
136f : d0 06 __ BNE $1377 ; (nformf.s25 + 0)
.s1049:
1371 : a5 4a __ LDA T5 + 0 
1373 : c9 04 __ CMP #$04
1375 : 90 07 __ BCC $137e ; (nformf.s24 + 0)
.s25:
1377 : a9 01 __ LDA #$01
1379 : 85 4e __ STA T9 + 0 
137b : 4c d5 15 JMP $15d5 ; (nformf.s30 + 0)
.s24:
137e : a5 4e __ LDA T9 + 0 
1380 : f0 03 __ BEQ $1385 ; (nformf.s32 + 0)
1382 : 4c d5 15 JMP $15d5 ; (nformf.s30 + 0)
.s32:
1385 : a5 4b __ LDA T5 + 1 
1387 : 10 3e __ BPL $13c7 ; (nformf.s34 + 0)
.s33:
1389 : a5 43 __ LDA T1 + 0 
138b : 85 1b __ STA ACCU + 0 
138d : a5 44 __ LDA T1 + 1 
138f : 85 1c __ STA ACCU + 1 
1391 : a5 45 __ LDA T1 + 2 
1393 : 85 1d __ STA ACCU + 2 
1395 : a5 46 __ LDA T1 + 3 
1397 : 85 1e __ STA ACCU + 3 
.l1085:
1399 : e6 4a __ INC T5 + 0 
139b : d0 02 __ BNE $139f ; (nformf.s1095 + 0)
.s1094:
139d : e6 4b __ INC T5 + 1 
.s1095:
139f : a9 00 __ LDA #$00
13a1 : 85 03 __ STA WORK + 0 
13a3 : 85 04 __ STA WORK + 1 
13a5 : a9 20 __ LDA #$20
13a7 : 85 05 __ STA WORK + 2 
13a9 : a9 41 __ LDA #$41
13ab : 85 06 __ STA WORK + 3 
13ad : 20 45 18 JSR $1845 ; (freg + 20)
13b0 : 20 2c 1a JSR $1a2c ; (fdiv + 0)
13b3 : a5 4b __ LDA T5 + 1 
13b5 : 30 e2 __ BMI $1399 ; (nformf.l1085 + 0)
.s1086:
13b7 : a5 1e __ LDA ACCU + 3 
13b9 : 85 46 __ STA T1 + 3 
13bb : a5 1d __ LDA ACCU + 2 
13bd : 85 45 __ STA T1 + 2 
13bf : a5 1c __ LDA ACCU + 1 
13c1 : 85 44 __ STA T1 + 1 
13c3 : a5 1b __ LDA ACCU + 0 
13c5 : 85 43 __ STA T1 + 0 
.s34:
13c7 : 18 __ __ CLC
13c8 : a5 49 __ LDA T4 + 0 
13ca : 65 4a __ ADC T5 + 0 
13cc : 18 __ __ CLC
13cd : 69 01 __ ADC #$01
13cf : 85 4c __ STA T8 + 0 
13d1 : c9 07 __ CMP #$07
13d3 : 90 13 __ BCC $13e8 ; (nformf.s35 + 0)
.s36:
13d5 : ad 4b 1d LDA $1d4b ; (fround5 + 25)
13d8 : 85 1c __ STA ACCU + 1 
13da : ad 4c 1d LDA $1d4c ; (fround5 + 26)
13dd : 85 1d __ STA ACCU + 2 
13df : ad 4d 1d LDA $1d4d ; (fround5 + 27)
13e2 : ae 4a 1d LDX $1d4a ; (fround5 + 24)
13e5 : 4c fb 13 JMP $13fb ; (nformf.s214 + 0)
.s35:
13e8 : 0a __ __ ASL
13e9 : 0a __ __ ASL
13ea : a8 __ __ TAY
13eb : b9 2f 1d LDA $1d2f,y ; (mul40 + 47)
13ee : 85 1c __ STA ACCU + 1 
13f0 : b9 30 1d LDA $1d30,y ; (mul40 + 48)
13f3 : 85 1d __ STA ACCU + 2 
13f5 : b9 31 1d LDA $1d31,y ; (mul40 + 49)
13f8 : be 2e 1d LDX $1d2e,y ; (mul40 + 46)
.s214:
13fb : 86 1b __ STX ACCU + 0 
13fd : 85 1e __ STA ACCU + 3 
13ff : a2 43 __ LDX #$43
1401 : 20 35 18 JSR $1835 ; (freg + 4)
1404 : 20 76 18 JSR $1876 ; (faddsub + 0)
1407 : a5 1c __ LDA ACCU + 1 
1409 : 85 16 __ STA P9 ; (f + 1)
140b : a5 1d __ LDA ACCU + 2 
140d : 85 17 __ STA P10 ; (f + 2)
140f : a6 1b __ LDX ACCU + 0 
1411 : a5 1e __ LDA ACCU + 3 
1413 : 85 18 __ STA P11 ; (f + 3)
1415 : 30 35 __ BMI $144c ; (nformf.s31 + 0)
.s1032:
1417 : c9 41 __ CMP #$41
1419 : d0 06 __ BNE $1421 ; (nformf.s1036 + 0)
.s1033:
141b : a5 17 __ LDA P10 ; (f + 2)
141d : c9 20 __ CMP #$20
141f : f0 02 __ BEQ $1423 ; (nformf.s38 + 0)
.s1036:
1421 : 90 29 __ BCC $144c ; (nformf.s31 + 0)
.s38:
1423 : a9 00 __ LDA #$00
1425 : 85 03 __ STA WORK + 0 
1427 : 85 04 __ STA WORK + 1 
1429 : a9 20 __ LDA #$20
142b : 85 05 __ STA WORK + 2 
142d : a9 41 __ LDA #$41
142f : 85 06 __ STA WORK + 3 
1431 : 20 45 18 JSR $1845 ; (freg + 20)
1434 : 20 2c 1a JSR $1a2c ; (fdiv + 0)
1437 : a5 1c __ LDA ACCU + 1 
1439 : 85 16 __ STA P9 ; (f + 1)
143b : a5 1d __ LDA ACCU + 2 
143d : 85 17 __ STA P10 ; (f + 2)
143f : a5 1e __ LDA ACCU + 3 
1441 : 85 18 __ STA P11 ; (f + 3)
1443 : 18 __ __ CLC
1444 : a5 49 __ LDA T4 + 0 
1446 : 69 ff __ ADC #$ff
1448 : 85 47 __ STA T2 + 0 
144a : a6 1b __ LDX ACCU + 0 
.s31:
144c : 38 __ __ SEC
144d : a5 4c __ LDA T8 + 0 
144f : e5 47 __ SBC T2 + 0 
1451 : 85 49 __ STA T4 + 0 
1453 : a9 14 __ LDA #$14
1455 : c5 4c __ CMP T8 + 0 
1457 : b0 02 __ BCS $145b ; (nformf.s49 + 0)
.s47:
1459 : 85 4c __ STA T8 + 0 
.s49:
145b : a5 49 __ LDA T4 + 0 
145d : d0 08 __ BNE $1467 ; (nformf.s219 + 0)
.s50:
145f : a9 30 __ LDA #$30
1461 : a4 48 __ LDY T3 + 0 
1463 : 91 13 __ STA (P6),y ; (str + 0)
1465 : e6 48 __ INC T3 + 0 
.s219:
1467 : a9 00 __ LDA #$00
1469 : 85 47 __ STA T2 + 0 
146b : c5 49 __ CMP T4 + 0 
146d : d0 08 __ BNE $1477 ; (nformf.l59 + 0)
.l57:
146f : a9 2e __ LDA #$2e
1471 : a4 48 __ LDY T3 + 0 
1473 : 91 13 __ STA (P6),y ; (str + 0)
1475 : e6 48 __ INC T3 + 0 
.l59:
1477 : a5 47 __ LDA T2 + 0 
1479 : c9 07 __ CMP #$07
147b : 90 04 __ BCC $1481 ; (nformf.s61 + 0)
.s60:
147d : a9 30 __ LDA #$30
147f : d0 55 __ BNE $14d6 ; (nformf.s208 + 0)
.s61:
1481 : 86 1b __ STX ACCU + 0 
1483 : 86 43 __ STX T1 + 0 
1485 : a5 16 __ LDA P9 ; (f + 1)
1487 : 85 1c __ STA ACCU + 1 
1489 : 85 44 __ STA T1 + 1 
148b : a5 17 __ LDA P10 ; (f + 2)
148d : 85 1d __ STA ACCU + 2 
148f : 85 45 __ STA T1 + 2 
1491 : a5 18 __ LDA P11 ; (f + 3)
1493 : 85 1e __ STA ACCU + 3 
1495 : 85 46 __ STA T1 + 3 
1497 : 20 c2 1b JSR $1bc2 ; (f32_to_i16 + 0)
149a : a5 1b __ LDA ACCU + 0 
149c : 85 4f __ STA T11 + 0 
149e : 20 04 1c JSR $1c04 ; (sint16_to_float + 0)
14a1 : a2 43 __ LDX #$43
14a3 : 20 35 18 JSR $1835 ; (freg + 4)
14a6 : a5 1e __ LDA ACCU + 3 
14a8 : 49 80 __ EOR #$80
14aa : 85 1e __ STA ACCU + 3 
14ac : 20 76 18 JSR $1876 ; (faddsub + 0)
14af : a9 00 __ LDA #$00
14b1 : 85 03 __ STA WORK + 0 
14b3 : 85 04 __ STA WORK + 1 
14b5 : a9 20 __ LDA #$20
14b7 : 85 05 __ STA WORK + 2 
14b9 : a9 41 __ LDA #$41
14bb : 85 06 __ STA WORK + 3 
14bd : 20 45 18 JSR $1845 ; (freg + 20)
14c0 : 20 5d 19 JSR $195d ; (fmul + 0)
14c3 : a5 1c __ LDA ACCU + 1 
14c5 : 85 16 __ STA P9 ; (f + 1)
14c7 : a5 1d __ LDA ACCU + 2 
14c9 : 85 17 __ STA P10 ; (f + 2)
14cb : a5 1e __ LDA ACCU + 3 
14cd : 85 18 __ STA P11 ; (f + 3)
14cf : 18 __ __ CLC
14d0 : a5 4f __ LDA T11 + 0 
14d2 : 69 30 __ ADC #$30
14d4 : a6 1b __ LDX ACCU + 0 
.s208:
14d6 : a4 48 __ LDY T3 + 0 
14d8 : 91 13 __ STA (P6),y ; (str + 0)
14da : e6 48 __ INC T3 + 0 
14dc : e6 47 __ INC T2 + 0 
14de : a5 47 __ LDA T2 + 0 
14e0 : c5 4c __ CMP T8 + 0 
14e2 : b0 07 __ BCS $14eb ; (nformf.s56 + 0)
.s54:
14e4 : c5 49 __ CMP T4 + 0 
14e6 : d0 8f __ BNE $1477 ; (nformf.l59 + 0)
14e8 : 4c 6f 14 JMP $146f ; (nformf.l57 + 0)
.s56:
14eb : a5 4e __ LDA T9 + 0 
14ed : f0 62 __ BEQ $1551 ; (nformf.s9 + 0)
.s63:
14ef : a9 45 __ LDA #$45
14f1 : a4 48 __ LDY T3 + 0 
14f3 : 91 13 __ STA (P6),y ; (str + 0)
14f5 : c8 __ __ INY
14f6 : a5 4b __ LDA T5 + 1 
14f8 : 30 06 __ BMI $1500 ; (nformf.s66 + 0)
.s67:
14fa : a9 2b __ LDA #$2b
14fc : 91 13 __ STA (P6),y ; (str + 0)
14fe : d0 11 __ BNE $1511 ; (nformf.s68 + 0)
.s66:
1500 : a9 2d __ LDA #$2d
1502 : 91 13 __ STA (P6),y ; (str + 0)
1504 : 38 __ __ SEC
1505 : a9 00 __ LDA #$00
1507 : e5 4a __ SBC T5 + 0 
1509 : 85 4a __ STA T5 + 0 
150b : a9 00 __ LDA #$00
150d : e5 4b __ SBC T5 + 1 
150f : 85 4b __ STA T5 + 1 
.s68:
1511 : a5 4a __ LDA T5 + 0 
1513 : 85 1b __ STA ACCU + 0 
1515 : a5 4b __ LDA T5 + 1 
1517 : 85 1c __ STA ACCU + 1 
1519 : a9 0a __ LDA #$0a
151b : 85 03 __ STA WORK + 0 
151d : a9 00 __ LDA #$00
151f : 85 04 __ STA WORK + 1 
1521 : 20 da 1a JSR $1ada ; (divs16 + 0)
1524 : 18 __ __ CLC
1525 : a5 1b __ LDA ACCU + 0 
1527 : 69 30 __ ADC #$30
1529 : a4 48 __ LDY T3 + 0 
152b : c8 __ __ INY
152c : c8 __ __ INY
152d : 91 13 __ STA (P6),y ; (str + 0)
152f : a5 4a __ LDA T5 + 0 
1531 : 85 1b __ STA ACCU + 0 
1533 : a5 4b __ LDA T5 + 1 
1535 : 85 1c __ STA ACCU + 1 
1537 : a9 0a __ LDA #$0a
1539 : 85 03 __ STA WORK + 0 
153b : a9 00 __ LDA #$00
153d : 85 04 __ STA WORK + 1 
153f : 20 99 1b JSR $1b99 ; (mods16 + 0)
1542 : 18 __ __ CLC
1543 : a5 05 __ LDA WORK + 2 
1545 : 69 30 __ ADC #$30
1547 : a4 48 __ LDY T3 + 0 
1549 : c8 __ __ INY
154a : c8 __ __ INY
154b : c8 __ __ INY
154c : 91 13 __ STA (P6),y ; (str + 0)
154e : c8 __ __ INY
154f : 84 48 __ STY T3 + 0 
.s9:
1551 : a5 11 __ LDA P4 ; (si + 0)
1553 : 85 4a __ STA T5 + 0 
1555 : a5 12 __ LDA P5 ; (si + 1)
1557 : 85 4b __ STA T5 + 1 
1559 : a5 48 __ LDA T3 + 0 
155b : a0 01 __ LDY #$01
155d : d1 11 __ CMP (P4),y ; (si + 0)
155f : b0 5d __ BCS $15be ; (nformf.s1001 + 0)
.s69:
1561 : a0 06 __ LDY #$06
1563 : b1 11 __ LDA (P4),y ; (si + 0)
1565 : f0 06 __ BEQ $156d ; (nformf.s73 + 0)
.s72:
1567 : a5 48 __ LDA T3 + 0 
1569 : aa __ __ TAX
156a : 4c c5 15 JMP $15c5 ; (nformf.l75 + 0)
.s73:
156d : a5 48 __ LDA T3 + 0 
156f : f0 2d __ BEQ $159e ; (nformf.s82 + 0)
.s90:
1571 : a9 01 __ LDA #$01
1573 : 85 47 __ STA T2 + 0 
1575 : a6 48 __ LDX T3 + 0 
1577 : 38 __ __ SEC
.l1083:
1578 : a0 01 __ LDY #$01
157a : b1 11 __ LDA (P4),y ; (si + 0)
157c : e5 47 __ SBC T2 + 0 
157e : 85 4c __ STA T8 + 0 
1580 : a9 ff __ LDA #$ff
1582 : 65 14 __ ADC P7 ; (str + 1)
1584 : 85 4d __ STA T8 + 1 
1586 : 8a __ __ TXA
1587 : 38 __ __ SEC
1588 : e5 47 __ SBC T2 + 0 
158a : 85 1b __ STA ACCU + 0 
158c : a9 ff __ LDA #$ff
158e : 65 14 __ ADC P7 ; (str + 1)
1590 : 85 1c __ STA ACCU + 1 
1592 : a4 13 __ LDY P6 ; (str + 0)
1594 : b1 1b __ LDA (ACCU + 0),y 
1596 : 91 4c __ STA (T8 + 0),y 
1598 : e6 47 __ INC T2 + 0 
159a : e4 47 __ CPX T2 + 0 
159c : b0 da __ BCS $1578 ; (nformf.l1083 + 0)
.s82:
159e : a9 00 __ LDA #$00
15a0 : 85 47 __ STA T2 + 0 
.l83:
15a2 : a0 01 __ LDY #$01
15a4 : b1 4a __ LDA (T5 + 0),y 
15a6 : 38 __ __ SEC
15a7 : e5 48 __ SBC T3 + 0 
15a9 : 90 06 __ BCC $15b1 ; (nformf.s84 + 0)
.s1011:
15ab : c5 47 __ CMP T2 + 0 
15ad : 90 0d __ BCC $15bc ; (nformf.s74 + 0)
.s1087:
15af : f0 0b __ BEQ $15bc ; (nformf.s74 + 0)
.s84:
15b1 : a9 20 __ LDA #$20
15b3 : a4 47 __ LDY T2 + 0 
15b5 : 91 13 __ STA (P6),y ; (str + 0)
15b7 : e6 47 __ INC T2 + 0 
15b9 : 4c a2 15 JMP $15a2 ; (nformf.l83 + 0)
.s74:
15bc : b1 11 __ LDA (P4),y ; (si + 0)
.s1001:
15be : 85 1b __ STA ACCU + 0 
15c0 : a9 00 __ LDA #$00
15c2 : 85 1c __ STA ACCU + 1 
15c4 : 60 __ __ RTS
.l75:
15c5 : a0 01 __ LDY #$01
15c7 : d1 4a __ CMP (T5 + 0),y 
15c9 : b0 f1 __ BCS $15bc ; (nformf.s74 + 0)
.s76:
15cb : a8 __ __ TAY
15cc : a9 20 __ LDA #$20
15ce : 91 13 __ STA (P6),y ; (str + 0)
15d0 : e8 __ __ INX
15d1 : 8a __ __ TXA
15d2 : 4c c5 15 JMP $15c5 ; (nformf.l75 + 0)
.s30:
15d5 : a5 4c __ LDA T8 + 0 
15d7 : c9 07 __ CMP #$07
15d9 : 90 13 __ BCC $15ee ; (nformf.s41 + 0)
.s42:
15db : ad 4b 1d LDA $1d4b ; (fround5 + 25)
15de : 85 1c __ STA ACCU + 1 
15e0 : ad 4c 1d LDA $1d4c ; (fround5 + 26)
15e3 : 85 1d __ STA ACCU + 2 
15e5 : ad 4d 1d LDA $1d4d ; (fround5 + 27)
15e8 : ae 4a 1d LDX $1d4a ; (fround5 + 24)
15eb : 4c 01 16 JMP $1601 ; (nformf.s204 + 0)
.s41:
15ee : 0a __ __ ASL
15ef : 0a __ __ ASL
15f0 : a8 __ __ TAY
15f1 : b9 2f 1d LDA $1d2f,y ; (mul40 + 47)
15f4 : 85 1c __ STA ACCU + 1 
15f6 : b9 30 1d LDA $1d30,y ; (mul40 + 48)
15f9 : 85 1d __ STA ACCU + 2 
15fb : b9 31 1d LDA $1d31,y ; (mul40 + 49)
15fe : be 2e 1d LDX $1d2e,y ; (mul40 + 46)
.s204:
1601 : 86 1b __ STX ACCU + 0 
1603 : 85 1e __ STA ACCU + 3 
1605 : a2 43 __ LDX #$43
1607 : 20 35 18 JSR $1835 ; (freg + 4)
160a : 20 76 18 JSR $1876 ; (faddsub + 0)
160d : a5 1c __ LDA ACCU + 1 
160f : 85 16 __ STA P9 ; (f + 1)
1611 : a5 1d __ LDA ACCU + 2 
1613 : 85 17 __ STA P10 ; (f + 2)
1615 : a6 1b __ LDX ACCU + 0 
1617 : a5 1e __ LDA ACCU + 3 
1619 : 85 18 __ STA P11 ; (f + 3)
161b : 10 03 __ BPL $1620 ; (nformf.s1042 + 0)
161d : 4c 4c 14 JMP $144c ; (nformf.s31 + 0)
.s1042:
1620 : c9 41 __ CMP #$41
1622 : d0 06 __ BNE $162a ; (nformf.s1046 + 0)
.s1043:
1624 : a5 17 __ LDA P10 ; (f + 2)
1626 : c9 20 __ CMP #$20
1628 : f0 05 __ BEQ $162f ; (nformf.s44 + 0)
.s1046:
162a : b0 03 __ BCS $162f ; (nformf.s44 + 0)
162c : 4c 4c 14 JMP $144c ; (nformf.s31 + 0)
.s44:
162f : a9 00 __ LDA #$00
1631 : 85 03 __ STA WORK + 0 
1633 : 85 04 __ STA WORK + 1 
1635 : a9 20 __ LDA #$20
1637 : 85 05 __ STA WORK + 2 
1639 : a9 41 __ LDA #$41
163b : 85 06 __ STA WORK + 3 
163d : 20 45 18 JSR $1845 ; (freg + 20)
1640 : 20 2c 1a JSR $1a2c ; (fdiv + 0)
1643 : a5 1c __ LDA ACCU + 1 
1645 : 85 16 __ STA P9 ; (f + 1)
1647 : a5 1d __ LDA ACCU + 2 
1649 : 85 17 __ STA P10 ; (f + 2)
164b : a5 1e __ LDA ACCU + 3 
164d : 85 18 __ STA P11 ; (f + 3)
164f : a6 1b __ LDX ACCU + 0 
1651 : e6 4a __ INC T5 + 0 
1653 : f0 03 __ BEQ $1658 ; (nformf.s1092 + 0)
1655 : 4c 4c 14 JMP $144c ; (nformf.s31 + 0)
.s1092:
1658 : e6 4b __ INC T5 + 1 
165a : 4c 4c 14 JMP $144c ; (nformf.s31 + 0)
.s13:
165d : a5 18 __ LDA P11 ; (f + 3)
165f : 30 59 __ BMI $16ba ; (nformf.l17 + 0)
.l1072:
1661 : c9 44 __ CMP #$44
1663 : f0 03 __ BEQ $1668 ; (nformf.s1073 + 0)
1665 : 4c 57 17 JMP $1757 ; (nformf.s1076 + 0)
.s1073:
1668 : a5 45 __ LDA T1 + 2 
166a : c9 7a __ CMP #$7a
166c : f0 03 __ BEQ $1671 ; (nformf.s1074 + 0)
166e : 4c 57 17 JMP $1757 ; (nformf.s1076 + 0)
.s1074:
1671 : a5 44 __ LDA T1 + 1 
1673 : d0 04 __ BNE $1679 ; (nformf.s1082 + 0)
.s1075:
1675 : a5 43 __ LDA T1 + 0 
1677 : f0 02 __ BEQ $167b ; (nformf.s14 + 0)
.s1082:
1679 : a5 43 __ LDA T1 + 0 
.s14:
167b : 85 1b __ STA ACCU + 0 
167d : a5 44 __ LDA T1 + 1 
167f : 85 1c __ STA ACCU + 1 
1681 : a5 45 __ LDA T1 + 2 
1683 : 85 1d __ STA ACCU + 2 
1685 : a5 46 __ LDA T1 + 3 
1687 : 85 1e __ STA ACCU + 3 
1689 : a9 00 __ LDA #$00
168b : 85 03 __ STA WORK + 0 
168d : 85 04 __ STA WORK + 1 
168f : a9 7a __ LDA #$7a
1691 : 85 05 __ STA WORK + 2 
1693 : a9 44 __ LDA #$44
1695 : 85 06 __ STA WORK + 3 
1697 : 20 45 18 JSR $1845 ; (freg + 20)
169a : 20 2c 1a JSR $1a2c ; (fdiv + 0)
169d : a5 1b __ LDA ACCU + 0 
169f : 85 43 __ STA T1 + 0 
16a1 : a5 1c __ LDA ACCU + 1 
16a3 : 85 44 __ STA T1 + 1 
16a5 : a5 1d __ LDA ACCU + 2 
16a7 : 85 45 __ STA T1 + 2 
16a9 : 18 __ __ CLC
16aa : a5 4a __ LDA T5 + 0 
16ac : 69 03 __ ADC #$03
16ae : 85 4a __ STA T5 + 0 
16b0 : 90 02 __ BCC $16b4 ; (nformf.s1097 + 0)
.s1096:
16b2 : e6 4b __ INC T5 + 1 
.s1097:
16b4 : a5 1e __ LDA ACCU + 3 
16b6 : 85 46 __ STA T1 + 3 
16b8 : 10 a7 __ BPL $1661 ; (nformf.l1072 + 0)
.l17:
16ba : a9 00 __ LDA #$00
16bc : 85 1b __ STA ACCU + 0 
16be : 85 1c __ STA ACCU + 1 
16c0 : a9 7a __ LDA #$7a
16c2 : 85 1d __ STA ACCU + 2 
16c4 : a9 44 __ LDA #$44
16c6 : 85 1e __ STA ACCU + 3 
16c8 : a2 43 __ LDX #$43
16ca : 20 35 18 JSR $1835 ; (freg + 4)
16cd : 20 5d 19 JSR $195d ; (fmul + 0)
16d0 : a5 1b __ LDA ACCU + 0 
16d2 : 85 43 __ STA T1 + 0 
16d4 : a5 1c __ LDA ACCU + 1 
16d6 : 85 44 __ STA T1 + 1 
16d8 : a5 1d __ LDA ACCU + 2 
16da : 85 45 __ STA T1 + 2 
16dc : a5 1e __ LDA ACCU + 3 
16de : 85 46 __ STA T1 + 3 
16e0 : 38 __ __ SEC
16e1 : a5 4a __ LDA T5 + 0 
16e3 : e9 03 __ SBC #$03
16e5 : 85 4a __ STA T5 + 0 
16e7 : b0 02 __ BCS $16eb ; (nformf.s16 + 0)
.s1088:
16e9 : c6 4b __ DEC T5 + 1 
.s16:
16eb : a5 46 __ LDA T1 + 3 
16ed : 30 cb __ BMI $16ba ; (nformf.l17 + 0)
.s1064:
16ef : c9 3f __ CMP #$3f
16f1 : d0 06 __ BNE $16f9 ; (nformf.s1068 + 0)
.s1065:
16f3 : a5 45 __ LDA T1 + 2 
16f5 : c9 80 __ CMP #$80
16f7 : f0 02 __ BEQ $16fb ; (nformf.s19 + 0)
.s1068:
16f9 : 90 bf __ BCC $16ba ; (nformf.l17 + 0)
.s19:
16fb : a5 46 __ LDA T1 + 3 
16fd : c9 41 __ CMP #$41
16ff : d0 51 __ BNE $1752 ; (nformf.l1060 + 0)
.s1057:
1701 : a5 45 __ LDA T1 + 2 
1703 : c9 20 __ CMP #$20
1705 : d0 4b __ BNE $1752 ; (nformf.l1060 + 0)
.s1058:
1707 : a5 44 __ LDA T1 + 1 
1709 : d0 04 __ BNE $170f ; (nformf.l1081 + 0)
.s1059:
170b : a5 43 __ LDA T1 + 0 
170d : f0 02 __ BEQ $1711 ; (nformf.l20 + 0)
.l1081:
170f : a5 43 __ LDA T1 + 0 
.l20:
1711 : 85 1b __ STA ACCU + 0 
1713 : a5 44 __ LDA T1 + 1 
1715 : 85 1c __ STA ACCU + 1 
1717 : a5 45 __ LDA T1 + 2 
1719 : 85 1d __ STA ACCU + 2 
171b : a5 46 __ LDA T1 + 3 
171d : 85 1e __ STA ACCU + 3 
171f : a9 00 __ LDA #$00
1721 : 85 03 __ STA WORK + 0 
1723 : 85 04 __ STA WORK + 1 
1725 : a9 20 __ LDA #$20
1727 : 85 05 __ STA WORK + 2 
1729 : a9 41 __ LDA #$41
172b : 85 06 __ STA WORK + 3 
172d : 20 45 18 JSR $1845 ; (freg + 20)
1730 : 20 2c 1a JSR $1a2c ; (fdiv + 0)
1733 : a5 1b __ LDA ACCU + 0 
1735 : 85 43 __ STA T1 + 0 
1737 : a5 1c __ LDA ACCU + 1 
1739 : 85 44 __ STA T1 + 1 
173b : a5 1d __ LDA ACCU + 2 
173d : 85 45 __ STA T1 + 2 
173f : e6 4a __ INC T5 + 0 
1741 : d0 02 __ BNE $1745 ; (nformf.s1091 + 0)
.s1090:
1743 : e6 4b __ INC T5 + 1 
.s1091:
1745 : a5 1e __ LDA ACCU + 3 
1747 : 85 46 __ STA T1 + 3 
1749 : 10 03 __ BPL $174e ; (nformf.s1056 + 0)
174b : 4c 50 13 JMP $1350 ; (nformf.s12 + 0)
.s1056:
174e : c9 41 __ CMP #$41
1750 : f0 af __ BEQ $1701 ; (nformf.s1057 + 0)
.l1060:
1752 : b0 bb __ BCS $170f ; (nformf.l1081 + 0)
1754 : 4c 50 13 JMP $1350 ; (nformf.s12 + 0)
.s1076:
1757 : 90 92 __ BCC $16eb ; (nformf.s16 + 0)
1759 : 4c 79 16 JMP $1679 ; (nformf.s1082 + 0)
.s7:
175c : 85 1b __ STA ACCU + 0 
175e : a9 49 __ LDA #$49
1760 : 91 13 __ STA (P6),y ; (str + 0)
1762 : a9 4e __ LDA #$4e
1764 : a4 4a __ LDY T5 + 0 
1766 : 91 13 __ STA (P6),y ; (str + 0)
1768 : a9 46 __ LDA #$46
176a : a4 1b __ LDY ACCU + 0 
176c : 91 13 __ STA (P6),y ; (str + 0)
176e : 18 __ __ CLC
176f : a5 48 __ LDA T3 + 0 
1771 : 69 03 __ ADC #$03
1773 : 85 48 __ STA T3 + 0 
1775 : 4c 51 15 JMP $1551 ; (nformf.s9 + 0)
.s189:
1778 : 20 90 17 JSR $1790 ; (isinf.s0 + 0)
177b : aa __ __ TAX
177c : a9 01 __ LDA #$01
177e : 85 48 __ STA T3 + 0 
1780 : 8a __ __ TXA
1781 : d0 03 __ BNE $1786 ; (nformf.s158 + 0)
1783 : 4c 2d 13 JMP $132d ; (nformf.s8 + 0)
.s158:
1786 : a9 02 __ LDA #$02
1788 : 85 4a __ STA T5 + 0 
178a : a9 03 __ LDA #$03
178c : a0 01 __ LDY #$01
178e : d0 cc __ BNE $175c ; (nformf.s7 + 0)
--------------------------------------------------------------------
isinf:
.s0:
1790 : 06 0f __ ASL P2 ; (f + 2)
1792 : a5 10 __ LDA P3 ; (f + 3)
1794 : 2a __ __ ROL
1795 : c9 ff __ CMP #$ff
1797 : d0 03 __ BNE $179c ; (isinf.s1003 + 0)
.s1002:
1799 : a9 01 __ LDA #$01
179b : 60 __ __ RTS
.s1003:
179c : a9 00 __ LDA #$00
.s1001:
179e : 60 __ __ RTS
--------------------------------------------------------------------
fround5:
1d32 : __ __ __ BYT 00 00 00 3f cd cc 4c 3d 0a d7 a3 3b 6f 12 03 3a : ...?..L=...;o..:
1d42 : __ __ __ BYT 17 b7 51 38 ac c5 a7 36 bd 37 06 35             : ..Q8...6.7.5
--------------------------------------------------------------------
09f9 : __ __ __ BYT 25 64 00                                        : %d.
--------------------------------------------------------------------
cwin_put_string:
.s0:
179f : a5 14 __ LDA P7 ; (win + 0)
17a1 : 85 0d __ STA P0 
17a3 : a5 15 __ LDA P8 ; (win + 1)
17a5 : 85 0e __ STA P1 
17a7 : a0 04 __ LDY #$04
17a9 : b1 14 __ LDA (P7),y ; (win + 0)
17ab : 85 0f __ STA P2 
17ad : c8 __ __ INY
17ae : b1 14 __ LDA (P7),y ; (win + 0)
17b0 : 85 10 __ STA P3 
17b2 : a5 16 __ LDA P9 ; (str + 0)
17b4 : 85 11 __ STA P4 
17b6 : a5 17 __ LDA P10 ; (str + 1)
17b8 : 85 12 __ STA P5 
17ba : a5 18 __ LDA P11 ; (color + 0)
17bc : 85 13 __ STA P6 
17be : 20 df 17 JSR $17df ; (cwin_putat_string.s0 + 0)
17c1 : 85 1b __ STA ACCU + 0 
17c3 : 18 __ __ CLC
17c4 : a0 04 __ LDY #$04
17c6 : 71 14 __ ADC (P7),y ; (win + 0)
17c8 : 91 14 __ STA (P7),y ; (win + 0)
17ca : a0 02 __ LDY #$02
17cc : d1 14 __ CMP (P7),y ; (win + 0)
17ce : 90 0e __ BCC $17de ; (cwin_put_string.s1001 + 0)
.s1:
17d0 : a9 00 __ LDA #$00
17d2 : a0 04 __ LDY #$04
17d4 : 91 14 __ STA (P7),y ; (win + 0)
17d6 : 18 __ __ CLC
17d7 : c8 __ __ INY
17d8 : b1 14 __ LDA (P7),y ; (win + 0)
17da : 69 01 __ ADC #$01
17dc : 91 14 __ STA (P7),y ; (win + 0)
.s1001:
17de : 60 __ __ RTS
--------------------------------------------------------------------
cwin_putat_string:
.s0:
17df : a5 10 __ LDA P3 ; (y + 0)
17e1 : 0a __ __ ASL
17e2 : aa __ __ TAX
17e3 : bd 00 1d LDA $1d00,x ; (mul40 + 0)
17e6 : 18 __ __ CLC
17e7 : 65 0f __ ADC P2 ; (x + 0)
17e9 : 85 1b __ STA ACCU + 0 
17eb : bd 01 1d LDA $1d01,x ; (mul40 + 1)
17ee : 69 00 __ ADC #$00
17f0 : 85 1c __ STA ACCU + 1 
17f2 : a0 06 __ LDY #$06
17f4 : b1 0d __ LDA (P0),y ; (win + 0)
17f6 : 18 __ __ CLC
17f7 : 65 1b __ ADC ACCU + 0 
17f9 : 85 43 __ STA T3 + 0 
17fb : c8 __ __ INY
17fc : b1 0d __ LDA (P0),y ; (win + 0)
17fe : 65 1c __ ADC ACCU + 1 
1800 : 85 44 __ STA T3 + 1 
1802 : c8 __ __ INY
1803 : b1 0d __ LDA (P0),y ; (win + 0)
1805 : 18 __ __ CLC
1806 : 65 1b __ ADC ACCU + 0 
1808 : 85 1b __ STA ACCU + 0 
180a : c8 __ __ INY
180b : b1 0d __ LDA (P0),y ; (win + 0)
180d : 65 1c __ ADC ACCU + 1 
180f : 85 1c __ STA ACCU + 1 
1811 : a0 00 __ LDY #$00
1813 : b1 11 __ LDA (P4),y ; (str + 0)
1815 : f0 18 __ BEQ $182f ; (cwin_putat_string.s3 + 0)
.l2:
1817 : 85 1d __ STA ACCU + 2 
1819 : 4a __ __ LSR
181a : 4a __ __ LSR
181b : 4a __ __ LSR
181c : 4a __ __ LSR
181d : 4a __ __ LSR
181e : aa __ __ TAX
181f : bd f5 1c LDA $1cf5,x ; (p2smap + 0)
1822 : 45 1d __ EOR ACCU + 2 
1824 : 91 43 __ STA (T3 + 0),y 
1826 : a5 13 __ LDA P6 ; (color + 0)
1828 : 91 1b __ STA (ACCU + 0),y 
182a : c8 __ __ INY
182b : b1 11 __ LDA (P4),y ; (str + 0)
182d : d0 e8 __ BNE $1817 ; (cwin_putat_string.l2 + 0)
.s3:
182f : 98 __ __ TYA
.s1001:
1830 : 60 __ __ RTS
--------------------------------------------------------------------
p2smap:
1cf5 : __ __ __ BYT 00 00 40 20 80 c0 80 80                         : ..@ ....
--------------------------------------------------------------------
freg:
1831 : b1 19 __ LDA (IP + 0),y 
1833 : c8 __ __ INY
1834 : aa __ __ TAX
1835 : b5 00 __ LDA $00,x 
1837 : 85 03 __ STA WORK + 0 
1839 : b5 01 __ LDA $01,x 
183b : 85 04 __ STA WORK + 1 
183d : b5 02 __ LDA $02,x 
183f : 85 05 __ STA WORK + 2 
1841 : b5 03 __ LDA WORK + 0,x 
1843 : 85 06 __ STA WORK + 3 
1845 : a5 05 __ LDA WORK + 2 
1847 : 0a __ __ ASL
1848 : a5 06 __ LDA WORK + 3 
184a : 2a __ __ ROL
184b : 85 08 __ STA WORK + 5 
184d : f0 06 __ BEQ $1855 ; (freg + 36)
184f : a5 05 __ LDA WORK + 2 
1851 : 09 80 __ ORA #$80
1853 : 85 05 __ STA WORK + 2 
1855 : a5 1d __ LDA ACCU + 2 
1857 : 0a __ __ ASL
1858 : a5 1e __ LDA ACCU + 3 
185a : 2a __ __ ROL
185b : 85 07 __ STA WORK + 4 
185d : f0 06 __ BEQ $1865 ; (freg + 52)
185f : a5 1d __ LDA ACCU + 2 
1861 : 09 80 __ ORA #$80
1863 : 85 1d __ STA ACCU + 2 
1865 : 60 __ __ RTS
1866 : 06 1e __ ASL ACCU + 3 
1868 : a5 07 __ LDA WORK + 4 
186a : 6a __ __ ROR
186b : 85 1e __ STA ACCU + 3 
186d : b0 06 __ BCS $1875 ; (freg + 68)
186f : a5 1d __ LDA ACCU + 2 
1871 : 29 7f __ AND #$7f
1873 : 85 1d __ STA ACCU + 2 
1875 : 60 __ __ RTS
--------------------------------------------------------------------
faddsub:
1876 : a9 ff __ LDA #$ff
1878 : c5 07 __ CMP WORK + 4 
187a : f0 04 __ BEQ $1880 ; (faddsub + 10)
187c : c5 08 __ CMP WORK + 5 
187e : d0 11 __ BNE $1891 ; (faddsub + 27)
1880 : a5 1e __ LDA ACCU + 3 
1882 : 09 7f __ ORA #$7f
1884 : 85 1e __ STA ACCU + 3 
1886 : a9 80 __ LDA #$80
1888 : 85 1d __ STA ACCU + 2 
188a : a9 00 __ LDA #$00
188c : 85 1b __ STA ACCU + 0 
188e : 85 1c __ STA ACCU + 1 
1890 : 60 __ __ RTS
1891 : 38 __ __ SEC
1892 : a5 07 __ LDA WORK + 4 
1894 : e5 08 __ SBC WORK + 5 
1896 : f0 38 __ BEQ $18d0 ; (faddsub + 90)
1898 : aa __ __ TAX
1899 : b0 25 __ BCS $18c0 ; (faddsub + 74)
189b : e0 e9 __ CPX #$e9
189d : b0 0e __ BCS $18ad ; (faddsub + 55)
189f : a5 08 __ LDA WORK + 5 
18a1 : 85 07 __ STA WORK + 4 
18a3 : a9 00 __ LDA #$00
18a5 : 85 1b __ STA ACCU + 0 
18a7 : 85 1c __ STA ACCU + 1 
18a9 : 85 1d __ STA ACCU + 2 
18ab : f0 23 __ BEQ $18d0 ; (faddsub + 90)
18ad : a5 1d __ LDA ACCU + 2 
18af : 4a __ __ LSR
18b0 : 66 1c __ ROR ACCU + 1 
18b2 : 66 1b __ ROR ACCU + 0 
18b4 : e8 __ __ INX
18b5 : d0 f8 __ BNE $18af ; (faddsub + 57)
18b7 : 85 1d __ STA ACCU + 2 
18b9 : a5 08 __ LDA WORK + 5 
18bb : 85 07 __ STA WORK + 4 
18bd : 4c d0 18 JMP $18d0 ; (faddsub + 90)
18c0 : e0 18 __ CPX #$18
18c2 : b0 33 __ BCS $18f7 ; (faddsub + 129)
18c4 : a5 05 __ LDA WORK + 2 
18c6 : 4a __ __ LSR
18c7 : 66 04 __ ROR WORK + 1 
18c9 : 66 03 __ ROR WORK + 0 
18cb : ca __ __ DEX
18cc : d0 f8 __ BNE $18c6 ; (faddsub + 80)
18ce : 85 05 __ STA WORK + 2 
18d0 : a5 1e __ LDA ACCU + 3 
18d2 : 29 80 __ AND #$80
18d4 : 85 1e __ STA ACCU + 3 
18d6 : 45 06 __ EOR WORK + 3 
18d8 : 30 31 __ BMI $190b ; (faddsub + 149)
18da : 18 __ __ CLC
18db : a5 1b __ LDA ACCU + 0 
18dd : 65 03 __ ADC WORK + 0 
18df : 85 1b __ STA ACCU + 0 
18e1 : a5 1c __ LDA ACCU + 1 
18e3 : 65 04 __ ADC WORK + 1 
18e5 : 85 1c __ STA ACCU + 1 
18e7 : a5 1d __ LDA ACCU + 2 
18e9 : 65 05 __ ADC WORK + 2 
18eb : 85 1d __ STA ACCU + 2 
18ed : 90 08 __ BCC $18f7 ; (faddsub + 129)
18ef : 66 1d __ ROR ACCU + 2 
18f1 : 66 1c __ ROR ACCU + 1 
18f3 : 66 1b __ ROR ACCU + 0 
18f5 : e6 07 __ INC WORK + 4 
18f7 : a5 07 __ LDA WORK + 4 
18f9 : c9 ff __ CMP #$ff
18fb : f0 83 __ BEQ $1880 ; (faddsub + 10)
18fd : 4a __ __ LSR
18fe : 05 1e __ ORA ACCU + 3 
1900 : 85 1e __ STA ACCU + 3 
1902 : b0 06 __ BCS $190a ; (faddsub + 148)
1904 : a5 1d __ LDA ACCU + 2 
1906 : 29 7f __ AND #$7f
1908 : 85 1d __ STA ACCU + 2 
190a : 60 __ __ RTS
190b : 38 __ __ SEC
190c : a5 1b __ LDA ACCU + 0 
190e : e5 03 __ SBC WORK + 0 
1910 : 85 1b __ STA ACCU + 0 
1912 : a5 1c __ LDA ACCU + 1 
1914 : e5 04 __ SBC WORK + 1 
1916 : 85 1c __ STA ACCU + 1 
1918 : a5 1d __ LDA ACCU + 2 
191a : e5 05 __ SBC WORK + 2 
191c : 85 1d __ STA ACCU + 2 
191e : b0 19 __ BCS $1939 ; (faddsub + 195)
1920 : 38 __ __ SEC
1921 : a9 00 __ LDA #$00
1923 : e5 1b __ SBC ACCU + 0 
1925 : 85 1b __ STA ACCU + 0 
1927 : a9 00 __ LDA #$00
1929 : e5 1c __ SBC ACCU + 1 
192b : 85 1c __ STA ACCU + 1 
192d : a9 00 __ LDA #$00
192f : e5 1d __ SBC ACCU + 2 
1931 : 85 1d __ STA ACCU + 2 
1933 : a5 1e __ LDA ACCU + 3 
1935 : 49 80 __ EOR #$80
1937 : 85 1e __ STA ACCU + 3 
1939 : a5 1d __ LDA ACCU + 2 
193b : 30 ba __ BMI $18f7 ; (faddsub + 129)
193d : 05 1c __ ORA ACCU + 1 
193f : 05 1b __ ORA ACCU + 0 
1941 : f0 0f __ BEQ $1952 ; (faddsub + 220)
1943 : c6 07 __ DEC WORK + 4 
1945 : f0 0b __ BEQ $1952 ; (faddsub + 220)
1947 : 06 1b __ ASL ACCU + 0 
1949 : 26 1c __ ROL ACCU + 1 
194b : 26 1d __ ROL ACCU + 2 
194d : 10 f4 __ BPL $1943 ; (faddsub + 205)
194f : 4c f7 18 JMP $18f7 ; (faddsub + 129)
1952 : a9 00 __ LDA #$00
1954 : 85 1b __ STA ACCU + 0 
1956 : 85 1c __ STA ACCU + 1 
1958 : 85 1d __ STA ACCU + 2 
195a : 85 1e __ STA ACCU + 3 
195c : 60 __ __ RTS
--------------------------------------------------------------------
fmul:
195d : a5 1b __ LDA ACCU + 0 
195f : 05 1c __ ORA ACCU + 1 
1961 : 05 1d __ ORA ACCU + 2 
1963 : d0 03 __ BNE $1968 ; (fmul + 11)
1965 : 85 1e __ STA ACCU + 3 
1967 : 60 __ __ RTS
1968 : a5 03 __ LDA WORK + 0 
196a : 05 04 __ ORA WORK + 1 
196c : 05 05 __ ORA WORK + 2 
196e : d0 09 __ BNE $1979 ; (fmul + 28)
1970 : 85 1b __ STA ACCU + 0 
1972 : 85 1c __ STA ACCU + 1 
1974 : 85 1d __ STA ACCU + 2 
1976 : 85 1e __ STA ACCU + 3 
1978 : 60 __ __ RTS
1979 : a5 1e __ LDA ACCU + 3 
197b : 45 06 __ EOR WORK + 3 
197d : 29 80 __ AND #$80
197f : 85 1e __ STA ACCU + 3 
1981 : a9 ff __ LDA #$ff
1983 : c5 07 __ CMP WORK + 4 
1985 : f0 42 __ BEQ $19c9 ; (fmul + 108)
1987 : c5 08 __ CMP WORK + 5 
1989 : f0 3e __ BEQ $19c9 ; (fmul + 108)
198b : a9 00 __ LDA #$00
198d : 85 09 __ STA WORK + 6 
198f : 85 0a __ STA WORK + 7 
1991 : 85 0b __ STA $0b 
1993 : a4 1b __ LDY ACCU + 0 
1995 : a5 03 __ LDA WORK + 0 
1997 : d0 06 __ BNE $199f ; (fmul + 66)
1999 : a5 04 __ LDA WORK + 1 
199b : f0 0a __ BEQ $19a7 ; (fmul + 74)
199d : d0 05 __ BNE $19a4 ; (fmul + 71)
199f : 20 fe 19 JSR $19fe ; (fmul8 + 0)
19a2 : a5 04 __ LDA WORK + 1 
19a4 : 20 fe 19 JSR $19fe ; (fmul8 + 0)
19a7 : a5 05 __ LDA WORK + 2 
19a9 : 20 fe 19 JSR $19fe ; (fmul8 + 0)
19ac : 38 __ __ SEC
19ad : a5 0b __ LDA $0b 
19af : 30 06 __ BMI $19b7 ; (fmul + 90)
19b1 : 06 09 __ ASL WORK + 6 
19b3 : 26 0a __ ROL WORK + 7 
19b5 : 2a __ __ ROL
19b6 : 18 __ __ CLC
19b7 : 29 7f __ AND #$7f
19b9 : 85 0b __ STA $0b 
19bb : a5 07 __ LDA WORK + 4 
19bd : 65 08 __ ADC WORK + 5 
19bf : 90 19 __ BCC $19da ; (fmul + 125)
19c1 : e9 7f __ SBC #$7f
19c3 : b0 04 __ BCS $19c9 ; (fmul + 108)
19c5 : c9 ff __ CMP #$ff
19c7 : d0 15 __ BNE $19de ; (fmul + 129)
19c9 : a5 1e __ LDA ACCU + 3 
19cb : 09 7f __ ORA #$7f
19cd : 85 1e __ STA ACCU + 3 
19cf : a9 80 __ LDA #$80
19d1 : 85 1d __ STA ACCU + 2 
19d3 : a9 00 __ LDA #$00
19d5 : 85 1b __ STA ACCU + 0 
19d7 : 85 1c __ STA ACCU + 1 
19d9 : 60 __ __ RTS
19da : e9 7e __ SBC #$7e
19dc : 90 15 __ BCC $19f3 ; (fmul + 150)
19de : 4a __ __ LSR
19df : 05 1e __ ORA ACCU + 3 
19e1 : 85 1e __ STA ACCU + 3 
19e3 : a9 00 __ LDA #$00
19e5 : 6a __ __ ROR
19e6 : 05 0b __ ORA $0b 
19e8 : 85 1d __ STA ACCU + 2 
19ea : a5 0a __ LDA WORK + 7 
19ec : 85 1c __ STA ACCU + 1 
19ee : a5 09 __ LDA WORK + 6 
19f0 : 85 1b __ STA ACCU + 0 
19f2 : 60 __ __ RTS
19f3 : a9 00 __ LDA #$00
19f5 : 85 1b __ STA ACCU + 0 
19f7 : 85 1c __ STA ACCU + 1 
19f9 : 85 1d __ STA ACCU + 2 
19fb : 85 1e __ STA ACCU + 3 
19fd : 60 __ __ RTS
--------------------------------------------------------------------
fmul8:
19fe : 38 __ __ SEC
19ff : 6a __ __ ROR
1a00 : 90 1e __ BCC $1a20 ; (fmul8 + 34)
1a02 : aa __ __ TAX
1a03 : 18 __ __ CLC
1a04 : 98 __ __ TYA
1a05 : 65 09 __ ADC WORK + 6 
1a07 : 85 09 __ STA WORK + 6 
1a09 : a5 0a __ LDA WORK + 7 
1a0b : 65 1c __ ADC ACCU + 1 
1a0d : 85 0a __ STA WORK + 7 
1a0f : a5 0b __ LDA $0b 
1a11 : 65 1d __ ADC ACCU + 2 
1a13 : 6a __ __ ROR
1a14 : 85 0b __ STA $0b 
1a16 : 8a __ __ TXA
1a17 : 66 0a __ ROR WORK + 7 
1a19 : 66 09 __ ROR WORK + 6 
1a1b : 4a __ __ LSR
1a1c : f0 0d __ BEQ $1a2b ; (fmul8 + 45)
1a1e : b0 e2 __ BCS $1a02 ; (fmul8 + 4)
1a20 : 66 0b __ ROR $0b 
1a22 : 66 0a __ ROR WORK + 7 
1a24 : 66 09 __ ROR WORK + 6 
1a26 : 4a __ __ LSR
1a27 : 90 f7 __ BCC $1a20 ; (fmul8 + 34)
1a29 : d0 d7 __ BNE $1a02 ; (fmul8 + 4)
1a2b : 60 __ __ RTS
--------------------------------------------------------------------
fdiv:
1a2c : a5 1b __ LDA ACCU + 0 
1a2e : 05 1c __ ORA ACCU + 1 
1a30 : 05 1d __ ORA ACCU + 2 
1a32 : d0 03 __ BNE $1a37 ; (fdiv + 11)
1a34 : 85 1e __ STA ACCU + 3 
1a36 : 60 __ __ RTS
1a37 : a5 1e __ LDA ACCU + 3 
1a39 : 45 06 __ EOR WORK + 3 
1a3b : 29 80 __ AND #$80
1a3d : 85 1e __ STA ACCU + 3 
1a3f : a5 08 __ LDA WORK + 5 
1a41 : f0 62 __ BEQ $1aa5 ; (fdiv + 121)
1a43 : a5 07 __ LDA WORK + 4 
1a45 : c9 ff __ CMP #$ff
1a47 : f0 5c __ BEQ $1aa5 ; (fdiv + 121)
1a49 : a9 00 __ LDA #$00
1a4b : 85 09 __ STA WORK + 6 
1a4d : 85 0a __ STA WORK + 7 
1a4f : 85 0b __ STA $0b 
1a51 : a2 18 __ LDX #$18
1a53 : a5 1b __ LDA ACCU + 0 
1a55 : c5 03 __ CMP WORK + 0 
1a57 : a5 1c __ LDA ACCU + 1 
1a59 : e5 04 __ SBC WORK + 1 
1a5b : a5 1d __ LDA ACCU + 2 
1a5d : e5 05 __ SBC WORK + 2 
1a5f : 90 13 __ BCC $1a74 ; (fdiv + 72)
1a61 : a5 1b __ LDA ACCU + 0 
1a63 : e5 03 __ SBC WORK + 0 
1a65 : 85 1b __ STA ACCU + 0 
1a67 : a5 1c __ LDA ACCU + 1 
1a69 : e5 04 __ SBC WORK + 1 
1a6b : 85 1c __ STA ACCU + 1 
1a6d : a5 1d __ LDA ACCU + 2 
1a6f : e5 05 __ SBC WORK + 2 
1a71 : 85 1d __ STA ACCU + 2 
1a73 : 38 __ __ SEC
1a74 : 26 09 __ ROL WORK + 6 
1a76 : 26 0a __ ROL WORK + 7 
1a78 : 26 0b __ ROL $0b 
1a7a : ca __ __ DEX
1a7b : f0 0a __ BEQ $1a87 ; (fdiv + 91)
1a7d : 06 1b __ ASL ACCU + 0 
1a7f : 26 1c __ ROL ACCU + 1 
1a81 : 26 1d __ ROL ACCU + 2 
1a83 : b0 dc __ BCS $1a61 ; (fdiv + 53)
1a85 : 90 cc __ BCC $1a53 ; (fdiv + 39)
1a87 : 38 __ __ SEC
1a88 : a5 0b __ LDA $0b 
1a8a : 30 06 __ BMI $1a92 ; (fdiv + 102)
1a8c : 06 09 __ ASL WORK + 6 
1a8e : 26 0a __ ROL WORK + 7 
1a90 : 2a __ __ ROL
1a91 : 18 __ __ CLC
1a92 : 29 7f __ AND #$7f
1a94 : 85 0b __ STA $0b 
1a96 : a5 07 __ LDA WORK + 4 
1a98 : e5 08 __ SBC WORK + 5 
1a9a : 90 1a __ BCC $1ab6 ; (fdiv + 138)
1a9c : 18 __ __ CLC
1a9d : 69 7f __ ADC #$7f
1a9f : b0 04 __ BCS $1aa5 ; (fdiv + 121)
1aa1 : c9 ff __ CMP #$ff
1aa3 : d0 15 __ BNE $1aba ; (fdiv + 142)
1aa5 : a5 1e __ LDA ACCU + 3 
1aa7 : 09 7f __ ORA #$7f
1aa9 : 85 1e __ STA ACCU + 3 
1aab : a9 80 __ LDA #$80
1aad : 85 1d __ STA ACCU + 2 
1aaf : a9 00 __ LDA #$00
1ab1 : 85 1c __ STA ACCU + 1 
1ab3 : 85 1b __ STA ACCU + 0 
1ab5 : 60 __ __ RTS
1ab6 : 69 7f __ ADC #$7f
1ab8 : 90 15 __ BCC $1acf ; (fdiv + 163)
1aba : 4a __ __ LSR
1abb : 05 1e __ ORA ACCU + 3 
1abd : 85 1e __ STA ACCU + 3 
1abf : a9 00 __ LDA #$00
1ac1 : 6a __ __ ROR
1ac2 : 05 0b __ ORA $0b 
1ac4 : 85 1d __ STA ACCU + 2 
1ac6 : a5 0a __ LDA WORK + 7 
1ac8 : 85 1c __ STA ACCU + 1 
1aca : a5 09 __ LDA WORK + 6 
1acc : 85 1b __ STA ACCU + 0 
1ace : 60 __ __ RTS
1acf : a9 00 __ LDA #$00
1ad1 : 85 1e __ STA ACCU + 3 
1ad3 : 85 1d __ STA ACCU + 2 
1ad5 : 85 1c __ STA ACCU + 1 
1ad7 : 85 1b __ STA ACCU + 0 
1ad9 : 60 __ __ RTS
--------------------------------------------------------------------
divs16:
1ada : 24 1c __ BIT ACCU + 1 
1adc : 10 0d __ BPL $1aeb ; (divs16 + 17)
1ade : 20 f8 1a JSR $1af8 ; (negaccu + 0)
1ae1 : 24 04 __ BIT WORK + 1 
1ae3 : 10 0d __ BPL $1af2 ; (divs16 + 24)
1ae5 : 20 06 1b JSR $1b06 ; (negtmp + 0)
1ae8 : 4c 14 1b JMP $1b14 ; (divmod + 0)
1aeb : 24 04 __ BIT WORK + 1 
1aed : 10 f9 __ BPL $1ae8 ; (divs16 + 14)
1aef : 20 06 1b JSR $1b06 ; (negtmp + 0)
1af2 : 20 14 1b JSR $1b14 ; (divmod + 0)
1af5 : 4c f8 1a JMP $1af8 ; (negaccu + 0)
--------------------------------------------------------------------
negaccu:
1af8 : 38 __ __ SEC
1af9 : a9 00 __ LDA #$00
1afb : e5 1b __ SBC ACCU + 0 
1afd : 85 1b __ STA ACCU + 0 
1aff : a9 00 __ LDA #$00
1b01 : e5 1c __ SBC ACCU + 1 
1b03 : 85 1c __ STA ACCU + 1 
1b05 : 60 __ __ RTS
--------------------------------------------------------------------
negtmp:
1b06 : 38 __ __ SEC
1b07 : a9 00 __ LDA #$00
1b09 : e5 03 __ SBC WORK + 0 
1b0b : 85 03 __ STA WORK + 0 
1b0d : a9 00 __ LDA #$00
1b0f : e5 04 __ SBC WORK + 1 
1b11 : 85 04 __ STA WORK + 1 
1b13 : 60 __ __ RTS
--------------------------------------------------------------------
divmod:
1b14 : a5 1c __ LDA ACCU + 1 
1b16 : d0 31 __ BNE $1b49 ; (divmod + 53)
1b18 : a5 04 __ LDA WORK + 1 
1b1a : d0 1e __ BNE $1b3a ; (divmod + 38)
1b1c : 85 06 __ STA WORK + 3 
1b1e : a2 04 __ LDX #$04
1b20 : 06 1b __ ASL ACCU + 0 
1b22 : 2a __ __ ROL
1b23 : c5 03 __ CMP WORK + 0 
1b25 : 90 02 __ BCC $1b29 ; (divmod + 21)
1b27 : e5 03 __ SBC WORK + 0 
1b29 : 26 1b __ ROL ACCU + 0 
1b2b : 2a __ __ ROL
1b2c : c5 03 __ CMP WORK + 0 
1b2e : 90 02 __ BCC $1b32 ; (divmod + 30)
1b30 : e5 03 __ SBC WORK + 0 
1b32 : 26 1b __ ROL ACCU + 0 
1b34 : ca __ __ DEX
1b35 : d0 eb __ BNE $1b22 ; (divmod + 14)
1b37 : 85 05 __ STA WORK + 2 
1b39 : 60 __ __ RTS
1b3a : a5 1b __ LDA ACCU + 0 
1b3c : 85 05 __ STA WORK + 2 
1b3e : a5 1c __ LDA ACCU + 1 
1b40 : 85 06 __ STA WORK + 3 
1b42 : a9 00 __ LDA #$00
1b44 : 85 1b __ STA ACCU + 0 
1b46 : 85 1c __ STA ACCU + 1 
1b48 : 60 __ __ RTS
1b49 : a5 04 __ LDA WORK + 1 
1b4b : d0 1f __ BNE $1b6c ; (divmod + 88)
1b4d : a5 03 __ LDA WORK + 0 
1b4f : 30 1b __ BMI $1b6c ; (divmod + 88)
1b51 : a9 00 __ LDA #$00
1b53 : 85 06 __ STA WORK + 3 
1b55 : a2 10 __ LDX #$10
1b57 : 06 1b __ ASL ACCU + 0 
1b59 : 26 1c __ ROL ACCU + 1 
1b5b : 2a __ __ ROL
1b5c : c5 03 __ CMP WORK + 0 
1b5e : 90 02 __ BCC $1b62 ; (divmod + 78)
1b60 : e5 03 __ SBC WORK + 0 
1b62 : 26 1b __ ROL ACCU + 0 
1b64 : 26 1c __ ROL ACCU + 1 
1b66 : ca __ __ DEX
1b67 : d0 f2 __ BNE $1b5b ; (divmod + 71)
1b69 : 85 05 __ STA WORK + 2 
1b6b : 60 __ __ RTS
1b6c : a9 00 __ LDA #$00
1b6e : 85 05 __ STA WORK + 2 
1b70 : 85 06 __ STA WORK + 3 
1b72 : 84 02 __ STY $02 
1b74 : a0 10 __ LDY #$10
1b76 : 18 __ __ CLC
1b77 : 26 1b __ ROL ACCU + 0 
1b79 : 26 1c __ ROL ACCU + 1 
1b7b : 26 05 __ ROL WORK + 2 
1b7d : 26 06 __ ROL WORK + 3 
1b7f : 38 __ __ SEC
1b80 : a5 05 __ LDA WORK + 2 
1b82 : e5 03 __ SBC WORK + 0 
1b84 : aa __ __ TAX
1b85 : a5 06 __ LDA WORK + 3 
1b87 : e5 04 __ SBC WORK + 1 
1b89 : 90 04 __ BCC $1b8f ; (divmod + 123)
1b8b : 86 05 __ STX WORK + 2 
1b8d : 85 06 __ STA WORK + 3 
1b8f : 88 __ __ DEY
1b90 : d0 e5 __ BNE $1b77 ; (divmod + 99)
1b92 : 26 1b __ ROL ACCU + 0 
1b94 : 26 1c __ ROL ACCU + 1 
1b96 : a4 02 __ LDY $02 
1b98 : 60 __ __ RTS
--------------------------------------------------------------------
mods16:
1b99 : 24 1c __ BIT ACCU + 1 
1b9b : 10 0d __ BPL $1baa ; (mods16 + 17)
1b9d : 20 f8 1a JSR $1af8 ; (negaccu + 0)
1ba0 : 24 04 __ BIT WORK + 1 
1ba2 : 10 0d __ BPL $1bb1 ; (mods16 + 24)
1ba4 : 20 06 1b JSR $1b06 ; (negtmp + 0)
1ba7 : 4c 14 1b JMP $1b14 ; (divmod + 0)
1baa : 24 04 __ BIT WORK + 1 
1bac : 10 f9 __ BPL $1ba7 ; (mods16 + 14)
1bae : 20 06 1b JSR $1b06 ; (negtmp + 0)
1bb1 : 20 14 1b JSR $1b14 ; (divmod + 0)
1bb4 : 38 __ __ SEC
1bb5 : a9 00 __ LDA #$00
1bb7 : e5 05 __ SBC WORK + 2 
1bb9 : 85 05 __ STA WORK + 2 
1bbb : a9 00 __ LDA #$00
1bbd : e5 06 __ SBC WORK + 3 
1bbf : 85 06 __ STA WORK + 3 
1bc1 : 60 __ __ RTS
--------------------------------------------------------------------
f32_to_i16:
1bc2 : 20 55 18 JSR $1855 ; (freg + 36)
1bc5 : a5 07 __ LDA WORK + 4 
1bc7 : c9 7f __ CMP #$7f
1bc9 : b0 07 __ BCS $1bd2 ; (f32_to_i16 + 16)
1bcb : a9 00 __ LDA #$00
1bcd : 85 1b __ STA ACCU + 0 
1bcf : 85 1c __ STA ACCU + 1 
1bd1 : 60 __ __ RTS
1bd2 : 38 __ __ SEC
1bd3 : e9 8e __ SBC #$8e
1bd5 : 90 0a __ BCC $1be1 ; (f32_to_i16 + 31)
1bd7 : a9 ff __ LDA #$ff
1bd9 : 85 1b __ STA ACCU + 0 
1bdb : a9 7f __ LDA #$7f
1bdd : 85 1c __ STA ACCU + 1 
1bdf : d0 08 __ BNE $1be9 ; (f32_to_i16 + 39)
1be1 : aa __ __ TAX
1be2 : 46 1d __ LSR ACCU + 2 
1be4 : 66 1c __ ROR ACCU + 1 
1be6 : e8 __ __ INX
1be7 : d0 f9 __ BNE $1be2 ; (f32_to_i16 + 32)
1be9 : 24 1e __ BIT ACCU + 3 
1beb : 10 0e __ BPL $1bfb ; (f32_to_i16 + 57)
1bed : 38 __ __ SEC
1bee : a9 00 __ LDA #$00
1bf0 : e5 1c __ SBC ACCU + 1 
1bf2 : 85 1b __ STA ACCU + 0 
1bf4 : a9 00 __ LDA #$00
1bf6 : e5 1d __ SBC ACCU + 2 
1bf8 : 85 1c __ STA ACCU + 1 
1bfa : 60 __ __ RTS
1bfb : a5 1c __ LDA ACCU + 1 
1bfd : 85 1b __ STA ACCU + 0 
1bff : a5 1d __ LDA ACCU + 2 
1c01 : 85 1c __ STA ACCU + 1 
1c03 : 60 __ __ RTS
--------------------------------------------------------------------
sint16_to_float:
1c04 : 24 1c __ BIT ACCU + 1 
1c06 : 30 03 __ BMI $1c0b ; (sint16_to_float + 7)
1c08 : 4c 22 1c JMP $1c22 ; (uint16_to_float + 0)
1c0b : 38 __ __ SEC
1c0c : a9 00 __ LDA #$00
1c0e : e5 1b __ SBC ACCU + 0 
1c10 : 85 1b __ STA ACCU + 0 
1c12 : a9 00 __ LDA #$00
1c14 : e5 1c __ SBC ACCU + 1 
1c16 : 85 1c __ STA ACCU + 1 
1c18 : 20 22 1c JSR $1c22 ; (uint16_to_float + 0)
1c1b : a5 1e __ LDA ACCU + 3 
1c1d : 09 80 __ ORA #$80
1c1f : 85 1e __ STA ACCU + 3 
1c21 : 60 __ __ RTS
--------------------------------------------------------------------
uint16_to_float:
1c22 : a5 1b __ LDA ACCU + 0 
1c24 : 05 1c __ ORA ACCU + 1 
1c26 : d0 05 __ BNE $1c2d ; (uint16_to_float + 11)
1c28 : 85 1d __ STA ACCU + 2 
1c2a : 85 1e __ STA ACCU + 3 
1c2c : 60 __ __ RTS
1c2d : a2 8e __ LDX #$8e
1c2f : a5 1c __ LDA ACCU + 1 
1c31 : 30 06 __ BMI $1c39 ; (uint16_to_float + 23)
1c33 : ca __ __ DEX
1c34 : 06 1b __ ASL ACCU + 0 
1c36 : 2a __ __ ROL
1c37 : 10 fa __ BPL $1c33 ; (uint16_to_float + 17)
1c39 : 29 7f __ AND #$7f
1c3b : 85 1d __ STA ACCU + 2 
1c3d : a5 1b __ LDA ACCU + 0 
1c3f : 85 1c __ STA ACCU + 1 
1c41 : 8a __ __ TXA
1c42 : 4a __ __ LSR
1c43 : 85 1e __ STA ACCU + 3 
1c45 : a9 00 __ LDA #$00
1c47 : 85 1b __ STA ACCU + 0 
1c49 : 6a __ __ ROR
1c4a : 05 1d __ ORA ACCU + 2 
1c4c : 85 1d __ STA ACCU + 2 
1c4e : 60 __ __ RTS
--------------------------------------------------------------------
divmod32:
1c4f : 84 02 __ STY $02 
1c51 : a0 20 __ LDY #$20
1c53 : a9 00 __ LDA #$00
1c55 : 85 07 __ STA WORK + 4 
1c57 : 85 08 __ STA WORK + 5 
1c59 : 85 09 __ STA WORK + 6 
1c5b : 85 0a __ STA WORK + 7 
1c5d : a5 05 __ LDA WORK + 2 
1c5f : 05 06 __ ORA WORK + 3 
1c61 : d0 39 __ BNE $1c9c ; (divmod32 + 77)
1c63 : 18 __ __ CLC
1c64 : 26 1b __ ROL ACCU + 0 
1c66 : 26 1c __ ROL ACCU + 1 
1c68 : 26 1d __ ROL ACCU + 2 
1c6a : 26 1e __ ROL ACCU + 3 
1c6c : 26 07 __ ROL WORK + 4 
1c6e : 26 08 __ ROL WORK + 5 
1c70 : 90 0c __ BCC $1c7e ; (divmod32 + 47)
1c72 : a5 07 __ LDA WORK + 4 
1c74 : e5 03 __ SBC WORK + 0 
1c76 : aa __ __ TAX
1c77 : a5 08 __ LDA WORK + 5 
1c79 : e5 04 __ SBC WORK + 1 
1c7b : 38 __ __ SEC
1c7c : b0 0c __ BCS $1c8a ; (divmod32 + 59)
1c7e : 38 __ __ SEC
1c7f : a5 07 __ LDA WORK + 4 
1c81 : e5 03 __ SBC WORK + 0 
1c83 : aa __ __ TAX
1c84 : a5 08 __ LDA WORK + 5 
1c86 : e5 04 __ SBC WORK + 1 
1c88 : 90 04 __ BCC $1c8e ; (divmod32 + 63)
1c8a : 86 07 __ STX WORK + 4 
1c8c : 85 08 __ STA WORK + 5 
1c8e : 88 __ __ DEY
1c8f : d0 d3 __ BNE $1c64 ; (divmod32 + 21)
1c91 : 26 1b __ ROL ACCU + 0 
1c93 : 26 1c __ ROL ACCU + 1 
1c95 : 26 1d __ ROL ACCU + 2 
1c97 : 26 1e __ ROL ACCU + 3 
1c99 : a4 02 __ LDY $02 
1c9b : 60 __ __ RTS
1c9c : 18 __ __ CLC
1c9d : 26 1b __ ROL ACCU + 0 
1c9f : 26 1c __ ROL ACCU + 1 
1ca1 : 26 1d __ ROL ACCU + 2 
1ca3 : 26 1e __ ROL ACCU + 3 
1ca5 : 26 07 __ ROL WORK + 4 
1ca7 : 26 08 __ ROL WORK + 5 
1ca9 : 26 09 __ ROL WORK + 6 
1cab : 26 0a __ ROL WORK + 7 
1cad : a5 07 __ LDA WORK + 4 
1caf : c5 03 __ CMP WORK + 0 
1cb1 : a5 08 __ LDA WORK + 5 
1cb3 : e5 04 __ SBC WORK + 1 
1cb5 : a5 09 __ LDA WORK + 6 
1cb7 : e5 05 __ SBC WORK + 2 
1cb9 : a5 0a __ LDA WORK + 7 
1cbb : e5 06 __ SBC WORK + 3 
1cbd : 90 18 __ BCC $1cd7 ; (divmod32 + 136)
1cbf : a5 07 __ LDA WORK + 4 
1cc1 : e5 03 __ SBC WORK + 0 
1cc3 : 85 07 __ STA WORK + 4 
1cc5 : a5 08 __ LDA WORK + 5 
1cc7 : e5 04 __ SBC WORK + 1 
1cc9 : 85 08 __ STA WORK + 5 
1ccb : a5 09 __ LDA WORK + 6 
1ccd : e5 05 __ SBC WORK + 2 
1ccf : 85 09 __ STA WORK + 6 
1cd1 : a5 0a __ LDA WORK + 7 
1cd3 : e5 06 __ SBC WORK + 3 
1cd5 : 85 0a __ STA WORK + 7 
1cd7 : 88 __ __ DEY
1cd8 : d0 c3 __ BNE $1c9d ; (divmod32 + 78)
1cda : 26 1b __ ROL ACCU + 0 
1cdc : 26 1c __ ROL ACCU + 1 
1cde : 26 1d __ ROL ACCU + 2 
1ce0 : 26 1e __ ROL ACCU + 3 
1ce2 : a4 02 __ LDY $02 
1ce4 : 60 __ __ RTS
