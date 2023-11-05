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
080e : 8e 78 21 STX $2178 ; (spentry + 0)
0811 : a9 98 __ LDA #$98
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
0830 : a9 d5 __ LDA #$d5
0832 : e9 98 __ SBC #$98
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
2178 : __ __ __ BYT 00                                              : .
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
0894 : ad ca 21 LDA $21ca ; (game + 0)
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
08ac : 20 9d 1f JSR $1f9d ; (divmod + 0)
08af : a5 05 __ LDA WORK + 2 
08b1 : 05 06 __ ORA WORK + 3 
08b3 : d0 09 __ BNE $08be ; (main.s7 + 0)
.s5:
08b5 : 20 62 16 JSR $1662 ; (spawn_enemy.s0 + 0)
08b8 : 20 c7 16 JSR $16c7 ; (move_enemies.s1000 + 0)
08bb : 20 bb 18 JSR $18bb ; (render_enemies.s0 + 0)
.s7:
08be : 20 10 19 JSR $1910 ; (move_enemy_shots.s0 + 0)
08c1 : 20 66 18 JSR $1866 ; (render_enemy_shots.s0 + 0)
08c4 : 20 7a 19 JSR $197a ; (check_player_enemy_collision.s0 + 0)
08c7 : 20 ca 19 JSR $19ca ; (control_player_ship.s0 + 0)
08ca : 20 e8 1a JSR $1ae8 ; (render_player_ship.s0 + 0)
08cd : 20 7a 19 JSR $197a ; (check_player_enemy_collision.s0 + 0)
08d0 : 20 28 1b JSR $1b28 ; (move_player_shots.s0 + 0)
08d3 : 20 90 1b JSR $1b90 ; (render_player_shots.s0 + 0)
08d6 : 20 e5 1b JSR $1be5 ; (check_shot_enemy_collision.s0 + 0)
08d9 : a9 03 __ LDA #$03
08db : 85 0d __ STA P0 
08dd : a9 00 __ LDA #$00
08df : 85 0e __ STA P1 
08e1 : 20 99 1c JSR $1c99 ; (wait_frames.s0 + 0)
08e4 : e6 53 __ INC T0 + 0 
08e6 : ad ca 21 LDA $21ca ; (game + 0)
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
08f9 : 8d 98 21 STA $2198 ; (Player + 0)
08fc : a9 0c __ LDA #$0c
08fe : 8d 99 21 STA $2199 ; (Player + 1)
.s1001:
0901 : 60 __ __ RTS
--------------------------------------------------------------------
Player:
2198 : __ __ __ BSS	2
--------------------------------------------------------------------
init_enemies:
.s0:
0902 : a0 0a __ LDY #$0a
0904 : a2 00 __ LDX #$00
0906 : 8a __ __ TXA
.l1004:
0907 : 9d 9a 21 STA $219a,x ; (Enemy + 0)
090a : 9d 9b 21 STA $219b,x ; (Enemy + 1)
090d : 9d 9c 21 STA $219c,x ; (Enemy + 2)
0910 : e8 __ __ INX
0911 : e8 __ __ INX
0912 : e8 __ __ INX
0913 : 88 __ __ DEY
0914 : d0 f1 __ BNE $0907 ; (init_enemies.l1004 + 0)
.s1001:
0916 : 60 __ __ RTS
--------------------------------------------------------------------
Enemy:
219a : __ __ __ BSS	30
--------------------------------------------------------------------
init_shots:
.s0:
0917 : a2 00 __ LDX #$00
0919 : a0 03 __ LDY #$03
091b : 8a __ __ TXA
.l1006:
091c : 9d b8 21 STA $21b8,x ; (PlayerShot + 0)
091f : 9d b9 21 STA $21b9,x ; (PlayerShot + 1)
0922 : 9d ba 21 STA $21ba,x ; (PlayerShot + 2)
0925 : e8 __ __ INX
0926 : e8 __ __ INX
0927 : e8 __ __ INX
0928 : 88 __ __ DEY
0929 : d0 f1 __ BNE $091c ; (init_shots.l1006 + 0)
.s6:
092b : a0 03 __ LDY #$03
092d : aa __ __ TAX
.l1008:
092e : 9d c1 21 STA $21c1,x ; (EnemyShot + 0)
0931 : 9d c2 21 STA $21c2,x ; (EnemyShot + 1)
0934 : 9d c3 21 STA $21c3,x ; (EnemyShot + 2)
0937 : e8 __ __ INX
0938 : e8 __ __ INX
0939 : e8 __ __ INX
093a : 88 __ __ DEY
093b : d0 f1 __ BNE $092e ; (init_shots.l1008 + 0)
.s1001:
093d : 60 __ __ RTS
--------------------------------------------------------------------
PlayerShot:
21b8 : __ __ __ BSS	9
--------------------------------------------------------------------
EnemyShot:
21c1 : __ __ __ BSS	9
--------------------------------------------------------------------
init_game_state:
.s0:
093e : a9 00 __ LDA #$00
0940 : 8d ca 21 STA $21ca ; (game + 0)
0943 : 8d cb 21 STA $21cb ; (game + 1)
0946 : 8d cc 21 STA $21cc ; (game + 2)
0949 : 8d cd 21 STA $21cd ; (game + 3)
094c : 8d ce 21 STA $21ce ; (game + 4)
.s1001:
094f : 60 __ __ RTS
--------------------------------------------------------------------
game:
21ca : __ __ __ BSS	5
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
097c : a9 57 __ LDA #$57
097e : a0 02 __ LDY #$02
0980 : 91 23 __ STA (SP + 0),y 
0982 : a9 16 __ LDA #$16
0984 : c8 __ __ INY
0985 : 91 23 __ STA (SP + 0),y 
0987 : ad cb 21 LDA $21cb ; (game + 1)
098a : c8 __ __ INY
098b : 91 23 __ STA (SP + 0),y 
098d : ad cc 21 LDA $21cc ; (game + 2)
0990 : c8 __ __ INY
0991 : 91 23 __ STA (SP + 0),y 
0993 : ad cd 21 LDA $21cd ; (game + 3)
0996 : c8 __ __ INY
0997 : 91 23 __ STA (SP + 0),y 
0999 : ad ce 21 LDA $21ce ; (game + 4)
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
09ef : ad f9 9f LDA $9ff9 ; (sstack + 3)
09f2 : 85 50 __ STA T0 + 0 
09f4 : ad fa 9f LDA $9ffa ; (sstack + 4)
09f7 : 85 51 __ STA T0 + 1 
09f9 : ad f7 9f LDA $9ff7 ; (sstack + 1)
09fc : 85 53 __ STA T1 + 0 
09fe : ad f8 9f LDA $9ff8 ; (sstack + 2)
0a01 : 85 54 __ STA T1 + 1 
0a03 : a9 00 __ LDA #$00
.l1057:
0a05 : 85 55 __ STA T2 + 0 
.l1:
0a07 : a0 00 __ LDY #$00
0a09 : b1 50 __ LDA (T0 + 0),y 
0a0b : d0 38 __ BNE $0a45 ; (sformat.s2 + 0)
.s3:
0a0d : a4 55 __ LDY T2 + 0 
0a0f : 91 53 __ STA (T1 + 0),y 
0a11 : 98 __ __ TYA
0a12 : f0 28 __ BEQ $0a3c ; (sformat.s1059 + 0)
.s112:
0a14 : ad fd 9f LDA $9ffd ; (sstack + 7)
0a17 : d0 18 __ BNE $0a31 ; (sformat.s115 + 0)
.s116:
0a19 : 18 __ __ CLC
0a1a : a5 53 __ LDA T1 + 0 
0a1c : 65 55 __ ADC T2 + 0 
0a1e : 85 1b __ STA ACCU + 0 ; (buff + 1)
0a20 : a5 54 __ LDA T1 + 1 
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
0a31 : a5 53 __ LDA T1 + 0 
0a33 : 85 0d __ STA P0 
0a35 : a5 54 __ LDA T1 + 1 
0a37 : 85 0e __ STA P1 
0a39 : 20 2b 0e JSR $0e2b ; (puts.s0 + 0)
.s1059:
0a3c : a5 53 __ LDA T1 + 0 
0a3e : 85 1b __ STA ACCU + 0 ; (buff + 1)
0a40 : a5 54 __ LDA T1 + 1 
0a42 : 4c 24 0a JMP $0a24 ; (sformat.s1001 + 0)
.s2:
0a45 : c9 25 __ CMP #$25
0a47 : f0 3f __ BEQ $0a88 ; (sformat.s4 + 0)
.s5:
0a49 : a4 55 __ LDY T2 + 0 
0a4b : 91 53 __ STA (T1 + 0),y 
0a4d : e6 50 __ INC T0 + 0 
0a4f : d0 02 __ BNE $0a53 ; (sformat.s1089 + 0)
.s1088:
0a51 : e6 51 __ INC T0 + 1 
.s1089:
0a53 : c8 __ __ INY
0a54 : 84 55 __ STY T2 + 0 
0a56 : 98 __ __ TYA
0a57 : c0 28 __ CPY #$28
0a59 : 90 ac __ BCC $0a07 ; (sformat.l1 + 0)
.s106:
0a5b : 85 57 __ STA T5 + 0 
0a5d : a9 00 __ LDA #$00
0a5f : 85 55 __ STA T2 + 0 
0a61 : ad fd 9f LDA $9ffd ; (sstack + 7)
0a64 : f0 14 __ BEQ $0a7a ; (sformat.s110 + 0)
.s109:
0a66 : a5 53 __ LDA T1 + 0 
0a68 : 85 0d __ STA P0 
0a6a : a5 54 __ LDA T1 + 1 
0a6c : 85 0e __ STA P1 
0a6e : a9 00 __ LDA #$00
0a70 : a4 57 __ LDY T5 + 0 
0a72 : 91 0d __ STA (P0),y 
0a74 : 20 2b 0e JSR $0e2b ; (puts.s0 + 0)
0a77 : 4c 07 0a JMP $0a07 ; (sformat.l1 + 0)
.s110:
0a7a : 18 __ __ CLC
0a7b : a5 53 __ LDA T1 + 0 
0a7d : 65 57 __ ADC T5 + 0 
0a7f : 85 53 __ STA T1 + 0 
0a81 : 90 84 __ BCC $0a07 ; (sformat.l1 + 0)
.s1090:
0a83 : e6 54 __ INC T1 + 1 
0a85 : 4c 07 0a JMP $0a07 ; (sformat.l1 + 0)
.s4:
0a88 : a5 55 __ LDA T2 + 0 
0a8a : f0 27 __ BEQ $0ab3 ; (sformat.s9 + 0)
.s7:
0a8c : 84 55 __ STY T2 + 0 
0a8e : 85 57 __ STA T5 + 0 
0a90 : ad fd 9f LDA $9ffd ; (sstack + 7)
0a93 : f0 13 __ BEQ $0aa8 ; (sformat.s11 + 0)
.s10:
0a95 : a5 53 __ LDA T1 + 0 
0a97 : 85 0d __ STA P0 
0a99 : a5 54 __ LDA T1 + 1 
0a9b : 85 0e __ STA P1 
0a9d : 98 __ __ TYA
0a9e : a4 57 __ LDY T5 + 0 
0aa0 : 91 0d __ STA (P0),y 
0aa2 : 20 2b 0e JSR $0e2b ; (puts.s0 + 0)
0aa5 : 4c b3 0a JMP $0ab3 ; (sformat.s9 + 0)
.s11:
0aa8 : 18 __ __ CLC
0aa9 : a5 53 __ LDA T1 + 0 
0aab : 65 57 __ ADC T5 + 0 
0aad : 85 53 __ STA T1 + 0 
0aaf : 90 02 __ BCC $0ab3 ; (sformat.s9 + 0)
.s1086:
0ab1 : e6 54 __ INC T1 + 1 
.s9:
0ab3 : a9 0a __ LDA #$0a
0ab5 : 8d e1 9f STA $9fe1 ; (si + 3)
0ab8 : a9 00 __ LDA #$00
0aba : 8d e2 9f STA $9fe2 ; (si + 4)
0abd : 8d e3 9f STA $9fe3 ; (si + 5)
0ac0 : 8d e4 9f STA $9fe4 ; (si + 6)
0ac3 : 8d e5 9f STA $9fe5 ; (si + 7)
0ac6 : a0 01 __ LDY #$01
0ac8 : b1 50 __ LDA (T0 + 0),y 
0aca : aa __ __ TAX
0acb : a9 20 __ LDA #$20
0acd : 8d de 9f STA $9fde ; (si + 0)
0ad0 : a9 00 __ LDA #$00
0ad2 : 8d df 9f STA $9fdf ; (si + 1)
0ad5 : a9 ff __ LDA #$ff
0ad7 : 8d e0 9f STA $9fe0 ; (si + 2)
0ada : 18 __ __ CLC
0adb : a5 50 __ LDA T0 + 0 
0add : 69 02 __ ADC #$02
.l14:
0adf : 85 50 __ STA T0 + 0 
0ae1 : 90 02 __ BCC $0ae5 ; (sformat.s1071 + 0)
.s1070:
0ae3 : e6 51 __ INC T0 + 1 
.s1071:
0ae5 : 8a __ __ TXA
0ae6 : e0 2b __ CPX #$2b
0ae8 : d0 08 __ BNE $0af2 ; (sformat.s17 + 0)
.s16:
0aea : a9 01 __ LDA #$01
0aec : 8d e3 9f STA $9fe3 ; (si + 5)
0aef : 4c 1e 0e JMP $0e1e ; (sformat.s224 + 0)
.s17:
0af2 : c9 30 __ CMP #$30
0af4 : d0 06 __ BNE $0afc ; (sformat.s20 + 0)
.s19:
0af6 : 8d de 9f STA $9fde ; (si + 0)
0af9 : 4c 1e 0e JMP $0e1e ; (sformat.s224 + 0)
.s20:
0afc : e0 23 __ CPX #$23
0afe : d0 08 __ BNE $0b08 ; (sformat.s23 + 0)
.s22:
0b00 : a9 01 __ LDA #$01
0b02 : 8d e5 9f STA $9fe5 ; (si + 7)
0b05 : 4c 1e 0e JMP $0e1e ; (sformat.s224 + 0)
.s23:
0b08 : e0 2d __ CPX #$2d
0b0a : d0 08 __ BNE $0b14 ; (sformat.s15 + 0)
.s25:
0b0c : a9 01 __ LDA #$01
0b0e : 8d e4 9f STA $9fe4 ; (si + 6)
0b11 : 4c 1e 0e JMP $0e1e ; (sformat.s224 + 0)
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
0b47 : 90 01 __ BCC $0b4a ; (sformat.s1083 + 0)
.s1082:
0b49 : e8 __ __ INX
.s1083:
0b4a : 38 __ __ SEC
0b4b : e9 30 __ SBC #$30
0b4d : 85 44 __ STA T6 + 0 
0b4f : 8a __ __ TXA
0b50 : e9 00 __ SBC #$00
0b52 : 85 45 __ STA T6 + 1 
0b54 : a0 00 __ LDY #$00
0b56 : b1 50 __ LDA (T0 + 0),y 
0b58 : 85 57 __ STA T5 + 0 
0b5a : e6 50 __ INC T0 + 0 
0b5c : d0 02 __ BNE $0b60 ; (sformat.s1085 + 0)
.s1084:
0b5e : e6 51 __ INC T0 + 1 
.s1085:
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
0b7b : b1 50 __ LDA (T0 + 0),y 
0b7d : 85 57 __ STA T5 + 0 
0b7f : e6 50 __ INC T0 + 0 
0b81 : d0 02 __ BNE $0b85 ; (sformat.s1073 + 0)
.s1072:
0b83 : e6 51 __ INC T0 + 1 
.s1073:
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
0bb6 : 90 01 __ BCC $0bb9 ; (sformat.s1081 + 0)
.s1080:
0bb8 : e8 __ __ INX
.s1081:
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
0bca : 4c e2 0d JMP $0de2 ; (sformat.s221 + 0)
.s45:
0bcd : c9 75 __ CMP #$75
0bcf : d0 03 __ BNE $0bd4 ; (sformat.s48 + 0)
0bd1 : 4c e0 0d JMP $0de0 ; (sformat.s250 + 0)
.s48:
0bd4 : c9 78 __ CMP #$78
0bd6 : d0 0d __ BNE $0be5 ; (sformat.s51 + 0)
.s50:
0bd8 : a9 10 __ LDA #$10
0bda : 8d e1 9f STA $9fe1 ; (si + 3)
0bdd : a9 00 __ LDA #$00
0bdf : 8d e2 9f STA $9fe2 ; (si + 4)
0be2 : 4c e0 0d JMP $0de0 ; (sformat.s250 + 0)
.s51:
0be5 : c9 6c __ CMP #$6c
0be7 : d0 03 __ BNE $0bec ; (sformat.s54 + 0)
0be9 : 4c 64 0d JMP $0d64 ; (sformat.s53 + 0)
.s54:
0bec : c9 66 __ CMP #$66
0bee : d0 03 __ BNE $0bf3 ; (sformat.s69 + 0)
0bf0 : 4c 15 0d JMP $0d15 ; (sformat.s65 + 0)
.s69:
0bf3 : c9 67 __ CMP #$67
0bf5 : d0 03 __ BNE $0bfa ; (sformat.s68 + 0)
0bf7 : 4c 15 0d JMP $0d15 ; (sformat.s65 + 0)
.s68:
0bfa : c9 65 __ CMP #$65
0bfc : d0 03 __ BNE $0c01 ; (sformat.s66 + 0)
0bfe : 4c 15 0d JMP $0d15 ; (sformat.s65 + 0)
.s66:
0c01 : c9 73 __ CMP #$73
0c03 : f0 4c __ BEQ $0c51 ; (sformat.s70 + 0)
.s71:
0c05 : c9 63 __ CMP #$63
0c07 : f0 1f __ BEQ $0c28 ; (sformat.s100 + 0)
.s101:
0c09 : 09 00 __ ORA #$00
0c0b : d0 03 __ BNE $0c10 ; (sformat.s103 + 0)
0c0d : 4c 07 0a JMP $0a07 ; (sformat.l1 + 0)
.s103:
0c10 : 18 __ __ CLC
0c11 : a5 53 __ LDA T1 + 0 
0c13 : 65 55 __ ADC T2 + 0 
0c15 : 85 44 __ STA T6 + 0 
0c17 : a5 54 __ LDA T1 + 1 
0c19 : 69 00 __ ADC #$00
0c1b : 85 45 __ STA T6 + 1 
0c1d : a5 57 __ LDA T5 + 0 
.s1056:
0c1f : a0 00 __ LDY #$00
0c21 : 91 44 __ STA (T6 + 0),y 
0c23 : e6 55 __ INC T2 + 0 
0c25 : 4c 07 0a JMP $0a07 ; (sformat.l1 + 0)
.s100:
0c28 : ad fb 9f LDA $9ffb ; (sstack + 5)
0c2b : 85 57 __ STA T5 + 0 
0c2d : 18 __ __ CLC
0c2e : 69 02 __ ADC #$02
0c30 : 8d fb 9f STA $9ffb ; (sstack + 5)
0c33 : ad fc 9f LDA $9ffc ; (sstack + 6)
0c36 : 85 58 __ STA T5 + 1 
0c38 : 69 00 __ ADC #$00
0c3a : 8d fc 9f STA $9ffc ; (sstack + 6)
0c3d : 18 __ __ CLC
0c3e : a5 53 __ LDA T1 + 0 
0c40 : 65 55 __ ADC T2 + 0 
0c42 : 85 44 __ STA T6 + 0 
0c44 : a5 54 __ LDA T1 + 1 
0c46 : 69 00 __ ADC #$00
0c48 : 85 45 __ STA T6 + 1 
0c4a : a0 00 __ LDY #$00
0c4c : b1 57 __ LDA (T5 + 0),y 
0c4e : 4c 1f 0c JMP $0c1f ; (sformat.s1056 + 0)
.s70:
0c51 : ad fb 9f LDA $9ffb ; (sstack + 5)
0c54 : 85 57 __ STA T5 + 0 
0c56 : 18 __ __ CLC
0c57 : 69 02 __ ADC #$02
0c59 : 8d fb 9f STA $9ffb ; (sstack + 5)
0c5c : ad fc 9f LDA $9ffc ; (sstack + 6)
0c5f : 85 58 __ STA T5 + 1 
0c61 : 69 00 __ ADC #$00
0c63 : 8d fc 9f STA $9ffc ; (sstack + 6)
0c66 : a0 00 __ LDY #$00
0c68 : b1 57 __ LDA (T5 + 0),y 
0c6a : aa __ __ TAX
0c6b : c8 __ __ INY
0c6c : b1 57 __ LDA (T5 + 0),y 
0c6e : 86 57 __ STX T5 + 0 
0c70 : 85 58 __ STA T5 + 1 
0c72 : a9 00 __ LDA #$00
0c74 : 85 52 __ STA T3 + 0 
0c76 : ad df 9f LDA $9fdf ; (si + 1)
0c79 : f0 0c __ BEQ $0c87 ; (sformat.s75 + 0)
.s1062:
0c7b : 88 __ __ DEY
0c7c : b1 57 __ LDA (T5 + 0),y 
0c7e : f0 05 __ BEQ $0c85 ; (sformat.s1063 + 0)
.l77:
0c80 : c8 __ __ INY
0c81 : b1 57 __ LDA (T5 + 0),y 
0c83 : d0 fb __ BNE $0c80 ; (sformat.l77 + 0)
.s1063:
0c85 : 84 52 __ STY T3 + 0 
.s75:
0c87 : ad e4 9f LDA $9fe4 ; (si + 6)
0c8a : d0 19 __ BNE $0ca5 ; (sformat.s81 + 0)
.s1066:
0c8c : a6 52 __ LDX T3 + 0 
0c8e : ec df 9f CPX $9fdf ; (si + 1)
0c91 : a4 55 __ LDY T2 + 0 
0c93 : b0 0c __ BCS $0ca1 ; (sformat.s1067 + 0)
.l83:
0c95 : ad de 9f LDA $9fde ; (si + 0)
0c98 : 91 53 __ STA (T1 + 0),y 
0c9a : e8 __ __ INX
0c9b : ec df 9f CPX $9fdf ; (si + 1)
0c9e : c8 __ __ INY
0c9f : 90 f4 __ BCC $0c95 ; (sformat.l83 + 0)
.s1067:
0ca1 : 86 52 __ STX T3 + 0 
0ca3 : 84 55 __ STY T2 + 0 
.s81:
0ca5 : ad fd 9f LDA $9ffd ; (sstack + 7)
0ca8 : d0 37 __ BNE $0ce1 ; (sformat.s85 + 0)
.l91:
0caa : a0 00 __ LDY #$00
0cac : b1 57 __ LDA (T5 + 0),y 
0cae : f0 0f __ BEQ $0cbf ; (sformat.s211 + 0)
.s92:
0cb0 : a4 55 __ LDY T2 + 0 
0cb2 : 91 53 __ STA (T1 + 0),y 
0cb4 : e6 55 __ INC T2 + 0 
0cb6 : e6 57 __ INC T5 + 0 
0cb8 : d0 f0 __ BNE $0caa ; (sformat.l91 + 0)
.s1078:
0cba : e6 58 __ INC T5 + 1 
0cbc : 4c aa 0c JMP $0caa ; (sformat.l91 + 0)
.s211:
0cbf : ad e4 9f LDA $9fe4 ; (si + 6)
0cc2 : d0 03 __ BNE $0cc7 ; (sformat.s1064 + 0)
0cc4 : 4c 07 0a JMP $0a07 ; (sformat.l1 + 0)
.s1064:
0cc7 : a6 52 __ LDX T3 + 0 
0cc9 : ec df 9f CPX $9fdf ; (si + 1)
0ccc : a4 55 __ LDY T2 + 0 
0cce : b0 0c __ BCS $0cdc ; (sformat.s1065 + 0)
.l98:
0cd0 : ad de 9f LDA $9fde ; (si + 0)
0cd3 : 91 53 __ STA (T1 + 0),y 
0cd5 : e8 __ __ INX
0cd6 : ec df 9f CPX $9fdf ; (si + 1)
0cd9 : c8 __ __ INY
0cda : 90 f4 __ BCC $0cd0 ; (sformat.l98 + 0)
.s1065:
0cdc : 84 55 __ STY T2 + 0 
0cde : 4c 07 0a JMP $0a07 ; (sformat.l1 + 0)
.s85:
0ce1 : a5 55 __ LDA T2 + 0 
0ce3 : f0 22 __ BEQ $0d07 ; (sformat.s90 + 0)
.s88:
0ce5 : a5 53 __ LDA T1 + 0 
0ce7 : 85 0d __ STA P0 
0ce9 : a5 54 __ LDA T1 + 1 
0ceb : 85 0e __ STA P1 
0ced : a9 00 __ LDA #$00
0cef : a4 55 __ LDY T2 + 0 
0cf1 : 91 0d __ STA (P0),y 
0cf3 : 20 2b 0e JSR $0e2b ; (puts.s0 + 0)
0cf6 : a5 57 __ LDA T5 + 0 
0cf8 : 85 0d __ STA P0 
0cfa : a5 58 __ LDA T5 + 1 
0cfc : 85 0e __ STA P1 
0cfe : 20 2b 0e JSR $0e2b ; (puts.s0 + 0)
0d01 : a9 00 __ LDA #$00
0d03 : 85 55 __ STA T2 + 0 
0d05 : f0 b8 __ BEQ $0cbf ; (sformat.s211 + 0)
.s90:
0d07 : a5 57 __ LDA T5 + 0 
0d09 : 85 0d __ STA P0 
0d0b : a5 58 __ LDA T5 + 1 
0d0d : 85 0e __ STA P1 
0d0f : 20 2b 0e JSR $0e2b ; (puts.s0 + 0)
0d12 : 4c bf 0c JMP $0cbf ; (sformat.s211 + 0)
.s65:
0d15 : a5 53 __ LDA T1 + 0 
0d17 : 85 13 __ STA P6 
0d19 : a5 54 __ LDA T1 + 1 
0d1b : 85 14 __ STA P7 
0d1d : a5 57 __ LDA T5 + 0 
0d1f : 8d f6 9f STA $9ff6 ; (sstack + 0)
0d22 : a9 de __ LDA #$de
0d24 : 85 11 __ STA P4 
0d26 : a9 9f __ LDA #$9f
0d28 : 85 12 __ STA P5 
0d2a : ad fb 9f LDA $9ffb ; (sstack + 5)
0d2d : 85 55 __ STA T2 + 0 
0d2f : ad fc 9f LDA $9ffc ; (sstack + 6)
0d32 : 85 56 __ STA T2 + 1 
0d34 : a0 00 __ LDY #$00
0d36 : b1 55 __ LDA (T2 + 0),y 
0d38 : 85 15 __ STA P8 
0d3a : c8 __ __ INY
0d3b : b1 55 __ LDA (T2 + 0),y 
0d3d : 85 16 __ STA P9 
0d3f : c8 __ __ INY
0d40 : b1 55 __ LDA (T2 + 0),y 
0d42 : 85 17 __ STA P10 
0d44 : c8 __ __ INY
0d45 : b1 55 __ LDA (T2 + 0),y 
0d47 : 85 18 __ STA P11 
0d49 : 20 77 11 JSR $1177 ; (nformf.s0 + 0)
0d4c : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0d4e : 85 55 __ STA T2 + 0 
0d50 : ad fb 9f LDA $9ffb ; (sstack + 5)
0d53 : 18 __ __ CLC
0d54 : 69 04 __ ADC #$04
0d56 : 8d fb 9f STA $9ffb ; (sstack + 5)
0d59 : b0 03 __ BCS $0d5e ; (sformat.s1076 + 0)
0d5b : 4c 07 0a JMP $0a07 ; (sformat.l1 + 0)
.s1076:
0d5e : ee fc 9f INC $9ffc ; (sstack + 6)
0d61 : 4c 07 0a JMP $0a07 ; (sformat.l1 + 0)
.s53:
0d64 : ad fb 9f LDA $9ffb ; (sstack + 5)
0d67 : 85 57 __ STA T5 + 0 
0d69 : 18 __ __ CLC
0d6a : 69 04 __ ADC #$04
0d6c : 8d fb 9f STA $9ffb ; (sstack + 5)
0d6f : ad fc 9f LDA $9ffc ; (sstack + 6)
0d72 : 85 58 __ STA T5 + 1 
0d74 : 69 00 __ ADC #$00
0d76 : 8d fc 9f STA $9ffc ; (sstack + 6)
0d79 : a0 00 __ LDY #$00
0d7b : b1 57 __ LDA (T5 + 0),y 
0d7d : 85 46 __ STA T7 + 0 
0d7f : c8 __ __ INY
0d80 : b1 57 __ LDA (T5 + 0),y 
0d82 : 85 47 __ STA T7 + 1 
0d84 : c8 __ __ INY
0d85 : b1 57 __ LDA (T5 + 0),y 
0d87 : 85 48 __ STA T7 + 2 
0d89 : c8 __ __ INY
0d8a : b1 57 __ LDA (T5 + 0),y 
0d8c : 85 49 __ STA T7 + 3 
0d8e : a0 00 __ LDY #$00
0d90 : b1 50 __ LDA (T0 + 0),y 
0d92 : aa __ __ TAX
0d93 : e6 50 __ INC T0 + 0 
0d95 : d0 02 __ BNE $0d99 ; (sformat.s1075 + 0)
.s1074:
0d97 : e6 51 __ INC T0 + 1 
.s1075:
0d99 : 8a __ __ TXA
0d9a : e0 64 __ CPX #$64
0d9c : d0 04 __ BNE $0da2 ; (sformat.s57 + 0)
.s56:
0d9e : a9 01 __ LDA #$01
0da0 : d0 14 __ BNE $0db6 ; (sformat.s222 + 0)
.s57:
0da2 : c9 75 __ CMP #$75
0da4 : f0 0f __ BEQ $0db5 ; (sformat.s251 + 0)
.s60:
0da6 : c9 78 __ CMP #$78
0da8 : f0 03 __ BEQ $0dad ; (sformat.s62 + 0)
0daa : 4c 07 0a JMP $0a07 ; (sformat.l1 + 0)
.s62:
0dad : 8c e2 9f STY $9fe2 ; (si + 4)
0db0 : a9 10 __ LDA #$10
0db2 : 8d e1 9f STA $9fe1 ; (si + 3)
.s251:
0db5 : 98 __ __ TYA
.s222:
0db6 : 85 15 __ STA P8 
0db8 : a5 53 __ LDA T1 + 0 
0dba : 85 0f __ STA P2 
0dbc : a5 54 __ LDA T1 + 1 
0dbe : 85 10 __ STA P3 
0dc0 : a5 46 __ LDA T7 + 0 
0dc2 : 85 11 __ STA P4 
0dc4 : a5 47 __ LDA T7 + 1 
0dc6 : 85 12 __ STA P5 
0dc8 : a5 48 __ LDA T7 + 2 
0dca : 85 13 __ STA P6 
0dcc : a5 49 __ LDA T7 + 3 
0dce : 85 14 __ STA P7 
0dd0 : a9 de __ LDA #$de
0dd2 : 85 0d __ STA P0 
0dd4 : a9 9f __ LDA #$9f
0dd6 : 85 0e __ STA P1 
0dd8 : 20 df 0f JSR $0fdf ; (nforml.s0 + 0)
.s1058:
0ddb : a5 1b __ LDA ACCU + 0 ; (buff + 1)
0ddd : 4c 05 0a JMP $0a05 ; (sformat.l1057 + 0)
.s250:
0de0 : a9 00 __ LDA #$00
.s221:
0de2 : 85 13 __ STA P6 
0de4 : a5 53 __ LDA T1 + 0 
0de6 : 85 0f __ STA P2 
0de8 : a5 54 __ LDA T1 + 1 
0dea : 85 10 __ STA P3 
0dec : ad fb 9f LDA $9ffb ; (sstack + 5)
0def : 85 55 __ STA T2 + 0 
0df1 : ad fc 9f LDA $9ffc ; (sstack + 6)
0df4 : 85 56 __ STA T2 + 1 
0df6 : a0 00 __ LDY #$00
0df8 : b1 55 __ LDA (T2 + 0),y 
0dfa : 85 11 __ STA P4 
0dfc : c8 __ __ INY
0dfd : b1 55 __ LDA (T2 + 0),y 
0dff : 85 12 __ STA P5 
0e01 : 18 __ __ CLC
0e02 : a5 55 __ LDA T2 + 0 
0e04 : 69 02 __ ADC #$02
0e06 : 8d fb 9f STA $9ffb ; (sstack + 5)
0e09 : a5 56 __ LDA T2 + 1 
0e0b : 69 00 __ ADC #$00
0e0d : 8d fc 9f STA $9ffc ; (sstack + 6)
0e10 : a9 de __ LDA #$de
0e12 : 85 0d __ STA P0 
0e14 : a9 9f __ LDA #$9f
0e16 : 85 0e __ STA P1 
0e18 : 20 80 0e JSR $0e80 ; (nformi.s0 + 0)
0e1b : 4c db 0d JMP $0ddb ; (sformat.s1058 + 0)
.s224:
0e1e : a0 00 __ LDY #$00
0e20 : b1 50 __ LDA (T0 + 0),y 
0e22 : aa __ __ TAX
0e23 : 18 __ __ CLC
0e24 : a5 50 __ LDA T0 + 0 
0e26 : 69 01 __ ADC #$01
0e28 : 4c df 0a JMP $0adf ; (sformat.l14 + 0)
--------------------------------------------------------------------
puts:
.s0:
0e2b : a0 00 __ LDY #$00
0e2d : b1 0d __ LDA (P0),y 
0e2f : f0 0b __ BEQ $0e3c ; (puts.s1001 + 0)
0e31 : 20 3d 0e JSR $0e3d ; (putpch + 0)
0e34 : e6 0d __ INC P0 
0e36 : d0 f3 __ BNE $0e2b ; (puts.s0 + 0)
0e38 : e6 0e __ INC P1 
0e3a : d0 ef __ BNE $0e2b ; (puts.s0 + 0)
.s1001:
0e3c : 60 __ __ RTS
--------------------------------------------------------------------
putpch:
0e3d : ae 79 21 LDX $2179 ; (giocharmap + 0)
0e40 : e0 01 __ CPX #$01
0e42 : 90 26 __ BCC $0e6a ; (putpch + 45)
0e44 : c9 0a __ CMP #$0a
0e46 : d0 02 __ BNE $0e4a ; (putpch + 13)
0e48 : a9 0d __ LDA #$0d
0e4a : c9 09 __ CMP #$09
0e4c : f0 1f __ BEQ $0e6d ; (putpch + 48)
0e4e : e0 02 __ CPX #$02
0e50 : 90 18 __ BCC $0e6a ; (putpch + 45)
0e52 : c9 41 __ CMP #$41
0e54 : 90 14 __ BCC $0e6a ; (putpch + 45)
0e56 : c9 7b __ CMP #$7b
0e58 : b0 10 __ BCS $0e6a ; (putpch + 45)
0e5a : c9 61 __ CMP #$61
0e5c : b0 04 __ BCS $0e62 ; (putpch + 37)
0e5e : c9 5b __ CMP #$5b
0e60 : b0 08 __ BCS $0e6a ; (putpch + 45)
0e62 : 49 20 __ EOR #$20
0e64 : e0 03 __ CPX #$03
0e66 : f0 02 __ BEQ $0e6a ; (putpch + 45)
0e68 : 29 df __ AND #$df
0e6a : 4c d2 ff JMP $ffd2 
0e6d : 38 __ __ SEC
0e6e : 20 f0 ff JSR $fff0 
0e71 : 98 __ __ TYA
0e72 : 29 03 __ AND #$03
0e74 : 49 03 __ EOR #$03
0e76 : aa __ __ TAX
0e77 : a9 20 __ LDA #$20
0e79 : 20 d2 ff JSR $ffd2 
0e7c : ca __ __ DEX
0e7d : 10 fa __ BPL $0e79 ; (putpch + 60)
0e7f : 60 __ __ RTS
--------------------------------------------------------------------
giocharmap:
2179 : __ __ __ BYT 01                                              : .
--------------------------------------------------------------------
nformi:
.s0:
0e80 : a9 00 __ LDA #$00
0e82 : 85 43 __ STA T1 + 0 
0e84 : a5 13 __ LDA P6 ; (s + 0)
0e86 : f0 15 __ BEQ $0e9d ; (nformi.s159 + 0)
.s4:
0e88 : a5 12 __ LDA P5 ; (v + 1)
0e8a : 10 11 __ BPL $0e9d ; (nformi.s159 + 0)
.s1:
0e8c : 38 __ __ SEC
0e8d : a9 00 __ LDA #$00
0e8f : e5 11 __ SBC P4 ; (v + 0)
0e91 : 85 11 __ STA P4 ; (v + 0)
0e93 : a9 00 __ LDA #$00
0e95 : e5 12 __ SBC P5 ; (v + 1)
0e97 : 85 12 __ STA P5 ; (v + 1)
0e99 : a9 01 __ LDA #$01
0e9b : 85 43 __ STA T1 + 0 
.s159:
0e9d : a9 10 __ LDA #$10
0e9f : 85 44 __ STA T2 + 0 
0ea1 : a5 11 __ LDA P4 ; (v + 0)
0ea3 : 05 12 __ ORA P5 ; (v + 1)
0ea5 : f0 61 __ BEQ $0f08 ; (nformi.s7 + 0)
.s45:
0ea7 : a5 0d __ LDA P0 ; (si + 0)
0ea9 : 85 45 __ STA T4 + 0 
0eab : a5 0e __ LDA P1 ; (si + 1)
0ead : 85 46 __ STA T4 + 1 
.l6:
0eaf : a0 03 __ LDY #$03
0eb1 : b1 45 __ LDA (T4 + 0),y 
0eb3 : 85 47 __ STA T5 + 0 
0eb5 : 85 03 __ STA WORK + 0 
0eb7 : c8 __ __ INY
0eb8 : b1 45 __ LDA (T4 + 0),y 
0eba : 85 48 __ STA T5 + 1 
0ebc : 85 04 __ STA WORK + 1 
0ebe : a5 11 __ LDA P4 ; (v + 0)
0ec0 : 85 1b __ STA ACCU + 0 
0ec2 : a5 12 __ LDA P5 ; (v + 1)
0ec4 : 85 1c __ STA ACCU + 1 
0ec6 : 20 9d 1f JSR $1f9d ; (divmod + 0)
0ec9 : a5 06 __ LDA WORK + 3 
0ecb : 30 10 __ BMI $0edd ; (nformi.s9 + 0)
.s1019:
0ecd : d0 06 __ BNE $0ed5 ; (nformi.s8 + 0)
.s1018:
0ecf : a5 05 __ LDA WORK + 2 
0ed1 : c9 0a __ CMP #$0a
0ed3 : 90 08 __ BCC $0edd ; (nformi.s9 + 0)
.s8:
0ed5 : 18 __ __ CLC
0ed6 : a5 05 __ LDA WORK + 2 
0ed8 : 69 37 __ ADC #$37
0eda : 4c e2 0e JMP $0ee2 ; (nformi.s10 + 0)
.s9:
0edd : 18 __ __ CLC
0ede : a5 05 __ LDA WORK + 2 
0ee0 : 69 30 __ ADC #$30
.s10:
0ee2 : c6 44 __ DEC T2 + 0 
0ee4 : a6 44 __ LDX T2 + 0 
0ee6 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
0ee9 : a5 11 __ LDA P4 ; (v + 0)
0eeb : 85 1b __ STA ACCU + 0 
0eed : a5 12 __ LDA P5 ; (v + 1)
0eef : 85 1c __ STA ACCU + 1 
0ef1 : a5 47 __ LDA T5 + 0 
0ef3 : 85 03 __ STA WORK + 0 
0ef5 : a5 48 __ LDA T5 + 1 
0ef7 : 85 04 __ STA WORK + 1 
0ef9 : 20 9d 1f JSR $1f9d ; (divmod + 0)
0efc : a5 1b __ LDA ACCU + 0 
0efe : 85 11 __ STA P4 ; (v + 0)
0f00 : a5 1c __ LDA ACCU + 1 
0f02 : 85 12 __ STA P5 ; (v + 1)
0f04 : 05 11 __ ORA P4 ; (v + 0)
0f06 : d0 a7 __ BNE $0eaf ; (nformi.l6 + 0)
.s7:
0f08 : a5 0d __ LDA P0 ; (si + 0)
0f0a : 85 11 __ STA P4 ; (v + 0)
0f0c : a5 0e __ LDA P1 ; (si + 1)
0f0e : 85 12 __ STA P5 ; (v + 1)
0f10 : a0 02 __ LDY #$02
0f12 : b1 0d __ LDA (P0),y ; (si + 0)
0f14 : c9 ff __ CMP #$ff
0f16 : d0 04 __ BNE $0f1c ; (nformi.s76 + 0)
.s77:
0f18 : a9 0f __ LDA #$0f
0f1a : d0 05 __ BNE $0f21 ; (nformi.s1026 + 0)
.s76:
0f1c : 38 __ __ SEC
0f1d : a9 10 __ LDA #$10
0f1f : f1 0d __ SBC (P0),y ; (si + 0)
.s1026:
0f21 : a8 __ __ TAY
0f22 : c4 44 __ CPY T2 + 0 
0f24 : b0 0d __ BCS $0f33 ; (nformi.s13 + 0)
.s12:
0f26 : a9 30 __ LDA #$30
.l1027:
0f28 : c6 44 __ DEC T2 + 0 
0f2a : a6 44 __ LDX T2 + 0 
0f2c : 9d e6 9f STA $9fe6,x ; (buffer + 0)
0f2f : c4 44 __ CPY T2 + 0 
0f31 : 90 f5 __ BCC $0f28 ; (nformi.l1027 + 0)
.s13:
0f33 : a0 07 __ LDY #$07
0f35 : b1 0d __ LDA (P0),y ; (si + 0)
0f37 : f0 20 __ BEQ $0f59 ; (nformi.s16 + 0)
.s17:
0f39 : a0 04 __ LDY #$04
0f3b : b1 0d __ LDA (P0),y ; (si + 0)
0f3d : d0 1a __ BNE $0f59 ; (nformi.s16 + 0)
.s1013:
0f3f : 88 __ __ DEY
0f40 : b1 0d __ LDA (P0),y ; (si + 0)
0f42 : c9 10 __ CMP #$10
0f44 : d0 13 __ BNE $0f59 ; (nformi.s16 + 0)
.s14:
0f46 : a9 58 __ LDA #$58
0f48 : a6 44 __ LDX T2 + 0 
0f4a : 9d e5 9f STA $9fe5,x ; (si + 7)
0f4d : 8a __ __ TXA
0f4e : 18 __ __ CLC
0f4f : 69 fe __ ADC #$fe
0f51 : 85 44 __ STA T2 + 0 
0f53 : aa __ __ TAX
0f54 : a9 30 __ LDA #$30
0f56 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
.s16:
0f59 : a9 00 __ LDA #$00
0f5b : 85 1b __ STA ACCU + 0 
0f5d : a5 43 __ LDA T1 + 0 
0f5f : f0 06 __ BEQ $0f67 ; (nformi.s19 + 0)
.s18:
0f61 : c6 44 __ DEC T2 + 0 
0f63 : a9 2d __ LDA #$2d
0f65 : d0 0a __ BNE $0f71 ; (nformi.s1025 + 0)
.s19:
0f67 : a0 05 __ LDY #$05
0f69 : b1 0d __ LDA (P0),y ; (si + 0)
0f6b : f0 09 __ BEQ $0f76 ; (nformi.s141 + 0)
.s21:
0f6d : c6 44 __ DEC T2 + 0 
0f6f : a9 2b __ LDA #$2b
.s1025:
0f71 : a6 44 __ LDX T2 + 0 
0f73 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
.s141:
0f76 : a0 06 __ LDY #$06
0f78 : b1 0d __ LDA (P0),y ; (si + 0)
0f7a : d0 37 __ BNE $0fb3 ; (nformi.s27 + 0)
.l33:
0f7c : a0 01 __ LDY #$01
0f7e : b1 11 __ LDA (P4),y ; (v + 0)
0f80 : 18 __ __ CLC
0f81 : 65 44 __ ADC T2 + 0 
0f83 : b0 04 __ BCS $0f89 ; (nformi.s34 + 0)
.s1006:
0f85 : c9 11 __ CMP #$11
0f87 : 90 0e __ BCC $0f97 ; (nformi.s36 + 0)
.s34:
0f89 : c6 44 __ DEC T2 + 0 
0f8b : a0 00 __ LDY #$00
0f8d : b1 11 __ LDA (P4),y ; (v + 0)
0f8f : a6 44 __ LDX T2 + 0 
0f91 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
0f94 : 4c 7c 0f JMP $0f7c ; (nformi.l33 + 0)
.s36:
0f97 : a6 44 __ LDX T2 + 0 
0f99 : e0 10 __ CPX #$10
0f9b : b0 11 __ BCS $0fae ; (nformi.s26 + 0)
.s1022:
0f9d : 88 __ __ DEY
.l1031:
0f9e : bd e6 9f LDA $9fe6,x ; (buffer + 0)
0fa1 : 91 0f __ STA (P2),y ; (str + 0)
0fa3 : e6 44 __ INC T2 + 0 
0fa5 : a6 44 __ LDX T2 + 0 
0fa7 : e0 10 __ CPX #$10
0fa9 : c8 __ __ INY
0faa : 90 f2 __ BCC $0f9e ; (nformi.l1031 + 0)
.s1032:
0fac : 84 1b __ STY ACCU + 0 
.s26:
0fae : a9 00 __ LDA #$00
0fb0 : 85 1c __ STA ACCU + 1 
.s1001:
0fb2 : 60 __ __ RTS
.s27:
0fb3 : a6 44 __ LDX T2 + 0 
0fb5 : e0 10 __ CPX #$10
0fb7 : b0 12 __ BCS $0fcb ; (nformi.l30 + 0)
.s1020:
0fb9 : a0 00 __ LDY #$00
.l1029:
0fbb : bd e6 9f LDA $9fe6,x ; (buffer + 0)
0fbe : 91 0f __ STA (P2),y ; (str + 0)
0fc0 : e6 44 __ INC T2 + 0 
0fc2 : a6 44 __ LDX T2 + 0 
0fc4 : e0 10 __ CPX #$10
0fc6 : c8 __ __ INY
0fc7 : 90 f2 __ BCC $0fbb ; (nformi.l1029 + 0)
.s1030:
0fc9 : 84 1b __ STY ACCU + 0 
.l30:
0fcb : a5 1b __ LDA ACCU + 0 
0fcd : a0 01 __ LDY #$01
0fcf : d1 11 __ CMP (P4),y ; (v + 0)
0fd1 : b0 db __ BCS $0fae ; (nformi.s26 + 0)
.s31:
0fd3 : 88 __ __ DEY
0fd4 : b1 11 __ LDA (P4),y ; (v + 0)
0fd6 : a4 1b __ LDY ACCU + 0 
0fd8 : 91 0f __ STA (P2),y ; (str + 0)
0fda : e6 1b __ INC ACCU + 0 
0fdc : 4c cb 0f JMP $0fcb ; (nformi.l30 + 0)
--------------------------------------------------------------------
nforml:
.s0:
0fdf : a9 00 __ LDA #$00
0fe1 : 85 43 __ STA T1 + 0 
0fe3 : a5 15 __ LDA P8 ; (s + 0)
0fe5 : f0 23 __ BEQ $100a ; (nforml.s159 + 0)
.s4:
0fe7 : a5 14 __ LDA P7 ; (v + 3)
0fe9 : f0 1f __ BEQ $100a ; (nforml.s159 + 0)
.s1032:
0feb : 10 1d __ BPL $100a ; (nforml.s159 + 0)
.s1:
0fed : 38 __ __ SEC
0fee : a9 00 __ LDA #$00
0ff0 : e5 11 __ SBC P4 ; (v + 0)
0ff2 : 85 11 __ STA P4 ; (v + 0)
0ff4 : a9 00 __ LDA #$00
0ff6 : e5 12 __ SBC P5 ; (v + 1)
0ff8 : 85 12 __ STA P5 ; (v + 1)
0ffa : a9 00 __ LDA #$00
0ffc : e5 13 __ SBC P6 ; (v + 2)
0ffe : 85 13 __ STA P6 ; (v + 2)
1000 : a9 00 __ LDA #$00
1002 : e5 14 __ SBC P7 ; (v + 3)
1004 : 85 14 __ STA P7 ; (v + 3)
1006 : a9 01 __ LDA #$01
1008 : 85 43 __ STA T1 + 0 
.s159:
100a : a9 10 __ LDA #$10
100c : 85 44 __ STA T2 + 0 
100e : a5 14 __ LDA P7 ; (v + 3)
1010 : f0 03 __ BEQ $1015 ; (nforml.s1018 + 0)
1012 : 4c f9 10 JMP $10f9 ; (nforml.l6 + 0)
.s1018:
1015 : a5 13 __ LDA P6 ; (v + 2)
1017 : f0 03 __ BEQ $101c ; (nforml.s1019 + 0)
1019 : 4c f9 10 JMP $10f9 ; (nforml.l6 + 0)
.s1019:
101c : a5 12 __ LDA P5 ; (v + 1)
101e : f0 03 __ BEQ $1023 ; (nforml.s1020 + 0)
1020 : 4c f9 10 JMP $10f9 ; (nforml.l6 + 0)
.s1020:
1023 : c5 11 __ CMP P4 ; (v + 0)
1025 : b0 03 __ BCS $102a ; (nforml.s7 + 0)
1027 : 4c f9 10 JMP $10f9 ; (nforml.l6 + 0)
.s7:
102a : a0 02 __ LDY #$02
102c : b1 0d __ LDA (P0),y ; (si + 0)
102e : c9 ff __ CMP #$ff
1030 : d0 04 __ BNE $1036 ; (nforml.s76 + 0)
.s77:
1032 : a9 0f __ LDA #$0f
1034 : d0 05 __ BNE $103b ; (nforml.s1039 + 0)
.s76:
1036 : 38 __ __ SEC
1037 : a9 10 __ LDA #$10
1039 : f1 0d __ SBC (P0),y ; (si + 0)
.s1039:
103b : a8 __ __ TAY
103c : c4 44 __ CPY T2 + 0 
103e : b0 0d __ BCS $104d ; (nforml.s13 + 0)
.s12:
1040 : a9 30 __ LDA #$30
.l1040:
1042 : c6 44 __ DEC T2 + 0 
1044 : a6 44 __ LDX T2 + 0 
1046 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
1049 : c4 44 __ CPY T2 + 0 
104b : 90 f5 __ BCC $1042 ; (nforml.l1040 + 0)
.s13:
104d : a0 07 __ LDY #$07
104f : b1 0d __ LDA (P0),y ; (si + 0)
1051 : f0 20 __ BEQ $1073 ; (nforml.s16 + 0)
.s17:
1053 : a0 04 __ LDY #$04
1055 : b1 0d __ LDA (P0),y ; (si + 0)
1057 : d0 1a __ BNE $1073 ; (nforml.s16 + 0)
.s1013:
1059 : 88 __ __ DEY
105a : b1 0d __ LDA (P0),y ; (si + 0)
105c : c9 10 __ CMP #$10
105e : d0 13 __ BNE $1073 ; (nforml.s16 + 0)
.s14:
1060 : a9 58 __ LDA #$58
1062 : a6 44 __ LDX T2 + 0 
1064 : 9d e5 9f STA $9fe5,x ; (si + 7)
1067 : 8a __ __ TXA
1068 : 18 __ __ CLC
1069 : 69 fe __ ADC #$fe
106b : 85 44 __ STA T2 + 0 
106d : aa __ __ TAX
106e : a9 30 __ LDA #$30
1070 : 9d e6 9f STA $9fe6,x ; (buffer + 0)
.s16:
1073 : a9 00 __ LDA #$00
1075 : 85 1b __ STA ACCU + 0 
1077 : a5 43 __ LDA T1 + 0 
1079 : f0 06 __ BEQ $1081 ; (nforml.s19 + 0)
.s18:
107b : c6 44 __ DEC T2 + 0 
107d : a9 2d __ LDA #$2d
107f : d0 0a __ BNE $108b ; (nforml.s1038 + 0)
.s19:
1081 : a0 05 __ LDY #$05
1083 : b1 0d __ LDA (P0),y ; (si + 0)
1085 : f0 09 __ BEQ $1090 ; (nforml.s141 + 0)
.s21:
1087 : c6 44 __ DEC T2 + 0 
1089 : a9 2b __ LDA #$2b
.s1038:
108b : a6 44 __ LDX T2 + 0 
108d : 9d e6 9f STA $9fe6,x ; (buffer + 0)
.s141:
1090 : a0 06 __ LDY #$06
1092 : b1 0d __ LDA (P0),y ; (si + 0)
1094 : d0 37 __ BNE $10cd ; (nforml.s27 + 0)
.l33:
1096 : a0 01 __ LDY #$01
1098 : b1 0d __ LDA (P0),y ; (si + 0)
109a : 18 __ __ CLC
109b : 65 44 __ ADC T2 + 0 
109d : b0 04 __ BCS $10a3 ; (nforml.s34 + 0)
.s1006:
109f : c9 11 __ CMP #$11
10a1 : 90 0e __ BCC $10b1 ; (nforml.s36 + 0)
.s34:
10a3 : c6 44 __ DEC T2 + 0 
10a5 : a0 00 __ LDY #$00
10a7 : b1 0d __ LDA (P0),y ; (si + 0)
10a9 : a6 44 __ LDX T2 + 0 
10ab : 9d e6 9f STA $9fe6,x ; (buffer + 0)
10ae : 4c 96 10 JMP $1096 ; (nforml.l33 + 0)
.s36:
10b1 : a6 44 __ LDX T2 + 0 
10b3 : e0 10 __ CPX #$10
10b5 : b0 11 __ BCS $10c8 ; (nforml.s26 + 0)
.s1035:
10b7 : 88 __ __ DEY
.l1044:
10b8 : bd e6 9f LDA $9fe6,x ; (buffer + 0)
10bb : 91 0f __ STA (P2),y ; (str + 0)
10bd : e6 44 __ INC T2 + 0 
10bf : a6 44 __ LDX T2 + 0 
10c1 : e0 10 __ CPX #$10
10c3 : c8 __ __ INY
10c4 : 90 f2 __ BCC $10b8 ; (nforml.l1044 + 0)
.s1045:
10c6 : 84 1b __ STY ACCU + 0 
.s26:
10c8 : a9 00 __ LDA #$00
10ca : 85 1c __ STA ACCU + 1 
.s1001:
10cc : 60 __ __ RTS
.s27:
10cd : a6 44 __ LDX T2 + 0 
10cf : e0 10 __ CPX #$10
10d1 : b0 12 __ BCS $10e5 ; (nforml.l30 + 0)
.s1033:
10d3 : a0 00 __ LDY #$00
.l1042:
10d5 : bd e6 9f LDA $9fe6,x ; (buffer + 0)
10d8 : 91 0f __ STA (P2),y ; (str + 0)
10da : e6 44 __ INC T2 + 0 
10dc : a6 44 __ LDX T2 + 0 
10de : e0 10 __ CPX #$10
10e0 : c8 __ __ INY
10e1 : 90 f2 __ BCC $10d5 ; (nforml.l1042 + 0)
.s1043:
10e3 : 84 1b __ STY ACCU + 0 
.l30:
10e5 : a5 1b __ LDA ACCU + 0 
10e7 : a0 01 __ LDY #$01
10e9 : d1 0d __ CMP (P0),y ; (si + 0)
10eb : b0 db __ BCS $10c8 ; (nforml.s26 + 0)
.s31:
10ed : 88 __ __ DEY
10ee : b1 0d __ LDA (P0),y ; (si + 0)
10f0 : a4 1b __ LDY ACCU + 0 
10f2 : 91 0f __ STA (P2),y ; (str + 0)
10f4 : e6 1b __ INC ACCU + 0 
10f6 : 4c e5 10 JMP $10e5 ; (nforml.l30 + 0)
.l6:
10f9 : a0 03 __ LDY #$03
10fb : b1 0d __ LDA (P0),y ; (si + 0)
10fd : 85 03 __ STA WORK + 0 
10ff : 85 45 __ STA T6 + 0 
1101 : c8 __ __ INY
1102 : b1 0d __ LDA (P0),y ; (si + 0)
1104 : 85 46 __ STA T6 + 1 
1106 : 85 04 __ STA WORK + 1 
1108 : a5 11 __ LDA P4 ; (v + 0)
110a : 85 1b __ STA ACCU + 0 
110c : a5 12 __ LDA P5 ; (v + 1)
110e : 85 1c __ STA ACCU + 1 
1110 : a5 13 __ LDA P6 ; (v + 2)
1112 : 85 1d __ STA ACCU + 2 
1114 : a5 14 __ LDA P7 ; (v + 3)
1116 : 85 1e __ STA ACCU + 3 
1118 : a9 00 __ LDA #$00
111a : 85 05 __ STA WORK + 2 
111c : 85 06 __ STA WORK + 3 
111e : 20 d8 20 JSR $20d8 ; (divmod32 + 0)
1121 : a5 08 __ LDA WORK + 5 
1123 : 30 10 __ BMI $1135 ; (nforml.s9 + 0)
.s1023:
1125 : d0 06 __ BNE $112d ; (nforml.s8 + 0)
.s1022:
1127 : a5 07 __ LDA WORK + 4 
1129 : c9 0a __ CMP #$0a
112b : 90 08 __ BCC $1135 ; (nforml.s9 + 0)
.s8:
112d : 18 __ __ CLC
112e : a5 07 __ LDA WORK + 4 
1130 : 69 37 __ ADC #$37
1132 : 4c 3a 11 JMP $113a ; (nforml.s10 + 0)
.s9:
1135 : 18 __ __ CLC
1136 : a5 07 __ LDA WORK + 4 
1138 : 69 30 __ ADC #$30
.s10:
113a : c6 44 __ DEC T2 + 0 
113c : a6 44 __ LDX T2 + 0 
113e : 9d e6 9f STA $9fe6,x ; (buffer + 0)
1141 : a5 11 __ LDA P4 ; (v + 0)
1143 : 85 1b __ STA ACCU + 0 
1145 : a5 12 __ LDA P5 ; (v + 1)
1147 : 85 1c __ STA ACCU + 1 
1149 : a5 13 __ LDA P6 ; (v + 2)
114b : 85 1d __ STA ACCU + 2 
114d : a5 14 __ LDA P7 ; (v + 3)
114f : 85 1e __ STA ACCU + 3 
1151 : a5 45 __ LDA T6 + 0 
1153 : 85 03 __ STA WORK + 0 
1155 : a5 46 __ LDA T6 + 1 
1157 : 85 04 __ STA WORK + 1 
1159 : a9 00 __ LDA #$00
115b : 85 05 __ STA WORK + 2 
115d : 85 06 __ STA WORK + 3 
115f : 20 d8 20 JSR $20d8 ; (divmod32 + 0)
1162 : a5 1b __ LDA ACCU + 0 
1164 : 85 11 __ STA P4 ; (v + 0)
1166 : a5 1c __ LDA ACCU + 1 
1168 : 85 12 __ STA P5 ; (v + 1)
116a : a5 1d __ LDA ACCU + 2 
116c : 85 13 __ STA P6 ; (v + 2)
116e : a5 1e __ LDA ACCU + 3 
1170 : 85 14 __ STA P7 ; (v + 3)
1172 : d0 85 __ BNE $10f9 ; (nforml.l6 + 0)
1174 : 4c 15 10 JMP $1015 ; (nforml.s1018 + 0)
--------------------------------------------------------------------
nformf:
.s0:
1177 : a5 15 __ LDA P8 ; (f + 0)
1179 : 85 43 __ STA T1 + 0 
117b : a5 16 __ LDA P9 ; (f + 1)
117d : 85 44 __ STA T1 + 1 
117f : a5 17 __ LDA P10 ; (f + 2)
1181 : 85 45 __ STA T1 + 2 
1183 : a5 18 __ LDA P11 ; (f + 3)
1185 : 29 7f __ AND #$7f
1187 : 05 17 __ ORA P10 ; (f + 2)
1189 : 05 16 __ ORA P9 ; (f + 1)
118b : 05 15 __ ORA P8 ; (f + 0)
118d : f0 21 __ BEQ $11b0 ; (nformf.s2 + 0)
.s1075:
118f : a5 18 __ LDA P11 ; (f + 3)
1191 : 10 1d __ BPL $11b0 ; (nformf.s2 + 0)
.s1:
1193 : a9 2d __ LDA #$2d
1195 : a0 00 __ LDY #$00
1197 : 91 13 __ STA (P6),y ; (str + 0)
1199 : a5 18 __ LDA P11 ; (f + 3)
119b : 49 80 __ EOR #$80
119d : 85 18 __ STA P11 ; (f + 3)
119f : 85 10 __ STA P3 
11a1 : a5 15 __ LDA P8 ; (f + 0)
11a3 : 85 0d __ STA P0 
11a5 : a5 16 __ LDA P9 ; (f + 1)
11a7 : 85 0e __ STA P1 
11a9 : a5 17 __ LDA P10 ; (f + 2)
11ab : 85 0f __ STA P2 
11ad : 4c 30 16 JMP $1630 ; (nformf.s189 + 0)
.s2:
11b0 : a5 15 __ LDA P8 ; (f + 0)
11b2 : 85 0d __ STA P0 
11b4 : a5 16 __ LDA P9 ; (f + 1)
11b6 : 85 0e __ STA P1 
11b8 : a5 17 __ LDA P10 ; (f + 2)
11ba : 85 0f __ STA P2 
11bc : a5 18 __ LDA P11 ; (f + 3)
11be : 85 10 __ STA P3 
11c0 : a0 05 __ LDY #$05
11c2 : b1 11 __ LDA (P4),y ; (si + 0)
11c4 : f0 09 __ BEQ $11cf ; (nformf.s3 + 0)
.s4:
11c6 : a9 2b __ LDA #$2b
11c8 : a0 00 __ LDY #$00
11ca : 91 13 __ STA (P6),y ; (str + 0)
11cc : 4c 30 16 JMP $1630 ; (nformf.s189 + 0)
.s3:
11cf : 20 48 16 JSR $1648 ; (isinf.s0 + 0)
11d2 : aa __ __ TAX
11d3 : a9 00 __ LDA #$00
11d5 : 85 48 __ STA T3 + 0 
11d7 : 8a __ __ TXA
11d8 : f0 0b __ BEQ $11e5 ; (nformf.s8 + 0)
.s160:
11da : a9 01 __ LDA #$01
11dc : 85 4a __ STA T5 + 0 
11de : a9 02 __ LDA #$02
11e0 : a0 00 __ LDY #$00
11e2 : 4c 14 16 JMP $1614 ; (nformf.s7 + 0)
.s8:
11e5 : a0 02 __ LDY #$02
11e7 : b1 11 __ LDA (P4),y ; (si + 0)
11e9 : c9 ff __ CMP #$ff
11eb : d0 02 __ BNE $11ef ; (nformf.s128 + 0)
.s129:
11ed : a9 06 __ LDA #$06
.s128:
11ef : 86 4a __ STX T5 + 0 
11f1 : 86 4b __ STX T5 + 1 
11f3 : 85 49 __ STA T4 + 0 
11f5 : 85 47 __ STA T2 + 0 
11f7 : a5 18 __ LDA P11 ; (f + 3)
11f9 : 85 46 __ STA T1 + 3 
11fb : 29 7f __ AND #$7f
11fd : 05 17 __ ORA P10 ; (f + 2)
11ff : 05 16 __ ORA P9 ; (f + 1)
1201 : 05 15 __ ORA P8 ; (f + 0)
1203 : f0 03 __ BEQ $1208 ; (nformf.s12 + 0)
1205 : 4c 15 15 JMP $1515 ; (nformf.s13 + 0)
.s12:
1208 : ad f6 9f LDA $9ff6 ; (sstack + 0)
120b : c9 65 __ CMP #$65
120d : d0 04 __ BNE $1213 ; (nformf.s1003 + 0)
.s1002:
120f : a9 01 __ LDA #$01
1211 : d0 02 __ BNE $1215 ; (nformf.s1004 + 0)
.s1003:
1213 : a9 00 __ LDA #$00
.s1004:
1215 : 85 4e __ STA T9 + 0 
1217 : a6 49 __ LDX T4 + 0 
1219 : e8 __ __ INX
121a : 86 4c __ STX T8 + 0 
121c : ad f6 9f LDA $9ff6 ; (sstack + 0)
121f : c9 67 __ CMP #$67
1221 : d0 13 __ BNE $1236 ; (nformf.s24 + 0)
.s22:
1223 : a5 4b __ LDA T5 + 1 
1225 : 30 08 __ BMI $122f ; (nformf.s25 + 0)
.s1046:
1227 : d0 06 __ BNE $122f ; (nformf.s25 + 0)
.s1045:
1229 : a5 4a __ LDA T5 + 0 
122b : c9 04 __ CMP #$04
122d : 90 07 __ BCC $1236 ; (nformf.s24 + 0)
.s25:
122f : a9 01 __ LDA #$01
1231 : 85 4e __ STA T9 + 0 
1233 : 4c 8d 14 JMP $148d ; (nformf.s30 + 0)
.s24:
1236 : a5 4e __ LDA T9 + 0 
1238 : f0 03 __ BEQ $123d ; (nformf.s32 + 0)
123a : 4c 8d 14 JMP $148d ; (nformf.s30 + 0)
.s32:
123d : a5 4b __ LDA T5 + 1 
123f : 10 3e __ BPL $127f ; (nformf.s34 + 0)
.s33:
1241 : a5 43 __ LDA T1 + 0 
1243 : 85 1b __ STA ACCU + 0 
1245 : a5 44 __ LDA T1 + 1 
1247 : 85 1c __ STA ACCU + 1 
1249 : a5 45 __ LDA T1 + 2 
124b : 85 1d __ STA ACCU + 2 
124d : a5 46 __ LDA T1 + 3 
124f : 85 1e __ STA ACCU + 3 
.l1082:
1251 : e6 4a __ INC T5 + 0 
1253 : d0 02 __ BNE $1257 ; (nformf.s1092 + 0)
.s1091:
1255 : e6 4b __ INC T5 + 1 
.s1092:
1257 : a9 00 __ LDA #$00
1259 : 85 03 __ STA WORK + 0 
125b : 85 04 __ STA WORK + 1 
125d : a9 20 __ LDA #$20
125f : 85 05 __ STA WORK + 2 
1261 : a9 41 __ LDA #$41
1263 : 85 06 __ STA WORK + 3 
1265 : 20 ce 1c JSR $1cce ; (freg + 20)
1268 : 20 b5 1e JSR $1eb5 ; (fdiv + 0)
126b : a5 4b __ LDA T5 + 1 
126d : 30 e2 __ BMI $1251 ; (nformf.l1082 + 0)
.s1083:
126f : a5 1e __ LDA ACCU + 3 
1271 : 85 46 __ STA T1 + 3 
1273 : a5 1d __ LDA ACCU + 2 
1275 : 85 45 __ STA T1 + 2 
1277 : a5 1c __ LDA ACCU + 1 
1279 : 85 44 __ STA T1 + 1 
127b : a5 1b __ LDA ACCU + 0 
127d : 85 43 __ STA T1 + 0 
.s34:
127f : 18 __ __ CLC
1280 : a5 49 __ LDA T4 + 0 
1282 : 65 4a __ ADC T5 + 0 
1284 : 18 __ __ CLC
1285 : 69 01 __ ADC #$01
1287 : 85 4c __ STA T8 + 0 
1289 : c9 07 __ CMP #$07
128b : 90 13 __ BCC $12a0 ; (nformf.s35 + 0)
.s36:
128d : ad 93 21 LDA $2193 ; (fround5 + 25)
1290 : 85 1c __ STA ACCU + 1 
1292 : ad 94 21 LDA $2194 ; (fround5 + 26)
1295 : 85 1d __ STA ACCU + 2 
1297 : ad 95 21 LDA $2195 ; (fround5 + 27)
129a : ae 92 21 LDX $2192 ; (fround5 + 24)
129d : 4c b3 12 JMP $12b3 ; (nformf.s214 + 0)
.s35:
12a0 : 0a __ __ ASL
12a1 : 0a __ __ ASL
12a2 : a8 __ __ TAY
12a3 : b9 77 21 LDA $2177,y ; (__multab3L + 9)
12a6 : 85 1c __ STA ACCU + 1 
12a8 : b9 78 21 LDA $2178,y ; (spentry + 0)
12ab : 85 1d __ STA ACCU + 2 
12ad : b9 79 21 LDA $2179,y ; (giocharmap + 0)
12b0 : be 76 21 LDX $2176,y ; (__multab3L + 8)
.s214:
12b3 : 86 1b __ STX ACCU + 0 
12b5 : 85 1e __ STA ACCU + 3 
12b7 : a2 43 __ LDX #$43
12b9 : 20 be 1c JSR $1cbe ; (freg + 4)
12bc : 20 ff 1c JSR $1cff ; (faddsub + 0)
12bf : a5 1c __ LDA ACCU + 1 
12c1 : 85 16 __ STA P9 ; (f + 1)
12c3 : a5 1d __ LDA ACCU + 2 
12c5 : 85 17 __ STA P10 ; (f + 2)
12c7 : a6 1b __ LDX ACCU + 0 
12c9 : a5 1e __ LDA ACCU + 3 
12cb : 85 18 __ STA P11 ; (f + 3)
12cd : 30 35 __ BMI $1304 ; (nformf.s31 + 0)
.s1028:
12cf : c9 41 __ CMP #$41
12d1 : d0 06 __ BNE $12d9 ; (nformf.s1032 + 0)
.s1029:
12d3 : a5 17 __ LDA P10 ; (f + 2)
12d5 : c9 20 __ CMP #$20
12d7 : f0 02 __ BEQ $12db ; (nformf.s38 + 0)
.s1032:
12d9 : 90 29 __ BCC $1304 ; (nformf.s31 + 0)
.s38:
12db : a9 00 __ LDA #$00
12dd : 85 03 __ STA WORK + 0 
12df : 85 04 __ STA WORK + 1 
12e1 : a9 20 __ LDA #$20
12e3 : 85 05 __ STA WORK + 2 
12e5 : a9 41 __ LDA #$41
12e7 : 85 06 __ STA WORK + 3 
12e9 : 20 ce 1c JSR $1cce ; (freg + 20)
12ec : 20 b5 1e JSR $1eb5 ; (fdiv + 0)
12ef : a5 1c __ LDA ACCU + 1 
12f1 : 85 16 __ STA P9 ; (f + 1)
12f3 : a5 1d __ LDA ACCU + 2 
12f5 : 85 17 __ STA P10 ; (f + 2)
12f7 : a5 1e __ LDA ACCU + 3 
12f9 : 85 18 __ STA P11 ; (f + 3)
12fb : 18 __ __ CLC
12fc : a5 49 __ LDA T4 + 0 
12fe : 69 ff __ ADC #$ff
1300 : 85 47 __ STA T2 + 0 
1302 : a6 1b __ LDX ACCU + 0 
.s31:
1304 : 38 __ __ SEC
1305 : a5 4c __ LDA T8 + 0 
1307 : e5 47 __ SBC T2 + 0 
1309 : 85 49 __ STA T4 + 0 
130b : a9 14 __ LDA #$14
130d : c5 4c __ CMP T8 + 0 
130f : b0 02 __ BCS $1313 ; (nformf.s49 + 0)
.s47:
1311 : 85 4c __ STA T8 + 0 
.s49:
1313 : a5 49 __ LDA T4 + 0 
1315 : d0 08 __ BNE $131f ; (nformf.s219 + 0)
.s50:
1317 : a9 30 __ LDA #$30
1319 : a4 48 __ LDY T3 + 0 
131b : 91 13 __ STA (P6),y ; (str + 0)
131d : e6 48 __ INC T3 + 0 
.s219:
131f : a9 00 __ LDA #$00
1321 : 85 47 __ STA T2 + 0 
1323 : c5 49 __ CMP T4 + 0 
1325 : d0 08 __ BNE $132f ; (nformf.l59 + 0)
.l57:
1327 : a9 2e __ LDA #$2e
1329 : a4 48 __ LDY T3 + 0 
132b : 91 13 __ STA (P6),y ; (str + 0)
132d : e6 48 __ INC T3 + 0 
.l59:
132f : a5 47 __ LDA T2 + 0 
1331 : c9 07 __ CMP #$07
1333 : 90 04 __ BCC $1339 ; (nformf.s61 + 0)
.s60:
1335 : a9 30 __ LDA #$30
1337 : d0 55 __ BNE $138e ; (nformf.s208 + 0)
.s61:
1339 : 86 1b __ STX ACCU + 0 
133b : 86 43 __ STX T1 + 0 
133d : a5 16 __ LDA P9 ; (f + 1)
133f : 85 1c __ STA ACCU + 1 
1341 : 85 44 __ STA T1 + 1 
1343 : a5 17 __ LDA P10 ; (f + 2)
1345 : 85 1d __ STA ACCU + 2 
1347 : 85 45 __ STA T1 + 2 
1349 : a5 18 __ LDA P11 ; (f + 3)
134b : 85 1e __ STA ACCU + 3 
134d : 85 46 __ STA T1 + 3 
134f : 20 4b 20 JSR $204b ; (f32_to_i16 + 0)
1352 : a5 1b __ LDA ACCU + 0 
1354 : 85 4f __ STA T11 + 0 
1356 : 20 8d 20 JSR $208d ; (sint16_to_float + 0)
1359 : a2 43 __ LDX #$43
135b : 20 be 1c JSR $1cbe ; (freg + 4)
135e : a5 1e __ LDA ACCU + 3 
1360 : 49 80 __ EOR #$80
1362 : 85 1e __ STA ACCU + 3 
1364 : 20 ff 1c JSR $1cff ; (faddsub + 0)
1367 : a9 00 __ LDA #$00
1369 : 85 03 __ STA WORK + 0 
136b : 85 04 __ STA WORK + 1 
136d : a9 20 __ LDA #$20
136f : 85 05 __ STA WORK + 2 
1371 : a9 41 __ LDA #$41
1373 : 85 06 __ STA WORK + 3 
1375 : 20 ce 1c JSR $1cce ; (freg + 20)
1378 : 20 e6 1d JSR $1de6 ; (fmul + 0)
137b : a5 1c __ LDA ACCU + 1 
137d : 85 16 __ STA P9 ; (f + 1)
137f : a5 1d __ LDA ACCU + 2 
1381 : 85 17 __ STA P10 ; (f + 2)
1383 : a5 1e __ LDA ACCU + 3 
1385 : 85 18 __ STA P11 ; (f + 3)
1387 : 18 __ __ CLC
1388 : a5 4f __ LDA T11 + 0 
138a : 69 30 __ ADC #$30
138c : a6 1b __ LDX ACCU + 0 
.s208:
138e : a4 48 __ LDY T3 + 0 
1390 : 91 13 __ STA (P6),y ; (str + 0)
1392 : e6 48 __ INC T3 + 0 
1394 : e6 47 __ INC T2 + 0 
1396 : a5 47 __ LDA T2 + 0 
1398 : c5 4c __ CMP T8 + 0 
139a : b0 07 __ BCS $13a3 ; (nformf.s56 + 0)
.s54:
139c : c5 49 __ CMP T4 + 0 
139e : d0 8f __ BNE $132f ; (nformf.l59 + 0)
13a0 : 4c 27 13 JMP $1327 ; (nformf.l57 + 0)
.s56:
13a3 : a5 4e __ LDA T9 + 0 
13a5 : f0 62 __ BEQ $1409 ; (nformf.s9 + 0)
.s63:
13a7 : a9 45 __ LDA #$45
13a9 : a4 48 __ LDY T3 + 0 
13ab : 91 13 __ STA (P6),y ; (str + 0)
13ad : c8 __ __ INY
13ae : a5 4b __ LDA T5 + 1 
13b0 : 30 06 __ BMI $13b8 ; (nformf.s66 + 0)
.s67:
13b2 : a9 2b __ LDA #$2b
13b4 : 91 13 __ STA (P6),y ; (str + 0)
13b6 : d0 11 __ BNE $13c9 ; (nformf.s68 + 0)
.s66:
13b8 : a9 2d __ LDA #$2d
13ba : 91 13 __ STA (P6),y ; (str + 0)
13bc : 38 __ __ SEC
13bd : a9 00 __ LDA #$00
13bf : e5 4a __ SBC T5 + 0 
13c1 : 85 4a __ STA T5 + 0 
13c3 : a9 00 __ LDA #$00
13c5 : e5 4b __ SBC T5 + 1 
13c7 : 85 4b __ STA T5 + 1 
.s68:
13c9 : a5 4a __ LDA T5 + 0 
13cb : 85 1b __ STA ACCU + 0 
13cd : a5 4b __ LDA T5 + 1 
13cf : 85 1c __ STA ACCU + 1 
13d1 : a9 0a __ LDA #$0a
13d3 : 85 03 __ STA WORK + 0 
13d5 : a9 00 __ LDA #$00
13d7 : 85 04 __ STA WORK + 1 
13d9 : 20 63 1f JSR $1f63 ; (divs16 + 0)
13dc : 18 __ __ CLC
13dd : a5 1b __ LDA ACCU + 0 
13df : 69 30 __ ADC #$30
13e1 : a4 48 __ LDY T3 + 0 
13e3 : c8 __ __ INY
13e4 : c8 __ __ INY
13e5 : 91 13 __ STA (P6),y ; (str + 0)
13e7 : a5 4a __ LDA T5 + 0 
13e9 : 85 1b __ STA ACCU + 0 
13eb : a5 4b __ LDA T5 + 1 
13ed : 85 1c __ STA ACCU + 1 
13ef : a9 0a __ LDA #$0a
13f1 : 85 03 __ STA WORK + 0 
13f3 : a9 00 __ LDA #$00
13f5 : 85 04 __ STA WORK + 1 
13f7 : 20 22 20 JSR $2022 ; (mods16 + 0)
13fa : 18 __ __ CLC
13fb : a5 05 __ LDA WORK + 2 
13fd : 69 30 __ ADC #$30
13ff : a4 48 __ LDY T3 + 0 
1401 : c8 __ __ INY
1402 : c8 __ __ INY
1403 : c8 __ __ INY
1404 : 91 13 __ STA (P6),y ; (str + 0)
1406 : c8 __ __ INY
1407 : 84 48 __ STY T3 + 0 
.s9:
1409 : a5 11 __ LDA P4 ; (si + 0)
140b : 85 4a __ STA T5 + 0 
140d : a5 12 __ LDA P5 ; (si + 1)
140f : 85 4b __ STA T5 + 1 
1411 : a5 48 __ LDA T3 + 0 
1413 : a0 01 __ LDY #$01
1415 : d1 11 __ CMP (P4),y ; (si + 0)
1417 : b0 5d __ BCS $1476 ; (nformf.s1001 + 0)
.s69:
1419 : a0 06 __ LDY #$06
141b : b1 11 __ LDA (P4),y ; (si + 0)
141d : f0 06 __ BEQ $1425 ; (nformf.s73 + 0)
.s72:
141f : a5 48 __ LDA T3 + 0 
1421 : aa __ __ TAX
1422 : 4c 7d 14 JMP $147d ; (nformf.l75 + 0)
.s73:
1425 : a5 48 __ LDA T3 + 0 
1427 : f0 2d __ BEQ $1456 ; (nformf.s82 + 0)
.s90:
1429 : a9 01 __ LDA #$01
142b : 85 47 __ STA T2 + 0 
142d : a6 48 __ LDX T3 + 0 
142f : 38 __ __ SEC
.l1080:
1430 : a0 01 __ LDY #$01
1432 : b1 11 __ LDA (P4),y ; (si + 0)
1434 : e5 47 __ SBC T2 + 0 
1436 : 85 4c __ STA T8 + 0 
1438 : a9 ff __ LDA #$ff
143a : 65 14 __ ADC P7 ; (str + 1)
143c : 85 4d __ STA T8 + 1 
143e : 8a __ __ TXA
143f : 38 __ __ SEC
1440 : e5 47 __ SBC T2 + 0 
1442 : 85 1b __ STA ACCU + 0 
1444 : a9 ff __ LDA #$ff
1446 : 65 14 __ ADC P7 ; (str + 1)
1448 : 85 1c __ STA ACCU + 1 
144a : a4 13 __ LDY P6 ; (str + 0)
144c : b1 1b __ LDA (ACCU + 0),y 
144e : 91 4c __ STA (T8 + 0),y 
1450 : e6 47 __ INC T2 + 0 
1452 : e4 47 __ CPX T2 + 0 
1454 : b0 da __ BCS $1430 ; (nformf.l1080 + 0)
.s82:
1456 : a9 00 __ LDA #$00
1458 : 85 47 __ STA T2 + 0 
.l83:
145a : a0 01 __ LDY #$01
145c : b1 4a __ LDA (T5 + 0),y 
145e : 38 __ __ SEC
145f : e5 48 __ SBC T3 + 0 
1461 : 90 06 __ BCC $1469 ; (nformf.s84 + 0)
.s1007:
1463 : c5 47 __ CMP T2 + 0 
1465 : 90 0d __ BCC $1474 ; (nformf.s74 + 0)
.s1084:
1467 : f0 0b __ BEQ $1474 ; (nformf.s74 + 0)
.s84:
1469 : a9 20 __ LDA #$20
146b : a4 47 __ LDY T2 + 0 
146d : 91 13 __ STA (P6),y ; (str + 0)
146f : e6 47 __ INC T2 + 0 
1471 : 4c 5a 14 JMP $145a ; (nformf.l83 + 0)
.s74:
1474 : b1 11 __ LDA (P4),y ; (si + 0)
.s1001:
1476 : 85 1b __ STA ACCU + 0 
1478 : a9 00 __ LDA #$00
147a : 85 1c __ STA ACCU + 1 
147c : 60 __ __ RTS
.l75:
147d : a0 01 __ LDY #$01
147f : d1 4a __ CMP (T5 + 0),y 
1481 : b0 f1 __ BCS $1474 ; (nformf.s74 + 0)
.s76:
1483 : a8 __ __ TAY
1484 : a9 20 __ LDA #$20
1486 : 91 13 __ STA (P6),y ; (str + 0)
1488 : e8 __ __ INX
1489 : 8a __ __ TXA
148a : 4c 7d 14 JMP $147d ; (nformf.l75 + 0)
.s30:
148d : a5 4c __ LDA T8 + 0 
148f : c9 07 __ CMP #$07
1491 : 90 13 __ BCC $14a6 ; (nformf.s41 + 0)
.s42:
1493 : ad 93 21 LDA $2193 ; (fround5 + 25)
1496 : 85 1c __ STA ACCU + 1 
1498 : ad 94 21 LDA $2194 ; (fround5 + 26)
149b : 85 1d __ STA ACCU + 2 
149d : ad 95 21 LDA $2195 ; (fround5 + 27)
14a0 : ae 92 21 LDX $2192 ; (fround5 + 24)
14a3 : 4c b9 14 JMP $14b9 ; (nformf.s204 + 0)
.s41:
14a6 : 0a __ __ ASL
14a7 : 0a __ __ ASL
14a8 : a8 __ __ TAY
14a9 : b9 77 21 LDA $2177,y ; (__multab3L + 9)
14ac : 85 1c __ STA ACCU + 1 
14ae : b9 78 21 LDA $2178,y ; (spentry + 0)
14b1 : 85 1d __ STA ACCU + 2 
14b3 : b9 79 21 LDA $2179,y ; (giocharmap + 0)
14b6 : be 76 21 LDX $2176,y ; (__multab3L + 8)
.s204:
14b9 : 86 1b __ STX ACCU + 0 
14bb : 85 1e __ STA ACCU + 3 
14bd : a2 43 __ LDX #$43
14bf : 20 be 1c JSR $1cbe ; (freg + 4)
14c2 : 20 ff 1c JSR $1cff ; (faddsub + 0)
14c5 : a5 1c __ LDA ACCU + 1 
14c7 : 85 16 __ STA P9 ; (f + 1)
14c9 : a5 1d __ LDA ACCU + 2 
14cb : 85 17 __ STA P10 ; (f + 2)
14cd : a6 1b __ LDX ACCU + 0 
14cf : a5 1e __ LDA ACCU + 3 
14d1 : 85 18 __ STA P11 ; (f + 3)
14d3 : 10 03 __ BPL $14d8 ; (nformf.s1038 + 0)
14d5 : 4c 04 13 JMP $1304 ; (nformf.s31 + 0)
.s1038:
14d8 : c9 41 __ CMP #$41
14da : d0 06 __ BNE $14e2 ; (nformf.s1042 + 0)
.s1039:
14dc : a5 17 __ LDA P10 ; (f + 2)
14de : c9 20 __ CMP #$20
14e0 : f0 05 __ BEQ $14e7 ; (nformf.s44 + 0)
.s1042:
14e2 : b0 03 __ BCS $14e7 ; (nformf.s44 + 0)
14e4 : 4c 04 13 JMP $1304 ; (nformf.s31 + 0)
.s44:
14e7 : a9 00 __ LDA #$00
14e9 : 85 03 __ STA WORK + 0 
14eb : 85 04 __ STA WORK + 1 
14ed : a9 20 __ LDA #$20
14ef : 85 05 __ STA WORK + 2 
14f1 : a9 41 __ LDA #$41
14f3 : 85 06 __ STA WORK + 3 
14f5 : 20 ce 1c JSR $1cce ; (freg + 20)
14f8 : 20 b5 1e JSR $1eb5 ; (fdiv + 0)
14fb : a5 1c __ LDA ACCU + 1 
14fd : 85 16 __ STA P9 ; (f + 1)
14ff : a5 1d __ LDA ACCU + 2 
1501 : 85 17 __ STA P10 ; (f + 2)
1503 : a5 1e __ LDA ACCU + 3 
1505 : 85 18 __ STA P11 ; (f + 3)
1507 : a6 1b __ LDX ACCU + 0 
1509 : e6 4a __ INC T5 + 0 
150b : f0 03 __ BEQ $1510 ; (nformf.s1089 + 0)
150d : 4c 04 13 JMP $1304 ; (nformf.s31 + 0)
.s1089:
1510 : e6 4b __ INC T5 + 1 
1512 : 4c 04 13 JMP $1304 ; (nformf.s31 + 0)
.s13:
1515 : a5 18 __ LDA P11 ; (f + 3)
1517 : 30 59 __ BMI $1572 ; (nformf.l17 + 0)
.l1068:
1519 : c9 44 __ CMP #$44
151b : f0 03 __ BEQ $1520 ; (nformf.s1069 + 0)
151d : 4c 0f 16 JMP $160f ; (nformf.s1072 + 0)
.s1069:
1520 : a5 45 __ LDA T1 + 2 
1522 : c9 7a __ CMP #$7a
1524 : f0 03 __ BEQ $1529 ; (nformf.s1070 + 0)
1526 : 4c 0f 16 JMP $160f ; (nformf.s1072 + 0)
.s1070:
1529 : a5 44 __ LDA T1 + 1 
152b : d0 04 __ BNE $1531 ; (nformf.s1079 + 0)
.s1071:
152d : a5 43 __ LDA T1 + 0 
152f : f0 02 __ BEQ $1533 ; (nformf.s14 + 0)
.s1079:
1531 : a5 43 __ LDA T1 + 0 
.s14:
1533 : 85 1b __ STA ACCU + 0 
1535 : a5 44 __ LDA T1 + 1 
1537 : 85 1c __ STA ACCU + 1 
1539 : a5 45 __ LDA T1 + 2 
153b : 85 1d __ STA ACCU + 2 
153d : a5 46 __ LDA T1 + 3 
153f : 85 1e __ STA ACCU + 3 
1541 : a9 00 __ LDA #$00
1543 : 85 03 __ STA WORK + 0 
1545 : 85 04 __ STA WORK + 1 
1547 : a9 7a __ LDA #$7a
1549 : 85 05 __ STA WORK + 2 
154b : a9 44 __ LDA #$44
154d : 85 06 __ STA WORK + 3 
154f : 20 ce 1c JSR $1cce ; (freg + 20)
1552 : 20 b5 1e JSR $1eb5 ; (fdiv + 0)
1555 : a5 1b __ LDA ACCU + 0 
1557 : 85 43 __ STA T1 + 0 
1559 : a5 1c __ LDA ACCU + 1 
155b : 85 44 __ STA T1 + 1 
155d : a5 1d __ LDA ACCU + 2 
155f : 85 45 __ STA T1 + 2 
1561 : 18 __ __ CLC
1562 : a5 4a __ LDA T5 + 0 
1564 : 69 03 __ ADC #$03
1566 : 85 4a __ STA T5 + 0 
1568 : 90 02 __ BCC $156c ; (nformf.s1094 + 0)
.s1093:
156a : e6 4b __ INC T5 + 1 
.s1094:
156c : a5 1e __ LDA ACCU + 3 
156e : 85 46 __ STA T1 + 3 
1570 : 10 a7 __ BPL $1519 ; (nformf.l1068 + 0)
.l17:
1572 : a9 00 __ LDA #$00
1574 : 85 1b __ STA ACCU + 0 
1576 : 85 1c __ STA ACCU + 1 
1578 : a9 7a __ LDA #$7a
157a : 85 1d __ STA ACCU + 2 
157c : a9 44 __ LDA #$44
157e : 85 1e __ STA ACCU + 3 
1580 : a2 43 __ LDX #$43
1582 : 20 be 1c JSR $1cbe ; (freg + 4)
1585 : 20 e6 1d JSR $1de6 ; (fmul + 0)
1588 : a5 1b __ LDA ACCU + 0 
158a : 85 43 __ STA T1 + 0 
158c : a5 1c __ LDA ACCU + 1 
158e : 85 44 __ STA T1 + 1 
1590 : a5 1d __ LDA ACCU + 2 
1592 : 85 45 __ STA T1 + 2 
1594 : a5 1e __ LDA ACCU + 3 
1596 : 85 46 __ STA T1 + 3 
1598 : 38 __ __ SEC
1599 : a5 4a __ LDA T5 + 0 
159b : e9 03 __ SBC #$03
159d : 85 4a __ STA T5 + 0 
159f : b0 02 __ BCS $15a3 ; (nformf.s16 + 0)
.s1085:
15a1 : c6 4b __ DEC T5 + 1 
.s16:
15a3 : a5 46 __ LDA T1 + 3 
15a5 : 30 cb __ BMI $1572 ; (nformf.l17 + 0)
.s1060:
15a7 : c9 3f __ CMP #$3f
15a9 : d0 06 __ BNE $15b1 ; (nformf.s1064 + 0)
.s1061:
15ab : a5 45 __ LDA T1 + 2 
15ad : c9 80 __ CMP #$80
15af : f0 02 __ BEQ $15b3 ; (nformf.s19 + 0)
.s1064:
15b1 : 90 bf __ BCC $1572 ; (nformf.l17 + 0)
.s19:
15b3 : a5 46 __ LDA T1 + 3 
15b5 : c9 41 __ CMP #$41
15b7 : d0 51 __ BNE $160a ; (nformf.l1056 + 0)
.s1053:
15b9 : a5 45 __ LDA T1 + 2 
15bb : c9 20 __ CMP #$20
15bd : d0 4b __ BNE $160a ; (nformf.l1056 + 0)
.s1054:
15bf : a5 44 __ LDA T1 + 1 
15c1 : d0 04 __ BNE $15c7 ; (nformf.l1078 + 0)
.s1055:
15c3 : a5 43 __ LDA T1 + 0 
15c5 : f0 02 __ BEQ $15c9 ; (nformf.l20 + 0)
.l1078:
15c7 : a5 43 __ LDA T1 + 0 
.l20:
15c9 : 85 1b __ STA ACCU + 0 
15cb : a5 44 __ LDA T1 + 1 
15cd : 85 1c __ STA ACCU + 1 
15cf : a5 45 __ LDA T1 + 2 
15d1 : 85 1d __ STA ACCU + 2 
15d3 : a5 46 __ LDA T1 + 3 
15d5 : 85 1e __ STA ACCU + 3 
15d7 : a9 00 __ LDA #$00
15d9 : 85 03 __ STA WORK + 0 
15db : 85 04 __ STA WORK + 1 
15dd : a9 20 __ LDA #$20
15df : 85 05 __ STA WORK + 2 
15e1 : a9 41 __ LDA #$41
15e3 : 85 06 __ STA WORK + 3 
15e5 : 20 ce 1c JSR $1cce ; (freg + 20)
15e8 : 20 b5 1e JSR $1eb5 ; (fdiv + 0)
15eb : a5 1b __ LDA ACCU + 0 
15ed : 85 43 __ STA T1 + 0 
15ef : a5 1c __ LDA ACCU + 1 
15f1 : 85 44 __ STA T1 + 1 
15f3 : a5 1d __ LDA ACCU + 2 
15f5 : 85 45 __ STA T1 + 2 
15f7 : e6 4a __ INC T5 + 0 
15f9 : d0 02 __ BNE $15fd ; (nformf.s1088 + 0)
.s1087:
15fb : e6 4b __ INC T5 + 1 
.s1088:
15fd : a5 1e __ LDA ACCU + 3 
15ff : 85 46 __ STA T1 + 3 
1601 : 10 03 __ BPL $1606 ; (nformf.s1052 + 0)
1603 : 4c 08 12 JMP $1208 ; (nformf.s12 + 0)
.s1052:
1606 : c9 41 __ CMP #$41
1608 : f0 af __ BEQ $15b9 ; (nformf.s1053 + 0)
.l1056:
160a : b0 bb __ BCS $15c7 ; (nformf.l1078 + 0)
160c : 4c 08 12 JMP $1208 ; (nformf.s12 + 0)
.s1072:
160f : 90 92 __ BCC $15a3 ; (nformf.s16 + 0)
1611 : 4c 31 15 JMP $1531 ; (nformf.s1079 + 0)
.s7:
1614 : 85 1b __ STA ACCU + 0 
1616 : a9 49 __ LDA #$49
1618 : 91 13 __ STA (P6),y ; (str + 0)
161a : a9 4e __ LDA #$4e
161c : a4 4a __ LDY T5 + 0 
161e : 91 13 __ STA (P6),y ; (str + 0)
1620 : a9 46 __ LDA #$46
1622 : a4 1b __ LDY ACCU + 0 
1624 : 91 13 __ STA (P6),y ; (str + 0)
1626 : 18 __ __ CLC
1627 : a5 48 __ LDA T3 + 0 
1629 : 69 03 __ ADC #$03
162b : 85 48 __ STA T3 + 0 
162d : 4c 09 14 JMP $1409 ; (nformf.s9 + 0)
.s189:
1630 : 20 48 16 JSR $1648 ; (isinf.s0 + 0)
1633 : aa __ __ TAX
1634 : a9 01 __ LDA #$01
1636 : 85 48 __ STA T3 + 0 
1638 : 8a __ __ TXA
1639 : d0 03 __ BNE $163e ; (nformf.s158 + 0)
163b : 4c e5 11 JMP $11e5 ; (nformf.s8 + 0)
.s158:
163e : a9 02 __ LDA #$02
1640 : 85 4a __ STA T5 + 0 
1642 : a9 03 __ LDA #$03
1644 : a0 01 __ LDY #$01
1646 : d0 cc __ BNE $1614 ; (nformf.s7 + 0)
--------------------------------------------------------------------
isinf:
.s0:
1648 : 06 0f __ ASL P2 ; (f + 2)
164a : a5 10 __ LDA P3 ; (f + 3)
164c : 2a __ __ ROL
164d : c9 ff __ CMP #$ff
164f : d0 03 __ BNE $1654 ; (isinf.s1003 + 0)
.s1002:
1651 : a9 01 __ LDA #$01
1653 : 60 __ __ RTS
.s1003:
1654 : a9 00 __ LDA #$00
.s1001:
1656 : 60 __ __ RTS
--------------------------------------------------------------------
fround5:
217a : __ __ __ BYT 00 00 00 3f cd cc 4c 3d 0a d7 a3 3b 6f 12 03 3a : ...?..L=...;o..:
218a : __ __ __ BYT 17 b7 51 38 ac c5 a7 36 bd 37 06 35             : ..Q8...6.7.5
--------------------------------------------------------------------
1657 : __ __ __ BYT 1e 53 43 4f 52 45 3a 20 25 64 00                : .SCORE: %d.
--------------------------------------------------------------------
spawn_enemy:
.s0:
1662 : 20 a0 16 JSR $16a0 ; (rand.s0 + 0)
1665 : 46 1b __ LSR ACCU + 0 
1667 : b0 0f __ BCS $1678 ; (spawn_enemy.s1001 + 0)
.s3:
1669 : a0 00 __ LDY #$00
.l6:
166b : be 6e 21 LDX $216e,y ; (__multab3L + 0)
166e : bd 9c 21 LDA $219c,x ; (Enemy + 2)
1671 : f0 06 __ BEQ $1679 ; (spawn_enemy.s9 + 0)
.s7:
1673 : c8 __ __ INY
1674 : c0 0a __ CPY #$0a
1676 : 90 f3 __ BCC $166b ; (spawn_enemy.l6 + 0)
.s1001:
1678 : 60 __ __ RTS
.s9:
1679 : 86 43 __ STX T0 + 0 
167b : a9 27 __ LDA #$27
167d : 9d 9a 21 STA $219a,x ; (Enemy + 0)
1680 : 20 a0 16 JSR $16a0 ; (rand.s0 + 0)
1683 : a9 01 __ LDA #$01
1685 : a6 43 __ LDX T0 + 0 
1687 : 9d 9c 21 STA $219c,x ; (Enemy + 2)
168a : a9 16 __ LDA #$16
168c : 85 03 __ STA WORK + 0 
168e : a9 00 __ LDA #$00
1690 : 85 04 __ STA WORK + 1 
1692 : 20 9d 1f JSR $1f9d ; (divmod + 0)
1695 : 18 __ __ CLC
1696 : a5 05 __ LDA WORK + 2 
1698 : 69 03 __ ADC #$03
169a : a6 43 __ LDX T0 + 0 
169c : 9d 9b 21 STA $219b,x ; (Enemy + 1)
169f : 60 __ __ RTS
--------------------------------------------------------------------
rand:
.s0:
16a0 : ad 97 21 LDA $2197 ; (seed + 1)
16a3 : 4a __ __ LSR
16a4 : ad 96 21 LDA $2196 ; (seed + 0)
16a7 : 6a __ __ ROR
16a8 : aa __ __ TAX
16a9 : a9 00 __ LDA #$00
16ab : 6a __ __ ROR
16ac : 4d 96 21 EOR $2196 ; (seed + 0)
16af : 85 1b __ STA ACCU + 0 
16b1 : 8a __ __ TXA
16b2 : 4d 97 21 EOR $2197 ; (seed + 1)
16b5 : 85 1c __ STA ACCU + 1 
16b7 : 4a __ __ LSR
16b8 : 45 1b __ EOR ACCU + 0 
16ba : 8d 96 21 STA $2196 ; (seed + 0)
16bd : 85 1b __ STA ACCU + 0 
16bf : 45 1c __ EOR ACCU + 1 
16c1 : 8d 97 21 STA $2197 ; (seed + 1)
16c4 : 85 1c __ STA ACCU + 1 
.s1001:
16c6 : 60 __ __ RTS
--------------------------------------------------------------------
seed:
2196 : __ __ __ BYT 00 7a                                           : .z
--------------------------------------------------------------------
move_enemies:
.s1000:
16c7 : a2 03 __ LDX #$03
16c9 : b5 53 __ LDA T0 + 0,x 
16cb : 9d 9f 9f STA $9f9f,x ; (move_enemies@stack + 0)
16ce : ca __ __ DEX
16cf : 10 f8 __ BPL $16c9 ; (move_enemies.s1000 + 2)
.s0:
16d1 : a2 00 __ LDX #$00
.l2:
16d3 : 86 53 __ STX T0 + 0 
16d5 : bc 6e 21 LDY $216e,x ; (__multab3L + 0)
16d8 : b9 9c 21 LDA $219c,y ; (Enemy + 2)
16db : c9 01 __ CMP #$01
16dd : d0 70 __ BNE $174f ; (move_enemies.s33 + 0)
.s5:
16df : 18 __ __ CLC
16e0 : a9 9a __ LDA #$9a
16e2 : 7d 6e 21 ADC $216e,x ; (__multab3L + 0)
16e5 : 85 54 __ STA T1 + 0 
16e7 : a9 21 __ LDA #$21
16e9 : 69 00 __ ADC #$00
16eb : 85 55 __ STA T1 + 1 
16ed : a0 01 __ LDY #$01
16ef : b1 54 __ LDA (T1 + 0),y 
16f1 : cd 99 21 CMP $2199 ; (Player + 1)
16f4 : d0 10 __ BNE $1706 ; (move_enemies.s10 + 0)
.s8:
16f6 : a5 54 __ LDA T1 + 0 
16f8 : 8d fe 9f STA $9ffe ; (sstack + 8)
16fb : a5 55 __ LDA T1 + 1 
16fd : 8d ff 9f STA $9fff ; (sstack + 9)
1700 : 20 b6 17 JSR $17b6 ; (spawn_enemy_shot.s1000 + 0)
1703 : 20 66 18 JSR $1866 ; (render_enemy_shots.s0 + 0)
.s10:
1706 : a0 00 __ LDY #$00
1708 : b1 54 __ LDA (T1 + 0),y 
170a : 85 56 __ STA T3 + 0 
170c : c8 __ __ INY
170d : b1 54 __ LDA (T1 + 0),y 
170f : 0a __ __ ASL
1710 : 85 1b __ STA ACCU + 0 
1712 : a9 00 __ LDA #$00
1714 : 2a __ __ ROL
1715 : 06 1b __ ASL ACCU + 0 
1717 : 2a __ __ ROL
1718 : aa __ __ TAX
1719 : a5 1b __ LDA ACCU + 0 
171b : 71 54 __ ADC (T1 + 0),y 
171d : 85 46 __ STA T5 + 0 
171f : 8a __ __ TXA
1720 : 69 00 __ ADC #$00
1722 : 06 46 __ ASL T5 + 0 
1724 : 2a __ __ ROL
1725 : 06 46 __ ASL T5 + 0 
1727 : 2a __ __ ROL
1728 : 06 46 __ ASL T5 + 0 
172a : 2a __ __ ROL
172b : aa __ __ TAX
172c : 18 __ __ CLC
172d : a5 46 __ LDA T5 + 0 
172f : 65 56 __ ADC T3 + 0 
1731 : 85 43 __ STA T2 + 0 
1733 : 85 1f __ STA ADDR + 0 
1735 : 8a __ __ TXA
1736 : 69 04 __ ADC #$04
1738 : 85 44 __ STA T2 + 1 
173a : 18 __ __ CLC
173b : 69 d4 __ ADC #$d4
173d : 85 20 __ STA ADDR + 1 
173f : a9 20 __ LDA #$20
1741 : 88 __ __ DEY
1742 : 91 43 __ STA (T2 + 0),y 
1744 : 98 __ __ TYA
1745 : 91 1f __ STA (ADDR + 0),y 
1747 : a5 56 __ LDA T3 + 0 
1749 : d0 19 __ BNE $1764 ; (move_enemies.s11 + 0)
.s12:
174b : a0 02 __ LDY #$02
.s1012:
174d : 91 54 __ STA (T1 + 0),y 
.s33:
174f : a6 53 __ LDX T0 + 0 
1751 : e8 __ __ INX
1752 : e0 0a __ CPX #$0a
1754 : b0 03 __ BCS $1759 ; (move_enemies.s1001 + 0)
1756 : 4c d3 16 JMP $16d3 ; (move_enemies.l2 + 0)
.s1001:
1759 : a2 03 __ LDX #$03
175b : bd 9f 9f LDA $9f9f,x ; (move_enemies@stack + 0)
175e : 95 53 __ STA T0 + 0,x 
1760 : ca __ __ DEX
1761 : 10 f8 __ BPL $175b ; (move_enemies.s1001 + 2)
1763 : 60 __ __ RTS
.s11:
1764 : c6 56 __ DEC T3 + 0 
1766 : a5 56 __ LDA T3 + 0 
1768 : 91 54 __ STA (T1 + 0),y 
176a : 20 a0 16 JSR $16a0 ; (rand.s0 + 0)
176d : a0 01 __ LDY #$01
176f : b1 54 __ LDA (T1 + 0),y 
1771 : 85 45 __ STA T4 + 0 
1773 : a9 03 __ LDA #$03
1775 : 85 03 __ STA WORK + 0 
1777 : a9 00 __ LDA #$00
1779 : 85 04 __ STA WORK + 1 
177b : 20 9d 1f JSR $1f9d ; (divmod + 0)
177e : 38 __ __ SEC
177f : a5 05 __ LDA WORK + 2 
1781 : e9 01 __ SBC #$01
1783 : aa __ __ TAX
1784 : a5 06 __ LDA WORK + 3 
1786 : e9 00 __ SBC #$00
1788 : a8 __ __ TAY
1789 : 8a __ __ TXA
178a : 18 __ __ CLC
178b : 65 45 __ ADC T4 + 0 
178d : 85 43 __ STA T2 + 0 
178f : 90 01 __ BCC $1792 ; (move_enemies.s1014 + 0)
.s1013:
1791 : c8 __ __ INY
.s1014:
1792 : 0a __ __ ASL
1793 : 0a __ __ ASL
1794 : 18 __ __ CLC
1795 : 65 43 __ ADC T2 + 0 
1797 : 0a __ __ ASL
1798 : 0a __ __ ASL
1799 : 0a __ __ ASL
179a : 18 __ __ CLC
179b : 65 56 __ ADC T3 + 0 
179d : aa __ __ TAX
179e : bd 00 04 LDA $0400,x 
17a1 : c9 58 __ CMP #$58
17a3 : f0 aa __ BEQ $174f ; (move_enemies.s33 + 0)
.s18:
17a5 : 98 __ __ TYA
17a6 : d0 a7 __ BNE $174f ; (move_enemies.s33 + 0)
.s1005:
17a8 : a5 43 __ LDA T2 + 0 
17aa : c9 03 __ CMP #$03
17ac : 90 a1 __ BCC $174f ; (move_enemies.s33 + 0)
.s1004:
17ae : c9 19 __ CMP #$19
17b0 : b0 9d __ BCS $174f ; (move_enemies.s33 + 0)
.s14:
17b2 : a0 01 __ LDY #$01
17b4 : d0 97 __ BNE $174d ; (move_enemies.s1012 + 0)
--------------------------------------------------------------------
spawn_enemy_shot:
.s1000:
17b6 : a5 53 __ LDA T1 + 0 
17b8 : 8d a3 9f STA $9fa3 ; (spawn_enemy_shot@stack + 0)
17bb : a5 54 __ LDA T3 + 0 
17bd : 8d a4 9f STA $9fa4 ; (spawn_enemy_shot@stack + 1)
17c0 : 38 __ __ SEC
17c1 : a5 23 __ LDA SP + 0 
17c3 : e9 08 __ SBC #$08
17c5 : 85 23 __ STA SP + 0 
17c7 : b0 02 __ BCS $17cb ; (spawn_enemy_shot.s0 + 0)
17c9 : c6 24 __ DEC SP + 1 
.s0:
17cb : ad fe 9f LDA $9ffe ; (sstack + 8)
17ce : 85 43 __ STA T0 + 0 
17d0 : ad ff 9f LDA $9fff ; (sstack + 9)
17d3 : 85 44 __ STA T0 + 1 
17d5 : a0 00 __ LDY #$00
17d7 : b1 43 __ LDA (T0 + 0),y 
17d9 : f0 0f __ BEQ $17ea ; (spawn_enemy_shot.s1001 + 0)
.s3:
17db : a2 00 __ LDX #$00
.l6:
17dd : bc 6e 21 LDY $216e,x ; (__multab3L + 0)
17e0 : b9 c3 21 LDA $21c3,y ; (EnemyShot + 2)
17e3 : f0 1b __ BEQ $1800 ; (spawn_enemy_shot.s9 + 0)
.s7:
17e5 : e8 __ __ INX
17e6 : e0 03 __ CPX #$03
17e8 : 90 f3 __ BCC $17dd ; (spawn_enemy_shot.l6 + 0)
.s1001:
17ea : 18 __ __ CLC
17eb : a5 23 __ LDA SP + 0 
17ed : 69 08 __ ADC #$08
17ef : 85 23 __ STA SP + 0 
17f1 : 90 02 __ BCC $17f5 ; (spawn_enemy_shot.s1001 + 11)
17f3 : e6 24 __ INC SP + 1 
17f5 : ad a3 9f LDA $9fa3 ; (spawn_enemy_shot@stack + 0)
17f8 : 85 53 __ STA T1 + 0 
17fa : ad a4 9f LDA $9fa4 ; (spawn_enemy_shot@stack + 1)
17fd : 85 54 __ STA T3 + 0 
17ff : 60 __ __ RTS
.s9:
1800 : a9 14 __ LDA #$14
1802 : 85 0d __ STA P0 
1804 : a9 00 __ LDA #$00
1806 : 85 0e __ STA P1 
1808 : 85 10 __ STA P3 
180a : a9 01 __ LDA #$01
180c : 85 0f __ STA P2 
180e : 99 c3 21 STA $21c3,y ; (EnemyShot + 2)
1811 : ad fe 9f LDA $9ffe ; (sstack + 8)
1814 : 85 45 __ STA T2 + 0 
1816 : ad ff 9f LDA $9fff ; (sstack + 9)
1819 : 85 46 __ STA T2 + 1 
181b : a0 00 __ LDY #$00
181d : b1 45 __ LDA (T2 + 0),y 
181f : 38 __ __ SEC
1820 : e9 01 __ SBC #$01
1822 : 85 54 __ STA T3 + 0 
1824 : bc 6e 21 LDY $216e,x ; (__multab3L + 0)
1827 : 99 c1 21 STA $21c1,y ; (EnemyShot + 0)
182a : a0 01 __ LDY #$01
182c : b1 45 __ LDA (T2 + 0),y 
182e : 85 53 __ STA T1 + 0 
1830 : bc 6e 21 LDY $216e,x ; (__multab3L + 0)
1833 : 99 c2 21 STA $21c2,y ; (EnemyShot + 1)
1836 : 20 ae 09 JSR $09ae ; (gotoxy.s0 + 0)
1839 : a9 5e __ LDA #$5e
183b : a0 02 __ LDY #$02
183d : 91 23 __ STA (SP + 0),y 
183f : a9 18 __ LDA #$18
1841 : c8 __ __ INY
1842 : 91 23 __ STA (SP + 0),y 
1844 : a5 54 __ LDA T3 + 0 
1846 : c8 __ __ INY
1847 : 91 23 __ STA (SP + 0),y 
1849 : a9 00 __ LDA #$00
184b : c8 __ __ INY
184c : 91 23 __ STA (SP + 0),y 
184e : a5 53 __ LDA T1 + 0 
1850 : c8 __ __ INY
1851 : 91 23 __ STA (SP + 0),y 
1853 : a9 00 __ LDA #$00
1855 : c8 __ __ INY
1856 : 91 23 __ STA (SP + 0),y 
1858 : 20 b7 09 JSR $09b7 ; (printf.s0 + 0)
185b : 4c ea 17 JMP $17ea ; (spawn_enemy_shot.s1001 + 0)
--------------------------------------------------------------------
185e : __ __ __ BYT 25 64 20 2d 20 25 64 00                         : %d - %d.
--------------------------------------------------------------------
render_enemy_shots:
.s0:
1866 : a2 00 __ LDX #$00
.l1006:
1868 : bc 6e 21 LDY $216e,x ; (__multab3L + 0)
186b : b9 c3 21 LDA $21c3,y ; (EnemyShot + 2)
186e : c9 01 __ CMP #$01
1870 : d0 43 __ BNE $18b5 ; (render_enemy_shots.s19 + 0)
.s5:
1872 : b9 c2 21 LDA $21c2,y ; (EnemyShot + 1)
1875 : 0a __ __ ASL
1876 : 85 1b __ STA ACCU + 0 
1878 : a9 00 __ LDA #$00
187a : 2a __ __ ROL
187b : 06 1b __ ASL ACCU + 0 
187d : 2a __ __ ROL
187e : 85 1c __ STA ACCU + 1 
1880 : a5 1b __ LDA ACCU + 0 
1882 : 79 c2 21 ADC $21c2,y ; (EnemyShot + 1)
1885 : 85 1b __ STA ACCU + 0 
1887 : a5 1c __ LDA ACCU + 1 
1889 : 69 00 __ ADC #$00
188b : 06 1b __ ASL ACCU + 0 
188d : 2a __ __ ROL
188e : 06 1b __ ASL ACCU + 0 
1890 : 2a __ __ ROL
1891 : 06 1b __ ASL ACCU + 0 
1893 : 2a __ __ ROL
1894 : 85 1c __ STA ACCU + 1 
1896 : 18 __ __ CLC
1897 : a5 1b __ LDA ACCU + 0 
1899 : 79 c1 21 ADC $21c1,y ; (EnemyShot + 0)
189c : 85 1b __ STA ACCU + 0 
189e : 85 1f __ STA ADDR + 0 
18a0 : a5 1c __ LDA ACCU + 1 
18a2 : 69 04 __ ADC #$04
18a4 : 85 1c __ STA ACCU + 1 
18a6 : 18 __ __ CLC
18a7 : 69 d4 __ ADC #$d4
18a9 : 85 20 __ STA ADDR + 1 
18ab : a9 1f __ LDA #$1f
18ad : a0 00 __ LDY #$00
18af : 91 1b __ STA (ACCU + 0),y 
18b1 : a9 01 __ LDA #$01
18b3 : 91 1f __ STA (ADDR + 0),y 
.s19:
18b5 : e8 __ __ INX
18b6 : e0 03 __ CPX #$03
18b8 : 90 ae __ BCC $1868 ; (render_enemy_shots.l1006 + 0)
.s1001:
18ba : 60 __ __ RTS
--------------------------------------------------------------------
render_enemies:
.s0:
18bb : a2 00 __ LDX #$00
.l1006:
18bd : bc 6e 21 LDY $216e,x ; (__multab3L + 0)
18c0 : b9 9c 21 LDA $219c,y ; (Enemy + 2)
18c3 : c9 01 __ CMP #$01
18c5 : d0 43 __ BNE $190a ; (render_enemies.s19 + 0)
.s5:
18c7 : b9 9b 21 LDA $219b,y ; (Enemy + 1)
18ca : 0a __ __ ASL
18cb : 85 1b __ STA ACCU + 0 
18cd : a9 00 __ LDA #$00
18cf : 2a __ __ ROL
18d0 : 06 1b __ ASL ACCU + 0 
18d2 : 2a __ __ ROL
18d3 : 85 1c __ STA ACCU + 1 
18d5 : a5 1b __ LDA ACCU + 0 
18d7 : 79 9b 21 ADC $219b,y ; (Enemy + 1)
18da : 85 1b __ STA ACCU + 0 
18dc : a5 1c __ LDA ACCU + 1 
18de : 69 00 __ ADC #$00
18e0 : 06 1b __ ASL ACCU + 0 
18e2 : 2a __ __ ROL
18e3 : 06 1b __ ASL ACCU + 0 
18e5 : 2a __ __ ROL
18e6 : 06 1b __ ASL ACCU + 0 
18e8 : 2a __ __ ROL
18e9 : 85 1c __ STA ACCU + 1 
18eb : 18 __ __ CLC
18ec : a5 1b __ LDA ACCU + 0 
18ee : 79 9a 21 ADC $219a,y ; (Enemy + 0)
18f1 : 85 1b __ STA ACCU + 0 
18f3 : 85 1f __ STA ADDR + 0 
18f5 : a5 1c __ LDA ACCU + 1 
18f7 : 69 04 __ ADC #$04
18f9 : 85 1c __ STA ACCU + 1 
18fb : 18 __ __ CLC
18fc : 69 d4 __ ADC #$d4
18fe : 85 20 __ STA ADDR + 1 
1900 : a9 58 __ LDA #$58
1902 : a0 00 __ LDY #$00
1904 : 91 1b __ STA (ACCU + 0),y 
1906 : a9 08 __ LDA #$08
1908 : 91 1f __ STA (ADDR + 0),y 
.s19:
190a : e8 __ __ INX
190b : e0 0a __ CPX #$0a
190d : 90 ae __ BCC $18bd ; (render_enemies.l1006 + 0)
.s1001:
190f : 60 __ __ RTS
--------------------------------------------------------------------
move_enemy_shots:
.s0:
1910 : a2 00 __ LDX #$00
.l1008:
1912 : bc 6e 21 LDY $216e,x ; (__multab3L + 0)
1915 : b9 c3 21 LDA $21c3,y ; (EnemyShot + 2)
1918 : c9 01 __ CMP #$01
191a : d0 58 __ BNE $1974 ; (move_enemy_shots.s23 + 0)
.s5:
191c : 84 1d __ STY ACCU + 2 
191e : b9 c2 21 LDA $21c2,y ; (EnemyShot + 1)
1921 : 0a __ __ ASL
1922 : 85 1b __ STA ACCU + 0 
1924 : a9 00 __ LDA #$00
1926 : 2a __ __ ROL
1927 : 06 1b __ ASL ACCU + 0 
1929 : 2a __ __ ROL
192a : 85 1c __ STA ACCU + 1 
192c : a5 1b __ LDA ACCU + 0 
192e : 79 c2 21 ADC $21c2,y ; (EnemyShot + 1)
1931 : 85 1b __ STA ACCU + 0 
1933 : a5 1c __ LDA ACCU + 1 
1935 : 69 00 __ ADC #$00
1937 : 06 1b __ ASL ACCU + 0 
1939 : 2a __ __ ROL
193a : 06 1b __ ASL ACCU + 0 
193c : 2a __ __ ROL
193d : 06 1b __ ASL ACCU + 0 
193f : 2a __ __ ROL
1940 : 85 1c __ STA ACCU + 1 
1942 : b9 c1 21 LDA $21c1,y ; (EnemyShot + 0)
1945 : 85 1e __ STA ACCU + 3 
1947 : 18 __ __ CLC
1948 : 65 1b __ ADC ACCU + 0 
194a : 85 1b __ STA ACCU + 0 
194c : 85 1f __ STA ADDR + 0 
194e : a5 1c __ LDA ACCU + 1 
1950 : 69 04 __ ADC #$04
1952 : 85 1c __ STA ACCU + 1 
1954 : 18 __ __ CLC
1955 : 69 d4 __ ADC #$d4
1957 : 85 20 __ STA ADDR + 1 
1959 : a9 20 __ LDA #$20
195b : a0 00 __ LDY #$00
195d : 91 1b __ STA (ACCU + 0),y 
195f : 98 __ __ TYA
1960 : 91 1f __ STA (ADDR + 0),y 
1962 : c6 1e __ DEC ACCU + 3 
1964 : a5 1e __ LDA ACCU + 3 
1966 : a4 1d __ LDY ACCU + 2 
1968 : 99 c1 21 STA $21c1,y ; (EnemyShot + 0)
196b : c9 ff __ CMP #$ff
196d : d0 05 __ BNE $1974 ; (move_enemy_shots.s23 + 0)
.s8:
196f : a9 00 __ LDA #$00
1971 : 99 c3 21 STA $21c3,y ; (EnemyShot + 2)
.s23:
1974 : e8 __ __ INX
1975 : e0 03 __ CPX #$03
1977 : 90 99 __ BCC $1912 ; (move_enemy_shots.l1008 + 0)
.s1001:
1979 : 60 __ __ RTS
--------------------------------------------------------------------
check_player_enemy_collision:
.s0:
197a : a0 00 __ LDY #$00
.l2:
197c : be 6e 21 LDX $216e,y ; (__multab3L + 0)
197f : bd 9c 21 LDA $219c,x ; (Enemy + 2)
1982 : c9 01 __ CMP #$01
1984 : d0 10 __ BNE $1996 ; (check_player_enemy_collision.s3 + 0)
.s5:
1986 : bd 9a 21 LDA $219a,x ; (Enemy + 0)
1989 : cd 98 21 CMP $2198 ; (Player + 0)
198c : d0 08 __ BNE $1996 ; (check_player_enemy_collision.s3 + 0)
.s11:
198e : bd 9b 21 LDA $219b,x ; (Enemy + 1)
1991 : cd 99 21 CMP $2199 ; (Player + 1)
1994 : f0 2d __ BEQ $19c3 ; (check_player_enemy_collision.s8 + 0)
.s3:
1996 : c8 __ __ INY
1997 : c0 0a __ CPY #$0a
1999 : 90 e1 __ BCC $197c ; (check_player_enemy_collision.l2 + 0)
.s4:
199b : a0 00 __ LDY #$00
.l13:
199d : be 6e 21 LDX $216e,y ; (__multab3L + 0)
19a0 : bd c3 21 LDA $21c3,x ; (EnemyShot + 2)
19a3 : c9 01 __ CMP #$01
19a5 : d0 10 __ BNE $19b7 ; (check_player_enemy_collision.s14 + 0)
.s16:
19a7 : bd c1 21 LDA $21c1,x ; (EnemyShot + 0)
19aa : cd 98 21 CMP $2198 ; (Player + 0)
19ad : d0 08 __ BNE $19b7 ; (check_player_enemy_collision.s14 + 0)
.s22:
19af : bd c2 21 LDA $21c2,x ; (EnemyShot + 1)
19b2 : cd 99 21 CMP $2199 ; (Player + 1)
19b5 : f0 06 __ BEQ $19bd ; (check_player_enemy_collision.s19 + 0)
.s14:
19b7 : c8 __ __ INY
19b8 : c0 03 __ CPY #$03
19ba : 90 e1 __ BCC $199d ; (check_player_enemy_collision.l13 + 0)
.s1001:
19bc : 60 __ __ RTS
.s19:
19bd : a9 01 __ LDA #$01
19bf : 8d ca 21 STA $21ca ; (game + 0)
19c2 : 60 __ __ RTS
.s8:
19c3 : a9 01 __ LDA #$01
19c5 : 8d ca 21 STA $21ca ; (game + 0)
19c8 : d0 d1 __ BNE $199b ; (check_player_enemy_collision.s4 + 0)
--------------------------------------------------------------------
control_player_ship:
.s0:
19ca : a9 00 __ LDA #$00
19cc : 20 6c 1a JSR $1a6c ; (joy_poll.s0 + 0)
19cf : ad d1 21 LDA $21d1 ; (joyx + 0)
19d2 : 85 1d __ STA ACCU + 2 
19d4 : 85 1e __ STA ACCU + 3 
19d6 : d0 08 __ BNE $19e0 ; (control_player_ship.s1 + 0)
.s4:
19d8 : ad cf 21 LDA $21cf ; (joyy + 0)
19db : d0 03 __ BNE $19e0 ; (control_player_ship.s1 + 0)
19dd : 4c 61 1a JMP $1a61 ; (control_player_ship.s3 + 0)
.s1:
19e0 : ad 98 21 LDA $2198 ; (Player + 0)
19e3 : 85 43 __ STA T2 + 0 
19e5 : 85 44 __ STA T3 + 0 
19e7 : ad 99 21 LDA $2199 ; (Player + 1)
19ea : 85 45 __ STA T4 + 0 
19ec : 85 46 __ STA T5 + 0 
19ee : 0a __ __ ASL
19ef : 85 1b __ STA ACCU + 0 
19f1 : a9 00 __ LDA #$00
19f3 : 2a __ __ ROL
19f4 : 06 1b __ ASL ACCU + 0 
19f6 : 2a __ __ ROL
19f7 : aa __ __ TAX
19f8 : a5 1b __ LDA ACCU + 0 
19fa : 65 45 __ ADC T4 + 0 
19fc : 85 1b __ STA ACCU + 0 
19fe : 8a __ __ TXA
19ff : 69 00 __ ADC #$00
1a01 : 06 1b __ ASL ACCU + 0 
1a03 : 2a __ __ ROL
1a04 : 06 1b __ ASL ACCU + 0 
1a06 : 2a __ __ ROL
1a07 : 06 1b __ ASL ACCU + 0 
1a09 : 2a __ __ ROL
1a0a : aa __ __ TAX
1a0b : 18 __ __ CLC
1a0c : a5 1b __ LDA ACCU + 0 
1a0e : 65 43 __ ADC T2 + 0 
1a10 : 85 1b __ STA ACCU + 0 
1a12 : 85 1f __ STA ADDR + 0 
1a14 : 8a __ __ TXA
1a15 : 69 04 __ ADC #$04
1a17 : 85 1c __ STA ACCU + 1 
1a19 : 18 __ __ CLC
1a1a : 69 d4 __ ADC #$d4
1a1c : 85 20 __ STA ADDR + 1 
1a1e : a9 20 __ LDA #$20
1a20 : a0 00 __ LDY #$00
1a22 : 91 1b __ STA (ACCU + 0),y 
1a24 : 98 __ __ TYA
1a25 : 91 1f __ STA (ADDR + 0),y 
1a27 : a5 43 __ LDA T2 + 0 
1a29 : f0 04 __ BEQ $1a2f ; (control_player_ship.s6 + 0)
.s8:
1a2b : a5 1d __ LDA ACCU + 2 
1a2d : 30 0c __ BMI $1a3b ; (control_player_ship.s5 + 0)
.s6:
1a2f : a5 43 __ LDA T2 + 0 
1a31 : c9 27 __ CMP #$27
1a33 : b0 0e __ BCS $1a43 ; (control_player_ship.s7 + 0)
.s12:
1a35 : a5 1d __ LDA ACCU + 2 
1a37 : 30 0a __ BMI $1a43 ; (control_player_ship.s7 + 0)
.s1009:
1a39 : f0 08 __ BEQ $1a43 ; (control_player_ship.s7 + 0)
.s5:
1a3b : 18 __ __ CLC
1a3c : a5 44 __ LDA T3 + 0 
1a3e : 65 1e __ ADC ACCU + 3 
1a40 : 8d 98 21 STA $2198 ; (Player + 0)
.s7:
1a43 : a5 45 __ LDA T4 + 0 
1a45 : c9 04 __ CMP #$04
1a47 : 90 07 __ BCC $1a50 ; (control_player_ship.s14 + 0)
.s16:
1a49 : ad cf 21 LDA $21cf ; (joyy + 0)
1a4c : 30 0d __ BMI $1a5b ; (control_player_ship.s32 + 0)
.s1012:
1a4e : a5 45 __ LDA T4 + 0 
.s14:
1a50 : c9 18 __ CMP #$18
1a52 : b0 0d __ BCS $1a61 ; (control_player_ship.s3 + 0)
.s20:
1a54 : ad cf 21 LDA $21cf ; (joyy + 0)
1a57 : 30 08 __ BMI $1a61 ; (control_player_ship.s3 + 0)
.s1004:
1a59 : f0 06 __ BEQ $1a61 ; (control_player_ship.s3 + 0)
.s32:
1a5b : 18 __ __ CLC
1a5c : 65 46 __ ADC T5 + 0 
1a5e : 8d 99 21 STA $2199 ; (Player + 1)
.s3:
1a61 : ad d3 21 LDA $21d3 ; (joyb + 0)
1a64 : c9 01 __ CMP #$01
1a66 : f0 01 __ BEQ $1a69 ; (control_player_ship.s21 + 0)
.s1001:
1a68 : 60 __ __ RTS
.s21:
1a69 : 4c ac 1a JMP $1aac ; (spawn_player_shot.s0 + 0)
--------------------------------------------------------------------
joy_poll:
.s0:
1a6c : aa __ __ TAX
1a6d : bd 00 dc LDA $dc00,x 
1a70 : a8 __ __ TAY
1a71 : 29 10 __ AND #$10
1a73 : f0 04 __ BEQ $1a79 ; (joy_poll.s1005 + 0)
.s1006:
1a75 : a9 00 __ LDA #$00
1a77 : f0 02 __ BEQ $1a7b ; (joy_poll.s1007 + 0)
.s1005:
1a79 : a9 01 __ LDA #$01
.s1007:
1a7b : 9d d3 21 STA $21d3,x ; (joyb + 0)
1a7e : 98 __ __ TYA
1a7f : 4a __ __ LSR
1a80 : b0 1d __ BCS $1a9f ; (joy_poll.s2 + 0)
.s1:
1a82 : a9 ff __ LDA #$ff
.s15:
1a84 : 9d cf 21 STA $21cf,x ; (joyy + 0)
1a87 : 98 __ __ TYA
1a88 : 29 04 __ AND #$04
1a8a : d0 06 __ BNE $1a92 ; (joy_poll.s8 + 0)
.s7:
1a8c : a9 ff __ LDA #$ff
.s1001:
1a8e : 9d d1 21 STA $21d1,x ; (joyx + 0)
1a91 : 60 __ __ RTS
.s8:
1a92 : 98 __ __ TYA
1a93 : 29 08 __ AND #$08
1a95 : f0 04 __ BEQ $1a9b ; (joy_poll.s1011 + 0)
.s1012:
1a97 : a9 00 __ LDA #$00
1a99 : f0 f3 __ BEQ $1a8e ; (joy_poll.s1001 + 0)
.s1011:
1a9b : a9 01 __ LDA #$01
1a9d : d0 ef __ BNE $1a8e ; (joy_poll.s1001 + 0)
.s2:
1a9f : 98 __ __ TYA
1aa0 : 29 02 __ AND #$02
1aa2 : f0 04 __ BEQ $1aa8 ; (joy_poll.s1008 + 0)
.s1009:
1aa4 : a9 00 __ LDA #$00
1aa6 : f0 dc __ BEQ $1a84 ; (joy_poll.s15 + 0)
.s1008:
1aa8 : a9 01 __ LDA #$01
1aaa : d0 d8 __ BNE $1a84 ; (joy_poll.s15 + 0)
--------------------------------------------------------------------
joyy:
21cf : __ __ __ BSS	2
--------------------------------------------------------------------
joyx:
21d1 : __ __ __ BSS	2
--------------------------------------------------------------------
joyb:
21d3 : __ __ __ BSS	2
--------------------------------------------------------------------
spawn_player_shot:
.s0:
1aac : ad 98 21 LDA $2198 ; (Player + 0)
1aaf : c9 27 __ CMP #$27
1ab1 : f0 0f __ BEQ $1ac2 ; (spawn_player_shot.s1001 + 0)
.s3:
1ab3 : a0 00 __ LDY #$00
.l6:
1ab5 : be 6e 21 LDX $216e,y ; (__multab3L + 0)
1ab8 : bd ba 21 LDA $21ba,x ; (PlayerShot + 2)
1abb : f0 06 __ BEQ $1ac3 ; (spawn_player_shot.s9 + 0)
.s7:
1abd : c8 __ __ INY
1abe : c0 03 __ CPY #$03
1ac0 : 90 f3 __ BCC $1ab5 ; (spawn_player_shot.l6 + 0)
.s1001:
1ac2 : 60 __ __ RTS
.s9:
1ac3 : a9 01 __ LDA #$01
1ac5 : 9d ba 21 STA $21ba,x ; (PlayerShot + 2)
1ac8 : ad 99 21 LDA $2199 ; (Player + 1)
1acb : 9d b9 21 STA $21b9,x ; (PlayerShot + 1)
1ace : ad d1 21 LDA $21d1 ; (joyx + 0)
1ad1 : 30 02 __ BMI $1ad5 ; (spawn_player_shot.s13 + 0)
.s1004:
1ad3 : d0 06 __ BNE $1adb ; (spawn_player_shot.s12 + 0)
.s13:
1ad5 : ad 98 21 LDA $2198 ; (Player + 0)
1ad8 : 4c e1 1a JMP $1ae1 ; (spawn_player_shot.s1007 + 0)
.s12:
1adb : ad 98 21 LDA $2198 ; (Player + 0)
1ade : 18 __ __ CLC
1adf : 69 01 __ ADC #$01
.s1007:
1ae1 : be 6e 21 LDX $216e,y ; (__multab3L + 0)
1ae4 : 9d b8 21 STA $21b8,x ; (PlayerShot + 0)
1ae7 : 60 __ __ RTS
--------------------------------------------------------------------
render_player_ship:
.s0:
1ae8 : ad 99 21 LDA $2199 ; (Player + 1)
1aeb : 0a __ __ ASL
1aec : 85 1b __ STA ACCU + 0 
1aee : a9 00 __ LDA #$00
1af0 : 2a __ __ ROL
1af1 : 06 1b __ ASL ACCU + 0 
1af3 : 2a __ __ ROL
1af4 : aa __ __ TAX
1af5 : a5 1b __ LDA ACCU + 0 
1af7 : 6d 99 21 ADC $2199 ; (Player + 1)
1afa : 85 1b __ STA ACCU + 0 
1afc : 8a __ __ TXA
1afd : 69 00 __ ADC #$00
1aff : 06 1b __ ASL ACCU + 0 
1b01 : 2a __ __ ROL
1b02 : 06 1b __ ASL ACCU + 0 
1b04 : 2a __ __ ROL
1b05 : 06 1b __ ASL ACCU + 0 
1b07 : 2a __ __ ROL
1b08 : aa __ __ TAX
1b09 : 18 __ __ CLC
1b0a : a5 1b __ LDA ACCU + 0 
1b0c : 6d 98 21 ADC $2198 ; (Player + 0)
1b0f : 85 1b __ STA ACCU + 0 
1b11 : 85 1f __ STA ADDR + 0 
1b13 : 8a __ __ TXA
1b14 : 69 04 __ ADC #$04
1b16 : 85 1c __ STA ACCU + 1 
1b18 : 18 __ __ CLC
1b19 : 69 d4 __ ADC #$d4
1b1b : 85 20 __ STA ADDR + 1 
1b1d : a9 51 __ LDA #$51
1b1f : a0 00 __ LDY #$00
1b21 : 91 1b __ STA (ACCU + 0),y 
1b23 : a9 03 __ LDA #$03
1b25 : 91 1f __ STA (ADDR + 0),y 
.s1001:
1b27 : 60 __ __ RTS
--------------------------------------------------------------------
move_player_shots:
.s0:
1b28 : a2 00 __ LDX #$00
.l2:
1b2a : 86 1d __ STX ACCU + 2 
1b2c : bc 6e 21 LDY $216e,x ; (__multab3L + 0)
1b2f : b9 ba 21 LDA $21ba,y ; (PlayerShot + 2)
1b32 : c9 01 __ CMP #$01
1b34 : d0 52 __ BNE $1b88 ; (move_player_shots.s23 + 0)
.s5:
1b36 : 84 1e __ STY ACCU + 3 
1b38 : b9 b9 21 LDA $21b9,y ; (PlayerShot + 1)
1b3b : 0a __ __ ASL
1b3c : 85 1b __ STA ACCU + 0 
1b3e : a9 00 __ LDA #$00
1b40 : 2a __ __ ROL
1b41 : 06 1b __ ASL ACCU + 0 
1b43 : 2a __ __ ROL
1b44 : aa __ __ TAX
1b45 : a5 1b __ LDA ACCU + 0 
1b47 : 79 b9 21 ADC $21b9,y ; (PlayerShot + 1)
1b4a : 85 1b __ STA ACCU + 0 
1b4c : 8a __ __ TXA
1b4d : 69 00 __ ADC #$00
1b4f : 06 1b __ ASL ACCU + 0 
1b51 : 2a __ __ ROL
1b52 : 06 1b __ ASL ACCU + 0 
1b54 : 2a __ __ ROL
1b55 : 06 1b __ ASL ACCU + 0 
1b57 : 2a __ __ ROL
1b58 : 85 1c __ STA ACCU + 1 
1b5a : b9 b8 21 LDA $21b8,y ; (PlayerShot + 0)
1b5d : aa __ __ TAX
1b5e : 18 __ __ CLC
1b5f : 65 1b __ ADC ACCU + 0 
1b61 : 85 1b __ STA ACCU + 0 
1b63 : 85 1f __ STA ADDR + 0 
1b65 : a5 1c __ LDA ACCU + 1 
1b67 : 69 04 __ ADC #$04
1b69 : 85 1c __ STA ACCU + 1 
1b6b : 18 __ __ CLC
1b6c : 69 d4 __ ADC #$d4
1b6e : 85 20 __ STA ADDR + 1 
1b70 : a9 20 __ LDA #$20
1b72 : a0 00 __ LDY #$00
1b74 : 91 1b __ STA (ACCU + 0),y 
1b76 : 98 __ __ TYA
1b77 : 91 1f __ STA (ADDR + 0),y 
1b79 : e8 __ __ INX
1b7a : 8a __ __ TXA
1b7b : a6 1e __ LDX ACCU + 3 
1b7d : 9d b8 21 STA $21b8,x ; (PlayerShot + 0)
1b80 : c9 28 __ CMP #$28
1b82 : 90 04 __ BCC $1b88 ; (move_player_shots.s23 + 0)
.s8:
1b84 : 98 __ __ TYA
1b85 : 9d ba 21 STA $21ba,x ; (PlayerShot + 2)
.s23:
1b88 : a6 1d __ LDX ACCU + 2 
1b8a : e8 __ __ INX
1b8b : e0 03 __ CPX #$03
1b8d : 90 9b __ BCC $1b2a ; (move_player_shots.l2 + 0)
.s1001:
1b8f : 60 __ __ RTS
--------------------------------------------------------------------
render_player_shots:
.s0:
1b90 : a2 00 __ LDX #$00
.l1006:
1b92 : bc 6e 21 LDY $216e,x ; (__multab3L + 0)
1b95 : b9 ba 21 LDA $21ba,y ; (PlayerShot + 2)
1b98 : c9 01 __ CMP #$01
1b9a : d0 43 __ BNE $1bdf ; (render_player_shots.s19 + 0)
.s5:
1b9c : b9 b9 21 LDA $21b9,y ; (PlayerShot + 1)
1b9f : 0a __ __ ASL
1ba0 : 85 1b __ STA ACCU + 0 
1ba2 : a9 00 __ LDA #$00
1ba4 : 2a __ __ ROL
1ba5 : 06 1b __ ASL ACCU + 0 
1ba7 : 2a __ __ ROL
1ba8 : 85 1c __ STA ACCU + 1 
1baa : a5 1b __ LDA ACCU + 0 
1bac : 79 b9 21 ADC $21b9,y ; (PlayerShot + 1)
1baf : 85 1b __ STA ACCU + 0 
1bb1 : a5 1c __ LDA ACCU + 1 
1bb3 : 69 00 __ ADC #$00
1bb5 : 06 1b __ ASL ACCU + 0 
1bb7 : 2a __ __ ROL
1bb8 : 06 1b __ ASL ACCU + 0 
1bba : 2a __ __ ROL
1bbb : 06 1b __ ASL ACCU + 0 
1bbd : 2a __ __ ROL
1bbe : 85 1c __ STA ACCU + 1 
1bc0 : 18 __ __ CLC
1bc1 : a5 1b __ LDA ACCU + 0 
1bc3 : 79 b8 21 ADC $21b8,y ; (PlayerShot + 0)
1bc6 : 85 1b __ STA ACCU + 0 
1bc8 : 85 1f __ STA ADDR + 0 
1bca : a5 1c __ LDA ACCU + 1 
1bcc : 69 04 __ ADC #$04
1bce : 85 1c __ STA ACCU + 1 
1bd0 : 18 __ __ CLC
1bd1 : 69 d4 __ ADC #$d4
1bd3 : 85 20 __ STA ADDR + 1 
1bd5 : a9 2b __ LDA #$2b
1bd7 : a0 00 __ LDY #$00
1bd9 : 91 1b __ STA (ACCU + 0),y 
1bdb : a9 01 __ LDA #$01
1bdd : 91 1f __ STA (ADDR + 0),y 
.s19:
1bdf : e8 __ __ INX
1be0 : e0 03 __ CPX #$03
1be2 : 90 ae __ BCC $1b92 ; (render_player_shots.l1006 + 0)
.s1001:
1be4 : 60 __ __ RTS
--------------------------------------------------------------------
check_shot_enemy_collision:
.s0:
1be5 : a2 00 __ LDX #$00
.l2:
1be7 : 86 1d __ STX ACCU + 2 
1be9 : bc 6e 21 LDY $216e,x ; (__multab3L + 0)
1bec : b9 ba 21 LDA $21ba,y ; (PlayerShot + 2)
1bef : c9 01 __ CMP #$01
1bf1 : f0 03 __ BEQ $1bf6 ; (check_shot_enemy_collision.s5 + 0)
1bf3 : 4c 8e 1c JMP $1c8e ; (check_shot_enemy_collision.s3 + 0)
.s5:
1bf6 : a2 00 __ LDX #$00
.l9:
1bf8 : 86 43 __ STX T2 + 0 
1bfa : bc 6e 21 LDY $216e,x ; (__multab3L + 0)
1bfd : b9 9c 21 LDA $219c,y ; (Enemy + 2)
1c00 : c9 01 __ CMP #$01
1c02 : f0 03 __ BEQ $1c07 ; (check_shot_enemy_collision.s12 + 0)
1c04 : 4c 84 1c JMP $1c84 ; (check_shot_enemy_collision.s43 + 0)
.s12:
1c07 : 84 1e __ STY ACCU + 3 
1c09 : a6 1d __ LDX ACCU + 2 
1c0b : bd 6e 21 LDA $216e,x ; (__multab3L + 0)
1c0e : 85 44 __ STA T3 + 0 
1c10 : aa __ __ TAX
1c11 : b9 9a 21 LDA $219a,y ; (Enemy + 0)
1c14 : dd b8 21 CMP $21b8,x ; (PlayerShot + 0)
1c17 : d0 6b __ BNE $1c84 ; (check_shot_enemy_collision.s43 + 0)
.s18:
1c19 : b9 9b 21 LDA $219b,y ; (Enemy + 1)
1c1c : dd b9 21 CMP $21b9,x ; (PlayerShot + 1)
1c1f : d0 63 __ BNE $1c84 ; (check_shot_enemy_collision.s43 + 0)
.s15:
1c21 : 0a __ __ ASL
1c22 : 85 1b __ STA ACCU + 0 
1c24 : a9 00 __ LDA #$00
1c26 : 2a __ __ ROL
1c27 : 06 1b __ ASL ACCU + 0 
1c29 : 2a __ __ ROL
1c2a : aa __ __ TAX
1c2b : a5 1b __ LDA ACCU + 0 
1c2d : 79 9b 21 ADC $219b,y ; (Enemy + 1)
1c30 : 85 1b __ STA ACCU + 0 
1c32 : 8a __ __ TXA
1c33 : 69 00 __ ADC #$00
1c35 : 06 1b __ ASL ACCU + 0 
1c37 : 2a __ __ ROL
1c38 : 06 1b __ ASL ACCU + 0 
1c3a : 2a __ __ ROL
1c3b : 06 1b __ ASL ACCU + 0 
1c3d : 2a __ __ ROL
1c3e : aa __ __ TAX
1c3f : 18 __ __ CLC
1c40 : a5 1b __ LDA ACCU + 0 
1c42 : 79 9a 21 ADC $219a,y ; (Enemy + 0)
1c45 : 85 1b __ STA ACCU + 0 
1c47 : 85 1f __ STA ADDR + 0 
1c49 : 8a __ __ TXA
1c4a : 69 04 __ ADC #$04
1c4c : 85 1c __ STA ACCU + 1 
1c4e : 18 __ __ CLC
1c4f : 69 d4 __ ADC #$d4
1c51 : 85 20 __ STA ADDR + 1 
1c53 : a9 20 __ LDA #$20
1c55 : a0 00 __ LDY #$00
1c57 : 91 1b __ STA (ACCU + 0),y 
1c59 : 98 __ __ TYA
1c5a : 91 1f __ STA (ADDR + 0),y 
1c5c : a6 1e __ LDX ACCU + 3 
1c5e : 9d 9c 21 STA $219c,x ; (Enemy + 2)
1c61 : a6 44 __ LDX T3 + 0 
1c63 : 9d ba 21 STA $21ba,x ; (PlayerShot + 2)
1c66 : ad cb 21 LDA $21cb ; (game + 1)
1c69 : 18 __ __ CLC
1c6a : 69 01 __ ADC #$01
1c6c : 8d cb 21 STA $21cb ; (game + 1)
1c6f : ad cc 21 LDA $21cc ; (game + 2)
1c72 : 69 00 __ ADC #$00
1c74 : 8d cc 21 STA $21cc ; (game + 2)
1c77 : ad cd 21 LDA $21cd ; (game + 3)
1c7a : 69 00 __ ADC #$00
1c7c : 8d cd 21 STA $21cd ; (game + 3)
1c7f : 90 03 __ BCC $1c84 ; (check_shot_enemy_collision.s43 + 0)
.s1014:
1c81 : ee ce 21 INC $21ce ; (game + 4)
.s43:
1c84 : a6 43 __ LDX T2 + 0 
1c86 : e8 __ __ INX
1c87 : e0 0a __ CPX #$0a
1c89 : b0 03 __ BCS $1c8e ; (check_shot_enemy_collision.s3 + 0)
1c8b : 4c f8 1b JMP $1bf8 ; (check_shot_enemy_collision.l9 + 0)
.s3:
1c8e : a6 1d __ LDX ACCU + 2 
1c90 : e8 __ __ INX
1c91 : e0 03 __ CPX #$03
1c93 : b0 03 __ BCS $1c98 ; (check_shot_enemy_collision.s1001 + 0)
1c95 : 4c e7 1b JMP $1be7 ; (check_shot_enemy_collision.l2 + 0)
.s1001:
1c98 : 60 __ __ RTS
--------------------------------------------------------------------
wait_frames:
.s0:
1c99 : a5 0e __ LDA P1 ; (frames + 1)
1c9b : 30 1c __ BMI $1cb9 ; (wait_frames.s1001 + 0)
.s1005:
1c9d : 05 0d __ ORA P0 ; (frames + 0)
1c9f : f0 18 __ BEQ $1cb9 ; (wait_frames.s1001 + 0)
.s13:
1ca1 : a0 00 __ LDY #$00
1ca3 : a6 0e __ LDX P1 ; (frames + 1)
.l6:
1ca5 : ad 11 d0 LDA $d011 
1ca8 : 30 fb __ BMI $1ca5 ; (wait_frames.l6 + 0)
.l9:
1caa : ad 11 d0 LDA $d011 
1cad : 10 fb __ BPL $1caa ; (wait_frames.l9 + 0)
.s3:
1caf : c8 __ __ INY
1cb0 : 8a __ __ TXA
1cb1 : 30 06 __ BMI $1cb9 ; (wait_frames.s1001 + 0)
.s1004:
1cb3 : d0 f0 __ BNE $1ca5 ; (wait_frames.l6 + 0)
.s1002:
1cb5 : c4 0d __ CPY P0 ; (frames + 0)
1cb7 : 90 ec __ BCC $1ca5 ; (wait_frames.l6 + 0)
.s1001:
1cb9 : 60 __ __ RTS
--------------------------------------------------------------------
freg:
1cba : b1 19 __ LDA (IP + 0),y 
1cbc : c8 __ __ INY
1cbd : aa __ __ TAX
1cbe : b5 00 __ LDA $00,x 
1cc0 : 85 03 __ STA WORK + 0 
1cc2 : b5 01 __ LDA $01,x 
1cc4 : 85 04 __ STA WORK + 1 
1cc6 : b5 02 __ LDA $02,x 
1cc8 : 85 05 __ STA WORK + 2 
1cca : b5 03 __ LDA WORK + 0,x 
1ccc : 85 06 __ STA WORK + 3 
1cce : a5 05 __ LDA WORK + 2 
1cd0 : 0a __ __ ASL
1cd1 : a5 06 __ LDA WORK + 3 
1cd3 : 2a __ __ ROL
1cd4 : 85 08 __ STA WORK + 5 
1cd6 : f0 06 __ BEQ $1cde ; (freg + 36)
1cd8 : a5 05 __ LDA WORK + 2 
1cda : 09 80 __ ORA #$80
1cdc : 85 05 __ STA WORK + 2 
1cde : a5 1d __ LDA ACCU + 2 
1ce0 : 0a __ __ ASL
1ce1 : a5 1e __ LDA ACCU + 3 
1ce3 : 2a __ __ ROL
1ce4 : 85 07 __ STA WORK + 4 
1ce6 : f0 06 __ BEQ $1cee ; (freg + 52)
1ce8 : a5 1d __ LDA ACCU + 2 
1cea : 09 80 __ ORA #$80
1cec : 85 1d __ STA ACCU + 2 
1cee : 60 __ __ RTS
1cef : 06 1e __ ASL ACCU + 3 
1cf1 : a5 07 __ LDA WORK + 4 
1cf3 : 6a __ __ ROR
1cf4 : 85 1e __ STA ACCU + 3 
1cf6 : b0 06 __ BCS $1cfe ; (freg + 68)
1cf8 : a5 1d __ LDA ACCU + 2 
1cfa : 29 7f __ AND #$7f
1cfc : 85 1d __ STA ACCU + 2 
1cfe : 60 __ __ RTS
--------------------------------------------------------------------
faddsub:
1cff : a9 ff __ LDA #$ff
1d01 : c5 07 __ CMP WORK + 4 
1d03 : f0 04 __ BEQ $1d09 ; (faddsub + 10)
1d05 : c5 08 __ CMP WORK + 5 
1d07 : d0 11 __ BNE $1d1a ; (faddsub + 27)
1d09 : a5 1e __ LDA ACCU + 3 
1d0b : 09 7f __ ORA #$7f
1d0d : 85 1e __ STA ACCU + 3 
1d0f : a9 80 __ LDA #$80
1d11 : 85 1d __ STA ACCU + 2 
1d13 : a9 00 __ LDA #$00
1d15 : 85 1b __ STA ACCU + 0 
1d17 : 85 1c __ STA ACCU + 1 
1d19 : 60 __ __ RTS
1d1a : 38 __ __ SEC
1d1b : a5 07 __ LDA WORK + 4 
1d1d : e5 08 __ SBC WORK + 5 
1d1f : f0 38 __ BEQ $1d59 ; (faddsub + 90)
1d21 : aa __ __ TAX
1d22 : b0 25 __ BCS $1d49 ; (faddsub + 74)
1d24 : e0 e9 __ CPX #$e9
1d26 : b0 0e __ BCS $1d36 ; (faddsub + 55)
1d28 : a5 08 __ LDA WORK + 5 
1d2a : 85 07 __ STA WORK + 4 
1d2c : a9 00 __ LDA #$00
1d2e : 85 1b __ STA ACCU + 0 
1d30 : 85 1c __ STA ACCU + 1 
1d32 : 85 1d __ STA ACCU + 2 
1d34 : f0 23 __ BEQ $1d59 ; (faddsub + 90)
1d36 : a5 1d __ LDA ACCU + 2 
1d38 : 4a __ __ LSR
1d39 : 66 1c __ ROR ACCU + 1 
1d3b : 66 1b __ ROR ACCU + 0 
1d3d : e8 __ __ INX
1d3e : d0 f8 __ BNE $1d38 ; (faddsub + 57)
1d40 : 85 1d __ STA ACCU + 2 
1d42 : a5 08 __ LDA WORK + 5 
1d44 : 85 07 __ STA WORK + 4 
1d46 : 4c 59 1d JMP $1d59 ; (faddsub + 90)
1d49 : e0 18 __ CPX #$18
1d4b : b0 33 __ BCS $1d80 ; (faddsub + 129)
1d4d : a5 05 __ LDA WORK + 2 
1d4f : 4a __ __ LSR
1d50 : 66 04 __ ROR WORK + 1 
1d52 : 66 03 __ ROR WORK + 0 
1d54 : ca __ __ DEX
1d55 : d0 f8 __ BNE $1d4f ; (faddsub + 80)
1d57 : 85 05 __ STA WORK + 2 
1d59 : a5 1e __ LDA ACCU + 3 
1d5b : 29 80 __ AND #$80
1d5d : 85 1e __ STA ACCU + 3 
1d5f : 45 06 __ EOR WORK + 3 
1d61 : 30 31 __ BMI $1d94 ; (faddsub + 149)
1d63 : 18 __ __ CLC
1d64 : a5 1b __ LDA ACCU + 0 
1d66 : 65 03 __ ADC WORK + 0 
1d68 : 85 1b __ STA ACCU + 0 
1d6a : a5 1c __ LDA ACCU + 1 
1d6c : 65 04 __ ADC WORK + 1 
1d6e : 85 1c __ STA ACCU + 1 
1d70 : a5 1d __ LDA ACCU + 2 
1d72 : 65 05 __ ADC WORK + 2 
1d74 : 85 1d __ STA ACCU + 2 
1d76 : 90 08 __ BCC $1d80 ; (faddsub + 129)
1d78 : 66 1d __ ROR ACCU + 2 
1d7a : 66 1c __ ROR ACCU + 1 
1d7c : 66 1b __ ROR ACCU + 0 
1d7e : e6 07 __ INC WORK + 4 
1d80 : a5 07 __ LDA WORK + 4 
1d82 : c9 ff __ CMP #$ff
1d84 : f0 83 __ BEQ $1d09 ; (faddsub + 10)
1d86 : 4a __ __ LSR
1d87 : 05 1e __ ORA ACCU + 3 
1d89 : 85 1e __ STA ACCU + 3 
1d8b : b0 06 __ BCS $1d93 ; (faddsub + 148)
1d8d : a5 1d __ LDA ACCU + 2 
1d8f : 29 7f __ AND #$7f
1d91 : 85 1d __ STA ACCU + 2 
1d93 : 60 __ __ RTS
1d94 : 38 __ __ SEC
1d95 : a5 1b __ LDA ACCU + 0 
1d97 : e5 03 __ SBC WORK + 0 
1d99 : 85 1b __ STA ACCU + 0 
1d9b : a5 1c __ LDA ACCU + 1 
1d9d : e5 04 __ SBC WORK + 1 
1d9f : 85 1c __ STA ACCU + 1 
1da1 : a5 1d __ LDA ACCU + 2 
1da3 : e5 05 __ SBC WORK + 2 
1da5 : 85 1d __ STA ACCU + 2 
1da7 : b0 19 __ BCS $1dc2 ; (faddsub + 195)
1da9 : 38 __ __ SEC
1daa : a9 00 __ LDA #$00
1dac : e5 1b __ SBC ACCU + 0 
1dae : 85 1b __ STA ACCU + 0 
1db0 : a9 00 __ LDA #$00
1db2 : e5 1c __ SBC ACCU + 1 
1db4 : 85 1c __ STA ACCU + 1 
1db6 : a9 00 __ LDA #$00
1db8 : e5 1d __ SBC ACCU + 2 
1dba : 85 1d __ STA ACCU + 2 
1dbc : a5 1e __ LDA ACCU + 3 
1dbe : 49 80 __ EOR #$80
1dc0 : 85 1e __ STA ACCU + 3 
1dc2 : a5 1d __ LDA ACCU + 2 
1dc4 : 30 ba __ BMI $1d80 ; (faddsub + 129)
1dc6 : 05 1c __ ORA ACCU + 1 
1dc8 : 05 1b __ ORA ACCU + 0 
1dca : f0 0f __ BEQ $1ddb ; (faddsub + 220)
1dcc : c6 07 __ DEC WORK + 4 
1dce : f0 0b __ BEQ $1ddb ; (faddsub + 220)
1dd0 : 06 1b __ ASL ACCU + 0 
1dd2 : 26 1c __ ROL ACCU + 1 
1dd4 : 26 1d __ ROL ACCU + 2 
1dd6 : 10 f4 __ BPL $1dcc ; (faddsub + 205)
1dd8 : 4c 80 1d JMP $1d80 ; (faddsub + 129)
1ddb : a9 00 __ LDA #$00
1ddd : 85 1b __ STA ACCU + 0 
1ddf : 85 1c __ STA ACCU + 1 
1de1 : 85 1d __ STA ACCU + 2 
1de3 : 85 1e __ STA ACCU + 3 
1de5 : 60 __ __ RTS
--------------------------------------------------------------------
fmul:
1de6 : a5 1b __ LDA ACCU + 0 
1de8 : 05 1c __ ORA ACCU + 1 
1dea : 05 1d __ ORA ACCU + 2 
1dec : d0 03 __ BNE $1df1 ; (fmul + 11)
1dee : 85 1e __ STA ACCU + 3 
1df0 : 60 __ __ RTS
1df1 : a5 03 __ LDA WORK + 0 
1df3 : 05 04 __ ORA WORK + 1 
1df5 : 05 05 __ ORA WORK + 2 
1df7 : d0 09 __ BNE $1e02 ; (fmul + 28)
1df9 : 85 1b __ STA ACCU + 0 
1dfb : 85 1c __ STA ACCU + 1 
1dfd : 85 1d __ STA ACCU + 2 
1dff : 85 1e __ STA ACCU + 3 
1e01 : 60 __ __ RTS
1e02 : a5 1e __ LDA ACCU + 3 
1e04 : 45 06 __ EOR WORK + 3 
1e06 : 29 80 __ AND #$80
1e08 : 85 1e __ STA ACCU + 3 
1e0a : a9 ff __ LDA #$ff
1e0c : c5 07 __ CMP WORK + 4 
1e0e : f0 42 __ BEQ $1e52 ; (fmul + 108)
1e10 : c5 08 __ CMP WORK + 5 
1e12 : f0 3e __ BEQ $1e52 ; (fmul + 108)
1e14 : a9 00 __ LDA #$00
1e16 : 85 09 __ STA WORK + 6 
1e18 : 85 0a __ STA WORK + 7 
1e1a : 85 0b __ STA $0b 
1e1c : a4 1b __ LDY ACCU + 0 
1e1e : a5 03 __ LDA WORK + 0 
1e20 : d0 06 __ BNE $1e28 ; (fmul + 66)
1e22 : a5 04 __ LDA WORK + 1 
1e24 : f0 0a __ BEQ $1e30 ; (fmul + 74)
1e26 : d0 05 __ BNE $1e2d ; (fmul + 71)
1e28 : 20 87 1e JSR $1e87 ; (fmul8 + 0)
1e2b : a5 04 __ LDA WORK + 1 
1e2d : 20 87 1e JSR $1e87 ; (fmul8 + 0)
1e30 : a5 05 __ LDA WORK + 2 
1e32 : 20 87 1e JSR $1e87 ; (fmul8 + 0)
1e35 : 38 __ __ SEC
1e36 : a5 0b __ LDA $0b 
1e38 : 30 06 __ BMI $1e40 ; (fmul + 90)
1e3a : 06 09 __ ASL WORK + 6 
1e3c : 26 0a __ ROL WORK + 7 
1e3e : 2a __ __ ROL
1e3f : 18 __ __ CLC
1e40 : 29 7f __ AND #$7f
1e42 : 85 0b __ STA $0b 
1e44 : a5 07 __ LDA WORK + 4 
1e46 : 65 08 __ ADC WORK + 5 
1e48 : 90 19 __ BCC $1e63 ; (fmul + 125)
1e4a : e9 7f __ SBC #$7f
1e4c : b0 04 __ BCS $1e52 ; (fmul + 108)
1e4e : c9 ff __ CMP #$ff
1e50 : d0 15 __ BNE $1e67 ; (fmul + 129)
1e52 : a5 1e __ LDA ACCU + 3 
1e54 : 09 7f __ ORA #$7f
1e56 : 85 1e __ STA ACCU + 3 
1e58 : a9 80 __ LDA #$80
1e5a : 85 1d __ STA ACCU + 2 
1e5c : a9 00 __ LDA #$00
1e5e : 85 1b __ STA ACCU + 0 
1e60 : 85 1c __ STA ACCU + 1 
1e62 : 60 __ __ RTS
1e63 : e9 7e __ SBC #$7e
1e65 : 90 15 __ BCC $1e7c ; (fmul + 150)
1e67 : 4a __ __ LSR
1e68 : 05 1e __ ORA ACCU + 3 
1e6a : 85 1e __ STA ACCU + 3 
1e6c : a9 00 __ LDA #$00
1e6e : 6a __ __ ROR
1e6f : 05 0b __ ORA $0b 
1e71 : 85 1d __ STA ACCU + 2 
1e73 : a5 0a __ LDA WORK + 7 
1e75 : 85 1c __ STA ACCU + 1 
1e77 : a5 09 __ LDA WORK + 6 
1e79 : 85 1b __ STA ACCU + 0 
1e7b : 60 __ __ RTS
1e7c : a9 00 __ LDA #$00
1e7e : 85 1b __ STA ACCU + 0 
1e80 : 85 1c __ STA ACCU + 1 
1e82 : 85 1d __ STA ACCU + 2 
1e84 : 85 1e __ STA ACCU + 3 
1e86 : 60 __ __ RTS
--------------------------------------------------------------------
fmul8:
1e87 : 38 __ __ SEC
1e88 : 6a __ __ ROR
1e89 : 90 1e __ BCC $1ea9 ; (fmul8 + 34)
1e8b : aa __ __ TAX
1e8c : 18 __ __ CLC
1e8d : 98 __ __ TYA
1e8e : 65 09 __ ADC WORK + 6 
1e90 : 85 09 __ STA WORK + 6 
1e92 : a5 0a __ LDA WORK + 7 
1e94 : 65 1c __ ADC ACCU + 1 
1e96 : 85 0a __ STA WORK + 7 
1e98 : a5 0b __ LDA $0b 
1e9a : 65 1d __ ADC ACCU + 2 
1e9c : 6a __ __ ROR
1e9d : 85 0b __ STA $0b 
1e9f : 8a __ __ TXA
1ea0 : 66 0a __ ROR WORK + 7 
1ea2 : 66 09 __ ROR WORK + 6 
1ea4 : 4a __ __ LSR
1ea5 : f0 0d __ BEQ $1eb4 ; (fmul8 + 45)
1ea7 : b0 e2 __ BCS $1e8b ; (fmul8 + 4)
1ea9 : 66 0b __ ROR $0b 
1eab : 66 0a __ ROR WORK + 7 
1ead : 66 09 __ ROR WORK + 6 
1eaf : 4a __ __ LSR
1eb0 : 90 f7 __ BCC $1ea9 ; (fmul8 + 34)
1eb2 : d0 d7 __ BNE $1e8b ; (fmul8 + 4)
1eb4 : 60 __ __ RTS
--------------------------------------------------------------------
fdiv:
1eb5 : a5 1b __ LDA ACCU + 0 
1eb7 : 05 1c __ ORA ACCU + 1 
1eb9 : 05 1d __ ORA ACCU + 2 
1ebb : d0 03 __ BNE $1ec0 ; (fdiv + 11)
1ebd : 85 1e __ STA ACCU + 3 
1ebf : 60 __ __ RTS
1ec0 : a5 1e __ LDA ACCU + 3 
1ec2 : 45 06 __ EOR WORK + 3 
1ec4 : 29 80 __ AND #$80
1ec6 : 85 1e __ STA ACCU + 3 
1ec8 : a5 08 __ LDA WORK + 5 
1eca : f0 62 __ BEQ $1f2e ; (fdiv + 121)
1ecc : a5 07 __ LDA WORK + 4 
1ece : c9 ff __ CMP #$ff
1ed0 : f0 5c __ BEQ $1f2e ; (fdiv + 121)
1ed2 : a9 00 __ LDA #$00
1ed4 : 85 09 __ STA WORK + 6 
1ed6 : 85 0a __ STA WORK + 7 
1ed8 : 85 0b __ STA $0b 
1eda : a2 18 __ LDX #$18
1edc : a5 1b __ LDA ACCU + 0 
1ede : c5 03 __ CMP WORK + 0 
1ee0 : a5 1c __ LDA ACCU + 1 
1ee2 : e5 04 __ SBC WORK + 1 
1ee4 : a5 1d __ LDA ACCU + 2 
1ee6 : e5 05 __ SBC WORK + 2 
1ee8 : 90 13 __ BCC $1efd ; (fdiv + 72)
1eea : a5 1b __ LDA ACCU + 0 
1eec : e5 03 __ SBC WORK + 0 
1eee : 85 1b __ STA ACCU + 0 
1ef0 : a5 1c __ LDA ACCU + 1 
1ef2 : e5 04 __ SBC WORK + 1 
1ef4 : 85 1c __ STA ACCU + 1 
1ef6 : a5 1d __ LDA ACCU + 2 
1ef8 : e5 05 __ SBC WORK + 2 
1efa : 85 1d __ STA ACCU + 2 
1efc : 38 __ __ SEC
1efd : 26 09 __ ROL WORK + 6 
1eff : 26 0a __ ROL WORK + 7 
1f01 : 26 0b __ ROL $0b 
1f03 : ca __ __ DEX
1f04 : f0 0a __ BEQ $1f10 ; (fdiv + 91)
1f06 : 06 1b __ ASL ACCU + 0 
1f08 : 26 1c __ ROL ACCU + 1 
1f0a : 26 1d __ ROL ACCU + 2 
1f0c : b0 dc __ BCS $1eea ; (fdiv + 53)
1f0e : 90 cc __ BCC $1edc ; (fdiv + 39)
1f10 : 38 __ __ SEC
1f11 : a5 0b __ LDA $0b 
1f13 : 30 06 __ BMI $1f1b ; (fdiv + 102)
1f15 : 06 09 __ ASL WORK + 6 
1f17 : 26 0a __ ROL WORK + 7 
1f19 : 2a __ __ ROL
1f1a : 18 __ __ CLC
1f1b : 29 7f __ AND #$7f
1f1d : 85 0b __ STA $0b 
1f1f : a5 07 __ LDA WORK + 4 
1f21 : e5 08 __ SBC WORK + 5 
1f23 : 90 1a __ BCC $1f3f ; (fdiv + 138)
1f25 : 18 __ __ CLC
1f26 : 69 7f __ ADC #$7f
1f28 : b0 04 __ BCS $1f2e ; (fdiv + 121)
1f2a : c9 ff __ CMP #$ff
1f2c : d0 15 __ BNE $1f43 ; (fdiv + 142)
1f2e : a5 1e __ LDA ACCU + 3 
1f30 : 09 7f __ ORA #$7f
1f32 : 85 1e __ STA ACCU + 3 
1f34 : a9 80 __ LDA #$80
1f36 : 85 1d __ STA ACCU + 2 
1f38 : a9 00 __ LDA #$00
1f3a : 85 1c __ STA ACCU + 1 
1f3c : 85 1b __ STA ACCU + 0 
1f3e : 60 __ __ RTS
1f3f : 69 7f __ ADC #$7f
1f41 : 90 15 __ BCC $1f58 ; (fdiv + 163)
1f43 : 4a __ __ LSR
1f44 : 05 1e __ ORA ACCU + 3 
1f46 : 85 1e __ STA ACCU + 3 
1f48 : a9 00 __ LDA #$00
1f4a : 6a __ __ ROR
1f4b : 05 0b __ ORA $0b 
1f4d : 85 1d __ STA ACCU + 2 
1f4f : a5 0a __ LDA WORK + 7 
1f51 : 85 1c __ STA ACCU + 1 
1f53 : a5 09 __ LDA WORK + 6 
1f55 : 85 1b __ STA ACCU + 0 
1f57 : 60 __ __ RTS
1f58 : a9 00 __ LDA #$00
1f5a : 85 1e __ STA ACCU + 3 
1f5c : 85 1d __ STA ACCU + 2 
1f5e : 85 1c __ STA ACCU + 1 
1f60 : 85 1b __ STA ACCU + 0 
1f62 : 60 __ __ RTS
--------------------------------------------------------------------
divs16:
1f63 : 24 1c __ BIT ACCU + 1 
1f65 : 10 0d __ BPL $1f74 ; (divs16 + 17)
1f67 : 20 81 1f JSR $1f81 ; (negaccu + 0)
1f6a : 24 04 __ BIT WORK + 1 
1f6c : 10 0d __ BPL $1f7b ; (divs16 + 24)
1f6e : 20 8f 1f JSR $1f8f ; (negtmp + 0)
1f71 : 4c 9d 1f JMP $1f9d ; (divmod + 0)
1f74 : 24 04 __ BIT WORK + 1 
1f76 : 10 f9 __ BPL $1f71 ; (divs16 + 14)
1f78 : 20 8f 1f JSR $1f8f ; (negtmp + 0)
1f7b : 20 9d 1f JSR $1f9d ; (divmod + 0)
1f7e : 4c 81 1f JMP $1f81 ; (negaccu + 0)
--------------------------------------------------------------------
negaccu:
1f81 : 38 __ __ SEC
1f82 : a9 00 __ LDA #$00
1f84 : e5 1b __ SBC ACCU + 0 
1f86 : 85 1b __ STA ACCU + 0 
1f88 : a9 00 __ LDA #$00
1f8a : e5 1c __ SBC ACCU + 1 
1f8c : 85 1c __ STA ACCU + 1 
1f8e : 60 __ __ RTS
--------------------------------------------------------------------
negtmp:
1f8f : 38 __ __ SEC
1f90 : a9 00 __ LDA #$00
1f92 : e5 03 __ SBC WORK + 0 
1f94 : 85 03 __ STA WORK + 0 
1f96 : a9 00 __ LDA #$00
1f98 : e5 04 __ SBC WORK + 1 
1f9a : 85 04 __ STA WORK + 1 
1f9c : 60 __ __ RTS
--------------------------------------------------------------------
divmod:
1f9d : a5 1c __ LDA ACCU + 1 
1f9f : d0 31 __ BNE $1fd2 ; (divmod + 53)
1fa1 : a5 04 __ LDA WORK + 1 
1fa3 : d0 1e __ BNE $1fc3 ; (divmod + 38)
1fa5 : 85 06 __ STA WORK + 3 
1fa7 : a2 04 __ LDX #$04
1fa9 : 06 1b __ ASL ACCU + 0 
1fab : 2a __ __ ROL
1fac : c5 03 __ CMP WORK + 0 
1fae : 90 02 __ BCC $1fb2 ; (divmod + 21)
1fb0 : e5 03 __ SBC WORK + 0 
1fb2 : 26 1b __ ROL ACCU + 0 
1fb4 : 2a __ __ ROL
1fb5 : c5 03 __ CMP WORK + 0 
1fb7 : 90 02 __ BCC $1fbb ; (divmod + 30)
1fb9 : e5 03 __ SBC WORK + 0 
1fbb : 26 1b __ ROL ACCU + 0 
1fbd : ca __ __ DEX
1fbe : d0 eb __ BNE $1fab ; (divmod + 14)
1fc0 : 85 05 __ STA WORK + 2 
1fc2 : 60 __ __ RTS
1fc3 : a5 1b __ LDA ACCU + 0 
1fc5 : 85 05 __ STA WORK + 2 
1fc7 : a5 1c __ LDA ACCU + 1 
1fc9 : 85 06 __ STA WORK + 3 
1fcb : a9 00 __ LDA #$00
1fcd : 85 1b __ STA ACCU + 0 
1fcf : 85 1c __ STA ACCU + 1 
1fd1 : 60 __ __ RTS
1fd2 : a5 04 __ LDA WORK + 1 
1fd4 : d0 1f __ BNE $1ff5 ; (divmod + 88)
1fd6 : a5 03 __ LDA WORK + 0 
1fd8 : 30 1b __ BMI $1ff5 ; (divmod + 88)
1fda : a9 00 __ LDA #$00
1fdc : 85 06 __ STA WORK + 3 
1fde : a2 10 __ LDX #$10
1fe0 : 06 1b __ ASL ACCU + 0 
1fe2 : 26 1c __ ROL ACCU + 1 
1fe4 : 2a __ __ ROL
1fe5 : c5 03 __ CMP WORK + 0 
1fe7 : 90 02 __ BCC $1feb ; (divmod + 78)
1fe9 : e5 03 __ SBC WORK + 0 
1feb : 26 1b __ ROL ACCU + 0 
1fed : 26 1c __ ROL ACCU + 1 
1fef : ca __ __ DEX
1ff0 : d0 f2 __ BNE $1fe4 ; (divmod + 71)
1ff2 : 85 05 __ STA WORK + 2 
1ff4 : 60 __ __ RTS
1ff5 : a9 00 __ LDA #$00
1ff7 : 85 05 __ STA WORK + 2 
1ff9 : 85 06 __ STA WORK + 3 
1ffb : 84 02 __ STY $02 
1ffd : a0 10 __ LDY #$10
1fff : 18 __ __ CLC
2000 : 26 1b __ ROL ACCU + 0 
2002 : 26 1c __ ROL ACCU + 1 
2004 : 26 05 __ ROL WORK + 2 
2006 : 26 06 __ ROL WORK + 3 
2008 : 38 __ __ SEC
2009 : a5 05 __ LDA WORK + 2 
200b : e5 03 __ SBC WORK + 0 
200d : aa __ __ TAX
200e : a5 06 __ LDA WORK + 3 
2010 : e5 04 __ SBC WORK + 1 
2012 : 90 04 __ BCC $2018 ; (divmod + 123)
2014 : 86 05 __ STX WORK + 2 
2016 : 85 06 __ STA WORK + 3 
2018 : 88 __ __ DEY
2019 : d0 e5 __ BNE $2000 ; (divmod + 99)
201b : 26 1b __ ROL ACCU + 0 
201d : 26 1c __ ROL ACCU + 1 
201f : a4 02 __ LDY $02 
2021 : 60 __ __ RTS
--------------------------------------------------------------------
mods16:
2022 : 24 1c __ BIT ACCU + 1 
2024 : 10 0d __ BPL $2033 ; (mods16 + 17)
2026 : 20 81 1f JSR $1f81 ; (negaccu + 0)
2029 : 24 04 __ BIT WORK + 1 
202b : 10 0d __ BPL $203a ; (mods16 + 24)
202d : 20 8f 1f JSR $1f8f ; (negtmp + 0)
2030 : 4c 9d 1f JMP $1f9d ; (divmod + 0)
2033 : 24 04 __ BIT WORK + 1 
2035 : 10 f9 __ BPL $2030 ; (mods16 + 14)
2037 : 20 8f 1f JSR $1f8f ; (negtmp + 0)
203a : 20 9d 1f JSR $1f9d ; (divmod + 0)
203d : 38 __ __ SEC
203e : a9 00 __ LDA #$00
2040 : e5 05 __ SBC WORK + 2 
2042 : 85 05 __ STA WORK + 2 
2044 : a9 00 __ LDA #$00
2046 : e5 06 __ SBC WORK + 3 
2048 : 85 06 __ STA WORK + 3 
204a : 60 __ __ RTS
--------------------------------------------------------------------
f32_to_i16:
204b : 20 de 1c JSR $1cde ; (freg + 36)
204e : a5 07 __ LDA WORK + 4 
2050 : c9 7f __ CMP #$7f
2052 : b0 07 __ BCS $205b ; (f32_to_i16 + 16)
2054 : a9 00 __ LDA #$00
2056 : 85 1b __ STA ACCU + 0 
2058 : 85 1c __ STA ACCU + 1 
205a : 60 __ __ RTS
205b : 38 __ __ SEC
205c : e9 8e __ SBC #$8e
205e : 90 0a __ BCC $206a ; (f32_to_i16 + 31)
2060 : a9 ff __ LDA #$ff
2062 : 85 1b __ STA ACCU + 0 
2064 : a9 7f __ LDA #$7f
2066 : 85 1c __ STA ACCU + 1 
2068 : d0 08 __ BNE $2072 ; (f32_to_i16 + 39)
206a : aa __ __ TAX
206b : 46 1d __ LSR ACCU + 2 
206d : 66 1c __ ROR ACCU + 1 
206f : e8 __ __ INX
2070 : d0 f9 __ BNE $206b ; (f32_to_i16 + 32)
2072 : 24 1e __ BIT ACCU + 3 
2074 : 10 0e __ BPL $2084 ; (f32_to_i16 + 57)
2076 : 38 __ __ SEC
2077 : a9 00 __ LDA #$00
2079 : e5 1c __ SBC ACCU + 1 
207b : 85 1b __ STA ACCU + 0 
207d : a9 00 __ LDA #$00
207f : e5 1d __ SBC ACCU + 2 
2081 : 85 1c __ STA ACCU + 1 
2083 : 60 __ __ RTS
2084 : a5 1c __ LDA ACCU + 1 
2086 : 85 1b __ STA ACCU + 0 
2088 : a5 1d __ LDA ACCU + 2 
208a : 85 1c __ STA ACCU + 1 
208c : 60 __ __ RTS
--------------------------------------------------------------------
sint16_to_float:
208d : 24 1c __ BIT ACCU + 1 
208f : 30 03 __ BMI $2094 ; (sint16_to_float + 7)
2091 : 4c ab 20 JMP $20ab ; (uint16_to_float + 0)
2094 : 38 __ __ SEC
2095 : a9 00 __ LDA #$00
2097 : e5 1b __ SBC ACCU + 0 
2099 : 85 1b __ STA ACCU + 0 
209b : a9 00 __ LDA #$00
209d : e5 1c __ SBC ACCU + 1 
209f : 85 1c __ STA ACCU + 1 
20a1 : 20 ab 20 JSR $20ab ; (uint16_to_float + 0)
20a4 : a5 1e __ LDA ACCU + 3 
20a6 : 09 80 __ ORA #$80
20a8 : 85 1e __ STA ACCU + 3 
20aa : 60 __ __ RTS
--------------------------------------------------------------------
uint16_to_float:
20ab : a5 1b __ LDA ACCU + 0 
20ad : 05 1c __ ORA ACCU + 1 
20af : d0 05 __ BNE $20b6 ; (uint16_to_float + 11)
20b1 : 85 1d __ STA ACCU + 2 
20b3 : 85 1e __ STA ACCU + 3 
20b5 : 60 __ __ RTS
20b6 : a2 8e __ LDX #$8e
20b8 : a5 1c __ LDA ACCU + 1 
20ba : 30 06 __ BMI $20c2 ; (uint16_to_float + 23)
20bc : ca __ __ DEX
20bd : 06 1b __ ASL ACCU + 0 
20bf : 2a __ __ ROL
20c0 : 10 fa __ BPL $20bc ; (uint16_to_float + 17)
20c2 : 29 7f __ AND #$7f
20c4 : 85 1d __ STA ACCU + 2 
20c6 : a5 1b __ LDA ACCU + 0 
20c8 : 85 1c __ STA ACCU + 1 
20ca : 8a __ __ TXA
20cb : 4a __ __ LSR
20cc : 85 1e __ STA ACCU + 3 
20ce : a9 00 __ LDA #$00
20d0 : 85 1b __ STA ACCU + 0 
20d2 : 6a __ __ ROR
20d3 : 05 1d __ ORA ACCU + 2 
20d5 : 85 1d __ STA ACCU + 2 
20d7 : 60 __ __ RTS
--------------------------------------------------------------------
divmod32:
20d8 : 84 02 __ STY $02 
20da : a0 20 __ LDY #$20
20dc : a9 00 __ LDA #$00
20de : 85 07 __ STA WORK + 4 
20e0 : 85 08 __ STA WORK + 5 
20e2 : 85 09 __ STA WORK + 6 
20e4 : 85 0a __ STA WORK + 7 
20e6 : a5 05 __ LDA WORK + 2 
20e8 : 05 06 __ ORA WORK + 3 
20ea : d0 39 __ BNE $2125 ; (divmod32 + 77)
20ec : 18 __ __ CLC
20ed : 26 1b __ ROL ACCU + 0 
20ef : 26 1c __ ROL ACCU + 1 
20f1 : 26 1d __ ROL ACCU + 2 
20f3 : 26 1e __ ROL ACCU + 3 
20f5 : 26 07 __ ROL WORK + 4 
20f7 : 26 08 __ ROL WORK + 5 
20f9 : 90 0c __ BCC $2107 ; (divmod32 + 47)
20fb : a5 07 __ LDA WORK + 4 
20fd : e5 03 __ SBC WORK + 0 
20ff : aa __ __ TAX
2100 : a5 08 __ LDA WORK + 5 
2102 : e5 04 __ SBC WORK + 1 
2104 : 38 __ __ SEC
2105 : b0 0c __ BCS $2113 ; (divmod32 + 59)
2107 : 38 __ __ SEC
2108 : a5 07 __ LDA WORK + 4 
210a : e5 03 __ SBC WORK + 0 
210c : aa __ __ TAX
210d : a5 08 __ LDA WORK + 5 
210f : e5 04 __ SBC WORK + 1 
2111 : 90 04 __ BCC $2117 ; (divmod32 + 63)
2113 : 86 07 __ STX WORK + 4 
2115 : 85 08 __ STA WORK + 5 
2117 : 88 __ __ DEY
2118 : d0 d3 __ BNE $20ed ; (divmod32 + 21)
211a : 26 1b __ ROL ACCU + 0 
211c : 26 1c __ ROL ACCU + 1 
211e : 26 1d __ ROL ACCU + 2 
2120 : 26 1e __ ROL ACCU + 3 
2122 : a4 02 __ LDY $02 
2124 : 60 __ __ RTS
2125 : 18 __ __ CLC
2126 : 26 1b __ ROL ACCU + 0 
2128 : 26 1c __ ROL ACCU + 1 
212a : 26 1d __ ROL ACCU + 2 
212c : 26 1e __ ROL ACCU + 3 
212e : 26 07 __ ROL WORK + 4 
2130 : 26 08 __ ROL WORK + 5 
2132 : 26 09 __ ROL WORK + 6 
2134 : 26 0a __ ROL WORK + 7 
2136 : a5 07 __ LDA WORK + 4 
2138 : c5 03 __ CMP WORK + 0 
213a : a5 08 __ LDA WORK + 5 
213c : e5 04 __ SBC WORK + 1 
213e : a5 09 __ LDA WORK + 6 
2140 : e5 05 __ SBC WORK + 2 
2142 : a5 0a __ LDA WORK + 7 
2144 : e5 06 __ SBC WORK + 3 
2146 : 90 18 __ BCC $2160 ; (divmod32 + 136)
2148 : a5 07 __ LDA WORK + 4 
214a : e5 03 __ SBC WORK + 0 
214c : 85 07 __ STA WORK + 4 
214e : a5 08 __ LDA WORK + 5 
2150 : e5 04 __ SBC WORK + 1 
2152 : 85 08 __ STA WORK + 5 
2154 : a5 09 __ LDA WORK + 6 
2156 : e5 05 __ SBC WORK + 2 
2158 : 85 09 __ STA WORK + 6 
215a : a5 0a __ LDA WORK + 7 
215c : e5 06 __ SBC WORK + 3 
215e : 85 0a __ STA WORK + 7 
2160 : 88 __ __ DEY
2161 : d0 c3 __ BNE $2126 ; (divmod32 + 78)
2163 : 26 1b __ ROL ACCU + 0 
2165 : 26 1c __ ROL ACCU + 1 
2167 : 26 1d __ ROL ACCU + 2 
2169 : 26 1e __ ROL ACCU + 3 
216b : a4 02 __ LDY $02 
216d : 60 __ __ RTS
--------------------------------------------------------------------
__multab3L:
216e : __ __ __ BYT 00 03 06 09 0c 0f 12 15 18 1b                   : ..........
