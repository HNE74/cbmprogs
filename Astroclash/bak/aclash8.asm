*=$C000

; VARIABLES USED BY JOYSTK ROUTINE
OFSET           = $CF10
NEUTRAL         = 0
RIGHT           = 8
LEFT            = 4
FIRE            = 16
RIGHTFIRE       = 24
LEFTFIRE        = 20
XMIN            = 1
XMAX            = 38
YCST            = 23
MAXSHOTS        = 3
JSTICK          = $DC01

; VARIABLES USED BY PLOT ROUTINE
XPOS            = $CF11 ;X-POSITION ZEICHEN 
YPOS            = $CF12 ;Y-POSITION ZEICHEN
CHRCODE         = $CF15 ;ZEICHENCODE
CHRCOLOR        = $CF16 ;ZEICHENFARBE
SCREENZEROADR   = $FB   ;ZERO PAGE ZEICHEN
COLORZEROADR    = $FB   ;ZERO PAGE FARBEN

; VARIABLES USED BY PLAYER ROUTINE
XPLAYER         = $CF17
YPLAYER         = $CF18
OLDXPLAYER      = $CF19
OLDYPLAYER      = $CF1A
PLAYERCHR       = 81
PLAYERCLR       = 5
PLEXPCOLOR      = $CF1B

; VARIABELES USED FOR CHARACTER REDEFINITION
VICSCREENBLOCKNO        = 1
VICCHARSETBLOCKNO       = 7
VICBITMAPBLOCKNO        = 0
VICBANKNO               = 13
VICCHARSETADR           = $3000
CHARROMADR              = $D000
VICMEMCONTROL           = $D018
ZP_HELPADR1             = $FB
ZP_HELPADR2             = $FD
CHARPTR                 = $CF1C
CHARDEFPTR              = $CF1D
CHARBYTE                = $CF1E

; VARIABLES USED FOR SHOT CONTROL
TOPYSHOT        = 2
COLSHOT         = 1
CHRSHOT         = 93
SHOTPTR         = $CF1F
SHOTXCHK        = $CF20
SHOTYCHK        = $CF21
SHOTFLAG        = $CF22

;VARIABLES USED BY RND ROUTINE
TIMERLOW        = $DC04
TIMERHIGH       = $DC05
RASTER          = $D012
RNDRESULT       = $CF23

;VARIABELES USED FOR ALIEN CONTROL
YALMAX          = 24
XALMIN          = 0
XALMAX          = 39
YACMAX          = 5
YACMIN          = TOPYSHOT
XACMAX          = 39
XACMIN          = 0
ACPROB          = $CF24
ALIENPTR        = $CF25
ALXPOS          = $CF26
ALYPOS          = $CF27
ALMAXCNT        = $CF28
ALCNT           = $CF29
MAXALCNT        = 20
ALEXPLCNT       = $CF2A
ALMVWAIT        = 6
ALMVCNT         = $CF2B
ALCOLOR         = $CF2C

;VARIABLES USED FOR ALIEN SHOT CONTROL
YALSHOTMAX      = 12
ALSHOTMAXCNT    = 5
ALSHOTCNT       = $CF2D
ALSHOTPTR       = $CF2E
ALSHOTCHR       = 46
ALSHOTCOLOR     = 1
ALSHOTMVWCNT    = $CF2F
ALSHOTMVWAIT    = 3 

;VARIABLES USED FOR HEADER PLOT
BASECOL   = $D800
BASESCR   = $0400
SETCSR    = $FFF0
CHROUT    = $E716

;VARIABLES USED FOR SOUND GENERATION
SIGVOL     = $D418
ATDCY1     = $D405
SUREL1     = $D406
VCREG1     = $D404
FRELO1     = $D400
FREHI1     = $D401
TRELL1     = $D402
TRELH1     = $D403

ATDCY2     = $D40C
SUREL2     = $D40E
VCREG2     = $D40B
FRELO2     = $D407
FREHI2     = $D408
TRELL2     = $D409
TRELH2     = $D40A

; VARIABLES USED FOR GAME CONTROL
GAMESTATE  = $CF30
LVLCONT1   = $CF31
LVLCONT2   = $CF32
LVLCONT3   = $CF33
CLSCREEN   = $E544
BACKGRND   = $D021
FBACKGRND  = $D020

        ;JSR @CHREDEF

        ; INIT  
@INIT   LDA #$FF
        STA OFSET
        LDA #19
        STA XPLAYER
        LDA #YCST
        STA YPLAYER
        LDA #30
        STA ACPROB
        LDA #1
        STA ALMAXCNT
        LDA #0
        STA ALCNT
        STA ALSHOTCNT
        LDA #4
        STA ALCOLOR
        LDA #0
        STA GAMESTATE
        JSR @INITF
        LDA #0
        STA BACKGRND
        STA FBACKGRND
        JSR CLSCREEN
        JSR @MVPLY
        JSR @HEADER

        ; GAME ROUTINE
