; ==============================================================================
; Arquivo:      [introducao-assembly.asm]
; Autor:        Davi Lopes Brito
; Disciplina:   Laboratório de Sistemas Microprocessados (ENE0440)
; Módulo:       [Módulo 1 - Programação Assembly]
; Data:         [23 de Agosto de 2026]
;
; Descrição:    Exercício guiado para apresentar modos 
; de endereçamento e diferenças entre bytes e words.
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
  mov.w #0x4400, SP

main:
  ; a) move 0xFE para endereço apontado 
  ; por R4 usando o modo indexado "i(Rn)"
  mov.b #0xFE, 0(R4)

  ; b) tentar mover 0xFE utilizando o 
  ; modo indireto "@Rn" não funciona
  ; pois o modo indireto funciona apenas
  ; na origem
  mov.b #0xFE, @R4

  ; c) move #0xCA para end. apontado 
  ; por R4 + 1
  mov.b #0xCA, 1(R4)

  ; d) grava 0x1234 e 0x5678 para 
  ; end. apontado por R4 + 2 e R4 + 4,
  ; respectivamente.
  mov.w #0x1234, 2(R4)
  mov.w #0x5678, 4(R4)

  ; e) grava 0xABCD em R4 + 5 (end impar)
  mov.w #0xABCD, 5(R4)

  jmp $
  nop
  