/****************
* Program name : WOLFMAP.C
* Description  : Wolfenstein 3d mapping utility.
* Version      : 1.2
*
* Author       : David Lummis
* Compuserve Id: 71534,3067
*
* Last updated : Wed Aug 12, 1992 @ 00:05:21
*****************/


/******************************************************************************

MAPHEAD.WL?   Map header file: Contains file offsets to level headers
MAPTEMP.WL?   Version 1.0  map data file.
GAMEMAPS.WL?  Version 1.1+ map data file

Shareware version.....: MAPHEAD.WL1, MAPTEMP.WL1

If bought episodes 1-3: MAPHEAD.WL3, GAMEMAPS.WL3 (contains 1 to 3)

If bought episodes 1-6: MAPHEAD.WL6, GAMEMAPS.WL6 (contains 1 to 6)

------------------------------------------------------------------------------

File: MAPHEAD.WL?  (Wolfenstein 3D - all versions)
=================

File Structure (all values shown in hex):

  A) Repeat_code

      File  Data Sample
     Offset Type  Data  Description
     ------ ---- ------ -------------------
      0000  int  CD AB  This is the 2 byte integer used in the map file to
                        indicate data compression.

  B) Level_header_offsets

     For every level in each episode there is a 4 byte (ie. long) absolute
     file offset which points into the map data file at a particular
     Level_header.

     Each episode consists of 10 levels.

     The file seems to allow for 100 four-byte offsets (ie. 100 levels, or
     10 episodes).  All remaining offsets are 00000000 (v1.1) or FFFFFFFF
     (v1.0).

------------------------------------------------------------------------------

File: MAPTEMP.WL?  (Wolfenstein 3D - version 1.0)
=================

File Structure (all values shown in hex):

  A) File_header

      File  Data
     Offset Type Sample Data Description
     ------ ---- ----------- -------------------------------------------
      0000  char  "TED5v1.0" Ascii string (8 bytes) (no null terminator)
      0008        A0         ???
      0009        FF         ???
      000A        CA         ???

  B) Level_data (contains data for all ten levels)

     Level structure (one per level)

        a) Level_header

           Level
           Header  Data
           Offset  Type  Description
           ------  ----  -------------------------------
            0000   long  File offset of Map_Block
            0004   long  File offset of Object_Block
            0008   long  File offset of Unknown_Block
            000C   int   File size   of Map_Block
            000E   int   File size   of Object_Block
            0010   int   File size   of Unknown_Block
            0012   int   Horizontal map size (# of squares)
            0014   int   Vertical   map size (# of squares)
            0016   char  Level name (ascii) (null terminated)
            0026   char  "!ID!" (4 bytes)

        b) Map_block
        c) Object_block
        d) Unknown_block

           Each block consists of a 4 byte header followed by data.

           Block  Data
           Offset Type Description
           ------ ---- --------------------------------------------
            0000  int  # of data bytes after decompresssing.
            0002  int  Data bytes.
                       Values are stored as 2 byte integers (low byte first).

                       If value == ABCD (ie. the integer we found at the
                       beginning of the MAPHEAD file) then:
                          - the next integer is # of repetitions
                          - the next integer is value to repeat

                       If value is not ABCD then store the value as is.

------------------------------------------------------------------------------

File: GAMEMAPS.WL?  (Wolfenstein 3D - version 1.1+)
==================

Changes since v1.0:

  - Level_header has moved so that it now follows the Unknown_block
  - must now make an extra pass through the raw data in order to decode
    special A7 and A8 bytes.
  - Byte at absolute offset 8 has changed (purpose ???).


File Structure (all values shown in hex):

  A) File_header

      File  Data
     Offset Type Sample Data Description
     ------ ---- ----------- -------------------------------------------
      0000  char  "TED5v1.0" Ascii string (8 bytes) (no null terminator)
      0008        C8         ???
      0009        FF         ???
      000A        CA         ???

  B) Level_data (contains data for all ten levels)

     Level structure (one per level)

        a) Map_block
        b) Object_block
        c) Unknown_block

           Each block consists of a 4 byte header followed by data.

           Block  Data
           Offset Type Description
           ------ ---- --------------------------------------------
            0000  int  # of data bytes after decoding (count includes
                       the two bytes at Block Offset 0002).
            0002  int  # of data bytes after decompresssing.
            0004  int  Data bytes.
                       Values are stored as 2 byte integers (low byte first).


                       To decode the data you must make two passes at it.


                       Pass1 (decoding):
                       -----

                       If high byte of value is A7 then:

                          If low byte is 00 then:
                             - high byte of value is A7
                             - low  byte of value is the next byte
                          Else
                             - the low  byte is a count (ie. # of integers we
                               want to reuse).
                             - the next byte is the # of integers we want
                               to move back in order to reuse data we have
                               already decoded.

                       If high byte of value is A8 then:

                          If low byte is 00 then:
                             - high byte of value is A8
                             - low  byte of value is the next byte
                          Else
                             - the low  byte is a count (ie. # of integers we
                               want to reuse).
                             - the next integer (2 bytes) is the # of integers
                               we want to skip over, starting at the beginning
                               of the buffer being used to hold data we have
                               already decoded (the first integer in the buffer
                               being the # of bytes after decompressing).

                       If high byte is not A7 or A8, then store the value
                       as is.


                       Pass2 (decompressing):
                       -----

                       If value == ABCD (ie. the integer we found at the
                       beginning of the MAPHEAD file) then:
                          - the next integer is # of repetitions
                          - the next integer is value to repeat

                       If value is not ABCD then store the value as is.


        d) Level_header

           Level
           Header  Data
           Offset  Type  Description
           ------  ----  -------------------------------
            0000   long  File offset of Map_Block
            0004   long  File offset of Object_Block
            0008   long  File offset of Unknown_Block
            000C   int   File size   of Map_Block
            000E   int   File size   of Object_Block
            0010   int   File size   of Unknown_Block
            0012   int   Horizontal map size (# of squares)
            0014   int   Vertical   map size (# of squares)
            0016   char  Level name (ascii) (null terminated)
            0026   char  "!ID!" (4 bytes)

******************************************************************************/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <dos.h>


#define byte unsigned char
#define word unsigned int

// Maximum number of levels allowed for in each game's map file.
#define MAP_MAXLEVELS 10

// Maximum number of episodes allowed
#define MAP_MAXEPISODES 6

// Filenames
#define FILE_MAPEXT   ".WL"
#define FILE_MAPHEAD  "MAPHEAD"
#define FILE_0MAPTEMP "MAPTEMP"
#define FILE_1MAPTEMP "GAMEMAPS"

#define FILE_LEGEND    "WMAP"
#define FILE_LEGENDEXT ".LEG"

#define FILE_COUNT    "WMAP"
#define FILE_COUNTEXT ".COU"

#define FILE_MAP      "WMAP"
#define FILE_MAP2     "WMAP"
#define FILE_WOLFMAP  "WOLFMAP.CFG"

// Number of different map types generated by this program
#define MAP_NUMTYPES   3

// Section names allowed in the WOLFMAP configuration file.
#define SECT_MAPGROUPS "[MAP GROUPS]"
#define SECT_MAPVALUES "[MAP VALUES]"
#define SECT_OBJGROUPS "[OBJECT GROUPS]"
#define SECT_OBJVALUES "[OBJECT VALUES]"

// Minimum lengths of GROUP and VALUE lines in the WOLFMAP configuration file.
#define LEN_GROUPLINE 11
#define LEN_VALUELINE 6

// Max length of group descriptions
#define LEN_GDESCRIPTION 35

// Minimum and maximum GROUP and VALUE numbers.
// Total number of GROUPS and VALUES allowed.
#define MIN_GROUP    0
#define MIN_VALUE    0
#define MAX_GROUP  255
#define MAX_VALUE  255
#define NUM_GROUPS 256
#define NUM_VALUES 256
// total # of map and object groups
#define NUM_GROUPS2 512

// Map group types
#define MT_OTHER 0
#define MT_WALL  1
#define MT_DOOR  2
#define MT_FLOOR 3

// Object group types
#define OT_OTHER      0
#define OT_TRIVIAL    1
#define OT_NONTRIVIAL 2
#define OT_ENEMY      3