@MAIN   LDA XPLAYER
        STA OLDXPLAYER
        LDA YPLAYER
        STA OLDYPLAYER
        JSR @PSCORE
        JSR @PLVL
        JSR @CREALI
        JSR @MOVALI
        JSR @CASHT
        JSR @CHKSAC
        JSR @MASHT
        JSR @MVSHOT
        JSR @JOYSTK 
        JSR @MVPLY
        JSR @CHKPAC
        JSR @CHKSAC
        JSR @CHKPAS
        JSR @WAIT
        JSR @WAIT
        JSR @WAIT
        JSR @MNGLV        
        LDA GAMESTATE
        CMP #1
        BEQ @ENDGM
        JMP @MAIN

@ENDGM  JSR @RESTAR
        ;JMP @INIT
        RTS 

;**********************************************
;*** INITIALIZE FIELDS
;**********************************************
@INITF  LDY #0
        LDA #255
@IN1    STA ALIENX:,Y
        STA ALIENY:,Y
        INY
        CPY #MAXALCNT
        BNE @IN1

        LDY #0
@IN2    STA ASHOTX:,Y
        STA ASHOTY:,Y
        INY
        CPY #ALSHOTMAXCNT
        BNE @IN2

        LDY #0
@IN3    LDA #255
        STA SHOTX:,Y
        LDA #TOPYSHOT
        STA SHOTY:,Y
        INY
        CPY #3
        BNE @IN3

        LDA #0
        STA SCORE:+0
        STA SCORE:+1
        STA SCORE:+2
        STA LEVEL:+1
        LDA #1
        STA LEVEL:+0
        STA LVLCONT1
        STA LVLCONT2
        STA LVLCONT3
        RTS

;**********************************************
;*** ROUTINE FOR GAME RESTART AFTER COLLISION
;**********************************************
@RESTAR LDA     JSTICK
        EOR     OFSET
        CMP     #FIRE
        BEQ     @REEND
        JMP     @RESTAR
        LDA     #0
@REST1  PHA
        JSR     @WAIT
        PLA
        TAX
        INX
        TXA
        CMP     #255
        BNE     @REST1
        LDA     #0
@REST2  PHA
        JSR     @WAIT
        PLA
        TAX
        INX
        TXA
        CMP     #255
        BNE     @REST2

@REEND  RTS

;**********************************************
;*** MANAGE LEVEL ROUTINE
;**********************************************
@MNGLV  LDA LVLCONT2    ; SKIP IF HIGHEST LEVEL 
        CMP #255
        BNE @MNGL0
        JMP @MNGLVE

@MNGL0  INC LVLCONT3    ; NEXT LEVEL
        LDA LVLCONT3
        CMP #2
        BNE @MNGLVE
        LDA #0
        STA LVLCONT3

@MNGL1  INC LVLCONT1    ; NEXT LEVEL
        LDA LVLCONT1
        CMP #255
        BNE @MNGLVE

        JSR @ADLEV      ; CONFIGURE NEXT LEVEL
        INC LVLCONT2
        INC ACPROB
        INC ACPROB
        INC ACPROB
        INC ACPROB
        INC ACPROB
        DEC ALCOLOR
        LDA ALCOLOR
        CMP #0
        BNE @MNGL2
        LDA #15
        STA ALCOLOR
@MNGL2  LDA ALMAXCNT
        CMP #MAXALCNT
        BEQ @MNGLVE
        INC ALMAXCNT
        CMP #15
        BNE @MNGLVE
        LDA #1
        STA ALCOLOR
        
@MNGLVE RTS

;**********************************************
;*** MOVE ALIEN SHOT ROUTINE
;**********************************************
@MASHT  INC ALSHOTMVWCNT     ; SLOW SHOTS
        LDA ALSHOTMVWCNT
        CMP #ALSHOTMVWAIT
        BEQ @MASHI
        JMP @MASHE

@MASHI  LDA #0
        STA ALSHOTMVWCNT
        STA ALSHOTPTR

@MASH0  LDY ALSHOTPTR   ; SKIP INACTIVE SHOT
        LDA ASHOTY:,Y
        CMP #255
        BEQ @MASH2

        LDY ALSHOTPTR
        LDA ASHOTY:,Y   ; REMOVE SHOT
        STA YPOS
        LDA ASHOTX:,Y
        STA XPOS
        LDA #32
        STA CHRCODE
        JSR @PLOT

        LDY ALSHOTPTR   ; CHECK SHOT TOO LOW
        LDA ASHOTY:,Y
        CMP #YALMAX
        BEQ @MASH1

        LDY ALSHOTPTR   ; INCREASE SHOT VERTIVAL POSITION
        LDA ASHOTY:,Y
        TAX
        INX
        TXA
        STA ASHOTY:,Y

        LDA ASHOTY:,Y   ; PLOT SHOT
        STA YPOS
        LDA ASHOTX:,Y
        STA XPOS
        LDA #ALSHOTCHR
        STA CHRCODE
        LDA #ALSHOTCOLOR
        STA CHRCOLOR
        JSR @PLOT
        JMP @MASH2
        
@MASH1  LDY ALSHOTPTR   ; INACTIVATE SHOT
        LDA #255
        STA ASHOTY:,Y
        STA ASHOTX:,Y

@MASH2  INC ALSHOTPTR
        LDA ALSHOTPTR
        CMP #ALSHOTMAXCNT
        BNE @MASH0
@MASHE  RTS

