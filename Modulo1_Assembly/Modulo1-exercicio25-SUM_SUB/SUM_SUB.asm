; ==============================================================================
; Arquivo:      [SUM_SUB.asm]
; Autor:        Davi Lopes Brito
; Disciplina:   Laboratório de Sistemas Microprocessados (ENE0440)
; Módulo:       [Módulo 1 - Programação Assembly]
; Data:         [24 de Agosto de 2026]
;
; Enunciado: Apresente a sub-rotina SUM_SUB, que recebe em R12 um ponteiro para uma matriz de words,
; em R13 o número de linhas da matriz e em R14 o número de colunas. A rotina deve salvar:
; • a soma dos elementos da matriz exceto aqueles que estão na primeira linha e/ou na
; primeira coluna em R12;
; • a soma dos elementos da matriz exceto aqueles que estão na primeira linha e/ou na
; última coluna em R13;
; • a soma dos elementos da matriz exceto aqueles que estão na última linha e/ou na
; primeira coluna em R14;
; • a soma dos elementos da matriz exceto aqueles que estão na última linha e/ou na última
; coluna em R15.
; Note que a sub-rotina deve funcionar para matrizes de qualquer tamanho (com pelo menos
; duas linhas e duas colunas) e que o programa tem que chamar a sub-rotina SUB_SUM, retornar
; para o bloco principal e então ficar preso no loop infinito.
;
; Parâmetros de Entrada:
;   R12 (Ponteiro para matriz de entrada)
;   R13 (Número de linhas da matriz)
;   R14 (Número de colunas da matriz)
;
; Parâmetros de Saída:
;   R12 (soma dos elementos da matriz exceto aqueles que estão na primeira linha e/ou na
;   primeira coluna)
;   R13 (soma dos elementos da matriz exceto aqueles que estão na primeira linha e/ou na
;   última coluna)
;   R14 (soma dos elementos da matriz exceto aqueles que estão na última linha e/ou na
;   primeira coluna)
;   R15 (soma dos elementos da matriz exceto aqueles que estão na última linha e/ou na última
;   coluna)
; ==============================================================================

  .cdecls "msp430.h"
  .global main

  .text
  
main:
  ; Desliga o WatchDog
  mov.w #(WDTPW|WDTHOLD), &WDTCTL
  mov.w #0x4400, SP

  mov #matriz, R12 ; Ponteiro para a matriz de entrada
  mov #3, R13 ; Número de linhas da matriz
  mov #3, R14 ; Número de colunas da matriz

  call #SUM_SUB ; Chamar sub-rotina

  jmp $ ; Loop infinito
  nop

SUM_SUB:
  ;Salva contexto dos registradores
  push R4
  push R5
  push R6
  push R7
  push R8
  push R9
  push R10
  push R11

  ; atribui limites 
  mov.w R13, R10
  dec.w R10
  mov.w R14, R11
  dec.w R11

  ; zera somas
  mov.w #0, R4
  mov.w #0, R5
  mov.w #0, R6
  mov.w #0, R7

  ; zera linha pra começar a percorrer a matriz
  mov.w #0, R8

loop_externo:
  ; linhas percorridas = linhas totais?
  cmp.w R13, R8
  jeq fim ; sim -> pula pro fim

  ; não -> continua para colunas
  mov.w #0, R9

loop_interno:
  ; colunas percorridas = colunas totais?
  cmp.w R14, R9
  jeq ret_loop_externo ; sim -> incrementa linha e retorna para fazer todas as linhas da nova col
  jmp somas

ret_loop_externo:
  inc.w R8
  jmp loop_externo

somas:
  mov.w @R12+, R15


teste1:
  tst.w R8
  jeq teste2 ; primeira linha?

  tst.w R9
  jeq teste2 ; primeira coluna?

  add.w R15, R4

teste2:
  tst.w R8
  jeq teste3 ; primeira linha?

  cmp.w R9, R11
  jeq teste3 ; última coluna?

  add.w R15, R5

teste3:
  cmp.w R8, R10
  jeq teste4 ; última linha?

  tst.w R9
  jeq teste4 ; primeira coluna?

  add.w R15, R6

teste4:
  cmp.w R8, R10
  jeq inc_col ; última linha?

  cmp.w R9, R11
  jeq inc_col ; última coluna?

  add.w R15, R7

inc_col:
  inc.w R9
  jmp loop_interno


fim:
  mov.w R4, R12
  mov.w R5, R13
  mov.w R6, R14
  mov.w R7, R15
  pop R11
  pop R10
  pop R9
  pop R8
  pop R7
  pop R6
  pop R5
  pop R4
  ret


; Especificar a matriz de entrada na seção de dados
.data
matriz: .word 1, 2, 3, 4, 5, 6, 7, 8, 9