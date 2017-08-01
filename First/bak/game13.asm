*=$C000

; VIC-II CONSTANTS
VICBANKNO               = 0
VICSCREENBLOCKNO        = 1
VICCHARSETBLOCKNO       = 7
VICBITMAPBLOCKNO        = 0
VICBANKNO               = 13
VICCHARSETADR           = $3000
CHARROMADR              = $D000
VICMEMCONTROL           = $D018
ZP_HELPADR1             = $FB
ZP_HELPADR2             = $FD


; COMMON SPRITE CONTROL REGISTERS
ENABLE    = $D015
XXPAND    = $D017
YXPAND    = $D01D
MSBX      = $D010
SPRITEBGCOLREG = $D01F
SPRITESPCOLREG = $D01E

; VARIABLES USED TO MANAGE PLAYER SPRITE
SPRITE0   = $7F8
COLOR0    = $D027
XSPRITE0  = $D000
YSPRITE0  = $D001
SHOUSE    = $0340
COLORSHIP = 3
COLORSHLD = 10

; VARIABLES USED TO MANAGE FUEL SPRITE
SPRITE1   = $7F9
COLOR1    = $D028
XSPRITE1  = $D002
YSPRITE1  = $D003
FHOUSE    = $0380
COLORFUEL = 7
DOFUEL    = 7

;VARIABLES USED BY GAME ROUTINE
BORDER    = $D020
BACKGROUND = $D021
CLSCREEN  = $E544
FUELHI  = $CF10
FUELLO  = $CF11

; VARIABLES USED BY JOYSTICK ROUTINE
OFSET     = $CF12
JSTICK    = $DC01
NEUTRAL   = 0
UP        = 1
DOWN      = 2
LEFT      = 4
UPLEFT    = 5
DNLEFT    = 6
RIGHT     = 8
UPRIGHT   = 9
DNRIGHT   = 10
FIRE      = 16
MINX      = 25
MAXX      = 240
MINY      = 88
MAXY      = 230
XPLAYER   = $CF13
YPLAYER   = $CF14

;VARIABLES USED BY RND ROUTINE
TIMERLOW  = $DC04
TIMERHIGH = $DC05
RASTER    = $D012
RNDMIN    = $CF15
RNDMAX    = $CF16
RNDRESULT = $CF17

; VARIABLES USED BY PLOT AND PEEK ROUTINE
XPOS      = $CF18
YPOS      = $CF19
CHRCODE   = $CF1A
CHRCOLOR  = $CF1B
SCREENZEROADR = $FB
COLORZEROADR = $FD

; VARIABLES USED BY SCROLL ROUTINE
XSCRL     = $CF1C
YSCRL     = $CF1D
YSCRLP    = $CF1E
SCRLMINY  = 10
SCRLMAXX  = 39
SCRLMAXY  = 48

;VARIABLES USED BY PLOT OBJECT ROUTINE
DOPLOT    = $CF1F
OBJCHR    = 42
OBJCLR    = 15
YOMIN     = 5
YOMAX     = 23

;VARIABLES USED BY GAME ROUTINE
BORDER    = $D020
BACKGROUND = $D021
CLSCREEN  = $E544
GAMESTATE = $CF20
DIFFCOUNT = $CF21
SHIELD    = $CF22
FUELSTATE = $CF23

;VARIABLES USED BY HEADER ROUTINES
BASECOL   = $D800
BASESCR   = $0400
XPOSCUR   = $CF24
FUELCNT   = $CF25

;VARIABLES USED FOR SOUND GENERATION
SIGVOL     = $D418
ATDCY1     = $D405
SUREL1     = $D406
VCREG1     = $D404
FRELO1     = $D400
FREHI1     = $D401

;VARIABLES USED BY PRINT ROUTINES
SETCSR  = $FFF0
CHROUT  = $E716

