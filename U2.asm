.NOLIST                        
.INCLUDE  "m128def.inc"        
.LIST                        
.CSEG                 	;nadefinování hodnot bloku 1
    LDI XL,0x00        
    LDI XH,0x01        	;poèáteèní hodnota na  
    LDI R20,0x01    	;velikost poèáteèní hodnoty    
    LDI R19,0x02    	;o kolik se bude hodnota zvìtšovat    
    LDI R18,0x0A    	;poèet hodnot
blok1:                	;plnìní 1. bloku pamìti
    ST X+,R20        	;uložení do registru
    ADD R20,R19        	;souèet hodnoty R20 a R19    
    DEC R18            	;ubrání jednoho opakování
    BRNE blok1        	;konec plnìní bloku 1
                    	;nadefinování hodnot bloku 2
    LDI YL,0x1E        
    LDI YH,0x01        	;poèáteèní hodnota na   
    LDI R20,0x03    	;velikost poèáteèní hodnoty    
    LDI R19,0x05    	;o kolik se bude hodnota zvìtšovat    
    LDI R18,0x08    	;poèet hodnot
blok2:                	;plnìní 2. bloku pamìti
    ST Y+,R20        	;uložení do registru
    ADD R20,R19      	;souèet hodnoty R20 a R19    
    DEC R18            	;ubrání jednoho opakování
    BRNE blok2        	;konec plnìní bloku 2
                    	;nadefinování hodnot bloku 3
    LDI ZL,0x3C        
    LDI ZH,0x01        	;poèáteèní hodnota na   
    LDI R20,0x0A    	;velikost poèáteèní hodnoty    
    LDI R19,0x08    	;o kolik se bude hodnota zvìtšovat    
    LDI R18,0x10    	;poèet hodnot
blok3:                	;plnìní 3. bloku pamìti
    ST Z+,R20        	;+1 a uložení do registru
    ADD R20,R19      	;soèet hodnoty R20 a R19    
    DEC R18            	;ubrání jenoho opakování
    BRNE blok3        	;konec plnìní bloku 3

    LDI XL,0x3C        
    LDI XH,0x01        	;poèáteèní hodnota    
    LDI R20,0x01    	;velikost poèáteèní hodnoty    
    LDI R19,0x02    	;o kolik se bude hodnota zvìtšovat    
    LDI R18,0x0A    	;poèet hodnot
presunblok1:            ;pøesování 1. bloku
    ST X+,R20        	;uložení do registru
    ADD R20,R19        	;souèet hodnoty R20 a R19    
    DEC R18            	;ubrání jednoho opakování
    BRNE presunblok1	;konec pøesování bloku 1
						;nahrazení ostatních èíslic èíslem FF
	LDI XL,0x46
	LDI XH,0x01			;poèáteèní hodnota
	LDI R20,0xFF		;èíslo které budu zapisovat FF dìlám v AVR simulaci 1, kdyby jsem byl ve 2 zadal bych hodnotu 00
	LDI R18,0x06		;poèet èísel k nahrazení
prepis1:               
    ST X+,R20       	;zapsání do pamìti
    DEC R18            	;odebrání jednoho opakování
    BRNE prepis1	


	LDI YL,0x00        
    LDI YH,0x01        	;poèáteèní hodnota    
    LDI R20,0x03    	;velikost poèáteèní hodnoty    
    LDI R19,0x05    	;o kolik se bude hodnota zvìtšovat    
    LDI R18,0x08    	;poèet hodnot
presunblok2:           	;pøesouvání 2. bloku pamìti
    ST Y+,R20        	;uložení do registru
    ADD R20,R19      	;souèet hodnoty R20 a R19    
    DEC R18            	;odebrání jednoho opakování
    BRNE presunblok2    ;konec pøesouvání bloku 2

	LDI YL,0x08
	LDI YH,0x01			;poèáteèní hodnota
	LDI R20,0xFF		;Prepisování hodnotou FF
	LDI R18,0x02		;poèet pøepisovaných èíslic
prepis2:               
    ST Y+,R20       	;zapsání do pamìti
    DEC R18            	;odebrání jednoho opakování
    BRNE prepis2	

	LDI ZL,0x1E        
    LDI ZH,0x01        	;poèáteèní hodnota    
    LDI R20,0x0A    	;velikost poèáteèní hodnoty    
    LDI R19,0x08    	;o kolik se bude hodnota zvìtšovat    
    LDI R18,0x10    	;poèet hodnot
presunblok3:            ;pøesouvání 3. bloku
    ST Z+,R20        	;uložení do registru
    ADD R20,R19      	;souèet hodnoty R20 a R19    
    DEC R18            	;odebrání jednoho opakování
    BRNE presunblok3    ;konec pøesouvání bloku 3

	 
    KONEC:RJMP KONEC	;konec programu
