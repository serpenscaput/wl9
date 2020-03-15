/*

---------------------------------------------------------------------------
| GameMap class                |    (c) Oct 1992 Sysma Automatisering     |
---------------------------------------------------------------------------
| Version 1.0         06/10/92 | First implementation.                    |
|                              | J.P. Dijkstra, M.Sc.                     |
| Version 1.05        11/10/92 | Removed all explicit references to far   |
|                              | pointers and changed the memory model to |
|                              | large.                                   |
|                              | J.P. Dijkstra, M.Sc.                     |
| Version 1.5         12/10/92 | Added a function which copies the entire |
|                              | contents of one GameMap to another.      |
|                              | J.P. Dijkstra, M.Sc.                     |
| Version 1.51        13/10/92 | Fixed a bug in the Create member         |
|                              | function. The Clear member function did  |
|                              | not execute after field initialization,  |
|                              | resulting in system crashes.             |
|                              | J.P. Dijkstra, M.Sc.                     |
---------------------------------------------------------------------------
| The GameMap class contains the logic to do the actual processing upon   |
| one single map. It contains the storage space for the four blocks each  |
| map consists of.                                                        |
| Routines are provided for the following services. (De)compression for   |
| the three compressed blocks for each format, loading and saving the of  |
| the four blocks, calculating statistics information, and printing of    |
| both the map and the map statistics.                                    |
---------------------------------------------------------------------------

*/

#include "wolfmap.h"
#include "stdio.h"
#include "string.h"
#include "bios.h"

/*

---------------------------------------------------------------------------
| Public functions to implement the desired API.                          |
---------------------------------------------------------------------------
| Function name               | Description.                              |
---------------------------------------------------------------------------

*/

GameMapRec::GameMapRec ()
: Maze (), Objects (), Unknown ()
{
  //
  //   Initialize the fields of this class.
  //
  ErrorCode       = errOk;
  CurrentFormat   = cUndetermined;
  HugeActorCount  = 0;
  SecretDoorCount = 0;
  LockedDoorCount = 0;
  DoorCount       = 0;
  ElevatorCount   = 0;
  TreasureCount   = 0;

  //
  //   Initialize the actor counters.
  //
  int Actor = oLastActor - oFirstActor + 1;
  while (Actor-- > 0) ActorCount [Actor] = 0;
}

GameMapRec::~GameMapRec ()
{
  Close ();
}

int GameMapRec::SetError (int Error)
{
  //
  //   Return the previous error code and set the error code to the
  //   specified one.
  //
  int OldError = ErrorCode;
  ErrorCode    = Error;
  return OldError;
}

unsigned GameMapRec::SetFormat (unsigned NewFormat)
{
  //
  //   Return the previous compression format and set the compression format
  //   to the specified one.
  //
  unsigned OldFormat = CurrentFormat;
  CurrentFormat      = NewFormat;
  return OldFormat;
}

int GameMapRec::DetermineFormat ()
{
  //
  //   First, determine this maze matrix size, in bytes.
  //
  unsigned MazeSize = (Header.SizeX * Header.SizeY) << 1;

  //
  //   If all sizes are equal to the maze matrix size, the format is
  //   uncompressed.
  //
  if (Maze.DataSize () == MazeSize && Objects.DataSize () == MazeSize && Unknown.DataSize 
() == MazeSize)
  {
    CurrentFormat = cDecompressed;
    return errOk;
  }

  //
  //   The format was not uncompressed. Now determine the maze size for one
  //   level of decompression. Currently, this size is stored in the first
  //   word of the memory block. If this size equals the maze matrix size,
  //   the compression format is v1.0 format, otherwise the format is assumed
  //   to be v1.1 format.
  //
  unsigned MazeFormat    = *Maze.Data ()    == MazeSize ? cFormat10 : cFormat11;

  unsigned ObjectsFormat = *Objects.Data () == MazeSize ? cFormat10 : cFormat11;

  unsigned UnknownFormat = *Unknown.Data () == MazeSize ? cFormat10 : cFormat11;


  //
  //   One last check. If the formats for the three memory blocks do not
  //   agree to the same format, v1.1 format is assumed.
  //   Note, however, that this probably indicates an error.
  //
  CurrentFormat = MazeFormat == ObjectsFormat && MazeFormat == UnknownFormat ? MazeFormat 
: cFormat11;

  return errOk;
}

