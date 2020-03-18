/*
** WOLFMAP.C, Scott Pitcher 1992 [public domain]
**
**	This program creates ascii maps from the 3D Wolfenstein data files.
**	It works for both Wolf1 and Wolf6. The map data and object codes were
**	taken from a file written by D.A.G. and thanks to John 
**	for a copy of the .WL6 data files so I could determine the Wolf6 data
**	structure.
**
**	To use this program ...
**
**	C:\>WOLFMAP [switches] [map numbers] {output file name}
**
**	Version 2 update ... 19/11/92
**	- added support for Spear of Destiny demo version
**
**	Version 3 update ... 02/12/92
**	- added support for Spear of Destiny 18 level version
*/

#include <stdio.h>
#include <dir.h>
#include <xclib.h>
#include <cmdparse.h>

/* function prototypes */

int main(int, char **);
void WriteMap(int);
unsigned int scan_array(unsigned int, struct WolfCodes *);
void ReadMapData(void);
void ReadMapHeader(int);
void DecompressMapData(void);
int pass1_decode(int, unsigned int *, unsigned int *);
int pass2_decode(unsigned int *, unsigned int *);
void DataHexDump(void);
void mapkey(void);
void help(void);

/* Wolfenstein map header data structures -
** Notes:
**	The WL1 header structure is esentially the same as the WL6 header except it does not
**	contain the id_name[4] field at the end. More importantly the MapStart, ObjStart and DataEnd
**	file offsets point to the data marker ( 0x00, 0x20) whereas the WL6 pointers point to the word
**	before the data marker, which should is not part of the map data.
*/

typedef struct {
	long MapStart;		/* offset of the start of the map data - see notes */
	long ObjStart;		/* offset of the start of the object data */
	long DataEnd;		/* offset of the end of the data for this level */
	char unknown[6];
	int map_width;
	int map_height;
	char level_name[16];	/* null padded if length < 16 */
	char id_name[4];	/* for WL6 only */
	} WOLFHEADSTRUCT;

/* Object and Mapcode arrays */

struct WolfCodes { unsigned int typeCode;
		   unsigned int asciiCode;
		   unsigned char colourCode;
		   char *name; };

