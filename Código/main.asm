.INCLUDE "m328pdef.inc" ;Incluindo lista de instruções do ATMega328P

NOP ;Nenhuma operação
RJMP INICIO ;Pula para INICIO

NOP
INICIO:
    LDI R21, HIGH(RAMEND) ;Carrega no R16 a última localização de memória
    OUT SPH, R21 ;Coloca o Stack Pointer no topo da RAM
    LDI R21, LOW(RAMEND) 
    OUT SPL, R21

    RCALL INICIALIZACAO ;Chama a rotina de inicialização

    RCALL MAIN ;Começo do programa principal

;--------------------------------------------------------

DELAY: INC R30
DELAY_START: LDI R26, 20
DELAY_EXTERNO: LDI R25, 20
DELAY_INTERNO:
    DEC R25
    BRNE DELAY_INTERNO
    DEC R26
    BRNE DELAY_EXTERNO
    DEC R29
    BRNE DELAY_START
    DEC R30
    BRNE DELAY_START
    RET

    ;----------------------------------------------------

MAIN:
    SBI DDRB, 5 ;Seta bit 5 no DDRB
    SBI DDRB, 4
    SBI DDRB, 3
    SBI DDRB, 2
    SBI DDRB, 1
    CBI PORTB, 5
    CBI PORTB, 4
    CBI PORTB, 3
    CBI PORTB, 2
    CBI PORTB, 1
    SBI PORTB, 5
    RET

;------------------------------------------------------
INICIALIZACAO:
    LDI R21, 0 ;Carrega o valor de 0 no Registrador 21
    OUT PORTB, R21 ;Guarda o registrador na posição do I/O, no caso a PORTB
    LDI R21, 0 ;Carrega o valor de 0 no Registrador 21
    OUT PORTC, R21 ;Guarda o registrador na posição do I/O, no caso a PORTC
    LDI R21, 0 ;Carrega o valor de 0 no Registrador 21
    OUT PORTD, R21 ;Guarda o registrador na posição do I/O, no caso a PORTD
    RET
;------------------------------------------------------
DESLOCABIT:
    CBI PORTB, 3 ;Limpa o bit 3 no PORTB
    CBI PORTB, 4 ;Limpa o bit 4 no PORTB
    CBI PORTB, 1 ;Limpa o bit 1 no PORTB
    LDS R5, 256 ;Carrega o valor da posição 256 no Registrador 5
    SBRC R5, 0
    SBI PORTB, 1
    SBI PORTB, 4
    SBI PORTB, 3
    RET