// Maximum X and Y values allowed for maps.
// Maximum size (in bytes) needed to hold fully uncompressed map data.
// Maximum size (in words) needed to hold fully uncompressed map data.
#define MAX_X 64
#define MAX_Y 64
#define MAX_BYTES 8192
#define MAX_WORDS 4096

char nullstr[1];

struct find_t diskinfo;

int  episode_num;    // Game number (1 to 6)
int  num_episodes;   // Number of episodes found in MAPHEAD file.
int  wolf_ver;       // Wolfenstein version number (0=1.0, 1=1.1+)

// Filenames
char data_extension[5];       // Extension used for data files (eg ".WL1")
char maphead1_filename[255];  // 1st MAPHEAD filename (episodes 1 to 3) (map offsets)

char maphead2_filename[255];  // 2nd MAPHEAD filename (episodes 4 to 6) (map offsets)

char maptemp_filename[255];   // MAPTEMP filename (map data)
char wolfmap_filename[255];   // Holds name of WOLFMAP's configuration file
char count_filename[255];     // Name of file to contain data counts.
char legend_filename[255];    // Name of file to contain map symbol legend.

char map_name[255];
char obj_name[255];
char comb_name[255];

int ep11_flag;  // =1 if we found episode 1-1 file
int ep13_flag;  // =1 if we found episode 1-3 file
int ep46_flag;  // =1 if we found episode 4-6 file
int ep16_flag;  // =1 if we found episode 1-6 file

struct group_rec       // Configuration file GROUP record layout
{
   byte character;        // Character to use when creating maps
   byte character2a;      // Character to use when creating maps (/2 option)
   byte character2b;      // Character to use when creating maps (/2 option)
   int  type;             // Group type number
   char legend;           // Y = print on legend page
   char *description;     // Pointer to description
};

struct value_rec       // Configuration file VALUE record layout
{
   int  group;            // Group number
};

struct group_rec map_groups[NUM_GROUPS];
struct value_rec map_values[NUM_VALUES];
struct group_rec obj_groups[NUM_GROUPS];
struct value_rec obj_values[NUM_VALUES];

struct group_rec *sortgroups[NUM_GROUPS2];


char input_buffer[255];   // Used when reading configuration file and user input

int  input_line;          // Current line number in configuration file.
long input_pos;           // Used to hold current file offset in config file.

word code_repeat;    // Holds repeat code found at start of MAPHEAD file


word counts[MAP_MAXLEVELS][256];  // Holds data counts by level
word totals[256];


int  help_flag;
int  item_mode;
int  count_flag;
int  enemy_mode;
int  pause_flag;
int  num_lines;
int  map_type;         // Type of map to generate.
int  double_width;     // 1=Use 2 characters to represent a map/object value
int  map_from;         // Starting level number
int  map_to;           // Ending level number
char map_title[255];   // Title for current map
int  hex_scale_x;      // 1=print hexadecimal X scale on map
int  hex_scale_y;      // 1=print hexadecimal Y scale on map

unsigned long map_offset[MAP_MAXEPISODES][MAP_MAXLEVELS]; // Offsets of map data 
in maptemp file


word map_data[MAX_WORDS];    // Fully uncompressed map data
word obj_data[MAX_WORDS];    // Fully uncompressed object data
byte buf1_data[MAX_BYTES];   // Holds data read directly from file
word buf2_data[MAX_WORDS];   // Holds decoded data


struct level_header
{
   long map_off;   // Offset of map data block
   long obj_off;   // Offset of object data block
   long xxx_off;   // Offset of unknown data block
   word map_size;  // Size of map data block (before decompressing)
   word obj_size;  // Size of object data block (before decompressing)
   word xxx_size;  // Size of unknown data block (before decompressing)
   word xsize;     // # of horizontal squares
   word ysize;     // # of vertical squares
   char name[16];  // Map name
};

struct level_header lh;



/****
* Function prototypes
****/
void read_config();
void init_section(FILE *hConfig, char *p1);
char *init_readline(FILE *handle);
void init_groups(struct group_rec *group, FILE *hConfig);
void init_values(struct value_rec *value, FILE *hConfig);
void set_options(char *f);

void one_more_line();
void pause(char *p);
void display_help();

int  make_map(int level, char *mapfile, char *objfile, char *combfile);
int  make_map2(int which, int level, char *outfile, word map_info[]);
int  read_map(int level);
void read_bytes(FILE *in_stream, word map_info[], word data_size);
int  seek_file(FILE *stream, long offset);
void print_xscale(FILE *out_stream, word xsize, int map_type);
void print_bytes(int which, FILE *out_stream, word map_info[]);

int  count_data();
void print_counts(FILE *out_stream);
void count_level(int level, word map_info[]);

int hextoi(char *hex);

void print_legend();
void vSort_List(struct group_rec *apsList[], int iLength);

int  read_hdr_info(FILE *stream, int max_episodes);
void read_header_files();

/*--------------------------------------------------------------------------*/


