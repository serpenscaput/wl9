/* Program name:  WMAP.C
   Description:   Draws maps for Wolfenstein 3D using ASCII characters
   Author:        P.G.W.Hosken  (<RMCB@DLRVM> or via GAMES-L)
   Version:       3.0
   Compilation:   MSC, compile using "cl wmap.c"

   Changes:  v1.0 - Original version.
             v2.0 - Blue SS guards marked separate to normal guards.
                    Key updated.
                    Code generally improved.
                    Command line parameters included.
             v2.1 - Minor mods.
                    Map interpretation errors corrected.
*/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function declarations */
void DRAWMAP (FILE*,int);
void HELP    (void);
void KEY     (FILE*);
void OUTVAL  (FILE*,int,int);
void OUTVAL2 (FILE*,FILE*,int,int);
int  READC   (FILE*,char*);

/* Map titles (taken from MAPTEMP.WL1) */
char *TITLE[] = {"Wolf1 Map1",
                 "Wolf1 Map2",
                 "Wolf1 Map3",
                 "Wolf1 Map4",
                 "Wolf1 Map5",
                 "Wolf1 Map6",
                 "Wolf1 Map7",
                 "Wolf1 Map8",
                 "Wolf1 Boss",
                 "Wolf1 Secret"};

/* Offset of start of map data in file */
int SECTOR[] = {0,8,22,36,49,63,73,84,95,98};
int OFFSET[] = {0x030,0x144,0x148,0x13A,0x1B0,0x178,0x1A8,0x1C4,0x076,0x0A4};

/* Output filename masks */
char *FIN   = "MAPTEMP.WL1";
char *FNAME = "LEVEL00.MAP";
char *FTEMP = "WMAP.TMP";

/* List of maps to output */
int MAPS[10] = {0,0,0,0,0,0,0,0,0,0};

/* 'Output key' switch */
int KEYON=0;

/*-------------------------------------------------------------------------*/

main(argc,argv)
int argc;
char **argv;
{
  FILE *FP1;     /* File pointer for MAPTEMP.WL1 */
  int   I;       /* 'for' loop counter */
  int   J;       /* 'for' loop counter */
  int   LEV;     /* Map level number */

  /* Check command line */
  for (I=1;I<argc;I++) {
 
    /* Check for switches */
    if (**(argv+I)=='/' || **(argv+I)=='-') {
      switch (*(*(argv+I)+1)) {
        case 'K':
        case 'k':  /* Output key */
                   KEYON=1;
                   break;
        case '?':
        default:   /* Help (and then exit) */
                   HELP();
      }
    }

    /* Check map number */
    else {
      if (!strcmp(strupr(*(argv+I)),"ALL")) {
        for (J=0;J<10;J++) MAPS[J]=1;
      }
      else {
        J=atoi(*(argv+I));
        if (J<1 || J>10) HELP();
        MAPS[J-1]=1;
      }
    }
  }

  /* Check that at least 1 map specified */
  for (I=J=0;I<10;I++) J+=MAPS[I];
  if (!J) HELP();

  /* Open input file */
  if ((FP1=fopen(FIN,"rb"))==NULL) {
    printf("\nERROR: cannot open file %s\n",FIN);
    exit(2);
  }

  /* Draw maps */
  for (LEV=0;LEV<10;LEV++) {
    if (MAPS[LEV]) DRAWMAP(FP1,LEV);
  }

  /* Tidy up */
  fclose(FP1);
}

/*-------------------------------------------------------------------------*/

void DRAWMAP(FP1,MN)

FILE *FP1;  /* Output file pointer */
int   MN;   /* Map number (0-9) */

