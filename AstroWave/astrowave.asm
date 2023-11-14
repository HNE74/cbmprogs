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
080e : 8e fe 08 STX $08fe ; (spentry + 0)
0811 : a9 1c __ LDA #$1c
0813 : 85 19 __ STA IP + 0 
0815 : a9 26 __ LDA #$26
0817 : 85 1a __ STA IP + 1 
0819 : 38 __ __ SEC
081a : a9 26 __ LDA #$26
081c : e9 26 __ SBC #$26
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
0830 : a9 6c __ LDA #$6c
0832 : e9 1c __ SBC #$1c
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
084b : a9 cb __ LDA #$cb
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
08fe : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
main:
.s0:
0880 : a9 00 __ LDA #$00
0882 : 8d f4 25 STA $25f4 ; (game + 0)
0885 : 20 97 08 JSR $0897 ; (redefine_charset.s0 + 0)
.l3:
0888 : 20 b4 09 JSR $09b4 ; (main_loop.s0 + 0)
088b : ad f4 25 LDA $25f4 ; (game + 0)
088e : f0 f8 __ BEQ $0888 ; (main.l3 + 0)
.s4:
0890 : a9 00 __ LDA #$00
0892 : 85 1b __ STA ACCU + 0 
0894 : 85 1c __ STA ACCU + 1 
.s1001:
0896 : 60 __ __ RTS
--------------------------------------------------------------------
game:
25f4 : __ __ __ BSS	6
--------------------------------------------------------------------
redefine_charset:
.s0:
0897 : 20 d7 08 JSR $08d7 ; (mmap_trampoline.s0 + 0)
089a : a9 31 __ LDA #$31
089c : 85 01 __ STA $01 
089e : a9 00 __ LDA #$00
08a0 : 85 11 __ STA P4 
08a2 : 85 0d __ STA P0 
08a4 : 85 0f __ STA P2 
08a6 : a9 08 __ LDA #$08
08a8 : 85 12 __ STA P5 
08aa : a9 c8 __ LDA #$c8
08ac : 85 0e __ STA P1 
08ae : a9 d0 __ LDA #$d0
08b0 : 85 10 __ STA P3 
08b2 : 20 2e 09 JSR $092e ; (memcpy.s0 + 0)
08b5 : a2 38 __ LDX #$38
.l1002:
08b7 : bd 7f 25 LDA $257f,x ; (__multab3L + 2)
08ba : 9d ff cb STA $cbff,x 
08bd : ca __ __ DEX
08be : d0 f7 __ BNE $08b7 ; (redefine_charset.l1002 + 0)
.s1003:
08c0 : a9 37 __ LDA #$37
08c2 : 85 01 __ STA $01 
08c4 : a9 00 __ LDA #$00
08c6 : 85 0d __ STA P0 
08c8 : 85 0e __ STA P1 
08ca : 85 10 __ STA P3 
08cc : a9 c8 __ LDA #$c8
08ce : 85 11 __ STA P4 
08d0 : a9 c0 __ LDA #$c0
08d2 : 85 0f __ STA P2 
08d4 : 4c 5d 09 JMP $095d ; (vic_setmode.s0 + 0)
--------------------------------------------------------------------
mmap_trampoline:
.s0:
08d7 : a9 00 __ LDA #$00
08d9 : 8d fa ff STA $fffa 
08dc : a9 09 __ LDA #$09
08de : 8d fb ff STA $fffb 
08e1 : a9 17 __ LDA #$17
08e3 : 8d fe ff STA $fffe 
08e6 : a9 09 __ LDA #$09
08e8 : 8d ff ff STA $ffff 
.s1001:
08eb : 60 __ __ RTS
--------------------------------------------------------------------
NMITrampoline:
0900 : 48 __ __ PHA
0901 : 8a __ __ TXA
0902 : 48 __ __ PHA
0903 : a9 08 __ LDA #$08
0905 : 48 __ __ PHA
0906 : a9 ec __ LDA #$ec
0908 : 48 __ __ PHA
0909 : ba __ __ TSX
090a : bd 05 01 LDA $0105,x 
090d : 48 __ __ PHA
090e : a6 01 __ LDX $01 
0910 : a9 36 __ LDA #$36
0912 : 85 01 __ STA $01 
0914 : 6c fa ff JMP ($fffa)
--------------------------------------------------------------------
DoneTrampoline:
08ec : 86 01 __ STX $01 
08ee : 68 __ __ PLA
08ef : aa __ __ TAX
08f0 : 68 __ __ PLA
08f1 : 40 __ __ RTI
08f2 : 60 __ __ RTS
--------------------------------------------------------------------
IRQTrampoline:
0917 : 48 __ __ PHA
0918 : 8a __ __ TXA
0919 : 48 __ __ PHA
091a : a9 08 __ LDA #$08
091c : 48 __ __ PHA
091d : a9 ec __ LDA #$ec
091f : 48 __ __ PHA
0920 : ba __ __ TSX
0921 : bd 05 01 LDA $0105,x 
0924 : 48 __ __ PHA
0925 : a6 01 __ LDX $01 
0927 : a9 36 __ LDA #$36
0929 : 85 01 __ STA $01 
092b : 6c fe ff JMP ($fffe)
--------------------------------------------------------------------
memcpy:
.s0:
092e : a6 12 __ LDX P5 
0930 : f0 10 __ BEQ $0942 ; (memcpy.s0 + 20)
0932 : a0 00 __ LDY #$00
0934 : b1 0f __ LDA (P2),y 
0936 : 91 0d __ STA (P0),y ; (dst + 0)
0938 : c8 __ __ INY
0939 : d0 f9 __ BNE $0934 ; (memcpy.s0 + 6)
093b : e6 10 __ INC P3 
093d : e6 0e __ INC P1 ; (dst + 1)
093f : ca __ __ DEX
0940 : d0 f2 __ BNE $0934 ; (memcpy.s0 + 6)
0942 : a4 11 __ LDY P4 
0944 : f0 0e __ BEQ $0954 ; (memcpy.s0 + 38)
0946 : 88 __ __ DEY
0947 : f0 07 __ BEQ $0950 ; (memcpy.s0 + 34)
0949 : b1 0f __ LDA (P2),y 
094b : 91 0d __ STA (P0),y ; (dst + 0)
094d : 88 __ __ DEY
094e : d0 f9 __ BNE $0949 ; (memcpy.s0 + 27)
0950 : b1 0f __ LDA (P2),y 
0952 : 91 0d __ STA (P0),y ; (dst + 0)
0954 : a5 0d __ LDA P0 ; (dst + 0)
0956 : 85 1b __ STA ACCU + 0 
0958 : a5 0e __ LDA P1 ; (dst + 1)
095a : 85 1c __ STA ACCU + 1 
.s1001:
095c : 60 __ __ RTS
--------------------------------------------------------------------
ChrRedef:
2580 : __ __ __ BYT 80 e0 f8 7f 7f f8 e0 80 00 00 60 3e 3e 60 00 00 : ..........`>>`..
2590 : __ __ __ BYT 00 00 3c 66 66 3c 00 00 1c 7f c6 1f 1f c6 7f 1c : ..<ff<..........
25a0 : __ __ __ BYT 00 3c 7e d5 ab 7e 3c 00 28 3c 6e df 5f fe 3c 14 : .<~..~<.(<n._.<.
25b0 : __ __ __ BYT 28 56 65 92 69 36 44 2a                         : (Ve.i6D*
--------------------------------------------------------------------
vic_setmode:
.s0:
095d : a6 0f __ LDX P2 ; (text + 1)
095f : a4 0d __ LDY P0 ; (mode + 0)
0961 : c0 02 __ CPY #$02
0963 : d0 07 __ BNE $096c ; (vic_setmode.s15 + 0)
.s6:
0965 : a9 5b __ LDA #$5b
0967 : 8d 11 d0 STA $d011 
096a : d0 0d __ BNE $0979 ; (vic_setmode.s23 + 0)
.s15:
096c : c0 02 __ CPY #$02
096e : 90 39 __ BCC $09a9 ; (vic_setmode.s17 + 0)
.s16:
0970 : a9 3b __ LDA #$3b
0972 : 8d 11 d0 STA $d011 
0975 : c0 03 __ CPY #$03
0977 : d0 04 __ BNE $097d ; (vic_setmode.s1009 + 0)
.s23:
0979 : a9 08 __ LDA #$08
097b : d0 02 __ BNE $097f ; (vic_setmode.s1 + 0)
.s1009:
097d : a9 18 __ LDA #$18
.s1:
097f : 8d 16 d0 STA $d016 
0982 : ad 00 dd LDA $dd00 
0985 : 29 fc __ AND #$fc
0987 : 85 1b __ STA ACCU + 0 
0989 : 8a __ __ TXA
098a : 0a __ __ ASL
098b : 2a __ __ ROL
098c : 29 01 __ AND #$01
098e : 2a __ __ ROL
098f : 49 03 __ EOR #$03
0991 : 05 1b __ ORA ACCU + 0 
0993 : 8d 00 dd STA $dd00 
0996 : 8a __ __ TXA
0997 : 0a __ __ ASL
0998 : 0a __ __ ASL
0999 : 29 f0 __ AND #$f0
099b : 85 1b __ STA ACCU + 0 
099d : a5 11 __ LDA P4 ; (font + 1)
099f : 4a __ __ LSR
09a0 : 4a __ __ LSR
09a1 : 29 0e __ AND #$0e
09a3 : 05 1b __ ORA ACCU + 0 
09a5 : 8d 18 d0 STA $d018 
.s1001:
09a8 : 60 __ __ RTS
.s17:
09a9 : a9 1b __ LDA #$1b
09ab : 8d 11 d0 STA $d011 
09ae : 98 __ __ TYA
09af : d0 cc __ BNE $097d ; (vic_setmode.s1009 + 0)
09b1 : 4c 79 09 JMP $0979 ; (vic_setmode.s23 + 0)
--------------------------------------------------------------------
main_loop:
.s0:
09b4 : 20 dd 09 JSR $09dd ; (init_game_state.s0 + 0)
09b7 : 20 f6 09 JSR $09f6 ; (prepare_game_screen.s0 + 0)
.l1:
09ba : 20 75 0a JSR $0a75 ; (clear_screen.s0 + 0)
09bd : 20 f3 08 JSR $08f3 ; (init_player.s0 + 0)
09c0 : 20 c9 0a JSR $0ac9 ; (init_enemies.s0 + 0)
09c3 : 20 e1 0a JSR $0ae1 ; (init_shots.s0 + 0)
09c6 : 20 08 0b JSR $0b08 ; (run_game.s1000 + 0)
09c9 : ae f9 25 LDX $25f9 ; (game + 5)
09cc : ce f9 25 DEC $25f9 ; (game + 5)
09cf : 8a __ __ TXA
09d0 : f0 07 __ BEQ $09d9 ; (main_loop.s3 + 0)
.s4:
09d2 : a9 01 __ LDA #$01
09d4 : 8d f4 25 STA $25f4 ; (game + 0)
09d7 : d0 e1 __ BNE $09ba ; (main_loop.l1 + 0)
.s3:
09d9 : 8d f4 25 STA $25f4 ; (game + 0)
.s1001:
09dc : 60 __ __ RTS
--------------------------------------------------------------------
init_game_state:
.s0:
09dd : a9 01 __ LDA #$01
09df : 8d f4 25 STA $25f4 ; (game + 0)
09e2 : a9 00 __ LDA #$00
09e4 : 8d f5 25 STA $25f5 ; (game + 1)
09e7 : 8d f6 25 STA $25f6 ; (game + 2)
09ea : 8d f7 25 STA $25f7 ; (game + 3)
09ed : 8d f8 25 STA $25f8 ; (game + 4)
09f0 : a9 03 __ LDA #$03
09f2 : 8d f9 25 STA $25f9 ; (game + 5)
.s1001:
09f5 : 60 __ __ RTS
--------------------------------------------------------------------
prepare_game_screen:
.s0:
09f6 : a9 0b __ LDA #$0b
09f8 : 8d 20 d0 STA $d020 
09fb : a9 00 __ LDA #$00
09fd : 8d 21 d0 STA $d021 
0a00 : 85 11 __ STA P4 
0a02 : 85 12 __ STA P5 
0a04 : a9 28 __ LDA #$28
0a06 : 85 13 __ STA P6 
0a08 : a9 03 __ LDA #$03
0a0a : 85 14 __ STA P7 
0a0c : a9 1c __ LDA #$1c
0a0e : 85 0d __ STA P0 
0a10 : a9 26 __ LDA #$26
0a12 : 85 0e __ STA P1 
0a14 : a9 00 __ LDA #$00
0a16 : 85 0f __ STA P2 
0a18 : a9 c0 __ LDA #$c0
0a1a : 85 10 __ STA P3 
0a1c : 4c 1f 0a JMP $0a1f ; (cwin_init.s0 + 0)
--------------------------------------------------------------------
cwin_init:
.s0:
0a1f : a9 00 __ LDA #$00
0a21 : a0 04 __ LDY #$04
0a23 : 91 0d __ STA (P0),y ; (win + 0)
0a25 : c8 __ __ INY
0a26 : 91 0d __ STA (P0),y ; (win + 0)
0a28 : a5 11 __ LDA P4 ; (sx + 0)
0a2a : a0 00 __ LDY #$00
0a2c : 91 0d __ STA (P0),y ; (win + 0)
0a2e : a5 12 __ LDA P5 ; (sy + 0)
0a30 : c8 __ __ INY
0a31 : 91 0d __ STA (P0),y ; (win + 0)
0a33 : a5 13 __ LDA P6 ; (wx + 0)
0a35 : c8 __ __ INY
0a36 : 91 0d __ STA (P0),y ; (win + 0)
0a38 : a5 14 __ LDA P7 ; (wy + 0)
0a3a : c8 __ __ INY
0a3b : 91 0d __ STA (P0),y ; (win + 0)
0a3d : a5 12 __ LDA P5 ; (sy + 0)
0a3f : 0a __ __ ASL
0a40 : a8 __ __ TAY
0a41 : b9 b8 25 LDA $25b8,y ; (mul40 + 0)
0a44 : 85 1b __ STA ACCU + 0 
0a46 : 18 __ __ CLC
0a47 : 65 11 __ ADC P4 ; (sx + 0)
0a49 : aa __ __ TAX
0a4a : b9 b9 25 LDA $25b9,y ; (mul40 + 1)
0a4d : 85 1c __ STA ACCU + 1 
0a4f : 69 d8 __ ADC #$d8
0a51 : a0 09 __ LDY #$09
0a53 : 91 0d __ STA (P0),y ; (win + 0)
0a55 : 8a __ __ TXA
0a56 : 88 __ __ DEY
0a57 : 91 0d __ STA (P0),y ; (win + 0)
0a59 : 18 __ __ CLC
0a5a : a5 0f __ LDA P2 ; (screen + 0)
0a5c : 65 1b __ ADC ACCU + 0 
0a5e : aa __ __ TAX
0a5f : a5 10 __ LDA P3 ; (screen + 1)
0a61 : 65 1c __ ADC ACCU + 1 
0a63 : 85 10 __ STA P3 ; (screen + 1)
0a65 : 8a __ __ TXA
0a66 : 18 __ __ CLC
0a67 : 65 11 __ ADC P4 ; (sx + 0)
0a69 : a0 06 __ LDY #$06
0a6b : 91 0d __ STA (P0),y ; (win + 0)
0a6d : a5 10 __ LDA P3 ; (screen + 1)
0a6f : 69 00 __ ADC #$00
0a71 : c8 __ __ INY
0a72 : 91 0d __ STA (P0),y ; (win + 0)
.s1001:
0a74 : 60 __ __ RTS
--------------------------------------------------------------------
mul40:
25b8 : __ __ __ BYT 00 00 28 00 50 00 78 00 a0 00 c8 00 f0 00 18 01 : ..(.P.x.........
25c8 : __ __ __ BYT 40 01 68 01 90 01 b8 01 e0 01 08 02 30 02 58 02 : @.h.........0.X.
25d8 : __ __ __ BYT 80 02 a8 02 d0 02 f8 02 20 03 48 03 70 03 98 03 : ........ .H.p...
25e8 : __ __ __ BYT c0 03                                           : ..
--------------------------------------------------------------------
cwTop:
261c : __ __ __ BSS	10
--------------------------------------------------------------------
clear_screen:
.s0:
0a75 : a9 20 __ LDA #$20
0a77 : 85 0f __ STA P2 
0a79 : a9 00 __ LDA #$00
0a7b : 85 10 __ STA P3 
0a7d : 85 0d __ STA P0 
0a7f : a9 e8 __ LDA #$e8
0a81 : 85 11 __ STA P4 
0a83 : a9 03 __ LDA #$03
0a85 : 85 12 __ STA P5 
0a87 : a9 c0 __ LDA #$c0
0a89 : 85 0e __ STA P1 
0a8b : 20 a5 0a JSR $0aa5 ; (memset.s0 + 0)
0a8e : a9 00 __ LDA #$00
0a90 : 85 0f __ STA P2 
0a92 : 85 10 __ STA P3 
0a94 : 85 0d __ STA P0 
0a96 : a9 e8 __ LDA #$e8
0a98 : 85 11 __ STA P4 
0a9a : a9 03 __ LDA #$03
0a9c : 85 12 __ STA P5 
0a9e : a9 d8 __ LDA #$d8
0aa0 : 85 0e __ STA P1 
0aa2 : 4c a5 0a JMP $0aa5 ; (memset.s0 + 0)
--------------------------------------------------------------------
memset:
.s0:
0aa5 : a5 0f __ LDA P2 
0aa7 : a6 12 __ LDX P5 
0aa9 : f0 0c __ BEQ $0ab7 ; (memset.s0 + 18)
0aab : a0 00 __ LDY #$00
0aad : 91 0d __ STA (P0),y ; (dst + 0)
0aaf : c8 __ __ INY
0ab0 : d0 fb __ BNE $0aad ; (memset.s0 + 8)
0ab2 : e6 0e __ INC P1 ; (dst + 1)
0ab4 : ca __ __ DEX
0ab5 : d0 f6 __ BNE $0aad ; (memset.s0 + 8)
0ab7 : a4 11 __ LDY P4 
0ab9 : f0 05 __ BEQ $0ac0 ; (memset.s0 + 27)
0abb : 88 __ __ DEY
0abc : 91 0d __ STA (P0),y ; (dst + 0)
0abe : d0 fb __ BNE $0abb ; (memset.s0 + 22)
0ac0 : a5 0d __ LDA P0 ; (dst + 0)
0ac2 : 85 1b __ STA ACCU + 0 
0ac4 : a5 0e __ LDA P1 ; (dst + 1)
0ac6 : 85 1c __ STA ACCU + 1 
.s1001:
0ac8 : 60 __ __ RTS
--------------------------------------------------------------------
init_player:
.s0:
08f3 : a9 05 __ LDA #$05
08f5 : 8d fa 25 STA $25fa ; (Player + 0)
08f8 : a9 0c __ LDA #$0c
08fa : 8d fb 25 STA $25fb ; (Player + 1)
.s1001:
08fd : 60 __ __ RTS
--------------------------------------------------------------------
Player:
25fa : __ __ __ BSS	2
--------------------------------------------------------------------
init_enemies:
.s0:
0ac9 : a2 00 __ LDX #$00
0acb : a0 0a __ LDY #$0a
.l1002:
0acd : a9 00 __ LDA #$00
0acf : 9d 26 26 STA $2626,x ; (Enemy + 0)
0ad2 : 9d 27 26 STA $2627,x ; (Enemy + 1)
0ad5 : 9d 2a 26 STA $262a,x ; (Enemy + 4)
0ad8 : 8a __ __ TXA
0ad9 : 18 __ __ CLC
0ada : 69 05 __ ADC #$05
0adc : aa __ __ TAX
0add : 88 __ __ DEY
0ade : d0 ed __ BNE $0acd ; (init_enemies.l1002 + 0)
.s1001:
0ae0 : 60 __ __ RTS
--------------------------------------------------------------------
Enemy:
2626 : __ __ __ BSS	50
--------------------------------------------------------------------
init_shots:
.s0:
0ae1 : a2 00 __ LDX #$00
0ae3 : a0 03 __ LDY #$03
0ae5 : 8a __ __ TXA
.l1006:
0ae6 : 9d 58 26 STA $2658,x ; (PlayerShot + 0)
0ae9 : 9d 59 26 STA $2659,x ; (PlayerShot + 1)
0aec : 9d 5a 26 STA $265a,x ; (PlayerShot + 2)
0aef : e8 __ __ INX
0af0 : e8 __ __ INX
0af1 : e8 __ __ INX
0af2 : 88 __ __ DEY
0af3 : d0 f1 __ BNE $0ae6 ; (init_shots.l1006 + 0)
.s6:
0af5 : a0 03 __ LDY #$03
0af7 : aa __ __ TAX
.l1008:
0af8 : 9d 61 26 STA $2661,x ; (EnemyShot + 0)
0afb : 9d 62 26 STA $2662,x ; (EnemyShot + 1)
0afe : 9d 63 26 STA $2663,x ; (EnemyShot + 2)
0b01 : e8 __ __ INX
0b02 : e8 __ __ INX
0b03 : e8 __ __ INX
0b04 : 88 __ __ DEY
0b05 : d0 f1 __ BNE $0af8 ; (init_shots.l1008 + 0)
.s1001:
0b07 : 60 __ __ RTS
--------------------------------------------------------------------
PlayerShot:
2658 : __ __ __ BSS	9
--------------------------------------------------------------------
EnemyShot:
2661 : __ __ __ BSS	9
--------------------------------------------------------------------
run_game:
.s1000:
0b08 : a5 53 __ LDA T0 + 0 
0b0a : 8d cd 9f STA $9fcd ; (run_game@stack + 0)
.s0:
0b0d : a9 0f __ LDA #$0f
0b0f : 8d 18 d4 STA $d418 
0b12 : ad f4 25 LDA $25f4 ; (game + 0)
0b15 : c9 01 __ CMP #$01
0b17 : d0 59 __ BNE $0b72 ; (run_game.s1001 + 0)
.s7:
0b19 : a9 00 __ LDA #$00
0b1b : 85 53 __ STA T0 + 0 
.l2:
0b1d : 20 78 0b JSR $0b78 ; (render_game_state.s1000 + 0)
0b20 : a5 53 __ LDA T0 + 0 
0b22 : 85 1b __ STA ACCU + 0 
0b24 : a9 00 __ LDA #$00
0b26 : 85 1c __ STA ACCU + 1 
0b28 : 85 04 __ STA WORK + 1 
0b2a : a9 03 __ LDA #$03
0b2c : 85 03 __ STA WORK + 0 
0b2e : 20 a2 23 JSR $23a2 ; (divmod + 0)
0b31 : a5 05 __ LDA WORK + 2 
0b33 : 05 06 __ ORA WORK + 3 
0b35 : d0 0c __ BNE $0b43 ; (run_game.s6 + 0)
.s4:
0b37 : 20 7c 19 JSR $197c ; (spawn_enemy.s0 + 0)
0b3a : 20 13 1a JSR $1a13 ; (move_enemies.s0 + 0)
0b3d : 20 8b 1b JSR $1b8b ; (render_enemies.s0 + 0)
0b40 : 20 e8 1b JSR $1be8 ; (check_shot_enemy_collision.s0 + 0)
.s6:
0b43 : 20 09 1d JSR $1d09 ; (move_enemy_shots.s0 + 0)
0b46 : 20 36 1b JSR $1b36 ; (render_enemy_shots.s0 + 0)
0b49 : 20 73 1d JSR $1d73 ; (check_player_enemy_collision.s0 + 0)
0b4c : 20 5e 1e JSR $1e5e ; (control_player_ship.s0 + 0)
0b4f : 20 a1 1f JSR $1fa1 ; (render_player_ship.s0 + 0)
0b52 : 20 73 1d JSR $1d73 ; (check_player_enemy_collision.s0 + 0)
0b55 : 20 e1 1f JSR $1fe1 ; (move_player_shots.s0 + 0)
0b58 : 20 49 20 JSR $2049 ; (render_player_shots.s0 + 0)
0b5b : 20 e8 1b JSR $1be8 ; (check_shot_enemy_collision.s0 + 0)
0b5e : a9 03 __ LDA #$03
0b60 : 85 0d __ STA P0 
0b62 : a9 00 __ LDA #$00
0b64 : 85 0e __ STA P1 
0b66 : 20 9e 20 JSR $209e ; (wait_frames.s0 + 0)
0b69 : e6 53 __ INC T0 + 0 
0b6b : ad f4 25 LDA $25f4 ; (game + 0)
0b6e : c9 01 __ CMP #$01
0b70 : f0 ab __ BEQ $0b1d ; (run_game.l2 + 0)
.s1001:
0b72 : ad cd 9f LDA $9fcd ; (run_game@stack + 0)
0b75 : 85 53 __ STA T0 + 0 
0b77 : 60 __ __ RTS
--------------------------------------------------------------------
render_game_state:
.s1000:
0b78 : 38 __ __ SEC
0b79 : a5 23 __ LDA SP + 0 
0b7b : e9 0a __ SBC #$0a
0b7d : 85 23 __ STA SP + 0 
0b7f : b0 02 __ BCS $0b83 ; (render_game_state.s0 + 0)
0b81 : c6 24 __ DEC SP + 1 
.s0:
0b83 : a9 01 __ LDA #$01
0b85 : 85 0f __ STA P2 
0b87 : a9 02 __ LDA #$02
0b89 : 85 10 __ STA P3 
0b8b : a9 05 __ LDA #$05
0b8d : 85 13 __ STA P6 
0b8f : a9 1c __ LDA #$1c
0b91 : 85 0d __ STA P0 
0b93 : a9 26 __ LDA #$26
0b95 : 85 0e __ STA P1 
0b97 : a9 a4 __ LDA #$a4
0b99 : 85 11 __ STA P4 
0b9b : a9 0c __ LDA #$0c
0b9d : 85 12 __ STA P5 
0b9f : 20 52 0c JSR $0c52 ; (cwin_putat_string.s0 + 0)
0ba2 : a9 ce __ LDA #$ce
0ba4 : a0 02 __ LDY #$02
0ba6 : 91 23 __ STA (SP + 0),y 
0ba8 : a9 9f __ LDA #$9f
0baa : c8 __ __ INY
0bab : 91 23 __ STA (SP + 0),y 
0bad : a9 72 __ LDA #$72
0baf : c8 __ __ INY
0bb0 : 91 23 __ STA (SP + 0),y 
0bb2 : a9 19 __ LDA #$19
0bb4 : c8 __ __ INY
0bb5 : 91 23 __ STA (SP + 0),y 
0bb7 : ad f5 25 LDA $25f5 ; (game + 1)
0bba : c8 __ __ INY
0bbb : 91 23 __ STA (SP + 0),y 
0bbd : ad f6 25 LDA $25f6 ; (game + 2)
0bc0 : c8 __ __ INY
0bc1 : 91 23 __ STA (SP + 0),y 
0bc3 : ad f7 25 LDA $25f7 ; (game + 3)
0bc6 : c8 __ __ INY
0bc7 : 91 23 __ STA (SP + 0),y 
0bc9 : ad f8 25 LDA $25f8 ; (game + 4)
0bcc : c8 __ __ INY
0bcd : 91 23 __ STA (SP + 0),y 
0bcf : 20 ab 0c JSR $0cab ; (sprintf.s1000 + 0)
0bd2 : a9 1c __ LDA #$1c
0bd4 : 85 0d __ STA P0 
0bd6 : a9 26 __ LDA #$26
0bd8 : 85 0e __ STA P1 
0bda : a9 08 __ LDA #$08
0bdc : 85 0f __ STA P2 
0bde : a9 02 __ LDA #$02
0be0 : 85 10 __ STA P3 
0be2 : a9 ce __ LDA #$ce
0be4 : 85 11 __ STA P4 
0be6 : a9 9f __ LDA #$9f
0be8 : 85 12 __ STA P5 
0bea : a9 05 __ LDA #$05
0bec : 85 13 __ STA P6 
0bee : 20 52 0c JSR $0c52 ; (cwin_putat_string.s0 + 0)
0bf1 : a9 20 __ LDA #$20
0bf3 : 85 0f __ STA P2 
0bf5 : a9 0e __ LDA #$0e
0bf7 : 85 13 __ STA P6 
0bf9 : a9 75 __ LDA #$75
0bfb : 85 11 __ STA P4 
0bfd : a9 19 __ LDA #$19
0bff : 85 12 __ STA P5 
0c01 : 20 52 0c JSR $0c52 ; (cwin_putat_string.s0 + 0)
0c04 : a9 ce __ LDA #$ce
0c06 : a0 02 __ LDY #$02
0c08 : 91 23 __ STA (SP + 0),y 
0c0a : a9 9f __ LDA #$9f
0c0c : c8 __ __ INY
0c0d : 91 23 __ STA (SP + 0),y 
0c0f : a9 72 __ LDA #$72
0c11 : c8 __ __ INY
0c12 : 91 23 __ STA (SP + 0),y 
0c14 : a9 19 __ LDA #$19
0c16 : c8 __ __ INY
0c17 : 91 23 __ STA (SP + 0),y 
0c19 : ad f9 25 LDA $25f9 ; (game + 5)
0c1c : c8 __ __ INY
0c1d : 91 23 __ STA (SP + 0),y 
0c1f : a9 00 __ LDA #$00
0c21 : c8 __ __ INY
0c22 : 91 23 __ STA (SP + 0),y 
0c24 : 20 ab 0c JSR $0cab ; (sprintf.s1000 + 0)
0c27 : a9 1c __ LDA #$1c
0c29 : 85 0d __ STA P0 
0c2b : a9 26 __ LDA #$26
0c2d : 85 0e __ STA P1 
0c2f : a9 26 __ LDA #$26
0c31 : 85 0f __ STA P2 
0c33 : a9 02 __ LDA #$02
0c35 : 85 10 __ STA P3 
0c37 : a9 ce __ LDA #$ce
0c39 : 85 11 __ STA P4 
0c3b : a9 9f __ LDA #$9f
0c3d : 85 12 __ STA P5 
0c3f : a9 0e __ LDA #$0e
0c41 : 85 13 __ STA P6 
0c43 : 20 52 0c JSR $0c52 ; (cwin_putat_string.s0 + 0)
.s1001:
0c46 : 18 __ __ CLC
0c47 : a5 23 __ LDA SP + 0 
0c49 : 69 0a __ ADC #$0a
0c4b : 85 23 __ STA SP + 0 
0c4d : 90 02 __ BCC $0c51 ; (render_game_state.s1001 + 11)
0c4f : e6 24 __ INC SP + 1 
0c51 : 60 __ __ RTS
--------------------------------------------------------------------
cwin_putat_string:
.s0:
0c52 : a5 10 __ LDA P3 ; (y + 0)
0c54 : 0a __ __ ASL
0c55 : aa __ __ TAX
0c56 : bd b8 25 LDA $25b8,x ; (mul40 + 0)
0c59 : 18 __ __ CLC
0c5a : 65 0f __ ADC P2 ; (x + 0)
0c5c : 85 1b __ STA ACCU + 0 
0c5e : bd b9 25 LDA $25b9,x ; (mul40 + 1)
0c61 : 69 00 __ ADC #$00
0c63 : 85 1c __ STA ACCU + 1 
0c65 : a0 06 __ LDY #$06
0c67 : b1 0d __ LDA (P0),y ; (win + 0)
0c69 : 18 __ __ CLC
0c6a : 65 1b __ ADC ACCU + 0 
0c6c : 85 43 __ STA T3 + 0 
0c6e : c8 __ __ INY
0c6f : b1 0d __ LDA (P0),y ; (win + 0)
0c71 : 65 1c __ ADC ACCU + 1 
0c73 : 85 44 __ STA T3 + 1 
0c75 : c8 __ __ INY
0c76 : b1 0d __ LDA (P0),y ; (win + 0)
0c78 : 18 __ __ CLC
0c79 : 65 1b __ ADC ACCU + 0 
0c7b : 85 1b __ STA ACCU + 0 
0c7d : c8 __ __ INY
0c7e : b1 0d __ LDA (P0),y ; (win + 0)
0c80 : 65 1c __ ADC ACCU + 1 
0c82 : 85 1c __ STA ACCU + 1 
0c84 : a0 00 __ LDY #$00
0c86 : b1 11 __ LDA (P4),y ; (str + 0)
0c88 : f0 18 __ BEQ $0ca2 ; (cwin_putat_string.s3 + 0)
.l2:
0c8a : 85 1d __ STA ACCU + 2 
0c8c : 4a __ __ LSR
0c8d : 4a __ __ LSR
0c8e : 4a __ __ LSR
0c8f : 4a __ __ LSR
0c90 : 4a __ __ LSR
0c91 : aa __ __ TAX
0c92 : bd ea 25 LDA $25ea,x ; (p2smap + 0)
0c95 : 45 1d __ EOR ACCU + 2 
0c97 : 91 43 __ STA (T3 + 0),y 
0c99 : a5 13 __ LDA P6 ; (color + 0)
0c9b : 91 1b __ STA (ACCU + 0),y 
0c9d : c8 __ __ INY
0c9e : b1 11 __ LDA (P4),y ; (str + 0)
0ca0 : d0 e8 __ BNE $0c8a ; (cwin_putat_string.l2 + 0)
.s3:
0ca2 : 98 __ __ TYA
.s1001:
0ca3 : 60 __ __ RTS
--------------------------------------------------------------------
p2smap:
25ea : __ __ __ BYT 00 00 40 20 80 c0 80 80                         : ..@ ....
--------------------------------------------------------------------
0ca4 : __ __ __ BYT 53 43 4f 52 45 3a 00                            : SCORE:.
--------------------------------------------------------------------
sprintf:
.s1000:
0cab : a5 53 __ LDA T0 + 0 
0cad : 8d d8 9f STA $9fd8 ; (sprintf@stack + 0)
0cb0 : a5 54 __ LDA T0 + 1 
0cb2 : 8d d9 9f STA $9fd9 ; (sprintf@stack + 1)
.s0:
0cb5 : a9 00 __ LDA #$00
0cb7 : 8d ff 9f STA $9fff ; (sstack + 7)
0cba : a0 03 __ LDY #$03
0cbc : b1 23 __ LDA (SP + 0),y 
0cbe : 85 54 __ STA T0 + 1 
0cc0 : 8d fa 9f STA $9ffa ; (sstack + 2)
0cc3 : 88 __ __ DEY
0cc4 : b1 23 __ LDA (SP + 0),y 
0cc6 : 85 53 __ STA T0 + 0 
0cc8 : 8d f9 9f STA $9ff9 ; (sstack + 1)
0ccb : a0 04 __ LDY #$04
0ccd : b1 23 __ LDA (SP + 0),y 
0ccf : 8d fb 9f STA $9ffb ; (sstack + 3)
0cd2 : c8 __ __ INY
0cd3 : b1 23 __ LDA (SP + 0),y 
0cd5 : 8d fc 9f STA $9ffc ; (sstack + 4)
0cd8 : 18 __ __ CLC
0cd9 : a5 23 __ LDA SP + 0 
0cdb : 69 06 __ ADC #$06
0cdd : 8d fd 9f STA $9ffd ; (sstack + 5)
0ce0 : a5 24 __ LDA SP + 1 
0ce2 : 69 00 __ ADC #$00
0ce4 : 8d fe 9f STA $9ffe ; (sstack + 6)
0ce7 : 20 02 0d JSR $0d02 ; (sformat.s1000 + 0)
0cea : 38 __ __ SEC
0ceb : a5 1b __ LDA ACCU + 0 
0ced : e5 53 __ SBC T0 + 0 
0cef : 85 1b __ STA ACCU + 0 
0cf1 : a5 1c __ LDA ACCU + 1 
0cf3 : e5 54 __ SBC T0 + 1 
0cf5 : 85 1c __ STA ACCU + 1 
.s1001:
0cf7 : ad d8 9f LDA $9fd8 ; (sprintf@stack + 0)
0cfa : 85 53 __ STA T0 + 0 
0cfc : ad d9 9f LDA $9fd9 ; (sprintf@stack + 1)
0cff : 85 54 __ STA T0 + 1 
0d01 : 60 __ __ RTS
--------------------------------------------------------------------
sformat:
.s1000:
0d02 : a2 05 __ LDX #$05
0d04 : b5 53 __ LDA T1 + 0,x 
0d06 : 9d da 9f STA $9fda,x ; (sformat@stack + 0)
0d09 : ca __ __ DEX
0d0a : 10 f8 __ BPL $0d04 ; (sformat.s1000 + 2)
.s0:
0d0c : a9 00 __ LDA #$00
0d0e : 85 50 __ STA T0 + 0 
0d10 : ad fb 9f LDA $9ffb ; (sstack + 3)
0d13 : 85 53 __ STA T1 + 0 
0d15 : ad fc 9f LDA $9ffc ; (sstack + 4)
0d18 : 85 54 __ STA T1 + 1 
0d1a : ad f9 9f LDA $9ff9 ; (sstack + 1)
0d1d : 85 55 __ STA T2 + 0 
0d1f : ad fa 9f LDA $9ffa ; (sstack + 2)
0d22 : 85 56 __ STA T2 + 1 
.l1:
0d24 : a0 00 __ LDY #$00
0d26 : b1 53 __ LDA (T1 + 0),y 
0d28 : d0 38 __ BNE $0d62 ; (sformat.s2 + 0)
.s3:
0d2a : a4 50 __ LDY T0 + 0 
0d2c : 91 55 __ STA (T2 + 0),y 
0d2e : 98 __ __ TYA
0d2f : f0 28 __ BEQ $0d59 ; (sformat.s1061 + 0)
.s112:
0d31 : ad ff 9f LDA $9fff ; (sstack + 7)
0d34 : d0 18 __ BNE $0d4e ; (sformat.s115 + 0)
.s116:
0d36 : 18 __ __ CLC
0d37 : a5 55 __ LDA T2 + 0 
0d39 : 65 50 __ ADC T0 + 0 
0d3b : 85 1b __ STA ACCU + 0 ; (buff + 1)
0d3d : a5 56 __ LDA T2 + 1 
0d3f : 69 00 __ ADC #$00
.s1001:
0d41 : 85 1c __ STA ACCU + 1 ; (fmt + 0)
0d43 : a2 05 __ LDX #$05
0d45 : bd da 9f LDA $9fda,x ; (sformat@stack + 0)
0d48 : 95 53 __ STA T1 + 0,x 
0d4a : ca __ __ DEX
0d4b : 10 f8 __ BPL $0d45 ; (sformat.s1001 + 4)
0d4d : 60 __ __ RTS
.s115:
0d4e : a5 55 __ LDA T2 + 0 
0d50 : 85 0d __ STA P0 
0d52 : a5 56 __ LDA T2 + 1 
0d54 : 85 0e __ STA P1 
0d56 : 20 46 11 JSR $1146 ; (puts.s0 + 0)
.s1061:
0d59 : a5 55 __ LDA T2 + 0 
0d5b : 85 1b __ STA ACCU + 0 ; (buff + 1)
0d5d : a5 56 __ LDA T2 + 1 
0d5f : 4c 41 0d JMP $0d41 ; (sformat.s1001 + 0)
.s2:
0d62 : c9 25 __ CMP #$25
0d64 : f0 3f __ BEQ $0da5 ; (sformat.s4 + 0)
.s5:
0d66 : a4 50 __ LDY T0 + 0 
0d68 : 91 55 __ STA (T2 + 0),y 
0d6a : e6 53 __ INC T1 + 0 
0d6c : d0 02 __ BNE $0d70 ; (sformat.s1090 + 0)
.s1089:
0d6e : e6 54 __ INC T1 + 1 
.s1090:
0d70 : c8 __ __ INY
0d71 : 84 50 __ STY T0 + 0 
0d73 : 98 __ __ TYA
0d74 : c0 28 __ CPY #$28
0d76 : 90 ac __ BCC $0d24 ; (sformat.l1 + 0)
.s106:
0d78 : 85 57 __ STA T5 + 0 
0d7a : a9 00 __ LDA #$00
0d7c : 85 50 __ STA T0 + 0 
0d7e : ad ff 9f LDA $9fff ; (sstack + 7)
0d81 : f0 14 __ BEQ $0d97 ; (sformat.s110 + 0)
.s109:
0d83 : a5 55 __ LDA T2 + 0 
0d85 : 85 0d __ STA P0 
0d87 : a5 56 __ LDA T2 + 1 
0d89 : 85 0e __ STA P1 
0d8b : a9 00 __ LDA #$00
0d8d : a4 57 __ LDY T5 + 0 
0d8f : 91 0d __ STA (P0),y 
0d91 : 20 46 11 JSR $1146 ; (puts.s0 + 0)
0d94 : 4c 24 0d JMP $0d24 ; (sformat.l1 + 0)
.s110:
0d97 : 18 __ __ CLC
0d98 : a5 55 __ LDA T2 + 0 
0d9a : 65 57 __ ADC T5 + 0 
0d9c : 85 55 __ STA T2 + 0 
0d9e : 90 84 __ BCC $0d24 ; (sformat.l1 + 0)
.s1092:
0da0 : e6 56 __ INC T2 + 1 
0da2 : 4c 24 0d JMP $0d24 ; (sformat.l1 + 0)
.s4:
0da5 : a5 50 __ LDA T0 + 0 
0da7 : f0 27 __ BEQ $0dd0 ; (sformat.s9 + 0)
.s7:
0da9 : 84 50 __ STY T0 + 0 
0dab : 85 57 __ STA T5 + 0 
0dad : ad ff 9f LDA $9fff ; (sstack + 7)
0db0 : f0 13 __ BEQ $0dc5 ; (sformat.s11 + 0)
.s10:
0db2 : a5 55 __ LDA T2 + 0 
0db4 : 85 0d __ STA P0 
0db6 : a5 56 __ LDA T2 + 1 
0db8 : 85 0e __ STA P1 
0dba : 98 __ __ TYA
0dbb : a4 57 __ LDY T5 + 0 
0dbd : 91 0d __ STA (P0),y 
0dbf : 20 46 11 JSR $1146 ; (puts.s0 + 0)
0dc2 : 4c d0 0d JMP $0dd0 ; (sformat.s9 + 0)
.s11:
0dc5 : 18 __ __ CLC
0dc6 : a5 55 __ LDA T2 + 0 
0dc8 : 65 57 __ ADC T5 + 0 
0dca : 85 55 __ STA T2 + 0 
0dcc : 90 02 __ BCC $0dd0 ; (sformat.s9 + 0)
.s1087:
0dce : e6 56 __ INC T2 + 1 
.s9:
0dd0 : a9 0a __ LDA #$0a
0dd2 : 8d e3 9f STA $9fe3 ; (si + 3)
0dd5 : a9 00 __ LDA #$00
0dd7 : 8d e4 9f STA $9fe4 ; (si + 4)
0dda : 8d e5 9f STA $9fe5 ; (si + 5)
0ddd : 8d e6 9f STA $9fe6 ; (si + 6)
0de0 : 8d e7 9f STA $9fe7 ; (si + 7)
0de3 : a0 01 __ LDY #$01
0de5 : b1 53 __ LDA (T1 + 0),y 
0de7 : aa __ __ TAX
0de8 : a9 20 __ LDA #$20
0dea : 8d e0 9f STA $9fe0 ; (si + 0)
0ded : a9 00 __ LDA #$00
0def : 8d e1 9f STA $9fe1 ; (si + 1)
0df2 : a9 ff __ LDA #$ff
0df4 : 8d e2 9f STA $9fe2 ; (si + 2)
0df7 : 18 __ __ CLC
0df8 : a5 53 __ LDA T1 + 0 
0dfa : 69 02 __ ADC #$02
.l14:
0dfc : 85 53 __ STA T1 + 0 
0dfe : 90 02 __ BCC $0e02 ; (sformat.s1074 + 0)
.s1073:
0e00 : e6 54 __ INC T1 + 1 
.s1074:
0e02 : 8a __ __ TXA
0e03 : e0 2b __ CPX #$2b
0e05 : d0 08 __ BNE $0e0f ; (sformat.s17 + 0)
.s16:
0e07 : a9 01 __ LDA #$01
0e09 : 8d e5 9f STA $9fe5 ; (si + 5)
0e0c : 4c 39 11 JMP $1139 ; (sformat.s224 + 0)
.s17:
0e0f : c9 30 __ CMP #$30
0e11 : d0 06 __ BNE $0e19 ; (sformat.s20 + 0)
.s19:
0e13 : 8d e0 9f STA $9fe0 ; (si + 0)
0e16 : 4c 39 11 JMP $1139 ; (sformat.s224 + 0)
.s20:
0e19 : e0 23 __ CPX #$23
0e1b : d0 08 __ BNE $0e25 ; (sformat.s23 + 0)
.s22:
0e1d : a9 01 __ LDA #$01
0e1f : 8d e7 9f STA $9fe7 ; (si + 7)
0e22 : 4c 39 11 JMP $1139 ; (sformat.s224 + 0)
.s23:
0e25 : e0 2d __ CPX #$2d
0e27 : d0 08 __ BNE $0e31 ; (sformat.s15 + 0)
.s25:
0e29 : a9 01 __ LDA #$01
0e2b : 8d e6 9f STA $9fe6 ; (si + 6)
0e2e : 4c 39 11 JMP $1139 ; (sformat.s224 + 0)
.s15:
0e31 : 86 57 __ STX T5 + 0 
0e33 : e0 30 __ CPX #$30
0e35 : 90 53 __ BCC $0e8a ; (sformat.s31 + 0)
.s32:
0e37 : e0 3a __ CPX #$3a
0e39 : b0 4f __ BCS $0e8a ; (sformat.s31 + 0)
.s29:
0e3b : a9 00 __ LDA #$00
0e3d : 85 44 __ STA T6 + 0 
0e3f : 85 45 __ STA T6 + 1 
0e41 : e0 3a __ CPX #$3a
0e43 : b0 40 __ BCS $0e85 ; (sformat.s35 + 0)
.l34:
0e45 : a5 44 __ LDA T6 + 0 
0e47 : 0a __ __ ASL
0e48 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0e4a : a5 45 __ LDA T6 + 1 
0e4c : 2a __ __ ROL
0e4d : 06 1b __ ASL ACCU + 0 ; (buff + 1)
0e4f : 2a __ __ ROL
0e50 : aa __ __ TAX
0e51 : 18 __ __ CLC
0e52 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0e54 : 65 44 __ ADC T6 + 0 
0e56 : 85 44 __ STA T6 + 0 
0e58 : 8a __ __ TXA
0e59 : 65 45 __ ADC T6 + 1 
0e5b : 06 44 __ ASL T6 + 0 
0e5d : 2a __ __ ROL
0e5e : aa __ __ TAX
0e5f : 18 __ __ CLC
0e60 : a5 44 __ LDA T6 + 0 
0e62 : 65 57 __ ADC T5 + 0 
0e64 : 90 01 __ BCC $0e67 ; (sformat.s1084 + 0)
.s1083:
0e66 : e8 __ __ INX
.s1084:
0e67 : 38 __ __ SEC
0e68 : e9 30 __ SBC #$30
0e6a : 85 44 __ STA T6 + 0 
0e6c : 8a __ __ TXA
0e6d : e9 00 __ SBC #$00
0e6f : 85 45 __ STA T6 + 1 
0e71 : a0 00 __ LDY #$00
0e73 : b1 53 __ LDA (T1 + 0),y 
0e75 : 85 57 __ STA T5 + 0 
0e77 : e6 53 __ INC T1 + 0 
0e79 : d0 02 __ BNE $0e7d ; (sformat.s1086 + 0)
.s1085:
0e7b : e6 54 __ INC T1 + 1 
.s1086:
0e7d : c9 30 __ CMP #$30
0e7f : 90 04 __ BCC $0e85 ; (sformat.s35 + 0)
.s36:
0e81 : c9 3a __ CMP #$3a
0e83 : 90 c0 __ BCC $0e45 ; (sformat.l34 + 0)
.s35:
0e85 : a5 44 __ LDA T6 + 0 
0e87 : 8d e1 9f STA $9fe1 ; (si + 1)
.s31:
0e8a : a5 57 __ LDA T5 + 0 
0e8c : c9 2e __ CMP #$2e
0e8e : d0 51 __ BNE $0ee1 ; (sformat.s39 + 0)
.s37:
0e90 : a9 00 __ LDA #$00
0e92 : 85 44 __ STA T6 + 0 
.l203:
0e94 : 85 45 __ STA T6 + 1 
0e96 : a0 00 __ LDY #$00
0e98 : b1 53 __ LDA (T1 + 0),y 
0e9a : 85 57 __ STA T5 + 0 
0e9c : e6 53 __ INC T1 + 0 
0e9e : d0 02 __ BNE $0ea2 ; (sformat.s1076 + 0)
.s1075:
0ea0 : e6 54 __ INC T1 + 1 
.s1076:
0ea2 : c9 30 __ CMP #$30
0ea4 : 90 04 __ BCC $0eaa ; (sformat.s42 + 0)
.s43:
0ea6 : c9 3a __ CMP #$3a
0ea8 : 90 0a __ BCC $0eb4 ; (sformat.s41 + 0)
.s42:
0eaa : a5 44 __ LDA T6 + 0 
0eac : 8d e2 9f STA $9fe2 ; (si + 2)
0eaf : a5 57 __ LDA T5 + 0 
0eb1 : 4c e1 0e JMP $0ee1 ; (sformat.s39 + 0)
.s41:
0eb4 : a5 44 __ LDA T6 + 0 
0eb6 : 0a __ __ ASL
0eb7 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0eb9 : a5 45 __ LDA T6 + 1 
0ebb : 2a __ __ ROL
0ebc : 06 1b __ ASL ACCU + 0 ; (buff + 1)
0ebe : 2a __ __ ROL
0ebf : aa __ __ TAX
0ec0 : 18 __ __ CLC
0ec1 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0ec3 : 65 44 __ ADC T6 + 0 
0ec5 : 85 44 __ STA T6 + 0 
0ec7 : 8a __ __ TXA
0ec8 : 65 45 __ ADC T6 + 1 
0eca : 06 44 __ ASL T6 + 0 
0ecc : 2a __ __ ROL
0ecd : aa __ __ TAX
0ece : 18 __ __ CLC
0ecf : a5 44 __ LDA T6 + 0 
0ed1 : 65 57 __ ADC T5 + 0 
0ed3 : 90 01 __ BCC $0ed6 ; (sformat.s1082 + 0)
.s1081:
0ed5 : e8 __ __ INX
.s1082:
0ed6 : 38 __ __ SEC
0ed7 : e9 30 __ SBC #$30
0ed9 : 85 44 __ STA T6 + 0 
0edb : 8a __ __ TXA
0edc : e9 00 __ SBC #$00
0ede : 4c 94 0e JMP $0e94 ; (sformat.l203 + 0)
.s39:
0ee1 : c9 64 __ CMP #$64
0ee3 : d0 05 __ BNE $0eea ; (sformat.s45 + 0)
.s44:
0ee5 : a9 01 __ LDA #$01
0ee7 : 4c fd 10 JMP $10fd ; (sformat.s221 + 0)
.s45:
0eea : c9 75 __ CMP #$75
0eec : d0 03 __ BNE $0ef1 ; (sformat.s48 + 0)
0eee : 4c fb 10 JMP $10fb ; (sformat.s250 + 0)
.s48:
0ef1 : c9 78 __ CMP #$78
0ef3 : d0 0d __ BNE $0f02 ; (sformat.s51 + 0)
.s50:
0ef5 : a9 10 __ LDA #$10
0ef7 : 8d e3 9f STA $9fe3 ; (si + 3)
0efa : a9 00 __ LDA #$00
0efc : 8d e4 9f STA $9fe4 ; (si + 4)
0eff : 4c fb 10 JMP $10fb ; (sformat.s250 + 0)
.s51:
0f02 : c9 6c __ CMP #$6c
0f04 : d0 03 __ BNE $0f09 ; (sformat.s54 + 0)
0f06 : 4c 76 10 JMP $1076 ; (sformat.s53 + 0)
.s54:
0f09 : c9 66 __ CMP #$66
0f0b : f0 08 __ BEQ $0f15 ; (sformat.s65 + 0)
.s69:
0f0d : c9 67 __ CMP #$67
0f0f : f0 04 __ BEQ $0f15 ; (sformat.s65 + 0)
.s68:
0f11 : c9 65 __ CMP #$65
0f13 : d0 4d __ BNE $0f62 ; (sformat.s66 + 0)
.s65:
0f15 : a5 55 __ LDA T2 + 0 
0f17 : 85 13 __ STA P6 
0f19 : a5 56 __ LDA T2 + 1 
0f1b : 85 14 __ STA P7 
0f1d : a5 57 __ LDA T5 + 0 
0f1f : 8d f8 9f STA $9ff8 ; (sstack + 0)
0f22 : a9 e0 __ LDA #$e0
0f24 : 85 11 __ STA P4 
0f26 : a9 9f __ LDA #$9f
0f28 : 85 12 __ STA P5 
0f2a : ad fd 9f LDA $9ffd ; (sstack + 5)
0f2d : 85 57 __ STA T5 + 0 
0f2f : ad fe 9f LDA $9ffe ; (sstack + 6)
0f32 : 85 58 __ STA T5 + 1 
0f34 : a0 00 __ LDY #$00
0f36 : b1 57 __ LDA (T5 + 0),y 
0f38 : 85 15 __ STA P8 
0f3a : c8 __ __ INY
0f3b : b1 57 __ LDA (T5 + 0),y 
0f3d : 85 16 __ STA P9 
0f3f : c8 __ __ INY
0f40 : b1 57 __ LDA (T5 + 0),y 
0f42 : 85 17 __ STA P10 
0f44 : c8 __ __ INY
0f45 : b1 57 __ LDA (T5 + 0),y 
0f47 : 85 18 __ STA P11 
0f49 : 20 92 14 JSR $1492 ; (nformf.s0 + 0)
0f4c : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0f4e : 85 50 __ STA T0 + 0 
0f50 : 18 __ __ CLC
0f51 : a5 57 __ LDA T5 + 0 
0f53 : 69 04 __ ADC #$04
0f55 : 8d fd 9f STA $9ffd ; (sstack + 5)
0f58 : a5 58 __ LDA T5 + 1 
0f5a : 69 00 __ ADC #$00
0f5c : 8d fe 9f STA $9ffe ; (sstack + 6)
0f5f : 4c 24 0d JMP $0d24 ; (sformat.l1 + 0)
.s66:
0f62 : c9 73 __ CMP #$73
0f64 : f0 4c __ BEQ $0fb2 ; (sformat.s70 + 0)
.s71:
0f66 : c9 63 __ CMP #$63
0f68 : f0 1f __ BEQ $0f89 ; (sformat.s100 + 0)
.s101:
0f6a : 09 00 __ ORA #$00
0f6c : d0 03 __ BNE $0f71 ; (sformat.s103 + 0)
0f6e : 4c 24 0d JMP $0d24 ; (sformat.l1 + 0)
.s103:
0f71 : 18 __ __ CLC
0f72 : a5 55 __ LDA T2 + 0 
0f74 : 65 50 __ ADC T0 + 0 
0f76 : 85 44 __ STA T6 + 0 
0f78 : a5 56 __ LDA T2 + 1 
0f7a : 69 00 __ ADC #$00
0f7c : 85 45 __ STA T6 + 1 
0f7e : a5 57 __ LDA T5 + 0 
.s1059:
0f80 : a0 00 __ LDY #$00
0f82 : 91 44 __ STA (T6 + 0),y 
0f84 : e6 50 __ INC T0 + 0 
0f86 : 4c 24 0d JMP $0d24 ; (sformat.l1 + 0)
.s100:
0f89 : ad fd 9f LDA $9ffd ; (sstack + 5)
0f8c : 85 57 __ STA T5 + 0 
0f8e : 18 __ __ CLC
0f8f : 69 02 __ ADC #$02
0f91 : 8d fd 9f STA $9ffd ; (sstack + 5)
0f94 : ad fe 9f LDA $9ffe ; (sstack + 6)
0f97 : 85 58 __ STA T5 + 1 
0f99 : 69 00 __ ADC #$00
0f9b : 8d fe 9f STA $9ffe ; (sstack + 6)
0f9e : 18 __ __ CLC
0f9f : a5 55 __ LDA T2 + 0 
0fa1 : 65 50 __ ADC T0 + 0 
0fa3 : 85 44 __ STA T6 + 0 
0fa5 : a5 56 __ LDA T2 + 1 
0fa7 : 69 00 __ ADC #$00
0fa9 : 85 45 __ STA T6 + 1 
0fab : a0 00 __ LDY #$00
0fad : b1 57 __ LDA (T5 + 0),y 
0faf : 4c 80 0f JMP $0f80 ; (sformat.s1059 + 0)
.s70:
0fb2 : ad fd 9f LDA $9ffd ; (sstack + 5)
0fb5 : 85 57 __ STA T5 + 0 
0fb7 : 18 __ __ CLC
0fb8 : 69 02 __ ADC #$02
0fba : 8d fd 9f STA $9ffd ; (sstack + 5)
0fbd : ad fe 9f LDA $9ffe ; (sstack + 6)
0fc0 : 85 58 __ STA T5 + 1 
0fc2 : 69 00 __ ADC #$00
0fc4 : 8d fe 9f STA $9ffe ; (sstack + 6)
0fc7 : a0 00 __ LDY #$00
0fc9 : b1 57 __ LDA (T5 + 0),y 
0fcb : aa __ __ TAX
0fcc : c8 __ __ INY
0fcd : b1 57 __ LDA (T5 + 0),y 
0fcf : 86 57 __ STX T5 + 0 
0fd1 : 85 58 __ STA T5 + 1 
0fd3 : a9 00 __ LDA #$00
0fd5 : 85 52 __ STA T3 + 0 
0fd7 : ad e1 9f LDA $9fe1 ; (si + 1)
0fda : f0 0c __ BEQ $0fe8 ; (sformat.s75 + 0)
.s1065:
0fdc : 88 __ __ DEY
0fdd : b1 57 __ LDA (T5 + 0),y 
0fdf : f0 05 __ BEQ $0fe6 ; (sformat.s1066 + 0)
.l77:
0fe1 : c8 __ __ INY
0fe2 : b1 57 __ LDA (T5 + 0),y 
0fe4 : d0 fb __ BNE $0fe1 ; (sformat.l77 + 0)
.s1066:
0fe6 : 84 52 __ STY T3 + 0 
.s75:
0fe8 : ad e6 9f LDA $9fe6 ; (si + 6)
0feb : d0 19 __ BNE $1006 ; (sformat.s81 + 0)
.s1069:
0fed : a6 52 __ LDX T3 + 0 
0fef : ec e1 9f CPX $9fe1 ; (si + 1)
0ff2 : a4 50 __ LDY T0 + 0 
0ff4 : b0 0c __ BCS $1002 ; (sformat.s1070 + 0)
.l83:
0ff6 : ad e0 9f LDA $9fe0 ; (si + 0)
0ff9 : 91 55 __ STA (T2 + 0),y 
0ffb : e8 __ __ INX
0ffc : ec e1 9f CPX $9fe1 ; (si + 1)
0fff : c8 __ __ INY
1000 : 90 f4 __ BCC $0ff6 ; (sformat.l83 + 0)
.s1070:
1002 : 86 52 __ STX T3 + 0 
1004 : 84 50 __ STY T0 + 0 
.s81:
1006 : ad ff 9f LDA $9fff ; (sstack + 7)
1009 : d0 37 __ BNE $1042 ; (sformat.s85 + 0)
.l91:
100b : a0 00 __ LDY #$00
100d : b1 57 __ LDA (T5 + 0),y 
100f : f0 0f __ BEQ $1020 ; (sformat.s211 + 0)
.s92:
1011 : a4 50 __ LDY T0 + 0 
1013 : 91 55 __ STA (T2 + 0),y 
1015 : e6 50 __ INC T0 + 0 
1017 : e6 57 __ INC T5 + 0 
1019 : d0 f0 __ BNE $100b ; (sformat.l91 + 0)
.s1079:
101b : e6 58 __ INC T5 + 1 
101d : 4c 0b 10 JMP $100b ; (sformat.l91 + 0)
.s211:
1020 : ad e6 9f LDA $9fe6 ; (si + 6)
1023 : d0 03 __ BNE $1028 ; (sformat.s1067 + 0)
1025 : 4c 24 0d JMP $0d24 ; (sformat.l1 + 0)
.s1067:
1028 : a6 52 __ LDX T3 + 0 
102a : ec e1 9f CPX $9fe1 ; (si + 1)
102d : a4 50 __ LDY T0 + 0 
102f : b0 0c __ BCS $103d ; (sformat.s1068 + 0)
.l98:
1031 : ad e0 9f LDA $9fe0 ; (si + 0)
1034 : 91 55 __ STA (T2 + 0),y 
1036 : e8 __ __ INX
1037 : ec e1 9f CPX $9fe1 ; (si + 1)
103a : c8 __ __ INY
103b : 90 f4 __ BCC $1031 ; (sformat.l98 + 0)
.s1068:
103d : 84 50 __ STY T0 + 0 
103f : 4c 24 0d JMP $0d24 ; (sformat.l1 + 0)
.s85:
1042 : a5 50 __ LDA T0 + 0 
1044 : f0 22 __ BEQ $1068 ; (sformat.s90 + 0)
.s88:
1046 : a5 55 __ LDA T2 + 0 
1048 : 85 0d __ STA P0 
104a : a5 56 __ LDA T2 + 1 
104c : 85 0e __ STA P1 
104e : a9 00 __ LDA #$00
1050 : a4 50 __ LDY T0 + 0 
1052 : 91 0d __ STA (P0),y 
1054 : 20 46 11 JSR $1146 ; (puts.s0 + 0)
1057 : a5 57 __ LDA T5 + 0 
1059 : 85 0d __ STA P0 
105b : a5 58 __ LDA T5 + 1 
105d : 85 0e __ STA P1 
105f : 20 46 11 JSR $1146 ; (puts.s0 + 0)
1062 : a9 00 __ LDA #$00
1064 : 85 50 __ STA T0 + 0 
1066 : f0 b8 __ BEQ $1020 ; (sformat.s211 + 0)
.s90:
1068 : a5 57 __ LDA T5 + 0 
106a : 85 0d __ STA P0 
106c : a5 58 __ LDA T5 + 1 
106e : 85 0e __ STA P1 
1070 : 20 46 11 JSR $1146 ; (puts.s0 + 0)
1073 : 4c 20 10 JMP $1020 ; (sformat.s211 + 0)
.s53:
1076 : ad fd 9f LDA $9ffd ; (sstack + 5)
1079 : 85 57 __ STA T5 + 0 
107b : 18 __ __ CLC
107c : 69 04 __ ADC #$04
107e : 8d fd 9f STA $9ffd ; (sstack + 5)
1081 : ad fe 9f LDA $9ffe ; (sstack + 6)
1084 : 85 58 __ STA T5 + 1 
1086 : 69 00 __ ADC #$00
1088 : 8d fe 9f STA $9ffe ; (sstack + 6)
108b : a0 00 __ LDY #$00
108d : b1 53 __ LDA (T1 + 0),y 
108f : 85 52 __ STA T3 + 0 
1091 : e6 53 __ INC T1 + 0 
1093 : d0 02 __ BNE $1097 ; (sformat.s1078 + 0)
.s1077:
1095 : e6 54 __ INC T1 + 1 
.s1078:
1097 : c9 64 __ CMP #$64
1099 : d0 04 __ BNE $109f ; (sformat.s1019 + 0)
.s1018:
109b : a2 01 __ LDX #$01
109d : d0 02 __ BNE $10a1 ; (sformat.s1020 + 0)
.s1019:
109f : a2 00 __ LDX #$00
.s1020:
10a1 : b1 57 __ LDA (T5 + 0),y 
10a3 : 85 46 __ STA T7 + 0 
10a5 : a0 01 __ LDY #$01
10a7 : b1 57 __ LDA (T5 + 0),y 
10a9 : 85 47 __ STA T7 + 1 
10ab : c8 __ __ INY
10ac : b1 57 __ LDA (T5 + 0),y 
10ae : 85 48 __ STA T7 + 2 
10b0 : c8 __ __ INY
10b1 : b1 57 __ LDA (T5 + 0),y 
10b3 : a8 __ __ TAY
10b4 : 8a __ __ TXA
10b5 : f0 04 __ BEQ $10bb ; (sformat.s57 + 0)
.s56:
10b7 : a9 01 __ LDA #$01
10b9 : d0 16 __ BNE $10d1 ; (sformat.s222 + 0)
.s57:
10bb : a5 52 __ LDA T3 + 0 
10bd : c9 75 __ CMP #$75
10bf : f0 0f __ BEQ $10d0 ; (sformat.s251 + 0)
.s60:
10c1 : c9 78 __ CMP #$78
10c3 : f0 03 __ BEQ $10c8 ; (sformat.s62 + 0)
10c5 : 4c 24 0d JMP $0d24 ; (sformat.l1 + 0)
.s62:
10c8 : 8e e4 9f STX $9fe4 ; (si + 4)
10cb : a9 10 __ LDA #$10
10cd : 8d e3 9f STA $9fe3 ; (si + 3)
.s251:
10d0 : 8a __ __ TXA
.s222:
10d1 : 84 14 __ STY P7 
10d3 : 85 15 __ STA P8 
10d5 : a5 55 __ LDA T2 + 0 
10d7 : 85 0f __ STA P2 
10d9 : a5 56 __ LDA T2 + 1 
10db : 85 10 __ STA P3 
10dd : a5 46 __ LDA T7 + 0 
10df : 85 11 __ STA P4 
10e1 : a5 47 __ LDA T7 + 1 
10e3 : 85 12 __ STA P5 
10e5 : a5 48 __ LDA T7 + 2 
10e7 : 85 13 __ STA P6 
10e9 : a9 e0 __ LDA #$e0
10eb : 85 0d __ STA P0 
10ed : a9 9f __ LDA #$9f
10ef : 85 0e __ STA P1 
10f1 : 20 fa 12 JSR $12fa ; (nforml.s0 + 0)
.s1062:
10f4 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
10f6 : 85 50 __ STA T0 + 0 
10f8 : 4c 24 0d JMP $0d24 ; (sformat.l1 + 0)
.s250:
10fb : a9 00 __ LDA #$00
.s221:
10fd : 85 13 __ STA P6 
10ff : a5 55 __ LDA T2 + 0 
1101 : 85 0f __ STA P2 
1103 : a5 56 __ LDA T2 + 1 
1105 : 85 10 __ STA P3 
1107 : ad fd 9f LDA $9ffd ; (sstack + 5)
110a : 85 50 __ STA T0 + 0 
110c : ad fe 9f LDA $9ffe ; (sstack + 6)
110f : 85 51 __ STA T0 + 1 
1111 : a0 00 __ LDY #$00
1113 : b1 50 __ LDA (T0 + 0),y 
1115 : 85 11 __ STA P4 
1117 : c8 __ __ INY
1118 : b1 50 __ LDA (T0 + 0),y 
111a : 85 12 __ STA P5 
111c : 18 __ __ CLC
111d : a5 50 __ LDA T0 + 0 
111f : 69 02 __ ADC #$02
1121 : 8d fd 9f STA $9ffd ; (sstack + 5)
1124 : a5 51 __ LDA T0 + 1 
1126 : 69 00 __ ADC #$00
1128 : 8d fe 9f STA $9ffe ; (sstack + 6)
112b : a9 e0 __ LDA #$e0
112d : 85 0d __ STA P0 
112f : a9 9f __ LDA #$9f
1131 : 85 0e __ STA P1 
1133 : 20 9b 11 JSR $119b ; (nformi.s0 + 0)
1136 : 4c f4 10 JMP $10f4 ; (sformat.s1062 + 0)
.s224:
1139 : a0 00 __ LDY #$00
113b : b1 53 __ LDA (T1 + 0),y 
113d : aa __ __ TAX
113e : 18 __ __ CLC
113f : a5 53 __ LDA T1 + 0 
1141 : 69 01 __ ADC #$01
1143 : 4c fc 0d JMP $0dfc ; (sformat.l14 + 0)
--------------------------------------------------------------------
puts:
.s0:
1146 : a0 00 __ LDY #$00
1148 : b1 0d __ LDA (P0),y 
114a : f0 0b __ BEQ $1157 ; (puts.s1001 + 0)
114c : 20 58 11 JSR $1158 ; (putpch + 0)
114f : e6 0d __ INC P0 
1151 : d0 f3 __ BNE $1146 ; (puts.s0 + 0)
1153 : e6 0e __ INC P1 
1155 : d0 ef __ BNE $1146 ; (puts.s0 + 0)
.s1001:
1157 : 60 __ __ RTS
--------------------------------------------------------------------
putpch:
1158 : ae ff 08 LDX $08ff ; (giocharmap + 0)
115b : e0 01 __ CPX #$01
115d : 90 26 __ BCC $1185 ; (putpch + 45)
115f : c9 0a __ CMP #$0a
1161 : d0 02 __ BNE $1165 ; (putpch + 13)
1163 : a9 0d __ LDA #$0d
1165 : c9 09 __ CMP #$09
1167 : f0 1f __ BEQ $1188 ; (putpch + 48)
1169 : e0 02 __ CPX #$02
116b : 90 18 __ BCC $1185 ; (putpch + 45)
116d : c9 41 __ CMP #$41
116f : 90 14 __ BCC $1185 ; (putpch + 45)
1171 : c9 7b __ CMP #$7b
1173 : b0 10 __ BCS $1185 ; (putpch + 45)
1175 : c9 61 __ CMP #$61
1177 : b0 04 __ BCS $117d ; (putpch + 37)
1179 : c9 5b __ CMP #$5b
117b : b0 08 __ BCS $1185 ; (putpch + 45)
117d : 49 20 __ EOR #$20
117f : e0 03 __ CPX #$03
1181 : f0 02 __ BEQ $1185 ; (putpch + 45)
1183 : 29 df __ AND #$df
1185 : 4c d2 ff JMP $ffd2 
1188 : 38 __ __ SEC
1189 : 20 f0 ff JSR $fff0 
118c : 98 __ __ TYA
118d : 29 03 __ AND #$03
118f : 49 03 __ EOR #$03
1191 : aa __ __ TAX
1192 : a9 20 __ LDA #$20
1194 : 20 d2 ff JSR $ffd2 
1197 : ca __ __ DEX
1198 : 10 fa __ BPL $1194 ; (putpch + 60)
119a : 60 __ __ RTS
--------------------------------------------------------------------
giocharmap:
08ff : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
nformi:
.s0:
119b : a9 00 __ LDA #$00
119d : 85 43 __ STA T0 + 0 
119f : a5 13 __ LDA P6 ; (s + 0)
11a1 : f0 15 __ BEQ $11b8 ; (nformi.s159 + 0)
.s4:
11a3 : a5 12 __ LDA P5 ; (v + 1)
11a5 : 10 11 __ BPL $11b8 ; (nformi.s159 + 0)
.s1:
11a7 : 38 __ __ SEC
11a8 : a9 00 __ LDA #$00
11aa : e5 11 __ SBC P4 ; (v + 0)
11ac : 85 11 __ STA P4 ; (v + 0)
11ae : a9 00 __ LDA #$00
11b0 : e5 12 __ SBC P5 ; (v + 1)
11b2 : 85 12 __ STA P5 ; (v + 1)
11b4 : a9 01 __ LDA #$01
11b6 : 85 43 __ STA T0 + 0 
.s159:
11b8 : a9 10 __ LDA #$10
11ba : 85 44 __ STA T2 + 0 
11bc : a5 11 __ LDA P4 ; (v + 0)
11be : 05 12 __ ORA P5 ; (v + 1)
11c0 : f0 61 __ BEQ $1223 ; (nformi.s7 + 0)
.s45:
11c2 : a5 0d __ LDA P0 ; (si + 0)
11c4 : 85 45 __ STA T4 + 0 
11c6 : a5 0e __ LDA P1 ; (si + 1)
11c8 : 85 46 __ STA T4 + 1 
.l6:
11ca : a0 03 __ LDY #$03
11cc : b1 45 __ LDA (T4 + 0),y 
11ce : 85 47 __ STA T5 + 0 
11d0 : 85 03 __ STA WORK + 0 
11d2 : c8 __ __ INY
11d3 : b1 45 __ LDA (T4 + 0),y 
11d5 : 85 48 __ STA T5 + 1 
11d7 : 85 04 __ STA WORK + 1 
11d9 : a5 11 __ LDA P4 ; (v + 0)
11db : 85 1b __ STA ACCU + 0 
11dd : a5 12 __ LDA P5 ; (v + 1)
11df : 85 1c __ STA ACCU + 1 
11e1 : 20 a2 23 JSR $23a2 ; (divmod + 0)
11e4 : a5 06 __ LDA WORK + 3 
11e6 : 30 10 __ BMI $11f8 ; (nformi.s9 + 0)
.s1019:
11e8 : d0 06 __ BNE $11f0 ; (nformi.s8 + 0)
.s1018:
11ea : a5 05 __ LDA WORK + 2 
11ec : c9 0a __ CMP #$0a
11ee : 90 08 __ BCC $11f8 ; (nformi.s9 + 0)
.s8:
11f0 : 18 __ __ CLC
11f1 : a5 05 __ LDA WORK + 2 
11f3 : 69 37 __ ADC #$37
11f5 : 4c fd 11 JMP $11fd ; (nformi.s10 + 0)
.s9:
11f8 : 18 __ __ CLC
11f9 : a5 05 __ LDA WORK + 2 
11fb : 69 30 __ ADC #$30
.s10:
11fd : c6 44 __ DEC T2 + 0 
11ff : a6 44 __ LDX T2 + 0 
1201 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1204 : a5 11 __ LDA P4 ; (v + 0)
1206 : 85 1b __ STA ACCU + 0 
1208 : a5 12 __ LDA P5 ; (v + 1)
120a : 85 1c __ STA ACCU + 1 
120c : a5 47 __ LDA T5 + 0 
120e : 85 03 __ STA WORK + 0 
1210 : a5 48 __ LDA T5 + 1 
1212 : 85 04 __ STA WORK + 1 
1214 : 20 a2 23 JSR $23a2 ; (divmod + 0)
1217 : a5 1b __ LDA ACCU + 0 
1219 : 85 11 __ STA P4 ; (v + 0)
121b : a5 1c __ LDA ACCU + 1 
121d : 85 12 __ STA P5 ; (v + 1)
121f : 05 11 __ ORA P4 ; (v + 0)
1221 : d0 a7 __ BNE $11ca ; (nformi.l6 + 0)
.s7:
1223 : a5 0d __ LDA P0 ; (si + 0)
1225 : 85 11 __ STA P4 ; (v + 0)
1227 : a5 0e __ LDA P1 ; (si + 1)
1229 : 85 12 __ STA P5 ; (v + 1)
122b : a0 02 __ LDY #$02
122d : b1 0d __ LDA (P0),y ; (si + 0)
122f : c9 ff __ CMP #$ff
1231 : d0 04 __ BNE $1237 ; (nformi.s76 + 0)
.s77:
1233 : a9 0f __ LDA #$0f
1235 : d0 05 __ BNE $123c ; (nformi.s1026 + 0)
.s76:
1237 : 38 __ __ SEC
1238 : a9 10 __ LDA #$10
123a : f1 0d __ SBC (P0),y ; (si + 0)
.s1026:
123c : a8 __ __ TAY
123d : c4 44 __ CPY T2 + 0 
123f : b0 0d __ BCS $124e ; (nformi.s13 + 0)
.s12:
1241 : a9 30 __ LDA #$30
.l1027:
1243 : c6 44 __ DEC T2 + 0 
1245 : a6 44 __ LDX T2 + 0 
1247 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
124a : c4 44 __ CPY T2 + 0 
124c : 90 f5 __ BCC $1243 ; (nformi.l1027 + 0)
.s13:
124e : a0 07 __ LDY #$07
1250 : b1 0d __ LDA (P0),y ; (si + 0)
1252 : f0 20 __ BEQ $1274 ; (nformi.s16 + 0)
.s17:
1254 : a0 04 __ LDY #$04
1256 : b1 0d __ LDA (P0),y ; (si + 0)
1258 : d0 1a __ BNE $1274 ; (nformi.s16 + 0)
.s1013:
125a : 88 __ __ DEY
125b : b1 0d __ LDA (P0),y ; (si + 0)
125d : c9 10 __ CMP #$10
125f : d0 13 __ BNE $1274 ; (nformi.s16 + 0)
.s14:
1261 : a9 58 __ LDA #$58
1263 : a6 44 __ LDX T2 + 0 
1265 : 9d e7 9f STA $9fe7,x ; (si + 7)
1268 : 8a __ __ TXA
1269 : 18 __ __ CLC
126a : 69 fe __ ADC #$fe
126c : 85 44 __ STA T2 + 0 
126e : aa __ __ TAX
126f : a9 30 __ LDA #$30
1271 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s16:
1274 : a9 00 __ LDA #$00
1276 : 85 1b __ STA ACCU + 0 
1278 : a5 43 __ LDA T0 + 0 
127a : f0 06 __ BEQ $1282 ; (nformi.s19 + 0)
.s18:
127c : c6 44 __ DEC T2 + 0 
127e : a9 2d __ LDA #$2d
1280 : d0 0a __ BNE $128c ; (nformi.s1025 + 0)
.s19:
1282 : a0 05 __ LDY #$05
1284 : b1 0d __ LDA (P0),y ; (si + 0)
1286 : f0 09 __ BEQ $1291 ; (nformi.s141 + 0)
.s21:
1288 : c6 44 __ DEC T2 + 0 
128a : a9 2b __ LDA #$2b
.s1025:
128c : a6 44 __ LDX T2 + 0 
128e : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s141:
1291 : a0 06 __ LDY #$06
1293 : b1 0d __ LDA (P0),y ; (si + 0)
1295 : d0 37 __ BNE $12ce ; (nformi.s27 + 0)
.l33:
1297 : a0 01 __ LDY #$01
1299 : b1 11 __ LDA (P4),y ; (v + 0)
129b : 18 __ __ CLC
129c : 65 44 __ ADC T2 + 0 
129e : b0 04 __ BCS $12a4 ; (nformi.s34 + 0)
.s1006:
12a0 : c9 11 __ CMP #$11
12a2 : 90 0e __ BCC $12b2 ; (nformi.s36 + 0)
.s34:
12a4 : c6 44 __ DEC T2 + 0 
12a6 : a0 00 __ LDY #$00
12a8 : b1 11 __ LDA (P4),y ; (v + 0)
12aa : a6 44 __ LDX T2 + 0 
12ac : 9d e8 9f STA $9fe8,x ; (buffer + 0)
12af : 4c 97 12 JMP $1297 ; (nformi.l33 + 0)
.s36:
12b2 : a6 44 __ LDX T2 + 0 
12b4 : e0 10 __ CPX #$10
12b6 : b0 11 __ BCS $12c9 ; (nformi.s26 + 0)
.s1022:
12b8 : 88 __ __ DEY
.l1031:
12b9 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
12bc : 91 0f __ STA (P2),y ; (str + 0)
12be : e6 44 __ INC T2 + 0 
12c0 : a6 44 __ LDX T2 + 0 
12c2 : e0 10 __ CPX #$10
12c4 : c8 __ __ INY
12c5 : 90 f2 __ BCC $12b9 ; (nformi.l1031 + 0)
.s1032:
12c7 : 84 1b __ STY ACCU + 0 
.s26:
12c9 : a9 00 __ LDA #$00
12cb : 85 1c __ STA ACCU + 1 
.s1001:
12cd : 60 __ __ RTS
.s27:
12ce : a6 44 __ LDX T2 + 0 
12d0 : e0 10 __ CPX #$10
12d2 : b0 12 __ BCS $12e6 ; (nformi.l30 + 0)
.s1020:
12d4 : a0 00 __ LDY #$00
.l1029:
12d6 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
12d9 : 91 0f __ STA (P2),y ; (str + 0)
12db : e6 44 __ INC T2 + 0 
12dd : a6 44 __ LDX T2 + 0 
12df : e0 10 __ CPX #$10
12e1 : c8 __ __ INY
12e2 : 90 f2 __ BCC $12d6 ; (nformi.l1029 + 0)
.s1030:
12e4 : 84 1b __ STY ACCU + 0 
.l30:
12e6 : a5 1b __ LDA ACCU + 0 
12e8 : a0 01 __ LDY #$01
12ea : d1 11 __ CMP (P4),y ; (v + 0)
12ec : b0 db __ BCS $12c9 ; (nformi.s26 + 0)
.s31:
12ee : 88 __ __ DEY
12ef : b1 11 __ LDA (P4),y ; (v + 0)
12f1 : a4 1b __ LDY ACCU + 0 
12f3 : 91 0f __ STA (P2),y ; (str + 0)
12f5 : e6 1b __ INC ACCU + 0 
12f7 : 4c e6 12 JMP $12e6 ; (nformi.l30 + 0)
--------------------------------------------------------------------
nforml:
.s0:
12fa : a9 00 __ LDA #$00
12fc : 85 43 __ STA T0 + 0 
12fe : a5 15 __ LDA P8 ; (s + 0)
1300 : f0 23 __ BEQ $1325 ; (nforml.s159 + 0)
.s4:
1302 : a5 14 __ LDA P7 ; (v + 3)
1304 : f0 1f __ BEQ $1325 ; (nforml.s159 + 0)
.s1032:
1306 : 10 1d __ BPL $1325 ; (nforml.s159 + 0)
.s1:
1308 : 38 __ __ SEC
1309 : a9 00 __ LDA #$00
130b : e5 11 __ SBC P4 ; (v + 0)
130d : 85 11 __ STA P4 ; (v + 0)
130f : a9 00 __ LDA #$00
1311 : e5 12 __ SBC P5 ; (v + 1)
1313 : 85 12 __ STA P5 ; (v + 1)
1315 : a9 00 __ LDA #$00
1317 : e5 13 __ SBC P6 ; (v + 2)
1319 : 85 13 __ STA P6 ; (v + 2)
131b : a9 00 __ LDA #$00
131d : e5 14 __ SBC P7 ; (v + 3)
131f : 85 14 __ STA P7 ; (v + 3)
1321 : a9 01 __ LDA #$01
1323 : 85 43 __ STA T0 + 0 
.s159:
1325 : a9 10 __ LDA #$10
1327 : 85 44 __ STA T2 + 0 
1329 : a5 14 __ LDA P7 ; (v + 3)
132b : f0 03 __ BEQ $1330 ; (nforml.s1018 + 0)
132d : 4c 14 14 JMP $1414 ; (nforml.l6 + 0)
.s1018:
1330 : a5 13 __ LDA P6 ; (v + 2)
1332 : f0 03 __ BEQ $1337 ; (nforml.s1019 + 0)
1334 : 4c 14 14 JMP $1414 ; (nforml.l6 + 0)
.s1019:
1337 : a5 12 __ LDA P5 ; (v + 1)
1339 : f0 03 __ BEQ $133e ; (nforml.s1020 + 0)
133b : 4c 14 14 JMP $1414 ; (nforml.l6 + 0)
.s1020:
133e : c5 11 __ CMP P4 ; (v + 0)
1340 : b0 03 __ BCS $1345 ; (nforml.s7 + 0)
1342 : 4c 14 14 JMP $1414 ; (nforml.l6 + 0)
.s7:
1345 : a0 02 __ LDY #$02
1347 : b1 0d __ LDA (P0),y ; (si + 0)
1349 : c9 ff __ CMP #$ff
134b : d0 04 __ BNE $1351 ; (nforml.s76 + 0)
.s77:
134d : a9 0f __ LDA #$0f
134f : d0 05 __ BNE $1356 ; (nforml.s1039 + 0)
.s76:
1351 : 38 __ __ SEC
1352 : a9 10 __ LDA #$10
1354 : f1 0d __ SBC (P0),y ; (si + 0)
.s1039:
1356 : a8 __ __ TAY
1357 : c4 44 __ CPY T2 + 0 
1359 : b0 0d __ BCS $1368 ; (nforml.s13 + 0)
.s12:
135b : a9 30 __ LDA #$30
.l1040:
135d : c6 44 __ DEC T2 + 0 
135f : a6 44 __ LDX T2 + 0 
1361 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1364 : c4 44 __ CPY T2 + 0 
1366 : 90 f5 __ BCC $135d ; (nforml.l1040 + 0)
.s13:
1368 : a0 07 __ LDY #$07
136a : b1 0d __ LDA (P0),y ; (si + 0)
136c : f0 20 __ BEQ $138e ; (nforml.s16 + 0)
.s17:
136e : a0 04 __ LDY #$04
1370 : b1 0d __ LDA (P0),y ; (si + 0)
1372 : d0 1a __ BNE $138e ; (nforml.s16 + 0)
.s1013:
1374 : 88 __ __ DEY
1375 : b1 0d __ LDA (P0),y ; (si + 0)
1377 : c9 10 __ CMP #$10
1379 : d0 13 __ BNE $138e ; (nforml.s16 + 0)
.s14:
137b : a9 58 __ LDA #$58
137d : a6 44 __ LDX T2 + 0 
137f : 9d e7 9f STA $9fe7,x ; (si + 7)
1382 : 8a __ __ TXA
1383 : 18 __ __ CLC
1384 : 69 fe __ ADC #$fe
1386 : 85 44 __ STA T2 + 0 
1388 : aa __ __ TAX
1389 : a9 30 __ LDA #$30
138b : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s16:
138e : a9 00 __ LDA #$00
1390 : 85 1b __ STA ACCU + 0 
1392 : a5 43 __ LDA T0 + 0 
1394 : f0 06 __ BEQ $139c ; (nforml.s19 + 0)
.s18:
1396 : c6 44 __ DEC T2 + 0 
1398 : a9 2d __ LDA #$2d
139a : d0 0a __ BNE $13a6 ; (nforml.s1038 + 0)
.s19:
139c : a0 05 __ LDY #$05
139e : b1 0d __ LDA (P0),y ; (si + 0)
13a0 : f0 09 __ BEQ $13ab ; (nforml.s141 + 0)
.s21:
13a2 : c6 44 __ DEC T2 + 0 
13a4 : a9 2b __ LDA #$2b
.s1038:
13a6 : a6 44 __ LDX T2 + 0 
13a8 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s141:
13ab : a0 06 __ LDY #$06
13ad : b1 0d __ LDA (P0),y ; (si + 0)
13af : d0 37 __ BNE $13e8 ; (nforml.s27 + 0)
.l33:
13b1 : a0 01 __ LDY #$01
13b3 : b1 0d __ LDA (P0),y ; (si + 0)
13b5 : 18 __ __ CLC
13b6 : 65 44 __ ADC T2 + 0 
13b8 : b0 04 __ BCS $13be ; (nforml.s34 + 0)
.s1006:
13ba : c9 11 __ CMP #$11
13bc : 90 0e __ BCC $13cc ; (nforml.s36 + 0)
.s34:
13be : c6 44 __ DEC T2 + 0 
13c0 : a0 00 __ LDY #$00
13c2 : b1 0d __ LDA (P0),y ; (si + 0)
13c4 : a6 44 __ LDX T2 + 0 
13c6 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
13c9 : 4c b1 13 JMP $13b1 ; (nforml.l33 + 0)
.s36:
13cc : a6 44 __ LDX T2 + 0 
13ce : e0 10 __ CPX #$10
13d0 : b0 11 __ BCS $13e3 ; (nforml.s26 + 0)
.s1035:
13d2 : 88 __ __ DEY
.l1044:
13d3 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
13d6 : 91 0f __ STA (P2),y ; (str + 0)
13d8 : e6 44 __ INC T2 + 0 
13da : a6 44 __ LDX T2 + 0 
13dc : e0 10 __ CPX #$10
13de : c8 __ __ INY
13df : 90 f2 __ BCC $13d3 ; (nforml.l1044 + 0)
.s1045:
13e1 : 84 1b __ STY ACCU + 0 
.s26:
13e3 : a9 00 __ LDA #$00
13e5 : 85 1c __ STA ACCU + 1 
.s1001:
13e7 : 60 __ __ RTS
.s27:
13e8 : a6 44 __ LDX T2 + 0 
13ea : e0 10 __ CPX #$10
13ec : b0 12 __ BCS $1400 ; (nforml.l30 + 0)
.s1033:
13ee : a0 00 __ LDY #$00
.l1042:
13f0 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
13f3 : 91 0f __ STA (P2),y ; (str + 0)
13f5 : e6 44 __ INC T2 + 0 
13f7 : a6 44 __ LDX T2 + 0 
13f9 : e0 10 __ CPX #$10
13fb : c8 __ __ INY
13fc : 90 f2 __ BCC $13f0 ; (nforml.l1042 + 0)
.s1043:
13fe : 84 1b __ STY ACCU + 0 
.l30:
1400 : a5 1b __ LDA ACCU + 0 
1402 : a0 01 __ LDY #$01
1404 : d1 0d __ CMP (P0),y ; (si + 0)
1406 : b0 db __ BCS $13e3 ; (nforml.s26 + 0)
.s31:
1408 : 88 __ __ DEY
1409 : b1 0d __ LDA (P0),y ; (si + 0)
140b : a4 1b __ LDY ACCU + 0 
140d : 91 0f __ STA (P2),y ; (str + 0)
140f : e6 1b __ INC ACCU + 0 
1411 : 4c 00 14 JMP $1400 ; (nforml.l30 + 0)
.l6:
1414 : a0 03 __ LDY #$03
1416 : b1 0d __ LDA (P0),y ; (si + 0)
1418 : 85 03 __ STA WORK + 0 
141a : 85 45 __ STA T6 + 0 
141c : c8 __ __ INY
141d : b1 0d __ LDA (P0),y ; (si + 0)
141f : 85 46 __ STA T6 + 1 
1421 : 85 04 __ STA WORK + 1 
1423 : a5 11 __ LDA P4 ; (v + 0)
1425 : 85 1b __ STA ACCU + 0 
1427 : a5 12 __ LDA P5 ; (v + 1)
1429 : 85 1c __ STA ACCU + 1 
142b : a5 13 __ LDA P6 ; (v + 2)
142d : 85 1d __ STA ACCU + 2 
142f : a5 14 __ LDA P7 ; (v + 3)
1431 : 85 1e __ STA ACCU + 3 
1433 : a9 00 __ LDA #$00
1435 : 85 05 __ STA WORK + 2 
1437 : 85 06 __ STA WORK + 3 
1439 : 20 dd 24 JSR $24dd ; (divmod32 + 0)
143c : a5 08 __ LDA WORK + 5 
143e : 30 10 __ BMI $1450 ; (nforml.s9 + 0)
.s1023:
1440 : d0 06 __ BNE $1448 ; (nforml.s8 + 0)
.s1022:
1442 : a5 07 __ LDA WORK + 4 
1444 : c9 0a __ CMP #$0a
1446 : 90 08 __ BCC $1450 ; (nforml.s9 + 0)
.s8:
1448 : 18 __ __ CLC
1449 : a5 07 __ LDA WORK + 4 
144b : 69 37 __ ADC #$37
144d : 4c 55 14 JMP $1455 ; (nforml.s10 + 0)
.s9:
1450 : 18 __ __ CLC
1451 : a5 07 __ LDA WORK + 4 
1453 : 69 30 __ ADC #$30
.s10:
1455 : c6 44 __ DEC T2 + 0 
1457 : a6 44 __ LDX T2 + 0 
1459 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
145c : a5 11 __ LDA P4 ; (v + 0)
145e : 85 1b __ STA ACCU + 0 
1460 : a5 12 __ LDA P5 ; (v + 1)
1462 : 85 1c __ STA ACCU + 1 
1464 : a5 13 __ LDA P6 ; (v + 2)
1466 : 85 1d __ STA ACCU + 2 
1468 : a5 14 __ LDA P7 ; (v + 3)
146a : 85 1e __ STA ACCU + 3 
146c : a5 45 __ LDA T6 + 0 
146e : 85 03 __ STA WORK + 0 
1470 : a5 46 __ LDA T6 + 1 
1472 : 85 04 __ STA WORK + 1 
1474 : a9 00 __ LDA #$00
1476 : 85 05 __ STA WORK + 2 
1478 : 85 06 __ STA WORK + 3 
147a : 20 dd 24 JSR $24dd ; (divmod32 + 0)
147d : a5 1b __ LDA ACCU + 0 
147f : 85 11 __ STA P4 ; (v + 0)
1481 : a5 1c __ LDA ACCU + 1 
1483 : 85 12 __ STA P5 ; (v + 1)
1485 : a5 1d __ LDA ACCU + 2 
1487 : 85 13 __ STA P6 ; (v + 2)
1489 : a5 1e __ LDA ACCU + 3 
148b : 85 14 __ STA P7 ; (v + 3)
148d : d0 85 __ BNE $1414 ; (nforml.l6 + 0)
148f : 4c 30 13 JMP $1330 ; (nforml.s1018 + 0)
--------------------------------------------------------------------
nformf:
.s0:
1492 : a5 15 __ LDA P8 ; (f + 0)
1494 : 85 43 __ STA T1 + 0 
1496 : a5 16 __ LDA P9 ; (f + 1)
1498 : 85 44 __ STA T1 + 1 
149a : a5 17 __ LDA P10 ; (f + 2)
149c : 85 45 __ STA T1 + 2 
149e : a5 18 __ LDA P11 ; (f + 3)
14a0 : 29 7f __ AND #$7f
14a2 : 05 17 __ ORA P10 ; (f + 2)
14a4 : 05 16 __ ORA P9 ; (f + 1)
14a6 : 05 15 __ ORA P8 ; (f + 0)
14a8 : f0 21 __ BEQ $14cb ; (nformf.s2 + 0)
.s1005:
14aa : a5 18 __ LDA P11 ; (f + 3)
14ac : 10 1d __ BPL $14cb ; (nformf.s2 + 0)
.s1:
14ae : a9 2d __ LDA #$2d
14b0 : a0 00 __ LDY #$00
14b2 : 91 13 __ STA (P6),y ; (str + 0)
14b4 : a5 18 __ LDA P11 ; (f + 3)
14b6 : 49 80 __ EOR #$80
14b8 : 85 18 __ STA P11 ; (f + 3)
14ba : 85 10 __ STA P3 
14bc : a5 15 __ LDA P8 ; (f + 0)
14be : 85 0d __ STA P0 
14c0 : a5 16 __ LDA P9 ; (f + 1)
14c2 : 85 0e __ STA P1 
14c4 : a5 17 __ LDA P10 ; (f + 2)
14c6 : 85 0f __ STA P2 
14c8 : 4c 4b 19 JMP $194b ; (nformf.s189 + 0)
.s2:
14cb : a5 15 __ LDA P8 ; (f + 0)
14cd : 85 0d __ STA P0 
14cf : a5 16 __ LDA P9 ; (f + 1)
14d1 : 85 0e __ STA P1 
14d3 : a5 17 __ LDA P10 ; (f + 2)
14d5 : 85 0f __ STA P2 
14d7 : a5 18 __ LDA P11 ; (f + 3)
14d9 : 85 10 __ STA P3 
14db : a0 05 __ LDY #$05
14dd : b1 11 __ LDA (P4),y ; (si + 0)
14df : f0 09 __ BEQ $14ea ; (nformf.s3 + 0)
.s4:
14e1 : a9 2b __ LDA #$2b
14e3 : a0 00 __ LDY #$00
14e5 : 91 13 __ STA (P6),y ; (str + 0)
14e7 : 4c 4b 19 JMP $194b ; (nformf.s189 + 0)
.s3:
14ea : 20 63 19 JSR $1963 ; (isinf.s0 + 0)
14ed : aa __ __ TAX
14ee : a9 00 __ LDA #$00
14f0 : 85 48 __ STA T3 + 0 
14f2 : 8a __ __ TXA
14f3 : f0 0b __ BEQ $1500 ; (nformf.s8 + 0)
.s160:
14f5 : a9 01 __ LDA #$01
14f7 : 85 4a __ STA T5 + 0 
14f9 : a9 02 __ LDA #$02
14fb : a0 00 __ LDY #$00
14fd : 4c 2f 19 JMP $192f ; (nformf.s7 + 0)
.s8:
1500 : a0 02 __ LDY #$02
1502 : b1 11 __ LDA (P4),y ; (si + 0)
1504 : c9 ff __ CMP #$ff
1506 : d0 02 __ BNE $150a ; (nformf.s128 + 0)
.s129:
1508 : a9 06 __ LDA #$06
.s128:
150a : 86 4a __ STX T5 + 0 
150c : 86 4b __ STX T5 + 1 
150e : 85 49 __ STA T4 + 0 
1510 : 85 47 __ STA T2 + 0 
1512 : a5 18 __ LDA P11 ; (f + 3)
1514 : 85 46 __ STA T1 + 3 
1516 : 29 7f __ AND #$7f
1518 : 05 17 __ ORA P10 ; (f + 2)
151a : 05 16 __ ORA P9 ; (f + 1)
151c : 05 15 __ ORA P8 ; (f + 0)
151e : f0 03 __ BEQ $1523 ; (nformf.s12 + 0)
1520 : 4c 30 18 JMP $1830 ; (nformf.s13 + 0)
.s12:
1523 : ad f8 9f LDA $9ff8 ; (sstack + 0)
1526 : c9 65 __ CMP #$65
1528 : d0 04 __ BNE $152e ; (nformf.s1007 + 0)
.s1006:
152a : a9 01 __ LDA #$01
152c : d0 02 __ BNE $1530 ; (nformf.s1008 + 0)
.s1007:
152e : a9 00 __ LDA #$00
.s1008:
1530 : 85 4e __ STA T9 + 0 
1532 : a6 49 __ LDX T4 + 0 
1534 : e8 __ __ INX
1535 : 86 4c __ STX T8 + 0 
1537 : ad f8 9f LDA $9ff8 ; (sstack + 0)
153a : c9 67 __ CMP #$67
153c : d0 13 __ BNE $1551 ; (nformf.s24 + 0)
.s22:
153e : a5 4b __ LDA T5 + 1 
1540 : 30 08 __ BMI $154a ; (nformf.s25 + 0)
.s1050:
1542 : d0 06 __ BNE $154a ; (nformf.s25 + 0)
.s1049:
1544 : a5 4a __ LDA T5 + 0 
1546 : c9 04 __ CMP #$04
1548 : 90 07 __ BCC $1551 ; (nformf.s24 + 0)
.s25:
154a : a9 01 __ LDA #$01
154c : 85 4e __ STA T9 + 0 
154e : 4c a8 17 JMP $17a8 ; (nformf.s30 + 0)
.s24:
1551 : a5 4e __ LDA T9 + 0 
1553 : f0 03 __ BEQ $1558 ; (nformf.s32 + 0)
1555 : 4c a8 17 JMP $17a8 ; (nformf.s30 + 0)
.s32:
1558 : a5 4b __ LDA T5 + 1 
155a : 10 3e __ BPL $159a ; (nformf.s34 + 0)
.s33:
155c : a5 43 __ LDA T1 + 0 
155e : 85 1b __ STA ACCU + 0 
1560 : a5 44 __ LDA T1 + 1 
1562 : 85 1c __ STA ACCU + 1 
1564 : a5 45 __ LDA T1 + 2 
1566 : 85 1d __ STA ACCU + 2 
1568 : a5 46 __ LDA T1 + 3 
156a : 85 1e __ STA ACCU + 3 
.l1085:
156c : e6 4a __ INC T5 + 0 
156e : d0 02 __ BNE $1572 ; (nformf.s1095 + 0)
.s1094:
1570 : e6 4b __ INC T5 + 1 
.s1095:
1572 : a9 00 __ LDA #$00
1574 : 85 03 __ STA WORK + 0 
1576 : 85 04 __ STA WORK + 1 
1578 : a9 20 __ LDA #$20
157a : 85 05 __ STA WORK + 2 
157c : a9 41 __ LDA #$41
157e : 85 06 __ STA WORK + 3 
1580 : 20 d3 20 JSR $20d3 ; (freg + 20)
1583 : 20 ba 22 JSR $22ba ; (fdiv + 0)
1586 : a5 4b __ LDA T5 + 1 
1588 : 30 e2 __ BMI $156c ; (nformf.l1085 + 0)
.s1086:
158a : a5 1e __ LDA ACCU + 3 
158c : 85 46 __ STA T1 + 3 
158e : a5 1d __ LDA ACCU + 2 
1590 : 85 45 __ STA T1 + 2 
1592 : a5 1c __ LDA ACCU + 1 
1594 : 85 44 __ STA T1 + 1 
1596 : a5 1b __ LDA ACCU + 0 
1598 : 85 43 __ STA T1 + 0 
.s34:
159a : 18 __ __ CLC
159b : a5 49 __ LDA T4 + 0 
159d : 65 4a __ ADC T5 + 0 
159f : 18 __ __ CLC
15a0 : 69 01 __ ADC #$01
15a2 : 85 4c __ STA T8 + 0 
15a4 : c9 07 __ CMP #$07
15a6 : 90 13 __ BCC $15bb ; (nformf.s35 + 0)
.s36:
15a8 : ad 19 26 LDA $2619 ; (fround5 + 25)
15ab : 85 1c __ STA ACCU + 1 
15ad : ad 1a 26 LDA $261a ; (fround5 + 26)
15b0 : 85 1d __ STA ACCU + 2 
15b2 : ad 1b 26 LDA $261b ; (fround5 + 27)
15b5 : ae 18 26 LDX $2618 ; (fround5 + 24)
15b8 : 4c ce 15 JMP $15ce ; (nformf.s214 + 0)
.s35:
15bb : 0a __ __ ASL
15bc : 0a __ __ ASL
15bd : a8 __ __ TAY
15be : b9 fd 25 LDA $25fd,y ; (joyy + 1)
15c1 : 85 1c __ STA ACCU + 1 
15c3 : b9 fe 25 LDA $25fe,y ; (joyx + 0)
15c6 : 85 1d __ STA ACCU + 2 
15c8 : b9 ff 25 LDA $25ff,y ; (joyx + 1)
15cb : be fc 25 LDX $25fc,y ; (joyy + 0)
.s214:
15ce : 86 1b __ STX ACCU + 0 
15d0 : 85 1e __ STA ACCU + 3 
15d2 : a2 43 __ LDX #$43
15d4 : 20 c3 20 JSR $20c3 ; (freg + 4)
15d7 : 20 04 21 JSR $2104 ; (faddsub + 0)
15da : a5 1c __ LDA ACCU + 1 
15dc : 85 16 __ STA P9 ; (f + 1)
15de : a5 1d __ LDA ACCU + 2 
15e0 : 85 17 __ STA P10 ; (f + 2)
15e2 : a6 1b __ LDX ACCU + 0 
15e4 : a5 1e __ LDA ACCU + 3 
15e6 : 85 18 __ STA P11 ; (f + 3)
15e8 : 30 35 __ BMI $161f ; (nformf.s31 + 0)
.s1032:
15ea : c9 41 __ CMP #$41
15ec : d0 06 __ BNE $15f4 ; (nformf.s1036 + 0)
.s1033:
15ee : a5 17 __ LDA P10 ; (f + 2)
15f0 : c9 20 __ CMP #$20
15f2 : f0 02 __ BEQ $15f6 ; (nformf.s38 + 0)
.s1036:
15f4 : 90 29 __ BCC $161f ; (nformf.s31 + 0)
.s38:
15f6 : a9 00 __ LDA #$00
15f8 : 85 03 __ STA WORK + 0 
15fa : 85 04 __ STA WORK + 1 
15fc : a9 20 __ LDA #$20
15fe : 85 05 __ STA WORK + 2 
1600 : a9 41 __ LDA #$41
1602 : 85 06 __ STA WORK + 3 
1604 : 20 d3 20 JSR $20d3 ; (freg + 20)
1607 : 20 ba 22 JSR $22ba ; (fdiv + 0)
160a : a5 1c __ LDA ACCU + 1 
160c : 85 16 __ STA P9 ; (f + 1)
160e : a5 1d __ LDA ACCU + 2 
1610 : 85 17 __ STA P10 ; (f + 2)
1612 : a5 1e __ LDA ACCU + 3 
1614 : 85 18 __ STA P11 ; (f + 3)
1616 : 18 __ __ CLC
1617 : a5 49 __ LDA T4 + 0 
1619 : 69 ff __ ADC #$ff
161b : 85 47 __ STA T2 + 0 
161d : a6 1b __ LDX ACCU + 0 
.s31:
161f : 38 __ __ SEC
1620 : a5 4c __ LDA T8 + 0 
1622 : e5 47 __ SBC T2 + 0 
1624 : 85 49 __ STA T4 + 0 
1626 : a9 14 __ LDA #$14
1628 : c5 4c __ CMP T8 + 0 
162a : b0 02 __ BCS $162e ; (nformf.s49 + 0)
.s47:
162c : 85 4c __ STA T8 + 0 
.s49:
162e : a5 49 __ LDA T4 + 0 
1630 : d0 08 __ BNE $163a ; (nformf.s219 + 0)
.s50:
1632 : a9 30 __ LDA #$30
1634 : a4 48 __ LDY T3 + 0 
1636 : 91 13 __ STA (P6),y ; (str + 0)
1638 : e6 48 __ INC T3 + 0 
.s219:
163a : a9 00 __ LDA #$00
163c : 85 47 __ STA T2 + 0 
163e : c5 49 __ CMP T4 + 0 
1640 : d0 08 __ BNE $164a ; (nformf.l59 + 0)
.l57:
1642 : a9 2e __ LDA #$2e
1644 : a4 48 __ LDY T3 + 0 
1646 : 91 13 __ STA (P6),y ; (str + 0)
1648 : e6 48 __ INC T3 + 0 
.l59:
164a : a5 47 __ LDA T2 + 0 
164c : c9 07 __ CMP #$07
164e : 90 04 __ BCC $1654 ; (nformf.s61 + 0)
.s60:
1650 : a9 30 __ LDA #$30
1652 : d0 55 __ BNE $16a9 ; (nformf.s208 + 0)
.s61:
1654 : 86 1b __ STX ACCU + 0 
1656 : 86 43 __ STX T1 + 0 
1658 : a5 16 __ LDA P9 ; (f + 1)
165a : 85 1c __ STA ACCU + 1 
165c : 85 44 __ STA T1 + 1 
165e : a5 17 __ LDA P10 ; (f + 2)
1660 : 85 1d __ STA ACCU + 2 
1662 : 85 45 __ STA T1 + 2 
1664 : a5 18 __ LDA P11 ; (f + 3)
1666 : 85 1e __ STA ACCU + 3 
1668 : 85 46 __ STA T1 + 3 
166a : 20 50 24 JSR $2450 ; (f32_to_i16 + 0)
166d : a5 1b __ LDA ACCU + 0 
166f : 85 4f __ STA T11 + 0 
1671 : 20 92 24 JSR $2492 ; (sint16_to_float + 0)
1674 : a2 43 __ LDX #$43
1676 : 20 c3 20 JSR $20c3 ; (freg + 4)
1679 : a5 1e __ LDA ACCU + 3 
167b : 49 80 __ EOR #$80
167d : 85 1e __ STA ACCU + 3 
167f : 20 04 21 JSR $2104 ; (faddsub + 0)
1682 : a9 00 __ LDA #$00
1684 : 85 03 __ STA WORK + 0 
1686 : 85 04 __ STA WORK + 1 
1688 : a9 20 __ LDA #$20
168a : 85 05 __ STA WORK + 2 
168c : a9 41 __ LDA #$41
168e : 85 06 __ STA WORK + 3 
1690 : 20 d3 20 JSR $20d3 ; (freg + 20)
1693 : 20 eb 21 JSR $21eb ; (fmul + 0)
1696 : a5 1c __ LDA ACCU + 1 
1698 : 85 16 __ STA P9 ; (f + 1)
169a : a5 1d __ LDA ACCU + 2 
169c : 85 17 __ STA P10 ; (f + 2)
169e : a5 1e __ LDA ACCU + 3 
16a0 : 85 18 __ STA P11 ; (f + 3)
16a2 : 18 __ __ CLC
16a3 : a5 4f __ LDA T11 + 0 
16a5 : 69 30 __ ADC #$30
16a7 : a6 1b __ LDX ACCU + 0 
.s208:
16a9 : a4 48 __ LDY T3 + 0 
16ab : 91 13 __ STA (P6),y ; (str + 0)
16ad : e6 48 __ INC T3 + 0 
16af : e6 47 __ INC T2 + 0 
16b1 : a5 47 __ LDA T2 + 0 
16b3 : c5 4c __ CMP T8 + 0 
16b5 : b0 07 __ BCS $16be ; (nformf.s56 + 0)
.s54:
16b7 : c5 49 __ CMP T4 + 0 
16b9 : d0 8f __ BNE $164a ; (nformf.l59 + 0)
16bb : 4c 42 16 JMP $1642 ; (nformf.l57 + 0)
.s56:
16be : a5 4e __ LDA T9 + 0 
16c0 : f0 62 __ BEQ $1724 ; (nformf.s9 + 0)
.s63:
16c2 : a9 45 __ LDA #$45
16c4 : a4 48 __ LDY T3 + 0 
16c6 : 91 13 __ STA (P6),y ; (str + 0)
16c8 : c8 __ __ INY
16c9 : a5 4b __ LDA T5 + 1 
16cb : 30 06 __ BMI $16d3 ; (nformf.s66 + 0)
.s67:
16cd : a9 2b __ LDA #$2b
16cf : 91 13 __ STA (P6),y ; (str + 0)
16d1 : d0 11 __ BNE $16e4 ; (nformf.s68 + 0)
.s66:
16d3 : a9 2d __ LDA #$2d
16d5 : 91 13 __ STA (P6),y ; (str + 0)
16d7 : 38 __ __ SEC
16d8 : a9 00 __ LDA #$00
16da : e5 4a __ SBC T5 + 0 
16dc : 85 4a __ STA T5 + 0 
16de : a9 00 __ LDA #$00
16e0 : e5 4b __ SBC T5 + 1 
16e2 : 85 4b __ STA T5 + 1 
.s68:
16e4 : a5 4a __ LDA T5 + 0 
16e6 : 85 1b __ STA ACCU + 0 
16e8 : a5 4b __ LDA T5 + 1 
16ea : 85 1c __ STA ACCU + 1 
16ec : a9 0a __ LDA #$0a
16ee : 85 03 __ STA WORK + 0 
16f0 : a9 00 __ LDA #$00
16f2 : 85 04 __ STA WORK + 1 
16f4 : 20 68 23 JSR $2368 ; (divs16 + 0)
16f7 : 18 __ __ CLC
16f8 : a5 1b __ LDA ACCU + 0 
16fa : 69 30 __ ADC #$30
16fc : a4 48 __ LDY T3 + 0 
16fe : c8 __ __ INY
16ff : c8 __ __ INY
1700 : 91 13 __ STA (P6),y ; (str + 0)
1702 : a5 4a __ LDA T5 + 0 
1704 : 85 1b __ STA ACCU + 0 
1706 : a5 4b __ LDA T5 + 1 
1708 : 85 1c __ STA ACCU + 1 
170a : a9 0a __ LDA #$0a
170c : 85 03 __ STA WORK + 0 
170e : a9 00 __ LDA #$00
1710 : 85 04 __ STA WORK + 1 
1712 : 20 27 24 JSR $2427 ; (mods16 + 0)
1715 : 18 __ __ CLC
1716 : a5 05 __ LDA WORK + 2 
1718 : 69 30 __ ADC #$30
171a : a4 48 __ LDY T3 + 0 
171c : c8 __ __ INY
171d : c8 __ __ INY
171e : c8 __ __ INY
171f : 91 13 __ STA (P6),y ; (str + 0)
1721 : c8 __ __ INY
1722 : 84 48 __ STY T3 + 0 
.s9:
1724 : a5 11 __ LDA P4 ; (si + 0)
1726 : 85 4a __ STA T5 + 0 
1728 : a5 12 __ LDA P5 ; (si + 1)
172a : 85 4b __ STA T5 + 1 
172c : a5 48 __ LDA T3 + 0 
172e : a0 01 __ LDY #$01
1730 : d1 11 __ CMP (P4),y ; (si + 0)
1732 : b0 5d __ BCS $1791 ; (nformf.s1001 + 0)
.s69:
1734 : a0 06 __ LDY #$06
1736 : b1 11 __ LDA (P4),y ; (si + 0)
1738 : f0 06 __ BEQ $1740 ; (nformf.s73 + 0)
.s72:
173a : a5 48 __ LDA T3 + 0 
173c : aa __ __ TAX
173d : 4c 98 17 JMP $1798 ; (nformf.l75 + 0)
.s73:
1740 : a5 48 __ LDA T3 + 0 
1742 : f0 2d __ BEQ $1771 ; (nformf.s82 + 0)
.s90:
1744 : a9 01 __ LDA #$01
1746 : 85 47 __ STA T2 + 0 
1748 : a6 48 __ LDX T3 + 0 
174a : 38 __ __ SEC
.l1083:
174b : a0 01 __ LDY #$01
174d : b1 11 __ LDA (P4),y ; (si + 0)
174f : e5 47 __ SBC T2 + 0 
1751 : 85 4c __ STA T8 + 0 
1753 : a9 ff __ LDA #$ff
1755 : 65 14 __ ADC P7 ; (str + 1)
1757 : 85 4d __ STA T8 + 1 
1759 : 8a __ __ TXA
175a : 38 __ __ SEC
175b : e5 47 __ SBC T2 + 0 
175d : 85 1b __ STA ACCU + 0 
175f : a9 ff __ LDA #$ff
1761 : 65 14 __ ADC P7 ; (str + 1)
1763 : 85 1c __ STA ACCU + 1 
1765 : a4 13 __ LDY P6 ; (str + 0)
1767 : b1 1b __ LDA (ACCU + 0),y 
1769 : 91 4c __ STA (T8 + 0),y 
176b : e6 47 __ INC T2 + 0 
176d : e4 47 __ CPX T2 + 0 
176f : b0 da __ BCS $174b ; (nformf.l1083 + 0)
.s82:
1771 : a9 00 __ LDA #$00
1773 : 85 47 __ STA T2 + 0 
.l83:
1775 : a0 01 __ LDY #$01
1777 : b1 4a __ LDA (T5 + 0),y 
1779 : 38 __ __ SEC
177a : e5 48 __ SBC T3 + 0 
177c : 90 06 __ BCC $1784 ; (nformf.s84 + 0)
.s1011:
177e : c5 47 __ CMP T2 + 0 
1780 : 90 0d __ BCC $178f ; (nformf.s74 + 0)
.s1087:
1782 : f0 0b __ BEQ $178f ; (nformf.s74 + 0)
.s84:
1784 : a9 20 __ LDA #$20
1786 : a4 47 __ LDY T2 + 0 
1788 : 91 13 __ STA (P6),y ; (str + 0)
178a : e6 47 __ INC T2 + 0 
178c : 4c 75 17 JMP $1775 ; (nformf.l83 + 0)
.s74:
178f : b1 11 __ LDA (P4),y ; (si + 0)
.s1001:
1791 : 85 1b __ STA ACCU + 0 
1793 : a9 00 __ LDA #$00
1795 : 85 1c __ STA ACCU + 1 
1797 : 60 __ __ RTS
.l75:
1798 : a0 01 __ LDY #$01
179a : d1 4a __ CMP (T5 + 0),y 
179c : b0 f1 __ BCS $178f ; (nformf.s74 + 0)
.s76:
179e : a8 __ __ TAY
179f : a9 20 __ LDA #$20
17a1 : 91 13 __ STA (P6),y ; (str + 0)
17a3 : e8 __ __ INX
17a4 : 8a __ __ TXA
17a5 : 4c 98 17 JMP $1798 ; (nformf.l75 + 0)
.s30:
17a8 : a5 4c __ LDA T8 + 0 
17aa : c9 07 __ CMP #$07
17ac : 90 13 __ BCC $17c1 ; (nformf.s41 + 0)
.s42:
17ae : ad 19 26 LDA $2619 ; (fround5 + 25)
17b1 : 85 1c __ STA ACCU + 1 
17b3 : ad 1a 26 LDA $261a ; (fround5 + 26)
17b6 : 85 1d __ STA ACCU + 2 
17b8 : ad 1b 26 LDA $261b ; (fround5 + 27)
17bb : ae 18 26 LDX $2618 ; (fround5 + 24)
17be : 4c d4 17 JMP $17d4 ; (nformf.s204 + 0)
.s41:
17c1 : 0a __ __ ASL
17c2 : 0a __ __ ASL
17c3 : a8 __ __ TAY
17c4 : b9 fd 25 LDA $25fd,y ; (joyy + 1)
17c7 : 85 1c __ STA ACCU + 1 
17c9 : b9 fe 25 LDA $25fe,y ; (joyx + 0)
17cc : 85 1d __ STA ACCU + 2 
17ce : b9 ff 25 LDA $25ff,y ; (joyx + 1)
17d1 : be fc 25 LDX $25fc,y ; (joyy + 0)
.s204:
17d4 : 86 1b __ STX ACCU + 0 
17d6 : 85 1e __ STA ACCU + 3 
17d8 : a2 43 __ LDX #$43
17da : 20 c3 20 JSR $20c3 ; (freg + 4)
17dd : 20 04 21 JSR $2104 ; (faddsub + 0)
17e0 : a5 1c __ LDA ACCU + 1 
17e2 : 85 16 __ STA P9 ; (f + 1)
17e4 : a5 1d __ LDA ACCU + 2 
17e6 : 85 17 __ STA P10 ; (f + 2)
17e8 : a6 1b __ LDX ACCU + 0 
17ea : a5 1e __ LDA ACCU + 3 
17ec : 85 18 __ STA P11 ; (f + 3)
17ee : 10 03 __ BPL $17f3 ; (nformf.s1042 + 0)
17f0 : 4c 1f 16 JMP $161f ; (nformf.s31 + 0)
.s1042:
17f3 : c9 41 __ CMP #$41
17f5 : d0 06 __ BNE $17fd ; (nformf.s1046 + 0)
.s1043:
17f7 : a5 17 __ LDA P10 ; (f + 2)
17f9 : c9 20 __ CMP #$20
17fb : f0 05 __ BEQ $1802 ; (nformf.s44 + 0)
.s1046:
17fd : b0 03 __ BCS $1802 ; (nformf.s44 + 0)
17ff : 4c 1f 16 JMP $161f ; (nformf.s31 + 0)
.s44:
1802 : a9 00 __ LDA #$00
1804 : 85 03 __ STA WORK + 0 
1806 : 85 04 __ STA WORK + 1 
1808 : a9 20 __ LDA #$20
180a : 85 05 __ STA WORK + 2 
180c : a9 41 __ LDA #$41
180e : 85 06 __ STA WORK + 3 
1810 : 20 d3 20 JSR $20d3 ; (freg + 20)
1813 : 20 ba 22 JSR $22ba ; (fdiv + 0)
1816 : a5 1c __ LDA ACCU + 1 
1818 : 85 16 __ STA P9 ; (f + 1)
181a : a5 1d __ LDA ACCU + 2 
181c : 85 17 __ STA P10 ; (f + 2)
181e : a5 1e __ LDA ACCU + 3 
1820 : 85 18 __ STA P11 ; (f + 3)
1822 : a6 1b __ LDX ACCU + 0 
1824 : e6 4a __ INC T5 + 0 
1826 : f0 03 __ BEQ $182b ; (nformf.s1092 + 0)
1828 : 4c 1f 16 JMP $161f ; (nformf.s31 + 0)
.s1092:
182b : e6 4b __ INC T5 + 1 
182d : 4c 1f 16 JMP $161f ; (nformf.s31 + 0)
.s13:
1830 : a5 18 __ LDA P11 ; (f + 3)
1832 : 30 59 __ BMI $188d ; (nformf.l17 + 0)
.l1072:
1834 : c9 44 __ CMP #$44
1836 : f0 03 __ BEQ $183b ; (nformf.s1073 + 0)
1838 : 4c 2a 19 JMP $192a ; (nformf.s1076 + 0)
.s1073:
183b : a5 45 __ LDA T1 + 2 
183d : c9 7a __ CMP #$7a
183f : f0 03 __ BEQ $1844 ; (nformf.s1074 + 0)
1841 : 4c 2a 19 JMP $192a ; (nformf.s1076 + 0)
.s1074:
1844 : a5 44 __ LDA T1 + 1 
1846 : d0 04 __ BNE $184c ; (nformf.s1082 + 0)
.s1075:
1848 : a5 43 __ LDA T1 + 0 
184a : f0 02 __ BEQ $184e ; (nformf.s14 + 0)
.s1082:
184c : a5 43 __ LDA T1 + 0 
.s14:
184e : 85 1b __ STA ACCU + 0 
1850 : a5 44 __ LDA T1 + 1 
1852 : 85 1c __ STA ACCU + 1 
1854 : a5 45 __ LDA T1 + 2 
1856 : 85 1d __ STA ACCU + 2 
1858 : a5 46 __ LDA T1 + 3 
185a : 85 1e __ STA ACCU + 3 
185c : a9 00 __ LDA #$00
185e : 85 03 __ STA WORK + 0 
1860 : 85 04 __ STA WORK + 1 
1862 : a9 7a __ LDA #$7a
1864 : 85 05 __ STA WORK + 2 
1866 : a9 44 __ LDA #$44
1868 : 85 06 __ STA WORK + 3 
186a : 20 d3 20 JSR $20d3 ; (freg + 20)
186d : 20 ba 22 JSR $22ba ; (fdiv + 0)
1870 : a5 1b __ LDA ACCU + 0 
1872 : 85 43 __ STA T1 + 0 
1874 : a5 1c __ LDA ACCU + 1 
1876 : 85 44 __ STA T1 + 1 
1878 : a5 1d __ LDA ACCU + 2 
187a : 85 45 __ STA T1 + 2 
187c : 18 __ __ CLC
187d : a5 4a __ LDA T5 + 0 
187f : 69 03 __ ADC #$03
1881 : 85 4a __ STA T5 + 0 
1883 : 90 02 __ BCC $1887 ; (nformf.s1097 + 0)
.s1096:
1885 : e6 4b __ INC T5 + 1 
.s1097:
1887 : a5 1e __ LDA ACCU + 3 
1889 : 85 46 __ STA T1 + 3 
188b : 10 a7 __ BPL $1834 ; (nformf.l1072 + 0)
.l17:
188d : a9 00 __ LDA #$00
188f : 85 1b __ STA ACCU + 0 
1891 : 85 1c __ STA ACCU + 1 
1893 : a9 7a __ LDA #$7a
1895 : 85 1d __ STA ACCU + 2 
1897 : a9 44 __ LDA #$44
1899 : 85 1e __ STA ACCU + 3 
189b : a2 43 __ LDX #$43
189d : 20 c3 20 JSR $20c3 ; (freg + 4)
18a0 : 20 eb 21 JSR $21eb ; (fmul + 0)
18a3 : a5 1b __ LDA ACCU + 0 
18a5 : 85 43 __ STA T1 + 0 
18a7 : a5 1c __ LDA ACCU + 1 
18a9 : 85 44 __ STA T1 + 1 
18ab : a5 1d __ LDA ACCU + 2 
18ad : 85 45 __ STA T1 + 2 
18af : a5 1e __ LDA ACCU + 3 
18b1 : 85 46 __ STA T1 + 3 
18b3 : 38 __ __ SEC
18b4 : a5 4a __ LDA T5 + 0 
18b6 : e9 03 __ SBC #$03
18b8 : 85 4a __ STA T5 + 0 
18ba : b0 02 __ BCS $18be ; (nformf.s16 + 0)
.s1088:
18bc : c6 4b __ DEC T5 + 1 
.s16:
18be : a5 46 __ LDA T1 + 3 
18c0 : 30 cb __ BMI $188d ; (nformf.l17 + 0)
.s1064:
18c2 : c9 3f __ CMP #$3f
18c4 : d0 06 __ BNE $18cc ; (nformf.s1068 + 0)
.s1065:
18c6 : a5 45 __ LDA T1 + 2 
18c8 : c9 80 __ CMP #$80
18ca : f0 02 __ BEQ $18ce ; (nformf.s19 + 0)
.s1068:
18cc : 90 bf __ BCC $188d ; (nformf.l17 + 0)
.s19:
18ce : a5 46 __ LDA T1 + 3 
18d0 : c9 41 __ CMP #$41
18d2 : d0 51 __ BNE $1925 ; (nformf.l1060 + 0)
.s1057:
18d4 : a5 45 __ LDA T1 + 2 
18d6 : c9 20 __ CMP #$20
18d8 : d0 4b __ BNE $1925 ; (nformf.l1060 + 0)
.s1058:
18da : a5 44 __ LDA T1 + 1 
18dc : d0 04 __ BNE $18e2 ; (nformf.l1081 + 0)
.s1059:
18de : a5 43 __ LDA T1 + 0 
18e0 : f0 02 __ BEQ $18e4 ; (nformf.l20 + 0)
.l1081:
18e2 : a5 43 __ LDA T1 + 0 
.l20:
18e4 : 85 1b __ STA ACCU + 0 
18e6 : a5 44 __ LDA T1 + 1 
18e8 : 85 1c __ STA ACCU + 1 
18ea : a5 45 __ LDA T1 + 2 
18ec : 85 1d __ STA ACCU + 2 
18ee : a5 46 __ LDA T1 + 3 
18f0 : 85 1e __ STA ACCU + 3 
18f2 : a9 00 __ LDA #$00
18f4 : 85 03 __ STA WORK + 0 
18f6 : 85 04 __ STA WORK + 1 
18f8 : a9 20 __ LDA #$20
18fa : 85 05 __ STA WORK + 2 
18fc : a9 41 __ LDA #$41
18fe : 85 06 __ STA WORK + 3 
1900 : 20 d3 20 JSR $20d3 ; (freg + 20)
1903 : 20 ba 22 JSR $22ba ; (fdiv + 0)
1906 : a5 1b __ LDA ACCU + 0 
1908 : 85 43 __ STA T1 + 0 
190a : a5 1c __ LDA ACCU + 1 
190c : 85 44 __ STA T1 + 1 
190e : a5 1d __ LDA ACCU + 2 
1910 : 85 45 __ STA T1 + 2 
1912 : e6 4a __ INC T5 + 0 
1914 : d0 02 __ BNE $1918 ; (nformf.s1091 + 0)
.s1090:
1916 : e6 4b __ INC T5 + 1 
.s1091:
1918 : a5 1e __ LDA ACCU + 3 
191a : 85 46 __ STA T1 + 3 
191c : 10 03 __ BPL $1921 ; (nformf.s1056 + 0)
191e : 4c 23 15 JMP $1523 ; (nformf.s12 + 0)
.s1056:
1921 : c9 41 __ CMP #$41
1923 : f0 af __ BEQ $18d4 ; (nformf.s1057 + 0)
.l1060:
1925 : b0 bb __ BCS $18e2 ; (nformf.l1081 + 0)
1927 : 4c 23 15 JMP $1523 ; (nformf.s12 + 0)
.s1076:
192a : 90 92 __ BCC $18be ; (nformf.s16 + 0)
192c : 4c 4c 18 JMP $184c ; (nformf.s1082 + 0)
.s7:
192f : 85 1b __ STA ACCU + 0 
1931 : a9 49 __ LDA #$49
1933 : 91 13 __ STA (P6),y ; (str + 0)
1935 : a9 4e __ LDA #$4e
1937 : a4 4a __ LDY T5 + 0 
1939 : 91 13 __ STA (P6),y ; (str + 0)
193b : a9 46 __ LDA #$46
193d : a4 1b __ LDY ACCU + 0 
193f : 91 13 __ STA (P6),y ; (str + 0)
1941 : 18 __ __ CLC
1942 : a5 48 __ LDA T3 + 0 
1944 : 69 03 __ ADC #$03
1946 : 85 48 __ STA T3 + 0 
1948 : 4c 24 17 JMP $1724 ; (nformf.s9 + 0)
.s189:
194b : 20 63 19 JSR $1963 ; (isinf.s0 + 0)
194e : aa __ __ TAX
194f : a9 01 __ LDA #$01
1951 : 85 48 __ STA T3 + 0 
1953 : 8a __ __ TXA
1954 : d0 03 __ BNE $1959 ; (nformf.s158 + 0)
1956 : 4c 00 15 JMP $1500 ; (nformf.s8 + 0)
.s158:
1959 : a9 02 __ LDA #$02
195b : 85 4a __ STA T5 + 0 
195d : a9 03 __ LDA #$03
195f : a0 01 __ LDY #$01
1961 : d0 cc __ BNE $192f ; (nformf.s7 + 0)
--------------------------------------------------------------------
isinf:
.s0:
1963 : 06 0f __ ASL P2 ; (f + 2)
1965 : a5 10 __ LDA P3 ; (f + 3)
1967 : 2a __ __ ROL
1968 : c9 ff __ CMP #$ff
196a : d0 03 __ BNE $196f ; (isinf.s1003 + 0)
.s1002:
196c : a9 01 __ LDA #$01
196e : 60 __ __ RTS
.s1003:
196f : a9 00 __ LDA #$00
.s1001:
1971 : 60 __ __ RTS
--------------------------------------------------------------------
fround5:
2600 : __ __ __ BYT 00 00 00 3f cd cc 4c 3d 0a d7 a3 3b 6f 12 03 3a : ...?..L=...;o..:
2610 : __ __ __ BYT 17 b7 51 38 ac c5 a7 36 bd 37 06 35             : ..Q8...6.7.5
--------------------------------------------------------------------
1972 : __ __ __ BYT 25 64 00                                        : %d.
--------------------------------------------------------------------
1975 : __ __ __ BYT 53 48 49 50 53 3a 00                            : SHIPS:.
--------------------------------------------------------------------
spawn_enemy:
.s0:
197c : 20 ec 19 JSR $19ec ; (rand.s0 + 0)
197f : 46 1b __ LSR ACCU + 0 
1981 : b0 0f __ BCS $1992 ; (spawn_enemy.s1001 + 0)
.s3:
1983 : a0 00 __ LDY #$00
.l6:
1985 : be 73 25 LDX $2573,y ; (__multab5L + 0)
1988 : bd 2a 26 LDA $262a,x ; (Enemy + 4)
198b : f0 06 __ BEQ $1993 ; (spawn_enemy.s9 + 0)
.s7:
198d : c8 __ __ INY
198e : c0 0a __ CPY #$0a
1990 : 90 f3 __ BCC $1985 ; (spawn_enemy.l6 + 0)
.s1001:
1992 : 60 __ __ RTS
.s9:
1993 : 86 43 __ STX T0 + 0 
1995 : a9 27 __ LDA #$27
1997 : 9d 26 26 STA $2626,x ; (Enemy + 0)
199a : 20 ec 19 JSR $19ec ; (rand.s0 + 0)
199d : a9 14 __ LDA #$14
199f : 85 03 __ STA WORK + 0 
19a1 : a9 00 __ LDA #$00
19a3 : 85 04 __ STA WORK + 1 
19a5 : 20 a2 23 JSR $23a2 ; (divmod + 0)
19a8 : 18 __ __ CLC
19a9 : a5 05 __ LDA WORK + 2 
19ab : 69 04 __ ADC #$04
19ad : a6 43 __ LDX T0 + 0 
19af : 9d 27 26 STA $2627,x ; (Enemy + 1)
19b2 : 20 ec 19 JSR $19ec ; (rand.s0 + 0)
19b5 : a9 0e __ LDA #$0e
19b7 : a6 43 __ LDX T0 + 0 
19b9 : 9d 29 26 STA $2629,x ; (Enemy + 3)
19bc : a9 01 __ LDA #$01
19be : 9d 2a 26 STA $262a,x ; (Enemy + 4)
19c1 : a9 03 __ LDA #$03
19c3 : 85 03 __ STA WORK + 0 
19c5 : a9 00 __ LDA #$00
19c7 : 85 04 __ STA WORK + 1 
19c9 : 20 a2 23 JSR $23a2 ; (divmod + 0)
19cc : 18 __ __ CLC
19cd : a5 05 __ LDA WORK + 2 
19cf : 69 83 __ ADC #$83
19d1 : a4 43 __ LDY T0 + 0 
19d3 : 99 28 26 STA $2628,y ; (Enemy + 2)
19d6 : c9 83 __ CMP #$83
19d8 : d0 04 __ BNE $19de ; (spawn_enemy.s13 + 0)
.s12:
19da : a9 0d __ LDA #$0d
19dc : d0 0a __ BNE $19e8 ; (spawn_enemy.s1008 + 0)
.s13:
19de : c9 84 __ CMP #$84
19e0 : d0 04 __ BNE $19e6 ; (spawn_enemy.s16 + 0)
.s15:
19e2 : a9 0a __ LDA #$0a
19e4 : d0 02 __ BNE $19e8 ; (spawn_enemy.s1008 + 0)
.s16:
19e6 : a9 09 __ LDA #$09
.s1008:
19e8 : 99 29 26 STA $2629,y ; (Enemy + 3)
19eb : 60 __ __ RTS
--------------------------------------------------------------------
rand:
.s0:
19ec : ad f3 25 LDA $25f3 ; (seed + 1)
19ef : 4a __ __ LSR
19f0 : ad f2 25 LDA $25f2 ; (seed + 0)
19f3 : 6a __ __ ROR
19f4 : aa __ __ TAX
19f5 : a9 00 __ LDA #$00
19f7 : 6a __ __ ROR
19f8 : 4d f2 25 EOR $25f2 ; (seed + 0)
19fb : 85 1b __ STA ACCU + 0 
19fd : 8a __ __ TXA
19fe : 4d f3 25 EOR $25f3 ; (seed + 1)
1a01 : 85 1c __ STA ACCU + 1 
1a03 : 4a __ __ LSR
1a04 : 45 1b __ EOR ACCU + 0 
1a06 : 8d f2 25 STA $25f2 ; (seed + 0)
1a09 : 85 1b __ STA ACCU + 0 
1a0b : 45 1c __ EOR ACCU + 1 
1a0d : 8d f3 25 STA $25f3 ; (seed + 1)
1a10 : 85 1c __ STA ACCU + 1 
.s1001:
1a12 : 60 __ __ RTS
--------------------------------------------------------------------
seed:
25f2 : __ __ __ BYT 00 7a                                           : .z
--------------------------------------------------------------------
move_enemies:
.s0:
1a13 : a2 00 __ LDX #$00
.l2:
1a15 : 86 43 __ STX T0 + 0 
1a17 : bc 73 25 LDY $2573,x ; (__multab5L + 0)
1a1a : b9 2a 26 LDA $262a,y ; (Enemy + 4)
1a1d : c9 01 __ CMP #$01
1a1f : d0 75 __ BNE $1a96 ; (move_enemies.s41 + 0)
.s5:
1a21 : 18 __ __ CLC
1a22 : a9 26 __ LDA #$26
1a24 : 7d 73 25 ADC $2573,x ; (__multab5L + 0)
1a27 : 85 44 __ STA T1 + 0 
1a29 : a9 26 __ LDA #$26
1a2b : 69 00 __ ADC #$00
1a2d : 85 45 __ STA T1 + 1 
1a2f : a0 02 __ LDY #$02
1a31 : b1 44 __ LDA (T1 + 0),y 
1a33 : c9 83 __ CMP #$83
1a35 : d0 16 __ BNE $1a4d ; (move_enemies.s10 + 0)
.s11:
1a37 : 88 __ __ DEY
1a38 : b1 44 __ LDA (T1 + 0),y 
1a3a : cd fb 25 CMP $25fb ; (Player + 1)
1a3d : d0 0e __ BNE $1a4d ; (move_enemies.s10 + 0)
.s8:
1a3f : a5 44 __ LDA T1 + 0 
1a41 : 85 0d __ STA P0 
1a43 : a5 45 __ LDA T1 + 1 
1a45 : 85 0e __ STA P1 
1a47 : 20 03 1b JSR $1b03 ; (spawn_enemy_shot.s0 + 0)
1a4a : 20 36 1b JSR $1b36 ; (render_enemy_shots.s0 + 0)
.s10:
1a4d : a0 00 __ LDY #$00
1a4f : b1 44 __ LDA (T1 + 0),y 
1a51 : 85 46 __ STA T3 + 0 
1a53 : c8 __ __ INY
1a54 : b1 44 __ LDA (T1 + 0),y 
1a56 : 0a __ __ ASL
1a57 : 85 1b __ STA ACCU + 0 
1a59 : a9 00 __ LDA #$00
1a5b : 2a __ __ ROL
1a5c : 06 1b __ ASL ACCU + 0 
1a5e : 2a __ __ ROL
1a5f : aa __ __ TAX
1a60 : a5 1b __ LDA ACCU + 0 
1a62 : 71 44 __ ADC (T1 + 0),y 
1a64 : 85 1b __ STA ACCU + 0 
1a66 : 8a __ __ TXA
1a67 : 69 00 __ ADC #$00
1a69 : 06 1b __ ASL ACCU + 0 
1a6b : 2a __ __ ROL
1a6c : 06 1b __ ASL ACCU + 0 
1a6e : 2a __ __ ROL
1a6f : 06 1b __ ASL ACCU + 0 
1a71 : 2a __ __ ROL
1a72 : aa __ __ TAX
1a73 : 18 __ __ CLC
1a74 : a5 1b __ LDA ACCU + 0 
1a76 : 65 46 __ ADC T3 + 0 
1a78 : 85 1b __ STA ACCU + 0 
1a7a : 85 1f __ STA ADDR + 0 
1a7c : 8a __ __ TXA
1a7d : 69 c0 __ ADC #$c0
1a7f : 85 1c __ STA ACCU + 1 
1a81 : 18 __ __ CLC
1a82 : 69 18 __ ADC #$18
1a84 : 85 20 __ STA ADDR + 1 
1a86 : a9 20 __ LDA #$20
1a88 : 88 __ __ DEY
1a89 : 91 1b __ STA (ACCU + 0),y 
1a8b : 98 __ __ TYA
1a8c : 91 1f __ STA (ADDR + 0),y 
1a8e : a5 46 __ LDA T3 + 0 
1a90 : d0 0f __ BNE $1aa1 ; (move_enemies.s12 + 0)
.s13:
1a92 : a0 04 __ LDY #$04
.s1020:
1a94 : 91 44 __ STA (T1 + 0),y 
.s41:
1a96 : a6 43 __ LDX T0 + 0 
1a98 : e8 __ __ INX
1a99 : e0 0a __ CPX #$0a
1a9b : b0 03 __ BCS $1aa0 ; (move_enemies.s1001 + 0)
1a9d : 4c 15 1a JMP $1a15 ; (move_enemies.l2 + 0)
.s1001:
1aa0 : 60 __ __ RTS
.s12:
1aa1 : c6 46 __ DEC T3 + 0 
1aa3 : a5 46 __ LDA T3 + 0 
1aa5 : 91 44 __ STA (T1 + 0),y 
1aa7 : a0 02 __ LDY #$02
1aa9 : b1 44 __ LDA (T1 + 0),y 
1aab : c9 85 __ CMP #$85
1aad : f0 e7 __ BEQ $1a96 ; (move_enemies.s41 + 0)
.s15:
1aaf : 20 ec 19 JSR $19ec ; (rand.s0 + 0)
1ab2 : a0 01 __ LDY #$01
1ab4 : b1 44 __ LDA (T1 + 0),y 
1ab6 : 85 47 __ STA T4 + 0 
1ab8 : a9 03 __ LDA #$03
1aba : 85 03 __ STA WORK + 0 
1abc : a9 00 __ LDA #$00
1abe : 85 04 __ STA WORK + 1 
1ac0 : 20 a2 23 JSR $23a2 ; (divmod + 0)
1ac3 : 38 __ __ SEC
1ac4 : a5 05 __ LDA WORK + 2 
1ac6 : e9 01 __ SBC #$01
1ac8 : aa __ __ TAX
1ac9 : a5 06 __ LDA WORK + 3 
1acb : e9 00 __ SBC #$00
1acd : a8 __ __ TAY
1ace : 8a __ __ TXA
1acf : 18 __ __ CLC
1ad0 : 65 47 __ ADC T4 + 0 
1ad2 : 85 1b __ STA ACCU + 0 
1ad4 : 90 01 __ BCC $1ad7 ; (move_enemies.s1022 + 0)
.s1021:
1ad6 : c8 __ __ INY
.s1022:
1ad7 : 0a __ __ ASL
1ad8 : 0a __ __ ASL
1ad9 : 18 __ __ CLC
1ada : 65 1b __ ADC ACCU + 0 
1adc : 0a __ __ ASL
1add : 0a __ __ ASL
1ade : 0a __ __ ASL
1adf : 18 __ __ CLC
1ae0 : 65 46 __ ADC T3 + 0 
1ae2 : aa __ __ TAX
1ae3 : bd 00 c0 LDA $c000,x 
1ae6 : c9 83 __ CMP #$83
1ae8 : f0 ac __ BEQ $1a96 ; (move_enemies.s41 + 0)
.s24:
1aea : c9 84 __ CMP #$84
1aec : f0 a8 __ BEQ $1a96 ; (move_enemies.s41 + 0)
.s23:
1aee : c9 85 __ CMP #$85
1af0 : f0 a4 __ BEQ $1a96 ; (move_enemies.s41 + 0)
.s22:
1af2 : 98 __ __ TYA
1af3 : d0 a1 __ BNE $1a96 ; (move_enemies.s41 + 0)
.s1005:
1af5 : a5 1b __ LDA ACCU + 0 
1af7 : c9 04 __ CMP #$04
1af9 : 90 9b __ BCC $1a96 ; (move_enemies.s41 + 0)
.s1004:
1afb : c9 18 __ CMP #$18
1afd : b0 97 __ BCS $1a96 ; (move_enemies.s41 + 0)
.s18:
1aff : a0 01 __ LDY #$01
1b01 : d0 91 __ BNE $1a94 ; (move_enemies.s1020 + 0)
--------------------------------------------------------------------
spawn_enemy_shot:
.s0:
1b03 : a0 00 __ LDY #$00
1b05 : b1 0d __ LDA (P0),y ; (e + 0)
1b07 : f0 0f __ BEQ $1b18 ; (spawn_enemy_shot.s1001 + 0)
.s3:
1b09 : a2 00 __ LDX #$00
.l6:
1b0b : bc 7d 25 LDY $257d,x ; (__multab3L + 0)
1b0e : b9 63 26 LDA $2663,y ; (EnemyShot + 2)
1b11 : f0 06 __ BEQ $1b19 ; (spawn_enemy_shot.s9 + 0)
.s7:
1b13 : e8 __ __ INX
1b14 : e0 03 __ CPX #$03
1b16 : 90 f3 __ BCC $1b0b ; (spawn_enemy_shot.l6 + 0)
.s1001:
1b18 : 60 __ __ RTS
.s9:
1b19 : a9 01 __ LDA #$01
1b1b : 99 63 26 STA $2663,y ; (EnemyShot + 2)
1b1e : a0 00 __ LDY #$00
1b20 : b1 0d __ LDA (P0),y ; (e + 0)
1b22 : 38 __ __ SEC
1b23 : e9 01 __ SBC #$01
1b25 : bc 7d 25 LDY $257d,x ; (__multab3L + 0)
1b28 : 99 61 26 STA $2661,y ; (EnemyShot + 0)
1b2b : a0 01 __ LDY #$01
1b2d : b1 0d __ LDA (P0),y ; (e + 0)
1b2f : bc 7d 25 LDY $257d,x ; (__multab3L + 0)
1b32 : 99 62 26 STA $2662,y ; (EnemyShot + 1)
1b35 : 60 __ __ RTS
--------------------------------------------------------------------
render_enemy_shots:
.s0:
1b36 : a2 00 __ LDX #$00
.l1006:
1b38 : bc 7d 25 LDY $257d,x ; (__multab3L + 0)
1b3b : b9 63 26 LDA $2663,y ; (EnemyShot + 2)
1b3e : c9 01 __ CMP #$01
1b40 : d0 43 __ BNE $1b85 ; (render_enemy_shots.s19 + 0)
.s5:
1b42 : b9 62 26 LDA $2662,y ; (EnemyShot + 1)
1b45 : 0a __ __ ASL
1b46 : 85 1b __ STA ACCU + 0 
1b48 : a9 00 __ LDA #$00
1b4a : 2a __ __ ROL
1b4b : 06 1b __ ASL ACCU + 0 
1b4d : 2a __ __ ROL
1b4e : 85 1c __ STA ACCU + 1 
1b50 : a5 1b __ LDA ACCU + 0 
1b52 : 79 62 26 ADC $2662,y ; (EnemyShot + 1)
1b55 : 85 1b __ STA ACCU + 0 
1b57 : a5 1c __ LDA ACCU + 1 
1b59 : 69 00 __ ADC #$00
1b5b : 06 1b __ ASL ACCU + 0 
1b5d : 2a __ __ ROL
1b5e : 06 1b __ ASL ACCU + 0 
1b60 : 2a __ __ ROL
1b61 : 06 1b __ ASL ACCU + 0 
1b63 : 2a __ __ ROL
1b64 : 85 1c __ STA ACCU + 1 
1b66 : 18 __ __ CLC
1b67 : a5 1b __ LDA ACCU + 0 
1b69 : 79 61 26 ADC $2661,y ; (EnemyShot + 0)
1b6c : 85 1b __ STA ACCU + 0 
1b6e : 85 1f __ STA ADDR + 0 
1b70 : a5 1c __ LDA ACCU + 1 
1b72 : 69 c0 __ ADC #$c0
1b74 : 85 1c __ STA ACCU + 1 
1b76 : 18 __ __ CLC
1b77 : 69 18 __ ADC #$18
1b79 : 85 20 __ STA ADDR + 1 
1b7b : a9 82 __ LDA #$82
1b7d : a0 00 __ LDY #$00
1b7f : 91 1b __ STA (ACCU + 0),y 
1b81 : a9 01 __ LDA #$01
1b83 : 91 1f __ STA (ADDR + 0),y 
.s19:
1b85 : e8 __ __ INX
1b86 : e0 03 __ CPX #$03
1b88 : 90 ae __ BCC $1b38 ; (render_enemy_shots.l1006 + 0)
.s1001:
1b8a : 60 __ __ RTS
--------------------------------------------------------------------
render_enemies:
.s0:
1b8b : a2 00 __ LDX #$00
.l1006:
1b8d : bc 73 25 LDY $2573,x ; (__multab5L + 0)
1b90 : b9 2a 26 LDA $262a,y ; (Enemy + 4)
1b93 : c9 01 __ CMP #$01
1b95 : d0 4b __ BNE $1be2 ; (render_enemies.s19 + 0)
.s5:
1b97 : 84 1d __ STY ACCU + 2 
1b99 : b9 27 26 LDA $2627,y ; (Enemy + 1)
1b9c : 0a __ __ ASL
1b9d : 85 1b __ STA ACCU + 0 
1b9f : a9 00 __ LDA #$00
1ba1 : 2a __ __ ROL
1ba2 : 06 1b __ ASL ACCU + 0 
1ba4 : 2a __ __ ROL
1ba5 : 85 1c __ STA ACCU + 1 
1ba7 : a5 1b __ LDA ACCU + 0 
1ba9 : 79 27 26 ADC $2627,y ; (Enemy + 1)
1bac : 85 1b __ STA ACCU + 0 
1bae : a5 1c __ LDA ACCU + 1 
1bb0 : 69 00 __ ADC #$00
1bb2 : 06 1b __ ASL ACCU + 0 
1bb4 : 2a __ __ ROL
1bb5 : 06 1b __ ASL ACCU + 0 
1bb7 : 2a __ __ ROL
1bb8 : 06 1b __ ASL ACCU + 0 
1bba : 2a __ __ ROL
1bbb : 85 1c __ STA ACCU + 1 
1bbd : 18 __ __ CLC
1bbe : a5 1b __ LDA ACCU + 0 
1bc0 : 79 26 26 ADC $2626,y ; (Enemy + 0)
1bc3 : 85 43 __ STA T2 + 0 
1bc5 : 85 1b __ STA ACCU + 0 
1bc7 : a5 1c __ LDA ACCU + 1 
1bc9 : 69 c0 __ ADC #$c0
1bcb : 85 44 __ STA T2 + 1 
1bcd : 18 __ __ CLC
1bce : 69 18 __ ADC #$18
1bd0 : 85 1c __ STA ACCU + 1 
1bd2 : b9 28 26 LDA $2628,y ; (Enemy + 2)
1bd5 : a0 00 __ LDY #$00
1bd7 : 91 43 __ STA (T2 + 0),y 
1bd9 : a4 1d __ LDY ACCU + 2 
1bdb : b9 29 26 LDA $2629,y ; (Enemy + 3)
1bde : a0 00 __ LDY #$00
1be0 : 91 1b __ STA (ACCU + 0),y 
.s19:
1be2 : e8 __ __ INX
1be3 : e0 0a __ CPX #$0a
1be5 : 90 a6 __ BCC $1b8d ; (render_enemies.l1006 + 0)
.s1001:
1be7 : 60 __ __ RTS
--------------------------------------------------------------------
check_shot_enemy_collision:
.s0:
1be8 : a2 00 __ LDX #$00
.l2:
1bea : 86 1d __ STX ACCU + 2 
1bec : bc 7d 25 LDY $257d,x ; (__multab3L + 0)
1bef : b9 5a 26 LDA $265a,y ; (PlayerShot + 2)
1bf2 : c9 01 __ CMP #$01
1bf4 : d0 2e __ BNE $1c24 ; (check_shot_enemy_collision.s3 + 0)
.s5:
1bf6 : a2 00 __ LDX #$00
.l9:
1bf8 : 86 43 __ STX T2 + 0 
1bfa : bc 73 25 LDY $2573,x ; (__multab5L + 0)
1bfd : 84 1e __ STY ACCU + 3 
1bff : b9 2a 26 LDA $262a,y ; (Enemy + 4)
1c02 : c9 01 __ CMP #$01
1c04 : d0 17 __ BNE $1c1d ; (check_shot_enemy_collision.s114 + 0)
.s12:
1c06 : b9 26 26 LDA $2626,y ; (Enemy + 0)
1c09 : a6 1d __ LDX ACCU + 2 
1c0b : bc 7d 25 LDY $257d,x ; (__multab3L + 0)
1c0e : d9 58 26 CMP $2658,y ; (PlayerShot + 0)
1c11 : d0 0a __ BNE $1c1d ; (check_shot_enemy_collision.s114 + 0)
.s18:
1c13 : b9 59 26 LDA $2659,y ; (PlayerShot + 1)
1c16 : a6 1e __ LDX ACCU + 3 
1c18 : dd 27 26 CMP $2627,x ; (Enemy + 1)
1c1b : f0 0f __ BEQ $1c2c ; (check_shot_enemy_collision.s15 + 0)
.s114:
1c1d : a6 43 __ LDX T2 + 0 
1c1f : e8 __ __ INX
1c20 : e0 0a __ CPX #$0a
1c22 : 90 d4 __ BCC $1bf8 ; (check_shot_enemy_collision.l9 + 0)
.s3:
1c24 : a6 1d __ LDX ACCU + 2 
1c26 : e8 __ __ INX
1c27 : e0 03 __ CPX #$03
1c29 : 90 bf __ BCC $1bea ; (check_shot_enemy_collision.l2 + 0)
.s1001:
1c2b : 60 __ __ RTS
.s15:
1c2c : a9 00 __ LDA #$00
1c2e : 85 44 __ STA T3 + 0 
.l20:
1c30 : bd 27 26 LDA $2627,x ; (Enemy + 1)
1c33 : 0a __ __ ASL
1c34 : 85 1b __ STA ACCU + 0 
1c36 : a9 00 __ LDA #$00
1c38 : 2a __ __ ROL
1c39 : 06 1b __ ASL ACCU + 0 
1c3b : 2a __ __ ROL
1c3c : a8 __ __ TAY
1c3d : a5 1b __ LDA ACCU + 0 
1c3f : 7d 27 26 ADC $2627,x ; (Enemy + 1)
1c42 : 85 1b __ STA ACCU + 0 
1c44 : 98 __ __ TYA
1c45 : 69 00 __ ADC #$00
1c47 : 06 1b __ ASL ACCU + 0 
1c49 : 2a __ __ ROL
1c4a : 06 1b __ ASL ACCU + 0 
1c4c : 2a __ __ ROL
1c4d : 06 1b __ ASL ACCU + 0 
1c4f : 2a __ __ ROL
1c50 : a8 __ __ TAY
1c51 : 18 __ __ CLC
1c52 : a5 1b __ LDA ACCU + 0 
1c54 : 7d 26 26 ADC $2626,x ; (Enemy + 0)
1c57 : 85 1b __ STA ACCU + 0 
1c59 : 98 __ __ TYA
1c5a : 69 c0 __ ADC #$c0
1c5c : 85 1c __ STA ACCU + 1 
1c5e : 18 __ __ CLC
1c5f : 69 18 __ ADC #$18
1c61 : 85 20 __ STA ADDR + 1 
1c63 : a9 86 __ LDA #$86
1c65 : a0 00 __ LDY #$00
1c67 : 84 1f __ STY ADDR + 0 
1c69 : 91 1b __ STA (ACCU + 0),y 
1c6b : a5 44 __ LDA T3 + 0 
1c6d : a4 1b __ LDY ACCU + 0 
1c6f : 91 1f __ STA (ADDR + 0),y 
.l109:
1c71 : ad 11 d0 LDA $d011 
1c74 : 30 fb __ BMI $1c71 ; (check_shot_enemy_collision.l109 + 0)
.l27:
1c76 : ad 11 d0 LDA $d011 
1c79 : 10 fb __ BPL $1c76 ; (check_shot_enemy_collision.l27 + 0)
.s21:
1c7b : e6 44 __ INC T3 + 0 
1c7d : a5 44 __ LDA T3 + 0 
1c7f : c9 08 __ CMP #$08
1c81 : 90 ad __ BCC $1c30 ; (check_shot_enemy_collision.l20 + 0)
.s22:
1c83 : bd 27 26 LDA $2627,x ; (Enemy + 1)
1c86 : 0a __ __ ASL
1c87 : 85 1b __ STA ACCU + 0 
1c89 : a9 00 __ LDA #$00
1c8b : 2a __ __ ROL
1c8c : 06 1b __ ASL ACCU + 0 
1c8e : 2a __ __ ROL
1c8f : a8 __ __ TAY
1c90 : a5 1b __ LDA ACCU + 0 
1c92 : 7d 27 26 ADC $2627,x ; (Enemy + 1)
1c95 : 85 1b __ STA ACCU + 0 
1c97 : 98 __ __ TYA
1c98 : 69 00 __ ADC #$00
1c9a : 06 1b __ ASL ACCU + 0 
1c9c : 2a __ __ ROL
1c9d : 06 1b __ ASL ACCU + 0 
1c9f : 2a __ __ ROL
1ca0 : 06 1b __ ASL ACCU + 0 
1ca2 : 2a __ __ ROL
1ca3 : a8 __ __ TAY
1ca4 : 18 __ __ CLC
1ca5 : a5 1b __ LDA ACCU + 0 
1ca7 : 7d 26 26 ADC $2626,x ; (Enemy + 0)
1caa : 85 44 __ STA T3 + 0 
1cac : 85 1f __ STA ADDR + 0 
1cae : 98 __ __ TYA
1caf : 69 c0 __ ADC #$c0
1cb1 : 85 45 __ STA T3 + 1 
1cb3 : 18 __ __ CLC
1cb4 : 69 18 __ ADC #$18
1cb6 : 85 20 __ STA ADDR + 1 
1cb8 : a9 20 __ LDA #$20
1cba : a0 00 __ LDY #$00
1cbc : 91 44 __ STA (T3 + 0),y 
1cbe : 98 __ __ TYA
1cbf : 91 1f __ STA (ADDR + 0),y 
1cc1 : 9d 2a 26 STA $262a,x ; (Enemy + 4)
1cc4 : a6 1d __ LDX ACCU + 2 
1cc6 : bc 7d 25 LDY $257d,x ; (__multab3L + 0)
1cc9 : 99 5a 26 STA $265a,y ; (PlayerShot + 2)
1ccc : a6 1e __ LDX ACCU + 3 
1cce : bd 28 26 LDA $2628,x ; (Enemy + 2)
1cd1 : c9 83 __ CMP #$83
1cd3 : f0 2b __ BEQ $1d00 ; (check_shot_enemy_collision.s30 + 0)
.s31:
1cd5 : c9 84 __ CMP #$84
1cd7 : f0 03 __ BEQ $1cdc ; (check_shot_enemy_collision.s33 + 0)
1cd9 : 4c 1d 1c JMP $1c1d ; (check_shot_enemy_collision.s114 + 0)
.s33:
1cdc : ad f5 25 LDA $25f5 ; (game + 1)
1cdf : 18 __ __ CLC
1ce0 : 69 19 __ ADC #$19
.s118:
1ce2 : 8d f5 25 STA $25f5 ; (game + 1)
1ce5 : ad f6 25 LDA $25f6 ; (game + 2)
1ce8 : 69 00 __ ADC #$00
1cea : 8d f6 25 STA $25f6 ; (game + 2)
1ced : ad f7 25 LDA $25f7 ; (game + 3)
1cf0 : 69 00 __ ADC #$00
1cf2 : 8d f7 25 STA $25f7 ; (game + 3)
1cf5 : b0 03 __ BCS $1cfa ; (check_shot_enemy_collision.s1019 + 0)
1cf7 : 4c 1d 1c JMP $1c1d ; (check_shot_enemy_collision.s114 + 0)
.s1019:
1cfa : ee f8 25 INC $25f8 ; (game + 4)
1cfd : 4c 1d 1c JMP $1c1d ; (check_shot_enemy_collision.s114 + 0)
.s30:
1d00 : ad f5 25 LDA $25f5 ; (game + 1)
1d03 : 18 __ __ CLC
1d04 : 69 32 __ ADC #$32
1d06 : 4c e2 1c JMP $1ce2 ; (check_shot_enemy_collision.s118 + 0)
--------------------------------------------------------------------
move_enemy_shots:
.s0:
1d09 : a2 00 __ LDX #$00
.l1008:
1d0b : bc 7d 25 LDY $257d,x ; (__multab3L + 0)
1d0e : b9 63 26 LDA $2663,y ; (EnemyShot + 2)
1d11 : c9 01 __ CMP #$01
1d13 : d0 58 __ BNE $1d6d ; (move_enemy_shots.s23 + 0)
.s5:
1d15 : 84 1d __ STY ACCU + 2 
1d17 : b9 62 26 LDA $2662,y ; (EnemyShot + 1)
1d1a : 0a __ __ ASL
1d1b : 85 1b __ STA ACCU + 0 
1d1d : a9 00 __ LDA #$00
1d1f : 2a __ __ ROL
1d20 : 06 1b __ ASL ACCU + 0 
1d22 : 2a __ __ ROL
1d23 : 85 1c __ STA ACCU + 1 
1d25 : a5 1b __ LDA ACCU + 0 
1d27 : 79 62 26 ADC $2662,y ; (EnemyShot + 1)
1d2a : 85 1b __ STA ACCU + 0 
1d2c : a5 1c __ LDA ACCU + 1 
1d2e : 69 00 __ ADC #$00
1d30 : 06 1b __ ASL ACCU + 0 
1d32 : 2a __ __ ROL
1d33 : 06 1b __ ASL ACCU + 0 
1d35 : 2a __ __ ROL
1d36 : 06 1b __ ASL ACCU + 0 
1d38 : 2a __ __ ROL
1d39 : 85 1c __ STA ACCU + 1 
1d3b : b9 61 26 LDA $2661,y ; (EnemyShot + 0)
1d3e : 85 1e __ STA ACCU + 3 
1d40 : 18 __ __ CLC
1d41 : 65 1b __ ADC ACCU + 0 
1d43 : 85 1b __ STA ACCU + 0 
1d45 : 85 1f __ STA ADDR + 0 
1d47 : a5 1c __ LDA ACCU + 1 
1d49 : 69 c0 __ ADC #$c0
1d4b : 85 1c __ STA ACCU + 1 
1d4d : 18 __ __ CLC
1d4e : 69 18 __ ADC #$18
1d50 : 85 20 __ STA ADDR + 1 
1d52 : a9 20 __ LDA #$20
1d54 : a0 00 __ LDY #$00
1d56 : 91 1b __ STA (ACCU + 0),y 
1d58 : 98 __ __ TYA
1d59 : 91 1f __ STA (ADDR + 0),y 
1d5b : c6 1e __ DEC ACCU + 3 
1d5d : a5 1e __ LDA ACCU + 3 
1d5f : a4 1d __ LDY ACCU + 2 
1d61 : 99 61 26 STA $2661,y ; (EnemyShot + 0)
1d64 : c9 ff __ CMP #$ff
1d66 : d0 05 __ BNE $1d6d ; (move_enemy_shots.s23 + 0)
.s8:
1d68 : a9 00 __ LDA #$00
1d6a : 99 63 26 STA $2663,y ; (EnemyShot + 2)
.s23:
1d6d : e8 __ __ INX
1d6e : e0 03 __ CPX #$03
1d70 : 90 99 __ BCC $1d0b ; (move_enemy_shots.l1008 + 0)
.s1001:
1d72 : 60 __ __ RTS
--------------------------------------------------------------------
check_player_enemy_collision:
.s0:
1d73 : a0 00 __ LDY #$00
.l2:
1d75 : be 73 25 LDX $2573,y ; (__multab5L + 0)
1d78 : bd 2a 26 LDA $262a,x ; (Enemy + 4)
1d7b : c9 01 __ CMP #$01
1d7d : d0 10 __ BNE $1d8f ; (check_player_enemy_collision.s3 + 0)
.s5:
1d7f : bd 26 26 LDA $2626,x ; (Enemy + 0)
1d82 : cd fa 25 CMP $25fa ; (Player + 0)
1d85 : d0 08 __ BNE $1d8f ; (check_player_enemy_collision.s3 + 0)
.s11:
1d87 : bd 27 26 LDA $2627,x ; (Enemy + 1)
1d8a : cd fb 25 CMP $25fb ; (Player + 1)
1d8d : f0 30 __ BEQ $1dbf ; (check_player_enemy_collision.s8 + 0)
.s3:
1d8f : c8 __ __ INY
1d90 : c0 0a __ CPY #$0a
1d92 : 90 e1 __ BCC $1d75 ; (check_player_enemy_collision.l2 + 0)
.s4:
1d94 : a0 00 __ LDY #$00
.l13:
1d96 : be 7d 25 LDX $257d,y ; (__multab3L + 0)
1d99 : bd 63 26 LDA $2663,x ; (EnemyShot + 2)
1d9c : c9 01 __ CMP #$01
1d9e : d0 10 __ BNE $1db0 ; (check_player_enemy_collision.s14 + 0)
.s16:
1da0 : bd 61 26 LDA $2661,x ; (EnemyShot + 0)
1da3 : cd fa 25 CMP $25fa ; (Player + 0)
1da6 : d0 08 __ BNE $1db0 ; (check_player_enemy_collision.s14 + 0)
.s22:
1da8 : bd 62 26 LDA $2662,x ; (EnemyShot + 1)
1dab : cd fb 25 CMP $25fb ; (Player + 1)
1dae : f0 06 __ BEQ $1db6 ; (check_player_enemy_collision.s19 + 0)
.s14:
1db0 : c8 __ __ INY
1db1 : c0 03 __ CPY #$03
1db3 : 90 e1 __ BCC $1d96 ; (check_player_enemy_collision.l13 + 0)
.s1001:
1db5 : 60 __ __ RTS
.s19:
1db6 : 20 c9 1d JSR $1dc9 ; (render_player_dead.s0 + 0)
1db9 : a9 02 __ LDA #$02
1dbb : 8d f4 25 STA $25f4 ; (game + 0)
1dbe : 60 __ __ RTS
.s8:
1dbf : 20 c9 1d JSR $1dc9 ; (render_player_dead.s0 + 0)
1dc2 : a9 02 __ LDA #$02
1dc4 : 8d f4 25 STA $25f4 ; (game + 0)
1dc7 : d0 cb __ BNE $1d94 ; (check_player_enemy_collision.s4 + 0)
--------------------------------------------------------------------
render_player_dead:
.s0:
1dc9 : ad fb 25 LDA $25fb ; (Player + 1)
1dcc : 85 1e __ STA ACCU + 3 
1dce : ad fa 25 LDA $25fa ; (Player + 0)
1dd1 : 85 43 __ STA T2 + 0 
1dd3 : a9 00 __ LDA #$00
1dd5 : 85 1d __ STA ACCU + 2 
.l2:
1dd7 : a9 ff __ LDA #$ff
1dd9 : 85 44 __ STA T3 + 0 
.l6:
1ddb : 29 80 __ AND #$80
1ddd : 10 02 __ BPL $1de1 ; (render_player_dead.l6 + 6)
1ddf : a9 ff __ LDA #$ff
1de1 : aa __ __ TAX
1de2 : 18 __ __ CLC
1de3 : a5 44 __ LDA T3 + 0 
1de5 : 65 1e __ ADC ACCU + 3 
1de7 : a8 __ __ TAY
1de8 : 90 01 __ BCC $1deb ; (render_player_dead.s1009 + 0)
.s1008:
1dea : e8 __ __ INX
.s1009:
1deb : 86 1c __ STX ACCU + 1 
1ded : 0a __ __ ASL
1dee : 85 1b __ STA ACCU + 0 
1df0 : 8a __ __ TXA
1df1 : 2a __ __ ROL
1df2 : 06 1b __ ASL ACCU + 0 
1df4 : 2a __ __ ROL
1df5 : aa __ __ TAX
1df6 : 98 __ __ TYA
1df7 : 18 __ __ CLC
1df8 : 65 1b __ ADC ACCU + 0 
1dfa : 85 1b __ STA ACCU + 0 
1dfc : 8a __ __ TXA
1dfd : 65 1c __ ADC ACCU + 1 
1dff : 06 1b __ ASL ACCU + 0 
1e01 : 2a __ __ ROL
1e02 : 06 1b __ ASL ACCU + 0 
1e04 : 2a __ __ ROL
1e05 : 06 1b __ ASL ACCU + 0 
1e07 : 2a __ __ ROL
1e08 : aa __ __ TAX
1e09 : 18 __ __ CLC
1e0a : a9 ff __ LDA #$ff
1e0c : 65 1b __ ADC ACCU + 0 
1e0e : a8 __ __ TAY
1e0f : 8a __ __ TXA
1e10 : 69 d7 __ ADC #$d7
1e12 : aa __ __ TAX
1e13 : 98 __ __ TYA
1e14 : 18 __ __ CLC
1e15 : 65 43 __ ADC T2 + 0 
1e17 : 85 1b __ STA ACCU + 0 
1e19 : 85 45 __ STA T5 + 0 
1e1b : 8a __ __ TXA
1e1c : 69 00 __ ADC #$00
1e1e : 85 1c __ STA ACCU + 1 
1e20 : 18 __ __ CLC
1e21 : 69 e8 __ ADC #$e8
1e23 : 85 46 __ STA T5 + 1 
1e25 : a0 00 __ LDY #$00
1e27 : a2 03 __ LDX #$03
.l1006:
1e29 : a9 86 __ LDA #$86
1e2b : 91 45 __ STA (T5 + 0),y 
1e2d : a5 1d __ LDA ACCU + 2 
1e2f : 91 1b __ STA (ACCU + 0),y 
1e31 : e6 45 __ INC T5 + 0 
1e33 : d0 02 __ BNE $1e37 ; (render_player_dead.s1011 + 0)
.s1010:
1e35 : e6 46 __ INC T5 + 1 
.s1011:
1e37 : e6 1b __ INC ACCU + 0 
1e39 : d0 02 __ BNE $1e3d ; (render_player_dead.s1013 + 0)
.s1012:
1e3b : e6 1c __ INC ACCU + 1 
.s1013:
1e3d : ca __ __ DEX
1e3e : d0 e9 __ BNE $1e29 ; (render_player_dead.l1006 + 0)
.s1007:
1e40 : e6 44 __ INC T3 + 0 
1e42 : a5 44 __ LDA T3 + 0 
1e44 : c9 02 __ CMP #$02
1e46 : 90 93 __ BCC $1ddb ; (render_player_dead.l6 + 0)
.l14:
1e48 : ad 11 d0 LDA $d011 
1e4b : 30 fb __ BMI $1e48 ; (render_player_dead.l14 + 0)
.l17:
1e4d : ad 11 d0 LDA $d011 
1e50 : 10 fb __ BPL $1e4d ; (render_player_dead.l17 + 0)
.s3:
1e52 : e6 1d __ INC ACCU + 2 
1e54 : a5 1d __ LDA ACCU + 2 
1e56 : c9 1e __ CMP #$1e
1e58 : b0 03 __ BCS $1e5d ; (render_player_dead.s1001 + 0)
1e5a : 4c d7 1d JMP $1dd7 ; (render_player_dead.l2 + 0)
.s1001:
1e5d : 60 __ __ RTS
--------------------------------------------------------------------
control_player_ship:
.s0:
1e5e : a9 00 __ LDA #$00
1e60 : 20 02 1f JSR $1f02 ; (joy_poll.s0 + 0)
1e63 : ad fe 25 LDA $25fe ; (joyx + 0)
1e66 : 85 1d __ STA ACCU + 2 
1e68 : 85 1e __ STA ACCU + 3 
1e6a : d0 08 __ BNE $1e74 ; (control_player_ship.s1 + 0)
.s4:
1e6c : ad fc 25 LDA $25fc ; (joyy + 0)
1e6f : d0 03 __ BNE $1e74 ; (control_player_ship.s1 + 0)
1e71 : 4c f7 1e JMP $1ef7 ; (control_player_ship.s3 + 0)
.s1:
1e74 : ad fa 25 LDA $25fa ; (Player + 0)
1e77 : 85 43 __ STA T2 + 0 
1e79 : 85 44 __ STA T3 + 0 
1e7b : ad fb 25 LDA $25fb ; (Player + 1)
1e7e : 85 45 __ STA T4 + 0 
1e80 : 85 46 __ STA T5 + 0 
1e82 : 0a __ __ ASL
1e83 : 85 1b __ STA ACCU + 0 
1e85 : a9 00 __ LDA #$00
1e87 : 2a __ __ ROL
1e88 : 06 1b __ ASL ACCU + 0 
1e8a : 2a __ __ ROL
1e8b : aa __ __ TAX
1e8c : a5 1b __ LDA ACCU + 0 
1e8e : 65 45 __ ADC T4 + 0 
1e90 : 85 1b __ STA ACCU + 0 
1e92 : 8a __ __ TXA
1e93 : 69 00 __ ADC #$00
1e95 : 06 1b __ ASL ACCU + 0 
1e97 : 2a __ __ ROL
1e98 : 06 1b __ ASL ACCU + 0 
1e9a : 2a __ __ ROL
1e9b : 06 1b __ ASL ACCU + 0 
1e9d : 2a __ __ ROL
1e9e : aa __ __ TAX
1e9f : 18 __ __ CLC
1ea0 : a5 1b __ LDA ACCU + 0 
1ea2 : 65 43 __ ADC T2 + 0 
1ea4 : 85 1b __ STA ACCU + 0 
1ea6 : 85 1f __ STA ADDR + 0 
1ea8 : 8a __ __ TXA
1ea9 : 69 c0 __ ADC #$c0
1eab : 85 1c __ STA ACCU + 1 
1ead : 18 __ __ CLC
1eae : 69 18 __ ADC #$18
1eb0 : 85 20 __ STA ADDR + 1 
1eb2 : a9 20 __ LDA #$20
1eb4 : a0 00 __ LDY #$00
1eb6 : 91 1b __ STA (ACCU + 0),y 
1eb8 : 98 __ __ TYA
1eb9 : 91 1f __ STA (ADDR + 0),y 
1ebb : a5 43 __ LDA T2 + 0 
1ebd : c9 02 __ CMP #$02
1ebf : 90 06 __ BCC $1ec7 ; (control_player_ship.s6 + 0)
.s8:
1ec1 : a5 1d __ LDA ACCU + 2 
1ec3 : 30 0c __ BMI $1ed1 ; (control_player_ship.s5 + 0)
.s1015:
1ec5 : a5 43 __ LDA T2 + 0 
.s6:
1ec7 : c9 26 __ CMP #$26
1ec9 : b0 0e __ BCS $1ed9 ; (control_player_ship.s7 + 0)
.s12:
1ecb : a5 1d __ LDA ACCU + 2 
1ecd : 30 0a __ BMI $1ed9 ; (control_player_ship.s7 + 0)
.s1009:
1ecf : f0 08 __ BEQ $1ed9 ; (control_player_ship.s7 + 0)
.s5:
1ed1 : 18 __ __ CLC
1ed2 : a5 44 __ LDA T3 + 0 
1ed4 : 65 1e __ ADC ACCU + 3 
1ed6 : 8d fa 25 STA $25fa ; (Player + 0)
.s7:
1ed9 : a5 45 __ LDA T4 + 0 
1edb : c9 05 __ CMP #$05
1edd : 90 07 __ BCC $1ee6 ; (control_player_ship.s14 + 0)
.s16:
1edf : ad fc 25 LDA $25fc ; (joyy + 0)
1ee2 : 30 0d __ BMI $1ef1 ; (control_player_ship.s32 + 0)
.s1014:
1ee4 : a5 45 __ LDA T4 + 0 
.s14:
1ee6 : c9 17 __ CMP #$17
1ee8 : b0 0d __ BCS $1ef7 ; (control_player_ship.s3 + 0)
.s20:
1eea : ad fc 25 LDA $25fc ; (joyy + 0)
1eed : 30 08 __ BMI $1ef7 ; (control_player_ship.s3 + 0)
.s1004:
1eef : f0 06 __ BEQ $1ef7 ; (control_player_ship.s3 + 0)
.s32:
1ef1 : 18 __ __ CLC
1ef2 : 65 46 __ ADC T5 + 0 
1ef4 : 8d fb 25 STA $25fb ; (Player + 1)
.s3:
1ef7 : ad 6a 26 LDA $266a ; (joyb + 0)
1efa : c9 01 __ CMP #$01
1efc : f0 01 __ BEQ $1eff ; (control_player_ship.s21 + 0)
.s1001:
1efe : 60 __ __ RTS
.s21:
1eff : 4c 42 1f JMP $1f42 ; (spawn_player_shot.s0 + 0)
--------------------------------------------------------------------
joy_poll:
.s0:
1f02 : aa __ __ TAX
1f03 : bd 00 dc LDA $dc00,x 
1f06 : a8 __ __ TAY
1f07 : 29 10 __ AND #$10
1f09 : f0 04 __ BEQ $1f0f ; (joy_poll.s1005 + 0)
.s1006:
1f0b : a9 00 __ LDA #$00
1f0d : f0 02 __ BEQ $1f11 ; (joy_poll.s1007 + 0)
.s1005:
1f0f : a9 01 __ LDA #$01
.s1007:
1f11 : 9d 6a 26 STA $266a,x ; (joyb + 0)
1f14 : 98 __ __ TYA
1f15 : 4a __ __ LSR
1f16 : b0 1d __ BCS $1f35 ; (joy_poll.s2 + 0)
.s1:
1f18 : a9 ff __ LDA #$ff
.s15:
1f1a : 9d fc 25 STA $25fc,x ; (joyy + 0)
1f1d : 98 __ __ TYA
1f1e : 29 04 __ AND #$04
1f20 : d0 06 __ BNE $1f28 ; (joy_poll.s8 + 0)
.s7:
1f22 : a9 ff __ LDA #$ff
.s1001:
1f24 : 9d fe 25 STA $25fe,x ; (joyx + 0)
1f27 : 60 __ __ RTS
.s8:
1f28 : 98 __ __ TYA
1f29 : 29 08 __ AND #$08
1f2b : f0 04 __ BEQ $1f31 ; (joy_poll.s1011 + 0)
.s1012:
1f2d : a9 00 __ LDA #$00
1f2f : f0 f3 __ BEQ $1f24 ; (joy_poll.s1001 + 0)
.s1011:
1f31 : a9 01 __ LDA #$01
1f33 : d0 ef __ BNE $1f24 ; (joy_poll.s1001 + 0)
.s2:
1f35 : 98 __ __ TYA
1f36 : 29 02 __ AND #$02
1f38 : f0 04 __ BEQ $1f3e ; (joy_poll.s1008 + 0)
.s1009:
1f3a : a9 00 __ LDA #$00
1f3c : f0 dc __ BEQ $1f1a ; (joy_poll.s15 + 0)
.s1008:
1f3e : a9 01 __ LDA #$01
1f40 : d0 d8 __ BNE $1f1a ; (joy_poll.s15 + 0)
--------------------------------------------------------------------
joyy:
25fc : __ __ __ BSS	2
--------------------------------------------------------------------
joyx:
25fe : __ __ __ BSS	2
--------------------------------------------------------------------
joyb:
266a : __ __ __ BSS	2
--------------------------------------------------------------------
spawn_player_shot:
.s0:
1f42 : ad fa 25 LDA $25fa ; (Player + 0)
1f45 : c9 26 __ CMP #$26
1f47 : f0 0f __ BEQ $1f58 ; (spawn_player_shot.s1001 + 0)
.s3:
1f49 : a0 00 __ LDY #$00
.l6:
1f4b : be 7d 25 LDX $257d,y ; (__multab3L + 0)
1f4e : bd 5a 26 LDA $265a,x ; (PlayerShot + 2)
1f51 : f0 06 __ BEQ $1f59 ; (spawn_player_shot.s9 + 0)
.s7:
1f53 : c8 __ __ INY
1f54 : c0 03 __ CPY #$03
1f56 : 90 f3 __ BCC $1f4b ; (spawn_player_shot.l6 + 0)
.s1001:
1f58 : 60 __ __ RTS
.s9:
1f59 : a9 01 __ LDA #$01
1f5b : 9d 5a 26 STA $265a,x ; (PlayerShot + 2)
1f5e : ad fb 25 LDA $25fb ; (Player + 1)
1f61 : 9d 59 26 STA $2659,x ; (PlayerShot + 1)
1f64 : ad fe 25 LDA $25fe ; (joyx + 0)
1f67 : 30 02 __ BMI $1f6b ; (spawn_player_shot.s13 + 0)
.s1007:
1f69 : d0 06 __ BNE $1f71 ; (spawn_player_shot.s12 + 0)
.s13:
1f6b : ad fa 25 LDA $25fa ; (Player + 0)
1f6e : 4c 77 1f JMP $1f77 ; (spawn_player_shot.s14 + 0)
.s12:
1f71 : ad fa 25 LDA $25fa ; (Player + 0)
1f74 : 18 __ __ CLC
1f75 : 69 01 __ ADC #$01
.s14:
1f77 : be 7d 25 LDX $257d,y ; (__multab3L + 0)
1f7a : 9d 58 26 STA $2658,x ; (PlayerShot + 0)
1f7d : a9 ba __ LDA #$ba
1f7f : 8d 00 d4 STA $d400 
1f82 : a9 02 __ LDA #$02
1f84 : 8d 01 d4 STA $d401 
1f87 : a9 00 __ LDA #$00
1f89 : 8d 05 d4 STA $d405 
1f8c : a9 f8 __ LDA #$f8
1f8e : 8d 06 d4 STA $d406 
1f91 : a9 00 __ LDA #$00
1f93 : 8d 02 d4 STA $d402 
1f96 : a9 08 __ LDA #$08
1f98 : 8d 03 d4 STA $d403 
1f9b : a9 40 __ LDA #$40
1f9d : 8d 04 d4 STA $d404 
1fa0 : 60 __ __ RTS
--------------------------------------------------------------------
render_player_ship:
.s0:
1fa1 : ad fb 25 LDA $25fb ; (Player + 1)
1fa4 : 0a __ __ ASL
1fa5 : 85 1b __ STA ACCU + 0 
1fa7 : a9 00 __ LDA #$00
1fa9 : 2a __ __ ROL
1faa : 06 1b __ ASL ACCU + 0 
1fac : 2a __ __ ROL
1fad : aa __ __ TAX
1fae : a5 1b __ LDA ACCU + 0 
1fb0 : 6d fb 25 ADC $25fb ; (Player + 1)
1fb3 : 85 1b __ STA ACCU + 0 
1fb5 : 8a __ __ TXA
1fb6 : 69 00 __ ADC #$00
1fb8 : 06 1b __ ASL ACCU + 0 
1fba : 2a __ __ ROL
1fbb : 06 1b __ ASL ACCU + 0 
1fbd : 2a __ __ ROL
1fbe : 06 1b __ ASL ACCU + 0 
1fc0 : 2a __ __ ROL
1fc1 : aa __ __ TAX
1fc2 : 18 __ __ CLC
1fc3 : a5 1b __ LDA ACCU + 0 
1fc5 : 6d fa 25 ADC $25fa ; (Player + 0)
1fc8 : 85 1b __ STA ACCU + 0 
1fca : 85 1f __ STA ADDR + 0 
1fcc : 8a __ __ TXA
1fcd : 69 c0 __ ADC #$c0
1fcf : 85 1c __ STA ACCU + 1 
1fd1 : 18 __ __ CLC
1fd2 : 69 18 __ ADC #$18
1fd4 : 85 20 __ STA ADDR + 1 
1fd6 : a9 80 __ LDA #$80
1fd8 : a0 00 __ LDY #$00
1fda : 91 1b __ STA (ACCU + 0),y 
1fdc : a9 03 __ LDA #$03
1fde : 91 1f __ STA (ADDR + 0),y 
.s1001:
1fe0 : 60 __ __ RTS
--------------------------------------------------------------------
move_player_shots:
.s0:
1fe1 : a2 00 __ LDX #$00
.l2:
1fe3 : 86 1d __ STX ACCU + 2 
1fe5 : bc 7d 25 LDY $257d,x ; (__multab3L + 0)
1fe8 : b9 5a 26 LDA $265a,y ; (PlayerShot + 2)
1feb : c9 01 __ CMP #$01
1fed : d0 52 __ BNE $2041 ; (move_player_shots.s23 + 0)
.s5:
1fef : 84 1e __ STY ACCU + 3 
1ff1 : b9 59 26 LDA $2659,y ; (PlayerShot + 1)
1ff4 : 0a __ __ ASL
1ff5 : 85 1b __ STA ACCU + 0 
1ff7 : a9 00 __ LDA #$00
1ff9 : 2a __ __ ROL
1ffa : 06 1b __ ASL ACCU + 0 
1ffc : 2a __ __ ROL
1ffd : aa __ __ TAX
1ffe : a5 1b __ LDA ACCU + 0 
2000 : 79 59 26 ADC $2659,y ; (PlayerShot + 1)
2003 : 85 1b __ STA ACCU + 0 
2005 : 8a __ __ TXA
2006 : 69 00 __ ADC #$00
2008 : 06 1b __ ASL ACCU + 0 
200a : 2a __ __ ROL
200b : 06 1b __ ASL ACCU + 0 
200d : 2a __ __ ROL
200e : 06 1b __ ASL ACCU + 0 
2010 : 2a __ __ ROL
2011 : 85 1c __ STA ACCU + 1 
2013 : b9 58 26 LDA $2658,y ; (PlayerShot + 0)
2016 : aa __ __ TAX
2017 : 18 __ __ CLC
2018 : 65 1b __ ADC ACCU + 0 
201a : 85 1b __ STA ACCU + 0 
201c : 85 1f __ STA ADDR + 0 
201e : a5 1c __ LDA ACCU + 1 
2020 : 69 c0 __ ADC #$c0
2022 : 85 1c __ STA ACCU + 1 
2024 : 18 __ __ CLC
2025 : 69 18 __ ADC #$18
2027 : 85 20 __ STA ADDR + 1 
2029 : a9 20 __ LDA #$20
202b : a0 00 __ LDY #$00
202d : 91 1b __ STA (ACCU + 0),y 
202f : 98 __ __ TYA
2030 : 91 1f __ STA (ADDR + 0),y 
2032 : e8 __ __ INX
2033 : 8a __ __ TXA
2034 : a6 1e __ LDX ACCU + 3 
2036 : 9d 58 26 STA $2658,x ; (PlayerShot + 0)
2039 : c9 27 __ CMP #$27
203b : 90 04 __ BCC $2041 ; (move_player_shots.s23 + 0)
.s8:
203d : 98 __ __ TYA
203e : 9d 5a 26 STA $265a,x ; (PlayerShot + 2)
.s23:
2041 : a6 1d __ LDX ACCU + 2 
2043 : e8 __ __ INX
2044 : e0 03 __ CPX #$03
2046 : 90 9b __ BCC $1fe3 ; (move_player_shots.l2 + 0)
.s1001:
2048 : 60 __ __ RTS
--------------------------------------------------------------------
render_player_shots:
.s0:
2049 : a2 00 __ LDX #$00
.l1006:
204b : bc 7d 25 LDY $257d,x ; (__multab3L + 0)
204e : b9 5a 26 LDA $265a,y ; (PlayerShot + 2)
2051 : c9 01 __ CMP #$01
2053 : d0 43 __ BNE $2098 ; (render_player_shots.s19 + 0)
.s5:
2055 : b9 59 26 LDA $2659,y ; (PlayerShot + 1)
2058 : 0a __ __ ASL
2059 : 85 1b __ STA ACCU + 0 
205b : a9 00 __ LDA #$00
205d : 2a __ __ ROL
205e : 06 1b __ ASL ACCU + 0 
2060 : 2a __ __ ROL
2061 : 85 1c __ STA ACCU + 1 
2063 : a5 1b __ LDA ACCU + 0 
2065 : 79 59 26 ADC $2659,y ; (PlayerShot + 1)
2068 : 85 1b __ STA ACCU + 0 
206a : a5 1c __ LDA ACCU + 1 
206c : 69 00 __ ADC #$00
206e : 06 1b __ ASL ACCU + 0 
2070 : 2a __ __ ROL
2071 : 06 1b __ ASL ACCU + 0 
2073 : 2a __ __ ROL
2074 : 06 1b __ ASL ACCU + 0 
2076 : 2a __ __ ROL
2077 : 85 1c __ STA ACCU + 1 
2079 : 18 __ __ CLC
207a : a5 1b __ LDA ACCU + 0 
207c : 79 58 26 ADC $2658,y ; (PlayerShot + 0)
207f : 85 1b __ STA ACCU + 0 
2081 : 85 1f __ STA ADDR + 0 
2083 : a5 1c __ LDA ACCU + 1 
2085 : 69 c0 __ ADC #$c0
2087 : 85 1c __ STA ACCU + 1 
2089 : 18 __ __ CLC
208a : 69 18 __ ADC #$18
208c : 85 20 __ STA ADDR + 1 
208e : a9 81 __ LDA #$81
2090 : a0 00 __ LDY #$00
2092 : 91 1b __ STA (ACCU + 0),y 
2094 : a9 01 __ LDA #$01
2096 : 91 1f __ STA (ADDR + 0),y 
.s19:
2098 : e8 __ __ INX
2099 : e0 03 __ CPX #$03
209b : 90 ae __ BCC $204b ; (render_player_shots.l1006 + 0)
.s1001:
209d : 60 __ __ RTS
--------------------------------------------------------------------
wait_frames:
.s0:
209e : a5 0e __ LDA P1 ; (frames + 1)
20a0 : 30 1c __ BMI $20be ; (wait_frames.s1001 + 0)
.s1005:
20a2 : 05 0d __ ORA P0 ; (frames + 0)
20a4 : f0 18 __ BEQ $20be ; (wait_frames.s1001 + 0)
.s13:
20a6 : a0 00 __ LDY #$00
20a8 : a6 0e __ LDX P1 ; (frames + 1)
.l6:
20aa : ad 11 d0 LDA $d011 
20ad : 30 fb __ BMI $20aa ; (wait_frames.l6 + 0)
.l9:
20af : ad 11 d0 LDA $d011 
20b2 : 10 fb __ BPL $20af ; (wait_frames.l9 + 0)
.s3:
20b4 : c8 __ __ INY
20b5 : 8a __ __ TXA
20b6 : 30 06 __ BMI $20be ; (wait_frames.s1001 + 0)
.s1004:
20b8 : d0 f0 __ BNE $20aa ; (wait_frames.l6 + 0)
.s1002:
20ba : c4 0d __ CPY P0 ; (frames + 0)
20bc : 90 ec __ BCC $20aa ; (wait_frames.l6 + 0)
.s1001:
20be : 60 __ __ RTS
--------------------------------------------------------------------
freg:
20bf : b1 19 __ LDA (IP + 0),y 
20c1 : c8 __ __ INY
20c2 : aa __ __ TAX
20c3 : b5 00 __ LDA $00,x 
20c5 : 85 03 __ STA WORK + 0 
20c7 : b5 01 __ LDA $01,x 
20c9 : 85 04 __ STA WORK + 1 
20cb : b5 02 __ LDA $02,x 
20cd : 85 05 __ STA WORK + 2 
20cf : b5 03 __ LDA WORK + 0,x 
20d1 : 85 06 __ STA WORK + 3 
20d3 : a5 05 __ LDA WORK + 2 
20d5 : 0a __ __ ASL
20d6 : a5 06 __ LDA WORK + 3 
20d8 : 2a __ __ ROL
20d9 : 85 08 __ STA WORK + 5 
20db : f0 06 __ BEQ $20e3 ; (freg + 36)
20dd : a5 05 __ LDA WORK + 2 
20df : 09 80 __ ORA #$80
20e1 : 85 05 __ STA WORK + 2 
20e3 : a5 1d __ LDA ACCU + 2 
20e5 : 0a __ __ ASL
20e6 : a5 1e __ LDA ACCU + 3 
20e8 : 2a __ __ ROL
20e9 : 85 07 __ STA WORK + 4 
20eb : f0 06 __ BEQ $20f3 ; (freg + 52)
20ed : a5 1d __ LDA ACCU + 2 
20ef : 09 80 __ ORA #$80
20f1 : 85 1d __ STA ACCU + 2 
20f3 : 60 __ __ RTS
20f4 : 06 1e __ ASL ACCU + 3 
20f6 : a5 07 __ LDA WORK + 4 
20f8 : 6a __ __ ROR
20f9 : 85 1e __ STA ACCU + 3 
20fb : b0 06 __ BCS $2103 ; (freg + 68)
20fd : a5 1d __ LDA ACCU + 2 
20ff : 29 7f __ AND #$7f
2101 : 85 1d __ STA ACCU + 2 
2103 : 60 __ __ RTS
--------------------------------------------------------------------
faddsub:
2104 : a9 ff __ LDA #$ff
2106 : c5 07 __ CMP WORK + 4 
2108 : f0 04 __ BEQ $210e ; (faddsub + 10)
210a : c5 08 __ CMP WORK + 5 
210c : d0 11 __ BNE $211f ; (faddsub + 27)
210e : a5 1e __ LDA ACCU + 3 
2110 : 09 7f __ ORA #$7f
2112 : 85 1e __ STA ACCU + 3 
2114 : a9 80 __ LDA #$80
2116 : 85 1d __ STA ACCU + 2 
2118 : a9 00 __ LDA #$00
211a : 85 1b __ STA ACCU + 0 
211c : 85 1c __ STA ACCU + 1 
211e : 60 __ __ RTS
211f : 38 __ __ SEC
2120 : a5 07 __ LDA WORK + 4 
2122 : e5 08 __ SBC WORK + 5 
2124 : f0 38 __ BEQ $215e ; (faddsub + 90)
2126 : aa __ __ TAX
2127 : b0 25 __ BCS $214e ; (faddsub + 74)
2129 : e0 e9 __ CPX #$e9
212b : b0 0e __ BCS $213b ; (faddsub + 55)
212d : a5 08 __ LDA WORK + 5 
212f : 85 07 __ STA WORK + 4 
2131 : a9 00 __ LDA #$00
2133 : 85 1b __ STA ACCU + 0 
2135 : 85 1c __ STA ACCU + 1 
2137 : 85 1d __ STA ACCU + 2 
2139 : f0 23 __ BEQ $215e ; (faddsub + 90)
213b : a5 1d __ LDA ACCU + 2 
213d : 4a __ __ LSR
213e : 66 1c __ ROR ACCU + 1 
2140 : 66 1b __ ROR ACCU + 0 
2142 : e8 __ __ INX
2143 : d0 f8 __ BNE $213d ; (faddsub + 57)
2145 : 85 1d __ STA ACCU + 2 
2147 : a5 08 __ LDA WORK + 5 
2149 : 85 07 __ STA WORK + 4 
214b : 4c 5e 21 JMP $215e ; (faddsub + 90)
214e : e0 18 __ CPX #$18
2150 : b0 33 __ BCS $2185 ; (faddsub + 129)
2152 : a5 05 __ LDA WORK + 2 
2154 : 4a __ __ LSR
2155 : 66 04 __ ROR WORK + 1 
2157 : 66 03 __ ROR WORK + 0 
2159 : ca __ __ DEX
215a : d0 f8 __ BNE $2154 ; (faddsub + 80)
215c : 85 05 __ STA WORK + 2 
215e : a5 1e __ LDA ACCU + 3 
2160 : 29 80 __ AND #$80
2162 : 85 1e __ STA ACCU + 3 
2164 : 45 06 __ EOR WORK + 3 
2166 : 30 31 __ BMI $2199 ; (faddsub + 149)
2168 : 18 __ __ CLC
2169 : a5 1b __ LDA ACCU + 0 
216b : 65 03 __ ADC WORK + 0 
216d : 85 1b __ STA ACCU + 0 
216f : a5 1c __ LDA ACCU + 1 
2171 : 65 04 __ ADC WORK + 1 
2173 : 85 1c __ STA ACCU + 1 
2175 : a5 1d __ LDA ACCU + 2 
2177 : 65 05 __ ADC WORK + 2 
2179 : 85 1d __ STA ACCU + 2 
217b : 90 08 __ BCC $2185 ; (faddsub + 129)
217d : 66 1d __ ROR ACCU + 2 
217f : 66 1c __ ROR ACCU + 1 
2181 : 66 1b __ ROR ACCU + 0 
2183 : e6 07 __ INC WORK + 4 
2185 : a5 07 __ LDA WORK + 4 
2187 : c9 ff __ CMP #$ff
2189 : f0 83 __ BEQ $210e ; (faddsub + 10)
218b : 4a __ __ LSR
218c : 05 1e __ ORA ACCU + 3 
218e : 85 1e __ STA ACCU + 3 
2190 : b0 06 __ BCS $2198 ; (faddsub + 148)
2192 : a5 1d __ LDA ACCU + 2 
2194 : 29 7f __ AND #$7f
2196 : 85 1d __ STA ACCU + 2 
2198 : 60 __ __ RTS
2199 : 38 __ __ SEC
219a : a5 1b __ LDA ACCU + 0 
219c : e5 03 __ SBC WORK + 0 
219e : 85 1b __ STA ACCU + 0 
21a0 : a5 1c __ LDA ACCU + 1 
21a2 : e5 04 __ SBC WORK + 1 
21a4 : 85 1c __ STA ACCU + 1 
21a6 : a5 1d __ LDA ACCU + 2 
21a8 : e5 05 __ SBC WORK + 2 
21aa : 85 1d __ STA ACCU + 2 
21ac : b0 19 __ BCS $21c7 ; (faddsub + 195)
21ae : 38 __ __ SEC
21af : a9 00 __ LDA #$00
21b1 : e5 1b __ SBC ACCU + 0 
21b3 : 85 1b __ STA ACCU + 0 
21b5 : a9 00 __ LDA #$00
21b7 : e5 1c __ SBC ACCU + 1 
21b9 : 85 1c __ STA ACCU + 1 
21bb : a9 00 __ LDA #$00
21bd : e5 1d __ SBC ACCU + 2 
21bf : 85 1d __ STA ACCU + 2 
21c1 : a5 1e __ LDA ACCU + 3 
21c3 : 49 80 __ EOR #$80
21c5 : 85 1e __ STA ACCU + 3 
21c7 : a5 1d __ LDA ACCU + 2 
21c9 : 30 ba __ BMI $2185 ; (faddsub + 129)
21cb : 05 1c __ ORA ACCU + 1 
21cd : 05 1b __ ORA ACCU + 0 
21cf : f0 0f __ BEQ $21e0 ; (faddsub + 220)
21d1 : c6 07 __ DEC WORK + 4 
21d3 : f0 0b __ BEQ $21e0 ; (faddsub + 220)
21d5 : 06 1b __ ASL ACCU + 0 
21d7 : 26 1c __ ROL ACCU + 1 
21d9 : 26 1d __ ROL ACCU + 2 
21db : 10 f4 __ BPL $21d1 ; (faddsub + 205)
21dd : 4c 85 21 JMP $2185 ; (faddsub + 129)
21e0 : a9 00 __ LDA #$00
21e2 : 85 1b __ STA ACCU + 0 
21e4 : 85 1c __ STA ACCU + 1 
21e6 : 85 1d __ STA ACCU + 2 
21e8 : 85 1e __ STA ACCU + 3 
21ea : 60 __ __ RTS
--------------------------------------------------------------------
fmul:
21eb : a5 1b __ LDA ACCU + 0 
21ed : 05 1c __ ORA ACCU + 1 
21ef : 05 1d __ ORA ACCU + 2 
21f1 : d0 03 __ BNE $21f6 ; (fmul + 11)
21f3 : 85 1e __ STA ACCU + 3 
21f5 : 60 __ __ RTS
21f6 : a5 03 __ LDA WORK + 0 
21f8 : 05 04 __ ORA WORK + 1 
21fa : 05 05 __ ORA WORK + 2 
21fc : d0 09 __ BNE $2207 ; (fmul + 28)
21fe : 85 1b __ STA ACCU + 0 
2200 : 85 1c __ STA ACCU + 1 
2202 : 85 1d __ STA ACCU + 2 
2204 : 85 1e __ STA ACCU + 3 
2206 : 60 __ __ RTS
2207 : a5 1e __ LDA ACCU + 3 
2209 : 45 06 __ EOR WORK + 3 
220b : 29 80 __ AND #$80
220d : 85 1e __ STA ACCU + 3 
220f : a9 ff __ LDA #$ff
2211 : c5 07 __ CMP WORK + 4 
2213 : f0 42 __ BEQ $2257 ; (fmul + 108)
2215 : c5 08 __ CMP WORK + 5 
2217 : f0 3e __ BEQ $2257 ; (fmul + 108)
2219 : a9 00 __ LDA #$00
221b : 85 09 __ STA WORK + 6 
221d : 85 0a __ STA WORK + 7 
221f : 85 0b __ STA $0b 
2221 : a4 1b __ LDY ACCU + 0 
2223 : a5 03 __ LDA WORK + 0 
2225 : d0 06 __ BNE $222d ; (fmul + 66)
2227 : a5 04 __ LDA WORK + 1 
2229 : f0 0a __ BEQ $2235 ; (fmul + 74)
222b : d0 05 __ BNE $2232 ; (fmul + 71)
222d : 20 8c 22 JSR $228c ; (fmul8 + 0)
2230 : a5 04 __ LDA WORK + 1 
2232 : 20 8c 22 JSR $228c ; (fmul8 + 0)
2235 : a5 05 __ LDA WORK + 2 
2237 : 20 8c 22 JSR $228c ; (fmul8 + 0)
223a : 38 __ __ SEC
223b : a5 0b __ LDA $0b 
223d : 30 06 __ BMI $2245 ; (fmul + 90)
223f : 06 09 __ ASL WORK + 6 
2241 : 26 0a __ ROL WORK + 7 
2243 : 2a __ __ ROL
2244 : 18 __ __ CLC
2245 : 29 7f __ AND #$7f
2247 : 85 0b __ STA $0b 
2249 : a5 07 __ LDA WORK + 4 
224b : 65 08 __ ADC WORK + 5 
224d : 90 19 __ BCC $2268 ; (fmul + 125)
224f : e9 7f __ SBC #$7f
2251 : b0 04 __ BCS $2257 ; (fmul + 108)
2253 : c9 ff __ CMP #$ff
2255 : d0 15 __ BNE $226c ; (fmul + 129)
2257 : a5 1e __ LDA ACCU + 3 
2259 : 09 7f __ ORA #$7f
225b : 85 1e __ STA ACCU + 3 
225d : a9 80 __ LDA #$80
225f : 85 1d __ STA ACCU + 2 
2261 : a9 00 __ LDA #$00
2263 : 85 1b __ STA ACCU + 0 
2265 : 85 1c __ STA ACCU + 1 
2267 : 60 __ __ RTS
2268 : e9 7e __ SBC #$7e
226a : 90 15 __ BCC $2281 ; (fmul + 150)
226c : 4a __ __ LSR
226d : 05 1e __ ORA ACCU + 3 
226f : 85 1e __ STA ACCU + 3 
2271 : a9 00 __ LDA #$00
2273 : 6a __ __ ROR
2274 : 05 0b __ ORA $0b 
2276 : 85 1d __ STA ACCU + 2 
2278 : a5 0a __ LDA WORK + 7 
227a : 85 1c __ STA ACCU + 1 
227c : a5 09 __ LDA WORK + 6 
227e : 85 1b __ STA ACCU + 0 
2280 : 60 __ __ RTS
2281 : a9 00 __ LDA #$00
2283 : 85 1b __ STA ACCU + 0 
2285 : 85 1c __ STA ACCU + 1 
2287 : 85 1d __ STA ACCU + 2 
2289 : 85 1e __ STA ACCU + 3 
228b : 60 __ __ RTS
--------------------------------------------------------------------
fmul8:
228c : 38 __ __ SEC
228d : 6a __ __ ROR
228e : 90 1e __ BCC $22ae ; (fmul8 + 34)
2290 : aa __ __ TAX
2291 : 18 __ __ CLC
2292 : 98 __ __ TYA
2293 : 65 09 __ ADC WORK + 6 
2295 : 85 09 __ STA WORK + 6 
2297 : a5 0a __ LDA WORK + 7 
2299 : 65 1c __ ADC ACCU + 1 
229b : 85 0a __ STA WORK + 7 
229d : a5 0b __ LDA $0b 
229f : 65 1d __ ADC ACCU + 2 
22a1 : 6a __ __ ROR
22a2 : 85 0b __ STA $0b 
22a4 : 8a __ __ TXA
22a5 : 66 0a __ ROR WORK + 7 
22a7 : 66 09 __ ROR WORK + 6 
22a9 : 4a __ __ LSR
22aa : f0 0d __ BEQ $22b9 ; (fmul8 + 45)
22ac : b0 e2 __ BCS $2290 ; (fmul8 + 4)
22ae : 66 0b __ ROR $0b 
22b0 : 66 0a __ ROR WORK + 7 
22b2 : 66 09 __ ROR WORK + 6 
22b4 : 4a __ __ LSR
22b5 : 90 f7 __ BCC $22ae ; (fmul8 + 34)
22b7 : d0 d7 __ BNE $2290 ; (fmul8 + 4)
22b9 : 60 __ __ RTS
--------------------------------------------------------------------
fdiv:
22ba : a5 1b __ LDA ACCU + 0 
22bc : 05 1c __ ORA ACCU + 1 
22be : 05 1d __ ORA ACCU + 2 
22c0 : d0 03 __ BNE $22c5 ; (fdiv + 11)
22c2 : 85 1e __ STA ACCU + 3 
22c4 : 60 __ __ RTS
22c5 : a5 1e __ LDA ACCU + 3 
22c7 : 45 06 __ EOR WORK + 3 
22c9 : 29 80 __ AND #$80
22cb : 85 1e __ STA ACCU + 3 
22cd : a5 08 __ LDA WORK + 5 
22cf : f0 62 __ BEQ $2333 ; (fdiv + 121)
22d1 : a5 07 __ LDA WORK + 4 
22d3 : c9 ff __ CMP #$ff
22d5 : f0 5c __ BEQ $2333 ; (fdiv + 121)
22d7 : a9 00 __ LDA #$00
22d9 : 85 09 __ STA WORK + 6 
22db : 85 0a __ STA WORK + 7 
22dd : 85 0b __ STA $0b 
22df : a2 18 __ LDX #$18
22e1 : a5 1b __ LDA ACCU + 0 
22e3 : c5 03 __ CMP WORK + 0 
22e5 : a5 1c __ LDA ACCU + 1 
22e7 : e5 04 __ SBC WORK + 1 
22e9 : a5 1d __ LDA ACCU + 2 
22eb : e5 05 __ SBC WORK + 2 
22ed : 90 13 __ BCC $2302 ; (fdiv + 72)
22ef : a5 1b __ LDA ACCU + 0 
22f1 : e5 03 __ SBC WORK + 0 
22f3 : 85 1b __ STA ACCU + 0 
22f5 : a5 1c __ LDA ACCU + 1 
22f7 : e5 04 __ SBC WORK + 1 
22f9 : 85 1c __ STA ACCU + 1 
22fb : a5 1d __ LDA ACCU + 2 
22fd : e5 05 __ SBC WORK + 2 
22ff : 85 1d __ STA ACCU + 2 
2301 : 38 __ __ SEC
2302 : 26 09 __ ROL WORK + 6 
2304 : 26 0a __ ROL WORK + 7 
2306 : 26 0b __ ROL $0b 
2308 : ca __ __ DEX
2309 : f0 0a __ BEQ $2315 ; (fdiv + 91)
230b : 06 1b __ ASL ACCU + 0 
230d : 26 1c __ ROL ACCU + 1 
230f : 26 1d __ ROL ACCU + 2 
2311 : b0 dc __ BCS $22ef ; (fdiv + 53)
2313 : 90 cc __ BCC $22e1 ; (fdiv + 39)
2315 : 38 __ __ SEC
2316 : a5 0b __ LDA $0b 
2318 : 30 06 __ BMI $2320 ; (fdiv + 102)
231a : 06 09 __ ASL WORK + 6 
231c : 26 0a __ ROL WORK + 7 
231e : 2a __ __ ROL
231f : 18 __ __ CLC
2320 : 29 7f __ AND #$7f
2322 : 85 0b __ STA $0b 
2324 : a5 07 __ LDA WORK + 4 
2326 : e5 08 __ SBC WORK + 5 
2328 : 90 1a __ BCC $2344 ; (fdiv + 138)
232a : 18 __ __ CLC
232b : 69 7f __ ADC #$7f
232d : b0 04 __ BCS $2333 ; (fdiv + 121)
232f : c9 ff __ CMP #$ff
2331 : d0 15 __ BNE $2348 ; (fdiv + 142)
2333 : a5 1e __ LDA ACCU + 3 
2335 : 09 7f __ ORA #$7f
2337 : 85 1e __ STA ACCU + 3 
2339 : a9 80 __ LDA #$80
233b : 85 1d __ STA ACCU + 2 
233d : a9 00 __ LDA #$00
233f : 85 1c __ STA ACCU + 1 
2341 : 85 1b __ STA ACCU + 0 
2343 : 60 __ __ RTS
2344 : 69 7f __ ADC #$7f
2346 : 90 15 __ BCC $235d ; (fdiv + 163)
2348 : 4a __ __ LSR
2349 : 05 1e __ ORA ACCU + 3 
234b : 85 1e __ STA ACCU + 3 
234d : a9 00 __ LDA #$00
234f : 6a __ __ ROR
2350 : 05 0b __ ORA $0b 
2352 : 85 1d __ STA ACCU + 2 
2354 : a5 0a __ LDA WORK + 7 
2356 : 85 1c __ STA ACCU + 1 
2358 : a5 09 __ LDA WORK + 6 
235a : 85 1b __ STA ACCU + 0 
235c : 60 __ __ RTS
235d : a9 00 __ LDA #$00
235f : 85 1e __ STA ACCU + 3 
2361 : 85 1d __ STA ACCU + 2 
2363 : 85 1c __ STA ACCU + 1 
2365 : 85 1b __ STA ACCU + 0 
2367 : 60 __ __ RTS
--------------------------------------------------------------------
divs16:
2368 : 24 1c __ BIT ACCU + 1 
236a : 10 0d __ BPL $2379 ; (divs16 + 17)
236c : 20 86 23 JSR $2386 ; (negaccu + 0)
236f : 24 04 __ BIT WORK + 1 
2371 : 10 0d __ BPL $2380 ; (divs16 + 24)
2373 : 20 94 23 JSR $2394 ; (negtmp + 0)
2376 : 4c a2 23 JMP $23a2 ; (divmod + 0)
2379 : 24 04 __ BIT WORK + 1 
237b : 10 f9 __ BPL $2376 ; (divs16 + 14)
237d : 20 94 23 JSR $2394 ; (negtmp + 0)
2380 : 20 a2 23 JSR $23a2 ; (divmod + 0)
2383 : 4c 86 23 JMP $2386 ; (negaccu + 0)
--------------------------------------------------------------------
negaccu:
2386 : 38 __ __ SEC
2387 : a9 00 __ LDA #$00
2389 : e5 1b __ SBC ACCU + 0 
238b : 85 1b __ STA ACCU + 0 
238d : a9 00 __ LDA #$00
238f : e5 1c __ SBC ACCU + 1 
2391 : 85 1c __ STA ACCU + 1 
2393 : 60 __ __ RTS
--------------------------------------------------------------------
negtmp:
2394 : 38 __ __ SEC
2395 : a9 00 __ LDA #$00
2397 : e5 03 __ SBC WORK + 0 
2399 : 85 03 __ STA WORK + 0 
239b : a9 00 __ LDA #$00
239d : e5 04 __ SBC WORK + 1 
239f : 85 04 __ STA WORK + 1 
23a1 : 60 __ __ RTS
--------------------------------------------------------------------
divmod:
23a2 : a5 1c __ LDA ACCU + 1 
23a4 : d0 31 __ BNE $23d7 ; (divmod + 53)
23a6 : a5 04 __ LDA WORK + 1 
23a8 : d0 1e __ BNE $23c8 ; (divmod + 38)
23aa : 85 06 __ STA WORK + 3 
23ac : a2 04 __ LDX #$04
23ae : 06 1b __ ASL ACCU + 0 
23b0 : 2a __ __ ROL
23b1 : c5 03 __ CMP WORK + 0 
23b3 : 90 02 __ BCC $23b7 ; (divmod + 21)
23b5 : e5 03 __ SBC WORK + 0 
23b7 : 26 1b __ ROL ACCU + 0 
23b9 : 2a __ __ ROL
23ba : c5 03 __ CMP WORK + 0 
23bc : 90 02 __ BCC $23c0 ; (divmod + 30)
23be : e5 03 __ SBC WORK + 0 
23c0 : 26 1b __ ROL ACCU + 0 
23c2 : ca __ __ DEX
23c3 : d0 eb __ BNE $23b0 ; (divmod + 14)
23c5 : 85 05 __ STA WORK + 2 
23c7 : 60 __ __ RTS
23c8 : a5 1b __ LDA ACCU + 0 
23ca : 85 05 __ STA WORK + 2 
23cc : a5 1c __ LDA ACCU + 1 
23ce : 85 06 __ STA WORK + 3 
23d0 : a9 00 __ LDA #$00
23d2 : 85 1b __ STA ACCU + 0 
23d4 : 85 1c __ STA ACCU + 1 
23d6 : 60 __ __ RTS
23d7 : a5 04 __ LDA WORK + 1 
23d9 : d0 1f __ BNE $23fa ; (divmod + 88)
23db : a5 03 __ LDA WORK + 0 
23dd : 30 1b __ BMI $23fa ; (divmod + 88)
23df : a9 00 __ LDA #$00
23e1 : 85 06 __ STA WORK + 3 
23e3 : a2 10 __ LDX #$10
23e5 : 06 1b __ ASL ACCU + 0 
23e7 : 26 1c __ ROL ACCU + 1 
23e9 : 2a __ __ ROL
23ea : c5 03 __ CMP WORK + 0 
23ec : 90 02 __ BCC $23f0 ; (divmod + 78)
23ee : e5 03 __ SBC WORK + 0 
23f0 : 26 1b __ ROL ACCU + 0 
23f2 : 26 1c __ ROL ACCU + 1 
23f4 : ca __ __ DEX
23f5 : d0 f2 __ BNE $23e9 ; (divmod + 71)
23f7 : 85 05 __ STA WORK + 2 
23f9 : 60 __ __ RTS
23fa : a9 00 __ LDA #$00
23fc : 85 05 __ STA WORK + 2 
23fe : 85 06 __ STA WORK + 3 
2400 : 84 02 __ STY $02 
2402 : a0 10 __ LDY #$10
2404 : 18 __ __ CLC
2405 : 26 1b __ ROL ACCU + 0 
2407 : 26 1c __ ROL ACCU + 1 
2409 : 26 05 __ ROL WORK + 2 
240b : 26 06 __ ROL WORK + 3 
240d : 38 __ __ SEC
240e : a5 05 __ LDA WORK + 2 
2410 : e5 03 __ SBC WORK + 0 
2412 : aa __ __ TAX
2413 : a5 06 __ LDA WORK + 3 
2415 : e5 04 __ SBC WORK + 1 
2417 : 90 04 __ BCC $241d ; (divmod + 123)
2419 : 86 05 __ STX WORK + 2 
241b : 85 06 __ STA WORK + 3 
241d : 88 __ __ DEY
241e : d0 e5 __ BNE $2405 ; (divmod + 99)
2420 : 26 1b __ ROL ACCU + 0 
2422 : 26 1c __ ROL ACCU + 1 
2424 : a4 02 __ LDY $02 
2426 : 60 __ __ RTS
--------------------------------------------------------------------
mods16:
2427 : 24 1c __ BIT ACCU + 1 
2429 : 10 0d __ BPL $2438 ; (mods16 + 17)
242b : 20 86 23 JSR $2386 ; (negaccu + 0)
242e : 24 04 __ BIT WORK + 1 
2430 : 10 0d __ BPL $243f ; (mods16 + 24)
2432 : 20 94 23 JSR $2394 ; (negtmp + 0)
2435 : 4c a2 23 JMP $23a2 ; (divmod + 0)
2438 : 24 04 __ BIT WORK + 1 
243a : 10 f9 __ BPL $2435 ; (mods16 + 14)
243c : 20 94 23 JSR $2394 ; (negtmp + 0)
243f : 20 a2 23 JSR $23a2 ; (divmod + 0)
2442 : 38 __ __ SEC
2443 : a9 00 __ LDA #$00
2445 : e5 05 __ SBC WORK + 2 
2447 : 85 05 __ STA WORK + 2 
2449 : a9 00 __ LDA #$00
244b : e5 06 __ SBC WORK + 3 
244d : 85 06 __ STA WORK + 3 
244f : 60 __ __ RTS
--------------------------------------------------------------------
f32_to_i16:
2450 : 20 e3 20 JSR $20e3 ; (freg + 36)
2453 : a5 07 __ LDA WORK + 4 
2455 : c9 7f __ CMP #$7f
2457 : b0 07 __ BCS $2460 ; (f32_to_i16 + 16)
2459 : a9 00 __ LDA #$00
245b : 85 1b __ STA ACCU + 0 
245d : 85 1c __ STA ACCU + 1 
245f : 60 __ __ RTS
2460 : 38 __ __ SEC
2461 : e9 8e __ SBC #$8e
2463 : 90 0a __ BCC $246f ; (f32_to_i16 + 31)
2465 : a9 ff __ LDA #$ff
2467 : 85 1b __ STA ACCU + 0 
2469 : a9 7f __ LDA #$7f
246b : 85 1c __ STA ACCU + 1 
246d : d0 08 __ BNE $2477 ; (f32_to_i16 + 39)
246f : aa __ __ TAX
2470 : 46 1d __ LSR ACCU + 2 
2472 : 66 1c __ ROR ACCU + 1 
2474 : e8 __ __ INX
2475 : d0 f9 __ BNE $2470 ; (f32_to_i16 + 32)
2477 : 24 1e __ BIT ACCU + 3 
2479 : 10 0e __ BPL $2489 ; (f32_to_i16 + 57)
247b : 38 __ __ SEC
247c : a9 00 __ LDA #$00
247e : e5 1c __ SBC ACCU + 1 
2480 : 85 1b __ STA ACCU + 0 
2482 : a9 00 __ LDA #$00
2484 : e5 1d __ SBC ACCU + 2 
2486 : 85 1c __ STA ACCU + 1 
2488 : 60 __ __ RTS
2489 : a5 1c __ LDA ACCU + 1 
248b : 85 1b __ STA ACCU + 0 
248d : a5 1d __ LDA ACCU + 2 
248f : 85 1c __ STA ACCU + 1 
2491 : 60 __ __ RTS
--------------------------------------------------------------------
sint16_to_float:
2492 : 24 1c __ BIT ACCU + 1 
2494 : 30 03 __ BMI $2499 ; (sint16_to_float + 7)
2496 : 4c b0 24 JMP $24b0 ; (uint16_to_float + 0)
2499 : 38 __ __ SEC
249a : a9 00 __ LDA #$00
249c : e5 1b __ SBC ACCU + 0 
249e : 85 1b __ STA ACCU + 0 
24a0 : a9 00 __ LDA #$00
24a2 : e5 1c __ SBC ACCU + 1 
24a4 : 85 1c __ STA ACCU + 1 
24a6 : 20 b0 24 JSR $24b0 ; (uint16_to_float + 0)
24a9 : a5 1e __ LDA ACCU + 3 
24ab : 09 80 __ ORA #$80
24ad : 85 1e __ STA ACCU + 3 
24af : 60 __ __ RTS
--------------------------------------------------------------------
uint16_to_float:
24b0 : a5 1b __ LDA ACCU + 0 
24b2 : 05 1c __ ORA ACCU + 1 
24b4 : d0 05 __ BNE $24bb ; (uint16_to_float + 11)
24b6 : 85 1d __ STA ACCU + 2 
24b8 : 85 1e __ STA ACCU + 3 
24ba : 60 __ __ RTS
24bb : a2 8e __ LDX #$8e
24bd : a5 1c __ LDA ACCU + 1 
24bf : 30 06 __ BMI $24c7 ; (uint16_to_float + 23)
24c1 : ca __ __ DEX
24c2 : 06 1b __ ASL ACCU + 0 
24c4 : 2a __ __ ROL
24c5 : 10 fa __ BPL $24c1 ; (uint16_to_float + 17)
24c7 : 29 7f __ AND #$7f
24c9 : 85 1d __ STA ACCU + 2 
24cb : a5 1b __ LDA ACCU + 0 
24cd : 85 1c __ STA ACCU + 1 
24cf : 8a __ __ TXA
24d0 : 4a __ __ LSR
24d1 : 85 1e __ STA ACCU + 3 
24d3 : a9 00 __ LDA #$00
24d5 : 85 1b __ STA ACCU + 0 
24d7 : 6a __ __ ROR
24d8 : 05 1d __ ORA ACCU + 2 
24da : 85 1d __ STA ACCU + 2 
24dc : 60 __ __ RTS
--------------------------------------------------------------------
divmod32:
24dd : 84 02 __ STY $02 
24df : a0 20 __ LDY #$20
24e1 : a9 00 __ LDA #$00
24e3 : 85 07 __ STA WORK + 4 
24e5 : 85 08 __ STA WORK + 5 
24e7 : 85 09 __ STA WORK + 6 
24e9 : 85 0a __ STA WORK + 7 
24eb : a5 05 __ LDA WORK + 2 
24ed : 05 06 __ ORA WORK + 3 
24ef : d0 39 __ BNE $252a ; (divmod32 + 77)
24f1 : 18 __ __ CLC
24f2 : 26 1b __ ROL ACCU + 0 
24f4 : 26 1c __ ROL ACCU + 1 
24f6 : 26 1d __ ROL ACCU + 2 
24f8 : 26 1e __ ROL ACCU + 3 
24fa : 26 07 __ ROL WORK + 4 
24fc : 26 08 __ ROL WORK + 5 
24fe : 90 0c __ BCC $250c ; (divmod32 + 47)
2500 : a5 07 __ LDA WORK + 4 
2502 : e5 03 __ SBC WORK + 0 
2504 : aa __ __ TAX
2505 : a5 08 __ LDA WORK + 5 
2507 : e5 04 __ SBC WORK + 1 
2509 : 38 __ __ SEC
250a : b0 0c __ BCS $2518 ; (divmod32 + 59)
250c : 38 __ __ SEC
250d : a5 07 __ LDA WORK + 4 
250f : e5 03 __ SBC WORK + 0 
2511 : aa __ __ TAX
2512 : a5 08 __ LDA WORK + 5 
2514 : e5 04 __ SBC WORK + 1 
2516 : 90 04 __ BCC $251c ; (divmod32 + 63)
2518 : 86 07 __ STX WORK + 4 
251a : 85 08 __ STA WORK + 5 
251c : 88 __ __ DEY
251d : d0 d3 __ BNE $24f2 ; (divmod32 + 21)
251f : 26 1b __ ROL ACCU + 0 
2521 : 26 1c __ ROL ACCU + 1 
2523 : 26 1d __ ROL ACCU + 2 
2525 : 26 1e __ ROL ACCU + 3 
2527 : a4 02 __ LDY $02 
2529 : 60 __ __ RTS
252a : 18 __ __ CLC
252b : 26 1b __ ROL ACCU + 0 
252d : 26 1c __ ROL ACCU + 1 
252f : 26 1d __ ROL ACCU + 2 
2531 : 26 1e __ ROL ACCU + 3 
2533 : 26 07 __ ROL WORK + 4 
2535 : 26 08 __ ROL WORK + 5 
2537 : 26 09 __ ROL WORK + 6 
2539 : 26 0a __ ROL WORK + 7 
253b : a5 07 __ LDA WORK + 4 
253d : c5 03 __ CMP WORK + 0 
253f : a5 08 __ LDA WORK + 5 
2541 : e5 04 __ SBC WORK + 1 
2543 : a5 09 __ LDA WORK + 6 
2545 : e5 05 __ SBC WORK + 2 
2547 : a5 0a __ LDA WORK + 7 
2549 : e5 06 __ SBC WORK + 3 
254b : 90 18 __ BCC $2565 ; (divmod32 + 136)
254d : a5 07 __ LDA WORK + 4 
254f : e5 03 __ SBC WORK + 0 
2551 : 85 07 __ STA WORK + 4 
2553 : a5 08 __ LDA WORK + 5 
2555 : e5 04 __ SBC WORK + 1 
2557 : 85 08 __ STA WORK + 5 
2559 : a5 09 __ LDA WORK + 6 
255b : e5 05 __ SBC WORK + 2 
255d : 85 09 __ STA WORK + 6 
255f : a5 0a __ LDA WORK + 7 
2561 : e5 06 __ SBC WORK + 3 
2563 : 85 0a __ STA WORK + 7 
2565 : 88 __ __ DEY
2566 : d0 c3 __ BNE $252b ; (divmod32 + 78)
2568 : 26 1b __ ROL ACCU + 0 
256a : 26 1c __ ROL ACCU + 1 
256c : 26 1d __ ROL ACCU + 2 
256e : 26 1e __ ROL ACCU + 3 
2570 : a4 02 __ LDY $02 
2572 : 60 __ __ RTS
--------------------------------------------------------------------
__multab5L:
2573 : __ __ __ BYT 00 05 0a 0f 14 19 1e 23 28 2d                   : .......#(-
--------------------------------------------------------------------
__multab3L:
257d : __ __ __ BYT 00 03 06                                        : ...