main(int argc, char *argv[])
{
   char *p1;
   int i, count;
   FILE *temp;
   int eplow, ephi;

   nullstr[0] = NULL;

   /******
   * Initialize defaults
   ******/
   episode_num = 0;  // Episode number (0 unless user uses /G option)
   num_episodes= 1;  // # of episodes

   wolf_ver   = 0;   // 0=v1.0
   help_flag  = 0;   // 0=No help
   item_mode  = 2;   // 2=Show non-trivial items only
   count_flag = 0;   // 0=No count file
   enemy_mode = 1;   // 1=Enemies by skill level
   pause_flag = 1;   // 1=Pause during help screen.
   num_lines  = 0;   // Line counter for pause option

   map_type     = 0; // Normal map
   double_width = 0; // 0=use a single char on map for each map/object value
   map_from     = 0; // From level (0 unless user uses /L option)
   map_to       = 0; // To   level (0 unless user uses /L option)

   hex_scale_x  = 1; // 1=print hexadecimal X scale on map
   hex_scale_y  = 1; // 1=print hexadecimal Y scale on map

   ep11_flag  = 0;
   ep13_flag  = 0;
   ep46_flag  = 0;
   ep16_flag  = 0;

   for (i=0; i<MAP_MAXEPISODES; i++)
   {
      for (count=0; count < MAP_MAXLEVELS; count++)
         map_offset[i][count] = 0;
   }

   *maphead1_filename = NULL;
   *maphead2_filename = NULL;
   *maptemp_filename  = NULL;
   *wolfmap_filename  = NULL;
   *count_filename    = NULL;


   /******
   * Print opening title
   ******/
   printf("\nWOLFMAP v1.2 by David Lummis.  For a help summary use: WOLFMAP /?\n\n");

             
   /******
   * Check for command line arguments
   ******/
   if (argc > 1)
   {
      for(count=1; count<argc; count++)
      {
         if (*argv[count]=='-' || *argv[count]=='/')
            set_options(argv[count]+1);
      }
   }

   /******
   * Display help if Help flag is on
   *******/
   if (help_flag)
   {
      display_help();
      return;
   }

   /******
   * Read data from the map header file(s) and determine the # of episodes
   * available.
   *******/
   read_header_files();


   /******
   * Read and process the configuration file
   ******/
   if (*wolfmap_filename==NULL)                  // If user did not supply name
      strcpy(wolfmap_filename, FILE_WOLFMAP);    // use default filename
   read_config();


   /******
   *
   * Found episodes: 1-3, 4-6
   *
   * Episode number  (1 to 6)?
   * Level # (1 to 10, *=All)?
   *
   * If user did not specify a game number (and there is more than 1 game
   * available) or if user did not specify a level number,
   * then ask user interactively.
   ******/
   printf("Found episodes: ");

   if (ep16_flag)
   {
      printf("1-6");
      eplow = 1;
      ephi  = 6;
   }
   else if (ep11_flag)
   {
      printf("1");
      eplow = 1;
      ephi  = 1;
   }
   else
   {
      if (ep13_flag)
      {
         printf("1-3");
         eplow = 1;
         ephi  = 3;

         if (ep46_flag)
         {
            ephi  = 6;
            printf(", 4-6");
         }
         else
         {
            printf("1-%s", num_episodes);
            eplow = 1;
            ephi  = num_episodes;
         }
      }
      else
      {
         if (ep46_flag)
         {
            printf("4-6");
            eplow = 4;
            ephi  = 6;
         }
         else
         {
            printf("1-%s", num_episodes);
            eplow = 1;
            ephi  = num_episodes;
         }
      }
   }
   printf("\n\n");


   if (ephi-eplow > 1 && episode_num==0)
   {
      while (episode_num == 0)
      {
         printf("Episode number  (%d to %d)? ", eplow, ephi);
         gets(input_buffer);

         episode_num = atoi(input_buffer);
         if (episode_num==0)
            exit(0);

         if (episode_num < eplow || episode_num > ephi || episode_num > MAP_MAXEPISODES)

            episode_num = 0;
      }
   }
   else
   {
      if (episode_num < eplow || episode_num > ephi || episode_num > MAP_MAXEPISODES)

         episode_num = 1;

      printf("Episode number..........: %d\n", episode_num);
   }

   if (map_from==0 || map_to==0)
   {
      while (map_from == 0)
      {
         printf("Level # (1 to %2d, *=All)? ", MAP_MAXLEVELS);
         gets(input_buffer);
         if (*input_buffer=='*')
         {
            map_from = 1;
            map_to   = MAP_MAXLEVELS;
         }
         else
         {
            map_from = atoi(input_buffer);
            if (map_from==0)
               exit(0);

            if (map_from >= 1 && map_from <= MAP_MAXLEVELS)
               map_to = map_from;
            else
               map_from = 0;
         }
      }
   }
   else
   {
      if (map_from==map_to)
         printf("Level number............: %d\n", map_from);
      else
         printf("Level numbers...........: %d to %d\n", map_from, map_to);
   }
   printf("\n");


   /******
   * Determine which version of Wolfenstein we are dealing with.
   *
   *   1. Look for MAPTEMP<data_extension>.
   *      If found, then it is version 1.0
   *   2. Look for GAMEMAPS<data_extension>
   *      If found, then it is version 1.1 or higher.
   ******/

   /* Extract extension from appropriate MAPHEAD filename */
   p1 = strpbrk(episode_num <= 3 ? maphead1_filename : maphead2_filename, ".");
   if (p1)
      strcpy(data_extension, p1);
   else
      *data_extension = NULL;

   strcpy(maptemp_filename, FILE_0MAPTEMP);
   strcat(maptemp_filename, data_extension);

   wolf_ver = 0;  // v1.0

   temp = fopen(maptemp_filename, "rb");
   if (temp==NULL)
   {
      strcpy(maptemp_filename, FILE_1MAPTEMP);
      strcat(maptemp_filename, data_extension);

      wolf_ver = 1;  // v1.1

      temp = fopen(maptemp_filename, "rb");
      if (temp==NULL)
      {
         printf("Unable to open Wolfenstein 3D map data file.\n");
         exit(1);
      }
   }
   fclose(temp);


   /* The count-file filename */
   sprintf(count_filename, "%s%d%s", FILE_COUNT, episode_num, FILE_COUNTEXT);


   /******
   * Now we generate the maps
   ******/
   for (i=map_from-1; i<map_to && i<MAP_MAXLEVELS; i++)
   {
      //Creating map for Episode 1, Level 10...xxxxxxxx.xxx, xxxxxxxx.xxx, xxxxxxxx.xxx

      printf("Creating map for Episode %d, Level %2d...", episode_num, i+1);

      /* Create filenames */
      if (map_type==0)
      {
         sprintf(comb_name, "%s%d.L%02d", FILE_MAP, episode_num, i+1);
      }
      else
      {
         sprintf(comb_name, "%s%dL%02d.T%dA", FILE_MAP2, episode_num, i+1, map_type);

         sprintf(map_name,  "%s%dL%02d.T%dB", FILE_MAP2, episode_num, i+1, map_type);

         sprintf(obj_name,  "%s%dL%02d.T%dC", FILE_MAP2, episode_num, i+1, map_type);

      }

      if (map_offset[episode_num-1][i]!=0 && map_offset[episode_num-1][i]!=0xffffffff)

      {
         /* Generate the map */
         if (make_map(i, map_name, obj_name, comb_name))
            break;

         if (map_type==0)
            printf(" Filename = %s", comb_name);
         else
         {
            printf("%s, %s, %s", comb_name, map_name, obj_name);
         }
      }
      else
         printf("Invalid file offset.");

      /* Drop cursor onto next screen line */
      printf("\n");
   }

   /******
   * If user wants a count file, then create it now.
   ******/
   if (count_flag)
      count_data();

   /******
   * Print legend page
   ******/
   if (map_type==0 || map_type==1)
      print_legend();
}


/*---------------------------------------------------------------------------*/


void read_config()
/*******************
* Read and process the configuration file
*******************/
{
   FILE *hConfig;
   char *p2;
   int  count;

   /***
   * Initialize to default values
   ***/
   for (count=MIN_GROUP; count<=MAX_GROUP; count++)
   {
      map_groups[count].character   = '?';
      map_groups[count].character2a = '?';
      map_groups[count].character2b = '?';
      map_groups[count].type        = 0;
      map_groups[count].legend      = 'N';
      map_groups[count].description = nullstr;

      obj_groups[count].character   = '?';
      obj_groups[count].character2a = '?';
      obj_groups[count].character2b = '?';
      obj_groups[count].type        = 0;
      obj_groups[count].legend      = 'N';
      obj_groups[count].description = nullstr;
   }
   for (count=MIN_VALUE; count<=MAX_VALUE; count++)
   {
      map_values[count].group = 0;

      obj_values[count].group = 0;
   }

   /***
   * Open configuration file.
   ***/
   hConfig = fopen(wolfmap_filename, "r");
   if (hConfig == NULL)
   {
      printf("Error opening %s\n", wolfmap_filename);
      exit(1);
   }

   /***
   * Read and process config file
   ***/
   input_line = 0;

   p2 = init_readline(hConfig);   // Read first line

   while (feof(hConfig)==0)
   {
      switch (*p2)
      {
         case '[':
            init_section(hConfig, p2);  // Handle a section
            break;

         default:
            printf("File %s, Line %d: Unknown line encountered.\n", wolfmap_filename, 
input_line);
            break;
      }

      p2 = init_readline(hConfig);      // Read next line
   }

   fclose(hConfig);
}


/*---------------------------------------------------------------------------*/


void init_section(FILE *hConfig, char *p1)
/********
* Process a section in the config file.
********/
{
   char *p2;

   p2 = strpbrk(p1, "]");
   if (p2 == NULL)
   {
      printf("File %s, Line %d: Invalid section header.\n", wolfmap_filename, input_line);

      exit(1);
   }

   *(p2+1) = NULL;

   if (strcmp(p1, SECT_MAPGROUPS)==0)
   {
      init_groups(map_groups, hConfig);
   }
   else if (strcmp(p1, SECT_MAPVALUES)==0)
   {
      init_values(map_values, hConfig);
   }
   else if (strcmp(p1, SECT_OBJGROUPS)==0)
   {
      init_groups(obj_groups, hConfig);
   }
   else if (strcmp(p1, SECT_OBJVALUES)==0)
   {
      init_values(obj_values, hConfig);
   }
   else
   {
      printf("File %s, Line %d: Unknown section header encountered.\n", wolfmap_filename, 
input_line);
      exit(1);
   }

   return;
}


/*---------------------------------------------------------------------------*/


char *init_readline(FILE *handle)
/********
* Read a line from the config file
********/
{
   char *p2;

   while (feof(handle)==0)
   {
      input_pos = ftell(handle);          // Save current file position
      fgets(input_buffer, 254, handle);   // Read line

      input_line++;                       // Increment line counter

      p2 = strpbrk(input_buffer, "\n");   // Check for newline char
      if (p2)
         *p2 = NULL;                      // Truncate at newline char

      p2 = input_buffer;
      while (*p2==' ')
         p2++;                            // Skip leading blanks

      if (*p2 != '*' && *p2 != NULL)      // Exit if not null or comment
         break;
   }

   return(p2);
}


/*---------------------------------------------------------------------------*/


