/*

---------------------------------------------------------------------------
| WolfMap global definitions   |    (c) Oct 1992 Sysma Automatisering     |
---------------------------------------------------------------------------
| Version 1.0         06/10/92 | First implementation.                    |
|                              | J.P. Dijkstra, M.Sc.                     |
| Version 1.01        07/10/92 | Added automatic renaming of the game     |
|                              | maps file during format conversions.     |
|                              | J.P. Dijkstra, M.Sc.                     |
| Version 1.05        11/10/92 | Removed all explicit references to far   |
|                              | pointers and changed the memory model to |
|                              | large.                                   |
|                              | J.P. Dijkstra, M.Sc.                     |
| Version 1.5         12/10/92 | Added functions which enable copying and |
|                              | storing modified GameMaps inside a       |
|                              | MapGlobalRec instance.                   |
|                              | J.P. Dijkstra, M.Sc.                     |
| Version 1.6         20/10/92 | Removed the list of map headers from the |
|                              | map data, since it was only used by one  |
|                              | command and saves about 2K of memory.    |
|                              | J.P. Dijkstra, M.Sc.                     |
---------------------------------------------------------------------------
| This header file contains definitions shared among the various source   |
| files used to create WolfMap.Exe                                        |
---------------------------------------------------------------------------

*/

#include "stdio.h"

/*

---------------------------------------------------------------------------
| Global data structures and constants                                    |
---------------------------------------------------------------------------
| MapHeaderRec                | Structure to hold the essential level     |
|                             | information to enable reading and         |
|                             | decompression.                            |
|   StartMaze                 | Start of compressed maze data.            |
|   StartObjects              | Start of compressed objects data.         |
|   StartUnknown              | Start of a compressed third block. In the |
|                             | current Wolf-3D versions this block       |
|                             | appears to contain only zeros.            |
|   SizeMaze                  | The number of data bytes of the maze data |
|                             | in the file.                              |
|   SizeObjects               | Idem., but for the objects data.          |
|   SizeUnknown               | Idem., but for the unknown data.          |
|   Title                     | Array to hold a zero terminated ASCII     |
|                             | string to give the level a name.          |
---------------------------------------------------------------------------
| LegendRec                   | Structure holding one legend description  |
|                             | and representation.                       |
|   Representation            | Holds the representation of the legend.   |
|   Name                      | Holds the name of the legend.             |
---------------------------------------------------------------------------
| MapGlobalRec                | Class holding all essential global data   |
|                             | of the maphead and gamemaps files.        |
|   ErrorCode                 | Holds the last error code.                |
|   CurrentVersion            | Holds the version of the opened set of    |
|                             | map files.                                |
|   MapHeadName               | Holds the name of the active MapHead      |
|                             | file.                                     |
|   GameMapsName              | Holds the name of the active GameMaps     |
|                             | file.                                     |
|   NrMaps                    | The number of maps in the file.           |
|   NrMapsStored              | The number of maps in the store.          |
|   MagicValue                | Value preceding a word count in the       |
|                             | second level (de)compression.             |
|   MapsHandle                | Holds the file handle to the opened maps  |
|                             | file.                                     |
|   WorkMapsHandle            | Holds the file handle to the created      |
|                             | work file to write processed maps into.   |
|   Offsets                   | Pointer to a memory block holding all the |
|                             | offsets, stored in the MapHead file.      |
|   Headers                   | Pointer to a memory block holding the map |
|                             | headers of all maps, accessible by the    |
|                             | HeaderOffsets.                            |
|   MapStore                  | Pointer to an array of pointers to        |
|                             | GameMapRec classes, making up the map     |
|                             | store.                                    |
---------------------------------------------------------------------------
| GraphRec                    | Class implementing the graphical map      |
|                             | viewer / editor.                          |
|   Maze                      | Pointer to an array of LegendRec pointers |
|                             | making up the maze legend list.           |
|   Objects                   | Pointer to an array of LegendRec          |
|                             | pointers making up the objects legend.    |
|   MazeChoise                | The value selected from the maze legend.  |
|   ObjectChoise              | The value selected from the objects       |
|                             | legend.                                   |
|   MazeFirst                 | The first value of the maze legend which  |
|                             | is visible on the display.                |
|   ObjectsFirst              | The first value of the objects legend     |
|                             | which is visible on the display.          |
|   Legend                    | Determines which legend list is currently |
|                             | visible on the display.                   |
|   ChoiseLegend              | Determines from which legend the selected |
|                             | choise is on the display.                 |
|   ShowFloors                | Holds whether or not the floor values     |
|                             | should be made visible.                   |
|   ShowObjects               | Holds whether or not the object values    |
|                             | should be made visible.                   |
|   SizeX                     | Holds the horizontal size of the map      |
|                             | currently in the editor.                  |
|   SizeY                     | Holds the vertical size of the map        |
|                             | currently in the editor.                  |
|   StartTextY                | Holds a calculated internal value. Used   |
|                             | to speedup certain draw actions.          |
---------------------------------------------------------------------------
| GameMapRec                  | Class holding all data of one single map. |
|   ErrorCode                 | Holds the last error code.                |
|   CurrentFormat             | Holds the code representing the current   |
|                             | compression format of the data blocks.    |
|   Maze                      | Data block holding the maze data.         |
|   Objects                   | Data block holding the objects data.      |
|   Unknown                   | Data block holding data for a presently   |
|                             | unknown function.                         |
|   Header                    | Data block holding the map header.        |
|   ActorCount                | Holds the number of actors of each actor  |
|                             | type, except special actors.              |
|   HugeActorCount            | Holds the number of special actors.       |
|   SecretDoorCount           | Holds the number of secret doors.         |
|   DoorCount                 | Holds the number of normal doors.         |
|   LockedDoorCount           | Holds the number of locked doors.         |
|   ElevatorCount             | Holds the number of elevators.            |
|   TreasureCount             | Holds the number of treasures, including  |
|                             | the bonus life sphere.                    |
---------------------------------------------------------------------------
| MapDataRec                  | Class holding one single data block.      |
|   BlockData                 | Pointer to a data block holding the data. |
|   BlockSize                 | Holds the size of the block the BlockData |
|                             | field is pointing to.                     |
---------------------------------------------------------------------------

*/

