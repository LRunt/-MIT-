.NOLIST
.INCLUDE "m128def.inc"
.LIST
.CSEG
.ORG 0x0000 JMP DEFINICE
.ORG 0x0018 JMP TLACITKO
 
DEFINICE:					;definuji zásobník, vstup a výstup
    LDI R16,LOW(RAMEND)
    OUT SPL,R16
    LDI R16,HIGH(RAMEND)
    OUT SPH,R16				;definice zásobníku 
 
    LDI R16,0x00
    OUT DDRE,R16			;definice vstupu
    LDI R16,0xFF
    OUT DDRB,R16			;definice výstupu
 
ON:
    CALL TIMER				;volám èasovaè
    SEI						;pøerušení
    LDI R16,0b01111111		;rozsvítím 1.LEDku
    OUT PORTB,R16			
VYJIMKA:
    LDI R23,0				;pomocná promìnná
    CALL TIMER				;volám èasovaè
    SEI						;pøerušení
    CBI PORTB,7				;nastavuji na 7.bit 0
ON1:
    CPI R23,1				;porovnávám
    BREQ OFF				;když se R23=1, skoèí na OFF
    JMP ON1					;když se R23 nerovná 1, skoèí zpìt na ON1
 
OFF:
    CALL TIMER				;volám èasovaè
    SEI						;pøerušení
	LDI R28,0xFF			;definuji registr R28
	OUT PORTB,R28			;posílám na portB
    SBI PORTB,7				;nastavuji na 7. bit 1
OFF1:
    CPI R23,2				;porovnávám
    BREQ VYJIMKA			;když se R23=2, skoèí na VYJIMKA
    JMP OFF1				;když se R23 nerovná 2, skoèí zpìt na OFF1;

TLACITKO:
    INC R23					;incrementuji R23		
    IN R17,PINE				;naèítám hodnotu z tlaèítek
    CPI R17,0b11111110		;porovnávám
    BRNE K1					
    BREQ K2
K1:
    SBI PORTB,6				;nastavuji na 6.bit 1
    JMP K3					;skoèí na K3
K2:
    CBI PORTB,6				;nastavuji na 6.bit 0
	LDI R28,0x3F			;definuji registr R28
	OUT PORTB,R28			;posílám na portB
K3:
    RETI 
 
TIMER:						;èasovaè
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
