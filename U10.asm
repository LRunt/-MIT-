.NOLIST
.INCLUDE "m128def.inc"
.LIST
.CSEG
.MACRO program			;podprogram na rozsv�cen� p�smena na displeji
LDI R22,@0				;Definuji p�smeno ,kter� se zobraz� na displeji
LDI R23,@1				;definuji pozici, na kter� se zobraz� p�smeno
OUT PORTD,R22			;odes�l�m informace na port
OUT PORTB,R23			;odes�l�m informace na port
RET
.ENDMACRO

.MACRO porovnani		;podprogram na zji�t�n�, kter� tla��tko je stiskl�
LDI R21,@0				;definuji kombinaci tla��tka, kter� chci porovn�vat
CP R21,R18				;Porovn�v�m, jestli nen� tla��tko x spu�t�n�
BREQ @1					;kdy� je tla��tko stisknuto, program p�esko�� na podprogram na rozsv�cen� p�smena na displeji
.ENDMACRO

LDI R24,LOW(RAMEND)
OUT SPL,R24
LDI R24,HIGH(RAMEND)
OUT SPH,R24
LDI R16,0xFF			;definuji v�stupn� porty
OUT DDRB,R16
LDI R17,0xFF
OUT DDRD,R17			
LDI R18,0x00			;definuji vstupn� port
OUT DDRE,R18
LDI R20,0xFD

Main:
IN R18,PINE				;vstup z tla��tek
porovnani 0xFE,A		;zji��uje, zde je tla��tko 1 stiskl�
porovnani 0xFD,B		;zji��uje, zde je tla��tko 2 stiskl�
porovnani 0xFB,C		;zji��uje, zde je tla��tko 3 stiskl�
porovnani 0xF7,D		;zji��uje, zde je tla��tko 4 stiskl�
porovnani 0xEF,E		;zji��uje, zde je tla��tko 5 stiskl�
porovnani 0xDF,F		;zji��uje, zde je tla��tko 6 stiskl�
porovnani 0xBF,G		;zji��uje, zde je tla��tko 7 stiskl�
porovnani 0x7F,H		;zji��uje, zde je tla��tko 8 stiskl�
JMP main
A:
program 0b11110011,0b11111100	;Na 1. displeji se zobraz� O
B:
program 0b11110010,0b10001110	;Na 2. displeji se zobraz� F
C:
program 0b11110001,0b10001110	;Na 3. displeji se zobraz� F
D:
program 0b11110000,0b01100000	;Na 4. displeji se zobraz� I
E:
program 0b11110100,0b10011100	;Na 5. displeji se zobraz� C
F:
program 0b11110101,0b01100000	;Na 6. displeji se zobraz� I
G:
program 0b11110110,0b11101110	;Na 7. displeji se zobraz� A
H:
program 0b11110111,0b00011100	;Na 8. displeji se zobraz� L
