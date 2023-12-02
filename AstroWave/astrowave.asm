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
080e : 8e cb 26 STX $26cb ; (spentry + 0)
0811 : a9 5e __ LDA #$5e
0813 : 85 19 __ STA IP + 0 
0815 : a9 27 __ LDA #$27
0817 : 85 1a __ STA IP + 1 
0819 : 38 __ __ SEC
081a : a9 27 __ LDA #$27
081c : e9 27 __ SBC #$27
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
0830 : a9 c2 __ LDA #$c2
0832 : e9 5e __ SBC #$5e
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
26cb : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
main:
.s0:
0880 : a9 00 __ LDA #$00
0882 : 8d 5e 27 STA $275e ; (game + 0)
0885 : 20 97 08 JSR $0897 ; (redefine_charset.s0 + 0)
.l3:
0888 : 20 b4 09 JSR $09b4 ; (main_loop.s0 + 0)
088b : ad 5e 27 LDA $275e ; (game + 0)
088e : f0 f8 __ BEQ $0888 ; (main.l3 + 0)
.s4:
0890 : a9 00 __ LDA #$00
0892 : 85 1b __ STA ACCU + 0 
0894 : 85 1c __ STA ACCU + 1 
.s1001:
0896 : 60 __ __ RTS
--------------------------------------------------------------------
game:
275e : __ __ __ BSS	6
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
08b7 : bd ff 26 LDA $26ff,x 
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
2700 : __ __ __ BYT 80 e0 f8 7f 7f f8 e0 80 00 00 60 3e 3e 60 00 00 : ..........`>>`..
2710 : __ __ __ BYT 00 00 3c 66 66 3c 00 00 1c 7f c6 1f 1f c6 7f 1c : ..<ff<..........
2720 : __ __ __ BYT 00 3c 7e d5 ab 7e 3c 00 28 3c 6e df 5f fe 3c 14 : .<~..~<.(<n._.<.
2730 : __ __ __ BYT 28 56 65 92 69 36 44 2a                         : (Ve.i6D*
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
09c9 : ae 63 27 LDX $2763 ; (game + 5)
09cc : ce 63 27 DEC $2763 ; (game + 5)
09cf : 8a __ __ TXA
09d0 : f0 07 __ BEQ $09d9 ; (main_loop.s3 + 0)
.s4:
09d2 : a9 01 __ LDA #$01
09d4 : 8d 5e 27 STA $275e ; (game + 0)
09d7 : d0 e1 __ BNE $09ba ; (main_loop.l1 + 0)
.s3:
09d9 : 8d 5e 27 STA $275e ; (game + 0)
.s1001:
09dc : 60 __ __ RTS
--------------------------------------------------------------------
init_game_state:
.s0:
09dd : a9 01 __ LDA #$01
09df : 8d 5e 27 STA $275e ; (game + 0)
09e2 : a9 00 __ LDA #$00
09e4 : 8d 5f 27 STA $275f ; (game + 1)
09e7 : 8d 60 27 STA $2760 ; (game + 2)
09ea : 8d 61 27 STA $2761 ; (game + 3)
09ed : 8d 62 27 STA $2762 ; (game + 4)
09f0 : a9 03 __ LDA #$03
09f2 : 8d 63 27 STA $2763 ; (game + 5)
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
0a0c : a9 64 __ LDA #$64
0a0e : 85 0d __ STA P0 
0a10 : a9 27 __ LDA #$27
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
0a41 : b9 cc 26 LDA $26cc,y ; (mul40 + 0)
0a44 : 85 1b __ STA ACCU + 0 
0a46 : 18 __ __ CLC
0a47 : 65 11 __ ADC P4 ; (sx + 0)
0a49 : aa __ __ TAX
0a4a : b9 cd 26 LDA $26cd,y ; (mul40 + 1)
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
26cc : __ __ __ BYT 00 00 28 00 50 00 78 00 a0 00 c8 00 f0 00 18 01 : ..(.P.x.........
26dc : __ __ __ BYT 40 01 68 01 90 01 b8 01 e0 01 08 02 30 02 58 02 : @.h.........0.X.
26ec : __ __ __ BYT 80 02 a8 02 d0 02 f8 02 20 03 48 03 70 03 98 03 : ........ .H.p...
26fc : __ __ __ BYT c0 03                                           : ..
--------------------------------------------------------------------
cwTop:
2764 : __ __ __ BSS	10
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
0acb : 8d 6e 27 STA $276e ; (Player + 0)
0ace : a9 0c __ LDA #$0c
0ad0 : 8d 6f 27 STA $276f ; (Player + 1)
0ad3 : a9 00 __ LDA #$00
0ad5 : 8d 73 27 STA $2773 ; (PlayerShotSound + 3)
.s1001:
0ad8 : 60 __ __ RTS
--------------------------------------------------------------------
Player:
276e : __ __ __ BSS	2
--------------------------------------------------------------------
PlayerShotSound:
2770 : __ __ __ BSS	4
--------------------------------------------------------------------
init_enemies:
.s0:
0ad9 : a2 00 __ LDX #$00
0adb : a0 0a __ LDY #$0a
.l1002:
0add : a9 00 __ LDA #$00
0adf : 9d 74 27 STA $2774,x ; (Enemy + 0)
0ae2 : 9d 75 27 STA $2775,x ; (Enemy + 1)
0ae5 : 9d 78 27 STA $2778,x ; (Enemy + 4)
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
2774 : __ __ __ BSS	50
--------------------------------------------------------------------
init_shots:
.s0:
0af1 : a2 00 __ LDX #$00
0af3 : a0 03 __ LDY #$03
0af5 : 8a __ __ TXA
.l1006:
0af6 : 9d a6 27 STA $27a6,x ; (PlayerShot + 0)
0af9 : 9d a7 27 STA $27a7,x ; (PlayerShot + 1)
0afc : 9d a8 27 STA $27a8,x ; (PlayerShot + 2)
0aff : e8 __ __ INX
0b00 : e8 __ __ INX
0b01 : e8 __ __ INX
0b02 : 88 __ __ DEY
0b03 : d0 f1 __ BNE $0af6 ; (init_shots.l1006 + 0)
.s6:
0b05 : a0 03 __ LDY #$03
0b07 : aa __ __ TAX
.l1008:
0b08 : 9d af 27 STA $27af,x ; (EnemyShot + 0)
0b0b : 9d b0 27 STA $27b0,x ; (EnemyShot + 1)
0b0e : 9d b1 27 STA $27b1,x ; (EnemyShot + 2)
0b11 : e8 __ __ INX
0b12 : e8 __ __ INX
0b13 : e8 __ __ INX
0b14 : 88 __ __ DEY
0b15 : d0 f1 __ BNE $0b08 ; (init_shots.l1008 + 0)
.s1001:
0b17 : 60 __ __ RTS
--------------------------------------------------------------------
PlayerShot:
27a6 : __ __ __ BSS	9
--------------------------------------------------------------------
EnemyShot:
27af : __ __ __ BSS	9
--------------------------------------------------------------------
run_game:
.s1000:
0b18 : a5 53 __ LDA T0 + 0 
0b1a : 8d cd 9f STA $9fcd ; (run_game@stack + 0)
.s0:
0b1d : a9 ff __ LDA #$ff
0b1f : 8d 18 d4 STA $d418 
0b22 : ad 5e 27 LDA $275e ; (game + 0)
0b25 : c9 01 __ CMP #$01
0b27 : d0 5c __ BNE $0b85 ; (run_game.s1001 + 0)
.s7:
0b29 : a9 00 __ LDA #$00
0b2b : 85 53 __ STA T0 + 0 
.l2:
0b2d : 20 8b 0b JSR $0b8b ; (render_game_state.s1000 + 0)
0b30 : 20 87 19 JSR $1987 ; (play_sound_effects.s0 + 0)
0b33 : a5 53 __ LDA T0 + 0 
0b35 : 85 1b __ STA ACCU + 0 
0b37 : a9 00 __ LDA #$00
0b39 : 85 1c __ STA ACCU + 1 
0b3b : 85 04 __ STA WORK + 1 
0b3d : a9 03 __ LDA #$03
0b3f : 85 03 __ STA WORK + 0 
0b41 : 20 e0 24 JSR $24e0 ; (divmod + 0)
0b44 : a5 05 __ LDA WORK + 2 
0b46 : 05 06 __ ORA WORK + 3 
0b48 : d0 0c __ BNE $0b56 ; (run_game.s6 + 0)
.s4:
0b4a : 20 5e 1a JSR $1a5e ; (spawn_enemy.s0 + 0)
0b4d : 20 f5 1a JSR $1af5 ; (move_enemies.s0 + 0)
0b50 : 20 77 1c JSR $1c77 ; (render_enemies.s0 + 0)
0b53 : 20 d4 1c JSR $1cd4 ; (check_shot_enemy_collision.s0 + 0)
.s6:
0b56 : 20 1f 1e JSR $1e1f ; (move_enemy_shots.s0 + 0)
0b59 : 20 22 1c JSR $1c22 ; (render_enemy_shots.s0 + 0)
0b5c : 20 89 1e JSR $1e89 ; (check_player_enemy_collision.s0 + 0)
0b5f : 20 b5 1f JSR $1fb5 ; (control_player_ship.s0 + 0)
0b62 : 20 df 20 JSR $20df ; (render_player_ship.s0 + 0)
0b65 : 20 89 1e JSR $1e89 ; (check_player_enemy_collision.s0 + 0)
0b68 : 20 1f 21 JSR $211f ; (move_player_shots.s0 + 0)
0b6b : 20 87 21 JSR $2187 ; (render_player_shots.s0 + 0)
0b6e : 20 d4 1c JSR $1cd4 ; (check_shot_enemy_collision.s0 + 0)
0b71 : a9 03 __ LDA #$03
0b73 : 85 0d __ STA P0 
0b75 : a9 00 __ LDA #$00
0b77 : 85 0e __ STA P1 
0b79 : 20 dc 21 JSR $21dc ; (wait_frames.s0 + 0)
0b7c : e6 53 __ INC T0 + 0 
0b7e : ad 5e 27 LDA $275e ; (game + 0)
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
0ba2 : a9 64 __ LDA #$64
0ba4 : 85 0d __ STA P0 
0ba6 : a9 27 __ LDA #$27
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
0bca : ad 5f 27 LDA $275f ; (game + 1)
0bcd : c8 __ __ INY
0bce : 91 23 __ STA (SP + 0),y 
0bd0 : ad 60 27 LDA $2760 ; (game + 2)
0bd3 : c8 __ __ INY
0bd4 : 91 23 __ STA (SP + 0),y 
0bd6 : ad 61 27 LDA $2761 ; (game + 3)
0bd9 : c8 __ __ INY
0bda : 91 23 __ STA (SP + 0),y 
0bdc : ad 62 27 LDA $2762 ; (game + 4)
0bdf : c8 __ __ INY
0be0 : 91 23 __ STA (SP + 0),y 
0be2 : 20 b7 0c JSR $0cb7 ; (sprintf.s1000 + 0)
0be5 : a9 64 __ LDA #$64
0be7 : 85 0d __ STA P0 
0be9 : a9 27 __ LDA #$27
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
0c0c : a9 80 __ LDA #$80
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
0c2c : ad 63 27 LDA $2763 ; (game + 5)
0c2f : c8 __ __ INY
0c30 : 91 23 __ STA (SP + 0),y 
0c32 : a9 00 __ LDA #$00
0c34 : c8 __ __ INY
0c35 : 91 23 __ STA (SP + 0),y 
0c37 : 20 b7 0c JSR $0cb7 ; (sprintf.s1000 + 0)
0c3a : a9 64 __ LDA #$64
0c3c : 85 0d __ STA P0 
0c3e : a9 27 __ LDA #$27
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
0c69 : bd cc 26 LDA $26cc,x ; (mul40 + 0)
0c6c : 18 __ __ CLC
0c6d : 65 0f __ ADC P2 ; (x + 0)
0c6f : 85 1b __ STA ACCU + 0 
0c71 : bd cd 26 LDA $26cd,x ; (mul40 + 1)
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
0ca5 : bd 38 27 LDA $2738,x ; (p2smap + 0)
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
2738 : __ __ __ BYT 00 00 40 20 80 c0 80 80                         : ..@ ....
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
0d18 : ad fb 9f LDA $9ffb ; (sstack + 3)
0d1b : 85 50 __ STA T0 + 0 
0d1d : ad fc 9f LDA $9ffc ; (sstack + 4)
0d20 : 85 51 __ STA T0 + 1 
0d22 : ad f9 9f LDA $9ff9 ; (sstack + 1)
0d25 : 85 53 __ STA T1 + 0 
0d27 : ad fa 9f LDA $9ffa ; (sstack + 2)
0d2a : 85 54 __ STA T1 + 1 
0d2c : a9 00 __ LDA #$00
.l1057:
0d2e : 85 55 __ STA T2 + 0 
.l1:
0d30 : a0 00 __ LDY #$00
0d32 : b1 50 __ LDA (T0 + 0),y 
0d34 : d0 38 __ BNE $0d6e ; (sformat.s2 + 0)
.s3:
0d36 : a4 55 __ LDY T2 + 0 
0d38 : 91 53 __ STA (T1 + 0),y 
0d3a : 98 __ __ TYA
0d3b : f0 28 __ BEQ $0d65 ; (sformat.s1059 + 0)
.s112:
0d3d : ad ff 9f LDA $9fff ; (sstack + 7)
0d40 : d0 18 __ BNE $0d5a ; (sformat.s115 + 0)
.s116:
0d42 : 18 __ __ CLC
0d43 : a5 53 __ LDA T1 + 0 
0d45 : 65 55 __ ADC T2 + 0 
0d47 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0d49 : a5 54 __ LDA T1 + 1 
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
0d5a : a5 53 __ LDA T1 + 0 
0d5c : 85 0d __ STA P0 
0d5e : a5 54 __ LDA T1 + 1 
0d60 : 85 0e __ STA P1 
0d62 : 20 54 11 JSR $1154 ; (puts.s0 + 0)
.s1059:
0d65 : a5 53 __ LDA T1 + 0 
0d67 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0d69 : a5 54 __ LDA T1 + 1 
0d6b : 4c 4d 0d JMP $0d4d ; (sformat.s1001 + 0)
.s2:
0d6e : c9 25 __ CMP #$25
0d70 : f0 3f __ BEQ $0db1 ; (sformat.s4 + 0)
.s5:
0d72 : a4 55 __ LDY T2 + 0 
0d74 : 91 53 __ STA (T1 + 0),y 
0d76 : e6 50 __ INC T0 + 0 
0d78 : d0 02 __ BNE $0d7c ; (sformat.s1089 + 0)
.s1088:
0d7a : e6 51 __ INC T0 + 1 
.s1089:
0d7c : c8 __ __ INY
0d7d : 84 55 __ STY T2 + 0 
0d7f : 98 __ __ TYA
0d80 : c0 28 __ CPY #$28
0d82 : 90 ac __ BCC $0d30 ; (sformat.l1 + 0)
.s106:
0d84 : 85 57 __ STA T5 + 0 
0d86 : a9 00 __ LDA #$00
0d88 : 85 55 __ STA T2 + 0 
0d8a : ad ff 9f LDA $9fff ; (sstack + 7)
0d8d : f0 14 __ BEQ $0da3 ; (sformat.s110 + 0)
.s109:
0d8f : a5 53 __ LDA T1 + 0 
0d91 : 85 0d __ STA P0 
0d93 : a5 54 __ LDA T1 + 1 
0d95 : 85 0e __ STA P1 
0d97 : a9 00 __ LDA #$00
0d99 : a4 57 __ LDY T5 + 0 
0d9b : 91 0d __ STA (P0),y 
0d9d : 20 54 11 JSR $1154 ; (puts.s0 + 0)
0da0 : 4c 30 0d JMP $0d30 ; (sformat.l1 + 0)
.s110:
0da3 : 18 __ __ CLC
0da4 : a5 53 __ LDA T1 + 0 
0da6 : 65 57 __ ADC T5 + 0 
0da8 : 85 53 __ STA T1 + 0 
0daa : 90 84 __ BCC $0d30 ; (sformat.l1 + 0)
.s1090:
0dac : e6 54 __ INC T1 + 1 
0dae : 4c 30 0d JMP $0d30 ; (sformat.l1 + 0)
.s4:
0db1 : a5 55 __ LDA T2 + 0 
0db3 : f0 27 __ BEQ $0ddc ; (sformat.s9 + 0)
.s7:
0db5 : 84 55 __ STY T2 + 0 
0db7 : 85 57 __ STA T5 + 0 
0db9 : ad ff 9f LDA $9fff ; (sstack + 7)
0dbc : f0 13 __ BEQ $0dd1 ; (sformat.s11 + 0)
.s10:
0dbe : a5 53 __ LDA T1 + 0 
0dc0 : 85 0d __ STA P0 
0dc2 : a5 54 __ LDA T1 + 1 
0dc4 : 85 0e __ STA P1 
0dc6 : 98 __ __ TYA
0dc7 : a4 57 __ LDY T5 + 0 
0dc9 : 91 0d __ STA (P0),y 
0dcb : 20 54 11 JSR $1154 ; (puts.s0 + 0)
0dce : 4c dc 0d JMP $0ddc ; (sformat.s9 + 0)
.s11:
0dd1 : 18 __ __ CLC
0dd2 : a5 53 __ LDA T1 + 0 
0dd4 : 65 57 __ ADC T5 + 0 
0dd6 : 85 53 __ STA T1 + 0 
0dd8 : 90 02 __ BCC $0ddc ; (sformat.s9 + 0)
.s1086:
0dda : e6 54 __ INC T1 + 1 
.s9:
0ddc : a9 0a __ LDA #$0a
0dde : 8d e3 9f STA $9fe3 ; (si + 3)
0de1 : a9 00 __ LDA #$00
0de3 : 8d e4 9f STA $9fe4 ; (si + 4)
0de6 : 8d e5 9f STA $9fe5 ; (si + 5)
0de9 : 8d e6 9f STA $9fe6 ; (si + 6)
0dec : 8d e7 9f STA $9fe7 ; (si + 7)
0def : a0 01 __ LDY #$01
0df1 : b1 50 __ LDA (T0 + 0),y 
0df3 : aa __ __ TAX
0df4 : a9 20 __ LDA #$20
0df6 : 8d e0 9f STA $9fe0 ; (si + 0)
0df9 : a9 00 __ LDA #$00
0dfb : 8d e1 9f STA $9fe1 ; (si + 1)
0dfe : a9 ff __ LDA #$ff
0e00 : 8d e2 9f STA $9fe2 ; (si + 2)
0e03 : 18 __ __ CLC
0e04 : a5 50 __ LDA T0 + 0 
0e06 : 69 02 __ ADC #$02
.l14:
0e08 : 85 50 __ STA T0 + 0 
0e0a : 90 02 __ BCC $0e0e ; (sformat.s1071 + 0)
.s1070:
0e0c : e6 51 __ INC T0 + 1 
.s1071:
0e0e : 8a __ __ TXA
0e0f : e0 2b __ CPX #$2b
0e11 : d0 08 __ BNE $0e1b ; (sformat.s17 + 0)
.s16:
0e13 : a9 01 __ LDA #$01
0e15 : 8d e5 9f STA $9fe5 ; (si + 5)
0e18 : 4c 47 11 JMP $1147 ; (sformat.s224 + 0)
.s17:
0e1b : c9 30 __ CMP #$30
0e1d : d0 06 __ BNE $0e25 ; (sformat.s20 + 0)
.s19:
0e1f : 8d e0 9f STA $9fe0 ; (si + 0)
0e22 : 4c 47 11 JMP $1147 ; (sformat.s224 + 0)
.s20:
0e25 : e0 23 __ CPX #$23
0e27 : d0 08 __ BNE $0e31 ; (sformat.s23 + 0)
.s22:
0e29 : a9 01 __ LDA #$01
0e2b : 8d e7 9f STA $9fe7 ; (si + 7)
0e2e : 4c 47 11 JMP $1147 ; (sformat.s224 + 0)
.s23:
0e31 : e0 2d __ CPX #$2d
0e33 : d0 08 __ BNE $0e3d ; (sformat.s15 + 0)
.s25:
0e35 : a9 01 __ LDA #$01
0e37 : 8d e6 9f STA $9fe6 ; (si + 6)
0e3a : 4c 47 11 JMP $1147 ; (sformat.s224 + 0)
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
0e70 : 90 01 __ BCC $0e73 ; (sformat.s1083 + 0)
.s1082:
0e72 : e8 __ __ INX
.s1083:
0e73 : 38 __ __ SEC
0e74 : e9 30 __ SBC #$30
0e76 : 85 44 __ STA T6 + 0 
0e78 : 8a __ __ TXA
0e79 : e9 00 __ SBC #$00
0e7b : 85 45 __ STA T6 + 1 
0e7d : a0 00 __ LDY #$00
0e7f : b1 50 __ LDA (T0 + 0),y 
0e81 : 85 57 __ STA T5 + 0 
0e83 : e6 50 __ INC T0 + 0 
0e85 : d0 02 __ BNE $0e89 ; (sformat.s1085 + 0)
.s1084:
0e87 : e6 51 __ INC T0 + 1 
.s1085:
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
0ea4 : b1 50 __ LDA (T0 + 0),y 
0ea6 : 85 57 __ STA T5 + 0 
0ea8 : e6 50 __ INC T0 + 0 
0eaa : d0 02 __ BNE $0eae ; (sformat.s1073 + 0)
.s1072:
0eac : e6 51 __ INC T0 + 1 
.s1073:
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
0edf : 90 01 __ BCC $0ee2 ; (sformat.s1081 + 0)
.s1080:
0ee1 : e8 __ __ INX
.s1081:
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
0ef3 : 4c 0b 11 JMP $110b ; (sformat.s221 + 0)
.s45:
0ef6 : c9 75 __ CMP #$75
0ef8 : d0 03 __ BNE $0efd ; (sformat.s48 + 0)
0efa : 4c 09 11 JMP $1109 ; (sformat.s250 + 0)
.s48:
0efd : c9 78 __ CMP #$78
0eff : d0 0d __ BNE $0f0e ; (sformat.s51 + 0)
.s50:
0f01 : a9 10 __ LDA #$10
0f03 : 8d e3 9f STA $9fe3 ; (si + 3)
0f06 : a9 00 __ LDA #$00
0f08 : 8d e4 9f STA $9fe4 ; (si + 4)
0f0b : 4c 09 11 JMP $1109 ; (sformat.s250 + 0)
.s51:
0f0e : c9 6c __ CMP #$6c
0f10 : d0 03 __ BNE $0f15 ; (sformat.s54 + 0)
0f12 : 4c 8d 10 JMP $108d ; (sformat.s53 + 0)
.s54:
0f15 : c9 66 __ CMP #$66
0f17 : d0 03 __ BNE $0f1c ; (sformat.s69 + 0)
0f19 : 4c 3e 10 JMP $103e ; (sformat.s65 + 0)
.s69:
0f1c : c9 67 __ CMP #$67
0f1e : d0 03 __ BNE $0f23 ; (sformat.s68 + 0)
0f20 : 4c 3e 10 JMP $103e ; (sformat.s65 + 0)
.s68:
0f23 : c9 65 __ CMP #$65
0f25 : d0 03 __ BNE $0f2a ; (sformat.s66 + 0)
0f27 : 4c 3e 10 JMP $103e ; (sformat.s65 + 0)
.s66:
0f2a : c9 73 __ CMP #$73
0f2c : f0 4c __ BEQ $0f7a ; (sformat.s70 + 0)
.s71:
0f2e : c9 63 __ CMP #$63
0f30 : f0 1f __ BEQ $0f51 ; (sformat.s100 + 0)
.s101:
0f32 : 09 00 __ ORA #$00
0f34 : d0 03 __ BNE $0f39 ; (sformat.s103 + 0)
0f36 : 4c 30 0d JMP $0d30 ; (sformat.l1 + 0)
.s103:
0f39 : 18 __ __ CLC
0f3a : a5 53 __ LDA T1 + 0 
0f3c : 65 55 __ ADC T2 + 0 
0f3e : 85 44 __ STA T6 + 0 
0f40 : a5 54 __ LDA T1 + 1 
0f42 : 69 00 __ ADC #$00
0f44 : 85 45 __ STA T6 + 1 
0f46 : a5 57 __ LDA T5 + 0 
.s1056:
0f48 : a0 00 __ LDY #$00
0f4a : 91 44 __ STA (T6 + 0),y 
0f4c : e6 55 __ INC T2 + 0 
0f4e : 4c 30 0d JMP $0d30 ; (sformat.l1 + 0)
.s100:
0f51 : ad fd 9f LDA $9ffd ; (sstack + 5)
0f54 : 85 57 __ STA T5 + 0 
0f56 : 18 __ __ CLC
0f57 : 69 02 __ ADC #$02
0f59 : 8d fd 9f STA $9ffd ; (sstack + 5)
0f5c : ad fe 9f LDA $9ffe ; (sstack + 6)
0f5f : 85 58 __ STA T5 + 1 
0f61 : 69 00 __ ADC #$00
0f63 : 8d fe 9f STA $9ffe ; (sstack + 6)
0f66 : 18 __ __ CLC
0f67 : a5 53 __ LDA T1 + 0 
0f69 : 65 55 __ ADC T2 + 0 
0f6b : 85 44 __ STA T6 + 0 
0f6d : a5 54 __ LDA T1 + 1 
0f6f : 69 00 __ ADC #$00
0f71 : 85 45 __ STA T6 + 1 
0f73 : a0 00 __ LDY #$00
0f75 : b1 57 __ LDA (T5 + 0),y 
0f77 : 4c 48 0f JMP $0f48 ; (sformat.s1056 + 0)
.s70:
0f7a : ad fd 9f LDA $9ffd ; (sstack + 5)
0f7d : 85 57 __ STA T5 + 0 
0f7f : 18 __ __ CLC
0f80 : 69 02 __ ADC #$02
0f82 : 8d fd 9f STA $9ffd ; (sstack + 5)
0f85 : ad fe 9f LDA $9ffe ; (sstack + 6)
0f88 : 85 58 __ STA T5 + 1 
0f8a : 69 00 __ ADC #$00
0f8c : 8d fe 9f STA $9ffe ; (sstack + 6)
0f8f : a0 00 __ LDY #$00
0f91 : b1 57 __ LDA (T5 + 0),y 
0f93 : aa __ __ TAX
0f94 : c8 __ __ INY
0f95 : b1 57 __ LDA (T5 + 0),y 
0f97 : 86 57 __ STX T5 + 0 
0f99 : 85 58 __ STA T5 + 1 
0f9b : a9 00 __ LDA #$00
0f9d : 85 52 __ STA T3 + 0 
0f9f : ad e1 9f LDA $9fe1 ; (si + 1)
0fa2 : f0 0c __ BEQ $0fb0 ; (sformat.s75 + 0)
.s1062:
0fa4 : 88 __ __ DEY
0fa5 : b1 57 __ LDA (T5 + 0),y 
0fa7 : f0 05 __ BEQ $0fae ; (sformat.s1063 + 0)
.l77:
0fa9 : c8 __ __ INY
0faa : b1 57 __ LDA (T5 + 0),y 
0fac : d0 fb __ BNE $0fa9 ; (sformat.l77 + 0)
.s1063:
0fae : 84 52 __ STY T3 + 0 
.s75:
0fb0 : ad e6 9f LDA $9fe6 ; (si + 6)
0fb3 : d0 19 __ BNE $0fce ; (sformat.s81 + 0)
.s1066:
0fb5 : a6 52 __ LDX T3 + 0 
0fb7 : ec e1 9f CPX $9fe1 ; (si + 1)
0fba : a4 55 __ LDY T2 + 0 
0fbc : b0 0c __ BCS $0fca ; (sformat.s1067 + 0)
.l83:
0fbe : ad e0 9f LDA $9fe0 ; (si + 0)
0fc1 : 91 53 __ STA (T1 + 0),y 
0fc3 : e8 __ __ INX
0fc4 : ec e1 9f CPX $9fe1 ; (si + 1)
0fc7 : c8 __ __ INY
0fc8 : 90 f4 __ BCC $0fbe ; (sformat.l83 + 0)
.s1067:
0fca : 86 52 __ STX T3 + 0 
0fcc : 84 55 __ STY T2 + 0 
.s81:
0fce : ad ff 9f LDA $9fff ; (sstack + 7)
0fd1 : d0 37 __ BNE $100a ; (sformat.s85 + 0)
.l91:
0fd3 : a0 00 __ LDY #$00
0fd5 : b1 57 __ LDA (T5 + 0),y 
0fd7 : f0 0f __ BEQ $0fe8 ; (sformat.s211 + 0)
.s92:
0fd9 : a4 55 __ LDY T2 + 0 
0fdb : 91 53 __ STA (T1 + 0),y 
0fdd : e6 55 __ INC T2 + 0 
0fdf : e6 57 __ INC T5 + 0 
0fe1 : d0 f0 __ BNE $0fd3 ; (sformat.l91 + 0)
.s1078:
0fe3 : e6 58 __ INC T5 + 1 
0fe5 : 4c d3 0f JMP $0fd3 ; (sformat.l91 + 0)
.s211:
0fe8 : ad e6 9f LDA $9fe6 ; (si + 6)
0feb : d0 03 __ BNE $0ff0 ; (sformat.s1064 + 0)
0fed : 4c 30 0d JMP $0d30 ; (sformat.l1 + 0)
.s1064:
0ff0 : a6 52 __ LDX T3 + 0 
0ff2 : ec e1 9f CPX $9fe1 ; (si + 1)
0ff5 : a4 55 __ LDY T2 + 0 
0ff7 : b0 0c __ BCS $1005 ; (sformat.s1065 + 0)
.l98:
0ff9 : ad e0 9f LDA $9fe0 ; (si + 0)
0ffc : 91 53 __ STA (T1 + 0),y 
0ffe : e8 __ __ INX
0fff : ec e1 9f CPX $9fe1 ; (si + 1)
1002 : c8 __ __ INY
1003 : 90 f4 __ BCC $0ff9 ; (sformat.l98 + 0)
.s1065:
1005 : 84 55 __ STY T2 + 0 
1007 : 4c 30 0d JMP $0d30 ; (sformat.l1 + 0)
.s85:
100a : a5 55 __ LDA T2 + 0 
100c : f0 22 __ BEQ $1030 ; (sformat.s90 + 0)
.s88:
100e : a5 53 __ LDA T1 + 0 
1010 : 85 0d __ STA P0 
1012 : a5 54 __ LDA T1 + 1 
1014 : 85 0e __ STA P1 
1016 : a9 00 __ LDA #$00
1018 : a4 55 __ LDY T2 + 0 
101a : 91 0d __ STA (P0),y 
101c : 20 54 11 JSR $1154 ; (puts.s0 + 0)
101f : a5 57 __ LDA T5 + 0 
1021 : 85 0d __ STA P0 
1023 : a5 58 __ LDA T5 + 1 
1025 : 85 0e __ STA P1 
1027 : 20 54 11 JSR $1154 ; (puts.s0 + 0)
102a : a9 00 __ LDA #$00
102c : 85 55 __ STA T2 + 0 
102e : f0 b8 __ BEQ $0fe8 ; (sformat.s211 + 0)
.s90:
1030 : a5 57 __ LDA T5 + 0 
1032 : 85 0d __ STA P0 
1034 : a5 58 __ LDA T5 + 1 
1036 : 85 0e __ STA P1 
1038 : 20 54 11 JSR $1154 ; (puts.s0 + 0)
103b : 4c e8 0f JMP $0fe8 ; (sformat.s211 + 0)
.s65:
103e : a5 53 __ LDA T1 + 0 
1040 : 85 13 __ STA P6 
1042 : a5 54 __ LDA T1 + 1 
1044 : 85 14 __ STA P7 
1046 : a5 57 __ LDA T5 + 0 
1048 : 8d f8 9f STA $9ff8 ; (sstack + 0)
104b : a9 e0 __ LDA #$e0
104d : 85 11 __ STA P4 
104f : a9 9f __ LDA #$9f
1051 : 85 12 __ STA P5 
1053 : ad fd 9f LDA $9ffd ; (sstack + 5)
1056 : 85 55 __ STA T2 + 0 
1058 : ad fe 9f LDA $9ffe ; (sstack + 6)
105b : 85 56 __ STA T2 + 1 
105d : a0 00 __ LDY #$00
105f : b1 55 __ LDA (T2 + 0),y 
1061 : 85 15 __ STA P8 
1063 : c8 __ __ INY
1064 : b1 55 __ LDA (T2 + 0),y 
1066 : 85 16 __ STA P9 
1068 : c8 __ __ INY
1069 : b1 55 __ LDA (T2 + 0),y 
106b : 85 17 __ STA P10 
106d : c8 __ __ INY
106e : b1 55 __ LDA (T2 + 0),y 
1070 : 85 18 __ STA P11 
1072 : 20 a0 14 JSR $14a0 ; (nformf.s0 + 0)
1075 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
1077 : 85 55 __ STA T2 + 0 
1079 : ad fd 9f LDA $9ffd ; (sstack + 5)
107c : 18 __ __ CLC
107d : 69 04 __ ADC #$04
107f : 8d fd 9f STA $9ffd ; (sstack + 5)
1082 : b0 03 __ BCS $1087 ; (sformat.s1076 + 0)
1084 : 4c 30 0d JMP $0d30 ; (sformat.l1 + 0)
.s1076:
1087 : ee fe 9f INC $9ffe ; (sstack + 6)
108a : 4c 30 0d JMP $0d30 ; (sformat.l1 + 0)
.s53:
108d : ad fd 9f LDA $9ffd ; (sstack + 5)
1090 : 85 57 __ STA T5 + 0 
1092 : 18 __ __ CLC
1093 : 69 04 __ ADC #$04
1095 : 8d fd 9f STA $9ffd ; (sstack + 5)
1098 : ad fe 9f LDA $9ffe ; (sstack + 6)
109b : 85 58 __ STA T5 + 1 
109d : 69 00 __ ADC #$00
109f : 8d fe 9f STA $9ffe ; (sstack + 6)
10a2 : a0 00 __ LDY #$00
10a4 : b1 57 __ LDA (T5 + 0),y 
10a6 : 85 46 __ STA T7 + 0 
10a8 : c8 __ __ INY
10a9 : b1 57 __ LDA (T5 + 0),y 
10ab : 85 47 __ STA T7 + 1 
10ad : c8 __ __ INY
10ae : b1 57 __ LDA (T5 + 0),y 
10b0 : 85 48 __ STA T7 + 2 
10b2 : c8 __ __ INY
10b3 : b1 57 __ LDA (T5 + 0),y 
10b5 : 85 49 __ STA T7 + 3 
10b7 : a0 00 __ LDY #$00
10b9 : b1 50 __ LDA (T0 + 0),y 
10bb : aa __ __ TAX
10bc : e6 50 __ INC T0 + 0 
10be : d0 02 __ BNE $10c2 ; (sformat.s1075 + 0)
.s1074:
10c0 : e6 51 __ INC T0 + 1 
.s1075:
10c2 : 8a __ __ TXA
10c3 : e0 64 __ CPX #$64
10c5 : d0 04 __ BNE $10cb ; (sformat.s57 + 0)
.s56:
10c7 : a9 01 __ LDA #$01
10c9 : d0 14 __ BNE $10df ; (sformat.s222 + 0)
.s57:
10cb : c9 75 __ CMP #$75
10cd : f0 0f __ BEQ $10de ; (sformat.s251 + 0)
.s60:
10cf : c9 78 __ CMP #$78
10d1 : f0 03 __ BEQ $10d6 ; (sformat.s62 + 0)
10d3 : 4c 30 0d JMP $0d30 ; (sformat.l1 + 0)
.s62:
10d6 : 8c e4 9f STY $9fe4 ; (si + 4)
10d9 : a9 10 __ LDA #$10
10db : 8d e3 9f STA $9fe3 ; (si + 3)
.s251:
10de : 98 __ __ TYA
.s222:
10df : 85 15 __ STA P8 
10e1 : a5 53 __ LDA T1 + 0 
10e3 : 85 0f __ STA P2 
10e5 : a5 54 __ LDA T1 + 1 
10e7 : 85 10 __ STA P3 
10e9 : a5 46 __ LDA T7 + 0 
10eb : 85 11 __ STA P4 
10ed : a5 47 __ LDA T7 + 1 
10ef : 85 12 __ STA P5 
10f1 : a5 48 __ LDA T7 + 2 
10f3 : 85 13 __ STA P6 
10f5 : a5 49 __ LDA T7 + 3 
10f7 : 85 14 __ STA P7 
10f9 : a9 e0 __ LDA #$e0
10fb : 85 0d __ STA P0 
10fd : a9 9f __ LDA #$9f
10ff : 85 0e __ STA P1 
1101 : 20 08 13 JSR $1308 ; (nforml.s0 + 0)
.s1058:
1104 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
1106 : 4c 2e 0d JMP $0d2e ; (sformat.l1057 + 0)
.s250:
1109 : a9 00 __ LDA #$00
.s221:
110b : 85 13 __ STA P6 
110d : a5 53 __ LDA T1 + 0 
110f : 85 0f __ STA P2 
1111 : a5 54 __ LDA T1 + 1 
1113 : 85 10 __ STA P3 
1115 : ad fd 9f LDA $9ffd ; (sstack + 5)
1118 : 85 55 __ STA T2 + 0 
111a : ad fe 9f LDA $9ffe ; (sstack + 6)
111d : 85 56 __ STA T2 + 1 
111f : a0 00 __ LDY #$00
1121 : b1 55 __ LDA (T2 + 0),y 
1123 : 85 11 __ STA P4 
1125 : c8 __ __ INY
1126 : b1 55 __ LDA (T2 + 0),y 
1128 : 85 12 __ STA P5 
112a : 18 __ __ CLC
112b : a5 55 __ LDA T2 + 0 
112d : 69 02 __ ADC #$02
112f : 8d fd 9f STA $9ffd ; (sstack + 5)
1132 : a5 56 __ LDA T2 + 1 
1134 : 69 00 __ ADC #$00
1136 : 8d fe 9f STA $9ffe ; (sstack + 6)
1139 : a9 e0 __ LDA #$e0
113b : 85 0d __ STA P0 
113d : a9 9f __ LDA #$9f
113f : 85 0e __ STA P1 
1141 : 20 a9 11 JSR $11a9 ; (nformi.s0 + 0)
1144 : 4c 04 11 JMP $1104 ; (sformat.s1058 + 0)
.s224:
1147 : a0 00 __ LDY #$00
1149 : b1 50 __ LDA (T0 + 0),y 
114b : aa __ __ TAX
114c : 18 __ __ CLC
114d : a5 50 __ LDA T0 + 0 
114f : 69 01 __ ADC #$01
1151 : 4c 08 0e JMP $0e08 ; (sformat.l14 + 0)
--------------------------------------------------------------------
puts:
.s0:
1154 : a0 00 __ LDY #$00
1156 : b1 0d __ LDA (P0),y 
1158 : f0 0b __ BEQ $1165 ; (puts.s1001 + 0)
115a : 20 66 11 JSR $1166 ; (putpch + 0)
115d : e6 0d __ INC P0 
115f : d0 f3 __ BNE $1154 ; (puts.s0 + 0)
1161 : e6 0e __ INC P1 
1163 : d0 ef __ BNE $1154 ; (puts.s0 + 0)
.s1001:
1165 : 60 __ __ RTS
--------------------------------------------------------------------
putpch:
1166 : ae fe 26 LDX $26fe ; (giocharmap + 0)
1169 : e0 01 __ CPX #$01
116b : 90 26 __ BCC $1193 ; (putpch + 45)
116d : c9 0a __ CMP #$0a
116f : d0 02 __ BNE $1173 ; (putpch + 13)
1171 : a9 0d __ LDA #$0d
1173 : c9 09 __ CMP #$09
1175 : f0 1f __ BEQ $1196 ; (putpch + 48)
1177 : e0 02 __ CPX #$02
1179 : 90 18 __ BCC $1193 ; (putpch + 45)
117b : c9 41 __ CMP #$41
117d : 90 14 __ BCC $1193 ; (putpch + 45)
117f : c9 7b __ CMP #$7b
1181 : b0 10 __ BCS $1193 ; (putpch + 45)
1183 : c9 61 __ CMP #$61
1185 : b0 04 __ BCS $118b ; (putpch + 37)
1187 : c9 5b __ CMP #$5b
1189 : b0 08 __ BCS $1193 ; (putpch + 45)
118b : 49 20 __ EOR #$20
118d : e0 03 __ CPX #$03
118f : f0 02 __ BEQ $1193 ; (putpch + 45)
1191 : 29 df __ AND #$df
1193 : 4c d2 ff JMP $ffd2 
1196 : 38 __ __ SEC
1197 : 20 f0 ff JSR $fff0 
119a : 98 __ __ TYA
119b : 29 03 __ AND #$03
119d : 49 03 __ EOR #$03
119f : aa __ __ TAX
11a0 : a9 20 __ LDA #$20
11a2 : 20 d2 ff JSR $ffd2 
11a5 : ca __ __ DEX
11a6 : 10 fa __ BPL $11a2 ; (putpch + 60)
11a8 : 60 __ __ RTS
--------------------------------------------------------------------
giocharmap:
26fe : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
nformi:
.s0:
11a9 : a9 00 __ LDA #$00
11ab : 85 43 __ STA T1 + 0 
11ad : a5 13 __ LDA P6 ; (s + 0)
11af : f0 15 __ BEQ $11c6 ; (nformi.s159 + 0)
.s4:
11b1 : a5 12 __ LDA P5 ; (v + 1)
11b3 : 10 11 __ BPL $11c6 ; (nformi.s159 + 0)
.s1:
11b5 : 38 __ __ SEC
11b6 : a9 00 __ LDA #$00
11b8 : e5 11 __ SBC P4 ; (v + 0)
11ba : 85 11 __ STA P4 ; (v + 0)
11bc : a9 00 __ LDA #$00
11be : e5 12 __ SBC P5 ; (v + 1)
11c0 : 85 12 __ STA P5 ; (v + 1)
11c2 : a9 01 __ LDA #$01
11c4 : 85 43 __ STA T1 + 0 
.s159:
11c6 : a9 10 __ LDA #$10
11c8 : 85 44 __ STA T2 + 0 
11ca : a5 11 __ LDA P4 ; (v + 0)
11cc : 05 12 __ ORA P5 ; (v + 1)
11ce : f0 61 __ BEQ $1231 ; (nformi.s7 + 0)
.s45:
11d0 : a5 0d __ LDA P0 ; (si + 0)
11d2 : 85 45 __ STA T4 + 0 
11d4 : a5 0e __ LDA P1 ; (si + 1)
11d6 : 85 46 __ STA T4 + 1 
.l6:
11d8 : a0 03 __ LDY #$03
11da : b1 45 __ LDA (T4 + 0),y 
11dc : 85 47 __ STA T5 + 0 
11de : 85 03 __ STA WORK + 0 
11e0 : c8 __ __ INY
11e1 : b1 45 __ LDA (T4 + 0),y 
11e3 : 85 48 __ STA T5 + 1 
11e5 : 85 04 __ STA WORK + 1 
11e7 : a5 11 __ LDA P4 ; (v + 0)
11e9 : 85 1b __ STA ACCU + 0 
11eb : a5 12 __ LDA P5 ; (v + 1)
11ed : 85 1c __ STA ACCU + 1 
11ef : 20 e0 24 JSR $24e0 ; (divmod + 0)
11f2 : a5 06 __ LDA WORK + 3 
11f4 : 30 10 __ BMI $1206 ; (nformi.s9 + 0)
.s1019:
11f6 : d0 06 __ BNE $11fe ; (nformi.s8 + 0)
.s1018:
11f8 : a5 05 __ LDA WORK + 2 
11fa : c9 0a __ CMP #$0a
11fc : 90 08 __ BCC $1206 ; (nformi.s9 + 0)
.s8:
11fe : 18 __ __ CLC
11ff : a5 05 __ LDA WORK + 2 
1201 : 69 37 __ ADC #$37
1203 : 4c 0b 12 JMP $120b ; (nformi.s10 + 0)
.s9:
1206 : 18 __ __ CLC
1207 : a5 05 __ LDA WORK + 2 
1209 : 69 30 __ ADC #$30
.s10:
120b : c6 44 __ DEC T2 + 0 
120d : a6 44 __ LDX T2 + 0 
120f : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1212 : a5 11 __ LDA P4 ; (v + 0)
1214 : 85 1b __ STA ACCU + 0 
1216 : a5 12 __ LDA P5 ; (v + 1)
1218 : 85 1c __ STA ACCU + 1 
121a : a5 47 __ LDA T5 + 0 
121c : 85 03 __ STA WORK + 0 
121e : a5 48 __ LDA T5 + 1 
1220 : 85 04 __ STA WORK + 1 
1222 : 20 e0 24 JSR $24e0 ; (divmod + 0)
1225 : a5 1b __ LDA ACCU + 0 
1227 : 85 11 __ STA P4 ; (v + 0)
1229 : a5 1c __ LDA ACCU + 1 
122b : 85 12 __ STA P5 ; (v + 1)
122d : 05 11 __ ORA P4 ; (v + 0)
122f : d0 a7 __ BNE $11d8 ; (nformi.l6 + 0)
.s7:
1231 : a5 0d __ LDA P0 ; (si + 0)
1233 : 85 11 __ STA P4 ; (v + 0)
1235 : a5 0e __ LDA P1 ; (si + 1)
1237 : 85 12 __ STA P5 ; (v + 1)
1239 : a0 02 __ LDY #$02
123b : b1 0d __ LDA (P0),y ; (si + 0)
123d : c9 ff __ CMP #$ff
123f : d0 04 __ BNE $1245 ; (nformi.s76 + 0)
.s77:
1241 : a9 0f __ LDA #$0f
1243 : d0 05 __ BNE $124a ; (nformi.s1026 + 0)
.s76:
1245 : 38 __ __ SEC
1246 : a9 10 __ LDA #$10
1248 : f1 0d __ SBC (P0),y ; (si + 0)
.s1026:
124a : a8 __ __ TAY
124b : c4 44 __ CPY T2 + 0 
124d : b0 0d __ BCS $125c ; (nformi.s13 + 0)
.s12:
124f : a9 30 __ LDA #$30
.l1027:
1251 : c6 44 __ DEC T2 + 0 
1253 : a6 44 __ LDX T2 + 0 
1255 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1258 : c4 44 __ CPY T2 + 0 
125a : 90 f5 __ BCC $1251 ; (nformi.l1027 + 0)
.s13:
125c : a0 07 __ LDY #$07
125e : b1 0d __ LDA (P0),y ; (si + 0)
1260 : f0 20 __ BEQ $1282 ; (nformi.s16 + 0)
.s17:
1262 : a0 04 __ LDY #$04
1264 : b1 0d __ LDA (P0),y ; (si + 0)
1266 : d0 1a __ BNE $1282 ; (nformi.s16 + 0)
.s1013:
1268 : 88 __ __ DEY
1269 : b1 0d __ LDA (P0),y ; (si + 0)
126b : c9 10 __ CMP #$10
126d : d0 13 __ BNE $1282 ; (nformi.s16 + 0)
.s14:
126f : a9 58 __ LDA #$58
1271 : a6 44 __ LDX T2 + 0 
1273 : 9d e7 9f STA $9fe7,x ; (si + 7)
1276 : 8a __ __ TXA
1277 : 18 __ __ CLC
1278 : 69 fe __ ADC #$fe
127a : 85 44 __ STA T2 + 0 
127c : aa __ __ TAX
127d : a9 30 __ LDA #$30
127f : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s16:
1282 : a9 00 __ LDA #$00
1284 : 85 1b __ STA ACCU + 0 
1286 : a5 43 __ LDA T1 + 0 
1288 : f0 06 __ BEQ $1290 ; (nformi.s19 + 0)
.s18:
128a : c6 44 __ DEC T2 + 0 
128c : a9 2d __ LDA #$2d
128e : d0 0a __ BNE $129a ; (nformi.s1025 + 0)
.s19:
1290 : a0 05 __ LDY #$05
1292 : b1 0d __ LDA (P0),y ; (si + 0)
1294 : f0 09 __ BEQ $129f ; (nformi.s141 + 0)
.s21:
1296 : c6 44 __ DEC T2 + 0 
1298 : a9 2b __ LDA #$2b
.s1025:
129a : a6 44 __ LDX T2 + 0 
129c : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s141:
129f : a0 06 __ LDY #$06
12a1 : b1 0d __ LDA (P0),y ; (si + 0)
12a3 : d0 37 __ BNE $12dc ; (nformi.s27 + 0)
.l33:
12a5 : a0 01 __ LDY #$01
12a7 : b1 11 __ LDA (P4),y ; (v + 0)
12a9 : 18 __ __ CLC
12aa : 65 44 __ ADC T2 + 0 
12ac : b0 04 __ BCS $12b2 ; (nformi.s34 + 0)
.s1006:
12ae : c9 11 __ CMP #$11
12b0 : 90 0e __ BCC $12c0 ; (nformi.s36 + 0)
.s34:
12b2 : c6 44 __ DEC T2 + 0 
12b4 : a0 00 __ LDY #$00
12b6 : b1 11 __ LDA (P4),y ; (v + 0)
12b8 : a6 44 __ LDX T2 + 0 
12ba : 9d e8 9f STA $9fe8,x ; (buffer + 0)
12bd : 4c a5 12 JMP $12a5 ; (nformi.l33 + 0)
.s36:
12c0 : a6 44 __ LDX T2 + 0 
12c2 : e0 10 __ CPX #$10
12c4 : b0 11 __ BCS $12d7 ; (nformi.s26 + 0)
.s1022:
12c6 : 88 __ __ DEY
.l1031:
12c7 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
12ca : 91 0f __ STA (P2),y ; (str + 0)
12cc : e6 44 __ INC T2 + 0 
12ce : a6 44 __ LDX T2 + 0 
12d0 : e0 10 __ CPX #$10
12d2 : c8 __ __ INY
12d3 : 90 f2 __ BCC $12c7 ; (nformi.l1031 + 0)
.s1032:
12d5 : 84 1b __ STY ACCU + 0 
.s26:
12d7 : a9 00 __ LDA #$00
12d9 : 85 1c __ STA ACCU + 1 
.s1001:
12db : 60 __ __ RTS
.s27:
12dc : a6 44 __ LDX T2 + 0 
12de : e0 10 __ CPX #$10
12e0 : b0 12 __ BCS $12f4 ; (nformi.l30 + 0)
.s1020:
12e2 : a0 00 __ LDY #$00
.l1029:
12e4 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
12e7 : 91 0f __ STA (P2),y ; (str + 0)
12e9 : e6 44 __ INC T2 + 0 
12eb : a6 44 __ LDX T2 + 0 
12ed : e0 10 __ CPX #$10
12ef : c8 __ __ INY
12f0 : 90 f2 __ BCC $12e4 ; (nformi.l1029 + 0)
.s1030:
12f2 : 84 1b __ STY ACCU + 0 
.l30:
12f4 : a5 1b __ LDA ACCU + 0 
12f6 : a0 01 __ LDY #$01
12f8 : d1 11 __ CMP (P4),y ; (v + 0)
12fa : b0 db __ BCS $12d7 ; (nformi.s26 + 0)
.s31:
12fc : 88 __ __ DEY
12fd : b1 11 __ LDA (P4),y ; (v + 0)
12ff : a4 1b __ LDY ACCU + 0 
1301 : 91 0f __ STA (P2),y ; (str + 0)
1303 : e6 1b __ INC ACCU + 0 
1305 : 4c f4 12 JMP $12f4 ; (nformi.l30 + 0)
--------------------------------------------------------------------
nforml:
.s0:
1308 : a9 00 __ LDA #$00
130a : 85 43 __ STA T1 + 0 
130c : a5 15 __ LDA P8 ; (s + 0)
130e : f0 23 __ BEQ $1333 ; (nforml.s159 + 0)
.s4:
1310 : a5 14 __ LDA P7 ; (v + 3)
1312 : f0 1f __ BEQ $1333 ; (nforml.s159 + 0)
.s1032:
1314 : 10 1d __ BPL $1333 ; (nforml.s159 + 0)
.s1:
1316 : 38 __ __ SEC
1317 : a9 00 __ LDA #$00
1319 : e5 11 __ SBC P4 ; (v + 0)
131b : 85 11 __ STA P4 ; (v + 0)
131d : a9 00 __ LDA #$00
131f : e5 12 __ SBC P5 ; (v + 1)
1321 : 85 12 __ STA P5 ; (v + 1)
1323 : a9 00 __ LDA #$00
1325 : e5 13 __ SBC P6 ; (v + 2)
1327 : 85 13 __ STA P6 ; (v + 2)
1329 : a9 00 __ LDA #$00
132b : e5 14 __ SBC P7 ; (v + 3)
132d : 85 14 __ STA P7 ; (v + 3)
132f : a9 01 __ LDA #$01
1331 : 85 43 __ STA T1 + 0 
.s159:
1333 : a9 10 __ LDA #$10
1335 : 85 44 __ STA T2 + 0 
1337 : a5 14 __ LDA P7 ; (v + 3)
1339 : f0 03 __ BEQ $133e ; (nforml.s1018 + 0)
133b : 4c 22 14 JMP $1422 ; (nforml.l6 + 0)
.s1018:
133e : a5 13 __ LDA P6 ; (v + 2)
1340 : f0 03 __ BEQ $1345 ; (nforml.s1019 + 0)
1342 : 4c 22 14 JMP $1422 ; (nforml.l6 + 0)
.s1019:
1345 : a5 12 __ LDA P5 ; (v + 1)
1347 : f0 03 __ BEQ $134c ; (nforml.s1020 + 0)
1349 : 4c 22 14 JMP $1422 ; (nforml.l6 + 0)
.s1020:
134c : c5 11 __ CMP P4 ; (v + 0)
134e : b0 03 __ BCS $1353 ; (nforml.s7 + 0)
1350 : 4c 22 14 JMP $1422 ; (nforml.l6 + 0)
.s7:
1353 : a0 02 __ LDY #$02
1355 : b1 0d __ LDA (P0),y ; (si + 0)
1357 : c9 ff __ CMP #$ff
1359 : d0 04 __ BNE $135f ; (nforml.s76 + 0)
.s77:
135b : a9 0f __ LDA #$0f
135d : d0 05 __ BNE $1364 ; (nforml.s1039 + 0)
.s76:
135f : 38 __ __ SEC
1360 : a9 10 __ LDA #$10
1362 : f1 0d __ SBC (P0),y ; (si + 0)
.s1039:
1364 : a8 __ __ TAY
1365 : c4 44 __ CPY T2 + 0 
1367 : b0 0d __ BCS $1376 ; (nforml.s13 + 0)
.s12:
1369 : a9 30 __ LDA #$30
.l1040:
136b : c6 44 __ DEC T2 + 0 
136d : a6 44 __ LDX T2 + 0 
136f : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1372 : c4 44 __ CPY T2 + 0 
1374 : 90 f5 __ BCC $136b ; (nforml.l1040 + 0)
.s13:
1376 : a0 07 __ LDY #$07
1378 : b1 0d __ LDA (P0),y ; (si + 0)
137a : f0 20 __ BEQ $139c ; (nforml.s16 + 0)
.s17:
137c : a0 04 __ LDY #$04
137e : b1 0d __ LDA (P0),y ; (si + 0)
1380 : d0 1a __ BNE $139c ; (nforml.s16 + 0)
.s1013:
1382 : 88 __ __ DEY
1383 : b1 0d __ LDA (P0),y ; (si + 0)
1385 : c9 10 __ CMP #$10
1387 : d0 13 __ BNE $139c ; (nforml.s16 + 0)
.s14:
1389 : a9 58 __ LDA #$58
138b : a6 44 __ LDX T2 + 0 
138d : 9d e7 9f STA $9fe7,x ; (si + 7)
1390 : 8a __ __ TXA
1391 : 18 __ __ CLC
1392 : 69 fe __ ADC #$fe
1394 : 85 44 __ STA T2 + 0 
1396 : aa __ __ TAX
1397 : a9 30 __ LDA #$30
1399 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s16:
139c : a9 00 __ LDA #$00
139e : 85 1b __ STA ACCU + 0 
13a0 : a5 43 __ LDA T1 + 0 
13a2 : f0 06 __ BEQ $13aa ; (nforml.s19 + 0)
.s18:
13a4 : c6 44 __ DEC T2 + 0 
13a6 : a9 2d __ LDA #$2d
13a8 : d0 0a __ BNE $13b4 ; (nforml.s1038 + 0)
.s19:
13aa : a0 05 __ LDY #$05
13ac : b1 0d __ LDA (P0),y ; (si + 0)
13ae : f0 09 __ BEQ $13b9 ; (nforml.s141 + 0)
.s21:
13b0 : c6 44 __ DEC T2 + 0 
13b2 : a9 2b __ LDA #$2b
.s1038:
13b4 : a6 44 __ LDX T2 + 0 
13b6 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s141:
13b9 : a0 06 __ LDY #$06
13bb : b1 0d __ LDA (P0),y ; (si + 0)
13bd : d0 37 __ BNE $13f6 ; (nforml.s27 + 0)
.l33:
13bf : a0 01 __ LDY #$01
13c1 : b1 0d __ LDA (P0),y ; (si + 0)
13c3 : 18 __ __ CLC
13c4 : 65 44 __ ADC T2 + 0 
13c6 : b0 04 __ BCS $13cc ; (nforml.s34 + 0)
.s1006:
13c8 : c9 11 __ CMP #$11
13ca : 90 0e __ BCC $13da ; (nforml.s36 + 0)
.s34:
13cc : c6 44 __ DEC T2 + 0 
13ce : a0 00 __ LDY #$00
13d0 : b1 0d __ LDA (P0),y ; (si + 0)
13d2 : a6 44 __ LDX T2 + 0 
13d4 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
13d7 : 4c bf 13 JMP $13bf ; (nforml.l33 + 0)
.s36:
13da : a6 44 __ LDX T2 + 0 
13dc : e0 10 __ CPX #$10
13de : b0 11 __ BCS $13f1 ; (nforml.s26 + 0)
.s1035:
13e0 : 88 __ __ DEY
.l1044:
13e1 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
13e4 : 91 0f __ STA (P2),y ; (str + 0)
13e6 : e6 44 __ INC T2 + 0 
13e8 : a6 44 __ LDX T2 + 0 
13ea : e0 10 __ CPX #$10
13ec : c8 __ __ INY
13ed : 90 f2 __ BCC $13e1 ; (nforml.l1044 + 0)
.s1045:
13ef : 84 1b __ STY ACCU + 0 
.s26:
13f1 : a9 00 __ LDA #$00
13f3 : 85 1c __ STA ACCU + 1 
.s1001:
13f5 : 60 __ __ RTS
.s27:
13f6 : a6 44 __ LDX T2 + 0 
13f8 : e0 10 __ CPX #$10
13fa : b0 12 __ BCS $140e ; (nforml.l30 + 0)
.s1033:
13fc : a0 00 __ LDY #$00
.l1042:
13fe : bd e8 9f LDA $9fe8,x ; (buffer + 0)
1401 : 91 0f __ STA (P2),y ; (str + 0)
1403 : e6 44 __ INC T2 + 0 
1405 : a6 44 __ LDX T2 + 0 
1407 : e0 10 __ CPX #$10
1409 : c8 __ __ INY
140a : 90 f2 __ BCC $13fe ; (nforml.l1042 + 0)
.s1043:
140c : 84 1b __ STY ACCU + 0 
.l30:
140e : a5 1b __ LDA ACCU + 0 
1410 : a0 01 __ LDY #$01
1412 : d1 0d __ CMP (P0),y ; (si + 0)
1414 : b0 db __ BCS $13f1 ; (nforml.s26 + 0)
.s31:
1416 : 88 __ __ DEY
1417 : b1 0d __ LDA (P0),y ; (si + 0)
1419 : a4 1b __ LDY ACCU + 0 
141b : 91 0f __ STA (P2),y ; (str + 0)
141d : e6 1b __ INC ACCU + 0 
141f : 4c 0e 14 JMP $140e ; (nforml.l30 + 0)
.l6:
1422 : a0 03 __ LDY #$03
1424 : b1 0d __ LDA (P0),y ; (si + 0)
1426 : 85 03 __ STA WORK + 0 
1428 : 85 45 __ STA T6 + 0 
142a : c8 __ __ INY
142b : b1 0d __ LDA (P0),y ; (si + 0)
142d : 85 46 __ STA T6 + 1 
142f : 85 04 __ STA WORK + 1 
1431 : a5 11 __ LDA P4 ; (v + 0)
1433 : 85 1b __ STA ACCU + 0 
1435 : a5 12 __ LDA P5 ; (v + 1)
1437 : 85 1c __ STA ACCU + 1 
1439 : a5 13 __ LDA P6 ; (v + 2)
143b : 85 1d __ STA ACCU + 2 
143d : a5 14 __ LDA P7 ; (v + 3)
143f : 85 1e __ STA ACCU + 3 
1441 : a9 00 __ LDA #$00
1443 : 85 05 __ STA WORK + 2 
1445 : 85 06 __ STA WORK + 3 
1447 : 20 1b 26 JSR $261b ; (divmod32 + 0)
144a : a5 08 __ LDA WORK + 5 
144c : 30 10 __ BMI $145e ; (nforml.s9 + 0)
.s1023:
144e : d0 06 __ BNE $1456 ; (nforml.s8 + 0)
.s1022:
1450 : a5 07 __ LDA WORK + 4 
1452 : c9 0a __ CMP #$0a
1454 : 90 08 __ BCC $145e ; (nforml.s9 + 0)
.s8:
1456 : 18 __ __ CLC
1457 : a5 07 __ LDA WORK + 4 
1459 : 69 37 __ ADC #$37
145b : 4c 63 14 JMP $1463 ; (nforml.s10 + 0)
.s9:
145e : 18 __ __ CLC
145f : a5 07 __ LDA WORK + 4 
1461 : 69 30 __ ADC #$30
.s10:
1463 : c6 44 __ DEC T2 + 0 
1465 : a6 44 __ LDX T2 + 0 
1467 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
146a : a5 11 __ LDA P4 ; (v + 0)
146c : 85 1b __ STA ACCU + 0 
146e : a5 12 __ LDA P5 ; (v + 1)
1470 : 85 1c __ STA ACCU + 1 
1472 : a5 13 __ LDA P6 ; (v + 2)
1474 : 85 1d __ STA ACCU + 2 
1476 : a5 14 __ LDA P7 ; (v + 3)
1478 : 85 1e __ STA ACCU + 3 
147a : a5 45 __ LDA T6 + 0 
147c : 85 03 __ STA WORK + 0 
147e : a5 46 __ LDA T6 + 1 
1480 : 85 04 __ STA WORK + 1 
1482 : a9 00 __ LDA #$00
1484 : 85 05 __ STA WORK + 2 
1486 : 85 06 __ STA WORK + 3 
1488 : 20 1b 26 JSR $261b ; (divmod32 + 0)
148b : a5 1b __ LDA ACCU + 0 
148d : 85 11 __ STA P4 ; (v + 0)
148f : a5 1c __ LDA ACCU + 1 
1491 : 85 12 __ STA P5 ; (v + 1)
1493 : a5 1d __ LDA ACCU + 2 
1495 : 85 13 __ STA P6 ; (v + 2)
1497 : a5 1e __ LDA ACCU + 3 
1499 : 85 14 __ STA P7 ; (v + 3)
149b : d0 85 __ BNE $1422 ; (nforml.l6 + 0)
149d : 4c 3e 13 JMP $133e ; (nforml.s1018 + 0)
--------------------------------------------------------------------
nformf:
.s0:
14a0 : a5 15 __ LDA P8 ; (f + 0)
14a2 : 85 43 __ STA T1 + 0 
14a4 : a5 16 __ LDA P9 ; (f + 1)
14a6 : 85 44 __ STA T1 + 1 
14a8 : a5 17 __ LDA P10 ; (f + 2)
14aa : 85 45 __ STA T1 + 2 
14ac : a5 18 __ LDA P11 ; (f + 3)
14ae : 29 7f __ AND #$7f
14b0 : 05 17 __ ORA P10 ; (f + 2)
14b2 : 05 16 __ ORA P9 ; (f + 1)
14b4 : 05 15 __ ORA P8 ; (f + 0)
14b6 : f0 21 __ BEQ $14d9 ; (nformf.s2 + 0)
.s1075:
14b8 : a5 18 __ LDA P11 ; (f + 3)
14ba : 10 1d __ BPL $14d9 ; (nformf.s2 + 0)
.s1:
14bc : a9 2d __ LDA #$2d
14be : a0 00 __ LDY #$00
14c0 : 91 13 __ STA (P6),y ; (str + 0)
14c2 : a5 18 __ LDA P11 ; (f + 3)
14c4 : 49 80 __ EOR #$80
14c6 : 85 18 __ STA P11 ; (f + 3)
14c8 : 85 10 __ STA P3 
14ca : a5 15 __ LDA P8 ; (f + 0)
14cc : 85 0d __ STA P0 
14ce : a5 16 __ LDA P9 ; (f + 1)
14d0 : 85 0e __ STA P1 
14d2 : a5 17 __ LDA P10 ; (f + 2)
14d4 : 85 0f __ STA P2 
14d6 : 4c 59 19 JMP $1959 ; (nformf.s189 + 0)
.s2:
14d9 : a5 15 __ LDA P8 ; (f + 0)
14db : 85 0d __ STA P0 
14dd : a5 16 __ LDA P9 ; (f + 1)
14df : 85 0e __ STA P1 
14e1 : a5 17 __ LDA P10 ; (f + 2)
14e3 : 85 0f __ STA P2 
14e5 : a5 18 __ LDA P11 ; (f + 3)
14e7 : 85 10 __ STA P3 
14e9 : a0 05 __ LDY #$05
14eb : b1 11 __ LDA (P4),y ; (si + 0)
14ed : f0 09 __ BEQ $14f8 ; (nformf.s3 + 0)
.s4:
14ef : a9 2b __ LDA #$2b
14f1 : a0 00 __ LDY #$00
14f3 : 91 13 __ STA (P6),y ; (str + 0)
14f5 : 4c 59 19 JMP $1959 ; (nformf.s189 + 0)
.s3:
14f8 : 20 71 19 JSR $1971 ; (isinf.s0 + 0)
14fb : aa __ __ TAX
14fc : a9 00 __ LDA #$00
14fe : 85 48 __ STA T3 + 0 
1500 : 8a __ __ TXA
1501 : f0 0b __ BEQ $150e ; (nformf.s8 + 0)
.s160:
1503 : a9 01 __ LDA #$01
1505 : 85 4a __ STA T5 + 0 
1507 : a9 02 __ LDA #$02
1509 : a0 00 __ LDY #$00
150b : 4c 3d 19 JMP $193d ; (nformf.s7 + 0)
.s8:
150e : a0 02 __ LDY #$02
1510 : b1 11 __ LDA (P4),y ; (si + 0)
1512 : c9 ff __ CMP #$ff
1514 : d0 02 __ BNE $1518 ; (nformf.s128 + 0)
.s129:
1516 : a9 06 __ LDA #$06
.s128:
1518 : 86 4a __ STX T5 + 0 
151a : 86 4b __ STX T5 + 1 
151c : 85 49 __ STA T4 + 0 
151e : 85 47 __ STA T2 + 0 
1520 : a5 18 __ LDA P11 ; (f + 3)
1522 : 85 46 __ STA T1 + 3 
1524 : 29 7f __ AND #$7f
1526 : 05 17 __ ORA P10 ; (f + 2)
1528 : 05 16 __ ORA P9 ; (f + 1)
152a : 05 15 __ ORA P8 ; (f + 0)
152c : f0 03 __ BEQ $1531 ; (nformf.s12 + 0)
152e : 4c 3e 18 JMP $183e ; (nformf.s13 + 0)
.s12:
1531 : ad f8 9f LDA $9ff8 ; (sstack + 0)
1534 : c9 65 __ CMP #$65
1536 : d0 04 __ BNE $153c ; (nformf.s1003 + 0)
.s1002:
1538 : a9 01 __ LDA #$01
153a : d0 02 __ BNE $153e ; (nformf.s1004 + 0)
.s1003:
153c : a9 00 __ LDA #$00
.s1004:
153e : 85 4e __ STA T9 + 0 
1540 : a6 49 __ LDX T4 + 0 
1542 : e8 __ __ INX
1543 : 86 4c __ STX T8 + 0 
1545 : ad f8 9f LDA $9ff8 ; (sstack + 0)
1548 : c9 67 __ CMP #$67
154a : d0 13 __ BNE $155f ; (nformf.s24 + 0)
.s22:
154c : a5 4b __ LDA T5 + 1 
154e : 30 08 __ BMI $1558 ; (nformf.s25 + 0)
.s1046:
1550 : d0 06 __ BNE $1558 ; (nformf.s25 + 0)
.s1045:
1552 : a5 4a __ LDA T5 + 0 
1554 : c9 04 __ CMP #$04
1556 : 90 07 __ BCC $155f ; (nformf.s24 + 0)
.s25:
1558 : a9 01 __ LDA #$01
155a : 85 4e __ STA T9 + 0 
155c : 4c b6 17 JMP $17b6 ; (nformf.s30 + 0)
.s24:
155f : a5 4e __ LDA T9 + 0 
1561 : f0 03 __ BEQ $1566 ; (nformf.s32 + 0)
1563 : 4c b6 17 JMP $17b6 ; (nformf.s30 + 0)
.s32:
1566 : a5 4b __ LDA T5 + 1 
1568 : 10 3e __ BPL $15a8 ; (nformf.s34 + 0)
.s33:
156a : a5 43 __ LDA T1 + 0 
156c : 85 1b __ STA ACCU + 0 
156e : a5 44 __ LDA T1 + 1 
1570 : 85 1c __ STA ACCU + 1 
1572 : a5 45 __ LDA T1 + 2 
1574 : 85 1d __ STA ACCU + 2 
1576 : a5 46 __ LDA T1 + 3 
1578 : 85 1e __ STA ACCU + 3 
.l1082:
157a : e6 4a __ INC T5 + 0 
157c : d0 02 __ BNE $1580 ; (nformf.s1092 + 0)
.s1091:
157e : e6 4b __ INC T5 + 1 
.s1092:
1580 : a9 00 __ LDA #$00
1582 : 85 03 __ STA WORK + 0 
1584 : 85 04 __ STA WORK + 1 
1586 : a9 20 __ LDA #$20
1588 : 85 05 __ STA WORK + 2 
158a : a9 41 __ LDA #$41
158c : 85 06 __ STA WORK + 3 
158e : 20 11 22 JSR $2211 ; (freg + 20)
1591 : 20 f8 23 JSR $23f8 ; (fdiv + 0)
1594 : a5 4b __ LDA T5 + 1 
1596 : 30 e2 __ BMI $157a ; (nformf.l1082 + 0)
.s1083:
1598 : a5 1e __ LDA ACCU + 3 
159a : 85 46 __ STA T1 + 3 
159c : a5 1d __ LDA ACCU + 2 
159e : 85 45 __ STA T1 + 2 
15a0 : a5 1c __ LDA ACCU + 1 
15a2 : 85 44 __ STA T1 + 1 
15a4 : a5 1b __ LDA ACCU + 0 
15a6 : 85 43 __ STA T1 + 0 
.s34:
15a8 : 18 __ __ CLC
15a9 : a5 49 __ LDA T4 + 0 
15ab : 65 4a __ ADC T5 + 0 
15ad : 18 __ __ CLC
15ae : 69 01 __ ADC #$01
15b0 : 85 4c __ STA T8 + 0 
15b2 : c9 07 __ CMP #$07
15b4 : 90 13 __ BCC $15c9 ; (nformf.s35 + 0)
.s36:
15b6 : ad 59 27 LDA $2759 ; (fround5 + 25)
15b9 : 85 1c __ STA ACCU + 1 
15bb : ad 5a 27 LDA $275a ; (fround5 + 26)
15be : 85 1d __ STA ACCU + 2 
15c0 : ad 5b 27 LDA $275b ; (fround5 + 27)
15c3 : ae 58 27 LDX $2758 ; (fround5 + 24)
15c6 : 4c dc 15 JMP $15dc ; (nformf.s214 + 0)
.s35:
15c9 : 0a __ __ ASL
15ca : 0a __ __ ASL
15cb : a8 __ __ TAY
15cc : b9 3d 27 LDA $273d,y ; (p2smap + 5)
15cf : 85 1c __ STA ACCU + 1 
15d1 : b9 3e 27 LDA $273e,y ; (p2smap + 6)
15d4 : 85 1d __ STA ACCU + 2 
15d6 : b9 3f 27 LDA $273f,y ; (p2smap + 7)
15d9 : be 3c 27 LDX $273c,y ; (p2smap + 4)
.s214:
15dc : 86 1b __ STX ACCU + 0 
15de : 85 1e __ STA ACCU + 3 
15e0 : a2 43 __ LDX #$43
15e2 : 20 01 22 JSR $2201 ; (freg + 4)
15e5 : 20 42 22 JSR $2242 ; (faddsub + 0)
15e8 : a5 1c __ LDA ACCU + 1 
15ea : 85 16 __ STA P9 ; (f + 1)
15ec : a5 1d __ LDA ACCU + 2 
15ee : 85 17 __ STA P10 ; (f + 2)
15f0 : a6 1b __ LDX ACCU + 0 
15f2 : a5 1e __ LDA ACCU + 3 
15f4 : 85 18 __ STA P11 ; (f + 3)
15f6 : 30 35 __ BMI $162d ; (nformf.s31 + 0)
.s1028:
15f8 : c9 41 __ CMP #$41
15fa : d0 06 __ BNE $1602 ; (nformf.s1032 + 0)
.s1029:
15fc : a5 17 __ LDA P10 ; (f + 2)
15fe : c9 20 __ CMP #$20
1600 : f0 02 __ BEQ $1604 ; (nformf.s38 + 0)
.s1032:
1602 : 90 29 __ BCC $162d ; (nformf.s31 + 0)
.s38:
1604 : a9 00 __ LDA #$00
1606 : 85 03 __ STA WORK + 0 
1608 : 85 04 __ STA WORK + 1 
160a : a9 20 __ LDA #$20
160c : 85 05 __ STA WORK + 2 
160e : a9 41 __ LDA #$41
1610 : 85 06 __ STA WORK + 3 
1612 : 20 11 22 JSR $2211 ; (freg + 20)
1615 : 20 f8 23 JSR $23f8 ; (fdiv + 0)
1618 : a5 1c __ LDA ACCU + 1 
161a : 85 16 __ STA P9 ; (f + 1)
161c : a5 1d __ LDA ACCU + 2 
161e : 85 17 __ STA P10 ; (f + 2)
1620 : a5 1e __ LDA ACCU + 3 
1622 : 85 18 __ STA P11 ; (f + 3)
1624 : 18 __ __ CLC
1625 : a5 49 __ LDA T4 + 0 
1627 : 69 ff __ ADC #$ff
1629 : 85 47 __ STA T2 + 0 
162b : a6 1b __ LDX ACCU + 0 
.s31:
162d : 38 __ __ SEC
162e : a5 4c __ LDA T8 + 0 
1630 : e5 47 __ SBC T2 + 0 
1632 : 85 49 __ STA T4 + 0 
1634 : a9 14 __ LDA #$14
1636 : c5 4c __ CMP T8 + 0 
1638 : b0 02 __ BCS $163c ; (nformf.s49 + 0)
.s47:
163a : 85 4c __ STA T8 + 0 
.s49:
163c : a5 49 __ LDA T4 + 0 
163e : d0 08 __ BNE $1648 ; (nformf.s219 + 0)
.s50:
1640 : a9 30 __ LDA #$30
1642 : a4 48 __ LDY T3 + 0 
1644 : 91 13 __ STA (P6),y ; (str + 0)
1646 : e6 48 __ INC T3 + 0 
.s219:
1648 : a9 00 __ LDA #$00
164a : 85 47 __ STA T2 + 0 
164c : c5 49 __ CMP T4 + 0 
164e : d0 08 __ BNE $1658 ; (nformf.l59 + 0)
.l57:
1650 : a9 2e __ LDA #$2e
1652 : a4 48 __ LDY T3 + 0 
1654 : 91 13 __ STA (P6),y ; (str + 0)
1656 : e6 48 __ INC T3 + 0 
.l59:
1658 : a5 47 __ LDA T2 + 0 
165a : c9 07 __ CMP #$07
165c : 90 04 __ BCC $1662 ; (nformf.s61 + 0)
.s60:
165e : a9 30 __ LDA #$30
1660 : d0 55 __ BNE $16b7 ; (nformf.s208 + 0)
.s61:
1662 : 86 1b __ STX ACCU + 0 
1664 : 86 43 __ STX T1 + 0 
1666 : a5 16 __ LDA P9 ; (f + 1)
1668 : 85 1c __ STA ACCU + 1 
166a : 85 44 __ STA T1 + 1 
166c : a5 17 __ LDA P10 ; (f + 2)
166e : 85 1d __ STA ACCU + 2 
1670 : 85 45 __ STA T1 + 2 
1672 : a5 18 __ LDA P11 ; (f + 3)
1674 : 85 1e __ STA ACCU + 3 
1676 : 85 46 __ STA T1 + 3 
1678 : 20 8e 25 JSR $258e ; (f32_to_i16 + 0)
167b : a5 1b __ LDA ACCU + 0 
167d : 85 4f __ STA T11 + 0 
167f : 20 d0 25 JSR $25d0 ; (sint16_to_float + 0)
1682 : a2 43 __ LDX #$43
1684 : 20 01 22 JSR $2201 ; (freg + 4)
1687 : a5 1e __ LDA ACCU + 3 
1689 : 49 80 __ EOR #$80
168b : 85 1e __ STA ACCU + 3 
168d : 20 42 22 JSR $2242 ; (faddsub + 0)
1690 : a9 00 __ LDA #$00
1692 : 85 03 __ STA WORK + 0 
1694 : 85 04 __ STA WORK + 1 
1696 : a9 20 __ LDA #$20
1698 : 85 05 __ STA WORK + 2 
169a : a9 41 __ LDA #$41
169c : 85 06 __ STA WORK + 3 
169e : 20 11 22 JSR $2211 ; (freg + 20)
16a1 : 20 29 23 JSR $2329 ; (fmul + 0)
16a4 : a5 1c __ LDA ACCU + 1 
16a6 : 85 16 __ STA P9 ; (f + 1)
16a8 : a5 1d __ LDA ACCU + 2 
16aa : 85 17 __ STA P10 ; (f + 2)
16ac : a5 1e __ LDA ACCU + 3 
16ae : 85 18 __ STA P11 ; (f + 3)
16b0 : 18 __ __ CLC
16b1 : a5 4f __ LDA T11 + 0 
16b3 : 69 30 __ ADC #$30
16b5 : a6 1b __ LDX ACCU + 0 
.s208:
16b7 : a4 48 __ LDY T3 + 0 
16b9 : 91 13 __ STA (P6),y ; (str + 0)
16bb : e6 48 __ INC T3 + 0 
16bd : e6 47 __ INC T2 + 0 
16bf : a5 47 __ LDA T2 + 0 
16c1 : c5 4c __ CMP T8 + 0 
16c3 : b0 07 __ BCS $16cc ; (nformf.s56 + 0)
.s54:
16c5 : c5 49 __ CMP T4 + 0 
16c7 : d0 8f __ BNE $1658 ; (nformf.l59 + 0)
16c9 : 4c 50 16 JMP $1650 ; (nformf.l57 + 0)
.s56:
16cc : a5 4e __ LDA T9 + 0 
16ce : f0 62 __ BEQ $1732 ; (nformf.s9 + 0)
.s63:
16d0 : a9 45 __ LDA #$45
16d2 : a4 48 __ LDY T3 + 0 
16d4 : 91 13 __ STA (P6),y ; (str + 0)
16d6 : c8 __ __ INY
16d7 : a5 4b __ LDA T5 + 1 
16d9 : 30 06 __ BMI $16e1 ; (nformf.s66 + 0)
.s67:
16db : a9 2b __ LDA #$2b
16dd : 91 13 __ STA (P6),y ; (str + 0)
16df : d0 11 __ BNE $16f2 ; (nformf.s68 + 0)
.s66:
16e1 : a9 2d __ LDA #$2d
16e3 : 91 13 __ STA (P6),y ; (str + 0)
16e5 : 38 __ __ SEC
16e6 : a9 00 __ LDA #$00
16e8 : e5 4a __ SBC T5 + 0 
16ea : 85 4a __ STA T5 + 0 
16ec : a9 00 __ LDA #$00
16ee : e5 4b __ SBC T5 + 1 
16f0 : 85 4b __ STA T5 + 1 
.s68:
16f2 : a5 4a __ LDA T5 + 0 
16f4 : 85 1b __ STA ACCU + 0 
16f6 : a5 4b __ LDA T5 + 1 
16f8 : 85 1c __ STA ACCU + 1 
16fa : a9 0a __ LDA #$0a
16fc : 85 03 __ STA WORK + 0 
16fe : a9 00 __ LDA #$00
1700 : 85 04 __ STA WORK + 1 
1702 : 20 a6 24 JSR $24a6 ; (divs16 + 0)
1705 : 18 __ __ CLC
1706 : a5 1b __ LDA ACCU + 0 
1708 : 69 30 __ ADC #$30
170a : a4 48 __ LDY T3 + 0 
170c : c8 __ __ INY
170d : c8 __ __ INY
170e : 91 13 __ STA (P6),y ; (str + 0)
1710 : a5 4a __ LDA T5 + 0 
1712 : 85 1b __ STA ACCU + 0 
1714 : a5 4b __ LDA T5 + 1 
1716 : 85 1c __ STA ACCU + 1 
1718 : a9 0a __ LDA #$0a
171a : 85 03 __ STA WORK + 0 
171c : a9 00 __ LDA #$00
171e : 85 04 __ STA WORK + 1 
1720 : 20 65 25 JSR $2565 ; (mods16 + 0)
1723 : 18 __ __ CLC
1724 : a5 05 __ LDA WORK + 2 
1726 : 69 30 __ ADC #$30
1728 : a4 48 __ LDY T3 + 0 
172a : c8 __ __ INY
172b : c8 __ __ INY
172c : c8 __ __ INY
172d : 91 13 __ STA (P6),y ; (str + 0)
172f : c8 __ __ INY
1730 : 84 48 __ STY T3 + 0 
.s9:
1732 : a5 11 __ LDA P4 ; (si + 0)
1734 : 85 4a __ STA T5 + 0 
1736 : a5 12 __ LDA P5 ; (si + 1)
1738 : 85 4b __ STA T5 + 1 
173a : a5 48 __ LDA T3 + 0 
173c : a0 01 __ LDY #$01
173e : d1 11 __ CMP (P4),y ; (si + 0)
1740 : b0 5d __ BCS $179f ; (nformf.s1001 + 0)
.s69:
1742 : a0 06 __ LDY #$06
1744 : b1 11 __ LDA (P4),y ; (si + 0)
1746 : f0 06 __ BEQ $174e ; (nformf.s73 + 0)
.s72:
1748 : a5 48 __ LDA T3 + 0 
174a : aa __ __ TAX
174b : 4c a6 17 JMP $17a6 ; (nformf.l75 + 0)
.s73:
174e : a5 48 __ LDA T3 + 0 
1750 : f0 2d __ BEQ $177f ; (nformf.s82 + 0)
.s90:
1752 : a9 01 __ LDA #$01
1754 : 85 47 __ STA T2 + 0 
1756 : a6 48 __ LDX T3 + 0 
1758 : 38 __ __ SEC
.l1080:
1759 : a0 01 __ LDY #$01
175b : b1 11 __ LDA (P4),y ; (si + 0)
175d : e5 47 __ SBC T2 + 0 
175f : 85 4c __ STA T8 + 0 
1761 : a9 ff __ LDA #$ff
1763 : 65 14 __ ADC P7 ; (str + 1)
1765 : 85 4d __ STA T8 + 1 
1767 : 8a __ __ TXA
1768 : 38 __ __ SEC
1769 : e5 47 __ SBC T2 + 0 
176b : 85 1b __ STA ACCU + 0 
176d : a9 ff __ LDA #$ff
176f : 65 14 __ ADC P7 ; (str + 1)
1771 : 85 1c __ STA ACCU + 1 
1773 : a4 13 __ LDY P6 ; (str + 0)
1775 : b1 1b __ LDA (ACCU + 0),y 
1777 : 91 4c __ STA (T8 + 0),y 
1779 : e6 47 __ INC T2 + 0 
177b : e4 47 __ CPX T2 + 0 
177d : b0 da __ BCS $1759 ; (nformf.l1080 + 0)
.s82:
177f : a9 00 __ LDA #$00
1781 : 85 47 __ STA T2 + 0 
.l83:
1783 : a0 01 __ LDY #$01
1785 : b1 4a __ LDA (T5 + 0),y 
1787 : 38 __ __ SEC
1788 : e5 48 __ SBC T3 + 0 
178a : 90 06 __ BCC $1792 ; (nformf.s84 + 0)
.s1007:
178c : c5 47 __ CMP T2 + 0 
178e : 90 0d __ BCC $179d ; (nformf.s74 + 0)
.s1084:
1790 : f0 0b __ BEQ $179d ; (nformf.s74 + 0)
.s84:
1792 : a9 20 __ LDA #$20
1794 : a4 47 __ LDY T2 + 0 
1796 : 91 13 __ STA (P6),y ; (str + 0)
1798 : e6 47 __ INC T2 + 0 
179a : 4c 83 17 JMP $1783 ; (nformf.l83 + 0)
.s74:
179d : b1 11 __ LDA (P4),y ; (si + 0)
.s1001:
179f : 85 1b __ STA ACCU + 0 
17a1 : a9 00 __ LDA #$00
17a3 : 85 1c __ STA ACCU + 1 
17a5 : 60 __ __ RTS
.l75:
17a6 : a0 01 __ LDY #$01
17a8 : d1 4a __ CMP (T5 + 0),y 
17aa : b0 f1 __ BCS $179d ; (nformf.s74 + 0)
.s76:
17ac : a8 __ __ TAY
17ad : a9 20 __ LDA #$20
17af : 91 13 __ STA (P6),y ; (str + 0)
17b1 : e8 __ __ INX
17b2 : 8a __ __ TXA
17b3 : 4c a6 17 JMP $17a6 ; (nformf.l75 + 0)
.s30:
17b6 : a5 4c __ LDA T8 + 0 
17b8 : c9 07 __ CMP #$07
17ba : 90 13 __ BCC $17cf ; (nformf.s41 + 0)
.s42:
17bc : ad 59 27 LDA $2759 ; (fround5 + 25)
17bf : 85 1c __ STA ACCU + 1 
17c1 : ad 5a 27 LDA $275a ; (fround5 + 26)
17c4 : 85 1d __ STA ACCU + 2 
17c6 : ad 5b 27 LDA $275b ; (fround5 + 27)
17c9 : ae 58 27 LDX $2758 ; (fround5 + 24)
17cc : 4c e2 17 JMP $17e2 ; (nformf.s204 + 0)
.s41:
17cf : 0a __ __ ASL
17d0 : 0a __ __ ASL
17d1 : a8 __ __ TAY
17d2 : b9 3d 27 LDA $273d,y ; (p2smap + 5)
17d5 : 85 1c __ STA ACCU + 1 
17d7 : b9 3e 27 LDA $273e,y ; (p2smap + 6)
17da : 85 1d __ STA ACCU + 2 
17dc : b9 3f 27 LDA $273f,y ; (p2smap + 7)
17df : be 3c 27 LDX $273c,y ; (p2smap + 4)
.s204:
17e2 : 86 1b __ STX ACCU + 0 
17e4 : 85 1e __ STA ACCU + 3 
17e6 : a2 43 __ LDX #$43
17e8 : 20 01 22 JSR $2201 ; (freg + 4)
17eb : 20 42 22 JSR $2242 ; (faddsub + 0)
17ee : a5 1c __ LDA ACCU + 1 
17f0 : 85 16 __ STA P9 ; (f + 1)
17f2 : a5 1d __ LDA ACCU + 2 
17f4 : 85 17 __ STA P10 ; (f + 2)
17f6 : a6 1b __ LDX ACCU + 0 
17f8 : a5 1e __ LDA ACCU + 3 
17fa : 85 18 __ STA P11 ; (f + 3)
17fc : 10 03 __ BPL $1801 ; (nformf.s1038 + 0)
17fe : 4c 2d 16 JMP $162d ; (nformf.s31 + 0)
.s1038:
1801 : c9 41 __ CMP #$41
1803 : d0 06 __ BNE $180b ; (nformf.s1042 + 0)
.s1039:
1805 : a5 17 __ LDA P10 ; (f + 2)
1807 : c9 20 __ CMP #$20
1809 : f0 05 __ BEQ $1810 ; (nformf.s44 + 0)
.s1042:
180b : b0 03 __ BCS $1810 ; (nformf.s44 + 0)
180d : 4c 2d 16 JMP $162d ; (nformf.s31 + 0)
.s44:
1810 : a9 00 __ LDA #$00
1812 : 85 03 __ STA WORK + 0 
1814 : 85 04 __ STA WORK + 1 
1816 : a9 20 __ LDA #$20
1818 : 85 05 __ STA WORK + 2 
181a : a9 41 __ LDA #$41
181c : 85 06 __ STA WORK + 3 
181e : 20 11 22 JSR $2211 ; (freg + 20)
1821 : 20 f8 23 JSR $23f8 ; (fdiv + 0)
1824 : a5 1c __ LDA ACCU + 1 
1826 : 85 16 __ STA P9 ; (f + 1)
1828 : a5 1d __ LDA ACCU + 2 
182a : 85 17 __ STA P10 ; (f + 2)
182c : a5 1e __ LDA ACCU + 3 
182e : 85 18 __ STA P11 ; (f + 3)
1830 : a6 1b __ LDX ACCU + 0 
1832 : e6 4a __ INC T5 + 0 
1834 : f0 03 __ BEQ $1839 ; (nformf.s1089 + 0)
1836 : 4c 2d 16 JMP $162d ; (nformf.s31 + 0)
.s1089:
1839 : e6 4b __ INC T5 + 1 
183b : 4c 2d 16 JMP $162d ; (nformf.s31 + 0)
.s13:
183e : a5 18 __ LDA P11 ; (f + 3)
1840 : 30 59 __ BMI $189b ; (nformf.l17 + 0)
.l1068:
1842 : c9 44 __ CMP #$44
1844 : f0 03 __ BEQ $1849 ; (nformf.s1069 + 0)
1846 : 4c 38 19 JMP $1938 ; (nformf.s1072 + 0)
.s1069:
1849 : a5 45 __ LDA T1 + 2 
184b : c9 7a __ CMP #$7a
184d : f0 03 __ BEQ $1852 ; (nformf.s1070 + 0)
184f : 4c 38 19 JMP $1938 ; (nformf.s1072 + 0)
.s1070:
1852 : a5 44 __ LDA T1 + 1 
1854 : d0 04 __ BNE $185a ; (nformf.s1079 + 0)
.s1071:
1856 : a5 43 __ LDA T1 + 0 
1858 : f0 02 __ BEQ $185c ; (nformf.s14 + 0)
.s1079:
185a : a5 43 __ LDA T1 + 0 
.s14:
185c : 85 1b __ STA ACCU + 0 
185e : a5 44 __ LDA T1 + 1 
1860 : 85 1c __ STA ACCU + 1 
1862 : a5 45 __ LDA T1 + 2 
1864 : 85 1d __ STA ACCU + 2 
1866 : a5 46 __ LDA T1 + 3 
1868 : 85 1e __ STA ACCU + 3 
186a : a9 00 __ LDA #$00
186c : 85 03 __ STA WORK + 0 
186e : 85 04 __ STA WORK + 1 
1870 : a9 7a __ LDA #$7a
1872 : 85 05 __ STA WORK + 2 
1874 : a9 44 __ LDA #$44
1876 : 85 06 __ STA WORK + 3 
1878 : 20 11 22 JSR $2211 ; (freg + 20)
187b : 20 f8 23 JSR $23f8 ; (fdiv + 0)
187e : a5 1b __ LDA ACCU + 0 
1880 : 85 43 __ STA T1 + 0 
1882 : a5 1c __ LDA ACCU + 1 
1884 : 85 44 __ STA T1 + 1 
1886 : a5 1d __ LDA ACCU + 2 
1888 : 85 45 __ STA T1 + 2 
188a : 18 __ __ CLC
188b : a5 4a __ LDA T5 + 0 
188d : 69 03 __ ADC #$03
188f : 85 4a __ STA T5 + 0 
1891 : 90 02 __ BCC $1895 ; (nformf.s1094 + 0)
.s1093:
1893 : e6 4b __ INC T5 + 1 
.s1094:
1895 : a5 1e __ LDA ACCU + 3 
1897 : 85 46 __ STA T1 + 3 
1899 : 10 a7 __ BPL $1842 ; (nformf.l1068 + 0)
.l17:
189b : a9 00 __ LDA #$00
189d : 85 1b __ STA ACCU + 0 
189f : 85 1c __ STA ACCU + 1 
18a1 : a9 7a __ LDA #$7a
18a3 : 85 1d __ STA ACCU + 2 
18a5 : a9 44 __ LDA #$44
18a7 : 85 1e __ STA ACCU + 3 
18a9 : a2 43 __ LDX #$43
18ab : 20 01 22 JSR $2201 ; (freg + 4)
18ae : 20 29 23 JSR $2329 ; (fmul + 0)
18b1 : a5 1b __ LDA ACCU + 0 
18b3 : 85 43 __ STA T1 + 0 
18b5 : a5 1c __ LDA ACCU + 1 
18b7 : 85 44 __ STA T1 + 1 
18b9 : a5 1d __ LDA ACCU + 2 
18bb : 85 45 __ STA T1 + 2 
18bd : a5 1e __ LDA ACCU + 3 
18bf : 85 46 __ STA T1 + 3 
18c1 : 38 __ __ SEC
18c2 : a5 4a __ LDA T5 + 0 
18c4 : e9 03 __ SBC #$03
18c6 : 85 4a __ STA T5 + 0 
18c8 : b0 02 __ BCS $18cc ; (nformf.s16 + 0)
.s1085:
18ca : c6 4b __ DEC T5 + 1 
.s16:
18cc : a5 46 __ LDA T1 + 3 
18ce : 30 cb __ BMI $189b ; (nformf.l17 + 0)
.s1060:
18d0 : c9 3f __ CMP #$3f
18d2 : d0 06 __ BNE $18da ; (nformf.s1064 + 0)
.s1061:
18d4 : a5 45 __ LDA T1 + 2 
18d6 : c9 80 __ CMP #$80
18d8 : f0 02 __ BEQ $18dc ; (nformf.s19 + 0)
.s1064:
18da : 90 bf __ BCC $189b ; (nformf.l17 + 0)
.s19:
18dc : a5 46 __ LDA T1 + 3 
18de : c9 41 __ CMP #$41
18e0 : d0 51 __ BNE $1933 ; (nformf.l1056 + 0)
.s1053:
18e2 : a5 45 __ LDA T1 + 2 
18e4 : c9 20 __ CMP #$20
18e6 : d0 4b __ BNE $1933 ; (nformf.l1056 + 0)
.s1054:
18e8 : a5 44 __ LDA T1 + 1 
18ea : d0 04 __ BNE $18f0 ; (nformf.l1078 + 0)
.s1055:
18ec : a5 43 __ LDA T1 + 0 
18ee : f0 02 __ BEQ $18f2 ; (nformf.l20 + 0)
.l1078:
18f0 : a5 43 __ LDA T1 + 0 
.l20:
18f2 : 85 1b __ STA ACCU + 0 
18f4 : a5 44 __ LDA T1 + 1 
18f6 : 85 1c __ STA ACCU + 1 
18f8 : a5 45 __ LDA T1 + 2 
18fa : 85 1d __ STA ACCU + 2 
18fc : a5 46 __ LDA T1 + 3 
18fe : 85 1e __ STA ACCU + 3 
1900 : a9 00 __ LDA #$00
1902 : 85 03 __ STA WORK + 0 
1904 : 85 04 __ STA WORK + 1 
1906 : a9 20 __ LDA #$20
1908 : 85 05 __ STA WORK + 2 
190a : a9 41 __ LDA #$41
190c : 85 06 __ STA WORK + 3 
190e : 20 11 22 JSR $2211 ; (freg + 20)
1911 : 20 f8 23 JSR $23f8 ; (fdiv + 0)
1914 : a5 1b __ LDA ACCU + 0 
1916 : 85 43 __ STA T1 + 0 
1918 : a5 1c __ LDA ACCU + 1 
191a : 85 44 __ STA T1 + 1 
191c : a5 1d __ LDA ACCU + 2 
191e : 85 45 __ STA T1 + 2 
1920 : e6 4a __ INC T5 + 0 
1922 : d0 02 __ BNE $1926 ; (nformf.s1088 + 0)
.s1087:
1924 : e6 4b __ INC T5 + 1 
.s1088:
1926 : a5 1e __ LDA ACCU + 3 
1928 : 85 46 __ STA T1 + 3 
192a : 10 03 __ BPL $192f ; (nformf.s1052 + 0)
192c : 4c 31 15 JMP $1531 ; (nformf.s12 + 0)
.s1052:
192f : c9 41 __ CMP #$41
1931 : f0 af __ BEQ $18e2 ; (nformf.s1053 + 0)
.l1056:
1933 : b0 bb __ BCS $18f0 ; (nformf.l1078 + 0)
1935 : 4c 31 15 JMP $1531 ; (nformf.s12 + 0)
.s1072:
1938 : 90 92 __ BCC $18cc ; (nformf.s16 + 0)
193a : 4c 5a 18 JMP $185a ; (nformf.s1079 + 0)
.s7:
193d : 85 1b __ STA ACCU + 0 
193f : a9 49 __ LDA #$49
1941 : 91 13 __ STA (P6),y ; (str + 0)
1943 : a9 4e __ LDA #$4e
1945 : a4 4a __ LDY T5 + 0 
1947 : 91 13 __ STA (P6),y ; (str + 0)
1949 : a9 46 __ LDA #$46
194b : a4 1b __ LDY ACCU + 0 
194d : 91 13 __ STA (P6),y ; (str + 0)
194f : 18 __ __ CLC
1950 : a5 48 __ LDA T3 + 0 
1952 : 69 03 __ ADC #$03
1954 : 85 48 __ STA T3 + 0 
1956 : 4c 32 17 JMP $1732 ; (nformf.s9 + 0)
.s189:
1959 : 20 71 19 JSR $1971 ; (isinf.s0 + 0)
195c : aa __ __ TAX
195d : a9 01 __ LDA #$01
195f : 85 48 __ STA T3 + 0 
1961 : 8a __ __ TXA
1962 : d0 03 __ BNE $1967 ; (nformf.s158 + 0)
1964 : 4c 0e 15 JMP $150e ; (nformf.s8 + 0)
.s158:
1967 : a9 02 __ LDA #$02
1969 : 85 4a __ STA T5 + 0 
196b : a9 03 __ LDA #$03
196d : a0 01 __ LDY #$01
196f : d0 cc __ BNE $193d ; (nformf.s7 + 0)
--------------------------------------------------------------------
isinf:
.s0:
1971 : 06 0f __ ASL P2 ; (f + 2)
1973 : a5 10 __ LDA P3 ; (f + 3)
1975 : 2a __ __ ROL
1976 : c9 ff __ CMP #$ff
1978 : d0 03 __ BNE $197d ; (isinf.s1003 + 0)
.s1002:
197a : a9 01 __ LDA #$01
197c : 60 __ __ RTS
.s1003:
197d : a9 00 __ LDA #$00
.s1001:
197f : 60 __ __ RTS
--------------------------------------------------------------------
fround5:
2740 : __ __ __ BYT 00 00 00 3f cd cc 4c 3d 0a d7 a3 3b 6f 12 03 3a : ...?..L=...;o..:
2750 : __ __ __ BYT 17 b7 51 38 ac c5 a7 36 bd 37 06 35             : ..Q8...6.7.5
--------------------------------------------------------------------
08fa : __ __ __ BYT 25 64 00                                        : %d.
--------------------------------------------------------------------
1980 : __ __ __ BYT 53 48 49 50 53 3a 00                            : SHIPS:.
--------------------------------------------------------------------
play_sound_effects:
.s0:
1987 : ad 73 27 LDA $2773 ; (PlayerShotSound + 3)
198a : c9 01 __ CMP #$01
198c : d0 2c __ BNE $19ba ; (play_sound_effects.s2 + 0)
.s1:
198e : a9 20 __ LDA #$20
1990 : 8d 70 27 STA $2770 ; (PlayerShotSound + 0)
1993 : a9 4e __ LDA #$4e
1995 : 8d 71 27 STA $2771 ; (PlayerShotSound + 1)
1998 : a9 00 __ LDA #$00
199a : 8d 72 27 STA $2772 ; (PlayerShotSound + 2)
199d : a9 20 __ LDA #$20
199f : 8d 00 d4 STA $d400 
19a2 : a9 4e __ LDA #$4e
19a4 : 8d 01 d4 STA $d401 
19a7 : a9 05 __ LDA #$05
19a9 : 8d 05 d4 STA $d405 
19ac : a9 f1 __ LDA #$f1
19ae : 8d 06 d4 STA $d406 
19b1 : a9 81 __ LDA #$81
19b3 : 8d 04 d4 STA $d404 
19b6 : a9 02 __ LDA #$02
19b8 : d0 35 __ BNE $19ef ; (play_sound_effects.s1014 + 0)
.s2:
19ba : c9 02 __ CMP #$02
19bc : d0 26 __ BNE $19e4 ; (play_sound_effects.s5 + 0)
.s4:
19be : ad 70 27 LDA $2770 ; (PlayerShotSound + 0)
19c1 : 38 __ __ SEC
19c2 : e9 f4 __ SBC #$f4
19c4 : 8d 70 27 STA $2770 ; (PlayerShotSound + 0)
19c7 : ad 71 27 LDA $2771 ; (PlayerShotSound + 1)
19ca : e9 01 __ SBC #$01
19cc : 8d 71 27 STA $2771 ; (PlayerShotSound + 1)
19cf : ad 70 27 LDA $2770 ; (PlayerShotSound + 0)
19d2 : 8d 00 d4 STA $d400 
19d5 : ad 71 27 LDA $2771 ; (PlayerShotSound + 1)
19d8 : 8d 01 d4 STA $d401 
19db : a9 14 __ LDA #$14
19dd : 8d 72 27 STA $2772 ; (PlayerShotSound + 2)
19e0 : a9 03 __ LDA #$03
19e2 : d0 0b __ BNE $19ef ; (play_sound_effects.s1014 + 0)
.s5:
19e4 : c9 03 __ CMP #$03
19e6 : d0 0a __ BNE $19f2 ; (play_sound_effects.s26 + 0)
.s10:
19e8 : a9 08 __ LDA #$08
19ea : 8d 04 d4 STA $d404 
19ed : a9 00 __ LDA #$00
.s1014:
19ef : 8d 73 27 STA $2773 ; (PlayerShotSound + 3)
.s26:
19f2 : ad bb 27 LDA $27bb ; (EnemyShotSound + 3)
19f5 : c9 01 __ CMP #$01
19f7 : d0 2c __ BNE $1a25 ; (play_sound_effects.s14 + 0)
.s13:
19f9 : a9 20 __ LDA #$20
19fb : 8d b8 27 STA $27b8 ; (EnemyShotSound + 0)
19fe : a9 4e __ LDA #$4e
1a00 : 8d b9 27 STA $27b9 ; (EnemyShotSound + 1)
1a03 : a9 00 __ LDA #$00
1a05 : 8d ba 27 STA $27ba ; (EnemyShotSound + 2)
1a08 : a9 20 __ LDA #$20
1a0a : 8d 07 d4 STA $d407 
1a0d : a9 4e __ LDA #$4e
1a0f : 8d 08 d4 STA $d408 
1a12 : a9 05 __ LDA #$05
1a14 : 8d 0c d4 STA $d40c 
1a17 : a9 f1 __ LDA #$f1
1a19 : 8d 0d d4 STA $d40d 
1a1c : a9 11 __ LDA #$11
1a1e : 8d 0b d4 STA $d40b 
1a21 : a9 02 __ LDA #$02
1a23 : d0 35 __ BNE $1a5a ; (play_sound_effects.s1015 + 0)
.s14:
1a25 : c9 02 __ CMP #$02
1a27 : d0 26 __ BNE $1a4f ; (play_sound_effects.s17 + 0)
.s16:
1a29 : ad b8 27 LDA $27b8 ; (EnemyShotSound + 0)
1a2c : 18 __ __ CLC
1a2d : 69 f4 __ ADC #$f4
1a2f : 8d b8 27 STA $27b8 ; (EnemyShotSound + 0)
1a32 : ad b9 27 LDA $27b9 ; (EnemyShotSound + 1)
1a35 : 69 01 __ ADC #$01
1a37 : 8d b9 27 STA $27b9 ; (EnemyShotSound + 1)
1a3a : ad b8 27 LDA $27b8 ; (EnemyShotSound + 0)
1a3d : 8d 07 d4 STA $d407 
1a40 : ad b9 27 LDA $27b9 ; (EnemyShotSound + 1)
1a43 : 8d 08 d4 STA $d408 
1a46 : a9 14 __ LDA #$14
1a48 : 8d ba 27 STA $27ba ; (EnemyShotSound + 2)
1a4b : a9 03 __ LDA #$03
1a4d : d0 0b __ BNE $1a5a ; (play_sound_effects.s1015 + 0)
.s17:
1a4f : c9 03 __ CMP #$03
1a51 : d0 0a __ BNE $1a5d ; (play_sound_effects.s1001 + 0)
.s22:
1a53 : a9 08 __ LDA #$08
1a55 : 8d 0b d4 STA $d40b 
1a58 : a9 00 __ LDA #$00
.s1015:
1a5a : 8d bb 27 STA $27bb ; (EnemyShotSound + 3)
.s1001:
1a5d : 60 __ __ RTS
--------------------------------------------------------------------
EnemyShotSound:
27b8 : __ __ __ BSS	4
--------------------------------------------------------------------
spawn_enemy:
.s0:
1a5e : 20 ce 1a JSR $1ace ; (rand.s0 + 0)
1a61 : 46 1b __ LSR ACCU + 0 
1a63 : b0 0f __ BCS $1a74 ; (spawn_enemy.s1001 + 0)
.s3:
1a65 : a0 00 __ LDY #$00
.l6:
1a67 : be b1 26 LDX $26b1,y ; (__multab5L + 0)
1a6a : bd 78 27 LDA $2778,x ; (Enemy + 4)
1a6d : f0 06 __ BEQ $1a75 ; (spawn_enemy.s9 + 0)
.s7:
1a6f : c8 __ __ INY
1a70 : c0 0a __ CPY #$0a
1a72 : 90 f3 __ BCC $1a67 ; (spawn_enemy.l6 + 0)
.s1001:
1a74 : 60 __ __ RTS
.s9:
1a75 : 86 43 __ STX T0 + 0 
1a77 : a9 27 __ LDA #$27
1a79 : 9d 74 27 STA $2774,x ; (Enemy + 0)
1a7c : 20 ce 1a JSR $1ace ; (rand.s0 + 0)
1a7f : a9 14 __ LDA #$14
1a81 : 85 03 __ STA WORK + 0 
1a83 : a9 00 __ LDA #$00
1a85 : 85 04 __ STA WORK + 1 
1a87 : 20 e0 24 JSR $24e0 ; (divmod + 0)
1a8a : 18 __ __ CLC
1a8b : a5 05 __ LDA WORK + 2 
1a8d : 69 04 __ ADC #$04
1a8f : a6 43 __ LDX T0 + 0 
1a91 : 9d 75 27 STA $2775,x ; (Enemy + 1)
1a94 : 20 ce 1a JSR $1ace ; (rand.s0 + 0)
1a97 : a9 0e __ LDA #$0e
1a99 : a6 43 __ LDX T0 + 0 
1a9b : 9d 77 27 STA $2777,x ; (Enemy + 3)
1a9e : a9 01 __ LDA #$01
1aa0 : 9d 78 27 STA $2778,x ; (Enemy + 4)
1aa3 : a9 03 __ LDA #$03
1aa5 : 85 03 __ STA WORK + 0 
1aa7 : a9 00 __ LDA #$00
1aa9 : 85 04 __ STA WORK + 1 
1aab : 20 e0 24 JSR $24e0 ; (divmod + 0)
1aae : 18 __ __ CLC
1aaf : a5 05 __ LDA WORK + 2 
1ab1 : 69 83 __ ADC #$83
1ab3 : a4 43 __ LDY T0 + 0 
1ab5 : 99 76 27 STA $2776,y ; (Enemy + 2)
1ab8 : c9 83 __ CMP #$83
1aba : d0 04 __ BNE $1ac0 ; (spawn_enemy.s13 + 0)
.s12:
1abc : a9 0d __ LDA #$0d
1abe : d0 0a __ BNE $1aca ; (spawn_enemy.s1008 + 0)
.s13:
1ac0 : c9 84 __ CMP #$84
1ac2 : d0 04 __ BNE $1ac8 ; (spawn_enemy.s16 + 0)
.s15:
1ac4 : a9 0a __ LDA #$0a
1ac6 : d0 02 __ BNE $1aca ; (spawn_enemy.s1008 + 0)
.s16:
1ac8 : a9 09 __ LDA #$09
.s1008:
1aca : 99 77 27 STA $2777,y ; (Enemy + 3)
1acd : 60 __ __ RTS
--------------------------------------------------------------------
rand:
.s0:
1ace : ad 5d 27 LDA $275d ; (seed + 1)
1ad1 : 4a __ __ LSR
1ad2 : ad 5c 27 LDA $275c ; (seed + 0)
1ad5 : 6a __ __ ROR
1ad6 : aa __ __ TAX
1ad7 : a9 00 __ LDA #$00
1ad9 : 6a __ __ ROR
1ada : 4d 5c 27 EOR $275c ; (seed + 0)
1add : 85 1b __ STA ACCU + 0 
1adf : 8a __ __ TXA
1ae0 : 4d 5d 27 EOR $275d ; (seed + 1)
1ae3 : 85 1c __ STA ACCU + 1 
1ae5 : 4a __ __ LSR
1ae6 : 45 1b __ EOR ACCU + 0 
1ae8 : 8d 5c 27 STA $275c ; (seed + 0)
1aeb : 85 1b __ STA ACCU + 0 
1aed : 45 1c __ EOR ACCU + 1 
1aef : 8d 5d 27 STA $275d ; (seed + 1)
1af2 : 85 1c __ STA ACCU + 1 
.s1001:
1af4 : 60 __ __ RTS
--------------------------------------------------------------------
seed:
275c : __ __ __ BYT 00 7a                                           : .z
--------------------------------------------------------------------
move_enemies:
.s0:
1af5 : a2 00 __ LDX #$00
.l2:
1af7 : 86 43 __ STX T0 + 0 
1af9 : bc b1 26 LDY $26b1,x ; (__multab5L + 0)
1afc : b9 78 27 LDA $2778,y ; (Enemy + 4)
1aff : c9 01 __ CMP #$01
1b01 : d0 75 __ BNE $1b78 ; (move_enemies.s41 + 0)
.s5:
1b03 : 18 __ __ CLC
1b04 : a9 74 __ LDA #$74
1b06 : 7d b1 26 ADC $26b1,x ; (__multab5L + 0)
1b09 : 85 44 __ STA T1 + 0 
1b0b : a9 27 __ LDA #$27
1b0d : 69 00 __ ADC #$00
1b0f : 85 45 __ STA T1 + 1 
1b11 : a0 02 __ LDY #$02
1b13 : b1 44 __ LDA (T1 + 0),y 
1b15 : c9 83 __ CMP #$83
1b17 : d0 16 __ BNE $1b2f ; (move_enemies.s10 + 0)
.s11:
1b19 : 88 __ __ DEY
1b1a : b1 44 __ LDA (T1 + 0),y 
1b1c : cd 6f 27 CMP $276f ; (Player + 1)
1b1f : d0 0e __ BNE $1b2f ; (move_enemies.s10 + 0)
.s8:
1b21 : a5 44 __ LDA T1 + 0 
1b23 : 85 0d __ STA P0 
1b25 : a5 45 __ LDA T1 + 1 
1b27 : 85 0e __ STA P1 
1b29 : 20 e5 1b JSR $1be5 ; (spawn_enemy_shot.s0 + 0)
1b2c : 20 22 1c JSR $1c22 ; (render_enemy_shots.s0 + 0)
.s10:
1b2f : a0 00 __ LDY #$00
1b31 : b1 44 __ LDA (T1 + 0),y 
1b33 : 85 46 __ STA T3 + 0 
1b35 : c8 __ __ INY
1b36 : b1 44 __ LDA (T1 + 0),y 
1b38 : 0a __ __ ASL
1b39 : 85 1b __ STA ACCU + 0 
1b3b : a9 00 __ LDA #$00
1b3d : 2a __ __ ROL
1b3e : 06 1b __ ASL ACCU + 0 
1b40 : 2a __ __ ROL
1b41 : aa __ __ TAX
1b42 : a5 1b __ LDA ACCU + 0 
1b44 : 71 44 __ ADC (T1 + 0),y 
1b46 : 85 1b __ STA ACCU + 0 
1b48 : 8a __ __ TXA
1b49 : 69 00 __ ADC #$00
1b4b : 06 1b __ ASL ACCU + 0 
1b4d : 2a __ __ ROL
1b4e : 06 1b __ ASL ACCU + 0 
1b50 : 2a __ __ ROL
1b51 : 06 1b __ ASL ACCU + 0 
1b53 : 2a __ __ ROL
1b54 : aa __ __ TAX
1b55 : 18 __ __ CLC
1b56 : a5 1b __ LDA ACCU + 0 
1b58 : 65 46 __ ADC T3 + 0 
1b5a : 85 1b __ STA ACCU + 0 
1b5c : 85 1f __ STA ADDR + 0 
1b5e : 8a __ __ TXA
1b5f : 69 c0 __ ADC #$c0
1b61 : 85 1c __ STA ACCU + 1 
1b63 : 18 __ __ CLC
1b64 : 69 18 __ ADC #$18
1b66 : 85 20 __ STA ADDR + 1 
1b68 : a9 20 __ LDA #$20
1b6a : 88 __ __ DEY
1b6b : 91 1b __ STA (ACCU + 0),y 
1b6d : 98 __ __ TYA
1b6e : 91 1f __ STA (ADDR + 0),y 
1b70 : a5 46 __ LDA T3 + 0 
1b72 : d0 0f __ BNE $1b83 ; (move_enemies.s12 + 0)
.s13:
1b74 : a0 04 __ LDY #$04
.s1020:
1b76 : 91 44 __ STA (T1 + 0),y 
.s41:
1b78 : a6 43 __ LDX T0 + 0 
1b7a : e8 __ __ INX
1b7b : e0 0a __ CPX #$0a
1b7d : b0 03 __ BCS $1b82 ; (move_enemies.s1001 + 0)
1b7f : 4c f7 1a JMP $1af7 ; (move_enemies.l2 + 0)
.s1001:
1b82 : 60 __ __ RTS
.s12:
1b83 : c6 46 __ DEC T3 + 0 
1b85 : a5 46 __ LDA T3 + 0 
1b87 : 91 44 __ STA (T1 + 0),y 
1b89 : a0 02 __ LDY #$02
1b8b : b1 44 __ LDA (T1 + 0),y 
1b8d : c9 85 __ CMP #$85
1b8f : f0 e7 __ BEQ $1b78 ; (move_enemies.s41 + 0)
.s15:
1b91 : 20 ce 1a JSR $1ace ; (rand.s0 + 0)
1b94 : a0 01 __ LDY #$01
1b96 : b1 44 __ LDA (T1 + 0),y 
1b98 : 85 47 __ STA T4 + 0 
1b9a : a9 03 __ LDA #$03
1b9c : 85 03 __ STA WORK + 0 
1b9e : a9 00 __ LDA #$00
1ba0 : 85 04 __ STA WORK + 1 
1ba2 : 20 e0 24 JSR $24e0 ; (divmod + 0)
1ba5 : 38 __ __ SEC
1ba6 : a5 05 __ LDA WORK + 2 
1ba8 : e9 01 __ SBC #$01
1baa : aa __ __ TAX
1bab : a5 06 __ LDA WORK + 3 
1bad : e9 00 __ SBC #$00
1baf : a8 __ __ TAY
1bb0 : 8a __ __ TXA
1bb1 : 18 __ __ CLC
1bb2 : 65 47 __ ADC T4 + 0 
1bb4 : 85 1b __ STA ACCU + 0 
1bb6 : 90 01 __ BCC $1bb9 ; (move_enemies.s1022 + 0)
.s1021:
1bb8 : c8 __ __ INY
.s1022:
1bb9 : 0a __ __ ASL
1bba : 0a __ __ ASL
1bbb : 18 __ __ CLC
1bbc : 65 1b __ ADC ACCU + 0 
1bbe : 0a __ __ ASL
1bbf : 0a __ __ ASL
1bc0 : 0a __ __ ASL
1bc1 : 18 __ __ CLC
1bc2 : 65 46 __ ADC T3 + 0 
1bc4 : aa __ __ TAX
1bc5 : bd 00 c0 LDA $c000,x 
1bc8 : c9 83 __ CMP #$83
1bca : f0 ac __ BEQ $1b78 ; (move_enemies.s41 + 0)
.s24:
1bcc : c9 84 __ CMP #$84
1bce : f0 a8 __ BEQ $1b78 ; (move_enemies.s41 + 0)
.s23:
1bd0 : c9 85 __ CMP #$85
1bd2 : f0 a4 __ BEQ $1b78 ; (move_enemies.s41 + 0)
.s22:
1bd4 : 98 __ __ TYA
1bd5 : d0 a1 __ BNE $1b78 ; (move_enemies.s41 + 0)
.s1005:
1bd7 : a5 1b __ LDA ACCU + 0 
1bd9 : c9 04 __ CMP #$04
1bdb : 90 9b __ BCC $1b78 ; (move_enemies.s41 + 0)
.s1004:
1bdd : c9 18 __ CMP #$18
1bdf : b0 97 __ BCS $1b78 ; (move_enemies.s41 + 0)
.s18:
1be1 : a0 01 __ LDY #$01
1be3 : d0 91 __ BNE $1b76 ; (move_enemies.s1020 + 0)
--------------------------------------------------------------------
spawn_enemy_shot:
.s0:
1be5 : a0 00 __ LDY #$00
1be7 : b1 0d __ LDA (P0),y ; (e + 0)
1be9 : f0 0f __ BEQ $1bfa ; (spawn_enemy_shot.s1001 + 0)
.s3:
1beb : a2 00 __ LDX #$00
.l6:
1bed : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1bf0 : b9 b1 27 LDA $27b1,y ; (EnemyShot + 2)
1bf3 : f0 06 __ BEQ $1bfb ; (spawn_enemy_shot.s9 + 0)
.s7:
1bf5 : e8 __ __ INX
1bf6 : e0 03 __ CPX #$03
1bf8 : 90 f3 __ BCC $1bed ; (spawn_enemy_shot.l6 + 0)
.s1001:
1bfa : 60 __ __ RTS
.s9:
1bfb : a9 01 __ LDA #$01
1bfd : 99 b1 27 STA $27b1,y ; (EnemyShot + 2)
1c00 : a0 00 __ LDY #$00
1c02 : b1 0d __ LDA (P0),y ; (e + 0)
1c04 : 38 __ __ SEC
1c05 : e9 01 __ SBC #$01
1c07 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1c0a : 99 af 27 STA $27af,y ; (EnemyShot + 0)
1c0d : a0 01 __ LDY #$01
1c0f : b1 0d __ LDA (P0),y ; (e + 0)
1c11 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1c14 : 99 b0 27 STA $27b0,y ; (EnemyShot + 1)
1c17 : ad bb 27 LDA $27bb ; (EnemyShotSound + 3)
1c1a : d0 de __ BNE $1bfa ; (spawn_enemy_shot.s1001 + 0)
.s12:
1c1c : a9 01 __ LDA #$01
1c1e : 8d bb 27 STA $27bb ; (EnemyShotSound + 3)
1c21 : 60 __ __ RTS
--------------------------------------------------------------------
render_enemy_shots:
.s0:
1c22 : a2 00 __ LDX #$00
.l1006:
1c24 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1c27 : b9 b1 27 LDA $27b1,y ; (EnemyShot + 2)
1c2a : c9 01 __ CMP #$01
1c2c : d0 43 __ BNE $1c71 ; (render_enemy_shots.s19 + 0)
.s5:
1c2e : b9 b0 27 LDA $27b0,y ; (EnemyShot + 1)
1c31 : 0a __ __ ASL
1c32 : 85 1b __ STA ACCU + 0 
1c34 : a9 00 __ LDA #$00
1c36 : 2a __ __ ROL
1c37 : 06 1b __ ASL ACCU + 0 
1c39 : 2a __ __ ROL
1c3a : 85 1c __ STA ACCU + 1 
1c3c : a5 1b __ LDA ACCU + 0 
1c3e : 79 b0 27 ADC $27b0,y ; (EnemyShot + 1)
1c41 : 85 1b __ STA ACCU + 0 
1c43 : a5 1c __ LDA ACCU + 1 
1c45 : 69 00 __ ADC #$00
1c47 : 06 1b __ ASL ACCU + 0 
1c49 : 2a __ __ ROL
1c4a : 06 1b __ ASL ACCU + 0 
1c4c : 2a __ __ ROL
1c4d : 06 1b __ ASL ACCU + 0 
1c4f : 2a __ __ ROL
1c50 : 85 1c __ STA ACCU + 1 
1c52 : 18 __ __ CLC
1c53 : a5 1b __ LDA ACCU + 0 
1c55 : 79 af 27 ADC $27af,y ; (EnemyShot + 0)
1c58 : 85 1b __ STA ACCU + 0 
1c5a : 85 1f __ STA ADDR + 0 
1c5c : a5 1c __ LDA ACCU + 1 
1c5e : 69 c0 __ ADC #$c0
1c60 : 85 1c __ STA ACCU + 1 
1c62 : 18 __ __ CLC
1c63 : 69 18 __ ADC #$18
1c65 : 85 20 __ STA ADDR + 1 
1c67 : a9 82 __ LDA #$82
1c69 : a0 00 __ LDY #$00
1c6b : 91 1b __ STA (ACCU + 0),y 
1c6d : a9 01 __ LDA #$01
1c6f : 91 1f __ STA (ADDR + 0),y 
.s19:
1c71 : e8 __ __ INX
1c72 : e0 03 __ CPX #$03
1c74 : 90 ae __ BCC $1c24 ; (render_enemy_shots.l1006 + 0)
.s1001:
1c76 : 60 __ __ RTS
--------------------------------------------------------------------
render_enemies:
.s0:
1c77 : a2 00 __ LDX #$00
.l1006:
1c79 : bc b1 26 LDY $26b1,x ; (__multab5L + 0)
1c7c : b9 78 27 LDA $2778,y ; (Enemy + 4)
1c7f : c9 01 __ CMP #$01
1c81 : d0 4b __ BNE $1cce ; (render_enemies.s19 + 0)
.s5:
1c83 : 84 1d __ STY ACCU + 2 
1c85 : b9 75 27 LDA $2775,y ; (Enemy + 1)
1c88 : 0a __ __ ASL
1c89 : 85 1b __ STA ACCU + 0 
1c8b : a9 00 __ LDA #$00
1c8d : 2a __ __ ROL
1c8e : 06 1b __ ASL ACCU + 0 
1c90 : 2a __ __ ROL
1c91 : 85 1c __ STA ACCU + 1 
1c93 : a5 1b __ LDA ACCU + 0 
1c95 : 79 75 27 ADC $2775,y ; (Enemy + 1)
1c98 : 85 1b __ STA ACCU + 0 
1c9a : a5 1c __ LDA ACCU + 1 
1c9c : 69 00 __ ADC #$00
1c9e : 06 1b __ ASL ACCU + 0 
1ca0 : 2a __ __ ROL
1ca1 : 06 1b __ ASL ACCU + 0 
1ca3 : 2a __ __ ROL
1ca4 : 06 1b __ ASL ACCU + 0 
1ca6 : 2a __ __ ROL
1ca7 : 85 1c __ STA ACCU + 1 
1ca9 : 18 __ __ CLC
1caa : a5 1b __ LDA ACCU + 0 
1cac : 79 74 27 ADC $2774,y ; (Enemy + 0)
1caf : 85 43 __ STA T2 + 0 
1cb1 : 85 1b __ STA ACCU + 0 
1cb3 : a5 1c __ LDA ACCU + 1 
1cb5 : 69 c0 __ ADC #$c0
1cb7 : 85 44 __ STA T2 + 1 
1cb9 : 18 __ __ CLC
1cba : 69 18 __ ADC #$18
1cbc : 85 1c __ STA ACCU + 1 
1cbe : b9 76 27 LDA $2776,y ; (Enemy + 2)
1cc1 : a0 00 __ LDY #$00
1cc3 : 91 43 __ STA (T2 + 0),y 
1cc5 : a4 1d __ LDY ACCU + 2 
1cc7 : b9 77 27 LDA $2777,y ; (Enemy + 3)
1cca : a0 00 __ LDY #$00
1ccc : 91 1b __ STA (ACCU + 0),y 
.s19:
1cce : e8 __ __ INX
1ccf : e0 0a __ CPX #$0a
1cd1 : 90 a6 __ BCC $1c79 ; (render_enemies.l1006 + 0)
.s1001:
1cd3 : 60 __ __ RTS
--------------------------------------------------------------------
check_shot_enemy_collision:
.s0:
1cd4 : a2 00 __ LDX #$00
.l2:
1cd6 : 86 1d __ STX ACCU + 2 
1cd8 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1cdb : b9 a8 27 LDA $27a8,y ; (PlayerShot + 2)
1cde : c9 01 __ CMP #$01
1ce0 : d0 2e __ BNE $1d10 ; (check_shot_enemy_collision.s3 + 0)
.s5:
1ce2 : a2 00 __ LDX #$00
.l9:
1ce4 : 86 43 __ STX T2 + 0 
1ce6 : bc b1 26 LDY $26b1,x ; (__multab5L + 0)
1ce9 : b9 78 27 LDA $2778,y ; (Enemy + 4)
1cec : c9 01 __ CMP #$01
1cee : d0 19 __ BNE $1d09 ; (check_shot_enemy_collision.s114 + 0)
.s12:
1cf0 : 84 1e __ STY ACCU + 3 
1cf2 : b9 74 27 LDA $2774,y ; (Enemy + 0)
1cf5 : a6 1d __ LDX ACCU + 2 
1cf7 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1cfa : d9 a6 27 CMP $27a6,y ; (PlayerShot + 0)
1cfd : d0 0a __ BNE $1d09 ; (check_shot_enemy_collision.s114 + 0)
.s18:
1cff : b9 a7 27 LDA $27a7,y ; (PlayerShot + 1)
1d02 : a6 1e __ LDX ACCU + 3 
1d04 : dd 75 27 CMP $2775,x ; (Enemy + 1)
1d07 : f0 0f __ BEQ $1d18 ; (check_shot_enemy_collision.s15 + 0)
.s114:
1d09 : a6 43 __ LDX T2 + 0 
1d0b : e8 __ __ INX
1d0c : e0 0a __ CPX #$0a
1d0e : 90 d4 __ BCC $1ce4 ; (check_shot_enemy_collision.l9 + 0)
.s3:
1d10 : a6 1d __ LDX ACCU + 2 
1d12 : e8 __ __ INX
1d13 : e0 03 __ CPX #$03
1d15 : 90 bf __ BCC $1cd6 ; (check_shot_enemy_collision.l2 + 0)
.s1001:
1d17 : 60 __ __ RTS
.s15:
1d18 : a9 08 __ LDA #$08
1d1a : 8d 0b d4 STA $d40b 
1d1d : a9 00 __ LDA #$00
1d1f : 85 44 __ STA T3 + 0 
.l20:
1d21 : a4 1e __ LDY ACCU + 3 
1d23 : b9 75 27 LDA $2775,y ; (Enemy + 1)
1d26 : 0a __ __ ASL
1d27 : 85 1b __ STA ACCU + 0 
1d29 : a9 00 __ LDA #$00
1d2b : 2a __ __ ROL
1d2c : 06 1b __ ASL ACCU + 0 
1d2e : 2a __ __ ROL
1d2f : aa __ __ TAX
1d30 : a5 1b __ LDA ACCU + 0 
1d32 : 79 75 27 ADC $2775,y ; (Enemy + 1)
1d35 : 85 1b __ STA ACCU + 0 
1d37 : 8a __ __ TXA
1d38 : 69 00 __ ADC #$00
1d3a : 06 1b __ ASL ACCU + 0 
1d3c : 2a __ __ ROL
1d3d : 06 1b __ ASL ACCU + 0 
1d3f : 2a __ __ ROL
1d40 : 06 1b __ ASL ACCU + 0 
1d42 : 2a __ __ ROL
1d43 : aa __ __ TAX
1d44 : 18 __ __ CLC
1d45 : a5 1b __ LDA ACCU + 0 
1d47 : 79 74 27 ADC $2774,y ; (Enemy + 0)
1d4a : 85 1b __ STA ACCU + 0 
1d4c : 8a __ __ TXA
1d4d : 69 c0 __ ADC #$c0
1d4f : 85 1c __ STA ACCU + 1 
1d51 : 18 __ __ CLC
1d52 : 69 18 __ ADC #$18
1d54 : 85 20 __ STA ADDR + 1 
1d56 : a9 86 __ LDA #$86
1d58 : a0 00 __ LDY #$00
1d5a : 84 1f __ STY ADDR + 0 
1d5c : 91 1b __ STA (ACCU + 0),y 
1d5e : a5 44 __ LDA T3 + 0 
1d60 : a4 1b __ LDY ACCU + 0 
1d62 : 91 1f __ STA (ADDR + 0),y 
1d64 : aa __ __ TAX
1d65 : bd bb 26 LDA $26bb,x ; (__multab2000L + 0)
1d68 : 8d 00 d4 STA $d400 
1d6b : bd c3 26 LDA $26c3,x ; (__multab2000H + 0)
1d6e : 8d 01 d4 STA $d401 
1d71 : a9 35 __ LDA #$35
1d73 : 8d 05 d4 STA $d405 
1d76 : a9 f1 __ LDA #$f1
1d78 : 8d 06 d4 STA $d406 
1d7b : a9 81 __ LDA #$81
1d7d : 8d 04 d4 STA $d404 
.l109:
1d80 : ad 11 d0 LDA $d011 
1d83 : 30 fb __ BMI $1d80 ; (check_shot_enemy_collision.l109 + 0)
.l27:
1d85 : ad 11 d0 LDA $d011 
1d88 : 10 fb __ BPL $1d85 ; (check_shot_enemy_collision.l27 + 0)
.s21:
1d8a : e6 44 __ INC T3 + 0 
1d8c : a5 44 __ LDA T3 + 0 
1d8e : c9 08 __ CMP #$08
1d90 : 90 8f __ BCC $1d21 ; (check_shot_enemy_collision.l20 + 0)
.s22:
1d92 : a9 08 __ LDA #$08
1d94 : 8d 04 d4 STA $d404 
1d97 : a6 1e __ LDX ACCU + 3 
1d99 : bd 75 27 LDA $2775,x ; (Enemy + 1)
1d9c : 0a __ __ ASL
1d9d : 85 1b __ STA ACCU + 0 
1d9f : a9 00 __ LDA #$00
1da1 : 2a __ __ ROL
1da2 : 06 1b __ ASL ACCU + 0 
1da4 : 2a __ __ ROL
1da5 : a8 __ __ TAY
1da6 : a5 1b __ LDA ACCU + 0 
1da8 : 7d 75 27 ADC $2775,x ; (Enemy + 1)
1dab : 85 1b __ STA ACCU + 0 
1dad : 98 __ __ TYA
1dae : 69 00 __ ADC #$00
1db0 : 06 1b __ ASL ACCU + 0 
1db2 : 2a __ __ ROL
1db3 : 06 1b __ ASL ACCU + 0 
1db5 : 2a __ __ ROL
1db6 : 06 1b __ ASL ACCU + 0 
1db8 : 2a __ __ ROL
1db9 : a8 __ __ TAY
1dba : 18 __ __ CLC
1dbb : a5 1b __ LDA ACCU + 0 
1dbd : 7d 74 27 ADC $2774,x ; (Enemy + 0)
1dc0 : 85 44 __ STA T3 + 0 
1dc2 : 85 1f __ STA ADDR + 0 
1dc4 : 98 __ __ TYA
1dc5 : 69 c0 __ ADC #$c0
1dc7 : 85 45 __ STA T3 + 1 
1dc9 : 18 __ __ CLC
1dca : 69 18 __ ADC #$18
1dcc : 85 20 __ STA ADDR + 1 
1dce : a9 20 __ LDA #$20
1dd0 : a0 00 __ LDY #$00
1dd2 : 91 44 __ STA (T3 + 0),y 
1dd4 : 98 __ __ TYA
1dd5 : 91 1f __ STA (ADDR + 0),y 
1dd7 : 9d 78 27 STA $2778,x ; (Enemy + 4)
1dda : a6 1d __ LDX ACCU + 2 
1ddc : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1ddf : 99 a8 27 STA $27a8,y ; (PlayerShot + 2)
1de2 : a6 1e __ LDX ACCU + 3 
1de4 : bd 76 27 LDA $2776,x ; (Enemy + 2)
1de7 : c9 83 __ CMP #$83
1de9 : f0 2b __ BEQ $1e16 ; (check_shot_enemy_collision.s30 + 0)
.s31:
1deb : c9 84 __ CMP #$84
1ded : f0 03 __ BEQ $1df2 ; (check_shot_enemy_collision.s33 + 0)
1def : 4c 09 1d JMP $1d09 ; (check_shot_enemy_collision.s114 + 0)
.s33:
1df2 : ad 5f 27 LDA $275f ; (game + 1)
1df5 : 18 __ __ CLC
1df6 : 69 19 __ ADC #$19
.s118:
1df8 : 8d 5f 27 STA $275f ; (game + 1)
1dfb : ad 60 27 LDA $2760 ; (game + 2)
1dfe : 69 00 __ ADC #$00
1e00 : 8d 60 27 STA $2760 ; (game + 2)
1e03 : ad 61 27 LDA $2761 ; (game + 3)
1e06 : 69 00 __ ADC #$00
1e08 : 8d 61 27 STA $2761 ; (game + 3)
1e0b : b0 03 __ BCS $1e10 ; (check_shot_enemy_collision.s1019 + 0)
1e0d : 4c 09 1d JMP $1d09 ; (check_shot_enemy_collision.s114 + 0)
.s1019:
1e10 : ee 62 27 INC $2762 ; (game + 4)
1e13 : 4c 09 1d JMP $1d09 ; (check_shot_enemy_collision.s114 + 0)
.s30:
1e16 : ad 5f 27 LDA $275f ; (game + 1)
1e19 : 18 __ __ CLC
1e1a : 69 32 __ ADC #$32
1e1c : 4c f8 1d JMP $1df8 ; (check_shot_enemy_collision.s118 + 0)
--------------------------------------------------------------------
move_enemy_shots:
.s0:
1e1f : a2 00 __ LDX #$00
.l1008:
1e21 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1e24 : b9 b1 27 LDA $27b1,y ; (EnemyShot + 2)
1e27 : c9 01 __ CMP #$01
1e29 : d0 58 __ BNE $1e83 ; (move_enemy_shots.s23 + 0)
.s5:
1e2b : 84 1d __ STY ACCU + 2 
1e2d : b9 b0 27 LDA $27b0,y ; (EnemyShot + 1)
1e30 : 0a __ __ ASL
1e31 : 85 1b __ STA ACCU + 0 
1e33 : a9 00 __ LDA #$00
1e35 : 2a __ __ ROL
1e36 : 06 1b __ ASL ACCU + 0 
1e38 : 2a __ __ ROL
1e39 : 85 1c __ STA ACCU + 1 
1e3b : a5 1b __ LDA ACCU + 0 
1e3d : 79 b0 27 ADC $27b0,y ; (EnemyShot + 1)
1e40 : 85 1b __ STA ACCU + 0 
1e42 : a5 1c __ LDA ACCU + 1 
1e44 : 69 00 __ ADC #$00
1e46 : 06 1b __ ASL ACCU + 0 
1e48 : 2a __ __ ROL
1e49 : 06 1b __ ASL ACCU + 0 
1e4b : 2a __ __ ROL
1e4c : 06 1b __ ASL ACCU + 0 
1e4e : 2a __ __ ROL
1e4f : 85 1c __ STA ACCU + 1 
1e51 : b9 af 27 LDA $27af,y ; (EnemyShot + 0)
1e54 : 85 1e __ STA ACCU + 3 
1e56 : 18 __ __ CLC
1e57 : 65 1b __ ADC ACCU + 0 
1e59 : 85 1b __ STA ACCU + 0 
1e5b : 85 1f __ STA ADDR + 0 
1e5d : a5 1c __ LDA ACCU + 1 
1e5f : 69 c0 __ ADC #$c0
1e61 : 85 1c __ STA ACCU + 1 
1e63 : 18 __ __ CLC
1e64 : 69 18 __ ADC #$18
1e66 : 85 20 __ STA ADDR + 1 
1e68 : a9 20 __ LDA #$20
1e6a : a0 00 __ LDY #$00
1e6c : 91 1b __ STA (ACCU + 0),y 
1e6e : 98 __ __ TYA
1e6f : 91 1f __ STA (ADDR + 0),y 
1e71 : c6 1e __ DEC ACCU + 3 
1e73 : a5 1e __ LDA ACCU + 3 
1e75 : a4 1d __ LDY ACCU + 2 
1e77 : 99 af 27 STA $27af,y ; (EnemyShot + 0)
1e7a : c9 ff __ CMP #$ff
1e7c : d0 05 __ BNE $1e83 ; (move_enemy_shots.s23 + 0)
.s8:
1e7e : a9 00 __ LDA #$00
1e80 : 99 b1 27 STA $27b1,y ; (EnemyShot + 2)
.s23:
1e83 : e8 __ __ INX
1e84 : e0 03 __ CPX #$03
1e86 : 90 99 __ BCC $1e21 ; (move_enemy_shots.l1008 + 0)
.s1001:
1e88 : 60 __ __ RTS
--------------------------------------------------------------------
check_player_enemy_collision:
.s0:
1e89 : a0 00 __ LDY #$00
.l2:
1e8b : be b1 26 LDX $26b1,y ; (__multab5L + 0)
1e8e : bd 78 27 LDA $2778,x ; (Enemy + 4)
1e91 : c9 01 __ CMP #$01
1e93 : d0 17 __ BNE $1eac ; (check_player_enemy_collision.s3 + 0)
.s5:
1e95 : bd 74 27 LDA $2774,x ; (Enemy + 0)
1e98 : cd 6e 27 CMP $276e ; (Player + 0)
1e9b : d0 0f __ BNE $1eac ; (check_player_enemy_collision.s3 + 0)
.s11:
1e9d : bd 75 27 LDA $2775,x ; (Enemy + 1)
1ea0 : cd 6f 27 CMP $276f ; (Player + 1)
1ea3 : d0 07 __ BNE $1eac ; (check_player_enemy_collision.s3 + 0)
.s8:
1ea5 : ad 5e 27 LDA $275e ; (game + 0)
1ea8 : c9 02 __ CMP #$02
1eaa : d0 37 __ BNE $1ee3 ; (check_player_enemy_collision.s12 + 0)
.s3:
1eac : c8 __ __ INY
1ead : c0 0a __ CPY #$0a
1eaf : 90 da __ BCC $1e8b ; (check_player_enemy_collision.l2 + 0)
.s31:
1eb1 : a0 00 __ LDY #$00
.l17:
1eb3 : be fd 08 LDX $08fd,y ; (__multab3L + 0)
1eb6 : bd b1 27 LDA $27b1,x ; (EnemyShot + 2)
1eb9 : c9 01 __ CMP #$01
1ebb : d0 17 __ BNE $1ed4 ; (check_player_enemy_collision.s18 + 0)
.s20:
1ebd : bd af 27 LDA $27af,x ; (EnemyShot + 0)
1ec0 : cd 6e 27 CMP $276e ; (Player + 0)
1ec3 : d0 0f __ BNE $1ed4 ; (check_player_enemy_collision.s18 + 0)
.s26:
1ec5 : bd b0 27 LDA $27b0,x ; (EnemyShot + 1)
1ec8 : cd 6f 27 CMP $276f ; (Player + 1)
1ecb : d0 07 __ BNE $1ed4 ; (check_player_enemy_collision.s18 + 0)
.s23:
1ecd : ad 5e 27 LDA $275e ; (game + 0)
1ed0 : c9 02 __ CMP #$02
1ed2 : d0 06 __ BNE $1eda ; (check_player_enemy_collision.s27 + 0)
.s18:
1ed4 : c8 __ __ INY
1ed5 : c0 03 __ CPY #$03
1ed7 : 90 da __ BCC $1eb3 ; (check_player_enemy_collision.l17 + 0)
.s1001:
1ed9 : 60 __ __ RTS
.s27:
1eda : 20 ed 1e JSR $1eed ; (render_player_dead.s0 + 0)
1edd : a9 02 __ LDA #$02
1edf : 8d 5e 27 STA $275e ; (game + 0)
1ee2 : 60 __ __ RTS
.s12:
1ee3 : 20 ed 1e JSR $1eed ; (render_player_dead.s0 + 0)
1ee6 : a9 02 __ LDA #$02
1ee8 : 8d 5e 27 STA $275e ; (game + 0)
1eeb : d0 c4 __ BNE $1eb1 ; (check_player_enemy_collision.s31 + 0)
--------------------------------------------------------------------
render_player_dead:
.s0:
1eed : ee 20 d0 INC $d020 
1ef0 : a9 ff __ LDA #$ff
1ef2 : 8d 18 d4 STA $d418 
1ef5 : a9 10 __ LDA #$10
1ef7 : 8d 00 d4 STA $d400 
1efa : a9 27 __ LDA #$27
1efc : 8d 01 d4 STA $d401 
1eff : a9 3a __ LDA #$3a
1f01 : 8d 05 d4 STA $d405 
1f04 : a9 00 __ LDA #$00
1f06 : 8d 06 d4 STA $d406 
1f09 : 8d 02 d4 STA $d402 
1f0c : a9 08 __ LDA #$08
1f0e : 8d 03 d4 STA $d403 
1f11 : a9 81 __ LDA #$81
1f13 : 8d 04 d4 STA $d404 
1f16 : ad 6f 27 LDA $276f ; (Player + 1)
1f19 : 85 1e __ STA ACCU + 3 
1f1b : ad 6e 27 LDA $276e ; (Player + 0)
1f1e : 85 43 __ STA T2 + 0 
1f20 : a9 00 __ LDA #$00
1f22 : 85 1d __ STA ACCU + 2 
.l2:
1f24 : a9 ff __ LDA #$ff
1f26 : 85 44 __ STA T3 + 0 
.l6:
1f28 : 29 80 __ AND #$80
1f2a : 10 02 __ BPL $1f2e ; (render_player_dead.l6 + 6)
1f2c : a9 ff __ LDA #$ff
1f2e : aa __ __ TAX
1f2f : 18 __ __ CLC
1f30 : a5 44 __ LDA T3 + 0 
1f32 : 65 1e __ ADC ACCU + 3 
1f34 : a8 __ __ TAY
1f35 : 90 01 __ BCC $1f38 ; (render_player_dead.s1009 + 0)
.s1008:
1f37 : e8 __ __ INX
.s1009:
1f38 : 86 1c __ STX ACCU + 1 
1f3a : 0a __ __ ASL
1f3b : 85 1b __ STA ACCU + 0 
1f3d : 8a __ __ TXA
1f3e : 2a __ __ ROL
1f3f : 06 1b __ ASL ACCU + 0 
1f41 : 2a __ __ ROL
1f42 : aa __ __ TAX
1f43 : 98 __ __ TYA
1f44 : 18 __ __ CLC
1f45 : 65 1b __ ADC ACCU + 0 
1f47 : 85 1b __ STA ACCU + 0 
1f49 : 8a __ __ TXA
1f4a : 65 1c __ ADC ACCU + 1 
1f4c : 06 1b __ ASL ACCU + 0 
1f4e : 2a __ __ ROL
1f4f : 06 1b __ ASL ACCU + 0 
1f51 : 2a __ __ ROL
1f52 : 06 1b __ ASL ACCU + 0 
1f54 : 2a __ __ ROL
1f55 : aa __ __ TAX
1f56 : 18 __ __ CLC
1f57 : a9 ff __ LDA #$ff
1f59 : 65 1b __ ADC ACCU + 0 
1f5b : a8 __ __ TAY
1f5c : 8a __ __ TXA
1f5d : 69 d7 __ ADC #$d7
1f5f : aa __ __ TAX
1f60 : 98 __ __ TYA
1f61 : 18 __ __ CLC
1f62 : 65 43 __ ADC T2 + 0 
1f64 : 85 1b __ STA ACCU + 0 
1f66 : 85 45 __ STA T5 + 0 
1f68 : 8a __ __ TXA
1f69 : 69 00 __ ADC #$00
1f6b : 85 1c __ STA ACCU + 1 
1f6d : 18 __ __ CLC
1f6e : 69 e8 __ ADC #$e8
1f70 : 85 46 __ STA T5 + 1 
1f72 : a0 00 __ LDY #$00
1f74 : a2 03 __ LDX #$03
.l1006:
1f76 : a9 86 __ LDA #$86
1f78 : 91 45 __ STA (T5 + 0),y 
1f7a : a5 1d __ LDA ACCU + 2 
1f7c : 91 1b __ STA (ACCU + 0),y 
1f7e : e6 45 __ INC T5 + 0 
1f80 : d0 02 __ BNE $1f84 ; (render_player_dead.s1011 + 0)
.s1010:
1f82 : e6 46 __ INC T5 + 1 
.s1011:
1f84 : e6 1b __ INC ACCU + 0 
1f86 : d0 02 __ BNE $1f8a ; (render_player_dead.s1013 + 0)
.s1012:
1f88 : e6 1c __ INC ACCU + 1 
.s1013:
1f8a : ca __ __ DEX
1f8b : d0 e9 __ BNE $1f76 ; (render_player_dead.l1006 + 0)
.s1007:
1f8d : e6 44 __ INC T3 + 0 
1f8f : a5 44 __ LDA T3 + 0 
1f91 : c9 02 __ CMP #$02
1f93 : 90 93 __ BCC $1f28 ; (render_player_dead.l6 + 0)
.l14:
1f95 : ad 11 d0 LDA $d011 
1f98 : 30 fb __ BMI $1f95 ; (render_player_dead.l14 + 0)
.l17:
1f9a : ad 11 d0 LDA $d011 
1f9d : 10 fb __ BPL $1f9a ; (render_player_dead.l17 + 0)
.s3:
1f9f : e6 1d __ INC ACCU + 2 
1fa1 : a5 1d __ LDA ACCU + 2 
1fa3 : c9 32 __ CMP #$32
1fa5 : b0 03 __ BCS $1faa ; (render_player_dead.s4 + 0)
1fa7 : 4c 24 1f JMP $1f24 ; (render_player_dead.l2 + 0)
.s4:
1faa : a9 08 __ LDA #$08
1fac : 8d 04 d4 STA $d404 
1faf : a9 00 __ LDA #$00
1fb1 : 8d 73 27 STA $2773 ; (PlayerShotSound + 3)
.s1001:
1fb4 : 60 __ __ RTS
--------------------------------------------------------------------
control_player_ship:
.s0:
1fb5 : a9 00 __ LDA #$00
1fb7 : 20 59 20 JSR $2059 ; (joy_poll.s0 + 0)
1fba : ad be 27 LDA $27be ; (joyx + 0)
1fbd : 85 1d __ STA ACCU + 2 
1fbf : 85 1e __ STA ACCU + 3 
1fc1 : d0 08 __ BNE $1fcb ; (control_player_ship.s1 + 0)
.s4:
1fc3 : ad bc 27 LDA $27bc ; (joyy + 0)
1fc6 : d0 03 __ BNE $1fcb ; (control_player_ship.s1 + 0)
1fc8 : 4c 4e 20 JMP $204e ; (control_player_ship.s3 + 0)
.s1:
1fcb : ad 6e 27 LDA $276e ; (Player + 0)
1fce : 85 43 __ STA T2 + 0 
1fd0 : 85 44 __ STA T3 + 0 
1fd2 : ad 6f 27 LDA $276f ; (Player + 1)
1fd5 : 85 45 __ STA T4 + 0 
1fd7 : 85 46 __ STA T5 + 0 
1fd9 : 0a __ __ ASL
1fda : 85 1b __ STA ACCU + 0 
1fdc : a9 00 __ LDA #$00
1fde : 2a __ __ ROL
1fdf : 06 1b __ ASL ACCU + 0 
1fe1 : 2a __ __ ROL
1fe2 : aa __ __ TAX
1fe3 : a5 1b __ LDA ACCU + 0 
1fe5 : 65 45 __ ADC T4 + 0 
1fe7 : 85 1b __ STA ACCU + 0 
1fe9 : 8a __ __ TXA
1fea : 69 00 __ ADC #$00
1fec : 06 1b __ ASL ACCU + 0 
1fee : 2a __ __ ROL
1fef : 06 1b __ ASL ACCU + 0 
1ff1 : 2a __ __ ROL
1ff2 : 06 1b __ ASL ACCU + 0 
1ff4 : 2a __ __ ROL
1ff5 : aa __ __ TAX
1ff6 : 18 __ __ CLC
1ff7 : a5 1b __ LDA ACCU + 0 
1ff9 : 65 43 __ ADC T2 + 0 
1ffb : 85 1b __ STA ACCU + 0 
1ffd : 85 1f __ STA ADDR + 0 
1fff : 8a __ __ TXA
2000 : 69 c0 __ ADC #$c0
2002 : 85 1c __ STA ACCU + 1 
2004 : 18 __ __ CLC
2005 : 69 18 __ ADC #$18
2007 : 85 20 __ STA ADDR + 1 
2009 : a9 20 __ LDA #$20
200b : a0 00 __ LDY #$00
200d : 91 1b __ STA (ACCU + 0),y 
200f : 98 __ __ TYA
2010 : 91 1f __ STA (ADDR + 0),y 
2012 : a5 43 __ LDA T2 + 0 
2014 : c9 02 __ CMP #$02
2016 : 90 06 __ BCC $201e ; (control_player_ship.s6 + 0)
.s8:
2018 : a5 1d __ LDA ACCU + 2 
201a : 30 0c __ BMI $2028 ; (control_player_ship.s5 + 0)
.s1015:
201c : a5 43 __ LDA T2 + 0 
.s6:
201e : c9 26 __ CMP #$26
2020 : b0 0e __ BCS $2030 ; (control_player_ship.s7 + 0)
.s12:
2022 : a5 1d __ LDA ACCU + 2 
2024 : 30 0a __ BMI $2030 ; (control_player_ship.s7 + 0)
.s1009:
2026 : f0 08 __ BEQ $2030 ; (control_player_ship.s7 + 0)
.s5:
2028 : 18 __ __ CLC
2029 : a5 44 __ LDA T3 + 0 
202b : 65 1e __ ADC ACCU + 3 
202d : 8d 6e 27 STA $276e ; (Player + 0)
.s7:
2030 : a5 45 __ LDA T4 + 0 
2032 : c9 05 __ CMP #$05
2034 : 90 07 __ BCC $203d ; (control_player_ship.s14 + 0)
.s16:
2036 : ad bc 27 LDA $27bc ; (joyy + 0)
2039 : 30 0d __ BMI $2048 ; (control_player_ship.s32 + 0)
.s1014:
203b : a5 45 __ LDA T4 + 0 
.s14:
203d : c9 17 __ CMP #$17
203f : b0 0d __ BCS $204e ; (control_player_ship.s3 + 0)
.s20:
2041 : ad bc 27 LDA $27bc ; (joyy + 0)
2044 : 30 08 __ BMI $204e ; (control_player_ship.s3 + 0)
.s1004:
2046 : f0 06 __ BEQ $204e ; (control_player_ship.s3 + 0)
.s32:
2048 : 18 __ __ CLC
2049 : 65 46 __ ADC T5 + 0 
204b : 8d 6f 27 STA $276f ; (Player + 1)
.s3:
204e : ad c0 27 LDA $27c0 ; (joyb + 0)
2051 : c9 01 __ CMP #$01
2053 : f0 01 __ BEQ $2056 ; (control_player_ship.s21 + 0)
.s1001:
2055 : 60 __ __ RTS
.s21:
2056 : 4c 99 20 JMP $2099 ; (spawn_player_shot.s0 + 0)
--------------------------------------------------------------------
joy_poll:
.s0:
2059 : aa __ __ TAX
205a : bd 00 dc LDA $dc00,x 
205d : a8 __ __ TAY
205e : 29 10 __ AND #$10
2060 : f0 04 __ BEQ $2066 ; (joy_poll.s1005 + 0)
.s1006:
2062 : a9 00 __ LDA #$00
2064 : f0 02 __ BEQ $2068 ; (joy_poll.s1007 + 0)
.s1005:
2066 : a9 01 __ LDA #$01
.s1007:
2068 : 9d c0 27 STA $27c0,x ; (joyb + 0)
206b : 98 __ __ TYA
206c : 4a __ __ LSR
206d : b0 1d __ BCS $208c ; (joy_poll.s2 + 0)
.s1:
206f : a9 ff __ LDA #$ff
.s15:
2071 : 9d bc 27 STA $27bc,x ; (joyy + 0)
2074 : 98 __ __ TYA
2075 : 29 04 __ AND #$04
2077 : d0 06 __ BNE $207f ; (joy_poll.s8 + 0)
.s7:
2079 : a9 ff __ LDA #$ff
.s1001:
207b : 9d be 27 STA $27be,x ; (joyx + 0)
207e : 60 __ __ RTS
.s8:
207f : 98 __ __ TYA
2080 : 29 08 __ AND #$08
2082 : f0 04 __ BEQ $2088 ; (joy_poll.s1011 + 0)
.s1012:
2084 : a9 00 __ LDA #$00
2086 : f0 f3 __ BEQ $207b ; (joy_poll.s1001 + 0)
.s1011:
2088 : a9 01 __ LDA #$01
208a : d0 ef __ BNE $207b ; (joy_poll.s1001 + 0)
.s2:
208c : 98 __ __ TYA
208d : 29 02 __ AND #$02
208f : f0 04 __ BEQ $2095 ; (joy_poll.s1008 + 0)
.s1009:
2091 : a9 00 __ LDA #$00
2093 : f0 dc __ BEQ $2071 ; (joy_poll.s15 + 0)
.s1008:
2095 : a9 01 __ LDA #$01
2097 : d0 d8 __ BNE $2071 ; (joy_poll.s15 + 0)
--------------------------------------------------------------------
joyy:
27bc : __ __ __ BSS	2
--------------------------------------------------------------------
joyx:
27be : __ __ __ BSS	2
--------------------------------------------------------------------
joyb:
27c0 : __ __ __ BSS	2
--------------------------------------------------------------------
spawn_player_shot:
.s0:
2099 : ad 6e 27 LDA $276e ; (Player + 0)
209c : c9 26 __ CMP #$26
209e : f0 0f __ BEQ $20af ; (spawn_player_shot.s1001 + 0)
.s3:
20a0 : a0 00 __ LDY #$00
.l6:
20a2 : be fd 08 LDX $08fd,y ; (__multab3L + 0)
20a5 : bd a8 27 LDA $27a8,x ; (PlayerShot + 2)
20a8 : f0 06 __ BEQ $20b0 ; (spawn_player_shot.s9 + 0)
.s7:
20aa : c8 __ __ INY
20ab : c0 03 __ CPY #$03
20ad : 90 f3 __ BCC $20a2 ; (spawn_player_shot.l6 + 0)
.s1001:
20af : 60 __ __ RTS
.s9:
20b0 : a9 01 __ LDA #$01
20b2 : 9d a8 27 STA $27a8,x ; (PlayerShot + 2)
20b5 : ad 6f 27 LDA $276f ; (Player + 1)
20b8 : 9d a7 27 STA $27a7,x ; (PlayerShot + 1)
20bb : ad be 27 LDA $27be ; (joyx + 0)
20be : 30 02 __ BMI $20c2 ; (spawn_player_shot.s13 + 0)
.s1004:
20c0 : d0 06 __ BNE $20c8 ; (spawn_player_shot.s12 + 0)
.s13:
20c2 : ad 6e 27 LDA $276e ; (Player + 0)
20c5 : 4c ce 20 JMP $20ce ; (spawn_player_shot.s14 + 0)
.s12:
20c8 : ad 6e 27 LDA $276e ; (Player + 0)
20cb : 18 __ __ CLC
20cc : 69 01 __ ADC #$01
.s14:
20ce : be fd 08 LDX $08fd,y ; (__multab3L + 0)
20d1 : 9d a6 27 STA $27a6,x ; (PlayerShot + 0)
20d4 : ad 73 27 LDA $2773 ; (PlayerShotSound + 3)
20d7 : d0 d6 __ BNE $20af ; (spawn_player_shot.s1001 + 0)
.s15:
20d9 : a9 01 __ LDA #$01
20db : 8d 73 27 STA $2773 ; (PlayerShotSound + 3)
20de : 60 __ __ RTS
--------------------------------------------------------------------
render_player_ship:
.s0:
20df : ad 6f 27 LDA $276f ; (Player + 1)
20e2 : 0a __ __ ASL
20e3 : 85 1b __ STA ACCU + 0 
20e5 : a9 00 __ LDA #$00
20e7 : 2a __ __ ROL
20e8 : 06 1b __ ASL ACCU + 0 
20ea : 2a __ __ ROL
20eb : aa __ __ TAX
20ec : a5 1b __ LDA ACCU + 0 
20ee : 6d 6f 27 ADC $276f ; (Player + 1)
20f1 : 85 1b __ STA ACCU + 0 
20f3 : 8a __ __ TXA
20f4 : 69 00 __ ADC #$00
20f6 : 06 1b __ ASL ACCU + 0 
20f8 : 2a __ __ ROL
20f9 : 06 1b __ ASL ACCU + 0 
20fb : 2a __ __ ROL
20fc : 06 1b __ ASL ACCU + 0 
20fe : 2a __ __ ROL
20ff : aa __ __ TAX
2100 : 18 __ __ CLC
2101 : a5 1b __ LDA ACCU + 0 
2103 : 6d 6e 27 ADC $276e ; (Player + 0)
2106 : 85 1b __ STA ACCU + 0 
2108 : 85 1f __ STA ADDR + 0 
210a : 8a __ __ TXA
210b : 69 c0 __ ADC #$c0
210d : 85 1c __ STA ACCU + 1 
210f : 18 __ __ CLC
2110 : 69 18 __ ADC #$18
2112 : 85 20 __ STA ADDR + 1 
2114 : a9 80 __ LDA #$80
2116 : a0 00 __ LDY #$00
2118 : 91 1b __ STA (ACCU + 0),y 
211a : a9 03 __ LDA #$03
211c : 91 1f __ STA (ADDR + 0),y 
.s1001:
211e : 60 __ __ RTS
--------------------------------------------------------------------
move_player_shots:
.s0:
211f : a2 00 __ LDX #$00
.l2:
2121 : 86 1d __ STX ACCU + 2 
2123 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
2126 : b9 a8 27 LDA $27a8,y ; (PlayerShot + 2)
2129 : c9 01 __ CMP #$01
212b : d0 52 __ BNE $217f ; (move_player_shots.s23 + 0)
.s5:
212d : 84 1e __ STY ACCU + 3 
212f : b9 a7 27 LDA $27a7,y ; (PlayerShot + 1)
2132 : 0a __ __ ASL
2133 : 85 1b __ STA ACCU + 0 
2135 : a9 00 __ LDA #$00
2137 : 2a __ __ ROL
2138 : 06 1b __ ASL ACCU + 0 
213a : 2a __ __ ROL
213b : aa __ __ TAX
213c : a5 1b __ LDA ACCU + 0 
213e : 79 a7 27 ADC $27a7,y ; (PlayerShot + 1)
2141 : 85 1b __ STA ACCU + 0 
2143 : 8a __ __ TXA
2144 : 69 00 __ ADC #$00
2146 : 06 1b __ ASL ACCU + 0 
2148 : 2a __ __ ROL
2149 : 06 1b __ ASL ACCU + 0 
214b : 2a __ __ ROL
214c : 06 1b __ ASL ACCU + 0 
214e : 2a __ __ ROL
214f : 85 1c __ STA ACCU + 1 
2151 : b9 a6 27 LDA $27a6,y ; (PlayerShot + 0)
2154 : aa __ __ TAX
2155 : 18 __ __ CLC
2156 : 65 1b __ ADC ACCU + 0 
2158 : 85 1b __ STA ACCU + 0 
215a : 85 1f __ STA ADDR + 0 
215c : a5 1c __ LDA ACCU + 1 
215e : 69 c0 __ ADC #$c0
2160 : 85 1c __ STA ACCU + 1 
2162 : 18 __ __ CLC
2163 : 69 18 __ ADC #$18
2165 : 85 20 __ STA ADDR + 1 
2167 : a9 20 __ LDA #$20
2169 : a0 00 __ LDY #$00
216b : 91 1b __ STA (ACCU + 0),y 
216d : 98 __ __ TYA
216e : 91 1f __ STA (ADDR + 0),y 
2170 : e8 __ __ INX
2171 : 8a __ __ TXA
2172 : a6 1e __ LDX ACCU + 3 
2174 : 9d a6 27 STA $27a6,x ; (PlayerShot + 0)
2177 : c9 27 __ CMP #$27
2179 : 90 04 __ BCC $217f ; (move_player_shots.s23 + 0)
.s8:
217b : 98 __ __ TYA
217c : 9d a8 27 STA $27a8,x ; (PlayerShot + 2)
.s23:
217f : a6 1d __ LDX ACCU + 2 
2181 : e8 __ __ INX
2182 : e0 03 __ CPX #$03
2184 : 90 9b __ BCC $2121 ; (move_player_shots.l2 + 0)
.s1001:
2186 : 60 __ __ RTS
--------------------------------------------------------------------
render_player_shots:
.s0:
2187 : a2 00 __ LDX #$00
.l1006:
2189 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
218c : b9 a8 27 LDA $27a8,y ; (PlayerShot + 2)
218f : c9 01 __ CMP #$01
2191 : d0 43 __ BNE $21d6 ; (render_player_shots.s19 + 0)
.s5:
2193 : b9 a7 27 LDA $27a7,y ; (PlayerShot + 1)
2196 : 0a __ __ ASL
2197 : 85 1b __ STA ACCU + 0 
2199 : a9 00 __ LDA #$00
219b : 2a __ __ ROL
219c : 06 1b __ ASL ACCU + 0 
219e : 2a __ __ ROL
219f : 85 1c __ STA ACCU + 1 
21a1 : a5 1b __ LDA ACCU + 0 
21a3 : 79 a7 27 ADC $27a7,y ; (PlayerShot + 1)
21a6 : 85 1b __ STA ACCU + 0 
21a8 : a5 1c __ LDA ACCU + 1 
21aa : 69 00 __ ADC #$00
21ac : 06 1b __ ASL ACCU + 0 
21ae : 2a __ __ ROL
21af : 06 1b __ ASL ACCU + 0 
21b1 : 2a __ __ ROL
21b2 : 06 1b __ ASL ACCU + 0 
21b4 : 2a __ __ ROL
21b5 : 85 1c __ STA ACCU + 1 
21b7 : 18 __ __ CLC
21b8 : a5 1b __ LDA ACCU + 0 
21ba : 79 a6 27 ADC $27a6,y ; (PlayerShot + 0)
21bd : 85 1b __ STA ACCU + 0 
21bf : 85 1f __ STA ADDR + 0 
21c1 : a5 1c __ LDA ACCU + 1 
21c3 : 69 c0 __ ADC #$c0
21c5 : 85 1c __ STA ACCU + 1 
21c7 : 18 __ __ CLC
21c8 : 69 18 __ ADC #$18
21ca : 85 20 __ STA ADDR + 1 
21cc : a9 81 __ LDA #$81
21ce : a0 00 __ LDY #$00
21d0 : 91 1b __ STA (ACCU + 0),y 
21d2 : a9 01 __ LDA #$01
21d4 : 91 1f __ STA (ADDR + 0),y 
.s19:
21d6 : e8 __ __ INX
21d7 : e0 03 __ CPX #$03
21d9 : 90 ae __ BCC $2189 ; (render_player_shots.l1006 + 0)
.s1001:
21db : 60 __ __ RTS
--------------------------------------------------------------------
wait_frames:
.s0:
21dc : a5 0e __ LDA P1 ; (frames + 1)
21de : 30 1c __ BMI $21fc ; (wait_frames.s1001 + 0)
.s1005:
21e0 : 05 0d __ ORA P0 ; (frames + 0)
21e2 : f0 18 __ BEQ $21fc ; (wait_frames.s1001 + 0)
.s13:
21e4 : a0 00 __ LDY #$00
21e6 : a6 0e __ LDX P1 ; (frames + 1)
.l6:
21e8 : ad 11 d0 LDA $d011 
21eb : 30 fb __ BMI $21e8 ; (wait_frames.l6 + 0)
.l9:
21ed : ad 11 d0 LDA $d011 
21f0 : 10 fb __ BPL $21ed ; (wait_frames.l9 + 0)
.s3:
21f2 : c8 __ __ INY
21f3 : 8a __ __ TXA
21f4 : 30 06 __ BMI $21fc ; (wait_frames.s1001 + 0)
.s1004:
21f6 : d0 f0 __ BNE $21e8 ; (wait_frames.l6 + 0)
.s1002:
21f8 : c4 0d __ CPY P0 ; (frames + 0)
21fa : 90 ec __ BCC $21e8 ; (wait_frames.l6 + 0)
.s1001:
21fc : 60 __ __ RTS
--------------------------------------------------------------------
freg:
21fd : b1 19 __ LDA (IP + 0),y 
21ff : c8 __ __ INY
2200 : aa __ __ TAX
2201 : b5 00 __ LDA $00,x 
2203 : 85 03 __ STA WORK + 0 
2205 : b5 01 __ LDA $01,x 
2207 : 85 04 __ STA WORK + 1 
2209 : b5 02 __ LDA $02,x 
220b : 85 05 __ STA WORK + 2 
220d : b5 03 __ LDA WORK + 0,x 
220f : 85 06 __ STA WORK + 3 
2211 : a5 05 __ LDA WORK + 2 
2213 : 0a __ __ ASL
2214 : a5 06 __ LDA WORK + 3 
2216 : 2a __ __ ROL
2217 : 85 08 __ STA WORK + 5 
2219 : f0 06 __ BEQ $2221 ; (freg + 36)
221b : a5 05 __ LDA WORK + 2 
221d : 09 80 __ ORA #$80
221f : 85 05 __ STA WORK + 2 
2221 : a5 1d __ LDA ACCU + 2 
2223 : 0a __ __ ASL
2224 : a5 1e __ LDA ACCU + 3 
2226 : 2a __ __ ROL
2227 : 85 07 __ STA WORK + 4 
2229 : f0 06 __ BEQ $2231 ; (freg + 52)
222b : a5 1d __ LDA ACCU + 2 
222d : 09 80 __ ORA #$80
222f : 85 1d __ STA ACCU + 2 
2231 : 60 __ __ RTS
2232 : 06 1e __ ASL ACCU + 3 
2234 : a5 07 __ LDA WORK + 4 
2236 : 6a __ __ ROR
2237 : 85 1e __ STA ACCU + 3 
2239 : b0 06 __ BCS $2241 ; (freg + 68)
223b : a5 1d __ LDA ACCU + 2 
223d : 29 7f __ AND #$7f
223f : 85 1d __ STA ACCU + 2 
2241 : 60 __ __ RTS
--------------------------------------------------------------------
faddsub:
2242 : a9 ff __ LDA #$ff
2244 : c5 07 __ CMP WORK + 4 
2246 : f0 04 __ BEQ $224c ; (faddsub + 10)
2248 : c5 08 __ CMP WORK + 5 
224a : d0 11 __ BNE $225d ; (faddsub + 27)
224c : a5 1e __ LDA ACCU + 3 
224e : 09 7f __ ORA #$7f
2250 : 85 1e __ STA ACCU + 3 
2252 : a9 80 __ LDA #$80
2254 : 85 1d __ STA ACCU + 2 
2256 : a9 00 __ LDA #$00
2258 : 85 1b __ STA ACCU + 0 
225a : 85 1c __ STA ACCU + 1 
225c : 60 __ __ RTS
225d : 38 __ __ SEC
225e : a5 07 __ LDA WORK + 4 
2260 : e5 08 __ SBC WORK + 5 
2262 : f0 38 __ BEQ $229c ; (faddsub + 90)
2264 : aa __ __ TAX
2265 : b0 25 __ BCS $228c ; (faddsub + 74)
2267 : e0 e9 __ CPX #$e9
2269 : b0 0e __ BCS $2279 ; (faddsub + 55)
226b : a5 08 __ LDA WORK + 5 
226d : 85 07 __ STA WORK + 4 
226f : a9 00 __ LDA #$00
2271 : 85 1b __ STA ACCU + 0 
2273 : 85 1c __ STA ACCU + 1 
2275 : 85 1d __ STA ACCU + 2 
2277 : f0 23 __ BEQ $229c ; (faddsub + 90)
2279 : a5 1d __ LDA ACCU + 2 
227b : 4a __ __ LSR
227c : 66 1c __ ROR ACCU + 1 
227e : 66 1b __ ROR ACCU + 0 
2280 : e8 __ __ INX
2281 : d0 f8 __ BNE $227b ; (faddsub + 57)
2283 : 85 1d __ STA ACCU + 2 
2285 : a5 08 __ LDA WORK + 5 
2287 : 85 07 __ STA WORK + 4 
2289 : 4c 9c 22 JMP $229c ; (faddsub + 90)
228c : e0 18 __ CPX #$18
228e : b0 33 __ BCS $22c3 ; (faddsub + 129)
2290 : a5 05 __ LDA WORK + 2 
2292 : 4a __ __ LSR
2293 : 66 04 __ ROR WORK + 1 
2295 : 66 03 __ ROR WORK + 0 
2297 : ca __ __ DEX
2298 : d0 f8 __ BNE $2292 ; (faddsub + 80)
229a : 85 05 __ STA WORK + 2 
229c : a5 1e __ LDA ACCU + 3 
229e : 29 80 __ AND #$80
22a0 : 85 1e __ STA ACCU + 3 
22a2 : 45 06 __ EOR WORK + 3 
22a4 : 30 31 __ BMI $22d7 ; (faddsub + 149)
22a6 : 18 __ __ CLC
22a7 : a5 1b __ LDA ACCU + 0 
22a9 : 65 03 __ ADC WORK + 0 
22ab : 85 1b __ STA ACCU + 0 
22ad : a5 1c __ LDA ACCU + 1 
22af : 65 04 __ ADC WORK + 1 
22b1 : 85 1c __ STA ACCU + 1 
22b3 : a5 1d __ LDA ACCU + 2 
22b5 : 65 05 __ ADC WORK + 2 
22b7 : 85 1d __ STA ACCU + 2 
22b9 : 90 08 __ BCC $22c3 ; (faddsub + 129)
22bb : 66 1d __ ROR ACCU + 2 
22bd : 66 1c __ ROR ACCU + 1 
22bf : 66 1b __ ROR ACCU + 0 
22c1 : e6 07 __ INC WORK + 4 
22c3 : a5 07 __ LDA WORK + 4 
22c5 : c9 ff __ CMP #$ff
22c7 : f0 83 __ BEQ $224c ; (faddsub + 10)
22c9 : 4a __ __ LSR
22ca : 05 1e __ ORA ACCU + 3 
22cc : 85 1e __ STA ACCU + 3 
22ce : b0 06 __ BCS $22d6 ; (faddsub + 148)
22d0 : a5 1d __ LDA ACCU + 2 
22d2 : 29 7f __ AND #$7f
22d4 : 85 1d __ STA ACCU + 2 
22d6 : 60 __ __ RTS
22d7 : 38 __ __ SEC
22d8 : a5 1b __ LDA ACCU + 0 
22da : e5 03 __ SBC WORK + 0 
22dc : 85 1b __ STA ACCU + 0 
22de : a5 1c __ LDA ACCU + 1 
22e0 : e5 04 __ SBC WORK + 1 
22e2 : 85 1c __ STA ACCU + 1 
22e4 : a5 1d __ LDA ACCU + 2 
22e6 : e5 05 __ SBC WORK + 2 
22e8 : 85 1d __ STA ACCU + 2 
22ea : b0 19 __ BCS $2305 ; (faddsub + 195)
22ec : 38 __ __ SEC
22ed : a9 00 __ LDA #$00
22ef : e5 1b __ SBC ACCU + 0 
22f1 : 85 1b __ STA ACCU + 0 
22f3 : a9 00 __ LDA #$00
22f5 : e5 1c __ SBC ACCU + 1 
22f7 : 85 1c __ STA ACCU + 1 
22f9 : a9 00 __ LDA #$00
22fb : e5 1d __ SBC ACCU + 2 
22fd : 85 1d __ STA ACCU + 2 
22ff : a5 1e __ LDA ACCU + 3 
2301 : 49 80 __ EOR #$80
2303 : 85 1e __ STA ACCU + 3 
2305 : a5 1d __ LDA ACCU + 2 
2307 : 30 ba __ BMI $22c3 ; (faddsub + 129)
2309 : 05 1c __ ORA ACCU + 1 
230b : 05 1b __ ORA ACCU + 0 
230d : f0 0f __ BEQ $231e ; (faddsub + 220)
230f : c6 07 __ DEC WORK + 4 
2311 : f0 0b __ BEQ $231e ; (faddsub + 220)
2313 : 06 1b __ ASL ACCU + 0 
2315 : 26 1c __ ROL ACCU + 1 
2317 : 26 1d __ ROL ACCU + 2 
2319 : 10 f4 __ BPL $230f ; (faddsub + 205)
231b : 4c c3 22 JMP $22c3 ; (faddsub + 129)
231e : a9 00 __ LDA #$00
2320 : 85 1b __ STA ACCU + 0 
2322 : 85 1c __ STA ACCU + 1 
2324 : 85 1d __ STA ACCU + 2 
2326 : 85 1e __ STA ACCU + 3 
2328 : 60 __ __ RTS
--------------------------------------------------------------------
fmul:
2329 : a5 1b __ LDA ACCU + 0 
232b : 05 1c __ ORA ACCU + 1 
232d : 05 1d __ ORA ACCU + 2 
232f : d0 03 __ BNE $2334 ; (fmul + 11)
2331 : 85 1e __ STA ACCU + 3 
2333 : 60 __ __ RTS
2334 : a5 03 __ LDA WORK + 0 
2336 : 05 04 __ ORA WORK + 1 
2338 : 05 05 __ ORA WORK + 2 
233a : d0 09 __ BNE $2345 ; (fmul + 28)
233c : 85 1b __ STA ACCU + 0 
233e : 85 1c __ STA ACCU + 1 
2340 : 85 1d __ STA ACCU + 2 
2342 : 85 1e __ STA ACCU + 3 
2344 : 60 __ __ RTS
2345 : a5 1e __ LDA ACCU + 3 
2347 : 45 06 __ EOR WORK + 3 
2349 : 29 80 __ AND #$80
234b : 85 1e __ STA ACCU + 3 
234d : a9 ff __ LDA #$ff
234f : c5 07 __ CMP WORK + 4 
2351 : f0 42 __ BEQ $2395 ; (fmul + 108)
2353 : c5 08 __ CMP WORK + 5 
2355 : f0 3e __ BEQ $2395 ; (fmul + 108)
2357 : a9 00 __ LDA #$00
2359 : 85 09 __ STA WORK + 6 
235b : 85 0a __ STA WORK + 7 
235d : 85 0b __ STA $0b 
235f : a4 1b __ LDY ACCU + 0 
2361 : a5 03 __ LDA WORK + 0 
2363 : d0 06 __ BNE $236b ; (fmul + 66)
2365 : a5 04 __ LDA WORK + 1 
2367 : f0 0a __ BEQ $2373 ; (fmul + 74)
2369 : d0 05 __ BNE $2370 ; (fmul + 71)
236b : 20 ca 23 JSR $23ca ; (fmul8 + 0)
236e : a5 04 __ LDA WORK + 1 
2370 : 20 ca 23 JSR $23ca ; (fmul8 + 0)
2373 : a5 05 __ LDA WORK + 2 
2375 : 20 ca 23 JSR $23ca ; (fmul8 + 0)
2378 : 38 __ __ SEC
2379 : a5 0b __ LDA $0b 
237b : 30 06 __ BMI $2383 ; (fmul + 90)
237d : 06 09 __ ASL WORK + 6 
237f : 26 0a __ ROL WORK + 7 
2381 : 2a __ __ ROL
2382 : 18 __ __ CLC
2383 : 29 7f __ AND #$7f
2385 : 85 0b __ STA $0b 
2387 : a5 07 __ LDA WORK + 4 
2389 : 65 08 __ ADC WORK + 5 
238b : 90 19 __ BCC $23a6 ; (fmul + 125)
238d : e9 7f __ SBC #$7f
238f : b0 04 __ BCS $2395 ; (fmul + 108)
2391 : c9 ff __ CMP #$ff
2393 : d0 15 __ BNE $23aa ; (fmul + 129)
2395 : a5 1e __ LDA ACCU + 3 
2397 : 09 7f __ ORA #$7f
2399 : 85 1e __ STA ACCU + 3 
239b : a9 80 __ LDA #$80
239d : 85 1d __ STA ACCU + 2 
239f : a9 00 __ LDA #$00
23a1 : 85 1b __ STA ACCU + 0 
23a3 : 85 1c __ STA ACCU + 1 
23a5 : 60 __ __ RTS
23a6 : e9 7e __ SBC #$7e
23a8 : 90 15 __ BCC $23bf ; (fmul + 150)
23aa : 4a __ __ LSR
23ab : 05 1e __ ORA ACCU + 3 
23ad : 85 1e __ STA ACCU + 3 
23af : a9 00 __ LDA #$00
23b1 : 6a __ __ ROR
23b2 : 05 0b __ ORA $0b 
23b4 : 85 1d __ STA ACCU + 2 
23b6 : a5 0a __ LDA WORK + 7 
23b8 : 85 1c __ STA ACCU + 1 
23ba : a5 09 __ LDA WORK + 6 
23bc : 85 1b __ STA ACCU + 0 
23be : 60 __ __ RTS
23bf : a9 00 __ LDA #$00
23c1 : 85 1b __ STA ACCU + 0 
23c3 : 85 1c __ STA ACCU + 1 
23c5 : 85 1d __ STA ACCU + 2 
23c7 : 85 1e __ STA ACCU + 3 
23c9 : 60 __ __ RTS
--------------------------------------------------------------------
fmul8:
23ca : 38 __ __ SEC
23cb : 6a __ __ ROR
23cc : 90 1e __ BCC $23ec ; (fmul8 + 34)
23ce : aa __ __ TAX
23cf : 18 __ __ CLC
23d0 : 98 __ __ TYA
23d1 : 65 09 __ ADC WORK + 6 
23d3 : 85 09 __ STA WORK + 6 
23d5 : a5 0a __ LDA WORK + 7 
23d7 : 65 1c __ ADC ACCU + 1 
23d9 : 85 0a __ STA WORK + 7 
23db : a5 0b __ LDA $0b 
23dd : 65 1d __ ADC ACCU + 2 
23df : 6a __ __ ROR
23e0 : 85 0b __ STA $0b 
23e2 : 8a __ __ TXA
23e3 : 66 0a __ ROR WORK + 7 
23e5 : 66 09 __ ROR WORK + 6 
23e7 : 4a __ __ LSR
23e8 : f0 0d __ BEQ $23f7 ; (fmul8 + 45)
23ea : b0 e2 __ BCS $23ce ; (fmul8 + 4)
23ec : 66 0b __ ROR $0b 
23ee : 66 0a __ ROR WORK + 7 
23f0 : 66 09 __ ROR WORK + 6 
23f2 : 4a __ __ LSR
23f3 : 90 f7 __ BCC $23ec ; (fmul8 + 34)
23f5 : d0 d7 __ BNE $23ce ; (fmul8 + 4)
23f7 : 60 __ __ RTS
--------------------------------------------------------------------
fdiv:
23f8 : a5 1b __ LDA ACCU + 0 
23fa : 05 1c __ ORA ACCU + 1 
23fc : 05 1d __ ORA ACCU + 2 
23fe : d0 03 __ BNE $2403 ; (fdiv + 11)
2400 : 85 1e __ STA ACCU + 3 
2402 : 60 __ __ RTS
2403 : a5 1e __ LDA ACCU + 3 
2405 : 45 06 __ EOR WORK + 3 
2407 : 29 80 __ AND #$80
2409 : 85 1e __ STA ACCU + 3 
240b : a5 08 __ LDA WORK + 5 
240d : f0 62 __ BEQ $2471 ; (fdiv + 121)
240f : a5 07 __ LDA WORK + 4 
2411 : c9 ff __ CMP #$ff
2413 : f0 5c __ BEQ $2471 ; (fdiv + 121)
2415 : a9 00 __ LDA #$00
2417 : 85 09 __ STA WORK + 6 
2419 : 85 0a __ STA WORK + 7 
241b : 85 0b __ STA $0b 
241d : a2 18 __ LDX #$18
241f : a5 1b __ LDA ACCU + 0 
2421 : c5 03 __ CMP WORK + 0 
2423 : a5 1c __ LDA ACCU + 1 
2425 : e5 04 __ SBC WORK + 1 
2427 : a5 1d __ LDA ACCU + 2 
2429 : e5 05 __ SBC WORK + 2 
242b : 90 13 __ BCC $2440 ; (fdiv + 72)
242d : a5 1b __ LDA ACCU + 0 
242f : e5 03 __ SBC WORK + 0 
2431 : 85 1b __ STA ACCU + 0 
2433 : a5 1c __ LDA ACCU + 1 
2435 : e5 04 __ SBC WORK + 1 
2437 : 85 1c __ STA ACCU + 1 
2439 : a5 1d __ LDA ACCU + 2 
243b : e5 05 __ SBC WORK + 2 
243d : 85 1d __ STA ACCU + 2 
243f : 38 __ __ SEC
2440 : 26 09 __ ROL WORK + 6 
2442 : 26 0a __ ROL WORK + 7 
2444 : 26 0b __ ROL $0b 
2446 : ca __ __ DEX
2447 : f0 0a __ BEQ $2453 ; (fdiv + 91)
2449 : 06 1b __ ASL ACCU + 0 
244b : 26 1c __ ROL ACCU + 1 
244d : 26 1d __ ROL ACCU + 2 
244f : b0 dc __ BCS $242d ; (fdiv + 53)
2451 : 90 cc __ BCC $241f ; (fdiv + 39)
2453 : 38 __ __ SEC
2454 : a5 0b __ LDA $0b 
2456 : 30 06 __ BMI $245e ; (fdiv + 102)
2458 : 06 09 __ ASL WORK + 6 
245a : 26 0a __ ROL WORK + 7 
245c : 2a __ __ ROL
245d : 18 __ __ CLC
245e : 29 7f __ AND #$7f
2460 : 85 0b __ STA $0b 
2462 : a5 07 __ LDA WORK + 4 
2464 : e5 08 __ SBC WORK + 5 
2466 : 90 1a __ BCC $2482 ; (fdiv + 138)
2468 : 18 __ __ CLC
2469 : 69 7f __ ADC #$7f
246b : b0 04 __ BCS $2471 ; (fdiv + 121)
246d : c9 ff __ CMP #$ff
246f : d0 15 __ BNE $2486 ; (fdiv + 142)
2471 : a5 1e __ LDA ACCU + 3 
2473 : 09 7f __ ORA #$7f
2475 : 85 1e __ STA ACCU + 3 
2477 : a9 80 __ LDA #$80
2479 : 85 1d __ STA ACCU + 2 
247b : a9 00 __ LDA #$00
247d : 85 1c __ STA ACCU + 1 
247f : 85 1b __ STA ACCU + 0 
2481 : 60 __ __ RTS
2482 : 69 7f __ ADC #$7f
2484 : 90 15 __ BCC $249b ; (fdiv + 163)
2486 : 4a __ __ LSR
2487 : 05 1e __ ORA ACCU + 3 
2489 : 85 1e __ STA ACCU + 3 
248b : a9 00 __ LDA #$00
248d : 6a __ __ ROR
248e : 05 0b __ ORA $0b 
2490 : 85 1d __ STA ACCU + 2 
2492 : a5 0a __ LDA WORK + 7 
2494 : 85 1c __ STA ACCU + 1 
2496 : a5 09 __ LDA WORK + 6 
2498 : 85 1b __ STA ACCU + 0 
249a : 60 __ __ RTS
249b : a9 00 __ LDA #$00
249d : 85 1e __ STA ACCU + 3 
249f : 85 1d __ STA ACCU + 2 
24a1 : 85 1c __ STA ACCU + 1 
24a3 : 85 1b __ STA ACCU + 0 
24a5 : 60 __ __ RTS
--------------------------------------------------------------------
divs16:
24a6 : 24 1c __ BIT ACCU + 1 
24a8 : 10 0d __ BPL $24b7 ; (divs16 + 17)
24aa : 20 c4 24 JSR $24c4 ; (negaccu + 0)
24ad : 24 04 __ BIT WORK + 1 
24af : 10 0d __ BPL $24be ; (divs16 + 24)
24b1 : 20 d2 24 JSR $24d2 ; (negtmp + 0)
24b4 : 4c e0 24 JMP $24e0 ; (divmod + 0)
24b7 : 24 04 __ BIT WORK + 1 
24b9 : 10 f9 __ BPL $24b4 ; (divs16 + 14)
24bb : 20 d2 24 JSR $24d2 ; (negtmp + 0)
24be : 20 e0 24 JSR $24e0 ; (divmod + 0)
24c1 : 4c c4 24 JMP $24c4 ; (negaccu + 0)
--------------------------------------------------------------------
negaccu:
24c4 : 38 __ __ SEC
24c5 : a9 00 __ LDA #$00
24c7 : e5 1b __ SBC ACCU + 0 
24c9 : 85 1b __ STA ACCU + 0 
24cb : a9 00 __ LDA #$00
24cd : e5 1c __ SBC ACCU + 1 
24cf : 85 1c __ STA ACCU + 1 
24d1 : 60 __ __ RTS
--------------------------------------------------------------------
negtmp:
24d2 : 38 __ __ SEC
24d3 : a9 00 __ LDA #$00
24d5 : e5 03 __ SBC WORK + 0 
24d7 : 85 03 __ STA WORK + 0 
24d9 : a9 00 __ LDA #$00
24db : e5 04 __ SBC WORK + 1 
24dd : 85 04 __ STA WORK + 1 
24df : 60 __ __ RTS
--------------------------------------------------------------------
divmod:
24e0 : a5 1c __ LDA ACCU + 1 
24e2 : d0 31 __ BNE $2515 ; (divmod + 53)
24e4 : a5 04 __ LDA WORK + 1 
24e6 : d0 1e __ BNE $2506 ; (divmod + 38)
24e8 : 85 06 __ STA WORK + 3 
24ea : a2 04 __ LDX #$04
24ec : 06 1b __ ASL ACCU + 0 
24ee : 2a __ __ ROL
24ef : c5 03 __ CMP WORK + 0 
24f1 : 90 02 __ BCC $24f5 ; (divmod + 21)
24f3 : e5 03 __ SBC WORK + 0 
24f5 : 26 1b __ ROL ACCU + 0 
24f7 : 2a __ __ ROL
24f8 : c5 03 __ CMP WORK + 0 
24fa : 90 02 __ BCC $24fe ; (divmod + 30)
24fc : e5 03 __ SBC WORK + 0 
24fe : 26 1b __ ROL ACCU + 0 
2500 : ca __ __ DEX
2501 : d0 eb __ BNE $24ee ; (divmod + 14)
2503 : 85 05 __ STA WORK + 2 
2505 : 60 __ __ RTS
2506 : a5 1b __ LDA ACCU + 0 
2508 : 85 05 __ STA WORK + 2 
250a : a5 1c __ LDA ACCU + 1 
250c : 85 06 __ STA WORK + 3 
250e : a9 00 __ LDA #$00
2510 : 85 1b __ STA ACCU + 0 
2512 : 85 1c __ STA ACCU + 1 
2514 : 60 __ __ RTS
2515 : a5 04 __ LDA WORK + 1 
2517 : d0 1f __ BNE $2538 ; (divmod + 88)
2519 : a5 03 __ LDA WORK + 0 
251b : 30 1b __ BMI $2538 ; (divmod + 88)
251d : a9 00 __ LDA #$00
251f : 85 06 __ STA WORK + 3 
2521 : a2 10 __ LDX #$10
2523 : 06 1b __ ASL ACCU + 0 
2525 : 26 1c __ ROL ACCU + 1 
2527 : 2a __ __ ROL
2528 : c5 03 __ CMP WORK + 0 
252a : 90 02 __ BCC $252e ; (divmod + 78)
252c : e5 03 __ SBC WORK + 0 
252e : 26 1b __ ROL ACCU + 0 
2530 : 26 1c __ ROL ACCU + 1 
2532 : ca __ __ DEX
2533 : d0 f2 __ BNE $2527 ; (divmod + 71)
2535 : 85 05 __ STA WORK + 2 
2537 : 60 __ __ RTS
2538 : a9 00 __ LDA #$00
253a : 85 05 __ STA WORK + 2 
253c : 85 06 __ STA WORK + 3 
253e : 84 02 __ STY $02 
2540 : a0 10 __ LDY #$10
2542 : 18 __ __ CLC
2543 : 26 1b __ ROL ACCU + 0 
2545 : 26 1c __ ROL ACCU + 1 
2547 : 26 05 __ ROL WORK + 2 
2549 : 26 06 __ ROL WORK + 3 
254b : 38 __ __ SEC
254c : a5 05 __ LDA WORK + 2 
254e : e5 03 __ SBC WORK + 0 
2550 : aa __ __ TAX
2551 : a5 06 __ LDA WORK + 3 
2553 : e5 04 __ SBC WORK + 1 
2555 : 90 04 __ BCC $255b ; (divmod + 123)
2557 : 86 05 __ STX WORK + 2 
2559 : 85 06 __ STA WORK + 3 
255b : 88 __ __ DEY
255c : d0 e5 __ BNE $2543 ; (divmod + 99)
255e : 26 1b __ ROL ACCU + 0 
2560 : 26 1c __ ROL ACCU + 1 
2562 : a4 02 __ LDY $02 
2564 : 60 __ __ RTS
--------------------------------------------------------------------
mods16:
2565 : 24 1c __ BIT ACCU + 1 
2567 : 10 0d __ BPL $2576 ; (mods16 + 17)
2569 : 20 c4 24 JSR $24c4 ; (negaccu + 0)
256c : 24 04 __ BIT WORK + 1 
256e : 10 0d __ BPL $257d ; (mods16 + 24)
2570 : 20 d2 24 JSR $24d2 ; (negtmp + 0)
2573 : 4c e0 24 JMP $24e0 ; (divmod + 0)
2576 : 24 04 __ BIT WORK + 1 
2578 : 10 f9 __ BPL $2573 ; (mods16 + 14)
257a : 20 d2 24 JSR $24d2 ; (negtmp + 0)
257d : 20 e0 24 JSR $24e0 ; (divmod + 0)
2580 : 38 __ __ SEC
2581 : a9 00 __ LDA #$00
2583 : e5 05 __ SBC WORK + 2 
2585 : 85 05 __ STA WORK + 2 
2587 : a9 00 __ LDA #$00
2589 : e5 06 __ SBC WORK + 3 
258b : 85 06 __ STA WORK + 3 
258d : 60 __ __ RTS
--------------------------------------------------------------------
f32_to_i16:
258e : 20 21 22 JSR $2221 ; (freg + 36)
2591 : a5 07 __ LDA WORK + 4 
2593 : c9 7f __ CMP #$7f
2595 : b0 07 __ BCS $259e ; (f32_to_i16 + 16)
2597 : a9 00 __ LDA #$00
2599 : 85 1b __ STA ACCU + 0 
259b : 85 1c __ STA ACCU + 1 
259d : 60 __ __ RTS
259e : 38 __ __ SEC
259f : e9 8e __ SBC #$8e
25a1 : 90 0a __ BCC $25ad ; (f32_to_i16 + 31)
25a3 : a9 ff __ LDA #$ff
25a5 : 85 1b __ STA ACCU + 0 
25a7 : a9 7f __ LDA #$7f
25a9 : 85 1c __ STA ACCU + 1 
25ab : d0 08 __ BNE $25b5 ; (f32_to_i16 + 39)
25ad : aa __ __ TAX
25ae : 46 1d __ LSR ACCU + 2 
25b0 : 66 1c __ ROR ACCU + 1 
25b2 : e8 __ __ INX
25b3 : d0 f9 __ BNE $25ae ; (f32_to_i16 + 32)
25b5 : 24 1e __ BIT ACCU + 3 
25b7 : 10 0e __ BPL $25c7 ; (f32_to_i16 + 57)
25b9 : 38 __ __ SEC
25ba : a9 00 __ LDA #$00
25bc : e5 1c __ SBC ACCU + 1 
25be : 85 1b __ STA ACCU + 0 
25c0 : a9 00 __ LDA #$00
25c2 : e5 1d __ SBC ACCU + 2 
25c4 : 85 1c __ STA ACCU + 1 
25c6 : 60 __ __ RTS
25c7 : a5 1c __ LDA ACCU + 1 
25c9 : 85 1b __ STA ACCU + 0 
25cb : a5 1d __ LDA ACCU + 2 
25cd : 85 1c __ STA ACCU + 1 
25cf : 60 __ __ RTS
--------------------------------------------------------------------
sint16_to_float:
25d0 : 24 1c __ BIT ACCU + 1 
25d2 : 30 03 __ BMI $25d7 ; (sint16_to_float + 7)
25d4 : 4c ee 25 JMP $25ee ; (uint16_to_float + 0)
25d7 : 38 __ __ SEC
25d8 : a9 00 __ LDA #$00
25da : e5 1b __ SBC ACCU + 0 
25dc : 85 1b __ STA ACCU + 0 
25de : a9 00 __ LDA #$00
25e0 : e5 1c __ SBC ACCU + 1 
25e2 : 85 1c __ STA ACCU + 1 
25e4 : 20 ee 25 JSR $25ee ; (uint16_to_float + 0)
25e7 : a5 1e __ LDA ACCU + 3 
25e9 : 09 80 __ ORA #$80
25eb : 85 1e __ STA ACCU + 3 
25ed : 60 __ __ RTS
--------------------------------------------------------------------
uint16_to_float:
25ee : a5 1b __ LDA ACCU + 0 
25f0 : 05 1c __ ORA ACCU + 1 
25f2 : d0 05 __ BNE $25f9 ; (uint16_to_float + 11)
25f4 : 85 1d __ STA ACCU + 2 
25f6 : 85 1e __ STA ACCU + 3 
25f8 : 60 __ __ RTS
25f9 : a2 8e __ LDX #$8e
25fb : a5 1c __ LDA ACCU + 1 
25fd : 30 06 __ BMI $2605 ; (uint16_to_float + 23)
25ff : ca __ __ DEX
2600 : 06 1b __ ASL ACCU + 0 
2602 : 2a __ __ ROL
2603 : 10 fa __ BPL $25ff ; (uint16_to_float + 17)
2605 : 29 7f __ AND #$7f
2607 : 85 1d __ STA ACCU + 2 
2609 : a5 1b __ LDA ACCU + 0 
260b : 85 1c __ STA ACCU + 1 
260d : 8a __ __ TXA
260e : 4a __ __ LSR
260f : 85 1e __ STA ACCU + 3 
2611 : a9 00 __ LDA #$00
2613 : 85 1b __ STA ACCU + 0 
2615 : 6a __ __ ROR
2616 : 05 1d __ ORA ACCU + 2 
2618 : 85 1d __ STA ACCU + 2 
261a : 60 __ __ RTS
--------------------------------------------------------------------
divmod32:
261b : 84 02 __ STY $02 
261d : a0 20 __ LDY #$20
261f : a9 00 __ LDA #$00
2621 : 85 07 __ STA WORK + 4 
2623 : 85 08 __ STA WORK + 5 
2625 : 85 09 __ STA WORK + 6 
2627 : 85 0a __ STA WORK + 7 
2629 : a5 05 __ LDA WORK + 2 
262b : 05 06 __ ORA WORK + 3 
262d : d0 39 __ BNE $2668 ; (divmod32 + 77)
262f : 18 __ __ CLC
2630 : 26 1b __ ROL ACCU + 0 
2632 : 26 1c __ ROL ACCU + 1 
2634 : 26 1d __ ROL ACCU + 2 
2636 : 26 1e __ ROL ACCU + 3 
2638 : 26 07 __ ROL WORK + 4 
263a : 26 08 __ ROL WORK + 5 
263c : 90 0c __ BCC $264a ; (divmod32 + 47)
263e : a5 07 __ LDA WORK + 4 
2640 : e5 03 __ SBC WORK + 0 
2642 : aa __ __ TAX
2643 : a5 08 __ LDA WORK + 5 
2645 : e5 04 __ SBC WORK + 1 
2647 : 38 __ __ SEC
2648 : b0 0c __ BCS $2656 ; (divmod32 + 59)
264a : 38 __ __ SEC
264b : a5 07 __ LDA WORK + 4 
264d : e5 03 __ SBC WORK + 0 
264f : aa __ __ TAX
2650 : a5 08 __ LDA WORK + 5 
2652 : e5 04 __ SBC WORK + 1 
2654 : 90 04 __ BCC $265a ; (divmod32 + 63)
2656 : 86 07 __ STX WORK + 4 
2658 : 85 08 __ STA WORK + 5 
265a : 88 __ __ DEY
265b : d0 d3 __ BNE $2630 ; (divmod32 + 21)
265d : 26 1b __ ROL ACCU + 0 
265f : 26 1c __ ROL ACCU + 1 
2661 : 26 1d __ ROL ACCU + 2 
2663 : 26 1e __ ROL ACCU + 3 
2665 : a4 02 __ LDY $02 
2667 : 60 __ __ RTS
2668 : 18 __ __ CLC
2669 : 26 1b __ ROL ACCU + 0 
266b : 26 1c __ ROL ACCU + 1 
266d : 26 1d __ ROL ACCU + 2 
266f : 26 1e __ ROL ACCU + 3 
2671 : 26 07 __ ROL WORK + 4 
2673 : 26 08 __ ROL WORK + 5 
2675 : 26 09 __ ROL WORK + 6 
2677 : 26 0a __ ROL WORK + 7 
2679 : a5 07 __ LDA WORK + 4 
267b : c5 03 __ CMP WORK + 0 
267d : a5 08 __ LDA WORK + 5 
267f : e5 04 __ SBC WORK + 1 
2681 : a5 09 __ LDA WORK + 6 
2683 : e5 05 __ SBC WORK + 2 
2685 : a5 0a __ LDA WORK + 7 
2687 : e5 06 __ SBC WORK + 3 
2689 : 90 18 __ BCC $26a3 ; (divmod32 + 136)
268b : a5 07 __ LDA WORK + 4 
268d : e5 03 __ SBC WORK + 0 
268f : 85 07 __ STA WORK + 4 
2691 : a5 08 __ LDA WORK + 5 
2693 : e5 04 __ SBC WORK + 1 
2695 : 85 08 __ STA WORK + 5 
2697 : a5 09 __ LDA WORK + 6 
2699 : e5 05 __ SBC WORK + 2 
269b : 85 09 __ STA WORK + 6 
269d : a5 0a __ LDA WORK + 7 
269f : e5 06 __ SBC WORK + 3 
26a1 : 85 0a __ STA WORK + 7 
26a3 : 88 __ __ DEY
26a4 : d0 c3 __ BNE $2669 ; (divmod32 + 78)
26a6 : 26 1b __ ROL ACCU + 0 
26a8 : 26 1c __ ROL ACCU + 1 
26aa : 26 1d __ ROL ACCU + 2 
26ac : 26 1e __ ROL ACCU + 3 
26ae : a4 02 __ LDY $02 
26b0 : 60 __ __ RTS
--------------------------------------------------------------------
__multab5L:
26b1 : __ __ __ BYT 00 05 0a 0f 14 19 1e 23 28 2d                   : .......#(-
--------------------------------------------------------------------
__multab3L:
08fd : __ __ __ BYT 00 03 06                                        : ...
--------------------------------------------------------------------
__multab2000L:
26bb : __ __ __ BYT 00 d0 a0 70 40 10 e0 b0                         : ...p@...
--------------------------------------------------------------------
__multab2000H:
26c3 : __ __ __ BYT 00 07 0f 17 1f 27 2e 36                         : .....'.6
