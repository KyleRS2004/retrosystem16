[org 0x7c00]
bits 16

start:			; start of disc read
mov di, buffer		; sets di to the buffer
mov ah, 03h
mov al, 10		; ten sectors set to read
mov ch, 1		; low eight bits of cylinder number
mov cl, 7-16		; sectors two through eleven
mov dh, 1		; drive head 1
mov dl, 1		; drive 1
mov [es:bx], di

int 0x10		; bios interrupt to read disc

jmp $

buffer times 15 db 0	; defines the buffer

;
;   Magic boot number
;   
times 510 - ($-$$) db 0
dw 0xAA55
