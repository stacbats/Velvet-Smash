// sprite movements

#import "constant.asm"
BasicUpstart2(main)


main:

// ** Clearing screen
    lda #$93
    jsr krljmp_CHROUT

    // ******* SPRITE 0
    lda #SPRITERAM +12       // load the sprite Number ( Screen ram starts at 1024, we add + 1016)
    //  So the address for Sprite 0 is 2040 (see below)
    sta SPRITE0              // this tells us where the Sprite pointer is (2040 in this case)
   // ******* SPRITE 1
    lda #SPRITERAM 
    sta SPRITE0 + 1 

    lda #3              // enabling sprite 1 ( %0000 0011)
    sta SPENA           // $d015
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

    


    rts // returning to basic


* = $2a80 "Sprite Data"
.import binary "Velvet_smash_Sprites.bin"



    