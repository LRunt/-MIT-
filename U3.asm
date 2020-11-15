.NOLIST                        
.INCLUDE  "m128def.inc"        
.LIST   
.CSEG
	LDI XL,0x04				;adresa ukládání cisla1 z programu
	LDI XH,0x01
	LDI R20,0x04			;poèet opakování
	LDI ZL,LOW(cislo1*2)	
	LDI ZH,HIGH(cislo1*2)
nacteni1:
	LPM R21,Z		;naètu cislo1 z programu
	ST -X,R21		;uložim byt do dat a snížím adresu 
	ST Z+,R21		;další byt v programu
	DEC R20			;snížím poèet opakování
	BRNE nacteni1	;konec cyklu naètení
	
	LDI YL,0x0E				;adresa ukládání cisla2 z programu
	LDI YH,0x01
	LDI ZL,LOW(cislo2*2)
	LDI ZH,HIGH(cislo2*2)
	LDI R20,0x04			;poèet opakování
nacteni2:
	LPM R22,Z		;naètu cislo2 z programu
	ST -Y,R22		;uložím byt do dat a snížím adresu
	ST Z+,R22		;další byt v programu
	DEC R20			;snížím poèet opakování
	BRNE nacteni2	;konec cyklu naètení

	LDI R20,0x05;poèet opakování
	LDI XL,0x04	;adresa kam se bude ukládat cislo1
	LDI XH,0x01
	LDI YL,0x0E	;adresa kam se bude ukládat cislo2
	LDI YH,0x01	
	LDI ZL,0x19	;adresa kam se bude ukládat výsledek
	LDI ZH,0x01 
vypocet:
	LD R10,-X	;naèítám cislo1
	LD R11,-Y	;naèítám cislo2
	ADC R10,R11	;seètu èísla s funkcí carry
	ST -Z,R10	;snížím hodnotu ukládání výsledku
	CLR R10		;vyèistím již uložený výsledek
	DEC R20		;snížím poèet opakování
	BRNE vypocet;konec cyklu vypoctu

cislo1: .DB 0xFE,0x01,0xBB,0xAA;AABB01FE
cislo2: .DB 0xAA,0x93,0x02,0x88;880293AA

	KONEC:RJMP KONEC	;konec programu
