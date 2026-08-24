; ==============================================================================
; Arquivo:      [introducao-assembly-2.asm]
; Autor:        Davi Lopes Brito
; Disciplina:   Laboratório de Sistemas Microprocessados (ENE0440)
; Módulo:       [Módulo 1 - Programação Assembly]
; Data:         [24 de Agosto de 2026]
;
; Descrição:    Exercício guiado para apresentar modos 
; de endereçamento e diferenças entre bytes e words. apresenta .data
;
; Parâmetros de Entrada:
;   N/A
;
; Parâmetros de Saída:
;   N/A
; ==============================================================================

  .cdecls "msp430.h"
  .global main

  .text
  ; Desliga o WatchDog
  mov.w #(WDTPW|WDTHOLD), &WDTCTL
  

main:
  ; a) utiliza modo imediato para inserir
  ; endereço do vetor em R4
  mov.w #vetor, R4

  ; b) utiliza o modo de endereçamento indireto com 
  ; incremento para ler os dois primeiros bytes
  ; do vetor e alocar em R5 e R6, respectivamente
  mov.b @R4+, R5
  mov.b @R4+, R6

  ; c) insere as próximas duas words em R7 e R8
  mov.w @R4+, R7
  mov.w @R4+, R8

  ; d)
  mov.b #0x33, 0(var)

  jmp $
  nop

  .data
vetor .bytes: 0x12, 0x34, 0x56, 0x78, 0x9A, 0xBC, 0xDE
var   .byte: 0x00