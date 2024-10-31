ORG	0000H
	MOV	SP, #70H
	MOV	PSW, #00H

LCD_IN:	MOV	A, #38H    ; init. LCD 2 lines, 5x7 matrix
	LCALL	COMNWRT		;call command subroutine
	LCALL 	DELAY		;give LCD some time
	MOV 	A, #0EH		;display on, cursor on
	LCALL	COMNWRT		;call command subroutine
	LCALL 	DELAY		;give LCD some time
	MOV     A, #01		;clear LCD
	LCALL	COMNWRT		;call command subroutine
	LCALL 	DELAY		;give LCD some time
	MOV     A, #06H		;shift cursor right
	LCALL	COMNWRT		;call command subroutine
	LCALL 	DELAY		;give LCD some time
	MOV     A, #85H		;cursor at line 1 postion 1
	LCALL	COMNWRT		;call command subroutine
	LCALL 	DELAY		;give LCD some time
	MOV     A, #'W'		;display letter W
	LCALL	DATAWRT		;call display subroutine
	LCALL 	DELAY		;give LCD some time
	MOV     A, #'E'		;display letter E
	LCALL	DATAWRT		;call display subroutine
	LCALL	DELAY
	MOV     A, #'L'		;display letter L
	LCALL	DATAWRT		;call display subroutine
	LCALL 	DELAY		;give LCD some time
	MOV     A, #'C'		;display letter C
	LCALL	DATAWRT		;call display subroutine
	LCALL   DELAY
	MOV     A, #'O'		;display letter O
	LCALL	DATAWRT		;call display subroutine
	LCALL 	DELAY		;give LCD some time
	MOV     A, #'M'		;display letter M
	LCALL	DATAWRT		;call display subroutine
	LCALL 	DELAY		;give LCD some time
	MOV     A, #'E'		;display letter E
	LCALL	DATAWRT		;call display subroutine
	LCALL 	DELAY		;give LCD some time
		
	MOV     A, #0C5H	;cursor at line 1 postion 1
	LCALL	COMNWRT		;call command subroutine
	LCALL 	DELAY		;give LCD some time
	
	MOV     A, #'C'		;display letter C
	LCALL	DATAWRT		;call display subroutine
	LCALL 	DELAY		;give LCD some time
	MOV     A, #'S'		;display letter S
	LCALL	DATAWRT		;call display subroutine
	LCALL	DELAY
	MOV     A, #'E'		;display letter E
	LCALL	DATAWRT		;call display subroutine
	LCALL 	DELAY		;give LCD some time
	MOV  	A, #'-'			;display letter -
	LCALL	DATAWRT
    LCALL 	DELAY 	;call display subroutine
	MOV	    A, #'A'			;display letter A
	LCALL	DATAWRT		;call display subroutine
	LCALL 	DELAY		;give LCD some time
	MOV	    A, #'I'			;display letter I
	LCALL	DATAWRT		;call display subroutine
	LCALL 	DELAY	
	MOV	    A, #'M'			;display letter M
	LCALL	DATAWRT		;call display subroutine
	LCALL 	DELAY	
	MOV	    A, #'L'			;display letter L
	LCALL	DATAWRT		;call display subroutine
	LCALL 	DELAY	
	
	AJMP	LCD_IN

COMNWRT:LCALL	READY           ;send command to LCD
	MOV	P1, A			;copy reg A to port 1
	CLR	P3.4			;RS=0 for command
	CLR	P3.5			;R/W=0 for write
	SETB	P3.6			;E-1 for high pulse	
	ACALL	DELAY	;give LCD some time
	CLR	P3.6			;E=0 for H-to-L pulse
	RET
	
DATAWRT:LCALL	READY	;write data to LCD
	MOV	P1, A			;copy reg A to port1
	SETB	P3.4			;RS=1 for data
	CLR	P3.5			;R/W=0 for write
	SETB	P3.6			;E=1 for high pulse
	ACALL	DELAY	;give LCD some time
	CLR	P3.6			;E=0 for H-to-L pulse
	RET
	
READY:CLR	P3.4
	  SETB	P3.5
	  RET	
	
DELAY:	MOV	R3, #15	;50 or higher for fast CPUs
HERE2:	MOV	R4, #15	;R4=255
HERE:	DJNZ	R4, HERE		;stay untill R4 becomes 0
	DJNZ 	R3, HERE2
	RET

	END

