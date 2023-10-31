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
080e : 8e d2 0b STX $0bd2 ; (spentry + 0)
0811 : a9 d5 __ LDA #$d5
0813 : 85 19 __ STA IP + 0 
0815 : a9 0b __ LDA #$0b
0817 : 85 1a __ STA IP + 1 
0819 : 38 __ __ SEC
081a : a9 0b __ LDA #$0b
081c : e9 0b __ SBC #$0b
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
0830 : a9 fb __ LDA #$fb
0832 : e9 d5 __ SBC #$d5
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
0bd2 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
main:
.s0:
0880 : 20 a6 08 JSR $08a6 ; (init_player.s0 + 0)
0883 : 20 b1 08 JSR $08b1 ; (init_enemies.s0 + 0)
0886 : 20 c6 08 JSR $08c6 ; (init_game_screen.s0 + 0)
.l3:
0889 : 20 d8 08 JSR $08d8 ; (spawn_enemy.s0 + 0)
088c : 20 4a 09 JSR $094a ; (move_enemies.s0 + 0)
088f : 20 b7 09 JSR $09b7 ; (render_enemies.s0 + 0)
0892 : 20 0c 0a JSR $0a0c ; (control_player_ship.s0 + 0)
0895 : 20 e2 0a JSR $0ae2 ; (render_player_ship.s0 + 0)
0898 : a9 05 __ LDA #$05
089a : 85 0d __ STA P0 
089c : a9 00 __ LDA #$00
089e : 85 0e __ STA P1 
08a0 : 20 22 0b JSR $0b22 ; (wait_frames.s0 + 0)
08a3 : 4c 89 08 JMP $0889 ; (main.l3 + 0)
--------------------------------------------------------------------
init_player:
.s0:
08a6 : a9 05 __ LDA #$05
08a8 : 8d d5 0b STA $0bd5 ; (Player + 0)
08ab : a9 0c __ LDA #$0c
08ad : 8d d6 0b STA $0bd6 ; (Player + 1)
.s1001:
08b0 : 60 __ __ RTS
--------------------------------------------------------------------
Player:
0bd5 : __ __ __ BSS	2
--------------------------------------------------------------------
init_enemies:
.s0:
08b1 : a0 0a __ LDY #$0a
08b3 : a2 00 __ LDX #$00
08b5 : 8a __ __ TXA
.l1004:
08b6 : 9d d7 0b STA $0bd7,x ; (Enemy + 0)
08b9 : 9d d8 0b STA $0bd8,x ; (Enemy + 1)
08bc : 9d d9 0b STA $0bd9,x ; (Enemy + 2)
08bf : e8 __ __ INX
08c0 : e8 __ __ INX
08c1 : e8 __ __ INX
08c2 : 88 __ __ DEY
08c3 : d0 f1 __ BNE $08b6 ; (init_enemies.l1004 + 0)
.s1001:
08c5 : 60 __ __ RTS
--------------------------------------------------------------------
Enemy:
0bd7 : __ __ __ BSS	30
--------------------------------------------------------------------
init_game_screen:
.s0:
08c6 : 20 d4 08 JSR $08d4 ; (clrscr.s0 + 0)
08c9 : a9 00 __ LDA #$00
08cb : 8d 21 d0 STA $d021 
08ce : a9 0b __ LDA #$0b
08d0 : 8d 20 d0 STA $d020 
.s1001:
08d3 : 60 __ __ RTS
--------------------------------------------------------------------
clrscr:
.s0:
08d4 : 20 81 ff JSR $ff81 
.s1001:
08d7 : 60 __ __ RTS
--------------------------------------------------------------------
spawn_enemy:
.s0:
08d8 : 20 23 09 JSR $0923 ; (rand.s0 + 0)
08db : a9 0a __ LDA #$0a
08dd : 85 03 __ STA WORK + 0 
08df : a9 00 __ LDA #$00
08e1 : 85 04 __ STA WORK + 1 
08e3 : 20 43 0b JSR $0b43 ; (divmod + 0)
08e6 : a5 05 __ LDA WORK + 2 
08e8 : 05 06 __ ORA WORK + 3 
08ea : d0 0f __ BNE $08fb ; (spawn_enemy.s1001 + 0)
.s3:
08ec : a0 00 __ LDY #$00
.l6:
08ee : be c8 0b LDX $0bc8,y ; (__multab3L + 0)
08f1 : bd d9 0b LDA $0bd9,x ; (Enemy + 2)
08f4 : f0 06 __ BEQ $08fc ; (spawn_enemy.s9 + 0)
.s7:
08f6 : c8 __ __ INY
08f7 : c0 0a __ CPY #$0a
08f9 : 90 f3 __ BCC $08ee ; (spawn_enemy.l6 + 0)
.s1001:
08fb : 60 __ __ RTS
.s9:
08fc : 86 43 __ STX T0 + 0 
08fe : a9 27 __ LDA #$27
0900 : 9d d7 0b STA $0bd7,x ; (Enemy + 0)
0903 : 20 23 09 JSR $0923 ; (rand.s0 + 0)
0906 : a9 01 __ LDA #$01
0908 : a6 43 __ LDX T0 + 0 
090a : 9d d9 0b STA $0bd9,x ; (Enemy + 2)
090d : a9 16 __ LDA #$16
090f : 85 03 __ STA WORK + 0 
0911 : a9 00 __ LDA #$00
0913 : 85 04 __ STA WORK + 1 
0915 : 20 43 0b JSR $0b43 ; (divmod + 0)
0918 : 18 __ __ CLC
0919 : a5 05 __ LDA WORK + 2 
091b : 69 03 __ ADC #$03
091d : a6 43 __ LDX T0 + 0 
091f : 9d d8 0b STA $0bd8,x ; (Enemy + 1)
0922 : 60 __ __ RTS
--------------------------------------------------------------------
rand:
.s0:
0923 : ad d4 0b LDA $0bd4 ; (seed + 1)
0926 : 4a __ __ LSR
0927 : ad d3 0b LDA $0bd3 ; (seed + 0)
092a : 6a __ __ ROR
092b : aa __ __ TAX
092c : a9 00 __ LDA #$00
092e : 6a __ __ ROR
092f : 4d d3 0b EOR $0bd3 ; (seed + 0)
0932 : 85 1b __ STA ACCU + 0 
0934 : 8a __ __ TXA
0935 : 4d d4 0b EOR $0bd4 ; (seed + 1)
0938 : 85 1c __ STA ACCU + 1 
093a : 4a __ __ LSR
093b : 45 1b __ EOR ACCU + 0 
093d : 8d d3 0b STA $0bd3 ; (seed + 0)
0940 : 85 1b __ STA ACCU + 0 
0942 : 45 1c __ EOR ACCU + 1 
0944 : 8d d4 0b STA $0bd4 ; (seed + 1)
0947 : 85 1c __ STA ACCU + 1 
.s1001:
0949 : 60 __ __ RTS
--------------------------------------------------------------------
seed:
0bd3 : __ __ __ BYT 00 7a                                           : .z
--------------------------------------------------------------------
move_enemies:
.s0:
094a : a2 00 __ LDX #$00
.l1006:
094c : bc c8 0b LDY $0bc8,x ; (__multab3L + 0)
094f : b9 d9 0b LDA $0bd9,y ; (Enemy + 2)
0952 : c9 01 __ CMP #$01
0954 : d0 5b __ BNE $09b1 ; (move_enemies.s23 + 0)
.s5:
0956 : 84 1d __ STY ACCU + 2 
0958 : b9 d8 0b LDA $0bd8,y ; (Enemy + 1)
095b : 0a __ __ ASL
095c : 85 1b __ STA ACCU + 0 
095e : a9 00 __ LDA #$00
0960 : 2a __ __ ROL
0961 : 06 1b __ ASL ACCU + 0 
0963 : 2a __ __ ROL
0964 : 85 1c __ STA ACCU + 1 
0966 : a5 1b __ LDA ACCU + 0 
0968 : 79 d8 0b ADC $0bd8,y ; (Enemy + 1)
096b : 85 1b __ STA ACCU + 0 
096d : a5 1c __ LDA ACCU + 1 
096f : 69 00 __ ADC #$00
0971 : 06 1b __ ASL ACCU + 0 
0973 : 2a __ __ ROL
0974 : 06 1b __ ASL ACCU + 0 
0976 : 2a __ __ ROL
0977 : 06 1b __ ASL ACCU + 0 
0979 : 2a __ __ ROL
097a : 85 1c __ STA ACCU + 1 
097c : b9 d7 0b LDA $0bd7,y ; (Enemy + 0)
097f : 85 1e __ STA ACCU + 3 
0981 : 18 __ __ CLC
0982 : 65 1b __ ADC ACCU + 0 
0984 : 85 1b __ STA ACCU + 0 
0986 : 85 1f __ STA ADDR + 0 
0988 : a5 1c __ LDA ACCU + 1 
098a : 69 04 __ ADC #$04
098c : 85 1c __ STA ACCU + 1 
098e : 18 __ __ CLC
098f : 69 d4 __ ADC #$d4
0991 : 85 20 __ STA ADDR + 1 
0993 : a9 20 __ LDA #$20
0995 : a0 00 __ LDY #$00
0997 : 91 1b __ STA (ACCU + 0),y 
0999 : 98 __ __ TYA
099a : 91 1f __ STA (ADDR + 0),y 
099c : a5 1e __ LDA ACCU + 3 
099e : d0 08 __ BNE $09a8 ; (move_enemies.s8 + 0)
.s9:
09a0 : a4 1d __ LDY ACCU + 2 
09a2 : 99 d9 0b STA $0bd9,y ; (Enemy + 2)
09a5 : 4c b1 09 JMP $09b1 ; (move_enemies.s23 + 0)
.s8:
09a8 : c6 1e __ DEC ACCU + 3 
09aa : a5 1e __ LDA ACCU + 3 
09ac : a4 1d __ LDY ACCU + 2 
09ae : 99 d7 0b STA $0bd7,y ; (Enemy + 0)
.s23:
09b1 : e8 __ __ INX
09b2 : e0 0a __ CPX #$0a
09b4 : 90 96 __ BCC $094c ; (move_enemies.l1006 + 0)
.s1001:
09b6 : 60 __ __ RTS
--------------------------------------------------------------------
render_enemies:
.s0:
09b7 : a2 00 __ LDX #$00
.l1006:
09b9 : bc c8 0b LDY $0bc8,x ; (__multab3L + 0)
09bc : b9 d9 0b LDA $0bd9,y ; (Enemy + 2)
09bf : c9 01 __ CMP #$01
09c1 : d0 43 __ BNE $0a06 ; (render_enemies.s19 + 0)
.s5:
09c3 : b9 d8 0b LDA $0bd8,y ; (Enemy + 1)
09c6 : 0a __ __ ASL
09c7 : 85 1b __ STA ACCU + 0 
09c9 : a9 00 __ LDA #$00
09cb : 2a __ __ ROL
09cc : 06 1b __ ASL ACCU + 0 
09ce : 2a __ __ ROL
09cf : 85 1c __ STA ACCU + 1 
09d1 : a5 1b __ LDA ACCU + 0 
09d3 : 79 d8 0b ADC $0bd8,y ; (Enemy + 1)
09d6 : 85 1b __ STA ACCU + 0 
09d8 : a5 1c __ LDA ACCU + 1 
09da : 69 00 __ ADC #$00
09dc : 06 1b __ ASL ACCU + 0 
09de : 2a __ __ ROL
09df : 06 1b __ ASL ACCU + 0 
09e1 : 2a __ __ ROL
09e2 : 06 1b __ ASL ACCU + 0 
09e4 : 2a __ __ ROL
09e5 : 85 1c __ STA ACCU + 1 
09e7 : 18 __ __ CLC
09e8 : a5 1b __ LDA ACCU + 0 
09ea : 79 d7 0b ADC $0bd7,y ; (Enemy + 0)
09ed : 85 1b __ STA ACCU + 0 
09ef : 85 1f __ STA ADDR + 0 
09f1 : a5 1c __ LDA ACCU + 1 
09f3 : 69 04 __ ADC #$04
09f5 : 85 1c __ STA ACCU + 1 
09f7 : 18 __ __ CLC
09f8 : 69 d4 __ ADC #$d4
09fa : 85 20 __ STA ADDR + 1 
09fc : a9 58 __ LDA #$58
09fe : a0 00 __ LDY #$00
0a00 : 91 1b __ STA (ACCU + 0),y 
0a02 : a9 08 __ LDA #$08
0a04 : 91 1f __ STA (ADDR + 0),y 
.s19:
0a06 : e8 __ __ INX
0a07 : e0 0a __ CPX #$0a
0a09 : 90 ae __ BCC $09b9 ; (render_enemies.l1006 + 0)
.s1001:
0a0b : 60 __ __ RTS
--------------------------------------------------------------------
control_player_ship:
.s0:
0a0c : a9 00 __ LDA #$00
0a0e : 20 a2 0a JSR $0aa2 ; (joy_poll.s0 + 0)
0a11 : ad f7 0b LDA $0bf7 ; (joyx + 0)
0a14 : 85 1d __ STA ACCU + 2 
0a16 : 85 1e __ STA ACCU + 3 
0a18 : d0 06 __ BNE $0a20 ; (control_player_ship.s1 + 0)
.s4:
0a1a : ad f5 0b LDA $0bf5 ; (joyy + 0)
0a1d : d0 01 __ BNE $0a20 ; (control_player_ship.s1 + 0)
0a1f : 60 __ __ RTS
.s1:
0a20 : ad d5 0b LDA $0bd5 ; (Player + 0)
0a23 : 85 43 __ STA T2 + 0 
0a25 : 85 44 __ STA T3 + 0 
0a27 : ad d6 0b LDA $0bd6 ; (Player + 1)
0a2a : 85 45 __ STA T4 + 0 
0a2c : 85 46 __ STA T5 + 0 
0a2e : 0a __ __ ASL
0a2f : 85 1b __ STA ACCU + 0 
0a31 : a9 00 __ LDA #$00
0a33 : 2a __ __ ROL
0a34 : 06 1b __ ASL ACCU + 0 
0a36 : 2a __ __ ROL
0a37 : aa __ __ TAX
0a38 : a5 1b __ LDA ACCU + 0 
0a3a : 65 45 __ ADC T4 + 0 
0a3c : 85 1b __ STA ACCU + 0 
0a3e : 8a __ __ TXA
0a3f : 69 00 __ ADC #$00
0a41 : 06 1b __ ASL ACCU + 0 
0a43 : 2a __ __ ROL
0a44 : 06 1b __ ASL ACCU + 0 
0a46 : 2a __ __ ROL
0a47 : 06 1b __ ASL ACCU + 0 
0a49 : 2a __ __ ROL
0a4a : aa __ __ TAX
0a4b : 18 __ __ CLC
0a4c : a5 1b __ LDA ACCU + 0 
0a4e : 65 43 __ ADC T2 + 0 
0a50 : 85 1b __ STA ACCU + 0 
0a52 : 85 1f __ STA ADDR + 0 
0a54 : 8a __ __ TXA
0a55 : 69 04 __ ADC #$04
0a57 : 85 1c __ STA ACCU + 1 
0a59 : 18 __ __ CLC
0a5a : 69 d4 __ ADC #$d4
0a5c : 85 20 __ STA ADDR + 1 
0a5e : a9 20 __ LDA #$20
0a60 : a0 00 __ LDY #$00
0a62 : 91 1b __ STA (ACCU + 0),y 
0a64 : 98 __ __ TYA
0a65 : 91 1f __ STA (ADDR + 0),y 
0a67 : a5 43 __ LDA T2 + 0 
0a69 : f0 04 __ BEQ $0a6f ; (control_player_ship.s6 + 0)
.s8:
0a6b : a5 1d __ LDA ACCU + 2 
0a6d : 30 0c __ BMI $0a7b ; (control_player_ship.s5 + 0)
.s6:
0a6f : a5 43 __ LDA T2 + 0 
0a71 : c9 27 __ CMP #$27
0a73 : b0 0e __ BCS $0a83 ; (control_player_ship.s7 + 0)
.s12:
0a75 : a5 1d __ LDA ACCU + 2 
0a77 : 30 0a __ BMI $0a83 ; (control_player_ship.s7 + 0)
.s1007:
0a79 : f0 08 __ BEQ $0a83 ; (control_player_ship.s7 + 0)
.s5:
0a7b : 18 __ __ CLC
0a7c : a5 44 __ LDA T3 + 0 
0a7e : 65 1e __ ADC ACCU + 3 
0a80 : 8d d5 0b STA $0bd5 ; (Player + 0)
.s7:
0a83 : a5 45 __ LDA T4 + 0 
0a85 : c9 04 __ CMP #$04
0a87 : 90 07 __ BCC $0a90 ; (control_player_ship.s14 + 0)
.s16:
0a89 : ad f5 0b LDA $0bf5 ; (joyy + 0)
0a8c : 30 0d __ BMI $0a9b ; (control_player_ship.s28 + 0)
.s1010:
0a8e : a5 45 __ LDA T4 + 0 
.s14:
0a90 : c9 18 __ CMP #$18
0a92 : b0 0d __ BCS $0aa1 ; (control_player_ship.s1001 + 0)
.s20:
0a94 : ad f5 0b LDA $0bf5 ; (joyy + 0)
0a97 : 30 08 __ BMI $0aa1 ; (control_player_ship.s1001 + 0)
.s1002:
0a99 : f0 06 __ BEQ $0aa1 ; (control_player_ship.s1001 + 0)
.s28:
0a9b : 18 __ __ CLC
0a9c : 65 46 __ ADC T5 + 0 
0a9e : 8d d6 0b STA $0bd6 ; (Player + 1)
.s1001:
0aa1 : 60 __ __ RTS
--------------------------------------------------------------------
joy_poll:
.s0:
0aa2 : aa __ __ TAX
0aa3 : bd 00 dc LDA $dc00,x 
0aa6 : a8 __ __ TAY
0aa7 : 29 10 __ AND #$10
0aa9 : f0 04 __ BEQ $0aaf ; (joy_poll.s1005 + 0)
.s1006:
0aab : a9 00 __ LDA #$00
0aad : f0 02 __ BEQ $0ab1 ; (joy_poll.s1007 + 0)
.s1005:
0aaf : a9 01 __ LDA #$01
.s1007:
0ab1 : 9d f9 0b STA $0bf9,x ; (joyb + 0)
0ab4 : 98 __ __ TYA
0ab5 : 4a __ __ LSR
0ab6 : b0 1d __ BCS $0ad5 ; (joy_poll.s2 + 0)
.s1:
0ab8 : a9 ff __ LDA #$ff
.s15:
0aba : 9d f5 0b STA $0bf5,x ; (joyy + 0)
0abd : 98 __ __ TYA
0abe : 29 04 __ AND #$04
0ac0 : d0 06 __ BNE $0ac8 ; (joy_poll.s8 + 0)
.s7:
0ac2 : a9 ff __ LDA #$ff
.s1001:
0ac4 : 9d f7 0b STA $0bf7,x ; (joyx + 0)
0ac7 : 60 __ __ RTS
.s8:
0ac8 : 98 __ __ TYA
0ac9 : 29 08 __ AND #$08
0acb : f0 04 __ BEQ $0ad1 ; (joy_poll.s1011 + 0)
.s1012:
0acd : a9 00 __ LDA #$00
0acf : f0 f3 __ BEQ $0ac4 ; (joy_poll.s1001 + 0)
.s1011:
0ad1 : a9 01 __ LDA #$01
0ad3 : d0 ef __ BNE $0ac4 ; (joy_poll.s1001 + 0)
.s2:
0ad5 : 98 __ __ TYA
0ad6 : 29 02 __ AND #$02
0ad8 : f0 04 __ BEQ $0ade ; (joy_poll.s1008 + 0)
.s1009:
0ada : a9 00 __ LDA #$00
0adc : f0 dc __ BEQ $0aba ; (joy_poll.s15 + 0)
.s1008:
0ade : a9 01 __ LDA #$01
0ae0 : d0 d8 __ BNE $0aba ; (joy_poll.s15 + 0)
--------------------------------------------------------------------
joyy:
0bf5 : __ __ __ BSS	2
--------------------------------------------------------------------
joyx:
0bf7 : __ __ __ BSS	2
--------------------------------------------------------------------
joyb:
0bf9 : __ __ __ BSS	2
--------------------------------------------------------------------
render_player_ship:
.s0:
0ae2 : ad d6 0b LDA $0bd6 ; (Player + 1)
0ae5 : 0a __ __ ASL
0ae6 : 85 1b __ STA ACCU + 0 
0ae8 : a9 00 __ LDA #$00
0aea : 2a __ __ ROL
0aeb : 06 1b __ ASL ACCU + 0 
0aed : 2a __ __ ROL
0aee : aa __ __ TAX
0aef : a5 1b __ LDA ACCU + 0 
0af1 : 6d d6 0b ADC $0bd6 ; (Player + 1)
0af4 : 85 1b __ STA ACCU + 0 
0af6 : 8a __ __ TXA
0af7 : 69 00 __ ADC #$00
0af9 : 06 1b __ ASL ACCU + 0 
0afb : 2a __ __ ROL
0afc : 06 1b __ ASL ACCU + 0 
0afe : 2a __ __ ROL
0aff : 06 1b __ ASL ACCU + 0 
0b01 : 2a __ __ ROL
0b02 : aa __ __ TAX
0b03 : 18 __ __ CLC
0b04 : a5 1b __ LDA ACCU + 0 
0b06 : 6d d5 0b ADC $0bd5 ; (Player + 0)
0b09 : 85 1b __ STA ACCU + 0 
0b0b : 85 1f __ STA ADDR + 0 
0b0d : 8a __ __ TXA
0b0e : 69 04 __ ADC #$04
0b10 : 85 1c __ STA ACCU + 1 
0b12 : 18 __ __ CLC
0b13 : 69 d4 __ ADC #$d4
0b15 : 85 20 __ STA ADDR + 1 
0b17 : a9 51 __ LDA #$51
0b19 : a0 00 __ LDY #$00
0b1b : 91 1b __ STA (ACCU + 0),y 
0b1d : a9 03 __ LDA #$03
0b1f : 91 1f __ STA (ADDR + 0),y 
.s1001:
0b21 : 60 __ __ RTS
--------------------------------------------------------------------
wait_frames:
.s0:
0b22 : a5 0e __ LDA P1 ; (frames + 1)
0b24 : 30 1c __ BMI $0b42 ; (wait_frames.s1001 + 0)
.s1005:
0b26 : 05 0d __ ORA P0 ; (frames + 0)
0b28 : f0 18 __ BEQ $0b42 ; (wait_frames.s1001 + 0)
.s13:
0b2a : a0 00 __ LDY #$00
0b2c : a6 0e __ LDX P1 ; (frames + 1)
.l6:
0b2e : ad 11 d0 LDA $d011 
0b31 : 30 fb __ BMI $0b2e ; (wait_frames.l6 + 0)
.l9:
0b33 : ad 11 d0 LDA $d011 
0b36 : 10 fb __ BPL $0b33 ; (wait_frames.l9 + 0)
.s3:
0b38 : c8 __ __ INY
0b39 : 8a __ __ TXA
0b3a : 30 06 __ BMI $0b42 ; (wait_frames.s1001 + 0)
.s1004:
0b3c : d0 f0 __ BNE $0b2e ; (wait_frames.l6 + 0)
.s1002:
0b3e : c4 0d __ CPY P0 ; (frames + 0)
0b40 : 90 ec __ BCC $0b2e ; (wait_frames.l6 + 0)
.s1001:
0b42 : 60 __ __ RTS
--------------------------------------------------------------------
divmod:
0b43 : a5 1c __ LDA ACCU + 1 
0b45 : d0 31 __ BNE $0b78 ; (divmod + 53)
0b47 : a5 04 __ LDA WORK + 1 
0b49 : d0 1e __ BNE $0b69 ; (divmod + 38)
0b4b : 85 06 __ STA WORK + 3 
0b4d : a2 04 __ LDX #$04
0b4f : 06 1b __ ASL ACCU + 0 
0b51 : 2a __ __ ROL
0b52 : c5 03 __ CMP WORK + 0 
0b54 : 90 02 __ BCC $0b58 ; (divmod + 21)
0b56 : e5 03 __ SBC WORK + 0 
0b58 : 26 1b __ ROL ACCU + 0 
0b5a : 2a __ __ ROL
0b5b : c5 03 __ CMP WORK + 0 
0b5d : 90 02 __ BCC $0b61 ; (divmod + 30)
0b5f : e5 03 __ SBC WORK + 0 
0b61 : 26 1b __ ROL ACCU + 0 
0b63 : ca __ __ DEX
0b64 : d0 eb __ BNE $0b51 ; (divmod + 14)
0b66 : 85 05 __ STA WORK + 2 
0b68 : 60 __ __ RTS
0b69 : a5 1b __ LDA ACCU + 0 
0b6b : 85 05 __ STA WORK + 2 
0b6d : a5 1c __ LDA ACCU + 1 
0b6f : 85 06 __ STA WORK + 3 
0b71 : a9 00 __ LDA #$00
0b73 : 85 1b __ STA ACCU + 0 
0b75 : 85 1c __ STA ACCU + 1 
0b77 : 60 __ __ RTS
0b78 : a5 04 __ LDA WORK + 1 
0b7a : d0 1f __ BNE $0b9b ; (divmod + 88)
0b7c : a5 03 __ LDA WORK + 0 
0b7e : 30 1b __ BMI $0b9b ; (divmod + 88)
0b80 : a9 00 __ LDA #$00
0b82 : 85 06 __ STA WORK + 3 
0b84 : a2 10 __ LDX #$10
0b86 : 06 1b __ ASL ACCU + 0 
0b88 : 26 1c __ ROL ACCU + 1 
0b8a : 2a __ __ ROL
0b8b : c5 03 __ CMP WORK + 0 
0b8d : 90 02 __ BCC $0b91 ; (divmod + 78)
0b8f : e5 03 __ SBC WORK + 0 
0b91 : 26 1b __ ROL ACCU + 0 
0b93 : 26 1c __ ROL ACCU + 1 
0b95 : ca __ __ DEX
0b96 : d0 f2 __ BNE $0b8a ; (divmod + 71)
0b98 : 85 05 __ STA WORK + 2 
0b9a : 60 __ __ RTS
0b9b : a9 00 __ LDA #$00
0b9d : 85 05 __ STA WORK + 2 
0b9f : 85 06 __ STA WORK + 3 
0ba1 : 84 02 __ STY $02 
0ba3 : a0 10 __ LDY #$10
0ba5 : 18 __ __ CLC
0ba6 : 26 1b __ ROL ACCU + 0 
0ba8 : 26 1c __ ROL ACCU + 1 
0baa : 26 05 __ ROL WORK + 2 
0bac : 26 06 __ ROL WORK + 3 
0bae : 38 __ __ SEC
0baf : a5 05 __ LDA WORK + 2 
0bb1 : e5 03 __ SBC WORK + 0 
0bb3 : aa __ __ TAX
0bb4 : a5 06 __ LDA WORK + 3 
0bb6 : e5 04 __ SBC WORK + 1 
0bb8 : 90 04 __ BCC $0bbe ; (divmod + 123)
0bba : 86 05 __ STX WORK + 2 
0bbc : 85 06 __ STA WORK + 3 
0bbe : 88 __ __ DEY
0bbf : d0 e5 __ BNE $0ba6 ; (divmod + 99)
0bc1 : 26 1b __ ROL ACCU + 0 
0bc3 : 26 1c __ ROL ACCU + 1 
0bc5 : a4 02 __ LDY $02 
0bc7 : 60 __ __ RTS
--------------------------------------------------------------------
__multab3L:
0bc8 : __ __ __ BYT 00 03 06 09 0c 0f 12 15 18 1b                   : ..........