struct WolfCodes ObjCodes[] =
      { {0x00,0x00,0x07,"Nothing"},
 	{0x13,0x3e3c,0x0a,"You_Start_Nth"},
 	{0x14,0x3e3c,0x0a,"You_Start_East"},
 	{0x15,0x3e3c,0x0a,"You_Start_Sth"},
 	{0x16,0x3e3c,0x0a,"You_Start_West"},
 	{0x17,0xf7,0x07,"Puddle"},
 	{0x18,0x6c62,0x07,"Barrel/green"},
 	{0x19,0xd1,0x07,"Table&Chairs"},
 	{0x1a,0xf4,0x07,"Lamp"},
 	{0x1b,0x2a,0x07,"Chandelier"},
 	{0x1c,0x6f62,0x07,"Bones/shackle"},
 	{0x1d,0xf8,0xcf,"Dog_Food"},
 	{0x1e,0x49,0x07,"Stone_Pillar"},
 	{0x1f,0x05,0x07,"Pot_plant"},
 	{0x20,0x6f62,0x07,"Bones1"},
 	{0x21,0x2a,0x07,"Wash_basin"},
 	{0x22,0x05,0x07,"Vase_Plant"},
 	{0x23,0x76,0x07,"Vase"},
 	{0x24,0xd1,0x07,"Round_table"},
 	{0x25,0xf8,0x07,"Light/Ceiling"},
 	{0x26,0x2a,0x07,"Pots&Pans"},
 	{0x27,0x92,0x07,"Armor"},
 	{0x28,0x6f62,0x07,"Bones/CageEmpty"},
 	{0x29,0x6f62,0x07,"Bones/cage"},
 	{0x2a,0x6f62,0x07,"Bones2"},
 	{0x2b,0x674b,0x0e,"Key(Gold)"},
 	{0x2c,0x624b,0x0e,"Key(Cyan)"},
 	{0x2d,0x2a,0x07,"Bed"},
 	{0x2e,0xf8,0x07,"Dog_food(Empty)"},
 	{0x2F,0x03,0xcF,"Food"},
 	{0x30,0x2B,0xcf,"Red_Cross"},
 	{0x31,0xFE,0xcF,"Ammo"},
 	{0x32,0x674d,0xcF,"Gun(SubM)"},
 	{0x33,0x6753,0xcf,"Gun(Super)"},
 	{0x34,0x7224,0x0e,"Treasure_Cross"},
 	{0x35,0x6724,0x0e,"Treasure_Goblet"},
 	{0x36,0x6824,0x0e,"Treasure_Chest"},
 	{0x37,0x6324,0x0e,"Treasure_Crown"},
 	{0x38,0x02,0xcF,"Extra_Life"},
 	{0x39,0x2a,0x04,"Gore_On_Floor"},
 	{0x3a,0x62,0x07,"Barrel/wood"},
 	{0x3b,0x77,0x07,"Well/full"},
 	{0x3c,0x77,0x07,"Well/empty"},
 	{0x3d,0x2a,0x04,"Blood_On_Floor"},
 	{0x3e,0x14,0x07,"Flag_pole"},
 	{0x3f,0x6741,0x04,"Call_Apogee"},	/* WL6 - the secret code word */
	{0x40,0x6f62,0x00,"Bones5"},		/* WL6 - extra bones */
	{0x41,0x6f62,0x00,"Bones3"},
	{0x42,0x6f62,0x00,"Bones4"},		/* WL6 - extra bones */
	{0x45,0x7073,0x00,"Spear_Rack"},	/* WL6 - spear racks */
	{0x46,0xf7,0x00,"Green_vines"},		/* WL6 - some green vines */
 	{0x49,0x3f,0x04,"##????"},
 	{0x5a,0x1A,0x08,"enemy_vector_R"},
 	{0x5b,0x2f,0x08,"enemy_vector_UR"},
 	{0x5c,0x18,0x08,"enemy_vector_U"},
 	{0x5d,0x5c,0x08,"enemy_vector_UL"},
 	{0x5e,0x1b,0x08,"enemy_vector_L"},
 	{0x5f,0x2f,0x08,"enemy_vector_DL"},
 	{0x60,0x19,0x08,"enemy_vector_D"},
 	{0x61,0x5c,0x08,"enemy_vector_DR"},
 	{0x62,0x2153,0xa0,"Secret_Door"},
 	{0x63,0x3c3e,0x04,"##Exit_trigger#"},
 	{0x64,0x3f,0x04,"##????"},
 	{0x65,0x3f,0x04,"##????"},
 	{0x66,0x3f,0x04,"##????"},
 	{0x67,0x3f,0x04,"##????"},
 	{0x68,0x3f,0x04,"##????"},
 	{0x69,0x3f,0x04,"##????"},
 	{0x6a,0x3f,0x04,"##????"},
 	{0x6b,0x3f,0x04,"##????"},
 	{0x6c,0x3167,0x06,"Guard1_E"},
 	{0x6d,0x3167,0x06,"Guard1_N"},
 	{0x6e,0x3167,0x06,"Guard1_W"},
 	{0x6f,0x3167,0x06,"Guard1_S"},
 	{0x70,0x3167,0x06,"*Guard1E"},
 	{0x71,0x3167,0x06,"*Guard1N"},
 	{0x72,0x3167,0x06,"*Guard1W"},
 	{0x73,0x3167,0x06,"*Guard1S"},
 	{0x74,0x3f,0x04,"##????"},
 	{0x75,0x3f,0x04,"##????"},
 	{0x76,0x3f,0x04,"##????"},
 	{0x77,0x3f,0x04,"##????"},
 	{0x78,0x3f,0x04,"##????"},
 	{0x79,0x3f,0x04,"##????"},
 	{0x7a,0x3f,0x04,"##????"},
 	{0x7b,0x3f,0x04,"##????"},
 	{0x7c,0x9D,0x06,"Dead_Guard"},
 	{0x7d,0x3f,0x04,"NULL"},
 	{0x7e,0x3173,0x09,"SSGuard1_E"},
 	{0x7f,0x3173,0x09,"SSGuard1_N"},
 	{0x80,0x3173,0x09,"SSGuard1_W"},
 	{0x81,0x3173,0x09,"SSGuard1_S"},
 	{0x82,0x3173,0x09,"*SSGuard1E"},
 	{0x83,0x3173,0x09,"*SSGuard1N"},
 	{0x84,0x3173,0x09,"*SSGuard1W"},
 	{0x85,0x3173,0x09,"*SSGuard1S"},
 	{0x8a,0x3164,0x06,"*Dog1_E"},
 	{0x8b,0x3164,0x06,"*Dog1_N"},
 	{0x8c,0x3164,0x06,"*Dog1_W"},
 	{0x8d,0x3164,0x06,"*Dog1_S"},
 	{0x90,0x3367,0x06,"Guard3_E"},
 	{0x91,0x3367,0x06,"Guard3_N"},
 	{0x92,0x3367,0x06,"Guard3_W"},
 	{0x93,0x3367,0x06,"Guard3_S"},
 	{0x94,0x3367,0x06,"*Guard3E"},
 	{0x95,0x3367,0x06,"*Guard3N"},
 	{0x96,0x3367,0x06,"*Guard3W"},
 	{0x97,0x3367,0x06,"*Guard3S"},
 	{0x98,0x3f,0x04,"##????BAD"},
 	{0xa2,0x3373,0x09,"SSGuard3_E"},
 	{0xa3,0x3373,0x09,"SSGuard3_N"},
 	{0xa4,0x3373,0x09,"SSGuard3_W"},
 	{0xa5,0x3373,0x09,"SSGuard3_S"},
 	{0xa6,0x3373,0x09,"*SSGuard3_E"},
 	{0xa7,0x3373,0x09,"*SSGuard3_N"},
 	{0xa8,0x3373,0x09,"*SSGuard3_W"},
 	{0xa9,0x3373,0x09,"*SSGuard3_S"},
 	{0xae,0x3364,0x06,"*Dog3_E"},
 	{0xaf,0x3364,0x06,"*Dog3_N"},
 	{0xb0,0x3364,0x06,"*Dog3_W"},
 	{0xb1,0x3364,0x06,"*Dog3_S"},
 	{0xb4,0x3467,0x06,"Guard4_E"},
 	{0xb5,0x3467,0x06,"Guard4_N"},
 	{0xb6,0x3467,0x06,"Guard4_W"},
 	{0xb7,0x3467,0x06,"Guard4_S"},
 	{0xb8,0x3467,0x06,"*Guard4E"},
 	{0xb9,0x3467,0x06,"*Guard4N"},
 	{0xba,0x3467,0x06,"*Guard4W"},
 	{0xbb,0x3467,0x06,"*Guard4S"},
 	{0xc4,0x6442,0x09,"Big_Bad_Doctor"},		/* WL6 - the evil Doctor */
 	{0xc6,0x3473,0x09,"SSGuard4_E"},
 	{0xc7,0x3473,0x09,"SSGuard4_N"},
 	{0xc8,0x3473,0x09,"SSGuard4_W"},
 	{0xc9,0x3473,0x09,"SSGuard4_S"},
 	{0xca,0x3473,0x09,"*SSGuard4_E"},
 	{0xcb,0x3473,0x09,"*SSGuard4_N"},
 	{0xcc,0x3473,0x09,"*SSGuard4_W"},
 	{0xcd,0x3473,0x09,"*SSGuard4_S"},
 	{0xd2,0x3464,0x06,"*Dog4_E"},
 	{0xd3,0x3464,0x06,"*Dog4_N"},
 	{0xd4,0x3464,0x06,"*Dog4_W"},
 	{0xd5,0x3464,0x06,"*Dog4_S"},
 	{0xd6,0x6742,0x09,"Big_Bad_Guy"},
 	{0xd8,0x316e,0x00,"Ninja_guard1_E"},		/* WL6 - black guards */
 	{0xd9,0x316e,0x00,"Ninja_guard1_N"},
 	{0xda,0x316e,0x00,"Ninja_guard1_W"},
 	{0xdb,0x316e,0x00,"Ninja_guard1_S"},
 	{0xdc,0x316e,0x00,"XNinja_guard1_E"},
	{0xdd,0x316e,0x00,"XNinja_guard1_N"},
	{0xde,0x316e,0x00,"XNinja_guard1_W"},
 	{0xdf,0x316e,0x00,"XNinja_guard1_S"},
 	{0xea,0x336e,0x00,"Ninja_guard3_E"},
 	{0xeb,0x336e,0x00,"Ninja_guard3_N"},
	{0xec,0x336e,0x00,"Ninja_guard3_W"},
	{0xed,0x336e,0x00,"Ninja_guard3_S"},
	{0xee,0x336e,0x00,"XNinja_guard3_E"},
	{0xef,0x336e,0x00,"XNinja_guard3_N"},
	{0xf0,0x336e,0x00,"XNinja_guard3_W"},
	{0xf1,0x336e,0x00,"XNinja_guard3_S"},
 	{0xfc,0x346e,0x00,"*Ninja_guard4_E"},
	{0xfd,0x346e,0x00,"*Ninja_guard4_N"},
	{0xfe,0x346e,0x00,"*Ninja_guard4_W"},
	{0xff,0x346e,0x00,"*Ninja_guard4_S"},
	{0x100,0x346e,0x00,"*XNinja_guard4_"},		/* WL6 - black guard??? */
	{0x101,0x346e,0x00,"*XNinja_guard4_"},
	{0x102,0x346e,0x00,"*XNinja_guard4_"},		/* WL6 - black guard??? */
	{0x103,0x346e,0x00,"*XNinja_guard4_"},
	{0x00,0x00,0x00,NULL} };

