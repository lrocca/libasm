# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lrocca <marvin@42.fr>                      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/31 14:54:52 by lrocca            #+#    #+#              #
#    Updated: 2021/04/03 20:30:31 by lrocca           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC		=	gcc
CFLAGS	=	-Wall -Wextra -Werror
RM		=	/bin/rm -f

NAME	=	libasm.a
MAIN	=	main.c
TEST	=	test
SRC		=	ft_strlen.s ft_strcpy.s ft_strcmp.s ft_write.s ft_read.s ft_strdup.s
SRC		+=	ft_list_size_bonus.s ft_atoi_base_bonus.s
OBJ		=	$(SRC:.s=.o)

all		:	$(NAME)

$(NAME)	:	$(OBJ)
	ar -rcs $@ $^

%.o		:	%.s
	nasm -fmacho64 $^ -o $@

$(TEST)	:	$(MAIN) $(NAME)
	$(CC) $(CFLAGS) -L. -lasm $< -o $@

clean	:
	$(RM) $(OBJ)
	$(RM) $(MAIN:.c=.o)

fclean	:	clean
	$(RM) $(NAME)
	$(RM) test

re		:	fclean all

bonus	:	all
