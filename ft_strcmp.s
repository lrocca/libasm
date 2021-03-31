			section	.text
			global	_ft_strcmp

_ft_strcmp:										; s1 = rdi, s2 = rsi
			mov		rcx, -1						; index starts from -1

loop:
			inc		rcx							; increment index
			mov		al, byte [rdi + rcx]		; move to ret
			mov		bl, byte [rsi + rcx]		; move to ret
			cmp		al, 0
			je		_zero
			cmp		bl, 0
			je		_zero
			cmp		al, bl					; compare two chars
			je		loop						; a == b

_zero:
			movzx	rax, al						; move to bigger register
			movzx	rdx, bl						; move to bigger register
			sub		rax, rdx					; get return value
			ret
