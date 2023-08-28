[org 0x7c00]
bits 16

start:			; start of disc read
mov di, buffer		; sets di to the buffer
mov ah, 2
mov al, 1		; ten sectors set to read
mov ch, 0		; low eight bits of cylinder number
mov cl, 2      	; sectors two through eleven
mov dh, 0		; drive head 1
mov [es:bx], di
mov dl, 0		; drive letter 1

int 13h		; bios interrupt to read disc

mov di, error_code
mov ah, [di]
int 16h

jmp $

buffer times 15 db 0	; defines the buffer
error_code times 3 db 0	; defines the error_code buffer

;
;   Magic boot number
;   
times 510 - ($-$$) db 0
dw 0xAA55
