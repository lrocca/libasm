; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_push_front_bonus.s                         :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: lrocca <marvin@42.fr>                      +;+  +:+       +;+         ;
;                                                 +;+;+;+;+;+   +;+            ;
;    Created: 2021/04/08 19:12:01 by lrocca            ;+;    ;+;              ;
;    Updated: 2021/04/08 19:12:02 by lrocca           ;;;   ;;;;;;;;.fr        ;
;                                                                              ;
; **************************************************************************** ;

	section	.text
	global	_ft_list_push_front
	extern	_malloc

_ft_list_push_front:		; rdi = t_list **head, rsi = void *data
	push	rdi				; save head
	push	rsi				; save data
	mov		rdi, 16			; sizeof(t_list)
	xor		rax, rax		; clear rax
	call	_malloc
	pop		rsi
	pop		rdi
	cmp		rax, 0
	jz		return			; malloc failed
	mov		[rax], rsi		; lst.data = rsi
	mov		rcx, [rdi]		; tmp = *head
	mov		[rax + 8], rcx	; lst.next = tmp
	mov		[rdi], rax		; *head = new
return:
	ret