int GameMapRec::CompressFormat10 (unsigned MagicValue)
{
  //
  //   Compress the three data blocks to the v1.0 format.
  //
  int                 Error = Maze.CompressFormat10    (MagicValue);
  if (Error == errOk) Error = Objects.CompressFormat10 (MagicValue);
  if (Error == errOk) Error = Unknown.CompressFormat10 (MagicValue);

  //
  //   Return the result of this function.
  //
  if (Error != errOk) SetError (Error);

  return Error;
}

int GameMapRec::CompressFormat11 ()
{
  //
  //   Compress the three data blocks to the v1.1 format.
  //
  int                 Error = Maze.CompressFormat11    ();
  if (Error == errOk) Error = Objects.CompressFormat11 ();
  if (Error == errOk) Error = Unknown.CompressFormat11 ();

  //
  //   Return the result of this function.
  //
  if (Error != errOk) SetError (Error);

  return Error;
}

int GameMapRec::DecompressFormat10 (unsigned MagicValue)
{
  //
  //   Decompress the three data blocks from the v1.0 format.
  //
  int                 Error = Maze.DecompressFormat10    (MagicValue);
  if (Error == errOk) Error = Objects.DecompressFormat10 (MagicValue);
  if (Error == errOk) Error = Unknown.DecompressFormat10 (MagicValue);

  //
  //   Return the result of this function.
  //
  if (Error != errOk) SetError (Error);

  return Error;
}

int GameMapRec::DecompressFormat11 ()
{
  //
  //   Decompress the three data blocks from the v1.1 format.
  //
  int                 Error = Maze.DecompressFormat11    ();
  if (Error == errOk) Error = Objects.DecompressFormat11 ();
  if (Error == errOk) Error = Unknown.DecompressFormat11 ();

  //
  //   Return the result of this function.
  //
  if (Error != errOk) SetError (Error);

  return Error;
}

int GameMapRec::Load (int Handle, long HeaderPos)
{
  //
  //   First, read the map header into memory.
  //
  int Error = ReadData (Handle, HeaderPos, &Header, sizeof (MapHeaderRec) );

  //
  //   Now allocate enough memory to hold the three data blocks.
  //
  if (Error == errOk) Error = Maze.Allocate (Header.SizeMaze);
  if (Error == errOk) Error = Objects.Allocate (Header.SizeObjects);
  if (Error == errOk) Error = Unknown.Allocate (Header.SizeUnknown);

  //
  //   Now read the three data blocks into the allocated memory.
  //
  if (Error == errOk) Error = ReadData (Handle, Header.StartMaze, Maze.Data (), Header.SizeMaze);

  if (Error == errOk) Error = ReadData (Handle, Header.StartObjects, Objects.Data 
(), Header.SizeObjects);
  if (Error == errOk) Error = ReadData (Handle, Header.StartUnknown, Unknown.Data 
(), Header.SizeUnknown);

  //
  //   Finally, process the error if one occured and return the result.
  //
  if (Error != errOk) SetError (Error);

  return Error;
}

int GameMapRec::Save (int Handle, long *HeaderPos)
{
  //
  //   First, set the data block sizes in the header structure to the correct
  //   values.
  //
  int Error = errOk;

  Header.SizeMaze    = Maze.DataSize ();
  Header.SizeObjects = Objects.DataSize ();
  Header.SizeUnknown = Unknown.DataSize ();

  //
  //   Now write the three data blocks from the allocated memory to the file.
  //   The header will be adjusted to reflect the correct starting positions
  //   for each of the three data blocks.
  //
  if (Error == errOk) Error = WriteData (Handle, &Header.StartMaze, Maze.Data (), 
Header.SizeMaze);
  if (Error == errOk) Error = WriteData (Handle, &Header.StartObjects, Objects.Data 
(), Header.SizeObjects);
  if (Error == errOk) Error = WriteData (Handle, &Header.StartUnknown, Unknown.Data 
(), Header.SizeUnknown);

  //
  //   Now write the map header to the file.
  //
  Error = WriteData (Handle, HeaderPos, &Header, sizeof (MapHeaderRec) );

  //
  //   Finally, process the error if one occured and return the result.
  //
  if (Error != errOk) SetError (Error);
  return Error;
}