//
//   Various general purpose constants.
//
const int cFalse        = 0;
const int cTrue         = 1;
const int cShowFloors   = cTrue;
const int cHideFloors   = cFalse;
const int cShowObjects  = cTrue;
const int cHideObjects  = cFalse;
const int cMazeLegend   = 1;
const int cObjectLegend = 2;

const unsigned cUndetermined = 0;
const unsigned cShareware    = 1;
const unsigned cComplete     = 2;
const unsigned cLocal        = 3;

const unsigned cDecompressed = 1;
const unsigned cFormat10     = 2;
const unsigned cFormat11     = 3;

const unsigned cStdout       = 0;
const unsigned cSeparate     = 1;
const unsigned cSingle       = 2;

const unsigned cOneColumn    = 0;
const unsigned cTwoColumns   = 1;
const unsigned cThreeColumns = 2;

const unsigned cMapCount         = 100;
const unsigned cMagicValue       = 0xABCD;
const unsigned cMaxMazeLegends   = 256;
const unsigned cMaxObjectLegends = 512;
const unsigned cMaxDisplayLegend = 25;

//
//   Error codes, generated by various functions.
//
const int errOk              = 0;
const int errNoMemory        = 1;
const int errMemoryCorrupted = 2;
const int errSeek            = 3;
const int errRead            = 4;
const int errWrite           = 5;
const int errLeaderTooLarge  = 6;
const int errNoSuchFile      = 7;
const int errNoMapHeadFile   = 8;
const int errNoSuchVersion   = 9;
const int errDelete          = 10;
const int errBackup          = 11;
const int errCopy            = 12;
const int errCreate          = 13;
const int errNotOpen         = 14;
const int errLocalIsTarget   = 15;
const int errMapNotPresent   = 16;
const int errNotAllocated    = 17;
const int errCreateOutput    = 18;
const int errNoDefFile       = 19;
const int errIllegalLegend   = 20;
const int errIllegalMaze     = 21;
const int errInitializeGraph = 22;

