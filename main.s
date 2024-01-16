                AREA    |.text|, CODE

AD0CR           EQU     0x40034000
AD0GDR          EQU     0x40034004
FIO1PIN         EQU     0x2009C034
FIO0SET         EQU     0x2009C018
FIO0CLR         EQU     0x2009C01C

                IMPORT  SetPinVal
                IMPORT  ClearPinVal
                IMPORT  IsBitSet
                IMPORT  SetLEDLvl
                IMPORT  BlinkLEDs
                IMPORT  ToggleBlink
                IMPORT  DelayLong

                EXPORT  __main
; R7 = LEDs output
; R8 = should LED blink boolean
__main          PROC
                BL      StartConv

                ; blink LEDs if R8 is true
                MOV     R0, R7
                LDR     R1, =FIO1PIN
                CMP     R8, #1
                BLEQ    BlinkLEDs

                ; Turn sensor off
                LDR     R0, =FIO0CLR
                MOV     R1, #2_1
                LSL     R1, R1, #25
                BL      SetPinVal

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
                LDR     R1, =SPIN_LEDs
                LDR     R2, =FIO1PIN
                BL      SetLEDLvl
                MOV     R7, R0

                POP     {R0-R2, LR}
                B       __main
                ENDP

StartConv       PROC
                PUSH    {LR}
                ; Set pin SEL (AD0CR[1])
                LDR     R0, =AD0CR
                LDR     R1, =2_10
                BL      SetPinVal

                ; Turn sensor on
                LDR     R0, =FIO0SET
                MOV     R1, #2_1
                LSL     R1, R1, #25
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

SPIN_LEDs       DATA
                DCD     18  ; LED 1
                DCD     20  ; LED 2
                DCD     21  ; LED 3
                DCD     23  ; LED 4

                END
