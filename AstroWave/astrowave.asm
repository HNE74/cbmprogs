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
080e : 8e ff 1a STX $1aff ; (spentry + 0)
0811 : a9 bb __ LDA #$bb
0813 : 85 19 __ STA IP + 0 
0815 : a9 31 __ LDA #$31
0817 : 85 1a __ STA IP + 1 
0819 : 38 __ __ SEC
081a : a9 32 __ LDA #$32
081c : e9 31 __ SBC #$31
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
0830 : a9 3b __ LDA #$3b
0832 : e9 bb __ SBC #$bb
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
084b : a9 c4 __ LDA #$c4
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
1aff : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
main:
.s0:
0880 : 20 41 09 JSR $0941 ; (redefine_charset.s0 + 0)
0883 : a9 00 __ LDA #$00
0885 : 85 11 __ STA P4 
0887 : a9 12 __ LDA #$12
0889 : 85 12 __ STA P5 
088b : a9 28 __ LDA #$28
088d : 85 13 __ STA P6 
088f : a9 01 __ LDA #$01
0891 : 85 14 __ STA P7 
0893 : a9 bb __ LDA #$bb
0895 : 85 0d __ STA P0 
0897 : a9 31 __ LDA #$31
0899 : 85 0e __ STA P1 
089b : a9 00 __ LDA #$00
089d : 85 0f __ STA P2 
089f : a9 c0 __ LDA #$c0
08a1 : 85 10 __ STA P3 
08a3 : 20 51 0a JSR $0a51 ; (cwin_init.s0 + 0)
08a6 : a9 c0 __ LDA #$c0
08a8 : 85 10 __ STA P3 
08aa : a9 00 __ LDA #$00
08ac : 85 12 __ STA P5 
08ae : a9 03 __ LDA #$03
08b0 : 85 14 __ STA P7 
08b2 : a9 c5 __ LDA #$c5
08b4 : 85 0d __ STA P0 
08b6 : a9 31 __ LDA #$31
08b8 : 85 0e __ STA P1 
08ba : 20 51 0a JSR $0a51 ; (cwin_init.s0 + 0)
08bd : a9 c0 __ LDA #$c0
08bf : 85 10 __ STA P3 
08c1 : a9 09 __ LDA #$09
08c3 : 85 11 __ STA P4 
08c5 : a9 07 __ LDA #$07
08c7 : 85 12 __ STA P5 
08c9 : a9 0a __ LDA #$0a
08cb : 85 13 __ STA P6 
08cd : a9 05 __ LDA #$05
08cf : 85 14 __ STA P7 
08d1 : a9 cf __ LDA #$cf
08d3 : 85 0d __ STA P0 
08d5 : a9 31 __ LDA #$31
08d7 : 85 0e __ STA P1 
08d9 : 20 51 0a JSR $0a51 ; (cwin_init.s0 + 0)
08dc : a9 00 __ LDA #$00
08de : 8d d9 31 STA $31d9 ; (game + 0)
08e1 : 8d de 31 STA $31de ; (game + 5)
08e4 : 8d df 31 STA $31df ; (game + 6)
08e7 : 8d e0 31 STA $31e0 ; (game + 7)
08ea : 8d e1 31 STA $31e1 ; (game + 8)
.l3:
08ed : 20 a7 0a JSR $0aa7 ; (show_intro_screen.s1000 + 0)
08f0 : ad d9 31 LDA $31d9 ; (game + 0)
08f3 : d0 0f __ BNE $0904 ; (main.s7 + 0)
.l6:
08f5 : 20 c0 18 JSR $18c0 ; (joy_poll.s0 + 0)
08f8 : ad e7 31 LDA $31e7 ; (joyb + 0)
08fb : c9 01 __ CMP #$01
08fd : f0 31 __ BEQ $0930 ; (main.s8 + 0)
.s48:
08ff : ad d9 31 LDA $31d9 ; (game + 0)
0902 : f0 f1 __ BEQ $08f5 ; (main.l6 + 0)
.s7:
0904 : 20 21 19 JSR $1921 ; (game_loop.s0 + 0)
0907 : 20 44 23 JSR $2344 ; (show_game_over_screen.s1000 + 0)
.l50:
090a : ad d9 31 LDA $31d9 ; (game + 0)
090d : c9 04 __ CMP #$04
090f : d0 dc __ BNE $08ed ; (main.l3 + 0)
.s12:
0911 : a9 00 __ LDA #$00
0913 : 20 c0 18 JSR $18c0 ; (joy_poll.s0 + 0)
0916 : ad e7 31 LDA $31e7 ; (joyb + 0)
0919 : c9 01 __ CMP #$01
091b : d0 ed __ BNE $090a ; (main.l50 + 0)
.s14:
091d : a9 00 __ LDA #$00
091f : 8d d9 31 STA $31d9 ; (game + 0)
0922 : a9 0a __ LDA #$0a
0924 : 85 0d __ STA P0 
0926 : a9 00 __ LDA #$00
0928 : 85 0e __ STA P1 
092a : 20 00 19 JSR $1900 ; (wait_frames.s0 + 0)
092d : 4c ed 08 JMP $08ed ; (main.l3 + 0)
.s8:
0930 : 8d d9 31 STA $31d9 ; (game + 0)
0933 : a9 0a __ LDA #$0a
0935 : 85 0d __ STA P0 
0937 : a9 00 __ LDA #$00
0939 : 85 0e __ STA P1 
093b : 20 00 19 JSR $1900 ; (wait_frames.s0 + 0)
093e : 4c 04 09 JMP $0904 ; (main.s7 + 0)
--------------------------------------------------------------------
redefine_charset:
.s0:
0941 : 20 81 09 JSR $0981 ; (mmap_trampoline.s0 + 0)
0944 : a9 31 __ LDA #$31
0946 : 85 01 __ STA $01 
0948 : a9 00 __ LDA #$00
094a : 85 11 __ STA P4 
094c : 85 0d __ STA P0 
094e : 85 0f __ STA P2 
0950 : a9 08 __ LDA #$08
0952 : 85 12 __ STA P5 
0954 : a9 c8 __ LDA #$c8
0956 : 85 0e __ STA P1 
0958 : a9 d0 __ LDA #$d0
095a : 85 10 __ STA P3 
095c : 20 cb 09 JSR $09cb ; (memcpy.s0 + 0)
095f : a2 38 __ LDX #$38
.l1002:
0961 : bd 59 29 LDA $2959,x ; (__multab2000H + 7)
0964 : 9d ff cb STA $cbff,x 
0967 : ca __ __ DEX
0968 : d0 f7 __ BNE $0961 ; (redefine_charset.l1002 + 0)
.s1003:
096a : a9 37 __ LDA #$37
096c : 85 01 __ STA $01 
096e : a9 00 __ LDA #$00
0970 : 85 0d __ STA P0 
0972 : 85 0e __ STA P1 
0974 : 85 10 __ STA P3 
0976 : a9 c8 __ LDA #$c8
0978 : 85 11 __ STA P4 
097a : a9 c0 __ LDA #$c0
097c : 85 0f __ STA P2 
097e : 4c fa 09 JMP $09fa ; (vic_setmode.s0 + 0)
--------------------------------------------------------------------
mmap_trampoline:
.s0:
0981 : a9 96 __ LDA #$96
0983 : 8d fa ff STA $fffa 
0986 : a9 09 __ LDA #$09
0988 : 8d fb ff STA $fffb 
098b : a9 b4 __ LDA #$b4
098d : 8d fe ff STA $fffe 
0990 : a9 09 __ LDA #$09
0992 : 8d ff ff STA $ffff 
.s1001:
0995 : 60 __ __ RTS
--------------------------------------------------------------------
NMITrampoline:
0996 : 48 __ __ PHA
0997 : 8a __ __ TXA
0998 : 48 __ __ PHA
0999 : a9 09 __ LDA #$09
099b : 48 __ __ PHA
099c : a9 ad __ LDA #$ad
099e : 48 __ __ PHA
099f : ba __ __ TSX
09a0 : bd 05 01 LDA $0105,x 
09a3 : 48 __ __ PHA
09a4 : a6 01 __ LDX $01 
09a6 : a9 36 __ LDA #$36
09a8 : 85 01 __ STA $01 
09aa : 6c fa ff JMP ($fffa)
--------------------------------------------------------------------
DoneTrampoline:
09ad : 86 01 __ STX $01 
09af : 68 __ __ PLA
09b0 : aa __ __ TAX
09b1 : 68 __ __ PLA
09b2 : 40 __ __ RTI
09b3 : 60 __ __ RTS
--------------------------------------------------------------------
IRQTrampoline:
09b4 : 48 __ __ PHA
09b5 : 8a __ __ TXA
09b6 : 48 __ __ PHA
09b7 : a9 09 __ LDA #$09
09b9 : 48 __ __ PHA
09ba : a9 ad __ LDA #$ad
09bc : 48 __ __ PHA
09bd : ba __ __ TSX
09be : bd 05 01 LDA $0105,x 
09c1 : 48 __ __ PHA
09c2 : a6 01 __ LDX $01 
09c4 : a9 36 __ LDA #$36
09c6 : 85 01 __ STA $01 
09c8 : 6c fe ff JMP ($fffe)
--------------------------------------------------------------------
memcpy:
.s0:
09cb : a6 12 __ LDX P5 
09cd : f0 10 __ BEQ $09df ; (memcpy.s0 + 20)
09cf : a0 00 __ LDY #$00
09d1 : b1 0f __ LDA (P2),y 
09d3 : 91 0d __ STA (P0),y ; (dst + 0)
09d5 : c8 __ __ INY
09d6 : d0 f9 __ BNE $09d1 ; (memcpy.s0 + 6)
09d8 : e6 10 __ INC P3 
09da : e6 0e __ INC P1 ; (dst + 1)
09dc : ca __ __ DEX
09dd : d0 f2 __ BNE $09d1 ; (memcpy.s0 + 6)
09df : a4 11 __ LDY P4 
09e1 : f0 0e __ BEQ $09f1 ; (memcpy.s0 + 38)
09e3 : 88 __ __ DEY
09e4 : f0 07 __ BEQ $09ed ; (memcpy.s0 + 34)
09e6 : b1 0f __ LDA (P2),y 
09e8 : 91 0d __ STA (P0),y ; (dst + 0)
09ea : 88 __ __ DEY
09eb : d0 f9 __ BNE $09e6 ; (memcpy.s0 + 27)
09ed : b1 0f __ LDA (P2),y 
09ef : 91 0d __ STA (P0),y ; (dst + 0)
09f1 : a5 0d __ LDA P0 ; (dst + 0)
09f3 : 85 1b __ STA ACCU + 0 
09f5 : a5 0e __ LDA P1 ; (dst + 1)
09f7 : 85 1c __ STA ACCU + 1 
.s1001:
09f9 : 60 __ __ RTS
--------------------------------------------------------------------
ChrRedef:
295a : __ __ __ BYT 80 e0 f8 7f 7f f8 e0 80 00 00 60 3e 3e 60 00 00 : ..........`>>`..
296a : __ __ __ BYT 00 00 3c 66 66 3c 00 00 1c 7f c6 1f 1f c6 7f 1c : ..<ff<..........
297a : __ __ __ BYT 00 3c 7e d5 ab 7e 3c 00 28 3c 6e df 5f fe 3c 14 : .<~..~<.(<n._.<.
298a : __ __ __ BYT 28 56 65 92 69 36 44 2a                         : (Ve.i6D*
--------------------------------------------------------------------
vic_setmode:
.s0:
09fa : a6 0f __ LDX P2 ; (text + 1)
09fc : a4 0d __ LDY P0 ; (mode + 0)
09fe : c0 02 __ CPY #$02
0a00 : d0 07 __ BNE $0a09 ; (vic_setmode.s15 + 0)
.s6:
0a02 : a9 5b __ LDA #$5b
0a04 : 8d 11 d0 STA $d011 
0a07 : d0 0d __ BNE $0a16 ; (vic_setmode.s23 + 0)
.s15:
0a09 : c0 02 __ CPY #$02
0a0b : 90 39 __ BCC $0a46 ; (vic_setmode.s17 + 0)
.s16:
0a0d : a9 3b __ LDA #$3b
0a0f : 8d 11 d0 STA $d011 
0a12 : c0 03 __ CPY #$03
0a14 : d0 04 __ BNE $0a1a ; (vic_setmode.s1009 + 0)
.s23:
0a16 : a9 08 __ LDA #$08
0a18 : d0 02 __ BNE $0a1c ; (vic_setmode.s1 + 0)
.s1009:
0a1a : a9 18 __ LDA #$18
.s1:
0a1c : 8d 16 d0 STA $d016 
0a1f : ad 00 dd LDA $dd00 
0a22 : 29 fc __ AND #$fc
0a24 : 85 1b __ STA ACCU + 0 
0a26 : 8a __ __ TXA
0a27 : 0a __ __ ASL
0a28 : 2a __ __ ROL
0a29 : 29 01 __ AND #$01
0a2b : 2a __ __ ROL
0a2c : 49 03 __ EOR #$03
0a2e : 05 1b __ ORA ACCU + 0 
0a30 : 8d 00 dd STA $dd00 
0a33 : 8a __ __ TXA
0a34 : 0a __ __ ASL
0a35 : 0a __ __ ASL
0a36 : 29 f0 __ AND #$f0
0a38 : 85 1b __ STA ACCU + 0 
0a3a : a5 11 __ LDA P4 ; (font + 1)
0a3c : 4a __ __ LSR
0a3d : 4a __ __ LSR
0a3e : 29 0e __ AND #$0e
0a40 : 05 1b __ ORA ACCU + 0 
0a42 : 8d 18 d0 STA $d018 
.s1001:
0a45 : 60 __ __ RTS
.s17:
0a46 : a9 1b __ LDA #$1b
0a48 : 8d 11 d0 STA $d011 
0a4b : 98 __ __ TYA
0a4c : d0 cc __ BNE $0a1a ; (vic_setmode.s1009 + 0)
0a4e : 4c 16 0a JMP $0a16 ; (vic_setmode.s23 + 0)
--------------------------------------------------------------------
cwin_init:
.s0:
0a51 : a9 00 __ LDA #$00
0a53 : a0 04 __ LDY #$04
0a55 : 91 0d __ STA (P0),y ; (win + 0)
0a57 : c8 __ __ INY
0a58 : 91 0d __ STA (P0),y ; (win + 0)
0a5a : a5 11 __ LDA P4 ; (sx + 0)
0a5c : a0 00 __ LDY #$00
0a5e : 91 0d __ STA (P0),y ; (win + 0)
0a60 : a5 12 __ LDA P5 ; (sy + 0)
0a62 : c8 __ __ INY
0a63 : 91 0d __ STA (P0),y ; (win + 0)
0a65 : a5 13 __ LDA P6 ; (wx + 0)
0a67 : c8 __ __ INY
0a68 : 91 0d __ STA (P0),y ; (win + 0)
0a6a : a5 14 __ LDA P7 ; (wy + 0)
0a6c : c8 __ __ INY
0a6d : 91 0d __ STA (P0),y ; (win + 0)
0a6f : a5 12 __ LDA P5 ; (sy + 0)
0a71 : 0a __ __ ASL
0a72 : a8 __ __ TAY
0a73 : b9 92 29 LDA $2992,y ; (mul40 + 0)
0a76 : 85 1b __ STA ACCU + 0 
0a78 : 18 __ __ CLC
0a79 : 65 11 __ ADC P4 ; (sx + 0)
0a7b : aa __ __ TAX
0a7c : b9 93 29 LDA $2993,y ; (mul40 + 1)
0a7f : 85 1c __ STA ACCU + 1 
0a81 : 69 d8 __ ADC #$d8
0a83 : a0 09 __ LDY #$09
0a85 : 91 0d __ STA (P0),y ; (win + 0)
0a87 : 8a __ __ TXA
0a88 : 88 __ __ DEY
0a89 : 91 0d __ STA (P0),y ; (win + 0)
0a8b : 18 __ __ CLC
0a8c : a5 0f __ LDA P2 ; (screen + 0)
0a8e : 65 1b __ ADC ACCU + 0 
0a90 : aa __ __ TAX
0a91 : a5 10 __ LDA P3 ; (screen + 1)
0a93 : 65 1c __ ADC ACCU + 1 
0a95 : 85 10 __ STA P3 ; (screen + 1)
0a97 : 8a __ __ TXA
0a98 : 18 __ __ CLC
0a99 : 65 11 __ ADC P4 ; (sx + 0)
0a9b : a0 06 __ LDY #$06
0a9d : 91 0d __ STA (P0),y ; (win + 0)
0a9f : a5 10 __ LDA P3 ; (screen + 1)
0aa1 : 69 00 __ ADC #$00
0aa3 : c8 __ __ INY
0aa4 : 91 0d __ STA (P0),y ; (win + 0)
.s1001:
0aa6 : 60 __ __ RTS
--------------------------------------------------------------------
mul40:
2992 : __ __ __ BYT 00 00 28 00 50 00 78 00 a0 00 c8 00 f0 00 18 01 : ..(.P.x.........
29a2 : __ __ __ BYT 40 01 68 01 90 01 b8 01 e0 01 08 02 30 02 58 02 : @.h.........0.X.
29b2 : __ __ __ BYT 80 02 a8 02 d0 02 f8 02 20 03 48 03 70 03 98 03 : ........ .H.p...
29c2 : __ __ __ BYT c0 03                                           : ..
--------------------------------------------------------------------
cwIntro:
31bb : __ __ __ BSS	10
--------------------------------------------------------------------
cwTop:
31c5 : __ __ __ BSS	10
--------------------------------------------------------------------
cwGameOver:
31cf : __ __ __ BSS	10
--------------------------------------------------------------------
game:
31d9 : __ __ __ BSS	10
--------------------------------------------------------------------
show_intro_screen:
.s1000:
0aa7 : 38 __ __ SEC
0aa8 : a5 23 __ LDA SP + 0 
0aaa : e9 0a __ SBC #$0a
0aac : 85 23 __ STA SP + 0 
0aae : b0 02 __ BCS $0ab2 ; (show_intro_screen.s0 + 0)
0ab0 : c6 24 __ DEC SP + 1 
.s0:
0ab2 : a9 0b __ LDA #$0b
0ab4 : 8d 20 d0 STA $d020 
0ab7 : a9 00 __ LDA #$00
0ab9 : 8d 21 d0 STA $d021 
0abc : 20 4c 0b JSR $0b4c ; (clear_screen.s0 + 0)
0abf : a9 00 __ LDA #$00
0ac1 : 85 11 __ STA P4 
0ac3 : 85 0d __ STA P0 
0ac5 : a9 04 __ LDA #$04
0ac7 : 85 12 __ STA P5 
0ac9 : a9 d8 __ LDA #$d8
0acb : 85 0e __ STA P1 
0acd : a9 c4 __ LDA #$c4
0acf : 85 0f __ STA P2 
0ad1 : a9 29 __ LDA #$29
0ad3 : 85 10 __ STA P3 
0ad5 : 20 cb 09 JSR $09cb ; (memcpy.s0 + 0)
0ad8 : a9 00 __ LDA #$00
0ada : 85 11 __ STA P4 
0adc : 85 0d __ STA P0 
0ade : a9 04 __ LDA #$04
0ae0 : 85 12 __ STA P5 
0ae2 : a9 c0 __ LDA #$c0
0ae4 : 85 0e __ STA P1 
0ae6 : a9 ac __ LDA #$ac
0ae8 : 85 0f __ STA P2 
0aea : a9 2d __ LDA #$2d
0aec : 85 10 __ STA P3 
0aee : 20 cb 09 JSR $09cb ; (memcpy.s0 + 0)
0af1 : a9 ce __ LDA #$ce
0af3 : a0 02 __ LDY #$02
0af5 : 91 23 __ STA (SP + 0),y 
0af7 : a9 9f __ LDA #$9f
0af9 : c8 __ __ INY
0afa : 91 23 __ STA (SP + 0),y 
0afc : a9 69 __ LDA #$69
0afe : c8 __ __ INY
0aff : 91 23 __ STA (SP + 0),y 
0b01 : a9 18 __ LDA #$18
0b03 : c8 __ __ INY
0b04 : 91 23 __ STA (SP + 0),y 
0b06 : ad de 31 LDA $31de ; (game + 5)
0b09 : c8 __ __ INY
0b0a : 91 23 __ STA (SP + 0),y 
0b0c : ad df 31 LDA $31df ; (game + 6)
0b0f : c8 __ __ INY
0b10 : 91 23 __ STA (SP + 0),y 
0b12 : ad e0 31 LDA $31e0 ; (game + 7)
0b15 : c8 __ __ INY
0b16 : 91 23 __ STA (SP + 0),y 
0b18 : ad e1 31 LDA $31e1 ; (game + 8)
0b1b : c8 __ __ INY
0b1c : 91 23 __ STA (SP + 0),y 
0b1e : 20 a0 0b JSR $0ba0 ; (sprintf.s1000 + 0)
0b21 : a9 1e __ LDA #$1e
0b23 : 85 0f __ STA P2 
0b25 : a9 00 __ LDA #$00
0b27 : 85 10 __ STA P3 
0b29 : a9 ce __ LDA #$ce
0b2b : 85 11 __ STA P4 
0b2d : a9 9f __ LDA #$9f
0b2f : 85 12 __ STA P5 
0b31 : a9 0a __ LDA #$0a
0b33 : 85 13 __ STA P6 
0b35 : a9 bb __ LDA #$bb
0b37 : 85 0d __ STA P0 
0b39 : a9 31 __ LDA #$31
0b3b : 85 0e __ STA P1 
0b3d : 20 6e 18 JSR $186e ; (cwin_putat_string.s0 + 0)
.s1001:
0b40 : 18 __ __ CLC
0b41 : a5 23 __ LDA SP + 0 
0b43 : 69 0a __ ADC #$0a
0b45 : 85 23 __ STA SP + 0 
0b47 : 90 02 __ BCC $0b4b ; (show_intro_screen.s1001 + 11)
0b49 : e6 24 __ INC SP + 1 
0b4b : 60 __ __ RTS
--------------------------------------------------------------------
clear_screen:
.s0:
0b4c : a9 20 __ LDA #$20
0b4e : 85 0f __ STA P2 
0b50 : a9 00 __ LDA #$00
0b52 : 85 10 __ STA P3 
0b54 : 85 0d __ STA P0 
0b56 : a9 e8 __ LDA #$e8
0b58 : 85 11 __ STA P4 
0b5a : a9 03 __ LDA #$03
0b5c : 85 12 __ STA P5 
0b5e : a9 c0 __ LDA #$c0
0b60 : 85 0e __ STA P1 
0b62 : 20 7c 0b JSR $0b7c ; (memset.s0 + 0)
0b65 : a9 00 __ LDA #$00
0b67 : 85 0f __ STA P2 
0b69 : 85 10 __ STA P3 
0b6b : 85 0d __ STA P0 
0b6d : a9 e8 __ LDA #$e8
0b6f : 85 11 __ STA P4 
0b71 : a9 03 __ LDA #$03
0b73 : 85 12 __ STA P5 
0b75 : a9 d8 __ LDA #$d8
0b77 : 85 0e __ STA P1 
0b79 : 4c 7c 0b JMP $0b7c ; (memset.s0 + 0)
--------------------------------------------------------------------
memset:
.s0:
0b7c : a5 0f __ LDA P2 
0b7e : a6 12 __ LDX P5 
0b80 : f0 0c __ BEQ $0b8e ; (memset.s0 + 18)
0b82 : a0 00 __ LDY #$00
0b84 : 91 0d __ STA (P0),y ; (dst + 0)
0b86 : c8 __ __ INY
0b87 : d0 fb __ BNE $0b84 ; (memset.s0 + 8)
0b89 : e6 0e __ INC P1 ; (dst + 1)
0b8b : ca __ __ DEX
0b8c : d0 f6 __ BNE $0b84 ; (memset.s0 + 8)
0b8e : a4 11 __ LDY P4 
0b90 : f0 05 __ BEQ $0b97 ; (memset.s0 + 27)
0b92 : 88 __ __ DEY
0b93 : 91 0d __ STA (P0),y ; (dst + 0)
0b95 : d0 fb __ BNE $0b92 ; (memset.s0 + 22)
0b97 : a5 0d __ LDA P0 ; (dst + 0)
0b99 : 85 1b __ STA ACCU + 0 
0b9b : a5 0e __ LDA P1 ; (dst + 1)
0b9d : 85 1c __ STA ACCU + 1 
.s1001:
0b9f : 60 __ __ RTS
--------------------------------------------------------------------
IntroColors:
29c4 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
29d4 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
29e4 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 03 03 03 03 03 03 03 : ................
29f4 : __ __ __ BYT 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 : ................
2a04 : __ __ __ BYT 03 03 03 03 03 03 03 03 03 03 03 03 03 00 00 00 : ................
2a14 : __ __ __ BYT 00 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 : ................
2a24 : __ __ __ BYT 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 03 : ................
2a34 : __ __ __ BYT 03 03 03 03 03 00 00 00 00 03 03 03 03 03 03 03 : ................
2a44 : __ __ __ BYT 03 03 03 03 03 03 03 00 03 03 03 03 00 00 00 03 : ................
2a54 : __ __ __ BYT 00 00 03 03 03 03 00 00 03 03 00 03 03 00 00 00 : ................
2a64 : __ __ __ BYT 00 03 03 03 00 03 03 00 03 03 03 03 00 00 00 00 : ................
2a74 : __ __ __ BYT 00 00 03 03 00 00 00 03 00 00 03 03 03 03 00 00 : ................
2a84 : __ __ __ BYT 03 03 00 03 03 00 00 00 00 03 03 03 03 03 03 03 : ................
2a94 : __ __ __ BYT 03 03 03 03 03 03 03 03 00 00 03 03 00 00 03 03 : ................
2aa4 : __ __ __ BYT 03 03 03 03 03 03 00 00 00 03 00 00 03 00 00 00 : ................
2ab4 : __ __ __ BYT 00 03 03 03 00 03 03 00 03 03 00 00 00 03 03 03 : ................
2ac4 : __ __ __ BYT 00 00 03 03 00 00 00 03 03 00 00 00 03 03 00 00 : ................
2ad4 : __ __ __ BYT 00 03 00 00 03 00 00 00 00 00 00 03 00 03 03 00 : ................
2ae4 : __ __ __ BYT 03 03 03 03 03 03 03 03 00 00 03 03 00 00 03 03 : ................
2af4 : __ __ __ BYT 03 03 03 03 03 03 03 03 03 03 03 03 03 00 00 00 : ................
2b04 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
2b14 : __ __ __ BYT 00 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 : ................
2b24 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 03 03 03 03 : ................
2b34 : __ __ __ BYT 03 03 03 07 03 00 03 03 03 03 03 00 03 03 03 03 : ................
2b44 : __ __ __ BYT 03 00 03 03 03 03 03 03 00 00 00 00 00 00 00 00 : ................
2b54 : __ __ __ BYT 00 00 00 07 00 03 00 00 03 00 00 00 03 00 03 03 : ................
2b64 : __ __ __ BYT 03 00 03 00 03 00 00 00 03 00 03 00 00 00 00 00 : ................
2b74 : __ __ __ BYT 03 00 00 00 00 00 00 00 00 00 00 00 00 03 03 00 : ................
2b84 : __ __ __ BYT 03 03 00 00 03 00 03 00 03 00 03 00 03 00 00 00 : ................
2b94 : __ __ __ BYT 03 03 03 00 00 00 00 00 00 03 00 00 00 00 00 00 : ................
2ba4 : __ __ __ BYT 00 00 00 00 00 03 03 03 03 03 03 03 03 00 03 03 : ................
2bb4 : __ __ __ BYT 03 03 03 00 03 03 03 03 00 03 03 03 03 00 00 00 : ................
2bc4 : __ __ __ BYT 00 03 00 00 00 00 00 00 00 00 00 00 00 03 00 03 : ................
2bd4 : __ __ __ BYT 03 00 03 00 03 00 03 00 03 00 03 03 03 03 00 03 : ................
2be4 : __ __ __ BYT 00 03 03 00 00 00 00 00 03 00 00 00 00 00 00 00 : ................
2bf4 : __ __ __ BYT 00 00 00 00 00 03 03 03 03 03 03 03 03 00 03 03 : ................
2c04 : __ __ __ BYT 03 03 03 00 03 03 03 03 03 03 03 03 03 03 03 03 : ................
2c14 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
2c24 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 : ................
2c34 : __ __ __ BYT 03 03 03 03 00 00 00 00 00 00 00 00 00 00 00 00 : ................
2c44 : __ __ __ BYT 00 00 00 00 0d 0d 0d 00 0d 0d 0d 0d 0d 0d 0d 0d : ................
2c54 : __ __ __ BYT 0d 00 0d 0d 0d 0d 00 00 00 00 00 00 00 00 00 00 : ................
2c64 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 03 03 03 00 : ................
2c74 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 0d 00 00 00 00 00 00 : ................
2c84 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
2c94 : __ __ __ BYT 00 00 00 00 00 0d 00 00 00 00 00 00 00 00 00 00 : ................
2ca4 : __ __ __ BYT 00 00 00 0a 0a 0a 0a 0a 0a 0a 0a 0a 0a 00 0a 0a : ................
2cb4 : __ __ __ BYT 0a 0a 0a 0a 0a 0a 00 00 00 00 00 00 00 00 00 00 : ................
2cc4 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
2cd4 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
2ce4 : __ __ __ BYT 00 00 00 07 0d 0d 0d 0d 0d 0d 07 0d 0d 0d 0d 0d : ................
2cf4 : __ __ __ BYT 0d 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 : ................
2d04 : __ __ __ BYT 07 07 07 07 07 07 00 00 00 00 00 07 07 07 07 07 : ................
2d14 : __ __ __ BYT 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 07 : ................
2d24 : __ __ __ BYT 07 07 07 07 07 07 07 07 07 07 07 07 07 07 00 00 : ................
2d34 : __ __ __ BYT 00 00 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e : ................
2d44 : __ __ __ BYT 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e : ................
2d54 : __ __ __ BYT 0e 0e 0e 0e 0e 0e 0e 0e 00 00 00 00 00 00 00 00 : ................
2d64 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
2d74 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
2d84 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
2d94 : __ __ __ BYT 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 : ................
2da4 : __ __ __ BYT 00 00 00 00 00 00 00 00                         : ........
--------------------------------------------------------------------
IntroScreen:
2dac : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
2dbc : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
2dcc : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
2ddc : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
2dec : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
2dfc : __ __ __ BYT 20 20 20 20 20 2a 2a 2a 2a 2a 20 2a 2a 2a 2a 2a :      ***** *****
2e0c : __ __ __ BYT 20 2a 2a 2a 2a 2a 20 2a 2a 2a 2a 2a 20 2a 2a 2a :  ***** ***** ***
2e1c : __ __ __ BYT 2a 2a 20 20 20 20 20 20 20 20 20 20 20 2a 20 20 : **           *  
2e2c : __ __ __ BYT 20 2a 20 2a 20 20 20 20 20 20 20 2a 20 20 20 2a :  * *       *   *
2e3c : __ __ __ BYT 20 20 20 2a 20 2a 20 20 20 2a 20 20 20 20 20 20 :    * *   *      
2e4c : __ __ __ BYT 20 20 20 20 20 2a 20 20 20 2a 20 2a 20 20 20 20 :      *   * *    
2e5c : __ __ __ BYT 20 20 20 2a 20 20 20 2a 20 20 20 2a 20 2a 20 20 :    *   *   * *  
2e6c : __ __ __ BYT 20 2a 20 20 20 20 20 20 20 20 20 20 20 2a 2a 2a :  *           ***
2e7c : __ __ __ BYT 2a 2a 20 2a 2a 2a 2a 2a 20 20 20 2a 20 20 20 2a : ** *****   *   *
2e8c : __ __ __ BYT 2a 2a 2a 2a 20 2a 20 20 20 2a 20 20 20 20 20 20 : **** *   *      
2e9c : __ __ __ BYT 20 20 20 20 20 2a 20 20 20 2a 20 20 20 20 20 2a :      *   *     *
2eac : __ __ __ BYT 20 20 20 2a 20 20 20 2a 2a 20 20 20 20 2a 20 20 :    *   **    *  
2ebc : __ __ __ BYT 20 2a 20 20 20 20 20 20 20 20 20 20 20 2a 20 20 :  *           *  
2ecc : __ __ __ BYT 20 2a 20 2a 2a 2a 2a 2a 20 20 20 2a 20 20 20 2a :  * *****   *   *
2edc : __ __ __ BYT 20 2a 2a 2a 20 2a 2a 2a 2a 2a 20 20 20 20 20 20 :  *** *****      
2eec : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
2efc : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
2f0c : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
2f1c : __ __ __ BYT 2a 20 20 20 2a 20 2a 2a 2a 2a 2a 20 2a 20 20 20 : *   * ***** *   
2f2c : __ __ __ BYT 2a 20 2a 2a 2a 2a 2a 20 20 20 20 20 20 20 20 20 : * *****         
2f3c : __ __ __ BYT 20 20 20 20 20 20 20 20 2a 20 20 20 2a 20 2a 20 :         *   * * 
2f4c : __ __ __ BYT 20 20 2a 20 2a 20 20 20 2a 20 2a 20 20 20 20 20 :   * *   * *     
2f5c : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
2f6c : __ __ __ BYT 2a 20 20 20 2a 20 2a 20 20 20 2a 20 2a 20 20 20 : *   * *   * *   
2f7c : __ __ __ BYT 2a 20 2a 20 20 20 20 20 20 20 20 20 20 20 20 20 : * *             
2f8c : __ __ __ BYT 20 20 20 20 20 20 20 20 2a 20 2a 20 2a 20 2a 2a :         * * * **
2f9c : __ __ __ BYT 2a 2a 2a 20 20 2a 20 2a 20 20 2a 2a 2a 20 20 20 : ***  * *  ***   
2fac : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
2fbc : __ __ __ BYT 2a 20 2a 20 2a 20 2a 20 20 20 2a 20 20 2a 20 2a : * * * *   *  * *
2fcc : __ __ __ BYT 20 20 2a 20 20 20 20 20 20 20 20 20 20 20 20 20 :   *             
2fdc : __ __ __ BYT 20 20 20 20 20 20 20 20 2a 2a 20 2a 2a 20 2a 20 :         ** ** * 
2fec : __ __ __ BYT 20 20 2a 20 20 20 2a 20 20 20 2a 2a 2a 2a 2a 20 :   *   *   ***** 
2ffc : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
300c : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
301c : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
302c : __ __ __ BYT 20 20 20 20 28 03 29 20 0e 0f 0c 14 09 13 0f 06 :     (.) ........
303c : __ __ __ BYT 14 20 32 30 32 33 20 20 20 20 20 20 20 20 20 20 : . 2023          
304c : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
305c : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
306c : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
307c : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
308c : __ __ __ BYT 20 20 20 08 09 07 08 13 03 0f 12 05 3a 20 20 20 :    .........:   
309c : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
30ac : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
30bc : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
30cc : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
30dc : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
30ec : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
30fc : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
310c : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
311c : __ __ __ BYT 20 20 10 12 05 13 13 20 0a 0f 19 13 14 09 0b 20 :   ..... ....... 
312c : __ __ __ BYT 32 20 06 09 12 05 20 02 15 14 14 0f 0e 20 14 0f : 2 .... ...... ..
313c : __ __ __ BYT 20 13 14 01 12 14 20 20 20 20 20 20 20 20 20 20 :  .....          
314c : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
315c : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
316c : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
317c : __ __ __ BYT 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 :                 
318c : __ __ __ BYT 20 20 20 20 20 20 20 20                         :         
--------------------------------------------------------------------
sprintf:
.s1000:
0ba0 : a5 53 __ LDA T0 + 0 
0ba2 : 8d d8 9f STA $9fd8 ; (sprintf@stack + 0)
0ba5 : a5 54 __ LDA T0 + 1 
0ba7 : 8d d9 9f STA $9fd9 ; (sprintf@stack + 1)
.s0:
0baa : a9 00 __ LDA #$00
0bac : 8d ff 9f STA $9fff ; (sstack + 7)
0baf : a0 03 __ LDY #$03
0bb1 : b1 23 __ LDA (SP + 0),y 
0bb3 : 85 54 __ STA T0 + 1 
0bb5 : 8d fa 9f STA $9ffa ; (sstack + 2)
0bb8 : 88 __ __ DEY
0bb9 : b1 23 __ LDA (SP + 0),y 
0bbb : 85 53 __ STA T0 + 0 
0bbd : 8d f9 9f STA $9ff9 ; (sstack + 1)
0bc0 : a0 04 __ LDY #$04
0bc2 : b1 23 __ LDA (SP + 0),y 
0bc4 : 8d fb 9f STA $9ffb ; (sstack + 3)
0bc7 : c8 __ __ INY
0bc8 : b1 23 __ LDA (SP + 0),y 
0bca : 8d fc 9f STA $9ffc ; (sstack + 4)
0bcd : 18 __ __ CLC
0bce : a5 23 __ LDA SP + 0 
0bd0 : 69 06 __ ADC #$06
0bd2 : 8d fd 9f STA $9ffd ; (sstack + 5)
0bd5 : a5 24 __ LDA SP + 1 
0bd7 : 69 00 __ ADC #$00
0bd9 : 8d fe 9f STA $9ffe ; (sstack + 6)
0bdc : 20 f7 0b JSR $0bf7 ; (sformat.s1000 + 0)
0bdf : 38 __ __ SEC
0be0 : a5 1b __ LDA ACCU + 0 
0be2 : e5 53 __ SBC T0 + 0 
0be4 : 85 1b __ STA ACCU + 0 
0be6 : a5 1c __ LDA ACCU + 1 
0be8 : e5 54 __ SBC T0 + 1 
0bea : 85 1c __ STA ACCU + 1 
.s1001:
0bec : ad d8 9f LDA $9fd8 ; (sprintf@stack + 0)
0bef : 85 53 __ STA T0 + 0 
0bf1 : ad d9 9f LDA $9fd9 ; (sprintf@stack + 1)
0bf4 : 85 54 __ STA T0 + 1 
0bf6 : 60 __ __ RTS
--------------------------------------------------------------------
sformat:
.s1000:
0bf7 : a2 05 __ LDX #$05
0bf9 : b5 53 __ LDA T1 + 0,x 
0bfb : 9d da 9f STA $9fda,x ; (sformat@stack + 0)
0bfe : ca __ __ DEX
0bff : 10 f8 __ BPL $0bf9 ; (sformat.s1000 + 2)
.s0:
0c01 : ad fb 9f LDA $9ffb ; (sstack + 3)
0c04 : 85 50 __ STA T0 + 0 
0c06 : ad fc 9f LDA $9ffc ; (sstack + 4)
0c09 : 85 51 __ STA T0 + 1 
0c0b : ad f9 9f LDA $9ff9 ; (sstack + 1)
0c0e : 85 53 __ STA T1 + 0 
0c10 : ad fa 9f LDA $9ffa ; (sstack + 2)
0c13 : 85 54 __ STA T1 + 1 
0c15 : a9 00 __ LDA #$00
.l1057:
0c17 : 85 55 __ STA T2 + 0 
.l1:
0c19 : a0 00 __ LDY #$00
0c1b : b1 50 __ LDA (T0 + 0),y 
0c1d : d0 38 __ BNE $0c57 ; (sformat.s2 + 0)
.s3:
0c1f : a4 55 __ LDY T2 + 0 
0c21 : 91 53 __ STA (T1 + 0),y 
0c23 : 98 __ __ TYA
0c24 : f0 28 __ BEQ $0c4e ; (sformat.s1059 + 0)
.s112:
0c26 : ad ff 9f LDA $9fff ; (sstack + 7)
0c29 : d0 18 __ BNE $0c43 ; (sformat.s115 + 0)
.s116:
0c2b : 18 __ __ CLC
0c2c : a5 53 __ LDA T1 + 0 
0c2e : 65 55 __ ADC T2 + 0 
0c30 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0c32 : a5 54 __ LDA T1 + 1 
0c34 : 69 00 __ ADC #$00
.s1001:
0c36 : 85 1c __ STA ACCU + 1 ; (fmt + 0)
0c38 : a2 05 __ LDX #$05
0c3a : bd da 9f LDA $9fda,x ; (sformat@stack + 0)
0c3d : 95 53 __ STA T1 + 0,x 
0c3f : ca __ __ DEX
0c40 : 10 f8 __ BPL $0c3a ; (sformat.s1001 + 4)
0c42 : 60 __ __ RTS
.s115:
0c43 : a5 53 __ LDA T1 + 0 
0c45 : 85 0d __ STA P0 
0c47 : a5 54 __ LDA T1 + 1 
0c49 : 85 0e __ STA P1 
0c4b : 20 3d 10 JSR $103d ; (puts.s0 + 0)
.s1059:
0c4e : a5 53 __ LDA T1 + 0 
0c50 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0c52 : a5 54 __ LDA T1 + 1 
0c54 : 4c 36 0c JMP $0c36 ; (sformat.s1001 + 0)
.s2:
0c57 : c9 25 __ CMP #$25
0c59 : f0 3f __ BEQ $0c9a ; (sformat.s4 + 0)
.s5:
0c5b : a4 55 __ LDY T2 + 0 
0c5d : 91 53 __ STA (T1 + 0),y 
0c5f : e6 50 __ INC T0 + 0 
0c61 : d0 02 __ BNE $0c65 ; (sformat.s1089 + 0)
.s1088:
0c63 : e6 51 __ INC T0 + 1 
.s1089:
0c65 : c8 __ __ INY
0c66 : 84 55 __ STY T2 + 0 
0c68 : 98 __ __ TYA
0c69 : c0 28 __ CPY #$28
0c6b : 90 ac __ BCC $0c19 ; (sformat.l1 + 0)
.s106:
0c6d : 85 57 __ STA T5 + 0 
0c6f : a9 00 __ LDA #$00
0c71 : 85 55 __ STA T2 + 0 
0c73 : ad ff 9f LDA $9fff ; (sstack + 7)
0c76 : f0 14 __ BEQ $0c8c ; (sformat.s110 + 0)
.s109:
0c78 : a5 53 __ LDA T1 + 0 
0c7a : 85 0d __ STA P0 
0c7c : a5 54 __ LDA T1 + 1 
0c7e : 85 0e __ STA P1 
0c80 : a9 00 __ LDA #$00
0c82 : a4 57 __ LDY T5 + 0 
0c84 : 91 0d __ STA (P0),y 
0c86 : 20 3d 10 JSR $103d ; (puts.s0 + 0)
0c89 : 4c 19 0c JMP $0c19 ; (sformat.l1 + 0)
.s110:
0c8c : 18 __ __ CLC
0c8d : a5 53 __ LDA T1 + 0 
0c8f : 65 57 __ ADC T5 + 0 
0c91 : 85 53 __ STA T1 + 0 
0c93 : 90 84 __ BCC $0c19 ; (sformat.l1 + 0)
.s1090:
0c95 : e6 54 __ INC T1 + 1 
0c97 : 4c 19 0c JMP $0c19 ; (sformat.l1 + 0)
.s4:
0c9a : a5 55 __ LDA T2 + 0 
0c9c : f0 27 __ BEQ $0cc5 ; (sformat.s9 + 0)
.s7:
0c9e : 84 55 __ STY T2 + 0 
0ca0 : 85 57 __ STA T5 + 0 
0ca2 : ad ff 9f LDA $9fff ; (sstack + 7)
0ca5 : f0 13 __ BEQ $0cba ; (sformat.s11 + 0)
.s10:
0ca7 : a5 53 __ LDA T1 + 0 
0ca9 : 85 0d __ STA P0 
0cab : a5 54 __ LDA T1 + 1 
0cad : 85 0e __ STA P1 
0caf : 98 __ __ TYA
0cb0 : a4 57 __ LDY T5 + 0 
0cb2 : 91 0d __ STA (P0),y 
0cb4 : 20 3d 10 JSR $103d ; (puts.s0 + 0)
0cb7 : 4c c5 0c JMP $0cc5 ; (sformat.s9 + 0)
.s11:
0cba : 18 __ __ CLC
0cbb : a5 53 __ LDA T1 + 0 
0cbd : 65 57 __ ADC T5 + 0 
0cbf : 85 53 __ STA T1 + 0 
0cc1 : 90 02 __ BCC $0cc5 ; (sformat.s9 + 0)
.s1086:
0cc3 : e6 54 __ INC T1 + 1 
.s9:
0cc5 : a9 0a __ LDA #$0a
0cc7 : 8d e3 9f STA $9fe3 ; (si + 3)
0cca : a9 00 __ LDA #$00
0ccc : 8d e4 9f STA $9fe4 ; (si + 4)
0ccf : 8d e5 9f STA $9fe5 ; (si + 5)
0cd2 : 8d e6 9f STA $9fe6 ; (si + 6)
0cd5 : 8d e7 9f STA $9fe7 ; (si + 7)
0cd8 : a0 01 __ LDY #$01
0cda : b1 50 __ LDA (T0 + 0),y 
0cdc : aa __ __ TAX
0cdd : a9 20 __ LDA #$20
0cdf : 8d e0 9f STA $9fe0 ; (si + 0)
0ce2 : a9 00 __ LDA #$00
0ce4 : 8d e1 9f STA $9fe1 ; (si + 1)
0ce7 : a9 ff __ LDA #$ff
0ce9 : 8d e2 9f STA $9fe2 ; (si + 2)
0cec : 18 __ __ CLC
0ced : a5 50 __ LDA T0 + 0 
0cef : 69 02 __ ADC #$02
.l14:
0cf1 : 85 50 __ STA T0 + 0 
0cf3 : 90 02 __ BCC $0cf7 ; (sformat.s1071 + 0)
.s1070:
0cf5 : e6 51 __ INC T0 + 1 
.s1071:
0cf7 : 8a __ __ TXA
0cf8 : e0 2b __ CPX #$2b
0cfa : d0 08 __ BNE $0d04 ; (sformat.s17 + 0)
.s16:
0cfc : a9 01 __ LDA #$01
0cfe : 8d e5 9f STA $9fe5 ; (si + 5)
0d01 : 4c 30 10 JMP $1030 ; (sformat.s224 + 0)
.s17:
0d04 : c9 30 __ CMP #$30
0d06 : d0 06 __ BNE $0d0e ; (sformat.s20 + 0)
.s19:
0d08 : 8d e0 9f STA $9fe0 ; (si + 0)
0d0b : 4c 30 10 JMP $1030 ; (sformat.s224 + 0)
.s20:
0d0e : e0 23 __ CPX #$23
0d10 : d0 08 __ BNE $0d1a ; (sformat.s23 + 0)
.s22:
0d12 : a9 01 __ LDA #$01
0d14 : 8d e7 9f STA $9fe7 ; (si + 7)
0d17 : 4c 30 10 JMP $1030 ; (sformat.s224 + 0)
.s23:
0d1a : e0 2d __ CPX #$2d
0d1c : d0 08 __ BNE $0d26 ; (sformat.s15 + 0)
.s25:
0d1e : a9 01 __ LDA #$01
0d20 : 8d e6 9f STA $9fe6 ; (si + 6)
0d23 : 4c 30 10 JMP $1030 ; (sformat.s224 + 0)
.s15:
0d26 : 86 57 __ STX T5 + 0 
0d28 : e0 30 __ CPX #$30
0d2a : 90 53 __ BCC $0d7f ; (sformat.s31 + 0)
.s32:
0d2c : e0 3a __ CPX #$3a
0d2e : b0 4f __ BCS $0d7f ; (sformat.s31 + 0)
.s29:
0d30 : a9 00 __ LDA #$00
0d32 : 85 44 __ STA T6 + 0 
0d34 : 85 45 __ STA T6 + 1 
0d36 : e0 3a __ CPX #$3a
0d38 : b0 40 __ BCS $0d7a ; (sformat.s35 + 0)
.l34:
0d3a : a5 44 __ LDA T6 + 0 
0d3c : 0a __ __ ASL
0d3d : 85 1b __ STA ACCU + 0 ; (buff + 1)
0d3f : a5 45 __ LDA T6 + 1 
0d41 : 2a __ __ ROL
0d42 : 06 1b __ ASL ACCU + 0 ; (buff + 1)
0d44 : 2a __ __ ROL
0d45 : aa __ __ TAX
0d46 : 18 __ __ CLC
0d47 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0d49 : 65 44 __ ADC T6 + 0 
0d4b : 85 44 __ STA T6 + 0 
0d4d : 8a __ __ TXA
0d4e : 65 45 __ ADC T6 + 1 
0d50 : 06 44 __ ASL T6 + 0 
0d52 : 2a __ __ ROL
0d53 : aa __ __ TAX
0d54 : 18 __ __ CLC
0d55 : a5 44 __ LDA T6 + 0 
0d57 : 65 57 __ ADC T5 + 0 
0d59 : 90 01 __ BCC $0d5c ; (sformat.s1083 + 0)
.s1082:
0d5b : e8 __ __ INX
.s1083:
0d5c : 38 __ __ SEC
0d5d : e9 30 __ SBC #$30
0d5f : 85 44 __ STA T6 + 0 
0d61 : 8a __ __ TXA
0d62 : e9 00 __ SBC #$00
0d64 : 85 45 __ STA T6 + 1 
0d66 : a0 00 __ LDY #$00
0d68 : b1 50 __ LDA (T0 + 0),y 
0d6a : 85 57 __ STA T5 + 0 
0d6c : e6 50 __ INC T0 + 0 
0d6e : d0 02 __ BNE $0d72 ; (sformat.s1085 + 0)
.s1084:
0d70 : e6 51 __ INC T0 + 1 
.s1085:
0d72 : c9 30 __ CMP #$30
0d74 : 90 04 __ BCC $0d7a ; (sformat.s35 + 0)
.s36:
0d76 : c9 3a __ CMP #$3a
0d78 : 90 c0 __ BCC $0d3a ; (sformat.l34 + 0)
.s35:
0d7a : a5 44 __ LDA T6 + 0 
0d7c : 8d e1 9f STA $9fe1 ; (si + 1)
.s31:
0d7f : a5 57 __ LDA T5 + 0 
0d81 : c9 2e __ CMP #$2e
0d83 : d0 51 __ BNE $0dd6 ; (sformat.s39 + 0)
.s37:
0d85 : a9 00 __ LDA #$00
0d87 : 85 44 __ STA T6 + 0 
.l203:
0d89 : 85 45 __ STA T6 + 1 
0d8b : a0 00 __ LDY #$00
0d8d : b1 50 __ LDA (T0 + 0),y 
0d8f : 85 57 __ STA T5 + 0 
0d91 : e6 50 __ INC T0 + 0 
0d93 : d0 02 __ BNE $0d97 ; (sformat.s1073 + 0)
.s1072:
0d95 : e6 51 __ INC T0 + 1 
.s1073:
0d97 : c9 30 __ CMP #$30
0d99 : 90 04 __ BCC $0d9f ; (sformat.s42 + 0)
.s43:
0d9b : c9 3a __ CMP #$3a
0d9d : 90 0a __ BCC $0da9 ; (sformat.s41 + 0)
.s42:
0d9f : a5 44 __ LDA T6 + 0 
0da1 : 8d e2 9f STA $9fe2 ; (si + 2)
0da4 : a5 57 __ LDA T5 + 0 
0da6 : 4c d6 0d JMP $0dd6 ; (sformat.s39 + 0)
.s41:
0da9 : a5 44 __ LDA T6 + 0 
0dab : 0a __ __ ASL
0dac : 85 1b __ STA ACCU + 0 ; (buff + 1)
0dae : a5 45 __ LDA T6 + 1 
0db0 : 2a __ __ ROL
0db1 : 06 1b __ ASL ACCU + 0 ; (buff + 1)
0db3 : 2a __ __ ROL
0db4 : aa __ __ TAX
0db5 : 18 __ __ CLC
0db6 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0db8 : 65 44 __ ADC T6 + 0 
0dba : 85 44 __ STA T6 + 0 
0dbc : 8a __ __ TXA
0dbd : 65 45 __ ADC T6 + 1 
0dbf : 06 44 __ ASL T6 + 0 
0dc1 : 2a __ __ ROL
0dc2 : aa __ __ TAX
0dc3 : 18 __ __ CLC
0dc4 : a5 44 __ LDA T6 + 0 
0dc6 : 65 57 __ ADC T5 + 0 
0dc8 : 90 01 __ BCC $0dcb ; (sformat.s1081 + 0)
.s1080:
0dca : e8 __ __ INX
.s1081:
0dcb : 38 __ __ SEC
0dcc : e9 30 __ SBC #$30
0dce : 85 44 __ STA T6 + 0 
0dd0 : 8a __ __ TXA
0dd1 : e9 00 __ SBC #$00
0dd3 : 4c 89 0d JMP $0d89 ; (sformat.l203 + 0)
.s39:
0dd6 : c9 64 __ CMP #$64
0dd8 : d0 05 __ BNE $0ddf ; (sformat.s45 + 0)
.s44:
0dda : a9 01 __ LDA #$01
0ddc : 4c f4 0f JMP $0ff4 ; (sformat.s221 + 0)
.s45:
0ddf : c9 75 __ CMP #$75
0de1 : d0 03 __ BNE $0de6 ; (sformat.s48 + 0)
0de3 : 4c f2 0f JMP $0ff2 ; (sformat.s250 + 0)
.s48:
0de6 : c9 78 __ CMP #$78
0de8 : d0 0d __ BNE $0df7 ; (sformat.s51 + 0)
.s50:
0dea : a9 10 __ LDA #$10
0dec : 8d e3 9f STA $9fe3 ; (si + 3)
0def : a9 00 __ LDA #$00
0df1 : 8d e4 9f STA $9fe4 ; (si + 4)
0df4 : 4c f2 0f JMP $0ff2 ; (sformat.s250 + 0)
.s51:
0df7 : c9 6c __ CMP #$6c
0df9 : d0 03 __ BNE $0dfe ; (sformat.s54 + 0)
0dfb : 4c 76 0f JMP $0f76 ; (sformat.s53 + 0)
.s54:
0dfe : c9 66 __ CMP #$66
0e00 : d0 03 __ BNE $0e05 ; (sformat.s69 + 0)
0e02 : 4c 27 0f JMP $0f27 ; (sformat.s65 + 0)
.s69:
0e05 : c9 67 __ CMP #$67
0e07 : d0 03 __ BNE $0e0c ; (sformat.s68 + 0)
0e09 : 4c 27 0f JMP $0f27 ; (sformat.s65 + 0)
.s68:
0e0c : c9 65 __ CMP #$65
0e0e : d0 03 __ BNE $0e13 ; (sformat.s66 + 0)
0e10 : 4c 27 0f JMP $0f27 ; (sformat.s65 + 0)
.s66:
0e13 : c9 73 __ CMP #$73
0e15 : f0 4c __ BEQ $0e63 ; (sformat.s70 + 0)
.s71:
0e17 : c9 63 __ CMP #$63
0e19 : f0 1f __ BEQ $0e3a ; (sformat.s100 + 0)
.s101:
0e1b : 09 00 __ ORA #$00
0e1d : d0 03 __ BNE $0e22 ; (sformat.s103 + 0)
0e1f : 4c 19 0c JMP $0c19 ; (sformat.l1 + 0)
.s103:
0e22 : 18 __ __ CLC
0e23 : a5 53 __ LDA T1 + 0 
0e25 : 65 55 __ ADC T2 + 0 
0e27 : 85 44 __ STA T6 + 0 
0e29 : a5 54 __ LDA T1 + 1 
0e2b : 69 00 __ ADC #$00
0e2d : 85 45 __ STA T6 + 1 
0e2f : a5 57 __ LDA T5 + 0 
.s1056:
0e31 : a0 00 __ LDY #$00
0e33 : 91 44 __ STA (T6 + 0),y 
0e35 : e6 55 __ INC T2 + 0 
0e37 : 4c 19 0c JMP $0c19 ; (sformat.l1 + 0)
.s100:
0e3a : ad fd 9f LDA $9ffd ; (sstack + 5)
0e3d : 85 57 __ STA T5 + 0 
0e3f : 18 __ __ CLC
0e40 : 69 02 __ ADC #$02
0e42 : 8d fd 9f STA $9ffd ; (sstack + 5)
0e45 : ad fe 9f LDA $9ffe ; (sstack + 6)
0e48 : 85 58 __ STA T5 + 1 
0e4a : 69 00 __ ADC #$00
0e4c : 8d fe 9f STA $9ffe ; (sstack + 6)
0e4f : 18 __ __ CLC
0e50 : a5 53 __ LDA T1 + 0 
0e52 : 65 55 __ ADC T2 + 0 
0e54 : 85 44 __ STA T6 + 0 
0e56 : a5 54 __ LDA T1 + 1 
0e58 : 69 00 __ ADC #$00
0e5a : 85 45 __ STA T6 + 1 
0e5c : a0 00 __ LDY #$00
0e5e : b1 57 __ LDA (T5 + 0),y 
0e60 : 4c 31 0e JMP $0e31 ; (sformat.s1056 + 0)
.s70:
0e63 : ad fd 9f LDA $9ffd ; (sstack + 5)
0e66 : 85 57 __ STA T5 + 0 
0e68 : 18 __ __ CLC
0e69 : 69 02 __ ADC #$02
0e6b : 8d fd 9f STA $9ffd ; (sstack + 5)
0e6e : ad fe 9f LDA $9ffe ; (sstack + 6)
0e71 : 85 58 __ STA T5 + 1 
0e73 : 69 00 __ ADC #$00
0e75 : 8d fe 9f STA $9ffe ; (sstack + 6)
0e78 : a0 00 __ LDY #$00
0e7a : b1 57 __ LDA (T5 + 0),y 
0e7c : aa __ __ TAX
0e7d : c8 __ __ INY
0e7e : b1 57 __ LDA (T5 + 0),y 
0e80 : 86 57 __ STX T5 + 0 
0e82 : 85 58 __ STA T5 + 1 
0e84 : a9 00 __ LDA #$00
0e86 : 85 52 __ STA T3 + 0 
0e88 : ad e1 9f LDA $9fe1 ; (si + 1)
0e8b : f0 0c __ BEQ $0e99 ; (sformat.s75 + 0)
.s1062:
0e8d : 88 __ __ DEY
0e8e : b1 57 __ LDA (T5 + 0),y 
0e90 : f0 05 __ BEQ $0e97 ; (sformat.s1063 + 0)
.l77:
0e92 : c8 __ __ INY
0e93 : b1 57 __ LDA (T5 + 0),y 
0e95 : d0 fb __ BNE $0e92 ; (sformat.l77 + 0)
.s1063:
0e97 : 84 52 __ STY T3 + 0 
.s75:
0e99 : ad e6 9f LDA $9fe6 ; (si + 6)
0e9c : d0 19 __ BNE $0eb7 ; (sformat.s81 + 0)
.s1066:
0e9e : a6 52 __ LDX T3 + 0 
0ea0 : ec e1 9f CPX $9fe1 ; (si + 1)
0ea3 : a4 55 __ LDY T2 + 0 
0ea5 : b0 0c __ BCS $0eb3 ; (sformat.s1067 + 0)
.l83:
0ea7 : ad e0 9f LDA $9fe0 ; (si + 0)
0eaa : 91 53 __ STA (T1 + 0),y 
0eac : e8 __ __ INX
0ead : ec e1 9f CPX $9fe1 ; (si + 1)
0eb0 : c8 __ __ INY
0eb1 : 90 f4 __ BCC $0ea7 ; (sformat.l83 + 0)
.s1067:
0eb3 : 86 52 __ STX T3 + 0 
0eb5 : 84 55 __ STY T2 + 0 
.s81:
0eb7 : ad ff 9f LDA $9fff ; (sstack + 7)
0eba : d0 37 __ BNE $0ef3 ; (sformat.s85 + 0)
.l91:
0ebc : a0 00 __ LDY #$00
0ebe : b1 57 __ LDA (T5 + 0),y 
0ec0 : f0 0f __ BEQ $0ed1 ; (sformat.s211 + 0)
.s92:
0ec2 : a4 55 __ LDY T2 + 0 
0ec4 : 91 53 __ STA (T1 + 0),y 
0ec6 : e6 55 __ INC T2 + 0 
0ec8 : e6 57 __ INC T5 + 0 
0eca : d0 f0 __ BNE $0ebc ; (sformat.l91 + 0)
.s1078:
0ecc : e6 58 __ INC T5 + 1 
0ece : 4c bc 0e JMP $0ebc ; (sformat.l91 + 0)
.s211:
0ed1 : ad e6 9f LDA $9fe6 ; (si + 6)
0ed4 : d0 03 __ BNE $0ed9 ; (sformat.s1064 + 0)
0ed6 : 4c 19 0c JMP $0c19 ; (sformat.l1 + 0)
.s1064:
0ed9 : a6 52 __ LDX T3 + 0 
0edb : ec e1 9f CPX $9fe1 ; (si + 1)
0ede : a4 55 __ LDY T2 + 0 
0ee0 : b0 0c __ BCS $0eee ; (sformat.s1065 + 0)
.l98:
0ee2 : ad e0 9f LDA $9fe0 ; (si + 0)
0ee5 : 91 53 __ STA (T1 + 0),y 
0ee7 : e8 __ __ INX
0ee8 : ec e1 9f CPX $9fe1 ; (si + 1)
0eeb : c8 __ __ INY
0eec : 90 f4 __ BCC $0ee2 ; (sformat.l98 + 0)
.s1065:
0eee : 84 55 __ STY T2 + 0 
0ef0 : 4c 19 0c JMP $0c19 ; (sformat.l1 + 0)
.s85:
0ef3 : a5 55 __ LDA T2 + 0 
0ef5 : f0 22 __ BEQ $0f19 ; (sformat.s90 + 0)
.s88:
0ef7 : a5 53 __ LDA T1 + 0 
0ef9 : 85 0d __ STA P0 
0efb : a5 54 __ LDA T1 + 1 
0efd : 85 0e __ STA P1 
0eff : a9 00 __ LDA #$00
0f01 : a4 55 __ LDY T2 + 0 
0f03 : 91 0d __ STA (P0),y 
0f05 : 20 3d 10 JSR $103d ; (puts.s0 + 0)
0f08 : a5 57 __ LDA T5 + 0 
0f0a : 85 0d __ STA P0 
0f0c : a5 58 __ LDA T5 + 1 
0f0e : 85 0e __ STA P1 
0f10 : 20 3d 10 JSR $103d ; (puts.s0 + 0)
0f13 : a9 00 __ LDA #$00
0f15 : 85 55 __ STA T2 + 0 
0f17 : f0 b8 __ BEQ $0ed1 ; (sformat.s211 + 0)
.s90:
0f19 : a5 57 __ LDA T5 + 0 
0f1b : 85 0d __ STA P0 
0f1d : a5 58 __ LDA T5 + 1 
0f1f : 85 0e __ STA P1 
0f21 : 20 3d 10 JSR $103d ; (puts.s0 + 0)
0f24 : 4c d1 0e JMP $0ed1 ; (sformat.s211 + 0)
.s65:
0f27 : a5 53 __ LDA T1 + 0 
0f29 : 85 13 __ STA P6 
0f2b : a5 54 __ LDA T1 + 1 
0f2d : 85 14 __ STA P7 
0f2f : a5 57 __ LDA T5 + 0 
0f31 : 8d f8 9f STA $9ff8 ; (sstack + 0)
0f34 : a9 e0 __ LDA #$e0
0f36 : 85 11 __ STA P4 
0f38 : a9 9f __ LDA #$9f
0f3a : 85 12 __ STA P5 
0f3c : ad fd 9f LDA $9ffd ; (sstack + 5)
0f3f : 85 55 __ STA T2 + 0 
0f41 : ad fe 9f LDA $9ffe ; (sstack + 6)
0f44 : 85 56 __ STA T2 + 1 
0f46 : a0 00 __ LDY #$00
0f48 : b1 55 __ LDA (T2 + 0),y 
0f4a : 85 15 __ STA P8 
0f4c : c8 __ __ INY
0f4d : b1 55 __ LDA (T2 + 0),y 
0f4f : 85 16 __ STA P9 
0f51 : c8 __ __ INY
0f52 : b1 55 __ LDA (T2 + 0),y 
0f54 : 85 17 __ STA P10 
0f56 : c8 __ __ INY
0f57 : b1 55 __ LDA (T2 + 0),y 
0f59 : 85 18 __ STA P11 
0f5b : 20 89 13 JSR $1389 ; (nformf.s0 + 0)
0f5e : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0f60 : 85 55 __ STA T2 + 0 
0f62 : ad fd 9f LDA $9ffd ; (sstack + 5)
0f65 : 18 __ __ CLC
0f66 : 69 04 __ ADC #$04
0f68 : 8d fd 9f STA $9ffd ; (sstack + 5)
0f6b : b0 03 __ BCS $0f70 ; (sformat.s1076 + 0)
0f6d : 4c 19 0c JMP $0c19 ; (sformat.l1 + 0)
.s1076:
0f70 : ee fe 9f INC $9ffe ; (sstack + 6)
0f73 : 4c 19 0c JMP $0c19 ; (sformat.l1 + 0)
.s53:
0f76 : ad fd 9f LDA $9ffd ; (sstack + 5)
0f79 : 85 57 __ STA T5 + 0 
0f7b : 18 __ __ CLC
0f7c : 69 04 __ ADC #$04
0f7e : 8d fd 9f STA $9ffd ; (sstack + 5)
0f81 : ad fe 9f LDA $9ffe ; (sstack + 6)
0f84 : 85 58 __ STA T5 + 1 
0f86 : 69 00 __ ADC #$00
0f88 : 8d fe 9f STA $9ffe ; (sstack + 6)
0f8b : a0 00 __ LDY #$00
0f8d : b1 57 __ LDA (T5 + 0),y 
0f8f : 85 46 __ STA T7 + 0 
0f91 : c8 __ __ INY
0f92 : b1 57 __ LDA (T5 + 0),y 
0f94 : 85 47 __ STA T7 + 1 
0f96 : c8 __ __ INY
0f97 : b1 57 __ LDA (T5 + 0),y 
0f99 : 85 48 __ STA T7 + 2 
0f9b : c8 __ __ INY
0f9c : b1 57 __ LDA (T5 + 0),y 
0f9e : 85 49 __ STA T7 + 3 
0fa0 : a0 00 __ LDY #$00
0fa2 : b1 50 __ LDA (T0 + 0),y 
0fa4 : aa __ __ TAX
0fa5 : e6 50 __ INC T0 + 0 
0fa7 : d0 02 __ BNE $0fab ; (sformat.s1075 + 0)
.s1074:
0fa9 : e6 51 __ INC T0 + 1 
.s1075:
0fab : 8a __ __ TXA
0fac : e0 64 __ CPX #$64
0fae : d0 04 __ BNE $0fb4 ; (sformat.s57 + 0)
.s56:
0fb0 : a9 01 __ LDA #$01
0fb2 : d0 14 __ BNE $0fc8 ; (sformat.s222 + 0)
.s57:
0fb4 : c9 75 __ CMP #$75
0fb6 : f0 0f __ BEQ $0fc7 ; (sformat.s251 + 0)
.s60:
0fb8 : c9 78 __ CMP #$78
0fba : f0 03 __ BEQ $0fbf ; (sformat.s62 + 0)
0fbc : 4c 19 0c JMP $0c19 ; (sformat.l1 + 0)
.s62:
0fbf : 8c e4 9f STY $9fe4 ; (si + 4)
0fc2 : a9 10 __ LDA #$10
0fc4 : 8d e3 9f STA $9fe3 ; (si + 3)
.s251:
0fc7 : 98 __ __ TYA
.s222:
0fc8 : 85 15 __ STA P8 
0fca : a5 53 __ LDA T1 + 0 
0fcc : 85 0f __ STA P2 
0fce : a5 54 __ LDA T1 + 1 
0fd0 : 85 10 __ STA P3 
0fd2 : a5 46 __ LDA T7 + 0 
0fd4 : 85 11 __ STA P4 
0fd6 : a5 47 __ LDA T7 + 1 
0fd8 : 85 12 __ STA P5 
0fda : a5 48 __ LDA T7 + 2 
0fdc : 85 13 __ STA P6 
0fde : a5 49 __ LDA T7 + 3 
0fe0 : 85 14 __ STA P7 
0fe2 : a9 e0 __ LDA #$e0
0fe4 : 85 0d __ STA P0 
0fe6 : a9 9f __ LDA #$9f
0fe8 : 85 0e __ STA P1 
0fea : 20 f1 11 JSR $11f1 ; (nforml.s0 + 0)
.s1058:
0fed : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0fef : 4c 17 0c JMP $0c17 ; (sformat.l1057 + 0)
.s250:
0ff2 : a9 00 __ LDA #$00
.s221:
0ff4 : 85 13 __ STA P6 
0ff6 : a5 53 __ LDA T1 + 0 
0ff8 : 85 0f __ STA P2 
0ffa : a5 54 __ LDA T1 + 1 
0ffc : 85 10 __ STA P3 
0ffe : ad fd 9f LDA $9ffd ; (sstack + 5)
1001 : 85 55 __ STA T2 + 0 
1003 : ad fe 9f LDA $9ffe ; (sstack + 6)
1006 : 85 56 __ STA T2 + 1 
1008 : a0 00 __ LDY #$00
100a : b1 55 __ LDA (T2 + 0),y 
100c : 85 11 __ STA P4 
100e : c8 __ __ INY
100f : b1 55 __ LDA (T2 + 0),y 
1011 : 85 12 __ STA P5 
1013 : 18 __ __ CLC
1014 : a5 55 __ LDA T2 + 0 
1016 : 69 02 __ ADC #$02
1018 : 8d fd 9f STA $9ffd ; (sstack + 5)
101b : a5 56 __ LDA T2 + 1 
101d : 69 00 __ ADC #$00
101f : 8d fe 9f STA $9ffe ; (sstack + 6)
1022 : a9 e0 __ LDA #$e0
1024 : 85 0d __ STA P0 
1026 : a9 9f __ LDA #$9f
1028 : 85 0e __ STA P1 
102a : 20 92 10 JSR $1092 ; (nformi.s0 + 0)
102d : 4c ed 0f JMP $0fed ; (sformat.s1058 + 0)
.s224:
1030 : a0 00 __ LDY #$00
1032 : b1 50 __ LDA (T0 + 0),y 
1034 : aa __ __ TAX
1035 : 18 __ __ CLC
1036 : a5 50 __ LDA T0 + 0 
1038 : 69 01 __ ADC #$01
103a : 4c f1 0c JMP $0cf1 ; (sformat.l14 + 0)
--------------------------------------------------------------------
puts:
.s0:
103d : a0 00 __ LDY #$00
103f : b1 0d __ LDA (P0),y 
1041 : f0 0b __ BEQ $104e ; (puts.s1001 + 0)
1043 : 20 4f 10 JSR $104f ; (putpch + 0)
1046 : e6 0d __ INC P0 
1048 : d0 f3 __ BNE $103d ; (puts.s0 + 0)
104a : e6 0e __ INC P1 
104c : d0 ef __ BNE $103d ; (puts.s0 + 0)
.s1001:
104e : 60 __ __ RTS
--------------------------------------------------------------------
putpch:
104f : ae 94 31 LDX $3194 ; (giocharmap + 0)
1052 : e0 01 __ CPX #$01
1054 : 90 26 __ BCC $107c ; (putpch + 45)
1056 : c9 0a __ CMP #$0a
1058 : d0 02 __ BNE $105c ; (putpch + 13)
105a : a9 0d __ LDA #$0d
105c : c9 09 __ CMP #$09
105e : f0 1f __ BEQ $107f ; (putpch + 48)
1060 : e0 02 __ CPX #$02
1062 : 90 18 __ BCC $107c ; (putpch + 45)
1064 : c9 41 __ CMP #$41
1066 : 90 14 __ BCC $107c ; (putpch + 45)
1068 : c9 7b __ CMP #$7b
106a : b0 10 __ BCS $107c ; (putpch + 45)
106c : c9 61 __ CMP #$61
106e : b0 04 __ BCS $1074 ; (putpch + 37)
1070 : c9 5b __ CMP #$5b
1072 : b0 08 __ BCS $107c ; (putpch + 45)
1074 : 49 20 __ EOR #$20
1076 : e0 03 __ CPX #$03
1078 : f0 02 __ BEQ $107c ; (putpch + 45)
107a : 29 df __ AND #$df
107c : 4c d2 ff JMP $ffd2 
107f : 38 __ __ SEC
1080 : 20 f0 ff JSR $fff0 
1083 : 98 __ __ TYA
1084 : 29 03 __ AND #$03
1086 : 49 03 __ EOR #$03
1088 : aa __ __ TAX
1089 : a9 20 __ LDA #$20
108b : 20 d2 ff JSR $ffd2 
108e : ca __ __ DEX
108f : 10 fa __ BPL $108b ; (putpch + 60)
1091 : 60 __ __ RTS
--------------------------------------------------------------------
giocharmap:
3194 : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
nformi:
.s0:
1092 : a9 00 __ LDA #$00
1094 : 85 43 __ STA T1 + 0 
1096 : a5 13 __ LDA P6 ; (s + 0)
1098 : f0 15 __ BEQ $10af ; (nformi.s159 + 0)
.s4:
109a : a5 12 __ LDA P5 ; (v + 1)
109c : 10 11 __ BPL $10af ; (nformi.s159 + 0)
.s1:
109e : 38 __ __ SEC
109f : a9 00 __ LDA #$00
10a1 : e5 11 __ SBC P4 ; (v + 0)
10a3 : 85 11 __ STA P4 ; (v + 0)
10a5 : a9 00 __ LDA #$00
10a7 : e5 12 __ SBC P5 ; (v + 1)
10a9 : 85 12 __ STA P5 ; (v + 1)
10ab : a9 01 __ LDA #$01
10ad : 85 43 __ STA T1 + 0 
.s159:
10af : a9 10 __ LDA #$10
10b1 : 85 44 __ STA T2 + 0 
10b3 : a5 11 __ LDA P4 ; (v + 0)
10b5 : 05 12 __ ORA P5 ; (v + 1)
10b7 : f0 61 __ BEQ $111a ; (nformi.s7 + 0)
.s45:
10b9 : a5 0d __ LDA P0 ; (si + 0)
10bb : 85 45 __ STA T4 + 0 
10bd : a5 0e __ LDA P1 ; (si + 1)
10bf : 85 46 __ STA T4 + 1 
.l6:
10c1 : a0 03 __ LDY #$03
10c3 : b1 45 __ LDA (T4 + 0),y 
10c5 : 85 47 __ STA T5 + 0 
10c7 : 85 03 __ STA WORK + 0 
10c9 : c8 __ __ INY
10ca : b1 45 __ LDA (T4 + 0),y 
10cc : 85 48 __ STA T5 + 1 
10ce : 85 04 __ STA WORK + 1 
10d0 : a5 11 __ LDA P4 ; (v + 0)
10d2 : 85 1b __ STA ACCU + 0 
10d4 : a5 12 __ LDA P5 ; (v + 1)
10d6 : 85 1c __ STA ACCU + 1 
10d8 : 20 6c 27 JSR $276c ; (divmod + 0)
10db : a5 06 __ LDA WORK + 3 
10dd : 30 10 __ BMI $10ef ; (nformi.s9 + 0)
.s1019:
10df : d0 06 __ BNE $10e7 ; (nformi.s8 + 0)
.s1018:
10e1 : a5 05 __ LDA WORK + 2 
10e3 : c9 0a __ CMP #$0a
10e5 : 90 08 __ BCC $10ef ; (nformi.s9 + 0)
.s8:
10e7 : 18 __ __ CLC
10e8 : a5 05 __ LDA WORK + 2 
10ea : 69 37 __ ADC #$37
10ec : 4c f4 10 JMP $10f4 ; (nformi.s10 + 0)
.s9:
10ef : 18 __ __ CLC
10f0 : a5 05 __ LDA WORK + 2 
10f2 : 69 30 __ ADC #$30
.s10:
10f4 : c6 44 __ DEC T2 + 0 
10f6 : a6 44 __ LDX T2 + 0 
10f8 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
10fb : a5 11 __ LDA P4 ; (v + 0)
10fd : 85 1b __ STA ACCU + 0 
10ff : a5 12 __ LDA P5 ; (v + 1)
1101 : 85 1c __ STA ACCU + 1 
1103 : a5 47 __ LDA T5 + 0 
1105 : 85 03 __ STA WORK + 0 
1107 : a5 48 __ LDA T5 + 1 
1109 : 85 04 __ STA WORK + 1 
110b : 20 6c 27 JSR $276c ; (divmod + 0)
110e : a5 1b __ LDA ACCU + 0 
1110 : 85 11 __ STA P4 ; (v + 0)
1112 : a5 1c __ LDA ACCU + 1 
1114 : 85 12 __ STA P5 ; (v + 1)
1116 : 05 11 __ ORA P4 ; (v + 0)
1118 : d0 a7 __ BNE $10c1 ; (nformi.l6 + 0)
.s7:
111a : a5 0d __ LDA P0 ; (si + 0)
111c : 85 11 __ STA P4 ; (v + 0)
111e : a5 0e __ LDA P1 ; (si + 1)
1120 : 85 12 __ STA P5 ; (v + 1)
1122 : a0 02 __ LDY #$02
1124 : b1 0d __ LDA (P0),y ; (si + 0)
1126 : c9 ff __ CMP #$ff
1128 : d0 04 __ BNE $112e ; (nformi.s76 + 0)
.s77:
112a : a9 0f __ LDA #$0f
112c : d0 05 __ BNE $1133 ; (nformi.s1026 + 0)
.s76:
112e : 38 __ __ SEC
112f : a9 10 __ LDA #$10
1131 : f1 0d __ SBC (P0),y ; (si + 0)
.s1026:
1133 : a8 __ __ TAY
1134 : c4 44 __ CPY T2 + 0 
1136 : b0 0d __ BCS $1145 ; (nformi.s13 + 0)
.s12:
1138 : a9 30 __ LDA #$30
.l1027:
113a : c6 44 __ DEC T2 + 0 
113c : a6 44 __ LDX T2 + 0 
113e : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1141 : c4 44 __ CPY T2 + 0 
1143 : 90 f5 __ BCC $113a ; (nformi.l1027 + 0)
.s13:
1145 : a0 07 __ LDY #$07
1147 : b1 0d __ LDA (P0),y ; (si + 0)
1149 : f0 20 __ BEQ $116b ; (nformi.s16 + 0)
.s17:
114b : a0 04 __ LDY #$04
114d : b1 0d __ LDA (P0),y ; (si + 0)
114f : d0 1a __ BNE $116b ; (nformi.s16 + 0)
.s1013:
1151 : 88 __ __ DEY
1152 : b1 0d __ LDA (P0),y ; (si + 0)
1154 : c9 10 __ CMP #$10
1156 : d0 13 __ BNE $116b ; (nformi.s16 + 0)
.s14:
1158 : a9 58 __ LDA #$58
115a : a6 44 __ LDX T2 + 0 
115c : 9d e7 9f STA $9fe7,x ; (si + 7)
115f : 8a __ __ TXA
1160 : 18 __ __ CLC
1161 : 69 fe __ ADC #$fe
1163 : 85 44 __ STA T2 + 0 
1165 : aa __ __ TAX
1166 : a9 30 __ LDA #$30
1168 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s16:
116b : a9 00 __ LDA #$00
116d : 85 1b __ STA ACCU + 0 
116f : a5 43 __ LDA T1 + 0 
1171 : f0 06 __ BEQ $1179 ; (nformi.s19 + 0)
.s18:
1173 : c6 44 __ DEC T2 + 0 
1175 : a9 2d __ LDA #$2d
1177 : d0 0a __ BNE $1183 ; (nformi.s1025 + 0)
.s19:
1179 : a0 05 __ LDY #$05
117b : b1 0d __ LDA (P0),y ; (si + 0)
117d : f0 09 __ BEQ $1188 ; (nformi.s141 + 0)
.s21:
117f : c6 44 __ DEC T2 + 0 
1181 : a9 2b __ LDA #$2b
.s1025:
1183 : a6 44 __ LDX T2 + 0 
1185 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s141:
1188 : a0 06 __ LDY #$06
118a : b1 0d __ LDA (P0),y ; (si + 0)
118c : d0 37 __ BNE $11c5 ; (nformi.s27 + 0)
.l33:
118e : a0 01 __ LDY #$01
1190 : b1 11 __ LDA (P4),y ; (v + 0)
1192 : 18 __ __ CLC
1193 : 65 44 __ ADC T2 + 0 
1195 : b0 04 __ BCS $119b ; (nformi.s34 + 0)
.s1006:
1197 : c9 11 __ CMP #$11
1199 : 90 0e __ BCC $11a9 ; (nformi.s36 + 0)
.s34:
119b : c6 44 __ DEC T2 + 0 
119d : a0 00 __ LDY #$00
119f : b1 11 __ LDA (P4),y ; (v + 0)
11a1 : a6 44 __ LDX T2 + 0 
11a3 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
11a6 : 4c 8e 11 JMP $118e ; (nformi.l33 + 0)
.s36:
11a9 : a6 44 __ LDX T2 + 0 
11ab : e0 10 __ CPX #$10
11ad : b0 11 __ BCS $11c0 ; (nformi.s26 + 0)
.s1022:
11af : 88 __ __ DEY
.l1031:
11b0 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
11b3 : 91 0f __ STA (P2),y ; (str + 0)
11b5 : e6 44 __ INC T2 + 0 
11b7 : a6 44 __ LDX T2 + 0 
11b9 : e0 10 __ CPX #$10
11bb : c8 __ __ INY
11bc : 90 f2 __ BCC $11b0 ; (nformi.l1031 + 0)
.s1032:
11be : 84 1b __ STY ACCU + 0 
.s26:
11c0 : a9 00 __ LDA #$00
11c2 : 85 1c __ STA ACCU + 1 
.s1001:
11c4 : 60 __ __ RTS
.s27:
11c5 : a6 44 __ LDX T2 + 0 
11c7 : e0 10 __ CPX #$10
11c9 : b0 12 __ BCS $11dd ; (nformi.l30 + 0)
.s1020:
11cb : a0 00 __ LDY #$00
.l1029:
11cd : bd e8 9f LDA $9fe8,x ; (buffer + 0)
11d0 : 91 0f __ STA (P2),y ; (str + 0)
11d2 : e6 44 __ INC T2 + 0 
11d4 : a6 44 __ LDX T2 + 0 
11d6 : e0 10 __ CPX #$10
11d8 : c8 __ __ INY
11d9 : 90 f2 __ BCC $11cd ; (nformi.l1029 + 0)
.s1030:
11db : 84 1b __ STY ACCU + 0 
.l30:
11dd : a5 1b __ LDA ACCU + 0 
11df : a0 01 __ LDY #$01
11e1 : d1 11 __ CMP (P4),y ; (v + 0)
11e3 : b0 db __ BCS $11c0 ; (nformi.s26 + 0)
.s31:
11e5 : 88 __ __ DEY
11e6 : b1 11 __ LDA (P4),y ; (v + 0)
11e8 : a4 1b __ LDY ACCU + 0 
11ea : 91 0f __ STA (P2),y ; (str + 0)
11ec : e6 1b __ INC ACCU + 0 
11ee : 4c dd 11 JMP $11dd ; (nformi.l30 + 0)
--------------------------------------------------------------------
nforml:
.s0:
11f1 : a9 00 __ LDA #$00
11f3 : 85 43 __ STA T1 + 0 
11f5 : a5 15 __ LDA P8 ; (s + 0)
11f7 : f0 23 __ BEQ $121c ; (nforml.s159 + 0)
.s4:
11f9 : a5 14 __ LDA P7 ; (v + 3)
11fb : f0 1f __ BEQ $121c ; (nforml.s159 + 0)
.s1032:
11fd : 10 1d __ BPL $121c ; (nforml.s159 + 0)
.s1:
11ff : 38 __ __ SEC
1200 : a9 00 __ LDA #$00
1202 : e5 11 __ SBC P4 ; (v + 0)
1204 : 85 11 __ STA P4 ; (v + 0)
1206 : a9 00 __ LDA #$00
1208 : e5 12 __ SBC P5 ; (v + 1)
120a : 85 12 __ STA P5 ; (v + 1)
120c : a9 00 __ LDA #$00
120e : e5 13 __ SBC P6 ; (v + 2)
1210 : 85 13 __ STA P6 ; (v + 2)
1212 : a9 00 __ LDA #$00
1214 : e5 14 __ SBC P7 ; (v + 3)
1216 : 85 14 __ STA P7 ; (v + 3)
1218 : a9 01 __ LDA #$01
121a : 85 43 __ STA T1 + 0 
.s159:
121c : a9 10 __ LDA #$10
121e : 85 44 __ STA T2 + 0 
1220 : a5 14 __ LDA P7 ; (v + 3)
1222 : f0 03 __ BEQ $1227 ; (nforml.s1018 + 0)
1224 : 4c 0b 13 JMP $130b ; (nforml.l6 + 0)
.s1018:
1227 : a5 13 __ LDA P6 ; (v + 2)
1229 : f0 03 __ BEQ $122e ; (nforml.s1019 + 0)
122b : 4c 0b 13 JMP $130b ; (nforml.l6 + 0)
.s1019:
122e : a5 12 __ LDA P5 ; (v + 1)
1230 : f0 03 __ BEQ $1235 ; (nforml.s1020 + 0)
1232 : 4c 0b 13 JMP $130b ; (nforml.l6 + 0)
.s1020:
1235 : c5 11 __ CMP P4 ; (v + 0)
1237 : b0 03 __ BCS $123c ; (nforml.s7 + 0)
1239 : 4c 0b 13 JMP $130b ; (nforml.l6 + 0)
.s7:
123c : a0 02 __ LDY #$02
123e : b1 0d __ LDA (P0),y ; (si + 0)
1240 : c9 ff __ CMP #$ff
1242 : d0 04 __ BNE $1248 ; (nforml.s76 + 0)
.s77:
1244 : a9 0f __ LDA #$0f
1246 : d0 05 __ BNE $124d ; (nforml.s1039 + 0)
.s76:
1248 : 38 __ __ SEC
1249 : a9 10 __ LDA #$10
124b : f1 0d __ SBC (P0),y ; (si + 0)
.s1039:
124d : a8 __ __ TAY
124e : c4 44 __ CPY T2 + 0 
1250 : b0 0d __ BCS $125f ; (nforml.s13 + 0)
.s12:
1252 : a9 30 __ LDA #$30
.l1040:
1254 : c6 44 __ DEC T2 + 0 
1256 : a6 44 __ LDX T2 + 0 
1258 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
125b : c4 44 __ CPY T2 + 0 
125d : 90 f5 __ BCC $1254 ; (nforml.l1040 + 0)
.s13:
125f : a0 07 __ LDY #$07
1261 : b1 0d __ LDA (P0),y ; (si + 0)
1263 : f0 20 __ BEQ $1285 ; (nforml.s16 + 0)
.s17:
1265 : a0 04 __ LDY #$04
1267 : b1 0d __ LDA (P0),y ; (si + 0)
1269 : d0 1a __ BNE $1285 ; (nforml.s16 + 0)
.s1013:
126b : 88 __ __ DEY
126c : b1 0d __ LDA (P0),y ; (si + 0)
126e : c9 10 __ CMP #$10
1270 : d0 13 __ BNE $1285 ; (nforml.s16 + 0)
.s14:
1272 : a9 58 __ LDA #$58
1274 : a6 44 __ LDX T2 + 0 
1276 : 9d e7 9f STA $9fe7,x ; (si + 7)
1279 : 8a __ __ TXA
127a : 18 __ __ CLC
127b : 69 fe __ ADC #$fe
127d : 85 44 __ STA T2 + 0 
127f : aa __ __ TAX
1280 : a9 30 __ LDA #$30
1282 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s16:
1285 : a9 00 __ LDA #$00
1287 : 85 1b __ STA ACCU + 0 
1289 : a5 43 __ LDA T1 + 0 
128b : f0 06 __ BEQ $1293 ; (nforml.s19 + 0)
.s18:
128d : c6 44 __ DEC T2 + 0 
128f : a9 2d __ LDA #$2d
1291 : d0 0a __ BNE $129d ; (nforml.s1038 + 0)
.s19:
1293 : a0 05 __ LDY #$05
1295 : b1 0d __ LDA (P0),y ; (si + 0)
1297 : f0 09 __ BEQ $12a2 ; (nforml.s141 + 0)
.s21:
1299 : c6 44 __ DEC T2 + 0 
129b : a9 2b __ LDA #$2b
.s1038:
129d : a6 44 __ LDX T2 + 0 
129f : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s141:
12a2 : a0 06 __ LDY #$06
12a4 : b1 0d __ LDA (P0),y ; (si + 0)
12a6 : d0 37 __ BNE $12df ; (nforml.s27 + 0)
.l33:
12a8 : a0 01 __ LDY #$01
12aa : b1 0d __ LDA (P0),y ; (si + 0)
12ac : 18 __ __ CLC
12ad : 65 44 __ ADC T2 + 0 
12af : b0 04 __ BCS $12b5 ; (nforml.s34 + 0)
.s1006:
12b1 : c9 11 __ CMP #$11
12b3 : 90 0e __ BCC $12c3 ; (nforml.s36 + 0)
.s34:
12b5 : c6 44 __ DEC T2 + 0 
12b7 : a0 00 __ LDY #$00
12b9 : b1 0d __ LDA (P0),y ; (si + 0)
12bb : a6 44 __ LDX T2 + 0 
12bd : 9d e8 9f STA $9fe8,x ; (buffer + 0)
12c0 : 4c a8 12 JMP $12a8 ; (nforml.l33 + 0)
.s36:
12c3 : a6 44 __ LDX T2 + 0 
12c5 : e0 10 __ CPX #$10
12c7 : b0 11 __ BCS $12da ; (nforml.s26 + 0)
.s1035:
12c9 : 88 __ __ DEY
.l1044:
12ca : bd e8 9f LDA $9fe8,x ; (buffer + 0)
12cd : 91 0f __ STA (P2),y ; (str + 0)
12cf : e6 44 __ INC T2 + 0 
12d1 : a6 44 __ LDX T2 + 0 
12d3 : e0 10 __ CPX #$10
12d5 : c8 __ __ INY
12d6 : 90 f2 __ BCC $12ca ; (nforml.l1044 + 0)
.s1045:
12d8 : 84 1b __ STY ACCU + 0 
.s26:
12da : a9 00 __ LDA #$00
12dc : 85 1c __ STA ACCU + 1 
.s1001:
12de : 60 __ __ RTS
.s27:
12df : a6 44 __ LDX T2 + 0 
12e1 : e0 10 __ CPX #$10
12e3 : b0 12 __ BCS $12f7 ; (nforml.l30 + 0)
.s1033:
12e5 : a0 00 __ LDY #$00
.l1042:
12e7 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
12ea : 91 0f __ STA (P2),y ; (str + 0)
12ec : e6 44 __ INC T2 + 0 
12ee : a6 44 __ LDX T2 + 0 
12f0 : e0 10 __ CPX #$10
12f2 : c8 __ __ INY
12f3 : 90 f2 __ BCC $12e7 ; (nforml.l1042 + 0)
.s1043:
12f5 : 84 1b __ STY ACCU + 0 
.l30:
12f7 : a5 1b __ LDA ACCU + 0 
12f9 : a0 01 __ LDY #$01
12fb : d1 0d __ CMP (P0),y ; (si + 0)
12fd : b0 db __ BCS $12da ; (nforml.s26 + 0)
.s31:
12ff : 88 __ __ DEY
1300 : b1 0d __ LDA (P0),y ; (si + 0)
1302 : a4 1b __ LDY ACCU + 0 
1304 : 91 0f __ STA (P2),y ; (str + 0)
1306 : e6 1b __ INC ACCU + 0 
1308 : 4c f7 12 JMP $12f7 ; (nforml.l30 + 0)
.l6:
130b : a0 03 __ LDY #$03
130d : b1 0d __ LDA (P0),y ; (si + 0)
130f : 85 03 __ STA WORK + 0 
1311 : 85 45 __ STA T6 + 0 
1313 : c8 __ __ INY
1314 : b1 0d __ LDA (P0),y ; (si + 0)
1316 : 85 46 __ STA T6 + 1 
1318 : 85 04 __ STA WORK + 1 
131a : a5 11 __ LDA P4 ; (v + 0)
131c : 85 1b __ STA ACCU + 0 
131e : a5 12 __ LDA P5 ; (v + 1)
1320 : 85 1c __ STA ACCU + 1 
1322 : a5 13 __ LDA P6 ; (v + 2)
1324 : 85 1d __ STA ACCU + 2 
1326 : a5 14 __ LDA P7 ; (v + 3)
1328 : 85 1e __ STA ACCU + 3 
132a : a9 00 __ LDA #$00
132c : 85 05 __ STA WORK + 2 
132e : 85 06 __ STA WORK + 3 
1330 : 20 a7 28 JSR $28a7 ; (divmod32 + 0)
1333 : a5 08 __ LDA WORK + 5 
1335 : 30 10 __ BMI $1347 ; (nforml.s9 + 0)
.s1023:
1337 : d0 06 __ BNE $133f ; (nforml.s8 + 0)
.s1022:
1339 : a5 07 __ LDA WORK + 4 
133b : c9 0a __ CMP #$0a
133d : 90 08 __ BCC $1347 ; (nforml.s9 + 0)
.s8:
133f : 18 __ __ CLC
1340 : a5 07 __ LDA WORK + 4 
1342 : 69 37 __ ADC #$37
1344 : 4c 4c 13 JMP $134c ; (nforml.s10 + 0)
.s9:
1347 : 18 __ __ CLC
1348 : a5 07 __ LDA WORK + 4 
134a : 69 30 __ ADC #$30
.s10:
134c : c6 44 __ DEC T2 + 0 
134e : a6 44 __ LDX T2 + 0 
1350 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1353 : a5 11 __ LDA P4 ; (v + 0)
1355 : 85 1b __ STA ACCU + 0 
1357 : a5 12 __ LDA P5 ; (v + 1)
1359 : 85 1c __ STA ACCU + 1 
135b : a5 13 __ LDA P6 ; (v + 2)
135d : 85 1d __ STA ACCU + 2 
135f : a5 14 __ LDA P7 ; (v + 3)
1361 : 85 1e __ STA ACCU + 3 
1363 : a5 45 __ LDA T6 + 0 
1365 : 85 03 __ STA WORK + 0 
1367 : a5 46 __ LDA T6 + 1 
1369 : 85 04 __ STA WORK + 1 
136b : a9 00 __ LDA #$00
136d : 85 05 __ STA WORK + 2 
136f : 85 06 __ STA WORK + 3 
1371 : 20 a7 28 JSR $28a7 ; (divmod32 + 0)
1374 : a5 1b __ LDA ACCU + 0 
1376 : 85 11 __ STA P4 ; (v + 0)
1378 : a5 1c __ LDA ACCU + 1 
137a : 85 12 __ STA P5 ; (v + 1)
137c : a5 1d __ LDA ACCU + 2 
137e : 85 13 __ STA P6 ; (v + 2)
1380 : a5 1e __ LDA ACCU + 3 
1382 : 85 14 __ STA P7 ; (v + 3)
1384 : d0 85 __ BNE $130b ; (nforml.l6 + 0)
1386 : 4c 27 12 JMP $1227 ; (nforml.s1018 + 0)
--------------------------------------------------------------------
nformf:
.s0:
1389 : a5 15 __ LDA P8 ; (f + 0)
138b : 85 43 __ STA T1 + 0 
138d : a5 16 __ LDA P9 ; (f + 1)
138f : 85 44 __ STA T1 + 1 
1391 : a5 17 __ LDA P10 ; (f + 2)
1393 : 85 45 __ STA T1 + 2 
1395 : a5 18 __ LDA P11 ; (f + 3)
1397 : 29 7f __ AND #$7f
1399 : 05 17 __ ORA P10 ; (f + 2)
139b : 05 16 __ ORA P9 ; (f + 1)
139d : 05 15 __ ORA P8 ; (f + 0)
139f : f0 21 __ BEQ $13c2 ; (nformf.s2 + 0)
.s1075:
13a1 : a5 18 __ LDA P11 ; (f + 3)
13a3 : 10 1d __ BPL $13c2 ; (nformf.s2 + 0)
.s1:
13a5 : a9 2d __ LDA #$2d
13a7 : a0 00 __ LDY #$00
13a9 : 91 13 __ STA (P6),y ; (str + 0)
13ab : a5 18 __ LDA P11 ; (f + 3)
13ad : 49 80 __ EOR #$80
13af : 85 18 __ STA P11 ; (f + 3)
13b1 : 85 10 __ STA P3 
13b3 : a5 15 __ LDA P8 ; (f + 0)
13b5 : 85 0d __ STA P0 
13b7 : a5 16 __ LDA P9 ; (f + 1)
13b9 : 85 0e __ STA P1 
13bb : a5 17 __ LDA P10 ; (f + 2)
13bd : 85 0f __ STA P2 
13bf : 4c 42 18 JMP $1842 ; (nformf.s189 + 0)
.s2:
13c2 : a5 15 __ LDA P8 ; (f + 0)
13c4 : 85 0d __ STA P0 
13c6 : a5 16 __ LDA P9 ; (f + 1)
13c8 : 85 0e __ STA P1 
13ca : a5 17 __ LDA P10 ; (f + 2)
13cc : 85 0f __ STA P2 
13ce : a5 18 __ LDA P11 ; (f + 3)
13d0 : 85 10 __ STA P3 
13d2 : a0 05 __ LDY #$05
13d4 : b1 11 __ LDA (P4),y ; (si + 0)
13d6 : f0 09 __ BEQ $13e1 ; (nformf.s3 + 0)
.s4:
13d8 : a9 2b __ LDA #$2b
13da : a0 00 __ LDY #$00
13dc : 91 13 __ STA (P6),y ; (str + 0)
13de : 4c 42 18 JMP $1842 ; (nformf.s189 + 0)
.s3:
13e1 : 20 5a 18 JSR $185a ; (isinf.s0 + 0)
13e4 : aa __ __ TAX
13e5 : a9 00 __ LDA #$00
13e7 : 85 48 __ STA T3 + 0 
13e9 : 8a __ __ TXA
13ea : f0 0b __ BEQ $13f7 ; (nformf.s8 + 0)
.s160:
13ec : a9 01 __ LDA #$01
13ee : 85 4a __ STA T5 + 0 
13f0 : a9 02 __ LDA #$02
13f2 : a0 00 __ LDY #$00
13f4 : 4c 26 18 JMP $1826 ; (nformf.s7 + 0)
.s8:
13f7 : a0 02 __ LDY #$02
13f9 : b1 11 __ LDA (P4),y ; (si + 0)
13fb : c9 ff __ CMP #$ff
13fd : d0 02 __ BNE $1401 ; (nformf.s128 + 0)
.s129:
13ff : a9 06 __ LDA #$06
.s128:
1401 : 86 4a __ STX T5 + 0 
1403 : 86 4b __ STX T5 + 1 
1405 : 85 49 __ STA T4 + 0 
1407 : 85 47 __ STA T2 + 0 
1409 : a5 18 __ LDA P11 ; (f + 3)
140b : 85 46 __ STA T1 + 3 
140d : 29 7f __ AND #$7f
140f : 05 17 __ ORA P10 ; (f + 2)
1411 : 05 16 __ ORA P9 ; (f + 1)
1413 : 05 15 __ ORA P8 ; (f + 0)
1415 : f0 03 __ BEQ $141a ; (nformf.s12 + 0)
1417 : 4c 27 17 JMP $1727 ; (nformf.s13 + 0)
.s12:
141a : ad f8 9f LDA $9ff8 ; (sstack + 0)
141d : c9 65 __ CMP #$65
141f : d0 04 __ BNE $1425 ; (nformf.s1003 + 0)
.s1002:
1421 : a9 01 __ LDA #$01
1423 : d0 02 __ BNE $1427 ; (nformf.s1004 + 0)
.s1003:
1425 : a9 00 __ LDA #$00
.s1004:
1427 : 85 4e __ STA T9 + 0 
1429 : a6 49 __ LDX T4 + 0 
142b : e8 __ __ INX
142c : 86 4c __ STX T8 + 0 
142e : ad f8 9f LDA $9ff8 ; (sstack + 0)
1431 : c9 67 __ CMP #$67
1433 : d0 13 __ BNE $1448 ; (nformf.s24 + 0)
.s22:
1435 : a5 4b __ LDA T5 + 1 
1437 : 30 08 __ BMI $1441 ; (nformf.s25 + 0)
.s1046:
1439 : d0 06 __ BNE $1441 ; (nformf.s25 + 0)
.s1045:
143b : a5 4a __ LDA T5 + 0 
143d : c9 04 __ CMP #$04
143f : 90 07 __ BCC $1448 ; (nformf.s24 + 0)
.s25:
1441 : a9 01 __ LDA #$01
1443 : 85 4e __ STA T9 + 0 
1445 : 4c 9f 16 JMP $169f ; (nformf.s30 + 0)
.s24:
1448 : a5 4e __ LDA T9 + 0 
144a : f0 03 __ BEQ $144f ; (nformf.s32 + 0)
144c : 4c 9f 16 JMP $169f ; (nformf.s30 + 0)
.s32:
144f : a5 4b __ LDA T5 + 1 
1451 : 10 3e __ BPL $1491 ; (nformf.s34 + 0)
.s33:
1453 : a5 43 __ LDA T1 + 0 
1455 : 85 1b __ STA ACCU + 0 
1457 : a5 44 __ LDA T1 + 1 
1459 : 85 1c __ STA ACCU + 1 
145b : a5 45 __ LDA T1 + 2 
145d : 85 1d __ STA ACCU + 2 
145f : a5 46 __ LDA T1 + 3 
1461 : 85 1e __ STA ACCU + 3 
.l1082:
1463 : e6 4a __ INC T5 + 0 
1465 : d0 02 __ BNE $1469 ; (nformf.s1092 + 0)
.s1091:
1467 : e6 4b __ INC T5 + 1 
.s1092:
1469 : a9 00 __ LDA #$00
146b : 85 03 __ STA WORK + 0 
146d : 85 04 __ STA WORK + 1 
146f : a9 20 __ LDA #$20
1471 : 85 05 __ STA WORK + 2 
1473 : a9 41 __ LDA #$41
1475 : 85 06 __ STA WORK + 3 
1477 : 20 9d 24 JSR $249d ; (freg + 20)
147a : 20 84 26 JSR $2684 ; (fdiv + 0)
147d : a5 4b __ LDA T5 + 1 
147f : 30 e2 __ BMI $1463 ; (nformf.l1082 + 0)
.s1083:
1481 : a5 1e __ LDA ACCU + 3 
1483 : 85 46 __ STA T1 + 3 
1485 : a5 1d __ LDA ACCU + 2 
1487 : 85 45 __ STA T1 + 2 
1489 : a5 1c __ LDA ACCU + 1 
148b : 85 44 __ STA T1 + 1 
148d : a5 1b __ LDA ACCU + 0 
148f : 85 43 __ STA T1 + 0 
.s34:
1491 : 18 __ __ CLC
1492 : a5 49 __ LDA T4 + 0 
1494 : 65 4a __ ADC T5 + 0 
1496 : 18 __ __ CLC
1497 : 69 01 __ ADC #$01
1499 : 85 4c __ STA T8 + 0 
149b : c9 07 __ CMP #$07
149d : 90 13 __ BCC $14b2 ; (nformf.s35 + 0)
.s36:
149f : ad ae 31 LDA $31ae ; (fround5 + 25)
14a2 : 85 1c __ STA ACCU + 1 
14a4 : ad af 31 LDA $31af ; (fround5 + 26)
14a7 : 85 1d __ STA ACCU + 2 
14a9 : ad b0 31 LDA $31b0 ; (fround5 + 27)
14ac : ae ad 31 LDX $31ad ; (fround5 + 24)
14af : 4c c5 14 JMP $14c5 ; (nformf.s214 + 0)
.s35:
14b2 : 0a __ __ ASL
14b3 : 0a __ __ ASL
14b4 : a8 __ __ TAY
14b5 : b9 92 31 LDA $3192,y ; (IntroScreen + 998)
14b8 : 85 1c __ STA ACCU + 1 
14ba : b9 93 31 LDA $3193,y ; (IntroScreen + 999)
14bd : 85 1d __ STA ACCU + 2 
14bf : b9 94 31 LDA $3194,y ; (giocharmap + 0)
14c2 : be 91 31 LDX $3191,y ; (IntroScreen + 997)
.s214:
14c5 : 86 1b __ STX ACCU + 0 
14c7 : 85 1e __ STA ACCU + 3 
14c9 : a2 43 __ LDX #$43
14cb : 20 8d 24 JSR $248d ; (freg + 4)
14ce : 20 ce 24 JSR $24ce ; (faddsub + 0)
14d1 : a5 1c __ LDA ACCU + 1 
14d3 : 85 16 __ STA P9 ; (f + 1)
14d5 : a5 1d __ LDA ACCU + 2 
14d7 : 85 17 __ STA P10 ; (f + 2)
14d9 : a6 1b __ LDX ACCU + 0 
14db : a5 1e __ LDA ACCU + 3 
14dd : 85 18 __ STA P11 ; (f + 3)
14df : 30 35 __ BMI $1516 ; (nformf.s31 + 0)
.s1028:
14e1 : c9 41 __ CMP #$41
14e3 : d0 06 __ BNE $14eb ; (nformf.s1032 + 0)
.s1029:
14e5 : a5 17 __ LDA P10 ; (f + 2)
14e7 : c9 20 __ CMP #$20
14e9 : f0 02 __ BEQ $14ed ; (nformf.s38 + 0)
.s1032:
14eb : 90 29 __ BCC $1516 ; (nformf.s31 + 0)
.s38:
14ed : a9 00 __ LDA #$00
14ef : 85 03 __ STA WORK + 0 
14f1 : 85 04 __ STA WORK + 1 
14f3 : a9 20 __ LDA #$20
14f5 : 85 05 __ STA WORK + 2 
14f7 : a9 41 __ LDA #$41
14f9 : 85 06 __ STA WORK + 3 
14fb : 20 9d 24 JSR $249d ; (freg + 20)
14fe : 20 84 26 JSR $2684 ; (fdiv + 0)
1501 : a5 1c __ LDA ACCU + 1 
1503 : 85 16 __ STA P9 ; (f + 1)
1505 : a5 1d __ LDA ACCU + 2 
1507 : 85 17 __ STA P10 ; (f + 2)
1509 : a5 1e __ LDA ACCU + 3 
150b : 85 18 __ STA P11 ; (f + 3)
150d : 18 __ __ CLC
150e : a5 49 __ LDA T4 + 0 
1510 : 69 ff __ ADC #$ff
1512 : 85 47 __ STA T2 + 0 
1514 : a6 1b __ LDX ACCU + 0 
.s31:
1516 : 38 __ __ SEC
1517 : a5 4c __ LDA T8 + 0 
1519 : e5 47 __ SBC T2 + 0 
151b : 85 49 __ STA T4 + 0 
151d : a9 14 __ LDA #$14
151f : c5 4c __ CMP T8 + 0 
1521 : b0 02 __ BCS $1525 ; (nformf.s49 + 0)
.s47:
1523 : 85 4c __ STA T8 + 0 
.s49:
1525 : a5 49 __ LDA T4 + 0 
1527 : d0 08 __ BNE $1531 ; (nformf.s219 + 0)
.s50:
1529 : a9 30 __ LDA #$30
152b : a4 48 __ LDY T3 + 0 
152d : 91 13 __ STA (P6),y ; (str + 0)
152f : e6 48 __ INC T3 + 0 
.s219:
1531 : a9 00 __ LDA #$00
1533 : 85 47 __ STA T2 + 0 
1535 : c5 49 __ CMP T4 + 0 
1537 : d0 08 __ BNE $1541 ; (nformf.l59 + 0)
.l57:
1539 : a9 2e __ LDA #$2e
153b : a4 48 __ LDY T3 + 0 
153d : 91 13 __ STA (P6),y ; (str + 0)
153f : e6 48 __ INC T3 + 0 
.l59:
1541 : a5 47 __ LDA T2 + 0 
1543 : c9 07 __ CMP #$07
1545 : 90 04 __ BCC $154b ; (nformf.s61 + 0)
.s60:
1547 : a9 30 __ LDA #$30
1549 : d0 55 __ BNE $15a0 ; (nformf.s208 + 0)
.s61:
154b : 86 1b __ STX ACCU + 0 
154d : 86 43 __ STX T1 + 0 
154f : a5 16 __ LDA P9 ; (f + 1)
1551 : 85 1c __ STA ACCU + 1 
1553 : 85 44 __ STA T1 + 1 
1555 : a5 17 __ LDA P10 ; (f + 2)
1557 : 85 1d __ STA ACCU + 2 
1559 : 85 45 __ STA T1 + 2 
155b : a5 18 __ LDA P11 ; (f + 3)
155d : 85 1e __ STA ACCU + 3 
155f : 85 46 __ STA T1 + 3 
1561 : 20 1a 28 JSR $281a ; (f32_to_i16 + 0)
1564 : a5 1b __ LDA ACCU + 0 
1566 : 85 4f __ STA T11 + 0 
1568 : 20 5c 28 JSR $285c ; (sint16_to_float + 0)
156b : a2 43 __ LDX #$43
156d : 20 8d 24 JSR $248d ; (freg + 4)
1570 : a5 1e __ LDA ACCU + 3 
1572 : 49 80 __ EOR #$80
1574 : 85 1e __ STA ACCU + 3 
1576 : 20 ce 24 JSR $24ce ; (faddsub + 0)
1579 : a9 00 __ LDA #$00
157b : 85 03 __ STA WORK + 0 
157d : 85 04 __ STA WORK + 1 
157f : a9 20 __ LDA #$20
1581 : 85 05 __ STA WORK + 2 
1583 : a9 41 __ LDA #$41
1585 : 85 06 __ STA WORK + 3 
1587 : 20 9d 24 JSR $249d ; (freg + 20)
158a : 20 b5 25 JSR $25b5 ; (fmul + 0)
158d : a5 1c __ LDA ACCU + 1 
158f : 85 16 __ STA P9 ; (f + 1)
1591 : a5 1d __ LDA ACCU + 2 
1593 : 85 17 __ STA P10 ; (f + 2)
1595 : a5 1e __ LDA ACCU + 3 
1597 : 85 18 __ STA P11 ; (f + 3)
1599 : 18 __ __ CLC
159a : a5 4f __ LDA T11 + 0 
159c : 69 30 __ ADC #$30
159e : a6 1b __ LDX ACCU + 0 
.s208:
15a0 : a4 48 __ LDY T3 + 0 
15a2 : 91 13 __ STA (P6),y ; (str + 0)
15a4 : e6 48 __ INC T3 + 0 
15a6 : e6 47 __ INC T2 + 0 
15a8 : a5 47 __ LDA T2 + 0 
15aa : c5 4c __ CMP T8 + 0 
15ac : b0 07 __ BCS $15b5 ; (nformf.s56 + 0)
.s54:
15ae : c5 49 __ CMP T4 + 0 
15b0 : d0 8f __ BNE $1541 ; (nformf.l59 + 0)
15b2 : 4c 39 15 JMP $1539 ; (nformf.l57 + 0)
.s56:
15b5 : a5 4e __ LDA T9 + 0 
15b7 : f0 62 __ BEQ $161b ; (nformf.s9 + 0)
.s63:
15b9 : a9 45 __ LDA #$45
15bb : a4 48 __ LDY T3 + 0 
15bd : 91 13 __ STA (P6),y ; (str + 0)
15bf : c8 __ __ INY
15c0 : a5 4b __ LDA T5 + 1 
15c2 : 30 06 __ BMI $15ca ; (nformf.s66 + 0)
.s67:
15c4 : a9 2b __ LDA #$2b
15c6 : 91 13 __ STA (P6),y ; (str + 0)
15c8 : d0 11 __ BNE $15db ; (nformf.s68 + 0)
.s66:
15ca : a9 2d __ LDA #$2d
15cc : 91 13 __ STA (P6),y ; (str + 0)
15ce : 38 __ __ SEC
15cf : a9 00 __ LDA #$00
15d1 : e5 4a __ SBC T5 + 0 
15d3 : 85 4a __ STA T5 + 0 
15d5 : a9 00 __ LDA #$00
15d7 : e5 4b __ SBC T5 + 1 
15d9 : 85 4b __ STA T5 + 1 
.s68:
15db : a5 4a __ LDA T5 + 0 
15dd : 85 1b __ STA ACCU + 0 
15df : a5 4b __ LDA T5 + 1 
15e1 : 85 1c __ STA ACCU + 1 
15e3 : a9 0a __ LDA #$0a
15e5 : 85 03 __ STA WORK + 0 
15e7 : a9 00 __ LDA #$00
15e9 : 85 04 __ STA WORK + 1 
15eb : 20 32 27 JSR $2732 ; (divs16 + 0)
15ee : 18 __ __ CLC
15ef : a5 1b __ LDA ACCU + 0 
15f1 : 69 30 __ ADC #$30
15f3 : a4 48 __ LDY T3 + 0 
15f5 : c8 __ __ INY
15f6 : c8 __ __ INY
15f7 : 91 13 __ STA (P6),y ; (str + 0)
15f9 : a5 4a __ LDA T5 + 0 
15fb : 85 1b __ STA ACCU + 0 
15fd : a5 4b __ LDA T5 + 1 
15ff : 85 1c __ STA ACCU + 1 
1601 : a9 0a __ LDA #$0a
1603 : 85 03 __ STA WORK + 0 
1605 : a9 00 __ LDA #$00
1607 : 85 04 __ STA WORK + 1 
1609 : 20 f1 27 JSR $27f1 ; (mods16 + 0)
160c : 18 __ __ CLC
160d : a5 05 __ LDA WORK + 2 
160f : 69 30 __ ADC #$30
1611 : a4 48 __ LDY T3 + 0 
1613 : c8 __ __ INY
1614 : c8 __ __ INY
1615 : c8 __ __ INY
1616 : 91 13 __ STA (P6),y ; (str + 0)
1618 : c8 __ __ INY
1619 : 84 48 __ STY T3 + 0 
.s9:
161b : a5 11 __ LDA P4 ; (si + 0)
161d : 85 4a __ STA T5 + 0 
161f : a5 12 __ LDA P5 ; (si + 1)
1621 : 85 4b __ STA T5 + 1 
1623 : a5 48 __ LDA T3 + 0 
1625 : a0 01 __ LDY #$01
1627 : d1 11 __ CMP (P4),y ; (si + 0)
1629 : b0 5d __ BCS $1688 ; (nformf.s1001 + 0)
.s69:
162b : a0 06 __ LDY #$06
162d : b1 11 __ LDA (P4),y ; (si + 0)
162f : f0 06 __ BEQ $1637 ; (nformf.s73 + 0)
.s72:
1631 : a5 48 __ LDA T3 + 0 
1633 : aa __ __ TAX
1634 : 4c 8f 16 JMP $168f ; (nformf.l75 + 0)
.s73:
1637 : a5 48 __ LDA T3 + 0 
1639 : f0 2d __ BEQ $1668 ; (nformf.s82 + 0)
.s90:
163b : a9 01 __ LDA #$01
163d : 85 47 __ STA T2 + 0 
163f : a6 48 __ LDX T3 + 0 
1641 : 38 __ __ SEC
.l1080:
1642 : a0 01 __ LDY #$01
1644 : b1 11 __ LDA (P4),y ; (si + 0)
1646 : e5 47 __ SBC T2 + 0 
1648 : 85 4c __ STA T8 + 0 
164a : a9 ff __ LDA #$ff
164c : 65 14 __ ADC P7 ; (str + 1)
164e : 85 4d __ STA T8 + 1 
1650 : 8a __ __ TXA
1651 : 38 __ __ SEC
1652 : e5 47 __ SBC T2 + 0 
1654 : 85 1b __ STA ACCU + 0 
1656 : a9 ff __ LDA #$ff
1658 : 65 14 __ ADC P7 ; (str + 1)
165a : 85 1c __ STA ACCU + 1 
165c : a4 13 __ LDY P6 ; (str + 0)
165e : b1 1b __ LDA (ACCU + 0),y 
1660 : 91 4c __ STA (T8 + 0),y 
1662 : e6 47 __ INC T2 + 0 
1664 : e4 47 __ CPX T2 + 0 
1666 : b0 da __ BCS $1642 ; (nformf.l1080 + 0)
.s82:
1668 : a9 00 __ LDA #$00
166a : 85 47 __ STA T2 + 0 
.l83:
166c : a0 01 __ LDY #$01
166e : b1 4a __ LDA (T5 + 0),y 
1670 : 38 __ __ SEC
1671 : e5 48 __ SBC T3 + 0 
1673 : 90 06 __ BCC $167b ; (nformf.s84 + 0)
.s1007:
1675 : c5 47 __ CMP T2 + 0 
1677 : 90 0d __ BCC $1686 ; (nformf.s74 + 0)
.s1084:
1679 : f0 0b __ BEQ $1686 ; (nformf.s74 + 0)
.s84:
167b : a9 20 __ LDA #$20
167d : a4 47 __ LDY T2 + 0 
167f : 91 13 __ STA (P6),y ; (str + 0)
1681 : e6 47 __ INC T2 + 0 
1683 : 4c 6c 16 JMP $166c ; (nformf.l83 + 0)
.s74:
1686 : b1 11 __ LDA (P4),y ; (si + 0)
.s1001:
1688 : 85 1b __ STA ACCU + 0 
168a : a9 00 __ LDA #$00
168c : 85 1c __ STA ACCU + 1 
168e : 60 __ __ RTS
.l75:
168f : a0 01 __ LDY #$01
1691 : d1 4a __ CMP (T5 + 0),y 
1693 : b0 f1 __ BCS $1686 ; (nformf.s74 + 0)
.s76:
1695 : a8 __ __ TAY
1696 : a9 20 __ LDA #$20
1698 : 91 13 __ STA (P6),y ; (str + 0)
169a : e8 __ __ INX
169b : 8a __ __ TXA
169c : 4c 8f 16 JMP $168f ; (nformf.l75 + 0)
.s30:
169f : a5 4c __ LDA T8 + 0 
16a1 : c9 07 __ CMP #$07
16a3 : 90 13 __ BCC $16b8 ; (nformf.s41 + 0)
.s42:
16a5 : ad ae 31 LDA $31ae ; (fround5 + 25)
16a8 : 85 1c __ STA ACCU + 1 
16aa : ad af 31 LDA $31af ; (fround5 + 26)
16ad : 85 1d __ STA ACCU + 2 
16af : ad b0 31 LDA $31b0 ; (fround5 + 27)
16b2 : ae ad 31 LDX $31ad ; (fround5 + 24)
16b5 : 4c cb 16 JMP $16cb ; (nformf.s204 + 0)
.s41:
16b8 : 0a __ __ ASL
16b9 : 0a __ __ ASL
16ba : a8 __ __ TAY
16bb : b9 92 31 LDA $3192,y ; (IntroScreen + 998)
16be : 85 1c __ STA ACCU + 1 
16c0 : b9 93 31 LDA $3193,y ; (IntroScreen + 999)
16c3 : 85 1d __ STA ACCU + 2 
16c5 : b9 94 31 LDA $3194,y ; (giocharmap + 0)
16c8 : be 91 31 LDX $3191,y ; (IntroScreen + 997)
.s204:
16cb : 86 1b __ STX ACCU + 0 
16cd : 85 1e __ STA ACCU + 3 
16cf : a2 43 __ LDX #$43
16d1 : 20 8d 24 JSR $248d ; (freg + 4)
16d4 : 20 ce 24 JSR $24ce ; (faddsub + 0)
16d7 : a5 1c __ LDA ACCU + 1 
16d9 : 85 16 __ STA P9 ; (f + 1)
16db : a5 1d __ LDA ACCU + 2 
16dd : 85 17 __ STA P10 ; (f + 2)
16df : a6 1b __ LDX ACCU + 0 
16e1 : a5 1e __ LDA ACCU + 3 
16e3 : 85 18 __ STA P11 ; (f + 3)
16e5 : 10 03 __ BPL $16ea ; (nformf.s1038 + 0)
16e7 : 4c 16 15 JMP $1516 ; (nformf.s31 + 0)
.s1038:
16ea : c9 41 __ CMP #$41
16ec : d0 06 __ BNE $16f4 ; (nformf.s1042 + 0)
.s1039:
16ee : a5 17 __ LDA P10 ; (f + 2)
16f0 : c9 20 __ CMP #$20
16f2 : f0 05 __ BEQ $16f9 ; (nformf.s44 + 0)
.s1042:
16f4 : b0 03 __ BCS $16f9 ; (nformf.s44 + 0)
16f6 : 4c 16 15 JMP $1516 ; (nformf.s31 + 0)
.s44:
16f9 : a9 00 __ LDA #$00
16fb : 85 03 __ STA WORK + 0 
16fd : 85 04 __ STA WORK + 1 
16ff : a9 20 __ LDA #$20
1701 : 85 05 __ STA WORK + 2 
1703 : a9 41 __ LDA #$41
1705 : 85 06 __ STA WORK + 3 
1707 : 20 9d 24 JSR $249d ; (freg + 20)
170a : 20 84 26 JSR $2684 ; (fdiv + 0)
170d : a5 1c __ LDA ACCU + 1 
170f : 85 16 __ STA P9 ; (f + 1)
1711 : a5 1d __ LDA ACCU + 2 
1713 : 85 17 __ STA P10 ; (f + 2)
1715 : a5 1e __ LDA ACCU + 3 
1717 : 85 18 __ STA P11 ; (f + 3)
1719 : a6 1b __ LDX ACCU + 0 
171b : e6 4a __ INC T5 + 0 
171d : f0 03 __ BEQ $1722 ; (nformf.s1089 + 0)
171f : 4c 16 15 JMP $1516 ; (nformf.s31 + 0)
.s1089:
1722 : e6 4b __ INC T5 + 1 
1724 : 4c 16 15 JMP $1516 ; (nformf.s31 + 0)
.s13:
1727 : a5 18 __ LDA P11 ; (f + 3)
1729 : 30 59 __ BMI $1784 ; (nformf.l17 + 0)
.l1068:
172b : c9 44 __ CMP #$44
172d : f0 03 __ BEQ $1732 ; (nformf.s1069 + 0)
172f : 4c 21 18 JMP $1821 ; (nformf.s1072 + 0)
.s1069:
1732 : a5 45 __ LDA T1 + 2 
1734 : c9 7a __ CMP #$7a
1736 : f0 03 __ BEQ $173b ; (nformf.s1070 + 0)
1738 : 4c 21 18 JMP $1821 ; (nformf.s1072 + 0)
.s1070:
173b : a5 44 __ LDA T1 + 1 
173d : d0 04 __ BNE $1743 ; (nformf.s1079 + 0)
.s1071:
173f : a5 43 __ LDA T1 + 0 
1741 : f0 02 __ BEQ $1745 ; (nformf.s14 + 0)
.s1079:
1743 : a5 43 __ LDA T1 + 0 
.s14:
1745 : 85 1b __ STA ACCU + 0 
1747 : a5 44 __ LDA T1 + 1 
1749 : 85 1c __ STA ACCU + 1 
174b : a5 45 __ LDA T1 + 2 
174d : 85 1d __ STA ACCU + 2 
174f : a5 46 __ LDA T1 + 3 
1751 : 85 1e __ STA ACCU + 3 
1753 : a9 00 __ LDA #$00
1755 : 85 03 __ STA WORK + 0 
1757 : 85 04 __ STA WORK + 1 
1759 : a9 7a __ LDA #$7a
175b : 85 05 __ STA WORK + 2 
175d : a9 44 __ LDA #$44
175f : 85 06 __ STA WORK + 3 
1761 : 20 9d 24 JSR $249d ; (freg + 20)
1764 : 20 84 26 JSR $2684 ; (fdiv + 0)
1767 : a5 1b __ LDA ACCU + 0 
1769 : 85 43 __ STA T1 + 0 
176b : a5 1c __ LDA ACCU + 1 
176d : 85 44 __ STA T1 + 1 
176f : a5 1d __ LDA ACCU + 2 
1771 : 85 45 __ STA T1 + 2 
1773 : 18 __ __ CLC
1774 : a5 4a __ LDA T5 + 0 
1776 : 69 03 __ ADC #$03
1778 : 85 4a __ STA T5 + 0 
177a : 90 02 __ BCC $177e ; (nformf.s1094 + 0)
.s1093:
177c : e6 4b __ INC T5 + 1 
.s1094:
177e : a5 1e __ LDA ACCU + 3 
1780 : 85 46 __ STA T1 + 3 
1782 : 10 a7 __ BPL $172b ; (nformf.l1068 + 0)
.l17:
1784 : a9 00 __ LDA #$00
1786 : 85 1b __ STA ACCU + 0 
1788 : 85 1c __ STA ACCU + 1 
178a : a9 7a __ LDA #$7a
178c : 85 1d __ STA ACCU + 2 
178e : a9 44 __ LDA #$44
1790 : 85 1e __ STA ACCU + 3 
1792 : a2 43 __ LDX #$43
1794 : 20 8d 24 JSR $248d ; (freg + 4)
1797 : 20 b5 25 JSR $25b5 ; (fmul + 0)
179a : a5 1b __ LDA ACCU + 0 
179c : 85 43 __ STA T1 + 0 
179e : a5 1c __ LDA ACCU + 1 
17a0 : 85 44 __ STA T1 + 1 
17a2 : a5 1d __ LDA ACCU + 2 
17a4 : 85 45 __ STA T1 + 2 
17a6 : a5 1e __ LDA ACCU + 3 
17a8 : 85 46 __ STA T1 + 3 
17aa : 38 __ __ SEC
17ab : a5 4a __ LDA T5 + 0 
17ad : e9 03 __ SBC #$03
17af : 85 4a __ STA T5 + 0 
17b1 : b0 02 __ BCS $17b5 ; (nformf.s16 + 0)
.s1085:
17b3 : c6 4b __ DEC T5 + 1 
.s16:
17b5 : a5 46 __ LDA T1 + 3 
17b7 : 30 cb __ BMI $1784 ; (nformf.l17 + 0)
.s1060:
17b9 : c9 3f __ CMP #$3f
17bb : d0 06 __ BNE $17c3 ; (nformf.s1064 + 0)
.s1061:
17bd : a5 45 __ LDA T1 + 2 
17bf : c9 80 __ CMP #$80
17c1 : f0 02 __ BEQ $17c5 ; (nformf.s19 + 0)
.s1064:
17c3 : 90 bf __ BCC $1784 ; (nformf.l17 + 0)
.s19:
17c5 : a5 46 __ LDA T1 + 3 
17c7 : c9 41 __ CMP #$41
17c9 : d0 51 __ BNE $181c ; (nformf.l1056 + 0)
.s1053:
17cb : a5 45 __ LDA T1 + 2 
17cd : c9 20 __ CMP #$20
17cf : d0 4b __ BNE $181c ; (nformf.l1056 + 0)
.s1054:
17d1 : a5 44 __ LDA T1 + 1 
17d3 : d0 04 __ BNE $17d9 ; (nformf.l1078 + 0)
.s1055:
17d5 : a5 43 __ LDA T1 + 0 
17d7 : f0 02 __ BEQ $17db ; (nformf.l20 + 0)
.l1078:
17d9 : a5 43 __ LDA T1 + 0 
.l20:
17db : 85 1b __ STA ACCU + 0 
17dd : a5 44 __ LDA T1 + 1 
17df : 85 1c __ STA ACCU + 1 
17e1 : a5 45 __ LDA T1 + 2 
17e3 : 85 1d __ STA ACCU + 2 
17e5 : a5 46 __ LDA T1 + 3 
17e7 : 85 1e __ STA ACCU + 3 
17e9 : a9 00 __ LDA #$00
17eb : 85 03 __ STA WORK + 0 
17ed : 85 04 __ STA WORK + 1 
17ef : a9 20 __ LDA #$20
17f1 : 85 05 __ STA WORK + 2 
17f3 : a9 41 __ LDA #$41
17f5 : 85 06 __ STA WORK + 3 
17f7 : 20 9d 24 JSR $249d ; (freg + 20)
17fa : 20 84 26 JSR $2684 ; (fdiv + 0)
17fd : a5 1b __ LDA ACCU + 0 
17ff : 85 43 __ STA T1 + 0 
1801 : a5 1c __ LDA ACCU + 1 
1803 : 85 44 __ STA T1 + 1 
1805 : a5 1d __ LDA ACCU + 2 
1807 : 85 45 __ STA T1 + 2 
1809 : e6 4a __ INC T5 + 0 
180b : d0 02 __ BNE $180f ; (nformf.s1088 + 0)
.s1087:
180d : e6 4b __ INC T5 + 1 
.s1088:
180f : a5 1e __ LDA ACCU + 3 
1811 : 85 46 __ STA T1 + 3 
1813 : 10 03 __ BPL $1818 ; (nformf.s1052 + 0)
1815 : 4c 1a 14 JMP $141a ; (nformf.s12 + 0)
.s1052:
1818 : c9 41 __ CMP #$41
181a : f0 af __ BEQ $17cb ; (nformf.s1053 + 0)
.l1056:
181c : b0 bb __ BCS $17d9 ; (nformf.l1078 + 0)
181e : 4c 1a 14 JMP $141a ; (nformf.s12 + 0)
.s1072:
1821 : 90 92 __ BCC $17b5 ; (nformf.s16 + 0)
1823 : 4c 43 17 JMP $1743 ; (nformf.s1079 + 0)
.s7:
1826 : 85 1b __ STA ACCU + 0 
1828 : a9 49 __ LDA #$49
182a : 91 13 __ STA (P6),y ; (str + 0)
182c : a9 4e __ LDA #$4e
182e : a4 4a __ LDY T5 + 0 
1830 : 91 13 __ STA (P6),y ; (str + 0)
1832 : a9 46 __ LDA #$46
1834 : a4 1b __ LDY ACCU + 0 
1836 : 91 13 __ STA (P6),y ; (str + 0)
1838 : 18 __ __ CLC
1839 : a5 48 __ LDA T3 + 0 
183b : 69 03 __ ADC #$03
183d : 85 48 __ STA T3 + 0 
183f : 4c 1b 16 JMP $161b ; (nformf.s9 + 0)
.s189:
1842 : 20 5a 18 JSR $185a ; (isinf.s0 + 0)
1845 : aa __ __ TAX
1846 : a9 01 __ LDA #$01
1848 : 85 48 __ STA T3 + 0 
184a : 8a __ __ TXA
184b : d0 03 __ BNE $1850 ; (nformf.s158 + 0)
184d : 4c f7 13 JMP $13f7 ; (nformf.s8 + 0)
.s158:
1850 : a9 02 __ LDA #$02
1852 : 85 4a __ STA T5 + 0 
1854 : a9 03 __ LDA #$03
1856 : a0 01 __ LDY #$01
1858 : d0 cc __ BNE $1826 ; (nformf.s7 + 0)
--------------------------------------------------------------------
isinf:
.s0:
185a : 06 0f __ ASL P2 ; (f + 2)
185c : a5 10 __ LDA P3 ; (f + 3)
185e : 2a __ __ ROL
185f : c9 ff __ CMP #$ff
1861 : d0 03 __ BNE $1866 ; (isinf.s1003 + 0)
.s1002:
1863 : a9 01 __ LDA #$01
1865 : 60 __ __ RTS
.s1003:
1866 : a9 00 __ LDA #$00
.s1001:
1868 : 60 __ __ RTS
--------------------------------------------------------------------
fround5:
3195 : __ __ __ BYT 00 00 00 3f cd cc 4c 3d 0a d7 a3 3b 6f 12 03 3a : ...?..L=...;o..:
31a5 : __ __ __ BYT 17 b7 51 38 ac c5 a7 36 bd 37 06 35             : ..Q8...6.7.5
--------------------------------------------------------------------
1869 : __ __ __ BYT 25 30 36 64 00                                  : %06d.
--------------------------------------------------------------------
cwin_putat_string:
.s0:
186e : a5 10 __ LDA P3 ; (y + 0)
1870 : 0a __ __ ASL
1871 : aa __ __ TAX
1872 : bd 92 29 LDA $2992,x ; (mul40 + 0)
1875 : 18 __ __ CLC
1876 : 65 0f __ ADC P2 ; (x + 0)
1878 : 85 1b __ STA ACCU + 0 
187a : bd 93 29 LDA $2993,x ; (mul40 + 1)
187d : 69 00 __ ADC #$00
187f : 85 1c __ STA ACCU + 1 
1881 : a0 06 __ LDY #$06
1883 : b1 0d __ LDA (P0),y ; (win + 0)
1885 : 18 __ __ CLC
1886 : 65 1b __ ADC ACCU + 0 
1888 : 85 43 __ STA T3 + 0 
188a : c8 __ __ INY
188b : b1 0d __ LDA (P0),y ; (win + 0)
188d : 65 1c __ ADC ACCU + 1 
188f : 85 44 __ STA T3 + 1 
1891 : c8 __ __ INY
1892 : b1 0d __ LDA (P0),y ; (win + 0)
1894 : 18 __ __ CLC
1895 : 65 1b __ ADC ACCU + 0 
1897 : 85 1b __ STA ACCU + 0 
1899 : c8 __ __ INY
189a : b1 0d __ LDA (P0),y ; (win + 0)
189c : 65 1c __ ADC ACCU + 1 
189e : 85 1c __ STA ACCU + 1 
18a0 : a0 00 __ LDY #$00
18a2 : b1 11 __ LDA (P4),y ; (str + 0)
18a4 : f0 18 __ BEQ $18be ; (cwin_putat_string.s3 + 0)
.l2:
18a6 : 85 1d __ STA ACCU + 2 
18a8 : 4a __ __ LSR
18a9 : 4a __ __ LSR
18aa : 4a __ __ LSR
18ab : 4a __ __ LSR
18ac : 4a __ __ LSR
18ad : aa __ __ TAX
18ae : bd b1 31 LDA $31b1,x ; (p2smap + 0)
18b1 : 45 1d __ EOR ACCU + 2 
18b3 : 91 43 __ STA (T3 + 0),y 
18b5 : a5 13 __ LDA P6 ; (color + 0)
18b7 : 91 1b __ STA (ACCU + 0),y 
18b9 : c8 __ __ INY
18ba : b1 11 __ LDA (P4),y ; (str + 0)
18bc : d0 e8 __ BNE $18a6 ; (cwin_putat_string.l2 + 0)
.s3:
18be : 98 __ __ TYA
.s1001:
18bf : 60 __ __ RTS
--------------------------------------------------------------------
p2smap:
31b1 : __ __ __ BYT 00 00 40 20 80 c0 80 80                         : ..@ ....
--------------------------------------------------------------------
joy_poll:
.s0:
18c0 : aa __ __ TAX
18c1 : bd 00 dc LDA $dc00,x 
18c4 : a8 __ __ TAY
18c5 : 29 10 __ AND #$10
18c7 : f0 04 __ BEQ $18cd ; (joy_poll.s1005 + 0)
.s1006:
18c9 : a9 00 __ LDA #$00
18cb : f0 02 __ BEQ $18cf ; (joy_poll.s1007 + 0)
.s1005:
18cd : a9 01 __ LDA #$01
.s1007:
18cf : 9d e7 31 STA $31e7,x ; (joyb + 0)
18d2 : 98 __ __ TYA
18d3 : 4a __ __ LSR
18d4 : b0 1d __ BCS $18f3 ; (joy_poll.s2 + 0)
.s1:
18d6 : a9 ff __ LDA #$ff
.s15:
18d8 : 9d e3 31 STA $31e3,x ; (joyy + 0)
18db : 98 __ __ TYA
18dc : 29 04 __ AND #$04
18de : d0 06 __ BNE $18e6 ; (joy_poll.s8 + 0)
.s7:
18e0 : a9 ff __ LDA #$ff
.s1001:
18e2 : 9d e5 31 STA $31e5,x ; (joyx + 0)
18e5 : 60 __ __ RTS
.s8:
18e6 : 98 __ __ TYA
18e7 : 29 08 __ AND #$08
18e9 : f0 04 __ BEQ $18ef ; (joy_poll.s1011 + 0)
.s1012:
18eb : a9 00 __ LDA #$00
18ed : f0 f3 __ BEQ $18e2 ; (joy_poll.s1001 + 0)
.s1011:
18ef : a9 01 __ LDA #$01
18f1 : d0 ef __ BNE $18e2 ; (joy_poll.s1001 + 0)
.s2:
18f3 : 98 __ __ TYA
18f4 : 29 02 __ AND #$02
18f6 : f0 04 __ BEQ $18fc ; (joy_poll.s1008 + 0)
.s1009:
18f8 : a9 00 __ LDA #$00
18fa : f0 dc __ BEQ $18d8 ; (joy_poll.s15 + 0)
.s1008:
18fc : a9 01 __ LDA #$01
18fe : d0 d8 __ BNE $18d8 ; (joy_poll.s15 + 0)
--------------------------------------------------------------------
joyy:
31e3 : __ __ __ BSS	2
--------------------------------------------------------------------
joyx:
31e5 : __ __ __ BSS	2
--------------------------------------------------------------------
joyb:
31e7 : __ __ __ BSS	2
--------------------------------------------------------------------
wait_frames:
.s0:
1900 : a5 0e __ LDA P1 ; (frames + 1)
1902 : 30 1c __ BMI $1920 ; (wait_frames.s1001 + 0)
.s1005:
1904 : 05 0d __ ORA P0 ; (frames + 0)
1906 : f0 18 __ BEQ $1920 ; (wait_frames.s1001 + 0)
.s13:
1908 : a0 00 __ LDY #$00
190a : a6 0e __ LDX P1 ; (frames + 1)
.l6:
190c : ad 11 d0 LDA $d011 
190f : 30 fb __ BMI $190c ; (wait_frames.l6 + 0)
.l9:
1911 : ad 11 d0 LDA $d011 
1914 : 10 fb __ BPL $1911 ; (wait_frames.l9 + 0)
.s3:
1916 : c8 __ __ INY
1917 : 8a __ __ TXA
1918 : 30 06 __ BMI $1920 ; (wait_frames.s1001 + 0)
.s1004:
191a : d0 f0 __ BNE $190c ; (wait_frames.l6 + 0)
.s1002:
191c : c4 0d __ CPY P0 ; (frames + 0)
191e : 90 ec __ BCC $190c ; (wait_frames.l6 + 0)
.s1001:
1920 : 60 __ __ RTS
--------------------------------------------------------------------
game_loop:
.s0:
1921 : 20 45 19 JSR $1945 ; (init_game_state.s0 + 0)
.l1:
1924 : 20 4c 0b JSR $0b4c ; (clear_screen.s0 + 0)
1927 : 20 5e 19 JSR $195e ; (init_player.s0 + 0)
192a : 20 73 19 JSR $1973 ; (init_enemies.s0 + 0)
192d : 20 8b 19 JSR $198b ; (init_shots.s0 + 0)
1930 : 20 b2 19 JSR $19b2 ; (run_game.s1000 + 0)
1933 : ce e2 31 DEC $31e2 ; (game + 9)
1936 : f0 07 __ BEQ $193f ; (game_loop.s3 + 0)
.s4:
1938 : a9 02 __ LDA #$02
193a : 8d d9 31 STA $31d9 ; (game + 0)
193d : d0 e5 __ BNE $1924 ; (game_loop.l1 + 0)
.s3:
193f : a9 04 __ LDA #$04
1941 : 8d d9 31 STA $31d9 ; (game + 0)
.s1001:
1944 : 60 __ __ RTS
--------------------------------------------------------------------
init_game_state:
.s0:
1945 : a9 02 __ LDA #$02
1947 : 8d d9 31 STA $31d9 ; (game + 0)
194a : a9 00 __ LDA #$00
194c : 8d da 31 STA $31da ; (game + 1)
194f : 8d db 31 STA $31db ; (game + 2)
1952 : 8d dc 31 STA $31dc ; (game + 3)
1955 : 8d dd 31 STA $31dd ; (game + 4)
1958 : a9 03 __ LDA #$03
195a : 8d e2 31 STA $31e2 ; (game + 9)
.s1001:
195d : 60 __ __ RTS
--------------------------------------------------------------------
init_player:
.s0:
195e : a9 05 __ LDA #$05
1960 : 8d e9 31 STA $31e9 ; (Player + 0)
1963 : a9 0c __ LDA #$0c
1965 : 8d ea 31 STA $31ea ; (Player + 1)
1968 : a9 01 __ LDA #$01
196a : 8d eb 31 STA $31eb ; (Player + 2)
196d : a9 00 __ LDA #$00
196f : 8d ef 31 STA $31ef ; (PlayerShotSound + 3)
.s1001:
1972 : 60 __ __ RTS
--------------------------------------------------------------------
Player:
31e9 : __ __ __ BSS	3
--------------------------------------------------------------------
PlayerShotSound:
31ec : __ __ __ BSS	4
--------------------------------------------------------------------
init_enemies:
.s0:
1973 : a2 00 __ LDX #$00
1975 : a0 0a __ LDY #$0a
.l1002:
1977 : a9 00 __ LDA #$00
1979 : 9d 00 32 STA $3200,x ; (Enemy + 0)
197c : 9d 01 32 STA $3201,x ; (Enemy + 1)
197f : 9d 04 32 STA $3204,x ; (Enemy + 4)
1982 : 8a __ __ TXA
1983 : 18 __ __ CLC
1984 : 69 05 __ ADC #$05
1986 : aa __ __ TAX
1987 : 88 __ __ DEY
1988 : d0 ed __ BNE $1977 ; (init_enemies.l1002 + 0)
.s1001:
198a : 60 __ __ RTS
--------------------------------------------------------------------
Enemy:
3200 : __ __ __ BSS	50
--------------------------------------------------------------------
init_shots:
.s0:
198b : a2 00 __ LDX #$00
198d : a0 03 __ LDY #$03
198f : 8a __ __ TXA
.l1006:
1990 : 9d f0 31 STA $31f0,x ; (PlayerShot + 0)
1993 : 9d f1 31 STA $31f1,x ; (PlayerShot + 1)
1996 : 9d f2 31 STA $31f2,x ; (PlayerShot + 2)
1999 : e8 __ __ INX
199a : e8 __ __ INX
199b : e8 __ __ INX
199c : 88 __ __ DEY
199d : d0 f1 __ BNE $1990 ; (init_shots.l1006 + 0)
.s6:
199f : a0 03 __ LDY #$03
19a1 : aa __ __ TAX
.l1008:
19a2 : 9d 32 32 STA $3232,x ; (EnemyShot + 0)
19a5 : 9d 33 32 STA $3233,x ; (EnemyShot + 1)
19a8 : 9d 34 32 STA $3234,x ; (EnemyShot + 2)
19ab : e8 __ __ INX
19ac : e8 __ __ INX
19ad : e8 __ __ INX
19ae : 88 __ __ DEY
19af : d0 f1 __ BNE $19a2 ; (init_shots.l1008 + 0)
.s1001:
19b1 : 60 __ __ RTS
--------------------------------------------------------------------
PlayerShot:
31f0 : __ __ __ BSS	9
--------------------------------------------------------------------
EnemyShot:
3232 : __ __ __ BSS	9
--------------------------------------------------------------------
run_game:
.s1000:
19b2 : a5 53 __ LDA T0 + 0 
19b4 : 8d cd 9f STA $9fcd ; (run_game@stack + 0)
.s0:
19b7 : a9 ff __ LDA #$ff
19b9 : 8d 18 d4 STA $d418 
19bc : ad d9 31 LDA $31d9 ; (game + 0)
19bf : c9 02 __ CMP #$02
19c1 : d0 5c __ BNE $1a1f ; (run_game.s1001 + 0)
.s7:
19c3 : a9 00 __ LDA #$00
19c5 : 85 53 __ STA T0 + 0 
.l2:
19c7 : 20 25 1a JSR $1a25 ; (render_game_state.s1000 + 0)
19ca : 20 13 1b JSR $1b13 ; (play_sound_effects.s0 + 0)
19cd : a5 53 __ LDA T0 + 0 
19cf : 85 1b __ STA ACCU + 0 
19d1 : a9 00 __ LDA #$00
19d3 : 85 1c __ STA ACCU + 1 
19d5 : 85 04 __ STA WORK + 1 
19d7 : a9 03 __ LDA #$03
19d9 : 85 03 __ STA WORK + 0 
19db : 20 6c 27 JSR $276c ; (divmod + 0)
19de : a5 05 __ LDA WORK + 2 
19e0 : 05 06 __ ORA WORK + 3 
19e2 : d0 0c __ BNE $19f0 ; (run_game.s6 + 0)
.s4:
19e4 : 20 ea 1b JSR $1bea ; (spawn_enemy.s0 + 0)
19e7 : 20 81 1c JSR $1c81 ; (move_enemies.s0 + 0)
19ea : 20 03 1e JSR $1e03 ; (render_enemies.s0 + 0)
19ed : 20 60 1e JSR $1e60 ; (check_shot_enemy_collision.s0 + 0)
.s6:
19f0 : 20 ab 1f JSR $1fab ; (move_enemy_shots.s0 + 0)
19f3 : 20 ae 1d JSR $1dae ; (render_enemy_shots.s0 + 0)
19f6 : 20 15 20 JSR $2015 ; (check_player_enemy_collision.s0 + 0)
19f9 : 20 46 21 JSR $2146 ; (control_player_ship.s0 + 0)
19fc : 20 47 22 JSR $2247 ; (render_player_ship.s0 + 0)
19ff : 20 15 20 JSR $2015 ; (check_player_enemy_collision.s0 + 0)
1a02 : 20 87 22 JSR $2287 ; (move_player_shots.s0 + 0)
1a05 : 20 ef 22 JSR $22ef ; (render_player_shots.s0 + 0)
1a08 : 20 60 1e JSR $1e60 ; (check_shot_enemy_collision.s0 + 0)
1a0b : a9 03 __ LDA #$03
1a0d : 85 0d __ STA P0 
1a0f : a9 00 __ LDA #$00
1a11 : 85 0e __ STA P1 
1a13 : 20 00 19 JSR $1900 ; (wait_frames.s0 + 0)
1a16 : e6 53 __ INC T0 + 0 
1a18 : ad d9 31 LDA $31d9 ; (game + 0)
1a1b : c9 02 __ CMP #$02
1a1d : f0 a8 __ BEQ $19c7 ; (run_game.l2 + 0)
.s1001:
1a1f : ad cd 9f LDA $9fcd ; (run_game@stack + 0)
1a22 : 85 53 __ STA T0 + 0 
1a24 : 60 __ __ RTS
--------------------------------------------------------------------
render_game_state:
.s1000:
1a25 : 38 __ __ SEC
1a26 : a5 23 __ LDA SP + 0 
1a28 : e9 0a __ SBC #$0a
1a2a : 85 23 __ STA SP + 0 
1a2c : b0 02 __ BCS $1a30 ; (render_game_state.s0 + 0)
1a2e : c6 24 __ DEC SP + 1 
.s0:
1a30 : a9 01 __ LDA #$01
1a32 : 85 0f __ STA P2 
1a34 : a9 02 __ LDA #$02
1a36 : 85 10 __ STA P3 
1a38 : a9 03 __ LDA #$03
1a3a : 85 13 __ STA P6 
1a3c : a9 c5 __ LDA #$c5
1a3e : 85 0d __ STA P0 
1a40 : a9 31 __ LDA #$31
1a42 : 85 0e __ STA P1 
1a44 : a9 00 __ LDA #$00
1a46 : 85 11 __ STA P4 
1a48 : a9 1b __ LDA #$1b
1a4a : 85 12 __ STA P5 
1a4c : 20 6e 18 JSR $186e ; (cwin_putat_string.s0 + 0)
1a4f : a9 ce __ LDA #$ce
1a51 : a0 02 __ LDY #$02
1a53 : 91 23 __ STA (SP + 0),y 
1a55 : a9 9f __ LDA #$9f
1a57 : c8 __ __ INY
1a58 : 91 23 __ STA (SP + 0),y 
1a5a : a9 69 __ LDA #$69
1a5c : c8 __ __ INY
1a5d : 91 23 __ STA (SP + 0),y 
1a5f : a9 18 __ LDA #$18
1a61 : c8 __ __ INY
1a62 : 91 23 __ STA (SP + 0),y 
1a64 : ad da 31 LDA $31da ; (game + 1)
1a67 : c8 __ __ INY
1a68 : 91 23 __ STA (SP + 0),y 
1a6a : ad db 31 LDA $31db ; (game + 2)
1a6d : c8 __ __ INY
1a6e : 91 23 __ STA (SP + 0),y 
1a70 : ad dc 31 LDA $31dc ; (game + 3)
1a73 : c8 __ __ INY
1a74 : 91 23 __ STA (SP + 0),y 
1a76 : ad dd 31 LDA $31dd ; (game + 4)
1a79 : c8 __ __ INY
1a7a : 91 23 __ STA (SP + 0),y 
1a7c : 20 a0 0b JSR $0ba0 ; (sprintf.s1000 + 0)
1a7f : a9 c5 __ LDA #$c5
1a81 : 85 0d __ STA P0 
1a83 : a9 31 __ LDA #$31
1a85 : 85 0e __ STA P1 
1a87 : a9 08 __ LDA #$08
1a89 : 85 0f __ STA P2 
1a8b : a9 02 __ LDA #$02
1a8d : 85 10 __ STA P3 
1a8f : a9 ce __ LDA #$ce
1a91 : 85 11 __ STA P4 
1a93 : a9 9f __ LDA #$9f
1a95 : 85 12 __ STA P5 
1a97 : a9 03 __ LDA #$03
1a99 : 85 13 __ STA P6 
1a9b : 20 6e 18 JSR $186e ; (cwin_putat_string.s0 + 0)
1a9e : a9 1d __ LDA #$1d
1aa0 : 85 0f __ STA P2 
1aa2 : a9 0e __ LDA #$0e
1aa4 : 85 13 __ STA P6 
1aa6 : a9 07 __ LDA #$07
1aa8 : 85 11 __ STA P4 
1aaa : a9 1b __ LDA #$1b
1aac : 85 12 __ STA P5 
1aae : 20 6e 18 JSR $186e ; (cwin_putat_string.s0 + 0)
1ab1 : a9 ce __ LDA #$ce
1ab3 : a0 02 __ LDY #$02
1ab5 : 91 23 __ STA (SP + 0),y 
1ab7 : a9 9f __ LDA #$9f
1ab9 : c8 __ __ INY
1aba : 91 23 __ STA (SP + 0),y 
1abc : a9 0e __ LDA #$0e
1abe : c8 __ __ INY
1abf : 91 23 __ STA (SP + 0),y 
1ac1 : a9 1b __ LDA #$1b
1ac3 : c8 __ __ INY
1ac4 : 91 23 __ STA (SP + 0),y 
1ac6 : ad e2 31 LDA $31e2 ; (game + 9)
1ac9 : c8 __ __ INY
1aca : 91 23 __ STA (SP + 0),y 
1acc : a9 00 __ LDA #$00
1ace : c8 __ __ INY
1acf : 91 23 __ STA (SP + 0),y 
1ad1 : 20 a0 0b JSR $0ba0 ; (sprintf.s1000 + 0)
1ad4 : a9 c5 __ LDA #$c5
1ad6 : 85 0d __ STA P0 
1ad8 : a9 31 __ LDA #$31
1ada : 85 0e __ STA P1 
1adc : a9 24 __ LDA #$24
1ade : 85 0f __ STA P2 
1ae0 : a9 02 __ LDA #$02
1ae2 : 85 10 __ STA P3 
1ae4 : a9 ce __ LDA #$ce
1ae6 : 85 11 __ STA P4 
1ae8 : a9 9f __ LDA #$9f
1aea : 85 12 __ STA P5 
1aec : a9 0e __ LDA #$0e
1aee : 85 13 __ STA P6 
1af0 : 20 6e 18 JSR $186e ; (cwin_putat_string.s0 + 0)
.s1001:
1af3 : 18 __ __ CLC
1af4 : a5 23 __ LDA SP + 0 
1af6 : 69 0a __ ADC #$0a
1af8 : 85 23 __ STA SP + 0 
1afa : 90 02 __ BCC $1afe ; (render_game_state.s1001 + 11)
1afc : e6 24 __ INC SP + 1 
1afe : 60 __ __ RTS
--------------------------------------------------------------------
1b00 : __ __ __ BYT 53 43 4f 52 45 3a 00                            : SCORE:.
--------------------------------------------------------------------
1b07 : __ __ __ BYT 53 48 49 50 53 3a 00                            : SHIPS:.
--------------------------------------------------------------------
1b0e : __ __ __ BYT 25 30 32 64 00                                  : %02d.
--------------------------------------------------------------------
play_sound_effects:
.s0:
1b13 : ad ef 31 LDA $31ef ; (PlayerShotSound + 3)
1b16 : c9 01 __ CMP #$01
1b18 : d0 2c __ BNE $1b46 ; (play_sound_effects.s2 + 0)
.s1:
1b1a : a9 20 __ LDA #$20
1b1c : 8d ec 31 STA $31ec ; (PlayerShotSound + 0)
1b1f : a9 4e __ LDA #$4e
1b21 : 8d ed 31 STA $31ed ; (PlayerShotSound + 1)
1b24 : a9 00 __ LDA #$00
1b26 : 8d ee 31 STA $31ee ; (PlayerShotSound + 2)
1b29 : a9 20 __ LDA #$20
1b2b : 8d 00 d4 STA $d400 
1b2e : a9 4e __ LDA #$4e
1b30 : 8d 01 d4 STA $d401 
1b33 : a9 05 __ LDA #$05
1b35 : 8d 05 d4 STA $d405 
1b38 : a9 f1 __ LDA #$f1
1b3a : 8d 06 d4 STA $d406 
1b3d : a9 81 __ LDA #$81
1b3f : 8d 04 d4 STA $d404 
1b42 : a9 02 __ LDA #$02
1b44 : d0 35 __ BNE $1b7b ; (play_sound_effects.s1014 + 0)
.s2:
1b46 : c9 02 __ CMP #$02
1b48 : d0 26 __ BNE $1b70 ; (play_sound_effects.s5 + 0)
.s4:
1b4a : ad ec 31 LDA $31ec ; (PlayerShotSound + 0)
1b4d : 38 __ __ SEC
1b4e : e9 f4 __ SBC #$f4
1b50 : 8d ec 31 STA $31ec ; (PlayerShotSound + 0)
1b53 : ad ed 31 LDA $31ed ; (PlayerShotSound + 1)
1b56 : e9 01 __ SBC #$01
1b58 : 8d ed 31 STA $31ed ; (PlayerShotSound + 1)
1b5b : ad ec 31 LDA $31ec ; (PlayerShotSound + 0)
1b5e : 8d 00 d4 STA $d400 
1b61 : ad ed 31 LDA $31ed ; (PlayerShotSound + 1)
1b64 : 8d 01 d4 STA $d401 
1b67 : a9 14 __ LDA #$14
1b69 : 8d ee 31 STA $31ee ; (PlayerShotSound + 2)
1b6c : a9 03 __ LDA #$03
1b6e : d0 0b __ BNE $1b7b ; (play_sound_effects.s1014 + 0)
.s5:
1b70 : c9 03 __ CMP #$03
1b72 : d0 0a __ BNE $1b7e ; (play_sound_effects.s26 + 0)
.s10:
1b74 : a9 08 __ LDA #$08
1b76 : 8d 04 d4 STA $d404 
1b79 : a9 00 __ LDA #$00
.s1014:
1b7b : 8d ef 31 STA $31ef ; (PlayerShotSound + 3)
.s26:
1b7e : ad fc 31 LDA $31fc ; (EnemyShotSound + 3)
1b81 : c9 01 __ CMP #$01
1b83 : d0 2c __ BNE $1bb1 ; (play_sound_effects.s14 + 0)
.s13:
1b85 : a9 20 __ LDA #$20
1b87 : 8d f9 31 STA $31f9 ; (EnemyShotSound + 0)
1b8a : a9 4e __ LDA #$4e
1b8c : 8d fa 31 STA $31fa ; (EnemyShotSound + 1)
1b8f : a9 00 __ LDA #$00
1b91 : 8d fb 31 STA $31fb ; (EnemyShotSound + 2)
1b94 : a9 20 __ LDA #$20
1b96 : 8d 07 d4 STA $d407 
1b99 : a9 4e __ LDA #$4e
1b9b : 8d 08 d4 STA $d408 
1b9e : a9 05 __ LDA #$05
1ba0 : 8d 0c d4 STA $d40c 
1ba3 : a9 f1 __ LDA #$f1
1ba5 : 8d 0d d4 STA $d40d 
1ba8 : a9 11 __ LDA #$11
1baa : 8d 0b d4 STA $d40b 
1bad : a9 02 __ LDA #$02
1baf : d0 35 __ BNE $1be6 ; (play_sound_effects.s1015 + 0)
.s14:
1bb1 : c9 02 __ CMP #$02
1bb3 : d0 26 __ BNE $1bdb ; (play_sound_effects.s17 + 0)
.s16:
1bb5 : ad f9 31 LDA $31f9 ; (EnemyShotSound + 0)
1bb8 : 18 __ __ CLC
1bb9 : 69 f4 __ ADC #$f4
1bbb : 8d f9 31 STA $31f9 ; (EnemyShotSound + 0)
1bbe : ad fa 31 LDA $31fa ; (EnemyShotSound + 1)
1bc1 : 69 01 __ ADC #$01
1bc3 : 8d fa 31 STA $31fa ; (EnemyShotSound + 1)
1bc6 : ad f9 31 LDA $31f9 ; (EnemyShotSound + 0)
1bc9 : 8d 07 d4 STA $d407 
1bcc : ad fa 31 LDA $31fa ; (EnemyShotSound + 1)
1bcf : 8d 08 d4 STA $d408 
1bd2 : a9 14 __ LDA #$14
1bd4 : 8d fb 31 STA $31fb ; (EnemyShotSound + 2)
1bd7 : a9 03 __ LDA #$03
1bd9 : d0 0b __ BNE $1be6 ; (play_sound_effects.s1015 + 0)
.s17:
1bdb : c9 03 __ CMP #$03
1bdd : d0 0a __ BNE $1be9 ; (play_sound_effects.s1001 + 0)
.s22:
1bdf : a9 08 __ LDA #$08
1be1 : 8d 0b d4 STA $d40b 
1be4 : a9 00 __ LDA #$00
.s1015:
1be6 : 8d fc 31 STA $31fc ; (EnemyShotSound + 3)
.s1001:
1be9 : 60 __ __ RTS
--------------------------------------------------------------------
EnemyShotSound:
31f9 : __ __ __ BSS	4
--------------------------------------------------------------------
spawn_enemy:
.s0:
1bea : 20 5a 1c JSR $1c5a ; (rand.s0 + 0)
1bed : 46 1b __ LSR ACCU + 0 
1bef : b0 0f __ BCS $1c00 ; (spawn_enemy.s1001 + 0)
.s3:
1bf1 : a0 00 __ LDY #$00
.l6:
1bf3 : be 3d 29 LDX $293d,y ; (__multab5L + 0)
1bf6 : bd 04 32 LDA $3204,x ; (Enemy + 4)
1bf9 : f0 06 __ BEQ $1c01 ; (spawn_enemy.s9 + 0)
.s7:
1bfb : c8 __ __ INY
1bfc : c0 0a __ CPY #$0a
1bfe : 90 f3 __ BCC $1bf3 ; (spawn_enemy.l6 + 0)
.s1001:
1c00 : 60 __ __ RTS
.s9:
1c01 : 86 43 __ STX T0 + 0 
1c03 : a9 27 __ LDA #$27
1c05 : 9d 00 32 STA $3200,x ; (Enemy + 0)
1c08 : 20 5a 1c JSR $1c5a ; (rand.s0 + 0)
1c0b : a9 14 __ LDA #$14
1c0d : 85 03 __ STA WORK + 0 
1c0f : a9 00 __ LDA #$00
1c11 : 85 04 __ STA WORK + 1 
1c13 : 20 6c 27 JSR $276c ; (divmod + 0)
1c16 : 18 __ __ CLC
1c17 : a5 05 __ LDA WORK + 2 
1c19 : 69 04 __ ADC #$04
1c1b : a6 43 __ LDX T0 + 0 
1c1d : 9d 01 32 STA $3201,x ; (Enemy + 1)
1c20 : 20 5a 1c JSR $1c5a ; (rand.s0 + 0)
1c23 : a9 0e __ LDA #$0e
1c25 : a6 43 __ LDX T0 + 0 
1c27 : 9d 03 32 STA $3203,x ; (Enemy + 3)
1c2a : a9 01 __ LDA #$01
1c2c : 9d 04 32 STA $3204,x ; (Enemy + 4)
1c2f : a9 03 __ LDA #$03
1c31 : 85 03 __ STA WORK + 0 
1c33 : a9 00 __ LDA #$00
1c35 : 85 04 __ STA WORK + 1 
1c37 : 20 6c 27 JSR $276c ; (divmod + 0)
1c3a : 18 __ __ CLC
1c3b : a5 05 __ LDA WORK + 2 
1c3d : 69 83 __ ADC #$83
1c3f : a4 43 __ LDY T0 + 0 
1c41 : 99 02 32 STA $3202,y ; (Enemy + 2)
1c44 : c9 83 __ CMP #$83
1c46 : d0 04 __ BNE $1c4c ; (spawn_enemy.s13 + 0)
.s12:
1c48 : a9 0d __ LDA #$0d
1c4a : d0 0a __ BNE $1c56 ; (spawn_enemy.s1008 + 0)
.s13:
1c4c : c9 84 __ CMP #$84
1c4e : d0 04 __ BNE $1c54 ; (spawn_enemy.s16 + 0)
.s15:
1c50 : a9 0a __ LDA #$0a
1c52 : d0 02 __ BNE $1c56 ; (spawn_enemy.s1008 + 0)
.s16:
1c54 : a9 09 __ LDA #$09
.s1008:
1c56 : 99 03 32 STA $3203,y ; (Enemy + 3)
1c59 : 60 __ __ RTS
--------------------------------------------------------------------
rand:
.s0:
1c5a : ad ba 31 LDA $31ba ; (seed + 1)
1c5d : 4a __ __ LSR
1c5e : ad b9 31 LDA $31b9 ; (seed + 0)
1c61 : 6a __ __ ROR
1c62 : aa __ __ TAX
1c63 : a9 00 __ LDA #$00
1c65 : 6a __ __ ROR
1c66 : 4d b9 31 EOR $31b9 ; (seed + 0)
1c69 : 85 1b __ STA ACCU + 0 
1c6b : 8a __ __ TXA
1c6c : 4d ba 31 EOR $31ba ; (seed + 1)
1c6f : 85 1c __ STA ACCU + 1 
1c71 : 4a __ __ LSR
1c72 : 45 1b __ EOR ACCU + 0 
1c74 : 8d b9 31 STA $31b9 ; (seed + 0)
1c77 : 85 1b __ STA ACCU + 0 
1c79 : 45 1c __ EOR ACCU + 1 
1c7b : 8d ba 31 STA $31ba ; (seed + 1)
1c7e : 85 1c __ STA ACCU + 1 
.s1001:
1c80 : 60 __ __ RTS
--------------------------------------------------------------------
seed:
31b9 : __ __ __ BYT 00 7a                                           : .z
--------------------------------------------------------------------
move_enemies:
.s0:
1c81 : a2 00 __ LDX #$00
.l2:
1c83 : 86 43 __ STX T0 + 0 
1c85 : bc 3d 29 LDY $293d,x ; (__multab5L + 0)
1c88 : b9 04 32 LDA $3204,y ; (Enemy + 4)
1c8b : c9 01 __ CMP #$01
1c8d : d0 75 __ BNE $1d04 ; (move_enemies.s41 + 0)
.s5:
1c8f : 18 __ __ CLC
1c90 : a9 00 __ LDA #$00
1c92 : 7d 3d 29 ADC $293d,x ; (__multab5L + 0)
1c95 : 85 44 __ STA T1 + 0 
1c97 : a9 32 __ LDA #$32
1c99 : 69 00 __ ADC #$00
1c9b : 85 45 __ STA T1 + 1 
1c9d : a0 02 __ LDY #$02
1c9f : b1 44 __ LDA (T1 + 0),y 
1ca1 : c9 83 __ CMP #$83
1ca3 : d0 16 __ BNE $1cbb ; (move_enemies.s10 + 0)
.s11:
1ca5 : 88 __ __ DEY
1ca6 : b1 44 __ LDA (T1 + 0),y 
1ca8 : cd ea 31 CMP $31ea ; (Player + 1)
1cab : d0 0e __ BNE $1cbb ; (move_enemies.s10 + 0)
.s8:
1cad : a5 44 __ LDA T1 + 0 
1caf : 85 0d __ STA P0 
1cb1 : a5 45 __ LDA T1 + 1 
1cb3 : 85 0e __ STA P1 
1cb5 : 20 71 1d JSR $1d71 ; (spawn_enemy_shot.s0 + 0)
1cb8 : 20 ae 1d JSR $1dae ; (render_enemy_shots.s0 + 0)
.s10:
1cbb : a0 00 __ LDY #$00
1cbd : b1 44 __ LDA (T1 + 0),y 
1cbf : 85 46 __ STA T3 + 0 
1cc1 : c8 __ __ INY
1cc2 : b1 44 __ LDA (T1 + 0),y 
1cc4 : 0a __ __ ASL
1cc5 : 85 1b __ STA ACCU + 0 
1cc7 : a9 00 __ LDA #$00
1cc9 : 2a __ __ ROL
1cca : 06 1b __ ASL ACCU + 0 
1ccc : 2a __ __ ROL
1ccd : aa __ __ TAX
1cce : a5 1b __ LDA ACCU + 0 
1cd0 : 71 44 __ ADC (T1 + 0),y 
1cd2 : 85 1b __ STA ACCU + 0 
1cd4 : 8a __ __ TXA
1cd5 : 69 00 __ ADC #$00
1cd7 : 06 1b __ ASL ACCU + 0 
1cd9 : 2a __ __ ROL
1cda : 06 1b __ ASL ACCU + 0 
1cdc : 2a __ __ ROL
1cdd : 06 1b __ ASL ACCU + 0 
1cdf : 2a __ __ ROL
1ce0 : aa __ __ TAX
1ce1 : 18 __ __ CLC
1ce2 : a5 1b __ LDA ACCU + 0 
1ce4 : 65 46 __ ADC T3 + 0 
1ce6 : 85 1b __ STA ACCU + 0 
1ce8 : 85 1f __ STA ADDR + 0 
1cea : 8a __ __ TXA
1ceb : 69 c0 __ ADC #$c0
1ced : 85 1c __ STA ACCU + 1 
1cef : 18 __ __ CLC
1cf0 : 69 18 __ ADC #$18
1cf2 : 85 20 __ STA ADDR + 1 
1cf4 : a9 20 __ LDA #$20
1cf6 : 88 __ __ DEY
1cf7 : 91 1b __ STA (ACCU + 0),y 
1cf9 : 98 __ __ TYA
1cfa : 91 1f __ STA (ADDR + 0),y 
1cfc : a5 46 __ LDA T3 + 0 
1cfe : d0 0f __ BNE $1d0f ; (move_enemies.s12 + 0)
.s13:
1d00 : a0 04 __ LDY #$04
.s1020:
1d02 : 91 44 __ STA (T1 + 0),y 
.s41:
1d04 : a6 43 __ LDX T0 + 0 
1d06 : e8 __ __ INX
1d07 : e0 0a __ CPX #$0a
1d09 : b0 03 __ BCS $1d0e ; (move_enemies.s1001 + 0)
1d0b : 4c 83 1c JMP $1c83 ; (move_enemies.l2 + 0)
.s1001:
1d0e : 60 __ __ RTS
.s12:
1d0f : c6 46 __ DEC T3 + 0 
1d11 : a5 46 __ LDA T3 + 0 
1d13 : 91 44 __ STA (T1 + 0),y 
1d15 : a0 02 __ LDY #$02
1d17 : b1 44 __ LDA (T1 + 0),y 
1d19 : c9 85 __ CMP #$85
1d1b : f0 e7 __ BEQ $1d04 ; (move_enemies.s41 + 0)
.s15:
1d1d : 20 5a 1c JSR $1c5a ; (rand.s0 + 0)
1d20 : a0 01 __ LDY #$01
1d22 : b1 44 __ LDA (T1 + 0),y 
1d24 : 85 47 __ STA T4 + 0 
1d26 : a9 03 __ LDA #$03
1d28 : 85 03 __ STA WORK + 0 
1d2a : a9 00 __ LDA #$00
1d2c : 85 04 __ STA WORK + 1 
1d2e : 20 6c 27 JSR $276c ; (divmod + 0)
1d31 : 38 __ __ SEC
1d32 : a5 05 __ LDA WORK + 2 
1d34 : e9 01 __ SBC #$01
1d36 : aa __ __ TAX
1d37 : a5 06 __ LDA WORK + 3 
1d39 : e9 00 __ SBC #$00
1d3b : a8 __ __ TAY
1d3c : 8a __ __ TXA
1d3d : 18 __ __ CLC
1d3e : 65 47 __ ADC T4 + 0 
1d40 : 85 1b __ STA ACCU + 0 
1d42 : 90 01 __ BCC $1d45 ; (move_enemies.s1022 + 0)
.s1021:
1d44 : c8 __ __ INY
.s1022:
1d45 : 0a __ __ ASL
1d46 : 0a __ __ ASL
1d47 : 18 __ __ CLC
1d48 : 65 1b __ ADC ACCU + 0 
1d4a : 0a __ __ ASL
1d4b : 0a __ __ ASL
1d4c : 0a __ __ ASL
1d4d : 18 __ __ CLC
1d4e : 65 46 __ ADC T3 + 0 
1d50 : aa __ __ TAX
1d51 : bd 00 c0 LDA $c000,x 
1d54 : c9 83 __ CMP #$83
1d56 : f0 ac __ BEQ $1d04 ; (move_enemies.s41 + 0)
.s24:
1d58 : c9 84 __ CMP #$84
1d5a : f0 a8 __ BEQ $1d04 ; (move_enemies.s41 + 0)
.s23:
1d5c : c9 85 __ CMP #$85
1d5e : f0 a4 __ BEQ $1d04 ; (move_enemies.s41 + 0)
.s22:
1d60 : 98 __ __ TYA
1d61 : d0 a1 __ BNE $1d04 ; (move_enemies.s41 + 0)
.s1005:
1d63 : a5 1b __ LDA ACCU + 0 
1d65 : c9 04 __ CMP #$04
1d67 : 90 9b __ BCC $1d04 ; (move_enemies.s41 + 0)
.s1004:
1d69 : c9 18 __ CMP #$18
1d6b : b0 97 __ BCS $1d04 ; (move_enemies.s41 + 0)
.s18:
1d6d : a0 01 __ LDY #$01
1d6f : d0 91 __ BNE $1d02 ; (move_enemies.s1020 + 0)
--------------------------------------------------------------------
spawn_enemy_shot:
.s0:
1d71 : a0 00 __ LDY #$00
1d73 : b1 0d __ LDA (P0),y ; (e + 0)
1d75 : f0 0f __ BEQ $1d86 ; (spawn_enemy_shot.s1001 + 0)
.s3:
1d77 : a2 00 __ LDX #$00
.l6:
1d79 : bc 47 29 LDY $2947,x ; (__multab3L + 0)
1d7c : b9 34 32 LDA $3234,y ; (EnemyShot + 2)
1d7f : f0 06 __ BEQ $1d87 ; (spawn_enemy_shot.s9 + 0)
.s7:
1d81 : e8 __ __ INX
1d82 : e0 03 __ CPX #$03
1d84 : 90 f3 __ BCC $1d79 ; (spawn_enemy_shot.l6 + 0)
.s1001:
1d86 : 60 __ __ RTS
.s9:
1d87 : a9 01 __ LDA #$01
1d89 : 99 34 32 STA $3234,y ; (EnemyShot + 2)
1d8c : a0 00 __ LDY #$00
1d8e : b1 0d __ LDA (P0),y ; (e + 0)
1d90 : 38 __ __ SEC
1d91 : e9 01 __ SBC #$01
1d93 : bc 47 29 LDY $2947,x ; (__multab3L + 0)
1d96 : 99 32 32 STA $3232,y ; (EnemyShot + 0)
1d99 : a0 01 __ LDY #$01
1d9b : b1 0d __ LDA (P0),y ; (e + 0)
1d9d : bc 47 29 LDY $2947,x ; (__multab3L + 0)
1da0 : 99 33 32 STA $3233,y ; (EnemyShot + 1)
1da3 : ad fc 31 LDA $31fc ; (EnemyShotSound + 3)
1da6 : d0 de __ BNE $1d86 ; (spawn_enemy_shot.s1001 + 0)
.s12:
1da8 : a9 01 __ LDA #$01
1daa : 8d fc 31 STA $31fc ; (EnemyShotSound + 3)
1dad : 60 __ __ RTS
--------------------------------------------------------------------
render_enemy_shots:
.s0:
1dae : a2 00 __ LDX #$00
.l1006:
1db0 : bc 47 29 LDY $2947,x ; (__multab3L + 0)
1db3 : b9 34 32 LDA $3234,y ; (EnemyShot + 2)
1db6 : c9 01 __ CMP #$01
1db8 : d0 43 __ BNE $1dfd ; (render_enemy_shots.s19 + 0)
.s5:
1dba : b9 33 32 LDA $3233,y ; (EnemyShot + 1)
1dbd : 0a __ __ ASL
1dbe : 85 1b __ STA ACCU + 0 
1dc0 : a9 00 __ LDA #$00
1dc2 : 2a __ __ ROL
1dc3 : 06 1b __ ASL ACCU + 0 
1dc5 : 2a __ __ ROL
1dc6 : 85 1c __ STA ACCU + 1 
1dc8 : a5 1b __ LDA ACCU + 0 
1dca : 79 33 32 ADC $3233,y ; (EnemyShot + 1)
1dcd : 85 1b __ STA ACCU + 0 
1dcf : a5 1c __ LDA ACCU + 1 
1dd1 : 69 00 __ ADC #$00
1dd3 : 06 1b __ ASL ACCU + 0 
1dd5 : 2a __ __ ROL
1dd6 : 06 1b __ ASL ACCU + 0 
1dd8 : 2a __ __ ROL
1dd9 : 06 1b __ ASL ACCU + 0 
1ddb : 2a __ __ ROL
1ddc : 85 1c __ STA ACCU + 1 
1dde : 18 __ __ CLC
1ddf : a5 1b __ LDA ACCU + 0 
1de1 : 79 32 32 ADC $3232,y ; (EnemyShot + 0)
1de4 : 85 1b __ STA ACCU + 0 
1de6 : 85 1f __ STA ADDR + 0 
1de8 : a5 1c __ LDA ACCU + 1 
1dea : 69 c0 __ ADC #$c0
1dec : 85 1c __ STA ACCU + 1 
1dee : 18 __ __ CLC
1def : 69 18 __ ADC #$18
1df1 : 85 20 __ STA ADDR + 1 
1df3 : a9 82 __ LDA #$82
1df5 : a0 00 __ LDY #$00
1df7 : 91 1b __ STA (ACCU + 0),y 
1df9 : a9 01 __ LDA #$01
1dfb : 91 1f __ STA (ADDR + 0),y 
.s19:
1dfd : e8 __ __ INX
1dfe : e0 03 __ CPX #$03
1e00 : 90 ae __ BCC $1db0 ; (render_enemy_shots.l1006 + 0)
.s1001:
1e02 : 60 __ __ RTS
--------------------------------------------------------------------
render_enemies:
.s0:
1e03 : a2 00 __ LDX #$00
.l1006:
1e05 : bc 3d 29 LDY $293d,x ; (__multab5L + 0)
1e08 : b9 04 32 LDA $3204,y ; (Enemy + 4)
1e0b : c9 01 __ CMP #$01
1e0d : d0 4b __ BNE $1e5a ; (render_enemies.s19 + 0)
.s5:
1e0f : 84 1d __ STY ACCU + 2 
1e11 : b9 01 32 LDA $3201,y ; (Enemy + 1)
1e14 : 0a __ __ ASL
1e15 : 85 1b __ STA ACCU + 0 
1e17 : a9 00 __ LDA #$00
1e19 : 2a __ __ ROL
1e1a : 06 1b __ ASL ACCU + 0 
1e1c : 2a __ __ ROL
1e1d : 85 1c __ STA ACCU + 1 
1e1f : a5 1b __ LDA ACCU + 0 
1e21 : 79 01 32 ADC $3201,y ; (Enemy + 1)
1e24 : 85 1b __ STA ACCU + 0 
1e26 : a5 1c __ LDA ACCU + 1 
1e28 : 69 00 __ ADC #$00
1e2a : 06 1b __ ASL ACCU + 0 
1e2c : 2a __ __ ROL
1e2d : 06 1b __ ASL ACCU + 0 
1e2f : 2a __ __ ROL
1e30 : 06 1b __ ASL ACCU + 0 
1e32 : 2a __ __ ROL
1e33 : 85 1c __ STA ACCU + 1 
1e35 : 18 __ __ CLC
1e36 : a5 1b __ LDA ACCU + 0 
1e38 : 79 00 32 ADC $3200,y ; (Enemy + 0)
1e3b : 85 43 __ STA T2 + 0 
1e3d : 85 1b __ STA ACCU + 0 
1e3f : a5 1c __ LDA ACCU + 1 
1e41 : 69 c0 __ ADC #$c0
1e43 : 85 44 __ STA T2 + 1 
1e45 : 18 __ __ CLC
1e46 : 69 18 __ ADC #$18
1e48 : 85 1c __ STA ACCU + 1 
1e4a : b9 02 32 LDA $3202,y ; (Enemy + 2)
1e4d : a0 00 __ LDY #$00
1e4f : 91 43 __ STA (T2 + 0),y 
1e51 : a4 1d __ LDY ACCU + 2 
1e53 : b9 03 32 LDA $3203,y ; (Enemy + 3)
1e56 : a0 00 __ LDY #$00
1e58 : 91 1b __ STA (ACCU + 0),y 
.s19:
1e5a : e8 __ __ INX
1e5b : e0 0a __ CPX #$0a
1e5d : 90 a6 __ BCC $1e05 ; (render_enemies.l1006 + 0)
.s1001:
1e5f : 60 __ __ RTS
--------------------------------------------------------------------
check_shot_enemy_collision:
.s0:
1e60 : a2 00 __ LDX #$00
.l2:
1e62 : 86 1d __ STX ACCU + 2 
1e64 : bc 47 29 LDY $2947,x ; (__multab3L + 0)
1e67 : b9 f2 31 LDA $31f2,y ; (PlayerShot + 2)
1e6a : c9 01 __ CMP #$01
1e6c : d0 2e __ BNE $1e9c ; (check_shot_enemy_collision.s3 + 0)
.s5:
1e6e : a2 00 __ LDX #$00
.l9:
1e70 : 86 43 __ STX T2 + 0 
1e72 : bc 3d 29 LDY $293d,x ; (__multab5L + 0)
1e75 : b9 04 32 LDA $3204,y ; (Enemy + 4)
1e78 : c9 01 __ CMP #$01
1e7a : d0 19 __ BNE $1e95 ; (check_shot_enemy_collision.s114 + 0)
.s12:
1e7c : 84 1e __ STY ACCU + 3 
1e7e : b9 00 32 LDA $3200,y ; (Enemy + 0)
1e81 : a6 1d __ LDX ACCU + 2 
1e83 : bc 47 29 LDY $2947,x ; (__multab3L + 0)
1e86 : d9 f0 31 CMP $31f0,y ; (PlayerShot + 0)
1e89 : d0 0a __ BNE $1e95 ; (check_shot_enemy_collision.s114 + 0)
.s18:
1e8b : b9 f1 31 LDA $31f1,y ; (PlayerShot + 1)
1e8e : a6 1e __ LDX ACCU + 3 
1e90 : dd 01 32 CMP $3201,x ; (Enemy + 1)
1e93 : f0 0f __ BEQ $1ea4 ; (check_shot_enemy_collision.s15 + 0)
.s114:
1e95 : a6 43 __ LDX T2 + 0 
1e97 : e8 __ __ INX
1e98 : e0 0a __ CPX #$0a
1e9a : 90 d4 __ BCC $1e70 ; (check_shot_enemy_collision.l9 + 0)
.s3:
1e9c : a6 1d __ LDX ACCU + 2 
1e9e : e8 __ __ INX
1e9f : e0 03 __ CPX #$03
1ea1 : 90 bf __ BCC $1e62 ; (check_shot_enemy_collision.l2 + 0)
.s1001:
1ea3 : 60 __ __ RTS
.s15:
1ea4 : a9 08 __ LDA #$08
1ea6 : 8d 0b d4 STA $d40b 
1ea9 : a9 00 __ LDA #$00
1eab : 85 44 __ STA T3 + 0 
.l20:
1ead : a4 1e __ LDY ACCU + 3 
1eaf : b9 01 32 LDA $3201,y ; (Enemy + 1)
1eb2 : 0a __ __ ASL
1eb3 : 85 1b __ STA ACCU + 0 
1eb5 : a9 00 __ LDA #$00
1eb7 : 2a __ __ ROL
1eb8 : 06 1b __ ASL ACCU + 0 
1eba : 2a __ __ ROL
1ebb : aa __ __ TAX
1ebc : a5 1b __ LDA ACCU + 0 
1ebe : 79 01 32 ADC $3201,y ; (Enemy + 1)
1ec1 : 85 1b __ STA ACCU + 0 
1ec3 : 8a __ __ TXA
1ec4 : 69 00 __ ADC #$00
1ec6 : 06 1b __ ASL ACCU + 0 
1ec8 : 2a __ __ ROL
1ec9 : 06 1b __ ASL ACCU + 0 
1ecb : 2a __ __ ROL
1ecc : 06 1b __ ASL ACCU + 0 
1ece : 2a __ __ ROL
1ecf : aa __ __ TAX
1ed0 : 18 __ __ CLC
1ed1 : a5 1b __ LDA ACCU + 0 
1ed3 : 79 00 32 ADC $3200,y ; (Enemy + 0)
1ed6 : 85 1b __ STA ACCU + 0 
1ed8 : 8a __ __ TXA
1ed9 : 69 c0 __ ADC #$c0
1edb : 85 1c __ STA ACCU + 1 
1edd : 18 __ __ CLC
1ede : 69 18 __ ADC #$18
1ee0 : 85 20 __ STA ADDR + 1 
1ee2 : a9 86 __ LDA #$86
1ee4 : a0 00 __ LDY #$00
1ee6 : 84 1f __ STY ADDR + 0 
1ee8 : 91 1b __ STA (ACCU + 0),y 
1eea : a5 44 __ LDA T3 + 0 
1eec : a4 1b __ LDY ACCU + 0 
1eee : 91 1f __ STA (ADDR + 0),y 
1ef0 : aa __ __ TAX
1ef1 : bd 4a 29 LDA $294a,x ; (__multab2000L + 0)
1ef4 : 8d 00 d4 STA $d400 
1ef7 : bd 52 29 LDA $2952,x ; (__multab2000H + 0)
1efa : 8d 01 d4 STA $d401 
1efd : a9 35 __ LDA #$35
1eff : 8d 05 d4 STA $d405 
1f02 : a9 f1 __ LDA #$f1
1f04 : 8d 06 d4 STA $d406 
1f07 : a9 81 __ LDA #$81
1f09 : 8d 04 d4 STA $d404 
.l109:
1f0c : ad 11 d0 LDA $d011 
1f0f : 30 fb __ BMI $1f0c ; (check_shot_enemy_collision.l109 + 0)
.l27:
1f11 : ad 11 d0 LDA $d011 
1f14 : 10 fb __ BPL $1f11 ; (check_shot_enemy_collision.l27 + 0)
.s21:
1f16 : e6 44 __ INC T3 + 0 
1f18 : a5 44 __ LDA T3 + 0 
1f1a : c9 08 __ CMP #$08
1f1c : 90 8f __ BCC $1ead ; (check_shot_enemy_collision.l20 + 0)
.s22:
1f1e : a9 08 __ LDA #$08
1f20 : 8d 04 d4 STA $d404 
1f23 : a6 1e __ LDX ACCU + 3 
1f25 : bd 01 32 LDA $3201,x ; (Enemy + 1)
1f28 : 0a __ __ ASL
1f29 : 85 1b __ STA ACCU + 0 
1f2b : a9 00 __ LDA #$00
1f2d : 2a __ __ ROL
1f2e : 06 1b __ ASL ACCU + 0 
1f30 : 2a __ __ ROL
1f31 : a8 __ __ TAY
1f32 : a5 1b __ LDA ACCU + 0 
1f34 : 7d 01 32 ADC $3201,x ; (Enemy + 1)
1f37 : 85 1b __ STA ACCU + 0 
1f39 : 98 __ __ TYA
1f3a : 69 00 __ ADC #$00
1f3c : 06 1b __ ASL ACCU + 0 
1f3e : 2a __ __ ROL
1f3f : 06 1b __ ASL ACCU + 0 
1f41 : 2a __ __ ROL
1f42 : 06 1b __ ASL ACCU + 0 
1f44 : 2a __ __ ROL
1f45 : a8 __ __ TAY
1f46 : 18 __ __ CLC
1f47 : a5 1b __ LDA ACCU + 0 
1f49 : 7d 00 32 ADC $3200,x ; (Enemy + 0)
1f4c : 85 44 __ STA T3 + 0 
1f4e : 85 1f __ STA ADDR + 0 
1f50 : 98 __ __ TYA
1f51 : 69 c0 __ ADC #$c0
1f53 : 85 45 __ STA T3 + 1 
1f55 : 18 __ __ CLC
1f56 : 69 18 __ ADC #$18
1f58 : 85 20 __ STA ADDR + 1 
1f5a : a9 20 __ LDA #$20
1f5c : a0 00 __ LDY #$00
1f5e : 91 44 __ STA (T3 + 0),y 
1f60 : 98 __ __ TYA
1f61 : 91 1f __ STA (ADDR + 0),y 
1f63 : 9d 04 32 STA $3204,x ; (Enemy + 4)
1f66 : a6 1d __ LDX ACCU + 2 
1f68 : bc 47 29 LDY $2947,x ; (__multab3L + 0)
1f6b : 99 f2 31 STA $31f2,y ; (PlayerShot + 2)
1f6e : a6 1e __ LDX ACCU + 3 
1f70 : bd 02 32 LDA $3202,x ; (Enemy + 2)
1f73 : c9 83 __ CMP #$83
1f75 : f0 2b __ BEQ $1fa2 ; (check_shot_enemy_collision.s30 + 0)
.s31:
1f77 : c9 84 __ CMP #$84
1f79 : f0 03 __ BEQ $1f7e ; (check_shot_enemy_collision.s33 + 0)
1f7b : 4c 95 1e JMP $1e95 ; (check_shot_enemy_collision.s114 + 0)
.s33:
1f7e : ad da 31 LDA $31da ; (game + 1)
1f81 : 18 __ __ CLC
1f82 : 69 19 __ ADC #$19
.s118:
1f84 : 8d da 31 STA $31da ; (game + 1)
1f87 : ad db 31 LDA $31db ; (game + 2)
1f8a : 69 00 __ ADC #$00
1f8c : 8d db 31 STA $31db ; (game + 2)
1f8f : ad dc 31 LDA $31dc ; (game + 3)
1f92 : 69 00 __ ADC #$00
1f94 : 8d dc 31 STA $31dc ; (game + 3)
1f97 : b0 03 __ BCS $1f9c ; (check_shot_enemy_collision.s1019 + 0)
1f99 : 4c 95 1e JMP $1e95 ; (check_shot_enemy_collision.s114 + 0)
.s1019:
1f9c : ee dd 31 INC $31dd ; (game + 4)
1f9f : 4c 95 1e JMP $1e95 ; (check_shot_enemy_collision.s114 + 0)
.s30:
1fa2 : ad da 31 LDA $31da ; (game + 1)
1fa5 : 18 __ __ CLC
1fa6 : 69 32 __ ADC #$32
1fa8 : 4c 84 1f JMP $1f84 ; (check_shot_enemy_collision.s118 + 0)
--------------------------------------------------------------------
move_enemy_shots:
.s0:
1fab : a2 00 __ LDX #$00
.l1008:
1fad : bc 47 29 LDY $2947,x ; (__multab3L + 0)
1fb0 : b9 34 32 LDA $3234,y ; (EnemyShot + 2)
1fb3 : c9 01 __ CMP #$01
1fb5 : d0 58 __ BNE $200f ; (move_enemy_shots.s23 + 0)
.s5:
1fb7 : 84 1d __ STY ACCU + 2 
1fb9 : b9 33 32 LDA $3233,y ; (EnemyShot + 1)
1fbc : 0a __ __ ASL
1fbd : 85 1b __ STA ACCU + 0 
1fbf : a9 00 __ LDA #$00
1fc1 : 2a __ __ ROL
1fc2 : 06 1b __ ASL ACCU + 0 
1fc4 : 2a __ __ ROL
1fc5 : 85 1c __ STA ACCU + 1 
1fc7 : a5 1b __ LDA ACCU + 0 
1fc9 : 79 33 32 ADC $3233,y ; (EnemyShot + 1)
1fcc : 85 1b __ STA ACCU + 0 
1fce : a5 1c __ LDA ACCU + 1 
1fd0 : 69 00 __ ADC #$00
1fd2 : 06 1b __ ASL ACCU + 0 
1fd4 : 2a __ __ ROL
1fd5 : 06 1b __ ASL ACCU + 0 
1fd7 : 2a __ __ ROL
1fd8 : 06 1b __ ASL ACCU + 0 
1fda : 2a __ __ ROL
1fdb : 85 1c __ STA ACCU + 1 
1fdd : b9 32 32 LDA $3232,y ; (EnemyShot + 0)
1fe0 : 85 1e __ STA ACCU + 3 
1fe2 : 18 __ __ CLC
1fe3 : 65 1b __ ADC ACCU + 0 
1fe5 : 85 1b __ STA ACCU + 0 
1fe7 : 85 1f __ STA ADDR + 0 
1fe9 : a5 1c __ LDA ACCU + 1 
1feb : 69 c0 __ ADC #$c0
1fed : 85 1c __ STA ACCU + 1 
1fef : 18 __ __ CLC
1ff0 : 69 18 __ ADC #$18
1ff2 : 85 20 __ STA ADDR + 1 
1ff4 : a9 20 __ LDA #$20
1ff6 : a0 00 __ LDY #$00
1ff8 : 91 1b __ STA (ACCU + 0),y 
1ffa : 98 __ __ TYA
1ffb : 91 1f __ STA (ADDR + 0),y 
1ffd : c6 1e __ DEC ACCU + 3 
1fff : a5 1e __ LDA ACCU + 3 
2001 : a4 1d __ LDY ACCU + 2 
2003 : 99 32 32 STA $3232,y ; (EnemyShot + 0)
2006 : c9 ff __ CMP #$ff
2008 : d0 05 __ BNE $200f ; (move_enemy_shots.s23 + 0)
.s8:
200a : a9 00 __ LDA #$00
200c : 99 34 32 STA $3234,y ; (EnemyShot + 2)
.s23:
200f : e8 __ __ INX
2010 : e0 03 __ CPX #$03
2012 : 90 99 __ BCC $1fad ; (move_enemy_shots.l1008 + 0)
.s1001:
2014 : 60 __ __ RTS
--------------------------------------------------------------------
check_player_enemy_collision:
.s0:
2015 : a0 00 __ LDY #$00
.l2:
2017 : be 3d 29 LDX $293d,y ; (__multab5L + 0)
201a : bd 04 32 LDA $3204,x ; (Enemy + 4)
201d : c9 01 __ CMP #$01
201f : d0 17 __ BNE $2038 ; (check_player_enemy_collision.s3 + 0)
.s5:
2021 : bd 00 32 LDA $3200,x ; (Enemy + 0)
2024 : cd e9 31 CMP $31e9 ; (Player + 0)
2027 : d0 0f __ BNE $2038 ; (check_player_enemy_collision.s3 + 0)
.s11:
2029 : bd 01 32 LDA $3201,x ; (Enemy + 1)
202c : cd ea 31 CMP $31ea ; (Player + 1)
202f : d0 07 __ BNE $2038 ; (check_player_enemy_collision.s3 + 0)
.s8:
2031 : ad d9 31 LDA $31d9 ; (game + 0)
2034 : c9 03 __ CMP #$03
2036 : d0 37 __ BNE $206f ; (check_player_enemy_collision.s12 + 0)
.s3:
2038 : c8 __ __ INY
2039 : c0 0a __ CPY #$0a
203b : 90 da __ BCC $2017 ; (check_player_enemy_collision.l2 + 0)
.s31:
203d : a0 00 __ LDY #$00
.l17:
203f : be 47 29 LDX $2947,y ; (__multab3L + 0)
2042 : bd 34 32 LDA $3234,x ; (EnemyShot + 2)
2045 : c9 01 __ CMP #$01
2047 : d0 17 __ BNE $2060 ; (check_player_enemy_collision.s18 + 0)
.s20:
2049 : bd 32 32 LDA $3232,x ; (EnemyShot + 0)
204c : cd e9 31 CMP $31e9 ; (Player + 0)
204f : d0 0f __ BNE $2060 ; (check_player_enemy_collision.s18 + 0)
.s26:
2051 : bd 33 32 LDA $3233,x ; (EnemyShot + 1)
2054 : cd ea 31 CMP $31ea ; (Player + 1)
2057 : d0 07 __ BNE $2060 ; (check_player_enemy_collision.s18 + 0)
.s23:
2059 : ad d9 31 LDA $31d9 ; (game + 0)
205c : c9 03 __ CMP #$03
205e : d0 06 __ BNE $2066 ; (check_player_enemy_collision.s27 + 0)
.s18:
2060 : c8 __ __ INY
2061 : c0 03 __ CPY #$03
2063 : 90 da __ BCC $203f ; (check_player_enemy_collision.l17 + 0)
.s1001:
2065 : 60 __ __ RTS
.s27:
2066 : 20 79 20 JSR $2079 ; (render_player_dead.s0 + 0)
2069 : a9 03 __ LDA #$03
206b : 8d d9 31 STA $31d9 ; (game + 0)
206e : 60 __ __ RTS
.s12:
206f : 20 79 20 JSR $2079 ; (render_player_dead.s0 + 0)
2072 : a9 03 __ LDA #$03
2074 : 8d d9 31 STA $31d9 ; (game + 0)
2077 : d0 c4 __ BNE $203d ; (check_player_enemy_collision.s31 + 0)
--------------------------------------------------------------------
render_player_dead:
.s0:
2079 : a9 ff __ LDA #$ff
207b : 8d 18 d4 STA $d418 
207e : a9 10 __ LDA #$10
2080 : 8d 00 d4 STA $d400 
2083 : a9 27 __ LDA #$27
2085 : 8d 01 d4 STA $d401 
2088 : a9 3a __ LDA #$3a
208a : 8d 05 d4 STA $d405 
208d : a9 00 __ LDA #$00
208f : 8d 06 d4 STA $d406 
2092 : 8d 02 d4 STA $d402 
2095 : 8d fc 31 STA $31fc ; (EnemyShotSound + 3)
2098 : a9 08 __ LDA #$08
209a : 8d 03 d4 STA $d403 
209d : a9 81 __ LDA #$81
209f : 8d 04 d4 STA $d404 
20a2 : a9 08 __ LDA #$08
20a4 : 8d 0b d4 STA $d40b 
20a7 : ad ea 31 LDA $31ea ; (Player + 1)
20aa : 85 1e __ STA ACCU + 3 
20ac : ad e9 31 LDA $31e9 ; (Player + 0)
20af : 85 43 __ STA T2 + 0 
20b1 : a9 00 __ LDA #$00
20b3 : 85 1d __ STA ACCU + 2 
.l2:
20b5 : a9 ff __ LDA #$ff
20b7 : 85 44 __ STA T3 + 0 
.l6:
20b9 : 29 80 __ AND #$80
20bb : 10 02 __ BPL $20bf ; (render_player_dead.l6 + 6)
20bd : a9 ff __ LDA #$ff
20bf : aa __ __ TAX
20c0 : 18 __ __ CLC
20c1 : a5 44 __ LDA T3 + 0 
20c3 : 65 1e __ ADC ACCU + 3 
20c5 : a8 __ __ TAY
20c6 : 90 01 __ BCC $20c9 ; (render_player_dead.s1009 + 0)
.s1008:
20c8 : e8 __ __ INX
.s1009:
20c9 : 86 1c __ STX ACCU + 1 
20cb : 0a __ __ ASL
20cc : 85 1b __ STA ACCU + 0 
20ce : 8a __ __ TXA
20cf : 2a __ __ ROL
20d0 : 06 1b __ ASL ACCU + 0 
20d2 : 2a __ __ ROL
20d3 : aa __ __ TAX
20d4 : 98 __ __ TYA
20d5 : 18 __ __ CLC
20d6 : 65 1b __ ADC ACCU + 0 
20d8 : 85 1b __ STA ACCU + 0 
20da : 8a __ __ TXA
20db : 65 1c __ ADC ACCU + 1 
20dd : 06 1b __ ASL ACCU + 0 
20df : 2a __ __ ROL
20e0 : 06 1b __ ASL ACCU + 0 
20e2 : 2a __ __ ROL
20e3 : 06 1b __ ASL ACCU + 0 
20e5 : 2a __ __ ROL
20e6 : aa __ __ TAX
20e7 : 18 __ __ CLC
20e8 : a9 ff __ LDA #$ff
20ea : 65 1b __ ADC ACCU + 0 
20ec : a8 __ __ TAY
20ed : 8a __ __ TXA
20ee : 69 d7 __ ADC #$d7
20f0 : aa __ __ TAX
20f1 : 98 __ __ TYA
20f2 : 18 __ __ CLC
20f3 : 65 43 __ ADC T2 + 0 
20f5 : 85 1b __ STA ACCU + 0 
20f7 : 85 45 __ STA T5 + 0 
20f9 : 8a __ __ TXA
20fa : 69 00 __ ADC #$00
20fc : 85 1c __ STA ACCU + 1 
20fe : 18 __ __ CLC
20ff : 69 e8 __ ADC #$e8
2101 : 85 46 __ STA T5 + 1 
2103 : a0 00 __ LDY #$00
2105 : a2 03 __ LDX #$03
.l1006:
2107 : a9 86 __ LDA #$86
2109 : 91 45 __ STA (T5 + 0),y 
210b : a5 1d __ LDA ACCU + 2 
210d : 91 1b __ STA (ACCU + 0),y 
210f : e6 45 __ INC T5 + 0 
2111 : d0 02 __ BNE $2115 ; (render_player_dead.s1011 + 0)
.s1010:
2113 : e6 46 __ INC T5 + 1 
.s1011:
2115 : e6 1b __ INC ACCU + 0 
2117 : d0 02 __ BNE $211b ; (render_player_dead.s1013 + 0)
.s1012:
2119 : e6 1c __ INC ACCU + 1 
.s1013:
211b : ca __ __ DEX
211c : d0 e9 __ BNE $2107 ; (render_player_dead.l1006 + 0)
.s1007:
211e : e6 44 __ INC T3 + 0 
2120 : a5 44 __ LDA T3 + 0 
2122 : c9 02 __ CMP #$02
2124 : 90 93 __ BCC $20b9 ; (render_player_dead.l6 + 0)
.l14:
2126 : ad 11 d0 LDA $d011 
2129 : 30 fb __ BMI $2126 ; (render_player_dead.l14 + 0)
.l17:
212b : ad 11 d0 LDA $d011 
212e : 10 fb __ BPL $212b ; (render_player_dead.l17 + 0)
.s3:
2130 : e6 1d __ INC ACCU + 2 
2132 : a5 1d __ LDA ACCU + 2 
2134 : c9 32 __ CMP #$32
2136 : b0 03 __ BCS $213b ; (render_player_dead.s4 + 0)
2138 : 4c b5 20 JMP $20b5 ; (render_player_dead.l2 + 0)
.s4:
213b : a9 08 __ LDA #$08
213d : 8d 04 d4 STA $d404 
2140 : a9 00 __ LDA #$00
2142 : 8d ef 31 STA $31ef ; (PlayerShotSound + 3)
.s1001:
2145 : 60 __ __ RTS
--------------------------------------------------------------------
control_player_ship:
.s0:
2146 : a9 00 __ LDA #$00
2148 : 20 c0 18 JSR $18c0 ; (joy_poll.s0 + 0)
214b : ad e5 31 LDA $31e5 ; (joyx + 0)
214e : 85 1d __ STA ACCU + 2 
2150 : 85 1e __ STA ACCU + 3 
2152 : d0 08 __ BNE $215c ; (control_player_ship.s1 + 0)
.s4:
2154 : ad e3 31 LDA $31e3 ; (joyy + 0)
2157 : d0 03 __ BNE $215c ; (control_player_ship.s1 + 0)
2159 : 4c df 21 JMP $21df ; (control_player_ship.s3 + 0)
.s1:
215c : ad e9 31 LDA $31e9 ; (Player + 0)
215f : 85 43 __ STA T2 + 0 
2161 : 85 44 __ STA T3 + 0 
2163 : ad ea 31 LDA $31ea ; (Player + 1)
2166 : 85 45 __ STA T4 + 0 
2168 : 85 46 __ STA T5 + 0 
216a : 0a __ __ ASL
216b : 85 1b __ STA ACCU + 0 
216d : a9 00 __ LDA #$00
216f : 2a __ __ ROL
2170 : 06 1b __ ASL ACCU + 0 
2172 : 2a __ __ ROL
2173 : aa __ __ TAX
2174 : a5 1b __ LDA ACCU + 0 
2176 : 65 45 __ ADC T4 + 0 
2178 : 85 1b __ STA ACCU + 0 
217a : 8a __ __ TXA
217b : 69 00 __ ADC #$00
217d : 06 1b __ ASL ACCU + 0 
217f : 2a __ __ ROL
2180 : 06 1b __ ASL ACCU + 0 
2182 : 2a __ __ ROL
2183 : 06 1b __ ASL ACCU + 0 
2185 : 2a __ __ ROL
2186 : aa __ __ TAX
2187 : 18 __ __ CLC
2188 : a5 1b __ LDA ACCU + 0 
218a : 65 43 __ ADC T2 + 0 
218c : 85 1b __ STA ACCU + 0 
218e : 85 1f __ STA ADDR + 0 
2190 : 8a __ __ TXA
2191 : 69 c0 __ ADC #$c0
2193 : 85 1c __ STA ACCU + 1 
2195 : 18 __ __ CLC
2196 : 69 18 __ ADC #$18
2198 : 85 20 __ STA ADDR + 1 
219a : a9 20 __ LDA #$20
219c : a0 00 __ LDY #$00
219e : 91 1b __ STA (ACCU + 0),y 
21a0 : 98 __ __ TYA
21a1 : 91 1f __ STA (ADDR + 0),y 
21a3 : a5 43 __ LDA T2 + 0 
21a5 : c9 02 __ CMP #$02
21a7 : 90 06 __ BCC $21af ; (control_player_ship.s6 + 0)
.s8:
21a9 : a5 1d __ LDA ACCU + 2 
21ab : 30 0c __ BMI $21b9 ; (control_player_ship.s5 + 0)
.s1020:
21ad : a5 43 __ LDA T2 + 0 
.s6:
21af : c9 26 __ CMP #$26
21b1 : b0 0e __ BCS $21c1 ; (control_player_ship.s7 + 0)
.s12:
21b3 : a5 1d __ LDA ACCU + 2 
21b5 : 30 0a __ BMI $21c1 ; (control_player_ship.s7 + 0)
.s1013:
21b7 : f0 08 __ BEQ $21c1 ; (control_player_ship.s7 + 0)
.s5:
21b9 : 18 __ __ CLC
21ba : a5 44 __ LDA T3 + 0 
21bc : 65 1e __ ADC ACCU + 3 
21be : 8d e9 31 STA $31e9 ; (Player + 0)
.s7:
21c1 : a5 45 __ LDA T4 + 0 
21c3 : c9 05 __ CMP #$05
21c5 : 90 07 __ BCC $21ce ; (control_player_ship.s14 + 0)
.s16:
21c7 : ad e3 31 LDA $31e3 ; (joyy + 0)
21ca : 30 0d __ BMI $21d9 ; (control_player_ship.s37 + 0)
.s1019:
21cc : a5 45 __ LDA T4 + 0 
.s14:
21ce : c9 17 __ CMP #$17
21d0 : b0 0d __ BCS $21df ; (control_player_ship.s3 + 0)
.s20:
21d2 : ad e3 31 LDA $31e3 ; (joyy + 0)
21d5 : 30 08 __ BMI $21df ; (control_player_ship.s3 + 0)
.s1008:
21d7 : f0 06 __ BEQ $21df ; (control_player_ship.s3 + 0)
.s37:
21d9 : 18 __ __ CLC
21da : 65 46 __ ADC T5 + 0 
21dc : 8d ea 31 STA $31ea ; (Player + 1)
.s3:
21df : ad e7 31 LDA $31e7 ; (joyb + 0)
21e2 : c9 01 __ CMP #$01
21e4 : d0 0e __ BNE $21f4 ; (control_player_ship.s22 + 0)
.s24:
21e6 : ad eb 31 LDA $31eb ; (Player + 2)
21e9 : c9 01 __ CMP #$01
21eb : d0 07 __ BNE $21f4 ; (control_player_ship.s22 + 0)
.s21:
21ed : 20 01 22 JSR $2201 ; (spawn_player_shot.s0 + 0)
21f0 : a9 00 __ LDA #$00
21f2 : f0 09 __ BEQ $21fd ; (control_player_ship.s1018 + 0)
.s22:
21f4 : ad e7 31 LDA $31e7 ; (joyb + 0)
21f7 : c9 01 __ CMP #$01
21f9 : f0 05 __ BEQ $2200 ; (control_player_ship.s1001 + 0)
.s25:
21fb : a9 01 __ LDA #$01
.s1018:
21fd : 8d eb 31 STA $31eb ; (Player + 2)
.s1001:
2200 : 60 __ __ RTS
--------------------------------------------------------------------
spawn_player_shot:
.s0:
2201 : ad e9 31 LDA $31e9 ; (Player + 0)
2204 : c9 26 __ CMP #$26
2206 : f0 0f __ BEQ $2217 ; (spawn_player_shot.s1001 + 0)
.s3:
2208 : a0 00 __ LDY #$00
.l6:
220a : be 47 29 LDX $2947,y ; (__multab3L + 0)
220d : bd f2 31 LDA $31f2,x ; (PlayerShot + 2)
2210 : f0 06 __ BEQ $2218 ; (spawn_player_shot.s9 + 0)
.s7:
2212 : c8 __ __ INY
2213 : c0 03 __ CPY #$03
2215 : 90 f3 __ BCC $220a ; (spawn_player_shot.l6 + 0)
.s1001:
2217 : 60 __ __ RTS
.s9:
2218 : a9 01 __ LDA #$01
221a : 9d f2 31 STA $31f2,x ; (PlayerShot + 2)
221d : ad ea 31 LDA $31ea ; (Player + 1)
2220 : 9d f1 31 STA $31f1,x ; (PlayerShot + 1)
2223 : ad e5 31 LDA $31e5 ; (joyx + 0)
2226 : 30 02 __ BMI $222a ; (spawn_player_shot.s13 + 0)
.s1004:
2228 : d0 06 __ BNE $2230 ; (spawn_player_shot.s12 + 0)
.s13:
222a : ad e9 31 LDA $31e9 ; (Player + 0)
222d : 4c 36 22 JMP $2236 ; (spawn_player_shot.s14 + 0)
.s12:
2230 : ad e9 31 LDA $31e9 ; (Player + 0)
2233 : 18 __ __ CLC
2234 : 69 01 __ ADC #$01
.s14:
2236 : be 47 29 LDX $2947,y ; (__multab3L + 0)
2239 : 9d f0 31 STA $31f0,x ; (PlayerShot + 0)
223c : ad ef 31 LDA $31ef ; (PlayerShotSound + 3)
223f : d0 d6 __ BNE $2217 ; (spawn_player_shot.s1001 + 0)
.s15:
2241 : a9 01 __ LDA #$01
2243 : 8d ef 31 STA $31ef ; (PlayerShotSound + 3)
2246 : 60 __ __ RTS
--------------------------------------------------------------------
render_player_ship:
.s0:
2247 : ad ea 31 LDA $31ea ; (Player + 1)
224a : 0a __ __ ASL
224b : 85 1b __ STA ACCU + 0 
224d : a9 00 __ LDA #$00
224f : 2a __ __ ROL
2250 : 06 1b __ ASL ACCU + 0 
2252 : 2a __ __ ROL
2253 : aa __ __ TAX
2254 : a5 1b __ LDA ACCU + 0 
2256 : 6d ea 31 ADC $31ea ; (Player + 1)
2259 : 85 1b __ STA ACCU + 0 
225b : 8a __ __ TXA
225c : 69 00 __ ADC #$00
225e : 06 1b __ ASL ACCU + 0 
2260 : 2a __ __ ROL
2261 : 06 1b __ ASL ACCU + 0 
2263 : 2a __ __ ROL
2264 : 06 1b __ ASL ACCU + 0 
2266 : 2a __ __ ROL
2267 : aa __ __ TAX
2268 : 18 __ __ CLC
2269 : a5 1b __ LDA ACCU + 0 
226b : 6d e9 31 ADC $31e9 ; (Player + 0)
226e : 85 1b __ STA ACCU + 0 
2270 : 85 1f __ STA ADDR + 0 
2272 : 8a __ __ TXA
2273 : 69 c0 __ ADC #$c0
2275 : 85 1c __ STA ACCU + 1 
2277 : 18 __ __ CLC
2278 : 69 18 __ ADC #$18
227a : 85 20 __ STA ADDR + 1 
227c : a9 80 __ LDA #$80
227e : a0 00 __ LDY #$00
2280 : 91 1b __ STA (ACCU + 0),y 
2282 : a9 03 __ LDA #$03
2284 : 91 1f __ STA (ADDR + 0),y 
.s1001:
2286 : 60 __ __ RTS
--------------------------------------------------------------------
move_player_shots:
.s0:
2287 : a2 00 __ LDX #$00
.l2:
2289 : 86 1d __ STX ACCU + 2 
228b : bc 47 29 LDY $2947,x ; (__multab3L + 0)
228e : b9 f2 31 LDA $31f2,y ; (PlayerShot + 2)
2291 : c9 01 __ CMP #$01
2293 : d0 52 __ BNE $22e7 ; (move_player_shots.s23 + 0)
.s5:
2295 : 84 1e __ STY ACCU + 3 
2297 : b9 f1 31 LDA $31f1,y ; (PlayerShot + 1)
229a : 0a __ __ ASL
229b : 85 1b __ STA ACCU + 0 
229d : a9 00 __ LDA #$00
229f : 2a __ __ ROL
22a0 : 06 1b __ ASL ACCU + 0 
22a2 : 2a __ __ ROL
22a3 : aa __ __ TAX
22a4 : a5 1b __ LDA ACCU + 0 
22a6 : 79 f1 31 ADC $31f1,y ; (PlayerShot + 1)
22a9 : 85 1b __ STA ACCU + 0 
22ab : 8a __ __ TXA
22ac : 69 00 __ ADC #$00
22ae : 06 1b __ ASL ACCU + 0 
22b0 : 2a __ __ ROL
22b1 : 06 1b __ ASL ACCU + 0 
22b3 : 2a __ __ ROL
22b4 : 06 1b __ ASL ACCU + 0 
22b6 : 2a __ __ ROL
22b7 : 85 1c __ STA ACCU + 1 
22b9 : b9 f0 31 LDA $31f0,y ; (PlayerShot + 0)
22bc : aa __ __ TAX
22bd : 18 __ __ CLC
22be : 65 1b __ ADC ACCU + 0 
22c0 : 85 1b __ STA ACCU + 0 
22c2 : 85 1f __ STA ADDR + 0 
22c4 : a5 1c __ LDA ACCU + 1 
22c6 : 69 c0 __ ADC #$c0
22c8 : 85 1c __ STA ACCU + 1 
22ca : 18 __ __ CLC
22cb : 69 18 __ ADC #$18
22cd : 85 20 __ STA ADDR + 1 
22cf : a9 20 __ LDA #$20
22d1 : a0 00 __ LDY #$00
22d3 : 91 1b __ STA (ACCU + 0),y 
22d5 : 98 __ __ TYA
22d6 : 91 1f __ STA (ADDR + 0),y 
22d8 : e8 __ __ INX
22d9 : 8a __ __ TXA
22da : a6 1e __ LDX ACCU + 3 
22dc : 9d f0 31 STA $31f0,x ; (PlayerShot + 0)
22df : c9 27 __ CMP #$27
22e1 : 90 04 __ BCC $22e7 ; (move_player_shots.s23 + 0)
.s8:
22e3 : 98 __ __ TYA
22e4 : 9d f2 31 STA $31f2,x ; (PlayerShot + 2)
.s23:
22e7 : a6 1d __ LDX ACCU + 2 
22e9 : e8 __ __ INX
22ea : e0 03 __ CPX #$03
22ec : 90 9b __ BCC $2289 ; (move_player_shots.l2 + 0)
.s1001:
22ee : 60 __ __ RTS
--------------------------------------------------------------------
render_player_shots:
.s0:
22ef : a2 00 __ LDX #$00
.l1006:
22f1 : bc 47 29 LDY $2947,x ; (__multab3L + 0)
22f4 : b9 f2 31 LDA $31f2,y ; (PlayerShot + 2)
22f7 : c9 01 __ CMP #$01
22f9 : d0 43 __ BNE $233e ; (render_player_shots.s19 + 0)
.s5:
22fb : b9 f1 31 LDA $31f1,y ; (PlayerShot + 1)
22fe : 0a __ __ ASL
22ff : 85 1b __ STA ACCU + 0 
2301 : a9 00 __ LDA #$00
2303 : 2a __ __ ROL
2304 : 06 1b __ ASL ACCU + 0 
2306 : 2a __ __ ROL
2307 : 85 1c __ STA ACCU + 1 
2309 : a5 1b __ LDA ACCU + 0 
230b : 79 f1 31 ADC $31f1,y ; (PlayerShot + 1)
230e : 85 1b __ STA ACCU + 0 
2310 : a5 1c __ LDA ACCU + 1 
2312 : 69 00 __ ADC #$00
2314 : 06 1b __ ASL ACCU + 0 
2316 : 2a __ __ ROL
2317 : 06 1b __ ASL ACCU + 0 
2319 : 2a __ __ ROL
231a : 06 1b __ ASL ACCU + 0 
231c : 2a __ __ ROL
231d : 85 1c __ STA ACCU + 1 
231f : 18 __ __ CLC
2320 : a5 1b __ LDA ACCU + 0 
2322 : 79 f0 31 ADC $31f0,y ; (PlayerShot + 0)
2325 : 85 1b __ STA ACCU + 0 
2327 : 85 1f __ STA ADDR + 0 
2329 : a5 1c __ LDA ACCU + 1 
232b : 69 c0 __ ADC #$c0
232d : 85 1c __ STA ACCU + 1 
232f : 18 __ __ CLC
2330 : 69 18 __ ADC #$18
2332 : 85 20 __ STA ADDR + 1 
2334 : a9 81 __ LDA #$81
2336 : a0 00 __ LDY #$00
2338 : 91 1b __ STA (ACCU + 0),y 
233a : a9 01 __ LDA #$01
233c : 91 1f __ STA (ADDR + 0),y 
.s19:
233e : e8 __ __ INX
233f : e0 03 __ CPX #$03
2341 : 90 ae __ BCC $22f1 ; (render_player_shots.l1006 + 0)
.s1001:
2343 : 60 __ __ RTS
--------------------------------------------------------------------
show_game_over_screen:
.s1000:
2344 : a2 03 __ LDX #$03
2346 : b5 53 __ LDA T3 + 0,x 
2348 : 9d c6 9f STA $9fc6,x ; (show_game_over_screen@stack + 0)
234b : ca __ __ DEX
234c : 10 f8 __ BPL $2346 ; (show_game_over_screen.s1000 + 2)
234e : 38 __ __ SEC
234f : a5 23 __ LDA SP + 0 
2351 : e9 0a __ SBC #$0a
2353 : 85 23 __ STA SP + 0 
2355 : b0 02 __ BCS $2359 ; (show_game_over_screen.s0 + 0)
2357 : c6 24 __ DEC SP + 1 
.s0:
2359 : 20 4c 0b JSR $0b4c ; (clear_screen.s0 + 0)
235c : a9 05 __ LDA #$05
235e : 85 0f __ STA P2 
2360 : a9 02 __ LDA #$02
2362 : 85 10 __ STA P3 
2364 : a9 07 __ LDA #$07
2366 : 85 13 __ STA P6 
2368 : a9 cf __ LDA #$cf
236a : 85 0d __ STA P0 
236c : a9 31 __ LDA #$31
236e : 85 0e __ STA P1 
2370 : a9 5c __ LDA #$5c
2372 : 85 11 __ STA P4 
2374 : a9 24 __ LDA #$24
2376 : 85 12 __ STA P5 
2378 : 20 6e 18 JSR $186e ; (cwin_putat_string.s0 + 0)
237b : a9 03 __ LDA #$03
237d : 85 0f __ STA P2 
237f : 85 13 __ STA P6 
2381 : a9 04 __ LDA #$04
2383 : 85 10 __ STA P3 
2385 : a9 00 __ LDA #$00
2387 : 85 11 __ STA P4 
2389 : a9 1b __ LDA #$1b
238b : 85 12 __ STA P5 
238d : 20 6e 18 JSR $186e ; (cwin_putat_string.s0 + 0)
2390 : a9 ce __ LDA #$ce
2392 : a0 02 __ LDY #$02
2394 : 91 23 __ STA (SP + 0),y 
2396 : a9 9f __ LDA #$9f
2398 : c8 __ __ INY
2399 : 91 23 __ STA (SP + 0),y 
239b : a9 69 __ LDA #$69
239d : c8 __ __ INY
239e : 91 23 __ STA (SP + 0),y 
23a0 : a9 18 __ LDA #$18
23a2 : c8 __ __ INY
23a3 : 91 23 __ STA (SP + 0),y 
23a5 : ad dd 31 LDA $31dd ; (game + 4)
23a8 : 85 56 __ STA T3 + 3 
23aa : a0 09 __ LDY #$09
23ac : 91 23 __ STA (SP + 0),y 
23ae : ad da 31 LDA $31da ; (game + 1)
23b1 : 85 53 __ STA T3 + 0 
23b3 : a0 06 __ LDY #$06
23b5 : 91 23 __ STA (SP + 0),y 
23b7 : ad db 31 LDA $31db ; (game + 2)
23ba : 85 54 __ STA T3 + 1 
23bc : c8 __ __ INY
23bd : 91 23 __ STA (SP + 0),y 
23bf : ad dc 31 LDA $31dc ; (game + 3)
23c2 : 85 55 __ STA T3 + 2 
23c4 : c8 __ __ INY
23c5 : 91 23 __ STA (SP + 0),y 
23c7 : 20 a0 0b JSR $0ba0 ; (sprintf.s1000 + 0)
23ca : a9 cf __ LDA #$cf
23cc : 85 0d __ STA P0 
23ce : a9 31 __ LDA #$31
23d0 : 85 0e __ STA P1 
23d2 : a9 0a __ LDA #$0a
23d4 : 85 0f __ STA P2 
23d6 : a9 04 __ LDA #$04
23d8 : 85 10 __ STA P3 
23da : a9 ce __ LDA #$ce
23dc : 85 11 __ STA P4 
23de : a9 9f __ LDA #$9f
23e0 : 85 12 __ STA P5 
23e2 : a9 03 __ LDA #$03
23e4 : 85 13 __ STA P6 
23e6 : 20 6e 18 JSR $186e ; (cwin_putat_string.s0 + 0)
23e9 : a9 02 __ LDA #$02
23eb : 85 0f __ STA P2 
23ed : a9 06 __ LDA #$06
23ef : 85 10 __ STA P3 
23f1 : a9 04 __ LDA #$04
23f3 : 85 13 __ STA P6 
23f5 : a5 56 __ LDA T3 + 3 
23f7 : 49 80 __ EOR #$80
23f9 : 85 03 __ STA WORK + 0 
23fb : ad e1 31 LDA $31e1 ; (game + 8)
23fe : 49 80 __ EOR #$80
2400 : c5 03 __ CMP WORK + 0 
2402 : d0 13 __ BNE $2417 ; (show_game_over_screen.s1005 + 0)
.s1002:
2404 : ad e0 31 LDA $31e0 ; (game + 7)
2407 : c5 55 __ CMP T3 + 2 
2409 : d0 0c __ BNE $2417 ; (show_game_over_screen.s1005 + 0)
.s1003:
240b : ad df 31 LDA $31df ; (game + 6)
240e : c5 54 __ CMP T3 + 1 
2410 : d0 05 __ BNE $2417 ; (show_game_over_screen.s1005 + 0)
.s1004:
2412 : ad de 31 LDA $31de ; (game + 5)
2415 : c5 53 __ CMP T3 + 0 
.s1005:
2417 : 90 0e __ BCC $2427 ; (show_game_over_screen.s1 + 0)
.s2:
2419 : a9 77 __ LDA #$77
241b : 85 11 __ STA P4 
241d : a9 24 __ LDA #$24
241f : 85 12 __ STA P5 
2421 : 20 6e 18 JSR $186e ; (cwin_putat_string.s0 + 0)
2424 : 4c 46 24 JMP $2446 ; (show_game_over_screen.s1001 + 0)
.s1:
2427 : a9 66 __ LDA #$66
2429 : 85 11 __ STA P4 
242b : a9 24 __ LDA #$24
242d : 85 12 __ STA P5 
242f : 20 6e 18 JSR $186e ; (cwin_putat_string.s0 + 0)
2432 : a5 53 __ LDA T3 + 0 
2434 : 8d de 31 STA $31de ; (game + 5)
2437 : a5 54 __ LDA T3 + 1 
2439 : 8d df 31 STA $31df ; (game + 6)
243c : a5 55 __ LDA T3 + 2 
243e : 8d e0 31 STA $31e0 ; (game + 7)
2441 : a5 56 __ LDA T3 + 3 
2443 : 8d e1 31 STA $31e1 ; (game + 8)
.s1001:
2446 : 18 __ __ CLC
2447 : a5 23 __ LDA SP + 0 
2449 : 69 0a __ ADC #$0a
244b : 85 23 __ STA SP + 0 
244d : 90 02 __ BCC $2451 ; (show_game_over_screen.s1001 + 11)
244f : e6 24 __ INC SP + 1 
2451 : a2 03 __ LDX #$03
2453 : bd c6 9f LDA $9fc6,x ; (show_game_over_screen@stack + 0)
2456 : 95 53 __ STA T3 + 0,x 
2458 : ca __ __ DEX
2459 : 10 f8 __ BPL $2453 ; (show_game_over_screen.s1001 + 13)
245b : 60 __ __ RTS
--------------------------------------------------------------------
245c : __ __ __ BYT 47 41 4d 45 20 4f 56 45 52 00                   : GAME OVER.
--------------------------------------------------------------------
2466 : __ __ __ BYT 41 20 4e 45 57 20 48 49 47 48 53 43 4f 52 45 21 : A NEW HIGHSCORE!
2476 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
2477 : __ __ __ BYT 4e 4f 20 4e 45 57 20 48 49 47 48 53 43 4f 52 45 : NO NEW HIGHSCORE
2487 : __ __ __ BYT 2e 00                                           : ..
--------------------------------------------------------------------
freg:
2489 : b1 19 __ LDA (IP + 0),y 
248b : c8 __ __ INY
248c : aa __ __ TAX
248d : b5 00 __ LDA $00,x 
248f : 85 03 __ STA WORK + 0 
2491 : b5 01 __ LDA $01,x 
2493 : 85 04 __ STA WORK + 1 
2495 : b5 02 __ LDA $02,x 
2497 : 85 05 __ STA WORK + 2 
2499 : b5 03 __ LDA WORK + 0,x 
249b : 85 06 __ STA WORK + 3 
249d : a5 05 __ LDA WORK + 2 
249f : 0a __ __ ASL
24a0 : a5 06 __ LDA WORK + 3 
24a2 : 2a __ __ ROL
24a3 : 85 08 __ STA WORK + 5 
24a5 : f0 06 __ BEQ $24ad ; (freg + 36)
24a7 : a5 05 __ LDA WORK + 2 
24a9 : 09 80 __ ORA #$80
24ab : 85 05 __ STA WORK + 2 
24ad : a5 1d __ LDA ACCU + 2 
24af : 0a __ __ ASL
24b0 : a5 1e __ LDA ACCU + 3 
24b2 : 2a __ __ ROL
24b3 : 85 07 __ STA WORK + 4 
24b5 : f0 06 __ BEQ $24bd ; (freg + 52)
24b7 : a5 1d __ LDA ACCU + 2 
24b9 : 09 80 __ ORA #$80
24bb : 85 1d __ STA ACCU + 2 
24bd : 60 __ __ RTS
24be : 06 1e __ ASL ACCU + 3 
24c0 : a5 07 __ LDA WORK + 4 
24c2 : 6a __ __ ROR
24c3 : 85 1e __ STA ACCU + 3 
24c5 : b0 06 __ BCS $24cd ; (freg + 68)
24c7 : a5 1d __ LDA ACCU + 2 
24c9 : 29 7f __ AND #$7f
24cb : 85 1d __ STA ACCU + 2 
24cd : 60 __ __ RTS
--------------------------------------------------------------------
faddsub:
24ce : a9 ff __ LDA #$ff
24d0 : c5 07 __ CMP WORK + 4 
24d2 : f0 04 __ BEQ $24d8 ; (faddsub + 10)
24d4 : c5 08 __ CMP WORK + 5 
24d6 : d0 11 __ BNE $24e9 ; (faddsub + 27)
24d8 : a5 1e __ LDA ACCU + 3 
24da : 09 7f __ ORA #$7f
24dc : 85 1e __ STA ACCU + 3 
24de : a9 80 __ LDA #$80
24e0 : 85 1d __ STA ACCU + 2 
24e2 : a9 00 __ LDA #$00
24e4 : 85 1b __ STA ACCU + 0 
24e6 : 85 1c __ STA ACCU + 1 
24e8 : 60 __ __ RTS
24e9 : 38 __ __ SEC
24ea : a5 07 __ LDA WORK + 4 
24ec : e5 08 __ SBC WORK + 5 
24ee : f0 38 __ BEQ $2528 ; (faddsub + 90)
24f0 : aa __ __ TAX
24f1 : b0 25 __ BCS $2518 ; (faddsub + 74)
24f3 : e0 e9 __ CPX #$e9
24f5 : b0 0e __ BCS $2505 ; (faddsub + 55)
24f7 : a5 08 __ LDA WORK + 5 
24f9 : 85 07 __ STA WORK + 4 
24fb : a9 00 __ LDA #$00
24fd : 85 1b __ STA ACCU + 0 
24ff : 85 1c __ STA ACCU + 1 
2501 : 85 1d __ STA ACCU + 2 
2503 : f0 23 __ BEQ $2528 ; (faddsub + 90)
2505 : a5 1d __ LDA ACCU + 2 
2507 : 4a __ __ LSR
2508 : 66 1c __ ROR ACCU + 1 
250a : 66 1b __ ROR ACCU + 0 
250c : e8 __ __ INX
250d : d0 f8 __ BNE $2507 ; (faddsub + 57)
250f : 85 1d __ STA ACCU + 2 
2511 : a5 08 __ LDA WORK + 5 
2513 : 85 07 __ STA WORK + 4 
2515 : 4c 28 25 JMP $2528 ; (faddsub + 90)
2518 : e0 18 __ CPX #$18
251a : b0 33 __ BCS $254f ; (faddsub + 129)
251c : a5 05 __ LDA WORK + 2 
251e : 4a __ __ LSR
251f : 66 04 __ ROR WORK + 1 
2521 : 66 03 __ ROR WORK + 0 
2523 : ca __ __ DEX
2524 : d0 f8 __ BNE $251e ; (faddsub + 80)
2526 : 85 05 __ STA WORK + 2 
2528 : a5 1e __ LDA ACCU + 3 
252a : 29 80 __ AND #$80
252c : 85 1e __ STA ACCU + 3 
252e : 45 06 __ EOR WORK + 3 
2530 : 30 31 __ BMI $2563 ; (faddsub + 149)
2532 : 18 __ __ CLC
2533 : a5 1b __ LDA ACCU + 0 
2535 : 65 03 __ ADC WORK + 0 
2537 : 85 1b __ STA ACCU + 0 
2539 : a5 1c __ LDA ACCU + 1 
253b : 65 04 __ ADC WORK + 1 
253d : 85 1c __ STA ACCU + 1 
253f : a5 1d __ LDA ACCU + 2 
2541 : 65 05 __ ADC WORK + 2 
2543 : 85 1d __ STA ACCU + 2 
2545 : 90 08 __ BCC $254f ; (faddsub + 129)
2547 : 66 1d __ ROR ACCU + 2 
2549 : 66 1c __ ROR ACCU + 1 
254b : 66 1b __ ROR ACCU + 0 
254d : e6 07 __ INC WORK + 4 
254f : a5 07 __ LDA WORK + 4 
2551 : c9 ff __ CMP #$ff
2553 : f0 83 __ BEQ $24d8 ; (faddsub + 10)
2555 : 4a __ __ LSR
2556 : 05 1e __ ORA ACCU + 3 
2558 : 85 1e __ STA ACCU + 3 
255a : b0 06 __ BCS $2562 ; (faddsub + 148)
255c : a5 1d __ LDA ACCU + 2 
255e : 29 7f __ AND #$7f
2560 : 85 1d __ STA ACCU + 2 
2562 : 60 __ __ RTS
2563 : 38 __ __ SEC
2564 : a5 1b __ LDA ACCU + 0 
2566 : e5 03 __ SBC WORK + 0 
2568 : 85 1b __ STA ACCU + 0 
256a : a5 1c __ LDA ACCU + 1 
256c : e5 04 __ SBC WORK + 1 
256e : 85 1c __ STA ACCU + 1 
2570 : a5 1d __ LDA ACCU + 2 
2572 : e5 05 __ SBC WORK + 2 
2574 : 85 1d __ STA ACCU + 2 
2576 : b0 19 __ BCS $2591 ; (faddsub + 195)
2578 : 38 __ __ SEC
2579 : a9 00 __ LDA #$00
257b : e5 1b __ SBC ACCU + 0 
257d : 85 1b __ STA ACCU + 0 
257f : a9 00 __ LDA #$00
2581 : e5 1c __ SBC ACCU + 1 
2583 : 85 1c __ STA ACCU + 1 
2585 : a9 00 __ LDA #$00
2587 : e5 1d __ SBC ACCU + 2 
2589 : 85 1d __ STA ACCU + 2 
258b : a5 1e __ LDA ACCU + 3 
258d : 49 80 __ EOR #$80
258f : 85 1e __ STA ACCU + 3 
2591 : a5 1d __ LDA ACCU + 2 
2593 : 30 ba __ BMI $254f ; (faddsub + 129)
2595 : 05 1c __ ORA ACCU + 1 
2597 : 05 1b __ ORA ACCU + 0 
2599 : f0 0f __ BEQ $25aa ; (faddsub + 220)
259b : c6 07 __ DEC WORK + 4 
259d : f0 0b __ BEQ $25aa ; (faddsub + 220)
259f : 06 1b __ ASL ACCU + 0 
25a1 : 26 1c __ ROL ACCU + 1 
25a3 : 26 1d __ ROL ACCU + 2 
25a5 : 10 f4 __ BPL $259b ; (faddsub + 205)
25a7 : 4c 4f 25 JMP $254f ; (faddsub + 129)
25aa : a9 00 __ LDA #$00
25ac : 85 1b __ STA ACCU + 0 
25ae : 85 1c __ STA ACCU + 1 
25b0 : 85 1d __ STA ACCU + 2 
25b2 : 85 1e __ STA ACCU + 3 
25b4 : 60 __ __ RTS
--------------------------------------------------------------------
fmul:
25b5 : a5 1b __ LDA ACCU + 0 
25b7 : 05 1c __ ORA ACCU + 1 
25b9 : 05 1d __ ORA ACCU + 2 
25bb : d0 03 __ BNE $25c0 ; (fmul + 11)
25bd : 85 1e __ STA ACCU + 3 
25bf : 60 __ __ RTS
25c0 : a5 03 __ LDA WORK + 0 
25c2 : 05 04 __ ORA WORK + 1 
25c4 : 05 05 __ ORA WORK + 2 
25c6 : d0 09 __ BNE $25d1 ; (fmul + 28)
25c8 : 85 1b __ STA ACCU + 0 
25ca : 85 1c __ STA ACCU + 1 
25cc : 85 1d __ STA ACCU + 2 
25ce : 85 1e __ STA ACCU + 3 
25d0 : 60 __ __ RTS
25d1 : a5 1e __ LDA ACCU + 3 
25d3 : 45 06 __ EOR WORK + 3 
25d5 : 29 80 __ AND #$80
25d7 : 85 1e __ STA ACCU + 3 
25d9 : a9 ff __ LDA #$ff
25db : c5 07 __ CMP WORK + 4 
25dd : f0 42 __ BEQ $2621 ; (fmul + 108)
25df : c5 08 __ CMP WORK + 5 
25e1 : f0 3e __ BEQ $2621 ; (fmul + 108)
25e3 : a9 00 __ LDA #$00
25e5 : 85 09 __ STA WORK + 6 
25e7 : 85 0a __ STA WORK + 7 
25e9 : 85 0b __ STA $0b 
25eb : a4 1b __ LDY ACCU + 0 
25ed : a5 03 __ LDA WORK + 0 
25ef : d0 06 __ BNE $25f7 ; (fmul + 66)
25f1 : a5 04 __ LDA WORK + 1 
25f3 : f0 0a __ BEQ $25ff ; (fmul + 74)
25f5 : d0 05 __ BNE $25fc ; (fmul + 71)
25f7 : 20 56 26 JSR $2656 ; (fmul8 + 0)
25fa : a5 04 __ LDA WORK + 1 
25fc : 20 56 26 JSR $2656 ; (fmul8 + 0)
25ff : a5 05 __ LDA WORK + 2 
2601 : 20 56 26 JSR $2656 ; (fmul8 + 0)
2604 : 38 __ __ SEC
2605 : a5 0b __ LDA $0b 
2607 : 30 06 __ BMI $260f ; (fmul + 90)
2609 : 06 09 __ ASL WORK + 6 
260b : 26 0a __ ROL WORK + 7 
260d : 2a __ __ ROL
260e : 18 __ __ CLC
260f : 29 7f __ AND #$7f
2611 : 85 0b __ STA $0b 
2613 : a5 07 __ LDA WORK + 4 
2615 : 65 08 __ ADC WORK + 5 
2617 : 90 19 __ BCC $2632 ; (fmul + 125)
2619 : e9 7f __ SBC #$7f
261b : b0 04 __ BCS $2621 ; (fmul + 108)
261d : c9 ff __ CMP #$ff
261f : d0 15 __ BNE $2636 ; (fmul + 129)
2621 : a5 1e __ LDA ACCU + 3 
2623 : 09 7f __ ORA #$7f
2625 : 85 1e __ STA ACCU + 3 
2627 : a9 80 __ LDA #$80
2629 : 85 1d __ STA ACCU + 2 
262b : a9 00 __ LDA #$00
262d : 85 1b __ STA ACCU + 0 
262f : 85 1c __ STA ACCU + 1 
2631 : 60 __ __ RTS
2632 : e9 7e __ SBC #$7e
2634 : 90 15 __ BCC $264b ; (fmul + 150)
2636 : 4a __ __ LSR
2637 : 05 1e __ ORA ACCU + 3 
2639 : 85 1e __ STA ACCU + 3 
263b : a9 00 __ LDA #$00
263d : 6a __ __ ROR
263e : 05 0b __ ORA $0b 
2640 : 85 1d __ STA ACCU + 2 
2642 : a5 0a __ LDA WORK + 7 
2644 : 85 1c __ STA ACCU + 1 
2646 : a5 09 __ LDA WORK + 6 
2648 : 85 1b __ STA ACCU + 0 
264a : 60 __ __ RTS
264b : a9 00 __ LDA #$00
264d : 85 1b __ STA ACCU + 0 
264f : 85 1c __ STA ACCU + 1 
2651 : 85 1d __ STA ACCU + 2 
2653 : 85 1e __ STA ACCU + 3 
2655 : 60 __ __ RTS
--------------------------------------------------------------------
fmul8:
2656 : 38 __ __ SEC
2657 : 6a __ __ ROR
2658 : 90 1e __ BCC $2678 ; (fmul8 + 34)
265a : aa __ __ TAX
265b : 18 __ __ CLC
265c : 98 __ __ TYA
265d : 65 09 __ ADC WORK + 6 
265f : 85 09 __ STA WORK + 6 
2661 : a5 0a __ LDA WORK + 7 
2663 : 65 1c __ ADC ACCU + 1 
2665 : 85 0a __ STA WORK + 7 
2667 : a5 0b __ LDA $0b 
2669 : 65 1d __ ADC ACCU + 2 
266b : 6a __ __ ROR
266c : 85 0b __ STA $0b 
266e : 8a __ __ TXA
266f : 66 0a __ ROR WORK + 7 
2671 : 66 09 __ ROR WORK + 6 
2673 : 4a __ __ LSR
2674 : f0 0d __ BEQ $2683 ; (fmul8 + 45)
2676 : b0 e2 __ BCS $265a ; (fmul8 + 4)
2678 : 66 0b __ ROR $0b 
267a : 66 0a __ ROR WORK + 7 
267c : 66 09 __ ROR WORK + 6 
267e : 4a __ __ LSR
267f : 90 f7 __ BCC $2678 ; (fmul8 + 34)
2681 : d0 d7 __ BNE $265a ; (fmul8 + 4)
2683 : 60 __ __ RTS
--------------------------------------------------------------------
fdiv:
2684 : a5 1b __ LDA ACCU + 0 
2686 : 05 1c __ ORA ACCU + 1 
2688 : 05 1d __ ORA ACCU + 2 
268a : d0 03 __ BNE $268f ; (fdiv + 11)
268c : 85 1e __ STA ACCU + 3 
268e : 60 __ __ RTS
268f : a5 1e __ LDA ACCU + 3 
2691 : 45 06 __ EOR WORK + 3 
2693 : 29 80 __ AND #$80
2695 : 85 1e __ STA ACCU + 3 
2697 : a5 08 __ LDA WORK + 5 
2699 : f0 62 __ BEQ $26fd ; (fdiv + 121)
269b : a5 07 __ LDA WORK + 4 
269d : c9 ff __ CMP #$ff
269f : f0 5c __ BEQ $26fd ; (fdiv + 121)
26a1 : a9 00 __ LDA #$00
26a3 : 85 09 __ STA WORK + 6 
26a5 : 85 0a __ STA WORK + 7 
26a7 : 85 0b __ STA $0b 
26a9 : a2 18 __ LDX #$18
26ab : a5 1b __ LDA ACCU + 0 
26ad : c5 03 __ CMP WORK + 0 
26af : a5 1c __ LDA ACCU + 1 
26b1 : e5 04 __ SBC WORK + 1 
26b3 : a5 1d __ LDA ACCU + 2 
26b5 : e5 05 __ SBC WORK + 2 
26b7 : 90 13 __ BCC $26cc ; (fdiv + 72)
26b9 : a5 1b __ LDA ACCU + 0 
26bb : e5 03 __ SBC WORK + 0 
26bd : 85 1b __ STA ACCU + 0 
26bf : a5 1c __ LDA ACCU + 1 
26c1 : e5 04 __ SBC WORK + 1 
26c3 : 85 1c __ STA ACCU + 1 
26c5 : a5 1d __ LDA ACCU + 2 
26c7 : e5 05 __ SBC WORK + 2 
26c9 : 85 1d __ STA ACCU + 2 
26cb : 38 __ __ SEC
26cc : 26 09 __ ROL WORK + 6 
26ce : 26 0a __ ROL WORK + 7 
26d0 : 26 0b __ ROL $0b 
26d2 : ca __ __ DEX
26d3 : f0 0a __ BEQ $26df ; (fdiv + 91)
26d5 : 06 1b __ ASL ACCU + 0 
26d7 : 26 1c __ ROL ACCU + 1 
26d9 : 26 1d __ ROL ACCU + 2 
26db : b0 dc __ BCS $26b9 ; (fdiv + 53)
26dd : 90 cc __ BCC $26ab ; (fdiv + 39)
26df : 38 __ __ SEC
26e0 : a5 0b __ LDA $0b 
26e2 : 30 06 __ BMI $26ea ; (fdiv + 102)
26e4 : 06 09 __ ASL WORK + 6 
26e6 : 26 0a __ ROL WORK + 7 
26e8 : 2a __ __ ROL
26e9 : 18 __ __ CLC
26ea : 29 7f __ AND #$7f
26ec : 85 0b __ STA $0b 
26ee : a5 07 __ LDA WORK + 4 
26f0 : e5 08 __ SBC WORK + 5 
26f2 : 90 1a __ BCC $270e ; (fdiv + 138)
26f4 : 18 __ __ CLC
26f5 : 69 7f __ ADC #$7f
26f7 : b0 04 __ BCS $26fd ; (fdiv + 121)
26f9 : c9 ff __ CMP #$ff
26fb : d0 15 __ BNE $2712 ; (fdiv + 142)
26fd : a5 1e __ LDA ACCU + 3 
26ff : 09 7f __ ORA #$7f
2701 : 85 1e __ STA ACCU + 3 
2703 : a9 80 __ LDA #$80
2705 : 85 1d __ STA ACCU + 2 
2707 : a9 00 __ LDA #$00
2709 : 85 1c __ STA ACCU + 1 
270b : 85 1b __ STA ACCU + 0 
270d : 60 __ __ RTS
270e : 69 7f __ ADC #$7f
2710 : 90 15 __ BCC $2727 ; (fdiv + 163)
2712 : 4a __ __ LSR
2713 : 05 1e __ ORA ACCU + 3 
2715 : 85 1e __ STA ACCU + 3 
2717 : a9 00 __ LDA #$00
2719 : 6a __ __ ROR
271a : 05 0b __ ORA $0b 
271c : 85 1d __ STA ACCU + 2 
271e : a5 0a __ LDA WORK + 7 
2720 : 85 1c __ STA ACCU + 1 
2722 : a5 09 __ LDA WORK + 6 
2724 : 85 1b __ STA ACCU + 0 
2726 : 60 __ __ RTS
2727 : a9 00 __ LDA #$00
2729 : 85 1e __ STA ACCU + 3 
272b : 85 1d __ STA ACCU + 2 
272d : 85 1c __ STA ACCU + 1 
272f : 85 1b __ STA ACCU + 0 
2731 : 60 __ __ RTS
--------------------------------------------------------------------
divs16:
2732 : 24 1c __ BIT ACCU + 1 
2734 : 10 0d __ BPL $2743 ; (divs16 + 17)
2736 : 20 50 27 JSR $2750 ; (negaccu + 0)
2739 : 24 04 __ BIT WORK + 1 
273b : 10 0d __ BPL $274a ; (divs16 + 24)
273d : 20 5e 27 JSR $275e ; (negtmp + 0)
2740 : 4c 6c 27 JMP $276c ; (divmod + 0)
2743 : 24 04 __ BIT WORK + 1 
2745 : 10 f9 __ BPL $2740 ; (divs16 + 14)
2747 : 20 5e 27 JSR $275e ; (negtmp + 0)
274a : 20 6c 27 JSR $276c ; (divmod + 0)
274d : 4c 50 27 JMP $2750 ; (negaccu + 0)
--------------------------------------------------------------------
negaccu:
2750 : 38 __ __ SEC
2751 : a9 00 __ LDA #$00
2753 : e5 1b __ SBC ACCU + 0 
2755 : 85 1b __ STA ACCU + 0 
2757 : a9 00 __ LDA #$00
2759 : e5 1c __ SBC ACCU + 1 
275b : 85 1c __ STA ACCU + 1 
275d : 60 __ __ RTS
--------------------------------------------------------------------
negtmp:
275e : 38 __ __ SEC
275f : a9 00 __ LDA #$00
2761 : e5 03 __ SBC WORK + 0 
2763 : 85 03 __ STA WORK + 0 
2765 : a9 00 __ LDA #$00
2767 : e5 04 __ SBC WORK + 1 
2769 : 85 04 __ STA WORK + 1 
276b : 60 __ __ RTS
--------------------------------------------------------------------
divmod:
276c : a5 1c __ LDA ACCU + 1 
276e : d0 31 __ BNE $27a1 ; (divmod + 53)
2770 : a5 04 __ LDA WORK + 1 
2772 : d0 1e __ BNE $2792 ; (divmod + 38)
2774 : 85 06 __ STA WORK + 3 
2776 : a2 04 __ LDX #$04
2778 : 06 1b __ ASL ACCU + 0 
277a : 2a __ __ ROL
277b : c5 03 __ CMP WORK + 0 
277d : 90 02 __ BCC $2781 ; (divmod + 21)
277f : e5 03 __ SBC WORK + 0 
2781 : 26 1b __ ROL ACCU + 0 
2783 : 2a __ __ ROL
2784 : c5 03 __ CMP WORK + 0 
2786 : 90 02 __ BCC $278a ; (divmod + 30)
2788 : e5 03 __ SBC WORK + 0 
278a : 26 1b __ ROL ACCU + 0 
278c : ca __ __ DEX
278d : d0 eb __ BNE $277a ; (divmod + 14)
278f : 85 05 __ STA WORK + 2 
2791 : 60 __ __ RTS
2792 : a5 1b __ LDA ACCU + 0 
2794 : 85 05 __ STA WORK + 2 
2796 : a5 1c __ LDA ACCU + 1 
2798 : 85 06 __ STA WORK + 3 
279a : a9 00 __ LDA #$00
279c : 85 1b __ STA ACCU + 0 
279e : 85 1c __ STA ACCU + 1 
27a0 : 60 __ __ RTS
27a1 : a5 04 __ LDA WORK + 1 
27a3 : d0 1f __ BNE $27c4 ; (divmod + 88)
27a5 : a5 03 __ LDA WORK + 0 
27a7 : 30 1b __ BMI $27c4 ; (divmod + 88)
27a9 : a9 00 __ LDA #$00
27ab : 85 06 __ STA WORK + 3 
27ad : a2 10 __ LDX #$10
27af : 06 1b __ ASL ACCU + 0 
27b1 : 26 1c __ ROL ACCU + 1 
27b3 : 2a __ __ ROL
27b4 : c5 03 __ CMP WORK + 0 
27b6 : 90 02 __ BCC $27ba ; (divmod + 78)
27b8 : e5 03 __ SBC WORK + 0 
27ba : 26 1b __ ROL ACCU + 0 
27bc : 26 1c __ ROL ACCU + 1 
27be : ca __ __ DEX
27bf : d0 f2 __ BNE $27b3 ; (divmod + 71)
27c1 : 85 05 __ STA WORK + 2 
27c3 : 60 __ __ RTS
27c4 : a9 00 __ LDA #$00
27c6 : 85 05 __ STA WORK + 2 
27c8 : 85 06 __ STA WORK + 3 
27ca : 84 02 __ STY $02 
27cc : a0 10 __ LDY #$10
27ce : 18 __ __ CLC
27cf : 26 1b __ ROL ACCU + 0 
27d1 : 26 1c __ ROL ACCU + 1 
27d3 : 26 05 __ ROL WORK + 2 
27d5 : 26 06 __ ROL WORK + 3 
27d7 : 38 __ __ SEC
27d8 : a5 05 __ LDA WORK + 2 
27da : e5 03 __ SBC WORK + 0 
27dc : aa __ __ TAX
27dd : a5 06 __ LDA WORK + 3 
27df : e5 04 __ SBC WORK + 1 
27e1 : 90 04 __ BCC $27e7 ; (divmod + 123)
27e3 : 86 05 __ STX WORK + 2 
27e5 : 85 06 __ STA WORK + 3 
27e7 : 88 __ __ DEY
27e8 : d0 e5 __ BNE $27cf ; (divmod + 99)
27ea : 26 1b __ ROL ACCU + 0 
27ec : 26 1c __ ROL ACCU + 1 
27ee : a4 02 __ LDY $02 
27f0 : 60 __ __ RTS
--------------------------------------------------------------------
mods16:
27f1 : 24 1c __ BIT ACCU + 1 
27f3 : 10 0d __ BPL $2802 ; (mods16 + 17)
27f5 : 20 50 27 JSR $2750 ; (negaccu + 0)
27f8 : 24 04 __ BIT WORK + 1 
27fa : 10 0d __ BPL $2809 ; (mods16 + 24)
27fc : 20 5e 27 JSR $275e ; (negtmp + 0)
27ff : 4c 6c 27 JMP $276c ; (divmod + 0)
2802 : 24 04 __ BIT WORK + 1 
2804 : 10 f9 __ BPL $27ff ; (mods16 + 14)
2806 : 20 5e 27 JSR $275e ; (negtmp + 0)
2809 : 20 6c 27 JSR $276c ; (divmod + 0)
280c : 38 __ __ SEC
280d : a9 00 __ LDA #$00
280f : e5 05 __ SBC WORK + 2 
2811 : 85 05 __ STA WORK + 2 
2813 : a9 00 __ LDA #$00
2815 : e5 06 __ SBC WORK + 3 
2817 : 85 06 __ STA WORK + 3 
2819 : 60 __ __ RTS
--------------------------------------------------------------------
f32_to_i16:
281a : 20 ad 24 JSR $24ad ; (freg + 36)
281d : a5 07 __ LDA WORK + 4 
281f : c9 7f __ CMP #$7f
2821 : b0 07 __ BCS $282a ; (f32_to_i16 + 16)
2823 : a9 00 __ LDA #$00
2825 : 85 1b __ STA ACCU + 0 
2827 : 85 1c __ STA ACCU + 1 
2829 : 60 __ __ RTS
282a : 38 __ __ SEC
282b : e9 8e __ SBC #$8e
282d : 90 0a __ BCC $2839 ; (f32_to_i16 + 31)
282f : a9 ff __ LDA #$ff
2831 : 85 1b __ STA ACCU + 0 
2833 : a9 7f __ LDA #$7f
2835 : 85 1c __ STA ACCU + 1 
2837 : d0 08 __ BNE $2841 ; (f32_to_i16 + 39)
2839 : aa __ __ TAX
283a : 46 1d __ LSR ACCU + 2 
283c : 66 1c __ ROR ACCU + 1 
283e : e8 __ __ INX
283f : d0 f9 __ BNE $283a ; (f32_to_i16 + 32)
2841 : 24 1e __ BIT ACCU + 3 
2843 : 10 0e __ BPL $2853 ; (f32_to_i16 + 57)
2845 : 38 __ __ SEC
2846 : a9 00 __ LDA #$00
2848 : e5 1c __ SBC ACCU + 1 
284a : 85 1b __ STA ACCU + 0 
284c : a9 00 __ LDA #$00
284e : e5 1d __ SBC ACCU + 2 
2850 : 85 1c __ STA ACCU + 1 
2852 : 60 __ __ RTS
2853 : a5 1c __ LDA ACCU + 1 
2855 : 85 1b __ STA ACCU + 0 
2857 : a5 1d __ LDA ACCU + 2 
2859 : 85 1c __ STA ACCU + 1 
285b : 60 __ __ RTS
--------------------------------------------------------------------
sint16_to_float:
285c : 24 1c __ BIT ACCU + 1 
285e : 30 03 __ BMI $2863 ; (sint16_to_float + 7)
2860 : 4c 7a 28 JMP $287a ; (uint16_to_float + 0)
2863 : 38 __ __ SEC
2864 : a9 00 __ LDA #$00
2866 : e5 1b __ SBC ACCU + 0 
2868 : 85 1b __ STA ACCU + 0 
286a : a9 00 __ LDA #$00
286c : e5 1c __ SBC ACCU + 1 
286e : 85 1c __ STA ACCU + 1 
2870 : 20 7a 28 JSR $287a ; (uint16_to_float + 0)
2873 : a5 1e __ LDA ACCU + 3 
2875 : 09 80 __ ORA #$80
2877 : 85 1e __ STA ACCU + 3 
2879 : 60 __ __ RTS
--------------------------------------------------------------------
uint16_to_float:
287a : a5 1b __ LDA ACCU + 0 
287c : 05 1c __ ORA ACCU + 1 
287e : d0 05 __ BNE $2885 ; (uint16_to_float + 11)
2880 : 85 1d __ STA ACCU + 2 
2882 : 85 1e __ STA ACCU + 3 
2884 : 60 __ __ RTS
2885 : a2 8e __ LDX #$8e
2887 : a5 1c __ LDA ACCU + 1 
2889 : 30 06 __ BMI $2891 ; (uint16_to_float + 23)
288b : ca __ __ DEX
288c : 06 1b __ ASL ACCU + 0 
288e : 2a __ __ ROL
288f : 10 fa __ BPL $288b ; (uint16_to_float + 17)
2891 : 29 7f __ AND #$7f
2893 : 85 1d __ STA ACCU + 2 
2895 : a5 1b __ LDA ACCU + 0 
2897 : 85 1c __ STA ACCU + 1 
2899 : 8a __ __ TXA
289a : 4a __ __ LSR
289b : 85 1e __ STA ACCU + 3 
289d : a9 00 __ LDA #$00
289f : 85 1b __ STA ACCU + 0 
28a1 : 6a __ __ ROR
28a2 : 05 1d __ ORA ACCU + 2 
28a4 : 85 1d __ STA ACCU + 2 
28a6 : 60 __ __ RTS
--------------------------------------------------------------------
divmod32:
28a7 : 84 02 __ STY $02 
28a9 : a0 20 __ LDY #$20
28ab : a9 00 __ LDA #$00
28ad : 85 07 __ STA WORK + 4 
28af : 85 08 __ STA WORK + 5 
28b1 : 85 09 __ STA WORK + 6 
28b3 : 85 0a __ STA WORK + 7 
28b5 : a5 05 __ LDA WORK + 2 
28b7 : 05 06 __ ORA WORK + 3 
28b9 : d0 39 __ BNE $28f4 ; (divmod32 + 77)
28bb : 18 __ __ CLC
28bc : 26 1b __ ROL ACCU + 0 
28be : 26 1c __ ROL ACCU + 1 
28c0 : 26 1d __ ROL ACCU + 2 
28c2 : 26 1e __ ROL ACCU + 3 
28c4 : 26 07 __ ROL WORK + 4 
28c6 : 26 08 __ ROL WORK + 5 
28c8 : 90 0c __ BCC $28d6 ; (divmod32 + 47)
28ca : a5 07 __ LDA WORK + 4 
28cc : e5 03 __ SBC WORK + 0 
28ce : aa __ __ TAX
28cf : a5 08 __ LDA WORK + 5 
28d1 : e5 04 __ SBC WORK + 1 
28d3 : 38 __ __ SEC
28d4 : b0 0c __ BCS $28e2 ; (divmod32 + 59)
28d6 : 38 __ __ SEC
28d7 : a5 07 __ LDA WORK + 4 
28d9 : e5 03 __ SBC WORK + 0 
28db : aa __ __ TAX
28dc : a5 08 __ LDA WORK + 5 
28de : e5 04 __ SBC WORK + 1 
28e0 : 90 04 __ BCC $28e6 ; (divmod32 + 63)
28e2 : 86 07 __ STX WORK + 4 
28e4 : 85 08 __ STA WORK + 5 
28e6 : 88 __ __ DEY
28e7 : d0 d3 __ BNE $28bc ; (divmod32 + 21)
28e9 : 26 1b __ ROL ACCU + 0 
28eb : 26 1c __ ROL ACCU + 1 
28ed : 26 1d __ ROL ACCU + 2 
28ef : 26 1e __ ROL ACCU + 3 
28f1 : a4 02 __ LDY $02 
28f3 : 60 __ __ RTS
28f4 : 18 __ __ CLC
28f5 : 26 1b __ ROL ACCU + 0 
28f7 : 26 1c __ ROL ACCU + 1 
28f9 : 26 1d __ ROL ACCU + 2 
28fb : 26 1e __ ROL ACCU + 3 
28fd : 26 07 __ ROL WORK + 4 
28ff : 26 08 __ ROL WORK + 5 
2901 : 26 09 __ ROL WORK + 6 
2903 : 26 0a __ ROL WORK + 7 
2905 : a5 07 __ LDA WORK + 4 
2907 : c5 03 __ CMP WORK + 0 
2909 : a5 08 __ LDA WORK + 5 
290b : e5 04 __ SBC WORK + 1 
290d : a5 09 __ LDA WORK + 6 
290f : e5 05 __ SBC WORK + 2 
2911 : a5 0a __ LDA WORK + 7 
2913 : e5 06 __ SBC WORK + 3 
2915 : 90 18 __ BCC $292f ; (divmod32 + 136)
2917 : a5 07 __ LDA WORK + 4 
2919 : e5 03 __ SBC WORK + 0 
291b : 85 07 __ STA WORK + 4 
291d : a5 08 __ LDA WORK + 5 
291f : e5 04 __ SBC WORK + 1 
2921 : 85 08 __ STA WORK + 5 
2923 : a5 09 __ LDA WORK + 6 
2925 : e5 05 __ SBC WORK + 2 
2927 : 85 09 __ STA WORK + 6 
2929 : a5 0a __ LDA WORK + 7 
292b : e5 06 __ SBC WORK + 3 
292d : 85 0a __ STA WORK + 7 
292f : 88 __ __ DEY
2930 : d0 c3 __ BNE $28f5 ; (divmod32 + 78)
2932 : 26 1b __ ROL ACCU + 0 
2934 : 26 1c __ ROL ACCU + 1 
2936 : 26 1d __ ROL ACCU + 2 
2938 : 26 1e __ ROL ACCU + 3 
293a : a4 02 __ LDY $02 
293c : 60 __ __ RTS
--------------------------------------------------------------------
__multab5L:
293d : __ __ __ BYT 00 05 0a 0f 14 19 1e 23 28 2d                   : .......#(-
--------------------------------------------------------------------
__multab3L:
2947 : __ __ __ BYT 00 03 06                                        : ...
--------------------------------------------------------------------
__multab2000L:
294a : __ __ __ BYT 00 d0 a0 70 40 10 e0 b0                         : ...p@...
--------------------------------------------------------------------
__multab2000H:
2952 : __ __ __ BYT 00 07 0f 17 1f 27 2e 36                         : .....'.6