//
//   Values of various maze components.
//
const int mUndetermined = 0;     //   Unknown or illegal maze value.
const int mNothing      = 1;     //   Nothing, no maze value present.
const int mWall         = 2;     //   Wall.
const int mFloor        = 3;     //   Floor.
const int mhDoor        = 4;     //   Horizontal normal door.
const int mvDoor        = 5;     //   Vertical normal door.
const int mlbhDoor      = 6;     //   Horizontal locked door, blue key.
const int mlbvDoor      = 7;     //   Vertical locked door, blue key.
const int mlyhDoor      = 8;     //   Horizontal locked door, yellow key.
const int mlyvDoor      = 9;     //   Vertical locked door, yellow key.
const int mehDoor       = 10;    //   Horizontal elevator door.
const int mevDoor       = 11;    //   Vertical elevator door.
const int mEntrance     = 12;    //   Door marking entrance to level.
const int mElevator     = 13;    //   Wall of elevator.

//
//   Values of various maze objects.
//
const int oUndetermined = 0;     //   Unknown or illegal object.
const int oNothing      = 1;     //   Nothing, no object value present.

const int oGuard1       = 11;    //   Stationary guard, level 1.
const int oGuard3       = 12;    //   Stationary guard, level 3.
const int oGuard4       = 13;    //   Stationary guard, level 4.
const int oOfficer1     = 14;    //   Stationary officer, level 1.
const int oOfficer3     = 15;    //   Stationary officer, level 3.
const int oOfficer4     = 16;    //   Stationary officer, level 4.
const int oSS1          = 17;    //   Stationary SS officer, level 1.
const int oSS3          = 18;    //   Stationary SS officer, level 3.
const int oSS4          = 19;    //   Stationary SS officer, level 4.
const int oUndead1      = 20;    //   Stationary undead man, level 1.
const int oUndead3      = 21;    //   Stationary undead man, level 3.
const int oUndead4      = 22;    //   Stationary undead man, level 4.
const int oDog1         = 23;    //   Moving dog, level 1.
const int oDog3         = 24;    //   Moving dog, level 3.
const int oDog4         = 25;    //   Moving dog, level 4.
const int omGuard1      = 26;    //   Moving guard, level 1.
const int omGuard3      = 27;    //   Moving guard, level 3.
const int omGuard4      = 28;    //   Moving guard, level 4.
const int omOfficer1    = 29;    //   Moving officer, level 1.
const int omOfficer3    = 30;    //   Moving officer, level 3.
const int omOfficer4    = 31;    //   Moving officer, level 4.
const int omSS1         = 32;    //   Moving SS officer, level 1.
const int omSS3         = 33;    //   Moving SS officer, level 3.
const int omSS4         = 34;    //   Moving SS officer, level 4.
const int omUndead1     = 35;    //   Moving undead man, level 1.
const int omUndead3     = 36;    //   Moving undead man, level 3.
const int omUndead4     = 37;    //   Moving undead man, level 4.
const int oPacman       = 38;    //   Moving pacman ghosts.
const int oHans         = 39;    //   Hans, the huge guard from episode 1.
const int oGretel       = 40;    //   Gretel, the huge guard from episode 5.
const int oSchabbs      = 41;    //   Dr. Schabbs, from episode 2.
const int oGiftmacher   = 42;    //   Dr. Otto Giftmacher, from episode 4.
const int oFettgesicht  = 43;    //   General Fettgesicht, from episode 6.
const int oHitler       = 44;    //   Adolf Hitler himself, from episode 3.
const int oGhostHitler  = 45;    //   Ghost of Hitler, also from episode 3.
const int oDeadGuard    = 46;    //   Dead guard, any level.
const int oFirstActor   = oGuard1;
const int oLastActor    = omUndead4;