void init_groups(struct group_rec *group, FILE *hConfig)
/**********
* Read group info from configuration file
**********/
{
   byte work[4];
   byte *p2, *desc;
   int  group_num;
   byte character;
   byte character2a;
   byte character2b;
   int  type;
   char legend;

   work[3] = NULL;

   p2 = init_readline(hConfig);    // Read first line

   while (feof(hConfig)==0 && *p2 != '[')
   {
      // Make sure line is long enough
      if (strlen(p2) < LEN_GROUPLINE)
      {
         printf("File %s, Line %d: Not enough characters on line.\n", wolfmap_filename, 
input_line);
         exit(1);
      }

      // Extract "group number"
      work[0] = *p2++;
      work[1] = *p2++;
      work[2] = *p2++;
      group_num = atoi(work);
      if (group_num < 0 || group_num > 255)
      {
         printf("File %s, Line %d: Group number out of range.\n", wolfmap_filename, 
input_line);
         exit(1);
      }

      p2++;   // Skip over space

      // Extract "character"
      character = *p2++;

      p2++;   // Skip over space

      // Extract "double width character 1"
      character2a = *p2++;
      // Extract "double width character 2"
      character2b = *p2++;

      p2++;   // Skip over space

      // Extract "type"
      work[0] = *p2++;
      work[1] = NULL;
      type = atoi(work);
      if (type < 0 || type > 255)
      {
         printf("File %s, Line %d: Type number out of range.\n", wolfmap_filename, 
input_line);
         exit(1);
      }

      p2++;   // Skip over space

      // Extract "print on legend?" flag (Y=print)
      legend = toupper(*p2);
      if (legend != 'Y')
         legend = 'N';
      p2++;

      /* Rest of line may be missing, so test char at p2 before using */
      if (*p2)
         p2++;   // Skip over space

      /* Allocate memory for description */
      desc = malloc(LEN_GDESCRIPTION+1);
      if (desc==NULL)
      {
         printf("Unable to allocate memory for group description.\n");
         exit(1);
      }

      if (*p2)
      {
         strncpy(desc, p2, LEN_GDESCRIPTION);
         *(desc+LEN_GDESCRIPTION)=NULL;        // Make sure null terminated.
      }
      else
         *desc = NULL;

      // Assign values
      group[group_num].character   = character;
      group[group_num].character2a = character2a;
      group[group_num].character2b = character2b;
      group[group_num].type        = type;
      group[group_num].legend      = legend;
      group[group_num].description = desc;

      p2 = init_readline(hConfig); // Read next line
   }

   if (*p2 == '[')
   {
      fseek(hConfig, input_pos, SEEK_SET); // Go back to the "[" line
      input_line--;
   }

   return;
}


/*---------------------------------------------------------------------------*/


void init_values(struct value_rec *value, FILE *hConfig)
/**********
* Read value info from configuration file
**********/
{
   char work[4];
   char *p2;
   int  value_num;
   int  group_num;

   work[3] = NULL;

   p2 = init_readline(hConfig); // Read first line

   while (feof(hConfig)==0 && *p2 != '[')
   {
      // Make sure line is long enough
      if (strlen(p2) < LEN_VALUELINE)
      {
         printf("File %s, Line %d: Not enough characters on line.\n", wolfmap_filename, 
input_line);
         exit(1);
      }

      // Extract "value number"
      work[0] = *p2++;
      work[1] = *p2++;
      work[2] = NULL;
      value_num = hextoi(work);
      if (value_num < 0 || value_num > 255)
      {
         printf("File %s, Line %d: Value out of range.\n", wolfmap_filename, input_line);

         exit(1);
      }

      p2++;   // Skip over space

      // Extract "group number"
      work[0] = *p2++;
      work[1] = *p2++;
      work[2] = *p2++;
      group_num = atoi(work);
      if (group_num < 0 || group_num > 255)
      {
         printf("File %s, Line %d: Group number out of range.\n", wolfmap_filename, 
input_line);
         exit(1);
      }

      // Assign values
      value[value_num].group = group_num;

      p2 = init_readline(hConfig); // Read next line
   }

   if (*p2 == '[')
   {
      fseek(hConfig, input_pos, SEEK_SET); // Go back to the "[" line
      input_line--;
   }

   return;
}


/*---------------------------------------------------------------------------*/


void set_options(char *f)
{
 int data, data2, on_off;
 char *p;
 byte ch;

 while( *f != NULL)
 {
    data = toupper(*f);

    on_off = 1;
    data2  = NULL;
    if (data)
    {
       /* Check next char for + or -. (quick check for allowing on/off switches) 
*/
       data2 = *(f+1);
       switch(data2)
       {
          case '+':
             on_off = 1;
             break;
          case '-':
             on_off = 0;
             break;
          default:
             on_off = 1;
             break;
       }
    }

    switch (data)
    {
     case '?':
     case 'H':
        help_flag = 1;     /* Display help screen */

        pause_flag = on_off;
        return;

     case '2':
        double_width = on_off;
        break;

     case 'C':
        count_flag = on_off;
        break;

     case 'F':
        f++;

        data2 = toupper(*f);

        if (data2)
        {
           f++;
           switch (data2)
           {
              case 'C':
                 strcpy(wolfmap_filename, f);
                 break;
           }
        }
        return;

     case 'X':
        f++;

        if (*f=='-')
           hex_scale_x = 0;
        else
           hex_scale_x = 1;
        return;

     case 'Y':
        f++;

        if (*f=='-')
           hex_scale_y = 0;
        else
           hex_scale_y = 1;
        return;

     case 'L':
        f++;

        if (*f == '*')
        {
           map_from = 1;
           map_to   = MAP_MAXLEVELS;
        }
        else
        {
           map_from = atoi(f);

           if (map_from < 1) map_from = 1;
           if (map_from > MAP_MAXLEVELS) map_from = MAP_MAXLEVELS;

           map_to   = map_from;
        }
        return;

     case 'T':
        f++;

        map_type = atoi(f);
        if (map_type < 0) map_type = 0;
        if (map_type > MAP_NUMTYPES) map_type = MAP_NUMTYPES;

        return;

     case 'G':
        f++;

        episode_num = atoi(f);

        if (episode_num < 1 || episode_num > MAP_MAXEPISODES)
           episode_num = 1;

     case 'E':
        f++;

        /* This applies to symbolic maps only */
        switch (*f)
        {
           case '-':
              /* suppress enemies */
              enemy_mode = 0;
              break;
        }
        return;

     case 'O':
        f++;

        switch (*f)
        {
           case '-':
              /* suppress all items */
              item_mode = 0;
              break;

           case '1':
              /* display all items */
              item_mode = 1;
              break;

           case '2':
              /* display only non trivial items */
              item_mode = 2;
              break;
        }
        return;
    }
    f++;
 }
 return;
}


/*---------------------------------------------------------------------------*/


void one_more_line()
{
 num_lines++;
 if (pause_flag && num_lines >= 23)
 {
    printf("Strike a key when ready . . . ");
    getch();

    printf("%c                              %c", 13, 13);

    num_lines = 0;
 }
 return;
}


/*---------------------------------------------------------------------------*/


void pause(char *p)
{
 puts(p);
 one_more_line();
}


/*---------------------------------------------------------------------------*/