;**********************************************
;*** CHECK PLAYER ALIEN SHOT COLLISION
;**********************************************
@CHKPAS LDY #0       
@CHPAS1 LDA ASHOTY:,Y   ; CHECK ALIEN AGAINST PLAYER CENTER
        CMP YPLAYER
        BNE @CHPAS3
        LDA ASHOTX:,Y
        CMP XPLAYER
        BEQ @CHPAS2

        LDX XPLAYER ; CHECK ALIEN AGAINST PLAYER LEFT
        DEX
        TXA
        CMP ASHOTX:,Y
        BEQ @CHPAS2

        LDX XPLAYER ; CHECK ALIEN AGAINST PLAYER RIGHT
        INX
        TXA
        CMP ASHOTX:,Y
        BEQ @CHPAS2
        JMP @CHPAS3

@CHPAS2 LDA #1          ; PLAYER WAS HIT
        STA GAMESTATE
        JSR @PLEXP
        JMP @CHPASE

@CHPAS3 INY             ; GO TO NEXT ALIEN SHOT
        CPY #ALSHOTMAXCNT
        BNE @CHPAS1
@CHPASE RTS

;**********************************************
;*** CREATE ALIEN SHOT ROUTINE
;**********************************************
@CASHT  LDA #0
        STA ALIENPTR

@CHSH0  LDY ALIENPTR    ; SKIP INACTIVE ALIEN
        LDA ALIENY:,Y
        CMP #255
        BEQ @CHSH3

        LDY ALIENPTR    ; SKIP ALIEN TOO LOW
        LDA ALIENY:,Y 
        CMP #YALSHOTMAX 
        BCS @CHSH3

        LDY ALIENPTR   ; SKIP ALIEN UNALIGNED WITH PLAYER
        LDX ALIENX:,Y   
        CPX XPLAYER
        BNE @CHSH3
        
        LDA #0
        STA ALSHOTPTR
@CHSH1  LDY ALSHOTPTR
        LDA ASHOTY:,Y  ; SKIP ACTIVE SHOT
        CMP #255
        BNE @CHSH2

        JSR @ASHPLS
        LDY ALIENPTR   ; CREATE SHOT 
        LDX ALIENX:,Y
        TXA 
        LDY ALSHOTPTR 
        STA ASHOTX:,Y
        STA XPOS
        LDY ALIENPTR
        LDX ALIENY:,Y
        INX
        TXA
        LDY ALSHOTPTR
        STA ASHOTY:,Y
        STA YPOS
        LDA #ALSHOTCHR
        STA CHRCODE
        LDA #ALSHOTCOLOR
        STA CHRCOLOR
        JSR @PLOT
        JMP @CHSH3

@CHSH2  INC ALSHOTPTR   ; CHECK NEXT SHOT
        LDA ALSHOTPTR
        CMP #ALSHOTMAXCNT
        BNE @CHSH1

@CHSH3  INC ALIENPTR    ; CHECK NEXT ALIEN
        LDA ALIENPTR
        CMP ALMAXCNT
        BNE @CHSH0
        RTS

;**********************************************
;*** ALIEN SHOT SOUND
;**********************************************
@ASHPLS LDA #0
        STA SIGVOL      ; VOLUME      
        STA ATDCY2      ; ATTACK - DECAY
        STA SUREL2      ; SUSTAIN - RELEASE
        STA FRELO2      ; FREQUENCY LOW
        STA FREHI2      ; FREQUENCY HIGH
        STA VCREG2      ; WAVEFORM

        LDA #255
        STA SIGVOL      ; VOLUME
        LDA #%00010011
        STA ATDCY1      ; ATTACK - DECAY
        LDA #%00000011
        STA SUREL2      ; SUSTAIN - RELEASE
        LDA #100
        STA FRELO2      ; FREQUENCY LOW
        LDA #100
        STA FREHI2      ; FREQUENCY HIGH
        LDA #17
        STA VCREG2      ; WAVEFORM
        RTS

;**********************************************
;*** MOVE PLAYER ROUTINE
;**********************************************
@MVPLY  LDA OLDXPLAYER
        CMP XPLAYER
        BEQ @MVPLYE

        LDA OLDYPLAYER ; REMOVE OLD PLAYER LEFT 
        STA YPOS
        LDA #32
        STA CHRCODE
        LDA #5
        STA CHRCOLOR
        LDX OLDXPLAYER
        DEX
        STX XPOS
        JSR @PLOT

        LDX OLDXPLAYER ; REMOVE OLD PLAYER CENTER
        DEX
        STX XPOS
        JSR @PLOT

        LDX OLDXPLAYER ; REMOVE OLD PLAYER RIGHT
        INX
        STX XPOS
        JSR @PLOT

        LDA YPLAYER    ; PLOT PLAYER LEFT
        STA YPOS
        LDA #5
        STA CHRCOLOR
        LDA #188
        STA CHRCODE
        LDX XPLAYER
        DEX
        STX XPOS
        JSR @PLOT

        LDA #191       ; PLOT PLAYER CENTER
        STA CHRCODE
        LDX XPLAYER
        STX XPOS
        JSR @PLOT

        LDA #190       ; PLOT PLAYER RIGHT
        STA CHRCODE
        LDX XPLAYER
        INX
        STX XPOS
        JSR @PLOT     
@MVPLYE RTS

;**********************************************
;*** MOVE SHOTS ROUTINE
;**********************************************
@MVSHOT LDA #0
        STA SHOTPTR
