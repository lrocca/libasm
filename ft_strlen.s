; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_strlen.s                                        :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: lrocca <marvin@42.fr>                      +;+  +:+       +;+         ;
;                                                 +;+;+;+;+;+   +;+            ;
;    Created: 2021/04/02 16:48:39 by lrocca            ;+;    ;+;              ;
;    Updated: 2021/04/02 16:48:45 by lrocca           ;;;   ;;;;;;;;.fr        ;
;                                                                              ;
; **************************************************************************** ;

	section	.text
	global	_ft_strlen

; size_t	ft_strlen(const char *rdi);

_ft_strlen:
	mov		rax, -1				; start index from -1

loop:
	inc		rax					; increment index
	cmp		byte [rdi + rax], 0	; compare *(s + index)
	jnz		loop				; if not zero, loop

	ret							; return index
