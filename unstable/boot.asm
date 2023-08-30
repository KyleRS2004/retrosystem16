[org 0x7c00]
bits 16

mov [driveL], dl
start:			; start of disk read
mov ah, 2		; parameter to tell bios to read
mov al, 1		; sectors set to read
mov ch, 0		; low eight bits of cylinder number
mov cl, 2      	; sector 2
mov dh, 0		; drive head
mov bx, buffer
mov dl, [driveL]; drive letter

int 0x13		; bios interrupt to read disk

mov ah, 0Eh		; error check
mov al, 0x30
int 10h

jmp $

buffer times 15 db 0	; defines the buffer
driveL times 2 db 0


;
;   Magic boot number
;   
times 510 - ($-$$) db 0
dw 0xAA55
