                AREA    LEDs, CODE

MAX_SENSOR_VOLT EQU     2110
MIN_SENSOR_VOLT EQU     993
BLINK_THRESHOLD EQU     2047

                IMPORT  DelayShort
                EXPORT  SetLEDLvl
; R0 = voltage from ADC
; R1 = LEDs[]
; R2 = FIOxPIN addr
SetLEDLvl       PROC
                PUSH    {R4-R6, LR}
                LDR     R4, =MAX_SENSOR_VOLT
                LDR     R5, =MIN_SENSOR_VOLT

                CMP     R0, #800
                MOVLE   R0, #0
                MOVGT   R0, #0x040000

                MOV     R5, #1024
                CMP     R0, R5
                MOVGE   R0, #0x140000

                MOV     R5, #2048
                CMP     R0, R5
                MOVGE   R0, #0x340000

                MOV     R5, #MAX_SENSOR_VOLT
                CMP     R0, R5
                MOVGE   R0, #0xB40000

                STR     R0, [R2]
                POP     {R4-R6, LR}
                BX      LR
                ENDP

                EXPORT  BlinkLEDs
; R0 = FIOxPIN toggle value
; R1 = FIOxPIN addr
BlinkLEDs       PROC
                LDR     R5, [R1]
                MOV     R6, #0xB40000

                ; check if there's any LED light up
                AND     R5, R6, R5
                CMP     R5, #0
                ORREQ   R5, R5, R0
                MVNNE   R0, R0
                ANDNE   R5, R5, R0
                STR     R5, [R1]
                PUSH    {LR}
                BL      DelayShort
                POP     {LR}
                BX      LR
                ENDP

                EXPORT  ToggleBlink
ToggleBlink     PROC
                PUSH    {R4, LR}
                LDR     R4, =BLINK_THRESHOLD
                CMP     R0, R4
                MOVGE   R0, #1
                MOVLT   R0, #0
                POP     {R4, LR}
                BX      LR
                ENDP

                ALIGN
                END
