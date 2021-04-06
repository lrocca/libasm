/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lrocca <marvin@42.fr>                      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/31 15:17:47 by lrocca            #+#    #+#             */
/*   Updated: 2021/04/06 20:14:57 by lrocca           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

#define NC "\x1b[0m"
#define GR "\x1b[32m"
#define RD "\x1b[31m"

#define OK GR "[OK]" NC " "
#define KO RD "[KO]" NC " "

#define BASE10 "0123456789"
#define BASE16 BASE10"abcdef"
typedef struct	s_list
{
	void			*data;
	struct s_list	*next;
}				t_list;

/*
** mandatory
*/
size_t	ft_strlen(const char *s);
char	*ft_strcpy(char *dst, const char *src);
int		ft_strcmp(const char *s1, const char *s2);
ssize_t	ft_write(int fildes, const void *buf, size_t nbyte);
ssize_t	ft_read(int fildes, void *buf, size_t nbyte);
char	*ft_strdup(const char *s1);

/*
** bonus
*/
int		ft_atoi_base(char *str, char *base);
void	ft_list_push_front(t_list **begin_list,void*data);
int		ft_list_size(t_list *begin_list);
void	ft_list_sort(t_list **begin_list, int(*cmp)());
void	ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void*));


void	test_strlen(void)
{
	puts("ft_strlen");

	if (strlen("ciao") == ft_strlen("ciao"))			printf(OK); else printf(KO);
	if (strlen("") == ft_strlen(""))					printf(OK); else printf(KO);
	if (strlen("ciao00000") == ft_strlen("ciao00000"))	printf(OK); else printf(KO);
	if (strlen("42") == ft_strlen("42"))				printf(OK); else printf(KO);

	puts("");
}

void	test_strcpy(void)
{
	puts("ft_strcpy");

	char	buffer[10];

	if (!strcmp("ciao", ft_strcpy(buffer, "ciao")))				printf(OK); else printf(KO);
	if (!strcmp("ciao00000", ft_strcpy(buffer, "ciao00000")))	printf(OK); else printf(KO);
	if (!strcmp("", ft_strcpy(buffer, "")))						printf(OK); else printf(KO);
	if (strcmp("ciao", ft_strcpy(buffer, "")))					printf(OK); else printf(KO);

	puts("");
}

void	test_strcmp(void)
{
	puts("ft_strcmp");

	if (strcmp("ciao", "ciao") == ft_strcmp("ciao", "ciao"))	printf(OK); else printf(KO);
	if (strcmp("ciao5", "ciao") == ft_strcmp("ciao5", "ciao"))	printf(OK); else printf(KO);
	if (strcmp("ciao", "ciaO") == ft_strcmp("ciao", "ciaO"))	printf(OK); else printf(KO);
	if (strcmp("ciao", "") == ft_strcmp("ciao", ""))			printf(OK); else printf(KO);

	puts("");
}

void	test_write(void)
{
	puts("ft_write");

	int	fd;
	fd = open("write", O_WRONLY, O_CREAT);

	if (write(fd, "ciao", 10) == ft_write(fd, "ciao", 10))	printf(OK); else printf(KO);
	if (write(-1, "ciao", 10) == ft_write(-1, "ciao", 10))	printf(OK); else printf(KO);
	if (write(fd, NULL, 10) == ft_write(fd, NULL, 10))		printf(OK); else printf(KO);
	if (write(fd, "ciao", 0) == ft_write(fd, "ciao", 0))	printf(OK); else printf(KO);

	close(fd);

	puts("");
}

void	test_read(void)
{
	puts("ft_read");

	int		fd;
	fd = open("test.c", O_RDONLY);

	char	buffer[10];

	if (read(fd, buffer, 10) == ft_read(fd, buffer, 10))	printf(OK); else printf(KO);
	if (read(-1, buffer, 10) == ft_read(-1, buffer, 10))	printf(OK); else printf(KO);
	if (read(fd, NULL, 10) == ft_read(fd, NULL, 10))		printf(OK); else printf(KO);
	if (read(fd, buffer, 0) == ft_read(fd, buffer, 0))		printf(OK); else printf(KO);

	close(fd);

	puts("");
}

void	test_strdup(void)
{
	puts("ft_strdup");

	if (!strcmp("ciao", ft_strdup("ciao")))				printf(OK); else printf(KO);
	if (!strcmp("ciao00000", ft_strdup("ciao00000")))	printf(OK); else printf(KO);
	if (!strcmp("", ft_strdup("")))						printf(OK); else printf(KO);
	if (strcmp("ciao", ft_strdup("")))					printf(OK); else printf(KO);

	puts("");
}

void	test_atoi_base(void)
{
	puts("ft_atoi_base");

	ft_atoi_base(" +--56", BASE10) == 56		? printf(OK) : printf(KO);
	ft_atoi_base("	---ff", BASE16) == -255		? printf(OK) : printf(KO);
	ft_atoi_base("\v-42", BASE10) == -42		? printf(OK) : printf(KO);
	ft_atoi_base("\f+-+-11101", "01") == 29		? printf(OK) : printf(KO);
	ft_atoi_base("  -+00501",BASE10) == -501	? printf(OK) : printf(KO);
	ft_atoi_base(" +105", BASE10) == 105		? printf(OK) : printf(KO);
	ft_atoi_base("  -+11", "") == 0				? printf(OK) : printf(KO);
	ft_atoi_base("15256", "5") == 0				? printf(OK) : printf(KO);
	ft_atoi_base("15", "-123456789") == 0		? printf(OK) : printf(KO);
	ft_atoi_base("122", "012+3456789") == 0		? printf(OK) : printf(KO);
	ft_atoi_base("122", "0 1") == 0				? printf(OK) : printf(KO);
	ft_atoi_base("568", "012345\t6789") == 0	? printf(OK) : printf(KO);
	ft_atoi_base("111", "01\r") == 0			? printf(OK) : printf(KO);
	ft_atoi_base("155", "01234506789") == 0		? printf(OK) : printf(KO);
	ft_atoi_base("05", "012345067890") == 0		? printf(OK) : printf(KO);
	ft_atoi_base("abc56", BASE10) == 0			? printf(OK) : printf(KO);

	puts("");
}

void	test_list_size(void)
{
	puts("ft_list_size");

	t_list	list;
	t_list	list_next;
	t_list	list_last;

	list.data = strdup("42");
	list.next = &list_next;
	list_next.data = strdup("43");
	list_next.next = &list_last;
	list_last.data = strdup("44");
	list_last.next = NULL;

	if (!ft_list_size(NULL))		printf(OK); else printf(KO);
	if (ft_list_size(&list) == 3)	printf(OK); else printf(KO);

	puts("");
}

int		main(void)
{
	test_strlen();
	test_strcpy();
	test_strcmp();
	test_write();
	test_read();
	test_strdup();

	puts("");

	test_atoi_base();
	test_list_size();
}
