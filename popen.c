/* nostt.c - Copyright (c) 2018, Sijmen J. Mulder (see LICENSE.md) */

#include <sys/stat.h>	/* mkfifo */
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <err.h>

/* defined by Makefile: VERSION */

const char usage[] =
"usage: popen [-V] command [argument ...]\n";

int
main(int argc, char **argv) {
	int opt;
	char *path;
	int fd;

	while ((opt = getopt(argc, argv, "V")) != -1) {
		switch (opt) {
		case 'V':
			puts("popen " VERSION);
			return 0;
		default:
			return 1;
		}
	}

	if (argc == optind) {
		fputs(usage, stderr);
		return 1;
	}

	if (!(path = tmpnam(NULL)))
		err(1, NULL);

	puts(path);
	fclose(stdout); /* unblock the shell */

	switch (fork()) {
	case -1:
		err(1, NULL);
	case 0:
		if (mkfifo(path, 0600) == -1)
			err(1, NULL);
		if ((fd = open(path, O_WRONLY)) == -1)
			err(1, NULL);
		if (dup2(fd, STDOUT_FILENO) == -1)
			err(1, NULL);
		execvp(argv[optind], &argv[optind]);
		err(1, NULL);
	default:
		return 0;
	}
}
