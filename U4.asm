.NOLIST
.INCLUDE "m128def.inc"
.LIST
.CSEG

    LDI XL,0x50             ;adresa ukládání èísel
    LDI XH,0x01
    LDI ZL,LOW(cisla*2)     ;adresa èerpání dat
    LDI ZH,HIGH(cisla*2)
    LDI R20,0x08            ;poèet opakování
nacteni:
    LPM R21,Z               ;naètu èíslo z programu
    ST X+,R21               ;uložím byt do dat a snížím adresu
    ST Z+,R21               ;další byt v programu
    DEC R20                 ;snížím poèet opakování
    BRNE nacteni            ;konec naèítání hodnot z programu

    LDI XL,0x00             ;adresa ukládánií hodnot
    LDI XH,0x01
    LDI R20,0x02            ;poèet opakování
nula:                       ;cyklus pro zmìnu hodnot z FF na 00, když zde bylo FF, tak se sèítalo první hodnota s FF
    ST X+,R12               ;uložím hodnotu a zvýším adresu pro ukládání
    DEC R20                 ;snížím poèet opakování
    BRNE nula               ;konec nastavování hodnot na nulu
    
    LDI R20,0x08            ;poèet opakování
    LDI XL,0x01             ;adresa uložení pro souèet
    LDI XH,0x01                
    LDI YL,0x58             ;adresa naètení hodnot
    LDI YH,0x01
    LDI ZL,0x00             ;adresa pro zapsání hodnoty, která se nevešla do X (carry)
    LDI ZH,0x01
vypocet:
    LD R10,-Y               ;naètení hodnoty
    LD R11,X                ;naètení souètu
    ADD R11,R10             ;souèet
    CLR R12                 ;vynulování Registru R12
    ADC R12,R10             ;souèet s carry
    SUB R12,R10             ;odeèítání pøièítaného èísla, zùstává zde však C
    ST Z,R12                ;zapsání C
    ST X,R11                ;zapsání souètu
    LD R13,Z                ;naètení Z
    ADD R14,R13             ;seètení C
    ST Z,R14                ;zapsání výsledného C
    DEC R20                 ;snížení poètu opakování
    BRNE vypocet            ;konec výpoètu


cisla: .DB 0xFE,0x01,0xBB,0xAA,0x93,0x02,0x88,0xAA    ;8 èísel do programu

KONEC:RJMP KONEC    ;konec programu
