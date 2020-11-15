.NOLIST
.INCLUDE"m128def.inc"
.LIST
.CSEG
.ORG 0x00 JMP DEFINICE
.ORG 0x1E JMP MAIN

.MACRO program				;podprogram pro zobrazení na 1 symbolu na displeji
LDI R23,@0					;definuji pozici
LDI R24,@1					;definuji znak
OUT PORTD,R23				;posílám údaje na porty
OUT PORTB,R24
CALL TIMER					;volám èasovaè
SEI							;pøerušení
.ENDMACRO

.MACRO funkce				;podprogram pro zobrazení na 3 symbolù na dispeji
LDI R20,0xFF				;nadefinování PORTB na výstupní
OUT DDRB,R20
program 0b11110000,@0		;3 èíslice na displeji => 3x podprogram na zobrazení 1 èíslice
program 0b11110100,@1
program 0b11111000,@2
JMP MAIN					;skoèí na zaèátek programu
.ENDMACRO

DEFINICE:				;zásobník
LDI R24,LOW(RAMEND)
OUT SPL,R24
LDI R24,HIGH(RAMEND)
OUT SPH,R24

LDI R20,0x00			;nadefinování portuB
OUT DDRB,R20
LDI R20,0xFF			;nadefinování portuD 
OUT DDRD,R20

MAIN:
LDI R20,0x0F
OUT DDRB,R20			;nadefinování PORTUB na vstupní
LDI R21,0xFE
OUT PORTB,R21				
CALL TIMER				;volání timeru
IN R22,PINB				;vstup z klávesnice
CPI R22,0xEE			;porovnání hodnot pøi stisku 1.tlaèítka
BREQ A					;skoèí na podprogram na zobrazení 010
CPI R22,0xDE			;porovnání hodnot pøi stisku 2.tlaèítka
BREQ B					;skoèí na podprogram na zobrazení 343
CPI R22,0xBE			;porovnání hodnot pøi stisku 3.tlaèítka
BREQ C					;skoèí na podprogram na zobrazení 676
JMP MAIN2
MAIN3:					;kontlola èísel na displeji
CPI R24,0b11000000		;010
BREQ A
CPI R24,0b10110000		;343
BREQ B
CPI R24,0b10000010		;676
BREQ C
JMP MAIN

A:																
funkce 0b11000000,0b11111001,0b11000000	;Zobrazí 010 na displeji
B:
funkce 0b10110000,0b10011001,0b10110000	;Zobrazí 343 na displeji
C:
funkce 0b10000010,0b11111000,0b10000010	;Zobrazí 676 na displeji
MAIN2:										;nulování hodnot na displeji
CPI R22,0x7E								;kontrola jestli je tlaèítko * stisklé
BREQ D
CPI R24,0b11111111
BREQ D
JMP MAIN3
D:											
LDI R20,0xFF								;nadefinuji PORTB na výstupní
OUT DDRB,R20
program 0b11110000,0b11111111				;nastavuji prázdné pole na displeji
JMP MAIN

TIMER:						;èasovaè 1ms
   	LDI R16,0
    LDI  r25, 21
	OUT TCCR1A,R16
    LDI R16,0b11111111
	LDI  r26, 199
	L1: DEC  r26
    BRNE L1
    DEC  r25
    BRNE L1
    OUT TCCR1B,R16
    LDI R21,0x7B
    LDI R22,0x0C
    OUT OCR1AL,R22
    OUT OCR1AH,R21
    LDI R16,0b00010000
    OUT TIMSK,R16
RET

