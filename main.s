                AREA    |.text|, CODE

AD0CR           EQU     0x40034000
AD0GDR          EQU     0x40034004
FIO1PIN         EQU     0x2009C034

                IMPORT  SetPinVal
                IMPORT  ClearPinVal
                IMPORT  IsBitSet
                IMPORT  SetLEDLvl
                IMPORT  BlinkLEDs
                IMPORT  ToggleBlink
                IMPORT  DelayLong

                EXPORT  __main
; R7 = LEDs output
; R8 = (boolean) should LEDs blink?
__main          PROC
                BL      StartConv

                ; blink LEDs if needed
                PUSH    {R0-R1, LR}
                MOV     R0, R7
                LDR     R1, =FIO1PIN
                CMP     R8, #1
                BLEQ    BlinkLEDs
                POP     {R0-R1, LR}

                ; process the result
                LDR     R4, =AD0GDR
                LDR     R4, [R4]
                LSR     R4, R4, #4
                LDR     R5, =0xFFF
                AND     R4, R4, R5

                PUSH    {R0-R2, LR}
                ; check if LEDs should blink
                MOV     R0, R4
                BL      ToggleBlink
                MOV     R8, R0

                ; set the LEDs output
                MOV     R0, R4
                LDR     R1, =FIO1PIN
                BL      SetLEDLvl
                MOV     R7, R0

                POP     {R0-R2, LR}
                B       __main
                ENDP

StartConv       PROC
                PUSH    {LR}
                ; Set pin SEL (AD0CR[1])
                LDR     R0, =AD0CR
                MOV     R1, #2_10
                BL      SetPinVal

                ; Let sensor stabilize the voltage
                BL      DelayLong

                ; Start the conversion
                LDR     R0, =AD0CR
                LDR     R1, =0x1000000
                BL      SetPinVal
                POP     {LR}
                BX      LR
                ENDP

                ALIGN
                END
