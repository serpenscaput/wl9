/*

---------------------------------------------------------------------------
| WSup module                  |    (c) Oct 1992 Sysma Automatisering     |
---------------------------------------------------------------------------
| Version 1.0         06/10/92 | First implementation.                    |
|                              | J.P. Dijkstra, M.Sc.                     |
| Version 1.05        11/10/92 | Removed all explicit references to far   |
|                              | pointers and changed the memory model to |
|                              | large.                                   |
|                              | J.P. Dijkstra, M.Sc.                     |
---------------------------------------------------------------------------
| This module contains support functions, used in the member functions of |
| the classes, containing the actual functionality of this program.       |
---------------------------------------------------------------------------

*/

#include "wolfmap.h"
#include "dos.h"
#include "io.h"
#include "fcntl.h"

/*

---------------------------------------------------------------------------
| Public functions to implement the desired API.                          |
---------------------------------------------------------------------------
| ReadData                    | Reads a block of data from the given      |
|                             | position into the specified memory block. |
| WriteData                   | Writes a block of data from the specified |
|                             | memory block to the target file and       |
|                             | returns the start position of that block  |
|                             | in the target file.                       |
| DetermineMaze               | Takes a word of maze data and determines  |
|                             | what class of maze data it belongs to.    |
| DetermineObject             | Takes a word of object data and tries to  |
|                             | determine what class of object data it    |
|                             | belongs to.                               |
| PrintLegend                 | Prints a legend of symbols used in the    |
|                             | printout of a map.                        |
---------------------------------------------------------------------------

*/

int ReadData (int Handle, long Pos, void *Location, unsigned Size)
{
  //
  //   Try positioning the file pointer at the given location.
  //
  if ( lseek (Handle, Pos, SEEK_SET) != Pos )
  {
    return errSeek;
  }

  //
  //   The seek was successful. Now try reading in the requested number of
  //   bytes from that position into the given buffer.
  //
  unsigned ReadSize = 0;
  if ( _dos_read (Handle, Location, Size, &ReadSize) == 0 && ReadSize == Size )
  {
    //
    //   The reading was successful, so return Ok.
    //
    return errOk;
  }

  //
  //   The read function failed, so return the error code.
  //
  return errRead;
}

int WriteData (int Handle, long *Pos, void *Location, unsigned Size)
{
  //
  //   Try positioning the file pointer at the given location.
  //
  *Pos = lseek (Handle, 0, SEEK_END);
  if (*Pos == -1)
  {
    *Pos = 0;
    return errSeek;
  }

  //
  //   The seek was successful. Now try reading in the requested number of
  //   bytes from that position into the given buffer.
  //
  unsigned WriteSize = 0;
  if ( _dos_write (Handle, Location, Size, &WriteSize) == 0 && WriteSize == Size 
)
  {
    //
    //   The reading was successful, so return Ok.
    //
    return errOk;
  }

  //
  //   The write function failed, so set the position of the block written
  //   to 0 and return the error code.
  //
  *Pos = 0;
  return errWrite;
}

unsigned DetermineMaze (unsigned Value)
{
  if (Value >= 0x01 && Value <= 0x14) return mWall;
  if (Value >= 0x17 && Value <= 0x31) return mWall;
  if (Value >= 0x6A && Value <= 0x8F) return mFloor;

  switch (Value)
  {
    case 0x00: return mNothing;
    case 0x0D: return mEntrance;
    case 0x15: return mElevator;
    case 0x16: return mElevator;
    case 0x5A: return mvDoor;
    case 0x5B: return mhDoor;
    case 0x5C: return mlyvDoor;
    case 0x5D: return mlyhDoor;
    case 0x5E: return mlbvDoor;
    case 0x5F: return mlbhDoor;
    case 0x64: return mevDoor;
    case 0x65: return mehDoor;
    default:   return mUndetermined;
  }
}

