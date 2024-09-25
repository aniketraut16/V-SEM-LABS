ORG 0000H
MOV DPTR , #6000H  ; DPTR = 6000H
MOVX A , @DPTR     ; A = AB
INC DPTR           ; DPTR = 6001H
MOV R0 , #50H ; Random data
MOV @R0 , A         ; R0 = A
MOVX A , @DPTR     ; A = CD
XCHD A , @R0       ; A = CB , R0 = AD
MOVX @DPTR , A     ; @6001 = CB
DEC DPL           ; DPTR = 6000
MOV A , @R0         ; A = AD
MOVX @DPTR , A     ; @6000 = AD
END