{
  int   C1,C2;   /* Character input */
  int   COUNT;   /* Map byte count */
  FILE *FP2;     /* File pointer for .TMP file */
  FILE *FP3;     /* File pointer for .MAP file */
  int   I;       /* 'for' loop counter */
  long  LI;      /* 'for' loop counter */
  int   LINE;    /* Output map line counter */
  int   N;       /* Repeat count for map data */
  long  OFF;     /* Offset of start of map data in bytes */


  printf("Constructing map %d\n",MN+1);

  /* Open output file */
  if ((FP2=fopen(FTEMP,"w+b"))==NULL) {
    printf("\nERROR: cannot open work file %s\n",FTEMP);
    exit(2);
  }

  /* Calculate offset of start of map data */
  OFF=SECTOR[MN];
  OFF=OFF*512 + OFFSET[MN];

  /* Position file pointer at start of data */
  if (fseek(FP1,OFF,SEEK_SET)) {
    printf("\nERROR: error positioning pointer in %s\n",FIN);
    exit(2);
  }

  /* Part 1 - read maze data */
  COUNT=0;
  for (;;) {

    /* Read 2 bytes */
    C1=READC(FP1,FIN);
    C2=READC(FP1,FIN);

    /* Check for repeated value */
    if (C1==0xCD && C2==0xAB) {
      C1=READC(FP1,FIN);
      C2=READC(FP1,FIN);
      N=C2*256 + C1;       /* Repetition */
      C1=READC(FP1,FIN);
      C2=READC(FP1,FIN);

      /* Output values */
      for (I=0;I<N;I++) {
        OUTVAL(FP2,C1,C2);
        COUNT++;
      }
    }

    /* Single value */
    else {
      OUTVAL(FP2,C1,C2);
      COUNT++;
    }
    if (COUNT>=4096) goto OUT;
  }
OUT:

  /* Rewind output file */
  rewind(FP2);

  /* Skip next 2 bytes */
  C1=READC(FP1,FIN);
  C2=READC(FP1,FIN);

  /* Set file name */
  if (MN!=9) {
    FNAME[5]='0';
    FNAME[6]='1'+MN;
  }
  else {
    FNAME[5]='1';
    FNAME[6]='0';
  }

  /* Open output file */
  if ((FP3=fopen(FNAME,"wt"))==NULL) {
    printf("\nERROR: cannot open output file %s\n",FNAME);
    exit(2);
  }

  /* Print map title */
  if (!fprintf(FP3,"\nWOLFENSTEIN 3D - %s\n\n",TITLE[MN])) {
    printf("\nERROR: writing to output file %s\n",FNAME);
    exit(2);
  }

  /* Part 2 - read object data */
  COUNT=LINE=0;
  for (;;) {

    /* Read 2 bytes */
    C1=READC(FP1,FIN);
    C2=READC(FP1,FIN);

    /* Check for repeated value */
    if (C1==0xCD && C2==0xAB) {
      C1=READC(FP1,FIN);
      C2=READC(FP1,FIN);
      N=C2*256 + C1;      /* Repetition */
      C1=READC(FP1,FIN);
      C2=READC(FP1,FIN);

      /* Output values */
      for (I=0;I<N;I++) {
        if (LINE>=64) {
          if (!fprintf(FP3,"\n")) {
            printf("\nERROR: writing to output file %s\n",FNAME);
            exit(2);
          }
          LINE=0;
        }
        OUTVAL2(FP2,FP3,C1,C2);
        LINE++;
        COUNT++;
      }
    }

    /* Single value */
    else {

      /* Check if new line to be started */
      if (LINE>=64) {
        if (!fprintf(FP3,"\n")) {
          printf("\nERROR: writing to output file %s\n",FNAME);
          exit(2);
        }
        LINE=0;
      }

      /* Output value */
      OUTVAL2(FP2,FP3,C1,C2);
      LINE++;
      COUNT++;
    }
    if (COUNT>=4096) goto OUT2;
  }

OUT2:
  /* Output key */
  if (KEYON) KEY(FP3);

  /* Tidy up */
  fclose(FP2);
  fclose(FP3);

  /* Delete .TMP file */
  if (remove(FTEMP)) {
    printf("\nERROR: cannot delete work file %s\n",FTEMP);
    exit(2);
  }
}

/*-------------------------------------------------------------------------*/

void KEY(FP)
FILE *FP;
{
  fprintf(FP,"\n\nKEY:");
  fprintf(FP,"\n        %c%c  Wall             a   Ammo",177,177);
  fprintf(FP,"\n        %c%c  Wall w/ decor    f   Food",178,178);
  fprintf(FP,"\n        %c%c  Wall-lift        g   Gun-4",219,219);
  fprintf(FP,"\n        %c%c  Exit from maze   k   Key",176,176);
  fprintf(FP,"\n        %c%c  Door             m   Machine gun-3",205,205);
  fprintf(FP,"\n        %c   Door             o   Object",186);
  fprintf(FP,"\n        %c   Lift door        s   Sphere",239);
  fprintf(FP,"\n        %c   Locked door      t   Treasure",240);
  fprintf(FP,"\n        %c   Hidden door      x   Hulk",168);
  fprintf(FP,"\n        %c%c  Cell             ",215,215);
  fprintf(FP,"Dn  Dog: difficulty levels 1-n");
  fprintf(FP,"\n        %c%c  Start of level   ",174,175);
  fprintf(FP,"Gn  Guard: difficulty levels 1-n");
  fprintf(FP,"\n        +   First aid kit    ");
  fprintf(FP,"Bn  Blue guard: difficulty levels 1-n");
  fprintf(FP,"\f");
}

