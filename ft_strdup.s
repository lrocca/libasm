			section	.text
			global	_ft_strdup
			extern	_ft_strlen
			extern	_malloc
			extern	_ft_strcpy
			extern	___error

_ft_strdup:							; src = rdi
			push	rdi				; save src
			call	_ft_strlen		; call function, now rax = lenght
			inc		rax				; add null terminator to lenght

			mov		rdi, rax		; move length to 1st arg
			call	_malloc			; call malloc
			cmp		rax, 0			; check returned pointer
			jz		error			; if zero go to error
			pop		rsi				; get back src to 2nd arg

			mov		rdi, rax		; move allocated pointer to 1st arg
			call	_ft_strcpy		; copy the string

			ret						; ft_strcpy returns dst

error:
			call	___error		; set rax to errno pointer
			mov		byte [rax], 12	; set errno to ENOMEN
			mov		rax, 0			; return null pointer
			ret
