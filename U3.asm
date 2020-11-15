.NOLIST                        
.INCLUDE  "m128def.inc"        
.LIST   
.CSEG
	LDI XL,0x04				;adresa ukl�d�n� cisla1 z programu
	LDI XH,0x01
	LDI R20,0x04			;po�et opakov�n�
	LDI ZL,LOW(cislo1*2)	
	LDI ZH,HIGH(cislo1*2)
nacteni1:
	LPM R21,Z		;na�tu cislo1 z programu
	ST -X,R21		;ulo�im byt do dat a sn��m adresu 
	ST Z+,R21		;dal�� byt v programu
	DEC R20			;sn��m po�et opakov�n�
	BRNE nacteni1	;konec cyklu na�ten�
	
	LDI YL,0x0E				;adresa ukl�d�n� cisla2 z programu
	LDI YH,0x01
	LDI ZL,LOW(cislo2*2)
	LDI ZH,HIGH(cislo2*2)
	LDI R20,0x04			;po�et opakov�n�
nacteni2:
	LPM R22,Z		;na�tu cislo2 z programu
	ST -Y,R22		;ulo��m byt do dat a sn��m adresu
	ST Z+,R22		;dal�� byt v programu
	DEC R20			;sn��m po�et opakov�n�
	BRNE nacteni2	;konec cyklu na�ten�

	LDI R20,0x05;po�et opakov�n�
	LDI XL,0x04	;adresa kam se bude ukl�dat cislo1
	LDI XH,0x01
	LDI YL,0x0E	;adresa kam se bude ukl�dat cislo2
	LDI YH,0x01	
	LDI ZL,0x19	;adresa kam se bude ukl�dat v�sledek
	LDI ZH,0x01 
vypocet:
	LD R10,-X	;na��t�m cislo1
	LD R11,-Y	;na��t�m cislo2
	ADC R10,R11	;se�tu ��sla s funkc� carry
	ST -Z,R10	;sn��m hodnotu ukl�d�n� v�sledku
	CLR R10		;vy�ist�m ji� ulo�en� v�sledek
	DEC R20		;sn��m po�et opakov�n�
	BRNE vypocet;konec cyklu vypoctu

cislo1: .DB 0xFE,0x01,0xBB,0xAA;AABB01FE
cislo2: .DB 0xAA,0x93,0x02,0x88;880293AA

	KONEC:RJMP KONEC	;konec programu
