.NOLIST
.INCLUDE "m128def.inc"
.LIST
.CSEG

LDI R24,LOW(RAMEND)			;po príkazu CALL o 1 øádek ní
OUT SPL,R24
LDI R24,HIGH(RAMEND)
OUT SPH,R24

LDI R16,0b11111111			;nadefinování vıstupu		
OUT DDRB,R16

LDI R16,0b00000000			;nadefinování vstupu
OUT DDRE,R16
main:						;hlavní program
IN R16,PINE					;vsupuje signál z tlaèítek

LDI R18,0x7E				;nadefinuji kombinaci tlaèítek
CP R16,R18					;porovnávám polohu tlaèítek s poadovanou kombinací
BREQ funkce1a				;kdy se R16=R18 volám funkci
LDI R18,0xBE				;nadefinuji kombinaci tlaèítek
CP R16,R18					;porovnávám polohu tlaèítek s poadovanou kombinací
BREQ funkce1b				;kdy se R16=R18 volám funkci

LDI R18,0x7D				;nadefinuji kombinaci tlaèítek
CP R16,R18					;porovnávám polohu tlaèítek s poadovanou kombinací
BREQ funkce2a				;kdy se R16=R18 volám funkci
LDI R18,0xBD				;nadefinuji kombinaci tlaèítek
CP R16,R18					;porovnávám polohu tlaèítek s poadovanou kombinací
BREQ funkce2b				;kdy se R16=R18 volám funkci

JMP main2					;skoèí na hlavní program 2. èást

funkce1a:					;funkce 1 zpodìní 500ms
	LDI R17,0x09			;kolikrát se bude opakovat cyklusf1
    LDI R19,0x01			;definuji poèáteèní èíslo
    LDI R20,0x01			
cyklusf1:
    SUB R19,R20				;odeèítám 1 od R19 tak aby bylo èíslo o 1 menší a zhasla by jedna dioda
    MOV R16,R19				;pøesouvám R18 do R16 aby jsem mohl mohl R18 zmìnit
    OUT PORTB,R16			;vıstup, rozsvítí LED podle binárního kodu
	CALL timer1				;zpodìní 500ms
    ADD R19,R20				;+1 a mohu pouít posunují o 1 místo
    ROL R19					;zdvojnásobuju R18
    DEC R17					;ubírám poèet opakování
	BRNE cyklusf1			;konec cyklu kdy R17=0
	JMP main				;zpátky na hlavní program

funkce1b:					;funkce 1 zpodìní 1s
	LDI R17,0x09			;pro cyklus
    LDI R19,0x01			;definuji poèáteèní èíslo
    LDI R20,0x01			
cyklusf1b:
    SUB R19,R20				;odeèítám 1 od R19 tak aby bylo èíslo o 1 menší a zhasla by jedna dioda
    MOV R16,R19				;pøesouvám R18 do R16 aby jsem mohl mohl R18 zmìnit
    OUT PORTB,R16			;vıstup, rozsvítí LED podle binárního kodu
	CALL timer2				;zpodìní 1s
    ADD R19,R20				;+1 a mohu pouít posunují o 1 místo
    ROL R19					;zdvojnásobuju R18
    DEC R17					;ubírám poèet opakování
	BRNE cyklusf1b			;konec cyklu kdy R17=0
	JMP main				;zpátky na hlavní program

funkce2a:					;funkce 2 zpodìní 500ms
 	LDI R17,0x0F			;binární kombinace pro 1. polovina svítí 
	LDI R19,0xF0			;binární kombinace pro 2. polovina svítí
	OUT PORTB,R17			;vıstup
	CALL timer1				;zpodìní 500ms
	OUT PORTB,R19			;vıstup
	CALL timer1				;zpodìní 500ms
	JMP main				;zpátky na hlavní program
funkce2b:					;funkce2 zpodìní 1s
 	LDI R17,0x0F			;binární kombinace pro 1. polovina svítí 
	LDI R19,0xF0			;binární kombinace pro 2. polovina svítí 
	OUT PORTB,R17			;vıstup
	CALL timer2				;zpodìní 1s
	OUT PORTB,R19			;vıstup
	CALL timer2				;zpodìní 1s
	JMP main				;zpátky na hlavní program

main2:						;hlavní program èást2
LDI R18,0x7B				;nadefinuji kombinaci tlaèítek
CP R16,R18					;porovnávám polohu tlaèítek s poadovanou kombinací
BREQ funkce3a				;kdy se R16=R18 volám funkci
LDI R18,0xBB				;nadefinuji kombinaci tlaèítek
CP R16,R18					;porovnávám polohu tlaèítek s poadovanou kombinací
BREQ funkce3b				;kdy se R16=R18 volám funkci

LDI R18,0x77				;nadefinuji kombinaci tlaèítek
CP R16,R18					;porovnávám polohu tlaèítek s poadovanou kombinací
BREQ funkce4a				;kdy se R16=R18 volám funkci
LDI R18,0xB7				;nadefinuji kombinaci tlaèítek
CP R16,R18					;porovnávám polohu tlaèítek s poadovanou kombinací
BREQ funkce4b				;kdy se R16=R18 volám funkci

LDI R18,0xFF				;definuji aby byly vsšchny LED zhasnuté			
OUT PORTB,R18				;vıstup
JMP main					;zpátky na hlavní program

funkce3a:					;funkce3 zpodìní 500ms
	LDI R17,0xAA			;definuji binární kombinaci pro zaplé liché LED
	LDI R19,0x55			;definuji binární kombinaci pro zaplé sudé LED
	OUT PORTB,R17			;vıstup
	CALL timer1				;zpodìní 500ms
	OUT PORTB,R19			;vıstup
	CALL timer1				;zpodìní 500ms
	JMP main				;zpátky na hlavní program
funkce3b:					;funkce3 zpodìní 1s
	LDI R17,0xAA			;definuji binární kombinaci pro zaplé liché LED
	LDI R19,0x55			;definuji binární kombinaci pro zaplé sudé LED
	OUT PORTB,R17			;vıstup
	CALL timer2				;zpodìní 1s
	OUT PORTB,R19			;vıstup
	CALL timer2				;zpodìní
	JMP main				;zpátky na hlavní program
	

funkce4a:					;funkce4 zpodìní 500ms
	LDI R17,0xFF			;nadefinuji poèáteèní stav LED
	LDI R19,0x09			;nadefinuji poèet opakování
cyklusf4:
	OUT PORTB,R17			;vıstup
	CALL timer1				;zpodìní 500ms
	ROL R17					;zdvojnásobuji
	DEC R19					;ubírám poèet opakování
	BRNE cyklusf4			;konec cyklu kdy R19=0
	JMP main				;zpátky na hlavní program

funkce4b:					;funkce4 zpodìní 1s
	LDI R17,0xFF			;nadefinuji poèáteèní stav LED
	LDI R19,0x09			;nadefinuji poèet opakování
cyklusf4b:
	OUT PORTB,R17			;vıstup
	CALL timer2				;zpodìní 1s
	ROL R17					;zdojnásobuji
	DEC R19					;ubírám poèet opakování
	BRNE cyklusf4b			;konec cyklu kdy R19=0
	JMP main				;zpátky na hlavní program
	

timer1:						;zpodìní 500ms
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

timer2:						;zpodìní 1s
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
