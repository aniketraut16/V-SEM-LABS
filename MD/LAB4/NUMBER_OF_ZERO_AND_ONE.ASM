ORG 0000H
MOV DPTR , #6000H
MOVX A , @DPTR;DATA IS IN A = 2A= 00101010

MOV R2 , #00H; C0UNT OF 0'S
MOV R3 , #00H; COUNT OF 1'S
MOV R4 , #08H; 8 BIT COUNT

START:

RRC A ; ROTATE RIGHT WITH CARRRY
JC LOOP_ONE
INC R3
JMP DECREMENT

LOOP_ONE:
INC R2

DECREMENT:
DJNZ R4,START


END