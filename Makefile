
logredir.so:	logredir.c
	$(CC) -Wall -fPIC -shared -o $@ $< -ldl

all:	logredir.so

