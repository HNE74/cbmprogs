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
080e : 8e 90 1f STX $1f90 ; (spentry + 0)
0811 : a9 b0 __ LDA #$b0
0813 : 85 19 __ STA IP + 0 
0815 : a9 1f __ LDA #$1f
0817 : 85 1a __ STA IP + 1 
0819 : 38 __ __ SEC
081a : a9 1f __ LDA #$1f
081c : e9 1f __ SBC #$1f
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
0830 : a9 e4 __ LDA #$e4
0832 : e9 b0 __ SBC #$b0
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
084b : a9 a5 __ LDA #$a5
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
1f90 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
main:
.s1000:
0880 : a5 53 __ LDA T0 + 0 
0882 : 8d a7 9f STA $9fa7 ; (main@stack + 0)
.s0:
0885 : 20 f1 08 JSR $08f1 ; (init_player.s0 + 0)
0888 : 20 fc 08 JSR $08fc ; (init_enemies.s0 + 0)
088b : 20 11 09 JSR $0911 ; (init_shots.s0 + 0)
088e : 20 26 09 JSR $0926 ; (init_game_state.s0 + 0)
0891 : 20 38 09 JSR $0938 ; (init_game_screen.s0 + 0)
0894 : ad d9 1f LDA $1fd9 ; (game + 0)
0897 : d0 4c __ BNE $08e5 ; (main.s4 + 0)
.s9:
0899 : 85 53 __ STA T0 + 0 
.l3:
089b : 20 4a 09 JSR $094a ; (render_game_state.s1000 + 0)
089e : a5 53 __ LDA T0 + 0 
08a0 : 85 1b __ STA ACCU + 0 
08a2 : a9 00 __ LDA #$00
08a4 : 85 1c __ STA ACCU + 1 
08a6 : 85 04 __ STA WORK + 1 
08a8 : a9 03 __ LDA #$03
08aa : 85 03 __ STA WORK + 0 
08ac : 20 b5 1d JSR $1db5 ; (divmod + 0)
08af : a5 05 __ LDA WORK + 2 
08b1 : 05 06 __ ORA WORK + 3 
08b3 : d0 09 __ BNE $08be ; (main.s7 + 0)
.s5:
08b5 : 20 48 16 JSR $1648 ; (spawn_enemy.s0 + 0)
08b8 : 20 ad 16 JSR $16ad ; (move_enemies.s0 + 0)
08bb : 20 68 17 JSR $1768 ; (render_enemies.s0 + 0)
.s7:
08be : 20 bd 17 JSR $17bd ; (check_player_enemy_collision.s0 + 0)
08c1 : 20 e5 17 JSR $17e5 ; (control_player_ship.s0 + 0)
08c4 : 20 03 19 JSR $1903 ; (render_player_ship.s0 + 0)
08c7 : 20 bd 17 JSR $17bd ; (check_player_enemy_collision.s0 + 0)
08ca : 20 43 19 JSR $1943 ; (move_player_shots.s0 + 0)
08cd : 20 ab 19 JSR $19ab ; (render_player_shots.s0 + 0)
08d0 : 20 00 1a JSR $1a00 ; (check_shot_enemy_collision.s0 + 0)
08d3 : a9 03 __ LDA #$03
08d5 : 85 0d __ STA P0 
08d7 : a9 00 __ LDA #$00
08d9 : 85 0e __ STA P1 
08db : 20 b1 1a JSR $1ab1 ; (wait_frames.s0 + 0)
08de : e6 53 __ INC T0 + 0 
08e0 : ad d9 1f LDA $1fd9 ; (game + 0)
08e3 : f0 b6 __ BEQ $089b ; (main.l3 + 0)
.s4:
08e5 : a9 00 __ LDA #$00
08e7 : 85 1b __ STA ACCU + 0 
08e9 : 85 1c __ STA ACCU + 1 
.s1001:
08eb : ad a7 9f LDA $9fa7 ; (main@stack + 0)
08ee : 85 53 __ STA T0 + 0 
08f0 : 60 __ __ RTS
--------------------------------------------------------------------
init_player:
.s0:
08f1 : a9 05 __ LDA #$05
08f3 : 8d b0 1f STA $1fb0 ; (Player + 0)
08f6 : a9 0c __ LDA #$0c
08f8 : 8d b1 1f STA $1fb1 ; (Player + 1)
.s1001:
08fb : 60 __ __ RTS
--------------------------------------------------------------------
Player:
1fb0 : __ __ __ BSS	2
--------------------------------------------------------------------
init_enemies:
.s0:
08fc : a0 0a __ LDY #$0a
08fe : a2 00 __ LDX #$00
0900 : 8a __ __ TXA
.l1004:
0901 : 9d b2 1f STA $1fb2,x ; (Enemy + 0)
0904 : 9d b3 1f STA $1fb3,x ; (Enemy + 1)
0907 : 9d b4 1f STA $1fb4,x ; (Enemy + 2)
090a : e8 __ __ INX
090b : e8 __ __ INX
090c : e8 __ __ INX
090d : 88 __ __ DEY
090e : d0 f1 __ BNE $0901 ; (init_enemies.l1004 + 0)
.s1001:
0910 : 60 __ __ RTS
--------------------------------------------------------------------
Enemy:
1fb2 : __ __ __ BSS	30
--------------------------------------------------------------------
init_shots:
.s0:
0911 : a0 03 __ LDY #$03
0913 : a2 00 __ LDX #$00
0915 : 8a __ __ TXA
.l1004:
0916 : 9d d0 1f STA $1fd0,x ; (PlayerShot + 0)
0919 : 9d d1 1f STA $1fd1,x ; (PlayerShot + 1)
091c : 9d d2 1f STA $1fd2,x ; (PlayerShot + 2)
091f : e8 __ __ INX
0920 : e8 __ __ INX
0921 : e8 __ __ INX
0922 : 88 __ __ DEY
0923 : d0 f1 __ BNE $0916 ; (init_shots.l1004 + 0)
.s1001:
0925 : 60 __ __ RTS
--------------------------------------------------------------------
PlayerShot:
1fd0 : __ __ __ BSS	9
--------------------------------------------------------------------
init_game_state:
.s0:
0926 : a9 00 __ LDA #$00
0928 : 8d d9 1f STA $1fd9 ; (game + 0)
092b : 8d da 1f STA $1fda ; (game + 1)
092e : 8d db 1f STA $1fdb ; (game + 2)
0931 : 8d dc 1f STA $1fdc ; (game + 3)
0934 : 8d dd 1f STA $1fdd ; (game + 4)
.s1001:
0937 : 60 __ __ RTS
--------------------------------------------------------------------
game:
1fd9 : __ __ __ BSS	5
--------------------------------------------------------------------
init_game_screen:
.s0:
0938 : 20 46 09 JSR $0946 ; (clrscr.s0 + 0)
093b : a9 00 __ LDA #$00
093d : 8d 21 d0 STA $d021 
0940 : a9 0b __ LDA #$0b
0942 : 8d 20 d0 STA $d020 
.s1001:
0945 : 60 __ __ RTS
--------------------------------------------------------------------
clrscr:
.s0:
0946 : 20 81 ff JSR $ff81 
.s1001:
0949 : 60 __ __ RTS
--------------------------------------------------------------------
render_game_state:
.s1000:
094a : 38 __ __ SEC
094b : a5 23 __ LDA SP + 0 
094d : e9 08 __ SBC #$08
094f : 85 23 __ STA SP + 0 
0951 : b0 02 __ BCS $0955 ; (render_game_state.s0 + 0)
0953 : c6 24 __ DEC SP + 1 
.s0:
0955 : a9 01 __ LDA #$01
0957 : 85 0d __ STA P0 
0959 : 85 0f __ STA P2 
095b : a9 00 __ LDA #$00
095d : 85 0e __ STA P1 
095f : 85 10 __ STA P3 
0961 : 20 96 09 JSR $0996 ; (gotoxy.s0 + 0)
0964 : a9 3d __ LDA #$3d
0966 : a0 02 __ LDY #$02
0968 : 91 23 __ STA (SP + 0),y 
096a : a9 16 __ LDA #$16
096c : c8 __ __ INY
096d : 91 23 __ STA (SP + 0),y 
096f : ad da 1f LDA $1fda ; (game + 1)
0972 : c8 __ __ INY
0973 : 91 23 __ STA (SP + 0),y 
0975 : ad db 1f LDA $1fdb ; (game + 2)
0978 : c8 __ __ INY
0979 : 91 23 __ STA (SP + 0),y 
097b : ad dc 1f LDA $1fdc ; (game + 3)
097e : c8 __ __ INY
097f : 91 23 __ STA (SP + 0),y 
0981 : ad dd 1f LDA $1fdd ; (game + 4)
0984 : c8 __ __ INY
0985 : 91 23 __ STA (SP + 0),y 
0987 : 20 9f 09 JSR $099f ; (printf.s0 + 0)
.s1001:
098a : 18 __ __ CLC
098b : a5 23 __ LDA SP + 0 
098d : 69 08 __ ADC #$08
098f : 85 23 __ STA SP + 0 
0991 : 90 02 __ BCC $0995 ; (render_game_state.s1001 + 11)
0993 : e6 24 __ INC SP + 1 
0995 : 60 __ __ RTS
--------------------------------------------------------------------
gotoxy:
.s0:
0996 : a6 0f __ LDX P2 
0998 : a4 0d __ LDY P0 
099a : 18 __ __ CLC
099b : 20 f0 ff JSR $fff0 
.s1001:
099e : 60 __ __ RTS
--------------------------------------------------------------------
printf:
.s0:
099f : a9 01 __ LDA #$01
09a1 : 8d ff 9f STA $9fff ; (sstack + 7)
09a4 : a9 a8 __ LDA #$a8
09a6 : 8d f9 9f STA $9ff9 ; (sstack + 1)
09a9 : a9 9f __ LDA #$9f
09ab : 8d fa 9f STA $9ffa ; (sstack + 2)
09ae : a0 02 __ LDY #$02
09b0 : b1 23 __ LDA (SP + 0),y 
09b2 : 8d fb 9f STA $9ffb ; (sstack + 3)
09b5 : c8 __ __ INY
09b6 : b1 23 __ LDA (SP + 0),y 
09b8 : 8d fc 9f STA $9ffc ; (sstack + 4)
09bb : 18 __ __ CLC
09bc : a5 23 __ LDA SP + 0 
09be : 69 04 __ ADC #$04
09c0 : 8d fd 9f STA $9ffd ; (sstack + 5)
09c3 : a5 24 __ LDA SP + 1 
09c5 : 69 00 __ ADC #$00
09c7 : 8d fe 9f STA $9ffe ; (sstack + 6)
09ca : 4c cd 09 JMP $09cd ; (sformat.s1000 + 0)
--------------------------------------------------------------------
sformat:
.s1000:
09cd : a2 05 __ LDX #$05
09cf : b5 53 __ LDA T1 + 0,x 
09d1 : 9d da 9f STA $9fda,x ; (sformat@stack + 0)
09d4 : ca __ __ DEX
09d5 : 10 f8 __ BPL $09cf ; (sformat.s1000 + 2)
.s0:
09d7 : a9 00 __ LDA #$00
09d9 : 85 50 __ STA T0 + 0 
09db : ad fb 9f LDA $9ffb ; (sstack + 3)
09de : 85 53 __ STA T1 + 0 
09e0 : ad fc 9f LDA $9ffc ; (sstack + 4)
09e3 : 85 54 __ STA T1 + 1 
09e5 : ad f9 9f LDA $9ff9 ; (sstack + 1)
09e8 : 85 55 __ STA T2 + 0 
09ea : ad fa 9f LDA $9ffa ; (sstack + 2)
09ed : 85 56 __ STA T2 + 1 
.l1:
09ef : a0 00 __ LDY #$00
09f1 : b1 53 __ LDA (T1 + 0),y 
09f3 : d0 38 __ BNE $0a2d ; (sformat.s2 + 0)
.s3:
09f5 : a4 50 __ LDY T0 + 0 
09f7 : 91 55 __ STA (T2 + 0),y 
09f9 : 98 __ __ TYA
09fa : f0 28 __ BEQ $0a24 ; (sformat.s1061 + 0)
.s112:
09fc : ad ff 9f LDA $9fff ; (sstack + 7)
09ff : d0 18 __ BNE $0a19 ; (sformat.s115 + 0)
.s116:
0a01 : 18 __ __ CLC
0a02 : a5 55 __ LDA T2 + 0 
0a04 : 65 50 __ ADC T0 + 0 
0a06 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0a08 : a5 56 __ LDA T2 + 1 
0a0a : 69 00 __ ADC #$00
.s1001:
0a0c : 85 1c __ STA ACCU + 1 ; (fmt + 0)
0a0e : a2 05 __ LDX #$05
0a10 : bd da 9f LDA $9fda,x ; (sformat@stack + 0)
0a13 : 95 53 __ STA T1 + 0,x 
0a15 : ca __ __ DEX
0a16 : 10 f8 __ BPL $0a10 ; (sformat.s1001 + 4)
0a18 : 60 __ __ RTS
.s115:
0a19 : a5 55 __ LDA T2 + 0 
0a1b : 85 0d __ STA P0 
0a1d : a5 56 __ LDA T2 + 1 
0a1f : 85 0e __ STA P1 
0a21 : 20 11 0e JSR $0e11 ; (puts.s0 + 0)
.s1061:
0a24 : a5 55 __ LDA T2 + 0 
0a26 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0a28 : a5 56 __ LDA T2 + 1 
0a2a : 4c 0c 0a JMP $0a0c ; (sformat.s1001 + 0)
.s2:
0a2d : c9 25 __ CMP #$25
0a2f : f0 3f __ BEQ $0a70 ; (sformat.s4 + 0)
.s5:
0a31 : a4 50 __ LDY T0 + 0 
0a33 : 91 55 __ STA (T2 + 0),y 
0a35 : e6 53 __ INC T1 + 0 
0a37 : d0 02 __ BNE $0a3b ; (sformat.s1090 + 0)
.s1089:
0a39 : e6 54 __ INC T1 + 1 
.s1090:
0a3b : c8 __ __ INY
0a3c : 84 50 __ STY T0 + 0 
0a3e : 98 __ __ TYA
0a3f : c0 28 __ CPY #$28
0a41 : 90 ac __ BCC $09ef ; (sformat.l1 + 0)
.s106:
0a43 : 85 57 __ STA T5 + 0 
0a45 : a9 00 __ LDA #$00
0a47 : 85 50 __ STA T0 + 0 
0a49 : ad ff 9f LDA $9fff ; (sstack + 7)
0a4c : f0 14 __ BEQ $0a62 ; (sformat.s110 + 0)
.s109:
0a4e : a5 55 __ LDA T2 + 0 
0a50 : 85 0d __ STA P0 
0a52 : a5 56 __ LDA T2 + 1 
0a54 : 85 0e __ STA P1 
0a56 : a9 00 __ LDA #$00
0a58 : a4 57 __ LDY T5 + 0 
0a5a : 91 0d __ STA (P0),y 
0a5c : 20 11 0e JSR $0e11 ; (puts.s0 + 0)
0a5f : 4c ef 09 JMP $09ef ; (sformat.l1 + 0)
.s110:
0a62 : 18 __ __ CLC
0a63 : a5 55 __ LDA T2 + 0 
0a65 : 65 57 __ ADC T5 + 0 
0a67 : 85 55 __ STA T2 + 0 
0a69 : 90 84 __ BCC $09ef ; (sformat.l1 + 0)
.s1092:
0a6b : e6 56 __ INC T2 + 1 
0a6d : 4c ef 09 JMP $09ef ; (sformat.l1 + 0)
.s4:
0a70 : a5 50 __ LDA T0 + 0 
0a72 : f0 27 __ BEQ $0a9b ; (sformat.s9 + 0)
.s7:
0a74 : 84 50 __ STY T0 + 0 
0a76 : 85 57 __ STA T5 + 0 
0a78 : ad ff 9f LDA $9fff ; (sstack + 7)
0a7b : f0 13 __ BEQ $0a90 ; (sformat.s11 + 0)
.s10:
0a7d : a5 55 __ LDA T2 + 0 
0a7f : 85 0d __ STA P0 
0a81 : a5 56 __ LDA T2 + 1 
0a83 : 85 0e __ STA P1 
0a85 : 98 __ __ TYA
0a86 : a4 57 __ LDY T5 + 0 
0a88 : 91 0d __ STA (P0),y 
0a8a : 20 11 0e JSR $0e11 ; (puts.s0 + 0)
0a8d : 4c 9b 0a JMP $0a9b ; (sformat.s9 + 0)
.s11:
0a90 : 18 __ __ CLC
0a91 : a5 55 __ LDA T2 + 0 
0a93 : 65 57 __ ADC T5 + 0 
0a95 : 85 55 __ STA T2 + 0 
0a97 : 90 02 __ BCC $0a9b ; (sformat.s9 + 0)
.s1087:
0a99 : e6 56 __ INC T2 + 1 
.s9:
0a9b : a9 0a __ LDA #$0a
0a9d : 8d e3 9f STA $9fe3 ; (si + 3)
0aa0 : a9 00 __ LDA #$00
0aa2 : 8d e4 9f STA $9fe4 ; (si + 4)
0aa5 : 8d e5 9f STA $9fe5 ; (si + 5)
0aa8 : 8d e6 9f STA $9fe6 ; (si + 6)
0aab : 8d e7 9f STA $9fe7 ; (si + 7)
0aae : a0 01 __ LDY #$01
0ab0 : b1 53 __ LDA (T1 + 0),y 
0ab2 : aa __ __ TAX
0ab3 : a9 20 __ LDA #$20
0ab5 : 8d e0 9f STA $9fe0 ; (si + 0)
0ab8 : a9 00 __ LDA #$00
0aba : 8d e1 9f STA $9fe1 ; (si + 1)
0abd : a9 ff __ LDA #$ff
0abf : 8d e2 9f STA $9fe2 ; (si + 2)
0ac2 : 18 __ __ CLC
0ac3 : a5 53 __ LDA T1 + 0 
0ac5 : 69 02 __ ADC #$02
.l14:
0ac7 : 85 53 __ STA T1 + 0 
0ac9 : 90 02 __ BCC $0acd ; (sformat.s1074 + 0)
.s1073:
0acb : e6 54 __ INC T1 + 1 
.s1074:
0acd : 8a __ __ TXA
0ace : e0 2b __ CPX #$2b
0ad0 : d0 08 __ BNE $0ada ; (sformat.s17 + 0)
.s16:
0ad2 : a9 01 __ LDA #$01
0ad4 : 8d e5 9f STA $9fe5 ; (si + 5)
0ad7 : 4c 04 0e JMP $0e04 ; (sformat.s224 + 0)
.s17:
0ada : c9 30 __ CMP #$30
0adc : d0 06 __ BNE $0ae4 ; (sformat.s20 + 0)
.s19:
0ade : 8d e0 9f STA $9fe0 ; (si + 0)
0ae1 : 4c 04 0e JMP $0e04 ; (sformat.s224 + 0)
.s20:
0ae4 : e0 23 __ CPX #$23
0ae6 : d0 08 __ BNE $0af0 ; (sformat.s23 + 0)
.s22:
0ae8 : a9 01 __ LDA #$01
0aea : 8d e7 9f STA $9fe7 ; (si + 7)
0aed : 4c 04 0e JMP $0e04 ; (sformat.s224 + 0)
.s23:
0af0 : e0 2d __ CPX #$2d
0af2 : d0 08 __ BNE $0afc ; (sformat.s15 + 0)
.s25:
0af4 : a9 01 __ LDA #$01
0af6 : 8d e6 9f STA $9fe6 ; (si + 6)
0af9 : 4c 04 0e JMP $0e04 ; (sformat.s224 + 0)
.s15:
0afc : 86 57 __ STX T5 + 0 
0afe : e0 30 __ CPX #$30
0b00 : 90 53 __ BCC $0b55 ; (sformat.s31 + 0)
.s32:
0b02 : e0 3a __ CPX #$3a
0b04 : b0 4f __ BCS $0b55 ; (sformat.s31 + 0)
.s29:
0b06 : a9 00 __ LDA #$00
0b08 : 85 44 __ STA T6 + 0 
0b0a : 85 45 __ STA T6 + 1 
0b0c : e0 3a __ CPX #$3a
0b0e : b0 40 __ BCS $0b50 ; (sformat.s35 + 0)
.l34:
0b10 : a5 44 __ LDA T6 + 0 
0b12 : 0a __ __ ASL
0b13 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0b15 : a5 45 __ LDA T6 + 1 
0b17 : 2a __ __ ROL
0b18 : 06 1b __ ASL ACCU + 0 ; (buff + 1)
0b1a : 2a __ __ ROL
0b1b : aa __ __ TAX
0b1c : 18 __ __ CLC
0b1d : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0b1f : 65 44 __ ADC T6 + 0 
0b21 : 85 44 __ STA T6 + 0 
0b23 : 8a __ __ TXA
0b24 : 65 45 __ ADC T6 + 1 
0b26 : 06 44 __ ASL T6 + 0 
0b28 : 2a __ __ ROL
0b29 : aa __ __ TAX
0b2a : 18 __ __ CLC
0b2b : a5 44 __ LDA T6 + 0 
0b2d : 65 57 __ ADC T5 + 0 
0b2f : 90 01 __ BCC $0b32 ; (sformat.s1084 + 0)
.s1083:
0b31 : e8 __ __ INX
.s1084:
0b32 : 38 __ __ SEC
0b33 : e9 30 __ SBC #$30
0b35 : 85 44 __ STA T6 + 0 
0b37 : 8a __ __ TXA
0b38 : e9 00 __ SBC #$00
0b3a : 85 45 __ STA T6 + 1 
0b3c : a0 00 __ LDY #$00
0b3e : b1 53 __ LDA (T1 + 0),y 
0b40 : 85 57 __ STA T5 + 0 
0b42 : e6 53 __ INC T1 + 0 
0b44 : d0 02 __ BNE $0b48 ; (sformat.s1086 + 0)
.s1085:
0b46 : e6 54 __ INC T1 + 1 
.s1086:
0b48 : c9 30 __ CMP #$30
0b4a : 90 04 __ BCC $0b50 ; (sformat.s35 + 0)
.s36:
0b4c : c9 3a __ CMP #$3a
0b4e : 90 c0 __ BCC $0b10 ; (sformat.l34 + 0)
.s35:
0b50 : a5 44 __ LDA T6 + 0 
0b52 : 8d e1 9f STA $9fe1 ; (si + 1)
.s31:
0b55 : a5 57 __ LDA T5 + 0 
0b57 : c9 2e __ CMP #$2e
0b59 : d0 51 __ BNE $0bac ; (sformat.s39 + 0)
.s37:
0b5b : a9 00 __ LDA #$00
0b5d : 85 44 __ STA T6 + 0 
.l203:
0b5f : 85 45 __ STA T6 + 1 
0b61 : a0 00 __ LDY #$00
0b63 : b1 53 __ LDA (T1 + 0),y 
0b65 : 85 57 __ STA T5 + 0 
0b67 : e6 53 __ INC T1 + 0 
0b69 : d0 02 __ BNE $0b6d ; (sformat.s1076 + 0)
.s1075:
0b6b : e6 54 __ INC T1 + 1 
.s1076:
0b6d : c9 30 __ CMP #$30
0b6f : 90 04 __ BCC $0b75 ; (sformat.s42 + 0)
.s43:
0b71 : c9 3a __ CMP #$3a
0b73 : 90 0a __ BCC $0b7f ; (sformat.s41 + 0)
.s42:
0b75 : a5 44 __ LDA T6 + 0 
0b77 : 8d e2 9f STA $9fe2 ; (si + 2)
0b7a : a5 57 __ LDA T5 + 0 
0b7c : 4c ac 0b JMP $0bac ; (sformat.s39 + 0)
.s41:
0b7f : a5 44 __ LDA T6 + 0 
0b81 : 0a __ __ ASL
0b82 : 85 1b __ STA ACCU + 0 ; (buff + 1)
0b84 : a5 45 __ LDA T6 + 1 
0b86 : 2a __ __ ROL
0b87 : 06 1b __ ASL ACCU + 0 ; (buff + 1)
0b89 : 2a __ __ ROL
0b8a : aa __ __ TAX
0b8b : 18 __ __ CLC
0b8c : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0b8e : 65 44 __ ADC T6 + 0 
0b90 : 85 44 __ STA T6 + 0 
0b92 : 8a __ __ TXA
0b93 : 65 45 __ ADC T6 + 1 
0b95 : 06 44 __ ASL T6 + 0 
0b97 : 2a __ __ ROL
0b98 : aa __ __ TAX
0b99 : 18 __ __ CLC
0b9a : a5 44 __ LDA T6 + 0 
0b9c : 65 57 __ ADC T5 + 0 
0b9e : 90 01 __ BCC $0ba1 ; (sformat.s1082 + 0)
.s1081:
0ba0 : e8 __ __ INX
.s1082:
0ba1 : 38 __ __ SEC
0ba2 : e9 30 __ SBC #$30
0ba4 : 85 44 __ STA T6 + 0 
0ba6 : 8a __ __ TXA
0ba7 : e9 00 __ SBC #$00
0ba9 : 4c 5f 0b JMP $0b5f ; (sformat.l203 + 0)
.s39:
0bac : c9 64 __ CMP #$64
0bae : d0 05 __ BNE $0bb5 ; (sformat.s45 + 0)
.s44:
0bb0 : a9 01 __ LDA #$01
0bb2 : 4c c8 0d JMP $0dc8 ; (sformat.s221 + 0)
.s45:
0bb5 : c9 75 __ CMP #$75
0bb7 : d0 03 __ BNE $0bbc ; (sformat.s48 + 0)
0bb9 : 4c c6 0d JMP $0dc6 ; (sformat.s250 + 0)
.s48:
0bbc : c9 78 __ CMP #$78
0bbe : d0 0d __ BNE $0bcd ; (sformat.s51 + 0)
.s50:
0bc0 : a9 10 __ LDA #$10
0bc2 : 8d e3 9f STA $9fe3 ; (si + 3)
0bc5 : a9 00 __ LDA #$00
0bc7 : 8d e4 9f STA $9fe4 ; (si + 4)
0bca : 4c c6 0d JMP $0dc6 ; (sformat.s250 + 0)
.s51:
0bcd : c9 6c __ CMP #$6c
0bcf : d0 03 __ BNE $0bd4 ; (sformat.s54 + 0)
0bd1 : 4c 41 0d JMP $0d41 ; (sformat.s53 + 0)
.s54:
0bd4 : c9 66 __ CMP #$66
0bd6 : f0 08 __ BEQ $0be0 ; (sformat.s65 + 0)
.s69:
0bd8 : c9 67 __ CMP #$67
0bda : f0 04 __ BEQ $0be0 ; (sformat.s65 + 0)
.s68:
0bdc : c9 65 __ CMP #$65
0bde : d0 4d __ BNE $0c2d ; (sformat.s66 + 0)
.s65:
0be0 : a5 55 __ LDA T2 + 0 
0be2 : 85 13 __ STA P6 
0be4 : a5 56 __ LDA T2 + 1 
0be6 : 85 14 __ STA P7 
0be8 : a5 57 __ LDA T5 + 0 
0bea : 8d f8 9f STA $9ff8 ; (sstack + 0)
0bed : a9 e0 __ LDA #$e0
0bef : 85 11 __ STA P4 
0bf1 : a9 9f __ LDA #$9f
0bf3 : 85 12 __ STA P5 
0bf5 : ad fd 9f LDA $9ffd ; (sstack + 5)
0bf8 : 85 57 __ STA T5 + 0 
0bfa : ad fe 9f LDA $9ffe ; (sstack + 6)
0bfd : 85 58 __ STA T5 + 1 
0bff : a0 00 __ LDY #$00
0c01 : b1 57 __ LDA (T5 + 0),y 
0c03 : 85 15 __ STA P8 
0c05 : c8 __ __ INY
0c06 : b1 57 __ LDA (T5 + 0),y 
0c08 : 85 16 __ STA P9 
0c0a : c8 __ __ INY
0c0b : b1 57 __ LDA (T5 + 0),y 
0c0d : 85 17 __ STA P10 
0c0f : c8 __ __ INY
0c10 : b1 57 __ LDA (T5 + 0),y 
0c12 : 85 18 __ STA P11 
0c14 : 20 5d 11 JSR $115d ; (nformf.s0 + 0)
0c17 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0c19 : 85 50 __ STA T0 + 0 
0c1b : 18 __ __ CLC
0c1c : a5 57 __ LDA T5 + 0 
0c1e : 69 04 __ ADC #$04
0c20 : 8d fd 9f STA $9ffd ; (sstack + 5)
0c23 : a5 58 __ LDA T5 + 1 
0c25 : 69 00 __ ADC #$00
0c27 : 8d fe 9f STA $9ffe ; (sstack + 6)
0c2a : 4c ef 09 JMP $09ef ; (sformat.l1 + 0)
.s66:
0c2d : c9 73 __ CMP #$73
0c2f : f0 4c __ BEQ $0c7d ; (sformat.s70 + 0)
.s71:
0c31 : c9 63 __ CMP #$63
0c33 : f0 1f __ BEQ $0c54 ; (sformat.s100 + 0)
.s101:
0c35 : 09 00 __ ORA #$00
0c37 : d0 03 __ BNE $0c3c ; (sformat.s103 + 0)
0c39 : 4c ef 09 JMP $09ef ; (sformat.l1 + 0)
.s103:
0c3c : 18 __ __ CLC
0c3d : a5 55 __ LDA T2 + 0 
0c3f : 65 50 __ ADC T0 + 0 
0c41 : 85 44 __ STA T6 + 0 
0c43 : a5 56 __ LDA T2 + 1 
0c45 : 69 00 __ ADC #$00
0c47 : 85 45 __ STA T6 + 1 
0c49 : a5 57 __ LDA T5 + 0 
.s1059:
0c4b : a0 00 __ LDY #$00
0c4d : 91 44 __ STA (T6 + 0),y 
0c4f : e6 50 __ INC T0 + 0 
0c51 : 4c ef 09 JMP $09ef ; (sformat.l1 + 0)
.s100:
0c54 : ad fd 9f LDA $9ffd ; (sstack + 5)
0c57 : 85 57 __ STA T5 + 0 
0c59 : 18 __ __ CLC
0c5a : 69 02 __ ADC #$02
0c5c : 8d fd 9f STA $9ffd ; (sstack + 5)
0c5f : ad fe 9f LDA $9ffe ; (sstack + 6)
0c62 : 85 58 __ STA T5 + 1 
0c64 : 69 00 __ ADC #$00
0c66 : 8d fe 9f STA $9ffe ; (sstack + 6)
0c69 : 18 __ __ CLC
0c6a : a5 55 __ LDA T2 + 0 
0c6c : 65 50 __ ADC T0 + 0 
0c6e : 85 44 __ STA T6 + 0 
0c70 : a5 56 __ LDA T2 + 1 
0c72 : 69 00 __ ADC #$00
0c74 : 85 45 __ STA T6 + 1 
0c76 : a0 00 __ LDY #$00
0c78 : b1 57 __ LDA (T5 + 0),y 
0c7a : 4c 4b 0c JMP $0c4b ; (sformat.s1059 + 0)
.s70:
0c7d : ad fd 9f LDA $9ffd ; (sstack + 5)
0c80 : 85 57 __ STA T5 + 0 
0c82 : 18 __ __ CLC
0c83 : 69 02 __ ADC #$02
0c85 : 8d fd 9f STA $9ffd ; (sstack + 5)
0c88 : ad fe 9f LDA $9ffe ; (sstack + 6)
0c8b : 85 58 __ STA T5 + 1 
0c8d : 69 00 __ ADC #$00
0c8f : 8d fe 9f STA $9ffe ; (sstack + 6)
0c92 : a0 00 __ LDY #$00
0c94 : b1 57 __ LDA (T5 + 0),y 
0c96 : aa __ __ TAX
0c97 : c8 __ __ INY
0c98 : b1 57 __ LDA (T5 + 0),y 
0c9a : 86 57 __ STX T5 + 0 
0c9c : 85 58 __ STA T5 + 1 
0c9e : a9 00 __ LDA #$00
0ca0 : 85 52 __ STA T3 + 0 
0ca2 : ad e1 9f LDA $9fe1 ; (si + 1)
0ca5 : f0 0c __ BEQ $0cb3 ; (sformat.s75 + 0)
.s1065:
0ca7 : 88 __ __ DEY
0ca8 : b1 57 __ LDA (T5 + 0),y 
0caa : f0 05 __ BEQ $0cb1 ; (sformat.s1066 + 0)
.l77:
0cac : c8 __ __ INY
0cad : b1 57 __ LDA (T5 + 0),y 
0caf : d0 fb __ BNE $0cac ; (sformat.l77 + 0)
.s1066:
0cb1 : 84 52 __ STY T3 + 0 
.s75:
0cb3 : ad e6 9f LDA $9fe6 ; (si + 6)
0cb6 : d0 19 __ BNE $0cd1 ; (sformat.s81 + 0)
.s1069:
0cb8 : a6 52 __ LDX T3 + 0 
0cba : ec e1 9f CPX $9fe1 ; (si + 1)
0cbd : a4 50 __ LDY T0 + 0 
0cbf : b0 0c __ BCS $0ccd ; (sformat.s1070 + 0)
.l83:
0cc1 : ad e0 9f LDA $9fe0 ; (si + 0)
0cc4 : 91 55 __ STA (T2 + 0),y 
0cc6 : e8 __ __ INX
0cc7 : ec e1 9f CPX $9fe1 ; (si + 1)
0cca : c8 __ __ INY
0ccb : 90 f4 __ BCC $0cc1 ; (sformat.l83 + 0)
.s1070:
0ccd : 86 52 __ STX T3 + 0 
0ccf : 84 50 __ STY T0 + 0 
.s81:
0cd1 : ad ff 9f LDA $9fff ; (sstack + 7)
0cd4 : d0 37 __ BNE $0d0d ; (sformat.s85 + 0)
.l91:
0cd6 : a0 00 __ LDY #$00
0cd8 : b1 57 __ LDA (T5 + 0),y 
0cda : f0 0f __ BEQ $0ceb ; (sformat.s211 + 0)
.s92:
0cdc : a4 50 __ LDY T0 + 0 
0cde : 91 55 __ STA (T2 + 0),y 
0ce0 : e6 50 __ INC T0 + 0 
0ce2 : e6 57 __ INC T5 + 0 
0ce4 : d0 f0 __ BNE $0cd6 ; (sformat.l91 + 0)
.s1079:
0ce6 : e6 58 __ INC T5 + 1 
0ce8 : 4c d6 0c JMP $0cd6 ; (sformat.l91 + 0)
.s211:
0ceb : ad e6 9f LDA $9fe6 ; (si + 6)
0cee : d0 03 __ BNE $0cf3 ; (sformat.s1067 + 0)
0cf0 : 4c ef 09 JMP $09ef ; (sformat.l1 + 0)
.s1067:
0cf3 : a6 52 __ LDX T3 + 0 
0cf5 : ec e1 9f CPX $9fe1 ; (si + 1)
0cf8 : a4 50 __ LDY T0 + 0 
0cfa : b0 0c __ BCS $0d08 ; (sformat.s1068 + 0)
.l98:
0cfc : ad e0 9f LDA $9fe0 ; (si + 0)
0cff : 91 55 __ STA (T2 + 0),y 
0d01 : e8 __ __ INX
0d02 : ec e1 9f CPX $9fe1 ; (si + 1)
0d05 : c8 __ __ INY
0d06 : 90 f4 __ BCC $0cfc ; (sformat.l98 + 0)
.s1068:
0d08 : 84 50 __ STY T0 + 0 
0d0a : 4c ef 09 JMP $09ef ; (sformat.l1 + 0)
.s85:
0d0d : a5 50 __ LDA T0 + 0 
0d0f : f0 22 __ BEQ $0d33 ; (sformat.s90 + 0)
.s88:
0d11 : a5 55 __ LDA T2 + 0 
0d13 : 85 0d __ STA P0 
0d15 : a5 56 __ LDA T2 + 1 
0d17 : 85 0e __ STA P1 
0d19 : a9 00 __ LDA #$00
0d1b : a4 50 __ LDY T0 + 0 
0d1d : 91 0d __ STA (P0),y 
0d1f : 20 11 0e JSR $0e11 ; (puts.s0 + 0)
0d22 : a5 57 __ LDA T5 + 0 
0d24 : 85 0d __ STA P0 
0d26 : a5 58 __ LDA T5 + 1 
0d28 : 85 0e __ STA P1 
0d2a : 20 11 0e JSR $0e11 ; (puts.s0 + 0)
0d2d : a9 00 __ LDA #$00
0d2f : 85 50 __ STA T0 + 0 
0d31 : f0 b8 __ BEQ $0ceb ; (sformat.s211 + 0)
.s90:
0d33 : a5 57 __ LDA T5 + 0 
0d35 : 85 0d __ STA P0 
0d37 : a5 58 __ LDA T5 + 1 
0d39 : 85 0e __ STA P1 
0d3b : 20 11 0e JSR $0e11 ; (puts.s0 + 0)
0d3e : 4c eb 0c JMP $0ceb ; (sformat.s211 + 0)
.s53:
0d41 : ad fd 9f LDA $9ffd ; (sstack + 5)
0d44 : 85 57 __ STA T5 + 0 
0d46 : 18 __ __ CLC
0d47 : 69 04 __ ADC #$04
0d49 : 8d fd 9f STA $9ffd ; (sstack + 5)
0d4c : ad fe 9f LDA $9ffe ; (sstack + 6)
0d4f : 85 58 __ STA T5 + 1 
0d51 : 69 00 __ ADC #$00
0d53 : 8d fe 9f STA $9ffe ; (sstack + 6)
0d56 : a0 00 __ LDY #$00
0d58 : b1 53 __ LDA (T1 + 0),y 
0d5a : 85 52 __ STA T3 + 0 
0d5c : e6 53 __ INC T1 + 0 
0d5e : d0 02 __ BNE $0d62 ; (sformat.s1078 + 0)
.s1077:
0d60 : e6 54 __ INC T1 + 1 
.s1078:
0d62 : c9 64 __ CMP #$64
0d64 : d0 04 __ BNE $0d6a ; (sformat.s1019 + 0)
.s1018:
0d66 : a2 01 __ LDX #$01
0d68 : d0 02 __ BNE $0d6c ; (sformat.s1020 + 0)
.s1019:
0d6a : a2 00 __ LDX #$00
.s1020:
0d6c : b1 57 __ LDA (T5 + 0),y 
0d6e : 85 46 __ STA T7 + 0 
0d70 : a0 01 __ LDY #$01
0d72 : b1 57 __ LDA (T5 + 0),y 
0d74 : 85 47 __ STA T7 + 1 
0d76 : c8 __ __ INY
0d77 : b1 57 __ LDA (T5 + 0),y 
0d79 : 85 48 __ STA T7 + 2 
0d7b : c8 __ __ INY
0d7c : b1 57 __ LDA (T5 + 0),y 
0d7e : a8 __ __ TAY
0d7f : 8a __ __ TXA
0d80 : f0 04 __ BEQ $0d86 ; (sformat.s57 + 0)
.s56:
0d82 : a9 01 __ LDA #$01
0d84 : d0 16 __ BNE $0d9c ; (sformat.s222 + 0)
.s57:
0d86 : a5 52 __ LDA T3 + 0 
0d88 : c9 75 __ CMP #$75
0d8a : f0 0f __ BEQ $0d9b ; (sformat.s251 + 0)
.s60:
0d8c : c9 78 __ CMP #$78
0d8e : f0 03 __ BEQ $0d93 ; (sformat.s62 + 0)
0d90 : 4c ef 09 JMP $09ef ; (sformat.l1 + 0)
.s62:
0d93 : 8e e4 9f STX $9fe4 ; (si + 4)
0d96 : a9 10 __ LDA #$10
0d98 : 8d e3 9f STA $9fe3 ; (si + 3)
.s251:
0d9b : 8a __ __ TXA
.s222:
0d9c : 84 14 __ STY P7 
0d9e : 85 15 __ STA P8 
0da0 : a5 55 __ LDA T2 + 0 
0da2 : 85 0f __ STA P2 
0da4 : a5 56 __ LDA T2 + 1 
0da6 : 85 10 __ STA P3 
0da8 : a5 46 __ LDA T7 + 0 
0daa : 85 11 __ STA P4 
0dac : a5 47 __ LDA T7 + 1 
0dae : 85 12 __ STA P5 
0db0 : a5 48 __ LDA T7 + 2 
0db2 : 85 13 __ STA P6 
0db4 : a9 e0 __ LDA #$e0
0db6 : 85 0d __ STA P0 
0db8 : a9 9f __ LDA #$9f
0dba : 85 0e __ STA P1 
0dbc : 20 c5 0f JSR $0fc5 ; (nforml.s0 + 0)
.s1062:
0dbf : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0dc1 : 85 50 __ STA T0 + 0 
0dc3 : 4c ef 09 JMP $09ef ; (sformat.l1 + 0)
.s250:
0dc6 : a9 00 __ LDA #$00
.s221:
0dc8 : 85 13 __ STA P6 
0dca : a5 55 __ LDA T2 + 0 
0dcc : 85 0f __ STA P2 
0dce : a5 56 __ LDA T2 + 1 
0dd0 : 85 10 __ STA P3 
0dd2 : ad fd 9f LDA $9ffd ; (sstack + 5)
0dd5 : 85 50 __ STA T0 + 0 
0dd7 : ad fe 9f LDA $9ffe ; (sstack + 6)
0dda : 85 51 __ STA T0 + 1 
0ddc : a0 00 __ LDY #$00
0dde : b1 50 __ LDA (T0 + 0),y 
0de0 : 85 11 __ STA P4 
0de2 : c8 __ __ INY
0de3 : b1 50 __ LDA (T0 + 0),y 
0de5 : 85 12 __ STA P5 
0de7 : 18 __ __ CLC
0de8 : a5 50 __ LDA T0 + 0 
0dea : 69 02 __ ADC #$02
0dec : 8d fd 9f STA $9ffd ; (sstack + 5)
0def : a5 51 __ LDA T0 + 1 
0df1 : 69 00 __ ADC #$00
0df3 : 8d fe 9f STA $9ffe ; (sstack + 6)
0df6 : a9 e0 __ LDA #$e0
0df8 : 85 0d __ STA P0 
0dfa : a9 9f __ LDA #$9f
0dfc : 85 0e __ STA P1 
0dfe : 20 66 0e JSR $0e66 ; (nformi.s0 + 0)
0e01 : 4c bf 0d JMP $0dbf ; (sformat.s1062 + 0)
.s224:
0e04 : a0 00 __ LDY #$00
0e06 : b1 53 __ LDA (T1 + 0),y 
0e08 : aa __ __ TAX
0e09 : 18 __ __ CLC
0e0a : a5 53 __ LDA T1 + 0 
0e0c : 69 01 __ ADC #$01
0e0e : 4c c7 0a JMP $0ac7 ; (sformat.l14 + 0)
--------------------------------------------------------------------
puts:
.s0:
0e11 : a0 00 __ LDY #$00
0e13 : b1 0d __ LDA (P0),y 
0e15 : f0 0b __ BEQ $0e22 ; (puts.s1001 + 0)
0e17 : 20 23 0e JSR $0e23 ; (putpch + 0)
0e1a : e6 0d __ INC P0 
0e1c : d0 f3 __ BNE $0e11 ; (puts.s0 + 0)
0e1e : e6 0e __ INC P1 
0e20 : d0 ef __ BNE $0e11 ; (puts.s0 + 0)
.s1001:
0e22 : 60 __ __ RTS
--------------------------------------------------------------------
putpch:
0e23 : ae 91 1f LDX $1f91 ; (giocharmap + 0)
0e26 : e0 01 __ CPX #$01
0e28 : 90 26 __ BCC $0e50 ; (putpch + 45)
0e2a : c9 0a __ CMP #$0a
0e2c : d0 02 __ BNE $0e30 ; (putpch + 13)
0e2e : a9 0d __ LDA #$0d
0e30 : c9 09 __ CMP #$09
0e32 : f0 1f __ BEQ $0e53 ; (putpch + 48)
0e34 : e0 02 __ CPX #$02
0e36 : 90 18 __ BCC $0e50 ; (putpch + 45)
0e38 : c9 41 __ CMP #$41
0e3a : 90 14 __ BCC $0e50 ; (putpch + 45)
0e3c : c9 7b __ CMP #$7b
0e3e : b0 10 __ BCS $0e50 ; (putpch + 45)
0e40 : c9 61 __ CMP #$61
0e42 : b0 04 __ BCS $0e48 ; (putpch + 37)
0e44 : c9 5b __ CMP #$5b
0e46 : b0 08 __ BCS $0e50 ; (putpch + 45)
0e48 : 49 20 __ EOR #$20
0e4a : e0 03 __ CPX #$03
0e4c : f0 02 __ BEQ $0e50 ; (putpch + 45)
0e4e : 29 df __ AND #$df
0e50 : 4c d2 ff JMP $ffd2 
0e53 : 38 __ __ SEC
0e54 : 20 f0 ff JSR $fff0 
0e57 : 98 __ __ TYA
0e58 : 29 03 __ AND #$03
0e5a : 49 03 __ EOR #$03
0e5c : aa __ __ TAX
0e5d : a9 20 __ LDA #$20
0e5f : 20 d2 ff JSR $ffd2 
0e62 : ca __ __ DEX
0e63 : 10 fa __ BPL $0e5f ; (putpch + 60)
0e65 : 60 __ __ RTS
--------------------------------------------------------------------
giocharmap:
1f91 : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
nformi:
.s0:
0e66 : a9 00 __ LDA #$00
0e68 : 85 43 __ STA T0 + 0 
0e6a : a5 13 __ LDA P6 ; (s + 0)
0e6c : f0 15 __ BEQ $0e83 ; (nformi.s159 + 0)
.s4:
0e6e : a5 12 __ LDA P5 ; (v + 1)
0e70 : 10 11 __ BPL $0e83 ; (nformi.s159 + 0)
.s1:
0e72 : 38 __ __ SEC
0e73 : a9 00 __ LDA #$00
0e75 : e5 11 __ SBC P4 ; (v + 0)
0e77 : 85 11 __ STA P4 ; (v + 0)
0e79 : a9 00 __ LDA #$00
0e7b : e5 12 __ SBC P5 ; (v + 1)
0e7d : 85 12 __ STA P5 ; (v + 1)
0e7f : a9 01 __ LDA #$01
0e81 : 85 43 __ STA T0 + 0 
.s159:
0e83 : a9 10 __ LDA #$10
0e85 : 85 44 __ STA T2 + 0 
0e87 : a5 11 __ LDA P4 ; (v + 0)
0e89 : 05 12 __ ORA P5 ; (v + 1)
0e8b : f0 61 __ BEQ $0eee ; (nformi.s7 + 0)
.s45:
0e8d : a5 0d __ LDA P0 ; (si + 0)
0e8f : 85 45 __ STA T4 + 0 
0e91 : a5 0e __ LDA P1 ; (si + 1)
0e93 : 85 46 __ STA T4 + 1 
.l6:
0e95 : a0 03 __ LDY #$03
0e97 : b1 45 __ LDA (T4 + 0),y 
0e99 : 85 47 __ STA T5 + 0 
0e9b : 85 03 __ STA WORK + 0 
0e9d : c8 __ __ INY
0e9e : b1 45 __ LDA (T4 + 0),y 
0ea0 : 85 48 __ STA T5 + 1 
0ea2 : 85 04 __ STA WORK + 1 
0ea4 : a5 11 __ LDA P4 ; (v + 0)
0ea6 : 85 1b __ STA ACCU + 0 
0ea8 : a5 12 __ LDA P5 ; (v + 1)
0eaa : 85 1c __ STA ACCU + 1 
0eac : 20 b5 1d JSR $1db5 ; (divmod + 0)
0eaf : a5 06 __ LDA WORK + 3 
0eb1 : 30 10 __ BMI $0ec3 ; (nformi.s9 + 0)
.s1019:
0eb3 : d0 06 __ BNE $0ebb ; (nformi.s8 + 0)
.s1018:
0eb5 : a5 05 __ LDA WORK + 2 
0eb7 : c9 0a __ CMP #$0a
0eb9 : 90 08 __ BCC $0ec3 ; (nformi.s9 + 0)
.s8:
0ebb : 18 __ __ CLC
0ebc : a5 05 __ LDA WORK + 2 
0ebe : 69 37 __ ADC #$37
0ec0 : 4c c8 0e JMP $0ec8 ; (nformi.s10 + 0)
.s9:
0ec3 : 18 __ __ CLC
0ec4 : a5 05 __ LDA WORK + 2 
0ec6 : 69 30 __ ADC #$30
.s10:
0ec8 : c6 44 __ DEC T2 + 0 
0eca : a6 44 __ LDX T2 + 0 
0ecc : 9d e8 9f STA $9fe8,x ; (buffer + 0)
0ecf : a5 11 __ LDA P4 ; (v + 0)
0ed1 : 85 1b __ STA ACCU + 0 
0ed3 : a5 12 __ LDA P5 ; (v + 1)
0ed5 : 85 1c __ STA ACCU + 1 
0ed7 : a5 47 __ LDA T5 + 0 
0ed9 : 85 03 __ STA WORK + 0 
0edb : a5 48 __ LDA T5 + 1 
0edd : 85 04 __ STA WORK + 1 
0edf : 20 b5 1d JSR $1db5 ; (divmod + 0)
0ee2 : a5 1b __ LDA ACCU + 0 
0ee4 : 85 11 __ STA P4 ; (v + 0)
0ee6 : a5 1c __ LDA ACCU + 1 
0ee8 : 85 12 __ STA P5 ; (v + 1)
0eea : 05 11 __ ORA P4 ; (v + 0)
0eec : d0 a7 __ BNE $0e95 ; (nformi.l6 + 0)
.s7:
0eee : a5 0d __ LDA P0 ; (si + 0)
0ef0 : 85 11 __ STA P4 ; (v + 0)
0ef2 : a5 0e __ LDA P1 ; (si + 1)
0ef4 : 85 12 __ STA P5 ; (v + 1)
0ef6 : a0 02 __ LDY #$02
0ef8 : b1 0d __ LDA (P0),y ; (si + 0)
0efa : c9 ff __ CMP #$ff
0efc : d0 04 __ BNE $0f02 ; (nformi.s76 + 0)
.s77:
0efe : a9 0f __ LDA #$0f
0f00 : d0 05 __ BNE $0f07 ; (nformi.s1026 + 0)
.s76:
0f02 : 38 __ __ SEC
0f03 : a9 10 __ LDA #$10
0f05 : f1 0d __ SBC (P0),y ; (si + 0)
.s1026:
0f07 : a8 __ __ TAY
0f08 : c4 44 __ CPY T2 + 0 
0f0a : b0 0d __ BCS $0f19 ; (nformi.s13 + 0)
.s12:
0f0c : a9 30 __ LDA #$30
.l1027:
0f0e : c6 44 __ DEC T2 + 0 
0f10 : a6 44 __ LDX T2 + 0 
0f12 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
0f15 : c4 44 __ CPY T2 + 0 
0f17 : 90 f5 __ BCC $0f0e ; (nformi.l1027 + 0)
.s13:
0f19 : a0 07 __ LDY #$07
0f1b : b1 0d __ LDA (P0),y ; (si + 0)
0f1d : f0 20 __ BEQ $0f3f ; (nformi.s16 + 0)
.s17:
0f1f : a0 04 __ LDY #$04
0f21 : b1 0d __ LDA (P0),y ; (si + 0)
0f23 : d0 1a __ BNE $0f3f ; (nformi.s16 + 0)
.s1013:
0f25 : 88 __ __ DEY
0f26 : b1 0d __ LDA (P0),y ; (si + 0)
0f28 : c9 10 __ CMP #$10
0f2a : d0 13 __ BNE $0f3f ; (nformi.s16 + 0)
.s14:
0f2c : a9 58 __ LDA #$58
0f2e : a6 44 __ LDX T2 + 0 
0f30 : 9d e7 9f STA $9fe7,x ; (si + 7)
0f33 : 8a __ __ TXA
0f34 : 18 __ __ CLC
0f35 : 69 fe __ ADC #$fe
0f37 : 85 44 __ STA T2 + 0 
0f39 : aa __ __ TAX
0f3a : a9 30 __ LDA #$30
0f3c : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s16:
0f3f : a9 00 __ LDA #$00
0f41 : 85 1b __ STA ACCU + 0 
0f43 : a5 43 __ LDA T0 + 0 
0f45 : f0 06 __ BEQ $0f4d ; (nformi.s19 + 0)
.s18:
0f47 : c6 44 __ DEC T2 + 0 
0f49 : a9 2d __ LDA #$2d
0f4b : d0 0a __ BNE $0f57 ; (nformi.s1025 + 0)
.s19:
0f4d : a0 05 __ LDY #$05
0f4f : b1 0d __ LDA (P0),y ; (si + 0)
0f51 : f0 09 __ BEQ $0f5c ; (nformi.s141 + 0)
.s21:
0f53 : c6 44 __ DEC T2 + 0 
0f55 : a9 2b __ LDA #$2b
.s1025:
0f57 : a6 44 __ LDX T2 + 0 
0f59 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s141:
0f5c : a0 06 __ LDY #$06
0f5e : b1 0d __ LDA (P0),y ; (si + 0)
0f60 : d0 37 __ BNE $0f99 ; (nformi.s27 + 0)
.l33:
0f62 : a0 01 __ LDY #$01
0f64 : b1 11 __ LDA (P4),y ; (v + 0)
0f66 : 18 __ __ CLC
0f67 : 65 44 __ ADC T2 + 0 
0f69 : b0 04 __ BCS $0f6f ; (nformi.s34 + 0)
.s1006:
0f6b : c9 11 __ CMP #$11
0f6d : 90 0e __ BCC $0f7d ; (nformi.s36 + 0)
.s34:
0f6f : c6 44 __ DEC T2 + 0 
0f71 : a0 00 __ LDY #$00
0f73 : b1 11 __ LDA (P4),y ; (v + 0)
0f75 : a6 44 __ LDX T2 + 0 
0f77 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
0f7a : 4c 62 0f JMP $0f62 ; (nformi.l33 + 0)
.s36:
0f7d : a6 44 __ LDX T2 + 0 
0f7f : e0 10 __ CPX #$10
0f81 : b0 11 __ BCS $0f94 ; (nformi.s26 + 0)
.s1022:
0f83 : 88 __ __ DEY
.l1031:
0f84 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
0f87 : 91 0f __ STA (P2),y ; (str + 0)
0f89 : e6 44 __ INC T2 + 0 
0f8b : a6 44 __ LDX T2 + 0 
0f8d : e0 10 __ CPX #$10
0f8f : c8 __ __ INY
0f90 : 90 f2 __ BCC $0f84 ; (nformi.l1031 + 0)
.s1032:
0f92 : 84 1b __ STY ACCU + 0 
.s26:
0f94 : a9 00 __ LDA #$00
0f96 : 85 1c __ STA ACCU + 1 
.s1001:
0f98 : 60 __ __ RTS
.s27:
0f99 : a6 44 __ LDX T2 + 0 
0f9b : e0 10 __ CPX #$10
0f9d : b0 12 __ BCS $0fb1 ; (nformi.l30 + 0)
.s1020:
0f9f : a0 00 __ LDY #$00
.l1029:
0fa1 : bd e8 9f LDA $9fe8,x ; (buffer + 0)
0fa4 : 91 0f __ STA (P2),y ; (str + 0)
0fa6 : e6 44 __ INC T2 + 0 
0fa8 : a6 44 __ LDX T2 + 0 
0faa : e0 10 __ CPX #$10
0fac : c8 __ __ INY
0fad : 90 f2 __ BCC $0fa1 ; (nformi.l1029 + 0)
.s1030:
0faf : 84 1b __ STY ACCU + 0 
.l30:
0fb1 : a5 1b __ LDA ACCU + 0 
0fb3 : a0 01 __ LDY #$01
0fb5 : d1 11 __ CMP (P4),y ; (v + 0)
0fb7 : b0 db __ BCS $0f94 ; (nformi.s26 + 0)
.s31:
0fb9 : 88 __ __ DEY
0fba : b1 11 __ LDA (P4),y ; (v + 0)
0fbc : a4 1b __ LDY ACCU + 0 
0fbe : 91 0f __ STA (P2),y ; (str + 0)
0fc0 : e6 1b __ INC ACCU + 0 
0fc2 : 4c b1 0f JMP $0fb1 ; (nformi.l30 + 0)
--------------------------------------------------------------------
nforml:
.s0:
0fc5 : a9 00 __ LDA #$00
0fc7 : 85 43 __ STA T0 + 0 
0fc9 : a5 15 __ LDA P8 ; (s + 0)
0fcb : f0 23 __ BEQ $0ff0 ; (nforml.s159 + 0)
.s4:
0fcd : a5 14 __ LDA P7 ; (v + 3)
0fcf : f0 1f __ BEQ $0ff0 ; (nforml.s159 + 0)
.s1032:
0fd1 : 10 1d __ BPL $0ff0 ; (nforml.s159 + 0)
.s1:
0fd3 : 38 __ __ SEC
0fd4 : a9 00 __ LDA #$00
0fd6 : e5 11 __ SBC P4 ; (v + 0)
0fd8 : 85 11 __ STA P4 ; (v + 0)
0fda : a9 00 __ LDA #$00
0fdc : e5 12 __ SBC P5 ; (v + 1)
0fde : 85 12 __ STA P5 ; (v + 1)
0fe0 : a9 00 __ LDA #$00
0fe2 : e5 13 __ SBC P6 ; (v + 2)
0fe4 : 85 13 __ STA P6 ; (v + 2)
0fe6 : a9 00 __ LDA #$00
0fe8 : e5 14 __ SBC P7 ; (v + 3)
0fea : 85 14 __ STA P7 ; (v + 3)
0fec : a9 01 __ LDA #$01
0fee : 85 43 __ STA T0 + 0 
.s159:
0ff0 : a9 10 __ LDA #$10
0ff2 : 85 44 __ STA T2 + 0 
0ff4 : a5 14 __ LDA P7 ; (v + 3)
0ff6 : f0 03 __ BEQ $0ffb ; (nforml.s1018 + 0)
0ff8 : 4c df 10 JMP $10df ; (nforml.l6 + 0)
.s1018:
0ffb : a5 13 __ LDA P6 ; (v + 2)
0ffd : f0 03 __ BEQ $1002 ; (nforml.s1019 + 0)
0fff : 4c df 10 JMP $10df ; (nforml.l6 + 0)
.s1019:
1002 : a5 12 __ LDA P5 ; (v + 1)
1004 : f0 03 __ BEQ $1009 ; (nforml.s1020 + 0)
1006 : 4c df 10 JMP $10df ; (nforml.l6 + 0)
.s1020:
1009 : c5 11 __ CMP P4 ; (v + 0)
100b : b0 03 __ BCS $1010 ; (nforml.s7 + 0)
100d : 4c df 10 JMP $10df ; (nforml.l6 + 0)
.s7:
1010 : a0 02 __ LDY #$02
1012 : b1 0d __ LDA (P0),y ; (si + 0)
1014 : c9 ff __ CMP #$ff
1016 : d0 04 __ BNE $101c ; (nforml.s76 + 0)
.s77:
1018 : a9 0f __ LDA #$0f
101a : d0 05 __ BNE $1021 ; (nforml.s1039 + 0)
.s76:
101c : 38 __ __ SEC
101d : a9 10 __ LDA #$10
101f : f1 0d __ SBC (P0),y ; (si + 0)
.s1039:
1021 : a8 __ __ TAY
1022 : c4 44 __ CPY T2 + 0 
1024 : b0 0d __ BCS $1033 ; (nforml.s13 + 0)
.s12:
1026 : a9 30 __ LDA #$30
.l1040:
1028 : c6 44 __ DEC T2 + 0 
102a : a6 44 __ LDX T2 + 0 
102c : 9d e8 9f STA $9fe8,x ; (buffer + 0)
102f : c4 44 __ CPY T2 + 0 
1031 : 90 f5 __ BCC $1028 ; (nforml.l1040 + 0)
.s13:
1033 : a0 07 __ LDY #$07
1035 : b1 0d __ LDA (P0),y ; (si + 0)
1037 : f0 20 __ BEQ $1059 ; (nforml.s16 + 0)
.s17:
1039 : a0 04 __ LDY #$04
103b : b1 0d __ LDA (P0),y ; (si + 0)
103d : d0 1a __ BNE $1059 ; (nforml.s16 + 0)
.s1013:
103f : 88 __ __ DEY
1040 : b1 0d __ LDA (P0),y ; (si + 0)
1042 : c9 10 __ CMP #$10
1044 : d0 13 __ BNE $1059 ; (nforml.s16 + 0)
.s14:
1046 : a9 58 __ LDA #$58
1048 : a6 44 __ LDX T2 + 0 
104a : 9d e7 9f STA $9fe7,x ; (si + 7)
104d : 8a __ __ TXA
104e : 18 __ __ CLC
104f : 69 fe __ ADC #$fe
1051 : 85 44 __ STA T2 + 0 
1053 : aa __ __ TAX
1054 : a9 30 __ LDA #$30
1056 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s16:
1059 : a9 00 __ LDA #$00
105b : 85 1b __ STA ACCU + 0 
105d : a5 43 __ LDA T0 + 0 
105f : f0 06 __ BEQ $1067 ; (nforml.s19 + 0)
.s18:
1061 : c6 44 __ DEC T2 + 0 
1063 : a9 2d __ LDA #$2d
1065 : d0 0a __ BNE $1071 ; (nforml.s1038 + 0)
.s19:
1067 : a0 05 __ LDY #$05
1069 : b1 0d __ LDA (P0),y ; (si + 0)
106b : f0 09 __ BEQ $1076 ; (nforml.s141 + 0)
.s21:
106d : c6 44 __ DEC T2 + 0 
106f : a9 2b __ LDA #$2b
.s1038:
1071 : a6 44 __ LDX T2 + 0 
1073 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
.s141:
1076 : a0 06 __ LDY #$06
1078 : b1 0d __ LDA (P0),y ; (si + 0)
107a : d0 37 __ BNE $10b3 ; (nforml.s27 + 0)
.l33:
107c : a0 01 __ LDY #$01
107e : b1 0d __ LDA (P0),y ; (si + 0)
1080 : 18 __ __ CLC
1081 : 65 44 __ ADC T2 + 0 
1083 : b0 04 __ BCS $1089 ; (nforml.s34 + 0)
.s1006:
1085 : c9 11 __ CMP #$11
1087 : 90 0e __ BCC $1097 ; (nforml.s36 + 0)
.s34:
1089 : c6 44 __ DEC T2 + 0 
108b : a0 00 __ LDY #$00
108d : b1 0d __ LDA (P0),y ; (si + 0)
108f : a6 44 __ LDX T2 + 0 
1091 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1094 : 4c 7c 10 JMP $107c ; (nforml.l33 + 0)
.s36:
1097 : a6 44 __ LDX T2 + 0 
1099 : e0 10 __ CPX #$10
109b : b0 11 __ BCS $10ae ; (nforml.s26 + 0)
.s1035:
109d : 88 __ __ DEY
.l1044:
109e : bd e8 9f LDA $9fe8,x ; (buffer + 0)
10a1 : 91 0f __ STA (P2),y ; (str + 0)
10a3 : e6 44 __ INC T2 + 0 
10a5 : a6 44 __ LDX T2 + 0 
10a7 : e0 10 __ CPX #$10
10a9 : c8 __ __ INY
10aa : 90 f2 __ BCC $109e ; (nforml.l1044 + 0)
.s1045:
10ac : 84 1b __ STY ACCU + 0 
.s26:
10ae : a9 00 __ LDA #$00
10b0 : 85 1c __ STA ACCU + 1 
.s1001:
10b2 : 60 __ __ RTS
.s27:
10b3 : a6 44 __ LDX T2 + 0 
10b5 : e0 10 __ CPX #$10
10b7 : b0 12 __ BCS $10cb ; (nforml.l30 + 0)
.s1033:
10b9 : a0 00 __ LDY #$00
.l1042:
10bb : bd e8 9f LDA $9fe8,x ; (buffer + 0)
10be : 91 0f __ STA (P2),y ; (str + 0)
10c0 : e6 44 __ INC T2 + 0 
10c2 : a6 44 __ LDX T2 + 0 
10c4 : e0 10 __ CPX #$10
10c6 : c8 __ __ INY
10c7 : 90 f2 __ BCC $10bb ; (nforml.l1042 + 0)
.s1043:
10c9 : 84 1b __ STY ACCU + 0 
.l30:
10cb : a5 1b __ LDA ACCU + 0 
10cd : a0 01 __ LDY #$01
10cf : d1 0d __ CMP (P0),y ; (si + 0)
10d1 : b0 db __ BCS $10ae ; (nforml.s26 + 0)
.s31:
10d3 : 88 __ __ DEY
10d4 : b1 0d __ LDA (P0),y ; (si + 0)
10d6 : a4 1b __ LDY ACCU + 0 
10d8 : 91 0f __ STA (P2),y ; (str + 0)
10da : e6 1b __ INC ACCU + 0 
10dc : 4c cb 10 JMP $10cb ; (nforml.l30 + 0)
.l6:
10df : a0 03 __ LDY #$03
10e1 : b1 0d __ LDA (P0),y ; (si + 0)
10e3 : 85 03 __ STA WORK + 0 
10e5 : 85 45 __ STA T6 + 0 
10e7 : c8 __ __ INY
10e8 : b1 0d __ LDA (P0),y ; (si + 0)
10ea : 85 46 __ STA T6 + 1 
10ec : 85 04 __ STA WORK + 1 
10ee : a5 11 __ LDA P4 ; (v + 0)
10f0 : 85 1b __ STA ACCU + 0 
10f2 : a5 12 __ LDA P5 ; (v + 1)
10f4 : 85 1c __ STA ACCU + 1 
10f6 : a5 13 __ LDA P6 ; (v + 2)
10f8 : 85 1d __ STA ACCU + 2 
10fa : a5 14 __ LDA P7 ; (v + 3)
10fc : 85 1e __ STA ACCU + 3 
10fe : a9 00 __ LDA #$00
1100 : 85 05 __ STA WORK + 2 
1102 : 85 06 __ STA WORK + 3 
1104 : 20 f0 1e JSR $1ef0 ; (divmod32 + 0)
1107 : a5 08 __ LDA WORK + 5 
1109 : 30 10 __ BMI $111b ; (nforml.s9 + 0)
.s1023:
110b : d0 06 __ BNE $1113 ; (nforml.s8 + 0)
.s1022:
110d : a5 07 __ LDA WORK + 4 
110f : c9 0a __ CMP #$0a
1111 : 90 08 __ BCC $111b ; (nforml.s9 + 0)
.s8:
1113 : 18 __ __ CLC
1114 : a5 07 __ LDA WORK + 4 
1116 : 69 37 __ ADC #$37
1118 : 4c 20 11 JMP $1120 ; (nforml.s10 + 0)
.s9:
111b : 18 __ __ CLC
111c : a5 07 __ LDA WORK + 4 
111e : 69 30 __ ADC #$30
.s10:
1120 : c6 44 __ DEC T2 + 0 
1122 : a6 44 __ LDX T2 + 0 
1124 : 9d e8 9f STA $9fe8,x ; (buffer + 0)
1127 : a5 11 __ LDA P4 ; (v + 0)
1129 : 85 1b __ STA ACCU + 0 
112b : a5 12 __ LDA P5 ; (v + 1)
112d : 85 1c __ STA ACCU + 1 
112f : a5 13 __ LDA P6 ; (v + 2)
1131 : 85 1d __ STA ACCU + 2 
1133 : a5 14 __ LDA P7 ; (v + 3)
1135 : 85 1e __ STA ACCU + 3 
1137 : a5 45 __ LDA T6 + 0 
1139 : 85 03 __ STA WORK + 0 
113b : a5 46 __ LDA T6 + 1 
113d : 85 04 __ STA WORK + 1 
113f : a9 00 __ LDA #$00
1141 : 85 05 __ STA WORK + 2 
1143 : 85 06 __ STA WORK + 3 
1145 : 20 f0 1e JSR $1ef0 ; (divmod32 + 0)
1148 : a5 1b __ LDA ACCU + 0 
114a : 85 11 __ STA P4 ; (v + 0)
114c : a5 1c __ LDA ACCU + 1 
114e : 85 12 __ STA P5 ; (v + 1)
1150 : a5 1d __ LDA ACCU + 2 
1152 : 85 13 __ STA P6 ; (v + 2)
1154 : a5 1e __ LDA ACCU + 3 
1156 : 85 14 __ STA P7 ; (v + 3)
1158 : d0 85 __ BNE $10df ; (nforml.l6 + 0)
115a : 4c fb 0f JMP $0ffb ; (nforml.s1018 + 0)
--------------------------------------------------------------------
nformf:
.s0:
115d : a5 15 __ LDA P8 ; (f + 0)
115f : 85 43 __ STA T1 + 0 
1161 : a5 16 __ LDA P9 ; (f + 1)
1163 : 85 44 __ STA T1 + 1 
1165 : a5 17 __ LDA P10 ; (f + 2)
1167 : 85 45 __ STA T1 + 2 
1169 : a5 18 __ LDA P11 ; (f + 3)
116b : 29 7f __ AND #$7f
116d : 05 17 __ ORA P10 ; (f + 2)
116f : 05 16 __ ORA P9 ; (f + 1)
1171 : 05 15 __ ORA P8 ; (f + 0)
1173 : f0 21 __ BEQ $1196 ; (nformf.s2 + 0)
.s1005:
1175 : a5 18 __ LDA P11 ; (f + 3)
1177 : 10 1d __ BPL $1196 ; (nformf.s2 + 0)
.s1:
1179 : a9 2d __ LDA #$2d
117b : a0 00 __ LDY #$00
117d : 91 13 __ STA (P6),y ; (str + 0)
117f : a5 18 __ LDA P11 ; (f + 3)
1181 : 49 80 __ EOR #$80
1183 : 85 18 __ STA P11 ; (f + 3)
1185 : 85 10 __ STA P3 
1187 : a5 15 __ LDA P8 ; (f + 0)
1189 : 85 0d __ STA P0 
118b : a5 16 __ LDA P9 ; (f + 1)
118d : 85 0e __ STA P1 
118f : a5 17 __ LDA P10 ; (f + 2)
1191 : 85 0f __ STA P2 
1193 : 4c 16 16 JMP $1616 ; (nformf.s189 + 0)
.s2:
1196 : a5 15 __ LDA P8 ; (f + 0)
1198 : 85 0d __ STA P0 
119a : a5 16 __ LDA P9 ; (f + 1)
119c : 85 0e __ STA P1 
119e : a5 17 __ LDA P10 ; (f + 2)
11a0 : 85 0f __ STA P2 
11a2 : a5 18 __ LDA P11 ; (f + 3)
11a4 : 85 10 __ STA P3 
11a6 : a0 05 __ LDY #$05
11a8 : b1 11 __ LDA (P4),y ; (si + 0)
11aa : f0 09 __ BEQ $11b5 ; (nformf.s3 + 0)
.s4:
11ac : a9 2b __ LDA #$2b
11ae : a0 00 __ LDY #$00
11b0 : 91 13 __ STA (P6),y ; (str + 0)
11b2 : 4c 16 16 JMP $1616 ; (nformf.s189 + 0)
.s3:
11b5 : 20 2e 16 JSR $162e ; (isinf.s0 + 0)
11b8 : aa __ __ TAX
11b9 : a9 00 __ LDA #$00
11bb : 85 48 __ STA T3 + 0 
11bd : 8a __ __ TXA
11be : f0 0b __ BEQ $11cb ; (nformf.s8 + 0)
.s160:
11c0 : a9 01 __ LDA #$01
11c2 : 85 4a __ STA T5 + 0 
11c4 : a9 02 __ LDA #$02
11c6 : a0 00 __ LDY #$00
11c8 : 4c fa 15 JMP $15fa ; (nformf.s7 + 0)
.s8:
11cb : a0 02 __ LDY #$02
11cd : b1 11 __ LDA (P4),y ; (si + 0)
11cf : c9 ff __ CMP #$ff
11d1 : d0 02 __ BNE $11d5 ; (nformf.s128 + 0)
.s129:
11d3 : a9 06 __ LDA #$06
.s128:
11d5 : 86 4a __ STX T5 + 0 
11d7 : 86 4b __ STX T5 + 1 
11d9 : 85 49 __ STA T4 + 0 
11db : 85 47 __ STA T2 + 0 
11dd : a5 18 __ LDA P11 ; (f + 3)
11df : 85 46 __ STA T1 + 3 
11e1 : 29 7f __ AND #$7f
11e3 : 05 17 __ ORA P10 ; (f + 2)
11e5 : 05 16 __ ORA P9 ; (f + 1)
11e7 : 05 15 __ ORA P8 ; (f + 0)
11e9 : f0 03 __ BEQ $11ee ; (nformf.s12 + 0)
11eb : 4c fb 14 JMP $14fb ; (nformf.s13 + 0)
.s12:
11ee : ad f8 9f LDA $9ff8 ; (sstack + 0)
11f1 : c9 65 __ CMP #$65
11f3 : d0 04 __ BNE $11f9 ; (nformf.s1007 + 0)
.s1006:
11f5 : a9 01 __ LDA #$01
11f7 : d0 02 __ BNE $11fb ; (nformf.s1008 + 0)
.s1007:
11f9 : a9 00 __ LDA #$00
.s1008:
11fb : 85 4e __ STA T9 + 0 
11fd : a6 49 __ LDX T4 + 0 
11ff : e8 __ __ INX
1200 : 86 4c __ STX T8 + 0 
1202 : ad f8 9f LDA $9ff8 ; (sstack + 0)
1205 : c9 67 __ CMP #$67
1207 : d0 13 __ BNE $121c ; (nformf.s24 + 0)
.s22:
1209 : a5 4b __ LDA T5 + 1 
120b : 30 08 __ BMI $1215 ; (nformf.s25 + 0)
.s1050:
120d : d0 06 __ BNE $1215 ; (nformf.s25 + 0)
.s1049:
120f : a5 4a __ LDA T5 + 0 
1211 : c9 04 __ CMP #$04
1213 : 90 07 __ BCC $121c ; (nformf.s24 + 0)
.s25:
1215 : a9 01 __ LDA #$01
1217 : 85 4e __ STA T9 + 0 
1219 : 4c 73 14 JMP $1473 ; (nformf.s30 + 0)
.s24:
121c : a5 4e __ LDA T9 + 0 
121e : f0 03 __ BEQ $1223 ; (nformf.s32 + 0)
1220 : 4c 73 14 JMP $1473 ; (nformf.s30 + 0)
.s32:
1223 : a5 4b __ LDA T5 + 1 
1225 : 10 3e __ BPL $1265 ; (nformf.s34 + 0)
.s33:
1227 : a5 43 __ LDA T1 + 0 
1229 : 85 1b __ STA ACCU + 0 
122b : a5 44 __ LDA T1 + 1 
122d : 85 1c __ STA ACCU + 1 
122f : a5 45 __ LDA T1 + 2 
1231 : 85 1d __ STA ACCU + 2 
1233 : a5 46 __ LDA T1 + 3 
1235 : 85 1e __ STA ACCU + 3 
.l1085:
1237 : e6 4a __ INC T5 + 0 
1239 : d0 02 __ BNE $123d ; (nformf.s1095 + 0)
.s1094:
123b : e6 4b __ INC T5 + 1 
.s1095:
123d : a9 00 __ LDA #$00
123f : 85 03 __ STA WORK + 0 
1241 : 85 04 __ STA WORK + 1 
1243 : a9 20 __ LDA #$20
1245 : 85 05 __ STA WORK + 2 
1247 : a9 41 __ LDA #$41
1249 : 85 06 __ STA WORK + 3 
124b : 20 e6 1a JSR $1ae6 ; (freg + 20)
124e : 20 cd 1c JSR $1ccd ; (fdiv + 0)
1251 : a5 4b __ LDA T5 + 1 
1253 : 30 e2 __ BMI $1237 ; (nformf.l1085 + 0)
.s1086:
1255 : a5 1e __ LDA ACCU + 3 
1257 : 85 46 __ STA T1 + 3 
1259 : a5 1d __ LDA ACCU + 2 
125b : 85 45 __ STA T1 + 2 
125d : a5 1c __ LDA ACCU + 1 
125f : 85 44 __ STA T1 + 1 
1261 : a5 1b __ LDA ACCU + 0 
1263 : 85 43 __ STA T1 + 0 
.s34:
1265 : 18 __ __ CLC
1266 : a5 49 __ LDA T4 + 0 
1268 : 65 4a __ ADC T5 + 0 
126a : 18 __ __ CLC
126b : 69 01 __ ADC #$01
126d : 85 4c __ STA T8 + 0 
126f : c9 07 __ CMP #$07
1271 : 90 13 __ BCC $1286 ; (nformf.s35 + 0)
.s36:
1273 : ad ab 1f LDA $1fab ; (fround5 + 25)
1276 : 85 1c __ STA ACCU + 1 
1278 : ad ac 1f LDA $1fac ; (fround5 + 26)
127b : 85 1d __ STA ACCU + 2 
127d : ad ad 1f LDA $1fad ; (fround5 + 27)
1280 : ae aa 1f LDX $1faa ; (fround5 + 24)
1283 : 4c 99 12 JMP $1299 ; (nformf.s214 + 0)
.s35:
1286 : 0a __ __ ASL
1287 : 0a __ __ ASL
1288 : a8 __ __ TAY
1289 : b9 8f 1f LDA $1f8f,y ; (__multab3L + 9)
128c : 85 1c __ STA ACCU + 1 
128e : b9 90 1f LDA $1f90,y ; (spentry + 0)
1291 : 85 1d __ STA ACCU + 2 
1293 : b9 91 1f LDA $1f91,y ; (giocharmap + 0)
1296 : be 8e 1f LDX $1f8e,y ; (__multab3L + 8)
.s214:
1299 : 86 1b __ STX ACCU + 0 
129b : 85 1e __ STA ACCU + 3 
129d : a2 43 __ LDX #$43
129f : 20 d6 1a JSR $1ad6 ; (freg + 4)
12a2 : 20 17 1b JSR $1b17 ; (faddsub + 0)
12a5 : a5 1c __ LDA ACCU + 1 
12a7 : 85 16 __ STA P9 ; (f + 1)
12a9 : a5 1d __ LDA ACCU + 2 
12ab : 85 17 __ STA P10 ; (f + 2)
12ad : a6 1b __ LDX ACCU + 0 
12af : a5 1e __ LDA ACCU + 3 
12b1 : 85 18 __ STA P11 ; (f + 3)
12b3 : 30 35 __ BMI $12ea ; (nformf.s31 + 0)
.s1032:
12b5 : c9 41 __ CMP #$41
12b7 : d0 06 __ BNE $12bf ; (nformf.s1036 + 0)
.s1033:
12b9 : a5 17 __ LDA P10 ; (f + 2)
12bb : c9 20 __ CMP #$20
12bd : f0 02 __ BEQ $12c1 ; (nformf.s38 + 0)
.s1036:
12bf : 90 29 __ BCC $12ea ; (nformf.s31 + 0)
.s38:
12c1 : a9 00 __ LDA #$00
12c3 : 85 03 __ STA WORK + 0 
12c5 : 85 04 __ STA WORK + 1 
12c7 : a9 20 __ LDA #$20
12c9 : 85 05 __ STA WORK + 2 
12cb : a9 41 __ LDA #$41
12cd : 85 06 __ STA WORK + 3 
12cf : 20 e6 1a JSR $1ae6 ; (freg + 20)
12d2 : 20 cd 1c JSR $1ccd ; (fdiv + 0)
12d5 : a5 1c __ LDA ACCU + 1 
12d7 : 85 16 __ STA P9 ; (f + 1)
12d9 : a5 1d __ LDA ACCU + 2 
12db : 85 17 __ STA P10 ; (f + 2)
12dd : a5 1e __ LDA ACCU + 3 
12df : 85 18 __ STA P11 ; (f + 3)
12e1 : 18 __ __ CLC
12e2 : a5 49 __ LDA T4 + 0 
12e4 : 69 ff __ ADC #$ff
12e6 : 85 47 __ STA T2 + 0 
12e8 : a6 1b __ LDX ACCU + 0 
.s31:
12ea : 38 __ __ SEC
12eb : a5 4c __ LDA T8 + 0 
12ed : e5 47 __ SBC T2 + 0 
12ef : 85 49 __ STA T4 + 0 
12f1 : a9 14 __ LDA #$14
12f3 : c5 4c __ CMP T8 + 0 
12f5 : b0 02 __ BCS $12f9 ; (nformf.s49 + 0)
.s47:
12f7 : 85 4c __ STA T8 + 0 
.s49:
12f9 : a5 49 __ LDA T4 + 0 
12fb : d0 08 __ BNE $1305 ; (nformf.s219 + 0)
.s50:
12fd : a9 30 __ LDA #$30
12ff : a4 48 __ LDY T3 + 0 
1301 : 91 13 __ STA (P6),y ; (str + 0)
1303 : e6 48 __ INC T3 + 0 
.s219:
1305 : a9 00 __ LDA #$00
1307 : 85 47 __ STA T2 + 0 
1309 : c5 49 __ CMP T4 + 0 
130b : d0 08 __ BNE $1315 ; (nformf.l59 + 0)
.l57:
130d : a9 2e __ LDA #$2e
130f : a4 48 __ LDY T3 + 0 
1311 : 91 13 __ STA (P6),y ; (str + 0)
1313 : e6 48 __ INC T3 + 0 
.l59:
1315 : a5 47 __ LDA T2 + 0 
1317 : c9 07 __ CMP #$07
1319 : 90 04 __ BCC $131f ; (nformf.s61 + 0)
.s60:
131b : a9 30 __ LDA #$30
131d : d0 55 __ BNE $1374 ; (nformf.s208 + 0)
.s61:
131f : 86 1b __ STX ACCU + 0 
1321 : 86 43 __ STX T1 + 0 
1323 : a5 16 __ LDA P9 ; (f + 1)
1325 : 85 1c __ STA ACCU + 1 
1327 : 85 44 __ STA T1 + 1 
1329 : a5 17 __ LDA P10 ; (f + 2)
132b : 85 1d __ STA ACCU + 2 
132d : 85 45 __ STA T1 + 2 
132f : a5 18 __ LDA P11 ; (f + 3)
1331 : 85 1e __ STA ACCU + 3 
1333 : 85 46 __ STA T1 + 3 
1335 : 20 63 1e JSR $1e63 ; (f32_to_i16 + 0)
1338 : a5 1b __ LDA ACCU + 0 
133a : 85 4f __ STA T11 + 0 
133c : 20 a5 1e JSR $1ea5 ; (sint16_to_float + 0)
133f : a2 43 __ LDX #$43
1341 : 20 d6 1a JSR $1ad6 ; (freg + 4)
1344 : a5 1e __ LDA ACCU + 3 
1346 : 49 80 __ EOR #$80
1348 : 85 1e __ STA ACCU + 3 
134a : 20 17 1b JSR $1b17 ; (faddsub + 0)
134d : a9 00 __ LDA #$00
134f : 85 03 __ STA WORK + 0 
1351 : 85 04 __ STA WORK + 1 
1353 : a9 20 __ LDA #$20
1355 : 85 05 __ STA WORK + 2 
1357 : a9 41 __ LDA #$41
1359 : 85 06 __ STA WORK + 3 
135b : 20 e6 1a JSR $1ae6 ; (freg + 20)
135e : 20 fe 1b JSR $1bfe ; (fmul + 0)
1361 : a5 1c __ LDA ACCU + 1 
1363 : 85 16 __ STA P9 ; (f + 1)
1365 : a5 1d __ LDA ACCU + 2 
1367 : 85 17 __ STA P10 ; (f + 2)
1369 : a5 1e __ LDA ACCU + 3 
136b : 85 18 __ STA P11 ; (f + 3)
136d : 18 __ __ CLC
136e : a5 4f __ LDA T11 + 0 
1370 : 69 30 __ ADC #$30
1372 : a6 1b __ LDX ACCU + 0 
.s208:
1374 : a4 48 __ LDY T3 + 0 
1376 : 91 13 __ STA (P6),y ; (str + 0)
1378 : e6 48 __ INC T3 + 0 
137a : e6 47 __ INC T2 + 0 
137c : a5 47 __ LDA T2 + 0 
137e : c5 4c __ CMP T8 + 0 
1380 : b0 07 __ BCS $1389 ; (nformf.s56 + 0)
.s54:
1382 : c5 49 __ CMP T4 + 0 
1384 : d0 8f __ BNE $1315 ; (nformf.l59 + 0)
1386 : 4c 0d 13 JMP $130d ; (nformf.l57 + 0)
.s56:
1389 : a5 4e __ LDA T9 + 0 
138b : f0 62 __ BEQ $13ef ; (nformf.s9 + 0)
.s63:
138d : a9 45 __ LDA #$45
138f : a4 48 __ LDY T3 + 0 
1391 : 91 13 __ STA (P6),y ; (str + 0)
1393 : c8 __ __ INY
1394 : a5 4b __ LDA T5 + 1 
1396 : 30 06 __ BMI $139e ; (nformf.s66 + 0)
.s67:
1398 : a9 2b __ LDA #$2b
139a : 91 13 __ STA (P6),y ; (str + 0)
139c : d0 11 __ BNE $13af ; (nformf.s68 + 0)
.s66:
139e : a9 2d __ LDA #$2d
13a0 : 91 13 __ STA (P6),y ; (str + 0)
13a2 : 38 __ __ SEC
13a3 : a9 00 __ LDA #$00
13a5 : e5 4a __ SBC T5 + 0 
13a7 : 85 4a __ STA T5 + 0 
13a9 : a9 00 __ LDA #$00
13ab : e5 4b __ SBC T5 + 1 
13ad : 85 4b __ STA T5 + 1 
.s68:
13af : a5 4a __ LDA T5 + 0 
13b1 : 85 1b __ STA ACCU + 0 
13b3 : a5 4b __ LDA T5 + 1 
13b5 : 85 1c __ STA ACCU + 1 
13b7 : a9 0a __ LDA #$0a
13b9 : 85 03 __ STA WORK + 0 
13bb : a9 00 __ LDA #$00
13bd : 85 04 __ STA WORK + 1 
13bf : 20 7b 1d JSR $1d7b ; (divs16 + 0)
13c2 : 18 __ __ CLC
13c3 : a5 1b __ LDA ACCU + 0 
13c5 : 69 30 __ ADC #$30
13c7 : a4 48 __ LDY T3 + 0 
13c9 : c8 __ __ INY
13ca : c8 __ __ INY
13cb : 91 13 __ STA (P6),y ; (str + 0)
13cd : a5 4a __ LDA T5 + 0 
13cf : 85 1b __ STA ACCU + 0 
13d1 : a5 4b __ LDA T5 + 1 
13d3 : 85 1c __ STA ACCU + 1 
13d5 : a9 0a __ LDA #$0a
13d7 : 85 03 __ STA WORK + 0 
13d9 : a9 00 __ LDA #$00
13db : 85 04 __ STA WORK + 1 
13dd : 20 3a 1e JSR $1e3a ; (mods16 + 0)
13e0 : 18 __ __ CLC
13e1 : a5 05 __ LDA WORK + 2 
13e3 : 69 30 __ ADC #$30
13e5 : a4 48 __ LDY T3 + 0 
13e7 : c8 __ __ INY
13e8 : c8 __ __ INY
13e9 : c8 __ __ INY
13ea : 91 13 __ STA (P6),y ; (str + 0)
13ec : c8 __ __ INY
13ed : 84 48 __ STY T3 + 0 
.s9:
13ef : a5 11 __ LDA P4 ; (si + 0)
13f1 : 85 4a __ STA T5 + 0 
13f3 : a5 12 __ LDA P5 ; (si + 1)
13f5 : 85 4b __ STA T5 + 1 
13f7 : a5 48 __ LDA T3 + 0 
13f9 : a0 01 __ LDY #$01
13fb : d1 11 __ CMP (P4),y ; (si + 0)
13fd : b0 5d __ BCS $145c ; (nformf.s1001 + 0)
.s69:
13ff : a0 06 __ LDY #$06
1401 : b1 11 __ LDA (P4),y ; (si + 0)
1403 : f0 06 __ BEQ $140b ; (nformf.s73 + 0)
.s72:
1405 : a5 48 __ LDA T3 + 0 
1407 : aa __ __ TAX
1408 : 4c 63 14 JMP $1463 ; (nformf.l75 + 0)
.s73:
140b : a5 48 __ LDA T3 + 0 
140d : f0 2d __ BEQ $143c ; (nformf.s82 + 0)
.s90:
140f : a9 01 __ LDA #$01
1411 : 85 47 __ STA T2 + 0 
1413 : a6 48 __ LDX T3 + 0 
1415 : 38 __ __ SEC
.l1083:
1416 : a0 01 __ LDY #$01
1418 : b1 11 __ LDA (P4),y ; (si + 0)
141a : e5 47 __ SBC T2 + 0 
141c : 85 4c __ STA T8 + 0 
141e : a9 ff __ LDA #$ff
1420 : 65 14 __ ADC P7 ; (str + 1)
1422 : 85 4d __ STA T8 + 1 
1424 : 8a __ __ TXA
1425 : 38 __ __ SEC
1426 : e5 47 __ SBC T2 + 0 
1428 : 85 1b __ STA ACCU + 0 
142a : a9 ff __ LDA #$ff
142c : 65 14 __ ADC P7 ; (str + 1)
142e : 85 1c __ STA ACCU + 1 
1430 : a4 13 __ LDY P6 ; (str + 0)
1432 : b1 1b __ LDA (ACCU + 0),y 
1434 : 91 4c __ STA (T8 + 0),y 
1436 : e6 47 __ INC T2 + 0 
1438 : e4 47 __ CPX T2 + 0 
143a : b0 da __ BCS $1416 ; (nformf.l1083 + 0)
.s82:
143c : a9 00 __ LDA #$00
143e : 85 47 __ STA T2 + 0 
.l83:
1440 : a0 01 __ LDY #$01
1442 : b1 4a __ LDA (T5 + 0),y 
1444 : 38 __ __ SEC
1445 : e5 48 __ SBC T3 + 0 
1447 : 90 06 __ BCC $144f ; (nformf.s84 + 0)
.s1011:
1449 : c5 47 __ CMP T2 + 0 
144b : 90 0d __ BCC $145a ; (nformf.s74 + 0)
.s1087:
144d : f0 0b __ BEQ $145a ; (nformf.s74 + 0)
.s84:
144f : a9 20 __ LDA #$20
1451 : a4 47 __ LDY T2 + 0 
1453 : 91 13 __ STA (P6),y ; (str + 0)
1455 : e6 47 __ INC T2 + 0 
1457 : 4c 40 14 JMP $1440 ; (nformf.l83 + 0)
.s74:
145a : b1 11 __ LDA (P4),y ; (si + 0)
.s1001:
145c : 85 1b __ STA ACCU + 0 
145e : a9 00 __ LDA #$00
1460 : 85 1c __ STA ACCU + 1 
1462 : 60 __ __ RTS
.l75:
1463 : a0 01 __ LDY #$01
1465 : d1 4a __ CMP (T5 + 0),y 
1467 : b0 f1 __ BCS $145a ; (nformf.s74 + 0)
.s76:
1469 : a8 __ __ TAY
146a : a9 20 __ LDA #$20
146c : 91 13 __ STA (P6),y ; (str + 0)
146e : e8 __ __ INX
146f : 8a __ __ TXA
1470 : 4c 63 14 JMP $1463 ; (nformf.l75 + 0)
.s30:
1473 : a5 4c __ LDA T8 + 0 
1475 : c9 07 __ CMP #$07
1477 : 90 13 __ BCC $148c ; (nformf.s41 + 0)
.s42:
1479 : ad ab 1f LDA $1fab ; (fround5 + 25)
147c : 85 1c __ STA ACCU + 1 
147e : ad ac 1f LDA $1fac ; (fround5 + 26)
1481 : 85 1d __ STA ACCU + 2 
1483 : ad ad 1f LDA $1fad ; (fround5 + 27)
1486 : ae aa 1f LDX $1faa ; (fround5 + 24)
1489 : 4c 9f 14 JMP $149f ; (nformf.s204 + 0)
.s41:
148c : 0a __ __ ASL
148d : 0a __ __ ASL
148e : a8 __ __ TAY
148f : b9 8f 1f LDA $1f8f,y ; (__multab3L + 9)
1492 : 85 1c __ STA ACCU + 1 
1494 : b9 90 1f LDA $1f90,y ; (spentry + 0)
1497 : 85 1d __ STA ACCU + 2 
1499 : b9 91 1f LDA $1f91,y ; (giocharmap + 0)
149c : be 8e 1f LDX $1f8e,y ; (__multab3L + 8)
.s204:
149f : 86 1b __ STX ACCU + 0 
14a1 : 85 1e __ STA ACCU + 3 
14a3 : a2 43 __ LDX #$43
14a5 : 20 d6 1a JSR $1ad6 ; (freg + 4)
14a8 : 20 17 1b JSR $1b17 ; (faddsub + 0)
14ab : a5 1c __ LDA ACCU + 1 
14ad : 85 16 __ STA P9 ; (f + 1)
14af : a5 1d __ LDA ACCU + 2 
14b1 : 85 17 __ STA P10 ; (f + 2)
14b3 : a6 1b __ LDX ACCU + 0 
14b5 : a5 1e __ LDA ACCU + 3 
14b7 : 85 18 __ STA P11 ; (f + 3)
14b9 : 10 03 __ BPL $14be ; (nformf.s1042 + 0)
14bb : 4c ea 12 JMP $12ea ; (nformf.s31 + 0)
.s1042:
14be : c9 41 __ CMP #$41
14c0 : d0 06 __ BNE $14c8 ; (nformf.s1046 + 0)
.s1043:
14c2 : a5 17 __ LDA P10 ; (f + 2)
14c4 : c9 20 __ CMP #$20
14c6 : f0 05 __ BEQ $14cd ; (nformf.s44 + 0)
.s1046:
14c8 : b0 03 __ BCS $14cd ; (nformf.s44 + 0)
14ca : 4c ea 12 JMP $12ea ; (nformf.s31 + 0)
.s44:
14cd : a9 00 __ LDA #$00
14cf : 85 03 __ STA WORK + 0 
14d1 : 85 04 __ STA WORK + 1 
14d3 : a9 20 __ LDA #$20
14d5 : 85 05 __ STA WORK + 2 
14d7 : a9 41 __ LDA #$41
14d9 : 85 06 __ STA WORK + 3 
14db : 20 e6 1a JSR $1ae6 ; (freg + 20)
14de : 20 cd 1c JSR $1ccd ; (fdiv + 0)
14e1 : a5 1c __ LDA ACCU + 1 
14e3 : 85 16 __ STA P9 ; (f + 1)
14e5 : a5 1d __ LDA ACCU + 2 
14e7 : 85 17 __ STA P10 ; (f + 2)
14e9 : a5 1e __ LDA ACCU + 3 
14eb : 85 18 __ STA P11 ; (f + 3)
14ed : a6 1b __ LDX ACCU + 0 
14ef : e6 4a __ INC T5 + 0 
14f1 : f0 03 __ BEQ $14f6 ; (nformf.s1092 + 0)
14f3 : 4c ea 12 JMP $12ea ; (nformf.s31 + 0)
.s1092:
14f6 : e6 4b __ INC T5 + 1 
14f8 : 4c ea 12 JMP $12ea ; (nformf.s31 + 0)
.s13:
14fb : a5 18 __ LDA P11 ; (f + 3)
14fd : 30 59 __ BMI $1558 ; (nformf.l17 + 0)
.l1072:
14ff : c9 44 __ CMP #$44
1501 : f0 03 __ BEQ $1506 ; (nformf.s1073 + 0)
1503 : 4c f5 15 JMP $15f5 ; (nformf.s1076 + 0)
.s1073:
1506 : a5 45 __ LDA T1 + 2 
1508 : c9 7a __ CMP #$7a
150a : f0 03 __ BEQ $150f ; (nformf.s1074 + 0)
150c : 4c f5 15 JMP $15f5 ; (nformf.s1076 + 0)
.s1074:
150f : a5 44 __ LDA T1 + 1 
1511 : d0 04 __ BNE $1517 ; (nformf.s1082 + 0)
.s1075:
1513 : a5 43 __ LDA T1 + 0 
1515 : f0 02 __ BEQ $1519 ; (nformf.s14 + 0)
.s1082:
1517 : a5 43 __ LDA T1 + 0 
.s14:
1519 : 85 1b __ STA ACCU + 0 
151b : a5 44 __ LDA T1 + 1 
151d : 85 1c __ STA ACCU + 1 
151f : a5 45 __ LDA T1 + 2 
1521 : 85 1d __ STA ACCU + 2 
1523 : a5 46 __ LDA T1 + 3 
1525 : 85 1e __ STA ACCU + 3 
1527 : a9 00 __ LDA #$00
1529 : 85 03 __ STA WORK + 0 
152b : 85 04 __ STA WORK + 1 
152d : a9 7a __ LDA #$7a
152f : 85 05 __ STA WORK + 2 
1531 : a9 44 __ LDA #$44
1533 : 85 06 __ STA WORK + 3 
1535 : 20 e6 1a JSR $1ae6 ; (freg + 20)
1538 : 20 cd 1c JSR $1ccd ; (fdiv + 0)
153b : a5 1b __ LDA ACCU + 0 
153d : 85 43 __ STA T1 + 0 
153f : a5 1c __ LDA ACCU + 1 
1541 : 85 44 __ STA T1 + 1 
1543 : a5 1d __ LDA ACCU + 2 
1545 : 85 45 __ STA T1 + 2 
1547 : 18 __ __ CLC
1548 : a5 4a __ LDA T5 + 0 
154a : 69 03 __ ADC #$03
154c : 85 4a __ STA T5 + 0 
154e : 90 02 __ BCC $1552 ; (nformf.s1097 + 0)
.s1096:
1550 : e6 4b __ INC T5 + 1 
.s1097:
1552 : a5 1e __ LDA ACCU + 3 
1554 : 85 46 __ STA T1 + 3 
1556 : 10 a7 __ BPL $14ff ; (nformf.l1072 + 0)
.l17:
1558 : a9 00 __ LDA #$00
155a : 85 1b __ STA ACCU + 0 
155c : 85 1c __ STA ACCU + 1 
155e : a9 7a __ LDA #$7a
1560 : 85 1d __ STA ACCU + 2 
1562 : a9 44 __ LDA #$44
1564 : 85 1e __ STA ACCU + 3 
1566 : a2 43 __ LDX #$43
1568 : 20 d6 1a JSR $1ad6 ; (freg + 4)
156b : 20 fe 1b JSR $1bfe ; (fmul + 0)
156e : a5 1b __ LDA ACCU + 0 
1570 : 85 43 __ STA T1 + 0 
1572 : a5 1c __ LDA ACCU + 1 
1574 : 85 44 __ STA T1 + 1 
1576 : a5 1d __ LDA ACCU + 2 
1578 : 85 45 __ STA T1 + 2 
157a : a5 1e __ LDA ACCU + 3 
157c : 85 46 __ STA T1 + 3 
157e : 38 __ __ SEC
157f : a5 4a __ LDA T5 + 0 
1581 : e9 03 __ SBC #$03
1583 : 85 4a __ STA T5 + 0 
1585 : b0 02 __ BCS $1589 ; (nformf.s16 + 0)
.s1088:
1587 : c6 4b __ DEC T5 + 1 
.s16:
1589 : a5 46 __ LDA T1 + 3 
158b : 30 cb __ BMI $1558 ; (nformf.l17 + 0)
.s1064:
158d : c9 3f __ CMP #$3f
158f : d0 06 __ BNE $1597 ; (nformf.s1068 + 0)
.s1065:
1591 : a5 45 __ LDA T1 + 2 
1593 : c9 80 __ CMP #$80
1595 : f0 02 __ BEQ $1599 ; (nformf.s19 + 0)
.s1068:
1597 : 90 bf __ BCC $1558 ; (nformf.l17 + 0)
.s19:
1599 : a5 46 __ LDA T1 + 3 
159b : c9 41 __ CMP #$41
159d : d0 51 __ BNE $15f0 ; (nformf.l1060 + 0)
.s1057:
159f : a5 45 __ LDA T1 + 2 
15a1 : c9 20 __ CMP #$20
15a3 : d0 4b __ BNE $15f0 ; (nformf.l1060 + 0)
.s1058:
15a5 : a5 44 __ LDA T1 + 1 
15a7 : d0 04 __ BNE $15ad ; (nformf.l1081 + 0)
.s1059:
15a9 : a5 43 __ LDA T1 + 0 
15ab : f0 02 __ BEQ $15af ; (nformf.l20 + 0)
.l1081:
15ad : a5 43 __ LDA T1 + 0 
.l20:
15af : 85 1b __ STA ACCU + 0 
15b1 : a5 44 __ LDA T1 + 1 
15b3 : 85 1c __ STA ACCU + 1 
15b5 : a5 45 __ LDA T1 + 2 
15b7 : 85 1d __ STA ACCU + 2 
15b9 : a5 46 __ LDA T1 + 3 
15bb : 85 1e __ STA ACCU + 3 
15bd : a9 00 __ LDA #$00
15bf : 85 03 __ STA WORK + 0 
15c1 : 85 04 __ STA WORK + 1 
15c3 : a9 20 __ LDA #$20
15c5 : 85 05 __ STA WORK + 2 
15c7 : a9 41 __ LDA #$41
15c9 : 85 06 __ STA WORK + 3 
15cb : 20 e6 1a JSR $1ae6 ; (freg + 20)
15ce : 20 cd 1c JSR $1ccd ; (fdiv + 0)
15d1 : a5 1b __ LDA ACCU + 0 
15d3 : 85 43 __ STA T1 + 0 
15d5 : a5 1c __ LDA ACCU + 1 
15d7 : 85 44 __ STA T1 + 1 
15d9 : a5 1d __ LDA ACCU + 2 
15db : 85 45 __ STA T1 + 2 
15dd : e6 4a __ INC T5 + 0 
15df : d0 02 __ BNE $15e3 ; (nformf.s1091 + 0)
.s1090:
15e1 : e6 4b __ INC T5 + 1 
.s1091:
15e3 : a5 1e __ LDA ACCU + 3 
15e5 : 85 46 __ STA T1 + 3 
15e7 : 10 03 __ BPL $15ec ; (nformf.s1056 + 0)
15e9 : 4c ee 11 JMP $11ee ; (nformf.s12 + 0)
.s1056:
15ec : c9 41 __ CMP #$41
15ee : f0 af __ BEQ $159f ; (nformf.s1057 + 0)
.l1060:
15f0 : b0 bb __ BCS $15ad ; (nformf.l1081 + 0)
15f2 : 4c ee 11 JMP $11ee ; (nformf.s12 + 0)
.s1076:
15f5 : 90 92 __ BCC $1589 ; (nformf.s16 + 0)
15f7 : 4c 17 15 JMP $1517 ; (nformf.s1082 + 0)
.s7:
15fa : 85 1b __ STA ACCU + 0 
15fc : a9 49 __ LDA #$49
15fe : 91 13 __ STA (P6),y ; (str + 0)
1600 : a9 4e __ LDA #$4e
1602 : a4 4a __ LDY T5 + 0 
1604 : 91 13 __ STA (P6),y ; (str + 0)
1606 : a9 46 __ LDA #$46
1608 : a4 1b __ LDY ACCU + 0 
160a : 91 13 __ STA (P6),y ; (str + 0)
160c : 18 __ __ CLC
160d : a5 48 __ LDA T3 + 0 
160f : 69 03 __ ADC #$03
1611 : 85 48 __ STA T3 + 0 
1613 : 4c ef 13 JMP $13ef ; (nformf.s9 + 0)
.s189:
1616 : 20 2e 16 JSR $162e ; (isinf.s0 + 0)
1619 : aa __ __ TAX
161a : a9 01 __ LDA #$01
161c : 85 48 __ STA T3 + 0 
161e : 8a __ __ TXA
161f : d0 03 __ BNE $1624 ; (nformf.s158 + 0)
1621 : 4c cb 11 JMP $11cb ; (nformf.s8 + 0)
.s158:
1624 : a9 02 __ LDA #$02
1626 : 85 4a __ STA T5 + 0 
1628 : a9 03 __ LDA #$03
162a : a0 01 __ LDY #$01
162c : d0 cc __ BNE $15fa ; (nformf.s7 + 0)
--------------------------------------------------------------------
isinf:
.s0:
162e : 06 0f __ ASL P2 ; (f + 2)
1630 : a5 10 __ LDA P3 ; (f + 3)
1632 : 2a __ __ ROL
1633 : c9 ff __ CMP #$ff
1635 : d0 03 __ BNE $163a ; (isinf.s1003 + 0)
.s1002:
1637 : a9 01 __ LDA #$01
1639 : 60 __ __ RTS
.s1003:
163a : a9 00 __ LDA #$00
.s1001:
163c : 60 __ __ RTS
--------------------------------------------------------------------
fround5:
1f92 : __ __ __ BYT 00 00 00 3f cd cc 4c 3d 0a d7 a3 3b 6f 12 03 3a : ...?..L=...;o..:
1fa2 : __ __ __ BYT 17 b7 51 38 ac c5 a7 36 bd 37 06 35             : ..Q8...6.7.5
--------------------------------------------------------------------
163d : __ __ __ BYT 1e 53 43 4f 52 45 3a 20 25 64 00                : .SCORE: %d.
--------------------------------------------------------------------
spawn_enemy:
.s0:
1648 : 20 86 16 JSR $1686 ; (rand.s0 + 0)
164b : 46 1b __ LSR ACCU + 0 
164d : b0 0f __ BCS $165e ; (spawn_enemy.s1001 + 0)
.s3:
164f : a0 00 __ LDY #$00
.l6:
1651 : be 86 1f LDX $1f86,y ; (__multab3L + 0)
1654 : bd b4 1f LDA $1fb4,x ; (Enemy + 2)
1657 : f0 06 __ BEQ $165f ; (spawn_enemy.s9 + 0)
.s7:
1659 : c8 __ __ INY
165a : c0 0a __ CPY #$0a
165c : 90 f3 __ BCC $1651 ; (spawn_enemy.l6 + 0)
.s1001:
165e : 60 __ __ RTS
.s9:
165f : 86 43 __ STX T0 + 0 
1661 : a9 27 __ LDA #$27
1663 : 9d b2 1f STA $1fb2,x ; (Enemy + 0)
1666 : 20 86 16 JSR $1686 ; (rand.s0 + 0)
1669 : a9 01 __ LDA #$01
166b : a6 43 __ LDX T0 + 0 
166d : 9d b4 1f STA $1fb4,x ; (Enemy + 2)
1670 : a9 16 __ LDA #$16
1672 : 85 03 __ STA WORK + 0 
1674 : a9 00 __ LDA #$00
1676 : 85 04 __ STA WORK + 1 
1678 : 20 b5 1d JSR $1db5 ; (divmod + 0)
167b : 18 __ __ CLC
167c : a5 05 __ LDA WORK + 2 
167e : 69 03 __ ADC #$03
1680 : a6 43 __ LDX T0 + 0 
1682 : 9d b3 1f STA $1fb3,x ; (Enemy + 1)
1685 : 60 __ __ RTS
--------------------------------------------------------------------
rand:
.s0:
1686 : ad af 1f LDA $1faf ; (seed + 1)
1689 : 4a __ __ LSR
168a : ad ae 1f LDA $1fae ; (seed + 0)
168d : 6a __ __ ROR
168e : aa __ __ TAX
168f : a9 00 __ LDA #$00
1691 : 6a __ __ ROR
1692 : 4d ae 1f EOR $1fae ; (seed + 0)
1695 : 85 1b __ STA ACCU + 0 
1697 : 8a __ __ TXA
1698 : 4d af 1f EOR $1faf ; (seed + 1)
169b : 85 1c __ STA ACCU + 1 
169d : 4a __ __ LSR
169e : 45 1b __ EOR ACCU + 0 
16a0 : 8d ae 1f STA $1fae ; (seed + 0)
16a3 : 85 1b __ STA ACCU + 0 
16a5 : 45 1c __ EOR ACCU + 1 
16a7 : 8d af 1f STA $1faf ; (seed + 1)
16aa : 85 1c __ STA ACCU + 1 
.s1001:
16ac : 60 __ __ RTS
--------------------------------------------------------------------
seed:
1fae : __ __ __ BYT 00 7a                                           : .z
--------------------------------------------------------------------
move_enemies:
.s0:
16ad : a2 00 __ LDX #$00
.l2:
16af : 86 43 __ STX T0 + 0 
16b1 : bc 86 1f LDY $1f86,x ; (__multab3L + 0)
16b4 : b9 b4 1f LDA $1fb4,y ; (Enemy + 2)
16b7 : c9 01 __ CMP #$01
16b9 : d0 4b __ BNE $1706 ; (move_enemies.s29 + 0)
.s5:
16bb : 84 44 __ STY T1 + 0 
16bd : b9 b3 1f LDA $1fb3,y ; (Enemy + 1)
16c0 : 0a __ __ ASL
16c1 : 85 1b __ STA ACCU + 0 
16c3 : a9 00 __ LDA #$00
16c5 : 2a __ __ ROL
16c6 : 06 1b __ ASL ACCU + 0 
16c8 : 2a __ __ ROL
16c9 : aa __ __ TAX
16ca : a5 1b __ LDA ACCU + 0 
16cc : 79 b3 1f ADC $1fb3,y ; (Enemy + 1)
16cf : 85 1b __ STA ACCU + 0 
16d1 : 8a __ __ TXA
16d2 : 69 00 __ ADC #$00
16d4 : 06 1b __ ASL ACCU + 0 
16d6 : 2a __ __ ROL
16d7 : 06 1b __ ASL ACCU + 0 
16d9 : 2a __ __ ROL
16da : 06 1b __ ASL ACCU + 0 
16dc : 2a __ __ ROL
16dd : aa __ __ TAX
16de : b9 b2 1f LDA $1fb2,y ; (Enemy + 0)
16e1 : 85 45 __ STA T3 + 0 
16e3 : 18 __ __ CLC
16e4 : 65 1b __ ADC ACCU + 0 
16e6 : 85 1b __ STA ACCU + 0 
16e8 : 85 1f __ STA ADDR + 0 
16ea : 8a __ __ TXA
16eb : 69 04 __ ADC #$04
16ed : 85 1c __ STA ACCU + 1 
16ef : 18 __ __ CLC
16f0 : 69 d4 __ ADC #$d4
16f2 : 85 20 __ STA ADDR + 1 
16f4 : a9 20 __ LDA #$20
16f6 : a0 00 __ LDY #$00
16f8 : 91 1b __ STA (ACCU + 0),y 
16fa : 98 __ __ TYA
16fb : 91 1f __ STA (ADDR + 0),y 
16fd : a5 45 __ LDA T3 + 0 
16ff : d0 0d __ BNE $170e ; (move_enemies.s8 + 0)
.s9:
1701 : a6 44 __ LDX T1 + 0 
1703 : 9d b4 1f STA $1fb4,x ; (Enemy + 2)
.s29:
1706 : a6 43 __ LDX T0 + 0 
1708 : e8 __ __ INX
1709 : e0 0a __ CPX #$0a
170b : 90 a2 __ BCC $16af ; (move_enemies.l2 + 0)
.s1001:
170d : 60 __ __ RTS
.s8:
170e : c6 45 __ DEC T3 + 0 
1710 : a5 45 __ LDA T3 + 0 
1712 : a6 44 __ LDX T1 + 0 
1714 : 9d b2 1f STA $1fb2,x ; (Enemy + 0)
1717 : 20 86 16 JSR $1686 ; (rand.s0 + 0)
171a : a6 44 __ LDX T1 + 0 
171c : bd b3 1f LDA $1fb3,x ; (Enemy + 1)
171f : 85 46 __ STA T4 + 0 
1721 : a9 03 __ LDA #$03
1723 : 85 03 __ STA WORK + 0 
1725 : a9 00 __ LDA #$00
1727 : 85 04 __ STA WORK + 1 
1729 : 20 b5 1d JSR $1db5 ; (divmod + 0)
172c : 38 __ __ SEC
172d : a5 05 __ LDA WORK + 2 
172f : e9 01 __ SBC #$01
1731 : aa __ __ TAX
1732 : a5 06 __ LDA WORK + 3 
1734 : e9 00 __ SBC #$00
1736 : a8 __ __ TAY
1737 : 8a __ __ TXA
1738 : 18 __ __ CLC
1739 : 65 46 __ ADC T4 + 0 
173b : 85 1b __ STA ACCU + 0 
173d : 90 01 __ BCC $1740 ; (move_enemies.s1011 + 0)
.s1010:
173f : c8 __ __ INY
.s1011:
1740 : 0a __ __ ASL
1741 : 0a __ __ ASL
1742 : 18 __ __ CLC
1743 : 65 1b __ ADC ACCU + 0 
1745 : 0a __ __ ASL
1746 : 0a __ __ ASL
1747 : 0a __ __ ASL
1748 : 18 __ __ CLC
1749 : 65 45 __ ADC T3 + 0 
174b : aa __ __ TAX
174c : bd 00 04 LDA $0400,x 
174f : c9 58 __ CMP #$58
1751 : f0 b3 __ BEQ $1706 ; (move_enemies.s29 + 0)
.s15:
1753 : 98 __ __ TYA
1754 : d0 b0 __ BNE $1706 ; (move_enemies.s29 + 0)
.s1005:
1756 : a5 1b __ LDA ACCU + 0 
1758 : c9 03 __ CMP #$03
175a : 90 aa __ BCC $1706 ; (move_enemies.s29 + 0)
.s1004:
175c : c9 19 __ CMP #$19
175e : b0 a6 __ BCS $1706 ; (move_enemies.s29 + 0)
.s11:
1760 : a6 44 __ LDX T1 + 0 
1762 : 9d b3 1f STA $1fb3,x ; (Enemy + 1)
1765 : 4c 06 17 JMP $1706 ; (move_enemies.s29 + 0)
--------------------------------------------------------------------
render_enemies:
.s0:
1768 : a2 00 __ LDX #$00
.l1006:
176a : bc 86 1f LDY $1f86,x ; (__multab3L + 0)
176d : b9 b4 1f LDA $1fb4,y ; (Enemy + 2)
1770 : c9 01 __ CMP #$01
1772 : d0 43 __ BNE $17b7 ; (render_enemies.s19 + 0)
.s5:
1774 : b9 b3 1f LDA $1fb3,y ; (Enemy + 1)
1777 : 0a __ __ ASL
1778 : 85 1b __ STA ACCU + 0 
177a : a9 00 __ LDA #$00
177c : 2a __ __ ROL
177d : 06 1b __ ASL ACCU + 0 
177f : 2a __ __ ROL
1780 : 85 1c __ STA ACCU + 1 
1782 : a5 1b __ LDA ACCU + 0 
1784 : 79 b3 1f ADC $1fb3,y ; (Enemy + 1)
1787 : 85 1b __ STA ACCU + 0 
1789 : a5 1c __ LDA ACCU + 1 
178b : 69 00 __ ADC #$00
178d : 06 1b __ ASL ACCU + 0 
178f : 2a __ __ ROL
1790 : 06 1b __ ASL ACCU + 0 
1792 : 2a __ __ ROL
1793 : 06 1b __ ASL ACCU + 0 
1795 : 2a __ __ ROL
1796 : 85 1c __ STA ACCU + 1 
1798 : 18 __ __ CLC
1799 : a5 1b __ LDA ACCU + 0 
179b : 79 b2 1f ADC $1fb2,y ; (Enemy + 0)
179e : 85 1b __ STA ACCU + 0 
17a0 : 85 1f __ STA ADDR + 0 
17a2 : a5 1c __ LDA ACCU + 1 
17a4 : 69 04 __ ADC #$04
17a6 : 85 1c __ STA ACCU + 1 
17a8 : 18 __ __ CLC
17a9 : 69 d4 __ ADC #$d4
17ab : 85 20 __ STA ADDR + 1 
17ad : a9 58 __ LDA #$58
17af : a0 00 __ LDY #$00
17b1 : 91 1b __ STA (ACCU + 0),y 
17b3 : a9 08 __ LDA #$08
17b5 : 91 1f __ STA (ADDR + 0),y 
.s19:
17b7 : e8 __ __ INX
17b8 : e0 0a __ CPX #$0a
17ba : 90 ae __ BCC $176a ; (render_enemies.l1006 + 0)
.s1001:
17bc : 60 __ __ RTS
--------------------------------------------------------------------
check_player_enemy_collision:
.s0:
17bd : a0 00 __ LDY #$00
.l2:
17bf : be 86 1f LDX $1f86,y ; (__multab3L + 0)
17c2 : bd b4 1f LDA $1fb4,x ; (Enemy + 2)
17c5 : c9 01 __ CMP #$01
17c7 : d0 10 __ BNE $17d9 ; (check_player_enemy_collision.s3 + 0)
.s5:
17c9 : bd b2 1f LDA $1fb2,x ; (Enemy + 0)
17cc : cd b0 1f CMP $1fb0 ; (Player + 0)
17cf : d0 08 __ BNE $17d9 ; (check_player_enemy_collision.s3 + 0)
.s11:
17d1 : bd b3 1f LDA $1fb3,x ; (Enemy + 1)
17d4 : cd b1 1f CMP $1fb1 ; (Player + 1)
17d7 : f0 06 __ BEQ $17df ; (check_player_enemy_collision.s8 + 0)
.s3:
17d9 : c8 __ __ INY
17da : c0 0a __ CPY #$0a
17dc : 90 e1 __ BCC $17bf ; (check_player_enemy_collision.l2 + 0)
.s1001:
17de : 60 __ __ RTS
.s8:
17df : a9 01 __ LDA #$01
17e1 : 8d d9 1f STA $1fd9 ; (game + 0)
17e4 : 60 __ __ RTS
--------------------------------------------------------------------
control_player_ship:
.s0:
17e5 : a9 00 __ LDA #$00
17e7 : 20 87 18 JSR $1887 ; (joy_poll.s0 + 0)
17ea : ad e0 1f LDA $1fe0 ; (joyx + 0)
17ed : 85 1d __ STA ACCU + 2 
17ef : 85 1e __ STA ACCU + 3 
17f1 : d0 08 __ BNE $17fb ; (control_player_ship.s1 + 0)
.s4:
17f3 : ad de 1f LDA $1fde ; (joyy + 0)
17f6 : d0 03 __ BNE $17fb ; (control_player_ship.s1 + 0)
17f8 : 4c 7c 18 JMP $187c ; (control_player_ship.s3 + 0)
.s1:
17fb : ad b0 1f LDA $1fb0 ; (Player + 0)
17fe : 85 43 __ STA T2 + 0 
1800 : 85 44 __ STA T3 + 0 
1802 : ad b1 1f LDA $1fb1 ; (Player + 1)
1805 : 85 45 __ STA T4 + 0 
1807 : 85 46 __ STA T5 + 0 
1809 : 0a __ __ ASL
180a : 85 1b __ STA ACCU + 0 
180c : a9 00 __ LDA #$00
180e : 2a __ __ ROL
180f : 06 1b __ ASL ACCU + 0 
1811 : 2a __ __ ROL
1812 : aa __ __ TAX
1813 : a5 1b __ LDA ACCU + 0 
1815 : 65 45 __ ADC T4 + 0 
1817 : 85 1b __ STA ACCU + 0 
1819 : 8a __ __ TXA
181a : 69 00 __ ADC #$00
181c : 06 1b __ ASL ACCU + 0 
181e : 2a __ __ ROL
181f : 06 1b __ ASL ACCU + 0 
1821 : 2a __ __ ROL
1822 : 06 1b __ ASL ACCU + 0 
1824 : 2a __ __ ROL
1825 : aa __ __ TAX
1826 : 18 __ __ CLC
1827 : a5 1b __ LDA ACCU + 0 
1829 : 65 43 __ ADC T2 + 0 
182b : 85 1b __ STA ACCU + 0 
182d : 85 1f __ STA ADDR + 0 
182f : 8a __ __ TXA
1830 : 69 04 __ ADC #$04
1832 : 85 1c __ STA ACCU + 1 
1834 : 18 __ __ CLC
1835 : 69 d4 __ ADC #$d4
1837 : 85 20 __ STA ADDR + 1 
1839 : a9 20 __ LDA #$20
183b : a0 00 __ LDY #$00
183d : 91 1b __ STA (ACCU + 0),y 
183f : 98 __ __ TYA
1840 : 91 1f __ STA (ADDR + 0),y 
1842 : a5 43 __ LDA T2 + 0 
1844 : f0 04 __ BEQ $184a ; (control_player_ship.s6 + 0)
.s8:
1846 : a5 1d __ LDA ACCU + 2 
1848 : 30 0c __ BMI $1856 ; (control_player_ship.s5 + 0)
.s6:
184a : a5 43 __ LDA T2 + 0 
184c : c9 27 __ CMP #$27
184e : b0 0e __ BCS $185e ; (control_player_ship.s7 + 0)
.s12:
1850 : a5 1d __ LDA ACCU + 2 
1852 : 30 0a __ BMI $185e ; (control_player_ship.s7 + 0)
.s1009:
1854 : f0 08 __ BEQ $185e ; (control_player_ship.s7 + 0)
.s5:
1856 : 18 __ __ CLC
1857 : a5 44 __ LDA T3 + 0 
1859 : 65 1e __ ADC ACCU + 3 
185b : 8d b0 1f STA $1fb0 ; (Player + 0)
.s7:
185e : a5 45 __ LDA T4 + 0 
1860 : c9 04 __ CMP #$04
1862 : 90 07 __ BCC $186b ; (control_player_ship.s14 + 0)
.s16:
1864 : ad de 1f LDA $1fde ; (joyy + 0)
1867 : 30 0d __ BMI $1876 ; (control_player_ship.s32 + 0)
.s1012:
1869 : a5 45 __ LDA T4 + 0 
.s14:
186b : c9 18 __ CMP #$18
186d : b0 0d __ BCS $187c ; (control_player_ship.s3 + 0)
.s20:
186f : ad de 1f LDA $1fde ; (joyy + 0)
1872 : 30 08 __ BMI $187c ; (control_player_ship.s3 + 0)
.s1004:
1874 : f0 06 __ BEQ $187c ; (control_player_ship.s3 + 0)
.s32:
1876 : 18 __ __ CLC
1877 : 65 46 __ ADC T5 + 0 
1879 : 8d b1 1f STA $1fb1 ; (Player + 1)
.s3:
187c : ad e2 1f LDA $1fe2 ; (joyb + 0)
187f : c9 01 __ CMP #$01
1881 : f0 01 __ BEQ $1884 ; (control_player_ship.s21 + 0)
.s1001:
1883 : 60 __ __ RTS
.s21:
1884 : 4c c7 18 JMP $18c7 ; (spawn_player_shot.s0 + 0)
--------------------------------------------------------------------
joy_poll:
.s0:
1887 : aa __ __ TAX
1888 : bd 00 dc LDA $dc00,x 
188b : a8 __ __ TAY
188c : 29 10 __ AND #$10
188e : f0 04 __ BEQ $1894 ; (joy_poll.s1005 + 0)
.s1006:
1890 : a9 00 __ LDA #$00
1892 : f0 02 __ BEQ $1896 ; (joy_poll.s1007 + 0)
.s1005:
1894 : a9 01 __ LDA #$01
.s1007:
1896 : 9d e2 1f STA $1fe2,x ; (joyb + 0)
1899 : 98 __ __ TYA
189a : 4a __ __ LSR
189b : b0 1d __ BCS $18ba ; (joy_poll.s2 + 0)
.s1:
189d : a9 ff __ LDA #$ff
.s15:
189f : 9d de 1f STA $1fde,x ; (joyy + 0)
18a2 : 98 __ __ TYA
18a3 : 29 04 __ AND #$04
18a5 : d0 06 __ BNE $18ad ; (joy_poll.s8 + 0)
.s7:
18a7 : a9 ff __ LDA #$ff
.s1001:
18a9 : 9d e0 1f STA $1fe0,x ; (joyx + 0)
18ac : 60 __ __ RTS
.s8:
18ad : 98 __ __ TYA
18ae : 29 08 __ AND #$08
18b0 : f0 04 __ BEQ $18b6 ; (joy_poll.s1011 + 0)
.s1012:
18b2 : a9 00 __ LDA #$00
18b4 : f0 f3 __ BEQ $18a9 ; (joy_poll.s1001 + 0)
.s1011:
18b6 : a9 01 __ LDA #$01
18b8 : d0 ef __ BNE $18a9 ; (joy_poll.s1001 + 0)
.s2:
18ba : 98 __ __ TYA
18bb : 29 02 __ AND #$02
18bd : f0 04 __ BEQ $18c3 ; (joy_poll.s1008 + 0)
.s1009:
18bf : a9 00 __ LDA #$00
18c1 : f0 dc __ BEQ $189f ; (joy_poll.s15 + 0)
.s1008:
18c3 : a9 01 __ LDA #$01
18c5 : d0 d8 __ BNE $189f ; (joy_poll.s15 + 0)
--------------------------------------------------------------------
joyy:
1fde : __ __ __ BSS	2
--------------------------------------------------------------------
joyx:
1fe0 : __ __ __ BSS	2
--------------------------------------------------------------------
joyb:
1fe2 : __ __ __ BSS	2
--------------------------------------------------------------------
spawn_player_shot:
.s0:
18c7 : ad b0 1f LDA $1fb0 ; (Player + 0)
18ca : c9 27 __ CMP #$27
18cc : f0 0f __ BEQ $18dd ; (spawn_player_shot.s1001 + 0)
.s3:
18ce : a0 00 __ LDY #$00
.l6:
18d0 : be 86 1f LDX $1f86,y ; (__multab3L + 0)
18d3 : bd d2 1f LDA $1fd2,x ; (PlayerShot + 2)
18d6 : f0 06 __ BEQ $18de ; (spawn_player_shot.s9 + 0)
.s7:
18d8 : c8 __ __ INY
18d9 : c0 03 __ CPY #$03
18db : 90 f3 __ BCC $18d0 ; (spawn_player_shot.l6 + 0)
.s1001:
18dd : 60 __ __ RTS
.s9:
18de : a9 01 __ LDA #$01
18e0 : 9d d2 1f STA $1fd2,x ; (PlayerShot + 2)
18e3 : ad b1 1f LDA $1fb1 ; (Player + 1)
18e6 : 9d d1 1f STA $1fd1,x ; (PlayerShot + 1)
18e9 : ad e0 1f LDA $1fe0 ; (joyx + 0)
18ec : 30 02 __ BMI $18f0 ; (spawn_player_shot.s13 + 0)
.s1007:
18ee : d0 06 __ BNE $18f6 ; (spawn_player_shot.s12 + 0)
.s13:
18f0 : ad b0 1f LDA $1fb0 ; (Player + 0)
18f3 : 4c fc 18 JMP $18fc ; (spawn_player_shot.s1010 + 0)
.s12:
18f6 : ad b0 1f LDA $1fb0 ; (Player + 0)
18f9 : 18 __ __ CLC
18fa : 69 01 __ ADC #$01
.s1010:
18fc : be 86 1f LDX $1f86,y ; (__multab3L + 0)
18ff : 9d d0 1f STA $1fd0,x ; (PlayerShot + 0)
1902 : 60 __ __ RTS
--------------------------------------------------------------------
render_player_ship:
.s0:
1903 : ad b1 1f LDA $1fb1 ; (Player + 1)
1906 : 0a __ __ ASL
1907 : 85 1b __ STA ACCU + 0 
1909 : a9 00 __ LDA #$00
190b : 2a __ __ ROL
190c : 06 1b __ ASL ACCU + 0 
190e : 2a __ __ ROL
190f : aa __ __ TAX
1910 : a5 1b __ LDA ACCU + 0 
1912 : 6d b1 1f ADC $1fb1 ; (Player + 1)
1915 : 85 1b __ STA ACCU + 0 
1917 : 8a __ __ TXA
1918 : 69 00 __ ADC #$00
191a : 06 1b __ ASL ACCU + 0 
191c : 2a __ __ ROL
191d : 06 1b __ ASL ACCU + 0 
191f : 2a __ __ ROL
1920 : 06 1b __ ASL ACCU + 0 
1922 : 2a __ __ ROL
1923 : aa __ __ TAX
1924 : 18 __ __ CLC
1925 : a5 1b __ LDA ACCU + 0 
1927 : 6d b0 1f ADC $1fb0 ; (Player + 0)
192a : 85 1b __ STA ACCU + 0 
192c : 85 1f __ STA ADDR + 0 
192e : 8a __ __ TXA
192f : 69 04 __ ADC #$04
1931 : 85 1c __ STA ACCU + 1 
1933 : 18 __ __ CLC
1934 : 69 d4 __ ADC #$d4
1936 : 85 20 __ STA ADDR + 1 
1938 : a9 51 __ LDA #$51
193a : a0 00 __ LDY #$00
193c : 91 1b __ STA (ACCU + 0),y 
193e : a9 03 __ LDA #$03
1940 : 91 1f __ STA (ADDR + 0),y 
.s1001:
1942 : 60 __ __ RTS
--------------------------------------------------------------------
move_player_shots:
.s0:
1943 : a2 00 __ LDX #$00
.l2:
1945 : 86 1d __ STX ACCU + 2 
1947 : bc 86 1f LDY $1f86,x ; (__multab3L + 0)
194a : b9 d2 1f LDA $1fd2,y ; (PlayerShot + 2)
194d : c9 01 __ CMP #$01
194f : d0 52 __ BNE $19a3 ; (move_player_shots.s23 + 0)
.s5:
1951 : 84 1e __ STY ACCU + 3 
1953 : b9 d1 1f LDA $1fd1,y ; (PlayerShot + 1)
1956 : 0a __ __ ASL
1957 : 85 1b __ STA ACCU + 0 
1959 : a9 00 __ LDA #$00
195b : 2a __ __ ROL
195c : 06 1b __ ASL ACCU + 0 
195e : 2a __ __ ROL
195f : aa __ __ TAX
1960 : a5 1b __ LDA ACCU + 0 
1962 : 79 d1 1f ADC $1fd1,y ; (PlayerShot + 1)
1965 : 85 1b __ STA ACCU + 0 
1967 : 8a __ __ TXA
1968 : 69 00 __ ADC #$00
196a : 06 1b __ ASL ACCU + 0 
196c : 2a __ __ ROL
196d : 06 1b __ ASL ACCU + 0 
196f : 2a __ __ ROL
1970 : 06 1b __ ASL ACCU + 0 
1972 : 2a __ __ ROL
1973 : 85 1c __ STA ACCU + 1 
1975 : b9 d0 1f LDA $1fd0,y ; (PlayerShot + 0)
1978 : aa __ __ TAX
1979 : 18 __ __ CLC
197a : 65 1b __ ADC ACCU + 0 
197c : 85 1b __ STA ACCU + 0 
197e : 85 1f __ STA ADDR + 0 
1980 : a5 1c __ LDA ACCU + 1 
1982 : 69 04 __ ADC #$04
1984 : 85 1c __ STA ACCU + 1 
1986 : 18 __ __ CLC
1987 : 69 d4 __ ADC #$d4
1989 : 85 20 __ STA ADDR + 1 
198b : a9 20 __ LDA #$20
198d : a0 00 __ LDY #$00
198f : 91 1b __ STA (ACCU + 0),y 
1991 : 98 __ __ TYA
1992 : 91 1f __ STA (ADDR + 0),y 
1994 : e8 __ __ INX
1995 : 8a __ __ TXA
1996 : a6 1e __ LDX ACCU + 3 
1998 : 9d d0 1f STA $1fd0,x ; (PlayerShot + 0)
199b : c9 28 __ CMP #$28
199d : 90 04 __ BCC $19a3 ; (move_player_shots.s23 + 0)
.s8:
199f : 98 __ __ TYA
19a0 : 9d d2 1f STA $1fd2,x ; (PlayerShot + 2)
.s23:
19a3 : a6 1d __ LDX ACCU + 2 
19a5 : e8 __ __ INX
19a6 : e0 03 __ CPX #$03
19a8 : 90 9b __ BCC $1945 ; (move_player_shots.l2 + 0)
.s1001:
19aa : 60 __ __ RTS
--------------------------------------------------------------------
render_player_shots:
.s0:
19ab : a2 00 __ LDX #$00
.l1006:
19ad : bc 86 1f LDY $1f86,x ; (__multab3L + 0)
19b0 : b9 d2 1f LDA $1fd2,y ; (PlayerShot + 2)
19b3 : c9 01 __ CMP #$01
19b5 : d0 43 __ BNE $19fa ; (render_player_shots.s19 + 0)
.s5:
19b7 : b9 d1 1f LDA $1fd1,y ; (PlayerShot + 1)
19ba : 0a __ __ ASL
19bb : 85 1b __ STA ACCU + 0 
19bd : a9 00 __ LDA #$00
19bf : 2a __ __ ROL
19c0 : 06 1b __ ASL ACCU + 0 
19c2 : 2a __ __ ROL
19c3 : 85 1c __ STA ACCU + 1 
19c5 : a5 1b __ LDA ACCU + 0 
19c7 : 79 d1 1f ADC $1fd1,y ; (PlayerShot + 1)
19ca : 85 1b __ STA ACCU + 0 
19cc : a5 1c __ LDA ACCU + 1 
19ce : 69 00 __ ADC #$00
19d0 : 06 1b __ ASL ACCU + 0 
19d2 : 2a __ __ ROL
19d3 : 06 1b __ ASL ACCU + 0 
19d5 : 2a __ __ ROL
19d6 : 06 1b __ ASL ACCU + 0 
19d8 : 2a __ __ ROL
19d9 : 85 1c __ STA ACCU + 1 
19db : 18 __ __ CLC
19dc : a5 1b __ LDA ACCU + 0 
19de : 79 d0 1f ADC $1fd0,y ; (PlayerShot + 0)
19e1 : 85 1b __ STA ACCU + 0 
19e3 : 85 1f __ STA ADDR + 0 
19e5 : a5 1c __ LDA ACCU + 1 
19e7 : 69 04 __ ADC #$04
19e9 : 85 1c __ STA ACCU + 1 
19eb : 18 __ __ CLC
19ec : 69 d4 __ ADC #$d4
19ee : 85 20 __ STA ADDR + 1 
19f0 : a9 2b __ LDA #$2b
19f2 : a0 00 __ LDY #$00
19f4 : 91 1b __ STA (ACCU + 0),y 
19f6 : a9 01 __ LDA #$01
19f8 : 91 1f __ STA (ADDR + 0),y 
.s19:
19fa : e8 __ __ INX
19fb : e0 03 __ CPX #$03
19fd : 90 ae __ BCC $19ad ; (render_player_shots.l1006 + 0)
.s1001:
19ff : 60 __ __ RTS
--------------------------------------------------------------------
check_shot_enemy_collision:
.s0:
1a00 : a2 00 __ LDX #$00
.l2:
1a02 : 86 1d __ STX ACCU + 2 
1a04 : bc 86 1f LDY $1f86,x ; (__multab3L + 0)
1a07 : b9 d2 1f LDA $1fd2,y ; (PlayerShot + 2)
1a0a : c9 01 __ CMP #$01
1a0c : f0 03 __ BEQ $1a11 ; (check_shot_enemy_collision.s5 + 0)
1a0e : 4c a6 1a JMP $1aa6 ; (check_shot_enemy_collision.s3 + 0)
.s5:
1a11 : a2 00 __ LDX #$00
.l9:
1a13 : 86 43 __ STX T2 + 0 
1a15 : bc 86 1f LDY $1f86,x ; (__multab3L + 0)
1a18 : 84 1e __ STY ACCU + 3 
1a1a : b9 b4 1f LDA $1fb4,y ; (Enemy + 2)
1a1d : c9 01 __ CMP #$01
1a1f : d0 7b __ BNE $1a9c ; (check_shot_enemy_collision.s43 + 0)
.s12:
1a21 : a6 1d __ LDX ACCU + 2 
1a23 : bd 86 1f LDA $1f86,x ; (__multab3L + 0)
1a26 : 85 44 __ STA T3 + 0 
1a28 : aa __ __ TAX
1a29 : b9 b2 1f LDA $1fb2,y ; (Enemy + 0)
1a2c : dd d0 1f CMP $1fd0,x ; (PlayerShot + 0)
1a2f : d0 6b __ BNE $1a9c ; (check_shot_enemy_collision.s43 + 0)
.s18:
1a31 : b9 b3 1f LDA $1fb3,y ; (Enemy + 1)
1a34 : dd d1 1f CMP $1fd1,x ; (PlayerShot + 1)
1a37 : d0 63 __ BNE $1a9c ; (check_shot_enemy_collision.s43 + 0)
.s15:
1a39 : 0a __ __ ASL
1a3a : 85 1b __ STA ACCU + 0 
1a3c : a9 00 __ LDA #$00
1a3e : 2a __ __ ROL
1a3f : 06 1b __ ASL ACCU + 0 
1a41 : 2a __ __ ROL
1a42 : aa __ __ TAX
1a43 : a5 1b __ LDA ACCU + 0 
1a45 : 79 b3 1f ADC $1fb3,y ; (Enemy + 1)
1a48 : 85 1b __ STA ACCU + 0 
1a4a : 8a __ __ TXA
1a4b : 69 00 __ ADC #$00
1a4d : 06 1b __ ASL ACCU + 0 
1a4f : 2a __ __ ROL
1a50 : 06 1b __ ASL ACCU + 0 
1a52 : 2a __ __ ROL
1a53 : 06 1b __ ASL ACCU + 0 
1a55 : 2a __ __ ROL
1a56 : aa __ __ TAX
1a57 : 18 __ __ CLC
1a58 : a5 1b __ LDA ACCU + 0 
1a5a : 79 b2 1f ADC $1fb2,y ; (Enemy + 0)
1a5d : 85 1b __ STA ACCU + 0 
1a5f : 85 1f __ STA ADDR + 0 
1a61 : 8a __ __ TXA
1a62 : 69 04 __ ADC #$04
1a64 : 85 1c __ STA ACCU + 1 
1a66 : 18 __ __ CLC
1a67 : 69 d4 __ ADC #$d4
1a69 : 85 20 __ STA ADDR + 1 
1a6b : a9 20 __ LDA #$20
1a6d : a0 00 __ LDY #$00
1a6f : 91 1b __ STA (ACCU + 0),y 
1a71 : 98 __ __ TYA
1a72 : 91 1f __ STA (ADDR + 0),y 
1a74 : a6 1e __ LDX ACCU + 3 
1a76 : 9d b4 1f STA $1fb4,x ; (Enemy + 2)
1a79 : a6 44 __ LDX T3 + 0 
1a7b : 9d d2 1f STA $1fd2,x ; (PlayerShot + 2)
1a7e : ad da 1f LDA $1fda ; (game + 1)
1a81 : 18 __ __ CLC
1a82 : 69 01 __ ADC #$01
1a84 : 8d da 1f STA $1fda ; (game + 1)
1a87 : ad db 1f LDA $1fdb ; (game + 2)
1a8a : 69 00 __ ADC #$00
1a8c : 8d db 1f STA $1fdb ; (game + 2)
1a8f : ad dc 1f LDA $1fdc ; (game + 3)
1a92 : 69 00 __ ADC #$00
1a94 : 8d dc 1f STA $1fdc ; (game + 3)
1a97 : 90 03 __ BCC $1a9c ; (check_shot_enemy_collision.s43 + 0)
.s1014:
1a99 : ee dd 1f INC $1fdd ; (game + 4)
.s43:
1a9c : a6 43 __ LDX T2 + 0 
1a9e : e8 __ __ INX
1a9f : e0 0a __ CPX #$0a
1aa1 : b0 03 __ BCS $1aa6 ; (check_shot_enemy_collision.s3 + 0)
1aa3 : 4c 13 1a JMP $1a13 ; (check_shot_enemy_collision.l9 + 0)
.s3:
1aa6 : a6 1d __ LDX ACCU + 2 
1aa8 : e8 __ __ INX
1aa9 : e0 03 __ CPX #$03
1aab : b0 03 __ BCS $1ab0 ; (check_shot_enemy_collision.s1001 + 0)
1aad : 4c 02 1a JMP $1a02 ; (check_shot_enemy_collision.l2 + 0)
.s1001:
1ab0 : 60 __ __ RTS
--------------------------------------------------------------------
wait_frames:
.s0:
1ab1 : a5 0e __ LDA P1 ; (frames + 1)
1ab3 : 30 1c __ BMI $1ad1 ; (wait_frames.s1001 + 0)
.s1005:
1ab5 : 05 0d __ ORA P0 ; (frames + 0)
1ab7 : f0 18 __ BEQ $1ad1 ; (wait_frames.s1001 + 0)
.s13:
1ab9 : a0 00 __ LDY #$00
1abb : a6 0e __ LDX P1 ; (frames + 1)
.l6:
1abd : ad 11 d0 LDA $d011 
1ac0 : 30 fb __ BMI $1abd ; (wait_frames.l6 + 0)
.l9:
1ac2 : ad 11 d0 LDA $d011 
1ac5 : 10 fb __ BPL $1ac2 ; (wait_frames.l9 + 0)
.s3:
1ac7 : c8 __ __ INY
1ac8 : 8a __ __ TXA
1ac9 : 30 06 __ BMI $1ad1 ; (wait_frames.s1001 + 0)
.s1004:
1acb : d0 f0 __ BNE $1abd ; (wait_frames.l6 + 0)
.s1002:
1acd : c4 0d __ CPY P0 ; (frames + 0)
1acf : 90 ec __ BCC $1abd ; (wait_frames.l6 + 0)
.s1001:
1ad1 : 60 __ __ RTS
--------------------------------------------------------------------
freg:
1ad2 : b1 19 __ LDA (IP + 0),y 
1ad4 : c8 __ __ INY
1ad5 : aa __ __ TAX
1ad6 : b5 00 __ LDA $00,x 
1ad8 : 85 03 __ STA WORK + 0 
1ada : b5 01 __ LDA $01,x 
1adc : 85 04 __ STA WORK + 1 
1ade : b5 02 __ LDA $02,x 
1ae0 : 85 05 __ STA WORK + 2 
1ae2 : b5 03 __ LDA WORK + 0,x 
1ae4 : 85 06 __ STA WORK + 3 
1ae6 : a5 05 __ LDA WORK + 2 
1ae8 : 0a __ __ ASL
1ae9 : a5 06 __ LDA WORK + 3 
1aeb : 2a __ __ ROL
1aec : 85 08 __ STA WORK + 5 
1aee : f0 06 __ BEQ $1af6 ; (freg + 36)
1af0 : a5 05 __ LDA WORK + 2 
1af2 : 09 80 __ ORA #$80
1af4 : 85 05 __ STA WORK + 2 
1af6 : a5 1d __ LDA ACCU + 2 
1af8 : 0a __ __ ASL
1af9 : a5 1e __ LDA ACCU + 3 
1afb : 2a __ __ ROL
1afc : 85 07 __ STA WORK + 4 
1afe : f0 06 __ BEQ $1b06 ; (freg + 52)
1b00 : a5 1d __ LDA ACCU + 2 
1b02 : 09 80 __ ORA #$80
1b04 : 85 1d __ STA ACCU + 2 
1b06 : 60 __ __ RTS
1b07 : 06 1e __ ASL ACCU + 3 
1b09 : a5 07 __ LDA WORK + 4 
1b0b : 6a __ __ ROR
1b0c : 85 1e __ STA ACCU + 3 
1b0e : b0 06 __ BCS $1b16 ; (freg + 68)
1b10 : a5 1d __ LDA ACCU + 2 
1b12 : 29 7f __ AND #$7f
1b14 : 85 1d __ STA ACCU + 2 
1b16 : 60 __ __ RTS
--------------------------------------------------------------------
faddsub:
1b17 : a9 ff __ LDA #$ff
1b19 : c5 07 __ CMP WORK + 4 
1b1b : f0 04 __ BEQ $1b21 ; (faddsub + 10)
1b1d : c5 08 __ CMP WORK + 5 
1b1f : d0 11 __ BNE $1b32 ; (faddsub + 27)
1b21 : a5 1e __ LDA ACCU + 3 
1b23 : 09 7f __ ORA #$7f
1b25 : 85 1e __ STA ACCU + 3 
1b27 : a9 80 __ LDA #$80
1b29 : 85 1d __ STA ACCU + 2 
1b2b : a9 00 __ LDA #$00
1b2d : 85 1b __ STA ACCU + 0 
1b2f : 85 1c __ STA ACCU + 1 
1b31 : 60 __ __ RTS
1b32 : 38 __ __ SEC
1b33 : a5 07 __ LDA WORK + 4 
1b35 : e5 08 __ SBC WORK + 5 
1b37 : f0 38 __ BEQ $1b71 ; (faddsub + 90)
1b39 : aa __ __ TAX
1b3a : b0 25 __ BCS $1b61 ; (faddsub + 74)
1b3c : e0 e9 __ CPX #$e9
1b3e : b0 0e __ BCS $1b4e ; (faddsub + 55)
1b40 : a5 08 __ LDA WORK + 5 
1b42 : 85 07 __ STA WORK + 4 
1b44 : a9 00 __ LDA #$00
1b46 : 85 1b __ STA ACCU + 0 
1b48 : 85 1c __ STA ACCU + 1 
1b4a : 85 1d __ STA ACCU + 2 
1b4c : f0 23 __ BEQ $1b71 ; (faddsub + 90)
1b4e : a5 1d __ LDA ACCU + 2 
1b50 : 4a __ __ LSR
1b51 : 66 1c __ ROR ACCU + 1 
1b53 : 66 1b __ ROR ACCU + 0 
1b55 : e8 __ __ INX
1b56 : d0 f8 __ BNE $1b50 ; (faddsub + 57)
1b58 : 85 1d __ STA ACCU + 2 
1b5a : a5 08 __ LDA WORK + 5 
1b5c : 85 07 __ STA WORK + 4 
1b5e : 4c 71 1b JMP $1b71 ; (faddsub + 90)
1b61 : e0 18 __ CPX #$18
1b63 : b0 33 __ BCS $1b98 ; (faddsub + 129)
1b65 : a5 05 __ LDA WORK + 2 
1b67 : 4a __ __ LSR
1b68 : 66 04 __ ROR WORK + 1 
1b6a : 66 03 __ ROR WORK + 0 
1b6c : ca __ __ DEX
1b6d : d0 f8 __ BNE $1b67 ; (faddsub + 80)
1b6f : 85 05 __ STA WORK + 2 
1b71 : a5 1e __ LDA ACCU + 3 
1b73 : 29 80 __ AND #$80
1b75 : 85 1e __ STA ACCU + 3 
1b77 : 45 06 __ EOR WORK + 3 
1b79 : 30 31 __ BMI $1bac ; (faddsub + 149)
1b7b : 18 __ __ CLC
1b7c : a5 1b __ LDA ACCU + 0 
1b7e : 65 03 __ ADC WORK + 0 
1b80 : 85 1b __ STA ACCU + 0 
1b82 : a5 1c __ LDA ACCU + 1 
1b84 : 65 04 __ ADC WORK + 1 
1b86 : 85 1c __ STA ACCU + 1 
1b88 : a5 1d __ LDA ACCU + 2 
1b8a : 65 05 __ ADC WORK + 2 
1b8c : 85 1d __ STA ACCU + 2 
1b8e : 90 08 __ BCC $1b98 ; (faddsub + 129)
1b90 : 66 1d __ ROR ACCU + 2 
1b92 : 66 1c __ ROR ACCU + 1 
1b94 : 66 1b __ ROR ACCU + 0 
1b96 : e6 07 __ INC WORK + 4 
1b98 : a5 07 __ LDA WORK + 4 
1b9a : c9 ff __ CMP #$ff
1b9c : f0 83 __ BEQ $1b21 ; (faddsub + 10)
1b9e : 4a __ __ LSR
1b9f : 05 1e __ ORA ACCU + 3 
1ba1 : 85 1e __ STA ACCU + 3 
1ba3 : b0 06 __ BCS $1bab ; (faddsub + 148)
1ba5 : a5 1d __ LDA ACCU + 2 
1ba7 : 29 7f __ AND #$7f
1ba9 : 85 1d __ STA ACCU + 2 
1bab : 60 __ __ RTS
1bac : 38 __ __ SEC
1bad : a5 1b __ LDA ACCU + 0 
1baf : e5 03 __ SBC WORK + 0 
1bb1 : 85 1b __ STA ACCU + 0 
1bb3 : a5 1c __ LDA ACCU + 1 
1bb5 : e5 04 __ SBC WORK + 1 
1bb7 : 85 1c __ STA ACCU + 1 
1bb9 : a5 1d __ LDA ACCU + 2 
1bbb : e5 05 __ SBC WORK + 2 
1bbd : 85 1d __ STA ACCU + 2 
1bbf : b0 19 __ BCS $1bda ; (faddsub + 195)
1bc1 : 38 __ __ SEC
1bc2 : a9 00 __ LDA #$00
1bc4 : e5 1b __ SBC ACCU + 0 
1bc6 : 85 1b __ STA ACCU + 0 
1bc8 : a9 00 __ LDA #$00
1bca : e5 1c __ SBC ACCU + 1 
1bcc : 85 1c __ STA ACCU + 1 
1bce : a9 00 __ LDA #$00
1bd0 : e5 1d __ SBC ACCU + 2 
1bd2 : 85 1d __ STA ACCU + 2 
1bd4 : a5 1e __ LDA ACCU + 3 
1bd6 : 49 80 __ EOR #$80
1bd8 : 85 1e __ STA ACCU + 3 
1bda : a5 1d __ LDA ACCU + 2 
1bdc : 30 ba __ BMI $1b98 ; (faddsub + 129)
1bde : 05 1c __ ORA ACCU + 1 
1be0 : 05 1b __ ORA ACCU + 0 
1be2 : f0 0f __ BEQ $1bf3 ; (faddsub + 220)
1be4 : c6 07 __ DEC WORK + 4 
1be6 : f0 0b __ BEQ $1bf3 ; (faddsub + 220)
1be8 : 06 1b __ ASL ACCU + 0 
1bea : 26 1c __ ROL ACCU + 1 
1bec : 26 1d __ ROL ACCU + 2 
1bee : 10 f4 __ BPL $1be4 ; (faddsub + 205)
1bf0 : 4c 98 1b JMP $1b98 ; (faddsub + 129)
1bf3 : a9 00 __ LDA #$00
1bf5 : 85 1b __ STA ACCU + 0 
1bf7 : 85 1c __ STA ACCU + 1 
1bf9 : 85 1d __ STA ACCU + 2 
1bfb : 85 1e __ STA ACCU + 3 
1bfd : 60 __ __ RTS
--------------------------------------------------------------------
fmul:
1bfe : a5 1b __ LDA ACCU + 0 
1c00 : 05 1c __ ORA ACCU + 1 
1c02 : 05 1d __ ORA ACCU + 2 
1c04 : d0 03 __ BNE $1c09 ; (fmul + 11)
1c06 : 85 1e __ STA ACCU + 3 
1c08 : 60 __ __ RTS
1c09 : a5 03 __ LDA WORK + 0 
1c0b : 05 04 __ ORA WORK + 1 
1c0d : 05 05 __ ORA WORK + 2 
1c0f : d0 09 __ BNE $1c1a ; (fmul + 28)
1c11 : 85 1b __ STA ACCU + 0 
1c13 : 85 1c __ STA ACCU + 1 
1c15 : 85 1d __ STA ACCU + 2 
1c17 : 85 1e __ STA ACCU + 3 
1c19 : 60 __ __ RTS
1c1a : a5 1e __ LDA ACCU + 3 
1c1c : 45 06 __ EOR WORK + 3 
1c1e : 29 80 __ AND #$80
1c20 : 85 1e __ STA ACCU + 3 
1c22 : a9 ff __ LDA #$ff
1c24 : c5 07 __ CMP WORK + 4 
1c26 : f0 42 __ BEQ $1c6a ; (fmul + 108)
1c28 : c5 08 __ CMP WORK + 5 
1c2a : f0 3e __ BEQ $1c6a ; (fmul + 108)
1c2c : a9 00 __ LDA #$00
1c2e : 85 09 __ STA WORK + 6 
1c30 : 85 0a __ STA WORK + 7 
1c32 : 85 0b __ STA $0b 
1c34 : a4 1b __ LDY ACCU + 0 
1c36 : a5 03 __ LDA WORK + 0 
1c38 : d0 06 __ BNE $1c40 ; (fmul + 66)
1c3a : a5 04 __ LDA WORK + 1 
1c3c : f0 0a __ BEQ $1c48 ; (fmul + 74)
1c3e : d0 05 __ BNE $1c45 ; (fmul + 71)
1c40 : 20 9f 1c JSR $1c9f ; (fmul8 + 0)
1c43 : a5 04 __ LDA WORK + 1 
1c45 : 20 9f 1c JSR $1c9f ; (fmul8 + 0)
1c48 : a5 05 __ LDA WORK + 2 
1c4a : 20 9f 1c JSR $1c9f ; (fmul8 + 0)
1c4d : 38 __ __ SEC
1c4e : a5 0b __ LDA $0b 
1c50 : 30 06 __ BMI $1c58 ; (fmul + 90)
1c52 : 06 09 __ ASL WORK + 6 
1c54 : 26 0a __ ROL WORK + 7 
1c56 : 2a __ __ ROL
1c57 : 18 __ __ CLC
1c58 : 29 7f __ AND #$7f
1c5a : 85 0b __ STA $0b 
1c5c : a5 07 __ LDA WORK + 4 
1c5e : 65 08 __ ADC WORK + 5 
1c60 : 90 19 __ BCC $1c7b ; (fmul + 125)
1c62 : e9 7f __ SBC #$7f
1c64 : b0 04 __ BCS $1c6a ; (fmul + 108)
1c66 : c9 ff __ CMP #$ff
1c68 : d0 15 __ BNE $1c7f ; (fmul + 129)
1c6a : a5 1e __ LDA ACCU + 3 
1c6c : 09 7f __ ORA #$7f
1c6e : 85 1e __ STA ACCU + 3 
1c70 : a9 80 __ LDA #$80
1c72 : 85 1d __ STA ACCU + 2 
1c74 : a9 00 __ LDA #$00
1c76 : 85 1b __ STA ACCU + 0 
1c78 : 85 1c __ STA ACCU + 1 
1c7a : 60 __ __ RTS
1c7b : e9 7e __ SBC #$7e
1c7d : 90 15 __ BCC $1c94 ; (fmul + 150)
1c7f : 4a __ __ LSR
1c80 : 05 1e __ ORA ACCU + 3 
1c82 : 85 1e __ STA ACCU + 3 
1c84 : a9 00 __ LDA #$00
1c86 : 6a __ __ ROR
1c87 : 05 0b __ ORA $0b 
1c89 : 85 1d __ STA ACCU + 2 
1c8b : a5 0a __ LDA WORK + 7 
1c8d : 85 1c __ STA ACCU + 1 
1c8f : a5 09 __ LDA WORK + 6 
1c91 : 85 1b __ STA ACCU + 0 
1c93 : 60 __ __ RTS
1c94 : a9 00 __ LDA #$00
1c96 : 85 1b __ STA ACCU + 0 
1c98 : 85 1c __ STA ACCU + 1 
1c9a : 85 1d __ STA ACCU + 2 
1c9c : 85 1e __ STA ACCU + 3 
1c9e : 60 __ __ RTS
--------------------------------------------------------------------
fmul8:
1c9f : 38 __ __ SEC
1ca0 : 6a __ __ ROR
1ca1 : 90 1e __ BCC $1cc1 ; (fmul8 + 34)
1ca3 : aa __ __ TAX
1ca4 : 18 __ __ CLC
1ca5 : 98 __ __ TYA
1ca6 : 65 09 __ ADC WORK + 6 
1ca8 : 85 09 __ STA WORK + 6 
1caa : a5 0a __ LDA WORK + 7 
1cac : 65 1c __ ADC ACCU + 1 
1cae : 85 0a __ STA WORK + 7 
1cb0 : a5 0b __ LDA $0b 
1cb2 : 65 1d __ ADC ACCU + 2 
1cb4 : 6a __ __ ROR
1cb5 : 85 0b __ STA $0b 
1cb7 : 8a __ __ TXA
1cb8 : 66 0a __ ROR WORK + 7 
1cba : 66 09 __ ROR WORK + 6 
1cbc : 4a __ __ LSR
1cbd : f0 0d __ BEQ $1ccc ; (fmul8 + 45)
1cbf : b0 e2 __ BCS $1ca3 ; (fmul8 + 4)
1cc1 : 66 0b __ ROR $0b 
1cc3 : 66 0a __ ROR WORK + 7 
1cc5 : 66 09 __ ROR WORK + 6 
1cc7 : 4a __ __ LSR
1cc8 : 90 f7 __ BCC $1cc1 ; (fmul8 + 34)
1cca : d0 d7 __ BNE $1ca3 ; (fmul8 + 4)
1ccc : 60 __ __ RTS
--------------------------------------------------------------------
fdiv:
1ccd : a5 1b __ LDA ACCU + 0 
1ccf : 05 1c __ ORA ACCU + 1 
1cd1 : 05 1d __ ORA ACCU + 2 
1cd3 : d0 03 __ BNE $1cd8 ; (fdiv + 11)
1cd5 : 85 1e __ STA ACCU + 3 
1cd7 : 60 __ __ RTS
1cd8 : a5 1e __ LDA ACCU + 3 
1cda : 45 06 __ EOR WORK + 3 
1cdc : 29 80 __ AND #$80
1cde : 85 1e __ STA ACCU + 3 
1ce0 : a5 08 __ LDA WORK + 5 
1ce2 : f0 62 __ BEQ $1d46 ; (fdiv + 121)
1ce4 : a5 07 __ LDA WORK + 4 
1ce6 : c9 ff __ CMP #$ff
1ce8 : f0 5c __ BEQ $1d46 ; (fdiv + 121)
1cea : a9 00 __ LDA #$00
1cec : 85 09 __ STA WORK + 6 
1cee : 85 0a __ STA WORK + 7 
1cf0 : 85 0b __ STA $0b 
1cf2 : a2 18 __ LDX #$18
1cf4 : a5 1b __ LDA ACCU + 0 
1cf6 : c5 03 __ CMP WORK + 0 
1cf8 : a5 1c __ LDA ACCU + 1 
1cfa : e5 04 __ SBC WORK + 1 
1cfc : a5 1d __ LDA ACCU + 2 
1cfe : e5 05 __ SBC WORK + 2 
1d00 : 90 13 __ BCC $1d15 ; (fdiv + 72)
1d02 : a5 1b __ LDA ACCU + 0 
1d04 : e5 03 __ SBC WORK + 0 
1d06 : 85 1b __ STA ACCU + 0 
1d08 : a5 1c __ LDA ACCU + 1 
1d0a : e5 04 __ SBC WORK + 1 
1d0c : 85 1c __ STA ACCU + 1 
1d0e : a5 1d __ LDA ACCU + 2 
1d10 : e5 05 __ SBC WORK + 2 
1d12 : 85 1d __ STA ACCU + 2 
1d14 : 38 __ __ SEC
1d15 : 26 09 __ ROL WORK + 6 
1d17 : 26 0a __ ROL WORK + 7 
1d19 : 26 0b __ ROL $0b 
1d1b : ca __ __ DEX
1d1c : f0 0a __ BEQ $1d28 ; (fdiv + 91)
1d1e : 06 1b __ ASL ACCU + 0 
1d20 : 26 1c __ ROL ACCU + 1 
1d22 : 26 1d __ ROL ACCU + 2 
1d24 : b0 dc __ BCS $1d02 ; (fdiv + 53)
1d26 : 90 cc __ BCC $1cf4 ; (fdiv + 39)
1d28 : 38 __ __ SEC
1d29 : a5 0b __ LDA $0b 
1d2b : 30 06 __ BMI $1d33 ; (fdiv + 102)
1d2d : 06 09 __ ASL WORK + 6 
1d2f : 26 0a __ ROL WORK + 7 
1d31 : 2a __ __ ROL
1d32 : 18 __ __ CLC
1d33 : 29 7f __ AND #$7f
1d35 : 85 0b __ STA $0b 
1d37 : a5 07 __ LDA WORK + 4 
1d39 : e5 08 __ SBC WORK + 5 
1d3b : 90 1a __ BCC $1d57 ; (fdiv + 138)
1d3d : 18 __ __ CLC
1d3e : 69 7f __ ADC #$7f
1d40 : b0 04 __ BCS $1d46 ; (fdiv + 121)
1d42 : c9 ff __ CMP #$ff
1d44 : d0 15 __ BNE $1d5b ; (fdiv + 142)
1d46 : a5 1e __ LDA ACCU + 3 
1d48 : 09 7f __ ORA #$7f
1d4a : 85 1e __ STA ACCU + 3 
1d4c : a9 80 __ LDA #$80
1d4e : 85 1d __ STA ACCU + 2 
1d50 : a9 00 __ LDA #$00
1d52 : 85 1c __ STA ACCU + 1 
1d54 : 85 1b __ STA ACCU + 0 
1d56 : 60 __ __ RTS
1d57 : 69 7f __ ADC #$7f
1d59 : 90 15 __ BCC $1d70 ; (fdiv + 163)
1d5b : 4a __ __ LSR
1d5c : 05 1e __ ORA ACCU + 3 
1d5e : 85 1e __ STA ACCU + 3 
1d60 : a9 00 __ LDA #$00
1d62 : 6a __ __ ROR
1d63 : 05 0b __ ORA $0b 
1d65 : 85 1d __ STA ACCU + 2 
1d67 : a5 0a __ LDA WORK + 7 
1d69 : 85 1c __ STA ACCU + 1 
1d6b : a5 09 __ LDA WORK + 6 
1d6d : 85 1b __ STA ACCU + 0 
1d6f : 60 __ __ RTS
1d70 : a9 00 __ LDA #$00
1d72 : 85 1e __ STA ACCU + 3 
1d74 : 85 1d __ STA ACCU + 2 
1d76 : 85 1c __ STA ACCU + 1 
1d78 : 85 1b __ STA ACCU + 0 
1d7a : 60 __ __ RTS
--------------------------------------------------------------------
divs16:
1d7b : 24 1c __ BIT ACCU + 1 
1d7d : 10 0d __ BPL $1d8c ; (divs16 + 17)
1d7f : 20 99 1d JSR $1d99 ; (negaccu + 0)
1d82 : 24 04 __ BIT WORK + 1 
1d84 : 10 0d __ BPL $1d93 ; (divs16 + 24)
1d86 : 20 a7 1d JSR $1da7 ; (negtmp + 0)
1d89 : 4c b5 1d JMP $1db5 ; (divmod + 0)
1d8c : 24 04 __ BIT WORK + 1 
1d8e : 10 f9 __ BPL $1d89 ; (divs16 + 14)
1d90 : 20 a7 1d JSR $1da7 ; (negtmp + 0)
1d93 : 20 b5 1d JSR $1db5 ; (divmod + 0)
1d96 : 4c 99 1d JMP $1d99 ; (negaccu + 0)
--------------------------------------------------------------------
negaccu:
1d99 : 38 __ __ SEC
1d9a : a9 00 __ LDA #$00
1d9c : e5 1b __ SBC ACCU + 0 
1d9e : 85 1b __ STA ACCU + 0 
1da0 : a9 00 __ LDA #$00
1da2 : e5 1c __ SBC ACCU + 1 
1da4 : 85 1c __ STA ACCU + 1 
1da6 : 60 __ __ RTS
--------------------------------------------------------------------
negtmp:
1da7 : 38 __ __ SEC
1da8 : a9 00 __ LDA #$00
1daa : e5 03 __ SBC WORK + 0 
1dac : 85 03 __ STA WORK + 0 
1dae : a9 00 __ LDA #$00
1db0 : e5 04 __ SBC WORK + 1 
1db2 : 85 04 __ STA WORK + 1 
1db4 : 60 __ __ RTS
--------------------------------------------------------------------
divmod:
1db5 : a5 1c __ LDA ACCU + 1 
1db7 : d0 31 __ BNE $1dea ; (divmod + 53)
1db9 : a5 04 __ LDA WORK + 1 
1dbb : d0 1e __ BNE $1ddb ; (divmod + 38)
1dbd : 85 06 __ STA WORK + 3 
1dbf : a2 04 __ LDX #$04
1dc1 : 06 1b __ ASL ACCU + 0 
1dc3 : 2a __ __ ROL
1dc4 : c5 03 __ CMP WORK + 0 
1dc6 : 90 02 __ BCC $1dca ; (divmod + 21)
1dc8 : e5 03 __ SBC WORK + 0 
1dca : 26 1b __ ROL ACCU + 0 
1dcc : 2a __ __ ROL
1dcd : c5 03 __ CMP WORK + 0 
1dcf : 90 02 __ BCC $1dd3 ; (divmod + 30)
1dd1 : e5 03 __ SBC WORK + 0 
1dd3 : 26 1b __ ROL ACCU + 0 
1dd5 : ca __ __ DEX
1dd6 : d0 eb __ BNE $1dc3 ; (divmod + 14)
1dd8 : 85 05 __ STA WORK + 2 
1dda : 60 __ __ RTS
1ddb : a5 1b __ LDA ACCU + 0 
1ddd : 85 05 __ STA WORK + 2 
1ddf : a5 1c __ LDA ACCU + 1 
1de1 : 85 06 __ STA WORK + 3 
1de3 : a9 00 __ LDA #$00
1de5 : 85 1b __ STA ACCU + 0 
1de7 : 85 1c __ STA ACCU + 1 
1de9 : 60 __ __ RTS
1dea : a5 04 __ LDA WORK + 1 
1dec : d0 1f __ BNE $1e0d ; (divmod + 88)
1dee : a5 03 __ LDA WORK + 0 
1df0 : 30 1b __ BMI $1e0d ; (divmod + 88)
1df2 : a9 00 __ LDA #$00
1df4 : 85 06 __ STA WORK + 3 
1df6 : a2 10 __ LDX #$10
1df8 : 06 1b __ ASL ACCU + 0 
1dfa : 26 1c __ ROL ACCU + 1 
1dfc : 2a __ __ ROL
1dfd : c5 03 __ CMP WORK + 0 
1dff : 90 02 __ BCC $1e03 ; (divmod + 78)
1e01 : e5 03 __ SBC WORK + 0 
1e03 : 26 1b __ ROL ACCU + 0 
1e05 : 26 1c __ ROL ACCU + 1 
1e07 : ca __ __ DEX
1e08 : d0 f2 __ BNE $1dfc ; (divmod + 71)
1e0a : 85 05 __ STA WORK + 2 
1e0c : 60 __ __ RTS
1e0d : a9 00 __ LDA #$00
1e0f : 85 05 __ STA WORK + 2 
1e11 : 85 06 __ STA WORK + 3 
1e13 : 84 02 __ STY $02 
1e15 : a0 10 __ LDY #$10
1e17 : 18 __ __ CLC
1e18 : 26 1b __ ROL ACCU + 0 
1e1a : 26 1c __ ROL ACCU + 1 
1e1c : 26 05 __ ROL WORK + 2 
1e1e : 26 06 __ ROL WORK + 3 
1e20 : 38 __ __ SEC
1e21 : a5 05 __ LDA WORK + 2 
1e23 : e5 03 __ SBC WORK + 0 
1e25 : aa __ __ TAX
1e26 : a5 06 __ LDA WORK + 3 
1e28 : e5 04 __ SBC WORK + 1 
1e2a : 90 04 __ BCC $1e30 ; (divmod + 123)
1e2c : 86 05 __ STX WORK + 2 
1e2e : 85 06 __ STA WORK + 3 
1e30 : 88 __ __ DEY
1e31 : d0 e5 __ BNE $1e18 ; (divmod + 99)
1e33 : 26 1b __ ROL ACCU + 0 
1e35 : 26 1c __ ROL ACCU + 1 
1e37 : a4 02 __ LDY $02 
1e39 : 60 __ __ RTS
--------------------------------------------------------------------
mods16:
1e3a : 24 1c __ BIT ACCU + 1 
1e3c : 10 0d __ BPL $1e4b ; (mods16 + 17)
1e3e : 20 99 1d JSR $1d99 ; (negaccu + 0)
1e41 : 24 04 __ BIT WORK + 1 
1e43 : 10 0d __ BPL $1e52 ; (mods16 + 24)
1e45 : 20 a7 1d JSR $1da7 ; (negtmp + 0)
1e48 : 4c b5 1d JMP $1db5 ; (divmod + 0)
1e4b : 24 04 __ BIT WORK + 1 
1e4d : 10 f9 __ BPL $1e48 ; (mods16 + 14)
1e4f : 20 a7 1d JSR $1da7 ; (negtmp + 0)
1e52 : 20 b5 1d JSR $1db5 ; (divmod + 0)
1e55 : 38 __ __ SEC
1e56 : a9 00 __ LDA #$00
1e58 : e5 05 __ SBC WORK + 2 
1e5a : 85 05 __ STA WORK + 2 
1e5c : a9 00 __ LDA #$00
1e5e : e5 06 __ SBC WORK + 3 
1e60 : 85 06 __ STA WORK + 3 
1e62 : 60 __ __ RTS
--------------------------------------------------------------------
f32_to_i16:
1e63 : 20 f6 1a JSR $1af6 ; (freg + 36)
1e66 : a5 07 __ LDA WORK + 4 
1e68 : c9 7f __ CMP #$7f
1e6a : b0 07 __ BCS $1e73 ; (f32_to_i16 + 16)
1e6c : a9 00 __ LDA #$00
1e6e : 85 1b __ STA ACCU + 0 
1e70 : 85 1c __ STA ACCU + 1 
1e72 : 60 __ __ RTS
1e73 : 38 __ __ SEC
1e74 : e9 8e __ SBC #$8e
1e76 : 90 0a __ BCC $1e82 ; (f32_to_i16 + 31)
1e78 : a9 ff __ LDA #$ff
1e7a : 85 1b __ STA ACCU + 0 
1e7c : a9 7f __ LDA #$7f
1e7e : 85 1c __ STA ACCU + 1 
1e80 : d0 08 __ BNE $1e8a ; (f32_to_i16 + 39)
1e82 : aa __ __ TAX
1e83 : 46 1d __ LSR ACCU + 2 
1e85 : 66 1c __ ROR ACCU + 1 
1e87 : e8 __ __ INX
1e88 : d0 f9 __ BNE $1e83 ; (f32_to_i16 + 32)
1e8a : 24 1e __ BIT ACCU + 3 
1e8c : 10 0e __ BPL $1e9c ; (f32_to_i16 + 57)
1e8e : 38 __ __ SEC
1e8f : a9 00 __ LDA #$00
1e91 : e5 1c __ SBC ACCU + 1 
1e93 : 85 1b __ STA ACCU + 0 
1e95 : a9 00 __ LDA #$00
1e97 : e5 1d __ SBC ACCU + 2 
1e99 : 85 1c __ STA ACCU + 1 
1e9b : 60 __ __ RTS
1e9c : a5 1c __ LDA ACCU + 1 
1e9e : 85 1b __ STA ACCU + 0 
1ea0 : a5 1d __ LDA ACCU + 2 
1ea2 : 85 1c __ STA ACCU + 1 
1ea4 : 60 __ __ RTS
--------------------------------------------------------------------
sint16_to_float:
1ea5 : 24 1c __ BIT ACCU + 1 
1ea7 : 30 03 __ BMI $1eac ; (sint16_to_float + 7)
1ea9 : 4c c3 1e JMP $1ec3 ; (uint16_to_float + 0)
1eac : 38 __ __ SEC
1ead : a9 00 __ LDA #$00
1eaf : e5 1b __ SBC ACCU + 0 
1eb1 : 85 1b __ STA ACCU + 0 
1eb3 : a9 00 __ LDA #$00
1eb5 : e5 1c __ SBC ACCU + 1 
1eb7 : 85 1c __ STA ACCU + 1 
1eb9 : 20 c3 1e JSR $1ec3 ; (uint16_to_float + 0)
1ebc : a5 1e __ LDA ACCU + 3 
1ebe : 09 80 __ ORA #$80
1ec0 : 85 1e __ STA ACCU + 3 
1ec2 : 60 __ __ RTS
--------------------------------------------------------------------
uint16_to_float:
1ec3 : a5 1b __ LDA ACCU + 0 
1ec5 : 05 1c __ ORA ACCU + 1 
1ec7 : d0 05 __ BNE $1ece ; (uint16_to_float + 11)
1ec9 : 85 1d __ STA ACCU + 2 
1ecb : 85 1e __ STA ACCU + 3 
1ecd : 60 __ __ RTS
1ece : a2 8e __ LDX #$8e
1ed0 : a5 1c __ LDA ACCU + 1 
1ed2 : 30 06 __ BMI $1eda ; (uint16_to_float + 23)
1ed4 : ca __ __ DEX
1ed5 : 06 1b __ ASL ACCU + 0 
1ed7 : 2a __ __ ROL
1ed8 : 10 fa __ BPL $1ed4 ; (uint16_to_float + 17)
1eda : 29 7f __ AND #$7f
1edc : 85 1d __ STA ACCU + 2 
1ede : a5 1b __ LDA ACCU + 0 
1ee0 : 85 1c __ STA ACCU + 1 
1ee2 : 8a __ __ TXA
1ee3 : 4a __ __ LSR
1ee4 : 85 1e __ STA ACCU + 3 
1ee6 : a9 00 __ LDA #$00
1ee8 : 85 1b __ STA ACCU + 0 
1eea : 6a __ __ ROR
1eeb : 05 1d __ ORA ACCU + 2 
1eed : 85 1d __ STA ACCU + 2 
1eef : 60 __ __ RTS
--------------------------------------------------------------------
divmod32:
1ef0 : 84 02 __ STY $02 
1ef2 : a0 20 __ LDY #$20
1ef4 : a9 00 __ LDA #$00
1ef6 : 85 07 __ STA WORK + 4 
1ef8 : 85 08 __ STA WORK + 5 
1efa : 85 09 __ STA WORK + 6 
1efc : 85 0a __ STA WORK + 7 
1efe : a5 05 __ LDA WORK + 2 
1f00 : 05 06 __ ORA WORK + 3 
1f02 : d0 39 __ BNE $1f3d ; (divmod32 + 77)
1f04 : 18 __ __ CLC
1f05 : 26 1b __ ROL ACCU + 0 
1f07 : 26 1c __ ROL ACCU + 1 
1f09 : 26 1d __ ROL ACCU + 2 
1f0b : 26 1e __ ROL ACCU + 3 
1f0d : 26 07 __ ROL WORK + 4 
1f0f : 26 08 __ ROL WORK + 5 
1f11 : 90 0c __ BCC $1f1f ; (divmod32 + 47)
1f13 : a5 07 __ LDA WORK + 4 
1f15 : e5 03 __ SBC WORK + 0 
1f17 : aa __ __ TAX
1f18 : a5 08 __ LDA WORK + 5 
1f1a : e5 04 __ SBC WORK + 1 
1f1c : 38 __ __ SEC
1f1d : b0 0c __ BCS $1f2b ; (divmod32 + 59)
1f1f : 38 __ __ SEC
1f20 : a5 07 __ LDA WORK + 4 
1f22 : e5 03 __ SBC WORK + 0 
1f24 : aa __ __ TAX
1f25 : a5 08 __ LDA WORK + 5 
1f27 : e5 04 __ SBC WORK + 1 
1f29 : 90 04 __ BCC $1f2f ; (divmod32 + 63)
1f2b : 86 07 __ STX WORK + 4 
1f2d : 85 08 __ STA WORK + 5 
1f2f : 88 __ __ DEY
1f30 : d0 d3 __ BNE $1f05 ; (divmod32 + 21)
1f32 : 26 1b __ ROL ACCU + 0 
1f34 : 26 1c __ ROL ACCU + 1 
1f36 : 26 1d __ ROL ACCU + 2 
1f38 : 26 1e __ ROL ACCU + 3 
1f3a : a4 02 __ LDY $02 
1f3c : 60 __ __ RTS
1f3d : 18 __ __ CLC
1f3e : 26 1b __ ROL ACCU + 0 
1f40 : 26 1c __ ROL ACCU + 1 
1f42 : 26 1d __ ROL ACCU + 2 
1f44 : 26 1e __ ROL ACCU + 3 
1f46 : 26 07 __ ROL WORK + 4 
1f48 : 26 08 __ ROL WORK + 5 
1f4a : 26 09 __ ROL WORK + 6 
1f4c : 26 0a __ ROL WORK + 7 
1f4e : a5 07 __ LDA WORK + 4 
1f50 : c5 03 __ CMP WORK + 0 
1f52 : a5 08 __ LDA WORK + 5 
1f54 : e5 04 __ SBC WORK + 1 
1f56 : a5 09 __ LDA WORK + 6 
1f58 : e5 05 __ SBC WORK + 2 
1f5a : a5 0a __ LDA WORK + 7 
1f5c : e5 06 __ SBC WORK + 3 
1f5e : 90 18 __ BCC $1f78 ; (divmod32 + 136)
1f60 : a5 07 __ LDA WORK + 4 
1f62 : e5 03 __ SBC WORK + 0 
1f64 : 85 07 __ STA WORK + 4 
1f66 : a5 08 __ LDA WORK + 5 
1f68 : e5 04 __ SBC WORK + 1 
1f6a : 85 08 __ STA WORK + 5 
1f6c : a5 09 __ LDA WORK + 6 
1f6e : e5 05 __ SBC WORK + 2 
1f70 : 85 09 __ STA WORK + 6 
1f72 : a5 0a __ LDA WORK + 7 
1f74 : e5 06 __ SBC WORK + 3 
1f76 : 85 0a __ STA WORK + 7 
1f78 : 88 __ __ DEY
1f79 : d0 c3 __ BNE $1f3e ; (divmod32 + 78)
1f7b : 26 1b __ ROL ACCU + 0 
1f7d : 26 1c __ ROL ACCU + 1 
1f7f : 26 1d __ ROL ACCU + 2 
1f81 : 26 1e __ ROL ACCU + 3 
1f83 : a4 02 __ LDY $02 
1f85 : 60 __ __ RTS
--------------------------------------------------------------------
__multab3L:
1f86 : __ __ __ BYT 00 03 06 09 0c 0f 12 15 18 1b                   : ..........
