.NOLIST
.INCLUDE "m128def.inc"
.LIST
.CSEG

LDI R24,LOW(RAMEND)			;po príkazu CALL 0 1 øádek ní
OUT SPL,R24
LDI R24,HIGH(RAMEND)
OUT SPH,R24

LDI R16,0xFF				;nadefinuji si vıstup, USB port
OUT DDRB,R16
LDI R16,0xFF
OUT PORTB,R16                
    LDI R23,0xFF			;nadefinování poètu opakování pro main
	LDI R17,0x07			;pro cyklus
main:
    LDI R16,0x00			;rozsvicuji všechny LED diody
    OUT PORTB,R16			;odeslání instrukce

    CALL timer1				;volám zpodìní

    LDI R16,0x01			;zhasínám 1.LED diodu
    OUT PORTB,R16

    CALL timer1				;volám zpodìní

    LDI R18,0x04			;definuji poèáteèní èíslo
    LDI R19,0x01			;
cyklus:
    SUB R18,R19				;odeèítám 1 od R18 tak aby bylo èíslo o 1 menší a zhasla by jedna dioda
    MOV R16,R18				;pøesouvám R18 do R16 aby jsem mohl mohl R18 zmìnit
    OUT PORTB,R16
    CALL timer1				;volám zpodìní
    ADD R18,R19				;+1 a mohu pouít posunují o 1 místo
    ROL R18					;zdvojnásobuju R18
    DEC R17					;sniuju poèet cyklù
    
BRNE cyklus					
    LDI R17,0x07			;R17 na 7, jinak cyklení skonèí
    DEC R23					;odebírám poèet opakování
BRNE main

timer1:						;zpodìní 300ms
    LDI R20, 0xA9
    LDI R21, 0x5A
    LDI R22, 0x19
cyklusa:
cyklusb:
cyklusc:
    DEC R20
    BRNE cyklusa
    DEC R21
    BRNE cyklusb
    DEC R22
    NOP
    BRNE cyklusc
    
    RET

KONEC:RJMP KONEC			;konec programu
