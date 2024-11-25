/**
 * The main file of Lightstrike.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "./logging.c"

int main(int argc, char* argv[]) {
	if(argc < 2) {
		printf("%sError: lightstrike \"<command>\" [arguments]%s\n", TEXT_HRED, RESET);
		return -1;
	}

	char* buff = malloc(512);
	buff[0] = '\0';
	
	int adapt = 0;

	for(int i = 1; i < argc; ++i) {
		if(strcmp(argv[i], "-adapt") == 0) {
			adapt = 1;
		}
		else {
			if(i > 1) strcat(buff, " ");
			strcat(buff, argv[i]);
		}
	}
}