/*-------------------------------------------------------------------------*/

void OUTVAL(FP,X1,X2)

/* Output maze value */

FILE *FP;     /* Output file pointer */
int   X1,X2;  /* 2 input bytes */

{
  unsigned char CH,CH2;

  if (X2) {
    printf("\nCode > 255 (%X)",X2);
    if (!fprintf(FP,"!!")) {
      printf("\nERROR: writing to work file %s\n",FTEMP);
      exit(2);
    }
  }
  else {
    switch (X1) {
      case 0x01: CH=177; break; /* Wall */
      case 0x02: CH=177; break; /* Wall */
      case 0x03: CH=178; break; /* Banner */
      case 0x04: CH=178; break; /* Hitler */
      case 0x05: CH=215; break; /* Cell */
      case 0x06: CH=178; break; /* Swastika w/ eagle */
      case 0x07: CH=215; break; /* Cell w/ skeleton */
      case 0x08: CH=177; break; /* Wall */
      case 0x09: CH=177; break; /* Wall */
      case 0x0A: CH=178; break; /* Eagle */
      case 0x0B: CH=178; break; /* Hitler */
      case 0x0C: CH=177; break; /* Wall */
      case 0x0D: CH=174; break; /* Entrance to level */
      case 0x0F: CH=178; break; /* Steel plates */
      case 0x10: CH=176; break; /* Landscape view */
      case 0x11: CH=177; break; /* Wall */
      case 0x12: CH=178; break; /* Wreath */
      case 0x13: CH=177; break; /* Wall */
      case 0x14: CH=178; break; /* Shield */
      case 0x15: CH=219; break; /* Lift */
      case 0x19: CH=178; break; /* Wall w/ blood */
      case 0x5A: CH=186; break; /* Vert. door */
      case 0x5B: CH=205; break; /* Horiz. door */
      case 0x5C: CH=240; break; /* Locked steel door (needs key) */
      case 0x5D: CH=240; break; /* Locked door (needs key) */
      case 0x64: CH=239; break; /* Lift entrance */
      case 0x6A: CH=' '; break; /* ????? */     
      case 0x6B:
      case 0x6C:
      case 0x6D:
      case 0x6E:
      case 0x6F:
      case 0x70:
      case 0x71:
      case 0x72:
      case 0x73:
      case 0x74:
      case 0x75:
      case 0x76:
      case 0x77:
      case 0x78:
      case 0x79:
      case 0x7A:
      case 0x7B:
      case 0x7C:
      case 0x7D:
      case 0x7E:
      case 0x7F:
      case 0x80:
      case 0x81:
      case 0x82:
      case 0x83:
      case 0x84:
      case 0x85:
      case 0x86:
      case 0x87:
      case 0x88:
      case 0x89:
      case 0x8A:
      case 0x8B:
      case 0x8C:
      case 0x8D:
      case 0x8E:
      case 0x8F: CH=' '; break; /* Floor */
      default:   CH='@';
                 printf("\nPart 1 unknown code (%X)",X1);
    }
    switch (CH) {
      case ' ': CH2=' '; break;
      case 176: CH2=176; break;
      case 177: CH2=177; break;
      case 178: CH2=178; break;
      case 219: CH2=219; break;
      case 215: CH2=215; break;
      case 205: CH2=205; break;
      case 174: CH2=175; break;
      case 240: CH2=240; break;
      default:  CH2=' ';
    }
    if (!fprintf(FP,"%c%c",CH,CH2)) {
      printf("\nERROR: writing to work file %s\n",FTEMP);
      exit(2);
    }
  }
}

/*-------------------------------------------------------------------------*/

void OUTVAL2(FPIN,FPOUT,X1,X2)

/* Output maze value */

