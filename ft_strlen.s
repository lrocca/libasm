			section	.text
			global	_ft_strlen

_ft_strlen:								; s = rdi
			mov		rax, -1				; start index from -1

loop:
			inc		rax					; increment index
			cmp		byte [rdi + rax], 0	; compare *(s + index)
			jnz		loop				; if not zero, loop

			ret							; return index
