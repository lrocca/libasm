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
	push	rbp
	mov		rbp, rsp
	sub		rsp, 8

	cmp		rdi, 0
	je		return
	cmp		qword [rdi], 0
	je		return

	PUSH_ALL
	mov		rdi, [rdi]
    mov		rdi, [rdi + 0]
    call	rdx					; cmp((*begin_list)->data, data_ref)
	POP_ALL
	cmp		rax, 0
	jz		remove

	push	rdi
	mov		rdi, [rdi]
	lea		rdi, [rdi + 8]
	call	_ft_list_remove_if	; recursive
	pop		rdi
	jmp		return

remove:
	mov		rax, [rdi]			; rax = *begin_list
	mov		rax, [rax + 8]		; rax = rax->next
	mov		[rbp - 8], rax		; saved_next = (*begin_list)->next

	push rdi					; strange behavior
	PUSH_ALL
	mov		rdi, [rdi]
	mov		rdi, [rdi + 0]
	call rcx					; free_fct((*begin_list)->data)
	POP_ALL
	pop  rdi

	PUSH_ALL
	mov		rdi, [rdi]
	call	_free				; free(*begin_list)
	POP_ALL

	mov		rax, [rbp - 8]
	mov		[rdi], rax
	call	_ft_list_remove_if

return:
	mov		rsp, rbp
	pop		rbp
	ret
