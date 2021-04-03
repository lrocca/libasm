; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strdup.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: lrocca <marvin@42.fr>                      +;+  +:+       +;+         ;
;                                                 +;+;+;+;+;+   +;+            ;
;    Created: 2021/04/03 15:15:07 by lrocca            ;+;    ;+;              ;
;    Updated: 2021/04/03 15:15:10 by lrocca           ;;;   ;;;;;;;;.fr        ;
;                                                                              ;
; **************************************************************************** ;

	section	.text
	global	_ft_strdup
	extern	_ft_strlen
	extern	_malloc
	extern	_ft_strcpy
	extern	___error

; char		*ft_strdup(const char *rdi);

_ft_strdup:
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
	xor		rax, rax		; return null pointer
	ret