@MVS1   LDY SHOTPTR

        LDA SHOTY:,Y    ; SKIP INACTIVE SHOT
        CMP #TOPYSHOT
        BEQ @MVS2
        
        LDA SHOTY:,Y    ; REMOVE SHOT AT OLD POS
        STA YPOS
        LDA SHOTX:,Y
        STA XPOS
        LDA #32
        STA CHRCODE
        JSR @PLOT

        LDY SHOTPTR
        LDX SHOTY:,Y    ; PLOT SHOT AT NEW POS
        DEX
        TXA
        STA SHOTY:,Y
        CMP #TOPYSHOT
        BEQ @MVS2       ; SKIP PLOT IF TOP SCREEN REACHED
        STX YPOS
        LDA SHOTX:,Y   
        STA XPOS
        LDA #CHRSHOT
        STA CHRCODE
        LDA #COLSHOT
        STA CHRCOLOR
        JSR @PLOT

@MVS2   INC SHOTPTR
        LDA SHOTPTR
        CMP #MAXSHOTS
        BNE @MVS1

@EMSHOT RTS

;**********************************************
;*** WAIT ROUTINE
;**********************************************
@WAIT   LDX #0
@W1     NOP
        NOP
        NOP
        NOP
        INX
        CPX #200
        BNE @W1
@W2     NOP
        NOP
        NOP
        NOP
        INX
        CPX #200
        BNE @W2
        RTS

;**********************************************
;*** JOYSTICK CONTROL ROUTINE
;**********************************************
@JOYSTK LDA JSTICK
        EOR OFSET
        CMP #FIRE
        BNE @J1
        JSR @FIRE
@J1     CMP #LEFT
        BNE @J2
        JSR @PLEFT
@J2     CMP #RIGHT
        BNE @J3
        JSR @PRIGHT
@J3     CMP #RIGHTFIRE
        BNE @J4
        JSR @FIRE
        JSR @PRIGHT
@J4     CMP #LEFTFIRE
        BNE @ENDJOY
        JSR @FIRE
        JSR @PLEFT
@ENDJOY RTS

;**********************************************
;*** FIRE PRESSED ROUTINE
;**********************************************
@FIRE   LDA SHOTFLAG
        CMP #1
        BNE @F0
        LDA #0
        STA SHOTFLAG
        JMP @EFIRE
@F0     LDA #1
        STA SHOTFLAG
        LDA #0          ; INIT SHOT POINTER
        STA SHOTPTR
@F1     LDY SHOTPTR
        LDA SHOTY:,Y
        CMP #TOPYSHOT
        BNE @F2         ; CHECK NEXT SHOT IF ACTIVE
        LDA XPLAYER     ; ACTIVTE FREE SHOT
        STA SHOTX:,Y
        STA XPOS
        LDA #YCST-1
        STA SHOTY:,Y
        STA YPOS
        LDA #CHRSHOT
        STA CHRCODE
        LDA #COLSHOT
        STA CHRCOLOR
        JSR @FSHOTS
        JSR @PLOT
        JMP @EFIRE
@F2     LDY SHOTPTR     ; ITERATE IF MAXSHOTS NOT REACHED
        INY
        STY SHOTPTR
        CPY #MAXSHOTS
        BNE @F1
@EFIRE  RTS

;**********************************************
;*** FIRE SHOT SOUND
;**********************************************
@FSHOTS LDA #0
        STA SIGVOL      ; VOLUME
        STA ATDCY1      ; ATTACK - DECAY
        STA SUREL1      ; SUSTAIN - RELEASE
        STA FRELO1      ; FREQUENCY LOW
        STA FREHI1      ; FREQUENCY HIGH
        STA VCREG1      ; WAVEFORM

        LDA #255
        STA SIGVOL      ; VOLUME
        LDA #%00010011
        STA ATDCY1      ; ATTACK - DECAY
        LDA #%00000011
        STA SUREL1      ; SUSTAIN - RELEASE
        LDA #0
        STA FRELO1      ; FREQUENCY LOW
        LDA #8
        STA FREHI1      ; FREQUENCY HIGH
        LDA #33
        STA VCREG1      ; WAVEFORM
        JSR @WAIT
        RTS

;**********************************************
;*** PLAYER LEFT ROUTINE
;**********************************************
@PLEFT  LDX XPLAYER
        CPX #XMIN
        BEQ @PLEFT1
        DEC XPLAYER
@PLEFT1 RTS

;**********************************************
;*** PLAYER RIGHT ROUTINE
;**********************************************
@PRIGHT LDX XPLAYER
        CPX #XMAX
        BEQ @PRIGH1
        INC XPLAYER
@PRIGH1 RTS

;**********************************************
;*** CHECK SHOT ALIEN COLLISION
;**********************************************
@CHKSAC LDY #0
        STY SHOTPTR
        
@CHSA1  LDY SHOTPTR     ; SKIP INACTIVE SHOT
        LDA SHOTY:,Y
        CMP #TOPYSHOT
        BEQ @CHSA4

        STA SHOTYCHK    ; GET SHOT COORDINATES
        LDA SHOTX:,Y
        STA SHOTXCHK

        LDY #0
        STY ALIENPTR
