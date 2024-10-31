MOV P1,#0FFH ;Make P1 input

START:MOV A,P1 ;Read data from Port 1

CJNE A,#0FFH,CHECK1 ;Key pressed branch to check1

SJMP START ;Branch to start

CHECK1:ACALL DELAY ;Call delay

MOV A,P1 ;Read data from Port 1

;CPL A ;Complement A

MOV P0,A ;Send the data to LED

AJMP START ;Branch to start

DELAY: MOV R6,#9H ;Delay program, R6 = 20h

NEXT1: MOV R7,#9H ;R7 = FFH

NEXT2: DJNZ R7, NEXT2 ;Stay until R7 becomes 0

DJNZ R6, NEXT1 ;Dec. R6, if it not zero, branch to NEXT1

RET

END