const int oSecretDoor   = 51;     //   Secret door, placed in a wall.
const int oEndgame      = 52;     //   Endgame trigger, jumping Blazkovic.
const int oTurningPoint = 53;     //   Turning point for moving actors.
const int oTreasure     = 54;     //   Treasure, including sphere.
const int oMachineGun   = 55;     //   Machine gun.
const int oGattlingGun  = 56;     //   Gattling (or big) gun.
const int oFirstAid     = 57;     //   First aid kid.
const int oFood         = 58;     //   Tray with food, or dog food.
const int oAmmunition   = 59;     //   Ammunition pack.
const int oBlueKey      = 60;     //   Blue key, for locked doors.
const int oYellowKey    = 61;     //   Yellow key, for locked doors.
const int olStart       = 62;     //   Starting position, facing left.
const int orStart       = 63;     //   Starting position, facing right.
const int ouStart       = 64;     //   Starting position, facing up.
const int odStart       = 65;     //   Starting position, facing down.
const int oObstacle     = 66;     //   Any object blocking the way.

//
//   Constants defining the different areas in the edit display.
//
const int aNone         = 0;
const int aMap          = 1;
const int aLegend       = 2;
const int aMapButton    = 3;
const int aObjectButton = 4;
const int aUpButton     = 5;
const int aDownButton   = 6;

//
//   Commands with which the ModifyMap can terminate.
//
const int cMap0        = 0;
const int cMap1        = 1;
const int cMap2        = 2;
const int cMap3        = 3;
const int cMap4        = 4;
const int cMap5        = 5;
const int cMap6        = 6;
const int cMap7        = 7;
const int cMap8        = 8;
const int cMap9        = 9;
const int cNextMap     = 10;
const int cPrevMap     = 11;
const int cDiscard     = 12;
const int cExit        = 13;
const int cNone        = 14;
const int cNextEpisode = 15;
const int cPrevEpisode = 16;
const int cEscape      = 17;
const int cBreak       = 18;
const int cStore       = 19;

extern char *cVersion;
extern char *cCopyright;

struct MapHeaderRec
{
  long     StartMaze;
  long     StartObjects;
  long     StartUnknown;
  unsigned SizeMaze;
  unsigned SizeObjects;
  unsigned SizeUnknown;
  unsigned SizeX;
  unsigned SizeY;
  char     Title [16];
};

struct LegendRec
{
  char Representation [5];
  char Name [25];
};

class MapDataRec
{
private:
  unsigned *BlockData;
  unsigned  BlockSize;

public:
  MapDataRec ();
  MapDataRec (unsigned Size);
  ~MapDataRec ();

  unsigned *Data ()     { return BlockData; }
  unsigned  DataSize () { return BlockSize; }
  int       Allocate (unsigned Size);
  int       Resize (unsigned NewSize);
  int       Free ();
  int       Copy (MapDataRec *Source);
  int       CompressFormat10 (unsigned MagicValue);
  int       CompressFormat11 ();
  int       DecompressFormat10 (unsigned MagicValue);
  int       DecompressFormat11 ();
};

class GameMapRec
{
private:
  int          ErrorCode;
  unsigned     CurrentFormat;
  MapDataRec   Maze;
  MapDataRec   Objects;
  MapDataRec   Unknown;
  MapHeaderRec Header;
  unsigned     ActorCount [ oLastActor - oFirstActor + 1 ];
  unsigned     HugeActorCount;
  unsigned     SecretDoorCount;
  unsigned     DoorCount;
  unsigned     LockedDoorCount;
  unsigned     ElevatorCount;
  unsigned     TreasureCount;

public:
  GameMapRec ();
  ~GameMapRec ();

  int       LastError ()            { return ErrorCode; }
  int       Format ()               { return CurrentFormat; }
  int       Actors (unsigned Actor) { return ActorCount [Actor - oFirstActor]; }

  int       HugeActors ()           { return HugeActorCount; }
  int       Doors ()                { return DoorCount; }
  int       LockedDoors ()          { return LockedDoorCount; }
  int       SecretDoors ()          { return SecretDoorCount; }
  int       Elevators ()            { return ElevatorCount; }
  int       Treasures ()            { return TreasureCount; }
  char     *Title ()                { return Header.Title; }
  unsigned  MazeSizeX ()            { return Header.SizeX; }
  unsigned  MazeSizeY ()            { return Header.SizeY; }
  unsigned *MazeBlock ()            { return Maze.Data (); }
  unsigned *ObjectsBlock ()         { return Objects.Data (); }
  unsigned *UnknownBlock ()         { return Unknown.Data (); }