struct WolfCodes MapCodes[] =
      { {0x00,0x20,0x90,"Floor_0"},
 	{0x01,0xb0,0x8F,"Grey_1"},
 	{0x02,0xb1,0x8F,"Grey_2"},
 	{0x03,0x46,0x8F,"Grey_flag"},
 	{0x04,0x48,0x8F,"Grey_Hitler"},
 	{0x06,0xEF,0x8F,"Grey_arch"},
 	{0x05,0x20,0x9F,"Empty_Cell"},
 	{0x07,0x20,0x9F,"Full_Cell"},
 	{0x08,0xb1,0x9F,"Blue_1"},
 	{0x09,0xb2,0x9F,"Blue_2"},
 	{0x0A,0x45,0x6F,"Wood_Eagle"},
 	{0x0B,0x48,0x6F,"Wood_Hitler"},
 	{0x0C,0x57,0x6F,"Wood"},
 	{0x0D,0x0F,0xa8,"Entrance"},
 	{0x0E,0x56,0x7F,"Metal_Verbotten"},
 	{0x0F,0x4d,0x7F,"Metal"},
 	{0x10,0xb0,0xAF,"Sky"},
 	{0x11,0xb1,0x4F,"Red"},
 	{0x12,0x91,0x4D,"Red_Swastika"},
 	{0x14,0x45,0x4F,"Red_Eagle"},
 	{0x13,0xb2,0x5a,"Purple"},
 	{0x15,0x58,0xa0,"Exit_Wall"},
 	{0x16,0x58,0xa0,"_Exit_Wall2"},
 	{0x17,0x2B,0x60,"Wood_Cross"},
	{0x18,0x59,0x00,"Yellow_stone"},	/* WL6 - slimy yellow stone wall */
 	{0x19,0xf7,0x54,"Purple_blood"},
	{0x1a,0x59,0x00,"Yellow_stone"},	/* WL6 - slimy yellow stone wall */
 	{0x1B,0xb2,0x8F,"Grey_Brick"},
 	{0x1C,0x56,0x8F,"Grey_Verbotten"},
 	{0x1D,0x44,0x0F,"_Door"},
 	{0x1E,0x44,0x0f,"_DoorFrame"},
 	{0x1F,0x5e,0x0f,"_LiftDoor"},
 	{0x5A,0xB3,0x0F,"EW_Door"},
 	{0x5B,0xC4,0x0F,"NS_Door"},
 	{0x5C,0xBA,0x0F,"EW_Door_Locked"},
 	{0x5D,0xCD,0x0F,"NS_Door_Locked"},
	{0x5e,0xba,0x00,"EW_Door_Locked2"},
	{0x5f,0xba,0x00,"EW_Door_Locked2"},
 	{0x64,0x5e,0x0a,"EW_Lift_Door"},
 	{0x65,0xCD,0x0F,"NS_Door_Locked3"},
 	{0x6A,0xFA,0x3F,"Guard_Post"},
	{0x6b,0x20,0x00,"Floor_37"},
 	{0x6C,0x20,0x0F,"Floor_1"},
 	{0x6D,0x20,0x0F,"Floor_2"},
 	{0x6E,0x20,0x0F,"Floor_3"},
 	{0x6F,0x20,0x0F,"Floor_4"},
 	{0x70,0x20,0x0F,"Floor_5"},
 	{0x71,0x20,0x0F,"Floor_6"},
 	{0x72,0x20,0x0F,"Floor_7"},
 	{0x73,0x20,0x0F,"Floor_8"},
 	{0x74,0x20,0x0F,"Floor_9"},
 	{0x75,0x20,0x0F,"Floor_10"},
 	{0x76,0x20,0x0F,"Floor_11"},
 	{0x77,0x20,0x0F,"Floor_12"},
 	{0x78,0x20,0x0F,"Floor_13"},
 	{0x79,0x20,0x0F,"Floor_14"},
 	{0x7A,0x20,0x0F,"Floor_15"},
 	{0x7B,0x20,0x0F,"Floor_16"},
 	{0x7C,0x20,0x0F,"Floor_17"},
 	{0x7D,0x20,0x0F,"Floor_18"},
 	{0x7E,0x20,0x0F,"Floor_19"},
 	{0x7F,0x20,0x0F,"Floor_20"},
 	{0x80,0x20,0x0F,"Floor_21"},
 	{0x81,0x20,0x0F,"Floor_22"},
 	{0x82,0x20,0x0F,"Floor_23"},
 	{0x83,0x20,0x0F,"Floor_24"},
 	{0x84,0x20,0x0F,"Floor_25"},
 	{0x85,0x20,0x0F,"Floor_26"},
 	{0x86,0x20,0x0F,"Floor_27"},
 	{0x87,0x20,0x0F,"Floor_28"},
 	{0x88,0x20,0x0F,"Floor_29"},
 	{0x89,0x20,0x0F,"Floor_30"},
 	{0x8A,0x20,0x0F,"Floor_31"},
 	{0x8B,0x20,0x0F,"Floor_32"},
 	{0x8C,0x20,0x0F,"Floor_33"},
 	{0x8D,0x20,0x0F,"Floor_34"},
 	{0x8E,0x20,0x0F,"Floor_35"},
 	{0x8F,0x20,0x0F,"Floor_36"},
	{0x00,0x00,0x00,NULL} };


