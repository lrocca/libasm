			section	.text
			global	_ft_strcpy

_ft_strcpy:
			mov rcx, -1					; index starts from -1

loop:
			inc rcx						; increment index
			mov al, byte [rsi + rcx]	; move src (2nd arg) char to register
			mov byte [rdi + rcx], al	; copy from register to dst (1st arg)
			cmp byte [rsi + rcx], 0		; compare *(str + index)
			jnz		loop				; repeat if not zero

			inc rcx						; increment index
			mov byte [rdi + rcx], 0		; null terminate dst
			mov rdi, rax				; return dst
			ret
