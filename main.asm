[org 0x7c00] 
[bits 16]

section .text

  global main

main:

cli
jmp 0x0000:ZeroSeg
ZeroSeg:
  xor ax, ax
  mov ss, ax
  mov ds, ax
  mov es, ax
  mov fs, ax
  mov gs, ax
  mov sp, main
  cld
sti

;push ax
;xor ax, ax
;int 0x13
;pop ax
;mov dl, 0x80
;int 0x13
;mov si, STR
;call printf

;mov si, STR_T
;call printf

;mov si, STR_TH
;call printf
;mov al, 1
;mov cl, 2
;call readDisk

mov ax, 0x2400
int 0x15

;mov dx, [0x7c00 + 510]

call testA20
mov dx, ax
call printh

call enableA20
mov dx, ax
call printh

jmp $

%include "./printf.asm"
%include "./readDisk.asm"
%include "./printh.asm"
%include "./testA20.asm"
%include "./enableA20.asm"

;STR: db "Loaded in 16-bit Real Mode to memory location 0x7c00.", 0x0a, 0x0d, 0
;STR_T: db "These messages use the BIOS interrupt 0x10 with the ah register sent to 0x0e.", 0x0a, 0x0d, 0
;STR_TH: db "Heraclitus test boot complete. Power off this machine and load a real OS, dummy.", 0
DISK_ERR_MSG: db "Error Loading Disk.", 0x0a, 0x0d, 0
TEST_STR: db "You are in the second sector.", 0x0a, 0x0d, 0

times 510-($-$$) db 0
dw 0xaa55

test:
mov si, TEST_STR
call printf

times 512 db 0
