    processor 6502

    org $C000            ; 49152


    ; Write text to screen: "today's steps: "
    lda #20
    sta 1954
    lda #15
    sta 1955
    lda #4
    sta 1956
    lda #1
    sta 1957
    lda #25
    sta 1958
    lda #39
    sta 1959
    lda #19
    sta 1960

    lda #19
    sta 1962
    lda #20
    sta 1963
    lda #5
    sta 1964
    lda #16
    sta 1965
    lda #19
    sta 1966
    lda #58
    sta 1967

    ; Add color to the text.
    ldx #$20
    lda #$07
ColorLoop
    sta 56226,x
    dex
    bne ColorLoop
    sta 56226

    lda #$00        ; Set user port data lines all to input.
    sta 56579

    lda 56578       ; Set user port PA2 to input.
    and #%11111011
    sta 56578

    jsr RasterInterruptInit

MainLoop
    jmp MainLoop


RasterInterruptInit
    SEI                  ; set interrupt bit, make the CPU ignore interrupt requests
    LDA #%01111111       ; switch off interrupt signals from CIA-1
    STA $DC0D

    AND $D011            ; clear most significant bit of VIC's raster register
    STA $D011

    LDA $DC0D            ; acknowledge pending interrupts from CIA-1
    LDA $DD0D            ; acknowledge pending interrupts from CIA-2

    LDA #215             ; set rasterline where interrupt shall occur
    STA $D012

    LDA #<Irq            ; set interrupt vectors, pointing to interrupt service routine
    STA $0314
    LDA #>Irq
    STA $0315

    LDA #%00000001       ; enable raster interrupt signals from VIC
    STA $D01A

    CLI                  ; clear interrupt flag, allowing the CPU to respond to interrupt requests
    
    RTS


Irq        
    LDA $D011             ; select text screen mode
    AND #%11011111
    STA $D011

    ; Turn off multcolor mode.
    lda $d016
    and #$EF
    sta $d016

    ; Set charset location.
    lda #$16
    sta $D018

    lda 56576   ; Read PA2 to see if data is ready.
    AND #%00000100
    cmp #%00000100
    bne SkipScreenUpdate
    ; Write user port value to screen.
    ; lda 56577
    ; sta 1969

    ldx 56577
    ldy #$00

    STX div_lo
    STY div_hi

    LDY #$04
next    JSR div10
    ORA #$30
    STA 1969,Y
    DEY
    BPL next


SkipScreenUpdate

    LDA #<Irq2            ; set interrupt vectors to the second interrupt service routine at Irq2
    STA $0314
    LDA #>Irq2
    STA $0315

    LDA #$0
    STA $D012            ; next interrupt will occur at line no. 0

    ASL $D019            ; acknowledge the interrupt by clearing the VIC's interrupt flag

    JMP $EA31            ; jump into KERNAL's standard interrupt service routine to handle keyboard scan, cursor display etc.


Irq2       
    LDA $D011             ; select bitmap screen mode
    ORA #%00100000
    STA $D011

    ; Turn on multcolor mode.
    lda $d016
    ora #$10
    sta $d016

    ; Set charset location.
    lda #$38
    sta $D018

    LDA #<Irq             ; set interrupt vectors back to the first interrupt service routine at Irq
    STA $0314
    LDA #>Irq
    STA $0315

    LDA #215
    STA $D012            ; next interrupt will occur at line no. 215

    ASL $D019            ; acknowledge the interrupt by clearing the VIC's interrupt flag

    JMP $EA81            ; jump into shorter ROM routine to only restore registers from the stack etc


div10:
    LDX #$11
    LDA #$00
    CLC
loop    ROL
    CMP #$0A
    BCC skip
    SBC #$0A
skip    ROL div_lo
    ROL div_hi
    DEX
    BNE loop
    RTS

div_lo  .byte
div_hi  .byte