;**********************************************
;*** GAME ROUTINE
;**********************************************
@GAME   LDA #$FF        ; JOYSTICK OFFSET
        STA OFSET
                
        LDA #30         ; DIFFICULTY
        STA DOPLOT
        LDA #0
        STA DIFFCOUNT
        
        JSR CLSCREEN    ; PREPARE SCREEN
        LDA #6
        STA BORDER
        LDA #0
        STA BACKGROUND
        JSR @CHREDEF    ; CHARACTER REDEFINITION

        JSR @IPLSPR     ; PLAYER SPRITE 
        JSR @IFUSPR     ; FUEL SPRITE

        LDA #0          ; INIT GAME STATE VARIABLES
        STA GAMESTATE
        LDA #1
        STA FUELSTATE
        LDA #0
        STA SHIELD
        LDA #30
        STA FUELHI
        LDA #10
        STA FUELLO
        LDA #1
        STA SECTOR:+0
        JSR @HEADER
        LDA SPRITEBGCOLREG
        LDA #0
        STA SCORE:+0
        STA SCORE:+1
        STA SCORE:+2
        STA SECTOR:+1
        LDA #1
        STA SECTOR:+0

@GL1    JSR @PSCORE     ; GAME LOOP
        JSR @ADSCORE
        JSR @FUELM
        JSR @FUELD
        JSR @PSECT
        JSR @JPLR
        JSR @PLTFUE
        JSR @PLTOBJ
        JSR @SCROLL
        JSR @PLOBJC
        JSR @DIFFIC
        JSR @FUELB
        JSR @PLYFCO
        LDA GAMESTATE
        CMP #1
        BEQ @END
        JMP @GL1
@END    JSR @PLEXP
        LDA #0
        STA ENABLE
        JSR @RESTAR
        RTS

;**********************************************
;*** MANAGE DIFFICULTY
;**********************************************
@DIFFIC LDX DIFFCOUNT
        INX
        STX DIFFCOUNT
        CPX #0
        BNE @ENDDC
        INC DOPLOT
        INC DOPLOT
        INC DOPLOT
        INC DOPLOT
        INC DOPLOT
        INC BORDER
        JSR @ADSEC
@ENDDC  RTS

;**********************************************
;*** CHECK PLAYER FUEL SPRITE COLLISION
;**********************************************
@PLYFCO LDA SPRITESPCOLREG
        CMP #3
        BNE @FLYFCE
        LDA #1
        STA ENABLE
        LDA #0          
        STA FUELSTATE
        JSR @CFULSN
        INC FUELHI
        INC FUELHI
        INC FUELHI
        INC FUELHI
        INC FUELHI
        INC FUELHI
        INC FUELHI
        INC FUELHI
        LDA FUELHI
        CMP #30
        BCS @PFC1
        JMP @PFC2
@PFC1   LDA #30
        STA FUELHI
@PFC2   LDA #10
        STA FUELLO
@FLYFCE RTS

;**********************************************
;*** FUEL COLLECTION SOUND
;**********************************************
@CFULSN LDA #0
        STA SIGVOL      ; VOLUME
        LDA #0      
        STA ATDCY1      ; ATTACK - DECAY
        LDA #0
        STA SUREL1      ; SUSTAIN - RELEASE
        LDA #0
        STA FRELO1      ; FREQUENCY LOW
        LDA #0
        STA FREHI1      ; FREQUENCY HIGH
        LDA #0
        STA VCREG1      ; WAVEFORM

        LDA #255
        STA SIGVOL      ; VOLUME
        LDA #5  
        STA ATDCY1      ; ATTACK - DECAY
        LDA #10
        STA SUREL1      ; SUSTAIN - RELEASE
        LDA #100
        STA FRELO1      ; FREQUENCY LOW
        LDA #50
        STA FREHI1      ; FREQUENCY HIGH
        LDA #33
        STA VCREG1      ; WAVEFORM
        RTS


