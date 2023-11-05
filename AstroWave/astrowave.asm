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
080e : 8e 7f 24 STX $247f ; (spentry + 0)
0811 : a9 1c __ LDA #$1c
0813 : 85 19 __ STA IP + 0 
0815 : a9 25 __ LDA #$25
0817 : 85 1a __ STA IP + 1 
0819 : 38 __ __ SEC
081a : a9 25 __ LDA #$25
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
0830 : a9 65 __ LDA #$65
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
247f : __ __ __ BYT 00                                              : .
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
0897 : ad f8 24 LDA $24f8 ; (game + 0)
089a : d0 52 __ BNE $08ee ; (main.s4 + 0)
.s9:
089c : 85 53 __ STA T0 + 0 
.l3:
089e : 20 39 0b JSR $0b39 ; (render_game_state.s1000 + 0)
08a1 : a5 53 __ LDA T0 + 0 
08a3 : 85 1b __ STA ACCU + 0 
08a5 : a9 00 __ LDA #$00
08a7 : 85 1c __ STA ACCU + 1 
08a9 : 85 04 __ STA WORK + 1 
08ab : a9 03 __ LDA #$03
08ad : 85 03 __ STA WORK + 0 
08af : 20 a1 22 JSR $22a1 ; (divmod + 0)
08b2 : a5 05 __ LDA WORK + 2 
08b4 : 05 06 __ ORA WORK + 3 
08b6 : d0 09 __ BNE $08c1 ; (main.s7 + 0)
.s5:
08b8 : 20 e1 18 JSR $18e1 ; (spawn_enemy.s0 + 0)
08bb : 20 78 19 JSR $1978 ; (move_enemies.s1000 + 0)
08be : 20 ba 1b JSR $1bba ; (render_enemies.s0 + 0)
.s7:
08c1 : 20 17 1c JSR $1c17 ; (move_enemy_shots.s0 + 0)
08c4 : 20 65 1b JSR $1b65 ; (render_enemy_shots.s0 + 0)
08c7 : 20 81 1c JSR $1c81 ; (check_player_enemy_collision.s0 + 0)
08ca : 20 d1 1c JSR $1cd1 ; (control_player_ship.s0 + 0)
08cd : 20 ef 1d JSR $1def ; (render_player_ship.s0 + 0)
08d0 : 20 81 1c JSR $1c81 ; (check_player_enemy_collision.s0 + 0)
08d3 : 20 2f 1e JSR $1e2f ; (move_player_shots.s0 + 0)
08d6 : 20 97 1e JSR $1e97 ; (render_player_shots.s0 + 0)
08d9 : 20 ec 1e JSR $1eec ; (check_shot_enemy_collision.s0 + 0)
08dc : a9 03 __ LDA #$03
08de : 85 0d __ STA P0 
08e0 : a9 00 __ LDA #$00
08e2 : 85 0e __ STA P1 
08e4 : 20 9d 1f JSR $1f9d ; (wait_frames.s0 + 0)
08e7 : e6 53 __ INC T0 + 0 
08e9 : ad f8 24 LDA $24f8 ; (game + 0)
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
091a : bd 7f 24 LDA $247f,x ; (spentry + 0)
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
2480 : __ __ __ BYT 80 e0 f8 7f 7f f8 e0 80 00 00 60 3e 3e 60 00 00 : ..........`>>`..
2490 : __ __ __ BYT 00 00 3c 66 66 3c 00 00 1c 7f c6 1f 1f c6 7f 1c : ..<ff<..........
24a0 : __ __ __ BYT 00 3c 7e d5 ab 7e 3c 00 28 3c 6e df 5f fe 3c 14 : .<~..~<.(<n._.<.
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
0a0c : 8d ed 24 STA $24ed ; (Player + 0)
0a0f : a9 0c __ LDA #$0c
0a11 : 8d ee 24 STA $24ee ; (Player + 1)
.s1001:
0a14 : 60 __ __ RTS
--------------------------------------------------------------------
Player:
24ed : __ __ __ BSS	2
--------------------------------------------------------------------
init_enemies:
.s0:
0a15 : a2 00 __ LDX #$00
0a17 : a0 0a __ LDY #$0a
.l1002:
0a19 : a9 00 __ LDA #$00
0a1b : 9d 1c 25 STA $251c,x ; (Enemy + 0)
0a1e : 9d 1d 25 STA $251d,x ; (Enemy + 1)
0a21 : 9d 20 25 STA $2520,x ; (Enemy + 4)
0a24 : 8a __ __ TXA
0a25 : 18 __ __ CLC
0a26 : 69 05 __ ADC #$05
0a28 : aa __ __ TAX
0a29 : 88 __ __ DEY
0a2a : d0 ed __ BNE $0a19 ; (init_enemies.l1002 + 0)
.s1001:
0a2c : 60 __ __ RTS
--------------------------------------------------------------------
Enemy:
251c : __ __ __ BSS	50
--------------------------------------------------------------------
init_shots:
.s0:
0a2d : a2 00 __ LDX #$00
0a2f : a0 03 __ LDY #$03
0a31 : 8a __ __ TXA
.l1006:
0a32 : 9d ef 24 STA $24ef,x ; (PlayerShot + 0)
0a35 : 9d f0 24 STA $24f0,x ; (PlayerShot + 1)
0a38 : 9d f1 24 STA $24f1,x ; (PlayerShot + 2)
0a3b : e8 __ __ INX
0a3c : e8 __ __ INX
0a3d : e8 __ __ INX
0a3e : 88 __ __ DEY
0a3f : d0 f1 __ BNE $0a32 ; (init_shots.l1006 + 0)
.s6:
0a41 : a0 03 __ LDY #$03
0a43 : aa __ __ TAX
.l1008:
0a44 : 9d 4e 25 STA $254e,x ; (EnemyShot + 0)
0a47 : 9d 4f 25 STA $254f,x ; (EnemyShot + 1)
0a4a : 9d 50 25 STA $2550,x ; (EnemyShot + 2)
0a4d : e8 __ __ INX
0a4e : e8 __ __ INX
0a4f : e8 __ __ INX
0a50 : 88 __ __ DEY
0a51 : d0 f1 __ BNE $0a44 ; (init_shots.l1008 + 0)
.s1001:
0a53 : 60 __ __ RTS
--------------------------------------------------------------------
PlayerShot:
24ef : __ __ __ BSS	9
--------------------------------------------------------------------
EnemyShot:
254e : __ __ __ BSS	9
--------------------------------------------------------------------
init_game_state:
.s0:
0a54 : a9 00 __ LDA #$00
0a56 : 8d f8 24 STA $24f8 ; (game + 0)
0a59 : 8d f9 24 STA $24f9 ; (game + 1)
0a5c : 8d fa 24 STA $24fa ; (game + 2)
0a5f : 8d fb 24 STA $24fb ; (game + 3)
0a62 : 8d fc 24 STA $24fc ; (game + 4)
.s1001:
0a65 : 60 __ __ RTS
--------------------------------------------------------------------
game:
24f8 : __ __ __ BSS	5
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
0a7c : 20 bf 0a JSR $0abf ; (memset.s0 + 0)
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
0a93 : 20 bf 0a JSR $0abf ; (memset.s0 + 0)
0a96 : a9 0b __ LDA #$0b
0a98 : 8d 20 d0 STA $d020 
0a9b : a9 00 __ LDA #$00
0a9d : 8d 21 d0 STA $d021 
0aa0 : 85 0f __ STA P2 
0aa2 : a9 c0 __ LDA #$c0
0aa4 : 85 10 __ STA P3 
0aa6 : a9 00 __ LDA #$00
0aa8 : 85 11 __ STA P4 
0aaa : 85 12 __ STA P5 
0aac : a9 28 __ LDA #$28
0aae : 85 13 __ STA P6 
0ab0 : a9 03 __ LDA #$03
0ab2 : 85 14 __ STA P7 
0ab4 : a9 57 __ LDA #$57
0ab6 : 85 0d __ STA P0 
0ab8 : a9 25 __ LDA #$25
0aba : 85 0e __ STA P1 
0abc : 4c e3 0a JMP $0ae3 ; (cwin_init.s0 + 0)
--------------------------------------------------------------------
memset:
.s0:
0abf : a5 0f __ LDA P2 
0ac1 : a6 12 __ LDX P5 
0ac3 : f0 0c __ BEQ $0ad1 ; (memset.s0 + 18)
0ac5 : a0 00 __ LDY #$00
0ac7 : 91 0d __ STA (P0),y ; (dst + 0)
0ac9 : c8 __ __ INY
0aca : d0 fb __ BNE $0ac7 ; (memset.s0 + 8)
0acc : e6 0e __ INC P1 ; (dst + 1)
0ace : ca __ __ DEX
0acf : d0 f6 __ BNE $0ac7 ; (memset.s0 + 8)
0ad1 : a4 11 __ LDY P4 
0ad3 : f0 05 __ BEQ $0ada ; (memset.s0 + 27)
0ad5 : 88 __ __ DEY
0ad6 : 91 0d __ STA (P0),y ; (dst + 0)
0ad8 : d0 fb __ BNE $0ad5 ; (memset.s0 + 22)
0ada : a5 0d __ LDA P0 ; (dst + 0)
0adc : 85 1b __ STA ACCU + 0 
0ade : a5 0e __ LDA P1 ; (dst + 1)
0ae0 : 85 1c __ STA ACCU + 1 
.s1001:
0ae2 : 60 __ __ RTS
--------------------------------------------------------------------
cwin_init:
.s0:
0ae3 : a9 00 __ LDA #$00
0ae5 : a0 04 __ LDY #$04
0ae7 : 91 0d __ STA (P0),y ; (win + 0)
0ae9 : c8 __ __ INY
0aea : 91 0d __ STA (P0),y ; (win + 0)
0aec : a5 11 __ LDA P4 ; (sx + 0)
0aee : a0 00 __ LDY #$00
0af0 : 91 0d __ STA (P0),y ; (win + 0)
0af2 : a5 12 __ LDA P5 ; (sy + 0)
0af4 : c8 __ __ INY
0af5 : 91 0d __ STA (P0),y ; (win + 0)
0af7 : a5 13 __ LDA P6 ; (wx + 0)
0af9 : c8 __ __ INY
0afa : 91 0d __ STA (P0),y ; (win + 0)
0afc : a5 14 __ LDA P7 ; (wy + 0)
0afe : c8 __ __ INY
0aff : 91 0d __ STA (P0),y ; (win + 0)
0b01 : a5 12 __ LDA P5 ; (sy + 0)
0b03 : 0a __ __ ASL
0b04 : a8 __ __ TAY
0b05 : b9 b0 24 LDA $24b0,y ; (mul40 + 0)
0b08 : 85 1b __ STA ACCU + 0 
0b0a : 18 __ __ CLC
0b0b : 65 11 __ ADC P4 ; (sx + 0)
0b0d : aa __ __ TAX
0b0e : b9 b1 24 LDA $24b1,y ; (mul40 + 1)
0b11 : 85 1c __ STA ACCU + 1 
0b13 : 69 d8 __ ADC #$d8
0b15 : a0 09 __ LDY #$09
0b17 : 91 0d __ STA (P0),y ; (win + 0)
0b19 : 8a __ __ TXA
0b1a : 88 __ __ DEY
0b1b : 91 0d __ STA (P0),y ; (win + 0)
0b1d : 18 __ __ CLC
0b1e : a5 0f __ LDA P2 ; (screen + 0)
0b20 : 65 1b __ ADC ACCU + 0 
0b22 : aa __ __ TAX
0b23 : a5 10 __ LDA P3 ; (screen + 1)
0b25 : 65 1c __ ADC ACCU + 1 
0b27 : 85 10 __ STA P3 ; (screen + 1)
0b29 : 8a __ __ TXA
0b2a : 18 __ __ CLC
0b2b : 65 11 __ ADC P4 ; (sx + 0)
0b2d : a0 06 __ LDY #$06
0b2f : 91 0d __ STA (P0),y ; (win + 0)
0b31 : a5 10 __ LDA P3 ; (screen + 1)
0b33 : 69 00 __ ADC #$00
0b35 : c8 __ __ INY
0b36 : 91 0d __ STA (P0),y ; (win + 0)
.s1001:
0b38 : 60 __ __ RTS
--------------------------------------------------------------------
mul40:
24b0 : __ __ __ BYT 00 00 28 00 50 00 78 00 a0 00 c8 00 f0 00 18 01 : ..(.P.x.........
24c0 : __ __ __ BYT 40 01 68 01 90 01 b8 01 e0 01 08 02 30 02 58 02 : @.h.........0.X.
24d0 : __ __ __ BYT 80 02 a8 02 d0 02 f8 02 20 03 48 03 70 03 98 03 : ........ .H.p...
24e0 : __ __ __ BYT c0 03                                           : ..
--------------------------------------------------------------------
cwTop:
2557 : __ __ __ BSS	10
--------------------------------------------------------------------
render_game_state:
.s1000:
0b39 : 38 __ __ SEC
0b3a : a5 23 __ LDA SP + 0 
0b3c : e9 0a __ SBC #$0a
0b3e : 85 23 __ STA SP + 0 
0b40 : b0 02 __ BCS $0b44 ; (render_game_state.s0 + 0)
0b42 : c6 24 __ DEC SP + 1 
.s0:
0b44 : a9 01 __ LDA #$01
0b46 : 85 0f __ STA P2 
0b48 : a9 02 __ LDA #$02
0b4a : 85 10 __ STA P3 
0b4c : a9 05 __ LDA #$05
0b4e : 85 13 __ STA P6 
0b50 : a9 57 __ LDA #$57
0b52 : 85 0d __ STA P0 
0b54 : a9 25 __ LDA #$25
0b56 : 85 0e __ STA P1 
0b58 : a9 10 __ LDA #$10
0b5a : 85 11 __ STA P4 
0b5c : a9 0c __ LDA #$0c
0b5e : 85 12 __ STA P5 
0b60 : 20 be 0b JSR $0bbe ; (cwin_putat_string.s0 + 0)
0b63 : a9 cc __ LDA #$cc
0b65 : a0 02 __ LDY #$02
0b67 : 91 23 __ STA (SP + 0),y 
0b69 : a9 9f __ LDA #$9f
0b6b : c8 __ __ INY
0b6c : 91 23 __ STA (SP + 0),y 
0b6e : a9 de __ LDA #$de
0b70 : c8 __ __ INY
0b71 : 91 23 __ STA (SP + 0),y 
0b73 : a9 18 __ LDA #$18
0b75 : c8 __ __ INY
0b76 : 91 23 __ STA (SP + 0),y 
0b78 : ad f9 24 LDA $24f9 ; (game + 1)
0b7b : c8 __ __ INY
0b7c : 91 23 __ STA (SP + 0),y 
0b7e : ad fa 24 LDA $24fa ; (game + 2)
0b81 : c8 __ __ INY
0b82 : 91 23 __ STA (SP + 0),y 
0b84 : ad fb 24 LDA $24fb ; (game + 3)
0b87 : c8 __ __ INY
0b88 : 91 23 __ STA (SP + 0),y 
0b8a : ad fc 24 LDA $24fc ; (game + 4)
0b8d : c8 __ __ INY
0b8e : 91 23 __ STA (SP + 0),y 
0b90 : 20 17 0c JSR $0c17 ; (sprintf.s1000 + 0)
0b93 : a9 57 __ LDA #$57
0b95 : 85 0d __ STA P0 
0b97 : a9 25 __ LDA #$25
0b99 : 85 0e __ STA P1 
0b9b : a9 08 __ LDA #$08
0b9d : 85 0f __ STA P2 
0b9f : a9 02 __ LDA #$02
0ba1 : 85 10 __ STA P3 
0ba3 : a9 cc __ LDA #$cc
0ba5 : 85 11 __ STA P4 
0ba7 : a9 9f __ LDA #$9f
0ba9 : 85 12 __ STA P5 
0bab : a9 05 __ LDA #$05
0bad : 85 13 __ STA P6 
0baf : 20 be 0b JSR $0bbe ; (cwin_putat_string.s0 + 0)
.s1001:
0bb2 : 18 __ __ CLC
0bb3 : a5 23 __ LDA SP + 0 
0bb5 : 69 0a __ ADC #$0a
0bb7 : 85 23 __ STA SP + 0 
0bb9 : 90 02 __ BCC $0bbd ; (render_game_state.s1001 + 11)
0bbb : e6 24 __ INC SP + 1 
0bbd : 60 __ __ RTS
--------------------------------------------------------------------
cwin_putat_string:
.s0:
0bbe : a5 10 __ LDA P3 ; (y + 0)
0bc0 : 0a __ __ ASL
0bc1 : aa __ __ TAX
0bc2 : bd b0 24 LDA $24b0,x ; (mul40 + 0)
0bc5 : 18 __ __ CLC
0bc6 : 65 0f __ ADC P2 ; (x + 0)
0bc8 : 85 1b __ STA ACCU + 0 
0bca : bd b1 24 LDA $24b1,x ; (mul40 + 1)
0bcd : 69 00 __ ADC #$00
0bcf : 85 1c __ STA ACCU + 1 
0bd1 : a0 06 __ LDY #$06
0bd3 : b1 0d __ LDA (P0),y ; (win + 0)
0bd5 : 18 __ __ CLC
0bd6 : 65 1b __ ADC ACCU + 0 
0bd8 : 85 43 __ STA T3 + 0 
0bda : c8 __ __ INY
0bdb : b1 0d __ LDA (P0),y ; (win + 0)
0bdd : 65 1c __ ADC ACCU + 1 
0bdf : 85 44 __ STA T3 + 1 
0be1 : c8 __ __ INY
0be2 : b1 0d __ LDA (P0),y ; (win + 0)
0be4 : 18 __ __ CLC
0be5 : 65 1b __ ADC ACCU + 0 
0be7 : 85 1b __ STA ACCU + 0 
0be9 : c8 __ __ INY
0bea : b1 0d __ LDA (P0),y ; (win + 0)
0bec : 65 1c __ ADC ACCU + 1 
0bee : 85 1c __ STA ACCU + 1 
0bf0 : a0 00 __ LDY #$00
0bf2 : b1 11 __ LDA (P4),y ; (str + 0)
0bf4 : f0 18 __ BEQ $0c0e ; (cwin_putat_string.s3 + 0)
.l2:
0bf6 : 85 1d __ STA ACCU + 2 
0bf8 : 4a __ __ LSR
0bf9 : 4a __ __ LSR
0bfa : 4a __ __ LSR
0bfb : 4a __ __ LSR
0bfc : 4a __ __ LSR
0bfd : aa __ __ TAX
0bfe : bd e2 24 LDA $24e2,x ; (p2smap + 0)
0c01 : 45 1d __ EOR ACCU + 2 
0c03 : 91 43 __ STA (T3 + 0),y 
0c05 : a5 13 __ LDA P6 ; (color + 0)
0c07 : 91 1b __ STA (ACCU + 0),y 
0c09 : c8 __ __ INY
0c0a : b1 11 __ LDA (P4),y ; (str + 0)
0c0c : d0 e8 __ BNE $0bf6 ; (cwin_putat_string.l2 + 0)
.s3:
0c0e : 98 __ __ TYA
.s1001:
0c0f : 60 __ __ RTS
--------------------------------------------------------------------
p2smap:
24e2 : __ __ __ BYT 00 00 40 20 80 c0 80 80                         : ..@ ....
--------------------------------------------------------------------
0c10 : __ __ __ BYT 53 43 4f 52 45 3a 00                            : SCORE:.
--------------------------------------------------------------------
sprintf:
.s1000:
0c17 : a5 53 __ LDA T0 + 0 
0c19 : 8d d6 9f STA $9fd6 ; (sprintf@stack + 0)
0c1c : a5 54 __ LDA T0 + 1 
0c1e : 8d d7 9f STA $9fd7 ; (sprintf@stack + 1)
.s0:
0c21 : a9 00 __ LDA #$00
0c23 : 8d fd 9f STA $9ffd ; (sstack + 7)
0c26 : a0 03 __ LDY #$03
0c28 : b1 23 __ LDA (SP + 0),y 
0c2a : 85 54 __ STA T0 + 1 
0c2c : 8d f8 9f STA $9ff8 ; (sstack + 2)
0c2f : 88 __ __ DEY
0c30 : b1 23 __ LDA (SP + 0),y 
0c32 : 85 53 __ STA T0 + 0 
0c34 : 8d f7 9f STA $9ff7 ; (sstack + 1)
0c37 : a0 04 __ LDY #$04
0c39 : b1 23 __ LDA (SP + 0),y 
0c3b : 8d f9 9f STA $9ff9 ; (sstack + 3)
0c3e : c8 __ __ INY
0c3f : b1 23 __ LDA (SP + 0),y 
0c41 : 8d fa 9f STA $9ffa ; (sstack + 4)
0c44 : 18 __ __ CLC
0c45 : a5 23 __ LDA SP + 0 
0c47 : 69 06 __ ADC #$06
0c49 : 8d fb 9f STA $9ffb ; (sstack + 5)
0c4c : a5 24 __ LDA SP + 1 
0c4e : 69 00 __ ADC #$00
0c50 : 8d fc 9f STA $9ffc ; (sstack + 6)
0c53 : 20 6e 0c JSR $0c6e ; (sformat.s1000 + 0)
0c56 : 38 __ __ SEC
0c57 : a5 1b __ LDA ACCU + 0 
0c59 : e5 53 __ SBC T0 + 0 
0c5b : 85 1b __ STA ACCU + 0 
0c5d : a5 1c __ LDA ACCU + 1 
0c5f : e5 54 __ SBC T0 + 1 
0c61 : 85 1c __ STA ACCU + 1 
.s1001:
0c63 : ad d6 9f LDA $9fd6 ; (sprintf@stack + 0)
0c66 : 85 53 __ STA T0 + 0 
0c68 : ad d7 9f LDA $9fd7 ; (sprintf@stack + 1)
0c6b : 85 54 __ STA T0 + 1 
0c6d : 60 __ __ RTS
--------------------------------------------------------------------
sformat:
.s1000:
0c6e : a2 05 __ LDX #$05
0c70 : b5 53 __ LDA T1 + 0,x 
0c72 : 9d d8 9f STA $9fd8,x ; (sformat@stack + 0)
0c75 : ca __ __ DEX
0c76 : 10 f8 __ BPL $0c70 ; (sformat.s1000 + 2)
.s0:
0c78 : a9 00 __ LDA #$00
0c7a : 85 50 __ STA T0 + 0 
0c7c : ad f9 9f LDA $9ff9 ; (sstack + 3)
0c7f : 85 53 __ STA T1 + 0 
0c81 : ad fa 9f LDA $9ffa ; (sstack + 4)
0c84 : 85 54 __ STA T1 + 1 
0c86 : ad f7 9f LDA $9ff7 ; (sstack + 1)
0c89 : 85 55 __ STA T2 + 0 
0c8b : ad f8 9f LDA $9ff8 ; (sstack + 2)
0c8e : 85 56 __ STA T2 + 1 
.l1:
0c90 : a0 00 __ LDY #$00
0c92 : b1 53 __ LDA (T1 + 0),y 
0c94 : d0 38 __ BNE $0cce ; (sformat.s2 + 0)
.s3:
0c96 : a4 50 __ LDY T0 + 0 
0c98 : 91 55 __ STA (T2 + 0),y 
0c9a : 98 __ __ TYA
0c9b : f0 28 __ BEQ $0cc5 ; (sformat.s1061 + 0)
.s112:
0c9d : ad fd 9f LDA $9ffd ; (sstack + 7)
0ca0 : d0 18 __ BNE $0cba ; (sformat.s115 + 0)
.s116:
0ca2 : 18 __ __ CLC
0ca3 : a5 55 __ LDA T2 + 0 
0ca5 : 65 50 __ ADC T0 + 0 
0ca7 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0ca9 : a5 56 __ LDA T2 + 1 
0cab : 69 00 __ ADC #$00
.s1001:
0cad : 85 1c __ STA ACCU + 1 ; (fmt + 0)
0caf : a2 05 __ LDX #$05
0cb1 : bd d8 9f LDA $9fd8,x ; (sformat@stack + 0)
0cb4 : 95 53 __ STA T1 + 0,x 
0cb6 : ca __ __ DEX
0cb7 : 10 f8 __ BPL $0cb1 ; (sformat.s1001 + 4)
0cb9 : 60 __ __ RTS
.s115:
0cba : a5 55 __ LDA T2 + 0 
0cbc : 85 0d __ STA P0 
0cbe : a5 56 __ LDA T2 + 1 
0cc0 : 85 0e __ STA P1 
0cc2 : 20 b2 10 JSR $10b2 ; (puts.s0 + 0)
.s1061:
0cc5 : a5 55 __ LDA T2 + 0 
0cc7 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0cc9 : a5 56 __ LDA T2 + 1 
0ccb : 4c ad 0c JMP $0cad ; (sformat.s1001 + 0)
.s2:
0cce : c9 25 __ CMP #$25
0cd0 : f0 3f __ BEQ $0d11 ; (sformat.s4 + 0)
.s5:
0cd2 : a4 50 __ LDY T0 + 0 
0cd4 : 91 55 __ STA (T2 + 0),y 
0cd6 : e6 53 __ INC T1 + 0 
0cd8 : d0 02 __ BNE $0cdc ; (sformat.s1090 + 0)
.s1089:
0cda : e6 54 __ INC T1 + 1 
.s1090:
0cdc : c8 __ __ INY
0cdd : 84 50 __ STY T0 + 0 
0cdf : 98 __ __ TYA
0ce0 : c0 28 __ CPY #$28
0ce2 : 90 ac __ BCC $0c90 ; (sformat.l1 + 0)
.s106:
0ce4 : 85 57 __ STA T5 + 0 
0ce6 : a9 00 __ LDA #$00
0ce8 : 85 50 __ STA T0 + 0 
0cea : ad fd 9f LDA $9ffd ; (sstack + 7)
0ced : f0 14 __ BEQ $0d03 ; (sformat.s110 + 0)
.s109:
0cef : a5 55 __ LDA T2 + 0 
0cf1 : 85 0d __ STA P0 
0cf3 : a5 56 __ LDA T2 + 1 
0cf5 : 85 0e __ STA P1 
0cf7 : a9 00 __ LDA #$00
0cf9 : a4 57 __ LDY T5 + 0 
0cfb : 91 0d __ STA (P0),y 
0cfd : 20 b2 10 JSR $10b2 ; (puts.s0 + 0)
0d00 : 4c 90 0c JMP $0c90 ; (sformat.l1 + 0)
.s110:
0d03 : 18 __ __ CLC
0d04 : a5 55 __ LDA T2 + 0 
0d06 : 65 57 __ ADC T5 + 0 
0d08 : 85 55 __ STA T2 + 0 
0d0a : 90 84 __ BCC $0c90 ; (sformat.l1 + 0)
.s1092:
0d0c : e6 56 __ INC T2 + 1 
0d0e : 4c 90 0c JMP $0c90 ; (sformat.l1 + 0)
.s4:
0d11 : a5 50 __ LDA T0 + 0 
0d13 : f0 27 __ BEQ $0d3c ; (sformat.s9 + 0)
.s7:
0d15 : 84 50 __ STY T0 + 0 
0d17 : 85 57 __ STA T5 + 0 
0d19 : ad fd 9f LDA $9ffd ; (sstack + 7)
0d1c : f0 13 __ BEQ $0d31 ; (sformat.s11 + 0)
.s10:
0d1e : a5 55 __ LDA T2 + 0 
0d20 : 85 0d __ STA P0 
0d22 : a5 56 __ LDA T2 + 1 
0d24 : 85 0e __ STA P1 
0d26 : 98 __ __ TYA
0d27 : a4 57 __ LDY T5 + 0 
0d29 : 91 0d __ STA (P0),y 
0d2b : 20 b2 10 JSR $10b2 ; (puts.s0 + 0)
0d2e : 4c 3c 0d JMP $0d3c ; (sformat.s9 + 0)
.s11:
0d31 : 18 __ __ CLC
0d32 : a5 55 __ LDA T2 + 0 
0d34 : 65 57 __ ADC T5 + 0 
0d36 : 85 55 __ STA T2 + 0 
0d38 : 90 02 __ BCC $0d3c ; (sformat.s9 + 0)
.s1087:
0d3a : e6 56 __ INC T2 + 1 
.s9:
0d3c : a9 0a __ LDA #$0a
0d3e : 8d e1 9f STA $9fe1 ; (si + 3)
0d41 : a9 00 __ LDA #$00
0d43 : 8d e2 9f STA $9fe2 ; (si + 4)
0d46 : 8d e3 9f STA $9fe3 ; (si + 5)
0d49 : 8d e4 9f STA $9fe4 ; (si + 6)
0d4c : 8d e5 9f STA $9fe5 ; (si + 7)
0d4f : a0 01 __ LDY #$01
0d51 : b1 53 __ LDA (T1 + 0),y 
0d53 : aa __ __ TAX
0d54 : a9 20 __ LDA #$20
0d56 : 8d de 9f STA $9fde ; (si + 0)
0d59 : a9 00 __ LDA #$00
0d5b : 8d df 9f STA $9fdf ; (si + 1)
0d5e : a9 ff __ LDA #$ff
0d60 : 8d e0 9f STA $9fe0 ; (si + 2)
0d63 : 18 __ __ CLC
0d64 : a5 53 __ LDA T1 + 0 
0d66 : 69 02 __ ADC #$02
.l14:
0d68 : 85 53 __ STA T1 + 0 
0d6a : 90 02 __ BCC $0d6e ; (sformat.s1074 + 0)
.s1073:
0d6c : e6 54 __ INC T1 + 1 
.s1074:
0d6e : 8a __ __ TXA
0d6f : e0 2b __ CPX #$2b
0d71 : d0 08 __ BNE $0d7b ; (sformat.s17 + 0)
.s16:
0d73 : a9 01 __ LDA #$01
0d75 : 8d e3 9f STA $9fe3 ; (si + 5)
0d78 : 4c a5 10 JMP $10a5 ; (sformat.s224 + 0)
.s17:
0d7b : c9 30 __ CMP #$30
0d7d : d0 06 __ BNE $0d85 ; (sformat.s20 + 0)
.s19:
0d7f : 8d de 9f STA $9fde ; (si + 0)
0d82 : 4c a5 10 JMP $10a5 ; (sformat.s224 + 0)
.s20:
0d85 : e0 23 __ CPX #$23
0d87 : d0 08 __ BNE $0d91 ; (sformat.s23 + 0)
.s22:
0d89 : a9 01 __ LDA #$01
0d8b : 8d e5 9f STA $9fe5 ; (si + 7)
0d8e : 4c a5 10 JMP $10a5 ; (sformat.s224 + 0)
.s23:
0d91 : e0 2d __ CPX #$2d
0d93 : d0 08 __ BNE $0d9d ; (sformat.s15 + 0)
.s25:
0d95 : a9 01 __ LDA #$01
0d97 : 8d e4 9f STA $9fe4 ; (si + 6)
0d9a : 4c a5 10 JMP $10a5 ; (sformat.s224 + 0)
.s15:
0d9d : 86 57 __ STX T5 + 0 
0d9f : e0 30 __ CPX #$30
0da1 : 90 53 __ BCC $0df6 ; (sformat.s31 + 0)
.s32:
0da3 : e0 3a __ CPX #$3a
0da5 : b0 4f __ BCS $0df6 ; (sformat.s31 + 0)
.s29:
0da7 : a9 00 __ LDA #$00
0da9 : 85 44 __ STA T6 + 0 
0dab : 85 45 __ STA T6 + 1 
0dad : e0 3a __ CPX #$3a
0daf : b0 40 __ BCS $0df1 ; (sformat.s35 + 0)
.l34:
0db1 : a5 44 __ LDA T6 + 0 
0db3 : 0a __ __ ASL
0db4 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0db6 : a5 45 __ LDA T6 + 1 
0db8 : 2a __ __ ROL
0db9 : 06 1b __ ASL ACCU + 0 ; (buff + 1)
0dbb : 2a __ __ ROL
0dbc : aa __ __ TAX
0dbd : 18 __ __ CLC
0dbe : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0dc0 : 65 44 __ ADC T6 + 0 
0dc2 : 85 44 __ STA T6 + 0 
0dc4 : 8a __ __ TXA
0dc5 : 65 45 __ ADC T6 + 1 
0dc7 : 06 44 __ ASL T6 + 0 
0dc9 : 2a __ __ ROL
0dca : aa __ __ TAX
0dcb : 18 __ __ CLC
0dcc : a5 44 __ LDA T6 + 0 
0dce : 65 57 __ ADC T5 + 0 
0dd0 : 90 01 __ BCC $0dd3 ; (sformat.s1084 + 0)
.s1083:
0dd2 : e8 __ __ INX
.s1084:
0dd3 : 38 __ __ SEC
0dd4 : e9 30 __ SBC #$30
0dd6 : 85 44 __ STA T6 + 0 
0dd8 : 8a __ __ TXA
0dd9 : e9 00 __ SBC #$00
0ddb : 85 45 __ STA T6 + 1 
0ddd : a0 00 __ LDY #$00
0ddf : b1 53 __ LDA (T1 + 0),y 
0de1 : 85 57 __ STA T5 + 0 
0de3 : e6 53 __ INC T1 + 0 
0de5 : d0 02 __ BNE $0de9 ; (sformat.s1086 + 0)
.s1085:
0de7 : e6 54 __ INC T1 + 1 
.s1086:
0de9 : c9 30 __ CMP #$30
0deb : 90 04 __ BCC $0df1 ; (sformat.s35 + 0)
.s36:
0ded : c9 3a __ CMP #$3a
0def : 90 c0 __ BCC $0db1 ; (sformat.l34 + 0)
.s35:
0df1 : a5 44 __ LDA T6 + 0 
0df3 : 8d df 9f STA $9fdf ; (si + 1)
.s31:
0df6 : a5 57 __ LDA T5 + 0 
0df8 : c9 2e __ CMP #$2e
0dfa : d0 51 __ BNE $0e4d ; (sformat.s39 + 0)
.s37:
0dfc : a9 00 __ LDA #$00
0dfe : 85 44 __ STA T6 + 0 
.l203:
0e00 : 85 45 __ STA T6 + 1 
0e02 : a0 00 __ LDY #$00
0e04 : b1 53 __ LDA (T1 + 0),y 
0e06 : 85 57 __ STA T5 + 0 
0e08 : e6 53 __ INC T1 + 0 
0e0a : d0 02 __ BNE $0e0e ; (sformat.s1076 + 0)
.s1075:
0e0c : e6 54 __ INC T1 + 1 
.s1076:
0e0e : c9 30 __ CMP #$30
0e10 : 90 04 __ BCC $0e16 ; (sformat.s42 + 0)
.s43:
0e12 : c9 3a __ CMP #$3a
0e14 : 90 0a __ BCC $0e20 ; (sformat.s41 + 0)
.s42:
0e16 : a5 44 __ LDA T6 + 0 
0e18 : 8d e0 9f STA $9fe0 ; (si + 2)
0e1b : a5 57 __ LDA T5 + 0 
0e1d : 4c 4d 0e JMP $0e4d ; (sformat.s39 + 0)
.s41:
0e20 : a5 44 __ LDA T6 + 0 
0e22 : 0a __ __ ASL
0e23 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0e25 : a5 45 __ LDA T6 + 1 
0e27 : 2a __ __ ROL
0e28 : 06 1b __ ASL ACCU + 0 ; (buff + 1)
0e2a : 2a __ __ ROL
0e2b : aa __ __ TAX
0e2c : 18 __ __ CLC
0e2d : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0e2f : 65 44 __ ADC T6 + 0 
0e31 : 85 44 __ STA T6 + 0 
0e33 : 8a __ __ TXA
0e34 : 65 45 __ ADC T6 + 1 
0e36 : 06 44 __ ASL T6 + 0 
0e38 : 2a __ __ ROL
0e39 : aa __ __ TAX
0e3a : 18 __ __ CLC
0e3b : a5 44 __ LDA T6 + 0 
0e3d : 65 57 __ ADC T5 + 0 
0e3f : 90 01 __ BCC $0e42 ; (sformat.s1082 + 0)
.s1081:
0e41 : e8 __ __ INX
.s1082:
0e42 : 38 __ __ SEC
0e43 : e9 30 __ SBC #$30
0e45 : 85 44 __ STA T6 + 0 
0e47 : 8a __ __ TXA
0e48 : e9 00 __ SBC #$00
0e4a : 4c 00 0e JMP $0e00 ; (sformat.l203 + 0)
.s39:
0e4d : c9 64 __ CMP #$64
0e4f : d0 05 __ BNE $0e56 ; (sformat.s45 + 0)
.s44:
0e51 : a9 01 __ LDA #$01
0e53 : 4c 69 10 JMP $1069 ; (sformat.s221 + 0)
.s45:
0e56 : c9 75 __ CMP #$75
0e58 : d0 03 __ BNE $0e5d ; (sformat.s48 + 0)
0e5a : 4c 67 10 JMP $1067 ; (sformat.s250 + 0)
.s48:
0e5d : c9 78 __ CMP #$78
0e5f : d0 0d __ BNE $0e6e ; (sformat.s51 + 0)
.s50:
0e61 : a9 10 __ LDA #$10
0e63 : 8d e1 9f STA $9fe1 ; (si + 3)
0e66 : a9 00 __ LDA #$00
0e68 : 8d e2 9f STA $9fe2 ; (si + 4)
0e6b : 4c 67 10 JMP $1067 ; (sformat.s250 + 0)
.s51:
0e6e : c9 6c __ CMP #$6c
0e70 : d0 03 __ BNE $0e75 ; (sformat.s54 + 0)
0e72 : 4c e2 0f JMP $0fe2 ; (sformat.s53 + 0)
.s54:
0e75 : c9 66 __ CMP #$66
0e77 : f0 08 __ BEQ $0e81 ; (sformat.s65 + 0)
.s69:
0e79 : c9 67 __ CMP #$67
0e7b : f0 04 __ BEQ $0e81 ; (sformat.s65 + 0)
.s68:
0e7d : c9 65 __ CMP #$65
0e7f : d0 4d __ BNE $0ece ; (sformat.s66 + 0)
.s65:
0e81 : a5 55 __ LDA T2 + 0 
0e83 : 85 13 __ STA P6 
0e85 : a5 56 __ LDA T2 + 1 
0e87 : 85 14 __ STA P7 
0e89 : a5 57 __ LDA T5 + 0 
0e8b : 8d f6 9f STA $9ff6 ; (sstack + 0)
0e8e : a9 de __ LDA #$de
0e90 : 85 11 __ STA P4 
0e92 : a9 9f __ LDA #$9f
0e94 : 85 12 __ STA P5 
0e96 : ad fb 9f LDA $9ffb ; (sstack + 5)
0e99 : 85 57 __ STA T5 + 0 
0e9b : ad fc 9f LDA $9ffc ; (sstack + 6)
0e9e : 85 58 __ STA T5 + 1 
0ea0 : a0 00 __ LDY #$00
0ea2 : b1 57 __ LDA (T5 + 0),y 
0ea4 : 85 15 __ STA P8 
0ea6 : c8 __ __ INY
0ea7 : b1 57 __ LDA (T5 + 0),y 
0ea9 : 85 16 __ STA P9 
0eab : c8 __ __ INY
0eac : b1 57 __ LDA (T5 + 0),y 
0eae : 85 17 __ STA P10 
0eb0 : c8 __ __ INY
0eb1 : b1 57 __ LDA (T5 + 0),y 
0eb3 : 85 18 __ STA P11 
0eb5 : 20 fe 13 JSR $13fe ; (nformf.s0 + 0)
0eb8 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0eba : 85 50 __ STA T0 + 0 
0ebc : 18 __ __ CLC
0ebd : a5 57 __ LDA T5 + 0 
0ebf : 69 04 __ ADC #$04
0ec1 : 8d fb 9f STA $9ffb ; (sstack + 5)
0ec4 : a5 58 __ LDA T5 + 1 
0ec6 : 69 00 __ ADC #$00
0ec8 : 8d fc 9f STA $9ffc ; (sstack + 6)
0ecb : 4c 90 0c JMP $0c90 ; (sformat.l1 + 0)
.s66:
0ece : c9 73 __ CMP #$73
0ed0 : f0 4c __ BEQ $0f1e ; (sformat.s70 + 0)
.s71:
0ed2 : c9 63 __ CMP #$63
0ed4 : f0 1f __ BEQ $0ef5 ; (sformat.s100 + 0)
.s101:
0ed6 : 09 00 __ ORA #$00
0ed8 : d0 03 __ BNE $0edd ; (sformat.s103 + 0)
0eda : 4c 90 0c JMP $0c90 ; (sformat.l1 + 0)
.s103:
0edd : 18 __ __ CLC
0ede : a5 55 __ LDA T2 + 0 
0ee0 : 65 50 __ ADC T0 + 0 
0ee2 : 85 44 __ STA T6 + 0 
0ee4 : a5 56 __ LDA T2 + 1 
0ee6 : 69 00 __ ADC #$00
0ee8 : 85 45 __ STA T6 + 1 
0eea : a5 57 __ LDA T5 + 0 
.s1059:
0eec : a0 00 __ LDY #$00
0eee : 91 44 __ STA (T6 + 0),y 
0ef0 : e6 50 __ INC T0 + 0 
0ef2 : 4c 90 0c JMP $0c90 ; (sformat.l1 + 0)
.s100:
0ef5 : ad fb 9f LDA $9ffb ; (sstack + 5)
0ef8 : 85 57 __ STA T5 + 0 
0efa : 18 __ __ CLC
0efb : 69 02 __ ADC #$02
0efd : 8d fb 9f STA $9ffb ; (sstack + 5)
0f00 : ad fc 9f LDA $9ffc ; (sstack + 6)
0f03 : 85 58 __ STA T5 + 1 
0f05 : 69 00 __ ADC #$00
0f07 : 8d fc 9f STA $9ffc ; (sstack + 6)
0f0a : 18 __ __ CLC
0f0b : a5 55 __ LDA T2 + 0 
0f0d : 65 50 __ ADC T0 + 0 
0f0f : 85 44 __ STA T6 + 0 
0f11 : a5 56 __ LDA T2 + 1 
0f13 : 69 00 __ ADC #$00
0f15 : 85 45 __ STA T6 + 1 
0f17 : a0 00 __ LDY #$00
0f19 : b1 57 __ LDA (T5 + 0),y 
0f1b : 4c ec 0e JMP $0eec ; (sformat.s1059 + 0)
.s70:
0f1e : ad fb 9f LDA $9ffb ; (sstack + 5)
0f21 : 85 57 __ STA T5 + 0 
0f23 : 18 __ __ CLC
0f24 : 69 02 __ ADC #$02
0f26 : 8d fb 9f STA $9ffb ; (sstack + 5)
0f29 : ad fc 9f LDA $9ffc ; (sstack + 6)
0f2c : 85 58 __ STA T5 + 1 
0f2e : 69 00 __ ADC #$00
0f30 : 8d fc 9f STA $9ffc ; (sstack + 6)
0f33 : a0 00 __ LDY #$00
0f35 : b1 57 __ LDA (T5 + 0),y 
0f37 : aa __ __ TAX
0f38 : c8 __ __ INY
0f39 : b1 57 __ LDA (T5 + 0),y 
0f3b : 86 57 __ STX T5 + 0 
0f3d : 85 58 __ STA T5 + 1 
0f3f : a9 00 __ LDA #$00
0f41 : 85 52 __ STA T3 + 0 
0f43 : ad df 9f LDA $9fdf ; (si + 1)
0f46 : f0 0c __ BEQ $0f54 ; (sformat.s75 + 0)
.s1065:
0f48 : 88 __ __ DEY
0f49 : b1 57 __ LDA (T5 + 0),y 
0f4b : f0 05 __ BEQ $0f52 ; (sformat.s1066 + 0)
.l77:
0f4d : c8 __ __ INY
0f4e : b1 57 __ LDA (T5 + 0),y 
0f50 : d0 fb __ BNE $0f4d ; (sformat.l77 + 0)
.s1066:
0f52 : 84 52 __ STY T3 + 0 
.s75:
0f54 : ad e4 9f LDA $9fe4 ; (si + 6)
0f57 : d0 19 __ BNE $0f72 ; (sformat.s81 + 0)
.s1069:
0f59 : a6 52 __ LDX T3 + 0 
0f5b : ec df 9f CPX $9fdf ; (si + 1)
0f5e : a4 50 __ LDY T0 + 0 
0f60 : b0 0c __ BCS $0f6e ; (sformat.s1070 + 0)
.l83:
0f62 : ad de 9f LDA $9fde ; (si + 0)
0f65 : 91 55 __ STA (T2 + 0),y 
0f67 : e8 __ __ INX
0f68 : ec df 9f CPX $9fdf ; (si + 1)
0f6b : c8 __ __ INY
0f6c : 90 f4 __ BCC $0f62 ; (sformat.l83 + 0)
.s1070:
0f6e : 86 52 __ STX T3 + 0 
0f70 : 84 50 __ STY T0 + 0 
.s81:
0f72 : ad fd 9f LDA $9ffd ; (sstack + 7)
0f75 : d0 37 __ BNE $0fae ; (sformat.s85 + 0)
.l91:
0f77 : a0 00 __ LDY #$00
0f79 : b1 57 __ LDA (T5 + 0),y 
0f7b : f0 0f __ BEQ $0f8c ; (sformat.s211 + 0)
.s92:
0f7d : a4 50 __ LDY T0 + 0 
0f7f : 91 55 __ STA (T2 + 0),y 
0f81 : e6 50 __ INC T0 + 0 
0f83 : e6 57 __ INC T5 + 0 
0f85 : d0 f0 __ BNE $0f77 ; (sformat.l91 + 0)
.s1079:
0f87 : e6 58 __ INC T5 + 1 
0f89 : 4c 77 0f JMP $0f77 ; (sformat.l91 + 0)
.s211:
0f8c : ad e4 9f LDA $9fe4 ; (si + 6)
0f8f : d0 03 __ BNE $0f94 ; (sformat.s1067 + 0)
0f91 : 4c 90 0c JMP $0c90 ; (sformat.l1 + 0)
.s1067:
0f94 : a6 52 __ LDX T3 + 0 
0f96 : ec df 9f CPX $9fdf ; (si + 1)
0f99 : a4 50 __ LDY T0 + 0 
0f9b : b0 0c __ BCS $0fa9 ; (sformat.s1068 + 0)
.l98:
0f9d : ad de 9f LDA $9fde ; (si + 0)
0fa0 : 91 55 __ STA (T2 + 0),y 
0fa2 : e8 __ __ INX
0fa3 : ec df 9f CPX $9fdf ; (si + 1)
0fa6 : c8 __ __ INY
0fa7 : 90 f4 __ BCC $0f9d ; (sformat.l98 + 0)
.s1068:
0fa9 : 84 50 __ STY T0 + 0 
0fab : 4c 90 0c JMP $0c90 ; (sformat.l1 + 0)
.s85:
0fae : a5 50 __ LDA T0 + 0 
0fb0 : f0 22 __ BEQ $0fd4 ; (sformat.s90 + 0)
.s88:
0fb2 : a5 55 __ LDA T2 + 0 
0fb4 : 85 0d __ STA P0 
0fb6 : a5 56 __ LDA T2 + 1 
0fb8 : 85 0e __ STA P1 
0fba : a9 00 __ LDA #$00
0fbc : a4 50 __ LDY T0 + 0 
0fbe : 91 0d __ STA (P0),y 
0fc0 : 20 b2 10 JSR $10b2 ; (puts.s0 + 0)
0fc3 : a5 57 __ LDA T5 + 0 
0fc5 : 85 0d __ STA P0 
0fc7 : a5 58 __ LDA T5 + 1 
0fc9 : 85 0e __ STA P1 
0fcb : 20 b2 10 JSR $10b2 ; (puts.s0 + 0)
0fce : a9 00 __ LDA #$00
0fd0 : 85 50 __ STA T0 + 0 
0fd2 : f0 b8 __ BEQ $0f8c ; (sformat.s211 + 0)
.s90:
0fd4 : a5 57 __ LDA T5 + 0 
0fd6 : 85 0d __ STA P0 
0fd8 : a5 58 __ LDA T5 + 1 
0fda : 85 0e __ STA P1 
0fdc : 20 b2 10 JSR $10b2 ; (puts.s0 + 0)
0fdf : 4c 8c 0f JMP $0f8c ; (sformat.s211 + 0)
.s53:
0fe2 : ad fb 9f LDA $9ffb ; (sstack + 5)
0fe5 : 85 57 __ STA T5 + 0 
0fe7 : 18 __ __ CLC
0fe8 : 69 04 __ ADC #$04
0fea : 8d fb 9f STA $9ffb ; (sstack + 5)
0fed : ad fc 9f LDA $9ffc ; (sstack + 6)
0ff0 : 85 58 __ STA T5 + 1 
0ff2 : 69 00 __ ADC #$00
0ff4 : 8d fc 9f STA $9ffc ; (sstack + 6)
0ff7 : a0 00 __ LDY #$00
0ff9 : b1 53 __ LDA (T1 + 0),y 
0ffb : 85 52 __ STA T3 + 0 
0ffd : e6 53 __ INC T1 + 0 
0fff : d0 02 __ BNE $1003 ; (sformat.s1078 + 0)
.s1077:
1001 : e6 54 __ INC T1 + 1 
.s1078:
1003 : c9 64 __ CMP #$64
1005 : d0 04 __ BNE $100b ; (sformat.s1019 + 0)
.s1018:
1007 : a2 01 __ LDX #$01
1009 : d0 02 __ BNE $100d ; (sformat.s1020 + 0)
.s1019:
100b : a2 00 __ LDX #$00
.s1020:
100d : b1 57 __ LDA (T5 + 0),y 
100f : 85 46 __ STA T7 + 0 
1011 : a0 01 __ LDY #$01
1013 : b1 57 __ LDA (T5 + 0),y 
1015 : 85 47 __ STA T7 + 1 
1017 : c8 __ __ INY
1018 : b1 57 __ LDA (T5 + 0),y 
101a : 85 48 __ STA T7 + 2 
101c : c8 __ __ INY
101d : b1 57 __ LDA (T5 + 0),y 
101f : a8 __ __ TAY
1020 : 8a __ __ TXA
1021 : f0 04 __ BEQ $1027 ; (sformat.s57 + 0)
.s56:
1023 : a9 01 __ LDA #$01
1025 : d0 16 __ BNE $103d ; (sformat.s222 + 0)
.s57:
1027 : a5 52 __ LDA T3 + 0 
1029 : c9 75 __ CMP #$75
102b : f0 0f __ BEQ $103c ; (sformat.s251 + 0)
.s60:
102d : c9 78 __ CMP #$78
102f : f0 03 __ BEQ $1034 ; (sformat.s62 + 0)
1031 : 4c 90 0c JMP $0c90 ; (sformat.l1 + 0)
.s62:
1034 : 8e e2 9f STX $9fe2 ; (si + 4)
1037 : a9 10 __ LDA #$10
1039 : 8d e1 9f STA $9fe1 ; (si + 3)
.s251:
103c : 8a __ __ TXA
.s222:
103d : 84 14 __ STY P7 
103f : 85 15 __ STA P8 
1041 : a5 55 __ LDA T2 + 0 
1043 : 85 0f __ STA P2 
1045 : a5 56 __ LDA T2 + 1 
1047 : 85 10 __ STA P3 
1049 : a5 46 __ LDA T7 + 0 
104b : 85 11 __ STA P4 
104d : a5 47 __ LDA T7 + 1 
104f : 85 12 __ STA P5 
1051 : a5 48 __ LDA T7 + 2 
1053 : 85 13 __ STA P6 
1055 : a9 de __ LDA #$de
1057 : 85 0d __ STA P0 
1059 : a9 9f __ LDA #$9f
105b : 85 0e __ STA P1 
105d : 20 66 12 JSR $1266 ; (nforml.s0 + 0)
.s1062:
1060 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
1062 : 85 50 __ STA T0 + 0 
1064 : 4c 90 0c JMP $0c90 ; (sformat.l1 + 0)
.s250:
1067 : a9 00 __ LDA #$00
.s221:
1069 : 85 13 __ STA P6 
106b : a5 55 __ LDA T2 + 0 
106d : 85 0f __ STA P2 
106f : a5 56 __ LDA T2 + 1 
1071 : 85 10 __ STA P3 
1073 : ad fb 9f LDA $9ffb ; (sstack + 5)
1076 : 85 50 __ STA T0 + 0 
1078 : ad fc 9f LDA $9ffc ; (sstack + 6)
107b : 85 51 __ STA T0 + 1 
107d : a0 00 __ LDY #$00
107f : b1 50 __ LDA (T0 + 0),y 
1081 : 85 11 __ STA P4 
1083 : c8 __ __ INY
1084 : b1 50 __ LDA (T0 + 0),y 
1086 : 85 12 __ STA P5 
1088 : 18 __ __ CLC
1089 : a5 50 __ LDA T0 + 0 
108b : 69 02 __ ADC #$02
108d : 8d fb 9f STA $9ffb ; (sstack + 5)
1090 : a5 51 __ LDA T0 + 1 
1092 : 69 00 __ ADC #$00
1094 : 8d fc 9f STA $9ffc ; (sstack + 6)
1097 : a9 de __ LDA #$de
1099 : 85 0d __ STA P0 
109b : a9 9f __ LDA #$9f
109d : 85 0e __ STA P1 
109f : 20 07 11 JSR $1107 ; (nformi.s0 + 0)
10a2 : 4c 60 10 JMP $1060 ; (sformat.s1062 + 0)
.s224:
10a5 : a0 00 __ LDY #$00
10a7 : b1 53 __ LDA (T1 + 0),y 
10a9 : aa __ __ TAX
10aa : 18 __ __ CLC
10ab : a5 53 __ LDA T1 + 0 
10ad : 69 01 __ ADC #$01
10af : 4c 68 0d JMP $0d68 ; (sformat.l14 + 0)
--------------------------------------------------------------------
puts:
.s0:
10b2 : a0 00 __ LDY #$00
10b4 : b1 0d __ LDA (P0),y 
10b6 : f0 0b __ BEQ $10c3 ; (puts.s1001 + 0)
10b8 : 20 c4 10 JSR $10c4 ; (putpch + 0)
10bb : e6 0d __ INC P0 
10bd : d0 f3 __ BNE $10b2 ; (puts.s0 + 0)
10bf : e6 0e __ INC P1 
10c1 : d0 ef __ BNE $10b2 ; (puts.s0 + 0)
.s1001:
10c3 : 60 __ __ RTS
--------------------------------------------------------------------
putpch:
10c4 : ae ea 24 LDX $24ea ; (giocharmap + 0)
10c7 : e0 01 __ CPX #$01
10c9 : 90 26 __ BCC $10f1 ; (putpch + 45)
10cb : c9 0a __ CMP #$0a
10cd : d0 02 __ BNE $10d1 ; (putpch + 13)
10cf : a9 0d __ LDA #$0d
10d1 : c9 09 __ CMP #$09
10d3 : f0 1f __ BEQ $10f4 ; (putpch + 48)
10d5 : e0 02 __ CPX #$02
10d7 : 90 18 __ BCC $10f1 ; (putpch + 45)
10d9 : c9 41 __ CMP #$41
10db : 90 14 __ BCC $10f1 ; (putpch + 45)
10dd : c9 7b __ CMP #$7b
10df : b0 10 __ BCS $10f1 ; (putpch + 45)
10e1 : c9 61 __ CMP #$61
10e3 : b0 04 __ BCS $10e9 ; (putpch + 37)
10e5 : c9 5b __ CMP #$5b
10e7 : b0 08 __ BCS $10f1 ; (putpch + 45)
10e9 : 49 20 __ EOR #$20
10eb : e0 03 __ CPX #$03
10ed : f0 02 __ BEQ $10f1 ; (putpch + 45)
10ef : 29 df __ AND #$df
10f1 : 4c d2 ff JMP $ffd2 
10f4 : 38 __ __ SEC
10f5 : 20 f0 ff JSR $fff0 
10f8 : 98 __ __ TYA
10f9 : 29 03 __ AND #$03
10fb : 49 03 __ EOR #$03
10fd : aa __ __ TAX
10fe : a9 20 __ LDA #$20
1100 : 20 d2 ff JSR $ffd2 
1103 : ca __ __ DEX
1104 : 10 fa __ BPL $1100 ; (putpch + 60)
1106 : 60 __ __ RTS
--------------------------------------------------------------------
giocharmap:
24ea : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
nformi:
.s0:
1107 : a9 00 __ LDA #$00
1109 : 85 43 __ STA T0 + 0 
110b : a5 13 __ LDA P6 ; (s + 0)
110d : f0 15 __ BEQ $1124 ; (nformi.s159 + 0)
.s4:
110f : a5 12 __ LDA P5 ; (v + 1)
1111 : 10 11 __ BPL $1124 ; (nformi.s159 + 0)
.s1:
1113 : 38 __ __ SEC
1114 : a9 00 __ LDA #$00
1116 : e5 11 __ SBC P4 ; (v + 0)
1118 : 85 11 __ STA P4 ; (v + 0)
111a : a9 00 __ LDA #$00
111c : e5 12 __ SBC P5 ; (v + 1)
111e : 85 12 __ STA P5 ; (v + 1)
1120 : a9 01 __ LDA #$01
1122 : 85 43 __ STA T0 + 0 
.s159:
1124 : a9 10 __ LDA #$10
1126 : 85 44 __ STA T2 + 0 
1128 : a5 11 __ LDA P4 ; (v + 0)
112a : 05 12 __ ORA P5 ; (v + 1)
112c : f0 61 __ BEQ $118f ; (nformi.s7 + 0)
.s45:
112e : a5 0d __ LDA P0 ; (si + 0)
1130 : 85 45 __ STA T4 + 0 
1132 : a5 0e __ LDA P1 ; (si + 1)
1134 : 85 46 __ STA T4 + 1 
.l6:
1136 : a0 03 __ LDY #$03
1138 : b1 45 __ LDA (T4 + 0),y 
113a : 85 47 __ STA T5 + 0 
113c : 85 03 __ STA WORK + 0 
113e : c8 __ __ INY
113f : b1 45 __ LDA (T4 + 0),y 
1141 : 85 48 __ STA T5 + 1 
1143 : 85 04 __ STA WORK + 1 
1145 : a5 11 __ LDA P4 ; (v + 0)
1147 : 85 1b __ STA ACCU + 0 
1149 : a5 12 __ LDA P5 ; (v + 1)
114b : 85 1c __ STA ACCU + 1 
114d : 20 a1 22 JSR $22a1 ; (divmod + 0)
1150 : a5 06 __ LDA WORK + 3 
1152 : 30 10 __ BMI $1164 ; (nformi.s9 + 0)
.s1019:
1154 : d0 06 __ BNE $115c ; (nformi.s8 + 0)
.s1018:
1156 : a5 05 __ LDA WORK + 2 
1158 : c9 0a __ CMP #$0a
115a : 90 08 __ BCC $1164 ; (nformi.s9 + 0)
.s8:
115c : 18 __ __ CLC
115d : a5 05 __ LDA WORK + 2 
115f : 69 37 __ ADC #$37
1161 : 4c 69 11 JMP $1169 ; (nformi.s10 + 0)
.s9:
1164 : 18 __ __ CLC
1165 : a5 05 __ LDA WORK + 2 
1167 : 69 30 __ ADC #$30
.s10:
1169 : c6 44 __ DEC T2 + 0 
116b : a6 44 __ LDX T2 + 0 
116d : 9d e6 9f STA $9fe6,x ; (buffer + 0)
1170 : a5 11 __ LDA P4 ; (v + 0)
1172 : 85 1b __ STA ACCU + 0 
1174 : a5 12 __ LDA P5 ; (v + 1)
1176 : 85 1c __ STA ACCU + 1 
1178 : a5 47 __ LDA T5 + 0 
117a : 85 03 __ STA WORK + 0 
117c : a5 48 __ LDA T5 + 1 
117e : 85 04 __ STA WORK + 1 
1180 : 20 a1 22 JSR $22a1 ; (divmod + 0)
1183 : a5 1b __ LDA ACCU + 0 
1185 : 85 11 __ STA P4 ; (v + 0)
1187 : a5 1c __ LDA ACCU + 1 
1189 : 85 12 __ STA P5 ; (v + 1)
118b : 05 11 __ ORA P4 ; (v + 0)
118d : d0 a7 __ BNE $1136 ; (nformi.l6 + 0)
.s7:
118f : a5 0d __ LDA P0 ; (si + 0)
1191 : 85 11 __ STA P4 ; (v + 0)
1193 : a5 0e __ LDA P1 ; (si + 1)
1195 : 85 12 __ STA P5 ; (v + 1)
1197 : a0 02 __ LDY #$02
1199 : b1 0d __ LDA (P0),y ; (si + 0)
119b : c9 ff __ CMP #$ff
119d : d0 04 __ BNE $11a3 ; (nformi.s76 + 0)
.s77:
119f : a9 0f __ LDA #$0f
11a1 : d0 05 __ BNE $11a8 ; (nformi.s1026 + 0)
.s76:
11a3 : 38 __ __ SEC
11a4 : a9 10 __ LDA #$10
11a6 : f1 0d __ SBC (P0),y ; (si + 0)
.s1026:
11a8 : a8 __ __ TAY
11a9 : c4 44 __ CPY T2 + 0 
11ab : b0 0d __ BCS $11ba ; (nformi.s13 + 0)
.s12:
11ad : a9 30 __ LDA #$30
.l1027:
11af : c6 44 __ DEC T2 + 0 
11b1 : a6 44 __ LDX T2 + 0 
11b3 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
11b6 : c4 44 __ CPY T2 + 0 
11b8 : 90 f5 __ BCC $11af ; (nformi.l1027 + 0)
.s13:
11ba : a0 07 __ LDY #$07
11bc : b1 0d __ LDA (P0),y ; (si + 0)
11be : f0 20 __ BEQ $11e0 ; (nformi.s16 + 0)
.s17:
11c0 : a0 04 __ LDY #$04
11c2 : b1 0d __ LDA (P0),y ; (si + 0)
11c4 : d0 1a __ BNE $11e0 ; (nformi.s16 + 0)
.s1013:
11c6 : 88 __ __ DEY
11c7 : b1 0d __ LDA (P0),y ; (si + 0)
11c9 : c9 10 __ CMP #$10
11cb : d0 13 __ BNE $11e0 ; (nformi.s16 + 0)
.s14:
11cd : a9 58 __ LDA #$58
11cf : a6 44 __ LDX T2 + 0 
11d1 : 9d e5 9f STA $9fe5,x ; (si + 7)
11d4 : 8a __ __ TXA
11d5 : 18 __ __ CLC
11d6 : 69 fe __ ADC #$fe
11d8 : 85 44 __ STA T2 + 0 
11da : aa __ __ TAX
11db : a9 30 __ LDA #$30
11dd : 9d e6 9f STA $9fe6,x ; (buffer + 0)
.s16:
11e0 : a9 00 __ LDA #$00
11e2 : 85 1b __ STA ACCU + 0 
11e4 : a5 43 __ LDA T0 + 0 
11e6 : f0 06 __ BEQ $11ee ; (nformi.s19 + 0)
.s18:
11e8 : c6 44 __ DEC T2 + 0 
11ea : a9 2d __ LDA #$2d
11ec : d0 0a __ BNE $11f8 ; (nformi.s1025 + 0)
.s19:
11ee : a0 05 __ LDY #$05
11f0 : b1 0d __ LDA (P0),y ; (si + 0)
11f2 : f0 09 __ BEQ $11fd ; (nformi.s141 + 0)
.s21:
11f4 : c6 44 __ DEC T2 + 0 
11f6 : a9 2b __ LDA #$2b
.s1025:
11f8 : a6 44 __ LDX T2 + 0 
11fa : 9d e6 9f STA $9fe6,x ; (buffer + 0)
.s141:
11fd : a0 06 __ LDY #$06
11ff : b1 0d __ LDA (P0),y ; (si + 0)
1201 : d0 37 __ BNE $123a ; (nformi.s27 + 0)
.l33:
1203 : a0 01 __ LDY #$01
1205 : b1 11 __ LDA (P4),y ; (v + 0)
1207 : 18 __ __ CLC
1208 : 65 44 __ ADC T2 + 0 
120a : b0 04 __ BCS $1210 ; (nformi.s34 + 0)
.s1006:
120c : c9 11 __ CMP #$11
120e : 90 0e __ BCC $121e ; (nformi.s36 + 0)
.s34:
1210 : c6 44 __ DEC T2 + 0 
1212 : a0 00 __ LDY #$00
1214 : b1 11 __ LDA (P4),y ; (v + 0)
1216 : a6 44 __ LDX T2 + 0 
1218 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
121b : 4c 03 12 JMP $1203 ; (nformi.l33 + 0)
.s36:
121e : a6 44 __ LDX T2 + 0 
1220 : e0 10 __ CPX #$10
1222 : b0 11 __ BCS $1235 ; (nformi.s26 + 0)
.s1022:
1224 : 88 __ __ DEY
.l1031:
1225 : bd e6 9f LDA $9fe6,x ; (buffer + 0)
1228 : 91 0f __ STA (P2),y ; (str + 0)
122a : e6 44 __ INC T2 + 0 
122c : a6 44 __ LDX T2 + 0 
122e : e0 10 __ CPX #$10
1230 : c8 __ __ INY
1231 : 90 f2 __ BCC $1225 ; (nformi.l1031 + 0)
.s1032:
1233 : 84 1b __ STY ACCU + 0 
.s26:
1235 : a9 00 __ LDA #$00
1237 : 85 1c __ STA ACCU + 1 
.s1001:
1239 : 60 __ __ RTS
.s27:
123a : a6 44 __ LDX T2 + 0 
123c : e0 10 __ CPX #$10
123e : b0 12 __ BCS $1252 ; (nformi.l30 + 0)
.s1020:
1240 : a0 00 __ LDY #$00
.l1029:
1242 : bd e6 9f LDA $9fe6,x ; (buffer + 0)
1245 : 91 0f __ STA (P2),y ; (str + 0)
1247 : e6 44 __ INC T2 + 0 
1249 : a6 44 __ LDX T2 + 0 
124b : e0 10 __ CPX #$10
124d : c8 __ __ INY
124e : 90 f2 __ BCC $1242 ; (nformi.l1029 + 0)
.s1030:
1250 : 84 1b __ STY ACCU + 0 
.l30:
1252 : a5 1b __ LDA ACCU + 0 
1254 : a0 01 __ LDY #$01
1256 : d1 11 __ CMP (P4),y ; (v + 0)
1258 : b0 db __ BCS $1235 ; (nformi.s26 + 0)
.s31:
125a : 88 __ __ DEY
125b : b1 11 __ LDA (P4),y ; (v + 0)
125d : a4 1b __ LDY ACCU + 0 
125f : 91 0f __ STA (P2),y ; (str + 0)
1261 : e6 1b __ INC ACCU + 0 
1263 : 4c 52 12 JMP $1252 ; (nformi.l30 + 0)
--------------------------------------------------------------------
nforml:
.s0:
1266 : a9 00 __ LDA #$00
1268 : 85 43 __ STA T0 + 0 
126a : a5 15 __ LDA P8 ; (s + 0)
126c : f0 23 __ BEQ $1291 ; (nforml.s159 + 0)
.s4:
126e : a5 14 __ LDA P7 ; (v + 3)
1270 : f0 1f __ BEQ $1291 ; (nforml.s159 + 0)
.s1032:
1272 : 10 1d __ BPL $1291 ; (nforml.s159 + 0)
.s1:
1274 : 38 __ __ SEC
1275 : a9 00 __ LDA #$00
1277 : e5 11 __ SBC P4 ; (v + 0)
1279 : 85 11 __ STA P4 ; (v + 0)
127b : a9 00 __ LDA #$00
127d : e5 12 __ SBC P5 ; (v + 1)
127f : 85 12 __ STA P5 ; (v + 1)
1281 : a9 00 __ LDA #$00
1283 : e5 13 __ SBC P6 ; (v + 2)
1285 : 85 13 __ STA P6 ; (v + 2)
1287 : a9 00 __ LDA #$00
1289 : e5 14 __ SBC P7 ; (v + 3)
128b : 85 14 __ STA P7 ; (v + 3)
128d : a9 01 __ LDA #$01
128f : 85 43 __ STA T0 + 0 
.s159:
1291 : a9 10 __ LDA #$10
1293 : 85 44 __ STA T2 + 0 
1295 : a5 14 __ LDA P7 ; (v + 3)
1297 : f0 03 __ BEQ $129c ; (nforml.s1018 + 0)
1299 : 4c 80 13 JMP $1380 ; (nforml.l6 + 0)
.s1018:
129c : a5 13 __ LDA P6 ; (v + 2)
129e : f0 03 __ BEQ $12a3 ; (nforml.s1019 + 0)
12a0 : 4c 80 13 JMP $1380 ; (nforml.l6 + 0)
.s1019:
12a3 : a5 12 __ LDA P5 ; (v + 1)
12a5 : f0 03 __ BEQ $12aa ; (nforml.s1020 + 0)
12a7 : 4c 80 13 JMP $1380 ; (nforml.l6 + 0)
.s1020:
12aa : c5 11 __ CMP P4 ; (v + 0)
12ac : b0 03 __ BCS $12b1 ; (nforml.s7 + 0)
12ae : 4c 80 13 JMP $1380 ; (nforml.l6 + 0)
.s7:
12b1 : a0 02 __ LDY #$02
12b3 : b1 0d __ LDA (P0),y ; (si + 0)
12b5 : c9 ff __ CMP #$ff
12b7 : d0 04 __ BNE $12bd ; (nforml.s76 + 0)
.s77:
12b9 : a9 0f __ LDA #$0f
12bb : d0 05 __ BNE $12c2 ; (nforml.s1039 + 0)
.s76:
12bd : 38 __ __ SEC
12be : a9 10 __ LDA #$10
12c0 : f1 0d __ SBC (P0),y ; (si + 0)
.s1039:
12c2 : a8 __ __ TAY
12c3 : c4 44 __ CPY T2 + 0 
12c5 : b0 0d __ BCS $12d4 ; (nforml.s13 + 0)
.s12:
12c7 : a9 30 __ LDA #$30
.l1040:
12c9 : c6 44 __ DEC T2 + 0 
12cb : a6 44 __ LDX T2 + 0 
12cd : 9d e6 9f STA $9fe6,x ; (buffer + 0)
12d0 : c4 44 __ CPY T2 + 0 
12d2 : 90 f5 __ BCC $12c9 ; (nforml.l1040 + 0)
.s13:
12d4 : a0 07 __ LDY #$07
12d6 : b1 0d __ LDA (P0),y ; (si + 0)
12d8 : f0 20 __ BEQ $12fa ; (nforml.s16 + 0)
.s17:
12da : a0 04 __ LDY #$04
12dc : b1 0d __ LDA (P0),y ; (si + 0)
12de : d0 1a __ BNE $12fa ; (nforml.s16 + 0)
.s1013:
12e0 : 88 __ __ DEY
12e1 : b1 0d __ LDA (P0),y ; (si + 0)
12e3 : c9 10 __ CMP #$10
12e5 : d0 13 __ BNE $12fa ; (nforml.s16 + 0)
.s14:
12e7 : a9 58 __ LDA #$58
12e9 : a6 44 __ LDX T2 + 0 
12eb : 9d e5 9f STA $9fe5,x ; (si + 7)
12ee : 8a __ __ TXA
12ef : 18 __ __ CLC
12f0 : 69 fe __ ADC #$fe
12f2 : 85 44 __ STA T2 + 0 
12f4 : aa __ __ TAX
12f5 : a9 30 __ LDA #$30
12f7 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
.s16:
12fa : a9 00 __ LDA #$00
12fc : 85 1b __ STA ACCU + 0 
12fe : a5 43 __ LDA T0 + 0 
1300 : f0 06 __ BEQ $1308 ; (nforml.s19 + 0)
.s18:
1302 : c6 44 __ DEC T2 + 0 
1304 : a9 2d __ LDA #$2d
1306 : d0 0a __ BNE $1312 ; (nforml.s1038 + 0)
.s19:
1308 : a0 05 __ LDY #$05
130a : b1 0d __ LDA (P0),y ; (si + 0)
130c : f0 09 __ BEQ $1317 ; (nforml.s141 + 0)
.s21:
130e : c6 44 __ DEC T2 + 0 
1310 : a9 2b __ LDA #$2b
.s1038:
1312 : a6 44 __ LDX T2 + 0 
1314 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
.s141:
1317 : a0 06 __ LDY #$06
1319 : b1 0d __ LDA (P0),y ; (si + 0)
131b : d0 37 __ BNE $1354 ; (nforml.s27 + 0)
.l33:
131d : a0 01 __ LDY #$01
131f : b1 0d __ LDA (P0),y ; (si + 0)
1321 : 18 __ __ CLC
1322 : 65 44 __ ADC T2 + 0 
1324 : b0 04 __ BCS $132a ; (nforml.s34 + 0)
.s1006:
1326 : c9 11 __ CMP #$11
1328 : 90 0e __ BCC $1338 ; (nforml.s36 + 0)
.s34:
132a : c6 44 __ DEC T2 + 0 
132c : a0 00 __ LDY #$00
132e : b1 0d __ LDA (P0),y ; (si + 0)
1330 : a6 44 __ LDX T2 + 0 
1332 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
1335 : 4c 1d 13 JMP $131d ; (nforml.l33 + 0)
.s36:
1338 : a6 44 __ LDX T2 + 0 
133a : e0 10 __ CPX #$10
133c : b0 11 __ BCS $134f ; (nforml.s26 + 0)
.s1035:
133e : 88 __ __ DEY
.l1044:
133f : bd e6 9f LDA $9fe6,x ; (buffer + 0)
1342 : 91 0f __ STA (P2),y ; (str + 0)
1344 : e6 44 __ INC T2 + 0 
1346 : a6 44 __ LDX T2 + 0 
1348 : e0 10 __ CPX #$10
134a : c8 __ __ INY
134b : 90 f2 __ BCC $133f ; (nforml.l1044 + 0)
.s1045:
134d : 84 1b __ STY ACCU + 0 
.s26:
134f : a9 00 __ LDA #$00
1351 : 85 1c __ STA ACCU + 1 
.s1001:
1353 : 60 __ __ RTS
.s27:
1354 : a6 44 __ LDX T2 + 0 
1356 : e0 10 __ CPX #$10
1358 : b0 12 __ BCS $136c ; (nforml.l30 + 0)
.s1033:
135a : a0 00 __ LDY #$00
.l1042:
135c : bd e6 9f LDA $9fe6,x ; (buffer + 0)
135f : 91 0f __ STA (P2),y ; (str + 0)
1361 : e6 44 __ INC T2 + 0 
1363 : a6 44 __ LDX T2 + 0 
1365 : e0 10 __ CPX #$10
1367 : c8 __ __ INY
1368 : 90 f2 __ BCC $135c ; (nforml.l1042 + 0)
.s1043:
136a : 84 1b __ STY ACCU + 0 
.l30:
136c : a5 1b __ LDA ACCU + 0 
136e : a0 01 __ LDY #$01
1370 : d1 0d __ CMP (P0),y ; (si + 0)
1372 : b0 db __ BCS $134f ; (nforml.s26 + 0)
.s31:
1374 : 88 __ __ DEY
1375 : b1 0d __ LDA (P0),y ; (si + 0)
1377 : a4 1b __ LDY ACCU + 0 
1379 : 91 0f __ STA (P2),y ; (str + 0)
137b : e6 1b __ INC ACCU + 0 
137d : 4c 6c 13 JMP $136c ; (nforml.l30 + 0)
.l6:
1380 : a0 03 __ LDY #$03
1382 : b1 0d __ LDA (P0),y ; (si + 0)
1384 : 85 03 __ STA WORK + 0 
1386 : 85 45 __ STA T6 + 0 
1388 : c8 __ __ INY
1389 : b1 0d __ LDA (P0),y ; (si + 0)
138b : 85 46 __ STA T6 + 1 
138d : 85 04 __ STA WORK + 1 
138f : a5 11 __ LDA P4 ; (v + 0)
1391 : 85 1b __ STA ACCU + 0 
1393 : a5 12 __ LDA P5 ; (v + 1)
1395 : 85 1c __ STA ACCU + 1 
1397 : a5 13 __ LDA P6 ; (v + 2)
1399 : 85 1d __ STA ACCU + 2 
139b : a5 14 __ LDA P7 ; (v + 3)
139d : 85 1e __ STA ACCU + 3 
139f : a9 00 __ LDA #$00
13a1 : 85 05 __ STA WORK + 2 
13a3 : 85 06 __ STA WORK + 3 
13a5 : 20 dc 23 JSR $23dc ; (divmod32 + 0)
13a8 : a5 08 __ LDA WORK + 5 
13aa : 30 10 __ BMI $13bc ; (nforml.s9 + 0)
.s1023:
13ac : d0 06 __ BNE $13b4 ; (nforml.s8 + 0)
.s1022:
13ae : a5 07 __ LDA WORK + 4 
13b0 : c9 0a __ CMP #$0a
13b2 : 90 08 __ BCC $13bc ; (nforml.s9 + 0)
.s8:
13b4 : 18 __ __ CLC
13b5 : a5 07 __ LDA WORK + 4 
13b7 : 69 37 __ ADC #$37
13b9 : 4c c1 13 JMP $13c1 ; (nforml.s10 + 0)
.s9:
13bc : 18 __ __ CLC
13bd : a5 07 __ LDA WORK + 4 
13bf : 69 30 __ ADC #$30
.s10:
13c1 : c6 44 __ DEC T2 + 0 
13c3 : a6 44 __ LDX T2 + 0 
13c5 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
13c8 : a5 11 __ LDA P4 ; (v + 0)
13ca : 85 1b __ STA ACCU + 0 
13cc : a5 12 __ LDA P5 ; (v + 1)
13ce : 85 1c __ STA ACCU + 1 
13d0 : a5 13 __ LDA P6 ; (v + 2)
13d2 : 85 1d __ STA ACCU + 2 
13d4 : a5 14 __ LDA P7 ; (v + 3)
13d6 : 85 1e __ STA ACCU + 3 
13d8 : a5 45 __ LDA T6 + 0 
13da : 85 03 __ STA WORK + 0 
13dc : a5 46 __ LDA T6 + 1 
13de : 85 04 __ STA WORK + 1 
13e0 : a9 00 __ LDA #$00
13e2 : 85 05 __ STA WORK + 2 
13e4 : 85 06 __ STA WORK + 3 
13e6 : 20 dc 23 JSR $23dc ; (divmod32 + 0)
13e9 : a5 1b __ LDA ACCU + 0 
13eb : 85 11 __ STA P4 ; (v + 0)
13ed : a5 1c __ LDA ACCU + 1 
13ef : 85 12 __ STA P5 ; (v + 1)
13f1 : a5 1d __ LDA ACCU + 2 
13f3 : 85 13 __ STA P6 ; (v + 2)
13f5 : a5 1e __ LDA ACCU + 3 
13f7 : 85 14 __ STA P7 ; (v + 3)
13f9 : d0 85 __ BNE $1380 ; (nforml.l6 + 0)
13fb : 4c 9c 12 JMP $129c ; (nforml.s1018 + 0)
--------------------------------------------------------------------
nformf:
.s0:
13fe : a5 15 __ LDA P8 ; (f + 0)
1400 : 85 43 __ STA T1 + 0 
1402 : a5 16 __ LDA P9 ; (f + 1)
1404 : 85 44 __ STA T1 + 1 
1406 : a5 17 __ LDA P10 ; (f + 2)
1408 : 85 45 __ STA T1 + 2 
140a : a5 18 __ LDA P11 ; (f + 3)
140c : 29 7f __ AND #$7f
140e : 05 17 __ ORA P10 ; (f + 2)
1410 : 05 16 __ ORA P9 ; (f + 1)
1412 : 05 15 __ ORA P8 ; (f + 0)
1414 : f0 21 __ BEQ $1437 ; (nformf.s2 + 0)
.s1005:
1416 : a5 18 __ LDA P11 ; (f + 3)
1418 : 10 1d __ BPL $1437 ; (nformf.s2 + 0)
.s1:
141a : a9 2d __ LDA #$2d
141c : a0 00 __ LDY #$00
141e : 91 13 __ STA (P6),y ; (str + 0)
1420 : a5 18 __ LDA P11 ; (f + 3)
1422 : 49 80 __ EOR #$80
1424 : 85 18 __ STA P11 ; (f + 3)
1426 : 85 10 __ STA P3 
1428 : a5 15 __ LDA P8 ; (f + 0)
142a : 85 0d __ STA P0 
142c : a5 16 __ LDA P9 ; (f + 1)
142e : 85 0e __ STA P1 
1430 : a5 17 __ LDA P10 ; (f + 2)
1432 : 85 0f __ STA P2 
1434 : 4c b7 18 JMP $18b7 ; (nformf.s189 + 0)
.s2:
1437 : a5 15 __ LDA P8 ; (f + 0)
1439 : 85 0d __ STA P0 
143b : a5 16 __ LDA P9 ; (f + 1)
143d : 85 0e __ STA P1 
143f : a5 17 __ LDA P10 ; (f + 2)
1441 : 85 0f __ STA P2 
1443 : a5 18 __ LDA P11 ; (f + 3)
1445 : 85 10 __ STA P3 
1447 : a0 05 __ LDY #$05
1449 : b1 11 __ LDA (P4),y ; (si + 0)
144b : f0 09 __ BEQ $1456 ; (nformf.s3 + 0)
.s4:
144d : a9 2b __ LDA #$2b
144f : a0 00 __ LDY #$00
1451 : 91 13 __ STA (P6),y ; (str + 0)
1453 : 4c b7 18 JMP $18b7 ; (nformf.s189 + 0)
.s3:
1456 : 20 cf 18 JSR $18cf ; (isinf.s0 + 0)
1459 : aa __ __ TAX
145a : a9 00 __ LDA #$00
145c : 85 48 __ STA T3 + 0 
145e : 8a __ __ TXA
145f : f0 0b __ BEQ $146c ; (nformf.s8 + 0)
.s160:
1461 : a9 01 __ LDA #$01
1463 : 85 4a __ STA T5 + 0 
1465 : a9 02 __ LDA #$02
1467 : a0 00 __ LDY #$00
1469 : 4c 9b 18 JMP $189b ; (nformf.s7 + 0)
.s8:
146c : a0 02 __ LDY #$02
146e : b1 11 __ LDA (P4),y ; (si + 0)
1470 : c9 ff __ CMP #$ff
1472 : d0 02 __ BNE $1476 ; (nformf.s128 + 0)
.s129:
1474 : a9 06 __ LDA #$06
.s128:
1476 : 86 4a __ STX T5 + 0 
1478 : 86 4b __ STX T5 + 1 
147a : 85 49 __ STA T4 + 0 
147c : 85 47 __ STA T2 + 0 
147e : a5 18 __ LDA P11 ; (f + 3)
1480 : 85 46 __ STA T1 + 3 
1482 : 29 7f __ AND #$7f
1484 : 05 17 __ ORA P10 ; (f + 2)
1486 : 05 16 __ ORA P9 ; (f + 1)
1488 : 05 15 __ ORA P8 ; (f + 0)
148a : f0 03 __ BEQ $148f ; (nformf.s12 + 0)
148c : 4c 9c 17 JMP $179c ; (nformf.s13 + 0)
.s12:
148f : ad f6 9f LDA $9ff6 ; (sstack + 0)
1492 : c9 65 __ CMP #$65
1494 : d0 04 __ BNE $149a ; (nformf.s1007 + 0)
.s1006:
1496 : a9 01 __ LDA #$01
1498 : d0 02 __ BNE $149c ; (nformf.s1008 + 0)
.s1007:
149a : a9 00 __ LDA #$00
.s1008:
149c : 85 4e __ STA T9 + 0 
149e : a6 49 __ LDX T4 + 0 
14a0 : e8 __ __ INX
14a1 : 86 4c __ STX T8 + 0 
14a3 : ad f6 9f LDA $9ff6 ; (sstack + 0)
14a6 : c9 67 __ CMP #$67
14a8 : d0 13 __ BNE $14bd ; (nformf.s24 + 0)
.s22:
14aa : a5 4b __ LDA T5 + 1 
14ac : 30 08 __ BMI $14b6 ; (nformf.s25 + 0)
.s1050:
14ae : d0 06 __ BNE $14b6 ; (nformf.s25 + 0)
.s1049:
14b0 : a5 4a __ LDA T5 + 0 
14b2 : c9 04 __ CMP #$04
14b4 : 90 07 __ BCC $14bd ; (nformf.s24 + 0)
.s25:
14b6 : a9 01 __ LDA #$01
14b8 : 85 4e __ STA T9 + 0 
14ba : 4c 14 17 JMP $1714 ; (nformf.s30 + 0)
.s24:
14bd : a5 4e __ LDA T9 + 0 
14bf : f0 03 __ BEQ $14c4 ; (nformf.s32 + 0)
14c1 : 4c 14 17 JMP $1714 ; (nformf.s30 + 0)
.s32:
14c4 : a5 4b __ LDA T5 + 1 
14c6 : 10 3e __ BPL $1506 ; (nformf.s34 + 0)
.s33:
14c8 : a5 43 __ LDA T1 + 0 
14ca : 85 1b __ STA ACCU + 0 
14cc : a5 44 __ LDA T1 + 1 
14ce : 85 1c __ STA ACCU + 1 
14d0 : a5 45 __ LDA T1 + 2 
14d2 : 85 1d __ STA ACCU + 2 
14d4 : a5 46 __ LDA T1 + 3 
14d6 : 85 1e __ STA ACCU + 3 
.l1085:
14d8 : e6 4a __ INC T5 + 0 
14da : d0 02 __ BNE $14de ; (nformf.s1095 + 0)
.s1094:
14dc : e6 4b __ INC T5 + 1 
.s1095:
14de : a9 00 __ LDA #$00
14e0 : 85 03 __ STA WORK + 0 
14e2 : 85 04 __ STA WORK + 1 
14e4 : a9 20 __ LDA #$20
14e6 : 85 05 __ STA WORK + 2 
14e8 : a9 41 __ LDA #$41
14ea : 85 06 __ STA WORK + 3 
14ec : 20 d2 1f JSR $1fd2 ; (freg + 20)
14ef : 20 b9 21 JSR $21b9 ; (fdiv + 0)
14f2 : a5 4b __ LDA T5 + 1 
14f4 : 30 e2 __ BMI $14d8 ; (nformf.l1085 + 0)
.s1086:
14f6 : a5 1e __ LDA ACCU + 3 
14f8 : 85 46 __ STA T1 + 3 
14fa : a5 1d __ LDA ACCU + 2 
14fc : 85 45 __ STA T1 + 2 
14fe : a5 1c __ LDA ACCU + 1 
1500 : 85 44 __ STA T1 + 1 
1502 : a5 1b __ LDA ACCU + 0 
1504 : 85 43 __ STA T1 + 0 
.s34:
1506 : 18 __ __ CLC
1507 : a5 49 __ LDA T4 + 0 
1509 : 65 4a __ ADC T5 + 0 
150b : 18 __ __ CLC
150c : 69 01 __ ADC #$01
150e : 85 4c __ STA T8 + 0 
1510 : c9 07 __ CMP #$07
1512 : 90 13 __ BCC $1527 ; (nformf.s35 + 0)
.s36:
1514 : ad 19 25 LDA $2519 ; (fround5 + 25)
1517 : 85 1c __ STA ACCU + 1 
1519 : ad 1a 25 LDA $251a ; (fround5 + 26)
151c : 85 1d __ STA ACCU + 2 
151e : ad 1b 25 LDA $251b ; (fround5 + 27)
1521 : ae 18 25 LDX $2518 ; (fround5 + 24)
1524 : 4c 3a 15 JMP $153a ; (nformf.s214 + 0)
.s35:
1527 : 0a __ __ ASL
1528 : 0a __ __ ASL
1529 : a8 __ __ TAY
152a : b9 fd 24 LDA $24fd,y ; (joyy + 0)
152d : 85 1c __ STA ACCU + 1 
152f : b9 fe 24 LDA $24fe,y ; (joyy + 1)
1532 : 85 1d __ STA ACCU + 2 
1534 : b9 ff 24 LDA $24ff,y 
1537 : be fc 24 LDX $24fc,y ; (game + 4)
.s214:
153a : 86 1b __ STX ACCU + 0 
153c : 85 1e __ STA ACCU + 3 
153e : a2 43 __ LDX #$43
1540 : 20 c2 1f JSR $1fc2 ; (freg + 4)
1543 : 20 03 20 JSR $2003 ; (faddsub + 0)
1546 : a5 1c __ LDA ACCU + 1 
1548 : 85 16 __ STA P9 ; (f + 1)
154a : a5 1d __ LDA ACCU + 2 
154c : 85 17 __ STA P10 ; (f + 2)
154e : a6 1b __ LDX ACCU + 0 
1550 : a5 1e __ LDA ACCU + 3 
1552 : 85 18 __ STA P11 ; (f + 3)
1554 : 30 35 __ BMI $158b ; (nformf.s31 + 0)
.s1032:
1556 : c9 41 __ CMP #$41
1558 : d0 06 __ BNE $1560 ; (nformf.s1036 + 0)
.s1033:
155a : a5 17 __ LDA P10 ; (f + 2)
155c : c9 20 __ CMP #$20
155e : f0 02 __ BEQ $1562 ; (nformf.s38 + 0)
.s1036:
1560 : 90 29 __ BCC $158b ; (nformf.s31 + 0)
.s38:
1562 : a9 00 __ LDA #$00
1564 : 85 03 __ STA WORK + 0 
1566 : 85 04 __ STA WORK + 1 
1568 : a9 20 __ LDA #$20
156a : 85 05 __ STA WORK + 2 
156c : a9 41 __ LDA #$41
156e : 85 06 __ STA WORK + 3 
1570 : 20 d2 1f JSR $1fd2 ; (freg + 20)
1573 : 20 b9 21 JSR $21b9 ; (fdiv + 0)
1576 : a5 1c __ LDA ACCU + 1 
1578 : 85 16 __ STA P9 ; (f + 1)
157a : a5 1d __ LDA ACCU + 2 
157c : 85 17 __ STA P10 ; (f + 2)
157e : a5 1e __ LDA ACCU + 3 
1580 : 85 18 __ STA P11 ; (f + 3)
1582 : 18 __ __ CLC
1583 : a5 49 __ LDA T4 + 0 
1585 : 69 ff __ ADC #$ff
1587 : 85 47 __ STA T2 + 0 
1589 : a6 1b __ LDX ACCU + 0 
.s31:
158b : 38 __ __ SEC
158c : a5 4c __ LDA T8 + 0 
158e : e5 47 __ SBC T2 + 0 
1590 : 85 49 __ STA T4 + 0 
1592 : a9 14 __ LDA #$14
1594 : c5 4c __ CMP T8 + 0 
1596 : b0 02 __ BCS $159a ; (nformf.s49 + 0)
.s47:
1598 : 85 4c __ STA T8 + 0 
.s49:
159a : a5 49 __ LDA T4 + 0 
159c : d0 08 __ BNE $15a6 ; (nformf.s219 + 0)
.s50:
159e : a9 30 __ LDA #$30
15a0 : a4 48 __ LDY T3 + 0 
15a2 : 91 13 __ STA (P6),y ; (str + 0)
15a4 : e6 48 __ INC T3 + 0 
.s219:
15a6 : a9 00 __ LDA #$00
15a8 : 85 47 __ STA T2 + 0 
15aa : c5 49 __ CMP T4 + 0 
15ac : d0 08 __ BNE $15b6 ; (nformf.l59 + 0)
.l57:
15ae : a9 2e __ LDA #$2e
15b0 : a4 48 __ LDY T3 + 0 
15b2 : 91 13 __ STA (P6),y ; (str + 0)
15b4 : e6 48 __ INC T3 + 0 
.l59:
15b6 : a5 47 __ LDA T2 + 0 
15b8 : c9 07 __ CMP #$07
15ba : 90 04 __ BCC $15c0 ; (nformf.s61 + 0)
.s60:
15bc : a9 30 __ LDA #$30
15be : d0 55 __ BNE $1615 ; (nformf.s208 + 0)
.s61:
15c0 : 86 1b __ STX ACCU + 0 
15c2 : 86 43 __ STX T1 + 0 
15c4 : a5 16 __ LDA P9 ; (f + 1)
15c6 : 85 1c __ STA ACCU + 1 
15c8 : 85 44 __ STA T1 + 1 
15ca : a5 17 __ LDA P10 ; (f + 2)
15cc : 85 1d __ STA ACCU + 2 
15ce : 85 45 __ STA T1 + 2 
15d0 : a5 18 __ LDA P11 ; (f + 3)
15d2 : 85 1e __ STA ACCU + 3 
15d4 : 85 46 __ STA T1 + 3 
15d6 : 20 4f 23 JSR $234f ; (f32_to_i16 + 0)
15d9 : a5 1b __ LDA ACCU + 0 
15db : 85 4f __ STA T11 + 0 
15dd : 20 91 23 JSR $2391 ; (sint16_to_float + 0)
15e0 : a2 43 __ LDX #$43
15e2 : 20 c2 1f JSR $1fc2 ; (freg + 4)
15e5 : a5 1e __ LDA ACCU + 3 
15e7 : 49 80 __ EOR #$80
15e9 : 85 1e __ STA ACCU + 3 
15eb : 20 03 20 JSR $2003 ; (faddsub + 0)
15ee : a9 00 __ LDA #$00
15f0 : 85 03 __ STA WORK + 0 
15f2 : 85 04 __ STA WORK + 1 
15f4 : a9 20 __ LDA #$20
15f6 : 85 05 __ STA WORK + 2 
15f8 : a9 41 __ LDA #$41
15fa : 85 06 __ STA WORK + 3 
15fc : 20 d2 1f JSR $1fd2 ; (freg + 20)
15ff : 20 ea 20 JSR $20ea ; (fmul + 0)
1602 : a5 1c __ LDA ACCU + 1 
1604 : 85 16 __ STA P9 ; (f + 1)
1606 : a5 1d __ LDA ACCU + 2 
1608 : 85 17 __ STA P10 ; (f + 2)
160a : a5 1e __ LDA ACCU + 3 
160c : 85 18 __ STA P11 ; (f + 3)
160e : 18 __ __ CLC
160f : a5 4f __ LDA T11 + 0 
1611 : 69 30 __ ADC #$30
1613 : a6 1b __ LDX ACCU + 0 
.s208:
1615 : a4 48 __ LDY T3 + 0 
1617 : 91 13 __ STA (P6),y ; (str + 0)
1619 : e6 48 __ INC T3 + 0 
161b : e6 47 __ INC T2 + 0 
161d : a5 47 __ LDA T2 + 0 
161f : c5 4c __ CMP T8 + 0 
1621 : b0 07 __ BCS $162a ; (nformf.s56 + 0)
.s54:
1623 : c5 49 __ CMP T4 + 0 
1625 : d0 8f __ BNE $15b6 ; (nformf.l59 + 0)
1627 : 4c ae 15 JMP $15ae ; (nformf.l57 + 0)
.s56:
162a : a5 4e __ LDA T9 + 0 
162c : f0 62 __ BEQ $1690 ; (nformf.s9 + 0)
.s63:
162e : a9 45 __ LDA #$45
1630 : a4 48 __ LDY T3 + 0 
1632 : 91 13 __ STA (P6),y ; (str + 0)
1634 : c8 __ __ INY
1635 : a5 4b __ LDA T5 + 1 
1637 : 30 06 __ BMI $163f ; (nformf.s66 + 0)
.s67:
1639 : a9 2b __ LDA #$2b
163b : 91 13 __ STA (P6),y ; (str + 0)
163d : d0 11 __ BNE $1650 ; (nformf.s68 + 0)
.s66:
163f : a9 2d __ LDA #$2d
1641 : 91 13 __ STA (P6),y ; (str + 0)
1643 : 38 __ __ SEC
1644 : a9 00 __ LDA #$00
1646 : e5 4a __ SBC T5 + 0 
1648 : 85 4a __ STA T5 + 0 
164a : a9 00 __ LDA #$00
164c : e5 4b __ SBC T5 + 1 
164e : 85 4b __ STA T5 + 1 
.s68:
1650 : a5 4a __ LDA T5 + 0 
1652 : 85 1b __ STA ACCU + 0 
1654 : a5 4b __ LDA T5 + 1 
1656 : 85 1c __ STA ACCU + 1 
1658 : a9 0a __ LDA #$0a
165a : 85 03 __ STA WORK + 0 
165c : a9 00 __ LDA #$00
165e : 85 04 __ STA WORK + 1 
1660 : 20 67 22 JSR $2267 ; (divs16 + 0)
1663 : 18 __ __ CLC
1664 : a5 1b __ LDA ACCU + 0 
1666 : 69 30 __ ADC #$30
1668 : a4 48 __ LDY T3 + 0 
166a : c8 __ __ INY
166b : c8 __ __ INY
166c : 91 13 __ STA (P6),y ; (str + 0)
166e : a5 4a __ LDA T5 + 0 
1670 : 85 1b __ STA ACCU + 0 
1672 : a5 4b __ LDA T5 + 1 
1674 : 85 1c __ STA ACCU + 1 
1676 : a9 0a __ LDA #$0a
1678 : 85 03 __ STA WORK + 0 
167a : a9 00 __ LDA #$00
167c : 85 04 __ STA WORK + 1 
167e : 20 26 23 JSR $2326 ; (mods16 + 0)
1681 : 18 __ __ CLC
1682 : a5 05 __ LDA WORK + 2 
1684 : 69 30 __ ADC #$30
1686 : a4 48 __ LDY T3 + 0 
1688 : c8 __ __ INY
1689 : c8 __ __ INY
168a : c8 __ __ INY
168b : 91 13 __ STA (P6),y ; (str + 0)
168d : c8 __ __ INY
168e : 84 48 __ STY T3 + 0 
.s9:
1690 : a5 11 __ LDA P4 ; (si + 0)
1692 : 85 4a __ STA T5 + 0 
1694 : a5 12 __ LDA P5 ; (si + 1)
1696 : 85 4b __ STA T5 + 1 
1698 : a5 48 __ LDA T3 + 0 
169a : a0 01 __ LDY #$01
169c : d1 11 __ CMP (P4),y ; (si + 0)
169e : b0 5d __ BCS $16fd ; (nformf.s1001 + 0)
.s69:
16a0 : a0 06 __ LDY #$06
16a2 : b1 11 __ LDA (P4),y ; (si + 0)
16a4 : f0 06 __ BEQ $16ac ; (nformf.s73 + 0)
.s72:
16a6 : a5 48 __ LDA T3 + 0 
16a8 : aa __ __ TAX
16a9 : 4c 04 17 JMP $1704 ; (nformf.l75 + 0)
.s73:
16ac : a5 48 __ LDA T3 + 0 
16ae : f0 2d __ BEQ $16dd ; (nformf.s82 + 0)
.s90:
16b0 : a9 01 __ LDA #$01
16b2 : 85 47 __ STA T2 + 0 
16b4 : a6 48 __ LDX T3 + 0 
16b6 : 38 __ __ SEC
.l1083:
16b7 : a0 01 __ LDY #$01
16b9 : b1 11 __ LDA (P4),y ; (si + 0)
16bb : e5 47 __ SBC T2 + 0 
16bd : 85 4c __ STA T8 + 0 
16bf : a9 ff __ LDA #$ff
16c1 : 65 14 __ ADC P7 ; (str + 1)
16c3 : 85 4d __ STA T8 + 1 
16c5 : 8a __ __ TXA
16c6 : 38 __ __ SEC
16c7 : e5 47 __ SBC T2 + 0 
16c9 : 85 1b __ STA ACCU + 0 
16cb : a9 ff __ LDA #$ff
16cd : 65 14 __ ADC P7 ; (str + 1)
16cf : 85 1c __ STA ACCU + 1 
16d1 : a4 13 __ LDY P6 ; (str + 0)
16d3 : b1 1b __ LDA (ACCU + 0),y 
16d5 : 91 4c __ STA (T8 + 0),y 
16d7 : e6 47 __ INC T2 + 0 
16d9 : e4 47 __ CPX T2 + 0 
16db : b0 da __ BCS $16b7 ; (nformf.l1083 + 0)
.s82:
16dd : a9 00 __ LDA #$00
16df : 85 47 __ STA T2 + 0 
.l83:
16e1 : a0 01 __ LDY #$01
16e3 : b1 4a __ LDA (T5 + 0),y 
16e5 : 38 __ __ SEC
16e6 : e5 48 __ SBC T3 + 0 
16e8 : 90 06 __ BCC $16f0 ; (nformf.s84 + 0)
.s1011:
16ea : c5 47 __ CMP T2 + 0 
16ec : 90 0d __ BCC $16fb ; (nformf.s74 + 0)
.s1087:
16ee : f0 0b __ BEQ $16fb ; (nformf.s74 + 0)
.s84:
16f0 : a9 20 __ LDA #$20
16f2 : a4 47 __ LDY T2 + 0 
16f4 : 91 13 __ STA (P6),y ; (str + 0)
16f6 : e6 47 __ INC T2 + 0 
16f8 : 4c e1 16 JMP $16e1 ; (nformf.l83 + 0)
.s74:
16fb : b1 11 __ LDA (P4),y ; (si + 0)
.s1001:
16fd : 85 1b __ STA ACCU + 0 
16ff : a9 00 __ LDA #$00
1701 : 85 1c __ STA ACCU + 1 
1703 : 60 __ __ RTS
.l75:
1704 : a0 01 __ LDY #$01
1706 : d1 4a __ CMP (T5 + 0),y 
1708 : b0 f1 __ BCS $16fb ; (nformf.s74 + 0)
.s76:
170a : a8 __ __ TAY
170b : a9 20 __ LDA #$20
170d : 91 13 __ STA (P6),y ; (str + 0)
170f : e8 __ __ INX
1710 : 8a __ __ TXA
1711 : 4c 04 17 JMP $1704 ; (nformf.l75 + 0)
.s30:
1714 : a5 4c __ LDA T8 + 0 
1716 : c9 07 __ CMP #$07
1718 : 90 13 __ BCC $172d ; (nformf.s41 + 0)
.s42:
171a : ad 19 25 LDA $2519 ; (fround5 + 25)
171d : 85 1c __ STA ACCU + 1 
171f : ad 1a 25 LDA $251a ; (fround5 + 26)
1722 : 85 1d __ STA ACCU + 2 
1724 : ad 1b 25 LDA $251b ; (fround5 + 27)
1727 : ae 18 25 LDX $2518 ; (fround5 + 24)
172a : 4c 40 17 JMP $1740 ; (nformf.s204 + 0)
.s41:
172d : 0a __ __ ASL
172e : 0a __ __ ASL
172f : a8 __ __ TAY
1730 : b9 fd 24 LDA $24fd,y ; (joyy + 0)
1733 : 85 1c __ STA ACCU + 1 
1735 : b9 fe 24 LDA $24fe,y ; (joyy + 1)
1738 : 85 1d __ STA ACCU + 2 
173a : b9 ff 24 LDA $24ff,y 
173d : be fc 24 LDX $24fc,y ; (game + 4)
.s204:
1740 : 86 1b __ STX ACCU + 0 
1742 : 85 1e __ STA ACCU + 3 
1744 : a2 43 __ LDX #$43
1746 : 20 c2 1f JSR $1fc2 ; (freg + 4)
1749 : 20 03 20 JSR $2003 ; (faddsub + 0)
174c : a5 1c __ LDA ACCU + 1 
174e : 85 16 __ STA P9 ; (f + 1)
1750 : a5 1d __ LDA ACCU + 2 
1752 : 85 17 __ STA P10 ; (f + 2)
1754 : a6 1b __ LDX ACCU + 0 
1756 : a5 1e __ LDA ACCU + 3 
1758 : 85 18 __ STA P11 ; (f + 3)
175a : 10 03 __ BPL $175f ; (nformf.s1042 + 0)
175c : 4c 8b 15 JMP $158b ; (nformf.s31 + 0)
.s1042:
175f : c9 41 __ CMP #$41
1761 : d0 06 __ BNE $1769 ; (nformf.s1046 + 0)
.s1043:
1763 : a5 17 __ LDA P10 ; (f + 2)
1765 : c9 20 __ CMP #$20
1767 : f0 05 __ BEQ $176e ; (nformf.s44 + 0)
.s1046:
1769 : b0 03 __ BCS $176e ; (nformf.s44 + 0)
176b : 4c 8b 15 JMP $158b ; (nformf.s31 + 0)
.s44:
176e : a9 00 __ LDA #$00
1770 : 85 03 __ STA WORK + 0 
1772 : 85 04 __ STA WORK + 1 
1774 : a9 20 __ LDA #$20
1776 : 85 05 __ STA WORK + 2 
1778 : a9 41 __ LDA #$41
177a : 85 06 __ STA WORK + 3 
177c : 20 d2 1f JSR $1fd2 ; (freg + 20)
177f : 20 b9 21 JSR $21b9 ; (fdiv + 0)
1782 : a5 1c __ LDA ACCU + 1 
1784 : 85 16 __ STA P9 ; (f + 1)
1786 : a5 1d __ LDA ACCU + 2 
1788 : 85 17 __ STA P10 ; (f + 2)
178a : a5 1e __ LDA ACCU + 3 
178c : 85 18 __ STA P11 ; (f + 3)
178e : a6 1b __ LDX ACCU + 0 
1790 : e6 4a __ INC T5 + 0 
1792 : f0 03 __ BEQ $1797 ; (nformf.s1092 + 0)
1794 : 4c 8b 15 JMP $158b ; (nformf.s31 + 0)
.s1092:
1797 : e6 4b __ INC T5 + 1 
1799 : 4c 8b 15 JMP $158b ; (nformf.s31 + 0)
.s13:
179c : a5 18 __ LDA P11 ; (f + 3)
179e : 30 59 __ BMI $17f9 ; (nformf.l17 + 0)
.l1072:
17a0 : c9 44 __ CMP #$44
17a2 : f0 03 __ BEQ $17a7 ; (nformf.s1073 + 0)
17a4 : 4c 96 18 JMP $1896 ; (nformf.s1076 + 0)
.s1073:
17a7 : a5 45 __ LDA T1 + 2 
17a9 : c9 7a __ CMP #$7a
17ab : f0 03 __ BEQ $17b0 ; (nformf.s1074 + 0)
17ad : 4c 96 18 JMP $1896 ; (nformf.s1076 + 0)
.s1074:
17b0 : a5 44 __ LDA T1 + 1 
17b2 : d0 04 __ BNE $17b8 ; (nformf.s1082 + 0)
.s1075:
17b4 : a5 43 __ LDA T1 + 0 
17b6 : f0 02 __ BEQ $17ba ; (nformf.s14 + 0)
.s1082:
17b8 : a5 43 __ LDA T1 + 0 
.s14:
17ba : 85 1b __ STA ACCU + 0 
17bc : a5 44 __ LDA T1 + 1 
17be : 85 1c __ STA ACCU + 1 
17c0 : a5 45 __ LDA T1 + 2 
17c2 : 85 1d __ STA ACCU + 2 
17c4 : a5 46 __ LDA T1 + 3 
17c6 : 85 1e __ STA ACCU + 3 
17c8 : a9 00 __ LDA #$00
17ca : 85 03 __ STA WORK + 0 
17cc : 85 04 __ STA WORK + 1 
17ce : a9 7a __ LDA #$7a
17d0 : 85 05 __ STA WORK + 2 
17d2 : a9 44 __ LDA #$44
17d4 : 85 06 __ STA WORK + 3 
17d6 : 20 d2 1f JSR $1fd2 ; (freg + 20)
17d9 : 20 b9 21 JSR $21b9 ; (fdiv + 0)
17dc : a5 1b __ LDA ACCU + 0 
17de : 85 43 __ STA T1 + 0 
17e0 : a5 1c __ LDA ACCU + 1 
17e2 : 85 44 __ STA T1 + 1 
17e4 : a5 1d __ LDA ACCU + 2 
17e6 : 85 45 __ STA T1 + 2 
17e8 : 18 __ __ CLC
17e9 : a5 4a __ LDA T5 + 0 
17eb : 69 03 __ ADC #$03
17ed : 85 4a __ STA T5 + 0 
17ef : 90 02 __ BCC $17f3 ; (nformf.s1097 + 0)
.s1096:
17f1 : e6 4b __ INC T5 + 1 
.s1097:
17f3 : a5 1e __ LDA ACCU + 3 
17f5 : 85 46 __ STA T1 + 3 
17f7 : 10 a7 __ BPL $17a0 ; (nformf.l1072 + 0)
.l17:
17f9 : a9 00 __ LDA #$00
17fb : 85 1b __ STA ACCU + 0 
17fd : 85 1c __ STA ACCU + 1 
17ff : a9 7a __ LDA #$7a
1801 : 85 1d __ STA ACCU + 2 
1803 : a9 44 __ LDA #$44
1805 : 85 1e __ STA ACCU + 3 
1807 : a2 43 __ LDX #$43
1809 : 20 c2 1f JSR $1fc2 ; (freg + 4)
180c : 20 ea 20 JSR $20ea ; (fmul + 0)
180f : a5 1b __ LDA ACCU + 0 
1811 : 85 43 __ STA T1 + 0 
1813 : a5 1c __ LDA ACCU + 1 
1815 : 85 44 __ STA T1 + 1 
1817 : a5 1d __ LDA ACCU + 2 
1819 : 85 45 __ STA T1 + 2 
181b : a5 1e __ LDA ACCU + 3 
181d : 85 46 __ STA T1 + 3 
181f : 38 __ __ SEC
1820 : a5 4a __ LDA T5 + 0 
1822 : e9 03 __ SBC #$03
1824 : 85 4a __ STA T5 + 0 
1826 : b0 02 __ BCS $182a ; (nformf.s16 + 0)
.s1088:
1828 : c6 4b __ DEC T5 + 1 
.s16:
182a : a5 46 __ LDA T1 + 3 
182c : 30 cb __ BMI $17f9 ; (nformf.l17 + 0)
.s1064:
182e : c9 3f __ CMP #$3f
1830 : d0 06 __ BNE $1838 ; (nformf.s1068 + 0)
.s1065:
1832 : a5 45 __ LDA T1 + 2 
1834 : c9 80 __ CMP #$80
1836 : f0 02 __ BEQ $183a ; (nformf.s19 + 0)
.s1068:
1838 : 90 bf __ BCC $17f9 ; (nformf.l17 + 0)
.s19:
183a : a5 46 __ LDA T1 + 3 
183c : c9 41 __ CMP #$41
183e : d0 51 __ BNE $1891 ; (nformf.l1060 + 0)
.s1057:
1840 : a5 45 __ LDA T1 + 2 
1842 : c9 20 __ CMP #$20
1844 : d0 4b __ BNE $1891 ; (nformf.l1060 + 0)
.s1058:
1846 : a5 44 __ LDA T1 + 1 
1848 : d0 04 __ BNE $184e ; (nformf.l1081 + 0)
.s1059:
184a : a5 43 __ LDA T1 + 0 
184c : f0 02 __ BEQ $1850 ; (nformf.l20 + 0)
.l1081:
184e : a5 43 __ LDA T1 + 0 
.l20:
1850 : 85 1b __ STA ACCU + 0 
1852 : a5 44 __ LDA T1 + 1 
1854 : 85 1c __ STA ACCU + 1 
1856 : a5 45 __ LDA T1 + 2 
1858 : 85 1d __ STA ACCU + 2 
185a : a5 46 __ LDA T1 + 3 
185c : 85 1e __ STA ACCU + 3 
185e : a9 00 __ LDA #$00
1860 : 85 03 __ STA WORK + 0 
1862 : 85 04 __ STA WORK + 1 
1864 : a9 20 __ LDA #$20
1866 : 85 05 __ STA WORK + 2 
1868 : a9 41 __ LDA #$41
186a : 85 06 __ STA WORK + 3 
186c : 20 d2 1f JSR $1fd2 ; (freg + 20)
186f : 20 b9 21 JSR $21b9 ; (fdiv + 0)
1872 : a5 1b __ LDA ACCU + 0 
1874 : 85 43 __ STA T1 + 0 
1876 : a5 1c __ LDA ACCU + 1 
1878 : 85 44 __ STA T1 + 1 
187a : a5 1d __ LDA ACCU + 2 
187c : 85 45 __ STA T1 + 2 
187e : e6 4a __ INC T5 + 0 
1880 : d0 02 __ BNE $1884 ; (nformf.s1091 + 0)
.s1090:
1882 : e6 4b __ INC T5 + 1 
.s1091:
1884 : a5 1e __ LDA ACCU + 3 
1886 : 85 46 __ STA T1 + 3 
1888 : 10 03 __ BPL $188d ; (nformf.s1056 + 0)
188a : 4c 8f 14 JMP $148f ; (nformf.s12 + 0)
.s1056:
188d : c9 41 __ CMP #$41
188f : f0 af __ BEQ $1840 ; (nformf.s1057 + 0)
.l1060:
1891 : b0 bb __ BCS $184e ; (nformf.l1081 + 0)
1893 : 4c 8f 14 JMP $148f ; (nformf.s12 + 0)
.s1076:
1896 : 90 92 __ BCC $182a ; (nformf.s16 + 0)
1898 : 4c b8 17 JMP $17b8 ; (nformf.s1082 + 0)
.s7:
189b : 85 1b __ STA ACCU + 0 
189d : a9 49 __ LDA #$49
189f : 91 13 __ STA (P6),y ; (str + 0)
18a1 : a9 4e __ LDA #$4e
18a3 : a4 4a __ LDY T5 + 0 
18a5 : 91 13 __ STA (P6),y ; (str + 0)
18a7 : a9 46 __ LDA #$46
18a9 : a4 1b __ LDY ACCU + 0 
18ab : 91 13 __ STA (P6),y ; (str + 0)
18ad : 18 __ __ CLC
18ae : a5 48 __ LDA T3 + 0 
18b0 : 69 03 __ ADC #$03
18b2 : 85 48 __ STA T3 + 0 
18b4 : 4c 90 16 JMP $1690 ; (nformf.s9 + 0)
.s189:
18b7 : 20 cf 18 JSR $18cf ; (isinf.s0 + 0)
18ba : aa __ __ TAX
18bb : a9 01 __ LDA #$01
18bd : 85 48 __ STA T3 + 0 
18bf : 8a __ __ TXA
18c0 : d0 03 __ BNE $18c5 ; (nformf.s158 + 0)
18c2 : 4c 6c 14 JMP $146c ; (nformf.s8 + 0)
.s158:
18c5 : a9 02 __ LDA #$02
18c7 : 85 4a __ STA T5 + 0 
18c9 : a9 03 __ LDA #$03
18cb : a0 01 __ LDY #$01
18cd : d0 cc __ BNE $189b ; (nformf.s7 + 0)
--------------------------------------------------------------------
isinf:
.s0:
18cf : 06 0f __ ASL P2 ; (f + 2)
18d1 : a5 10 __ LDA P3 ; (f + 3)
18d3 : 2a __ __ ROL
18d4 : c9 ff __ CMP #$ff
18d6 : d0 03 __ BNE $18db ; (isinf.s1003 + 0)
.s1002:
18d8 : a9 01 __ LDA #$01
18da : 60 __ __ RTS
.s1003:
18db : a9 00 __ LDA #$00
.s1001:
18dd : 60 __ __ RTS
--------------------------------------------------------------------
fround5:
2500 : __ __ __ BYT 00 00 00 3f cd cc 4c 3d 0a d7 a3 3b 6f 12 03 3a : ...?..L=...;o..:
2510 : __ __ __ BYT 17 b7 51 38 ac c5 a7 36 bd 37 06 35             : ..Q8...6.7.5
--------------------------------------------------------------------
18de : __ __ __ BYT 25 64 00                                        : %d.
--------------------------------------------------------------------
spawn_enemy:
.s0:
18e1 : 20 51 19 JSR $1951 ; (rand.s0 + 0)
18e4 : 46 1b __ LSR ACCU + 0 
18e6 : b0 0f __ BCS $18f7 ; (spawn_enemy.s1001 + 0)
.s3:
18e8 : a0 00 __ LDY #$00
.l6:
18ea : be 72 24 LDX $2472,y ; (__multab5L + 0)
18ed : bd 20 25 LDA $2520,x ; (Enemy + 4)
18f0 : f0 06 __ BEQ $18f8 ; (spawn_enemy.s9 + 0)
.s7:
18f2 : c8 __ __ INY
18f3 : c0 0a __ CPY #$0a
18f5 : 90 f3 __ BCC $18ea ; (spawn_enemy.l6 + 0)
.s1001:
18f7 : 60 __ __ RTS
.s9:
18f8 : 86 43 __ STX T0 + 0 
18fa : a9 27 __ LDA #$27
18fc : 9d 1c 25 STA $251c,x ; (Enemy + 0)
18ff : 20 51 19 JSR $1951 ; (rand.s0 + 0)
1902 : a9 15 __ LDA #$15
1904 : 85 03 __ STA WORK + 0 
1906 : a9 00 __ LDA #$00
1908 : 85 04 __ STA WORK + 1 
190a : 20 a1 22 JSR $22a1 ; (divmod + 0)
190d : 18 __ __ CLC
190e : a5 05 __ LDA WORK + 2 
1910 : 69 04 __ ADC #$04
1912 : a6 43 __ LDX T0 + 0 
1914 : 9d 1d 25 STA $251d,x ; (Enemy + 1)
1917 : 20 51 19 JSR $1951 ; (rand.s0 + 0)
191a : a9 0e __ LDA #$0e
191c : a6 43 __ LDX T0 + 0 
191e : 9d 1f 25 STA $251f,x ; (Enemy + 3)
1921 : a9 01 __ LDA #$01
1923 : 9d 20 25 STA $2520,x ; (Enemy + 4)
1926 : a9 03 __ LDA #$03
1928 : 85 03 __ STA WORK + 0 
192a : a9 00 __ LDA #$00
192c : 85 04 __ STA WORK + 1 
192e : 20 a1 22 JSR $22a1 ; (divmod + 0)
1931 : 18 __ __ CLC
1932 : a5 05 __ LDA WORK + 2 
1934 : 69 83 __ ADC #$83
1936 : a4 43 __ LDY T0 + 0 
1938 : 99 1e 25 STA $251e,y ; (Enemy + 2)
193b : c9 83 __ CMP #$83
193d : d0 04 __ BNE $1943 ; (spawn_enemy.s13 + 0)
.s12:
193f : a9 0d __ LDA #$0d
1941 : d0 0a __ BNE $194d ; (spawn_enemy.s1008 + 0)
.s13:
1943 : c9 84 __ CMP #$84
1945 : d0 04 __ BNE $194b ; (spawn_enemy.s16 + 0)
.s15:
1947 : a9 0a __ LDA #$0a
1949 : d0 02 __ BNE $194d ; (spawn_enemy.s1008 + 0)
.s16:
194b : a9 09 __ LDA #$09
.s1008:
194d : 99 1f 25 STA $251f,y ; (Enemy + 3)
1950 : 60 __ __ RTS
--------------------------------------------------------------------
rand:
.s0:
1951 : ad ec 24 LDA $24ec ; (seed + 1)
1954 : 4a __ __ LSR
1955 : ad eb 24 LDA $24eb ; (seed + 0)
1958 : 6a __ __ ROR
1959 : aa __ __ TAX
195a : a9 00 __ LDA #$00
195c : 6a __ __ ROR
195d : 4d eb 24 EOR $24eb ; (seed + 0)
1960 : 85 1b __ STA ACCU + 0 
1962 : 8a __ __ TXA
1963 : 4d ec 24 EOR $24ec ; (seed + 1)
1966 : 85 1c __ STA ACCU + 1 
1968 : 4a __ __ LSR
1969 : 45 1b __ EOR ACCU + 0 
196b : 8d eb 24 STA $24eb ; (seed + 0)
196e : 85 1b __ STA ACCU + 0 
1970 : 45 1c __ EOR ACCU + 1 
1972 : 8d ec 24 STA $24ec ; (seed + 1)
1975 : 85 1c __ STA ACCU + 1 
.s1001:
1977 : 60 __ __ RTS
--------------------------------------------------------------------
seed:
24eb : __ __ __ BYT 00 7a                                           : .z
--------------------------------------------------------------------
move_enemies:
.s1000:
1978 : a2 03 __ LDX #$03
197a : b5 53 __ LDA T0 + 0,x 
197c : 9d 9f 9f STA $9f9f,x ; (move_enemies@stack + 0)
197f : ca __ __ DEX
1980 : 10 f8 __ BPL $197a ; (move_enemies.s1000 + 2)
.s0:
1982 : a2 00 __ LDX #$00
.l2:
1984 : 86 53 __ STX T0 + 0 
1986 : bc 72 24 LDY $2472,x ; (__multab5L + 0)
1989 : b9 20 25 LDA $2520,y ; (Enemy + 4)
198c : c9 01 __ CMP #$01
198e : d0 77 __ BNE $1a07 ; (move_enemies.s41 + 0)
.s5:
1990 : 18 __ __ CLC
1991 : a9 1c __ LDA #$1c
1993 : 7d 72 24 ADC $2472,x ; (__multab5L + 0)
1996 : 85 54 __ STA T1 + 0 
1998 : a9 25 __ LDA #$25
199a : 69 00 __ ADC #$00
199c : 85 55 __ STA T1 + 1 
199e : a0 02 __ LDY #$02
19a0 : b1 54 __ LDA (T1 + 0),y 
19a2 : c9 83 __ CMP #$83
19a4 : d0 18 __ BNE $19be ; (move_enemies.s10 + 0)
.s11:
19a6 : 88 __ __ DEY
19a7 : b1 54 __ LDA (T1 + 0),y 
19a9 : cd ee 24 CMP $24ee ; (Player + 1)
19ac : d0 10 __ BNE $19be ; (move_enemies.s10 + 0)
.s8:
19ae : a5 54 __ LDA T1 + 0 
19b0 : 8d fe 9f STA $9ffe ; (sstack + 8)
19b3 : a5 55 __ LDA T1 + 1 
19b5 : 8d ff 9f STA $9fff ; (sstack + 9)
19b8 : 20 7e 1a JSR $1a7e ; (spawn_enemy_shot.s1000 + 0)
19bb : 20 65 1b JSR $1b65 ; (render_enemy_shots.s0 + 0)
.s10:
19be : a0 00 __ LDY #$00
19c0 : b1 54 __ LDA (T1 + 0),y 
19c2 : 85 56 __ STA T3 + 0 
19c4 : c8 __ __ INY
19c5 : b1 54 __ LDA (T1 + 0),y 
19c7 : 0a __ __ ASL
19c8 : 85 1b __ STA ACCU + 0 
19ca : a9 00 __ LDA #$00
19cc : 2a __ __ ROL
19cd : 06 1b __ ASL ACCU + 0 
19cf : 2a __ __ ROL
19d0 : aa __ __ TAX
19d1 : a5 1b __ LDA ACCU + 0 
19d3 : 71 54 __ ADC (T1 + 0),y 
19d5 : 85 46 __ STA T5 + 0 
19d7 : 8a __ __ TXA
19d8 : 69 00 __ ADC #$00
19da : 06 46 __ ASL T5 + 0 
19dc : 2a __ __ ROL
19dd : 06 46 __ ASL T5 + 0 
19df : 2a __ __ ROL
19e0 : 06 46 __ ASL T5 + 0 
19e2 : 2a __ __ ROL
19e3 : aa __ __ TAX
19e4 : 18 __ __ CLC
19e5 : a5 46 __ LDA T5 + 0 
19e7 : 65 56 __ ADC T3 + 0 
19e9 : 85 43 __ STA T2 + 0 
19eb : 85 1f __ STA ADDR + 0 
19ed : 8a __ __ TXA
19ee : 69 c0 __ ADC #$c0
19f0 : 85 44 __ STA T2 + 1 
19f2 : 18 __ __ CLC
19f3 : 69 18 __ ADC #$18
19f5 : 85 20 __ STA ADDR + 1 
19f7 : a9 20 __ LDA #$20
19f9 : 88 __ __ DEY
19fa : 91 43 __ STA (T2 + 0),y 
19fc : 98 __ __ TYA
19fd : 91 1f __ STA (ADDR + 0),y 
19ff : a5 56 __ LDA T3 + 0 
1a01 : d0 19 __ BNE $1a1c ; (move_enemies.s12 + 0)
.s13:
1a03 : a0 04 __ LDY #$04
.s1020:
1a05 : 91 54 __ STA (T1 + 0),y 
.s41:
1a07 : a6 53 __ LDX T0 + 0 
1a09 : e8 __ __ INX
1a0a : e0 0a __ CPX #$0a
1a0c : b0 03 __ BCS $1a11 ; (move_enemies.s1001 + 0)
1a0e : 4c 84 19 JMP $1984 ; (move_enemies.l2 + 0)
.s1001:
1a11 : a2 03 __ LDX #$03
1a13 : bd 9f 9f LDA $9f9f,x ; (move_enemies@stack + 0)
1a16 : 95 53 __ STA T0 + 0,x 
1a18 : ca __ __ DEX
1a19 : 10 f8 __ BPL $1a13 ; (move_enemies.s1001 + 2)
1a1b : 60 __ __ RTS
.s12:
1a1c : c6 56 __ DEC T3 + 0 
1a1e : a5 56 __ LDA T3 + 0 
1a20 : 91 54 __ STA (T1 + 0),y 
1a22 : a0 02 __ LDY #$02
1a24 : b1 54 __ LDA (T1 + 0),y 
1a26 : c9 85 __ CMP #$85
1a28 : f0 dd __ BEQ $1a07 ; (move_enemies.s41 + 0)
.s15:
1a2a : 20 51 19 JSR $1951 ; (rand.s0 + 0)
1a2d : a0 01 __ LDY #$01
1a2f : b1 54 __ LDA (T1 + 0),y 
1a31 : 85 45 __ STA T4 + 0 
1a33 : a9 03 __ LDA #$03
1a35 : 85 03 __ STA WORK + 0 
1a37 : a9 00 __ LDA #$00
1a39 : 85 04 __ STA WORK + 1 
1a3b : 20 a1 22 JSR $22a1 ; (divmod + 0)
1a3e : 38 __ __ SEC
1a3f : a5 05 __ LDA WORK + 2 
1a41 : e9 01 __ SBC #$01
1a43 : aa __ __ TAX
1a44 : a5 06 __ LDA WORK + 3 
1a46 : e9 00 __ SBC #$00
1a48 : a8 __ __ TAY
1a49 : 8a __ __ TXA
1a4a : 18 __ __ CLC
1a4b : 65 45 __ ADC T4 + 0 
1a4d : 85 43 __ STA T2 + 0 
1a4f : 90 01 __ BCC $1a52 ; (move_enemies.s1022 + 0)
.s1021:
1a51 : c8 __ __ INY
.s1022:
1a52 : 0a __ __ ASL
1a53 : 0a __ __ ASL
1a54 : 18 __ __ CLC
1a55 : 65 43 __ ADC T2 + 0 
1a57 : 0a __ __ ASL
1a58 : 0a __ __ ASL
1a59 : 0a __ __ ASL
1a5a : 18 __ __ CLC
1a5b : 65 56 __ ADC T3 + 0 
1a5d : aa __ __ TAX
1a5e : bd 00 c0 LDA $c000,x 
1a61 : c9 83 __ CMP #$83
1a63 : f0 a2 __ BEQ $1a07 ; (move_enemies.s41 + 0)
.s24:
1a65 : c9 84 __ CMP #$84
1a67 : f0 9e __ BEQ $1a07 ; (move_enemies.s41 + 0)
.s23:
1a69 : c9 85 __ CMP #$85
1a6b : f0 9a __ BEQ $1a07 ; (move_enemies.s41 + 0)
.s22:
1a6d : 98 __ __ TYA
1a6e : d0 97 __ BNE $1a07 ; (move_enemies.s41 + 0)
.s1005:
1a70 : a5 43 __ LDA T2 + 0 
1a72 : c9 04 __ CMP #$04
1a74 : 90 91 __ BCC $1a07 ; (move_enemies.s41 + 0)
.s1004:
1a76 : c9 19 __ CMP #$19
1a78 : b0 8d __ BCS $1a07 ; (move_enemies.s41 + 0)
.s18:
1a7a : a0 01 __ LDY #$01
1a7c : d0 87 __ BNE $1a05 ; (move_enemies.s1020 + 0)
--------------------------------------------------------------------
spawn_enemy_shot:
.s1000:
1a7e : a5 53 __ LDA T1 + 0 
1a80 : 8d a3 9f STA $9fa3 ; (spawn_enemy_shot@stack + 0)
1a83 : a5 54 __ LDA T3 + 0 
1a85 : 8d a4 9f STA $9fa4 ; (spawn_enemy_shot@stack + 1)
1a88 : 38 __ __ SEC
1a89 : a5 23 __ LDA SP + 0 
1a8b : e9 08 __ SBC #$08
1a8d : 85 23 __ STA SP + 0 
1a8f : b0 02 __ BCS $1a93 ; (spawn_enemy_shot.s0 + 0)
1a91 : c6 24 __ DEC SP + 1 
.s0:
1a93 : ad fe 9f LDA $9ffe ; (sstack + 8)
1a96 : 85 43 __ STA T0 + 0 
1a98 : ad ff 9f LDA $9fff ; (sstack + 9)
1a9b : 85 44 __ STA T0 + 1 
1a9d : a0 00 __ LDY #$00
1a9f : b1 43 __ LDA (T0 + 0),y 
1aa1 : f0 0f __ BEQ $1ab2 ; (spawn_enemy_shot.s1001 + 0)
.s3:
1aa3 : a2 00 __ LDX #$00
.l6:
1aa5 : bc 7c 24 LDY $247c,x ; (__multab3L + 0)
1aa8 : b9 50 25 LDA $2550,y ; (EnemyShot + 2)
1aab : f0 1b __ BEQ $1ac8 ; (spawn_enemy_shot.s9 + 0)
.s7:
1aad : e8 __ __ INX
1aae : e0 03 __ CPX #$03
1ab0 : 90 f3 __ BCC $1aa5 ; (spawn_enemy_shot.l6 + 0)
.s1001:
1ab2 : 18 __ __ CLC
1ab3 : a5 23 __ LDA SP + 0 
1ab5 : 69 08 __ ADC #$08
1ab7 : 85 23 __ STA SP + 0 
1ab9 : 90 02 __ BCC $1abd ; (spawn_enemy_shot.s1001 + 11)
1abb : e6 24 __ INC SP + 1 
1abd : ad a3 9f LDA $9fa3 ; (spawn_enemy_shot@stack + 0)
1ac0 : 85 53 __ STA T1 + 0 
1ac2 : ad a4 9f LDA $9fa4 ; (spawn_enemy_shot@stack + 1)
1ac5 : 85 54 __ STA T3 + 0 
1ac7 : 60 __ __ RTS
.s9:
1ac8 : a9 14 __ LDA #$14
1aca : 85 0d __ STA P0 
1acc : a9 00 __ LDA #$00
1ace : 85 0e __ STA P1 
1ad0 : 85 10 __ STA P3 
1ad2 : a9 01 __ LDA #$01
1ad4 : 85 0f __ STA P2 
1ad6 : 99 50 25 STA $2550,y ; (EnemyShot + 2)
1ad9 : ad fe 9f LDA $9ffe ; (sstack + 8)
1adc : 85 45 __ STA T2 + 0 
1ade : ad ff 9f LDA $9fff ; (sstack + 9)
1ae1 : 85 46 __ STA T2 + 1 
1ae3 : a0 00 __ LDY #$00
1ae5 : b1 45 __ LDA (T2 + 0),y 
1ae7 : 38 __ __ SEC
1ae8 : e9 01 __ SBC #$01
1aea : 85 54 __ STA T3 + 0 
1aec : bc 7c 24 LDY $247c,x ; (__multab3L + 0)
1aef : 99 4e 25 STA $254e,y ; (EnemyShot + 0)
1af2 : a0 01 __ LDY #$01
1af4 : b1 45 __ LDA (T2 + 0),y 
1af6 : 85 53 __ STA T1 + 0 
1af8 : bc 7c 24 LDY $247c,x ; (__multab3L + 0)
1afb : 99 4f 25 STA $254f,y ; (EnemyShot + 1)
1afe : 20 26 1b JSR $1b26 ; (gotoxy.s0 + 0)
1b01 : a9 5d __ LDA #$5d
1b03 : a0 02 __ LDY #$02
1b05 : 91 23 __ STA (SP + 0),y 
1b07 : a9 1b __ LDA #$1b
1b09 : c8 __ __ INY
1b0a : 91 23 __ STA (SP + 0),y 
1b0c : a5 54 __ LDA T3 + 0 
1b0e : c8 __ __ INY
1b0f : 91 23 __ STA (SP + 0),y 
1b11 : a9 00 __ LDA #$00
1b13 : c8 __ __ INY
1b14 : 91 23 __ STA (SP + 0),y 
1b16 : a5 53 __ LDA T1 + 0 
1b18 : c8 __ __ INY
1b19 : 91 23 __ STA (SP + 0),y 
1b1b : a9 00 __ LDA #$00
1b1d : c8 __ __ INY
1b1e : 91 23 __ STA (SP + 0),y 
1b20 : 20 2f 1b JSR $1b2f ; (printf.s0 + 0)
1b23 : 4c b2 1a JMP $1ab2 ; (spawn_enemy_shot.s1001 + 0)
--------------------------------------------------------------------
gotoxy:
.s0:
1b26 : a6 0f __ LDX P2 
1b28 : a4 0d __ LDY P0 
1b2a : 18 __ __ CLC
1b2b : 20 f0 ff JSR $fff0 
.s1001:
1b2e : 60 __ __ RTS
--------------------------------------------------------------------
printf:
.s0:
1b2f : a9 01 __ LDA #$01
1b31 : 8d fd 9f STA $9ffd ; (sstack + 7)
1b34 : a9 a6 __ LDA #$a6
1b36 : 8d f7 9f STA $9ff7 ; (sstack + 1)
1b39 : a9 9f __ LDA #$9f
1b3b : 8d f8 9f STA $9ff8 ; (sstack + 2)
1b3e : a0 02 __ LDY #$02
1b40 : b1 23 __ LDA (SP + 0),y 
1b42 : 8d f9 9f STA $9ff9 ; (sstack + 3)
1b45 : c8 __ __ INY
1b46 : b1 23 __ LDA (SP + 0),y 
1b48 : 8d fa 9f STA $9ffa ; (sstack + 4)
1b4b : 18 __ __ CLC
1b4c : a5 23 __ LDA SP + 0 
1b4e : 69 04 __ ADC #$04
1b50 : 8d fb 9f STA $9ffb ; (sstack + 5)
1b53 : a5 24 __ LDA SP + 1 
1b55 : 69 00 __ ADC #$00
1b57 : 8d fc 9f STA $9ffc ; (sstack + 6)
1b5a : 4c 6e 0c JMP $0c6e ; (sformat.s1000 + 0)
--------------------------------------------------------------------
1b5d : __ __ __ BYT 25 64 20 2d 20 25 64 00                         : %d - %d.
--------------------------------------------------------------------
render_enemy_shots:
.s0:
1b65 : a2 00 __ LDX #$00
.l1006:
1b67 : bc 7c 24 LDY $247c,x ; (__multab3L + 0)
1b6a : b9 50 25 LDA $2550,y ; (EnemyShot + 2)
1b6d : c9 01 __ CMP #$01
1b6f : d0 43 __ BNE $1bb4 ; (render_enemy_shots.s19 + 0)
.s5:
1b71 : b9 4f 25 LDA $254f,y ; (EnemyShot + 1)
1b74 : 0a __ __ ASL
1b75 : 85 1b __ STA ACCU + 0 
1b77 : a9 00 __ LDA #$00
1b79 : 2a __ __ ROL
1b7a : 06 1b __ ASL ACCU + 0 
1b7c : 2a __ __ ROL
1b7d : 85 1c __ STA ACCU + 1 
1b7f : a5 1b __ LDA ACCU + 0 
1b81 : 79 4f 25 ADC $254f,y ; (EnemyShot + 1)
1b84 : 85 1b __ STA ACCU + 0 
1b86 : a5 1c __ LDA ACCU + 1 
1b88 : 69 00 __ ADC #$00
1b8a : 06 1b __ ASL ACCU + 0 
1b8c : 2a __ __ ROL
1b8d : 06 1b __ ASL ACCU + 0 
1b8f : 2a __ __ ROL
1b90 : 06 1b __ ASL ACCU + 0 
1b92 : 2a __ __ ROL
1b93 : 85 1c __ STA ACCU + 1 
1b95 : 18 __ __ CLC
1b96 : a5 1b __ LDA ACCU + 0 
1b98 : 79 4e 25 ADC $254e,y ; (EnemyShot + 0)
1b9b : 85 1b __ STA ACCU + 0 
1b9d : 85 1f __ STA ADDR + 0 
1b9f : a5 1c __ LDA ACCU + 1 
1ba1 : 69 c0 __ ADC #$c0
1ba3 : 85 1c __ STA ACCU + 1 
1ba5 : 18 __ __ CLC
1ba6 : 69 18 __ ADC #$18
1ba8 : 85 20 __ STA ADDR + 1 
1baa : a9 82 __ LDA #$82
1bac : a0 00 __ LDY #$00
1bae : 91 1b __ STA (ACCU + 0),y 
1bb0 : a9 01 __ LDA #$01
1bb2 : 91 1f __ STA (ADDR + 0),y 
.s19:
1bb4 : e8 __ __ INX
1bb5 : e0 03 __ CPX #$03
1bb7 : 90 ae __ BCC $1b67 ; (render_enemy_shots.l1006 + 0)
.s1001:
1bb9 : 60 __ __ RTS
--------------------------------------------------------------------
render_enemies:
.s0:
1bba : a2 00 __ LDX #$00
.l1006:
1bbc : bc 72 24 LDY $2472,x ; (__multab5L + 0)
1bbf : b9 20 25 LDA $2520,y ; (Enemy + 4)
1bc2 : c9 01 __ CMP #$01
1bc4 : d0 4b __ BNE $1c11 ; (render_enemies.s19 + 0)
.s5:
1bc6 : 84 1d __ STY ACCU + 2 
1bc8 : b9 1d 25 LDA $251d,y ; (Enemy + 1)
1bcb : 0a __ __ ASL
1bcc : 85 1b __ STA ACCU + 0 
1bce : a9 00 __ LDA #$00
1bd0 : 2a __ __ ROL
1bd1 : 06 1b __ ASL ACCU + 0 
1bd3 : 2a __ __ ROL
1bd4 : 85 1c __ STA ACCU + 1 
1bd6 : a5 1b __ LDA ACCU + 0 
1bd8 : 79 1d 25 ADC $251d,y ; (Enemy + 1)
1bdb : 85 1b __ STA ACCU + 0 
1bdd : a5 1c __ LDA ACCU + 1 
1bdf : 69 00 __ ADC #$00
1be1 : 06 1b __ ASL ACCU + 0 
1be3 : 2a __ __ ROL
1be4 : 06 1b __ ASL ACCU + 0 
1be6 : 2a __ __ ROL
1be7 : 06 1b __ ASL ACCU + 0 
1be9 : 2a __ __ ROL
1bea : 85 1c __ STA ACCU + 1 
1bec : 18 __ __ CLC
1bed : a5 1b __ LDA ACCU + 0 
1bef : 79 1c 25 ADC $251c,y ; (Enemy + 0)
1bf2 : 85 43 __ STA T2 + 0 
1bf4 : 85 1b __ STA ACCU + 0 
1bf6 : a5 1c __ LDA ACCU + 1 
1bf8 : 69 c0 __ ADC #$c0
1bfa : 85 44 __ STA T2 + 1 
1bfc : 18 __ __ CLC
1bfd : 69 18 __ ADC #$18
1bff : 85 1c __ STA ACCU + 1 
1c01 : b9 1e 25 LDA $251e,y ; (Enemy + 2)
1c04 : a0 00 __ LDY #$00
1c06 : 91 43 __ STA (T2 + 0),y 
1c08 : a4 1d __ LDY ACCU + 2 
1c0a : b9 1f 25 LDA $251f,y ; (Enemy + 3)
1c0d : a0 00 __ LDY #$00
1c0f : 91 1b __ STA (ACCU + 0),y 
.s19:
1c11 : e8 __ __ INX
1c12 : e0 0a __ CPX #$0a
1c14 : 90 a6 __ BCC $1bbc ; (render_enemies.l1006 + 0)
.s1001:
1c16 : 60 __ __ RTS
--------------------------------------------------------------------
move_enemy_shots:
.s0:
1c17 : a2 00 __ LDX #$00
.l1008:
1c19 : bc 7c 24 LDY $247c,x ; (__multab3L + 0)
1c1c : b9 50 25 LDA $2550,y ; (EnemyShot + 2)
1c1f : c9 01 __ CMP #$01
1c21 : d0 58 __ BNE $1c7b ; (move_enemy_shots.s23 + 0)
.s5:
1c23 : 84 1d __ STY ACCU + 2 
1c25 : b9 4f 25 LDA $254f,y ; (EnemyShot + 1)
1c28 : 0a __ __ ASL
1c29 : 85 1b __ STA ACCU + 0 
1c2b : a9 00 __ LDA #$00
1c2d : 2a __ __ ROL
1c2e : 06 1b __ ASL ACCU + 0 
1c30 : 2a __ __ ROL
1c31 : 85 1c __ STA ACCU + 1 
1c33 : a5 1b __ LDA ACCU + 0 
1c35 : 79 4f 25 ADC $254f,y ; (EnemyShot + 1)
1c38 : 85 1b __ STA ACCU + 0 
1c3a : a5 1c __ LDA ACCU + 1 
1c3c : 69 00 __ ADC #$00
1c3e : 06 1b __ ASL ACCU + 0 
1c40 : 2a __ __ ROL
1c41 : 06 1b __ ASL ACCU + 0 
1c43 : 2a __ __ ROL
1c44 : 06 1b __ ASL ACCU + 0 
1c46 : 2a __ __ ROL
1c47 : 85 1c __ STA ACCU + 1 
1c49 : b9 4e 25 LDA $254e,y ; (EnemyShot + 0)
1c4c : 85 1e __ STA ACCU + 3 
1c4e : 18 __ __ CLC
1c4f : 65 1b __ ADC ACCU + 0 
1c51 : 85 1b __ STA ACCU + 0 
1c53 : 85 1f __ STA ADDR + 0 
1c55 : a5 1c __ LDA ACCU + 1 
1c57 : 69 c0 __ ADC #$c0
1c59 : 85 1c __ STA ACCU + 1 
1c5b : 18 __ __ CLC
1c5c : 69 18 __ ADC #$18
1c5e : 85 20 __ STA ADDR + 1 
1c60 : a9 20 __ LDA #$20
1c62 : a0 00 __ LDY #$00
1c64 : 91 1b __ STA (ACCU + 0),y 
1c66 : 98 __ __ TYA
1c67 : 91 1f __ STA (ADDR + 0),y 
1c69 : c6 1e __ DEC ACCU + 3 
1c6b : a5 1e __ LDA ACCU + 3 
1c6d : a4 1d __ LDY ACCU + 2 
1c6f : 99 4e 25 STA $254e,y ; (EnemyShot + 0)
1c72 : c9 ff __ CMP #$ff
1c74 : d0 05 __ BNE $1c7b ; (move_enemy_shots.s23 + 0)
.s8:
1c76 : a9 00 __ LDA #$00
1c78 : 99 50 25 STA $2550,y ; (EnemyShot + 2)
.s23:
1c7b : e8 __ __ INX
1c7c : e0 03 __ CPX #$03
1c7e : 90 99 __ BCC $1c19 ; (move_enemy_shots.l1008 + 0)
.s1001:
1c80 : 60 __ __ RTS
--------------------------------------------------------------------
check_player_enemy_collision:
.s0:
1c81 : a0 00 __ LDY #$00
.l2:
1c83 : be 72 24 LDX $2472,y ; (__multab5L + 0)
1c86 : bd 20 25 LDA $2520,x ; (Enemy + 4)
1c89 : c9 01 __ CMP #$01
1c8b : d0 10 __ BNE $1c9d ; (check_player_enemy_collision.s3 + 0)
.s5:
1c8d : bd 1c 25 LDA $251c,x ; (Enemy + 0)
1c90 : cd ed 24 CMP $24ed ; (Player + 0)
1c93 : d0 08 __ BNE $1c9d ; (check_player_enemy_collision.s3 + 0)
.s11:
1c95 : bd 1d 25 LDA $251d,x ; (Enemy + 1)
1c98 : cd ee 24 CMP $24ee ; (Player + 1)
1c9b : f0 2d __ BEQ $1cca ; (check_player_enemy_collision.s8 + 0)
.s3:
1c9d : c8 __ __ INY
1c9e : c0 0a __ CPY #$0a
1ca0 : 90 e1 __ BCC $1c83 ; (check_player_enemy_collision.l2 + 0)
.s4:
1ca2 : a0 00 __ LDY #$00
.l13:
1ca4 : be 7c 24 LDX $247c,y ; (__multab3L + 0)
1ca7 : bd 50 25 LDA $2550,x ; (EnemyShot + 2)
1caa : c9 01 __ CMP #$01
1cac : d0 10 __ BNE $1cbe ; (check_player_enemy_collision.s14 + 0)
.s16:
1cae : bd 4e 25 LDA $254e,x ; (EnemyShot + 0)
1cb1 : cd ed 24 CMP $24ed ; (Player + 0)
1cb4 : d0 08 __ BNE $1cbe ; (check_player_enemy_collision.s14 + 0)
.s22:
1cb6 : bd 4f 25 LDA $254f,x ; (EnemyShot + 1)
1cb9 : cd ee 24 CMP $24ee ; (Player + 1)
1cbc : f0 06 __ BEQ $1cc4 ; (check_player_enemy_collision.s19 + 0)
.s14:
1cbe : c8 __ __ INY
1cbf : c0 03 __ CPY #$03
1cc1 : 90 e1 __ BCC $1ca4 ; (check_player_enemy_collision.l13 + 0)
.s1001:
1cc3 : 60 __ __ RTS
.s19:
1cc4 : a9 01 __ LDA #$01
1cc6 : 8d f8 24 STA $24f8 ; (game + 0)
1cc9 : 60 __ __ RTS
.s8:
1cca : a9 01 __ LDA #$01
1ccc : 8d f8 24 STA $24f8 ; (game + 0)
1ccf : d0 d1 __ BNE $1ca2 ; (check_player_enemy_collision.s4 + 0)
--------------------------------------------------------------------
control_player_ship:
.s0:
1cd1 : a9 00 __ LDA #$00
1cd3 : 20 73 1d JSR $1d73 ; (joy_poll.s0 + 0)
1cd6 : ad 61 25 LDA $2561 ; (joyx + 0)
1cd9 : 85 1d __ STA ACCU + 2 
1cdb : 85 1e __ STA ACCU + 3 
1cdd : d0 08 __ BNE $1ce7 ; (control_player_ship.s1 + 0)
.s4:
1cdf : ad fd 24 LDA $24fd ; (joyy + 0)
1ce2 : d0 03 __ BNE $1ce7 ; (control_player_ship.s1 + 0)
1ce4 : 4c 68 1d JMP $1d68 ; (control_player_ship.s3 + 0)
.s1:
1ce7 : ad ed 24 LDA $24ed ; (Player + 0)
1cea : 85 43 __ STA T2 + 0 
1cec : 85 44 __ STA T3 + 0 
1cee : ad ee 24 LDA $24ee ; (Player + 1)
1cf1 : 85 45 __ STA T4 + 0 
1cf3 : 85 46 __ STA T5 + 0 
1cf5 : 0a __ __ ASL
1cf6 : 85 1b __ STA ACCU + 0 
1cf8 : a9 00 __ LDA #$00
1cfa : 2a __ __ ROL
1cfb : 06 1b __ ASL ACCU + 0 
1cfd : 2a __ __ ROL
1cfe : aa __ __ TAX
1cff : a5 1b __ LDA ACCU + 0 
1d01 : 65 45 __ ADC T4 + 0 
1d03 : 85 1b __ STA ACCU + 0 
1d05 : 8a __ __ TXA
1d06 : 69 00 __ ADC #$00
1d08 : 06 1b __ ASL ACCU + 0 
1d0a : 2a __ __ ROL
1d0b : 06 1b __ ASL ACCU + 0 
1d0d : 2a __ __ ROL
1d0e : 06 1b __ ASL ACCU + 0 
1d10 : 2a __ __ ROL
1d11 : aa __ __ TAX
1d12 : 18 __ __ CLC
1d13 : a5 1b __ LDA ACCU + 0 
1d15 : 65 43 __ ADC T2 + 0 
1d17 : 85 1b __ STA ACCU + 0 
1d19 : 85 1f __ STA ADDR + 0 
1d1b : 8a __ __ TXA
1d1c : 69 c0 __ ADC #$c0
1d1e : 85 1c __ STA ACCU + 1 
1d20 : 18 __ __ CLC
1d21 : 69 18 __ ADC #$18
1d23 : 85 20 __ STA ADDR + 1 
1d25 : a9 20 __ LDA #$20
1d27 : a0 00 __ LDY #$00
1d29 : 91 1b __ STA (ACCU + 0),y 
1d2b : 98 __ __ TYA
1d2c : 91 1f __ STA (ADDR + 0),y 
1d2e : a5 43 __ LDA T2 + 0 
1d30 : f0 04 __ BEQ $1d36 ; (control_player_ship.s6 + 0)
.s8:
1d32 : a5 1d __ LDA ACCU + 2 
1d34 : 30 0c __ BMI $1d42 ; (control_player_ship.s5 + 0)
.s6:
1d36 : a5 43 __ LDA T2 + 0 
1d38 : c9 27 __ CMP #$27
1d3a : b0 0e __ BCS $1d4a ; (control_player_ship.s7 + 0)
.s12:
1d3c : a5 1d __ LDA ACCU + 2 
1d3e : 30 0a __ BMI $1d4a ; (control_player_ship.s7 + 0)
.s1009:
1d40 : f0 08 __ BEQ $1d4a ; (control_player_ship.s7 + 0)
.s5:
1d42 : 18 __ __ CLC
1d43 : a5 44 __ LDA T3 + 0 
1d45 : 65 1e __ ADC ACCU + 3 
1d47 : 8d ed 24 STA $24ed ; (Player + 0)
.s7:
1d4a : a5 45 __ LDA T4 + 0 
1d4c : c9 05 __ CMP #$05
1d4e : 90 07 __ BCC $1d57 ; (control_player_ship.s14 + 0)
.s16:
1d50 : ad fd 24 LDA $24fd ; (joyy + 0)
1d53 : 30 0d __ BMI $1d62 ; (control_player_ship.s32 + 0)
.s1012:
1d55 : a5 45 __ LDA T4 + 0 
.s14:
1d57 : c9 18 __ CMP #$18
1d59 : b0 0d __ BCS $1d68 ; (control_player_ship.s3 + 0)
.s20:
1d5b : ad fd 24 LDA $24fd ; (joyy + 0)
1d5e : 30 08 __ BMI $1d68 ; (control_player_ship.s3 + 0)
.s1004:
1d60 : f0 06 __ BEQ $1d68 ; (control_player_ship.s3 + 0)
.s32:
1d62 : 18 __ __ CLC
1d63 : 65 46 __ ADC T5 + 0 
1d65 : 8d ee 24 STA $24ee ; (Player + 1)
.s3:
1d68 : ad 63 25 LDA $2563 ; (joyb + 0)
1d6b : c9 01 __ CMP #$01
1d6d : f0 01 __ BEQ $1d70 ; (control_player_ship.s21 + 0)
.s1001:
1d6f : 60 __ __ RTS
.s21:
1d70 : 4c b3 1d JMP $1db3 ; (spawn_player_shot.s0 + 0)
--------------------------------------------------------------------
joy_poll:
.s0:
1d73 : aa __ __ TAX
1d74 : bd 00 dc LDA $dc00,x 
1d77 : a8 __ __ TAY
1d78 : 29 10 __ AND #$10
1d7a : f0 04 __ BEQ $1d80 ; (joy_poll.s1005 + 0)
.s1006:
1d7c : a9 00 __ LDA #$00
1d7e : f0 02 __ BEQ $1d82 ; (joy_poll.s1007 + 0)
.s1005:
1d80 : a9 01 __ LDA #$01
.s1007:
1d82 : 9d 63 25 STA $2563,x ; (joyb + 0)
1d85 : 98 __ __ TYA
1d86 : 4a __ __ LSR
1d87 : b0 1d __ BCS $1da6 ; (joy_poll.s2 + 0)
.s1:
1d89 : a9 ff __ LDA #$ff
.s15:
1d8b : 9d fd 24 STA $24fd,x ; (joyy + 0)
1d8e : 98 __ __ TYA
1d8f : 29 04 __ AND #$04
1d91 : d0 06 __ BNE $1d99 ; (joy_poll.s8 + 0)
.s7:
1d93 : a9 ff __ LDA #$ff
.s1001:
1d95 : 9d 61 25 STA $2561,x ; (joyx + 0)
1d98 : 60 __ __ RTS
.s8:
1d99 : 98 __ __ TYA
1d9a : 29 08 __ AND #$08
1d9c : f0 04 __ BEQ $1da2 ; (joy_poll.s1011 + 0)
.s1012:
1d9e : a9 00 __ LDA #$00
1da0 : f0 f3 __ BEQ $1d95 ; (joy_poll.s1001 + 0)
.s1011:
1da2 : a9 01 __ LDA #$01
1da4 : d0 ef __ BNE $1d95 ; (joy_poll.s1001 + 0)
.s2:
1da6 : 98 __ __ TYA
1da7 : 29 02 __ AND #$02
1da9 : f0 04 __ BEQ $1daf ; (joy_poll.s1008 + 0)
.s1009:
1dab : a9 00 __ LDA #$00
1dad : f0 dc __ BEQ $1d8b ; (joy_poll.s15 + 0)
.s1008:
1daf : a9 01 __ LDA #$01
1db1 : d0 d8 __ BNE $1d8b ; (joy_poll.s15 + 0)
--------------------------------------------------------------------
joyy:
24fd : __ __ __ BSS	2
--------------------------------------------------------------------
joyx:
2561 : __ __ __ BSS	2
--------------------------------------------------------------------
joyb:
2563 : __ __ __ BSS	2
--------------------------------------------------------------------
spawn_player_shot:
.s0:
1db3 : ad ed 24 LDA $24ed ; (Player + 0)
1db6 : c9 27 __ CMP #$27
1db8 : f0 0f __ BEQ $1dc9 ; (spawn_player_shot.s1001 + 0)
.s3:
1dba : a0 00 __ LDY #$00
.l6:
1dbc : be 7c 24 LDX $247c,y ; (__multab3L + 0)
1dbf : bd f1 24 LDA $24f1,x ; (PlayerShot + 2)
1dc2 : f0 06 __ BEQ $1dca ; (spawn_player_shot.s9 + 0)
.s7:
1dc4 : c8 __ __ INY
1dc5 : c0 03 __ CPY #$03
1dc7 : 90 f3 __ BCC $1dbc ; (spawn_player_shot.l6 + 0)
.s1001:
1dc9 : 60 __ __ RTS
.s9:
1dca : a9 01 __ LDA #$01
1dcc : 9d f1 24 STA $24f1,x ; (PlayerShot + 2)
1dcf : ad ee 24 LDA $24ee ; (Player + 1)
1dd2 : 9d f0 24 STA $24f0,x ; (PlayerShot + 1)
1dd5 : ad 61 25 LDA $2561 ; (joyx + 0)
1dd8 : 30 02 __ BMI $1ddc ; (spawn_player_shot.s13 + 0)
.s1007:
1dda : d0 06 __ BNE $1de2 ; (spawn_player_shot.s12 + 0)
.s13:
1ddc : ad ed 24 LDA $24ed ; (Player + 0)
1ddf : 4c e8 1d JMP $1de8 ; (spawn_player_shot.s1010 + 0)
.s12:
1de2 : ad ed 24 LDA $24ed ; (Player + 0)
1de5 : 18 __ __ CLC
1de6 : 69 01 __ ADC #$01
.s1010:
1de8 : be 7c 24 LDX $247c,y ; (__multab3L + 0)
1deb : 9d ef 24 STA $24ef,x ; (PlayerShot + 0)
1dee : 60 __ __ RTS
--------------------------------------------------------------------
render_player_ship:
.s0:
1def : ad ee 24 LDA $24ee ; (Player + 1)
1df2 : 0a __ __ ASL
1df3 : 85 1b __ STA ACCU + 0 
1df5 : a9 00 __ LDA #$00
1df7 : 2a __ __ ROL
1df8 : 06 1b __ ASL ACCU + 0 
1dfa : 2a __ __ ROL
1dfb : aa __ __ TAX
1dfc : a5 1b __ LDA ACCU + 0 
1dfe : 6d ee 24 ADC $24ee ; (Player + 1)
1e01 : 85 1b __ STA ACCU + 0 
1e03 : 8a __ __ TXA
1e04 : 69 00 __ ADC #$00
1e06 : 06 1b __ ASL ACCU + 0 
1e08 : 2a __ __ ROL
1e09 : 06 1b __ ASL ACCU + 0 
1e0b : 2a __ __ ROL
1e0c : 06 1b __ ASL ACCU + 0 
1e0e : 2a __ __ ROL
1e0f : aa __ __ TAX
1e10 : 18 __ __ CLC
1e11 : a5 1b __ LDA ACCU + 0 
1e13 : 6d ed 24 ADC $24ed ; (Player + 0)
1e16 : 85 1b __ STA ACCU + 0 
1e18 : 85 1f __ STA ADDR + 0 
1e1a : 8a __ __ TXA
1e1b : 69 c0 __ ADC #$c0
1e1d : 85 1c __ STA ACCU + 1 
1e1f : 18 __ __ CLC
1e20 : 69 18 __ ADC #$18
1e22 : 85 20 __ STA ADDR + 1 
1e24 : a9 80 __ LDA #$80
1e26 : a0 00 __ LDY #$00
1e28 : 91 1b __ STA (ACCU + 0),y 
1e2a : a9 03 __ LDA #$03
1e2c : 91 1f __ STA (ADDR + 0),y 
.s1001:
1e2e : 60 __ __ RTS
--------------------------------------------------------------------
move_player_shots:
.s0:
1e2f : a2 00 __ LDX #$00
.l2:
1e31 : 86 1d __ STX ACCU + 2 
1e33 : bc 7c 24 LDY $247c,x ; (__multab3L + 0)
1e36 : b9 f1 24 LDA $24f1,y ; (PlayerShot + 2)
1e39 : c9 01 __ CMP #$01
1e3b : d0 52 __ BNE $1e8f ; (move_player_shots.s23 + 0)
.s5:
1e3d : 84 1e __ STY ACCU + 3 
1e3f : b9 f0 24 LDA $24f0,y ; (PlayerShot + 1)
1e42 : 0a __ __ ASL
1e43 : 85 1b __ STA ACCU + 0 
1e45 : a9 00 __ LDA #$00
1e47 : 2a __ __ ROL
1e48 : 06 1b __ ASL ACCU + 0 
1e4a : 2a __ __ ROL
1e4b : aa __ __ TAX
1e4c : a5 1b __ LDA ACCU + 0 
1e4e : 79 f0 24 ADC $24f0,y ; (PlayerShot + 1)
1e51 : 85 1b __ STA ACCU + 0 
1e53 : 8a __ __ TXA
1e54 : 69 00 __ ADC #$00
1e56 : 06 1b __ ASL ACCU + 0 
1e58 : 2a __ __ ROL
1e59 : 06 1b __ ASL ACCU + 0 
1e5b : 2a __ __ ROL
1e5c : 06 1b __ ASL ACCU + 0 
1e5e : 2a __ __ ROL
1e5f : 85 1c __ STA ACCU + 1 
1e61 : b9 ef 24 LDA $24ef,y ; (PlayerShot + 0)
1e64 : aa __ __ TAX
1e65 : 18 __ __ CLC
1e66 : 65 1b __ ADC ACCU + 0 
1e68 : 85 1b __ STA ACCU + 0 
1e6a : 85 1f __ STA ADDR + 0 
1e6c : a5 1c __ LDA ACCU + 1 
1e6e : 69 c0 __ ADC #$c0
1e70 : 85 1c __ STA ACCU + 1 
1e72 : 18 __ __ CLC
1e73 : 69 18 __ ADC #$18
1e75 : 85 20 __ STA ADDR + 1 
1e77 : a9 20 __ LDA #$20
1e79 : a0 00 __ LDY #$00
1e7b : 91 1b __ STA (ACCU + 0),y 
1e7d : 98 __ __ TYA
1e7e : 91 1f __ STA (ADDR + 0),y 
1e80 : e8 __ __ INX
1e81 : 8a __ __ TXA
1e82 : a6 1e __ LDX ACCU + 3 
1e84 : 9d ef 24 STA $24ef,x ; (PlayerShot + 0)
1e87 : c9 28 __ CMP #$28
1e89 : 90 04 __ BCC $1e8f ; (move_player_shots.s23 + 0)
.s8:
1e8b : 98 __ __ TYA
1e8c : 9d f1 24 STA $24f1,x ; (PlayerShot + 2)
.s23:
1e8f : a6 1d __ LDX ACCU + 2 
1e91 : e8 __ __ INX
1e92 : e0 03 __ CPX #$03
1e94 : 90 9b __ BCC $1e31 ; (move_player_shots.l2 + 0)
.s1001:
1e96 : 60 __ __ RTS
--------------------------------------------------------------------
render_player_shots:
.s0:
1e97 : a2 00 __ LDX #$00
.l1006:
1e99 : bc 7c 24 LDY $247c,x ; (__multab3L + 0)
1e9c : b9 f1 24 LDA $24f1,y ; (PlayerShot + 2)
1e9f : c9 01 __ CMP #$01
1ea1 : d0 43 __ BNE $1ee6 ; (render_player_shots.s19 + 0)
.s5:
1ea3 : b9 f0 24 LDA $24f0,y ; (PlayerShot + 1)
1ea6 : 0a __ __ ASL
1ea7 : 85 1b __ STA ACCU + 0 
1ea9 : a9 00 __ LDA #$00
1eab : 2a __ __ ROL
1eac : 06 1b __ ASL ACCU + 0 
1eae : 2a __ __ ROL
1eaf : 85 1c __ STA ACCU + 1 
1eb1 : a5 1b __ LDA ACCU + 0 
1eb3 : 79 f0 24 ADC $24f0,y ; (PlayerShot + 1)
1eb6 : 85 1b __ STA ACCU + 0 
1eb8 : a5 1c __ LDA ACCU + 1 
1eba : 69 00 __ ADC #$00
1ebc : 06 1b __ ASL ACCU + 0 
1ebe : 2a __ __ ROL
1ebf : 06 1b __ ASL ACCU + 0 
1ec1 : 2a __ __ ROL
1ec2 : 06 1b __ ASL ACCU + 0 
1ec4 : 2a __ __ ROL
1ec5 : 85 1c __ STA ACCU + 1 
1ec7 : 18 __ __ CLC
1ec8 : a5 1b __ LDA ACCU + 0 
1eca : 79 ef 24 ADC $24ef,y ; (PlayerShot + 0)
1ecd : 85 1b __ STA ACCU + 0 
1ecf : 85 1f __ STA ADDR + 0 
1ed1 : a5 1c __ LDA ACCU + 1 
1ed3 : 69 c0 __ ADC #$c0
1ed5 : 85 1c __ STA ACCU + 1 
1ed7 : 18 __ __ CLC
1ed8 : 69 18 __ ADC #$18
1eda : 85 20 __ STA ADDR + 1 
1edc : a9 81 __ LDA #$81
1ede : a0 00 __ LDY #$00
1ee0 : 91 1b __ STA (ACCU + 0),y 
1ee2 : a9 01 __ LDA #$01
1ee4 : 91 1f __ STA (ADDR + 0),y 
.s19:
1ee6 : e8 __ __ INX
1ee7 : e0 03 __ CPX #$03
1ee9 : 90 ae __ BCC $1e99 ; (render_player_shots.l1006 + 0)
.s1001:
1eeb : 60 __ __ RTS
--------------------------------------------------------------------
check_shot_enemy_collision:
.s0:
1eec : a2 00 __ LDX #$00
.l2:
1eee : 86 1d __ STX ACCU + 2 
1ef0 : bc 7c 24 LDY $247c,x ; (__multab3L + 0)
1ef3 : b9 f1 24 LDA $24f1,y ; (PlayerShot + 2)
1ef6 : c9 01 __ CMP #$01
1ef8 : f0 03 __ BEQ $1efd ; (check_shot_enemy_collision.s5 + 0)
1efa : 4c 92 1f JMP $1f92 ; (check_shot_enemy_collision.s3 + 0)
.s5:
1efd : a2 00 __ LDX #$00
.l9:
1eff : 86 43 __ STX T2 + 0 
1f01 : bc 72 24 LDY $2472,x ; (__multab5L + 0)
1f04 : 84 1e __ STY ACCU + 3 
1f06 : b9 20 25 LDA $2520,y ; (Enemy + 4)
1f09 : c9 01 __ CMP #$01
1f0b : d0 7b __ BNE $1f88 ; (check_shot_enemy_collision.s43 + 0)
.s12:
1f0d : a6 1d __ LDX ACCU + 2 
1f0f : bd 7c 24 LDA $247c,x ; (__multab3L + 0)
1f12 : 85 44 __ STA T3 + 0 
1f14 : aa __ __ TAX
1f15 : b9 1c 25 LDA $251c,y ; (Enemy + 0)
1f18 : dd ef 24 CMP $24ef,x ; (PlayerShot + 0)
1f1b : d0 6b __ BNE $1f88 ; (check_shot_enemy_collision.s43 + 0)
.s18:
1f1d : b9 1d 25 LDA $251d,y ; (Enemy + 1)
1f20 : dd f0 24 CMP $24f0,x ; (PlayerShot + 1)
1f23 : d0 63 __ BNE $1f88 ; (check_shot_enemy_collision.s43 + 0)
.s15:
1f25 : 0a __ __ ASL
1f26 : 85 1b __ STA ACCU + 0 
1f28 : a9 00 __ LDA #$00
1f2a : 2a __ __ ROL
1f2b : 06 1b __ ASL ACCU + 0 
1f2d : 2a __ __ ROL
1f2e : aa __ __ TAX
1f2f : a5 1b __ LDA ACCU + 0 
1f31 : 79 1d 25 ADC $251d,y ; (Enemy + 1)
1f34 : 85 1b __ STA ACCU + 0 
1f36 : 8a __ __ TXA
1f37 : 69 00 __ ADC #$00
1f39 : 06 1b __ ASL ACCU + 0 
1f3b : 2a __ __ ROL
1f3c : 06 1b __ ASL ACCU + 0 
1f3e : 2a __ __ ROL
1f3f : 06 1b __ ASL ACCU + 0 
1f41 : 2a __ __ ROL
1f42 : aa __ __ TAX
1f43 : 18 __ __ CLC
1f44 : a5 1b __ LDA ACCU + 0 
1f46 : 79 1c 25 ADC $251c,y ; (Enemy + 0)
1f49 : 85 1b __ STA ACCU + 0 
1f4b : 85 1f __ STA ADDR + 0 
1f4d : 8a __ __ TXA
1f4e : 69 c0 __ ADC #$c0
1f50 : 85 1c __ STA ACCU + 1 
1f52 : 18 __ __ CLC
1f53 : 69 18 __ ADC #$18
1f55 : 85 20 __ STA ADDR + 1 
1f57 : a9 20 __ LDA #$20
1f59 : a0 00 __ LDY #$00
1f5b : 91 1b __ STA (ACCU + 0),y 
1f5d : 98 __ __ TYA
1f5e : 91 1f __ STA (ADDR + 0),y 
1f60 : a6 1e __ LDX ACCU + 3 
1f62 : 9d 20 25 STA $2520,x ; (Enemy + 4)
1f65 : a6 44 __ LDX T3 + 0 
1f67 : 9d f1 24 STA $24f1,x ; (PlayerShot + 2)
1f6a : ad f9 24 LDA $24f9 ; (game + 1)
1f6d : 18 __ __ CLC
1f6e : 69 01 __ ADC #$01
1f70 : 8d f9 24 STA $24f9 ; (game + 1)
1f73 : ad fa 24 LDA $24fa ; (game + 2)
1f76 : 69 00 __ ADC #$00
1f78 : 8d fa 24 STA $24fa ; (game + 2)
1f7b : ad fb 24 LDA $24fb ; (game + 3)
1f7e : 69 00 __ ADC #$00
1f80 : 8d fb 24 STA $24fb ; (game + 3)
1f83 : 90 03 __ BCC $1f88 ; (check_shot_enemy_collision.s43 + 0)
.s1014:
1f85 : ee fc 24 INC $24fc ; (game + 4)
.s43:
1f88 : a6 43 __ LDX T2 + 0 
1f8a : e8 __ __ INX
1f8b : e0 0a __ CPX #$0a
1f8d : b0 03 __ BCS $1f92 ; (check_shot_enemy_collision.s3 + 0)
1f8f : 4c ff 1e JMP $1eff ; (check_shot_enemy_collision.l9 + 0)
.s3:
1f92 : a6 1d __ LDX ACCU + 2 
1f94 : e8 __ __ INX
1f95 : e0 03 __ CPX #$03
1f97 : b0 03 __ BCS $1f9c ; (check_shot_enemy_collision.s1001 + 0)
1f99 : 4c ee 1e JMP $1eee ; (check_shot_enemy_collision.l2 + 0)
.s1001:
1f9c : 60 __ __ RTS
--------------------------------------------------------------------
wait_frames:
.s0:
1f9d : a5 0e __ LDA P1 ; (frames + 1)
1f9f : 30 1c __ BMI $1fbd ; (wait_frames.s1001 + 0)
.s1005:
1fa1 : 05 0d __ ORA P0 ; (frames + 0)
1fa3 : f0 18 __ BEQ $1fbd ; (wait_frames.s1001 + 0)
.s13:
1fa5 : a0 00 __ LDY #$00
1fa7 : a6 0e __ LDX P1 ; (frames + 1)
.l6:
1fa9 : ad 11 d0 LDA $d011 
1fac : 30 fb __ BMI $1fa9 ; (wait_frames.l6 + 0)
.l9:
1fae : ad 11 d0 LDA $d011 
1fb1 : 10 fb __ BPL $1fae ; (wait_frames.l9 + 0)
.s3:
1fb3 : c8 __ __ INY
1fb4 : 8a __ __ TXA
1fb5 : 30 06 __ BMI $1fbd ; (wait_frames.s1001 + 0)
.s1004:
1fb7 : d0 f0 __ BNE $1fa9 ; (wait_frames.l6 + 0)
.s1002:
1fb9 : c4 0d __ CPY P0 ; (frames + 0)
1fbb : 90 ec __ BCC $1fa9 ; (wait_frames.l6 + 0)
.s1001:
1fbd : 60 __ __ RTS
--------------------------------------------------------------------
freg:
1fbe : b1 19 __ LDA (IP + 0),y 
1fc0 : c8 __ __ INY
1fc1 : aa __ __ TAX
1fc2 : b5 00 __ LDA $00,x 
1fc4 : 85 03 __ STA WORK + 0 
1fc6 : b5 01 __ LDA $01,x 
1fc8 : 85 04 __ STA WORK + 1 
1fca : b5 02 __ LDA $02,x 
1fcc : 85 05 __ STA WORK + 2 
1fce : b5 03 __ LDA WORK + 0,x 
1fd0 : 85 06 __ STA WORK + 3 
1fd2 : a5 05 __ LDA WORK + 2 
1fd4 : 0a __ __ ASL
1fd5 : a5 06 __ LDA WORK + 3 
1fd7 : 2a __ __ ROL
1fd8 : 85 08 __ STA WORK + 5 
1fda : f0 06 __ BEQ $1fe2 ; (freg + 36)
1fdc : a5 05 __ LDA WORK + 2 
1fde : 09 80 __ ORA #$80
1fe0 : 85 05 __ STA WORK + 2 
1fe2 : a5 1d __ LDA ACCU + 2 
1fe4 : 0a __ __ ASL
1fe5 : a5 1e __ LDA ACCU + 3 
1fe7 : 2a __ __ ROL
1fe8 : 85 07 __ STA WORK + 4 
1fea : f0 06 __ BEQ $1ff2 ; (freg + 52)
1fec : a5 1d __ LDA ACCU + 2 
1fee : 09 80 __ ORA #$80
1ff0 : 85 1d __ STA ACCU + 2 
1ff2 : 60 __ __ RTS
1ff3 : 06 1e __ ASL ACCU + 3 
1ff5 : a5 07 __ LDA WORK + 4 
1ff7 : 6a __ __ ROR
1ff8 : 85 1e __ STA ACCU + 3 
1ffa : b0 06 __ BCS $2002 ; (freg + 68)
1ffc : a5 1d __ LDA ACCU + 2 
1ffe : 29 7f __ AND #$7f
2000 : 85 1d __ STA ACCU + 2 
2002 : 60 __ __ RTS
--------------------------------------------------------------------
faddsub:
2003 : a9 ff __ LDA #$ff
2005 : c5 07 __ CMP WORK + 4 
2007 : f0 04 __ BEQ $200d ; (faddsub + 10)
2009 : c5 08 __ CMP WORK + 5 
200b : d0 11 __ BNE $201e ; (faddsub + 27)
200d : a5 1e __ LDA ACCU + 3 
200f : 09 7f __ ORA #$7f
2011 : 85 1e __ STA ACCU + 3 
2013 : a9 80 __ LDA #$80
2015 : 85 1d __ STA ACCU + 2 
2017 : a9 00 __ LDA #$00
2019 : 85 1b __ STA ACCU + 0 
201b : 85 1c __ STA ACCU + 1 
201d : 60 __ __ RTS
201e : 38 __ __ SEC
201f : a5 07 __ LDA WORK + 4 
2021 : e5 08 __ SBC WORK + 5 
2023 : f0 38 __ BEQ $205d ; (faddsub + 90)
2025 : aa __ __ TAX
2026 : b0 25 __ BCS $204d ; (faddsub + 74)
2028 : e0 e9 __ CPX #$e9
202a : b0 0e __ BCS $203a ; (faddsub + 55)
202c : a5 08 __ LDA WORK + 5 
202e : 85 07 __ STA WORK + 4 
2030 : a9 00 __ LDA #$00
2032 : 85 1b __ STA ACCU + 0 
2034 : 85 1c __ STA ACCU + 1 
2036 : 85 1d __ STA ACCU + 2 
2038 : f0 23 __ BEQ $205d ; (faddsub + 90)
203a : a5 1d __ LDA ACCU + 2 
203c : 4a __ __ LSR
203d : 66 1c __ ROR ACCU + 1 
203f : 66 1b __ ROR ACCU + 0 
2041 : e8 __ __ INX
2042 : d0 f8 __ BNE $203c ; (faddsub + 57)
2044 : 85 1d __ STA ACCU + 2 
2046 : a5 08 __ LDA WORK + 5 
2048 : 85 07 __ STA WORK + 4 
204a : 4c 5d 20 JMP $205d ; (faddsub + 90)
204d : e0 18 __ CPX #$18
204f : b0 33 __ BCS $2084 ; (faddsub + 129)
2051 : a5 05 __ LDA WORK + 2 
2053 : 4a __ __ LSR
2054 : 66 04 __ ROR WORK + 1 
2056 : 66 03 __ ROR WORK + 0 
2058 : ca __ __ DEX
2059 : d0 f8 __ BNE $2053 ; (faddsub + 80)
205b : 85 05 __ STA WORK + 2 
205d : a5 1e __ LDA ACCU + 3 
205f : 29 80 __ AND #$80
2061 : 85 1e __ STA ACCU + 3 
2063 : 45 06 __ EOR WORK + 3 
2065 : 30 31 __ BMI $2098 ; (faddsub + 149)
2067 : 18 __ __ CLC
2068 : a5 1b __ LDA ACCU + 0 
206a : 65 03 __ ADC WORK + 0 
206c : 85 1b __ STA ACCU + 0 
206e : a5 1c __ LDA ACCU + 1 
2070 : 65 04 __ ADC WORK + 1 
2072 : 85 1c __ STA ACCU + 1 
2074 : a5 1d __ LDA ACCU + 2 
2076 : 65 05 __ ADC WORK + 2 
2078 : 85 1d __ STA ACCU + 2 
207a : 90 08 __ BCC $2084 ; (faddsub + 129)
207c : 66 1d __ ROR ACCU + 2 
207e : 66 1c __ ROR ACCU + 1 
2080 : 66 1b __ ROR ACCU + 0 
2082 : e6 07 __ INC WORK + 4 
2084 : a5 07 __ LDA WORK + 4 
2086 : c9 ff __ CMP #$ff
2088 : f0 83 __ BEQ $200d ; (faddsub + 10)
208a : 4a __ __ LSR
208b : 05 1e __ ORA ACCU + 3 
208d : 85 1e __ STA ACCU + 3 
208f : b0 06 __ BCS $2097 ; (faddsub + 148)
2091 : a5 1d __ LDA ACCU + 2 
2093 : 29 7f __ AND #$7f
2095 : 85 1d __ STA ACCU + 2 
2097 : 60 __ __ RTS
2098 : 38 __ __ SEC
2099 : a5 1b __ LDA ACCU + 0 
209b : e5 03 __ SBC WORK + 0 
209d : 85 1b __ STA ACCU + 0 
209f : a5 1c __ LDA ACCU + 1 
20a1 : e5 04 __ SBC WORK + 1 
20a3 : 85 1c __ STA ACCU + 1 
20a5 : a5 1d __ LDA ACCU + 2 
20a7 : e5 05 __ SBC WORK + 2 
20a9 : 85 1d __ STA ACCU + 2 
20ab : b0 19 __ BCS $20c6 ; (faddsub + 195)
20ad : 38 __ __ SEC
20ae : a9 00 __ LDA #$00
20b0 : e5 1b __ SBC ACCU + 0 
20b2 : 85 1b __ STA ACCU + 0 
20b4 : a9 00 __ LDA #$00
20b6 : e5 1c __ SBC ACCU + 1 
20b8 : 85 1c __ STA ACCU + 1 
20ba : a9 00 __ LDA #$00
20bc : e5 1d __ SBC ACCU + 2 
20be : 85 1d __ STA ACCU + 2 
20c0 : a5 1e __ LDA ACCU + 3 
20c2 : 49 80 __ EOR #$80
20c4 : 85 1e __ STA ACCU + 3 
20c6 : a5 1d __ LDA ACCU + 2 
20c8 : 30 ba __ BMI $2084 ; (faddsub + 129)
20ca : 05 1c __ ORA ACCU + 1 
20cc : 05 1b __ ORA ACCU + 0 
20ce : f0 0f __ BEQ $20df ; (faddsub + 220)
20d0 : c6 07 __ DEC WORK + 4 
20d2 : f0 0b __ BEQ $20df ; (faddsub + 220)
20d4 : 06 1b __ ASL ACCU + 0 
20d6 : 26 1c __ ROL ACCU + 1 
20d8 : 26 1d __ ROL ACCU + 2 
20da : 10 f4 __ BPL $20d0 ; (faddsub + 205)
20dc : 4c 84 20 JMP $2084 ; (faddsub + 129)
20df : a9 00 __ LDA #$00
20e1 : 85 1b __ STA ACCU + 0 
20e3 : 85 1c __ STA ACCU + 1 
20e5 : 85 1d __ STA ACCU + 2 
20e7 : 85 1e __ STA ACCU + 3 
20e9 : 60 __ __ RTS
--------------------------------------------------------------------
fmul:
20ea : a5 1b __ LDA ACCU + 0 
20ec : 05 1c __ ORA ACCU + 1 
20ee : 05 1d __ ORA ACCU + 2 
20f0 : d0 03 __ BNE $20f5 ; (fmul + 11)
20f2 : 85 1e __ STA ACCU + 3 
20f4 : 60 __ __ RTS
20f5 : a5 03 __ LDA WORK + 0 
20f7 : 05 04 __ ORA WORK + 1 
20f9 : 05 05 __ ORA WORK + 2 
20fb : d0 09 __ BNE $2106 ; (fmul + 28)
20fd : 85 1b __ STA ACCU + 0 
20ff : 85 1c __ STA ACCU + 1 
2101 : 85 1d __ STA ACCU + 2 
2103 : 85 1e __ STA ACCU + 3 
2105 : 60 __ __ RTS
2106 : a5 1e __ LDA ACCU + 3 
2108 : 45 06 __ EOR WORK + 3 
210a : 29 80 __ AND #$80
210c : 85 1e __ STA ACCU + 3 
210e : a9 ff __ LDA #$ff
2110 : c5 07 __ CMP WORK + 4 
2112 : f0 42 __ BEQ $2156 ; (fmul + 108)
2114 : c5 08 __ CMP WORK + 5 
2116 : f0 3e __ BEQ $2156 ; (fmul + 108)
2118 : a9 00 __ LDA #$00
211a : 85 09 __ STA WORK + 6 
211c : 85 0a __ STA WORK + 7 
211e : 85 0b __ STA $0b 
2120 : a4 1b __ LDY ACCU + 0 
2122 : a5 03 __ LDA WORK + 0 
2124 : d0 06 __ BNE $212c ; (fmul + 66)
2126 : a5 04 __ LDA WORK + 1 
2128 : f0 0a __ BEQ $2134 ; (fmul + 74)
212a : d0 05 __ BNE $2131 ; (fmul + 71)
212c : 20 8b 21 JSR $218b ; (fmul8 + 0)
212f : a5 04 __ LDA WORK + 1 
2131 : 20 8b 21 JSR $218b ; (fmul8 + 0)
2134 : a5 05 __ LDA WORK + 2 
2136 : 20 8b 21 JSR $218b ; (fmul8 + 0)
2139 : 38 __ __ SEC
213a : a5 0b __ LDA $0b 
213c : 30 06 __ BMI $2144 ; (fmul + 90)
213e : 06 09 __ ASL WORK + 6 
2140 : 26 0a __ ROL WORK + 7 
2142 : 2a __ __ ROL
2143 : 18 __ __ CLC
2144 : 29 7f __ AND #$7f
2146 : 85 0b __ STA $0b 
2148 : a5 07 __ LDA WORK + 4 
214a : 65 08 __ ADC WORK + 5 
214c : 90 19 __ BCC $2167 ; (fmul + 125)
214e : e9 7f __ SBC #$7f
2150 : b0 04 __ BCS $2156 ; (fmul + 108)
2152 : c9 ff __ CMP #$ff
2154 : d0 15 __ BNE $216b ; (fmul + 129)
2156 : a5 1e __ LDA ACCU + 3 
2158 : 09 7f __ ORA #$7f
215a : 85 1e __ STA ACCU + 3 
215c : a9 80 __ LDA #$80
215e : 85 1d __ STA ACCU + 2 
2160 : a9 00 __ LDA #$00
2162 : 85 1b __ STA ACCU + 0 
2164 : 85 1c __ STA ACCU + 1 
2166 : 60 __ __ RTS
2167 : e9 7e __ SBC #$7e
2169 : 90 15 __ BCC $2180 ; (fmul + 150)
216b : 4a __ __ LSR
216c : 05 1e __ ORA ACCU + 3 
216e : 85 1e __ STA ACCU + 3 
2170 : a9 00 __ LDA #$00
2172 : 6a __ __ ROR
2173 : 05 0b __ ORA $0b 
2175 : 85 1d __ STA ACCU + 2 
2177 : a5 0a __ LDA WORK + 7 
2179 : 85 1c __ STA ACCU + 1 
217b : a5 09 __ LDA WORK + 6 
217d : 85 1b __ STA ACCU + 0 
217f : 60 __ __ RTS
2180 : a9 00 __ LDA #$00
2182 : 85 1b __ STA ACCU + 0 
2184 : 85 1c __ STA ACCU + 1 
2186 : 85 1d __ STA ACCU + 2 
2188 : 85 1e __ STA ACCU + 3 
218a : 60 __ __ RTS
--------------------------------------------------------------------
fmul8:
218b : 38 __ __ SEC
218c : 6a __ __ ROR
218d : 90 1e __ BCC $21ad ; (fmul8 + 34)
218f : aa __ __ TAX
2190 : 18 __ __ CLC
2191 : 98 __ __ TYA
2192 : 65 09 __ ADC WORK + 6 
2194 : 85 09 __ STA WORK + 6 
2196 : a5 0a __ LDA WORK + 7 
2198 : 65 1c __ ADC ACCU + 1 
219a : 85 0a __ STA WORK + 7 
219c : a5 0b __ LDA $0b 
219e : 65 1d __ ADC ACCU + 2 
21a0 : 6a __ __ ROR
21a1 : 85 0b __ STA $0b 
21a3 : 8a __ __ TXA
21a4 : 66 0a __ ROR WORK + 7 
21a6 : 66 09 __ ROR WORK + 6 
21a8 : 4a __ __ LSR
21a9 : f0 0d __ BEQ $21b8 ; (fmul8 + 45)
21ab : b0 e2 __ BCS $218f ; (fmul8 + 4)
21ad : 66 0b __ ROR $0b 
21af : 66 0a __ ROR WORK + 7 
21b1 : 66 09 __ ROR WORK + 6 
21b3 : 4a __ __ LSR
21b4 : 90 f7 __ BCC $21ad ; (fmul8 + 34)
21b6 : d0 d7 __ BNE $218f ; (fmul8 + 4)
21b8 : 60 __ __ RTS
--------------------------------------------------------------------
fdiv:
21b9 : a5 1b __ LDA ACCU + 0 
21bb : 05 1c __ ORA ACCU + 1 
21bd : 05 1d __ ORA ACCU + 2 
21bf : d0 03 __ BNE $21c4 ; (fdiv + 11)
21c1 : 85 1e __ STA ACCU + 3 
21c3 : 60 __ __ RTS
21c4 : a5 1e __ LDA ACCU + 3 
21c6 : 45 06 __ EOR WORK + 3 
21c8 : 29 80 __ AND #$80
21ca : 85 1e __ STA ACCU + 3 
21cc : a5 08 __ LDA WORK + 5 
21ce : f0 62 __ BEQ $2232 ; (fdiv + 121)
21d0 : a5 07 __ LDA WORK + 4 
21d2 : c9 ff __ CMP #$ff
21d4 : f0 5c __ BEQ $2232 ; (fdiv + 121)
21d6 : a9 00 __ LDA #$00
21d8 : 85 09 __ STA WORK + 6 
21da : 85 0a __ STA WORK + 7 
21dc : 85 0b __ STA $0b 
21de : a2 18 __ LDX #$18
21e0 : a5 1b __ LDA ACCU + 0 
21e2 : c5 03 __ CMP WORK + 0 
21e4 : a5 1c __ LDA ACCU + 1 
21e6 : e5 04 __ SBC WORK + 1 
21e8 : a5 1d __ LDA ACCU + 2 
21ea : e5 05 __ SBC WORK + 2 
21ec : 90 13 __ BCC $2201 ; (fdiv + 72)
21ee : a5 1b __ LDA ACCU + 0 
21f0 : e5 03 __ SBC WORK + 0 
21f2 : 85 1b __ STA ACCU + 0 
21f4 : a5 1c __ LDA ACCU + 1 
21f6 : e5 04 __ SBC WORK + 1 
21f8 : 85 1c __ STA ACCU + 1 
21fa : a5 1d __ LDA ACCU + 2 
21fc : e5 05 __ SBC WORK + 2 
21fe : 85 1d __ STA ACCU + 2 
2200 : 38 __ __ SEC
2201 : 26 09 __ ROL WORK + 6 
2203 : 26 0a __ ROL WORK + 7 
2205 : 26 0b __ ROL $0b 
2207 : ca __ __ DEX
2208 : f0 0a __ BEQ $2214 ; (fdiv + 91)
220a : 06 1b __ ASL ACCU + 0 
220c : 26 1c __ ROL ACCU + 1 
220e : 26 1d __ ROL ACCU + 2 
2210 : b0 dc __ BCS $21ee ; (fdiv + 53)
2212 : 90 cc __ BCC $21e0 ; (fdiv + 39)
2214 : 38 __ __ SEC
2215 : a5 0b __ LDA $0b 
2217 : 30 06 __ BMI $221f ; (fdiv + 102)
2219 : 06 09 __ ASL WORK + 6 
221b : 26 0a __ ROL WORK + 7 
221d : 2a __ __ ROL
221e : 18 __ __ CLC
221f : 29 7f __ AND #$7f
2221 : 85 0b __ STA $0b 
2223 : a5 07 __ LDA WORK + 4 
2225 : e5 08 __ SBC WORK + 5 
2227 : 90 1a __ BCC $2243 ; (fdiv + 138)
2229 : 18 __ __ CLC
222a : 69 7f __ ADC #$7f
222c : b0 04 __ BCS $2232 ; (fdiv + 121)
222e : c9 ff __ CMP #$ff
2230 : d0 15 __ BNE $2247 ; (fdiv + 142)
2232 : a5 1e __ LDA ACCU + 3 
2234 : 09 7f __ ORA #$7f
2236 : 85 1e __ STA ACCU + 3 
2238 : a9 80 __ LDA #$80
223a : 85 1d __ STA ACCU + 2 
223c : a9 00 __ LDA #$00
223e : 85 1c __ STA ACCU + 1 
2240 : 85 1b __ STA ACCU + 0 
2242 : 60 __ __ RTS
2243 : 69 7f __ ADC #$7f
2245 : 90 15 __ BCC $225c ; (fdiv + 163)
2247 : 4a __ __ LSR
2248 : 05 1e __ ORA ACCU + 3 
224a : 85 1e __ STA ACCU + 3 
224c : a9 00 __ LDA #$00
224e : 6a __ __ ROR
224f : 05 0b __ ORA $0b 
2251 : 85 1d __ STA ACCU + 2 
2253 : a5 0a __ LDA WORK + 7 
2255 : 85 1c __ STA ACCU + 1 
2257 : a5 09 __ LDA WORK + 6 
2259 : 85 1b __ STA ACCU + 0 
225b : 60 __ __ RTS
225c : a9 00 __ LDA #$00
225e : 85 1e __ STA ACCU + 3 
2260 : 85 1d __ STA ACCU + 2 
2262 : 85 1c __ STA ACCU + 1 
2264 : 85 1b __ STA ACCU + 0 
2266 : 60 __ __ RTS
--------------------------------------------------------------------
divs16:
2267 : 24 1c __ BIT ACCU + 1 
2269 : 10 0d __ BPL $2278 ; (divs16 + 17)
226b : 20 85 22 JSR $2285 ; (negaccu + 0)
226e : 24 04 __ BIT WORK + 1 
2270 : 10 0d __ BPL $227f ; (divs16 + 24)
2272 : 20 93 22 JSR $2293 ; (negtmp + 0)
2275 : 4c a1 22 JMP $22a1 ; (divmod + 0)
2278 : 24 04 __ BIT WORK + 1 
227a : 10 f9 __ BPL $2275 ; (divs16 + 14)
227c : 20 93 22 JSR $2293 ; (negtmp + 0)
227f : 20 a1 22 JSR $22a1 ; (divmod + 0)
2282 : 4c 85 22 JMP $2285 ; (negaccu + 0)
--------------------------------------------------------------------
negaccu:
2285 : 38 __ __ SEC
2286 : a9 00 __ LDA #$00
2288 : e5 1b __ SBC ACCU + 0 
228a : 85 1b __ STA ACCU + 0 
228c : a9 00 __ LDA #$00
228e : e5 1c __ SBC ACCU + 1 
2290 : 85 1c __ STA ACCU + 1 
2292 : 60 __ __ RTS
--------------------------------------------------------------------
negtmp:
2293 : 38 __ __ SEC
2294 : a9 00 __ LDA #$00
2296 : e5 03 __ SBC WORK + 0 
2298 : 85 03 __ STA WORK + 0 
229a : a9 00 __ LDA #$00
229c : e5 04 __ SBC WORK + 1 
229e : 85 04 __ STA WORK + 1 
22a0 : 60 __ __ RTS
--------------------------------------------------------------------
divmod:
22a1 : a5 1c __ LDA ACCU + 1 
22a3 : d0 31 __ BNE $22d6 ; (divmod + 53)
22a5 : a5 04 __ LDA WORK + 1 
22a7 : d0 1e __ BNE $22c7 ; (divmod + 38)
22a9 : 85 06 __ STA WORK + 3 
22ab : a2 04 __ LDX #$04
22ad : 06 1b __ ASL ACCU + 0 
22af : 2a __ __ ROL
22b0 : c5 03 __ CMP WORK + 0 
22b2 : 90 02 __ BCC $22b6 ; (divmod + 21)
22b4 : e5 03 __ SBC WORK + 0 
22b6 : 26 1b __ ROL ACCU + 0 
22b8 : 2a __ __ ROL
22b9 : c5 03 __ CMP WORK + 0 
22bb : 90 02 __ BCC $22bf ; (divmod + 30)
22bd : e5 03 __ SBC WORK + 0 
22bf : 26 1b __ ROL ACCU + 0 
22c1 : ca __ __ DEX
22c2 : d0 eb __ BNE $22af ; (divmod + 14)
22c4 : 85 05 __ STA WORK + 2 
22c6 : 60 __ __ RTS
22c7 : a5 1b __ LDA ACCU + 0 
22c9 : 85 05 __ STA WORK + 2 
22cb : a5 1c __ LDA ACCU + 1 
22cd : 85 06 __ STA WORK + 3 
22cf : a9 00 __ LDA #$00
22d1 : 85 1b __ STA ACCU + 0 
22d3 : 85 1c __ STA ACCU + 1 
22d5 : 60 __ __ RTS
22d6 : a5 04 __ LDA WORK + 1 
22d8 : d0 1f __ BNE $22f9 ; (divmod + 88)
22da : a5 03 __ LDA WORK + 0 
22dc : 30 1b __ BMI $22f9 ; (divmod + 88)
22de : a9 00 __ LDA #$00
22e0 : 85 06 __ STA WORK + 3 
22e2 : a2 10 __ LDX #$10
22e4 : 06 1b __ ASL ACCU + 0 
22e6 : 26 1c __ ROL ACCU + 1 
22e8 : 2a __ __ ROL
22e9 : c5 03 __ CMP WORK + 0 
22eb : 90 02 __ BCC $22ef ; (divmod + 78)
22ed : e5 03 __ SBC WORK + 0 
22ef : 26 1b __ ROL ACCU + 0 
22f1 : 26 1c __ ROL ACCU + 1 
22f3 : ca __ __ DEX
22f4 : d0 f2 __ BNE $22e8 ; (divmod + 71)
22f6 : 85 05 __ STA WORK + 2 
22f8 : 60 __ __ RTS
22f9 : a9 00 __ LDA #$00
22fb : 85 05 __ STA WORK + 2 
22fd : 85 06 __ STA WORK + 3 
22ff : 84 02 __ STY $02 
2301 : a0 10 __ LDY #$10
2303 : 18 __ __ CLC
2304 : 26 1b __ ROL ACCU + 0 
2306 : 26 1c __ ROL ACCU + 1 
2308 : 26 05 __ ROL WORK + 2 
230a : 26 06 __ ROL WORK + 3 
230c : 38 __ __ SEC
230d : a5 05 __ LDA WORK + 2 
230f : e5 03 __ SBC WORK + 0 
2311 : aa __ __ TAX
2312 : a5 06 __ LDA WORK + 3 
2314 : e5 04 __ SBC WORK + 1 
2316 : 90 04 __ BCC $231c ; (divmod + 123)
2318 : 86 05 __ STX WORK + 2 
231a : 85 06 __ STA WORK + 3 
231c : 88 __ __ DEY
231d : d0 e5 __ BNE $2304 ; (divmod + 99)
231f : 26 1b __ ROL ACCU + 0 
2321 : 26 1c __ ROL ACCU + 1 
2323 : a4 02 __ LDY $02 
2325 : 60 __ __ RTS
--------------------------------------------------------------------
mods16:
2326 : 24 1c __ BIT ACCU + 1 
2328 : 10 0d __ BPL $2337 ; (mods16 + 17)
232a : 20 85 22 JSR $2285 ; (negaccu + 0)
232d : 24 04 __ BIT WORK + 1 
232f : 10 0d __ BPL $233e ; (mods16 + 24)
2331 : 20 93 22 JSR $2293 ; (negtmp + 0)
2334 : 4c a1 22 JMP $22a1 ; (divmod + 0)
2337 : 24 04 __ BIT WORK + 1 
2339 : 10 f9 __ BPL $2334 ; (mods16 + 14)
233b : 20 93 22 JSR $2293 ; (negtmp + 0)
233e : 20 a1 22 JSR $22a1 ; (divmod + 0)
2341 : 38 __ __ SEC
2342 : a9 00 __ LDA #$00
2344 : e5 05 __ SBC WORK + 2 
2346 : 85 05 __ STA WORK + 2 
2348 : a9 00 __ LDA #$00
234a : e5 06 __ SBC WORK + 3 
234c : 85 06 __ STA WORK + 3 
234e : 60 __ __ RTS
--------------------------------------------------------------------
f32_to_i16:
234f : 20 e2 1f JSR $1fe2 ; (freg + 36)
2352 : a5 07 __ LDA WORK + 4 
2354 : c9 7f __ CMP #$7f
2356 : b0 07 __ BCS $235f ; (f32_to_i16 + 16)
2358 : a9 00 __ LDA #$00
235a : 85 1b __ STA ACCU + 0 
235c : 85 1c __ STA ACCU + 1 
235e : 60 __ __ RTS
235f : 38 __ __ SEC
2360 : e9 8e __ SBC #$8e
2362 : 90 0a __ BCC $236e ; (f32_to_i16 + 31)
2364 : a9 ff __ LDA #$ff
2366 : 85 1b __ STA ACCU + 0 
2368 : a9 7f __ LDA #$7f
236a : 85 1c __ STA ACCU + 1 
236c : d0 08 __ BNE $2376 ; (f32_to_i16 + 39)
236e : aa __ __ TAX
236f : 46 1d __ LSR ACCU + 2 
2371 : 66 1c __ ROR ACCU + 1 
2373 : e8 __ __ INX
2374 : d0 f9 __ BNE $236f ; (f32_to_i16 + 32)
2376 : 24 1e __ BIT ACCU + 3 
2378 : 10 0e __ BPL $2388 ; (f32_to_i16 + 57)
237a : 38 __ __ SEC
237b : a9 00 __ LDA #$00
237d : e5 1c __ SBC ACCU + 1 
237f : 85 1b __ STA ACCU + 0 
2381 : a9 00 __ LDA #$00
2383 : e5 1d __ SBC ACCU + 2 
2385 : 85 1c __ STA ACCU + 1 
2387 : 60 __ __ RTS
2388 : a5 1c __ LDA ACCU + 1 
238a : 85 1b __ STA ACCU + 0 
238c : a5 1d __ LDA ACCU + 2 
238e : 85 1c __ STA ACCU + 1 
2390 : 60 __ __ RTS
--------------------------------------------------------------------
sint16_to_float:
2391 : 24 1c __ BIT ACCU + 1 
2393 : 30 03 __ BMI $2398 ; (sint16_to_float + 7)
2395 : 4c af 23 JMP $23af ; (uint16_to_float + 0)
2398 : 38 __ __ SEC
2399 : a9 00 __ LDA #$00
239b : e5 1b __ SBC ACCU + 0 
239d : 85 1b __ STA ACCU + 0 
239f : a9 00 __ LDA #$00
23a1 : e5 1c __ SBC ACCU + 1 
23a3 : 85 1c __ STA ACCU + 1 
23a5 : 20 af 23 JSR $23af ; (uint16_to_float + 0)
23a8 : a5 1e __ LDA ACCU + 3 
23aa : 09 80 __ ORA #$80
23ac : 85 1e __ STA ACCU + 3 
23ae : 60 __ __ RTS
--------------------------------------------------------------------
uint16_to_float:
23af : a5 1b __ LDA ACCU + 0 
23b1 : 05 1c __ ORA ACCU + 1 
23b3 : d0 05 __ BNE $23ba ; (uint16_to_float + 11)
23b5 : 85 1d __ STA ACCU + 2 
23b7 : 85 1e __ STA ACCU + 3 
23b9 : 60 __ __ RTS
23ba : a2 8e __ LDX #$8e
23bc : a5 1c __ LDA ACCU + 1 
23be : 30 06 __ BMI $23c6 ; (uint16_to_float + 23)
23c0 : ca __ __ DEX
23c1 : 06 1b __ ASL ACCU + 0 
23c3 : 2a __ __ ROL
23c4 : 10 fa __ BPL $23c0 ; (uint16_to_float + 17)
23c6 : 29 7f __ AND #$7f
23c8 : 85 1d __ STA ACCU + 2 
23ca : a5 1b __ LDA ACCU + 0 
23cc : 85 1c __ STA ACCU + 1 
23ce : 8a __ __ TXA
23cf : 4a __ __ LSR
23d0 : 85 1e __ STA ACCU + 3 
23d2 : a9 00 __ LDA #$00
23d4 : 85 1b __ STA ACCU + 0 
23d6 : 6a __ __ ROR
23d7 : 05 1d __ ORA ACCU + 2 
23d9 : 85 1d __ STA ACCU + 2 
23db : 60 __ __ RTS
--------------------------------------------------------------------
divmod32:
23dc : 84 02 __ STY $02 
23de : a0 20 __ LDY #$20
23e0 : a9 00 __ LDA #$00
23e2 : 85 07 __ STA WORK + 4 
23e4 : 85 08 __ STA WORK + 5 
23e6 : 85 09 __ STA WORK + 6 
23e8 : 85 0a __ STA WORK + 7 
23ea : a5 05 __ LDA WORK + 2 
23ec : 05 06 __ ORA WORK + 3 
23ee : d0 39 __ BNE $2429 ; (divmod32 + 77)
23f0 : 18 __ __ CLC
23f1 : 26 1b __ ROL ACCU + 0 
23f3 : 26 1c __ ROL ACCU + 1 
23f5 : 26 1d __ ROL ACCU + 2 
23f7 : 26 1e __ ROL ACCU + 3 
23f9 : 26 07 __ ROL WORK + 4 
23fb : 26 08 __ ROL WORK + 5 
23fd : 90 0c __ BCC $240b ; (divmod32 + 47)
23ff : a5 07 __ LDA WORK + 4 
2401 : e5 03 __ SBC WORK + 0 
2403 : aa __ __ TAX
2404 : a5 08 __ LDA WORK + 5 
2406 : e5 04 __ SBC WORK + 1 
2408 : 38 __ __ SEC
2409 : b0 0c __ BCS $2417 ; (divmod32 + 59)
240b : 38 __ __ SEC
240c : a5 07 __ LDA WORK + 4 
240e : e5 03 __ SBC WORK + 0 
2410 : aa __ __ TAX
2411 : a5 08 __ LDA WORK + 5 
2413 : e5 04 __ SBC WORK + 1 
2415 : 90 04 __ BCC $241b ; (divmod32 + 63)
2417 : 86 07 __ STX WORK + 4 
2419 : 85 08 __ STA WORK + 5 
241b : 88 __ __ DEY
241c : d0 d3 __ BNE $23f1 ; (divmod32 + 21)
241e : 26 1b __ ROL ACCU + 0 
2420 : 26 1c __ ROL ACCU + 1 
2422 : 26 1d __ ROL ACCU + 2 
2424 : 26 1e __ ROL ACCU + 3 
2426 : a4 02 __ LDY $02 
2428 : 60 __ __ RTS
2429 : 18 __ __ CLC
242a : 26 1b __ ROL ACCU + 0 
242c : 26 1c __ ROL ACCU + 1 
242e : 26 1d __ ROL ACCU + 2 
2430 : 26 1e __ ROL ACCU + 3 
2432 : 26 07 __ ROL WORK + 4 
2434 : 26 08 __ ROL WORK + 5 
2436 : 26 09 __ ROL WORK + 6 
2438 : 26 0a __ ROL WORK + 7 
243a : a5 07 __ LDA WORK + 4 
243c : c5 03 __ CMP WORK + 0 
243e : a5 08 __ LDA WORK + 5 
2440 : e5 04 __ SBC WORK + 1 
2442 : a5 09 __ LDA WORK + 6 
2444 : e5 05 __ SBC WORK + 2 
2446 : a5 0a __ LDA WORK + 7 
2448 : e5 06 __ SBC WORK + 3 
244a : 90 18 __ BCC $2464 ; (divmod32 + 136)
244c : a5 07 __ LDA WORK + 4 
244e : e5 03 __ SBC WORK + 0 
2450 : 85 07 __ STA WORK + 4 
2452 : a5 08 __ LDA WORK + 5 
2454 : e5 04 __ SBC WORK + 1 
2456 : 85 08 __ STA WORK + 5 
2458 : a5 09 __ LDA WORK + 6 
245a : e5 05 __ SBC WORK + 2 
245c : 85 09 __ STA WORK + 6 
245e : a5 0a __ LDA WORK + 7 
2460 : e5 06 __ SBC WORK + 3 
2462 : 85 0a __ STA WORK + 7 
2464 : 88 __ __ DEY
2465 : d0 c3 __ BNE $242a ; (divmod32 + 78)
2467 : 26 1b __ ROL ACCU + 0 
2469 : 26 1c __ ROL ACCU + 1 
246b : 26 1d __ ROL ACCU + 2 
246d : 26 1e __ ROL ACCU + 3 
246f : a4 02 __ LDY $02 
2471 : 60 __ __ RTS
--------------------------------------------------------------------
__multab5L:
2472 : __ __ __ BYT 00 05 0a 0f 14 19 1e 23 28 2d                   : .......#(-
--------------------------------------------------------------------
__multab3L:
247c : __ __ __ BYT 00 03 06                                        : ...