int GameMapRec::Copy (GameMapRec *Source)
{
  int Error = errOk;

  //
  //   Only copy when the source is allocated.
  //
  if (Source->Maze.Data () != NULL && Source->Objects.Data () != NULL && Source->Unknown.Data 
() != NULL)
  {
    //
    //   First copy the three data blocks.
    //
    if (Error == errOk) Error = Maze.Copy (&Source->Maze);
    if (Error == errOk) Error = Objects.Copy (&Source->Objects);
    if (Error == errOk) Error = Unknown.Copy (&Source->Unknown);

    //
    //   Now copy the private fields.
    //
    if (Error == errOk)
    {
      CurrentFormat   = Source->CurrentFormat;
      HugeActorCount  = Source->HugeActorCount;
      SecretDoorCount = Source->SecretDoorCount;
      LockedDoorCount = Source->LockedDoorCount;
      DoorCount       = Source->DoorCount;
      ElevatorCount   = Source->ElevatorCount;
      TreasureCount   = Source->TreasureCount;
      Header          = Source->Header;

      int Actor = oLastActor - oFirstActor + 1;
      while (Actor-- > 0) ActorCount [Actor] = Source->ActorCount [Actor];
    }
  }

  //
  //   Finally, process the error if one occured and return the result.
  //
  if (Error != errOk) SetError (Error);
  return Error;
}

int GameMapRec::Close ()
{
  //
  //   Free the memory blocks and reinitialize the private fields.
  //
  Maze.Free ();
  Objects.Free ();
  Unknown.Free ();

  CurrentFormat   = cUndetermined;
  HugeActorCount  = 0;
  SecretDoorCount = 0;
  LockedDoorCount = 0;
  DoorCount       = 0;
  ElevatorCount   = 0;
  TreasureCount   = 0;

  //
  //   Reinitialize the actor counters.
  //
  int Actor = oLastActor - oFirstActor + 1;
  while (Actor-- > 0) ActorCount [Actor] = 0;

  //
  //   Return Ok to indicate success.
  //
  return errOk;
}

