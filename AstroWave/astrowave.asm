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
080e : 8e 4b 21 STX $214b ; (spentry + 0)
0811 : a9 6b __ LDA #$6b
0813 : 85 19 __ STA IP + 0 
0815 : a9 21 __ LDA #$21
0817 : 85 1a __ STA IP + 1 
0819 : 38 __ __ SEC
081a : a9 21 __ LDA #$21
081c : e9 21 __ SBC #$21
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
0830 : a9 a8 __ LDA #$a8
0832 : e9 6b __ SBC #$6b
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
214b : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
main:
.s1000:
0880 : a5 53 __ LDA T0 + 0 
0882 : 8d 9e 9f STA $9f9e ; (main@stack + 0)
.s0:
0885 : 20 f7 08 JSR $08f7 ; (init_player.s0 + 0)
0888 : 20 02 09 JSR $0902 ; (init_enemies.s0 + 0)
088b : 20 17 09 JSR $0917 ; (init_shots.s0 + 0)
088e : 20 3e 09 JSR $093e ; (init_game_state.s0 + 0)
0891 : 20 50 09 JSR $0950 ; (init_game_screen.s0 + 0)
0894 : ad 9d 21 LDA $219d ; (game + 0)
0897 : d0 52 __ BNE $08eb ; (main.s4 + 0)
.s9:
0899 : 85 53 __ STA T0 + 0 
.l3:
089b : 20 62 09 JSR $0962 ; (render_game_state.s1000 + 0)
089e : a5 53 __ LDA T0 + 0 
08a0 : 85 1b __ STA ACCU + 0 
08a2 : a9 00 __ LDA #$00
08a4 : 85 1c __ STA ACCU + 1 
08a6 : 85 04 __ STA WORK + 1 
08a8 : a9 03 __ LDA #$03
08aa : 85 03 __ STA WORK + 0 
08ac : 20 70 1f JSR $1f70 ; (divmod + 0)
08af : a5 05 __ LDA WORK + 2 
08b1 : 05 06 __ ORA WORK + 3 
08b3 : d0 09 __ BNE $08be ; (main.s7 + 0)
.s5:
08b5 : 20 60 16 JSR $1660 ; (spawn_enemy.s0 + 0)
08b8 : 20 c5 16 JSR $16c5 ; (move_enemies.s1000 + 0)
08bb : 20 b9 18 JSR $18b9 ; (render_enemies.s0 + 0)
.s7:
08be : 20 0e 19 JSR $190e ; (move_enemy_shots.s0 + 0)
08c1 : 20 64 18 JSR $1864 ; (render_enemy_shots.s0 + 0)
08c4 : 20 78 19 JSR $1978 ; (check_player_enemy_collision.s0 + 0)
08c7 : 20 a0 19 JSR $19a0 ; (control_player_ship.s0 + 0)
08ca : 20 be 1a JSR $1abe ; (render_player_ship.s0 + 0)
08cd : 20 78 19 JSR $1978 ; (check_player_enemy_collision.s0 + 0)
08d0 : 20 fe 1a JSR $1afe ; (move_player_shots.s0 + 0)
08d3 : 20 66 1b JSR $1b66 ; (render_player_shots.s0 + 0)
08d6 : 20 bb 1b JSR $1bbb ; (check_shot_enemy_collision.s0 + 0)
08d9 : a9 03 __ LDA #$03
08db : 85 0d __ STA P0 
08dd : a9 00 __ LDA #$00
08df : 85 0e __ STA P1 
08e1 : 20 6c 1c JSR $1c6c ; (wait_frames.s0 + 0)
08e4 : e6 53 __ INC T0 + 0 
08e6 : ad 9d 21 LDA $219d ; (game + 0)
08e9 : f0 b0 __ BEQ $089b ; (main.l3 + 0)
.s4:
08eb : a9 00 __ LDA #$00
08ed : 85 1b __ STA ACCU + 0 
08ef : 85 1c __ STA ACCU + 1 
.s1001:
08f1 : ad 9e 9f LDA $9f9e ; (main@stack + 0)
08f4 : 85 53 __ STA T0 + 0 
08f6 : 60 __ __ RTS
--------------------------------------------------------------------
init_player:
.s0:
08f7 : a9 05 __ LDA #$05
08f9 : 8d 6b 21 STA $216b ; (Player + 0)
08fc : a9 0c __ LDA #$0c
08fe : 8d 6c 21 STA $216c ; (Player + 1)
.s1001:
0901 : 60 __ __ RTS
--------------------------------------------------------------------
Player:
216b : __ __ __ BSS	2
--------------------------------------------------------------------
init_enemies:
.s0:
0902 : a0 0a __ LDY #$0a
0904 : a2 00 __ LDX #$00
0906 : 8a __ __ TXA
.l1004:
0907 : 9d 6d 21 STA $216d,x ; (Enemy + 0)
090a : 9d 6e 21 STA $216e,x ; (Enemy + 1)
090d : 9d 6f 21 STA $216f,x ; (Enemy + 2)
0910 : e8 __ __ INX
0911 : e8 __ __ INX
0912 : e8 __ __ INX
0913 : 88 __ __ DEY
0914 : d0 f1 __ BNE $0907 ; (init_enemies.l1004 + 0)
.s1001:
0916 : 60 __ __ RTS
--------------------------------------------------------------------
Enemy:
216d : __ __ __ BSS	30
--------------------------------------------------------------------
init_shots:
.s0:
0917 : a2 00 __ LDX #$00
0919 : a0 03 __ LDY #$03
091b : 8a __ __ TXA
.l1006:
091c : 9d 8b 21 STA $218b,x ; (PlayerShot + 0)
091f : 9d 8c 21 STA $218c,x ; (PlayerShot + 1)
0922 : 9d 8d 21 STA $218d,x ; (PlayerShot + 2)
0925 : e8 __ __ INX
0926 : e8 __ __ INX
0927 : e8 __ __ INX
0928 : 88 __ __ DEY
0929 : d0 f1 __ BNE $091c ; (init_shots.l1006 + 0)
.s6:
092b : a0 03 __ LDY #$03
092d : aa __ __ TAX
.l1008:
092e : 9d 94 21 STA $2194,x ; (EnemyShot + 0)
0931 : 9d 95 21 STA $2195,x ; (EnemyShot + 1)
0934 : 9d 96 21 STA $2196,x ; (EnemyShot + 2)
0937 : e8 __ __ INX
0938 : e8 __ __ INX
0939 : e8 __ __ INX
093a : 88 __ __ DEY
093b : d0 f1 __ BNE $092e ; (init_shots.l1008 + 0)
.s1001:
093d : 60 __ __ RTS
--------------------------------------------------------------------
PlayerShot:
218b : __ __ __ BSS	9
--------------------------------------------------------------------
EnemyShot:
2194 : __ __ __ BSS	9
--------------------------------------------------------------------
init_game_state:
.s0:
093e : a9 00 __ LDA #$00
0940 : 8d 9d 21 STA $219d ; (game + 0)
0943 : 8d 9e 21 STA $219e ; (game + 1)
0946 : 8d 9f 21 STA $219f ; (game + 2)
0949 : 8d a0 21 STA $21a0 ; (game + 3)
094c : 8d a1 21 STA $21a1 ; (game + 4)
.s1001:
094f : 60 __ __ RTS
--------------------------------------------------------------------
game:
219d : __ __ __ BSS	5
--------------------------------------------------------------------
init_game_screen:
.s0:
0950 : 20 5e 09 JSR $095e ; (clrscr.s0 + 0)
0953 : a9 00 __ LDA #$00
0955 : 8d 21 d0 STA $d021 
0958 : a9 0b __ LDA #$0b
095a : 8d 20 d0 STA $d020 
.s1001:
095d : 60 __ __ RTS
--------------------------------------------------------------------
clrscr:
.s0:
095e : 20 81 ff JSR $ff81 
.s1001:
0961 : 60 __ __ RTS
--------------------------------------------------------------------
render_game_state:
.s1000:
0962 : 38 __ __ SEC
0963 : a5 23 __ LDA SP + 0 
0965 : e9 08 __ SBC #$08
0967 : 85 23 __ STA SP + 0 
0969 : b0 02 __ BCS $096d ; (render_game_state.s0 + 0)
096b : c6 24 __ DEC SP + 1 
.s0:
096d : a9 01 __ LDA #$01
096f : 85 0d __ STA P0 
0971 : 85 0f __ STA P2 
0973 : a9 00 __ LDA #$00
0975 : 85 0e __ STA P1 
0977 : 85 10 __ STA P3 
0979 : 20 ae 09 JSR $09ae ; (gotoxy.s0 + 0)
097c : a9 55 __ LDA #$55
097e : a0 02 __ LDY #$02
0980 : 91 23 __ STA (SP + 0),y 
0982 : a9 16 __ LDA #$16
0984 : c8 __ __ INY
0985 : 91 23 __ STA (SP + 0),y 
0987 : ad 9e 21 LDA $219e ; (game + 1)
098a : c8 __ __ INY
098b : 91 23 __ STA (SP + 0),y 
098d : ad 9f 21 LDA $219f ; (game + 2)
0990 : c8 __ __ INY
0991 : 91 23 __ STA (SP + 0),y 
0993 : ad a0 21 LDA $21a0 ; (game + 3)
0996 : c8 __ __ INY
0997 : 91 23 __ STA (SP + 0),y 
0999 : ad a1 21 LDA $21a1 ; (game + 4)
099c : c8 __ __ INY
099d : 91 23 __ STA (SP + 0),y 
099f : 20 b7 09 JSR $09b7 ; (printf.s0 + 0)
.s1001:
09a2 : 18 __ __ CLC
09a3 : a5 23 __ LDA SP + 0 
09a5 : 69 08 __ ADC #$08
09a7 : 85 23 __ STA SP + 0 
09a9 : 90 02 __ BCC $09ad ; (render_game_state.s1001 + 11)
09ab : e6 24 __ INC SP + 1 
09ad : 60 __ __ RTS
--------------------------------------------------------------------
gotoxy:
.s0:
09ae : a6 0f __ LDX P2 
09b0 : a4 0d __ LDY P0 
09b2 : 18 __ __ CLC
09b3 : 20 f0 ff JSR $fff0 
.s1001:
09b6 : 60 __ __ RTS
--------------------------------------------------------------------
printf:
.s0:
09b7 : a9 01 __ LDA #$01
09b9 : 8d fd 9f STA $9ffd ; (sstack + 7)
09bc : a9 a6 __ LDA #$a6
09be : 8d f7 9f STA $9ff7 ; (sstack + 1)
09c1 : a9 9f __ LDA #$9f
09c3 : 8d f8 9f STA $9ff8 ; (sstack + 2)
09c6 : a0 02 __ LDY #$02
09c8 : b1 23 __ LDA (SP + 0),y 
09ca : 8d f9 9f STA $9ff9 ; (sstack + 3)
09cd : c8 __ __ INY
09ce : b1 23 __ LDA (SP + 0),y 
09d0 : 8d fa 9f STA $9ffa ; (sstack + 4)
09d3 : 18 __ __ CLC
09d4 : a5 23 __ LDA SP + 0 
09d6 : 69 04 __ ADC #$04
09d8 : 8d fb 9f STA $9ffb ; (sstack + 5)
09db : a5 24 __ LDA SP + 1 
09dd : 69 00 __ ADC #$00
09df : 8d fc 9f STA $9ffc ; (sstack + 6)
09e2 : 4c e5 09 JMP $09e5 ; (sformat.s1000 + 0)
--------------------------------------------------------------------
sformat:
.s1000:
09e5 : a2 05 __ LDX #$05
09e7 : b5 53 __ LDA T1 + 0,x 
09e9 : 9d d8 9f STA $9fd8,x ; (sformat@stack + 0)
09ec : ca __ __ DEX
09ed : 10 f8 __ BPL $09e7 ; (sformat.s1000 + 2)
.s0:
09ef : a9 00 __ LDA #$00
09f1 : 85 50 __ STA T0 + 0 
09f3 : ad f9 9f LDA $9ff9 ; (sstack + 3)
09f6 : 85 53 __ STA T1 + 0 
09f8 : ad fa 9f LDA $9ffa ; (sstack + 4)
09fb : 85 54 __ STA T1 + 1 
09fd : ad f7 9f LDA $9ff7 ; (sstack + 1)
0a00 : 85 55 __ STA T2 + 0 
0a02 : ad f8 9f LDA $9ff8 ; (sstack + 2)
0a05 : 85 56 __ STA T2 + 1 
.l1:
0a07 : a0 00 __ LDY #$00
0a09 : b1 53 __ LDA (T1 + 0),y 
0a0b : d0 38 __ BNE $0a45 ; (sformat.s2 + 0)
.s3:
0a0d : a4 50 __ LDY T0 + 0 
0a0f : 91 55 __ STA (T2 + 0),y 
0a11 : 98 __ __ TYA
0a12 : f0 28 __ BEQ $0a3c ; (sformat.s1061 + 0)
.s112:
0a14 : ad fd 9f LDA $9ffd ; (sstack + 7)
0a17 : d0 18 __ BNE $0a31 ; (sformat.s115 + 0)
.s116:
0a19 : 18 __ __ CLC
0a1a : a5 55 __ LDA T2 + 0 
0a1c : 65 50 __ ADC T0 + 0 
0a1e : 85 1b __ STA ACCU + 0 ; (buff + 1)
0a20 : a5 56 __ LDA T2 + 1 
0a22 : 69 00 __ ADC #$00
.s1001:
0a24 : 85 1c __ STA ACCU + 1 ; (fmt + 0)
0a26 : a2 05 __ LDX #$05
0a28 : bd d8 9f LDA $9fd8,x ; (sformat@stack + 0)
0a2b : 95 53 __ STA T1 + 0,x 
0a2d : ca __ __ DEX
0a2e : 10 f8 __ BPL $0a28 ; (sformat.s1001 + 4)
0a30 : 60 __ __ RTS
.s115:
0a31 : a5 55 __ LDA T2 + 0 
0a33 : 85 0d __ STA P0 
0a35 : a5 56 __ LDA T2 + 1 
0a37 : 85 0e __ STA P1 
0a39 : 20 29 0e JSR $0e29 ; (puts.s0 + 0)
.s1061:
0a3c : a5 55 __ LDA T2 + 0 
0a3e : 85 1b __ STA ACCU + 0 ; (buff + 1)
0a40 : a5 56 __ LDA T2 + 1 
0a42 : 4c 24 0a JMP $0a24 ; (sformat.s1001 + 0)
.s2:
0a45 : c9 25 __ CMP #$25
0a47 : f0 3f __ BEQ $0a88 ; (sformat.s4 + 0)
.s5:
0a49 : a4 50 __ LDY T0 + 0 
0a4b : 91 55 __ STA (T2 + 0),y 
0a4d : e6 53 __ INC T1 + 0 
0a4f : d0 02 __ BNE $0a53 ; (sformat.s1090 + 0)
.s1089:
0a51 : e6 54 __ INC T1 + 1 
.s1090:
0a53 : c8 __ __ INY
0a54 : 84 50 __ STY T0 + 0 
0a56 : 98 __ __ TYA
0a57 : c0 28 __ CPY #$28
0a59 : 90 ac __ BCC $0a07 ; (sformat.l1 + 0)
.s106:
0a5b : 85 57 __ STA T5 + 0 
0a5d : a9 00 __ LDA #$00
0a5f : 85 50 __ STA T0 + 0 
0a61 : ad fd 9f LDA $9ffd ; (sstack + 7)
0a64 : f0 14 __ BEQ $0a7a ; (sformat.s110 + 0)
.s109:
0a66 : a5 55 __ LDA T2 + 0 
0a68 : 85 0d __ STA P0 
0a6a : a5 56 __ LDA T2 + 1 
0a6c : 85 0e __ STA P1 
0a6e : a9 00 __ LDA #$00
0a70 : a4 57 __ LDY T5 + 0 
0a72 : 91 0d __ STA (P0),y 
0a74 : 20 29 0e JSR $0e29 ; (puts.s0 + 0)
0a77 : 4c 07 0a JMP $0a07 ; (sformat.l1 + 0)
.s110:
0a7a : 18 __ __ CLC
0a7b : a5 55 __ LDA T2 + 0 
0a7d : 65 57 __ ADC T5 + 0 
0a7f : 85 55 __ STA T2 + 0 
0a81 : 90 84 __ BCC $0a07 ; (sformat.l1 + 0)
.s1092:
0a83 : e6 56 __ INC T2 + 1 
0a85 : 4c 07 0a JMP $0a07 ; (sformat.l1 + 0)
.s4:
0a88 : a5 50 __ LDA T0 + 0 
0a8a : f0 27 __ BEQ $0ab3 ; (sformat.s9 + 0)
.s7:
0a8c : 84 50 __ STY T0 + 0 
0a8e : 85 57 __ STA T5 + 0 
0a90 : ad fd 9f LDA $9ffd ; (sstack + 7)
0a93 : f0 13 __ BEQ $0aa8 ; (sformat.s11 + 0)
.s10:
0a95 : a5 55 __ LDA T2 + 0 
0a97 : 85 0d __ STA P0 
0a99 : a5 56 __ LDA T2 + 1 
0a9b : 85 0e __ STA P1 
0a9d : 98 __ __ TYA
0a9e : a4 57 __ LDY T5 + 0 
0aa0 : 91 0d __ STA (P0),y 
0aa2 : 20 29 0e JSR $0e29 ; (puts.s0 + 0)
0aa5 : 4c b3 0a JMP $0ab3 ; (sformat.s9 + 0)
.s11:
0aa8 : 18 __ __ CLC
0aa9 : a5 55 __ LDA T2 + 0 
0aab : 65 57 __ ADC T5 + 0 
0aad : 85 55 __ STA T2 + 0 
0aaf : 90 02 __ BCC $0ab3 ; (sformat.s9 + 0)
.s1087:
0ab1 : e6 56 __ INC T2 + 1 
.s9:
0ab3 : a9 0a __ LDA #$0a
0ab5 : 8d e1 9f STA $9fe1 ; (si + 3)
0ab8 : a9 00 __ LDA #$00
0aba : 8d e2 9f STA $9fe2 ; (si + 4)
0abd : 8d e3 9f STA $9fe3 ; (si + 5)
0ac0 : 8d e4 9f STA $9fe4 ; (si + 6)
0ac3 : 8d e5 9f STA $9fe5 ; (si + 7)
0ac6 : a0 01 __ LDY #$01
0ac8 : b1 53 __ LDA (T1 + 0),y 
0aca : aa __ __ TAX
0acb : a9 20 __ LDA #$20
0acd : 8d de 9f STA $9fde ; (si + 0)
0ad0 : a9 00 __ LDA #$00
0ad2 : 8d df 9f STA $9fdf ; (si + 1)
0ad5 : a9 ff __ LDA #$ff
0ad7 : 8d e0 9f STA $9fe0 ; (si + 2)
0ada : 18 __ __ CLC
0adb : a5 53 __ LDA T1 + 0 
0add : 69 02 __ ADC #$02
.l14:
0adf : 85 53 __ STA T1 + 0 
0ae1 : 90 02 __ BCC $0ae5 ; (sformat.s1074 + 0)
.s1073:
0ae3 : e6 54 __ INC T1 + 1 
.s1074:
0ae5 : 8a __ __ TXA
0ae6 : e0 2b __ CPX #$2b
0ae8 : d0 08 __ BNE $0af2 ; (sformat.s17 + 0)
.s16:
0aea : a9 01 __ LDA #$01
0aec : 8d e3 9f STA $9fe3 ; (si + 5)
0aef : 4c 1c 0e JMP $0e1c ; (sformat.s224 + 0)
.s17:
0af2 : c9 30 __ CMP #$30
0af4 : d0 06 __ BNE $0afc ; (sformat.s20 + 0)
.s19:
0af6 : 8d de 9f STA $9fde ; (si + 0)
0af9 : 4c 1c 0e JMP $0e1c ; (sformat.s224 + 0)
.s20:
0afc : e0 23 __ CPX #$23
0afe : d0 08 __ BNE $0b08 ; (sformat.s23 + 0)
.s22:
0b00 : a9 01 __ LDA #$01
0b02 : 8d e5 9f STA $9fe5 ; (si + 7)
0b05 : 4c 1c 0e JMP $0e1c ; (sformat.s224 + 0)
.s23:
0b08 : e0 2d __ CPX #$2d
0b0a : d0 08 __ BNE $0b14 ; (sformat.s15 + 0)
.s25:
0b0c : a9 01 __ LDA #$01
0b0e : 8d e4 9f STA $9fe4 ; (si + 6)
0b11 : 4c 1c 0e JMP $0e1c ; (sformat.s224 + 0)
.s15:
0b14 : 86 57 __ STX T5 + 0 
0b16 : e0 30 __ CPX #$30
0b18 : 90 53 __ BCC $0b6d ; (sformat.s31 + 0)
.s32:
0b1a : e0 3a __ CPX #$3a
0b1c : b0 4f __ BCS $0b6d ; (sformat.s31 + 0)
.s29:
0b1e : a9 00 __ LDA #$00
0b20 : 85 44 __ STA T6 + 0 
0b22 : 85 45 __ STA T6 + 1 
0b24 : e0 3a __ CPX #$3a
0b26 : b0 40 __ BCS $0b68 ; (sformat.s35 + 0)
.l34:
0b28 : a5 44 __ LDA T6 + 0 
0b2a : 0a __ __ ASL
0b2b : 85 1b __ STA ACCU + 0 ; (buff + 1)
0b2d : a5 45 __ LDA T6 + 1 
0b2f : 2a __ __ ROL
0b30 : 06 1b __ ASL ACCU + 0 ; (buff + 1)
0b32 : 2a __ __ ROL
0b33 : aa __ __ TAX
0b34 : 18 __ __ CLC
0b35 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0b37 : 65 44 __ ADC T6 + 0 
0b39 : 85 44 __ STA T6 + 0 
0b3b : 8a __ __ TXA
0b3c : 65 45 __ ADC T6 + 1 
0b3e : 06 44 __ ASL T6 + 0 
0b40 : 2a __ __ ROL
0b41 : aa __ __ TAX
0b42 : 18 __ __ CLC
0b43 : a5 44 __ LDA T6 + 0 
0b45 : 65 57 __ ADC T5 + 0 
0b47 : 90 01 __ BCC $0b4a ; (sformat.s1084 + 0)
.s1083:
0b49 : e8 __ __ INX
.s1084:
0b4a : 38 __ __ SEC
0b4b : e9 30 __ SBC #$30
0b4d : 85 44 __ STA T6 + 0 
0b4f : 8a __ __ TXA
0b50 : e9 00 __ SBC #$00
0b52 : 85 45 __ STA T6 + 1 
0b54 : a0 00 __ LDY #$00
0b56 : b1 53 __ LDA (T1 + 0),y 
0b58 : 85 57 __ STA T5 + 0 
0b5a : e6 53 __ INC T1 + 0 
0b5c : d0 02 __ BNE $0b60 ; (sformat.s1086 + 0)
.s1085:
0b5e : e6 54 __ INC T1 + 1 
.s1086:
0b60 : c9 30 __ CMP #$30
0b62 : 90 04 __ BCC $0b68 ; (sformat.s35 + 0)
.s36:
0b64 : c9 3a __ CMP #$3a
0b66 : 90 c0 __ BCC $0b28 ; (sformat.l34 + 0)
.s35:
0b68 : a5 44 __ LDA T6 + 0 
0b6a : 8d df 9f STA $9fdf ; (si + 1)
.s31:
0b6d : a5 57 __ LDA T5 + 0 
0b6f : c9 2e __ CMP #$2e
0b71 : d0 51 __ BNE $0bc4 ; (sformat.s39 + 0)
.s37:
0b73 : a9 00 __ LDA #$00
0b75 : 85 44 __ STA T6 + 0 
.l203:
0b77 : 85 45 __ STA T6 + 1 
0b79 : a0 00 __ LDY #$00
0b7b : b1 53 __ LDA (T1 + 0),y 
0b7d : 85 57 __ STA T5 + 0 
0b7f : e6 53 __ INC T1 + 0 
0b81 : d0 02 __ BNE $0b85 ; (sformat.s1076 + 0)
.s1075:
0b83 : e6 54 __ INC T1 + 1 
.s1076:
0b85 : c9 30 __ CMP #$30
0b87 : 90 04 __ BCC $0b8d ; (sformat.s42 + 0)
.s43:
0b89 : c9 3a __ CMP #$3a
0b8b : 90 0a __ BCC $0b97 ; (sformat.s41 + 0)
.s42:
0b8d : a5 44 __ LDA T6 + 0 
0b8f : 8d e0 9f STA $9fe0 ; (si + 2)
0b92 : a5 57 __ LDA T5 + 0 
0b94 : 4c c4 0b JMP $0bc4 ; (sformat.s39 + 0)
.s41:
0b97 : a5 44 __ LDA T6 + 0 
0b99 : 0a __ __ ASL
0b9a : 85 1b __ STA ACCU + 0 ; (buff + 1)
0b9c : a5 45 __ LDA T6 + 1 
0b9e : 2a __ __ ROL
0b9f : 06 1b __ ASL ACCU + 0 ; (buff + 1)
0ba1 : 2a __ __ ROL
0ba2 : aa __ __ TAX
0ba3 : 18 __ __ CLC
0ba4 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0ba6 : 65 44 __ ADC T6 + 0 
0ba8 : 85 44 __ STA T6 + 0 
0baa : 8a __ __ TXA
0bab : 65 45 __ ADC T6 + 1 
0bad : 06 44 __ ASL T6 + 0 
0baf : 2a __ __ ROL
0bb0 : aa __ __ TAX
0bb1 : 18 __ __ CLC
0bb2 : a5 44 __ LDA T6 + 0 
0bb4 : 65 57 __ ADC T5 + 0 
0bb6 : 90 01 __ BCC $0bb9 ; (sformat.s1082 + 0)
.s1081:
0bb8 : e8 __ __ INX
.s1082:
0bb9 : 38 __ __ SEC
0bba : e9 30 __ SBC #$30
0bbc : 85 44 __ STA T6 + 0 
0bbe : 8a __ __ TXA
0bbf : e9 00 __ SBC #$00
0bc1 : 4c 77 0b JMP $0b77 ; (sformat.l203 + 0)
.s39:
0bc4 : c9 64 __ CMP #$64
0bc6 : d0 05 __ BNE $0bcd ; (sformat.s45 + 0)
.s44:
0bc8 : a9 01 __ LDA #$01
0bca : 4c e0 0d JMP $0de0 ; (sformat.s221 + 0)
.s45:
0bcd : c9 75 __ CMP #$75
0bcf : d0 03 __ BNE $0bd4 ; (sformat.s48 + 0)
0bd1 : 4c de 0d JMP $0dde ; (sformat.s250 + 0)
.s48:
0bd4 : c9 78 __ CMP #$78
0bd6 : d0 0d __ BNE $0be5 ; (sformat.s51 + 0)
.s50:
0bd8 : a9 10 __ LDA #$10
0bda : 8d e1 9f STA $9fe1 ; (si + 3)
0bdd : a9 00 __ LDA #$00
0bdf : 8d e2 9f STA $9fe2 ; (si + 4)
0be2 : 4c de 0d JMP $0dde ; (sformat.s250 + 0)
.s51:
0be5 : c9 6c __ CMP #$6c
0be7 : d0 03 __ BNE $0bec ; (sformat.s54 + 0)
0be9 : 4c 59 0d JMP $0d59 ; (sformat.s53 + 0)
.s54:
0bec : c9 66 __ CMP #$66
0bee : f0 08 __ BEQ $0bf8 ; (sformat.s65 + 0)
.s69:
0bf0 : c9 67 __ CMP #$67
0bf2 : f0 04 __ BEQ $0bf8 ; (sformat.s65 + 0)
.s68:
0bf4 : c9 65 __ CMP #$65
0bf6 : d0 4d __ BNE $0c45 ; (sformat.s66 + 0)
.s65:
0bf8 : a5 55 __ LDA T2 + 0 
0bfa : 85 13 __ STA P6 
0bfc : a5 56 __ LDA T2 + 1 
0bfe : 85 14 __ STA P7 
0c00 : a5 57 __ LDA T5 + 0 
0c02 : 8d f6 9f STA $9ff6 ; (sstack + 0)
0c05 : a9 de __ LDA #$de
0c07 : 85 11 __ STA P4 
0c09 : a9 9f __ LDA #$9f
0c0b : 85 12 __ STA P5 
0c0d : ad fb 9f LDA $9ffb ; (sstack + 5)
0c10 : 85 57 __ STA T5 + 0 
0c12 : ad fc 9f LDA $9ffc ; (sstack + 6)
0c15 : 85 58 __ STA T5 + 1 
0c17 : a0 00 __ LDY #$00
0c19 : b1 57 __ LDA (T5 + 0),y 
0c1b : 85 15 __ STA P8 
0c1d : c8 __ __ INY
0c1e : b1 57 __ LDA (T5 + 0),y 
0c20 : 85 16 __ STA P9 
0c22 : c8 __ __ INY
0c23 : b1 57 __ LDA (T5 + 0),y 
0c25 : 85 17 __ STA P10 
0c27 : c8 __ __ INY
0c28 : b1 57 __ LDA (T5 + 0),y 
0c2a : 85 18 __ STA P11 
0c2c : 20 75 11 JSR $1175 ; (nformf.s0 + 0)
0c2f : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0c31 : 85 50 __ STA T0 + 0 
0c33 : 18 __ __ CLC
0c34 : a5 57 __ LDA T5 + 0 
0c36 : 69 04 __ ADC #$04
0c38 : 8d fb 9f STA $9ffb ; (sstack + 5)
0c3b : a5 58 __ LDA T5 + 1 
0c3d : 69 00 __ ADC #$00
0c3f : 8d fc 9f STA $9ffc ; (sstack + 6)
0c42 : 4c 07 0a JMP $0a07 ; (sformat.l1 + 0)
.s66:
0c45 : c9 73 __ CMP #$73
0c47 : f0 4c __ BEQ $0c95 ; (sformat.s70 + 0)
.s71:
0c49 : c9 63 __ CMP #$63
0c4b : f0 1f __ BEQ $0c6c ; (sformat.s100 + 0)
.s101:
0c4d : 09 00 __ ORA #$00
0c4f : d0 03 __ BNE $0c54 ; (sformat.s103 + 0)
0c51 : 4c 07 0a JMP $0a07 ; (sformat.l1 + 0)
.s103:
0c54 : 18 __ __ CLC
0c55 : a5 55 __ LDA T2 + 0 
0c57 : 65 50 __ ADC T0 + 0 
0c59 : 85 44 __ STA T6 + 0 
0c5b : a5 56 __ LDA T2 + 1 
0c5d : 69 00 __ ADC #$00
0c5f : 85 45 __ STA T6 + 1 
0c61 : a5 57 __ LDA T5 + 0 
.s1059:
0c63 : a0 00 __ LDY #$00
0c65 : 91 44 __ STA (T6 + 0),y 
0c67 : e6 50 __ INC T0 + 0 
0c69 : 4c 07 0a JMP $0a07 ; (sformat.l1 + 0)
.s100:
0c6c : ad fb 9f LDA $9ffb ; (sstack + 5)
0c6f : 85 57 __ STA T5 + 0 
0c71 : 18 __ __ CLC
0c72 : 69 02 __ ADC #$02
0c74 : 8d fb 9f STA $9ffb ; (sstack + 5)
0c77 : ad fc 9f LDA $9ffc ; (sstack + 6)
0c7a : 85 58 __ STA T5 + 1 
0c7c : 69 00 __ ADC #$00
0c7e : 8d fc 9f STA $9ffc ; (sstack + 6)
0c81 : 18 __ __ CLC
0c82 : a5 55 __ LDA T2 + 0 
0c84 : 65 50 __ ADC T0 + 0 
0c86 : 85 44 __ STA T6 + 0 
0c88 : a5 56 __ LDA T2 + 1 
0c8a : 69 00 __ ADC #$00
0c8c : 85 45 __ STA T6 + 1 
0c8e : a0 00 __ LDY #$00
0c90 : b1 57 __ LDA (T5 + 0),y 
0c92 : 4c 63 0c JMP $0c63 ; (sformat.s1059 + 0)
.s70:
0c95 : ad fb 9f LDA $9ffb ; (sstack + 5)
0c98 : 85 57 __ STA T5 + 0 
0c9a : 18 __ __ CLC
0c9b : 69 02 __ ADC #$02
0c9d : 8d fb 9f STA $9ffb ; (sstack + 5)
0ca0 : ad fc 9f LDA $9ffc ; (sstack + 6)
0ca3 : 85 58 __ STA T5 + 1 
0ca5 : 69 00 __ ADC #$00
0ca7 : 8d fc 9f STA $9ffc ; (sstack + 6)
0caa : a0 00 __ LDY #$00
0cac : b1 57 __ LDA (T5 + 0),y 
0cae : aa __ __ TAX
0caf : c8 __ __ INY
0cb0 : b1 57 __ LDA (T5 + 0),y 
0cb2 : 86 57 __ STX T5 + 0 
0cb4 : 85 58 __ STA T5 + 1 
0cb6 : a9 00 __ LDA #$00
0cb8 : 85 52 __ STA T3 + 0 
0cba : ad df 9f LDA $9fdf ; (si + 1)
0cbd : f0 0c __ BEQ $0ccb ; (sformat.s75 + 0)
.s1065:
0cbf : 88 __ __ DEY
0cc0 : b1 57 __ LDA (T5 + 0),y 
0cc2 : f0 05 __ BEQ $0cc9 ; (sformat.s1066 + 0)
.l77:
0cc4 : c8 __ __ INY
0cc5 : b1 57 __ LDA (T5 + 0),y 
0cc7 : d0 fb __ BNE $0cc4 ; (sformat.l77 + 0)
.s1066:
0cc9 : 84 52 __ STY T3 + 0 
.s75:
0ccb : ad e4 9f LDA $9fe4 ; (si + 6)
0cce : d0 19 __ BNE $0ce9 ; (sformat.s81 + 0)
.s1069:
0cd0 : a6 52 __ LDX T3 + 0 
0cd2 : ec df 9f CPX $9fdf ; (si + 1)
0cd5 : a4 50 __ LDY T0 + 0 
0cd7 : b0 0c __ BCS $0ce5 ; (sformat.s1070 + 0)
.l83:
0cd9 : ad de 9f LDA $9fde ; (si + 0)
0cdc : 91 55 __ STA (T2 + 0),y 
0cde : e8 __ __ INX
0cdf : ec df 9f CPX $9fdf ; (si + 1)
0ce2 : c8 __ __ INY
0ce3 : 90 f4 __ BCC $0cd9 ; (sformat.l83 + 0)
.s1070:
0ce5 : 86 52 __ STX T3 + 0 
0ce7 : 84 50 __ STY T0 + 0 
.s81:
0ce9 : ad fd 9f LDA $9ffd ; (sstack + 7)
0cec : d0 37 __ BNE $0d25 ; (sformat.s85 + 0)
.l91:
0cee : a0 00 __ LDY #$00
0cf0 : b1 57 __ LDA (T5 + 0),y 
0cf2 : f0 0f __ BEQ $0d03 ; (sformat.s211 + 0)
.s92:
0cf4 : a4 50 __ LDY T0 + 0 
0cf6 : 91 55 __ STA (T2 + 0),y 
0cf8 : e6 50 __ INC T0 + 0 
0cfa : e6 57 __ INC T5 + 0 
0cfc : d0 f0 __ BNE $0cee ; (sformat.l91 + 0)
.s1079:
0cfe : e6 58 __ INC T5 + 1 
0d00 : 4c ee 0c JMP $0cee ; (sformat.l91 + 0)
.s211:
0d03 : ad e4 9f LDA $9fe4 ; (si + 6)
0d06 : d0 03 __ BNE $0d0b ; (sformat.s1067 + 0)
0d08 : 4c 07 0a JMP $0a07 ; (sformat.l1 + 0)
.s1067:
0d0b : a6 52 __ LDX T3 + 0 
0d0d : ec df 9f CPX $9fdf ; (si + 1)
0d10 : a4 50 __ LDY T0 + 0 
0d12 : b0 0c __ BCS $0d20 ; (sformat.s1068 + 0)
.l98:
0d14 : ad de 9f LDA $9fde ; (si + 0)
0d17 : 91 55 __ STA (T2 + 0),y 
0d19 : e8 __ __ INX
0d1a : ec df 9f CPX $9fdf ; (si + 1)
0d1d : c8 __ __ INY
0d1e : 90 f4 __ BCC $0d14 ; (sformat.l98 + 0)
.s1068:
0d20 : 84 50 __ STY T0 + 0 
0d22 : 4c 07 0a JMP $0a07 ; (sformat.l1 + 0)
.s85:
0d25 : a5 50 __ LDA T0 + 0 
0d27 : f0 22 __ BEQ $0d4b ; (sformat.s90 + 0)
.s88:
0d29 : a5 55 __ LDA T2 + 0 
0d2b : 85 0d __ STA P0 
0d2d : a5 56 __ LDA T2 + 1 
0d2f : 85 0e __ STA P1 
0d31 : a9 00 __ LDA #$00
0d33 : a4 50 __ LDY T0 + 0 
0d35 : 91 0d __ STA (P0),y 
0d37 : 20 29 0e JSR $0e29 ; (puts.s0 + 0)
0d3a : a5 57 __ LDA T5 + 0 
0d3c : 85 0d __ STA P0 
0d3e : a5 58 __ LDA T5 + 1 
0d40 : 85 0e __ STA P1 
0d42 : 20 29 0e JSR $0e29 ; (puts.s0 + 0)
0d45 : a9 00 __ LDA #$00
0d47 : 85 50 __ STA T0 + 0 
0d49 : f0 b8 __ BEQ $0d03 ; (sformat.s211 + 0)
.s90:
0d4b : a5 57 __ LDA T5 + 0 
0d4d : 85 0d __ STA P0 
0d4f : a5 58 __ LDA T5 + 1 
0d51 : 85 0e __ STA P1 
0d53 : 20 29 0e JSR $0e29 ; (puts.s0 + 0)
0d56 : 4c 03 0d JMP $0d03 ; (sformat.s211 + 0)
.s53:
0d59 : ad fb 9f LDA $9ffb ; (sstack + 5)
0d5c : 85 57 __ STA T5 + 0 
0d5e : 18 __ __ CLC
0d5f : 69 04 __ ADC #$04
0d61 : 8d fb 9f STA $9ffb ; (sstack + 5)
0d64 : ad fc 9f LDA $9ffc ; (sstack + 6)
0d67 : 85 58 __ STA T5 + 1 
0d69 : 69 00 __ ADC #$00
0d6b : 8d fc 9f STA $9ffc ; (sstack + 6)
0d6e : a0 00 __ LDY #$00
0d70 : b1 53 __ LDA (T1 + 0),y 
0d72 : 85 52 __ STA T3 + 0 
0d74 : e6 53 __ INC T1 + 0 
0d76 : d0 02 __ BNE $0d7a ; (sformat.s1078 + 0)
.s1077:
0d78 : e6 54 __ INC T1 + 1 
.s1078:
0d7a : c9 64 __ CMP #$64
0d7c : d0 04 __ BNE $0d82 ; (sformat.s1019 + 0)
.s1018:
0d7e : a2 01 __ LDX #$01
0d80 : d0 02 __ BNE $0d84 ; (sformat.s1020 + 0)
.s1019:
0d82 : a2 00 __ LDX #$00
.s1020:
0d84 : b1 57 __ LDA (T5 + 0),y 
0d86 : 85 46 __ STA T7 + 0 
0d88 : a0 01 __ LDY #$01
0d8a : b1 57 __ LDA (T5 + 0),y 
0d8c : 85 47 __ STA T7 + 1 
0d8e : c8 __ __ INY
0d8f : b1 57 __ LDA (T5 + 0),y 
0d91 : 85 48 __ STA T7 + 2 
0d93 : c8 __ __ INY
0d94 : b1 57 __ LDA (T5 + 0),y 
0d96 : a8 __ __ TAY
0d97 : 8a __ __ TXA
0d98 : f0 04 __ BEQ $0d9e ; (sformat.s57 + 0)
.s56:
0d9a : a9 01 __ LDA #$01
0d9c : d0 16 __ BNE $0db4 ; (sformat.s222 + 0)
.s57:
0d9e : a5 52 __ LDA T3 + 0 
0da0 : c9 75 __ CMP #$75
0da2 : f0 0f __ BEQ $0db3 ; (sformat.s251 + 0)
.s60:
0da4 : c9 78 __ CMP #$78
0da6 : f0 03 __ BEQ $0dab ; (sformat.s62 + 0)
0da8 : 4c 07 0a JMP $0a07 ; (sformat.l1 + 0)
.s62:
0dab : 8e e2 9f STX $9fe2 ; (si + 4)
0dae : a9 10 __ LDA #$10
0db0 : 8d e1 9f STA $9fe1 ; (si + 3)
.s251:
0db3 : 8a __ __ TXA
.s222:
0db4 : 84 14 __ STY P7 
0db6 : 85 15 __ STA P8 
0db8 : a5 55 __ LDA T2 + 0 
0dba : 85 0f __ STA P2 
0dbc : a5 56 __ LDA T2 + 1 
0dbe : 85 10 __ STA P3 
0dc0 : a5 46 __ LDA T7 + 0 
0dc2 : 85 11 __ STA P4 
0dc4 : a5 47 __ LDA T7 + 1 
0dc6 : 85 12 __ STA P5 
0dc8 : a5 48 __ LDA T7 + 2 
0dca : 85 13 __ STA P6 
0dcc : a9 de __ LDA #$de
0dce : 85 0d __ STA P0 
0dd0 : a9 9f __ LDA #$9f
0dd2 : 85 0e __ STA P1 
0dd4 : 20 dd 0f JSR $0fdd ; (nforml.s0 + 0)
.s1062:
0dd7 : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0dd9 : 85 50 __ STA T0 + 0 
0ddb : 4c 07 0a JMP $0a07 ; (sformat.l1 + 0)
.s250:
0dde : a9 00 __ LDA #$00
.s221:
0de0 : 85 13 __ STA P6 
0de2 : a5 55 __ LDA T2 + 0 
0de4 : 85 0f __ STA P2 
0de6 : a5 56 __ LDA T2 + 1 
0de8 : 85 10 __ STA P3 
0dea : ad fb 9f LDA $9ffb ; (sstack + 5)
0ded : 85 50 __ STA T0 + 0 
0def : ad fc 9f LDA $9ffc ; (sstack + 6)
0df2 : 85 51 __ STA T0 + 1 
0df4 : a0 00 __ LDY #$00
0df6 : b1 50 __ LDA (T0 + 0),y 
0df8 : 85 11 __ STA P4 
0dfa : c8 __ __ INY
0dfb : b1 50 __ LDA (T0 + 0),y 
0dfd : 85 12 __ STA P5 
0dff : 18 __ __ CLC
0e00 : a5 50 __ LDA T0 + 0 
0e02 : 69 02 __ ADC #$02
0e04 : 8d fb 9f STA $9ffb ; (sstack + 5)
0e07 : a5 51 __ LDA T0 + 1 
0e09 : 69 00 __ ADC #$00
0e0b : 8d fc 9f STA $9ffc ; (sstack + 6)
0e0e : a9 de __ LDA #$de
0e10 : 85 0d __ STA P0 
0e12 : a9 9f __ LDA #$9f
0e14 : 85 0e __ STA P1 
0e16 : 20 7e 0e JSR $0e7e ; (nformi.s0 + 0)
0e19 : 4c d7 0d JMP $0dd7 ; (sformat.s1062 + 0)
.s224:
0e1c : a0 00 __ LDY #$00
0e1e : b1 53 __ LDA (T1 + 0),y 
0e20 : aa __ __ TAX
0e21 : 18 __ __ CLC
0e22 : a5 53 __ LDA T1 + 0 
0e24 : 69 01 __ ADC #$01
0e26 : 4c df 0a JMP $0adf ; (sformat.l14 + 0)
--------------------------------------------------------------------
puts:
.s0:
0e29 : a0 00 __ LDY #$00
0e2b : b1 0d __ LDA (P0),y 
0e2d : f0 0b __ BEQ $0e3a ; (puts.s1001 + 0)
0e2f : 20 3b 0e JSR $0e3b ; (putpch + 0)
0e32 : e6 0d __ INC P0 
0e34 : d0 f3 __ BNE $0e29 ; (puts.s0 + 0)
0e36 : e6 0e __ INC P1 
0e38 : d0 ef __ BNE $0e29 ; (puts.s0 + 0)
.s1001:
0e3a : 60 __ __ RTS
--------------------------------------------------------------------
putpch:
0e3b : ae 4c 21 LDX $214c ; (giocharmap + 0)
0e3e : e0 01 __ CPX #$01
0e40 : 90 26 __ BCC $0e68 ; (putpch + 45)
0e42 : c9 0a __ CMP #$0a
0e44 : d0 02 __ BNE $0e48 ; (putpch + 13)
0e46 : a9 0d __ LDA #$0d
0e48 : c9 09 __ CMP #$09
0e4a : f0 1f __ BEQ $0e6b ; (putpch + 48)
0e4c : e0 02 __ CPX #$02
0e4e : 90 18 __ BCC $0e68 ; (putpch + 45)
0e50 : c9 41 __ CMP #$41
0e52 : 90 14 __ BCC $0e68 ; (putpch + 45)
0e54 : c9 7b __ CMP #$7b
0e56 : b0 10 __ BCS $0e68 ; (putpch + 45)
0e58 : c9 61 __ CMP #$61
0e5a : b0 04 __ BCS $0e60 ; (putpch + 37)
0e5c : c9 5b __ CMP #$5b
0e5e : b0 08 __ BCS $0e68 ; (putpch + 45)
0e60 : 49 20 __ EOR #$20
0e62 : e0 03 __ CPX #$03
0e64 : f0 02 __ BEQ $0e68 ; (putpch + 45)
0e66 : 29 df __ AND #$df
0e68 : 4c d2 ff JMP $ffd2 
0e6b : 38 __ __ SEC
0e6c : 20 f0 ff JSR $fff0 
0e6f : 98 __ __ TYA
0e70 : 29 03 __ AND #$03
0e72 : 49 03 __ EOR #$03
0e74 : aa __ __ TAX
0e75 : a9 20 __ LDA #$20
0e77 : 20 d2 ff JSR $ffd2 
0e7a : ca __ __ DEX
0e7b : 10 fa __ BPL $0e77 ; (putpch + 60)
0e7d : 60 __ __ RTS
--------------------------------------------------------------------
giocharmap:
214c : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
nformi:
.s0:
0e7e : a9 00 __ LDA #$00
0e80 : 85 43 __ STA T0 + 0 
0e82 : a5 13 __ LDA P6 ; (s + 0)
0e84 : f0 15 __ BEQ $0e9b ; (nformi.s159 + 0)
.s4:
0e86 : a5 12 __ LDA P5 ; (v + 1)
0e88 : 10 11 __ BPL $0e9b ; (nformi.s159 + 0)
.s1:
0e8a : 38 __ __ SEC
0e8b : a9 00 __ LDA #$00
0e8d : e5 11 __ SBC P4 ; (v + 0)
0e8f : 85 11 __ STA P4 ; (v + 0)
0e91 : a9 00 __ LDA #$00
0e93 : e5 12 __ SBC P5 ; (v + 1)
0e95 : 85 12 __ STA P5 ; (v + 1)
0e97 : a9 01 __ LDA #$01
0e99 : 85 43 __ STA T0 + 0 
.s159:
0e9b : a9 10 __ LDA #$10
0e9d : 85 44 __ STA T2 + 0 
0e9f : a5 11 __ LDA P4 ; (v + 0)
0ea1 : 05 12 __ ORA P5 ; (v + 1)
0ea3 : f0 61 __ BEQ $0f06 ; (nformi.s7 + 0)
.s45:
0ea5 : a5 0d __ LDA P0 ; (si + 0)
0ea7 : 85 45 __ STA T4 + 0 
0ea9 : a5 0e __ LDA P1 ; (si + 1)
0eab : 85 46 __ STA T4 + 1 
.l6:
0ead : a0 03 __ LDY #$03
0eaf : b1 45 __ LDA (T4 + 0),y 
0eb1 : 85 47 __ STA T5 + 0 
0eb3 : 85 03 __ STA WORK + 0 
0eb5 : c8 __ __ INY
0eb6 : b1 45 __ LDA (T4 + 0),y 
0eb8 : 85 48 __ STA T5 + 1 
0eba : 85 04 __ STA WORK + 1 
0ebc : a5 11 __ LDA P4 ; (v + 0)
0ebe : 85 1b __ STA ACCU + 0 
0ec0 : a5 12 __ LDA P5 ; (v + 1)
0ec2 : 85 1c __ STA ACCU + 1 
0ec4 : 20 70 1f JSR $1f70 ; (divmod + 0)
0ec7 : a5 06 __ LDA WORK + 3 
0ec9 : 30 10 __ BMI $0edb ; (nformi.s9 + 0)
.s1019:
0ecb : d0 06 __ BNE $0ed3 ; (nformi.s8 + 0)
.s1018:
0ecd : a5 05 __ LDA WORK + 2 
0ecf : c9 0a __ CMP #$0a
0ed1 : 90 08 __ BCC $0edb ; (nformi.s9 + 0)
.s8:
0ed3 : 18 __ __ CLC
0ed4 : a5 05 __ LDA WORK + 2 
0ed6 : 69 37 __ ADC #$37
0ed8 : 4c e0 0e JMP $0ee0 ; (nformi.s10 + 0)
.s9:
0edb : 18 __ __ CLC
0edc : a5 05 __ LDA WORK + 2 
0ede : 69 30 __ ADC #$30
.s10:
0ee0 : c6 44 __ DEC T2 + 0 
0ee2 : a6 44 __ LDX T2 + 0 
0ee4 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
0ee7 : a5 11 __ LDA P4 ; (v + 0)
0ee9 : 85 1b __ STA ACCU + 0 
0eeb : a5 12 __ LDA P5 ; (v + 1)
0eed : 85 1c __ STA ACCU + 1 
0eef : a5 47 __ LDA T5 + 0 
0ef1 : 85 03 __ STA WORK + 0 
0ef3 : a5 48 __ LDA T5 + 1 
0ef5 : 85 04 __ STA WORK + 1 
0ef7 : 20 70 1f JSR $1f70 ; (divmod + 0)
0efa : a5 1b __ LDA ACCU + 0 
0efc : 85 11 __ STA P4 ; (v + 0)
0efe : a5 1c __ LDA ACCU + 1 
0f00 : 85 12 __ STA P5 ; (v + 1)
0f02 : 05 11 __ ORA P4 ; (v + 0)
0f04 : d0 a7 __ BNE $0ead ; (nformi.l6 + 0)
.s7:
0f06 : a5 0d __ LDA P0 ; (si + 0)
0f08 : 85 11 __ STA P4 ; (v + 0)
0f0a : a5 0e __ LDA P1 ; (si + 1)
0f0c : 85 12 __ STA P5 ; (v + 1)
0f0e : a0 02 __ LDY #$02
0f10 : b1 0d __ LDA (P0),y ; (si + 0)
0f12 : c9 ff __ CMP #$ff
0f14 : d0 04 __ BNE $0f1a ; (nformi.s76 + 0)
.s77:
0f16 : a9 0f __ LDA #$0f
0f18 : d0 05 __ BNE $0f1f ; (nformi.s1026 + 0)
.s76:
0f1a : 38 __ __ SEC
0f1b : a9 10 __ LDA #$10
0f1d : f1 0d __ SBC (P0),y ; (si + 0)
.s1026:
0f1f : a8 __ __ TAY
0f20 : c4 44 __ CPY T2 + 0 
0f22 : b0 0d __ BCS $0f31 ; (nformi.s13 + 0)
.s12:
0f24 : a9 30 __ LDA #$30
.l1027:
0f26 : c6 44 __ DEC T2 + 0 
0f28 : a6 44 __ LDX T2 + 0 
0f2a : 9d e6 9f STA $9fe6,x ; (buffer + 0)
0f2d : c4 44 __ CPY T2 + 0 
0f2f : 90 f5 __ BCC $0f26 ; (nformi.l1027 + 0)
.s13:
0f31 : a0 07 __ LDY #$07
0f33 : b1 0d __ LDA (P0),y ; (si + 0)
0f35 : f0 20 __ BEQ $0f57 ; (nformi.s16 + 0)
.s17:
0f37 : a0 04 __ LDY #$04
0f39 : b1 0d __ LDA (P0),y ; (si + 0)
0f3b : d0 1a __ BNE $0f57 ; (nformi.s16 + 0)
.s1013:
0f3d : 88 __ __ DEY
0f3e : b1 0d __ LDA (P0),y ; (si + 0)
0f40 : c9 10 __ CMP #$10
0f42 : d0 13 __ BNE $0f57 ; (nformi.s16 + 0)
.s14:
0f44 : a9 58 __ LDA #$58
0f46 : a6 44 __ LDX T2 + 0 
0f48 : 9d e5 9f STA $9fe5,x ; (si + 7)
0f4b : 8a __ __ TXA
0f4c : 18 __ __ CLC
0f4d : 69 fe __ ADC #$fe
0f4f : 85 44 __ STA T2 + 0 
0f51 : aa __ __ TAX
0f52 : a9 30 __ LDA #$30
0f54 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
.s16:
0f57 : a9 00 __ LDA #$00
0f59 : 85 1b __ STA ACCU + 0 
0f5b : a5 43 __ LDA T0 + 0 
0f5d : f0 06 __ BEQ $0f65 ; (nformi.s19 + 0)
.s18:
0f5f : c6 44 __ DEC T2 + 0 
0f61 : a9 2d __ LDA #$2d
0f63 : d0 0a __ BNE $0f6f ; (nformi.s1025 + 0)
.s19:
0f65 : a0 05 __ LDY #$05
0f67 : b1 0d __ LDA (P0),y ; (si + 0)
0f69 : f0 09 __ BEQ $0f74 ; (nformi.s141 + 0)
.s21:
0f6b : c6 44 __ DEC T2 + 0 
0f6d : a9 2b __ LDA #$2b
.s1025:
0f6f : a6 44 __ LDX T2 + 0 
0f71 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
.s141:
0f74 : a0 06 __ LDY #$06
0f76 : b1 0d __ LDA (P0),y ; (si + 0)
0f78 : d0 37 __ BNE $0fb1 ; (nformi.s27 + 0)
.l33:
0f7a : a0 01 __ LDY #$01
0f7c : b1 11 __ LDA (P4),y ; (v + 0)
0f7e : 18 __ __ CLC
0f7f : 65 44 __ ADC T2 + 0 
0f81 : b0 04 __ BCS $0f87 ; (nformi.s34 + 0)
.s1006:
0f83 : c9 11 __ CMP #$11
0f85 : 90 0e __ BCC $0f95 ; (nformi.s36 + 0)
.s34:
0f87 : c6 44 __ DEC T2 + 0 
0f89 : a0 00 __ LDY #$00
0f8b : b1 11 __ LDA (P4),y ; (v + 0)
0f8d : a6 44 __ LDX T2 + 0 
0f8f : 9d e6 9f STA $9fe6,x ; (buffer + 0)
0f92 : 4c 7a 0f JMP $0f7a ; (nformi.l33 + 0)
.s36:
0f95 : a6 44 __ LDX T2 + 0 
0f97 : e0 10 __ CPX #$10
0f99 : b0 11 __ BCS $0fac ; (nformi.s26 + 0)
.s1022:
0f9b : 88 __ __ DEY
.l1031:
0f9c : bd e6 9f LDA $9fe6,x ; (buffer + 0)
0f9f : 91 0f __ STA (P2),y ; (str + 0)
0fa1 : e6 44 __ INC T2 + 0 
0fa3 : a6 44 __ LDX T2 + 0 
0fa5 : e0 10 __ CPX #$10
0fa7 : c8 __ __ INY
0fa8 : 90 f2 __ BCC $0f9c ; (nformi.l1031 + 0)
.s1032:
0faa : 84 1b __ STY ACCU + 0 
.s26:
0fac : a9 00 __ LDA #$00
0fae : 85 1c __ STA ACCU + 1 
.s1001:
0fb0 : 60 __ __ RTS
.s27:
0fb1 : a6 44 __ LDX T2 + 0 
0fb3 : e0 10 __ CPX #$10
0fb5 : b0 12 __ BCS $0fc9 ; (nformi.l30 + 0)
.s1020:
0fb7 : a0 00 __ LDY #$00
.l1029:
0fb9 : bd e6 9f LDA $9fe6,x ; (buffer + 0)
0fbc : 91 0f __ STA (P2),y ; (str + 0)
0fbe : e6 44 __ INC T2 + 0 
0fc0 : a6 44 __ LDX T2 + 0 
0fc2 : e0 10 __ CPX #$10
0fc4 : c8 __ __ INY
0fc5 : 90 f2 __ BCC $0fb9 ; (nformi.l1029 + 0)
.s1030:
0fc7 : 84 1b __ STY ACCU + 0 
.l30:
0fc9 : a5 1b __ LDA ACCU + 0 
0fcb : a0 01 __ LDY #$01
0fcd : d1 11 __ CMP (P4),y ; (v + 0)
0fcf : b0 db __ BCS $0fac ; (nformi.s26 + 0)
.s31:
0fd1 : 88 __ __ DEY
0fd2 : b1 11 __ LDA (P4),y ; (v + 0)
0fd4 : a4 1b __ LDY ACCU + 0 
0fd6 : 91 0f __ STA (P2),y ; (str + 0)
0fd8 : e6 1b __ INC ACCU + 0 
0fda : 4c c9 0f JMP $0fc9 ; (nformi.l30 + 0)
--------------------------------------------------------------------
nforml:
.s0:
0fdd : a9 00 __ LDA #$00
0fdf : 85 43 __ STA T0 + 0 
0fe1 : a5 15 __ LDA P8 ; (s + 0)
0fe3 : f0 23 __ BEQ $1008 ; (nforml.s159 + 0)
.s4:
0fe5 : a5 14 __ LDA P7 ; (v + 3)
0fe7 : f0 1f __ BEQ $1008 ; (nforml.s159 + 0)
.s1032:
0fe9 : 10 1d __ BPL $1008 ; (nforml.s159 + 0)
.s1:
0feb : 38 __ __ SEC
0fec : a9 00 __ LDA #$00
0fee : e5 11 __ SBC P4 ; (v + 0)
0ff0 : 85 11 __ STA P4 ; (v + 0)
0ff2 : a9 00 __ LDA #$00
0ff4 : e5 12 __ SBC P5 ; (v + 1)
0ff6 : 85 12 __ STA P5 ; (v + 1)
0ff8 : a9 00 __ LDA #$00
0ffa : e5 13 __ SBC P6 ; (v + 2)
0ffc : 85 13 __ STA P6 ; (v + 2)
0ffe : a9 00 __ LDA #$00
1000 : e5 14 __ SBC P7 ; (v + 3)
1002 : 85 14 __ STA P7 ; (v + 3)
1004 : a9 01 __ LDA #$01
1006 : 85 43 __ STA T0 + 0 
.s159:
1008 : a9 10 __ LDA #$10
100a : 85 44 __ STA T2 + 0 
100c : a5 14 __ LDA P7 ; (v + 3)
100e : f0 03 __ BEQ $1013 ; (nforml.s1018 + 0)
1010 : 4c f7 10 JMP $10f7 ; (nforml.l6 + 0)
.s1018:
1013 : a5 13 __ LDA P6 ; (v + 2)
1015 : f0 03 __ BEQ $101a ; (nforml.s1019 + 0)
1017 : 4c f7 10 JMP $10f7 ; (nforml.l6 + 0)
.s1019:
101a : a5 12 __ LDA P5 ; (v + 1)
101c : f0 03 __ BEQ $1021 ; (nforml.s1020 + 0)
101e : 4c f7 10 JMP $10f7 ; (nforml.l6 + 0)
.s1020:
1021 : c5 11 __ CMP P4 ; (v + 0)
1023 : b0 03 __ BCS $1028 ; (nforml.s7 + 0)
1025 : 4c f7 10 JMP $10f7 ; (nforml.l6 + 0)
.s7:
1028 : a0 02 __ LDY #$02
102a : b1 0d __ LDA (P0),y ; (si + 0)
102c : c9 ff __ CMP #$ff
102e : d0 04 __ BNE $1034 ; (nforml.s76 + 0)
.s77:
1030 : a9 0f __ LDA #$0f
1032 : d0 05 __ BNE $1039 ; (nforml.s1039 + 0)
.s76:
1034 : 38 __ __ SEC
1035 : a9 10 __ LDA #$10
1037 : f1 0d __ SBC (P0),y ; (si + 0)
.s1039:
1039 : a8 __ __ TAY
103a : c4 44 __ CPY T2 + 0 
103c : b0 0d __ BCS $104b ; (nforml.s13 + 0)
.s12:
103e : a9 30 __ LDA #$30
.l1040:
1040 : c6 44 __ DEC T2 + 0 
1042 : a6 44 __ LDX T2 + 0 
1044 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
1047 : c4 44 __ CPY T2 + 0 
1049 : 90 f5 __ BCC $1040 ; (nforml.l1040 + 0)
.s13:
104b : a0 07 __ LDY #$07
104d : b1 0d __ LDA (P0),y ; (si + 0)
104f : f0 20 __ BEQ $1071 ; (nforml.s16 + 0)
.s17:
1051 : a0 04 __ LDY #$04
1053 : b1 0d __ LDA (P0),y ; (si + 0)
1055 : d0 1a __ BNE $1071 ; (nforml.s16 + 0)
.s1013:
1057 : 88 __ __ DEY
1058 : b1 0d __ LDA (P0),y ; (si + 0)
105a : c9 10 __ CMP #$10
105c : d0 13 __ BNE $1071 ; (nforml.s16 + 0)
.s14:
105e : a9 58 __ LDA #$58
1060 : a6 44 __ LDX T2 + 0 
1062 : 9d e5 9f STA $9fe5,x ; (si + 7)
1065 : 8a __ __ TXA
1066 : 18 __ __ CLC
1067 : 69 fe __ ADC #$fe
1069 : 85 44 __ STA T2 + 0 
106b : aa __ __ TAX
106c : a9 30 __ LDA #$30
106e : 9d e6 9f STA $9fe6,x ; (buffer + 0)
.s16:
1071 : a9 00 __ LDA #$00
1073 : 85 1b __ STA ACCU + 0 
1075 : a5 43 __ LDA T0 + 0 
1077 : f0 06 __ BEQ $107f ; (nforml.s19 + 0)
.s18:
1079 : c6 44 __ DEC T2 + 0 
107b : a9 2d __ LDA #$2d
107d : d0 0a __ BNE $1089 ; (nforml.s1038 + 0)
.s19:
107f : a0 05 __ LDY #$05
1081 : b1 0d __ LDA (P0),y ; (si + 0)
1083 : f0 09 __ BEQ $108e ; (nforml.s141 + 0)
.s21:
1085 : c6 44 __ DEC T2 + 0 
1087 : a9 2b __ LDA #$2b
.s1038:
1089 : a6 44 __ LDX T2 + 0 
108b : 9d e6 9f STA $9fe6,x ; (buffer + 0)
.s141:
108e : a0 06 __ LDY #$06
1090 : b1 0d __ LDA (P0),y ; (si + 0)
1092 : d0 37 __ BNE $10cb ; (nforml.s27 + 0)
.l33:
1094 : a0 01 __ LDY #$01
1096 : b1 0d __ LDA (P0),y ; (si + 0)
1098 : 18 __ __ CLC
1099 : 65 44 __ ADC T2 + 0 
109b : b0 04 __ BCS $10a1 ; (nforml.s34 + 0)
.s1006:
109d : c9 11 __ CMP #$11
109f : 90 0e __ BCC $10af ; (nforml.s36 + 0)
.s34:
10a1 : c6 44 __ DEC T2 + 0 
10a3 : a0 00 __ LDY #$00
10a5 : b1 0d __ LDA (P0),y ; (si + 0)
10a7 : a6 44 __ LDX T2 + 0 
10a9 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
10ac : 4c 94 10 JMP $1094 ; (nforml.l33 + 0)
.s36:
10af : a6 44 __ LDX T2 + 0 
10b1 : e0 10 __ CPX #$10
10b3 : b0 11 __ BCS $10c6 ; (nforml.s26 + 0)
.s1035:
10b5 : 88 __ __ DEY
.l1044:
10b6 : bd e6 9f LDA $9fe6,x ; (buffer + 0)
10b9 : 91 0f __ STA (P2),y ; (str + 0)
10bb : e6 44 __ INC T2 + 0 
10bd : a6 44 __ LDX T2 + 0 
10bf : e0 10 __ CPX #$10
10c1 : c8 __ __ INY
10c2 : 90 f2 __ BCC $10b6 ; (nforml.l1044 + 0)
.s1045:
10c4 : 84 1b __ STY ACCU + 0 
.s26:
10c6 : a9 00 __ LDA #$00
10c8 : 85 1c __ STA ACCU + 1 
.s1001:
10ca : 60 __ __ RTS
.s27:
10cb : a6 44 __ LDX T2 + 0 
10cd : e0 10 __ CPX #$10
10cf : b0 12 __ BCS $10e3 ; (nforml.l30 + 0)
.s1033:
10d1 : a0 00 __ LDY #$00
.l1042:
10d3 : bd e6 9f LDA $9fe6,x ; (buffer + 0)
10d6 : 91 0f __ STA (P2),y ; (str + 0)
10d8 : e6 44 __ INC T2 + 0 
10da : a6 44 __ LDX T2 + 0 
10dc : e0 10 __ CPX #$10
10de : c8 __ __ INY
10df : 90 f2 __ BCC $10d3 ; (nforml.l1042 + 0)
.s1043:
10e1 : 84 1b __ STY ACCU + 0 
.l30:
10e3 : a5 1b __ LDA ACCU + 0 
10e5 : a0 01 __ LDY #$01
10e7 : d1 0d __ CMP (P0),y ; (si + 0)
10e9 : b0 db __ BCS $10c6 ; (nforml.s26 + 0)
.s31:
10eb : 88 __ __ DEY
10ec : b1 0d __ LDA (P0),y ; (si + 0)
10ee : a4 1b __ LDY ACCU + 0 
10f0 : 91 0f __ STA (P2),y ; (str + 0)
10f2 : e6 1b __ INC ACCU + 0 
10f4 : 4c e3 10 JMP $10e3 ; (nforml.l30 + 0)
.l6:
10f7 : a0 03 __ LDY #$03
10f9 : b1 0d __ LDA (P0),y ; (si + 0)
10fb : 85 03 __ STA WORK + 0 
10fd : 85 45 __ STA T6 + 0 
10ff : c8 __ __ INY
1100 : b1 0d __ LDA (P0),y ; (si + 0)
1102 : 85 46 __ STA T6 + 1 
1104 : 85 04 __ STA WORK + 1 
1106 : a5 11 __ LDA P4 ; (v + 0)
1108 : 85 1b __ STA ACCU + 0 
110a : a5 12 __ LDA P5 ; (v + 1)
110c : 85 1c __ STA ACCU + 1 
110e : a5 13 __ LDA P6 ; (v + 2)
1110 : 85 1d __ STA ACCU + 2 
1112 : a5 14 __ LDA P7 ; (v + 3)
1114 : 85 1e __ STA ACCU + 3 
1116 : a9 00 __ LDA #$00
1118 : 85 05 __ STA WORK + 2 
111a : 85 06 __ STA WORK + 3 
111c : 20 ab 20 JSR $20ab ; (divmod32 + 0)
111f : a5 08 __ LDA WORK + 5 
1121 : 30 10 __ BMI $1133 ; (nforml.s9 + 0)
.s1023:
1123 : d0 06 __ BNE $112b ; (nforml.s8 + 0)
.s1022:
1125 : a5 07 __ LDA WORK + 4 
1127 : c9 0a __ CMP #$0a
1129 : 90 08 __ BCC $1133 ; (nforml.s9 + 0)
.s8:
112b : 18 __ __ CLC
112c : a5 07 __ LDA WORK + 4 
112e : 69 37 __ ADC #$37
1130 : 4c 38 11 JMP $1138 ; (nforml.s10 + 0)
.s9:
1133 : 18 __ __ CLC
1134 : a5 07 __ LDA WORK + 4 
1136 : 69 30 __ ADC #$30
.s10:
1138 : c6 44 __ DEC T2 + 0 
113a : a6 44 __ LDX T2 + 0 
113c : 9d e6 9f STA $9fe6,x ; (buffer + 0)
113f : a5 11 __ LDA P4 ; (v + 0)
1141 : 85 1b __ STA ACCU + 0 
1143 : a5 12 __ LDA P5 ; (v + 1)
1145 : 85 1c __ STA ACCU + 1 
1147 : a5 13 __ LDA P6 ; (v + 2)
1149 : 85 1d __ STA ACCU + 2 
114b : a5 14 __ LDA P7 ; (v + 3)
114d : 85 1e __ STA ACCU + 3 
114f : a5 45 __ LDA T6 + 0 
1151 : 85 03 __ STA WORK + 0 
1153 : a5 46 __ LDA T6 + 1 
1155 : 85 04 __ STA WORK + 1 
1157 : a9 00 __ LDA #$00
1159 : 85 05 __ STA WORK + 2 
115b : 85 06 __ STA WORK + 3 
115d : 20 ab 20 JSR $20ab ; (divmod32 + 0)
1160 : a5 1b __ LDA ACCU + 0 
1162 : 85 11 __ STA P4 ; (v + 0)
1164 : a5 1c __ LDA ACCU + 1 
1166 : 85 12 __ STA P5 ; (v + 1)
1168 : a5 1d __ LDA ACCU + 2 
116a : 85 13 __ STA P6 ; (v + 2)
116c : a5 1e __ LDA ACCU + 3 
116e : 85 14 __ STA P7 ; (v + 3)
1170 : d0 85 __ BNE $10f7 ; (nforml.l6 + 0)
1172 : 4c 13 10 JMP $1013 ; (nforml.s1018 + 0)
--------------------------------------------------------------------
nformf:
.s0:
1175 : a5 15 __ LDA P8 ; (f + 0)
1177 : 85 43 __ STA T1 + 0 
1179 : a5 16 __ LDA P9 ; (f + 1)
117b : 85 44 __ STA T1 + 1 
117d : a5 17 __ LDA P10 ; (f + 2)
117f : 85 45 __ STA T1 + 2 
1181 : a5 18 __ LDA P11 ; (f + 3)
1183 : 29 7f __ AND #$7f
1185 : 05 17 __ ORA P10 ; (f + 2)
1187 : 05 16 __ ORA P9 ; (f + 1)
1189 : 05 15 __ ORA P8 ; (f + 0)
118b : f0 21 __ BEQ $11ae ; (nformf.s2 + 0)
.s1005:
118d : a5 18 __ LDA P11 ; (f + 3)
118f : 10 1d __ BPL $11ae ; (nformf.s2 + 0)
.s1:
1191 : a9 2d __ LDA #$2d
1193 : a0 00 __ LDY #$00
1195 : 91 13 __ STA (P6),y ; (str + 0)
1197 : a5 18 __ LDA P11 ; (f + 3)
1199 : 49 80 __ EOR #$80
119b : 85 18 __ STA P11 ; (f + 3)
119d : 85 10 __ STA P3 
119f : a5 15 __ LDA P8 ; (f + 0)
11a1 : 85 0d __ STA P0 
11a3 : a5 16 __ LDA P9 ; (f + 1)
11a5 : 85 0e __ STA P1 
11a7 : a5 17 __ LDA P10 ; (f + 2)
11a9 : 85 0f __ STA P2 
11ab : 4c 2e 16 JMP $162e ; (nformf.s189 + 0)
.s2:
11ae : a5 15 __ LDA P8 ; (f + 0)
11b0 : 85 0d __ STA P0 
11b2 : a5 16 __ LDA P9 ; (f + 1)
11b4 : 85 0e __ STA P1 
11b6 : a5 17 __ LDA P10 ; (f + 2)
11b8 : 85 0f __ STA P2 
11ba : a5 18 __ LDA P11 ; (f + 3)
11bc : 85 10 __ STA P3 
11be : a0 05 __ LDY #$05
11c0 : b1 11 __ LDA (P4),y ; (si + 0)
11c2 : f0 09 __ BEQ $11cd ; (nformf.s3 + 0)
.s4:
11c4 : a9 2b __ LDA #$2b
11c6 : a0 00 __ LDY #$00
11c8 : 91 13 __ STA (P6),y ; (str + 0)
11ca : 4c 2e 16 JMP $162e ; (nformf.s189 + 0)
.s3:
11cd : 20 46 16 JSR $1646 ; (isinf.s0 + 0)
11d0 : aa __ __ TAX
11d1 : a9 00 __ LDA #$00
11d3 : 85 48 __ STA T3 + 0 
11d5 : 8a __ __ TXA
11d6 : f0 0b __ BEQ $11e3 ; (nformf.s8 + 0)
.s160:
11d8 : a9 01 __ LDA #$01
11da : 85 4a __ STA T5 + 0 
11dc : a9 02 __ LDA #$02
11de : a0 00 __ LDY #$00
11e0 : 4c 12 16 JMP $1612 ; (nformf.s7 + 0)
.s8:
11e3 : a0 02 __ LDY #$02
11e5 : b1 11 __ LDA (P4),y ; (si + 0)
11e7 : c9 ff __ CMP #$ff
11e9 : d0 02 __ BNE $11ed ; (nformf.s128 + 0)
.s129:
11eb : a9 06 __ LDA #$06
.s128:
11ed : 86 4a __ STX T5 + 0 
11ef : 86 4b __ STX T5 + 1 
11f1 : 85 49 __ STA T4 + 0 
11f3 : 85 47 __ STA T2 + 0 
11f5 : a5 18 __ LDA P11 ; (f + 3)
11f7 : 85 46 __ STA T1 + 3 
11f9 : 29 7f __ AND #$7f
11fb : 05 17 __ ORA P10 ; (f + 2)
11fd : 05 16 __ ORA P9 ; (f + 1)
11ff : 05 15 __ ORA P8 ; (f + 0)
1201 : f0 03 __ BEQ $1206 ; (nformf.s12 + 0)
1203 : 4c 13 15 JMP $1513 ; (nformf.s13 + 0)
.s12:
1206 : ad f6 9f LDA $9ff6 ; (sstack + 0)
1209 : c9 65 __ CMP #$65
120b : d0 04 __ BNE $1211 ; (nformf.s1007 + 0)
.s1006:
120d : a9 01 __ LDA #$01
120f : d0 02 __ BNE $1213 ; (nformf.s1008 + 0)
.s1007:
1211 : a9 00 __ LDA #$00
.s1008:
1213 : 85 4e __ STA T9 + 0 
1215 : a6 49 __ LDX T4 + 0 
1217 : e8 __ __ INX
1218 : 86 4c __ STX T8 + 0 
121a : ad f6 9f LDA $9ff6 ; (sstack + 0)
121d : c9 67 __ CMP #$67
121f : d0 13 __ BNE $1234 ; (nformf.s24 + 0)
.s22:
1221 : a5 4b __ LDA T5 + 1 
1223 : 30 08 __ BMI $122d ; (nformf.s25 + 0)
.s1050:
1225 : d0 06 __ BNE $122d ; (nformf.s25 + 0)
.s1049:
1227 : a5 4a __ LDA T5 + 0 
1229 : c9 04 __ CMP #$04
122b : 90 07 __ BCC $1234 ; (nformf.s24 + 0)
.s25:
122d : a9 01 __ LDA #$01
122f : 85 4e __ STA T9 + 0 
1231 : 4c 8b 14 JMP $148b ; (nformf.s30 + 0)
.s24:
1234 : a5 4e __ LDA T9 + 0 
1236 : f0 03 __ BEQ $123b ; (nformf.s32 + 0)
1238 : 4c 8b 14 JMP $148b ; (nformf.s30 + 0)
.s32:
123b : a5 4b __ LDA T5 + 1 
123d : 10 3e __ BPL $127d ; (nformf.s34 + 0)
.s33:
123f : a5 43 __ LDA T1 + 0 
1241 : 85 1b __ STA ACCU + 0 
1243 : a5 44 __ LDA T1 + 1 
1245 : 85 1c __ STA ACCU + 1 
1247 : a5 45 __ LDA T1 + 2 
1249 : 85 1d __ STA ACCU + 2 
124b : a5 46 __ LDA T1 + 3 
124d : 85 1e __ STA ACCU + 3 
.l1085:
124f : e6 4a __ INC T5 + 0 
1251 : d0 02 __ BNE $1255 ; (nformf.s1095 + 0)
.s1094:
1253 : e6 4b __ INC T5 + 1 
.s1095:
1255 : a9 00 __ LDA #$00
1257 : 85 03 __ STA WORK + 0 
1259 : 85 04 __ STA WORK + 1 
125b : a9 20 __ LDA #$20
125d : 85 05 __ STA WORK + 2 
125f : a9 41 __ LDA #$41
1261 : 85 06 __ STA WORK + 3 
1263 : 20 a1 1c JSR $1ca1 ; (freg + 20)
1266 : 20 88 1e JSR $1e88 ; (fdiv + 0)
1269 : a5 4b __ LDA T5 + 1 
126b : 30 e2 __ BMI $124f ; (nformf.l1085 + 0)
.s1086:
126d : a5 1e __ LDA ACCU + 3 
126f : 85 46 __ STA T1 + 3 
1271 : a5 1d __ LDA ACCU + 2 
1273 : 85 45 __ STA T1 + 2 
1275 : a5 1c __ LDA ACCU + 1 
1277 : 85 44 __ STA T1 + 1 
1279 : a5 1b __ LDA ACCU + 0 
127b : 85 43 __ STA T1 + 0 
.s34:
127d : 18 __ __ CLC
127e : a5 49 __ LDA T4 + 0 
1280 : 65 4a __ ADC T5 + 0 
1282 : 18 __ __ CLC
1283 : 69 01 __ ADC #$01
1285 : 85 4c __ STA T8 + 0 
1287 : c9 07 __ CMP #$07
1289 : 90 13 __ BCC $129e ; (nformf.s35 + 0)
.s36:
128b : ad 66 21 LDA $2166 ; (fround5 + 25)
128e : 85 1c __ STA ACCU + 1 
1290 : ad 67 21 LDA $2167 ; (fround5 + 26)
1293 : 85 1d __ STA ACCU + 2 
1295 : ad 68 21 LDA $2168 ; (fround5 + 27)
1298 : ae 65 21 LDX $2165 ; (fround5 + 24)
129b : 4c b1 12 JMP $12b1 ; (nformf.s214 + 0)
.s35:
129e : 0a __ __ ASL
129f : 0a __ __ ASL
12a0 : a8 __ __ TAY
12a1 : b9 4a 21 LDA $214a,y ; (__multab3L + 9)
12a4 : 85 1c __ STA ACCU + 1 
12a6 : b9 4b 21 LDA $214b,y ; (spentry + 0)
12a9 : 85 1d __ STA ACCU + 2 
12ab : b9 4c 21 LDA $214c,y ; (giocharmap + 0)
12ae : be 49 21 LDX $2149,y ; (__multab3L + 8)
.s214:
12b1 : 86 1b __ STX ACCU + 0 
12b3 : 85 1e __ STA ACCU + 3 
12b5 : a2 43 __ LDX #$43
12b7 : 20 91 1c JSR $1c91 ; (freg + 4)
12ba : 20 d2 1c JSR $1cd2 ; (faddsub + 0)
12bd : a5 1c __ LDA ACCU + 1 
12bf : 85 16 __ STA P9 ; (f + 1)
12c1 : a5 1d __ LDA ACCU + 2 
12c3 : 85 17 __ STA P10 ; (f + 2)
12c5 : a6 1b __ LDX ACCU + 0 
12c7 : a5 1e __ LDA ACCU + 3 
12c9 : 85 18 __ STA P11 ; (f + 3)
12cb : 30 35 __ BMI $1302 ; (nformf.s31 + 0)
.s1032:
12cd : c9 41 __ CMP #$41
12cf : d0 06 __ BNE $12d7 ; (nformf.s1036 + 0)
.s1033:
12d1 : a5 17 __ LDA P10 ; (f + 2)
12d3 : c9 20 __ CMP #$20
12d5 : f0 02 __ BEQ $12d9 ; (nformf.s38 + 0)
.s1036:
12d7 : 90 29 __ BCC $1302 ; (nformf.s31 + 0)
.s38:
12d9 : a9 00 __ LDA #$00
12db : 85 03 __ STA WORK + 0 
12dd : 85 04 __ STA WORK + 1 
12df : a9 20 __ LDA #$20
12e1 : 85 05 __ STA WORK + 2 
12e3 : a9 41 __ LDA #$41
12e5 : 85 06 __ STA WORK + 3 
12e7 : 20 a1 1c JSR $1ca1 ; (freg + 20)
12ea : 20 88 1e JSR $1e88 ; (fdiv + 0)
12ed : a5 1c __ LDA ACCU + 1 
12ef : 85 16 __ STA P9 ; (f + 1)
12f1 : a5 1d __ LDA ACCU + 2 
12f3 : 85 17 __ STA P10 ; (f + 2)
12f5 : a5 1e __ LDA ACCU + 3 
12f7 : 85 18 __ STA P11 ; (f + 3)
12f9 : 18 __ __ CLC
12fa : a5 49 __ LDA T4 + 0 
12fc : 69 ff __ ADC #$ff
12fe : 85 47 __ STA T2 + 0 
1300 : a6 1b __ LDX ACCU + 0 
.s31:
1302 : 38 __ __ SEC
1303 : a5 4c __ LDA T8 + 0 
1305 : e5 47 __ SBC T2 + 0 
1307 : 85 49 __ STA T4 + 0 
1309 : a9 14 __ LDA #$14
130b : c5 4c __ CMP T8 + 0 
130d : b0 02 __ BCS $1311 ; (nformf.s49 + 0)
.s47:
130f : 85 4c __ STA T8 + 0 
.s49:
1311 : a5 49 __ LDA T4 + 0 
1313 : d0 08 __ BNE $131d ; (nformf.s219 + 0)
.s50:
1315 : a9 30 __ LDA #$30
1317 : a4 48 __ LDY T3 + 0 
1319 : 91 13 __ STA (P6),y ; (str + 0)
131b : e6 48 __ INC T3 + 0 
.s219:
131d : a9 00 __ LDA #$00
131f : 85 47 __ STA T2 + 0 
1321 : c5 49 __ CMP T4 + 0 
1323 : d0 08 __ BNE $132d ; (nformf.l59 + 0)
.l57:
1325 : a9 2e __ LDA #$2e
1327 : a4 48 __ LDY T3 + 0 
1329 : 91 13 __ STA (P6),y ; (str + 0)
132b : e6 48 __ INC T3 + 0 
.l59:
132d : a5 47 __ LDA T2 + 0 
132f : c9 07 __ CMP #$07
1331 : 90 04 __ BCC $1337 ; (nformf.s61 + 0)
.s60:
1333 : a9 30 __ LDA #$30
1335 : d0 55 __ BNE $138c ; (nformf.s208 + 0)
.s61:
1337 : 86 1b __ STX ACCU + 0 
1339 : 86 43 __ STX T1 + 0 
133b : a5 16 __ LDA P9 ; (f + 1)
133d : 85 1c __ STA ACCU + 1 
133f : 85 44 __ STA T1 + 1 
1341 : a5 17 __ LDA P10 ; (f + 2)
1343 : 85 1d __ STA ACCU + 2 
1345 : 85 45 __ STA T1 + 2 
1347 : a5 18 __ LDA P11 ; (f + 3)
1349 : 85 1e __ STA ACCU + 3 
134b : 85 46 __ STA T1 + 3 
134d : 20 1e 20 JSR $201e ; (f32_to_i16 + 0)
1350 : a5 1b __ LDA ACCU + 0 
1352 : 85 4f __ STA T11 + 0 
1354 : 20 60 20 JSR $2060 ; (sint16_to_float + 0)
1357 : a2 43 __ LDX #$43
1359 : 20 91 1c JSR $1c91 ; (freg + 4)
135c : a5 1e __ LDA ACCU + 3 
135e : 49 80 __ EOR #$80
1360 : 85 1e __ STA ACCU + 3 
1362 : 20 d2 1c JSR $1cd2 ; (faddsub + 0)
1365 : a9 00 __ LDA #$00
1367 : 85 03 __ STA WORK + 0 
1369 : 85 04 __ STA WORK + 1 
136b : a9 20 __ LDA #$20
136d : 85 05 __ STA WORK + 2 
136f : a9 41 __ LDA #$41
1371 : 85 06 __ STA WORK + 3 
1373 : 20 a1 1c JSR $1ca1 ; (freg + 20)
1376 : 20 b9 1d JSR $1db9 ; (fmul + 0)
1379 : a5 1c __ LDA ACCU + 1 
137b : 85 16 __ STA P9 ; (f + 1)
137d : a5 1d __ LDA ACCU + 2 
137f : 85 17 __ STA P10 ; (f + 2)
1381 : a5 1e __ LDA ACCU + 3 
1383 : 85 18 __ STA P11 ; (f + 3)
1385 : 18 __ __ CLC
1386 : a5 4f __ LDA T11 + 0 
1388 : 69 30 __ ADC #$30
138a : a6 1b __ LDX ACCU + 0 
.s208:
138c : a4 48 __ LDY T3 + 0 
138e : 91 13 __ STA (P6),y ; (str + 0)
1390 : e6 48 __ INC T3 + 0 
1392 : e6 47 __ INC T2 + 0 
1394 : a5 47 __ LDA T2 + 0 
1396 : c5 4c __ CMP T8 + 0 
1398 : b0 07 __ BCS $13a1 ; (nformf.s56 + 0)
.s54:
139a : c5 49 __ CMP T4 + 0 
139c : d0 8f __ BNE $132d ; (nformf.l59 + 0)
139e : 4c 25 13 JMP $1325 ; (nformf.l57 + 0)
.s56:
13a1 : a5 4e __ LDA T9 + 0 
13a3 : f0 62 __ BEQ $1407 ; (nformf.s9 + 0)
.s63:
13a5 : a9 45 __ LDA #$45
13a7 : a4 48 __ LDY T3 + 0 
13a9 : 91 13 __ STA (P6),y ; (str + 0)
13ab : c8 __ __ INY
13ac : a5 4b __ LDA T5 + 1 
13ae : 30 06 __ BMI $13b6 ; (nformf.s66 + 0)
.s67:
13b0 : a9 2b __ LDA #$2b
13b2 : 91 13 __ STA (P6),y ; (str + 0)
13b4 : d0 11 __ BNE $13c7 ; (nformf.s68 + 0)
.s66:
13b6 : a9 2d __ LDA #$2d
13b8 : 91 13 __ STA (P6),y ; (str + 0)
13ba : 38 __ __ SEC
13bb : a9 00 __ LDA #$00
13bd : e5 4a __ SBC T5 + 0 
13bf : 85 4a __ STA T5 + 0 
13c1 : a9 00 __ LDA #$00
13c3 : e5 4b __ SBC T5 + 1 
13c5 : 85 4b __ STA T5 + 1 
.s68:
13c7 : a5 4a __ LDA T5 + 0 
13c9 : 85 1b __ STA ACCU + 0 
13cb : a5 4b __ LDA T5 + 1 
13cd : 85 1c __ STA ACCU + 1 
13cf : a9 0a __ LDA #$0a
13d1 : 85 03 __ STA WORK + 0 
13d3 : a9 00 __ LDA #$00
13d5 : 85 04 __ STA WORK + 1 
13d7 : 20 36 1f JSR $1f36 ; (divs16 + 0)
13da : 18 __ __ CLC
13db : a5 1b __ LDA ACCU + 0 
13dd : 69 30 __ ADC #$30
13df : a4 48 __ LDY T3 + 0 
13e1 : c8 __ __ INY
13e2 : c8 __ __ INY
13e3 : 91 13 __ STA (P6),y ; (str + 0)
13e5 : a5 4a __ LDA T5 + 0 
13e7 : 85 1b __ STA ACCU + 0 
13e9 : a5 4b __ LDA T5 + 1 
13eb : 85 1c __ STA ACCU + 1 
13ed : a9 0a __ LDA #$0a
13ef : 85 03 __ STA WORK + 0 
13f1 : a9 00 __ LDA #$00
13f3 : 85 04 __ STA WORK + 1 
13f5 : 20 f5 1f JSR $1ff5 ; (mods16 + 0)
13f8 : 18 __ __ CLC
13f9 : a5 05 __ LDA WORK + 2 
13fb : 69 30 __ ADC #$30
13fd : a4 48 __ LDY T3 + 0 
13ff : c8 __ __ INY
1400 : c8 __ __ INY
1401 : c8 __ __ INY
1402 : 91 13 __ STA (P6),y ; (str + 0)
1404 : c8 __ __ INY
1405 : 84 48 __ STY T3 + 0 
.s9:
1407 : a5 11 __ LDA P4 ; (si + 0)
1409 : 85 4a __ STA T5 + 0 
140b : a5 12 __ LDA P5 ; (si + 1)
140d : 85 4b __ STA T5 + 1 
140f : a5 48 __ LDA T3 + 0 
1411 : a0 01 __ LDY #$01
1413 : d1 11 __ CMP (P4),y ; (si + 0)
1415 : b0 5d __ BCS $1474 ; (nformf.s1001 + 0)
.s69:
1417 : a0 06 __ LDY #$06
1419 : b1 11 __ LDA (P4),y ; (si + 0)
141b : f0 06 __ BEQ $1423 ; (nformf.s73 + 0)
.s72:
141d : a5 48 __ LDA T3 + 0 
141f : aa __ __ TAX
1420 : 4c 7b 14 JMP $147b ; (nformf.l75 + 0)
.s73:
1423 : a5 48 __ LDA T3 + 0 
1425 : f0 2d __ BEQ $1454 ; (nformf.s82 + 0)
.s90:
1427 : a9 01 __ LDA #$01
1429 : 85 47 __ STA T2 + 0 
142b : a6 48 __ LDX T3 + 0 
142d : 38 __ __ SEC
.l1083:
142e : a0 01 __ LDY #$01
1430 : b1 11 __ LDA (P4),y ; (si + 0)
1432 : e5 47 __ SBC T2 + 0 
1434 : 85 4c __ STA T8 + 0 
1436 : a9 ff __ LDA #$ff
1438 : 65 14 __ ADC P7 ; (str + 1)
143a : 85 4d __ STA T8 + 1 
143c : 8a __ __ TXA
143d : 38 __ __ SEC
143e : e5 47 __ SBC T2 + 0 
1440 : 85 1b __ STA ACCU + 0 
1442 : a9 ff __ LDA #$ff
1444 : 65 14 __ ADC P7 ; (str + 1)
1446 : 85 1c __ STA ACCU + 1 
1448 : a4 13 __ LDY P6 ; (str + 0)
144a : b1 1b __ LDA (ACCU + 0),y 
144c : 91 4c __ STA (T8 + 0),y 
144e : e6 47 __ INC T2 + 0 
1450 : e4 47 __ CPX T2 + 0 
1452 : b0 da __ BCS $142e ; (nformf.l1083 + 0)
.s82:
1454 : a9 00 __ LDA #$00
1456 : 85 47 __ STA T2 + 0 
.l83:
1458 : a0 01 __ LDY #$01
145a : b1 4a __ LDA (T5 + 0),y 
145c : 38 __ __ SEC
145d : e5 48 __ SBC T3 + 0 
145f : 90 06 __ BCC $1467 ; (nformf.s84 + 0)
.s1011:
1461 : c5 47 __ CMP T2 + 0 
1463 : 90 0d __ BCC $1472 ; (nformf.s74 + 0)
.s1087:
1465 : f0 0b __ BEQ $1472 ; (nformf.s74 + 0)
.s84:
1467 : a9 20 __ LDA #$20
1469 : a4 47 __ LDY T2 + 0 
146b : 91 13 __ STA (P6),y ; (str + 0)
146d : e6 47 __ INC T2 + 0 
146f : 4c 58 14 JMP $1458 ; (nformf.l83 + 0)
.s74:
1472 : b1 11 __ LDA (P4),y ; (si + 0)
.s1001:
1474 : 85 1b __ STA ACCU + 0 
1476 : a9 00 __ LDA #$00
1478 : 85 1c __ STA ACCU + 1 
147a : 60 __ __ RTS
.l75:
147b : a0 01 __ LDY #$01
147d : d1 4a __ CMP (T5 + 0),y 
147f : b0 f1 __ BCS $1472 ; (nformf.s74 + 0)
.s76:
1481 : a8 __ __ TAY
1482 : a9 20 __ LDA #$20
1484 : 91 13 __ STA (P6),y ; (str + 0)
1486 : e8 __ __ INX
1487 : 8a __ __ TXA
1488 : 4c 7b 14 JMP $147b ; (nformf.l75 + 0)
.s30:
148b : a5 4c __ LDA T8 + 0 
148d : c9 07 __ CMP #$07
148f : 90 13 __ BCC $14a4 ; (nformf.s41 + 0)
.s42:
1491 : ad 66 21 LDA $2166 ; (fround5 + 25)
1494 : 85 1c __ STA ACCU + 1 
1496 : ad 67 21 LDA $2167 ; (fround5 + 26)
1499 : 85 1d __ STA ACCU + 2 
149b : ad 68 21 LDA $2168 ; (fround5 + 27)
149e : ae 65 21 LDX $2165 ; (fround5 + 24)
14a1 : 4c b7 14 JMP $14b7 ; (nformf.s204 + 0)
.s41:
14a4 : 0a __ __ ASL
14a5 : 0a __ __ ASL
14a6 : a8 __ __ TAY
14a7 : b9 4a 21 LDA $214a,y ; (__multab3L + 9)
14aa : 85 1c __ STA ACCU + 1 
14ac : b9 4b 21 LDA $214b,y ; (spentry + 0)
14af : 85 1d __ STA ACCU + 2 
14b1 : b9 4c 21 LDA $214c,y ; (giocharmap + 0)
14b4 : be 49 21 LDX $2149,y ; (__multab3L + 8)
.s204:
14b7 : 86 1b __ STX ACCU + 0 
14b9 : 85 1e __ STA ACCU + 3 
14bb : a2 43 __ LDX #$43
14bd : 20 91 1c JSR $1c91 ; (freg + 4)
14c0 : 20 d2 1c JSR $1cd2 ; (faddsub + 0)
14c3 : a5 1c __ LDA ACCU + 1 
14c5 : 85 16 __ STA P9 ; (f + 1)
14c7 : a5 1d __ LDA ACCU + 2 
14c9 : 85 17 __ STA P10 ; (f + 2)
14cb : a6 1b __ LDX ACCU + 0 
14cd : a5 1e __ LDA ACCU + 3 
14cf : 85 18 __ STA P11 ; (f + 3)
14d1 : 10 03 __ BPL $14d6 ; (nformf.s1042 + 0)
14d3 : 4c 02 13 JMP $1302 ; (nformf.s31 + 0)
.s1042:
14d6 : c9 41 __ CMP #$41
14d8 : d0 06 __ BNE $14e0 ; (nformf.s1046 + 0)
.s1043:
14da : a5 17 __ LDA P10 ; (f + 2)
14dc : c9 20 __ CMP #$20
14de : f0 05 __ BEQ $14e5 ; (nformf.s44 + 0)
.s1046:
14e0 : b0 03 __ BCS $14e5 ; (nformf.s44 + 0)
14e2 : 4c 02 13 JMP $1302 ; (nformf.s31 + 0)
.s44:
14e5 : a9 00 __ LDA #$00
14e7 : 85 03 __ STA WORK + 0 
14e9 : 85 04 __ STA WORK + 1 
14eb : a9 20 __ LDA #$20
14ed : 85 05 __ STA WORK + 2 
14ef : a9 41 __ LDA #$41
14f1 : 85 06 __ STA WORK + 3 
14f3 : 20 a1 1c JSR $1ca1 ; (freg + 20)
14f6 : 20 88 1e JSR $1e88 ; (fdiv + 0)
14f9 : a5 1c __ LDA ACCU + 1 
14fb : 85 16 __ STA P9 ; (f + 1)
14fd : a5 1d __ LDA ACCU + 2 
14ff : 85 17 __ STA P10 ; (f + 2)
1501 : a5 1e __ LDA ACCU + 3 
1503 : 85 18 __ STA P11 ; (f + 3)
1505 : a6 1b __ LDX ACCU + 0 
1507 : e6 4a __ INC T5 + 0 
1509 : f0 03 __ BEQ $150e ; (nformf.s1092 + 0)
150b : 4c 02 13 JMP $1302 ; (nformf.s31 + 0)
.s1092:
150e : e6 4b __ INC T5 + 1 
1510 : 4c 02 13 JMP $1302 ; (nformf.s31 + 0)
.s13:
1513 : a5 18 __ LDA P11 ; (f + 3)
1515 : 30 59 __ BMI $1570 ; (nformf.l17 + 0)
.l1072:
1517 : c9 44 __ CMP #$44
1519 : f0 03 __ BEQ $151e ; (nformf.s1073 + 0)
151b : 4c 0d 16 JMP $160d ; (nformf.s1076 + 0)
.s1073:
151e : a5 45 __ LDA T1 + 2 
1520 : c9 7a __ CMP #$7a
1522 : f0 03 __ BEQ $1527 ; (nformf.s1074 + 0)
1524 : 4c 0d 16 JMP $160d ; (nformf.s1076 + 0)
.s1074:
1527 : a5 44 __ LDA T1 + 1 
1529 : d0 04 __ BNE $152f ; (nformf.s1082 + 0)
.s1075:
152b : a5 43 __ LDA T1 + 0 
152d : f0 02 __ BEQ $1531 ; (nformf.s14 + 0)
.s1082:
152f : a5 43 __ LDA T1 + 0 
.s14:
1531 : 85 1b __ STA ACCU + 0 
1533 : a5 44 __ LDA T1 + 1 
1535 : 85 1c __ STA ACCU + 1 
1537 : a5 45 __ LDA T1 + 2 
1539 : 85 1d __ STA ACCU + 2 
153b : a5 46 __ LDA T1 + 3 
153d : 85 1e __ STA ACCU + 3 
153f : a9 00 __ LDA #$00
1541 : 85 03 __ STA WORK + 0 
1543 : 85 04 __ STA WORK + 1 
1545 : a9 7a __ LDA #$7a
1547 : 85 05 __ STA WORK + 2 
1549 : a9 44 __ LDA #$44
154b : 85 06 __ STA WORK + 3 
154d : 20 a1 1c JSR $1ca1 ; (freg + 20)
1550 : 20 88 1e JSR $1e88 ; (fdiv + 0)
1553 : a5 1b __ LDA ACCU + 0 
1555 : 85 43 __ STA T1 + 0 
1557 : a5 1c __ LDA ACCU + 1 
1559 : 85 44 __ STA T1 + 1 
155b : a5 1d __ LDA ACCU + 2 
155d : 85 45 __ STA T1 + 2 
155f : 18 __ __ CLC
1560 : a5 4a __ LDA T5 + 0 
1562 : 69 03 __ ADC #$03
1564 : 85 4a __ STA T5 + 0 
1566 : 90 02 __ BCC $156a ; (nformf.s1097 + 0)
.s1096:
1568 : e6 4b __ INC T5 + 1 
.s1097:
156a : a5 1e __ LDA ACCU + 3 
156c : 85 46 __ STA T1 + 3 
156e : 10 a7 __ BPL $1517 ; (nformf.l1072 + 0)
.l17:
1570 : a9 00 __ LDA #$00
1572 : 85 1b __ STA ACCU + 0 
1574 : 85 1c __ STA ACCU + 1 
1576 : a9 7a __ LDA #$7a
1578 : 85 1d __ STA ACCU + 2 
157a : a9 44 __ LDA #$44
157c : 85 1e __ STA ACCU + 3 
157e : a2 43 __ LDX #$43
1580 : 20 91 1c JSR $1c91 ; (freg + 4)
1583 : 20 b9 1d JSR $1db9 ; (fmul + 0)
1586 : a5 1b __ LDA ACCU + 0 
1588 : 85 43 __ STA T1 + 0 
158a : a5 1c __ LDA ACCU + 1 
158c : 85 44 __ STA T1 + 1 
158e : a5 1d __ LDA ACCU + 2 
1590 : 85 45 __ STA T1 + 2 
1592 : a5 1e __ LDA ACCU + 3 
1594 : 85 46 __ STA T1 + 3 
1596 : 38 __ __ SEC
1597 : a5 4a __ LDA T5 + 0 
1599 : e9 03 __ SBC #$03
159b : 85 4a __ STA T5 + 0 
159d : b0 02 __ BCS $15a1 ; (nformf.s16 + 0)
.s1088:
159f : c6 4b __ DEC T5 + 1 
.s16:
15a1 : a5 46 __ LDA T1 + 3 
15a3 : 30 cb __ BMI $1570 ; (nformf.l17 + 0)
.s1064:
15a5 : c9 3f __ CMP #$3f
15a7 : d0 06 __ BNE $15af ; (nformf.s1068 + 0)
.s1065:
15a9 : a5 45 __ LDA T1 + 2 
15ab : c9 80 __ CMP #$80
15ad : f0 02 __ BEQ $15b1 ; (nformf.s19 + 0)
.s1068:
15af : 90 bf __ BCC $1570 ; (nformf.l17 + 0)
.s19:
15b1 : a5 46 __ LDA T1 + 3 
15b3 : c9 41 __ CMP #$41
15b5 : d0 51 __ BNE $1608 ; (nformf.l1060 + 0)
.s1057:
15b7 : a5 45 __ LDA T1 + 2 
15b9 : c9 20 __ CMP #$20
15bb : d0 4b __ BNE $1608 ; (nformf.l1060 + 0)
.s1058:
15bd : a5 44 __ LDA T1 + 1 
15bf : d0 04 __ BNE $15c5 ; (nformf.l1081 + 0)
.s1059:
15c1 : a5 43 __ LDA T1 + 0 
15c3 : f0 02 __ BEQ $15c7 ; (nformf.l20 + 0)
.l1081:
15c5 : a5 43 __ LDA T1 + 0 
.l20:
15c7 : 85 1b __ STA ACCU + 0 
15c9 : a5 44 __ LDA T1 + 1 
15cb : 85 1c __ STA ACCU + 1 
15cd : a5 45 __ LDA T1 + 2 
15cf : 85 1d __ STA ACCU + 2 
15d1 : a5 46 __ LDA T1 + 3 
15d3 : 85 1e __ STA ACCU + 3 
15d5 : a9 00 __ LDA #$00
15d7 : 85 03 __ STA WORK + 0 
15d9 : 85 04 __ STA WORK + 1 
15db : a9 20 __ LDA #$20
15dd : 85 05 __ STA WORK + 2 
15df : a9 41 __ LDA #$41
15e1 : 85 06 __ STA WORK + 3 
15e3 : 20 a1 1c JSR $1ca1 ; (freg + 20)
15e6 : 20 88 1e JSR $1e88 ; (fdiv + 0)
15e9 : a5 1b __ LDA ACCU + 0 
15eb : 85 43 __ STA T1 + 0 
15ed : a5 1c __ LDA ACCU + 1 
15ef : 85 44 __ STA T1 + 1 
15f1 : a5 1d __ LDA ACCU + 2 
15f3 : 85 45 __ STA T1 + 2 
15f5 : e6 4a __ INC T5 + 0 
15f7 : d0 02 __ BNE $15fb ; (nformf.s1091 + 0)
.s1090:
15f9 : e6 4b __ INC T5 + 1 
.s1091:
15fb : a5 1e __ LDA ACCU + 3 
15fd : 85 46 __ STA T1 + 3 
15ff : 10 03 __ BPL $1604 ; (nformf.s1056 + 0)
1601 : 4c 06 12 JMP $1206 ; (nformf.s12 + 0)
.s1056:
1604 : c9 41 __ CMP #$41
1606 : f0 af __ BEQ $15b7 ; (nformf.s1057 + 0)
.l1060:
1608 : b0 bb __ BCS $15c5 ; (nformf.l1081 + 0)
160a : 4c 06 12 JMP $1206 ; (nformf.s12 + 0)
.s1076:
160d : 90 92 __ BCC $15a1 ; (nformf.s16 + 0)
160f : 4c 2f 15 JMP $152f ; (nformf.s1082 + 0)
.s7:
1612 : 85 1b __ STA ACCU + 0 
1614 : a9 49 __ LDA #$49
1616 : 91 13 __ STA (P6),y ; (str + 0)
1618 : a9 4e __ LDA #$4e
161a : a4 4a __ LDY T5 + 0 
161c : 91 13 __ STA (P6),y ; (str + 0)
161e : a9 46 __ LDA #$46
1620 : a4 1b __ LDY ACCU + 0 
1622 : 91 13 __ STA (P6),y ; (str + 0)
1624 : 18 __ __ CLC
1625 : a5 48 __ LDA T3 + 0 
1627 : 69 03 __ ADC #$03
1629 : 85 48 __ STA T3 + 0 
162b : 4c 07 14 JMP $1407 ; (nformf.s9 + 0)
.s189:
162e : 20 46 16 JSR $1646 ; (isinf.s0 + 0)
1631 : aa __ __ TAX
1632 : a9 01 __ LDA #$01
1634 : 85 48 __ STA T3 + 0 
1636 : 8a __ __ TXA
1637 : d0 03 __ BNE $163c ; (nformf.s158 + 0)
1639 : 4c e3 11 JMP $11e3 ; (nformf.s8 + 0)
.s158:
163c : a9 02 __ LDA #$02
163e : 85 4a __ STA T5 + 0 
1640 : a9 03 __ LDA #$03
1642 : a0 01 __ LDY #$01
1644 : d0 cc __ BNE $1612 ; (nformf.s7 + 0)
--------------------------------------------------------------------
isinf:
.s0:
1646 : 06 0f __ ASL P2 ; (f + 2)
1648 : a5 10 __ LDA P3 ; (f + 3)
164a : 2a __ __ ROL
164b : c9 ff __ CMP #$ff
164d : d0 03 __ BNE $1652 ; (isinf.s1003 + 0)
.s1002:
164f : a9 01 __ LDA #$01
1651 : 60 __ __ RTS
.s1003:
1652 : a9 00 __ LDA #$00
.s1001:
1654 : 60 __ __ RTS
--------------------------------------------------------------------
fround5:
214d : __ __ __ BYT 00 00 00 3f cd cc 4c 3d 0a d7 a3 3b 6f 12 03 3a : ...?..L=...;o..:
215d : __ __ __ BYT 17 b7 51 38 ac c5 a7 36 bd 37 06 35             : ..Q8...6.7.5
--------------------------------------------------------------------
1655 : __ __ __ BYT 1e 53 43 4f 52 45 3a 20 25 64 00                : .SCORE: %d.
--------------------------------------------------------------------
spawn_enemy:
.s0:
1660 : 20 9e 16 JSR $169e ; (rand.s0 + 0)
1663 : 46 1b __ LSR ACCU + 0 
1665 : b0 0f __ BCS $1676 ; (spawn_enemy.s1001 + 0)
.s3:
1667 : a0 00 __ LDY #$00
.l6:
1669 : be 41 21 LDX $2141,y ; (__multab3L + 0)
166c : bd 6f 21 LDA $216f,x ; (Enemy + 2)
166f : f0 06 __ BEQ $1677 ; (spawn_enemy.s9 + 0)
.s7:
1671 : c8 __ __ INY
1672 : c0 0a __ CPY #$0a
1674 : 90 f3 __ BCC $1669 ; (spawn_enemy.l6 + 0)
.s1001:
1676 : 60 __ __ RTS
.s9:
1677 : 86 43 __ STX T0 + 0 
1679 : a9 27 __ LDA #$27
167b : 9d 6d 21 STA $216d,x ; (Enemy + 0)
167e : 20 9e 16 JSR $169e ; (rand.s0 + 0)
1681 : a9 01 __ LDA #$01
1683 : a6 43 __ LDX T0 + 0 
1685 : 9d 6f 21 STA $216f,x ; (Enemy + 2)
1688 : a9 16 __ LDA #$16
168a : 85 03 __ STA WORK + 0 
168c : a9 00 __ LDA #$00
168e : 85 04 __ STA WORK + 1 
1690 : 20 70 1f JSR $1f70 ; (divmod + 0)
1693 : 18 __ __ CLC
1694 : a5 05 __ LDA WORK + 2 
1696 : 69 03 __ ADC #$03
1698 : a6 43 __ LDX T0 + 0 
169a : 9d 6e 21 STA $216e,x ; (Enemy + 1)
169d : 60 __ __ RTS
--------------------------------------------------------------------
rand:
.s0:
169e : ad 6a 21 LDA $216a ; (seed + 1)
16a1 : 4a __ __ LSR
16a2 : ad 69 21 LDA $2169 ; (seed + 0)
16a5 : 6a __ __ ROR
16a6 : aa __ __ TAX
16a7 : a9 00 __ LDA #$00
16a9 : 6a __ __ ROR
16aa : 4d 69 21 EOR $2169 ; (seed + 0)
16ad : 85 1b __ STA ACCU + 0 
16af : 8a __ __ TXA
16b0 : 4d 6a 21 EOR $216a ; (seed + 1)
16b3 : 85 1c __ STA ACCU + 1 
16b5 : 4a __ __ LSR
16b6 : 45 1b __ EOR ACCU + 0 
16b8 : 8d 69 21 STA $2169 ; (seed + 0)
16bb : 85 1b __ STA ACCU + 0 
16bd : 45 1c __ EOR ACCU + 1 
16bf : 8d 6a 21 STA $216a ; (seed + 1)
16c2 : 85 1c __ STA ACCU + 1 
.s1001:
16c4 : 60 __ __ RTS
--------------------------------------------------------------------
seed:
2169 : __ __ __ BYT 00 7a                                           : .z
--------------------------------------------------------------------
move_enemies:
.s1000:
16c5 : a2 03 __ LDX #$03
16c7 : b5 53 __ LDA T0 + 0,x 
16c9 : 9d 9f 9f STA $9f9f,x ; (move_enemies@stack + 0)
16cc : ca __ __ DEX
16cd : 10 f8 __ BPL $16c7 ; (move_enemies.s1000 + 2)
.s0:
16cf : a2 00 __ LDX #$00
.l2:
16d1 : 86 53 __ STX T0 + 0 
16d3 : bc 41 21 LDY $2141,x ; (__multab3L + 0)
16d6 : b9 6f 21 LDA $216f,y ; (Enemy + 2)
16d9 : c9 01 __ CMP #$01
16db : d0 70 __ BNE $174d ; (move_enemies.s33 + 0)
.s5:
16dd : 18 __ __ CLC
16de : a9 6d __ LDA #$6d
16e0 : 7d 41 21 ADC $2141,x ; (__multab3L + 0)
16e3 : 85 54 __ STA T1 + 0 
16e5 : a9 21 __ LDA #$21
16e7 : 69 00 __ ADC #$00
16e9 : 85 55 __ STA T1 + 1 
16eb : a0 01 __ LDY #$01
16ed : b1 54 __ LDA (T1 + 0),y 
16ef : cd 6c 21 CMP $216c ; (Player + 1)
16f2 : d0 10 __ BNE $1704 ; (move_enemies.s10 + 0)
.s8:
16f4 : a5 54 __ LDA T1 + 0 
16f6 : 8d fe 9f STA $9ffe ; (sstack + 8)
16f9 : a5 55 __ LDA T1 + 1 
16fb : 8d ff 9f STA $9fff ; (sstack + 9)
16fe : 20 b4 17 JSR $17b4 ; (spawn_enemy_shot.s1000 + 0)
1701 : 20 64 18 JSR $1864 ; (render_enemy_shots.s0 + 0)
.s10:
1704 : a0 00 __ LDY #$00
1706 : b1 54 __ LDA (T1 + 0),y 
1708 : 85 56 __ STA T3 + 0 
170a : c8 __ __ INY
170b : b1 54 __ LDA (T1 + 0),y 
170d : 0a __ __ ASL
170e : 85 1b __ STA ACCU + 0 
1710 : a9 00 __ LDA #$00
1712 : 2a __ __ ROL
1713 : 06 1b __ ASL ACCU + 0 
1715 : 2a __ __ ROL
1716 : aa __ __ TAX
1717 : a5 1b __ LDA ACCU + 0 
1719 : 71 54 __ ADC (T1 + 0),y 
171b : 85 46 __ STA T5 + 0 
171d : 8a __ __ TXA
171e : 69 00 __ ADC #$00
1720 : 06 46 __ ASL T5 + 0 
1722 : 2a __ __ ROL
1723 : 06 46 __ ASL T5 + 0 
1725 : 2a __ __ ROL
1726 : 06 46 __ ASL T5 + 0 
1728 : 2a __ __ ROL
1729 : aa __ __ TAX
172a : 18 __ __ CLC
172b : a5 46 __ LDA T5 + 0 
172d : 65 56 __ ADC T3 + 0 
172f : 85 43 __ STA T2 + 0 
1731 : 85 1f __ STA ADDR + 0 
1733 : 8a __ __ TXA
1734 : 69 04 __ ADC #$04
1736 : 85 44 __ STA T2 + 1 
1738 : 18 __ __ CLC
1739 : 69 d4 __ ADC #$d4
173b : 85 20 __ STA ADDR + 1 
173d : a9 20 __ LDA #$20
173f : 88 __ __ DEY
1740 : 91 43 __ STA (T2 + 0),y 
1742 : 98 __ __ TYA
1743 : 91 1f __ STA (ADDR + 0),y 
1745 : a5 56 __ LDA T3 + 0 
1747 : d0 19 __ BNE $1762 ; (move_enemies.s11 + 0)
.s12:
1749 : a0 02 __ LDY #$02
.s1012:
174b : 91 54 __ STA (T1 + 0),y 
.s33:
174d : a6 53 __ LDX T0 + 0 
174f : e8 __ __ INX
1750 : e0 0a __ CPX #$0a
1752 : b0 03 __ BCS $1757 ; (move_enemies.s1001 + 0)
1754 : 4c d1 16 JMP $16d1 ; (move_enemies.l2 + 0)
.s1001:
1757 : a2 03 __ LDX #$03
1759 : bd 9f 9f LDA $9f9f,x ; (move_enemies@stack + 0)
175c : 95 53 __ STA T0 + 0,x 
175e : ca __ __ DEX
175f : 10 f8 __ BPL $1759 ; (move_enemies.s1001 + 2)
1761 : 60 __ __ RTS
.s11:
1762 : c6 56 __ DEC T3 + 0 
1764 : a5 56 __ LDA T3 + 0 
1766 : 91 54 __ STA (T1 + 0),y 
1768 : 20 9e 16 JSR $169e ; (rand.s0 + 0)
176b : a0 01 __ LDY #$01
176d : b1 54 __ LDA (T1 + 0),y 
176f : 85 45 __ STA T4 + 0 
1771 : a9 03 __ LDA #$03
1773 : 85 03 __ STA WORK + 0 
1775 : a9 00 __ LDA #$00
1777 : 85 04 __ STA WORK + 1 
1779 : 20 70 1f JSR $1f70 ; (divmod + 0)
177c : 38 __ __ SEC
177d : a5 05 __ LDA WORK + 2 
177f : e9 01 __ SBC #$01
1781 : aa __ __ TAX
1782 : a5 06 __ LDA WORK + 3 
1784 : e9 00 __ SBC #$00
1786 : a8 __ __ TAY
1787 : 8a __ __ TXA
1788 : 18 __ __ CLC
1789 : 65 45 __ ADC T4 + 0 
178b : 85 43 __ STA T2 + 0 
178d : 90 01 __ BCC $1790 ; (move_enemies.s1014 + 0)
.s1013:
178f : c8 __ __ INY
.s1014:
1790 : 0a __ __ ASL
1791 : 0a __ __ ASL
1792 : 18 __ __ CLC
1793 : 65 43 __ ADC T2 + 0 
1795 : 0a __ __ ASL
1796 : 0a __ __ ASL
1797 : 0a __ __ ASL
1798 : 18 __ __ CLC
1799 : 65 56 __ ADC T3 + 0 
179b : aa __ __ TAX
179c : bd 00 04 LDA $0400,x 
179f : c9 58 __ CMP #$58
17a1 : f0 aa __ BEQ $174d ; (move_enemies.s33 + 0)
.s18:
17a3 : 98 __ __ TYA
17a4 : d0 a7 __ BNE $174d ; (move_enemies.s33 + 0)
.s1005:
17a6 : a5 43 __ LDA T2 + 0 
17a8 : c9 03 __ CMP #$03
17aa : 90 a1 __ BCC $174d ; (move_enemies.s33 + 0)
.s1004:
17ac : c9 19 __ CMP #$19
17ae : b0 9d __ BCS $174d ; (move_enemies.s33 + 0)
.s14:
17b0 : a0 01 __ LDY #$01
17b2 : d0 97 __ BNE $174b ; (move_enemies.s1012 + 0)
--------------------------------------------------------------------
spawn_enemy_shot:
.s1000:
17b4 : a5 53 __ LDA T1 + 0 
17b6 : 8d a3 9f STA $9fa3 ; (spawn_enemy_shot@stack + 0)
17b9 : a5 54 __ LDA T3 + 0 
17bb : 8d a4 9f STA $9fa4 ; (spawn_enemy_shot@stack + 1)
17be : 38 __ __ SEC
17bf : a5 23 __ LDA SP + 0 
17c1 : e9 08 __ SBC #$08
17c3 : 85 23 __ STA SP + 0 
17c5 : b0 02 __ BCS $17c9 ; (spawn_enemy_shot.s0 + 0)
17c7 : c6 24 __ DEC SP + 1 
.s0:
17c9 : ad fe 9f LDA $9ffe ; (sstack + 8)
17cc : 85 43 __ STA T0 + 0 
17ce : ad ff 9f LDA $9fff ; (sstack + 9)
17d1 : 85 44 __ STA T0 + 1 
17d3 : a0 00 __ LDY #$00
17d5 : b1 43 __ LDA (T0 + 0),y 
17d7 : f0 0f __ BEQ $17e8 ; (spawn_enemy_shot.s1001 + 0)
.s3:
17d9 : a2 00 __ LDX #$00
.l6:
17db : bc 41 21 LDY $2141,x ; (__multab3L + 0)
17de : b9 96 21 LDA $2196,y ; (EnemyShot + 2)
17e1 : f0 1b __ BEQ $17fe ; (spawn_enemy_shot.s9 + 0)
.s7:
17e3 : e8 __ __ INX
17e4 : e0 03 __ CPX #$03
17e6 : 90 f3 __ BCC $17db ; (spawn_enemy_shot.l6 + 0)
.s1001:
17e8 : 18 __ __ CLC
17e9 : a5 23 __ LDA SP + 0 
17eb : 69 08 __ ADC #$08
17ed : 85 23 __ STA SP + 0 
17ef : 90 02 __ BCC $17f3 ; (spawn_enemy_shot.s1001 + 11)
17f1 : e6 24 __ INC SP + 1 
17f3 : ad a3 9f LDA $9fa3 ; (spawn_enemy_shot@stack + 0)
17f6 : 85 53 __ STA T1 + 0 
17f8 : ad a4 9f LDA $9fa4 ; (spawn_enemy_shot@stack + 1)
17fb : 85 54 __ STA T3 + 0 
17fd : 60 __ __ RTS
.s9:
17fe : a9 14 __ LDA #$14
1800 : 85 0d __ STA P0 
1802 : a9 00 __ LDA #$00
1804 : 85 0e __ STA P1 
1806 : 85 10 __ STA P3 
1808 : a9 01 __ LDA #$01
180a : 85 0f __ STA P2 
180c : 99 96 21 STA $2196,y ; (EnemyShot + 2)
180f : ad fe 9f LDA $9ffe ; (sstack + 8)
1812 : 85 45 __ STA T2 + 0 
1814 : ad ff 9f LDA $9fff ; (sstack + 9)
1817 : 85 46 __ STA T2 + 1 
1819 : a0 00 __ LDY #$00
181b : b1 45 __ LDA (T2 + 0),y 
181d : 38 __ __ SEC
181e : e9 01 __ SBC #$01
1820 : 85 54 __ STA T3 + 0 
1822 : bc 41 21 LDY $2141,x ; (__multab3L + 0)
1825 : 99 94 21 STA $2194,y ; (EnemyShot + 0)
1828 : a0 01 __ LDY #$01
182a : b1 45 __ LDA (T2 + 0),y 
182c : 85 53 __ STA T1 + 0 
182e : bc 41 21 LDY $2141,x ; (__multab3L + 0)
1831 : 99 95 21 STA $2195,y ; (EnemyShot + 1)
1834 : 20 ae 09 JSR $09ae ; (gotoxy.s0 + 0)
1837 : a9 5c __ LDA #$5c
1839 : a0 02 __ LDY #$02
183b : 91 23 __ STA (SP + 0),y 
183d : a9 18 __ LDA #$18
183f : c8 __ __ INY
1840 : 91 23 __ STA (SP + 0),y 
1842 : a5 54 __ LDA T3 + 0 
1844 : c8 __ __ INY
1845 : 91 23 __ STA (SP + 0),y 
1847 : a9 00 __ LDA #$00
1849 : c8 __ __ INY
184a : 91 23 __ STA (SP + 0),y 
184c : a5 53 __ LDA T1 + 0 
184e : c8 __ __ INY
184f : 91 23 __ STA (SP + 0),y 
1851 : a9 00 __ LDA #$00
1853 : c8 __ __ INY
1854 : 91 23 __ STA (SP + 0),y 
1856 : 20 b7 09 JSR $09b7 ; (printf.s0 + 0)
1859 : 4c e8 17 JMP $17e8 ; (spawn_enemy_shot.s1001 + 0)
--------------------------------------------------------------------
185c : __ __ __ BYT 25 64 20 2d 20 25 64 00                         : %d - %d.
--------------------------------------------------------------------
render_enemy_shots:
.s0:
1864 : a2 00 __ LDX #$00
.l1006:
1866 : bc 41 21 LDY $2141,x ; (__multab3L + 0)
1869 : b9 96 21 LDA $2196,y ; (EnemyShot + 2)
186c : c9 01 __ CMP #$01
186e : d0 43 __ BNE $18b3 ; (render_enemy_shots.s19 + 0)
.s5:
1870 : b9 95 21 LDA $2195,y ; (EnemyShot + 1)
1873 : 0a __ __ ASL
1874 : 85 1b __ STA ACCU + 0 
1876 : a9 00 __ LDA #$00
1878 : 2a __ __ ROL
1879 : 06 1b __ ASL ACCU + 0 
187b : 2a __ __ ROL
187c : 85 1c __ STA ACCU + 1 
187e : a5 1b __ LDA ACCU + 0 
1880 : 79 95 21 ADC $2195,y ; (EnemyShot + 1)
1883 : 85 1b __ STA ACCU + 0 
1885 : a5 1c __ LDA ACCU + 1 
1887 : 69 00 __ ADC #$00
1889 : 06 1b __ ASL ACCU + 0 
188b : 2a __ __ ROL
188c : 06 1b __ ASL ACCU + 0 
188e : 2a __ __ ROL
188f : 06 1b __ ASL ACCU + 0 
1891 : 2a __ __ ROL
1892 : 85 1c __ STA ACCU + 1 
1894 : 18 __ __ CLC
1895 : a5 1b __ LDA ACCU + 0 
1897 : 79 94 21 ADC $2194,y ; (EnemyShot + 0)
189a : 85 1b __ STA ACCU + 0 
189c : 85 1f __ STA ADDR + 0 
189e : a5 1c __ LDA ACCU + 1 
18a0 : 69 04 __ ADC #$04
18a2 : 85 1c __ STA ACCU + 1 
18a4 : 18 __ __ CLC
18a5 : 69 d4 __ ADC #$d4
18a7 : 85 20 __ STA ADDR + 1 
18a9 : a9 1f __ LDA #$1f
18ab : a0 00 __ LDY #$00
18ad : 91 1b __ STA (ACCU + 0),y 
18af : a9 01 __ LDA #$01
18b1 : 91 1f __ STA (ADDR + 0),y 
.s19:
18b3 : e8 __ __ INX
18b4 : e0 03 __ CPX #$03
18b6 : 90 ae __ BCC $1866 ; (render_enemy_shots.l1006 + 0)
.s1001:
18b8 : 60 __ __ RTS
--------------------------------------------------------------------
render_enemies:
.s0:
18b9 : a2 00 __ LDX #$00
.l1006:
18bb : bc 41 21 LDY $2141,x ; (__multab3L + 0)
18be : b9 6f 21 LDA $216f,y ; (Enemy + 2)
18c1 : c9 01 __ CMP #$01
18c3 : d0 43 __ BNE $1908 ; (render_enemies.s19 + 0)
.s5:
18c5 : b9 6e 21 LDA $216e,y ; (Enemy + 1)
18c8 : 0a __ __ ASL
18c9 : 85 1b __ STA ACCU + 0 
18cb : a9 00 __ LDA #$00
18cd : 2a __ __ ROL
18ce : 06 1b __ ASL ACCU + 0 
18d0 : 2a __ __ ROL
18d1 : 85 1c __ STA ACCU + 1 
18d3 : a5 1b __ LDA ACCU + 0 
18d5 : 79 6e 21 ADC $216e,y ; (Enemy + 1)
18d8 : 85 1b __ STA ACCU + 0 
18da : a5 1c __ LDA ACCU + 1 
18dc : 69 00 __ ADC #$00
18de : 06 1b __ ASL ACCU + 0 
18e0 : 2a __ __ ROL
18e1 : 06 1b __ ASL ACCU + 0 
18e3 : 2a __ __ ROL
18e4 : 06 1b __ ASL ACCU + 0 
18e6 : 2a __ __ ROL
18e7 : 85 1c __ STA ACCU + 1 
18e9 : 18 __ __ CLC
18ea : a5 1b __ LDA ACCU + 0 
18ec : 79 6d 21 ADC $216d,y ; (Enemy + 0)
18ef : 85 1b __ STA ACCU + 0 
18f1 : 85 1f __ STA ADDR + 0 
18f3 : a5 1c __ LDA ACCU + 1 
18f5 : 69 04 __ ADC #$04
18f7 : 85 1c __ STA ACCU + 1 
18f9 : 18 __ __ CLC
18fa : 69 d4 __ ADC #$d4
18fc : 85 20 __ STA ADDR + 1 
18fe : a9 58 __ LDA #$58
1900 : a0 00 __ LDY #$00
1902 : 91 1b __ STA (ACCU + 0),y 
1904 : a9 08 __ LDA #$08
1906 : 91 1f __ STA (ADDR + 0),y 
.s19:
1908 : e8 __ __ INX
1909 : e0 0a __ CPX #$0a
190b : 90 ae __ BCC $18bb ; (render_enemies.l1006 + 0)
.s1001:
190d : 60 __ __ RTS
--------------------------------------------------------------------
move_enemy_shots:
.s0:
190e : a2 00 __ LDX #$00
.l1008:
1910 : bc 41 21 LDY $2141,x ; (__multab3L + 0)
1913 : b9 96 21 LDA $2196,y ; (EnemyShot + 2)
1916 : c9 01 __ CMP #$01
1918 : d0 58 __ BNE $1972 ; (move_enemy_shots.s23 + 0)
.s5:
191a : 84 1d __ STY ACCU + 2 
191c : b9 95 21 LDA $2195,y ; (EnemyShot + 1)
191f : 0a __ __ ASL
1920 : 85 1b __ STA ACCU + 0 
1922 : a9 00 __ LDA #$00
1924 : 2a __ __ ROL
1925 : 06 1b __ ASL ACCU + 0 
1927 : 2a __ __ ROL
1928 : 85 1c __ STA ACCU + 1 
192a : a5 1b __ LDA ACCU + 0 
192c : 79 95 21 ADC $2195,y ; (EnemyShot + 1)
192f : 85 1b __ STA ACCU + 0 
1931 : a5 1c __ LDA ACCU + 1 
1933 : 69 00 __ ADC #$00
1935 : 06 1b __ ASL ACCU + 0 
1937 : 2a __ __ ROL
1938 : 06 1b __ ASL ACCU + 0 
193a : 2a __ __ ROL
193b : 06 1b __ ASL ACCU + 0 
193d : 2a __ __ ROL
193e : 85 1c __ STA ACCU + 1 
1940 : b9 94 21 LDA $2194,y ; (EnemyShot + 0)
1943 : 85 1e __ STA ACCU + 3 
1945 : 18 __ __ CLC
1946 : 65 1b __ ADC ACCU + 0 
1948 : 85 1b __ STA ACCU + 0 
194a : 85 1f __ STA ADDR + 0 
194c : a5 1c __ LDA ACCU + 1 
194e : 69 04 __ ADC #$04
1950 : 85 1c __ STA ACCU + 1 
1952 : 18 __ __ CLC
1953 : 69 d4 __ ADC #$d4
1955 : 85 20 __ STA ADDR + 1 
1957 : a9 20 __ LDA #$20
1959 : a0 00 __ LDY #$00
195b : 91 1b __ STA (ACCU + 0),y 
195d : 98 __ __ TYA
195e : 91 1f __ STA (ADDR + 0),y 
1960 : c6 1e __ DEC ACCU + 3 
1962 : a5 1e __ LDA ACCU + 3 
1964 : a4 1d __ LDY ACCU + 2 
1966 : 99 94 21 STA $2194,y ; (EnemyShot + 0)
1969 : c9 ff __ CMP #$ff
196b : d0 05 __ BNE $1972 ; (move_enemy_shots.s23 + 0)
.s8:
196d : a9 00 __ LDA #$00
196f : 99 96 21 STA $2196,y ; (EnemyShot + 2)
.s23:
1972 : e8 __ __ INX
1973 : e0 03 __ CPX #$03
1975 : 90 99 __ BCC $1910 ; (move_enemy_shots.l1008 + 0)
.s1001:
1977 : 60 __ __ RTS
--------------------------------------------------------------------
check_player_enemy_collision:
.s0:
1978 : a0 00 __ LDY #$00
.l2:
197a : be 41 21 LDX $2141,y ; (__multab3L + 0)
197d : bd 6f 21 LDA $216f,x ; (Enemy + 2)
1980 : c9 01 __ CMP #$01
1982 : d0 10 __ BNE $1994 ; (check_player_enemy_collision.s3 + 0)
.s5:
1984 : bd 6d 21 LDA $216d,x ; (Enemy + 0)
1987 : cd 6b 21 CMP $216b ; (Player + 0)
198a : d0 08 __ BNE $1994 ; (check_player_enemy_collision.s3 + 0)
.s11:
198c : bd 6e 21 LDA $216e,x ; (Enemy + 1)
198f : cd 6c 21 CMP $216c ; (Player + 1)
1992 : f0 06 __ BEQ $199a ; (check_player_enemy_collision.s8 + 0)
.s3:
1994 : c8 __ __ INY
1995 : c0 0a __ CPY #$0a
1997 : 90 e1 __ BCC $197a ; (check_player_enemy_collision.l2 + 0)
.s1001:
1999 : 60 __ __ RTS
.s8:
199a : a9 01 __ LDA #$01
199c : 8d 9d 21 STA $219d ; (game + 0)
199f : 60 __ __ RTS
--------------------------------------------------------------------
control_player_ship:
.s0:
19a0 : a9 00 __ LDA #$00
19a2 : 20 42 1a JSR $1a42 ; (joy_poll.s0 + 0)
19a5 : ad a4 21 LDA $21a4 ; (joyx + 0)
19a8 : 85 1d __ STA ACCU + 2 
19aa : 85 1e __ STA ACCU + 3 
19ac : d0 08 __ BNE $19b6 ; (control_player_ship.s1 + 0)
.s4:
19ae : ad a2 21 LDA $21a2 ; (joyy + 0)
19b1 : d0 03 __ BNE $19b6 ; (control_player_ship.s1 + 0)
19b3 : 4c 37 1a JMP $1a37 ; (control_player_ship.s3 + 0)
.s1:
19b6 : ad 6b 21 LDA $216b ; (Player + 0)
19b9 : 85 43 __ STA T2 + 0 
19bb : 85 44 __ STA T3 + 0 
19bd : ad 6c 21 LDA $216c ; (Player + 1)
19c0 : 85 45 __ STA T4 + 0 
19c2 : 85 46 __ STA T5 + 0 
19c4 : 0a __ __ ASL
19c5 : 85 1b __ STA ACCU + 0 
19c7 : a9 00 __ LDA #$00
19c9 : 2a __ __ ROL
19ca : 06 1b __ ASL ACCU + 0 
19cc : 2a __ __ ROL
19cd : aa __ __ TAX
19ce : a5 1b __ LDA ACCU + 0 
19d0 : 65 45 __ ADC T4 + 0 
19d2 : 85 1b __ STA ACCU + 0 
19d4 : 8a __ __ TXA
19d5 : 69 00 __ ADC #$00
19d7 : 06 1b __ ASL ACCU + 0 
19d9 : 2a __ __ ROL
19da : 06 1b __ ASL ACCU + 0 
19dc : 2a __ __ ROL
19dd : 06 1b __ ASL ACCU + 0 
19df : 2a __ __ ROL
19e0 : aa __ __ TAX
19e1 : 18 __ __ CLC
19e2 : a5 1b __ LDA ACCU + 0 
19e4 : 65 43 __ ADC T2 + 0 
19e6 : 85 1b __ STA ACCU + 0 
19e8 : 85 1f __ STA ADDR + 0 
19ea : 8a __ __ TXA
19eb : 69 04 __ ADC #$04
19ed : 85 1c __ STA ACCU + 1 
19ef : 18 __ __ CLC
19f0 : 69 d4 __ ADC #$d4
19f2 : 85 20 __ STA ADDR + 1 
19f4 : a9 20 __ LDA #$20
19f6 : a0 00 __ LDY #$00
19f8 : 91 1b __ STA (ACCU + 0),y 
19fa : 98 __ __ TYA
19fb : 91 1f __ STA (ADDR + 0),y 
19fd : a5 43 __ LDA T2 + 0 
19ff : f0 04 __ BEQ $1a05 ; (control_player_ship.s6 + 0)
.s8:
1a01 : a5 1d __ LDA ACCU + 2 
1a03 : 30 0c __ BMI $1a11 ; (control_player_ship.s5 + 0)
.s6:
1a05 : a5 43 __ LDA T2 + 0 
1a07 : c9 27 __ CMP #$27
1a09 : b0 0e __ BCS $1a19 ; (control_player_ship.s7 + 0)
.s12:
1a0b : a5 1d __ LDA ACCU + 2 
1a0d : 30 0a __ BMI $1a19 ; (control_player_ship.s7 + 0)
.s1009:
1a0f : f0 08 __ BEQ $1a19 ; (control_player_ship.s7 + 0)
.s5:
1a11 : 18 __ __ CLC
1a12 : a5 44 __ LDA T3 + 0 
1a14 : 65 1e __ ADC ACCU + 3 
1a16 : 8d 6b 21 STA $216b ; (Player + 0)
.s7:
1a19 : a5 45 __ LDA T4 + 0 
1a1b : c9 04 __ CMP #$04
1a1d : 90 07 __ BCC $1a26 ; (control_player_ship.s14 + 0)
.s16:
1a1f : ad a2 21 LDA $21a2 ; (joyy + 0)
1a22 : 30 0d __ BMI $1a31 ; (control_player_ship.s32 + 0)
.s1012:
1a24 : a5 45 __ LDA T4 + 0 
.s14:
1a26 : c9 18 __ CMP #$18
1a28 : b0 0d __ BCS $1a37 ; (control_player_ship.s3 + 0)
.s20:
1a2a : ad a2 21 LDA $21a2 ; (joyy + 0)
1a2d : 30 08 __ BMI $1a37 ; (control_player_ship.s3 + 0)
.s1004:
1a2f : f0 06 __ BEQ $1a37 ; (control_player_ship.s3 + 0)
.s32:
1a31 : 18 __ __ CLC
1a32 : 65 46 __ ADC T5 + 0 
1a34 : 8d 6c 21 STA $216c ; (Player + 1)
.s3:
1a37 : ad a6 21 LDA $21a6 ; (joyb + 0)
1a3a : c9 01 __ CMP #$01
1a3c : f0 01 __ BEQ $1a3f ; (control_player_ship.s21 + 0)
.s1001:
1a3e : 60 __ __ RTS
.s21:
1a3f : 4c 82 1a JMP $1a82 ; (spawn_player_shot.s0 + 0)
--------------------------------------------------------------------
joy_poll:
.s0:
1a42 : aa __ __ TAX
1a43 : bd 00 dc LDA $dc00,x 
1a46 : a8 __ __ TAY
1a47 : 29 10 __ AND #$10
1a49 : f0 04 __ BEQ $1a4f ; (joy_poll.s1005 + 0)
.s1006:
1a4b : a9 00 __ LDA #$00
1a4d : f0 02 __ BEQ $1a51 ; (joy_poll.s1007 + 0)
.s1005:
1a4f : a9 01 __ LDA #$01
.s1007:
1a51 : 9d a6 21 STA $21a6,x ; (joyb + 0)
1a54 : 98 __ __ TYA
1a55 : 4a __ __ LSR
1a56 : b0 1d __ BCS $1a75 ; (joy_poll.s2 + 0)
.s1:
1a58 : a9 ff __ LDA #$ff
.s15:
1a5a : 9d a2 21 STA $21a2,x ; (joyy + 0)
1a5d : 98 __ __ TYA
1a5e : 29 04 __ AND #$04
1a60 : d0 06 __ BNE $1a68 ; (joy_poll.s8 + 0)
.s7:
1a62 : a9 ff __ LDA #$ff
.s1001:
1a64 : 9d a4 21 STA $21a4,x ; (joyx + 0)
1a67 : 60 __ __ RTS
.s8:
1a68 : 98 __ __ TYA
1a69 : 29 08 __ AND #$08
1a6b : f0 04 __ BEQ $1a71 ; (joy_poll.s1011 + 0)
.s1012:
1a6d : a9 00 __ LDA #$00
1a6f : f0 f3 __ BEQ $1a64 ; (joy_poll.s1001 + 0)
.s1011:
1a71 : a9 01 __ LDA #$01
1a73 : d0 ef __ BNE $1a64 ; (joy_poll.s1001 + 0)
.s2:
1a75 : 98 __ __ TYA
1a76 : 29 02 __ AND #$02
1a78 : f0 04 __ BEQ $1a7e ; (joy_poll.s1008 + 0)
.s1009:
1a7a : a9 00 __ LDA #$00
1a7c : f0 dc __ BEQ $1a5a ; (joy_poll.s15 + 0)
.s1008:
1a7e : a9 01 __ LDA #$01
1a80 : d0 d8 __ BNE $1a5a ; (joy_poll.s15 + 0)
--------------------------------------------------------------------
joyy:
21a2 : __ __ __ BSS	2
--------------------------------------------------------------------
joyx:
21a4 : __ __ __ BSS	2
--------------------------------------------------------------------
joyb:
21a6 : __ __ __ BSS	2
--------------------------------------------------------------------
spawn_player_shot:
.s0:
1a82 : ad 6b 21 LDA $216b ; (Player + 0)
1a85 : c9 27 __ CMP #$27
1a87 : f0 0f __ BEQ $1a98 ; (spawn_player_shot.s1001 + 0)
.s3:
1a89 : a0 00 __ LDY #$00
.l6:
1a8b : be 41 21 LDX $2141,y ; (__multab3L + 0)
1a8e : bd 8d 21 LDA $218d,x ; (PlayerShot + 2)
1a91 : f0 06 __ BEQ $1a99 ; (spawn_player_shot.s9 + 0)
.s7:
1a93 : c8 __ __ INY
1a94 : c0 03 __ CPY #$03
1a96 : 90 f3 __ BCC $1a8b ; (spawn_player_shot.l6 + 0)
.s1001:
1a98 : 60 __ __ RTS
.s9:
1a99 : a9 01 __ LDA #$01
1a9b : 9d 8d 21 STA $218d,x ; (PlayerShot + 2)
1a9e : ad 6c 21 LDA $216c ; (Player + 1)
1aa1 : 9d 8c 21 STA $218c,x ; (PlayerShot + 1)
1aa4 : ad a4 21 LDA $21a4 ; (joyx + 0)
1aa7 : 30 02 __ BMI $1aab ; (spawn_player_shot.s13 + 0)
.s1007:
1aa9 : d0 06 __ BNE $1ab1 ; (spawn_player_shot.s12 + 0)
.s13:
1aab : ad 6b 21 LDA $216b ; (Player + 0)
1aae : 4c b7 1a JMP $1ab7 ; (spawn_player_shot.s1010 + 0)
.s12:
1ab1 : ad 6b 21 LDA $216b ; (Player + 0)
1ab4 : 18 __ __ CLC
1ab5 : 69 01 __ ADC #$01
.s1010:
1ab7 : be 41 21 LDX $2141,y ; (__multab3L + 0)
1aba : 9d 8b 21 STA $218b,x ; (PlayerShot + 0)
1abd : 60 __ __ RTS
--------------------------------------------------------------------
render_player_ship:
.s0:
1abe : ad 6c 21 LDA $216c ; (Player + 1)
1ac1 : 0a __ __ ASL
1ac2 : 85 1b __ STA ACCU + 0 
1ac4 : a9 00 __ LDA #$00
1ac6 : 2a __ __ ROL
1ac7 : 06 1b __ ASL ACCU + 0 
1ac9 : 2a __ __ ROL
1aca : aa __ __ TAX
1acb : a5 1b __ LDA ACCU + 0 
1acd : 6d 6c 21 ADC $216c ; (Player + 1)
1ad0 : 85 1b __ STA ACCU + 0 
1ad2 : 8a __ __ TXA
1ad3 : 69 00 __ ADC #$00
1ad5 : 06 1b __ ASL ACCU + 0 
1ad7 : 2a __ __ ROL
1ad8 : 06 1b __ ASL ACCU + 0 
1ada : 2a __ __ ROL
1adb : 06 1b __ ASL ACCU + 0 
1add : 2a __ __ ROL
1ade : aa __ __ TAX
1adf : 18 __ __ CLC
1ae0 : a5 1b __ LDA ACCU + 0 
1ae2 : 6d 6b 21 ADC $216b ; (Player + 0)
1ae5 : 85 1b __ STA ACCU + 0 
1ae7 : 85 1f __ STA ADDR + 0 
1ae9 : 8a __ __ TXA
1aea : 69 04 __ ADC #$04
1aec : 85 1c __ STA ACCU + 1 
1aee : 18 __ __ CLC
1aef : 69 d4 __ ADC #$d4
1af1 : 85 20 __ STA ADDR + 1 
1af3 : a9 51 __ LDA #$51
1af5 : a0 00 __ LDY #$00
1af7 : 91 1b __ STA (ACCU + 0),y 
1af9 : a9 03 __ LDA #$03
1afb : 91 1f __ STA (ADDR + 0),y 
.s1001:
1afd : 60 __ __ RTS
--------------------------------------------------------------------
move_player_shots:
.s0:
1afe : a2 00 __ LDX #$00
.l2:
1b00 : 86 1d __ STX ACCU + 2 
1b02 : bc 41 21 LDY $2141,x ; (__multab3L + 0)
1b05 : b9 8d 21 LDA $218d,y ; (PlayerShot + 2)
1b08 : c9 01 __ CMP #$01
1b0a : d0 52 __ BNE $1b5e ; (move_player_shots.s23 + 0)
.s5:
1b0c : 84 1e __ STY ACCU + 3 
1b0e : b9 8c 21 LDA $218c,y ; (PlayerShot + 1)
1b11 : 0a __ __ ASL
1b12 : 85 1b __ STA ACCU + 0 
1b14 : a9 00 __ LDA #$00
1b16 : 2a __ __ ROL
1b17 : 06 1b __ ASL ACCU + 0 
1b19 : 2a __ __ ROL
1b1a : aa __ __ TAX
1b1b : a5 1b __ LDA ACCU + 0 
1b1d : 79 8c 21 ADC $218c,y ; (PlayerShot + 1)
1b20 : 85 1b __ STA ACCU + 0 
1b22 : 8a __ __ TXA
1b23 : 69 00 __ ADC #$00
1b25 : 06 1b __ ASL ACCU + 0 
1b27 : 2a __ __ ROL
1b28 : 06 1b __ ASL ACCU + 0 
1b2a : 2a __ __ ROL
1b2b : 06 1b __ ASL ACCU + 0 
1b2d : 2a __ __ ROL
1b2e : 85 1c __ STA ACCU + 1 
1b30 : b9 8b 21 LDA $218b,y ; (PlayerShot + 0)
1b33 : aa __ __ TAX
1b34 : 18 __ __ CLC
1b35 : 65 1b __ ADC ACCU + 0 
1b37 : 85 1b __ STA ACCU + 0 
1b39 : 85 1f __ STA ADDR + 0 
1b3b : a5 1c __ LDA ACCU + 1 
1b3d : 69 04 __ ADC #$04
1b3f : 85 1c __ STA ACCU + 1 
1b41 : 18 __ __ CLC
1b42 : 69 d4 __ ADC #$d4
1b44 : 85 20 __ STA ADDR + 1 
1b46 : a9 20 __ LDA #$20
1b48 : a0 00 __ LDY #$00
1b4a : 91 1b __ STA (ACCU + 0),y 
1b4c : 98 __ __ TYA
1b4d : 91 1f __ STA (ADDR + 0),y 
1b4f : e8 __ __ INX
1b50 : 8a __ __ TXA
1b51 : a6 1e __ LDX ACCU + 3 
1b53 : 9d 8b 21 STA $218b,x ; (PlayerShot + 0)
1b56 : c9 28 __ CMP #$28
1b58 : 90 04 __ BCC $1b5e ; (move_player_shots.s23 + 0)
.s8:
1b5a : 98 __ __ TYA
1b5b : 9d 8d 21 STA $218d,x ; (PlayerShot + 2)
.s23:
1b5e : a6 1d __ LDX ACCU + 2 
1b60 : e8 __ __ INX
1b61 : e0 03 __ CPX #$03
1b63 : 90 9b __ BCC $1b00 ; (move_player_shots.l2 + 0)
.s1001:
1b65 : 60 __ __ RTS
--------------------------------------------------------------------
render_player_shots:
.s0:
1b66 : a2 00 __ LDX #$00
.l1006:
1b68 : bc 41 21 LDY $2141,x ; (__multab3L + 0)
1b6b : b9 8d 21 LDA $218d,y ; (PlayerShot + 2)
1b6e : c9 01 __ CMP #$01
1b70 : d0 43 __ BNE $1bb5 ; (render_player_shots.s19 + 0)
.s5:
1b72 : b9 8c 21 LDA $218c,y ; (PlayerShot + 1)
1b75 : 0a __ __ ASL
1b76 : 85 1b __ STA ACCU + 0 
1b78 : a9 00 __ LDA #$00
1b7a : 2a __ __ ROL
1b7b : 06 1b __ ASL ACCU + 0 
1b7d : 2a __ __ ROL
1b7e : 85 1c __ STA ACCU + 1 
1b80 : a5 1b __ LDA ACCU + 0 
1b82 : 79 8c 21 ADC $218c,y ; (PlayerShot + 1)
1b85 : 85 1b __ STA ACCU + 0 
1b87 : a5 1c __ LDA ACCU + 1 
1b89 : 69 00 __ ADC #$00
1b8b : 06 1b __ ASL ACCU + 0 
1b8d : 2a __ __ ROL
1b8e : 06 1b __ ASL ACCU + 0 
1b90 : 2a __ __ ROL
1b91 : 06 1b __ ASL ACCU + 0 
1b93 : 2a __ __ ROL
1b94 : 85 1c __ STA ACCU + 1 
1b96 : 18 __ __ CLC
1b97 : a5 1b __ LDA ACCU + 0 
1b99 : 79 8b 21 ADC $218b,y ; (PlayerShot + 0)
1b9c : 85 1b __ STA ACCU + 0 
1b9e : 85 1f __ STA ADDR + 0 
1ba0 : a5 1c __ LDA ACCU + 1 
1ba2 : 69 04 __ ADC #$04
1ba4 : 85 1c __ STA ACCU + 1 
1ba6 : 18 __ __ CLC
1ba7 : 69 d4 __ ADC #$d4
1ba9 : 85 20 __ STA ADDR + 1 
1bab : a9 2b __ LDA #$2b
1bad : a0 00 __ LDY #$00
1baf : 91 1b __ STA (ACCU + 0),y 
1bb1 : a9 01 __ LDA #$01
1bb3 : 91 1f __ STA (ADDR + 0),y 
.s19:
1bb5 : e8 __ __ INX
1bb6 : e0 03 __ CPX #$03
1bb8 : 90 ae __ BCC $1b68 ; (render_player_shots.l1006 + 0)
.s1001:
1bba : 60 __ __ RTS
--------------------------------------------------------------------
check_shot_enemy_collision:
.s0:
1bbb : a2 00 __ LDX #$00
.l2:
1bbd : 86 1d __ STX ACCU + 2 
1bbf : bc 41 21 LDY $2141,x ; (__multab3L + 0)
1bc2 : b9 8d 21 LDA $218d,y ; (PlayerShot + 2)
1bc5 : c9 01 __ CMP #$01
1bc7 : f0 03 __ BEQ $1bcc ; (check_shot_enemy_collision.s5 + 0)
1bc9 : 4c 61 1c JMP $1c61 ; (check_shot_enemy_collision.s3 + 0)
.s5:
1bcc : a2 00 __ LDX #$00
.l9:
1bce : 86 43 __ STX T2 + 0 
1bd0 : bc 41 21 LDY $2141,x ; (__multab3L + 0)
1bd3 : 84 1e __ STY ACCU + 3 
1bd5 : b9 6f 21 LDA $216f,y ; (Enemy + 2)
1bd8 : c9 01 __ CMP #$01
1bda : d0 7b __ BNE $1c57 ; (check_shot_enemy_collision.s43 + 0)
.s12:
1bdc : a6 1d __ LDX ACCU + 2 
1bde : bd 41 21 LDA $2141,x ; (__multab3L + 0)
1be1 : 85 44 __ STA T3 + 0 
1be3 : aa __ __ TAX
1be4 : b9 6d 21 LDA $216d,y ; (Enemy + 0)
1be7 : dd 8b 21 CMP $218b,x ; (PlayerShot + 0)
1bea : d0 6b __ BNE $1c57 ; (check_shot_enemy_collision.s43 + 0)
.s18:
1bec : b9 6e 21 LDA $216e,y ; (Enemy + 1)
1bef : dd 8c 21 CMP $218c,x ; (PlayerShot + 1)
1bf2 : d0 63 __ BNE $1c57 ; (check_shot_enemy_collision.s43 + 0)
.s15:
1bf4 : 0a __ __ ASL
1bf5 : 85 1b __ STA ACCU + 0 
1bf7 : a9 00 __ LDA #$00
1bf9 : 2a __ __ ROL
1bfa : 06 1b __ ASL ACCU + 0 
1bfc : 2a __ __ ROL
1bfd : aa __ __ TAX
1bfe : a5 1b __ LDA ACCU + 0 
1c00 : 79 6e 21 ADC $216e,y ; (Enemy + 1)
1c03 : 85 1b __ STA ACCU + 0 
1c05 : 8a __ __ TXA
1c06 : 69 00 __ ADC #$00
1c08 : 06 1b __ ASL ACCU + 0 
1c0a : 2a __ __ ROL
1c0b : 06 1b __ ASL ACCU + 0 
1c0d : 2a __ __ ROL
1c0e : 06 1b __ ASL ACCU + 0 
1c10 : 2a __ __ ROL
1c11 : aa __ __ TAX
1c12 : 18 __ __ CLC
1c13 : a5 1b __ LDA ACCU + 0 
1c15 : 79 6d 21 ADC $216d,y ; (Enemy + 0)
1c18 : 85 1b __ STA ACCU + 0 
1c1a : 85 1f __ STA ADDR + 0 
1c1c : 8a __ __ TXA
1c1d : 69 04 __ ADC #$04
1c1f : 85 1c __ STA ACCU + 1 
1c21 : 18 __ __ CLC
1c22 : 69 d4 __ ADC #$d4
1c24 : 85 20 __ STA ADDR + 1 
1c26 : a9 20 __ LDA #$20
1c28 : a0 00 __ LDY #$00
1c2a : 91 1b __ STA (ACCU + 0),y 
1c2c : 98 __ __ TYA
1c2d : 91 1f __ STA (ADDR + 0),y 
1c2f : a6 1e __ LDX ACCU + 3 
1c31 : 9d 6f 21 STA $216f,x ; (Enemy + 2)
1c34 : a6 44 __ LDX T3 + 0 
1c36 : 9d 8d 21 STA $218d,x ; (PlayerShot + 2)
1c39 : ad 9e 21 LDA $219e ; (game + 1)
1c3c : 18 __ __ CLC
1c3d : 69 01 __ ADC #$01
1c3f : 8d 9e 21 STA $219e ; (game + 1)
1c42 : ad 9f 21 LDA $219f ; (game + 2)
1c45 : 69 00 __ ADC #$00
1c47 : 8d 9f 21 STA $219f ; (game + 2)
1c4a : ad a0 21 LDA $21a0 ; (game + 3)
1c4d : 69 00 __ ADC #$00
1c4f : 8d a0 21 STA $21a0 ; (game + 3)
1c52 : 90 03 __ BCC $1c57 ; (check_shot_enemy_collision.s43 + 0)
.s1014:
1c54 : ee a1 21 INC $21a1 ; (game + 4)
.s43:
1c57 : a6 43 __ LDX T2 + 0 
1c59 : e8 __ __ INX
1c5a : e0 0a __ CPX #$0a
1c5c : b0 03 __ BCS $1c61 ; (check_shot_enemy_collision.s3 + 0)
1c5e : 4c ce 1b JMP $1bce ; (check_shot_enemy_collision.l9 + 0)
.s3:
1c61 : a6 1d __ LDX ACCU + 2 
1c63 : e8 __ __ INX
1c64 : e0 03 __ CPX #$03
1c66 : b0 03 __ BCS $1c6b ; (check_shot_enemy_collision.s1001 + 0)
1c68 : 4c bd 1b JMP $1bbd ; (check_shot_enemy_collision.l2 + 0)
.s1001:
1c6b : 60 __ __ RTS
--------------------------------------------------------------------
wait_frames:
.s0:
1c6c : a5 0e __ LDA P1 ; (frames + 1)
1c6e : 30 1c __ BMI $1c8c ; (wait_frames.s1001 + 0)
.s1005:
1c70 : 05 0d __ ORA P0 ; (frames + 0)
1c72 : f0 18 __ BEQ $1c8c ; (wait_frames.s1001 + 0)
.s13:
1c74 : a0 00 __ LDY #$00
1c76 : a6 0e __ LDX P1 ; (frames + 1)
.l6:
1c78 : ad 11 d0 LDA $d011 
1c7b : 30 fb __ BMI $1c78 ; (wait_frames.l6 + 0)
.l9:
1c7d : ad 11 d0 LDA $d011 
1c80 : 10 fb __ BPL $1c7d ; (wait_frames.l9 + 0)
.s3:
1c82 : c8 __ __ INY
1c83 : 8a __ __ TXA
1c84 : 30 06 __ BMI $1c8c ; (wait_frames.s1001 + 0)
.s1004:
1c86 : d0 f0 __ BNE $1c78 ; (wait_frames.l6 + 0)
.s1002:
1c88 : c4 0d __ CPY P0 ; (frames + 0)
1c8a : 90 ec __ BCC $1c78 ; (wait_frames.l6 + 0)
.s1001:
1c8c : 60 __ __ RTS
--------------------------------------------------------------------
freg:
1c8d : b1 19 __ LDA (IP + 0),y 
1c8f : c8 __ __ INY
1c90 : aa __ __ TAX
1c91 : b5 00 __ LDA $00,x 
1c93 : 85 03 __ STA WORK + 0 
1c95 : b5 01 __ LDA $01,x 
1c97 : 85 04 __ STA WORK + 1 
1c99 : b5 02 __ LDA $02,x 
1c9b : 85 05 __ STA WORK + 2 
1c9d : b5 03 __ LDA WORK + 0,x 
1c9f : 85 06 __ STA WORK + 3 
1ca1 : a5 05 __ LDA WORK + 2 
1ca3 : 0a __ __ ASL
1ca4 : a5 06 __ LDA WORK + 3 
1ca6 : 2a __ __ ROL
1ca7 : 85 08 __ STA WORK + 5 
1ca9 : f0 06 __ BEQ $1cb1 ; (freg + 36)
1cab : a5 05 __ LDA WORK + 2 
1cad : 09 80 __ ORA #$80
1caf : 85 05 __ STA WORK + 2 
1cb1 : a5 1d __ LDA ACCU + 2 
1cb3 : 0a __ __ ASL
1cb4 : a5 1e __ LDA ACCU + 3 
1cb6 : 2a __ __ ROL
1cb7 : 85 07 __ STA WORK + 4 
1cb9 : f0 06 __ BEQ $1cc1 ; (freg + 52)
1cbb : a5 1d __ LDA ACCU + 2 
1cbd : 09 80 __ ORA #$80
1cbf : 85 1d __ STA ACCU + 2 
1cc1 : 60 __ __ RTS
1cc2 : 06 1e __ ASL ACCU + 3 
1cc4 : a5 07 __ LDA WORK + 4 
1cc6 : 6a __ __ ROR
1cc7 : 85 1e __ STA ACCU + 3 
1cc9 : b0 06 __ BCS $1cd1 ; (freg + 68)
1ccb : a5 1d __ LDA ACCU + 2 
1ccd : 29 7f __ AND #$7f
1ccf : 85 1d __ STA ACCU + 2 
1cd1 : 60 __ __ RTS
--------------------------------------------------------------------
faddsub:
1cd2 : a9 ff __ LDA #$ff
1cd4 : c5 07 __ CMP WORK + 4 
1cd6 : f0 04 __ BEQ $1cdc ; (faddsub + 10)
1cd8 : c5 08 __ CMP WORK + 5 
1cda : d0 11 __ BNE $1ced ; (faddsub + 27)
1cdc : a5 1e __ LDA ACCU + 3 
1cde : 09 7f __ ORA #$7f
1ce0 : 85 1e __ STA ACCU + 3 
1ce2 : a9 80 __ LDA #$80
1ce4 : 85 1d __ STA ACCU + 2 
1ce6 : a9 00 __ LDA #$00
1ce8 : 85 1b __ STA ACCU + 0 
1cea : 85 1c __ STA ACCU + 1 
1cec : 60 __ __ RTS
1ced : 38 __ __ SEC
1cee : a5 07 __ LDA WORK + 4 
1cf0 : e5 08 __ SBC WORK + 5 
1cf2 : f0 38 __ BEQ $1d2c ; (faddsub + 90)
1cf4 : aa __ __ TAX
1cf5 : b0 25 __ BCS $1d1c ; (faddsub + 74)
1cf7 : e0 e9 __ CPX #$e9
1cf9 : b0 0e __ BCS $1d09 ; (faddsub + 55)
1cfb : a5 08 __ LDA WORK + 5 
1cfd : 85 07 __ STA WORK + 4 
1cff : a9 00 __ LDA #$00
1d01 : 85 1b __ STA ACCU + 0 
1d03 : 85 1c __ STA ACCU + 1 
1d05 : 85 1d __ STA ACCU + 2 
1d07 : f0 23 __ BEQ $1d2c ; (faddsub + 90)
1d09 : a5 1d __ LDA ACCU + 2 
1d0b : 4a __ __ LSR
1d0c : 66 1c __ ROR ACCU + 1 
1d0e : 66 1b __ ROR ACCU + 0 
1d10 : e8 __ __ INX
1d11 : d0 f8 __ BNE $1d0b ; (faddsub + 57)
1d13 : 85 1d __ STA ACCU + 2 
1d15 : a5 08 __ LDA WORK + 5 
1d17 : 85 07 __ STA WORK + 4 
1d19 : 4c 2c 1d JMP $1d2c ; (faddsub + 90)
1d1c : e0 18 __ CPX #$18
1d1e : b0 33 __ BCS $1d53 ; (faddsub + 129)
1d20 : a5 05 __ LDA WORK + 2 
1d22 : 4a __ __ LSR
1d23 : 66 04 __ ROR WORK + 1 
1d25 : 66 03 __ ROR WORK + 0 
1d27 : ca __ __ DEX
1d28 : d0 f8 __ BNE $1d22 ; (faddsub + 80)
1d2a : 85 05 __ STA WORK + 2 
1d2c : a5 1e __ LDA ACCU + 3 
1d2e : 29 80 __ AND #$80
1d30 : 85 1e __ STA ACCU + 3 
1d32 : 45 06 __ EOR WORK + 3 
1d34 : 30 31 __ BMI $1d67 ; (faddsub + 149)
1d36 : 18 __ __ CLC
1d37 : a5 1b __ LDA ACCU + 0 
1d39 : 65 03 __ ADC WORK + 0 
1d3b : 85 1b __ STA ACCU + 0 
1d3d : a5 1c __ LDA ACCU + 1 
1d3f : 65 04 __ ADC WORK + 1 
1d41 : 85 1c __ STA ACCU + 1 
1d43 : a5 1d __ LDA ACCU + 2 
1d45 : 65 05 __ ADC WORK + 2 
1d47 : 85 1d __ STA ACCU + 2 
1d49 : 90 08 __ BCC $1d53 ; (faddsub + 129)
1d4b : 66 1d __ ROR ACCU + 2 
1d4d : 66 1c __ ROR ACCU + 1 
1d4f : 66 1b __ ROR ACCU + 0 
1d51 : e6 07 __ INC WORK + 4 
1d53 : a5 07 __ LDA WORK + 4 
1d55 : c9 ff __ CMP #$ff
1d57 : f0 83 __ BEQ $1cdc ; (faddsub + 10)
1d59 : 4a __ __ LSR
1d5a : 05 1e __ ORA ACCU + 3 
1d5c : 85 1e __ STA ACCU + 3 
1d5e : b0 06 __ BCS $1d66 ; (faddsub + 148)
1d60 : a5 1d __ LDA ACCU + 2 
1d62 : 29 7f __ AND #$7f
1d64 : 85 1d __ STA ACCU + 2 
1d66 : 60 __ __ RTS
1d67 : 38 __ __ SEC
1d68 : a5 1b __ LDA ACCU + 0 
1d6a : e5 03 __ SBC WORK + 0 
1d6c : 85 1b __ STA ACCU + 0 
1d6e : a5 1c __ LDA ACCU + 1 
1d70 : e5 04 __ SBC WORK + 1 
1d72 : 85 1c __ STA ACCU + 1 
1d74 : a5 1d __ LDA ACCU + 2 
1d76 : e5 05 __ SBC WORK + 2 
1d78 : 85 1d __ STA ACCU + 2 
1d7a : b0 19 __ BCS $1d95 ; (faddsub + 195)
1d7c : 38 __ __ SEC
1d7d : a9 00 __ LDA #$00
1d7f : e5 1b __ SBC ACCU + 0 
1d81 : 85 1b __ STA ACCU + 0 
1d83 : a9 00 __ LDA #$00
1d85 : e5 1c __ SBC ACCU + 1 
1d87 : 85 1c __ STA ACCU + 1 
1d89 : a9 00 __ LDA #$00
1d8b : e5 1d __ SBC ACCU + 2 
1d8d : 85 1d __ STA ACCU + 2 
1d8f : a5 1e __ LDA ACCU + 3 
1d91 : 49 80 __ EOR #$80
1d93 : 85 1e __ STA ACCU + 3 
1d95 : a5 1d __ LDA ACCU + 2 
1d97 : 30 ba __ BMI $1d53 ; (faddsub + 129)
1d99 : 05 1c __ ORA ACCU + 1 
1d9b : 05 1b __ ORA ACCU + 0 
1d9d : f0 0f __ BEQ $1dae ; (faddsub + 220)
1d9f : c6 07 __ DEC WORK + 4 
1da1 : f0 0b __ BEQ $1dae ; (faddsub + 220)
1da3 : 06 1b __ ASL ACCU + 0 
1da5 : 26 1c __ ROL ACCU + 1 
1da7 : 26 1d __ ROL ACCU + 2 
1da9 : 10 f4 __ BPL $1d9f ; (faddsub + 205)
1dab : 4c 53 1d JMP $1d53 ; (faddsub + 129)
1dae : a9 00 __ LDA #$00
1db0 : 85 1b __ STA ACCU + 0 
1db2 : 85 1c __ STA ACCU + 1 
1db4 : 85 1d __ STA ACCU + 2 
1db6 : 85 1e __ STA ACCU + 3 
1db8 : 60 __ __ RTS
--------------------------------------------------------------------
fmul:
1db9 : a5 1b __ LDA ACCU + 0 
1dbb : 05 1c __ ORA ACCU + 1 
1dbd : 05 1d __ ORA ACCU + 2 
1dbf : d0 03 __ BNE $1dc4 ; (fmul + 11)
1dc1 : 85 1e __ STA ACCU + 3 
1dc3 : 60 __ __ RTS
1dc4 : a5 03 __ LDA WORK + 0 
1dc6 : 05 04 __ ORA WORK + 1 
1dc8 : 05 05 __ ORA WORK + 2 
1dca : d0 09 __ BNE $1dd5 ; (fmul + 28)
1dcc : 85 1b __ STA ACCU + 0 
1dce : 85 1c __ STA ACCU + 1 
1dd0 : 85 1d __ STA ACCU + 2 
1dd2 : 85 1e __ STA ACCU + 3 
1dd4 : 60 __ __ RTS
1dd5 : a5 1e __ LDA ACCU + 3 
1dd7 : 45 06 __ EOR WORK + 3 
1dd9 : 29 80 __ AND #$80
1ddb : 85 1e __ STA ACCU + 3 
1ddd : a9 ff __ LDA #$ff
1ddf : c5 07 __ CMP WORK + 4 
1de1 : f0 42 __ BEQ $1e25 ; (fmul + 108)
1de3 : c5 08 __ CMP WORK + 5 
1de5 : f0 3e __ BEQ $1e25 ; (fmul + 108)
1de7 : a9 00 __ LDA #$00
1de9 : 85 09 __ STA WORK + 6 
1deb : 85 0a __ STA WORK + 7 
1ded : 85 0b __ STA $0b 
1def : a4 1b __ LDY ACCU + 0 
1df1 : a5 03 __ LDA WORK + 0 
1df3 : d0 06 __ BNE $1dfb ; (fmul + 66)
1df5 : a5 04 __ LDA WORK + 1 
1df7 : f0 0a __ BEQ $1e03 ; (fmul + 74)
1df9 : d0 05 __ BNE $1e00 ; (fmul + 71)
1dfb : 20 5a 1e JSR $1e5a ; (fmul8 + 0)
1dfe : a5 04 __ LDA WORK + 1 
1e00 : 20 5a 1e JSR $1e5a ; (fmul8 + 0)
1e03 : a5 05 __ LDA WORK + 2 
1e05 : 20 5a 1e JSR $1e5a ; (fmul8 + 0)
1e08 : 38 __ __ SEC
1e09 : a5 0b __ LDA $0b 
1e0b : 30 06 __ BMI $1e13 ; (fmul + 90)
1e0d : 06 09 __ ASL WORK + 6 
1e0f : 26 0a __ ROL WORK + 7 
1e11 : 2a __ __ ROL
1e12 : 18 __ __ CLC
1e13 : 29 7f __ AND #$7f
1e15 : 85 0b __ STA $0b 
1e17 : a5 07 __ LDA WORK + 4 
1e19 : 65 08 __ ADC WORK + 5 
1e1b : 90 19 __ BCC $1e36 ; (fmul + 125)
1e1d : e9 7f __ SBC #$7f
1e1f : b0 04 __ BCS $1e25 ; (fmul + 108)
1e21 : c9 ff __ CMP #$ff
1e23 : d0 15 __ BNE $1e3a ; (fmul + 129)
1e25 : a5 1e __ LDA ACCU + 3 
1e27 : 09 7f __ ORA #$7f
1e29 : 85 1e __ STA ACCU + 3 
1e2b : a9 80 __ LDA #$80
1e2d : 85 1d __ STA ACCU + 2 
1e2f : a9 00 __ LDA #$00
1e31 : 85 1b __ STA ACCU + 0 
1e33 : 85 1c __ STA ACCU + 1 
1e35 : 60 __ __ RTS
1e36 : e9 7e __ SBC #$7e
1e38 : 90 15 __ BCC $1e4f ; (fmul + 150)
1e3a : 4a __ __ LSR
1e3b : 05 1e __ ORA ACCU + 3 
1e3d : 85 1e __ STA ACCU + 3 
1e3f : a9 00 __ LDA #$00
1e41 : 6a __ __ ROR
1e42 : 05 0b __ ORA $0b 
1e44 : 85 1d __ STA ACCU + 2 
1e46 : a5 0a __ LDA WORK + 7 
1e48 : 85 1c __ STA ACCU + 1 
1e4a : a5 09 __ LDA WORK + 6 
1e4c : 85 1b __ STA ACCU + 0 
1e4e : 60 __ __ RTS
1e4f : a9 00 __ LDA #$00
1e51 : 85 1b __ STA ACCU + 0 
1e53 : 85 1c __ STA ACCU + 1 
1e55 : 85 1d __ STA ACCU + 2 
1e57 : 85 1e __ STA ACCU + 3 
1e59 : 60 __ __ RTS
--------------------------------------------------------------------
fmul8:
1e5a : 38 __ __ SEC
1e5b : 6a __ __ ROR
1e5c : 90 1e __ BCC $1e7c ; (fmul8 + 34)
1e5e : aa __ __ TAX
1e5f : 18 __ __ CLC
1e60 : 98 __ __ TYA
1e61 : 65 09 __ ADC WORK + 6 
1e63 : 85 09 __ STA WORK + 6 
1e65 : a5 0a __ LDA WORK + 7 
1e67 : 65 1c __ ADC ACCU + 1 
1e69 : 85 0a __ STA WORK + 7 
1e6b : a5 0b __ LDA $0b 
1e6d : 65 1d __ ADC ACCU + 2 
1e6f : 6a __ __ ROR
1e70 : 85 0b __ STA $0b 
1e72 : 8a __ __ TXA
1e73 : 66 0a __ ROR WORK + 7 
1e75 : 66 09 __ ROR WORK + 6 
1e77 : 4a __ __ LSR
1e78 : f0 0d __ BEQ $1e87 ; (fmul8 + 45)
1e7a : b0 e2 __ BCS $1e5e ; (fmul8 + 4)
1e7c : 66 0b __ ROR $0b 
1e7e : 66 0a __ ROR WORK + 7 
1e80 : 66 09 __ ROR WORK + 6 
1e82 : 4a __ __ LSR
1e83 : 90 f7 __ BCC $1e7c ; (fmul8 + 34)
1e85 : d0 d7 __ BNE $1e5e ; (fmul8 + 4)
1e87 : 60 __ __ RTS
--------------------------------------------------------------------
fdiv:
1e88 : a5 1b __ LDA ACCU + 0 
1e8a : 05 1c __ ORA ACCU + 1 
1e8c : 05 1d __ ORA ACCU + 2 
1e8e : d0 03 __ BNE $1e93 ; (fdiv + 11)
1e90 : 85 1e __ STA ACCU + 3 
1e92 : 60 __ __ RTS
1e93 : a5 1e __ LDA ACCU + 3 
1e95 : 45 06 __ EOR WORK + 3 
1e97 : 29 80 __ AND #$80
1e99 : 85 1e __ STA ACCU + 3 
1e9b : a5 08 __ LDA WORK + 5 
1e9d : f0 62 __ BEQ $1f01 ; (fdiv + 121)
1e9f : a5 07 __ LDA WORK + 4 
1ea1 : c9 ff __ CMP #$ff
1ea3 : f0 5c __ BEQ $1f01 ; (fdiv + 121)
1ea5 : a9 00 __ LDA #$00
1ea7 : 85 09 __ STA WORK + 6 
1ea9 : 85 0a __ STA WORK + 7 
1eab : 85 0b __ STA $0b 
1ead : a2 18 __ LDX #$18
1eaf : a5 1b __ LDA ACCU + 0 
1eb1 : c5 03 __ CMP WORK + 0 
1eb3 : a5 1c __ LDA ACCU + 1 
1eb5 : e5 04 __ SBC WORK + 1 
1eb7 : a5 1d __ LDA ACCU + 2 
1eb9 : e5 05 __ SBC WORK + 2 
1ebb : 90 13 __ BCC $1ed0 ; (fdiv + 72)
1ebd : a5 1b __ LDA ACCU + 0 
1ebf : e5 03 __ SBC WORK + 0 
1ec1 : 85 1b __ STA ACCU + 0 
1ec3 : a5 1c __ LDA ACCU + 1 
1ec5 : e5 04 __ SBC WORK + 1 
1ec7 : 85 1c __ STA ACCU + 1 
1ec9 : a5 1d __ LDA ACCU + 2 
1ecb : e5 05 __ SBC WORK + 2 
1ecd : 85 1d __ STA ACCU + 2 
1ecf : 38 __ __ SEC
1ed0 : 26 09 __ ROL WORK + 6 
1ed2 : 26 0a __ ROL WORK + 7 
1ed4 : 26 0b __ ROL $0b 
1ed6 : ca __ __ DEX
1ed7 : f0 0a __ BEQ $1ee3 ; (fdiv + 91)
1ed9 : 06 1b __ ASL ACCU + 0 
1edb : 26 1c __ ROL ACCU + 1 
1edd : 26 1d __ ROL ACCU + 2 
1edf : b0 dc __ BCS $1ebd ; (fdiv + 53)
1ee1 : 90 cc __ BCC $1eaf ; (fdiv + 39)
1ee3 : 38 __ __ SEC
1ee4 : a5 0b __ LDA $0b 
1ee6 : 30 06 __ BMI $1eee ; (fdiv + 102)
1ee8 : 06 09 __ ASL WORK + 6 
1eea : 26 0a __ ROL WORK + 7 
1eec : 2a __ __ ROL
1eed : 18 __ __ CLC
1eee : 29 7f __ AND #$7f
1ef0 : 85 0b __ STA $0b 
1ef2 : a5 07 __ LDA WORK + 4 
1ef4 : e5 08 __ SBC WORK + 5 
1ef6 : 90 1a __ BCC $1f12 ; (fdiv + 138)
1ef8 : 18 __ __ CLC
1ef9 : 69 7f __ ADC #$7f
1efb : b0 04 __ BCS $1f01 ; (fdiv + 121)
1efd : c9 ff __ CMP #$ff
1eff : d0 15 __ BNE $1f16 ; (fdiv + 142)
1f01 : a5 1e __ LDA ACCU + 3 
1f03 : 09 7f __ ORA #$7f
1f05 : 85 1e __ STA ACCU + 3 
1f07 : a9 80 __ LDA #$80
1f09 : 85 1d __ STA ACCU + 2 
1f0b : a9 00 __ LDA #$00
1f0d : 85 1c __ STA ACCU + 1 
1f0f : 85 1b __ STA ACCU + 0 
1f11 : 60 __ __ RTS
1f12 : 69 7f __ ADC #$7f
1f14 : 90 15 __ BCC $1f2b ; (fdiv + 163)
1f16 : 4a __ __ LSR
1f17 : 05 1e __ ORA ACCU + 3 
1f19 : 85 1e __ STA ACCU + 3 
1f1b : a9 00 __ LDA #$00
1f1d : 6a __ __ ROR
1f1e : 05 0b __ ORA $0b 
1f20 : 85 1d __ STA ACCU + 2 
1f22 : a5 0a __ LDA WORK + 7 
1f24 : 85 1c __ STA ACCU + 1 
1f26 : a5 09 __ LDA WORK + 6 
1f28 : 85 1b __ STA ACCU + 0 
1f2a : 60 __ __ RTS
1f2b : a9 00 __ LDA #$00
1f2d : 85 1e __ STA ACCU + 3 
1f2f : 85 1d __ STA ACCU + 2 
1f31 : 85 1c __ STA ACCU + 1 
1f33 : 85 1b __ STA ACCU + 0 
1f35 : 60 __ __ RTS
--------------------------------------------------------------------
divs16:
1f36 : 24 1c __ BIT ACCU + 1 
1f38 : 10 0d __ BPL $1f47 ; (divs16 + 17)
1f3a : 20 54 1f JSR $1f54 ; (negaccu + 0)
1f3d : 24 04 __ BIT WORK + 1 
1f3f : 10 0d __ BPL $1f4e ; (divs16 + 24)
1f41 : 20 62 1f JSR $1f62 ; (negtmp + 0)
1f44 : 4c 70 1f JMP $1f70 ; (divmod + 0)
1f47 : 24 04 __ BIT WORK + 1 
1f49 : 10 f9 __ BPL $1f44 ; (divs16 + 14)
1f4b : 20 62 1f JSR $1f62 ; (negtmp + 0)
1f4e : 20 70 1f JSR $1f70 ; (divmod + 0)
1f51 : 4c 54 1f JMP $1f54 ; (negaccu + 0)
--------------------------------------------------------------------
negaccu:
1f54 : 38 __ __ SEC
1f55 : a9 00 __ LDA #$00
1f57 : e5 1b __ SBC ACCU + 0 
1f59 : 85 1b __ STA ACCU + 0 
1f5b : a9 00 __ LDA #$00
1f5d : e5 1c __ SBC ACCU + 1 
1f5f : 85 1c __ STA ACCU + 1 
1f61 : 60 __ __ RTS
--------------------------------------------------------------------
negtmp:
1f62 : 38 __ __ SEC
1f63 : a9 00 __ LDA #$00
1f65 : e5 03 __ SBC WORK + 0 
1f67 : 85 03 __ STA WORK + 0 
1f69 : a9 00 __ LDA #$00
1f6b : e5 04 __ SBC WORK + 1 
1f6d : 85 04 __ STA WORK + 1 
1f6f : 60 __ __ RTS
--------------------------------------------------------------------
divmod:
1f70 : a5 1c __ LDA ACCU + 1 
1f72 : d0 31 __ BNE $1fa5 ; (divmod + 53)
1f74 : a5 04 __ LDA WORK + 1 
1f76 : d0 1e __ BNE $1f96 ; (divmod + 38)
1f78 : 85 06 __ STA WORK + 3 
1f7a : a2 04 __ LDX #$04
1f7c : 06 1b __ ASL ACCU + 0 
1f7e : 2a __ __ ROL
1f7f : c5 03 __ CMP WORK + 0 
1f81 : 90 02 __ BCC $1f85 ; (divmod + 21)
1f83 : e5 03 __ SBC WORK + 0 
1f85 : 26 1b __ ROL ACCU + 0 
1f87 : 2a __ __ ROL
1f88 : c5 03 __ CMP WORK + 0 
1f8a : 90 02 __ BCC $1f8e ; (divmod + 30)
1f8c : e5 03 __ SBC WORK + 0 
1f8e : 26 1b __ ROL ACCU + 0 
1f90 : ca __ __ DEX
1f91 : d0 eb __ BNE $1f7e ; (divmod + 14)
1f93 : 85 05 __ STA WORK + 2 
1f95 : 60 __ __ RTS
1f96 : a5 1b __ LDA ACCU + 0 
1f98 : 85 05 __ STA WORK + 2 
1f9a : a5 1c __ LDA ACCU + 1 
1f9c : 85 06 __ STA WORK + 3 
1f9e : a9 00 __ LDA #$00
1fa0 : 85 1b __ STA ACCU + 0 
1fa2 : 85 1c __ STA ACCU + 1 
1fa4 : 60 __ __ RTS
1fa5 : a5 04 __ LDA WORK + 1 
1fa7 : d0 1f __ BNE $1fc8 ; (divmod + 88)
1fa9 : a5 03 __ LDA WORK + 0 
1fab : 30 1b __ BMI $1fc8 ; (divmod + 88)
1fad : a9 00 __ LDA #$00
1faf : 85 06 __ STA WORK + 3 
1fb1 : a2 10 __ LDX #$10
1fb3 : 06 1b __ ASL ACCU + 0 
1fb5 : 26 1c __ ROL ACCU + 1 
1fb7 : 2a __ __ ROL
1fb8 : c5 03 __ CMP WORK + 0 
1fba : 90 02 __ BCC $1fbe ; (divmod + 78)
1fbc : e5 03 __ SBC WORK + 0 
1fbe : 26 1b __ ROL ACCU + 0 
1fc0 : 26 1c __ ROL ACCU + 1 
1fc2 : ca __ __ DEX
1fc3 : d0 f2 __ BNE $1fb7 ; (divmod + 71)
1fc5 : 85 05 __ STA WORK + 2 
1fc7 : 60 __ __ RTS
1fc8 : a9 00 __ LDA #$00
1fca : 85 05 __ STA WORK + 2 
1fcc : 85 06 __ STA WORK + 3 
1fce : 84 02 __ STY $02 
1fd0 : a0 10 __ LDY #$10
1fd2 : 18 __ __ CLC
1fd3 : 26 1b __ ROL ACCU + 0 
1fd5 : 26 1c __ ROL ACCU + 1 
1fd7 : 26 05 __ ROL WORK + 2 
1fd9 : 26 06 __ ROL WORK + 3 
1fdb : 38 __ __ SEC
1fdc : a5 05 __ LDA WORK + 2 
1fde : e5 03 __ SBC WORK + 0 
1fe0 : aa __ __ TAX
1fe1 : a5 06 __ LDA WORK + 3 
1fe3 : e5 04 __ SBC WORK + 1 
1fe5 : 90 04 __ BCC $1feb ; (divmod + 123)
1fe7 : 86 05 __ STX WORK + 2 
1fe9 : 85 06 __ STA WORK + 3 
1feb : 88 __ __ DEY
1fec : d0 e5 __ BNE $1fd3 ; (divmod + 99)
1fee : 26 1b __ ROL ACCU + 0 
1ff0 : 26 1c __ ROL ACCU + 1 
1ff2 : a4 02 __ LDY $02 
1ff4 : 60 __ __ RTS
--------------------------------------------------------------------
mods16:
1ff5 : 24 1c __ BIT ACCU + 1 
1ff7 : 10 0d __ BPL $2006 ; (mods16 + 17)
1ff9 : 20 54 1f JSR $1f54 ; (negaccu + 0)
1ffc : 24 04 __ BIT WORK + 1 
1ffe : 10 0d __ BPL $200d ; (mods16 + 24)
2000 : 20 62 1f JSR $1f62 ; (negtmp + 0)
2003 : 4c 70 1f JMP $1f70 ; (divmod + 0)
2006 : 24 04 __ BIT WORK + 1 
2008 : 10 f9 __ BPL $2003 ; (mods16 + 14)
200a : 20 62 1f JSR $1f62 ; (negtmp + 0)
200d : 20 70 1f JSR $1f70 ; (divmod + 0)
2010 : 38 __ __ SEC
2011 : a9 00 __ LDA #$00
2013 : e5 05 __ SBC WORK + 2 
2015 : 85 05 __ STA WORK + 2 
2017 : a9 00 __ LDA #$00
2019 : e5 06 __ SBC WORK + 3 
201b : 85 06 __ STA WORK + 3 
201d : 60 __ __ RTS
--------------------------------------------------------------------
f32_to_i16:
201e : 20 b1 1c JSR $1cb1 ; (freg + 36)
2021 : a5 07 __ LDA WORK + 4 
2023 : c9 7f __ CMP #$7f
2025 : b0 07 __ BCS $202e ; (f32_to_i16 + 16)
2027 : a9 00 __ LDA #$00
2029 : 85 1b __ STA ACCU + 0 
202b : 85 1c __ STA ACCU + 1 
202d : 60 __ __ RTS
202e : 38 __ __ SEC
202f : e9 8e __ SBC #$8e
2031 : 90 0a __ BCC $203d ; (f32_to_i16 + 31)
2033 : a9 ff __ LDA #$ff
2035 : 85 1b __ STA ACCU + 0 
2037 : a9 7f __ LDA #$7f
2039 : 85 1c __ STA ACCU + 1 
203b : d0 08 __ BNE $2045 ; (f32_to_i16 + 39)
203d : aa __ __ TAX
203e : 46 1d __ LSR ACCU + 2 
2040 : 66 1c __ ROR ACCU + 1 
2042 : e8 __ __ INX
2043 : d0 f9 __ BNE $203e ; (f32_to_i16 + 32)
2045 : 24 1e __ BIT ACCU + 3 
2047 : 10 0e __ BPL $2057 ; (f32_to_i16 + 57)
2049 : 38 __ __ SEC
204a : a9 00 __ LDA #$00
204c : e5 1c __ SBC ACCU + 1 
204e : 85 1b __ STA ACCU + 0 
2050 : a9 00 __ LDA #$00
2052 : e5 1d __ SBC ACCU + 2 
2054 : 85 1c __ STA ACCU + 1 
2056 : 60 __ __ RTS
2057 : a5 1c __ LDA ACCU + 1 
2059 : 85 1b __ STA ACCU + 0 
205b : a5 1d __ LDA ACCU + 2 
205d : 85 1c __ STA ACCU + 1 
205f : 60 __ __ RTS
--------------------------------------------------------------------
sint16_to_float:
2060 : 24 1c __ BIT ACCU + 1 
2062 : 30 03 __ BMI $2067 ; (sint16_to_float + 7)
2064 : 4c 7e 20 JMP $207e ; (uint16_to_float + 0)
2067 : 38 __ __ SEC
2068 : a9 00 __ LDA #$00
206a : e5 1b __ SBC ACCU + 0 
206c : 85 1b __ STA ACCU + 0 
206e : a9 00 __ LDA #$00
2070 : e5 1c __ SBC ACCU + 1 
2072 : 85 1c __ STA ACCU + 1 
2074 : 20 7e 20 JSR $207e ; (uint16_to_float + 0)
2077 : a5 1e __ LDA ACCU + 3 
2079 : 09 80 __ ORA #$80
207b : 85 1e __ STA ACCU + 3 
207d : 60 __ __ RTS
--------------------------------------------------------------------
uint16_to_float:
207e : a5 1b __ LDA ACCU + 0 
2080 : 05 1c __ ORA ACCU + 1 
2082 : d0 05 __ BNE $2089 ; (uint16_to_float + 11)
2084 : 85 1d __ STA ACCU + 2 
2086 : 85 1e __ STA ACCU + 3 
2088 : 60 __ __ RTS
2089 : a2 8e __ LDX #$8e
208b : a5 1c __ LDA ACCU + 1 
208d : 30 06 __ BMI $2095 ; (uint16_to_float + 23)
208f : ca __ __ DEX
2090 : 06 1b __ ASL ACCU + 0 
2092 : 2a __ __ ROL
2093 : 10 fa __ BPL $208f ; (uint16_to_float + 17)
2095 : 29 7f __ AND #$7f
2097 : 85 1d __ STA ACCU + 2 
2099 : a5 1b __ LDA ACCU + 0 
209b : 85 1c __ STA ACCU + 1 
209d : 8a __ __ TXA
209e : 4a __ __ LSR
209f : 85 1e __ STA ACCU + 3 
20a1 : a9 00 __ LDA #$00
20a3 : 85 1b __ STA ACCU + 0 
20a5 : 6a __ __ ROR
20a6 : 05 1d __ ORA ACCU + 2 
20a8 : 85 1d __ STA ACCU + 2 
20aa : 60 __ __ RTS
--------------------------------------------------------------------
divmod32:
20ab : 84 02 __ STY $02 
20ad : a0 20 __ LDY #$20
20af : a9 00 __ LDA #$00
20b1 : 85 07 __ STA WORK + 4 
20b3 : 85 08 __ STA WORK + 5 
20b5 : 85 09 __ STA WORK + 6 
20b7 : 85 0a __ STA WORK + 7 
20b9 : a5 05 __ LDA WORK + 2 
20bb : 05 06 __ ORA WORK + 3 
20bd : d0 39 __ BNE $20f8 ; (divmod32 + 77)
20bf : 18 __ __ CLC
20c0 : 26 1b __ ROL ACCU + 0 
20c2 : 26 1c __ ROL ACCU + 1 
20c4 : 26 1d __ ROL ACCU + 2 
20c6 : 26 1e __ ROL ACCU + 3 
20c8 : 26 07 __ ROL WORK + 4 
20ca : 26 08 __ ROL WORK + 5 
20cc : 90 0c __ BCC $20da ; (divmod32 + 47)
20ce : a5 07 __ LDA WORK + 4 
20d0 : e5 03 __ SBC WORK + 0 
20d2 : aa __ __ TAX
20d3 : a5 08 __ LDA WORK + 5 
20d5 : e5 04 __ SBC WORK + 1 
20d7 : 38 __ __ SEC
20d8 : b0 0c __ BCS $20e6 ; (divmod32 + 59)
20da : 38 __ __ SEC
20db : a5 07 __ LDA WORK + 4 
20dd : e5 03 __ SBC WORK + 0 
20df : aa __ __ TAX
20e0 : a5 08 __ LDA WORK + 5 
20e2 : e5 04 __ SBC WORK + 1 
20e4 : 90 04 __ BCC $20ea ; (divmod32 + 63)
20e6 : 86 07 __ STX WORK + 4 
20e8 : 85 08 __ STA WORK + 5 
20ea : 88 __ __ DEY
20eb : d0 d3 __ BNE $20c0 ; (divmod32 + 21)
20ed : 26 1b __ ROL ACCU + 0 
20ef : 26 1c __ ROL ACCU + 1 
20f1 : 26 1d __ ROL ACCU + 2 
20f3 : 26 1e __ ROL ACCU + 3 
20f5 : a4 02 __ LDY $02 
20f7 : 60 __ __ RTS
20f8 : 18 __ __ CLC
20f9 : 26 1b __ ROL ACCU + 0 
20fb : 26 1c __ ROL ACCU + 1 
20fd : 26 1d __ ROL ACCU + 2 
20ff : 26 1e __ ROL ACCU + 3 
2101 : 26 07 __ ROL WORK + 4 
2103 : 26 08 __ ROL WORK + 5 
2105 : 26 09 __ ROL WORK + 6 
2107 : 26 0a __ ROL WORK + 7 
2109 : a5 07 __ LDA WORK + 4 
210b : c5 03 __ CMP WORK + 0 
210d : a5 08 __ LDA WORK + 5 
210f : e5 04 __ SBC WORK + 1 
2111 : a5 09 __ LDA WORK + 6 
2113 : e5 05 __ SBC WORK + 2 
2115 : a5 0a __ LDA WORK + 7 
2117 : e5 06 __ SBC WORK + 3 
2119 : 90 18 __ BCC $2133 ; (divmod32 + 136)
211b : a5 07 __ LDA WORK + 4 
211d : e5 03 __ SBC WORK + 0 
211f : 85 07 __ STA WORK + 4 
2121 : a5 08 __ LDA WORK + 5 
2123 : e5 04 __ SBC WORK + 1 
2125 : 85 08 __ STA WORK + 5 
2127 : a5 09 __ LDA WORK + 6 
2129 : e5 05 __ SBC WORK + 2 
212b : 85 09 __ STA WORK + 6 
212d : a5 0a __ LDA WORK + 7 
212f : e5 06 __ SBC WORK + 3 
2131 : 85 0a __ STA WORK + 7 
2133 : 88 __ __ DEY
2134 : d0 c3 __ BNE $20f9 ; (divmod32 + 78)
2136 : 26 1b __ ROL ACCU + 0 
2138 : 26 1c __ ROL ACCU + 1 
213a : 26 1d __ ROL ACCU + 2 
213c : 26 1e __ ROL ACCU + 3 
213e : a4 02 __ LDY $02 
2140 : 60 __ __ RTS
--------------------------------------------------------------------
__multab3L:
2141 : __ __ __ BYT 00 03 06 09 0c 0f 12 15 18 1b                   : ..........