void display_help()
{
   pause("Syntax:");
   pause(" ");
   pause("  WOLFMAP [ <option>[ ...]]");
   pause(" ");
   pause("Valid <option>s:");
   pause(" ");
   pause("  /L<n>      Level number (1 to 10, or * for all).");
   pause("  /G<n>      Game (episode) number (1 to 6).");
   pause(" ");
   pause("  /E-        Suppress display of enemies (/T0 maps only).");
   pause(" ");
   pause("  /O1        Display all objects.");
   pause("  /O2        Display non-trivial objects only. (default)");
   pause("  /O-        Suppress all objects (/T0 maps only).");
   pause(" ");
   pause("  /2         Use two characters per item on symbolic maps (/T0 and /T1 
only)");
   pause(" ");
   pause("  /T0        Map type 0: Symbolic. (default)");
   pause("  /T1        Map type 1: Symbolic.");
   pause("  /T2        Map type 2: Full hex dump.  Not affected by /O.");
   pause("  /T3        Map type 3: Partial hex dump.");
   pause(" ");
   pause("  /C         Create a file containing counts of map and object values");

   pause(" ");
   pause("  /X         Display  hexadecimal X scale on maps. (default)");
   pause("  /X-        Suppress hexadecimal X scale on maps.");
   pause("  /Y         Display  hexadecimal Y scale on maps. (default)");
   pause("  /Y-        Suppress hexadecimal Y scale on maps.");
   pause(" ");
   pause("  /FC<file>  Filename of WOLFMAP Configuration file (default is WOLFMAP.CFG)");

   pause(" ");
   pause("  /?         Display this help screen.");
   pause("  /?-        Display this help screen (no pausing).");
   pause(" ");
   pause("Required files:");
   pause(" ");
   pause("   The current directory is searched for 3 files:");
   pause(" ");
   pause("      1) MAPHEAD.WL?     Wolf3D all versions");
   pause(" ");
   pause("      2) MAPTEMP.WL?     Wolf3D v1.0 only");
   pause("         GAMEMAPS.WL?    Wolf3D v1.1 and higher");
   pause(" ");
   pause("      3) WOLFMAP.CFG     This is WOLFMAP's configuration file.");
   pause(" ");
   pause("Files created:");
   pause(" ");
   pause("  Opt  Filenames         Type          Map contents");
   pause("  ---  ----------------  ------------  -------------------------------------");

   pause("  /T0  WMAP<g>.L<nn>     Symbolic.     Map and object data.");
   pause("       WMAP<g>.LEG       Legend.       List of symbols used on maps.");

   pause(" ");
   pause("  /T1  WMAP<g>L<nn>.T1A  Symbolic.     Map and object data.");
   pause("       WMAP<g>L<nn>.T1B  Symbolic.     Map data only.");
   pause("       WMAP<g>L<nn>.T1C  Symbolic.     Object data only.");
   pause("       WMAP<g>.LEG       Legend.       List of symbols used on maps.");

   pause(" ");
   pause("  /T2  WMAP<g>L<nn>.T2A  Full hex.     Map and object data.");
   pause("       WMAP<g>L<nn>.T2B  Full hex.     Map data only.");
   pause("       WMAP<g>L<nn>.T2C  Full hex.     Object data only.");
   pause(" ");
   pause("  /T3  WMAP<g>L<nn>.T3A  Partial hex.  Map and object data.  No floors.");

   pause("       WMAP<g>L<nn>.T3B  Partial hex.  Map data only.        No walls.");

   pause("       WMAP<g>L<nn>.T3C  Partial hex.  Object data only.     No 00's.");

   pause(" ");
   pause("  /C   WMAP<g>.COU       Table.        Count of map and object data by 
level");
   pause(" ");
   pause("  where: <g>  = game  number (1 to 6)");
   pause("         <nn> = level number (01 to 10)");
   pause(" ");

   return;
}


/*---------------------------------------------------------------------------*/


int make_map(int level, char *mapfile, char *objfile, char *combfile)
{
   /*****
   * Read level data
   *****/
   if (read_map(level))
      return;

   if (map_type == 0)
   {
      if (make_map2(0, level, combfile, map_data))
         return(1);
   }
   else
   {
      if (make_map2(2, level, combfile, map_data))
         return(1);

      if (make_map2(0, level, mapfile, map_data))
         return(1);

      if (make_map2(1, level, objfile, obj_data))
         return(1);
   }
}


/*---------------------------------------------------------------------------*/


int make_map2(int which, int level, char *outfile, word map_info[])
/************
* Make an output map file (map or objects)
************/
{
   word count;
   int  start, mult;
   FILE *out_stream;
   char temp[10];

   /****
   * Open output map file
   ****/
   out_stream = fopen(outfile, "w");
   if (out_stream==NULL)
   {
      printf("Error opening file: %s\n", outfile);
      return(1);
   }

   /****
   * Create map
   ****/
   fprintf(out_stream, "\n");

   *map_title = NULL;
   strncat(map_title, lh.name, sizeof(lh.name));

   strcat(map_title, " (Episode ");
   sprintf(temp, "%d", episode_num);
   strcat(map_title, temp);

   strcat(map_title, ", Level ");
   sprintf(temp, "%d", level+1);
   strcat(map_title, temp);
   strcat(map_title, ")");

   switch (map_type)
   {
      case 0:
      case 1:
         if (double_width==0)
            mult = 1;
         else
            mult = 2;
         break;
      case 2:
      case 3:
         mult = 3;
         break;
   }
   start = ((lh.xsize * mult) - strlen(map_title)) / 2;
   for (count=0; count < start; count++)
       fprintf(out_stream, "%c", ' ');
   fprintf(out_stream, "%s\n", map_title);

   fprintf(out_stream, "\n");
   if (hex_scale_x)
   {
      print_xscale(out_stream, lh.xsize, map_type);
      fprintf(out_stream, "\n");
   }

   print_bytes(which, out_stream, map_info);

   if (hex_scale_x)
   {
      fprintf(out_stream, "\n");
      print_xscale(out_stream, lh.xsize, map_type);
   }

   if (fclose(out_stream))
   {
      printf("Error creating map file.\n");
      exit(1);
   }
   return(0);
}


/*---------------------------------------------------------------------------*/


int read_map(int level)
/******************
* Read the data for a level (map and objects)
*
* Params: level = 0 to n
******************/
{
   word count, data, repeat;
   int  x, y;
   long offset;
   FILE *in_stream;

   /****
   * Open input map data file
   ****/
   in_stream = fopen(maptemp_filename, "rb");
   if (in_stream==NULL)
   {
      printf("Error opening file: %s\n", maptemp_filename);
      return(1);
   }


   /****
   * Read level header
   ****/
   if (seek_file(in_stream, map_offset[episode_num-1][level]))
      return(1);

   if (fread(&lh, sizeof(struct level_header), 1, in_stream) != 1)
   {
      printf("Error reading file: %s\n", maptemp_filename);
      return(1);
   }


   /****
   * Read map data.
   ****/
   if (seek_file(in_stream, lh.map_off))
      return(1);
   read_bytes(in_stream, map_data, lh.map_size);


   /****
   * Read object data.
   ****/
   if (seek_file(in_stream, lh.obj_off))
      return(1);
   read_bytes(in_stream, obj_data, lh.obj_size);

   fclose(in_stream);

   return(0);
}


/*---------------------------------------------------------------------------*/


void read_bytes(FILE *in_stream, word map_info[], word data_size)
/*****************
* Read data from the map file into array (map or objects).
*
* Params: data_size -- # bytes in data block (on disk)
*****************/
{
   word x, y, data, count, repeat;
   int  data_offset;

   byte low, high;
   byte *p1;
   word *p2;
   word *p3;
   int  counter;
   word after_decode, after_decompress;

   /****
   * Read data
   ****/

   if (wolf_ver==1)
   {
      // Read # bytes after decoding
      after_decode = (unsigned)fgetc(in_stream) + (unsigned)(fgetc(in_stream)*256);

   }
   // Read # of bytes after decompressing
   after_decompress = (unsigned)fgetc(in_stream) + (unsigned)(fgetc(in_stream)*256);



   // Read bytes from file
   if (fread(buf1_data, data_size, 1, in_stream) != 1)
   {
      printf("Error reading file: %s\n", maptemp_filename);
      exit(1);
   }


   if (wolf_ver==0)
   {
      // Version 1.0

      // Copy data into word buffer

      counter = data_size / 2;         // # words

      p1 = buf1_data;
      p2 = buf2_data;

      for (count=0; count < counter; count++)
      {
         *p2++ = *p1 + *(p1+1)*256;
         p1 += 2;
      }
   }
   else
   {
      // Version 1.1

      // Decode data
      counter = after_decode / 2;      // # words after decoding

      p1 = buf1_data;                  // source
      p2 = buf2_data;                  // dest

      do
      {
         low  = *p1++;                    // Get low byte of word
         high = *p1++;                    // Get high byte of word

         if (high == 0xa7)                // Test for A7 high byte
         {
            if (low == 0)                 // Is repeat count zero?
            {
               low  = *p1++;              // Actual low byte is in next byte
               data = low + high * 256;   // Create word

               *p2++ = data;              // Save word
               counter--;                 // One less word
            }
            else
            {
               // # of words is in low byte

               data = *p1++;              // Get offset (# of words)
               p3 = p2 - data;            // Calc temp source ptr = dest - offset


               counter -= low;            // Reduce # words

               for (count=0; count < low; count++)
               {
                  *p2++ = *p3++;
               }
            }
         }
         else if (high == 0xa8)           // Test for A8 high byte
         {
            if (low == 0)                 // Is repeat count zero?
            {
               low  = *p1++;              // Actual low byte is in next byte
               data = low + high * 256;   // Create word

               *p2++ = data;              // Save word
               counter--;                 // One less word
            }
            else
            {
               // # of words is in low byte

               data = *p1 + *(p1+1)*256;  // Get offset (# of words)
               p1 += 2;

               p3 = buf2_data + data - 1; // Calc temp source ptr = buf2 + # words 
- 1 word;

               counter -= low;            // Reduce # words

               for (count=0; count < low; count++)
               {
                  *p2++ = *p3++;
               }
            }
         }
         else
         {
            *p2++ = low + high * 256;     // Store word as is.
            counter--;                    // One less word
         }
      }
      while (counter > 0);
   }


   // Now we decompress the data

   counter = after_decompress / 2;        // # words after decompressing

   p2 = buf2_data;                        // Source
   p3 = map_info;                         // Destination

   do
   {
      data = *p2++;

      if (data == code_repeat)
      {
         repeat = *p2++;                     // # times to repeat next word
         data   = *p2++;                     // Word to repeat

         counter -= repeat;                  // Reduce # words

         for (count=0; count<repeat; count++)
         {
            *p3++ = data;                    // Repeat the word
         }
      }
      else
      {
         *p3++ = data;                       // Store the word
         counter--;                          // One less word
      }
   }
   while (counter > 0);
}


/*---------------------------------------------------------------------------*/


int seek_file(FILE *stream, long offset)
{
   if (fseek(stream, offset, SEEK_SET))
   {
      printf("Error seeking to offset %l\n", offset);
      return(1);
   }
   return(0);
}


/*---------------------------------------------------------------------------*/


void print_xscale(FILE *out_stream, word xsize, int map_type)
/*****************
* Print horizontal x scale on map
*****************/
{
   int count, row, start;
   char hex[8];

   start = 3;
   if (xsize > 0xf)
      start = 2;
   if (xsize > 0xff)
      start = 1;
   if (xsize > 0xfff)
      start = 0;

   for (row=start; row<4; row++)
   {
      if (hex_scale_y)
      {
         fprintf(out_stream, "   ");

         switch (map_type)
         {
            case 2:
            case 3:
               fprintf(out_stream, " ");
               break;
         }
      }

      for (count=0; count<xsize; count++)
      {
         sprintf(hex, "%04x", count);
         fprintf(out_stream, "%c", *(hex+row));
         
         switch (map_type)
         {
            case 0:
            case 1:
               if (double_width)
                  fprintf(out_stream, " ");
               break;
            case 2:
            case 3:
               fprintf(out_stream, "  ");
               break;
         }
      }
      fprintf(out_stream, "\n");
   }
}


/*---------------------------------------------------------------------------*/


void print_bytes(int which, FILE *out_stream, word map_info[])
/*****************
* Print map or object data
*****************/
{
   int  obj_suppress;
   word x, y, data;
   int  data_offset;
   byte data_char, data_char2a, data_char2b, data1;
   struct group_rec *og;
   struct group_rec *mg;

   x = 0;
   y = 0;

   data_offset = 0;
   do
   {
      if (x==0 && hex_scale_y)
      {
         fprintf(out_stream, "%02x ", y);

         switch (map_type)
         {
            case 2:
            case 3:
               fprintf(out_stream, " ");
               break;
         }
      }

      data = map_info[data_offset];

      switch (map_type)
      {
         case 0:
         /******
         * Symbol map
         ******/
            /******
            * Combined map and object data
            ******/
            if (obj_data[data_offset]!=0)
            {
               data1 = data;             /* save map data */

               data      = obj_data[data_offset];   /* get obj data */
               og = &obj_groups[obj_values[data].group];
               data_char   = og->character;
               data_char2a = og->character2a;
               data_char2b = og->character2b;

               /* Should we suppress object ? */
               obj_suppress = 0;

               if (og->type==OT_TRIVIAL && item_mode==2)
               {
                  /* Suppress trivial object */
                  obj_suppress = 1;
               }
               else if (og->type==OT_ENEMY && enemy_mode != 0)
               {
                  /* We want to display the enemy */
                  obj_suppress = 0;
               }
               else if (item_mode==0)
               {
                  /* Suppress all objects */
                  obj_suppress = 1;
               }
               else
               {
                  /* Display the object */
                  obj_suppress = 0;
               }

               if (obj_suppress)
               {
                  /* Suppress object, so use map data instead */
                  data = data1;
                  mg = &map_groups[map_values[data].group];
                  data_char   = mg->character;
                  data_char2a = mg->character2a;
                  data_char2b = mg->character2b;
               }
            }
            else
            {
               /* no object so use map character */
               mg = &map_groups[map_values[data].group];
               data_char   = mg->character;
               data_char2a = mg->character2a;
               data_char2b = mg->character2b;
            }

            if (double_width)
               fprintf(out_stream, "%c%c", data_char2a, data_char2b);
            else
               fprintf(out_stream, "%c", data_char);
            break;

         case 1:
         /******
         * Symbol map
         ******/
            switch (which)
            {
               case 0:
                  /******
                  * Map data only
                  ******/
                  mg = &map_groups[map_values[data].group];
                  if (double_width)
                     fprintf(out_stream, "%c%c", mg->character2a, mg->character2b);

                  else
                     fprintf(out_stream, "%c", mg->character);
                  break;

               case 1:
                  /******
                  * Object data only
                  ******/
                  og = &obj_groups[obj_values[data].group];

                  if (item_mode==2 && og->type==OT_TRIVIAL)
                  {
                     if (double_width)
                        fprintf(out_stream, "  ");  /* suppress trivial object */

                     else
                        fprintf(out_stream, " ");   /* suppress trivial object */

                  }
                  else
                  {
                     if (double_width)
                        fprintf(out_stream, "%c%c", og->character2a, og->character2b);

                     else
                        fprintf(out_stream, "%c", og->character);
                  }
                  break;

               case 2:
                  /******
                  * Combined map and object data
                  ******/
                  if (obj_data[data_offset]!=0)
                  {
                     data1 = data;             /* save map data */

                     data      = obj_data[data_offset];   /* get obj data */
                     og = &obj_groups[obj_values[data].group];
                     data_char   = og->character;
                     data_char2a = og->character2a;
                     data_char2b = og->character2b;

                     if (item_mode==2 && og->type==OT_TRIVIAL)
                     {
                        /* Is a trivial object, so use map data instead */
                        data = data1;
                        mg = &map_groups[map_values[data].group];
                        data_char   = mg->character;
                        data_char2a = mg->character2a;
                        data_char2b = mg->character2b;
                     }
                  }
                  else
                  {
                     /* no object so use map character */
                     mg = &map_groups[map_values[data].group];
                     data_char   = mg->character;
                     data_char2a = mg->character2a;
                     data_char2b = mg->character2b;
                  }

                  if (double_width)
                     fprintf(out_stream, "%c%c", data_char2a, data_char2b);
                  else
                     fprintf(out_stream, "%c", data_char);
                  break;
            }
            break;
         case 2:
            /******
            * Hex map unfiltered full dump.
            ******/
            switch (which)
            {
               case 2:
                  /****
                  * Combined map and object data
                  * We want overlay any objects on the map data
                  ****/
                  if (obj_data[data_offset]!=0)
                  {
                     data = obj_data[data_offset];   /* dispay object value */
                  }
                  break;
            }
            fprintf(out_stream, "%02x ", data);
            break;

         case 3:
         /******
         * Hex maps, filtered, partial dump
         ******/
            og = &obj_groups[obj_values[data].group];
            mg = &map_groups[map_values[data].group];

            switch (which)
            {
               case 0:
                  /******
                  * Map data only
                  * We want to show all but walls.
                  ****/
                  if (mg->type==MT_WALL)
                  {
                     data = 0;  /* suppress walls */
                  }
                  break;

               case 1:
                  /****
                  * Object data only
                  * We want to show objects only.
                  ****/
                  if (item_mode==2 && og->type==OT_TRIVIAL)
                  {
                     /* Is a trivial object, so ignore */
                     data = 0;
                  }
                  break;

               case 2:
                  /****
                  * Combined map and object data
                  * We want to show any objects, all walls, and no floors.
                  ****/
                  if (obj_data[data_offset]!=0)
                  {
                     data = obj_data[data_offset];   /* dispay object value */

                     og = &obj_groups[obj_values[data].group];
                     if (item_mode==2 && og->type==OT_TRIVIAL)
                     {
                        /* Is a trivial object, so ignore */
                        data = 0;
                     }
                  }
                  else if (mg->type==MT_FLOOR)
                  {
                     data = 0;  /* suppress hex value */
                  }
                  break;
            }

            if (data==0)
               fprintf(out_stream, "   ");
            else
               fprintf(out_stream, "%02x ", data);

            break;
      }

      x++;
      data_offset++;

      if (x >= lh.xsize)
      {
         if (hex_scale_y)
            fprintf(out_stream, " %02x", y);

         fprintf(out_stream, "\n");
         x = 0;
         y++;
      }
   }
   while (y < lh.ysize);
}


/*---------------------------------------------------------------------------*/


int count_data()
{
   int i, j;
   FILE *out_stream;


   out_stream = fopen(count_filename, "w");
   if (out_stream==NULL)
   {
      printf("Error opening %s\n", count_filename);
      return(1);
   }

   fprintf(out_stream, "\nWolfenstein 3D:  Episode %d\n\n", episode_num);


   /********
   * Map data
   ********/

   /* Reset totals */
   for (i=0; i<256; i++)
   {
      totals[i] = 0;

      for (j=0; j < MAP_MAXLEVELS; j++)
         counts[j][i] = 0;
   }

   /* Count map data */
   for (i=0; i<MAP_MAXLEVELS; i++)
   {
      if (map_offset[episode_num-1][i]!=0 && map_offset[episode_num-1][i]!=0xffffffff)

      {
         if (read_map(i))
            return(1);
         count_level(i, map_data);
      }
   }

   /* Print results */
   fprintf(out_stream, "\nMap data\n\n");
   print_counts(out_stream);

   /********
   * Object data
   ********/

   /* Reset totals */
   for (i=0; i<256; i++)
   {
      totals[i] = 0;

      for (j=0; j < MAP_MAXLEVELS; j++)
         counts[j][i] = 0;
   }
   /* Count object data */
   for (i=0; i<MAP_MAXLEVELS; i++)
   {
      if (map_offset[episode_num-1][i]!=0 && map_offset[episode_num-1][i]!=0xffffffff)

      {
         if (read_map(i))
            return(1);
         count_level(i, obj_data);
      }
   }

   /* Print results */
   fprintf(out_stream, "\nObject data\n\n");
   print_counts(out_stream);



   fclose(out_stream);

   return(0);
}


/*---------------------------------------------------------------------------*/


void print_counts(FILE *out_stream)
{
   int i, j;


   fprintf(out_stream, "     TOTAL");
   for (j=0; j<MAP_MAXLEVELS; j++)
      fprintf(out_stream, " %5d", j+1);
   fprintf(out_stream, "\n");

   fprintf(out_stream, "    ======");
   for (j=0; j<MAP_MAXLEVELS; j++)
      fprintf(out_stream, " -----");
   fprintf(out_stream, "\n");


   for (i=0; i<256; i++)
   {
      if (totals[i] > 0)
      {
         fprintf(out_stream, "%02x: %6u", i, totals[i]);

         for (j=0; j<MAP_MAXLEVELS; j++)
         {
            if (counts[j][i] > 0)
                fprintf(out_stream, " %5u", counts[j][i]);
            else
                fprintf(out_stream, "      ");
         }

         fprintf(out_stream, "\n");
      }
   }
   return;
}


/*---------------------------------------------------------------------------*/


void count_level(int level, word map_info[])
{
   int i;
   int data_offset;

   word x, y, data;

   x = 0;
   y = 0;

   data_offset = 0;
   do
   {
      data = map_info[data_offset];

      counts[level][data] ++;
      totals[data] ++;

      x++;
      data_offset++;

      if (x >= lh.xsize)
      {
         x = 0;
         y++;
      }
   }
   while (y < lh.ysize);

   return;
}


/*---------------------------------------------------------------------------*/


int hextoi(char *hex)
{
   char *p2, ch;
   long mult;
   int  result;
   int  digit;

   mult = 1;
   result = 0;

   if (*hex == NULL)
      return(0);

   p2 = hex;

   // Advance to last digit
   while (*p2)
      p2++;
   p2--;

   do
   {
      ch = toupper(*p2);

      if (isxdigit(ch)==0)
         ch = '0';

      if (ch >= '0' && ch <= '9')
      {
         digit = ch - '0';
      }
      else
      {
         digit = ch - 'A' + 10;
      }

      result += (digit * mult);

      mult *= 16;
   }
   while (p2-- != hex);

   return(result);
}


/*---------------------------------------------------------------------------*/


void print_legend()
{
   int ii, jj;
   int count1, count2, count3;
   int start2, start3;
   FILE *stream;

   count1 = 0;

   // Create arrays of pointers to structures, eliminate items that will not
   // print on legend, calculate # elements to print in each column.
   for (ii=MIN_GROUP; ii<=MAX_GROUP; ii++)
   {
      if (map_groups[ii].legend == 'Y')
      {
         sortgroups[count1++] = &map_groups[ii];
      }
   }
   for (ii=MIN_GROUP; ii<=MAX_GROUP; ii++)
   {
      if (obj_groups[ii].legend == 'Y')
      {
         sortgroups[count1++] = &obj_groups[ii];
      }
   }

   // Calculate # to print in each column
   start2 = 0;
   if (count1 > 60)
   {
      // More than one column
      if (count1 <= 120)
      {
         // But <= 2 columns...Fill left column first.
         count2 = 60;
         start3 = count2;
         count3 = count1 - count2;
      }
      else
      {
         // More than 2 columns...Split evenly into two long columns.
         count2 = (count1+1)/ 2;
         start3 = count2;
         count3 = count1 - count2;
      }
   }
   else
   {
      // <= 1 column
      count2 = count1;
      start3 = 0;
      count3 = 0;
   }


   // Sort list
   vSort_List(sortgroups, count1);

   // Open print file
   sprintf(legend_filename, "%s%d%s", FILE_LEGEND, episode_num, FILE_LEGENDEXT);

   stream = fopen(legend_filename, "w");
   if (stream == NULL)
   {
      printf("Unable to create legend file.\n");
      exit(1);
   }

   /*
   *
   * 1
   * 2 Map legend
   * 3
   * 4 SYM
   * 5 ===
   * 6
   *
   *60
   */

   fprintf(stream, "\n%20sMap Legend for Wolfenstein 3D Episode %d\n", " ", episode_num);


   fprintf(stream, "\nSYM             DESCRIPTION            ");
   if (count3 > 0)
      fprintf(stream, " SYM             DESCRIPTION\n");
   else
      fprintf(stream, "\n");

   fprintf(stream,   "=== ===================================");
   if (count3 > 0)
      fprintf(stream, " === ===================================\n");
   else
      fprintf(stream, "\n");

   // Print details
   for (ii=start2, jj=start3; ii < count2 || jj < start3+count3; ii++, jj++)
   {
      if (ii < count2)
      {
         if (double_width)
            fprintf(stream, "%c%c", sortgroups[ii]->character2a, sortgroups[ii]->character2b);

         else
            fprintf(stream, " %c", sortgroups[ii]->character);
         fprintf(stream, "  %-35s ", sortgroups[ii]->description);
      }
      else
      {
         fprintf(stream, "%41s", " ");
      }

      if (jj < start3+count3)
      {
         if (double_width)
            fprintf(stream, "%c%c", sortgroups[jj]->character2a, sortgroups[jj]->character2b);

         else
            fprintf(stream, " %c", sortgroups[jj]->character);
         fprintf(stream, "  %-35s", sortgroups[jj]->description);
      }

      fprintf(stream, "\n");
   }

   fclose(stream);
   return;
}


/*---------------------------------------------------------------------------*/


void vSort_List(struct group_rec *apsList[], int iLength)
/***************************
* Sort a list of group structures by symbol + description (ascending).
*
* Parameters: apsList[]: Array of pointers to group structures
*             iLength  : Length of array (number of elements).
*
* Returns   : nothing
***************************/
{
   int  iCount1;   /* outer loop counter (number of passes through list) */
   int  iCount2;   /* inner loop counter (lower element # to test) */
   int  iSwaps;    /* swap flag (0=no swaps this pass, 1=swap ocurred) */
   int  iSwapit;
   byte char1a, char2a;
   byte char1b, char2b;

   struct group_rec *psTemp; /* holds pointer during swap of pointers */

   struct group_rec *p1;
   struct group_rec *p2;

   /*****
   * Sort the list by symbol + description (ascending order)
   ******/
   iSwapit = 0;

   /* Reduce # elements to test each loop */
   for (iCount1 = iLength-1; iCount1 > 0; iCount1 --)
   {
      iSwaps = 0;

      /***
      * Loop to test all elements not yet sorted
      ****/
      for (iCount2 = 0; iCount2 < iCount1; iCount2 ++)
      {
         p1 = apsList[iCount2];
         p2 = apsList[iCount2+1];

         if (double_width)
         {
            char1a = toupper(p1->character2a);
            char1b = toupper(p1->character2b);
            char2a = toupper(p2->character2a);
            char2b = toupper(p2->character2b);

            if (char1a > char2a)
            {
               iSwapit = 1;
            }
            else
            {
               if ((char1a == char2a) && (char1b >  char2b))
               {
                  iSwapit = 1;
               }
               else
               {
                  if ((char1a == char2a) && (char1b == char2b) &&
                      (strcmp(p1->description, p2->description) > 0))
                  {
                     iSwapit = 1;
                  }
               }
            }
         }
         else
         {
            char1a = toupper(p1->character);
            char2a = toupper(p2->character);

            if (char1a > char2a)
            {
               iSwapit = 1;
            }
            else
            {
               if ((char1a == char2a) &&
                   (strcmp(p1->description, p2->description) > 0))
               {
                  iSwapit = 1;
               }
            }
         }

         if (iSwapit)
         {
            iSwapit = 0;
            iSwaps  = 1;

            /***
            * Swap pointers
            ****/
            psTemp             = apsList[iCount2];
            apsList[iCount2]   = apsList[iCount2+1];
            apsList[iCount2+1] = psTemp;
         }
      }

      if (iSwaps==0)  /* If no swaps have ocurred then we are done */
         break;
   }
   return;
}


/*---------------------------------------------------------------------------*/


int read_hdr_info(FILE *stream, int max_episodes)
/****************
* Read data from the map header file (tells us the offset of each map
* in the actual map data file)
****************/
{
   unsigned long offset, save_offset;
   int num_read, good_offset, num_episodes;
   word data, count, count2;



   /* Get initial word (ABCD) */
   code_repeat = (unsigned)fgetc(stream) + (unsigned)(fgetc(stream)*256);


   /* Skip over any 0 or ffffffff offset (in case the .WL6 file containing
      only episodes 4 to 6 does not store the offsets right at the beginning
      of the file...(this was not known at the time this program was written))
   */
   while (feof(stream)==0)
   {
      save_offset = ftell(stream);

      num_read = fread(&offset, 4, 1, stream);
      if (num_read != 1)
         break;

      if (offset!=0 && offset!=0xffffffff)
      {
         fseek(stream, save_offset, SEEK_SET);  // So we can reread map offset
         break;
      }
   }

   /* Get file offsets to maps */
   num_episodes = 0;
   for (count=0; count<max_episodes && feof(stream)==0; count++)
   {
      good_offset = 0;

      for (count2=0; count2<MAP_MAXLEVELS && feof(stream)==0; count2++)
      {
         num_read = fread(&offset, 4, 1, stream);
         if (num_read != 1)
            break;

         map_offset[count][count2] = offset;

         if (offset!=0 && offset!=0xffffffff)
            good_offset = 1;
      }
      if (good_offset)
         num_episodes++;  // Count # episodes with at least one valid offset
   }

   return(num_episodes);
}


/*---------------------------------------------------------------------------*/


void read_header_files()
{
   int count, count2;
   FILE *temp;

   strcpy(maphead1_filename, FILE_MAPHEAD);
   strcat(maphead1_filename, FILE_MAPEXT);
   strcat(maphead1_filename, "6");

   temp = fopen(maphead1_filename, "rb");
   if (temp!=NULL)
   {
      /****
      * Header file may contain map offsets for all 6 episodes, OR just
      * episodes 4 to 6 (note: this was an early assumption. Evidence now
      * indicates that all 6 episodes should be in the WL6 file...but this
      * will still catch the other case if true).
      *****/
      num_episodes = read_hdr_info(temp, 6);
      fclose(temp);

      if (num_episodes==3)
      {
         /****
         * Shift offsets in first 3 episode slots, into the correct slots
         * for episodes 4 to 6
         *****/
         for (count=0; count<3; count++)
         {
            for (count2=0; count2<MAP_MAXLEVELS; count2++)
               map_offset[count+3][count2] = map_offset[count][count2];
         }

         /* Save filename for episodes 4 to 6 */
         strcpy(maphead2_filename, maphead1_filename);

         ep46_flag = 1;

         /****
         * Reset the first 3 slots
         *****/
         for (count=0; count<3; count++)
         {
            for (count2=0; count2<MAP_MAXLEVELS; count2++)
               map_offset[count][count2] = 0;
         }

         /****
         * Try for MAPHEAD.WL3 file which should contain offsets for
         * episodes 1 to 3
         *****/
         strcpy(maphead1_filename, FILE_MAPHEAD);
         strcat(maphead1_filename, FILE_MAPEXT);
         strcat(maphead1_filename, "3");

         temp = fopen(maphead1_filename, "rb");
         if (temp!=NULL)
         {
            /* Header file should contain map offsets for episodes 1 to 3 */
            num_episodes += read_hdr_info(temp, 3);
            fclose(temp);
            ep13_flag = 1;
         }
      }
      else
      {
         /***
         * File should contain data for all 6 episodes
         ****/
         ep16_flag = 1;

         strcpy(maphead2_filename, maphead1_filename);
      }
   }
   else
   {
      /*****
      * Was no MAPHEAD.WL6 file, so try for just MAPHEAD.WL3 (first 3 episodes)
      ******/
      strcpy(maphead1_filename, FILE_MAPHEAD);
      strcat(maphead1_filename, FILE_MAPEXT);
      strcat(maphead1_filename, "3");

      temp = fopen(maphead1_filename, "rb");
      if (temp!=NULL)
      {
         /* Header file should contain map offsets for episodes 1 to 3 */
         num_episodes = read_hdr_info(temp, 6);
         fclose(temp);
         ep13_flag = 1;
      }
      else
      {
         /*****
         * Was no MAPHEAD.WL3 file, so try for just MAPHEAD.WL1 (episode
         * 1 only)
         ******/
         strcpy(maphead1_filename, FILE_MAPHEAD);
         strcat(maphead1_filename, FILE_MAPEXT);
         strcat(maphead1_filename, "1");

         temp = fopen(maphead1_filename, "rb");
         if (temp!=NULL)
         {
            /* Header file should contain map offsets for episode 1 */
            num_episodes = read_hdr_info(temp, 6);
            fclose(temp);
            ep11_flag = 1;
         }
         else
         {
            /*****
            * Could not find MAPHEAD.WL6, .WL3, or .WL1
            ******/
            printf("Unable to locate %s%s6, %s%s3, or %s%s1\n",
                 FILE_MAPHEAD, FILE_MAPEXT, FILE_MAPHEAD, FILE_MAPEXT,
                 FILE_MAPHEAD, FILE_MAPEXT);
            exit(1);
         }
      }
   }

   if (num_episodes==0)
   {
      printf("No map offsets found\n");
      exit(1);
   }
   if (num_episodes > MAP_MAXEPISODES)
      num_episodes = MAP_MAXEPISODES;

   return;
}

