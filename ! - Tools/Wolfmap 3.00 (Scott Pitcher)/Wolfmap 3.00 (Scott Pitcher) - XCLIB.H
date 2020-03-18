/*
**      The extended c-lib functions and definitions.
*/

/* bring in some required defs */


#if !defined( __STDIO_H )
#include <stdio.h>
#endif

#if !defined( __STDLIB_H )
#include <stdlib.h>
#endif

/* some common defs */

typedef unsigned char BYTE;
typedef unsigned int WORD;
typedef unsigned long LONG;

#define HIBYTE(a) (*(((BYTE *) &a) + 1))
#define LOBYTE(a) (*((BYTE *) &a))
#define HIWORD(a) (*(((WORD *) &a) + 1))
#define LOWORD(a) (*((WORD *) &a))

/* 'graceful' file and memory functions */

void _xclib_ohook(int (*)(const char *, ...), int (*)(const char *));
void _xclib_ounhook(void);
void *gmalloc(size_t, int);
void gfree(void *);
FILE *gfopen(char *, char *);
void gfclose(FILE *);
void gfprintf(FILE *, const char *, ... );
size_t gfwrite(const void *, size_t, size_t, FILE *);
size_t gfread(const void *, size_t, size_t, FILE *);
char *gfgets(char *, int ,FILE *);
void gfputs(const char *, FILE *);
void gfseek(FILE *, long, int);
void xmem_debug(char *);
long fsize(FILE *);

/* re-directable functions */

extern int (*gprintf)(const char *, ...);
extern int (*gputs)(const char *);

/* global vars for the memory usage tracker */

extern WORD _xclib_debug;
extern int _malloc_count;
extern long _malloc_size;

/* xclib debugging bit flags */

#define XLIBDBG_MEM             0x0001  /* use for heap debugger */