  int       SetError (int Error);
  unsigned  SetFormat (unsigned NewFormat);
  int       DetermineFormat ();
  int       CompressFormat10 (unsigned MagicValue);
  int       CompressFormat11 ();
  int       DecompressFormat10 (unsigned MagicValue);
  int       DecompressFormat11 ();
  int       Load (int Handle, long HeaderPos);
  int       Save (int Handle, long *HeaderPos);
  int       Copy (GameMapRec *Source);
  int       Close ();
  int       Print (FILE *Stream, unsigned MapNr);
  int       PrintStatistics (FILE *Stream, unsigned MapNr);
  int       Statistics ();
  int       Clear ();
  int       Create (unsigned SizeX, unsigned SizeY, char *Title);
};

class GraphRec
{
private:
  LegendRec **Maze;
  LegendRec **Objects;
  unsigned    MazeChoise;
  unsigned    ObjectChoise;
  unsigned    MazeFirst;
  unsigned    ObjectsFirst;
  int         Legend;
  int         ChoiseLegend;
  int         ShowFloors;
  int         ShowObjects;
  unsigned    SizeX;
  unsigned    SizeY;
  int         StartTextY;

  void DisplayCell (int x, int y, unsigned MazeValue, unsigned ObjectValue);
  void DisplayMap (GameMapRec *Map);
  void DisplayMazeLegend ();
  void DisplayObjectLegend ();
  int  DetermineArea (int x, int y, int *ResultX, int *ResultY);

public:
  GraphRec ();
  ~GraphRec ();

  int Open ();
  int Close ();
  int Display (GameMapRec *Map, int EpisodeNr, int MapNr);
  int Modify (GameMapRec *Map, int *Changed, int *Command);
};

class MapGlobalRec
{
private:
  int          ErrorCode;
  unsigned     CurrentVersion;
  char         MapHeadName  [13];
  char         GameMapsName [13];
  unsigned     NrMaps;
  unsigned     NrMapsStored;
  unsigned     MagicValue;
  int          MapsHandle;
  int          WorkMapsHandle;
  long        *Offsets;
  GameMapRec **MapStore;

public:
  MapGlobalRec ();
  ~MapGlobalRec ();
  int      LastError      () { return ErrorCode; }
  unsigned MapCount       () { return NrMaps; }
  unsigned OpenedVersion  () { return CurrentVersion; }
  unsigned MapsStored     () { return NrMapsStored; }
  int      SetError       (int Error);
  int      MapPossible    (unsigned MapNr);
  int      MapAvailable   (unsigned MapNr);
  int      Open           (unsigned Version);
  int      Create         (unsigned Version);
  int      OpenWork       ();
  int      ConvertName    (unsigned NewFormat);
  int      Close          ();
  int      Load           (GameMapRec *Map, unsigned MapNr);
  int      Save           (GameMapRec *Map, unsigned MapNr);
  int      Compress       (GameMapRec *Map, unsigned NewFormat);
  int      Add            (GameMapRec *Map, unsigned MapNr);
  int      Copy           (GameMapRec *Map, unsigned MapNr);
  int      InStore        (unsigned MapNr);
  int      Delete         (unsigned MapNr);
  int      DisplayHeaders (FILE *Stream, unsigned Columns);
};

const int cOk             = 0;
const int cNoCommands     = 1;
const int cIllegalCommand = 2;
const int cError          = 3;

/*

---------------------------------------------------------------------------
| Global functions to support the implementation of the application.      |
---------------------------------------------------------------------------
| Function name               | Description.                              |
---------------------------------------------------------------------------

*/

int      ReadData (int Handle, long Pos, void *Location, unsigned Size);
int      WriteData (int Handle, long *Pos, void *Location, unsigned Size);
unsigned DetermineMaze (unsigned Value);
unsigned DetermineObject (unsigned Value);
int      PrintLegend (FILE *Stream);
