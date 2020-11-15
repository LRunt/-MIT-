.NOLIST
.INCLUDE "m128def.inc"
.LIST
.CSEG

.MACRO otocka		;podprogram na 2 oto�ky
LDI R21,50			;50 opakov�n� (50*4=200krok�)
@0:
LDI ZL,LOW(@2*2)	
LDI ZH,HIGH(@2*2)
LDI R18,0x04		;po�et na��tan�ch hodnot
@1:
LPM R19,Z+			;na�ti hodnotu
OUT PORTB,R19		;po�li na port
CALL @3				;vol�m zpo�d�n�
DEC R18				;sni�uji po�et opakov�n� na��t�n� hodnot
BRNE @1				
DEC R21				;sni�uji po�et opakov�n�
BRNE @0
.ENDMACRO


LDI R24,LOW(RAMEND)		;z�sobn�k
OUT SPL,R24
LDI R24,HIGH(RAMEND)
OUT SPH,R24

MAIN:
LDI R16,0b00000101
LDI R17,0b00001111				
OUT DDRB,R17					;nadefinov�n� PORTUB
otocka MAIN1,A,leva,DELAY1		;oto�ka doleva,rychlost kroku 16ms
otocka MAIN2,B,prava,DELAY1		;oto�ka doprava, rychlost kroku 16ms
otocka MAIN3,C,leva,DELAY2		;oto�ka doleva, rychlost kroku 32ms
otocka MAIN4,D,prava,DELAY2		;oto�ka doprava, rychlost kroku 32ms
JMP MAIN						;sko� na za��tek

DELAY1:							;zpo�d�n� 16ms
 ldi  r25, 2
    ldi  r26, 77
    ldi  r27, 117
L1: dec  r27
    brne L1
    dec  r26
    brne L1
    dec  r25
    brne L1
    nop
RET

DELAY2:							;zpo�d�n� 32ms
ldi  r25, 3
    ldi  r26, 112
    ldi  r27, 93
L2: dec  r27
    brne L2
    dec  r26
    brne L2
    dec  r25
    brne L2
    nop
RET

leva: .DB 0x01,0x04,0x02,0x08
prava: .DB 0x08,0x02,0x04,0x01
