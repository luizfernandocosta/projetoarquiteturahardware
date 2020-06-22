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
;*******************************************************************************
LOOP_PRIMARIO:
    LDI R21, 1 ;Carrega 1 byte no Registrador 21
    STS 256, R21 ;Guarda o valor de 256 no espaço de dados
    RCALL DESLOCABIT ;Chamada relativa a subrotina DESLOCABIT
    LDI R29, 244 ;Carrega o valor de 244 no Registrador 29
    LDI R30, 1 ;Carrega o valor de 1 no Registrador de 30
    RCALL DELAY ;Chamada relativa a subrotina DELAY
    LDI R21, 0 ;Carrega imediatamente o valor de 0 no Registrador 21
    STS 257, R21 ;Guarda o valor de R21 na posição 257
LOOP:
    LDS R0, 257 ;Carrega o valor de 257 direto no R0
    INC R0 ;Incrementa R0
    STS 257, R0 ;Guarda o valor de R0 na posição 257
    LDI R21, 0 ;Carrega o valor imediato de 0 em Registrador 21
    STS 256, R21 ;Guarda o valor de R21 na posição 256
    RCALL DESLOCABIT ;Chamada relativa a subrotina DESLOCABIT
    LDI R29, 244 ;Carrega o valor imediato de 244 em Registrador 29
    LDI R30, 1 ;Carrega o valor de  no Registrador 30
    RCALL DELAY ;Chamada relativa a subrotina DELAY
    LDS R22, 257 ;Carrega o valor da posição 257 no Registrador 22
    CPI R22, 7 ;Compara imediatamente o valor do Registrador 22 com o valor de 7, se for menor do que 7, ele continua o loop, se não, ele continua o programa
    BRLO LOOP ;Branch de condicional relativa, por eu usar o comando CPI antest, a branch vai ocorrer apenas se o valor no registrador for menor que o número representado, caso o valor seja maior, ele continua o programa
FIMLOOP:
    RJMP LOOP_PRIMARIO ;Chama o LOOP_PRIMARIO
;*******************************************************************************
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
;*******************************************************************************
MAIN:
    SBI DDRB, 5 ;Seta bit na posição 5 no DDRB
    SBI DDRB, 4 ;Seta bit na posição 4 no DDRB
    SBI DDRB, 3 ;Seta bit na posição 3 no DDRB
    SBI DDRB, 2 ;Seta bit na posição 2 no DDRB
    SBI DDRB, 1 ;Seta bit na posição 1 no DDRB
    CBI PORTB, 5 ;Limpa bit na posição 5 do PORTB
    CBI PORTB, 4 ;Limpa bit na posição 4 do PORTB
    CBI PORTB, 3 ;Limpa bit na posição 3 do PORTB
    CBI PORTB, 2 ;Limpa bit na posição 2 do PORTB
    CBI PORTB, 1 ;Limpa bit na posição 1 do PORTB
    SBI PORTB, 5 ;Setta bit na posição 5 do PORTB
    RET ;Retorna da subrotina
;*******************************************************************************
INICIALIZACAO:
    LDI R21, 0 ;Carrega o valor de 0 no Registrador 21
    OUT PORTB, R21 ;Guarda o registrador na posição do I/O, no caso a PORTB
    LDI R21, 0 ;Carrega o valor de 0 no Registrador 21
    OUT PORTC, R21 ;Guarda o registrador na posição do I/O, no caso a PORTC
    LDI R21, 0 ;Carrega o valor de 0 no Registrador 21
    OUT PORTD, R21 ;Guarda o registrador na posição do I/O, no caso a PORTD
    RET ;Retorna da subrotina
;*******************************************************************************
DESLOCABIT:
    CBI PORTB, 3 ;Limpa o bit 3 no PORTB
    CBI PORTB, 4 ;Limpa o bit 4 no PORTB
    CBI PORTB, 1 ;Limpa o bit 1 no PORTB
    LDS R5, 256 ;Carrega o valor da posição 256 no Registrador 5
    SBRC R5, 0 ;Compara se o R5 é igual a 0, se for igual, ele não executa a próxima linha, se for diferente, ele executta a próxima linha
    SBI PORTB, 1 ;Seta bit na posição 1 no PORTB
    SBI PORTB, 4 ;Seta bit na posição 4 no PORTB
    SBI PORTB, 3 ;Seta bit na posição 3 no PORTB
    RET ;Retorna da subrotina