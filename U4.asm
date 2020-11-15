.NOLIST
.INCLUDE "m128def.inc"
.LIST
.CSEG

    LDI XL,0x50             ;adresa ukl�d�n� ��sel
    LDI XH,0x01
    LDI ZL,LOW(cisla*2)     ;adresa �erp�n� dat
    LDI ZH,HIGH(cisla*2)
    LDI R20,0x08            ;po�et opakov�n�
nacteni:
    LPM R21,Z               ;na�tu ��slo z programu
    ST X+,R21               ;ulo��m byt do dat a sn��m adresu
    ST Z+,R21               ;dal�� byt v programu
    DEC R20                 ;sn��m po�et opakov�n�
    BRNE nacteni            ;konec na��t�n� hodnot z programu

    LDI XL,0x00             ;adresa ukl�d�ni� hodnot
    LDI XH,0x01
    LDI R20,0x02            ;po�et opakov�n�
nula:                       ;cyklus pro zm�nu hodnot z FF na 00, kdy� zde bylo FF, tak se s��talo prvn� hodnota s FF
    ST X+,R12               ;ulo��m hodnotu a zv���m adresu pro ukl�d�n�
    DEC R20                 ;sn��m po�et opakov�n�
    BRNE nula               ;konec nastavov�n� hodnot na nulu
    
    LDI R20,0x08            ;po�et opakov�n�
    LDI XL,0x01             ;adresa ulo�en� pro sou�et
    LDI XH,0x01                
    LDI YL,0x58             ;adresa na�ten� hodnot
    LDI YH,0x01
    LDI ZL,0x00             ;adresa pro zaps�n� hodnoty, kter� se neve�la do X (carry)
    LDI ZH,0x01
vypocet:
    LD R10,-Y               ;na�ten� hodnoty
    LD R11,X                ;na�ten� sou�tu
    ADD R11,R10             ;sou�et
    CLR R12                 ;vynulov�n� Registru R12
    ADC R12,R10             ;sou�et s carry
    SUB R12,R10             ;ode��t�n� p�i��tan�ho ��sla, z�st�v� zde v�ak C
    ST Z,R12                ;zaps�n� C
    ST X,R11                ;zaps�n� sou�tu
    LD R13,Z                ;na�ten� Z
    ADD R14,R13             ;se�ten� C
    ST Z,R14                ;zaps�n� v�sledn�ho C
    DEC R20                 ;sn�en� po�tu opakov�n�
    BRNE vypocet            ;konec v�po�tu


cisla: .DB 0xFE,0x01,0xBB,0xAA,0x93,0x02,0x88,0xAA    ;8 ��sel do programu

KONEC:RJMP KONEC    ;konec programu
