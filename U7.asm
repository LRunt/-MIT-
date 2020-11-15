.NOLIST
.INCLUDE "m128def.inc"
.LIST
.CSEG

LDI R24,LOW(RAMEND)			;po pøíkazu RET o jeden øádek pod CALL
OUT SPL,R24
LDI R24,HIGH(RAMEND)
OUT SPH,R24

LDI R16,0xFF
OUT DDRB,R16				;nadefinuju si vstup B
LDI R17,0xFF
OUT DDRE,R17				;nadefinuju si vstup E
LDI R18,0b11110011			;1.segmentový displej

main:
LDI R19,0b11111001			;èíslice 1
OUT PORTE,R18				;odešlu údaje R18 na portE
OUT PORTB,R19				;odešlu údaje R19 na portB
LDI R18,0b11110111			;2.segmentový displej

CALL timer1					;zavolám zpoždìní1

LDI R19,0b10100100			;èíslice 2
OUT PORTE,R18				;odešlu údaje R18 na portE
OUT PORTB,R19				;odešlu údaje R19 na portB
LDI R18,0b11111011			;3.segmentový displej

CALL timer1					;zavolám zpoždìní1

LDI R19,0b10110000			;èíslice 3
OUT PORTE,R18				;odešlu údaje R18 na portE
OUT PORTB,R19				;odešlu údaje R19 na portB
LDI R18,0b11111111			;4.segmentový displej

CALL timer1					;zavolám zpoždìní1

LDI R19,0b10011001			;èíslice 4
OUT PORTE,R18				;odešlu údaje R18 na portE
OUT PORTB,R19				;odešlu údaje R19 na portB
LDI R18,0b11110011			;1.segmentový displej

CALL timer1					;zavolám zpoždìní1

LDI R19,0b10010010			;èíslice 5
OUT PORTE,R18				;odešlu údaje R18 na portE
OUT PORTB,R19				;odešlu údaje R19 na portB
LDI R18,0b11110111			;2.segmentový displej

CALL timer2					;zavolám zpoždìní2

LDI R19,0b10000010			;èíslice 6
OUT PORTE,R18				;odešlu údaje R18 na portE
OUT PORTB,R19				;odešlu údaje R19 na portB
LDI R18,0b11111011			;3.segmentový displej

CALL timer2					;zavolám zpoždìní2

LDI R19,0b11111000			;èíslice 7
OUT PORTE,R18				;odešlu údaje R18 na portE
OUT PORTB,R19				;odešlu údaje R19 na portB
LDI R18,0b11111111			;4.segmentový displej

CALL timer2					;zavolám zpoždìní2

LDI R19,0b10000000			;èíslice 8
OUT PORTE,R18				;odešlu údaje R18 na portE
OUT PORTB,R19				;odešlu údaje R19 na portB
LDI R18,0b11110011			;1.segmentový displej

CALL timer2					;zavolám zpoždìní2
BRNE main					;konec hlavního programu

timer1:						;zpoždìní 500ms
LDI  R20, 41
LDI  R21, 150
LDI  R22, 128
L1: DEC  R22
    BRNE L1
    DEC  R21
    BRNE L1
    DEC  R20
    BRNE L1
RET

timer2:						;zpoždìní 1s
LDI  R20, 82
LDI  R21, 43
LDI  R22, 0
L2: DEC  R22
    BRNE L2
    DEC  R21
    BRNE L2
    DEC  R20
    BRNE L2
    LPM
    NOP
RET

KONEC:RJMP KONEC			;konec programu

    
