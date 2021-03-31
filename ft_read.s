			section	.text
			global	_ft_read
			extern	___error

_ft_read:
			mov		rax, 0x02000003		; set system call for read
			syscall						; invoke operating system
			jc _err						; if carry flag exists, there was an err
			ret							; if everything went well, rax was set automatically
_err:
			mov		rdx, rax			; save errno
			call	___error			; set rax to errno pointer
			mov		[rax], rdx			; set errno
			mov		rax, -1				; set ret to -1
			ret
