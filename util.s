                AREA    Utility, CODE

                EXPORT  SetPinVal
SetPinVal       PROC
                PUSH    {R4, LR}
                LDR     R4, [R0]
                ORR     R4, R4, R1
                STR     R4, [R0]
                POP     {R4, LR}
                BX      LR
                ENDP

                EXPORT  ClearPinVal
ClearPinVal     PROC
                PUSH    {R4, LR}
                LDR     R4, [R0]
                MVN     R1, R1
                AND     R4, R4, R1
                STR     R4, [R0]
                POP     {R4, LR}
                BX      LR
                ENDP

                EXPORT  IsBitSet
IsBitSet        PROC
                PUSH    {R4, LR}
                LDR     R4, [R0]
                LSR     R4, R4, R1
                CMP     R4, #1
                POP     {R4, LR}
                BX      LR
                ENDP

                EXPORT DelayLong
DelayLong       PROC
                PUSH    {R4, LR}
                ; TODO: make the delay time configurable
                ; currently the delay time is arbitrary
                ; I have no idea how long this would take
                ; because I don't know how to get the clock
                ; frequency of processor
                MOV     R4, #0xFFFF
                MOVT    R4, #0x0007
while_delayLong SUBS    R4, R4, #1
                BNE     while_delayLong
                POP     {R4, LR}
                BX      LR
                ENDP

                EXPORT DelayShort
DelayShort      PROC
                PUSH    {R4, LR}
                ; TODO: make the delay time configurable
                ; currently the delay time is arbitrary
                ; I have no idea how long this would take
                ; because I don't know how to get the clock
                ; frequency of processor
                MOV     R4, #0xFFFF
                MOVT    R4, #0x0000
while_delayS	SUBS    R4, R4, #1
                BNE     while_delayS
                POP     {R4, LR}
                BX      LR
                ENDP

                ALIGN
                END
