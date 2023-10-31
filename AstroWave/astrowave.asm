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
080e : 8e ff 0b STX $0bff ; (spentry + 0)
0811 : a9 02 __ LDA #$02
0813 : 85 19 __ STA IP + 0 
0815 : a9 0c __ LDA #$0c
0817 : 85 1a __ STA IP + 1 
0819 : 38 __ __ SEC
081a : a9 0c __ LDA #$0c
081c : e9 0c __ SBC #$0c
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
0830 : a9 29 __ LDA #$29
0832 : e9 02 __ SBC #$02
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
084b : a9 fe __ LDA #$fe
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
0bff : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
main:
.s0:
0880 : 20 b8 08 JSR $08b8 ; (init_player.s0 + 0)
0883 : 20 c3 08 JSR $08c3 ; (init_enemies.s0 + 0)
0886 : 20 d8 08 JSR $08d8 ; (init_game_screen.s0 + 0)
0889 : a9 00 __ LDA #$00
088b : 8d 22 0c STA $0c22 ; (game + 0)
088e : 85 0e __ STA P1 
0890 : a9 02 __ LDA #$02
0892 : 85 0d __ STA P0 
.l1002:
0894 : 20 ea 08 JSR $08ea ; (spawn_enemy.s0 + 0)
0897 : 20 4f 09 JSR $094f ; (move_enemies.s0 + 0)
089a : 20 bc 09 JSR $09bc ; (render_enemies.s0 + 0)
089d : 20 11 0a JSR $0a11 ; (check_player_enemy_collision.s0 + 0)
08a0 : 20 39 0a JSR $0a39 ; (control_player_ship.s0 + 0)
08a3 : 20 0f 0b JSR $0b0f ; (render_player_ship.s0 + 0)
08a6 : 20 11 0a JSR $0a11 ; (check_player_enemy_collision.s0 + 0)
08a9 : 20 4f 0b JSR $0b4f ; (wait_frames.s0 + 0)
08ac : ad 22 0c LDA $0c22 ; (game + 0)
08af : f0 e3 __ BEQ $0894 ; (main.l1002 + 0)
.s4:
08b1 : a9 00 __ LDA #$00
08b3 : 85 1b __ STA ACCU + 0 
08b5 : 85 1c __ STA ACCU + 1 
.s1001:
08b7 : 60 __ __ RTS
--------------------------------------------------------------------
init_player:
.s0:
08b8 : a9 05 __ LDA #$05
08ba : 8d 02 0c STA $0c02 ; (Player + 0)
08bd : a9 0c __ LDA #$0c
08bf : 8d 03 0c STA $0c03 ; (Player + 1)
.s1001:
08c2 : 60 __ __ RTS
--------------------------------------------------------------------
Player:
0c02 : __ __ __ BSS	2
--------------------------------------------------------------------
init_enemies:
.s0:
08c3 : a0 0a __ LDY #$0a
08c5 : a2 00 __ LDX #$00
08c7 : 8a __ __ TXA
.l1004:
08c8 : 9d 04 0c STA $0c04,x ; (Enemy + 0)
08cb : 9d 05 0c STA $0c05,x ; (Enemy + 1)
08ce : 9d 06 0c STA $0c06,x ; (Enemy + 2)
08d1 : e8 __ __ INX
08d2 : e8 __ __ INX
08d3 : e8 __ __ INX
08d4 : 88 __ __ DEY
08d5 : d0 f1 __ BNE $08c8 ; (init_enemies.l1004 + 0)
.s1001:
08d7 : 60 __ __ RTS
--------------------------------------------------------------------
Enemy:
0c04 : __ __ __ BSS	30
--------------------------------------------------------------------
init_game_screen:
.s0:
08d8 : 20 e6 08 JSR $08e6 ; (clrscr.s0 + 0)
08db : a9 00 __ LDA #$00
08dd : 8d 21 d0 STA $d021 
08e0 : a9 0b __ LDA #$0b
08e2 : 8d 20 d0 STA $d020 
.s1001:
08e5 : 60 __ __ RTS
--------------------------------------------------------------------
clrscr:
.s0:
08e6 : 20 81 ff JSR $ff81 
.s1001:
08e9 : 60 __ __ RTS
--------------------------------------------------------------------
game:
0c22 : __ __ __ BSS	1
--------------------------------------------------------------------
spawn_enemy:
.s0:
08ea : 20 28 09 JSR $0928 ; (rand.s0 + 0)
08ed : 46 1b __ LSR ACCU + 0 
08ef : b0 0f __ BCS $0900 ; (spawn_enemy.s1001 + 0)
.s3:
08f1 : a0 00 __ LDY #$00
.l6:
08f3 : be f5 0b LDX $0bf5,y ; (__multab3L + 0)
08f6 : bd 06 0c LDA $0c06,x ; (Enemy + 2)
08f9 : f0 06 __ BEQ $0901 ; (spawn_enemy.s9 + 0)
.s7:
08fb : c8 __ __ INY
08fc : c0 0a __ CPY #$0a
08fe : 90 f3 __ BCC $08f3 ; (spawn_enemy.l6 + 0)
.s1001:
0900 : 60 __ __ RTS
.s9:
0901 : 86 43 __ STX T0 + 0 
0903 : a9 27 __ LDA #$27
0905 : 9d 04 0c STA $0c04,x ; (Enemy + 0)
0908 : 20 28 09 JSR $0928 ; (rand.s0 + 0)
090b : a9 01 __ LDA #$01
090d : a6 43 __ LDX T0 + 0 
090f : 9d 06 0c STA $0c06,x ; (Enemy + 2)
0912 : a9 16 __ LDA #$16
0914 : 85 03 __ STA WORK + 0 
0916 : a9 00 __ LDA #$00
0918 : 85 04 __ STA WORK + 1 
091a : 20 70 0b JSR $0b70 ; (divmod + 0)
091d : 18 __ __ CLC
091e : a5 05 __ LDA WORK + 2 
0920 : 69 03 __ ADC #$03
0922 : a6 43 __ LDX T0 + 0 
0924 : 9d 05 0c STA $0c05,x ; (Enemy + 1)
0927 : 60 __ __ RTS
--------------------------------------------------------------------
rand:
.s0:
0928 : ad 01 0c LDA $0c01 ; (seed + 1)
092b : 4a __ __ LSR
092c : ad 00 0c LDA $0c00 ; (seed + 0)
092f : 6a __ __ ROR
0930 : aa __ __ TAX
0931 : a9 00 __ LDA #$00
0933 : 6a __ __ ROR
0934 : 4d 00 0c EOR $0c00 ; (seed + 0)
0937 : 85 1b __ STA ACCU + 0 
0939 : 8a __ __ TXA
093a : 4d 01 0c EOR $0c01 ; (seed + 1)
093d : 85 1c __ STA ACCU + 1 
093f : 4a __ __ LSR
0940 : 45 1b __ EOR ACCU + 0 
0942 : 8d 00 0c STA $0c00 ; (seed + 0)
0945 : 85 1b __ STA ACCU + 0 
0947 : 45 1c __ EOR ACCU + 1 
0949 : 8d 01 0c STA $0c01 ; (seed + 1)
094c : 85 1c __ STA ACCU + 1 
.s1001:
094e : 60 __ __ RTS
--------------------------------------------------------------------
seed:
0c00 : __ __ __ BYT 00 7a                                           : .z
--------------------------------------------------------------------
move_enemies:
.s0:
094f : a2 00 __ LDX #$00
.l1006:
0951 : bc f5 0b LDY $0bf5,x ; (__multab3L + 0)
0954 : b9 06 0c LDA $0c06,y ; (Enemy + 2)
0957 : c9 01 __ CMP #$01
0959 : d0 5b __ BNE $09b6 ; (move_enemies.s23 + 0)
.s5:
095b : 84 1d __ STY ACCU + 2 
095d : b9 05 0c LDA $0c05,y ; (Enemy + 1)
0960 : 0a __ __ ASL
0961 : 85 1b __ STA ACCU + 0 
0963 : a9 00 __ LDA #$00
0965 : 2a __ __ ROL
0966 : 06 1b __ ASL ACCU + 0 
0968 : 2a __ __ ROL
0969 : 85 1c __ STA ACCU + 1 
096b : a5 1b __ LDA ACCU + 0 
096d : 79 05 0c ADC $0c05,y ; (Enemy + 1)
0970 : 85 1b __ STA ACCU + 0 
0972 : a5 1c __ LDA ACCU + 1 
0974 : 69 00 __ ADC #$00
0976 : 06 1b __ ASL ACCU + 0 
0978 : 2a __ __ ROL
0979 : 06 1b __ ASL ACCU + 0 
097b : 2a __ __ ROL
097c : 06 1b __ ASL ACCU + 0 
097e : 2a __ __ ROL
097f : 85 1c __ STA ACCU + 1 
0981 : b9 04 0c LDA $0c04,y ; (Enemy + 0)
0984 : 85 1e __ STA ACCU + 3 
0986 : 18 __ __ CLC
0987 : 65 1b __ ADC ACCU + 0 
0989 : 85 1b __ STA ACCU + 0 
098b : 85 1f __ STA ADDR + 0 
098d : a5 1c __ LDA ACCU + 1 
098f : 69 04 __ ADC #$04
0991 : 85 1c __ STA ACCU + 1 
0993 : 18 __ __ CLC
0994 : 69 d4 __ ADC #$d4
0996 : 85 20 __ STA ADDR + 1 
0998 : a9 20 __ LDA #$20
099a : a0 00 __ LDY #$00
099c : 91 1b __ STA (ACCU + 0),y 
099e : 98 __ __ TYA
099f : 91 1f __ STA (ADDR + 0),y 
09a1 : a5 1e __ LDA ACCU + 3 
09a3 : d0 08 __ BNE $09ad ; (move_enemies.s8 + 0)
.s9:
09a5 : a4 1d __ LDY ACCU + 2 
09a7 : 99 06 0c STA $0c06,y ; (Enemy + 2)
09aa : 4c b6 09 JMP $09b6 ; (move_enemies.s23 + 0)
.s8:
09ad : c6 1e __ DEC ACCU + 3 
09af : a5 1e __ LDA ACCU + 3 
09b1 : a4 1d __ LDY ACCU + 2 
09b3 : 99 04 0c STA $0c04,y ; (Enemy + 0)
.s23:
09b6 : e8 __ __ INX
09b7 : e0 0a __ CPX #$0a
09b9 : 90 96 __ BCC $0951 ; (move_enemies.l1006 + 0)
.s1001:
09bb : 60 __ __ RTS
--------------------------------------------------------------------
render_enemies:
.s0:
09bc : a2 00 __ LDX #$00
.l1006:
09be : bc f5 0b LDY $0bf5,x ; (__multab3L + 0)
09c1 : b9 06 0c LDA $0c06,y ; (Enemy + 2)
09c4 : c9 01 __ CMP #$01
09c6 : d0 43 __ BNE $0a0b ; (render_enemies.s19 + 0)
.s5:
09c8 : b9 05 0c LDA $0c05,y ; (Enemy + 1)
09cb : 0a __ __ ASL
09cc : 85 1b __ STA ACCU + 0 
09ce : a9 00 __ LDA #$00
09d0 : 2a __ __ ROL
09d1 : 06 1b __ ASL ACCU + 0 
09d3 : 2a __ __ ROL
09d4 : 85 1c __ STA ACCU + 1 
09d6 : a5 1b __ LDA ACCU + 0 
09d8 : 79 05 0c ADC $0c05,y ; (Enemy + 1)
09db : 85 1b __ STA ACCU + 0 
09dd : a5 1c __ LDA ACCU + 1 
09df : 69 00 __ ADC #$00
09e1 : 06 1b __ ASL ACCU + 0 
09e3 : 2a __ __ ROL
09e4 : 06 1b __ ASL ACCU + 0 
09e6 : 2a __ __ ROL
09e7 : 06 1b __ ASL ACCU + 0 
09e9 : 2a __ __ ROL
09ea : 85 1c __ STA ACCU + 1 
09ec : 18 __ __ CLC
09ed : a5 1b __ LDA ACCU + 0 
09ef : 79 04 0c ADC $0c04,y ; (Enemy + 0)
09f2 : 85 1b __ STA ACCU + 0 
09f4 : 85 1f __ STA ADDR + 0 
09f6 : a5 1c __ LDA ACCU + 1 
09f8 : 69 04 __ ADC #$04
09fa : 85 1c __ STA ACCU + 1 
09fc : 18 __ __ CLC
09fd : 69 d4 __ ADC #$d4
09ff : 85 20 __ STA ADDR + 1 
0a01 : a9 58 __ LDA #$58
0a03 : a0 00 __ LDY #$00
0a05 : 91 1b __ STA (ACCU + 0),y 
0a07 : a9 08 __ LDA #$08
0a09 : 91 1f __ STA (ADDR + 0),y 
.s19:
0a0b : e8 __ __ INX
0a0c : e0 0a __ CPX #$0a
0a0e : 90 ae __ BCC $09be ; (render_enemies.l1006 + 0)
.s1001:
0a10 : 60 __ __ RTS
--------------------------------------------------------------------
check_player_enemy_collision:
.s0:
0a11 : a0 00 __ LDY #$00
.l2:
0a13 : be f5 0b LDX $0bf5,y ; (__multab3L + 0)
0a16 : bd 06 0c LDA $0c06,x ; (Enemy + 2)
0a19 : c9 01 __ CMP #$01
0a1b : d0 10 __ BNE $0a2d ; (check_player_enemy_collision.s3 + 0)
.s5:
0a1d : bd 04 0c LDA $0c04,x ; (Enemy + 0)
0a20 : cd 02 0c CMP $0c02 ; (Player + 0)
0a23 : d0 08 __ BNE $0a2d ; (check_player_enemy_collision.s3 + 0)
.s11:
0a25 : bd 05 0c LDA $0c05,x ; (Enemy + 1)
0a28 : cd 03 0c CMP $0c03 ; (Player + 1)
0a2b : f0 06 __ BEQ $0a33 ; (check_player_enemy_collision.s8 + 0)
.s3:
0a2d : c8 __ __ INY
0a2e : c0 0a __ CPY #$0a
0a30 : 90 e1 __ BCC $0a13 ; (check_player_enemy_collision.l2 + 0)
.s1001:
0a32 : 60 __ __ RTS
.s8:
0a33 : a9 01 __ LDA #$01
0a35 : 8d 22 0c STA $0c22 ; (game + 0)
0a38 : 60 __ __ RTS
--------------------------------------------------------------------
control_player_ship:
.s0:
0a39 : a9 00 __ LDA #$00
0a3b : 20 cf 0a JSR $0acf ; (joy_poll.s0 + 0)
0a3e : ad 25 0c LDA $0c25 ; (joyx + 0)
0a41 : 85 1d __ STA ACCU + 2 
0a43 : 85 1e __ STA ACCU + 3 
0a45 : d0 06 __ BNE $0a4d ; (control_player_ship.s1 + 0)
.s4:
0a47 : ad 23 0c LDA $0c23 ; (joyy + 0)
0a4a : d0 01 __ BNE $0a4d ; (control_player_ship.s1 + 0)
0a4c : 60 __ __ RTS
.s1:
0a4d : ad 02 0c LDA $0c02 ; (Player + 0)
0a50 : 85 43 __ STA T2 + 0 
0a52 : 85 44 __ STA T3 + 0 
0a54 : ad 03 0c LDA $0c03 ; (Player + 1)
0a57 : 85 45 __ STA T4 + 0 
0a59 : 85 46 __ STA T5 + 0 
0a5b : 0a __ __ ASL
0a5c : 85 1b __ STA ACCU + 0 
0a5e : a9 00 __ LDA #$00
0a60 : 2a __ __ ROL
0a61 : 06 1b __ ASL ACCU + 0 
0a63 : 2a __ __ ROL
0a64 : aa __ __ TAX
0a65 : a5 1b __ LDA ACCU + 0 
0a67 : 65 45 __ ADC T4 + 0 
0a69 : 85 1b __ STA ACCU + 0 
0a6b : 8a __ __ TXA
0a6c : 69 00 __ ADC #$00
0a6e : 06 1b __ ASL ACCU + 0 
0a70 : 2a __ __ ROL
0a71 : 06 1b __ ASL ACCU + 0 
0a73 : 2a __ __ ROL
0a74 : 06 1b __ ASL ACCU + 0 
0a76 : 2a __ __ ROL
0a77 : aa __ __ TAX
0a78 : 18 __ __ CLC
0a79 : a5 1b __ LDA ACCU + 0 
0a7b : 65 43 __ ADC T2 + 0 
0a7d : 85 1b __ STA ACCU + 0 
0a7f : 85 1f __ STA ADDR + 0 
0a81 : 8a __ __ TXA
0a82 : 69 04 __ ADC #$04
0a84 : 85 1c __ STA ACCU + 1 
0a86 : 18 __ __ CLC
0a87 : 69 d4 __ ADC #$d4
0a89 : 85 20 __ STA ADDR + 1 
0a8b : a9 20 __ LDA #$20
0a8d : a0 00 __ LDY #$00
0a8f : 91 1b __ STA (ACCU + 0),y 
0a91 : 98 __ __ TYA
0a92 : 91 1f __ STA (ADDR + 0),y 
0a94 : a5 43 __ LDA T2 + 0 
0a96 : f0 04 __ BEQ $0a9c ; (control_player_ship.s6 + 0)
.s8:
0a98 : a5 1d __ LDA ACCU + 2 
0a9a : 30 0c __ BMI $0aa8 ; (control_player_ship.s5 + 0)
.s6:
0a9c : a5 43 __ LDA T2 + 0 
0a9e : c9 27 __ CMP #$27
0aa0 : b0 0e __ BCS $0ab0 ; (control_player_ship.s7 + 0)
.s12:
0aa2 : a5 1d __ LDA ACCU + 2 
0aa4 : 30 0a __ BMI $0ab0 ; (control_player_ship.s7 + 0)
.s1007:
0aa6 : f0 08 __ BEQ $0ab0 ; (control_player_ship.s7 + 0)
.s5:
0aa8 : 18 __ __ CLC
0aa9 : a5 44 __ LDA T3 + 0 
0aab : 65 1e __ ADC ACCU + 3 
0aad : 8d 02 0c STA $0c02 ; (Player + 0)
.s7:
0ab0 : a5 45 __ LDA T4 + 0 
0ab2 : c9 04 __ CMP #$04
0ab4 : 90 07 __ BCC $0abd ; (control_player_ship.s14 + 0)
.s16:
0ab6 : ad 23 0c LDA $0c23 ; (joyy + 0)
0ab9 : 30 0d __ BMI $0ac8 ; (control_player_ship.s28 + 0)
.s1010:
0abb : a5 45 __ LDA T4 + 0 
.s14:
0abd : c9 18 __ CMP #$18
0abf : b0 0d __ BCS $0ace ; (control_player_ship.s1001 + 0)
.s20:
0ac1 : ad 23 0c LDA $0c23 ; (joyy + 0)
0ac4 : 30 08 __ BMI $0ace ; (control_player_ship.s1001 + 0)
.s1002:
0ac6 : f0 06 __ BEQ $0ace ; (control_player_ship.s1001 + 0)
.s28:
0ac8 : 18 __ __ CLC
0ac9 : 65 46 __ ADC T5 + 0 
0acb : 8d 03 0c STA $0c03 ; (Player + 1)
.s1001:
0ace : 60 __ __ RTS
--------------------------------------------------------------------
joy_poll:
.s0:
0acf : aa __ __ TAX
0ad0 : bd 00 dc LDA $dc00,x 
0ad3 : a8 __ __ TAY
0ad4 : 29 10 __ AND #$10
0ad6 : f0 04 __ BEQ $0adc ; (joy_poll.s1005 + 0)
.s1006:
0ad8 : a9 00 __ LDA #$00
0ada : f0 02 __ BEQ $0ade ; (joy_poll.s1007 + 0)
.s1005:
0adc : a9 01 __ LDA #$01
.s1007:
0ade : 9d 27 0c STA $0c27,x ; (joyb + 0)
0ae1 : 98 __ __ TYA
0ae2 : 4a __ __ LSR
0ae3 : b0 1d __ BCS $0b02 ; (joy_poll.s2 + 0)
.s1:
0ae5 : a9 ff __ LDA #$ff
.s15:
0ae7 : 9d 23 0c STA $0c23,x ; (joyy + 0)
0aea : 98 __ __ TYA
0aeb : 29 04 __ AND #$04
0aed : d0 06 __ BNE $0af5 ; (joy_poll.s8 + 0)
.s7:
0aef : a9 ff __ LDA #$ff
.s1001:
0af1 : 9d 25 0c STA $0c25,x ; (joyx + 0)
0af4 : 60 __ __ RTS
.s8:
0af5 : 98 __ __ TYA
0af6 : 29 08 __ AND #$08
0af8 : f0 04 __ BEQ $0afe ; (joy_poll.s1011 + 0)
.s1012:
0afa : a9 00 __ LDA #$00
0afc : f0 f3 __ BEQ $0af1 ; (joy_poll.s1001 + 0)
.s1011:
0afe : a9 01 __ LDA #$01
0b00 : d0 ef __ BNE $0af1 ; (joy_poll.s1001 + 0)
.s2:
0b02 : 98 __ __ TYA
0b03 : 29 02 __ AND #$02
0b05 : f0 04 __ BEQ $0b0b ; (joy_poll.s1008 + 0)
.s1009:
0b07 : a9 00 __ LDA #$00
0b09 : f0 dc __ BEQ $0ae7 ; (joy_poll.s15 + 0)
.s1008:
0b0b : a9 01 __ LDA #$01
0b0d : d0 d8 __ BNE $0ae7 ; (joy_poll.s15 + 0)
--------------------------------------------------------------------
joyy:
0c23 : __ __ __ BSS	2
--------------------------------------------------------------------
joyx:
0c25 : __ __ __ BSS	2
--------------------------------------------------------------------
joyb:
0c27 : __ __ __ BSS	2
--------------------------------------------------------------------
render_player_ship:
.s0:
0b0f : ad 03 0c LDA $0c03 ; (Player + 1)
0b12 : 0a __ __ ASL
0b13 : 85 1b __ STA ACCU + 0 
0b15 : a9 00 __ LDA #$00
0b17 : 2a __ __ ROL
0b18 : 06 1b __ ASL ACCU + 0 
0b1a : 2a __ __ ROL
0b1b : aa __ __ TAX
0b1c : a5 1b __ LDA ACCU + 0 
0b1e : 6d 03 0c ADC $0c03 ; (Player + 1)
0b21 : 85 1b __ STA ACCU + 0 
0b23 : 8a __ __ TXA
0b24 : 69 00 __ ADC #$00
0b26 : 06 1b __ ASL ACCU + 0 
0b28 : 2a __ __ ROL
0b29 : 06 1b __ ASL ACCU + 0 
0b2b : 2a __ __ ROL
0b2c : 06 1b __ ASL ACCU + 0 
0b2e : 2a __ __ ROL
0b2f : aa __ __ TAX
0b30 : 18 __ __ CLC
0b31 : a5 1b __ LDA ACCU + 0 
0b33 : 6d 02 0c ADC $0c02 ; (Player + 0)
0b36 : 85 1b __ STA ACCU + 0 
0b38 : 85 1f __ STA ADDR + 0 
0b3a : 8a __ __ TXA
0b3b : 69 04 __ ADC #$04
0b3d : 85 1c __ STA ACCU + 1 
0b3f : 18 __ __ CLC
0b40 : 69 d4 __ ADC #$d4
0b42 : 85 20 __ STA ADDR + 1 
0b44 : a9 51 __ LDA #$51
0b46 : a0 00 __ LDY #$00
0b48 : 91 1b __ STA (ACCU + 0),y 
0b4a : a9 03 __ LDA #$03
0b4c : 91 1f __ STA (ADDR + 0),y 
.s1001:
0b4e : 60 __ __ RTS
--------------------------------------------------------------------
wait_frames:
.s0:
0b4f : a5 0e __ LDA P1 ; (frames + 1)
0b51 : 30 1c __ BMI $0b6f ; (wait_frames.s1001 + 0)
.s1005:
0b53 : 05 0d __ ORA P0 ; (frames + 0)
0b55 : f0 18 __ BEQ $0b6f ; (wait_frames.s1001 + 0)
.s13:
0b57 : a0 00 __ LDY #$00
0b59 : a6 0e __ LDX P1 ; (frames + 1)
.l6:
0b5b : ad 11 d0 LDA $d011 
0b5e : 30 fb __ BMI $0b5b ; (wait_frames.l6 + 0)
.l9:
0b60 : ad 11 d0 LDA $d011 
0b63 : 10 fb __ BPL $0b60 ; (wait_frames.l9 + 0)
.s3:
0b65 : c8 __ __ INY
0b66 : 8a __ __ TXA
0b67 : 30 06 __ BMI $0b6f ; (wait_frames.s1001 + 0)
.s1004:
0b69 : d0 f0 __ BNE $0b5b ; (wait_frames.l6 + 0)
.s1002:
0b6b : c4 0d __ CPY P0 ; (frames + 0)
0b6d : 90 ec __ BCC $0b5b ; (wait_frames.l6 + 0)
.s1001:
0b6f : 60 __ __ RTS
--------------------------------------------------------------------
divmod:
0b70 : a5 1c __ LDA ACCU + 1 
0b72 : d0 31 __ BNE $0ba5 ; (divmod + 53)
0b74 : a5 04 __ LDA WORK + 1 
0b76 : d0 1e __ BNE $0b96 ; (divmod + 38)
0b78 : 85 06 __ STA WORK + 3 
0b7a : a2 04 __ LDX #$04
0b7c : 06 1b __ ASL ACCU + 0 
0b7e : 2a __ __ ROL
0b7f : c5 03 __ CMP WORK + 0 
0b81 : 90 02 __ BCC $0b85 ; (divmod + 21)
0b83 : e5 03 __ SBC WORK + 0 
0b85 : 26 1b __ ROL ACCU + 0 
0b87 : 2a __ __ ROL
0b88 : c5 03 __ CMP WORK + 0 
0b8a : 90 02 __ BCC $0b8e ; (divmod + 30)
0b8c : e5 03 __ SBC WORK + 0 
0b8e : 26 1b __ ROL ACCU + 0 
0b90 : ca __ __ DEX
0b91 : d0 eb __ BNE $0b7e ; (divmod + 14)
0b93 : 85 05 __ STA WORK + 2 
0b95 : 60 __ __ RTS
0b96 : a5 1b __ LDA ACCU + 0 
0b98 : 85 05 __ STA WORK + 2 
0b9a : a5 1c __ LDA ACCU + 1 
0b9c : 85 06 __ STA WORK + 3 
0b9e : a9 00 __ LDA #$00
0ba0 : 85 1b __ STA ACCU + 0 
0ba2 : 85 1c __ STA ACCU + 1 
0ba4 : 60 __ __ RTS
0ba5 : a5 04 __ LDA WORK + 1 
0ba7 : d0 1f __ BNE $0bc8 ; (divmod + 88)
0ba9 : a5 03 __ LDA WORK + 0 
0bab : 30 1b __ BMI $0bc8 ; (divmod + 88)
0bad : a9 00 __ LDA #$00
0baf : 85 06 __ STA WORK + 3 
0bb1 : a2 10 __ LDX #$10
0bb3 : 06 1b __ ASL ACCU + 0 
0bb5 : 26 1c __ ROL ACCU + 1 
0bb7 : 2a __ __ ROL
0bb8 : c5 03 __ CMP WORK + 0 
0bba : 90 02 __ BCC $0bbe ; (divmod + 78)
0bbc : e5 03 __ SBC WORK + 0 
0bbe : 26 1b __ ROL ACCU + 0 
0bc0 : 26 1c __ ROL ACCU + 1 
0bc2 : ca __ __ DEX
0bc3 : d0 f2 __ BNE $0bb7 ; (divmod + 71)
0bc5 : 85 05 __ STA WORK + 2 
0bc7 : 60 __ __ RTS
0bc8 : a9 00 __ LDA #$00
0bca : 85 05 __ STA WORK + 2 
0bcc : 85 06 __ STA WORK + 3 
0bce : 84 02 __ STY $02 
0bd0 : a0 10 __ LDY #$10
0bd2 : 18 __ __ CLC
0bd3 : 26 1b __ ROL ACCU + 0 
0bd5 : 26 1c __ ROL ACCU + 1 
0bd7 : 26 05 __ ROL WORK + 2 
0bd9 : 26 06 __ ROL WORK + 3 
0bdb : 38 __ __ SEC
0bdc : a5 05 __ LDA WORK + 2 
0bde : e5 03 __ SBC WORK + 0 
0be0 : aa __ __ TAX
0be1 : a5 06 __ LDA WORK + 3 
0be3 : e5 04 __ SBC WORK + 1 
0be5 : 90 04 __ BCC $0beb ; (divmod + 123)
0be7 : 86 05 __ STX WORK + 2 
0be9 : 85 06 __ STA WORK + 3 
0beb : 88 __ __ DEY
0bec : d0 e5 __ BNE $0bd3 ; (divmod + 99)
0bee : 26 1b __ ROL ACCU + 0 
0bf0 : 26 1c __ ROL ACCU + 1 
0bf2 : a4 02 __ LDY $02 
0bf4 : 60 __ __ RTS
--------------------------------------------------------------------
__multab3L:
0bf5 : __ __ __ BYT 00 03 06 09 0c 0f 12 15 18 1b                   : ..........
