#/*****************************************************************************
# * #file:    startup_LPC17xx.s
# * #purpose: CMSIS Cortex-M3 Core Device Startup File
# *           for the NXP LPC17xx Device Series
# * #version: V1.03
# * #date:    09. February 2010
# *------- <<< Use Configuration Wizard in Context Menu >>> ------------------
# *
# * Copyright (C) 2010 ARM Limited. All rights reserved.
# * ARM Limited (ARM) is supplying this software for use with Cortex-M3
# * processor based microcontrollers.  This file can be freely distributed
# * within development tools that are supporting such ARM based processors.
# *
# * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
# * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
# * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
# * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
# * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
# *
# *****************************************************************************/


# <h> Stack Configuration
#   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
# </h>

.equ Stack_Size, 0x00000200

.section .text, "ax"
.balign 8
Stack_Mem:       .space   Stack_Size
__initial_sp:


# <h> Heap Configuration
#   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
# </h>

.equ Heap_Size,     0x00000000

.section .text, "ax"
.balign 8
__heap_base:
Heap_Mem:        .space   Heap_Size
__heap_limit:


                PRESERVE8
                THUMB


# Vector Table Mapped to Address 0 at Reset

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       .word     __initial_sp              # Top of Stack
                .word     Reset_Handler             # Reset Handler
                .word     NMI_Handler               # NMI Handler
                .word     HardFault_Handler         # Hard Fault Handler
                .word     MemManage_Handler         # MPU Fault Handler
                .word     BusFault_Handler          # Bus Fault Handler
                .word     UsageFault_Handler        # Usage Fault Handler
                .word     0                         # Reserved
                .word     0                         # Reserved
                .word     0                         # Reserved
                .word     0                         # Reserved
                .word     SVC_Handler               # SVCall Handler
                .word     DebugMon_Handler          # Debug Monitor Handler
                .word     0                         # Reserved
                .word     PendSV_Handler            # PendSV Handler
                .word     SysTick_Handler           # SysTick Handler

                # External Interrupts
                .word     WDT_IRQHandler            # 16: Watchdog Timer
                .word     TIMER0_IRQHandler         # 17: Timer0
                .word     TIMER1_IRQHandler         # 18: Timer1
                .word     TIMER2_IRQHandler         # 19: Timer2
                .word     TIMER3_IRQHandler         # 20: Timer3
                .word     UART0_IRQHandler          # 21: UART0
                .word     UART1_IRQHandler          # 22: UART1
                .word     UART2_IRQHandler          # 23: UART2
                .word     UART3_IRQHandler          # 24: UART3
                .word     PWM1_IRQHandler           # 25: PWM1
                .word     I2C0_IRQHandler           # 26: I2C0
                .word     I2C1_IRQHandler           # 27: I2C1
                .word     I2C2_IRQHandler           # 28: I2C2
                .word     SPI_IRQHandler            # 29: SPI
                .word     SSP0_IRQHandler           # 30: SSP0
                .word     SSP1_IRQHandler           # 31: SSP1
                .word     PLL0_IRQHandler           # 32: PLL0 Lock (Main PLL)
                .word     RTC_IRQHandler            # 33: Real Time Clock
                .word     EINT0_IRQHandler          # 34: External Interrupt 0
                .word     EINT1_IRQHandler          # 35: External Interrupt 1
                .word     EINT2_IRQHandler          # 36: External Interrupt 2
                .word     EINT3_IRQHandler          # 37: External Interrupt 3
                .word     ADC_IRQHandler            # 38: A/D Converter
                .word     BOD_IRQHandler            # 39: Brown-Out Detect
                .word     USB_IRQHandler            # 40: USB
                .word     CAN_IRQHandler            # 41: CAN
                .word     DMA_IRQHandler            # 42: General Purpose DMA
                .word     I2S_IRQHandler            # 43: I2S
                .word     ENET_IRQHandler           # 44: Ethernet
                .word     RIT_IRQHandler            # 45: Repetitive Interrupt Timer
                .word     MCPWM_IRQHandler          # 46: Motor Control PWM
                .word     QEI_IRQHandler            # 47: Quadrature Encoder Interface
                .word     PLL1_IRQHandler           # 48: PLL1 Lock (USB PLL)
                .word		USBActivity_IRQHandler	  # 49: USB Activity interrupt to wakeup
                .word		CANActivity_IRQHandler	  # 50: CAN Activity interrupt to wakeup


                IF      :LNOT::DEF:NO_CRP
                AREA    |.ARM.__at_0x02FC|, CODE, READONLY
CRP_Key         .word     0xFFFFFFFF
                ENDIF


                AREA    |.text|, CODE, READONLY


# Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
                IMPORT  SystemInit
                IMPORT  __main
                LDR     R0, =SystemInit
                BLX     R0
                LDR     R0, =__main
                BX      R0
                ENDP


# Dummy Exception Handlers (infinite loops which can be modified)

NMI_Handler     PROC
                EXPORT  NMI_Handler               [WEAK]
                B       .
                ENDP
