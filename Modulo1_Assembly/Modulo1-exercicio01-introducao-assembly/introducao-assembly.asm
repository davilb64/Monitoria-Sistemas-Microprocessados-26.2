; ==============================================================================
; Arquivo:      [introducao-assembly.asm]
; Autor:        Davi Lopes Brito (Monitor)
; Disciplina:   Laboratório de Sistemas Microprocessados (ENE0440)
; Módulo:       [Módulo 1 - Programação Assembly]
; Data:         [23 de Agosto de 2026]
;
; Descrição:    Exercício guiado para apresentar modos de endereçamento e diferenças entre bytes e words.
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
  mov.w #(WDTPW|WDTHOLD), &WDTCTL
  mov.w #0x4400, SP