/* key table header strings */

char KeyHeader1[] = "      name         ascii  hex  ";
char KeyHeader2[] = " ==============================";

/* globals */

char *dest;			/* a parser work buffer pointer */
char *OutputFile;		/* file name of ascii output file */
char *MapHeaderFile;		/* file name of Wolf Map Header file */
char *MapDataFile;		/* file name of Wolf Map Data file */
char *WolfDirectory;		/* the Wolf path given by /DIR= */
unsigned int *MapData;		/* pointer to map data code array */
unsigned int *ObjectData;	/* pointer to map object code array */
long WolfVersionFileAdjust;	/* data file offset adjustment factor */
				/* for Wolf1 the offset is 2 */
				/* for Wolf6 the offset is 4 */
int MapDataSize;		/* size of map code array - changes when decompressing */
int MapObjectSize;		/* size of object code array - changes when decompressing */
int *MapNumbers;		/* selected map numbers array */
int SelectedVersions;		/* increment for each version selected */
WOLFHEADSTRUCT *WolfHeader;	/* pointer to the Wolf Header structure */
FILE *fpOutFile;		/* ascii output file pointer */

/* some needed file names */

char SdmMapData[] = "GAMEMAPS.SDM";
char SdmMapHeader[] = "MAPHEAD.SDM";
char SodMapData[] = "GAMEMAPS.SOD";
char SodMapHeader[] = "MAPHEAD.SOD";
char WL6MapData[] = "GAMEMAPS.WL6";
char WL6MapHeader[] = "MAPHEAD.WL6";
char WL1MapData[] = "MAPTEMP.WL1";
char WL1MapHeader[] = "MAPHEAD.WL1";

/* the command line switch bit flags and data */

char *args[] = { "WL6", "DIR=", "D=", "H", "HELP", "?",
		"HD", "HEXDUMP", "A", "ALL", "K", "KEY",
		"HD1", "HEXDUMP1", "HD2", "HEXDUMP2",
		"W", "NOWARN", "SDM", "SOD", NULL};