;**********************************************
;*** SHIELD ENABLE SOUND
;**********************************************
@SHLENS LDA #0
        STA SIGVOL      ; VOLUME
        LDA #0      
        STA ATDCY1      ; ATTACK - DECAY
        LDA #0
        STA SUREL1      ; SUSTAIN - RELEASE
        LDA #0
        STA FRELO1      ; FREQUENCY LOW
        LDA #0
        STA FREHI1      ; FREQUENCY HIGH
        LDA #0
        STA VCREG1      ; WAVEFORM

        LDA #255
        STA SIGVOL      ; VOLUME
        LDA #5  
        STA ATDCY1      ; ATTACK - DECAY
        LDA #10
        STA SUREL1      ; SUSTAIN - RELEASE
        LDA #100
        STA FRELO1      ; FREQUENCY LOW
        LDA #50
        STA FREHI1      ; FREQUENCY HIGH
        LDA #17
        STA VCREG1      ; WAVEFORM
        RTS

;**********************************************
;*** MOVE FUEL SPRITE
;**********************************************
@FUELM  LDA FUELSTATE   ; ABORT IF NO FUEL VISIBLE
        CMP #0
        BEQ @FM1
        JMP @FM2
@FM1    RTS
@FM2    LDA XSPRITE1    ; ADJUST X-POSITION AREA FLAG
        CMP #0
        BEQ @FM3
        JMP @FM4
@FM3    LDA #0          
        STA MSBX
@FM4    DEC XSPRITE1    ; DECREASE FUEL SPRITE X POSITION
        DEC XSPRITE1
        DEC XSPRITE1
        DEC XSPRITE1
        DEC XSPRITE1
        LDA XSPRITE1
        JSR @FUELV
        LDA MSBX        ; SKIP IF FUEL SPRITE ON RIGHT OF SCREEN
        CMP #2
        BEQ @FUELE
        LDA XSPRITE1    ; REMOVE FUEL SPRITE IF LEFT OF SCREEN
        CMP #5
        BCS @FUELE
        LDA #0
        STA FUELSTATE
        LDA #1
        STA ENABLE
@FUELE  RTS

;**********************************************
;*** RANDOMLY MOVE FUEL SPRITE VERTICALLY
;**********************************************
@FUELV  JSR @DECOBJ
        LDA RNDRESULT
        CMP #155
        BCC @FUELVE
        CMP #205
        BCC @FUP
        JMP @FDWN
@FUP    LDX #4
@FUP1   LDA YSPRITE1
        CMP #MINY
        BEQ @FUELVE
        DEC YSPRITE1
        DEX
        CPX #0
        BNE @FUP1
        JMP @FUELVE
@FDWN   LDX #4
@FDWN1  LDA YSPRITE1
        CMP #MAXY
        BEQ @FUELVE
        INC YSPRITE1
        DEX
        CPX #0
        BNE @FDWN1
@FUELVE RTS

;**********************************************
;*** ROUTINE TO CHECK PLAYER OBSTACLE COLLISION
;**********************************************
@PLOBJC LDA SHIELD
        CMP #1
        BEQ @SHLD       ; CHECK IF SHIELD ACTIVE 
        LDA #COLORSHIP          
        STA COLOR0
        LDA SPRITEBGCOLREG
        AND #%000000001
        BEQ @CEND
        LDA #1
        STA GAMESTATE
        JMP @CEND
@SHLD   LDA SPRITEBGCOLREG ; IGNORE COLLISION 
        LDA #COLORSHLD
        STA COLOR0
@CEND   RTS

;**********************************************
;*** ROUTINE TO INITIALIZE THE PLAYER SPRITE
;**********************************************
@IPLSPR LDA #$0D        ; BLOCK 13
        STA SPRITE0 
        LDA #1          ; ENABLE SPRITE 0
        STA ENABLE
        LDA #COLORSHIP  ; SET SPRITE 0 COLOR
        STA COLOR0
        LDA #0          ; DONT EXPAND SPRITE 0
        STA XXPAND
        STA YXPAND

        ; CLEAN SPRITE 0 DATA AREA
        LDX #0
        LDA #0
@CLEAN  STA SHOUSE,X
        INX
        CPX #63
        BNE @CLEAN

        ; BUILD SPRITE 0
        LDX #0
@BUILD  LDA PLAYER:,X
        STA SHOUSE,X
        INX
        CPX #63
        BNE @BUILD
        
        ; INIT SPRITE POSITION
        LDA #0
        STA MSBX
        LDX #100
        STX XPLAYER
        STX YPLAYER
        STX XSPRITE0
        STX YSPRITE0
        RTS

