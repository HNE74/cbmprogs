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
080e : 8e f8 22 STX $22f8 ; (spentry + 0)
0811 : a9 4c __ LDA #$4c
0813 : 85 19 __ STA IP + 0 
0815 : a9 23 __ LDA #$23
0817 : 85 1a __ STA IP + 1 
0819 : 38 __ __ SEC
081a : a9 23 __ LDA #$23
081c : e9 23 __ SBC #$23
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
0830 : a9 8f __ LDA #$8f
0832 : e9 4c __ SBC #$4c
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
084b : a9 9c __ LDA #$9c
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
22f8 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
main:
.s1000:
0880 : a5 53 __ LDA T0 + 0 
0882 : 8d 9e 9f STA $9f9e ; (main@stack + 0)
.s0:
0885 : 20 fa 08 JSR $08fa ; (redefine_charset.s0 + 0)
0888 : 20 0a 0a JSR $0a0a ; (init_player.s0 + 0)
088b : 20 15 0a JSR $0a15 ; (init_enemies.s0 + 0)
088e : 20 2d 0a JSR $0a2d ; (init_shots.s0 + 0)
0891 : 20 54 0a JSR $0a54 ; (init_game_state.s0 + 0)
0894 : 20 66 0a JSR $0a66 ; (prepare_game_screen.s0 + 0)
0897 : ad 86 23 LDA $2386 ; (game + 0)
089a : d0 52 __ BNE $08ee ; (main.s4 + 0)
.s9:
089c : 85 53 __ STA T0 + 0 
.l3:
089e : 20 c5 0a JSR $0ac5 ; (render_game_state.s1000 + 0)
08a1 : a5 53 __ LDA T0 + 0 
08a3 : 85 1b __ STA ACCU + 0 
08a5 : a9 00 __ LDA #$00
08a7 : 85 1c __ STA ACCU + 1 
08a9 : 85 04 __ STA WORK + 1 
08ab : a9 03 __ LDA #$03
08ad : 85 03 __ STA WORK + 0 
08af : 20 24 21 JSR $2124 ; (divmod + 0)
08b2 : a5 05 __ LDA WORK + 2 
08b4 : 05 06 __ ORA WORK + 3 
08b6 : d0 09 __ BNE $08c1 ; (main.s7 + 0)
.s5:
08b8 : 20 c3 17 JSR $17c3 ; (spawn_enemy.s0 + 0)
08bb : 20 42 18 JSR $1842 ; (move_enemies.s1000 + 0)
08be : 20 3f 1a JSR $1a3f ; (render_enemies.s0 + 0)
.s7:
08c1 : 20 97 1a JSR $1a97 ; (move_enemy_shots.s0 + 0)
08c4 : 20 ea 19 JSR $19ea ; (render_enemy_shots.s0 + 0)
08c7 : 20 01 1b JSR $1b01 ; (check_player_enemy_collision.s0 + 0)
08ca : 20 53 1b JSR $1b53 ; (control_player_ship.s0 + 0)
08cd : 20 71 1c JSR $1c71 ; (render_player_ship.s0 + 0)
08d0 : 20 01 1b JSR $1b01 ; (check_player_enemy_collision.s0 + 0)
08d3 : 20 b1 1c JSR $1cb1 ; (move_player_shots.s0 + 0)
08d6 : 20 19 1d JSR $1d19 ; (render_player_shots.s0 + 0)
08d9 : 20 6e 1d JSR $1d6e ; (check_shot_enemy_collision.s0 + 0)
08dc : a9 03 __ LDA #$03
08de : 85 0d __ STA P0 
08e0 : a9 00 __ LDA #$00
08e2 : 85 0e __ STA P1 
08e4 : 20 20 1e JSR $1e20 ; (wait_frames.s0 + 0)
08e7 : e6 53 __ INC T0 + 0 
08e9 : ad 86 23 LDA $2386 ; (game + 0)
08ec : f0 b0 __ BEQ $089e ; (main.l3 + 0)
.s4:
08ee : a9 00 __ LDA #$00
08f0 : 85 1b __ STA ACCU + 0 
08f2 : 85 1c __ STA ACCU + 1 
.s1001:
08f4 : ad 9e 9f LDA $9f9e ; (main@stack + 0)
08f7 : 85 53 __ STA T0 + 0 
08f9 : 60 __ __ RTS
--------------------------------------------------------------------
redefine_charset:
.s0:
08fa : 20 3a 09 JSR $093a ; (mmap_trampoline.s0 + 0)
08fd : a9 31 __ LDA #$31
08ff : 85 01 __ STA $01 
0901 : a9 00 __ LDA #$00
0903 : 85 11 __ STA P4 
0905 : 85 0d __ STA P0 
0907 : 85 0f __ STA P2 
0909 : a9 08 __ LDA #$08
090b : 85 12 __ STA P5 
090d : a9 c8 __ LDA #$c8
090f : 85 0e __ STA P1 
0911 : a9 d0 __ LDA #$d0
0913 : 85 10 __ STA P3 
0915 : 20 84 09 JSR $0984 ; (memcpy.s0 + 0)
0918 : a2 30 __ LDX #$30
.l1002:
091a : bd ff 22 LDA $22ff,x ; (joyy + 1)
091d : 9d ff cb STA $cbff,x 
0920 : ca __ __ DEX
0921 : d0 f7 __ BNE $091a ; (redefine_charset.l1002 + 0)
.s1003:
0923 : a9 37 __ LDA #$37
0925 : 85 01 __ STA $01 
0927 : a9 00 __ LDA #$00
0929 : 85 0d __ STA P0 
092b : 85 0e __ STA P1 
092d : 85 10 __ STA P3 
092f : a9 c8 __ LDA #$c8
0931 : 85 11 __ STA P4 
0933 : a9 c0 __ LDA #$c0
0935 : 85 0f __ STA P2 
0937 : 4c b3 09 JMP $09b3 ; (vic_setmode.s0 + 0)
--------------------------------------------------------------------
mmap_trampoline:
.s0:
093a : a9 4f __ LDA #$4f
093c : 8d fa ff STA $fffa 
093f : a9 09 __ LDA #$09
0941 : 8d fb ff STA $fffb 
0944 : a9 6d __ LDA #$6d
0946 : 8d fe ff STA $fffe 
0949 : a9 09 __ LDA #$09
094b : 8d ff ff STA $ffff 
.s1001:
094e : 60 __ __ RTS
--------------------------------------------------------------------
NMITrampoline:
094f : 48 __ __ PHA
0950 : 8a __ __ TXA
0951 : 48 __ __ PHA
0952 : a9 09 __ LDA #$09
0954 : 48 __ __ PHA
0955 : a9 66 __ LDA #$66
0957 : 48 __ __ PHA
0958 : ba __ __ TSX
0959 : bd 05 01 LDA $0105,x 
095c : 48 __ __ PHA
095d : a6 01 __ LDX $01 
095f : a9 36 __ LDA #$36
0961 : 85 01 __ STA $01 
0963 : 6c fa ff JMP ($fffa)
--------------------------------------------------------------------
DoneTrampoline:
0966 : 86 01 __ STX $01 
0968 : 68 __ __ PLA
0969 : aa __ __ TAX
096a : 68 __ __ PLA
096b : 40 __ __ RTI
096c : 60 __ __ RTS
--------------------------------------------------------------------
IRQTrampoline:
096d : 48 __ __ PHA
096e : 8a __ __ TXA
096f : 48 __ __ PHA
0970 : a9 09 __ LDA #$09
0972 : 48 __ __ PHA
0973 : a9 66 __ LDA #$66
0975 : 48 __ __ PHA
0976 : ba __ __ TSX
0977 : bd 05 01 LDA $0105,x 
097a : 48 __ __ PHA
097b : a6 01 __ LDX $01 
097d : a9 36 __ LDA #$36
097f : 85 01 __ STA $01 
0981 : 6c fe ff JMP ($fffe)
--------------------------------------------------------------------
memcpy:
.s0:
0984 : a6 12 __ LDX P5 
0986 : f0 10 __ BEQ $0998 ; (memcpy.s0 + 20)
0988 : a0 00 __ LDY #$00
098a : b1 0f __ LDA (P2),y 
098c : 91 0d __ STA (P0),y ; (dst + 0)
098e : c8 __ __ INY
098f : d0 f9 __ BNE $098a ; (memcpy.s0 + 6)
0991 : e6 10 __ INC P3 
0993 : e6 0e __ INC P1 ; (dst + 1)
0995 : ca __ __ DEX
0996 : d0 f2 __ BNE $098a ; (memcpy.s0 + 6)
0998 : a4 11 __ LDY P4 
099a : f0 0e __ BEQ $09aa ; (memcpy.s0 + 38)
099c : 88 __ __ DEY
099d : f0 07 __ BEQ $09a6 ; (memcpy.s0 + 34)
099f : b1 0f __ LDA (P2),y 
09a1 : 91 0d __ STA (P0),y ; (dst + 0)
09a3 : 88 __ __ DEY
09a4 : d0 f9 __ BNE $099f ; (memcpy.s0 + 27)
09a6 : b1 0f __ LDA (P2),y 
09a8 : 91 0d __ STA (P0),y ; (dst + 0)
09aa : a5 0d __ LDA P0 ; (dst + 0)
09ac : 85 1b __ STA ACCU + 0 
09ae : a5 0e __ LDA P1 ; (dst + 1)
09b0 : 85 1c __ STA ACCU + 1 
.s1001:
09b2 : 60 __ __ RTS
--------------------------------------------------------------------
ChrRedef:
2300 : __ __ __ BYT 80 e0 f8 7f 7f f8 e0 80 00 00 60 3e 3e 60 00 00 : ..........`>>`..
2310 : __ __ __ BYT 00 00 3c 66 66 3c 00 00 1c 7f c6 1f 1f c6 7f 1c : ..<ff<..........
2320 : __ __ __ BYT 00 3c 7e d5 ab 7e 3c 00 28 3c 6e df 5f fe 3c 14 : .<~..~<.(<n._.<.
--------------------------------------------------------------------
vic_setmode:
.s0:
09b3 : a6 0f __ LDX P2 ; (text + 1)
09b5 : a4 0d __ LDY P0 ; (mode + 0)
09b7 : c0 02 __ CPY #$02
09b9 : d0 07 __ BNE $09c2 ; (vic_setmode.s15 + 0)
.s6:
09bb : a9 5b __ LDA #$5b
09bd : 8d 11 d0 STA $d011 
09c0 : d0 0d __ BNE $09cf ; (vic_setmode.s23 + 0)
.s15:
09c2 : c0 02 __ CPY #$02
09c4 : 90 39 __ BCC $09ff ; (vic_setmode.s17 + 0)
.s16:
09c6 : a9 3b __ LDA #$3b
09c8 : 8d 11 d0 STA $d011 
09cb : c0 03 __ CPY #$03
09cd : d0 04 __ BNE $09d3 ; (vic_setmode.s1009 + 0)
.s23:
09cf : a9 08 __ LDA #$08
09d1 : d0 02 __ BNE $09d5 ; (vic_setmode.s1 + 0)
.s1009:
09d3 : a9 18 __ LDA #$18
.s1:
09d5 : 8d 16 d0 STA $d016 
09d8 : ad 00 dd LDA $dd00 
09db : 29 fc __ AND #$fc
09dd : 85 1b __ STA ACCU + 0 
09df : 8a __ __ TXA
09e0 : 0a __ __ ASL
09e1 : 2a __ __ ROL
09e2 : 29 01 __ AND #$01
09e4 : 2a __ __ ROL
09e5 : 49 03 __ EOR #$03
09e7 : 05 1b __ ORA ACCU + 0 
09e9 : 8d 00 dd STA $dd00 
09ec : 8a __ __ TXA
09ed : 0a __ __ ASL
09ee : 0a __ __ ASL
09ef : 29 f0 __ AND #$f0
09f1 : 85 1b __ STA ACCU + 0 
09f3 : a5 11 __ LDA P4 ; (font + 1)
09f5 : 4a __ __ LSR
09f6 : 4a __ __ LSR
09f7 : 29 0e __ AND #$0e
09f9 : 05 1b __ ORA ACCU + 0 
09fb : 8d 18 d0 STA $d018 
.s1001:
09fe : 60 __ __ RTS
.s17:
09ff : a9 1b __ LDA #$1b
0a01 : 8d 11 d0 STA $d011 
0a04 : 98 __ __ TYA
0a05 : d0 cc __ BNE $09d3 ; (vic_setmode.s1009 + 0)
0a07 : 4c cf 09 JMP $09cf ; (vic_setmode.s23 + 0)
--------------------------------------------------------------------
init_player:
.s0:
0a0a : a9 05 __ LDA #$05
0a0c : 8d fc 22 STA $22fc ; (Player + 0)
0a0f : a9 0c __ LDA #$0c
0a11 : 8d fd 22 STA $22fd ; (Player + 1)
.s1001:
0a14 : 60 __ __ RTS
--------------------------------------------------------------------
Player:
22fc : __ __ __ BSS	2
--------------------------------------------------------------------
init_enemies:
.s0:
0a15 : a2 00 __ LDX #$00
0a17 : a0 0a __ LDY #$0a
.l1002:
0a19 : a9 00 __ LDA #$00
0a1b : 9d 4c 23 STA $234c,x ; (Enemy + 0)
0a1e : 9d 4d 23 STA $234d,x ; (Enemy + 1)
0a21 : 9d 4f 23 STA $234f,x ; (Enemy + 3)
0a24 : 8a __ __ TXA
0a25 : 18 __ __ CLC
0a26 : 69 04 __ ADC #$04
0a28 : aa __ __ TAX
0a29 : 88 __ __ DEY
0a2a : d0 ed __ BNE $0a19 ; (init_enemies.l1002 + 0)
.s1001:
0a2c : 60 __ __ RTS
--------------------------------------------------------------------
Enemy:
234c : __ __ __ BSS	40
--------------------------------------------------------------------
init_shots:
.s0:
0a2d : a2 00 __ LDX #$00
0a2f : a0 03 __ LDY #$03
0a31 : 8a __ __ TXA
.l1006:
0a32 : 9d 74 23 STA $2374,x ; (PlayerShot + 0)
0a35 : 9d 75 23 STA $2375,x ; (PlayerShot + 1)
0a38 : 9d 76 23 STA $2376,x ; (PlayerShot + 2)
0a3b : e8 __ __ INX
0a3c : e8 __ __ INX
0a3d : e8 __ __ INX
0a3e : 88 __ __ DEY
0a3f : d0 f1 __ BNE $0a32 ; (init_shots.l1006 + 0)
.s6:
0a41 : a0 03 __ LDY #$03
0a43 : aa __ __ TAX
.l1008:
0a44 : 9d 7d 23 STA $237d,x ; (EnemyShot + 0)
0a47 : 9d 7e 23 STA $237e,x ; (EnemyShot + 1)
0a4a : 9d 7f 23 STA $237f,x ; (EnemyShot + 2)
0a4d : e8 __ __ INX
0a4e : e8 __ __ INX
0a4f : e8 __ __ INX
0a50 : 88 __ __ DEY
0a51 : d0 f1 __ BNE $0a44 ; (init_shots.l1008 + 0)
.s1001:
0a53 : 60 __ __ RTS
--------------------------------------------------------------------
PlayerShot:
2374 : __ __ __ BSS	9
--------------------------------------------------------------------
EnemyShot:
237d : __ __ __ BSS	9
--------------------------------------------------------------------
init_game_state:
.s0:
0a54 : a9 00 __ LDA #$00
0a56 : 8d 86 23 STA $2386 ; (game + 0)
0a59 : 8d 87 23 STA $2387 ; (game + 1)
0a5c : 8d 88 23 STA $2388 ; (game + 2)
0a5f : 8d 89 23 STA $2389 ; (game + 3)
0a62 : 8d 8a 23 STA $238a ; (game + 4)
.s1001:
0a65 : 60 __ __ RTS
--------------------------------------------------------------------
game:
2386 : __ __ __ BSS	5
--------------------------------------------------------------------
prepare_game_screen:
.s0:
0a66 : a9 20 __ LDA #$20
0a68 : 85 0f __ STA P2 
0a6a : a9 00 __ LDA #$00
0a6c : 85 10 __ STA P3 
0a6e : 85 0d __ STA P0 
0a70 : a9 e8 __ LDA #$e8
0a72 : 85 11 __ STA P4 
0a74 : a9 03 __ LDA #$03
0a76 : 85 12 __ STA P5 
0a78 : a9 c0 __ LDA #$c0
0a7a : 85 0e __ STA P1 
0a7c : 20 a1 0a JSR $0aa1 ; (memset.s0 + 0)
0a7f : a9 00 __ LDA #$00
0a81 : 85 0f __ STA P2 
0a83 : 85 10 __ STA P3 
0a85 : 85 0d __ STA P0 
0a87 : a9 e8 __ LDA #$e8
0a89 : 85 11 __ STA P4 
0a8b : a9 03 __ LDA #$03
0a8d : 85 12 __ STA P5 
0a8f : a9 d8 __ LDA #$d8
0a91 : 85 0e __ STA P1 
0a93 : 20 a1 0a JSR $0aa1 ; (memset.s0 + 0)
0a96 : a9 0b __ LDA #$0b
0a98 : 8d 20 d0 STA $d020 
0a9b : a9 00 __ LDA #$00
0a9d : 8d 21 d0 STA $d021 
.s1001:
0aa0 : 60 __ __ RTS
--------------------------------------------------------------------
memset:
.s0:
0aa1 : a5 0f __ LDA P2 
0aa3 : a6 12 __ LDX P5 
0aa5 : f0 0c __ BEQ $0ab3 ; (memset.s0 + 18)
0aa7 : a0 00 __ LDY #$00
0aa9 : 91 0d __ STA (P0),y ; (dst + 0)
0aab : c8 __ __ INY
0aac : d0 fb __ BNE $0aa9 ; (memset.s0 + 8)
0aae : e6 0e __ INC P1 ; (dst + 1)
0ab0 : ca __ __ DEX
0ab1 : d0 f6 __ BNE $0aa9 ; (memset.s0 + 8)
0ab3 : a4 11 __ LDY P4 
0ab5 : f0 05 __ BEQ $0abc ; (memset.s0 + 27)
0ab7 : 88 __ __ DEY
0ab8 : 91 0d __ STA (P0),y ; (dst + 0)
0aba : d0 fb __ BNE $0ab7 ; (memset.s0 + 22)
0abc : a5 0d __ LDA P0 ; (dst + 0)
0abe : 85 1b __ STA ACCU + 0 
0ac0 : a5 0e __ LDA P1 ; (dst + 1)
0ac2 : 85 1c __ STA ACCU + 1 
.s1001:
0ac4 : 60 __ __ RTS
--------------------------------------------------------------------
render_game_state:
.s1000:
0ac5 : 38 __ __ SEC
0ac6 : a5 23 __ LDA SP + 0 
0ac8 : e9 08 __ SBC #$08
0aca : 85 23 __ STA SP + 0 
0acc : b0 02 __ BCS $0ad0 ; (render_game_state.s0 + 0)
0ace : c6 24 __ DEC SP + 1 
.s0:
0ad0 : a9 01 __ LDA #$01
0ad2 : 85 0d __ STA P0 
0ad4 : 85 0f __ STA P2 
0ad6 : a9 00 __ LDA #$00
0ad8 : 85 0e __ STA P1 
0ada : 85 10 __ STA P3 
0adc : 20 11 0b JSR $0b11 ; (gotoxy.s0 + 0)
0adf : a9 b8 __ LDA #$b8
0ae1 : a0 02 __ LDY #$02
0ae3 : 91 23 __ STA (SP + 0),y 
0ae5 : a9 17 __ LDA #$17
0ae7 : c8 __ __ INY
0ae8 : 91 23 __ STA (SP + 0),y 
0aea : ad 87 23 LDA $2387 ; (game + 1)
0aed : c8 __ __ INY
0aee : 91 23 __ STA (SP + 0),y 
0af0 : ad 88 23 LDA $2388 ; (game + 2)
0af3 : c8 __ __ INY
0af4 : 91 23 __ STA (SP + 0),y 
0af6 : ad 89 23 LDA $2389 ; (game + 3)
0af9 : c8 __ __ INY
0afa : 91 23 __ STA (SP + 0),y 
0afc : ad 8a 23 LDA $238a ; (game + 4)
0aff : c8 __ __ INY
0b00 : 91 23 __ STA (SP + 0),y 
0b02 : 20 1a 0b JSR $0b1a ; (printf.s0 + 0)
.s1001:
0b05 : 18 __ __ CLC
0b06 : a5 23 __ LDA SP + 0 
0b08 : 69 08 __ ADC #$08
0b0a : 85 23 __ STA SP + 0 
0b0c : 90 02 __ BCC $0b10 ; (render_game_state.s1001 + 11)
0b0e : e6 24 __ INC SP + 1 
0b10 : 60 __ __ RTS
--------------------------------------------------------------------
gotoxy:
.s0:
0b11 : a6 0f __ LDX P2 
0b13 : a4 0d __ LDY P0 
0b15 : 18 __ __ CLC
0b16 : 20 f0 ff JSR $fff0 
.s1001:
0b19 : 60 __ __ RTS
--------------------------------------------------------------------
printf:
.s0:
0b1a : a9 01 __ LDA #$01
0b1c : 8d fd 9f STA $9ffd ; (sstack + 7)
0b1f : a9 a6 __ LDA #$a6
0b21 : 8d f7 9f STA $9ff7 ; (sstack + 1)
0b24 : a9 9f __ LDA #$9f
0b26 : 8d f8 9f STA $9ff8 ; (sstack + 2)
0b29 : a0 02 __ LDY #$02
0b2b : b1 23 __ LDA (SP + 0),y 
0b2d : 8d f9 9f STA $9ff9 ; (sstack + 3)
0b30 : c8 __ __ INY
0b31 : b1 23 __ LDA (SP + 0),y 
0b33 : 8d fa 9f STA $9ffa ; (sstack + 4)
0b36 : 18 __ __ CLC
0b37 : a5 23 __ LDA SP + 0 
0b39 : 69 04 __ ADC #$04
0b3b : 8d fb 9f STA $9ffb ; (sstack + 5)
0b3e : a5 24 __ LDA SP + 1 
0b40 : 69 00 __ ADC #$00
0b42 : 8d fc 9f STA $9ffc ; (sstack + 6)
0b45 : 4c 48 0b JMP $0b48 ; (sformat.s1000 + 0)
--------------------------------------------------------------------
sformat:
.s1000:
0b48 : a2 05 __ LDX #$05
0b4a : b5 53 __ LDA T1 + 0,x 
0b4c : 9d d8 9f STA $9fd8,x ; (sformat@stack + 0)
0b4f : ca __ __ DEX
0b50 : 10 f8 __ BPL $0b4a ; (sformat.s1000 + 2)
.s0:
0b52 : a9 00 __ LDA #$00
0b54 : 85 50 __ STA T0 + 0 
0b56 : ad f9 9f LDA $9ff9 ; (sstack + 3)
0b59 : 85 53 __ STA T1 + 0 
0b5b : ad fa 9f LDA $9ffa ; (sstack + 4)
0b5e : 85 54 __ STA T1 + 1 
0b60 : ad f7 9f LDA $9ff7 ; (sstack + 1)
0b63 : 85 55 __ STA T2 + 0 
0b65 : ad f8 9f LDA $9ff8 ; (sstack + 2)
0b68 : 85 56 __ STA T2 + 1 
.l1:
0b6a : a0 00 __ LDY #$00
0b6c : b1 53 __ LDA (T1 + 0),y 
0b6e : d0 38 __ BNE $0ba8 ; (sformat.s2 + 0)
.s3:
0b70 : a4 50 __ LDY T0 + 0 
0b72 : 91 55 __ STA (T2 + 0),y 
0b74 : 98 __ __ TYA
0b75 : f0 28 __ BEQ $0b9f ; (sformat.s1061 + 0)
.s112:
0b77 : ad fd 9f LDA $9ffd ; (sstack + 7)
0b7a : d0 18 __ BNE $0b94 ; (sformat.s115 + 0)
.s116:
0b7c : 18 __ __ CLC
0b7d : a5 55 __ LDA T2 + 0 
0b7f : 65 50 __ ADC T0 + 0 
0b81 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0b83 : a5 56 __ LDA T2 + 1 
0b85 : 69 00 __ ADC #$00
.s1001:
0b87 : 85 1c __ STA ACCU + 1 ; (fmt + 0)
0b89 : a2 05 __ LDX #$05
0b8b : bd d8 9f LDA $9fd8,x ; (sformat@stack + 0)
0b8e : 95 53 __ STA T1 + 0,x 
0b90 : ca __ __ DEX
0b91 : 10 f8 __ BPL $0b8b ; (sformat.s1001 + 4)
0b93 : 60 __ __ RTS
.s115:
0b94 : a5 55 __ LDA T2 + 0 
0b96 : 85 0d __ STA P0 
0b98 : a5 56 __ LDA T2 + 1 
0b9a : 85 0e __ STA P1 
0b9c : 20 8c 0f JSR $0f8c ; (puts.s0 + 0)
.s1061:
0b9f : a5 55 __ LDA T2 + 0 
0ba1 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0ba3 : a5 56 __ LDA T2 + 1 
0ba5 : 4c 87 0b JMP $0b87 ; (sformat.s1001 + 0)
.s2:
0ba8 : c9 25 __ CMP #$25
0baa : f0 3f __ BEQ $0beb ; (sformat.s4 + 0)
.s5:
0bac : a4 50 __ LDY T0 + 0 
0bae : 91 55 __ STA (T2 + 0),y 
0bb0 : e6 53 __ INC T1 + 0 
0bb2 : d0 02 __ BNE $0bb6 ; (sformat.s1090 + 0)
.s1089:
0bb4 : e6 54 __ INC T1 + 1 
.s1090:
0bb6 : c8 __ __ INY
0bb7 : 84 50 __ STY T0 + 0 
0bb9 : 98 __ __ TYA
0bba : c0 28 __ CPY #$28
0bbc : 90 ac __ BCC $0b6a ; (sformat.l1 + 0)
.s106:
0bbe : 85 57 __ STA T5 + 0 
0bc0 : a9 00 __ LDA #$00
0bc2 : 85 50 __ STA T0 + 0 
0bc4 : ad fd 9f LDA $9ffd ; (sstack + 7)
0bc7 : f0 14 __ BEQ $0bdd ; (sformat.s110 + 0)
.s109:
0bc9 : a5 55 __ LDA T2 + 0 
0bcb : 85 0d __ STA P0 
0bcd : a5 56 __ LDA T2 + 1 
0bcf : 85 0e __ STA P1 
0bd1 : a9 00 __ LDA #$00
0bd3 : a4 57 __ LDY T5 + 0 
0bd5 : 91 0d __ STA (P0),y 
0bd7 : 20 8c 0f JSR $0f8c ; (puts.s0 + 0)
0bda : 4c 6a 0b JMP $0b6a ; (sformat.l1 + 0)
.s110:
0bdd : 18 __ __ CLC
0bde : a5 55 __ LDA T2 + 0 
0be0 : 65 57 __ ADC T5 + 0 
0be2 : 85 55 __ STA T2 + 0 
0be4 : 90 84 __ BCC $0b6a ; (sformat.l1 + 0)
.s1092:
0be6 : e6 56 __ INC T2 + 1 
0be8 : 4c 6a 0b JMP $0b6a ; (sformat.l1 + 0)
.s4:
0beb : a5 50 __ LDA T0 + 0 
0bed : f0 27 __ BEQ $0c16 ; (sformat.s9 + 0)
.s7:
0bef : 84 50 __ STY T0 + 0 
0bf1 : 85 57 __ STA T5 + 0 
0bf3 : ad fd 9f LDA $9ffd ; (sstack + 7)
0bf6 : f0 13 __ BEQ $0c0b ; (sformat.s11 + 0)
.s10:
0bf8 : a5 55 __ LDA T2 + 0 
0bfa : 85 0d __ STA P0 
0bfc : a5 56 __ LDA T2 + 1 
0bfe : 85 0e __ STA P1 
0c00 : 98 __ __ TYA
0c01 : a4 57 __ LDY T5 + 0 
0c03 : 91 0d __ STA (P0),y 
0c05 : 20 8c 0f JSR $0f8c ; (puts.s0 + 0)
0c08 : 4c 16 0c JMP $0c16 ; (sformat.s9 + 0)
.s11:
0c0b : 18 __ __ CLC
0c0c : a5 55 __ LDA T2 + 0 
0c0e : 65 57 __ ADC T5 + 0 
0c10 : 85 55 __ STA T2 + 0 
0c12 : 90 02 __ BCC $0c16 ; (sformat.s9 + 0)
.s1087:
0c14 : e6 56 __ INC T2 + 1 
.s9:
0c16 : a9 0a __ LDA #$0a
0c18 : 8d e1 9f STA $9fe1 ; (si + 3)
0c1b : a9 00 __ LDA #$00
0c1d : 8d e2 9f STA $9fe2 ; (si + 4)
0c20 : 8d e3 9f STA $9fe3 ; (si + 5)
0c23 : 8d e4 9f STA $9fe4 ; (si + 6)
0c26 : 8d e5 9f STA $9fe5 ; (si + 7)
0c29 : a0 01 __ LDY #$01
0c2b : b1 53 __ LDA (T1 + 0),y 
0c2d : aa __ __ TAX
0c2e : a9 20 __ LDA #$20
0c30 : 8d de 9f STA $9fde ; (si + 0)
0c33 : a9 00 __ LDA #$00
0c35 : 8d df 9f STA $9fdf ; (si + 1)
0c38 : a9 ff __ LDA #$ff
0c3a : 8d e0 9f STA $9fe0 ; (si + 2)
0c3d : 18 __ __ CLC
0c3e : a5 53 __ LDA T1 + 0 
0c40 : 69 02 __ ADC #$02
.l14:
0c42 : 85 53 __ STA T1 + 0 
0c44 : 90 02 __ BCC $0c48 ; (sformat.s1074 + 0)
.s1073:
0c46 : e6 54 __ INC T1 + 1 
.s1074:
0c48 : 8a __ __ TXA
0c49 : e0 2b __ CPX #$2b
0c4b : d0 08 __ BNE $0c55 ; (sformat.s17 + 0)
.s16:
0c4d : a9 01 __ LDA #$01
0c4f : 8d e3 9f STA $9fe3 ; (si + 5)
0c52 : 4c 7f 0f JMP $0f7f ; (sformat.s224 + 0)
.s17:
0c55 : c9 30 __ CMP #$30
0c57 : d0 06 __ BNE $0c5f ; (sformat.s20 + 0)
.s19:
0c59 : 8d de 9f STA $9fde ; (si + 0)
0c5c : 4c 7f 0f JMP $0f7f ; (sformat.s224 + 0)
.s20:
0c5f : e0 23 __ CPX #$23
0c61 : d0 08 __ BNE $0c6b ; (sformat.s23 + 0)
.s22:
0c63 : a9 01 __ LDA #$01
0c65 : 8d e5 9f STA $9fe5 ; (si + 7)
0c68 : 4c 7f 0f JMP $0f7f ; (sformat.s224 + 0)
.s23:
0c6b : e0 2d __ CPX #$2d
0c6d : d0 08 __ BNE $0c77 ; (sformat.s15 + 0)
.s25:
0c6f : a9 01 __ LDA #$01
0c71 : 8d e4 9f STA $9fe4 ; (si + 6)
0c74 : 4c 7f 0f JMP $0f7f ; (sformat.s224 + 0)
.s15:
0c77 : 86 57 __ STX T5 + 0 
0c79 : e0 30 __ CPX #$30
0c7b : 90 53 __ BCC $0cd0 ; (sformat.s31 + 0)
.s32:
0c7d : e0 3a __ CPX #$3a
0c7f : b0 4f __ BCS $0cd0 ; (sformat.s31 + 0)
.s29:
0c81 : a9 00 __ LDA #$00
0c83 : 85 44 __ STA T6 + 0 
0c85 : 85 45 __ STA T6 + 1 
0c87 : e0 3a __ CPX #$3a
0c89 : b0 40 __ BCS $0ccb ; (sformat.s35 + 0)
.l34:
0c8b : a5 44 __ LDA T6 + 0 
0c8d : 0a __ __ ASL
0c8e : 85 1b __ STA ACCU + 0 ; (buff + 1)
0c90 : a5 45 __ LDA T6 + 1 
0c92 : 2a __ __ ROL
0c93 : 06 1b __ ASL ACCU + 0 ; (buff + 1)
0c95 : 2a __ __ ROL
0c96 : aa __ __ TAX
0c97 : 18 __ __ CLC
0c98 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0c9a : 65 44 __ ADC T6 + 0 
0c9c : 85 44 __ STA T6 + 0 
0c9e : 8a __ __ TXA
0c9f : 65 45 __ ADC T6 + 1 
0ca1 : 06 44 __ ASL T6 + 0 
0ca3 : 2a __ __ ROL
0ca4 : aa __ __ TAX
0ca5 : 18 __ __ CLC
0ca6 : a5 44 __ LDA T6 + 0 
0ca8 : 65 57 __ ADC T5 + 0 
0caa : 90 01 __ BCC $0cad ; (sformat.s1084 + 0)
.s1083:
0cac : e8 __ __ INX
.s1084:
0cad : 38 __ __ SEC
0cae : e9 30 __ SBC #$30
0cb0 : 85 44 __ STA T6 + 0 
0cb2 : 8a __ __ TXA
0cb3 : e9 00 __ SBC #$00
0cb5 : 85 45 __ STA T6 + 1 
0cb7 : a0 00 __ LDY #$00
0cb9 : b1 53 __ LDA (T1 + 0),y 
0cbb : 85 57 __ STA T5 + 0 
0cbd : e6 53 __ INC T1 + 0 
0cbf : d0 02 __ BNE $0cc3 ; (sformat.s1086 + 0)
.s1085:
0cc1 : e6 54 __ INC T1 + 1 
.s1086:
0cc3 : c9 30 __ CMP #$30
0cc5 : 90 04 __ BCC $0ccb ; (sformat.s35 + 0)
.s36:
0cc7 : c9 3a __ CMP #$3a
0cc9 : 90 c0 __ BCC $0c8b ; (sformat.l34 + 0)
.s35:
0ccb : a5 44 __ LDA T6 + 0 
0ccd : 8d df 9f STA $9fdf ; (si + 1)
.s31:
0cd0 : a5 57 __ LDA T5 + 0 
0cd2 : c9 2e __ CMP #$2e
0cd4 : d0 51 __ BNE $0d27 ; (sformat.s39 + 0)
.s37:
0cd6 : a9 00 __ LDA #$00
0cd8 : 85 44 __ STA T6 + 0 
.l203:
0cda : 85 45 __ STA T6 + 1 
0cdc : a0 00 __ LDY #$00
0cde : b1 53 __ LDA (T1 + 0),y 
0ce0 : 85 57 __ STA T5 + 0 
0ce2 : e6 53 __ INC T1 + 0 
0ce4 : d0 02 __ BNE $0ce8 ; (sformat.s1076 + 0)
.s1075:
0ce6 : e6 54 __ INC T1 + 1 
.s1076:
0ce8 : c9 30 __ CMP #$30
0cea : 90 04 __ BCC $0cf0 ; (sformat.s42 + 0)
.s43:
0cec : c9 3a __ CMP #$3a
0cee : 90 0a __ BCC $0cfa ; (sformat.s41 + 0)
.s42:
0cf0 : a5 44 __ LDA T6 + 0 
0cf2 : 8d e0 9f STA $9fe0 ; (si + 2)
0cf5 : a5 57 __ LDA T5 + 0 
0cf7 : 4c 27 0d JMP $0d27 ; (sformat.s39 + 0)
.s41:
0cfa : a5 44 __ LDA T6 + 0 
0cfc : 0a __ __ ASL
0cfd : 85 1b __ STA ACCU + 0 ; (buff + 1)
0cff : a5 45 __ LDA T6 + 1 
0d01 : 2a __ __ ROL
0d02 : 06 1b __ ASL ACCU + 0 ; (buff + 1)
0d04 : 2a __ __ ROL
0d05 : aa __ __ TAX
0d06 : 18 __ __ CLC
0d07 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0d09 : 65 44 __ ADC T6 + 0 
0d0b : 85 44 __ STA T6 + 0 
0d0d : 8a __ __ TXA
0d0e : 65 45 __ ADC T6 + 1 
0d10 : 06 44 __ ASL T6 + 0 
0d12 : 2a __ __ ROL
0d13 : aa __ __ TAX
0d14 : 18 __ __ CLC
0d15 : a5 44 __ LDA T6 + 0 
0d17 : 65 57 __ ADC T5 + 0 
0d19 : 90 01 __ BCC $0d1c ; (sformat.s1082 + 0)
.s1081:
0d1b : e8 __ __ INX
.s1082:
0d1c : 38 __ __ SEC
0d1d : e9 30 __ SBC #$30
0d1f : 85 44 __ STA T6 + 0 
0d21 : 8a __ __ TXA
0d22 : e9 00 __ SBC #$00
0d24 : 4c da 0c JMP $0cda ; (sformat.l203 + 0)
.s39:
0d27 : c9 64 __ CMP #$64
0d29 : d0 05 __ BNE $0d30 ; (sformat.s45 + 0)
.s44:
0d2b : a9 01 __ LDA #$01
0d2d : 4c 43 0f JMP $0f43 ; (sformat.s221 + 0)
.s45:
0d30 : c9 75 __ CMP #$75
0d32 : d0 03 __ BNE $0d37 ; (sformat.s48 + 0)
0d34 : 4c 41 0f JMP $0f41 ; (sformat.s250 + 0)
.s48:
0d37 : c9 78 __ CMP #$78
0d39 : d0 0d __ BNE $0d48 ; (sformat.s51 + 0)
.s50:
0d3b : a9 10 __ LDA #$10
0d3d : 8d e1 9f STA $9fe1 ; (si + 3)
0d40 : a9 00 __ LDA #$00
0d42 : 8d e2 9f STA $9fe2 ; (si + 4)
0d45 : 4c 41 0f JMP $0f41 ; (sformat.s250 + 0)
.s51:
0d48 : c9 6c __ CMP #$6c
0d4a : d0 03 __ BNE $0d4f ; (sformat.s54 + 0)
0d4c : 4c bc 0e JMP $0ebc ; (sformat.s53 + 0)
.s54:
0d4f : c9 66 __ CMP #$66
0d51 : f0 08 __ BEQ $0d5b ; (sformat.s65 + 0)
.s69:
0d53 : c9 67 __ CMP #$67
0d55 : f0 04 __ BEQ $0d5b ; (sformat.s65 + 0)
.s68:
0d57 : c9 65 __ CMP #$65
0d59 : d0 4d __ BNE $0da8 ; (sformat.s66 + 0)
.s65:
0d5b : a5 55 __ LDA T2 + 0 
0d5d : 85 13 __ STA P6 
0d5f : a5 56 __ LDA T2 + 1 
0d61 : 85 14 __ STA P7 
0d63 : a5 57 __ LDA T5 + 0 
0d65 : 8d f6 9f STA $9ff6 ; (sstack + 0)
0d68 : a9 de __ LDA #$de
0d6a : 85 11 __ STA P4 
0d6c : a9 9f __ LDA #$9f
0d6e : 85 12 __ STA P5 
0d70 : ad fb 9f LDA $9ffb ; (sstack + 5)
0d73 : 85 57 __ STA T5 + 0 
0d75 : ad fc 9f LDA $9ffc ; (sstack + 6)
0d78 : 85 58 __ STA T5 + 1 
0d7a : a0 00 __ LDY #$00
0d7c : b1 57 __ LDA (T5 + 0),y 
0d7e : 85 15 __ STA P8 
0d80 : c8 __ __ INY
0d81 : b1 57 __ LDA (T5 + 0),y 
0d83 : 85 16 __ STA P9 
0d85 : c8 __ __ INY
0d86 : b1 57 __ LDA (T5 + 0),y 
0d88 : 85 17 __ STA P10 
0d8a : c8 __ __ INY
0d8b : b1 57 __ LDA (T5 + 0),y 
0d8d : 85 18 __ STA P11 
0d8f : 20 d8 12 JSR $12d8 ; (nformf.s0 + 0)
0d92 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0d94 : 85 50 __ STA T0 + 0 
0d96 : 18 __ __ CLC
0d97 : a5 57 __ LDA T5 + 0 
0d99 : 69 04 __ ADC #$04
0d9b : 8d fb 9f STA $9ffb ; (sstack + 5)
0d9e : a5 58 __ LDA T5 + 1 
0da0 : 69 00 __ ADC #$00
0da2 : 8d fc 9f STA $9ffc ; (sstack + 6)
0da5 : 4c 6a 0b JMP $0b6a ; (sformat.l1 + 0)
.s66:
0da8 : c9 73 __ CMP #$73
0daa : f0 4c __ BEQ $0df8 ; (sformat.s70 + 0)
.s71:
0dac : c9 63 __ CMP #$63
0dae : f0 1f __ BEQ $0dcf ; (sformat.s100 + 0)
.s101:
0db0 : 09 00 __ ORA #$00
0db2 : d0 03 __ BNE $0db7 ; (sformat.s103 + 0)
0db4 : 4c 6a 0b JMP $0b6a ; (sformat.l1 + 0)
.s103:
0db7 : 18 __ __ CLC
0db8 : a5 55 __ LDA T2 + 0 
0dba : 65 50 __ ADC T0 + 0 
0dbc : 85 44 __ STA T6 + 0 
0dbe : a5 56 __ LDA T2 + 1 
0dc0 : 69 00 __ ADC #$00
0dc2 : 85 45 __ STA T6 + 1 
0dc4 : a5 57 __ LDA T5 + 0 
.s1059:
0dc6 : a0 00 __ LDY #$00
0dc8 : 91 44 __ STA (T6 + 0),y 
0dca : e6 50 __ INC T0 + 0 
0dcc : 4c 6a 0b JMP $0b6a ; (sformat.l1 + 0)
.s100:
0dcf : ad fb 9f LDA $9ffb ; (sstack + 5)
0dd2 : 85 57 __ STA T5 + 0 
0dd4 : 18 __ __ CLC
0dd5 : 69 02 __ ADC #$02
0dd7 : 8d fb 9f STA $9ffb ; (sstack + 5)
0dda : ad fc 9f LDA $9ffc ; (sstack + 6)
0ddd : 85 58 __ STA T5 + 1 
0ddf : 69 00 __ ADC #$00
0de1 : 8d fc 9f STA $9ffc ; (sstack + 6)
0de4 : 18 __ __ CLC
0de5 : a5 55 __ LDA T2 + 0 
0de7 : 65 50 __ ADC T0 + 0 
0de9 : 85 44 __ STA T6 + 0 
0deb : a5 56 __ LDA T2 + 1 
0ded : 69 00 __ ADC #$00
0def : 85 45 __ STA T6 + 1 
0df1 : a0 00 __ LDY #$00
0df3 : b1 57 __ LDA (T5 + 0),y 
0df5 : 4c c6 0d JMP $0dc6 ; (sformat.s1059 + 0)
.s70:
0df8 : ad fb 9f LDA $9ffb ; (sstack + 5)
0dfb : 85 57 __ STA T5 + 0 
0dfd : 18 __ __ CLC
0dfe : 69 02 __ ADC #$02
0e00 : 8d fb 9f STA $9ffb ; (sstack + 5)
0e03 : ad fc 9f LDA $9ffc ; (sstack + 6)
0e06 : 85 58 __ STA T5 + 1 
0e08 : 69 00 __ ADC #$00
0e0a : 8d fc 9f STA $9ffc ; (sstack + 6)
0e0d : a0 00 __ LDY #$00
0e0f : b1 57 __ LDA (T5 + 0),y 
0e11 : aa __ __ TAX
0e12 : c8 __ __ INY
0e13 : b1 57 __ LDA (T5 + 0),y 
0e15 : 86 57 __ STX T5 + 0 
0e17 : 85 58 __ STA T5 + 1 
0e19 : a9 00 __ LDA #$00
0e1b : 85 52 __ STA T3 + 0 
0e1d : ad df 9f LDA $9fdf ; (si + 1)
0e20 : f0 0c __ BEQ $0e2e ; (sformat.s75 + 0)
.s1065:
0e22 : 88 __ __ DEY
0e23 : b1 57 __ LDA (T5 + 0),y 
0e25 : f0 05 __ BEQ $0e2c ; (sformat.s1066 + 0)
.l77:
0e27 : c8 __ __ INY
0e28 : b1 57 __ LDA (T5 + 0),y 
0e2a : d0 fb __ BNE $0e27 ; (sformat.l77 + 0)
.s1066:
0e2c : 84 52 __ STY T3 + 0 
.s75:
0e2e : ad e4 9f LDA $9fe4 ; (si + 6)
0e31 : d0 19 __ BNE $0e4c ; (sformat.s81 + 0)
.s1069:
0e33 : a6 52 __ LDX T3 + 0 
0e35 : ec df 9f CPX $9fdf ; (si + 1)
0e38 : a4 50 __ LDY T0 + 0 
0e3a : b0 0c __ BCS $0e48 ; (sformat.s1070 + 0)
.l83:
0e3c : ad de 9f LDA $9fde ; (si + 0)
0e3f : 91 55 __ STA (T2 + 0),y 
0e41 : e8 __ __ INX
0e42 : ec df 9f CPX $9fdf ; (si + 1)
0e45 : c8 __ __ INY
0e46 : 90 f4 __ BCC $0e3c ; (sformat.l83 + 0)
.s1070:
0e48 : 86 52 __ STX T3 + 0 
0e4a : 84 50 __ STY T0 + 0 
.s81:
0e4c : ad fd 9f LDA $9ffd ; (sstack + 7)
0e4f : d0 37 __ BNE $0e88 ; (sformat.s85 + 0)
.l91:
0e51 : a0 00 __ LDY #$00
0e53 : b1 57 __ LDA (T5 + 0),y 
0e55 : f0 0f __ BEQ $0e66 ; (sformat.s211 + 0)
.s92:
0e57 : a4 50 __ LDY T0 + 0 
0e59 : 91 55 __ STA (T2 + 0),y 
0e5b : e6 50 __ INC T0 + 0 
0e5d : e6 57 __ INC T5 + 0 
0e5f : d0 f0 __ BNE $0e51 ; (sformat.l91 + 0)
.s1079:
0e61 : e6 58 __ INC T5 + 1 
0e63 : 4c 51 0e JMP $0e51 ; (sformat.l91 + 0)
.s211:
0e66 : ad e4 9f LDA $9fe4 ; (si + 6)
0e69 : d0 03 __ BNE $0e6e ; (sformat.s1067 + 0)
0e6b : 4c 6a 0b JMP $0b6a ; (sformat.l1 + 0)
.s1067:
0e6e : a6 52 __ LDX T3 + 0 
0e70 : ec df 9f CPX $9fdf ; (si + 1)
0e73 : a4 50 __ LDY T0 + 0 
0e75 : b0 0c __ BCS $0e83 ; (sformat.s1068 + 0)
.l98:
0e77 : ad de 9f LDA $9fde ; (si + 0)
0e7a : 91 55 __ STA (T2 + 0),y 
0e7c : e8 __ __ INX
0e7d : ec df 9f CPX $9fdf ; (si + 1)
0e80 : c8 __ __ INY
0e81 : 90 f4 __ BCC $0e77 ; (sformat.l98 + 0)
.s1068:
0e83 : 84 50 __ STY T0 + 0 
0e85 : 4c 6a 0b JMP $0b6a ; (sformat.l1 + 0)
.s85:
0e88 : a5 50 __ LDA T0 + 0 
0e8a : f0 22 __ BEQ $0eae ; (sformat.s90 + 0)
.s88:
0e8c : a5 55 __ LDA T2 + 0 
0e8e : 85 0d __ STA P0 
0e90 : a5 56 __ LDA T2 + 1 
0e92 : 85 0e __ STA P1 
0e94 : a9 00 __ LDA #$00
0e96 : a4 50 __ LDY T0 + 0 
0e98 : 91 0d __ STA (P0),y 
0e9a : 20 8c 0f JSR $0f8c ; (puts.s0 + 0)
0e9d : a5 57 __ LDA T5 + 0 
0e9f : 85 0d __ STA P0 
0ea1 : a5 58 __ LDA T5 + 1 
0ea3 : 85 0e __ STA P1 
0ea5 : 20 8c 0f JSR $0f8c ; (puts.s0 + 0)
0ea8 : a9 00 __ LDA #$00
0eaa : 85 50 __ STA T0 + 0 
0eac : f0 b8 __ BEQ $0e66 ; (sformat.s211 + 0)
.s90:
0eae : a5 57 __ LDA T5 + 0 
0eb0 : 85 0d __ STA P0 
0eb2 : a5 58 __ LDA T5 + 1 
0eb4 : 85 0e __ STA P1 
0eb6 : 20 8c 0f JSR $0f8c ; (puts.s0 + 0)
0eb9 : 4c 66 0e JMP $0e66 ; (sformat.s211 + 0)
.s53:
0ebc : ad fb 9f LDA $9ffb ; (sstack + 5)
0ebf : 85 57 __ STA T5 + 0 
0ec1 : 18 __ __ CLC
0ec2 : 69 04 __ ADC #$04
0ec4 : 8d fb 9f STA $9ffb ; (sstack + 5)
0ec7 : ad fc 9f LDA $9ffc ; (sstack + 6)
0eca : 85 58 __ STA T5 + 1 
0ecc : 69 00 __ ADC #$00
0ece : 8d fc 9f STA $9ffc ; (sstack + 6)
0ed1 : a0 00 __ LDY #$00
0ed3 : b1 53 __ LDA (T1 + 0),y 
0ed5 : 85 52 __ STA T3 + 0 
0ed7 : e6 53 __ INC T1 + 0 
0ed9 : d0 02 __ BNE $0edd ; (sformat.s1078 + 0)
.s1077:
0edb : e6 54 __ INC T1 + 1 
.s1078:
0edd : c9 64 __ CMP #$64
0edf : d0 04 __ BNE $0ee5 ; (sformat.s1019 + 0)
.s1018:
0ee1 : a2 01 __ LDX #$01
0ee3 : d0 02 __ BNE $0ee7 ; (sformat.s1020 + 0)
.s1019:
0ee5 : a2 00 __ LDX #$00
.s1020:
0ee7 : b1 57 __ LDA (T5 + 0),y 
0ee9 : 85 46 __ STA T7 + 0 
0eeb : a0 01 __ LDY #$01
0eed : b1 57 __ LDA (T5 + 0),y 
0eef : 85 47 __ STA T7 + 1 
0ef1 : c8 __ __ INY
0ef2 : b1 57 __ LDA (T5 + 0),y 
0ef4 : 85 48 __ STA T7 + 2 
0ef6 : c8 __ __ INY
0ef7 : b1 57 __ LDA (T5 + 0),y 
0ef9 : a8 __ __ TAY
0efa : 8a __ __ TXA
0efb : f0 04 __ BEQ $0f01 ; (sformat.s57 + 0)
.s56:
0efd : a9 01 __ LDA #$01
0eff : d0 16 __ BNE $0f17 ; (sformat.s222 + 0)
.s57:
0f01 : a5 52 __ LDA T3 + 0 
0f03 : c9 75 __ CMP #$75
0f05 : f0 0f __ BEQ $0f16 ; (sformat.s251 + 0)
.s60:
0f07 : c9 78 __ CMP #$78
0f09 : f0 03 __ BEQ $0f0e ; (sformat.s62 + 0)
0f0b : 4c 6a 0b JMP $0b6a ; (sformat.l1 + 0)
.s62:
0f0e : 8e e2 9f STX $9fe2 ; (si + 4)
0f11 : a9 10 __ LDA #$10
0f13 : 8d e1 9f STA $9fe1 ; (si + 3)
.s251:
0f16 : 8a __ __ TXA
.s222:
0f17 : 84 14 __ STY P7 
0f19 : 85 15 __ STA P8 
0f1b : a5 55 __ LDA T2 + 0 
0f1d : 85 0f __ STA P2 
0f1f : a5 56 __ LDA T2 + 1 
0f21 : 85 10 __ STA P3 
0f23 : a5 46 __ LDA T7 + 0 
0f25 : 85 11 __ STA P4 
0f27 : a5 47 __ LDA T7 + 1 
0f29 : 85 12 __ STA P5 
0f2b : a5 48 __ LDA T7 + 2 
0f2d : 85 13 __ STA P6 
0f2f : a9 de __ LDA #$de
0f31 : 85 0d __ STA P0 
0f33 : a9 9f __ LDA #$9f
0f35 : 85 0e __ STA P1 
0f37 : 20 40 11 JSR $1140 ; (nforml.s0 + 0)
.s1062:
0f3a : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0f3c : 85 50 __ STA T0 + 0 
0f3e : 4c 6a 0b JMP $0b6a ; (sformat.l1 + 0)
.s250:
0f41 : a9 00 __ LDA #$00
.s221:
0f43 : 85 13 __ STA P6 
0f45 : a5 55 __ LDA T2 + 0 
0f47 : 85 0f __ STA P2 
0f49 : a5 56 __ LDA T2 + 1 
0f4b : 85 10 __ STA P3 
0f4d : ad fb 9f LDA $9ffb ; (sstack + 5)
0f50 : 85 50 __ STA T0 + 0 
0f52 : ad fc 9f LDA $9ffc ; (sstack + 6)
0f55 : 85 51 __ STA T0 + 1 
0f57 : a0 00 __ LDY #$00
0f59 : b1 50 __ LDA (T0 + 0),y 
0f5b : 85 11 __ STA P4 
0f5d : c8 __ __ INY
0f5e : b1 50 __ LDA (T0 + 0),y 
0f60 : 85 12 __ STA P5 
0f62 : 18 __ __ CLC
0f63 : a5 50 __ LDA T0 + 0 
0f65 : 69 02 __ ADC #$02
0f67 : 8d fb 9f STA $9ffb ; (sstack + 5)
0f6a : a5 51 __ LDA T0 + 1 
0f6c : 69 00 __ ADC #$00
0f6e : 8d fc 9f STA $9ffc ; (sstack + 6)
0f71 : a9 de __ LDA #$de
0f73 : 85 0d __ STA P0 
0f75 : a9 9f __ LDA #$9f
0f77 : 85 0e __ STA P1 
0f79 : 20 e1 0f JSR $0fe1 ; (nformi.s0 + 0)
0f7c : 4c 3a 0f JMP $0f3a ; (sformat.s1062 + 0)
.s224:
0f7f : a0 00 __ LDY #$00
0f81 : b1 53 __ LDA (T1 + 0),y 
0f83 : aa __ __ TAX
0f84 : 18 __ __ CLC
0f85 : a5 53 __ LDA T1 + 0 
0f87 : 69 01 __ ADC #$01
0f89 : 4c 42 0c JMP $0c42 ; (sformat.l14 + 0)
--------------------------------------------------------------------
puts:
.s0:
0f8c : a0 00 __ LDY #$00
0f8e : b1 0d __ LDA (P0),y 
0f90 : f0 0b __ BEQ $0f9d ; (puts.s1001 + 0)
0f92 : 20 9e 0f JSR $0f9e ; (putpch + 0)
0f95 : e6 0d __ INC P0 
0f97 : d0 f3 __ BNE $0f8c ; (puts.s0 + 0)
0f99 : e6 0e __ INC P1 
0f9b : d0 ef __ BNE $0f8c ; (puts.s0 + 0)
.s1001:
0f9d : 60 __ __ RTS
--------------------------------------------------------------------
putpch:
0f9e : ae f9 22 LDX $22f9 ; (giocharmap + 0)
0fa1 : e0 01 __ CPX #$01
0fa3 : 90 26 __ BCC $0fcb ; (putpch + 45)
0fa5 : c9 0a __ CMP #$0a
0fa7 : d0 02 __ BNE $0fab ; (putpch + 13)
0fa9 : a9 0d __ LDA #$0d
0fab : c9 09 __ CMP #$09
0fad : f0 1f __ BEQ $0fce ; (putpch + 48)
0faf : e0 02 __ CPX #$02
0fb1 : 90 18 __ BCC $0fcb ; (putpch + 45)
0fb3 : c9 41 __ CMP #$41
0fb5 : 90 14 __ BCC $0fcb ; (putpch + 45)
0fb7 : c9 7b __ CMP #$7b
0fb9 : b0 10 __ BCS $0fcb ; (putpch + 45)
0fbb : c9 61 __ CMP #$61
0fbd : b0 04 __ BCS $0fc3 ; (putpch + 37)
0fbf : c9 5b __ CMP #$5b
0fc1 : b0 08 __ BCS $0fcb ; (putpch + 45)
0fc3 : 49 20 __ EOR #$20
0fc5 : e0 03 __ CPX #$03
0fc7 : f0 02 __ BEQ $0fcb ; (putpch + 45)
0fc9 : 29 df __ AND #$df
0fcb : 4c d2 ff JMP $ffd2 
0fce : 38 __ __ SEC
0fcf : 20 f0 ff JSR $fff0 
0fd2 : 98 __ __ TYA
0fd3 : 29 03 __ AND #$03
0fd5 : 49 03 __ EOR #$03
0fd7 : aa __ __ TAX
0fd8 : a9 20 __ LDA #$20
0fda : 20 d2 ff JSR $ffd2 
0fdd : ca __ __ DEX
0fde : 10 fa __ BPL $0fda ; (putpch + 60)
0fe0 : 60 __ __ RTS
--------------------------------------------------------------------
giocharmap:
22f9 : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
nformi:
.s0:
0fe1 : a9 00 __ LDA #$00
0fe3 : 85 43 __ STA T0 + 0 
0fe5 : a5 13 __ LDA P6 ; (s + 0)
0fe7 : f0 15 __ BEQ $0ffe ; (nformi.s159 + 0)
.s4:
0fe9 : a5 12 __ LDA P5 ; (v + 1)
0feb : 10 11 __ BPL $0ffe ; (nformi.s159 + 0)
.s1:
0fed : 38 __ __ SEC
0fee : a9 00 __ LDA #$00
0ff0 : e5 11 __ SBC P4 ; (v + 0)
0ff2 : 85 11 __ STA P4 ; (v + 0)
0ff4 : a9 00 __ LDA #$00
0ff6 : e5 12 __ SBC P5 ; (v + 1)
0ff8 : 85 12 __ STA P5 ; (v + 1)
0ffa : a9 01 __ LDA #$01
0ffc : 85 43 __ STA T0 + 0 
.s159:
0ffe : a9 10 __ LDA #$10
1000 : 85 44 __ STA T2 + 0 
1002 : a5 11 __ LDA P4 ; (v + 0)
1004 : 05 12 __ ORA P5 ; (v + 1)
1006 : f0 61 __ BEQ $1069 ; (nformi.s7 + 0)
.s45:
1008 : a5 0d __ LDA P0 ; (si + 0)
100a : 85 45 __ STA T4 + 0 
100c : a5 0e __ LDA P1 ; (si + 1)
100e : 85 46 __ STA T4 + 1 
.l6:
1010 : a0 03 __ LDY #$03
1012 : b1 45 __ LDA (T4 + 0),y 
1014 : 85 47 __ STA T5 + 0 
1016 : 85 03 __ STA WORK + 0 
1018 : c8 __ __ INY
1019 : b1 45 __ LDA (T4 + 0),y 
101b : 85 48 __ STA T5 + 1 
101d : 85 04 __ STA WORK + 1 
101f : a5 11 __ LDA P4 ; (v + 0)
1021 : 85 1b __ STA ACCU + 0 
1023 : a5 12 __ LDA P5 ; (v + 1)
1025 : 85 1c __ STA ACCU + 1 
1027 : 20 24 21 JSR $2124 ; (divmod + 0)
102a : a5 06 __ LDA WORK + 3 
102c : 30 10 __ BMI $103e ; (nformi.s9 + 0)
.s1019:
102e : d0 06 __ BNE $1036 ; (nformi.s8 + 0)
.s1018:
1030 : a5 05 __ LDA WORK + 2 
1032 : c9 0a __ CMP #$0a
1034 : 90 08 __ BCC $103e ; (nformi.s9 + 0)
.s8:
1036 : 18 __ __ CLC
1037 : a5 05 __ LDA WORK + 2 
1039 : 69 37 __ ADC #$37
103b : 4c 43 10 JMP $1043 ; (nformi.s10 + 0)
.s9:
103e : 18 __ __ CLC
103f : a5 05 __ LDA WORK + 2 
1041 : 69 30 __ ADC #$30
.s10:
1043 : c6 44 __ DEC T2 + 0 
1045 : a6 44 __ LDX T2 + 0 
1047 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
104a : a5 11 __ LDA P4 ; (v + 0)
104c : 85 1b __ STA ACCU + 0 
104e : a5 12 __ LDA P5 ; (v + 1)
1050 : 85 1c __ STA ACCU + 1 
1052 : a5 47 __ LDA T5 + 0 
1054 : 85 03 __ STA WORK + 0 
1056 : a5 48 __ LDA T5 + 1 
1058 : 85 04 __ STA WORK + 1 
105a : 20 24 21 JSR $2124 ; (divmod + 0)
105d : a5 1b __ LDA ACCU + 0 
105f : 85 11 __ STA P4 ; (v + 0)
1061 : a5 1c __ LDA ACCU + 1 
1063 : 85 12 __ STA P5 ; (v + 1)
1065 : 05 11 __ ORA P4 ; (v + 0)
1067 : d0 a7 __ BNE $1010 ; (nformi.l6 + 0)
.s7:
1069 : a5 0d __ LDA P0 ; (si + 0)
106b : 85 11 __ STA P4 ; (v + 0)
106d : a5 0e __ LDA P1 ; (si + 1)
106f : 85 12 __ STA P5 ; (v + 1)
1071 : a0 02 __ LDY #$02
1073 : b1 0d __ LDA (P0),y ; (si + 0)
1075 : c9 ff __ CMP #$ff
1077 : d0 04 __ BNE $107d ; (nformi.s76 + 0)
.s77:
1079 : a9 0f __ LDA #$0f
107b : d0 05 __ BNE $1082 ; (nformi.s1026 + 0)
.s76:
107d : 38 __ __ SEC
107e : a9 10 __ LDA #$10
1080 : f1 0d __ SBC (P0),y ; (si + 0)
.s1026:
1082 : a8 __ __ TAY
1083 : c4 44 __ CPY T2 + 0 
1085 : b0 0d __ BCS $1094 ; (nformi.s13 + 0)
.s12:
1087 : a9 30 __ LDA #$30
.l1027:
1089 : c6 44 __ DEC T2 + 0 
108b : a6 44 __ LDX T2 + 0 
108d : 9d e6 9f STA $9fe6,x ; (buffer + 0)
1090 : c4 44 __ CPY T2 + 0 
1092 : 90 f5 __ BCC $1089 ; (nformi.l1027 + 0)
.s13:
1094 : a0 07 __ LDY #$07
1096 : b1 0d __ LDA (P0),y ; (si + 0)
1098 : f0 20 __ BEQ $10ba ; (nformi.s16 + 0)
.s17:
109a : a0 04 __ LDY #$04
109c : b1 0d __ LDA (P0),y ; (si + 0)
109e : d0 1a __ BNE $10ba ; (nformi.s16 + 0)
.s1013:
10a0 : 88 __ __ DEY
10a1 : b1 0d __ LDA (P0),y ; (si + 0)
10a3 : c9 10 __ CMP #$10
10a5 : d0 13 __ BNE $10ba ; (nformi.s16 + 0)
.s14:
10a7 : a9 58 __ LDA #$58
10a9 : a6 44 __ LDX T2 + 0 
10ab : 9d e5 9f STA $9fe5,x ; (si + 7)
10ae : 8a __ __ TXA
10af : 18 __ __ CLC
10b0 : 69 fe __ ADC #$fe
10b2 : 85 44 __ STA T2 + 0 
10b4 : aa __ __ TAX
10b5 : a9 30 __ LDA #$30
10b7 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
.s16:
10ba : a9 00 __ LDA #$00
10bc : 85 1b __ STA ACCU + 0 
10be : a5 43 __ LDA T0 + 0 
10c0 : f0 06 __ BEQ $10c8 ; (nformi.s19 + 0)
.s18:
10c2 : c6 44 __ DEC T2 + 0 
10c4 : a9 2d __ LDA #$2d
10c6 : d0 0a __ BNE $10d2 ; (nformi.s1025 + 0)
.s19:
10c8 : a0 05 __ LDY #$05
10ca : b1 0d __ LDA (P0),y ; (si + 0)
10cc : f0 09 __ BEQ $10d7 ; (nformi.s141 + 0)
.s21:
10ce : c6 44 __ DEC T2 + 0 
10d0 : a9 2b __ LDA #$2b
.s1025:
10d2 : a6 44 __ LDX T2 + 0 
10d4 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
.s141:
10d7 : a0 06 __ LDY #$06
10d9 : b1 0d __ LDA (P0),y ; (si + 0)
10db : d0 37 __ BNE $1114 ; (nformi.s27 + 0)
.l33:
10dd : a0 01 __ LDY #$01
10df : b1 11 __ LDA (P4),y ; (v + 0)
10e1 : 18 __ __ CLC
10e2 : 65 44 __ ADC T2 + 0 
10e4 : b0 04 __ BCS $10ea ; (nformi.s34 + 0)
.s1006:
10e6 : c9 11 __ CMP #$11
10e8 : 90 0e __ BCC $10f8 ; (nformi.s36 + 0)
.s34:
10ea : c6 44 __ DEC T2 + 0 
10ec : a0 00 __ LDY #$00
10ee : b1 11 __ LDA (P4),y ; (v + 0)
10f0 : a6 44 __ LDX T2 + 0 
10f2 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
10f5 : 4c dd 10 JMP $10dd ; (nformi.l33 + 0)
.s36:
10f8 : a6 44 __ LDX T2 + 0 
10fa : e0 10 __ CPX #$10
10fc : b0 11 __ BCS $110f ; (nformi.s26 + 0)
.s1022:
10fe : 88 __ __ DEY
.l1031:
10ff : bd e6 9f LDA $9fe6,x ; (buffer + 0)
1102 : 91 0f __ STA (P2),y ; (str + 0)
1104 : e6 44 __ INC T2 + 0 
1106 : a6 44 __ LDX T2 + 0 
1108 : e0 10 __ CPX #$10
110a : c8 __ __ INY
110b : 90 f2 __ BCC $10ff ; (nformi.l1031 + 0)
.s1032:
110d : 84 1b __ STY ACCU + 0 
.s26:
110f : a9 00 __ LDA #$00
1111 : 85 1c __ STA ACCU + 1 
.s1001:
1113 : 60 __ __ RTS
.s27:
1114 : a6 44 __ LDX T2 + 0 
1116 : e0 10 __ CPX #$10
1118 : b0 12 __ BCS $112c ; (nformi.l30 + 0)
.s1020:
111a : a0 00 __ LDY #$00
.l1029:
111c : bd e6 9f LDA $9fe6,x ; (buffer + 0)
111f : 91 0f __ STA (P2),y ; (str + 0)
1121 : e6 44 __ INC T2 + 0 
1123 : a6 44 __ LDX T2 + 0 
1125 : e0 10 __ CPX #$10
1127 : c8 __ __ INY
1128 : 90 f2 __ BCC $111c ; (nformi.l1029 + 0)
.s1030:
112a : 84 1b __ STY ACCU + 0 
.l30:
112c : a5 1b __ LDA ACCU + 0 
112e : a0 01 __ LDY #$01
1130 : d1 11 __ CMP (P4),y ; (v + 0)
1132 : b0 db __ BCS $110f ; (nformi.s26 + 0)
.s31:
1134 : 88 __ __ DEY
1135 : b1 11 __ LDA (P4),y ; (v + 0)
1137 : a4 1b __ LDY ACCU + 0 
1139 : 91 0f __ STA (P2),y ; (str + 0)
113b : e6 1b __ INC ACCU + 0 
113d : 4c 2c 11 JMP $112c ; (nformi.l30 + 0)
--------------------------------------------------------------------
nforml:
.s0:
1140 : a9 00 __ LDA #$00
1142 : 85 43 __ STA T0 + 0 
1144 : a5 15 __ LDA P8 ; (s + 0)
1146 : f0 23 __ BEQ $116b ; (nforml.s159 + 0)
.s4:
1148 : a5 14 __ LDA P7 ; (v + 3)
114a : f0 1f __ BEQ $116b ; (nforml.s159 + 0)
.s1032:
114c : 10 1d __ BPL $116b ; (nforml.s159 + 0)
.s1:
114e : 38 __ __ SEC
114f : a9 00 __ LDA #$00
1151 : e5 11 __ SBC P4 ; (v + 0)
1153 : 85 11 __ STA P4 ; (v + 0)
1155 : a9 00 __ LDA #$00
1157 : e5 12 __ SBC P5 ; (v + 1)
1159 : 85 12 __ STA P5 ; (v + 1)
115b : a9 00 __ LDA #$00
115d : e5 13 __ SBC P6 ; (v + 2)
115f : 85 13 __ STA P6 ; (v + 2)
1161 : a9 00 __ LDA #$00
1163 : e5 14 __ SBC P7 ; (v + 3)
1165 : 85 14 __ STA P7 ; (v + 3)
1167 : a9 01 __ LDA #$01
1169 : 85 43 __ STA T0 + 0 
.s159:
116b : a9 10 __ LDA #$10
116d : 85 44 __ STA T2 + 0 
116f : a5 14 __ LDA P7 ; (v + 3)
1171 : f0 03 __ BEQ $1176 ; (nforml.s1018 + 0)
1173 : 4c 5a 12 JMP $125a ; (nforml.l6 + 0)
.s1018:
1176 : a5 13 __ LDA P6 ; (v + 2)
1178 : f0 03 __ BEQ $117d ; (nforml.s1019 + 0)
117a : 4c 5a 12 JMP $125a ; (nforml.l6 + 0)
.s1019:
117d : a5 12 __ LDA P5 ; (v + 1)
117f : f0 03 __ BEQ $1184 ; (nforml.s1020 + 0)
1181 : 4c 5a 12 JMP $125a ; (nforml.l6 + 0)
.s1020:
1184 : c5 11 __ CMP P4 ; (v + 0)
1186 : b0 03 __ BCS $118b ; (nforml.s7 + 0)
1188 : 4c 5a 12 JMP $125a ; (nforml.l6 + 0)
.s7:
118b : a0 02 __ LDY #$02
118d : b1 0d __ LDA (P0),y ; (si + 0)
118f : c9 ff __ CMP #$ff
1191 : d0 04 __ BNE $1197 ; (nforml.s76 + 0)
.s77:
1193 : a9 0f __ LDA #$0f
1195 : d0 05 __ BNE $119c ; (nforml.s1039 + 0)
.s76:
1197 : 38 __ __ SEC
1198 : a9 10 __ LDA #$10
119a : f1 0d __ SBC (P0),y ; (si + 0)
.s1039:
119c : a8 __ __ TAY
119d : c4 44 __ CPY T2 + 0 
119f : b0 0d __ BCS $11ae ; (nforml.s13 + 0)
.s12:
11a1 : a9 30 __ LDA #$30
.l1040:
11a3 : c6 44 __ DEC T2 + 0 
11a5 : a6 44 __ LDX T2 + 0 
11a7 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
11aa : c4 44 __ CPY T2 + 0 
11ac : 90 f5 __ BCC $11a3 ; (nforml.l1040 + 0)
.s13:
11ae : a0 07 __ LDY #$07
11b0 : b1 0d __ LDA (P0),y ; (si + 0)
11b2 : f0 20 __ BEQ $11d4 ; (nforml.s16 + 0)
.s17:
11b4 : a0 04 __ LDY #$04
11b6 : b1 0d __ LDA (P0),y ; (si + 0)
11b8 : d0 1a __ BNE $11d4 ; (nforml.s16 + 0)
.s1013:
11ba : 88 __ __ DEY
11bb : b1 0d __ LDA (P0),y ; (si + 0)
11bd : c9 10 __ CMP #$10
11bf : d0 13 __ BNE $11d4 ; (nforml.s16 + 0)
.s14:
11c1 : a9 58 __ LDA #$58
11c3 : a6 44 __ LDX T2 + 0 
11c5 : 9d e5 9f STA $9fe5,x ; (si + 7)
11c8 : 8a __ __ TXA
11c9 : 18 __ __ CLC
11ca : 69 fe __ ADC #$fe
11cc : 85 44 __ STA T2 + 0 
11ce : aa __ __ TAX
11cf : a9 30 __ LDA #$30
11d1 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
.s16:
11d4 : a9 00 __ LDA #$00
11d6 : 85 1b __ STA ACCU + 0 
11d8 : a5 43 __ LDA T0 + 0 
11da : f0 06 __ BEQ $11e2 ; (nforml.s19 + 0)
.s18:
11dc : c6 44 __ DEC T2 + 0 
11de : a9 2d __ LDA #$2d
11e0 : d0 0a __ BNE $11ec ; (nforml.s1038 + 0)
.s19:
11e2 : a0 05 __ LDY #$05
11e4 : b1 0d __ LDA (P0),y ; (si + 0)
11e6 : f0 09 __ BEQ $11f1 ; (nforml.s141 + 0)
.s21:
11e8 : c6 44 __ DEC T2 + 0 
11ea : a9 2b __ LDA #$2b
.s1038:
11ec : a6 44 __ LDX T2 + 0 
11ee : 9d e6 9f STA $9fe6,x ; (buffer + 0)
.s141:
11f1 : a0 06 __ LDY #$06
11f3 : b1 0d __ LDA (P0),y ; (si + 0)
11f5 : d0 37 __ BNE $122e ; (nforml.s27 + 0)
.l33:
11f7 : a0 01 __ LDY #$01
11f9 : b1 0d __ LDA (P0),y ; (si + 0)
11fb : 18 __ __ CLC
11fc : 65 44 __ ADC T2 + 0 
11fe : b0 04 __ BCS $1204 ; (nforml.s34 + 0)
.s1006:
1200 : c9 11 __ CMP #$11
1202 : 90 0e __ BCC $1212 ; (nforml.s36 + 0)
.s34:
1204 : c6 44 __ DEC T2 + 0 
1206 : a0 00 __ LDY #$00
1208 : b1 0d __ LDA (P0),y ; (si + 0)
120a : a6 44 __ LDX T2 + 0 
120c : 9d e6 9f STA $9fe6,x ; (buffer + 0)
120f : 4c f7 11 JMP $11f7 ; (nforml.l33 + 0)
.s36:
1212 : a6 44 __ LDX T2 + 0 
1214 : e0 10 __ CPX #$10
1216 : b0 11 __ BCS $1229 ; (nforml.s26 + 0)
.s1035:
1218 : 88 __ __ DEY
.l1044:
1219 : bd e6 9f LDA $9fe6,x ; (buffer + 0)
121c : 91 0f __ STA (P2),y ; (str + 0)
121e : e6 44 __ INC T2 + 0 
1220 : a6 44 __ LDX T2 + 0 
1222 : e0 10 __ CPX #$10
1224 : c8 __ __ INY
1225 : 90 f2 __ BCC $1219 ; (nforml.l1044 + 0)
.s1045:
1227 : 84 1b __ STY ACCU + 0 
.s26:
1229 : a9 00 __ LDA #$00
122b : 85 1c __ STA ACCU + 1 
.s1001:
122d : 60 __ __ RTS
.s27:
122e : a6 44 __ LDX T2 + 0 
1230 : e0 10 __ CPX #$10
1232 : b0 12 __ BCS $1246 ; (nforml.l30 + 0)
.s1033:
1234 : a0 00 __ LDY #$00
.l1042:
1236 : bd e6 9f LDA $9fe6,x ; (buffer + 0)
1239 : 91 0f __ STA (P2),y ; (str + 0)
123b : e6 44 __ INC T2 + 0 
123d : a6 44 __ LDX T2 + 0 
123f : e0 10 __ CPX #$10
1241 : c8 __ __ INY
1242 : 90 f2 __ BCC $1236 ; (nforml.l1042 + 0)
.s1043:
1244 : 84 1b __ STY ACCU + 0 
.l30:
1246 : a5 1b __ LDA ACCU + 0 
1248 : a0 01 __ LDY #$01
124a : d1 0d __ CMP (P0),y ; (si + 0)
124c : b0 db __ BCS $1229 ; (nforml.s26 + 0)
.s31:
124e : 88 __ __ DEY
124f : b1 0d __ LDA (P0),y ; (si + 0)
1251 : a4 1b __ LDY ACCU + 0 
1253 : 91 0f __ STA (P2),y ; (str + 0)
1255 : e6 1b __ INC ACCU + 0 
1257 : 4c 46 12 JMP $1246 ; (nforml.l30 + 0)
.l6:
125a : a0 03 __ LDY #$03
125c : b1 0d __ LDA (P0),y ; (si + 0)
125e : 85 03 __ STA WORK + 0 
1260 : 85 45 __ STA T6 + 0 
1262 : c8 __ __ INY
1263 : b1 0d __ LDA (P0),y ; (si + 0)
1265 : 85 46 __ STA T6 + 1 
1267 : 85 04 __ STA WORK + 1 
1269 : a5 11 __ LDA P4 ; (v + 0)
126b : 85 1b __ STA ACCU + 0 
126d : a5 12 __ LDA P5 ; (v + 1)
126f : 85 1c __ STA ACCU + 1 
1271 : a5 13 __ LDA P6 ; (v + 2)
1273 : 85 1d __ STA ACCU + 2 
1275 : a5 14 __ LDA P7 ; (v + 3)
1277 : 85 1e __ STA ACCU + 3 
1279 : a9 00 __ LDA #$00
127b : 85 05 __ STA WORK + 2 
127d : 85 06 __ STA WORK + 3 
127f : 20 5f 22 JSR $225f ; (divmod32 + 0)
1282 : a5 08 __ LDA WORK + 5 
1284 : 30 10 __ BMI $1296 ; (nforml.s9 + 0)
.s1023:
1286 : d0 06 __ BNE $128e ; (nforml.s8 + 0)
.s1022:
1288 : a5 07 __ LDA WORK + 4 
128a : c9 0a __ CMP #$0a
128c : 90 08 __ BCC $1296 ; (nforml.s9 + 0)
.s8:
128e : 18 __ __ CLC
128f : a5 07 __ LDA WORK + 4 
1291 : 69 37 __ ADC #$37
1293 : 4c 9b 12 JMP $129b ; (nforml.s10 + 0)
.s9:
1296 : 18 __ __ CLC
1297 : a5 07 __ LDA WORK + 4 
1299 : 69 30 __ ADC #$30
.s10:
129b : c6 44 __ DEC T2 + 0 
129d : a6 44 __ LDX T2 + 0 
129f : 9d e6 9f STA $9fe6,x ; (buffer + 0)
12a2 : a5 11 __ LDA P4 ; (v + 0)
12a4 : 85 1b __ STA ACCU + 0 
12a6 : a5 12 __ LDA P5 ; (v + 1)
12a8 : 85 1c __ STA ACCU + 1 
12aa : a5 13 __ LDA P6 ; (v + 2)
12ac : 85 1d __ STA ACCU + 2 
12ae : a5 14 __ LDA P7 ; (v + 3)
12b0 : 85 1e __ STA ACCU + 3 
12b2 : a5 45 __ LDA T6 + 0 
12b4 : 85 03 __ STA WORK + 0 
12b6 : a5 46 __ LDA T6 + 1 
12b8 : 85 04 __ STA WORK + 1 
12ba : a9 00 __ LDA #$00
12bc : 85 05 __ STA WORK + 2 
12be : 85 06 __ STA WORK + 3 
12c0 : 20 5f 22 JSR $225f ; (divmod32 + 0)
12c3 : a5 1b __ LDA ACCU + 0 
12c5 : 85 11 __ STA P4 ; (v + 0)
12c7 : a5 1c __ LDA ACCU + 1 
12c9 : 85 12 __ STA P5 ; (v + 1)
12cb : a5 1d __ LDA ACCU + 2 
12cd : 85 13 __ STA P6 ; (v + 2)
12cf : a5 1e __ LDA ACCU + 3 
12d1 : 85 14 __ STA P7 ; (v + 3)
12d3 : d0 85 __ BNE $125a ; (nforml.l6 + 0)
12d5 : 4c 76 11 JMP $1176 ; (nforml.s1018 + 0)
--------------------------------------------------------------------
nformf:
.s0:
12d8 : a5 15 __ LDA P8 ; (f + 0)
12da : 85 43 __ STA T1 + 0 
12dc : a5 16 __ LDA P9 ; (f + 1)
12de : 85 44 __ STA T1 + 1 
12e0 : a5 17 __ LDA P10 ; (f + 2)
12e2 : 85 45 __ STA T1 + 2 
12e4 : a5 18 __ LDA P11 ; (f + 3)
12e6 : 29 7f __ AND #$7f
12e8 : 05 17 __ ORA P10 ; (f + 2)
12ea : 05 16 __ ORA P9 ; (f + 1)
12ec : 05 15 __ ORA P8 ; (f + 0)
12ee : f0 21 __ BEQ $1311 ; (nformf.s2 + 0)
.s1005:
12f0 : a5 18 __ LDA P11 ; (f + 3)
12f2 : 10 1d __ BPL $1311 ; (nformf.s2 + 0)
.s1:
12f4 : a9 2d __ LDA #$2d
12f6 : a0 00 __ LDY #$00
12f8 : 91 13 __ STA (P6),y ; (str + 0)
12fa : a5 18 __ LDA P11 ; (f + 3)
12fc : 49 80 __ EOR #$80
12fe : 85 18 __ STA P11 ; (f + 3)
1300 : 85 10 __ STA P3 
1302 : a5 15 __ LDA P8 ; (f + 0)
1304 : 85 0d __ STA P0 
1306 : a5 16 __ LDA P9 ; (f + 1)
1308 : 85 0e __ STA P1 
130a : a5 17 __ LDA P10 ; (f + 2)
130c : 85 0f __ STA P2 
130e : 4c 91 17 JMP $1791 ; (nformf.s189 + 0)
.s2:
1311 : a5 15 __ LDA P8 ; (f + 0)
1313 : 85 0d __ STA P0 
1315 : a5 16 __ LDA P9 ; (f + 1)
1317 : 85 0e __ STA P1 
1319 : a5 17 __ LDA P10 ; (f + 2)
131b : 85 0f __ STA P2 
131d : a5 18 __ LDA P11 ; (f + 3)
131f : 85 10 __ STA P3 
1321 : a0 05 __ LDY #$05
1323 : b1 11 __ LDA (P4),y ; (si + 0)
1325 : f0 09 __ BEQ $1330 ; (nformf.s3 + 0)
.s4:
1327 : a9 2b __ LDA #$2b
1329 : a0 00 __ LDY #$00
132b : 91 13 __ STA (P6),y ; (str + 0)
132d : 4c 91 17 JMP $1791 ; (nformf.s189 + 0)
.s3:
1330 : 20 a9 17 JSR $17a9 ; (isinf.s0 + 0)
1333 : aa __ __ TAX
1334 : a9 00 __ LDA #$00
1336 : 85 48 __ STA T3 + 0 
1338 : 8a __ __ TXA
1339 : f0 0b __ BEQ $1346 ; (nformf.s8 + 0)
.s160:
133b : a9 01 __ LDA #$01
133d : 85 4a __ STA T5 + 0 
133f : a9 02 __ LDA #$02
1341 : a0 00 __ LDY #$00
1343 : 4c 75 17 JMP $1775 ; (nformf.s7 + 0)
.s8:
1346 : a0 02 __ LDY #$02
1348 : b1 11 __ LDA (P4),y ; (si + 0)
134a : c9 ff __ CMP #$ff
134c : d0 02 __ BNE $1350 ; (nformf.s128 + 0)
.s129:
134e : a9 06 __ LDA #$06
.s128:
1350 : 86 4a __ STX T5 + 0 
1352 : 86 4b __ STX T5 + 1 
1354 : 85 49 __ STA T4 + 0 
1356 : 85 47 __ STA T2 + 0 
1358 : a5 18 __ LDA P11 ; (f + 3)
135a : 85 46 __ STA T1 + 3 
135c : 29 7f __ AND #$7f
135e : 05 17 __ ORA P10 ; (f + 2)
1360 : 05 16 __ ORA P9 ; (f + 1)
1362 : 05 15 __ ORA P8 ; (f + 0)
1364 : f0 03 __ BEQ $1369 ; (nformf.s12 + 0)
1366 : 4c 76 16 JMP $1676 ; (nformf.s13 + 0)
.s12:
1369 : ad f6 9f LDA $9ff6 ; (sstack + 0)
136c : c9 65 __ CMP #$65
136e : d0 04 __ BNE $1374 ; (nformf.s1007 + 0)
.s1006:
1370 : a9 01 __ LDA #$01
1372 : d0 02 __ BNE $1376 ; (nformf.s1008 + 0)
.s1007:
1374 : a9 00 __ LDA #$00
.s1008:
1376 : 85 4e __ STA T9 + 0 
1378 : a6 49 __ LDX T4 + 0 
137a : e8 __ __ INX
137b : 86 4c __ STX T8 + 0 
137d : ad f6 9f LDA $9ff6 ; (sstack + 0)
1380 : c9 67 __ CMP #$67
1382 : d0 13 __ BNE $1397 ; (nformf.s24 + 0)
.s22:
1384 : a5 4b __ LDA T5 + 1 
1386 : 30 08 __ BMI $1390 ; (nformf.s25 + 0)
.s1050:
1388 : d0 06 __ BNE $1390 ; (nformf.s25 + 0)
.s1049:
138a : a5 4a __ LDA T5 + 0 
138c : c9 04 __ CMP #$04
138e : 90 07 __ BCC $1397 ; (nformf.s24 + 0)
.s25:
1390 : a9 01 __ LDA #$01
1392 : 85 4e __ STA T9 + 0 
1394 : 4c ee 15 JMP $15ee ; (nformf.s30 + 0)
.s24:
1397 : a5 4e __ LDA T9 + 0 
1399 : f0 03 __ BEQ $139e ; (nformf.s32 + 0)
139b : 4c ee 15 JMP $15ee ; (nformf.s30 + 0)
.s32:
139e : a5 4b __ LDA T5 + 1 
13a0 : 10 3e __ BPL $13e0 ; (nformf.s34 + 0)
.s33:
13a2 : a5 43 __ LDA T1 + 0 
13a4 : 85 1b __ STA ACCU + 0 
13a6 : a5 44 __ LDA T1 + 1 
13a8 : 85 1c __ STA ACCU + 1 
13aa : a5 45 __ LDA T1 + 2 
13ac : 85 1d __ STA ACCU + 2 
13ae : a5 46 __ LDA T1 + 3 
13b0 : 85 1e __ STA ACCU + 3 
.l1085:
13b2 : e6 4a __ INC T5 + 0 
13b4 : d0 02 __ BNE $13b8 ; (nformf.s1095 + 0)
.s1094:
13b6 : e6 4b __ INC T5 + 1 
.s1095:
13b8 : a9 00 __ LDA #$00
13ba : 85 03 __ STA WORK + 0 
13bc : 85 04 __ STA WORK + 1 
13be : a9 20 __ LDA #$20
13c0 : 85 05 __ STA WORK + 2 
13c2 : a9 41 __ LDA #$41
13c4 : 85 06 __ STA WORK + 3 
13c6 : 20 55 1e JSR $1e55 ; (freg + 20)
13c9 : 20 3c 20 JSR $203c ; (fdiv + 0)
13cc : a5 4b __ LDA T5 + 1 
13ce : 30 e2 __ BMI $13b2 ; (nformf.l1085 + 0)
.s1086:
13d0 : a5 1e __ LDA ACCU + 3 
13d2 : 85 46 __ STA T1 + 3 
13d4 : a5 1d __ LDA ACCU + 2 
13d6 : 85 45 __ STA T1 + 2 
13d8 : a5 1c __ LDA ACCU + 1 
13da : 85 44 __ STA T1 + 1 
13dc : a5 1b __ LDA ACCU + 0 
13de : 85 43 __ STA T1 + 0 
.s34:
13e0 : 18 __ __ CLC
13e1 : a5 49 __ LDA T4 + 0 
13e3 : 65 4a __ ADC T5 + 0 
13e5 : 18 __ __ CLC
13e6 : 69 01 __ ADC #$01
13e8 : 85 4c __ STA T8 + 0 
13ea : c9 07 __ CMP #$07
13ec : 90 13 __ BCC $1401 ; (nformf.s35 + 0)
.s36:
13ee : ad 49 23 LDA $2349 ; (fround5 + 25)
13f1 : 85 1c __ STA ACCU + 1 
13f3 : ad 4a 23 LDA $234a ; (fround5 + 26)
13f6 : 85 1d __ STA ACCU + 2 
13f8 : ad 4b 23 LDA $234b ; (fround5 + 27)
13fb : ae 48 23 LDX $2348 ; (fround5 + 24)
13fe : 4c 14 14 JMP $1414 ; (nformf.s214 + 0)
.s35:
1401 : 0a __ __ ASL
1402 : 0a __ __ ASL
1403 : a8 __ __ TAY
1404 : b9 2d 23 LDA $232d,y ; (ChrRedef + 45)
1407 : 85 1c __ STA ACCU + 1 
1409 : b9 2e 23 LDA $232e,y ; (ChrRedef + 46)
140c : 85 1d __ STA ACCU + 2 
140e : b9 2f 23 LDA $232f,y ; (ChrRedef + 47)
1411 : be 2c 23 LDX $232c,y ; (ChrRedef + 44)
.s214:
1414 : 86 1b __ STX ACCU + 0 
1416 : 85 1e __ STA ACCU + 3 
1418 : a2 43 __ LDX #$43
141a : 20 45 1e JSR $1e45 ; (freg + 4)
141d : 20 86 1e JSR $1e86 ; (faddsub + 0)
1420 : a5 1c __ LDA ACCU + 1 
1422 : 85 16 __ STA P9 ; (f + 1)
1424 : a5 1d __ LDA ACCU + 2 
1426 : 85 17 __ STA P10 ; (f + 2)
1428 : a6 1b __ LDX ACCU + 0 
142a : a5 1e __ LDA ACCU + 3 
142c : 85 18 __ STA P11 ; (f + 3)
142e : 30 35 __ BMI $1465 ; (nformf.s31 + 0)
.s1032:
1430 : c9 41 __ CMP #$41
1432 : d0 06 __ BNE $143a ; (nformf.s1036 + 0)
.s1033:
1434 : a5 17 __ LDA P10 ; (f + 2)
1436 : c9 20 __ CMP #$20
1438 : f0 02 __ BEQ $143c ; (nformf.s38 + 0)
.s1036:
143a : 90 29 __ BCC $1465 ; (nformf.s31 + 0)
.s38:
143c : a9 00 __ LDA #$00
143e : 85 03 __ STA WORK + 0 
1440 : 85 04 __ STA WORK + 1 
1442 : a9 20 __ LDA #$20
1444 : 85 05 __ STA WORK + 2 
1446 : a9 41 __ LDA #$41
1448 : 85 06 __ STA WORK + 3 
144a : 20 55 1e JSR $1e55 ; (freg + 20)
144d : 20 3c 20 JSR $203c ; (fdiv + 0)
1450 : a5 1c __ LDA ACCU + 1 
1452 : 85 16 __ STA P9 ; (f + 1)
1454 : a5 1d __ LDA ACCU + 2 
1456 : 85 17 __ STA P10 ; (f + 2)
1458 : a5 1e __ LDA ACCU + 3 
145a : 85 18 __ STA P11 ; (f + 3)
145c : 18 __ __ CLC
145d : a5 49 __ LDA T4 + 0 
145f : 69 ff __ ADC #$ff
1461 : 85 47 __ STA T2 + 0 
1463 : a6 1b __ LDX ACCU + 0 
.s31:
1465 : 38 __ __ SEC
1466 : a5 4c __ LDA T8 + 0 
1468 : e5 47 __ SBC T2 + 0 
146a : 85 49 __ STA T4 + 0 
146c : a9 14 __ LDA #$14
146e : c5 4c __ CMP T8 + 0 
1470 : b0 02 __ BCS $1474 ; (nformf.s49 + 0)
.s47:
1472 : 85 4c __ STA T8 + 0 
.s49:
1474 : a5 49 __ LDA T4 + 0 
1476 : d0 08 __ BNE $1480 ; (nformf.s219 + 0)
.s50:
1478 : a9 30 __ LDA #$30
147a : a4 48 __ LDY T3 + 0 
147c : 91 13 __ STA (P6),y ; (str + 0)
147e : e6 48 __ INC T3 + 0 
.s219:
1480 : a9 00 __ LDA #$00
1482 : 85 47 __ STA T2 + 0 
1484 : c5 49 __ CMP T4 + 0 
1486 : d0 08 __ BNE $1490 ; (nformf.l59 + 0)
.l57:
1488 : a9 2e __ LDA #$2e
148a : a4 48 __ LDY T3 + 0 
148c : 91 13 __ STA (P6),y ; (str + 0)
148e : e6 48 __ INC T3 + 0 
.l59:
1490 : a5 47 __ LDA T2 + 0 
1492 : c9 07 __ CMP #$07
1494 : 90 04 __ BCC $149a ; (nformf.s61 + 0)
.s60:
1496 : a9 30 __ LDA #$30
1498 : d0 55 __ BNE $14ef ; (nformf.s208 + 0)
.s61:
149a : 86 1b __ STX ACCU + 0 
149c : 86 43 __ STX T1 + 0 
149e : a5 16 __ LDA P9 ; (f + 1)
14a0 : 85 1c __ STA ACCU + 1 
14a2 : 85 44 __ STA T1 + 1 
14a4 : a5 17 __ LDA P10 ; (f + 2)
14a6 : 85 1d __ STA ACCU + 2 
14a8 : 85 45 __ STA T1 + 2 
14aa : a5 18 __ LDA P11 ; (f + 3)
14ac : 85 1e __ STA ACCU + 3 
14ae : 85 46 __ STA T1 + 3 
14b0 : 20 d2 21 JSR $21d2 ; (f32_to_i16 + 0)
14b3 : a5 1b __ LDA ACCU + 0 
14b5 : 85 4f __ STA T11 + 0 
14b7 : 20 14 22 JSR $2214 ; (sint16_to_float + 0)
14ba : a2 43 __ LDX #$43
14bc : 20 45 1e JSR $1e45 ; (freg + 4)
14bf : a5 1e __ LDA ACCU + 3 
14c1 : 49 80 __ EOR #$80
14c3 : 85 1e __ STA ACCU + 3 
14c5 : 20 86 1e JSR $1e86 ; (faddsub + 0)
14c8 : a9 00 __ LDA #$00
14ca : 85 03 __ STA WORK + 0 
14cc : 85 04 __ STA WORK + 1 
14ce : a9 20 __ LDA #$20
14d0 : 85 05 __ STA WORK + 2 
14d2 : a9 41 __ LDA #$41
14d4 : 85 06 __ STA WORK + 3 
14d6 : 20 55 1e JSR $1e55 ; (freg + 20)
14d9 : 20 6d 1f JSR $1f6d ; (fmul + 0)
14dc : a5 1c __ LDA ACCU + 1 
14de : 85 16 __ STA P9 ; (f + 1)
14e0 : a5 1d __ LDA ACCU + 2 
14e2 : 85 17 __ STA P10 ; (f + 2)
14e4 : a5 1e __ LDA ACCU + 3 
14e6 : 85 18 __ STA P11 ; (f + 3)
14e8 : 18 __ __ CLC
14e9 : a5 4f __ LDA T11 + 0 
14eb : 69 30 __ ADC #$30
14ed : a6 1b __ LDX ACCU + 0 
.s208:
14ef : a4 48 __ LDY T3 + 0 
14f1 : 91 13 __ STA (P6),y ; (str + 0)
14f3 : e6 48 __ INC T3 + 0 
14f5 : e6 47 __ INC T2 + 0 
14f7 : a5 47 __ LDA T2 + 0 
14f9 : c5 4c __ CMP T8 + 0 
14fb : b0 07 __ BCS $1504 ; (nformf.s56 + 0)
.s54:
14fd : c5 49 __ CMP T4 + 0 
14ff : d0 8f __ BNE $1490 ; (nformf.l59 + 0)
1501 : 4c 88 14 JMP $1488 ; (nformf.l57 + 0)
.s56:
1504 : a5 4e __ LDA T9 + 0 
1506 : f0 62 __ BEQ $156a ; (nformf.s9 + 0)
.s63:
1508 : a9 45 __ LDA #$45
150a : a4 48 __ LDY T3 + 0 
150c : 91 13 __ STA (P6),y ; (str + 0)
150e : c8 __ __ INY
150f : a5 4b __ LDA T5 + 1 
1511 : 30 06 __ BMI $1519 ; (nformf.s66 + 0)
.s67:
1513 : a9 2b __ LDA #$2b
1515 : 91 13 __ STA (P6),y ; (str + 0)
1517 : d0 11 __ BNE $152a ; (nformf.s68 + 0)
.s66:
1519 : a9 2d __ LDA #$2d
151b : 91 13 __ STA (P6),y ; (str + 0)
151d : 38 __ __ SEC
151e : a9 00 __ LDA #$00
1520 : e5 4a __ SBC T5 + 0 
1522 : 85 4a __ STA T5 + 0 
1524 : a9 00 __ LDA #$00
1526 : e5 4b __ SBC T5 + 1 
1528 : 85 4b __ STA T5 + 1 
.s68:
152a : a5 4a __ LDA T5 + 0 
152c : 85 1b __ STA ACCU + 0 
152e : a5 4b __ LDA T5 + 1 
1530 : 85 1c __ STA ACCU + 1 
1532 : a9 0a __ LDA #$0a
1534 : 85 03 __ STA WORK + 0 
1536 : a9 00 __ LDA #$00
1538 : 85 04 __ STA WORK + 1 
153a : 20 ea 20 JSR $20ea ; (divs16 + 0)
153d : 18 __ __ CLC
153e : a5 1b __ LDA ACCU + 0 
1540 : 69 30 __ ADC #$30
1542 : a4 48 __ LDY T3 + 0 
1544 : c8 __ __ INY
1545 : c8 __ __ INY
1546 : 91 13 __ STA (P6),y ; (str + 0)
1548 : a5 4a __ LDA T5 + 0 
154a : 85 1b __ STA ACCU + 0 
154c : a5 4b __ LDA T5 + 1 
154e : 85 1c __ STA ACCU + 1 
1550 : a9 0a __ LDA #$0a
1552 : 85 03 __ STA WORK + 0 
1554 : a9 00 __ LDA #$00
1556 : 85 04 __ STA WORK + 1 
1558 : 20 a9 21 JSR $21a9 ; (mods16 + 0)
155b : 18 __ __ CLC
155c : a5 05 __ LDA WORK + 2 
155e : 69 30 __ ADC #$30
1560 : a4 48 __ LDY T3 + 0 
1562 : c8 __ __ INY
1563 : c8 __ __ INY
1564 : c8 __ __ INY
1565 : 91 13 __ STA (P6),y ; (str + 0)
1567 : c8 __ __ INY
1568 : 84 48 __ STY T3 + 0 
.s9:
156a : a5 11 __ LDA P4 ; (si + 0)
156c : 85 4a __ STA T5 + 0 
156e : a5 12 __ LDA P5 ; (si + 1)
1570 : 85 4b __ STA T5 + 1 
1572 : a5 48 __ LDA T3 + 0 
1574 : a0 01 __ LDY #$01
1576 : d1 11 __ CMP (P4),y ; (si + 0)
1578 : b0 5d __ BCS $15d7 ; (nformf.s1001 + 0)
.s69:
157a : a0 06 __ LDY #$06
157c : b1 11 __ LDA (P4),y ; (si + 0)
157e : f0 06 __ BEQ $1586 ; (nformf.s73 + 0)
.s72:
1580 : a5 48 __ LDA T3 + 0 
1582 : aa __ __ TAX
1583 : 4c de 15 JMP $15de ; (nformf.l75 + 0)
.s73:
1586 : a5 48 __ LDA T3 + 0 
1588 : f0 2d __ BEQ $15b7 ; (nformf.s82 + 0)
.s90:
158a : a9 01 __ LDA #$01
158c : 85 47 __ STA T2 + 0 
158e : a6 48 __ LDX T3 + 0 
1590 : 38 __ __ SEC
.l1083:
1591 : a0 01 __ LDY #$01
1593 : b1 11 __ LDA (P4),y ; (si + 0)
1595 : e5 47 __ SBC T2 + 0 
1597 : 85 4c __ STA T8 + 0 
1599 : a9 ff __ LDA #$ff
159b : 65 14 __ ADC P7 ; (str + 1)
159d : 85 4d __ STA T8 + 1 
159f : 8a __ __ TXA
15a0 : 38 __ __ SEC
15a1 : e5 47 __ SBC T2 + 0 
15a3 : 85 1b __ STA ACCU + 0 
15a5 : a9 ff __ LDA #$ff
15a7 : 65 14 __ ADC P7 ; (str + 1)
15a9 : 85 1c __ STA ACCU + 1 
15ab : a4 13 __ LDY P6 ; (str + 0)
15ad : b1 1b __ LDA (ACCU + 0),y 
15af : 91 4c __ STA (T8 + 0),y 
15b1 : e6 47 __ INC T2 + 0 
15b3 : e4 47 __ CPX T2 + 0 
15b5 : b0 da __ BCS $1591 ; (nformf.l1083 + 0)
.s82:
15b7 : a9 00 __ LDA #$00
15b9 : 85 47 __ STA T2 + 0 
.l83:
15bb : a0 01 __ LDY #$01
15bd : b1 4a __ LDA (T5 + 0),y 
15bf : 38 __ __ SEC
15c0 : e5 48 __ SBC T3 + 0 
15c2 : 90 06 __ BCC $15ca ; (nformf.s84 + 0)
.s1011:
15c4 : c5 47 __ CMP T2 + 0 
15c6 : 90 0d __ BCC $15d5 ; (nformf.s74 + 0)
.s1087:
15c8 : f0 0b __ BEQ $15d5 ; (nformf.s74 + 0)
.s84:
15ca : a9 20 __ LDA #$20
15cc : a4 47 __ LDY T2 + 0 
15ce : 91 13 __ STA (P6),y ; (str + 0)
15d0 : e6 47 __ INC T2 + 0 
15d2 : 4c bb 15 JMP $15bb ; (nformf.l83 + 0)
.s74:
15d5 : b1 11 __ LDA (P4),y ; (si + 0)
.s1001:
15d7 : 85 1b __ STA ACCU + 0 
15d9 : a9 00 __ LDA #$00
15db : 85 1c __ STA ACCU + 1 
15dd : 60 __ __ RTS
.l75:
15de : a0 01 __ LDY #$01
15e0 : d1 4a __ CMP (T5 + 0),y 
15e2 : b0 f1 __ BCS $15d5 ; (nformf.s74 + 0)
.s76:
15e4 : a8 __ __ TAY
15e5 : a9 20 __ LDA #$20
15e7 : 91 13 __ STA (P6),y ; (str + 0)
15e9 : e8 __ __ INX
15ea : 8a __ __ TXA
15eb : 4c de 15 JMP $15de ; (nformf.l75 + 0)
.s30:
15ee : a5 4c __ LDA T8 + 0 
15f0 : c9 07 __ CMP #$07
15f2 : 90 13 __ BCC $1607 ; (nformf.s41 + 0)
.s42:
15f4 : ad 49 23 LDA $2349 ; (fround5 + 25)
15f7 : 85 1c __ STA ACCU + 1 
15f9 : ad 4a 23 LDA $234a ; (fround5 + 26)
15fc : 85 1d __ STA ACCU + 2 
15fe : ad 4b 23 LDA $234b ; (fround5 + 27)
1601 : ae 48 23 LDX $2348 ; (fround5 + 24)
1604 : 4c 1a 16 JMP $161a ; (nformf.s204 + 0)
.s41:
1607 : 0a __ __ ASL
1608 : 0a __ __ ASL
1609 : a8 __ __ TAY
160a : b9 2d 23 LDA $232d,y ; (ChrRedef + 45)
160d : 85 1c __ STA ACCU + 1 
160f : b9 2e 23 LDA $232e,y ; (ChrRedef + 46)
1612 : 85 1d __ STA ACCU + 2 
1614 : b9 2f 23 LDA $232f,y ; (ChrRedef + 47)
1617 : be 2c 23 LDX $232c,y ; (ChrRedef + 44)
.s204:
161a : 86 1b __ STX ACCU + 0 
161c : 85 1e __ STA ACCU + 3 
161e : a2 43 __ LDX #$43
1620 : 20 45 1e JSR $1e45 ; (freg + 4)
1623 : 20 86 1e JSR $1e86 ; (faddsub + 0)
1626 : a5 1c __ LDA ACCU + 1 
1628 : 85 16 __ STA P9 ; (f + 1)
162a : a5 1d __ LDA ACCU + 2 
162c : 85 17 __ STA P10 ; (f + 2)
162e : a6 1b __ LDX ACCU + 0 
1630 : a5 1e __ LDA ACCU + 3 
1632 : 85 18 __ STA P11 ; (f + 3)
1634 : 10 03 __ BPL $1639 ; (nformf.s1042 + 0)
1636 : 4c 65 14 JMP $1465 ; (nformf.s31 + 0)
.s1042:
1639 : c9 41 __ CMP #$41
163b : d0 06 __ BNE $1643 ; (nformf.s1046 + 0)
.s1043:
163d : a5 17 __ LDA P10 ; (f + 2)
163f : c9 20 __ CMP #$20
1641 : f0 05 __ BEQ $1648 ; (nformf.s44 + 0)
.s1046:
1643 : b0 03 __ BCS $1648 ; (nformf.s44 + 0)
1645 : 4c 65 14 JMP $1465 ; (nformf.s31 + 0)
.s44:
1648 : a9 00 __ LDA #$00
164a : 85 03 __ STA WORK + 0 
164c : 85 04 __ STA WORK + 1 
164e : a9 20 __ LDA #$20
1650 : 85 05 __ STA WORK + 2 
1652 : a9 41 __ LDA #$41
1654 : 85 06 __ STA WORK + 3 
1656 : 20 55 1e JSR $1e55 ; (freg + 20)
1659 : 20 3c 20 JSR $203c ; (fdiv + 0)
165c : a5 1c __ LDA ACCU + 1 
165e : 85 16 __ STA P9 ; (f + 1)
1660 : a5 1d __ LDA ACCU + 2 
1662 : 85 17 __ STA P10 ; (f + 2)
1664 : a5 1e __ LDA ACCU + 3 
1666 : 85 18 __ STA P11 ; (f + 3)
1668 : a6 1b __ LDX ACCU + 0 
166a : e6 4a __ INC T5 + 0 
166c : f0 03 __ BEQ $1671 ; (nformf.s1092 + 0)
166e : 4c 65 14 JMP $1465 ; (nformf.s31 + 0)
.s1092:
1671 : e6 4b __ INC T5 + 1 
1673 : 4c 65 14 JMP $1465 ; (nformf.s31 + 0)
.s13:
1676 : a5 18 __ LDA P11 ; (f + 3)
1678 : 30 59 __ BMI $16d3 ; (nformf.l17 + 0)
.l1072:
167a : c9 44 __ CMP #$44
167c : f0 03 __ BEQ $1681 ; (nformf.s1073 + 0)
167e : 4c 70 17 JMP $1770 ; (nformf.s1076 + 0)
.s1073:
1681 : a5 45 __ LDA T1 + 2 
1683 : c9 7a __ CMP #$7a
1685 : f0 03 __ BEQ $168a ; (nformf.s1074 + 0)
1687 : 4c 70 17 JMP $1770 ; (nformf.s1076 + 0)
.s1074:
168a : a5 44 __ LDA T1 + 1 
168c : d0 04 __ BNE $1692 ; (nformf.s1082 + 0)
.s1075:
168e : a5 43 __ LDA T1 + 0 
1690 : f0 02 __ BEQ $1694 ; (nformf.s14 + 0)
.s1082:
1692 : a5 43 __ LDA T1 + 0 
.s14:
1694 : 85 1b __ STA ACCU + 0 
1696 : a5 44 __ LDA T1 + 1 
1698 : 85 1c __ STA ACCU + 1 
169a : a5 45 __ LDA T1 + 2 
169c : 85 1d __ STA ACCU + 2 
169e : a5 46 __ LDA T1 + 3 
16a0 : 85 1e __ STA ACCU + 3 
16a2 : a9 00 __ LDA #$00
16a4 : 85 03 __ STA WORK + 0 
16a6 : 85 04 __ STA WORK + 1 
16a8 : a9 7a __ LDA #$7a
16aa : 85 05 __ STA WORK + 2 
16ac : a9 44 __ LDA #$44
16ae : 85 06 __ STA WORK + 3 
16b0 : 20 55 1e JSR $1e55 ; (freg + 20)
16b3 : 20 3c 20 JSR $203c ; (fdiv + 0)
16b6 : a5 1b __ LDA ACCU + 0 
16b8 : 85 43 __ STA T1 + 0 
16ba : a5 1c __ LDA ACCU + 1 
16bc : 85 44 __ STA T1 + 1 
16be : a5 1d __ LDA ACCU + 2 
16c0 : 85 45 __ STA T1 + 2 
16c2 : 18 __ __ CLC
16c3 : a5 4a __ LDA T5 + 0 
16c5 : 69 03 __ ADC #$03
16c7 : 85 4a __ STA T5 + 0 
16c9 : 90 02 __ BCC $16cd ; (nformf.s1097 + 0)
.s1096:
16cb : e6 4b __ INC T5 + 1 
.s1097:
16cd : a5 1e __ LDA ACCU + 3 
16cf : 85 46 __ STA T1 + 3 
16d1 : 10 a7 __ BPL $167a ; (nformf.l1072 + 0)
.l17:
16d3 : a9 00 __ LDA #$00
16d5 : 85 1b __ STA ACCU + 0 
16d7 : 85 1c __ STA ACCU + 1 
16d9 : a9 7a __ LDA #$7a
16db : 85 1d __ STA ACCU + 2 
16dd : a9 44 __ LDA #$44
16df : 85 1e __ STA ACCU + 3 
16e1 : a2 43 __ LDX #$43
16e3 : 20 45 1e JSR $1e45 ; (freg + 4)
16e6 : 20 6d 1f JSR $1f6d ; (fmul + 0)
16e9 : a5 1b __ LDA ACCU + 0 
16eb : 85 43 __ STA T1 + 0 
16ed : a5 1c __ LDA ACCU + 1 
16ef : 85 44 __ STA T1 + 1 
16f1 : a5 1d __ LDA ACCU + 2 
16f3 : 85 45 __ STA T1 + 2 
16f5 : a5 1e __ LDA ACCU + 3 
16f7 : 85 46 __ STA T1 + 3 
16f9 : 38 __ __ SEC
16fa : a5 4a __ LDA T5 + 0 
16fc : e9 03 __ SBC #$03
16fe : 85 4a __ STA T5 + 0 
1700 : b0 02 __ BCS $1704 ; (nformf.s16 + 0)
.s1088:
1702 : c6 4b __ DEC T5 + 1 
.s16:
1704 : a5 46 __ LDA T1 + 3 
1706 : 30 cb __ BMI $16d3 ; (nformf.l17 + 0)
.s1064:
1708 : c9 3f __ CMP #$3f
170a : d0 06 __ BNE $1712 ; (nformf.s1068 + 0)
.s1065:
170c : a5 45 __ LDA T1 + 2 
170e : c9 80 __ CMP #$80
1710 : f0 02 __ BEQ $1714 ; (nformf.s19 + 0)
.s1068:
1712 : 90 bf __ BCC $16d3 ; (nformf.l17 + 0)
.s19:
1714 : a5 46 __ LDA T1 + 3 
1716 : c9 41 __ CMP #$41
1718 : d0 51 __ BNE $176b ; (nformf.l1060 + 0)
.s1057:
171a : a5 45 __ LDA T1 + 2 
171c : c9 20 __ CMP #$20
171e : d0 4b __ BNE $176b ; (nformf.l1060 + 0)
.s1058:
1720 : a5 44 __ LDA T1 + 1 
1722 : d0 04 __ BNE $1728 ; (nformf.l1081 + 0)
.s1059:
1724 : a5 43 __ LDA T1 + 0 
1726 : f0 02 __ BEQ $172a ; (nformf.l20 + 0)
.l1081:
1728 : a5 43 __ LDA T1 + 0 
.l20:
172a : 85 1b __ STA ACCU + 0 
172c : a5 44 __ LDA T1 + 1 
172e : 85 1c __ STA ACCU + 1 
1730 : a5 45 __ LDA T1 + 2 
1732 : 85 1d __ STA ACCU + 2 
1734 : a5 46 __ LDA T1 + 3 
1736 : 85 1e __ STA ACCU + 3 
1738 : a9 00 __ LDA #$00
173a : 85 03 __ STA WORK + 0 
173c : 85 04 __ STA WORK + 1 
173e : a9 20 __ LDA #$20
1740 : 85 05 __ STA WORK + 2 
1742 : a9 41 __ LDA #$41
1744 : 85 06 __ STA WORK + 3 
1746 : 20 55 1e JSR $1e55 ; (freg + 20)
1749 : 20 3c 20 JSR $203c ; (fdiv + 0)
174c : a5 1b __ LDA ACCU + 0 
174e : 85 43 __ STA T1 + 0 
1750 : a5 1c __ LDA ACCU + 1 
1752 : 85 44 __ STA T1 + 1 
1754 : a5 1d __ LDA ACCU + 2 
1756 : 85 45 __ STA T1 + 2 
1758 : e6 4a __ INC T5 + 0 
175a : d0 02 __ BNE $175e ; (nformf.s1091 + 0)
.s1090:
175c : e6 4b __ INC T5 + 1 
.s1091:
175e : a5 1e __ LDA ACCU + 3 
1760 : 85 46 __ STA T1 + 3 
1762 : 10 03 __ BPL $1767 ; (nformf.s1056 + 0)
1764 : 4c 69 13 JMP $1369 ; (nformf.s12 + 0)
.s1056:
1767 : c9 41 __ CMP #$41
1769 : f0 af __ BEQ $171a ; (nformf.s1057 + 0)
.l1060:
176b : b0 bb __ BCS $1728 ; (nformf.l1081 + 0)
176d : 4c 69 13 JMP $1369 ; (nformf.s12 + 0)
.s1076:
1770 : 90 92 __ BCC $1704 ; (nformf.s16 + 0)
1772 : 4c 92 16 JMP $1692 ; (nformf.s1082 + 0)
.s7:
1775 : 85 1b __ STA ACCU + 0 
1777 : a9 49 __ LDA #$49
1779 : 91 13 __ STA (P6),y ; (str + 0)
177b : a9 4e __ LDA #$4e
177d : a4 4a __ LDY T5 + 0 
177f : 91 13 __ STA (P6),y ; (str + 0)
1781 : a9 46 __ LDA #$46
1783 : a4 1b __ LDY ACCU + 0 
1785 : 91 13 __ STA (P6),y ; (str + 0)
1787 : 18 __ __ CLC
1788 : a5 48 __ LDA T3 + 0 
178a : 69 03 __ ADC #$03
178c : 85 48 __ STA T3 + 0 
178e : 4c 6a 15 JMP $156a ; (nformf.s9 + 0)
.s189:
1791 : 20 a9 17 JSR $17a9 ; (isinf.s0 + 0)
1794 : aa __ __ TAX
1795 : a9 01 __ LDA #$01
1797 : 85 48 __ STA T3 + 0 
1799 : 8a __ __ TXA
179a : d0 03 __ BNE $179f ; (nformf.s158 + 0)
179c : 4c 46 13 JMP $1346 ; (nformf.s8 + 0)
.s158:
179f : a9 02 __ LDA #$02
17a1 : 85 4a __ STA T5 + 0 
17a3 : a9 03 __ LDA #$03
17a5 : a0 01 __ LDY #$01
17a7 : d0 cc __ BNE $1775 ; (nformf.s7 + 0)
--------------------------------------------------------------------
isinf:
.s0:
17a9 : 06 0f __ ASL P2 ; (f + 2)
17ab : a5 10 __ LDA P3 ; (f + 3)
17ad : 2a __ __ ROL
17ae : c9 ff __ CMP #$ff
17b0 : d0 03 __ BNE $17b5 ; (isinf.s1003 + 0)
.s1002:
17b2 : a9 01 __ LDA #$01
17b4 : 60 __ __ RTS
.s1003:
17b5 : a9 00 __ LDA #$00
.s1001:
17b7 : 60 __ __ RTS
--------------------------------------------------------------------
fround5:
2330 : __ __ __ BYT 00 00 00 3f cd cc 4c 3d 0a d7 a3 3b 6f 12 03 3a : ...?..L=...;o..:
2340 : __ __ __ BYT 17 b7 51 38 ac c5 a7 36 bd 37 06 35             : ..Q8...6.7.5
--------------------------------------------------------------------
17b8 : __ __ __ BYT 1e 53 43 4f 52 45 3a 20 25 64 00                : .SCORE: %d.
--------------------------------------------------------------------
spawn_enemy:
.s0:
17c3 : 20 1b 18 JSR $181b ; (rand.s0 + 0)
17c6 : 46 1b __ LSR ACCU + 0 
17c8 : b0 13 __ BCS $17dd ; (spawn_enemy.s1001 + 0)
.s3:
17ca : a9 00 __ LDA #$00
17cc : a8 __ __ TAY
.l6:
17cd : 0a __ __ ASL
17ce : 0a __ __ ASL
17cf : 85 43 __ STA T0 + 0 
17d1 : aa __ __ TAX
17d2 : bd 4f 23 LDA $234f,x ; (Enemy + 3)
17d5 : f0 07 __ BEQ $17de ; (spawn_enemy.s9 + 0)
.s7:
17d7 : c8 __ __ INY
17d8 : 98 __ __ TYA
17d9 : c0 0a __ CPY #$0a
17db : 90 f0 __ BCC $17cd ; (spawn_enemy.l6 + 0)
.s1001:
17dd : 60 __ __ RTS
.s9:
17de : a9 27 __ LDA #$27
17e0 : 9d 4c 23 STA $234c,x ; (Enemy + 0)
17e3 : 20 1b 18 JSR $181b ; (rand.s0 + 0)
17e6 : a9 16 __ LDA #$16
17e8 : 85 03 __ STA WORK + 0 
17ea : a9 00 __ LDA #$00
17ec : 85 04 __ STA WORK + 1 
17ee : 20 24 21 JSR $2124 ; (divmod + 0)
17f1 : 18 __ __ CLC
17f2 : a5 05 __ LDA WORK + 2 
17f4 : 69 03 __ ADC #$03
17f6 : a6 43 __ LDX T0 + 0 
17f8 : 9d 4d 23 STA $234d,x ; (Enemy + 1)
17fb : 20 1b 18 JSR $181b ; (rand.s0 + 0)
17fe : a9 01 __ LDA #$01
1800 : a6 43 __ LDX T0 + 0 
1802 : 9d 4f 23 STA $234f,x ; (Enemy + 3)
1805 : a9 03 __ LDA #$03
1807 : 85 03 __ STA WORK + 0 
1809 : a9 00 __ LDA #$00
180b : 85 04 __ STA WORK + 1 
180d : 20 24 21 JSR $2124 ; (divmod + 0)
1810 : 18 __ __ CLC
1811 : a5 05 __ LDA WORK + 2 
1813 : 69 83 __ ADC #$83
1815 : a6 43 __ LDX T0 + 0 
1817 : 9d 4e 23 STA $234e,x ; (Enemy + 2)
181a : 60 __ __ RTS
--------------------------------------------------------------------
rand:
.s0:
181b : ad fb 22 LDA $22fb ; (seed + 1)
181e : 4a __ __ LSR
181f : ad fa 22 LDA $22fa ; (seed + 0)
1822 : 6a __ __ ROR
1823 : aa __ __ TAX
1824 : a9 00 __ LDA #$00
1826 : 6a __ __ ROR
1827 : 4d fa 22 EOR $22fa ; (seed + 0)
182a : 85 1b __ STA ACCU + 0 
182c : 8a __ __ TXA
182d : 4d fb 22 EOR $22fb ; (seed + 1)
1830 : 85 1c __ STA ACCU + 1 
1832 : 4a __ __ LSR
1833 : 45 1b __ EOR ACCU + 0 
1835 : 8d fa 22 STA $22fa ; (seed + 0)
1838 : 85 1b __ STA ACCU + 0 
183a : 45 1c __ EOR ACCU + 1 
183c : 8d fb 22 STA $22fb ; (seed + 1)
183f : 85 1c __ STA ACCU + 1 
.s1001:
1841 : 60 __ __ RTS
--------------------------------------------------------------------
seed:
22fa : __ __ __ BYT 00 7a                                           : .z
--------------------------------------------------------------------
move_enemies:
.s1000:
1842 : a2 03 __ LDX #$03
1844 : b5 53 __ LDA T0 + 0,x 
1846 : 9d 9f 9f STA $9f9f,x ; (move_enemies@stack + 0)
1849 : ca __ __ DEX
184a : 10 f8 __ BPL $1844 ; (move_enemies.s1000 + 2)
.s0:
184c : a9 00 __ LDA #$00
184e : 85 53 __ STA T0 + 0 
.l2:
1850 : 0a __ __ ASL
1851 : 0a __ __ ASL
1852 : 85 54 __ STA T1 + 0 
1854 : a8 __ __ TAY
1855 : b9 4f 23 LDA $234f,y ; (Enemy + 3)
1858 : c9 01 __ CMP #$01
185a : d0 6e __ BNE $18ca ; (move_enemies.s35 + 0)
.s5:
185c : 18 __ __ CLC
185d : a9 4c __ LDA #$4c
185f : 65 54 __ ADC T1 + 0 
1861 : 85 54 __ STA T1 + 0 
1863 : a9 23 __ LDA #$23
1865 : 69 00 __ ADC #$00
1867 : 85 55 __ STA T1 + 1 
1869 : b9 4d 23 LDA $234d,y ; (Enemy + 1)
186c : cd fd 22 CMP $22fd ; (Player + 1)
186f : d0 10 __ BNE $1881 ; (move_enemies.s10 + 0)
.s8:
1871 : a5 54 __ LDA T1 + 0 
1873 : 8d fe 9f STA $9ffe ; (sstack + 8)
1876 : a5 55 __ LDA T1 + 1 
1878 : 8d ff 9f STA $9fff ; (sstack + 9)
187b : 20 3a 19 JSR $193a ; (spawn_enemy_shot.s1000 + 0)
187e : 20 ea 19 JSR $19ea ; (render_enemy_shots.s0 + 0)
.s10:
1881 : a0 00 __ LDY #$00
1883 : b1 54 __ LDA (T1 + 0),y 
1885 : 85 56 __ STA T3 + 0 
1887 : c8 __ __ INY
1888 : b1 54 __ LDA (T1 + 0),y 
188a : 0a __ __ ASL
188b : 85 1b __ STA ACCU + 0 
188d : a9 00 __ LDA #$00
188f : 2a __ __ ROL
1890 : 06 1b __ ASL ACCU + 0 
1892 : 2a __ __ ROL
1893 : aa __ __ TAX
1894 : a5 1b __ LDA ACCU + 0 
1896 : 71 54 __ ADC (T1 + 0),y 
1898 : 85 46 __ STA T5 + 0 
189a : 8a __ __ TXA
189b : 69 00 __ ADC #$00
189d : 06 46 __ ASL T5 + 0 
189f : 2a __ __ ROL
18a0 : 06 46 __ ASL T5 + 0 
18a2 : 2a __ __ ROL
18a3 : 06 46 __ ASL T5 + 0 
18a5 : 2a __ __ ROL
18a6 : aa __ __ TAX
18a7 : 18 __ __ CLC
18a8 : a5 46 __ LDA T5 + 0 
18aa : 65 56 __ ADC T3 + 0 
18ac : 85 43 __ STA T2 + 0 
18ae : 85 1f __ STA ADDR + 0 
18b0 : 8a __ __ TXA
18b1 : 69 c0 __ ADC #$c0
18b3 : 85 44 __ STA T2 + 1 
18b5 : 18 __ __ CLC
18b6 : 69 18 __ ADC #$18
18b8 : 85 20 __ STA ADDR + 1 
18ba : a9 20 __ LDA #$20
18bc : 88 __ __ DEY
18bd : 91 43 __ STA (T2 + 0),y 
18bf : 98 __ __ TYA
18c0 : 91 1f __ STA (ADDR + 0),y 
18c2 : a5 56 __ LDA T3 + 0 
18c4 : d0 1a __ BNE $18e0 ; (move_enemies.s11 + 0)
.s12:
18c6 : a0 03 __ LDY #$03
.s1016:
18c8 : 91 54 __ STA (T1 + 0),y 
.s35:
18ca : e6 53 __ INC T0 + 0 
18cc : a5 53 __ LDA T0 + 0 
18ce : c9 0a __ CMP #$0a
18d0 : b0 03 __ BCS $18d5 ; (move_enemies.s1001 + 0)
18d2 : 4c 50 18 JMP $1850 ; (move_enemies.l2 + 0)
.s1001:
18d5 : a2 03 __ LDX #$03
18d7 : bd 9f 9f LDA $9f9f,x ; (move_enemies@stack + 0)
18da : 95 53 __ STA T0 + 0,x 
18dc : ca __ __ DEX
18dd : 10 f8 __ BPL $18d7 ; (move_enemies.s1001 + 2)
18df : 60 __ __ RTS
.s11:
18e0 : c6 56 __ DEC T3 + 0 
18e2 : a5 56 __ LDA T3 + 0 
18e4 : 91 54 __ STA (T1 + 0),y 
18e6 : 20 1b 18 JSR $181b ; (rand.s0 + 0)
18e9 : a0 01 __ LDY #$01
18eb : b1 54 __ LDA (T1 + 0),y 
18ed : 85 45 __ STA T4 + 0 
18ef : a9 03 __ LDA #$03
18f1 : 85 03 __ STA WORK + 0 
18f3 : a9 00 __ LDA #$00
18f5 : 85 04 __ STA WORK + 1 
18f7 : 20 24 21 JSR $2124 ; (divmod + 0)
18fa : 38 __ __ SEC
18fb : a5 05 __ LDA WORK + 2 
18fd : e9 01 __ SBC #$01
18ff : aa __ __ TAX
1900 : a5 06 __ LDA WORK + 3 
1902 : e9 00 __ SBC #$00
1904 : a8 __ __ TAY
1905 : 8a __ __ TXA
1906 : 18 __ __ CLC
1907 : 65 45 __ ADC T4 + 0 
1909 : 85 43 __ STA T2 + 0 
190b : 90 01 __ BCC $190e ; (move_enemies.s1018 + 0)
.s1017:
190d : c8 __ __ INY
.s1018:
190e : 0a __ __ ASL
190f : 0a __ __ ASL
1910 : 18 __ __ CLC
1911 : 65 43 __ ADC T2 + 0 
1913 : 0a __ __ ASL
1914 : 0a __ __ ASL
1915 : 0a __ __ ASL
1916 : 18 __ __ CLC
1917 : 65 56 __ ADC T3 + 0 
1919 : aa __ __ TAX
191a : bd 00 c0 LDA $c000,x 
191d : c9 83 __ CMP #$83
191f : f0 a9 __ BEQ $18ca ; (move_enemies.s35 + 0)
.s20:
1921 : c9 84 __ CMP #$84
1923 : f0 a5 __ BEQ $18ca ; (move_enemies.s35 + 0)
.s19:
1925 : c9 85 __ CMP #$85
1927 : f0 a1 __ BEQ $18ca ; (move_enemies.s35 + 0)
.s18:
1929 : 98 __ __ TYA
192a : d0 9e __ BNE $18ca ; (move_enemies.s35 + 0)
.s1005:
192c : a5 43 __ LDA T2 + 0 
192e : c9 03 __ CMP #$03
1930 : 90 98 __ BCC $18ca ; (move_enemies.s35 + 0)
.s1004:
1932 : c9 19 __ CMP #$19
1934 : b0 94 __ BCS $18ca ; (move_enemies.s35 + 0)
.s14:
1936 : a0 01 __ LDY #$01
1938 : d0 8e __ BNE $18c8 ; (move_enemies.s1016 + 0)
--------------------------------------------------------------------
spawn_enemy_shot:
.s1000:
193a : a5 53 __ LDA T1 + 0 
193c : 8d a3 9f STA $9fa3 ; (spawn_enemy_shot@stack + 0)
193f : a5 54 __ LDA T3 + 0 
1941 : 8d a4 9f STA $9fa4 ; (spawn_enemy_shot@stack + 1)
1944 : 38 __ __ SEC
1945 : a5 23 __ LDA SP + 0 
1947 : e9 08 __ SBC #$08
1949 : 85 23 __ STA SP + 0 
194b : b0 02 __ BCS $194f ; (spawn_enemy_shot.s0 + 0)
194d : c6 24 __ DEC SP + 1 
.s0:
194f : ad fe 9f LDA $9ffe ; (sstack + 8)
1952 : 85 43 __ STA T0 + 0 
1954 : ad ff 9f LDA $9fff ; (sstack + 9)
1957 : 85 44 __ STA T0 + 1 
1959 : a0 00 __ LDY #$00
195b : b1 43 __ LDA (T0 + 0),y 
195d : f0 0f __ BEQ $196e ; (spawn_enemy_shot.s1001 + 0)
.s3:
195f : a2 00 __ LDX #$00
.l6:
1961 : bc f5 22 LDY $22f5,x ; (__multab3L + 0)
1964 : b9 7f 23 LDA $237f,y ; (EnemyShot + 2)
1967 : f0 1b __ BEQ $1984 ; (spawn_enemy_shot.s9 + 0)
.s7:
1969 : e8 __ __ INX
196a : e0 03 __ CPX #$03
196c : 90 f3 __ BCC $1961 ; (spawn_enemy_shot.l6 + 0)
.s1001:
196e : 18 __ __ CLC
196f : a5 23 __ LDA SP + 0 
1971 : 69 08 __ ADC #$08
1973 : 85 23 __ STA SP + 0 
1975 : 90 02 __ BCC $1979 ; (spawn_enemy_shot.s1001 + 11)
1977 : e6 24 __ INC SP + 1 
1979 : ad a3 9f LDA $9fa3 ; (spawn_enemy_shot@stack + 0)
197c : 85 53 __ STA T1 + 0 
197e : ad a4 9f LDA $9fa4 ; (spawn_enemy_shot@stack + 1)
1981 : 85 54 __ STA T3 + 0 
1983 : 60 __ __ RTS
.s9:
1984 : a9 14 __ LDA #$14
1986 : 85 0d __ STA P0 
1988 : a9 00 __ LDA #$00
198a : 85 0e __ STA P1 
198c : 85 10 __ STA P3 
198e : a9 01 __ LDA #$01
1990 : 85 0f __ STA P2 
1992 : 99 7f 23 STA $237f,y ; (EnemyShot + 2)
1995 : ad fe 9f LDA $9ffe ; (sstack + 8)
1998 : 85 45 __ STA T2 + 0 
199a : ad ff 9f LDA $9fff ; (sstack + 9)
199d : 85 46 __ STA T2 + 1 
199f : a0 00 __ LDY #$00
19a1 : b1 45 __ LDA (T2 + 0),y 
19a3 : 38 __ __ SEC
19a4 : e9 01 __ SBC #$01
19a6 : 85 54 __ STA T3 + 0 
19a8 : bc f5 22 LDY $22f5,x ; (__multab3L + 0)
19ab : 99 7d 23 STA $237d,y ; (EnemyShot + 0)
19ae : a0 01 __ LDY #$01
19b0 : b1 45 __ LDA (T2 + 0),y 
19b2 : 85 53 __ STA T1 + 0 
19b4 : bc f5 22 LDY $22f5,x ; (__multab3L + 0)
19b7 : 99 7e 23 STA $237e,y ; (EnemyShot + 1)
19ba : 20 11 0b JSR $0b11 ; (gotoxy.s0 + 0)
19bd : a9 e2 __ LDA #$e2
19bf : a0 02 __ LDY #$02
19c1 : 91 23 __ STA (SP + 0),y 
19c3 : a9 19 __ LDA #$19
19c5 : c8 __ __ INY
19c6 : 91 23 __ STA (SP + 0),y 
19c8 : a5 54 __ LDA T3 + 0 
19ca : c8 __ __ INY
19cb : 91 23 __ STA (SP + 0),y 
19cd : a9 00 __ LDA #$00
19cf : c8 __ __ INY
19d0 : 91 23 __ STA (SP + 0),y 
19d2 : a5 53 __ LDA T1 + 0 
19d4 : c8 __ __ INY
19d5 : 91 23 __ STA (SP + 0),y 
19d7 : a9 00 __ LDA #$00
19d9 : c8 __ __ INY
19da : 91 23 __ STA (SP + 0),y 
19dc : 20 1a 0b JSR $0b1a ; (printf.s0 + 0)
19df : 4c 6e 19 JMP $196e ; (spawn_enemy_shot.s1001 + 0)
--------------------------------------------------------------------
19e2 : __ __ __ BYT 25 64 20 2d 20 25 64 00                         : %d - %d.
--------------------------------------------------------------------
render_enemy_shots:
.s0:
19ea : a2 00 __ LDX #$00
.l1006:
19ec : bc f5 22 LDY $22f5,x ; (__multab3L + 0)
19ef : b9 7f 23 LDA $237f,y ; (EnemyShot + 2)
19f2 : c9 01 __ CMP #$01
19f4 : d0 43 __ BNE $1a39 ; (render_enemy_shots.s19 + 0)
.s5:
19f6 : b9 7e 23 LDA $237e,y ; (EnemyShot + 1)
19f9 : 0a __ __ ASL
19fa : 85 1b __ STA ACCU + 0 
19fc : a9 00 __ LDA #$00
19fe : 2a __ __ ROL
19ff : 06 1b __ ASL ACCU + 0 
1a01 : 2a __ __ ROL
1a02 : 85 1c __ STA ACCU + 1 
1a04 : a5 1b __ LDA ACCU + 0 
1a06 : 79 7e 23 ADC $237e,y ; (EnemyShot + 1)
1a09 : 85 1b __ STA ACCU + 0 
1a0b : a5 1c __ LDA ACCU + 1 
1a0d : 69 00 __ ADC #$00
1a0f : 06 1b __ ASL ACCU + 0 
1a11 : 2a __ __ ROL
1a12 : 06 1b __ ASL ACCU + 0 
1a14 : 2a __ __ ROL
1a15 : 06 1b __ ASL ACCU + 0 
1a17 : 2a __ __ ROL
1a18 : 85 1c __ STA ACCU + 1 
1a1a : 18 __ __ CLC
1a1b : a5 1b __ LDA ACCU + 0 
1a1d : 79 7d 23 ADC $237d,y ; (EnemyShot + 0)
1a20 : 85 1b __ STA ACCU + 0 
1a22 : 85 1f __ STA ADDR + 0 
1a24 : a5 1c __ LDA ACCU + 1 
1a26 : 69 c0 __ ADC #$c0
1a28 : 85 1c __ STA ACCU + 1 
1a2a : 18 __ __ CLC
1a2b : 69 18 __ ADC #$18
1a2d : 85 20 __ STA ADDR + 1 
1a2f : a9 82 __ LDA #$82
1a31 : a0 00 __ LDY #$00
1a33 : 91 1b __ STA (ACCU + 0),y 
1a35 : a9 01 __ LDA #$01
1a37 : 91 1f __ STA (ADDR + 0),y 
.s19:
1a39 : e8 __ __ INX
1a3a : e0 03 __ CPX #$03
1a3c : 90 ae __ BCC $19ec ; (render_enemy_shots.l1006 + 0)
.s1001:
1a3e : 60 __ __ RTS
--------------------------------------------------------------------
render_enemies:
.s0:
1a3f : a9 00 __ LDA #$00
1a41 : aa __ __ TAX
.l2:
1a42 : 0a __ __ ASL
1a43 : 0a __ __ ASL
1a44 : a8 __ __ TAY
1a45 : b9 4f 23 LDA $234f,y ; (Enemy + 3)
1a48 : c9 01 __ CMP #$01
1a4a : d0 44 __ BNE $1a90 ; (render_enemies.s19 + 0)
.s5:
1a4c : b9 4d 23 LDA $234d,y ; (Enemy + 1)
1a4f : 0a __ __ ASL
1a50 : 85 1b __ STA ACCU + 0 
1a52 : a9 00 __ LDA #$00
1a54 : 2a __ __ ROL
1a55 : 06 1b __ ASL ACCU + 0 
1a57 : 2a __ __ ROL
1a58 : 85 1c __ STA ACCU + 1 
1a5a : a5 1b __ LDA ACCU + 0 
1a5c : 79 4d 23 ADC $234d,y ; (Enemy + 1)
1a5f : 85 1b __ STA ACCU + 0 
1a61 : a5 1c __ LDA ACCU + 1 
1a63 : 69 00 __ ADC #$00
1a65 : 06 1b __ ASL ACCU + 0 
1a67 : 2a __ __ ROL
1a68 : 06 1b __ ASL ACCU + 0 
1a6a : 2a __ __ ROL
1a6b : 06 1b __ ASL ACCU + 0 
1a6d : 2a __ __ ROL
1a6e : 85 1c __ STA ACCU + 1 
1a70 : 18 __ __ CLC
1a71 : a5 1b __ LDA ACCU + 0 
1a73 : 79 4c 23 ADC $234c,y ; (Enemy + 0)
1a76 : 85 1b __ STA ACCU + 0 
1a78 : 85 1f __ STA ADDR + 0 
1a7a : a5 1c __ LDA ACCU + 1 
1a7c : 69 c0 __ ADC #$c0
1a7e : 85 1c __ STA ACCU + 1 
1a80 : 18 __ __ CLC
1a81 : 69 18 __ ADC #$18
1a83 : 85 20 __ STA ADDR + 1 
1a85 : b9 4e 23 LDA $234e,y ; (Enemy + 2)
1a88 : a0 00 __ LDY #$00
1a8a : 91 1b __ STA (ACCU + 0),y 
1a8c : a9 08 __ LDA #$08
1a8e : 91 1f __ STA (ADDR + 0),y 
.s19:
1a90 : e8 __ __ INX
1a91 : 8a __ __ TXA
1a92 : e0 0a __ CPX #$0a
1a94 : 90 ac __ BCC $1a42 ; (render_enemies.l2 + 0)
.s1001:
1a96 : 60 __ __ RTS
--------------------------------------------------------------------
move_enemy_shots:
.s0:
1a97 : a2 00 __ LDX #$00
.l1008:
1a99 : bc f5 22 LDY $22f5,x ; (__multab3L + 0)
1a9c : b9 7f 23 LDA $237f,y ; (EnemyShot + 2)
1a9f : c9 01 __ CMP #$01
1aa1 : d0 58 __ BNE $1afb ; (move_enemy_shots.s23 + 0)
.s5:
1aa3 : 84 1d __ STY ACCU + 2 
1aa5 : b9 7e 23 LDA $237e,y ; (EnemyShot + 1)
1aa8 : 0a __ __ ASL
1aa9 : 85 1b __ STA ACCU + 0 
1aab : a9 00 __ LDA #$00
1aad : 2a __ __ ROL
1aae : 06 1b __ ASL ACCU + 0 
1ab0 : 2a __ __ ROL
1ab1 : 85 1c __ STA ACCU + 1 
1ab3 : a5 1b __ LDA ACCU + 0 
1ab5 : 79 7e 23 ADC $237e,y ; (EnemyShot + 1)
1ab8 : 85 1b __ STA ACCU + 0 
1aba : a5 1c __ LDA ACCU + 1 
1abc : 69 00 __ ADC #$00
1abe : 06 1b __ ASL ACCU + 0 
1ac0 : 2a __ __ ROL
1ac1 : 06 1b __ ASL ACCU + 0 
1ac3 : 2a __ __ ROL
1ac4 : 06 1b __ ASL ACCU + 0 
1ac6 : 2a __ __ ROL
1ac7 : 85 1c __ STA ACCU + 1 
1ac9 : b9 7d 23 LDA $237d,y ; (EnemyShot + 0)
1acc : 85 1e __ STA ACCU + 3 
1ace : 18 __ __ CLC
1acf : 65 1b __ ADC ACCU + 0 
1ad1 : 85 1b __ STA ACCU + 0 
1ad3 : 85 1f __ STA ADDR + 0 
1ad5 : a5 1c __ LDA ACCU + 1 
1ad7 : 69 c0 __ ADC #$c0
1ad9 : 85 1c __ STA ACCU + 1 
1adb : 18 __ __ CLC
1adc : 69 18 __ ADC #$18
1ade : 85 20 __ STA ADDR + 1 
1ae0 : a9 20 __ LDA #$20
1ae2 : a0 00 __ LDY #$00
1ae4 : 91 1b __ STA (ACCU + 0),y 
1ae6 : 98 __ __ TYA
1ae7 : 91 1f __ STA (ADDR + 0),y 
1ae9 : c6 1e __ DEC ACCU + 3 
1aeb : a5 1e __ LDA ACCU + 3 
1aed : a4 1d __ LDY ACCU + 2 
1aef : 99 7d 23 STA $237d,y ; (EnemyShot + 0)
1af2 : c9 ff __ CMP #$ff
1af4 : d0 05 __ BNE $1afb ; (move_enemy_shots.s23 + 0)
.s8:
1af6 : a9 00 __ LDA #$00
1af8 : 99 7f 23 STA $237f,y ; (EnemyShot + 2)
.s23:
1afb : e8 __ __ INX
1afc : e0 03 __ CPX #$03
1afe : 90 99 __ BCC $1a99 ; (move_enemy_shots.l1008 + 0)
.s1001:
1b00 : 60 __ __ RTS
--------------------------------------------------------------------
check_player_enemy_collision:
.s0:
1b01 : a9 00 __ LDA #$00
1b03 : a8 __ __ TAY
.l2:
1b04 : 0a __ __ ASL
1b05 : 0a __ __ ASL
1b06 : aa __ __ TAX
1b07 : bd 4f 23 LDA $234f,x ; (Enemy + 3)
1b0a : c9 01 __ CMP #$01
1b0c : d0 10 __ BNE $1b1e ; (check_player_enemy_collision.s3 + 0)
.s5:
1b0e : bd 4c 23 LDA $234c,x ; (Enemy + 0)
1b11 : cd fc 22 CMP $22fc ; (Player + 0)
1b14 : d0 08 __ BNE $1b1e ; (check_player_enemy_collision.s3 + 0)
.s11:
1b16 : bd 4d 23 LDA $234d,x ; (Enemy + 1)
1b19 : cd fd 22 CMP $22fd ; (Player + 1)
1b1c : f0 2e __ BEQ $1b4c ; (check_player_enemy_collision.s8 + 0)
.s3:
1b1e : c8 __ __ INY
1b1f : 98 __ __ TYA
1b20 : c0 0a __ CPY #$0a
1b22 : 90 e0 __ BCC $1b04 ; (check_player_enemy_collision.l2 + 0)
.s4:
1b24 : a0 00 __ LDY #$00
.l13:
1b26 : be f5 22 LDX $22f5,y ; (__multab3L + 0)
1b29 : bd 7f 23 LDA $237f,x ; (EnemyShot + 2)
1b2c : c9 01 __ CMP #$01
1b2e : d0 10 __ BNE $1b40 ; (check_player_enemy_collision.s14 + 0)
.s16:
1b30 : bd 7d 23 LDA $237d,x ; (EnemyShot + 0)
1b33 : cd fc 22 CMP $22fc ; (Player + 0)
1b36 : d0 08 __ BNE $1b40 ; (check_player_enemy_collision.s14 + 0)
.s22:
1b38 : bd 7e 23 LDA $237e,x ; (EnemyShot + 1)
1b3b : cd fd 22 CMP $22fd ; (Player + 1)
1b3e : f0 06 __ BEQ $1b46 ; (check_player_enemy_collision.s19 + 0)
.s14:
1b40 : c8 __ __ INY
1b41 : c0 03 __ CPY #$03
1b43 : 90 e1 __ BCC $1b26 ; (check_player_enemy_collision.l13 + 0)
.s1001:
1b45 : 60 __ __ RTS
.s19:
1b46 : a9 01 __ LDA #$01
1b48 : 8d 86 23 STA $2386 ; (game + 0)
1b4b : 60 __ __ RTS
.s8:
1b4c : a9 01 __ LDA #$01
1b4e : 8d 86 23 STA $2386 ; (game + 0)
1b51 : d0 d1 __ BNE $1b24 ; (check_player_enemy_collision.s4 + 0)
--------------------------------------------------------------------
control_player_ship:
.s0:
1b53 : a9 00 __ LDA #$00
1b55 : 20 f5 1b JSR $1bf5 ; (joy_poll.s0 + 0)
1b58 : ad 8b 23 LDA $238b ; (joyx + 0)
1b5b : 85 1d __ STA ACCU + 2 
1b5d : 85 1e __ STA ACCU + 3 
1b5f : d0 08 __ BNE $1b69 ; (control_player_ship.s1 + 0)
.s4:
1b61 : ad fe 22 LDA $22fe ; (joyy + 0)
1b64 : d0 03 __ BNE $1b69 ; (control_player_ship.s1 + 0)
1b66 : 4c ea 1b JMP $1bea ; (control_player_ship.s3 + 0)
.s1:
1b69 : ad fc 22 LDA $22fc ; (Player + 0)
1b6c : 85 43 __ STA T2 + 0 
1b6e : 85 44 __ STA T3 + 0 
1b70 : ad fd 22 LDA $22fd ; (Player + 1)
1b73 : 85 45 __ STA T4 + 0 
1b75 : 85 46 __ STA T5 + 0 
1b77 : 0a __ __ ASL
1b78 : 85 1b __ STA ACCU + 0 
1b7a : a9 00 __ LDA #$00
1b7c : 2a __ __ ROL
1b7d : 06 1b __ ASL ACCU + 0 
1b7f : 2a __ __ ROL
1b80 : aa __ __ TAX
1b81 : a5 1b __ LDA ACCU + 0 
1b83 : 65 45 __ ADC T4 + 0 
1b85 : 85 1b __ STA ACCU + 0 
1b87 : 8a __ __ TXA
1b88 : 69 00 __ ADC #$00
1b8a : 06 1b __ ASL ACCU + 0 
1b8c : 2a __ __ ROL
1b8d : 06 1b __ ASL ACCU + 0 
1b8f : 2a __ __ ROL
1b90 : 06 1b __ ASL ACCU + 0 
1b92 : 2a __ __ ROL
1b93 : aa __ __ TAX
1b94 : 18 __ __ CLC
1b95 : a5 1b __ LDA ACCU + 0 
1b97 : 65 43 __ ADC T2 + 0 
1b99 : 85 1b __ STA ACCU + 0 
1b9b : 85 1f __ STA ADDR + 0 
1b9d : 8a __ __ TXA
1b9e : 69 c0 __ ADC #$c0
1ba0 : 85 1c __ STA ACCU + 1 
1ba2 : 18 __ __ CLC
1ba3 : 69 18 __ ADC #$18
1ba5 : 85 20 __ STA ADDR + 1 
1ba7 : a9 20 __ LDA #$20
1ba9 : a0 00 __ LDY #$00
1bab : 91 1b __ STA (ACCU + 0),y 
1bad : 98 __ __ TYA
1bae : 91 1f __ STA (ADDR + 0),y 
1bb0 : a5 43 __ LDA T2 + 0 
1bb2 : f0 04 __ BEQ $1bb8 ; (control_player_ship.s6 + 0)
.s8:
1bb4 : a5 1d __ LDA ACCU + 2 
1bb6 : 30 0c __ BMI $1bc4 ; (control_player_ship.s5 + 0)
.s6:
1bb8 : a5 43 __ LDA T2 + 0 
1bba : c9 27 __ CMP #$27
1bbc : b0 0e __ BCS $1bcc ; (control_player_ship.s7 + 0)
.s12:
1bbe : a5 1d __ LDA ACCU + 2 
1bc0 : 30 0a __ BMI $1bcc ; (control_player_ship.s7 + 0)
.s1009:
1bc2 : f0 08 __ BEQ $1bcc ; (control_player_ship.s7 + 0)
.s5:
1bc4 : 18 __ __ CLC
1bc5 : a5 44 __ LDA T3 + 0 
1bc7 : 65 1e __ ADC ACCU + 3 
1bc9 : 8d fc 22 STA $22fc ; (Player + 0)
.s7:
1bcc : a5 45 __ LDA T4 + 0 
1bce : c9 04 __ CMP #$04
1bd0 : 90 07 __ BCC $1bd9 ; (control_player_ship.s14 + 0)
.s16:
1bd2 : ad fe 22 LDA $22fe ; (joyy + 0)
1bd5 : 30 0d __ BMI $1be4 ; (control_player_ship.s32 + 0)
.s1012:
1bd7 : a5 45 __ LDA T4 + 0 
.s14:
1bd9 : c9 18 __ CMP #$18
1bdb : b0 0d __ BCS $1bea ; (control_player_ship.s3 + 0)
.s20:
1bdd : ad fe 22 LDA $22fe ; (joyy + 0)
1be0 : 30 08 __ BMI $1bea ; (control_player_ship.s3 + 0)
.s1004:
1be2 : f0 06 __ BEQ $1bea ; (control_player_ship.s3 + 0)
.s32:
1be4 : 18 __ __ CLC
1be5 : 65 46 __ ADC T5 + 0 
1be7 : 8d fd 22 STA $22fd ; (Player + 1)
.s3:
1bea : ad 8d 23 LDA $238d ; (joyb + 0)
1bed : c9 01 __ CMP #$01
1bef : f0 01 __ BEQ $1bf2 ; (control_player_ship.s21 + 0)
.s1001:
1bf1 : 60 __ __ RTS
.s21:
1bf2 : 4c 35 1c JMP $1c35 ; (spawn_player_shot.s0 + 0)
--------------------------------------------------------------------
joy_poll:
.s0:
1bf5 : aa __ __ TAX
1bf6 : bd 00 dc LDA $dc00,x 
1bf9 : a8 __ __ TAY
1bfa : 29 10 __ AND #$10
1bfc : f0 04 __ BEQ $1c02 ; (joy_poll.s1005 + 0)
.s1006:
1bfe : a9 00 __ LDA #$00
1c00 : f0 02 __ BEQ $1c04 ; (joy_poll.s1007 + 0)
.s1005:
1c02 : a9 01 __ LDA #$01
.s1007:
1c04 : 9d 8d 23 STA $238d,x ; (joyb + 0)
1c07 : 98 __ __ TYA
1c08 : 4a __ __ LSR
1c09 : b0 1d __ BCS $1c28 ; (joy_poll.s2 + 0)
.s1:
1c0b : a9 ff __ LDA #$ff
.s15:
1c0d : 9d fe 22 STA $22fe,x ; (joyy + 0)
1c10 : 98 __ __ TYA
1c11 : 29 04 __ AND #$04
1c13 : d0 06 __ BNE $1c1b ; (joy_poll.s8 + 0)
.s7:
1c15 : a9 ff __ LDA #$ff
.s1001:
1c17 : 9d 8b 23 STA $238b,x ; (joyx + 0)
1c1a : 60 __ __ RTS
.s8:
1c1b : 98 __ __ TYA
1c1c : 29 08 __ AND #$08
1c1e : f0 04 __ BEQ $1c24 ; (joy_poll.s1011 + 0)
.s1012:
1c20 : a9 00 __ LDA #$00
1c22 : f0 f3 __ BEQ $1c17 ; (joy_poll.s1001 + 0)
.s1011:
1c24 : a9 01 __ LDA #$01
1c26 : d0 ef __ BNE $1c17 ; (joy_poll.s1001 + 0)
.s2:
1c28 : 98 __ __ TYA
1c29 : 29 02 __ AND #$02
1c2b : f0 04 __ BEQ $1c31 ; (joy_poll.s1008 + 0)
.s1009:
1c2d : a9 00 __ LDA #$00
1c2f : f0 dc __ BEQ $1c0d ; (joy_poll.s15 + 0)
.s1008:
1c31 : a9 01 __ LDA #$01
1c33 : d0 d8 __ BNE $1c0d ; (joy_poll.s15 + 0)
--------------------------------------------------------------------
joyy:
22fe : __ __ __ BSS	2
--------------------------------------------------------------------
joyx:
238b : __ __ __ BSS	2
--------------------------------------------------------------------
joyb:
238d : __ __ __ BSS	2
--------------------------------------------------------------------
spawn_player_shot:
.s0:
1c35 : ad fc 22 LDA $22fc ; (Player + 0)
1c38 : c9 27 __ CMP #$27
1c3a : f0 0f __ BEQ $1c4b ; (spawn_player_shot.s1001 + 0)
.s3:
1c3c : a0 00 __ LDY #$00
.l6:
1c3e : be f5 22 LDX $22f5,y ; (__multab3L + 0)
1c41 : bd 76 23 LDA $2376,x ; (PlayerShot + 2)
1c44 : f0 06 __ BEQ $1c4c ; (spawn_player_shot.s9 + 0)
.s7:
1c46 : c8 __ __ INY
1c47 : c0 03 __ CPY #$03
1c49 : 90 f3 __ BCC $1c3e ; (spawn_player_shot.l6 + 0)
.s1001:
1c4b : 60 __ __ RTS
.s9:
1c4c : a9 01 __ LDA #$01
1c4e : 9d 76 23 STA $2376,x ; (PlayerShot + 2)
1c51 : ad fd 22 LDA $22fd ; (Player + 1)
1c54 : 9d 75 23 STA $2375,x ; (PlayerShot + 1)
1c57 : ad 8b 23 LDA $238b ; (joyx + 0)
1c5a : 30 02 __ BMI $1c5e ; (spawn_player_shot.s13 + 0)
.s1007:
1c5c : d0 06 __ BNE $1c64 ; (spawn_player_shot.s12 + 0)
.s13:
1c5e : ad fc 22 LDA $22fc ; (Player + 0)
1c61 : 4c 6a 1c JMP $1c6a ; (spawn_player_shot.s1010 + 0)
.s12:
1c64 : ad fc 22 LDA $22fc ; (Player + 0)
1c67 : 18 __ __ CLC
1c68 : 69 01 __ ADC #$01
.s1010:
1c6a : be f5 22 LDX $22f5,y ; (__multab3L + 0)
1c6d : 9d 74 23 STA $2374,x ; (PlayerShot + 0)
1c70 : 60 __ __ RTS
--------------------------------------------------------------------
render_player_ship:
.s0:
1c71 : ad fd 22 LDA $22fd ; (Player + 1)
1c74 : 0a __ __ ASL
1c75 : 85 1b __ STA ACCU + 0 
1c77 : a9 00 __ LDA #$00
1c79 : 2a __ __ ROL
1c7a : 06 1b __ ASL ACCU + 0 
1c7c : 2a __ __ ROL
1c7d : aa __ __ TAX
1c7e : a5 1b __ LDA ACCU + 0 
1c80 : 6d fd 22 ADC $22fd ; (Player + 1)
1c83 : 85 1b __ STA ACCU + 0 
1c85 : 8a __ __ TXA
1c86 : 69 00 __ ADC #$00
1c88 : 06 1b __ ASL ACCU + 0 
1c8a : 2a __ __ ROL
1c8b : 06 1b __ ASL ACCU + 0 
1c8d : 2a __ __ ROL
1c8e : 06 1b __ ASL ACCU + 0 
1c90 : 2a __ __ ROL
1c91 : aa __ __ TAX
1c92 : 18 __ __ CLC
1c93 : a5 1b __ LDA ACCU + 0 
1c95 : 6d fc 22 ADC $22fc ; (Player + 0)
1c98 : 85 1b __ STA ACCU + 0 
1c9a : 85 1f __ STA ADDR + 0 
1c9c : 8a __ __ TXA
1c9d : 69 c0 __ ADC #$c0
1c9f : 85 1c __ STA ACCU + 1 
1ca1 : 18 __ __ CLC
1ca2 : 69 18 __ ADC #$18
1ca4 : 85 20 __ STA ADDR + 1 
1ca6 : a9 80 __ LDA #$80
1ca8 : a0 00 __ LDY #$00
1caa : 91 1b __ STA (ACCU + 0),y 
1cac : a9 03 __ LDA #$03
1cae : 91 1f __ STA (ADDR + 0),y 
.s1001:
1cb0 : 60 __ __ RTS
--------------------------------------------------------------------
move_player_shots:
.s0:
1cb1 : a2 00 __ LDX #$00
.l2:
1cb3 : 86 1d __ STX ACCU + 2 
1cb5 : bc f5 22 LDY $22f5,x ; (__multab3L + 0)
1cb8 : b9 76 23 LDA $2376,y ; (PlayerShot + 2)
1cbb : c9 01 __ CMP #$01
1cbd : d0 52 __ BNE $1d11 ; (move_player_shots.s23 + 0)
.s5:
1cbf : 84 1e __ STY ACCU + 3 
1cc1 : b9 75 23 LDA $2375,y ; (PlayerShot + 1)
1cc4 : 0a __ __ ASL
1cc5 : 85 1b __ STA ACCU + 0 
1cc7 : a9 00 __ LDA #$00
1cc9 : 2a __ __ ROL
1cca : 06 1b __ ASL ACCU + 0 
1ccc : 2a __ __ ROL
1ccd : aa __ __ TAX
1cce : a5 1b __ LDA ACCU + 0 
1cd0 : 79 75 23 ADC $2375,y ; (PlayerShot + 1)
1cd3 : 85 1b __ STA ACCU + 0 
1cd5 : 8a __ __ TXA
1cd6 : 69 00 __ ADC #$00
1cd8 : 06 1b __ ASL ACCU + 0 
1cda : 2a __ __ ROL
1cdb : 06 1b __ ASL ACCU + 0 
1cdd : 2a __ __ ROL
1cde : 06 1b __ ASL ACCU + 0 
1ce0 : 2a __ __ ROL
1ce1 : 85 1c __ STA ACCU + 1 
1ce3 : b9 74 23 LDA $2374,y ; (PlayerShot + 0)
1ce6 : aa __ __ TAX
1ce7 : 18 __ __ CLC
1ce8 : 65 1b __ ADC ACCU + 0 
1cea : 85 1b __ STA ACCU + 0 
1cec : 85 1f __ STA ADDR + 0 
1cee : a5 1c __ LDA ACCU + 1 
1cf0 : 69 c0 __ ADC #$c0
1cf2 : 85 1c __ STA ACCU + 1 
1cf4 : 18 __ __ CLC
1cf5 : 69 18 __ ADC #$18
1cf7 : 85 20 __ STA ADDR + 1 
1cf9 : a9 20 __ LDA #$20
1cfb : a0 00 __ LDY #$00
1cfd : 91 1b __ STA (ACCU + 0),y 
1cff : 98 __ __ TYA
1d00 : 91 1f __ STA (ADDR + 0),y 
1d02 : e8 __ __ INX
1d03 : 8a __ __ TXA
1d04 : a6 1e __ LDX ACCU + 3 
1d06 : 9d 74 23 STA $2374,x ; (PlayerShot + 0)
1d09 : c9 28 __ CMP #$28
1d0b : 90 04 __ BCC $1d11 ; (move_player_shots.s23 + 0)
.s8:
1d0d : 98 __ __ TYA
1d0e : 9d 76 23 STA $2376,x ; (PlayerShot + 2)
.s23:
1d11 : a6 1d __ LDX ACCU + 2 
1d13 : e8 __ __ INX
1d14 : e0 03 __ CPX #$03
1d16 : 90 9b __ BCC $1cb3 ; (move_player_shots.l2 + 0)
.s1001:
1d18 : 60 __ __ RTS
--------------------------------------------------------------------
render_player_shots:
.s0:
1d19 : a2 00 __ LDX #$00
.l1006:
1d1b : bc f5 22 LDY $22f5,x ; (__multab3L + 0)
1d1e : b9 76 23 LDA $2376,y ; (PlayerShot + 2)
1d21 : c9 01 __ CMP #$01
1d23 : d0 43 __ BNE $1d68 ; (render_player_shots.s19 + 0)
.s5:
1d25 : b9 75 23 LDA $2375,y ; (PlayerShot + 1)
1d28 : 0a __ __ ASL
1d29 : 85 1b __ STA ACCU + 0 
1d2b : a9 00 __ LDA #$00
1d2d : 2a __ __ ROL
1d2e : 06 1b __ ASL ACCU + 0 
1d30 : 2a __ __ ROL
1d31 : 85 1c __ STA ACCU + 1 
1d33 : a5 1b __ LDA ACCU + 0 
1d35 : 79 75 23 ADC $2375,y ; (PlayerShot + 1)
1d38 : 85 1b __ STA ACCU + 0 
1d3a : a5 1c __ LDA ACCU + 1 
1d3c : 69 00 __ ADC #$00
1d3e : 06 1b __ ASL ACCU + 0 
1d40 : 2a __ __ ROL
1d41 : 06 1b __ ASL ACCU + 0 
1d43 : 2a __ __ ROL
1d44 : 06 1b __ ASL ACCU + 0 
1d46 : 2a __ __ ROL
1d47 : 85 1c __ STA ACCU + 1 
1d49 : 18 __ __ CLC
1d4a : a5 1b __ LDA ACCU + 0 
1d4c : 79 74 23 ADC $2374,y ; (PlayerShot + 0)
1d4f : 85 1b __ STA ACCU + 0 
1d51 : 85 1f __ STA ADDR + 0 
1d53 : a5 1c __ LDA ACCU + 1 
1d55 : 69 c0 __ ADC #$c0
1d57 : 85 1c __ STA ACCU + 1 
1d59 : 18 __ __ CLC
1d5a : 69 18 __ ADC #$18
1d5c : 85 20 __ STA ADDR + 1 
1d5e : a9 81 __ LDA #$81
1d60 : a0 00 __ LDY #$00
1d62 : 91 1b __ STA (ACCU + 0),y 
1d64 : a9 01 __ LDA #$01
1d66 : 91 1f __ STA (ADDR + 0),y 
.s19:
1d68 : e8 __ __ INX
1d69 : e0 03 __ CPX #$03
1d6b : 90 ae __ BCC $1d1b ; (render_player_shots.l1006 + 0)
.s1001:
1d6d : 60 __ __ RTS
--------------------------------------------------------------------
check_shot_enemy_collision:
.s0:
1d6e : a2 00 __ LDX #$00
.l2:
1d70 : 86 1d __ STX ACCU + 2 
1d72 : bc f5 22 LDY $22f5,x ; (__multab3L + 0)
1d75 : b9 76 23 LDA $2376,y ; (PlayerShot + 2)
1d78 : c9 01 __ CMP #$01
1d7a : f0 03 __ BEQ $1d7f ; (check_shot_enemy_collision.s5 + 0)
1d7c : 4c 15 1e JMP $1e15 ; (check_shot_enemy_collision.s3 + 0)
.s5:
1d7f : a9 00 __ LDA #$00
1d81 : 85 43 __ STA T2 + 0 
.l9:
1d83 : 0a __ __ ASL
1d84 : 0a __ __ ASL
1d85 : 85 1e __ STA ACCU + 3 
1d87 : a8 __ __ TAY
1d88 : b9 4f 23 LDA $234f,y ; (Enemy + 3)
1d8b : c9 01 __ CMP #$01
1d8d : d0 7b __ BNE $1e0a ; (check_shot_enemy_collision.s43 + 0)
.s12:
1d8f : a6 1d __ LDX ACCU + 2 
1d91 : bd f5 22 LDA $22f5,x ; (__multab3L + 0)
1d94 : 85 44 __ STA T3 + 0 
1d96 : aa __ __ TAX
1d97 : b9 4c 23 LDA $234c,y ; (Enemy + 0)
1d9a : dd 74 23 CMP $2374,x ; (PlayerShot + 0)
1d9d : d0 6b __ BNE $1e0a ; (check_shot_enemy_collision.s43 + 0)
.s18:
1d9f : b9 4d 23 LDA $234d,y ; (Enemy + 1)
1da2 : dd 75 23 CMP $2375,x ; (PlayerShot + 1)
1da5 : d0 63 __ BNE $1e0a ; (check_shot_enemy_collision.s43 + 0)
.s15:
1da7 : 0a __ __ ASL
1da8 : 85 1b __ STA ACCU + 0 
1daa : a9 00 __ LDA #$00
1dac : 2a __ __ ROL
1dad : 06 1b __ ASL ACCU + 0 
1daf : 2a __ __ ROL
1db0 : aa __ __ TAX
1db1 : a5 1b __ LDA ACCU + 0 
1db3 : 79 4d 23 ADC $234d,y ; (Enemy + 1)
1db6 : 85 1b __ STA ACCU + 0 
1db8 : 8a __ __ TXA
1db9 : 69 00 __ ADC #$00
1dbb : 06 1b __ ASL ACCU + 0 
1dbd : 2a __ __ ROL
1dbe : 06 1b __ ASL ACCU + 0 
1dc0 : 2a __ __ ROL
1dc1 : 06 1b __ ASL ACCU + 0 
1dc3 : 2a __ __ ROL
1dc4 : aa __ __ TAX
1dc5 : 18 __ __ CLC
1dc6 : a5 1b __ LDA ACCU + 0 
1dc8 : 79 4c 23 ADC $234c,y ; (Enemy + 0)
1dcb : 85 1b __ STA ACCU + 0 
1dcd : 85 1f __ STA ADDR + 0 
1dcf : 8a __ __ TXA
1dd0 : 69 c0 __ ADC #$c0
1dd2 : 85 1c __ STA ACCU + 1 
1dd4 : 18 __ __ CLC
1dd5 : 69 18 __ ADC #$18
1dd7 : 85 20 __ STA ADDR + 1 
1dd9 : a9 20 __ LDA #$20
1ddb : a0 00 __ LDY #$00
1ddd : 91 1b __ STA (ACCU + 0),y 
1ddf : 98 __ __ TYA
1de0 : 91 1f __ STA (ADDR + 0),y 
1de2 : a6 1e __ LDX ACCU + 3 
1de4 : 9d 4f 23 STA $234f,x ; (Enemy + 3)
1de7 : a6 44 __ LDX T3 + 0 
1de9 : 9d 76 23 STA $2376,x ; (PlayerShot + 2)
1dec : ad 87 23 LDA $2387 ; (game + 1)
1def : 18 __ __ CLC
1df0 : 69 01 __ ADC #$01
1df2 : 8d 87 23 STA $2387 ; (game + 1)
1df5 : ad 88 23 LDA $2388 ; (game + 2)
1df8 : 69 00 __ ADC #$00
1dfa : 8d 88 23 STA $2388 ; (game + 2)
1dfd : ad 89 23 LDA $2389 ; (game + 3)
1e00 : 69 00 __ ADC #$00
1e02 : 8d 89 23 STA $2389 ; (game + 3)
1e05 : 90 03 __ BCC $1e0a ; (check_shot_enemy_collision.s43 + 0)
.s1014:
1e07 : ee 8a 23 INC $238a ; (game + 4)
.s43:
1e0a : e6 43 __ INC T2 + 0 
1e0c : a5 43 __ LDA T2 + 0 
1e0e : c9 0a __ CMP #$0a
1e10 : b0 03 __ BCS $1e15 ; (check_shot_enemy_collision.s3 + 0)
1e12 : 4c 83 1d JMP $1d83 ; (check_shot_enemy_collision.l9 + 0)
.s3:
1e15 : a6 1d __ LDX ACCU + 2 
1e17 : e8 __ __ INX
1e18 : e0 03 __ CPX #$03
1e1a : b0 03 __ BCS $1e1f ; (check_shot_enemy_collision.s1001 + 0)
1e1c : 4c 70 1d JMP $1d70 ; (check_shot_enemy_collision.l2 + 0)
.s1001:
1e1f : 60 __ __ RTS
--------------------------------------------------------------------
wait_frames:
.s0:
1e20 : a5 0e __ LDA P1 ; (frames + 1)
1e22 : 30 1c __ BMI $1e40 ; (wait_frames.s1001 + 0)
.s1005:
1e24 : 05 0d __ ORA P0 ; (frames + 0)
1e26 : f0 18 __ BEQ $1e40 ; (wait_frames.s1001 + 0)
.s13:
1e28 : a0 00 __ LDY #$00
1e2a : a6 0e __ LDX P1 ; (frames + 1)
.l6:
1e2c : ad 11 d0 LDA $d011 
1e2f : 30 fb __ BMI $1e2c ; (wait_frames.l6 + 0)
.l9:
1e31 : ad 11 d0 LDA $d011 
1e34 : 10 fb __ BPL $1e31 ; (wait_frames.l9 + 0)
.s3:
1e36 : c8 __ __ INY
1e37 : 8a __ __ TXA
1e38 : 30 06 __ BMI $1e40 ; (wait_frames.s1001 + 0)
.s1004:
1e3a : d0 f0 __ BNE $1e2c ; (wait_frames.l6 + 0)
.s1002:
1e3c : c4 0d __ CPY P0 ; (frames + 0)
1e3e : 90 ec __ BCC $1e2c ; (wait_frames.l6 + 0)
.s1001:
1e40 : 60 __ __ RTS
--------------------------------------------------------------------
freg:
1e41 : b1 19 __ LDA (IP + 0),y 
1e43 : c8 __ __ INY
1e44 : aa __ __ TAX
1e45 : b5 00 __ LDA $00,x 
1e47 : 85 03 __ STA WORK + 0 
1e49 : b5 01 __ LDA $01,x 
1e4b : 85 04 __ STA WORK + 1 
1e4d : b5 02 __ LDA $02,x 
1e4f : 85 05 __ STA WORK + 2 
1e51 : b5 03 __ LDA WORK + 0,x 
1e53 : 85 06 __ STA WORK + 3 
1e55 : a5 05 __ LDA WORK + 2 
1e57 : 0a __ __ ASL
1e58 : a5 06 __ LDA WORK + 3 
1e5a : 2a __ __ ROL
1e5b : 85 08 __ STA WORK + 5 
1e5d : f0 06 __ BEQ $1e65 ; (freg + 36)
1e5f : a5 05 __ LDA WORK + 2 
1e61 : 09 80 __ ORA #$80
1e63 : 85 05 __ STA WORK + 2 
1e65 : a5 1d __ LDA ACCU + 2 
1e67 : 0a __ __ ASL
1e68 : a5 1e __ LDA ACCU + 3 
1e6a : 2a __ __ ROL
1e6b : 85 07 __ STA WORK + 4 
1e6d : f0 06 __ BEQ $1e75 ; (freg + 52)
1e6f : a5 1d __ LDA ACCU + 2 
1e71 : 09 80 __ ORA #$80
1e73 : 85 1d __ STA ACCU + 2 
1e75 : 60 __ __ RTS
1e76 : 06 1e __ ASL ACCU + 3 
1e78 : a5 07 __ LDA WORK + 4 
1e7a : 6a __ __ ROR
1e7b : 85 1e __ STA ACCU + 3 
1e7d : b0 06 __ BCS $1e85 ; (freg + 68)
1e7f : a5 1d __ LDA ACCU + 2 
1e81 : 29 7f __ AND #$7f
1e83 : 85 1d __ STA ACCU + 2 
1e85 : 60 __ __ RTS
--------------------------------------------------------------------
faddsub:
1e86 : a9 ff __ LDA #$ff
1e88 : c5 07 __ CMP WORK + 4 
1e8a : f0 04 __ BEQ $1e90 ; (faddsub + 10)
1e8c : c5 08 __ CMP WORK + 5 
1e8e : d0 11 __ BNE $1ea1 ; (faddsub + 27)
1e90 : a5 1e __ LDA ACCU + 3 
1e92 : 09 7f __ ORA #$7f
1e94 : 85 1e __ STA ACCU + 3 
1e96 : a9 80 __ LDA #$80
1e98 : 85 1d __ STA ACCU + 2 
1e9a : a9 00 __ LDA #$00
1e9c : 85 1b __ STA ACCU + 0 
1e9e : 85 1c __ STA ACCU + 1 
1ea0 : 60 __ __ RTS
1ea1 : 38 __ __ SEC
1ea2 : a5 07 __ LDA WORK + 4 
1ea4 : e5 08 __ SBC WORK + 5 
1ea6 : f0 38 __ BEQ $1ee0 ; (faddsub + 90)
1ea8 : aa __ __ TAX
1ea9 : b0 25 __ BCS $1ed0 ; (faddsub + 74)
1eab : e0 e9 __ CPX #$e9
1ead : b0 0e __ BCS $1ebd ; (faddsub + 55)
1eaf : a5 08 __ LDA WORK + 5 
1eb1 : 85 07 __ STA WORK + 4 
1eb3 : a9 00 __ LDA #$00
1eb5 : 85 1b __ STA ACCU + 0 
1eb7 : 85 1c __ STA ACCU + 1 
1eb9 : 85 1d __ STA ACCU + 2 
1ebb : f0 23 __ BEQ $1ee0 ; (faddsub + 90)
1ebd : a5 1d __ LDA ACCU + 2 
1ebf : 4a __ __ LSR
1ec0 : 66 1c __ ROR ACCU + 1 
1ec2 : 66 1b __ ROR ACCU + 0 
1ec4 : e8 __ __ INX
1ec5 : d0 f8 __ BNE $1ebf ; (faddsub + 57)
1ec7 : 85 1d __ STA ACCU + 2 
1ec9 : a5 08 __ LDA WORK + 5 
1ecb : 85 07 __ STA WORK + 4 
1ecd : 4c e0 1e JMP $1ee0 ; (faddsub + 90)
1ed0 : e0 18 __ CPX #$18
1ed2 : b0 33 __ BCS $1f07 ; (faddsub + 129)
1ed4 : a5 05 __ LDA WORK + 2 
1ed6 : 4a __ __ LSR
1ed7 : 66 04 __ ROR WORK + 1 
1ed9 : 66 03 __ ROR WORK + 0 
1edb : ca __ __ DEX
1edc : d0 f8 __ BNE $1ed6 ; (faddsub + 80)
1ede : 85 05 __ STA WORK + 2 
1ee0 : a5 1e __ LDA ACCU + 3 
1ee2 : 29 80 __ AND #$80
1ee4 : 85 1e __ STA ACCU + 3 
1ee6 : 45 06 __ EOR WORK + 3 
1ee8 : 30 31 __ BMI $1f1b ; (faddsub + 149)
1eea : 18 __ __ CLC
1eeb : a5 1b __ LDA ACCU + 0 
1eed : 65 03 __ ADC WORK + 0 
1eef : 85 1b __ STA ACCU + 0 
1ef1 : a5 1c __ LDA ACCU + 1 
1ef3 : 65 04 __ ADC WORK + 1 
1ef5 : 85 1c __ STA ACCU + 1 
1ef7 : a5 1d __ LDA ACCU + 2 
1ef9 : 65 05 __ ADC WORK + 2 
1efb : 85 1d __ STA ACCU + 2 
1efd : 90 08 __ BCC $1f07 ; (faddsub + 129)
1eff : 66 1d __ ROR ACCU + 2 
1f01 : 66 1c __ ROR ACCU + 1 
1f03 : 66 1b __ ROR ACCU + 0 
1f05 : e6 07 __ INC WORK + 4 
1f07 : a5 07 __ LDA WORK + 4 
1f09 : c9 ff __ CMP #$ff
1f0b : f0 83 __ BEQ $1e90 ; (faddsub + 10)
1f0d : 4a __ __ LSR
1f0e : 05 1e __ ORA ACCU + 3 
1f10 : 85 1e __ STA ACCU + 3 
1f12 : b0 06 __ BCS $1f1a ; (faddsub + 148)
1f14 : a5 1d __ LDA ACCU + 2 
1f16 : 29 7f __ AND #$7f
1f18 : 85 1d __ STA ACCU + 2 
1f1a : 60 __ __ RTS
1f1b : 38 __ __ SEC
1f1c : a5 1b __ LDA ACCU + 0 
1f1e : e5 03 __ SBC WORK + 0 
1f20 : 85 1b __ STA ACCU + 0 
1f22 : a5 1c __ LDA ACCU + 1 
1f24 : e5 04 __ SBC WORK + 1 
1f26 : 85 1c __ STA ACCU + 1 
1f28 : a5 1d __ LDA ACCU + 2 
1f2a : e5 05 __ SBC WORK + 2 
1f2c : 85 1d __ STA ACCU + 2 
1f2e : b0 19 __ BCS $1f49 ; (faddsub + 195)
1f30 : 38 __ __ SEC
1f31 : a9 00 __ LDA #$00
1f33 : e5 1b __ SBC ACCU + 0 
1f35 : 85 1b __ STA ACCU + 0 
1f37 : a9 00 __ LDA #$00
1f39 : e5 1c __ SBC ACCU + 1 
1f3b : 85 1c __ STA ACCU + 1 
1f3d : a9 00 __ LDA #$00
1f3f : e5 1d __ SBC ACCU + 2 
1f41 : 85 1d __ STA ACCU + 2 
1f43 : a5 1e __ LDA ACCU + 3 
1f45 : 49 80 __ EOR #$80
1f47 : 85 1e __ STA ACCU + 3 
1f49 : a5 1d __ LDA ACCU + 2 
1f4b : 30 ba __ BMI $1f07 ; (faddsub + 129)
1f4d : 05 1c __ ORA ACCU + 1 
1f4f : 05 1b __ ORA ACCU + 0 
1f51 : f0 0f __ BEQ $1f62 ; (faddsub + 220)
1f53 : c6 07 __ DEC WORK + 4 
1f55 : f0 0b __ BEQ $1f62 ; (faddsub + 220)
1f57 : 06 1b __ ASL ACCU + 0 
1f59 : 26 1c __ ROL ACCU + 1 
1f5b : 26 1d __ ROL ACCU + 2 
1f5d : 10 f4 __ BPL $1f53 ; (faddsub + 205)
1f5f : 4c 07 1f JMP $1f07 ; (faddsub + 129)
1f62 : a9 00 __ LDA #$00
1f64 : 85 1b __ STA ACCU + 0 
1f66 : 85 1c __ STA ACCU + 1 
1f68 : 85 1d __ STA ACCU + 2 
1f6a : 85 1e __ STA ACCU + 3 
1f6c : 60 __ __ RTS
--------------------------------------------------------------------
fmul:
1f6d : a5 1b __ LDA ACCU + 0 
1f6f : 05 1c __ ORA ACCU + 1 
1f71 : 05 1d __ ORA ACCU + 2 
1f73 : d0 03 __ BNE $1f78 ; (fmul + 11)
1f75 : 85 1e __ STA ACCU + 3 
1f77 : 60 __ __ RTS
1f78 : a5 03 __ LDA WORK + 0 
1f7a : 05 04 __ ORA WORK + 1 
1f7c : 05 05 __ ORA WORK + 2 
1f7e : d0 09 __ BNE $1f89 ; (fmul + 28)
1f80 : 85 1b __ STA ACCU + 0 
1f82 : 85 1c __ STA ACCU + 1 
1f84 : 85 1d __ STA ACCU + 2 
1f86 : 85 1e __ STA ACCU + 3 
1f88 : 60 __ __ RTS
1f89 : a5 1e __ LDA ACCU + 3 
1f8b : 45 06 __ EOR WORK + 3 
1f8d : 29 80 __ AND #$80
1f8f : 85 1e __ STA ACCU + 3 
1f91 : a9 ff __ LDA #$ff
1f93 : c5 07 __ CMP WORK + 4 
1f95 : f0 42 __ BEQ $1fd9 ; (fmul + 108)
1f97 : c5 08 __ CMP WORK + 5 
1f99 : f0 3e __ BEQ $1fd9 ; (fmul + 108)
1f9b : a9 00 __ LDA #$00
1f9d : 85 09 __ STA WORK + 6 
1f9f : 85 0a __ STA WORK + 7 
1fa1 : 85 0b __ STA $0b 
1fa3 : a4 1b __ LDY ACCU + 0 
1fa5 : a5 03 __ LDA WORK + 0 
1fa7 : d0 06 __ BNE $1faf ; (fmul + 66)
1fa9 : a5 04 __ LDA WORK + 1 
1fab : f0 0a __ BEQ $1fb7 ; (fmul + 74)
1fad : d0 05 __ BNE $1fb4 ; (fmul + 71)
1faf : 20 0e 20 JSR $200e ; (fmul8 + 0)
1fb2 : a5 04 __ LDA WORK + 1 
1fb4 : 20 0e 20 JSR $200e ; (fmul8 + 0)
1fb7 : a5 05 __ LDA WORK + 2 
1fb9 : 20 0e 20 JSR $200e ; (fmul8 + 0)
1fbc : 38 __ __ SEC
1fbd : a5 0b __ LDA $0b 
1fbf : 30 06 __ BMI $1fc7 ; (fmul + 90)
1fc1 : 06 09 __ ASL WORK + 6 
1fc3 : 26 0a __ ROL WORK + 7 
1fc5 : 2a __ __ ROL
1fc6 : 18 __ __ CLC
1fc7 : 29 7f __ AND #$7f
1fc9 : 85 0b __ STA $0b 
1fcb : a5 07 __ LDA WORK + 4 
1fcd : 65 08 __ ADC WORK + 5 
1fcf : 90 19 __ BCC $1fea ; (fmul + 125)
1fd1 : e9 7f __ SBC #$7f
1fd3 : b0 04 __ BCS $1fd9 ; (fmul + 108)
1fd5 : c9 ff __ CMP #$ff
1fd7 : d0 15 __ BNE $1fee ; (fmul + 129)
1fd9 : a5 1e __ LDA ACCU + 3 
1fdb : 09 7f __ ORA #$7f
1fdd : 85 1e __ STA ACCU + 3 
1fdf : a9 80 __ LDA #$80
1fe1 : 85 1d __ STA ACCU + 2 
1fe3 : a9 00 __ LDA #$00
1fe5 : 85 1b __ STA ACCU + 0 
1fe7 : 85 1c __ STA ACCU + 1 
1fe9 : 60 __ __ RTS
1fea : e9 7e __ SBC #$7e
1fec : 90 15 __ BCC $2003 ; (fmul + 150)
1fee : 4a __ __ LSR
1fef : 05 1e __ ORA ACCU + 3 
1ff1 : 85 1e __ STA ACCU + 3 
1ff3 : a9 00 __ LDA #$00
1ff5 : 6a __ __ ROR
1ff6 : 05 0b __ ORA $0b 
1ff8 : 85 1d __ STA ACCU + 2 
1ffa : a5 0a __ LDA WORK + 7 
1ffc : 85 1c __ STA ACCU + 1 
1ffe : a5 09 __ LDA WORK + 6 
2000 : 85 1b __ STA ACCU + 0 
2002 : 60 __ __ RTS
2003 : a9 00 __ LDA #$00
2005 : 85 1b __ STA ACCU + 0 
2007 : 85 1c __ STA ACCU + 1 
2009 : 85 1d __ STA ACCU + 2 
200b : 85 1e __ STA ACCU + 3 
200d : 60 __ __ RTS
--------------------------------------------------------------------
fmul8:
200e : 38 __ __ SEC
200f : 6a __ __ ROR
2010 : 90 1e __ BCC $2030 ; (fmul8 + 34)
2012 : aa __ __ TAX
2013 : 18 __ __ CLC
2014 : 98 __ __ TYA
2015 : 65 09 __ ADC WORK + 6 
2017 : 85 09 __ STA WORK + 6 
2019 : a5 0a __ LDA WORK + 7 
201b : 65 1c __ ADC ACCU + 1 
201d : 85 0a __ STA WORK + 7 
201f : a5 0b __ LDA $0b 
2021 : 65 1d __ ADC ACCU + 2 
2023 : 6a __ __ ROR
2024 : 85 0b __ STA $0b 
2026 : 8a __ __ TXA
2027 : 66 0a __ ROR WORK + 7 
2029 : 66 09 __ ROR WORK + 6 
202b : 4a __ __ LSR
202c : f0 0d __ BEQ $203b ; (fmul8 + 45)
202e : b0 e2 __ BCS $2012 ; (fmul8 + 4)
2030 : 66 0b __ ROR $0b 
2032 : 66 0a __ ROR WORK + 7 
2034 : 66 09 __ ROR WORK + 6 
2036 : 4a __ __ LSR
2037 : 90 f7 __ BCC $2030 ; (fmul8 + 34)
2039 : d0 d7 __ BNE $2012 ; (fmul8 + 4)
203b : 60 __ __ RTS
--------------------------------------------------------------------
fdiv:
203c : a5 1b __ LDA ACCU + 0 
203e : 05 1c __ ORA ACCU + 1 
2040 : 05 1d __ ORA ACCU + 2 
2042 : d0 03 __ BNE $2047 ; (fdiv + 11)
2044 : 85 1e __ STA ACCU + 3 
2046 : 60 __ __ RTS
2047 : a5 1e __ LDA ACCU + 3 
2049 : 45 06 __ EOR WORK + 3 
204b : 29 80 __ AND #$80
204d : 85 1e __ STA ACCU + 3 
204f : a5 08 __ LDA WORK + 5 
2051 : f0 62 __ BEQ $20b5 ; (fdiv + 121)
2053 : a5 07 __ LDA WORK + 4 
2055 : c9 ff __ CMP #$ff
2057 : f0 5c __ BEQ $20b5 ; (fdiv + 121)
2059 : a9 00 __ LDA #$00
205b : 85 09 __ STA WORK + 6 
205d : 85 0a __ STA WORK + 7 
205f : 85 0b __ STA $0b 
2061 : a2 18 __ LDX #$18
2063 : a5 1b __ LDA ACCU + 0 
2065 : c5 03 __ CMP WORK + 0 
2067 : a5 1c __ LDA ACCU + 1 
2069 : e5 04 __ SBC WORK + 1 
206b : a5 1d __ LDA ACCU + 2 
206d : e5 05 __ SBC WORK + 2 
206f : 90 13 __ BCC $2084 ; (fdiv + 72)
2071 : a5 1b __ LDA ACCU + 0 
2073 : e5 03 __ SBC WORK + 0 
2075 : 85 1b __ STA ACCU + 0 
2077 : a5 1c __ LDA ACCU + 1 
2079 : e5 04 __ SBC WORK + 1 
207b : 85 1c __ STA ACCU + 1 
207d : a5 1d __ LDA ACCU + 2 
207f : e5 05 __ SBC WORK + 2 
2081 : 85 1d __ STA ACCU + 2 
2083 : 38 __ __ SEC
2084 : 26 09 __ ROL WORK + 6 
2086 : 26 0a __ ROL WORK + 7 
2088 : 26 0b __ ROL $0b 
208a : ca __ __ DEX
208b : f0 0a __ BEQ $2097 ; (fdiv + 91)
208d : 06 1b __ ASL ACCU + 0 
208f : 26 1c __ ROL ACCU + 1 
2091 : 26 1d __ ROL ACCU + 2 
2093 : b0 dc __ BCS $2071 ; (fdiv + 53)
2095 : 90 cc __ BCC $2063 ; (fdiv + 39)
2097 : 38 __ __ SEC
2098 : a5 0b __ LDA $0b 
209a : 30 06 __ BMI $20a2 ; (fdiv + 102)
209c : 06 09 __ ASL WORK + 6 
209e : 26 0a __ ROL WORK + 7 
20a0 : 2a __ __ ROL
20a1 : 18 __ __ CLC
20a2 : 29 7f __ AND #$7f
20a4 : 85 0b __ STA $0b 
20a6 : a5 07 __ LDA WORK + 4 
20a8 : e5 08 __ SBC WORK + 5 
20aa : 90 1a __ BCC $20c6 ; (fdiv + 138)
20ac : 18 __ __ CLC
20ad : 69 7f __ ADC #$7f
20af : b0 04 __ BCS $20b5 ; (fdiv + 121)
20b1 : c9 ff __ CMP #$ff
20b3 : d0 15 __ BNE $20ca ; (fdiv + 142)
20b5 : a5 1e __ LDA ACCU + 3 
20b7 : 09 7f __ ORA #$7f
20b9 : 85 1e __ STA ACCU + 3 
20bb : a9 80 __ LDA #$80
20bd : 85 1d __ STA ACCU + 2 
20bf : a9 00 __ LDA #$00
20c1 : 85 1c __ STA ACCU + 1 
20c3 : 85 1b __ STA ACCU + 0 
20c5 : 60 __ __ RTS
20c6 : 69 7f __ ADC #$7f
20c8 : 90 15 __ BCC $20df ; (fdiv + 163)
20ca : 4a __ __ LSR
20cb : 05 1e __ ORA ACCU + 3 
20cd : 85 1e __ STA ACCU + 3 
20cf : a9 00 __ LDA #$00
20d1 : 6a __ __ ROR
20d2 : 05 0b __ ORA $0b 
20d4 : 85 1d __ STA ACCU + 2 
20d6 : a5 0a __ LDA WORK + 7 
20d8 : 85 1c __ STA ACCU + 1 
20da : a5 09 __ LDA WORK + 6 
20dc : 85 1b __ STA ACCU + 0 
20de : 60 __ __ RTS
20df : a9 00 __ LDA #$00
20e1 : 85 1e __ STA ACCU + 3 
20e3 : 85 1d __ STA ACCU + 2 
20e5 : 85 1c __ STA ACCU + 1 
20e7 : 85 1b __ STA ACCU + 0 
20e9 : 60 __ __ RTS
--------------------------------------------------------------------
divs16:
20ea : 24 1c __ BIT ACCU + 1 
20ec : 10 0d __ BPL $20fb ; (divs16 + 17)
20ee : 20 08 21 JSR $2108 ; (negaccu + 0)
20f1 : 24 04 __ BIT WORK + 1 
20f3 : 10 0d __ BPL $2102 ; (divs16 + 24)
20f5 : 20 16 21 JSR $2116 ; (negtmp + 0)
20f8 : 4c 24 21 JMP $2124 ; (divmod + 0)
20fb : 24 04 __ BIT WORK + 1 
20fd : 10 f9 __ BPL $20f8 ; (divs16 + 14)
20ff : 20 16 21 JSR $2116 ; (negtmp + 0)
2102 : 20 24 21 JSR $2124 ; (divmod + 0)
2105 : 4c 08 21 JMP $2108 ; (negaccu + 0)
--------------------------------------------------------------------
negaccu:
2108 : 38 __ __ SEC
2109 : a9 00 __ LDA #$00
210b : e5 1b __ SBC ACCU + 0 
210d : 85 1b __ STA ACCU + 0 
210f : a9 00 __ LDA #$00
2111 : e5 1c __ SBC ACCU + 1 
2113 : 85 1c __ STA ACCU + 1 
2115 : 60 __ __ RTS
--------------------------------------------------------------------
negtmp:
2116 : 38 __ __ SEC
2117 : a9 00 __ LDA #$00
2119 : e5 03 __ SBC WORK + 0 
211b : 85 03 __ STA WORK + 0 
211d : a9 00 __ LDA #$00
211f : e5 04 __ SBC WORK + 1 
2121 : 85 04 __ STA WORK + 1 
2123 : 60 __ __ RTS
--------------------------------------------------------------------
divmod:
2124 : a5 1c __ LDA ACCU + 1 
2126 : d0 31 __ BNE $2159 ; (divmod + 53)
2128 : a5 04 __ LDA WORK + 1 
212a : d0 1e __ BNE $214a ; (divmod + 38)
212c : 85 06 __ STA WORK + 3 
212e : a2 04 __ LDX #$04
2130 : 06 1b __ ASL ACCU + 0 
2132 : 2a __ __ ROL
2133 : c5 03 __ CMP WORK + 0 
2135 : 90 02 __ BCC $2139 ; (divmod + 21)
2137 : e5 03 __ SBC WORK + 0 
2139 : 26 1b __ ROL ACCU + 0 
213b : 2a __ __ ROL
213c : c5 03 __ CMP WORK + 0 
213e : 90 02 __ BCC $2142 ; (divmod + 30)
2140 : e5 03 __ SBC WORK + 0 
2142 : 26 1b __ ROL ACCU + 0 
2144 : ca __ __ DEX
2145 : d0 eb __ BNE $2132 ; (divmod + 14)
2147 : 85 05 __ STA WORK + 2 
2149 : 60 __ __ RTS
214a : a5 1b __ LDA ACCU + 0 
214c : 85 05 __ STA WORK + 2 
214e : a5 1c __ LDA ACCU + 1 
2150 : 85 06 __ STA WORK + 3 
2152 : a9 00 __ LDA #$00
2154 : 85 1b __ STA ACCU + 0 
2156 : 85 1c __ STA ACCU + 1 
2158 : 60 __ __ RTS
2159 : a5 04 __ LDA WORK + 1 
215b : d0 1f __ BNE $217c ; (divmod + 88)
215d : a5 03 __ LDA WORK + 0 
215f : 30 1b __ BMI $217c ; (divmod + 88)
2161 : a9 00 __ LDA #$00
2163 : 85 06 __ STA WORK + 3 
2165 : a2 10 __ LDX #$10
2167 : 06 1b __ ASL ACCU + 0 
2169 : 26 1c __ ROL ACCU + 1 
216b : 2a __ __ ROL
216c : c5 03 __ CMP WORK + 0 
216e : 90 02 __ BCC $2172 ; (divmod + 78)
2170 : e5 03 __ SBC WORK + 0 
2172 : 26 1b __ ROL ACCU + 0 
2174 : 26 1c __ ROL ACCU + 1 
2176 : ca __ __ DEX
2177 : d0 f2 __ BNE $216b ; (divmod + 71)
2179 : 85 05 __ STA WORK + 2 
217b : 60 __ __ RTS
217c : a9 00 __ LDA #$00
217e : 85 05 __ STA WORK + 2 
2180 : 85 06 __ STA WORK + 3 
2182 : 84 02 __ STY $02 
2184 : a0 10 __ LDY #$10
2186 : 18 __ __ CLC
2187 : 26 1b __ ROL ACCU + 0 
2189 : 26 1c __ ROL ACCU + 1 
218b : 26 05 __ ROL WORK + 2 
218d : 26 06 __ ROL WORK + 3 
218f : 38 __ __ SEC
2190 : a5 05 __ LDA WORK + 2 
2192 : e5 03 __ SBC WORK + 0 
2194 : aa __ __ TAX
2195 : a5 06 __ LDA WORK + 3 
2197 : e5 04 __ SBC WORK + 1 
2199 : 90 04 __ BCC $219f ; (divmod + 123)
219b : 86 05 __ STX WORK + 2 
219d : 85 06 __ STA WORK + 3 
219f : 88 __ __ DEY
21a0 : d0 e5 __ BNE $2187 ; (divmod + 99)
21a2 : 26 1b __ ROL ACCU + 0 
21a4 : 26 1c __ ROL ACCU + 1 
21a6 : a4 02 __ LDY $02 
21a8 : 60 __ __ RTS
--------------------------------------------------------------------
mods16:
21a9 : 24 1c __ BIT ACCU + 1 
21ab : 10 0d __ BPL $21ba ; (mods16 + 17)
21ad : 20 08 21 JSR $2108 ; (negaccu + 0)
21b0 : 24 04 __ BIT WORK + 1 
21b2 : 10 0d __ BPL $21c1 ; (mods16 + 24)
21b4 : 20 16 21 JSR $2116 ; (negtmp + 0)
21b7 : 4c 24 21 JMP $2124 ; (divmod + 0)
21ba : 24 04 __ BIT WORK + 1 
21bc : 10 f9 __ BPL $21b7 ; (mods16 + 14)
21be : 20 16 21 JSR $2116 ; (negtmp + 0)
21c1 : 20 24 21 JSR $2124 ; (divmod + 0)
21c4 : 38 __ __ SEC
21c5 : a9 00 __ LDA #$00
21c7 : e5 05 __ SBC WORK + 2 
21c9 : 85 05 __ STA WORK + 2 
21cb : a9 00 __ LDA #$00
21cd : e5 06 __ SBC WORK + 3 
21cf : 85 06 __ STA WORK + 3 
21d1 : 60 __ __ RTS
--------------------------------------------------------------------
f32_to_i16:
21d2 : 20 65 1e JSR $1e65 ; (freg + 36)
21d5 : a5 07 __ LDA WORK + 4 
21d7 : c9 7f __ CMP #$7f
21d9 : b0 07 __ BCS $21e2 ; (f32_to_i16 + 16)
21db : a9 00 __ LDA #$00
21dd : 85 1b __ STA ACCU + 0 
21df : 85 1c __ STA ACCU + 1 
21e1 : 60 __ __ RTS
21e2 : 38 __ __ SEC
21e3 : e9 8e __ SBC #$8e
21e5 : 90 0a __ BCC $21f1 ; (f32_to_i16 + 31)
21e7 : a9 ff __ LDA #$ff
21e9 : 85 1b __ STA ACCU + 0 
21eb : a9 7f __ LDA #$7f
21ed : 85 1c __ STA ACCU + 1 
21ef : d0 08 __ BNE $21f9 ; (f32_to_i16 + 39)
21f1 : aa __ __ TAX
21f2 : 46 1d __ LSR ACCU + 2 
21f4 : 66 1c __ ROR ACCU + 1 
21f6 : e8 __ __ INX
21f7 : d0 f9 __ BNE $21f2 ; (f32_to_i16 + 32)
21f9 : 24 1e __ BIT ACCU + 3 
21fb : 10 0e __ BPL $220b ; (f32_to_i16 + 57)
21fd : 38 __ __ SEC
21fe : a9 00 __ LDA #$00
2200 : e5 1c __ SBC ACCU + 1 
2202 : 85 1b __ STA ACCU + 0 
2204 : a9 00 __ LDA #$00
2206 : e5 1d __ SBC ACCU + 2 
2208 : 85 1c __ STA ACCU + 1 
220a : 60 __ __ RTS
220b : a5 1c __ LDA ACCU + 1 
220d : 85 1b __ STA ACCU + 0 
220f : a5 1d __ LDA ACCU + 2 
2211 : 85 1c __ STA ACCU + 1 
2213 : 60 __ __ RTS
--------------------------------------------------------------------
sint16_to_float:
2214 : 24 1c __ BIT ACCU + 1 
2216 : 30 03 __ BMI $221b ; (sint16_to_float + 7)
2218 : 4c 32 22 JMP $2232 ; (uint16_to_float + 0)
221b : 38 __ __ SEC
221c : a9 00 __ LDA #$00
221e : e5 1b __ SBC ACCU + 0 
2220 : 85 1b __ STA ACCU + 0 
2222 : a9 00 __ LDA #$00
2224 : e5 1c __ SBC ACCU + 1 
2226 : 85 1c __ STA ACCU + 1 
2228 : 20 32 22 JSR $2232 ; (uint16_to_float + 0)
222b : a5 1e __ LDA ACCU + 3 
222d : 09 80 __ ORA #$80
222f : 85 1e __ STA ACCU + 3 
2231 : 60 __ __ RTS
--------------------------------------------------------------------
uint16_to_float:
2232 : a5 1b __ LDA ACCU + 0 
2234 : 05 1c __ ORA ACCU + 1 
2236 : d0 05 __ BNE $223d ; (uint16_to_float + 11)
2238 : 85 1d __ STA ACCU + 2 
223a : 85 1e __ STA ACCU + 3 
223c : 60 __ __ RTS
223d : a2 8e __ LDX #$8e
223f : a5 1c __ LDA ACCU + 1 
2241 : 30 06 __ BMI $2249 ; (uint16_to_float + 23)
2243 : ca __ __ DEX
2244 : 06 1b __ ASL ACCU + 0 
2246 : 2a __ __ ROL
2247 : 10 fa __ BPL $2243 ; (uint16_to_float + 17)
2249 : 29 7f __ AND #$7f
224b : 85 1d __ STA ACCU + 2 
224d : a5 1b __ LDA ACCU + 0 
224f : 85 1c __ STA ACCU + 1 
2251 : 8a __ __ TXA
2252 : 4a __ __ LSR
2253 : 85 1e __ STA ACCU + 3 
2255 : a9 00 __ LDA #$00
2257 : 85 1b __ STA ACCU + 0 
2259 : 6a __ __ ROR
225a : 05 1d __ ORA ACCU + 2 
225c : 85 1d __ STA ACCU + 2 
225e : 60 __ __ RTS
--------------------------------------------------------------------
divmod32:
225f : 84 02 __ STY $02 
2261 : a0 20 __ LDY #$20
2263 : a9 00 __ LDA #$00
2265 : 85 07 __ STA WORK + 4 
2267 : 85 08 __ STA WORK + 5 
2269 : 85 09 __ STA WORK + 6 
226b : 85 0a __ STA WORK + 7 
226d : a5 05 __ LDA WORK + 2 
226f : 05 06 __ ORA WORK + 3 
2271 : d0 39 __ BNE $22ac ; (divmod32 + 77)
2273 : 18 __ __ CLC
2274 : 26 1b __ ROL ACCU + 0 
2276 : 26 1c __ ROL ACCU + 1 
2278 : 26 1d __ ROL ACCU + 2 
227a : 26 1e __ ROL ACCU + 3 
227c : 26 07 __ ROL WORK + 4 
227e : 26 08 __ ROL WORK + 5 
2280 : 90 0c __ BCC $228e ; (divmod32 + 47)
2282 : a5 07 __ LDA WORK + 4 
2284 : e5 03 __ SBC WORK + 0 
2286 : aa __ __ TAX
2287 : a5 08 __ LDA WORK + 5 
2289 : e5 04 __ SBC WORK + 1 
228b : 38 __ __ SEC
228c : b0 0c __ BCS $229a ; (divmod32 + 59)
228e : 38 __ __ SEC
228f : a5 07 __ LDA WORK + 4 
2291 : e5 03 __ SBC WORK + 0 
2293 : aa __ __ TAX
2294 : a5 08 __ LDA WORK + 5 
2296 : e5 04 __ SBC WORK + 1 
2298 : 90 04 __ BCC $229e ; (divmod32 + 63)
229a : 86 07 __ STX WORK + 4 
229c : 85 08 __ STA WORK + 5 
229e : 88 __ __ DEY
229f : d0 d3 __ BNE $2274 ; (divmod32 + 21)
22a1 : 26 1b __ ROL ACCU + 0 
22a3 : 26 1c __ ROL ACCU + 1 
22a5 : 26 1d __ ROL ACCU + 2 
22a7 : 26 1e __ ROL ACCU + 3 
22a9 : a4 02 __ LDY $02 
22ab : 60 __ __ RTS
22ac : 18 __ __ CLC
22ad : 26 1b __ ROL ACCU + 0 
22af : 26 1c __ ROL ACCU + 1 
22b1 : 26 1d __ ROL ACCU + 2 
22b3 : 26 1e __ ROL ACCU + 3 
22b5 : 26 07 __ ROL WORK + 4 
22b7 : 26 08 __ ROL WORK + 5 
22b9 : 26 09 __ ROL WORK + 6 
22bb : 26 0a __ ROL WORK + 7 
22bd : a5 07 __ LDA WORK + 4 
22bf : c5 03 __ CMP WORK + 0 
22c1 : a5 08 __ LDA WORK + 5 
22c3 : e5 04 __ SBC WORK + 1 
22c5 : a5 09 __ LDA WORK + 6 
22c7 : e5 05 __ SBC WORK + 2 
22c9 : a5 0a __ LDA WORK + 7 
22cb : e5 06 __ SBC WORK + 3 
22cd : 90 18 __ BCC $22e7 ; (divmod32 + 136)
22cf : a5 07 __ LDA WORK + 4 
22d1 : e5 03 __ SBC WORK + 0 
22d3 : 85 07 __ STA WORK + 4 
22d5 : a5 08 __ LDA WORK + 5 
22d7 : e5 04 __ SBC WORK + 1 
22d9 : 85 08 __ STA WORK + 5 
22db : a5 09 __ LDA WORK + 6 
22dd : e5 05 __ SBC WORK + 2 
22df : 85 09 __ STA WORK + 6 
22e1 : a5 0a __ LDA WORK + 7 
22e3 : e5 06 __ SBC WORK + 3 
22e5 : 85 0a __ STA WORK + 7 
22e7 : 88 __ __ DEY
22e8 : d0 c3 __ BNE $22ad ; (divmod32 + 78)
22ea : 26 1b __ ROL ACCU + 0 
22ec : 26 1c __ ROL ACCU + 1 
22ee : 26 1d __ ROL ACCU + 2 
22f0 : 26 1e __ ROL ACCU + 3 
22f2 : a4 02 __ LDY $02 
22f4 : 60 __ __ RTS
--------------------------------------------------------------------
__multab3L:
22f5 : __ __ __ BYT 00 03 06                                        : ...
