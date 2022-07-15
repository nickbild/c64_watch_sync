10 for i=0 to 511:poke i+8192,peek(i+4096):next i






lda #$ff
sta $dd00

VIC Bank #0, $0000-$3FFF, 0-16383.



lda #$3b
sta $d011

111011
bitmap mode



lda #$38
sta d018_vMemControl

111000
char mem: 100, 4: $2000-$27FF, 8192-10239
screen mem: %0011, 3: $0C00-$0FFF, 3072-4095.



lda #$18
sta $d016

11000
multicolor mode on