;**********************************************
;*** EXPLODE PLAYER SPRITE
;**********************************************
@PLEXP  LDX #0
@PLE1   LDA EXPLODE:,X
        STA SHOUSE,X
        INX
        CPX #63
        BNE @PLE1
        LDA #1          ; EXPAND SPRITE 0
        STA XXPAND
        STA YXPAND
        JSR @EXPLS
        LDX #200
@PLE2   TXA
        PHA
        JSR @WAIT
        PLA
        TAX
        DEX
        STX COLOR0
        CPX #0
        BNE @PLE2
        LDA #0          ; DONT EXPAND SPRITE 0
        STA XXPAND
        STA YXPAND
        RTS

;**********************************************
;*** EXPLODE PLAYER SOUND
;**********************************************
@EXPLS  LDA #0
        STA SIGVOL      ; VOLUME
        LDA #0      
        STA ATDCY1      ; ATTACK - DECAY
        LDA #0
        STA SUREL1      ; SUSTAIN - RELEASE
        LDA #0
        STA FRELO1      ; FREQUENCY LOW
        LDA #0
        STA FREHI1      ; FREQUENCY HIGH
        LDA #0
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
;*** ROUTINE TO INITIALIZE THE FUEL SPRITE
;**********************************************
@IFUSPR LDA #$0E        ; BLOCK 14
        STA SPRITE1 
        LDA #COLORFUEL ; SET SPRITE 1 COLOR
        STA COLOR1

        ; CLEAN SPRITE 0 DATA AREA
        LDX #0
        LDA #0
@CLEANF STA FHOUSE,X
        INX
        CPX #63
        BNE @CLEANF

        ; BUILD SPRITE 0
        LDX #0
@BUILDF LDA FUEL:,X
        STA FHOUSE,X
        INX
        CPX #63
        BNE @BUILDF        
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
;*** ROUTINE TO CONTROL PLAYER BY JOYSTICK
;**********************************************
@JPLR   LDA     FUELHI
        CMP     #0
        BNE     @JC
        LDA     #COLORSHIP
        STA     COLOR0
        LDA     #0
        STA     SHIELD
        RTS
@JC     LDA     JSTICK
        EOR     OFSET
        CMP     #NEUTRAL
        BEQ     @NEUTR
        CMP     #FIRE
        BEQ     @JFIRE
        JMP     @JL1
@JFIRE  JMP     @FIRE
@JL1    CMP     #UP
        BEQ     @UP
        CMP     #DOWN
        BEQ     @DOWN
        CMP     #LEFT       
        BEQ     @JLEF
        JMP     @JL5
@JLEF   JMP     @LEFT
@JL5    CMP     #UPLEFT
        BEQ     @ULEFT
        CMP     #DNLEFT
        BEQ     @JDLEF
        JMP     @JL6
@JDLEF  JMP     @DLEFT
@JL6    CMP     #RIGHT
        BEQ     @JRIG
        JMP     @JL4
@JRIG   JMP     @RIGHT
@JL4    CMP     #UPRIGHT
        BEQ     @JDURIG
        JMP     @JL2
@JDURIG JMP     @URIGHT
@JL2    CMP     #DNRIGHT
        BEQ     @JDRIG
        JMP     @JL3
@JDRIG  JMP     @DRIGHT
@JL3    JMP     @FIRE

@NEUTR  LDA     #0
        STA     SHIELD
        JMP     @ENDJOY

@UP     LDX     YPLAYER
        DEX
        DEX
        DEX
        DEX
        DEX
        STX     YPLAYER
        LDA     #0
        STA     SHIELD
        JMP     @ENDJOY

@DOWN   LDX     YPLAYER
        INX
        INX
        INX
        INX
        INX
        STX     YPLAYER
        LDA     #0
        STA     SHIELD
        JMP     @ENDJOY