unsigned DetermineObject (unsigned Value)
{
  //
  //   Check for stationary actors.
  //
  if (Value >= 0x6C && Value <= 0x6F) return oGuard1;
  if (Value >= 0x90 && Value <= 0x93) return oGuard3;
  if (Value >= 0xB4 && Value <= 0xB7) return oGuard4;
  if (Value >= 0x74 && Value <= 0x77) return oOfficer1;
  if (Value >= 0x98 && Value <= 0x9B) return oOfficer3;
  if (Value >= 0xBC && Value <= 0xBF) return oOfficer4;
  if (Value >= 0x7E && Value <= 0x81) return oSS1;
  if (Value >= 0xA2 && Value <= 0xA5) return oSS3;
  if (Value >= 0xC6 && Value <= 0xC9) return oSS4;
  if (Value >= 0xD8 && Value <= 0xDB) return oUndead1;
  if (Value >= 0xEA && Value <= 0xED) return oUndead3;
  if (Value >= 0xFC && Value <= 0xFF) return oUndead4;

  //
  //   Check for moving actors.
  //
  if (Value >= 0x8A && Value <= 0x8D) return oDog1;
  if (Value >= 0xAE && Value <= 0xB1) return oDog3;
  if (Value >= 0xD2 && Value <= 0xD5) return oDog4;
  if (Value >= 0x70 && Value <= 0x73) return omGuard1;
  if (Value >= 0x94 && Value <= 0x97) return omGuard3;
  if (Value >= 0xB8 && Value <= 0xBB) return omGuard4;
  if (Value >= 0x78 && Value <= 0x7B) return omOfficer1;
  if (Value >= 0x9C && Value <= 0x9F) return omOfficer3;
  if (Value >= 0xC0 && Value <= 0xC3) return omOfficer4;
  if (Value >= 0x82 && Value <= 0x85) return omSS1;
  if (Value >= 0xA6 && Value <= 0xA9) return omSS3;
  if (Value >= 0xCA && Value <= 0xCD) return omSS4;
  if (Value >= 0xDC && Value <= 0xDF) return omUndead1;
  if (Value >= 0xEE && Value <= 0xF1) return omUndead3;
  if (Value >= 0x100 && Value <= 0x103) return omUndead4;
  if (Value >= 0xE0 && Value <= 0xE3) return oPacman;

  //
  //   Check for other objects.
  //
  if (Value >= 0x18 && Value <= 0x1A) return oObstacle;
  if (Value >= 0x1E && Value <= 0x1F) return oObstacle;
  if (Value >= 0x21 && Value <= 0x24) return oObstacle;
  if (Value >= 0x26 && Value <= 0x29) return oObstacle;
  if (Value >= 0x2D && Value <= 0x2E) return oObstacle;
  if (Value >= 0x3A && Value <= 0x3C) return oObstacle;
  if (Value >= 0x5A && Value <= 0x61) return oTurningPoint;
  if (Value >= 0x34 && Value <= 0x38) return oTreasure;

  switch (Value)
  {
    case 0x00: return oNothing;
    case 0x1C: return oObstacle;
    case 0x3E: return oObstacle;
    case 0x62: return oSecretDoor;
    case 0x63: return oEndgame;
    case 0x13: return ouStart;
    case 0x14: return orStart;
    case 0x15: return odStart;
    case 0x16: return olStart;
    case 0x7C: return oDeadGuard;
    case 0x2B: return oYellowKey;
    case 0x2C: return oBlueKey;
    case 0x32: return oMachineGun;
    case 0x33: return oGattlingGun;
    case 0x30: return oFirstAid;
    case 0x2F: return oFood;
    case 0x1D: return oFood;
    case 0x31: return oAmmunition;
    case 0xD6: return oHans;
    case 0xC4: return oSchabbs;
    case 0xA0: return oGhostHitler;
    case 0xB2: return oHitler;
    case 0xD7: return oGiftmacher;
    case 0xC5: return oGretel;
    case 0xB3: return oFettgesicht;
    default:   return oUndetermined;
  }
}

