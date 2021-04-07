	section	.text
	global	_ft_list_sort

; void		ft_list_sort(t_list **rdi, int (*rsi)());

_ft_list_sort:
	cmp		rdi, 0			; 1st arg == 0, return
	jz		return
	mov		r8, [rdi]		; r8 = *head
	mov		rcx, rsi		; rcx = cmp function

_loop:
	mov		r9, [r8 + 8]	; r9 = lst.next
	cmp		r9, 0			; lst.next == 0
	jz		return			; lst is over
	push	rdi				; save lst head
	mov		rdi, [r8]		; 1st arg = lst.data
	mov		rsi, [r9]		; 2nd arg = lst.next.data
	call	rcx				; call compare function
	pop		rdi				; restore lst head
	cmp		rax, 0			; check return of cmp
	jg		swap			; ret > 0, then swap
	jmp		next			; else loop

swap:
	mov		r10, [r8]		; r10 = lst.data
	mov		r11, [r9]		; r11 = lst.next.data
	mov		[r8], r11		; lst.data = r11
	mov		[r9], r10		; lst.next.data = r10
	mov		r8, [rdi]		; reset lst head
	; ret
	jmp		_loop

next:
	mov		r8, r9			; lst = lst.next
	jmp		_loop

return:
	ret
