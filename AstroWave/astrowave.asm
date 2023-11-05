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
080e : 8e 28 24 STX $2428 ; (spentry + 0)
0811 : a9 ba __ LDA #$ba
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
0830 : a9 15 __ LDA #$15
0832 : e9 ba __ SBC #$ba
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
2428 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
main:
.s1000:
0880 : a5 53 __ LDA T0 + 0 
0882 : 8d cd 9f STA $9fcd ; (main@stack + 0)
.s0:
0885 : 20 fd 08 JSR $08fd ; (redefine_charset.s0 + 0)
0888 : 20 0d 0a JSR $0a0d ; (init_player.s0 + 0)
088b : 20 18 0a JSR $0a18 ; (init_enemies.s0 + 0)
088e : 20 30 0a JSR $0a30 ; (init_shots.s0 + 0)
0891 : 20 57 0a JSR $0a57 ; (init_game_state.s0 + 0)
0894 : 20 69 0a JSR $0a69 ; (prepare_game_screen.s0 + 0)
0897 : ad 00 25 LDA $2500 ; (game + 0)
089a : d0 55 __ BNE $08f1 ; (main.s4 + 0)
.s9:
089c : 85 53 __ STA T0 + 0 
.l3:
089e : 20 3c 0b JSR $0b3c ; (render_game_state.s1000 + 0)
08a1 : a5 53 __ LDA T0 + 0 
08a3 : 85 1b __ STA ACCU + 0 
08a5 : a9 00 __ LDA #$00
08a7 : 85 1c __ STA ACCU + 1 
08a9 : 85 04 __ STA WORK + 1 
08ab : a9 03 __ LDA #$03
08ad : 85 03 __ STA WORK + 0 
08af : 20 4a 22 JSR $224a ; (divmod + 0)
08b2 : a5 05 __ LDA WORK + 2 
08b4 : 05 06 __ ORA WORK + 3 
08b6 : d0 0c __ BNE $08c4 ; (main.s7 + 0)
.s5:
08b8 : 20 e4 18 JSR $18e4 ; (spawn_enemy.s0 + 0)
08bb : 20 7b 19 JSR $197b ; (move_enemies.s0 + 0)
08be : 20 f3 1a JSR $1af3 ; (render_enemies.s0 + 0)
08c1 : 20 50 1b JSR $1b50 ; (check_shot_enemy_collision.s0 + 0)
.s7:
08c4 : 20 71 1c JSR $1c71 ; (move_enemy_shots.s0 + 0)
08c7 : 20 9e 1a JSR $1a9e ; (render_enemy_shots.s0 + 0)
08ca : 20 db 1c JSR $1cdb ; (check_player_enemy_collision.s0 + 0)
08cd : 20 2b 1d JSR $1d2b ; (control_player_ship.s0 + 0)
08d0 : 20 49 1e JSR $1e49 ; (render_player_ship.s0 + 0)
08d3 : 20 db 1c JSR $1cdb ; (check_player_enemy_collision.s0 + 0)
08d6 : 20 89 1e JSR $1e89 ; (move_player_shots.s0 + 0)
08d9 : 20 f1 1e JSR $1ef1 ; (render_player_shots.s0 + 0)
08dc : 20 50 1b JSR $1b50 ; (check_shot_enemy_collision.s0 + 0)
08df : a9 03 __ LDA #$03
08e1 : 85 0d __ STA P0 
08e3 : a9 00 __ LDA #$00
08e5 : 85 0e __ STA P1 
08e7 : 20 46 1f JSR $1f46 ; (wait_frames.s0 + 0)
08ea : e6 53 __ INC T0 + 0 
08ec : ad 00 25 LDA $2500 ; (game + 0)
08ef : f0 ad __ BEQ $089e ; (main.l3 + 0)
.s4:
08f1 : a9 00 __ LDA #$00
08f3 : 85 1b __ STA ACCU + 0 
08f5 : 85 1c __ STA ACCU + 1 
.s1001:
08f7 : ad cd 9f LDA $9fcd ; (main@stack + 0)
08fa : 85 53 __ STA T0 + 0 
08fc : 60 __ __ RTS
--------------------------------------------------------------------
redefine_charset:
.s0:
08fd : 20 3d 09 JSR $093d ; (mmap_trampoline.s0 + 0)
0900 : a9 31 __ LDA #$31
0902 : 85 01 __ STA $01 
0904 : a9 00 __ LDA #$00
0906 : 85 11 __ STA P4 
0908 : 85 0d __ STA P0 
090a : 85 0f __ STA P2 
090c : a9 08 __ LDA #$08
090e : 85 12 __ STA P5 
0910 : a9 c8 __ LDA #$c8
0912 : 85 0e __ STA P1 
0914 : a9 d0 __ LDA #$d0
0916 : 85 10 __ STA P3 
0918 : 20 87 09 JSR $0987 ; (memcpy.s0 + 0)
091b : a2 38 __ LDX #$38
.l1002:
091d : bd 28 24 LDA $2428,x ; (spentry + 0)
0920 : 9d ff cb STA $cbff,x 
0923 : ca __ __ DEX
0924 : d0 f7 __ BNE $091d ; (redefine_charset.l1002 + 0)
.s1003:
0926 : a9 37 __ LDA #$37
0928 : 85 01 __ STA $01 
092a : a9 00 __ LDA #$00
092c : 85 0d __ STA P0 
092e : 85 0e __ STA P1 
0930 : 85 10 __ STA P3 
0932 : a9 c8 __ LDA #$c8
0934 : 85 11 __ STA P4 
0936 : a9 c0 __ LDA #$c0
0938 : 85 0f __ STA P2 
093a : 4c b6 09 JMP $09b6 ; (vic_setmode.s0 + 0)
--------------------------------------------------------------------
mmap_trampoline:
.s0:
093d : a9 52 __ LDA #$52
093f : 8d fa ff STA $fffa 
0942 : a9 09 __ LDA #$09
0944 : 8d fb ff STA $fffb 
0947 : a9 70 __ LDA #$70
0949 : 8d fe ff STA $fffe 
094c : a9 09 __ LDA #$09
094e : 8d ff ff STA $ffff 
.s1001:
0951 : 60 __ __ RTS
--------------------------------------------------------------------
NMITrampoline:
0952 : 48 __ __ PHA
0953 : 8a __ __ TXA
0954 : 48 __ __ PHA
0955 : a9 09 __ LDA #$09
0957 : 48 __ __ PHA
0958 : a9 69 __ LDA #$69
095a : 48 __ __ PHA
095b : ba __ __ TSX
095c : bd 05 01 LDA $0105,x 
095f : 48 __ __ PHA
0960 : a6 01 __ LDX $01 
0962 : a9 36 __ LDA #$36
0964 : 85 01 __ STA $01 
0966 : 6c fa ff JMP ($fffa)
--------------------------------------------------------------------
DoneTrampoline:
0969 : 86 01 __ STX $01 
096b : 68 __ __ PLA
096c : aa __ __ TAX
096d : 68 __ __ PLA
096e : 40 __ __ RTI
096f : 60 __ __ RTS
--------------------------------------------------------------------
IRQTrampoline:
0970 : 48 __ __ PHA
0971 : 8a __ __ TXA
0972 : 48 __ __ PHA
0973 : a9 09 __ LDA #$09
0975 : 48 __ __ PHA
0976 : a9 69 __ LDA #$69
0978 : 48 __ __ PHA
0979 : ba __ __ TSX
097a : bd 05 01 LDA $0105,x 
097d : 48 __ __ PHA
097e : a6 01 __ LDX $01 
0980 : a9 36 __ LDA #$36
0982 : 85 01 __ STA $01 
0984 : 6c fe ff JMP ($fffe)
--------------------------------------------------------------------
memcpy:
.s0:
0987 : a6 12 __ LDX P5 
0989 : f0 10 __ BEQ $099b ; (memcpy.s0 + 20)
098b : a0 00 __ LDY #$00
098d : b1 0f __ LDA (P2),y 
098f : 91 0d __ STA (P0),y ; (dst + 0)
0991 : c8 __ __ INY
0992 : d0 f9 __ BNE $098d ; (memcpy.s0 + 6)
0994 : e6 10 __ INC P3 
0996 : e6 0e __ INC P1 ; (dst + 1)
0998 : ca __ __ DEX
0999 : d0 f2 __ BNE $098d ; (memcpy.s0 + 6)
099b : a4 11 __ LDY P4 
099d : f0 0e __ BEQ $09ad ; (memcpy.s0 + 38)
099f : 88 __ __ DEY
09a0 : f0 07 __ BEQ $09a9 ; (memcpy.s0 + 34)
09a2 : b1 0f __ LDA (P2),y 
09a4 : 91 0d __ STA (P0),y ; (dst + 0)
09a6 : 88 __ __ DEY
09a7 : d0 f9 __ BNE $09a2 ; (memcpy.s0 + 27)
09a9 : b1 0f __ LDA (P2),y 
09ab : 91 0d __ STA (P0),y ; (dst + 0)
09ad : a5 0d __ LDA P0 ; (dst + 0)
09af : 85 1b __ STA ACCU + 0 
09b1 : a5 0e __ LDA P1 ; (dst + 1)
09b3 : 85 1c __ STA ACCU + 1 
.s1001:
09b5 : 60 __ __ RTS
--------------------------------------------------------------------
ChrRedef:
2429 : __ __ __ BYT 80 e0 f8 7f 7f f8 e0 80 00 00 60 3e 3e 60 00 00 : ..........`>>`..
2439 : __ __ __ BYT 00 00 3c 66 66 3c 00 00 1c 7f c6 1f 1f c6 7f 1c : ..<ff<..........
2449 : __ __ __ BYT 00 3c 7e d5 ab 7e 3c 00 28 3c 6e df 5f fe 3c 14 : .<~..~<.(<n._.<.
2459 : __ __ __ BYT 28 56 65 92 69 36 44 2a                         : (Ve.i6D*
--------------------------------------------------------------------
vic_setmode:
.s0:
09b6 : a6 0f __ LDX P2 ; (text + 1)
09b8 : a4 0d __ LDY P0 ; (mode + 0)
09ba : c0 02 __ CPY #$02
09bc : d0 07 __ BNE $09c5 ; (vic_setmode.s15 + 0)
.s6:
09be : a9 5b __ LDA #$5b
09c0 : 8d 11 d0 STA $d011 
09c3 : d0 0d __ BNE $09d2 ; (vic_setmode.s23 + 0)
.s15:
09c5 : c0 02 __ CPY #$02
09c7 : 90 39 __ BCC $0a02 ; (vic_setmode.s17 + 0)
.s16:
09c9 : a9 3b __ LDA #$3b
09cb : 8d 11 d0 STA $d011 
09ce : c0 03 __ CPY #$03
09d0 : d0 04 __ BNE $09d6 ; (vic_setmode.s1009 + 0)
.s23:
09d2 : a9 08 __ LDA #$08
09d4 : d0 02 __ BNE $09d8 ; (vic_setmode.s1 + 0)
.s1009:
09d6 : a9 18 __ LDA #$18
.s1:
09d8 : 8d 16 d0 STA $d016 
09db : ad 00 dd LDA $dd00 
09de : 29 fc __ AND #$fc
09e0 : 85 1b __ STA ACCU + 0 
09e2 : 8a __ __ TXA
09e3 : 0a __ __ ASL
09e4 : 2a __ __ ROL
09e5 : 29 01 __ AND #$01
09e7 : 2a __ __ ROL
09e8 : 49 03 __ EOR #$03
09ea : 05 1b __ ORA ACCU + 0 
09ec : 8d 00 dd STA $dd00 
09ef : 8a __ __ TXA
09f0 : 0a __ __ ASL
09f1 : 0a __ __ ASL
09f2 : 29 f0 __ AND #$f0
09f4 : 85 1b __ STA ACCU + 0 
09f6 : a5 11 __ LDA P4 ; (font + 1)
09f8 : 4a __ __ LSR
09f9 : 4a __ __ LSR
09fa : 29 0e __ AND #$0e
09fc : 05 1b __ ORA ACCU + 0 
09fe : 8d 18 d0 STA $d018 
.s1001:
0a01 : 60 __ __ RTS
.s17:
0a02 : a9 1b __ LDA #$1b
0a04 : 8d 11 d0 STA $d011 
0a07 : 98 __ __ TYA
0a08 : d0 cc __ BNE $09d6 ; (vic_setmode.s1009 + 0)
0a0a : 4c d2 09 JMP $09d2 ; (vic_setmode.s23 + 0)
--------------------------------------------------------------------
init_player:
.s0:
0a0d : a9 05 __ LDA #$05
0a0f : 8d ba 24 STA $24ba ; (Player + 0)
0a12 : a9 0c __ LDA #$0c
0a14 : 8d bb 24 STA $24bb ; (Player + 1)
.s1001:
0a17 : 60 __ __ RTS
--------------------------------------------------------------------
Player:
24ba : __ __ __ BSS	2
--------------------------------------------------------------------
init_enemies:
.s0:
0a18 : a2 00 __ LDX #$00
0a1a : a0 0a __ LDY #$0a
.l1002:
0a1c : a9 00 __ LDA #$00
0a1e : 9d bc 24 STA $24bc,x ; (Enemy + 0)
0a21 : 9d bd 24 STA $24bd,x ; (Enemy + 1)
0a24 : 9d c0 24 STA $24c0,x ; (Enemy + 4)
0a27 : 8a __ __ TXA
0a28 : 18 __ __ CLC
0a29 : 69 05 __ ADC #$05
0a2b : aa __ __ TAX
0a2c : 88 __ __ DEY
0a2d : d0 ed __ BNE $0a1c ; (init_enemies.l1002 + 0)
.s1001:
0a2f : 60 __ __ RTS
--------------------------------------------------------------------
Enemy:
24bc : __ __ __ BSS	50
--------------------------------------------------------------------
init_shots:
.s0:
0a30 : a2 00 __ LDX #$00
0a32 : a0 03 __ LDY #$03
0a34 : 8a __ __ TXA
.l1006:
0a35 : 9d ee 24 STA $24ee,x ; (PlayerShot + 0)
0a38 : 9d ef 24 STA $24ef,x ; (PlayerShot + 1)
0a3b : 9d f0 24 STA $24f0,x ; (PlayerShot + 2)
0a3e : e8 __ __ INX
0a3f : e8 __ __ INX
0a40 : e8 __ __ INX
0a41 : 88 __ __ DEY
0a42 : d0 f1 __ BNE $0a35 ; (init_shots.l1006 + 0)
.s6:
0a44 : a0 03 __ LDY #$03
0a46 : aa __ __ TAX
.l1008:
0a47 : 9d f7 24 STA $24f7,x ; (EnemyShot + 0)
0a4a : 9d f8 24 STA $24f8,x ; (EnemyShot + 1)
0a4d : 9d f9 24 STA $24f9,x ; (EnemyShot + 2)
0a50 : e8 __ __ INX
0a51 : e8 __ __ INX
0a52 : e8 __ __ INX
0a53 : 88 __ __ DEY
0a54 : d0 f1 __ BNE $0a47 ; (init_shots.l1008 + 0)
.s1001:
0a56 : 60 __ __ RTS
--------------------------------------------------------------------
PlayerShot:
24ee : __ __ __ BSS	9
--------------------------------------------------------------------
EnemyShot:
24f7 : __ __ __ BSS	9
--------------------------------------------------------------------
init_game_state:
.s0:
0a57 : a9 00 __ LDA #$00
0a59 : 8d 00 25 STA $2500 ; (game + 0)
0a5c : 8d 01 25 STA $2501 ; (game + 1)
0a5f : 8d 02 25 STA $2502 ; (game + 2)
0a62 : 8d 03 25 STA $2503 ; (game + 3)
0a65 : 8d 04 25 STA $2504 ; (game + 4)
.s1001:
0a68 : 60 __ __ RTS
--------------------------------------------------------------------
game:
2500 : __ __ __ BSS	5
--------------------------------------------------------------------
prepare_game_screen:
.s0:
0a69 : a9 20 __ LDA #$20
0a6b : 85 0f __ STA P2 
0a6d : a9 00 __ LDA #$00
0a6f : 85 10 __ STA P3 
0a71 : 85 0d __ STA P0 
0a73 : a9 e8 __ LDA #$e8
0a75 : 85 11 __ STA P4 
0a77 : a9 03 __ LDA #$03
0a79 : 85 12 __ STA P5 
0a7b : a9 c0 __ LDA #$c0
0a7d : 85 0e __ STA P1 
0a7f : 20 c2 0a JSR $0ac2 ; (memset.s0 + 0)
0a82 : a9 00 __ LDA #$00
0a84 : 85 0f __ STA P2 
0a86 : 85 10 __ STA P3 
0a88 : 85 0d __ STA P0 
0a8a : a9 e8 __ LDA #$e8
0a8c : 85 11 __ STA P4 
0a8e : a9 03 __ LDA #$03
0a90 : 85 12 __ STA P5 
0a92 : a9 d8 __ LDA #$d8
0a94 : 85 0e __ STA P1 
0a96 : 20 c2 0a JSR $0ac2 ; (memset.s0 + 0)
0a99 : a9 0b __ LDA #$0b
0a9b : 8d 20 d0 STA $d020 
0a9e : a9 00 __ LDA #$00
0aa0 : 8d 21 d0 STA $d021 
0aa3 : 85 0f __ STA P2 
0aa5 : a9 c0 __ LDA #$c0
0aa7 : 85 10 __ STA P3 
0aa9 : a9 00 __ LDA #$00
0aab : 85 11 __ STA P4 
0aad : 85 12 __ STA P5 
0aaf : a9 28 __ LDA #$28
0ab1 : 85 13 __ STA P6 
0ab3 : a9 03 __ LDA #$03
0ab5 : 85 14 __ STA P7 
0ab7 : a9 05 __ LDA #$05
0ab9 : 85 0d __ STA P0 
0abb : a9 25 __ LDA #$25
0abd : 85 0e __ STA P1 
0abf : 4c e6 0a JMP $0ae6 ; (cwin_init.s0 + 0)
--------------------------------------------------------------------
memset:
.s0:
0ac2 : a5 0f __ LDA P2 
0ac4 : a6 12 __ LDX P5 
0ac6 : f0 0c __ BEQ $0ad4 ; (memset.s0 + 18)
0ac8 : a0 00 __ LDY #$00
0aca : 91 0d __ STA (P0),y ; (dst + 0)
0acc : c8 __ __ INY
0acd : d0 fb __ BNE $0aca ; (memset.s0 + 8)
0acf : e6 0e __ INC P1 ; (dst + 1)
0ad1 : ca __ __ DEX
0ad2 : d0 f6 __ BNE $0aca ; (memset.s0 + 8)
0ad4 : a4 11 __ LDY P4 
0ad6 : f0 05 __ BEQ $0add ; (memset.s0 + 27)
0ad8 : 88 __ __ DEY
0ad9 : 91 0d __ STA (P0),y ; (dst + 0)
0adb : d0 fb __ BNE $0ad8 ; (memset.s0 + 22)
0add : a5 0d __ LDA P0 ; (dst + 0)
0adf : 85 1b __ STA ACCU + 0 
0ae1 : a5 0e __ LDA P1 ; (dst + 1)
0ae3 : 85 1c __ STA ACCU + 1 
.s1001:
0ae5 : 60 __ __ RTS
--------------------------------------------------------------------
cwin_init:
.s0:
0ae6 : a9 00 __ LDA #$00
0ae8 : a0 04 __ LDY #$04
0aea : 91 0d __ STA (P0),y ; (win + 0)
0aec : c8 __ __ INY
0aed : 91 0d __ STA (P0),y ; (win + 0)
0aef : a5 11 __ LDA P4 ; (sx + 0)
0af1 : a0 00 __ LDY #$00
0af3 : 91 0d __ STA (P0),y ; (win + 0)
0af5 : a5 12 __ LDA P5 ; (sy + 0)
0af7 : c8 __ __ INY
0af8 : 91 0d __ STA (P0),y ; (win + 0)
0afa : a5 13 __ LDA P6 ; (wx + 0)
0afc : c8 __ __ INY
0afd : 91 0d __ STA (P0),y ; (win + 0)
0aff : a5 14 __ LDA P7 ; (wy + 0)
0b01 : c8 __ __ INY
0b02 : 91 0d __ STA (P0),y ; (win + 0)
0b04 : a5 12 __ LDA P5 ; (sy + 0)
0b06 : 0a __ __ ASL
0b07 : a8 __ __ TAY
0b08 : b9 61 24 LDA $2461,y ; (mul40 + 0)
0b0b : 85 1b __ STA ACCU + 0 
0b0d : 18 __ __ CLC
0b0e : 65 11 __ ADC P4 ; (sx + 0)
0b10 : aa __ __ TAX
0b11 : b9 62 24 LDA $2462,y ; (mul40 + 1)
0b14 : 85 1c __ STA ACCU + 1 
0b16 : 69 d8 __ ADC #$d8
0b18 : a0 09 __ LDY #$09
0b1a : 91 0d __ STA (P0),y ; (win + 0)
0b1c : 8a __ __ TXA
0b1d : 88 __ __ DEY
0b1e : 91 0d __ STA (P0),y ; (win + 0)
0b20 : 18 __ __ CLC
0b21 : a5 0f __ LDA P2 ; (screen + 0)
0b23 : 65 1b __ ADC ACCU + 0 
0b25 : aa __ __ TAX
0b26 : a5 10 __ LDA P3 ; (screen + 1)
0b28 : 65 1c __ ADC ACCU + 1 
0b2a : 85 10 __ STA P3 ; (screen + 1)
0b2c : 8a __ __ TXA
0b2d : 18 __ __ CLC
0b2e : 65 11 __ ADC P4 ; (sx + 0)
0b30 : a0 06 __ LDY #$06
0b32 : 91 0d __ STA (P0),y ; (win + 0)
0b34 : a5 10 __ LDA P3 ; (screen + 1)
0b36 : 69 00 __ ADC #$00
0b38 : c8 __ __ INY
0b39 : 91 0d __ STA (P0),y ; (win + 0)
.s1001:
0b3b : 60 __ __ RTS
--------------------------------------------------------------------
mul40:
2461 : __ __ __ BYT 00 00 28 00 50 00 78 00 a0 00 c8 00 f0 00 18 01 : ..(.P.x.........
2471 : __ __ __ BYT 40 01 68 01 90 01 b8 01 e0 01 08 02 30 02 58 02 : @.h.........0.X.
2481 : __ __ __ BYT 80 02 a8 02 d0 02 f8 02 20 03 48 03 70 03 98 03 : ........ .H.p...
2491 : __ __ __ BYT c0 03                                           : ..
--------------------------------------------------------------------
cwTop:
2505 : __ __ __ BSS	10
--------------------------------------------------------------------
render_game_state:
.s1000:
0b3c : 38 __ __ SEC
0b3d : a5 23 __ LDA SP + 0 
0b3f : e9 0a __ SBC #$0a
0b41 : 85 23 __ STA SP + 0 
0b43 : b0 02 __ BCS $0b47 ; (render_game_state.s0 + 0)
0b45 : c6 24 __ DEC SP + 1 
.s0:
0b47 : a9 01 __ LDA #$01
0b49 : 85 0f __ STA P2 
0b4b : a9 02 __ LDA #$02
0b4d : 85 10 __ STA P3 
0b4f : a9 05 __ LDA #$05
0b51 : 85 13 __ STA P6 
0b53 : a9 05 __ LDA #$05
0b55 : 85 0d __ STA P0 
0b57 : a9 25 __ LDA #$25
0b59 : 85 0e __ STA P1 
0b5b : a9 13 __ LDA #$13
0b5d : 85 11 __ STA P4 
0b5f : a9 0c __ LDA #$0c
0b61 : 85 12 __ STA P5 
0b63 : 20 c1 0b JSR $0bc1 ; (cwin_putat_string.s0 + 0)
0b66 : a9 ce __ LDA #$ce
0b68 : a0 02 __ LDY #$02
0b6a : 91 23 __ STA (SP + 0),y 
0b6c : a9 9f __ LDA #$9f
0b6e : c8 __ __ INY
0b6f : 91 23 __ STA (SP + 0),y 
0b71 : a9 e1 __ LDA #$e1
0b73 : c8 __ __ INY
0b74 : 91 23 __ STA (SP + 0),y 
0b76 : a9 18 __ LDA #$18
0b78 : c8 __ __ INY
0b79 : 91 23 __ STA (SP + 0),y 
0b7b : ad 01 25 LDA $2501 ; (game + 1)
0b7e : c8 __ __ INY
0b7f : 91 23 __ STA (SP + 0),y 
0b81 : ad 02 25 LDA $2502 ; (game + 2)
0b84 : c8 __ __ INY
0b85 : 91 23 __ STA (SP + 0),y 
0b87 : ad 03 25 LDA $2503 ; (game + 3)
0b8a : c8 __ __ INY
0b8b : 91 23 __ STA (SP + 0),y 
0b8d : ad 04 25 LDA $2504 ; (game + 4)
0b90 : c8 __ __ INY
0b91 : 91 23 __ STA (SP + 0),y 
0b93 : 20 1a 0c JSR $0c1a ; (sprintf.s1000 + 0)
0b96 : a9 05 __ LDA #$05
0b98 : 85 0d __ STA P0 
0b9a : a9 25 __ LDA #$25
0b9c : 85 0e __ STA P1 
0b9e : a9 08 __ LDA #$08
0ba0 : 85 0f __ STA P2 
0ba2 : a9 02 __ LDA #$02
0ba4 : 85 10 __ STA P3 
0ba6 : a9 ce __ LDA #$ce
0ba8 : 85 11 __ STA P4 
0baa : a9 9f __ LDA #$9f
0bac : 85 12 __ STA P5 
0bae : a9 05 __ LDA #$05
0bb0 : 85 13 __ STA P6 
0bb2 : 20 c1 0b JSR $0bc1 ; (cwin_putat_string.s0 + 0)
.s1001:
0bb5 : 18 __ __ CLC
0bb6 : a5 23 __ LDA SP + 0 
0bb8 : 69 0a __ ADC #$0a
0bba : 85 23 __ STA SP + 0 
0bbc : 90 02 __ BCC $0bc0 ; (render_game_state.s1001 + 11)
0bbe : e6 24 __ INC SP + 1 
0bc0 : 60 __ __ RTS
--------------------------------------------------------------------
cwin_putat_string:
.s0:
0bc1 : a5 10 __ LDA P3 ; (y + 0)
0bc3 : 0a __ __ ASL
0bc4 : aa __ __ TAX
0bc5 : bd 61 24 LDA $2461,x ; (mul40 + 0)
0bc8 : 18 __ __ CLC
0bc9 : 65 0f __ ADC P2 ; (x + 0)
0bcb : 85 1b __ STA ACCU + 0 
0bcd : bd 62 24 LDA $2462,x ; (mul40 + 1)
0bd0 : 69 00 __ ADC #$00
0bd2 : 85 1c __ STA ACCU + 1 
0bd4 : a0 06 __ LDY #$06
0bd6 : b1 0d __ LDA (P0),y ; (win + 0)
0bd8 : 18 __ __ CLC
0bd9 : 65 1b __ ADC ACCU + 0 
0bdb : 85 43 __ STA T3 + 0 
0bdd : c8 __ __ INY
0bde : b1 0d __ LDA (P0),y ; (win + 0)
0be0 : 65 1c __ ADC ACCU + 1 
0be2 : 85 44 __ STA T3 + 1 
0be4 : c8 __ __ INY
0be5 : b1 0d __ LDA (P0),y ; (win + 0)
0be7 : 18 __ __ CLC
0be8 : 65 1b __ ADC ACCU + 0 
0bea : 85 1b __ STA ACCU + 0 
0bec : c8 __ __ INY
0bed : b1 0d __ LDA (P0),y ; (win + 0)
0bef : 65 1c __ ADC ACCU + 1 
0bf1 : 85 1c __ STA ACCU + 1 
0bf3 : a0 00 __ LDY #$00
0bf5 : b1 11 __ LDA (P4),y ; (str + 0)
0bf7 : f0 18 __ BEQ $0c11 ; (cwin_putat_string.s3 + 0)
.l2:
0bf9 : 85 1d __ STA ACCU + 2 
0bfb : 4a __ __ LSR
0bfc : 4a __ __ LSR
0bfd : 4a __ __ LSR
0bfe : 4a __ __ LSR
0bff : 4a __ __ LSR
0c00 : aa __ __ TAX
0c01 : bd 93 24 LDA $2493,x ; (p2smap + 0)
0c04 : 45 1d __ EOR ACCU + 2 
0c06 : 91 43 __ STA (T3 + 0),y 
0c08 : a5 13 __ LDA P6 ; (color + 0)
0c0a : 91 1b __ STA (ACCU + 0),y 
0c0c : c8 __ __ INY
0c0d : b1 11 __ LDA (P4),y ; (str + 0)
0c0f : d0 e8 __ BNE $0bf9 ; (cwin_putat_string.l2 + 0)
.s3:
0c11 : 98 __ __ TYA
.s1001:
0c12 : 60 __ __ RTS
--------------------------------------------------------------------
p2smap:
2493 : __ __ __ BYT 00 00 40 20 80 c0 80 80                         : ..@ ....
--------------------------------------------------------------------
0c13 : __ __ __ BYT 53 43 4f 52 45 3a 00                            : SCORE:.
--------------------------------------------------------------------
sprintf:
.s1000:
0c1a : a5 53 __ LDA T0 + 0 
0c1c : 8d d8 9f STA $9fd8 ; (sprintf@stack + 0)
0c1f : a5 54 __ LDA T0 + 1 
0c21 : 8d d9 9f STA $9fd9 ; (sprintf@stack + 1)
.s0:
0c24 : a9 00 __ LDA #$00
0c26 : 8d ff 9f STA $9fff ; (sstack + 7)
0c29 : a0 03 __ LDY #$03
0c2b : b1 23 __ LDA (SP + 0),y 
0c2d : 85 54 __ STA T0 + 1 
0c2f : 8d fa 9f STA $9ffa ; (sstack + 2)
0c32 : 88 __ __ DEY
0c33 : b1 23 __ LDA (SP + 0),y 
0c35 : 85 53 __ STA T0 + 0 
0c37 : 8d f9 9f STA $9ff9 ; (sstack + 1)
0c3a : a0 04 __ LDY #$04
0c3c : b1 23 __ LDA (SP + 0),y 
0c3e : 8d fb 9f STA $9ffb ; (sstack + 3)
0c41 : c8 __ __ INY
0c42 : b1 23 __ LDA (SP + 0),y 
0c44 : 8d fc 9f STA $9ffc ; (sstack + 4)
0c47 : 18 __ __ CLC
0c48 : a5 23 __ LDA SP + 0 
0c4a : 69 06 __ ADC #$06
0c4c : 8d fd 9f STA $9ffd ; (sstack + 5)
0c4f : a5 24 __ LDA SP + 1 
0c51 : 69 00 __ ADC #$00
0c53 : 8d fe 9f STA $9ffe ; (sstack + 6)
0c56 : 20 71 0c JSR $0c71 ; (sformat.s1000 + 0)
0c59 : 38 __ __ SEC
0c5a : a5 1b __ LDA ACCU + 0 
0c5c : e5 53 __ SBC T0 + 0 
0c5e : 85 1b __ STA ACCU + 0 
0c60 : a5 1c __ LDA ACCU + 1 
0c62 : e5 54 __ SBC T0 + 1 
0c64 : 85 1c __ STA ACCU + 1 
.s1001:
0c66 : ad d8 9f LDA $9fd8 ; (sprintf@stack + 0)
0c69 : 85 53 __ STA T0 + 0 
0c6b : ad d9 9f LDA $9fd9 ; (sprintf@stack + 1)
0c6e : 85 54 __ STA T0 + 1 
0c70 : 60 __ __ RTS
--------------------------------------------------------------------
sformat:
.s1000:
0c71 : a2 05 __ LDX #$05
0c73 : b5 53 __ LDA T1 + 0,x 
0c75 : 9d da 9f STA $9fda,x ; (sformat@stack + 0)
0c78 : ca __ __ DEX
0c79 : 10 f8 __ BPL $0c73 ; (sformat.s1000 + 2)
.s0:
0c7b : a9 00 __ LDA #$00
0c7d : 85 50 __ STA T0 + 0 
0c7f : ad fb 9f LDA $9ffb ; (sstack + 3)
0c82 : 85 53 __ STA T1 + 0 
0c84 : ad fc 9f LDA $9ffc ; (sstack + 4)
0c87 : 85 54 __ STA T1 + 1 
0c89 : ad f9 9f LDA $9ff9 ; (sstack + 1)
0c8c : 85 55 __ STA T2 + 0 
0c8e : ad fa 9f LDA $9ffa ; (sstack + 2)
0c91 : 85 56 __ STA T2 + 1 
.l1:
0c93 : a0 00 __ LDY #$00
0c95 : b1 53 __ LDA (T1 + 0),y 
0c97 : d0 38 __ BNE $0cd1 ; (sformat.s2 + 0)
.s3:
0c99 : a4 50 __ LDY T0 + 0 
0c9b : 91 55 __ STA (T2 + 0),y 
0c9d : 98 __ __ TYA
0c9e : f0 28 __ BEQ $0cc8 ; (sformat.s1061 + 0)
.s112:
0ca0 : ad ff 9f LDA $9fff ; (sstack + 7)
0ca3 : d0 18 __ BNE $0cbd ; (sformat.s115 + 0)
.s116:
0ca5 : 18 __ __ CLC
0ca6 : a5 55 __ LDA T2 + 0 
0ca8 : 65 50 __ ADC T0 + 0 
0caa : 85 1b __ STA ACCU + 0 ; (buff + 1)
0cac : a5 56 __ LDA T2 + 1 
0cae : 69 00 __ ADC #$00
.s1001:
0cb0 : 85 1c __ STA ACCU + 1 ; (fmt + 0)
0cb2 : a2 05 __ LDX #$05
0cb4 : bd da 9f LDA $9fda,x ; (sformat@stack + 0)
0cb7 : 95 53 __ STA T1 + 0,x 
0cb9 : ca __ __ DEX
0cba : 10 f8 __ BPL $0cb4 ; (sformat.s1001 + 4)
0cbc : 60 __ __ RTS
.s115:
0cbd : a5 55 __ LDA T2 + 0 
0cbf : 85 0d __ STA P0 
0cc1 : a5 56 __ LDA T2 + 1 
0cc3 : 85 0e __ STA P1 
0cc5 : 20 b5 10 JSR $10b5 ; (puts.s0 + 0)
.s1061:
0cc8 : a5 55 __ LDA T2 + 0 
0cca : 85 1b __ STA ACCU + 0 ; (buff + 1)
0ccc : a5 56 __ LDA T2 + 1 
0cce : 4c b0 0c JMP $0cb0 ; (sformat.s1001 + 0)
.s2:
0cd1 : c9 25 __ CMP #$25
0cd3 : f0 3f __ BEQ $0d14 ; (sformat.s4 + 0)
.s5:
0cd5 : a4 50 __ LDY T0 + 0 
0cd7 : 91 55 __ STA (T2 + 0),y 
0cd9 : e6 53 __ INC T1 + 0 
0cdb : d0 02 __ BNE $0cdf ; (sformat.s1090 + 0)
.s1089:
0cdd : e6 54 __ INC T1 + 1 
.s1090:
0cdf : c8 __ __ INY
0ce0 : 84 50 __ STY T0 + 0 
0ce2 : 98 __ __ TYA
0ce3 : c0 28 __ CPY #$28
0ce5 : 90 ac __ BCC $0c93 ; (sformat.l1 + 0)
.s106:
0ce7 : 85 57 __ STA T5 + 0 
0ce9 : a9 00 __ LDA #$00
0ceb : 85 50 __ STA T0 + 0 
0ced : ad ff 9f LDA $9fff ; (sstack + 7)
0cf0 : f0 14 __ BEQ $0d06 ; (sformat.s110 + 0)
.s109:
0cf2 : a5 55 __ LDA T2 + 0 
0cf4 : 85 0d __ STA P0 
0cf6 : a5 56 __ LDA T2 + 1 
0cf8 : 85 0e __ STA P1 
0cfa : a9 00 __ LDA #$00
0cfc : a4 57 __ LDY T5 + 0 
0cfe : 91 0d __ STA (P0),y 
0d00 : 20 b5 10 JSR $10b5 ; (puts.s0 + 0)
0d03 : 4c 93 0c JMP $0c93 ; (sformat.l1 + 0)
.s110:
0d06 : 18 __ __ CLC
0d07 : a5 55 __ LDA T2 + 0 
0d09 : 65 57 __ ADC T5 + 0 
0d0b : 85 55 __ STA T2 + 0 
0d0d : 90 84 __ BCC $0c93 ; (sformat.l1 + 0)
.s1092:
0d0f : e6 56 __ INC T2 + 1 
0d11 : 4c 93 0c JMP $0c93 ; (sformat.l1 + 0)
.s4:
0d14 : a5 50 __ LDA T0 + 0 
0d16 : f0 27 __ BEQ $0d3f ; (sformat.s9 + 0)
.s7:
0d18 : 84 50 __ STY T0 + 0 
0d1a : 85 57 __ STA T5 + 0 
0d1c : ad ff 9f LDA $9fff ; (sstack + 7)
0d1f : f0 13 __ BEQ $0d34 ; (sformat.s11 + 0)
.s10:
0d21 : a5 55 __ LDA T2 + 0 
0d23 : 85 0d __ STA P0 
0d25 : a5 56 __ LDA T2 + 1 
0d27 : 85 0e __ STA P1 
0d29 : 98 __ __ TYA
0d2a : a4 57 __ LDY T5 + 0 
0d2c : 91 0d __ STA (P0),y 
0d2e : 20 b5 10 JSR $10b5 ; (puts.s0 + 0)
0d31 : 4c 3f 0d JMP $0d3f ; (sformat.s9 + 0)
.s11:
0d34 : 18 __ __ CLC
0d35 : a5 55 __ LDA T2 + 0 
0d37 : 65 57 __ ADC T5 + 0 
0d39 : 85 55 __ STA T2 + 0 
0d3b : 90 02 __ BCC $0d3f ; (sformat.s9 + 0)
.s1087:
0d3d : e6 56 __ INC T2 + 1 
.s9:
0d3f : a9 0a __ LDA #$0a
0d41 : 8d e3 9f STA $9fe3 ; (si + 3)
0d44 : a9 00 __ LDA #$00
0d46 : 8d e4 9f STA $9fe4 ; (si + 4)
0d49 : 8d e5 9f STA $9fe5 ; (si + 5)
0d4c : 8d e6 9f STA $9fe6 ; (si + 6)
0d4f : 8d e7 9f STA $9fe7 ; (si + 7)
0d52 : a0 01 __ LDY #$01
0d54 : b1 53 __ LDA (T1 + 0),y 
0d56 : aa __ __ TAX
0d57 : a9 20 __ LDA #$20
0d59 : 8d e0 9f STA $9fe0 ; (si + 0)
0d5c : a9 00 __ LDA #$00
0d5e : 8d e1 9f STA $9fe1 ; (si + 1)
0d61 : a9 ff __ LDA #$ff
0d63 : 8d e2 9f STA $9fe2 ; (si + 2)
0d66 : 18 __ __ CLC
0d67 : a5 53 __ LDA T1 + 0 
0d69 : 69 02 __ ADC #$02
.l14:
0d6b : 85 53 __ STA T1 + 0 
0d6d : 90 02 __ BCC $0d71 ; (sformat.s1074 + 0)
.s1073:
0d6f : e6 54 __ INC T1 + 1 
.s1074:
0d71 : 8a __ __ TXA
0d72 : e0 2b __ CPX #$2b
0d74 : d0 08 __ BNE $0d7e ; (sformat.s17 + 0)
.s16:
0d76 : a9 01 __ LDA #$01
0d78 : 8d e5 9f STA $9fe5 ; (si + 5)
0d7b : 4c a8 10 JMP $10a8 ; (sformat.s224 + 0)
.s17:
0d7e : c9 30 __ CMP #$30
0d80 : d0 06 __ BNE $0d88 ; (sformat.s20 + 0)
.s19:
0d82 : 8d e0 9f STA $9fe0 ; (si + 0)
0d85 : 4c a8 10 JMP $10a8 ; (sformat.s224 + 0)
.s20:
0d88 : e0 23 __ CPX #$23
0d8a : d0 08 __ BNE $0d94 ; (sformat.s23 + 0)
.s22:
0d8c : a9 01 __ LDA #$01
0d8e : 8d e7 9f STA $9fe7 ; (si + 7)
0d91 : 4c a8 10 JMP $10a8 ; (sformat.s224 + 0)
.s23:
0d94 : e0 2d __ CPX #$2d
0d96 : d0 08 __ BNE $0da0 ; (sformat.s15 + 0)
.s25:
0d98 : a9 01 __ LDA #$01
0d9a : 8d e6 9f STA $9fe6 ; (si + 6)
0d9d : 4c a8 10 JMP $10a8 ; (sformat.s224 + 0)
.s15:
0da0 : 86 57 __ STX T5 + 0 
0da2 : e0 30 __ CPX #$30
0da4 : 90 53 __ BCC $0df9 ; (sformat.s31 + 0)
.s32:
0da6 : e0 3a __ CPX #$3a
0da8 : b0 4f __ BCS $0df9 ; (sformat.s31 + 0)
.s29:
0daa : a9 00 __ LDA #$00
0dac : 85 44 __ STA T6 + 0 
0dae : 85 45 __ STA T6 + 1 
0db0 : e0 3a __ CPX #$3a
0db2 : b0 40 __ BCS $0df4 ; (sformat.s35 + 0)
.l34:
0db4 : a5 44 __ LDA T6 + 0 
0db6 : 0a __ __ ASL
0db7 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0db9 : a5 45 __ LDA T6 + 1 
0dbb : 2a __ __ ROL
0dbc : 06 1b __ ASL ACCU + 0 ; (buff + 1)
0dbe : 2a __ __ ROL
0dbf : aa __ __ TAX
0dc0 : 18 __ __ CLC
0dc1 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0dc3 : 65 44 __ ADC T6 + 0 
0dc5 : 85 44 __ STA T6 + 0 
0dc7 : 8a __ __ TXA
0dc8 : 65 45 __ ADC T6 + 1 
0dca : 06 44 __ ASL T6 + 0 
0dcc : 2a __ __ ROL
0dcd : aa __ __ TAX
0dce : 18 __ __ CLC
0dcf : a5 44 __ LDA T6 + 0 
0dd1 : 65 57 __ ADC T5 + 0 
0dd3 : 90 01 __ BCC $0dd6 ; (sformat.s1084 + 0)
.s1083:
0dd5 : e8 __ __ INX
.s1084:
0dd6 : 38 __ __ SEC
0dd7 : e9 30 __ SBC #$30
0dd9 : 85 44 __ STA T6 + 0 
0ddb : 8a __ __ TXA
0ddc : e9 00 __ SBC #$00
0dde : 85 45 __ STA T6 + 1 
0de0 : a0 00 __ LDY #$00
0de2 : b1 53 __ LDA (T1 + 0),y 
0de4 : 85 57 __ STA T5 + 0 
0de6 : e6 53 __ INC T1 + 0 
0de8 : d0 02 __ BNE $0dec ; (sformat.s1086 + 0)
.s1085:
0dea : e6 54 __ INC T1 + 1 
.s1086:
0dec : c9 30 __ CMP #$30
0dee : 90 04 __ BCC $0df4 ; (sformat.s35 + 0)
.s36:
0df0 : c9 3a __ CMP #$3a
0df2 : 90 c0 __ BCC $0db4 ; (sformat.l34 + 0)
.s35:
0df4 : a5 44 __ LDA T6 + 0 
0df6 : 8d e1 9f STA $9fe1 ; (si + 1)
.s31:
0df9 : a5 57 __ LDA T5 + 0 
0dfb : c9 2e __ CMP #$2e
0dfd : d0 51 __ BNE $0e50 ; (sformat.s39 + 0)
.s37:
0dff : a9 00 __ LDA #$00
0e01 : 85 44 __ STA T6 + 0 
.l203:
0e03 : 85 45 __ STA T6 + 1 
0e05 : a0 00 __ LDY #$00
0e07 : b1 53 __ LDA (T1 + 0),y 
0e09 : 85 57 __ STA T5 + 0 
0e0b : e6 53 __ INC T1 + 0 
0e0d : d0 02 __ BNE $0e11 ; (sformat.s1076 + 0)
.s1075:
0e0f : e6 54 __ INC T1 + 1 
.s1076:
0e11 : c9 30 __ CMP #$30
0e13 : 90 04 __ BCC $0e19 ; (sformat.s42 + 0)
.s43:
0e15 : c9 3a __ CMP #$3a
0e17 : 90 0a __ BCC $0e23 ; (sformat.s41 + 0)
.s42:
0e19 : a5 44 __ LDA T6 + 0 
0e1b : 8d e2 9f STA $9fe2 ; (si + 2)
0e1e : a5 57 __ LDA T5 + 0 
0e20 : 4c 50 0e JMP $0e50 ; (sformat.s39 + 0)
.s41:
0e23 : a5 44 __ LDA T6 + 0 
0e25 : 0a __ __ ASL
0e26 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0e28 : a5 45 __ LDA T6 + 1 
0e2a : 2a __ __ ROL
0e2b : 06 1b __ ASL ACCU + 0 ; (buff + 1)
0e2d : 2a __ __ ROL
0e2e : aa __ __ TAX
0e2f : 18 __ __ CLC
0e30 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0e32 : 65 44 __ ADC T6 + 0 
0e34 : 85 44 __ STA T6 + 0 
0e36 : 8a __ __ TXA
0e37 : 65 45 __ ADC T6 + 1 
0e39 : 06 44 __ ASL T6 + 0 
0e3b : 2a __ __ ROL
0e3c : aa __ __ TAX
0e3d : 18 __ __ CLC
0e3e : a5 44 __ LDA T6 + 0 
0e40 : 65 57 __ ADC T5 + 0 
0e42 : 90 01 __ BCC $0e45 ; (sformat.s1082 + 0)
.s1081:
0e44 : e8 __ __ INX
.s1082:
0e45 : 38 __ __ SEC
0e46 : e9 30 __ SBC #$30
0e48 : 85 44 __ STA T6 + 0 
0e4a : 8a __ __ TXA
0e4b : e9 00 __ SBC #$00
0e4d : 4c 03 0e JMP $0e03 ; (sformat.l203 + 0)
.s39:
0e50 : c9 64 __ CMP #$64
0e52 : d0 05 __ BNE $0e59 ; (sformat.s45 + 0)
.s44:
0e54 : a9 01 __ LDA #$01
0e56 : 4c 6c 10 JMP $106c ; (sformat.s221 + 0)
.s45:
0e59 : c9 75 __ CMP #$75
0e5b : d0 03 __ BNE $0e60 ; (sformat.s48 + 0)
0e5d : 4c 6a 10 JMP $106a ; (sformat.s250 + 0)
.s48:
0e60 : c9 78 __ CMP #$78
0e62 : d0 0d __ BNE $0e71 ; (sformat.s51 + 0)
.s50:
0e64 : a9 10 __ LDA #$10
0e66 : 8d e3 9f STA $9fe3 ; (si + 3)
0e69 : a9 00 __ LDA #$00
0e6b : 8d e4 9f STA $9fe4 ; (si + 4)
0e6e : 4c 6a 10 JMP $106a ; (sformat.s250 + 0)
.s51:
0e71 : c9 6c __ CMP #$6c
0e73 : d0 03 __ BNE $0e78 ; (sformat.s54 + 0)
0e75 : 4c e5 0f JMP $0fe5 ; (sformat.s53 + 0)
.s54:
0e78 : c9 66 __ CMP #$66
0e7a : f0 08 __ BEQ $0e84 ; (sformat.s65 + 0)
.s69:
0e7c : c9 67 __ CMP #$67
0e7e : f0 04 __ BEQ $0e84 ; (sformat.s65 + 0)
.s68:
0e80 : c9 65 __ CMP #$65
0e82 : d0 4d __ BNE $0ed1 ; (sformat.s66 + 0)
.s65:
0e84 : a5 55 __ LDA T2 + 0 
0e86 : 85 13 __ STA P6 
0e88 : a5 56 __ LDA T2 + 1 
0e8a : 85 14 __ STA P7 
0e8c : a5 57 __ LDA T5 + 0 
0e8e : 8d f8 9f STA $9ff8 ; (sstack + 0)
0e91 : a9 e0 __ LDA #$e0
0e93 : 85 11 __ STA P4 
0e95 : a9 9f __ LDA #$9f
0e97 : 85 12 __ STA P5 
0e99 : ad fd 9f LDA $9ffd ; (sstack + 5)
0e9c : 85 57 __ STA T5 + 0 
0e9e : ad fe 9f LDA $9ffe ; (sstack + 6)
0ea1 : 85 58 __ STA T5 + 1 
0ea3 : a0 00 __ LDY #$00
0ea5 : b1 57 __ LDA (T5 + 0),y 
0ea7 : 85 15 __ STA P8 
0ea9 : c8 __ __ INY
0eaa : b1 57 __ LDA (T5 + 0),y 
0eac : 85 16 __ STA P9 
0eae : c8 __ __ INY
0eaf : b1 57 __ LDA (T5 + 0),y 
0eb1 : 85 17 __ STA P10 
0eb3 : c8 __ __ INY
0eb4 : b1 57 __ LDA (T5 + 0),y 
0eb6 : 85 18 __ STA P11 
0eb8 : 20 01 14 JSR $1401 ; (nformf.s0 + 0)
0ebb : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0ebd : 85 50 __ STA T0 + 0 
0ebf : 18 __ __ CLC
0ec0 : a5 57 __ LDA T5 + 0 
0ec2 : 69 04 __ ADC #$04
0ec4 : 8d fd 9f STA $9ffd ; (sstack + 5)
0ec7 : a5 58 __ LDA T5 + 1 
0ec9 : 69 00 __ ADC #$00
0ecb : 8d fe 9f STA $9ffe ; (sstack + 6)
0ece : 4c 93 0c JMP $0c93 ; (sformat.l1 + 0)
.s66:
0ed1 : c9 73 __ CMP #$73
0ed3 : f0 4c __ BEQ $0f21 ; (sformat.s70 + 0)
.s71:
0ed5 : c9 63 __ CMP #$63
0ed7 : f0 1f __ BEQ $0ef8 ; (sformat.s100 + 0)
.s101:
0ed9 : 09 00 __ ORA #$00
0edb : d0 03 __ BNE $0ee0 ; (sformat.s103 + 0)
0edd : 4c 93 0c JMP $0c93 ; (sformat.l1 + 0)
.s103:
0ee0 : 18 __ __ CLC
0ee1 : a5 55 __ LDA T2 + 0 
0ee3 : 65 50 __ ADC T0 + 0 
0ee5 : 85 44 __ STA T6 + 0 
0ee7 : a5 56 __ LDA T2 + 1 
0ee9 : 69 00 __ ADC #$00
0eeb : 85 45 __ STA T6 + 1 
0eed : a5 57 __ LDA T5 + 0 
.s1059:
0eef : a0 00 __ LDY #$00
0ef1 : 91 44 __ STA (T6 + 0),y 
0ef3 : e6 50 __ INC T0 + 0 
0ef5 : 4c 93 0c JMP $0c93 ; (sformat.l1 + 0)
.s100:
0ef8 : ad fd 9f LDA $9ffd ; (sstack + 5)
0efb : 85 57 __ STA T5 + 0 
0efd : 18 __ __ CLC
0efe : 69 02 __ ADC #$02
0f00 : 8d fd 9f STA $9ffd ; (sstack + 5)
0f03 : ad fe 9f LDA $9ffe ; (sstack + 6)
0f06 : 85 58 __ STA T5 + 1 
0f08 : 69 00 __ ADC #$00
0f0a : 8d fe 9f STA $9ffe ; (sstack + 6)
0f0d : 18 __ __ CLC
0f0e : a5 55 __ LDA T2 + 0 
0f10 : 65 50 __ ADC T0 + 0 
0f12 : 85 44 __ STA T6 + 0 
0f14 : a5 56 __ LDA T2 + 1 
0f16 : 69 00 __ ADC #$00
0f18 : 85 45 __ STA T6 + 1 
0f1a : a0 00 __ LDY #$00
0f1c : b1 57 __ LDA (T5 + 0),y 
0f1e : 4c ef 0e JMP $0eef ; (sformat.s1059 + 0)
.s70:
0f21 : ad fd 9f LDA $9ffd ; (sstack + 5)
0f24 : 85 57 __ STA T5 + 0 
0f26 : 18 __ __ CLC
0f27 : 69 02 __ ADC #$02
0f29 : 8d fd 9f STA $9ffd ; (sstack + 5)
0f2c : ad fe 9f LDA $9ffe ; (sstack + 6)
0f2f : 85 58 __ STA T5 + 1 
0f31 : 69 00 __ ADC #$00
0f33 : 8d fe 9f STA $9ffe ; (sstack + 6)
0f36 : a0 00 __ LDY #$00
0f38 : b1 57 __ LDA (T5 + 0),y 
0f3a : aa __ __ TAX
0f3b : c8 __ __ INY
0f3c : b1 57 __ LDA (T5 + 0),y 
0f3e : 86 57 __ STX T5 + 0 
0f40 : 85 58 __ STA T5 + 1 
0f42 : a9 00 __ LDA #$00
0f44 : 85 52 __ STA T3 + 0 
0f46 : ad e1 9f LDA $9fe1 ; (si + 1)
0f49 : f0 0c __ BEQ $0f57 ; (sformat.s75 + 0)
.s1065:
0f4b : 88 __ __ DEY
0f4c : b1 57 __ LDA (T5 + 0),y 
0f4e : f0 05 __ BEQ $0f55 ; (sformat.s1066 + 0)
.l77:
0f50 : c8 __ __ INY
0f51 : b1 57 __ LDA (T5 + 0),y 
0f53 : d0 fb __ BNE $0f50 ; (sformat.l77 + 0)
.s1066:
0f55 : 84 52 __ STY T3 + 0 
.s75:
0f57 : ad e6 9f LDA $9fe6 ; (si + 6)
0f5a : d0 19 __ BNE $0f75 ; (sformat.s81 + 0)
.s1069:
0f5c : a6 52 __ LDX T3 + 0 
0f5e : ec e1 9f CPX $9fe1 ; (si + 1)
0f61 : a4 50 __ LDY T0 + 0 
0f63 : b0 0c __ BCS $0f71 ; (sformat.s1070 + 0)
.l83:
0f65 : ad e0 9f LDA $9fe0 ; (si + 0)
0f68 : 91 55 __ STA (T2 + 0),y 
0f6a : e8 __ __ INX
0f6b : ec e1 9f CPX $9fe1 ; (si + 1)
0f6e : c8 __ __ INY
0f6f : 90 f4 __ BCC $0f65 ; (sformat.l83 + 0)
.s1070:
0f71 : 86 52 __ STX T3 + 0 
0f73 : 84 50 __ STY T0 + 0 
.s81:
0f75 : ad ff 9f LDA $9fff ; (sstack + 7)
0f78 : d0 37 __ BNE $0fb1 ; (sformat.s85 + 0)
.l91:
0f7a : a0 00 __ LDY #$00
0f7c : b1 57 __ LDA (T5 + 0),y 
0f7e : f0 0f __ BEQ $0f8f ; (sformat.s211 + 0)
.s92:
0f80 : a4 50 __ LDY T0 + 0 
0f82 : 91 55 __ STA (T2 + 0),y 
0f84 : e6 50 __ INC T0 + 0 
0f86 : e6 57 __ INC T5 + 0 
0f88 : d0 f0 __ BNE $0f7a ; (sformat.l91 + 0)
.s1079:
0f8a : e6 58 __ INC T5 + 1 
0f8c : 4c 7a 0f JMP $0f7a ; (sformat.l91 + 0)
.s211:
0f8f : ad e6 9f LDA $9fe6 ; (si + 6)
0f92 : d0 03 __ BNE $0f97 ; (sformat.s1067 + 0)
0f94 : 4c 93 0c JMP $0c93 ; (sformat.l1 + 0)
.s1067:
0f97 : a6 52 __ LDX T3 + 0 
0f99 : ec e1 9f CPX $9fe1 ; (si + 1)
0f9c : a4 50 __ LDY T0 + 0 
0f9e : b0 0c __ BCS $0fac ; (sformat.s1068 + 0)
.l98:
0fa0 : ad e0 9f LDA $9fe0 ; (si + 0)
0fa3 : 91 55 __ STA (T2 + 0),y 
0fa5 : e8 __ __ INX
0fa6 : ec e1 9f CPX $9fe1 ; (si + 1)
0fa9 : c8 __ __ INY
0faa : 90 f4 __ BCC $0fa0 ; (sformat.l98 + 0)
.s1068:
0fac : 84 50 __ STY T0 + 0 
0fae : 4c 93 0c JMP $0c93 ; (sformat.l1 + 0)
.s85:
0fb1 : a5 50 __ LDA T0 + 0 
0fb3 : f0 22 __ BEQ $0fd7 ; (sformat.s90 + 0)
.s88:
0fb5 : a5 55 __ LDA T2 + 0 
0fb7 : 85 0d __ STA P0 
0fb9 : a5 56 __ LDA T2 + 1 
0fbb : 85 0e __ STA P1 
0fbd : a9 00 __ LDA #$00
0fbf : a4 50 __ LDY T0 + 0 
0fc1 : 91 0d __ STA (P0),y 
0fc3 : 20 b5 10 JSR $10b5 ; (puts.s0 + 0)
0fc6 : a5 57 __ LDA T5 + 0 
0fc8 : 85 0d __ STA P0 
0fca : a5 58 __ LDA T5 + 1 
0fcc : 85 0e __ STA P1 
0fce : 20 b5 10 JSR $10b5 ; (puts.s0 + 0)
0fd1 : a9 00 __ LDA #$00
0fd3 : 85 50 __ STA T0 + 0 
0fd5 : f0 b8 __ BEQ $0f8f ; (sformat.s211 + 0)
.s90:
0fd7 : a5 57 __ LDA T5 + 0 
0fd9 : 85 0d __ STA P0 
0fdb : a5 58 __ LDA T5 + 1 
0fdd : 85 0e __ STA P1 
0fdf : 20 b5 10 JSR $10b5 ; (puts.s0 + 0)
0fe2 : 4c 8f 0f JMP $0f8f ; (sformat.s211 + 0)
.s53:
0fe5 : ad fd 9f LDA $9ffd ; (sstack + 5)
0fe8 : 85 57 __ STA T5 + 0 
0fea : 18 __ __ CLC
0feb : 69 04 __ ADC #$04
0fed : 8d fd 9f STA $9ffd ; (sstack + 5)
0ff0 : ad fe 9f LDA $9ffe ; (sstack + 6)
0ff3 : 85 58 __ STA T5 + 1 
0ff5 : 69 00 __ ADC #$00
0ff7 : 8d fe 9f STA $9ffe ; (sstack + 6)
0ffa : a0 00 __ LDY #$00
0ffc : b1 53 __ LDA (T1 + 0),y 
0ffe : 85 52 __ STA T3 + 0 
1000 : e6 53 __ INC T1 + 0 
1002 : d0 02 __ BNE $1006 ; (sformat.s1078 + 0)
.s1077:
1004 : e6 54 __ INC T1 + 1 
.s1078:
1006 : c9 64 __ CMP #$64
1008 : d0 04 __ BNE $100e ; (sformat.s1019 + 0)
.s1018:
100a : a2 01 __ LDX #$01
100c : d0 02 __ BNE $1010 ; (sformat.s1020 + 0)
.s1019:
100e : a2 00 __ LDX #$00
.s1020:
1010 : b1 57 __ LDA (T5 + 0),y 
1012 : 85 46 __ STA T7 + 0 
1014 : a0 01 __ LDY #$01
1016 : b1 57 __ LDA (T5 + 0),y 
1018 : 85 47 __ STA T7 + 1 
101a : c8 __ __ INY
101b : b1 57 __ LDA (T5 + 0),y 
101d : 85 48 __ STA T7 + 2 
101f : c8 __ __ INY
1020 : b1 57 __ LDA (T5 + 0),y 
1022 : a8 __ __ TAY
1023 : 8a __ __ TXA
1024 : f0 04 __ BEQ $102a ; (sformat.s57 + 0)
.s56:
1026 : a9 01 __ LDA #$01
1028 : d0 16 __ BNE $1040 ; (sformat.s222 + 0)
.s57:
102a : a5 52 __ LDA T3 + 0 
102c : c9 75 __ CMP #$75
102e : f0 0f __ BEQ $103f ; (sformat.s251 + 0)
.s60:
1030 : c9 78 __ CMP #$78
1032 : f0 03 __ BEQ $1037 ; (sformat.s62 + 0)
1034 : 4c 93 0c JMP $0c93 ; (sformat.l1 + 0)
.s62:
1037 : 8e e4 9f STX $9fe4 ; (si + 4)
103a : a9 10 __ LDA #$10
103c : 8d e3 9f STA $9fe3 ; (si + 3)
.s251:
103f : 8a __ __ TXA
.s222:
1040 : 84 14 __ STY P7 
1042 : 85 15 __ STA P8 
1044 : a5 55 __ LDA T2 + 0 
1046 : 85 0f __ STA P2 
1048 : a5 56 __ LDA T2 + 1 
104a : 85 10 __ STA P3 
104c : a5 46 __ LDA T7 + 0 
104e : 85 11 __ STA P4 
1050 : a5 47 __ LDA T7 + 1 
1052 : 85 12 __ STA P5 
1054 : a5 48 __ LDA T7 + 2 
1056 : 85 13 __ STA P6 
1058 : a9 e0 __ LDA #$e0
105a : 85 0d __ STA P0 
105c : a9 9f __ LDA #$9f
105e : 85 0e __ STA P1 
1060 : 20 69 12 JSR $1269 ; (nforml.s0 + 0)
.s1062:
1063 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
1065 : 85 50 __ STA T0 + 0 
1067 : 4c 93 0c JMP $0c93 ; (sformat.l1 + 0)
.s250:
106a : a9 00 __ LDA #$00
.s221:
106c : 85 13 __ STA P6 
106e : a5 55 __ LDA T2 + 0 
1070 : 85 0f __ STA P2 
1072 : a5 56 __ LDA T2 + 1 
1074 : 85 10 __ STA P3 
1076 : ad fd 9f LDA $9ffd ; (sstack + 5)
1079 : 85 50 __ STA T0 + 0 
107b : ad fe 9f LDA $9ffe ; (sstack + 6)
107e : 85 51 __ STA T0 + 1 
1080 : a0 00 __ LDY #$00
1082 : b1 50 __ LDA (T0 + 0),y 
1084 : 85 11 __ STA P4 
1086 : c8 __ __ INY
1087 : b1 50 __ LDA (T0 + 0),y 
1089 : 85 12 __ STA P5 
108b : 18 __ __ CLC
108c : a5 50 __ LDA T0 + 0 
108e : 69 02 __ ADC #$02
1090 : 8d fd 9f STA $9ffd ; (sstack + 5)
1093 : a5 51 __ LDA T0 + 1 
1095 : 69 00 __ ADC #$00
1097 : 8d fe 9f STA $9ffe ; (sstack + 6)
109a : a9 e0 __ LDA #$e0
109c : 85 0d __ STA P0 
109e : a9 9f __ LDA #$9f
10a0 : 85 0e __ STA P1 
10a2 : 20 0a 11 JSR $110a ; (nformi.s0 + 0)
10a5 : 4c 63 10 JMP $1063 ; (sformat.s1062 + 0)
.s224:
10a8 : a0 00 __ LDY #$00
10aa : b1 53 __ LDA (T1 + 0),y 
10ac : aa __ __ TAX
10ad : 18 __ __ CLC
10ae : a5 53 __ LDA T1 + 0 
10b0 : 69 01 __ ADC #$01
10b2 : 4c 6b 0d JMP $0d6b ; (sformat.l14 + 0)
--------------------------------------------------------------------
puts:
.s0:
10b5 : a0 00 __ LDY #$00
10b7 : b1 0d __ LDA (P0),y 
10b9 : f0 0b __ BEQ $10c6 ; (puts.s1001 + 0)
10bb : 20 c7 10 JSR $10c7 ; (putpch + 0)
10be : e6 0d __ INC P0 
10c0 : d0 f3 __ BNE $10b5 ; (puts.s0 + 0)
10c2 : e6 0e __ INC P1 
10c4 : d0 ef __ BNE $10b5 ; (puts.s0 + 0)
.s1001:
10c6 : 60 __ __ RTS
--------------------------------------------------------------------
putpch:
10c7 : ae 9b 24 LDX $249b ; (giocharmap + 0)
10ca : e0 01 __ CPX #$01
10cc : 90 26 __ BCC $10f4 ; (putpch + 45)
10ce : c9 0a __ CMP #$0a
10d0 : d0 02 __ BNE $10d4 ; (putpch + 13)
10d2 : a9 0d __ LDA #$0d
10d4 : c9 09 __ CMP #$09
10d6 : f0 1f __ BEQ $10f7 ; (putpch + 48)
10d8 : e0 02 __ CPX #$02
10da : 90 18 __ BCC $10f4 ; (putpch + 45)
10dc : c9 41 __ CMP #$41
10de : 90 14 __ BCC $10f4 ; (putpch + 45)
10e0 : c9 7b __ CMP #$7b
10e2 : b0 10 __ BCS $10f4 ; (putpch + 45)
10e4 : c9 61 __ CMP #$61
10e6 : b0 04 __ BCS $10ec ; (putpch + 37)
10e8 : c9 5b __ CMP #$5b
10ea : b0 08 __ BCS $10f4 ; (putpch + 45)
10ec : 49 20 __ EOR #$20
10ee : e0 03 __ CPX #$03
10f0 : f0 02 __ BEQ $10f4 ; (putpch + 45)
10f2 : 29 df __ AND #$df
10f4 : 4c d2 ff JMP $ffd2 
10f7 : 38 __ __ SEC
10f8 : 20 f0 ff JSR $fff0 
10fb : 98 __ __ TYA
10fc : 29 03 __ AND #$03
10fe : 49 03 __ EOR #$03
1100 : aa __ __ TAX
1101 : a9 20 __ LDA #$20
1103 : 20 d2 ff JSR $ffd2 
1106 : ca __ __ DEX
1107 : 10 fa __ BPL $1103 ; (putpch + 60)
1109 : 60 __ __ RTS
--------------------------------------------------------------------
giocharmap:
249b : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
nformi:
.s0:
110a : a9 00 __ LDA #$00
110c : 85 43 __ STA T0 + 0 
110e : a5 13 __ LDA P6 ; (s + 0)
1110 : f0 15 __ BEQ $1127 ; (nformi.s159 + 0)
.s4:
1112 : a5 12 __ LDA P5 ; (v + 1)
1114 : 10 11 __ BPL $1127 ; (nformi.s159 + 0)
.s1:
1116 : 38 __ __ SEC
1117 : a9 00 __ LDA #$00
1119 : e5 11 __ SBC P4 ; (v + 0)
111b : 85 11 __ STA P4 ; (v + 0)
111d : a9 00 __ LDA #$00
111f : e5 12 __ SBC P5 ; (v + 1)
1121 : 85 12 __ STA P5 ; (v + 1)
1123 : a9 01 __ LDA #$01
1125 : 85 43 __ STA T0 + 0 
.s159:
1127 : a9 10 __ LDA #$10
1129 : 85 44 __ STA T2 + 0 
112b : a5 11 __ LDA P4 ; (v + 0)
112d : 05 12 __ ORA P5 ; (v + 1)
112f : f0 61 __ BEQ $1192 ; (nformi.s7 + 0)
.s45:
1131 : a5 0d __ LDA P0 ; (si + 0)
1133 : 85 45 __ STA T4 + 0 
1135 : a5 0e __ LDA P1 ; (si + 1)
1137 : 85 46 __ STA T4 + 1 
.l6:
1139 : a0 03 __ LDY #$03
113b : b1 45 __ LDA (T4 + 0),y 
113d : 85 47 __ STA T5 + 0 
113f : 85 03 __ STA WORK + 0 
1141 : c8 __ __ INY
1142 : b1 45 __ LDA (T4 + 0),y 
1144 : 85 48 __ STA T5 + 1 
1146 : 85 04 __ STA WORK + 1 
1148 : a5 11 __ LDA P4 ; (v + 0)
114a : 85 1b __ STA ACCU + 0 
114c : a5 12 __ LDA P5 ; (v + 1)
114e : 85 1c __ STA ACCU + 1 
1150 : 20 4a 22 JSR $224a ; (divmod + 0)
1153 : a5 06 __ LDA WORK + 3 
1155 : 30 10 __ BMI $1167 ; (nformi.s9 + 0)
.s1019:
1157 : d0 06 __ BNE $115f ; (nformi.s8 + 0)
.s1018:
1159 : a5 05 __ LDA WORK + 2 
115b : c9 0a __ CMP #$0a
115d : 90 08 __ BCC $1167 ; (nformi.s9 + 0)
.s8:
115f : 18 __ __ CLC
1160 : a5 05 __ LDA WORK + 2 
1162 : 69 37 __ ADC #$37
1164 : 4c 6c 11 JMP $116c ; (nformi.s10 + 0)
.s9:
1167 : 18 __ __ CLC
1168 : a5 05 __ LDA WORK + 2 
116a : 69 30 __ ADC #$30
.s10:
116c : c6 44 __ DEC T2 + 0 
116e : a6 44 __ LDX T2 + 0 
1170 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1173 : a5 11 __ LDA P4 ; (v + 0)
1175 : 85 1b __ STA ACCU + 0 
1177 : a5 12 __ LDA P5 ; (v + 1)
1179 : 85 1c __ STA ACCU + 1 
117b : a5 47 __ LDA T5 + 0 
117d : 85 03 __ STA WORK + 0 
117f : a5 48 __ LDA T5 + 1 
1181 : 85 04 __ STA WORK + 1 
1183 : 20 4a 22 JSR $224a ; (divmod + 0)
1186 : a5 1b __ LDA ACCU + 0 
1188 : 85 11 __ STA P4 ; (v + 0)
118a : a5 1c __ LDA ACCU + 1 
118c : 85 12 __ STA P5 ; (v + 1)
118e : 05 11 __ ORA P4 ; (v + 0)
1190 : d0 a7 __ BNE $1139 ; (nformi.l6 + 0)
.s7:
1192 : a5 0d __ LDA P0 ; (si + 0)
1194 : 85 11 __ STA P4 ; (v + 0)
1196 : a5 0e __ LDA P1 ; (si + 1)
1198 : 85 12 __ STA P5 ; (v + 1)
119a : a0 02 __ LDY #$02
119c : b1 0d __ LDA (P0),y ; (si + 0)
119e : c9 ff __ CMP #$ff
11a0 : d0 04 __ BNE $11a6 ; (nformi.s76 + 0)
.s77:
11a2 : a9 0f __ LDA #$0f
11a4 : d0 05 __ BNE $11ab ; (nformi.s1026 + 0)
.s76:
11a6 : 38 __ __ SEC
11a7 : a9 10 __ LDA #$10
11a9 : f1 0d __ SBC (P0),y ; (si + 0)
.s1026:
11ab : a8 __ __ TAY
11ac : c4 44 __ CPY T2 + 0 
11ae : b0 0d __ BCS $11bd ; (nformi.s13 + 0)
.s12:
11b0 : a9 30 __ LDA #$30
.l1027:
11b2 : c6 44 __ DEC T2 + 0 
11b4 : a6 44 __ LDX T2 + 0 
11b6 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
11b9 : c4 44 __ CPY T2 + 0 
11bb : 90 f5 __ BCC $11b2 ; (nformi.l1027 + 0)
.s13:
11bd : a0 07 __ LDY #$07
11bf : b1 0d __ LDA (P0),y ; (si + 0)
11c1 : f0 20 __ BEQ $11e3 ; (nformi.s16 + 0)
.s17:
11c3 : a0 04 __ LDY #$04
11c5 : b1 0d __ LDA (P0),y ; (si + 0)
11c7 : d0 1a __ BNE $11e3 ; (nformi.s16 + 0)
.s1013:
11c9 : 88 __ __ DEY
11ca : b1 0d __ LDA (P0),y ; (si + 0)
11cc : c9 10 __ CMP #$10
11ce : d0 13 __ BNE $11e3 ; (nformi.s16 + 0)
.s14:
11d0 : a9 58 __ LDA #$58
11d2 : a6 44 __ LDX T2 + 0 
11d4 : 9d e7 9f STA $9fe7,x ; (si + 7)
11d7 : 8a __ __ TXA
11d8 : 18 __ __ CLC
11d9 : 69 fe __ ADC #$fe
11db : 85 44 __ STA T2 + 0 
11dd : aa __ __ TAX
11de : a9 30 __ LDA #$30
11e0 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s16:
11e3 : a9 00 __ LDA #$00
11e5 : 85 1b __ STA ACCU + 0 
11e7 : a5 43 __ LDA T0 + 0 
11e9 : f0 06 __ BEQ $11f1 ; (nformi.s19 + 0)
.s18:
11eb : c6 44 __ DEC T2 + 0 
11ed : a9 2d __ LDA #$2d
11ef : d0 0a __ BNE $11fb ; (nformi.s1025 + 0)
.s19:
11f1 : a0 05 __ LDY #$05
11f3 : b1 0d __ LDA (P0),y ; (si + 0)
11f5 : f0 09 __ BEQ $1200 ; (nformi.s141 + 0)
.s21:
11f7 : c6 44 __ DEC T2 + 0 
11f9 : a9 2b __ LDA #$2b
.s1025:
11fb : a6 44 __ LDX T2 + 0 
11fd : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s141:
1200 : a0 06 __ LDY #$06
1202 : b1 0d __ LDA (P0),y ; (si + 0)
1204 : d0 37 __ BNE $123d ; (nformi.s27 + 0)
.l33:
1206 : a0 01 __ LDY #$01
1208 : b1 11 __ LDA (P4),y ; (v + 0)
120a : 18 __ __ CLC
120b : 65 44 __ ADC T2 + 0 
120d : b0 04 __ BCS $1213 ; (nformi.s34 + 0)
.s1006:
120f : c9 11 __ CMP #$11
1211 : 90 0e __ BCC $1221 ; (nformi.s36 + 0)
.s34:
1213 : c6 44 __ DEC T2 + 0 
1215 : a0 00 __ LDY #$00
1217 : b1 11 __ LDA (P4),y ; (v + 0)
1219 : a6 44 __ LDX T2 + 0 
121b : 9d e8 9f STA $9fe8,x ; (buffer + 0)
121e : 4c 06 12 JMP $1206 ; (nformi.l33 + 0)
.s36:
1221 : a6 44 __ LDX T2 + 0 
1223 : e0 10 __ CPX #$10
1225 : b0 11 __ BCS $1238 ; (nformi.s26 + 0)
.s1022:
1227 : 88 __ __ DEY
.l1031:
1228 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
122b : 91 0f __ STA (P2),y ; (str + 0)
122d : e6 44 __ INC T2 + 0 
122f : a6 44 __ LDX T2 + 0 
1231 : e0 10 __ CPX #$10
1233 : c8 __ __ INY
1234 : 90 f2 __ BCC $1228 ; (nformi.l1031 + 0)
.s1032:
1236 : 84 1b __ STY ACCU + 0 
.s26:
1238 : a9 00 __ LDA #$00
123a : 85 1c __ STA ACCU + 1 
.s1001:
123c : 60 __ __ RTS
.s27:
123d : a6 44 __ LDX T2 + 0 
123f : e0 10 __ CPX #$10
1241 : b0 12 __ BCS $1255 ; (nformi.l30 + 0)
.s1020:
1243 : a0 00 __ LDY #$00
.l1029:
1245 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
1248 : 91 0f __ STA (P2),y ; (str + 0)
124a : e6 44 __ INC T2 + 0 
124c : a6 44 __ LDX T2 + 0 
124e : e0 10 __ CPX #$10
1250 : c8 __ __ INY
1251 : 90 f2 __ BCC $1245 ; (nformi.l1029 + 0)
.s1030:
1253 : 84 1b __ STY ACCU + 0 
.l30:
1255 : a5 1b __ LDA ACCU + 0 
1257 : a0 01 __ LDY #$01
1259 : d1 11 __ CMP (P4),y ; (v + 0)
125b : b0 db __ BCS $1238 ; (nformi.s26 + 0)
.s31:
125d : 88 __ __ DEY
125e : b1 11 __ LDA (P4),y ; (v + 0)
1260 : a4 1b __ LDY ACCU + 0 
1262 : 91 0f __ STA (P2),y ; (str + 0)
1264 : e6 1b __ INC ACCU + 0 
1266 : 4c 55 12 JMP $1255 ; (nformi.l30 + 0)
--------------------------------------------------------------------
nforml:
.s0:
1269 : a9 00 __ LDA #$00
126b : 85 43 __ STA T0 + 0 
126d : a5 15 __ LDA P8 ; (s + 0)
126f : f0 23 __ BEQ $1294 ; (nforml.s159 + 0)
.s4:
1271 : a5 14 __ LDA P7 ; (v + 3)
1273 : f0 1f __ BEQ $1294 ; (nforml.s159 + 0)
.s1032:
1275 : 10 1d __ BPL $1294 ; (nforml.s159 + 0)
.s1:
1277 : 38 __ __ SEC
1278 : a9 00 __ LDA #$00
127a : e5 11 __ SBC P4 ; (v + 0)
127c : 85 11 __ STA P4 ; (v + 0)
127e : a9 00 __ LDA #$00
1280 : e5 12 __ SBC P5 ; (v + 1)
1282 : 85 12 __ STA P5 ; (v + 1)
1284 : a9 00 __ LDA #$00
1286 : e5 13 __ SBC P6 ; (v + 2)
1288 : 85 13 __ STA P6 ; (v + 2)
128a : a9 00 __ LDA #$00
128c : e5 14 __ SBC P7 ; (v + 3)
128e : 85 14 __ STA P7 ; (v + 3)
1290 : a9 01 __ LDA #$01
1292 : 85 43 __ STA T0 + 0 
.s159:
1294 : a9 10 __ LDA #$10
1296 : 85 44 __ STA T2 + 0 
1298 : a5 14 __ LDA P7 ; (v + 3)
129a : f0 03 __ BEQ $129f ; (nforml.s1018 + 0)
129c : 4c 83 13 JMP $1383 ; (nforml.l6 + 0)
.s1018:
129f : a5 13 __ LDA P6 ; (v + 2)
12a1 : f0 03 __ BEQ $12a6 ; (nforml.s1019 + 0)
12a3 : 4c 83 13 JMP $1383 ; (nforml.l6 + 0)
.s1019:
12a6 : a5 12 __ LDA P5 ; (v + 1)
12a8 : f0 03 __ BEQ $12ad ; (nforml.s1020 + 0)
12aa : 4c 83 13 JMP $1383 ; (nforml.l6 + 0)
.s1020:
12ad : c5 11 __ CMP P4 ; (v + 0)
12af : b0 03 __ BCS $12b4 ; (nforml.s7 + 0)
12b1 : 4c 83 13 JMP $1383 ; (nforml.l6 + 0)
.s7:
12b4 : a0 02 __ LDY #$02
12b6 : b1 0d __ LDA (P0),y ; (si + 0)
12b8 : c9 ff __ CMP #$ff
12ba : d0 04 __ BNE $12c0 ; (nforml.s76 + 0)
.s77:
12bc : a9 0f __ LDA #$0f
12be : d0 05 __ BNE $12c5 ; (nforml.s1039 + 0)
.s76:
12c0 : 38 __ __ SEC
12c1 : a9 10 __ LDA #$10
12c3 : f1 0d __ SBC (P0),y ; (si + 0)
.s1039:
12c5 : a8 __ __ TAY
12c6 : c4 44 __ CPY T2 + 0 
12c8 : b0 0d __ BCS $12d7 ; (nforml.s13 + 0)
.s12:
12ca : a9 30 __ LDA #$30
.l1040:
12cc : c6 44 __ DEC T2 + 0 
12ce : a6 44 __ LDX T2 + 0 
12d0 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
12d3 : c4 44 __ CPY T2 + 0 
12d5 : 90 f5 __ BCC $12cc ; (nforml.l1040 + 0)
.s13:
12d7 : a0 07 __ LDY #$07
12d9 : b1 0d __ LDA (P0),y ; (si + 0)
12db : f0 20 __ BEQ $12fd ; (nforml.s16 + 0)
.s17:
12dd : a0 04 __ LDY #$04
12df : b1 0d __ LDA (P0),y ; (si + 0)
12e1 : d0 1a __ BNE $12fd ; (nforml.s16 + 0)
.s1013:
12e3 : 88 __ __ DEY
12e4 : b1 0d __ LDA (P0),y ; (si + 0)
12e6 : c9 10 __ CMP #$10
12e8 : d0 13 __ BNE $12fd ; (nforml.s16 + 0)
.s14:
12ea : a9 58 __ LDA #$58
12ec : a6 44 __ LDX T2 + 0 
12ee : 9d e7 9f STA $9fe7,x ; (si + 7)
12f1 : 8a __ __ TXA
12f2 : 18 __ __ CLC
12f3 : 69 fe __ ADC #$fe
12f5 : 85 44 __ STA T2 + 0 
12f7 : aa __ __ TAX
12f8 : a9 30 __ LDA #$30
12fa : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s16:
12fd : a9 00 __ LDA #$00
12ff : 85 1b __ STA ACCU + 0 
1301 : a5 43 __ LDA T0 + 0 
1303 : f0 06 __ BEQ $130b ; (nforml.s19 + 0)
.s18:
1305 : c6 44 __ DEC T2 + 0 
1307 : a9 2d __ LDA #$2d
1309 : d0 0a __ BNE $1315 ; (nforml.s1038 + 0)
.s19:
130b : a0 05 __ LDY #$05
130d : b1 0d __ LDA (P0),y ; (si + 0)
130f : f0 09 __ BEQ $131a ; (nforml.s141 + 0)
.s21:
1311 : c6 44 __ DEC T2 + 0 
1313 : a9 2b __ LDA #$2b
.s1038:
1315 : a6 44 __ LDX T2 + 0 
1317 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s141:
131a : a0 06 __ LDY #$06
131c : b1 0d __ LDA (P0),y ; (si + 0)
131e : d0 37 __ BNE $1357 ; (nforml.s27 + 0)
.l33:
1320 : a0 01 __ LDY #$01
1322 : b1 0d __ LDA (P0),y ; (si + 0)
1324 : 18 __ __ CLC
1325 : 65 44 __ ADC T2 + 0 
1327 : b0 04 __ BCS $132d ; (nforml.s34 + 0)
.s1006:
1329 : c9 11 __ CMP #$11
132b : 90 0e __ BCC $133b ; (nforml.s36 + 0)
.s34:
132d : c6 44 __ DEC T2 + 0 
132f : a0 00 __ LDY #$00
1331 : b1 0d __ LDA (P0),y ; (si + 0)
1333 : a6 44 __ LDX T2 + 0 
1335 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1338 : 4c 20 13 JMP $1320 ; (nforml.l33 + 0)
.s36:
133b : a6 44 __ LDX T2 + 0 
133d : e0 10 __ CPX #$10
133f : b0 11 __ BCS $1352 ; (nforml.s26 + 0)
.s1035:
1341 : 88 __ __ DEY
.l1044:
1342 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
1345 : 91 0f __ STA (P2),y ; (str + 0)
1347 : e6 44 __ INC T2 + 0 
1349 : a6 44 __ LDX T2 + 0 
134b : e0 10 __ CPX #$10
134d : c8 __ __ INY
134e : 90 f2 __ BCC $1342 ; (nforml.l1044 + 0)
.s1045:
1350 : 84 1b __ STY ACCU + 0 
.s26:
1352 : a9 00 __ LDA #$00
1354 : 85 1c __ STA ACCU + 1 
.s1001:
1356 : 60 __ __ RTS
.s27:
1357 : a6 44 __ LDX T2 + 0 
1359 : e0 10 __ CPX #$10
135b : b0 12 __ BCS $136f ; (nforml.l30 + 0)
.s1033:
135d : a0 00 __ LDY #$00
.l1042:
135f : bd e8 9f LDA $9fe8,x ; (buffer + 0)
1362 : 91 0f __ STA (P2),y ; (str + 0)
1364 : e6 44 __ INC T2 + 0 
1366 : a6 44 __ LDX T2 + 0 
1368 : e0 10 __ CPX #$10
136a : c8 __ __ INY
136b : 90 f2 __ BCC $135f ; (nforml.l1042 + 0)
.s1043:
136d : 84 1b __ STY ACCU + 0 
.l30:
136f : a5 1b __ LDA ACCU + 0 
1371 : a0 01 __ LDY #$01
1373 : d1 0d __ CMP (P0),y ; (si + 0)
1375 : b0 db __ BCS $1352 ; (nforml.s26 + 0)
.s31:
1377 : 88 __ __ DEY
1378 : b1 0d __ LDA (P0),y ; (si + 0)
137a : a4 1b __ LDY ACCU + 0 
137c : 91 0f __ STA (P2),y ; (str + 0)
137e : e6 1b __ INC ACCU + 0 
1380 : 4c 6f 13 JMP $136f ; (nforml.l30 + 0)
.l6:
1383 : a0 03 __ LDY #$03
1385 : b1 0d __ LDA (P0),y ; (si + 0)
1387 : 85 03 __ STA WORK + 0 
1389 : 85 45 __ STA T6 + 0 
138b : c8 __ __ INY
138c : b1 0d __ LDA (P0),y ; (si + 0)
138e : 85 46 __ STA T6 + 1 
1390 : 85 04 __ STA WORK + 1 
1392 : a5 11 __ LDA P4 ; (v + 0)
1394 : 85 1b __ STA ACCU + 0 
1396 : a5 12 __ LDA P5 ; (v + 1)
1398 : 85 1c __ STA ACCU + 1 
139a : a5 13 __ LDA P6 ; (v + 2)
139c : 85 1d __ STA ACCU + 2 
139e : a5 14 __ LDA P7 ; (v + 3)
13a0 : 85 1e __ STA ACCU + 3 
13a2 : a9 00 __ LDA #$00
13a4 : 85 05 __ STA WORK + 2 
13a6 : 85 06 __ STA WORK + 3 
13a8 : 20 85 23 JSR $2385 ; (divmod32 + 0)
13ab : a5 08 __ LDA WORK + 5 
13ad : 30 10 __ BMI $13bf ; (nforml.s9 + 0)
.s1023:
13af : d0 06 __ BNE $13b7 ; (nforml.s8 + 0)
.s1022:
13b1 : a5 07 __ LDA WORK + 4 
13b3 : c9 0a __ CMP #$0a
13b5 : 90 08 __ BCC $13bf ; (nforml.s9 + 0)
.s8:
13b7 : 18 __ __ CLC
13b8 : a5 07 __ LDA WORK + 4 
13ba : 69 37 __ ADC #$37
13bc : 4c c4 13 JMP $13c4 ; (nforml.s10 + 0)
.s9:
13bf : 18 __ __ CLC
13c0 : a5 07 __ LDA WORK + 4 
13c2 : 69 30 __ ADC #$30
.s10:
13c4 : c6 44 __ DEC T2 + 0 
13c6 : a6 44 __ LDX T2 + 0 
13c8 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
13cb : a5 11 __ LDA P4 ; (v + 0)
13cd : 85 1b __ STA ACCU + 0 
13cf : a5 12 __ LDA P5 ; (v + 1)
13d1 : 85 1c __ STA ACCU + 1 
13d3 : a5 13 __ LDA P6 ; (v + 2)
13d5 : 85 1d __ STA ACCU + 2 
13d7 : a5 14 __ LDA P7 ; (v + 3)
13d9 : 85 1e __ STA ACCU + 3 
13db : a5 45 __ LDA T6 + 0 
13dd : 85 03 __ STA WORK + 0 
13df : a5 46 __ LDA T6 + 1 
13e1 : 85 04 __ STA WORK + 1 
13e3 : a9 00 __ LDA #$00
13e5 : 85 05 __ STA WORK + 2 
13e7 : 85 06 __ STA WORK + 3 
13e9 : 20 85 23 JSR $2385 ; (divmod32 + 0)
13ec : a5 1b __ LDA ACCU + 0 
13ee : 85 11 __ STA P4 ; (v + 0)
13f0 : a5 1c __ LDA ACCU + 1 
13f2 : 85 12 __ STA P5 ; (v + 1)
13f4 : a5 1d __ LDA ACCU + 2 
13f6 : 85 13 __ STA P6 ; (v + 2)
13f8 : a5 1e __ LDA ACCU + 3 
13fa : 85 14 __ STA P7 ; (v + 3)
13fc : d0 85 __ BNE $1383 ; (nforml.l6 + 0)
13fe : 4c 9f 12 JMP $129f ; (nforml.s1018 + 0)
--------------------------------------------------------------------
nformf:
.s0:
1401 : a5 15 __ LDA P8 ; (f + 0)
1403 : 85 43 __ STA T1 + 0 
1405 : a5 16 __ LDA P9 ; (f + 1)
1407 : 85 44 __ STA T1 + 1 
1409 : a5 17 __ LDA P10 ; (f + 2)
140b : 85 45 __ STA T1 + 2 
140d : a5 18 __ LDA P11 ; (f + 3)
140f : 29 7f __ AND #$7f
1411 : 05 17 __ ORA P10 ; (f + 2)
1413 : 05 16 __ ORA P9 ; (f + 1)
1415 : 05 15 __ ORA P8 ; (f + 0)
1417 : f0 21 __ BEQ $143a ; (nformf.s2 + 0)
.s1005:
1419 : a5 18 __ LDA P11 ; (f + 3)
141b : 10 1d __ BPL $143a ; (nformf.s2 + 0)
.s1:
141d : a9 2d __ LDA #$2d
141f : a0 00 __ LDY #$00
1421 : 91 13 __ STA (P6),y ; (str + 0)
1423 : a5 18 __ LDA P11 ; (f + 3)
1425 : 49 80 __ EOR #$80
1427 : 85 18 __ STA P11 ; (f + 3)
1429 : 85 10 __ STA P3 
142b : a5 15 __ LDA P8 ; (f + 0)
142d : 85 0d __ STA P0 
142f : a5 16 __ LDA P9 ; (f + 1)
1431 : 85 0e __ STA P1 
1433 : a5 17 __ LDA P10 ; (f + 2)
1435 : 85 0f __ STA P2 
1437 : 4c ba 18 JMP $18ba ; (nformf.s189 + 0)
.s2:
143a : a5 15 __ LDA P8 ; (f + 0)
143c : 85 0d __ STA P0 
143e : a5 16 __ LDA P9 ; (f + 1)
1440 : 85 0e __ STA P1 
1442 : a5 17 __ LDA P10 ; (f + 2)
1444 : 85 0f __ STA P2 
1446 : a5 18 __ LDA P11 ; (f + 3)
1448 : 85 10 __ STA P3 
144a : a0 05 __ LDY #$05
144c : b1 11 __ LDA (P4),y ; (si + 0)
144e : f0 09 __ BEQ $1459 ; (nformf.s3 + 0)
.s4:
1450 : a9 2b __ LDA #$2b
1452 : a0 00 __ LDY #$00
1454 : 91 13 __ STA (P6),y ; (str + 0)
1456 : 4c ba 18 JMP $18ba ; (nformf.s189 + 0)
.s3:
1459 : 20 d2 18 JSR $18d2 ; (isinf.s0 + 0)
145c : aa __ __ TAX
145d : a9 00 __ LDA #$00
145f : 85 48 __ STA T3 + 0 
1461 : 8a __ __ TXA
1462 : f0 0b __ BEQ $146f ; (nformf.s8 + 0)
.s160:
1464 : a9 01 __ LDA #$01
1466 : 85 4a __ STA T5 + 0 
1468 : a9 02 __ LDA #$02
146a : a0 00 __ LDY #$00
146c : 4c 9e 18 JMP $189e ; (nformf.s7 + 0)
.s8:
146f : a0 02 __ LDY #$02
1471 : b1 11 __ LDA (P4),y ; (si + 0)
1473 : c9 ff __ CMP #$ff
1475 : d0 02 __ BNE $1479 ; (nformf.s128 + 0)
.s129:
1477 : a9 06 __ LDA #$06
.s128:
1479 : 86 4a __ STX T5 + 0 
147b : 86 4b __ STX T5 + 1 
147d : 85 49 __ STA T4 + 0 
147f : 85 47 __ STA T2 + 0 
1481 : a5 18 __ LDA P11 ; (f + 3)
1483 : 85 46 __ STA T1 + 3 
1485 : 29 7f __ AND #$7f
1487 : 05 17 __ ORA P10 ; (f + 2)
1489 : 05 16 __ ORA P9 ; (f + 1)
148b : 05 15 __ ORA P8 ; (f + 0)
148d : f0 03 __ BEQ $1492 ; (nformf.s12 + 0)
148f : 4c 9f 17 JMP $179f ; (nformf.s13 + 0)
.s12:
1492 : ad f8 9f LDA $9ff8 ; (sstack + 0)
1495 : c9 65 __ CMP #$65
1497 : d0 04 __ BNE $149d ; (nformf.s1007 + 0)
.s1006:
1499 : a9 01 __ LDA #$01
149b : d0 02 __ BNE $149f ; (nformf.s1008 + 0)
.s1007:
149d : a9 00 __ LDA #$00
.s1008:
149f : 85 4e __ STA T9 + 0 
14a1 : a6 49 __ LDX T4 + 0 
14a3 : e8 __ __ INX
14a4 : 86 4c __ STX T8 + 0 
14a6 : ad f8 9f LDA $9ff8 ; (sstack + 0)
14a9 : c9 67 __ CMP #$67
14ab : d0 13 __ BNE $14c0 ; (nformf.s24 + 0)
.s22:
14ad : a5 4b __ LDA T5 + 1 
14af : 30 08 __ BMI $14b9 ; (nformf.s25 + 0)
.s1050:
14b1 : d0 06 __ BNE $14b9 ; (nformf.s25 + 0)
.s1049:
14b3 : a5 4a __ LDA T5 + 0 
14b5 : c9 04 __ CMP #$04
14b7 : 90 07 __ BCC $14c0 ; (nformf.s24 + 0)
.s25:
14b9 : a9 01 __ LDA #$01
14bb : 85 4e __ STA T9 + 0 
14bd : 4c 17 17 JMP $1717 ; (nformf.s30 + 0)
.s24:
14c0 : a5 4e __ LDA T9 + 0 
14c2 : f0 03 __ BEQ $14c7 ; (nformf.s32 + 0)
14c4 : 4c 17 17 JMP $1717 ; (nformf.s30 + 0)
.s32:
14c7 : a5 4b __ LDA T5 + 1 
14c9 : 10 3e __ BPL $1509 ; (nformf.s34 + 0)
.s33:
14cb : a5 43 __ LDA T1 + 0 
14cd : 85 1b __ STA ACCU + 0 
14cf : a5 44 __ LDA T1 + 1 
14d1 : 85 1c __ STA ACCU + 1 
14d3 : a5 45 __ LDA T1 + 2 
14d5 : 85 1d __ STA ACCU + 2 
14d7 : a5 46 __ LDA T1 + 3 
14d9 : 85 1e __ STA ACCU + 3 
.l1085:
14db : e6 4a __ INC T5 + 0 
14dd : d0 02 __ BNE $14e1 ; (nformf.s1095 + 0)
.s1094:
14df : e6 4b __ INC T5 + 1 
.s1095:
14e1 : a9 00 __ LDA #$00
14e3 : 85 03 __ STA WORK + 0 
14e5 : 85 04 __ STA WORK + 1 
14e7 : a9 20 __ LDA #$20
14e9 : 85 05 __ STA WORK + 2 
14eb : a9 41 __ LDA #$41
14ed : 85 06 __ STA WORK + 3 
14ef : 20 7b 1f JSR $1f7b ; (freg + 20)
14f2 : 20 62 21 JSR $2162 ; (fdiv + 0)
14f5 : a5 4b __ LDA T5 + 1 
14f7 : 30 e2 __ BMI $14db ; (nformf.l1085 + 0)
.s1086:
14f9 : a5 1e __ LDA ACCU + 3 
14fb : 85 46 __ STA T1 + 3 
14fd : a5 1d __ LDA ACCU + 2 
14ff : 85 45 __ STA T1 + 2 
1501 : a5 1c __ LDA ACCU + 1 
1503 : 85 44 __ STA T1 + 1 
1505 : a5 1b __ LDA ACCU + 0 
1507 : 85 43 __ STA T1 + 0 
.s34:
1509 : 18 __ __ CLC
150a : a5 49 __ LDA T4 + 0 
150c : 65 4a __ ADC T5 + 0 
150e : 18 __ __ CLC
150f : 69 01 __ ADC #$01
1511 : 85 4c __ STA T8 + 0 
1513 : c9 07 __ CMP #$07
1515 : 90 13 __ BCC $152a ; (nformf.s35 + 0)
.s36:
1517 : ad b5 24 LDA $24b5 ; (fround5 + 25)
151a : 85 1c __ STA ACCU + 1 
151c : ad b6 24 LDA $24b6 ; (fround5 + 26)
151f : 85 1d __ STA ACCU + 2 
1521 : ad b7 24 LDA $24b7 ; (fround5 + 27)
1524 : ae b4 24 LDX $24b4 ; (fround5 + 24)
1527 : 4c 3d 15 JMP $153d ; (nformf.s214 + 0)
.s35:
152a : 0a __ __ ASL
152b : 0a __ __ ASL
152c : a8 __ __ TAY
152d : b9 99 24 LDA $2499,y ; (p2smap + 6)
1530 : 85 1c __ STA ACCU + 1 
1532 : b9 9a 24 LDA $249a,y ; (p2smap + 7)
1535 : 85 1d __ STA ACCU + 2 
1537 : b9 9b 24 LDA $249b,y ; (giocharmap + 0)
153a : be 98 24 LDX $2498,y ; (p2smap + 5)
.s214:
153d : 86 1b __ STX ACCU + 0 
153f : 85 1e __ STA ACCU + 3 
1541 : a2 43 __ LDX #$43
1543 : 20 6b 1f JSR $1f6b ; (freg + 4)
1546 : 20 ac 1f JSR $1fac ; (faddsub + 0)
1549 : a5 1c __ LDA ACCU + 1 
154b : 85 16 __ STA P9 ; (f + 1)
154d : a5 1d __ LDA ACCU + 2 
154f : 85 17 __ STA P10 ; (f + 2)
1551 : a6 1b __ LDX ACCU + 0 
1553 : a5 1e __ LDA ACCU + 3 
1555 : 85 18 __ STA P11 ; (f + 3)
1557 : 30 35 __ BMI $158e ; (nformf.s31 + 0)
.s1032:
1559 : c9 41 __ CMP #$41
155b : d0 06 __ BNE $1563 ; (nformf.s1036 + 0)
.s1033:
155d : a5 17 __ LDA P10 ; (f + 2)
155f : c9 20 __ CMP #$20
1561 : f0 02 __ BEQ $1565 ; (nformf.s38 + 0)
.s1036:
1563 : 90 29 __ BCC $158e ; (nformf.s31 + 0)
.s38:
1565 : a9 00 __ LDA #$00
1567 : 85 03 __ STA WORK + 0 
1569 : 85 04 __ STA WORK + 1 
156b : a9 20 __ LDA #$20
156d : 85 05 __ STA WORK + 2 
156f : a9 41 __ LDA #$41
1571 : 85 06 __ STA WORK + 3 
1573 : 20 7b 1f JSR $1f7b ; (freg + 20)
1576 : 20 62 21 JSR $2162 ; (fdiv + 0)
1579 : a5 1c __ LDA ACCU + 1 
157b : 85 16 __ STA P9 ; (f + 1)
157d : a5 1d __ LDA ACCU + 2 
157f : 85 17 __ STA P10 ; (f + 2)
1581 : a5 1e __ LDA ACCU + 3 
1583 : 85 18 __ STA P11 ; (f + 3)
1585 : 18 __ __ CLC
1586 : a5 49 __ LDA T4 + 0 
1588 : 69 ff __ ADC #$ff
158a : 85 47 __ STA T2 + 0 
158c : a6 1b __ LDX ACCU + 0 
.s31:
158e : 38 __ __ SEC
158f : a5 4c __ LDA T8 + 0 
1591 : e5 47 __ SBC T2 + 0 
1593 : 85 49 __ STA T4 + 0 
1595 : a9 14 __ LDA #$14
1597 : c5 4c __ CMP T8 + 0 
1599 : b0 02 __ BCS $159d ; (nformf.s49 + 0)
.s47:
159b : 85 4c __ STA T8 + 0 
.s49:
159d : a5 49 __ LDA T4 + 0 
159f : d0 08 __ BNE $15a9 ; (nformf.s219 + 0)
.s50:
15a1 : a9 30 __ LDA #$30
15a3 : a4 48 __ LDY T3 + 0 
15a5 : 91 13 __ STA (P6),y ; (str + 0)
15a7 : e6 48 __ INC T3 + 0 
.s219:
15a9 : a9 00 __ LDA #$00
15ab : 85 47 __ STA T2 + 0 
15ad : c5 49 __ CMP T4 + 0 
15af : d0 08 __ BNE $15b9 ; (nformf.l59 + 0)
.l57:
15b1 : a9 2e __ LDA #$2e
15b3 : a4 48 __ LDY T3 + 0 
15b5 : 91 13 __ STA (P6),y ; (str + 0)
15b7 : e6 48 __ INC T3 + 0 
.l59:
15b9 : a5 47 __ LDA T2 + 0 
15bb : c9 07 __ CMP #$07
15bd : 90 04 __ BCC $15c3 ; (nformf.s61 + 0)
.s60:
15bf : a9 30 __ LDA #$30
15c1 : d0 55 __ BNE $1618 ; (nformf.s208 + 0)
.s61:
15c3 : 86 1b __ STX ACCU + 0 
15c5 : 86 43 __ STX T1 + 0 
15c7 : a5 16 __ LDA P9 ; (f + 1)
15c9 : 85 1c __ STA ACCU + 1 
15cb : 85 44 __ STA T1 + 1 
15cd : a5 17 __ LDA P10 ; (f + 2)
15cf : 85 1d __ STA ACCU + 2 
15d1 : 85 45 __ STA T1 + 2 
15d3 : a5 18 __ LDA P11 ; (f + 3)
15d5 : 85 1e __ STA ACCU + 3 
15d7 : 85 46 __ STA T1 + 3 
15d9 : 20 f8 22 JSR $22f8 ; (f32_to_i16 + 0)
15dc : a5 1b __ LDA ACCU + 0 
15de : 85 4f __ STA T11 + 0 
15e0 : 20 3a 23 JSR $233a ; (sint16_to_float + 0)
15e3 : a2 43 __ LDX #$43
15e5 : 20 6b 1f JSR $1f6b ; (freg + 4)
15e8 : a5 1e __ LDA ACCU + 3 
15ea : 49 80 __ EOR #$80
15ec : 85 1e __ STA ACCU + 3 
15ee : 20 ac 1f JSR $1fac ; (faddsub + 0)
15f1 : a9 00 __ LDA #$00
15f3 : 85 03 __ STA WORK + 0 
15f5 : 85 04 __ STA WORK + 1 
15f7 : a9 20 __ LDA #$20
15f9 : 85 05 __ STA WORK + 2 
15fb : a9 41 __ LDA #$41
15fd : 85 06 __ STA WORK + 3 
15ff : 20 7b 1f JSR $1f7b ; (freg + 20)
1602 : 20 93 20 JSR $2093 ; (fmul + 0)
1605 : a5 1c __ LDA ACCU + 1 
1607 : 85 16 __ STA P9 ; (f + 1)
1609 : a5 1d __ LDA ACCU + 2 
160b : 85 17 __ STA P10 ; (f + 2)
160d : a5 1e __ LDA ACCU + 3 
160f : 85 18 __ STA P11 ; (f + 3)
1611 : 18 __ __ CLC
1612 : a5 4f __ LDA T11 + 0 
1614 : 69 30 __ ADC #$30
1616 : a6 1b __ LDX ACCU + 0 
.s208:
1618 : a4 48 __ LDY T3 + 0 
161a : 91 13 __ STA (P6),y ; (str + 0)
161c : e6 48 __ INC T3 + 0 
161e : e6 47 __ INC T2 + 0 
1620 : a5 47 __ LDA T2 + 0 
1622 : c5 4c __ CMP T8 + 0 
1624 : b0 07 __ BCS $162d ; (nformf.s56 + 0)
.s54:
1626 : c5 49 __ CMP T4 + 0 
1628 : d0 8f __ BNE $15b9 ; (nformf.l59 + 0)
162a : 4c b1 15 JMP $15b1 ; (nformf.l57 + 0)
.s56:
162d : a5 4e __ LDA T9 + 0 
162f : f0 62 __ BEQ $1693 ; (nformf.s9 + 0)
.s63:
1631 : a9 45 __ LDA #$45
1633 : a4 48 __ LDY T3 + 0 
1635 : 91 13 __ STA (P6),y ; (str + 0)
1637 : c8 __ __ INY
1638 : a5 4b __ LDA T5 + 1 
163a : 30 06 __ BMI $1642 ; (nformf.s66 + 0)
.s67:
163c : a9 2b __ LDA #$2b
163e : 91 13 __ STA (P6),y ; (str + 0)
1640 : d0 11 __ BNE $1653 ; (nformf.s68 + 0)
.s66:
1642 : a9 2d __ LDA #$2d
1644 : 91 13 __ STA (P6),y ; (str + 0)
1646 : 38 __ __ SEC
1647 : a9 00 __ LDA #$00
1649 : e5 4a __ SBC T5 + 0 
164b : 85 4a __ STA T5 + 0 
164d : a9 00 __ LDA #$00
164f : e5 4b __ SBC T5 + 1 
1651 : 85 4b __ STA T5 + 1 
.s68:
1653 : a5 4a __ LDA T5 + 0 
1655 : 85 1b __ STA ACCU + 0 
1657 : a5 4b __ LDA T5 + 1 
1659 : 85 1c __ STA ACCU + 1 
165b : a9 0a __ LDA #$0a
165d : 85 03 __ STA WORK + 0 
165f : a9 00 __ LDA #$00
1661 : 85 04 __ STA WORK + 1 
1663 : 20 10 22 JSR $2210 ; (divs16 + 0)
1666 : 18 __ __ CLC
1667 : a5 1b __ LDA ACCU + 0 
1669 : 69 30 __ ADC #$30
166b : a4 48 __ LDY T3 + 0 
166d : c8 __ __ INY
166e : c8 __ __ INY
166f : 91 13 __ STA (P6),y ; (str + 0)
1671 : a5 4a __ LDA T5 + 0 
1673 : 85 1b __ STA ACCU + 0 
1675 : a5 4b __ LDA T5 + 1 
1677 : 85 1c __ STA ACCU + 1 
1679 : a9 0a __ LDA #$0a
167b : 85 03 __ STA WORK + 0 
167d : a9 00 __ LDA #$00
167f : 85 04 __ STA WORK + 1 
1681 : 20 cf 22 JSR $22cf ; (mods16 + 0)
1684 : 18 __ __ CLC
1685 : a5 05 __ LDA WORK + 2 
1687 : 69 30 __ ADC #$30
1689 : a4 48 __ LDY T3 + 0 
168b : c8 __ __ INY
168c : c8 __ __ INY
168d : c8 __ __ INY
168e : 91 13 __ STA (P6),y ; (str + 0)
1690 : c8 __ __ INY
1691 : 84 48 __ STY T3 + 0 
.s9:
1693 : a5 11 __ LDA P4 ; (si + 0)
1695 : 85 4a __ STA T5 + 0 
1697 : a5 12 __ LDA P5 ; (si + 1)
1699 : 85 4b __ STA T5 + 1 
169b : a5 48 __ LDA T3 + 0 
169d : a0 01 __ LDY #$01
169f : d1 11 __ CMP (P4),y ; (si + 0)
16a1 : b0 5d __ BCS $1700 ; (nformf.s1001 + 0)
.s69:
16a3 : a0 06 __ LDY #$06
16a5 : b1 11 __ LDA (P4),y ; (si + 0)
16a7 : f0 06 __ BEQ $16af ; (nformf.s73 + 0)
.s72:
16a9 : a5 48 __ LDA T3 + 0 
16ab : aa __ __ TAX
16ac : 4c 07 17 JMP $1707 ; (nformf.l75 + 0)
.s73:
16af : a5 48 __ LDA T3 + 0 
16b1 : f0 2d __ BEQ $16e0 ; (nformf.s82 + 0)
.s90:
16b3 : a9 01 __ LDA #$01
16b5 : 85 47 __ STA T2 + 0 
16b7 : a6 48 __ LDX T3 + 0 
16b9 : 38 __ __ SEC
.l1083:
16ba : a0 01 __ LDY #$01
16bc : b1 11 __ LDA (P4),y ; (si + 0)
16be : e5 47 __ SBC T2 + 0 
16c0 : 85 4c __ STA T8 + 0 
16c2 : a9 ff __ LDA #$ff
16c4 : 65 14 __ ADC P7 ; (str + 1)
16c6 : 85 4d __ STA T8 + 1 
16c8 : 8a __ __ TXA
16c9 : 38 __ __ SEC
16ca : e5 47 __ SBC T2 + 0 
16cc : 85 1b __ STA ACCU + 0 
16ce : a9 ff __ LDA #$ff
16d0 : 65 14 __ ADC P7 ; (str + 1)
16d2 : 85 1c __ STA ACCU + 1 
16d4 : a4 13 __ LDY P6 ; (str + 0)
16d6 : b1 1b __ LDA (ACCU + 0),y 
16d8 : 91 4c __ STA (T8 + 0),y 
16da : e6 47 __ INC T2 + 0 
16dc : e4 47 __ CPX T2 + 0 
16de : b0 da __ BCS $16ba ; (nformf.l1083 + 0)
.s82:
16e0 : a9 00 __ LDA #$00
16e2 : 85 47 __ STA T2 + 0 
.l83:
16e4 : a0 01 __ LDY #$01
16e6 : b1 4a __ LDA (T5 + 0),y 
16e8 : 38 __ __ SEC
16e9 : e5 48 __ SBC T3 + 0 
16eb : 90 06 __ BCC $16f3 ; (nformf.s84 + 0)
.s1011:
16ed : c5 47 __ CMP T2 + 0 
16ef : 90 0d __ BCC $16fe ; (nformf.s74 + 0)
.s1087:
16f1 : f0 0b __ BEQ $16fe ; (nformf.s74 + 0)
.s84:
16f3 : a9 20 __ LDA #$20
16f5 : a4 47 __ LDY T2 + 0 
16f7 : 91 13 __ STA (P6),y ; (str + 0)
16f9 : e6 47 __ INC T2 + 0 
16fb : 4c e4 16 JMP $16e4 ; (nformf.l83 + 0)
.s74:
16fe : b1 11 __ LDA (P4),y ; (si + 0)
.s1001:
1700 : 85 1b __ STA ACCU + 0 
1702 : a9 00 __ LDA #$00
1704 : 85 1c __ STA ACCU + 1 
1706 : 60 __ __ RTS
.l75:
1707 : a0 01 __ LDY #$01
1709 : d1 4a __ CMP (T5 + 0),y 
170b : b0 f1 __ BCS $16fe ; (nformf.s74 + 0)
.s76:
170d : a8 __ __ TAY
170e : a9 20 __ LDA #$20
1710 : 91 13 __ STA (P6),y ; (str + 0)
1712 : e8 __ __ INX
1713 : 8a __ __ TXA
1714 : 4c 07 17 JMP $1707 ; (nformf.l75 + 0)
.s30:
1717 : a5 4c __ LDA T8 + 0 
1719 : c9 07 __ CMP #$07
171b : 90 13 __ BCC $1730 ; (nformf.s41 + 0)
.s42:
171d : ad b5 24 LDA $24b5 ; (fround5 + 25)
1720 : 85 1c __ STA ACCU + 1 
1722 : ad b6 24 LDA $24b6 ; (fround5 + 26)
1725 : 85 1d __ STA ACCU + 2 
1727 : ad b7 24 LDA $24b7 ; (fround5 + 27)
172a : ae b4 24 LDX $24b4 ; (fround5 + 24)
172d : 4c 43 17 JMP $1743 ; (nformf.s204 + 0)
.s41:
1730 : 0a __ __ ASL
1731 : 0a __ __ ASL
1732 : a8 __ __ TAY
1733 : b9 99 24 LDA $2499,y ; (p2smap + 6)
1736 : 85 1c __ STA ACCU + 1 
1738 : b9 9a 24 LDA $249a,y ; (p2smap + 7)
173b : 85 1d __ STA ACCU + 2 
173d : b9 9b 24 LDA $249b,y ; (giocharmap + 0)
1740 : be 98 24 LDX $2498,y ; (p2smap + 5)
.s204:
1743 : 86 1b __ STX ACCU + 0 
1745 : 85 1e __ STA ACCU + 3 
1747 : a2 43 __ LDX #$43
1749 : 20 6b 1f JSR $1f6b ; (freg + 4)
174c : 20 ac 1f JSR $1fac ; (faddsub + 0)
174f : a5 1c __ LDA ACCU + 1 
1751 : 85 16 __ STA P9 ; (f + 1)
1753 : a5 1d __ LDA ACCU + 2 
1755 : 85 17 __ STA P10 ; (f + 2)
1757 : a6 1b __ LDX ACCU + 0 
1759 : a5 1e __ LDA ACCU + 3 
175b : 85 18 __ STA P11 ; (f + 3)
175d : 10 03 __ BPL $1762 ; (nformf.s1042 + 0)
175f : 4c 8e 15 JMP $158e ; (nformf.s31 + 0)
.s1042:
1762 : c9 41 __ CMP #$41
1764 : d0 06 __ BNE $176c ; (nformf.s1046 + 0)
.s1043:
1766 : a5 17 __ LDA P10 ; (f + 2)
1768 : c9 20 __ CMP #$20
176a : f0 05 __ BEQ $1771 ; (nformf.s44 + 0)
.s1046:
176c : b0 03 __ BCS $1771 ; (nformf.s44 + 0)
176e : 4c 8e 15 JMP $158e ; (nformf.s31 + 0)
.s44:
1771 : a9 00 __ LDA #$00
1773 : 85 03 __ STA WORK + 0 
1775 : 85 04 __ STA WORK + 1 
1777 : a9 20 __ LDA #$20
1779 : 85 05 __ STA WORK + 2 
177b : a9 41 __ LDA #$41
177d : 85 06 __ STA WORK + 3 
177f : 20 7b 1f JSR $1f7b ; (freg + 20)
1782 : 20 62 21 JSR $2162 ; (fdiv + 0)
1785 : a5 1c __ LDA ACCU + 1 
1787 : 85 16 __ STA P9 ; (f + 1)
1789 : a5 1d __ LDA ACCU + 2 
178b : 85 17 __ STA P10 ; (f + 2)
178d : a5 1e __ LDA ACCU + 3 
178f : 85 18 __ STA P11 ; (f + 3)
1791 : a6 1b __ LDX ACCU + 0 
1793 : e6 4a __ INC T5 + 0 
1795 : f0 03 __ BEQ $179a ; (nformf.s1092 + 0)
1797 : 4c 8e 15 JMP $158e ; (nformf.s31 + 0)
.s1092:
179a : e6 4b __ INC T5 + 1 
179c : 4c 8e 15 JMP $158e ; (nformf.s31 + 0)
.s13:
179f : a5 18 __ LDA P11 ; (f + 3)
17a1 : 30 59 __ BMI $17fc ; (nformf.l17 + 0)
.l1072:
17a3 : c9 44 __ CMP #$44
17a5 : f0 03 __ BEQ $17aa ; (nformf.s1073 + 0)
17a7 : 4c 99 18 JMP $1899 ; (nformf.s1076 + 0)
.s1073:
17aa : a5 45 __ LDA T1 + 2 
17ac : c9 7a __ CMP #$7a
17ae : f0 03 __ BEQ $17b3 ; (nformf.s1074 + 0)
17b0 : 4c 99 18 JMP $1899 ; (nformf.s1076 + 0)
.s1074:
17b3 : a5 44 __ LDA T1 + 1 
17b5 : d0 04 __ BNE $17bb ; (nformf.s1082 + 0)
.s1075:
17b7 : a5 43 __ LDA T1 + 0 
17b9 : f0 02 __ BEQ $17bd ; (nformf.s14 + 0)
.s1082:
17bb : a5 43 __ LDA T1 + 0 
.s14:
17bd : 85 1b __ STA ACCU + 0 
17bf : a5 44 __ LDA T1 + 1 
17c1 : 85 1c __ STA ACCU + 1 
17c3 : a5 45 __ LDA T1 + 2 
17c5 : 85 1d __ STA ACCU + 2 
17c7 : a5 46 __ LDA T1 + 3 
17c9 : 85 1e __ STA ACCU + 3 
17cb : a9 00 __ LDA #$00
17cd : 85 03 __ STA WORK + 0 
17cf : 85 04 __ STA WORK + 1 
17d1 : a9 7a __ LDA #$7a
17d3 : 85 05 __ STA WORK + 2 
17d5 : a9 44 __ LDA #$44
17d7 : 85 06 __ STA WORK + 3 
17d9 : 20 7b 1f JSR $1f7b ; (freg + 20)
17dc : 20 62 21 JSR $2162 ; (fdiv + 0)
17df : a5 1b __ LDA ACCU + 0 
17e1 : 85 43 __ STA T1 + 0 
17e3 : a5 1c __ LDA ACCU + 1 
17e5 : 85 44 __ STA T1 + 1 
17e7 : a5 1d __ LDA ACCU + 2 
17e9 : 85 45 __ STA T1 + 2 
17eb : 18 __ __ CLC
17ec : a5 4a __ LDA T5 + 0 
17ee : 69 03 __ ADC #$03
17f0 : 85 4a __ STA T5 + 0 
17f2 : 90 02 __ BCC $17f6 ; (nformf.s1097 + 0)
.s1096:
17f4 : e6 4b __ INC T5 + 1 
.s1097:
17f6 : a5 1e __ LDA ACCU + 3 
17f8 : 85 46 __ STA T1 + 3 
17fa : 10 a7 __ BPL $17a3 ; (nformf.l1072 + 0)
.l17:
17fc : a9 00 __ LDA #$00
17fe : 85 1b __ STA ACCU + 0 
1800 : 85 1c __ STA ACCU + 1 
1802 : a9 7a __ LDA #$7a
1804 : 85 1d __ STA ACCU + 2 
1806 : a9 44 __ LDA #$44
1808 : 85 1e __ STA ACCU + 3 
180a : a2 43 __ LDX #$43
180c : 20 6b 1f JSR $1f6b ; (freg + 4)
180f : 20 93 20 JSR $2093 ; (fmul + 0)
1812 : a5 1b __ LDA ACCU + 0 
1814 : 85 43 __ STA T1 + 0 
1816 : a5 1c __ LDA ACCU + 1 
1818 : 85 44 __ STA T1 + 1 
181a : a5 1d __ LDA ACCU + 2 
181c : 85 45 __ STA T1 + 2 
181e : a5 1e __ LDA ACCU + 3 
1820 : 85 46 __ STA T1 + 3 
1822 : 38 __ __ SEC
1823 : a5 4a __ LDA T5 + 0 
1825 : e9 03 __ SBC #$03
1827 : 85 4a __ STA T5 + 0 
1829 : b0 02 __ BCS $182d ; (nformf.s16 + 0)
.s1088:
182b : c6 4b __ DEC T5 + 1 
.s16:
182d : a5 46 __ LDA T1 + 3 
182f : 30 cb __ BMI $17fc ; (nformf.l17 + 0)
.s1064:
1831 : c9 3f __ CMP #$3f
1833 : d0 06 __ BNE $183b ; (nformf.s1068 + 0)
.s1065:
1835 : a5 45 __ LDA T1 + 2 
1837 : c9 80 __ CMP #$80
1839 : f0 02 __ BEQ $183d ; (nformf.s19 + 0)
.s1068:
183b : 90 bf __ BCC $17fc ; (nformf.l17 + 0)
.s19:
183d : a5 46 __ LDA T1 + 3 
183f : c9 41 __ CMP #$41
1841 : d0 51 __ BNE $1894 ; (nformf.l1060 + 0)
.s1057:
1843 : a5 45 __ LDA T1 + 2 
1845 : c9 20 __ CMP #$20
1847 : d0 4b __ BNE $1894 ; (nformf.l1060 + 0)
.s1058:
1849 : a5 44 __ LDA T1 + 1 
184b : d0 04 __ BNE $1851 ; (nformf.l1081 + 0)
.s1059:
184d : a5 43 __ LDA T1 + 0 
184f : f0 02 __ BEQ $1853 ; (nformf.l20 + 0)
.l1081:
1851 : a5 43 __ LDA T1 + 0 
.l20:
1853 : 85 1b __ STA ACCU + 0 
1855 : a5 44 __ LDA T1 + 1 
1857 : 85 1c __ STA ACCU + 1 
1859 : a5 45 __ LDA T1 + 2 
185b : 85 1d __ STA ACCU + 2 
185d : a5 46 __ LDA T1 + 3 
185f : 85 1e __ STA ACCU + 3 
1861 : a9 00 __ LDA #$00
1863 : 85 03 __ STA WORK + 0 
1865 : 85 04 __ STA WORK + 1 
1867 : a9 20 __ LDA #$20
1869 : 85 05 __ STA WORK + 2 
186b : a9 41 __ LDA #$41
186d : 85 06 __ STA WORK + 3 
186f : 20 7b 1f JSR $1f7b ; (freg + 20)
1872 : 20 62 21 JSR $2162 ; (fdiv + 0)
1875 : a5 1b __ LDA ACCU + 0 
1877 : 85 43 __ STA T1 + 0 
1879 : a5 1c __ LDA ACCU + 1 
187b : 85 44 __ STA T1 + 1 
187d : a5 1d __ LDA ACCU + 2 
187f : 85 45 __ STA T1 + 2 
1881 : e6 4a __ INC T5 + 0 
1883 : d0 02 __ BNE $1887 ; (nformf.s1091 + 0)
.s1090:
1885 : e6 4b __ INC T5 + 1 
.s1091:
1887 : a5 1e __ LDA ACCU + 3 
1889 : 85 46 __ STA T1 + 3 
188b : 10 03 __ BPL $1890 ; (nformf.s1056 + 0)
188d : 4c 92 14 JMP $1492 ; (nformf.s12 + 0)
.s1056:
1890 : c9 41 __ CMP #$41
1892 : f0 af __ BEQ $1843 ; (nformf.s1057 + 0)
.l1060:
1894 : b0 bb __ BCS $1851 ; (nformf.l1081 + 0)
1896 : 4c 92 14 JMP $1492 ; (nformf.s12 + 0)
.s1076:
1899 : 90 92 __ BCC $182d ; (nformf.s16 + 0)
189b : 4c bb 17 JMP $17bb ; (nformf.s1082 + 0)
.s7:
189e : 85 1b __ STA ACCU + 0 
18a0 : a9 49 __ LDA #$49
18a2 : 91 13 __ STA (P6),y ; (str + 0)
18a4 : a9 4e __ LDA #$4e
18a6 : a4 4a __ LDY T5 + 0 
18a8 : 91 13 __ STA (P6),y ; (str + 0)
18aa : a9 46 __ LDA #$46
18ac : a4 1b __ LDY ACCU + 0 
18ae : 91 13 __ STA (P6),y ; (str + 0)
18b0 : 18 __ __ CLC
18b1 : a5 48 __ LDA T3 + 0 
18b3 : 69 03 __ ADC #$03
18b5 : 85 48 __ STA T3 + 0 
18b7 : 4c 93 16 JMP $1693 ; (nformf.s9 + 0)
.s189:
18ba : 20 d2 18 JSR $18d2 ; (isinf.s0 + 0)
18bd : aa __ __ TAX
18be : a9 01 __ LDA #$01
18c0 : 85 48 __ STA T3 + 0 
18c2 : 8a __ __ TXA
18c3 : d0 03 __ BNE $18c8 ; (nformf.s158 + 0)
18c5 : 4c 6f 14 JMP $146f ; (nformf.s8 + 0)
.s158:
18c8 : a9 02 __ LDA #$02
18ca : 85 4a __ STA T5 + 0 
18cc : a9 03 __ LDA #$03
18ce : a0 01 __ LDY #$01
18d0 : d0 cc __ BNE $189e ; (nformf.s7 + 0)
--------------------------------------------------------------------
isinf:
.s0:
18d2 : 06 0f __ ASL P2 ; (f + 2)
18d4 : a5 10 __ LDA P3 ; (f + 3)
18d6 : 2a __ __ ROL
18d7 : c9 ff __ CMP #$ff
18d9 : d0 03 __ BNE $18de ; (isinf.s1003 + 0)
.s1002:
18db : a9 01 __ LDA #$01
18dd : 60 __ __ RTS
.s1003:
18de : a9 00 __ LDA #$00
.s1001:
18e0 : 60 __ __ RTS
--------------------------------------------------------------------
fround5:
249c : __ __ __ BYT 00 00 00 3f cd cc 4c 3d 0a d7 a3 3b 6f 12 03 3a : ...?..L=...;o..:
24ac : __ __ __ BYT 17 b7 51 38 ac c5 a7 36 bd 37 06 35             : ..Q8...6.7.5
--------------------------------------------------------------------
18e1 : __ __ __ BYT 25 64 00                                        : %d.
--------------------------------------------------------------------
spawn_enemy:
.s0:
18e4 : 20 54 19 JSR $1954 ; (rand.s0 + 0)
18e7 : 46 1b __ LSR ACCU + 0 
18e9 : b0 0f __ BCS $18fa ; (spawn_enemy.s1001 + 0)
.s3:
18eb : a0 00 __ LDY #$00
.l6:
18ed : be 1b 24 LDX $241b,y ; (__multab5L + 0)
18f0 : bd c0 24 LDA $24c0,x ; (Enemy + 4)
18f3 : f0 06 __ BEQ $18fb ; (spawn_enemy.s9 + 0)
.s7:
18f5 : c8 __ __ INY
18f6 : c0 0a __ CPY #$0a
18f8 : 90 f3 __ BCC $18ed ; (spawn_enemy.l6 + 0)
.s1001:
18fa : 60 __ __ RTS
.s9:
18fb : 86 43 __ STX T0 + 0 
18fd : a9 27 __ LDA #$27
18ff : 9d bc 24 STA $24bc,x ; (Enemy + 0)
1902 : 20 54 19 JSR $1954 ; (rand.s0 + 0)
1905 : a9 14 __ LDA #$14
1907 : 85 03 __ STA WORK + 0 
1909 : a9 00 __ LDA #$00
190b : 85 04 __ STA WORK + 1 
190d : 20 4a 22 JSR $224a ; (divmod + 0)
1910 : 18 __ __ CLC
1911 : a5 05 __ LDA WORK + 2 
1913 : 69 04 __ ADC #$04
1915 : a6 43 __ LDX T0 + 0 
1917 : 9d bd 24 STA $24bd,x ; (Enemy + 1)
191a : 20 54 19 JSR $1954 ; (rand.s0 + 0)
191d : a9 0e __ LDA #$0e
191f : a6 43 __ LDX T0 + 0 
1921 : 9d bf 24 STA $24bf,x ; (Enemy + 3)
1924 : a9 01 __ LDA #$01
1926 : 9d c0 24 STA $24c0,x ; (Enemy + 4)
1929 : a9 03 __ LDA #$03
192b : 85 03 __ STA WORK + 0 
192d : a9 00 __ LDA #$00
192f : 85 04 __ STA WORK + 1 
1931 : 20 4a 22 JSR $224a ; (divmod + 0)
1934 : 18 __ __ CLC
1935 : a5 05 __ LDA WORK + 2 
1937 : 69 83 __ ADC #$83
1939 : a4 43 __ LDY T0 + 0 
193b : 99 be 24 STA $24be,y ; (Enemy + 2)
193e : c9 83 __ CMP #$83
1940 : d0 04 __ BNE $1946 ; (spawn_enemy.s13 + 0)
.s12:
1942 : a9 0d __ LDA #$0d
1944 : d0 0a __ BNE $1950 ; (spawn_enemy.s1008 + 0)
.s13:
1946 : c9 84 __ CMP #$84
1948 : d0 04 __ BNE $194e ; (spawn_enemy.s16 + 0)
.s15:
194a : a9 0a __ LDA #$0a
194c : d0 02 __ BNE $1950 ; (spawn_enemy.s1008 + 0)
.s16:
194e : a9 09 __ LDA #$09
.s1008:
1950 : 99 bf 24 STA $24bf,y ; (Enemy + 3)
1953 : 60 __ __ RTS
--------------------------------------------------------------------
rand:
.s0:
1954 : ad b9 24 LDA $24b9 ; (seed + 1)
1957 : 4a __ __ LSR
1958 : ad b8 24 LDA $24b8 ; (seed + 0)
195b : 6a __ __ ROR
195c : aa __ __ TAX
195d : a9 00 __ LDA #$00
195f : 6a __ __ ROR
1960 : 4d b8 24 EOR $24b8 ; (seed + 0)
1963 : 85 1b __ STA ACCU + 0 
1965 : 8a __ __ TXA
1966 : 4d b9 24 EOR $24b9 ; (seed + 1)
1969 : 85 1c __ STA ACCU + 1 
196b : 4a __ __ LSR
196c : 45 1b __ EOR ACCU + 0 
196e : 8d b8 24 STA $24b8 ; (seed + 0)
1971 : 85 1b __ STA ACCU + 0 
1973 : 45 1c __ EOR ACCU + 1 
1975 : 8d b9 24 STA $24b9 ; (seed + 1)
1978 : 85 1c __ STA ACCU + 1 
.s1001:
197a : 60 __ __ RTS
--------------------------------------------------------------------
seed:
24b8 : __ __ __ BYT 00 7a                                           : .z
--------------------------------------------------------------------
move_enemies:
.s0:
197b : a2 00 __ LDX #$00
.l2:
197d : 86 43 __ STX T0 + 0 
197f : bc 1b 24 LDY $241b,x ; (__multab5L + 0)
1982 : b9 c0 24 LDA $24c0,y ; (Enemy + 4)
1985 : c9 01 __ CMP #$01
1987 : d0 75 __ BNE $19fe ; (move_enemies.s41 + 0)
.s5:
1989 : 18 __ __ CLC
198a : a9 bc __ LDA #$bc
198c : 7d 1b 24 ADC $241b,x ; (__multab5L + 0)
198f : 85 44 __ STA T1 + 0 
1991 : a9 24 __ LDA #$24
1993 : 69 00 __ ADC #$00
1995 : 85 45 __ STA T1 + 1 
1997 : a0 02 __ LDY #$02
1999 : b1 44 __ LDA (T1 + 0),y 
199b : c9 83 __ CMP #$83
199d : d0 16 __ BNE $19b5 ; (move_enemies.s10 + 0)
.s11:
199f : 88 __ __ DEY
19a0 : b1 44 __ LDA (T1 + 0),y 
19a2 : cd bb 24 CMP $24bb ; (Player + 1)
19a5 : d0 0e __ BNE $19b5 ; (move_enemies.s10 + 0)
.s8:
19a7 : a5 44 __ LDA T1 + 0 
19a9 : 85 0d __ STA P0 
19ab : a5 45 __ LDA T1 + 1 
19ad : 85 0e __ STA P1 
19af : 20 6b 1a JSR $1a6b ; (spawn_enemy_shot.s0 + 0)
19b2 : 20 9e 1a JSR $1a9e ; (render_enemy_shots.s0 + 0)
.s10:
19b5 : a0 00 __ LDY #$00
19b7 : b1 44 __ LDA (T1 + 0),y 
19b9 : 85 46 __ STA T3 + 0 
19bb : c8 __ __ INY
19bc : b1 44 __ LDA (T1 + 0),y 
19be : 0a __ __ ASL
19bf : 85 1b __ STA ACCU + 0 
19c1 : a9 00 __ LDA #$00
19c3 : 2a __ __ ROL
19c4 : 06 1b __ ASL ACCU + 0 
19c6 : 2a __ __ ROL
19c7 : aa __ __ TAX
19c8 : a5 1b __ LDA ACCU + 0 
19ca : 71 44 __ ADC (T1 + 0),y 
19cc : 85 1b __ STA ACCU + 0 
19ce : 8a __ __ TXA
19cf : 69 00 __ ADC #$00
19d1 : 06 1b __ ASL ACCU + 0 
19d3 : 2a __ __ ROL
19d4 : 06 1b __ ASL ACCU + 0 
19d6 : 2a __ __ ROL
19d7 : 06 1b __ ASL ACCU + 0 
19d9 : 2a __ __ ROL
19da : aa __ __ TAX
19db : 18 __ __ CLC
19dc : a5 1b __ LDA ACCU + 0 
19de : 65 46 __ ADC T3 + 0 
19e0 : 85 1b __ STA ACCU + 0 
19e2 : 85 1f __ STA ADDR + 0 
19e4 : 8a __ __ TXA
19e5 : 69 c0 __ ADC #$c0
19e7 : 85 1c __ STA ACCU + 1 
19e9 : 18 __ __ CLC
19ea : 69 18 __ ADC #$18
19ec : 85 20 __ STA ADDR + 1 
19ee : a9 20 __ LDA #$20
19f0 : 88 __ __ DEY
19f1 : 91 1b __ STA (ACCU + 0),y 
19f3 : 98 __ __ TYA
19f4 : 91 1f __ STA (ADDR + 0),y 
19f6 : a5 46 __ LDA T3 + 0 
19f8 : d0 0f __ BNE $1a09 ; (move_enemies.s12 + 0)
.s13:
19fa : a0 04 __ LDY #$04
.s1020:
19fc : 91 44 __ STA (T1 + 0),y 
.s41:
19fe : a6 43 __ LDX T0 + 0 
1a00 : e8 __ __ INX
1a01 : e0 0a __ CPX #$0a
1a03 : b0 03 __ BCS $1a08 ; (move_enemies.s1001 + 0)
1a05 : 4c 7d 19 JMP $197d ; (move_enemies.l2 + 0)
.s1001:
1a08 : 60 __ __ RTS
.s12:
1a09 : c6 46 __ DEC T3 + 0 
1a0b : a5 46 __ LDA T3 + 0 
1a0d : 91 44 __ STA (T1 + 0),y 
1a0f : a0 02 __ LDY #$02
1a11 : b1 44 __ LDA (T1 + 0),y 
1a13 : c9 85 __ CMP #$85
1a15 : f0 e7 __ BEQ $19fe ; (move_enemies.s41 + 0)
.s15:
1a17 : 20 54 19 JSR $1954 ; (rand.s0 + 0)
1a1a : a0 01 __ LDY #$01
1a1c : b1 44 __ LDA (T1 + 0),y 
1a1e : 85 47 __ STA T4 + 0 
1a20 : a9 03 __ LDA #$03
1a22 : 85 03 __ STA WORK + 0 
1a24 : a9 00 __ LDA #$00
1a26 : 85 04 __ STA WORK + 1 
1a28 : 20 4a 22 JSR $224a ; (divmod + 0)
1a2b : 38 __ __ SEC
1a2c : a5 05 __ LDA WORK + 2 
1a2e : e9 01 __ SBC #$01
1a30 : aa __ __ TAX
1a31 : a5 06 __ LDA WORK + 3 
1a33 : e9 00 __ SBC #$00
1a35 : a8 __ __ TAY
1a36 : 8a __ __ TXA
1a37 : 18 __ __ CLC
1a38 : 65 47 __ ADC T4 + 0 
1a3a : 85 1b __ STA ACCU + 0 
1a3c : 90 01 __ BCC $1a3f ; (move_enemies.s1022 + 0)
.s1021:
1a3e : c8 __ __ INY
.s1022:
1a3f : 0a __ __ ASL
1a40 : 0a __ __ ASL
1a41 : 18 __ __ CLC
1a42 : 65 1b __ ADC ACCU + 0 
1a44 : 0a __ __ ASL
1a45 : 0a __ __ ASL
1a46 : 0a __ __ ASL
1a47 : 18 __ __ CLC
1a48 : 65 46 __ ADC T3 + 0 
1a4a : aa __ __ TAX
1a4b : bd 00 c0 LDA $c000,x 
1a4e : c9 83 __ CMP #$83
1a50 : f0 ac __ BEQ $19fe ; (move_enemies.s41 + 0)
.s24:
1a52 : c9 84 __ CMP #$84
1a54 : f0 a8 __ BEQ $19fe ; (move_enemies.s41 + 0)
.s23:
1a56 : c9 85 __ CMP #$85
1a58 : f0 a4 __ BEQ $19fe ; (move_enemies.s41 + 0)
.s22:
1a5a : 98 __ __ TYA
1a5b : d0 a1 __ BNE $19fe ; (move_enemies.s41 + 0)
.s1005:
1a5d : a5 1b __ LDA ACCU + 0 
1a5f : c9 04 __ CMP #$04
1a61 : 90 9b __ BCC $19fe ; (move_enemies.s41 + 0)
.s1004:
1a63 : c9 18 __ CMP #$18
1a65 : b0 97 __ BCS $19fe ; (move_enemies.s41 + 0)
.s18:
1a67 : a0 01 __ LDY #$01
1a69 : d0 91 __ BNE $19fc ; (move_enemies.s1020 + 0)
--------------------------------------------------------------------
spawn_enemy_shot:
.s0:
1a6b : a0 00 __ LDY #$00
1a6d : b1 0d __ LDA (P0),y ; (e + 0)
1a6f : f0 0f __ BEQ $1a80 ; (spawn_enemy_shot.s1001 + 0)
.s3:
1a71 : a2 00 __ LDX #$00
.l6:
1a73 : bc 25 24 LDY $2425,x ; (__multab3L + 0)
1a76 : b9 f9 24 LDA $24f9,y ; (EnemyShot + 2)
1a79 : f0 06 __ BEQ $1a81 ; (spawn_enemy_shot.s9 + 0)
.s7:
1a7b : e8 __ __ INX
1a7c : e0 03 __ CPX #$03
1a7e : 90 f3 __ BCC $1a73 ; (spawn_enemy_shot.l6 + 0)
.s1001:
1a80 : 60 __ __ RTS
.s9:
1a81 : a9 01 __ LDA #$01
1a83 : 99 f9 24 STA $24f9,y ; (EnemyShot + 2)
1a86 : a0 00 __ LDY #$00
1a88 : b1 0d __ LDA (P0),y ; (e + 0)
1a8a : 38 __ __ SEC
1a8b : e9 01 __ SBC #$01
1a8d : bc 25 24 LDY $2425,x ; (__multab3L + 0)
1a90 : 99 f7 24 STA $24f7,y ; (EnemyShot + 0)
1a93 : a0 01 __ LDY #$01
1a95 : b1 0d __ LDA (P0),y ; (e + 0)
1a97 : bc 25 24 LDY $2425,x ; (__multab3L + 0)
1a9a : 99 f8 24 STA $24f8,y ; (EnemyShot + 1)
1a9d : 60 __ __ RTS
--------------------------------------------------------------------
render_enemy_shots:
.s0:
1a9e : a2 00 __ LDX #$00
.l1006:
1aa0 : bc 25 24 LDY $2425,x ; (__multab3L + 0)
1aa3 : b9 f9 24 LDA $24f9,y ; (EnemyShot + 2)
1aa6 : c9 01 __ CMP #$01
1aa8 : d0 43 __ BNE $1aed ; (render_enemy_shots.s19 + 0)
.s5:
1aaa : b9 f8 24 LDA $24f8,y ; (EnemyShot + 1)
1aad : 0a __ __ ASL
1aae : 85 1b __ STA ACCU + 0 
1ab0 : a9 00 __ LDA #$00
1ab2 : 2a __ __ ROL
1ab3 : 06 1b __ ASL ACCU + 0 
1ab5 : 2a __ __ ROL
1ab6 : 85 1c __ STA ACCU + 1 
1ab8 : a5 1b __ LDA ACCU + 0 
1aba : 79 f8 24 ADC $24f8,y ; (EnemyShot + 1)
1abd : 85 1b __ STA ACCU + 0 
1abf : a5 1c __ LDA ACCU + 1 
1ac1 : 69 00 __ ADC #$00
1ac3 : 06 1b __ ASL ACCU + 0 
1ac5 : 2a __ __ ROL
1ac6 : 06 1b __ ASL ACCU + 0 
1ac8 : 2a __ __ ROL
1ac9 : 06 1b __ ASL ACCU + 0 
1acb : 2a __ __ ROL
1acc : 85 1c __ STA ACCU + 1 
1ace : 18 __ __ CLC
1acf : a5 1b __ LDA ACCU + 0 
1ad1 : 79 f7 24 ADC $24f7,y ; (EnemyShot + 0)
1ad4 : 85 1b __ STA ACCU + 0 
1ad6 : 85 1f __ STA ADDR + 0 
1ad8 : a5 1c __ LDA ACCU + 1 
1ada : 69 c0 __ ADC #$c0
1adc : 85 1c __ STA ACCU + 1 
1ade : 18 __ __ CLC
1adf : 69 18 __ ADC #$18
1ae1 : 85 20 __ STA ADDR + 1 
1ae3 : a9 82 __ LDA #$82
1ae5 : a0 00 __ LDY #$00
1ae7 : 91 1b __ STA (ACCU + 0),y 
1ae9 : a9 01 __ LDA #$01
1aeb : 91 1f __ STA (ADDR + 0),y 
.s19:
1aed : e8 __ __ INX
1aee : e0 03 __ CPX #$03
1af0 : 90 ae __ BCC $1aa0 ; (render_enemy_shots.l1006 + 0)
.s1001:
1af2 : 60 __ __ RTS
--------------------------------------------------------------------
render_enemies:
.s0:
1af3 : a2 00 __ LDX #$00
.l1006:
1af5 : bc 1b 24 LDY $241b,x ; (__multab5L + 0)
1af8 : b9 c0 24 LDA $24c0,y ; (Enemy + 4)
1afb : c9 01 __ CMP #$01
1afd : d0 4b __ BNE $1b4a ; (render_enemies.s19 + 0)
.s5:
1aff : 84 1d __ STY ACCU + 2 
1b01 : b9 bd 24 LDA $24bd,y ; (Enemy + 1)
1b04 : 0a __ __ ASL
1b05 : 85 1b __ STA ACCU + 0 
1b07 : a9 00 __ LDA #$00
1b09 : 2a __ __ ROL
1b0a : 06 1b __ ASL ACCU + 0 
1b0c : 2a __ __ ROL
1b0d : 85 1c __ STA ACCU + 1 
1b0f : a5 1b __ LDA ACCU + 0 
1b11 : 79 bd 24 ADC $24bd,y ; (Enemy + 1)
1b14 : 85 1b __ STA ACCU + 0 
1b16 : a5 1c __ LDA ACCU + 1 
1b18 : 69 00 __ ADC #$00
1b1a : 06 1b __ ASL ACCU + 0 
1b1c : 2a __ __ ROL
1b1d : 06 1b __ ASL ACCU + 0 
1b1f : 2a __ __ ROL
1b20 : 06 1b __ ASL ACCU + 0 
1b22 : 2a __ __ ROL
1b23 : 85 1c __ STA ACCU + 1 
1b25 : 18 __ __ CLC
1b26 : a5 1b __ LDA ACCU + 0 
1b28 : 79 bc 24 ADC $24bc,y ; (Enemy + 0)
1b2b : 85 43 __ STA T2 + 0 
1b2d : 85 1b __ STA ACCU + 0 
1b2f : a5 1c __ LDA ACCU + 1 
1b31 : 69 c0 __ ADC #$c0
1b33 : 85 44 __ STA T2 + 1 
1b35 : 18 __ __ CLC
1b36 : 69 18 __ ADC #$18
1b38 : 85 1c __ STA ACCU + 1 
1b3a : b9 be 24 LDA $24be,y ; (Enemy + 2)
1b3d : a0 00 __ LDY #$00
1b3f : 91 43 __ STA (T2 + 0),y 
1b41 : a4 1d __ LDY ACCU + 2 
1b43 : b9 bf 24 LDA $24bf,y ; (Enemy + 3)
1b46 : a0 00 __ LDY #$00
1b48 : 91 1b __ STA (ACCU + 0),y 
.s19:
1b4a : e8 __ __ INX
1b4b : e0 0a __ CPX #$0a
1b4d : 90 a6 __ BCC $1af5 ; (render_enemies.l1006 + 0)
.s1001:
1b4f : 60 __ __ RTS
--------------------------------------------------------------------
check_shot_enemy_collision:
.s0:
1b50 : a2 00 __ LDX #$00
.l2:
1b52 : 86 1d __ STX ACCU + 2 
1b54 : bc 25 24 LDY $2425,x ; (__multab3L + 0)
1b57 : b9 f0 24 LDA $24f0,y ; (PlayerShot + 2)
1b5a : c9 01 __ CMP #$01
1b5c : d0 2e __ BNE $1b8c ; (check_shot_enemy_collision.s3 + 0)
.s5:
1b5e : a2 00 __ LDX #$00
.l9:
1b60 : 86 43 __ STX T2 + 0 
1b62 : bc 1b 24 LDY $241b,x ; (__multab5L + 0)
1b65 : 84 1e __ STY ACCU + 3 
1b67 : b9 c0 24 LDA $24c0,y ; (Enemy + 4)
1b6a : c9 01 __ CMP #$01
1b6c : d0 17 __ BNE $1b85 ; (check_shot_enemy_collision.s114 + 0)
.s12:
1b6e : b9 bc 24 LDA $24bc,y ; (Enemy + 0)
1b71 : a6 1d __ LDX ACCU + 2 
1b73 : bc 25 24 LDY $2425,x ; (__multab3L + 0)
1b76 : d9 ee 24 CMP $24ee,y ; (PlayerShot + 0)
1b79 : d0 0a __ BNE $1b85 ; (check_shot_enemy_collision.s114 + 0)
.s18:
1b7b : b9 ef 24 LDA $24ef,y ; (PlayerShot + 1)
1b7e : a6 1e __ LDX ACCU + 3 
1b80 : dd bd 24 CMP $24bd,x ; (Enemy + 1)
1b83 : f0 0f __ BEQ $1b94 ; (check_shot_enemy_collision.s15 + 0)
.s114:
1b85 : a6 43 __ LDX T2 + 0 
1b87 : e8 __ __ INX
1b88 : e0 0a __ CPX #$0a
1b8a : 90 d4 __ BCC $1b60 ; (check_shot_enemy_collision.l9 + 0)
.s3:
1b8c : a6 1d __ LDX ACCU + 2 
1b8e : e8 __ __ INX
1b8f : e0 03 __ CPX #$03
1b91 : 90 bf __ BCC $1b52 ; (check_shot_enemy_collision.l2 + 0)
.s1001:
1b93 : 60 __ __ RTS
.s15:
1b94 : a9 00 __ LDA #$00
1b96 : 85 44 __ STA T3 + 0 
.l20:
1b98 : bd bd 24 LDA $24bd,x ; (Enemy + 1)
1b9b : 0a __ __ ASL
1b9c : 85 1b __ STA ACCU + 0 
1b9e : a9 00 __ LDA #$00
1ba0 : 2a __ __ ROL
1ba1 : 06 1b __ ASL ACCU + 0 
1ba3 : 2a __ __ ROL
1ba4 : a8 __ __ TAY
1ba5 : a5 1b __ LDA ACCU + 0 
1ba7 : 7d bd 24 ADC $24bd,x ; (Enemy + 1)
1baa : 85 1b __ STA ACCU + 0 
1bac : 98 __ __ TYA
1bad : 69 00 __ ADC #$00
1baf : 06 1b __ ASL ACCU + 0 
1bb1 : 2a __ __ ROL
1bb2 : 06 1b __ ASL ACCU + 0 
1bb4 : 2a __ __ ROL
1bb5 : 06 1b __ ASL ACCU + 0 
1bb7 : 2a __ __ ROL
1bb8 : a8 __ __ TAY
1bb9 : 18 __ __ CLC
1bba : a5 1b __ LDA ACCU + 0 
1bbc : 7d bc 24 ADC $24bc,x ; (Enemy + 0)
1bbf : 85 1b __ STA ACCU + 0 
1bc1 : 98 __ __ TYA
1bc2 : 69 c0 __ ADC #$c0
1bc4 : 85 1c __ STA ACCU + 1 
1bc6 : 18 __ __ CLC
1bc7 : 69 18 __ ADC #$18
1bc9 : 85 20 __ STA ADDR + 1 
1bcb : a9 86 __ LDA #$86
1bcd : a0 00 __ LDY #$00
1bcf : 84 1f __ STY ADDR + 0 
1bd1 : 91 1b __ STA (ACCU + 0),y 
1bd3 : a5 44 __ LDA T3 + 0 
1bd5 : a4 1b __ LDY ACCU + 0 
1bd7 : 91 1f __ STA (ADDR + 0),y 
.l109:
1bd9 : ad 11 d0 LDA $d011 
1bdc : 30 fb __ BMI $1bd9 ; (check_shot_enemy_collision.l109 + 0)
.l27:
1bde : ad 11 d0 LDA $d011 
1be1 : 10 fb __ BPL $1bde ; (check_shot_enemy_collision.l27 + 0)
.s21:
1be3 : e6 44 __ INC T3 + 0 
1be5 : a5 44 __ LDA T3 + 0 
1be7 : c9 08 __ CMP #$08
1be9 : 90 ad __ BCC $1b98 ; (check_shot_enemy_collision.l20 + 0)
.s22:
1beb : bd bd 24 LDA $24bd,x ; (Enemy + 1)
1bee : 0a __ __ ASL
1bef : 85 1b __ STA ACCU + 0 
1bf1 : a9 00 __ LDA #$00
1bf3 : 2a __ __ ROL
1bf4 : 06 1b __ ASL ACCU + 0 
1bf6 : 2a __ __ ROL
1bf7 : a8 __ __ TAY
1bf8 : a5 1b __ LDA ACCU + 0 
1bfa : 7d bd 24 ADC $24bd,x ; (Enemy + 1)
1bfd : 85 1b __ STA ACCU + 0 
1bff : 98 __ __ TYA
1c00 : 69 00 __ ADC #$00
1c02 : 06 1b __ ASL ACCU + 0 
1c04 : 2a __ __ ROL
1c05 : 06 1b __ ASL ACCU + 0 
1c07 : 2a __ __ ROL
1c08 : 06 1b __ ASL ACCU + 0 
1c0a : 2a __ __ ROL
1c0b : a8 __ __ TAY
1c0c : 18 __ __ CLC
1c0d : a5 1b __ LDA ACCU + 0 
1c0f : 7d bc 24 ADC $24bc,x ; (Enemy + 0)
1c12 : 85 44 __ STA T3 + 0 
1c14 : 85 1f __ STA ADDR + 0 
1c16 : 98 __ __ TYA
1c17 : 69 c0 __ ADC #$c0
1c19 : 85 45 __ STA T3 + 1 
1c1b : 18 __ __ CLC
1c1c : 69 18 __ ADC #$18
1c1e : 85 20 __ STA ADDR + 1 
1c20 : a9 20 __ LDA #$20
1c22 : a0 00 __ LDY #$00
1c24 : 91 44 __ STA (T3 + 0),y 
1c26 : 98 __ __ TYA
1c27 : 91 1f __ STA (ADDR + 0),y 
1c29 : 9d c0 24 STA $24c0,x ; (Enemy + 4)
1c2c : a6 1d __ LDX ACCU + 2 
1c2e : bc 25 24 LDY $2425,x ; (__multab3L + 0)
1c31 : 99 f0 24 STA $24f0,y ; (PlayerShot + 2)
1c34 : a6 1e __ LDX ACCU + 3 
1c36 : bd be 24 LDA $24be,x ; (Enemy + 2)
1c39 : c9 83 __ CMP #$83
1c3b : f0 2b __ BEQ $1c68 ; (check_shot_enemy_collision.s30 + 0)
.s31:
1c3d : c9 84 __ CMP #$84
1c3f : f0 03 __ BEQ $1c44 ; (check_shot_enemy_collision.s33 + 0)
1c41 : 4c 85 1b JMP $1b85 ; (check_shot_enemy_collision.s114 + 0)
.s33:
1c44 : ad 01 25 LDA $2501 ; (game + 1)
1c47 : 18 __ __ CLC
1c48 : 69 19 __ ADC #$19
.s118:
1c4a : 8d 01 25 STA $2501 ; (game + 1)
1c4d : ad 02 25 LDA $2502 ; (game + 2)
1c50 : 69 00 __ ADC #$00
1c52 : 8d 02 25 STA $2502 ; (game + 2)
1c55 : ad 03 25 LDA $2503 ; (game + 3)
1c58 : 69 00 __ ADC #$00
1c5a : 8d 03 25 STA $2503 ; (game + 3)
1c5d : b0 03 __ BCS $1c62 ; (check_shot_enemy_collision.s1019 + 0)
1c5f : 4c 85 1b JMP $1b85 ; (check_shot_enemy_collision.s114 + 0)
.s1019:
1c62 : ee 04 25 INC $2504 ; (game + 4)
1c65 : 4c 85 1b JMP $1b85 ; (check_shot_enemy_collision.s114 + 0)
.s30:
1c68 : ad 01 25 LDA $2501 ; (game + 1)
1c6b : 18 __ __ CLC
1c6c : 69 32 __ ADC #$32
1c6e : 4c 4a 1c JMP $1c4a ; (check_shot_enemy_collision.s118 + 0)
--------------------------------------------------------------------
move_enemy_shots:
.s0:
1c71 : a2 00 __ LDX #$00
.l1008:
1c73 : bc 25 24 LDY $2425,x ; (__multab3L + 0)
1c76 : b9 f9 24 LDA $24f9,y ; (EnemyShot + 2)
1c79 : c9 01 __ CMP #$01
1c7b : d0 58 __ BNE $1cd5 ; (move_enemy_shots.s23 + 0)
.s5:
1c7d : 84 1d __ STY ACCU + 2 
1c7f : b9 f8 24 LDA $24f8,y ; (EnemyShot + 1)
1c82 : 0a __ __ ASL
1c83 : 85 1b __ STA ACCU + 0 
1c85 : a9 00 __ LDA #$00
1c87 : 2a __ __ ROL
1c88 : 06 1b __ ASL ACCU + 0 
1c8a : 2a __ __ ROL
1c8b : 85 1c __ STA ACCU + 1 
1c8d : a5 1b __ LDA ACCU + 0 
1c8f : 79 f8 24 ADC $24f8,y ; (EnemyShot + 1)
1c92 : 85 1b __ STA ACCU + 0 
1c94 : a5 1c __ LDA ACCU + 1 
1c96 : 69 00 __ ADC #$00
1c98 : 06 1b __ ASL ACCU + 0 
1c9a : 2a __ __ ROL
1c9b : 06 1b __ ASL ACCU + 0 
1c9d : 2a __ __ ROL
1c9e : 06 1b __ ASL ACCU + 0 
1ca0 : 2a __ __ ROL
1ca1 : 85 1c __ STA ACCU + 1 
1ca3 : b9 f7 24 LDA $24f7,y ; (EnemyShot + 0)
1ca6 : 85 1e __ STA ACCU + 3 
1ca8 : 18 __ __ CLC
1ca9 : 65 1b __ ADC ACCU + 0 
1cab : 85 1b __ STA ACCU + 0 
1cad : 85 1f __ STA ADDR + 0 
1caf : a5 1c __ LDA ACCU + 1 
1cb1 : 69 c0 __ ADC #$c0
1cb3 : 85 1c __ STA ACCU + 1 
1cb5 : 18 __ __ CLC
1cb6 : 69 18 __ ADC #$18
1cb8 : 85 20 __ STA ADDR + 1 
1cba : a9 20 __ LDA #$20
1cbc : a0 00 __ LDY #$00
1cbe : 91 1b __ STA (ACCU + 0),y 
1cc0 : 98 __ __ TYA
1cc1 : 91 1f __ STA (ADDR + 0),y 
1cc3 : c6 1e __ DEC ACCU + 3 
1cc5 : a5 1e __ LDA ACCU + 3 
1cc7 : a4 1d __ LDY ACCU + 2 
1cc9 : 99 f7 24 STA $24f7,y ; (EnemyShot + 0)
1ccc : c9 ff __ CMP #$ff
1cce : d0 05 __ BNE $1cd5 ; (move_enemy_shots.s23 + 0)
.s8:
1cd0 : a9 00 __ LDA #$00
1cd2 : 99 f9 24 STA $24f9,y ; (EnemyShot + 2)
.s23:
1cd5 : e8 __ __ INX
1cd6 : e0 03 __ CPX #$03
1cd8 : 90 99 __ BCC $1c73 ; (move_enemy_shots.l1008 + 0)
.s1001:
1cda : 60 __ __ RTS
--------------------------------------------------------------------
check_player_enemy_collision:
.s0:
1cdb : a0 00 __ LDY #$00
.l2:
1cdd : be 1b 24 LDX $241b,y ; (__multab5L + 0)
1ce0 : bd c0 24 LDA $24c0,x ; (Enemy + 4)
1ce3 : c9 01 __ CMP #$01
1ce5 : d0 10 __ BNE $1cf7 ; (check_player_enemy_collision.s3 + 0)
.s5:
1ce7 : bd bc 24 LDA $24bc,x ; (Enemy + 0)
1cea : cd ba 24 CMP $24ba ; (Player + 0)
1ced : d0 08 __ BNE $1cf7 ; (check_player_enemy_collision.s3 + 0)
.s11:
1cef : bd bd 24 LDA $24bd,x ; (Enemy + 1)
1cf2 : cd bb 24 CMP $24bb ; (Player + 1)
1cf5 : f0 2d __ BEQ $1d24 ; (check_player_enemy_collision.s8 + 0)
.s3:
1cf7 : c8 __ __ INY
1cf8 : c0 0a __ CPY #$0a
1cfa : 90 e1 __ BCC $1cdd ; (check_player_enemy_collision.l2 + 0)
.s4:
1cfc : a0 00 __ LDY #$00
.l13:
1cfe : be 25 24 LDX $2425,y ; (__multab3L + 0)
1d01 : bd f9 24 LDA $24f9,x ; (EnemyShot + 2)
1d04 : c9 01 __ CMP #$01
1d06 : d0 10 __ BNE $1d18 ; (check_player_enemy_collision.s14 + 0)
.s16:
1d08 : bd f7 24 LDA $24f7,x ; (EnemyShot + 0)
1d0b : cd ba 24 CMP $24ba ; (Player + 0)
1d0e : d0 08 __ BNE $1d18 ; (check_player_enemy_collision.s14 + 0)
.s22:
1d10 : bd f8 24 LDA $24f8,x ; (EnemyShot + 1)
1d13 : cd bb 24 CMP $24bb ; (Player + 1)
1d16 : f0 06 __ BEQ $1d1e ; (check_player_enemy_collision.s19 + 0)
.s14:
1d18 : c8 __ __ INY
1d19 : c0 03 __ CPY #$03
1d1b : 90 e1 __ BCC $1cfe ; (check_player_enemy_collision.l13 + 0)
.s1001:
1d1d : 60 __ __ RTS
.s19:
1d1e : a9 01 __ LDA #$01
1d20 : 8d 00 25 STA $2500 ; (game + 0)
1d23 : 60 __ __ RTS
.s8:
1d24 : a9 01 __ LDA #$01
1d26 : 8d 00 25 STA $2500 ; (game + 0)
1d29 : d0 d1 __ BNE $1cfc ; (check_player_enemy_collision.s4 + 0)
--------------------------------------------------------------------
control_player_ship:
.s0:
1d2b : a9 00 __ LDA #$00
1d2d : 20 cd 1d JSR $1dcd ; (joy_poll.s0 + 0)
1d30 : ad 11 25 LDA $2511 ; (joyx + 0)
1d33 : 85 1d __ STA ACCU + 2 
1d35 : 85 1e __ STA ACCU + 3 
1d37 : d0 08 __ BNE $1d41 ; (control_player_ship.s1 + 0)
.s4:
1d39 : ad 0f 25 LDA $250f ; (joyy + 0)
1d3c : d0 03 __ BNE $1d41 ; (control_player_ship.s1 + 0)
1d3e : 4c c2 1d JMP $1dc2 ; (control_player_ship.s3 + 0)
.s1:
1d41 : ad ba 24 LDA $24ba ; (Player + 0)
1d44 : 85 43 __ STA T2 + 0 
1d46 : 85 44 __ STA T3 + 0 
1d48 : ad bb 24 LDA $24bb ; (Player + 1)
1d4b : 85 45 __ STA T4 + 0 
1d4d : 85 46 __ STA T5 + 0 
1d4f : 0a __ __ ASL
1d50 : 85 1b __ STA ACCU + 0 
1d52 : a9 00 __ LDA #$00
1d54 : 2a __ __ ROL
1d55 : 06 1b __ ASL ACCU + 0 
1d57 : 2a __ __ ROL
1d58 : aa __ __ TAX
1d59 : a5 1b __ LDA ACCU + 0 
1d5b : 65 45 __ ADC T4 + 0 
1d5d : 85 1b __ STA ACCU + 0 
1d5f : 8a __ __ TXA
1d60 : 69 00 __ ADC #$00
1d62 : 06 1b __ ASL ACCU + 0 
1d64 : 2a __ __ ROL
1d65 : 06 1b __ ASL ACCU + 0 
1d67 : 2a __ __ ROL
1d68 : 06 1b __ ASL ACCU + 0 
1d6a : 2a __ __ ROL
1d6b : aa __ __ TAX
1d6c : 18 __ __ CLC
1d6d : a5 1b __ LDA ACCU + 0 
1d6f : 65 43 __ ADC T2 + 0 
1d71 : 85 1b __ STA ACCU + 0 
1d73 : 85 1f __ STA ADDR + 0 
1d75 : 8a __ __ TXA
1d76 : 69 c0 __ ADC #$c0
1d78 : 85 1c __ STA ACCU + 1 
1d7a : 18 __ __ CLC
1d7b : 69 18 __ ADC #$18
1d7d : 85 20 __ STA ADDR + 1 
1d7f : a9 20 __ LDA #$20
1d81 : a0 00 __ LDY #$00
1d83 : 91 1b __ STA (ACCU + 0),y 
1d85 : 98 __ __ TYA
1d86 : 91 1f __ STA (ADDR + 0),y 
1d88 : a5 43 __ LDA T2 + 0 
1d8a : f0 04 __ BEQ $1d90 ; (control_player_ship.s6 + 0)
.s8:
1d8c : a5 1d __ LDA ACCU + 2 
1d8e : 30 0c __ BMI $1d9c ; (control_player_ship.s5 + 0)
.s6:
1d90 : a5 43 __ LDA T2 + 0 
1d92 : c9 27 __ CMP #$27
1d94 : b0 0e __ BCS $1da4 ; (control_player_ship.s7 + 0)
.s12:
1d96 : a5 1d __ LDA ACCU + 2 
1d98 : 30 0a __ BMI $1da4 ; (control_player_ship.s7 + 0)
.s1009:
1d9a : f0 08 __ BEQ $1da4 ; (control_player_ship.s7 + 0)
.s5:
1d9c : 18 __ __ CLC
1d9d : a5 44 __ LDA T3 + 0 
1d9f : 65 1e __ ADC ACCU + 3 
1da1 : 8d ba 24 STA $24ba ; (Player + 0)
.s7:
1da4 : a5 45 __ LDA T4 + 0 
1da6 : c9 05 __ CMP #$05
1da8 : 90 07 __ BCC $1db1 ; (control_player_ship.s14 + 0)
.s16:
1daa : ad 0f 25 LDA $250f ; (joyy + 0)
1dad : 30 0d __ BMI $1dbc ; (control_player_ship.s32 + 0)
.s1012:
1daf : a5 45 __ LDA T4 + 0 
.s14:
1db1 : c9 17 __ CMP #$17
1db3 : b0 0d __ BCS $1dc2 ; (control_player_ship.s3 + 0)
.s20:
1db5 : ad 0f 25 LDA $250f ; (joyy + 0)
1db8 : 30 08 __ BMI $1dc2 ; (control_player_ship.s3 + 0)
.s1004:
1dba : f0 06 __ BEQ $1dc2 ; (control_player_ship.s3 + 0)
.s32:
1dbc : 18 __ __ CLC
1dbd : 65 46 __ ADC T5 + 0 
1dbf : 8d bb 24 STA $24bb ; (Player + 1)
.s3:
1dc2 : ad 13 25 LDA $2513 ; (joyb + 0)
1dc5 : c9 01 __ CMP #$01
1dc7 : f0 01 __ BEQ $1dca ; (control_player_ship.s21 + 0)
.s1001:
1dc9 : 60 __ __ RTS
.s21:
1dca : 4c 0d 1e JMP $1e0d ; (spawn_player_shot.s0 + 0)
--------------------------------------------------------------------
joy_poll:
.s0:
1dcd : aa __ __ TAX
1dce : bd 00 dc LDA $dc00,x 
1dd1 : a8 __ __ TAY
1dd2 : 29 10 __ AND #$10
1dd4 : f0 04 __ BEQ $1dda ; (joy_poll.s1005 + 0)
.s1006:
1dd6 : a9 00 __ LDA #$00
1dd8 : f0 02 __ BEQ $1ddc ; (joy_poll.s1007 + 0)
.s1005:
1dda : a9 01 __ LDA #$01
.s1007:
1ddc : 9d 13 25 STA $2513,x ; (joyb + 0)
1ddf : 98 __ __ TYA
1de0 : 4a __ __ LSR
1de1 : b0 1d __ BCS $1e00 ; (joy_poll.s2 + 0)
.s1:
1de3 : a9 ff __ LDA #$ff
.s15:
1de5 : 9d 0f 25 STA $250f,x ; (joyy + 0)
1de8 : 98 __ __ TYA
1de9 : 29 04 __ AND #$04
1deb : d0 06 __ BNE $1df3 ; (joy_poll.s8 + 0)
.s7:
1ded : a9 ff __ LDA #$ff
.s1001:
1def : 9d 11 25 STA $2511,x ; (joyx + 0)
1df2 : 60 __ __ RTS
.s8:
1df3 : 98 __ __ TYA
1df4 : 29 08 __ AND #$08
1df6 : f0 04 __ BEQ $1dfc ; (joy_poll.s1011 + 0)
.s1012:
1df8 : a9 00 __ LDA #$00
1dfa : f0 f3 __ BEQ $1def ; (joy_poll.s1001 + 0)
.s1011:
1dfc : a9 01 __ LDA #$01
1dfe : d0 ef __ BNE $1def ; (joy_poll.s1001 + 0)
.s2:
1e00 : 98 __ __ TYA
1e01 : 29 02 __ AND #$02
1e03 : f0 04 __ BEQ $1e09 ; (joy_poll.s1008 + 0)
.s1009:
1e05 : a9 00 __ LDA #$00
1e07 : f0 dc __ BEQ $1de5 ; (joy_poll.s15 + 0)
.s1008:
1e09 : a9 01 __ LDA #$01
1e0b : d0 d8 __ BNE $1de5 ; (joy_poll.s15 + 0)
--------------------------------------------------------------------
joyy:
250f : __ __ __ BSS	2
--------------------------------------------------------------------
joyx:
2511 : __ __ __ BSS	2
--------------------------------------------------------------------
joyb:
2513 : __ __ __ BSS	2
--------------------------------------------------------------------
spawn_player_shot:
.s0:
1e0d : ad ba 24 LDA $24ba ; (Player + 0)
1e10 : c9 27 __ CMP #$27
1e12 : f0 0f __ BEQ $1e23 ; (spawn_player_shot.s1001 + 0)
.s3:
1e14 : a0 00 __ LDY #$00
.l6:
1e16 : be 25 24 LDX $2425,y ; (__multab3L + 0)
1e19 : bd f0 24 LDA $24f0,x ; (PlayerShot + 2)
1e1c : f0 06 __ BEQ $1e24 ; (spawn_player_shot.s9 + 0)
.s7:
1e1e : c8 __ __ INY
1e1f : c0 03 __ CPY #$03
1e21 : 90 f3 __ BCC $1e16 ; (spawn_player_shot.l6 + 0)
.s1001:
1e23 : 60 __ __ RTS
.s9:
1e24 : a9 01 __ LDA #$01
1e26 : 9d f0 24 STA $24f0,x ; (PlayerShot + 2)
1e29 : ad bb 24 LDA $24bb ; (Player + 1)
1e2c : 9d ef 24 STA $24ef,x ; (PlayerShot + 1)
1e2f : ad 11 25 LDA $2511 ; (joyx + 0)
1e32 : 30 02 __ BMI $1e36 ; (spawn_player_shot.s13 + 0)
.s1007:
1e34 : d0 06 __ BNE $1e3c ; (spawn_player_shot.s12 + 0)
.s13:
1e36 : ad ba 24 LDA $24ba ; (Player + 0)
1e39 : 4c 42 1e JMP $1e42 ; (spawn_player_shot.s1010 + 0)
.s12:
1e3c : ad ba 24 LDA $24ba ; (Player + 0)
1e3f : 18 __ __ CLC
1e40 : 69 01 __ ADC #$01
.s1010:
1e42 : be 25 24 LDX $2425,y ; (__multab3L + 0)
1e45 : 9d ee 24 STA $24ee,x ; (PlayerShot + 0)
1e48 : 60 __ __ RTS
--------------------------------------------------------------------
render_player_ship:
.s0:
1e49 : ad bb 24 LDA $24bb ; (Player + 1)
1e4c : 0a __ __ ASL
1e4d : 85 1b __ STA ACCU + 0 
1e4f : a9 00 __ LDA #$00
1e51 : 2a __ __ ROL
1e52 : 06 1b __ ASL ACCU + 0 
1e54 : 2a __ __ ROL
1e55 : aa __ __ TAX
1e56 : a5 1b __ LDA ACCU + 0 
1e58 : 6d bb 24 ADC $24bb ; (Player + 1)
1e5b : 85 1b __ STA ACCU + 0 
1e5d : 8a __ __ TXA
1e5e : 69 00 __ ADC #$00
1e60 : 06 1b __ ASL ACCU + 0 
1e62 : 2a __ __ ROL
1e63 : 06 1b __ ASL ACCU + 0 
1e65 : 2a __ __ ROL
1e66 : 06 1b __ ASL ACCU + 0 
1e68 : 2a __ __ ROL
1e69 : aa __ __ TAX
1e6a : 18 __ __ CLC
1e6b : a5 1b __ LDA ACCU + 0 
1e6d : 6d ba 24 ADC $24ba ; (Player + 0)
1e70 : 85 1b __ STA ACCU + 0 
1e72 : 85 1f __ STA ADDR + 0 
1e74 : 8a __ __ TXA
1e75 : 69 c0 __ ADC #$c0
1e77 : 85 1c __ STA ACCU + 1 
1e79 : 18 __ __ CLC
1e7a : 69 18 __ ADC #$18
1e7c : 85 20 __ STA ADDR + 1 
1e7e : a9 80 __ LDA #$80
1e80 : a0 00 __ LDY #$00
1e82 : 91 1b __ STA (ACCU + 0),y 
1e84 : a9 03 __ LDA #$03
1e86 : 91 1f __ STA (ADDR + 0),y 
.s1001:
1e88 : 60 __ __ RTS
--------------------------------------------------------------------
move_player_shots:
.s0:
1e89 : a2 00 __ LDX #$00
.l2:
1e8b : 86 1d __ STX ACCU + 2 
1e8d : bc 25 24 LDY $2425,x ; (__multab3L + 0)
1e90 : b9 f0 24 LDA $24f0,y ; (PlayerShot + 2)
1e93 : c9 01 __ CMP #$01
1e95 : d0 52 __ BNE $1ee9 ; (move_player_shots.s23 + 0)
.s5:
1e97 : 84 1e __ STY ACCU + 3 
1e99 : b9 ef 24 LDA $24ef,y ; (PlayerShot + 1)
1e9c : 0a __ __ ASL
1e9d : 85 1b __ STA ACCU + 0 
1e9f : a9 00 __ LDA #$00
1ea1 : 2a __ __ ROL
1ea2 : 06 1b __ ASL ACCU + 0 
1ea4 : 2a __ __ ROL
1ea5 : aa __ __ TAX
1ea6 : a5 1b __ LDA ACCU + 0 
1ea8 : 79 ef 24 ADC $24ef,y ; (PlayerShot + 1)
1eab : 85 1b __ STA ACCU + 0 
1ead : 8a __ __ TXA
1eae : 69 00 __ ADC #$00
1eb0 : 06 1b __ ASL ACCU + 0 
1eb2 : 2a __ __ ROL
1eb3 : 06 1b __ ASL ACCU + 0 
1eb5 : 2a __ __ ROL
1eb6 : 06 1b __ ASL ACCU + 0 
1eb8 : 2a __ __ ROL
1eb9 : 85 1c __ STA ACCU + 1 
1ebb : b9 ee 24 LDA $24ee,y ; (PlayerShot + 0)
1ebe : aa __ __ TAX
1ebf : 18 __ __ CLC
1ec0 : 65 1b __ ADC ACCU + 0 
1ec2 : 85 1b __ STA ACCU + 0 
1ec4 : 85 1f __ STA ADDR + 0 
1ec6 : a5 1c __ LDA ACCU + 1 
1ec8 : 69 c0 __ ADC #$c0
1eca : 85 1c __ STA ACCU + 1 
1ecc : 18 __ __ CLC
1ecd : 69 18 __ ADC #$18
1ecf : 85 20 __ STA ADDR + 1 
1ed1 : a9 20 __ LDA #$20
1ed3 : a0 00 __ LDY #$00
1ed5 : 91 1b __ STA (ACCU + 0),y 
1ed7 : 98 __ __ TYA
1ed8 : 91 1f __ STA (ADDR + 0),y 
1eda : e8 __ __ INX
1edb : 8a __ __ TXA
1edc : a6 1e __ LDX ACCU + 3 
1ede : 9d ee 24 STA $24ee,x ; (PlayerShot + 0)
1ee1 : c9 28 __ CMP #$28
1ee3 : 90 04 __ BCC $1ee9 ; (move_player_shots.s23 + 0)
.s8:
1ee5 : 98 __ __ TYA
1ee6 : 9d f0 24 STA $24f0,x ; (PlayerShot + 2)
.s23:
1ee9 : a6 1d __ LDX ACCU + 2 
1eeb : e8 __ __ INX
1eec : e0 03 __ CPX #$03
1eee : 90 9b __ BCC $1e8b ; (move_player_shots.l2 + 0)
.s1001:
1ef0 : 60 __ __ RTS
--------------------------------------------------------------------
render_player_shots:
.s0:
1ef1 : a2 00 __ LDX #$00
.l1006:
1ef3 : bc 25 24 LDY $2425,x ; (__multab3L + 0)
1ef6 : b9 f0 24 LDA $24f0,y ; (PlayerShot + 2)
1ef9 : c9 01 __ CMP #$01
1efb : d0 43 __ BNE $1f40 ; (render_player_shots.s19 + 0)
.s5:
1efd : b9 ef 24 LDA $24ef,y ; (PlayerShot + 1)
1f00 : 0a __ __ ASL
1f01 : 85 1b __ STA ACCU + 0 
1f03 : a9 00 __ LDA #$00
1f05 : 2a __ __ ROL
1f06 : 06 1b __ ASL ACCU + 0 
1f08 : 2a __ __ ROL
1f09 : 85 1c __ STA ACCU + 1 
1f0b : a5 1b __ LDA ACCU + 0 
1f0d : 79 ef 24 ADC $24ef,y ; (PlayerShot + 1)
1f10 : 85 1b __ STA ACCU + 0 
1f12 : a5 1c __ LDA ACCU + 1 
1f14 : 69 00 __ ADC #$00
1f16 : 06 1b __ ASL ACCU + 0 
1f18 : 2a __ __ ROL
1f19 : 06 1b __ ASL ACCU + 0 
1f1b : 2a __ __ ROL
1f1c : 06 1b __ ASL ACCU + 0 
1f1e : 2a __ __ ROL
1f1f : 85 1c __ STA ACCU + 1 
1f21 : 18 __ __ CLC
1f22 : a5 1b __ LDA ACCU + 0 
1f24 : 79 ee 24 ADC $24ee,y ; (PlayerShot + 0)
1f27 : 85 1b __ STA ACCU + 0 
1f29 : 85 1f __ STA ADDR + 0 
1f2b : a5 1c __ LDA ACCU + 1 
1f2d : 69 c0 __ ADC #$c0
1f2f : 85 1c __ STA ACCU + 1 
1f31 : 18 __ __ CLC
1f32 : 69 18 __ ADC #$18
1f34 : 85 20 __ STA ADDR + 1 
1f36 : a9 81 __ LDA #$81
1f38 : a0 00 __ LDY #$00
1f3a : 91 1b __ STA (ACCU + 0),y 
1f3c : a9 01 __ LDA #$01
1f3e : 91 1f __ STA (ADDR + 0),y 
.s19:
1f40 : e8 __ __ INX
1f41 : e0 03 __ CPX #$03
1f43 : 90 ae __ BCC $1ef3 ; (render_player_shots.l1006 + 0)
.s1001:
1f45 : 60 __ __ RTS
--------------------------------------------------------------------
wait_frames:
.s0:
1f46 : a5 0e __ LDA P1 ; (frames + 1)
1f48 : 30 1c __ BMI $1f66 ; (wait_frames.s1001 + 0)
.s1005:
1f4a : 05 0d __ ORA P0 ; (frames + 0)
1f4c : f0 18 __ BEQ $1f66 ; (wait_frames.s1001 + 0)
.s13:
1f4e : a0 00 __ LDY #$00
1f50 : a6 0e __ LDX P1 ; (frames + 1)
.l6:
1f52 : ad 11 d0 LDA $d011 
1f55 : 30 fb __ BMI $1f52 ; (wait_frames.l6 + 0)
.l9:
1f57 : ad 11 d0 LDA $d011 
1f5a : 10 fb __ BPL $1f57 ; (wait_frames.l9 + 0)
.s3:
1f5c : c8 __ __ INY
1f5d : 8a __ __ TXA
1f5e : 30 06 __ BMI $1f66 ; (wait_frames.s1001 + 0)
.s1004:
1f60 : d0 f0 __ BNE $1f52 ; (wait_frames.l6 + 0)
.s1002:
1f62 : c4 0d __ CPY P0 ; (frames + 0)
1f64 : 90 ec __ BCC $1f52 ; (wait_frames.l6 + 0)
.s1001:
1f66 : 60 __ __ RTS
--------------------------------------------------------------------
freg:
1f67 : b1 19 __ LDA (IP + 0),y 
1f69 : c8 __ __ INY
1f6a : aa __ __ TAX
1f6b : b5 00 __ LDA $00,x 
1f6d : 85 03 __ STA WORK + 0 
1f6f : b5 01 __ LDA $01,x 
1f71 : 85 04 __ STA WORK + 1 
1f73 : b5 02 __ LDA $02,x 
1f75 : 85 05 __ STA WORK + 2 
1f77 : b5 03 __ LDA WORK + 0,x 
1f79 : 85 06 __ STA WORK + 3 
1f7b : a5 05 __ LDA WORK + 2 
1f7d : 0a __ __ ASL
1f7e : a5 06 __ LDA WORK + 3 
1f80 : 2a __ __ ROL
1f81 : 85 08 __ STA WORK + 5 
1f83 : f0 06 __ BEQ $1f8b ; (freg + 36)
1f85 : a5 05 __ LDA WORK + 2 
1f87 : 09 80 __ ORA #$80
1f89 : 85 05 __ STA WORK + 2 
1f8b : a5 1d __ LDA ACCU + 2 
1f8d : 0a __ __ ASL
1f8e : a5 1e __ LDA ACCU + 3 
1f90 : 2a __ __ ROL
1f91 : 85 07 __ STA WORK + 4 
1f93 : f0 06 __ BEQ $1f9b ; (freg + 52)
1f95 : a5 1d __ LDA ACCU + 2 
1f97 : 09 80 __ ORA #$80
1f99 : 85 1d __ STA ACCU + 2 
1f9b : 60 __ __ RTS
1f9c : 06 1e __ ASL ACCU + 3 
1f9e : a5 07 __ LDA WORK + 4 
1fa0 : 6a __ __ ROR
1fa1 : 85 1e __ STA ACCU + 3 
1fa3 : b0 06 __ BCS $1fab ; (freg + 68)
1fa5 : a5 1d __ LDA ACCU + 2 
1fa7 : 29 7f __ AND #$7f
1fa9 : 85 1d __ STA ACCU + 2 
1fab : 60 __ __ RTS
--------------------------------------------------------------------
faddsub:
1fac : a9 ff __ LDA #$ff
1fae : c5 07 __ CMP WORK + 4 
1fb0 : f0 04 __ BEQ $1fb6 ; (faddsub + 10)
1fb2 : c5 08 __ CMP WORK + 5 
1fb4 : d0 11 __ BNE $1fc7 ; (faddsub + 27)
1fb6 : a5 1e __ LDA ACCU + 3 
1fb8 : 09 7f __ ORA #$7f
1fba : 85 1e __ STA ACCU + 3 
1fbc : a9 80 __ LDA #$80
1fbe : 85 1d __ STA ACCU + 2 
1fc0 : a9 00 __ LDA #$00
1fc2 : 85 1b __ STA ACCU + 0 
1fc4 : 85 1c __ STA ACCU + 1 
1fc6 : 60 __ __ RTS
1fc7 : 38 __ __ SEC
1fc8 : a5 07 __ LDA WORK + 4 
1fca : e5 08 __ SBC WORK + 5 
1fcc : f0 38 __ BEQ $2006 ; (faddsub + 90)
1fce : aa __ __ TAX
1fcf : b0 25 __ BCS $1ff6 ; (faddsub + 74)
1fd1 : e0 e9 __ CPX #$e9
1fd3 : b0 0e __ BCS $1fe3 ; (faddsub + 55)
1fd5 : a5 08 __ LDA WORK + 5 
1fd7 : 85 07 __ STA WORK + 4 
1fd9 : a9 00 __ LDA #$00
1fdb : 85 1b __ STA ACCU + 0 
1fdd : 85 1c __ STA ACCU + 1 
1fdf : 85 1d __ STA ACCU + 2 
1fe1 : f0 23 __ BEQ $2006 ; (faddsub + 90)
1fe3 : a5 1d __ LDA ACCU + 2 
1fe5 : 4a __ __ LSR
1fe6 : 66 1c __ ROR ACCU + 1 
1fe8 : 66 1b __ ROR ACCU + 0 
1fea : e8 __ __ INX
1feb : d0 f8 __ BNE $1fe5 ; (faddsub + 57)
1fed : 85 1d __ STA ACCU + 2 
1fef : a5 08 __ LDA WORK + 5 
1ff1 : 85 07 __ STA WORK + 4 
1ff3 : 4c 06 20 JMP $2006 ; (faddsub + 90)
1ff6 : e0 18 __ CPX #$18
1ff8 : b0 33 __ BCS $202d ; (faddsub + 129)
1ffa : a5 05 __ LDA WORK + 2 
1ffc : 4a __ __ LSR
1ffd : 66 04 __ ROR WORK + 1 
1fff : 66 03 __ ROR WORK + 0 
2001 : ca __ __ DEX
2002 : d0 f8 __ BNE $1ffc ; (faddsub + 80)
2004 : 85 05 __ STA WORK + 2 
2006 : a5 1e __ LDA ACCU + 3 
2008 : 29 80 __ AND #$80
200a : 85 1e __ STA ACCU + 3 
200c : 45 06 __ EOR WORK + 3 
200e : 30 31 __ BMI $2041 ; (faddsub + 149)
2010 : 18 __ __ CLC
2011 : a5 1b __ LDA ACCU + 0 
2013 : 65 03 __ ADC WORK + 0 
2015 : 85 1b __ STA ACCU + 0 
2017 : a5 1c __ LDA ACCU + 1 
2019 : 65 04 __ ADC WORK + 1 
201b : 85 1c __ STA ACCU + 1 
201d : a5 1d __ LDA ACCU + 2 
201f : 65 05 __ ADC WORK + 2 
2021 : 85 1d __ STA ACCU + 2 
2023 : 90 08 __ BCC $202d ; (faddsub + 129)
2025 : 66 1d __ ROR ACCU + 2 
2027 : 66 1c __ ROR ACCU + 1 
2029 : 66 1b __ ROR ACCU + 0 
202b : e6 07 __ INC WORK + 4 
202d : a5 07 __ LDA WORK + 4 
202f : c9 ff __ CMP #$ff
2031 : f0 83 __ BEQ $1fb6 ; (faddsub + 10)
2033 : 4a __ __ LSR
2034 : 05 1e __ ORA ACCU + 3 
2036 : 85 1e __ STA ACCU + 3 
2038 : b0 06 __ BCS $2040 ; (faddsub + 148)
203a : a5 1d __ LDA ACCU + 2 
203c : 29 7f __ AND #$7f
203e : 85 1d __ STA ACCU + 2 
2040 : 60 __ __ RTS
2041 : 38 __ __ SEC
2042 : a5 1b __ LDA ACCU + 0 
2044 : e5 03 __ SBC WORK + 0 
2046 : 85 1b __ STA ACCU + 0 
2048 : a5 1c __ LDA ACCU + 1 
204a : e5 04 __ SBC WORK + 1 
204c : 85 1c __ STA ACCU + 1 
204e : a5 1d __ LDA ACCU + 2 
2050 : e5 05 __ SBC WORK + 2 
2052 : 85 1d __ STA ACCU + 2 
2054 : b0 19 __ BCS $206f ; (faddsub + 195)
2056 : 38 __ __ SEC
2057 : a9 00 __ LDA #$00
2059 : e5 1b __ SBC ACCU + 0 
205b : 85 1b __ STA ACCU + 0 
205d : a9 00 __ LDA #$00
205f : e5 1c __ SBC ACCU + 1 
2061 : 85 1c __ STA ACCU + 1 
2063 : a9 00 __ LDA #$00
2065 : e5 1d __ SBC ACCU + 2 
2067 : 85 1d __ STA ACCU + 2 
2069 : a5 1e __ LDA ACCU + 3 
206b : 49 80 __ EOR #$80
206d : 85 1e __ STA ACCU + 3 
206f : a5 1d __ LDA ACCU + 2 
2071 : 30 ba __ BMI $202d ; (faddsub + 129)
2073 : 05 1c __ ORA ACCU + 1 
2075 : 05 1b __ ORA ACCU + 0 
2077 : f0 0f __ BEQ $2088 ; (faddsub + 220)
2079 : c6 07 __ DEC WORK + 4 
207b : f0 0b __ BEQ $2088 ; (faddsub + 220)
207d : 06 1b __ ASL ACCU + 0 
207f : 26 1c __ ROL ACCU + 1 
2081 : 26 1d __ ROL ACCU + 2 
2083 : 10 f4 __ BPL $2079 ; (faddsub + 205)
2085 : 4c 2d 20 JMP $202d ; (faddsub + 129)
2088 : a9 00 __ LDA #$00
208a : 85 1b __ STA ACCU + 0 
208c : 85 1c __ STA ACCU + 1 
208e : 85 1d __ STA ACCU + 2 
2090 : 85 1e __ STA ACCU + 3 
2092 : 60 __ __ RTS
--------------------------------------------------------------------
fmul:
2093 : a5 1b __ LDA ACCU + 0 
2095 : 05 1c __ ORA ACCU + 1 
2097 : 05 1d __ ORA ACCU + 2 
2099 : d0 03 __ BNE $209e ; (fmul + 11)
209b : 85 1e __ STA ACCU + 3 
209d : 60 __ __ RTS
209e : a5 03 __ LDA WORK + 0 
20a0 : 05 04 __ ORA WORK + 1 
20a2 : 05 05 __ ORA WORK + 2 
20a4 : d0 09 __ BNE $20af ; (fmul + 28)
20a6 : 85 1b __ STA ACCU + 0 
20a8 : 85 1c __ STA ACCU + 1 
20aa : 85 1d __ STA ACCU + 2 
20ac : 85 1e __ STA ACCU + 3 
20ae : 60 __ __ RTS
20af : a5 1e __ LDA ACCU + 3 
20b1 : 45 06 __ EOR WORK + 3 
20b3 : 29 80 __ AND #$80
20b5 : 85 1e __ STA ACCU + 3 
20b7 : a9 ff __ LDA #$ff
20b9 : c5 07 __ CMP WORK + 4 
20bb : f0 42 __ BEQ $20ff ; (fmul + 108)
20bd : c5 08 __ CMP WORK + 5 
20bf : f0 3e __ BEQ $20ff ; (fmul + 108)
20c1 : a9 00 __ LDA #$00
20c3 : 85 09 __ STA WORK + 6 
20c5 : 85 0a __ STA WORK + 7 
20c7 : 85 0b __ STA $0b 
20c9 : a4 1b __ LDY ACCU + 0 
20cb : a5 03 __ LDA WORK + 0 
20cd : d0 06 __ BNE $20d5 ; (fmul + 66)
20cf : a5 04 __ LDA WORK + 1 
20d1 : f0 0a __ BEQ $20dd ; (fmul + 74)
20d3 : d0 05 __ BNE $20da ; (fmul + 71)
20d5 : 20 34 21 JSR $2134 ; (fmul8 + 0)
20d8 : a5 04 __ LDA WORK + 1 
20da : 20 34 21 JSR $2134 ; (fmul8 + 0)
20dd : a5 05 __ LDA WORK + 2 
20df : 20 34 21 JSR $2134 ; (fmul8 + 0)
20e2 : 38 __ __ SEC
20e3 : a5 0b __ LDA $0b 
20e5 : 30 06 __ BMI $20ed ; (fmul + 90)
20e7 : 06 09 __ ASL WORK + 6 
20e9 : 26 0a __ ROL WORK + 7 
20eb : 2a __ __ ROL
20ec : 18 __ __ CLC
20ed : 29 7f __ AND #$7f
20ef : 85 0b __ STA $0b 
20f1 : a5 07 __ LDA WORK + 4 
20f3 : 65 08 __ ADC WORK + 5 
20f5 : 90 19 __ BCC $2110 ; (fmul + 125)
20f7 : e9 7f __ SBC #$7f
20f9 : b0 04 __ BCS $20ff ; (fmul + 108)
20fb : c9 ff __ CMP #$ff
20fd : d0 15 __ BNE $2114 ; (fmul + 129)
20ff : a5 1e __ LDA ACCU + 3 
2101 : 09 7f __ ORA #$7f
2103 : 85 1e __ STA ACCU + 3 
2105 : a9 80 __ LDA #$80
2107 : 85 1d __ STA ACCU + 2 
2109 : a9 00 __ LDA #$00
210b : 85 1b __ STA ACCU + 0 
210d : 85 1c __ STA ACCU + 1 
210f : 60 __ __ RTS
2110 : e9 7e __ SBC #$7e
2112 : 90 15 __ BCC $2129 ; (fmul + 150)
2114 : 4a __ __ LSR
2115 : 05 1e __ ORA ACCU + 3 
2117 : 85 1e __ STA ACCU + 3 
2119 : a9 00 __ LDA #$00
211b : 6a __ __ ROR
211c : 05 0b __ ORA $0b 
211e : 85 1d __ STA ACCU + 2 
2120 : a5 0a __ LDA WORK + 7 
2122 : 85 1c __ STA ACCU + 1 
2124 : a5 09 __ LDA WORK + 6 
2126 : 85 1b __ STA ACCU + 0 
2128 : 60 __ __ RTS
2129 : a9 00 __ LDA #$00
212b : 85 1b __ STA ACCU + 0 
212d : 85 1c __ STA ACCU + 1 
212f : 85 1d __ STA ACCU + 2 
2131 : 85 1e __ STA ACCU + 3 
2133 : 60 __ __ RTS
--------------------------------------------------------------------
fmul8:
2134 : 38 __ __ SEC
2135 : 6a __ __ ROR
2136 : 90 1e __ BCC $2156 ; (fmul8 + 34)
2138 : aa __ __ TAX
2139 : 18 __ __ CLC
213a : 98 __ __ TYA
213b : 65 09 __ ADC WORK + 6 
213d : 85 09 __ STA WORK + 6 
213f : a5 0a __ LDA WORK + 7 
2141 : 65 1c __ ADC ACCU + 1 
2143 : 85 0a __ STA WORK + 7 
2145 : a5 0b __ LDA $0b 
2147 : 65 1d __ ADC ACCU + 2 
2149 : 6a __ __ ROR
214a : 85 0b __ STA $0b 
214c : 8a __ __ TXA
214d : 66 0a __ ROR WORK + 7 
214f : 66 09 __ ROR WORK + 6 
2151 : 4a __ __ LSR
2152 : f0 0d __ BEQ $2161 ; (fmul8 + 45)
2154 : b0 e2 __ BCS $2138 ; (fmul8 + 4)
2156 : 66 0b __ ROR $0b 
2158 : 66 0a __ ROR WORK + 7 
215a : 66 09 __ ROR WORK + 6 
215c : 4a __ __ LSR
215d : 90 f7 __ BCC $2156 ; (fmul8 + 34)
215f : d0 d7 __ BNE $2138 ; (fmul8 + 4)
2161 : 60 __ __ RTS
--------------------------------------------------------------------
fdiv:
2162 : a5 1b __ LDA ACCU + 0 
2164 : 05 1c __ ORA ACCU + 1 
2166 : 05 1d __ ORA ACCU + 2 
2168 : d0 03 __ BNE $216d ; (fdiv + 11)
216a : 85 1e __ STA ACCU + 3 
216c : 60 __ __ RTS
216d : a5 1e __ LDA ACCU + 3 
216f : 45 06 __ EOR WORK + 3 
2171 : 29 80 __ AND #$80
2173 : 85 1e __ STA ACCU + 3 
2175 : a5 08 __ LDA WORK + 5 
2177 : f0 62 __ BEQ $21db ; (fdiv + 121)
2179 : a5 07 __ LDA WORK + 4 
217b : c9 ff __ CMP #$ff
217d : f0 5c __ BEQ $21db ; (fdiv + 121)
217f : a9 00 __ LDA #$00
2181 : 85 09 __ STA WORK + 6 
2183 : 85 0a __ STA WORK + 7 
2185 : 85 0b __ STA $0b 
2187 : a2 18 __ LDX #$18
2189 : a5 1b __ LDA ACCU + 0 
218b : c5 03 __ CMP WORK + 0 
218d : a5 1c __ LDA ACCU + 1 
218f : e5 04 __ SBC WORK + 1 
2191 : a5 1d __ LDA ACCU + 2 
2193 : e5 05 __ SBC WORK + 2 
2195 : 90 13 __ BCC $21aa ; (fdiv + 72)
2197 : a5 1b __ LDA ACCU + 0 
2199 : e5 03 __ SBC WORK + 0 
219b : 85 1b __ STA ACCU + 0 
219d : a5 1c __ LDA ACCU + 1 
219f : e5 04 __ SBC WORK + 1 
21a1 : 85 1c __ STA ACCU + 1 
21a3 : a5 1d __ LDA ACCU + 2 
21a5 : e5 05 __ SBC WORK + 2 
21a7 : 85 1d __ STA ACCU + 2 
21a9 : 38 __ __ SEC
21aa : 26 09 __ ROL WORK + 6 
21ac : 26 0a __ ROL WORK + 7 
21ae : 26 0b __ ROL $0b 
21b0 : ca __ __ DEX
21b1 : f0 0a __ BEQ $21bd ; (fdiv + 91)
21b3 : 06 1b __ ASL ACCU + 0 
21b5 : 26 1c __ ROL ACCU + 1 
21b7 : 26 1d __ ROL ACCU + 2 
21b9 : b0 dc __ BCS $2197 ; (fdiv + 53)
21bb : 90 cc __ BCC $2189 ; (fdiv + 39)
21bd : 38 __ __ SEC
21be : a5 0b __ LDA $0b 
21c0 : 30 06 __ BMI $21c8 ; (fdiv + 102)
21c2 : 06 09 __ ASL WORK + 6 
21c4 : 26 0a __ ROL WORK + 7 
21c6 : 2a __ __ ROL
21c7 : 18 __ __ CLC
21c8 : 29 7f __ AND #$7f
21ca : 85 0b __ STA $0b 
21cc : a5 07 __ LDA WORK + 4 
21ce : e5 08 __ SBC WORK + 5 
21d0 : 90 1a __ BCC $21ec ; (fdiv + 138)
21d2 : 18 __ __ CLC
21d3 : 69 7f __ ADC #$7f
21d5 : b0 04 __ BCS $21db ; (fdiv + 121)
21d7 : c9 ff __ CMP #$ff
21d9 : d0 15 __ BNE $21f0 ; (fdiv + 142)
21db : a5 1e __ LDA ACCU + 3 
21dd : 09 7f __ ORA #$7f
21df : 85 1e __ STA ACCU + 3 
21e1 : a9 80 __ LDA #$80
21e3 : 85 1d __ STA ACCU + 2 
21e5 : a9 00 __ LDA #$00
21e7 : 85 1c __ STA ACCU + 1 
21e9 : 85 1b __ STA ACCU + 0 
21eb : 60 __ __ RTS
21ec : 69 7f __ ADC #$7f
21ee : 90 15 __ BCC $2205 ; (fdiv + 163)
21f0 : 4a __ __ LSR
21f1 : 05 1e __ ORA ACCU + 3 
21f3 : 85 1e __ STA ACCU + 3 
21f5 : a9 00 __ LDA #$00
21f7 : 6a __ __ ROR
21f8 : 05 0b __ ORA $0b 
21fa : 85 1d __ STA ACCU + 2 
21fc : a5 0a __ LDA WORK + 7 
21fe : 85 1c __ STA ACCU + 1 
2200 : a5 09 __ LDA WORK + 6 
2202 : 85 1b __ STA ACCU + 0 
2204 : 60 __ __ RTS
2205 : a9 00 __ LDA #$00
2207 : 85 1e __ STA ACCU + 3 
2209 : 85 1d __ STA ACCU + 2 
220b : 85 1c __ STA ACCU + 1 
220d : 85 1b __ STA ACCU + 0 
220f : 60 __ __ RTS
--------------------------------------------------------------------
divs16:
2210 : 24 1c __ BIT ACCU + 1 
2212 : 10 0d __ BPL $2221 ; (divs16 + 17)
2214 : 20 2e 22 JSR $222e ; (negaccu + 0)
2217 : 24 04 __ BIT WORK + 1 
2219 : 10 0d __ BPL $2228 ; (divs16 + 24)
221b : 20 3c 22 JSR $223c ; (negtmp + 0)
221e : 4c 4a 22 JMP $224a ; (divmod + 0)
2221 : 24 04 __ BIT WORK + 1 
2223 : 10 f9 __ BPL $221e ; (divs16 + 14)
2225 : 20 3c 22 JSR $223c ; (negtmp + 0)
2228 : 20 4a 22 JSR $224a ; (divmod + 0)
222b : 4c 2e 22 JMP $222e ; (negaccu + 0)
--------------------------------------------------------------------
negaccu:
222e : 38 __ __ SEC
222f : a9 00 __ LDA #$00
2231 : e5 1b __ SBC ACCU + 0 
2233 : 85 1b __ STA ACCU + 0 
2235 : a9 00 __ LDA #$00
2237 : e5 1c __ SBC ACCU + 1 
2239 : 85 1c __ STA ACCU + 1 
223b : 60 __ __ RTS
--------------------------------------------------------------------
negtmp:
223c : 38 __ __ SEC
223d : a9 00 __ LDA #$00
223f : e5 03 __ SBC WORK + 0 
2241 : 85 03 __ STA WORK + 0 
2243 : a9 00 __ LDA #$00
2245 : e5 04 __ SBC WORK + 1 
2247 : 85 04 __ STA WORK + 1 
2249 : 60 __ __ RTS
--------------------------------------------------------------------
divmod:
224a : a5 1c __ LDA ACCU + 1 
224c : d0 31 __ BNE $227f ; (divmod + 53)
224e : a5 04 __ LDA WORK + 1 
2250 : d0 1e __ BNE $2270 ; (divmod + 38)
2252 : 85 06 __ STA WORK + 3 
2254 : a2 04 __ LDX #$04
2256 : 06 1b __ ASL ACCU + 0 
2258 : 2a __ __ ROL
2259 : c5 03 __ CMP WORK + 0 
225b : 90 02 __ BCC $225f ; (divmod + 21)
225d : e5 03 __ SBC WORK + 0 
225f : 26 1b __ ROL ACCU + 0 
2261 : 2a __ __ ROL
2262 : c5 03 __ CMP WORK + 0 
2264 : 90 02 __ BCC $2268 ; (divmod + 30)
2266 : e5 03 __ SBC WORK + 0 
2268 : 26 1b __ ROL ACCU + 0 
226a : ca __ __ DEX
226b : d0 eb __ BNE $2258 ; (divmod + 14)
226d : 85 05 __ STA WORK + 2 
226f : 60 __ __ RTS
2270 : a5 1b __ LDA ACCU + 0 
2272 : 85 05 __ STA WORK + 2 
2274 : a5 1c __ LDA ACCU + 1 
2276 : 85 06 __ STA WORK + 3 
2278 : a9 00 __ LDA #$00
227a : 85 1b __ STA ACCU + 0 
227c : 85 1c __ STA ACCU + 1 
227e : 60 __ __ RTS
227f : a5 04 __ LDA WORK + 1 
2281 : d0 1f __ BNE $22a2 ; (divmod + 88)
2283 : a5 03 __ LDA WORK + 0 
2285 : 30 1b __ BMI $22a2 ; (divmod + 88)
2287 : a9 00 __ LDA #$00
2289 : 85 06 __ STA WORK + 3 
228b : a2 10 __ LDX #$10
228d : 06 1b __ ASL ACCU + 0 
228f : 26 1c __ ROL ACCU + 1 
2291 : 2a __ __ ROL
2292 : c5 03 __ CMP WORK + 0 
2294 : 90 02 __ BCC $2298 ; (divmod + 78)
2296 : e5 03 __ SBC WORK + 0 
2298 : 26 1b __ ROL ACCU + 0 
229a : 26 1c __ ROL ACCU + 1 
229c : ca __ __ DEX
229d : d0 f2 __ BNE $2291 ; (divmod + 71)
229f : 85 05 __ STA WORK + 2 
22a1 : 60 __ __ RTS
22a2 : a9 00 __ LDA #$00
22a4 : 85 05 __ STA WORK + 2 
22a6 : 85 06 __ STA WORK + 3 
22a8 : 84 02 __ STY $02 
22aa : a0 10 __ LDY #$10
22ac : 18 __ __ CLC
22ad : 26 1b __ ROL ACCU + 0 
22af : 26 1c __ ROL ACCU + 1 
22b1 : 26 05 __ ROL WORK + 2 
22b3 : 26 06 __ ROL WORK + 3 
22b5 : 38 __ __ SEC
22b6 : a5 05 __ LDA WORK + 2 
22b8 : e5 03 __ SBC WORK + 0 
22ba : aa __ __ TAX
22bb : a5 06 __ LDA WORK + 3 
22bd : e5 04 __ SBC WORK + 1 
22bf : 90 04 __ BCC $22c5 ; (divmod + 123)
22c1 : 86 05 __ STX WORK + 2 
22c3 : 85 06 __ STA WORK + 3 
22c5 : 88 __ __ DEY
22c6 : d0 e5 __ BNE $22ad ; (divmod + 99)
22c8 : 26 1b __ ROL ACCU + 0 
22ca : 26 1c __ ROL ACCU + 1 
22cc : a4 02 __ LDY $02 
22ce : 60 __ __ RTS
--------------------------------------------------------------------
mods16:
22cf : 24 1c __ BIT ACCU + 1 
22d1 : 10 0d __ BPL $22e0 ; (mods16 + 17)
22d3 : 20 2e 22 JSR $222e ; (negaccu + 0)
22d6 : 24 04 __ BIT WORK + 1 
22d8 : 10 0d __ BPL $22e7 ; (mods16 + 24)
22da : 20 3c 22 JSR $223c ; (negtmp + 0)
22dd : 4c 4a 22 JMP $224a ; (divmod + 0)
22e0 : 24 04 __ BIT WORK + 1 
22e2 : 10 f9 __ BPL $22dd ; (mods16 + 14)
22e4 : 20 3c 22 JSR $223c ; (negtmp + 0)
22e7 : 20 4a 22 JSR $224a ; (divmod + 0)
22ea : 38 __ __ SEC
22eb : a9 00 __ LDA #$00
22ed : e5 05 __ SBC WORK + 2 
22ef : 85 05 __ STA WORK + 2 
22f1 : a9 00 __ LDA #$00
22f3 : e5 06 __ SBC WORK + 3 
22f5 : 85 06 __ STA WORK + 3 
22f7 : 60 __ __ RTS
--------------------------------------------------------------------
f32_to_i16:
22f8 : 20 8b 1f JSR $1f8b ; (freg + 36)
22fb : a5 07 __ LDA WORK + 4 
22fd : c9 7f __ CMP #$7f
22ff : b0 07 __ BCS $2308 ; (f32_to_i16 + 16)
2301 : a9 00 __ LDA #$00
2303 : 85 1b __ STA ACCU + 0 
2305 : 85 1c __ STA ACCU + 1 
2307 : 60 __ __ RTS
2308 : 38 __ __ SEC
2309 : e9 8e __ SBC #$8e
230b : 90 0a __ BCC $2317 ; (f32_to_i16 + 31)
230d : a9 ff __ LDA #$ff
230f : 85 1b __ STA ACCU + 0 
2311 : a9 7f __ LDA #$7f
2313 : 85 1c __ STA ACCU + 1 
2315 : d0 08 __ BNE $231f ; (f32_to_i16 + 39)
2317 : aa __ __ TAX
2318 : 46 1d __ LSR ACCU + 2 
231a : 66 1c __ ROR ACCU + 1 
231c : e8 __ __ INX
231d : d0 f9 __ BNE $2318 ; (f32_to_i16 + 32)
231f : 24 1e __ BIT ACCU + 3 
2321 : 10 0e __ BPL $2331 ; (f32_to_i16 + 57)
2323 : 38 __ __ SEC
2324 : a9 00 __ LDA #$00
2326 : e5 1c __ SBC ACCU + 1 
2328 : 85 1b __ STA ACCU + 0 
232a : a9 00 __ LDA #$00
232c : e5 1d __ SBC ACCU + 2 
232e : 85 1c __ STA ACCU + 1 
2330 : 60 __ __ RTS
2331 : a5 1c __ LDA ACCU + 1 
2333 : 85 1b __ STA ACCU + 0 
2335 : a5 1d __ LDA ACCU + 2 
2337 : 85 1c __ STA ACCU + 1 
2339 : 60 __ __ RTS
--------------------------------------------------------------------
sint16_to_float:
233a : 24 1c __ BIT ACCU + 1 
233c : 30 03 __ BMI $2341 ; (sint16_to_float + 7)
233e : 4c 58 23 JMP $2358 ; (uint16_to_float + 0)
2341 : 38 __ __ SEC
2342 : a9 00 __ LDA #$00
2344 : e5 1b __ SBC ACCU + 0 
2346 : 85 1b __ STA ACCU + 0 
2348 : a9 00 __ LDA #$00
234a : e5 1c __ SBC ACCU + 1 
234c : 85 1c __ STA ACCU + 1 
234e : 20 58 23 JSR $2358 ; (uint16_to_float + 0)
2351 : a5 1e __ LDA ACCU + 3 
2353 : 09 80 __ ORA #$80
2355 : 85 1e __ STA ACCU + 3 
2357 : 60 __ __ RTS
--------------------------------------------------------------------
uint16_to_float:
2358 : a5 1b __ LDA ACCU + 0 
235a : 05 1c __ ORA ACCU + 1 
235c : d0 05 __ BNE $2363 ; (uint16_to_float + 11)
235e : 85 1d __ STA ACCU + 2 
2360 : 85 1e __ STA ACCU + 3 
2362 : 60 __ __ RTS
2363 : a2 8e __ LDX #$8e
2365 : a5 1c __ LDA ACCU + 1 
2367 : 30 06 __ BMI $236f ; (uint16_to_float + 23)
2369 : ca __ __ DEX
236a : 06 1b __ ASL ACCU + 0 
236c : 2a __ __ ROL
236d : 10 fa __ BPL $2369 ; (uint16_to_float + 17)
236f : 29 7f __ AND #$7f
2371 : 85 1d __ STA ACCU + 2 
2373 : a5 1b __ LDA ACCU + 0 
2375 : 85 1c __ STA ACCU + 1 
2377 : 8a __ __ TXA
2378 : 4a __ __ LSR
2379 : 85 1e __ STA ACCU + 3 
237b : a9 00 __ LDA #$00
237d : 85 1b __ STA ACCU + 0 
237f : 6a __ __ ROR
2380 : 05 1d __ ORA ACCU + 2 
2382 : 85 1d __ STA ACCU + 2 
2384 : 60 __ __ RTS
--------------------------------------------------------------------
divmod32:
2385 : 84 02 __ STY $02 
2387 : a0 20 __ LDY #$20
2389 : a9 00 __ LDA #$00
238b : 85 07 __ STA WORK + 4 
238d : 85 08 __ STA WORK + 5 
238f : 85 09 __ STA WORK + 6 
2391 : 85 0a __ STA WORK + 7 
2393 : a5 05 __ LDA WORK + 2 
2395 : 05 06 __ ORA WORK + 3 
2397 : d0 39 __ BNE $23d2 ; (divmod32 + 77)
2399 : 18 __ __ CLC
239a : 26 1b __ ROL ACCU + 0 
239c : 26 1c __ ROL ACCU + 1 
239e : 26 1d __ ROL ACCU + 2 
23a0 : 26 1e __ ROL ACCU + 3 
23a2 : 26 07 __ ROL WORK + 4 
23a4 : 26 08 __ ROL WORK + 5 
23a6 : 90 0c __ BCC $23b4 ; (divmod32 + 47)
23a8 : a5 07 __ LDA WORK + 4 
23aa : e5 03 __ SBC WORK + 0 
23ac : aa __ __ TAX
23ad : a5 08 __ LDA WORK + 5 
23af : e5 04 __ SBC WORK + 1 
23b1 : 38 __ __ SEC
23b2 : b0 0c __ BCS $23c0 ; (divmod32 + 59)
23b4 : 38 __ __ SEC
23b5 : a5 07 __ LDA WORK + 4 
23b7 : e5 03 __ SBC WORK + 0 
23b9 : aa __ __ TAX
23ba : a5 08 __ LDA WORK + 5 
23bc : e5 04 __ SBC WORK + 1 
23be : 90 04 __ BCC $23c4 ; (divmod32 + 63)
23c0 : 86 07 __ STX WORK + 4 
23c2 : 85 08 __ STA WORK + 5 
23c4 : 88 __ __ DEY
23c5 : d0 d3 __ BNE $239a ; (divmod32 + 21)
23c7 : 26 1b __ ROL ACCU + 0 
23c9 : 26 1c __ ROL ACCU + 1 
23cb : 26 1d __ ROL ACCU + 2 
23cd : 26 1e __ ROL ACCU + 3 
23cf : a4 02 __ LDY $02 
23d1 : 60 __ __ RTS
23d2 : 18 __ __ CLC
23d3 : 26 1b __ ROL ACCU + 0 
23d5 : 26 1c __ ROL ACCU + 1 
23d7 : 26 1d __ ROL ACCU + 2 
23d9 : 26 1e __ ROL ACCU + 3 
23db : 26 07 __ ROL WORK + 4 
23dd : 26 08 __ ROL WORK + 5 
23df : 26 09 __ ROL WORK + 6 
23e1 : 26 0a __ ROL WORK + 7 
23e3 : a5 07 __ LDA WORK + 4 
23e5 : c5 03 __ CMP WORK + 0 
23e7 : a5 08 __ LDA WORK + 5 
23e9 : e5 04 __ SBC WORK + 1 
23eb : a5 09 __ LDA WORK + 6 
23ed : e5 05 __ SBC WORK + 2 
23ef : a5 0a __ LDA WORK + 7 
23f1 : e5 06 __ SBC WORK + 3 
23f3 : 90 18 __ BCC $240d ; (divmod32 + 136)
23f5 : a5 07 __ LDA WORK + 4 
23f7 : e5 03 __ SBC WORK + 0 
23f9 : 85 07 __ STA WORK + 4 
23fb : a5 08 __ LDA WORK + 5 
23fd : e5 04 __ SBC WORK + 1 
23ff : 85 08 __ STA WORK + 5 
2401 : a5 09 __ LDA WORK + 6 
2403 : e5 05 __ SBC WORK + 2 
2405 : 85 09 __ STA WORK + 6 
2407 : a5 0a __ LDA WORK + 7 
2409 : e5 06 __ SBC WORK + 3 
240b : 85 0a __ STA WORK + 7 
240d : 88 __ __ DEY
240e : d0 c3 __ BNE $23d3 ; (divmod32 + 78)
2410 : 26 1b __ ROL ACCU + 0 
2412 : 26 1c __ ROL ACCU + 1 
2414 : 26 1d __ ROL ACCU + 2 
2416 : 26 1e __ ROL ACCU + 3 
2418 : a4 02 __ LDY $02 
241a : 60 __ __ RTS
--------------------------------------------------------------------
__multab5L:
241b : __ __ __ BYT 00 05 0a 0f 14 19 1e 23 28 2d                   : .......#(-
--------------------------------------------------------------------
__multab3L:
2425 : __ __ __ BYT 00 03 06                                        : ...
