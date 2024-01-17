                AREA    SystemInit, CODE

PCONP           EQU     0x400FC0C4
PCLKSEL0        EQU     0x400FC1A8
PINSEL1         EQU     0x4002C004
FIO1DIR         EQU     0x2009C020
AD0CR           EQU     0x40034000

                EXPORT  __systemInit
__systemInit    PROC
                IMPORT  SetPinVal
                PUSH    {R0-R3, LR}

                ; P0.24 (AD0.1)
                LDR     R0, =PINSEL1
                LDR     R1, =0x10000 ; PINSEL1[17:16]
                BL      SetPinVal

                ; Power ADC
                LDR     R0, =PCONP
                MOV     R1, #0x1000  ; PCONP[12]
                BL      SetPinVal

                ; ADC Clock
                LDR     R0, =PCLKSEL0
                LDR     R1, =0x1000000 ; PCLKSEL[25:24]
                BL      SetPinVal

                ; Enable ADC
                LDR     R0, =AD0CR
                LDR     R1, =0x200000 ; AD0CR[21]
                BL      SetPinVal

                ; LEDs output pin
                LDR     R0, =FIO1DIR
                LDR     R1, =0xB40000
                BL      SetPinVal

                POP     {R0-R3, LR}
                BX      LR
                ENDP

                ALIGN
                END
