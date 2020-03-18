/*
** CMDPARSE.C, 1992 Scott Pitcher
** This module provides a simple command line parser for parsing command line
** switches and their parameters.
** Parameters:
**	char **format	- This is a pointer to a RAGGED array of strings which are the valid command line
**			  switch characters or strings, without any leading switch chars, and terminated
**			  by a NULL pointer.
**	char *argv	- The argument that the function is, or is going to pass.
**	char *dest	- The destination char array for any parameters or illegal switches to be copied
**			  into.
**	int case_flag	- specifies whether to do a case sensitive or non-case sensitive comparison. Use
**			  the IGNORECASE and NOIGNORECASE constants from cmdparse.h .
** Returns:
**	0 -> n		- Where 'n' is the number of elements in the format array. This is the switch
**			  number that was found in the argv string. Any additional parameters after the
**			  '=' or ':' are copied to *dest.
**	ENDOFARGUMENT	- cmdl_parse has finished scanning the current *argv string and requires a new one.
**	NOTASWITCH	- Found something that did not have a switch character in front of it, such as a
**			  file name or a drive letter etc. The 'something' is copied back into *dest for
**			  you to use.
**	ILLEGALSWITCH	- Found something that did have a switch character in front of it, but could not
**			  find it in the format array. The switch, including the leading switch char is
**			  copied back into *dest.
**	EXTRAPARAMS	- A valid switch was found, but it was trailed by ':' or '=', possibly with
**			  parameters following. The entire switch and parameters are copied back to *dest
**			  and the switch number (0 -> n) is returned next time cmdln_parse() is called.
**
** Notes:
**  This function operates like a simple state machine, using the flag 'STATE' to indicate what it is
** currently doing. Each argument string is passed to the function repeatedly until an ENDOFARGUMENT
** value is returned. This allows switches with no embedded blanks to be parsed (eg. '/F/G/H'). The
** following list is the states that cmdln_parse() uses.
**
**	STATE			DESCRIPTION
**	-----			-----------
**	  0	Waiting for a new argument. This is the intial state, and it changes to state 1
**		when a new argument string is received.
**	  1	Evaluating an argument. This is the working state of cmdln_parse() and indicates
**		that it is currently parsing an argument. Changes to state 2 when the NULL char
**		at the end of the argument string is reached.
**	  2	End of argument. In this state an ENDOFARGUMENT value is returned to the caller,
**		and the state is changed to 0, waiting for a new argument.
**	  3	Extra parameters. To be in this state an EXTRAPARAMS value must have been returned
**		to the previous caller, so this time through we return the actual switch number
**		to the caller. This allows a program to decide what to do with extra parameters.
**		Change to state 1.
**	  4	Extra parameters & end of argument. This is similar to state 3 except that the
**		end of the argument follows the extra parameter. Change to state 2.
*/

#include <stdlib.h>
#include <string.h>
#include "cmdparse.h"

int cmdln_parse(char **format, char *argv, char *dest, int case_flag)
{
	static char *c_argv;
	static int STATE;
	static int last_switch;
	int length, ret_code = 0;
	int copy_flag = 0;

	switch(STATE) {
		case 0 :			/* starting a new argument */		    
		    STATE = 1;			/* change to evaluating an argument */
		    c_argv = argv;		/* set the current argument pointer to the new one */
		    break;
		case 2 :			/* just completed evaluating an argument */
		    STATE = 0;			/* prepare parser for next argument */
		    return ENDOFARGUMENT;	/* inform caller of completion */
		case 3 :			/* had a switch with extra parameters */
		    STATE = 1;			/* but not the end of argument */
		    return last_switch;		/* give caller the last switch */
		case 4 :			/* had a switch with extra parameters */
		    STATE = 2;			/* and the end of argument */
		    return last_switch;		/* give caller the last switch */
		default :
		    break;
	}
	while(*c_argv == ' ')	/* skip leading blanks */
		++c_argv;
	if(*c_argv == '/' || *c_argv == '-') {
		++c_argv;	/* found an argument - skip the switch character */
		while(*format != NULL) {
			length = strlen(*format);
			if( (case_flag == IGNORECASE && !strnicmp(c_argv, *format, length)) ||
			    (case_flag == NOIGNORECASE && !strncmp(c_argv, *format, length)) ) {
			    	/* check for mismatch eg. /F and /FD         */
			    	/* check for parameters eg. /F:              */
			    	/* check for extra parameters eg. /F and /F: */
			    	/* check for legal switch eg. /F and /F      */
			    	if(*(c_argv + length - 1) == ':' || *(c_argv + length - 1) == '=') {
			    		/* got some parameters to copy */
			    		c_argv += length;
			    		copy_flag = 1;
			    		break;
			    	}
			    	else if(*(c_argv + length) == ':' || *(c_argv + length) == '=') {
			    		/* got extra parameters */
			    		*dest++ = *(--c_argv);
			    		++c_argv;
			    		last_switch = ret_code;
			    		ret_code = EXTRAPARAMS;
			    		copy_flag = 1;
			    		STATE = 3;
			    		break;
			    	}
				else if(*(c_argv + length) == ' ' || *(c_argv + length) == '\0' ||
			    	        *(c_argv + length) == '-' || *(c_argv + length) == '/') {
			    		/* must have a legal switch */
			    		c_argv += length;
			    		break;
			    	}
			}
			++ret_code;	/* count the argument in format string */
			++format;	/* point to next argument in format string */
		}
		if(*format == NULL) {	/* if format is null then the loop above matched no argument in format */
			ret_code = ILLEGALSWITCH;
			*dest++ = *(--c_argv);	/* copy the switch character */
			++c_argv;
			copy_flag = 1;
		}
	}
	else {		/* not a switch character */
		ret_code = NOTASWITCH;
		copy_flag = 1;
	}
	if(copy_flag == 1)	/* c_argv should point to what is to be copied to *dest */
		while(*c_argv != '/' && *c_argv != '-' && *c_argv != '\0' && *c_argv != ' ')
			*dest++ = *c_argv++;
	*dest = '\0';		/* will either terminate *dest or make it a NULL string */
	if(*c_argv == '\0')
		if(STATE == 3)	/* if we hit the end of the argument then tell the caller next time through */
			STATE = 4;
		else
			STATE = 2;
	return ret_code;
}
