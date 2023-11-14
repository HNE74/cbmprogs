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
080e : 8e 8a 26 STX $268a ; (spentry + 0)
0811 : a9 1c __ LDA #$1c
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
0830 : a9 80 __ LDA #$80
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
268a : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
main:
.s0:
0880 : a9 00 __ LDA #$00
0882 : 8d 1c 27 STA $271c ; (game + 0)
0885 : 20 97 08 JSR $0897 ; (redefine_charset.s0 + 0)
.l3:
0888 : 20 b4 09 JSR $09b4 ; (main_loop.s0 + 0)
088b : ad 1c 27 LDA $271c ; (game + 0)
088e : f0 f8 __ BEQ $0888 ; (main.l3 + 0)
.s4:
0890 : a9 00 __ LDA #$00
0892 : 85 1b __ STA ACCU + 0 
0894 : 85 1c __ STA ACCU + 1 
.s1001:
0896 : 60 __ __ RTS
--------------------------------------------------------------------
game:
271c : __ __ __ BSS	6
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
08b7 : bd 8a 26 LDA $268a,x ; (spentry + 0)
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
268b : __ __ __ BYT 80 e0 f8 7f 7f f8 e0 80 00 00 60 3e 3e 60 00 00 : ..........`>>`..
269b : __ __ __ BYT 00 00 3c 66 66 3c 00 00 1c 7f c6 1f 1f c6 7f 1c : ..<ff<..........
26ab : __ __ __ BYT 00 3c 7e d5 ab 7e 3c 00 28 3c 6e df 5f fe 3c 14 : .<~..~<.(<n._.<.
26bb : __ __ __ BYT 28 56 65 92 69 36 44 2a                         : (Ve.i6D*
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
09c9 : ae 21 27 LDX $2721 ; (game + 5)
09cc : ce 21 27 DEC $2721 ; (game + 5)
09cf : 8a __ __ TXA
09d0 : f0 07 __ BEQ $09d9 ; (main_loop.s3 + 0)
.s4:
09d2 : a9 01 __ LDA #$01
09d4 : 8d 1c 27 STA $271c ; (game + 0)
09d7 : d0 e1 __ BNE $09ba ; (main_loop.l1 + 0)
.s3:
09d9 : 8d 1c 27 STA $271c ; (game + 0)
.s1001:
09dc : 60 __ __ RTS
--------------------------------------------------------------------
init_game_state:
.s0:
09dd : a9 01 __ LDA #$01
09df : 8d 1c 27 STA $271c ; (game + 0)
09e2 : a9 00 __ LDA #$00
09e4 : 8d 1d 27 STA $271d ; (game + 1)
09e7 : 8d 1e 27 STA $271e ; (game + 2)
09ea : 8d 1f 27 STA $271f ; (game + 3)
09ed : 8d 20 27 STA $2720 ; (game + 4)
09f0 : a9 03 __ LDA #$03
09f2 : 8d 21 27 STA $2721 ; (game + 5)
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
0a0c : a9 22 __ LDA #$22
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
0a41 : b9 c3 26 LDA $26c3,y ; (mul40 + 0)
0a44 : 85 1b __ STA ACCU + 0 
0a46 : 18 __ __ CLC
0a47 : 65 11 __ ADC P4 ; (sx + 0)
0a49 : aa __ __ TAX
0a4a : b9 c4 26 LDA $26c4,y ; (mul40 + 1)
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
26c3 : __ __ __ BYT 00 00 28 00 50 00 78 00 a0 00 c8 00 f0 00 18 01 : ..(.P.x.........
26d3 : __ __ __ BYT 40 01 68 01 90 01 b8 01 e0 01 08 02 30 02 58 02 : @.h.........0.X.
26e3 : __ __ __ BYT 80 02 a8 02 d0 02 f8 02 20 03 48 03 70 03 98 03 : ........ .H.p...
26f3 : __ __ __ BYT c0 03                                           : ..
--------------------------------------------------------------------
cwTop:
2722 : __ __ __ BSS	10
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
0acb : 8d 2c 27 STA $272c ; (Player + 0)
0ace : a9 0c __ LDA #$0c
0ad0 : 8d 2d 27 STA $272d ; (Player + 1)
0ad3 : a9 00 __ LDA #$00
0ad5 : 8d 31 27 STA $2731 ; (PlayerShotSound + 3)
.s1001:
0ad8 : 60 __ __ RTS
--------------------------------------------------------------------
Player:
272c : __ __ __ BSS	2
--------------------------------------------------------------------
PlayerShotSound:
272e : __ __ __ BSS	4
--------------------------------------------------------------------
init_enemies:
.s0:
0ad9 : a2 00 __ LDX #$00
0adb : a0 0a __ LDY #$0a
.l1002:
0add : a9 00 __ LDA #$00
0adf : 9d 32 27 STA $2732,x ; (Enemy + 0)
0ae2 : 9d 33 27 STA $2733,x ; (Enemy + 1)
0ae5 : 9d 36 27 STA $2736,x ; (Enemy + 4)
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
2732 : __ __ __ BSS	50
--------------------------------------------------------------------
init_shots:
.s0:
0af1 : a2 00 __ LDX #$00
0af3 : a0 03 __ LDY #$03
0af5 : 8a __ __ TXA
.l1006:
0af6 : 9d 64 27 STA $2764,x ; (PlayerShot + 0)
0af9 : 9d 65 27 STA $2765,x ; (PlayerShot + 1)
0afc : 9d 66 27 STA $2766,x ; (PlayerShot + 2)
0aff : e8 __ __ INX
0b00 : e8 __ __ INX
0b01 : e8 __ __ INX
0b02 : 88 __ __ DEY
0b03 : d0 f1 __ BNE $0af6 ; (init_shots.l1006 + 0)
.s6:
0b05 : a0 03 __ LDY #$03
0b07 : aa __ __ TAX
.l1008:
0b08 : 9d 6d 27 STA $276d,x ; (EnemyShot + 0)
0b0b : 9d 6e 27 STA $276e,x ; (EnemyShot + 1)
0b0e : 9d 6f 27 STA $276f,x ; (EnemyShot + 2)
0b11 : e8 __ __ INX
0b12 : e8 __ __ INX
0b13 : e8 __ __ INX
0b14 : 88 __ __ DEY
0b15 : d0 f1 __ BNE $0b08 ; (init_shots.l1008 + 0)
.s1001:
0b17 : 60 __ __ RTS
--------------------------------------------------------------------
PlayerShot:
2764 : __ __ __ BSS	9
--------------------------------------------------------------------
EnemyShot:
276d : __ __ __ BSS	9
--------------------------------------------------------------------
run_game:
.s1000:
0b18 : a5 53 __ LDA T0 + 0 
0b1a : 8d cd 9f STA $9fcd ; (run_game@stack + 0)
.s0:
0b1d : a9 ff __ LDA #$ff
0b1f : 8d 18 d4 STA $d418 
0b22 : ad 1c 27 LDA $271c ; (game + 0)
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
0b41 : 20 9f 24 JSR $249f ; (divmod + 0)
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
0b5f : 20 74 1f JSR $1f74 ; (control_player_ship.s0 + 0)
0b62 : 20 9e 20 JSR $209e ; (render_player_ship.s0 + 0)
0b65 : 20 89 1e JSR $1e89 ; (check_player_enemy_collision.s0 + 0)
0b68 : 20 de 20 JSR $20de ; (move_player_shots.s0 + 0)
0b6b : 20 46 21 JSR $2146 ; (render_player_shots.s0 + 0)
0b6e : 20 d4 1c JSR $1cd4 ; (check_shot_enemy_collision.s0 + 0)
0b71 : a9 03 __ LDA #$03
0b73 : 85 0d __ STA P0 
0b75 : a9 00 __ LDA #$00
0b77 : 85 0e __ STA P1 
0b79 : 20 9b 21 JSR $219b ; (wait_frames.s0 + 0)
0b7c : e6 53 __ INC T0 + 0 
0b7e : ad 1c 27 LDA $271c ; (game + 0)
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
0ba2 : a9 22 __ LDA #$22
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
0bca : ad 1d 27 LDA $271d ; (game + 1)
0bcd : c8 __ __ INY
0bce : 91 23 __ STA (SP + 0),y 
0bd0 : ad 1e 27 LDA $271e ; (game + 2)
0bd3 : c8 __ __ INY
0bd4 : 91 23 __ STA (SP + 0),y 
0bd6 : ad 1f 27 LDA $271f ; (game + 3)
0bd9 : c8 __ __ INY
0bda : 91 23 __ STA (SP + 0),y 
0bdc : ad 20 27 LDA $2720 ; (game + 4)
0bdf : c8 __ __ INY
0be0 : 91 23 __ STA (SP + 0),y 
0be2 : 20 b7 0c JSR $0cb7 ; (sprintf.s1000 + 0)
0be5 : a9 22 __ LDA #$22
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
0c2c : ad 21 27 LDA $2721 ; (game + 5)
0c2f : c8 __ __ INY
0c30 : 91 23 __ STA (SP + 0),y 
0c32 : a9 00 __ LDA #$00
0c34 : c8 __ __ INY
0c35 : 91 23 __ STA (SP + 0),y 
0c37 : 20 b7 0c JSR $0cb7 ; (sprintf.s1000 + 0)
0c3a : a9 22 __ LDA #$22
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
0c69 : bd c3 26 LDA $26c3,x ; (mul40 + 0)
0c6c : 18 __ __ CLC
0c6d : 65 0f __ ADC P2 ; (x + 0)
0c6f : 85 1b __ STA ACCU + 0 
0c71 : bd c4 26 LDA $26c4,x ; (mul40 + 1)
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
0ca5 : bd f5 26 LDA $26f5,x ; (p2smap + 0)
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
26f5 : __ __ __ BYT 00 00 40 20 80 c0 80 80                         : ..@ ....
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
1164 : ae fd 26 LDX $26fd ; (giocharmap + 0)
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
26fd : __ __ __ BYT 01                                              : .
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
11ed : 20 9f 24 JSR $249f ; (divmod + 0)
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
1220 : 20 9f 24 JSR $249f ; (divmod + 0)
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
1445 : 20 da 25 JSR $25da ; (divmod32 + 0)
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
1486 : 20 da 25 JSR $25da ; (divmod32 + 0)
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
158c : 20 d0 21 JSR $21d0 ; (freg + 20)
158f : 20 b7 23 JSR $23b7 ; (fdiv + 0)
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
15b4 : ad 19 27 LDA $2719 ; (fround5 + 25)
15b7 : 85 1c __ STA ACCU + 1 
15b9 : ad 1a 27 LDA $271a ; (fround5 + 26)
15bc : 85 1d __ STA ACCU + 2 
15be : ad 1b 27 LDA $271b ; (fround5 + 27)
15c1 : ae 18 27 LDX $2718 ; (fround5 + 24)
15c4 : 4c da 15 JMP $15da ; (nformf.s214 + 0)
.s35:
15c7 : 0a __ __ ASL
15c8 : 0a __ __ ASL
15c9 : a8 __ __ TAY
15ca : b9 fd 26 LDA $26fd,y ; (giocharmap + 0)
15cd : 85 1c __ STA ACCU + 1 
15cf : b9 fe 26 LDA $26fe,y ; (seed + 0)
15d2 : 85 1d __ STA ACCU + 2 
15d4 : b9 ff 26 LDA $26ff,y ; (seed + 1)
15d7 : be fc 26 LDX $26fc,y ; (p2smap + 7)
.s214:
15da : 86 1b __ STX ACCU + 0 
15dc : 85 1e __ STA ACCU + 3 
15de : a2 43 __ LDX #$43
15e0 : 20 c0 21 JSR $21c0 ; (freg + 4)
15e3 : 20 01 22 JSR $2201 ; (faddsub + 0)
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
1610 : 20 d0 21 JSR $21d0 ; (freg + 20)
1613 : 20 b7 23 JSR $23b7 ; (fdiv + 0)
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
1676 : 20 4d 25 JSR $254d ; (f32_to_i16 + 0)
1679 : a5 1b __ LDA ACCU + 0 
167b : 85 4f __ STA T11 + 0 
167d : 20 8f 25 JSR $258f ; (sint16_to_float + 0)
1680 : a2 43 __ LDX #$43
1682 : 20 c0 21 JSR $21c0 ; (freg + 4)
1685 : a5 1e __ LDA ACCU + 3 
1687 : 49 80 __ EOR #$80
1689 : 85 1e __ STA ACCU + 3 
168b : 20 01 22 JSR $2201 ; (faddsub + 0)
168e : a9 00 __ LDA #$00
1690 : 85 03 __ STA WORK + 0 
1692 : 85 04 __ STA WORK + 1 
1694 : a9 20 __ LDA #$20
1696 : 85 05 __ STA WORK + 2 
1698 : a9 41 __ LDA #$41
169a : 85 06 __ STA WORK + 3 
169c : 20 d0 21 JSR $21d0 ; (freg + 20)
169f : 20 e8 22 JSR $22e8 ; (fmul + 0)
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
1700 : 20 65 24 JSR $2465 ; (divs16 + 0)
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
171e : 20 24 25 JSR $2524 ; (mods16 + 0)
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
17ba : ad 19 27 LDA $2719 ; (fround5 + 25)
17bd : 85 1c __ STA ACCU + 1 
17bf : ad 1a 27 LDA $271a ; (fround5 + 26)
17c2 : 85 1d __ STA ACCU + 2 
17c4 : ad 1b 27 LDA $271b ; (fround5 + 27)
17c7 : ae 18 27 LDX $2718 ; (fround5 + 24)
17ca : 4c e0 17 JMP $17e0 ; (nformf.s204 + 0)
.s41:
17cd : 0a __ __ ASL
17ce : 0a __ __ ASL
17cf : a8 __ __ TAY
17d0 : b9 fd 26 LDA $26fd,y ; (giocharmap + 0)
17d3 : 85 1c __ STA ACCU + 1 
17d5 : b9 fe 26 LDA $26fe,y ; (seed + 0)
17d8 : 85 1d __ STA ACCU + 2 
17da : b9 ff 26 LDA $26ff,y ; (seed + 1)
17dd : be fc 26 LDX $26fc,y ; (p2smap + 7)
.s204:
17e0 : 86 1b __ STX ACCU + 0 
17e2 : 85 1e __ STA ACCU + 3 
17e4 : a2 43 __ LDX #$43
17e6 : 20 c0 21 JSR $21c0 ; (freg + 4)
17e9 : 20 01 22 JSR $2201 ; (faddsub + 0)
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
181c : 20 d0 21 JSR $21d0 ; (freg + 20)
181f : 20 b7 23 JSR $23b7 ; (fdiv + 0)
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
1876 : 20 d0 21 JSR $21d0 ; (freg + 20)
1879 : 20 b7 23 JSR $23b7 ; (fdiv + 0)
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
18a9 : 20 c0 21 JSR $21c0 ; (freg + 4)
18ac : 20 e8 22 JSR $22e8 ; (fmul + 0)
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
190c : 20 d0 21 JSR $21d0 ; (freg + 20)
190f : 20 b7 23 JSR $23b7 ; (fdiv + 0)
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
2700 : __ __ __ BYT 00 00 00 3f cd cc 4c 3d 0a d7 a3 3b 6f 12 03 3a : ...?..L=...;o..:
2710 : __ __ __ BYT 17 b7 51 38 ac c5 a7 36 bd 37 06 35             : ..Q8...6.7.5
--------------------------------------------------------------------
08fa : __ __ __ BYT 25 64 00                                        : %d.
--------------------------------------------------------------------
197e : __ __ __ BYT 53 48 49 50 53 3a 00                            : SHIPS:.
--------------------------------------------------------------------
play_sound_effects:
.s0:
1985 : ad 31 27 LDA $2731 ; (PlayerShotSound + 3)
1988 : c9 01 __ CMP #$01
198a : d0 2c __ BNE $19b8 ; (play_sound_effects.s2 + 0)
.s1:
198c : a9 20 __ LDA #$20
198e : 8d 2e 27 STA $272e ; (PlayerShotSound + 0)
1991 : a9 4e __ LDA #$4e
1993 : 8d 2f 27 STA $272f ; (PlayerShotSound + 1)
1996 : a9 00 __ LDA #$00
1998 : 8d 30 27 STA $2730 ; (PlayerShotSound + 2)
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
19b6 : d0 35 __ BNE $19ed ; (play_sound_effects.s1014 + 0)
.s2:
19b8 : c9 02 __ CMP #$02
19ba : d0 26 __ BNE $19e2 ; (play_sound_effects.s5 + 0)
.s4:
19bc : ad 2e 27 LDA $272e ; (PlayerShotSound + 0)
19bf : 38 __ __ SEC
19c0 : e9 f4 __ SBC #$f4
19c2 : 8d 2e 27 STA $272e ; (PlayerShotSound + 0)
19c5 : ad 2f 27 LDA $272f ; (PlayerShotSound + 1)
19c8 : e9 01 __ SBC #$01
19ca : 8d 2f 27 STA $272f ; (PlayerShotSound + 1)
19cd : ad 2e 27 LDA $272e ; (PlayerShotSound + 0)
19d0 : 8d 00 d4 STA $d400 
19d3 : ad 2f 27 LDA $272f ; (PlayerShotSound + 1)
19d6 : 8d 01 d4 STA $d401 
19d9 : a9 14 __ LDA #$14
19db : 8d 30 27 STA $2730 ; (PlayerShotSound + 2)
19de : a9 03 __ LDA #$03
19e0 : d0 0b __ BNE $19ed ; (play_sound_effects.s1014 + 0)
.s5:
19e2 : c9 03 __ CMP #$03
19e4 : d0 0a __ BNE $19f0 ; (play_sound_effects.s26 + 0)
.s10:
19e6 : a9 08 __ LDA #$08
19e8 : 8d 04 d4 STA $d404 
19eb : a9 00 __ LDA #$00
.s1014:
19ed : 8d 31 27 STA $2731 ; (PlayerShotSound + 3)
.s26:
19f0 : ad 79 27 LDA $2779 ; (EnemyShotSound + 3)
19f3 : c9 01 __ CMP #$01
19f5 : d0 2e __ BNE $1a25 ; (play_sound_effects.s14 + 0)
.s13:
19f7 : a9 20 __ LDA #$20
19f9 : 8d 76 27 STA $2776 ; (EnemyShotSound + 0)
19fc : a9 4e __ LDA #$4e
19fe : 8d 77 27 STA $2777 ; (EnemyShotSound + 1)
1a01 : a9 00 __ LDA #$00
1a03 : 8d 78 27 STA $2778 ; (EnemyShotSound + 2)
1a06 : ad 2e 27 LDA $272e ; (PlayerShotSound + 0)
1a09 : 8d 07 d4 STA $d407 
1a0c : ad 2f 27 LDA $272f ; (PlayerShotSound + 1)
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
1a29 : ad 76 27 LDA $2776 ; (EnemyShotSound + 0)
1a2c : 18 __ __ CLC
1a2d : 69 f4 __ ADC #$f4
1a2f : 8d 76 27 STA $2776 ; (EnemyShotSound + 0)
1a32 : ad 77 27 LDA $2777 ; (EnemyShotSound + 1)
1a35 : 69 01 __ ADC #$01
1a37 : 8d 77 27 STA $2777 ; (EnemyShotSound + 1)
1a3a : ad 76 27 LDA $2776 ; (EnemyShotSound + 0)
1a3d : 8d 07 d4 STA $d407 
1a40 : ad 77 27 LDA $2777 ; (EnemyShotSound + 1)
1a43 : 8d 08 d4 STA $d408 
1a46 : a9 14 __ LDA #$14
1a48 : 8d 78 27 STA $2778 ; (EnemyShotSound + 2)
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
1a5a : 8d 79 27 STA $2779 ; (EnemyShotSound + 3)
.s1001:
1a5d : 60 __ __ RTS
--------------------------------------------------------------------
EnemyShotSound:
2776 : __ __ __ BSS	4
--------------------------------------------------------------------
spawn_enemy:
.s0:
1a5e : 20 ce 1a JSR $1ace ; (rand.s0 + 0)
1a61 : 46 1b __ LSR ACCU + 0 
1a63 : b0 0f __ BCS $1a74 ; (spawn_enemy.s1001 + 0)
.s3:
1a65 : a0 00 __ LDY #$00
.l6:
1a67 : be 70 26 LDX $2670,y ; (__multab5L + 0)
1a6a : bd 36 27 LDA $2736,x ; (Enemy + 4)
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
1a79 : 9d 32 27 STA $2732,x ; (Enemy + 0)
1a7c : 20 ce 1a JSR $1ace ; (rand.s0 + 0)
1a7f : a9 14 __ LDA #$14
1a81 : 85 03 __ STA WORK + 0 
1a83 : a9 00 __ LDA #$00
1a85 : 85 04 __ STA WORK + 1 
1a87 : 20 9f 24 JSR $249f ; (divmod + 0)
1a8a : 18 __ __ CLC
1a8b : a5 05 __ LDA WORK + 2 
1a8d : 69 04 __ ADC #$04
1a8f : a6 43 __ LDX T0 + 0 
1a91 : 9d 33 27 STA $2733,x ; (Enemy + 1)
1a94 : 20 ce 1a JSR $1ace ; (rand.s0 + 0)
1a97 : a9 0e __ LDA #$0e
1a99 : a6 43 __ LDX T0 + 0 
1a9b : 9d 35 27 STA $2735,x ; (Enemy + 3)
1a9e : a9 01 __ LDA #$01
1aa0 : 9d 36 27 STA $2736,x ; (Enemy + 4)
1aa3 : a9 03 __ LDA #$03
1aa5 : 85 03 __ STA WORK + 0 
1aa7 : a9 00 __ LDA #$00
1aa9 : 85 04 __ STA WORK + 1 
1aab : 20 9f 24 JSR $249f ; (divmod + 0)
1aae : 18 __ __ CLC
1aaf : a5 05 __ LDA WORK + 2 
1ab1 : 69 83 __ ADC #$83
1ab3 : a4 43 __ LDY T0 + 0 
1ab5 : 99 34 27 STA $2734,y ; (Enemy + 2)
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
1aca : 99 35 27 STA $2735,y ; (Enemy + 3)
1acd : 60 __ __ RTS
--------------------------------------------------------------------
rand:
.s0:
1ace : ad ff 26 LDA $26ff ; (seed + 1)
1ad1 : 4a __ __ LSR
1ad2 : ad fe 26 LDA $26fe ; (seed + 0)
1ad5 : 6a __ __ ROR
1ad6 : aa __ __ TAX
1ad7 : a9 00 __ LDA #$00
1ad9 : 6a __ __ ROR
1ada : 4d fe 26 EOR $26fe ; (seed + 0)
1add : 85 1b __ STA ACCU + 0 
1adf : 8a __ __ TXA
1ae0 : 4d ff 26 EOR $26ff ; (seed + 1)
1ae3 : 85 1c __ STA ACCU + 1 
1ae5 : 4a __ __ LSR
1ae6 : 45 1b __ EOR ACCU + 0 
1ae8 : 8d fe 26 STA $26fe ; (seed + 0)
1aeb : 85 1b __ STA ACCU + 0 
1aed : 45 1c __ EOR ACCU + 1 
1aef : 8d ff 26 STA $26ff ; (seed + 1)
1af2 : 85 1c __ STA ACCU + 1 
.s1001:
1af4 : 60 __ __ RTS
--------------------------------------------------------------------
seed:
26fe : __ __ __ BYT 00 7a                                           : .z
--------------------------------------------------------------------
move_enemies:
.s0:
1af5 : a2 00 __ LDX #$00
.l2:
1af7 : 86 43 __ STX T0 + 0 
1af9 : bc 70 26 LDY $2670,x ; (__multab5L + 0)
1afc : b9 36 27 LDA $2736,y ; (Enemy + 4)
1aff : c9 01 __ CMP #$01
1b01 : d0 75 __ BNE $1b78 ; (move_enemies.s41 + 0)
.s5:
1b03 : 18 __ __ CLC
1b04 : a9 32 __ LDA #$32
1b06 : 7d 70 26 ADC $2670,x ; (__multab5L + 0)
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
1b1c : cd 2d 27 CMP $272d ; (Player + 1)
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
1ba2 : 20 9f 24 JSR $249f ; (divmod + 0)
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
1bf0 : b9 6f 27 LDA $276f,y ; (EnemyShot + 2)
1bf3 : f0 06 __ BEQ $1bfb ; (spawn_enemy_shot.s9 + 0)
.s7:
1bf5 : e8 __ __ INX
1bf6 : e0 03 __ CPX #$03
1bf8 : 90 f3 __ BCC $1bed ; (spawn_enemy_shot.l6 + 0)
.s1001:
1bfa : 60 __ __ RTS
.s9:
1bfb : a9 01 __ LDA #$01
1bfd : 99 6f 27 STA $276f,y ; (EnemyShot + 2)
1c00 : a0 00 __ LDY #$00
1c02 : b1 0d __ LDA (P0),y ; (e + 0)
1c04 : 38 __ __ SEC
1c05 : e9 01 __ SBC #$01
1c07 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1c0a : 99 6d 27 STA $276d,y ; (EnemyShot + 0)
1c0d : a0 01 __ LDY #$01
1c0f : b1 0d __ LDA (P0),y ; (e + 0)
1c11 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1c14 : 99 6e 27 STA $276e,y ; (EnemyShot + 1)
1c17 : ad 79 27 LDA $2779 ; (EnemyShotSound + 3)
1c1a : d0 de __ BNE $1bfa ; (spawn_enemy_shot.s1001 + 0)
.s12:
1c1c : a9 01 __ LDA #$01
1c1e : 8d 79 27 STA $2779 ; (EnemyShotSound + 3)
1c21 : 60 __ __ RTS
--------------------------------------------------------------------
render_enemy_shots:
.s0:
1c22 : a2 00 __ LDX #$00
.l1006:
1c24 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1c27 : b9 6f 27 LDA $276f,y ; (EnemyShot + 2)
1c2a : c9 01 __ CMP #$01
1c2c : d0 43 __ BNE $1c71 ; (render_enemy_shots.s19 + 0)
.s5:
1c2e : b9 6e 27 LDA $276e,y ; (EnemyShot + 1)
1c31 : 0a __ __ ASL
1c32 : 85 1b __ STA ACCU + 0 
1c34 : a9 00 __ LDA #$00
1c36 : 2a __ __ ROL
1c37 : 06 1b __ ASL ACCU + 0 
1c39 : 2a __ __ ROL
1c3a : 85 1c __ STA ACCU + 1 
1c3c : a5 1b __ LDA ACCU + 0 
1c3e : 79 6e 27 ADC $276e,y ; (EnemyShot + 1)
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
1c55 : 79 6d 27 ADC $276d,y ; (EnemyShot + 0)
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
1c79 : bc 70 26 LDY $2670,x ; (__multab5L + 0)
1c7c : b9 36 27 LDA $2736,y ; (Enemy + 4)
1c7f : c9 01 __ CMP #$01
1c81 : d0 4b __ BNE $1cce ; (render_enemies.s19 + 0)
.s5:
1c83 : 84 1d __ STY ACCU + 2 
1c85 : b9 33 27 LDA $2733,y ; (Enemy + 1)
1c88 : 0a __ __ ASL
1c89 : 85 1b __ STA ACCU + 0 
1c8b : a9 00 __ LDA #$00
1c8d : 2a __ __ ROL
1c8e : 06 1b __ ASL ACCU + 0 
1c90 : 2a __ __ ROL
1c91 : 85 1c __ STA ACCU + 1 
1c93 : a5 1b __ LDA ACCU + 0 
1c95 : 79 33 27 ADC $2733,y ; (Enemy + 1)
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
1cac : 79 32 27 ADC $2732,y ; (Enemy + 0)
1caf : 85 43 __ STA T2 + 0 
1cb1 : 85 1b __ STA ACCU + 0 
1cb3 : a5 1c __ LDA ACCU + 1 
1cb5 : 69 c0 __ ADC #$c0
1cb7 : 85 44 __ STA T2 + 1 
1cb9 : 18 __ __ CLC
1cba : 69 18 __ ADC #$18
1cbc : 85 1c __ STA ACCU + 1 
1cbe : b9 34 27 LDA $2734,y ; (Enemy + 2)
1cc1 : a0 00 __ LDY #$00
1cc3 : 91 43 __ STA (T2 + 0),y 
1cc5 : a4 1d __ LDY ACCU + 2 
1cc7 : b9 35 27 LDA $2735,y ; (Enemy + 3)
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
1cdb : b9 66 27 LDA $2766,y ; (PlayerShot + 2)
1cde : c9 01 __ CMP #$01
1ce0 : d0 2e __ BNE $1d10 ; (check_shot_enemy_collision.s3 + 0)
.s5:
1ce2 : a2 00 __ LDX #$00
.l9:
1ce4 : 86 43 __ STX T2 + 0 
1ce6 : bc 70 26 LDY $2670,x ; (__multab5L + 0)
1ce9 : 84 1e __ STY ACCU + 3 
1ceb : b9 36 27 LDA $2736,y ; (Enemy + 4)
1cee : c9 01 __ CMP #$01
1cf0 : d0 17 __ BNE $1d09 ; (check_shot_enemy_collision.s114 + 0)
.s12:
1cf2 : b9 32 27 LDA $2732,y ; (Enemy + 0)
1cf5 : a6 1d __ LDX ACCU + 2 
1cf7 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1cfa : d9 64 27 CMP $2764,y ; (PlayerShot + 0)
1cfd : d0 0a __ BNE $1d09 ; (check_shot_enemy_collision.s114 + 0)
.s18:
1cff : b9 65 27 LDA $2765,y ; (PlayerShot + 1)
1d02 : a6 1e __ LDX ACCU + 3 
1d04 : dd 33 27 CMP $2733,x ; (Enemy + 1)
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
1d23 : b9 33 27 LDA $2733,y ; (Enemy + 1)
1d26 : 0a __ __ ASL
1d27 : 85 1b __ STA ACCU + 0 
1d29 : a9 00 __ LDA #$00
1d2b : 2a __ __ ROL
1d2c : 06 1b __ ASL ACCU + 0 
1d2e : 2a __ __ ROL
1d2f : aa __ __ TAX
1d30 : a5 1b __ LDA ACCU + 0 
1d32 : 79 33 27 ADC $2733,y ; (Enemy + 1)
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
1d47 : 79 32 27 ADC $2732,y ; (Enemy + 0)
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
1d65 : bd 7a 26 LDA $267a,x ; (__multab2000L + 0)
1d68 : 8d 00 d4 STA $d400 
1d6b : bd 82 26 LDA $2682,x ; (__multab2000H + 0)
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
1d99 : bd 33 27 LDA $2733,x ; (Enemy + 1)
1d9c : 0a __ __ ASL
1d9d : 85 1b __ STA ACCU + 0 
1d9f : a9 00 __ LDA #$00
1da1 : 2a __ __ ROL
1da2 : 06 1b __ ASL ACCU + 0 
1da4 : 2a __ __ ROL
1da5 : a8 __ __ TAY
1da6 : a5 1b __ LDA ACCU + 0 
1da8 : 7d 33 27 ADC $2733,x ; (Enemy + 1)
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
1dbd : 7d 32 27 ADC $2732,x ; (Enemy + 0)
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
1dd7 : 9d 36 27 STA $2736,x ; (Enemy + 4)
1dda : a6 1d __ LDX ACCU + 2 
1ddc : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1ddf : 99 66 27 STA $2766,y ; (PlayerShot + 2)
1de2 : a6 1e __ LDX ACCU + 3 
1de4 : bd 34 27 LDA $2734,x ; (Enemy + 2)
1de7 : c9 83 __ CMP #$83
1de9 : f0 2b __ BEQ $1e16 ; (check_shot_enemy_collision.s30 + 0)
.s31:
1deb : c9 84 __ CMP #$84
1ded : f0 03 __ BEQ $1df2 ; (check_shot_enemy_collision.s33 + 0)
1def : 4c 09 1d JMP $1d09 ; (check_shot_enemy_collision.s114 + 0)
.s33:
1df2 : ad 1d 27 LDA $271d ; (game + 1)
1df5 : 18 __ __ CLC
1df6 : 69 19 __ ADC #$19
.s118:
1df8 : 8d 1d 27 STA $271d ; (game + 1)
1dfb : ad 1e 27 LDA $271e ; (game + 2)
1dfe : 69 00 __ ADC #$00
1e00 : 8d 1e 27 STA $271e ; (game + 2)
1e03 : ad 1f 27 LDA $271f ; (game + 3)
1e06 : 69 00 __ ADC #$00
1e08 : 8d 1f 27 STA $271f ; (game + 3)
1e0b : b0 03 __ BCS $1e10 ; (check_shot_enemy_collision.s1019 + 0)
1e0d : 4c 09 1d JMP $1d09 ; (check_shot_enemy_collision.s114 + 0)
.s1019:
1e10 : ee 20 27 INC $2720 ; (game + 4)
1e13 : 4c 09 1d JMP $1d09 ; (check_shot_enemy_collision.s114 + 0)
.s30:
1e16 : ad 1d 27 LDA $271d ; (game + 1)
1e19 : 18 __ __ CLC
1e1a : 69 32 __ ADC #$32
1e1c : 4c f8 1d JMP $1df8 ; (check_shot_enemy_collision.s118 + 0)
--------------------------------------------------------------------
move_enemy_shots:
.s0:
1e1f : a2 00 __ LDX #$00
.l1008:
1e21 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
1e24 : b9 6f 27 LDA $276f,y ; (EnemyShot + 2)
1e27 : c9 01 __ CMP #$01
1e29 : d0 58 __ BNE $1e83 ; (move_enemy_shots.s23 + 0)
.s5:
1e2b : 84 1d __ STY ACCU + 2 
1e2d : b9 6e 27 LDA $276e,y ; (EnemyShot + 1)
1e30 : 0a __ __ ASL
1e31 : 85 1b __ STA ACCU + 0 
1e33 : a9 00 __ LDA #$00
1e35 : 2a __ __ ROL
1e36 : 06 1b __ ASL ACCU + 0 
1e38 : 2a __ __ ROL
1e39 : 85 1c __ STA ACCU + 1 
1e3b : a5 1b __ LDA ACCU + 0 
1e3d : 79 6e 27 ADC $276e,y ; (EnemyShot + 1)
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
1e51 : b9 6d 27 LDA $276d,y ; (EnemyShot + 0)
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
1e77 : 99 6d 27 STA $276d,y ; (EnemyShot + 0)
1e7a : c9 ff __ CMP #$ff
1e7c : d0 05 __ BNE $1e83 ; (move_enemy_shots.s23 + 0)
.s8:
1e7e : a9 00 __ LDA #$00
1e80 : 99 6f 27 STA $276f,y ; (EnemyShot + 2)
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
1e8b : be 70 26 LDX $2670,y ; (__multab5L + 0)
1e8e : bd 36 27 LDA $2736,x ; (Enemy + 4)
1e91 : c9 01 __ CMP #$01
1e93 : d0 10 __ BNE $1ea5 ; (check_player_enemy_collision.s3 + 0)
.s5:
1e95 : bd 32 27 LDA $2732,x ; (Enemy + 0)
1e98 : cd 2c 27 CMP $272c ; (Player + 0)
1e9b : d0 08 __ BNE $1ea5 ; (check_player_enemy_collision.s3 + 0)
.s11:
1e9d : bd 33 27 LDA $2733,x ; (Enemy + 1)
1ea0 : cd 2d 27 CMP $272d ; (Player + 1)
1ea3 : f0 30 __ BEQ $1ed5 ; (check_player_enemy_collision.s8 + 0)
.s3:
1ea5 : c8 __ __ INY
1ea6 : c0 0a __ CPY #$0a
1ea8 : 90 e1 __ BCC $1e8b ; (check_player_enemy_collision.l2 + 0)
.s4:
1eaa : a0 00 __ LDY #$00
.l13:
1eac : be fd 08 LDX $08fd,y ; (__multab3L + 0)
1eaf : bd 6f 27 LDA $276f,x ; (EnemyShot + 2)
1eb2 : c9 01 __ CMP #$01
1eb4 : d0 10 __ BNE $1ec6 ; (check_player_enemy_collision.s14 + 0)
.s16:
1eb6 : bd 6d 27 LDA $276d,x ; (EnemyShot + 0)
1eb9 : cd 2c 27 CMP $272c ; (Player + 0)
1ebc : d0 08 __ BNE $1ec6 ; (check_player_enemy_collision.s14 + 0)
.s22:
1ebe : bd 6e 27 LDA $276e,x ; (EnemyShot + 1)
1ec1 : cd 2d 27 CMP $272d ; (Player + 1)
1ec4 : f0 06 __ BEQ $1ecc ; (check_player_enemy_collision.s19 + 0)
.s14:
1ec6 : c8 __ __ INY
1ec7 : c0 03 __ CPY #$03
1ec9 : 90 e1 __ BCC $1eac ; (check_player_enemy_collision.l13 + 0)
.s1001:
1ecb : 60 __ __ RTS
.s19:
1ecc : 20 df 1e JSR $1edf ; (render_player_dead.s0 + 0)
1ecf : a9 02 __ LDA #$02
1ed1 : 8d 1c 27 STA $271c ; (game + 0)
1ed4 : 60 __ __ RTS
.s8:
1ed5 : 20 df 1e JSR $1edf ; (render_player_dead.s0 + 0)
1ed8 : a9 02 __ LDA #$02
1eda : 8d 1c 27 STA $271c ; (game + 0)
1edd : d0 cb __ BNE $1eaa ; (check_player_enemy_collision.s4 + 0)
--------------------------------------------------------------------
render_player_dead:
.s0:
1edf : ad 2d 27 LDA $272d ; (Player + 1)
1ee2 : 85 1e __ STA ACCU + 3 
1ee4 : ad 2c 27 LDA $272c ; (Player + 0)
1ee7 : 85 43 __ STA T2 + 0 
1ee9 : a9 00 __ LDA #$00
1eeb : 85 1d __ STA ACCU + 2 
.l2:
1eed : a9 ff __ LDA #$ff
1eef : 85 44 __ STA T3 + 0 
.l6:
1ef1 : 29 80 __ AND #$80
1ef3 : 10 02 __ BPL $1ef7 ; (render_player_dead.l6 + 6)
1ef5 : a9 ff __ LDA #$ff
1ef7 : aa __ __ TAX
1ef8 : 18 __ __ CLC
1ef9 : a5 44 __ LDA T3 + 0 
1efb : 65 1e __ ADC ACCU + 3 
1efd : a8 __ __ TAY
1efe : 90 01 __ BCC $1f01 ; (render_player_dead.s1009 + 0)
.s1008:
1f00 : e8 __ __ INX
.s1009:
1f01 : 86 1c __ STX ACCU + 1 
1f03 : 0a __ __ ASL
1f04 : 85 1b __ STA ACCU + 0 
1f06 : 8a __ __ TXA
1f07 : 2a __ __ ROL
1f08 : 06 1b __ ASL ACCU + 0 
1f0a : 2a __ __ ROL
1f0b : aa __ __ TAX
1f0c : 98 __ __ TYA
1f0d : 18 __ __ CLC
1f0e : 65 1b __ ADC ACCU + 0 
1f10 : 85 1b __ STA ACCU + 0 
1f12 : 8a __ __ TXA
1f13 : 65 1c __ ADC ACCU + 1 
1f15 : 06 1b __ ASL ACCU + 0 
1f17 : 2a __ __ ROL
1f18 : 06 1b __ ASL ACCU + 0 
1f1a : 2a __ __ ROL
1f1b : 06 1b __ ASL ACCU + 0 
1f1d : 2a __ __ ROL
1f1e : aa __ __ TAX
1f1f : 18 __ __ CLC
1f20 : a9 ff __ LDA #$ff
1f22 : 65 1b __ ADC ACCU + 0 
1f24 : a8 __ __ TAY
1f25 : 8a __ __ TXA
1f26 : 69 d7 __ ADC #$d7
1f28 : aa __ __ TAX
1f29 : 98 __ __ TYA
1f2a : 18 __ __ CLC
1f2b : 65 43 __ ADC T2 + 0 
1f2d : 85 1b __ STA ACCU + 0 
1f2f : 85 45 __ STA T5 + 0 
1f31 : 8a __ __ TXA
1f32 : 69 00 __ ADC #$00
1f34 : 85 1c __ STA ACCU + 1 
1f36 : 18 __ __ CLC
1f37 : 69 e8 __ ADC #$e8
1f39 : 85 46 __ STA T5 + 1 
1f3b : a0 00 __ LDY #$00
1f3d : a2 03 __ LDX #$03
.l1006:
1f3f : a9 86 __ LDA #$86
1f41 : 91 45 __ STA (T5 + 0),y 
1f43 : a5 1d __ LDA ACCU + 2 
1f45 : 91 1b __ STA (ACCU + 0),y 
1f47 : e6 45 __ INC T5 + 0 
1f49 : d0 02 __ BNE $1f4d ; (render_player_dead.s1011 + 0)
.s1010:
1f4b : e6 46 __ INC T5 + 1 
.s1011:
1f4d : e6 1b __ INC ACCU + 0 
1f4f : d0 02 __ BNE $1f53 ; (render_player_dead.s1013 + 0)
.s1012:
1f51 : e6 1c __ INC ACCU + 1 
.s1013:
1f53 : ca __ __ DEX
1f54 : d0 e9 __ BNE $1f3f ; (render_player_dead.l1006 + 0)
.s1007:
1f56 : e6 44 __ INC T3 + 0 
1f58 : a5 44 __ LDA T3 + 0 
1f5a : c9 02 __ CMP #$02
1f5c : 90 93 __ BCC $1ef1 ; (render_player_dead.l6 + 0)
.l14:
1f5e : ad 11 d0 LDA $d011 
1f61 : 30 fb __ BMI $1f5e ; (render_player_dead.l14 + 0)
.l17:
1f63 : ad 11 d0 LDA $d011 
1f66 : 10 fb __ BPL $1f63 ; (render_player_dead.l17 + 0)
.s3:
1f68 : e6 1d __ INC ACCU + 2 
1f6a : a5 1d __ LDA ACCU + 2 
1f6c : c9 1e __ CMP #$1e
1f6e : b0 03 __ BCS $1f73 ; (render_player_dead.s1001 + 0)
1f70 : 4c ed 1e JMP $1eed ; (render_player_dead.l2 + 0)
.s1001:
1f73 : 60 __ __ RTS
--------------------------------------------------------------------
control_player_ship:
.s0:
1f74 : a9 00 __ LDA #$00
1f76 : 20 18 20 JSR $2018 ; (joy_poll.s0 + 0)
1f79 : ad 7c 27 LDA $277c ; (joyx + 0)
1f7c : 85 1d __ STA ACCU + 2 
1f7e : 85 1e __ STA ACCU + 3 
1f80 : d0 08 __ BNE $1f8a ; (control_player_ship.s1 + 0)
.s4:
1f82 : ad 7a 27 LDA $277a ; (joyy + 0)
1f85 : d0 03 __ BNE $1f8a ; (control_player_ship.s1 + 0)
1f87 : 4c 0d 20 JMP $200d ; (control_player_ship.s3 + 0)
.s1:
1f8a : ad 2c 27 LDA $272c ; (Player + 0)
1f8d : 85 43 __ STA T2 + 0 
1f8f : 85 44 __ STA T3 + 0 
1f91 : ad 2d 27 LDA $272d ; (Player + 1)
1f94 : 85 45 __ STA T4 + 0 
1f96 : 85 46 __ STA T5 + 0 
1f98 : 0a __ __ ASL
1f99 : 85 1b __ STA ACCU + 0 
1f9b : a9 00 __ LDA #$00
1f9d : 2a __ __ ROL
1f9e : 06 1b __ ASL ACCU + 0 
1fa0 : 2a __ __ ROL
1fa1 : aa __ __ TAX
1fa2 : a5 1b __ LDA ACCU + 0 
1fa4 : 65 45 __ ADC T4 + 0 
1fa6 : 85 1b __ STA ACCU + 0 
1fa8 : 8a __ __ TXA
1fa9 : 69 00 __ ADC #$00
1fab : 06 1b __ ASL ACCU + 0 
1fad : 2a __ __ ROL
1fae : 06 1b __ ASL ACCU + 0 
1fb0 : 2a __ __ ROL
1fb1 : 06 1b __ ASL ACCU + 0 
1fb3 : 2a __ __ ROL
1fb4 : aa __ __ TAX
1fb5 : 18 __ __ CLC
1fb6 : a5 1b __ LDA ACCU + 0 
1fb8 : 65 43 __ ADC T2 + 0 
1fba : 85 1b __ STA ACCU + 0 
1fbc : 85 1f __ STA ADDR + 0 
1fbe : 8a __ __ TXA
1fbf : 69 c0 __ ADC #$c0
1fc1 : 85 1c __ STA ACCU + 1 
1fc3 : 18 __ __ CLC
1fc4 : 69 18 __ ADC #$18
1fc6 : 85 20 __ STA ADDR + 1 
1fc8 : a9 20 __ LDA #$20
1fca : a0 00 __ LDY #$00
1fcc : 91 1b __ STA (ACCU + 0),y 
1fce : 98 __ __ TYA
1fcf : 91 1f __ STA (ADDR + 0),y 
1fd1 : a5 43 __ LDA T2 + 0 
1fd3 : c9 02 __ CMP #$02
1fd5 : 90 06 __ BCC $1fdd ; (control_player_ship.s6 + 0)
.s8:
1fd7 : a5 1d __ LDA ACCU + 2 
1fd9 : 30 0c __ BMI $1fe7 ; (control_player_ship.s5 + 0)
.s1015:
1fdb : a5 43 __ LDA T2 + 0 
.s6:
1fdd : c9 26 __ CMP #$26
1fdf : b0 0e __ BCS $1fef ; (control_player_ship.s7 + 0)
.s12:
1fe1 : a5 1d __ LDA ACCU + 2 
1fe3 : 30 0a __ BMI $1fef ; (control_player_ship.s7 + 0)
.s1009:
1fe5 : f0 08 __ BEQ $1fef ; (control_player_ship.s7 + 0)
.s5:
1fe7 : 18 __ __ CLC
1fe8 : a5 44 __ LDA T3 + 0 
1fea : 65 1e __ ADC ACCU + 3 
1fec : 8d 2c 27 STA $272c ; (Player + 0)
.s7:
1fef : a5 45 __ LDA T4 + 0 
1ff1 : c9 05 __ CMP #$05
1ff3 : 90 07 __ BCC $1ffc ; (control_player_ship.s14 + 0)
.s16:
1ff5 : ad 7a 27 LDA $277a ; (joyy + 0)
1ff8 : 30 0d __ BMI $2007 ; (control_player_ship.s32 + 0)
.s1014:
1ffa : a5 45 __ LDA T4 + 0 
.s14:
1ffc : c9 17 __ CMP #$17
1ffe : b0 0d __ BCS $200d ; (control_player_ship.s3 + 0)
.s20:
2000 : ad 7a 27 LDA $277a ; (joyy + 0)
2003 : 30 08 __ BMI $200d ; (control_player_ship.s3 + 0)
.s1004:
2005 : f0 06 __ BEQ $200d ; (control_player_ship.s3 + 0)
.s32:
2007 : 18 __ __ CLC
2008 : 65 46 __ ADC T5 + 0 
200a : 8d 2d 27 STA $272d ; (Player + 1)
.s3:
200d : ad 7e 27 LDA $277e ; (joyb + 0)
2010 : c9 01 __ CMP #$01
2012 : f0 01 __ BEQ $2015 ; (control_player_ship.s21 + 0)
.s1001:
2014 : 60 __ __ RTS
.s21:
2015 : 4c 58 20 JMP $2058 ; (spawn_player_shot.s0 + 0)
--------------------------------------------------------------------
joy_poll:
.s0:
2018 : aa __ __ TAX
2019 : bd 00 dc LDA $dc00,x 
201c : a8 __ __ TAY
201d : 29 10 __ AND #$10
201f : f0 04 __ BEQ $2025 ; (joy_poll.s1005 + 0)
.s1006:
2021 : a9 00 __ LDA #$00
2023 : f0 02 __ BEQ $2027 ; (joy_poll.s1007 + 0)
.s1005:
2025 : a9 01 __ LDA #$01
.s1007:
2027 : 9d 7e 27 STA $277e,x ; (joyb + 0)
202a : 98 __ __ TYA
202b : 4a __ __ LSR
202c : b0 1d __ BCS $204b ; (joy_poll.s2 + 0)
.s1:
202e : a9 ff __ LDA #$ff
.s15:
2030 : 9d 7a 27 STA $277a,x ; (joyy + 0)
2033 : 98 __ __ TYA
2034 : 29 04 __ AND #$04
2036 : d0 06 __ BNE $203e ; (joy_poll.s8 + 0)
.s7:
2038 : a9 ff __ LDA #$ff
.s1001:
203a : 9d 7c 27 STA $277c,x ; (joyx + 0)
203d : 60 __ __ RTS
.s8:
203e : 98 __ __ TYA
203f : 29 08 __ AND #$08
2041 : f0 04 __ BEQ $2047 ; (joy_poll.s1011 + 0)
.s1012:
2043 : a9 00 __ LDA #$00
2045 : f0 f3 __ BEQ $203a ; (joy_poll.s1001 + 0)
.s1011:
2047 : a9 01 __ LDA #$01
2049 : d0 ef __ BNE $203a ; (joy_poll.s1001 + 0)
.s2:
204b : 98 __ __ TYA
204c : 29 02 __ AND #$02
204e : f0 04 __ BEQ $2054 ; (joy_poll.s1008 + 0)
.s1009:
2050 : a9 00 __ LDA #$00
2052 : f0 dc __ BEQ $2030 ; (joy_poll.s15 + 0)
.s1008:
2054 : a9 01 __ LDA #$01
2056 : d0 d8 __ BNE $2030 ; (joy_poll.s15 + 0)
--------------------------------------------------------------------
joyy:
277a : __ __ __ BSS	2
--------------------------------------------------------------------
joyx:
277c : __ __ __ BSS	2
--------------------------------------------------------------------
joyb:
277e : __ __ __ BSS	2
--------------------------------------------------------------------
spawn_player_shot:
.s0:
2058 : ad 2c 27 LDA $272c ; (Player + 0)
205b : c9 26 __ CMP #$26
205d : f0 0f __ BEQ $206e ; (spawn_player_shot.s1001 + 0)
.s3:
205f : a0 00 __ LDY #$00
.l6:
2061 : be fd 08 LDX $08fd,y ; (__multab3L + 0)
2064 : bd 66 27 LDA $2766,x ; (PlayerShot + 2)
2067 : f0 06 __ BEQ $206f ; (spawn_player_shot.s9 + 0)
.s7:
2069 : c8 __ __ INY
206a : c0 03 __ CPY #$03
206c : 90 f3 __ BCC $2061 ; (spawn_player_shot.l6 + 0)
.s1001:
206e : 60 __ __ RTS
.s9:
206f : a9 01 __ LDA #$01
2071 : 9d 66 27 STA $2766,x ; (PlayerShot + 2)
2074 : ad 2d 27 LDA $272d ; (Player + 1)
2077 : 9d 65 27 STA $2765,x ; (PlayerShot + 1)
207a : ad 7c 27 LDA $277c ; (joyx + 0)
207d : 30 02 __ BMI $2081 ; (spawn_player_shot.s13 + 0)
.s1007:
207f : d0 06 __ BNE $2087 ; (spawn_player_shot.s12 + 0)
.s13:
2081 : ad 2c 27 LDA $272c ; (Player + 0)
2084 : 4c 8d 20 JMP $208d ; (spawn_player_shot.s14 + 0)
.s12:
2087 : ad 2c 27 LDA $272c ; (Player + 0)
208a : 18 __ __ CLC
208b : 69 01 __ ADC #$01
.s14:
208d : be fd 08 LDX $08fd,y ; (__multab3L + 0)
2090 : 9d 64 27 STA $2764,x ; (PlayerShot + 0)
2093 : ad 31 27 LDA $2731 ; (PlayerShotSound + 3)
2096 : d0 d6 __ BNE $206e ; (spawn_player_shot.s1001 + 0)
.s15:
2098 : a9 01 __ LDA #$01
209a : 8d 31 27 STA $2731 ; (PlayerShotSound + 3)
209d : 60 __ __ RTS
--------------------------------------------------------------------
render_player_ship:
.s0:
209e : ad 2d 27 LDA $272d ; (Player + 1)
20a1 : 0a __ __ ASL
20a2 : 85 1b __ STA ACCU + 0 
20a4 : a9 00 __ LDA #$00
20a6 : 2a __ __ ROL
20a7 : 06 1b __ ASL ACCU + 0 
20a9 : 2a __ __ ROL
20aa : aa __ __ TAX
20ab : a5 1b __ LDA ACCU + 0 
20ad : 6d 2d 27 ADC $272d ; (Player + 1)
20b0 : 85 1b __ STA ACCU + 0 
20b2 : 8a __ __ TXA
20b3 : 69 00 __ ADC #$00
20b5 : 06 1b __ ASL ACCU + 0 
20b7 : 2a __ __ ROL
20b8 : 06 1b __ ASL ACCU + 0 
20ba : 2a __ __ ROL
20bb : 06 1b __ ASL ACCU + 0 
20bd : 2a __ __ ROL
20be : aa __ __ TAX
20bf : 18 __ __ CLC
20c0 : a5 1b __ LDA ACCU + 0 
20c2 : 6d 2c 27 ADC $272c ; (Player + 0)
20c5 : 85 1b __ STA ACCU + 0 
20c7 : 85 1f __ STA ADDR + 0 
20c9 : 8a __ __ TXA
20ca : 69 c0 __ ADC #$c0
20cc : 85 1c __ STA ACCU + 1 
20ce : 18 __ __ CLC
20cf : 69 18 __ ADC #$18
20d1 : 85 20 __ STA ADDR + 1 
20d3 : a9 80 __ LDA #$80
20d5 : a0 00 __ LDY #$00
20d7 : 91 1b __ STA (ACCU + 0),y 
20d9 : a9 03 __ LDA #$03
20db : 91 1f __ STA (ADDR + 0),y 
.s1001:
20dd : 60 __ __ RTS
--------------------------------------------------------------------
move_player_shots:
.s0:
20de : a2 00 __ LDX #$00
.l2:
20e0 : 86 1d __ STX ACCU + 2 
20e2 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
20e5 : b9 66 27 LDA $2766,y ; (PlayerShot + 2)
20e8 : c9 01 __ CMP #$01
20ea : d0 52 __ BNE $213e ; (move_player_shots.s23 + 0)
.s5:
20ec : 84 1e __ STY ACCU + 3 
20ee : b9 65 27 LDA $2765,y ; (PlayerShot + 1)
20f1 : 0a __ __ ASL
20f2 : 85 1b __ STA ACCU + 0 
20f4 : a9 00 __ LDA #$00
20f6 : 2a __ __ ROL
20f7 : 06 1b __ ASL ACCU + 0 
20f9 : 2a __ __ ROL
20fa : aa __ __ TAX
20fb : a5 1b __ LDA ACCU + 0 
20fd : 79 65 27 ADC $2765,y ; (PlayerShot + 1)
2100 : 85 1b __ STA ACCU + 0 
2102 : 8a __ __ TXA
2103 : 69 00 __ ADC #$00
2105 : 06 1b __ ASL ACCU + 0 
2107 : 2a __ __ ROL
2108 : 06 1b __ ASL ACCU + 0 
210a : 2a __ __ ROL
210b : 06 1b __ ASL ACCU + 0 
210d : 2a __ __ ROL
210e : 85 1c __ STA ACCU + 1 
2110 : b9 64 27 LDA $2764,y ; (PlayerShot + 0)
2113 : aa __ __ TAX
2114 : 18 __ __ CLC
2115 : 65 1b __ ADC ACCU + 0 
2117 : 85 1b __ STA ACCU + 0 
2119 : 85 1f __ STA ADDR + 0 
211b : a5 1c __ LDA ACCU + 1 
211d : 69 c0 __ ADC #$c0
211f : 85 1c __ STA ACCU + 1 
2121 : 18 __ __ CLC
2122 : 69 18 __ ADC #$18
2124 : 85 20 __ STA ADDR + 1 
2126 : a9 20 __ LDA #$20
2128 : a0 00 __ LDY #$00
212a : 91 1b __ STA (ACCU + 0),y 
212c : 98 __ __ TYA
212d : 91 1f __ STA (ADDR + 0),y 
212f : e8 __ __ INX
2130 : 8a __ __ TXA
2131 : a6 1e __ LDX ACCU + 3 
2133 : 9d 64 27 STA $2764,x ; (PlayerShot + 0)
2136 : c9 27 __ CMP #$27
2138 : 90 04 __ BCC $213e ; (move_player_shots.s23 + 0)
.s8:
213a : 98 __ __ TYA
213b : 9d 66 27 STA $2766,x ; (PlayerShot + 2)
.s23:
213e : a6 1d __ LDX ACCU + 2 
2140 : e8 __ __ INX
2141 : e0 03 __ CPX #$03
2143 : 90 9b __ BCC $20e0 ; (move_player_shots.l2 + 0)
.s1001:
2145 : 60 __ __ RTS
--------------------------------------------------------------------
render_player_shots:
.s0:
2146 : a2 00 __ LDX #$00
.l1006:
2148 : bc fd 08 LDY $08fd,x ; (__multab3L + 0)
214b : b9 66 27 LDA $2766,y ; (PlayerShot + 2)
214e : c9 01 __ CMP #$01
2150 : d0 43 __ BNE $2195 ; (render_player_shots.s19 + 0)
.s5:
2152 : b9 65 27 LDA $2765,y ; (PlayerShot + 1)
2155 : 0a __ __ ASL
2156 : 85 1b __ STA ACCU + 0 
2158 : a9 00 __ LDA #$00
215a : 2a __ __ ROL
215b : 06 1b __ ASL ACCU + 0 
215d : 2a __ __ ROL
215e : 85 1c __ STA ACCU + 1 
2160 : a5 1b __ LDA ACCU + 0 
2162 : 79 65 27 ADC $2765,y ; (PlayerShot + 1)
2165 : 85 1b __ STA ACCU + 0 
2167 : a5 1c __ LDA ACCU + 1 
2169 : 69 00 __ ADC #$00
216b : 06 1b __ ASL ACCU + 0 
216d : 2a __ __ ROL
216e : 06 1b __ ASL ACCU + 0 
2170 : 2a __ __ ROL
2171 : 06 1b __ ASL ACCU + 0 
2173 : 2a __ __ ROL
2174 : 85 1c __ STA ACCU + 1 
2176 : 18 __ __ CLC
2177 : a5 1b __ LDA ACCU + 0 
2179 : 79 64 27 ADC $2764,y ; (PlayerShot + 0)
217c : 85 1b __ STA ACCU + 0 
217e : 85 1f __ STA ADDR + 0 
2180 : a5 1c __ LDA ACCU + 1 
2182 : 69 c0 __ ADC #$c0
2184 : 85 1c __ STA ACCU + 1 
2186 : 18 __ __ CLC
2187 : 69 18 __ ADC #$18
2189 : 85 20 __ STA ADDR + 1 
218b : a9 81 __ LDA #$81
218d : a0 00 __ LDY #$00
218f : 91 1b __ STA (ACCU + 0),y 
2191 : a9 01 __ LDA #$01
2193 : 91 1f __ STA (ADDR + 0),y 
.s19:
2195 : e8 __ __ INX
2196 : e0 03 __ CPX #$03
2198 : 90 ae __ BCC $2148 ; (render_player_shots.l1006 + 0)
.s1001:
219a : 60 __ __ RTS
--------------------------------------------------------------------
wait_frames:
.s0:
219b : a5 0e __ LDA P1 ; (frames + 1)
219d : 30 1c __ BMI $21bb ; (wait_frames.s1001 + 0)
.s1005:
219f : 05 0d __ ORA P0 ; (frames + 0)
21a1 : f0 18 __ BEQ $21bb ; (wait_frames.s1001 + 0)
.s13:
21a3 : a0 00 __ LDY #$00
21a5 : a6 0e __ LDX P1 ; (frames + 1)
.l6:
21a7 : ad 11 d0 LDA $d011 
21aa : 30 fb __ BMI $21a7 ; (wait_frames.l6 + 0)
.l9:
21ac : ad 11 d0 LDA $d011 
21af : 10 fb __ BPL $21ac ; (wait_frames.l9 + 0)
.s3:
21b1 : c8 __ __ INY
21b2 : 8a __ __ TXA
21b3 : 30 06 __ BMI $21bb ; (wait_frames.s1001 + 0)
.s1004:
21b5 : d0 f0 __ BNE $21a7 ; (wait_frames.l6 + 0)
.s1002:
21b7 : c4 0d __ CPY P0 ; (frames + 0)
21b9 : 90 ec __ BCC $21a7 ; (wait_frames.l6 + 0)
.s1001:
21bb : 60 __ __ RTS
--------------------------------------------------------------------
freg:
21bc : b1 19 __ LDA (IP + 0),y 
21be : c8 __ __ INY
21bf : aa __ __ TAX
21c0 : b5 00 __ LDA $00,x 
21c2 : 85 03 __ STA WORK + 0 
21c4 : b5 01 __ LDA $01,x 
21c6 : 85 04 __ STA WORK + 1 
21c8 : b5 02 __ LDA $02,x 
21ca : 85 05 __ STA WORK + 2 
21cc : b5 03 __ LDA WORK + 0,x 
21ce : 85 06 __ STA WORK + 3 
21d0 : a5 05 __ LDA WORK + 2 
21d2 : 0a __ __ ASL
21d3 : a5 06 __ LDA WORK + 3 
21d5 : 2a __ __ ROL
21d6 : 85 08 __ STA WORK + 5 
21d8 : f0 06 __ BEQ $21e0 ; (freg + 36)
21da : a5 05 __ LDA WORK + 2 
21dc : 09 80 __ ORA #$80
21de : 85 05 __ STA WORK + 2 
21e0 : a5 1d __ LDA ACCU + 2 
21e2 : 0a __ __ ASL
21e3 : a5 1e __ LDA ACCU + 3 
21e5 : 2a __ __ ROL
21e6 : 85 07 __ STA WORK + 4 
21e8 : f0 06 __ BEQ $21f0 ; (freg + 52)
21ea : a5 1d __ LDA ACCU + 2 
21ec : 09 80 __ ORA #$80
21ee : 85 1d __ STA ACCU + 2 
21f0 : 60 __ __ RTS
21f1 : 06 1e __ ASL ACCU + 3 
21f3 : a5 07 __ LDA WORK + 4 
21f5 : 6a __ __ ROR
21f6 : 85 1e __ STA ACCU + 3 
21f8 : b0 06 __ BCS $2200 ; (freg + 68)
21fa : a5 1d __ LDA ACCU + 2 
21fc : 29 7f __ AND #$7f
21fe : 85 1d __ STA ACCU + 2 
2200 : 60 __ __ RTS
--------------------------------------------------------------------
faddsub:
2201 : a9 ff __ LDA #$ff
2203 : c5 07 __ CMP WORK + 4 
2205 : f0 04 __ BEQ $220b ; (faddsub + 10)
2207 : c5 08 __ CMP WORK + 5 
2209 : d0 11 __ BNE $221c ; (faddsub + 27)
220b : a5 1e __ LDA ACCU + 3 
220d : 09 7f __ ORA #$7f
220f : 85 1e __ STA ACCU + 3 
2211 : a9 80 __ LDA #$80
2213 : 85 1d __ STA ACCU + 2 
2215 : a9 00 __ LDA #$00
2217 : 85 1b __ STA ACCU + 0 
2219 : 85 1c __ STA ACCU + 1 
221b : 60 __ __ RTS
221c : 38 __ __ SEC
221d : a5 07 __ LDA WORK + 4 
221f : e5 08 __ SBC WORK + 5 
2221 : f0 38 __ BEQ $225b ; (faddsub + 90)
2223 : aa __ __ TAX
2224 : b0 25 __ BCS $224b ; (faddsub + 74)
2226 : e0 e9 __ CPX #$e9
2228 : b0 0e __ BCS $2238 ; (faddsub + 55)
222a : a5 08 __ LDA WORK + 5 
222c : 85 07 __ STA WORK + 4 
222e : a9 00 __ LDA #$00
2230 : 85 1b __ STA ACCU + 0 
2232 : 85 1c __ STA ACCU + 1 
2234 : 85 1d __ STA ACCU + 2 
2236 : f0 23 __ BEQ $225b ; (faddsub + 90)
2238 : a5 1d __ LDA ACCU + 2 
223a : 4a __ __ LSR
223b : 66 1c __ ROR ACCU + 1 
223d : 66 1b __ ROR ACCU + 0 
223f : e8 __ __ INX
2240 : d0 f8 __ BNE $223a ; (faddsub + 57)
2242 : 85 1d __ STA ACCU + 2 
2244 : a5 08 __ LDA WORK + 5 
2246 : 85 07 __ STA WORK + 4 
2248 : 4c 5b 22 JMP $225b ; (faddsub + 90)
224b : e0 18 __ CPX #$18
224d : b0 33 __ BCS $2282 ; (faddsub + 129)
224f : a5 05 __ LDA WORK + 2 
2251 : 4a __ __ LSR
2252 : 66 04 __ ROR WORK + 1 
2254 : 66 03 __ ROR WORK + 0 
2256 : ca __ __ DEX
2257 : d0 f8 __ BNE $2251 ; (faddsub + 80)
2259 : 85 05 __ STA WORK + 2 
225b : a5 1e __ LDA ACCU + 3 
225d : 29 80 __ AND #$80
225f : 85 1e __ STA ACCU + 3 
2261 : 45 06 __ EOR WORK + 3 
2263 : 30 31 __ BMI $2296 ; (faddsub + 149)
2265 : 18 __ __ CLC
2266 : a5 1b __ LDA ACCU + 0 
2268 : 65 03 __ ADC WORK + 0 
226a : 85 1b __ STA ACCU + 0 
226c : a5 1c __ LDA ACCU + 1 
226e : 65 04 __ ADC WORK + 1 
2270 : 85 1c __ STA ACCU + 1 
2272 : a5 1d __ LDA ACCU + 2 
2274 : 65 05 __ ADC WORK + 2 
2276 : 85 1d __ STA ACCU + 2 
2278 : 90 08 __ BCC $2282 ; (faddsub + 129)
227a : 66 1d __ ROR ACCU + 2 
227c : 66 1c __ ROR ACCU + 1 
227e : 66 1b __ ROR ACCU + 0 
2280 : e6 07 __ INC WORK + 4 
2282 : a5 07 __ LDA WORK + 4 
2284 : c9 ff __ CMP #$ff
2286 : f0 83 __ BEQ $220b ; (faddsub + 10)
2288 : 4a __ __ LSR
2289 : 05 1e __ ORA ACCU + 3 
228b : 85 1e __ STA ACCU + 3 
228d : b0 06 __ BCS $2295 ; (faddsub + 148)
228f : a5 1d __ LDA ACCU + 2 
2291 : 29 7f __ AND #$7f
2293 : 85 1d __ STA ACCU + 2 
2295 : 60 __ __ RTS
2296 : 38 __ __ SEC
2297 : a5 1b __ LDA ACCU + 0 
2299 : e5 03 __ SBC WORK + 0 
229b : 85 1b __ STA ACCU + 0 
229d : a5 1c __ LDA ACCU + 1 
229f : e5 04 __ SBC WORK + 1 
22a1 : 85 1c __ STA ACCU + 1 
22a3 : a5 1d __ LDA ACCU + 2 
22a5 : e5 05 __ SBC WORK + 2 
22a7 : 85 1d __ STA ACCU + 2 
22a9 : b0 19 __ BCS $22c4 ; (faddsub + 195)
22ab : 38 __ __ SEC
22ac : a9 00 __ LDA #$00
22ae : e5 1b __ SBC ACCU + 0 
22b0 : 85 1b __ STA ACCU + 0 
22b2 : a9 00 __ LDA #$00
22b4 : e5 1c __ SBC ACCU + 1 
22b6 : 85 1c __ STA ACCU + 1 
22b8 : a9 00 __ LDA #$00
22ba : e5 1d __ SBC ACCU + 2 
22bc : 85 1d __ STA ACCU + 2 
22be : a5 1e __ LDA ACCU + 3 
22c0 : 49 80 __ EOR #$80
22c2 : 85 1e __ STA ACCU + 3 
22c4 : a5 1d __ LDA ACCU + 2 
22c6 : 30 ba __ BMI $2282 ; (faddsub + 129)
22c8 : 05 1c __ ORA ACCU + 1 
22ca : 05 1b __ ORA ACCU + 0 
22cc : f0 0f __ BEQ $22dd ; (faddsub + 220)
22ce : c6 07 __ DEC WORK + 4 
22d0 : f0 0b __ BEQ $22dd ; (faddsub + 220)
22d2 : 06 1b __ ASL ACCU + 0 
22d4 : 26 1c __ ROL ACCU + 1 
22d6 : 26 1d __ ROL ACCU + 2 
22d8 : 10 f4 __ BPL $22ce ; (faddsub + 205)
22da : 4c 82 22 JMP $2282 ; (faddsub + 129)
22dd : a9 00 __ LDA #$00
22df : 85 1b __ STA ACCU + 0 
22e1 : 85 1c __ STA ACCU + 1 
22e3 : 85 1d __ STA ACCU + 2 
22e5 : 85 1e __ STA ACCU + 3 
22e7 : 60 __ __ RTS
--------------------------------------------------------------------
fmul:
22e8 : a5 1b __ LDA ACCU + 0 
22ea : 05 1c __ ORA ACCU + 1 
22ec : 05 1d __ ORA ACCU + 2 
22ee : d0 03 __ BNE $22f3 ; (fmul + 11)
22f0 : 85 1e __ STA ACCU + 3 
22f2 : 60 __ __ RTS
22f3 : a5 03 __ LDA WORK + 0 
22f5 : 05 04 __ ORA WORK + 1 
22f7 : 05 05 __ ORA WORK + 2 
22f9 : d0 09 __ BNE $2304 ; (fmul + 28)
22fb : 85 1b __ STA ACCU + 0 
22fd : 85 1c __ STA ACCU + 1 
22ff : 85 1d __ STA ACCU + 2 
2301 : 85 1e __ STA ACCU + 3 
2303 : 60 __ __ RTS
2304 : a5 1e __ LDA ACCU + 3 
2306 : 45 06 __ EOR WORK + 3 
2308 : 29 80 __ AND #$80
230a : 85 1e __ STA ACCU + 3 
230c : a9 ff __ LDA #$ff
230e : c5 07 __ CMP WORK + 4 
2310 : f0 42 __ BEQ $2354 ; (fmul + 108)
2312 : c5 08 __ CMP WORK + 5 
2314 : f0 3e __ BEQ $2354 ; (fmul + 108)
2316 : a9 00 __ LDA #$00
2318 : 85 09 __ STA WORK + 6 
231a : 85 0a __ STA WORK + 7 
231c : 85 0b __ STA $0b 
231e : a4 1b __ LDY ACCU + 0 
2320 : a5 03 __ LDA WORK + 0 
2322 : d0 06 __ BNE $232a ; (fmul + 66)
2324 : a5 04 __ LDA WORK + 1 
2326 : f0 0a __ BEQ $2332 ; (fmul + 74)
2328 : d0 05 __ BNE $232f ; (fmul + 71)
232a : 20 89 23 JSR $2389 ; (fmul8 + 0)
232d : a5 04 __ LDA WORK + 1 
232f : 20 89 23 JSR $2389 ; (fmul8 + 0)
2332 : a5 05 __ LDA WORK + 2 
2334 : 20 89 23 JSR $2389 ; (fmul8 + 0)
2337 : 38 __ __ SEC
2338 : a5 0b __ LDA $0b 
233a : 30 06 __ BMI $2342 ; (fmul + 90)
233c : 06 09 __ ASL WORK + 6 
233e : 26 0a __ ROL WORK + 7 
2340 : 2a __ __ ROL
2341 : 18 __ __ CLC
2342 : 29 7f __ AND #$7f
2344 : 85 0b __ STA $0b 
2346 : a5 07 __ LDA WORK + 4 
2348 : 65 08 __ ADC WORK + 5 
234a : 90 19 __ BCC $2365 ; (fmul + 125)
234c : e9 7f __ SBC #$7f
234e : b0 04 __ BCS $2354 ; (fmul + 108)
2350 : c9 ff __ CMP #$ff
2352 : d0 15 __ BNE $2369 ; (fmul + 129)
2354 : a5 1e __ LDA ACCU + 3 
2356 : 09 7f __ ORA #$7f
2358 : 85 1e __ STA ACCU + 3 
235a : a9 80 __ LDA #$80
235c : 85 1d __ STA ACCU + 2 
235e : a9 00 __ LDA #$00
2360 : 85 1b __ STA ACCU + 0 
2362 : 85 1c __ STA ACCU + 1 
2364 : 60 __ __ RTS
2365 : e9 7e __ SBC #$7e
2367 : 90 15 __ BCC $237e ; (fmul + 150)
2369 : 4a __ __ LSR
236a : 05 1e __ ORA ACCU + 3 
236c : 85 1e __ STA ACCU + 3 
236e : a9 00 __ LDA #$00
2370 : 6a __ __ ROR
2371 : 05 0b __ ORA $0b 
2373 : 85 1d __ STA ACCU + 2 
2375 : a5 0a __ LDA WORK + 7 
2377 : 85 1c __ STA ACCU + 1 
2379 : a5 09 __ LDA WORK + 6 
237b : 85 1b __ STA ACCU + 0 
237d : 60 __ __ RTS
237e : a9 00 __ LDA #$00
2380 : 85 1b __ STA ACCU + 0 
2382 : 85 1c __ STA ACCU + 1 
2384 : 85 1d __ STA ACCU + 2 
2386 : 85 1e __ STA ACCU + 3 
2388 : 60 __ __ RTS
--------------------------------------------------------------------
fmul8:
2389 : 38 __ __ SEC
238a : 6a __ __ ROR
238b : 90 1e __ BCC $23ab ; (fmul8 + 34)
238d : aa __ __ TAX
238e : 18 __ __ CLC
238f : 98 __ __ TYA
2390 : 65 09 __ ADC WORK + 6 
2392 : 85 09 __ STA WORK + 6 
2394 : a5 0a __ LDA WORK + 7 
2396 : 65 1c __ ADC ACCU + 1 
2398 : 85 0a __ STA WORK + 7 
239a : a5 0b __ LDA $0b 
239c : 65 1d __ ADC ACCU + 2 
239e : 6a __ __ ROR
239f : 85 0b __ STA $0b 
23a1 : 8a __ __ TXA
23a2 : 66 0a __ ROR WORK + 7 
23a4 : 66 09 __ ROR WORK + 6 
23a6 : 4a __ __ LSR
23a7 : f0 0d __ BEQ $23b6 ; (fmul8 + 45)
23a9 : b0 e2 __ BCS $238d ; (fmul8 + 4)
23ab : 66 0b __ ROR $0b 
23ad : 66 0a __ ROR WORK + 7 
23af : 66 09 __ ROR WORK + 6 
23b1 : 4a __ __ LSR
23b2 : 90 f7 __ BCC $23ab ; (fmul8 + 34)
23b4 : d0 d7 __ BNE $238d ; (fmul8 + 4)
23b6 : 60 __ __ RTS
--------------------------------------------------------------------
fdiv:
23b7 : a5 1b __ LDA ACCU + 0 
23b9 : 05 1c __ ORA ACCU + 1 
23bb : 05 1d __ ORA ACCU + 2 
23bd : d0 03 __ BNE $23c2 ; (fdiv + 11)
23bf : 85 1e __ STA ACCU + 3 
23c1 : 60 __ __ RTS
23c2 : a5 1e __ LDA ACCU + 3 
23c4 : 45 06 __ EOR WORK + 3 
23c6 : 29 80 __ AND #$80
23c8 : 85 1e __ STA ACCU + 3 
23ca : a5 08 __ LDA WORK + 5 
23cc : f0 62 __ BEQ $2430 ; (fdiv + 121)
23ce : a5 07 __ LDA WORK + 4 
23d0 : c9 ff __ CMP #$ff
23d2 : f0 5c __ BEQ $2430 ; (fdiv + 121)
23d4 : a9 00 __ LDA #$00
23d6 : 85 09 __ STA WORK + 6 
23d8 : 85 0a __ STA WORK + 7 
23da : 85 0b __ STA $0b 
23dc : a2 18 __ LDX #$18
23de : a5 1b __ LDA ACCU + 0 
23e0 : c5 03 __ CMP WORK + 0 
23e2 : a5 1c __ LDA ACCU + 1 
23e4 : e5 04 __ SBC WORK + 1 
23e6 : a5 1d __ LDA ACCU + 2 
23e8 : e5 05 __ SBC WORK + 2 
23ea : 90 13 __ BCC $23ff ; (fdiv + 72)
23ec : a5 1b __ LDA ACCU + 0 
23ee : e5 03 __ SBC WORK + 0 
23f0 : 85 1b __ STA ACCU + 0 
23f2 : a5 1c __ LDA ACCU + 1 
23f4 : e5 04 __ SBC WORK + 1 
23f6 : 85 1c __ STA ACCU + 1 
23f8 : a5 1d __ LDA ACCU + 2 
23fa : e5 05 __ SBC WORK + 2 
23fc : 85 1d __ STA ACCU + 2 
23fe : 38 __ __ SEC
23ff : 26 09 __ ROL WORK + 6 
2401 : 26 0a __ ROL WORK + 7 
2403 : 26 0b __ ROL $0b 
2405 : ca __ __ DEX
2406 : f0 0a __ BEQ $2412 ; (fdiv + 91)
2408 : 06 1b __ ASL ACCU + 0 
240a : 26 1c __ ROL ACCU + 1 
240c : 26 1d __ ROL ACCU + 2 
240e : b0 dc __ BCS $23ec ; (fdiv + 53)
2410 : 90 cc __ BCC $23de ; (fdiv + 39)
2412 : 38 __ __ SEC
2413 : a5 0b __ LDA $0b 
2415 : 30 06 __ BMI $241d ; (fdiv + 102)
2417 : 06 09 __ ASL WORK + 6 
2419 : 26 0a __ ROL WORK + 7 
241b : 2a __ __ ROL
241c : 18 __ __ CLC
241d : 29 7f __ AND #$7f
241f : 85 0b __ STA $0b 
2421 : a5 07 __ LDA WORK + 4 
2423 : e5 08 __ SBC WORK + 5 
2425 : 90 1a __ BCC $2441 ; (fdiv + 138)
2427 : 18 __ __ CLC
2428 : 69 7f __ ADC #$7f
242a : b0 04 __ BCS $2430 ; (fdiv + 121)
242c : c9 ff __ CMP #$ff
242e : d0 15 __ BNE $2445 ; (fdiv + 142)
2430 : a5 1e __ LDA ACCU + 3 
2432 : 09 7f __ ORA #$7f
2434 : 85 1e __ STA ACCU + 3 
2436 : a9 80 __ LDA #$80
2438 : 85 1d __ STA ACCU + 2 
243a : a9 00 __ LDA #$00
243c : 85 1c __ STA ACCU + 1 
243e : 85 1b __ STA ACCU + 0 
2440 : 60 __ __ RTS
2441 : 69 7f __ ADC #$7f
2443 : 90 15 __ BCC $245a ; (fdiv + 163)
2445 : 4a __ __ LSR
2446 : 05 1e __ ORA ACCU + 3 
2448 : 85 1e __ STA ACCU + 3 
244a : a9 00 __ LDA #$00
244c : 6a __ __ ROR
244d : 05 0b __ ORA $0b 
244f : 85 1d __ STA ACCU + 2 
2451 : a5 0a __ LDA WORK + 7 
2453 : 85 1c __ STA ACCU + 1 
2455 : a5 09 __ LDA WORK + 6 
2457 : 85 1b __ STA ACCU + 0 
2459 : 60 __ __ RTS
245a : a9 00 __ LDA #$00
245c : 85 1e __ STA ACCU + 3 
245e : 85 1d __ STA ACCU + 2 
2460 : 85 1c __ STA ACCU + 1 
2462 : 85 1b __ STA ACCU + 0 
2464 : 60 __ __ RTS
--------------------------------------------------------------------
divs16:
2465 : 24 1c __ BIT ACCU + 1 
2467 : 10 0d __ BPL $2476 ; (divs16 + 17)
2469 : 20 83 24 JSR $2483 ; (negaccu + 0)
246c : 24 04 __ BIT WORK + 1 
246e : 10 0d __ BPL $247d ; (divs16 + 24)
2470 : 20 91 24 JSR $2491 ; (negtmp + 0)
2473 : 4c 9f 24 JMP $249f ; (divmod + 0)
2476 : 24 04 __ BIT WORK + 1 
2478 : 10 f9 __ BPL $2473 ; (divs16 + 14)
247a : 20 91 24 JSR $2491 ; (negtmp + 0)
247d : 20 9f 24 JSR $249f ; (divmod + 0)
2480 : 4c 83 24 JMP $2483 ; (negaccu + 0)
--------------------------------------------------------------------
negaccu:
2483 : 38 __ __ SEC
2484 : a9 00 __ LDA #$00
2486 : e5 1b __ SBC ACCU + 0 
2488 : 85 1b __ STA ACCU + 0 
248a : a9 00 __ LDA #$00
248c : e5 1c __ SBC ACCU + 1 
248e : 85 1c __ STA ACCU + 1 
2490 : 60 __ __ RTS
--------------------------------------------------------------------
negtmp:
2491 : 38 __ __ SEC
2492 : a9 00 __ LDA #$00
2494 : e5 03 __ SBC WORK + 0 
2496 : 85 03 __ STA WORK + 0 
2498 : a9 00 __ LDA #$00
249a : e5 04 __ SBC WORK + 1 
249c : 85 04 __ STA WORK + 1 
249e : 60 __ __ RTS
--------------------------------------------------------------------
divmod:
249f : a5 1c __ LDA ACCU + 1 
24a1 : d0 31 __ BNE $24d4 ; (divmod + 53)
24a3 : a5 04 __ LDA WORK + 1 
24a5 : d0 1e __ BNE $24c5 ; (divmod + 38)
24a7 : 85 06 __ STA WORK + 3 
24a9 : a2 04 __ LDX #$04
24ab : 06 1b __ ASL ACCU + 0 
24ad : 2a __ __ ROL
24ae : c5 03 __ CMP WORK + 0 
24b0 : 90 02 __ BCC $24b4 ; (divmod + 21)
24b2 : e5 03 __ SBC WORK + 0 
24b4 : 26 1b __ ROL ACCU + 0 
24b6 : 2a __ __ ROL
24b7 : c5 03 __ CMP WORK + 0 
24b9 : 90 02 __ BCC $24bd ; (divmod + 30)
24bb : e5 03 __ SBC WORK + 0 
24bd : 26 1b __ ROL ACCU + 0 
24bf : ca __ __ DEX
24c0 : d0 eb __ BNE $24ad ; (divmod + 14)
24c2 : 85 05 __ STA WORK + 2 
24c4 : 60 __ __ RTS
24c5 : a5 1b __ LDA ACCU + 0 
24c7 : 85 05 __ STA WORK + 2 
24c9 : a5 1c __ LDA ACCU + 1 
24cb : 85 06 __ STA WORK + 3 
24cd : a9 00 __ LDA #$00
24cf : 85 1b __ STA ACCU + 0 
24d1 : 85 1c __ STA ACCU + 1 
24d3 : 60 __ __ RTS
24d4 : a5 04 __ LDA WORK + 1 
24d6 : d0 1f __ BNE $24f7 ; (divmod + 88)
24d8 : a5 03 __ LDA WORK + 0 
24da : 30 1b __ BMI $24f7 ; (divmod + 88)
24dc : a9 00 __ LDA #$00
24de : 85 06 __ STA WORK + 3 
24e0 : a2 10 __ LDX #$10
24e2 : 06 1b __ ASL ACCU + 0 
24e4 : 26 1c __ ROL ACCU + 1 
24e6 : 2a __ __ ROL
24e7 : c5 03 __ CMP WORK + 0 
24e9 : 90 02 __ BCC $24ed ; (divmod + 78)
24eb : e5 03 __ SBC WORK + 0 
24ed : 26 1b __ ROL ACCU + 0 
24ef : 26 1c __ ROL ACCU + 1 
24f1 : ca __ __ DEX
24f2 : d0 f2 __ BNE $24e6 ; (divmod + 71)
24f4 : 85 05 __ STA WORK + 2 
24f6 : 60 __ __ RTS
24f7 : a9 00 __ LDA #$00
24f9 : 85 05 __ STA WORK + 2 
24fb : 85 06 __ STA WORK + 3 
24fd : 84 02 __ STY $02 
24ff : a0 10 __ LDY #$10
2501 : 18 __ __ CLC
2502 : 26 1b __ ROL ACCU + 0 
2504 : 26 1c __ ROL ACCU + 1 
2506 : 26 05 __ ROL WORK + 2 
2508 : 26 06 __ ROL WORK + 3 
250a : 38 __ __ SEC
250b : a5 05 __ LDA WORK + 2 
250d : e5 03 __ SBC WORK + 0 
250f : aa __ __ TAX
2510 : a5 06 __ LDA WORK + 3 
2512 : e5 04 __ SBC WORK + 1 
2514 : 90 04 __ BCC $251a ; (divmod + 123)
2516 : 86 05 __ STX WORK + 2 
2518 : 85 06 __ STA WORK + 3 
251a : 88 __ __ DEY
251b : d0 e5 __ BNE $2502 ; (divmod + 99)
251d : 26 1b __ ROL ACCU + 0 
251f : 26 1c __ ROL ACCU + 1 
2521 : a4 02 __ LDY $02 
2523 : 60 __ __ RTS
--------------------------------------------------------------------
mods16:
2524 : 24 1c __ BIT ACCU + 1 
2526 : 10 0d __ BPL $2535 ; (mods16 + 17)
2528 : 20 83 24 JSR $2483 ; (negaccu + 0)
252b : 24 04 __ BIT WORK + 1 
252d : 10 0d __ BPL $253c ; (mods16 + 24)
252f : 20 91 24 JSR $2491 ; (negtmp + 0)
2532 : 4c 9f 24 JMP $249f ; (divmod + 0)
2535 : 24 04 __ BIT WORK + 1 
2537 : 10 f9 __ BPL $2532 ; (mods16 + 14)
2539 : 20 91 24 JSR $2491 ; (negtmp + 0)
253c : 20 9f 24 JSR $249f ; (divmod + 0)
253f : 38 __ __ SEC
2540 : a9 00 __ LDA #$00
2542 : e5 05 __ SBC WORK + 2 
2544 : 85 05 __ STA WORK + 2 
2546 : a9 00 __ LDA #$00
2548 : e5 06 __ SBC WORK + 3 
254a : 85 06 __ STA WORK + 3 
254c : 60 __ __ RTS
--------------------------------------------------------------------
f32_to_i16:
254d : 20 e0 21 JSR $21e0 ; (freg + 36)
2550 : a5 07 __ LDA WORK + 4 
2552 : c9 7f __ CMP #$7f
2554 : b0 07 __ BCS $255d ; (f32_to_i16 + 16)
2556 : a9 00 __ LDA #$00
2558 : 85 1b __ STA ACCU + 0 
255a : 85 1c __ STA ACCU + 1 
255c : 60 __ __ RTS
255d : 38 __ __ SEC
255e : e9 8e __ SBC #$8e
2560 : 90 0a __ BCC $256c ; (f32_to_i16 + 31)
2562 : a9 ff __ LDA #$ff
2564 : 85 1b __ STA ACCU + 0 
2566 : a9 7f __ LDA #$7f
2568 : 85 1c __ STA ACCU + 1 
256a : d0 08 __ BNE $2574 ; (f32_to_i16 + 39)
256c : aa __ __ TAX
256d : 46 1d __ LSR ACCU + 2 
256f : 66 1c __ ROR ACCU + 1 
2571 : e8 __ __ INX
2572 : d0 f9 __ BNE $256d ; (f32_to_i16 + 32)
2574 : 24 1e __ BIT ACCU + 3 
2576 : 10 0e __ BPL $2586 ; (f32_to_i16 + 57)
2578 : 38 __ __ SEC
2579 : a9 00 __ LDA #$00
257b : e5 1c __ SBC ACCU + 1 
257d : 85 1b __ STA ACCU + 0 
257f : a9 00 __ LDA #$00
2581 : e5 1d __ SBC ACCU + 2 
2583 : 85 1c __ STA ACCU + 1 
2585 : 60 __ __ RTS
2586 : a5 1c __ LDA ACCU + 1 
2588 : 85 1b __ STA ACCU + 0 
258a : a5 1d __ LDA ACCU + 2 
258c : 85 1c __ STA ACCU + 1 
258e : 60 __ __ RTS
--------------------------------------------------------------------
sint16_to_float:
258f : 24 1c __ BIT ACCU + 1 
2591 : 30 03 __ BMI $2596 ; (sint16_to_float + 7)
2593 : 4c ad 25 JMP $25ad ; (uint16_to_float + 0)
2596 : 38 __ __ SEC
2597 : a9 00 __ LDA #$00
2599 : e5 1b __ SBC ACCU + 0 
259b : 85 1b __ STA ACCU + 0 
259d : a9 00 __ LDA #$00
259f : e5 1c __ SBC ACCU + 1 
25a1 : 85 1c __ STA ACCU + 1 
25a3 : 20 ad 25 JSR $25ad ; (uint16_to_float + 0)
25a6 : a5 1e __ LDA ACCU + 3 
25a8 : 09 80 __ ORA #$80
25aa : 85 1e __ STA ACCU + 3 
25ac : 60 __ __ RTS
--------------------------------------------------------------------
uint16_to_float:
25ad : a5 1b __ LDA ACCU + 0 
25af : 05 1c __ ORA ACCU + 1 
25b1 : d0 05 __ BNE $25b8 ; (uint16_to_float + 11)
25b3 : 85 1d __ STA ACCU + 2 
25b5 : 85 1e __ STA ACCU + 3 
25b7 : 60 __ __ RTS
25b8 : a2 8e __ LDX #$8e
25ba : a5 1c __ LDA ACCU + 1 
25bc : 30 06 __ BMI $25c4 ; (uint16_to_float + 23)
25be : ca __ __ DEX
25bf : 06 1b __ ASL ACCU + 0 
25c1 : 2a __ __ ROL
25c2 : 10 fa __ BPL $25be ; (uint16_to_float + 17)
25c4 : 29 7f __ AND #$7f
25c6 : 85 1d __ STA ACCU + 2 
25c8 : a5 1b __ LDA ACCU + 0 
25ca : 85 1c __ STA ACCU + 1 
25cc : 8a __ __ TXA
25cd : 4a __ __ LSR
25ce : 85 1e __ STA ACCU + 3 
25d0 : a9 00 __ LDA #$00
25d2 : 85 1b __ STA ACCU + 0 
25d4 : 6a __ __ ROR
25d5 : 05 1d __ ORA ACCU + 2 
25d7 : 85 1d __ STA ACCU + 2 
25d9 : 60 __ __ RTS
--------------------------------------------------------------------
divmod32:
25da : 84 02 __ STY $02 
25dc : a0 20 __ LDY #$20
25de : a9 00 __ LDA #$00
25e0 : 85 07 __ STA WORK + 4 
25e2 : 85 08 __ STA WORK + 5 
25e4 : 85 09 __ STA WORK + 6 
25e6 : 85 0a __ STA WORK + 7 
25e8 : a5 05 __ LDA WORK + 2 
25ea : 05 06 __ ORA WORK + 3 
25ec : d0 39 __ BNE $2627 ; (divmod32 + 77)
25ee : 18 __ __ CLC
25ef : 26 1b __ ROL ACCU + 0 
25f1 : 26 1c __ ROL ACCU + 1 
25f3 : 26 1d __ ROL ACCU + 2 
25f5 : 26 1e __ ROL ACCU + 3 
25f7 : 26 07 __ ROL WORK + 4 
25f9 : 26 08 __ ROL WORK + 5 
25fb : 90 0c __ BCC $2609 ; (divmod32 + 47)
25fd : a5 07 __ LDA WORK + 4 
25ff : e5 03 __ SBC WORK + 0 
2601 : aa __ __ TAX
2602 : a5 08 __ LDA WORK + 5 
2604 : e5 04 __ SBC WORK + 1 
2606 : 38 __ __ SEC
2607 : b0 0c __ BCS $2615 ; (divmod32 + 59)
2609 : 38 __ __ SEC
260a : a5 07 __ LDA WORK + 4 
260c : e5 03 __ SBC WORK + 0 
260e : aa __ __ TAX
260f : a5 08 __ LDA WORK + 5 
2611 : e5 04 __ SBC WORK + 1 
2613 : 90 04 __ BCC $2619 ; (divmod32 + 63)
2615 : 86 07 __ STX WORK + 4 
2617 : 85 08 __ STA WORK + 5 
2619 : 88 __ __ DEY
261a : d0 d3 __ BNE $25ef ; (divmod32 + 21)
261c : 26 1b __ ROL ACCU + 0 
261e : 26 1c __ ROL ACCU + 1 
2620 : 26 1d __ ROL ACCU + 2 
2622 : 26 1e __ ROL ACCU + 3 
2624 : a4 02 __ LDY $02 
2626 : 60 __ __ RTS
2627 : 18 __ __ CLC
2628 : 26 1b __ ROL ACCU + 0 
262a : 26 1c __ ROL ACCU + 1 
262c : 26 1d __ ROL ACCU + 2 
262e : 26 1e __ ROL ACCU + 3 
2630 : 26 07 __ ROL WORK + 4 
2632 : 26 08 __ ROL WORK + 5 
2634 : 26 09 __ ROL WORK + 6 
2636 : 26 0a __ ROL WORK + 7 
2638 : a5 07 __ LDA WORK + 4 
263a : c5 03 __ CMP WORK + 0 
263c : a5 08 __ LDA WORK + 5 
263e : e5 04 __ SBC WORK + 1 
2640 : a5 09 __ LDA WORK + 6 
2642 : e5 05 __ SBC WORK + 2 
2644 : a5 0a __ LDA WORK + 7 
2646 : e5 06 __ SBC WORK + 3 
2648 : 90 18 __ BCC $2662 ; (divmod32 + 136)
264a : a5 07 __ LDA WORK + 4 
264c : e5 03 __ SBC WORK + 0 
264e : 85 07 __ STA WORK + 4 
2650 : a5 08 __ LDA WORK + 5 
2652 : e5 04 __ SBC WORK + 1 
2654 : 85 08 __ STA WORK + 5 
2656 : a5 09 __ LDA WORK + 6 
2658 : e5 05 __ SBC WORK + 2 
265a : 85 09 __ STA WORK + 6 
265c : a5 0a __ LDA WORK + 7 
265e : e5 06 __ SBC WORK + 3 
2660 : 85 0a __ STA WORK + 7 
2662 : 88 __ __ DEY
2663 : d0 c3 __ BNE $2628 ; (divmod32 + 78)
2665 : 26 1b __ ROL ACCU + 0 
2667 : 26 1c __ ROL ACCU + 1 
2669 : 26 1d __ ROL ACCU + 2 
266b : 26 1e __ ROL ACCU + 3 
266d : a4 02 __ LDY $02 
266f : 60 __ __ RTS
--------------------------------------------------------------------
__multab5L:
2670 : __ __ __ BYT 00 05 0a 0f 14 19 1e 23 28 2d                   : .......#(-
--------------------------------------------------------------------
__multab3L:
08fd : __ __ __ BYT 00 03 06                                        : ...
--------------------------------------------------------------------
__multab2000L:
267a : __ __ __ BYT 00 d0 a0 70 40 10 e0 b0                         : ...p@...
--------------------------------------------------------------------
__multab2000H:
2682 : __ __ __ BYT 00 07 0f 17 1f 27 2e 36                         : .....'.6
