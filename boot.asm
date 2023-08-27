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
    call printFunction              ; Moves the cursor to a new line
    mov si, buffer
    mov di, CMD_Version
    call stringCompareFunction      ; Checks the buffer for the Version command
    je CMD_Version_Run   

    mov si, buffer
    mov di, CMD_BootScreen
    call stringCompareFunction      ; Checks the buffer for the Bootscreen command
    je CMD_BootScreen_Run

    jmp CMD_NOTFOUND_Run               ; return to input

    CMD_Version_Run:
    mov si, version_string
    call printFunction
    mov si, newline
    call printFunction
    mov di, buffer
    mov byte [di], 0x00
    jmp UserInputLoop

    CMD_NOTFOUND_Run:
    mov si, CMD_NOTFOUND
    call printFunction
    mov si, newline
    call printFunction
    mov di, buffer
    mov byte [di], 0x00
    jmp UserInputLoop
    
    CMD_BootScreen_Run:
    mov si, CMD_BootScreen
    call printFunction
    mov si, newline
    call printFunction
    mov di, buffer
    mov byte [di], 0x00
    jmp UserInputLoop

jmp $


;Variables

;Data
version_string db 'Version: prealpha 0.0.0.1', 0  ;defines a string I want to output later.
CMD_Version db 'version', 0
CMD_BootScreen db 'bootscreen', 0
CMD_NOTFOUND db 'Command Not Found', 0
buffer times 15 db 0
backspace db 0x08,0x20,0x08,0        ; backspace, space, backspace
newline db 0x0a,0x0d,0               ;new line,carriage return

;Functions




stringCompareFunction:
    Repeat:
    lodsb                       ; Gets character from string
    cmp al, 0                   ; Checks that the end of loop hasn't been reached
    je stringCompareDone   ; If so, then it goes to done
    cmp [di], al
    je RepeatInc
    jmp stringCompareDone
    RepeatInc:
    inc di
    jmp Repeat

stringCompareDone:
    cmp [di], al
    ret





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
