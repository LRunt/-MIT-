.NOLIST
.INCLUDE"m128def.inc"
.LIST
.CSEG
.ORG 0x00 JMP DEFINICE
.ORG 0x1E JMP MAIN

.MACRO program				;podprogram pro zobrazen� na 1 symbolu na displeji
LDI R23,@0					;definuji pozici
LDI R24,@1					;definuji znak
OUT PORTD,R23				;pos�l�m �daje na porty
OUT PORTB,R24
CALL TIMER					;vol�m �asova�
SEI							;p�eru�en�
.ENDMACRO

.MACRO funkce				;podprogram pro zobrazen� na 3 symbol� na dispeji
LDI R20,0xFF				;nadefinov�n� PORTB na v�stupn�
OUT DDRB,R20
program 0b11110000,@0		;3 ��slice na displeji => 3x podprogram na zobrazen� 1 ��slice
program 0b11110100,@1
program 0b11111000,@2
JMP MAIN					;sko�� na za��tek programu
.ENDMACRO

DEFINICE:				;z�sobn�k
LDI R24,LOW(RAMEND)
OUT SPL,R24
LDI R24,HIGH(RAMEND)
OUT SPH,R24

LDI R20,0x00			;nadefinov�n� portuB
OUT DDRB,R20
LDI R20,0xFF			;nadefinov�n� portuD 
OUT DDRD,R20

MAIN:
LDI R20,0x0F
OUT DDRB,R20			;nadefinov�n� PORTUB na vstupn�
LDI R21,0xFE
OUT PORTB,R21				
CALL TIMER				;vol�n� timeru
IN R22,PINB				;vstup z kl�vesnice
CPI R22,0xEE			;porovn�n� hodnot p�i stisku 1.tla��tka
BREQ A					;sko�� na podprogram na zobrazen� 010
CPI R22,0xDE			;porovn�n� hodnot p�i stisku 2.tla��tka
BREQ B					;sko�� na podprogram na zobrazen� 343
CPI R22,0xBE			;porovn�n� hodnot p�i stisku 3.tla��tka
BREQ C					;sko�� na podprogram na zobrazen� 676
JMP MAIN2
MAIN3:					;kontlola ��sel na displeji
CPI R24,0b11000000		;010
BREQ A
CPI R24,0b10110000		;343
BREQ B
CPI R24,0b10000010		;676
BREQ C
JMP MAIN

A:																
funkce 0b11000000,0b11111001,0b11000000	;Zobraz� 010 na displeji
B:
funkce 0b10110000,0b10011001,0b10110000	;Zobraz� 343 na displeji
C:
funkce 0b10000010,0b11111000,0b10000010	;Zobraz� 676 na displeji
MAIN2:										;nulov�n� hodnot na displeji
CPI R22,0x7E								;kontrola jestli je tla��tko * stiskl�
BREQ D
CPI R24,0b11111111
BREQ D
JMP MAIN3
D:											
LDI R20,0xFF								;nadefinuji PORTB na v�stupn�
OUT DDRB,R20
program 0b11110000,0b11111111				;nastavuji pr�zdn� pole na displeji
JMP MAIN

TIMER:						;�asova� 1ms
   	LDI R16,0
    LDI  r25, 21
	OUT TCCR1A,R16
    LDI R16,0b11111111
	LDI  r26, 199
	L1: DEC  r26
    BRNE L1
    DEC  r25
    BRNE L1
    OUT TCCR1B,R16
    LDI R21,0x7B
    LDI R22,0x0C
    OUT OCR1AL,R22
    OUT OCR1AH,R21
    LDI R16,0b00010000
    OUT TIMSK,R16
RET

