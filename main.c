/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lrocca <marvin@42.fr>                      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/31 15:17:47 by lrocca            #+#    #+#             */
/*   Updated: 2021/03/31 19:59:18 by lrocca           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <string.h>
#include <stdio.h>
#define CHECK(x,y) x == y

size_t	ft_strlen(const char *s);
char	*ft_strcpy(char *dst, const char *src);
int		ft_strcmp(const char *s1, const char *s2);
ssize_t	ft_write(int fildes, const void *buf, size_t nbyte);
ssize_t	read(int fildes, void *buf, size_t nbyte);
char	*ft_strdup(const char *s1);

int	main(void)
{
	char s[] = "";

	// printf("strcmp\t%lu == %lu\t%s\n", strlen(s), ft_strlen(s), strlen(s) == ft_strlen(s) ? "OK" : "KO");

	// char org[6];
	// char min[6];
	// strcpy(org, s);
	// ft_strcpy(min, s);
	// printf("strcpy\t\t%s\n", strcmp(org, min) ? "OK" : "KO");

	char s2[] = "";
	int ret = ft_strcmp(s, s2);
	printf("strcmp\t%d\t%s\n", ret, ret == strcmp(s, s2) ? "OK" : "KO");

	// ft_write(1, "hello", 6);

	return (0);
}
