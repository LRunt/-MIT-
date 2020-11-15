.NOLIST
.INCLUDE "m128def.inc"
.LIST
.CSEG
.MACRO program			;podprogram na rozsvícení písmena na displeji
LDI R22,@0				;Definuji písmeno ,které se zobrazí na displeji
LDI R23,@1				;definuji pozici, na které se zobrazí písmeno
OUT PORTD,R22			;odesílám informace na port
OUT PORTB,R23			;odesílám informace na port
RET
.ENDMACRO

.MACRO porovnani		;podprogram na zjištìní, které tlaèítko je stisklé
LDI R21,@0				;definuji kombinaci tlaèítka, které chci porovnávat
CP R21,R18				;Porovnávám, jestli není tlaèítko x spuštìné
BREQ @1					;kdy je tlaèítko stisknuto, program pøeskoèí na podprogram na rozsvícení písmena na displeji
.ENDMACRO

LDI R24,LOW(RAMEND)
OUT SPL,R24
LDI R24,HIGH(RAMEND)
OUT SPH,R24
LDI R16,0xFF			;definuji vıstupní porty
OUT DDRB,R16
LDI R17,0xFF
OUT DDRD,R17			
LDI R18,0x00			;definuji vstupní port
OUT DDRE,R18
LDI R20,0xFD

Main:
IN R18,PINE				;vstup z tlaèítek
porovnani 0xFE,A		;zjišuje, zde je tlaèítko 1 stisklé
porovnani 0xFD,B		;zjišuje, zde je tlaèítko 2 stisklé
porovnani 0xFB,C		;zjišuje, zde je tlaèítko 3 stisklé
porovnani 0xF7,D		;zjišuje, zde je tlaèítko 4 stisklé
porovnani 0xEF,E		;zjišuje, zde je tlaèítko 5 stisklé
porovnani 0xDF,F		;zjišuje, zde je tlaèítko 6 stisklé
porovnani 0xBF,G		;zjišuje, zde je tlaèítko 7 stisklé
porovnani 0x7F,H		;zjišuje, zde je tlaèítko 8 stisklé
JMP main
A:
program 0b11110011,0b11111100	;Na 1. displeji se zobrazí O
B:
program 0b11110010,0b10001110	;Na 2. displeji se zobrazí F
C:
program 0b11110001,0b10001110	;Na 3. displeji se zobrazí F
D:
program 0b11110000,0b01100000	;Na 4. displeji se zobrazí I
E:
program 0b11110100,0b10011100	;Na 5. displeji se zobrazí C
F:
program 0b11110101,0b01100000	;Na 6. displeji se zobrazí I
G:
program 0b11110110,0b11101110	;Na 7. displeji se zobrazí A
H:
program 0b11110111,0b00011100	;Na 8. displeji se zobrazí L