@LEFT   LDX     XPLAYER
        DEX
        DEX
        DEX
        DEX
        DEX
        STX     XPLAYER
        LDA     #0
        STA     SHIELD
        JMP     @ENDJOY

@ULEFT  LDX     YPLAYER
        DEX
        DEX
        DEX
        DEX
        DEX
        STX     YPLAYER
        LDX     XPLAYER
        DEX
        DEX
        DEX
        DEX
        DEX
        STX     XPLAYER
        LDA     #0
        STA     SHIELD
        JMP     @ENDJOY

@DLEFT  LDX     YPLAYER
        INX
        INX
        INX
        INX
        INX
        STX     YPLAYER
        LDX     XPLAYER
        DEX
        DEX
        DEX
        DEX
        DEX
        STX     XPLAYER
        LDA     #0
        STA     SHIELD
        JMP     @ENDJOY

@RIGHT  LDX     XPLAYER
        INX
        INX
        INX
        INX
        INX
        STX     XPLAYER
        LDA     #0
        STA     SHIELD
        JMP     @ENDJOY

@URIGHT LDX     YPLAYER
        DEX
        DEX
        DEX
        DEX
        DEX
        STX     YPLAYER
        LDX     XPLAYER
        INX
        INX
        INX
        INX
        INX
        STX     XPLAYER
        LDA     #0
        STA     SHIELD
        JMP     @ENDJOY

@DRIGHT LDX     YPLAYER
        INX
        INX
        INX
        INX
        INX
        STX     YPLAYER
        LDX     XPLAYER
        INX
        INX
        INX
        INX
        INX
        STX     XPLAYER
        LDA     #0
        STA     SHIELD
        JMP     @ENDJOY

@FIRE   JSR     @SHLENS 
        LDA     #1
        STA     SHIELD
        JSR     @FUELD
        JSR     @FUELD
        JSR     @FUELD
        JSR     @FUELD
        JMP     @ENDJOY

@ENDJOY LDX     XPLAYER         ; Adjust player position if movment
        CPX     #MINX           ; range has been exceeded
        BCS     @CMAXX
        LDX     #MINX
        STX     XPLAYER
@CMAXX  LDX     XPLAYER
        CPX     #MAXX
        BCC     @CMINY
        LDX     #MAXX
        STX     XPLAYER 
@CMINY  LDX     YPLAYER
        CPX     #MINY
        BCS     @CMAXY
        LDX     #MINY
        STX     YPLAYER
@CMAXY  LDX     YPLAYER
        CPX     #MAXY
        BCC     @RTSJOY
        LDX     #MAXY
        STX     YPLAYER
@RTSJOY LDA     XPLAYER
        STA     XSPRITE0
        LDA     YPLAYER
        STA     YSPRITE0
        RTS

;**********************************************
;*** ROUTINE TO PLOT CHARACTER TO SCREENRAM
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
;*** ROUTINE TO HARDSCROLL SCREENRAM FROM  
;*** RIGHT TO LEFT
;**********************************************
@SCROLL LDY #SCRLMINY           ; INIT SCROLL POINTER
        STY YSCRL
        STY YSCRLP

@YSCRL  LDX #1
        STX XSCRL

@XSCRL  LDY YSCRL
        LDA CLRTABLE:,Y+1       ; POINT ZERO PAGE TO COLORRAM ADDRESS
        STA COLORZEROADR
        LDA CLRTABLE:,Y
        STA COLORZEROADR+1

        LDA SCRTABLE:,Y+1       ; POINT ZERO PAGE TO SCREENRAM ADDRESS
        STA SCREENZEROADR
        LDA SCRTABLE:,Y
        STA SCREENZEROADR+1

        LDY XSCRL               ; COPY COLORRAMRAM CONTENT RIGHT TO LEFT
        LDA (COLORZEROADR),Y
        DEY
        STA (COLORZEROADR),Y
        
        LDY XSCRL               ; COPY SCREENRAM CONTENT RIGHT TO LEFT
        LDA (SCREENZEROADR),Y
        DEY
        STA (SCREENZEROADR),Y

        LDX XSCRL               ; INCREASE COLUMN COUNTER
        INX
        STX XSCRL
        CPX #SCRLMAXX+1
        BNE @XSCRL
        
        LDY XSCRL               ; RESET LAST COLOR OF COLUMN
        LDA (COLORZEROADR),Y
        LDY XSCRL
        DEY
        LDA #0
        STA (COLORZEROADR),Y

        LDY XSCRL               ; DELETE LAST CHAR OF COLUMN
        LDA (SCREENZEROADR),Y
        LDY XSCRL
        DEY
        LDA #32
        STA (SCREENZEROADR),Y

        LDX YSCRLP
        INX
        STX YSCRLP
        LDX YSCRL
        INX
        INX
        STX YSCRL
        CPX #SCRLMAXY
        BNE @SL1
        JMP @ENDSCR