#define	CLS_WL6		0
#define	CLS_DIR		1
#define	CLS_D		2
#define	CLS_H		3
#define	CLS_HELP	4
#define	CLS_QnM		5
#define	CLS_HD		6
#define	CLS_HEXDUMP	7
#define	CLS_A		8
#define	CLS_ALL		9
#define CLS_K		10
#define CLS_KEY		11
#define CLS_HD1		12
#define CLS_HEXDUMP1	13
#define CLS_HD2		14
#define CLS_HEXDUMP2	15
#define CLS_W		16
#define CLS_NOWARN	17
#define CLS_SDM		18
#define CLS_SOD		19

unsigned int SelectedOptions = 0;	/* command line option bit flags */

#define	OPT_WL6		0x0001		/* use Wolf6 format (Wolf1 by default) */
#define	OPT_DIR		0x0002		/* an alternate directory is present */
#define	OPT_HEXDUMP	0x0004		/* do a hex-dump instead of ascii map */
#define	OPT_ALL		0x0008		/* do all maps */
#define OPT_FILENAME	0x0010		/* an output file name is present */
#define OPT_MAPNUMS	0x0020		/* map numbers are present */
#define OPT_KEY		0x0040		/* write the map key */
#define OPT_HEXDUMP1	0x0080		/* do a hex-dump post pass 1 */
#define OPT_HEXDUMP2	0x0100		/* do a hex-dump post pass 2 */
#define OPT_NOWARN	0x0200		/* turn unknown object/data warnings off */
#define OPT_SPEAR	0x0400		/* use Spear of Destiny demo format */
#define OPT_SPEAR18	0x0800		/* use Spear of Destiny format */

#pragma argsused

int main(int argc, char **argv)
{
	int i, NumberOfMaps, arg_state = 0;

	printf("3D Wolfenstein map maker v3.00 - [FREEWARE] Scott Pitcher 1992\n");

	/* allocate space for strings and things */

	OutputFile = (char *) gmalloc(sizeof(char), MAXPATH);
	MapHeaderFile = (char *) gmalloc(sizeof(char), MAXPATH);
	MapDataFile = (char *) gmalloc(sizeof(char), MAXPATH);
	WolfDirectory = (char *) gmalloc(sizeof(char), MAXDIR);
	MapNumbers = (int *) gmalloc(sizeof(int), 60);
	WolfHeader = (WOLFHEADSTRUCT *) gmalloc(sizeof(WOLFHEADSTRUCT), 1);
	dest = (char *) gmalloc(sizeof(char), MAXPATH);

	/* parse command line arguments */

	++argv;
	while(*argv) {
		switch(i = cmdln_parse(args, *argv, dest, IGNORECASE)) {
			case ENDOFARGUMENT :
				++argv;
				break;
			case ILLEGALSWITCH :
				printf("\n\aIllegal switch : '%s'", dest);
				exit(1);
			case EXTRAPARAMS :
				printf("\n\aExtra parameter ignored in switch : '%s'", dest);
				break;
			case NOTASWITCH :
				if(isdigit(dest[0])) {
					MapNumbers[atoi(dest) - 1 & 0x3f] = 1;
					SelectedOptions |= OPT_MAPNUMS;
				}
				else if(arg_state == 0) {
					arg_state = 1;
					strcpy(OutputFile, dest);
					SelectedOptions |= OPT_FILENAME;
				}
				else {
					printf("\n\aToo many command line arguments");
					exit(1);
				}
				break;
			case CLS_WL6 :
				SelectedOptions |= OPT_WL6;
				++SelectedVersions;
				break;
			case CLS_DIR :
			case CLS_D :
				SelectedOptions |= OPT_DIR;
				strcpy(WolfDirectory, dest);
				break;
			case CLS_H :
			case CLS_HELP :
			case CLS_QnM :
				help();
				exit(0);
			case CLS_HD :
			case CLS_HEXDUMP :
				SelectedOptions |= OPT_HEXDUMP;
				break;
			case CLS_A :
			case CLS_ALL :
				SelectedOptions |= OPT_ALL | OPT_MAPNUMS;
				break;
			case CLS_K :
			case CLS_KEY :
				SelectedOptions |= OPT_KEY;
				break;
			case CLS_HD1 :
			case CLS_HEXDUMP1 :
				SelectedOptions |= OPT_HEXDUMP1;
				break;
			case CLS_HD2 :
			case CLS_HEXDUMP2 :
				SelectedOptions |= OPT_HEXDUMP2;
				break;
			case CLS_W :
			case CLS_NOWARN :
				SelectedOptions |= OPT_NOWARN;
				break;
			case CLS_SDM :
				SelectedOptions |= OPT_SPEAR;
				++SelectedVersions;
				break;
			case CLS_SOD :
				SelectedOptions |= OPT_SPEAR18;
				++SelectedVersions;
				break;
			default :
				printf("\n\aParse error %d", i);
				exit(1);
		}
	}
	if(!(SelectedOptions & OPT_MAPNUMS)) {
		printf("\n\aYou must specify which map numbers you want");
		exit(1);
	}
	if(!(SelectedOptions & OPT_FILENAME)) {
		printf("\n\aYou must specify an output file name");
		exit(1);
	}
	if(!(SelectedVersions == 0 || SelectedVersions == 1)) {
		printf("\n\aYou cannot use the /SDM /SOD or /WL6 together");
		exit(1);
	}
	if(SelectedOptions & OPT_ALL) {
		if(SelectedOptions & OPT_WL6)	/* for an /ALL switch, mark every map entry */
			i = 60;
		else if(SelectedOptions & OPT_SPEAR)
			i = 2;
		else if(SelectedOptions & OPT_SPEAR18)
			i = 21;
		else
			i = 10;
		for( ; i >= 0; --i)
			MapNumbers[i] = 1;
	}

	/* set up the path is one has been given */

	if(SelectedOptions & OPT_DIR) {
		if(*(WolfDirectory + strlen(WolfDirectory) - 1) != '\\')
			strcat(WolfDirectory, "\\");	/* append a backslash if none present */
		strcpy(MapHeaderFile, WolfDirectory);	/* copy the path strings to the file names */
		strcpy(MapDataFile, WolfDirectory);
	}

	/*
	   set the data offset version dependent adjustment value
	   and create the map data and header file names
	*/

	if(SelectedOptions & OPT_WL6) {
		strcat(MapHeaderFile, WL6MapHeader);
		strcat(MapDataFile, WL6MapData);
		NumberOfMaps = 60;
		WolfVersionFileAdjust = 4L;
	}
	else if(SelectedOptions & OPT_SPEAR) {
		strcat(MapHeaderFile, SdmMapHeader);
		strcat(MapDataFile, SdmMapData);
		NumberOfMaps = 2;
		WolfVersionFileAdjust = 4L;
	}
	else if(SelectedOptions & OPT_SPEAR18) {
		strcat(MapHeaderFile, SodMapHeader);
		strcat(MapDataFile, SodMapData);
		NumberOfMaps = 21;
		WolfVersionFileAdjust = 4L;
	}
	else {
		strcat(MapHeaderFile, WL1MapHeader);
		strcat(MapDataFile, WL1MapData);
		NumberOfMaps = 10;
		WolfVersionFileAdjust = 2L;
	}

	/*
	   this loop performs 1 cycle for each entry in the MapNumbers array
	   decoding and printing a map if the current entry is set
	*/

	fpOutFile = gfopen(OutputFile, "wt");

	/* write the map key if we are asked for it */

	if(SelectedOptions & OPT_KEY)
		mapkey();

	for(i = 0; i < NumberOfMaps; ++i) {
		if(MapNumbers[i]) {
			printf("\n\nCreating map number %d, for game number %d", i % 10 + 1, i / 10 + 1);
			ReadMapHeader(i);
			ReadMapData();
			DecompressMapData();
			if(MapDataSize != (WolfHeader -> map_width * WolfHeader -> map_height) * 2 ||
			   MapObjectSize != (WolfHeader -> map_width * WolfHeader -> map_height) * 2) {
			   	printf("\n\aError - unexpected Map Data/Object size after decompression");
			   	exit(1);
			}
			WriteMap(i);
		}
	}
	gfclose(fpOutFile);
	return(0);
}

