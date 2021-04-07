; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    ft_atoi_base_bonus.s                               :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: lrocca <marvin@42.fr>                      +;+  +:+       +;+         ;
;                                                 +;+;+;+;+;+   +;+            ;
;    Created: 2021/04/03 15:51:50 by lrocca            ;+;    ;+;              ;
;    Updated: 2021/04/03 15:51:52 by lrocca           ;;;   ;;;;;;;;.fr        ;
;                                                                              ;
; **************************************************************************** ;

	section	.text
	global	_ft_atoi_base

; int		ft_atoi_base(char *rdi, char *rsi);

; rax = number
; r8 = base
; r9 = 1st iterator
; r10 = temporary char, sign flag
; dl = termporary char
; r11 = 2nd iterator

_ft_atoi_base:
	xor		rax, rax				; number = 0
	mov		r8, -1					; r8 = base

radix_loop:							; main radix loop check
	inc		r8						; increment base
	cmp		byte [rsi + r8], 0		; if radix is over
	jz		radix_validate			; validate base
	mov		r9, r8					; copy curr value to iterator
	mov		r10b, [rsi + r8]		; copy current char

radix_dup:							; look for following duplicate chars
	inc		r9						; next radix char
	cmp		byte [rsi + r9], 0		; if radix is over
	jz		radix_check				; go check char value
	cmp		byte [rsi + r9], r10b	; compare current with iterated
	je		error					; if equal, we have a duplicate
	jmp		radix_dup				; continue looking...

radix_check:						; radix can't contain the following chars
	cmp		byte [rsi + r8], 9		; '\t'
	je		error
	cmp		byte [rsi + r8], 10		; '\n'
	je		error
	cmp		byte [rsi + r8], 11		; '\v'
	je		error
	cmp		byte [rsi + r8], 12		; '\f'
	je		error
	cmp		byte [rsi + r8], 13		; '\r'
	je		error
	cmp		byte [rsi + r8], 32		; ' '
	je		error
	cmp		byte [rsi + r8], 43		; '+'
	je		error
	cmp		byte [rsi + r8], 45		; '-'
	je		error
	jmp		radix_loop				; continue looping radix

radix_validate:
	cmp		r8, 1					; if base <= 1
	jle		error					; go to error

	mov		r9, -1					; reset iterator
skip:								; skip number whitespaces
	inc		r9
	cmp		byte [rdi + r9], 9		; '\t'
	je		skip
	cmp		byte [rdi + r9], 10		; '\n'
	je		skip
	cmp		byte [rdi + r9], 11		; '\v'
	je		skip
	cmp		byte [rdi + r9], 12		; '\f'
	je		skip
	cmp		byte [rdi + r9], 13		; '\r'
	je		skip
	cmp		byte [rdi + r9], 32		; ' '
	je		skip
	xor		r10, r10				; reset sign flag
	jmp		sign

_neg:
	xor		r10b, 0x00000001		; invert previous value
_pos:
	inc		r9
sign:								; sign loop
	cmp		byte [rdi + r9], 43		; '+'
	je		_pos
	cmp		byte [rdi + r9], 45		; '-'
	je		_neg
	dec		r9						; i--

atoi:
	inc		r9						; i++
	cmp		byte [rdi + r9], 0		; if string is over
	jz		_ret					; go to ret
	mov		r11, -1					; reset j

atoi_loop:
	inc		r11						; next radix char
	mov		dl, byte [rdi + r9]		; copy current char
	cmp		byte [rsi + r11], 0		; if radix is over
	jz		_ret					; the number is over as well
	cmp		dl, byte [rsi + r11]	; compare with current radix char
	jne		atoi_loop				; continue looking for radix char

sum:
	mul		r8						; multiply actual number with base
	add		rax, r11				; add radix index
	jmp		atoi

_ret:
	cmp		r10, 0					; check if negative
	jz		return					; if 0, return positive
	neg		rax						; make negative, then return
return:
	ret

error:
	xor		rax, rax				; clean rax
	ret								; return 0
