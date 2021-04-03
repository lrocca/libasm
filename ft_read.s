; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_read.s                                          :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: lrocca <marvin@42.fr>                      +;+  +:+       +;+         ;
;                                                 +;+;+;+;+;+   +;+            ;
;    Created: 2021/04/03 15:14:17 by lrocca            ;+;    ;+;              ;
;    Updated: 2021/04/03 15:14:19 by lrocca           ;;;   ;;;;;;;;.fr        ;
;                                                                              ;
; **************************************************************************** ;

	section	.text
	global	_ft_read
	extern	___error

_ft_read:
	mov		rax, 0x02000003		; set system call for read
	syscall						; invoke operating system
	jc		error				; if carry flag exists, there was an err
	ret							; if everything went well, rax was set automatically

error:
	push	rax					; save errno
	call	___error			; set rax to errno pointer
	pop		qword [rax]			; set errno
	mov		rax, -1				; set ret to -1
	ret
