	section	.text
	global	_ft_list_sort

; void		ft_list_sort(t_list **rdi, int (*rsi)());

_ft_list_sort:
	push	r12
	push	r13
	push	r15
	cmp		rdi, 0			; 1st arg == 0, return
	jz		return
	mov		r12, [rdi]		; r12 = *head
	mov		r15, rsi		; r15 = cmp function

_loop:
	mov		r13, [r12 + 8]	; r13 = lst.next
	cmp		r13, 0			; lst.next == 0
	jz		return			; lst is over
	push	rdi				; save lst head
	mov		rdi, [r12]		; 1st arg = lst.data
	mov		rsi, [r13]		; 2nd arg = lst.next.data
	call	r15				; call compare function
	pop		rdi				; restore lst head
	cmp		rax, 0			; check return of cmp
	jg		swap			; ret > 0, then swap
	jmp		next			; else loop

swap:
	mov		r10, [r12]		; r10 = lst.data
	mov		r11, [r13]		; r11 = lst.next.data
	mov		[r12], r11		; lst.data = r11
	mov		[r13], r10		; lst.next.data = r10
	mov		r12, [rdi]		; reset lst head
	jmp		_loop

next:
	mov		r12, r13		; lst = lst.next
	jmp		_loop

return:
	pop		r15
	pop		r13
	pop		r12
	ret
