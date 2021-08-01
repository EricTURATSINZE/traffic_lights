    ;ASSIGNMENT 2 TRAFFIC LIGHT USING ASSEMBLY LANGUAGE
    ;Cedrick GAHAMANYI (218007750) AND Eric TURATSINZE(218009832) 
    
 STATUS equ 03h ;STATUS Register for Selecting Bank
     RP0 equ 05
     RP1 equ 06
 PORTD equ 08h ;BANK0
 TRISD equ 88h ;BANK1 
 
 COUNTER equ 20h; The counter for our delay loop
 
 ; use directive to force the program to start at reset vector : 00h
 
    org 00h ; the program starts here
 
    clrw ;clear w register
 
 ; Selecting Bank
 
    BCF STATUS, RP0; RP0=0
    BCF STATUS, RP1; RP1=0
 
    CLRF PORTD ; initialise PORTD
 
 ;Switch to bank1 for TRISD register
 
    BSF STATUS, RP0; RP0 = 1
 
 ;Next we make sure that all pins in PORTD
 
    MOVLW 0x00; clear W register
 
    MOVWF TRISD; set PORTD as output
 
 ;back to Bank0 for working with PORTD
 
    BCF STATUS, RP0; RP0=0
    BCF STATUS, RP1; RP1=0
 
 ; Now let us turn on pin 1 at PORTD
SART	BSF PORTD, 0; Turn on pin 1 on PORTD
    ;DELAY 
    
    MOVLW 0xff
    MOVWF COUNTER  ; SET Counter to 0xff
     
Loop1	DECFSZ COUNTER, 1; Subtract 1 from 255
    GOTO    Loop1	; it will loop until zero 0

    BCF PORTD, 0  ;turn off pin 1 on PORTD
    
    MOVLW 0x02	;YOU can turn on pin 2 using either BSF or passing through the working Register
    MOVWF PORTD ;turn on pin 2 on PORTD

       ;Delay
    MOVLW 0xff
    MOVWF COUNTER    ;Set Counter to 0xff
   
Loop2	DECFSZ COUNTER, 1; Subtract 1 from 255
    GOTO    Loop2	; it will loop until zero 0
    
    BCF PORTD, 1    ;turn off pin 2 on PORTD
    
    BSF PORTD, 2    ;turn on pin 3 on PortD
    
    MOVLW 0xff
    MOVWF COUNTER  ; SET Counter to 0xff
    
Loop3	DECFSZ COUNTER, 1; Subtract 1 from 255
    GOTO    Loop3	; it will loop until zero 0
    
    MOVLW 0x00
    MOVWF PORTD	;turn OFF all pins on PORTD
    
    BCF PORTD, 2  ;turn off pin 3 on PORTD 

    GOTO    SART
 
END
