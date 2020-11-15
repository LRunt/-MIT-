.NOLIST
.INCLUDE "m128def.inc"
.LIST
.CSEG
.ORG 0x0000 JMP DEFINICE
.ORG 0x0018 JMP TLACITKO
 
DEFINICE:					;definuji z�sobn�k, vstup a v�stup
    LDI R16,LOW(RAMEND)
    OUT SPL,R16
    LDI R16,HIGH(RAMEND)
    OUT SPH,R16				;definice z�sobn�ku 
 
    LDI R16,0x00
    OUT DDRE,R16			;definice vstupu
    LDI R16,0xFF
    OUT DDRB,R16			;definice v�stupu
 
ON:
    CALL TIMER				;vol�m �asova�
    SEI						;p�eru�en�
    LDI R16,0b01111111		;rozsv�t�m 1.LEDku
    OUT PORTB,R16			
VYJIMKA:
    LDI R23,0				;pomocn� prom�nn�
    CALL TIMER				;vol�m �asova�
    SEI						;p�eru�en�
    CBI PORTB,7				;nastavuji na 7.bit 0
ON1:
    CPI R23,1				;porovn�v�m
    BREQ OFF				;kdy� se R23=1, sko�� na OFF
    JMP ON1					;kdy� se R23 nerovn� 1, sko�� zp�t na ON1
 
OFF:
    CALL TIMER				;vol�m �asova�
    SEI						;p�eru�en�
	LDI R28,0xFF			;definuji registr R28
	OUT PORTB,R28			;pos�l�m na portB
    SBI PORTB,7				;nastavuji na 7. bit 1
OFF1:
    CPI R23,2				;porovn�v�m
    BREQ VYJIMKA			;kdy� se R23=2, sko�� na VYJIMKA
    JMP OFF1				;kdy� se R23 nerovn� 2, sko�� zp�t na OFF1;

TLACITKO:
    INC R23					;incrementuji R23		
    IN R17,PINE				;na��t�m hodnotu z tla��tek
    CPI R17,0b11111110		;porovn�v�m
    BRNE K1					
    BREQ K2
K1:
    SBI PORTB,6				;nastavuji na 6.bit 1
    JMP K3					;sko�� na K3
K2:
    CBI PORTB,6				;nastavuji na 6.bit 0
	LDI R28,0x3F			;definuji registr R28
	OUT PORTB,R28			;pos�l�m na portB
K3:
    RETI 
 
TIMER:						;�asova�
    LDI R16,0
    OUT TCCR1A,R16
    LDI R16,0b00001100
    OUT TCCR1B,R16
    LDI R20,0x7B
    LDI R21,0x0C
    OUT OCR1AL,R21
    OUT OCR1AH,R20
    LDI R16,0b00010000
    OUT TIMSK,R16
    RET