@CHSA2  LDY ALIENPTR    ; CHECK ALIEN AGAINST SHOT
        LDA ALIENY:,Y
        CMP SHOTYCHK
        BNE @CHSA3
        LDA ALIENX:,Y
        CMP SHOTXCHK
        BNE @CHSA3

        JSR @ALEXP      ; EXPLOSION
        JSR @ADSCORE    ; INCREASE SCORE

        LDA #255        ; INACTIVATE ALIEN
        LDY ALIENPTR
        STA ALIENX:,Y
        STA ALIENY:,Y
       
        LDY SHOTPTR     ; INACTIVATE SHOT
        STA SHOTX:,Y
        LDA #TOPYSHOT
        STA SHOTY:,Y

@CHSA3  INC ALIENPTR    ; NEXT ALIEN
        LDA ALIENPTR
        CMP ALMAXCNT
        BNE @CHSA2

@CHSA4  LDY SHOTPTR     ; NEXT SHOT
        INY
        TYA
        STA SHOTPTR
        LDA SHOTPTR
        CMP #MAXSHOTS
        BNE @CHSA1

@CHSACE RTS

;**********************************************
;*** ALIEN EXPLOSION
;**********************************************
@ALEXP  LDA #0
        STA ALEXPLCNT
        JSR @AEXPLS
  
@ALEXP1 LDY ALIENPTR
        LDA ALIENX:,Y   ; EXPLOSION
        STA XPOS
        LDA ALIENY:,Y
        STA YPOS
        LDA #187
        STA CHRCODE
        LDA ALEXPLCNT
        STA CHRCOLOR
        JSR @PLOT
        INC ALEXPLCNT
        LDA #10
        JSR @WAIT
        CMP ALEXPLCNT
        BNE @ALEXP1

        LDY ALIENPTR
        LDA ALIENX:,Y   ; CLEAN
        STA XPOS
        LDA ALIENY:,Y
        STA YPOS
        LDA #32
        STA CHRCODE
        LDA #0
        STA CHRCOLOR
        JSR @PLOT
        RTS

;**********************************************
;*** EXPLODE ALIEN SOUND
;**********************************************
@AEXPLS LDA #0
        STA SIGVOL      ; VOLUME      
        STA ATDCY2      ; ATTACK - DECAY
        STA SUREL2      ; SUSTAIN - RELEASE
        STA FRELO2      ; FREQUENCY LOW
        STA FREHI2      ; FREQUENCY HIGH
        STA VCREG2      ; WAVEFORM

        LDA #255
        STA SIGVOL      ; VOLUME
        LDA #8
        STA ATDCY2      ; ATTACK - DECAY
        LDA #15
        STA SUREL2      ; SUSTAIN - RELEASE
        LDA #100
        STA FRELO2      ; FREQUENCY LOW
        LDA #200
        STA FREHI2      ; FREQUENCY HIGH
        LDA #129
        STA VCREG2      ; WAVEFORM
        RTS

;**********************************************
;*** CHECK PLAYER ALIEN COLLISION
;**********************************************
@CHKPAC LDY #0       
@CHPAC1 LDA ALIENY:,Y   ; CHECK ALIEN AGAINST PLAYER CENTER
        CMP YPLAYER
        BNE @CHPAC3
        LDA ALIENX:,Y
        CMP XPLAYER
        BEQ @CHPAC2

        LDX XPLAYER ; CHECK ALIEN AGAINST PLAYER LEFT
        DEX
        TXA
        CMP ALIENX:,Y
        BEQ @CHPAC2

        LDX XPLAYER ; CHECK ALIEN AGAINST PLAYER RIGHT
        INX
        TXA
        CMP ALIENX:,Y
        BEQ @CHPAC2
        JMP @CHPAC3

@CHPAC2 LDA #1          ; PLAYER WAS HIT
        STA GAMESTATE
        JSR @PLEXP
        JMP @CHPACE

@CHPAC3 INY             ; GO TO NEXT ALIEN
        CPY ALMAXCNT
        BNE @CHPAC1
@CHPACE RTS

;**********************************************
;*** PLAYER EXPLOSION
;**********************************************
@PLEXP  LDA #0
        STA PLEXPCOLOR
        JSR @PEXPLS

@PLEXP1 LDX XPLAYER     ; LEFT EXPLOSION
        DEX
        STX XPOS
        LDX YPLAYER
        STX YPOS
        LDA #83
        STA CHRCODE
        LDA PLEXPCOLOR 
        STA CHRCOLOR
        JSR @PLOT
        
        LDX XPLAYER     ; MIDDLE EXPLOSION
        STX XPOS
        LDX YPLAYER
        STX YPOS
        LDA #83
        STA CHRCODE
        LDA PLEXPCOLOR 
        STA CHRCOLOR
        JSR @PLOT

        LDX XPLAYER     ; RIGHT EXPLOSION
        INX
        STX XPOS
        LDX YPLAYER
        STX YPOS
        LDA #83
        STA CHRCODE
        LDA PLEXPCOLOR 
        STA CHRCOLOR
        JSR @PLOT

        JSR @WAIT
        INC PLEXPCOLOR
        LDA PLEXPCOLOR
        CMP #0
        BNE @PLEXP1

        RTS


