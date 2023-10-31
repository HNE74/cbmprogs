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
080e : 8e 25 0a STX $0a25 ; (spentry + 0)
0811 : a9 2a __ LDA #$2a
0813 : 85 19 __ STA IP + 0 
0815 : a9 0a __ LDA #$0a
0817 : 85 1a __ STA IP + 1 
0819 : 38 __ __ SEC
081a : a9 0a __ LDA #$0a
081c : e9 0a __ SBC #$0a
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
0830 : a9 30 __ LDA #$30
0832 : e9 2a __ SBC #$2a
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
0a25 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
main:
.s0:
0880 : 20 97 08 JSR $0897 ; (init_game_screen.s0 + 0)
.l3:
0883 : 20 a9 08 JSR $08a9 ; (control_player_ship.s0 + 0)
0886 : 20 b7 09 JSR $09b7 ; (render_player_ship.s0 + 0)
0889 : a9 05 __ LDA #$05
088b : 85 0d __ STA P0 
088d : a9 00 __ LDA #$00
088f : 85 0e __ STA P1 
0891 : 20 fe 09 JSR $09fe ; (wait_frames.s0 + 0)
0894 : 4c 83 08 JMP $0883 ; (main.l3 + 0)
--------------------------------------------------------------------
init_game_screen:
.s0:
0897 : 20 a5 08 JSR $08a5 ; (clrscr.s0 + 0)
089a : a9 00 __ LDA #$00
089c : 8d 21 d0 STA $d021 
089f : a9 0b __ LDA #$0b
08a1 : 8d 20 d0 STA $d020 
.s1001:
08a4 : 60 __ __ RTS
--------------------------------------------------------------------
clrscr:
.s0:
08a5 : 20 81 ff JSR $ff81 
.s1001:
08a8 : 60 __ __ RTS
--------------------------------------------------------------------
control_player_ship:
.s0:
08a9 : a9 00 __ LDA #$00
08ab : 20 77 09 JSR $0977 ; (joy_poll.s0 + 0)
08ae : ad 2c 0a LDA $0a2c ; (joyx + 0)
08b1 : 85 1d __ STA ACCU + 2 
08b3 : 85 43 __ STA T1 + 0 
08b5 : 29 80 __ AND #$80
08b7 : 10 02 __ BPL $08bb ; (control_player_ship.s0 + 18)
08b9 : a9 ff __ LDA #$ff
08bb : 85 44 __ STA T1 + 1 
08bd : a5 1d __ LDA ACCU + 2 
08bf : d0 06 __ BNE $08c7 ; (control_player_ship.s1 + 0)
.s4:
08c1 : ad 2a 0a LDA $0a2a ; (joyy + 0)
08c4 : d0 01 __ BNE $08c7 ; (control_player_ship.s1 + 0)
08c6 : 60 __ __ RTS
.s1:
08c7 : ad 28 0a LDA $0a28 ; (Player + 2)
08ca : 85 45 __ STA T3 + 0 
08cc : 0a __ __ ASL
08cd : 85 1b __ STA ACCU + 0 
08cf : ad 29 0a LDA $0a29 ; (Player + 3)
08d2 : 85 46 __ STA T3 + 1 
08d4 : 2a __ __ ROL
08d5 : 06 1b __ ASL ACCU + 0 
08d7 : 2a __ __ ROL
08d8 : aa __ __ TAX
08d9 : 18 __ __ CLC
08da : a5 1b __ LDA ACCU + 0 
08dc : 65 45 __ ADC T3 + 0 
08de : 85 1b __ STA ACCU + 0 
08e0 : 8a __ __ TXA
08e1 : 65 46 __ ADC T3 + 1 
08e3 : 06 1b __ ASL ACCU + 0 
08e5 : 2a __ __ ROL
08e6 : 06 1b __ ASL ACCU + 0 
08e8 : 2a __ __ ROL
08e9 : 06 1b __ ASL ACCU + 0 
08eb : 2a __ __ ROL
08ec : 85 1c __ STA ACCU + 1 
08ee : ad 26 0a LDA $0a26 ; (Player + 0)
08f1 : 85 1e __ STA ACCU + 3 
08f3 : 18 __ __ CLC
08f4 : 65 1b __ ADC ACCU + 0 
08f6 : 85 1b __ STA ACCU + 0 
08f8 : ad 27 0a LDA $0a27 ; (Player + 1)
08fb : aa __ __ TAX
08fc : 65 1c __ ADC ACCU + 1 
08fe : 18 __ __ CLC
08ff : 69 04 __ ADC #$04
0901 : 85 1c __ STA ACCU + 1 
0903 : a9 20 __ LDA #$20
0905 : a0 00 __ LDY #$00
0907 : 91 1b __ STA (ACCU + 0),y 
0909 : 18 __ __ CLC
090a : a5 1c __ LDA ACCU + 1 
090c : 69 d4 __ ADC #$d4
090e : 85 1c __ STA ACCU + 1 
0910 : 98 __ __ TYA
0911 : 91 1b __ STA (ACCU + 0),y 
0913 : 8a __ __ TXA
0914 : 30 11 __ BMI $0927 ; (control_player_ship.s12 + 0)
.s1009:
0916 : 05 1e __ ORA ACCU + 3 
0918 : f0 04 __ BEQ $091e ; (control_player_ship.s6 + 0)
.s8:
091a : a5 1d __ LDA ACCU + 2 
091c : 30 0f __ BMI $092d ; (control_player_ship.s5 + 0)
.s6:
091e : 8a __ __ TXA
091f : d0 1a __ BNE $093b ; (control_player_ship.s7 + 0)
.s1007:
0921 : a5 1e __ LDA ACCU + 3 
0923 : c9 27 __ CMP #$27
0925 : b0 14 __ BCS $093b ; (control_player_ship.s7 + 0)
.s12:
0927 : a5 1d __ LDA ACCU + 2 
0929 : 30 10 __ BMI $093b ; (control_player_ship.s7 + 0)
.s1006:
092b : f0 0e __ BEQ $093b ; (control_player_ship.s7 + 0)
.s5:
092d : 18 __ __ CLC
092e : a5 1e __ LDA ACCU + 3 
0930 : 65 43 __ ADC T1 + 0 
0932 : 8d 26 0a STA $0a26 ; (Player + 0)
0935 : 8a __ __ TXA
0936 : 65 44 __ ADC T1 + 1 
0938 : 8d 27 0a STA $0a27 ; (Player + 1)
.s7:
093b : a5 46 __ LDA T3 + 1 
093d : 30 1e __ BMI $095d ; (control_player_ship.s20 + 0)
.s1005:
093f : 05 45 __ ORA T3 + 0 
0941 : f0 10 __ BEQ $0953 ; (control_player_ship.s14 + 0)
.s16:
0943 : ad 2a 0a LDA $0a2a ; (joyy + 0)
0946 : 10 0b __ BPL $0953 ; (control_player_ship.s14 + 0)
.s13:
0948 : 85 43 __ STA T1 + 0 
094a : 0a __ __ ASL
094b : 98 __ __ TYA
094c : 69 ff __ ADC #$ff
094e : 49 ff __ EOR #$ff
0950 : 4c 67 09 JMP $0967 ; (control_player_ship.s28 + 0)
.s14:
0953 : a5 46 __ LDA T3 + 1 
0955 : d0 1f __ BNE $0976 ; (control_player_ship.s1001 + 0)
.s1003:
0957 : a5 45 __ LDA T3 + 0 
0959 : c9 18 __ CMP #$18
095b : b0 19 __ BCS $0976 ; (control_player_ship.s1001 + 0)
.s20:
095d : ad 2a 0a LDA $0a2a ; (joyy + 0)
0960 : 30 14 __ BMI $0976 ; (control_player_ship.s1001 + 0)
.s1002:
0962 : f0 12 __ BEQ $0976 ; (control_player_ship.s1001 + 0)
.s17:
0964 : 85 43 __ STA T1 + 0 
0966 : 98 __ __ TYA
.s28:
0967 : aa __ __ TAX
0968 : 18 __ __ CLC
0969 : a5 43 __ LDA T1 + 0 
096b : 65 45 __ ADC T3 + 0 
096d : 8d 28 0a STA $0a28 ; (Player + 2)
0970 : 8a __ __ TXA
0971 : 65 46 __ ADC T3 + 1 
0973 : 8d 29 0a STA $0a29 ; (Player + 3)
.s1001:
0976 : 60 __ __ RTS
--------------------------------------------------------------------
joy_poll:
.s0:
0977 : aa __ __ TAX
0978 : bd 00 dc LDA $dc00,x 
097b : a8 __ __ TAY
097c : 29 10 __ AND #$10
097e : f0 04 __ BEQ $0984 ; (joy_poll.s1005 + 0)
.s1006:
0980 : a9 00 __ LDA #$00
0982 : f0 02 __ BEQ $0986 ; (joy_poll.s1007 + 0)
.s1005:
0984 : a9 01 __ LDA #$01
.s1007:
0986 : 9d 2e 0a STA $0a2e,x ; (joyb + 0)
0989 : 98 __ __ TYA
098a : 4a __ __ LSR
098b : b0 1d __ BCS $09aa ; (joy_poll.s2 + 0)
.s1:
098d : a9 ff __ LDA #$ff
.s15:
098f : 9d 2a 0a STA $0a2a,x ; (joyy + 0)
0992 : 98 __ __ TYA
0993 : 29 04 __ AND #$04
0995 : d0 06 __ BNE $099d ; (joy_poll.s8 + 0)
.s7:
0997 : a9 ff __ LDA #$ff
.s1001:
0999 : 9d 2c 0a STA $0a2c,x ; (joyx + 0)
099c : 60 __ __ RTS
.s8:
099d : 98 __ __ TYA
099e : 29 08 __ AND #$08
09a0 : f0 04 __ BEQ $09a6 ; (joy_poll.s1011 + 0)
.s1012:
09a2 : a9 00 __ LDA #$00
09a4 : f0 f3 __ BEQ $0999 ; (joy_poll.s1001 + 0)
.s1011:
09a6 : a9 01 __ LDA #$01
09a8 : d0 ef __ BNE $0999 ; (joy_poll.s1001 + 0)
.s2:
09aa : 98 __ __ TYA
09ab : 29 02 __ AND #$02
09ad : f0 04 __ BEQ $09b3 ; (joy_poll.s1008 + 0)
.s1009:
09af : a9 00 __ LDA #$00
09b1 : f0 dc __ BEQ $098f ; (joy_poll.s15 + 0)
.s1008:
09b3 : a9 01 __ LDA #$01
09b5 : d0 d8 __ BNE $098f ; (joy_poll.s15 + 0)
--------------------------------------------------------------------
joyy:
0a2a : __ __ __ BSS	2
--------------------------------------------------------------------
joyx:
0a2c : __ __ __ BSS	2
--------------------------------------------------------------------
joyb:
0a2e : __ __ __ BSS	2
--------------------------------------------------------------------
Player:
0a26 : __ __ __ BYT 05 00 0c 00                                     : ....
--------------------------------------------------------------------
render_player_ship:
.s0:
09b7 : ad 28 0a LDA $0a28 ; (Player + 2)
09ba : 0a __ __ ASL
09bb : 85 07 __ STA WORK + 4 
09bd : ad 29 0a LDA $0a29 ; (Player + 3)
09c0 : 2a __ __ ROL
09c1 : 06 07 __ ASL WORK + 4 
09c3 : 2a __ __ ROL
09c4 : aa __ __ TAX
09c5 : 18 __ __ CLC
09c6 : a5 07 __ LDA WORK + 4 
09c8 : 6d 28 0a ADC $0a28 ; (Player + 2)
09cb : 85 1b __ STA ACCU + 0 
09cd : 8a __ __ TXA
09ce : 6d 29 0a ADC $0a29 ; (Player + 3)
09d1 : 06 1b __ ASL ACCU + 0 
09d3 : 2a __ __ ROL
09d4 : 06 1b __ ASL ACCU + 0 
09d6 : 2a __ __ ROL
09d7 : 06 1b __ ASL ACCU + 0 
09d9 : 2a __ __ ROL
09da : aa __ __ TAX
09db : ad 26 0a LDA $0a26 ; (Player + 0)
09de : 18 __ __ CLC
09df : 65 1b __ ADC ACCU + 0 
09e1 : 85 1b __ STA ACCU + 0 
09e3 : 8a __ __ TXA
09e4 : 6d 27 0a ADC $0a27 ; (Player + 1)
09e7 : 18 __ __ CLC
09e8 : 69 04 __ ADC #$04
09ea : 85 1c __ STA ACCU + 1 
09ec : a9 51 __ LDA #$51
09ee : a0 00 __ LDY #$00
09f0 : 91 1b __ STA (ACCU + 0),y 
09f2 : 18 __ __ CLC
09f3 : a5 1c __ LDA ACCU + 1 
09f5 : 69 d4 __ ADC #$d4
09f7 : 85 1c __ STA ACCU + 1 
09f9 : a9 03 __ LDA #$03
09fb : 91 1b __ STA (ACCU + 0),y 
.s1001:
09fd : 60 __ __ RTS
--------------------------------------------------------------------
wait_frames:
.s0:
09fe : a5 0e __ LDA P1 ; (frames + 1)
0a00 : 30 22 __ BMI $0a24 ; (wait_frames.s1001 + 0)
.s1005:
0a02 : 05 0d __ ORA P0 ; (frames + 0)
0a04 : f0 1e __ BEQ $0a24 ; (wait_frames.s1001 + 0)
.s13:
0a06 : a2 00 __ LDX #$00
0a08 : a0 00 __ LDY #$00
.l6:
0a0a : ad 11 d0 LDA $d011 
0a0d : 30 fb __ BMI $0a0a ; (wait_frames.l6 + 0)
.l9:
0a0f : ad 11 d0 LDA $d011 
0a12 : 10 fb __ BPL $0a0f ; (wait_frames.l9 + 0)
.s3:
0a14 : a5 0e __ LDA P1 ; (frames + 1)
0a16 : 30 0c __ BMI $0a24 ; (wait_frames.s1001 + 0)
.s1004:
0a18 : c8 __ __ INY
0a19 : d0 01 __ BNE $0a1c ; (wait_frames.s1009 + 0)
.s1008:
0a1b : e8 __ __ INX
.s1009:
0a1c : e4 0e __ CPX P1 ; (frames + 1)
0a1e : d0 02 __ BNE $0a22 ; (wait_frames.s1003 + 0)
.s1002:
0a20 : c4 0d __ CPY P0 ; (frames + 0)
.s1003:
0a22 : 90 e6 __ BCC $0a0a ; (wait_frames.l6 + 0)
.s1001:
0a24 : 60 __ __ RTS
