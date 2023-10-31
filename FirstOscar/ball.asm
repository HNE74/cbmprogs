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
080e : 8e 45 0b STX $0b45 ; (spentry + 0)
0811 : a9 48 __ LDA #$48
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
0830 : a9 e8 __ LDA #$e8
0832 : e9 48 __ SBC #$48
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
0b45 : __ __ __ BYT 00                                              : .
--------------------------------------------------------------------
main:
.s0:
0880 : 20 9a 08 JSR $089a ; (init_balls.s0 + 0)
0883 : 20 44 09 JSR $0944 ; (clrscr.s0 + 0)
0886 : 20 48 09 JSR $0948 ; (ballbounce.s0 + 0)
.l40:
0889 : ad 11 d0 LDA $d011 
088c : 30 fb __ BMI $0889 ; (main.l40 + 0)
.l6:
088e : ad 11 d0 LDA $d011 
0891 : 10 fb __ BPL $088e ; (main.l6 + 0)
.s2:
0893 : a9 00 __ LDA #$00
0895 : 85 1b __ STA ACCU + 0 
0897 : 85 1c __ STA ACCU + 1 
.s1001:
0899 : 60 __ __ RTS
--------------------------------------------------------------------
init_balls:
.s0:
089a : a9 00 __ LDA #$00
089c : 85 43 __ STA T0 + 0 
.l2:
089e : 20 1d 09 JSR $091d ; (rand.s0 + 0)
08a1 : a9 1e __ LDA #$1e
08a3 : 85 03 __ STA WORK + 0 
08a5 : a9 00 __ LDA #$00
08a7 : 85 04 __ STA WORK + 1 
08a9 : 20 97 0a JSR $0a97 ; (divmod + 0)
08ac : a5 43 __ LDA T0 + 0 
08ae : 0a __ __ ASL
08af : 85 44 __ STA T2 + 0 
08b1 : aa __ __ TAX
08b2 : 18 __ __ CLC
08b3 : a5 05 __ LDA WORK + 2 
08b5 : 69 05 __ ADC #$05
08b7 : 9d 48 0b STA $0b48,x ; (ballXp + 0)
08ba : a9 00 __ LDA #$00
08bc : 9d 49 0b STA $0b49,x ; (ballXp + 1)
08bf : 20 1d 09 JSR $091d ; (rand.s0 + 0)
08c2 : a9 13 __ LDA #$13
08c4 : 85 03 __ STA WORK + 0 
08c6 : a9 00 __ LDA #$00
08c8 : 85 04 __ STA WORK + 1 
08ca : 20 97 0a JSR $0a97 ; (divmod + 0)
08cd : 18 __ __ CLC
08ce : a5 05 __ LDA WORK + 2 
08d0 : 69 05 __ ADC #$05
08d2 : a6 44 __ LDX T2 + 0 
08d4 : 9d 70 0b STA $0b70,x ; (ballYp + 0)
08d7 : a9 00 __ LDA #$00
08d9 : 9d 71 0b STA $0b71,x ; (ballYp + 1)
08dc : 20 1d 09 JSR $091d ; (rand.s0 + 0)
08df : 46 1b __ LSR ACCU + 0 
08e1 : 90 0b __ BCC $08ee ; (init_balls.s5 + 0)
.s6:
08e3 : a9 01 __ LDA #$01
08e5 : a4 44 __ LDY T2 + 0 
08e7 : 99 98 0b STA $0b98,y ; (ballXd + 0)
08ea : a9 00 __ LDA #$00
08ec : f0 07 __ BEQ $08f5 ; (init_balls.s22 + 0)
.s5:
08ee : a9 ff __ LDA #$ff
08f0 : a4 44 __ LDY T2 + 0 
08f2 : 99 98 0b STA $0b98,y ; (ballXd + 0)
.s22:
08f5 : 99 99 0b STA $0b99,y ; (ballXd + 1)
08f8 : 20 1d 09 JSR $091d ; (rand.s0 + 0)
08fb : 46 1b __ LSR ACCU + 0 
08fd : 90 0b __ BCC $090a ; (init_balls.s8 + 0)
.s9:
08ff : a9 01 __ LDA #$01
0901 : a4 44 __ LDY T2 + 0 
0903 : 99 c0 0b STA $0bc0,y ; (ballYd + 0)
0906 : a9 00 __ LDA #$00
0908 : f0 07 __ BEQ $0911 ; (init_balls.s23 + 0)
.s8:
090a : a9 ff __ LDA #$ff
090c : a4 44 __ LDY T2 + 0 
090e : 99 c0 0b STA $0bc0,y ; (ballYd + 0)
.s23:
0911 : 99 c1 0b STA $0bc1,y ; (ballYd + 1)
0914 : e6 43 __ INC T0 + 0 
0916 : a5 43 __ LDA T0 + 0 
0918 : c9 14 __ CMP #$14
091a : 90 82 __ BCC $089e ; (init_balls.l2 + 0)
.s1001:
091c : 60 __ __ RTS
--------------------------------------------------------------------
rand:
.s0:
091d : ad 47 0b LDA $0b47 ; (seed + 1)
0920 : 4a __ __ LSR
0921 : ad 46 0b LDA $0b46 ; (seed + 0)
0924 : 6a __ __ ROR
0925 : aa __ __ TAX
0926 : a9 00 __ LDA #$00
0928 : 6a __ __ ROR
0929 : 4d 46 0b EOR $0b46 ; (seed + 0)
092c : 85 1b __ STA ACCU + 0 
092e : 8a __ __ TXA
092f : 4d 47 0b EOR $0b47 ; (seed + 1)
0932 : 85 1c __ STA ACCU + 1 
0934 : 4a __ __ LSR
0935 : 45 1b __ EOR ACCU + 0 
0937 : 8d 46 0b STA $0b46 ; (seed + 0)
093a : 85 1b __ STA ACCU + 0 
093c : 45 1c __ EOR ACCU + 1 
093e : 8d 47 0b STA $0b47 ; (seed + 1)
0941 : 85 1c __ STA ACCU + 1 
.s1001:
0943 : 60 __ __ RTS
--------------------------------------------------------------------
seed:
0b46 : __ __ __ BYT 00 7a                                           : .z
--------------------------------------------------------------------
ballXp:
0b48 : __ __ __ BSS	40
--------------------------------------------------------------------
ballYp:
0b70 : __ __ __ BSS	40
--------------------------------------------------------------------
ballXd:
0b98 : __ __ __ BSS	40
--------------------------------------------------------------------
ballYd:
0bc0 : __ __ __ BSS	40
--------------------------------------------------------------------
clrscr:
.s0:
0944 : 20 81 ff JSR $ff81 
.s1001:
0947 : 60 __ __ RTS
--------------------------------------------------------------------
ballbounce:
.s0:
0948 : a9 00 __ LDA #$00
094a : 85 43 __ STA T0 + 0 
094c : 85 44 __ STA T0 + 1 
.l2:
094e : a5 43 __ LDA T0 + 0 
0950 : 85 1b __ STA ACCU + 0 
0952 : a5 44 __ LDA T0 + 1 
0954 : 85 1c __ STA ACCU + 1 
0956 : a9 50 __ LDA #$50
0958 : 85 03 __ STA WORK + 0 
095a : a9 00 __ LDA #$00
095c : 85 04 __ STA WORK + 1 
095e : 20 1c 0b JSR $0b1c ; (mods16 + 0)
0961 : e6 43 __ INC T0 + 0 
0963 : d0 02 __ BNE $0967 ; (ballbounce.s1006 + 0)
.s1005:
0965 : e6 44 __ INC T0 + 1 
.s1006:
0967 : a5 05 __ LDA WORK + 2 
0969 : 05 06 __ ORA WORK + 3 
096b : d0 e1 __ BNE $094e ; (ballbounce.l2 + 0)
.s6:
096d : a9 00 __ LDA #$00
096f : 85 45 __ STA T1 + 0 
.l9:
0971 : 0a __ __ ASL
0972 : 85 46 __ STA T3 + 0 
0974 : a8 __ __ TAY
0975 : b9 70 0b LDA $0b70,y ; (ballYp + 0)
0978 : 85 4a __ STA T7 + 0 
097a : 18 __ __ CLC
097b : 79 c0 0b ADC $0bc0,y ; (ballYd + 0)
097e : 85 4c __ STA T8 + 0 
0980 : b9 71 0b LDA $0b71,y ; (ballYp + 1)
0983 : 85 4b __ STA T7 + 1 
0985 : 79 c1 0b ADC $0bc1,y ; (ballYd + 1)
0988 : 30 08 __ BMI $0992 ; (ballbounce.s12 + 0)
.s15:
098a : d0 06 __ BNE $0992 ; (ballbounce.s12 + 0)
.s1004:
098c : a9 18 __ LDA #$18
098e : c5 4c __ CMP T8 + 0 
0990 : b0 11 __ BCS $09a3 ; (ballbounce.s14 + 0)
.s12:
0992 : 38 __ __ SEC
0993 : a9 00 __ LDA #$00
0995 : f9 c0 0b SBC $0bc0,y ; (ballYd + 0)
0998 : 99 c0 0b STA $0bc0,y ; (ballYd + 0)
099b : a9 00 __ LDA #$00
099d : f9 c1 0b SBC $0bc1,y ; (ballYd + 1)
09a0 : 99 c1 0b STA $0bc1,y ; (ballYd + 1)
.s14:
09a3 : 84 4c __ STY T8 + 0 
09a5 : a5 4a __ LDA T7 + 0 
09a7 : 0a __ __ ASL
09a8 : 85 1b __ STA ACCU + 0 
09aa : a5 4b __ LDA T7 + 1 
09ac : 2a __ __ ROL
09ad : 06 1b __ ASL ACCU + 0 
09af : 2a __ __ ROL
09b0 : aa __ __ TAX
09b1 : 18 __ __ CLC
09b2 : a5 1b __ LDA ACCU + 0 
09b4 : 65 4a __ ADC T7 + 0 
09b6 : 85 1b __ STA ACCU + 0 
09b8 : 8a __ __ TXA
09b9 : 65 4b __ ADC T7 + 1 
09bb : 06 1b __ ASL ACCU + 0 
09bd : 2a __ __ ROL
09be : 06 1b __ ASL ACCU + 0 
09c0 : 2a __ __ ROL
09c1 : 06 1b __ ASL ACCU + 0 
09c3 : 2a __ __ ROL
09c4 : 85 1c __ STA ACCU + 1 
09c6 : b9 48 0b LDA $0b48,y ; (ballXp + 0)
09c9 : 85 4d __ STA T9 + 0 
09cb : 18 __ __ CLC
09cc : 65 1b __ ADC ACCU + 0 
09ce : 85 1b __ STA ACCU + 0 
09d0 : b9 49 0b LDA $0b49,y ; (ballXp + 1)
09d3 : 85 4e __ STA T9 + 1 
09d5 : 65 1c __ ADC ACCU + 1 
09d7 : 18 __ __ CLC
09d8 : 69 04 __ ADC #$04
09da : 85 1c __ STA ACCU + 1 
09dc : a9 20 __ LDA #$20
09de : a0 00 __ LDY #$00
09e0 : 91 1b __ STA (ACCU + 0),y 
09e2 : a4 46 __ LDY T3 + 0 
09e4 : b9 c0 0b LDA $0bc0,y ; (ballYd + 0)
09e7 : 18 __ __ CLC
09e8 : 65 4a __ ADC T7 + 0 
09ea : 99 70 0b STA $0b70,y ; (ballYp + 0)
09ed : 85 48 __ STA T4 + 0 
09ef : b9 c1 0b LDA $0bc1,y ; (ballYd + 1)
09f2 : 65 4b __ ADC T7 + 1 
09f4 : 99 71 0b STA $0b71,y ; (ballYp + 1)
09f7 : 85 49 __ STA T4 + 1 
09f9 : b9 98 0b LDA $0b98,y ; (ballXd + 0)
09fc : 18 __ __ CLC
09fd : 65 4d __ ADC T9 + 0 
09ff : 85 1b __ STA ACCU + 0 
0a01 : b9 99 0b LDA $0b99,y ; (ballXd + 1)
0a04 : 65 4e __ ADC T9 + 1 
0a06 : 30 08 __ BMI $0a10 ; (ballbounce.s16 + 0)
.s19:
0a08 : d0 06 __ BNE $0a10 ; (ballbounce.s16 + 0)
.s1003:
0a0a : a9 27 __ LDA #$27
0a0c : c5 1b __ CMP ACCU + 0 
0a0e : b0 11 __ BCS $0a21 ; (ballbounce.s18 + 0)
.s16:
0a10 : 38 __ __ SEC
0a11 : a9 00 __ LDA #$00
0a13 : f9 98 0b SBC $0b98,y ; (ballXd + 0)
0a16 : 99 98 0b STA $0b98,y ; (ballXd + 0)
0a19 : a9 00 __ LDA #$00
0a1b : f9 99 0b SBC $0b99,y ; (ballXd + 1)
0a1e : 99 99 0b STA $0b99,y ; (ballXd + 1)
.s18:
0a21 : b9 98 0b LDA $0b98,y ; (ballXd + 0)
0a24 : 18 __ __ CLC
0a25 : 65 4d __ ADC T9 + 0 
0a27 : 85 46 __ STA T3 + 0 
0a29 : a6 4c __ LDX T8 + 0 
0a2b : 9d 48 0b STA $0b48,x ; (ballXp + 0)
0a2e : b9 99 0b LDA $0b99,y ; (ballXd + 1)
0a31 : 65 4e __ ADC T9 + 1 
0a33 : 85 47 __ STA T3 + 1 
0a35 : 9d 49 0b STA $0b49,x ; (ballXp + 1)
0a38 : a5 48 __ LDA T4 + 0 
0a3a : 0a __ __ ASL
0a3b : 85 1b __ STA ACCU + 0 
0a3d : a5 49 __ LDA T4 + 1 
0a3f : 2a __ __ ROL
0a40 : 06 1b __ ASL ACCU + 0 
0a42 : 2a __ __ ROL
0a43 : aa __ __ TAX
0a44 : 18 __ __ CLC
0a45 : a5 1b __ LDA ACCU + 0 
0a47 : 65 48 __ ADC T4 + 0 
0a49 : 85 48 __ STA T4 + 0 
0a4b : 8a __ __ TXA
0a4c : 65 49 __ ADC T4 + 1 
0a4e : 06 48 __ ASL T4 + 0 
0a50 : 2a __ __ ROL
0a51 : 06 48 __ ASL T4 + 0 
0a53 : 2a __ __ ROL
0a54 : 06 48 __ ASL T4 + 0 
0a56 : 2a __ __ ROL
0a57 : aa __ __ TAX
0a58 : 18 __ __ CLC
0a59 : a5 48 __ LDA T4 + 0 
0a5b : 65 46 __ ADC T3 + 0 
0a5d : 85 46 __ STA T3 + 0 
0a5f : 8a __ __ TXA
0a60 : 65 47 __ ADC T3 + 1 
0a62 : 18 __ __ CLC
0a63 : 69 04 __ ADC #$04
0a65 : 85 47 __ STA T3 + 1 
0a67 : a9 51 __ LDA #$51
0a69 : a0 00 __ LDY #$00
0a6b : 91 46 __ STA (T3 + 0),y 
0a6d : e6 45 __ INC T1 + 0 
0a6f : a5 45 __ LDA T1 + 0 
0a71 : c9 14 __ CMP #$14
0a73 : b0 03 __ BCS $0a78 ; (ballbounce.s18 + 87)
0a75 : 4c 71 09 JMP $0971 ; (ballbounce.l9 + 0)
0a78 : 4c 4e 09 JMP $094e ; (ballbounce.l2 + 0)
--------------------------------------------------------------------
negaccu:
0a7b : 38 __ __ SEC
0a7c : a9 00 __ LDA #$00
0a7e : e5 1b __ SBC ACCU + 0 
0a80 : 85 1b __ STA ACCU + 0 
0a82 : a9 00 __ LDA #$00
0a84 : e5 1c __ SBC ACCU + 1 
0a86 : 85 1c __ STA ACCU + 1 
0a88 : 60 __ __ RTS
--------------------------------------------------------------------
negtmp:
0a89 : 38 __ __ SEC
0a8a : a9 00 __ LDA #$00
0a8c : e5 03 __ SBC WORK + 0 
0a8e : 85 03 __ STA WORK + 0 
0a90 : a9 00 __ LDA #$00
0a92 : e5 04 __ SBC WORK + 1 
0a94 : 85 04 __ STA WORK + 1 
0a96 : 60 __ __ RTS
--------------------------------------------------------------------
divmod:
0a97 : a5 1c __ LDA ACCU + 1 
0a99 : d0 31 __ BNE $0acc ; (divmod + 53)
0a9b : a5 04 __ LDA WORK + 1 
0a9d : d0 1e __ BNE $0abd ; (divmod + 38)
0a9f : 85 06 __ STA WORK + 3 
0aa1 : a2 04 __ LDX #$04
0aa3 : 06 1b __ ASL ACCU + 0 
0aa5 : 2a __ __ ROL
0aa6 : c5 03 __ CMP WORK + 0 
0aa8 : 90 02 __ BCC $0aac ; (divmod + 21)
0aaa : e5 03 __ SBC WORK + 0 
0aac : 26 1b __ ROL ACCU + 0 
0aae : 2a __ __ ROL
0aaf : c5 03 __ CMP WORK + 0 
0ab1 : 90 02 __ BCC $0ab5 ; (divmod + 30)
0ab3 : e5 03 __ SBC WORK + 0 
0ab5 : 26 1b __ ROL ACCU + 0 
0ab7 : ca __ __ DEX
0ab8 : d0 eb __ BNE $0aa5 ; (divmod + 14)
0aba : 85 05 __ STA WORK + 2 
0abc : 60 __ __ RTS
0abd : a5 1b __ LDA ACCU + 0 
0abf : 85 05 __ STA WORK + 2 
0ac1 : a5 1c __ LDA ACCU + 1 
0ac3 : 85 06 __ STA WORK + 3 
0ac5 : a9 00 __ LDA #$00
0ac7 : 85 1b __ STA ACCU + 0 
0ac9 : 85 1c __ STA ACCU + 1 
0acb : 60 __ __ RTS
0acc : a5 04 __ LDA WORK + 1 
0ace : d0 1f __ BNE $0aef ; (divmod + 88)
0ad0 : a5 03 __ LDA WORK + 0 
0ad2 : 30 1b __ BMI $0aef ; (divmod + 88)
0ad4 : a9 00 __ LDA #$00
0ad6 : 85 06 __ STA WORK + 3 
0ad8 : a2 10 __ LDX #$10
0ada : 06 1b __ ASL ACCU + 0 
0adc : 26 1c __ ROL ACCU + 1 
0ade : 2a __ __ ROL
0adf : c5 03 __ CMP WORK + 0 
0ae1 : 90 02 __ BCC $0ae5 ; (divmod + 78)
0ae3 : e5 03 __ SBC WORK + 0 
0ae5 : 26 1b __ ROL ACCU + 0 
0ae7 : 26 1c __ ROL ACCU + 1 
0ae9 : ca __ __ DEX
0aea : d0 f2 __ BNE $0ade ; (divmod + 71)
0aec : 85 05 __ STA WORK + 2 
0aee : 60 __ __ RTS
0aef : a9 00 __ LDA #$00
0af1 : 85 05 __ STA WORK + 2 
0af3 : 85 06 __ STA WORK + 3 
0af5 : 84 02 __ STY $02 
0af7 : a0 10 __ LDY #$10
0af9 : 18 __ __ CLC
0afa : 26 1b __ ROL ACCU + 0 
0afc : 26 1c __ ROL ACCU + 1 
0afe : 26 05 __ ROL WORK + 2 
0b00 : 26 06 __ ROL WORK + 3 
0b02 : 38 __ __ SEC
0b03 : a5 05 __ LDA WORK + 2 
0b05 : e5 03 __ SBC WORK + 0 
0b07 : aa __ __ TAX
0b08 : a5 06 __ LDA WORK + 3 
0b0a : e5 04 __ SBC WORK + 1 
0b0c : 90 04 __ BCC $0b12 ; (divmod + 123)
0b0e : 86 05 __ STX WORK + 2 
0b10 : 85 06 __ STA WORK + 3 
0b12 : 88 __ __ DEY
0b13 : d0 e5 __ BNE $0afa ; (divmod + 99)
0b15 : 26 1b __ ROL ACCU + 0 
0b17 : 26 1c __ ROL ACCU + 1 
0b19 : a4 02 __ LDY $02 
0b1b : 60 __ __ RTS
--------------------------------------------------------------------
mods16:
0b1c : 24 1c __ BIT ACCU + 1 
0b1e : 10 0d __ BPL $0b2d ; (mods16 + 17)
0b20 : 20 7b 0a JSR $0a7b ; (negaccu + 0)
0b23 : 24 04 __ BIT WORK + 1 
0b25 : 10 0d __ BPL $0b34 ; (mods16 + 24)
0b27 : 20 89 0a JSR $0a89 ; (negtmp + 0)
0b2a : 4c 97 0a JMP $0a97 ; (divmod + 0)
0b2d : 24 04 __ BIT WORK + 1 
0b2f : 10 f9 __ BPL $0b2a ; (mods16 + 14)
0b31 : 20 89 0a JSR $0a89 ; (negtmp + 0)
0b34 : 20 97 0a JSR $0a97 ; (divmod + 0)
0b37 : 38 __ __ SEC
0b38 : a9 00 __ LDA #$00
0b3a : e5 05 __ SBC WORK + 2 
0b3c : 85 05 __ STA WORK + 2 
0b3e : a9 00 __ LDA #$00
0b40 : e5 06 __ SBC WORK + 3 
0b42 : 85 06 __ STA WORK + 3 
0b44 : 60 __ __ RTS
