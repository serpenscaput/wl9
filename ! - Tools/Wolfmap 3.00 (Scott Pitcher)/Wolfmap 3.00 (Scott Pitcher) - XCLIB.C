/*
** XCLIB.C Scott Pitcher, 1992
**
**      Extended standard library functions
*/

#include <stdio.h>
#include <alloc.h>
#include <stdlib.h>
#include <stdarg.h>
#include "xclib.h"

/* variables */

WORD _xclib_debug = 0;  /* generic library debug flag */
int _malloc_count = 0;  /* global memory usage tracking variable */
long _malloc_size = 0L;
static char szFatalError[] = "\n\aFatal Error - ";
static char szWriteError[] = "while writing to file : ";

/*
** gprintf() and gputs()
**
**      These are pointers to functions that the standard library calls
**      to do error output. They could be hooked by an external function
**      for sending error/debug messages to an alternate device or file.
*/

int (*gprintf)(const char *, ...);
int (*gputs)(const char *);

/*
** _xclib_ohook() and _xclib_ounhook()
**
**      These 2 functions are used for redirecting xclib library output,
**      and for directing it to the default device.
*/

void _xclib_ohook(int (*f1)(const char *, ...), int (*f2)(const char *))
{
	if(f1 != NULL)
		gprintf = f1;
	if(f2 != NULL)
		gputs = f2;
}

void _xclib_ounhook()
{
	gprintf = printf;
	gputs = puts;
}

/*
** xclib_init() and xclib_uninit()
**
**      These are internal functions for initialising the library. Do
**      not call them from a program.
*/

static void xclib_init()
{
	gprintf = printf;
	gputs = puts;
}

#pragma startup xclib_init

static void xclib_uninit()
{
	/* does nothing for now */
}
#pragma atexit xclib_uninit()

/*
** gmalloc()
**
**      This is an alternative memory allocation function that performs two
**      operations. Firstly it will automatically call exit() if a memory
**      allocation error occurs, after displaying an error message. Second
**      it will increment the global variable _malloc_count allowing for
**      memory usage tracking to be implemented.
*/

void *gmalloc(size_t size, int n)
{
	void *pTemp;

	pTemp = calloc(size, n);
	if(pTemp != NULL) {
		++_malloc_count;                /* register the allocation */
		_malloc_size += size * n;       /* and record the amount */
	}
	else {
		gprintf("\n\aMemory allocation error : %s", strerror(errno));
		exit(1);
	}
	if(_xclib_debug & XLIBDBG_MEM)
		xmem_debug("gmalloc()");
	return pTemp;
}

/*
** gfree()
**
**      This is the free function used with gmalloc(). It checks the heap and
**      the validity of the pointer that it receives when a call is made to free
**      memory.
*/

void gfree(void *p)
{
	struct heapinfo hinf;
	int i;

	if (heapcheck() == _HEAPCORRUPT) {
		gprintf("%scorrupt heap reported by heapcheck()", szFatalError);
		exit(1);
	}
	hinf.ptr = NULL;
	while(hinf.ptr != p) {
		switch(heapwalk(&hinf)) {
			case _HEAPEMPTY:
				gprintf( "%sfree() called when heap is empty", szFatalError);
				exit(1);
			case _HEAPCORRUPT:
				gprintf( "%scorrupt heap reported by heapwalk()", szFatalError);
				exit(1);
			case _BADNODE:
				gprintf( "%sbad node in heap", szFatalError);
				exit(1);
			case _HEAPEND :
				gprintf("%scannot find block referenced by free() in the heap", szFatalError);
				exit(1);                        
			case _HEAPOK :
				break;
			default:
				gprintf( "%sunknown error code from heapwalk()", szFatalError);
				exit(1);
		}
	}
	if(!hinf.in_use) {
		gprintf("%sattempt to free() unallocated block", szFatalError);
		exit(1);
	}
	_malloc_size -= hinf.size;
	--_malloc_count;
	free(p);
	if(_xclib_debug & XLIBDBG_MEM)
		xmem_debug("gfree()");
}

/*
** xmem_debug()
**
**      This function provides internal memory debbuging during allocation/deallocation
**      using the _xclib_debug flags. Calls are made from gfree() and gmalloc(), and
**      the information displayed will depend on the flags that are set. Calling functions
**      must provide their name.
*/