@SL1    JMP @YSCRL
@ENDSCR RTS

;**********************************************
;*** ROUTINE TO PUT FUEL SPRITE ON RANDOM POSITION ON SCREEN
;**********************************************
@PLTFUE LDA FUELSTATE   ; SKIP IF FUEL SPRITE VISIBLE
        CMP #1
        BEQ @EPLTFU
        JSR @DECOBJ     ; DECIDE IF FUEL SPRITE BECOMES VISIBLE
        CMP #DOFUEL
        BCS @EPLTFU
        LDA #1          ; MAKE FUEL SPRITE VISIBLE
        STA FUELSTATE
        JSR @RNDFUE
        LDA RNDRESULT
        STA YSPRITE1
        LDX #90
        STX XSPRITE1
        LDA #2
        STA MSBX
        LDA #3
        STA ENABLE
        JSR @EFULSN
@EPLTFU RTS

;**********************************************
;*** FUEL APPEARANCE SOUND
;**********************************************
@EFULSN LDA #0
        STA SIGVOL      ; VOLUME
        LDA #0      
        STA ATDCY1      ; ATTACK - DECAY
        LDA #0
        STA SUREL1      ; SUSTAIN - RELEASE
        LDA #0
        STA FRELO1      ; FREQUENCY LOW
        LDA #0
        STA FREHI1      ; FREQUENCY HIGH
        LDA #0
        STA VCREG1      ; WAVEFORM

        LDA #255
        STA SIGVOL      ; VOLUME
        LDA #5  
        STA ATDCY1      ; ATTACK - DECAY
        LDA #10
        STA SUREL1      ; SUSTAIN - RELEASE
        LDA #240
        STA FRELO1      ; FREQUENCY LOW
        LDA #200
        STA FREHI1      ; FREQUENCY HIGH
        LDA #17
        STA VCREG1      ; WAVEFORM
        RTS


;**********************************************
;*** ROUTINE TO GENERATE A RANDOM NUMBER FOR FUEL POS
;**********************************************
@RNDFUE LDA TIMERLOW
        EOR TIMERHIGH
        EOR TIMERLOW
        ADC TIMERHIGH
        EOR TIMERLOW
        EOR TIMERHIGH
        EOR RASTER
        CMP #MAXY-#MINY
        BCS @RNDFUE
        SEC
        ADC #MINY
        STA RNDRESULT
        RTS 

;**********************************************
;*** ROUTINE TO PLOT OBJECTS RANDOMLY TO 
;*** RIGHTMOST COLUMN OF SCREEN
;**********************************************
@PLTOBJ JSR @DECOBJ
        LDA RNDRESULT
        CMP DOPLOT
        BCS @ENDOBJ
        LDX #39
        STX XPOS
        LDA #YOMIN
        STA RNDMIN
        LDA #YOMAX
        STA RNDMAX
        JSR @RNDOBJ
        LDY RNDRESULT
        STY YPOS
        LDA #OBJCHR
        STA CHRCODE
        LDA #OBJCLR
        STA CHRCOLOR
        JSR @PLOT
@ENDOBJ RTS

;**********************************************
;*** ROUTINE TO GENERATE A RANDOM NUMBER FOR OBJECT 
;*** CREATION DECISION
;**********************************************
@DECOBJ LDA TIMERLOW
        EOR TIMERHIGH
        EOR TIMERLOW
        ADC TIMERHIGH
        EOR TIMERLOW
        EOR TIMERHIGH
        EOR RASTER
        STA RNDRESULT
        RTS 

