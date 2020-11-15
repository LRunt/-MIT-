.NOLIST
.INCLUDE "m128def.inc"
.LIST
.CSEG

.MACRO test_sloupce
LDI R21,@0				;aktivuji sloupec
OUT PORTB,R21			;pos�l�m hodnotu na PORTB
CALL DELAY				;vol�m zpo�d�n�, bez zpo�d�n� nefungovalo spr�vn�
IN R19, PINB			;na��t�m hodnotu z PINUB
CALL DELAY				;vol�m programov� zpozdeni 5*1ms (nezbyly registry)
CALL DELAY
CALL DELAY
CALL DELAY
CALL DELAY
.ENDMACRO

.MACRO test_radku
CALL V2				;vol�m v�stup bez zm�ny
CPI R19,@0			;podm�nka
BREQ @2
RJMP @1				;pri nesplneni podm�nky sko�� na dal�� test ��dku
.ENDMACRO

.MACRO znak
LDI R17,@0			;ukl�d�m symbol, kter� se zobraz� na displeji
CALL V1				;sko�� na v�stup se zm�nou
.ENDMACRO		
	
LDI R16,LOW(RAMEND)
OUT SPL,R16
LDI R16,HIGH(RAMEND)          ;vrac� se po RET na ��dek pod call
OUT SPH,R16

LDI R20,0x0F
OUT DDRB,R20		;nadefinuji si port B
LDI R20,0xFF
OUT DDRD,R20		;nadefinuji si port D
LDI R18, 0xFF		;definuji hodnoty, aby se p�i druh�m spu�t�n� nezobrazila na displeji ��slice z p�edchoz�ho spu�t�n�  
LDI R22, 0xFF	 
LDI R27, 0xFF		
LDI R28, 0xFF

sloupec1:
test_sloupce 0xFE			;zkou��m shodu s 1.sloupcem
	A:
test_radku 0b11101110,B,A1	;zkou��m shodu s 1.��dkem
	A1:
znak 0b11111001				;��slice 1
	B:
test_radku 0b11011110,C,B1	;zkou��m shodu s 2.��dkem
	B1:
znak 0b10011001				;��slice 4
	C:
test_radku 0b10111110,sloupec2,C1	;zkou��m shodu s 3.��dkem
	C1:
znak 0b11111000				;��slice 7

sloupec2:					;zkou��m shodu s 2.sloupcem
test_sloupce 0xFD					
	D:
test_radku 0b11101101,E,D1	;zkou��m shodu s 1.��dkem
	D1:
znak 0b10100100				;��slice 2
	E:
test_radku 0b11011101,F,E1	;zkou��m shodu s 2.��dkem
	E1:
znak 0b10010010				;��slice 5
	F:
test_radku 0b10111101,G,F1	;zkou��m shodu s 3.��dkem
	F1:
znak 0b10000000				;��slice 8
	G:
test_radku 0b01111101,sloupec3,G1	;zkou��m shodu s 4.��dkem
	G1:
znak 0b11000000				;��slice 0

sloupec3:					;zkou��m shodu s 3.sloupcem
test_sloupce 0xFB
	H:
test_radku 0b11101011,I,H1	;zkou��m shodu s 1.��dkem
	H1:
znak 0b10110000				;��slice 3
	I:
test_radku 0b11011011,J,I1	;zkou��m shodu s 2.��dkem
	I1:
znak 0b10000010				;��slice 6
	J:
test_radku 0b10111011,V1,J1	;zkou��m shodu s 3.��dkem
	J1:
znak 0b10010000				;��slice 9
	
V1:							;zm�na ��sel v registrech, posouv�m o 1 dozadu
	LDI R28, 0
	MOV R28, R27   		
	MOV R27, R22		
	MOV R22, R18
	MOV R18, R17
	CALL V2

V2:
	LDI R20, 0xFF		
	OUT DDRB, R20
	LDI R29, 0b11010011		;pozice na segmentov�m displeji
	OUT PORTD, R29			;pos�l�m R29 na PORT D
	OUT PORTB, R18			;pos�l�m R18 na PORT B
	CALL DELAY				;vol�m zpo�d�n�
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
	LDI  R24, 21      ;programove zpozden� 1ms
   	LDI  R23, 199
L1: DEC  R23
   	BRNE L1
   	DEC  R24
  	BRNE L1
   	RET
RET

