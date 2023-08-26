[org 0x7c00]
bits 16


;Bootloading code
start:
    mov di, buffer
    
    UserInputLoop:
    mov ah, 00h                     ;keyboard input is set to register ah
    int 16h                         ;keyboard input is gotten
    cmp al, 0x0d                    ; press "enter" to go to cmd check
    je CMD_Check
    cmp al, 0x08
    je InputRemove
    mov [di], al                    ; move input into the buffer
    inc di
    mov ah, 0Eh		; int 10h 'print char' function
    int 10h                         ; print current input
    jmp UserInputLoop

    InputRemove:
    dec di                          ; moves back to previous inputted byte
    mov byte [di], 0x00             ; sets that byte to null
    mov si, backspace
    call printFunction
    jmp UserInputLoop

    CMD_Check:                      ; User Input Check loop
    mov si, newline
    call printFunction
    mov si, buffer                  ; Input checked in the buffer
    call printFunction              
    mov di, buffer
    mov si, newline
    call printFunction
    jmp UserInputLoop               ; return to input


    


jmp $


;Variables

;Data
version_string db 'Version: prealpha 0.0.0.1', 0  ;defines a string I want to output later.
CMD_Version db 'version', 0
buffer times 10 db 0
backspace db 0x08,0x20,0x08,0        ; backspace, space, backspace
newline db 0x0a,0x0d,0               ;new line,carriage return

;Functions

printFunction:      ; Credit to mikeos for this function.
	mov ah, 0Eh		; int 10h 'print char' function

.repeat:            ; Loop
	lodsb			; Get character from string
	cmp al, 0
	je .done		; If char is zero, end of string
	int 10h			; Otherwise, print it
	jmp .repeat

.done:
	ret


;
;   Magic boot number
;   
times 510 - ($-$$) db 0
dw 0xAA55
