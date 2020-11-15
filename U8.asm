.NOLIST
.INCLUDE "m128def.inc"
.LIST
.CSEG

LDI R24,LOW(RAMEND)			;po pr�kazu CALL o 1 ��dek n�
OUT SPL,R24
LDI R24,HIGH(RAMEND)
OUT SPH,R24

LDI R16,0b11111111			;nadefinov�n� v�stupu		
OUT DDRB,R16

LDI R16,0b00000000			;nadefinov�n� vstupu
OUT DDRE,R16
main:						;hlavn� program
IN R16,PINE					;vsupuje sign�l z tla��tek

LDI R18,0x7E				;nadefinuji kombinaci tla��tek
CP R16,R18					;porovn�v�m polohu tla��tek s po�adovanou kombinac�
BREQ funkce1a				;kdy� se R16=R18 vol�m funkci
LDI R18,0xBE				;nadefinuji kombinaci tla��tek
CP R16,R18					;porovn�v�m polohu tla��tek s po�adovanou kombinac�
BREQ funkce1b				;kdy� se R16=R18 vol�m funkci

LDI R18,0x7D				;nadefinuji kombinaci tla��tek
CP R16,R18					;porovn�v�m polohu tla��tek s po�adovanou kombinac�
BREQ funkce2a				;kdy� se R16=R18 vol�m funkci
LDI R18,0xBD				;nadefinuji kombinaci tla��tek
CP R16,R18					;porovn�v�m polohu tla��tek s po�adovanou kombinac�
BREQ funkce2b				;kdy� se R16=R18 vol�m funkci

JMP main2					;sko�� na hlavn� program 2. ��st

funkce1a:					;funkce 1 zpo�d�n� 500ms
	LDI R17,0x09			;kolikr�t se bude opakovat cyklusf1
    LDI R19,0x01			;definuji po��te�n� ��slo
    LDI R20,0x01			
cyklusf1:
    SUB R19,R20				;ode��t�m 1 od R19 tak aby bylo ��slo o 1 men�� a zhasla by jedna dioda
    MOV R16,R19				;p�esouv�m R18 do R16 aby jsem mohl mohl R18 zm�nit
    OUT PORTB,R16			;v�stup, rozsv�t� LED podle bin�rn�ho kodu
	CALL timer1				;zpo�d�n� 500ms
    ADD R19,R20				;+1 a� mohu pou��t posunuj� o 1 m�sto
    ROL R19					;zdvojn�sobuju R18
    DEC R17					;ub�r�m po�et opakov�n�
	BRNE cyklusf1			;konec cyklu kdy� R17=0
	JMP main				;zp�tky na hlavn� program

funkce1b:					;funkce 1 zpo�d�n� 1s
	LDI R17,0x09			;pro cyklus
    LDI R19,0x01			;definuji po��te�n� ��slo
    LDI R20,0x01			
cyklusf1b:
    SUB R19,R20				;ode��t�m 1 od R19 tak aby bylo ��slo o 1 men�� a zhasla by jedna dioda
    MOV R16,R19				;p�esouv�m R18 do R16 aby jsem mohl mohl R18 zm�nit
    OUT PORTB,R16			;v�stup, rozsv�t� LED podle bin�rn�ho kodu
	CALL timer2				;zpo�d�n� 1s
    ADD R19,R20				;+1 a� mohu pou��t posunuj� o 1 m�sto
    ROL R19					;zdvojn�sobuju R18
    DEC R17					;ub�r�m po�et opakov�n�
	BRNE cyklusf1b			;konec cyklu kdy� R17=0
	JMP main				;zp�tky na hlavn� program

funkce2a:					;funkce 2 zpo�d�n� 500ms
 	LDI R17,0x0F			;bin�rn� kombinace pro 1. polovina sv�t� 
	LDI R19,0xF0			;bin�rn� kombinace pro 2. polovina sv�t�
	OUT PORTB,R17			;v�stup
	CALL timer1				;zpo�d�n� 500ms
	OUT PORTB,R19			;v�stup
	CALL timer1				;zpo�d�n� 500ms
	JMP main				;zp�tky na hlavn� program