;**********************************************
;*** ROUTINE TO GENERATE A RANDOM NUMBER FOR OBJECT POS
;**********************************************
@RNDOBJ LDA TIMERLOW
        EOR TIMERHIGH
        EOR TIMERLOW
        ADC TIMERHIGH
        EOR TIMERLOW
        EOR TIMERHIGH
        EOR RASTER
        CMP #YOMAX-#YOMIN
        BCS @RNDOBJ
        SEC
        ADC #YOMIN
        STA RNDRESULT
        RTS 

;**********************************************
;*** ROUTINE TO PEEK CHARACTER FROM SCREENRAM
;**********************************************
@PEEK   LDY #0
        LDX #0
@PINC1  INY                     ; SET OFFSET COLOR RAM (Y POSITION)
        INY
        INX
        CPX YPOS
        BNE @PINC1

        LDA CLRTABLE:,Y+1       ; STORE OFFSET IN ZERO PAGE POINTER REGISTER
        STA COLORZEROADR
        LDA CLRTABLE:,Y
        STA COLORZEROADR+1
           
        LDY XPOS                ; GET COLOR RAM ADDING X POSITION TO 
        LDA (COLORZEROADR),Y    ; MEMORY POSITION ZERO PAGE POINTS TO
        STA CHRCOLOR

        LDY #0                  ; SET OFFSET SCREEN RAM (Y POSITION)
        LDX #0
@PINC2  INY
        INY
        INX
        CPX YPOS
        BNE @PINC2

        LDA SCRTABLE:,Y+1       ; STORE OFFSET IN ZERO PAGE POINTER REGISTER
        STA SCREENZEROADR
        LDA SCRTABLE:,Y
        STA SCREENZEROADR+1
        
        LDY XPOS                ; GET SCREEN RAM ADDING X POSITION TO
        LDA (SCREENZEROADR),Y   ; MEMORY POSITION ZERO PAGE POINTS TO
        STA CHRCODE
        RTS

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
;*** PLOT GAME HEADER
;**********************************************
@HEADER LDX #0
@H1     LDA HEADERCOLOR:,X
        STA BASECOL,X ; BASE COLOR ADDRESS + X
        LDA HEADERDATA:,X
        STA BASESCR,X ; BASE SCREEN ADDRESS + X
        INX
        CPX #200      
        BNE @H1       
        RTS

;**********************************************
; PLOT SCORE
;**********************************************
@PSCORE CLC
        LDY #8
        LDX #3
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
; PLOT SECTOR
;**********************************************
@PSECT  CLC
        LDY #28
        LDX #3
        JSR SETCSR
        LDX #$01
@PSE1   LDA SECTOR:,X
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
        BPL @PSE1
        RTS

;**********************************************
; ADD SECTOR
;**********************************************
@ADSEC
        SED
        CLC
        LDA SECTOR:+0
        ADC ADDITION:+0
        STA SECTOR:+0
        LDA SECTOR:+1
        ADC ADDITION:+1
        STA SECTOR:+1
        CLD
        RTS

;**********************************************
;*** DEDUCT FUEL
;**********************************************
@FUELD  LDA FUELHI
        CMP #0
        BNE @FU2
        LDA #1
        JMP @FU1
@FU2    LDX FUELLO
        DEX
        STX FUELLO
        CPX #0
        BNE @FU1
        LDA #10
        STA FUELLO
        DEC FUELHI
@FU1    RTS

;**********************************************
;*** PLOT FUEL BAR
;**********************************************
@FUELB  LDA #7
        STA XPOS
        STA XPOSCUR
        LDA FUELHI
        CMP #0
        BEQ @FL2
        LDA #7
        STA XPOS
        STA XPOSCUR
        LDA #0
        STA FUELCNT
