; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strcmp.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: lrocca <marvin@42.fr>                      +;+  +:+       +;+         ;
;                                                 +;+;+;+;+;+   +;+            ;
;    Created: 2021/04/03 15:14:34 by lrocca            ;+;    ;+;              ;
;    Updated: 2021/04/03 15:14:36 by lrocca           ;;;   ;;;;;;;;.fr        ;
;                                                                              ;
; **************************************************************************** ;

	section	.text
	global	_ft_strcmp

; char		*ft_strcmp(const char *rdi, const char *rsi);

_ft_strcmp:
	mov		rcx, -1					; index starts from -1

_loop:
	inc		rcx						; increment index
	mov		al, byte [rdi + rcx]	; move to ret
	mov		bl, byte [rsi + rcx]	; move to ret
	cmp		al, 0					; if s1 is over
	je		_ret					; go to ret
	cmp		bl, 0					; if s2 is over
	je		_ret					; go to ret
	cmp		al, bl					; compare two chars
	je		_loop					; a == b

_ret:
	sub		al, bl					; get diff
	jz		eq						; diff is 0, ret = 0
	jl		less					; less than 0, ret = -1
	jg		more					; more than 0, ret = 1

eq:
	xor		rax, rax
	ret

less:
	mov		rax, -1
	ret

more:
	mov		rax, 1
	ret