/*
** WriteMap() writes the ascii maps to the output file
**
**	The output file must have been opened before this call is made.
*/

void WriteMap(int MapNumber)
{
	int i,j;
	unsigned int output_code, map_code, obj_code;
	unsigned int *pMap, *pObj;
	char map_name[17];

	printf("\n---Writing Map--->");
	pMap = MapData;
	pObj = ObjectData;
	strncpy(map_name, WolfHeader -> level_name, 16);

	/* write the map header */

	if(SelectedOptions & OPT_WL6)
		gfprintf(fpOutFile, "\nWolfenstein6 map, game %d, map %d '%s'\n\n", MapNumber / 10 + 1, MapNumber % 10 + 1, map_name);
	else if(SelectedOptions & OPT_SPEAR)
		gfprintf(fpOutFile, "\nSpear of Destiny demo map, map %d '%s'\n\n", MapNumber + 1, map_name);
	else if(SelectedOptions & OPT_SPEAR18)
		gfprintf(fpOutFile, "\nSpear of Destiny map, map %d '%s'\n\n", MapNumber + 1, map_name);
	else
		gfprintf(fpOutFile, "\nWolfenstein1 map, map %d '%s'\n\n", MapNumber + 1, map_name);
	if(SelectedOptions & OPT_HEXDUMP)
		gfputs("[Hex Dump Mode]\n\n", fpOutFile);
	for(i = 0; i < WolfHeader -> map_height; ++i) {
		for(j = 0; j < WolfHeader -> map_width; ++j) {
			if((map_code = scan_array(*pMap, MapCodes)) == 0xffff) {
				if(!(SelectedOptions & OPT_NOWARN))
					printf("\nWarning - Unknown map code : %4.4xH", *pMap);
				map_code = '?';
			}
			if(map_code < 0x20)
				map_code |= 0x80;
			if((obj_code = scan_array(*pObj, ObjCodes)) == 0xffff) {
				if(!(SelectedOptions & OPT_NOWARN))
					printf("\nWarning - Unknown object code : %4.4xH", *pObj);
				obj_code = '?';
			}
			output_code = map_code | map_code << 8;
			if(obj_code) {
				if(obj_code & 0xff00)		/* fix for double byte obj codes */
					output_code = obj_code;
				else {				/* single byte obj codes */
					if(obj_code < 0x20)
						obj_code |= 0x80;
					output_code &= 0xff00;
					output_code |= obj_code;
				}
			}
			if(SelectedOptions & OPT_HEXDUMP)
				gfprintf(fpOutFile, "%4.4x ", output_code);
			else
				gfwrite(&output_code, sizeof(int), 1, fpOutFile);
			++pMap;
			++pObj;
		}
		gfputs("\n", fpOutFile);
	}
	gfputs("\n", fpOutFile);
	gfree(MapData);
	gfree(ObjectData);	
}

