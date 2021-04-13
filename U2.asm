.NOLIST                        
.INCLUDE  "m128def.inc"        
.LIST                        
.CSEG                 	;nadefinov�n� hodnot bloku 1
    LDI XL,0x00        
    LDI XH,0x01        	;po��te�n� hodnota na  
    LDI R20,0x01    	;velikost po��te�n� hodnoty    
    LDI R19,0x02    	;o kolik se bude hodnota zv�t�ovat    
    LDI R18,0x0A    	;po�et hodnot
blok1:                	;pln�n� 1. bloku pam�ti
    ST X+,R20        	;ulo�en� do registru
    ADD R20,R19        	;sou�et hodnoty R20 a R19    
    DEC R18            	;ubr�n� jednoho opakov�n�
    BRNE blok1        	;konec pln�n� bloku 1
                    	;nadefinov�n� hodnot bloku 2
    LDI YL,0x1E        
    LDI YH,0x01        	;po��te�n� hodnota na   
    LDI R20,0x03    	;velikost po��te�n� hodnoty    
    LDI R19,0x05    	;o kolik se bude hodnota zv�t�ovat    
    LDI R18,0x08    	;po�et hodnot
blok2:                	;pln�n� 2. bloku pam�ti
    ST Y+,R20        	;ulo�en� do registru
    ADD R20,R19      	;sou�et hodnoty R20 a R19    
    DEC R18            	;ubr�n� jednoho opakov�n�
    BRNE blok2        	;konec pln�n� bloku 2
                    	;nadefinov�n� hodnot bloku 3
    LDI ZL,0x3C        
    LDI ZH,0x01        	;po��te�n� hodnota na   
    LDI R20,0x0A    	;velikost po��te�n� hodnoty    
    LDI R19,0x08    	;o kolik se bude hodnota zv�t�ovat    
    LDI R18,0x10    	;po�et hodnot
blok3:                	;pln�n� 3. bloku pam�ti
    ST Z+,R20        	;+1 a ulo�en� do registru
    ADD R20,R19      	;so�et hodnoty R20 a R19    
    DEC R18            	;ubr�n� jenoho opakov�n�
    BRNE blok3        	;konec pln�n� bloku 3

    LDI XL,0x3C        
    LDI XH,0x01        	;po��te�n� hodnota    
    LDI R20,0x01    	;velikost po��te�n� hodnoty    
    LDI R19,0x02    	;o kolik se bude hodnota zv�t�ovat    
    LDI R18,0x0A    	;po�et hodnot
presunblok1:            ;p�esov�n� 1. bloku
    ST X+,R20        	;ulo�en� do registru
    ADD R20,R19        	;sou�et hodnoty R20 a R19    
    DEC R18            	;ubr�n� jednoho opakov�n�
    BRNE presunblok1	;konec p�esov�n� bloku 1
						;nahrazen� ostatn�ch ��slic ��slem FF
	LDI XL,0x46
	LDI XH,0x01			;po��te�n� hodnota
	LDI R20,0xFF		;��slo kter� budu zapisovat FF d�l�m v AVR simulaci 1, kdyby jsem byl ve 2 zadal bych hodnotu 00
	LDI R18,0x06		;po�et ��sel k nahrazen�
prepis1:               
    ST X+,R20       	;zaps�n� do pam�ti
    DEC R18            	;odebr�n� jednoho opakov�n�
    BRNE prepis1	


	LDI YL,0x00        
    LDI YH,0x01        	;po��te�n� hodnota    
    LDI R20,0x03    	;velikost po��te�n� hodnoty    
    LDI R19,0x05    	;o kolik se bude hodnota zv�t�ovat    
    LDI R18,0x08    	;po�et hodnot
presunblok2:           	;p�esouv�n� 2. bloku pam�ti
    ST Y+,R20        	;ulo�en� do registru
    ADD R20,R19      	;sou�et hodnoty R20 a R19    
    DEC R18            	;odebr�n� jednoho opakov�n�
    BRNE presunblok2    ;konec p�esouv�n� bloku 2

	LDI YL,0x08
	LDI YH,0x01			;po��te�n� hodnota
	LDI R20,0xFF		;Prepisov�n� hodnotou FF
	LDI R18,0x02		;po�et p�episovan�ch ��slic
prepis2:               
    ST Y+,R20       	;zaps�n� do pam�ti
    DEC R18            	;odebr�n� jednoho opakov�n�
    BRNE prepis2	

	LDI ZL,0x1E        
    LDI ZH,0x01        	;po��te�n� hodnota    
    LDI R20,0x0A    	;velikost po��te�n� hodnoty    
    LDI R19,0x08    	;o kolik se bude hodnota zv�t�ovat    
    LDI R18,0x10    	;po�et hodnot
presunblok3:            ;p�esouv�n� 3. bloku
    ST Z+,R20        	;ulo�en� do registru
    ADD R20,R19      	;sou�et hodnoty R20 a R19    
    DEC R18            	;odebr�n� jednoho opakov�n�
    BRNE presunblok3    ;konec p�esouv�n� bloku 3

	 
    KONEC:RJMP KONEC	;konec programu