void xmem_debug(char *fn_name)
{
	struct heapinfo hinf;
	int i = 0;
	LONG mem;
	LONG free_mem = 0L, used_mem = 0L, largest_blk = 0L;
	WORD free_blks = 0, used_blks = 0;

	gprintf("\n***HEAP DEBUG DUMP***");
	gprintf("\n[called from '%s']", fn_name);
	gprintf("\n\n  block size   status");
	gprintf("\n---------------------------");
	hinf.ptr = NULL;
	while(i != _HEAPEND) {
		switch(i = heapwalk(&hinf)) {
			case _HEAPEMPTY:
				gprintf("\n  <-- heap  empty -->");
				break;
			case _HEAPCORRUPT:
				gprintf( "%scorrupt heap reported by heapwalk()", szFatalError);
				exit(1);
			case _BADNODE:
				gprintf( "%sbad node in heap", szFatalError);
				exit(1);
			case _HEAPEND :
				break;
			case _HEAPOK :
#if __TINY__ || __SMALL__ || __MEDIUM__
				gprintf("\n%7u         ", hinf.size);
#else
				gprintf("\n%7lu         ", hinf.size);
#endif
				if(hinf.in_use) {
					used_mem += hinf.size;
					++used_blks;
					gprintf("used");
				}
				else {
					free_mem += hinf.size;
					++free_blks;
					if(hinf.size > largest_blk)
						largest_blk = hinf.size;
					gprintf("free");
				}
				break;
			default:
				gprintf( "%sunknown error code from heapwalk()", szFatalError);
				exit(1);
		}
	}
	mem = coreleft();
#if __TINY__ || __SMALL__ || __MEDIUM__
	gprintf("\n%7u         free (core)", mem);
#else
	gprintf("\n%7lu         free (core)", mem);
#endif
	free_mem += mem;
	++free_blks;
	if(mem > largest_blk)
		largest_blk = mem;
	gprintf("\n---------------------------");
	gprintf("\n%s%9.9lu\n%s%9.9lu\n%s%9.9u\n%s%9.9u\n%s%9.9lu\n",
		"Total Free Heap    : ", free_mem,
		"Total Used Heap    : ", used_mem,
		"Total Free Blocks  : ", free_blks,
		"Total Used Blocks  : ", used_blks,
		"Largest Free Block : ", largest_blk);
	gprintf("\n-----------------------");
}
/*
** gfopen()
**
**      This function is an alternative to the fopen() in stdio, as it does
**      an error check and calls exit() if unable to open the file.
*/

FILE *gfopen(char *filename, char *mode)
{
	FILE *fpTemp;

	if((fpTemp = fopen(filename, mode)) == NULL) {
		gprintf("%sunable to open file %s : %s", szFatalError, filename, strerror(errno));
		exit(1);
	}
	return fpTemp;
}

/*
** gfclose()
**
**      This function corresponds with gfopen() function.
*/

void gfclose(FILE *fp)
{
	if(fclose(fp) == EOF) {
		gprintf("%sunable to close file : %s", szFatalError, strerror(errno));
		exit(1);
	}
}

/*
** gfprintf()
**
**      This function writes output to a file in the same fashion that fprintf does,
**      except that an exit() will occur if an error occurs, with error an message
**      written to the console.
*/

void gfprintf(FILE *fp, const char *format, ... )
{
	va_list arg_list;

	va_start(arg_list, format);     
	if(vfprintf(fp, format, arg_list) == EOF) {
		gprintf("%s%s%s", szFatalError, szWriteError, strerror(errno));
		exit(1);
	}
	va_end(arg_list);
}

/*
** gfwrite()
**
**      This function provides an alternative way of writing to files, performing
**      error checking and calling exit() if a file error occurs.
*/

size_t gfwrite(const void *p, size_t size, size_t n, FILE *fp)
{
	size_t i;

	if((i = fwrite(p, size, n, fp)) != n) {
		gprintf("%s%s%s", szFatalError, szWriteError, strerror(errno));
		exit(1);
	}
	return i;
}

/*
** gfread()
**
**      This function provides an alternative way of reading from a file. Error
**      checking is performed, and if true a string is written to the console,
**      and exit() is called.
*/

size_t gfread(const void *p, size_t size, size_t n, FILE *fp)
{
	size_t i;

	i = fread(p, size, n, fp);
	if(ferror(fp)) {
		gprintf("%sa read error occured : %s", szFatalError, strerror(errno));
		exit(1);
	}
	return i;
}

/*
** gfgets()
**
**      This function provides an alternative way of reading a string
**      from a file.
*/

char *gfgets(char *s, int n, FILE *fp)
{
	return fgets(s,n,fp);
}
	
/*
** gfputs()
**
**      This function provides an alternative way of writing a const char string to a
**      file, performing error checking and calling exit() if a file error occurs.
*/

void gfputs(const char *s, FILE *fp)
{
	if(fputs(s, fp) == EOF) {
		gprintf("%s%s%s", szFatalError, szWriteError, strerror(errno));
		exit(1);
	}
}

/*
** gfseek()
**
**      This function provides an alternative way of performing fseek() operations,
**      as it performs error checking, and calls exit() if one occurs.
*/

void gfseek(FILE *fp, long h, int w)
{
	if(fseek(fp,h,w)) {
		gprintf("%sduring an fseek() operation : %s", szFatalError, strerror(errno));
		exit(1);
	}
}

/*
** fsize()
**
**	Returns the size in bytes of a file.
*/

long fsize(FILE *fp)
{
	long curpos, length;

	curpos = ftell(fp);
	fseek(fp, 0L, SEEK_END);
	length = ftell(fp);
	fseek(fp, curpos, SEEK_SET);
	return length;
}