/*
** scan_array().
**
**	This function scans the map code and object code arrays for a match.
**	It returns the corresponding double byte ascii code or -1 if it
**	could not find a match.
*/

unsigned int scan_array(unsigned int code, struct WolfCodes *scan_codes)
{
	while(scan_codes -> name) {
		if(scan_codes -> typeCode == code)
			return scan_codes -> asciiCode;
		else
			++scan_codes;
	}
	return 0xffff;
}

/*
** ReadMapData().
**
**	This function reads the map codes and object codes in from the
**	Wolfenstein data file. The amount of memory allocated for each
**	of the arrays is determined by the Wolfenstein data header
*/

void ReadMapData()
{
	FILE *fp;

	printf("\n---Reading Map Data--->");
	MapDataSize = WolfHeader -> ObjStart - WolfHeader -> MapStart;
	MapObjectSize = WolfHeader -> DataEnd - WolfHeader -> ObjStart;
	MapData = gmalloc(sizeof(char), MapDataSize);
	ObjectData = gmalloc(sizeof(char), MapObjectSize);
	fp = gfopen(MapDataFile, "rb");
	gfseek(fp, WolfHeader -> MapStart + WolfVersionFileAdjust, SEEK_SET);
	gfread(MapData, sizeof(char), MapDataSize, fp);
	gfseek(fp, WolfHeader -> ObjStart + WolfVersionFileAdjust, SEEK_SET);
	gfread(ObjectData, sizeof(char), MapObjectSize, fp);
	gfclose(fp);
}
	
/*
** ReadMapHeader().
**
**	This function reads the map header in from the Wolfenstein data file. The
**	Map Header file is consulted to determine the offset of the data header.
*/

void ReadMapHeader(int MapNumber)
{
	FILE *fp;
	long header_offset;

	printf("\n---Reading Map Header--->");

	/* first - find the file offset of the header data */

	fp = gfopen(MapHeaderFile, "rb");
	gfseek(fp, MapNumber * sizeof(long) + 2L, SEEK_SET);
	gfread(&header_offset, sizeof(long), 1, fp);
	gfclose(fp);

	/* second - read the header into the space previously allocated for it */

	fp = gfopen(MapDataFile, "rb");
	gfseek(fp, header_offset, SEEK_SET);
	if(SelectedOptions & OPT_WL6 || SelectedOptions & OPT_SPEAR || SelectedOptions & OPT_SPEAR18)
		gfread(WolfHeader, sizeof(WOLFHEADSTRUCT), 1, fp);
	else
		gfread(WolfHeader, sizeof(WOLFHEADSTRUCT) - sizeof(WolfHeader -> id_name), 1, fp);
	gfclose(fp);
}

/*
** DecompressMapData()
**
**	This function is the high level of the decompression function. It
**	calls the two lower level decompression functions, and takes care
**	of memory management while the map code and object code data blocks
**	are unravelled.
*/

void DecompressMapData()
{
	unsigned int *pTemp;

	printf("\n---Decompressing Map Data--->");

	/* the pass one decoder is only for WOLF6 map data */

	if(SelectedOptions & OPT_WL6 || SelectedOptions & OPT_SPEAR || SelectedOptions & OPT_SPEAR18) {
		pTemp = gmalloc(sizeof(int), WolfHeader -> map_width * WolfHeader -> map_height);
		MapDataSize = pass1_decode(MapDataSize, MapData, pTemp);
		gfree(MapData);
		MapData = pTemp;
		pTemp = gmalloc(sizeof(int), WolfHeader -> map_width * WolfHeader -> map_height);
		MapObjectSize = pass1_decode(MapObjectSize, ObjectData, pTemp);
		gfree(ObjectData);
		ObjectData = pTemp;
	}
	if(SelectedOptions & OPT_HEXDUMP1) {
		gfputs("\n[Pass 1 Hex Dump]", fpOutFile);
		DataHexDump();
	}
	pTemp = gmalloc(sizeof(int), WolfHeader -> map_width * WolfHeader -> map_height + 200);
	MapDataSize = pass2_decode(MapData, pTemp);
	gfree(MapData);
	MapData = pTemp;
	pTemp = gmalloc(sizeof(int), WolfHeader -> map_width * WolfHeader -> map_height + 200);
	MapObjectSize = pass2_decode(ObjectData, pTemp);
	gfree(ObjectData);
	ObjectData = pTemp;
	if(SelectedOptions & OPT_HEXDUMP2) {
		gfputs("\n[Pass 2 Hex Dump]", fpOutFile);
		DataHexDump();
	}
}

/*
** pass1_decode()
**
**	This function performs the first type of the map decompression procedure, as
**	used in the Wolf6 & after map data files. It handles the 0xA7 and 0xA8
**	repeat codes.
*/

