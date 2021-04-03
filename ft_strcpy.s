; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcpy.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: lrocca <marvin@42.fr>                      +;+  +:+       +;+         ;
;                                                 +;+;+;+;+;+   +;+            ;
;    Created: 2021/04/03 15:14:46 by lrocca            ;+;    ;+;              ;
;    Updated: 2021/04/03 15:14:48 by lrocca           ;;;   ;;;;;;;;.fr        ;
;                                                                              ;
; **************************************************************************** ;

	section	.text
	global	_ft_strcpy

; char		*ft_strcpy(char *rdi, const char *rsi);

_ft_strcpy:
	xor		rcx, rcx				; index starts from 0

_loop:
	cmp		byte [rsi + rcx], 0		; compare *(str + index)
	jz		_ret					; src == 0, go to return
	mov		al, byte [rsi + rcx]	; move src (2nd arg) char to register
	mov		byte [rdi + rcx], al	; copy from register to dst (1st arg)
	inc		rcx						; increment index
	jmp		_loop					; repeat if not zero

_ret:
	mov		byte [rdi + rcx], 0		; null terminate dst
	mov		rax, rdi				; return dst
	ret
