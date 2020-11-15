.NOLIST
.INCLUDE "m128def.inc"
.LIST
.CSEG

.MACRO test_sloupce
LDI R21,@0				;aktivuji sloupec
OUT PORTB,R21			;posílám hodnotu na PORTB
CALL DELAY				;volám zpoždìní, bez zpoždìní nefungovalo správnì
IN R19, PINB			;naèítám hodnotu z PINUB
CALL DELAY				;volám programové zpozdeni 5*1ms (nezbyly registry)
CALL DELAY
CALL DELAY
CALL DELAY
CALL DELAY
.ENDMACRO

.MACRO test_radku
CALL V2				;volám výstup bez zmìny
CPI R19,@0			;podmínka
BREQ @2
RJMP @1				;pri nesplneni podmínky skoèí na další test øádku
.ENDMACRO

.MACRO znak
LDI R17,@0			;ukládám symbol, který se zobrazí na displeji
CALL V1				;skoèí na výstup se zmìnou
.ENDMACRO		
	
LDI R16,LOW(RAMEND)
OUT SPL,R16
LDI R16,HIGH(RAMEND)          ;vrací se po RET na øádek pod call
OUT SPH,R16

LDI R20,0x0F
OUT DDRB,R20		;nadefinuji si port B
LDI R20,0xFF
OUT DDRD,R20		;nadefinuji si port D
LDI R18, 0xFF		;definuji hodnoty, aby se pøi druhém spuštìní nezobrazila na displeji èíslice z pøedchozího spuštìní  
LDI R22, 0xFF	 
LDI R27, 0xFF		
LDI R28, 0xFF

sloupec1:
test_sloupce 0xFE			;zkouším shodu s 1.sloupcem
	A:
test_radku 0b11101110,B,A1	;zkouším shodu s 1.øádkem
	A1:
znak 0b11111001				;èíslice 1
	B:
test_radku 0b11011110,C,B1	;zkouším shodu s 2.øádkem
	B1:
znak 0b10011001				;èíslice 4
	C:
test_radku 0b10111110,sloupec2,C1	;zkouším shodu s 3.øádkem
	C1:
znak 0b11111000				;èíslice 7

sloupec2:					;zkouším shodu s 2.sloupcem
test_sloupce 0xFD					
	D:
test_radku 0b11101101,E,D1	;zkouším shodu s 1.øádkem
	D1:
znak 0b10100100				;èíslice 2
	E:
test_radku 0b11011101,F,E1	;zkouším shodu s 2.øádkem
	E1:
znak 0b10010010				;èíslice 5
	F:
test_radku 0b10111101,G,F1	;zkouším shodu s 3.øádkem
	F1:
znak 0b10000000				;èíslice 8
	G:
test_radku 0b01111101,sloupec3,G1	;zkouším shodu s 4.øádkem
	G1:
znak 0b11000000				;èíslice 0

sloupec3:					;zkouším shodu s 3.sloupcem
test_sloupce 0xFB
	H:
test_radku 0b11101011,I,H1	;zkouším shodu s 1.øádkem
	H1:
znak 0b10110000				;èíslice 3
	I:
test_radku 0b11011011,J,I1	;zkouším shodu s 2.øádkem
	I1:
znak 0b10000010				;èíslice 6
	J:
test_radku 0b10111011,V1,J1	;zkouším shodu s 3.øádkem
	J1:
znak 0b10010000				;èíslice 9
	
V1:							;zmìna èísel v registrech, posouvám o 1 dozadu
	LDI R28, 0
	MOV R28, R27   		
	MOV R27, R22		
	MOV R22, R18
	MOV R18, R17
	CALL V2

V2:
	LDI R20, 0xFF		
	OUT DDRB, R20
	LDI R29, 0b11010011		;pozice na segmentovém displeji
	OUT PORTD, R29			;posílám R29 na PORT D
	OUT PORTB, R18			;posílám R18 na PORT B
	CALL DELAY				;volám zpoždìní
	LDI R29, 0b11010111
	OUT PORTD, R29
	OUT PORTB, R22
	CALL DELAY
	LDI R29, 0b11011011
	OUT PORTD, R29
	OUT PORTB, R27
	CALL DELAY
	LDI R29, 0b11011111
	OUT PORTD, R29
	OUT PORTB, R28
	CALL DELAY
	LDI R20, 0x0F
	OUT DDRB, R20
	LDI R29, 0
	OUT PORTD, R29
	CALL DELAY
	RET

	DELAY:
	LDI  R24, 21      ;programove zpozdení 1ms
   	LDI  R23, 199
L1: DEC  R23
   	BRNE L1
   	DEC  R24
  	BRNE L1
   	RET
RET