funkce2b:					;funkce2 zpo�d�n� 1s
 	LDI R17,0x0F			;bin�rn� kombinace pro 1. polovina sv�t� 
	LDI R19,0xF0			;bin�rn� kombinace pro 2. polovina sv�t� 
	OUT PORTB,R17			;v�stup
	CALL timer2				;zpo�d�n� 1s
	OUT PORTB,R19			;v�stup
	CALL timer2				;zpo�d�n� 1s
	JMP main				;zp�tky na hlavn� program

main2:						;hlavn� program ��st2
LDI R18,0x7B				;nadefinuji kombinaci tla��tek
CP R16,R18					;porovn�v�m polohu tla��tek s po�adovanou kombinac�
BREQ funkce3a				;kdy� se R16=R18 vol�m funkci
LDI R18,0xBB				;nadefinuji kombinaci tla��tek
CP R16,R18					;porovn�v�m polohu tla��tek s po�adovanou kombinac�
BREQ funkce3b				;kdy� se R16=R18 vol�m funkci

LDI R18,0x77				;nadefinuji kombinaci tla��tek
CP R16,R18					;porovn�v�m polohu tla��tek s po�adovanou kombinac�
BREQ funkce4a				;kdy� se R16=R18 vol�m funkci
LDI R18,0xB7				;nadefinuji kombinaci tla��tek
CP R16,R18					;porovn�v�m polohu tla��tek s po�adovanou kombinac�
BREQ funkce4b				;kdy� se R16=R18 vol�m funkci

LDI R18,0xFF				;definuji aby byly vs�chny LED zhasnut�			
OUT PORTB,R18				;v�stup
JMP main					;zp�tky na hlavn� program

funkce3a:					;funkce3 zpo�d�n� 500ms
	LDI R17,0xAA			;definuji bin�rn� kombinaci pro zapl� lich� LED
	LDI R19,0x55			;definuji bin�rn� kombinaci pro zapl� sud� LED
	OUT PORTB,R17			;v�stup
	CALL timer1				;zpo�d�n� 500ms
	OUT PORTB,R19			;v�stup
	CALL timer1				;zpo�d�n� 500ms
	JMP main				;zp�tky na hlavn� program
funkce3b:					;funkce3 zpo�d�n� 1s
	LDI R17,0xAA			;definuji bin�rn� kombinaci pro zapl� lich� LED
	LDI R19,0x55			;definuji bin�rn� kombinaci pro zapl� sud� LED
	OUT PORTB,R17			;v�stup
	CALL timer2				;zpo�d�n� 1s
	OUT PORTB,R19			;v�stup
	CALL timer2				;zpo�d�n�
	JMP main				;zp�tky na hlavn� program
	

funkce4a:					;funkce4 zpo�d�n� 500ms
	LDI R17,0xFF			;nadefinuji po��te�n� stav LED
	LDI R19,0x09			;nadefinuji po�et opakov�n�
cyklusf4:
	OUT PORTB,R17			;v�stup
	CALL timer1				;zpo�d�n� 500ms
	ROL R17					;zdvojn�sobuji
	DEC R19					;ub�r�m po�et opakov�n�
	BRNE cyklusf4			;konec cyklu kdy� R19=0
	JMP main				;zp�tky na hlavn� program

funkce4b:					;funkce4 zpo�d�n� 1s
	LDI R17,0xFF			;nadefinuji po��te�n� stav LED
	LDI R19,0x09			;nadefinuji po�et opakov�n�
cyklusf4b:
	OUT PORTB,R17			;v�stup
	CALL timer2				;zpo�d�n� 1s
	ROL R17					;zdojn�sobuji
	DEC R19					;ub�r�m po�et opakov�n�
	BRNE cyklusf4b			;konec cyklu kdy� R19=0
	JMP main				;zp�tky na hlavn� program
	

timer1:						;zpo�d�n� 500ms
	LDI  R21,0x29
    LDI  R22,0x96
    LDI  R23,0x80
L1: DEC  R23
    BRNE L1
    DEC  R22
    BRNE L1
    DEC  R21
    BRNE L1
RET

timer2:						;zpo�d�n� 1s
LDI  R21,0x52
LDI  R22,0x2B
LDI  R23,0x00
L2: DEC  R23
    BRNE L2
    DEC  R22
    BRNE L2
    DEC  R21
    BRNE L2
    LPM
    NOP
RET


KONEC:RJMP KONEC			;konec programu