@FL1    LDA #$51
        STA CHRCODE
        LDA #07
        STA CHRCOLOR
        LDA #1
        STA YPOS
        JSR @PLOT
        INC XPOSCUR
        LDA XPOSCUR
        STA XPOS
        INC FUELCNT
        LDX FUELCNT
        CPX FUELHI
        BNE @FL1
@FL2    LDA #32
        STA CHRCODE
        LDA XPOSCUR
        STA XPOS
        JSR @PLOT
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

        LDX #42         ; CHARACTER TO REPLACE
        JSR @DEFCHR

        LDA VICMEMCONTROL  ; SWITCH BANK FOR NEW CHARSET
        AND #240
        ORA #13
        STA VICMEMCONTROL
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

        LDX #$08            ; COPY LOOP
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
;***  DEFINE CHARACTER
;****************************************************
@DEFCHR TXA                    ; SCREENCODE * 8
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

        LDY #$07                ; COPY DEFINITION
@DFCHR1 LDA ASTCHAR:,Y
        STA (ZP_HELPADR2),Y
        DEY
        BPL @DFCHR1
        RTS

ASTCHAR:
        BYTE %00000000
        BYTE %00111100
        BYTE %01011110
        BYTE %10111111
        BYTE %10111111
        BYTE %10011111
        BYTE %01000110
        BYTE %00111100

SCORE:
        BYTE $00, $00, $00

SECTOR:
        BYTE $00, $00

ADDITION:
        BYTE $01, $00, $00

HEADERDATA:
        BYTE $70,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$6E
        BYTE $42,$06,$15,$05,$0C,$3A,$20,$51,$51,$51,$51,$51,$51,$51,$51,$51,$51,$51,$51,$51,$51,$51,$51,$51,$51,$51,$51,$51,$51,$51,$51,$51,$51,$51,$51,$51,$51,$20,$20,$42
        BYTE $6B,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$72,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$73
        BYTE $42,$13,$03,$0F,$12,$05,$3A,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$42,$13,$05,$03,$14,$0F,$12,$3A,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$42
        BYTE $6D,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$71,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$43,$7D

HEADERCOLOR:
        BYTE $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
        BYTE $0F,$03,$03,$03,$03,$03,$03,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$07,$00,$0F
        BYTE $0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F
        BYTE $0F,$0D,$0D,$0D,$0D,$0D,$0D,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0F,$0D,$0D,$0D,$0D,$0D,$0D,$0D,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$0F
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

PLAYER:
        BYTE 0,0,0
        BYTE 96,0,0
        BYTE 248,0,0
        BYTE 252,0,0
        BYTE 126,0,0
        BYTE 127,0,0
        BYTE 31,128,0
        BYTE 19,224,240
        BYTE 9,255,220
        BYTE 9,255,199
        BYTE 9,255,195
        BYTE 18,127,254
        BYTE 63,159,184
        BYTE 127,239,96
        BYTE 127,176,192
        BYTE 248,63,128
        BYTE 224,63,0
        BYTE 0,62,0
        BYTE 0,60,0
        BYTE 0,56,0
        BYTE 0,32,0

EXPLODE:
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 0,12,0
        BYTE 1,4,64
        BYTE 25,216,80
        BYTE 4,9,96
        BYTE 13,161,24
        BYTE 26,183,192
        BYTE 3,251,208
        BYTE 2,174,184
        BYTE 21,183,200
        BYTE 16,239,96
        BYTE 6,157,12
        BYTE 5,226,192
        BYTE 18,152,24
        BYTE 16,48,96
        BYTE 1,139,96
        BYTE 1,168,0
        BYTE 0,32,0
        BYTE 0,0,0
        BYTE 0,0,0

FUEL:
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 1,255,128
        BYTE 3,0,192
        BYTE 6,126,96
        BYTE 4,255,32
        BYTE 5,195,160
        BYTE 5,223,160
        BYTE 5,199,160
        BYTE 5,223,160
        BYTE 5,223,160
        BYTE 4,255,32
        BYTE 6,126,96
        BYTE 3,0,192
        BYTE 1,255,128
        BYTE 0,0,0
        BYTE 0,0,0
        BYTE 0,0,0
