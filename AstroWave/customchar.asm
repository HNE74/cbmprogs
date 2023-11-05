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
08d0 : bd e6 1c LDA $1ce6,x ; (divmod32 + 149)
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
0972 : 20 a1 17 JSR $17a1 ; (cwin_put_string.s0 + 0)
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
1ce7 : __ __ __ BYT 7c fe 92 fe 82 c6 7c 00 7c fe 92 fe c6 ba 7c 00 : |.....|.|.....|.
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
0b39 : ad fb 9f LDA $9ffb ; (sstack + 3)
0b3c : 85 50 __ STA T0 + 0 
0b3e : ad fc 9f LDA $9ffc ; (sstack + 4)
0b41 : 85 51 __ STA T0 + 1 
0b43 : ad f9 9f LDA $9ff9 ; (sstack + 1)
0b46 : 85 53 __ STA T1 + 0 
0b48 : ad fa 9f LDA $9ffa ; (sstack + 2)
0b4b : 85 54 __ STA T1 + 1 
0b4d : a9 00 __ LDA #$00
.l1057:
0b4f : 85 55 __ STA T2 + 0 
.l1:
0b51 : a0 00 __ LDY #$00
0b53 : b1 50 __ LDA (T0 + 0),y 
0b55 : d0 38 __ BNE $0b8f ; (sformat.s2 + 0)
.s3:
0b57 : a4 55 __ LDY T2 + 0 
0b59 : 91 53 __ STA (T1 + 0),y 
0b5b : 98 __ __ TYA
0b5c : f0 28 __ BEQ $0b86 ; (sformat.s1059 + 0)
.s112:
0b5e : ad ff 9f LDA $9fff ; (sstack + 7)
0b61 : d0 18 __ BNE $0b7b ; (sformat.s115 + 0)
.s116:
0b63 : 18 __ __ CLC
0b64 : a5 53 __ LDA T1 + 0 
0b66 : 65 55 __ ADC T2 + 0 
0b68 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0b6a : a5 54 __ LDA T1 + 1 
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
0b7b : a5 53 __ LDA T1 + 0 
0b7d : 85 0d __ STA P0 
0b7f : a5 54 __ LDA T1 + 1 
0b81 : 85 0e __ STA P1 
0b83 : 20 75 0f JSR $0f75 ; (puts.s0 + 0)
.s1059:
0b86 : a5 53 __ LDA T1 + 0 
0b88 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0b8a : a5 54 __ LDA T1 + 1 
0b8c : 4c 6e 0b JMP $0b6e ; (sformat.s1001 + 0)
.s2:
0b8f : c9 25 __ CMP #$25
0b91 : f0 3f __ BEQ $0bd2 ; (sformat.s4 + 0)
.s5:
0b93 : a4 55 __ LDY T2 + 0 
0b95 : 91 53 __ STA (T1 + 0),y 
0b97 : e6 50 __ INC T0 + 0 
0b99 : d0 02 __ BNE $0b9d ; (sformat.s1089 + 0)
.s1088:
0b9b : e6 51 __ INC T0 + 1 
.s1089:
0b9d : c8 __ __ INY
0b9e : 84 55 __ STY T2 + 0 
0ba0 : 98 __ __ TYA
0ba1 : c0 28 __ CPY #$28
0ba3 : 90 ac __ BCC $0b51 ; (sformat.l1 + 0)
.s106:
0ba5 : 85 57 __ STA T5 + 0 
0ba7 : a9 00 __ LDA #$00
0ba9 : 85 55 __ STA T2 + 0 
0bab : ad ff 9f LDA $9fff ; (sstack + 7)
0bae : f0 14 __ BEQ $0bc4 ; (sformat.s110 + 0)
.s109:
0bb0 : a5 53 __ LDA T1 + 0 
0bb2 : 85 0d __ STA P0 
0bb4 : a5 54 __ LDA T1 + 1 
0bb6 : 85 0e __ STA P1 
0bb8 : a9 00 __ LDA #$00
0bba : a4 57 __ LDY T5 + 0 
0bbc : 91 0d __ STA (P0),y 
0bbe : 20 75 0f JSR $0f75 ; (puts.s0 + 0)
0bc1 : 4c 51 0b JMP $0b51 ; (sformat.l1 + 0)
.s110:
0bc4 : 18 __ __ CLC
0bc5 : a5 53 __ LDA T1 + 0 
0bc7 : 65 57 __ ADC T5 + 0 
0bc9 : 85 53 __ STA T1 + 0 
0bcb : 90 84 __ BCC $0b51 ; (sformat.l1 + 0)
.s1090:
0bcd : e6 54 __ INC T1 + 1 
0bcf : 4c 51 0b JMP $0b51 ; (sformat.l1 + 0)
.s4:
0bd2 : a5 55 __ LDA T2 + 0 
0bd4 : f0 27 __ BEQ $0bfd ; (sformat.s9 + 0)
.s7:
0bd6 : 84 55 __ STY T2 + 0 
0bd8 : 85 57 __ STA T5 + 0 
0bda : ad ff 9f LDA $9fff ; (sstack + 7)
0bdd : f0 13 __ BEQ $0bf2 ; (sformat.s11 + 0)
.s10:
0bdf : a5 53 __ LDA T1 + 0 
0be1 : 85 0d __ STA P0 
0be3 : a5 54 __ LDA T1 + 1 
0be5 : 85 0e __ STA P1 
0be7 : 98 __ __ TYA
0be8 : a4 57 __ LDY T5 + 0 
0bea : 91 0d __ STA (P0),y 
0bec : 20 75 0f JSR $0f75 ; (puts.s0 + 0)
0bef : 4c fd 0b JMP $0bfd ; (sformat.s9 + 0)
.s11:
0bf2 : 18 __ __ CLC
0bf3 : a5 53 __ LDA T1 + 0 
0bf5 : 65 57 __ ADC T5 + 0 
0bf7 : 85 53 __ STA T1 + 0 
0bf9 : 90 02 __ BCC $0bfd ; (sformat.s9 + 0)
.s1086:
0bfb : e6 54 __ INC T1 + 1 
.s9:
0bfd : a9 0a __ LDA #$0a
0bff : 8d e3 9f STA $9fe3 ; (si + 3)
0c02 : a9 00 __ LDA #$00
0c04 : 8d e4 9f STA $9fe4 ; (si + 4)
0c07 : 8d e5 9f STA $9fe5 ; (si + 5)
0c0a : 8d e6 9f STA $9fe6 ; (si + 6)
0c0d : 8d e7 9f STA $9fe7 ; (si + 7)
0c10 : a0 01 __ LDY #$01
0c12 : b1 50 __ LDA (T0 + 0),y 
0c14 : aa __ __ TAX
0c15 : a9 20 __ LDA #$20
0c17 : 8d e0 9f STA $9fe0 ; (si + 0)
0c1a : a9 00 __ LDA #$00
0c1c : 8d e1 9f STA $9fe1 ; (si + 1)
0c1f : a9 ff __ LDA #$ff
0c21 : 8d e2 9f STA $9fe2 ; (si + 2)
0c24 : 18 __ __ CLC
0c25 : a5 50 __ LDA T0 + 0 
0c27 : 69 02 __ ADC #$02
.l14:
0c29 : 85 50 __ STA T0 + 0 
0c2b : 90 02 __ BCC $0c2f ; (sformat.s1071 + 0)
.s1070:
0c2d : e6 51 __ INC T0 + 1 
.s1071:
0c2f : 8a __ __ TXA
0c30 : e0 2b __ CPX #$2b
0c32 : d0 08 __ BNE $0c3c ; (sformat.s17 + 0)
.s16:
0c34 : a9 01 __ LDA #$01
0c36 : 8d e5 9f STA $9fe5 ; (si + 5)
0c39 : 4c 68 0f JMP $0f68 ; (sformat.s224 + 0)
.s17:
0c3c : c9 30 __ CMP #$30
0c3e : d0 06 __ BNE $0c46 ; (sformat.s20 + 0)
.s19:
0c40 : 8d e0 9f STA $9fe0 ; (si + 0)
0c43 : 4c 68 0f JMP $0f68 ; (sformat.s224 + 0)
.s20:
0c46 : e0 23 __ CPX #$23
0c48 : d0 08 __ BNE $0c52 ; (sformat.s23 + 0)
.s22:
0c4a : a9 01 __ LDA #$01
0c4c : 8d e7 9f STA $9fe7 ; (si + 7)
0c4f : 4c 68 0f JMP $0f68 ; (sformat.s224 + 0)
.s23:
0c52 : e0 2d __ CPX #$2d
0c54 : d0 08 __ BNE $0c5e ; (sformat.s15 + 0)
.s25:
0c56 : a9 01 __ LDA #$01
0c58 : 8d e6 9f STA $9fe6 ; (si + 6)
0c5b : 4c 68 0f JMP $0f68 ; (sformat.s224 + 0)
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
0c91 : 90 01 __ BCC $0c94 ; (sformat.s1083 + 0)
.s1082:
0c93 : e8 __ __ INX
.s1083:
0c94 : 38 __ __ SEC
0c95 : e9 30 __ SBC #$30
0c97 : 85 44 __ STA T6 + 0 
0c99 : 8a __ __ TXA
0c9a : e9 00 __ SBC #$00
0c9c : 85 45 __ STA T6 + 1 
0c9e : a0 00 __ LDY #$00
0ca0 : b1 50 __ LDA (T0 + 0),y 
0ca2 : 85 57 __ STA T5 + 0 
0ca4 : e6 50 __ INC T0 + 0 
0ca6 : d0 02 __ BNE $0caa ; (sformat.s1085 + 0)
.s1084:
0ca8 : e6 51 __ INC T0 + 1 
.s1085:
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
0cc5 : b1 50 __ LDA (T0 + 0),y 
0cc7 : 85 57 __ STA T5 + 0 
0cc9 : e6 50 __ INC T0 + 0 
0ccb : d0 02 __ BNE $0ccf ; (sformat.s1073 + 0)
.s1072:
0ccd : e6 51 __ INC T0 + 1 
.s1073:
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
0d00 : 90 01 __ BCC $0d03 ; (sformat.s1081 + 0)
.s1080:
0d02 : e8 __ __ INX
.s1081:
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
0d14 : 4c 2c 0f JMP $0f2c ; (sformat.s221 + 0)
.s45:
0d17 : c9 75 __ CMP #$75
0d19 : d0 03 __ BNE $0d1e ; (sformat.s48 + 0)
0d1b : 4c 2a 0f JMP $0f2a ; (sformat.s250 + 0)
.s48:
0d1e : c9 78 __ CMP #$78
0d20 : d0 0d __ BNE $0d2f ; (sformat.s51 + 0)
.s50:
0d22 : a9 10 __ LDA #$10
0d24 : 8d e3 9f STA $9fe3 ; (si + 3)
0d27 : a9 00 __ LDA #$00
0d29 : 8d e4 9f STA $9fe4 ; (si + 4)
0d2c : 4c 2a 0f JMP $0f2a ; (sformat.s250 + 0)
.s51:
0d2f : c9 6c __ CMP #$6c
0d31 : d0 03 __ BNE $0d36 ; (sformat.s54 + 0)
0d33 : 4c ae 0e JMP $0eae ; (sformat.s53 + 0)
.s54:
0d36 : c9 66 __ CMP #$66
0d38 : d0 03 __ BNE $0d3d ; (sformat.s69 + 0)
0d3a : 4c 5f 0e JMP $0e5f ; (sformat.s65 + 0)
.s69:
0d3d : c9 67 __ CMP #$67
0d3f : d0 03 __ BNE $0d44 ; (sformat.s68 + 0)
0d41 : 4c 5f 0e JMP $0e5f ; (sformat.s65 + 0)
.s68:
0d44 : c9 65 __ CMP #$65
0d46 : d0 03 __ BNE $0d4b ; (sformat.s66 + 0)
0d48 : 4c 5f 0e JMP $0e5f ; (sformat.s65 + 0)
.s66:
0d4b : c9 73 __ CMP #$73
0d4d : f0 4c __ BEQ $0d9b ; (sformat.s70 + 0)
.s71:
0d4f : c9 63 __ CMP #$63
0d51 : f0 1f __ BEQ $0d72 ; (sformat.s100 + 0)
.s101:
0d53 : 09 00 __ ORA #$00
0d55 : d0 03 __ BNE $0d5a ; (sformat.s103 + 0)
0d57 : 4c 51 0b JMP $0b51 ; (sformat.l1 + 0)
.s103:
0d5a : 18 __ __ CLC
0d5b : a5 53 __ LDA T1 + 0 
0d5d : 65 55 __ ADC T2 + 0 
0d5f : 85 44 __ STA T6 + 0 
0d61 : a5 54 __ LDA T1 + 1 
0d63 : 69 00 __ ADC #$00
0d65 : 85 45 __ STA T6 + 1 
0d67 : a5 57 __ LDA T5 + 0 
.s1056:
0d69 : a0 00 __ LDY #$00
0d6b : 91 44 __ STA (T6 + 0),y 
0d6d : e6 55 __ INC T2 + 0 
0d6f : 4c 51 0b JMP $0b51 ; (sformat.l1 + 0)
.s100:
0d72 : ad fd 9f LDA $9ffd ; (sstack + 5)
0d75 : 85 57 __ STA T5 + 0 
0d77 : 18 __ __ CLC
0d78 : 69 02 __ ADC #$02
0d7a : 8d fd 9f STA $9ffd ; (sstack + 5)
0d7d : ad fe 9f LDA $9ffe ; (sstack + 6)
0d80 : 85 58 __ STA T5 + 1 
0d82 : 69 00 __ ADC #$00
0d84 : 8d fe 9f STA $9ffe ; (sstack + 6)
0d87 : 18 __ __ CLC
0d88 : a5 53 __ LDA T1 + 0 
0d8a : 65 55 __ ADC T2 + 0 
0d8c : 85 44 __ STA T6 + 0 
0d8e : a5 54 __ LDA T1 + 1 
0d90 : 69 00 __ ADC #$00
0d92 : 85 45 __ STA T6 + 1 
0d94 : a0 00 __ LDY #$00
0d96 : b1 57 __ LDA (T5 + 0),y 
0d98 : 4c 69 0d JMP $0d69 ; (sformat.s1056 + 0)
.s70:
0d9b : ad fd 9f LDA $9ffd ; (sstack + 5)
0d9e : 85 57 __ STA T5 + 0 
0da0 : 18 __ __ CLC
0da1 : 69 02 __ ADC #$02
0da3 : 8d fd 9f STA $9ffd ; (sstack + 5)
0da6 : ad fe 9f LDA $9ffe ; (sstack + 6)
0da9 : 85 58 __ STA T5 + 1 
0dab : 69 00 __ ADC #$00
0dad : 8d fe 9f STA $9ffe ; (sstack + 6)
0db0 : a0 00 __ LDY #$00
0db2 : b1 57 __ LDA (T5 + 0),y 
0db4 : aa __ __ TAX
0db5 : c8 __ __ INY
0db6 : b1 57 __ LDA (T5 + 0),y 
0db8 : 86 57 __ STX T5 + 0 
0dba : 85 58 __ STA T5 + 1 
0dbc : a9 00 __ LDA #$00
0dbe : 85 52 __ STA T3 + 0 
0dc0 : ad e1 9f LDA $9fe1 ; (si + 1)
0dc3 : f0 0c __ BEQ $0dd1 ; (sformat.s75 + 0)
.s1062:
0dc5 : 88 __ __ DEY
0dc6 : b1 57 __ LDA (T5 + 0),y 
0dc8 : f0 05 __ BEQ $0dcf ; (sformat.s1063 + 0)
.l77:
0dca : c8 __ __ INY
0dcb : b1 57 __ LDA (T5 + 0),y 
0dcd : d0 fb __ BNE $0dca ; (sformat.l77 + 0)
.s1063:
0dcf : 84 52 __ STY T3 + 0 
.s75:
0dd1 : ad e6 9f LDA $9fe6 ; (si + 6)
0dd4 : d0 19 __ BNE $0def ; (sformat.s81 + 0)
.s1066:
0dd6 : a6 52 __ LDX T3 + 0 
0dd8 : ec e1 9f CPX $9fe1 ; (si + 1)
0ddb : a4 55 __ LDY T2 + 0 
0ddd : b0 0c __ BCS $0deb ; (sformat.s1067 + 0)
.l83:
0ddf : ad e0 9f LDA $9fe0 ; (si + 0)
0de2 : 91 53 __ STA (T1 + 0),y 
0de4 : e8 __ __ INX
0de5 : ec e1 9f CPX $9fe1 ; (si + 1)
0de8 : c8 __ __ INY
0de9 : 90 f4 __ BCC $0ddf ; (sformat.l83 + 0)
.s1067:
0deb : 86 52 __ STX T3 + 0 
0ded : 84 55 __ STY T2 + 0 
.s81:
0def : ad ff 9f LDA $9fff ; (sstack + 7)
0df2 : d0 37 __ BNE $0e2b ; (sformat.s85 + 0)
.l91:
0df4 : a0 00 __ LDY #$00
0df6 : b1 57 __ LDA (T5 + 0),y 
0df8 : f0 0f __ BEQ $0e09 ; (sformat.s211 + 0)
.s92:
0dfa : a4 55 __ LDY T2 + 0 
0dfc : 91 53 __ STA (T1 + 0),y 
0dfe : e6 55 __ INC T2 + 0 
0e00 : e6 57 __ INC T5 + 0 
0e02 : d0 f0 __ BNE $0df4 ; (sformat.l91 + 0)
.s1078:
0e04 : e6 58 __ INC T5 + 1 
0e06 : 4c f4 0d JMP $0df4 ; (sformat.l91 + 0)
.s211:
0e09 : ad e6 9f LDA $9fe6 ; (si + 6)
0e0c : d0 03 __ BNE $0e11 ; (sformat.s1064 + 0)
0e0e : 4c 51 0b JMP $0b51 ; (sformat.l1 + 0)
.s1064:
0e11 : a6 52 __ LDX T3 + 0 
0e13 : ec e1 9f CPX $9fe1 ; (si + 1)
0e16 : a4 55 __ LDY T2 + 0 
0e18 : b0 0c __ BCS $0e26 ; (sformat.s1065 + 0)
.l98:
0e1a : ad e0 9f LDA $9fe0 ; (si + 0)
0e1d : 91 53 __ STA (T1 + 0),y 
0e1f : e8 __ __ INX
0e20 : ec e1 9f CPX $9fe1 ; (si + 1)
0e23 : c8 __ __ INY
0e24 : 90 f4 __ BCC $0e1a ; (sformat.l98 + 0)
.s1065:
0e26 : 84 55 __ STY T2 + 0 
0e28 : 4c 51 0b JMP $0b51 ; (sformat.l1 + 0)
.s85:
0e2b : a5 55 __ LDA T2 + 0 
0e2d : f0 22 __ BEQ $0e51 ; (sformat.s90 + 0)
.s88:
0e2f : a5 53 __ LDA T1 + 0 
0e31 : 85 0d __ STA P0 
0e33 : a5 54 __ LDA T1 + 1 
0e35 : 85 0e __ STA P1 
0e37 : a9 00 __ LDA #$00
0e39 : a4 55 __ LDY T2 + 0 
0e3b : 91 0d __ STA (P0),y 
0e3d : 20 75 0f JSR $0f75 ; (puts.s0 + 0)
0e40 : a5 57 __ LDA T5 + 0 
0e42 : 85 0d __ STA P0 
0e44 : a5 58 __ LDA T5 + 1 
0e46 : 85 0e __ STA P1 
0e48 : 20 75 0f JSR $0f75 ; (puts.s0 + 0)
0e4b : a9 00 __ LDA #$00
0e4d : 85 55 __ STA T2 + 0 
0e4f : f0 b8 __ BEQ $0e09 ; (sformat.s211 + 0)
.s90:
0e51 : a5 57 __ LDA T5 + 0 
0e53 : 85 0d __ STA P0 
0e55 : a5 58 __ LDA T5 + 1 
0e57 : 85 0e __ STA P1 
0e59 : 20 75 0f JSR $0f75 ; (puts.s0 + 0)
0e5c : 4c 09 0e JMP $0e09 ; (sformat.s211 + 0)
.s65:
0e5f : a5 53 __ LDA T1 + 0 
0e61 : 85 13 __ STA P6 
0e63 : a5 54 __ LDA T1 + 1 
0e65 : 85 14 __ STA P7 
0e67 : a5 57 __ LDA T5 + 0 
0e69 : 8d f8 9f STA $9ff8 ; (sstack + 0)
0e6c : a9 e0 __ LDA #$e0
0e6e : 85 11 __ STA P4 
0e70 : a9 9f __ LDA #$9f
0e72 : 85 12 __ STA P5 
0e74 : ad fd 9f LDA $9ffd ; (sstack + 5)
0e77 : 85 55 __ STA T2 + 0 
0e79 : ad fe 9f LDA $9ffe ; (sstack + 6)
0e7c : 85 56 __ STA T2 + 1 
0e7e : a0 00 __ LDY #$00
0e80 : b1 55 __ LDA (T2 + 0),y 
0e82 : 85 15 __ STA P8 
0e84 : c8 __ __ INY
0e85 : b1 55 __ LDA (T2 + 0),y 
0e87 : 85 16 __ STA P9 
0e89 : c8 __ __ INY
0e8a : b1 55 __ LDA (T2 + 0),y 
0e8c : 85 17 __ STA P10 
0e8e : c8 __ __ INY
0e8f : b1 55 __ LDA (T2 + 0),y 
0e91 : 85 18 __ STA P11 
0e93 : 20 c1 12 JSR $12c1 ; (nformf.s0 + 0)
0e96 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0e98 : 85 55 __ STA T2 + 0 
0e9a : ad fd 9f LDA $9ffd ; (sstack + 5)
0e9d : 18 __ __ CLC
0e9e : 69 04 __ ADC #$04
0ea0 : 8d fd 9f STA $9ffd ; (sstack + 5)
0ea3 : b0 03 __ BCS $0ea8 ; (sformat.s1076 + 0)
0ea5 : 4c 51 0b JMP $0b51 ; (sformat.l1 + 0)
.s1076:
0ea8 : ee fe 9f INC $9ffe ; (sstack + 6)
0eab : 4c 51 0b JMP $0b51 ; (sformat.l1 + 0)
.s53:
0eae : ad fd 9f LDA $9ffd ; (sstack + 5)
0eb1 : 85 57 __ STA T5 + 0 
0eb3 : 18 __ __ CLC
0eb4 : 69 04 __ ADC #$04
0eb6 : 8d fd 9f STA $9ffd ; (sstack + 5)
0eb9 : ad fe 9f LDA $9ffe ; (sstack + 6)
0ebc : 85 58 __ STA T5 + 1 
0ebe : 69 00 __ ADC #$00
0ec0 : 8d fe 9f STA $9ffe ; (sstack + 6)
0ec3 : a0 00 __ LDY #$00
0ec5 : b1 57 __ LDA (T5 + 0),y 
0ec7 : 85 46 __ STA T7 + 0 
0ec9 : c8 __ __ INY
0eca : b1 57 __ LDA (T5 + 0),y 
0ecc : 85 47 __ STA T7 + 1 
0ece : c8 __ __ INY
0ecf : b1 57 __ LDA (T5 + 0),y 
0ed1 : 85 48 __ STA T7 + 2 
0ed3 : c8 __ __ INY
0ed4 : b1 57 __ LDA (T5 + 0),y 
0ed6 : 85 49 __ STA T7 + 3 
0ed8 : a0 00 __ LDY #$00
0eda : b1 50 __ LDA (T0 + 0),y 
0edc : aa __ __ TAX
0edd : e6 50 __ INC T0 + 0 
0edf : d0 02 __ BNE $0ee3 ; (sformat.s1075 + 0)
.s1074:
0ee1 : e6 51 __ INC T0 + 1 
.s1075:
0ee3 : 8a __ __ TXA
0ee4 : e0 64 __ CPX #$64
0ee6 : d0 04 __ BNE $0eec ; (sformat.s57 + 0)
.s56:
0ee8 : a9 01 __ LDA #$01
0eea : d0 14 __ BNE $0f00 ; (sformat.s222 + 0)
.s57:
0eec : c9 75 __ CMP #$75
0eee : f0 0f __ BEQ $0eff ; (sformat.s251 + 0)
.s60:
0ef0 : c9 78 __ CMP #$78
0ef2 : f0 03 __ BEQ $0ef7 ; (sformat.s62 + 0)
0ef4 : 4c 51 0b JMP $0b51 ; (sformat.l1 + 0)
.s62:
0ef7 : 8c e4 9f STY $9fe4 ; (si + 4)
0efa : a9 10 __ LDA #$10
0efc : 8d e3 9f STA $9fe3 ; (si + 3)
.s251:
0eff : 98 __ __ TYA
.s222:
0f00 : 85 15 __ STA P8 
0f02 : a5 53 __ LDA T1 + 0 
0f04 : 85 0f __ STA P2 
0f06 : a5 54 __ LDA T1 + 1 
0f08 : 85 10 __ STA P3 
0f0a : a5 46 __ LDA T7 + 0 
0f0c : 85 11 __ STA P4 
0f0e : a5 47 __ LDA T7 + 1 
0f10 : 85 12 __ STA P5 
0f12 : a5 48 __ LDA T7 + 2 
0f14 : 85 13 __ STA P6 
0f16 : a5 49 __ LDA T7 + 3 
0f18 : 85 14 __ STA P7 
0f1a : a9 e0 __ LDA #$e0
0f1c : 85 0d __ STA P0 
0f1e : a9 9f __ LDA #$9f
0f20 : 85 0e __ STA P1 
0f22 : 20 29 11 JSR $1129 ; (nforml.s0 + 0)
.s1058:
0f25 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0f27 : 4c 4f 0b JMP $0b4f ; (sformat.l1057 + 0)
.s250:
0f2a : a9 00 __ LDA #$00
.s221:
0f2c : 85 13 __ STA P6 
0f2e : a5 53 __ LDA T1 + 0 
0f30 : 85 0f __ STA P2 
0f32 : a5 54 __ LDA T1 + 1 
0f34 : 85 10 __ STA P3 
0f36 : ad fd 9f LDA $9ffd ; (sstack + 5)
0f39 : 85 55 __ STA T2 + 0 
0f3b : ad fe 9f LDA $9ffe ; (sstack + 6)
0f3e : 85 56 __ STA T2 + 1 
0f40 : a0 00 __ LDY #$00
0f42 : b1 55 __ LDA (T2 + 0),y 
0f44 : 85 11 __ STA P4 
0f46 : c8 __ __ INY
0f47 : b1 55 __ LDA (T2 + 0),y 
0f49 : 85 12 __ STA P5 
0f4b : 18 __ __ CLC
0f4c : a5 55 __ LDA T2 + 0 
0f4e : 69 02 __ ADC #$02
0f50 : 8d fd 9f STA $9ffd ; (sstack + 5)
0f53 : a5 56 __ LDA T2 + 1 
0f55 : 69 00 __ ADC #$00
0f57 : 8d fe 9f STA $9ffe ; (sstack + 6)
0f5a : a9 e0 __ LDA #$e0
0f5c : 85 0d __ STA P0 
0f5e : a9 9f __ LDA #$9f
0f60 : 85 0e __ STA P1 
0f62 : 20 ca 0f JSR $0fca ; (nformi.s0 + 0)
0f65 : 4c 25 0f JMP $0f25 ; (sformat.s1058 + 0)
.s224:
0f68 : a0 00 __ LDY #$00
0f6a : b1 50 __ LDA (T0 + 0),y 
0f6c : aa __ __ TAX
0f6d : 18 __ __ CLC
0f6e : a5 50 __ LDA T0 + 0 
0f70 : 69 01 __ ADC #$01
0f72 : 4c 29 0c JMP $0c29 ; (sformat.l14 + 0)
--------------------------------------------------------------------
puts:
.s0:
0f75 : a0 00 __ LDY #$00
0f77 : b1 0d __ LDA (P0),y 
0f79 : f0 0b __ BEQ $0f86 ; (puts.s1001 + 0)
0f7b : 20 87 0f JSR $0f87 ; (putpch + 0)
0f7e : e6 0d __ INC P0 
0f80 : d0 f3 __ BNE $0f75 ; (puts.s0 + 0)
0f82 : e6 0e __ INC P1 
0f84 : d0 ef __ BNE $0f75 ; (puts.s0 + 0)
.s1001:
0f86 : 60 __ __ RTS
--------------------------------------------------------------------
putpch:
0f87 : ae ff 09 LDX $09ff ; (giocharmap + 0)
0f8a : e0 01 __ CPX #$01
0f8c : 90 26 __ BCC $0fb4 ; (putpch + 45)
0f8e : c9 0a __ CMP #$0a
0f90 : d0 02 __ BNE $0f94 ; (putpch + 13)
0f92 : a9 0d __ LDA #$0d
0f94 : c9 09 __ CMP #$09
0f96 : f0 1f __ BEQ $0fb7 ; (putpch + 48)
0f98 : e0 02 __ CPX #$02
0f9a : 90 18 __ BCC $0fb4 ; (putpch + 45)
0f9c : c9 41 __ CMP #$41
0f9e : 90 14 __ BCC $0fb4 ; (putpch + 45)
0fa0 : c9 7b __ CMP #$7b
0fa2 : b0 10 __ BCS $0fb4 ; (putpch + 45)
0fa4 : c9 61 __ CMP #$61
0fa6 : b0 04 __ BCS $0fac ; (putpch + 37)
0fa8 : c9 5b __ CMP #$5b
0faa : b0 08 __ BCS $0fb4 ; (putpch + 45)
0fac : 49 20 __ EOR #$20
0fae : e0 03 __ CPX #$03
0fb0 : f0 02 __ BEQ $0fb4 ; (putpch + 45)
0fb2 : 29 df __ AND #$df
0fb4 : 4c d2 ff JMP $ffd2 
0fb7 : 38 __ __ SEC
0fb8 : 20 f0 ff JSR $fff0 
0fbb : 98 __ __ TYA
0fbc : 29 03 __ AND #$03
0fbe : 49 03 __ EOR #$03
0fc0 : aa __ __ TAX
0fc1 : a9 20 __ LDA #$20
0fc3 : 20 d2 ff JSR $ffd2 
0fc6 : ca __ __ DEX
0fc7 : 10 fa __ BPL $0fc3 ; (putpch + 60)
0fc9 : 60 __ __ RTS
--------------------------------------------------------------------
giocharmap:
09ff : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
nformi:
.s0:
0fca : a9 00 __ LDA #$00
0fcc : 85 43 __ STA T1 + 0 
0fce : a5 13 __ LDA P6 ; (s + 0)
0fd0 : f0 15 __ BEQ $0fe7 ; (nformi.s159 + 0)
.s4:
0fd2 : a5 12 __ LDA P5 ; (v + 1)
0fd4 : 10 11 __ BPL $0fe7 ; (nformi.s159 + 0)
.s1:
0fd6 : 38 __ __ SEC
0fd7 : a9 00 __ LDA #$00
0fd9 : e5 11 __ SBC P4 ; (v + 0)
0fdb : 85 11 __ STA P4 ; (v + 0)
0fdd : a9 00 __ LDA #$00
0fdf : e5 12 __ SBC P5 ; (v + 1)
0fe1 : 85 12 __ STA P5 ; (v + 1)
0fe3 : a9 01 __ LDA #$01
0fe5 : 85 43 __ STA T1 + 0 
.s159:
0fe7 : a9 10 __ LDA #$10
0fe9 : 85 44 __ STA T2 + 0 
0feb : a5 11 __ LDA P4 ; (v + 0)
0fed : 05 12 __ ORA P5 ; (v + 1)
0fef : f0 61 __ BEQ $1052 ; (nformi.s7 + 0)
.s45:
0ff1 : a5 0d __ LDA P0 ; (si + 0)
0ff3 : 85 45 __ STA T4 + 0 
0ff5 : a5 0e __ LDA P1 ; (si + 1)
0ff7 : 85 46 __ STA T4 + 1 
.l6:
0ff9 : a0 03 __ LDY #$03
0ffb : b1 45 __ LDA (T4 + 0),y 
0ffd : 85 47 __ STA T5 + 0 
0fff : 85 03 __ STA WORK + 0 
1001 : c8 __ __ INY
1002 : b1 45 __ LDA (T4 + 0),y 
1004 : 85 48 __ STA T5 + 1 
1006 : 85 04 __ STA WORK + 1 
1008 : a5 11 __ LDA P4 ; (v + 0)
100a : 85 1b __ STA ACCU + 0 
100c : a5 12 __ LDA P5 ; (v + 1)
100e : 85 1c __ STA ACCU + 1 
1010 : 20 16 1b JSR $1b16 ; (divmod + 0)
1013 : a5 06 __ LDA WORK + 3 
1015 : 30 10 __ BMI $1027 ; (nformi.s9 + 0)
.s1019:
1017 : d0 06 __ BNE $101f ; (nformi.s8 + 0)
.s1018:
1019 : a5 05 __ LDA WORK + 2 
101b : c9 0a __ CMP #$0a
101d : 90 08 __ BCC $1027 ; (nformi.s9 + 0)
.s8:
101f : 18 __ __ CLC
1020 : a5 05 __ LDA WORK + 2 
1022 : 69 37 __ ADC #$37
1024 : 4c 2c 10 JMP $102c ; (nformi.s10 + 0)
.s9:
1027 : 18 __ __ CLC
1028 : a5 05 __ LDA WORK + 2 
102a : 69 30 __ ADC #$30
.s10:
102c : c6 44 __ DEC T2 + 0 
102e : a6 44 __ LDX T2 + 0 
1030 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1033 : a5 11 __ LDA P4 ; (v + 0)
1035 : 85 1b __ STA ACCU + 0 
1037 : a5 12 __ LDA P5 ; (v + 1)
1039 : 85 1c __ STA ACCU + 1 
103b : a5 47 __ LDA T5 + 0 
103d : 85 03 __ STA WORK + 0 
103f : a5 48 __ LDA T5 + 1 
1041 : 85 04 __ STA WORK + 1 
1043 : 20 16 1b JSR $1b16 ; (divmod + 0)
1046 : a5 1b __ LDA ACCU + 0 
1048 : 85 11 __ STA P4 ; (v + 0)
104a : a5 1c __ LDA ACCU + 1 
104c : 85 12 __ STA P5 ; (v + 1)
104e : 05 11 __ ORA P4 ; (v + 0)
1050 : d0 a7 __ BNE $0ff9 ; (nformi.l6 + 0)
.s7:
1052 : a5 0d __ LDA P0 ; (si + 0)
1054 : 85 11 __ STA P4 ; (v + 0)
1056 : a5 0e __ LDA P1 ; (si + 1)
1058 : 85 12 __ STA P5 ; (v + 1)
105a : a0 02 __ LDY #$02
105c : b1 0d __ LDA (P0),y ; (si + 0)
105e : c9 ff __ CMP #$ff
1060 : d0 04 __ BNE $1066 ; (nformi.s76 + 0)
.s77:
1062 : a9 0f __ LDA #$0f
1064 : d0 05 __ BNE $106b ; (nformi.s1026 + 0)
.s76:
1066 : 38 __ __ SEC
1067 : a9 10 __ LDA #$10
1069 : f1 0d __ SBC (P0),y ; (si + 0)
.s1026:
106b : a8 __ __ TAY
106c : c4 44 __ CPY T2 + 0 
106e : b0 0d __ BCS $107d ; (nformi.s13 + 0)
.s12:
1070 : a9 30 __ LDA #$30
.l1027:
1072 : c6 44 __ DEC T2 + 0 
1074 : a6 44 __ LDX T2 + 0 
1076 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1079 : c4 44 __ CPY T2 + 0 
107b : 90 f5 __ BCC $1072 ; (nformi.l1027 + 0)
.s13:
107d : a0 07 __ LDY #$07
107f : b1 0d __ LDA (P0),y ; (si + 0)
1081 : f0 20 __ BEQ $10a3 ; (nformi.s16 + 0)
.s17:
1083 : a0 04 __ LDY #$04
1085 : b1 0d __ LDA (P0),y ; (si + 0)
1087 : d0 1a __ BNE $10a3 ; (nformi.s16 + 0)
.s1013:
1089 : 88 __ __ DEY
108a : b1 0d __ LDA (P0),y ; (si + 0)
108c : c9 10 __ CMP #$10
108e : d0 13 __ BNE $10a3 ; (nformi.s16 + 0)
.s14:
1090 : a9 58 __ LDA #$58
1092 : a6 44 __ LDX T2 + 0 
1094 : 9d e7 9f STA $9fe7,x ; (si + 7)
1097 : 8a __ __ TXA
1098 : 18 __ __ CLC
1099 : 69 fe __ ADC #$fe
109b : 85 44 __ STA T2 + 0 
109d : aa __ __ TAX
109e : a9 30 __ LDA #$30
10a0 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s16:
10a3 : a9 00 __ LDA #$00
10a5 : 85 1b __ STA ACCU + 0 
10a7 : a5 43 __ LDA T1 + 0 
10a9 : f0 06 __ BEQ $10b1 ; (nformi.s19 + 0)
.s18:
10ab : c6 44 __ DEC T2 + 0 
10ad : a9 2d __ LDA #$2d
10af : d0 0a __ BNE $10bb ; (nformi.s1025 + 0)
.s19:
10b1 : a0 05 __ LDY #$05
10b3 : b1 0d __ LDA (P0),y ; (si + 0)
10b5 : f0 09 __ BEQ $10c0 ; (nformi.s141 + 0)
.s21:
10b7 : c6 44 __ DEC T2 + 0 
10b9 : a9 2b __ LDA #$2b
.s1025:
10bb : a6 44 __ LDX T2 + 0 
10bd : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s141:
10c0 : a0 06 __ LDY #$06
10c2 : b1 0d __ LDA (P0),y ; (si + 0)
10c4 : d0 37 __ BNE $10fd ; (nformi.s27 + 0)
.l33:
10c6 : a0 01 __ LDY #$01
10c8 : b1 11 __ LDA (P4),y ; (v + 0)
10ca : 18 __ __ CLC
10cb : 65 44 __ ADC T2 + 0 
10cd : b0 04 __ BCS $10d3 ; (nformi.s34 + 0)
.s1006:
10cf : c9 11 __ CMP #$11
10d1 : 90 0e __ BCC $10e1 ; (nformi.s36 + 0)
.s34:
10d3 : c6 44 __ DEC T2 + 0 
10d5 : a0 00 __ LDY #$00
10d7 : b1 11 __ LDA (P4),y ; (v + 0)
10d9 : a6 44 __ LDX T2 + 0 
10db : 9d e8 9f STA $9fe8,x ; (buffer + 0)
10de : 4c c6 10 JMP $10c6 ; (nformi.l33 + 0)
.s36:
10e1 : a6 44 __ LDX T2 + 0 
10e3 : e0 10 __ CPX #$10
10e5 : b0 11 __ BCS $10f8 ; (nformi.s26 + 0)
.s1022:
10e7 : 88 __ __ DEY
.l1031:
10e8 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
10eb : 91 0f __ STA (P2),y ; (str + 0)
10ed : e6 44 __ INC T2 + 0 
10ef : a6 44 __ LDX T2 + 0 
10f1 : e0 10 __ CPX #$10
10f3 : c8 __ __ INY
10f4 : 90 f2 __ BCC $10e8 ; (nformi.l1031 + 0)
.s1032:
10f6 : 84 1b __ STY ACCU + 0 
.s26:
10f8 : a9 00 __ LDA #$00
10fa : 85 1c __ STA ACCU + 1 
.s1001:
10fc : 60 __ __ RTS
.s27:
10fd : a6 44 __ LDX T2 + 0 
10ff : e0 10 __ CPX #$10
1101 : b0 12 __ BCS $1115 ; (nformi.l30 + 0)
.s1020:
1103 : a0 00 __ LDY #$00
.l1029:
1105 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
1108 : 91 0f __ STA (P2),y ; (str + 0)
110a : e6 44 __ INC T2 + 0 
110c : a6 44 __ LDX T2 + 0 
110e : e0 10 __ CPX #$10
1110 : c8 __ __ INY
1111 : 90 f2 __ BCC $1105 ; (nformi.l1029 + 0)
.s1030:
1113 : 84 1b __ STY ACCU + 0 
.l30:
1115 : a5 1b __ LDA ACCU + 0 
1117 : a0 01 __ LDY #$01
1119 : d1 11 __ CMP (P4),y ; (v + 0)
111b : b0 db __ BCS $10f8 ; (nformi.s26 + 0)
.s31:
111d : 88 __ __ DEY
111e : b1 11 __ LDA (P4),y ; (v + 0)
1120 : a4 1b __ LDY ACCU + 0 
1122 : 91 0f __ STA (P2),y ; (str + 0)
1124 : e6 1b __ INC ACCU + 0 
1126 : 4c 15 11 JMP $1115 ; (nformi.l30 + 0)
--------------------------------------------------------------------
nforml:
.s0:
1129 : a9 00 __ LDA #$00
112b : 85 43 __ STA T1 + 0 
112d : a5 15 __ LDA P8 ; (s + 0)
112f : f0 23 __ BEQ $1154 ; (nforml.s159 + 0)
.s4:
1131 : a5 14 __ LDA P7 ; (v + 3)
1133 : f0 1f __ BEQ $1154 ; (nforml.s159 + 0)
.s1032:
1135 : 10 1d __ BPL $1154 ; (nforml.s159 + 0)
.s1:
1137 : 38 __ __ SEC
1138 : a9 00 __ LDA #$00
113a : e5 11 __ SBC P4 ; (v + 0)
113c : 85 11 __ STA P4 ; (v + 0)
113e : a9 00 __ LDA #$00
1140 : e5 12 __ SBC P5 ; (v + 1)
1142 : 85 12 __ STA P5 ; (v + 1)
1144 : a9 00 __ LDA #$00
1146 : e5 13 __ SBC P6 ; (v + 2)
1148 : 85 13 __ STA P6 ; (v + 2)
114a : a9 00 __ LDA #$00
114c : e5 14 __ SBC P7 ; (v + 3)
114e : 85 14 __ STA P7 ; (v + 3)
1150 : a9 01 __ LDA #$01
1152 : 85 43 __ STA T1 + 0 
.s159:
1154 : a9 10 __ LDA #$10
1156 : 85 44 __ STA T2 + 0 
1158 : a5 14 __ LDA P7 ; (v + 3)
115a : f0 03 __ BEQ $115f ; (nforml.s1018 + 0)
115c : 4c 43 12 JMP $1243 ; (nforml.l6 + 0)
.s1018:
115f : a5 13 __ LDA P6 ; (v + 2)
1161 : f0 03 __ BEQ $1166 ; (nforml.s1019 + 0)
1163 : 4c 43 12 JMP $1243 ; (nforml.l6 + 0)
.s1019:
1166 : a5 12 __ LDA P5 ; (v + 1)
1168 : f0 03 __ BEQ $116d ; (nforml.s1020 + 0)
116a : 4c 43 12 JMP $1243 ; (nforml.l6 + 0)
.s1020:
116d : c5 11 __ CMP P4 ; (v + 0)
116f : b0 03 __ BCS $1174 ; (nforml.s7 + 0)
1171 : 4c 43 12 JMP $1243 ; (nforml.l6 + 0)
.s7:
1174 : a0 02 __ LDY #$02
1176 : b1 0d __ LDA (P0),y ; (si + 0)
1178 : c9 ff __ CMP #$ff
117a : d0 04 __ BNE $1180 ; (nforml.s76 + 0)
.s77:
117c : a9 0f __ LDA #$0f
117e : d0 05 __ BNE $1185 ; (nforml.s1039 + 0)
.s76:
1180 : 38 __ __ SEC
1181 : a9 10 __ LDA #$10
1183 : f1 0d __ SBC (P0),y ; (si + 0)
.s1039:
1185 : a8 __ __ TAY
1186 : c4 44 __ CPY T2 + 0 
1188 : b0 0d __ BCS $1197 ; (nforml.s13 + 0)
.s12:
118a : a9 30 __ LDA #$30
.l1040:
118c : c6 44 __ DEC T2 + 0 
118e : a6 44 __ LDX T2 + 0 
1190 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1193 : c4 44 __ CPY T2 + 0 
1195 : 90 f5 __ BCC $118c ; (nforml.l1040 + 0)
.s13:
1197 : a0 07 __ LDY #$07
1199 : b1 0d __ LDA (P0),y ; (si + 0)
119b : f0 20 __ BEQ $11bd ; (nforml.s16 + 0)
.s17:
119d : a0 04 __ LDY #$04
119f : b1 0d __ LDA (P0),y ; (si + 0)
11a1 : d0 1a __ BNE $11bd ; (nforml.s16 + 0)
.s1013:
11a3 : 88 __ __ DEY
11a4 : b1 0d __ LDA (P0),y ; (si + 0)
11a6 : c9 10 __ CMP #$10
11a8 : d0 13 __ BNE $11bd ; (nforml.s16 + 0)
.s14:
11aa : a9 58 __ LDA #$58
11ac : a6 44 __ LDX T2 + 0 
11ae : 9d e7 9f STA $9fe7,x ; (si + 7)
11b1 : 8a __ __ TXA
11b2 : 18 __ __ CLC
11b3 : 69 fe __ ADC #$fe
11b5 : 85 44 __ STA T2 + 0 
11b7 : aa __ __ TAX
11b8 : a9 30 __ LDA #$30
11ba : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s16:
11bd : a9 00 __ LDA #$00
11bf : 85 1b __ STA ACCU + 0 
11c1 : a5 43 __ LDA T1 + 0 
11c3 : f0 06 __ BEQ $11cb ; (nforml.s19 + 0)
.s18:
11c5 : c6 44 __ DEC T2 + 0 
11c7 : a9 2d __ LDA #$2d
11c9 : d0 0a __ BNE $11d5 ; (nforml.s1038 + 0)
.s19:
11cb : a0 05 __ LDY #$05
11cd : b1 0d __ LDA (P0),y ; (si + 0)
11cf : f0 09 __ BEQ $11da ; (nforml.s141 + 0)
.s21:
11d1 : c6 44 __ DEC T2 + 0 
11d3 : a9 2b __ LDA #$2b
.s1038:
11d5 : a6 44 __ LDX T2 + 0 
11d7 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s141:
11da : a0 06 __ LDY #$06
11dc : b1 0d __ LDA (P0),y ; (si + 0)
11de : d0 37 __ BNE $1217 ; (nforml.s27 + 0)
.l33:
11e0 : a0 01 __ LDY #$01
11e2 : b1 0d __ LDA (P0),y ; (si + 0)
11e4 : 18 __ __ CLC
11e5 : 65 44 __ ADC T2 + 0 
11e7 : b0 04 __ BCS $11ed ; (nforml.s34 + 0)
.s1006:
11e9 : c9 11 __ CMP #$11
11eb : 90 0e __ BCC $11fb ; (nforml.s36 + 0)
.s34:
11ed : c6 44 __ DEC T2 + 0 
11ef : a0 00 __ LDY #$00
11f1 : b1 0d __ LDA (P0),y ; (si + 0)
11f3 : a6 44 __ LDX T2 + 0 
11f5 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
11f8 : 4c e0 11 JMP $11e0 ; (nforml.l33 + 0)
.s36:
11fb : a6 44 __ LDX T2 + 0 
11fd : e0 10 __ CPX #$10
11ff : b0 11 __ BCS $1212 ; (nforml.s26 + 0)
.s1035:
1201 : 88 __ __ DEY
.l1044:
1202 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
1205 : 91 0f __ STA (P2),y ; (str + 0)
1207 : e6 44 __ INC T2 + 0 
1209 : a6 44 __ LDX T2 + 0 
120b : e0 10 __ CPX #$10
120d : c8 __ __ INY
120e : 90 f2 __ BCC $1202 ; (nforml.l1044 + 0)
.s1045:
1210 : 84 1b __ STY ACCU + 0 
.s26:
1212 : a9 00 __ LDA #$00
1214 : 85 1c __ STA ACCU + 1 
.s1001:
1216 : 60 __ __ RTS
.s27:
1217 : a6 44 __ LDX T2 + 0 
1219 : e0 10 __ CPX #$10
121b : b0 12 __ BCS $122f ; (nforml.l30 + 0)
.s1033:
121d : a0 00 __ LDY #$00
.l1042:
121f : bd e8 9f LDA $9fe8,x ; (buffer + 0)
1222 : 91 0f __ STA (P2),y ; (str + 0)
1224 : e6 44 __ INC T2 + 0 
1226 : a6 44 __ LDX T2 + 0 
1228 : e0 10 __ CPX #$10
122a : c8 __ __ INY
122b : 90 f2 __ BCC $121f ; (nforml.l1042 + 0)
.s1043:
122d : 84 1b __ STY ACCU + 0 
.l30:
122f : a5 1b __ LDA ACCU + 0 
1231 : a0 01 __ LDY #$01
1233 : d1 0d __ CMP (P0),y ; (si + 0)
1235 : b0 db __ BCS $1212 ; (nforml.s26 + 0)
.s31:
1237 : 88 __ __ DEY
1238 : b1 0d __ LDA (P0),y ; (si + 0)
123a : a4 1b __ LDY ACCU + 0 
123c : 91 0f __ STA (P2),y ; (str + 0)
123e : e6 1b __ INC ACCU + 0 
1240 : 4c 2f 12 JMP $122f ; (nforml.l30 + 0)
.l6:
1243 : a0 03 __ LDY #$03
1245 : b1 0d __ LDA (P0),y ; (si + 0)
1247 : 85 03 __ STA WORK + 0 
1249 : 85 45 __ STA T6 + 0 
124b : c8 __ __ INY
124c : b1 0d __ LDA (P0),y ; (si + 0)
124e : 85 46 __ STA T6 + 1 
1250 : 85 04 __ STA WORK + 1 
1252 : a5 11 __ LDA P4 ; (v + 0)
1254 : 85 1b __ STA ACCU + 0 
1256 : a5 12 __ LDA P5 ; (v + 1)
1258 : 85 1c __ STA ACCU + 1 
125a : a5 13 __ LDA P6 ; (v + 2)
125c : 85 1d __ STA ACCU + 2 
125e : a5 14 __ LDA P7 ; (v + 3)
1260 : 85 1e __ STA ACCU + 3 
1262 : a9 00 __ LDA #$00
1264 : 85 05 __ STA WORK + 2 
1266 : 85 06 __ STA WORK + 3 
1268 : 20 51 1c JSR $1c51 ; (divmod32 + 0)
126b : a5 08 __ LDA WORK + 5 
126d : 30 10 __ BMI $127f ; (nforml.s9 + 0)
.s1023:
126f : d0 06 __ BNE $1277 ; (nforml.s8 + 0)
.s1022:
1271 : a5 07 __ LDA WORK + 4 
1273 : c9 0a __ CMP #$0a
1275 : 90 08 __ BCC $127f ; (nforml.s9 + 0)
.s8:
1277 : 18 __ __ CLC
1278 : a5 07 __ LDA WORK + 4 
127a : 69 37 __ ADC #$37
127c : 4c 84 12 JMP $1284 ; (nforml.s10 + 0)
.s9:
127f : 18 __ __ CLC
1280 : a5 07 __ LDA WORK + 4 
1282 : 69 30 __ ADC #$30
.s10:
1284 : c6 44 __ DEC T2 + 0 
1286 : a6 44 __ LDX T2 + 0 
1288 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
128b : a5 11 __ LDA P4 ; (v + 0)
128d : 85 1b __ STA ACCU + 0 
128f : a5 12 __ LDA P5 ; (v + 1)
1291 : 85 1c __ STA ACCU + 1 
1293 : a5 13 __ LDA P6 ; (v + 2)
1295 : 85 1d __ STA ACCU + 2 
1297 : a5 14 __ LDA P7 ; (v + 3)
1299 : 85 1e __ STA ACCU + 3 
129b : a5 45 __ LDA T6 + 0 
129d : 85 03 __ STA WORK + 0 
129f : a5 46 __ LDA T6 + 1 
12a1 : 85 04 __ STA WORK + 1 
12a3 : a9 00 __ LDA #$00
12a5 : 85 05 __ STA WORK + 2 
12a7 : 85 06 __ STA WORK + 3 
12a9 : 20 51 1c JSR $1c51 ; (divmod32 + 0)
12ac : a5 1b __ LDA ACCU + 0 
12ae : 85 11 __ STA P4 ; (v + 0)
12b0 : a5 1c __ LDA ACCU + 1 
12b2 : 85 12 __ STA P5 ; (v + 1)
12b4 : a5 1d __ LDA ACCU + 2 
12b6 : 85 13 __ STA P6 ; (v + 2)
12b8 : a5 1e __ LDA ACCU + 3 
12ba : 85 14 __ STA P7 ; (v + 3)
12bc : d0 85 __ BNE $1243 ; (nforml.l6 + 0)
12be : 4c 5f 11 JMP $115f ; (nforml.s1018 + 0)
--------------------------------------------------------------------
nformf:
.s0:
12c1 : a5 15 __ LDA P8 ; (f + 0)
12c3 : 85 43 __ STA T1 + 0 
12c5 : a5 16 __ LDA P9 ; (f + 1)
12c7 : 85 44 __ STA T1 + 1 
12c9 : a5 17 __ LDA P10 ; (f + 2)
12cb : 85 45 __ STA T1 + 2 
12cd : a5 18 __ LDA P11 ; (f + 3)
12cf : 29 7f __ AND #$7f
12d1 : 05 17 __ ORA P10 ; (f + 2)
12d3 : 05 16 __ ORA P9 ; (f + 1)
12d5 : 05 15 __ ORA P8 ; (f + 0)
12d7 : f0 21 __ BEQ $12fa ; (nformf.s2 + 0)
.s1075:
12d9 : a5 18 __ LDA P11 ; (f + 3)
12db : 10 1d __ BPL $12fa ; (nformf.s2 + 0)
.s1:
12dd : a9 2d __ LDA #$2d
12df : a0 00 __ LDY #$00
12e1 : 91 13 __ STA (P6),y ; (str + 0)
12e3 : a5 18 __ LDA P11 ; (f + 3)
12e5 : 49 80 __ EOR #$80
12e7 : 85 18 __ STA P11 ; (f + 3)
12e9 : 85 10 __ STA P3 
12eb : a5 15 __ LDA P8 ; (f + 0)
12ed : 85 0d __ STA P0 
12ef : a5 16 __ LDA P9 ; (f + 1)
12f1 : 85 0e __ STA P1 
12f3 : a5 17 __ LDA P10 ; (f + 2)
12f5 : 85 0f __ STA P2 
12f7 : 4c 7a 17 JMP $177a ; (nformf.s189 + 0)
.s2:
12fa : a5 15 __ LDA P8 ; (f + 0)
12fc : 85 0d __ STA P0 
12fe : a5 16 __ LDA P9 ; (f + 1)
1300 : 85 0e __ STA P1 
1302 : a5 17 __ LDA P10 ; (f + 2)
1304 : 85 0f __ STA P2 
1306 : a5 18 __ LDA P11 ; (f + 3)
1308 : 85 10 __ STA P3 
130a : a0 05 __ LDY #$05
130c : b1 11 __ LDA (P4),y ; (si + 0)
130e : f0 09 __ BEQ $1319 ; (nformf.s3 + 0)
.s4:
1310 : a9 2b __ LDA #$2b
1312 : a0 00 __ LDY #$00
1314 : 91 13 __ STA (P6),y ; (str + 0)
1316 : 4c 7a 17 JMP $177a ; (nformf.s189 + 0)
.s3:
1319 : 20 92 17 JSR $1792 ; (isinf.s0 + 0)
131c : aa __ __ TAX
131d : a9 00 __ LDA #$00
131f : 85 48 __ STA T3 + 0 
1321 : 8a __ __ TXA
1322 : f0 0b __ BEQ $132f ; (nformf.s8 + 0)
.s160:
1324 : a9 01 __ LDA #$01
1326 : 85 4a __ STA T5 + 0 
1328 : a9 02 __ LDA #$02
132a : a0 00 __ LDY #$00
132c : 4c 5e 17 JMP $175e ; (nformf.s7 + 0)
.s8:
132f : a0 02 __ LDY #$02
1331 : b1 11 __ LDA (P4),y ; (si + 0)
1333 : c9 ff __ CMP #$ff
1335 : d0 02 __ BNE $1339 ; (nformf.s128 + 0)
.s129:
1337 : a9 06 __ LDA #$06
.s128:
1339 : 86 4a __ STX T5 + 0 
133b : 86 4b __ STX T5 + 1 
133d : 85 49 __ STA T4 + 0 
133f : 85 47 __ STA T2 + 0 
1341 : a5 18 __ LDA P11 ; (f + 3)
1343 : 85 46 __ STA T1 + 3 
1345 : 29 7f __ AND #$7f
1347 : 05 17 __ ORA P10 ; (f + 2)
1349 : 05 16 __ ORA P9 ; (f + 1)
134b : 05 15 __ ORA P8 ; (f + 0)
134d : f0 03 __ BEQ $1352 ; (nformf.s12 + 0)
134f : 4c 5f 16 JMP $165f ; (nformf.s13 + 0)
.s12:
1352 : ad f8 9f LDA $9ff8 ; (sstack + 0)
1355 : c9 65 __ CMP #$65
1357 : d0 04 __ BNE $135d ; (nformf.s1003 + 0)
.s1002:
1359 : a9 01 __ LDA #$01
135b : d0 02 __ BNE $135f ; (nformf.s1004 + 0)
.s1003:
135d : a9 00 __ LDA #$00
.s1004:
135f : 85 4e __ STA T9 + 0 
1361 : a6 49 __ LDX T4 + 0 
1363 : e8 __ __ INX
1364 : 86 4c __ STX T8 + 0 
1366 : ad f8 9f LDA $9ff8 ; (sstack + 0)
1369 : c9 67 __ CMP #$67
136b : d0 13 __ BNE $1380 ; (nformf.s24 + 0)
.s22:
136d : a5 4b __ LDA T5 + 1 
136f : 30 08 __ BMI $1379 ; (nformf.s25 + 0)
.s1046:
1371 : d0 06 __ BNE $1379 ; (nformf.s25 + 0)
.s1045:
1373 : a5 4a __ LDA T5 + 0 
1375 : c9 04 __ CMP #$04
1377 : 90 07 __ BCC $1380 ; (nformf.s24 + 0)
.s25:
1379 : a9 01 __ LDA #$01
137b : 85 4e __ STA T9 + 0 
137d : 4c d7 15 JMP $15d7 ; (nformf.s30 + 0)
.s24:
1380 : a5 4e __ LDA T9 + 0 
1382 : f0 03 __ BEQ $1387 ; (nformf.s32 + 0)
1384 : 4c d7 15 JMP $15d7 ; (nformf.s30 + 0)
.s32:
1387 : a5 4b __ LDA T5 + 1 
1389 : 10 3e __ BPL $13c9 ; (nformf.s34 + 0)
.s33:
138b : a5 43 __ LDA T1 + 0 
138d : 85 1b __ STA ACCU + 0 
138f : a5 44 __ LDA T1 + 1 
1391 : 85 1c __ STA ACCU + 1 
1393 : a5 45 __ LDA T1 + 2 
1395 : 85 1d __ STA ACCU + 2 
1397 : a5 46 __ LDA T1 + 3 
1399 : 85 1e __ STA ACCU + 3 
.l1082:
139b : e6 4a __ INC T5 + 0 
139d : d0 02 __ BNE $13a1 ; (nformf.s1092 + 0)
.s1091:
139f : e6 4b __ INC T5 + 1 
.s1092:
13a1 : a9 00 __ LDA #$00
13a3 : 85 03 __ STA WORK + 0 
13a5 : 85 04 __ STA WORK + 1 
13a7 : a9 20 __ LDA #$20
13a9 : 85 05 __ STA WORK + 2 
13ab : a9 41 __ LDA #$41
13ad : 85 06 __ STA WORK + 3 
13af : 20 47 18 JSR $1847 ; (freg + 20)
13b2 : 20 2e 1a JSR $1a2e ; (fdiv + 0)
13b5 : a5 4b __ LDA T5 + 1 
13b7 : 30 e2 __ BMI $139b ; (nformf.l1082 + 0)
.s1083:
13b9 : a5 1e __ LDA ACCU + 3 
13bb : 85 46 __ STA T1 + 3 
13bd : a5 1d __ LDA ACCU + 2 
13bf : 85 45 __ STA T1 + 2 
13c1 : a5 1c __ LDA ACCU + 1 
13c3 : 85 44 __ STA T1 + 1 
13c5 : a5 1b __ LDA ACCU + 0 
13c7 : 85 43 __ STA T1 + 0 
.s34:
13c9 : 18 __ __ CLC
13ca : a5 49 __ LDA T4 + 0 
13cc : 65 4a __ ADC T5 + 0 
13ce : 18 __ __ CLC
13cf : 69 01 __ ADC #$01
13d1 : 85 4c __ STA T8 + 0 
13d3 : c9 07 __ CMP #$07
13d5 : 90 13 __ BCC $13ea ; (nformf.s35 + 0)
.s36:
13d7 : ad 4b 1d LDA $1d4b ; (fround5 + 25)
13da : 85 1c __ STA ACCU + 1 
13dc : ad 4c 1d LDA $1d4c ; (fround5 + 26)
13df : 85 1d __ STA ACCU + 2 
13e1 : ad 4d 1d LDA $1d4d ; (fround5 + 27)
13e4 : ae 4a 1d LDX $1d4a ; (fround5 + 24)
13e7 : 4c fd 13 JMP $13fd ; (nformf.s214 + 0)
.s35:
13ea : 0a __ __ ASL
13eb : 0a __ __ ASL
13ec : a8 __ __ TAY
13ed : b9 2f 1d LDA $1d2f,y ; (mul40 + 47)
13f0 : 85 1c __ STA ACCU + 1 
13f2 : b9 30 1d LDA $1d30,y ; (mul40 + 48)
13f5 : 85 1d __ STA ACCU + 2 
13f7 : b9 31 1d LDA $1d31,y ; (mul40 + 49)
13fa : be 2e 1d LDX $1d2e,y ; (mul40 + 46)
.s214:
13fd : 86 1b __ STX ACCU + 0 
13ff : 85 1e __ STA ACCU + 3 
1401 : a2 43 __ LDX #$43
1403 : 20 37 18 JSR $1837 ; (freg + 4)
1406 : 20 78 18 JSR $1878 ; (faddsub + 0)
1409 : a5 1c __ LDA ACCU + 1 
140b : 85 16 __ STA P9 ; (f + 1)
140d : a5 1d __ LDA ACCU + 2 
140f : 85 17 __ STA P10 ; (f + 2)
1411 : a6 1b __ LDX ACCU + 0 
1413 : a5 1e __ LDA ACCU + 3 
1415 : 85 18 __ STA P11 ; (f + 3)
1417 : 30 35 __ BMI $144e ; (nformf.s31 + 0)
.s1028:
1419 : c9 41 __ CMP #$41
141b : d0 06 __ BNE $1423 ; (nformf.s1032 + 0)
.s1029:
141d : a5 17 __ LDA P10 ; (f + 2)
141f : c9 20 __ CMP #$20
1421 : f0 02 __ BEQ $1425 ; (nformf.s38 + 0)
.s1032:
1423 : 90 29 __ BCC $144e ; (nformf.s31 + 0)
.s38:
1425 : a9 00 __ LDA #$00
1427 : 85 03 __ STA WORK + 0 
1429 : 85 04 __ STA WORK + 1 
142b : a9 20 __ LDA #$20
142d : 85 05 __ STA WORK + 2 
142f : a9 41 __ LDA #$41
1431 : 85 06 __ STA WORK + 3 
1433 : 20 47 18 JSR $1847 ; (freg + 20)
1436 : 20 2e 1a JSR $1a2e ; (fdiv + 0)
1439 : a5 1c __ LDA ACCU + 1 
143b : 85 16 __ STA P9 ; (f + 1)
143d : a5 1d __ LDA ACCU + 2 
143f : 85 17 __ STA P10 ; (f + 2)
1441 : a5 1e __ LDA ACCU + 3 
1443 : 85 18 __ STA P11 ; (f + 3)
1445 : 18 __ __ CLC
1446 : a5 49 __ LDA T4 + 0 
1448 : 69 ff __ ADC #$ff
144a : 85 47 __ STA T2 + 0 
144c : a6 1b __ LDX ACCU + 0 
.s31:
144e : 38 __ __ SEC
144f : a5 4c __ LDA T8 + 0 
1451 : e5 47 __ SBC T2 + 0 
1453 : 85 49 __ STA T4 + 0 
1455 : a9 14 __ LDA #$14
1457 : c5 4c __ CMP T8 + 0 
1459 : b0 02 __ BCS $145d ; (nformf.s49 + 0)
.s47:
145b : 85 4c __ STA T8 + 0 
.s49:
145d : a5 49 __ LDA T4 + 0 
145f : d0 08 __ BNE $1469 ; (nformf.s219 + 0)
.s50:
1461 : a9 30 __ LDA #$30
1463 : a4 48 __ LDY T3 + 0 
1465 : 91 13 __ STA (P6),y ; (str + 0)
1467 : e6 48 __ INC T3 + 0 
.s219:
1469 : a9 00 __ LDA #$00
146b : 85 47 __ STA T2 + 0 
146d : c5 49 __ CMP T4 + 0 
146f : d0 08 __ BNE $1479 ; (nformf.l59 + 0)
.l57:
1471 : a9 2e __ LDA #$2e
1473 : a4 48 __ LDY T3 + 0 
1475 : 91 13 __ STA (P6),y ; (str + 0)
1477 : e6 48 __ INC T3 + 0 
.l59:
1479 : a5 47 __ LDA T2 + 0 
147b : c9 07 __ CMP #$07
147d : 90 04 __ BCC $1483 ; (nformf.s61 + 0)
.s60:
147f : a9 30 __ LDA #$30
1481 : d0 55 __ BNE $14d8 ; (nformf.s208 + 0)
.s61:
1483 : 86 1b __ STX ACCU + 0 
1485 : 86 43 __ STX T1 + 0 
1487 : a5 16 __ LDA P9 ; (f + 1)
1489 : 85 1c __ STA ACCU + 1 
148b : 85 44 __ STA T1 + 1 
148d : a5 17 __ LDA P10 ; (f + 2)
148f : 85 1d __ STA ACCU + 2 
1491 : 85 45 __ STA T1 + 2 
1493 : a5 18 __ LDA P11 ; (f + 3)
1495 : 85 1e __ STA ACCU + 3 
1497 : 85 46 __ STA T1 + 3 
1499 : 20 c4 1b JSR $1bc4 ; (f32_to_i16 + 0)
149c : a5 1b __ LDA ACCU + 0 
149e : 85 4f __ STA T11 + 0 
14a0 : 20 06 1c JSR $1c06 ; (sint16_to_float + 0)
14a3 : a2 43 __ LDX #$43
14a5 : 20 37 18 JSR $1837 ; (freg + 4)
14a8 : a5 1e __ LDA ACCU + 3 
14aa : 49 80 __ EOR #$80
14ac : 85 1e __ STA ACCU + 3 
14ae : 20 78 18 JSR $1878 ; (faddsub + 0)
14b1 : a9 00 __ LDA #$00
14b3 : 85 03 __ STA WORK + 0 
14b5 : 85 04 __ STA WORK + 1 
14b7 : a9 20 __ LDA #$20
14b9 : 85 05 __ STA WORK + 2 
14bb : a9 41 __ LDA #$41
14bd : 85 06 __ STA WORK + 3 
14bf : 20 47 18 JSR $1847 ; (freg + 20)
14c2 : 20 5f 19 JSR $195f ; (fmul + 0)
14c5 : a5 1c __ LDA ACCU + 1 
14c7 : 85 16 __ STA P9 ; (f + 1)
14c9 : a5 1d __ LDA ACCU + 2 
14cb : 85 17 __ STA P10 ; (f + 2)
14cd : a5 1e __ LDA ACCU + 3 
14cf : 85 18 __ STA P11 ; (f + 3)
14d1 : 18 __ __ CLC
14d2 : a5 4f __ LDA T11 + 0 
14d4 : 69 30 __ ADC #$30
14d6 : a6 1b __ LDX ACCU + 0 
.s208:
14d8 : a4 48 __ LDY T3 + 0 
14da : 91 13 __ STA (P6),y ; (str + 0)
14dc : e6 48 __ INC T3 + 0 
14de : e6 47 __ INC T2 + 0 
14e0 : a5 47 __ LDA T2 + 0 
14e2 : c5 4c __ CMP T8 + 0 
14e4 : b0 07 __ BCS $14ed ; (nformf.s56 + 0)
.s54:
14e6 : c5 49 __ CMP T4 + 0 
14e8 : d0 8f __ BNE $1479 ; (nformf.l59 + 0)
14ea : 4c 71 14 JMP $1471 ; (nformf.l57 + 0)
.s56:
14ed : a5 4e __ LDA T9 + 0 
14ef : f0 62 __ BEQ $1553 ; (nformf.s9 + 0)
.s63:
14f1 : a9 45 __ LDA #$45
14f3 : a4 48 __ LDY T3 + 0 
14f5 : 91 13 __ STA (P6),y ; (str + 0)
14f7 : c8 __ __ INY
14f8 : a5 4b __ LDA T5 + 1 
14fa : 30 06 __ BMI $1502 ; (nformf.s66 + 0)
.s67:
14fc : a9 2b __ LDA #$2b
14fe : 91 13 __ STA (P6),y ; (str + 0)
1500 : d0 11 __ BNE $1513 ; (nformf.s68 + 0)
.s66:
1502 : a9 2d __ LDA #$2d
1504 : 91 13 __ STA (P6),y ; (str + 0)
1506 : 38 __ __ SEC
1507 : a9 00 __ LDA #$00
1509 : e5 4a __ SBC T5 + 0 
150b : 85 4a __ STA T5 + 0 
150d : a9 00 __ LDA #$00
150f : e5 4b __ SBC T5 + 1 
1511 : 85 4b __ STA T5 + 1 
.s68:
1513 : a5 4a __ LDA T5 + 0 
1515 : 85 1b __ STA ACCU + 0 
1517 : a5 4b __ LDA T5 + 1 
1519 : 85 1c __ STA ACCU + 1 
151b : a9 0a __ LDA #$0a
151d : 85 03 __ STA WORK + 0 
151f : a9 00 __ LDA #$00
1521 : 85 04 __ STA WORK + 1 
1523 : 20 dc 1a JSR $1adc ; (divs16 + 0)
1526 : 18 __ __ CLC
1527 : a5 1b __ LDA ACCU + 0 
1529 : 69 30 __ ADC #$30
152b : a4 48 __ LDY T3 + 0 
152d : c8 __ __ INY
152e : c8 __ __ INY
152f : 91 13 __ STA (P6),y ; (str + 0)
1531 : a5 4a __ LDA T5 + 0 
1533 : 85 1b __ STA ACCU + 0 
1535 : a5 4b __ LDA T5 + 1 
1537 : 85 1c __ STA ACCU + 1 
1539 : a9 0a __ LDA #$0a
153b : 85 03 __ STA WORK + 0 
153d : a9 00 __ LDA #$00
153f : 85 04 __ STA WORK + 1 
1541 : 20 9b 1b JSR $1b9b ; (mods16 + 0)
1544 : 18 __ __ CLC
1545 : a5 05 __ LDA WORK + 2 
1547 : 69 30 __ ADC #$30
1549 : a4 48 __ LDY T3 + 0 
154b : c8 __ __ INY
154c : c8 __ __ INY
154d : c8 __ __ INY
154e : 91 13 __ STA (P6),y ; (str + 0)
1550 : c8 __ __ INY
1551 : 84 48 __ STY T3 + 0 
.s9:
1553 : a5 11 __ LDA P4 ; (si + 0)
1555 : 85 4a __ STA T5 + 0 
1557 : a5 12 __ LDA P5 ; (si + 1)
1559 : 85 4b __ STA T5 + 1 
155b : a5 48 __ LDA T3 + 0 
155d : a0 01 __ LDY #$01
155f : d1 11 __ CMP (P4),y ; (si + 0)
1561 : b0 5d __ BCS $15c0 ; (nformf.s1001 + 0)
.s69:
1563 : a0 06 __ LDY #$06
1565 : b1 11 __ LDA (P4),y ; (si + 0)
1567 : f0 06 __ BEQ $156f ; (nformf.s73 + 0)
.s72:
1569 : a5 48 __ LDA T3 + 0 
156b : aa __ __ TAX
156c : 4c c7 15 JMP $15c7 ; (nformf.l75 + 0)
.s73:
156f : a5 48 __ LDA T3 + 0 
1571 : f0 2d __ BEQ $15a0 ; (nformf.s82 + 0)
.s90:
1573 : a9 01 __ LDA #$01
1575 : 85 47 __ STA T2 + 0 
1577 : a6 48 __ LDX T3 + 0 
1579 : 38 __ __ SEC
.l1080:
157a : a0 01 __ LDY #$01
157c : b1 11 __ LDA (P4),y ; (si + 0)
157e : e5 47 __ SBC T2 + 0 
1580 : 85 4c __ STA T8 + 0 
1582 : a9 ff __ LDA #$ff
1584 : 65 14 __ ADC P7 ; (str + 1)
1586 : 85 4d __ STA T8 + 1 
1588 : 8a __ __ TXA
1589 : 38 __ __ SEC
158a : e5 47 __ SBC T2 + 0 
158c : 85 1b __ STA ACCU + 0 
158e : a9 ff __ LDA #$ff
1590 : 65 14 __ ADC P7 ; (str + 1)
1592 : 85 1c __ STA ACCU + 1 
1594 : a4 13 __ LDY P6 ; (str + 0)
1596 : b1 1b __ LDA (ACCU + 0),y 
1598 : 91 4c __ STA (T8 + 0),y 
159a : e6 47 __ INC T2 + 0 
159c : e4 47 __ CPX T2 + 0 
159e : b0 da __ BCS $157a ; (nformf.l1080 + 0)
.s82:
15a0 : a9 00 __ LDA #$00
15a2 : 85 47 __ STA T2 + 0 
.l83:
15a4 : a0 01 __ LDY #$01
15a6 : b1 4a __ LDA (T5 + 0),y 
15a8 : 38 __ __ SEC
15a9 : e5 48 __ SBC T3 + 0 
15ab : 90 06 __ BCC $15b3 ; (nformf.s84 + 0)
.s1007:
15ad : c5 47 __ CMP T2 + 0 
15af : 90 0d __ BCC $15be ; (nformf.s74 + 0)
.s1084:
15b1 : f0 0b __ BEQ $15be ; (nformf.s74 + 0)
.s84:
15b3 : a9 20 __ LDA #$20
15b5 : a4 47 __ LDY T2 + 0 
15b7 : 91 13 __ STA (P6),y ; (str + 0)
15b9 : e6 47 __ INC T2 + 0 
15bb : 4c a4 15 JMP $15a4 ; (nformf.l83 + 0)
.s74:
15be : b1 11 __ LDA (P4),y ; (si + 0)
.s1001:
15c0 : 85 1b __ STA ACCU + 0 
15c2 : a9 00 __ LDA #$00
15c4 : 85 1c __ STA ACCU + 1 
15c6 : 60 __ __ RTS
.l75:
15c7 : a0 01 __ LDY #$01
15c9 : d1 4a __ CMP (T5 + 0),y 
15cb : b0 f1 __ BCS $15be ; (nformf.s74 + 0)
.s76:
15cd : a8 __ __ TAY
15ce : a9 20 __ LDA #$20
15d0 : 91 13 __ STA (P6),y ; (str + 0)
15d2 : e8 __ __ INX
15d3 : 8a __ __ TXA
15d4 : 4c c7 15 JMP $15c7 ; (nformf.l75 + 0)
.s30:
15d7 : a5 4c __ LDA T8 + 0 
15d9 : c9 07 __ CMP #$07
15db : 90 13 __ BCC $15f0 ; (nformf.s41 + 0)
.s42:
15dd : ad 4b 1d LDA $1d4b ; (fround5 + 25)
15e0 : 85 1c __ STA ACCU + 1 
15e2 : ad 4c 1d LDA $1d4c ; (fround5 + 26)
15e5 : 85 1d __ STA ACCU + 2 
15e7 : ad 4d 1d LDA $1d4d ; (fround5 + 27)
15ea : ae 4a 1d LDX $1d4a ; (fround5 + 24)
15ed : 4c 03 16 JMP $1603 ; (nformf.s204 + 0)
.s41:
15f0 : 0a __ __ ASL
15f1 : 0a __ __ ASL
15f2 : a8 __ __ TAY
15f3 : b9 2f 1d LDA $1d2f,y ; (mul40 + 47)
15f6 : 85 1c __ STA ACCU + 1 
15f8 : b9 30 1d LDA $1d30,y ; (mul40 + 48)
15fb : 85 1d __ STA ACCU + 2 
15fd : b9 31 1d LDA $1d31,y ; (mul40 + 49)
1600 : be 2e 1d LDX $1d2e,y ; (mul40 + 46)
.s204:
1603 : 86 1b __ STX ACCU + 0 
1605 : 85 1e __ STA ACCU + 3 
1607 : a2 43 __ LDX #$43
1609 : 20 37 18 JSR $1837 ; (freg + 4)
160c : 20 78 18 JSR $1878 ; (faddsub + 0)
160f : a5 1c __ LDA ACCU + 1 
1611 : 85 16 __ STA P9 ; (f + 1)
1613 : a5 1d __ LDA ACCU + 2 
1615 : 85 17 __ STA P10 ; (f + 2)
1617 : a6 1b __ LDX ACCU + 0 
1619 : a5 1e __ LDA ACCU + 3 
161b : 85 18 __ STA P11 ; (f + 3)
161d : 10 03 __ BPL $1622 ; (nformf.s1038 + 0)
161f : 4c 4e 14 JMP $144e ; (nformf.s31 + 0)
.s1038:
1622 : c9 41 __ CMP #$41
1624 : d0 06 __ BNE $162c ; (nformf.s1042 + 0)
.s1039:
1626 : a5 17 __ LDA P10 ; (f + 2)
1628 : c9 20 __ CMP #$20
162a : f0 05 __ BEQ $1631 ; (nformf.s44 + 0)
.s1042:
162c : b0 03 __ BCS $1631 ; (nformf.s44 + 0)
162e : 4c 4e 14 JMP $144e ; (nformf.s31 + 0)
.s44:
1631 : a9 00 __ LDA #$00
1633 : 85 03 __ STA WORK + 0 
1635 : 85 04 __ STA WORK + 1 
1637 : a9 20 __ LDA #$20
1639 : 85 05 __ STA WORK + 2 
163b : a9 41 __ LDA #$41
163d : 85 06 __ STA WORK + 3 
163f : 20 47 18 JSR $1847 ; (freg + 20)
1642 : 20 2e 1a JSR $1a2e ; (fdiv + 0)
1645 : a5 1c __ LDA ACCU + 1 
1647 : 85 16 __ STA P9 ; (f + 1)
1649 : a5 1d __ LDA ACCU + 2 
164b : 85 17 __ STA P10 ; (f + 2)
164d : a5 1e __ LDA ACCU + 3 
164f : 85 18 __ STA P11 ; (f + 3)
1651 : a6 1b __ LDX ACCU + 0 
1653 : e6 4a __ INC T5 + 0 
1655 : f0 03 __ BEQ $165a ; (nformf.s1089 + 0)
1657 : 4c 4e 14 JMP $144e ; (nformf.s31 + 0)
.s1089:
165a : e6 4b __ INC T5 + 1 
165c : 4c 4e 14 JMP $144e ; (nformf.s31 + 0)
.s13:
165f : a5 18 __ LDA P11 ; (f + 3)
1661 : 30 59 __ BMI $16bc ; (nformf.l17 + 0)
.l1068:
1663 : c9 44 __ CMP #$44
1665 : f0 03 __ BEQ $166a ; (nformf.s1069 + 0)
1667 : 4c 59 17 JMP $1759 ; (nformf.s1072 + 0)
.s1069:
166a : a5 45 __ LDA T1 + 2 
166c : c9 7a __ CMP #$7a
166e : f0 03 __ BEQ $1673 ; (nformf.s1070 + 0)
1670 : 4c 59 17 JMP $1759 ; (nformf.s1072 + 0)
.s1070:
1673 : a5 44 __ LDA T1 + 1 
1675 : d0 04 __ BNE $167b ; (nformf.s1079 + 0)
.s1071:
1677 : a5 43 __ LDA T1 + 0 
1679 : f0 02 __ BEQ $167d ; (nformf.s14 + 0)
.s1079:
167b : a5 43 __ LDA T1 + 0 
.s14:
167d : 85 1b __ STA ACCU + 0 
167f : a5 44 __ LDA T1 + 1 
1681 : 85 1c __ STA ACCU + 1 
1683 : a5 45 __ LDA T1 + 2 
1685 : 85 1d __ STA ACCU + 2 
1687 : a5 46 __ LDA T1 + 3 
1689 : 85 1e __ STA ACCU + 3 
168b : a9 00 __ LDA #$00
168d : 85 03 __ STA WORK + 0 
168f : 85 04 __ STA WORK + 1 
1691 : a9 7a __ LDA #$7a
1693 : 85 05 __ STA WORK + 2 
1695 : a9 44 __ LDA #$44
1697 : 85 06 __ STA WORK + 3 
1699 : 20 47 18 JSR $1847 ; (freg + 20)
169c : 20 2e 1a JSR $1a2e ; (fdiv + 0)
169f : a5 1b __ LDA ACCU + 0 
16a1 : 85 43 __ STA T1 + 0 
16a3 : a5 1c __ LDA ACCU + 1 
16a5 : 85 44 __ STA T1 + 1 
16a7 : a5 1d __ LDA ACCU + 2 
16a9 : 85 45 __ STA T1 + 2 
16ab : 18 __ __ CLC
16ac : a5 4a __ LDA T5 + 0 
16ae : 69 03 __ ADC #$03
16b0 : 85 4a __ STA T5 + 0 
16b2 : 90 02 __ BCC $16b6 ; (nformf.s1094 + 0)
.s1093:
16b4 : e6 4b __ INC T5 + 1 
.s1094:
16b6 : a5 1e __ LDA ACCU + 3 
16b8 : 85 46 __ STA T1 + 3 
16ba : 10 a7 __ BPL $1663 ; (nformf.l1068 + 0)
.l17:
16bc : a9 00 __ LDA #$00
16be : 85 1b __ STA ACCU + 0 
16c0 : 85 1c __ STA ACCU + 1 
16c2 : a9 7a __ LDA #$7a
16c4 : 85 1d __ STA ACCU + 2 
16c6 : a9 44 __ LDA #$44
16c8 : 85 1e __ STA ACCU + 3 
16ca : a2 43 __ LDX #$43
16cc : 20 37 18 JSR $1837 ; (freg + 4)
16cf : 20 5f 19 JSR $195f ; (fmul + 0)
16d2 : a5 1b __ LDA ACCU + 0 
16d4 : 85 43 __ STA T1 + 0 
16d6 : a5 1c __ LDA ACCU + 1 
16d8 : 85 44 __ STA T1 + 1 
16da : a5 1d __ LDA ACCU + 2 
16dc : 85 45 __ STA T1 + 2 
16de : a5 1e __ LDA ACCU + 3 
16e0 : 85 46 __ STA T1 + 3 
16e2 : 38 __ __ SEC
16e3 : a5 4a __ LDA T5 + 0 
16e5 : e9 03 __ SBC #$03
16e7 : 85 4a __ STA T5 + 0 
16e9 : b0 02 __ BCS $16ed ; (nformf.s16 + 0)
.s1085:
16eb : c6 4b __ DEC T5 + 1 
.s16:
16ed : a5 46 __ LDA T1 + 3 
16ef : 30 cb __ BMI $16bc ; (nformf.l17 + 0)
.s1060:
16f1 : c9 3f __ CMP #$3f
16f3 : d0 06 __ BNE $16fb ; (nformf.s1064 + 0)
.s1061:
16f5 : a5 45 __ LDA T1 + 2 
16f7 : c9 80 __ CMP #$80
16f9 : f0 02 __ BEQ $16fd ; (nformf.s19 + 0)
.s1064:
16fb : 90 bf __ BCC $16bc ; (nformf.l17 + 0)
.s19:
16fd : a5 46 __ LDA T1 + 3 
16ff : c9 41 __ CMP #$41
1701 : d0 51 __ BNE $1754 ; (nformf.l1056 + 0)
.s1053:
1703 : a5 45 __ LDA T1 + 2 
1705 : c9 20 __ CMP #$20
1707 : d0 4b __ BNE $1754 ; (nformf.l1056 + 0)
.s1054:
1709 : a5 44 __ LDA T1 + 1 
170b : d0 04 __ BNE $1711 ; (nformf.l1078 + 0)
.s1055:
170d : a5 43 __ LDA T1 + 0 
170f : f0 02 __ BEQ $1713 ; (nformf.l20 + 0)
.l1078:
1711 : a5 43 __ LDA T1 + 0 
.l20:
1713 : 85 1b __ STA ACCU + 0 
1715 : a5 44 __ LDA T1 + 1 
1717 : 85 1c __ STA ACCU + 1 
1719 : a5 45 __ LDA T1 + 2 
171b : 85 1d __ STA ACCU + 2 
171d : a5 46 __ LDA T1 + 3 
171f : 85 1e __ STA ACCU + 3 
1721 : a9 00 __ LDA #$00
1723 : 85 03 __ STA WORK + 0 
1725 : 85 04 __ STA WORK + 1 
1727 : a9 20 __ LDA #$20
1729 : 85 05 __ STA WORK + 2 
172b : a9 41 __ LDA #$41
172d : 85 06 __ STA WORK + 3 
172f : 20 47 18 JSR $1847 ; (freg + 20)
1732 : 20 2e 1a JSR $1a2e ; (fdiv + 0)
1735 : a5 1b __ LDA ACCU + 0 
1737 : 85 43 __ STA T1 + 0 
1739 : a5 1c __ LDA ACCU + 1 
173b : 85 44 __ STA T1 + 1 
173d : a5 1d __ LDA ACCU + 2 
173f : 85 45 __ STA T1 + 2 
1741 : e6 4a __ INC T5 + 0 
1743 : d0 02 __ BNE $1747 ; (nformf.s1088 + 0)
.s1087:
1745 : e6 4b __ INC T5 + 1 
.s1088:
1747 : a5 1e __ LDA ACCU + 3 
1749 : 85 46 __ STA T1 + 3 
174b : 10 03 __ BPL $1750 ; (nformf.s1052 + 0)
174d : 4c 52 13 JMP $1352 ; (nformf.s12 + 0)
.s1052:
1750 : c9 41 __ CMP #$41
1752 : f0 af __ BEQ $1703 ; (nformf.s1053 + 0)
.l1056:
1754 : b0 bb __ BCS $1711 ; (nformf.l1078 + 0)
1756 : 4c 52 13 JMP $1352 ; (nformf.s12 + 0)
.s1072:
1759 : 90 92 __ BCC $16ed ; (nformf.s16 + 0)
175b : 4c 7b 16 JMP $167b ; (nformf.s1079 + 0)
.s7:
175e : 85 1b __ STA ACCU + 0 
1760 : a9 49 __ LDA #$49
1762 : 91 13 __ STA (P6),y ; (str + 0)
1764 : a9 4e __ LDA #$4e
1766 : a4 4a __ LDY T5 + 0 
1768 : 91 13 __ STA (P6),y ; (str + 0)
176a : a9 46 __ LDA #$46
176c : a4 1b __ LDY ACCU + 0 
176e : 91 13 __ STA (P6),y ; (str + 0)
1770 : 18 __ __ CLC
1771 : a5 48 __ LDA T3 + 0 
1773 : 69 03 __ ADC #$03
1775 : 85 48 __ STA T3 + 0 
1777 : 4c 53 15 JMP $1553 ; (nformf.s9 + 0)
.s189:
177a : 20 92 17 JSR $1792 ; (isinf.s0 + 0)
177d : aa __ __ TAX
177e : a9 01 __ LDA #$01
1780 : 85 48 __ STA T3 + 0 
1782 : 8a __ __ TXA
1783 : d0 03 __ BNE $1788 ; (nformf.s158 + 0)
1785 : 4c 2f 13 JMP $132f ; (nformf.s8 + 0)
.s158:
1788 : a9 02 __ LDA #$02
178a : 85 4a __ STA T5 + 0 
178c : a9 03 __ LDA #$03
178e : a0 01 __ LDY #$01
1790 : d0 cc __ BNE $175e ; (nformf.s7 + 0)
--------------------------------------------------------------------
isinf:
.s0:
1792 : 06 0f __ ASL P2 ; (f + 2)
1794 : a5 10 __ LDA P3 ; (f + 3)
1796 : 2a __ __ ROL
1797 : c9 ff __ CMP #$ff
1799 : d0 03 __ BNE $179e ; (isinf.s1003 + 0)
.s1002:
179b : a9 01 __ LDA #$01
179d : 60 __ __ RTS
.s1003:
179e : a9 00 __ LDA #$00
.s1001:
17a0 : 60 __ __ RTS
--------------------------------------------------------------------
fround5:
1d32 : __ __ __ BYT 00 00 00 3f cd cc 4c 3d 0a d7 a3 3b 6f 12 03 3a : ...?..L=...;o..:
1d42 : __ __ __ BYT 17 b7 51 38 ac c5 a7 36 bd 37 06 35             : ..Q8...6.7.5
--------------------------------------------------------------------
09f9 : __ __ __ BYT 25 64 00                                        : %d.
--------------------------------------------------------------------
cwin_put_string:
.s0:
17a1 : a5 14 __ LDA P7 ; (win + 0)
17a3 : 85 0d __ STA P0 
17a5 : a5 15 __ LDA P8 ; (win + 1)
17a7 : 85 0e __ STA P1 
17a9 : a0 04 __ LDY #$04
17ab : b1 14 __ LDA (P7),y ; (win + 0)
17ad : 85 0f __ STA P2 
17af : c8 __ __ INY
17b0 : b1 14 __ LDA (P7),y ; (win + 0)
17b2 : 85 10 __ STA P3 
17b4 : a5 16 __ LDA P9 ; (str + 0)
17b6 : 85 11 __ STA P4 
17b8 : a5 17 __ LDA P10 ; (str + 1)
17ba : 85 12 __ STA P5 
17bc : a5 18 __ LDA P11 ; (color + 0)
17be : 85 13 __ STA P6 
17c0 : 20 e1 17 JSR $17e1 ; (cwin_putat_string.s0 + 0)
17c3 : 85 1b __ STA ACCU + 0 
17c5 : 18 __ __ CLC
17c6 : a0 04 __ LDY #$04
17c8 : 71 14 __ ADC (P7),y ; (win + 0)
17ca : 91 14 __ STA (P7),y ; (win + 0)
17cc : a0 02 __ LDY #$02
17ce : d1 14 __ CMP (P7),y ; (win + 0)
17d0 : 90 0e __ BCC $17e0 ; (cwin_put_string.s1001 + 0)
.s1:
17d2 : a9 00 __ LDA #$00
17d4 : a0 04 __ LDY #$04
17d6 : 91 14 __ STA (P7),y ; (win + 0)
17d8 : 18 __ __ CLC
17d9 : c8 __ __ INY
17da : b1 14 __ LDA (P7),y ; (win + 0)
17dc : 69 01 __ ADC #$01
17de : 91 14 __ STA (P7),y ; (win + 0)
.s1001:
17e0 : 60 __ __ RTS
--------------------------------------------------------------------
cwin_putat_string:
.s0:
17e1 : a5 10 __ LDA P3 ; (y + 0)
17e3 : 0a __ __ ASL
17e4 : aa __ __ TAX
17e5 : bd 00 1d LDA $1d00,x ; (mul40 + 0)
17e8 : 18 __ __ CLC
17e9 : 65 0f __ ADC P2 ; (x + 0)
17eb : 85 1b __ STA ACCU + 0 
17ed : bd 01 1d LDA $1d01,x ; (mul40 + 1)
17f0 : 69 00 __ ADC #$00
17f2 : 85 1c __ STA ACCU + 1 
17f4 : a0 06 __ LDY #$06
17f6 : b1 0d __ LDA (P0),y ; (win + 0)
17f8 : 18 __ __ CLC
17f9 : 65 1b __ ADC ACCU + 0 
17fb : 85 43 __ STA T3 + 0 
17fd : c8 __ __ INY
17fe : b1 0d __ LDA (P0),y ; (win + 0)
1800 : 65 1c __ ADC ACCU + 1 
1802 : 85 44 __ STA T3 + 1 
1804 : c8 __ __ INY
1805 : b1 0d __ LDA (P0),y ; (win + 0)
1807 : 18 __ __ CLC
1808 : 65 1b __ ADC ACCU + 0 
180a : 85 1b __ STA ACCU + 0 
180c : c8 __ __ INY
180d : b1 0d __ LDA (P0),y ; (win + 0)
180f : 65 1c __ ADC ACCU + 1 
1811 : 85 1c __ STA ACCU + 1 
1813 : a0 00 __ LDY #$00
1815 : b1 11 __ LDA (P4),y ; (str + 0)
1817 : f0 18 __ BEQ $1831 ; (cwin_putat_string.s3 + 0)
.l2:
1819 : 85 1d __ STA ACCU + 2 
181b : 4a __ __ LSR
181c : 4a __ __ LSR
181d : 4a __ __ LSR
181e : 4a __ __ LSR
181f : 4a __ __ LSR
1820 : aa __ __ TAX
1821 : bd f7 1c LDA $1cf7,x ; (p2smap + 0)
1824 : 45 1d __ EOR ACCU + 2 
1826 : 91 43 __ STA (T3 + 0),y 
1828 : a5 13 __ LDA P6 ; (color + 0)
182a : 91 1b __ STA (ACCU + 0),y 
182c : c8 __ __ INY
182d : b1 11 __ LDA (P4),y ; (str + 0)
182f : d0 e8 __ BNE $1819 ; (cwin_putat_string.l2 + 0)
.s3:
1831 : 98 __ __ TYA
.s1001:
1832 : 60 __ __ RTS
--------------------------------------------------------------------
p2smap:
1cf7 : __ __ __ BYT 00 00 40 20 80 c0 80 80                         : ..@ ....
--------------------------------------------------------------------
freg:
1833 : b1 19 __ LDA (IP + 0),y 
1835 : c8 __ __ INY
1836 : aa __ __ TAX
1837 : b5 00 __ LDA $00,x 
1839 : 85 03 __ STA WORK + 0 
183b : b5 01 __ LDA $01,x 
183d : 85 04 __ STA WORK + 1 
183f : b5 02 __ LDA $02,x 
1841 : 85 05 __ STA WORK + 2 
1843 : b5 03 __ LDA WORK + 0,x 
1845 : 85 06 __ STA WORK + 3 
1847 : a5 05 __ LDA WORK + 2 
1849 : 0a __ __ ASL
184a : a5 06 __ LDA WORK + 3 
184c : 2a __ __ ROL
184d : 85 08 __ STA WORK + 5 
184f : f0 06 __ BEQ $1857 ; (freg + 36)
1851 : a5 05 __ LDA WORK + 2 
1853 : 09 80 __ ORA #$80
1855 : 85 05 __ STA WORK + 2 
1857 : a5 1d __ LDA ACCU + 2 
1859 : 0a __ __ ASL
185a : a5 1e __ LDA ACCU + 3 
185c : 2a __ __ ROL
185d : 85 07 __ STA WORK + 4 
185f : f0 06 __ BEQ $1867 ; (freg + 52)
1861 : a5 1d __ LDA ACCU + 2 
1863 : 09 80 __ ORA #$80
1865 : 85 1d __ STA ACCU + 2 
1867 : 60 __ __ RTS
1868 : 06 1e __ ASL ACCU + 3 
186a : a5 07 __ LDA WORK + 4 
186c : 6a __ __ ROR
186d : 85 1e __ STA ACCU + 3 
186f : b0 06 __ BCS $1877 ; (freg + 68)
1871 : a5 1d __ LDA ACCU + 2 
1873 : 29 7f __ AND #$7f
1875 : 85 1d __ STA ACCU + 2 
1877 : 60 __ __ RTS
--------------------------------------------------------------------
faddsub:
1878 : a9 ff __ LDA #$ff
187a : c5 07 __ CMP WORK + 4 
187c : f0 04 __ BEQ $1882 ; (faddsub + 10)
187e : c5 08 __ CMP WORK + 5 
1880 : d0 11 __ BNE $1893 ; (faddsub + 27)
1882 : a5 1e __ LDA ACCU + 3 
1884 : 09 7f __ ORA #$7f
1886 : 85 1e __ STA ACCU + 3 
1888 : a9 80 __ LDA #$80
188a : 85 1d __ STA ACCU + 2 
188c : a9 00 __ LDA #$00
188e : 85 1b __ STA ACCU + 0 
1890 : 85 1c __ STA ACCU + 1 
1892 : 60 __ __ RTS
1893 : 38 __ __ SEC
1894 : a5 07 __ LDA WORK + 4 
1896 : e5 08 __ SBC WORK + 5 
1898 : f0 38 __ BEQ $18d2 ; (faddsub + 90)
189a : aa __ __ TAX
189b : b0 25 __ BCS $18c2 ; (faddsub + 74)
189d : e0 e9 __ CPX #$e9
189f : b0 0e __ BCS $18af ; (faddsub + 55)
18a1 : a5 08 __ LDA WORK + 5 
18a3 : 85 07 __ STA WORK + 4 
18a5 : a9 00 __ LDA #$00
18a7 : 85 1b __ STA ACCU + 0 
18a9 : 85 1c __ STA ACCU + 1 
18ab : 85 1d __ STA ACCU + 2 
18ad : f0 23 __ BEQ $18d2 ; (faddsub + 90)
18af : a5 1d __ LDA ACCU + 2 
18b1 : 4a __ __ LSR
18b2 : 66 1c __ ROR ACCU + 1 
18b4 : 66 1b __ ROR ACCU + 0 
18b6 : e8 __ __ INX
18b7 : d0 f8 __ BNE $18b1 ; (faddsub + 57)
18b9 : 85 1d __ STA ACCU + 2 
18bb : a5 08 __ LDA WORK + 5 
18bd : 85 07 __ STA WORK + 4 
18bf : 4c d2 18 JMP $18d2 ; (faddsub + 90)
18c2 : e0 18 __ CPX #$18
18c4 : b0 33 __ BCS $18f9 ; (faddsub + 129)
18c6 : a5 05 __ LDA WORK + 2 
18c8 : 4a __ __ LSR
18c9 : 66 04 __ ROR WORK + 1 
18cb : 66 03 __ ROR WORK + 0 
18cd : ca __ __ DEX
18ce : d0 f8 __ BNE $18c8 ; (faddsub + 80)
18d0 : 85 05 __ STA WORK + 2 
18d2 : a5 1e __ LDA ACCU + 3 
18d4 : 29 80 __ AND #$80
18d6 : 85 1e __ STA ACCU + 3 
18d8 : 45 06 __ EOR WORK + 3 
18da : 30 31 __ BMI $190d ; (faddsub + 149)
18dc : 18 __ __ CLC
18dd : a5 1b __ LDA ACCU + 0 
18df : 65 03 __ ADC WORK + 0 
18e1 : 85 1b __ STA ACCU + 0 
18e3 : a5 1c __ LDA ACCU + 1 
18e5 : 65 04 __ ADC WORK + 1 
18e7 : 85 1c __ STA ACCU + 1 
18e9 : a5 1d __ LDA ACCU + 2 
18eb : 65 05 __ ADC WORK + 2 
18ed : 85 1d __ STA ACCU + 2 
18ef : 90 08 __ BCC $18f9 ; (faddsub + 129)
18f1 : 66 1d __ ROR ACCU + 2 
18f3 : 66 1c __ ROR ACCU + 1 
18f5 : 66 1b __ ROR ACCU + 0 
18f7 : e6 07 __ INC WORK + 4 
18f9 : a5 07 __ LDA WORK + 4 
18fb : c9 ff __ CMP #$ff
18fd : f0 83 __ BEQ $1882 ; (faddsub + 10)
18ff : 4a __ __ LSR
1900 : 05 1e __ ORA ACCU + 3 
1902 : 85 1e __ STA ACCU + 3 
1904 : b0 06 __ BCS $190c ; (faddsub + 148)
1906 : a5 1d __ LDA ACCU + 2 
1908 : 29 7f __ AND #$7f
190a : 85 1d __ STA ACCU + 2 
190c : 60 __ __ RTS
190d : 38 __ __ SEC
190e : a5 1b __ LDA ACCU + 0 
1910 : e5 03 __ SBC WORK + 0 
1912 : 85 1b __ STA ACCU + 0 
1914 : a5 1c __ LDA ACCU + 1 
1916 : e5 04 __ SBC WORK + 1 
1918 : 85 1c __ STA ACCU + 1 
191a : a5 1d __ LDA ACCU + 2 
191c : e5 05 __ SBC WORK + 2 
191e : 85 1d __ STA ACCU + 2 
1920 : b0 19 __ BCS $193b ; (faddsub + 195)
1922 : 38 __ __ SEC
1923 : a9 00 __ LDA #$00
1925 : e5 1b __ SBC ACCU + 0 
1927 : 85 1b __ STA ACCU + 0 
1929 : a9 00 __ LDA #$00
192b : e5 1c __ SBC ACCU + 1 
192d : 85 1c __ STA ACCU + 1 
192f : a9 00 __ LDA #$00
1931 : e5 1d __ SBC ACCU + 2 
1933 : 85 1d __ STA ACCU + 2 
1935 : a5 1e __ LDA ACCU + 3 
1937 : 49 80 __ EOR #$80
1939 : 85 1e __ STA ACCU + 3 
193b : a5 1d __ LDA ACCU + 2 
193d : 30 ba __ BMI $18f9 ; (faddsub + 129)
193f : 05 1c __ ORA ACCU + 1 
1941 : 05 1b __ ORA ACCU + 0 
1943 : f0 0f __ BEQ $1954 ; (faddsub + 220)
1945 : c6 07 __ DEC WORK + 4 
1947 : f0 0b __ BEQ $1954 ; (faddsub + 220)
1949 : 06 1b __ ASL ACCU + 0 
194b : 26 1c __ ROL ACCU + 1 
194d : 26 1d __ ROL ACCU + 2 
194f : 10 f4 __ BPL $1945 ; (faddsub + 205)
1951 : 4c f9 18 JMP $18f9 ; (faddsub + 129)
1954 : a9 00 __ LDA #$00
1956 : 85 1b __ STA ACCU + 0 
1958 : 85 1c __ STA ACCU + 1 
195a : 85 1d __ STA ACCU + 2 
195c : 85 1e __ STA ACCU + 3 
195e : 60 __ __ RTS
--------------------------------------------------------------------
fmul:
195f : a5 1b __ LDA ACCU + 0 
1961 : 05 1c __ ORA ACCU + 1 
1963 : 05 1d __ ORA ACCU + 2 
1965 : d0 03 __ BNE $196a ; (fmul + 11)
1967 : 85 1e __ STA ACCU + 3 
1969 : 60 __ __ RTS
196a : a5 03 __ LDA WORK + 0 
196c : 05 04 __ ORA WORK + 1 
196e : 05 05 __ ORA WORK + 2 
1970 : d0 09 __ BNE $197b ; (fmul + 28)
1972 : 85 1b __ STA ACCU + 0 
1974 : 85 1c __ STA ACCU + 1 
1976 : 85 1d __ STA ACCU + 2 
1978 : 85 1e __ STA ACCU + 3 
197a : 60 __ __ RTS
197b : a5 1e __ LDA ACCU + 3 
197d : 45 06 __ EOR WORK + 3 
197f : 29 80 __ AND #$80
1981 : 85 1e __ STA ACCU + 3 
1983 : a9 ff __ LDA #$ff
1985 : c5 07 __ CMP WORK + 4 
1987 : f0 42 __ BEQ $19cb ; (fmul + 108)
1989 : c5 08 __ CMP WORK + 5 
198b : f0 3e __ BEQ $19cb ; (fmul + 108)
198d : a9 00 __ LDA #$00
198f : 85 09 __ STA WORK + 6 
1991 : 85 0a __ STA WORK + 7 
1993 : 85 0b __ STA $0b 
1995 : a4 1b __ LDY ACCU + 0 
1997 : a5 03 __ LDA WORK + 0 
1999 : d0 06 __ BNE $19a1 ; (fmul + 66)
199b : a5 04 __ LDA WORK + 1 
199d : f0 0a __ BEQ $19a9 ; (fmul + 74)
199f : d0 05 __ BNE $19a6 ; (fmul + 71)
19a1 : 20 00 1a JSR $1a00 ; (fmul8 + 0)
19a4 : a5 04 __ LDA WORK + 1 
19a6 : 20 00 1a JSR $1a00 ; (fmul8 + 0)
19a9 : a5 05 __ LDA WORK + 2 
19ab : 20 00 1a JSR $1a00 ; (fmul8 + 0)
19ae : 38 __ __ SEC
19af : a5 0b __ LDA $0b 
19b1 : 30 06 __ BMI $19b9 ; (fmul + 90)
19b3 : 06 09 __ ASL WORK + 6 
19b5 : 26 0a __ ROL WORK + 7 
19b7 : 2a __ __ ROL
19b8 : 18 __ __ CLC
19b9 : 29 7f __ AND #$7f
19bb : 85 0b __ STA $0b 
19bd : a5 07 __ LDA WORK + 4 
19bf : 65 08 __ ADC WORK + 5 
19c1 : 90 19 __ BCC $19dc ; (fmul + 125)
19c3 : e9 7f __ SBC #$7f
19c5 : b0 04 __ BCS $19cb ; (fmul + 108)
19c7 : c9 ff __ CMP #$ff
19c9 : d0 15 __ BNE $19e0 ; (fmul + 129)
19cb : a5 1e __ LDA ACCU + 3 
19cd : 09 7f __ ORA #$7f
19cf : 85 1e __ STA ACCU + 3 
19d1 : a9 80 __ LDA #$80
19d3 : 85 1d __ STA ACCU + 2 
19d5 : a9 00 __ LDA #$00
19d7 : 85 1b __ STA ACCU + 0 
19d9 : 85 1c __ STA ACCU + 1 
19db : 60 __ __ RTS
19dc : e9 7e __ SBC #$7e
19de : 90 15 __ BCC $19f5 ; (fmul + 150)
19e0 : 4a __ __ LSR
19e1 : 05 1e __ ORA ACCU + 3 
19e3 : 85 1e __ STA ACCU + 3 
19e5 : a9 00 __ LDA #$00
19e7 : 6a __ __ ROR
19e8 : 05 0b __ ORA $0b 
19ea : 85 1d __ STA ACCU + 2 
19ec : a5 0a __ LDA WORK + 7 
19ee : 85 1c __ STA ACCU + 1 
19f0 : a5 09 __ LDA WORK + 6 
19f2 : 85 1b __ STA ACCU + 0 
19f4 : 60 __ __ RTS
19f5 : a9 00 __ LDA #$00
19f7 : 85 1b __ STA ACCU + 0 
19f9 : 85 1c __ STA ACCU + 1 
19fb : 85 1d __ STA ACCU + 2 
19fd : 85 1e __ STA ACCU + 3 
19ff : 60 __ __ RTS
--------------------------------------------------------------------
fmul8:
1a00 : 38 __ __ SEC
1a01 : 6a __ __ ROR
1a02 : 90 1e __ BCC $1a22 ; (fmul8 + 34)
1a04 : aa __ __ TAX
1a05 : 18 __ __ CLC
1a06 : 98 __ __ TYA
1a07 : 65 09 __ ADC WORK + 6 
1a09 : 85 09 __ STA WORK + 6 
1a0b : a5 0a __ LDA WORK + 7 
1a0d : 65 1c __ ADC ACCU + 1 
1a0f : 85 0a __ STA WORK + 7 
1a11 : a5 0b __ LDA $0b 
1a13 : 65 1d __ ADC ACCU + 2 
1a15 : 6a __ __ ROR
1a16 : 85 0b __ STA $0b 
1a18 : 8a __ __ TXA
1a19 : 66 0a __ ROR WORK + 7 
1a1b : 66 09 __ ROR WORK + 6 
1a1d : 4a __ __ LSR
1a1e : f0 0d __ BEQ $1a2d ; (fmul8 + 45)
1a20 : b0 e2 __ BCS $1a04 ; (fmul8 + 4)
1a22 : 66 0b __ ROR $0b 
1a24 : 66 0a __ ROR WORK + 7 
1a26 : 66 09 __ ROR WORK + 6 
1a28 : 4a __ __ LSR
1a29 : 90 f7 __ BCC $1a22 ; (fmul8 + 34)
1a2b : d0 d7 __ BNE $1a04 ; (fmul8 + 4)
1a2d : 60 __ __ RTS
--------------------------------------------------------------------
fdiv:
1a2e : a5 1b __ LDA ACCU + 0 
1a30 : 05 1c __ ORA ACCU + 1 
1a32 : 05 1d __ ORA ACCU + 2 
1a34 : d0 03 __ BNE $1a39 ; (fdiv + 11)
1a36 : 85 1e __ STA ACCU + 3 
1a38 : 60 __ __ RTS
1a39 : a5 1e __ LDA ACCU + 3 
1a3b : 45 06 __ EOR WORK + 3 
1a3d : 29 80 __ AND #$80
1a3f : 85 1e __ STA ACCU + 3 
1a41 : a5 08 __ LDA WORK + 5 
1a43 : f0 62 __ BEQ $1aa7 ; (fdiv + 121)
1a45 : a5 07 __ LDA WORK + 4 
1a47 : c9 ff __ CMP #$ff
1a49 : f0 5c __ BEQ $1aa7 ; (fdiv + 121)
1a4b : a9 00 __ LDA #$00
1a4d : 85 09 __ STA WORK + 6 
1a4f : 85 0a __ STA WORK + 7 
1a51 : 85 0b __ STA $0b 
1a53 : a2 18 __ LDX #$18
1a55 : a5 1b __ LDA ACCU + 0 
1a57 : c5 03 __ CMP WORK + 0 
1a59 : a5 1c __ LDA ACCU + 1 
1a5b : e5 04 __ SBC WORK + 1 
1a5d : a5 1d __ LDA ACCU + 2 
1a5f : e5 05 __ SBC WORK + 2 
1a61 : 90 13 __ BCC $1a76 ; (fdiv + 72)
1a63 : a5 1b __ LDA ACCU + 0 
1a65 : e5 03 __ SBC WORK + 0 
1a67 : 85 1b __ STA ACCU + 0 
1a69 : a5 1c __ LDA ACCU + 1 
1a6b : e5 04 __ SBC WORK + 1 
1a6d : 85 1c __ STA ACCU + 1 
1a6f : a5 1d __ LDA ACCU + 2 
1a71 : e5 05 __ SBC WORK + 2 
1a73 : 85 1d __ STA ACCU + 2 
1a75 : 38 __ __ SEC
1a76 : 26 09 __ ROL WORK + 6 
1a78 : 26 0a __ ROL WORK + 7 
1a7a : 26 0b __ ROL $0b 
1a7c : ca __ __ DEX
1a7d : f0 0a __ BEQ $1a89 ; (fdiv + 91)
1a7f : 06 1b __ ASL ACCU + 0 
1a81 : 26 1c __ ROL ACCU + 1 
1a83 : 26 1d __ ROL ACCU + 2 
1a85 : b0 dc __ BCS $1a63 ; (fdiv + 53)
1a87 : 90 cc __ BCC $1a55 ; (fdiv + 39)
1a89 : 38 __ __ SEC
1a8a : a5 0b __ LDA $0b 
1a8c : 30 06 __ BMI $1a94 ; (fdiv + 102)
1a8e : 06 09 __ ASL WORK + 6 
1a90 : 26 0a __ ROL WORK + 7 
1a92 : 2a __ __ ROL
1a93 : 18 __ __ CLC
1a94 : 29 7f __ AND #$7f
1a96 : 85 0b __ STA $0b 
1a98 : a5 07 __ LDA WORK + 4 
1a9a : e5 08 __ SBC WORK + 5 
1a9c : 90 1a __ BCC $1ab8 ; (fdiv + 138)
1a9e : 18 __ __ CLC
1a9f : 69 7f __ ADC #$7f
1aa1 : b0 04 __ BCS $1aa7 ; (fdiv + 121)
1aa3 : c9 ff __ CMP #$ff
1aa5 : d0 15 __ BNE $1abc ; (fdiv + 142)
1aa7 : a5 1e __ LDA ACCU + 3 
1aa9 : 09 7f __ ORA #$7f
1aab : 85 1e __ STA ACCU + 3 
1aad : a9 80 __ LDA #$80
1aaf : 85 1d __ STA ACCU + 2 
1ab1 : a9 00 __ LDA #$00
1ab3 : 85 1c __ STA ACCU + 1 
1ab5 : 85 1b __ STA ACCU + 0 
1ab7 : 60 __ __ RTS
1ab8 : 69 7f __ ADC #$7f
1aba : 90 15 __ BCC $1ad1 ; (fdiv + 163)
1abc : 4a __ __ LSR
1abd : 05 1e __ ORA ACCU + 3 
1abf : 85 1e __ STA ACCU + 3 
1ac1 : a9 00 __ LDA #$00
1ac3 : 6a __ __ ROR
1ac4 : 05 0b __ ORA $0b 
1ac6 : 85 1d __ STA ACCU + 2 
1ac8 : a5 0a __ LDA WORK + 7 
1aca : 85 1c __ STA ACCU + 1 
1acc : a5 09 __ LDA WORK + 6 
1ace : 85 1b __ STA ACCU + 0 
1ad0 : 60 __ __ RTS
1ad1 : a9 00 __ LDA #$00
1ad3 : 85 1e __ STA ACCU + 3 
1ad5 : 85 1d __ STA ACCU + 2 
1ad7 : 85 1c __ STA ACCU + 1 
1ad9 : 85 1b __ STA ACCU + 0 
1adb : 60 __ __ RTS
--------------------------------------------------------------------
divs16:
1adc : 24 1c __ BIT ACCU + 1 
1ade : 10 0d __ BPL $1aed ; (divs16 + 17)
1ae0 : 20 fa 1a JSR $1afa ; (negaccu + 0)
1ae3 : 24 04 __ BIT WORK + 1 
1ae5 : 10 0d __ BPL $1af4 ; (divs16 + 24)
1ae7 : 20 08 1b JSR $1b08 ; (negtmp + 0)
1aea : 4c 16 1b JMP $1b16 ; (divmod + 0)
1aed : 24 04 __ BIT WORK + 1 
1aef : 10 f9 __ BPL $1aea ; (divs16 + 14)
1af1 : 20 08 1b JSR $1b08 ; (negtmp + 0)
1af4 : 20 16 1b JSR $1b16 ; (divmod + 0)
1af7 : 4c fa 1a JMP $1afa ; (negaccu + 0)
--------------------------------------------------------------------
negaccu:
1afa : 38 __ __ SEC
1afb : a9 00 __ LDA #$00
1afd : e5 1b __ SBC ACCU + 0 
1aff : 85 1b __ STA ACCU + 0 
1b01 : a9 00 __ LDA #$00
1b03 : e5 1c __ SBC ACCU + 1 
1b05 : 85 1c __ STA ACCU + 1 
1b07 : 60 __ __ RTS
--------------------------------------------------------------------
negtmp:
1b08 : 38 __ __ SEC
1b09 : a9 00 __ LDA #$00
1b0b : e5 03 __ SBC WORK + 0 
1b0d : 85 03 __ STA WORK + 0 
1b0f : a9 00 __ LDA #$00
1b11 : e5 04 __ SBC WORK + 1 
1b13 : 85 04 __ STA WORK + 1 
1b15 : 60 __ __ RTS
--------------------------------------------------------------------
divmod:
1b16 : a5 1c __ LDA ACCU + 1 
1b18 : d0 31 __ BNE $1b4b ; (divmod + 53)
1b1a : a5 04 __ LDA WORK + 1 
1b1c : d0 1e __ BNE $1b3c ; (divmod + 38)
1b1e : 85 06 __ STA WORK + 3 
1b20 : a2 04 __ LDX #$04
1b22 : 06 1b __ ASL ACCU + 0 
1b24 : 2a __ __ ROL
1b25 : c5 03 __ CMP WORK + 0 
1b27 : 90 02 __ BCC $1b2b ; (divmod + 21)
1b29 : e5 03 __ SBC WORK + 0 
1b2b : 26 1b __ ROL ACCU + 0 
1b2d : 2a __ __ ROL
1b2e : c5 03 __ CMP WORK + 0 
1b30 : 90 02 __ BCC $1b34 ; (divmod + 30)
1b32 : e5 03 __ SBC WORK + 0 
1b34 : 26 1b __ ROL ACCU + 0 
1b36 : ca __ __ DEX
1b37 : d0 eb __ BNE $1b24 ; (divmod + 14)
1b39 : 85 05 __ STA WORK + 2 
1b3b : 60 __ __ RTS
1b3c : a5 1b __ LDA ACCU + 0 
1b3e : 85 05 __ STA WORK + 2 
1b40 : a5 1c __ LDA ACCU + 1 
1b42 : 85 06 __ STA WORK + 3 
1b44 : a9 00 __ LDA #$00
1b46 : 85 1b __ STA ACCU + 0 
1b48 : 85 1c __ STA ACCU + 1 
1b4a : 60 __ __ RTS
1b4b : a5 04 __ LDA WORK + 1 
1b4d : d0 1f __ BNE $1b6e ; (divmod + 88)
1b4f : a5 03 __ LDA WORK + 0 
1b51 : 30 1b __ BMI $1b6e ; (divmod + 88)
1b53 : a9 00 __ LDA #$00
1b55 : 85 06 __ STA WORK + 3 
1b57 : a2 10 __ LDX #$10
1b59 : 06 1b __ ASL ACCU + 0 
1b5b : 26 1c __ ROL ACCU + 1 
1b5d : 2a __ __ ROL
1b5e : c5 03 __ CMP WORK + 0 
1b60 : 90 02 __ BCC $1b64 ; (divmod + 78)
1b62 : e5 03 __ SBC WORK + 0 
1b64 : 26 1b __ ROL ACCU + 0 
1b66 : 26 1c __ ROL ACCU + 1 
1b68 : ca __ __ DEX
1b69 : d0 f2 __ BNE $1b5d ; (divmod + 71)
1b6b : 85 05 __ STA WORK + 2 
1b6d : 60 __ __ RTS
1b6e : a9 00 __ LDA #$00
1b70 : 85 05 __ STA WORK + 2 
1b72 : 85 06 __ STA WORK + 3 
1b74 : 84 02 __ STY $02 
1b76 : a0 10 __ LDY #$10
1b78 : 18 __ __ CLC
1b79 : 26 1b __ ROL ACCU + 0 
1b7b : 26 1c __ ROL ACCU + 1 
1b7d : 26 05 __ ROL WORK + 2 
1b7f : 26 06 __ ROL WORK + 3 
1b81 : 38 __ __ SEC
1b82 : a5 05 __ LDA WORK + 2 
1b84 : e5 03 __ SBC WORK + 0 
1b86 : aa __ __ TAX
1b87 : a5 06 __ LDA WORK + 3 
1b89 : e5 04 __ SBC WORK + 1 
1b8b : 90 04 __ BCC $1b91 ; (divmod + 123)
1b8d : 86 05 __ STX WORK + 2 
1b8f : 85 06 __ STA WORK + 3 
1b91 : 88 __ __ DEY
1b92 : d0 e5 __ BNE $1b79 ; (divmod + 99)
1b94 : 26 1b __ ROL ACCU + 0 
1b96 : 26 1c __ ROL ACCU + 1 
1b98 : a4 02 __ LDY $02 
1b9a : 60 __ __ RTS
--------------------------------------------------------------------
mods16:
1b9b : 24 1c __ BIT ACCU + 1 
1b9d : 10 0d __ BPL $1bac ; (mods16 + 17)
1b9f : 20 fa 1a JSR $1afa ; (negaccu + 0)
1ba2 : 24 04 __ BIT WORK + 1 
1ba4 : 10 0d __ BPL $1bb3 ; (mods16 + 24)
1ba6 : 20 08 1b JSR $1b08 ; (negtmp + 0)
1ba9 : 4c 16 1b JMP $1b16 ; (divmod + 0)
1bac : 24 04 __ BIT WORK + 1 
1bae : 10 f9 __ BPL $1ba9 ; (mods16 + 14)
1bb0 : 20 08 1b JSR $1b08 ; (negtmp + 0)
1bb3 : 20 16 1b JSR $1b16 ; (divmod + 0)
1bb6 : 38 __ __ SEC
1bb7 : a9 00 __ LDA #$00
1bb9 : e5 05 __ SBC WORK + 2 
1bbb : 85 05 __ STA WORK + 2 
1bbd : a9 00 __ LDA #$00
1bbf : e5 06 __ SBC WORK + 3 
1bc1 : 85 06 __ STA WORK + 3 
1bc3 : 60 __ __ RTS
--------------------------------------------------------------------
f32_to_i16:
1bc4 : 20 57 18 JSR $1857 ; (freg + 36)
1bc7 : a5 07 __ LDA WORK + 4 
1bc9 : c9 7f __ CMP #$7f
1bcb : b0 07 __ BCS $1bd4 ; (f32_to_i16 + 16)
1bcd : a9 00 __ LDA #$00
1bcf : 85 1b __ STA ACCU + 0 
1bd1 : 85 1c __ STA ACCU + 1 
1bd3 : 60 __ __ RTS
1bd4 : 38 __ __ SEC
1bd5 : e9 8e __ SBC #$8e
1bd7 : 90 0a __ BCC $1be3 ; (f32_to_i16 + 31)
1bd9 : a9 ff __ LDA #$ff
1bdb : 85 1b __ STA ACCU + 0 
1bdd : a9 7f __ LDA #$7f
1bdf : 85 1c __ STA ACCU + 1 
1be1 : d0 08 __ BNE $1beb ; (f32_to_i16 + 39)
1be3 : aa __ __ TAX
1be4 : 46 1d __ LSR ACCU + 2 
1be6 : 66 1c __ ROR ACCU + 1 
1be8 : e8 __ __ INX
1be9 : d0 f9 __ BNE $1be4 ; (f32_to_i16 + 32)
1beb : 24 1e __ BIT ACCU + 3 
1bed : 10 0e __ BPL $1bfd ; (f32_to_i16 + 57)
1bef : 38 __ __ SEC
1bf0 : a9 00 __ LDA #$00
1bf2 : e5 1c __ SBC ACCU + 1 
1bf4 : 85 1b __ STA ACCU + 0 
1bf6 : a9 00 __ LDA #$00
1bf8 : e5 1d __ SBC ACCU + 2 
1bfa : 85 1c __ STA ACCU + 1 
1bfc : 60 __ __ RTS
1bfd : a5 1c __ LDA ACCU + 1 
1bff : 85 1b __ STA ACCU + 0 
1c01 : a5 1d __ LDA ACCU + 2 
1c03 : 85 1c __ STA ACCU + 1 
1c05 : 60 __ __ RTS
--------------------------------------------------------------------
sint16_to_float:
1c06 : 24 1c __ BIT ACCU + 1 
1c08 : 30 03 __ BMI $1c0d ; (sint16_to_float + 7)
1c0a : 4c 24 1c JMP $1c24 ; (uint16_to_float + 0)
1c0d : 38 __ __ SEC
1c0e : a9 00 __ LDA #$00
1c10 : e5 1b __ SBC ACCU + 0 
1c12 : 85 1b __ STA ACCU + 0 
1c14 : a9 00 __ LDA #$00
1c16 : e5 1c __ SBC ACCU + 1 
1c18 : 85 1c __ STA ACCU + 1 
1c1a : 20 24 1c JSR $1c24 ; (uint16_to_float + 0)
1c1d : a5 1e __ LDA ACCU + 3 
1c1f : 09 80 __ ORA #$80
1c21 : 85 1e __ STA ACCU + 3 
1c23 : 60 __ __ RTS
--------------------------------------------------------------------
uint16_to_float:
1c24 : a5 1b __ LDA ACCU + 0 
1c26 : 05 1c __ ORA ACCU + 1 
1c28 : d0 05 __ BNE $1c2f ; (uint16_to_float + 11)
1c2a : 85 1d __ STA ACCU + 2 
1c2c : 85 1e __ STA ACCU + 3 
1c2e : 60 __ __ RTS
1c2f : a2 8e __ LDX #$8e
1c31 : a5 1c __ LDA ACCU + 1 
1c33 : 30 06 __ BMI $1c3b ; (uint16_to_float + 23)
1c35 : ca __ __ DEX
1c36 : 06 1b __ ASL ACCU + 0 
1c38 : 2a __ __ ROL
1c39 : 10 fa __ BPL $1c35 ; (uint16_to_float + 17)
1c3b : 29 7f __ AND #$7f
1c3d : 85 1d __ STA ACCU + 2 
1c3f : a5 1b __ LDA ACCU + 0 
1c41 : 85 1c __ STA ACCU + 1 
1c43 : 8a __ __ TXA
1c44 : 4a __ __ LSR
1c45 : 85 1e __ STA ACCU + 3 
1c47 : a9 00 __ LDA #$00
1c49 : 85 1b __ STA ACCU + 0 
1c4b : 6a __ __ ROR
1c4c : 05 1d __ ORA ACCU + 2 
1c4e : 85 1d __ STA ACCU + 2 
1c50 : 60 __ __ RTS
--------------------------------------------------------------------
divmod32:
1c51 : 84 02 __ STY $02 
1c53 : a0 20 __ LDY #$20
1c55 : a9 00 __ LDA #$00
1c57 : 85 07 __ STA WORK + 4 
1c59 : 85 08 __ STA WORK + 5 
1c5b : 85 09 __ STA WORK + 6 
1c5d : 85 0a __ STA WORK + 7 
1c5f : a5 05 __ LDA WORK + 2 
1c61 : 05 06 __ ORA WORK + 3 
1c63 : d0 39 __ BNE $1c9e ; (divmod32 + 77)
1c65 : 18 __ __ CLC
1c66 : 26 1b __ ROL ACCU + 0 
1c68 : 26 1c __ ROL ACCU + 1 
1c6a : 26 1d __ ROL ACCU + 2 
1c6c : 26 1e __ ROL ACCU + 3 
1c6e : 26 07 __ ROL WORK + 4 
1c70 : 26 08 __ ROL WORK + 5 
1c72 : 90 0c __ BCC $1c80 ; (divmod32 + 47)
1c74 : a5 07 __ LDA WORK + 4 
1c76 : e5 03 __ SBC WORK + 0 
1c78 : aa __ __ TAX
1c79 : a5 08 __ LDA WORK + 5 
1c7b : e5 04 __ SBC WORK + 1 
1c7d : 38 __ __ SEC
1c7e : b0 0c __ BCS $1c8c ; (divmod32 + 59)
1c80 : 38 __ __ SEC
1c81 : a5 07 __ LDA WORK + 4 
1c83 : e5 03 __ SBC WORK + 0 
1c85 : aa __ __ TAX
1c86 : a5 08 __ LDA WORK + 5 
1c88 : e5 04 __ SBC WORK + 1 
1c8a : 90 04 __ BCC $1c90 ; (divmod32 + 63)
1c8c : 86 07 __ STX WORK + 4 
1c8e : 85 08 __ STA WORK + 5 
1c90 : 88 __ __ DEY
1c91 : d0 d3 __ BNE $1c66 ; (divmod32 + 21)
1c93 : 26 1b __ ROL ACCU + 0 
1c95 : 26 1c __ ROL ACCU + 1 
1c97 : 26 1d __ ROL ACCU + 2 
1c99 : 26 1e __ ROL ACCU + 3 
1c9b : a4 02 __ LDY $02 
1c9d : 60 __ __ RTS
1c9e : 18 __ __ CLC
1c9f : 26 1b __ ROL ACCU + 0 
1ca1 : 26 1c __ ROL ACCU + 1 
1ca3 : 26 1d __ ROL ACCU + 2 
1ca5 : 26 1e __ ROL ACCU + 3 
1ca7 : 26 07 __ ROL WORK + 4 
1ca9 : 26 08 __ ROL WORK + 5 
1cab : 26 09 __ ROL WORK + 6 
1cad : 26 0a __ ROL WORK + 7 
1caf : a5 07 __ LDA WORK + 4 
1cb1 : c5 03 __ CMP WORK + 0 
1cb3 : a5 08 __ LDA WORK + 5 
1cb5 : e5 04 __ SBC WORK + 1 
1cb7 : a5 09 __ LDA WORK + 6 
1cb9 : e5 05 __ SBC WORK + 2 
1cbb : a5 0a __ LDA WORK + 7 
1cbd : e5 06 __ SBC WORK + 3 
1cbf : 90 18 __ BCC $1cd9 ; (divmod32 + 136)
1cc1 : a5 07 __ LDA WORK + 4 
1cc3 : e5 03 __ SBC WORK + 0 
1cc5 : 85 07 __ STA WORK + 4 
1cc7 : a5 08 __ LDA WORK + 5 
1cc9 : e5 04 __ SBC WORK + 1 
1ccb : 85 08 __ STA WORK + 5 
1ccd : a5 09 __ LDA WORK + 6 
1ccf : e5 05 __ SBC WORK + 2 
1cd1 : 85 09 __ STA WORK + 6 
1cd3 : a5 0a __ LDA WORK + 7 
1cd5 : e5 06 __ SBC WORK + 3 
1cd7 : 85 0a __ STA WORK + 7 
1cd9 : 88 __ __ DEY
1cda : d0 c3 __ BNE $1c9f ; (divmod32 + 78)
1cdc : 26 1b __ ROL ACCU + 0 
1cde : 26 1c __ ROL ACCU + 1 
1ce0 : 26 1d __ ROL ACCU + 2 
1ce2 : 26 1e __ ROL ACCU + 3 
1ce4 : a4 02 __ LDY $02 
1ce6 : 60 __ __ RTS
