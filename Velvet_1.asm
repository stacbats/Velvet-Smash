// sprite movements

#import "constant.asm"

BasicUpstart2(main)

.label VelvetDirection = $02a7  // spare byte location  

.label Velvet_right = 170   // Using the sprite sheet from char pad remember how many animations
// you have going right as well as any overlays.
.label Velvet_left = 176    // For your overlay, remember its 0,1,2 and three (0 is 1st sprite)
// so if you have 6 animations your first right anim sprite is 0-5 and the left anim would be 6-11

main:
// ** Clearing screen


    lda #$93
    jsr krljmp_CHROUT

// Background & Border

    lda #LIGHT_BLUE
    sta $d021
    lda #BLUE
    sta $d020 


    // ******* SPRITE 0
    lda #SPRITERAM +12       // load the sprite Number ( Screen ram starts at 1024, we add + 1016)
    //  So the address for Sprite 0 is 2040 (see below)
    sta SPRITE0              // this tells us where the Sprite pointer is (2040 in this case)
   // ******* SPRITE 1
    lda #SPRITERAM 
    sta SPRITE0 + 1 

    lda #3              // enabling sprite 0+1 ( %0000 0011)
    sta SPENA           // $d015
    sta YXPAND      // ***  DOUBLE SPRITE SIZE Y    ***
    sta XXPAND      // ***  DOUBLE SPRITE SIZE X    ***
    lda #0              // using 0 as turning multi color off
    sta SPMC            // Sprite multi or hires

    lda #80             // location on screen for x & y
    sta SP0X            // $d000 SP0x location
    sta SP0Y            // $d001 SP0y location
    lda #80             // location on screen for x & y
    sta SP0X +2         // $d000 SP0x location
    sta SP0Y +2         // $d001 SP0y location

    lda #YELLOW          // black for our sprite
    sta SP0COL          // Sprite colour 1 $d027
    lda #BLACK         // black for our sprite
    sta SP0COL + 1      // Sprite colour 1 $d027

// -----------------------------------------------------------------------------    
GAMELOOP:
    lda #240            //scanline -A
    cmp RASTER          // compare A to current Raster line
    bne GAMELOOP
           
KeyboardTEST:       // testig for key press A & D
    lda 197
    cmp #scanCode_A
    bne TestForAKey
    lda #255
    sta VelvetDirection
    jmp UpdateVELVET

TestForAKey:
    cmp #scanCode_D
    bne GAMELOOP
    lda #1
    sta VelvetDirection
    jmp UpdateVELVET
// -----------------------------------------------------------------------------
//   SPRITE Movement
// -----------------------------------------------------------------------------
UpdateVELVET:
    lda VelvetDirection
    bmi Going_left         // only need to test one direction
    
    // ** Move bytes for Right
    lda #Velvet_right
    sta SPRITE0 + 1
    lda #Velvet_right+12
    sta SPRITE0

    inc SP0X
    inc SP0X + 2
    jmp GAMELOOP

Going_left:
    // ** Move bytes for Left
    lda #Velvet_left
    sta SPRITE0 + 1
    lda #Velvet_left + 12
    sta SPRITE0

    dec SP0X
    dec SP0X + 2
    jmp GAMELOOP

GAMELOOPEND:
    jmp GAMELOOP


    rts // returning to basic


* = $2a80 "Sprite Data"
.import binary "Velvet_smash_Sprites.bin"



    