;**********************************************
;*** EXPLODE PLAYER SOUND
;**********************************************
@PEXPLS LDA #0
        STA SIGVOL      ; VOLUME      
        STA ATDCY1      ; ATTACK - DECAY
        STA SUREL1      ; SUSTAIN - RELEASE
        STA FRELO1      ; FREQUENCY LOW
        STA FREHI1      ; FREQUENCY HIGH
        STA VCREG1      ; WAVEFORM

        LDA #255
        STA SIGVOL      ; VOLUME
        LDA #10  
        STA ATDCY1      ; ATTACK - DECAY
        LDA #8
        STA SUREL1      ; SUSTAIN - RELEASE
        LDA #255
        STA FRELO1      ; FREQUENCY LOW
        LDA #200
        STA FREHI1      ; FREQUENCY HIGH
        LDA #129
        STA VCREG1      ; WAVEFORM
        RTS


;**********************************************
;*** MOVE ALIENS
;**********************************************
@MOVALI INC ALMVCNT     ; SLOW ALIENS
        LDA ALMVCNT
        CMP #ALMVWAIT
        BEQ @MOVA0
        JMP @MOVALE
        
@MOVA0  LDY #0          ; ALIENS MOVE ROUTINE
        STY ALMVCNT
        LDY #0
        STY ALIENPTR
        
@MOVA1  LDY ALIENPTR    ; SKIP INACTIVE ALIEN
        LDA ALIENY:,Y
        CMP #255
        BEQ @MOVA3

        JSR @DECALI     ; DECIDE VERTICAL MOVE
        LDA RNDRESULT
        CMP #200
        BCS @MOVA3

        LDY ALIENPTR    ; REMOVE ALIEN
        LDA ALIENY:,Y
        STA YPOS        
        LDA ALIENX:,Y
        STA XPOS
        LDA #32
        STA CHRCODE
        JSR @PLOT

        LDY ALIENPTR    ; FREE ALIEN IF MAX VERTICAL
        LDA ALIENY:,Y   ; POSITION REACHED
        CMP #YALMAX
        BNE @MOVA2
        LDA #255
        STA ALIENY:,Y
        STA ALIENX:,Y
        JMP @MOVA3

@MOVA2  LDX ALIENY:,Y   ; MOVE ALIEN vERTICALLY
        INX
        TXA
        STA ALIENY:,Y

        JSR @MVALH      ; MOVE ALIEN HORIZONTALLY

        LDY ALIENPTR
        LDA ALIENY:,Y   ; PLOT ALIEN
        STA YPOS
        LDA ALIENX:,Y   
        STA XPOS
        LDA #187
        STA CHRCODE
        LDA ALCOLOR
        STA CHRCOLOR
        JSR @PLOT

@MOVA3  INC ALIENPTR    ; CHECK NEXT ALIEN
        LDY ALIENPTR
        CPY ALMAXCNT
        BNE @MOVA1
@MOVALE RTS

;**********************************************
;*** MOVE ALIEN HORIZONTALLY
;**********************************************
@MVALH  JSR @DECALI
        LDA RNDRESULT
        LDY ALIENPTR
        
        CMP #75
        BCS @MVALH1     ; MOVE LEFT
        LDX ALIENX:,Y
        CPX #XALMIN
        BEQ @MVALHE
        DEX
        TXA
        STA ALIENX:,Y
        JMP @MVALHE

@MVALH1 CMP #150
        BCS @MVALHE     ; MOVE RIGHT
        LDX ALIENX:,Y
        CPX #XALMAX
        BEQ @MVALHE
        INX
        TXA
        STA ALIENX:,Y
               
@MVALHE RTS

;**********************************************
;*** RANDOMLY CREATE ALIEN
;**********************************************
@CREALI LDA ALCNT       ; CHECK MAX NUMBER ALIENS
        CMP #MAXALCNT
        BEQ @CREEND

        JSR @DECALI     ; DECIDE ALIEN CREATTION
        LDA RNDRESULT
        CMP ACPROB
        BCS @CREEND

        JSR @RNDALX     ; ALIEN X POSITION
        LDA RNDRESULT
        STA ALXPOS
        JSR @RNDALY     ; ALIEN Y POSITION
        LDA RNDRESULT
        STA ALYPOS

        LDY #0          ; CHECK INACTIVE ALIEN
@CREA1  LDA ALIENY:,Y
        CMP #255
        BEQ @CREA2
        INY
        CPY #MAXALCNT
        BNE @CREA1 
        JMP @CREEND

@CREA2  LDA ALXPOS      ; INITIALIZE ALIEN 
        STA ALIENX:,Y
        LDA ALYPOS
        STA ALIENY:,Y
        LDA #0
@CREEND RTS

;**********************************************
;*** ROUTINE TO GENERATE A RANDOM NUMBER FOR ALIEN 
;*** CREATION DECISION
;**********************************************
@DECALI LDA TIMERLOW
        EOR TIMERHIGH
        EOR TIMERLOW
        ADC TIMERHIGH
        EOR TIMERLOW
        EOR TIMERHIGH
        EOR RASTER
        STA RNDRESULT
        RTS 

;**********************************************
;*** RANDOMLY GENERATE ALIEN VERTICAL POSITION
;**********************************************
@RNDALY LDA TIMERLOW
        EOR TIMERHIGH
        EOR TIMERLOW
        ADC TIMERHIGH
        EOR TIMERLOW
        EOR TIMERHIGH
        EOR RASTER
        CMP #YACMAX-#YACMIN
        BCS @RNDALY
        SEC
        ADC #YACMIN
        STA RNDRESULT
        RTS