int GameMapRec::Print (FILE *Stream, unsigned MapNr)
{
  //
  //   Print a banner on the output stream.
  //
  fprintf (Stream, "WOLFENSTEIN 3D   -   Map #%u: %s\n\n", MapNr, Header.Title);


  //
  //   Initialize the line counter and the pointers in the source data.
  //
  unsigned *MazeValue   = Maze.Data ();
  unsigned *ObjectValue = Objects.Data ();
  unsigned  PosY        = Header.SizeY;

  //
  //   Process the maze, one line at a time.
  //
  while (PosY-- > 0)
  {
    //
    //   Initialize the output line.
    //
    char Buffer [256];
    char *Str     = Buffer;
    unsigned PosX = Header.SizeX;

    //
    //   Fill the output line, one maze cell at a time.
    //
    while (PosX-- > 0)
    {
      char First;
      char Second;

      //
      //   First figure out what maze cell we have.
      //
      switch ( DetermineMaze (*MazeValue) )
      {
        case mEntrance: First = 0xAE; Second = 0xAF; break;
        case mElevator: First = 0xDB; Second = 0xDB; break;
        case mvDoor:    First = 0xB3; Second = ' ';  break;
        case mhDoor:    First = 0xC4; Second = 0xC4; break;
        case mlyvDoor:  First = 0xBA; Second = ' ';  break;
        case mlyhDoor:  First = 0xCD; Second = 0xCD; break;
        case mlbvDoor:  First = 0xBA; Second = ' ';  break;
        case mlbhDoor:  First = 0xCD; Second = 0xCD; break;
        case mevDoor:   First = 0xC6; Second = 0xB5; break;
        case mehDoor:   First = 0xC6; Second = 0xB5; break;
        case mFloor:    First = ' ';  Second = ' ';  break;
        case mWall:     First = 0xB2; Second = 0xB2; break;
        default:        First = '*';  Second = '*';  break;
      }

      //
      //   Now figure out what object is standing in the maze cell. If it
      //   is an importand object, we superimpose it over the maze
      //   characters.
      //
      switch ( DetermineObject (*ObjectValue) )
      {
        case ouStart:      First = 0x18; Second = 0x18; break;
        case orStart:      First = '-';  Second = '>';  break;
        case odStart:      First = 0x19; Second = 0x19; break;
        case olStart:      First = '<';  Second = '-';  break;
        case oSecretDoor:  First = '[';  Second = ']';  break;
        case oEndgame:     First = '%';  Second = '%';  break;
        case oMachineGun:  First = 'm';  Second = 'g';  break;
        case oGattlingGun: First = 'g';  Second = 'g';  break;
        case oAmmunition:  First = 'a';  Second = ' ';  break;
        case oFood:        First = 'f';  Second = ' ';  break;
        case oFirstAid:    First = '+';  Second = ' ';  break;
        case oTreasure:    First = 't';  Second = ' ';  break;
        case oBlueKey:     First = 'b';  Second = 'k';  break;
        case oYellowKey:   First = 'y';  Second = 'k';  break;
        case oObstacle:    First = 'o';  Second = ' ';  break;
        case oDeadGuard:   First = 'D';  Second = 'G';  break;
        case oHans:        First = 'H';  Second = 'A';  break;
        case oSchabbs:     First = 'D';  Second = 'S';  break;
        case oGhostHitler: First = 'G';  Second = 'A';  break;
        case oHitler:      First = 'A';  Second = 'H';  break;
        case oGiftmacher:  First = 'O';  Second = 'G';  break;
        case oGretel:      First = 'G';  Second = 'R';  break;
        case oFettgesicht: First = 'G';  Second = 'F';  break;
        case oGuard1:      First = 'G';  Second = '1';  break;
        case oGuard3:      First = 'G';  Second = '3';  break;
        case oGuard4:      First = 'G';  Second = '4';  break;
        case oOfficer1:    First = 'O';  Second = '1';  break;
        case oOfficer3:    First = 'O';  Second = '3';  break;
        case oOfficer4:    First = 'O';  Second = '4';  break;
        case oSS1:         First = 'S';  Second = '1';  break;
        case oSS3:         First = 'S';  Second = '3';  break;
        case oSS4:         First = 'S';  Second = '4';  break;
        case oUndead1:     First = 'U';  Second = '1';  break;
        case oUndead3:     First = 'U';  Second = '3';  break;
        case oUndead4:     First = 'U';  Second = '4';  break;
        case oDog1:        First = 'D';  Second = '1';  break;
        case oDog3:        First = 'D';  Second = '3';  break;
        case oDog4:        First = 'D';  Second = '4';  break;
        case omGuard1:     First = 'G';  Second = '1';  break;
        case omGuard3:     First = 'G';  Second = '3';  break;
        case omGuard4:     First = 'G';  Second = '4';  break;
        case omOfficer1:   First = 'O';  Second = '1';  break;
        case omOfficer3:   First = 'O';  Second = '3';  break;
        case omOfficer4:   First = 'O';  Second = '4';  break;
        case omSS1:        First = 'S';  Second = '1';  break;
        case omSS3:        First = 'S';  Second = '3';  break;
        case omSS4:        First = 'S';  Second = '4';  break;
        case omUndead1:    First = 'U';  Second = '1';  break;
        case omUndead3:    First = 'U';  Second = '3';  break;
        case omUndead4:    First = 'U';  Second = '4';  break;
        case oPacman:      First = 'P';  Second = 'G';  break;
      }

      //
      //   Add the converted cell code to the buffer and advance the
      //   pointers.
      //
      *(Str++) = First;
      *(Str++) = Second;
      MazeValue++;
      ObjectValue++;
    }

    //
    //   Append the terminator to the line and output the filled line to
    //   the output stream.
    //
    *Str = '\0';
    fprintf (Stream, "%s\n", Buffer);
  }

  //
  //   The maze has been printed without any errors, so return Ok.
  //
  return errOk;
}