int PrintLegend (FILE *Stream)
{
  //
  //   Write a banner to the output stream.
  //
  fprintf (Stream, "WOLFENSTEIN 3D   -   Legend of the maps\n\n\n\n");

  //
  //   Write the legend for maze related objects.
  //
  fprintf (Stream, "Various maze related objects.\n\n");
  fprintf (Stream, "'%c%c' , '%c%c'   Start position, facing left or right.\n", '<', 
'-', '-', '>');
  fprintf (Stream, "'%c%c' , '%c%c'   Start position, facing up or down.\n", 0x18, 
0x18, 0x19, 0x19);
  fprintf (Stream, "'%c%c' , '%c%c'   Normal door.\n", 0xB3, ' ', 0xC4, 0xC4);
  fprintf (Stream, "'%c%c' , '%c%c'   Locked door, blue or yellow key.\n", 0xBA, 
' ', 0xCD, 0xCD);
  fprintf (Stream, "'%c%c'          Secret door.\n", '[', ']');
  fprintf (Stream, "'%c%c'          Any type of wall.\n", 0xB2, 0xB2);
  fprintf (Stream, "'%c%c'          Any type of floor.\n", ' ', ' ');
  fprintf (Stream, "'%c%c'          Entrance to level.\n", 0xAE, 0xAF);
  fprintf (Stream, "'%c%c'          Elevator.\n", 0xDB, 0xDB);
  fprintf (Stream, "'%c%c'          Trigger of the endgame.\n", '%', '%');
  fprintf (Stream, "'%c%c'          Obstacle.\n", 'o', ' ');

  //
  //   Write the legend of the takeables.
  //
  fprintf (Stream, "\nVarious objects which can be taken.\n\n");
  fprintf (Stream, "'%c%c'          Treasure, including bonus life sphere.\n", 't', 
' ');
  fprintf (Stream, "'%c%c'          First aid kid.\n", '+', ' ');
  fprintf (Stream, "'%c%c'          Food tray or dog food basket.\n", 'f', ' ');

  fprintf (Stream, "'%c%c'          Free ammunition.\n", 'a', ' ');
  fprintf (Stream, "'%c%c'          Free machine gun.\n", 'm', 'g');
  fprintf (Stream, "'%c%c'          Free gattling (or big) gun.\n", 'g', 'g');
  fprintf (Stream, "'%c%c'          Blue key to unlock doors.\n", 'b', 'k');
  fprintf (Stream, "'%c%c'          Yellow key to unlock doors.\n", 'y', 'k');

  //
  //   Write the legend of the actors.
  //
  fprintf (Stream, "\nVarious actors inside a maze.\n\n");
  fprintf (Stream, "'%c%c'          Dead guard.\n", 'D', 'G');
  fprintf (Stream, "'%c%c'          Hans, the huge guard from episode 1.\n", 'H', 
'A');
  fprintf (Stream, "'%c%c'          Doctor Schabbs, from episode 2.\n", 'D', 'S');

  fprintf (Stream, "'%c%c'          Ghost of Hitler, from episode 3.\n", 'G', 'H');

  fprintf (Stream, "'%c%c'          Hitler, from episode 3.\n", 'A', 'H');
  fprintf (Stream, "'%c%c'          Otto Giftmacher, from episode 4.\n", 'O', 'G');

  fprintf (Stream, "'%c%c'          Gretel, the huge guard from episode 5, and sister 
of Hans.\n", 'G', 'R');
  fprintf (Stream, "'%c%c'          General Fettgesicht, from episode 6.\n", 'G', 
'F');
  fprintf (Stream, "'%c%c'          Pacman ghost.\n", 'P', 'G');
  fprintf (Stream, "'%c%c'          Moving or stationary brown guard, from difficulty 
level x.\n", 'G', 'x');
  fprintf (Stream, "'%c%c'          Moving or stationary white officer, from difficulty 
level x.\n", 'O', 'x');
  fprintf (Stream, "'%c%c'          Moving or stationary blue SS officer, from difficulty 
level x.\n", 'S', 'x');
  fprintf (Stream, "'%c%c'          Moving or stationary undead man, from difficulty 
level x.\n", 'U', 'x');
  fprintf (Stream, "'%c%c'          Moving dog, from difficulty level x.\n\n\n\n", 
'D', 'x');

  //
  //   Write a copyright message as a trailer.
  //
  fprintf (Stream, "Printed with %s.\n%s\n", cVersion, cCopyright);

  //
  //   Return Ok to indicate success.
  //
  return errOk;
}

