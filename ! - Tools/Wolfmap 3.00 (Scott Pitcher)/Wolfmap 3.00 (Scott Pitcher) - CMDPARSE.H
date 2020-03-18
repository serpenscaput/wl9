/*
** CMDPARSE.H, 1992 Scott Pitcher
** The constants and function declarations for the command line parser.
*/

#define NOIGNORECASE	0	/* constants for the case_flag parameter */
#define IGNORECASE	1

#define NOTASWITCH	-1	/* constants for the return values */
#define ILLEGALSWITCH	-2
#define ENDOFARGUMENT	-3
#define EXTRAPARAMS	-4

int cmdln_parse(char **, char *, char *, int);

