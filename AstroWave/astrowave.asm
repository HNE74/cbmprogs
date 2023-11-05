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
080e : 8e 4d 24 STX $244d ; (spentry + 0)
0811 : a9 d7 __ LDA #$d7
0813 : 85 19 __ STA IP + 0 
0815 : a9 24 __ LDA #$24
0817 : 85 1a __ STA IP + 1 
0819 : 38 __ __ SEC
081a : a9 25 __ LDA #$25
081c : e9 24 __ SBC #$24
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
0830 : a9 28 __ LDA #$28
0832 : e9 d7 __ SBC #$d7
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
244d : __ __ __ BYT 00                                              : .
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
0897 : ad eb 24 LDA $24eb ; (game + 0)
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
08af : 20 79 22 JSR $2279 ; (divmod + 0)
08b2 : a5 05 __ LDA WORK + 2 
08b4 : 05 06 __ ORA WORK + 3 
08b6 : d0 09 __ BNE $08c1 ; (main.s7 + 0)
.s5:
08b8 : 20 e1 18 JSR $18e1 ; (spawn_enemy.s0 + 0)
08bb : 20 60 19 JSR $1960 ; (move_enemies.s1000 + 0)
08be : 20 94 1b JSR $1b94 ; (render_enemies.s0 + 0)
.s7:
08c1 : 20 ec 1b JSR $1bec ; (move_enemy_shots.s0 + 0)
08c4 : 20 3f 1b JSR $1b3f ; (render_enemy_shots.s0 + 0)
08c7 : 20 56 1c JSR $1c56 ; (check_player_enemy_collision.s0 + 0)
08ca : 20 a8 1c JSR $1ca8 ; (control_player_ship.s0 + 0)
08cd : 20 c6 1d JSR $1dc6 ; (render_player_ship.s0 + 0)
08d0 : 20 56 1c JSR $1c56 ; (check_player_enemy_collision.s0 + 0)
08d3 : 20 06 1e JSR $1e06 ; (move_player_shots.s0 + 0)
08d6 : 20 6e 1e JSR $1e6e ; (render_player_shots.s0 + 0)
08d9 : 20 c3 1e JSR $1ec3 ; (check_shot_enemy_collision.s0 + 0)
08dc : a9 03 __ LDA #$03
08de : 85 0d __ STA P0 
08e0 : a9 00 __ LDA #$00
08e2 : 85 0e __ STA P1 
08e4 : 20 75 1f JSR $1f75 ; (wait_frames.s0 + 0)
08e7 : e6 53 __ INC T0 + 0 
08e9 : ad eb 24 LDA $24eb ; (game + 0)
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
091a : bd 4d 24 LDA $244d,x ; (spentry + 0)
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
244e : __ __ __ BYT 80 e0 f8 7f 7f f8 e0 80 00 00 60 3e 3e 60 00 00 : ..........`>>`..
245e : __ __ __ BYT 00 00 3c 66 66 3c 00 00 1c 7f c6 1f 1f c6 7f 1c : ..<ff<..........
246e : __ __ __ BYT 00 3c 7e d5 ab 7e 3c 00 28 3c 6e df 5f fe 3c 14 : .<~..~<.(<n._.<.
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
0a0c : 8d d7 24 STA $24d7 ; (Player + 0)
0a0f : a9 0c __ LDA #$0c
0a11 : 8d d8 24 STA $24d8 ; (Player + 1)
.s1001:
0a14 : 60 __ __ RTS
--------------------------------------------------------------------
Player:
24d7 : __ __ __ BSS	2
--------------------------------------------------------------------
init_enemies:
.s0:
0a15 : a2 00 __ LDX #$00
0a17 : a0 0a __ LDY #$0a
.l1002:
0a19 : a9 00 __ LDA #$00
0a1b : 9d 00 25 STA $2500,x ; (Enemy + 0)
0a1e : 9d 01 25 STA $2501,x ; (Enemy + 1)
0a21 : 9d 03 25 STA $2503,x ; (Enemy + 3)
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
2500 : __ __ __ BSS	40
--------------------------------------------------------------------
init_shots:
.s0:
0a2d : a2 00 __ LDX #$00
0a2f : a0 03 __ LDY #$03
0a31 : 8a __ __ TXA
.l1006:
0a32 : 9d d9 24 STA $24d9,x ; (PlayerShot + 0)
0a35 : 9d da 24 STA $24da,x ; (PlayerShot + 1)
0a38 : 9d db 24 STA $24db,x ; (PlayerShot + 2)
0a3b : e8 __ __ INX
0a3c : e8 __ __ INX
0a3d : e8 __ __ INX
0a3e : 88 __ __ DEY
0a3f : d0 f1 __ BNE $0a32 ; (init_shots.l1006 + 0)
.s6:
0a41 : a0 03 __ LDY #$03
0a43 : aa __ __ TAX
.l1008:
0a44 : 9d e2 24 STA $24e2,x ; (EnemyShot + 0)
0a47 : 9d e3 24 STA $24e3,x ; (EnemyShot + 1)
0a4a : 9d e4 24 STA $24e4,x ; (EnemyShot + 2)
0a4d : e8 __ __ INX
0a4e : e8 __ __ INX
0a4f : e8 __ __ INX
0a50 : 88 __ __ DEY
0a51 : d0 f1 __ BNE $0a44 ; (init_shots.l1008 + 0)
.s1001:
0a53 : 60 __ __ RTS
--------------------------------------------------------------------
PlayerShot:
24d9 : __ __ __ BSS	9
--------------------------------------------------------------------
EnemyShot:
24e2 : __ __ __ BSS	9
--------------------------------------------------------------------
init_game_state:
.s0:
0a54 : a9 00 __ LDA #$00
0a56 : 8d eb 24 STA $24eb ; (game + 0)
0a59 : 8d ec 24 STA $24ec ; (game + 1)
0a5c : 8d ed 24 STA $24ed ; (game + 2)
0a5f : 8d ee 24 STA $24ee ; (game + 3)
0a62 : 8d ef 24 STA $24ef ; (game + 4)
.s1001:
0a65 : 60 __ __ RTS
--------------------------------------------------------------------
game:
24eb : __ __ __ BSS	5
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
0ab4 : a9 f0 __ LDA #$f0
0ab6 : 85 0d __ STA P0 
0ab8 : a9 24 __ LDA #$24
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
0b05 : b9 7e 24 LDA $247e,y ; (mul40 + 0)
0b08 : 85 1b __ STA ACCU + 0 
0b0a : 18 __ __ CLC
0b0b : 65 11 __ ADC P4 ; (sx + 0)
0b0d : aa __ __ TAX
0b0e : b9 7f 24 LDA $247f,y ; (mul40 + 1)
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
247e : __ __ __ BYT 00 00 28 00 50 00 78 00 a0 00 c8 00 f0 00 18 01 : ..(.P.x.........
248e : __ __ __ BYT 40 01 68 01 90 01 b8 01 e0 01 08 02 30 02 58 02 : @.h.........0.X.
249e : __ __ __ BYT 80 02 a8 02 d0 02 f8 02 20 03 48 03 70 03 98 03 : ........ .H.p...
24ae : __ __ __ BYT c0 03                                           : ..
--------------------------------------------------------------------
cwTop:
24f0 : __ __ __ BSS	10
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
0b50 : a9 f0 __ LDA #$f0
0b52 : 85 0d __ STA P0 
0b54 : a9 24 __ LDA #$24
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
0b78 : ad ec 24 LDA $24ec ; (game + 1)
0b7b : c8 __ __ INY
0b7c : 91 23 __ STA (SP + 0),y 
0b7e : ad ed 24 LDA $24ed ; (game + 2)
0b81 : c8 __ __ INY
0b82 : 91 23 __ STA (SP + 0),y 
0b84 : ad ee 24 LDA $24ee ; (game + 3)
0b87 : c8 __ __ INY
0b88 : 91 23 __ STA (SP + 0),y 
0b8a : ad ef 24 LDA $24ef ; (game + 4)
0b8d : c8 __ __ INY
0b8e : 91 23 __ STA (SP + 0),y 
0b90 : 20 17 0c JSR $0c17 ; (sprintf.s1000 + 0)
0b93 : a9 f0 __ LDA #$f0
0b95 : 85 0d __ STA P0 
0b97 : a9 24 __ LDA #$24
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
0bc2 : bd 7e 24 LDA $247e,x ; (mul40 + 0)
0bc5 : 18 __ __ CLC
0bc6 : 65 0f __ ADC P2 ; (x + 0)
0bc8 : 85 1b __ STA ACCU + 0 
0bca : bd 7f 24 LDA $247f,x ; (mul40 + 1)
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
0bfe : bd b0 24 LDA $24b0,x ; (p2smap + 0)
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
24b0 : __ __ __ BYT 00 00 40 20 80 c0 80 80                         : ..@ ....
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
10c4 : ae b8 24 LDX $24b8 ; (giocharmap + 0)
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
24b8 : __ __ __ BYT 01                                              : .
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
114d : 20 79 22 JSR $2279 ; (divmod + 0)
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
1180 : 20 79 22 JSR $2279 ; (divmod + 0)
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
13a5 : 20 b4 23 JSR $23b4 ; (divmod32 + 0)
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
13e6 : 20 b4 23 JSR $23b4 ; (divmod32 + 0)
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
14ec : 20 aa 1f JSR $1faa ; (freg + 20)
14ef : 20 91 21 JSR $2191 ; (fdiv + 0)
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
1514 : ad d2 24 LDA $24d2 ; (fround5 + 25)
1517 : 85 1c __ STA ACCU + 1 
1519 : ad d3 24 LDA $24d3 ; (fround5 + 26)
151c : 85 1d __ STA ACCU + 2 
151e : ad d4 24 LDA $24d4 ; (fround5 + 27)
1521 : ae d1 24 LDX $24d1 ; (fround5 + 24)
1524 : 4c 3a 15 JMP $153a ; (nformf.s214 + 0)
.s35:
1527 : 0a __ __ ASL
1528 : 0a __ __ ASL
1529 : a8 __ __ TAY
152a : b9 b6 24 LDA $24b6,y ; (p2smap + 6)
152d : 85 1c __ STA ACCU + 1 
152f : b9 b7 24 LDA $24b7,y ; (p2smap + 7)
1532 : 85 1d __ STA ACCU + 2 
1534 : b9 b8 24 LDA $24b8,y ; (giocharmap + 0)
1537 : be b5 24 LDX $24b5,y ; (p2smap + 5)
.s214:
153a : 86 1b __ STX ACCU + 0 
153c : 85 1e __ STA ACCU + 3 
153e : a2 43 __ LDX #$43
1540 : 20 9a 1f JSR $1f9a ; (freg + 4)
1543 : 20 db 1f JSR $1fdb ; (faddsub + 0)
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
1570 : 20 aa 1f JSR $1faa ; (freg + 20)
1573 : 20 91 21 JSR $2191 ; (fdiv + 0)
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
15d6 : 20 27 23 JSR $2327 ; (f32_to_i16 + 0)
15d9 : a5 1b __ LDA ACCU + 0 
15db : 85 4f __ STA T11 + 0 
15dd : 20 69 23 JSR $2369 ; (sint16_to_float + 0)
15e0 : a2 43 __ LDX #$43
15e2 : 20 9a 1f JSR $1f9a ; (freg + 4)
15e5 : a5 1e __ LDA ACCU + 3 
15e7 : 49 80 __ EOR #$80
15e9 : 85 1e __ STA ACCU + 3 
15eb : 20 db 1f JSR $1fdb ; (faddsub + 0)
15ee : a9 00 __ LDA #$00
15f0 : 85 03 __ STA WORK + 0 
15f2 : 85 04 __ STA WORK + 1 
15f4 : a9 20 __ LDA #$20
15f6 : 85 05 __ STA WORK + 2 
15f8 : a9 41 __ LDA #$41
15fa : 85 06 __ STA WORK + 3 
15fc : 20 aa 1f JSR $1faa ; (freg + 20)
15ff : 20 c2 20 JSR $20c2 ; (fmul + 0)
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
1660 : 20 3f 22 JSR $223f ; (divs16 + 0)
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
167e : 20 fe 22 JSR $22fe ; (mods16 + 0)
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
171a : ad d2 24 LDA $24d2 ; (fround5 + 25)
171d : 85 1c __ STA ACCU + 1 
171f : ad d3 24 LDA $24d3 ; (fround5 + 26)
1722 : 85 1d __ STA ACCU + 2 
1724 : ad d4 24 LDA $24d4 ; (fround5 + 27)
1727 : ae d1 24 LDX $24d1 ; (fround5 + 24)
172a : 4c 40 17 JMP $1740 ; (nformf.s204 + 0)
.s41:
172d : 0a __ __ ASL
172e : 0a __ __ ASL
172f : a8 __ __ TAY
1730 : b9 b6 24 LDA $24b6,y ; (p2smap + 6)
1733 : 85 1c __ STA ACCU + 1 
1735 : b9 b7 24 LDA $24b7,y ; (p2smap + 7)
1738 : 85 1d __ STA ACCU + 2 
173a : b9 b8 24 LDA $24b8,y ; (giocharmap + 0)
173d : be b5 24 LDX $24b5,y ; (p2smap + 5)
.s204:
1740 : 86 1b __ STX ACCU + 0 
1742 : 85 1e __ STA ACCU + 3 
1744 : a2 43 __ LDX #$43
1746 : 20 9a 1f JSR $1f9a ; (freg + 4)
1749 : 20 db 1f JSR $1fdb ; (faddsub + 0)
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
177c : 20 aa 1f JSR $1faa ; (freg + 20)
177f : 20 91 21 JSR $2191 ; (fdiv + 0)
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
17d6 : 20 aa 1f JSR $1faa ; (freg + 20)
17d9 : 20 91 21 JSR $2191 ; (fdiv + 0)
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
1809 : 20 9a 1f JSR $1f9a ; (freg + 4)
180c : 20 c2 20 JSR $20c2 ; (fmul + 0)
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
186c : 20 aa 1f JSR $1faa ; (freg + 20)
186f : 20 91 21 JSR $2191 ; (fdiv + 0)
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
24b9 : __ __ __ BYT 00 00 00 3f cd cc 4c 3d 0a d7 a3 3b 6f 12 03 3a : ...?..L=...;o..:
24c9 : __ __ __ BYT 17 b7 51 38 ac c5 a7 36 bd 37 06 35             : ..Q8...6.7.5
--------------------------------------------------------------------
18de : __ __ __ BYT 25 64 00                                        : %d.
--------------------------------------------------------------------
spawn_enemy:
.s0:
18e1 : 20 39 19 JSR $1939 ; (rand.s0 + 0)
18e4 : 46 1b __ LSR ACCU + 0 
18e6 : b0 13 __ BCS $18fb ; (spawn_enemy.s1001 + 0)
.s3:
18e8 : a9 00 __ LDA #$00
18ea : a8 __ __ TAY
.l6:
18eb : 0a __ __ ASL
18ec : 0a __ __ ASL
18ed : 85 43 __ STA T0 + 0 
18ef : aa __ __ TAX
18f0 : bd 03 25 LDA $2503,x ; (Enemy + 3)
18f3 : f0 07 __ BEQ $18fc ; (spawn_enemy.s9 + 0)
.s7:
18f5 : c8 __ __ INY
18f6 : 98 __ __ TYA
18f7 : c0 0a __ CPY #$0a
18f9 : 90 f0 __ BCC $18eb ; (spawn_enemy.l6 + 0)
.s1001:
18fb : 60 __ __ RTS
.s9:
18fc : a9 27 __ LDA #$27
18fe : 9d 00 25 STA $2500,x ; (Enemy + 0)
1901 : 20 39 19 JSR $1939 ; (rand.s0 + 0)
1904 : a9 16 __ LDA #$16
1906 : 85 03 __ STA WORK + 0 
1908 : a9 00 __ LDA #$00
190a : 85 04 __ STA WORK + 1 
190c : 20 79 22 JSR $2279 ; (divmod + 0)
190f : 18 __ __ CLC
1910 : a5 05 __ LDA WORK + 2 
1912 : 69 03 __ ADC #$03
1914 : a6 43 __ LDX T0 + 0 
1916 : 9d 01 25 STA $2501,x ; (Enemy + 1)
1919 : 20 39 19 JSR $1939 ; (rand.s0 + 0)
191c : a9 01 __ LDA #$01
191e : a6 43 __ LDX T0 + 0 
1920 : 9d 03 25 STA $2503,x ; (Enemy + 3)
1923 : a9 03 __ LDA #$03
1925 : 85 03 __ STA WORK + 0 
1927 : a9 00 __ LDA #$00
1929 : 85 04 __ STA WORK + 1 
192b : 20 79 22 JSR $2279 ; (divmod + 0)
192e : 18 __ __ CLC
192f : a5 05 __ LDA WORK + 2 
1931 : 69 83 __ ADC #$83
1933 : a6 43 __ LDX T0 + 0 
1935 : 9d 02 25 STA $2502,x ; (Enemy + 2)
1938 : 60 __ __ RTS
--------------------------------------------------------------------
rand:
.s0:
1939 : ad d6 24 LDA $24d6 ; (seed + 1)
193c : 4a __ __ LSR
193d : ad d5 24 LDA $24d5 ; (seed + 0)
1940 : 6a __ __ ROR
1941 : aa __ __ TAX
1942 : a9 00 __ LDA #$00
1944 : 6a __ __ ROR
1945 : 4d d5 24 EOR $24d5 ; (seed + 0)
1948 : 85 1b __ STA ACCU + 0 
194a : 8a __ __ TXA
194b : 4d d6 24 EOR $24d6 ; (seed + 1)
194e : 85 1c __ STA ACCU + 1 
1950 : 4a __ __ LSR
1951 : 45 1b __ EOR ACCU + 0 
1953 : 8d d5 24 STA $24d5 ; (seed + 0)
1956 : 85 1b __ STA ACCU + 0 
1958 : 45 1c __ EOR ACCU + 1 
195a : 8d d6 24 STA $24d6 ; (seed + 1)
195d : 85 1c __ STA ACCU + 1 
.s1001:
195f : 60 __ __ RTS
--------------------------------------------------------------------
seed:
24d5 : __ __ __ BYT 00 7a                                           : .z
--------------------------------------------------------------------
move_enemies:
.s1000:
1960 : a2 03 __ LDX #$03
1962 : b5 53 __ LDA T0 + 0,x 
1964 : 9d 9f 9f STA $9f9f,x ; (move_enemies@stack + 0)
1967 : ca __ __ DEX
1968 : 10 f8 __ BPL $1962 ; (move_enemies.s1000 + 2)
.s0:
196a : a9 00 __ LDA #$00
196c : 85 53 __ STA T0 + 0 
.l2:
196e : 0a __ __ ASL
196f : 0a __ __ ASL
1970 : 85 54 __ STA T1 + 0 
1972 : a8 __ __ TAY
1973 : b9 03 25 LDA $2503,y ; (Enemy + 3)
1976 : c9 01 __ CMP #$01
1978 : d0 6e __ BNE $19e8 ; (move_enemies.s35 + 0)
.s5:
197a : 18 __ __ CLC
197b : a9 00 __ LDA #$00
197d : 65 54 __ ADC T1 + 0 
197f : 85 54 __ STA T1 + 0 
1981 : a9 25 __ LDA #$25
1983 : 69 00 __ ADC #$00
1985 : 85 55 __ STA T1 + 1 
1987 : b9 01 25 LDA $2501,y ; (Enemy + 1)
198a : cd d8 24 CMP $24d8 ; (Player + 1)
198d : d0 10 __ BNE $199f ; (move_enemies.s10 + 0)
.s8:
198f : a5 54 __ LDA T1 + 0 
1991 : 8d fe 9f STA $9ffe ; (sstack + 8)
1994 : a5 55 __ LDA T1 + 1 
1996 : 8d ff 9f STA $9fff ; (sstack + 9)
1999 : 20 58 1a JSR $1a58 ; (spawn_enemy_shot.s1000 + 0)
199c : 20 3f 1b JSR $1b3f ; (render_enemy_shots.s0 + 0)
.s10:
199f : a0 00 __ LDY #$00
19a1 : b1 54 __ LDA (T1 + 0),y 
19a3 : 85 56 __ STA T3 + 0 
19a5 : c8 __ __ INY
19a6 : b1 54 __ LDA (T1 + 0),y 
19a8 : 0a __ __ ASL
19a9 : 85 1b __ STA ACCU + 0 
19ab : a9 00 __ LDA #$00
19ad : 2a __ __ ROL
19ae : 06 1b __ ASL ACCU + 0 
19b0 : 2a __ __ ROL
19b1 : aa __ __ TAX
19b2 : a5 1b __ LDA ACCU + 0 
19b4 : 71 54 __ ADC (T1 + 0),y 
19b6 : 85 46 __ STA T5 + 0 
19b8 : 8a __ __ TXA
19b9 : 69 00 __ ADC #$00
19bb : 06 46 __ ASL T5 + 0 
19bd : 2a __ __ ROL
19be : 06 46 __ ASL T5 + 0 
19c0 : 2a __ __ ROL
19c1 : 06 46 __ ASL T5 + 0 
19c3 : 2a __ __ ROL
19c4 : aa __ __ TAX
19c5 : 18 __ __ CLC
19c6 : a5 46 __ LDA T5 + 0 
19c8 : 65 56 __ ADC T3 + 0 
19ca : 85 43 __ STA T2 + 0 
19cc : 85 1f __ STA ADDR + 0 
19ce : 8a __ __ TXA
19cf : 69 c0 __ ADC #$c0
19d1 : 85 44 __ STA T2 + 1 
19d3 : 18 __ __ CLC
19d4 : 69 18 __ ADC #$18
19d6 : 85 20 __ STA ADDR + 1 
19d8 : a9 20 __ LDA #$20
19da : 88 __ __ DEY
19db : 91 43 __ STA (T2 + 0),y 
19dd : 98 __ __ TYA
19de : 91 1f __ STA (ADDR + 0),y 
19e0 : a5 56 __ LDA T3 + 0 
19e2 : d0 1a __ BNE $19fe ; (move_enemies.s11 + 0)
.s12:
19e4 : a0 03 __ LDY #$03
.s1016:
19e6 : 91 54 __ STA (T1 + 0),y 
.s35:
19e8 : e6 53 __ INC T0 + 0 
19ea : a5 53 __ LDA T0 + 0 
19ec : c9 0a __ CMP #$0a
19ee : b0 03 __ BCS $19f3 ; (move_enemies.s1001 + 0)
19f0 : 4c 6e 19 JMP $196e ; (move_enemies.l2 + 0)
.s1001:
19f3 : a2 03 __ LDX #$03
19f5 : bd 9f 9f LDA $9f9f,x ; (move_enemies@stack + 0)
19f8 : 95 53 __ STA T0 + 0,x 
19fa : ca __ __ DEX
19fb : 10 f8 __ BPL $19f5 ; (move_enemies.s1001 + 2)
19fd : 60 __ __ RTS
.s11:
19fe : c6 56 __ DEC T3 + 0 
1a00 : a5 56 __ LDA T3 + 0 
1a02 : 91 54 __ STA (T1 + 0),y 
1a04 : 20 39 19 JSR $1939 ; (rand.s0 + 0)
1a07 : a0 01 __ LDY #$01
1a09 : b1 54 __ LDA (T1 + 0),y 
1a0b : 85 45 __ STA T4 + 0 
1a0d : a9 03 __ LDA #$03
1a0f : 85 03 __ STA WORK + 0 
1a11 : a9 00 __ LDA #$00
1a13 : 85 04 __ STA WORK + 1 
1a15 : 20 79 22 JSR $2279 ; (divmod + 0)
1a18 : 38 __ __ SEC
1a19 : a5 05 __ LDA WORK + 2 
1a1b : e9 01 __ SBC #$01
1a1d : aa __ __ TAX
1a1e : a5 06 __ LDA WORK + 3 
1a20 : e9 00 __ SBC #$00
1a22 : a8 __ __ TAY
1a23 : 8a __ __ TXA
1a24 : 18 __ __ CLC
1a25 : 65 45 __ ADC T4 + 0 
1a27 : 85 43 __ STA T2 + 0 
1a29 : 90 01 __ BCC $1a2c ; (move_enemies.s1018 + 0)
.s1017:
1a2b : c8 __ __ INY
.s1018:
1a2c : 0a __ __ ASL
1a2d : 0a __ __ ASL
1a2e : 18 __ __ CLC
1a2f : 65 43 __ ADC T2 + 0 
1a31 : 0a __ __ ASL
1a32 : 0a __ __ ASL
1a33 : 0a __ __ ASL
1a34 : 18 __ __ CLC
1a35 : 65 56 __ ADC T3 + 0 
1a37 : aa __ __ TAX
1a38 : bd 00 c0 LDA $c000,x 
1a3b : c9 83 __ CMP #$83
1a3d : f0 a9 __ BEQ $19e8 ; (move_enemies.s35 + 0)
.s20:
1a3f : c9 84 __ CMP #$84
1a41 : f0 a5 __ BEQ $19e8 ; (move_enemies.s35 + 0)
.s19:
1a43 : c9 85 __ CMP #$85
1a45 : f0 a1 __ BEQ $19e8 ; (move_enemies.s35 + 0)
.s18:
1a47 : 98 __ __ TYA
1a48 : d0 9e __ BNE $19e8 ; (move_enemies.s35 + 0)
.s1005:
1a4a : a5 43 __ LDA T2 + 0 
1a4c : c9 03 __ CMP #$03
1a4e : 90 98 __ BCC $19e8 ; (move_enemies.s35 + 0)
.s1004:
1a50 : c9 19 __ CMP #$19
1a52 : b0 94 __ BCS $19e8 ; (move_enemies.s35 + 0)
.s14:
1a54 : a0 01 __ LDY #$01
1a56 : d0 8e __ BNE $19e6 ; (move_enemies.s1016 + 0)
--------------------------------------------------------------------
spawn_enemy_shot:
.s1000:
1a58 : a5 53 __ LDA T1 + 0 
1a5a : 8d a3 9f STA $9fa3 ; (spawn_enemy_shot@stack + 0)
1a5d : a5 54 __ LDA T3 + 0 
1a5f : 8d a4 9f STA $9fa4 ; (spawn_enemy_shot@stack + 1)
1a62 : 38 __ __ SEC
1a63 : a5 23 __ LDA SP + 0 
1a65 : e9 08 __ SBC #$08
1a67 : 85 23 __ STA SP + 0 
1a69 : b0 02 __ BCS $1a6d ; (spawn_enemy_shot.s0 + 0)
1a6b : c6 24 __ DEC SP + 1 
.s0:
1a6d : ad fe 9f LDA $9ffe ; (sstack + 8)
1a70 : 85 43 __ STA T0 + 0 
1a72 : ad ff 9f LDA $9fff ; (sstack + 9)
1a75 : 85 44 __ STA T0 + 1 
1a77 : a0 00 __ LDY #$00
1a79 : b1 43 __ LDA (T0 + 0),y 
1a7b : f0 0f __ BEQ $1a8c ; (spawn_enemy_shot.s1001 + 0)
.s3:
1a7d : a2 00 __ LDX #$00
.l6:
1a7f : bc 4a 24 LDY $244a,x ; (__multab3L + 0)
1a82 : b9 e4 24 LDA $24e4,y ; (EnemyShot + 2)
1a85 : f0 1b __ BEQ $1aa2 ; (spawn_enemy_shot.s9 + 0)
.s7:
1a87 : e8 __ __ INX
1a88 : e0 03 __ CPX #$03
1a8a : 90 f3 __ BCC $1a7f ; (spawn_enemy_shot.l6 + 0)
.s1001:
1a8c : 18 __ __ CLC
1a8d : a5 23 __ LDA SP + 0 
1a8f : 69 08 __ ADC #$08
1a91 : 85 23 __ STA SP + 0 
1a93 : 90 02 __ BCC $1a97 ; (spawn_enemy_shot.s1001 + 11)
1a95 : e6 24 __ INC SP + 1 
1a97 : ad a3 9f LDA $9fa3 ; (spawn_enemy_shot@stack + 0)
1a9a : 85 53 __ STA T1 + 0 
1a9c : ad a4 9f LDA $9fa4 ; (spawn_enemy_shot@stack + 1)
1a9f : 85 54 __ STA T3 + 0 
1aa1 : 60 __ __ RTS
.s9:
1aa2 : a9 14 __ LDA #$14
1aa4 : 85 0d __ STA P0 
1aa6 : a9 00 __ LDA #$00
1aa8 : 85 0e __ STA P1 
1aaa : 85 10 __ STA P3 
1aac : a9 01 __ LDA #$01
1aae : 85 0f __ STA P2 
1ab0 : 99 e4 24 STA $24e4,y ; (EnemyShot + 2)
1ab3 : ad fe 9f LDA $9ffe ; (sstack + 8)
1ab6 : 85 45 __ STA T2 + 0 
1ab8 : ad ff 9f LDA $9fff ; (sstack + 9)
1abb : 85 46 __ STA T2 + 1 
1abd : a0 00 __ LDY #$00
1abf : b1 45 __ LDA (T2 + 0),y 
1ac1 : 38 __ __ SEC
1ac2 : e9 01 __ SBC #$01
1ac4 : 85 54 __ STA T3 + 0 
1ac6 : bc 4a 24 LDY $244a,x ; (__multab3L + 0)
1ac9 : 99 e2 24 STA $24e2,y ; (EnemyShot + 0)
1acc : a0 01 __ LDY #$01
1ace : b1 45 __ LDA (T2 + 0),y 
1ad0 : 85 53 __ STA T1 + 0 
1ad2 : bc 4a 24 LDY $244a,x ; (__multab3L + 0)
1ad5 : 99 e3 24 STA $24e3,y ; (EnemyShot + 1)
1ad8 : 20 00 1b JSR $1b00 ; (gotoxy.s0 + 0)
1adb : a9 37 __ LDA #$37
1add : a0 02 __ LDY #$02
1adf : 91 23 __ STA (SP + 0),y 
1ae1 : a9 1b __ LDA #$1b
1ae3 : c8 __ __ INY
1ae4 : 91 23 __ STA (SP + 0),y 
1ae6 : a5 54 __ LDA T3 + 0 
1ae8 : c8 __ __ INY
1ae9 : 91 23 __ STA (SP + 0),y 
1aeb : a9 00 __ LDA #$00
1aed : c8 __ __ INY
1aee : 91 23 __ STA (SP + 0),y 
1af0 : a5 53 __ LDA T1 + 0 
1af2 : c8 __ __ INY
1af3 : 91 23 __ STA (SP + 0),y 
1af5 : a9 00 __ LDA #$00
1af7 : c8 __ __ INY
1af8 : 91 23 __ STA (SP + 0),y 
1afa : 20 09 1b JSR $1b09 ; (printf.s0 + 0)
1afd : 4c 8c 1a JMP $1a8c ; (spawn_enemy_shot.s1001 + 0)
--------------------------------------------------------------------
gotoxy:
.s0:
1b00 : a6 0f __ LDX P2 
1b02 : a4 0d __ LDY P0 
1b04 : 18 __ __ CLC
1b05 : 20 f0 ff JSR $fff0 
.s1001:
1b08 : 60 __ __ RTS
--------------------------------------------------------------------
printf:
.s0:
1b09 : a9 01 __ LDA #$01
1b0b : 8d fd 9f STA $9ffd ; (sstack + 7)
1b0e : a9 a6 __ LDA #$a6
1b10 : 8d f7 9f STA $9ff7 ; (sstack + 1)
1b13 : a9 9f __ LDA #$9f
1b15 : 8d f8 9f STA $9ff8 ; (sstack + 2)
1b18 : a0 02 __ LDY #$02
1b1a : b1 23 __ LDA (SP + 0),y 
1b1c : 8d f9 9f STA $9ff9 ; (sstack + 3)
1b1f : c8 __ __ INY
1b20 : b1 23 __ LDA (SP + 0),y 
1b22 : 8d fa 9f STA $9ffa ; (sstack + 4)
1b25 : 18 __ __ CLC
1b26 : a5 23 __ LDA SP + 0 
1b28 : 69 04 __ ADC #$04
1b2a : 8d fb 9f STA $9ffb ; (sstack + 5)
1b2d : a5 24 __ LDA SP + 1 
1b2f : 69 00 __ ADC #$00
1b31 : 8d fc 9f STA $9ffc ; (sstack + 6)
1b34 : 4c 6e 0c JMP $0c6e ; (sformat.s1000 + 0)
--------------------------------------------------------------------
1b37 : __ __ __ BYT 25 64 20 2d 20 25 64 00                         : %d - %d.
--------------------------------------------------------------------
render_enemy_shots:
.s0:
1b3f : a2 00 __ LDX #$00
.l1006:
1b41 : bc 4a 24 LDY $244a,x ; (__multab3L + 0)
1b44 : b9 e4 24 LDA $24e4,y ; (EnemyShot + 2)
1b47 : c9 01 __ CMP #$01
1b49 : d0 43 __ BNE $1b8e ; (render_enemy_shots.s19 + 0)
.s5:
1b4b : b9 e3 24 LDA $24e3,y ; (EnemyShot + 1)
1b4e : 0a __ __ ASL
1b4f : 85 1b __ STA ACCU + 0 
1b51 : a9 00 __ LDA #$00
1b53 : 2a __ __ ROL
1b54 : 06 1b __ ASL ACCU + 0 
1b56 : 2a __ __ ROL
1b57 : 85 1c __ STA ACCU + 1 
1b59 : a5 1b __ LDA ACCU + 0 
1b5b : 79 e3 24 ADC $24e3,y ; (EnemyShot + 1)
1b5e : 85 1b __ STA ACCU + 0 
1b60 : a5 1c __ LDA ACCU + 1 
1b62 : 69 00 __ ADC #$00
1b64 : 06 1b __ ASL ACCU + 0 
1b66 : 2a __ __ ROL
1b67 : 06 1b __ ASL ACCU + 0 
1b69 : 2a __ __ ROL
1b6a : 06 1b __ ASL ACCU + 0 
1b6c : 2a __ __ ROL
1b6d : 85 1c __ STA ACCU + 1 
1b6f : 18 __ __ CLC
1b70 : a5 1b __ LDA ACCU + 0 
1b72 : 79 e2 24 ADC $24e2,y ; (EnemyShot + 0)
1b75 : 85 1b __ STA ACCU + 0 
1b77 : 85 1f __ STA ADDR + 0 
1b79 : a5 1c __ LDA ACCU + 1 
1b7b : 69 c0 __ ADC #$c0
1b7d : 85 1c __ STA ACCU + 1 
1b7f : 18 __ __ CLC
1b80 : 69 18 __ ADC #$18
1b82 : 85 20 __ STA ADDR + 1 
1b84 : a9 82 __ LDA #$82
1b86 : a0 00 __ LDY #$00
1b88 : 91 1b __ STA (ACCU + 0),y 
1b8a : a9 01 __ LDA #$01
1b8c : 91 1f __ STA (ADDR + 0),y 
.s19:
1b8e : e8 __ __ INX
1b8f : e0 03 __ CPX #$03
1b91 : 90 ae __ BCC $1b41 ; (render_enemy_shots.l1006 + 0)
.s1001:
1b93 : 60 __ __ RTS
--------------------------------------------------------------------
render_enemies:
.s0:
1b94 : a9 00 __ LDA #$00
1b96 : aa __ __ TAX
.l2:
1b97 : 0a __ __ ASL
1b98 : 0a __ __ ASL
1b99 : a8 __ __ TAY
1b9a : b9 03 25 LDA $2503,y ; (Enemy + 3)
1b9d : c9 01 __ CMP #$01
1b9f : d0 44 __ BNE $1be5 ; (render_enemies.s19 + 0)
.s5:
1ba1 : b9 01 25 LDA $2501,y ; (Enemy + 1)
1ba4 : 0a __ __ ASL
1ba5 : 85 1b __ STA ACCU + 0 
1ba7 : a9 00 __ LDA #$00
1ba9 : 2a __ __ ROL
1baa : 06 1b __ ASL ACCU + 0 
1bac : 2a __ __ ROL
1bad : 85 1c __ STA ACCU + 1 
1baf : a5 1b __ LDA ACCU + 0 
1bb1 : 79 01 25 ADC $2501,y ; (Enemy + 1)
1bb4 : 85 1b __ STA ACCU + 0 
1bb6 : a5 1c __ LDA ACCU + 1 
1bb8 : 69 00 __ ADC #$00
1bba : 06 1b __ ASL ACCU + 0 
1bbc : 2a __ __ ROL
1bbd : 06 1b __ ASL ACCU + 0 
1bbf : 2a __ __ ROL
1bc0 : 06 1b __ ASL ACCU + 0 
1bc2 : 2a __ __ ROL
1bc3 : 85 1c __ STA ACCU + 1 
1bc5 : 18 __ __ CLC
1bc6 : a5 1b __ LDA ACCU + 0 
1bc8 : 79 00 25 ADC $2500,y ; (Enemy + 0)
1bcb : 85 1b __ STA ACCU + 0 
1bcd : 85 1f __ STA ADDR + 0 
1bcf : a5 1c __ LDA ACCU + 1 
1bd1 : 69 c0 __ ADC #$c0
1bd3 : 85 1c __ STA ACCU + 1 
1bd5 : 18 __ __ CLC
1bd6 : 69 18 __ ADC #$18
1bd8 : 85 20 __ STA ADDR + 1 
1bda : b9 02 25 LDA $2502,y ; (Enemy + 2)
1bdd : a0 00 __ LDY #$00
1bdf : 91 1b __ STA (ACCU + 0),y 
1be1 : a9 08 __ LDA #$08
1be3 : 91 1f __ STA (ADDR + 0),y 
.s19:
1be5 : e8 __ __ INX
1be6 : 8a __ __ TXA
1be7 : e0 0a __ CPX #$0a
1be9 : 90 ac __ BCC $1b97 ; (render_enemies.l2 + 0)
.s1001:
1beb : 60 __ __ RTS
--------------------------------------------------------------------
move_enemy_shots:
.s0:
1bec : a2 00 __ LDX #$00
.l1008:
1bee : bc 4a 24 LDY $244a,x ; (__multab3L + 0)
1bf1 : b9 e4 24 LDA $24e4,y ; (EnemyShot + 2)
1bf4 : c9 01 __ CMP #$01
1bf6 : d0 58 __ BNE $1c50 ; (move_enemy_shots.s23 + 0)
.s5:
1bf8 : 84 1d __ STY ACCU + 2 
1bfa : b9 e3 24 LDA $24e3,y ; (EnemyShot + 1)
1bfd : 0a __ __ ASL
1bfe : 85 1b __ STA ACCU + 0 
1c00 : a9 00 __ LDA #$00
1c02 : 2a __ __ ROL
1c03 : 06 1b __ ASL ACCU + 0 
1c05 : 2a __ __ ROL
1c06 : 85 1c __ STA ACCU + 1 
1c08 : a5 1b __ LDA ACCU + 0 
1c0a : 79 e3 24 ADC $24e3,y ; (EnemyShot + 1)
1c0d : 85 1b __ STA ACCU + 0 
1c0f : a5 1c __ LDA ACCU + 1 
1c11 : 69 00 __ ADC #$00
1c13 : 06 1b __ ASL ACCU + 0 
1c15 : 2a __ __ ROL
1c16 : 06 1b __ ASL ACCU + 0 
1c18 : 2a __ __ ROL
1c19 : 06 1b __ ASL ACCU + 0 
1c1b : 2a __ __ ROL
1c1c : 85 1c __ STA ACCU + 1 
1c1e : b9 e2 24 LDA $24e2,y ; (EnemyShot + 0)
1c21 : 85 1e __ STA ACCU + 3 
1c23 : 18 __ __ CLC
1c24 : 65 1b __ ADC ACCU + 0 
1c26 : 85 1b __ STA ACCU + 0 
1c28 : 85 1f __ STA ADDR + 0 
1c2a : a5 1c __ LDA ACCU + 1 
1c2c : 69 c0 __ ADC #$c0
1c2e : 85 1c __ STA ACCU + 1 
1c30 : 18 __ __ CLC
1c31 : 69 18 __ ADC #$18
1c33 : 85 20 __ STA ADDR + 1 
1c35 : a9 20 __ LDA #$20
1c37 : a0 00 __ LDY #$00
1c39 : 91 1b __ STA (ACCU + 0),y 
1c3b : 98 __ __ TYA
1c3c : 91 1f __ STA (ADDR + 0),y 
1c3e : c6 1e __ DEC ACCU + 3 
1c40 : a5 1e __ LDA ACCU + 3 
1c42 : a4 1d __ LDY ACCU + 2 
1c44 : 99 e2 24 STA $24e2,y ; (EnemyShot + 0)
1c47 : c9 ff __ CMP #$ff
1c49 : d0 05 __ BNE $1c50 ; (move_enemy_shots.s23 + 0)
.s8:
1c4b : a9 00 __ LDA #$00
1c4d : 99 e4 24 STA $24e4,y ; (EnemyShot + 2)
.s23:
1c50 : e8 __ __ INX
1c51 : e0 03 __ CPX #$03
1c53 : 90 99 __ BCC $1bee ; (move_enemy_shots.l1008 + 0)
.s1001:
1c55 : 60 __ __ RTS
--------------------------------------------------------------------
check_player_enemy_collision:
.s0:
1c56 : a9 00 __ LDA #$00
1c58 : a8 __ __ TAY
.l2:
1c59 : 0a __ __ ASL
1c5a : 0a __ __ ASL
1c5b : aa __ __ TAX
1c5c : bd 03 25 LDA $2503,x ; (Enemy + 3)
1c5f : c9 01 __ CMP #$01
1c61 : d0 10 __ BNE $1c73 ; (check_player_enemy_collision.s3 + 0)
.s5:
1c63 : bd 00 25 LDA $2500,x ; (Enemy + 0)
1c66 : cd d7 24 CMP $24d7 ; (Player + 0)
1c69 : d0 08 __ BNE $1c73 ; (check_player_enemy_collision.s3 + 0)
.s11:
1c6b : bd 01 25 LDA $2501,x ; (Enemy + 1)
1c6e : cd d8 24 CMP $24d8 ; (Player + 1)
1c71 : f0 2e __ BEQ $1ca1 ; (check_player_enemy_collision.s8 + 0)
.s3:
1c73 : c8 __ __ INY
1c74 : 98 __ __ TYA
1c75 : c0 0a __ CPY #$0a
1c77 : 90 e0 __ BCC $1c59 ; (check_player_enemy_collision.l2 + 0)
.s4:
1c79 : a0 00 __ LDY #$00
.l13:
1c7b : be 4a 24 LDX $244a,y ; (__multab3L + 0)
1c7e : bd e4 24 LDA $24e4,x ; (EnemyShot + 2)
1c81 : c9 01 __ CMP #$01
1c83 : d0 10 __ BNE $1c95 ; (check_player_enemy_collision.s14 + 0)
.s16:
1c85 : bd e2 24 LDA $24e2,x ; (EnemyShot + 0)
1c88 : cd d7 24 CMP $24d7 ; (Player + 0)
1c8b : d0 08 __ BNE $1c95 ; (check_player_enemy_collision.s14 + 0)
.s22:
1c8d : bd e3 24 LDA $24e3,x ; (EnemyShot + 1)
1c90 : cd d8 24 CMP $24d8 ; (Player + 1)
1c93 : f0 06 __ BEQ $1c9b ; (check_player_enemy_collision.s19 + 0)
.s14:
1c95 : c8 __ __ INY
1c96 : c0 03 __ CPY #$03
1c98 : 90 e1 __ BCC $1c7b ; (check_player_enemy_collision.l13 + 0)
.s1001:
1c9a : 60 __ __ RTS
.s19:
1c9b : a9 01 __ LDA #$01
1c9d : 8d eb 24 STA $24eb ; (game + 0)
1ca0 : 60 __ __ RTS
.s8:
1ca1 : a9 01 __ LDA #$01
1ca3 : 8d eb 24 STA $24eb ; (game + 0)
1ca6 : d0 d1 __ BNE $1c79 ; (check_player_enemy_collision.s4 + 0)
--------------------------------------------------------------------
control_player_ship:
.s0:
1ca8 : a9 00 __ LDA #$00
1caa : 20 4a 1d JSR $1d4a ; (joy_poll.s0 + 0)
1cad : ad fc 24 LDA $24fc ; (joyx + 0)
1cb0 : 85 1d __ STA ACCU + 2 
1cb2 : 85 1e __ STA ACCU + 3 
1cb4 : d0 08 __ BNE $1cbe ; (control_player_ship.s1 + 0)
.s4:
1cb6 : ad fa 24 LDA $24fa ; (joyy + 0)
1cb9 : d0 03 __ BNE $1cbe ; (control_player_ship.s1 + 0)
1cbb : 4c 3f 1d JMP $1d3f ; (control_player_ship.s3 + 0)
.s1:
1cbe : ad d7 24 LDA $24d7 ; (Player + 0)
1cc1 : 85 43 __ STA T2 + 0 
1cc3 : 85 44 __ STA T3 + 0 
1cc5 : ad d8 24 LDA $24d8 ; (Player + 1)
1cc8 : 85 45 __ STA T4 + 0 
1cca : 85 46 __ STA T5 + 0 
1ccc : 0a __ __ ASL
1ccd : 85 1b __ STA ACCU + 0 
1ccf : a9 00 __ LDA #$00
1cd1 : 2a __ __ ROL
1cd2 : 06 1b __ ASL ACCU + 0 
1cd4 : 2a __ __ ROL
1cd5 : aa __ __ TAX
1cd6 : a5 1b __ LDA ACCU + 0 
1cd8 : 65 45 __ ADC T4 + 0 
1cda : 85 1b __ STA ACCU + 0 
1cdc : 8a __ __ TXA
1cdd : 69 00 __ ADC #$00
1cdf : 06 1b __ ASL ACCU + 0 
1ce1 : 2a __ __ ROL
1ce2 : 06 1b __ ASL ACCU + 0 
1ce4 : 2a __ __ ROL
1ce5 : 06 1b __ ASL ACCU + 0 
1ce7 : 2a __ __ ROL
1ce8 : aa __ __ TAX
1ce9 : 18 __ __ CLC
1cea : a5 1b __ LDA ACCU + 0 
1cec : 65 43 __ ADC T2 + 0 
1cee : 85 1b __ STA ACCU + 0 
1cf0 : 85 1f __ STA ADDR + 0 
1cf2 : 8a __ __ TXA
1cf3 : 69 c0 __ ADC #$c0
1cf5 : 85 1c __ STA ACCU + 1 
1cf7 : 18 __ __ CLC
1cf8 : 69 18 __ ADC #$18
1cfa : 85 20 __ STA ADDR + 1 
1cfc : a9 20 __ LDA #$20
1cfe : a0 00 __ LDY #$00
1d00 : 91 1b __ STA (ACCU + 0),y 
1d02 : 98 __ __ TYA
1d03 : 91 1f __ STA (ADDR + 0),y 
1d05 : a5 43 __ LDA T2 + 0 
1d07 : f0 04 __ BEQ $1d0d ; (control_player_ship.s6 + 0)
.s8:
1d09 : a5 1d __ LDA ACCU + 2 
1d0b : 30 0c __ BMI $1d19 ; (control_player_ship.s5 + 0)
.s6:
1d0d : a5 43 __ LDA T2 + 0 
1d0f : c9 27 __ CMP #$27
1d11 : b0 0e __ BCS $1d21 ; (control_player_ship.s7 + 0)
.s12:
1d13 : a5 1d __ LDA ACCU + 2 
1d15 : 30 0a __ BMI $1d21 ; (control_player_ship.s7 + 0)
.s1009:
1d17 : f0 08 __ BEQ $1d21 ; (control_player_ship.s7 + 0)
.s5:
1d19 : 18 __ __ CLC
1d1a : a5 44 __ LDA T3 + 0 
1d1c : 65 1e __ ADC ACCU + 3 
1d1e : 8d d7 24 STA $24d7 ; (Player + 0)
.s7:
1d21 : a5 45 __ LDA T4 + 0 
1d23 : c9 04 __ CMP #$04
1d25 : 90 07 __ BCC $1d2e ; (control_player_ship.s14 + 0)
.s16:
1d27 : ad fa 24 LDA $24fa ; (joyy + 0)
1d2a : 30 0d __ BMI $1d39 ; (control_player_ship.s32 + 0)
.s1012:
1d2c : a5 45 __ LDA T4 + 0 
.s14:
1d2e : c9 18 __ CMP #$18
1d30 : b0 0d __ BCS $1d3f ; (control_player_ship.s3 + 0)
.s20:
1d32 : ad fa 24 LDA $24fa ; (joyy + 0)
1d35 : 30 08 __ BMI $1d3f ; (control_player_ship.s3 + 0)
.s1004:
1d37 : f0 06 __ BEQ $1d3f ; (control_player_ship.s3 + 0)
.s32:
1d39 : 18 __ __ CLC
1d3a : 65 46 __ ADC T5 + 0 
1d3c : 8d d8 24 STA $24d8 ; (Player + 1)
.s3:
1d3f : ad fe 24 LDA $24fe ; (joyb + 0)
1d42 : c9 01 __ CMP #$01
1d44 : f0 01 __ BEQ $1d47 ; (control_player_ship.s21 + 0)
.s1001:
1d46 : 60 __ __ RTS
.s21:
1d47 : 4c 8a 1d JMP $1d8a ; (spawn_player_shot.s0 + 0)
--------------------------------------------------------------------
joy_poll:
.s0:
1d4a : aa __ __ TAX
1d4b : bd 00 dc LDA $dc00,x 
1d4e : a8 __ __ TAY
1d4f : 29 10 __ AND #$10
1d51 : f0 04 __ BEQ $1d57 ; (joy_poll.s1005 + 0)
.s1006:
1d53 : a9 00 __ LDA #$00
1d55 : f0 02 __ BEQ $1d59 ; (joy_poll.s1007 + 0)
.s1005:
1d57 : a9 01 __ LDA #$01
.s1007:
1d59 : 9d fe 24 STA $24fe,x ; (joyb + 0)
1d5c : 98 __ __ TYA
1d5d : 4a __ __ LSR
1d5e : b0 1d __ BCS $1d7d ; (joy_poll.s2 + 0)
.s1:
1d60 : a9 ff __ LDA #$ff
.s15:
1d62 : 9d fa 24 STA $24fa,x ; (joyy + 0)
1d65 : 98 __ __ TYA
1d66 : 29 04 __ AND #$04
1d68 : d0 06 __ BNE $1d70 ; (joy_poll.s8 + 0)
.s7:
1d6a : a9 ff __ LDA #$ff
.s1001:
1d6c : 9d fc 24 STA $24fc,x ; (joyx + 0)
1d6f : 60 __ __ RTS
.s8:
1d70 : 98 __ __ TYA
1d71 : 29 08 __ AND #$08
1d73 : f0 04 __ BEQ $1d79 ; (joy_poll.s1011 + 0)
.s1012:
1d75 : a9 00 __ LDA #$00
1d77 : f0 f3 __ BEQ $1d6c ; (joy_poll.s1001 + 0)
.s1011:
1d79 : a9 01 __ LDA #$01
1d7b : d0 ef __ BNE $1d6c ; (joy_poll.s1001 + 0)
.s2:
1d7d : 98 __ __ TYA
1d7e : 29 02 __ AND #$02
1d80 : f0 04 __ BEQ $1d86 ; (joy_poll.s1008 + 0)
.s1009:
1d82 : a9 00 __ LDA #$00
1d84 : f0 dc __ BEQ $1d62 ; (joy_poll.s15 + 0)
.s1008:
1d86 : a9 01 __ LDA #$01
1d88 : d0 d8 __ BNE $1d62 ; (joy_poll.s15 + 0)
--------------------------------------------------------------------
joyy:
24fa : __ __ __ BSS	2
--------------------------------------------------------------------
joyx:
24fc : __ __ __ BSS	2
--------------------------------------------------------------------
joyb:
24fe : __ __ __ BSS	2
--------------------------------------------------------------------
spawn_player_shot:
.s0:
1d8a : ad d7 24 LDA $24d7 ; (Player + 0)
1d8d : c9 27 __ CMP #$27
1d8f : f0 0f __ BEQ $1da0 ; (spawn_player_shot.s1001 + 0)
.s3:
1d91 : a0 00 __ LDY #$00
.l6:
1d93 : be 4a 24 LDX $244a,y ; (__multab3L + 0)
1d96 : bd db 24 LDA $24db,x ; (PlayerShot + 2)
1d99 : f0 06 __ BEQ $1da1 ; (spawn_player_shot.s9 + 0)
.s7:
1d9b : c8 __ __ INY
1d9c : c0 03 __ CPY #$03
1d9e : 90 f3 __ BCC $1d93 ; (spawn_player_shot.l6 + 0)
.s1001:
1da0 : 60 __ __ RTS
.s9:
1da1 : a9 01 __ LDA #$01
1da3 : 9d db 24 STA $24db,x ; (PlayerShot + 2)
1da6 : ad d8 24 LDA $24d8 ; (Player + 1)
1da9 : 9d da 24 STA $24da,x ; (PlayerShot + 1)
1dac : ad fc 24 LDA $24fc ; (joyx + 0)
1daf : 30 02 __ BMI $1db3 ; (spawn_player_shot.s13 + 0)
.s1007:
1db1 : d0 06 __ BNE $1db9 ; (spawn_player_shot.s12 + 0)
.s13:
1db3 : ad d7 24 LDA $24d7 ; (Player + 0)
1db6 : 4c bf 1d JMP $1dbf ; (spawn_player_shot.s1010 + 0)
.s12:
1db9 : ad d7 24 LDA $24d7 ; (Player + 0)
1dbc : 18 __ __ CLC
1dbd : 69 01 __ ADC #$01
.s1010:
1dbf : be 4a 24 LDX $244a,y ; (__multab3L + 0)
1dc2 : 9d d9 24 STA $24d9,x ; (PlayerShot + 0)
1dc5 : 60 __ __ RTS
--------------------------------------------------------------------
render_player_ship:
.s0:
1dc6 : ad d8 24 LDA $24d8 ; (Player + 1)
1dc9 : 0a __ __ ASL
1dca : 85 1b __ STA ACCU + 0 
1dcc : a9 00 __ LDA #$00
1dce : 2a __ __ ROL
1dcf : 06 1b __ ASL ACCU + 0 
1dd1 : 2a __ __ ROL
1dd2 : aa __ __ TAX
1dd3 : a5 1b __ LDA ACCU + 0 
1dd5 : 6d d8 24 ADC $24d8 ; (Player + 1)
1dd8 : 85 1b __ STA ACCU + 0 
1dda : 8a __ __ TXA
1ddb : 69 00 __ ADC #$00
1ddd : 06 1b __ ASL ACCU + 0 
1ddf : 2a __ __ ROL
1de0 : 06 1b __ ASL ACCU + 0 
1de2 : 2a __ __ ROL
1de3 : 06 1b __ ASL ACCU + 0 
1de5 : 2a __ __ ROL
1de6 : aa __ __ TAX
1de7 : 18 __ __ CLC
1de8 : a5 1b __ LDA ACCU + 0 
1dea : 6d d7 24 ADC $24d7 ; (Player + 0)
1ded : 85 1b __ STA ACCU + 0 
1def : 85 1f __ STA ADDR + 0 
1df1 : 8a __ __ TXA
1df2 : 69 c0 __ ADC #$c0
1df4 : 85 1c __ STA ACCU + 1 
1df6 : 18 __ __ CLC
1df7 : 69 18 __ ADC #$18
1df9 : 85 20 __ STA ADDR + 1 
1dfb : a9 80 __ LDA #$80
1dfd : a0 00 __ LDY #$00
1dff : 91 1b __ STA (ACCU + 0),y 
1e01 : a9 03 __ LDA #$03
1e03 : 91 1f __ STA (ADDR + 0),y 
.s1001:
1e05 : 60 __ __ RTS
--------------------------------------------------------------------
move_player_shots:
.s0:
1e06 : a2 00 __ LDX #$00
.l2:
1e08 : 86 1d __ STX ACCU + 2 
1e0a : bc 4a 24 LDY $244a,x ; (__multab3L + 0)
1e0d : b9 db 24 LDA $24db,y ; (PlayerShot + 2)
1e10 : c9 01 __ CMP #$01
1e12 : d0 52 __ BNE $1e66 ; (move_player_shots.s23 + 0)
.s5:
1e14 : 84 1e __ STY ACCU + 3 
1e16 : b9 da 24 LDA $24da,y ; (PlayerShot + 1)
1e19 : 0a __ __ ASL
1e1a : 85 1b __ STA ACCU + 0 
1e1c : a9 00 __ LDA #$00
1e1e : 2a __ __ ROL
1e1f : 06 1b __ ASL ACCU + 0 
1e21 : 2a __ __ ROL
1e22 : aa __ __ TAX
1e23 : a5 1b __ LDA ACCU + 0 
1e25 : 79 da 24 ADC $24da,y ; (PlayerShot + 1)
1e28 : 85 1b __ STA ACCU + 0 
1e2a : 8a __ __ TXA
1e2b : 69 00 __ ADC #$00
1e2d : 06 1b __ ASL ACCU + 0 
1e2f : 2a __ __ ROL
1e30 : 06 1b __ ASL ACCU + 0 
1e32 : 2a __ __ ROL
1e33 : 06 1b __ ASL ACCU + 0 
1e35 : 2a __ __ ROL
1e36 : 85 1c __ STA ACCU + 1 
1e38 : b9 d9 24 LDA $24d9,y ; (PlayerShot + 0)
1e3b : aa __ __ TAX
1e3c : 18 __ __ CLC
1e3d : 65 1b __ ADC ACCU + 0 
1e3f : 85 1b __ STA ACCU + 0 
1e41 : 85 1f __ STA ADDR + 0 
1e43 : a5 1c __ LDA ACCU + 1 
1e45 : 69 c0 __ ADC #$c0
1e47 : 85 1c __ STA ACCU + 1 
1e49 : 18 __ __ CLC
1e4a : 69 18 __ ADC #$18
1e4c : 85 20 __ STA ADDR + 1 
1e4e : a9 20 __ LDA #$20
1e50 : a0 00 __ LDY #$00
1e52 : 91 1b __ STA (ACCU + 0),y 
1e54 : 98 __ __ TYA
1e55 : 91 1f __ STA (ADDR + 0),y 
1e57 : e8 __ __ INX
1e58 : 8a __ __ TXA
1e59 : a6 1e __ LDX ACCU + 3 
1e5b : 9d d9 24 STA $24d9,x ; (PlayerShot + 0)
1e5e : c9 28 __ CMP #$28
1e60 : 90 04 __ BCC $1e66 ; (move_player_shots.s23 + 0)
.s8:
1e62 : 98 __ __ TYA
1e63 : 9d db 24 STA $24db,x ; (PlayerShot + 2)
.s23:
1e66 : a6 1d __ LDX ACCU + 2 
1e68 : e8 __ __ INX
1e69 : e0 03 __ CPX #$03
1e6b : 90 9b __ BCC $1e08 ; (move_player_shots.l2 + 0)
.s1001:
1e6d : 60 __ __ RTS
--------------------------------------------------------------------
render_player_shots:
.s0:
1e6e : a2 00 __ LDX #$00
.l1006:
1e70 : bc 4a 24 LDY $244a,x ; (__multab3L + 0)
1e73 : b9 db 24 LDA $24db,y ; (PlayerShot + 2)
1e76 : c9 01 __ CMP #$01
1e78 : d0 43 __ BNE $1ebd ; (render_player_shots.s19 + 0)
.s5:
1e7a : b9 da 24 LDA $24da,y ; (PlayerShot + 1)
1e7d : 0a __ __ ASL
1e7e : 85 1b __ STA ACCU + 0 
1e80 : a9 00 __ LDA #$00
1e82 : 2a __ __ ROL
1e83 : 06 1b __ ASL ACCU + 0 
1e85 : 2a __ __ ROL
1e86 : 85 1c __ STA ACCU + 1 
1e88 : a5 1b __ LDA ACCU + 0 
1e8a : 79 da 24 ADC $24da,y ; (PlayerShot + 1)
1e8d : 85 1b __ STA ACCU + 0 
1e8f : a5 1c __ LDA ACCU + 1 
1e91 : 69 00 __ ADC #$00
1e93 : 06 1b __ ASL ACCU + 0 
1e95 : 2a __ __ ROL
1e96 : 06 1b __ ASL ACCU + 0 
1e98 : 2a __ __ ROL
1e99 : 06 1b __ ASL ACCU + 0 
1e9b : 2a __ __ ROL
1e9c : 85 1c __ STA ACCU + 1 
1e9e : 18 __ __ CLC
1e9f : a5 1b __ LDA ACCU + 0 
1ea1 : 79 d9 24 ADC $24d9,y ; (PlayerShot + 0)
1ea4 : 85 1b __ STA ACCU + 0 
1ea6 : 85 1f __ STA ADDR + 0 
1ea8 : a5 1c __ LDA ACCU + 1 
1eaa : 69 c0 __ ADC #$c0
1eac : 85 1c __ STA ACCU + 1 
1eae : 18 __ __ CLC
1eaf : 69 18 __ ADC #$18
1eb1 : 85 20 __ STA ADDR + 1 
1eb3 : a9 81 __ LDA #$81
1eb5 : a0 00 __ LDY #$00
1eb7 : 91 1b __ STA (ACCU + 0),y 
1eb9 : a9 01 __ LDA #$01
1ebb : 91 1f __ STA (ADDR + 0),y 
.s19:
1ebd : e8 __ __ INX
1ebe : e0 03 __ CPX #$03
1ec0 : 90 ae __ BCC $1e70 ; (render_player_shots.l1006 + 0)
.s1001:
1ec2 : 60 __ __ RTS
--------------------------------------------------------------------
check_shot_enemy_collision:
.s0:
1ec3 : a2 00 __ LDX #$00
.l2:
1ec5 : 86 1d __ STX ACCU + 2 
1ec7 : bc 4a 24 LDY $244a,x ; (__multab3L + 0)
1eca : b9 db 24 LDA $24db,y ; (PlayerShot + 2)
1ecd : c9 01 __ CMP #$01
1ecf : f0 03 __ BEQ $1ed4 ; (check_shot_enemy_collision.s5 + 0)
1ed1 : 4c 6a 1f JMP $1f6a ; (check_shot_enemy_collision.s3 + 0)
.s5:
1ed4 : a9 00 __ LDA #$00
1ed6 : 85 43 __ STA T2 + 0 
.l9:
1ed8 : 0a __ __ ASL
1ed9 : 0a __ __ ASL
1eda : 85 1e __ STA ACCU + 3 
1edc : a8 __ __ TAY
1edd : b9 03 25 LDA $2503,y ; (Enemy + 3)
1ee0 : c9 01 __ CMP #$01
1ee2 : d0 7b __ BNE $1f5f ; (check_shot_enemy_collision.s43 + 0)
.s12:
1ee4 : a6 1d __ LDX ACCU + 2 
1ee6 : bd 4a 24 LDA $244a,x ; (__multab3L + 0)
1ee9 : 85 44 __ STA T3 + 0 
1eeb : aa __ __ TAX
1eec : b9 00 25 LDA $2500,y ; (Enemy + 0)
1eef : dd d9 24 CMP $24d9,x ; (PlayerShot + 0)
1ef2 : d0 6b __ BNE $1f5f ; (check_shot_enemy_collision.s43 + 0)
.s18:
1ef4 : b9 01 25 LDA $2501,y ; (Enemy + 1)
1ef7 : dd da 24 CMP $24da,x ; (PlayerShot + 1)
1efa : d0 63 __ BNE $1f5f ; (check_shot_enemy_collision.s43 + 0)
.s15:
1efc : 0a __ __ ASL
1efd : 85 1b __ STA ACCU + 0 
1eff : a9 00 __ LDA #$00
1f01 : 2a __ __ ROL
1f02 : 06 1b __ ASL ACCU + 0 
1f04 : 2a __ __ ROL
1f05 : aa __ __ TAX
1f06 : a5 1b __ LDA ACCU + 0 
1f08 : 79 01 25 ADC $2501,y ; (Enemy + 1)
1f0b : 85 1b __ STA ACCU + 0 
1f0d : 8a __ __ TXA
1f0e : 69 00 __ ADC #$00
1f10 : 06 1b __ ASL ACCU + 0 
1f12 : 2a __ __ ROL
1f13 : 06 1b __ ASL ACCU + 0 
1f15 : 2a __ __ ROL
1f16 : 06 1b __ ASL ACCU + 0 
1f18 : 2a __ __ ROL
1f19 : aa __ __ TAX
1f1a : 18 __ __ CLC
1f1b : a5 1b __ LDA ACCU + 0 
1f1d : 79 00 25 ADC $2500,y ; (Enemy + 0)
1f20 : 85 1b __ STA ACCU + 0 
1f22 : 85 1f __ STA ADDR + 0 
1f24 : 8a __ __ TXA
1f25 : 69 c0 __ ADC #$c0
1f27 : 85 1c __ STA ACCU + 1 
1f29 : 18 __ __ CLC
1f2a : 69 18 __ ADC #$18
1f2c : 85 20 __ STA ADDR + 1 
1f2e : a9 20 __ LDA #$20
1f30 : a0 00 __ LDY #$00
1f32 : 91 1b __ STA (ACCU + 0),y 
1f34 : 98 __ __ TYA
1f35 : 91 1f __ STA (ADDR + 0),y 
1f37 : a6 1e __ LDX ACCU + 3 
1f39 : 9d 03 25 STA $2503,x ; (Enemy + 3)
1f3c : a6 44 __ LDX T3 + 0 
1f3e : 9d db 24 STA $24db,x ; (PlayerShot + 2)
1f41 : ad ec 24 LDA $24ec ; (game + 1)
1f44 : 18 __ __ CLC
1f45 : 69 01 __ ADC #$01
1f47 : 8d ec 24 STA $24ec ; (game + 1)
1f4a : ad ed 24 LDA $24ed ; (game + 2)
1f4d : 69 00 __ ADC #$00
1f4f : 8d ed 24 STA $24ed ; (game + 2)
1f52 : ad ee 24 LDA $24ee ; (game + 3)
1f55 : 69 00 __ ADC #$00
1f57 : 8d ee 24 STA $24ee ; (game + 3)
1f5a : 90 03 __ BCC $1f5f ; (check_shot_enemy_collision.s43 + 0)
.s1014:
1f5c : ee ef 24 INC $24ef ; (game + 4)
.s43:
1f5f : e6 43 __ INC T2 + 0 
1f61 : a5 43 __ LDA T2 + 0 
1f63 : c9 0a __ CMP #$0a
1f65 : b0 03 __ BCS $1f6a ; (check_shot_enemy_collision.s3 + 0)
1f67 : 4c d8 1e JMP $1ed8 ; (check_shot_enemy_collision.l9 + 0)
.s3:
1f6a : a6 1d __ LDX ACCU + 2 
1f6c : e8 __ __ INX
1f6d : e0 03 __ CPX #$03
1f6f : b0 03 __ BCS $1f74 ; (check_shot_enemy_collision.s1001 + 0)
1f71 : 4c c5 1e JMP $1ec5 ; (check_shot_enemy_collision.l2 + 0)
.s1001:
1f74 : 60 __ __ RTS
--------------------------------------------------------------------
wait_frames:
.s0:
1f75 : a5 0e __ LDA P1 ; (frames + 1)
1f77 : 30 1c __ BMI $1f95 ; (wait_frames.s1001 + 0)
.s1005:
1f79 : 05 0d __ ORA P0 ; (frames + 0)
1f7b : f0 18 __ BEQ $1f95 ; (wait_frames.s1001 + 0)
.s13:
1f7d : a0 00 __ LDY #$00
1f7f : a6 0e __ LDX P1 ; (frames + 1)
.l6:
1f81 : ad 11 d0 LDA $d011 
1f84 : 30 fb __ BMI $1f81 ; (wait_frames.l6 + 0)
.l9:
1f86 : ad 11 d0 LDA $d011 
1f89 : 10 fb __ BPL $1f86 ; (wait_frames.l9 + 0)
.s3:
1f8b : c8 __ __ INY
1f8c : 8a __ __ TXA
1f8d : 30 06 __ BMI $1f95 ; (wait_frames.s1001 + 0)
.s1004:
1f8f : d0 f0 __ BNE $1f81 ; (wait_frames.l6 + 0)
.s1002:
1f91 : c4 0d __ CPY P0 ; (frames + 0)
1f93 : 90 ec __ BCC $1f81 ; (wait_frames.l6 + 0)
.s1001:
1f95 : 60 __ __ RTS
--------------------------------------------------------------------
freg:
1f96 : b1 19 __ LDA (IP + 0),y 
1f98 : c8 __ __ INY
1f99 : aa __ __ TAX
1f9a : b5 00 __ LDA $00,x 
1f9c : 85 03 __ STA WORK + 0 
1f9e : b5 01 __ LDA $01,x 
1fa0 : 85 04 __ STA WORK + 1 
1fa2 : b5 02 __ LDA $02,x 
1fa4 : 85 05 __ STA WORK + 2 
1fa6 : b5 03 __ LDA WORK + 0,x 
1fa8 : 85 06 __ STA WORK + 3 
1faa : a5 05 __ LDA WORK + 2 
1fac : 0a __ __ ASL
1fad : a5 06 __ LDA WORK + 3 
1faf : 2a __ __ ROL
1fb0 : 85 08 __ STA WORK + 5 
1fb2 : f0 06 __ BEQ $1fba ; (freg + 36)
1fb4 : a5 05 __ LDA WORK + 2 
1fb6 : 09 80 __ ORA #$80
1fb8 : 85 05 __ STA WORK + 2 
1fba : a5 1d __ LDA ACCU + 2 
1fbc : 0a __ __ ASL
1fbd : a5 1e __ LDA ACCU + 3 
1fbf : 2a __ __ ROL
1fc0 : 85 07 __ STA WORK + 4 
1fc2 : f0 06 __ BEQ $1fca ; (freg + 52)
1fc4 : a5 1d __ LDA ACCU + 2 
1fc6 : 09 80 __ ORA #$80
1fc8 : 85 1d __ STA ACCU + 2 
1fca : 60 __ __ RTS
1fcb : 06 1e __ ASL ACCU + 3 
1fcd : a5 07 __ LDA WORK + 4 
1fcf : 6a __ __ ROR
1fd0 : 85 1e __ STA ACCU + 3 
1fd2 : b0 06 __ BCS $1fda ; (freg + 68)
1fd4 : a5 1d __ LDA ACCU + 2 
1fd6 : 29 7f __ AND #$7f
1fd8 : 85 1d __ STA ACCU + 2 
1fda : 60 __ __ RTS
--------------------------------------------------------------------
faddsub:
1fdb : a9 ff __ LDA #$ff
1fdd : c5 07 __ CMP WORK + 4 
1fdf : f0 04 __ BEQ $1fe5 ; (faddsub + 10)
1fe1 : c5 08 __ CMP WORK + 5 
1fe3 : d0 11 __ BNE $1ff6 ; (faddsub + 27)
1fe5 : a5 1e __ LDA ACCU + 3 
1fe7 : 09 7f __ ORA #$7f
1fe9 : 85 1e __ STA ACCU + 3 
1feb : a9 80 __ LDA #$80
1fed : 85 1d __ STA ACCU + 2 
1fef : a9 00 __ LDA #$00
1ff1 : 85 1b __ STA ACCU + 0 
1ff3 : 85 1c __ STA ACCU + 1 
1ff5 : 60 __ __ RTS
1ff6 : 38 __ __ SEC
1ff7 : a5 07 __ LDA WORK + 4 
1ff9 : e5 08 __ SBC WORK + 5 
1ffb : f0 38 __ BEQ $2035 ; (faddsub + 90)
1ffd : aa __ __ TAX
1ffe : b0 25 __ BCS $2025 ; (faddsub + 74)
2000 : e0 e9 __ CPX #$e9
2002 : b0 0e __ BCS $2012 ; (faddsub + 55)
2004 : a5 08 __ LDA WORK + 5 
2006 : 85 07 __ STA WORK + 4 
2008 : a9 00 __ LDA #$00
200a : 85 1b __ STA ACCU + 0 
200c : 85 1c __ STA ACCU + 1 
200e : 85 1d __ STA ACCU + 2 
2010 : f0 23 __ BEQ $2035 ; (faddsub + 90)
2012 : a5 1d __ LDA ACCU + 2 
2014 : 4a __ __ LSR
2015 : 66 1c __ ROR ACCU + 1 
2017 : 66 1b __ ROR ACCU + 0 
2019 : e8 __ __ INX
201a : d0 f8 __ BNE $2014 ; (faddsub + 57)
201c : 85 1d __ STA ACCU + 2 
201e : a5 08 __ LDA WORK + 5 
2020 : 85 07 __ STA WORK + 4 
2022 : 4c 35 20 JMP $2035 ; (faddsub + 90)
2025 : e0 18 __ CPX #$18
2027 : b0 33 __ BCS $205c ; (faddsub + 129)
2029 : a5 05 __ LDA WORK + 2 
202b : 4a __ __ LSR
202c : 66 04 __ ROR WORK + 1 
202e : 66 03 __ ROR WORK + 0 
2030 : ca __ __ DEX
2031 : d0 f8 __ BNE $202b ; (faddsub + 80)
2033 : 85 05 __ STA WORK + 2 
2035 : a5 1e __ LDA ACCU + 3 
2037 : 29 80 __ AND #$80
2039 : 85 1e __ STA ACCU + 3 
203b : 45 06 __ EOR WORK + 3 
203d : 30 31 __ BMI $2070 ; (faddsub + 149)
203f : 18 __ __ CLC
2040 : a5 1b __ LDA ACCU + 0 
2042 : 65 03 __ ADC WORK + 0 
2044 : 85 1b __ STA ACCU + 0 
2046 : a5 1c __ LDA ACCU + 1 
2048 : 65 04 __ ADC WORK + 1 
204a : 85 1c __ STA ACCU + 1 
204c : a5 1d __ LDA ACCU + 2 
204e : 65 05 __ ADC WORK + 2 
2050 : 85 1d __ STA ACCU + 2 
2052 : 90 08 __ BCC $205c ; (faddsub + 129)
2054 : 66 1d __ ROR ACCU + 2 
2056 : 66 1c __ ROR ACCU + 1 
2058 : 66 1b __ ROR ACCU + 0 
205a : e6 07 __ INC WORK + 4 
205c : a5 07 __ LDA WORK + 4 
205e : c9 ff __ CMP #$ff
2060 : f0 83 __ BEQ $1fe5 ; (faddsub + 10)
2062 : 4a __ __ LSR
2063 : 05 1e __ ORA ACCU + 3 
2065 : 85 1e __ STA ACCU + 3 
2067 : b0 06 __ BCS $206f ; (faddsub + 148)
2069 : a5 1d __ LDA ACCU + 2 
206b : 29 7f __ AND #$7f
206d : 85 1d __ STA ACCU + 2 
206f : 60 __ __ RTS
2070 : 38 __ __ SEC
2071 : a5 1b __ LDA ACCU + 0 
2073 : e5 03 __ SBC WORK + 0 
2075 : 85 1b __ STA ACCU + 0 
2077 : a5 1c __ LDA ACCU + 1 
2079 : e5 04 __ SBC WORK + 1 
207b : 85 1c __ STA ACCU + 1 
207d : a5 1d __ LDA ACCU + 2 
207f : e5 05 __ SBC WORK + 2 
2081 : 85 1d __ STA ACCU + 2 
2083 : b0 19 __ BCS $209e ; (faddsub + 195)
2085 : 38 __ __ SEC
2086 : a9 00 __ LDA #$00
2088 : e5 1b __ SBC ACCU + 0 
208a : 85 1b __ STA ACCU + 0 
208c : a9 00 __ LDA #$00
208e : e5 1c __ SBC ACCU + 1 
2090 : 85 1c __ STA ACCU + 1 
2092 : a9 00 __ LDA #$00
2094 : e5 1d __ SBC ACCU + 2 
2096 : 85 1d __ STA ACCU + 2 
2098 : a5 1e __ LDA ACCU + 3 
209a : 49 80 __ EOR #$80
209c : 85 1e __ STA ACCU + 3 
209e : a5 1d __ LDA ACCU + 2 
20a0 : 30 ba __ BMI $205c ; (faddsub + 129)
20a2 : 05 1c __ ORA ACCU + 1 
20a4 : 05 1b __ ORA ACCU + 0 
20a6 : f0 0f __ BEQ $20b7 ; (faddsub + 220)
20a8 : c6 07 __ DEC WORK + 4 
20aa : f0 0b __ BEQ $20b7 ; (faddsub + 220)
20ac : 06 1b __ ASL ACCU + 0 
20ae : 26 1c __ ROL ACCU + 1 
20b0 : 26 1d __ ROL ACCU + 2 
20b2 : 10 f4 __ BPL $20a8 ; (faddsub + 205)
20b4 : 4c 5c 20 JMP $205c ; (faddsub + 129)
20b7 : a9 00 __ LDA #$00
20b9 : 85 1b __ STA ACCU + 0 
20bb : 85 1c __ STA ACCU + 1 
20bd : 85 1d __ STA ACCU + 2 
20bf : 85 1e __ STA ACCU + 3 
20c1 : 60 __ __ RTS
--------------------------------------------------------------------
fmul:
20c2 : a5 1b __ LDA ACCU + 0 
20c4 : 05 1c __ ORA ACCU + 1 
20c6 : 05 1d __ ORA ACCU + 2 
20c8 : d0 03 __ BNE $20cd ; (fmul + 11)
20ca : 85 1e __ STA ACCU + 3 
20cc : 60 __ __ RTS
20cd : a5 03 __ LDA WORK + 0 
20cf : 05 04 __ ORA WORK + 1 
20d1 : 05 05 __ ORA WORK + 2 
20d3 : d0 09 __ BNE $20de ; (fmul + 28)
20d5 : 85 1b __ STA ACCU + 0 
20d7 : 85 1c __ STA ACCU + 1 
20d9 : 85 1d __ STA ACCU + 2 
20db : 85 1e __ STA ACCU + 3 
20dd : 60 __ __ RTS
20de : a5 1e __ LDA ACCU + 3 
20e0 : 45 06 __ EOR WORK + 3 
20e2 : 29 80 __ AND #$80
20e4 : 85 1e __ STA ACCU + 3 
20e6 : a9 ff __ LDA #$ff
20e8 : c5 07 __ CMP WORK + 4 
20ea : f0 42 __ BEQ $212e ; (fmul + 108)
20ec : c5 08 __ CMP WORK + 5 
20ee : f0 3e __ BEQ $212e ; (fmul + 108)
20f0 : a9 00 __ LDA #$00
20f2 : 85 09 __ STA WORK + 6 
20f4 : 85 0a __ STA WORK + 7 
20f6 : 85 0b __ STA $0b 
20f8 : a4 1b __ LDY ACCU + 0 
20fa : a5 03 __ LDA WORK + 0 
20fc : d0 06 __ BNE $2104 ; (fmul + 66)
20fe : a5 04 __ LDA WORK + 1 
2100 : f0 0a __ BEQ $210c ; (fmul + 74)
2102 : d0 05 __ BNE $2109 ; (fmul + 71)
2104 : 20 63 21 JSR $2163 ; (fmul8 + 0)
2107 : a5 04 __ LDA WORK + 1 
2109 : 20 63 21 JSR $2163 ; (fmul8 + 0)
210c : a5 05 __ LDA WORK + 2 
210e : 20 63 21 JSR $2163 ; (fmul8 + 0)
2111 : 38 __ __ SEC
2112 : a5 0b __ LDA $0b 
2114 : 30 06 __ BMI $211c ; (fmul + 90)
2116 : 06 09 __ ASL WORK + 6 
2118 : 26 0a __ ROL WORK + 7 
211a : 2a __ __ ROL
211b : 18 __ __ CLC
211c : 29 7f __ AND #$7f
211e : 85 0b __ STA $0b 
2120 : a5 07 __ LDA WORK + 4 
2122 : 65 08 __ ADC WORK + 5 
2124 : 90 19 __ BCC $213f ; (fmul + 125)
2126 : e9 7f __ SBC #$7f
2128 : b0 04 __ BCS $212e ; (fmul + 108)
212a : c9 ff __ CMP #$ff
212c : d0 15 __ BNE $2143 ; (fmul + 129)
212e : a5 1e __ LDA ACCU + 3 
2130 : 09 7f __ ORA #$7f
2132 : 85 1e __ STA ACCU + 3 
2134 : a9 80 __ LDA #$80
2136 : 85 1d __ STA ACCU + 2 
2138 : a9 00 __ LDA #$00
213a : 85 1b __ STA ACCU + 0 
213c : 85 1c __ STA ACCU + 1 
213e : 60 __ __ RTS
213f : e9 7e __ SBC #$7e
2141 : 90 15 __ BCC $2158 ; (fmul + 150)
2143 : 4a __ __ LSR
2144 : 05 1e __ ORA ACCU + 3 
2146 : 85 1e __ STA ACCU + 3 
2148 : a9 00 __ LDA #$00
214a : 6a __ __ ROR
214b : 05 0b __ ORA $0b 
214d : 85 1d __ STA ACCU + 2 
214f : a5 0a __ LDA WORK + 7 
2151 : 85 1c __ STA ACCU + 1 
2153 : a5 09 __ LDA WORK + 6 
2155 : 85 1b __ STA ACCU + 0 
2157 : 60 __ __ RTS
2158 : a9 00 __ LDA #$00
215a : 85 1b __ STA ACCU + 0 
215c : 85 1c __ STA ACCU + 1 
215e : 85 1d __ STA ACCU + 2 
2160 : 85 1e __ STA ACCU + 3 
2162 : 60 __ __ RTS
--------------------------------------------------------------------
fmul8:
2163 : 38 __ __ SEC
2164 : 6a __ __ ROR
2165 : 90 1e __ BCC $2185 ; (fmul8 + 34)
2167 : aa __ __ TAX
2168 : 18 __ __ CLC
2169 : 98 __ __ TYA
216a : 65 09 __ ADC WORK + 6 
216c : 85 09 __ STA WORK + 6 
216e : a5 0a __ LDA WORK + 7 
2170 : 65 1c __ ADC ACCU + 1 
2172 : 85 0a __ STA WORK + 7 
2174 : a5 0b __ LDA $0b 
2176 : 65 1d __ ADC ACCU + 2 
2178 : 6a __ __ ROR
2179 : 85 0b __ STA $0b 
217b : 8a __ __ TXA
217c : 66 0a __ ROR WORK + 7 
217e : 66 09 __ ROR WORK + 6 
2180 : 4a __ __ LSR
2181 : f0 0d __ BEQ $2190 ; (fmul8 + 45)
2183 : b0 e2 __ BCS $2167 ; (fmul8 + 4)
2185 : 66 0b __ ROR $0b 
2187 : 66 0a __ ROR WORK + 7 
2189 : 66 09 __ ROR WORK + 6 
218b : 4a __ __ LSR
218c : 90 f7 __ BCC $2185 ; (fmul8 + 34)
218e : d0 d7 __ BNE $2167 ; (fmul8 + 4)
2190 : 60 __ __ RTS
--------------------------------------------------------------------
fdiv:
2191 : a5 1b __ LDA ACCU + 0 
2193 : 05 1c __ ORA ACCU + 1 
2195 : 05 1d __ ORA ACCU + 2 
2197 : d0 03 __ BNE $219c ; (fdiv + 11)
2199 : 85 1e __ STA ACCU + 3 
219b : 60 __ __ RTS
219c : a5 1e __ LDA ACCU + 3 
219e : 45 06 __ EOR WORK + 3 
21a0 : 29 80 __ AND #$80
21a2 : 85 1e __ STA ACCU + 3 
21a4 : a5 08 __ LDA WORK + 5 
21a6 : f0 62 __ BEQ $220a ; (fdiv + 121)
21a8 : a5 07 __ LDA WORK + 4 
21aa : c9 ff __ CMP #$ff
21ac : f0 5c __ BEQ $220a ; (fdiv + 121)
21ae : a9 00 __ LDA #$00
21b0 : 85 09 __ STA WORK + 6 
21b2 : 85 0a __ STA WORK + 7 
21b4 : 85 0b __ STA $0b 
21b6 : a2 18 __ LDX #$18
21b8 : a5 1b __ LDA ACCU + 0 
21ba : c5 03 __ CMP WORK + 0 
21bc : a5 1c __ LDA ACCU + 1 
21be : e5 04 __ SBC WORK + 1 
21c0 : a5 1d __ LDA ACCU + 2 
21c2 : e5 05 __ SBC WORK + 2 
21c4 : 90 13 __ BCC $21d9 ; (fdiv + 72)
21c6 : a5 1b __ LDA ACCU + 0 
21c8 : e5 03 __ SBC WORK + 0 
21ca : 85 1b __ STA ACCU + 0 
21cc : a5 1c __ LDA ACCU + 1 
21ce : e5 04 __ SBC WORK + 1 
21d0 : 85 1c __ STA ACCU + 1 
21d2 : a5 1d __ LDA ACCU + 2 
21d4 : e5 05 __ SBC WORK + 2 
21d6 : 85 1d __ STA ACCU + 2 
21d8 : 38 __ __ SEC
21d9 : 26 09 __ ROL WORK + 6 
21db : 26 0a __ ROL WORK + 7 
21dd : 26 0b __ ROL $0b 
21df : ca __ __ DEX
21e0 : f0 0a __ BEQ $21ec ; (fdiv + 91)
21e2 : 06 1b __ ASL ACCU + 0 
21e4 : 26 1c __ ROL ACCU + 1 
21e6 : 26 1d __ ROL ACCU + 2 
21e8 : b0 dc __ BCS $21c6 ; (fdiv + 53)
21ea : 90 cc __ BCC $21b8 ; (fdiv + 39)
21ec : 38 __ __ SEC
21ed : a5 0b __ LDA $0b 
21ef : 30 06 __ BMI $21f7 ; (fdiv + 102)
21f1 : 06 09 __ ASL WORK + 6 
21f3 : 26 0a __ ROL WORK + 7 
21f5 : 2a __ __ ROL
21f6 : 18 __ __ CLC
21f7 : 29 7f __ AND #$7f
21f9 : 85 0b __ STA $0b 
21fb : a5 07 __ LDA WORK + 4 
21fd : e5 08 __ SBC WORK + 5 
21ff : 90 1a __ BCC $221b ; (fdiv + 138)
2201 : 18 __ __ CLC
2202 : 69 7f __ ADC #$7f
2204 : b0 04 __ BCS $220a ; (fdiv + 121)
2206 : c9 ff __ CMP #$ff
2208 : d0 15 __ BNE $221f ; (fdiv + 142)
220a : a5 1e __ LDA ACCU + 3 
220c : 09 7f __ ORA #$7f
220e : 85 1e __ STA ACCU + 3 
2210 : a9 80 __ LDA #$80
2212 : 85 1d __ STA ACCU + 2 
2214 : a9 00 __ LDA #$00
2216 : 85 1c __ STA ACCU + 1 
2218 : 85 1b __ STA ACCU + 0 
221a : 60 __ __ RTS
221b : 69 7f __ ADC #$7f
221d : 90 15 __ BCC $2234 ; (fdiv + 163)
221f : 4a __ __ LSR
2220 : 05 1e __ ORA ACCU + 3 
2222 : 85 1e __ STA ACCU + 3 
2224 : a9 00 __ LDA #$00
2226 : 6a __ __ ROR
2227 : 05 0b __ ORA $0b 
2229 : 85 1d __ STA ACCU + 2 
222b : a5 0a __ LDA WORK + 7 
222d : 85 1c __ STA ACCU + 1 
222f : a5 09 __ LDA WORK + 6 
2231 : 85 1b __ STA ACCU + 0 
2233 : 60 __ __ RTS
2234 : a9 00 __ LDA #$00
2236 : 85 1e __ STA ACCU + 3 
2238 : 85 1d __ STA ACCU + 2 
223a : 85 1c __ STA ACCU + 1 
223c : 85 1b __ STA ACCU + 0 
223e : 60 __ __ RTS
--------------------------------------------------------------------
divs16:
223f : 24 1c __ BIT ACCU + 1 
2241 : 10 0d __ BPL $2250 ; (divs16 + 17)
2243 : 20 5d 22 JSR $225d ; (negaccu + 0)
2246 : 24 04 __ BIT WORK + 1 
2248 : 10 0d __ BPL $2257 ; (divs16 + 24)
224a : 20 6b 22 JSR $226b ; (negtmp + 0)
224d : 4c 79 22 JMP $2279 ; (divmod + 0)
2250 : 24 04 __ BIT WORK + 1 
2252 : 10 f9 __ BPL $224d ; (divs16 + 14)
2254 : 20 6b 22 JSR $226b ; (negtmp + 0)
2257 : 20 79 22 JSR $2279 ; (divmod + 0)
225a : 4c 5d 22 JMP $225d ; (negaccu + 0)
--------------------------------------------------------------------
negaccu:
225d : 38 __ __ SEC
225e : a9 00 __ LDA #$00
2260 : e5 1b __ SBC ACCU + 0 
2262 : 85 1b __ STA ACCU + 0 
2264 : a9 00 __ LDA #$00
2266 : e5 1c __ SBC ACCU + 1 
2268 : 85 1c __ STA ACCU + 1 
226a : 60 __ __ RTS
--------------------------------------------------------------------
negtmp:
226b : 38 __ __ SEC
226c : a9 00 __ LDA #$00
226e : e5 03 __ SBC WORK + 0 
2270 : 85 03 __ STA WORK + 0 
2272 : a9 00 __ LDA #$00
2274 : e5 04 __ SBC WORK + 1 
2276 : 85 04 __ STA WORK + 1 
2278 : 60 __ __ RTS
--------------------------------------------------------------------
divmod:
2279 : a5 1c __ LDA ACCU + 1 
227b : d0 31 __ BNE $22ae ; (divmod + 53)
227d : a5 04 __ LDA WORK + 1 
227f : d0 1e __ BNE $229f ; (divmod + 38)
2281 : 85 06 __ STA WORK + 3 
2283 : a2 04 __ LDX #$04
2285 : 06 1b __ ASL ACCU + 0 
2287 : 2a __ __ ROL
2288 : c5 03 __ CMP WORK + 0 
228a : 90 02 __ BCC $228e ; (divmod + 21)
228c : e5 03 __ SBC WORK + 0 
228e : 26 1b __ ROL ACCU + 0 
2290 : 2a __ __ ROL
2291 : c5 03 __ CMP WORK + 0 
2293 : 90 02 __ BCC $2297 ; (divmod + 30)
2295 : e5 03 __ SBC WORK + 0 
2297 : 26 1b __ ROL ACCU + 0 
2299 : ca __ __ DEX
229a : d0 eb __ BNE $2287 ; (divmod + 14)
229c : 85 05 __ STA WORK + 2 
229e : 60 __ __ RTS
229f : a5 1b __ LDA ACCU + 0 
22a1 : 85 05 __ STA WORK + 2 
22a3 : a5 1c __ LDA ACCU + 1 
22a5 : 85 06 __ STA WORK + 3 
22a7 : a9 00 __ LDA #$00
22a9 : 85 1b __ STA ACCU + 0 
22ab : 85 1c __ STA ACCU + 1 
22ad : 60 __ __ RTS
22ae : a5 04 __ LDA WORK + 1 
22b0 : d0 1f __ BNE $22d1 ; (divmod + 88)
22b2 : a5 03 __ LDA WORK + 0 
22b4 : 30 1b __ BMI $22d1 ; (divmod + 88)
22b6 : a9 00 __ LDA #$00
22b8 : 85 06 __ STA WORK + 3 
22ba : a2 10 __ LDX #$10
22bc : 06 1b __ ASL ACCU + 0 
22be : 26 1c __ ROL ACCU + 1 
22c0 : 2a __ __ ROL
22c1 : c5 03 __ CMP WORK + 0 
22c3 : 90 02 __ BCC $22c7 ; (divmod + 78)
22c5 : e5 03 __ SBC WORK + 0 
22c7 : 26 1b __ ROL ACCU + 0 
22c9 : 26 1c __ ROL ACCU + 1 
22cb : ca __ __ DEX
22cc : d0 f2 __ BNE $22c0 ; (divmod + 71)
22ce : 85 05 __ STA WORK + 2 
22d0 : 60 __ __ RTS
22d1 : a9 00 __ LDA #$00
22d3 : 85 05 __ STA WORK + 2 
22d5 : 85 06 __ STA WORK + 3 
22d7 : 84 02 __ STY $02 
22d9 : a0 10 __ LDY #$10
22db : 18 __ __ CLC
22dc : 26 1b __ ROL ACCU + 0 
22de : 26 1c __ ROL ACCU + 1 
22e0 : 26 05 __ ROL WORK + 2 
22e2 : 26 06 __ ROL WORK + 3 
22e4 : 38 __ __ SEC
22e5 : a5 05 __ LDA WORK + 2 
22e7 : e5 03 __ SBC WORK + 0 
22e9 : aa __ __ TAX
22ea : a5 06 __ LDA WORK + 3 
22ec : e5 04 __ SBC WORK + 1 
22ee : 90 04 __ BCC $22f4 ; (divmod + 123)
22f0 : 86 05 __ STX WORK + 2 
22f2 : 85 06 __ STA WORK + 3 
22f4 : 88 __ __ DEY
22f5 : d0 e5 __ BNE $22dc ; (divmod + 99)
22f7 : 26 1b __ ROL ACCU + 0 
22f9 : 26 1c __ ROL ACCU + 1 
22fb : a4 02 __ LDY $02 
22fd : 60 __ __ RTS
--------------------------------------------------------------------
mods16:
22fe : 24 1c __ BIT ACCU + 1 
2300 : 10 0d __ BPL $230f ; (mods16 + 17)
2302 : 20 5d 22 JSR $225d ; (negaccu + 0)
2305 : 24 04 __ BIT WORK + 1 
2307 : 10 0d __ BPL $2316 ; (mods16 + 24)
2309 : 20 6b 22 JSR $226b ; (negtmp + 0)
230c : 4c 79 22 JMP $2279 ; (divmod + 0)
230f : 24 04 __ BIT WORK + 1 
2311 : 10 f9 __ BPL $230c ; (mods16 + 14)
2313 : 20 6b 22 JSR $226b ; (negtmp + 0)
2316 : 20 79 22 JSR $2279 ; (divmod + 0)
2319 : 38 __ __ SEC
231a : a9 00 __ LDA #$00
231c : e5 05 __ SBC WORK + 2 
231e : 85 05 __ STA WORK + 2 
2320 : a9 00 __ LDA #$00
2322 : e5 06 __ SBC WORK + 3 
2324 : 85 06 __ STA WORK + 3 
2326 : 60 __ __ RTS
--------------------------------------------------------------------
f32_to_i16:
2327 : 20 ba 1f JSR $1fba ; (freg + 36)
232a : a5 07 __ LDA WORK + 4 
232c : c9 7f __ CMP #$7f
232e : b0 07 __ BCS $2337 ; (f32_to_i16 + 16)
2330 : a9 00 __ LDA #$00
2332 : 85 1b __ STA ACCU + 0 
2334 : 85 1c __ STA ACCU + 1 
2336 : 60 __ __ RTS
2337 : 38 __ __ SEC
2338 : e9 8e __ SBC #$8e
233a : 90 0a __ BCC $2346 ; (f32_to_i16 + 31)
233c : a9 ff __ LDA #$ff
233e : 85 1b __ STA ACCU + 0 
2340 : a9 7f __ LDA #$7f
2342 : 85 1c __ STA ACCU + 1 
2344 : d0 08 __ BNE $234e ; (f32_to_i16 + 39)
2346 : aa __ __ TAX
2347 : 46 1d __ LSR ACCU + 2 
2349 : 66 1c __ ROR ACCU + 1 
234b : e8 __ __ INX
234c : d0 f9 __ BNE $2347 ; (f32_to_i16 + 32)
234e : 24 1e __ BIT ACCU + 3 
2350 : 10 0e __ BPL $2360 ; (f32_to_i16 + 57)
2352 : 38 __ __ SEC
2353 : a9 00 __ LDA #$00
2355 : e5 1c __ SBC ACCU + 1 
2357 : 85 1b __ STA ACCU + 0 
2359 : a9 00 __ LDA #$00
235b : e5 1d __ SBC ACCU + 2 
235d : 85 1c __ STA ACCU + 1 
235f : 60 __ __ RTS
2360 : a5 1c __ LDA ACCU + 1 
2362 : 85 1b __ STA ACCU + 0 
2364 : a5 1d __ LDA ACCU + 2 
2366 : 85 1c __ STA ACCU + 1 
2368 : 60 __ __ RTS
--------------------------------------------------------------------
sint16_to_float:
2369 : 24 1c __ BIT ACCU + 1 
236b : 30 03 __ BMI $2370 ; (sint16_to_float + 7)
236d : 4c 87 23 JMP $2387 ; (uint16_to_float + 0)
2370 : 38 __ __ SEC
2371 : a9 00 __ LDA #$00
2373 : e5 1b __ SBC ACCU + 0 
2375 : 85 1b __ STA ACCU + 0 
2377 : a9 00 __ LDA #$00
2379 : e5 1c __ SBC ACCU + 1 
237b : 85 1c __ STA ACCU + 1 
237d : 20 87 23 JSR $2387 ; (uint16_to_float + 0)
2380 : a5 1e __ LDA ACCU + 3 
2382 : 09 80 __ ORA #$80
2384 : 85 1e __ STA ACCU + 3 
2386 : 60 __ __ RTS
--------------------------------------------------------------------
uint16_to_float:
2387 : a5 1b __ LDA ACCU + 0 
2389 : 05 1c __ ORA ACCU + 1 
238b : d0 05 __ BNE $2392 ; (uint16_to_float + 11)
238d : 85 1d __ STA ACCU + 2 
238f : 85 1e __ STA ACCU + 3 
2391 : 60 __ __ RTS
2392 : a2 8e __ LDX #$8e
2394 : a5 1c __ LDA ACCU + 1 
2396 : 30 06 __ BMI $239e ; (uint16_to_float + 23)
2398 : ca __ __ DEX
2399 : 06 1b __ ASL ACCU + 0 
239b : 2a __ __ ROL
239c : 10 fa __ BPL $2398 ; (uint16_to_float + 17)
239e : 29 7f __ AND #$7f
23a0 : 85 1d __ STA ACCU + 2 
23a2 : a5 1b __ LDA ACCU + 0 
23a4 : 85 1c __ STA ACCU + 1 
23a6 : 8a __ __ TXA
23a7 : 4a __ __ LSR
23a8 : 85 1e __ STA ACCU + 3 
23aa : a9 00 __ LDA #$00
23ac : 85 1b __ STA ACCU + 0 
23ae : 6a __ __ ROR
23af : 05 1d __ ORA ACCU + 2 
23b1 : 85 1d __ STA ACCU + 2 
23b3 : 60 __ __ RTS
--------------------------------------------------------------------
divmod32:
23b4 : 84 02 __ STY $02 
23b6 : a0 20 __ LDY #$20
23b8 : a9 00 __ LDA #$00
23ba : 85 07 __ STA WORK + 4 
23bc : 85 08 __ STA WORK + 5 
23be : 85 09 __ STA WORK + 6 
23c0 : 85 0a __ STA WORK + 7 
23c2 : a5 05 __ LDA WORK + 2 
23c4 : 05 06 __ ORA WORK + 3 
23c6 : d0 39 __ BNE $2401 ; (divmod32 + 77)
23c8 : 18 __ __ CLC
23c9 : 26 1b __ ROL ACCU + 0 
23cb : 26 1c __ ROL ACCU + 1 
23cd : 26 1d __ ROL ACCU + 2 
23cf : 26 1e __ ROL ACCU + 3 
23d1 : 26 07 __ ROL WORK + 4 
23d3 : 26 08 __ ROL WORK + 5 
23d5 : 90 0c __ BCC $23e3 ; (divmod32 + 47)
23d7 : a5 07 __ LDA WORK + 4 
23d9 : e5 03 __ SBC WORK + 0 
23db : aa __ __ TAX
23dc : a5 08 __ LDA WORK + 5 
23de : e5 04 __ SBC WORK + 1 
23e0 : 38 __ __ SEC
23e1 : b0 0c __ BCS $23ef ; (divmod32 + 59)
23e3 : 38 __ __ SEC
23e4 : a5 07 __ LDA WORK + 4 
23e6 : e5 03 __ SBC WORK + 0 
23e8 : aa __ __ TAX
23e9 : a5 08 __ LDA WORK + 5 
23eb : e5 04 __ SBC WORK + 1 
23ed : 90 04 __ BCC $23f3 ; (divmod32 + 63)
23ef : 86 07 __ STX WORK + 4 
23f1 : 85 08 __ STA WORK + 5 
23f3 : 88 __ __ DEY
23f4 : d0 d3 __ BNE $23c9 ; (divmod32 + 21)
23f6 : 26 1b __ ROL ACCU + 0 
23f8 : 26 1c __ ROL ACCU + 1 
23fa : 26 1d __ ROL ACCU + 2 
23fc : 26 1e __ ROL ACCU + 3 
23fe : a4 02 __ LDY $02 
2400 : 60 __ __ RTS
2401 : 18 __ __ CLC
2402 : 26 1b __ ROL ACCU + 0 
2404 : 26 1c __ ROL ACCU + 1 
2406 : 26 1d __ ROL ACCU + 2 
2408 : 26 1e __ ROL ACCU + 3 
240a : 26 07 __ ROL WORK + 4 
240c : 26 08 __ ROL WORK + 5 
240e : 26 09 __ ROL WORK + 6 
2410 : 26 0a __ ROL WORK + 7 
2412 : a5 07 __ LDA WORK + 4 
2414 : c5 03 __ CMP WORK + 0 
2416 : a5 08 __ LDA WORK + 5 
2418 : e5 04 __ SBC WORK + 1 
241a : a5 09 __ LDA WORK + 6 
241c : e5 05 __ SBC WORK + 2 
241e : a5 0a __ LDA WORK + 7 
2420 : e5 06 __ SBC WORK + 3 
2422 : 90 18 __ BCC $243c ; (divmod32 + 136)
2424 : a5 07 __ LDA WORK + 4 
2426 : e5 03 __ SBC WORK + 0 
2428 : 85 07 __ STA WORK + 4 
242a : a5 08 __ LDA WORK + 5 
242c : e5 04 __ SBC WORK + 1 
242e : 85 08 __ STA WORK + 5 
2430 : a5 09 __ LDA WORK + 6 
2432 : e5 05 __ SBC WORK + 2 
2434 : 85 09 __ STA WORK + 6 
2436 : a5 0a __ LDA WORK + 7 
2438 : e5 06 __ SBC WORK + 3 
243a : 85 0a __ STA WORK + 7 
243c : 88 __ __ DEY
243d : d0 c3 __ BNE $2402 ; (divmod32 + 78)
243f : 26 1b __ ROL ACCU + 0 
2441 : 26 1c __ ROL ACCU + 1 
2443 : 26 1d __ ROL ACCU + 2 
2445 : 26 1e __ ROL ACCU + 3 
2447 : a4 02 __ LDY $02 
2449 : 60 __ __ RTS
--------------------------------------------------------------------
__multab3L:
244a : __ __ __ BYT 00 03 06                                        : ...