FILE *FPIN;   /* File pointer for .TMP file */
FILE *FPOUT;  /* Output file pointer */
int   X1,X2;  /* 2 input bytes */
{
  unsigned char CH;
  int IN,IN2;
  int GUARD=0;
  int DOG=0;

  /* Read maze data for location */
  IN =READC(FPIN,FTEMP);
  IN2=READC(FPIN,FTEMP);

  if (X2) {
    printf("\nCode > 255 (%X)",X2);
    if (!fprintf(FPOUT,"%c€")) {
      printf("\nERROR: writing to output file %s\n",FNAME);
      exit(2);
    }
  }
  else {
    switch (X1) {
      case 0x00: CH=' '; break; /* Nothing */
      case 0x13: CH=' '; break; /* Start position */
      case 0x14: CH=175; break; /* Entrance */
      case 0x15: CH=' '; break; /* ? */
      case 0x17: CH=' '; break; /* Water */
      case 0x18: CH='o'; break; /* Drum */
      case 0x19: CH='o'; break; /* Desk */
      case 0x1A: CH='o'; break; /* Stand lamp */
      case 0x1B: CH=' '; break; /* Chandalier */
      case 0x1C: CH='o'; break; /* Hanging skeleton */
      case 0x1D: CH='f'; break; /* Dog food */
      case 0x1E: CH='o'; break; /* Column */
      case 0x1F: CH='o'; break; /* ? */
      case 0x20: CH='o'; break; /* Skeleton */
      case 0x21: CH='o'; break; /* Sink */
      case 0x22: CH='o'; break; /* Plant */
      case 0x23: CH='o'; break; /* Vase */
      case 0x24: CH='o'; break; /* Table */
      case 0x25: CH=' '; break; /* Lamp */
      case 0x26: CH=' '; break; /* Hanging kitchen utensils */
      case 0x27: CH='o'; break; /* Knight */
      case 0x28: CH='o'; break; /* Empty cage */
      case 0x29: CH='o'; break; /* Cage /w skeleton */
      case 0x2A: CH='o'; break; /* Bones */
      case 0x2B: CH='k'; break; /* Key */
      case 0x2D: CH='o'; break; /* Bed */
      case 0x2E: CH='o'; break; /* Bin */
      case 0x2F: CH='f'; break; /* Food */
      case 0x30: CH='+'; break; /* First aid bed */
      case 0x31: CH='a'; break; /* Ammo */
      case 0x32: CH='m'; break; /* Machine gun (3) */
      case 0x33: CH='g'; break; /* Gun (4) */
      case 0x34: CH='t'; break; /* Cross */
      case 0x35: CH='t'; break; /* Chalace */
      case 0x36: CH='t'; break; /* Jewels */
      case 0x37: CH='t'; break; /* Crown */
      case 0x38: CH='s'; break; /* Sphere */
      case 0x39: CH=' '; break; /* Bones in blood */
      case 0x3A: CH='o'; break; /* Barrel */
      case 0x3B: CH='o'; break; /* Well with water */
      case 0x3C: CH='o'; break; /* Well without water */
      case 0x3D: CH=' '; break; /* Pool of blood */
      case 0x3E: CH='o'; break; /* Flag */
      case 0x49: CH=' '; break; /* ? */
      case 0x5A: CH=' '; break; /* Movement turning point */
      case 0x5B: CH=' '; break; /* Movement turning point */
      case 0x5C: CH=' '; break; /* Movement turning point */
      case 0x5D: CH=' '; break; /* Movement turning point */
      case 0x5E: CH=' '; break; /* Movement turning point */
      case 0x5F: CH=' '; break; /* Movement turning point */
      case 0x60: CH=' '; break; /* Movement turning point */
      case 0x61: CH=' '; break; /* Movement turning point */
      case 0x62: CH=168; break; /* Hidden door */
      case 0x63: CH=' '; break; /* Trigger on floor */
      case 0x6C: CH='1'; GUARD=1; break; /* Guard */
      case 0x6D: CH='1'; GUARD=1; break; /* Guard */
      case 0x6F: CH='1'; GUARD=1; break; /* Guard */
      case 0x6E: CH='1'; GUARD=1; break; /* Guard */
      case 0x70: CH='1'; GUARD=1; break; /* Guard */
      case 0x71: CH='1'; GUARD=1; break; /* Guard */
      case 0x72: CH='1'; GUARD=1; break; /* Guard */
      case 0x73: CH='1'; GUARD=1; break; /* Guard */
      case 0x7C: CH=' '; break; /* Dead guard */
      case 0x7E: CH='1'; GUARD=2; break; /* Blue officer */
      case 0x7F: CH='1'; GUARD=2; break; /* Blue officer */
      case 0x80: CH='1'; GUARD=2; break; /* Blue officer */
      case 0x81: CH='1'; GUARD=2; break; /* Blue officer */
      case 0x83: CH='1'; GUARD=2; break; /* Blue officer */
      case 0x85: CH='1'; GUARD=2; break; /* Blue officer */
      case 0x8A: CH='1'; DOG=1; break; /* Dog */
      case 0x8B: CH='1'; DOG=1; break; /* Dog */
      case 0x8C: CH='1'; DOG=1; break; /* Dog */
      case 0x8D: CH='1'; DOG=1; break; /* Dog */
      case 0x90: CH='3'; GUARD=1; break; /* Guard */
      case 0x91: CH='3'; GUARD=1; break; /* Guard */
      case 0x92: CH='3'; GUARD=1; break; /* Guard */
      case 0x93: CH='3'; GUARD=1; break; /* Guard */
      case 0x94: CH='3'; GUARD=1; break; /* Guard */
      case 0x95: CH='3'; GUARD=1; break; /* Guard */
      case 0x96: CH='3'; GUARD=1; break; /* Guard */
      case 0x97: CH='3'; GUARD=1; break; /* Guard */
      case 0xA2: CH='3'; GUARD=2; break; /* Blue officer */
      case 0xA3: CH='3'; GUARD=2; break; /* Blue officer */
      case 0xA4: CH='3'; GUARD=2; break; /* Blue officer */
      case 0xA5: CH='3'; GUARD=2; break; /* Blue officer */
      case 0xAE: CH='3'; DOG=1; break; /* Dog */
      case 0xAF: CH='3'; DOG=1; break; /* Dog */
      case 0xB0: CH='3'; DOG=1; break; /* Dog */
      case 0xB1: CH='3'; DOG=1; break; /* Dog */
      case 0xB4: CH='4'; GUARD=1; break; /* Guard */
      case 0xB5: CH='4'; GUARD=1; break; /* Guard */
      case 0xB6: CH='4'; GUARD=1; break; /* Guard */
      case 0xB7: CH='4'; GUARD=1; break; /* Guard */
      case 0xB8: CH='4'; GUARD=1; break; /* Guard */
      case 0xB9: CH='4'; GUARD=1; break; /* Guard */
      case 0xBA: CH='4'; GUARD=1; break; /* Guard */
      case 0xBB: CH='4'; GUARD=1; break; /* Guard */
      case 0xC6: CH='4'; GUARD=2; break; /* Blue officer */
      case 0xC7: CH='4'; GUARD=2; break; /* Blue officer */
      case 0xC8: CH='4'; GUARD=2; break; /* Blue officer */
      case 0xC9: CH='4'; GUARD=2; break; /* Blue officer */
      case 0xD2: CH='4'; DOG=1; break; /* Dog */
      case 0xD3: CH='4'; DOG=1; break; /* Dog */
      case 0xD4: CH='4'; DOG=1; break; /* Dog */
      case 0xD5: CH='4'; DOG=1; break; /* Dog */
      case 0xD6: CH='x'; break; /* Hulk */
      default:   CH='@';
                 printf("\nPart 2 unknown code (%X)",X1);
    }
    if (CH==' ') CH=IN2;
    if (GUARD==1) IN='G';
    if (GUARD==2) IN='B';
    if (DOG) IN='D';
    if (IN==' ' &&  CH==175) IN=174;
    if (!fprintf(FPOUT,"%c%c",IN,CH)) {
      printf("\nERROR: writing to output file %s\n",FNAME);
      exit(2);
    }
  }
}

/*-------------------------------------------------------------------------*/

int READC(FP,NAME)
FILE *FP;
char *NAME;
{
  int CH;

  CH=fgetc(FP);
  if (feof(FP) || ferror(FP)) {
    printf("\nERROR: error reading %s\n",NAME);
    exit(2);
  }
  return(CH);
}

/*-------------------------------------------------------------------------*/

void HELP()
{
  printf("\nWMAP (v2.1) - constructs maps for Wolfenstein from Apogee");
  printf("\n");
  printf("\n");
  printf("\nCommand line:");
  printf("\n");
  printf("\n   WMAP <sw1> ... <swN> <param.1> ... <param.M>");
  printf("\n");
  printf("\nwhere  <swN> is one of the following switches:");
  printf("\n             /? = display this help message");
  printf("\n             /K = output key table"); 
  printf("\n             Note: switches may start with '/' or '-'");
  printf("\n       <param.N> is a map number in the range 1-10, or 'ALL'.");
  printf("\n");
  printf("\n");
  printf("\nNotes:");
  printf("\n   The file %s must be in the current directory.",FIN);
  printf("\n   This program writes the output to files LEVELxx.MAP");
  printf("\n");
  exit(1);
}

/*-------------------------------------------------------------------------*/
