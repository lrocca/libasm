; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_remove_if_bonus.s                          :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: lrocca <marvin@42.fr>                      +;+  +:+       +;+         ;
;                                                 +;+;+;+;+;+   +;+            ;
;    Created: 2021/04/08 19:12:55 by lrocca            ;+;    ;+;              ;
;    Updated: 2021/04/08 19:12:56 by lrocca           ;;;   ;;;;;;;;.fr        ;
;                                                                              ;
; **************************************************************************** ;

	section	.text
	global	_ft_list_remove_if
	extern	_free

%macro PUSH_ALL 0
	push	rdi
	push	rsi
	push	rdx
	push	rcx
%endmacro

%macro POP_ALL 0
	pop		rcx
	pop		rdx
	pop		rsi
	pop		rdi
%endmacro

_ft_list_remove_if:
	push	rbp					; save base pointer
	mov		rbp, rsp			; copy stack pointer
	sub		rsp, 8				; align stack

	cmp		rdi, 0				; node == 0
	jz		return
	cmp		qword [rdi], 0		; *node == 0
	jz		return

	PUSH_ALL
	mov		rdi, [rdi]			; *node
	mov		rdi, [rdi + 0]		; (*node)->data
	call	rdx					; cmp((*node)->data, data_ref)
	POP_ALL
	cmp		rax, 0				; cmp returned 0, remove
	jz		remove

	mov		rdi, [rdi]			; *node
	lea		rdi, [rdi + 8]		; (*node)->next
	call	_ft_list_remove_if	; call recursively
	jmp		return

remove:
	mov		rax, [rdi]			; rax = *node
	mov		rax, [rax + 8]		; rax = rax->next
	mov		[rbp - 8], rax		; saved_next = (*node)->next

	PUSH_ALL
	mov		rdi, [rdi]			; *node
	mov		rdi, [rdi + 0]		; (*node)->data
	call	rcx					; free_fct((*node)->data)
	POP_ALL

	PUSH_ALL
	mov		rdi, [rdi]			; *node
	call	_free				; free(*node)
	POP_ALL

	mov		rax, [rbp - 8]		; get next node
	mov		[rdi], rax
	call	_ft_list_remove_if	; call recursively

return:
	mov		rsp, rbp			; restore stack pointer
	pop		rbp					; restore base pointer
	ret