int pass1_decode(int length, unsigned int *src, unsigned int *dest)
{
	unsigned char *p;
	int new_length, i, j;
	unsigned int offset;

	p = (unsigned char *) src;
	for(new_length = 0; p < (unsigned char *) (src + length); ) {
		if(*(p + 1) == 0xa7) {
			offset = *(p + 2);
			for( j = *p; j > 0; --j) {
				*(dest + new_length) = *(dest + new_length - offset);
				++new_length;
			}
			p += 3;
		}
		else if(*(p + 1) == 0xa8) {
			offset = *((unsigned int *) (p + 2));
			for(j = 0; j < *p; ++j) {
				*(dest + new_length) = *(dest + offset + j - 1);
				++new_length;
			}
			p += 4;
		}
		else {
			*(dest + new_length) = *((unsigned int *) p);
			p += 2;
			++new_length;
		}
	}
	return new_length * 2;
}


/*
** pass2_decode()
**
**	This function performs the second type of the map decompression procedure, as
**	used in all the map data files. It handles the 0xABCD repeat code.
*/

int pass2_decode(unsigned int *src, unsigned int *dest)
{
	int new_length;
	unsigned int j, type;

	for(new_length = 0; new_length < WolfHeader -> map_width * WolfHeader -> map_height; ) {
		if(*src == 0xabcd) {
			++src;
			for(j = *src++, type = *src++; j > 0; --j) {
				*(dest + new_length) = type;
				++new_length;
			}
		}
		else {
			*(dest + new_length) = *src;
			++src;
			++new_length;
		}
	}
	return new_length * 2;
}

/*
** DataHexDump()
**
**	A simple hex dump function for debugging unknown object/data codes. It dumps
**	both 8192 byte blocks of data regardless ofthe actual used size of each.
*/

void DataHexDump()
{
	int i, j;

	gfputs("\n--Object Codes->\n", fpOutFile);
	for(i = 0; i < 4096; i += 64) {
		for(j = 0; j < 64; ++j) {
			fprintf(fpOutFile, "%4.4x ", *(MapData + i + j));
		}
		gfputs("\n", fpOutFile);
	}
	gfputs("\n--Map Codes->\n", fpOutFile);
	for(i = 0; i < 4096; i += 64) {
		for(j = 0; j < 64; ++j) {
			gfprintf(fpOutFile, "%4.4x ", *(ObjectData + i + j));
		}
		gfputs("\n", fpOutFile);
	}
}

/*
** mapkey()
**
**	This function writes the map key to the output file,
**	which must have already been opened.
*/

void mapkey()
{
	struct WolfCodes *Wp;
	int i;

	gfputs("\nWolfenstein & Spear of Destiny map key ...", fpOutFile);

	Wp = MapCodes;
	gfputs("\n\n[Map Codes]", fpOutFile);
	i = 0;
	gfprintf(fpOutFile, "\n%s%s\n%s%s", KeyHeader1, KeyHeader1, KeyHeader2, KeyHeader2);
	while(Wp -> name) {
		if(!(i & 1))
			gfputs("\n", fpOutFile);
		++i;
		gfprintf(fpOutFile, " '%15s' '%c%c' '%4.4Xh'", Wp -> name,
			(Wp -> asciiCode < 0x20 ? Wp -> asciiCode | 0x80 : Wp -> asciiCode),
			(Wp -> asciiCode >> 8 ? Wp -> asciiCode >> 8 :
			(Wp -> asciiCode < 0x20 ? Wp -> asciiCode | 0x80 : Wp -> asciiCode)), Wp -> typeCode);
		++Wp;
	}
	gfprintf(fpOutFile, "\n%s%s", KeyHeader2, KeyHeader2);

	Wp = ObjCodes;
	gfputs("\n\n[Object Codes]", fpOutFile);
	i = 0;
	gfprintf(fpOutFile, "\n%s%s\n%s%s", KeyHeader1, KeyHeader1, KeyHeader2, KeyHeader2);
	while(Wp -> name) {
		if(!(i & 1))
			gfputs("\n", fpOutFile);
		++i;
		gfprintf(fpOutFile, " '%15s' '%c%c' '%4.4Xh'", Wp -> name,
			(Wp -> asciiCode < 0x20 ? Wp -> asciiCode | 0x80 : Wp -> asciiCode),
			(Wp -> asciiCode >> 8 ? Wp -> asciiCode >> 8 : ' '), Wp -> typeCode);
		++Wp;
	}
	gfprintf(fpOutFile, "\n%s%s\n", KeyHeader2, KeyHeader2);

}

/*
** help()
**
**	The help function!
*/

void help()
{
	printf("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s",
		"\nCommand line format is ...",
		"\n",
		"\n\tC:\>WOLFMAP [switches] [games] [output file name]",
		"\n",
		"\n[games] are any number of numbers with a space between each.",
		"\n",
		"\neg. C:\>WOLFMAP /DIR=\\GAMES\\WOLF /WL6 /KEY 1 3 7 12 OUTFILE.MAP",
		"\n",
		"\nvalid command line [switches] are ...",
		"\n",
		"\n/H,/HELP,/?\t... display this help screen",
		"\n/D=,/DIR=\t... specify the Wolfenstein drive/directory",
		"\n/HD,/HEXDUMP\t... print a hexdump instead of ascii map",
		"\n/A,/ALL\t\t... print all the maps",
		"\n/WL6\t\t... for Wolf6 (commercial) instead of Wolf1 (shareware)",
		"\n/SDM\t\t... for Spear of Destiny demo version",
		"\n/SOD\t\t... for Spear of Destiny 18 level version",
		"\n/W,/NOWARN\t... turn off unknown object/map data warnings",
		"\n/K,/KEY\t\t... print the map Object Key");
}
