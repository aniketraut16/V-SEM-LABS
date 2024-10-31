ORG 0000H ;initial starting address
MOV DPTR,#CC_PATTERNS ; loads the adress Lookup Table
START: MOV A,#0FFH ; initial value of accumulator
MOV B,A
MOV R0,#0AH ;Register R0 initialized as counter
LOOP: MOV A,B
INC A
MOV B,A
ACALL DISPLAY ;
MOV P0,A
ACALL DELAY ; calls the delay of the timer
DEC R0 ;Counter R0 decremented by 1
MOV A,R0 ; R0 moved to accumulator to check if it is zero in next instruction.
JZ START ;Checks accumulator for zero and jumps to START. Done to check if counting has been finished.
SJMP LOOP
DELAY: MOV R3, #45 ;50 or higher for fast CPUs
HERE2: MOV R4, #45 ;R4=255
HERE: DJNZ R4, HERE ;stay untill R4 becomes 0
DJNZ R3, HERE2
RET

DISPLAY:
MOVC A,@A+DPTR ; adds the byte in A to the address in DPTR and loads A with data present in the r e s u l t a n t address
RET

CC_PATTERNS:
DB 088H,080h,0C6h,0C0h,086h,0D2h,082h,0f8h,080h,090h,0 ;COMMON ANODECONFIGURATION
END
