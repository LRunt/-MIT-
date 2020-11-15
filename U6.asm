.NOLIST
.INCLUDE "m128def.inc"
.LIST
.CSEG

LDI R24,LOW(RAMEND)			;po pr�kazu CALL 0 1 ��dek n�
OUT SPL,R24
LDI R24,HIGH(RAMEND)
OUT SPH,R24

LDI R16,0xFF				;nadefinuji si v�stup, USB port
OUT DDRB,R16
LDI R16,0xFF
OUT PORTB,R16                
    LDI R23,0xFF			;nadefinov�n� po�tu opakov�n� pro main
	LDI R17,0x07			;pro cyklus
main:
    LDI R16,0x00			;rozsvicuji v�echny LED diody
    OUT PORTB,R16			;odesl�n� instrukce

    CALL timer1				;vol�m zpo�d�n�

    LDI R16,0x01			;zhas�n�m 1.LED diodu
    OUT PORTB,R16

    CALL timer1				;vol�m zpo�d�n�

    LDI R18,0x04			;definuji po��te�n� ��slo
    LDI R19,0x01			;
cyklus:
    SUB R18,R19				;ode��t�m 1 od R18 tak aby bylo ��slo o 1 men�� a zhasla by jedna dioda
    MOV R16,R18				;p�esouv�m R18 do R16 aby jsem mohl mohl R18 zm�nit
    OUT PORTB,R16
    CALL timer1				;vol�m zpo�d�n�
    ADD R18,R19				;+1 a� mohu pou��t posunuj� o 1 m�sto
    ROL R18					;zdvojn�sobuju R18
    DEC R17					;sni�uju po�et cykl�
    
BRNE cyklus					
    LDI R17,0x07			;R17 na 7, jinak cyklen� skon��
    DEC R23					;odeb�r�m po�et opakov�n�
BRNE main

timer1:						;zpo�d�n� 300ms
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