;**********************************************
;*** RANDOMLY GENERATE ALIEN HORIZONTAL POSITION
;**********************************************
@RNDALX LDA TIMERLOW
        EOR TIMERHIGH
        EOR TIMERLOW
        ADC TIMERHIGH
        EOR TIMERLOW
        EOR TIMERHIGH
        EOR RASTER
        CMP #XACMAX-#XACMIN
        BCS @RNDALX
        SEC
        ADC #XACMIN
        STA RNDRESULT
        RTS

;**********************************************
;*** PLOT PLAYER ROUTINE
;**********************************************
@PLOT   LDY #0
        LDX #0
@INC1   INY                     ; SET OFFSET COLOR RAM (Y POSITION)
        INY
        INX
        CPX YPOS
        BNE @INC1

        LDA CLRTABLE:,Y+1       ; STORE OFFSET IN ZERO PAGE POINTER REGISTER
        STA COLORZEROADR
        LDA CLRTABLE:,Y
        STA COLORZEROADR+1

        LDA CHRCOLOR            ; SET COLOR RAM ADDING X POSITION TO 
        LDY XPOS                ; MEMORY POSITION ZERO PAGE POINTS TO
        STA (COLORZEROADR),Y

        LDY #0                  ; SET OFFSET SCREEN RAM (Y POSITION)
        LDX #0
@INC2   INY
        INY
        INX
        CPX YPOS
        BNE @INC2

        LDA SCRTABLE:,Y+1       ; STORE OFFSET IN ZERO PAGE POINTER REGISTER
        STA SCREENZEROADR
        LDA SCRTABLE:,Y
        STA SCREENZEROADR+1
        
        LDA CHRCODE             ; SET SCREEN RAM ADDING X POSITION TO 
        LDY XPOS                ; MEMORY POSITION ZERO PAGE POINTS TO
        STA (SCREENZEROADR),Y
        RTS

;**********************************************
;*** PLOT GAME HEADER
;**********************************************
@HEADER LDX #0
@H1     LDA HEADERCOLOR:,X
        STA BASECOL,X ; BASE COLOR ADDRESS + X
        LDA HEADERDATA:,X
        STA BASESCR,X ; BASE SCREEN ADDRESS + X
        INX
        CPX #120      
        BNE @H1       
        RTS

;**********************************************
; PLOT SCORE
;**********************************************
@PSCORE CLC
        LDY #7
        LDX #1
        JSR SETCSR
        LDX #$02
@PS1    LDA SCORE:,X
        PHA
        LSR
        LSR
        LSR
        LSR
        CLC
        ADC #$30
        JSR CHROUT
        PLA
        AND #%00001111
        CLC 
        ADC #$30
        JSR CHROUT
        DEX
        BPL @PS1
        RTS

;**********************************************
; ADD SCORE
;**********************************************
@ADSCORE
        SED
        CLC
        LDA SCORE:+0
        ADC ADDITION:+0
        STA SCORE:+0
        LDA SCORE:+1
        ADC ADDITION:+1
        STA SCORE:+1
        LDA SCORE:+2
        ADC ADDITION:+2
        STA SCORE:+2
        CLD
        RTS

;**********************************************
; PLOT LEVEL
;**********************************************
@PLVL   CLC
        LDY #35
        LDX #1
        JSR SETCSR
        LDX #$01
@PLVL1  LDA LEVEL:,X
        PHA
        LSR
        LSR
        LSR
        LSR
        CLC
        ADC #$30
        JSR CHROUT
        PLA
        AND #%00001111
        CLC 
        ADC #$30
        JSR CHROUT
        DEX
        BPL @PLVL1
        RTS

;**********************************************
; ADD LEVEL
;**********************************************
@ADLEV  SED
        CLC
        LDA LEVEL:+0
        ADC LADDITION:+0
        STA LEVEL:+0
        LDA LEVEL:+1
        ADC LADDITION:+1
        STA LEVEL:+1
        CLD
        RTS

;****************************************************
;***  COPY THE CHARACTER ROM TO RAM
;****************************************************
@CHREDEF
        LDA $DD00
        ORA #%00000001
        STA $DD00

        ; DETERMINE CHARSET START
        SEI             ; BLOCK INTERRUPTS
        LDA $01         ; ROM-KONFIG
        PHA             ; RESCUE ROM-KONFIG
        AND #%11111011  ; FADE OUT IO-AREA
        STA $01
        JSR @CHRCPY     ; COPY CHARSET
        PLA             ; RESTORE ROM SETTINGS
        STA $01
        CLI             ; UNBLOCK INTERRUPTS

        JSR @DEFCHR     ; CHARACTER REDEFINITION

        LDA VICMEMCONTROL  ; SWITCH BANK TO NEW CHARSET
        AND #240
        ORA #13
        STA VICMEMCONTROL
        RTS

;****************************************************
;***  CALL SUBROUTINES FOR CHARACTER REDEFINITION
;****************************************************
@DEFCHR LDX #0
        STX CHARPTR
        STX CHARDEFPTR