int GameMapRec::PrintStatistics (FILE *Stream, unsigned MapNr)
{
  //
  //   Print a banner on the output stream.
  //
  fprintf (Stream, "WOLFENSTEIN 3D   -   Statistics of map #%u: %s\n\n", MapNr, Header.Title);


  //
  //   Print maze statistics.
  //
  fprintf (Stream, "Maze Size:           [%d,%d]\n", Header.SizeX, Header.SizeY);

  fprintf (Stream, "Doors:               %d\n", Doors () );
  fprintf (Stream, "Locked Doors:        %d\n", LockedDoors () );
  fprintf (Stream, "Secret Doors:        %d\n", SecretDoors () );
  fprintf (Stream, "Elevators:           %d\n", Elevators () );
  fprintf (Stream, "Treasures:           %d\n", Treasures () );
  fprintf (Stream, "Huge Guards:         %d\n\n", HugeActors () + Actors (oPacman) 
);

  //
  //   Print the totals for stationary normal actors.
  //
  fprintf (Stream, "Statianory Actor     Level 1     Level 3     Level 4     Total 
3     Total 4\n");
  fprintf (Stream, "================     =======     =======     =======     ======= 
    =======\n");
  fprintf (Stream, "Brown Guard             %4u        %4u        %4u        %4u 
       %4u\n",
           Actors (oGuard1), Actors (oGuard3), Actors (oGuard4),
           Actors (oGuard1) + Actors (oGuard3),
           Actors (oGuard1) + Actors (oGuard3) + Actors (oGuard4)
          );
  fprintf (Stream, "White Officer           %4u        %4u        %4u        %4u 
       %4u\n",
           Actors (oOfficer1), Actors (oOfficer3), Actors (oOfficer4),
           Actors (oOfficer1) + Actors (oOfficer3),
           Actors (oOfficer1) + Actors (oOfficer3) + Actors (oOfficer4)
          );
  fprintf (Stream, "Blue SS Officer         %4u        %4u        %4u        %4u 
       %4u\n",
           Actors (oSS1), Actors (oSS3), Actors (oSS4),
           Actors (oSS1) + Actors (oSS3),
           Actors (oSS1) + Actors (oSS3) + Actors (oSS4)
          );
  fprintf (Stream, "Undead                  %4u        %4u        %4u        %4u 
       %4u\n\n",
           Actors (oUndead1), Actors (oUndead3), Actors (oUndead4),
           Actors (oUndead1) + Actors (oUndead3),
           Actors (oUndead1) + Actors (oUndead3) + Actors (oUndead4)
          );

  //
  //   Print the totals for moving actors.
  //
  fprintf (Stream, "Moving Actor         Level 1     Level 3     Level 4     Total 
3     Total 4\n");
  fprintf (Stream, "================     =======     =======     =======     ======= 
    =======\n");
  fprintf (Stream, "Brown Guard             %4u        %4u        %4u        %4u 
       %4u\n",
           Actors (omGuard1), Actors (omGuard3), Actors (omGuard4),
           Actors (omGuard1) + Actors (omGuard3),
           Actors (omGuard1) + Actors (omGuard3) + Actors (omGuard4)
          );
  fprintf (Stream, "White Officer           %4u        %4u        %4u        %4u 
       %4u\n",
           Actors (omOfficer1), Actors (omOfficer3), Actors (omOfficer4),
           Actors (omOfficer1) + Actors (omOfficer3),
           Actors (omOfficer1) + Actors (omOfficer3) + Actors (omOfficer4)
          );
  fprintf (Stream, "Blue SS Officer         %4u        %4u        %4u        %4u 
       %4u\n",
           Actors (omSS1), Actors (omSS3), Actors (omSS4),
           Actors (omSS1) + Actors (omSS3),
           Actors (omSS1) + Actors (omSS3) + Actors (omSS4)
          );
  fprintf (Stream, "Undead                  %4u        %4u        %4u        %4u 
       %4u\n",
           Actors (omUndead1), Actors (omUndead3), Actors (omUndead4),
           Actors (omUndead1) + Actors (omUndead3),
           Actors (omUndead1) + Actors (omUndead3) + Actors (omUndead4)
          );
  fprintf (Stream, "Dog                     %4u        %4u        %4u        %4u 
       %4u\n",
           Actors (oDog1), Actors (oDog3), Actors (oDog4),
           Actors (oDog1) + Actors (oDog3),
           Actors (oDog1) + Actors (oDog3) + Actors (oDog4)
          );

  //
  //   Return Ok to indicate success.
  //
  return errOk;
}

int GameMapRec::Statistics ()
{
  //
  //   Initialize the line counter and the pointers in the source data.
  //
  unsigned *MazeValue   = Maze.Data ();
  unsigned *ObjectValue = Objects.Data ();
  unsigned  PosY        = Header.SizeY;

  //
  //   Process the maze, one line at a time.
  //
  while (PosY-- > 0)
  {
    unsigned PosX = Header.SizeX;

    //
    //   Process the current maze row, one maze cell at a time.
    //
    while (PosX-- > 0)
    {
      //
      //   First count the doors. They can all be found in the maze data,
      //   except for the secret doors.
      //
      switch ( DetermineMaze (*MazeValue) )
      {
        case mvDoor:   DoorCount++;       break;
        case mhDoor:   DoorCount++;       break;
        case mlyvDoor: LockedDoorCount++; break;
        case mlyhDoor: LockedDoorCount++; break;
        case mlbvDoor: LockedDoorCount++; break;
        case mlbhDoor: LockedDoorCount++; break;
        case mevDoor:  ElevatorCount++;   break;
        case mehDoor:  ElevatorCount++;   break;
      }

      //
      //   Now count the actors, treasures and secret doors.
      //
      switch ( DetermineObject (*ObjectValue) )
      {
        case oSecretDoor:  SecretDoorCount++; break;
        case oTreasure:    TreasureCount++;   break;
        case oHans:        HugeActorCount++;  break;
        case oSchabbs:     HugeActorCount++;  break;
        case oGhostHitler: HugeActorCount++;  break;
        case oHitler:      HugeActorCount++;  break;
        case oGiftmacher:  HugeActorCount++;  break;
        case oGretel:      HugeActorCount++;  break;
        case oFettgesicht: HugeActorCount++;  break;
        default:
          int Actor = DetermineObject (*ObjectValue);
          if (Actor >= oFirstActor && Actor <= oLastActor)
          {
            ActorCount [Actor - oFirstActor]++;
          }
      }

      //
      //   The current cell has been processed, so advance to the next one.
      //   pointers.
      //
      MazeValue++;
      ObjectValue++;
    }
  }

  //
  //   The maze has been processed without any errors, so return Ok.
  //
  return errOk;
}

int GameMapRec::Clear ()
{
  //
  //   Initialize the pointers.
  //
  unsigned *MazePtr    = Maze.Data ();
  unsigned *ObjectPtr  = Objects.Data ();
  unsigned *UnknownPtr = Unknown.Data ();
  unsigned  PosY       = 0;

  //
  //   Walk the entire maze, one row at a time.
  //
  while (PosY < Header.SizeY)
  {
    //
    //   Walk every cell in a row, one cell at a time.
    //
    unsigned PosX = 0;

    while (PosX < Header.SizeX)
    {
      //
      //   Erase the object.
      //
      *ObjectPtr  = 0x0000;
      *UnknownPtr = 0x0000;

      //
      //   Set the maze to grey brick if the cell is on the border of the
      //   maze. Otherwise, set the cell to be a floor.
      //
      if (PosX == 0 || PosX == Header.SizeX-1)
      {
        *MazePtr = 0x0001;
      }
      else
      {
        if (PosY == 0 || PosY == Header.SizeY-1)
        {
          *MazePtr = 0x0001;
        }
        else
        {
          *MazePtr = 0x006B;
        }
      }

      //
      //   Advance to the next cell.
      //
      PosX++;
      MazePtr++;
      ObjectPtr++;
      UnknownPtr++;
    }

    //
    //   Advance to the next row.
    //
    PosY++;
  }

  //
  //   Return Ok to indicate success.
  //
  return errOk;
}

int GameMapRec::Create (unsigned SizeX, unsigned SizeY, char *Title)
{
  //
  //   Check the specified sizes and calculate the memory block size.
  //
  int      Error   = SizeX == 0 || SizeX > 64 || SizeY == 0 || SizeY > 64 ? errIllegalMaze 
: errOk;
  unsigned MemSize = (SizeX * SizeY) << 1;

  //
  //   Allocate the three data blocks.
  //
  if (Error == errOk) Error = Maze.Allocate (MemSize);
  if (Error == errOk) Error = Objects.Allocate (MemSize);
  if (Error == errOk) Error = Unknown.Allocate (MemSize);

  //
  //   If allocation and initialization is successfull, set the header to
  //   reflect the map specifications. Then initialize the map.
  //
  if (Error == errOk)
  {
    strncpy (Header.Title, Title, 16);
    Header.Title [15] = '\0';
    Header.SizeX      = SizeX;
    Header.SizeY      = SizeY;
    CurrentFormat     = cDecompressed;

    Error = Clear ();
  }

  //
  //   Process an error and return the error state.
  //
  if (Error != errOk) SetError (Error);
  return Error;
}

