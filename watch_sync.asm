    processor 6502

    org $C000            ; 49152


    jsr RasterInterruptInit
    rts

; MainLoop
;     jmp MainLoop


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