@DFCH1  LDY CHARPTR     ; FOR EACH ENTRY IN CHRDEF
        LDX CHRDEF:,Y   ; CARRY OUT CHARACTER REDEFINITION 
        JSR @RECHR              
        INC CHARPTR
        LDX CHARPTR
        CPX #5
        BNE @DFCH1
        RTS

;****************************************************
;***  COPY THE CHARACTER ROM TO RAM
;****************************************************
@CHRCPY LDA #<CHARROMADR ; CHAR ROM SOURCE TO ZP_HELPADR1
        STA ZP_HELPADR1
        LDA #>CHARROMADR
        STA ZP_HELPADR1+1

        LDA #<VICCHARSETADR ; CHAR RAM DEST TO ZP_HELPADR2
        STA ZP_HELPADR2
        LDA #>VICCHARSETADR
        STA ZP_HELPADR2+1

        LDX #$08            ; COPY CHAR ROM TO RAM LOOP
@CHRC1  LDY #$00
@CHRC2  LDA (ZP_HELPADR1),Y
        STA (ZP_HELPADR2),Y
        DEY
        CPY #0
        BNE @CHRC2
        INC ZP_HELPADR1+1
        INC ZP_HELPADR2+1
        DEX
        CPX #0
        BNE @CHRC1
        RTS

;****************************************************
;***  REDEFINE CHARACTER
;****************************************************
@RECHR  TXA                    ; SCREENCODE * 8
        AND #%00011111
        ASL
        ASL
        ASL
        CLC
        ADC #<VICCHARSETADR     ; LZP DESTCHAR TO ZP
        STA ZP_HELPADR2

        TXA                     ; SCREENCODE TO AKKU
        LSR                     ; TOP 3 BYTES TO CALC PAGE
        LSR
        LSR
        LSR
        LSR
        CLC
        ADC #>VICCHARSETADR     ; MSB DESTCHAR TO ZP
        STA ZP_HELPADR2+1

        LDX #$00                ; COPY DEFINITION STARTING AT
@RECHR1 LDY CHARDEFPTR          ; CHRDATA PLUS CHARDEFPTR
        LDA CHRDATA:,Y
        STA CHARBYTE
        TXA
        TAY
        LDA CHARBYTE
        STA (ZP_HELPADR2),Y
        INX
        INC CHARDEFPTR
        CPX #8
        BNE @RECHR1
        RTS

CHRDEF:
        BYTE 187,190,188,191,83

CHRDATA:        
        BYTE 126,255,219,255,165,189,24,24
        BYTE 0,0,0,0,120,252,174,255
        BYTE 0,0,0,0,30,63,117,255
        BYTE 24,24,60,60,126,231,255,231
        BYTE 68,17,132,32,4,145,4,73

SHOTX:
        BYTE 255,255,255
SHOTY:  
        BYTE TOPYSHOT,TOPYSHOT,TOPYSHOT

ALIENX:
        BYTE 255,255,255,255,255,255,255,255,255,255
        BYTE 255,255,255,255,255,255,255,255,255,255

ALIENY:
        BYTE 255,255,255,255,255,255,255,255,255,255
        BYTE 255,255,255,255,255,255,255,255,255,255

ASHOTX:
        BYTE 255,255,255,255,255,255
        
ASHOTY:
        BYTE 255,255,255,255,255,255

SCORE:
        BYTE $00, $00, $00

LEVEL:
        BYTE $01, $00

ADDITION:
        BYTE $10, $00, $00

LADDITION:
        BYTE $01, $00, $00

HEADERDATA:
        BYTE $55,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$49
        BYTE $42,$13,$03,$0F,$12,$05,$3A,$20,$20,$20,$20,$20,$20,$20,$20,$01,$13,$14,$12,$0F,$03,$0C,$01,$13,$08,$20,$20,$20,$20,$0C,$05,$16,$05,$0C,$3A,$20,$20,$20,$20,$42
        BYTE $4A,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$4B

HEADERCOLOR:
        BYTE $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
        BYTE $0F,$03,$03,$03,$03,$03,$03,$00,$00,$00,$00,$00,$00,$00,$00,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$00,$00,$00,$00,$0A,$0A,$0A,$0A,$0A,$0A,$00,$00,$00,$00,$0F
        BYTE $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F

SCRTABLE:
        BYTE $04, $00, $04, $28, $04, $50, $04, $78, $04, $A0, $04, $C8 
        BYTE $04, $F0, $05, $18, $05, $40, $05, $68, $05 ,$90, $05, $B8 
        BYTE $05, $E0, $06, $08, $06, $30, $06, $58, $06 ,$80, $06, $A8 
        BYTE $06, $D0, $06, $F8, $07, $20, $07, $48, $07, $70, $07, $98 
        BYTE $07, $C0

CLRTABLE:
        BYTE $D8, $00, $D8, $28, $D8, $50, $D8, $78, $D8, $A0, $D8, $C8 
        BYTE $D8, $F0, $D9, $18, $D9, $40, $D9, $68, $D9, $90, $D9, $B8 
        BYTE $D9, $E0, $DA, $08, $DA, $30, $DA, $58, $DA, $80, $DA, $A8 
        BYTE $DA, $D0, $DA, $F8, $DB, $20, $DB, $48, $DB, $70, $DB, $98 
        BYTE $DB, $C0

