.NOLIST
.INCLUDE "m128def.inc"
.LIST
.CSEG

LDI R24,LOW(RAMEND)			;po p��kazu RET o jeden ��dek pod CALL
OUT SPL,R24
LDI R24,HIGH(RAMEND)
OUT SPH,R24

LDI R16,0xFF
OUT DDRB,R16				;nadefinuju si vstup B
LDI R17,0xFF
OUT DDRE,R17				;nadefinuju si vstup E
LDI R18,0b11110011			;1.segmentov� displej

main:
LDI R19,0b11111001			;��slice 1
OUT PORTE,R18				;ode�lu �daje R18 na portE
OUT PORTB,R19				;ode�lu �daje R19 na portB
LDI R18,0b11110111			;2.segmentov� displej

CALL timer1					;zavol�m zpo�d�n�1

LDI R19,0b10100100			;��slice 2
OUT PORTE,R18				;ode�lu �daje R18 na portE
OUT PORTB,R19				;ode�lu �daje R19 na portB
LDI R18,0b11111011			;3.segmentov� displej

CALL timer1					;zavol�m zpo�d�n�1

LDI R19,0b10110000			;��slice 3
OUT PORTE,R18				;ode�lu �daje R18 na portE
OUT PORTB,R19				;ode�lu �daje R19 na portB
LDI R18,0b11111111			;4.segmentov� displej

CALL timer1					;zavol�m zpo�d�n�1

LDI R19,0b10011001			;��slice 4
OUT PORTE,R18				;ode�lu �daje R18 na portE
OUT PORTB,R19				;ode�lu �daje R19 na portB
LDI R18,0b11110011			;1.segmentov� displej

CALL timer1					;zavol�m zpo�d�n�1

LDI R19,0b10010010			;��slice 5
OUT PORTE,R18				;ode�lu �daje R18 na portE
OUT PORTB,R19				;ode�lu �daje R19 na portB
LDI R18,0b11110111			;2.segmentov� displej

CALL timer2					;zavol�m zpo�d�n�2

LDI R19,0b10000010			;��slice 6
OUT PORTE,R18				;ode�lu �daje R18 na portE
OUT PORTB,R19				;ode�lu �daje R19 na portB
LDI R18,0b11111011			;3.segmentov� displej

CALL timer2					;zavol�m zpo�d�n�2

LDI R19,0b11111000			;��slice 7
OUT PORTE,R18				;ode�lu �daje R18 na portE
OUT PORTB,R19				;ode�lu �daje R19 na portB
LDI R18,0b11111111			;4.segmentov� displej

CALL timer2					;zavol�m zpo�d�n�2

LDI R19,0b10000000			;��slice 8
OUT PORTE,R18				;ode�lu �daje R18 na portE
OUT PORTB,R19				;ode�lu �daje R19 na portB
LDI R18,0b11110011			;1.segmentov� displej

CALL timer2					;zavol�m zpo�d�n�2
BRNE main					;konec hlavn�ho programu

timer1:						;zpo�d�n� 500ms
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

timer2:						;zpo�d�n� 1s
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

    
