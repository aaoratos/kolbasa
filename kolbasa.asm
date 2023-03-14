.686
.model flat, stdcall
option casemap : none

include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib

POINT struct
    x DWORD ?
    y DWORD ?
POINT ends

.data?
    cur POINT <>
.code

start:
    ; MASM can't assemble the RDRAND instruction
    ; so we have use machine code directly
    db 0Fh, 0C7h, 0F0h
    xor edx, edx
    mov ecx, 1Eh
    div ecx
    mov ebx, edx
    lea eax, cur
    push eax
    call GetCursorPos
    db 0Fh, 0C7h, 0F0h
    xor edx, edx
    mov ecx, 04h
    div ecx
    mov eax, edx
    mov edx, cur.x
    mov ecx, cur.y
    or eax, eax
    jne uno
    add edx, ebx
    add ecx, ebx
    jmp nihil
uno:
    cmp eax, 01h
    jne dos
    sub edx, ebx
    sub ecx, ebx
    jmp nihil
dos:
    cmp eax, 02h
    jne tres
    sub edx, ebx
    add ecx, ebx
    jmp nihil
tres:
    add edx, ebx
    sub ecx, ebx
nihil:
    push ecx
    push edx
    call SetCursorPos
    push 20h
    call Sleep
    jmp start
end start