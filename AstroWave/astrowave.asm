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
080e : 8e fe 25 STX $25fe ; (spentry + 0)
0811 : a9 a0 __ LDA #$a0
0813 : 85 19 __ STA IP + 0 
0815 : a9 26 __ LDA #$26
0817 : 85 1a __ STA IP + 1 
0819 : 38 __ __ SEC
081a : a9 27 __ LDA #$27
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
0830 : a9 00 __ LDA #$00
0832 : e9 a0 __ SBC #$a0
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
25fe : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
main:
.s0:
0880 : a9 00 __ LDA #$00
0882 : 8d a0 26 STA $26a0 ; (game + 0)
0885 : 20 97 08 JSR $0897 ; (redefine_charset.s0 + 0)
.l3:
0888 : 20 b4 09 JSR $09b4 ; (main_loop.s0 + 0)
088b : ad a0 26 LDA $26a0 ; (game + 0)
088e : f0 f8 __ BEQ $0888 ; (main.l3 + 0)
.s4:
0890 : a9 00 __ LDA #$00
0892 : 85 1b __ STA ACCU + 0 
0894 : 85 1c __ STA ACCU + 1 
.s1001:
0896 : 60 __ __ RTS
--------------------------------------------------------------------
game:
26a0 : __ __ __ BSS	6
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
08b7 : bd 0f 26 LDA $260f,x ; (__multab2000H + 7)
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
2610 : __ __ __ BYT 80 e0 f8 7f 7f f8 e0 80 00 00 60 3e 3e 60 00 00 : ..........`>>`..
2620 : __ __ __ BYT 00 00 3c 66 66 3c 00 00 1c 7f c6 1f 1f c6 7f 1c : ..<ff<..........
2630 : __ __ __ BYT 00 3c 7e d5 ab 7e 3c 00 28 3c 6e df 5f fe 3c 14 : .<~..~<.(<n._.<.
2640 : __ __ __ BYT 28 56 65 92 69 36 44 2a                         : (Ve.i6D*
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
09bd : 20 c9 0a JSR $0ac9 ; (init_player.s0 + 0)
09c0 : 20 d9 0a JSR $0ad9 ; (init_enemies.s0 + 0)
09c3 : 20 f1 0a JSR $0af1 ; (init_shots.s0 + 0)
09c6 : 20 18 0b JSR $0b18 ; (run_game.s1000 + 0)
09c9 : ae a5 26 LDX $26a5 ; (game + 5)
09cc : ce a5 26 DEC $26a5 ; (game + 5)
09cf : 8a __ __ TXA
09d0 : f0 07 __ BEQ $09d9 ; (main_loop.s3 + 0)
.s4:
09d2 : a9 01 __ LDA #$01
09d4 : 8d a0 26 STA $26a0 ; (game + 0)
09d7 : d0 e1 __ BNE $09ba ; (main_loop.l1 + 0)
.s3:
09d9 : 8d a0 26 STA $26a0 ; (game + 0)
.s1001:
09dc : 60 __ __ RTS
--------------------------------------------------------------------
init_game_state:
.s0:
09dd : a9 01 __ LDA #$01
09df : 8d a0 26 STA $26a0 ; (game + 0)
09e2 : a9 00 __ LDA #$00
09e4 : 8d a1 26 STA $26a1 ; (game + 1)
09e7 : 8d a2 26 STA $26a2 ; (game + 2)
09ea : 8d a3 26 STA $26a3 ; (game + 3)
09ed : 8d a4 26 STA $26a4 ; (game + 4)
09f0 : a9 03 __ LDA #$03
09f2 : 8d a5 26 STA $26a5 ; (game + 5)
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
0a0c : a9 a6 __ LDA #$a6
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
0a41 : b9 48 26 LDA $2648,y ; (mul40 + 0)
0a44 : 85 1b __ STA ACCU + 0 
0a46 : 18 __ __ CLC
0a47 : 65 11 __ ADC P4 ; (sx + 0)
0a49 : aa __ __ TAX
0a4a : b9 49 26 LDA $2649,y ; (mul40 + 1)
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
2648 : __ __ __ BYT 00 00 28 00 50 00 78 00 a0 00 c8 00 f0 00 18 01 : ..(.P.x.........
2658 : __ __ __ BYT 40 01 68 01 90 01 b8 01 e0 01 08 02 30 02 58 02 : @.h.........0.X.
2668 : __ __ __ BYT 80 02 a8 02 d0 02 f8 02 20 03 48 03 70 03 98 03 : ........ .H.p...
2678 : __ __ __ BYT c0 03                                           : ..
--------------------------------------------------------------------
cwTop:
26a6 : __ __ __ BSS	10
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
0ac9 : a9 05 __ LDA #$05
0acb : 8d b0 26 STA $26b0 ; (Player + 0)
0ace : a9 0c __ LDA #$0c
0ad0 : 8d b1 26 STA $26b1 ; (Player + 1)
0ad3 : a9 00 __ LDA #$00
0ad5 : 8d b5 26 STA $26b5 ; (PlayerShotSound + 3)
.s1001:
0ad8 : 60 __ __ RTS
--------------------------------------------------------------------
Player:
26b0 : __ __ __ BSS	2
--------------------------------------------------------------------
PlayerShotSound:
26b2 : __ __ __ BSS	4
--------------------------------------------------------------------
init_enemies:
.s0:
0ad9 : a2 00 __ LDX #$00
0adb : a0 0a __ LDY #$0a
.l1002:
0add : a9 00 __ LDA #$00
0adf : 9d b6 26 STA $26b6,x ; (Enemy + 0)
0ae2 : 9d b7 26 STA $26b7,x ; (Enemy + 1)
0ae5 : 9d ba 26 STA $26ba,x ; (Enemy + 4)
0ae8 : 8a __ __ TXA
0ae9 : 18 __ __ CLC
0aea : 69 05 __ ADC #$05
0aec : aa __ __ TAX
0aed : 88 __ __ DEY
0aee : d0 ed __ BNE $0add ; (init_enemies.l1002 + 0)
.s1001:
0af0 : 60 __ __ RTS
--------------------------------------------------------------------
Enemy:
26b6 : __ __ __ BSS	50
--------------------------------------------------------------------
init_shots:
.s0:
0af1 : a2 00 __ LDX #$00
0af3 : a0 03 __ LDY #$03
0af5 : 8a __ __ TXA
.l1006:
0af6 : 9d e8 26 STA $26e8,x ; (PlayerShot + 0)
0af9 : 9d e9 26 STA $26e9,x ; (PlayerShot + 1)
0afc : 9d ea 26 STA $26ea,x ; (PlayerShot + 2)
0aff : e8 __ __ INX
0b00 : e8 __ __ INX
0b01 : e8 __ __ INX
0b02 : 88 __ __ DEY
0b03 : d0 f1 __ BNE $0af6 ; (init_shots.l1006 + 0)
.s6:
0b05 : a0 03 __ LDY #$03
0b07 : aa __ __ TAX
.l1008:
0b08 : 9d f1 26 STA $26f1,x ; (EnemyShot + 0)
0b0b : 9d f2 26 STA $26f2,x ; (EnemyShot + 1)
0b0e : 9d f3 26 STA $26f3,x ; (EnemyShot + 2)
0b11 : e8 __ __ INX
0b12 : e8 __ __ INX
0b13 : e8 __ __ INX
0b14 : 88 __ __ DEY
0b15 : d0 f1 __ BNE $0b08 ; (init_shots.l1008 + 0)
.s1001:
0b17 : 60 __ __ RTS
--------------------------------------------------------------------
PlayerShot:
26e8 : __ __ __ BSS	9
--------------------------------------------------------------------
EnemyShot:
26f1 : __ __ __ BSS	9
--------------------------------------------------------------------
run_game:
.s1000:
0b18 : a5 53 __ LDA T0 + 0 
0b1a : 8d cd 9f STA $9fcd ; (run_game@stack + 0)
.s0:
0b1d : a9 ff __ LDA #$ff
0b1f : 8d 18 d4 STA $d418 
0b22 : ad a0 26 LDA $26a0 ; (game + 0)
0b25 : c9 01 __ CMP #$01
0b27 : d0 5c __ BNE $0b85 ; (run_game.s1001 + 0)
.s7:
0b29 : a9 00 __ LDA #$00
0b2b : 85 53 __ STA T0 + 0 
.l2:
0b2d : 20 8b 0b JSR $0b8b ; (render_game_state.s1000 + 0)
0b30 : 20 85 19 JSR $1985 ; (play_sound_effects.s0 + 0)
0b33 : a5 53 __ LDA T0 + 0 
0b35 : 85 1b __ STA ACCU + 0 
0b37 : a9 00 __ LDA #$00
0b39 : 85 1c __ STA ACCU + 1 
0b3b : 85 04 __ STA WORK + 1 
0b3d : a9 03 __ LDA #$03
0b3f : 85 03 __ STA WORK + 0 
0b41 : 20 23 24 JSR $2423 ; (divmod + 0)
0b44 : a5 05 __ LDA WORK + 2 
0b46 : 05 06 __ ORA WORK + 3 
0b48 : d0 0c __ BNE $0b56 ; (run_game.s6 + 0)
.s4:
0b4a : 20 f1 19 JSR $19f1 ; (spawn_enemy.s0 + 0)
0b4d : 20 88 1a JSR $1a88 ; (move_enemies.s0 + 0)
0b50 : 20 00 1c JSR $1c00 ; (render_enemies.s0 + 0)
0b53 : 20 5d 1c JSR $1c5d ; (check_shot_enemy_collision.s0 + 0)
.s6:
0b56 : 20 a3 1d JSR $1da3 ; (move_enemy_shots.s0 + 0)
0b59 : 20 ab 1b JSR $1bab ; (render_enemy_shots.s0 + 0)
0b5c : 20 0d 1e JSR $1e0d ; (check_player_enemy_collision.s0 + 0)
0b5f : 20 f8 1e JSR $1ef8 ; (control_player_ship.s0 + 0)
0b62 : 20 22 20 JSR $2022 ; (render_player_ship.s0 + 0)
0b65 : 20 0d 1e JSR $1e0d ; (check_player_enemy_collision.s0 + 0)
0b68 : 20 62 20 JSR $2062 ; (move_player_shots.s0 + 0)
0b6b : 20 ca 20 JSR $20ca ; (render_player_shots.s0 + 0)
0b6e : 20 5d 1c JSR $1c5d ; (check_shot_enemy_collision.s0 + 0)
0b71 : a9 03 __ LDA #$03
0b73 : 85 0d __ STA P0 
0b75 : a9 00 __ LDA #$00
0b77 : 85 0e __ STA P1 
0b79 : 20 1f 21 JSR $211f ; (wait_frames.s0 + 0)
0b7c : e6 53 __ INC T0 + 0 
0b7e : ad a0 26 LDA $26a0 ; (game + 0)
0b81 : c9 01 __ CMP #$01
0b83 : f0 a8 __ BEQ $0b2d ; (run_game.l2 + 0)
.s1001:
0b85 : ad cd 9f LDA $9fcd ; (run_game@stack + 0)
0b88 : 85 53 __ STA T0 + 0 
0b8a : 60 __ __ RTS
--------------------------------------------------------------------
render_game_state:
.s1000:
0b8b : 38 __ __ SEC
0b8c : a5 23 __ LDA SP + 0 
0b8e : e9 0a __ SBC #$0a
0b90 : 85 23 __ STA SP + 0 
0b92 : b0 02 __ BCS $0b96 ; (render_game_state.s0 + 0)
0b94 : c6 24 __ DEC SP + 1 
.s0:
0b96 : a9 01 __ LDA #$01
0b98 : 85 0f __ STA P2 
0b9a : a9 02 __ LDA #$02
0b9c : 85 10 __ STA P3 
0b9e : a9 05 __ LDA #$05
0ba0 : 85 13 __ STA P6 
0ba2 : a9 a6 __ LDA #$a6
0ba4 : 85 0d __ STA P0 
0ba6 : a9 26 __ LDA #$26
0ba8 : 85 0e __ STA P1 
0baa : a9 f3 __ LDA #$f3
0bac : 85 11 __ STA P4 
0bae : a9 08 __ LDA #$08
0bb0 : 85 12 __ STA P5 
0bb2 : 20 65 0c JSR $0c65 ; (cwin_putat_string.s0 + 0)
0bb5 : a9 ce __ LDA #$ce
0bb7 : a0 02 __ LDY #$02
0bb9 : 91 23 __ STA (SP + 0),y 
0bbb : a9 9f __ LDA #$9f
0bbd : c8 __ __ INY
0bbe : 91 23 __ STA (SP + 0),y 
0bc0 : a9 fa __ LDA #$fa
0bc2 : c8 __ __ INY
0bc3 : 91 23 __ STA (SP + 0),y 
0bc5 : a9 08 __ LDA #$08
0bc7 : c8 __ __ INY
0bc8 : 91 23 __ STA (SP + 0),y 
0bca : ad a1 26 LDA $26a1 ; (game + 1)
0bcd : c8 __ __ INY
0bce : 91 23 __ STA (SP + 0),y 
0bd0 : ad a2 26 LDA $26a2 ; (game + 2)
0bd3 : c8 __ __ INY
0bd4 : 91 23 __ STA (SP + 0),y 
0bd6 : ad a3 26 LDA $26a3 ; (game + 3)
0bd9 : c8 __ __ INY
0bda : 91 23 __ STA (SP + 0),y 
0bdc : ad a4 26 LDA $26a4 ; (game + 4)
0bdf : c8 __ __ INY
0be0 : 91 23 __ STA (SP + 0),y 
0be2 : 20 b7 0c JSR $0cb7 ; (sprintf.s1000 + 0)
0be5 : a9 a6 __ LDA #$a6
0be7 : 85 0d __ STA P0 
0be9 : a9 26 __ LDA #$26
0beb : 85 0e __ STA P1 
0bed : a9 08 __ LDA #$08
0bef : 85 0f __ STA P2 
0bf1 : a9 02 __ LDA #$02
0bf3 : 85 10 __ STA P3 
0bf5 : a9 ce __ LDA #$ce
0bf7 : 85 11 __ STA P4 
0bf9 : a9 9f __ LDA #$9f
0bfb : 85 12 __ STA P5 
0bfd : a9 05 __ LDA #$05
0bff : 85 13 __ STA P6 
0c01 : 20 65 0c JSR $0c65 ; (cwin_putat_string.s0 + 0)
0c04 : a9 20 __ LDA #$20
0c06 : 85 0f __ STA P2 
0c08 : a9 0e __ LDA #$0e
0c0a : 85 13 __ STA P6 
0c0c : a9 7e __ LDA #$7e
0c0e : 85 11 __ STA P4 
0c10 : a9 19 __ LDA #$19
0c12 : 85 12 __ STA P5 
0c14 : 20 65 0c JSR $0c65 ; (cwin_putat_string.s0 + 0)
0c17 : a9 ce __ LDA #$ce
0c19 : a0 02 __ LDY #$02
0c1b : 91 23 __ STA (SP + 0),y 
0c1d : a9 9f __ LDA #$9f
0c1f : c8 __ __ INY
0c20 : 91 23 __ STA (SP + 0),y 
0c22 : a9 fa __ LDA #$fa
0c24 : c8 __ __ INY
0c25 : 91 23 __ STA (SP + 0),y 
0c27 : a9 08 __ LDA #$08
0c29 : c8 __ __ INY
0c2a : 91 23 __ STA (SP + 0),y 
0c2c : ad a5 26 LDA $26a5 ; (game + 5)
0c2f : c8 __ __ INY
0c30 : 91 23 __ STA (SP + 0),y 
0c32 : a9 00 __ LDA #$00
0c34 : c8 __ __ INY
0c35 : 91 23 __ STA (SP + 0),y 
0c37 : 20 b7 0c JSR $0cb7 ; (sprintf.s1000 + 0)
0c3a : a9 a6 __ LDA #$a6
0c3c : 85 0d __ STA P0 
0c3e : a9 26 __ LDA #$26
0c40 : 85 0e __ STA P1 
0c42 : a9 26 __ LDA #$26
0c44 : 85 0f __ STA P2 
0c46 : a9 02 __ LDA #$02
0c48 : 85 10 __ STA P3 
0c4a : a9 ce __ LDA #$ce
0c4c : 85 11 __ STA P4 
0c4e : a9 9f __ LDA #$9f
0c50 : 85 12 __ STA P5 
0c52 : a9 0e __ LDA #$0e
0c54 : 85 13 __ STA P6 
0c56 : 20 65 0c JSR $0c65 ; (cwin_putat_string.s0 + 0)
.s1001:
0c59 : 18 __ __ CLC
0c5a : a5 23 __ LDA SP + 0 
0c5c : 69 0a __ ADC #$0a
0c5e : 85 23 __ STA SP + 0 
0c60 : 90 02 __ BCC $0c64 ; (render_game_state.s1001 + 11)
0c62 : e6 24 __ INC SP + 1 
0c64 : 60 __ __ RTS
--------------------------------------------------------------------
cwin_putat_string:
.s0:
0c65 : a5 10 __ LDA P3 ; (y + 0)
0c67 : 0a __ __ ASL
0c68 : aa __ __ TAX
0c69 : bd 48 26 LDA $2648,x ; (mul40 + 0)
0c6c : 18 __ __ CLC
0c6d : 65 0f __ ADC P2 ; (x + 0)
0c6f : 85 1b __ STA ACCU + 0 
0c71 : bd 49 26 LDA $2649,x ; (mul40 + 1)
0c74 : 69 00 __ ADC #$00
0c76 : 85 1c __ STA ACCU + 1 
0c78 : a0 06 __ LDY #$06
0c7a : b1 0d __ LDA (P0),y ; (win + 0)
0c7c : 18 __ __ CLC
0c7d : 65 1b __ ADC ACCU + 0 
0c7f : 85 43 __ STA T3 + 0 
0c81 : c8 __ __ INY
0c82 : b1 0d __ LDA (P0),y ; (win + 0)
0c84 : 65 1c __ ADC ACCU + 1 
0c86 : 85 44 __ STA T3 + 1 
0c88 : c8 __ __ INY
0c89 : b1 0d __ LDA (P0),y ; (win + 0)
0c8b : 18 __ __ CLC
0c8c : 65 1b __ ADC ACCU + 0 
0c8e : 85 1b __ STA ACCU + 0 
0c90 : c8 __ __ INY
0c91 : b1 0d __ LDA (P0),y ; (win + 0)
0c93 : 65 1c __ ADC ACCU + 1 
0c95 : 85 1c __ STA ACCU + 1 
0c97 : a0 00 __ LDY #$00
0c99 : b1 11 __ LDA (P4),y ; (str + 0)
0c9b : f0 18 __ BEQ $0cb5 ; (cwin_putat_string.s3 + 0)
.l2:
0c9d : 85 1d __ STA ACCU + 2 
0c9f : 4a __ __ LSR
0ca0 : 4a __ __ LSR
0ca1 : 4a __ __ LSR
0ca2 : 4a __ __ LSR
0ca3 : 4a __ __ LSR
0ca4 : aa __ __ TAX
0ca5 : bd 7a 26 LDA $267a,x ; (p2smap + 0)
0ca8 : 45 1d __ EOR ACCU + 2 
0caa : 91 43 __ STA (T3 + 0),y 
0cac : a5 13 __ LDA P6 ; (color + 0)
0cae : 91 1b __ STA (ACCU + 0),y 
0cb0 : c8 __ __ INY
0cb1 : b1 11 __ LDA (P4),y ; (str + 0)
0cb3 : d0 e8 __ BNE $0c9d ; (cwin_putat_string.l2 + 0)
.s3:
0cb5 : 98 __ __ TYA
.s1001:
0cb6 : 60 __ __ RTS
--------------------------------------------------------------------
p2smap:
267a : __ __ __ BYT 00 00 40 20 80 c0 80 80                         : ..@ ....
--------------------------------------------------------------------
08f3 : __ __ __ BYT 53 43 4f 52 45 3a 00                            : SCORE:.
--------------------------------------------------------------------
sprintf:
.s1000:
0cb7 : a5 53 __ LDA T0 + 0 
0cb9 : 8d d8 9f STA $9fd8 ; (sprintf@stack + 0)
0cbc : a5 54 __ LDA T0 + 1 
0cbe : 8d d9 9f STA $9fd9 ; (sprintf@stack + 1)
.s0:
0cc1 : a9 00 __ LDA #$00
0cc3 : 8d ff 9f STA $9fff ; (sstack + 7)
0cc6 : a0 03 __ LDY #$03
0cc8 : b1 23 __ LDA (SP + 0),y 
0cca : 85 54 __ STA T0 + 1 
0ccc : 8d fa 9f STA $9ffa ; (sstack + 2)
0ccf : 88 __ __ DEY
0cd0 : b1 23 __ LDA (SP + 0),y 
0cd2 : 85 53 __ STA T0 + 0 
0cd4 : 8d f9 9f STA $9ff9 ; (sstack + 1)
0cd7 : a0 04 __ LDY #$04
0cd9 : b1 23 __ LDA (SP + 0),y 
0cdb : 8d fb 9f STA $9ffb ; (sstack + 3)
0cde : c8 __ __ INY
0cdf : b1 23 __ LDA (SP + 0),y 
0ce1 : 8d fc 9f STA $9ffc ; (sstack + 4)
0ce4 : 18 __ __ CLC
0ce5 : a5 23 __ LDA SP + 0 
0ce7 : 69 06 __ ADC #$06
0ce9 : 8d fd 9f STA $9ffd ; (sstack + 5)
0cec : a5 24 __ LDA SP + 1 
0cee : 69 00 __ ADC #$00
0cf0 : 8d fe 9f STA $9ffe ; (sstack + 6)
0cf3 : 20 0e 0d JSR $0d0e ; (sformat.s1000 + 0)
0cf6 : 38 __ __ SEC
0cf7 : a5 1b __ LDA ACCU + 0 
0cf9 : e5 53 __ SBC T0 + 0 
0cfb : 85 1b __ STA ACCU + 0 
0cfd : a5 1c __ LDA ACCU + 1 
0cff : e5 54 __ SBC T0 + 1 
0d01 : 85 1c __ STA ACCU + 1 
.s1001:
0d03 : ad d8 9f LDA $9fd8 ; (sprintf@stack + 0)
0d06 : 85 53 __ STA T0 + 0 
0d08 : ad d9 9f LDA $9fd9 ; (sprintf@stack + 1)
0d0b : 85 54 __ STA T0 + 1 
0d0d : 60 __ __ RTS
--------------------------------------------------------------------
sformat:
.s1000:
0d0e : a2 05 __ LDX #$05
0d10 : b5 53 __ LDA T1 + 0,x 
0d12 : 9d da 9f STA $9fda,x ; (sformat@stack + 0)
0d15 : ca __ __ DEX
0d16 : 10 f8 __ BPL $0d10 ; (sformat.s1000 + 2)
.s0:
0d18 : a9 00 __ LDA #$00
0d1a : 85 50 __ STA T0 + 0 
0d1c : ad fb 9f LDA $9ffb ; (sstack + 3)
0d1f : 85 53 __ STA T1 + 0 
0d21 : ad fc 9f LDA $9ffc ; (sstack + 4)
0d24 : 85 54 __ STA T1 + 1 
0d26 : ad f9 9f LDA $9ff9 ; (sstack + 1)
0d29 : 85 55 __ STA T2 + 0 
0d2b : ad fa 9f LDA $9ffa ; (sstack + 2)
0d2e : 85 56 __ STA T2 + 1 
.l1:
0d30 : a0 00 __ LDY #$00
0d32 : b1 53 __ LDA (T1 + 0),y 
0d34 : d0 38 __ BNE $0d6e ; (sformat.s2 + 0)
.s3:
0d36 : a4 50 __ LDY T0 + 0 
0d38 : 91 55 __ STA (T2 + 0),y 
0d3a : 98 __ __ TYA
0d3b : f0 28 __ BEQ $0d65 ; (sformat.s1061 + 0)
.s112:
0d3d : ad ff 9f LDA $9fff ; (sstack + 7)
0d40 : d0 18 __ BNE $0d5a ; (sformat.s115 + 0)
.s116:
0d42 : 18 __ __ CLC
0d43 : a5 55 __ LDA T2 + 0 
0d45 : 65 50 __ ADC T0 + 0 
0d47 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0d49 : a5 56 __ LDA T2 + 1 
0d4b : 69 00 __ ADC #$00
.s1001:
0d4d : 85 1c __ STA ACCU + 1 ; (fmt + 0)
0d4f : a2 05 __ LDX #$05
0d51 : bd da 9f LDA $9fda,x ; (sformat@stack + 0)
0d54 : 95 53 __ STA T1 + 0,x 
0d56 : ca __ __ DEX
0d57 : 10 f8 __ BPL $0d51 ; (sformat.s1001 + 4)
0d59 : 60 __ __ RTS
.s115:
0d5a : a5 55 __ LDA T2 + 0 
0d5c : 85 0d __ STA P0 
0d5e : a5 56 __ LDA T2 + 1 
0d60 : 85 0e __ STA P1 
0d62 : 20 52 11 JSR $1152 ; (puts.s0 + 0)
.s1061:
0d65 : a5 55 __ LDA T2 + 0 
0d67 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0d69 : a5 56 __ LDA T2 + 1 
0d6b : 4c 4d 0d JMP $0d4d ; (sformat.s1001 + 0)
.s2:
0d6e : c9 25 __ CMP #$25
0d70 : f0 3f __ BEQ $0db1 ; (sformat.s4 + 0)
.s5:
0d72 : a4 50 __ LDY T0 + 0 
0d74 : 91 55 __ STA (T2 + 0),y 
0d76 : e6 53 __ INC T1 + 0 
0d78 : d0 02 __ BNE $0d7c ; (sformat.s1090 + 0)
.s1089:
0d7a : e6 54 __ INC T1 + 1 
.s1090:
0d7c : c8 __ __ INY
0d7d : 84 50 __ STY T0 + 0 
0d7f : 98 __ __ TYA
0d80 : c0 28 __ CPY #$28
0d82 : 90 ac __ BCC $0d30 ; (sformat.l1 + 0)
.s106:
0d84 : 85 57 __ STA T5 + 0 
0d86 : a9 00 __ LDA #$00
0d88 : 85 50 __ STA T0 + 0 
0d8a : ad ff 9f LDA $9fff ; (sstack + 7)
0d8d : f0 14 __ BEQ $0da3 ; (sformat.s110 + 0)
.s109:
0d8f : a5 55 __ LDA T2 + 0 
0d91 : 85 0d __ STA P0 
0d93 : a5 56 __ LDA T2 + 1 
0d95 : 85 0e __ STA P1 
0d97 : a9 00 __ LDA #$00
0d99 : a4 57 __ LDY T5 + 0 
0d9b : 91 0d __ STA (P0),y 
0d9d : 20 52 11 JSR $1152 ; (puts.s0 + 0)
0da0 : 4c 30 0d JMP $0d30 ; (sformat.l1 + 0)
.s110:
0da3 : 18 __ __ CLC
0da4 : a5 55 __ LDA T2 + 0 
0da6 : 65 57 __ ADC T5 + 0 
0da8 : 85 55 __ STA T2 + 0 
0daa : 90 84 __ BCC $0d30 ; (sformat.l1 + 0)
.s1092:
0dac : e6 56 __ INC T2 + 1 
0dae : 4c 30 0d JMP $0d30 ; (sformat.l1 + 0)
.s4:
0db1 : a5 50 __ LDA T0 + 0 
0db3 : f0 27 __ BEQ $0ddc ; (sformat.s9 + 0)
.s7:
0db5 : 84 50 __ STY T0 + 0 
0db7 : 85 57 __ STA T5 + 0 
0db9 : ad ff 9f LDA $9fff ; (sstack + 7)
0dbc : f0 13 __ BEQ $0dd1 ; (sformat.s11 + 0)
.s10:
0dbe : a5 55 __ LDA T2 + 0 
0dc0 : 85 0d __ STA P0 
0dc2 : a5 56 __ LDA T2 + 1 
0dc4 : 85 0e __ STA P1 
0dc6 : 98 __ __ TYA
0dc7 : a4 57 __ LDY T5 + 0 
0dc9 : 91 0d __ STA (P0),y 
0dcb : 20 52 11 JSR $1152 ; (puts.s0 + 0)
0dce : 4c dc 0d JMP $0ddc ; (sformat.s9 + 0)
.s11:
0dd1 : 18 __ __ CLC
0dd2 : a5 55 __ LDA T2 + 0 
0dd4 : 65 57 __ ADC T5 + 0 
0dd6 : 85 55 __ STA T2 + 0 
0dd8 : 90 02 __ BCC $0ddc ; (sformat.s9 + 0)
.s1087:
0dda : e6 56 __ INC T2 + 1 
.s9:
0ddc : a9 0a __ LDA #$0a
0dde : 8d e3 9f STA $9fe3 ; (si + 3)
0de1 : a9 00 __ LDA #$00
0de3 : 8d e4 9f STA $9fe4 ; (si + 4)
0de6 : 8d e5 9f STA $9fe5 ; (si + 5)
0de9 : 8d e6 9f STA $9fe6 ; (si + 6)
0dec : 8d e7 9f STA $9fe7 ; (si + 7)
0def : a0 01 __ LDY #$01
0df1 : b1 53 __ LDA (T1 + 0),y 
0df3 : aa __ __ TAX
0df4 : a9 20 __ LDA #$20
0df6 : 8d e0 9f STA $9fe0 ; (si + 0)
0df9 : a9 00 __ LDA #$00
0dfb : 8d e1 9f STA $9fe1 ; (si + 1)
0dfe : a9 ff __ LDA #$ff
0e00 : 8d e2 9f STA $9fe2 ; (si + 2)
0e03 : 18 __ __ CLC
0e04 : a5 53 __ LDA T1 + 0 
0e06 : 69 02 __ ADC #$02
.l14:
0e08 : 85 53 __ STA T1 + 0 
0e0a : 90 02 __ BCC $0e0e ; (sformat.s1074 + 0)
.s1073:
0e0c : e6 54 __ INC T1 + 1 
.s1074:
0e0e : 8a __ __ TXA
0e0f : e0 2b __ CPX #$2b
0e11 : d0 08 __ BNE $0e1b ; (sformat.s17 + 0)
.s16:
0e13 : a9 01 __ LDA #$01
0e15 : 8d e5 9f STA $9fe5 ; (si + 5)
0e18 : 4c 45 11 JMP $1145 ; (sformat.s224 + 0)
.s17:
0e1b : c9 30 __ CMP #$30
0e1d : d0 06 __ BNE $0e25 ; (sformat.s20 + 0)
.s19:
0e1f : 8d e0 9f STA $9fe0 ; (si + 0)
0e22 : 4c 45 11 JMP $1145 ; (sformat.s224 + 0)
.s20:
0e25 : e0 23 __ CPX #$23
0e27 : d0 08 __ BNE $0e31 ; (sformat.s23 + 0)
.s22:
0e29 : a9 01 __ LDA #$01
0e2b : 8d e7 9f STA $9fe7 ; (si + 7)
0e2e : 4c 45 11 JMP $1145 ; (sformat.s224 + 0)
.s23:
0e31 : e0 2d __ CPX #$2d
0e33 : d0 08 __ BNE $0e3d ; (sformat.s15 + 0)
.s25:
0e35 : a9 01 __ LDA #$01
0e37 : 8d e6 9f STA $9fe6 ; (si + 6)
0e3a : 4c 45 11 JMP $1145 ; (sformat.s224 + 0)
.s15:
0e3d : 86 57 __ STX T5 + 0 
0e3f : e0 30 __ CPX #$30
0e41 : 90 53 __ BCC $0e96 ; (sformat.s31 + 0)
.s32:
0e43 : e0 3a __ CPX #$3a
0e45 : b0 4f __ BCS $0e96 ; (sformat.s31 + 0)
.s29:
0e47 : a9 00 __ LDA #$00
0e49 : 85 44 __ STA T6 + 0 
0e4b : 85 45 __ STA T6 + 1 
0e4d : e0 3a __ CPX #$3a
0e4f : b0 40 __ BCS $0e91 ; (sformat.s35 + 0)
.l34:
0e51 : a5 44 __ LDA T6 + 0 
0e53 : 0a __ __ ASL
0e54 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0e56 : a5 45 __ LDA T6 + 1 
0e58 : 2a __ __ ROL
0e59 : 06 1b __ ASL ACCU + 0 ; (buff + 1)
0e5b : 2a __ __ ROL
0e5c : aa __ __ TAX
0e5d : 18 __ __ CLC
0e5e : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0e60 : 65 44 __ ADC T6 + 0 
0e62 : 85 44 __ STA T6 + 0 
0e64 : 8a __ __ TXA
0e65 : 65 45 __ ADC T6 + 1 
0e67 : 06 44 __ ASL T6 + 0 
0e69 : 2a __ __ ROL
0e6a : aa __ __ TAX
0e6b : 18 __ __ CLC
0e6c : a5 44 __ LDA T6 + 0 
0e6e : 65 57 __ ADC T5 + 0 
0e70 : 90 01 __ BCC $0e73 ; (sformat.s1084 + 0)
.s1083:
0e72 : e8 __ __ INX
.s1084:
0e73 : 38 __ __ SEC
0e74 : e9 30 __ SBC #$30
0e76 : 85 44 __ STA T6 + 0 
0e78 : 8a __ __ TXA
0e79 : e9 00 __ SBC #$00
0e7b : 85 45 __ STA T6 + 1 
0e7d : a0 00 __ LDY #$00
0e7f : b1 53 __ LDA (T1 + 0),y 
0e81 : 85 57 __ STA T5 + 0 
0e83 : e6 53 __ INC T1 + 0 
0e85 : d0 02 __ BNE $0e89 ; (sformat.s1086 + 0)
.s1085:
0e87 : e6 54 __ INC T1 + 1 
.s1086:
0e89 : c9 30 __ CMP #$30
0e8b : 90 04 __ BCC $0e91 ; (sformat.s35 + 0)
.s36:
0e8d : c9 3a __ CMP #$3a
0e8f : 90 c0 __ BCC $0e51 ; (sformat.l34 + 0)
.s35:
0e91 : a5 44 __ LDA T6 + 0 
0e93 : 8d e1 9f STA $9fe1 ; (si + 1)
.s31:
0e96 : a5 57 __ LDA T5 + 0 
0e98 : c9 2e __ CMP #$2e
0e9a : d0 51 __ BNE $0eed ; (sformat.s39 + 0)
.s37:
0e9c : a9 00 __ LDA #$00
0e9e : 85 44 __ STA T6 + 0 
.l203:
0ea0 : 85 45 __ STA T6 + 1 
0ea2 : a0 00 __ LDY #$00
0ea4 : b1 53 __ LDA (T1 + 0),y 
0ea6 : 85 57 __ STA T5 + 0 
0ea8 : e6 53 __ INC T1 + 0 
0eaa : d0 02 __ BNE $0eae ; (sformat.s1076 + 0)
.s1075:
0eac : e6 54 __ INC T1 + 1 
.s1076:
0eae : c9 30 __ CMP #$30
0eb0 : 90 04 __ BCC $0eb6 ; (sformat.s42 + 0)
.s43:
0eb2 : c9 3a __ CMP #$3a
0eb4 : 90 0a __ BCC $0ec0 ; (sformat.s41 + 0)
.s42:
0eb6 : a5 44 __ LDA T6 + 0 
0eb8 : 8d e2 9f STA $9fe2 ; (si + 2)
0ebb : a5 57 __ LDA T5 + 0 
0ebd : 4c ed 0e JMP $0eed ; (sformat.s39 + 0)
.s41:
0ec0 : a5 44 __ LDA T6 + 0 
0ec2 : 0a __ __ ASL
0ec3 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0ec5 : a5 45 __ LDA T6 + 1 
0ec7 : 2a __ __ ROL
0ec8 : 06 1b __ ASL ACCU + 0 ; (buff + 1)
0eca : 2a __ __ ROL
0ecb : aa __ __ TAX
0ecc : 18 __ __ CLC
0ecd : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0ecf : 65 44 __ ADC T6 + 0 
0ed1 : 85 44 __ STA T6 + 0 
0ed3 : 8a __ __ TXA
0ed4 : 65 45 __ ADC T6 + 1 
0ed6 : 06 44 __ ASL T6 + 0 
0ed8 : 2a __ __ ROL
0ed9 : aa __ __ TAX
0eda : 18 __ __ CLC
0edb : a5 44 __ LDA T6 + 0 
0edd : 65 57 __ ADC T5 + 0 
0edf : 90 01 __ BCC $0ee2 ; (sformat.s1082 + 0)
.s1081:
0ee1 : e8 __ __ INX
.s1082:
0ee2 : 38 __ __ SEC
0ee3 : e9 30 __ SBC #$30
0ee5 : 85 44 __ STA T6 + 0 
0ee7 : 8a __ __ TXA
0ee8 : e9 00 __ SBC #$00
0eea : 4c a0 0e JMP $0ea0 ; (sformat.l203 + 0)
.s39:
0eed : c9 64 __ CMP #$64
0eef : d0 05 __ BNE $0ef6 ; (sformat.s45 + 0)
.s44:
0ef1 : a9 01 __ LDA #$01
0ef3 : 4c 09 11 JMP $1109 ; (sformat.s221 + 0)
.s45:
0ef6 : c9 75 __ CMP #$75
0ef8 : d0 03 __ BNE $0efd ; (sformat.s48 + 0)
0efa : 4c 07 11 JMP $1107 ; (sformat.s250 + 0)
.s48:
0efd : c9 78 __ CMP #$78
0eff : d0 0d __ BNE $0f0e ; (sformat.s51 + 0)
.s50:
0f01 : a9 10 __ LDA #$10
0f03 : 8d e3 9f STA $9fe3 ; (si + 3)
0f06 : a9 00 __ LDA #$00
0f08 : 8d e4 9f STA $9fe4 ; (si + 4)
0f0b : 4c 07 11 JMP $1107 ; (sformat.s250 + 0)
.s51:
0f0e : c9 6c __ CMP #$6c
0f10 : d0 03 __ BNE $0f15 ; (sformat.s54 + 0)
0f12 : 4c 82 10 JMP $1082 ; (sformat.s53 + 0)
.s54:
0f15 : c9 66 __ CMP #$66
0f17 : f0 08 __ BEQ $0f21 ; (sformat.s65 + 0)
.s69:
0f19 : c9 67 __ CMP #$67
0f1b : f0 04 __ BEQ $0f21 ; (sformat.s65 + 0)
.s68:
0f1d : c9 65 __ CMP #$65
0f1f : d0 4d __ BNE $0f6e ; (sformat.s66 + 0)
.s65:
0f21 : a5 55 __ LDA T2 + 0 
0f23 : 85 13 __ STA P6 
0f25 : a5 56 __ LDA T2 + 1 
0f27 : 85 14 __ STA P7 
0f29 : a5 57 __ LDA T5 + 0 
0f2b : 8d f8 9f STA $9ff8 ; (sstack + 0)
0f2e : a9 e0 __ LDA #$e0
0f30 : 85 11 __ STA P4 
0f32 : a9 9f __ LDA #$9f
0f34 : 85 12 __ STA P5 
0f36 : ad fd 9f LDA $9ffd ; (sstack + 5)
0f39 : 85 57 __ STA T5 + 0 
0f3b : ad fe 9f LDA $9ffe ; (sstack + 6)
0f3e : 85 58 __ STA T5 + 1 
0f40 : a0 00 __ LDY #$00
0f42 : b1 57 __ LDA (T5 + 0),y 
0f44 : 85 15 __ STA P8 
0f46 : c8 __ __ INY
0f47 : b1 57 __ LDA (T5 + 0),y 
0f49 : 85 16 __ STA P9 
0f4b : c8 __ __ INY
0f4c : b1 57 __ LDA (T5 + 0),y 
0f4e : 85 17 __ STA P10 
0f50 : c8 __ __ INY
0f51 : b1 57 __ LDA (T5 + 0),y 
0f53 : 85 18 __ STA P11 
0f55 : 20 9e 14 JSR $149e ; (nformf.s0 + 0)
0f58 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0f5a : 85 50 __ STA T0 + 0 
0f5c : 18 __ __ CLC
0f5d : a5 57 __ LDA T5 + 0 
0f5f : 69 04 __ ADC #$04
0f61 : 8d fd 9f STA $9ffd ; (sstack + 5)
0f64 : a5 58 __ LDA T5 + 1 
0f66 : 69 00 __ ADC #$00
0f68 : 8d fe 9f STA $9ffe ; (sstack + 6)
0f6b : 4c 30 0d JMP $0d30 ; (sformat.l1 + 0)
.s66:
0f6e : c9 73 __ CMP #$73
0f70 : f0 4c __ BEQ $0fbe ; (sformat.s70 + 0)
.s71:
0f72 : c9 63 __ CMP #$63
0f74 : f0 1f __ BEQ $0f95 ; (sformat.s100 + 0)
.s101:
0f76 : 09 00 __ ORA #$00
0f78 : d0 03 __ BNE $0f7d ; (sformat.s103 + 0)
0f7a : 4c 30 0d JMP $0d30 ; (sformat.l1 + 0)
.s103:
0f7d : 18 __ __ CLC
0f7e : a5 55 __ LDA T2 + 0 
0f80 : 65 50 __ ADC T0 + 0 
0f82 : 85 44 __ STA T6 + 0 
0f84 : a5 56 __ LDA T2 + 1 
0f86 : 69 00 __ ADC #$00
0f88 : 85 45 __ STA T6 + 1 
0f8a : a5 57 __ LDA T5 + 0 
.s1059:
0f8c : a0 00 __ LDY #$00
0f8e : 91 44 __ STA (T6 + 0),y 
0f90 : e6 50 __ INC T0 + 0 
0f92 : 4c 30 0d JMP $0d30 ; (sformat.l1 + 0)
.s100:
0f95 : ad fd 9f LDA $9ffd ; (sstack + 5)
0f98 : 85 57 __ STA T5 + 0 
0f9a : 18 __ __ CLC
0f9b : 69 02 __ ADC #$02
0f9d : 8d fd 9f STA $9ffd ; (sstack + 5)
0fa0 : ad fe 9f LDA $9ffe ; (sstack + 6)
0fa3 : 85 58 __ STA T5 + 1 
0fa5 : 69 00 __ ADC #$00
0fa7 : 8d fe 9f STA $9ffe ; (sstack + 6)
0faa : 18 __ __ CLC
0fab : a5 55 __ LDA T2 + 0 
0fad : 65 50 __ ADC T0 + 0 
0faf : 85 44 __ STA T6 + 0 
0fb1 : a5 56 __ LDA T2 + 1 
0fb3 : 69 00 __ ADC #$00
0fb5 : 85 45 __ STA T6 + 1 
0fb7 : a0 00 __ LDY #$00
0fb9 : b1 57 __ LDA (T5 + 0),y 
0fbb : 4c 8c 0f JMP $0f8c ; (sformat.s1059 + 0)
.s70:
0fbe : ad fd 9f LDA $9ffd ; (sstack + 5)
0fc1 : 85 57 __ STA T5 + 0 
0fc3 : 18 __ __ CLC
0fc4 : 69 02 __ ADC #$02
0fc6 : 8d fd 9f STA $9ffd ; (sstack + 5)
0fc9 : ad fe 9f LDA $9ffe ; (sstack + 6)
0fcc : 85 58 __ STA T5 + 1 
0fce : 69 00 __ ADC #$00
0fd0 : 8d fe 9f STA $9ffe ; (sstack + 6)
0fd3 : a0 00 __ LDY #$00
0fd5 : b1 57 __ LDA (T5 + 0),y 
0fd7 : aa __ __ TAX
0fd8 : c8 __ __ INY
0fd9 : b1 57 __ LDA (T5 + 0),y 
0fdb : 86 57 __ STX T5 + 0 
0fdd : 85 58 __ STA T5 + 1 
0fdf : a9 00 __ LDA #$00
0fe1 : 85 52 __ STA T3 + 0 
0fe3 : ad e1 9f LDA $9fe1 ; (si + 1)
0fe6 : f0 0c __ BEQ $0ff4 ; (sformat.s75 + 0)
.s1065:
0fe8 : 88 __ __ DEY
0fe9 : b1 57 __ LDA (T5 + 0),y 
0feb : f0 05 __ BEQ $0ff2 ; (sformat.s1066 + 0)
.l77:
0fed : c8 __ __ INY
0fee : b1 57 __ LDA (T5 + 0),y 
0ff0 : d0 fb __ BNE $0fed ; (sformat.l77 + 0)
.s1066:
0ff2 : 84 52 __ STY T3 + 0 
.s75:
0ff4 : ad e6 9f LDA $9fe6 ; (si + 6)
0ff7 : d0 19 __ BNE $1012 ; (sformat.s81 + 0)
.s1069:
0ff9 : a6 52 __ LDX T3 + 0 
0ffb : ec e1 9f CPX $9fe1 ; (si + 1)
0ffe : a4 50 __ LDY T0 + 0 
1000 : b0 0c __ BCS $100e ; (sformat.s1070 + 0)
.l83:
1002 : ad e0 9f LDA $9fe0 ; (si + 0)
1005 : 91 55 __ STA (T2 + 0),y 
1007 : e8 __ __ INX
1008 : ec e1 9f CPX $9fe1 ; (si + 1)
100b : c8 __ __ INY
100c : 90 f4 __ BCC $1002 ; (sformat.l83 + 0)
.s1070:
100e : 86 52 __ STX T3 + 0 
1010 : 84 50 __ STY T0 + 0 
.s81:
1012 : ad ff 9f LDA $9fff ; (sstack + 7)
1015 : d0 37 __ BNE $104e ; (sformat.s85 + 0)
.l91:
1017 : a0 00 __ LDY #$00
1019 : b1 57 __ LDA (T5 + 0),y 
101b : f0 0f __ BEQ $102c ; (sformat.s211 + 0)
.s92:
101d : a4 50 __ LDY T0 + 0 
101f : 91 55 __ STA (T2 + 0),y 
1021 : e6 50 __ INC T0 + 0 
1023 : e6 57 __ INC T5 + 0 
1025 : d0 f0 __ BNE $1017 ; (sformat.l91 + 0)
.s1079:
1027 : e6 58 __ INC T5 + 1 
1029 : 4c 17 10 JMP $1017 ; (sformat.l91 + 0)
.s211:
102c : ad e6 9f LDA $9fe6 ; (si + 6)
102f : d0 03 __ BNE $1034 ; (sformat.s1067 + 0)
1031 : 4c 30 0d JMP $0d30 ; (sformat.l1 + 0)
.s1067:
1034 : a6 52 __ LDX T3 + 0 
1036 : ec e1 9f CPX $9fe1 ; (si + 1)
1039 : a4 50 __ LDY T0 + 0 
103b : b0 0c __ BCS $1049 ; (sformat.s1068 + 0)
.l98:
103d : ad e0 9f LDA $9fe0 ; (si + 0)
1040 : 91 55 __ STA (T2 + 0),y 
1042 : e8 __ __ INX
1043 : ec e1 9f CPX $9fe1 ; (si + 1)
1046 : c8 __ __ INY
1047 : 90 f4 __ BCC $103d ; (sformat.l98 + 0)
.s1068:
1049 : 84 50 __ STY T0 + 0 
104b : 4c 30 0d JMP $0d30 ; (sformat.l1 + 0)
.s85:
104e : a5 50 __ LDA T0 + 0 
1050 : f0 22 __ BEQ $1074 ; (sformat.s90 + 0)
.s88:
1052 : a5 55 __ LDA T2 + 0 
1054 : 85 0d __ STA P0 
1056 : a5 56 __ LDA T2 + 1 
1058 : 85 0e __ STA P1 
105a : a9 00 __ LDA #$00
105c : a4 50 __ LDY T0 + 0 
105e : 91 0d __ STA (P0),y 
1060 : 20 52 11 JSR $1152 ; (puts.s0 + 0)
1063 : a5 57 __ LDA T5 + 0 
1065 : 85 0d __ STA P0 
1067 : a5 58 __ LDA T5 + 1 
1069 : 85 0e __ STA P1 
106b : 20 52 11 JSR $1152 ; (puts.s0 + 0)
106e : a9 00 __ LDA #$00
1070 : 85 50 __ STA T0 + 0 
1072 : f0 b8 __ BEQ $102c ; (sformat.s211 + 0)
.s90:
1074 : a5 57 __ LDA T5 + 0 
1076 : 85 0d __ STA P0 
1078 : a5 58 __ LDA T5 + 1 
107a : 85 0e __ STA P1 
107c : 20 52 11 JSR $1152 ; (puts.s0 + 0)
107f : 4c 2c 10 JMP $102c ; (sformat.s211 + 0)
.s53:
1082 : ad fd 9f LDA $9ffd ; (sstack + 5)
1085 : 85 57 __ STA T5 + 0 
1087 : 18 __ __ CLC
1088 : 69 04 __ ADC #$04
108a : 8d fd 9f STA $9ffd ; (sstack + 5)
108d : ad fe 9f LDA $9ffe ; (sstack + 6)
1090 : 85 58 __ STA T5 + 1 
1092 : 69 00 __ ADC #$00
1094 : 8d fe 9f STA $9ffe ; (sstack + 6)
1097 : a0 00 __ LDY #$00
1099 : b1 53 __ LDA (T1 + 0),y 
109b : 85 52 __ STA T3 + 0 
109d : e6 53 __ INC T1 + 0 
109f : d0 02 __ BNE $10a3 ; (sformat.s1078 + 0)
.s1077:
10a1 : e6 54 __ INC T1 + 1 
.s1078:
10a3 : c9 64 __ CMP #$64
10a5 : d0 04 __ BNE $10ab ; (sformat.s1019 + 0)
.s1018:
10a7 : a2 01 __ LDX #$01
10a9 : d0 02 __ BNE $10ad ; (sformat.s1020 + 0)
.s1019:
10ab : a2 00 __ LDX #$00
.s1020:
10ad : b1 57 __ LDA (T5 + 0),y 
10af : 85 46 __ STA T7 + 0 
10b1 : a0 01 __ LDY #$01
10b3 : b1 57 __ LDA (T5 + 0),y 
10b5 : 85 47 __ STA T7 + 1 
10b7 : c8 __ __ INY
10b8 : b1 57 __ LDA (T5 + 0),y 
10ba : 85 48 __ STA T7 + 2 
10bc : c8 __ __ INY
10bd : b1 57 __ LDA (T5 + 0),y 
10bf : a8 __ __ TAY
10c0 : 8a __ __ TXA
10c1 : f0 04 __ BEQ $10c7 ; (sformat.s57 + 0)
.s56:
10c3 : a9 01 __ LDA #$01
10c5 : d0 16 __ BNE $10dd ; (sformat.s222 + 0)
.s57:
10c7 : a5 52 __ LDA T3 + 0 
10c9 : c9 75 __ CMP #$75
10cb : f0 0f __ BEQ $10dc ; (sformat.s251 + 0)
.s60:
10cd : c9 78 __ CMP #$78
10cf : f0 03 __ BEQ $10d4 ; (sformat.s62 + 0)
10d1 : 4c 30 0d JMP $0d30 ; (sformat.l1 + 0)
.s62:
10d4 : 8e e4 9f STX $9fe4 ; (si + 4)
10d7 : a9 10 __ LDA #$10
10d9 : 8d e3 9f STA $9fe3 ; (si + 3)
.s251:
10dc : 8a __ __ TXA
.s222:
10dd : 84 14 __ STY P7 
10df : 85 15 __ STA P8 
10e1 : a5 55 __ LDA T2 + 0 
10e3 : 85 0f __ STA P2 
10e5 : a5 56 __ LDA T2 + 1 
10e7 : 85 10 __ STA P3 
10e9 : a5 46 __ LDA T7 + 0 
10eb : 85 11 __ STA P4 
10ed : a5 47 __ LDA T7 + 1 
10ef : 85 12 __ STA P5 
10f1 : a5 48 __ LDA T7 + 2 
10f3 : 85 13 __ STA P6 
10f5 : a9 e0 __ LDA #$e0
10f7 : 85 0d __ STA P0 
10f9 : a9 9f __ LDA #$9f
10fb : 85 0e __ STA P1 
10fd : 20 06 13 JSR $1306 ; (nforml.s0 + 0)
.s1062:
1100 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
1102 : 85 50 __ STA T0 + 0 
1104 : 4c 30 0d JMP $0d30 ; (sformat.l1 + 0)
.s250:
1107 : a9 00 __ LDA #$00
.s221:
1109 : 85 13 __ STA P6 
110b : a5 55 __ LDA T2 + 0 
110d : 85 0f __ STA P2 
110f : a5 56 __ LDA T2 + 1 
1111 : 85 10 __ STA P3 
1113 : ad fd 9f LDA $9ffd ; (sstack + 5)
1116 : 85 50 __ STA T0 + 0 
1118 : ad fe 9f LDA $9ffe ; (sstack + 6)
111b : 85 51 __ STA T0 + 1 
111d : a0 00 __ LDY #$00
111f : b1 50 __ LDA (T0 + 0),y 
1121 : 85 11 __ STA P4 
1123 : c8 __ __ INY
1124 : b1 50 __ LDA (T0 + 0),y 
1126 : 85 12 __ STA P5 
1128 : 18 __ __ CLC
1129 : a5 50 __ LDA T0 + 0 
112b : 69 02 __ ADC #$02
112d : 8d fd 9f STA $9ffd ; (sstack + 5)
1130 : a5 51 __ LDA T0 + 1 
1132 : 69 00 __ ADC #$00
1134 : 8d fe 9f STA $9ffe ; (sstack + 6)
1137 : a9 e0 __ LDA #$e0
1139 : 85 0d __ STA P0 
113b : a9 9f __ LDA #$9f
113d : 85 0e __ STA P1 
113f : 20 a7 11 JSR $11a7 ; (nformi.s0 + 0)
1142 : 4c 00 11 JMP $1100 ; (sformat.s1062 + 0)
.s224:
1145 : a0 00 __ LDY #$00
1147 : b1 53 __ LDA (T1 + 0),y 
1149 : aa __ __ TAX
114a : 18 __ __ CLC
114b : a5 53 __ LDA T1 + 0 
114d : 69 01 __ ADC #$01
114f : 4c 08 0e JMP $0e08 ; (sformat.l14 + 0)
--------------------------------------------------------------------
puts:
.s0:
1152 : a0 00 __ LDY #$00
1154 : b1 0d __ LDA (P0),y 
1156 : f0 0b __ BEQ $1163 ; (puts.s1001 + 0)
1158 : 20 64 11 JSR $1164 ; (putpch + 0)
115b : e6 0d __ INC P0 
115d : d0 f3 __ BNE $1152 ; (puts.s0 + 0)
115f : e6 0e __ INC P1 
1161 : d0 ef __ BNE $1152 ; (puts.s0 + 0)
.s1001:
1163 : 60 __ __ RTS
--------------------------------------------------------------------
putpch:
1164 : ae ff 25 LDX $25ff ; (giocharmap + 0)
1167 : e0 01 __ CPX #$01
1169 : 90 26 __ BCC $1191 ; (putpch + 45)
116b : c9 0a __ CMP #$0a
116d : d0 02 __ BNE $1171 ; (putpch + 13)
116f : a9 0d __ LDA #$0d
1171 : c9 09 __ CMP #$09
1173 : f0 1f __ BEQ $1194 ; (putpch + 48)
1175 : e0 02 __ CPX #$02
1177 : 90 18 __ BCC $1191 ; (putpch + 45)
1179 : c9 41 __ CMP #$41
117b : 90 14 __ BCC $1191 ; (putpch + 45)
117d : c9 7b __ CMP #$7b
117f : b0 10 __ BCS $1191 ; (putpch + 45)
1181 : c9 61 __ CMP #$61
1183 : b0 04 __ BCS $1189 ; (putpch + 37)
1185 : c9 5b __ CMP #$5b
1187 : b0 08 __ BCS $1191 ; (putpch + 45)
1189 : 49 20 __ EOR #$20
118b : e0 03 __ CPX #$03
118d : f0 02 __ BEQ $1191 ; (putpch + 45)
118f : 29 df __ AND #$df
1191 : 4c d2 ff JMP $ffd2 
1194 : 38 __ __ SEC
1195 : 20 f0 ff JSR $fff0 
1198 : 98 __ __ TYA
1199 : 29 03 __ AND #$03
119b : 49 03 __ EOR #$03
119d : aa __ __ TAX
119e : a9 20 __ LDA #$20
11a0 : 20 d2 ff JSR $ffd2 
11a3 : ca __ __ DEX
11a4 : 10 fa __ BPL $11a0 ; (putpch + 60)
11a6 : 60 __ __ RTS
--------------------------------------------------------------------
giocharmap:
25ff : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
nformi:
.s0:
11a7 : a9 00 __ LDA #$00
11a9 : 85 43 __ STA T0 + 0 
11ab : a5 13 __ LDA P6 ; (s + 0)
11ad : f0 15 __ BEQ $11c4 ; (nformi.s159 + 0)
.s4:
11af : a5 12 __ LDA P5 ; (v + 1)
11b1 : 10 11 __ BPL $11c4 ; (nformi.s159 + 0)
.s1:
11b3 : 38 __ __ SEC
11b4 : a9 00 __ LDA #$00
11b6 : e5 11 __ SBC P4 ; (v + 0)
11b8 : 85 11 __ STA P4 ; (v + 0)
11ba : a9 00 __ LDA #$00
11bc : e5 12 __ SBC P5 ; (v + 1)
11be : 85 12 __ STA P5 ; (v + 1)
11c0 : a9 01 __ LDA #$01
11c2 : 85 43 __ STA T0 + 0 
.s159:
11c4 : a9 10 __ LDA #$10
11c6 : 85 44 __ STA T2 + 0 
11c8 : a5 11 __ LDA P4 ; (v + 0)
11ca : 05 12 __ ORA P5 ; (v + 1)
11cc : f0 61 __ BEQ $122f ; (nformi.s7 + 0)
.s45:
11ce : a5 0d __ LDA P0 ; (si + 0)
11d0 : 85 45 __ STA T4 + 0 
11d2 : a5 0e __ LDA P1 ; (si + 1)
11d4 : 85 46 __ STA T4 + 1 
.l6:
11d6 : a0 03 __ LDY #$03
11d8 : b1 45 __ LDA (T4 + 0),y 
11da : 85 47 __ STA T5 + 0 
11dc : 85 03 __ STA WORK + 0 
11de : c8 __ __ INY
11df : b1 45 __ LDA (T4 + 0),y 
11e1 : 85 48 __ STA T5 + 1 
11e3 : 85 04 __ STA WORK + 1 
11e5 : a5 11 __ LDA P4 ; (v + 0)
11e7 : 85 1b __ STA ACCU + 0 
11e9 : a5 12 __ LDA P5 ; (v + 1)
11eb : 85 1c __ STA ACCU + 1 
11ed : 20 23 24 JSR $2423 ; (divmod + 0)
11f0 : a5 06 __ LDA WORK + 3 
11f2 : 30 10 __ BMI $1204 ; (nformi.s9 + 0)
.s1019:
11f4 : d0 06 __ BNE $11fc ; (nformi.s8 + 0)
.s1018:
11f6 : a5 05 __ LDA WORK + 2 
11f8 : c9 0a __ CMP #$0a
11fa : 90 08 __ BCC $1204 ; (nformi.s9 + 0)
.s8:
11fc : 18 __ __ CLC
11fd : a5 05 __ LDA WORK + 2 
11ff : 69 37 __ ADC #$37
1201 : 4c 09 12 JMP $1209 ; (nformi.s10 + 0)
.s9:
1204 : 18 __ __ CLC
1205 : a5 05 __ LDA WORK + 2 
1207 : 69 30 __ ADC #$30
.s10:
1209 : c6 44 __ DEC T2 + 0 
120b : a6 44 __ LDX T2 + 0 
120d : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1210 : a5 11 __ LDA P4 ; (v + 0)
1212 : 85 1b __ STA ACCU + 0 
1214 : a5 12 __ LDA P5 ; (v + 1)
1216 : 85 1c __ STA ACCU + 1 
1218 : a5 47 __ LDA T5 + 0 
121a : 85 03 __ STA WORK + 0 
121c : a5 48 __ LDA T5 + 1 
121e : 85 04 __ STA WORK + 1 
1220 : 20 23 24 JSR $2423 ; (divmod + 0)
1223 : a5 1b __ LDA ACCU + 0 
1225 : 85 11 __ STA P4 ; (v + 0)
1227 : a5 1c __ LDA ACCU + 1 
1229 : 85 12 __ STA P5 ; (v + 1)
122b : 05 11 __ ORA P4 ; (v + 0)
122d : d0 a7 __ BNE $11d6 ; (nformi.l6 + 0)
.s7:
122f : a5 0d __ LDA P0 ; (si + 0)
1231 : 85 11 __ STA P4 ; (v + 0)
1233 : a5 0e __ LDA P1 ; (si + 1)
1235 : 85 12 __ STA P5 ; (v + 1)
1237 : a0 02 __ LDY #$02
1239 : b1 0d __ LDA (P0),y ; (si + 0)
123b : c9 ff __ CMP #$ff
123d : d0 04 __ BNE $1243 ; (nformi.s76 + 0)
.s77:
123f : a9 0f __ LDA #$0f
1241 : d0 05 __ BNE $1248 ; (nformi.s1026 + 0)
.s76:
1243 : 38 __ __ SEC
1244 : a9 10 __ LDA #$10
1246 : f1 0d __ SBC (P0),y ; (si + 0)
.s1026:
1248 : a8 __ __ TAY
1249 : c4 44 __ CPY T2 + 0 
124b : b0 0d __ BCS $125a ; (nformi.s13 + 0)
.s12:
124d : a9 30 __ LDA #$30
.l1027:
124f : c6 44 __ DEC T2 + 0 
1251 : a6 44 __ LDX T2 + 0 
1253 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1256 : c4 44 __ CPY T2 + 0 
1258 : 90 f5 __ BCC $124f ; (nformi.l1027 + 0)
.s13:
125a : a0 07 __ LDY #$07
125c : b1 0d __ LDA (P0),y ; (si + 0)
125e : f0 20 __ BEQ $1280 ; (nformi.s16 + 0)
.s17:
1260 : a0 04 __ LDY #$04
1262 : b1 0d __ LDA (P0),y ; (si + 0)
1264 : d0 1a __ BNE $1280 ; (nformi.s16 + 0)
.s1013:
1266 : 88 __ __ DEY
1267 : b1 0d __ LDA (P0),y ; (si + 0)
1269 : c9 10 __ CMP #$10
126b : d0 13 __ BNE $1280 ; (nformi.s16 + 0)
.s14:
126d : a9 58 __ LDA #$58
126f : a6 44 __ LDX T2 + 0 
1271 : 9d e7 9f STA $9fe7,x ; (si + 7)
1274 : 8a __ __ TXA
1275 : 18 __ __ CLC
1276 : 69 fe __ ADC #$fe
1278 : 85 44 __ STA T2 + 0 
127a : aa __ __ TAX
127b : a9 30 __ LDA #$30
127d : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s16:
1280 : a9 00 __ LDA #$00
1282 : 85 1b __ STA ACCU + 0 
1284 : a5 43 __ LDA T0 + 0 
1286 : f0 06 __ BEQ $128e ; (nformi.s19 + 0)
.s18:
1288 : c6 44 __ DEC T2 + 0 
128a : a9 2d __ LDA #$2d
128c : d0 0a __ BNE $1298 ; (nformi.s1025 + 0)
.s19:
128e : a0 05 __ LDY #$05
1290 : b1 0d __ LDA (P0),y ; (si + 0)
1292 : f0 09 __ BEQ $129d ; (nformi.s141 + 0)
.s21:
1294 : c6 44 __ DEC T2 + 0 
1296 : a9 2b __ LDA #$2b
.s1025:
1298 : a6 44 __ LDX T2 + 0 
129a : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s141:
129d : a0 06 __ LDY #$06
129f : b1 0d __ LDA (P0),y ; (si + 0)
12a1 : d0 37 __ BNE $12da ; (nformi.s27 + 0)
.l33:
12a3 : a0 01 __ LDY #$01
12a5 : b1 11 __ LDA (P4),y ; (v + 0)
12a7 : 18 __ __ CLC
12a8 : 65 44 __ ADC T2 + 0 
12aa : b0 04 __ BCS $12b0 ; (nformi.s34 + 0)
.s1006:
12ac : c9 11 __ CMP #$11
12ae : 90 0e __ BCC $12be ; (nformi.s36 + 0)
.s34:
12b0 : c6 44 __ DEC T2 + 0 
12b2 : a0 00 __ LDY #$00
12b4 : b1 11 __ LDA (P4),y ; (v + 0)
12b6 : a6 44 __ LDX T2 + 0 
12b8 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
12bb : 4c a3 12 JMP $12a3 ; (nformi.l33 + 0)
.s36:
12be : a6 44 __ LDX T2 + 0 
12c0 : e0 10 __ CPX #$10
12c2 : b0 11 __ BCS $12d5 ; (nformi.s26 + 0)
.s1022:
12c4 : 88 __ __ DEY
.l1031:
12c5 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
12c8 : 91 0f __ STA (P2),y ; (str + 0)
12ca : e6 44 __ INC T2 + 0 
12cc : a6 44 __ LDX T2 + 0 
12ce : e0 10 __ CPX #$10
12d0 : c8 __ __ INY
12d1 : 90 f2 __ BCC $12c5 ; (nformi.l1031 + 0)
.s1032:
12d3 : 84 1b __ STY ACCU + 0 
.s26:
12d5 : a9 00 __ LDA #$00
12d7 : 85 1c __ STA ACCU + 1 
.s1001:
12d9 : 60 __ __ RTS
.s27:
12da : a6 44 __ LDX T2 + 0 
12dc : e0 10 __ CPX #$10
12de : b0 12 __ BCS $12f2 ; (nformi.l30 + 0)
.s1020:
12e0 : a0 00 __ LDY #$00
.l1029:
12e2 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
12e5 : 91 0f __ STA (P2),y ; (str + 0)
12e7 : e6 44 __ INC T2 + 0 
12e9 : a6 44 __ LDX T2 + 0 
12eb : e0 10 __ CPX #$10
12ed : c8 __ __ INY
12ee : 90 f2 __ BCC $12e2 ; (nformi.l1029 + 0)
.s1030:
12f0 : 84 1b __ STY ACCU + 0 
.l30:
12f2 : a5 1b __ LDA ACCU + 0 
12f4 : a0 01 __ LDY #$01
12f6 : d1 11 __ CMP (P4),y ; (v + 0)
12f8 : b0 db __ BCS $12d5 ; (nformi.s26 + 0)
.s31:
12fa : 88 __ __ DEY
12fb : b1 11 __ LDA (P4),y ; (v + 0)
12fd : a4 1b __ LDY ACCU + 0 
12ff : 91 0f __ STA (P2),y ; (str + 0)
1301 : e6 1b __ INC ACCU + 0 
1303 : 4c f2 12 JMP $12f2 ; (nformi.l30 + 0)
--------------------------------------------------------------------
nforml:
.s0:
1306 : a9 00 __ LDA #$00
1308 : 85 43 __ STA T0 + 0 
130a : a5 15 __ LDA P8 ; (s + 0)
130c : f0 23 __ BEQ $1331 ; (nforml.s159 + 0)
.s4:
130e : a5 14 __ LDA P7 ; (v + 3)
1310 : f0 1f __ BEQ $1331 ; (nforml.s159 + 0)
.s1032:
1312 : 10 1d __ BPL $1331 ; (nforml.s159 + 0)
.s1:
1314 : 38 __ __ SEC
1315 : a9 00 __ LDA #$00
1317 : e5 11 __ SBC P4 ; (v + 0)
1319 : 85 11 __ STA P4 ; (v + 0)
131b : a9 00 __ LDA #$00
131d : e5 12 __ SBC P5 ; (v + 1)
131f : 85 12 __ STA P5 ; (v + 1)
1321 : a9 00 __ LDA #$00
1323 : e5 13 __ SBC P6 ; (v + 2)
1325 : 85 13 __ STA P6 ; (v + 2)
1327 : a9 00 __ LDA #$00
1329 : e5 14 __ SBC P7 ; (v + 3)
132b : 85 14 __ STA P7 ; (v + 3)
132d : a9 01 __ LDA #$01
132f : 85 43 __ STA T0 + 0 
.s159:
1331 : a9 10 __ LDA #$10
1333 : 85 44 __ STA T2 + 0 
1335 : a5 14 __ LDA P7 ; (v + 3)
1337 : f0 03 __ BEQ $133c ; (nforml.s1018 + 0)
1339 : 4c 20 14 JMP $1420 ; (nforml.l6 + 0)
.s1018:
133c : a5 13 __ LDA P6 ; (v + 2)
133e : f0 03 __ BEQ $1343 ; (nforml.s1019 + 0)
1340 : 4c 20 14 JMP $1420 ; (nforml.l6 + 0)
.s1019:
1343 : a5 12 __ LDA P5 ; (v + 1)
1345 : f0 03 __ BEQ $134a ; (nforml.s1020 + 0)
1347 : 4c 20 14 JMP $1420 ; (nforml.l6 + 0)
.s1020:
134a : c5 11 __ CMP P4 ; (v + 0)
134c : b0 03 __ BCS $1351 ; (nforml.s7 + 0)
134e : 4c 20 14 JMP $1420 ; (nforml.l6 + 0)
.s7:
1351 : a0 02 __ LDY #$02
1353 : b1 0d __ LDA (P0),y ; (si + 0)
1355 : c9 ff __ CMP #$ff
1357 : d0 04 __ BNE $135d ; (nforml.s76 + 0)
.s77:
1359 : a9 0f __ LDA #$0f
135b : d0 05 __ BNE $1362 ; (nforml.s1039 + 0)
.s76:
135d : 38 __ __ SEC
135e : a9 10 __ LDA #$10
1360 : f1 0d __ SBC (P0),y ; (si + 0)
.s1039:
1362 : a8 __ __ TAY
1363 : c4 44 __ CPY T2 + 0 
1365 : b0 0d __ BCS $1374 ; (nforml.s13 + 0)
.s12:
1367 : a9 30 __ LDA #$30
.l1040:
1369 : c6 44 __ DEC T2 + 0 
136b : a6 44 __ LDX T2 + 0 
136d : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1370 : c4 44 __ CPY T2 + 0 
1372 : 90 f5 __ BCC $1369 ; (nforml.l1040 + 0)
.s13:
1374 : a0 07 __ LDY #$07
1376 : b1 0d __ LDA (P0),y ; (si + 0)
1378 : f0 20 __ BEQ $139a ; (nforml.s16 + 0)
.s17:
137a : a0 04 __ LDY #$04
137c : b1 0d __ LDA (P0),y ; (si + 0)
137e : d0 1a __ BNE $139a ; (nforml.s16 + 0)
.s1013:
1380 : 88 __ __ DEY
1381 : b1 0d __ LDA (P0),y ; (si + 0)
1383 : c9 10 __ CMP #$10
1385 : d0 13 __ BNE $139a ; (nforml.s16 + 0)
.s14:
1387 : a9 58 __ LDA #$58
1389 : a6 44 __ LDX T2 + 0 
138b : 9d e7 9f STA $9fe7,x ; (si + 7)
138e : 8a __ __ TXA
138f : 18 __ __ CLC
1390 : 69 fe __ ADC #$fe
1392 : 85 44 __ STA T2 + 0 
1394 : aa __ __ TAX
1395 : a9 30 __ LDA #$30
1397 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s16:
139a : a9 00 __ LDA #$00
139c : 85 1b __ STA ACCU + 0 
139e : a5 43 __ LDA T0 + 0 
13a0 : f0 06 __ BEQ $13a8 ; (nforml.s19 + 0)
.s18:
13a2 : c6 44 __ DEC T2 + 0 
13a4 : a9 2d __ LDA #$2d
13a6 : d0 0a __ BNE $13b2 ; (nforml.s1038 + 0)
.s19:
13a8 : a0 05 __ LDY #$05
13aa : b1 0d __ LDA (P0),y ; (si + 0)
13ac : f0 09 __ BEQ $13b7 ; (nforml.s141 + 0)
.s21:
13ae : c6 44 __ DEC T2 + 0 
13b0 : a9 2b __ LDA #$2b
.s1038:
13b2 : a6 44 __ LDX T2 + 0 
13b4 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s141:
13b7 : a0 06 __ LDY #$06
13b9 : b1 0d __ LDA (P0),y ; (si + 0)
13bb : d0 37 __ BNE $13f4 ; (nforml.s27 + 0)
.l33:
13bd : a0 01 __ LDY #$01
13bf : b1 0d __ LDA (P0),y ; (si + 0)
13c1 : 18 __ __ CLC
13c2 : 65 44 __ ADC T2 + 0 
13c4 : b0 04 __ BCS $13ca ; (nforml.s34 + 0)
.s1006:
13c6 : c9 11 __ CMP #$11
13c8 : 90 0e __ BCC $13d8 ; (nforml.s36 + 0)
.s34:
13ca : c6 44 __ DEC T2 + 0 
13cc : a0 00 __ LDY #$00
13ce : b1 0d __ LDA (P0),y ; (si + 0)
13d0 : a6 44 __ LDX T2 + 0 
13d2 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
13d5 : 4c bd 13 JMP $13bd ; (nforml.l33 + 0)
.s36:
13d8 : a6 44 __ LDX T2 + 0 
13da : e0 10 __ CPX #$10
13dc : b0 11 __ BCS $13ef ; (nforml.s26 + 0)
.s1035:
13de : 88 __ __ DEY
.l1044:
13df : bd e8 9f LDA $9fe8,x ; (buffer + 0)
13e2 : 91 0f __ STA (P2),y ; (str + 0)
13e4 : e6 44 __ INC T2 + 0 
13e6 : a6 44 __ LDX T2 + 0 
13e8 : e0 10 __ CPX #$10
13ea : c8 __ __ INY
13eb : 90 f2 __ BCC $13df ; (nforml.l1044 + 0)
.s1045:
13ed : 84 1b __ STY ACCU + 0 
.s26:
13ef : a9 00 __ LDA #$00
13f1 : 85 1c __ STA ACCU + 1 
.s1001:
13f3 : 60 __ __ RTS
.s27:
13f4 : a6 44 __ LDX T2 + 0 
13f6 : e0 10 __ CPX #$10
13f8 : b0 12 __ BCS $140c ; (nforml.l30 + 0)
.s1033:
13fa : a0 00 __ LDY #$00
.l1042:
13fc : bd e8 9f LDA $9fe8,x ; (buffer + 0)
13ff : 91 0f __ STA (P2),y ; (str + 0)
1401 : e6 44 __ INC T2 + 0 
1403 : a6 44 __ LDX T2 + 0 
1405 : e0 10 __ CPX #$10
1407 : c8 __ __ INY
1408 : 90 f2 __ BCC $13fc ; (nforml.l1042 + 0)
.s1043:
140a : 84 1b __ STY ACCU + 0 
.l30:
140c : a5 1b __ LDA ACCU + 0 
140e : a0 01 __ LDY #$01
1410 : d1 0d __ CMP (P0),y ; (si + 0)
1412 : b0 db __ BCS $13ef ; (nforml.s26 + 0)
.s31:
1414 : 88 __ __ DEY
1415 : b1 0d __ LDA (P0),y ; (si + 0)
1417 : a4 1b __ LDY ACCU + 0 
1419 : 91 0f __ STA (P2),y ; (str + 0)
141b : e6 1b __ INC ACCU + 0 
141d : 4c 0c 14 JMP $140c ; (nforml.l30 + 0)
.l6:
1420 : a0 03 __ LDY #$03
1422 : b1 0d __ LDA (P0),y ; (si + 0)
1424 : 85 03 __ STA WORK + 0 
1426 : 85 45 __ STA T6 + 0 
1428 : c8 __ __ INY
1429 : b1 0d __ LDA (P0),y ; (si + 0)
142b : 85 46 __ STA T6 + 1 
142d : 85 04 __ STA WORK + 1 
142f : a5 11 __ LDA P4 ; (v + 0)
1431 : 85 1b __ STA ACCU + 0 
1433 : a5 12 __ LDA P5 ; (v + 1)
1435 : 85 1c __ STA ACCU + 1 
1437 : a5 13 __ LDA P6 ; (v + 2)
1439 : 85 1d __ STA ACCU + 2 
143b : a5 14 __ LDA P7 ; (v + 3)
143d : 85 1e __ STA ACCU + 3 
143f : a9 00 __ LDA #$00
1441 : 85 05 __ STA WORK + 2 
1443 : 85 06 __ STA WORK + 3 
1445 : 20 5e 25 JSR $255e ; (divmod32 + 0)
1448 : a5 08 __ LDA WORK + 5 
144a : 30 10 __ BMI $145c ; (nforml.s9 + 0)
.s1023:
144c : d0 06 __ BNE $1454 ; (nforml.s8 + 0)
.s1022:
144e : a5 07 __ LDA WORK + 4 
1450 : c9 0a __ CMP #$0a
1452 : 90 08 __ BCC $145c ; (nforml.s9 + 0)
.s8:
1454 : 18 __ __ CLC
1455 : a5 07 __ LDA WORK + 4 
1457 : 69 37 __ ADC #$37
1459 : 4c 61 14 JMP $1461 ; (nforml.s10 + 0)
.s9:
145c : 18 __ __ CLC
145d : a5 07 __ LDA WORK + 4 
145f : 69 30 __ ADC #$30
.s10:
1461 : c6 44 __ DEC T2 + 0 
1463 : a6 44 __ LDX T2 + 0 
1465 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1468 : a5 11 __ LDA P4 ; (v + 0)
146a : 85 1b __ STA ACCU + 0 
146c : a5 12 __ LDA P5 ; (v + 1)
146e : 85 1c __ STA ACCU + 1 
1470 : a5 13 __ LDA P6 ; (v + 2)
1472 : 85 1d __ STA ACCU + 2 
1474 : a5 14 __ LDA P7 ; (v + 3)
1476 : 85 1e __ STA ACCU + 3 
1478 : a5 45 __ LDA T6 + 0 
147a : 85 03 __ STA WORK + 0 
147c : a5 46 __ LDA T6 + 1 
147e : 85 04 __ STA WORK + 1 
1480 : a9 00 __ LDA #$00
1482 : 85 05 __ STA WORK + 2 
1484 : 85 06 __ STA WORK + 3 
1486 : 20 5e 25 JSR $255e ; (divmod32 + 0)
1489 : a5 1b __ LDA ACCU + 0 
148b : 85 11 __ STA P4 ; (v + 0)
148d : a5 1c __ LDA ACCU + 1 
148f : 85 12 __ STA P5 ; (v + 1)
1491 : a5 1d __ LDA ACCU + 2 
1493 : 85 13 __ STA P6 ; (v + 2)
1495 : a5 1e __ LDA ACCU + 3 
1497 : 85 14 __ STA P7 ; (v + 3)
1499 : d0 85 __ BNE $1420 ; (nforml.l6 + 0)
149b : 4c 3c 13 JMP $133c ; (nforml.s1018 + 0)
--------------------------------------------------------------------
nformf:
.s0:
149e : a5 15 __ LDA P8 ; (f + 0)
14a0 : 85 43 __ STA T1 + 0 
14a2 : a5 16 __ LDA P9 ; (f + 1)
14a4 : 85 44 __ STA T1 + 1 
14a6 : a5 17 __ LDA P10 ; (f + 2)
14a8 : 85 45 __ STA T1 + 2 
14aa : a5 18 __ LDA P11 ; (f + 3)
14ac : 29 7f __ AND #$7f
14ae : 05 17 __ ORA P10 ; (f + 2)
14b0 : 05 16 __ ORA P9 ; (f + 1)
14b2 : 05 15 __ ORA P8 ; (f + 0)
14b4 : f0 21 __ BEQ $14d7 ; (nformf.s2 + 0)
.s1005:
14b6 : a5 18 __ LDA P11 ; (f + 3)
14b8 : 10 1d __ BPL $14d7 ; (nformf.s2 + 0)
.s1:
14ba : a9 2d __ LDA #$2d
14bc : a0 00 __ LDY #$00
14be : 91 13 __ STA (P6),y ; (str + 0)
14c0 : a5 18 __ LDA P11 ; (f + 3)
14c2 : 49 80 __ EOR #$80
14c4 : 85 18 __ STA P11 ; (f + 3)
14c6 : 85 10 __ STA P3 
14c8 : a5 15 __ LDA P8 ; (f + 0)
14ca : 85 0d __ STA P0 
14cc : a5 16 __ LDA P9 ; (f + 1)
14ce : 85 0e __ STA P1 
14d0 : a5 17 __ LDA P10 ; (f + 2)
14d2 : 85 0f __ STA P2 
14d4 : 4c 57 19 JMP $1957 ; (nformf.s189 + 0)
.s2:
14d7 : a5 15 __ LDA P8 ; (f + 0)
14d9 : 85 0d __ STA P0 
14db : a5 16 __ LDA P9 ; (f + 1)
14dd : 85 0e __ STA P1 
14df : a5 17 __ LDA P10 ; (f + 2)
14e1 : 85 0f __ STA P2 
14e3 : a5 18 __ LDA P11 ; (f + 3)
14e5 : 85 10 __ STA P3 
14e7 : a0 05 __ LDY #$05
14e9 : b1 11 __ LDA (P4),y ; (si + 0)
14eb : f0 09 __ BEQ $14f6 ; (nformf.s3 + 0)
.s4:
14ed : a9 2b __ LDA #$2b
14ef : a0 00 __ LDY #$00
14f1 : 91 13 __ STA (P6),y ; (str + 0)
14f3 : 4c 57 19 JMP $1957 ; (nformf.s189 + 0)
.s3:
14f6 : 20 6f 19 JSR $196f ; (isinf.s0 + 0)
14f9 : aa __ __ TAX
14fa : a9 00 __ LDA #$00
14fc : 85 48 __ STA T3 + 0 
14fe : 8a __ __ TXA
14ff : f0 0b __ BEQ $150c ; (nformf.s8 + 0)
.s160:
1501 : a9 01 __ LDA #$01
1503 : 85 4a __ STA T5 + 0 
1505 : a9 02 __ LDA #$02
1507 : a0 00 __ LDY #$00
1509 : 4c 3b 19 JMP $193b ; (nformf.s7 + 0)
.s8:
150c : a0 02 __ LDY #$02
150e : b1 11 __ LDA (P4),y ; (si + 0)
1510 : c9 ff __ CMP #$ff
1512 : d0 02 __ BNE $1516 ; (nformf.s128 + 0)
.s129:
1514 : a9 06 __ LDA #$06
.s128:
1516 : 86 4a __ STX T5 + 0 
1518 : 86 4b __ STX T5 + 1 
151a : 85 49 __ STA T4 + 0 
151c : 85 47 __ STA T2 + 0 
151e : a5 18 __ LDA P11 ; (f + 3)
1520 : 85 46 __ STA T1 + 3 
1522 : 29 7f __ AND #$7f
1524 : 05 17 __ ORA P10 ; (f + 2)
1526 : 05 16 __ ORA P9 ; (f + 1)
1528 : 05 15 __ ORA P8 ; (f + 0)
152a : f0 03 __ BEQ $152f ; (nformf.s12 + 0)
152c : 4c 3c 18 JMP $183c ; (nformf.s13 + 0)
.s12:
152f : ad f8 9f LDA $9ff8 ; (sstack + 0)
1532 : c9 65 __ CMP #$65
1534 : d0 04 __ BNE $153a ; (nformf.s1007 + 0)
.s1006:
1536 : a9 01 __ LDA #$01
1538 : d0 02 __ BNE $153c ; (nformf.s1008 + 0)
.s1007:
153a : a9 00 __ LDA #$00
.s1008:
153c : 85 4e __ STA T9 + 0 
153e : a6 49 __ LDX T4 + 0 
1540 : e8 __ __ INX
1541 : 86 4c __ STX T8 + 0 
1543 : ad f8 9f LDA $9ff8 ; (sstack + 0)
1546 : c9 67 __ CMP #$67
1548 : d0 13 __ BNE $155d ; (nformf.s24 + 0)
.s22:
154a : a5 4b __ LDA T5 + 1 
154c : 30 08 __ BMI $1556 ; (nformf.s25 + 0)
.s1050:
154e : d0 06 __ BNE $1556 ; (nformf.s25 + 0)
.s1049:
1550 : a5 4a __ LDA T5 + 0 
1552 : c9 04 __ CMP #$04
1554 : 90 07 __ BCC $155d ; (nformf.s24 + 0)
.s25:
1556 : a9 01 __ LDA #$01
1558 : 85 4e __ STA T9 + 0 
155a : 4c b4 17 JMP $17b4 ; (nformf.s30 + 0)
.s24:
155d : a5 4e __ LDA T9 + 0 
155f : f0 03 __ BEQ $1564 ; (nformf.s32 + 0)
1561 : 4c b4 17 JMP $17b4 ; (nformf.s30 + 0)
.s32:
1564 : a5 4b __ LDA T5 + 1 
1566 : 10 3e __ BPL $15a6 ; (nformf.s34 + 0)
.s33:
1568 : a5 43 __ LDA T1 + 0 
156a : 85 1b __ STA ACCU + 0 
156c : a5 44 __ LDA T1 + 1 
156e : 85 1c __ STA ACCU + 1 
1570 : a5 45 __ LDA T1 + 2 
1572 : 85 1d __ STA ACCU + 2 
1574 : a5 46 __ LDA T1 + 3 
1576 : 85 1e __ STA ACCU + 3 
.l1085:
1578 : e6 4a __ INC T5 + 0 
157a : d0 02 __ BNE $157e ; (nformf.s1095 + 0)
.s1094:
157c : e6 4b __ INC T5 + 1 
.s1095:
157e : a9 00 __ LDA #$00
1580 : 85 03 __ STA WORK + 0 
1582 : 85 04 __ STA WORK + 1 
1584 : a9 20 __ LDA #$20
1586 : 85 05 __ STA WORK + 2 
1588 : a9 41 __ LDA #$41
158a : 85 06 __ STA WORK + 3 
158c : 20 54 21 JSR $2154 ; (freg + 20)
158f : 20 3b 23 JSR $233b ; (fdiv + 0)
1592 : a5 4b __ LDA T5 + 1 
1594 : 30 e2 __ BMI $1578 ; (nformf.l1085 + 0)
.s1086:
1596 : a5 1e __ LDA ACCU + 3 
1598 : 85 46 __ STA T1 + 3 
159a : a5 1d __ LDA ACCU + 2 
159c : 85 45 __ STA T1 + 2 
159e : a5 1c __ LDA ACCU + 1 
15a0 : 85 44 __ STA T1 + 1 
15a2 : a5 1b __ LDA ACCU + 0 
15a4 : 85 43 __ STA T1 + 0 
.s34:
15a6 : 18 __ __ CLC
15a7 : a5 49 __ LDA T4 + 0 
15a9 : 65 4a __ ADC T5 + 0 
15ab : 18 __ __ CLC
15ac : 69 01 __ ADC #$01
15ae : 85 4c __ STA T8 + 0 
15b0 : c9 07 __ CMP #$07
15b2 : 90 13 __ BCC $15c7 ; (nformf.s35 + 0)
.s36:
15b4 : ad 9b 26 LDA $269b ; (fround5 + 25)
15b7 : 85 1c __ STA ACCU + 1 
15b9 : ad 9c 26 LDA $269c ; (fround5 + 26)
15bc : 85 1d __ STA ACCU + 2 
15be : ad 9d 26 LDA $269d ; (fround5 + 27)
15c1 : ae 9a 26 LDX $269a ; (fround5 + 24)
15c4 : 4c da 15 JMP $15da ; (nformf.s214 + 0)
.s35:
15c7 : 0a __ __ ASL
15c8 : 0a __ __ ASL
15c9 : a8 __ __ TAY
15ca : b9 7f 26 LDA $267f,y ; (p2smap + 5)
15cd : 85 1c __ STA ACCU + 1 
15cf : b9 80 26 LDA $2680,y ; (p2smap + 6)
15d2 : 85 1d __ STA ACCU + 2 
15d4 : b9 81 26 LDA $2681,y ; (p2smap + 7)
15d7 : be 7e 26 LDX $267e,y ; (p2smap + 4)
.s214:
15da : 86 1b __ STX ACCU + 0 
15dc : 85 1e __ STA ACCU + 3 
15de : a2 43 __ LDX #$43
15e0 : 20 44 21 JSR $2144 ; (freg + 4)
15e3 : 20 85 21 JSR $2185 ; (faddsub + 0)
15e6 : a5 1c __ LDA ACCU + 1 
15e8 : 85 16 __ STA P9 ; (f + 1)
15ea : a5 1d __ LDA ACCU + 2 
15ec : 85 17 __ STA P10 ; (f + 2)
15ee : a6 1b __ LDX ACCU + 0 
15f0 : a5 1e __ LDA ACCU + 3 
15f2 : 85 18 __ STA P11 ; (f + 3)
15f4 : 30 35 __ BMI $162b ; (nformf.s31 + 0)
.s1032:
15f6 : c9 41 __ CMP #$41
15f8 : d0 06 __ BNE $1600 ; (nformf.s1036 + 0)
.s1033:
15fa : a5 17 __ LDA P10 ; (f + 2)
15fc : c9 20 __ CMP #$20
15fe : f0 02 __ BEQ $1602 ; (nformf.s38 + 0)
.s1036:
1600 : 90 29 __ BCC $162b ; (nformf.s31 + 0)
.s38:
1602 : a9 00 __ LDA #$00
1604 : 85 03 __ STA WORK + 0 
1606 : 85 04 __ STA WORK + 1 
1608 : a9 20 __ LDA #$20
160a : 85 05 __ STA WORK + 2 
160c : a9 41 __ LDA #$41
160e : 85 06 __ STA WORK + 3 
1610 : 20 54 21 JSR $2154 ; (freg + 20)
1613 : 20 3b 23 JSR $233b ; (fdiv + 0)
1616 : a5 1c __ LDA ACCU + 1 
1618 : 85 16 __ STA P9 ; (f + 1)
161a : a5 1d __ LDA ACCU + 2 
161c : 85 17 __ STA P10 ; (f + 2)
161e : a5 1e __ LDA ACCU + 3 
1620 : 85 18 __ STA P11 ; (f + 3)
1622 : 18 __ __ CLC
1623 : a5 49 __ LDA T4 + 0 
1625 : 69 ff __ ADC #$ff
1627 : 85 47 __ STA T2 + 0 
1629 : a6 1b __ LDX ACCU + 0 
.s31:
162b : 38 __ __ SEC
162c : a5 4c __ LDA T8 + 0 
162e : e5 47 __ SBC T2 + 0 
1630 : 85 49 __ STA T4 + 0 
1632 : a9 14 __ LDA #$14
1634 : c5 4c __ CMP T8 + 0 
1636 : b0 02 __ BCS $163a ; (nformf.s49 + 0)
.s47:
1638 : 85 4c __ STA T8 + 0 
.s49:
163a : a5 49 __ LDA T4 + 0 
163c : d0 08 __ BNE $1646 ; (nformf.s219 + 0)
.s50:
163e : a9 30 __ LDA #$30
1640 : a4 48 __ LDY T3 + 0 
1642 : 91 13 __ STA (P6),y ; (str + 0)
1644 : e6 48 __ INC T3 + 0 
.s219:
1646 : a9 00 __ LDA #$00
1648 : 85 47 __ STA T2 + 0 
164a : c5 49 __ CMP T4 + 0 
164c : d0 08 __ BNE $1656 ; (nformf.l59 + 0)
.l57:
164e : a9 2e __ LDA #$2e
1650 : a4 48 __ LDY T3 + 0 
1652 : 91 13 __ STA (P6),y ; (str + 0)
1654 : e6 48 __ INC T3 + 0 
.l59:
1656 : a5 47 __ LDA T2 + 0 
1658 : c9 07 __ CMP #$07
165a : 90 04 __ BCC $1660 ; (nformf.s61 + 0)
.s60:
165c : a9 30 __ LDA #$30
165e : d0 55 __ BNE $16b5 ; (nformf.s208 + 0)
.s61:
1660 : 86 1b __ STX ACCU + 0 
1662 : 86 43 __ STX T1 + 0 
1664 : a5 16 __ LDA P9 ; (f + 1)
1666 : 85 1c __ STA ACCU + 1 
1668 : 85 44 __ STA T1 + 1 
166a : a5 17 __ LDA P10 ; (f + 2)
166c : 85 1d __ STA ACCU + 2 
166e : 85 45 __ STA T1 + 2 
1670 : a5 18 __ LDA P11 ; (f + 3)
1672 : 85 1e __ STA ACCU + 3 
1674 : 85 46 __ STA T1 + 3 
1676 : 20 d1 24 JSR $24d1 ; (f32_to_i16 + 0)
1679 : a5 1b __ LDA ACCU + 0 
167b : 85 4f __ STA T11 + 0 
167d : 20 13 25 JSR $2513 ; (sint16_to_float + 0)
1680 : a2 43 __ LDX #$43
1682 : 20 44 21 JSR $2144 ; (freg + 4)
1685 : a5 1e __ LDA ACCU + 3 
1687 : 49 80 __ EOR #$80
1689 : 85 1e __ STA ACCU + 3 
168b : 20 85 21 JSR $2185 ; (faddsub + 0)
168e : a9 00 __ LDA #$00
1690 : 85 03 __ STA WORK + 0 
1692 : 85 04 __ STA WORK + 1 
1694 : a9 20 __ LDA #$20
1696 : 85 05 __ STA WORK + 2 
1698 : a9 41 __ LDA #$41
169a : 85 06 __ STA WORK + 3 
169c : 20 54 21 JSR $2154 ; (freg + 20)
169f : 20 6c 22 JSR $226c ; (fmul + 0)
16a2 : a5 1c __ LDA ACCU + 1 
16a4 : 85 16 __ STA P9 ; (f + 1)
16a6 : a5 1d __ LDA ACCU + 2 
16a8 : 85 17 __ STA P10 ; (f + 2)
16aa : a5 1e __ LDA ACCU + 3 
16ac : 85 18 __ STA P11 ; (f + 3)
16ae : 18 __ __ CLC
16af : a5 4f __ LDA T11 + 0 
16b1 : 69 30 __ ADC #$30
16b3 : a6 1b __ LDX ACCU + 0 
.s208:
16b5 : a4 48 __ LDY T3 + 0 
16b7 : 91 13 __ STA (P6),y ; (str + 0)
16b9 : e6 48 __ INC T3 + 0 
16bb : e6 47 __ INC T2 + 0 
16bd : a5 47 __ LDA T2 + 0 
16bf : c5 4c __ CMP T8 + 0 
16c1 : b0 07 __ BCS $16ca ; (nformf.s56 + 0)
.s54:
16c3 : c5 49 __ CMP T4 + 0 
16c5 : d0 8f __ BNE $1656 ; (nformf.l59 + 0)
16c7 : 4c 4e 16 JMP $164e ; (nformf.l57 + 0)
.s56:
16ca : a5 4e __ LDA T9 + 0 
16cc : f0 62 __ BEQ $1730 ; (nformf.s9 + 0)
.s63:
16ce : a9 45 __ LDA #$45
16d0 : a4 48 __ LDY T3 + 0 
16d2 : 91 13 __ STA (P6),y ; (str + 0)
16d4 : c8 __ __ INY
16d5 : a5 4b __ LDA T5 + 1 
16d7 : 30 06 __ BMI $16df ; (nformf.s66 + 0)
.s67:
16d9 : a9 2b __ LDA #$2b
16db : 91 13 __ STA (P6),y ; (str + 0)
16dd : d0 11 __ BNE $16f0 ; (nformf.s68 + 0)
.s66:
16df : a9 2d __ LDA #$2d
16e1 : 91 13 __ STA (P6),y ; (str + 0)
16e3 : 38 __ __ SEC
16e4 : a9 00 __ LDA #$00
16e6 : e5 4a __ SBC T5 + 0 
16e8 : 85 4a __ STA T5 + 0 
16ea : a9 00 __ LDA #$00
16ec : e5 4b __ SBC T5 + 1 
16ee : 85 4b __ STA T5 + 1 
.s68:
16f0 : a5 4a __ LDA T5 + 0 
16f2 : 85 1b __ STA ACCU + 0 
16f4 : a5 4b __ LDA T5 + 1 
16f6 : 85 1c __ STA ACCU + 1 
16f8 : a9 0a __ LDA #$0a
16fa : 85 03 __ STA WORK + 0 
16fc : a9 00 __ LDA #$00
16fe : 85 04 __ STA WORK + 1 
1700 : 20 e9 23 JSR $23e9 ; (divs16 + 0)
1703 : 18 __ __ CLC
1704 : a5 1b __ LDA ACCU + 0 
1706 : 69 30 __ ADC #$30
1708 : a4 48 __ LDY T3 + 0 
170a : c8 __ __ INY
170b : c8 __ __ INY
170c : 91 13 __ STA (P6),y ; (str + 0)
170e : a5 4a __ LDA T5 + 0 
1710 : 85 1b __ STA ACCU + 0 
1712 : a5 4b __ LDA T5 + 1 
1714 : 85 1c __ STA ACCU + 1 
1716 : a9 0a __ LDA #$0a
1718 : 85 03 __ STA WORK + 0 
171a : a9 00 __ LDA #$00
171c : 85 04 __ STA WORK + 1 
171e : 20 a8 24 JSR $24a8 ; (mods16 + 0)
1721 : 18 __ __ CLC
1722 : a5 05 __ LDA WORK + 2 
1724 : 69 30 __ ADC #$30
1726 : a4 48 __ LDY T3 + 0 
1728 : c8 __ __ INY
1729 : c8 __ __ INY
172a : c8 __ __ INY
172b : 91 13 __ STA (P6),y ; (str + 0)
172d : c8 __ __ INY
172e : 84 48 __ STY T3 + 0 
.s9:
1730 : a5 11 __ LDA P4 ; (si + 0)
1732 : 85 4a __ STA T5 + 0 
1734 : a5 12 __ LDA P5 ; (si + 1)
1736 : 85 4b __ STA T5 + 1 
1738 : a5 48 __ LDA T3 + 0 
173a : a0 01 __ LDY #$01
173c : d1 11 __ CMP (P4),y ; (si + 0)
173e : b0 5d __ BCS $179d ; (nformf.s1001 + 0)
.s69:
1740 : a0 06 __ LDY #$06
1742 : b1 11 __ LDA (P4),y ; (si + 0)
1744 : f0 06 __ BEQ $174c ; (nformf.s73 + 0)
.s72:
1746 : a5 48 __ LDA T3 + 0 
1748 : aa __ __ TAX
1749 : 4c a4 17 JMP $17a4 ; (nformf.l75 + 0)
.s73:
174c : a5 48 __ LDA T3 + 0 
174e : f0 2d __ BEQ $177d ; (nformf.s82 + 0)
.s90:
1750 : a9 01 __ LDA #$01
1752 : 85 47 __ STA T2 + 0 
1754 : a6 48 __ LDX T3 + 0 
1756 : 38 __ __ SEC
.l1083:
1757 : a0 01 __ LDY #$01
1759 : b1 11 __ LDA (P4),y ; (si + 0)
175b : e5 47 __ SBC T2 + 0 
175d : 85 4c __ STA T8 + 0 
175f : a9 ff __ LDA #$ff
1761 : 65 14 __ ADC P7 ; (str + 1)
1763 : 85 4d __ STA T8 + 1 
1765 : 8a __ __ TXA
1766 : 38 __ __ SEC
1767 : e5 47 __ SBC T2 + 0 
1769 : 85 1b __ STA ACCU + 0 
176b : a9 ff __ LDA #$ff
176d : 65 14 __ ADC P7 ; (str + 1)
176f : 85 1c __ STA ACCU + 1 
1771 : a4 13 __ LDY P6 ; (str + 0)
1773 : b1 1b __ LDA (ACCU + 0),y 
1775 : 91 4c __ STA (T8 + 0),y 
1777 : e6 47 __ INC T2 + 0 
1779 : e4 47 __ CPX T2 + 0 
177b : b0 da __ BCS $1757 ; (nformf.l1083 + 0)
.s82:
177d : a9 00 __ LDA #$00
177f : 85 47 __ STA T2 + 0 
.l83:
1781 : a0 01 __ LDY #$01
1783 : b1 4a __ LDA (T5 + 0),y 
1785 : 38 __ __ SEC
1786 : e5 48 __ SBC T3 + 0 
1788 : 90 06 __ BCC $1790 ; (nformf.s84 + 0)
.s1011:
178a : c5 47 __ CMP T2 + 0 
178c : 90 0d __ BCC $179b ; (nformf.s74 + 0)
.s1087:
178e : f0 0b __ BEQ $179b ; (nformf.s74 + 0)
.s84:
1790 : a9 20 __ LDA #$20
1792 : a4 47 __ LDY T2 + 0 
1794 : 91 13 __ STA (P6),y ; (str + 0)
1796 : e6 47 __ INC T2 + 0 
1798 : 4c 81 17 JMP $1781 ; (nformf.l83 + 0)
.s74:
179b : b1 11 __ LDA (P4),y ; (si + 0)
.s1001:
179d : 85 1b __ STA ACCU + 0 
179f : a9 00 __ LDA #$00
17a1 : 85 1c __ STA ACCU + 1 
17a3 : 60 __ __ RTS
.l75:
17a4 : a0 01 __ LDY #$01
17a6 : d1 4a __ CMP (T5 + 0),y 
17a8 : b0 f1 __ BCS $179b ; (nformf.s74 + 0)
.s76:
17aa : a8 __ __ TAY
17ab : a9 20 __ LDA #$20
17ad : 91 13 __ STA (P6),y ; (str + 0)
17af : e8 __ __ INX
17b0 : 8a __ __ TXA
17b1 : 4c a4 17 JMP $17a4 ; (nformf.l75 + 0)
.s30:
17b4 : a5 4c __ LDA T8 + 0 
17b6 : c9 07 __ CMP #$07
17b8 : 90 13 __ BCC $17cd ; (nformf.s41 + 0)
.s42:
17ba : ad 9b 26 LDA $269b ; (fround5 + 25)
17bd : 85 1c __ STA ACCU + 1 
17bf : ad 9c 26 LDA $269c ; (fround5 + 26)
17c2 : 85 1d __ STA ACCU + 2 
17c4 : ad 9d 26 LDA $269d ; (fround5 + 27)
17c7 : ae 9a 26 LDX $269a ; (fround5 + 24)
17ca : 4c e0 17 JMP $17e0 ; (nformf.s204 + 0)
.s41:
17cd : 0a __ __ ASL
17ce : 0a __ __ ASL
17cf : a8 __ __ TAY
17d0 : b9 7f 26 LDA $267f,y ; (p2smap + 5)
17d3 : 85 1c __ STA ACCU + 1 
17d5 : b9 80 26 LDA $2680,y ; (p2smap + 6)
17d8 : 85 1d __ STA ACCU + 2 
17da : b9 81 26 LDA $2681,y ; (p2smap + 7)
17dd : be 7e 26 LDX $267e,y ; (p2smap + 4)
.s204:
17e0 : 86 1b __ STX ACCU + 0 
17e2 : 85 1e __ STA ACCU + 3 
17e4 : a2 43 __ LDX #$43
17e6 : 20 44 21 JSR $2144 ; (freg + 4)
17e9 : 20 85 21 JSR $2185 ; (faddsub + 0)
17ec : a5 1c __ LDA ACCU + 1 
17ee : 85 16 __ STA P9 ; (f + 1)
17f0 : a5 1d __ LDA ACCU + 2 
17f2 : 85 17 __ STA P10 ; (f + 2)
17f4 : a6 1b __ LDX ACCU + 0 
17f6 : a5 1e __ LDA ACCU + 3 
17f8 : 85 18 __ STA P11 ; (f + 3)
17fa : 10 03 __ BPL $17ff ; (nformf.s1042 + 0)
17fc : 4c 2b 16 JMP $162b ; (nformf.s31 + 0)
.s1042:
17ff : c9 41 __ CMP #$41
1801 : d0 06 __ BNE $1809 ; (nformf.s1046 + 0)
.s1043:
1803 : a5 17 __ LDA P10 ; (f + 2)
1805 : c9 20 __ CMP #$20
1807 : f0 05 __ BEQ $180e ; (nformf.s44 + 0)
.s1046:
1809 : b0 03 __ BCS $180e ; (nformf.s44 + 0)
180b : 4c 2b 16 JMP $162b ; (nformf.s31 + 0)
.s44:
180e : a9 00 __ LDA #$00
1810 : 85 03 __ STA WORK + 0 
1812 : 85 04 __ STA WORK + 1 
1814 : a9 20 __ LDA #$20
1816 : 85 05 __ STA WORK + 2 
1818 : a9 41 __ LDA #$41
181a : 85 06 __ STA WORK + 3 
181c : 20 54 21 JSR $2154 ; (freg + 20)
181f : 20 3b 23 JSR $233b ; (fdiv + 0)
1822 : a5 1c __ LDA ACCU + 1 
1824 : 85 16 __ STA P9 ; (f + 1)
1826 : a5 1d __ LDA ACCU + 2 
1828 : 85 17 __ STA P10 ; (f + 2)
182a : a5 1e __ LDA ACCU + 3 
182c : 85 18 __ STA P11 ; (f + 3)
182e : a6 1b __ LDX ACCU + 0 
1830 : e6 4a __ INC T5 + 0 
1832 : f0 03 __ BEQ $1837 ; (nformf.s1092 + 0)
1834 : 4c 2b 16 JMP $162b ; (nformf.s31 + 0)
.s1092:
1837 : e6 4b __ INC T5 + 1 
1839 : 4c 2b 16 JMP $162b ; (nformf.s31 + 0)
.s13:
183c : a5 18 __ LDA P11 ; (f + 3)
183e : 30 59 __ BMI $1899 ; (nformf.l17 + 0)
.l1072:
1840 : c9 44 __ CMP #$44
1842 : f0 03 __ BEQ $1847 ; (nformf.s1073 + 0)
1844 : 4c 36 19 JMP $1936 ; (nformf.s1076 + 0)
.s1073:
1847 : a5 45 __ LDA T1 + 2 
1849 : c9 7a __ CMP #$7a
184b : f0 03 __ BEQ $1850 ; (nformf.s1074 + 0)
184d : 4c 36 19 JMP $1936 ; (nformf.s1076 + 0)
.s1074:
1850 : a5 44 __ LDA T1 + 1 
1852 : d0 04 __ BNE $1858 ; (nformf.s1082 + 0)
.s1075:
1854 : a5 43 __ LDA T1 + 0 
1856 : f0 02 __ BEQ $185a ; (nformf.s14 + 0)
.s1082:
1858 : a5 43 __ LDA T1 + 0 
.s14:
185a : 85 1b __ STA ACCU + 0 
185c : a5 44 __ LDA T1 + 1 
185e : 85 1c __ STA ACCU + 1 
1860 : a5 45 __ LDA T1 + 2 
1862 : 85 1d __ STA ACCU + 2 
1864 : a5 46 __ LDA T1 + 3 
1866 : 85 1e __ STA ACCU + 3 
1868 : a9 00 __ LDA #$00
186a : 85 03 __ STA WORK + 0 
186c : 85 04 __ STA WORK + 1 
186e : a9 7a __ LDA #$7a
1870 : 85 05 __ STA WORK + 2 
1872 : a9 44 __ LDA #$44
1874 : 85 06 __ STA WORK + 3 
1876 : 20 54 21 JSR $2154 ; (freg + 20)
1879 : 20 3b 23 JSR $233b ; (fdiv + 0)
187c : a5 1b __ LDA ACCU + 0 
187e : 85 43 __ STA T1 + 0 
1880 : a5 1c __ LDA ACCU + 1 
1882 : 85 44 __ STA T1 + 1 
1884 : a5 1d __ LDA ACCU + 2 
1886 : 85 45 __ STA T1 + 2 
1888 : 18 __ __ CLC
1889 : a5 4a __ LDA T5 + 0 
188b : 69 03 __ ADC #$03
188d : 85 4a __ STA T5 + 0 
188f : 90 02 __ BCC $1893 ; (nformf.s1097 + 0)
.s1096:
1891 : e6 4b __ INC T5 + 1 
.s1097:
1893 : a5 1e __ LDA ACCU + 3 
1895 : 85 46 __ STA T1 + 3 
1897 : 10 a7 __ BPL $1840 ; (nformf.l1072 + 0)
.l17:
1899 : a9 00 __ LDA #$00
189b : 85 1b __ STA ACCU + 0 
189d : 85 1c __ STA ACCU + 1 
189f : a9 7a __ LDA #$7a
18a1 : 85 1d __ STA ACCU + 2 
18a3 : a9 44 __ LDA #$44
18a5 : 85 1e __ STA ACCU + 3 
18a7 : a2 43 __ LDX #$43
18a9 : 20 44 21 JSR $2144 ; (freg + 4)
18ac : 20 6c 22 JSR $226c ; (fmul + 0)
18af : a5 1b __ LDA ACCU + 0 
18b1 : 85 43 __ STA T1 + 0 
18b3 : a5 1c __ LDA ACCU + 1 
18b5 : 85 44 __ STA T1 + 1 
18b7 : a5 1d __ LDA ACCU + 2 
18b9 : 85 45 __ STA T1 + 2 
18bb : a5 1e __ LDA ACCU + 3 
18bd : 85 46 __ STA T1 + 3 
18bf : 38 __ __ SEC
18c0 : a5 4a __ LDA T5 + 0 
18c2 : e9 03 __ SBC #$03
18c4 : 85 4a __ STA T5 + 0 
18c6 : b0 02 __ BCS $18ca ; (nformf.s16 + 0)
.s1088:
18c8 : c6 4b __ DEC T5 + 1 
.s16:
18ca : a5 46 __ LDA T1 + 3 
18cc : 30 cb __ BMI $1899 ; (nformf.l17 + 0)
.s1064:
18ce : c9 3f __ CMP #$3f
18d0 : d0 06 __ BNE $18d8 ; (nformf.s1068 + 0)
.s1065:
18d2 : a5 45 __ LDA T1 + 2 
18d4 : c9 80 __ CMP #$80
18d6 : f0 02 __ BEQ $18da ; (nformf.s19 + 0)
.s1068:
18d8 : 90 bf __ BCC $1899 ; (nformf.l17 + 0)
.s19:
18da : a5 46 __ LDA T1 + 3 
18dc : c9 41 __ CMP #$41
18de : d0 51 __ BNE $1931 ; (nformf.l1060 + 0)
.s1057:
18e0 : a5 45 __ LDA T1 + 2 
18e2 : c9 20 __ CMP #$20
18e4 : d0 4b __ BNE $1931 ; (nformf.l1060 + 0)
.s1058:
18e6 : a5 44 __ LDA T1 + 1 
18e8 : d0 04 __ BNE $18ee ; (nformf.l1081 + 0)
.s1059:
18ea : a5 43 __ LDA T1 + 0 
18ec : f0 02 __ BEQ $18f0 ; (nformf.l20 + 0)
.l1081:
18ee : a5 43 __ LDA T1 + 0 
.l20:
18f0 : 85 1b __ STA ACCU + 0 
18f2 : a5 44 __ LDA T1 + 1 
18f4 : 85 1c __ STA ACCU + 1 
18f6 : a5 45 __ LDA T1 + 2 
18f8 : 85 1d __ STA ACCU + 2 
18fa : a5 46 __ LDA T1 + 3 
18fc : 85 1e __ STA ACCU + 3 
18fe : a9 00 __ LDA #$00
1900 : 85 03 __ STA WORK + 0 
1902 : 85 04 __ STA WORK + 1 
1904 : a9 20 __ LDA #$20
1906 : 85 05 __ STA WORK + 2 
1908 : a9 41 __ LDA #$41
190a : 85 06 __ STA WORK + 3 
190c : 20 54 21 JSR $2154 ; (freg + 20)
190f : 20 3b 23 JSR $233b ; (fdiv + 0)
1912 : a5 1b __ LDA ACCU + 0 
1914 : 85 43 __ STA T1 + 0 
1916 : a5 1c __ LDA ACCU + 1 
1918 : 85 44 __ STA T1 + 1 
191a : a5 1d __ LDA ACCU + 2 
191c : 85 45 __ STA T1 + 2 
191e : e6 4a __ INC T5 + 0 
1920 : d0 02 __ BNE $1924 ; (nformf.s1091 + 0)
.s1090:
1922 : e6 4b __ INC T5 + 1 
.s1091:
1924 : a5 1e __ LDA ACCU + 3 
1926 : 85 46 __ STA T1 + 3 
1928 : 10 03 __ BPL $192d ; (nformf.s1056 + 0)
192a : 4c 2f 15 JMP $152f ; (nformf.s12 + 0)
.s1056:
192d : c9 41 __ CMP #$41
192f : f0 af __ BEQ $18e0 ; (nformf.s1057 + 0)
.l1060:
1931 : b0 bb __ BCS $18ee ; (nformf.l1081 + 0)
1933 : 4c 2f 15 JMP $152f ; (nformf.s12 + 0)
.s1076:
1936 : 90 92 __ BCC $18ca ; (nformf.s16 + 0)
1938 : 4c 58 18 JMP $1858 ; (nformf.s1082 + 0)
.s7:
193b : 85 1b __ STA ACCU + 0 
193d : a9 49 __ LDA #$49
193f : 91 13 __ STA (P6),y ; (str + 0)
1941 : a9 4e __ LDA #$4e
1943 : a4 4a __ LDY T5 + 0 
1945 : 91 13 __ STA (P6),y ; (str + 0)
1947 : a9 46 __ LDA #$46
1949 : a4 1b __ LDY ACCU + 0 
194b : 91 13 __ STA (P6),y ; (str + 0)
194d : 18 __ __ CLC
194e : a5 48 __ LDA T3 + 0 
1950 : 69 03 __ ADC #$03
1952 : 85 48 __ STA T3 + 0 
1954 : 4c 30 17 JMP $1730 ; (nformf.s9 + 0)
.s189:
1957 : 20 6f 19 JSR $196f ; (isinf.s0 + 0)
195a : aa __ __ TAX
195b : a9 01 __ LDA #$01
195d : 85 48 __ STA T3 + 0 
195f : 8a __ __ TXA
1960 : d0 03 __ BNE $1965 ; (nformf.s158 + 0)
1962 : 4c 0c 15 JMP $150c ; (nformf.s8 + 0)
.s158:
1965 : a9 02 __ LDA #$02
1967 : 85 4a __ STA T5 + 0 
1969 : a9 03 __ LDA #$03
196b : a0 01 __ LDY #$01
196d : d0 cc __ BNE $193b ; (nformf.s7 + 0)
--------------------------------------------------------------------
isinf:
.s0:
196f : 06 0f __ ASL P2 ; (f + 2)
1971 : a5 10 __ LDA P3 ; (f + 3)
1973 : 2a __ __ ROL
1974 : c9 ff __ CMP #$ff
1976 : d0 03 __ BNE $197b ; (isinf.s1003 + 0)
.s1002:
1978 : a9 01 __ LDA #$01
197a : 60 __ __ RTS
.s1003:
197b : a9 00 __ LDA #$00
.s1001:
197d : 60 __ __ RTS
--------------------------------------------------------------------
fround5:
2682 : __ __ __ BYT 00 00 00 3f cd cc 4c 3d 0a d7 a3 3b 6f 12 03 3a : ...?..L=...;o..:
2692 : __ __ __ BYT 17 b7 51 38 ac c5 a7 36 bd 37 06 35             : ..Q8...6.7.5
--------------------------------------------------------------------
08fa : __ __ __ BYT 25 64 00                                        : %d.
--------------------------------------------------------------------
197e : __ __ __ BYT 53 48 49 50 53 3a 00                            : SHIPS:.
--------------------------------------------------------------------
play_sound_effects:
.s0:
1985 : ad b5 26 LDA $26b5 ; (PlayerShotSound + 3)
1988 : c9 01 __ CMP #$01
198a : d0 2c __ BNE $19b8 ; (play_sound_effects.s2 + 0)
.s1:
198c : a9 20 __ LDA #$20
198e : 8d b2 26 STA $26b2 ; (PlayerShotSound + 0)
1991 : a9 4e __ LDA #$4e
1993 : 8d b3 26 STA $26b3 ; (PlayerShotSound + 1)
1996 : a9 00 __ LDA #$00
1998 : 8d b4 26 STA $26b4 ; (PlayerShotSound + 2)
199b : a9 20 __ LDA #$20
199d : 8d 00 d4 STA $d400 
19a0 : a9 4e __ LDA #$4e
19a2 : 8d 01 d4 STA $d401 
19a5 : a9 05 __ LDA #$05
19a7 : 8d 05 d4 STA $d405 
19aa : a9 f1 __ LDA #$f1
19ac : 8d 06 d4 STA $d406 
19af : a9 81 __ LDA #$81
19b1 : 8d 04 d4 STA $d404 
19b4 : a9 02 __ LDA #$02
19b6 : d0 35 __ BNE $19ed ; (play_sound_effects.s1008 + 0)
.s2:
19b8 : c9 02 __ CMP #$02
19ba : d0 26 __ BNE $19e2 ; (play_sound_effects.s5 + 0)
.s4:
19bc : ad b2 26 LDA $26b2 ; (PlayerShotSound + 0)
19bf : 38 __ __ SEC
19c0 : e9 f4 __ SBC #$f4
19c2 : 8d b2 26 STA $26b2 ; (PlayerShotSound + 0)
19c5 : ad b3 26 LDA $26b3 ; (PlayerShotSound + 1)
19c8 : e9 01 __ SBC #$01
19ca : 8d b3 26 STA $26b3 ; (PlayerShotSound + 1)
19cd : ad b2 26 LDA $26b2 ; (PlayerShotSound + 0)
19d0 : 8d 00 d4 STA $d400 
19d3 : ad b3 26 LDA $26b3 ; (PlayerShotSound + 1)
19d6 : 8d 01 d4 STA $d401 
19d9 : a9 14 __ LDA #$14
19db : 8d b4 26 STA $26b4 ; (PlayerShotSound + 2)
19de : a9 03 __ LDA #$03
19e0 : d0 0b __ BNE $19ed ; (play_sound_effects.s1008 + 0)
.s5:
19e2 : c9 03 __ CMP #$03
19e4 : d0 0a __ BNE $19f0 ; (play_sound_effects.s1001 + 0)
.s10:
19e6 : a9 08 __ LDA #$08
19e8 : 8d 04 d4 STA $d404 
19eb : a9 00 __ LDA #$00
.s1008:
19ed : 8d b5 26 STA $26b5 ; (PlayerShotSound + 3)
.s1001:
19f0 : 60 __ __ RTS
--------------------------------------------------------------------
spawn_enemy:
.s0:
19f1 : 20 61 1a JSR $1a61 ; (rand.s0 + 0)
19f4 : 46 1b __ LSR ACCU + 0 
19f6 : b0 0f __ BCS $1a07 ; (spawn_enemy.s1001 + 0)
.s3:
19f8 : a0 00 __ LDY #$00
.l6:
19fa : be f4 25 LDX $25f4,y ; (__multab5L + 0)
19fd : bd ba 26 LDA $26ba,x ; (Enemy + 4)
1a00 : f0 06 __ BEQ $1a08 ; (spawn_enemy.s9 + 0)
.s7:
1a02 : c8 __ __ INY
1a03 : c0 0a __ CPY #$0a
1a05 : 90 f3 __ BCC $19fa ; (spawn_enemy.l6 + 0)
.s1001:
1a07 : 60 __ __ RTS
.s9:
1a08 : 86 43 __ STX T0 + 0 
1a0a : a9 27 __ LDA #$27
1a0c : 9d b6 26 STA $26b6,x ; (Enemy + 0)
1a0f : 20 61 1a JSR $1a61 ; (rand.s0 + 0)
1a12 : a9 14 __ LDA #$14
1a14 : 85 03 __ STA WORK + 0 
1a16 : a9 00 __ LDA #$00
1a18 : 85 04 __ STA WORK + 1 
1a1a : 20 23 24 JSR $2423 ; (divmod + 0)
1a1d : 18 __ __ CLC
1a1e : a5 05 __ LDA WORK + 2 
1a20 : 69 04 __ ADC #$04
1a22 : a6 43 __ LDX T0 + 0 
1a24 : 9d b7 26 STA $26b7,x ; (Enemy + 1)
1a27 : 20 61 1a JSR $1a61 ; (rand.s0 + 0)
1a2a : a9 0e __ LDA #$0e
1a2c : a6 43 __ LDX T0 + 0 
1a2e : 9d b9 26 STA $26b9,x ; (Enemy + 3)
1a31 : a9 01 __ LDA #$01
1a33 : 9d ba 26 STA $26ba,x ; (Enemy + 4)
1a36 : a9 03 __ LDA #$03
1a38 : 85 03 __ STA WORK + 0 
1a3a : a9 00 __ LDA #$00
1a3c : 85 04 __ STA WORK + 1 
1a3e : 20 23 24 JSR $2423 ; (divmod + 0)
1a41 : 18 __ __ CLC
1a42 : a5 05 __ LDA WORK + 2 
1a44 : 69 83 __ ADC #$83
1a46 : a4 43 __ LDY T0 + 0 
1a48 : 99 b8 26 STA $26b8,y ; (Enemy + 2)
1a4b : c9 83 __ CMP #$83
1a4d : d0 04 __ BNE $1a53 ; (spawn_enemy.s13 + 0)
.s12:
1a4f : a9 0d __ LDA #$0d
1a51 : d0 0a __ BNE $1a5d ; (spawn_enemy.s1008 + 0)
.s13:
1a53 : c9 84 __ CMP #$84
1a55 : d0 04 __ BNE $1a5b ; (spawn_enemy.s16 + 0)
.s15:
1a57 : a9 0a __ LDA #$0a
1a59 : d0 02 __ BNE $1a5d ; (spawn_enemy.s1008 + 0)
.s16:
1a5b : a9 09 __ LDA #$09
.s1008:
1a5d : 99 b9 26 STA $26b9,y ; (Enemy + 3)
1a60 : 60 __ __ RTS
--------------------------------------------------------------------
rand:
.s0:
1a61 : ad 9f 26 LDA $269f ; (seed + 1)
1a64 : 4a __ __ LSR
1a65 : ad 9e 26 LDA $269e ; (seed + 0)
1a68 : 6a __ __ ROR
1a69 : aa __ __ TAX
1a6a : a9 00 __ LDA #$00
1a6c : 6a __ __ ROR
1a6d : 4d 9e 26 EOR $269e ; (seed + 0)
1a70 : 85 1b __ STA ACCU + 0 
1a72 : 8a __ __ TXA
1a73 : 4d 9f 26 EOR $269f ; (seed + 1)
1a76 : 85 1c __ STA ACCU + 1 
1a78 : 4a __ __ LSR
1a79 : 45 1b __ EOR ACCU + 0 
1a7b : 8d 9e 26 STA $269e ; (seed + 0)
1a7e : 85 1b __ STA ACCU + 0 
1a80 : 45 1c __ EOR ACCU + 1 
1a82 : 8d 9f 26 STA $269f ; (seed + 1)
1a85 : 85 1c __ STA ACCU + 1 
.s1001:
1a87 : 60 __ __ RTS
--------------------------------------------------------------------
seed:
269e : __ __ __ BYT 00 7a                                           : .z
--------------------------------------------------------------------
move_enemies:
.s0:
1a88 : a2 00 __ LDX #$00
.l2:
1a8a : 86 43 __ STX T0 + 0 
1a8c : bc f4 25 LDY $25f4,x ; (__multab5L + 0)
1a8f : b9 ba 26 LDA $26ba,y ; (Enemy + 4)
1a92 : c9 01 __ CMP #$01
1a94 : d0 75 __ BNE $1b0b ; (move_enemies.s41 + 0)
.s5:
1a96 : 18 __ __ CLC
1a97 : a9 b6 __ LDA #$b6
1a99 : 7d f4 25 ADC $25f4,x ; (__multab5L + 0)
1a9c : 85 44 __ STA T1 + 0 
1a9e : a9 26 __ LDA #$26
1aa0 : 69 00 __ ADC #$00
1aa2 : 85 45 __ STA T1 + 1 
1aa4 : a0 02 __ LDY #$02
1aa6 : b1 44 __ LDA (T1 + 0),y 
1aa8 : c9 83 __ CMP #$83
1aaa : d0 16 __ BNE $1ac2 ; (move_enemies.s10 + 0)
.s11:
1aac : 88 __ __ DEY
1aad : b1 44 __ LDA (T1 + 0),y 
1aaf : cd b1 26 CMP $26b1 ; (Player + 1)
1ab2 : d0 0e __ BNE $1ac2 ; (move_enemies.s10 + 0)
.s8:
1ab4 : a5 44 __ LDA T1 + 0 
1ab6 : 85 0d __ STA P0 
1ab8 : a5 45 __ LDA T1 + 1 
1aba : 85 0e __ STA P1 
1abc : 20 78 1b JSR $1b78 ; (spawn_enemy_shot.s0 + 0)
1abf : 20 ab 1b JSR $1bab ; (render_enemy_shots.s0 + 0)
.s10:
1ac2 : a0 00 __ LDY #$00
1ac4 : b1 44 __ LDA (T1 + 0),y 
1ac6 : 85 46 __ STA T3 + 0 
1ac8 : c8 __ __ INY
1ac9 : b1 44 __ LDA (T1 + 0),y 
1acb : 0a __ __ ASL
1acc : 85 1b __ STA ACCU + 0 
1ace : a9 00 __ LDA #$00
1ad0 : 2a __ __ ROL
1ad1 : 06 1b __ ASL ACCU + 0 
1ad3 : 2a __ __ ROL
1ad4 : aa __ __ TAX
1ad5 : a5 1b __ LDA ACCU + 0 
1ad7 : 71 44 __ ADC (T1 + 0),y 
1ad9 : 85 1b __ STA ACCU + 0 
1adb : 8a __ __ TXA
1adc : 69 00 __ ADC #$00
1ade : 06 1b __ ASL ACCU + 0 
1ae0 : 2a __ __ ROL
1ae1 : 06 1b __ ASL ACCU + 0 
1ae3 : 2a __ __ ROL
1ae4 : 06 1b __ ASL ACCU + 0 
1ae6 : 2a __ __ ROL
1ae7 : aa __ __ TAX
1ae8 : 18 __ __ CLC
1ae9 : a5 1b __ LDA ACCU + 0 
1aeb : 65 46 __ ADC T3 + 0 
1aed : 85 1b __ STA ACCU + 0 
1aef : 85 1f __ STA ADDR + 0 
1af1 : 8a __ __ TXA
1af2 : 69 c0 __ ADC #$c0
1af4 : 85 1c __ STA ACCU + 1 
1af6 : 18 __ __ CLC
1af7 : 69 18 __ ADC #$18
1af9 : 85 20 __ STA ADDR + 1 
1afb : a9 20 __ LDA #$20
1afd : 88 __ __ DEY
1afe : 91 1b __ STA (ACCU + 0),y 
1b00 : 98 __ __ TYA
1b01 : 91 1f __ STA (ADDR + 0),y 
1b03 : a5 46 __ LDA T3 + 0 
1b05 : d0 0f __ BNE $1b16 ; (move_enemies.s12 + 0)
.s13:
1b07 : a0 04 __ LDY #$04
.s1020:
1b09 : 91 44 __ STA (T1 + 0),y 
.s41:
1b0b : a6 43 __ LDX T0 + 0 
1b0d : e8 __ __ INX
1b0e : e0 0a __ CPX #$0a
1b10 : b0 03 __ BCS $1b15 ; (move_enemies.s1001 + 0)
1b12 : 4c 8a 1a JMP $1a8a ; (move_enemies.l2 + 0)
.s1001:
1b15 : 60 __ __ RTS
.s12:
1b16 : c6 46 __ DEC T3 + 0 
1b18 : a5 46 __ LDA T3 + 0 
1b1a : 91 44 __ STA (T1 + 0),y 
1b1c : a0 02 __ LDY #$02
1b1e : b1 44 __ LDA (T1 + 0),y 
1b20 : c9 85 __ CMP #$85
1b22 : f0 e7 __ BEQ $1b0b ; (move_enemies.s41 + 0)
.s15:
1b24 : 20 61 1a JSR $1a61 ; (rand.s0 + 0)
1b27 : a0 01 __ LDY #$01
1b29 : b1 44 __ LDA (T1 + 0),y 
1b2b : 85 47 __ STA T4 + 0 
1b2d : a9 03 __ LDA #$03
1b2f : 85 03 __ STA WORK + 0 
1b31 : a9 00 __ LDA #$00
1b33 : 85 04 __ STA WORK + 1 
1b35 : 20 23 24 JSR $2423 ; (divmod + 0)
1b38 : 38 __ __ SEC
1b39 : a5 05 __ LDA WORK + 2 
1b3b : e9 01 __ SBC #$01
1b3d : aa __ __ TAX
1b3e : a5 06 __ LDA WORK + 3 
1b40 : e9 00 __ SBC #$00
1b42 : a8 __ __ TAY
1b43 : 8a __ __ TXA
1b44 : 18 __ __ CLC
1b45 : 65 47 __ ADC T4 + 0 
1b47 : 85 1b __ STA ACCU + 0 
1b49 : 90 01 __ BCC $1b4c ; (move_enemies.s1022 + 0)
.s1021:
1b4b : c8 __ __ INY
.s1022:
1b4c : 0a __ __ ASL
1b4d : 0a __ __ ASL
1b4e : 18 __ __ CLC
1b4f : 65 1b __ ADC ACCU + 0 
1b51 : 0a __ __ ASL
1b52 : 0a __ __ ASL
1b53 : 0a __ __ ASL
1b54 : 18 __ __ CLC
1b55 : 65 46 __ ADC T3 + 0 
1b57 : aa __ __ TAX
1b58 : bd 00 c0 LDA $c000,x 
1b5b : c9 83 __ CMP #$83
1b5d : f0 ac __ BEQ $1b0b ; (move_enemies.s41 + 0)
.s24:
1b5f : c9 84 __ CMP #$84
1b61 : f0 a8 __ BEQ $1b0b ; (move_enemies.s41 + 0)
.s23:
1b63 : c9 85 __ CMP #$85
1b65 : f0 a4 __ BEQ $1b0b ; (move_enemies.s41 + 0)
.s22:
1b67 : 98 __ __ TYA
1b68 : d0 a1 __ BNE $1b0b ; (move_enemies.s41 + 0)
.s1005:
1b6a : a5 1b __ LDA ACCU + 0 
1b6c : c9 04 __ CMP #$04
1b6e : 90 9b __ BCC $1b0b ; (move_enemies.s41 + 0)
.s1004:
1b70 : c9 18 __ CMP #$18
1b72 : b0 97 __ BCS $1b0b ; (move_enemies.s41 + 0)
.s18:
1b74 : a0 01 __ LDY #$01
1b76 : d0 91 __ BNE $1b09 ; (move_enemies.s1020 + 0)
--------------------------------------------------------------------
spawn_enemy_shot:
.s0:
1b78 : a0 00 __ LDY #$00
1b7a : b1 0d __ LDA (P0),y ; (e + 0)
1b7c : f0 0f __ BEQ $1b8d ; (spawn_enemy_shot.s1001 + 0)
.s3:
1b7e : a2 00 __ LDX #$00
.l6:
1b80 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1b83 : b9 f3 26 LDA $26f3,y ; (EnemyShot + 2)
1b86 : f0 06 __ BEQ $1b8e ; (spawn_enemy_shot.s9 + 0)
.s7:
1b88 : e8 __ __ INX
1b89 : e0 03 __ CPX #$03
1b8b : 90 f3 __ BCC $1b80 ; (spawn_enemy_shot.l6 + 0)
.s1001:
1b8d : 60 __ __ RTS
.s9:
1b8e : a9 01 __ LDA #$01
1b90 : 99 f3 26 STA $26f3,y ; (EnemyShot + 2)
1b93 : a0 00 __ LDY #$00
1b95 : b1 0d __ LDA (P0),y ; (e + 0)
1b97 : 38 __ __ SEC
1b98 : e9 01 __ SBC #$01
1b9a : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1b9d : 99 f1 26 STA $26f1,y ; (EnemyShot + 0)
1ba0 : a0 01 __ LDY #$01
1ba2 : b1 0d __ LDA (P0),y ; (e + 0)
1ba4 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1ba7 : 99 f2 26 STA $26f2,y ; (EnemyShot + 1)
1baa : 60 __ __ RTS
--------------------------------------------------------------------
render_enemy_shots:
.s0:
1bab : a2 00 __ LDX #$00
.l1006:
1bad : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1bb0 : b9 f3 26 LDA $26f3,y ; (EnemyShot + 2)
1bb3 : c9 01 __ CMP #$01
1bb5 : d0 43 __ BNE $1bfa ; (render_enemy_shots.s19 + 0)
.s5:
1bb7 : b9 f2 26 LDA $26f2,y ; (EnemyShot + 1)
1bba : 0a __ __ ASL
1bbb : 85 1b __ STA ACCU + 0 
1bbd : a9 00 __ LDA #$00
1bbf : 2a __ __ ROL
1bc0 : 06 1b __ ASL ACCU + 0 
1bc2 : 2a __ __ ROL
1bc3 : 85 1c __ STA ACCU + 1 
1bc5 : a5 1b __ LDA ACCU + 0 
1bc7 : 79 f2 26 ADC $26f2,y ; (EnemyShot + 1)
1bca : 85 1b __ STA ACCU + 0 
1bcc : a5 1c __ LDA ACCU + 1 
1bce : 69 00 __ ADC #$00
1bd0 : 06 1b __ ASL ACCU + 0 
1bd2 : 2a __ __ ROL
1bd3 : 06 1b __ ASL ACCU + 0 
1bd5 : 2a __ __ ROL
1bd6 : 06 1b __ ASL ACCU + 0 
1bd8 : 2a __ __ ROL
1bd9 : 85 1c __ STA ACCU + 1 
1bdb : 18 __ __ CLC
1bdc : a5 1b __ LDA ACCU + 0 
1bde : 79 f1 26 ADC $26f1,y ; (EnemyShot + 0)
1be1 : 85 1b __ STA ACCU + 0 
1be3 : 85 1f __ STA ADDR + 0 
1be5 : a5 1c __ LDA ACCU + 1 
1be7 : 69 c0 __ ADC #$c0
1be9 : 85 1c __ STA ACCU + 1 
1beb : 18 __ __ CLC
1bec : 69 18 __ ADC #$18
1bee : 85 20 __ STA ADDR + 1 
1bf0 : a9 82 __ LDA #$82
1bf2 : a0 00 __ LDY #$00
1bf4 : 91 1b __ STA (ACCU + 0),y 
1bf6 : a9 01 __ LDA #$01
1bf8 : 91 1f __ STA (ADDR + 0),y 
.s19:
1bfa : e8 __ __ INX
1bfb : e0 03 __ CPX #$03
1bfd : 90 ae __ BCC $1bad ; (render_enemy_shots.l1006 + 0)
.s1001:
1bff : 60 __ __ RTS
--------------------------------------------------------------------
render_enemies:
.s0:
1c00 : a2 00 __ LDX #$00
.l1006:
1c02 : bc f4 25 LDY $25f4,x ; (__multab5L + 0)
1c05 : b9 ba 26 LDA $26ba,y ; (Enemy + 4)
1c08 : c9 01 __ CMP #$01
1c0a : d0 4b __ BNE $1c57 ; (render_enemies.s19 + 0)
.s5:
1c0c : 84 1d __ STY ACCU + 2 
1c0e : b9 b7 26 LDA $26b7,y ; (Enemy + 1)
1c11 : 0a __ __ ASL
1c12 : 85 1b __ STA ACCU + 0 
1c14 : a9 00 __ LDA #$00
1c16 : 2a __ __ ROL
1c17 : 06 1b __ ASL ACCU + 0 
1c19 : 2a __ __ ROL
1c1a : 85 1c __ STA ACCU + 1 
1c1c : a5 1b __ LDA ACCU + 0 
1c1e : 79 b7 26 ADC $26b7,y ; (Enemy + 1)
1c21 : 85 1b __ STA ACCU + 0 
1c23 : a5 1c __ LDA ACCU + 1 
1c25 : 69 00 __ ADC #$00
1c27 : 06 1b __ ASL ACCU + 0 
1c29 : 2a __ __ ROL
1c2a : 06 1b __ ASL ACCU + 0 
1c2c : 2a __ __ ROL
1c2d : 06 1b __ ASL ACCU + 0 
1c2f : 2a __ __ ROL
1c30 : 85 1c __ STA ACCU + 1 
1c32 : 18 __ __ CLC
1c33 : a5 1b __ LDA ACCU + 0 
1c35 : 79 b6 26 ADC $26b6,y ; (Enemy + 0)
1c38 : 85 43 __ STA T2 + 0 
1c3a : 85 1b __ STA ACCU + 0 
1c3c : a5 1c __ LDA ACCU + 1 
1c3e : 69 c0 __ ADC #$c0
1c40 : 85 44 __ STA T2 + 1 
1c42 : 18 __ __ CLC
1c43 : 69 18 __ ADC #$18
1c45 : 85 1c __ STA ACCU + 1 
1c47 : b9 b8 26 LDA $26b8,y ; (Enemy + 2)
1c4a : a0 00 __ LDY #$00
1c4c : 91 43 __ STA (T2 + 0),y 
1c4e : a4 1d __ LDY ACCU + 2 
1c50 : b9 b9 26 LDA $26b9,y ; (Enemy + 3)
1c53 : a0 00 __ LDY #$00
1c55 : 91 1b __ STA (ACCU + 0),y 
.s19:
1c57 : e8 __ __ INX
1c58 : e0 0a __ CPX #$0a
1c5a : 90 a6 __ BCC $1c02 ; (render_enemies.l1006 + 0)
.s1001:
1c5c : 60 __ __ RTS
--------------------------------------------------------------------
check_shot_enemy_collision:
.s0:
1c5d : a2 00 __ LDX #$00
.l2:
1c5f : 86 1d __ STX ACCU + 2 
1c61 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1c64 : b9 ea 26 LDA $26ea,y ; (PlayerShot + 2)
1c67 : c9 01 __ CMP #$01
1c69 : d0 2e __ BNE $1c99 ; (check_shot_enemy_collision.s3 + 0)
.s5:
1c6b : a2 00 __ LDX #$00
.l9:
1c6d : 86 43 __ STX T2 + 0 
1c6f : bc f4 25 LDY $25f4,x ; (__multab5L + 0)
1c72 : 84 1e __ STY ACCU + 3 
1c74 : b9 ba 26 LDA $26ba,y ; (Enemy + 4)
1c77 : c9 01 __ CMP #$01
1c79 : d0 17 __ BNE $1c92 ; (check_shot_enemy_collision.s114 + 0)
.s12:
1c7b : b9 b6 26 LDA $26b6,y ; (Enemy + 0)
1c7e : a6 1d __ LDX ACCU + 2 
1c80 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1c83 : d9 e8 26 CMP $26e8,y ; (PlayerShot + 0)
1c86 : d0 0a __ BNE $1c92 ; (check_shot_enemy_collision.s114 + 0)
.s18:
1c88 : b9 e9 26 LDA $26e9,y ; (PlayerShot + 1)
1c8b : a6 1e __ LDX ACCU + 3 
1c8d : dd b7 26 CMP $26b7,x ; (Enemy + 1)
1c90 : f0 0f __ BEQ $1ca1 ; (check_shot_enemy_collision.s15 + 0)
.s114:
1c92 : a6 43 __ LDX T2 + 0 
1c94 : e8 __ __ INX
1c95 : e0 0a __ CPX #$0a
1c97 : 90 d4 __ BCC $1c6d ; (check_shot_enemy_collision.l9 + 0)
.s3:
1c99 : a6 1d __ LDX ACCU + 2 
1c9b : e8 __ __ INX
1c9c : e0 03 __ CPX #$03
1c9e : 90 bf __ BCC $1c5f ; (check_shot_enemy_collision.l2 + 0)
.s1001:
1ca0 : 60 __ __ RTS
.s15:
1ca1 : a9 00 __ LDA #$00
1ca3 : 85 44 __ STA T3 + 0 
.l20:
1ca5 : a4 1e __ LDY ACCU + 3 
1ca7 : b9 b7 26 LDA $26b7,y ; (Enemy + 1)
1caa : 0a __ __ ASL
1cab : 85 1b __ STA ACCU + 0 
1cad : a9 00 __ LDA #$00
1caf : 2a __ __ ROL
1cb0 : 06 1b __ ASL ACCU + 0 
1cb2 : 2a __ __ ROL
1cb3 : aa __ __ TAX
1cb4 : a5 1b __ LDA ACCU + 0 
1cb6 : 79 b7 26 ADC $26b7,y ; (Enemy + 1)
1cb9 : 85 1b __ STA ACCU + 0 
1cbb : 8a __ __ TXA
1cbc : 69 00 __ ADC #$00
1cbe : 06 1b __ ASL ACCU + 0 
1cc0 : 2a __ __ ROL
1cc1 : 06 1b __ ASL ACCU + 0 
1cc3 : 2a __ __ ROL
1cc4 : 06 1b __ ASL ACCU + 0 
1cc6 : 2a __ __ ROL
1cc7 : aa __ __ TAX
1cc8 : 18 __ __ CLC
1cc9 : a5 1b __ LDA ACCU + 0 
1ccb : 79 b6 26 ADC $26b6,y ; (Enemy + 0)
1cce : 85 1b __ STA ACCU + 0 
1cd0 : 8a __ __ TXA
1cd1 : 69 c0 __ ADC #$c0
1cd3 : 85 1c __ STA ACCU + 1 
1cd5 : 18 __ __ CLC
1cd6 : 69 18 __ ADC #$18
1cd8 : 85 20 __ STA ADDR + 1 
1cda : a9 86 __ LDA #$86
1cdc : a0 00 __ LDY #$00
1cde : 84 1f __ STY ADDR + 0 
1ce0 : 91 1b __ STA (ACCU + 0),y 
1ce2 : a5 44 __ LDA T3 + 0 
1ce4 : a4 1b __ LDY ACCU + 0 
1ce6 : 91 1f __ STA (ADDR + 0),y 
1ce8 : aa __ __ TAX
1ce9 : bd 00 26 LDA $2600,x ; (__multab2000L + 0)
1cec : 8d 00 d4 STA $d400 
1cef : bd 08 26 LDA $2608,x ; (__multab2000H + 0)
1cf2 : 8d 01 d4 STA $d401 
1cf5 : a9 35 __ LDA #$35
1cf7 : 8d 05 d4 STA $d405 
1cfa : a9 f1 __ LDA #$f1
1cfc : 8d 06 d4 STA $d406 
1cff : a9 81 __ LDA #$81
1d01 : 8d 04 d4 STA $d404 
.l109:
1d04 : ad 11 d0 LDA $d011 
1d07 : 30 fb __ BMI $1d04 ; (check_shot_enemy_collision.l109 + 0)
.l27:
1d09 : ad 11 d0 LDA $d011 
1d0c : 10 fb __ BPL $1d09 ; (check_shot_enemy_collision.l27 + 0)
.s21:
1d0e : e6 44 __ INC T3 + 0 
1d10 : a5 44 __ LDA T3 + 0 
1d12 : c9 08 __ CMP #$08
1d14 : 90 8f __ BCC $1ca5 ; (check_shot_enemy_collision.l20 + 0)
.s22:
1d16 : a9 08 __ LDA #$08
1d18 : 8d 04 d4 STA $d404 
1d1b : a6 1e __ LDX ACCU + 3 
1d1d : bd b7 26 LDA $26b7,x ; (Enemy + 1)
1d20 : 0a __ __ ASL
1d21 : 85 1b __ STA ACCU + 0 
1d23 : a9 00 __ LDA #$00
1d25 : 2a __ __ ROL
1d26 : 06 1b __ ASL ACCU + 0 
1d28 : 2a __ __ ROL
1d29 : a8 __ __ TAY
1d2a : a5 1b __ LDA ACCU + 0 
1d2c : 7d b7 26 ADC $26b7,x ; (Enemy + 1)
1d2f : 85 1b __ STA ACCU + 0 
1d31 : 98 __ __ TYA
1d32 : 69 00 __ ADC #$00
1d34 : 06 1b __ ASL ACCU + 0 
1d36 : 2a __ __ ROL
1d37 : 06 1b __ ASL ACCU + 0 
1d39 : 2a __ __ ROL
1d3a : 06 1b __ ASL ACCU + 0 
1d3c : 2a __ __ ROL
1d3d : a8 __ __ TAY
1d3e : 18 __ __ CLC
1d3f : a5 1b __ LDA ACCU + 0 
1d41 : 7d b6 26 ADC $26b6,x ; (Enemy + 0)
1d44 : 85 44 __ STA T3 + 0 
1d46 : 85 1f __ STA ADDR + 0 
1d48 : 98 __ __ TYA
1d49 : 69 c0 __ ADC #$c0
1d4b : 85 45 __ STA T3 + 1 
1d4d : 18 __ __ CLC
1d4e : 69 18 __ ADC #$18
1d50 : 85 20 __ STA ADDR + 1 
1d52 : a9 20 __ LDA #$20
1d54 : a0 00 __ LDY #$00
1d56 : 91 44 __ STA (T3 + 0),y 
1d58 : 98 __ __ TYA
1d59 : 91 1f __ STA (ADDR + 0),y 
1d5b : 9d ba 26 STA $26ba,x ; (Enemy + 4)
1d5e : a6 1d __ LDX ACCU + 2 
1d60 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1d63 : 99 ea 26 STA $26ea,y ; (PlayerShot + 2)
1d66 : a6 1e __ LDX ACCU + 3 
1d68 : bd b8 26 LDA $26b8,x ; (Enemy + 2)
1d6b : c9 83 __ CMP #$83
1d6d : f0 2b __ BEQ $1d9a ; (check_shot_enemy_collision.s30 + 0)
.s31:
1d6f : c9 84 __ CMP #$84
1d71 : f0 03 __ BEQ $1d76 ; (check_shot_enemy_collision.s33 + 0)
1d73 : 4c 92 1c JMP $1c92 ; (check_shot_enemy_collision.s114 + 0)
.s33:
1d76 : ad a1 26 LDA $26a1 ; (game + 1)
1d79 : 18 __ __ CLC
1d7a : 69 19 __ ADC #$19
.s118:
1d7c : 8d a1 26 STA $26a1 ; (game + 1)
1d7f : ad a2 26 LDA $26a2 ; (game + 2)
1d82 : 69 00 __ ADC #$00
1d84 : 8d a2 26 STA $26a2 ; (game + 2)
1d87 : ad a3 26 LDA $26a3 ; (game + 3)
1d8a : 69 00 __ ADC #$00
1d8c : 8d a3 26 STA $26a3 ; (game + 3)
1d8f : b0 03 __ BCS $1d94 ; (check_shot_enemy_collision.s1019 + 0)
1d91 : 4c 92 1c JMP $1c92 ; (check_shot_enemy_collision.s114 + 0)
.s1019:
1d94 : ee a4 26 INC $26a4 ; (game + 4)
1d97 : 4c 92 1c JMP $1c92 ; (check_shot_enemy_collision.s114 + 0)
.s30:
1d9a : ad a1 26 LDA $26a1 ; (game + 1)
1d9d : 18 __ __ CLC
1d9e : 69 32 __ ADC #$32
1da0 : 4c 7c 1d JMP $1d7c ; (check_shot_enemy_collision.s118 + 0)
--------------------------------------------------------------------
move_enemy_shots:
.s0:
1da3 : a2 00 __ LDX #$00
.l1008:
1da5 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1da8 : b9 f3 26 LDA $26f3,y ; (EnemyShot + 2)
1dab : c9 01 __ CMP #$01
1dad : d0 58 __ BNE $1e07 ; (move_enemy_shots.s23 + 0)
.s5:
1daf : 84 1d __ STY ACCU + 2 
1db1 : b9 f2 26 LDA $26f2,y ; (EnemyShot + 1)
1db4 : 0a __ __ ASL
1db5 : 85 1b __ STA ACCU + 0 
1db7 : a9 00 __ LDA #$00
1db9 : 2a __ __ ROL
1dba : 06 1b __ ASL ACCU + 0 
1dbc : 2a __ __ ROL
1dbd : 85 1c __ STA ACCU + 1 
1dbf : a5 1b __ LDA ACCU + 0 
1dc1 : 79 f2 26 ADC $26f2,y ; (EnemyShot + 1)
1dc4 : 85 1b __ STA ACCU + 0 
1dc6 : a5 1c __ LDA ACCU + 1 
1dc8 : 69 00 __ ADC #$00
1dca : 06 1b __ ASL ACCU + 0 
1dcc : 2a __ __ ROL
1dcd : 06 1b __ ASL ACCU + 0 
1dcf : 2a __ __ ROL
1dd0 : 06 1b __ ASL ACCU + 0 
1dd2 : 2a __ __ ROL
1dd3 : 85 1c __ STA ACCU + 1 
1dd5 : b9 f1 26 LDA $26f1,y ; (EnemyShot + 0)
1dd8 : 85 1e __ STA ACCU + 3 
1dda : 18 __ __ CLC
1ddb : 65 1b __ ADC ACCU + 0 
1ddd : 85 1b __ STA ACCU + 0 
1ddf : 85 1f __ STA ADDR + 0 
1de1 : a5 1c __ LDA ACCU + 1 
1de3 : 69 c0 __ ADC #$c0
1de5 : 85 1c __ STA ACCU + 1 
1de7 : 18 __ __ CLC
1de8 : 69 18 __ ADC #$18
1dea : 85 20 __ STA ADDR + 1 
1dec : a9 20 __ LDA #$20
1dee : a0 00 __ LDY #$00
1df0 : 91 1b __ STA (ACCU + 0),y 
1df2 : 98 __ __ TYA
1df3 : 91 1f __ STA (ADDR + 0),y 
1df5 : c6 1e __ DEC ACCU + 3 
1df7 : a5 1e __ LDA ACCU + 3 
1df9 : a4 1d __ LDY ACCU + 2 
1dfb : 99 f1 26 STA $26f1,y ; (EnemyShot + 0)
1dfe : c9 ff __ CMP #$ff
1e00 : d0 05 __ BNE $1e07 ; (move_enemy_shots.s23 + 0)
.s8:
1e02 : a9 00 __ LDA #$00
1e04 : 99 f3 26 STA $26f3,y ; (EnemyShot + 2)
.s23:
1e07 : e8 __ __ INX
1e08 : e0 03 __ CPX #$03
1e0a : 90 99 __ BCC $1da5 ; (move_enemy_shots.l1008 + 0)
.s1001:
1e0c : 60 __ __ RTS
--------------------------------------------------------------------
check_player_enemy_collision:
.s0:
1e0d : a0 00 __ LDY #$00
.l2:
1e0f : be f4 25 LDX $25f4,y ; (__multab5L + 0)
1e12 : bd ba 26 LDA $26ba,x ; (Enemy + 4)
1e15 : c9 01 __ CMP #$01
1e17 : d0 10 __ BNE $1e29 ; (check_player_enemy_collision.s3 + 0)
.s5:
1e19 : bd b6 26 LDA $26b6,x ; (Enemy + 0)
1e1c : cd b0 26 CMP $26b0 ; (Player + 0)
1e1f : d0 08 __ BNE $1e29 ; (check_player_enemy_collision.s3 + 0)
.s11:
1e21 : bd b7 26 LDA $26b7,x ; (Enemy + 1)
1e24 : cd b1 26 CMP $26b1 ; (Player + 1)
1e27 : f0 30 __ BEQ $1e59 ; (check_player_enemy_collision.s8 + 0)
.s3:
1e29 : c8 __ __ INY
1e2a : c0 0a __ CPY #$0a
1e2c : 90 e1 __ BCC $1e0f ; (check_player_enemy_collision.l2 + 0)
.s4:
1e2e : a0 00 __ LDY #$00
.l13:
1e30 : be fd 08 LDX $08fd,y ; (__multab3L + 0)
1e33 : bd f3 26 LDA $26f3,x ; (EnemyShot + 2)
1e36 : c9 01 __ CMP #$01
1e38 : d0 10 __ BNE $1e4a ; (check_player_enemy_collision.s14 + 0)
.s16:
1e3a : bd f1 26 LDA $26f1,x ; (EnemyShot + 0)
1e3d : cd b0 26 CMP $26b0 ; (Player + 0)
1e40 : d0 08 __ BNE $1e4a ; (check_player_enemy_collision.s14 + 0)
.s22:
1e42 : bd f2 26 LDA $26f2,x ; (EnemyShot + 1)
1e45 : cd b1 26 CMP $26b1 ; (Player + 1)
1e48 : f0 06 __ BEQ $1e50 ; (check_player_enemy_collision.s19 + 0)
.s14:
1e4a : c8 __ __ INY
1e4b : c0 03 __ CPY #$03
1e4d : 90 e1 __ BCC $1e30 ; (check_player_enemy_collision.l13 + 0)
.s1001:
1e4f : 60 __ __ RTS
.s19:
1e50 : 20 63 1e JSR $1e63 ; (render_player_dead.s0 + 0)
1e53 : a9 02 __ LDA #$02
1e55 : 8d a0 26 STA $26a0 ; (game + 0)
1e58 : 60 __ __ RTS
.s8:
1e59 : 20 63 1e JSR $1e63 ; (render_player_dead.s0 + 0)
1e5c : a9 02 __ LDA #$02
1e5e : 8d a0 26 STA $26a0 ; (game + 0)
1e61 : d0 cb __ BNE $1e2e ; (check_player_enemy_collision.s4 + 0)
--------------------------------------------------------------------
render_player_dead:
.s0:
1e63 : ad b1 26 LDA $26b1 ; (Player + 1)
1e66 : 85 1e __ STA ACCU + 3 
1e68 : ad b0 26 LDA $26b0 ; (Player + 0)
1e6b : 85 43 __ STA T2 + 0 
1e6d : a9 00 __ LDA #$00
1e6f : 85 1d __ STA ACCU + 2 
.l2:
1e71 : a9 ff __ LDA #$ff
1e73 : 85 44 __ STA T3 + 0 
.l6:
1e75 : 29 80 __ AND #$80
1e77 : 10 02 __ BPL $1e7b ; (render_player_dead.l6 + 6)
1e79 : a9 ff __ LDA #$ff
1e7b : aa __ __ TAX
1e7c : 18 __ __ CLC
1e7d : a5 44 __ LDA T3 + 0 
1e7f : 65 1e __ ADC ACCU + 3 
1e81 : a8 __ __ TAY
1e82 : 90 01 __ BCC $1e85 ; (render_player_dead.s1009 + 0)
.s1008:
1e84 : e8 __ __ INX
.s1009:
1e85 : 86 1c __ STX ACCU + 1 
1e87 : 0a __ __ ASL
1e88 : 85 1b __ STA ACCU + 0 
1e8a : 8a __ __ TXA
1e8b : 2a __ __ ROL
1e8c : 06 1b __ ASL ACCU + 0 
1e8e : 2a __ __ ROL
1e8f : aa __ __ TAX
1e90 : 98 __ __ TYA
1e91 : 18 __ __ CLC
1e92 : 65 1b __ ADC ACCU + 0 
1e94 : 85 1b __ STA ACCU + 0 
1e96 : 8a __ __ TXA
1e97 : 65 1c __ ADC ACCU + 1 
1e99 : 06 1b __ ASL ACCU + 0 
1e9b : 2a __ __ ROL
1e9c : 06 1b __ ASL ACCU + 0 
1e9e : 2a __ __ ROL
1e9f : 06 1b __ ASL ACCU + 0 
1ea1 : 2a __ __ ROL
1ea2 : aa __ __ TAX
1ea3 : 18 __ __ CLC
1ea4 : a9 ff __ LDA #$ff
1ea6 : 65 1b __ ADC ACCU + 0 
1ea8 : a8 __ __ TAY
1ea9 : 8a __ __ TXA
1eaa : 69 d7 __ ADC #$d7
1eac : aa __ __ TAX
1ead : 98 __ __ TYA
1eae : 18 __ __ CLC
1eaf : 65 43 __ ADC T2 + 0 
1eb1 : 85 1b __ STA ACCU + 0 
1eb3 : 85 45 __ STA T5 + 0 
1eb5 : 8a __ __ TXA
1eb6 : 69 00 __ ADC #$00
1eb8 : 85 1c __ STA ACCU + 1 
1eba : 18 __ __ CLC
1ebb : 69 e8 __ ADC #$e8
1ebd : 85 46 __ STA T5 + 1 
1ebf : a0 00 __ LDY #$00
1ec1 : a2 03 __ LDX #$03
.l1006:
1ec3 : a9 86 __ LDA #$86
1ec5 : 91 45 __ STA (T5 + 0),y 
1ec7 : a5 1d __ LDA ACCU + 2 
1ec9 : 91 1b __ STA (ACCU + 0),y 
1ecb : e6 45 __ INC T5 + 0 
1ecd : d0 02 __ BNE $1ed1 ; (render_player_dead.s1011 + 0)
.s1010:
1ecf : e6 46 __ INC T5 + 1 
.s1011:
1ed1 : e6 1b __ INC ACCU + 0 
1ed3 : d0 02 __ BNE $1ed7 ; (render_player_dead.s1013 + 0)
.s1012:
1ed5 : e6 1c __ INC ACCU + 1 
.s1013:
1ed7 : ca __ __ DEX
1ed8 : d0 e9 __ BNE $1ec3 ; (render_player_dead.l1006 + 0)
.s1007:
1eda : e6 44 __ INC T3 + 0 
1edc : a5 44 __ LDA T3 + 0 
1ede : c9 02 __ CMP #$02
1ee0 : 90 93 __ BCC $1e75 ; (render_player_dead.l6 + 0)
.l14:
1ee2 : ad 11 d0 LDA $d011 
1ee5 : 30 fb __ BMI $1ee2 ; (render_player_dead.l14 + 0)
.l17:
1ee7 : ad 11 d0 LDA $d011 
1eea : 10 fb __ BPL $1ee7 ; (render_player_dead.l17 + 0)
.s3:
1eec : e6 1d __ INC ACCU + 2 
1eee : a5 1d __ LDA ACCU + 2 
1ef0 : c9 1e __ CMP #$1e
1ef2 : b0 03 __ BCS $1ef7 ; (render_player_dead.s1001 + 0)
1ef4 : 4c 71 1e JMP $1e71 ; (render_player_dead.l2 + 0)
.s1001:
1ef7 : 60 __ __ RTS
--------------------------------------------------------------------
control_player_ship:
.s0:
1ef8 : a9 00 __ LDA #$00
1efa : 20 9c 1f JSR $1f9c ; (joy_poll.s0 + 0)
1efd : ad fc 26 LDA $26fc ; (joyx + 0)
1f00 : 85 1d __ STA ACCU + 2 
1f02 : 85 1e __ STA ACCU + 3 
1f04 : d0 08 __ BNE $1f0e ; (control_player_ship.s1 + 0)
.s4:
1f06 : ad fa 26 LDA $26fa ; (joyy + 0)
1f09 : d0 03 __ BNE $1f0e ; (control_player_ship.s1 + 0)
1f0b : 4c 91 1f JMP $1f91 ; (control_player_ship.s3 + 0)
.s1:
1f0e : ad b0 26 LDA $26b0 ; (Player + 0)
1f11 : 85 43 __ STA T2 + 0 
1f13 : 85 44 __ STA T3 + 0 
1f15 : ad b1 26 LDA $26b1 ; (Player + 1)
1f18 : 85 45 __ STA T4 + 0 
1f1a : 85 46 __ STA T5 + 0 
1f1c : 0a __ __ ASL
1f1d : 85 1b __ STA ACCU + 0 
1f1f : a9 00 __ LDA #$00
1f21 : 2a __ __ ROL
1f22 : 06 1b __ ASL ACCU + 0 
1f24 : 2a __ __ ROL
1f25 : aa __ __ TAX
1f26 : a5 1b __ LDA ACCU + 0 
1f28 : 65 45 __ ADC T4 + 0 
1f2a : 85 1b __ STA ACCU + 0 
1f2c : 8a __ __ TXA
1f2d : 69 00 __ ADC #$00
1f2f : 06 1b __ ASL ACCU + 0 
1f31 : 2a __ __ ROL
1f32 : 06 1b __ ASL ACCU + 0 
1f34 : 2a __ __ ROL
1f35 : 06 1b __ ASL ACCU + 0 
1f37 : 2a __ __ ROL
1f38 : aa __ __ TAX
1f39 : 18 __ __ CLC
1f3a : a5 1b __ LDA ACCU + 0 
1f3c : 65 43 __ ADC T2 + 0 
1f3e : 85 1b __ STA ACCU + 0 
1f40 : 85 1f __ STA ADDR + 0 
1f42 : 8a __ __ TXA
1f43 : 69 c0 __ ADC #$c0
1f45 : 85 1c __ STA ACCU + 1 
1f47 : 18 __ __ CLC
1f48 : 69 18 __ ADC #$18
1f4a : 85 20 __ STA ADDR + 1 
1f4c : a9 20 __ LDA #$20
1f4e : a0 00 __ LDY #$00
1f50 : 91 1b __ STA (ACCU + 0),y 
1f52 : 98 __ __ TYA
1f53 : 91 1f __ STA (ADDR + 0),y 
1f55 : a5 43 __ LDA T2 + 0 
1f57 : c9 02 __ CMP #$02
1f59 : 90 06 __ BCC $1f61 ; (control_player_ship.s6 + 0)
.s8:
1f5b : a5 1d __ LDA ACCU + 2 
1f5d : 30 0c __ BMI $1f6b ; (control_player_ship.s5 + 0)
.s1015:
1f5f : a5 43 __ LDA T2 + 0 
.s6:
1f61 : c9 26 __ CMP #$26
1f63 : b0 0e __ BCS $1f73 ; (control_player_ship.s7 + 0)
.s12:
1f65 : a5 1d __ LDA ACCU + 2 
1f67 : 30 0a __ BMI $1f73 ; (control_player_ship.s7 + 0)
.s1009:
1f69 : f0 08 __ BEQ $1f73 ; (control_player_ship.s7 + 0)
.s5:
1f6b : 18 __ __ CLC
1f6c : a5 44 __ LDA T3 + 0 
1f6e : 65 1e __ ADC ACCU + 3 
1f70 : 8d b0 26 STA $26b0 ; (Player + 0)
.s7:
1f73 : a5 45 __ LDA T4 + 0 
1f75 : c9 05 __ CMP #$05
1f77 : 90 07 __ BCC $1f80 ; (control_player_ship.s14 + 0)
.s16:
1f79 : ad fa 26 LDA $26fa ; (joyy + 0)
1f7c : 30 0d __ BMI $1f8b ; (control_player_ship.s32 + 0)
.s1014:
1f7e : a5 45 __ LDA T4 + 0 
.s14:
1f80 : c9 17 __ CMP #$17
1f82 : b0 0d __ BCS $1f91 ; (control_player_ship.s3 + 0)
.s20:
1f84 : ad fa 26 LDA $26fa ; (joyy + 0)
1f87 : 30 08 __ BMI $1f91 ; (control_player_ship.s3 + 0)
.s1004:
1f89 : f0 06 __ BEQ $1f91 ; (control_player_ship.s3 + 0)
.s32:
1f8b : 18 __ __ CLC
1f8c : 65 46 __ ADC T5 + 0 
1f8e : 8d b1 26 STA $26b1 ; (Player + 1)
.s3:
1f91 : ad fe 26 LDA $26fe ; (joyb + 0)
1f94 : c9 01 __ CMP #$01
1f96 : f0 01 __ BEQ $1f99 ; (control_player_ship.s21 + 0)
.s1001:
1f98 : 60 __ __ RTS
.s21:
1f99 : 4c dc 1f JMP $1fdc ; (spawn_player_shot.s0 + 0)
--------------------------------------------------------------------
joy_poll:
.s0:
1f9c : aa __ __ TAX
1f9d : bd 00 dc LDA $dc00,x 
1fa0 : a8 __ __ TAY
1fa1 : 29 10 __ AND #$10
1fa3 : f0 04 __ BEQ $1fa9 ; (joy_poll.s1005 + 0)
.s1006:
1fa5 : a9 00 __ LDA #$00
1fa7 : f0 02 __ BEQ $1fab ; (joy_poll.s1007 + 0)
.s1005:
1fa9 : a9 01 __ LDA #$01
.s1007:
1fab : 9d fe 26 STA $26fe,x ; (joyb + 0)
1fae : 98 __ __ TYA
1faf : 4a __ __ LSR
1fb0 : b0 1d __ BCS $1fcf ; (joy_poll.s2 + 0)
.s1:
1fb2 : a9 ff __ LDA #$ff
.s15:
1fb4 : 9d fa 26 STA $26fa,x ; (joyy + 0)
1fb7 : 98 __ __ TYA
1fb8 : 29 04 __ AND #$04
1fba : d0 06 __ BNE $1fc2 ; (joy_poll.s8 + 0)
.s7:
1fbc : a9 ff __ LDA #$ff
.s1001:
1fbe : 9d fc 26 STA $26fc,x ; (joyx + 0)
1fc1 : 60 __ __ RTS
.s8:
1fc2 : 98 __ __ TYA
1fc3 : 29 08 __ AND #$08
1fc5 : f0 04 __ BEQ $1fcb ; (joy_poll.s1011 + 0)
.s1012:
1fc7 : a9 00 __ LDA #$00
1fc9 : f0 f3 __ BEQ $1fbe ; (joy_poll.s1001 + 0)
.s1011:
1fcb : a9 01 __ LDA #$01
1fcd : d0 ef __ BNE $1fbe ; (joy_poll.s1001 + 0)
.s2:
1fcf : 98 __ __ TYA
1fd0 : 29 02 __ AND #$02
1fd2 : f0 04 __ BEQ $1fd8 ; (joy_poll.s1008 + 0)
.s1009:
1fd4 : a9 00 __ LDA #$00
1fd6 : f0 dc __ BEQ $1fb4 ; (joy_poll.s15 + 0)
.s1008:
1fd8 : a9 01 __ LDA #$01
1fda : d0 d8 __ BNE $1fb4 ; (joy_poll.s15 + 0)
--------------------------------------------------------------------
joyy:
26fa : __ __ __ BSS	2
--------------------------------------------------------------------
joyx:
26fc : __ __ __ BSS	2
--------------------------------------------------------------------
joyb:
26fe : __ __ __ BSS	2
--------------------------------------------------------------------
spawn_player_shot:
.s0:
1fdc : ad b0 26 LDA $26b0 ; (Player + 0)
1fdf : c9 26 __ CMP #$26
1fe1 : f0 0f __ BEQ $1ff2 ; (spawn_player_shot.s1001 + 0)
.s3:
1fe3 : a0 00 __ LDY #$00
.l6:
1fe5 : be fd 08 LDX $08fd,y ; (__multab3L + 0)
1fe8 : bd ea 26 LDA $26ea,x ; (PlayerShot + 2)
1feb : f0 06 __ BEQ $1ff3 ; (spawn_player_shot.s9 + 0)
.s7:
1fed : c8 __ __ INY
1fee : c0 03 __ CPY #$03
1ff0 : 90 f3 __ BCC $1fe5 ; (spawn_player_shot.l6 + 0)
.s1001:
1ff2 : 60 __ __ RTS
.s9:
1ff3 : a9 01 __ LDA #$01
1ff5 : 9d ea 26 STA $26ea,x ; (PlayerShot + 2)
1ff8 : ad b1 26 LDA $26b1 ; (Player + 1)
1ffb : 9d e9 26 STA $26e9,x ; (PlayerShot + 1)
1ffe : ad fc 26 LDA $26fc ; (joyx + 0)
2001 : 30 02 __ BMI $2005 ; (spawn_player_shot.s13 + 0)
.s1007:
2003 : d0 06 __ BNE $200b ; (spawn_player_shot.s12 + 0)
.s13:
2005 : ad b0 26 LDA $26b0 ; (Player + 0)
2008 : 4c 11 20 JMP $2011 ; (spawn_player_shot.s14 + 0)
.s12:
200b : ad b0 26 LDA $26b0 ; (Player + 0)
200e : 18 __ __ CLC
200f : 69 01 __ ADC #$01
.s14:
2011 : be fd 08 LDX $08fd,y ; (__multab3L + 0)
2014 : 9d e8 26 STA $26e8,x ; (PlayerShot + 0)
2017 : ad b5 26 LDA $26b5 ; (PlayerShotSound + 3)
201a : d0 d6 __ BNE $1ff2 ; (spawn_player_shot.s1001 + 0)
.s15:
201c : a9 01 __ LDA #$01
201e : 8d b5 26 STA $26b5 ; (PlayerShotSound + 3)
2021 : 60 __ __ RTS
--------------------------------------------------------------------
render_player_ship:
.s0:
2022 : ad b1 26 LDA $26b1 ; (Player + 1)
2025 : 0a __ __ ASL
2026 : 85 1b __ STA ACCU + 0 
2028 : a9 00 __ LDA #$00
202a : 2a __ __ ROL
202b : 06 1b __ ASL ACCU + 0 
202d : 2a __ __ ROL
202e : aa __ __ TAX
202f : a5 1b __ LDA ACCU + 0 
2031 : 6d b1 26 ADC $26b1 ; (Player + 1)
2034 : 85 1b __ STA ACCU + 0 
2036 : 8a __ __ TXA
2037 : 69 00 __ ADC #$00
2039 : 06 1b __ ASL ACCU + 0 
203b : 2a __ __ ROL
203c : 06 1b __ ASL ACCU + 0 
203e : 2a __ __ ROL
203f : 06 1b __ ASL ACCU + 0 
2041 : 2a __ __ ROL
2042 : aa __ __ TAX
2043 : 18 __ __ CLC
2044 : a5 1b __ LDA ACCU + 0 
2046 : 6d b0 26 ADC $26b0 ; (Player + 0)
2049 : 85 1b __ STA ACCU + 0 
204b : 85 1f __ STA ADDR + 0 
204d : 8a __ __ TXA
204e : 69 c0 __ ADC #$c0
2050 : 85 1c __ STA ACCU + 1 
2052 : 18 __ __ CLC
2053 : 69 18 __ ADC #$18
2055 : 85 20 __ STA ADDR + 1 
2057 : a9 80 __ LDA #$80
2059 : a0 00 __ LDY #$00
205b : 91 1b __ STA (ACCU + 0),y 
205d : a9 03 __ LDA #$03
205f : 91 1f __ STA (ADDR + 0),y 
.s1001:
2061 : 60 __ __ RTS
--------------------------------------------------------------------
move_player_shots:
.s0:
2062 : a2 00 __ LDX #$00
.l2:
2064 : 86 1d __ STX ACCU + 2 
2066 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
2069 : b9 ea 26 LDA $26ea,y ; (PlayerShot + 2)
206c : c9 01 __ CMP #$01
206e : d0 52 __ BNE $20c2 ; (move_player_shots.s23 + 0)
.s5:
2070 : 84 1e __ STY ACCU + 3 
2072 : b9 e9 26 LDA $26e9,y ; (PlayerShot + 1)
2075 : 0a __ __ ASL
2076 : 85 1b __ STA ACCU + 0 
2078 : a9 00 __ LDA #$00
207a : 2a __ __ ROL
207b : 06 1b __ ASL ACCU + 0 
207d : 2a __ __ ROL
207e : aa __ __ TAX
207f : a5 1b __ LDA ACCU + 0 
2081 : 79 e9 26 ADC $26e9,y ; (PlayerShot + 1)
2084 : 85 1b __ STA ACCU + 0 
2086 : 8a __ __ TXA
2087 : 69 00 __ ADC #$00
2089 : 06 1b __ ASL ACCU + 0 
208b : 2a __ __ ROL
208c : 06 1b __ ASL ACCU + 0 
208e : 2a __ __ ROL
208f : 06 1b __ ASL ACCU + 0 
2091 : 2a __ __ ROL
2092 : 85 1c __ STA ACCU + 1 
2094 : b9 e8 26 LDA $26e8,y ; (PlayerShot + 0)
2097 : aa __ __ TAX
2098 : 18 __ __ CLC
2099 : 65 1b __ ADC ACCU + 0 
209b : 85 1b __ STA ACCU + 0 
209d : 85 1f __ STA ADDR + 0 
209f : a5 1c __ LDA ACCU + 1 
20a1 : 69 c0 __ ADC #$c0
20a3 : 85 1c __ STA ACCU + 1 
20a5 : 18 __ __ CLC
20a6 : 69 18 __ ADC #$18
20a8 : 85 20 __ STA ADDR + 1 
20aa : a9 20 __ LDA #$20
20ac : a0 00 __ LDY #$00
20ae : 91 1b __ STA (ACCU + 0),y 
20b0 : 98 __ __ TYA
20b1 : 91 1f __ STA (ADDR + 0),y 
20b3 : e8 __ __ INX
20b4 : 8a __ __ TXA
20b5 : a6 1e __ LDX ACCU + 3 
20b7 : 9d e8 26 STA $26e8,x ; (PlayerShot + 0)
20ba : c9 27 __ CMP #$27
20bc : 90 04 __ BCC $20c2 ; (move_player_shots.s23 + 0)
.s8:
20be : 98 __ __ TYA
20bf : 9d ea 26 STA $26ea,x ; (PlayerShot + 2)
.s23:
20c2 : a6 1d __ LDX ACCU + 2 
20c4 : e8 __ __ INX
20c5 : e0 03 __ CPX #$03
20c7 : 90 9b __ BCC $2064 ; (move_player_shots.l2 + 0)
.s1001:
20c9 : 60 __ __ RTS
--------------------------------------------------------------------
render_player_shots:
.s0:
20ca : a2 00 __ LDX #$00
.l1006:
20cc : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
20cf : b9 ea 26 LDA $26ea,y ; (PlayerShot + 2)
20d2 : c9 01 __ CMP #$01
20d4 : d0 43 __ BNE $2119 ; (render_player_shots.s19 + 0)
.s5:
20d6 : b9 e9 26 LDA $26e9,y ; (PlayerShot + 1)
20d9 : 0a __ __ ASL
20da : 85 1b __ STA ACCU + 0 
20dc : a9 00 __ LDA #$00
20de : 2a __ __ ROL
20df : 06 1b __ ASL ACCU + 0 
20e1 : 2a __ __ ROL
20e2 : 85 1c __ STA ACCU + 1 
20e4 : a5 1b __ LDA ACCU + 0 
20e6 : 79 e9 26 ADC $26e9,y ; (PlayerShot + 1)
20e9 : 85 1b __ STA ACCU + 0 
20eb : a5 1c __ LDA ACCU + 1 
20ed : 69 00 __ ADC #$00
20ef : 06 1b __ ASL ACCU + 0 
20f1 : 2a __ __ ROL
20f2 : 06 1b __ ASL ACCU + 0 
20f4 : 2a __ __ ROL
20f5 : 06 1b __ ASL ACCU + 0 
20f7 : 2a __ __ ROL
20f8 : 85 1c __ STA ACCU + 1 
20fa : 18 __ __ CLC
20fb : a5 1b __ LDA ACCU + 0 
20fd : 79 e8 26 ADC $26e8,y ; (PlayerShot + 0)
2100 : 85 1b __ STA ACCU + 0 
2102 : 85 1f __ STA ADDR + 0 
2104 : a5 1c __ LDA ACCU + 1 
2106 : 69 c0 __ ADC #$c0
2108 : 85 1c __ STA ACCU + 1 
210a : 18 __ __ CLC
210b : 69 18 __ ADC #$18
210d : 85 20 __ STA ADDR + 1 
210f : a9 81 __ LDA #$81
2111 : a0 00 __ LDY #$00
2113 : 91 1b __ STA (ACCU + 0),y 
2115 : a9 01 __ LDA #$01
2117 : 91 1f __ STA (ADDR + 0),y 
.s19:
2119 : e8 __ __ INX
211a : e0 03 __ CPX #$03
211c : 90 ae __ BCC $20cc ; (render_player_shots.l1006 + 0)
.s1001:
211e : 60 __ __ RTS
--------------------------------------------------------------------
wait_frames:
.s0:
211f : a5 0e __ LDA P1 ; (frames + 1)
2121 : 30 1c __ BMI $213f ; (wait_frames.s1001 + 0)
.s1005:
2123 : 05 0d __ ORA P0 ; (frames + 0)
2125 : f0 18 __ BEQ $213f ; (wait_frames.s1001 + 0)
.s13:
2127 : a0 00 __ LDY #$00
2129 : a6 0e __ LDX P1 ; (frames + 1)
.l6:
212b : ad 11 d0 LDA $d011 
212e : 30 fb __ BMI $212b ; (wait_frames.l6 + 0)
.l9:
2130 : ad 11 d0 LDA $d011 
2133 : 10 fb __ BPL $2130 ; (wait_frames.l9 + 0)
.s3:
2135 : c8 __ __ INY
2136 : 8a __ __ TXA
2137 : 30 06 __ BMI $213f ; (wait_frames.s1001 + 0)
.s1004:
2139 : d0 f0 __ BNE $212b ; (wait_frames.l6 + 0)
.s1002:
213b : c4 0d __ CPY P0 ; (frames + 0)
213d : 90 ec __ BCC $212b ; (wait_frames.l6 + 0)
.s1001:
213f : 60 __ __ RTS
--------------------------------------------------------------------
freg:
2140 : b1 19 __ LDA (IP + 0),y 
2142 : c8 __ __ INY
2143 : aa __ __ TAX
2144 : b5 00 __ LDA $00,x 
2146 : 85 03 __ STA WORK + 0 
2148 : b5 01 __ LDA $01,x 
214a : 85 04 __ STA WORK + 1 
214c : b5 02 __ LDA $02,x 
214e : 85 05 __ STA WORK + 2 
2150 : b5 03 __ LDA WORK + 0,x 
2152 : 85 06 __ STA WORK + 3 
2154 : a5 05 __ LDA WORK + 2 
2156 : 0a __ __ ASL
2157 : a5 06 __ LDA WORK + 3 
2159 : 2a __ __ ROL
215a : 85 08 __ STA WORK + 5 
215c : f0 06 __ BEQ $2164 ; (freg + 36)
215e : a5 05 __ LDA WORK + 2 
2160 : 09 80 __ ORA #$80
2162 : 85 05 __ STA WORK + 2 
2164 : a5 1d __ LDA ACCU + 2 
2166 : 0a __ __ ASL
2167 : a5 1e __ LDA ACCU + 3 
2169 : 2a __ __ ROL
216a : 85 07 __ STA WORK + 4 
216c : f0 06 __ BEQ $2174 ; (freg + 52)
216e : a5 1d __ LDA ACCU + 2 
2170 : 09 80 __ ORA #$80
2172 : 85 1d __ STA ACCU + 2 
2174 : 60 __ __ RTS
2175 : 06 1e __ ASL ACCU + 3 
2177 : a5 07 __ LDA WORK + 4 
2179 : 6a __ __ ROR
217a : 85 1e __ STA ACCU + 3 
217c : b0 06 __ BCS $2184 ; (freg + 68)
217e : a5 1d __ LDA ACCU + 2 
2180 : 29 7f __ AND #$7f
2182 : 85 1d __ STA ACCU + 2 
2184 : 60 __ __ RTS
--------------------------------------------------------------------
faddsub:
2185 : a9 ff __ LDA #$ff
2187 : c5 07 __ CMP WORK + 4 
2189 : f0 04 __ BEQ $218f ; (faddsub + 10)
218b : c5 08 __ CMP WORK + 5 
218d : d0 11 __ BNE $21a0 ; (faddsub + 27)
218f : a5 1e __ LDA ACCU + 3 
2191 : 09 7f __ ORA #$7f
2193 : 85 1e __ STA ACCU + 3 
2195 : a9 80 __ LDA #$80
2197 : 85 1d __ STA ACCU + 2 
2199 : a9 00 __ LDA #$00
219b : 85 1b __ STA ACCU + 0 
219d : 85 1c __ STA ACCU + 1 
219f : 60 __ __ RTS
21a0 : 38 __ __ SEC
21a1 : a5 07 __ LDA WORK + 4 
21a3 : e5 08 __ SBC WORK + 5 
21a5 : f0 38 __ BEQ $21df ; (faddsub + 90)
21a7 : aa __ __ TAX
21a8 : b0 25 __ BCS $21cf ; (faddsub + 74)
21aa : e0 e9 __ CPX #$e9
21ac : b0 0e __ BCS $21bc ; (faddsub + 55)
21ae : a5 08 __ LDA WORK + 5 
21b0 : 85 07 __ STA WORK + 4 
21b2 : a9 00 __ LDA #$00
21b4 : 85 1b __ STA ACCU + 0 
21b6 : 85 1c __ STA ACCU + 1 
21b8 : 85 1d __ STA ACCU + 2 
21ba : f0 23 __ BEQ $21df ; (faddsub + 90)
21bc : a5 1d __ LDA ACCU + 2 
21be : 4a __ __ LSR
21bf : 66 1c __ ROR ACCU + 1 
21c1 : 66 1b __ ROR ACCU + 0 
21c3 : e8 __ __ INX
21c4 : d0 f8 __ BNE $21be ; (faddsub + 57)
21c6 : 85 1d __ STA ACCU + 2 
21c8 : a5 08 __ LDA WORK + 5 
21ca : 85 07 __ STA WORK + 4 
21cc : 4c df 21 JMP $21df ; (faddsub + 90)
21cf : e0 18 __ CPX #$18
21d1 : b0 33 __ BCS $2206 ; (faddsub + 129)
21d3 : a5 05 __ LDA WORK + 2 
21d5 : 4a __ __ LSR
21d6 : 66 04 __ ROR WORK + 1 
21d8 : 66 03 __ ROR WORK + 0 
21da : ca __ __ DEX
21db : d0 f8 __ BNE $21d5 ; (faddsub + 80)
21dd : 85 05 __ STA WORK + 2 
21df : a5 1e __ LDA ACCU + 3 
21e1 : 29 80 __ AND #$80
21e3 : 85 1e __ STA ACCU + 3 
21e5 : 45 06 __ EOR WORK + 3 
21e7 : 30 31 __ BMI $221a ; (faddsub + 149)
21e9 : 18 __ __ CLC
21ea : a5 1b __ LDA ACCU + 0 
21ec : 65 03 __ ADC WORK + 0 
21ee : 85 1b __ STA ACCU + 0 
21f0 : a5 1c __ LDA ACCU + 1 
21f2 : 65 04 __ ADC WORK + 1 
21f4 : 85 1c __ STA ACCU + 1 
21f6 : a5 1d __ LDA ACCU + 2 
21f8 : 65 05 __ ADC WORK + 2 
21fa : 85 1d __ STA ACCU + 2 
21fc : 90 08 __ BCC $2206 ; (faddsub + 129)
21fe : 66 1d __ ROR ACCU + 2 
2200 : 66 1c __ ROR ACCU + 1 
2202 : 66 1b __ ROR ACCU + 0 
2204 : e6 07 __ INC WORK + 4 
2206 : a5 07 __ LDA WORK + 4 
2208 : c9 ff __ CMP #$ff
220a : f0 83 __ BEQ $218f ; (faddsub + 10)
220c : 4a __ __ LSR
220d : 05 1e __ ORA ACCU + 3 
220f : 85 1e __ STA ACCU + 3 
2211 : b0 06 __ BCS $2219 ; (faddsub + 148)
2213 : a5 1d __ LDA ACCU + 2 
2215 : 29 7f __ AND #$7f
2217 : 85 1d __ STA ACCU + 2 
2219 : 60 __ __ RTS
221a : 38 __ __ SEC
221b : a5 1b __ LDA ACCU + 0 
221d : e5 03 __ SBC WORK + 0 
221f : 85 1b __ STA ACCU + 0 
2221 : a5 1c __ LDA ACCU + 1 
2223 : e5 04 __ SBC WORK + 1 
2225 : 85 1c __ STA ACCU + 1 
2227 : a5 1d __ LDA ACCU + 2 
2229 : e5 05 __ SBC WORK + 2 
222b : 85 1d __ STA ACCU + 2 
222d : b0 19 __ BCS $2248 ; (faddsub + 195)
222f : 38 __ __ SEC
2230 : a9 00 __ LDA #$00
2232 : e5 1b __ SBC ACCU + 0 
2234 : 85 1b __ STA ACCU + 0 
2236 : a9 00 __ LDA #$00
2238 : e5 1c __ SBC ACCU + 1 
223a : 85 1c __ STA ACCU + 1 
223c : a9 00 __ LDA #$00
223e : e5 1d __ SBC ACCU + 2 
2240 : 85 1d __ STA ACCU + 2 
2242 : a5 1e __ LDA ACCU + 3 
2244 : 49 80 __ EOR #$80
2246 : 85 1e __ STA ACCU + 3 
2248 : a5 1d __ LDA ACCU + 2 
224a : 30 ba __ BMI $2206 ; (faddsub + 129)
224c : 05 1c __ ORA ACCU + 1 
224e : 05 1b __ ORA ACCU + 0 
2250 : f0 0f __ BEQ $2261 ; (faddsub + 220)
2252 : c6 07 __ DEC WORK + 4 
2254 : f0 0b __ BEQ $2261 ; (faddsub + 220)
2256 : 06 1b __ ASL ACCU + 0 
2258 : 26 1c __ ROL ACCU + 1 
225a : 26 1d __ ROL ACCU + 2 
225c : 10 f4 __ BPL $2252 ; (faddsub + 205)
225e : 4c 06 22 JMP $2206 ; (faddsub + 129)
2261 : a9 00 __ LDA #$00
2263 : 85 1b __ STA ACCU + 0 
2265 : 85 1c __ STA ACCU + 1 
2267 : 85 1d __ STA ACCU + 2 
2269 : 85 1e __ STA ACCU + 3 
226b : 60 __ __ RTS
--------------------------------------------------------------------
fmul:
226c : a5 1b __ LDA ACCU + 0 
226e : 05 1c __ ORA ACCU + 1 
2270 : 05 1d __ ORA ACCU + 2 
2272 : d0 03 __ BNE $2277 ; (fmul + 11)
2274 : 85 1e __ STA ACCU + 3 
2276 : 60 __ __ RTS
2277 : a5 03 __ LDA WORK + 0 
2279 : 05 04 __ ORA WORK + 1 
227b : 05 05 __ ORA WORK + 2 
227d : d0 09 __ BNE $2288 ; (fmul + 28)
227f : 85 1b __ STA ACCU + 0 
2281 : 85 1c __ STA ACCU + 1 
2283 : 85 1d __ STA ACCU + 2 
2285 : 85 1e __ STA ACCU + 3 
2287 : 60 __ __ RTS
2288 : a5 1e __ LDA ACCU + 3 
228a : 45 06 __ EOR WORK + 3 
228c : 29 80 __ AND #$80
228e : 85 1e __ STA ACCU + 3 
2290 : a9 ff __ LDA #$ff
2292 : c5 07 __ CMP WORK + 4 
2294 : f0 42 __ BEQ $22d8 ; (fmul + 108)
2296 : c5 08 __ CMP WORK + 5 
2298 : f0 3e __ BEQ $22d8 ; (fmul + 108)
229a : a9 00 __ LDA #$00
229c : 85 09 __ STA WORK + 6 
229e : 85 0a __ STA WORK + 7 
22a0 : 85 0b __ STA $0b 
22a2 : a4 1b __ LDY ACCU + 0 
22a4 : a5 03 __ LDA WORK + 0 
22a6 : d0 06 __ BNE $22ae ; (fmul + 66)
22a8 : a5 04 __ LDA WORK + 1 
22aa : f0 0a __ BEQ $22b6 ; (fmul + 74)
22ac : d0 05 __ BNE $22b3 ; (fmul + 71)
22ae : 20 0d 23 JSR $230d ; (fmul8 + 0)
22b1 : a5 04 __ LDA WORK + 1 
22b3 : 20 0d 23 JSR $230d ; (fmul8 + 0)
22b6 : a5 05 __ LDA WORK + 2 
22b8 : 20 0d 23 JSR $230d ; (fmul8 + 0)
22bb : 38 __ __ SEC
22bc : a5 0b __ LDA $0b 
22be : 30 06 __ BMI $22c6 ; (fmul + 90)
22c0 : 06 09 __ ASL WORK + 6 
22c2 : 26 0a __ ROL WORK + 7 
22c4 : 2a __ __ ROL
22c5 : 18 __ __ CLC
22c6 : 29 7f __ AND #$7f
22c8 : 85 0b __ STA $0b 
22ca : a5 07 __ LDA WORK + 4 
22cc : 65 08 __ ADC WORK + 5 
22ce : 90 19 __ BCC $22e9 ; (fmul + 125)
22d0 : e9 7f __ SBC #$7f
22d2 : b0 04 __ BCS $22d8 ; (fmul + 108)
22d4 : c9 ff __ CMP #$ff
22d6 : d0 15 __ BNE $22ed ; (fmul + 129)
22d8 : a5 1e __ LDA ACCU + 3 
22da : 09 7f __ ORA #$7f
22dc : 85 1e __ STA ACCU + 3 
22de : a9 80 __ LDA #$80
22e0 : 85 1d __ STA ACCU + 2 
22e2 : a9 00 __ LDA #$00
22e4 : 85 1b __ STA ACCU + 0 
22e6 : 85 1c __ STA ACCU + 1 
22e8 : 60 __ __ RTS
22e9 : e9 7e __ SBC #$7e
22eb : 90 15 __ BCC $2302 ; (fmul + 150)
22ed : 4a __ __ LSR
22ee : 05 1e __ ORA ACCU + 3 
22f0 : 85 1e __ STA ACCU + 3 
22f2 : a9 00 __ LDA #$00
22f4 : 6a __ __ ROR
22f5 : 05 0b __ ORA $0b 
22f7 : 85 1d __ STA ACCU + 2 
22f9 : a5 0a __ LDA WORK + 7 
22fb : 85 1c __ STA ACCU + 1 
22fd : a5 09 __ LDA WORK + 6 
22ff : 85 1b __ STA ACCU + 0 
2301 : 60 __ __ RTS
2302 : a9 00 __ LDA #$00
2304 : 85 1b __ STA ACCU + 0 
2306 : 85 1c __ STA ACCU + 1 
2308 : 85 1d __ STA ACCU + 2 
230a : 85 1e __ STA ACCU + 3 
230c : 60 __ __ RTS
--------------------------------------------------------------------
fmul8:
230d : 38 __ __ SEC
230e : 6a __ __ ROR
230f : 90 1e __ BCC $232f ; (fmul8 + 34)
2311 : aa __ __ TAX
2312 : 18 __ __ CLC
2313 : 98 __ __ TYA
2314 : 65 09 __ ADC WORK + 6 
2316 : 85 09 __ STA WORK + 6 
2318 : a5 0a __ LDA WORK + 7 
231a : 65 1c __ ADC ACCU + 1 
231c : 85 0a __ STA WORK + 7 
231e : a5 0b __ LDA $0b 
2320 : 65 1d __ ADC ACCU + 2 
2322 : 6a __ __ ROR
2323 : 85 0b __ STA $0b 
2325 : 8a __ __ TXA
2326 : 66 0a __ ROR WORK + 7 
2328 : 66 09 __ ROR WORK + 6 
232a : 4a __ __ LSR
232b : f0 0d __ BEQ $233a ; (fmul8 + 45)
232d : b0 e2 __ BCS $2311 ; (fmul8 + 4)
232f : 66 0b __ ROR $0b 
2331 : 66 0a __ ROR WORK + 7 
2333 : 66 09 __ ROR WORK + 6 
2335 : 4a __ __ LSR
2336 : 90 f7 __ BCC $232f ; (fmul8 + 34)
2338 : d0 d7 __ BNE $2311 ; (fmul8 + 4)
233a : 60 __ __ RTS
--------------------------------------------------------------------
fdiv:
233b : a5 1b __ LDA ACCU + 0 
233d : 05 1c __ ORA ACCU + 1 
233f : 05 1d __ ORA ACCU + 2 
2341 : d0 03 __ BNE $2346 ; (fdiv + 11)
2343 : 85 1e __ STA ACCU + 3 
2345 : 60 __ __ RTS
2346 : a5 1e __ LDA ACCU + 3 
2348 : 45 06 __ EOR WORK + 3 
234a : 29 80 __ AND #$80
234c : 85 1e __ STA ACCU + 3 
234e : a5 08 __ LDA WORK + 5 
2350 : f0 62 __ BEQ $23b4 ; (fdiv + 121)
2352 : a5 07 __ LDA WORK + 4 
2354 : c9 ff __ CMP #$ff
2356 : f0 5c __ BEQ $23b4 ; (fdiv + 121)
2358 : a9 00 __ LDA #$00
235a : 85 09 __ STA WORK + 6 
235c : 85 0a __ STA WORK + 7 
235e : 85 0b __ STA $0b 
2360 : a2 18 __ LDX #$18
2362 : a5 1b __ LDA ACCU + 0 
2364 : c5 03 __ CMP WORK + 0 
2366 : a5 1c __ LDA ACCU + 1 
2368 : e5 04 __ SBC WORK + 1 
236a : a5 1d __ LDA ACCU + 2 
236c : e5 05 __ SBC WORK + 2 
236e : 90 13 __ BCC $2383 ; (fdiv + 72)
2370 : a5 1b __ LDA ACCU + 0 
2372 : e5 03 __ SBC WORK + 0 
2374 : 85 1b __ STA ACCU + 0 
2376 : a5 1c __ LDA ACCU + 1 
2378 : e5 04 __ SBC WORK + 1 
237a : 85 1c __ STA ACCU + 1 
237c : a5 1d __ LDA ACCU + 2 
237e : e5 05 __ SBC WORK + 2 
2380 : 85 1d __ STA ACCU + 2 
2382 : 38 __ __ SEC
2383 : 26 09 __ ROL WORK + 6 
2385 : 26 0a __ ROL WORK + 7 
2387 : 26 0b __ ROL $0b 
2389 : ca __ __ DEX
238a : f0 0a __ BEQ $2396 ; (fdiv + 91)
238c : 06 1b __ ASL ACCU + 0 
238e : 26 1c __ ROL ACCU + 1 
2390 : 26 1d __ ROL ACCU + 2 
2392 : b0 dc __ BCS $2370 ; (fdiv + 53)
2394 : 90 cc __ BCC $2362 ; (fdiv + 39)
2396 : 38 __ __ SEC
2397 : a5 0b __ LDA $0b 
2399 : 30 06 __ BMI $23a1 ; (fdiv + 102)
239b : 06 09 __ ASL WORK + 6 
239d : 26 0a __ ROL WORK + 7 
239f : 2a __ __ ROL
23a0 : 18 __ __ CLC
23a1 : 29 7f __ AND #$7f
23a3 : 85 0b __ STA $0b 
23a5 : a5 07 __ LDA WORK + 4 
23a7 : e5 08 __ SBC WORK + 5 
23a9 : 90 1a __ BCC $23c5 ; (fdiv + 138)
23ab : 18 __ __ CLC
23ac : 69 7f __ ADC #$7f
23ae : b0 04 __ BCS $23b4 ; (fdiv + 121)
23b0 : c9 ff __ CMP #$ff
23b2 : d0 15 __ BNE $23c9 ; (fdiv + 142)
23b4 : a5 1e __ LDA ACCU + 3 
23b6 : 09 7f __ ORA #$7f
23b8 : 85 1e __ STA ACCU + 3 
23ba : a9 80 __ LDA #$80
23bc : 85 1d __ STA ACCU + 2 
23be : a9 00 __ LDA #$00
23c0 : 85 1c __ STA ACCU + 1 
23c2 : 85 1b __ STA ACCU + 0 
23c4 : 60 __ __ RTS
23c5 : 69 7f __ ADC #$7f
23c7 : 90 15 __ BCC $23de ; (fdiv + 163)
23c9 : 4a __ __ LSR
23ca : 05 1e __ ORA ACCU + 3 
23cc : 85 1e __ STA ACCU + 3 
23ce : a9 00 __ LDA #$00
23d0 : 6a __ __ ROR
23d1 : 05 0b __ ORA $0b 
23d3 : 85 1d __ STA ACCU + 2 
23d5 : a5 0a __ LDA WORK + 7 
23d7 : 85 1c __ STA ACCU + 1 
23d9 : a5 09 __ LDA WORK + 6 
23db : 85 1b __ STA ACCU + 0 
23dd : 60 __ __ RTS
23de : a9 00 __ LDA #$00
23e0 : 85 1e __ STA ACCU + 3 
23e2 : 85 1d __ STA ACCU + 2 
23e4 : 85 1c __ STA ACCU + 1 
23e6 : 85 1b __ STA ACCU + 0 
23e8 : 60 __ __ RTS
--------------------------------------------------------------------
divs16:
23e9 : 24 1c __ BIT ACCU + 1 
23eb : 10 0d __ BPL $23fa ; (divs16 + 17)
23ed : 20 07 24 JSR $2407 ; (negaccu + 0)
23f0 : 24 04 __ BIT WORK + 1 
23f2 : 10 0d __ BPL $2401 ; (divs16 + 24)
23f4 : 20 15 24 JSR $2415 ; (negtmp + 0)
23f7 : 4c 23 24 JMP $2423 ; (divmod + 0)
23fa : 24 04 __ BIT WORK + 1 
23fc : 10 f9 __ BPL $23f7 ; (divs16 + 14)
23fe : 20 15 24 JSR $2415 ; (negtmp + 0)
2401 : 20 23 24 JSR $2423 ; (divmod + 0)
2404 : 4c 07 24 JMP $2407 ; (negaccu + 0)
--------------------------------------------------------------------
negaccu:
2407 : 38 __ __ SEC
2408 : a9 00 __ LDA #$00
240a : e5 1b __ SBC ACCU + 0 
240c : 85 1b __ STA ACCU + 0 
240e : a9 00 __ LDA #$00
2410 : e5 1c __ SBC ACCU + 1 
2412 : 85 1c __ STA ACCU + 1 
2414 : 60 __ __ RTS
--------------------------------------------------------------------
negtmp:
2415 : 38 __ __ SEC
2416 : a9 00 __ LDA #$00
2418 : e5 03 __ SBC WORK + 0 
241a : 85 03 __ STA WORK + 0 
241c : a9 00 __ LDA #$00
241e : e5 04 __ SBC WORK + 1 
2420 : 85 04 __ STA WORK + 1 
2422 : 60 __ __ RTS
--------------------------------------------------------------------
divmod:
2423 : a5 1c __ LDA ACCU + 1 
2425 : d0 31 __ BNE $2458 ; (divmod + 53)
2427 : a5 04 __ LDA WORK + 1 
2429 : d0 1e __ BNE $2449 ; (divmod + 38)
242b : 85 06 __ STA WORK + 3 
242d : a2 04 __ LDX #$04
242f : 06 1b __ ASL ACCU + 0 
2431 : 2a __ __ ROL
2432 : c5 03 __ CMP WORK + 0 
2434 : 90 02 __ BCC $2438 ; (divmod + 21)
2436 : e5 03 __ SBC WORK + 0 
2438 : 26 1b __ ROL ACCU + 0 
243a : 2a __ __ ROL
243b : c5 03 __ CMP WORK + 0 
243d : 90 02 __ BCC $2441 ; (divmod + 30)
243f : e5 03 __ SBC WORK + 0 
2441 : 26 1b __ ROL ACCU + 0 
2443 : ca __ __ DEX
2444 : d0 eb __ BNE $2431 ; (divmod + 14)
2446 : 85 05 __ STA WORK + 2 
2448 : 60 __ __ RTS
2449 : a5 1b __ LDA ACCU + 0 
244b : 85 05 __ STA WORK + 2 
244d : a5 1c __ LDA ACCU + 1 
244f : 85 06 __ STA WORK + 3 
2451 : a9 00 __ LDA #$00
2453 : 85 1b __ STA ACCU + 0 
2455 : 85 1c __ STA ACCU + 1 
2457 : 60 __ __ RTS
2458 : a5 04 __ LDA WORK + 1 
245a : d0 1f __ BNE $247b ; (divmod + 88)
245c : a5 03 __ LDA WORK + 0 
245e : 30 1b __ BMI $247b ; (divmod + 88)
2460 : a9 00 __ LDA #$00
2462 : 85 06 __ STA WORK + 3 
2464 : a2 10 __ LDX #$10
2466 : 06 1b __ ASL ACCU + 0 
2468 : 26 1c __ ROL ACCU + 1 
246a : 2a __ __ ROL
246b : c5 03 __ CMP WORK + 0 
246d : 90 02 __ BCC $2471 ; (divmod + 78)
246f : e5 03 __ SBC WORK + 0 
2471 : 26 1b __ ROL ACCU + 0 
2473 : 26 1c __ ROL ACCU + 1 
2475 : ca __ __ DEX
2476 : d0 f2 __ BNE $246a ; (divmod + 71)
2478 : 85 05 __ STA WORK + 2 
247a : 60 __ __ RTS
247b : a9 00 __ LDA #$00
247d : 85 05 __ STA WORK + 2 
247f : 85 06 __ STA WORK + 3 
2481 : 84 02 __ STY $02 
2483 : a0 10 __ LDY #$10
2485 : 18 __ __ CLC
2486 : 26 1b __ ROL ACCU + 0 
2488 : 26 1c __ ROL ACCU + 1 
248a : 26 05 __ ROL WORK + 2 
248c : 26 06 __ ROL WORK + 3 
248e : 38 __ __ SEC
248f : a5 05 __ LDA WORK + 2 
2491 : e5 03 __ SBC WORK + 0 
2493 : aa __ __ TAX
2494 : a5 06 __ LDA WORK + 3 
2496 : e5 04 __ SBC WORK + 1 
2498 : 90 04 __ BCC $249e ; (divmod + 123)
249a : 86 05 __ STX WORK + 2 
249c : 85 06 __ STA WORK + 3 
249e : 88 __ __ DEY
249f : d0 e5 __ BNE $2486 ; (divmod + 99)
24a1 : 26 1b __ ROL ACCU + 0 
24a3 : 26 1c __ ROL ACCU + 1 
24a5 : a4 02 __ LDY $02 
24a7 : 60 __ __ RTS
--------------------------------------------------------------------
mods16:
24a8 : 24 1c __ BIT ACCU + 1 
24aa : 10 0d __ BPL $24b9 ; (mods16 + 17)
24ac : 20 07 24 JSR $2407 ; (negaccu + 0)
24af : 24 04 __ BIT WORK + 1 
24b1 : 10 0d __ BPL $24c0 ; (mods16 + 24)
24b3 : 20 15 24 JSR $2415 ; (negtmp + 0)
24b6 : 4c 23 24 JMP $2423 ; (divmod + 0)
24b9 : 24 04 __ BIT WORK + 1 
24bb : 10 f9 __ BPL $24b6 ; (mods16 + 14)
24bd : 20 15 24 JSR $2415 ; (negtmp + 0)
24c0 : 20 23 24 JSR $2423 ; (divmod + 0)
24c3 : 38 __ __ SEC
24c4 : a9 00 __ LDA #$00
24c6 : e5 05 __ SBC WORK + 2 
24c8 : 85 05 __ STA WORK + 2 
24ca : a9 00 __ LDA #$00
24cc : e5 06 __ SBC WORK + 3 
24ce : 85 06 __ STA WORK + 3 
24d0 : 60 __ __ RTS
--------------------------------------------------------------------
f32_to_i16:
24d1 : 20 64 21 JSR $2164 ; (freg + 36)
24d4 : a5 07 __ LDA WORK + 4 
24d6 : c9 7f __ CMP #$7f
24d8 : b0 07 __ BCS $24e1 ; (f32_to_i16 + 16)
24da : a9 00 __ LDA #$00
24dc : 85 1b __ STA ACCU + 0 
24de : 85 1c __ STA ACCU + 1 
24e0 : 60 __ __ RTS
24e1 : 38 __ __ SEC
24e2 : e9 8e __ SBC #$8e
24e4 : 90 0a __ BCC $24f0 ; (f32_to_i16 + 31)
24e6 : a9 ff __ LDA #$ff
24e8 : 85 1b __ STA ACCU + 0 
24ea : a9 7f __ LDA #$7f
24ec : 85 1c __ STA ACCU + 1 
24ee : d0 08 __ BNE $24f8 ; (f32_to_i16 + 39)
24f0 : aa __ __ TAX
24f1 : 46 1d __ LSR ACCU + 2 
24f3 : 66 1c __ ROR ACCU + 1 
24f5 : e8 __ __ INX
24f6 : d0 f9 __ BNE $24f1 ; (f32_to_i16 + 32)
24f8 : 24 1e __ BIT ACCU + 3 
24fa : 10 0e __ BPL $250a ; (f32_to_i16 + 57)
24fc : 38 __ __ SEC
24fd : a9 00 __ LDA #$00
24ff : e5 1c __ SBC ACCU + 1 
2501 : 85 1b __ STA ACCU + 0 
2503 : a9 00 __ LDA #$00
2505 : e5 1d __ SBC ACCU + 2 
2507 : 85 1c __ STA ACCU + 1 
2509 : 60 __ __ RTS
250a : a5 1c __ LDA ACCU + 1 
250c : 85 1b __ STA ACCU + 0 
250e : a5 1d __ LDA ACCU + 2 
2510 : 85 1c __ STA ACCU + 1 
2512 : 60 __ __ RTS
--------------------------------------------------------------------
sint16_to_float:
2513 : 24 1c __ BIT ACCU + 1 
2515 : 30 03 __ BMI $251a ; (sint16_to_float + 7)
2517 : 4c 31 25 JMP $2531 ; (uint16_to_float + 0)
251a : 38 __ __ SEC
251b : a9 00 __ LDA #$00
251d : e5 1b __ SBC ACCU + 0 
251f : 85 1b __ STA ACCU + 0 
2521 : a9 00 __ LDA #$00
2523 : e5 1c __ SBC ACCU + 1 
2525 : 85 1c __ STA ACCU + 1 
2527 : 20 31 25 JSR $2531 ; (uint16_to_float + 0)
252a : a5 1e __ LDA ACCU + 3 
252c : 09 80 __ ORA #$80
252e : 85 1e __ STA ACCU + 3 
2530 : 60 __ __ RTS
--------------------------------------------------------------------
uint16_to_float:
2531 : a5 1b __ LDA ACCU + 0 
2533 : 05 1c __ ORA ACCU + 1 
2535 : d0 05 __ BNE $253c ; (uint16_to_float + 11)
2537 : 85 1d __ STA ACCU + 2 
2539 : 85 1e __ STA ACCU + 3 
253b : 60 __ __ RTS
253c : a2 8e __ LDX #$8e
253e : a5 1c __ LDA ACCU + 1 
2540 : 30 06 __ BMI $2548 ; (uint16_to_float + 23)
2542 : ca __ __ DEX
2543 : 06 1b __ ASL ACCU + 0 
2545 : 2a __ __ ROL
2546 : 10 fa __ BPL $2542 ; (uint16_to_float + 17)
2548 : 29 7f __ AND #$7f
254a : 85 1d __ STA ACCU + 2 
254c : a5 1b __ LDA ACCU + 0 
254e : 85 1c __ STA ACCU + 1 
2550 : 8a __ __ TXA
2551 : 4a __ __ LSR
2552 : 85 1e __ STA ACCU + 3 
2554 : a9 00 __ LDA #$00
2556 : 85 1b __ STA ACCU + 0 
2558 : 6a __ __ ROR
2559 : 05 1d __ ORA ACCU + 2 
255b : 85 1d __ STA ACCU + 2 
255d : 60 __ __ RTS
--------------------------------------------------------------------
divmod32:
255e : 84 02 __ STY $02 
2560 : a0 20 __ LDY #$20
2562 : a9 00 __ LDA #$00
2564 : 85 07 __ STA WORK + 4 
2566 : 85 08 __ STA WORK + 5 
2568 : 85 09 __ STA WORK + 6 
256a : 85 0a __ STA WORK + 7 
256c : a5 05 __ LDA WORK + 2 
256e : 05 06 __ ORA WORK + 3 
2570 : d0 39 __ BNE $25ab ; (divmod32 + 77)
2572 : 18 __ __ CLC
2573 : 26 1b __ ROL ACCU + 0 
2575 : 26 1c __ ROL ACCU + 1 
2577 : 26 1d __ ROL ACCU + 2 
2579 : 26 1e __ ROL ACCU + 3 
257b : 26 07 __ ROL WORK + 4 
257d : 26 08 __ ROL WORK + 5 
257f : 90 0c __ BCC $258d ; (divmod32 + 47)
2581 : a5 07 __ LDA WORK + 4 
2583 : e5 03 __ SBC WORK + 0 
2585 : aa __ __ TAX
2586 : a5 08 __ LDA WORK + 5 
2588 : e5 04 __ SBC WORK + 1 
258a : 38 __ __ SEC
258b : b0 0c __ BCS $2599 ; (divmod32 + 59)
258d : 38 __ __ SEC
258e : a5 07 __ LDA WORK + 4 
2590 : e5 03 __ SBC WORK + 0 
2592 : aa __ __ TAX
2593 : a5 08 __ LDA WORK + 5 
2595 : e5 04 __ SBC WORK + 1 
2597 : 90 04 __ BCC $259d ; (divmod32 + 63)
2599 : 86 07 __ STX WORK + 4 
259b : 85 08 __ STA WORK + 5 
259d : 88 __ __ DEY
259e : d0 d3 __ BNE $2573 ; (divmod32 + 21)
25a0 : 26 1b __ ROL ACCU + 0 
25a2 : 26 1c __ ROL ACCU + 1 
25a4 : 26 1d __ ROL ACCU + 2 
25a6 : 26 1e __ ROL ACCU + 3 
25a8 : a4 02 __ LDY $02 
25aa : 60 __ __ RTS
25ab : 18 __ __ CLC
25ac : 26 1b __ ROL ACCU + 0 
25ae : 26 1c __ ROL ACCU + 1 
25b0 : 26 1d __ ROL ACCU + 2 
25b2 : 26 1e __ ROL ACCU + 3 
25b4 : 26 07 __ ROL WORK + 4 
25b6 : 26 08 __ ROL WORK + 5 
25b8 : 26 09 __ ROL WORK + 6 
25ba : 26 0a __ ROL WORK + 7 
25bc : a5 07 __ LDA WORK + 4 
25be : c5 03 __ CMP WORK + 0 
25c0 : a5 08 __ LDA WORK + 5 
25c2 : e5 04 __ SBC WORK + 1 
25c4 : a5 09 __ LDA WORK + 6 
25c6 : e5 05 __ SBC WORK + 2 
25c8 : a5 0a __ LDA WORK + 7 
25ca : e5 06 __ SBC WORK + 3 
25cc : 90 18 __ BCC $25e6 ; (divmod32 + 136)
25ce : a5 07 __ LDA WORK + 4 
25d0 : e5 03 __ SBC WORK + 0 
25d2 : 85 07 __ STA WORK + 4 
25d4 : a5 08 __ LDA WORK + 5 
25d6 : e5 04 __ SBC WORK + 1 
25d8 : 85 08 __ STA WORK + 5 
25da : a5 09 __ LDA WORK + 6 
25dc : e5 05 __ SBC WORK + 2 
25de : 85 09 __ STA WORK + 6 
25e0 : a5 0a __ LDA WORK + 7 
25e2 : e5 06 __ SBC WORK + 3 
25e4 : 85 0a __ STA WORK + 7 
25e6 : 88 __ __ DEY
25e7 : d0 c3 __ BNE $25ac ; (divmod32 + 78)
25e9 : 26 1b __ ROL ACCU + 0 
25eb : 26 1c __ ROL ACCU + 1 
25ed : 26 1d __ ROL ACCU + 2 
25ef : 26 1e __ ROL ACCU + 3 
25f1 : a4 02 __ LDY $02 
25f3 : 60 __ __ RTS
--------------------------------------------------------------------
__multab5L:
25f4 : __ __ __ BYT 00 05 0a 0f 14 19 1e 23 28 2d                   : .......#(-
--------------------------------------------------------------------
__multab3L:
08fd : __ __ __ BYT 00 03 06                                        : ...
--------------------------------------------------------------------
__multab2000L:
2600 : __ __ __ BYT 00 d0 a0 70 40 10 e0 b0                         : ...p@...
--------------------------------------------------------------------
__multab2000H:
2608 : __ __ __ BYT 00 07 0f 17 1f 27 2e 36                         : .....'.6
