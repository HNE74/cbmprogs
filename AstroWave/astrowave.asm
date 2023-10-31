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
080e : 8e 4d 0c STX $0c4d ; (spentry + 0)
0811 : a9 50 __ LDA #$50
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
0830 : a9 77 __ LDA #$77
0832 : e9 50 __ SBC #$50
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
0c4d : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
main:
.s0:
0880 : 20 b8 08 JSR $08b8 ; (init_player.s0 + 0)
0883 : 20 c3 08 JSR $08c3 ; (init_enemies.s0 + 0)
0886 : 20 d8 08 JSR $08d8 ; (init_game_screen.s0 + 0)
0889 : a9 00 __ LDA #$00
088b : 8d 70 0c STA $0c70 ; (game + 0)
088e : 85 0e __ STA P1 
0890 : a9 04 __ LDA #$04
0892 : 85 0d __ STA P0 
.l1002:
0894 : 20 ea 08 JSR $08ea ; (spawn_enemy.s0 + 0)
0897 : 20 4f 09 JSR $094f ; (move_enemies.s0 + 0)
089a : 20 0a 0a JSR $0a0a ; (render_enemies.s0 + 0)
089d : 20 5f 0a JSR $0a5f ; (check_player_enemy_collision.s0 + 0)
08a0 : 20 87 0a JSR $0a87 ; (control_player_ship.s0 + 0)
08a3 : 20 5d 0b JSR $0b5d ; (render_player_ship.s0 + 0)
08a6 : 20 5f 0a JSR $0a5f ; (check_player_enemy_collision.s0 + 0)
08a9 : 20 9d 0b JSR $0b9d ; (wait_frames.s0 + 0)
08ac : ad 70 0c LDA $0c70 ; (game + 0)
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
08ba : 8d 50 0c STA $0c50 ; (Player + 0)
08bd : a9 0c __ LDA #$0c
08bf : 8d 51 0c STA $0c51 ; (Player + 1)
.s1001:
08c2 : 60 __ __ RTS
--------------------------------------------------------------------
Player:
0c50 : __ __ __ BSS	2
--------------------------------------------------------------------
init_enemies:
.s0:
08c3 : a0 0a __ LDY #$0a
08c5 : a2 00 __ LDX #$00
08c7 : 8a __ __ TXA
.l1004:
08c8 : 9d 52 0c STA $0c52,x ; (Enemy + 0)
08cb : 9d 53 0c STA $0c53,x ; (Enemy + 1)
08ce : 9d 54 0c STA $0c54,x ; (Enemy + 2)
08d1 : e8 __ __ INX
08d2 : e8 __ __ INX
08d3 : e8 __ __ INX
08d4 : 88 __ __ DEY
08d5 : d0 f1 __ BNE $08c8 ; (init_enemies.l1004 + 0)
.s1001:
08d7 : 60 __ __ RTS
--------------------------------------------------------------------
Enemy:
0c52 : __ __ __ BSS	30
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
0c70 : __ __ __ BSS	1
--------------------------------------------------------------------
spawn_enemy:
.s0:
08ea : 20 28 09 JSR $0928 ; (rand.s0 + 0)
08ed : 46 1b __ LSR ACCU + 0 
08ef : b0 0f __ BCS $0900 ; (spawn_enemy.s1001 + 0)
.s3:
08f1 : a0 00 __ LDY #$00
.l6:
08f3 : be 43 0c LDX $0c43,y ; (__multab3L + 0)
08f6 : bd 54 0c LDA $0c54,x ; (Enemy + 2)
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
0905 : 9d 52 0c STA $0c52,x ; (Enemy + 0)
0908 : 20 28 09 JSR $0928 ; (rand.s0 + 0)
090b : a9 01 __ LDA #$01
090d : a6 43 __ LDX T0 + 0 
090f : 9d 54 0c STA $0c54,x ; (Enemy + 2)
0912 : a9 16 __ LDA #$16
0914 : 85 03 __ STA WORK + 0 
0916 : a9 00 __ LDA #$00
0918 : 85 04 __ STA WORK + 1 
091a : 20 be 0b JSR $0bbe ; (divmod + 0)
091d : 18 __ __ CLC
091e : a5 05 __ LDA WORK + 2 
0920 : 69 03 __ ADC #$03
0922 : a6 43 __ LDX T0 + 0 
0924 : 9d 53 0c STA $0c53,x ; (Enemy + 1)
0927 : 60 __ __ RTS
--------------------------------------------------------------------
rand:
.s0:
0928 : ad 4f 0c LDA $0c4f ; (seed + 1)
092b : 4a __ __ LSR
092c : ad 4e 0c LDA $0c4e ; (seed + 0)
092f : 6a __ __ ROR
0930 : aa __ __ TAX
0931 : a9 00 __ LDA #$00
0933 : 6a __ __ ROR
0934 : 4d 4e 0c EOR $0c4e ; (seed + 0)
0937 : 85 1b __ STA ACCU + 0 
0939 : 8a __ __ TXA
093a : 4d 4f 0c EOR $0c4f ; (seed + 1)
093d : 85 1c __ STA ACCU + 1 
093f : 4a __ __ LSR
0940 : 45 1b __ EOR ACCU + 0 
0942 : 8d 4e 0c STA $0c4e ; (seed + 0)
0945 : 85 1b __ STA ACCU + 0 
0947 : 45 1c __ EOR ACCU + 1 
0949 : 8d 4f 0c STA $0c4f ; (seed + 1)
094c : 85 1c __ STA ACCU + 1 
.s1001:
094e : 60 __ __ RTS
--------------------------------------------------------------------
seed:
0c4e : __ __ __ BYT 00 7a                                           : .z
--------------------------------------------------------------------
move_enemies:
.s0:
094f : a2 00 __ LDX #$00
.l2:
0951 : 86 43 __ STX T0 + 0 
0953 : bc 43 0c LDY $0c43,x ; (__multab3L + 0)
0956 : b9 54 0c LDA $0c54,y ; (Enemy + 2)
0959 : c9 01 __ CMP #$01
095b : d0 4b __ BNE $09a8 ; (move_enemies.s29 + 0)
.s5:
095d : 84 44 __ STY T1 + 0 
095f : b9 53 0c LDA $0c53,y ; (Enemy + 1)
0962 : 0a __ __ ASL
0963 : 85 1b __ STA ACCU + 0 
0965 : a9 00 __ LDA #$00
0967 : 2a __ __ ROL
0968 : 06 1b __ ASL ACCU + 0 
096a : 2a __ __ ROL
096b : aa __ __ TAX
096c : a5 1b __ LDA ACCU + 0 
096e : 79 53 0c ADC $0c53,y ; (Enemy + 1)
0971 : 85 1b __ STA ACCU + 0 
0973 : 8a __ __ TXA
0974 : 69 00 __ ADC #$00
0976 : 06 1b __ ASL ACCU + 0 
0978 : 2a __ __ ROL
0979 : 06 1b __ ASL ACCU + 0 
097b : 2a __ __ ROL
097c : 06 1b __ ASL ACCU + 0 
097e : 2a __ __ ROL
097f : aa __ __ TAX
0980 : b9 52 0c LDA $0c52,y ; (Enemy + 0)
0983 : 85 45 __ STA T3 + 0 
0985 : 18 __ __ CLC
0986 : 65 1b __ ADC ACCU + 0 
0988 : 85 1b __ STA ACCU + 0 
098a : 85 1f __ STA ADDR + 0 
098c : 8a __ __ TXA
098d : 69 04 __ ADC #$04
098f : 85 1c __ STA ACCU + 1 
0991 : 18 __ __ CLC
0992 : 69 d4 __ ADC #$d4
0994 : 85 20 __ STA ADDR + 1 
0996 : a9 20 __ LDA #$20
0998 : a0 00 __ LDY #$00
099a : 91 1b __ STA (ACCU + 0),y 
099c : 98 __ __ TYA
099d : 91 1f __ STA (ADDR + 0),y 
099f : a5 45 __ LDA T3 + 0 
09a1 : d0 0d __ BNE $09b0 ; (move_enemies.s8 + 0)
.s9:
09a3 : a6 44 __ LDX T1 + 0 
09a5 : 9d 54 0c STA $0c54,x ; (Enemy + 2)
.s29:
09a8 : a6 43 __ LDX T0 + 0 
09aa : e8 __ __ INX
09ab : e0 0a __ CPX #$0a
09ad : 90 a2 __ BCC $0951 ; (move_enemies.l2 + 0)
.s1001:
09af : 60 __ __ RTS
.s8:
09b0 : c6 45 __ DEC T3 + 0 
09b2 : a5 45 __ LDA T3 + 0 
09b4 : a6 44 __ LDX T1 + 0 
09b6 : 9d 52 0c STA $0c52,x ; (Enemy + 0)
09b9 : 20 28 09 JSR $0928 ; (rand.s0 + 0)
09bc : a6 44 __ LDX T1 + 0 
09be : bd 53 0c LDA $0c53,x ; (Enemy + 1)
09c1 : 85 46 __ STA T4 + 0 
09c3 : a9 03 __ LDA #$03
09c5 : 85 03 __ STA WORK + 0 
09c7 : a9 00 __ LDA #$00
09c9 : 85 04 __ STA WORK + 1 
09cb : 20 be 0b JSR $0bbe ; (divmod + 0)
09ce : 38 __ __ SEC
09cf : a5 05 __ LDA WORK + 2 
09d1 : e9 01 __ SBC #$01
09d3 : aa __ __ TAX
09d4 : a5 06 __ LDA WORK + 3 
09d6 : e9 00 __ SBC #$00
09d8 : a8 __ __ TAY
09d9 : 8a __ __ TXA
09da : 18 __ __ CLC
09db : 65 46 __ ADC T4 + 0 
09dd : 85 1b __ STA ACCU + 0 
09df : 90 01 __ BCC $09e2 ; (move_enemies.s1011 + 0)
.s1010:
09e1 : c8 __ __ INY
.s1011:
09e2 : 0a __ __ ASL
09e3 : 0a __ __ ASL
09e4 : 18 __ __ CLC
09e5 : 65 1b __ ADC ACCU + 0 
09e7 : 0a __ __ ASL
09e8 : 0a __ __ ASL
09e9 : 0a __ __ ASL
09ea : 18 __ __ CLC
09eb : 65 45 __ ADC T3 + 0 
09ed : aa __ __ TAX
09ee : bd 00 04 LDA $0400,x 
09f1 : c9 58 __ CMP #$58
09f3 : f0 b3 __ BEQ $09a8 ; (move_enemies.s29 + 0)
.s15:
09f5 : 98 __ __ TYA
09f6 : d0 b0 __ BNE $09a8 ; (move_enemies.s29 + 0)
.s1005:
09f8 : a5 1b __ LDA ACCU + 0 
09fa : c9 03 __ CMP #$03
09fc : 90 aa __ BCC $09a8 ; (move_enemies.s29 + 0)
.s1004:
09fe : c9 19 __ CMP #$19
0a00 : b0 a6 __ BCS $09a8 ; (move_enemies.s29 + 0)
.s11:
0a02 : a6 44 __ LDX T1 + 0 
0a04 : 9d 53 0c STA $0c53,x ; (Enemy + 1)
0a07 : 4c a8 09 JMP $09a8 ; (move_enemies.s29 + 0)
--------------------------------------------------------------------
render_enemies:
.s0:
0a0a : a2 00 __ LDX #$00
.l1006:
0a0c : bc 43 0c LDY $0c43,x ; (__multab3L + 0)
0a0f : b9 54 0c LDA $0c54,y ; (Enemy + 2)
0a12 : c9 01 __ CMP #$01
0a14 : d0 43 __ BNE $0a59 ; (render_enemies.s19 + 0)
.s5:
0a16 : b9 53 0c LDA $0c53,y ; (Enemy + 1)
0a19 : 0a __ __ ASL
0a1a : 85 1b __ STA ACCU + 0 
0a1c : a9 00 __ LDA #$00
0a1e : 2a __ __ ROL
0a1f : 06 1b __ ASL ACCU + 0 
0a21 : 2a __ __ ROL
0a22 : 85 1c __ STA ACCU + 1 
0a24 : a5 1b __ LDA ACCU + 0 
0a26 : 79 53 0c ADC $0c53,y ; (Enemy + 1)
0a29 : 85 1b __ STA ACCU + 0 
0a2b : a5 1c __ LDA ACCU + 1 
0a2d : 69 00 __ ADC #$00
0a2f : 06 1b __ ASL ACCU + 0 
0a31 : 2a __ __ ROL
0a32 : 06 1b __ ASL ACCU + 0 
0a34 : 2a __ __ ROL
0a35 : 06 1b __ ASL ACCU + 0 
0a37 : 2a __ __ ROL
0a38 : 85 1c __ STA ACCU + 1 
0a3a : 18 __ __ CLC
0a3b : a5 1b __ LDA ACCU + 0 
0a3d : 79 52 0c ADC $0c52,y ; (Enemy + 0)
0a40 : 85 1b __ STA ACCU + 0 
0a42 : 85 1f __ STA ADDR + 0 
0a44 : a5 1c __ LDA ACCU + 1 
0a46 : 69 04 __ ADC #$04
0a48 : 85 1c __ STA ACCU + 1 
0a4a : 18 __ __ CLC
0a4b : 69 d4 __ ADC #$d4
0a4d : 85 20 __ STA ADDR + 1 
0a4f : a9 58 __ LDA #$58
0a51 : a0 00 __ LDY #$00
0a53 : 91 1b __ STA (ACCU + 0),y 
0a55 : a9 08 __ LDA #$08
0a57 : 91 1f __ STA (ADDR + 0),y 
.s19:
0a59 : e8 __ __ INX
0a5a : e0 0a __ CPX #$0a
0a5c : 90 ae __ BCC $0a0c ; (render_enemies.l1006 + 0)
.s1001:
0a5e : 60 __ __ RTS
--------------------------------------------------------------------
check_player_enemy_collision:
.s0:
0a5f : a0 00 __ LDY #$00
.l2:
0a61 : be 43 0c LDX $0c43,y ; (__multab3L + 0)
0a64 : bd 54 0c LDA $0c54,x ; (Enemy + 2)
0a67 : c9 01 __ CMP #$01
0a69 : d0 10 __ BNE $0a7b ; (check_player_enemy_collision.s3 + 0)
.s5:
0a6b : bd 52 0c LDA $0c52,x ; (Enemy + 0)
0a6e : cd 50 0c CMP $0c50 ; (Player + 0)
0a71 : d0 08 __ BNE $0a7b ; (check_player_enemy_collision.s3 + 0)
.s11:
0a73 : bd 53 0c LDA $0c53,x ; (Enemy + 1)
0a76 : cd 51 0c CMP $0c51 ; (Player + 1)
0a79 : f0 06 __ BEQ $0a81 ; (check_player_enemy_collision.s8 + 0)
.s3:
0a7b : c8 __ __ INY
0a7c : c0 0a __ CPY #$0a
0a7e : 90 e1 __ BCC $0a61 ; (check_player_enemy_collision.l2 + 0)
.s1001:
0a80 : 60 __ __ RTS
.s8:
0a81 : a9 01 __ LDA #$01
0a83 : 8d 70 0c STA $0c70 ; (game + 0)
0a86 : 60 __ __ RTS
--------------------------------------------------------------------
control_player_ship:
.s0:
0a87 : a9 00 __ LDA #$00
0a89 : 20 1d 0b JSR $0b1d ; (joy_poll.s0 + 0)
0a8c : ad 73 0c LDA $0c73 ; (joyx + 0)
0a8f : 85 1d __ STA ACCU + 2 
0a91 : 85 1e __ STA ACCU + 3 
0a93 : d0 06 __ BNE $0a9b ; (control_player_ship.s1 + 0)
.s4:
0a95 : ad 71 0c LDA $0c71 ; (joyy + 0)
0a98 : d0 01 __ BNE $0a9b ; (control_player_ship.s1 + 0)
0a9a : 60 __ __ RTS
.s1:
0a9b : ad 50 0c LDA $0c50 ; (Player + 0)
0a9e : 85 43 __ STA T2 + 0 
0aa0 : 85 44 __ STA T3 + 0 
0aa2 : ad 51 0c LDA $0c51 ; (Player + 1)
0aa5 : 85 45 __ STA T4 + 0 
0aa7 : 85 46 __ STA T5 + 0 
0aa9 : 0a __ __ ASL
0aaa : 85 1b __ STA ACCU + 0 
0aac : a9 00 __ LDA #$00
0aae : 2a __ __ ROL
0aaf : 06 1b __ ASL ACCU + 0 
0ab1 : 2a __ __ ROL
0ab2 : aa __ __ TAX
0ab3 : a5 1b __ LDA ACCU + 0 
0ab5 : 65 45 __ ADC T4 + 0 
0ab7 : 85 1b __ STA ACCU + 0 
0ab9 : 8a __ __ TXA
0aba : 69 00 __ ADC #$00
0abc : 06 1b __ ASL ACCU + 0 
0abe : 2a __ __ ROL
0abf : 06 1b __ ASL ACCU + 0 
0ac1 : 2a __ __ ROL
0ac2 : 06 1b __ ASL ACCU + 0 
0ac4 : 2a __ __ ROL
0ac5 : aa __ __ TAX
0ac6 : 18 __ __ CLC
0ac7 : a5 1b __ LDA ACCU + 0 
0ac9 : 65 43 __ ADC T2 + 0 
0acb : 85 1b __ STA ACCU + 0 
0acd : 85 1f __ STA ADDR + 0 
0acf : 8a __ __ TXA
0ad0 : 69 04 __ ADC #$04
0ad2 : 85 1c __ STA ACCU + 1 
0ad4 : 18 __ __ CLC
0ad5 : 69 d4 __ ADC #$d4
0ad7 : 85 20 __ STA ADDR + 1 
0ad9 : a9 20 __ LDA #$20
0adb : a0 00 __ LDY #$00
0add : 91 1b __ STA (ACCU + 0),y 
0adf : 98 __ __ TYA
0ae0 : 91 1f __ STA (ADDR + 0),y 
0ae2 : a5 43 __ LDA T2 + 0 
0ae4 : f0 04 __ BEQ $0aea ; (control_player_ship.s6 + 0)
.s8:
0ae6 : a5 1d __ LDA ACCU + 2 
0ae8 : 30 0c __ BMI $0af6 ; (control_player_ship.s5 + 0)
.s6:
0aea : a5 43 __ LDA T2 + 0 
0aec : c9 27 __ CMP #$27
0aee : b0 0e __ BCS $0afe ; (control_player_ship.s7 + 0)
.s12:
0af0 : a5 1d __ LDA ACCU + 2 
0af2 : 30 0a __ BMI $0afe ; (control_player_ship.s7 + 0)
.s1007:
0af4 : f0 08 __ BEQ $0afe ; (control_player_ship.s7 + 0)
.s5:
0af6 : 18 __ __ CLC
0af7 : a5 44 __ LDA T3 + 0 
0af9 : 65 1e __ ADC ACCU + 3 
0afb : 8d 50 0c STA $0c50 ; (Player + 0)
.s7:
0afe : a5 45 __ LDA T4 + 0 
0b00 : c9 04 __ CMP #$04
0b02 : 90 07 __ BCC $0b0b ; (control_player_ship.s14 + 0)
.s16:
0b04 : ad 71 0c LDA $0c71 ; (joyy + 0)
0b07 : 30 0d __ BMI $0b16 ; (control_player_ship.s28 + 0)
.s1010:
0b09 : a5 45 __ LDA T4 + 0 
.s14:
0b0b : c9 18 __ CMP #$18
0b0d : b0 0d __ BCS $0b1c ; (control_player_ship.s1001 + 0)
.s20:
0b0f : ad 71 0c LDA $0c71 ; (joyy + 0)
0b12 : 30 08 __ BMI $0b1c ; (control_player_ship.s1001 + 0)
.s1002:
0b14 : f0 06 __ BEQ $0b1c ; (control_player_ship.s1001 + 0)
.s28:
0b16 : 18 __ __ CLC
0b17 : 65 46 __ ADC T5 + 0 
0b19 : 8d 51 0c STA $0c51 ; (Player + 1)
.s1001:
0b1c : 60 __ __ RTS
--------------------------------------------------------------------
joy_poll:
.s0:
0b1d : aa __ __ TAX
0b1e : bd 00 dc LDA $dc00,x 
0b21 : a8 __ __ TAY
0b22 : 29 10 __ AND #$10
0b24 : f0 04 __ BEQ $0b2a ; (joy_poll.s1005 + 0)
.s1006:
0b26 : a9 00 __ LDA #$00
0b28 : f0 02 __ BEQ $0b2c ; (joy_poll.s1007 + 0)
.s1005:
0b2a : a9 01 __ LDA #$01
.s1007:
0b2c : 9d 75 0c STA $0c75,x ; (joyb + 0)
0b2f : 98 __ __ TYA
0b30 : 4a __ __ LSR
0b31 : b0 1d __ BCS $0b50 ; (joy_poll.s2 + 0)
.s1:
0b33 : a9 ff __ LDA #$ff
.s15:
0b35 : 9d 71 0c STA $0c71,x ; (joyy + 0)
0b38 : 98 __ __ TYA
0b39 : 29 04 __ AND #$04
0b3b : d0 06 __ BNE $0b43 ; (joy_poll.s8 + 0)
.s7:
0b3d : a9 ff __ LDA #$ff
.s1001:
0b3f : 9d 73 0c STA $0c73,x ; (joyx + 0)
0b42 : 60 __ __ RTS
.s8:
0b43 : 98 __ __ TYA
0b44 : 29 08 __ AND #$08
0b46 : f0 04 __ BEQ $0b4c ; (joy_poll.s1011 + 0)
.s1012:
0b48 : a9 00 __ LDA #$00
0b4a : f0 f3 __ BEQ $0b3f ; (joy_poll.s1001 + 0)
.s1011:
0b4c : a9 01 __ LDA #$01
0b4e : d0 ef __ BNE $0b3f ; (joy_poll.s1001 + 0)
.s2:
0b50 : 98 __ __ TYA
0b51 : 29 02 __ AND #$02
0b53 : f0 04 __ BEQ $0b59 ; (joy_poll.s1008 + 0)
.s1009:
0b55 : a9 00 __ LDA #$00
0b57 : f0 dc __ BEQ $0b35 ; (joy_poll.s15 + 0)
.s1008:
0b59 : a9 01 __ LDA #$01
0b5b : d0 d8 __ BNE $0b35 ; (joy_poll.s15 + 0)
--------------------------------------------------------------------
joyy:
0c71 : __ __ __ BSS	2
--------------------------------------------------------------------
joyx:
0c73 : __ __ __ BSS	2
--------------------------------------------------------------------
joyb:
0c75 : __ __ __ BSS	2
--------------------------------------------------------------------
render_player_ship:
.s0:
0b5d : ad 51 0c LDA $0c51 ; (Player + 1)
0b60 : 0a __ __ ASL
0b61 : 85 1b __ STA ACCU + 0 
0b63 : a9 00 __ LDA #$00
0b65 : 2a __ __ ROL
0b66 : 06 1b __ ASL ACCU + 0 
0b68 : 2a __ __ ROL
0b69 : aa __ __ TAX
0b6a : a5 1b __ LDA ACCU + 0 
0b6c : 6d 51 0c ADC $0c51 ; (Player + 1)
0b6f : 85 1b __ STA ACCU + 0 
0b71 : 8a __ __ TXA
0b72 : 69 00 __ ADC #$00
0b74 : 06 1b __ ASL ACCU + 0 
0b76 : 2a __ __ ROL
0b77 : 06 1b __ ASL ACCU + 0 
0b79 : 2a __ __ ROL
0b7a : 06 1b __ ASL ACCU + 0 
0b7c : 2a __ __ ROL
0b7d : aa __ __ TAX
0b7e : 18 __ __ CLC
0b7f : a5 1b __ LDA ACCU + 0 
0b81 : 6d 50 0c ADC $0c50 ; (Player + 0)
0b84 : 85 1b __ STA ACCU + 0 
0b86 : 85 1f __ STA ADDR + 0 
0b88 : 8a __ __ TXA
0b89 : 69 04 __ ADC #$04
0b8b : 85 1c __ STA ACCU + 1 
0b8d : 18 __ __ CLC
0b8e : 69 d4 __ ADC #$d4
0b90 : 85 20 __ STA ADDR + 1 
0b92 : a9 51 __ LDA #$51
0b94 : a0 00 __ LDY #$00
0b96 : 91 1b __ STA (ACCU + 0),y 
0b98 : a9 03 __ LDA #$03
0b9a : 91 1f __ STA (ADDR + 0),y 
.s1001:
0b9c : 60 __ __ RTS
--------------------------------------------------------------------
wait_frames:
.s0:
0b9d : a5 0e __ LDA P1 ; (frames + 1)
0b9f : 30 1c __ BMI $0bbd ; (wait_frames.s1001 + 0)
.s1005:
0ba1 : 05 0d __ ORA P0 ; (frames + 0)
0ba3 : f0 18 __ BEQ $0bbd ; (wait_frames.s1001 + 0)
.s13:
0ba5 : a0 00 __ LDY #$00
0ba7 : a6 0e __ LDX P1 ; (frames + 1)
.l6:
0ba9 : ad 11 d0 LDA $d011 
0bac : 30 fb __ BMI $0ba9 ; (wait_frames.l6 + 0)
.l9:
0bae : ad 11 d0 LDA $d011 
0bb1 : 10 fb __ BPL $0bae ; (wait_frames.l9 + 0)
.s3:
0bb3 : c8 __ __ INY
0bb4 : 8a __ __ TXA
0bb5 : 30 06 __ BMI $0bbd ; (wait_frames.s1001 + 0)
.s1004:
0bb7 : d0 f0 __ BNE $0ba9 ; (wait_frames.l6 + 0)
.s1002:
0bb9 : c4 0d __ CPY P0 ; (frames + 0)
0bbb : 90 ec __ BCC $0ba9 ; (wait_frames.l6 + 0)
.s1001:
0bbd : 60 __ __ RTS
--------------------------------------------------------------------
divmod:
0bbe : a5 1c __ LDA ACCU + 1 
0bc0 : d0 31 __ BNE $0bf3 ; (divmod + 53)
0bc2 : a5 04 __ LDA WORK + 1 
0bc4 : d0 1e __ BNE $0be4 ; (divmod + 38)
0bc6 : 85 06 __ STA WORK + 3 
0bc8 : a2 04 __ LDX #$04
0bca : 06 1b __ ASL ACCU + 0 
0bcc : 2a __ __ ROL
0bcd : c5 03 __ CMP WORK + 0 
0bcf : 90 02 __ BCC $0bd3 ; (divmod + 21)
0bd1 : e5 03 __ SBC WORK + 0 
0bd3 : 26 1b __ ROL ACCU + 0 
0bd5 : 2a __ __ ROL
0bd6 : c5 03 __ CMP WORK + 0 
0bd8 : 90 02 __ BCC $0bdc ; (divmod + 30)
0bda : e5 03 __ SBC WORK + 0 
0bdc : 26 1b __ ROL ACCU + 0 
0bde : ca __ __ DEX
0bdf : d0 eb __ BNE $0bcc ; (divmod + 14)
0be1 : 85 05 __ STA WORK + 2 
0be3 : 60 __ __ RTS
0be4 : a5 1b __ LDA ACCU + 0 
0be6 : 85 05 __ STA WORK + 2 
0be8 : a5 1c __ LDA ACCU + 1 
0bea : 85 06 __ STA WORK + 3 
0bec : a9 00 __ LDA #$00
0bee : 85 1b __ STA ACCU + 0 
0bf0 : 85 1c __ STA ACCU + 1 
0bf2 : 60 __ __ RTS
0bf3 : a5 04 __ LDA WORK + 1 
0bf5 : d0 1f __ BNE $0c16 ; (divmod + 88)
0bf7 : a5 03 __ LDA WORK + 0 
0bf9 : 30 1b __ BMI $0c16 ; (divmod + 88)
0bfb : a9 00 __ LDA #$00
0bfd : 85 06 __ STA WORK + 3 
0bff : a2 10 __ LDX #$10
0c01 : 06 1b __ ASL ACCU + 0 
0c03 : 26 1c __ ROL ACCU + 1 
0c05 : 2a __ __ ROL
0c06 : c5 03 __ CMP WORK + 0 
0c08 : 90 02 __ BCC $0c0c ; (divmod + 78)
0c0a : e5 03 __ SBC WORK + 0 
0c0c : 26 1b __ ROL ACCU + 0 
0c0e : 26 1c __ ROL ACCU + 1 
0c10 : ca __ __ DEX
0c11 : d0 f2 __ BNE $0c05 ; (divmod + 71)
0c13 : 85 05 __ STA WORK + 2 
0c15 : 60 __ __ RTS
0c16 : a9 00 __ LDA #$00
0c18 : 85 05 __ STA WORK + 2 
0c1a : 85 06 __ STA WORK + 3 
0c1c : 84 02 __ STY $02 
0c1e : a0 10 __ LDY #$10
0c20 : 18 __ __ CLC
0c21 : 26 1b __ ROL ACCU + 0 
0c23 : 26 1c __ ROL ACCU + 1 
0c25 : 26 05 __ ROL WORK + 2 
0c27 : 26 06 __ ROL WORK + 3 
0c29 : 38 __ __ SEC
0c2a : a5 05 __ LDA WORK + 2 
0c2c : e5 03 __ SBC WORK + 0 
0c2e : aa __ __ TAX
0c2f : a5 06 __ LDA WORK + 3 
0c31 : e5 04 __ SBC WORK + 1 
0c33 : 90 04 __ BCC $0c39 ; (divmod + 123)
0c35 : 86 05 __ STX WORK + 2 
0c37 : 85 06 __ STA WORK + 3 
0c39 : 88 __ __ DEY
0c3a : d0 e5 __ BNE $0c21 ; (divmod + 99)
0c3c : 26 1b __ ROL ACCU + 0 
0c3e : 26 1c __ ROL ACCU + 1 
0c40 : a4 02 __ LDY $02 
0c42 : 60 __ __ RTS
--------------------------------------------------------------------
__multab3L:
0c43 : __ __ __ BYT 00 03 06 09 0c 0f 12 15 18 1b                   : ..........
