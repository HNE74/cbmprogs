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
0811 : a9 e8 __ LDA #$e8
0813 : 85 19 __ STA IP + 0 
0815 : a9 25 __ LDA #$25
0817 : 85 1a __ STA IP + 1 
0819 : 38 __ __ SEC
081a : a9 26 __ LDA #$26
081c : e9 25 __ SBC #$25
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
0830 : a9 44 __ LDA #$44
0832 : e9 e8 __ SBC #$e8
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
0882 : 8d e8 25 STA $25e8 ; (game + 0)
0885 : 20 97 08 JSR $0897 ; (redefine_charset.s0 + 0)
.l3:
0888 : 20 b4 09 JSR $09b4 ; (main_loop.s0 + 0)
088b : ad e8 25 LDA $25e8 ; (game + 0)
088e : f0 f8 __ BEQ $0888 ; (main.l3 + 0)
.s4:
0890 : a9 00 __ LDA #$00
0892 : 85 1b __ STA ACCU + 0 
0894 : 85 1c __ STA ACCU + 1 
.s1001:
0896 : 60 __ __ RTS
--------------------------------------------------------------------
game:
25e8 : __ __ __ BSS	6
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
08b7 : bd 57 25 LDA $2557,x ; (__multab3L + 2)
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
2558 : __ __ __ BYT 80 e0 f8 7f 7f f8 e0 80 00 00 60 3e 3e 60 00 00 : ..........`>>`..
2568 : __ __ __ BYT 00 00 3c 66 66 3c 00 00 1c 7f c6 1f 1f c6 7f 1c : ..<ff<..........
2578 : __ __ __ BYT 00 3c 7e d5 ab 7e 3c 00 28 3c 6e df 5f fe 3c 14 : .<~..~<.(<n._.<.
2588 : __ __ __ BYT 28 56 65 92 69 36 44 2a                         : (Ve.i6D*
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
09c9 : ae ed 25 LDX $25ed ; (game + 5)
09cc : ce ed 25 DEC $25ed ; (game + 5)
09cf : 8a __ __ TXA
09d0 : f0 07 __ BEQ $09d9 ; (main_loop.s3 + 0)
.s4:
09d2 : a9 01 __ LDA #$01
09d4 : 8d e8 25 STA $25e8 ; (game + 0)
09d7 : d0 e1 __ BNE $09ba ; (main_loop.l1 + 0)
.s3:
09d9 : 8d e8 25 STA $25e8 ; (game + 0)
.s1001:
09dc : 60 __ __ RTS
--------------------------------------------------------------------
init_game_state:
.s0:
09dd : a9 01 __ LDA #$01
09df : 8d e8 25 STA $25e8 ; (game + 0)
09e2 : a9 00 __ LDA #$00
09e4 : 8d e9 25 STA $25e9 ; (game + 1)
09e7 : 8d ea 25 STA $25ea ; (game + 2)
09ea : 8d eb 25 STA $25eb ; (game + 3)
09ed : 8d ec 25 STA $25ec ; (game + 4)
09f0 : a9 03 __ LDA #$03
09f2 : 8d ed 25 STA $25ed ; (game + 5)
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
0a0c : a9 ee __ LDA #$ee
0a0e : 85 0d __ STA P0 
0a10 : a9 25 __ LDA #$25
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
0a41 : b9 90 25 LDA $2590,y ; (mul40 + 0)
0a44 : 85 1b __ STA ACCU + 0 
0a46 : 18 __ __ CLC
0a47 : 65 11 __ ADC P4 ; (sx + 0)
0a49 : aa __ __ TAX
0a4a : b9 91 25 LDA $2591,y ; (mul40 + 1)
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
2590 : __ __ __ BYT 00 00 28 00 50 00 78 00 a0 00 c8 00 f0 00 18 01 : ..(.P.x.........
25a0 : __ __ __ BYT 40 01 68 01 90 01 b8 01 e0 01 08 02 30 02 58 02 : @.h.........0.X.
25b0 : __ __ __ BYT 80 02 a8 02 d0 02 f8 02 20 03 48 03 70 03 98 03 : ........ .H.p...
25c0 : __ __ __ BYT c0 03                                           : ..
--------------------------------------------------------------------
cwTop:
25ee : __ __ __ BSS	10
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
08f5 : 8d f8 25 STA $25f8 ; (Player + 0)
08f8 : a9 0c __ LDA #$0c
08fa : 8d f9 25 STA $25f9 ; (Player + 1)
.s1001:
08fd : 60 __ __ RTS
--------------------------------------------------------------------
Player:
25f8 : __ __ __ BSS	2
--------------------------------------------------------------------
init_enemies:
.s0:
0ac9 : a2 00 __ LDX #$00
0acb : a0 0a __ LDY #$0a
.l1002:
0acd : a9 00 __ LDA #$00
0acf : 9d 00 26 STA $2600,x ; (Enemy + 0)
0ad2 : 9d 01 26 STA $2601,x ; (Enemy + 1)
0ad5 : 9d 04 26 STA $2604,x ; (Enemy + 4)
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
2600 : __ __ __ BSS	50
--------------------------------------------------------------------
init_shots:
.s0:
0ae1 : a2 00 __ LDX #$00
0ae3 : a0 03 __ LDY #$03
0ae5 : 8a __ __ TXA
.l1006:
0ae6 : 9d 32 26 STA $2632,x ; (PlayerShot + 0)
0ae9 : 9d 33 26 STA $2633,x ; (PlayerShot + 1)
0aec : 9d 34 26 STA $2634,x ; (PlayerShot + 2)
0aef : e8 __ __ INX
0af0 : e8 __ __ INX
0af1 : e8 __ __ INX
0af2 : 88 __ __ DEY
0af3 : d0 f1 __ BNE $0ae6 ; (init_shots.l1006 + 0)
.s6:
0af5 : a0 03 __ LDY #$03
0af7 : aa __ __ TAX
.l1008:
0af8 : 9d 3b 26 STA $263b,x ; (EnemyShot + 0)
0afb : 9d 3c 26 STA $263c,x ; (EnemyShot + 1)
0afe : 9d 3d 26 STA $263d,x ; (EnemyShot + 2)
0b01 : e8 __ __ INX
0b02 : e8 __ __ INX
0b03 : e8 __ __ INX
0b04 : 88 __ __ DEY
0b05 : d0 f1 __ BNE $0af8 ; (init_shots.l1008 + 0)
.s1001:
0b07 : 60 __ __ RTS
--------------------------------------------------------------------
PlayerShot:
2632 : __ __ __ BSS	9
--------------------------------------------------------------------
EnemyShot:
263b : __ __ __ BSS	9
--------------------------------------------------------------------
run_game:
.s1000:
0b08 : a5 53 __ LDA T0 + 0 
0b0a : 8d cd 9f STA $9fcd ; (run_game@stack + 0)
.s0:
0b0d : ad e8 25 LDA $25e8 ; (game + 0)
0b10 : c9 01 __ CMP #$01
0b12 : d0 59 __ BNE $0b6d ; (run_game.s1001 + 0)
.s7:
0b14 : a9 00 __ LDA #$00
0b16 : 85 53 __ STA T0 + 0 
.l2:
0b18 : 20 73 0b JSR $0b73 ; (render_game_state.s1000 + 0)
0b1b : a5 53 __ LDA T0 + 0 
0b1d : 85 1b __ STA ACCU + 0 
0b1f : a9 00 __ LDA #$00
0b21 : 85 1c __ STA ACCU + 1 
0b23 : 85 04 __ STA WORK + 1 
0b25 : a9 03 __ LDA #$03
0b27 : 85 03 __ STA WORK + 0 
0b29 : 20 7a 23 JSR $237a ; (divmod + 0)
0b2c : a5 05 __ LDA WORK + 2 
0b2e : 05 06 __ ORA WORK + 3 
0b30 : d0 0c __ BNE $0b3e ; (run_game.s6 + 0)
.s4:
0b32 : 20 77 19 JSR $1977 ; (spawn_enemy.s0 + 0)
0b35 : 20 0e 1a JSR $1a0e ; (move_enemies.s0 + 0)
0b38 : 20 86 1b JSR $1b86 ; (render_enemies.s0 + 0)
0b3b : 20 e3 1b JSR $1be3 ; (check_shot_enemy_collision.s0 + 0)
.s6:
0b3e : 20 04 1d JSR $1d04 ; (move_enemy_shots.s0 + 0)
0b41 : 20 31 1b JSR $1b31 ; (render_enemy_shots.s0 + 0)
0b44 : 20 6e 1d JSR $1d6e ; (check_player_enemy_collision.s0 + 0)
0b47 : 20 59 1e JSR $1e59 ; (control_player_ship.s0 + 0)
0b4a : 20 79 1f JSR $1f79 ; (render_player_ship.s0 + 0)
0b4d : 20 6e 1d JSR $1d6e ; (check_player_enemy_collision.s0 + 0)
0b50 : 20 b9 1f JSR $1fb9 ; (move_player_shots.s0 + 0)
0b53 : 20 21 20 JSR $2021 ; (render_player_shots.s0 + 0)
0b56 : 20 e3 1b JSR $1be3 ; (check_shot_enemy_collision.s0 + 0)
0b59 : a9 03 __ LDA #$03
0b5b : 85 0d __ STA P0 
0b5d : a9 00 __ LDA #$00
0b5f : 85 0e __ STA P1 
0b61 : 20 76 20 JSR $2076 ; (wait_frames.s0 + 0)
0b64 : e6 53 __ INC T0 + 0 
0b66 : ad e8 25 LDA $25e8 ; (game + 0)
0b69 : c9 01 __ CMP #$01
0b6b : f0 ab __ BEQ $0b18 ; (run_game.l2 + 0)
.s1001:
0b6d : ad cd 9f LDA $9fcd ; (run_game@stack + 0)
0b70 : 85 53 __ STA T0 + 0 
0b72 : 60 __ __ RTS
--------------------------------------------------------------------
render_game_state:
.s1000:
0b73 : 38 __ __ SEC
0b74 : a5 23 __ LDA SP + 0 
0b76 : e9 0a __ SBC #$0a
0b78 : 85 23 __ STA SP + 0 
0b7a : b0 02 __ BCS $0b7e ; (render_game_state.s0 + 0)
0b7c : c6 24 __ DEC SP + 1 
.s0:
0b7e : a9 01 __ LDA #$01
0b80 : 85 0f __ STA P2 
0b82 : a9 02 __ LDA #$02
0b84 : 85 10 __ STA P3 
0b86 : a9 05 __ LDA #$05
0b88 : 85 13 __ STA P6 
0b8a : a9 ee __ LDA #$ee
0b8c : 85 0d __ STA P0 
0b8e : a9 25 __ LDA #$25
0b90 : 85 0e __ STA P1 
0b92 : a9 9f __ LDA #$9f
0b94 : 85 11 __ STA P4 
0b96 : a9 0c __ LDA #$0c
0b98 : 85 12 __ STA P5 
0b9a : 20 4d 0c JSR $0c4d ; (cwin_putat_string.s0 + 0)
0b9d : a9 ce __ LDA #$ce
0b9f : a0 02 __ LDY #$02
0ba1 : 91 23 __ STA (SP + 0),y 
0ba3 : a9 9f __ LDA #$9f
0ba5 : c8 __ __ INY
0ba6 : 91 23 __ STA (SP + 0),y 
0ba8 : a9 6d __ LDA #$6d
0baa : c8 __ __ INY
0bab : 91 23 __ STA (SP + 0),y 
0bad : a9 19 __ LDA #$19
0baf : c8 __ __ INY
0bb0 : 91 23 __ STA (SP + 0),y 
0bb2 : ad e9 25 LDA $25e9 ; (game + 1)
0bb5 : c8 __ __ INY
0bb6 : 91 23 __ STA (SP + 0),y 
0bb8 : ad ea 25 LDA $25ea ; (game + 2)
0bbb : c8 __ __ INY
0bbc : 91 23 __ STA (SP + 0),y 
0bbe : ad eb 25 LDA $25eb ; (game + 3)
0bc1 : c8 __ __ INY
0bc2 : 91 23 __ STA (SP + 0),y 
0bc4 : ad ec 25 LDA $25ec ; (game + 4)
0bc7 : c8 __ __ INY
0bc8 : 91 23 __ STA (SP + 0),y 
0bca : 20 a6 0c JSR $0ca6 ; (sprintf.s1000 + 0)
0bcd : a9 ee __ LDA #$ee
0bcf : 85 0d __ STA P0 
0bd1 : a9 25 __ LDA #$25
0bd3 : 85 0e __ STA P1 
0bd5 : a9 08 __ LDA #$08
0bd7 : 85 0f __ STA P2 
0bd9 : a9 02 __ LDA #$02
0bdb : 85 10 __ STA P3 
0bdd : a9 ce __ LDA #$ce
0bdf : 85 11 __ STA P4 
0be1 : a9 9f __ LDA #$9f
0be3 : 85 12 __ STA P5 
0be5 : a9 05 __ LDA #$05
0be7 : 85 13 __ STA P6 
0be9 : 20 4d 0c JSR $0c4d ; (cwin_putat_string.s0 + 0)
0bec : a9 20 __ LDA #$20
0bee : 85 0f __ STA P2 
0bf0 : a9 0e __ LDA #$0e
0bf2 : 85 13 __ STA P6 
0bf4 : a9 70 __ LDA #$70
0bf6 : 85 11 __ STA P4 
0bf8 : a9 19 __ LDA #$19
0bfa : 85 12 __ STA P5 
0bfc : 20 4d 0c JSR $0c4d ; (cwin_putat_string.s0 + 0)
0bff : a9 ce __ LDA #$ce
0c01 : a0 02 __ LDY #$02
0c03 : 91 23 __ STA (SP + 0),y 
0c05 : a9 9f __ LDA #$9f
0c07 : c8 __ __ INY
0c08 : 91 23 __ STA (SP + 0),y 
0c0a : a9 6d __ LDA #$6d
0c0c : c8 __ __ INY
0c0d : 91 23 __ STA (SP + 0),y 
0c0f : a9 19 __ LDA #$19
0c11 : c8 __ __ INY
0c12 : 91 23 __ STA (SP + 0),y 
0c14 : ad ed 25 LDA $25ed ; (game + 5)
0c17 : c8 __ __ INY
0c18 : 91 23 __ STA (SP + 0),y 
0c1a : a9 00 __ LDA #$00
0c1c : c8 __ __ INY
0c1d : 91 23 __ STA (SP + 0),y 
0c1f : 20 a6 0c JSR $0ca6 ; (sprintf.s1000 + 0)
0c22 : a9 ee __ LDA #$ee
0c24 : 85 0d __ STA P0 
0c26 : a9 25 __ LDA #$25
0c28 : 85 0e __ STA P1 
0c2a : a9 26 __ LDA #$26
0c2c : 85 0f __ STA P2 
0c2e : a9 02 __ LDA #$02
0c30 : 85 10 __ STA P3 
0c32 : a9 ce __ LDA #$ce
0c34 : 85 11 __ STA P4 
0c36 : a9 9f __ LDA #$9f
0c38 : 85 12 __ STA P5 
0c3a : a9 0e __ LDA #$0e
0c3c : 85 13 __ STA P6 
0c3e : 20 4d 0c JSR $0c4d ; (cwin_putat_string.s0 + 0)
.s1001:
0c41 : 18 __ __ CLC
0c42 : a5 23 __ LDA SP + 0 
0c44 : 69 0a __ ADC #$0a
0c46 : 85 23 __ STA SP + 0 
0c48 : 90 02 __ BCC $0c4c ; (render_game_state.s1001 + 11)
0c4a : e6 24 __ INC SP + 1 
0c4c : 60 __ __ RTS
--------------------------------------------------------------------
cwin_putat_string:
.s0:
0c4d : a5 10 __ LDA P3 ; (y + 0)
0c4f : 0a __ __ ASL
0c50 : aa __ __ TAX
0c51 : bd 90 25 LDA $2590,x ; (mul40 + 0)
0c54 : 18 __ __ CLC
0c55 : 65 0f __ ADC P2 ; (x + 0)
0c57 : 85 1b __ STA ACCU + 0 
0c59 : bd 91 25 LDA $2591,x ; (mul40 + 1)
0c5c : 69 00 __ ADC #$00
0c5e : 85 1c __ STA ACCU + 1 
0c60 : a0 06 __ LDY #$06
0c62 : b1 0d __ LDA (P0),y ; (win + 0)
0c64 : 18 __ __ CLC
0c65 : 65 1b __ ADC ACCU + 0 
0c67 : 85 43 __ STA T3 + 0 
0c69 : c8 __ __ INY
0c6a : b1 0d __ LDA (P0),y ; (win + 0)
0c6c : 65 1c __ ADC ACCU + 1 
0c6e : 85 44 __ STA T3 + 1 
0c70 : c8 __ __ INY
0c71 : b1 0d __ LDA (P0),y ; (win + 0)
0c73 : 18 __ __ CLC
0c74 : 65 1b __ ADC ACCU + 0 
0c76 : 85 1b __ STA ACCU + 0 
0c78 : c8 __ __ INY
0c79 : b1 0d __ LDA (P0),y ; (win + 0)
0c7b : 65 1c __ ADC ACCU + 1 
0c7d : 85 1c __ STA ACCU + 1 
0c7f : a0 00 __ LDY #$00
0c81 : b1 11 __ LDA (P4),y ; (str + 0)
0c83 : f0 18 __ BEQ $0c9d ; (cwin_putat_string.s3 + 0)
.l2:
0c85 : 85 1d __ STA ACCU + 2 
0c87 : 4a __ __ LSR
0c88 : 4a __ __ LSR
0c89 : 4a __ __ LSR
0c8a : 4a __ __ LSR
0c8b : 4a __ __ LSR
0c8c : aa __ __ TAX
0c8d : bd c2 25 LDA $25c2,x ; (p2smap + 0)
0c90 : 45 1d __ EOR ACCU + 2 
0c92 : 91 43 __ STA (T3 + 0),y 
0c94 : a5 13 __ LDA P6 ; (color + 0)
0c96 : 91 1b __ STA (ACCU + 0),y 
0c98 : c8 __ __ INY
0c99 : b1 11 __ LDA (P4),y ; (str + 0)
0c9b : d0 e8 __ BNE $0c85 ; (cwin_putat_string.l2 + 0)
.s3:
0c9d : 98 __ __ TYA
.s1001:
0c9e : 60 __ __ RTS
--------------------------------------------------------------------
p2smap:
25c2 : __ __ __ BYT 00 00 40 20 80 c0 80 80                         : ..@ ....
--------------------------------------------------------------------
0c9f : __ __ __ BYT 53 43 4f 52 45 3a 00                            : SCORE:.
--------------------------------------------------------------------
sprintf:
.s1000:
0ca6 : a5 53 __ LDA T0 + 0 
0ca8 : 8d d8 9f STA $9fd8 ; (sprintf@stack + 0)
0cab : a5 54 __ LDA T0 + 1 
0cad : 8d d9 9f STA $9fd9 ; (sprintf@stack + 1)
.s0:
0cb0 : a9 00 __ LDA #$00
0cb2 : 8d ff 9f STA $9fff ; (sstack + 7)
0cb5 : a0 03 __ LDY #$03
0cb7 : b1 23 __ LDA (SP + 0),y 
0cb9 : 85 54 __ STA T0 + 1 
0cbb : 8d fa 9f STA $9ffa ; (sstack + 2)
0cbe : 88 __ __ DEY
0cbf : b1 23 __ LDA (SP + 0),y 
0cc1 : 85 53 __ STA T0 + 0 
0cc3 : 8d f9 9f STA $9ff9 ; (sstack + 1)
0cc6 : a0 04 __ LDY #$04
0cc8 : b1 23 __ LDA (SP + 0),y 
0cca : 8d fb 9f STA $9ffb ; (sstack + 3)
0ccd : c8 __ __ INY
0cce : b1 23 __ LDA (SP + 0),y 
0cd0 : 8d fc 9f STA $9ffc ; (sstack + 4)
0cd3 : 18 __ __ CLC
0cd4 : a5 23 __ LDA SP + 0 
0cd6 : 69 06 __ ADC #$06
0cd8 : 8d fd 9f STA $9ffd ; (sstack + 5)
0cdb : a5 24 __ LDA SP + 1 
0cdd : 69 00 __ ADC #$00
0cdf : 8d fe 9f STA $9ffe ; (sstack + 6)
0ce2 : 20 fd 0c JSR $0cfd ; (sformat.s1000 + 0)
0ce5 : 38 __ __ SEC
0ce6 : a5 1b __ LDA ACCU + 0 
0ce8 : e5 53 __ SBC T0 + 0 
0cea : 85 1b __ STA ACCU + 0 
0cec : a5 1c __ LDA ACCU + 1 
0cee : e5 54 __ SBC T0 + 1 
0cf0 : 85 1c __ STA ACCU + 1 
.s1001:
0cf2 : ad d8 9f LDA $9fd8 ; (sprintf@stack + 0)
0cf5 : 85 53 __ STA T0 + 0 
0cf7 : ad d9 9f LDA $9fd9 ; (sprintf@stack + 1)
0cfa : 85 54 __ STA T0 + 1 
0cfc : 60 __ __ RTS
--------------------------------------------------------------------
sformat:
.s1000:
0cfd : a2 05 __ LDX #$05
0cff : b5 53 __ LDA T1 + 0,x 
0d01 : 9d da 9f STA $9fda,x ; (sformat@stack + 0)
0d04 : ca __ __ DEX
0d05 : 10 f8 __ BPL $0cff ; (sformat.s1000 + 2)
.s0:
0d07 : a9 00 __ LDA #$00
0d09 : 85 50 __ STA T0 + 0 
0d0b : ad fb 9f LDA $9ffb ; (sstack + 3)
0d0e : 85 53 __ STA T1 + 0 
0d10 : ad fc 9f LDA $9ffc ; (sstack + 4)
0d13 : 85 54 __ STA T1 + 1 
0d15 : ad f9 9f LDA $9ff9 ; (sstack + 1)
0d18 : 85 55 __ STA T2 + 0 
0d1a : ad fa 9f LDA $9ffa ; (sstack + 2)
0d1d : 85 56 __ STA T2 + 1 
.l1:
0d1f : a0 00 __ LDY #$00
0d21 : b1 53 __ LDA (T1 + 0),y 
0d23 : d0 38 __ BNE $0d5d ; (sformat.s2 + 0)
.s3:
0d25 : a4 50 __ LDY T0 + 0 
0d27 : 91 55 __ STA (T2 + 0),y 
0d29 : 98 __ __ TYA
0d2a : f0 28 __ BEQ $0d54 ; (sformat.s1061 + 0)
.s112:
0d2c : ad ff 9f LDA $9fff ; (sstack + 7)
0d2f : d0 18 __ BNE $0d49 ; (sformat.s115 + 0)
.s116:
0d31 : 18 __ __ CLC
0d32 : a5 55 __ LDA T2 + 0 
0d34 : 65 50 __ ADC T0 + 0 
0d36 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0d38 : a5 56 __ LDA T2 + 1 
0d3a : 69 00 __ ADC #$00
.s1001:
0d3c : 85 1c __ STA ACCU + 1 ; (fmt + 0)
0d3e : a2 05 __ LDX #$05
0d40 : bd da 9f LDA $9fda,x ; (sformat@stack + 0)
0d43 : 95 53 __ STA T1 + 0,x 
0d45 : ca __ __ DEX
0d46 : 10 f8 __ BPL $0d40 ; (sformat.s1001 + 4)
0d48 : 60 __ __ RTS
.s115:
0d49 : a5 55 __ LDA T2 + 0 
0d4b : 85 0d __ STA P0 
0d4d : a5 56 __ LDA T2 + 1 
0d4f : 85 0e __ STA P1 
0d51 : 20 41 11 JSR $1141 ; (puts.s0 + 0)
.s1061:
0d54 : a5 55 __ LDA T2 + 0 
0d56 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0d58 : a5 56 __ LDA T2 + 1 
0d5a : 4c 3c 0d JMP $0d3c ; (sformat.s1001 + 0)
.s2:
0d5d : c9 25 __ CMP #$25
0d5f : f0 3f __ BEQ $0da0 ; (sformat.s4 + 0)
.s5:
0d61 : a4 50 __ LDY T0 + 0 
0d63 : 91 55 __ STA (T2 + 0),y 
0d65 : e6 53 __ INC T1 + 0 
0d67 : d0 02 __ BNE $0d6b ; (sformat.s1090 + 0)
.s1089:
0d69 : e6 54 __ INC T1 + 1 
.s1090:
0d6b : c8 __ __ INY
0d6c : 84 50 __ STY T0 + 0 
0d6e : 98 __ __ TYA
0d6f : c0 28 __ CPY #$28
0d71 : 90 ac __ BCC $0d1f ; (sformat.l1 + 0)
.s106:
0d73 : 85 57 __ STA T5 + 0 
0d75 : a9 00 __ LDA #$00
0d77 : 85 50 __ STA T0 + 0 
0d79 : ad ff 9f LDA $9fff ; (sstack + 7)
0d7c : f0 14 __ BEQ $0d92 ; (sformat.s110 + 0)
.s109:
0d7e : a5 55 __ LDA T2 + 0 
0d80 : 85 0d __ STA P0 
0d82 : a5 56 __ LDA T2 + 1 
0d84 : 85 0e __ STA P1 
0d86 : a9 00 __ LDA #$00
0d88 : a4 57 __ LDY T5 + 0 
0d8a : 91 0d __ STA (P0),y 
0d8c : 20 41 11 JSR $1141 ; (puts.s0 + 0)
0d8f : 4c 1f 0d JMP $0d1f ; (sformat.l1 + 0)
.s110:
0d92 : 18 __ __ CLC
0d93 : a5 55 __ LDA T2 + 0 
0d95 : 65 57 __ ADC T5 + 0 
0d97 : 85 55 __ STA T2 + 0 
0d99 : 90 84 __ BCC $0d1f ; (sformat.l1 + 0)
.s1092:
0d9b : e6 56 __ INC T2 + 1 
0d9d : 4c 1f 0d JMP $0d1f ; (sformat.l1 + 0)
.s4:
0da0 : a5 50 __ LDA T0 + 0 
0da2 : f0 27 __ BEQ $0dcb ; (sformat.s9 + 0)
.s7:
0da4 : 84 50 __ STY T0 + 0 
0da6 : 85 57 __ STA T5 + 0 
0da8 : ad ff 9f LDA $9fff ; (sstack + 7)
0dab : f0 13 __ BEQ $0dc0 ; (sformat.s11 + 0)
.s10:
0dad : a5 55 __ LDA T2 + 0 
0daf : 85 0d __ STA P0 
0db1 : a5 56 __ LDA T2 + 1 
0db3 : 85 0e __ STA P1 
0db5 : 98 __ __ TYA
0db6 : a4 57 __ LDY T5 + 0 
0db8 : 91 0d __ STA (P0),y 
0dba : 20 41 11 JSR $1141 ; (puts.s0 + 0)
0dbd : 4c cb 0d JMP $0dcb ; (sformat.s9 + 0)
.s11:
0dc0 : 18 __ __ CLC
0dc1 : a5 55 __ LDA T2 + 0 
0dc3 : 65 57 __ ADC T5 + 0 
0dc5 : 85 55 __ STA T2 + 0 
0dc7 : 90 02 __ BCC $0dcb ; (sformat.s9 + 0)
.s1087:
0dc9 : e6 56 __ INC T2 + 1 
.s9:
0dcb : a9 0a __ LDA #$0a
0dcd : 8d e3 9f STA $9fe3 ; (si + 3)
0dd0 : a9 00 __ LDA #$00
0dd2 : 8d e4 9f STA $9fe4 ; (si + 4)
0dd5 : 8d e5 9f STA $9fe5 ; (si + 5)
0dd8 : 8d e6 9f STA $9fe6 ; (si + 6)
0ddb : 8d e7 9f STA $9fe7 ; (si + 7)
0dde : a0 01 __ LDY #$01
0de0 : b1 53 __ LDA (T1 + 0),y 
0de2 : aa __ __ TAX
0de3 : a9 20 __ LDA #$20
0de5 : 8d e0 9f STA $9fe0 ; (si + 0)
0de8 : a9 00 __ LDA #$00
0dea : 8d e1 9f STA $9fe1 ; (si + 1)
0ded : a9 ff __ LDA #$ff
0def : 8d e2 9f STA $9fe2 ; (si + 2)
0df2 : 18 __ __ CLC
0df3 : a5 53 __ LDA T1 + 0 
0df5 : 69 02 __ ADC #$02
.l14:
0df7 : 85 53 __ STA T1 + 0 
0df9 : 90 02 __ BCC $0dfd ; (sformat.s1074 + 0)
.s1073:
0dfb : e6 54 __ INC T1 + 1 
.s1074:
0dfd : 8a __ __ TXA
0dfe : e0 2b __ CPX #$2b
0e00 : d0 08 __ BNE $0e0a ; (sformat.s17 + 0)
.s16:
0e02 : a9 01 __ LDA #$01
0e04 : 8d e5 9f STA $9fe5 ; (si + 5)
0e07 : 4c 34 11 JMP $1134 ; (sformat.s224 + 0)
.s17:
0e0a : c9 30 __ CMP #$30
0e0c : d0 06 __ BNE $0e14 ; (sformat.s20 + 0)
.s19:
0e0e : 8d e0 9f STA $9fe0 ; (si + 0)
0e11 : 4c 34 11 JMP $1134 ; (sformat.s224 + 0)
.s20:
0e14 : e0 23 __ CPX #$23
0e16 : d0 08 __ BNE $0e20 ; (sformat.s23 + 0)
.s22:
0e18 : a9 01 __ LDA #$01
0e1a : 8d e7 9f STA $9fe7 ; (si + 7)
0e1d : 4c 34 11 JMP $1134 ; (sformat.s224 + 0)
.s23:
0e20 : e0 2d __ CPX #$2d
0e22 : d0 08 __ BNE $0e2c ; (sformat.s15 + 0)
.s25:
0e24 : a9 01 __ LDA #$01
0e26 : 8d e6 9f STA $9fe6 ; (si + 6)
0e29 : 4c 34 11 JMP $1134 ; (sformat.s224 + 0)
.s15:
0e2c : 86 57 __ STX T5 + 0 
0e2e : e0 30 __ CPX #$30
0e30 : 90 53 __ BCC $0e85 ; (sformat.s31 + 0)
.s32:
0e32 : e0 3a __ CPX #$3a
0e34 : b0 4f __ BCS $0e85 ; (sformat.s31 + 0)
.s29:
0e36 : a9 00 __ LDA #$00
0e38 : 85 44 __ STA T6 + 0 
0e3a : 85 45 __ STA T6 + 1 
0e3c : e0 3a __ CPX #$3a
0e3e : b0 40 __ BCS $0e80 ; (sformat.s35 + 0)
.l34:
0e40 : a5 44 __ LDA T6 + 0 
0e42 : 0a __ __ ASL
0e43 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0e45 : a5 45 __ LDA T6 + 1 
0e47 : 2a __ __ ROL
0e48 : 06 1b __ ASL ACCU + 0 ; (buff + 1)
0e4a : 2a __ __ ROL
0e4b : aa __ __ TAX
0e4c : 18 __ __ CLC
0e4d : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0e4f : 65 44 __ ADC T6 + 0 
0e51 : 85 44 __ STA T6 + 0 
0e53 : 8a __ __ TXA
0e54 : 65 45 __ ADC T6 + 1 
0e56 : 06 44 __ ASL T6 + 0 
0e58 : 2a __ __ ROL
0e59 : aa __ __ TAX
0e5a : 18 __ __ CLC
0e5b : a5 44 __ LDA T6 + 0 
0e5d : 65 57 __ ADC T5 + 0 
0e5f : 90 01 __ BCC $0e62 ; (sformat.s1084 + 0)
.s1083:
0e61 : e8 __ __ INX
.s1084:
0e62 : 38 __ __ SEC
0e63 : e9 30 __ SBC #$30
0e65 : 85 44 __ STA T6 + 0 
0e67 : 8a __ __ TXA
0e68 : e9 00 __ SBC #$00
0e6a : 85 45 __ STA T6 + 1 
0e6c : a0 00 __ LDY #$00
0e6e : b1 53 __ LDA (T1 + 0),y 
0e70 : 85 57 __ STA T5 + 0 
0e72 : e6 53 __ INC T1 + 0 
0e74 : d0 02 __ BNE $0e78 ; (sformat.s1086 + 0)
.s1085:
0e76 : e6 54 __ INC T1 + 1 
.s1086:
0e78 : c9 30 __ CMP #$30
0e7a : 90 04 __ BCC $0e80 ; (sformat.s35 + 0)
.s36:
0e7c : c9 3a __ CMP #$3a
0e7e : 90 c0 __ BCC $0e40 ; (sformat.l34 + 0)
.s35:
0e80 : a5 44 __ LDA T6 + 0 
0e82 : 8d e1 9f STA $9fe1 ; (si + 1)
.s31:
0e85 : a5 57 __ LDA T5 + 0 
0e87 : c9 2e __ CMP #$2e
0e89 : d0 51 __ BNE $0edc ; (sformat.s39 + 0)
.s37:
0e8b : a9 00 __ LDA #$00
0e8d : 85 44 __ STA T6 + 0 
.l203:
0e8f : 85 45 __ STA T6 + 1 
0e91 : a0 00 __ LDY #$00
0e93 : b1 53 __ LDA (T1 + 0),y 
0e95 : 85 57 __ STA T5 + 0 
0e97 : e6 53 __ INC T1 + 0 
0e99 : d0 02 __ BNE $0e9d ; (sformat.s1076 + 0)
.s1075:
0e9b : e6 54 __ INC T1 + 1 
.s1076:
0e9d : c9 30 __ CMP #$30
0e9f : 90 04 __ BCC $0ea5 ; (sformat.s42 + 0)
.s43:
0ea1 : c9 3a __ CMP #$3a
0ea3 : 90 0a __ BCC $0eaf ; (sformat.s41 + 0)
.s42:
0ea5 : a5 44 __ LDA T6 + 0 
0ea7 : 8d e2 9f STA $9fe2 ; (si + 2)
0eaa : a5 57 __ LDA T5 + 0 
0eac : 4c dc 0e JMP $0edc ; (sformat.s39 + 0)
.s41:
0eaf : a5 44 __ LDA T6 + 0 
0eb1 : 0a __ __ ASL
0eb2 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0eb4 : a5 45 __ LDA T6 + 1 
0eb6 : 2a __ __ ROL
0eb7 : 06 1b __ ASL ACCU + 0 ; (buff + 1)
0eb9 : 2a __ __ ROL
0eba : aa __ __ TAX
0ebb : 18 __ __ CLC
0ebc : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0ebe : 65 44 __ ADC T6 + 0 
0ec0 : 85 44 __ STA T6 + 0 
0ec2 : 8a __ __ TXA
0ec3 : 65 45 __ ADC T6 + 1 
0ec5 : 06 44 __ ASL T6 + 0 
0ec7 : 2a __ __ ROL
0ec8 : aa __ __ TAX
0ec9 : 18 __ __ CLC
0eca : a5 44 __ LDA T6 + 0 
0ecc : 65 57 __ ADC T5 + 0 
0ece : 90 01 __ BCC $0ed1 ; (sformat.s1082 + 0)
.s1081:
0ed0 : e8 __ __ INX
.s1082:
0ed1 : 38 __ __ SEC
0ed2 : e9 30 __ SBC #$30
0ed4 : 85 44 __ STA T6 + 0 
0ed6 : 8a __ __ TXA
0ed7 : e9 00 __ SBC #$00
0ed9 : 4c 8f 0e JMP $0e8f ; (sformat.l203 + 0)
.s39:
0edc : c9 64 __ CMP #$64
0ede : d0 05 __ BNE $0ee5 ; (sformat.s45 + 0)
.s44:
0ee0 : a9 01 __ LDA #$01
0ee2 : 4c f8 10 JMP $10f8 ; (sformat.s221 + 0)
.s45:
0ee5 : c9 75 __ CMP #$75
0ee7 : d0 03 __ BNE $0eec ; (sformat.s48 + 0)
0ee9 : 4c f6 10 JMP $10f6 ; (sformat.s250 + 0)
.s48:
0eec : c9 78 __ CMP #$78
0eee : d0 0d __ BNE $0efd ; (sformat.s51 + 0)
.s50:
0ef0 : a9 10 __ LDA #$10
0ef2 : 8d e3 9f STA $9fe3 ; (si + 3)
0ef5 : a9 00 __ LDA #$00
0ef7 : 8d e4 9f STA $9fe4 ; (si + 4)
0efa : 4c f6 10 JMP $10f6 ; (sformat.s250 + 0)
.s51:
0efd : c9 6c __ CMP #$6c
0eff : d0 03 __ BNE $0f04 ; (sformat.s54 + 0)
0f01 : 4c 71 10 JMP $1071 ; (sformat.s53 + 0)
.s54:
0f04 : c9 66 __ CMP #$66
0f06 : f0 08 __ BEQ $0f10 ; (sformat.s65 + 0)
.s69:
0f08 : c9 67 __ CMP #$67
0f0a : f0 04 __ BEQ $0f10 ; (sformat.s65 + 0)
.s68:
0f0c : c9 65 __ CMP #$65
0f0e : d0 4d __ BNE $0f5d ; (sformat.s66 + 0)
.s65:
0f10 : a5 55 __ LDA T2 + 0 
0f12 : 85 13 __ STA P6 
0f14 : a5 56 __ LDA T2 + 1 
0f16 : 85 14 __ STA P7 
0f18 : a5 57 __ LDA T5 + 0 
0f1a : 8d f8 9f STA $9ff8 ; (sstack + 0)
0f1d : a9 e0 __ LDA #$e0
0f1f : 85 11 __ STA P4 
0f21 : a9 9f __ LDA #$9f
0f23 : 85 12 __ STA P5 
0f25 : ad fd 9f LDA $9ffd ; (sstack + 5)
0f28 : 85 57 __ STA T5 + 0 
0f2a : ad fe 9f LDA $9ffe ; (sstack + 6)
0f2d : 85 58 __ STA T5 + 1 
0f2f : a0 00 __ LDY #$00
0f31 : b1 57 __ LDA (T5 + 0),y 
0f33 : 85 15 __ STA P8 
0f35 : c8 __ __ INY
0f36 : b1 57 __ LDA (T5 + 0),y 
0f38 : 85 16 __ STA P9 
0f3a : c8 __ __ INY
0f3b : b1 57 __ LDA (T5 + 0),y 
0f3d : 85 17 __ STA P10 
0f3f : c8 __ __ INY
0f40 : b1 57 __ LDA (T5 + 0),y 
0f42 : 85 18 __ STA P11 
0f44 : 20 8d 14 JSR $148d ; (nformf.s0 + 0)
0f47 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0f49 : 85 50 __ STA T0 + 0 
0f4b : 18 __ __ CLC
0f4c : a5 57 __ LDA T5 + 0 
0f4e : 69 04 __ ADC #$04
0f50 : 8d fd 9f STA $9ffd ; (sstack + 5)
0f53 : a5 58 __ LDA T5 + 1 
0f55 : 69 00 __ ADC #$00
0f57 : 8d fe 9f STA $9ffe ; (sstack + 6)
0f5a : 4c 1f 0d JMP $0d1f ; (sformat.l1 + 0)
.s66:
0f5d : c9 73 __ CMP #$73
0f5f : f0 4c __ BEQ $0fad ; (sformat.s70 + 0)
.s71:
0f61 : c9 63 __ CMP #$63
0f63 : f0 1f __ BEQ $0f84 ; (sformat.s100 + 0)
.s101:
0f65 : 09 00 __ ORA #$00
0f67 : d0 03 __ BNE $0f6c ; (sformat.s103 + 0)
0f69 : 4c 1f 0d JMP $0d1f ; (sformat.l1 + 0)
.s103:
0f6c : 18 __ __ CLC
0f6d : a5 55 __ LDA T2 + 0 
0f6f : 65 50 __ ADC T0 + 0 
0f71 : 85 44 __ STA T6 + 0 
0f73 : a5 56 __ LDA T2 + 1 
0f75 : 69 00 __ ADC #$00
0f77 : 85 45 __ STA T6 + 1 
0f79 : a5 57 __ LDA T5 + 0 
.s1059:
0f7b : a0 00 __ LDY #$00
0f7d : 91 44 __ STA (T6 + 0),y 
0f7f : e6 50 __ INC T0 + 0 
0f81 : 4c 1f 0d JMP $0d1f ; (sformat.l1 + 0)
.s100:
0f84 : ad fd 9f LDA $9ffd ; (sstack + 5)
0f87 : 85 57 __ STA T5 + 0 
0f89 : 18 __ __ CLC
0f8a : 69 02 __ ADC #$02
0f8c : 8d fd 9f STA $9ffd ; (sstack + 5)
0f8f : ad fe 9f LDA $9ffe ; (sstack + 6)
0f92 : 85 58 __ STA T5 + 1 
0f94 : 69 00 __ ADC #$00
0f96 : 8d fe 9f STA $9ffe ; (sstack + 6)
0f99 : 18 __ __ CLC
0f9a : a5 55 __ LDA T2 + 0 
0f9c : 65 50 __ ADC T0 + 0 
0f9e : 85 44 __ STA T6 + 0 
0fa0 : a5 56 __ LDA T2 + 1 
0fa2 : 69 00 __ ADC #$00
0fa4 : 85 45 __ STA T6 + 1 
0fa6 : a0 00 __ LDY #$00
0fa8 : b1 57 __ LDA (T5 + 0),y 
0faa : 4c 7b 0f JMP $0f7b ; (sformat.s1059 + 0)
.s70:
0fad : ad fd 9f LDA $9ffd ; (sstack + 5)
0fb0 : 85 57 __ STA T5 + 0 
0fb2 : 18 __ __ CLC
0fb3 : 69 02 __ ADC #$02
0fb5 : 8d fd 9f STA $9ffd ; (sstack + 5)
0fb8 : ad fe 9f LDA $9ffe ; (sstack + 6)
0fbb : 85 58 __ STA T5 + 1 
0fbd : 69 00 __ ADC #$00
0fbf : 8d fe 9f STA $9ffe ; (sstack + 6)
0fc2 : a0 00 __ LDY #$00
0fc4 : b1 57 __ LDA (T5 + 0),y 
0fc6 : aa __ __ TAX
0fc7 : c8 __ __ INY
0fc8 : b1 57 __ LDA (T5 + 0),y 
0fca : 86 57 __ STX T5 + 0 
0fcc : 85 58 __ STA T5 + 1 
0fce : a9 00 __ LDA #$00
0fd0 : 85 52 __ STA T3 + 0 
0fd2 : ad e1 9f LDA $9fe1 ; (si + 1)
0fd5 : f0 0c __ BEQ $0fe3 ; (sformat.s75 + 0)
.s1065:
0fd7 : 88 __ __ DEY
0fd8 : b1 57 __ LDA (T5 + 0),y 
0fda : f0 05 __ BEQ $0fe1 ; (sformat.s1066 + 0)
.l77:
0fdc : c8 __ __ INY
0fdd : b1 57 __ LDA (T5 + 0),y 
0fdf : d0 fb __ BNE $0fdc ; (sformat.l77 + 0)
.s1066:
0fe1 : 84 52 __ STY T3 + 0 
.s75:
0fe3 : ad e6 9f LDA $9fe6 ; (si + 6)
0fe6 : d0 19 __ BNE $1001 ; (sformat.s81 + 0)
.s1069:
0fe8 : a6 52 __ LDX T3 + 0 
0fea : ec e1 9f CPX $9fe1 ; (si + 1)
0fed : a4 50 __ LDY T0 + 0 
0fef : b0 0c __ BCS $0ffd ; (sformat.s1070 + 0)
.l83:
0ff1 : ad e0 9f LDA $9fe0 ; (si + 0)
0ff4 : 91 55 __ STA (T2 + 0),y 
0ff6 : e8 __ __ INX
0ff7 : ec e1 9f CPX $9fe1 ; (si + 1)
0ffa : c8 __ __ INY
0ffb : 90 f4 __ BCC $0ff1 ; (sformat.l83 + 0)
.s1070:
0ffd : 86 52 __ STX T3 + 0 
0fff : 84 50 __ STY T0 + 0 
.s81:
1001 : ad ff 9f LDA $9fff ; (sstack + 7)
1004 : d0 37 __ BNE $103d ; (sformat.s85 + 0)
.l91:
1006 : a0 00 __ LDY #$00
1008 : b1 57 __ LDA (T5 + 0),y 
100a : f0 0f __ BEQ $101b ; (sformat.s211 + 0)
.s92:
100c : a4 50 __ LDY T0 + 0 
100e : 91 55 __ STA (T2 + 0),y 
1010 : e6 50 __ INC T0 + 0 
1012 : e6 57 __ INC T5 + 0 
1014 : d0 f0 __ BNE $1006 ; (sformat.l91 + 0)
.s1079:
1016 : e6 58 __ INC T5 + 1 
1018 : 4c 06 10 JMP $1006 ; (sformat.l91 + 0)
.s211:
101b : ad e6 9f LDA $9fe6 ; (si + 6)
101e : d0 03 __ BNE $1023 ; (sformat.s1067 + 0)
1020 : 4c 1f 0d JMP $0d1f ; (sformat.l1 + 0)
.s1067:
1023 : a6 52 __ LDX T3 + 0 
1025 : ec e1 9f CPX $9fe1 ; (si + 1)
1028 : a4 50 __ LDY T0 + 0 
102a : b0 0c __ BCS $1038 ; (sformat.s1068 + 0)
.l98:
102c : ad e0 9f LDA $9fe0 ; (si + 0)
102f : 91 55 __ STA (T2 + 0),y 
1031 : e8 __ __ INX
1032 : ec e1 9f CPX $9fe1 ; (si + 1)
1035 : c8 __ __ INY
1036 : 90 f4 __ BCC $102c ; (sformat.l98 + 0)
.s1068:
1038 : 84 50 __ STY T0 + 0 
103a : 4c 1f 0d JMP $0d1f ; (sformat.l1 + 0)
.s85:
103d : a5 50 __ LDA T0 + 0 
103f : f0 22 __ BEQ $1063 ; (sformat.s90 + 0)
.s88:
1041 : a5 55 __ LDA T2 + 0 
1043 : 85 0d __ STA P0 
1045 : a5 56 __ LDA T2 + 1 
1047 : 85 0e __ STA P1 
1049 : a9 00 __ LDA #$00
104b : a4 50 __ LDY T0 + 0 
104d : 91 0d __ STA (P0),y 
104f : 20 41 11 JSR $1141 ; (puts.s0 + 0)
1052 : a5 57 __ LDA T5 + 0 
1054 : 85 0d __ STA P0 
1056 : a5 58 __ LDA T5 + 1 
1058 : 85 0e __ STA P1 
105a : 20 41 11 JSR $1141 ; (puts.s0 + 0)
105d : a9 00 __ LDA #$00
105f : 85 50 __ STA T0 + 0 
1061 : f0 b8 __ BEQ $101b ; (sformat.s211 + 0)
.s90:
1063 : a5 57 __ LDA T5 + 0 
1065 : 85 0d __ STA P0 
1067 : a5 58 __ LDA T5 + 1 
1069 : 85 0e __ STA P1 
106b : 20 41 11 JSR $1141 ; (puts.s0 + 0)
106e : 4c 1b 10 JMP $101b ; (sformat.s211 + 0)
.s53:
1071 : ad fd 9f LDA $9ffd ; (sstack + 5)
1074 : 85 57 __ STA T5 + 0 
1076 : 18 __ __ CLC
1077 : 69 04 __ ADC #$04
1079 : 8d fd 9f STA $9ffd ; (sstack + 5)
107c : ad fe 9f LDA $9ffe ; (sstack + 6)
107f : 85 58 __ STA T5 + 1 
1081 : 69 00 __ ADC #$00
1083 : 8d fe 9f STA $9ffe ; (sstack + 6)
1086 : a0 00 __ LDY #$00
1088 : b1 53 __ LDA (T1 + 0),y 
108a : 85 52 __ STA T3 + 0 
108c : e6 53 __ INC T1 + 0 
108e : d0 02 __ BNE $1092 ; (sformat.s1078 + 0)
.s1077:
1090 : e6 54 __ INC T1 + 1 
.s1078:
1092 : c9 64 __ CMP #$64
1094 : d0 04 __ BNE $109a ; (sformat.s1019 + 0)
.s1018:
1096 : a2 01 __ LDX #$01
1098 : d0 02 __ BNE $109c ; (sformat.s1020 + 0)
.s1019:
109a : a2 00 __ LDX #$00
.s1020:
109c : b1 57 __ LDA (T5 + 0),y 
109e : 85 46 __ STA T7 + 0 
10a0 : a0 01 __ LDY #$01
10a2 : b1 57 __ LDA (T5 + 0),y 
10a4 : 85 47 __ STA T7 + 1 
10a6 : c8 __ __ INY
10a7 : b1 57 __ LDA (T5 + 0),y 
10a9 : 85 48 __ STA T7 + 2 
10ab : c8 __ __ INY
10ac : b1 57 __ LDA (T5 + 0),y 
10ae : a8 __ __ TAY
10af : 8a __ __ TXA
10b0 : f0 04 __ BEQ $10b6 ; (sformat.s57 + 0)
.s56:
10b2 : a9 01 __ LDA #$01
10b4 : d0 16 __ BNE $10cc ; (sformat.s222 + 0)
.s57:
10b6 : a5 52 __ LDA T3 + 0 
10b8 : c9 75 __ CMP #$75
10ba : f0 0f __ BEQ $10cb ; (sformat.s251 + 0)
.s60:
10bc : c9 78 __ CMP #$78
10be : f0 03 __ BEQ $10c3 ; (sformat.s62 + 0)
10c0 : 4c 1f 0d JMP $0d1f ; (sformat.l1 + 0)
.s62:
10c3 : 8e e4 9f STX $9fe4 ; (si + 4)
10c6 : a9 10 __ LDA #$10
10c8 : 8d e3 9f STA $9fe3 ; (si + 3)
.s251:
10cb : 8a __ __ TXA
.s222:
10cc : 84 14 __ STY P7 
10ce : 85 15 __ STA P8 
10d0 : a5 55 __ LDA T2 + 0 
10d2 : 85 0f __ STA P2 
10d4 : a5 56 __ LDA T2 + 1 
10d6 : 85 10 __ STA P3 
10d8 : a5 46 __ LDA T7 + 0 
10da : 85 11 __ STA P4 
10dc : a5 47 __ LDA T7 + 1 
10de : 85 12 __ STA P5 
10e0 : a5 48 __ LDA T7 + 2 
10e2 : 85 13 __ STA P6 
10e4 : a9 e0 __ LDA #$e0
10e6 : 85 0d __ STA P0 
10e8 : a9 9f __ LDA #$9f
10ea : 85 0e __ STA P1 
10ec : 20 f5 12 JSR $12f5 ; (nforml.s0 + 0)
.s1062:
10ef : a5 1b __ LDA ACCU + 0 ; (buff + 1)
10f1 : 85 50 __ STA T0 + 0 
10f3 : 4c 1f 0d JMP $0d1f ; (sformat.l1 + 0)
.s250:
10f6 : a9 00 __ LDA #$00
.s221:
10f8 : 85 13 __ STA P6 
10fa : a5 55 __ LDA T2 + 0 
10fc : 85 0f __ STA P2 
10fe : a5 56 __ LDA T2 + 1 
1100 : 85 10 __ STA P3 
1102 : ad fd 9f LDA $9ffd ; (sstack + 5)
1105 : 85 50 __ STA T0 + 0 
1107 : ad fe 9f LDA $9ffe ; (sstack + 6)
110a : 85 51 __ STA T0 + 1 
110c : a0 00 __ LDY #$00
110e : b1 50 __ LDA (T0 + 0),y 
1110 : 85 11 __ STA P4 
1112 : c8 __ __ INY
1113 : b1 50 __ LDA (T0 + 0),y 
1115 : 85 12 __ STA P5 
1117 : 18 __ __ CLC
1118 : a5 50 __ LDA T0 + 0 
111a : 69 02 __ ADC #$02
111c : 8d fd 9f STA $9ffd ; (sstack + 5)
111f : a5 51 __ LDA T0 + 1 
1121 : 69 00 __ ADC #$00
1123 : 8d fe 9f STA $9ffe ; (sstack + 6)
1126 : a9 e0 __ LDA #$e0
1128 : 85 0d __ STA P0 
112a : a9 9f __ LDA #$9f
112c : 85 0e __ STA P1 
112e : 20 96 11 JSR $1196 ; (nformi.s0 + 0)
1131 : 4c ef 10 JMP $10ef ; (sformat.s1062 + 0)
.s224:
1134 : a0 00 __ LDY #$00
1136 : b1 53 __ LDA (T1 + 0),y 
1138 : aa __ __ TAX
1139 : 18 __ __ CLC
113a : a5 53 __ LDA T1 + 0 
113c : 69 01 __ ADC #$01
113e : 4c f7 0d JMP $0df7 ; (sformat.l14 + 0)
--------------------------------------------------------------------
puts:
.s0:
1141 : a0 00 __ LDY #$00
1143 : b1 0d __ LDA (P0),y 
1145 : f0 0b __ BEQ $1152 ; (puts.s1001 + 0)
1147 : 20 53 11 JSR $1153 ; (putpch + 0)
114a : e6 0d __ INC P0 
114c : d0 f3 __ BNE $1141 ; (puts.s0 + 0)
114e : e6 0e __ INC P1 
1150 : d0 ef __ BNE $1141 ; (puts.s0 + 0)
.s1001:
1152 : 60 __ __ RTS
--------------------------------------------------------------------
putpch:
1153 : ae ff 08 LDX $08ff ; (giocharmap + 0)
1156 : e0 01 __ CPX #$01
1158 : 90 26 __ BCC $1180 ; (putpch + 45)
115a : c9 0a __ CMP #$0a
115c : d0 02 __ BNE $1160 ; (putpch + 13)
115e : a9 0d __ LDA #$0d
1160 : c9 09 __ CMP #$09
1162 : f0 1f __ BEQ $1183 ; (putpch + 48)
1164 : e0 02 __ CPX #$02
1166 : 90 18 __ BCC $1180 ; (putpch + 45)
1168 : c9 41 __ CMP #$41
116a : 90 14 __ BCC $1180 ; (putpch + 45)
116c : c9 7b __ CMP #$7b
116e : b0 10 __ BCS $1180 ; (putpch + 45)
1170 : c9 61 __ CMP #$61
1172 : b0 04 __ BCS $1178 ; (putpch + 37)
1174 : c9 5b __ CMP #$5b
1176 : b0 08 __ BCS $1180 ; (putpch + 45)
1178 : 49 20 __ EOR #$20
117a : e0 03 __ CPX #$03
117c : f0 02 __ BEQ $1180 ; (putpch + 45)
117e : 29 df __ AND #$df
1180 : 4c d2 ff JMP $ffd2 
1183 : 38 __ __ SEC
1184 : 20 f0 ff JSR $fff0 
1187 : 98 __ __ TYA
1188 : 29 03 __ AND #$03
118a : 49 03 __ EOR #$03
118c : aa __ __ TAX
118d : a9 20 __ LDA #$20
118f : 20 d2 ff JSR $ffd2 
1192 : ca __ __ DEX
1193 : 10 fa __ BPL $118f ; (putpch + 60)
1195 : 60 __ __ RTS
--------------------------------------------------------------------
giocharmap:
08ff : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
nformi:
.s0:
1196 : a9 00 __ LDA #$00
1198 : 85 43 __ STA T0 + 0 
119a : a5 13 __ LDA P6 ; (s + 0)
119c : f0 15 __ BEQ $11b3 ; (nformi.s159 + 0)
.s4:
119e : a5 12 __ LDA P5 ; (v + 1)
11a0 : 10 11 __ BPL $11b3 ; (nformi.s159 + 0)
.s1:
11a2 : 38 __ __ SEC
11a3 : a9 00 __ LDA #$00
11a5 : e5 11 __ SBC P4 ; (v + 0)
11a7 : 85 11 __ STA P4 ; (v + 0)
11a9 : a9 00 __ LDA #$00
11ab : e5 12 __ SBC P5 ; (v + 1)
11ad : 85 12 __ STA P5 ; (v + 1)
11af : a9 01 __ LDA #$01
11b1 : 85 43 __ STA T0 + 0 
.s159:
11b3 : a9 10 __ LDA #$10
11b5 : 85 44 __ STA T2 + 0 
11b7 : a5 11 __ LDA P4 ; (v + 0)
11b9 : 05 12 __ ORA P5 ; (v + 1)
11bb : f0 61 __ BEQ $121e ; (nformi.s7 + 0)
.s45:
11bd : a5 0d __ LDA P0 ; (si + 0)
11bf : 85 45 __ STA T4 + 0 
11c1 : a5 0e __ LDA P1 ; (si + 1)
11c3 : 85 46 __ STA T4 + 1 
.l6:
11c5 : a0 03 __ LDY #$03
11c7 : b1 45 __ LDA (T4 + 0),y 
11c9 : 85 47 __ STA T5 + 0 
11cb : 85 03 __ STA WORK + 0 
11cd : c8 __ __ INY
11ce : b1 45 __ LDA (T4 + 0),y 
11d0 : 85 48 __ STA T5 + 1 
11d2 : 85 04 __ STA WORK + 1 
11d4 : a5 11 __ LDA P4 ; (v + 0)
11d6 : 85 1b __ STA ACCU + 0 
11d8 : a5 12 __ LDA P5 ; (v + 1)
11da : 85 1c __ STA ACCU + 1 
11dc : 20 7a 23 JSR $237a ; (divmod + 0)
11df : a5 06 __ LDA WORK + 3 
11e1 : 30 10 __ BMI $11f3 ; (nformi.s9 + 0)
.s1019:
11e3 : d0 06 __ BNE $11eb ; (nformi.s8 + 0)
.s1018:
11e5 : a5 05 __ LDA WORK + 2 
11e7 : c9 0a __ CMP #$0a
11e9 : 90 08 __ BCC $11f3 ; (nformi.s9 + 0)
.s8:
11eb : 18 __ __ CLC
11ec : a5 05 __ LDA WORK + 2 
11ee : 69 37 __ ADC #$37
11f0 : 4c f8 11 JMP $11f8 ; (nformi.s10 + 0)
.s9:
11f3 : 18 __ __ CLC
11f4 : a5 05 __ LDA WORK + 2 
11f6 : 69 30 __ ADC #$30
.s10:
11f8 : c6 44 __ DEC T2 + 0 
11fa : a6 44 __ LDX T2 + 0 
11fc : 9d e8 9f STA $9fe8,x ; (buffer + 0)
11ff : a5 11 __ LDA P4 ; (v + 0)
1201 : 85 1b __ STA ACCU + 0 
1203 : a5 12 __ LDA P5 ; (v + 1)
1205 : 85 1c __ STA ACCU + 1 
1207 : a5 47 __ LDA T5 + 0 
1209 : 85 03 __ STA WORK + 0 
120b : a5 48 __ LDA T5 + 1 
120d : 85 04 __ STA WORK + 1 
120f : 20 7a 23 JSR $237a ; (divmod + 0)
1212 : a5 1b __ LDA ACCU + 0 
1214 : 85 11 __ STA P4 ; (v + 0)
1216 : a5 1c __ LDA ACCU + 1 
1218 : 85 12 __ STA P5 ; (v + 1)
121a : 05 11 __ ORA P4 ; (v + 0)
121c : d0 a7 __ BNE $11c5 ; (nformi.l6 + 0)
.s7:
121e : a5 0d __ LDA P0 ; (si + 0)
1220 : 85 11 __ STA P4 ; (v + 0)
1222 : a5 0e __ LDA P1 ; (si + 1)
1224 : 85 12 __ STA P5 ; (v + 1)
1226 : a0 02 __ LDY #$02
1228 : b1 0d __ LDA (P0),y ; (si + 0)
122a : c9 ff __ CMP #$ff
122c : d0 04 __ BNE $1232 ; (nformi.s76 + 0)
.s77:
122e : a9 0f __ LDA #$0f
1230 : d0 05 __ BNE $1237 ; (nformi.s1026 + 0)
.s76:
1232 : 38 __ __ SEC
1233 : a9 10 __ LDA #$10
1235 : f1 0d __ SBC (P0),y ; (si + 0)
.s1026:
1237 : a8 __ __ TAY
1238 : c4 44 __ CPY T2 + 0 
123a : b0 0d __ BCS $1249 ; (nformi.s13 + 0)
.s12:
123c : a9 30 __ LDA #$30
.l1027:
123e : c6 44 __ DEC T2 + 0 
1240 : a6 44 __ LDX T2 + 0 
1242 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1245 : c4 44 __ CPY T2 + 0 
1247 : 90 f5 __ BCC $123e ; (nformi.l1027 + 0)
.s13:
1249 : a0 07 __ LDY #$07
124b : b1 0d __ LDA (P0),y ; (si + 0)
124d : f0 20 __ BEQ $126f ; (nformi.s16 + 0)
.s17:
124f : a0 04 __ LDY #$04
1251 : b1 0d __ LDA (P0),y ; (si + 0)
1253 : d0 1a __ BNE $126f ; (nformi.s16 + 0)
.s1013:
1255 : 88 __ __ DEY
1256 : b1 0d __ LDA (P0),y ; (si + 0)
1258 : c9 10 __ CMP #$10
125a : d0 13 __ BNE $126f ; (nformi.s16 + 0)
.s14:
125c : a9 58 __ LDA #$58
125e : a6 44 __ LDX T2 + 0 
1260 : 9d e7 9f STA $9fe7,x ; (si + 7)
1263 : 8a __ __ TXA
1264 : 18 __ __ CLC
1265 : 69 fe __ ADC #$fe
1267 : 85 44 __ STA T2 + 0 
1269 : aa __ __ TAX
126a : a9 30 __ LDA #$30
126c : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s16:
126f : a9 00 __ LDA #$00
1271 : 85 1b __ STA ACCU + 0 
1273 : a5 43 __ LDA T0 + 0 
1275 : f0 06 __ BEQ $127d ; (nformi.s19 + 0)
.s18:
1277 : c6 44 __ DEC T2 + 0 
1279 : a9 2d __ LDA #$2d
127b : d0 0a __ BNE $1287 ; (nformi.s1025 + 0)
.s19:
127d : a0 05 __ LDY #$05
127f : b1 0d __ LDA (P0),y ; (si + 0)
1281 : f0 09 __ BEQ $128c ; (nformi.s141 + 0)
.s21:
1283 : c6 44 __ DEC T2 + 0 
1285 : a9 2b __ LDA #$2b
.s1025:
1287 : a6 44 __ LDX T2 + 0 
1289 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s141:
128c : a0 06 __ LDY #$06
128e : b1 0d __ LDA (P0),y ; (si + 0)
1290 : d0 37 __ BNE $12c9 ; (nformi.s27 + 0)
.l33:
1292 : a0 01 __ LDY #$01
1294 : b1 11 __ LDA (P4),y ; (v + 0)
1296 : 18 __ __ CLC
1297 : 65 44 __ ADC T2 + 0 
1299 : b0 04 __ BCS $129f ; (nformi.s34 + 0)
.s1006:
129b : c9 11 __ CMP #$11
129d : 90 0e __ BCC $12ad ; (nformi.s36 + 0)
.s34:
129f : c6 44 __ DEC T2 + 0 
12a1 : a0 00 __ LDY #$00
12a3 : b1 11 __ LDA (P4),y ; (v + 0)
12a5 : a6 44 __ LDX T2 + 0 
12a7 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
12aa : 4c 92 12 JMP $1292 ; (nformi.l33 + 0)
.s36:
12ad : a6 44 __ LDX T2 + 0 
12af : e0 10 __ CPX #$10
12b1 : b0 11 __ BCS $12c4 ; (nformi.s26 + 0)
.s1022:
12b3 : 88 __ __ DEY
.l1031:
12b4 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
12b7 : 91 0f __ STA (P2),y ; (str + 0)
12b9 : e6 44 __ INC T2 + 0 
12bb : a6 44 __ LDX T2 + 0 
12bd : e0 10 __ CPX #$10
12bf : c8 __ __ INY
12c0 : 90 f2 __ BCC $12b4 ; (nformi.l1031 + 0)
.s1032:
12c2 : 84 1b __ STY ACCU + 0 
.s26:
12c4 : a9 00 __ LDA #$00
12c6 : 85 1c __ STA ACCU + 1 
.s1001:
12c8 : 60 __ __ RTS
.s27:
12c9 : a6 44 __ LDX T2 + 0 
12cb : e0 10 __ CPX #$10
12cd : b0 12 __ BCS $12e1 ; (nformi.l30 + 0)
.s1020:
12cf : a0 00 __ LDY #$00
.l1029:
12d1 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
12d4 : 91 0f __ STA (P2),y ; (str + 0)
12d6 : e6 44 __ INC T2 + 0 
12d8 : a6 44 __ LDX T2 + 0 
12da : e0 10 __ CPX #$10
12dc : c8 __ __ INY
12dd : 90 f2 __ BCC $12d1 ; (nformi.l1029 + 0)
.s1030:
12df : 84 1b __ STY ACCU + 0 
.l30:
12e1 : a5 1b __ LDA ACCU + 0 
12e3 : a0 01 __ LDY #$01
12e5 : d1 11 __ CMP (P4),y ; (v + 0)
12e7 : b0 db __ BCS $12c4 ; (nformi.s26 + 0)
.s31:
12e9 : 88 __ __ DEY
12ea : b1 11 __ LDA (P4),y ; (v + 0)
12ec : a4 1b __ LDY ACCU + 0 
12ee : 91 0f __ STA (P2),y ; (str + 0)
12f0 : e6 1b __ INC ACCU + 0 
12f2 : 4c e1 12 JMP $12e1 ; (nformi.l30 + 0)
--------------------------------------------------------------------
nforml:
.s0:
12f5 : a9 00 __ LDA #$00
12f7 : 85 43 __ STA T0 + 0 
12f9 : a5 15 __ LDA P8 ; (s + 0)
12fb : f0 23 __ BEQ $1320 ; (nforml.s159 + 0)
.s4:
12fd : a5 14 __ LDA P7 ; (v + 3)
12ff : f0 1f __ BEQ $1320 ; (nforml.s159 + 0)
.s1032:
1301 : 10 1d __ BPL $1320 ; (nforml.s159 + 0)
.s1:
1303 : 38 __ __ SEC
1304 : a9 00 __ LDA #$00
1306 : e5 11 __ SBC P4 ; (v + 0)
1308 : 85 11 __ STA P4 ; (v + 0)
130a : a9 00 __ LDA #$00
130c : e5 12 __ SBC P5 ; (v + 1)
130e : 85 12 __ STA P5 ; (v + 1)
1310 : a9 00 __ LDA #$00
1312 : e5 13 __ SBC P6 ; (v + 2)
1314 : 85 13 __ STA P6 ; (v + 2)
1316 : a9 00 __ LDA #$00
1318 : e5 14 __ SBC P7 ; (v + 3)
131a : 85 14 __ STA P7 ; (v + 3)
131c : a9 01 __ LDA #$01
131e : 85 43 __ STA T0 + 0 
.s159:
1320 : a9 10 __ LDA #$10
1322 : 85 44 __ STA T2 + 0 
1324 : a5 14 __ LDA P7 ; (v + 3)
1326 : f0 03 __ BEQ $132b ; (nforml.s1018 + 0)
1328 : 4c 0f 14 JMP $140f ; (nforml.l6 + 0)
.s1018:
132b : a5 13 __ LDA P6 ; (v + 2)
132d : f0 03 __ BEQ $1332 ; (nforml.s1019 + 0)
132f : 4c 0f 14 JMP $140f ; (nforml.l6 + 0)
.s1019:
1332 : a5 12 __ LDA P5 ; (v + 1)
1334 : f0 03 __ BEQ $1339 ; (nforml.s1020 + 0)
1336 : 4c 0f 14 JMP $140f ; (nforml.l6 + 0)
.s1020:
1339 : c5 11 __ CMP P4 ; (v + 0)
133b : b0 03 __ BCS $1340 ; (nforml.s7 + 0)
133d : 4c 0f 14 JMP $140f ; (nforml.l6 + 0)
.s7:
1340 : a0 02 __ LDY #$02
1342 : b1 0d __ LDA (P0),y ; (si + 0)
1344 : c9 ff __ CMP #$ff
1346 : d0 04 __ BNE $134c ; (nforml.s76 + 0)
.s77:
1348 : a9 0f __ LDA #$0f
134a : d0 05 __ BNE $1351 ; (nforml.s1039 + 0)
.s76:
134c : 38 __ __ SEC
134d : a9 10 __ LDA #$10
134f : f1 0d __ SBC (P0),y ; (si + 0)
.s1039:
1351 : a8 __ __ TAY
1352 : c4 44 __ CPY T2 + 0 
1354 : b0 0d __ BCS $1363 ; (nforml.s13 + 0)
.s12:
1356 : a9 30 __ LDA #$30
.l1040:
1358 : c6 44 __ DEC T2 + 0 
135a : a6 44 __ LDX T2 + 0 
135c : 9d e8 9f STA $9fe8,x ; (buffer + 0)
135f : c4 44 __ CPY T2 + 0 
1361 : 90 f5 __ BCC $1358 ; (nforml.l1040 + 0)
.s13:
1363 : a0 07 __ LDY #$07
1365 : b1 0d __ LDA (P0),y ; (si + 0)
1367 : f0 20 __ BEQ $1389 ; (nforml.s16 + 0)
.s17:
1369 : a0 04 __ LDY #$04
136b : b1 0d __ LDA (P0),y ; (si + 0)
136d : d0 1a __ BNE $1389 ; (nforml.s16 + 0)
.s1013:
136f : 88 __ __ DEY
1370 : b1 0d __ LDA (P0),y ; (si + 0)
1372 : c9 10 __ CMP #$10
1374 : d0 13 __ BNE $1389 ; (nforml.s16 + 0)
.s14:
1376 : a9 58 __ LDA #$58
1378 : a6 44 __ LDX T2 + 0 
137a : 9d e7 9f STA $9fe7,x ; (si + 7)
137d : 8a __ __ TXA
137e : 18 __ __ CLC
137f : 69 fe __ ADC #$fe
1381 : 85 44 __ STA T2 + 0 
1383 : aa __ __ TAX
1384 : a9 30 __ LDA #$30
1386 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s16:
1389 : a9 00 __ LDA #$00
138b : 85 1b __ STA ACCU + 0 
138d : a5 43 __ LDA T0 + 0 
138f : f0 06 __ BEQ $1397 ; (nforml.s19 + 0)
.s18:
1391 : c6 44 __ DEC T2 + 0 
1393 : a9 2d __ LDA #$2d
1395 : d0 0a __ BNE $13a1 ; (nforml.s1038 + 0)
.s19:
1397 : a0 05 __ LDY #$05
1399 : b1 0d __ LDA (P0),y ; (si + 0)
139b : f0 09 __ BEQ $13a6 ; (nforml.s141 + 0)
.s21:
139d : c6 44 __ DEC T2 + 0 
139f : a9 2b __ LDA #$2b
.s1038:
13a1 : a6 44 __ LDX T2 + 0 
13a3 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s141:
13a6 : a0 06 __ LDY #$06
13a8 : b1 0d __ LDA (P0),y ; (si + 0)
13aa : d0 37 __ BNE $13e3 ; (nforml.s27 + 0)
.l33:
13ac : a0 01 __ LDY #$01
13ae : b1 0d __ LDA (P0),y ; (si + 0)
13b0 : 18 __ __ CLC
13b1 : 65 44 __ ADC T2 + 0 
13b3 : b0 04 __ BCS $13b9 ; (nforml.s34 + 0)
.s1006:
13b5 : c9 11 __ CMP #$11
13b7 : 90 0e __ BCC $13c7 ; (nforml.s36 + 0)
.s34:
13b9 : c6 44 __ DEC T2 + 0 
13bb : a0 00 __ LDY #$00
13bd : b1 0d __ LDA (P0),y ; (si + 0)
13bf : a6 44 __ LDX T2 + 0 
13c1 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
13c4 : 4c ac 13 JMP $13ac ; (nforml.l33 + 0)
.s36:
13c7 : a6 44 __ LDX T2 + 0 
13c9 : e0 10 __ CPX #$10
13cb : b0 11 __ BCS $13de ; (nforml.s26 + 0)
.s1035:
13cd : 88 __ __ DEY
.l1044:
13ce : bd e8 9f LDA $9fe8,x ; (buffer + 0)
13d1 : 91 0f __ STA (P2),y ; (str + 0)
13d3 : e6 44 __ INC T2 + 0 
13d5 : a6 44 __ LDX T2 + 0 
13d7 : e0 10 __ CPX #$10
13d9 : c8 __ __ INY
13da : 90 f2 __ BCC $13ce ; (nforml.l1044 + 0)
.s1045:
13dc : 84 1b __ STY ACCU + 0 
.s26:
13de : a9 00 __ LDA #$00
13e0 : 85 1c __ STA ACCU + 1 
.s1001:
13e2 : 60 __ __ RTS
.s27:
13e3 : a6 44 __ LDX T2 + 0 
13e5 : e0 10 __ CPX #$10
13e7 : b0 12 __ BCS $13fb ; (nforml.l30 + 0)
.s1033:
13e9 : a0 00 __ LDY #$00
.l1042:
13eb : bd e8 9f LDA $9fe8,x ; (buffer + 0)
13ee : 91 0f __ STA (P2),y ; (str + 0)
13f0 : e6 44 __ INC T2 + 0 
13f2 : a6 44 __ LDX T2 + 0 
13f4 : e0 10 __ CPX #$10
13f6 : c8 __ __ INY
13f7 : 90 f2 __ BCC $13eb ; (nforml.l1042 + 0)
.s1043:
13f9 : 84 1b __ STY ACCU + 0 
.l30:
13fb : a5 1b __ LDA ACCU + 0 
13fd : a0 01 __ LDY #$01
13ff : d1 0d __ CMP (P0),y ; (si + 0)
1401 : b0 db __ BCS $13de ; (nforml.s26 + 0)
.s31:
1403 : 88 __ __ DEY
1404 : b1 0d __ LDA (P0),y ; (si + 0)
1406 : a4 1b __ LDY ACCU + 0 
1408 : 91 0f __ STA (P2),y ; (str + 0)
140a : e6 1b __ INC ACCU + 0 
140c : 4c fb 13 JMP $13fb ; (nforml.l30 + 0)
.l6:
140f : a0 03 __ LDY #$03
1411 : b1 0d __ LDA (P0),y ; (si + 0)
1413 : 85 03 __ STA WORK + 0 
1415 : 85 45 __ STA T6 + 0 
1417 : c8 __ __ INY
1418 : b1 0d __ LDA (P0),y ; (si + 0)
141a : 85 46 __ STA T6 + 1 
141c : 85 04 __ STA WORK + 1 
141e : a5 11 __ LDA P4 ; (v + 0)
1420 : 85 1b __ STA ACCU + 0 
1422 : a5 12 __ LDA P5 ; (v + 1)
1424 : 85 1c __ STA ACCU + 1 
1426 : a5 13 __ LDA P6 ; (v + 2)
1428 : 85 1d __ STA ACCU + 2 
142a : a5 14 __ LDA P7 ; (v + 3)
142c : 85 1e __ STA ACCU + 3 
142e : a9 00 __ LDA #$00
1430 : 85 05 __ STA WORK + 2 
1432 : 85 06 __ STA WORK + 3 
1434 : 20 b5 24 JSR $24b5 ; (divmod32 + 0)
1437 : a5 08 __ LDA WORK + 5 
1439 : 30 10 __ BMI $144b ; (nforml.s9 + 0)
.s1023:
143b : d0 06 __ BNE $1443 ; (nforml.s8 + 0)
.s1022:
143d : a5 07 __ LDA WORK + 4 
143f : c9 0a __ CMP #$0a
1441 : 90 08 __ BCC $144b ; (nforml.s9 + 0)
.s8:
1443 : 18 __ __ CLC
1444 : a5 07 __ LDA WORK + 4 
1446 : 69 37 __ ADC #$37
1448 : 4c 50 14 JMP $1450 ; (nforml.s10 + 0)
.s9:
144b : 18 __ __ CLC
144c : a5 07 __ LDA WORK + 4 
144e : 69 30 __ ADC #$30
.s10:
1450 : c6 44 __ DEC T2 + 0 
1452 : a6 44 __ LDX T2 + 0 
1454 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1457 : a5 11 __ LDA P4 ; (v + 0)
1459 : 85 1b __ STA ACCU + 0 
145b : a5 12 __ LDA P5 ; (v + 1)
145d : 85 1c __ STA ACCU + 1 
145f : a5 13 __ LDA P6 ; (v + 2)
1461 : 85 1d __ STA ACCU + 2 
1463 : a5 14 __ LDA P7 ; (v + 3)
1465 : 85 1e __ STA ACCU + 3 
1467 : a5 45 __ LDA T6 + 0 
1469 : 85 03 __ STA WORK + 0 
146b : a5 46 __ LDA T6 + 1 
146d : 85 04 __ STA WORK + 1 
146f : a9 00 __ LDA #$00
1471 : 85 05 __ STA WORK + 2 
1473 : 85 06 __ STA WORK + 3 
1475 : 20 b5 24 JSR $24b5 ; (divmod32 + 0)
1478 : a5 1b __ LDA ACCU + 0 
147a : 85 11 __ STA P4 ; (v + 0)
147c : a5 1c __ LDA ACCU + 1 
147e : 85 12 __ STA P5 ; (v + 1)
1480 : a5 1d __ LDA ACCU + 2 
1482 : 85 13 __ STA P6 ; (v + 2)
1484 : a5 1e __ LDA ACCU + 3 
1486 : 85 14 __ STA P7 ; (v + 3)
1488 : d0 85 __ BNE $140f ; (nforml.l6 + 0)
148a : 4c 2b 13 JMP $132b ; (nforml.s1018 + 0)
--------------------------------------------------------------------
nformf:
.s0:
148d : a5 15 __ LDA P8 ; (f + 0)
148f : 85 43 __ STA T1 + 0 
1491 : a5 16 __ LDA P9 ; (f + 1)
1493 : 85 44 __ STA T1 + 1 
1495 : a5 17 __ LDA P10 ; (f + 2)
1497 : 85 45 __ STA T1 + 2 
1499 : a5 18 __ LDA P11 ; (f + 3)
149b : 29 7f __ AND #$7f
149d : 05 17 __ ORA P10 ; (f + 2)
149f : 05 16 __ ORA P9 ; (f + 1)
14a1 : 05 15 __ ORA P8 ; (f + 0)
14a3 : f0 21 __ BEQ $14c6 ; (nformf.s2 + 0)
.s1005:
14a5 : a5 18 __ LDA P11 ; (f + 3)
14a7 : 10 1d __ BPL $14c6 ; (nformf.s2 + 0)
.s1:
14a9 : a9 2d __ LDA #$2d
14ab : a0 00 __ LDY #$00
14ad : 91 13 __ STA (P6),y ; (str + 0)
14af : a5 18 __ LDA P11 ; (f + 3)
14b1 : 49 80 __ EOR #$80
14b3 : 85 18 __ STA P11 ; (f + 3)
14b5 : 85 10 __ STA P3 
14b7 : a5 15 __ LDA P8 ; (f + 0)
14b9 : 85 0d __ STA P0 
14bb : a5 16 __ LDA P9 ; (f + 1)
14bd : 85 0e __ STA P1 
14bf : a5 17 __ LDA P10 ; (f + 2)
14c1 : 85 0f __ STA P2 
14c3 : 4c 46 19 JMP $1946 ; (nformf.s189 + 0)
.s2:
14c6 : a5 15 __ LDA P8 ; (f + 0)
14c8 : 85 0d __ STA P0 
14ca : a5 16 __ LDA P9 ; (f + 1)
14cc : 85 0e __ STA P1 
14ce : a5 17 __ LDA P10 ; (f + 2)
14d0 : 85 0f __ STA P2 
14d2 : a5 18 __ LDA P11 ; (f + 3)
14d4 : 85 10 __ STA P3 
14d6 : a0 05 __ LDY #$05
14d8 : b1 11 __ LDA (P4),y ; (si + 0)
14da : f0 09 __ BEQ $14e5 ; (nformf.s3 + 0)
.s4:
14dc : a9 2b __ LDA #$2b
14de : a0 00 __ LDY #$00
14e0 : 91 13 __ STA (P6),y ; (str + 0)
14e2 : 4c 46 19 JMP $1946 ; (nformf.s189 + 0)
.s3:
14e5 : 20 5e 19 JSR $195e ; (isinf.s0 + 0)
14e8 : aa __ __ TAX
14e9 : a9 00 __ LDA #$00
14eb : 85 48 __ STA T3 + 0 
14ed : 8a __ __ TXA
14ee : f0 0b __ BEQ $14fb ; (nformf.s8 + 0)
.s160:
14f0 : a9 01 __ LDA #$01
14f2 : 85 4a __ STA T5 + 0 
14f4 : a9 02 __ LDA #$02
14f6 : a0 00 __ LDY #$00
14f8 : 4c 2a 19 JMP $192a ; (nformf.s7 + 0)
.s8:
14fb : a0 02 __ LDY #$02
14fd : b1 11 __ LDA (P4),y ; (si + 0)
14ff : c9 ff __ CMP #$ff
1501 : d0 02 __ BNE $1505 ; (nformf.s128 + 0)
.s129:
1503 : a9 06 __ LDA #$06
.s128:
1505 : 86 4a __ STX T5 + 0 
1507 : 86 4b __ STX T5 + 1 
1509 : 85 49 __ STA T4 + 0 
150b : 85 47 __ STA T2 + 0 
150d : a5 18 __ LDA P11 ; (f + 3)
150f : 85 46 __ STA T1 + 3 
1511 : 29 7f __ AND #$7f
1513 : 05 17 __ ORA P10 ; (f + 2)
1515 : 05 16 __ ORA P9 ; (f + 1)
1517 : 05 15 __ ORA P8 ; (f + 0)
1519 : f0 03 __ BEQ $151e ; (nformf.s12 + 0)
151b : 4c 2b 18 JMP $182b ; (nformf.s13 + 0)
.s12:
151e : ad f8 9f LDA $9ff8 ; (sstack + 0)
1521 : c9 65 __ CMP #$65
1523 : d0 04 __ BNE $1529 ; (nformf.s1007 + 0)
.s1006:
1525 : a9 01 __ LDA #$01
1527 : d0 02 __ BNE $152b ; (nformf.s1008 + 0)
.s1007:
1529 : a9 00 __ LDA #$00
.s1008:
152b : 85 4e __ STA T9 + 0 
152d : a6 49 __ LDX T4 + 0 
152f : e8 __ __ INX
1530 : 86 4c __ STX T8 + 0 
1532 : ad f8 9f LDA $9ff8 ; (sstack + 0)
1535 : c9 67 __ CMP #$67
1537 : d0 13 __ BNE $154c ; (nformf.s24 + 0)
.s22:
1539 : a5 4b __ LDA T5 + 1 
153b : 30 08 __ BMI $1545 ; (nformf.s25 + 0)
.s1050:
153d : d0 06 __ BNE $1545 ; (nformf.s25 + 0)
.s1049:
153f : a5 4a __ LDA T5 + 0 
1541 : c9 04 __ CMP #$04
1543 : 90 07 __ BCC $154c ; (nformf.s24 + 0)
.s25:
1545 : a9 01 __ LDA #$01
1547 : 85 4e __ STA T9 + 0 
1549 : 4c a3 17 JMP $17a3 ; (nformf.s30 + 0)
.s24:
154c : a5 4e __ LDA T9 + 0 
154e : f0 03 __ BEQ $1553 ; (nformf.s32 + 0)
1550 : 4c a3 17 JMP $17a3 ; (nformf.s30 + 0)
.s32:
1553 : a5 4b __ LDA T5 + 1 
1555 : 10 3e __ BPL $1595 ; (nformf.s34 + 0)
.s33:
1557 : a5 43 __ LDA T1 + 0 
1559 : 85 1b __ STA ACCU + 0 
155b : a5 44 __ LDA T1 + 1 
155d : 85 1c __ STA ACCU + 1 
155f : a5 45 __ LDA T1 + 2 
1561 : 85 1d __ STA ACCU + 2 
1563 : a5 46 __ LDA T1 + 3 
1565 : 85 1e __ STA ACCU + 3 
.l1085:
1567 : e6 4a __ INC T5 + 0 
1569 : d0 02 __ BNE $156d ; (nformf.s1095 + 0)
.s1094:
156b : e6 4b __ INC T5 + 1 
.s1095:
156d : a9 00 __ LDA #$00
156f : 85 03 __ STA WORK + 0 
1571 : 85 04 __ STA WORK + 1 
1573 : a9 20 __ LDA #$20
1575 : 85 05 __ STA WORK + 2 
1577 : a9 41 __ LDA #$41
1579 : 85 06 __ STA WORK + 3 
157b : 20 ab 20 JSR $20ab ; (freg + 20)
157e : 20 92 22 JSR $2292 ; (fdiv + 0)
1581 : a5 4b __ LDA T5 + 1 
1583 : 30 e2 __ BMI $1567 ; (nformf.l1085 + 0)
.s1086:
1585 : a5 1e __ LDA ACCU + 3 
1587 : 85 46 __ STA T1 + 3 
1589 : a5 1d __ LDA ACCU + 2 
158b : 85 45 __ STA T1 + 2 
158d : a5 1c __ LDA ACCU + 1 
158f : 85 44 __ STA T1 + 1 
1591 : a5 1b __ LDA ACCU + 0 
1593 : 85 43 __ STA T1 + 0 
.s34:
1595 : 18 __ __ CLC
1596 : a5 49 __ LDA T4 + 0 
1598 : 65 4a __ ADC T5 + 0 
159a : 18 __ __ CLC
159b : 69 01 __ ADC #$01
159d : 85 4c __ STA T8 + 0 
159f : c9 07 __ CMP #$07
15a1 : 90 13 __ BCC $15b6 ; (nformf.s35 + 0)
.s36:
15a3 : ad e3 25 LDA $25e3 ; (fround5 + 25)
15a6 : 85 1c __ STA ACCU + 1 
15a8 : ad e4 25 LDA $25e4 ; (fround5 + 26)
15ab : 85 1d __ STA ACCU + 2 
15ad : ad e5 25 LDA $25e5 ; (fround5 + 27)
15b0 : ae e2 25 LDX $25e2 ; (fround5 + 24)
15b3 : 4c c9 15 JMP $15c9 ; (nformf.s214 + 0)
.s35:
15b6 : 0a __ __ ASL
15b7 : 0a __ __ ASL
15b8 : a8 __ __ TAY
15b9 : b9 c7 25 LDA $25c7,y ; (p2smap + 5)
15bc : 85 1c __ STA ACCU + 1 
15be : b9 c8 25 LDA $25c8,y ; (p2smap + 6)
15c1 : 85 1d __ STA ACCU + 2 
15c3 : b9 c9 25 LDA $25c9,y ; (p2smap + 7)
15c6 : be c6 25 LDX $25c6,y ; (p2smap + 4)
.s214:
15c9 : 86 1b __ STX ACCU + 0 
15cb : 85 1e __ STA ACCU + 3 
15cd : a2 43 __ LDX #$43
15cf : 20 9b 20 JSR $209b ; (freg + 4)
15d2 : 20 dc 20 JSR $20dc ; (faddsub + 0)
15d5 : a5 1c __ LDA ACCU + 1 
15d7 : 85 16 __ STA P9 ; (f + 1)
15d9 : a5 1d __ LDA ACCU + 2 
15db : 85 17 __ STA P10 ; (f + 2)
15dd : a6 1b __ LDX ACCU + 0 
15df : a5 1e __ LDA ACCU + 3 
15e1 : 85 18 __ STA P11 ; (f + 3)
15e3 : 30 35 __ BMI $161a ; (nformf.s31 + 0)
.s1032:
15e5 : c9 41 __ CMP #$41
15e7 : d0 06 __ BNE $15ef ; (nformf.s1036 + 0)
.s1033:
15e9 : a5 17 __ LDA P10 ; (f + 2)
15eb : c9 20 __ CMP #$20
15ed : f0 02 __ BEQ $15f1 ; (nformf.s38 + 0)
.s1036:
15ef : 90 29 __ BCC $161a ; (nformf.s31 + 0)
.s38:
15f1 : a9 00 __ LDA #$00
15f3 : 85 03 __ STA WORK + 0 
15f5 : 85 04 __ STA WORK + 1 
15f7 : a9 20 __ LDA #$20
15f9 : 85 05 __ STA WORK + 2 
15fb : a9 41 __ LDA #$41
15fd : 85 06 __ STA WORK + 3 
15ff : 20 ab 20 JSR $20ab ; (freg + 20)
1602 : 20 92 22 JSR $2292 ; (fdiv + 0)
1605 : a5 1c __ LDA ACCU + 1 
1607 : 85 16 __ STA P9 ; (f + 1)
1609 : a5 1d __ LDA ACCU + 2 
160b : 85 17 __ STA P10 ; (f + 2)
160d : a5 1e __ LDA ACCU + 3 
160f : 85 18 __ STA P11 ; (f + 3)
1611 : 18 __ __ CLC
1612 : a5 49 __ LDA T4 + 0 
1614 : 69 ff __ ADC #$ff
1616 : 85 47 __ STA T2 + 0 
1618 : a6 1b __ LDX ACCU + 0 
.s31:
161a : 38 __ __ SEC
161b : a5 4c __ LDA T8 + 0 
161d : e5 47 __ SBC T2 + 0 
161f : 85 49 __ STA T4 + 0 
1621 : a9 14 __ LDA #$14
1623 : c5 4c __ CMP T8 + 0 
1625 : b0 02 __ BCS $1629 ; (nformf.s49 + 0)
.s47:
1627 : 85 4c __ STA T8 + 0 
.s49:
1629 : a5 49 __ LDA T4 + 0 
162b : d0 08 __ BNE $1635 ; (nformf.s219 + 0)
.s50:
162d : a9 30 __ LDA #$30
162f : a4 48 __ LDY T3 + 0 
1631 : 91 13 __ STA (P6),y ; (str + 0)
1633 : e6 48 __ INC T3 + 0 
.s219:
1635 : a9 00 __ LDA #$00
1637 : 85 47 __ STA T2 + 0 
1639 : c5 49 __ CMP T4 + 0 
163b : d0 08 __ BNE $1645 ; (nformf.l59 + 0)
.l57:
163d : a9 2e __ LDA #$2e
163f : a4 48 __ LDY T3 + 0 
1641 : 91 13 __ STA (P6),y ; (str + 0)
1643 : e6 48 __ INC T3 + 0 
.l59:
1645 : a5 47 __ LDA T2 + 0 
1647 : c9 07 __ CMP #$07
1649 : 90 04 __ BCC $164f ; (nformf.s61 + 0)
.s60:
164b : a9 30 __ LDA #$30
164d : d0 55 __ BNE $16a4 ; (nformf.s208 + 0)
.s61:
164f : 86 1b __ STX ACCU + 0 
1651 : 86 43 __ STX T1 + 0 
1653 : a5 16 __ LDA P9 ; (f + 1)
1655 : 85 1c __ STA ACCU + 1 
1657 : 85 44 __ STA T1 + 1 
1659 : a5 17 __ LDA P10 ; (f + 2)
165b : 85 1d __ STA ACCU + 2 
165d : 85 45 __ STA T1 + 2 
165f : a5 18 __ LDA P11 ; (f + 3)
1661 : 85 1e __ STA ACCU + 3 
1663 : 85 46 __ STA T1 + 3 
1665 : 20 28 24 JSR $2428 ; (f32_to_i16 + 0)
1668 : a5 1b __ LDA ACCU + 0 
166a : 85 4f __ STA T11 + 0 
166c : 20 6a 24 JSR $246a ; (sint16_to_float + 0)
166f : a2 43 __ LDX #$43
1671 : 20 9b 20 JSR $209b ; (freg + 4)
1674 : a5 1e __ LDA ACCU + 3 
1676 : 49 80 __ EOR #$80
1678 : 85 1e __ STA ACCU + 3 
167a : 20 dc 20 JSR $20dc ; (faddsub + 0)
167d : a9 00 __ LDA #$00
167f : 85 03 __ STA WORK + 0 
1681 : 85 04 __ STA WORK + 1 
1683 : a9 20 __ LDA #$20
1685 : 85 05 __ STA WORK + 2 
1687 : a9 41 __ LDA #$41
1689 : 85 06 __ STA WORK + 3 
168b : 20 ab 20 JSR $20ab ; (freg + 20)
168e : 20 c3 21 JSR $21c3 ; (fmul + 0)
1691 : a5 1c __ LDA ACCU + 1 
1693 : 85 16 __ STA P9 ; (f + 1)
1695 : a5 1d __ LDA ACCU + 2 
1697 : 85 17 __ STA P10 ; (f + 2)
1699 : a5 1e __ LDA ACCU + 3 
169b : 85 18 __ STA P11 ; (f + 3)
169d : 18 __ __ CLC
169e : a5 4f __ LDA T11 + 0 
16a0 : 69 30 __ ADC #$30
16a2 : a6 1b __ LDX ACCU + 0 
.s208:
16a4 : a4 48 __ LDY T3 + 0 
16a6 : 91 13 __ STA (P6),y ; (str + 0)
16a8 : e6 48 __ INC T3 + 0 
16aa : e6 47 __ INC T2 + 0 
16ac : a5 47 __ LDA T2 + 0 
16ae : c5 4c __ CMP T8 + 0 
16b0 : b0 07 __ BCS $16b9 ; (nformf.s56 + 0)
.s54:
16b2 : c5 49 __ CMP T4 + 0 
16b4 : d0 8f __ BNE $1645 ; (nformf.l59 + 0)
16b6 : 4c 3d 16 JMP $163d ; (nformf.l57 + 0)
.s56:
16b9 : a5 4e __ LDA T9 + 0 
16bb : f0 62 __ BEQ $171f ; (nformf.s9 + 0)
.s63:
16bd : a9 45 __ LDA #$45
16bf : a4 48 __ LDY T3 + 0 
16c1 : 91 13 __ STA (P6),y ; (str + 0)
16c3 : c8 __ __ INY
16c4 : a5 4b __ LDA T5 + 1 
16c6 : 30 06 __ BMI $16ce ; (nformf.s66 + 0)
.s67:
16c8 : a9 2b __ LDA #$2b
16ca : 91 13 __ STA (P6),y ; (str + 0)
16cc : d0 11 __ BNE $16df ; (nformf.s68 + 0)
.s66:
16ce : a9 2d __ LDA #$2d
16d0 : 91 13 __ STA (P6),y ; (str + 0)
16d2 : 38 __ __ SEC
16d3 : a9 00 __ LDA #$00
16d5 : e5 4a __ SBC T5 + 0 
16d7 : 85 4a __ STA T5 + 0 
16d9 : a9 00 __ LDA #$00
16db : e5 4b __ SBC T5 + 1 
16dd : 85 4b __ STA T5 + 1 
.s68:
16df : a5 4a __ LDA T5 + 0 
16e1 : 85 1b __ STA ACCU + 0 
16e3 : a5 4b __ LDA T5 + 1 
16e5 : 85 1c __ STA ACCU + 1 
16e7 : a9 0a __ LDA #$0a
16e9 : 85 03 __ STA WORK + 0 
16eb : a9 00 __ LDA #$00
16ed : 85 04 __ STA WORK + 1 
16ef : 20 40 23 JSR $2340 ; (divs16 + 0)
16f2 : 18 __ __ CLC
16f3 : a5 1b __ LDA ACCU + 0 
16f5 : 69 30 __ ADC #$30
16f7 : a4 48 __ LDY T3 + 0 
16f9 : c8 __ __ INY
16fa : c8 __ __ INY
16fb : 91 13 __ STA (P6),y ; (str + 0)
16fd : a5 4a __ LDA T5 + 0 
16ff : 85 1b __ STA ACCU + 0 
1701 : a5 4b __ LDA T5 + 1 
1703 : 85 1c __ STA ACCU + 1 
1705 : a9 0a __ LDA #$0a
1707 : 85 03 __ STA WORK + 0 
1709 : a9 00 __ LDA #$00
170b : 85 04 __ STA WORK + 1 
170d : 20 ff 23 JSR $23ff ; (mods16 + 0)
1710 : 18 __ __ CLC
1711 : a5 05 __ LDA WORK + 2 
1713 : 69 30 __ ADC #$30
1715 : a4 48 __ LDY T3 + 0 
1717 : c8 __ __ INY
1718 : c8 __ __ INY
1719 : c8 __ __ INY
171a : 91 13 __ STA (P6),y ; (str + 0)
171c : c8 __ __ INY
171d : 84 48 __ STY T3 + 0 
.s9:
171f : a5 11 __ LDA P4 ; (si + 0)
1721 : 85 4a __ STA T5 + 0 
1723 : a5 12 __ LDA P5 ; (si + 1)
1725 : 85 4b __ STA T5 + 1 
1727 : a5 48 __ LDA T3 + 0 
1729 : a0 01 __ LDY #$01
172b : d1 11 __ CMP (P4),y ; (si + 0)
172d : b0 5d __ BCS $178c ; (nformf.s1001 + 0)
.s69:
172f : a0 06 __ LDY #$06
1731 : b1 11 __ LDA (P4),y ; (si + 0)
1733 : f0 06 __ BEQ $173b ; (nformf.s73 + 0)
.s72:
1735 : a5 48 __ LDA T3 + 0 
1737 : aa __ __ TAX
1738 : 4c 93 17 JMP $1793 ; (nformf.l75 + 0)
.s73:
173b : a5 48 __ LDA T3 + 0 
173d : f0 2d __ BEQ $176c ; (nformf.s82 + 0)
.s90:
173f : a9 01 __ LDA #$01
1741 : 85 47 __ STA T2 + 0 
1743 : a6 48 __ LDX T3 + 0 
1745 : 38 __ __ SEC
.l1083:
1746 : a0 01 __ LDY #$01
1748 : b1 11 __ LDA (P4),y ; (si + 0)
174a : e5 47 __ SBC T2 + 0 
174c : 85 4c __ STA T8 + 0 
174e : a9 ff __ LDA #$ff
1750 : 65 14 __ ADC P7 ; (str + 1)
1752 : 85 4d __ STA T8 + 1 
1754 : 8a __ __ TXA
1755 : 38 __ __ SEC
1756 : e5 47 __ SBC T2 + 0 
1758 : 85 1b __ STA ACCU + 0 
175a : a9 ff __ LDA #$ff
175c : 65 14 __ ADC P7 ; (str + 1)
175e : 85 1c __ STA ACCU + 1 
1760 : a4 13 __ LDY P6 ; (str + 0)
1762 : b1 1b __ LDA (ACCU + 0),y 
1764 : 91 4c __ STA (T8 + 0),y 
1766 : e6 47 __ INC T2 + 0 
1768 : e4 47 __ CPX T2 + 0 
176a : b0 da __ BCS $1746 ; (nformf.l1083 + 0)
.s82:
176c : a9 00 __ LDA #$00
176e : 85 47 __ STA T2 + 0 
.l83:
1770 : a0 01 __ LDY #$01
1772 : b1 4a __ LDA (T5 + 0),y 
1774 : 38 __ __ SEC
1775 : e5 48 __ SBC T3 + 0 
1777 : 90 06 __ BCC $177f ; (nformf.s84 + 0)
.s1011:
1779 : c5 47 __ CMP T2 + 0 
177b : 90 0d __ BCC $178a ; (nformf.s74 + 0)
.s1087:
177d : f0 0b __ BEQ $178a ; (nformf.s74 + 0)
.s84:
177f : a9 20 __ LDA #$20
1781 : a4 47 __ LDY T2 + 0 
1783 : 91 13 __ STA (P6),y ; (str + 0)
1785 : e6 47 __ INC T2 + 0 
1787 : 4c 70 17 JMP $1770 ; (nformf.l83 + 0)
.s74:
178a : b1 11 __ LDA (P4),y ; (si + 0)
.s1001:
178c : 85 1b __ STA ACCU + 0 
178e : a9 00 __ LDA #$00
1790 : 85 1c __ STA ACCU + 1 
1792 : 60 __ __ RTS
.l75:
1793 : a0 01 __ LDY #$01
1795 : d1 4a __ CMP (T5 + 0),y 
1797 : b0 f1 __ BCS $178a ; (nformf.s74 + 0)
.s76:
1799 : a8 __ __ TAY
179a : a9 20 __ LDA #$20
179c : 91 13 __ STA (P6),y ; (str + 0)
179e : e8 __ __ INX
179f : 8a __ __ TXA
17a0 : 4c 93 17 JMP $1793 ; (nformf.l75 + 0)
.s30:
17a3 : a5 4c __ LDA T8 + 0 
17a5 : c9 07 __ CMP #$07
17a7 : 90 13 __ BCC $17bc ; (nformf.s41 + 0)
.s42:
17a9 : ad e3 25 LDA $25e3 ; (fround5 + 25)
17ac : 85 1c __ STA ACCU + 1 
17ae : ad e4 25 LDA $25e4 ; (fround5 + 26)
17b1 : 85 1d __ STA ACCU + 2 
17b3 : ad e5 25 LDA $25e5 ; (fround5 + 27)
17b6 : ae e2 25 LDX $25e2 ; (fround5 + 24)
17b9 : 4c cf 17 JMP $17cf ; (nformf.s204 + 0)
.s41:
17bc : 0a __ __ ASL
17bd : 0a __ __ ASL
17be : a8 __ __ TAY
17bf : b9 c7 25 LDA $25c7,y ; (p2smap + 5)
17c2 : 85 1c __ STA ACCU + 1 
17c4 : b9 c8 25 LDA $25c8,y ; (p2smap + 6)
17c7 : 85 1d __ STA ACCU + 2 
17c9 : b9 c9 25 LDA $25c9,y ; (p2smap + 7)
17cc : be c6 25 LDX $25c6,y ; (p2smap + 4)
.s204:
17cf : 86 1b __ STX ACCU + 0 
17d1 : 85 1e __ STA ACCU + 3 
17d3 : a2 43 __ LDX #$43
17d5 : 20 9b 20 JSR $209b ; (freg + 4)
17d8 : 20 dc 20 JSR $20dc ; (faddsub + 0)
17db : a5 1c __ LDA ACCU + 1 
17dd : 85 16 __ STA P9 ; (f + 1)
17df : a5 1d __ LDA ACCU + 2 
17e1 : 85 17 __ STA P10 ; (f + 2)
17e3 : a6 1b __ LDX ACCU + 0 
17e5 : a5 1e __ LDA ACCU + 3 
17e7 : 85 18 __ STA P11 ; (f + 3)
17e9 : 10 03 __ BPL $17ee ; (nformf.s1042 + 0)
17eb : 4c 1a 16 JMP $161a ; (nformf.s31 + 0)
.s1042:
17ee : c9 41 __ CMP #$41
17f0 : d0 06 __ BNE $17f8 ; (nformf.s1046 + 0)
.s1043:
17f2 : a5 17 __ LDA P10 ; (f + 2)
17f4 : c9 20 __ CMP #$20
17f6 : f0 05 __ BEQ $17fd ; (nformf.s44 + 0)
.s1046:
17f8 : b0 03 __ BCS $17fd ; (nformf.s44 + 0)
17fa : 4c 1a 16 JMP $161a ; (nformf.s31 + 0)
.s44:
17fd : a9 00 __ LDA #$00
17ff : 85 03 __ STA WORK + 0 
1801 : 85 04 __ STA WORK + 1 
1803 : a9 20 __ LDA #$20
1805 : 85 05 __ STA WORK + 2 
1807 : a9 41 __ LDA #$41
1809 : 85 06 __ STA WORK + 3 
180b : 20 ab 20 JSR $20ab ; (freg + 20)
180e : 20 92 22 JSR $2292 ; (fdiv + 0)
1811 : a5 1c __ LDA ACCU + 1 
1813 : 85 16 __ STA P9 ; (f + 1)
1815 : a5 1d __ LDA ACCU + 2 
1817 : 85 17 __ STA P10 ; (f + 2)
1819 : a5 1e __ LDA ACCU + 3 
181b : 85 18 __ STA P11 ; (f + 3)
181d : a6 1b __ LDX ACCU + 0 
181f : e6 4a __ INC T5 + 0 
1821 : f0 03 __ BEQ $1826 ; (nformf.s1092 + 0)
1823 : 4c 1a 16 JMP $161a ; (nformf.s31 + 0)
.s1092:
1826 : e6 4b __ INC T5 + 1 
1828 : 4c 1a 16 JMP $161a ; (nformf.s31 + 0)
.s13:
182b : a5 18 __ LDA P11 ; (f + 3)
182d : 30 59 __ BMI $1888 ; (nformf.l17 + 0)
.l1072:
182f : c9 44 __ CMP #$44
1831 : f0 03 __ BEQ $1836 ; (nformf.s1073 + 0)
1833 : 4c 25 19 JMP $1925 ; (nformf.s1076 + 0)
.s1073:
1836 : a5 45 __ LDA T1 + 2 
1838 : c9 7a __ CMP #$7a
183a : f0 03 __ BEQ $183f ; (nformf.s1074 + 0)
183c : 4c 25 19 JMP $1925 ; (nformf.s1076 + 0)
.s1074:
183f : a5 44 __ LDA T1 + 1 
1841 : d0 04 __ BNE $1847 ; (nformf.s1082 + 0)
.s1075:
1843 : a5 43 __ LDA T1 + 0 
1845 : f0 02 __ BEQ $1849 ; (nformf.s14 + 0)
.s1082:
1847 : a5 43 __ LDA T1 + 0 
.s14:
1849 : 85 1b __ STA ACCU + 0 
184b : a5 44 __ LDA T1 + 1 
184d : 85 1c __ STA ACCU + 1 
184f : a5 45 __ LDA T1 + 2 
1851 : 85 1d __ STA ACCU + 2 
1853 : a5 46 __ LDA T1 + 3 
1855 : 85 1e __ STA ACCU + 3 
1857 : a9 00 __ LDA #$00
1859 : 85 03 __ STA WORK + 0 
185b : 85 04 __ STA WORK + 1 
185d : a9 7a __ LDA #$7a
185f : 85 05 __ STA WORK + 2 
1861 : a9 44 __ LDA #$44
1863 : 85 06 __ STA WORK + 3 
1865 : 20 ab 20 JSR $20ab ; (freg + 20)
1868 : 20 92 22 JSR $2292 ; (fdiv + 0)
186b : a5 1b __ LDA ACCU + 0 
186d : 85 43 __ STA T1 + 0 
186f : a5 1c __ LDA ACCU + 1 
1871 : 85 44 __ STA T1 + 1 
1873 : a5 1d __ LDA ACCU + 2 
1875 : 85 45 __ STA T1 + 2 
1877 : 18 __ __ CLC
1878 : a5 4a __ LDA T5 + 0 
187a : 69 03 __ ADC #$03
187c : 85 4a __ STA T5 + 0 
187e : 90 02 __ BCC $1882 ; (nformf.s1097 + 0)
.s1096:
1880 : e6 4b __ INC T5 + 1 
.s1097:
1882 : a5 1e __ LDA ACCU + 3 
1884 : 85 46 __ STA T1 + 3 
1886 : 10 a7 __ BPL $182f ; (nformf.l1072 + 0)
.l17:
1888 : a9 00 __ LDA #$00
188a : 85 1b __ STA ACCU + 0 
188c : 85 1c __ STA ACCU + 1 
188e : a9 7a __ LDA #$7a
1890 : 85 1d __ STA ACCU + 2 
1892 : a9 44 __ LDA #$44
1894 : 85 1e __ STA ACCU + 3 
1896 : a2 43 __ LDX #$43
1898 : 20 9b 20 JSR $209b ; (freg + 4)
189b : 20 c3 21 JSR $21c3 ; (fmul + 0)
189e : a5 1b __ LDA ACCU + 0 
18a0 : 85 43 __ STA T1 + 0 
18a2 : a5 1c __ LDA ACCU + 1 
18a4 : 85 44 __ STA T1 + 1 
18a6 : a5 1d __ LDA ACCU + 2 
18a8 : 85 45 __ STA T1 + 2 
18aa : a5 1e __ LDA ACCU + 3 
18ac : 85 46 __ STA T1 + 3 
18ae : 38 __ __ SEC
18af : a5 4a __ LDA T5 + 0 
18b1 : e9 03 __ SBC #$03
18b3 : 85 4a __ STA T5 + 0 
18b5 : b0 02 __ BCS $18b9 ; (nformf.s16 + 0)
.s1088:
18b7 : c6 4b __ DEC T5 + 1 
.s16:
18b9 : a5 46 __ LDA T1 + 3 
18bb : 30 cb __ BMI $1888 ; (nformf.l17 + 0)
.s1064:
18bd : c9 3f __ CMP #$3f
18bf : d0 06 __ BNE $18c7 ; (nformf.s1068 + 0)
.s1065:
18c1 : a5 45 __ LDA T1 + 2 
18c3 : c9 80 __ CMP #$80
18c5 : f0 02 __ BEQ $18c9 ; (nformf.s19 + 0)
.s1068:
18c7 : 90 bf __ BCC $1888 ; (nformf.l17 + 0)
.s19:
18c9 : a5 46 __ LDA T1 + 3 
18cb : c9 41 __ CMP #$41
18cd : d0 51 __ BNE $1920 ; (nformf.l1060 + 0)
.s1057:
18cf : a5 45 __ LDA T1 + 2 
18d1 : c9 20 __ CMP #$20
18d3 : d0 4b __ BNE $1920 ; (nformf.l1060 + 0)
.s1058:
18d5 : a5 44 __ LDA T1 + 1 
18d7 : d0 04 __ BNE $18dd ; (nformf.l1081 + 0)
.s1059:
18d9 : a5 43 __ LDA T1 + 0 
18db : f0 02 __ BEQ $18df ; (nformf.l20 + 0)
.l1081:
18dd : a5 43 __ LDA T1 + 0 
.l20:
18df : 85 1b __ STA ACCU + 0 
18e1 : a5 44 __ LDA T1 + 1 
18e3 : 85 1c __ STA ACCU + 1 
18e5 : a5 45 __ LDA T1 + 2 
18e7 : 85 1d __ STA ACCU + 2 
18e9 : a5 46 __ LDA T1 + 3 
18eb : 85 1e __ STA ACCU + 3 
18ed : a9 00 __ LDA #$00
18ef : 85 03 __ STA WORK + 0 
18f1 : 85 04 __ STA WORK + 1 
18f3 : a9 20 __ LDA #$20
18f5 : 85 05 __ STA WORK + 2 
18f7 : a9 41 __ LDA #$41
18f9 : 85 06 __ STA WORK + 3 
18fb : 20 ab 20 JSR $20ab ; (freg + 20)
18fe : 20 92 22 JSR $2292 ; (fdiv + 0)
1901 : a5 1b __ LDA ACCU + 0 
1903 : 85 43 __ STA T1 + 0 
1905 : a5 1c __ LDA ACCU + 1 
1907 : 85 44 __ STA T1 + 1 
1909 : a5 1d __ LDA ACCU + 2 
190b : 85 45 __ STA T1 + 2 
190d : e6 4a __ INC T5 + 0 
190f : d0 02 __ BNE $1913 ; (nformf.s1091 + 0)
.s1090:
1911 : e6 4b __ INC T5 + 1 
.s1091:
1913 : a5 1e __ LDA ACCU + 3 
1915 : 85 46 __ STA T1 + 3 
1917 : 10 03 __ BPL $191c ; (nformf.s1056 + 0)
1919 : 4c 1e 15 JMP $151e ; (nformf.s12 + 0)
.s1056:
191c : c9 41 __ CMP #$41
191e : f0 af __ BEQ $18cf ; (nformf.s1057 + 0)
.l1060:
1920 : b0 bb __ BCS $18dd ; (nformf.l1081 + 0)
1922 : 4c 1e 15 JMP $151e ; (nformf.s12 + 0)
.s1076:
1925 : 90 92 __ BCC $18b9 ; (nformf.s16 + 0)
1927 : 4c 47 18 JMP $1847 ; (nformf.s1082 + 0)
.s7:
192a : 85 1b __ STA ACCU + 0 
192c : a9 49 __ LDA #$49
192e : 91 13 __ STA (P6),y ; (str + 0)
1930 : a9 4e __ LDA #$4e
1932 : a4 4a __ LDY T5 + 0 
1934 : 91 13 __ STA (P6),y ; (str + 0)
1936 : a9 46 __ LDA #$46
1938 : a4 1b __ LDY ACCU + 0 
193a : 91 13 __ STA (P6),y ; (str + 0)
193c : 18 __ __ CLC
193d : a5 48 __ LDA T3 + 0 
193f : 69 03 __ ADC #$03
1941 : 85 48 __ STA T3 + 0 
1943 : 4c 1f 17 JMP $171f ; (nformf.s9 + 0)
.s189:
1946 : 20 5e 19 JSR $195e ; (isinf.s0 + 0)
1949 : aa __ __ TAX
194a : a9 01 __ LDA #$01
194c : 85 48 __ STA T3 + 0 
194e : 8a __ __ TXA
194f : d0 03 __ BNE $1954 ; (nformf.s158 + 0)
1951 : 4c fb 14 JMP $14fb ; (nformf.s8 + 0)
.s158:
1954 : a9 02 __ LDA #$02
1956 : 85 4a __ STA T5 + 0 
1958 : a9 03 __ LDA #$03
195a : a0 01 __ LDY #$01
195c : d0 cc __ BNE $192a ; (nformf.s7 + 0)
--------------------------------------------------------------------
isinf:
.s0:
195e : 06 0f __ ASL P2 ; (f + 2)
1960 : a5 10 __ LDA P3 ; (f + 3)
1962 : 2a __ __ ROL
1963 : c9 ff __ CMP #$ff
1965 : d0 03 __ BNE $196a ; (isinf.s1003 + 0)
.s1002:
1967 : a9 01 __ LDA #$01
1969 : 60 __ __ RTS
.s1003:
196a : a9 00 __ LDA #$00
.s1001:
196c : 60 __ __ RTS
--------------------------------------------------------------------
fround5:
25ca : __ __ __ BYT 00 00 00 3f cd cc 4c 3d 0a d7 a3 3b 6f 12 03 3a : ...?..L=...;o..:
25da : __ __ __ BYT 17 b7 51 38 ac c5 a7 36 bd 37 06 35             : ..Q8...6.7.5
--------------------------------------------------------------------
196d : __ __ __ BYT 25 64 00                                        : %d.
--------------------------------------------------------------------
1970 : __ __ __ BYT 53 48 49 50 53 3a 00                            : SHIPS:.
--------------------------------------------------------------------
spawn_enemy:
.s0:
1977 : 20 e7 19 JSR $19e7 ; (rand.s0 + 0)
197a : 46 1b __ LSR ACCU + 0 
197c : b0 0f __ BCS $198d ; (spawn_enemy.s1001 + 0)
.s3:
197e : a0 00 __ LDY #$00
.l6:
1980 : be 4b 25 LDX $254b,y ; (__multab5L + 0)
1983 : bd 04 26 LDA $2604,x ; (Enemy + 4)
1986 : f0 06 __ BEQ $198e ; (spawn_enemy.s9 + 0)
.s7:
1988 : c8 __ __ INY
1989 : c0 0a __ CPY #$0a
198b : 90 f3 __ BCC $1980 ; (spawn_enemy.l6 + 0)
.s1001:
198d : 60 __ __ RTS
.s9:
198e : 86 43 __ STX T0 + 0 
1990 : a9 27 __ LDA #$27
1992 : 9d 00 26 STA $2600,x ; (Enemy + 0)
1995 : 20 e7 19 JSR $19e7 ; (rand.s0 + 0)
1998 : a9 14 __ LDA #$14
199a : 85 03 __ STA WORK + 0 
199c : a9 00 __ LDA #$00
199e : 85 04 __ STA WORK + 1 
19a0 : 20 7a 23 JSR $237a ; (divmod + 0)
19a3 : 18 __ __ CLC
19a4 : a5 05 __ LDA WORK + 2 
19a6 : 69 04 __ ADC #$04
19a8 : a6 43 __ LDX T0 + 0 
19aa : 9d 01 26 STA $2601,x ; (Enemy + 1)
19ad : 20 e7 19 JSR $19e7 ; (rand.s0 + 0)
19b0 : a9 0e __ LDA #$0e
19b2 : a6 43 __ LDX T0 + 0 
19b4 : 9d 03 26 STA $2603,x ; (Enemy + 3)
19b7 : a9 01 __ LDA #$01
19b9 : 9d 04 26 STA $2604,x ; (Enemy + 4)
19bc : a9 03 __ LDA #$03
19be : 85 03 __ STA WORK + 0 
19c0 : a9 00 __ LDA #$00
19c2 : 85 04 __ STA WORK + 1 
19c4 : 20 7a 23 JSR $237a ; (divmod + 0)
19c7 : 18 __ __ CLC
19c8 : a5 05 __ LDA WORK + 2 
19ca : 69 83 __ ADC #$83
19cc : a4 43 __ LDY T0 + 0 
19ce : 99 02 26 STA $2602,y ; (Enemy + 2)
19d1 : c9 83 __ CMP #$83
19d3 : d0 04 __ BNE $19d9 ; (spawn_enemy.s13 + 0)
.s12:
19d5 : a9 0d __ LDA #$0d
19d7 : d0 0a __ BNE $19e3 ; (spawn_enemy.s1008 + 0)
.s13:
19d9 : c9 84 __ CMP #$84
19db : d0 04 __ BNE $19e1 ; (spawn_enemy.s16 + 0)
.s15:
19dd : a9 0a __ LDA #$0a
19df : d0 02 __ BNE $19e3 ; (spawn_enemy.s1008 + 0)
.s16:
19e1 : a9 09 __ LDA #$09
.s1008:
19e3 : 99 03 26 STA $2603,y ; (Enemy + 3)
19e6 : 60 __ __ RTS
--------------------------------------------------------------------
rand:
.s0:
19e7 : ad e7 25 LDA $25e7 ; (seed + 1)
19ea : 4a __ __ LSR
19eb : ad e6 25 LDA $25e6 ; (seed + 0)
19ee : 6a __ __ ROR
19ef : aa __ __ TAX
19f0 : a9 00 __ LDA #$00
19f2 : 6a __ __ ROR
19f3 : 4d e6 25 EOR $25e6 ; (seed + 0)
19f6 : 85 1b __ STA ACCU + 0 
19f8 : 8a __ __ TXA
19f9 : 4d e7 25 EOR $25e7 ; (seed + 1)
19fc : 85 1c __ STA ACCU + 1 
19fe : 4a __ __ LSR
19ff : 45 1b __ EOR ACCU + 0 
1a01 : 8d e6 25 STA $25e6 ; (seed + 0)
1a04 : 85 1b __ STA ACCU + 0 
1a06 : 45 1c __ EOR ACCU + 1 
1a08 : 8d e7 25 STA $25e7 ; (seed + 1)
1a0b : 85 1c __ STA ACCU + 1 
.s1001:
1a0d : 60 __ __ RTS
--------------------------------------------------------------------
seed:
25e6 : __ __ __ BYT 00 7a                                           : .z
--------------------------------------------------------------------
move_enemies:
.s0:
1a0e : a2 00 __ LDX #$00
.l2:
1a10 : 86 43 __ STX T0 + 0 
1a12 : bc 4b 25 LDY $254b,x ; (__multab5L + 0)
1a15 : b9 04 26 LDA $2604,y ; (Enemy + 4)
1a18 : c9 01 __ CMP #$01
1a1a : d0 75 __ BNE $1a91 ; (move_enemies.s41 + 0)
.s5:
1a1c : 18 __ __ CLC
1a1d : a9 00 __ LDA #$00
1a1f : 7d 4b 25 ADC $254b,x ; (__multab5L + 0)
1a22 : 85 44 __ STA T1 + 0 
1a24 : a9 26 __ LDA #$26
1a26 : 69 00 __ ADC #$00
1a28 : 85 45 __ STA T1 + 1 
1a2a : a0 02 __ LDY #$02
1a2c : b1 44 __ LDA (T1 + 0),y 
1a2e : c9 83 __ CMP #$83
1a30 : d0 16 __ BNE $1a48 ; (move_enemies.s10 + 0)
.s11:
1a32 : 88 __ __ DEY
1a33 : b1 44 __ LDA (T1 + 0),y 
1a35 : cd f9 25 CMP $25f9 ; (Player + 1)
1a38 : d0 0e __ BNE $1a48 ; (move_enemies.s10 + 0)
.s8:
1a3a : a5 44 __ LDA T1 + 0 
1a3c : 85 0d __ STA P0 
1a3e : a5 45 __ LDA T1 + 1 
1a40 : 85 0e __ STA P1 
1a42 : 20 fe 1a JSR $1afe ; (spawn_enemy_shot.s0 + 0)
1a45 : 20 31 1b JSR $1b31 ; (render_enemy_shots.s0 + 0)
.s10:
1a48 : a0 00 __ LDY #$00
1a4a : b1 44 __ LDA (T1 + 0),y 
1a4c : 85 46 __ STA T3 + 0 
1a4e : c8 __ __ INY
1a4f : b1 44 __ LDA (T1 + 0),y 
1a51 : 0a __ __ ASL
1a52 : 85 1b __ STA ACCU + 0 
1a54 : a9 00 __ LDA #$00
1a56 : 2a __ __ ROL
1a57 : 06 1b __ ASL ACCU + 0 
1a59 : 2a __ __ ROL
1a5a : aa __ __ TAX
1a5b : a5 1b __ LDA ACCU + 0 
1a5d : 71 44 __ ADC (T1 + 0),y 
1a5f : 85 1b __ STA ACCU + 0 
1a61 : 8a __ __ TXA
1a62 : 69 00 __ ADC #$00
1a64 : 06 1b __ ASL ACCU + 0 
1a66 : 2a __ __ ROL
1a67 : 06 1b __ ASL ACCU + 0 
1a69 : 2a __ __ ROL
1a6a : 06 1b __ ASL ACCU + 0 
1a6c : 2a __ __ ROL
1a6d : aa __ __ TAX
1a6e : 18 __ __ CLC
1a6f : a5 1b __ LDA ACCU + 0 
1a71 : 65 46 __ ADC T3 + 0 
1a73 : 85 1b __ STA ACCU + 0 
1a75 : 85 1f __ STA ADDR + 0 
1a77 : 8a __ __ TXA
1a78 : 69 c0 __ ADC #$c0
1a7a : 85 1c __ STA ACCU + 1 
1a7c : 18 __ __ CLC
1a7d : 69 18 __ ADC #$18
1a7f : 85 20 __ STA ADDR + 1 
1a81 : a9 20 __ LDA #$20
1a83 : 88 __ __ DEY
1a84 : 91 1b __ STA (ACCU + 0),y 
1a86 : 98 __ __ TYA
1a87 : 91 1f __ STA (ADDR + 0),y 
1a89 : a5 46 __ LDA T3 + 0 
1a8b : d0 0f __ BNE $1a9c ; (move_enemies.s12 + 0)
.s13:
1a8d : a0 04 __ LDY #$04
.s1020:
1a8f : 91 44 __ STA (T1 + 0),y 
.s41:
1a91 : a6 43 __ LDX T0 + 0 
1a93 : e8 __ __ INX
1a94 : e0 0a __ CPX #$0a
1a96 : b0 03 __ BCS $1a9b ; (move_enemies.s1001 + 0)
1a98 : 4c 10 1a JMP $1a10 ; (move_enemies.l2 + 0)
.s1001:
1a9b : 60 __ __ RTS
.s12:
1a9c : c6 46 __ DEC T3 + 0 
1a9e : a5 46 __ LDA T3 + 0 
1aa0 : 91 44 __ STA (T1 + 0),y 
1aa2 : a0 02 __ LDY #$02
1aa4 : b1 44 __ LDA (T1 + 0),y 
1aa6 : c9 85 __ CMP #$85
1aa8 : f0 e7 __ BEQ $1a91 ; (move_enemies.s41 + 0)
.s15:
1aaa : 20 e7 19 JSR $19e7 ; (rand.s0 + 0)
1aad : a0 01 __ LDY #$01
1aaf : b1 44 __ LDA (T1 + 0),y 
1ab1 : 85 47 __ STA T4 + 0 
1ab3 : a9 03 __ LDA #$03
1ab5 : 85 03 __ STA WORK + 0 
1ab7 : a9 00 __ LDA #$00
1ab9 : 85 04 __ STA WORK + 1 
1abb : 20 7a 23 JSR $237a ; (divmod + 0)
1abe : 38 __ __ SEC
1abf : a5 05 __ LDA WORK + 2 
1ac1 : e9 01 __ SBC #$01
1ac3 : aa __ __ TAX
1ac4 : a5 06 __ LDA WORK + 3 
1ac6 : e9 00 __ SBC #$00
1ac8 : a8 __ __ TAY
1ac9 : 8a __ __ TXA
1aca : 18 __ __ CLC
1acb : 65 47 __ ADC T4 + 0 
1acd : 85 1b __ STA ACCU + 0 
1acf : 90 01 __ BCC $1ad2 ; (move_enemies.s1022 + 0)
.s1021:
1ad1 : c8 __ __ INY
.s1022:
1ad2 : 0a __ __ ASL
1ad3 : 0a __ __ ASL
1ad4 : 18 __ __ CLC
1ad5 : 65 1b __ ADC ACCU + 0 
1ad7 : 0a __ __ ASL
1ad8 : 0a __ __ ASL
1ad9 : 0a __ __ ASL
1ada : 18 __ __ CLC
1adb : 65 46 __ ADC T3 + 0 
1add : aa __ __ TAX
1ade : bd 00 c0 LDA $c000,x 
1ae1 : c9 83 __ CMP #$83
1ae3 : f0 ac __ BEQ $1a91 ; (move_enemies.s41 + 0)
.s24:
1ae5 : c9 84 __ CMP #$84
1ae7 : f0 a8 __ BEQ $1a91 ; (move_enemies.s41 + 0)
.s23:
1ae9 : c9 85 __ CMP #$85
1aeb : f0 a4 __ BEQ $1a91 ; (move_enemies.s41 + 0)
.s22:
1aed : 98 __ __ TYA
1aee : d0 a1 __ BNE $1a91 ; (move_enemies.s41 + 0)
.s1005:
1af0 : a5 1b __ LDA ACCU + 0 
1af2 : c9 04 __ CMP #$04
1af4 : 90 9b __ BCC $1a91 ; (move_enemies.s41 + 0)
.s1004:
1af6 : c9 18 __ CMP #$18
1af8 : b0 97 __ BCS $1a91 ; (move_enemies.s41 + 0)
.s18:
1afa : a0 01 __ LDY #$01
1afc : d0 91 __ BNE $1a8f ; (move_enemies.s1020 + 0)
--------------------------------------------------------------------
spawn_enemy_shot:
.s0:
1afe : a0 00 __ LDY #$00
1b00 : b1 0d __ LDA (P0),y ; (e + 0)
1b02 : f0 0f __ BEQ $1b13 ; (spawn_enemy_shot.s1001 + 0)
.s3:
1b04 : a2 00 __ LDX #$00
.l6:
1b06 : bc 55 25 LDY $2555,x ; (__multab3L + 0)
1b09 : b9 3d 26 LDA $263d,y ; (EnemyShot + 2)
1b0c : f0 06 __ BEQ $1b14 ; (spawn_enemy_shot.s9 + 0)
.s7:
1b0e : e8 __ __ INX
1b0f : e0 03 __ CPX #$03
1b11 : 90 f3 __ BCC $1b06 ; (spawn_enemy_shot.l6 + 0)
.s1001:
1b13 : 60 __ __ RTS
.s9:
1b14 : a9 01 __ LDA #$01
1b16 : 99 3d 26 STA $263d,y ; (EnemyShot + 2)
1b19 : a0 00 __ LDY #$00
1b1b : b1 0d __ LDA (P0),y ; (e + 0)
1b1d : 38 __ __ SEC
1b1e : e9 01 __ SBC #$01
1b20 : bc 55 25 LDY $2555,x ; (__multab3L + 0)
1b23 : 99 3b 26 STA $263b,y ; (EnemyShot + 0)
1b26 : a0 01 __ LDY #$01
1b28 : b1 0d __ LDA (P0),y ; (e + 0)
1b2a : bc 55 25 LDY $2555,x ; (__multab3L + 0)
1b2d : 99 3c 26 STA $263c,y ; (EnemyShot + 1)
1b30 : 60 __ __ RTS
--------------------------------------------------------------------
render_enemy_shots:
.s0:
1b31 : a2 00 __ LDX #$00
.l1006:
1b33 : bc 55 25 LDY $2555,x ; (__multab3L + 0)
1b36 : b9 3d 26 LDA $263d,y ; (EnemyShot + 2)
1b39 : c9 01 __ CMP #$01
1b3b : d0 43 __ BNE $1b80 ; (render_enemy_shots.s19 + 0)
.s5:
1b3d : b9 3c 26 LDA $263c,y ; (EnemyShot + 1)
1b40 : 0a __ __ ASL
1b41 : 85 1b __ STA ACCU + 0 
1b43 : a9 00 __ LDA #$00
1b45 : 2a __ __ ROL
1b46 : 06 1b __ ASL ACCU + 0 
1b48 : 2a __ __ ROL
1b49 : 85 1c __ STA ACCU + 1 
1b4b : a5 1b __ LDA ACCU + 0 
1b4d : 79 3c 26 ADC $263c,y ; (EnemyShot + 1)
1b50 : 85 1b __ STA ACCU + 0 
1b52 : a5 1c __ LDA ACCU + 1 
1b54 : 69 00 __ ADC #$00
1b56 : 06 1b __ ASL ACCU + 0 
1b58 : 2a __ __ ROL
1b59 : 06 1b __ ASL ACCU + 0 
1b5b : 2a __ __ ROL
1b5c : 06 1b __ ASL ACCU + 0 
1b5e : 2a __ __ ROL
1b5f : 85 1c __ STA ACCU + 1 
1b61 : 18 __ __ CLC
1b62 : a5 1b __ LDA ACCU + 0 
1b64 : 79 3b 26 ADC $263b,y ; (EnemyShot + 0)
1b67 : 85 1b __ STA ACCU + 0 
1b69 : 85 1f __ STA ADDR + 0 
1b6b : a5 1c __ LDA ACCU + 1 
1b6d : 69 c0 __ ADC #$c0
1b6f : 85 1c __ STA ACCU + 1 
1b71 : 18 __ __ CLC
1b72 : 69 18 __ ADC #$18
1b74 : 85 20 __ STA ADDR + 1 
1b76 : a9 82 __ LDA #$82
1b78 : a0 00 __ LDY #$00
1b7a : 91 1b __ STA (ACCU + 0),y 
1b7c : a9 01 __ LDA #$01
1b7e : 91 1f __ STA (ADDR + 0),y 
.s19:
1b80 : e8 __ __ INX
1b81 : e0 03 __ CPX #$03
1b83 : 90 ae __ BCC $1b33 ; (render_enemy_shots.l1006 + 0)
.s1001:
1b85 : 60 __ __ RTS
--------------------------------------------------------------------
render_enemies:
.s0:
1b86 : a2 00 __ LDX #$00
.l1006:
1b88 : bc 4b 25 LDY $254b,x ; (__multab5L + 0)
1b8b : b9 04 26 LDA $2604,y ; (Enemy + 4)
1b8e : c9 01 __ CMP #$01
1b90 : d0 4b __ BNE $1bdd ; (render_enemies.s19 + 0)
.s5:
1b92 : 84 1d __ STY ACCU + 2 
1b94 : b9 01 26 LDA $2601,y ; (Enemy + 1)
1b97 : 0a __ __ ASL
1b98 : 85 1b __ STA ACCU + 0 
1b9a : a9 00 __ LDA #$00
1b9c : 2a __ __ ROL
1b9d : 06 1b __ ASL ACCU + 0 
1b9f : 2a __ __ ROL
1ba0 : 85 1c __ STA ACCU + 1 
1ba2 : a5 1b __ LDA ACCU + 0 
1ba4 : 79 01 26 ADC $2601,y ; (Enemy + 1)
1ba7 : 85 1b __ STA ACCU + 0 
1ba9 : a5 1c __ LDA ACCU + 1 
1bab : 69 00 __ ADC #$00
1bad : 06 1b __ ASL ACCU + 0 
1baf : 2a __ __ ROL
1bb0 : 06 1b __ ASL ACCU + 0 
1bb2 : 2a __ __ ROL
1bb3 : 06 1b __ ASL ACCU + 0 
1bb5 : 2a __ __ ROL
1bb6 : 85 1c __ STA ACCU + 1 
1bb8 : 18 __ __ CLC
1bb9 : a5 1b __ LDA ACCU + 0 
1bbb : 79 00 26 ADC $2600,y ; (Enemy + 0)
1bbe : 85 43 __ STA T2 + 0 
1bc0 : 85 1b __ STA ACCU + 0 
1bc2 : a5 1c __ LDA ACCU + 1 
1bc4 : 69 c0 __ ADC #$c0
1bc6 : 85 44 __ STA T2 + 1 
1bc8 : 18 __ __ CLC
1bc9 : 69 18 __ ADC #$18
1bcb : 85 1c __ STA ACCU + 1 
1bcd : b9 02 26 LDA $2602,y ; (Enemy + 2)
1bd0 : a0 00 __ LDY #$00
1bd2 : 91 43 __ STA (T2 + 0),y 
1bd4 : a4 1d __ LDY ACCU + 2 
1bd6 : b9 03 26 LDA $2603,y ; (Enemy + 3)
1bd9 : a0 00 __ LDY #$00
1bdb : 91 1b __ STA (ACCU + 0),y 
.s19:
1bdd : e8 __ __ INX
1bde : e0 0a __ CPX #$0a
1be0 : 90 a6 __ BCC $1b88 ; (render_enemies.l1006 + 0)
.s1001:
1be2 : 60 __ __ RTS
--------------------------------------------------------------------
check_shot_enemy_collision:
.s0:
1be3 : a2 00 __ LDX #$00
.l2:
1be5 : 86 1d __ STX ACCU + 2 
1be7 : bc 55 25 LDY $2555,x ; (__multab3L + 0)
1bea : b9 34 26 LDA $2634,y ; (PlayerShot + 2)
1bed : c9 01 __ CMP #$01
1bef : d0 2e __ BNE $1c1f ; (check_shot_enemy_collision.s3 + 0)
.s5:
1bf1 : a2 00 __ LDX #$00
.l9:
1bf3 : 86 43 __ STX T2 + 0 
1bf5 : bc 4b 25 LDY $254b,x ; (__multab5L + 0)
1bf8 : 84 1e __ STY ACCU + 3 
1bfa : b9 04 26 LDA $2604,y ; (Enemy + 4)
1bfd : c9 01 __ CMP #$01
1bff : d0 17 __ BNE $1c18 ; (check_shot_enemy_collision.s114 + 0)
.s12:
1c01 : b9 00 26 LDA $2600,y ; (Enemy + 0)
1c04 : a6 1d __ LDX ACCU + 2 
1c06 : bc 55 25 LDY $2555,x ; (__multab3L + 0)
1c09 : d9 32 26 CMP $2632,y ; (PlayerShot + 0)
1c0c : d0 0a __ BNE $1c18 ; (check_shot_enemy_collision.s114 + 0)
.s18:
1c0e : b9 33 26 LDA $2633,y ; (PlayerShot + 1)
1c11 : a6 1e __ LDX ACCU + 3 
1c13 : dd 01 26 CMP $2601,x ; (Enemy + 1)
1c16 : f0 0f __ BEQ $1c27 ; (check_shot_enemy_collision.s15 + 0)
.s114:
1c18 : a6 43 __ LDX T2 + 0 
1c1a : e8 __ __ INX
1c1b : e0 0a __ CPX #$0a
1c1d : 90 d4 __ BCC $1bf3 ; (check_shot_enemy_collision.l9 + 0)
.s3:
1c1f : a6 1d __ LDX ACCU + 2 
1c21 : e8 __ __ INX
1c22 : e0 03 __ CPX #$03
1c24 : 90 bf __ BCC $1be5 ; (check_shot_enemy_collision.l2 + 0)
.s1001:
1c26 : 60 __ __ RTS
.s15:
1c27 : a9 00 __ LDA #$00
1c29 : 85 44 __ STA T3 + 0 
.l20:
1c2b : bd 01 26 LDA $2601,x ; (Enemy + 1)
1c2e : 0a __ __ ASL
1c2f : 85 1b __ STA ACCU + 0 
1c31 : a9 00 __ LDA #$00
1c33 : 2a __ __ ROL
1c34 : 06 1b __ ASL ACCU + 0 
1c36 : 2a __ __ ROL
1c37 : a8 __ __ TAY
1c38 : a5 1b __ LDA ACCU + 0 
1c3a : 7d 01 26 ADC $2601,x ; (Enemy + 1)
1c3d : 85 1b __ STA ACCU + 0 
1c3f : 98 __ __ TYA
1c40 : 69 00 __ ADC #$00
1c42 : 06 1b __ ASL ACCU + 0 
1c44 : 2a __ __ ROL
1c45 : 06 1b __ ASL ACCU + 0 
1c47 : 2a __ __ ROL
1c48 : 06 1b __ ASL ACCU + 0 
1c4a : 2a __ __ ROL
1c4b : a8 __ __ TAY
1c4c : 18 __ __ CLC
1c4d : a5 1b __ LDA ACCU + 0 
1c4f : 7d 00 26 ADC $2600,x ; (Enemy + 0)
1c52 : 85 1b __ STA ACCU + 0 
1c54 : 98 __ __ TYA
1c55 : 69 c0 __ ADC #$c0
1c57 : 85 1c __ STA ACCU + 1 
1c59 : 18 __ __ CLC
1c5a : 69 18 __ ADC #$18
1c5c : 85 20 __ STA ADDR + 1 
1c5e : a9 86 __ LDA #$86
1c60 : a0 00 __ LDY #$00
1c62 : 84 1f __ STY ADDR + 0 
1c64 : 91 1b __ STA (ACCU + 0),y 
1c66 : a5 44 __ LDA T3 + 0 
1c68 : a4 1b __ LDY ACCU + 0 
1c6a : 91 1f __ STA (ADDR + 0),y 
.l109:
1c6c : ad 11 d0 LDA $d011 
1c6f : 30 fb __ BMI $1c6c ; (check_shot_enemy_collision.l109 + 0)
.l27:
1c71 : ad 11 d0 LDA $d011 
1c74 : 10 fb __ BPL $1c71 ; (check_shot_enemy_collision.l27 + 0)
.s21:
1c76 : e6 44 __ INC T3 + 0 
1c78 : a5 44 __ LDA T3 + 0 
1c7a : c9 08 __ CMP #$08
1c7c : 90 ad __ BCC $1c2b ; (check_shot_enemy_collision.l20 + 0)
.s22:
1c7e : bd 01 26 LDA $2601,x ; (Enemy + 1)
1c81 : 0a __ __ ASL
1c82 : 85 1b __ STA ACCU + 0 
1c84 : a9 00 __ LDA #$00
1c86 : 2a __ __ ROL
1c87 : 06 1b __ ASL ACCU + 0 
1c89 : 2a __ __ ROL
1c8a : a8 __ __ TAY
1c8b : a5 1b __ LDA ACCU + 0 
1c8d : 7d 01 26 ADC $2601,x ; (Enemy + 1)
1c90 : 85 1b __ STA ACCU + 0 
1c92 : 98 __ __ TYA
1c93 : 69 00 __ ADC #$00
1c95 : 06 1b __ ASL ACCU + 0 
1c97 : 2a __ __ ROL
1c98 : 06 1b __ ASL ACCU + 0 
1c9a : 2a __ __ ROL
1c9b : 06 1b __ ASL ACCU + 0 
1c9d : 2a __ __ ROL
1c9e : a8 __ __ TAY
1c9f : 18 __ __ CLC
1ca0 : a5 1b __ LDA ACCU + 0 
1ca2 : 7d 00 26 ADC $2600,x ; (Enemy + 0)
1ca5 : 85 44 __ STA T3 + 0 
1ca7 : 85 1f __ STA ADDR + 0 
1ca9 : 98 __ __ TYA
1caa : 69 c0 __ ADC #$c0
1cac : 85 45 __ STA T3 + 1 
1cae : 18 __ __ CLC
1caf : 69 18 __ ADC #$18
1cb1 : 85 20 __ STA ADDR + 1 
1cb3 : a9 20 __ LDA #$20
1cb5 : a0 00 __ LDY #$00
1cb7 : 91 44 __ STA (T3 + 0),y 
1cb9 : 98 __ __ TYA
1cba : 91 1f __ STA (ADDR + 0),y 
1cbc : 9d 04 26 STA $2604,x ; (Enemy + 4)
1cbf : a6 1d __ LDX ACCU + 2 
1cc1 : bc 55 25 LDY $2555,x ; (__multab3L + 0)
1cc4 : 99 34 26 STA $2634,y ; (PlayerShot + 2)
1cc7 : a6 1e __ LDX ACCU + 3 
1cc9 : bd 02 26 LDA $2602,x ; (Enemy + 2)
1ccc : c9 83 __ CMP #$83
1cce : f0 2b __ BEQ $1cfb ; (check_shot_enemy_collision.s30 + 0)
.s31:
1cd0 : c9 84 __ CMP #$84
1cd2 : f0 03 __ BEQ $1cd7 ; (check_shot_enemy_collision.s33 + 0)
1cd4 : 4c 18 1c JMP $1c18 ; (check_shot_enemy_collision.s114 + 0)
.s33:
1cd7 : ad e9 25 LDA $25e9 ; (game + 1)
1cda : 18 __ __ CLC
1cdb : 69 19 __ ADC #$19
.s118:
1cdd : 8d e9 25 STA $25e9 ; (game + 1)
1ce0 : ad ea 25 LDA $25ea ; (game + 2)
1ce3 : 69 00 __ ADC #$00
1ce5 : 8d ea 25 STA $25ea ; (game + 2)
1ce8 : ad eb 25 LDA $25eb ; (game + 3)
1ceb : 69 00 __ ADC #$00
1ced : 8d eb 25 STA $25eb ; (game + 3)
1cf0 : b0 03 __ BCS $1cf5 ; (check_shot_enemy_collision.s1019 + 0)
1cf2 : 4c 18 1c JMP $1c18 ; (check_shot_enemy_collision.s114 + 0)
.s1019:
1cf5 : ee ec 25 INC $25ec ; (game + 4)
1cf8 : 4c 18 1c JMP $1c18 ; (check_shot_enemy_collision.s114 + 0)
.s30:
1cfb : ad e9 25 LDA $25e9 ; (game + 1)
1cfe : 18 __ __ CLC
1cff : 69 32 __ ADC #$32
1d01 : 4c dd 1c JMP $1cdd ; (check_shot_enemy_collision.s118 + 0)
--------------------------------------------------------------------
move_enemy_shots:
.s0:
1d04 : a2 00 __ LDX #$00
.l1008:
1d06 : bc 55 25 LDY $2555,x ; (__multab3L + 0)
1d09 : b9 3d 26 LDA $263d,y ; (EnemyShot + 2)
1d0c : c9 01 __ CMP #$01
1d0e : d0 58 __ BNE $1d68 ; (move_enemy_shots.s23 + 0)
.s5:
1d10 : 84 1d __ STY ACCU + 2 
1d12 : b9 3c 26 LDA $263c,y ; (EnemyShot + 1)
1d15 : 0a __ __ ASL
1d16 : 85 1b __ STA ACCU + 0 
1d18 : a9 00 __ LDA #$00
1d1a : 2a __ __ ROL
1d1b : 06 1b __ ASL ACCU + 0 
1d1d : 2a __ __ ROL
1d1e : 85 1c __ STA ACCU + 1 
1d20 : a5 1b __ LDA ACCU + 0 
1d22 : 79 3c 26 ADC $263c,y ; (EnemyShot + 1)
1d25 : 85 1b __ STA ACCU + 0 
1d27 : a5 1c __ LDA ACCU + 1 
1d29 : 69 00 __ ADC #$00
1d2b : 06 1b __ ASL ACCU + 0 
1d2d : 2a __ __ ROL
1d2e : 06 1b __ ASL ACCU + 0 
1d30 : 2a __ __ ROL
1d31 : 06 1b __ ASL ACCU + 0 
1d33 : 2a __ __ ROL
1d34 : 85 1c __ STA ACCU + 1 
1d36 : b9 3b 26 LDA $263b,y ; (EnemyShot + 0)
1d39 : 85 1e __ STA ACCU + 3 
1d3b : 18 __ __ CLC
1d3c : 65 1b __ ADC ACCU + 0 
1d3e : 85 1b __ STA ACCU + 0 
1d40 : 85 1f __ STA ADDR + 0 
1d42 : a5 1c __ LDA ACCU + 1 
1d44 : 69 c0 __ ADC #$c0
1d46 : 85 1c __ STA ACCU + 1 
1d48 : 18 __ __ CLC
1d49 : 69 18 __ ADC #$18
1d4b : 85 20 __ STA ADDR + 1 
1d4d : a9 20 __ LDA #$20
1d4f : a0 00 __ LDY #$00
1d51 : 91 1b __ STA (ACCU + 0),y 
1d53 : 98 __ __ TYA
1d54 : 91 1f __ STA (ADDR + 0),y 
1d56 : c6 1e __ DEC ACCU + 3 
1d58 : a5 1e __ LDA ACCU + 3 
1d5a : a4 1d __ LDY ACCU + 2 
1d5c : 99 3b 26 STA $263b,y ; (EnemyShot + 0)
1d5f : c9 ff __ CMP #$ff
1d61 : d0 05 __ BNE $1d68 ; (move_enemy_shots.s23 + 0)
.s8:
1d63 : a9 00 __ LDA #$00
1d65 : 99 3d 26 STA $263d,y ; (EnemyShot + 2)
.s23:
1d68 : e8 __ __ INX
1d69 : e0 03 __ CPX #$03
1d6b : 90 99 __ BCC $1d06 ; (move_enemy_shots.l1008 + 0)
.s1001:
1d6d : 60 __ __ RTS
--------------------------------------------------------------------
check_player_enemy_collision:
.s0:
1d6e : a0 00 __ LDY #$00
.l2:
1d70 : be 4b 25 LDX $254b,y ; (__multab5L + 0)
1d73 : bd 04 26 LDA $2604,x ; (Enemy + 4)
1d76 : c9 01 __ CMP #$01
1d78 : d0 10 __ BNE $1d8a ; (check_player_enemy_collision.s3 + 0)
.s5:
1d7a : bd 00 26 LDA $2600,x ; (Enemy + 0)
1d7d : cd f8 25 CMP $25f8 ; (Player + 0)
1d80 : d0 08 __ BNE $1d8a ; (check_player_enemy_collision.s3 + 0)
.s11:
1d82 : bd 01 26 LDA $2601,x ; (Enemy + 1)
1d85 : cd f9 25 CMP $25f9 ; (Player + 1)
1d88 : f0 30 __ BEQ $1dba ; (check_player_enemy_collision.s8 + 0)
.s3:
1d8a : c8 __ __ INY
1d8b : c0 0a __ CPY #$0a
1d8d : 90 e1 __ BCC $1d70 ; (check_player_enemy_collision.l2 + 0)
.s4:
1d8f : a0 00 __ LDY #$00
.l13:
1d91 : be 55 25 LDX $2555,y ; (__multab3L + 0)
1d94 : bd 3d 26 LDA $263d,x ; (EnemyShot + 2)
1d97 : c9 01 __ CMP #$01
1d99 : d0 10 __ BNE $1dab ; (check_player_enemy_collision.s14 + 0)
.s16:
1d9b : bd 3b 26 LDA $263b,x ; (EnemyShot + 0)
1d9e : cd f8 25 CMP $25f8 ; (Player + 0)
1da1 : d0 08 __ BNE $1dab ; (check_player_enemy_collision.s14 + 0)
.s22:
1da3 : bd 3c 26 LDA $263c,x ; (EnemyShot + 1)
1da6 : cd f9 25 CMP $25f9 ; (Player + 1)
1da9 : f0 06 __ BEQ $1db1 ; (check_player_enemy_collision.s19 + 0)
.s14:
1dab : c8 __ __ INY
1dac : c0 03 __ CPY #$03
1dae : 90 e1 __ BCC $1d91 ; (check_player_enemy_collision.l13 + 0)
.s1001:
1db0 : 60 __ __ RTS
.s19:
1db1 : 20 c4 1d JSR $1dc4 ; (render_player_dead.s0 + 0)
1db4 : a9 02 __ LDA #$02
1db6 : 8d e8 25 STA $25e8 ; (game + 0)
1db9 : 60 __ __ RTS
.s8:
1dba : 20 c4 1d JSR $1dc4 ; (render_player_dead.s0 + 0)
1dbd : a9 02 __ LDA #$02
1dbf : 8d e8 25 STA $25e8 ; (game + 0)
1dc2 : d0 cb __ BNE $1d8f ; (check_player_enemy_collision.s4 + 0)
--------------------------------------------------------------------
render_player_dead:
.s0:
1dc4 : ad f9 25 LDA $25f9 ; (Player + 1)
1dc7 : 85 1e __ STA ACCU + 3 
1dc9 : ad f8 25 LDA $25f8 ; (Player + 0)
1dcc : 85 43 __ STA T2 + 0 
1dce : a9 00 __ LDA #$00
1dd0 : 85 1d __ STA ACCU + 2 
.l2:
1dd2 : a9 ff __ LDA #$ff
1dd4 : 85 44 __ STA T3 + 0 
.l6:
1dd6 : 29 80 __ AND #$80
1dd8 : 10 02 __ BPL $1ddc ; (render_player_dead.l6 + 6)
1dda : a9 ff __ LDA #$ff
1ddc : aa __ __ TAX
1ddd : 18 __ __ CLC
1dde : a5 44 __ LDA T3 + 0 
1de0 : 65 1e __ ADC ACCU + 3 
1de2 : a8 __ __ TAY
1de3 : 90 01 __ BCC $1de6 ; (render_player_dead.s1009 + 0)
.s1008:
1de5 : e8 __ __ INX
.s1009:
1de6 : 86 1c __ STX ACCU + 1 
1de8 : 0a __ __ ASL
1de9 : 85 1b __ STA ACCU + 0 
1deb : 8a __ __ TXA
1dec : 2a __ __ ROL
1ded : 06 1b __ ASL ACCU + 0 
1def : 2a __ __ ROL
1df0 : aa __ __ TAX
1df1 : 98 __ __ TYA
1df2 : 18 __ __ CLC
1df3 : 65 1b __ ADC ACCU + 0 
1df5 : 85 1b __ STA ACCU + 0 
1df7 : 8a __ __ TXA
1df8 : 65 1c __ ADC ACCU + 1 
1dfa : 06 1b __ ASL ACCU + 0 
1dfc : 2a __ __ ROL
1dfd : 06 1b __ ASL ACCU + 0 
1dff : 2a __ __ ROL
1e00 : 06 1b __ ASL ACCU + 0 
1e02 : 2a __ __ ROL
1e03 : aa __ __ TAX
1e04 : 18 __ __ CLC
1e05 : a9 ff __ LDA #$ff
1e07 : 65 1b __ ADC ACCU + 0 
1e09 : a8 __ __ TAY
1e0a : 8a __ __ TXA
1e0b : 69 d7 __ ADC #$d7
1e0d : aa __ __ TAX
1e0e : 98 __ __ TYA
1e0f : 18 __ __ CLC
1e10 : 65 43 __ ADC T2 + 0 
1e12 : 85 1b __ STA ACCU + 0 
1e14 : 85 45 __ STA T5 + 0 
1e16 : 8a __ __ TXA
1e17 : 69 00 __ ADC #$00
1e19 : 85 1c __ STA ACCU + 1 
1e1b : 18 __ __ CLC
1e1c : 69 e8 __ ADC #$e8
1e1e : 85 46 __ STA T5 + 1 
1e20 : a0 00 __ LDY #$00
1e22 : a2 03 __ LDX #$03
.l1006:
1e24 : a9 86 __ LDA #$86
1e26 : 91 45 __ STA (T5 + 0),y 
1e28 : a5 1d __ LDA ACCU + 2 
1e2a : 91 1b __ STA (ACCU + 0),y 
1e2c : e6 45 __ INC T5 + 0 
1e2e : d0 02 __ BNE $1e32 ; (render_player_dead.s1011 + 0)
.s1010:
1e30 : e6 46 __ INC T5 + 1 
.s1011:
1e32 : e6 1b __ INC ACCU + 0 
1e34 : d0 02 __ BNE $1e38 ; (render_player_dead.s1013 + 0)
.s1012:
1e36 : e6 1c __ INC ACCU + 1 
.s1013:
1e38 : ca __ __ DEX
1e39 : d0 e9 __ BNE $1e24 ; (render_player_dead.l1006 + 0)
.s1007:
1e3b : e6 44 __ INC T3 + 0 
1e3d : a5 44 __ LDA T3 + 0 
1e3f : c9 02 __ CMP #$02
1e41 : 90 93 __ BCC $1dd6 ; (render_player_dead.l6 + 0)
.l14:
1e43 : ad 11 d0 LDA $d011 
1e46 : 30 fb __ BMI $1e43 ; (render_player_dead.l14 + 0)
.l17:
1e48 : ad 11 d0 LDA $d011 
1e4b : 10 fb __ BPL $1e48 ; (render_player_dead.l17 + 0)
.s3:
1e4d : e6 1d __ INC ACCU + 2 
1e4f : a5 1d __ LDA ACCU + 2 
1e51 : c9 1e __ CMP #$1e
1e53 : b0 03 __ BCS $1e58 ; (render_player_dead.s1001 + 0)
1e55 : 4c d2 1d JMP $1dd2 ; (render_player_dead.l2 + 0)
.s1001:
1e58 : 60 __ __ RTS
--------------------------------------------------------------------
control_player_ship:
.s0:
1e59 : a9 00 __ LDA #$00
1e5b : 20 fd 1e JSR $1efd ; (joy_poll.s0 + 0)
1e5e : ad fc 25 LDA $25fc ; (joyx + 0)
1e61 : 85 1d __ STA ACCU + 2 
1e63 : 85 1e __ STA ACCU + 3 
1e65 : d0 08 __ BNE $1e6f ; (control_player_ship.s1 + 0)
.s4:
1e67 : ad fa 25 LDA $25fa ; (joyy + 0)
1e6a : d0 03 __ BNE $1e6f ; (control_player_ship.s1 + 0)
1e6c : 4c f2 1e JMP $1ef2 ; (control_player_ship.s3 + 0)
.s1:
1e6f : ad f8 25 LDA $25f8 ; (Player + 0)
1e72 : 85 43 __ STA T2 + 0 
1e74 : 85 44 __ STA T3 + 0 
1e76 : ad f9 25 LDA $25f9 ; (Player + 1)
1e79 : 85 45 __ STA T4 + 0 
1e7b : 85 46 __ STA T5 + 0 
1e7d : 0a __ __ ASL
1e7e : 85 1b __ STA ACCU + 0 
1e80 : a9 00 __ LDA #$00
1e82 : 2a __ __ ROL
1e83 : 06 1b __ ASL ACCU + 0 
1e85 : 2a __ __ ROL
1e86 : aa __ __ TAX
1e87 : a5 1b __ LDA ACCU + 0 
1e89 : 65 45 __ ADC T4 + 0 
1e8b : 85 1b __ STA ACCU + 0 
1e8d : 8a __ __ TXA
1e8e : 69 00 __ ADC #$00
1e90 : 06 1b __ ASL ACCU + 0 
1e92 : 2a __ __ ROL
1e93 : 06 1b __ ASL ACCU + 0 
1e95 : 2a __ __ ROL
1e96 : 06 1b __ ASL ACCU + 0 
1e98 : 2a __ __ ROL
1e99 : aa __ __ TAX
1e9a : 18 __ __ CLC
1e9b : a5 1b __ LDA ACCU + 0 
1e9d : 65 43 __ ADC T2 + 0 
1e9f : 85 1b __ STA ACCU + 0 
1ea1 : 85 1f __ STA ADDR + 0 
1ea3 : 8a __ __ TXA
1ea4 : 69 c0 __ ADC #$c0
1ea6 : 85 1c __ STA ACCU + 1 
1ea8 : 18 __ __ CLC
1ea9 : 69 18 __ ADC #$18
1eab : 85 20 __ STA ADDR + 1 
1ead : a9 20 __ LDA #$20
1eaf : a0 00 __ LDY #$00
1eb1 : 91 1b __ STA (ACCU + 0),y 
1eb3 : 98 __ __ TYA
1eb4 : 91 1f __ STA (ADDR + 0),y 
1eb6 : a5 43 __ LDA T2 + 0 
1eb8 : c9 02 __ CMP #$02
1eba : 90 06 __ BCC $1ec2 ; (control_player_ship.s6 + 0)
.s8:
1ebc : a5 1d __ LDA ACCU + 2 
1ebe : 30 0c __ BMI $1ecc ; (control_player_ship.s5 + 0)
.s1015:
1ec0 : a5 43 __ LDA T2 + 0 
.s6:
1ec2 : c9 26 __ CMP #$26
1ec4 : b0 0e __ BCS $1ed4 ; (control_player_ship.s7 + 0)
.s12:
1ec6 : a5 1d __ LDA ACCU + 2 
1ec8 : 30 0a __ BMI $1ed4 ; (control_player_ship.s7 + 0)
.s1009:
1eca : f0 08 __ BEQ $1ed4 ; (control_player_ship.s7 + 0)
.s5:
1ecc : 18 __ __ CLC
1ecd : a5 44 __ LDA T3 + 0 
1ecf : 65 1e __ ADC ACCU + 3 
1ed1 : 8d f8 25 STA $25f8 ; (Player + 0)
.s7:
1ed4 : a5 45 __ LDA T4 + 0 
1ed6 : c9 05 __ CMP #$05
1ed8 : 90 07 __ BCC $1ee1 ; (control_player_ship.s14 + 0)
.s16:
1eda : ad fa 25 LDA $25fa ; (joyy + 0)
1edd : 30 0d __ BMI $1eec ; (control_player_ship.s32 + 0)
.s1014:
1edf : a5 45 __ LDA T4 + 0 
.s14:
1ee1 : c9 17 __ CMP #$17
1ee3 : b0 0d __ BCS $1ef2 ; (control_player_ship.s3 + 0)
.s20:
1ee5 : ad fa 25 LDA $25fa ; (joyy + 0)
1ee8 : 30 08 __ BMI $1ef2 ; (control_player_ship.s3 + 0)
.s1004:
1eea : f0 06 __ BEQ $1ef2 ; (control_player_ship.s3 + 0)
.s32:
1eec : 18 __ __ CLC
1eed : 65 46 __ ADC T5 + 0 
1eef : 8d f9 25 STA $25f9 ; (Player + 1)
.s3:
1ef2 : ad fe 25 LDA $25fe ; (joyb + 0)
1ef5 : c9 01 __ CMP #$01
1ef7 : f0 01 __ BEQ $1efa ; (control_player_ship.s21 + 0)
.s1001:
1ef9 : 60 __ __ RTS
.s21:
1efa : 4c 3d 1f JMP $1f3d ; (spawn_player_shot.s0 + 0)
--------------------------------------------------------------------
joy_poll:
.s0:
1efd : aa __ __ TAX
1efe : bd 00 dc LDA $dc00,x 
1f01 : a8 __ __ TAY
1f02 : 29 10 __ AND #$10
1f04 : f0 04 __ BEQ $1f0a ; (joy_poll.s1005 + 0)
.s1006:
1f06 : a9 00 __ LDA #$00
1f08 : f0 02 __ BEQ $1f0c ; (joy_poll.s1007 + 0)
.s1005:
1f0a : a9 01 __ LDA #$01
.s1007:
1f0c : 9d fe 25 STA $25fe,x ; (joyb + 0)
1f0f : 98 __ __ TYA
1f10 : 4a __ __ LSR
1f11 : b0 1d __ BCS $1f30 ; (joy_poll.s2 + 0)
.s1:
1f13 : a9 ff __ LDA #$ff
.s15:
1f15 : 9d fa 25 STA $25fa,x ; (joyy + 0)
1f18 : 98 __ __ TYA
1f19 : 29 04 __ AND #$04
1f1b : d0 06 __ BNE $1f23 ; (joy_poll.s8 + 0)
.s7:
1f1d : a9 ff __ LDA #$ff
.s1001:
1f1f : 9d fc 25 STA $25fc,x ; (joyx + 0)
1f22 : 60 __ __ RTS
.s8:
1f23 : 98 __ __ TYA
1f24 : 29 08 __ AND #$08
1f26 : f0 04 __ BEQ $1f2c ; (joy_poll.s1011 + 0)
.s1012:
1f28 : a9 00 __ LDA #$00
1f2a : f0 f3 __ BEQ $1f1f ; (joy_poll.s1001 + 0)
.s1011:
1f2c : a9 01 __ LDA #$01
1f2e : d0 ef __ BNE $1f1f ; (joy_poll.s1001 + 0)
.s2:
1f30 : 98 __ __ TYA
1f31 : 29 02 __ AND #$02
1f33 : f0 04 __ BEQ $1f39 ; (joy_poll.s1008 + 0)
.s1009:
1f35 : a9 00 __ LDA #$00
1f37 : f0 dc __ BEQ $1f15 ; (joy_poll.s15 + 0)
.s1008:
1f39 : a9 01 __ LDA #$01
1f3b : d0 d8 __ BNE $1f15 ; (joy_poll.s15 + 0)
--------------------------------------------------------------------
joyy:
25fa : __ __ __ BSS	2
--------------------------------------------------------------------
joyx:
25fc : __ __ __ BSS	2
--------------------------------------------------------------------
joyb:
25fe : __ __ __ BSS	2
--------------------------------------------------------------------
spawn_player_shot:
.s0:
1f3d : ad f8 25 LDA $25f8 ; (Player + 0)
1f40 : c9 26 __ CMP #$26
1f42 : f0 0f __ BEQ $1f53 ; (spawn_player_shot.s1001 + 0)
.s3:
1f44 : a0 00 __ LDY #$00
.l6:
1f46 : be 55 25 LDX $2555,y ; (__multab3L + 0)
1f49 : bd 34 26 LDA $2634,x ; (PlayerShot + 2)
1f4c : f0 06 __ BEQ $1f54 ; (spawn_player_shot.s9 + 0)
.s7:
1f4e : c8 __ __ INY
1f4f : c0 03 __ CPY #$03
1f51 : 90 f3 __ BCC $1f46 ; (spawn_player_shot.l6 + 0)
.s1001:
1f53 : 60 __ __ RTS
.s9:
1f54 : a9 01 __ LDA #$01
1f56 : 9d 34 26 STA $2634,x ; (PlayerShot + 2)
1f59 : ad f9 25 LDA $25f9 ; (Player + 1)
1f5c : 9d 33 26 STA $2633,x ; (PlayerShot + 1)
1f5f : ad fc 25 LDA $25fc ; (joyx + 0)
1f62 : 30 02 __ BMI $1f66 ; (spawn_player_shot.s13 + 0)
.s1007:
1f64 : d0 06 __ BNE $1f6c ; (spawn_player_shot.s12 + 0)
.s13:
1f66 : ad f8 25 LDA $25f8 ; (Player + 0)
1f69 : 4c 72 1f JMP $1f72 ; (spawn_player_shot.s1010 + 0)
.s12:
1f6c : ad f8 25 LDA $25f8 ; (Player + 0)
1f6f : 18 __ __ CLC
1f70 : 69 01 __ ADC #$01
.s1010:
1f72 : be 55 25 LDX $2555,y ; (__multab3L + 0)
1f75 : 9d 32 26 STA $2632,x ; (PlayerShot + 0)
1f78 : 60 __ __ RTS
--------------------------------------------------------------------
render_player_ship:
.s0:
1f79 : ad f9 25 LDA $25f9 ; (Player + 1)
1f7c : 0a __ __ ASL
1f7d : 85 1b __ STA ACCU + 0 
1f7f : a9 00 __ LDA #$00
1f81 : 2a __ __ ROL
1f82 : 06 1b __ ASL ACCU + 0 
1f84 : 2a __ __ ROL
1f85 : aa __ __ TAX
1f86 : a5 1b __ LDA ACCU + 0 
1f88 : 6d f9 25 ADC $25f9 ; (Player + 1)
1f8b : 85 1b __ STA ACCU + 0 
1f8d : 8a __ __ TXA
1f8e : 69 00 __ ADC #$00
1f90 : 06 1b __ ASL ACCU + 0 
1f92 : 2a __ __ ROL
1f93 : 06 1b __ ASL ACCU + 0 
1f95 : 2a __ __ ROL
1f96 : 06 1b __ ASL ACCU + 0 
1f98 : 2a __ __ ROL
1f99 : aa __ __ TAX
1f9a : 18 __ __ CLC
1f9b : a5 1b __ LDA ACCU + 0 
1f9d : 6d f8 25 ADC $25f8 ; (Player + 0)
1fa0 : 85 1b __ STA ACCU + 0 
1fa2 : 85 1f __ STA ADDR + 0 
1fa4 : 8a __ __ TXA
1fa5 : 69 c0 __ ADC #$c0
1fa7 : 85 1c __ STA ACCU + 1 
1fa9 : 18 __ __ CLC
1faa : 69 18 __ ADC #$18
1fac : 85 20 __ STA ADDR + 1 
1fae : a9 80 __ LDA #$80
1fb0 : a0 00 __ LDY #$00
1fb2 : 91 1b __ STA (ACCU + 0),y 
1fb4 : a9 03 __ LDA #$03
1fb6 : 91 1f __ STA (ADDR + 0),y 
.s1001:
1fb8 : 60 __ __ RTS
--------------------------------------------------------------------
move_player_shots:
.s0:
1fb9 : a2 00 __ LDX #$00
.l2:
1fbb : 86 1d __ STX ACCU + 2 
1fbd : bc 55 25 LDY $2555,x ; (__multab3L + 0)
1fc0 : b9 34 26 LDA $2634,y ; (PlayerShot + 2)
1fc3 : c9 01 __ CMP #$01
1fc5 : d0 52 __ BNE $2019 ; (move_player_shots.s23 + 0)
.s5:
1fc7 : 84 1e __ STY ACCU + 3 
1fc9 : b9 33 26 LDA $2633,y ; (PlayerShot + 1)
1fcc : 0a __ __ ASL
1fcd : 85 1b __ STA ACCU + 0 
1fcf : a9 00 __ LDA #$00
1fd1 : 2a __ __ ROL
1fd2 : 06 1b __ ASL ACCU + 0 
1fd4 : 2a __ __ ROL
1fd5 : aa __ __ TAX
1fd6 : a5 1b __ LDA ACCU + 0 
1fd8 : 79 33 26 ADC $2633,y ; (PlayerShot + 1)
1fdb : 85 1b __ STA ACCU + 0 
1fdd : 8a __ __ TXA
1fde : 69 00 __ ADC #$00
1fe0 : 06 1b __ ASL ACCU + 0 
1fe2 : 2a __ __ ROL
1fe3 : 06 1b __ ASL ACCU + 0 
1fe5 : 2a __ __ ROL
1fe6 : 06 1b __ ASL ACCU + 0 
1fe8 : 2a __ __ ROL
1fe9 : 85 1c __ STA ACCU + 1 
1feb : b9 32 26 LDA $2632,y ; (PlayerShot + 0)
1fee : aa __ __ TAX
1fef : 18 __ __ CLC
1ff0 : 65 1b __ ADC ACCU + 0 
1ff2 : 85 1b __ STA ACCU + 0 
1ff4 : 85 1f __ STA ADDR + 0 
1ff6 : a5 1c __ LDA ACCU + 1 
1ff8 : 69 c0 __ ADC #$c0
1ffa : 85 1c __ STA ACCU + 1 
1ffc : 18 __ __ CLC
1ffd : 69 18 __ ADC #$18
1fff : 85 20 __ STA ADDR + 1 
2001 : a9 20 __ LDA #$20
2003 : a0 00 __ LDY #$00
2005 : 91 1b __ STA (ACCU + 0),y 
2007 : 98 __ __ TYA
2008 : 91 1f __ STA (ADDR + 0),y 
200a : e8 __ __ INX
200b : 8a __ __ TXA
200c : a6 1e __ LDX ACCU + 3 
200e : 9d 32 26 STA $2632,x ; (PlayerShot + 0)
2011 : c9 27 __ CMP #$27
2013 : 90 04 __ BCC $2019 ; (move_player_shots.s23 + 0)
.s8:
2015 : 98 __ __ TYA
2016 : 9d 34 26 STA $2634,x ; (PlayerShot + 2)
.s23:
2019 : a6 1d __ LDX ACCU + 2 
201b : e8 __ __ INX
201c : e0 03 __ CPX #$03
201e : 90 9b __ BCC $1fbb ; (move_player_shots.l2 + 0)
.s1001:
2020 : 60 __ __ RTS
--------------------------------------------------------------------
render_player_shots:
.s0:
2021 : a2 00 __ LDX #$00
.l1006:
2023 : bc 55 25 LDY $2555,x ; (__multab3L + 0)
2026 : b9 34 26 LDA $2634,y ; (PlayerShot + 2)
2029 : c9 01 __ CMP #$01
202b : d0 43 __ BNE $2070 ; (render_player_shots.s19 + 0)
.s5:
202d : b9 33 26 LDA $2633,y ; (PlayerShot + 1)
2030 : 0a __ __ ASL
2031 : 85 1b __ STA ACCU + 0 
2033 : a9 00 __ LDA #$00
2035 : 2a __ __ ROL
2036 : 06 1b __ ASL ACCU + 0 
2038 : 2a __ __ ROL
2039 : 85 1c __ STA ACCU + 1 
203b : a5 1b __ LDA ACCU + 0 
203d : 79 33 26 ADC $2633,y ; (PlayerShot + 1)
2040 : 85 1b __ STA ACCU + 0 
2042 : a5 1c __ LDA ACCU + 1 
2044 : 69 00 __ ADC #$00
2046 : 06 1b __ ASL ACCU + 0 
2048 : 2a __ __ ROL
2049 : 06 1b __ ASL ACCU + 0 
204b : 2a __ __ ROL
204c : 06 1b __ ASL ACCU + 0 
204e : 2a __ __ ROL
204f : 85 1c __ STA ACCU + 1 
2051 : 18 __ __ CLC
2052 : a5 1b __ LDA ACCU + 0 
2054 : 79 32 26 ADC $2632,y ; (PlayerShot + 0)
2057 : 85 1b __ STA ACCU + 0 
2059 : 85 1f __ STA ADDR + 0 
205b : a5 1c __ LDA ACCU + 1 
205d : 69 c0 __ ADC #$c0
205f : 85 1c __ STA ACCU + 1 
2061 : 18 __ __ CLC
2062 : 69 18 __ ADC #$18
2064 : 85 20 __ STA ADDR + 1 
2066 : a9 81 __ LDA #$81
2068 : a0 00 __ LDY #$00
206a : 91 1b __ STA (ACCU + 0),y 
206c : a9 01 __ LDA #$01
206e : 91 1f __ STA (ADDR + 0),y 
.s19:
2070 : e8 __ __ INX
2071 : e0 03 __ CPX #$03
2073 : 90 ae __ BCC $2023 ; (render_player_shots.l1006 + 0)
.s1001:
2075 : 60 __ __ RTS
--------------------------------------------------------------------
wait_frames:
.s0:
2076 : a5 0e __ LDA P1 ; (frames + 1)
2078 : 30 1c __ BMI $2096 ; (wait_frames.s1001 + 0)
.s1005:
207a : 05 0d __ ORA P0 ; (frames + 0)
207c : f0 18 __ BEQ $2096 ; (wait_frames.s1001 + 0)
.s13:
207e : a0 00 __ LDY #$00
2080 : a6 0e __ LDX P1 ; (frames + 1)
.l6:
2082 : ad 11 d0 LDA $d011 
2085 : 30 fb __ BMI $2082 ; (wait_frames.l6 + 0)
.l9:
2087 : ad 11 d0 LDA $d011 
208a : 10 fb __ BPL $2087 ; (wait_frames.l9 + 0)
.s3:
208c : c8 __ __ INY
208d : 8a __ __ TXA
208e : 30 06 __ BMI $2096 ; (wait_frames.s1001 + 0)
.s1004:
2090 : d0 f0 __ BNE $2082 ; (wait_frames.l6 + 0)
.s1002:
2092 : c4 0d __ CPY P0 ; (frames + 0)
2094 : 90 ec __ BCC $2082 ; (wait_frames.l6 + 0)
.s1001:
2096 : 60 __ __ RTS
--------------------------------------------------------------------
freg:
2097 : b1 19 __ LDA (IP + 0),y 
2099 : c8 __ __ INY
209a : aa __ __ TAX
209b : b5 00 __ LDA $00,x 
209d : 85 03 __ STA WORK + 0 
209f : b5 01 __ LDA $01,x 
20a1 : 85 04 __ STA WORK + 1 
20a3 : b5 02 __ LDA $02,x 
20a5 : 85 05 __ STA WORK + 2 
20a7 : b5 03 __ LDA WORK + 0,x 
20a9 : 85 06 __ STA WORK + 3 
20ab : a5 05 __ LDA WORK + 2 
20ad : 0a __ __ ASL
20ae : a5 06 __ LDA WORK + 3 
20b0 : 2a __ __ ROL
20b1 : 85 08 __ STA WORK + 5 
20b3 : f0 06 __ BEQ $20bb ; (freg + 36)
20b5 : a5 05 __ LDA WORK + 2 
20b7 : 09 80 __ ORA #$80
20b9 : 85 05 __ STA WORK + 2 
20bb : a5 1d __ LDA ACCU + 2 
20bd : 0a __ __ ASL
20be : a5 1e __ LDA ACCU + 3 
20c0 : 2a __ __ ROL
20c1 : 85 07 __ STA WORK + 4 
20c3 : f0 06 __ BEQ $20cb ; (freg + 52)
20c5 : a5 1d __ LDA ACCU + 2 
20c7 : 09 80 __ ORA #$80
20c9 : 85 1d __ STA ACCU + 2 
20cb : 60 __ __ RTS
20cc : 06 1e __ ASL ACCU + 3 
20ce : a5 07 __ LDA WORK + 4 
20d0 : 6a __ __ ROR
20d1 : 85 1e __ STA ACCU + 3 
20d3 : b0 06 __ BCS $20db ; (freg + 68)
20d5 : a5 1d __ LDA ACCU + 2 
20d7 : 29 7f __ AND #$7f
20d9 : 85 1d __ STA ACCU + 2 
20db : 60 __ __ RTS
--------------------------------------------------------------------
faddsub:
20dc : a9 ff __ LDA #$ff
20de : c5 07 __ CMP WORK + 4 
20e0 : f0 04 __ BEQ $20e6 ; (faddsub + 10)
20e2 : c5 08 __ CMP WORK + 5 
20e4 : d0 11 __ BNE $20f7 ; (faddsub + 27)
20e6 : a5 1e __ LDA ACCU + 3 
20e8 : 09 7f __ ORA #$7f
20ea : 85 1e __ STA ACCU + 3 
20ec : a9 80 __ LDA #$80
20ee : 85 1d __ STA ACCU + 2 
20f0 : a9 00 __ LDA #$00
20f2 : 85 1b __ STA ACCU + 0 
20f4 : 85 1c __ STA ACCU + 1 
20f6 : 60 __ __ RTS
20f7 : 38 __ __ SEC
20f8 : a5 07 __ LDA WORK + 4 
20fa : e5 08 __ SBC WORK + 5 
20fc : f0 38 __ BEQ $2136 ; (faddsub + 90)
20fe : aa __ __ TAX
20ff : b0 25 __ BCS $2126 ; (faddsub + 74)
2101 : e0 e9 __ CPX #$e9
2103 : b0 0e __ BCS $2113 ; (faddsub + 55)
2105 : a5 08 __ LDA WORK + 5 
2107 : 85 07 __ STA WORK + 4 
2109 : a9 00 __ LDA #$00
210b : 85 1b __ STA ACCU + 0 
210d : 85 1c __ STA ACCU + 1 
210f : 85 1d __ STA ACCU + 2 
2111 : f0 23 __ BEQ $2136 ; (faddsub + 90)
2113 : a5 1d __ LDA ACCU + 2 
2115 : 4a __ __ LSR
2116 : 66 1c __ ROR ACCU + 1 
2118 : 66 1b __ ROR ACCU + 0 
211a : e8 __ __ INX
211b : d0 f8 __ BNE $2115 ; (faddsub + 57)
211d : 85 1d __ STA ACCU + 2 
211f : a5 08 __ LDA WORK + 5 
2121 : 85 07 __ STA WORK + 4 
2123 : 4c 36 21 JMP $2136 ; (faddsub + 90)
2126 : e0 18 __ CPX #$18
2128 : b0 33 __ BCS $215d ; (faddsub + 129)
212a : a5 05 __ LDA WORK + 2 
212c : 4a __ __ LSR
212d : 66 04 __ ROR WORK + 1 
212f : 66 03 __ ROR WORK + 0 
2131 : ca __ __ DEX
2132 : d0 f8 __ BNE $212c ; (faddsub + 80)
2134 : 85 05 __ STA WORK + 2 
2136 : a5 1e __ LDA ACCU + 3 
2138 : 29 80 __ AND #$80
213a : 85 1e __ STA ACCU + 3 
213c : 45 06 __ EOR WORK + 3 
213e : 30 31 __ BMI $2171 ; (faddsub + 149)
2140 : 18 __ __ CLC
2141 : a5 1b __ LDA ACCU + 0 
2143 : 65 03 __ ADC WORK + 0 
2145 : 85 1b __ STA ACCU + 0 
2147 : a5 1c __ LDA ACCU + 1 
2149 : 65 04 __ ADC WORK + 1 
214b : 85 1c __ STA ACCU + 1 
214d : a5 1d __ LDA ACCU + 2 
214f : 65 05 __ ADC WORK + 2 
2151 : 85 1d __ STA ACCU + 2 
2153 : 90 08 __ BCC $215d ; (faddsub + 129)
2155 : 66 1d __ ROR ACCU + 2 
2157 : 66 1c __ ROR ACCU + 1 
2159 : 66 1b __ ROR ACCU + 0 
215b : e6 07 __ INC WORK + 4 
215d : a5 07 __ LDA WORK + 4 
215f : c9 ff __ CMP #$ff
2161 : f0 83 __ BEQ $20e6 ; (faddsub + 10)
2163 : 4a __ __ LSR
2164 : 05 1e __ ORA ACCU + 3 
2166 : 85 1e __ STA ACCU + 3 
2168 : b0 06 __ BCS $2170 ; (faddsub + 148)
216a : a5 1d __ LDA ACCU + 2 
216c : 29 7f __ AND #$7f
216e : 85 1d __ STA ACCU + 2 
2170 : 60 __ __ RTS
2171 : 38 __ __ SEC
2172 : a5 1b __ LDA ACCU + 0 
2174 : e5 03 __ SBC WORK + 0 
2176 : 85 1b __ STA ACCU + 0 
2178 : a5 1c __ LDA ACCU + 1 
217a : e5 04 __ SBC WORK + 1 
217c : 85 1c __ STA ACCU + 1 
217e : a5 1d __ LDA ACCU + 2 
2180 : e5 05 __ SBC WORK + 2 
2182 : 85 1d __ STA ACCU + 2 
2184 : b0 19 __ BCS $219f ; (faddsub + 195)
2186 : 38 __ __ SEC
2187 : a9 00 __ LDA #$00
2189 : e5 1b __ SBC ACCU + 0 
218b : 85 1b __ STA ACCU + 0 
218d : a9 00 __ LDA #$00
218f : e5 1c __ SBC ACCU + 1 
2191 : 85 1c __ STA ACCU + 1 
2193 : a9 00 __ LDA #$00
2195 : e5 1d __ SBC ACCU + 2 
2197 : 85 1d __ STA ACCU + 2 
2199 : a5 1e __ LDA ACCU + 3 
219b : 49 80 __ EOR #$80
219d : 85 1e __ STA ACCU + 3 
219f : a5 1d __ LDA ACCU + 2 
21a1 : 30 ba __ BMI $215d ; (faddsub + 129)
21a3 : 05 1c __ ORA ACCU + 1 
21a5 : 05 1b __ ORA ACCU + 0 
21a7 : f0 0f __ BEQ $21b8 ; (faddsub + 220)
21a9 : c6 07 __ DEC WORK + 4 
21ab : f0 0b __ BEQ $21b8 ; (faddsub + 220)
21ad : 06 1b __ ASL ACCU + 0 
21af : 26 1c __ ROL ACCU + 1 
21b1 : 26 1d __ ROL ACCU + 2 
21b3 : 10 f4 __ BPL $21a9 ; (faddsub + 205)
21b5 : 4c 5d 21 JMP $215d ; (faddsub + 129)
21b8 : a9 00 __ LDA #$00
21ba : 85 1b __ STA ACCU + 0 
21bc : 85 1c __ STA ACCU + 1 
21be : 85 1d __ STA ACCU + 2 
21c0 : 85 1e __ STA ACCU + 3 
21c2 : 60 __ __ RTS
--------------------------------------------------------------------
fmul:
21c3 : a5 1b __ LDA ACCU + 0 
21c5 : 05 1c __ ORA ACCU + 1 
21c7 : 05 1d __ ORA ACCU + 2 
21c9 : d0 03 __ BNE $21ce ; (fmul + 11)
21cb : 85 1e __ STA ACCU + 3 
21cd : 60 __ __ RTS
21ce : a5 03 __ LDA WORK + 0 
21d0 : 05 04 __ ORA WORK + 1 
21d2 : 05 05 __ ORA WORK + 2 
21d4 : d0 09 __ BNE $21df ; (fmul + 28)
21d6 : 85 1b __ STA ACCU + 0 
21d8 : 85 1c __ STA ACCU + 1 
21da : 85 1d __ STA ACCU + 2 
21dc : 85 1e __ STA ACCU + 3 
21de : 60 __ __ RTS
21df : a5 1e __ LDA ACCU + 3 
21e1 : 45 06 __ EOR WORK + 3 
21e3 : 29 80 __ AND #$80
21e5 : 85 1e __ STA ACCU + 3 
21e7 : a9 ff __ LDA #$ff
21e9 : c5 07 __ CMP WORK + 4 
21eb : f0 42 __ BEQ $222f ; (fmul + 108)
21ed : c5 08 __ CMP WORK + 5 
21ef : f0 3e __ BEQ $222f ; (fmul + 108)
21f1 : a9 00 __ LDA #$00
21f3 : 85 09 __ STA WORK + 6 
21f5 : 85 0a __ STA WORK + 7 
21f7 : 85 0b __ STA $0b 
21f9 : a4 1b __ LDY ACCU + 0 
21fb : a5 03 __ LDA WORK + 0 
21fd : d0 06 __ BNE $2205 ; (fmul + 66)
21ff : a5 04 __ LDA WORK + 1 
2201 : f0 0a __ BEQ $220d ; (fmul + 74)
2203 : d0 05 __ BNE $220a ; (fmul + 71)
2205 : 20 64 22 JSR $2264 ; (fmul8 + 0)
2208 : a5 04 __ LDA WORK + 1 
220a : 20 64 22 JSR $2264 ; (fmul8 + 0)
220d : a5 05 __ LDA WORK + 2 
220f : 20 64 22 JSR $2264 ; (fmul8 + 0)
2212 : 38 __ __ SEC
2213 : a5 0b __ LDA $0b 
2215 : 30 06 __ BMI $221d ; (fmul + 90)
2217 : 06 09 __ ASL WORK + 6 
2219 : 26 0a __ ROL WORK + 7 
221b : 2a __ __ ROL
221c : 18 __ __ CLC
221d : 29 7f __ AND #$7f
221f : 85 0b __ STA $0b 
2221 : a5 07 __ LDA WORK + 4 
2223 : 65 08 __ ADC WORK + 5 
2225 : 90 19 __ BCC $2240 ; (fmul + 125)
2227 : e9 7f __ SBC #$7f
2229 : b0 04 __ BCS $222f ; (fmul + 108)
222b : c9 ff __ CMP #$ff
222d : d0 15 __ BNE $2244 ; (fmul + 129)
222f : a5 1e __ LDA ACCU + 3 
2231 : 09 7f __ ORA #$7f
2233 : 85 1e __ STA ACCU + 3 
2235 : a9 80 __ LDA #$80
2237 : 85 1d __ STA ACCU + 2 
2239 : a9 00 __ LDA #$00
223b : 85 1b __ STA ACCU + 0 
223d : 85 1c __ STA ACCU + 1 
223f : 60 __ __ RTS
2240 : e9 7e __ SBC #$7e
2242 : 90 15 __ BCC $2259 ; (fmul + 150)
2244 : 4a __ __ LSR
2245 : 05 1e __ ORA ACCU + 3 
2247 : 85 1e __ STA ACCU + 3 
2249 : a9 00 __ LDA #$00
224b : 6a __ __ ROR
224c : 05 0b __ ORA $0b 
224e : 85 1d __ STA ACCU + 2 
2250 : a5 0a __ LDA WORK + 7 
2252 : 85 1c __ STA ACCU + 1 
2254 : a5 09 __ LDA WORK + 6 
2256 : 85 1b __ STA ACCU + 0 
2258 : 60 __ __ RTS
2259 : a9 00 __ LDA #$00
225b : 85 1b __ STA ACCU + 0 
225d : 85 1c __ STA ACCU + 1 
225f : 85 1d __ STA ACCU + 2 
2261 : 85 1e __ STA ACCU + 3 
2263 : 60 __ __ RTS
--------------------------------------------------------------------
fmul8:
2264 : 38 __ __ SEC
2265 : 6a __ __ ROR
2266 : 90 1e __ BCC $2286 ; (fmul8 + 34)
2268 : aa __ __ TAX
2269 : 18 __ __ CLC
226a : 98 __ __ TYA
226b : 65 09 __ ADC WORK + 6 
226d : 85 09 __ STA WORK + 6 
226f : a5 0a __ LDA WORK + 7 
2271 : 65 1c __ ADC ACCU + 1 
2273 : 85 0a __ STA WORK + 7 
2275 : a5 0b __ LDA $0b 
2277 : 65 1d __ ADC ACCU + 2 
2279 : 6a __ __ ROR
227a : 85 0b __ STA $0b 
227c : 8a __ __ TXA
227d : 66 0a __ ROR WORK + 7 
227f : 66 09 __ ROR WORK + 6 
2281 : 4a __ __ LSR
2282 : f0 0d __ BEQ $2291 ; (fmul8 + 45)
2284 : b0 e2 __ BCS $2268 ; (fmul8 + 4)
2286 : 66 0b __ ROR $0b 
2288 : 66 0a __ ROR WORK + 7 
228a : 66 09 __ ROR WORK + 6 
228c : 4a __ __ LSR
228d : 90 f7 __ BCC $2286 ; (fmul8 + 34)
228f : d0 d7 __ BNE $2268 ; (fmul8 + 4)
2291 : 60 __ __ RTS
--------------------------------------------------------------------
fdiv:
2292 : a5 1b __ LDA ACCU + 0 
2294 : 05 1c __ ORA ACCU + 1 
2296 : 05 1d __ ORA ACCU + 2 
2298 : d0 03 __ BNE $229d ; (fdiv + 11)
229a : 85 1e __ STA ACCU + 3 
229c : 60 __ __ RTS
229d : a5 1e __ LDA ACCU + 3 
229f : 45 06 __ EOR WORK + 3 
22a1 : 29 80 __ AND #$80
22a3 : 85 1e __ STA ACCU + 3 
22a5 : a5 08 __ LDA WORK + 5 
22a7 : f0 62 __ BEQ $230b ; (fdiv + 121)
22a9 : a5 07 __ LDA WORK + 4 
22ab : c9 ff __ CMP #$ff
22ad : f0 5c __ BEQ $230b ; (fdiv + 121)
22af : a9 00 __ LDA #$00
22b1 : 85 09 __ STA WORK + 6 
22b3 : 85 0a __ STA WORK + 7 
22b5 : 85 0b __ STA $0b 
22b7 : a2 18 __ LDX #$18
22b9 : a5 1b __ LDA ACCU + 0 
22bb : c5 03 __ CMP WORK + 0 
22bd : a5 1c __ LDA ACCU + 1 
22bf : e5 04 __ SBC WORK + 1 
22c1 : a5 1d __ LDA ACCU + 2 
22c3 : e5 05 __ SBC WORK + 2 
22c5 : 90 13 __ BCC $22da ; (fdiv + 72)
22c7 : a5 1b __ LDA ACCU + 0 
22c9 : e5 03 __ SBC WORK + 0 
22cb : 85 1b __ STA ACCU + 0 
22cd : a5 1c __ LDA ACCU + 1 
22cf : e5 04 __ SBC WORK + 1 
22d1 : 85 1c __ STA ACCU + 1 
22d3 : a5 1d __ LDA ACCU + 2 
22d5 : e5 05 __ SBC WORK + 2 
22d7 : 85 1d __ STA ACCU + 2 
22d9 : 38 __ __ SEC
22da : 26 09 __ ROL WORK + 6 
22dc : 26 0a __ ROL WORK + 7 
22de : 26 0b __ ROL $0b 
22e0 : ca __ __ DEX
22e1 : f0 0a __ BEQ $22ed ; (fdiv + 91)
22e3 : 06 1b __ ASL ACCU + 0 
22e5 : 26 1c __ ROL ACCU + 1 
22e7 : 26 1d __ ROL ACCU + 2 
22e9 : b0 dc __ BCS $22c7 ; (fdiv + 53)
22eb : 90 cc __ BCC $22b9 ; (fdiv + 39)
22ed : 38 __ __ SEC
22ee : a5 0b __ LDA $0b 
22f0 : 30 06 __ BMI $22f8 ; (fdiv + 102)
22f2 : 06 09 __ ASL WORK + 6 
22f4 : 26 0a __ ROL WORK + 7 
22f6 : 2a __ __ ROL
22f7 : 18 __ __ CLC
22f8 : 29 7f __ AND #$7f
22fa : 85 0b __ STA $0b 
22fc : a5 07 __ LDA WORK + 4 
22fe : e5 08 __ SBC WORK + 5 
2300 : 90 1a __ BCC $231c ; (fdiv + 138)
2302 : 18 __ __ CLC
2303 : 69 7f __ ADC #$7f
2305 : b0 04 __ BCS $230b ; (fdiv + 121)
2307 : c9 ff __ CMP #$ff
2309 : d0 15 __ BNE $2320 ; (fdiv + 142)
230b : a5 1e __ LDA ACCU + 3 
230d : 09 7f __ ORA #$7f
230f : 85 1e __ STA ACCU + 3 
2311 : a9 80 __ LDA #$80
2313 : 85 1d __ STA ACCU + 2 
2315 : a9 00 __ LDA #$00
2317 : 85 1c __ STA ACCU + 1 
2319 : 85 1b __ STA ACCU + 0 
231b : 60 __ __ RTS
231c : 69 7f __ ADC #$7f
231e : 90 15 __ BCC $2335 ; (fdiv + 163)
2320 : 4a __ __ LSR
2321 : 05 1e __ ORA ACCU + 3 
2323 : 85 1e __ STA ACCU + 3 
2325 : a9 00 __ LDA #$00
2327 : 6a __ __ ROR
2328 : 05 0b __ ORA $0b 
232a : 85 1d __ STA ACCU + 2 
232c : a5 0a __ LDA WORK + 7 
232e : 85 1c __ STA ACCU + 1 
2330 : a5 09 __ LDA WORK + 6 
2332 : 85 1b __ STA ACCU + 0 
2334 : 60 __ __ RTS
2335 : a9 00 __ LDA #$00
2337 : 85 1e __ STA ACCU + 3 
2339 : 85 1d __ STA ACCU + 2 
233b : 85 1c __ STA ACCU + 1 
233d : 85 1b __ STA ACCU + 0 
233f : 60 __ __ RTS
--------------------------------------------------------------------
divs16:
2340 : 24 1c __ BIT ACCU + 1 
2342 : 10 0d __ BPL $2351 ; (divs16 + 17)
2344 : 20 5e 23 JSR $235e ; (negaccu + 0)
2347 : 24 04 __ BIT WORK + 1 
2349 : 10 0d __ BPL $2358 ; (divs16 + 24)
234b : 20 6c 23 JSR $236c ; (negtmp + 0)
234e : 4c 7a 23 JMP $237a ; (divmod + 0)
2351 : 24 04 __ BIT WORK + 1 
2353 : 10 f9 __ BPL $234e ; (divs16 + 14)
2355 : 20 6c 23 JSR $236c ; (negtmp + 0)
2358 : 20 7a 23 JSR $237a ; (divmod + 0)
235b : 4c 5e 23 JMP $235e ; (negaccu + 0)
--------------------------------------------------------------------
negaccu:
235e : 38 __ __ SEC
235f : a9 00 __ LDA #$00
2361 : e5 1b __ SBC ACCU + 0 
2363 : 85 1b __ STA ACCU + 0 
2365 : a9 00 __ LDA #$00
2367 : e5 1c __ SBC ACCU + 1 
2369 : 85 1c __ STA ACCU + 1 
236b : 60 __ __ RTS
--------------------------------------------------------------------
negtmp:
236c : 38 __ __ SEC
236d : a9 00 __ LDA #$00
236f : e5 03 __ SBC WORK + 0 
2371 : 85 03 __ STA WORK + 0 
2373 : a9 00 __ LDA #$00
2375 : e5 04 __ SBC WORK + 1 
2377 : 85 04 __ STA WORK + 1 
2379 : 60 __ __ RTS
--------------------------------------------------------------------
divmod:
237a : a5 1c __ LDA ACCU + 1 
237c : d0 31 __ BNE $23af ; (divmod + 53)
237e : a5 04 __ LDA WORK + 1 
2380 : d0 1e __ BNE $23a0 ; (divmod + 38)
2382 : 85 06 __ STA WORK + 3 
2384 : a2 04 __ LDX #$04
2386 : 06 1b __ ASL ACCU + 0 
2388 : 2a __ __ ROL
2389 : c5 03 __ CMP WORK + 0 
238b : 90 02 __ BCC $238f ; (divmod + 21)
238d : e5 03 __ SBC WORK + 0 
238f : 26 1b __ ROL ACCU + 0 
2391 : 2a __ __ ROL
2392 : c5 03 __ CMP WORK + 0 
2394 : 90 02 __ BCC $2398 ; (divmod + 30)
2396 : e5 03 __ SBC WORK + 0 
2398 : 26 1b __ ROL ACCU + 0 
239a : ca __ __ DEX
239b : d0 eb __ BNE $2388 ; (divmod + 14)
239d : 85 05 __ STA WORK + 2 
239f : 60 __ __ RTS
23a0 : a5 1b __ LDA ACCU + 0 
23a2 : 85 05 __ STA WORK + 2 
23a4 : a5 1c __ LDA ACCU + 1 
23a6 : 85 06 __ STA WORK + 3 
23a8 : a9 00 __ LDA #$00
23aa : 85 1b __ STA ACCU + 0 
23ac : 85 1c __ STA ACCU + 1 
23ae : 60 __ __ RTS
23af : a5 04 __ LDA WORK + 1 
23b1 : d0 1f __ BNE $23d2 ; (divmod + 88)
23b3 : a5 03 __ LDA WORK + 0 
23b5 : 30 1b __ BMI $23d2 ; (divmod + 88)
23b7 : a9 00 __ LDA #$00
23b9 : 85 06 __ STA WORK + 3 
23bb : a2 10 __ LDX #$10
23bd : 06 1b __ ASL ACCU + 0 
23bf : 26 1c __ ROL ACCU + 1 
23c1 : 2a __ __ ROL
23c2 : c5 03 __ CMP WORK + 0 
23c4 : 90 02 __ BCC $23c8 ; (divmod + 78)
23c6 : e5 03 __ SBC WORK + 0 
23c8 : 26 1b __ ROL ACCU + 0 
23ca : 26 1c __ ROL ACCU + 1 
23cc : ca __ __ DEX
23cd : d0 f2 __ BNE $23c1 ; (divmod + 71)
23cf : 85 05 __ STA WORK + 2 
23d1 : 60 __ __ RTS
23d2 : a9 00 __ LDA #$00
23d4 : 85 05 __ STA WORK + 2 
23d6 : 85 06 __ STA WORK + 3 
23d8 : 84 02 __ STY $02 
23da : a0 10 __ LDY #$10
23dc : 18 __ __ CLC
23dd : 26 1b __ ROL ACCU + 0 
23df : 26 1c __ ROL ACCU + 1 
23e1 : 26 05 __ ROL WORK + 2 
23e3 : 26 06 __ ROL WORK + 3 
23e5 : 38 __ __ SEC
23e6 : a5 05 __ LDA WORK + 2 
23e8 : e5 03 __ SBC WORK + 0 
23ea : aa __ __ TAX
23eb : a5 06 __ LDA WORK + 3 
23ed : e5 04 __ SBC WORK + 1 
23ef : 90 04 __ BCC $23f5 ; (divmod + 123)
23f1 : 86 05 __ STX WORK + 2 
23f3 : 85 06 __ STA WORK + 3 
23f5 : 88 __ __ DEY
23f6 : d0 e5 __ BNE $23dd ; (divmod + 99)
23f8 : 26 1b __ ROL ACCU + 0 
23fa : 26 1c __ ROL ACCU + 1 
23fc : a4 02 __ LDY $02 
23fe : 60 __ __ RTS
--------------------------------------------------------------------
mods16:
23ff : 24 1c __ BIT ACCU + 1 
2401 : 10 0d __ BPL $2410 ; (mods16 + 17)
2403 : 20 5e 23 JSR $235e ; (negaccu + 0)
2406 : 24 04 __ BIT WORK + 1 
2408 : 10 0d __ BPL $2417 ; (mods16 + 24)
240a : 20 6c 23 JSR $236c ; (negtmp + 0)
240d : 4c 7a 23 JMP $237a ; (divmod + 0)
2410 : 24 04 __ BIT WORK + 1 
2412 : 10 f9 __ BPL $240d ; (mods16 + 14)
2414 : 20 6c 23 JSR $236c ; (negtmp + 0)
2417 : 20 7a 23 JSR $237a ; (divmod + 0)
241a : 38 __ __ SEC
241b : a9 00 __ LDA #$00
241d : e5 05 __ SBC WORK + 2 
241f : 85 05 __ STA WORK + 2 
2421 : a9 00 __ LDA #$00
2423 : e5 06 __ SBC WORK + 3 
2425 : 85 06 __ STA WORK + 3 
2427 : 60 __ __ RTS
--------------------------------------------------------------------
f32_to_i16:
2428 : 20 bb 20 JSR $20bb ; (freg + 36)
242b : a5 07 __ LDA WORK + 4 
242d : c9 7f __ CMP #$7f
242f : b0 07 __ BCS $2438 ; (f32_to_i16 + 16)
2431 : a9 00 __ LDA #$00
2433 : 85 1b __ STA ACCU + 0 
2435 : 85 1c __ STA ACCU + 1 
2437 : 60 __ __ RTS
2438 : 38 __ __ SEC
2439 : e9 8e __ SBC #$8e
243b : 90 0a __ BCC $2447 ; (f32_to_i16 + 31)
243d : a9 ff __ LDA #$ff
243f : 85 1b __ STA ACCU + 0 
2441 : a9 7f __ LDA #$7f
2443 : 85 1c __ STA ACCU + 1 
2445 : d0 08 __ BNE $244f ; (f32_to_i16 + 39)
2447 : aa __ __ TAX
2448 : 46 1d __ LSR ACCU + 2 
244a : 66 1c __ ROR ACCU + 1 
244c : e8 __ __ INX
244d : d0 f9 __ BNE $2448 ; (f32_to_i16 + 32)
244f : 24 1e __ BIT ACCU + 3 
2451 : 10 0e __ BPL $2461 ; (f32_to_i16 + 57)
2453 : 38 __ __ SEC
2454 : a9 00 __ LDA #$00
2456 : e5 1c __ SBC ACCU + 1 
2458 : 85 1b __ STA ACCU + 0 
245a : a9 00 __ LDA #$00
245c : e5 1d __ SBC ACCU + 2 
245e : 85 1c __ STA ACCU + 1 
2460 : 60 __ __ RTS
2461 : a5 1c __ LDA ACCU + 1 
2463 : 85 1b __ STA ACCU + 0 
2465 : a5 1d __ LDA ACCU + 2 
2467 : 85 1c __ STA ACCU + 1 
2469 : 60 __ __ RTS
--------------------------------------------------------------------
sint16_to_float:
246a : 24 1c __ BIT ACCU + 1 
246c : 30 03 __ BMI $2471 ; (sint16_to_float + 7)
246e : 4c 88 24 JMP $2488 ; (uint16_to_float + 0)
2471 : 38 __ __ SEC
2472 : a9 00 __ LDA #$00
2474 : e5 1b __ SBC ACCU + 0 
2476 : 85 1b __ STA ACCU + 0 
2478 : a9 00 __ LDA #$00
247a : e5 1c __ SBC ACCU + 1 
247c : 85 1c __ STA ACCU + 1 
247e : 20 88 24 JSR $2488 ; (uint16_to_float + 0)
2481 : a5 1e __ LDA ACCU + 3 
2483 : 09 80 __ ORA #$80
2485 : 85 1e __ STA ACCU + 3 
2487 : 60 __ __ RTS
--------------------------------------------------------------------
uint16_to_float:
2488 : a5 1b __ LDA ACCU + 0 
248a : 05 1c __ ORA ACCU + 1 
248c : d0 05 __ BNE $2493 ; (uint16_to_float + 11)
248e : 85 1d __ STA ACCU + 2 
2490 : 85 1e __ STA ACCU + 3 
2492 : 60 __ __ RTS
2493 : a2 8e __ LDX #$8e
2495 : a5 1c __ LDA ACCU + 1 
2497 : 30 06 __ BMI $249f ; (uint16_to_float + 23)
2499 : ca __ __ DEX
249a : 06 1b __ ASL ACCU + 0 
249c : 2a __ __ ROL
249d : 10 fa __ BPL $2499 ; (uint16_to_float + 17)
249f : 29 7f __ AND #$7f
24a1 : 85 1d __ STA ACCU + 2 
24a3 : a5 1b __ LDA ACCU + 0 
24a5 : 85 1c __ STA ACCU + 1 
24a7 : 8a __ __ TXA
24a8 : 4a __ __ LSR
24a9 : 85 1e __ STA ACCU + 3 
24ab : a9 00 __ LDA #$00
24ad : 85 1b __ STA ACCU + 0 
24af : 6a __ __ ROR
24b0 : 05 1d __ ORA ACCU + 2 
24b2 : 85 1d __ STA ACCU + 2 
24b4 : 60 __ __ RTS
--------------------------------------------------------------------
divmod32:
24b5 : 84 02 __ STY $02 
24b7 : a0 20 __ LDY #$20
24b9 : a9 00 __ LDA #$00
24bb : 85 07 __ STA WORK + 4 
24bd : 85 08 __ STA WORK + 5 
24bf : 85 09 __ STA WORK + 6 
24c1 : 85 0a __ STA WORK + 7 
24c3 : a5 05 __ LDA WORK + 2 
24c5 : 05 06 __ ORA WORK + 3 
24c7 : d0 39 __ BNE $2502 ; (divmod32 + 77)
24c9 : 18 __ __ CLC
24ca : 26 1b __ ROL ACCU + 0 
24cc : 26 1c __ ROL ACCU + 1 
24ce : 26 1d __ ROL ACCU + 2 
24d0 : 26 1e __ ROL ACCU + 3 
24d2 : 26 07 __ ROL WORK + 4 
24d4 : 26 08 __ ROL WORK + 5 
24d6 : 90 0c __ BCC $24e4 ; (divmod32 + 47)
24d8 : a5 07 __ LDA WORK + 4 
24da : e5 03 __ SBC WORK + 0 
24dc : aa __ __ TAX
24dd : a5 08 __ LDA WORK + 5 
24df : e5 04 __ SBC WORK + 1 
24e1 : 38 __ __ SEC
24e2 : b0 0c __ BCS $24f0 ; (divmod32 + 59)
24e4 : 38 __ __ SEC
24e5 : a5 07 __ LDA WORK + 4 
24e7 : e5 03 __ SBC WORK + 0 
24e9 : aa __ __ TAX
24ea : a5 08 __ LDA WORK + 5 
24ec : e5 04 __ SBC WORK + 1 
24ee : 90 04 __ BCC $24f4 ; (divmod32 + 63)
24f0 : 86 07 __ STX WORK + 4 
24f2 : 85 08 __ STA WORK + 5 
24f4 : 88 __ __ DEY
24f5 : d0 d3 __ BNE $24ca ; (divmod32 + 21)
24f7 : 26 1b __ ROL ACCU + 0 
24f9 : 26 1c __ ROL ACCU + 1 
24fb : 26 1d __ ROL ACCU + 2 
24fd : 26 1e __ ROL ACCU + 3 
24ff : a4 02 __ LDY $02 
2501 : 60 __ __ RTS
2502 : 18 __ __ CLC
2503 : 26 1b __ ROL ACCU + 0 
2505 : 26 1c __ ROL ACCU + 1 
2507 : 26 1d __ ROL ACCU + 2 
2509 : 26 1e __ ROL ACCU + 3 
250b : 26 07 __ ROL WORK + 4 
250d : 26 08 __ ROL WORK + 5 
250f : 26 09 __ ROL WORK + 6 
2511 : 26 0a __ ROL WORK + 7 
2513 : a5 07 __ LDA WORK + 4 
2515 : c5 03 __ CMP WORK + 0 
2517 : a5 08 __ LDA WORK + 5 
2519 : e5 04 __ SBC WORK + 1 
251b : a5 09 __ LDA WORK + 6 
251d : e5 05 __ SBC WORK + 2 
251f : a5 0a __ LDA WORK + 7 
2521 : e5 06 __ SBC WORK + 3 
2523 : 90 18 __ BCC $253d ; (divmod32 + 136)
2525 : a5 07 __ LDA WORK + 4 
2527 : e5 03 __ SBC WORK + 0 
2529 : 85 07 __ STA WORK + 4 
252b : a5 08 __ LDA WORK + 5 
252d : e5 04 __ SBC WORK + 1 
252f : 85 08 __ STA WORK + 5 
2531 : a5 09 __ LDA WORK + 6 
2533 : e5 05 __ SBC WORK + 2 
2535 : 85 09 __ STA WORK + 6 
2537 : a5 0a __ LDA WORK + 7 
2539 : e5 06 __ SBC WORK + 3 
253b : 85 0a __ STA WORK + 7 
253d : 88 __ __ DEY
253e : d0 c3 __ BNE $2503 ; (divmod32 + 78)
2540 : 26 1b __ ROL ACCU + 0 
2542 : 26 1c __ ROL ACCU + 1 
2544 : 26 1d __ ROL ACCU + 2 
2546 : 26 1e __ ROL ACCU + 3 
2548 : a4 02 __ LDY $02 
254a : 60 __ __ RTS
--------------------------------------------------------------------
__multab5L:
254b : __ __ __ BYT 00 05 0a 0f 14 19 1e 23 28 2d                   : .......#(-
--------------------------------------------------------------------
__multab3L:
2555 : __ __ __ BYT 00 03 06                                        : ...
