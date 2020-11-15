.NOLIST
.INCLUDE "m128def.inc"
.LIST
.CSEG

.MACRO program			;V programu se opakuje jeden "odstavec" pøíkazù, kde se jen mìní hodnoty, nahradím ho macrem
LDI R26,250				;250 opakování cyklu tj. 250*1ms=>250ms mezi kroky
@3:
LDI ZL,LOW(kombinace*2)		;naèítám z pamìti DB
LDI ZH,HIGH(kombinace*2)
LDI R22,@0				;poèet pozic které se naètou z DB
@1:
CP R26,R27				;porovnávám R26 a R27
BREQ @2					;když se R26=0 program pøeskoèí dále
LPM R18,Z+				;naèítám z DB pozici
LPM R19,Z+				;naèítám z DB písmeno
OUT PORTB,R19			;posílám písmeno na port
OUT PORTD,R18			;posílám pozici na port
CALL timer				;volám èasovaè
DEC R26					;snižuji poèet, v dalším cyklu se zkontroluje zda se R26=0 
DEC R22					;snižuji poèet opakování cyklu
BRNE @1					;konec cyklu
JMP @3					
.ENDMACRO

LDI R24,LOW(RAMEND)
OUT SPL,R24
LDI R24,HIGH(RAMEND)
OUT SPH,R24
LDI R16,0xFF			;definuji výstupní porty
OUT DDRB,R16
LDI R17,0xFF
OUT DDRD,R17			
LDI R27,0x00			;definuji R27 do podmínek
backf:
program 0x01,main1,A1,back				;Písmeno O 250ms
A1:
program 0x02,main2,B1,A					;Písmena OF 250ms
B1:
program 0x03,main3,C1,B					;Písmena OFF 250ms
C1:
program 0x04,main4,D1,C					;Písmena OFFI 250ms
D1:
program 0x05,main5,E1,D					;Písmena OFFIC 250ms
E1:
program 0x06,main6,F1,E					;Písmena OFFICI 250ms
F1:
program 0x07,main7,G1,F					;Písmena OFFICIA 250ms
G1:
program 0x08,main8,P1,G					;Písmena OFFICIAL 250ms
P1:
program 0x01,mein1,P2,P					;Písmeno O 500ms
P2:program 0x01,moin1,Q1,PA	
Q1:
program 0x02,mein2,Q2,Q					;Písmena OF 500ms
Q2:program 0x02,moin2,RA,QA	
RA:
program 0x03,mein3,RB,R					;Písmena OFF 500ms
RB:program 0x03,moin3,S1,RC	
S1:
program 0x04,mein4,S2,S					;Písmena OFFI 500ms
S2:program 0x04,moin4,T1,SA	
T1:
program 0x05,mein5,T2,T					;Písmena OFFIC 500ms
T2:program 0x05,moin5,U1,TA	
U1:
program 0x06,mein6,U2,U					;Písmena OFFICI 500ms
U2:program 0x06,moin6,V1,UA	
V1:
program 0x07,mein7,V2,V					;Písmena OFFICIA 500ms
V2:program 0x07,moin7,W1,VA	
W1:
program 0x08,mein8,W2,W					;Písmena OFFICIAL 500ms
W2:program 0x08,moin8,F10,WA	
F10:
JMP backf								;Zpátky na zaèátek

timer:
LDI R23,0b00000111	;definuji údaje potøebné pro èasovaè
OUT TCCR0,R23
LDI R24,250
OUT OCR0,R24
LDI R25,2
LDI R27,1
LDI R20, 21
LDI R21, 199

delay:				;èasovaè
IN R15,TIFR
CP R15,R25
BREQ delay
OUT TIFR,R25
DEC R27 
BRNE delay
L1: DEC  r21
    BRNE L1
    DEC  r20
    BRNE L1
RET

KONEC:RJMP KONEC

kombinace:.DB 0b11110011,0b11111100,0b11110010,0b10001110,0b11110001,0b10001110,0b11110000,0b01100000,0b11110100,0b10011100,0b11110101,0b01100000,0b11110110,0b11101110,0b11110111,0b00011100