HardFault_Handler\
                PROC
                EXPORT  HardFault_Handler         [WEAK]
                B       .
                ENDP
MemManage_Handler\
                PROC
                EXPORT  MemManage_Handler         [WEAK]
                B       .
                ENDP
BusFault_Handler\
                PROC
                EXPORT  BusFault_Handler          [WEAK]
                B       .
                ENDP
UsageFault_Handler\
                PROC
                EXPORT  UsageFault_Handler        [WEAK]
                B       .
                ENDP
SVC_Handler     PROC
                EXPORT  SVC_Handler               [WEAK]
                B       .
                ENDP
DebugMon_Handler\
                PROC
                EXPORT  DebugMon_Handler          [WEAK]
                B       .
                ENDP
PendSV_Handler  PROC
                EXPORT  PendSV_Handler            [WEAK]
                B       .
                ENDP
SysTick_Handler PROC
                EXPORT  SysTick_Handler           [WEAK]
                B       .
                ENDP

Default_Handler PROC

                EXPORT  WDT_IRQHandler            [WEAK]
                EXPORT  TIMER0_IRQHandler         [WEAK]
                EXPORT  TIMER1_IRQHandler         [WEAK]
                EXPORT  TIMER2_IRQHandler         [WEAK]
                EXPORT  TIMER3_IRQHandler         [WEAK]
                EXPORT  UART0_IRQHandler          [WEAK]
                EXPORT  UART1_IRQHandler          [WEAK]
                EXPORT  UART2_IRQHandler          [WEAK]
                EXPORT  UART3_IRQHandler          [WEAK]
                EXPORT  PWM1_IRQHandler           [WEAK]
                EXPORT  I2C0_IRQHandler           [WEAK]
                EXPORT  I2C1_IRQHandler           [WEAK]
                EXPORT  I2C2_IRQHandler           [WEAK]
                EXPORT  SPI_IRQHandler            [WEAK]
                EXPORT  SSP0_IRQHandler           [WEAK]
                EXPORT  SSP1_IRQHandler           [WEAK]
                EXPORT  PLL0_IRQHandler           [WEAK]
                EXPORT  RTC_IRQHandler            [WEAK]
                EXPORT  EINT0_IRQHandler          [WEAK]
                EXPORT  EINT1_IRQHandler          [WEAK]
                EXPORT  EINT2_IRQHandler          [WEAK]
                EXPORT  EINT3_IRQHandler          [WEAK]
                EXPORT  ADC_IRQHandler            [WEAK]
                EXPORT  BOD_IRQHandler            [WEAK]
                EXPORT  USB_IRQHandler            [WEAK]
                EXPORT  CAN_IRQHandler            [WEAK]
                EXPORT  DMA_IRQHandler            [WEAK]
                EXPORT  I2S_IRQHandler            [WEAK]
                EXPORT  ENET_IRQHandler           [WEAK]
                EXPORT  RIT_IRQHandler            [WEAK]
                EXPORT  MCPWM_IRQHandler          [WEAK]
                EXPORT  QEI_IRQHandler            [WEAK]
                EXPORT  PLL1_IRQHandler           [WEAK]
                EXPORT  USBActivity_IRQHandler	  [WEAK]
                EXPORT  CANActivity_IRQHandler	  [WEAK]

WDT_IRQHandler
TIMER0_IRQHandler
TIMER1_IRQHandler
TIMER2_IRQHandler
TIMER3_IRQHandler
UART0_IRQHandler
UART1_IRQHandler
UART2_IRQHandler
UART3_IRQHandler
PWM1_IRQHandler
I2C0_IRQHandler
I2C1_IRQHandler
I2C2_IRQHandler
SPI_IRQHandler
SSP0_IRQHandler
SSP1_IRQHandler
PLL0_IRQHandler
RTC_IRQHandler
EINT0_IRQHandler
EINT1_IRQHandler
EINT2_IRQHandler
EINT3_IRQHandler
ADC_IRQHandler
BOD_IRQHandler
USB_IRQHandler
CAN_IRQHandler
DMA_IRQHandler
I2S_IRQHandler
ENET_IRQHandler
RIT_IRQHandler
MCPWM_IRQHandler
QEI_IRQHandler
PLL1_IRQHandler
USBActivity_IRQHandler
CANActivity_IRQHandler

                B       .

                ENDP


                ALIGN


# User Initial Stack & Heap

                IF      :DEF:__MICROLIB

                EXPORT  __initial_sp
                EXPORT  __heap_base
                EXPORT  __heap_limit

                ELSE

                IMPORT  __use_two_region_memory
                EXPORT  __user_initial_stackheap
__user_initial_stackheap

                LDR     R0, =  Heap_Mem
                LDR     R1, =(Stack_Mem + Stack_Size)
                LDR     R2, = (Heap_Mem +  Heap_Size)
                LDR     R3, = Stack_Mem
                BX      LR

                ALIGN

                ENDIF


                END
