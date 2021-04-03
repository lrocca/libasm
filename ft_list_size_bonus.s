; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_list_size_bonus.s                               :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: lrocca <marvin@42.fr>                      +;+  +:+       +;+         ;
;                                                 +;+;+;+;+;+   +;+            ;
;    Created: 2021/04/03 16:18:45 by lrocca            ;+;    ;+;              ;
;    Updated: 2021/04/03 16:18:45 by lrocca           ;;;   ;;;;;;;;.fr        ;
;                                                                              ;
; **************************************************************************** ;

	section	.text
	global	_ft_list_size

; int		ft_list_size(t_list *rdi);

_ft_list_size:
	xor		rax, rax			; start count from 0

loop:
	cmp		rdi, 0				; compare node
	jz		ret					; if end of list, go to ret
	inc		rax					; increment count
	mov		rdi, [rdi + 8]		; move to next node
	jmp		loop				; if not zero, loop

ret:
	ret							; return count
