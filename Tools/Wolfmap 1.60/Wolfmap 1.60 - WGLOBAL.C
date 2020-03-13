/*

---------------------------------------------------------------------------
| MapGlobal class              |    (c) Oct 1992 Sysma Automatisering     |
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
| The MapGlobal class contains the logic to process the map files as a    |
| single unit. In those files the actual maps are stored. A map consists  |
| of four separate data blocks. Each block is stored in the maps file     |
| separately. The header block contains the sizes and start offsets of    |
| the other three blocks, together with some descriptive information      |
| about the map itself. The size of the header is fixed and it's start    |
| offset is stored in the map head file.                                  |
| The other three blocks contain compressed data. The first block         |
| contains the maze data, the second one the objects inside the maze. The |
| function of the third block is unknown at present and contains at the   |
| moment only zeros for all maps.                                         |
| As stated, the start offsets of all map headers is stored in the map    |
| head file. The format is an array of long ints, preseded by a word      |
| containing the so called magic value, used in the (de)compression       |
| algorithms of the version 1.0 format.                                   |
| The logic in this class consists of routines to open, create and close  |
| the map files, and to load, save and (de)compress single maps.          |
---------------------------------------------------------------------------

*/

#include "wolfmap.h"
#include "dos.h"
#include "io.h"
#include "fcntl.h"
#include "alloc.h"
#include "string.h"
#include "errno.h"

/*

---------------------------------------------------------------------------
| Local data structures and constants                                     |
---------------------------------------------------------------------------
| Struct / Class name         | Description.                              |
|   Field name                | Description.                              |
---------------------------------------------------------------------------
| Struct / Class name         | Description.                              |
|   Field name                | Description.                              |
---------------------------------------------------------------------------

*/

#define WorkGameMaps   "GameMaps.Wrk"
#define WorkMapHead    "MapHead.Wrk"
#define BackupGameMaps "GameMaps.Bak"
#define BackupMapHead  "MapHead.Bak"
#define lGameMaps      "GameMaps.Loc"
#define lMapHead       "MapHead.Loc"
#define c11GameMaps    "GameMaps.Wl6"
#define c10GameMaps    "MapTemp.Wl6"
#define cMapHead       "MapHead.Wl6"
#define s11GameMaps    "GameMaps.Wl1"
#define s10GameMaps    "MapTemp.Wl1"
#define sMapHead       "MapHead.Wl1"

static unsigned long Id        = 0x21444921;
const  unsigned      IdSize    = 4;

/*

---------------------------------------------------------------------------
| Local functions to implement elementary operations.                     |
---------------------------------------------------------------------------
| CopyWorkFiles               | This function takes care of copying the   |
|                             | origional files to the backup files, the  |
|                             | work files to the origional files and to  |
|                             | delete the work files upon success.       |
---------------------------------------------------------------------------

*/

static int CopyWorkFiles (char *GameMapsName, char *MapHeadName)
{
  //
  //   Try to delete the backups of the origional files, because they may
  //   have been left over from a previous session.
  //
  if ( unlink (BackupGameMaps) == -1 && errno != ENOENT)
  {
    return errDelete;
  }

  if ( unlink (BackupMapHead) == -1 && errno != ENOENT)
  {
    return errDelete;
  }

  //
  //   The backup files have been deleted. Now rename the origionals to
  //   their backup names.
  //
  if ( rename (GameMapsName, BackupGameMaps) == -1 && errno != ENOENT )
  {
    return errBackup;
  }

  if ( rename (MapHeadName, BackupMapHead) == -1 && errno != ENOENT )
  {
    //
    //   Renaming of the MapHead file failed, so reverse the renaming of
    //   the GameMaps file.
    //
    rename (BackupGameMaps, GameMapsName);
    return errBackup;
  }

  //
  //   The origional files have been renamed to their respective backup
  //   names, so now rename the temp files to the origional names.
  //
  if ( rename (WorkGameMaps, GameMapsName) == -1 )
  {
    //
    //   Renaming the GameMaps file failed, so we rename the backup files
    //   back to their respective origional names. We don't test for
    //   success or failure here, since these files have already been
    //   successfully renamed once.
    //
    rename (BackupGameMaps, GameMapsName);
    rename (BackupMapHead, MapHeadName);
    return errCopy;
  }

  if ( rename (WorkMapHead, MapHeadName) == -1 )
  {
    //
    //   Renaming of the MapHead file failed, so we rename the backup
    //   files back to their respective origional names. We don't test
    //   for success or failure, since these files have already been
    //   renamed once.
    //
    rename (GameMapsName, WorkGameMaps);
    rename (BackupGameMaps, GameMapsName);
    rename (BackupMapHead, MapHeadName);
    return errCopy;
  }

  //
  //   All files have been renamed successfully, so we now have a set of
  //   backup files, a new set of origionals and no temp files left.
  //
  return errOk;
}

/*

---------------------------------------------------------------------------
| Public functions to implement the desired API.                          |
---------------------------------------------------------------------------
| Function name               | Description.                              |
---------------------------------------------------------------------------

*/

MapGlobalRec::MapGlobalRec ()
{
  //
  //   Initialize all fields with default values.
  //
  NrMaps         = 0;
  NrMapsStored   = 0;
  Offsets        = NULL;
  MapStore       = NULL;
  MagicValue     = 0x0000;
  MapsHandle     = -1;
  WorkMapsHandle = -1;
  ErrorCode      = errOk;
  CurrentVersion = cUndetermined;
}

MapGlobalRec::~MapGlobalRec ()
{
  //
  //   Use the Close () function to shutdown this instance.
  //
  Close ();
}

int MapGlobalRec::SetError (int Error)
{
  int OldError = ErrorCode;
  ErrorCode    = Error;
  return OldError;
}

int MapGlobalRec::MapPossible (unsigned MapNr)
{
  //
  //   Determine if the given map slot is possible to load or save from.
  //
  return MapNr < NrMaps && Offsets != NULL ? cTrue : cFalse;
}

int MapGlobalRec::MapAvailable (unsigned MapNr)
{
  //
  //   Determine if the given map slot is in fact available in the maps file.
  //
  return MapPossible (MapNr) && Offsets [MapNr] != 0 ? cTrue : cFalse;
}

int MapGlobalRec::Open (unsigned Version)
{
  int Handle = -1;

  //
  //   If the version is not determined yet, try the complete version first.
  //
  if (Version == cUndetermined)
  {
    //
    //   Set version and file names.
    //
    CurrentVersion = cComplete;
    strcpy (MapHeadName,  cMapHead);
    strcpy (GameMapsName, c11GameMaps);

    //
    //   Try opening the two files.
    //
    Handle     = _open (MapHeadName,  O_RDONLY);
    MapsHandle = _open (GameMapsName, O_RDONLY);

    //
    //   Continue processing if the two files are opened.
    //
    if (Handle != -1 && MapsHandle != -1) goto FilesOpened;
    if (Handle != -1)
    {
      //
      //   The map head file is open, so try the second possible name for
      //   the game maps file.
      //
      strcpy (GameMapsName, c10GameMaps);
      MapsHandle = _open (GameMapsName, O_RDONLY);

      //
      //   This time successfull, so continue processing.
      //
      if (MapsHandle != -1) goto FilesOpened;

      close (Handle);
    }

    //
    //   The complete version could not be opened, so try the shareware
    //   version now.
    //
    Version = cShareware;
  }

  //
  //   Set the correct file names for the requested version.
  //
  switch (Version)
  {
    case cComplete:
      strcpy (MapHeadName,  cMapHead);
      strcpy (GameMapsName, c11GameMaps);
      break;
    case cShareware:
      strcpy (MapHeadName,  sMapHead);
      strcpy (GameMapsName, s11GameMaps);
      break;
    case cLocal:
      strcpy (MapHeadName,  lMapHead);
      strcpy (GameMapsName, lGameMaps);
      break;
    default:
      SetError (errNoSuchVersion);
      return errNoSuchVersion;
  }

  //
  //   Set the version and try opening the two files.
  //
  CurrentVersion = Version;
  Handle         = _open (MapHeadName,  O_RDONLY);
  MapsHandle     = _open (GameMapsName, O_RDONLY);

  //
  //   Continue processing if the two files are opened.
  //
  if (Handle != -1 && MapsHandle != -1) goto FilesOpened;
  if (Handle != -1)
  {
    //
    //   The map head file is open, so try the second possible name for the
    //   game maps file.
    //
    switch (Version)
    {
      case cComplete:  strcpy (GameMapsName, c10GameMaps); break;
      case cShareware: strcpy (GameMapsName, s10GameMaps); break;
    }
    MapsHandle = _open (GameMapsName, O_RDONLY);

    //
    //   This time successfull, so continue processing.
    //
    if (MapsHandle != -1) goto FilesOpened;

    close (Handle);
  }

  //
  //   The requested version is not available, so return an error.
  //
  SetError (errNoSuchVersion);
  return errNoSuchVersion;

FilesOpened:
  //
  //   From this point on the map head file and the game maps file are both
  //   opened for reading. Now first determine the size of the map head file,
  //   as this determines the max. number of maps stored.
  //
  long Size  = lseek (Handle, 0, SEEK_END);
  int  Error = errOk;

  //
  //   Allocate memory, but only if the map head file checks out ok.
  //
  if ( ((Size-2) & 0x0003) == 0)
  {
    NrMaps   = (Size - 2) >> 2;
    Offsets  = (long *)        calloc (NrMaps, sizeof (long) );
    MapStore = (GameMapRec **) calloc (NrMaps, sizeof (GameMapRec *) );

    if (Offsets == NULL || MapStore == NULL)
    {
      Error = errNoMemory;
    }
  }
  else
  {
    Error = errNoMapHeadFile;
  }

  //
  //   Read the magic value and the start positions of every map header from
  //   the map head file.
  //
  if (Error == errOk) Error = ReadData (Handle, 0, &MagicValue, 2);
  if (Error == errOk) Error = ReadData (Handle, 2, Offsets, NrMaps * sizeof (long) 
);

  //
  //   Close the map head file and return the error status.
  //
  close (Handle);
  if (Error != errOk) SetError (Error);
  return Error;
}

int MapGlobalRec::Create (unsigned Version)
{
  int Error = errOk;

  //
  //   Set the correct file names for the two files to reflect the chosen
  //   version.
  //
  switch (Version)
  {
    case cComplete:
      strcpy (MapHeadName,  cMapHead);
      strcpy (GameMapsName, c11GameMaps);
      break;
    case cShareware:
      strcpy (MapHeadName,  sMapHead);
      strcpy (GameMapsName, s11GameMaps);
      break;
    case cLocal:
      strcpy (MapHeadName,  lMapHead);
      strcpy (GameMapsName, lGameMaps);
      break;
    default:
      Error = errNoSuchVersion;
      break;
  }

  if (Error == errOk)
  {
    //
    //   Set the created version and try creating the game maps work file.
    //
    CurrentVersion = Version;
    WorkMapsHandle = _creat (WorkGameMaps, 0);

    //
    //   If the work file is created, create the memory blocks and write a
    //   leader of our own to this work file.
    //
    if (WorkMapsHandle != -1)
    {
      NrMaps     = cMapCount;
      MagicValue = cMagicValue;
      Offsets    = (long *)        calloc (NrMaps, sizeof (long) );
      MapStore   = (GameMapRec **) calloc (NrMaps, sizeof (GameMapRec *) );

      if (Offsets != NULL && MapStore != NULL)
      {
        //
        //   The memory blocks are allocated. Now write our own leader.
        //
        long Pos;
        char Signature [256];

        sprintf (Signature, "Maps created with %s\r\n%s\r\n\X1A", cVersion, cCopyright);

        Error = WriteData (WorkMapsHandle, &Pos, Signature, strlen (Signature) + 
1);
      }
      else
      {
        Error = errNoMemory;
      }
    }
    else
    {
      Error = errCreate;
    }
  }

  //
  //   If an error occured, process it. Then return the error status.
  //
  if (Error != errOk) SetError (Error);
  return Error;
}

int MapGlobalRec::OpenWork ()
{
  //
  //   Try creating the maps work file.
  //
  WorkMapsHandle = _creat (WorkGameMaps, 0);

  //
  //   If the work file is created, copy the leader of the origional file to
  //   this work file.
  //
  int   Error = WorkMapsHandle == -1 ? errCreate : errOk;
  long *Pos   = Offsets;
  int   Count = MapCount ();
  long  Size  = 0x7FFFFFFF;

  while (Error == errOk && Count-- > 0)
  {
    //
    //   Only track maps that are actually present.
    //
    if (*Pos != 0)
    {
      MapHeaderRec Hdr;

      Error = ReadData (MapsHandle, *Pos, &Hdr, sizeof (MapHeaderRec) );

      if (Error == errOk)
      {
        if (Size > Hdr.StartMaze)    Size = Hdr.StartMaze;
        if (Size > Hdr.StartObjects) Size = Hdr.StartObjects;
        if (Size > Hdr.StartUnknown) Size = Hdr.StartUnknown;
        if (Size > *Pos)             Size = *Pos;
      }
    }

    Pos++;
  }

  //
  //   Copy the leader, if there is one.
  //
  if (Error == errOk && Size > 0)
  {
    //
    //   Allocate a temporary block to hold the leader.
    //
    char *Leader = (char *) malloc (Size);

    //
    //   Copy the leader from the maps file to the work file, using the
    //   temporary memory block. Then free the block again.
    //
    if (Leader != NULL)
    {
      long Pos;

      if (Error == errOk) Error = ReadData (MapsHandle, 0, Leader, Size);
      if (Error == errOk) Error = WriteData (WorkMapsHandle, &Pos, Leader, Size);


      free (Leader);
    }
    else
    {
      Error = errNoMemory;
    }
  }

  //
  //   If an error occured, process it. Then return the error status.
  //
  if (Error != errOk) SetError (Error);
  return Error;
}

int MapGlobalRec::ConvertName (unsigned NewFormat)
{
  //
  //   This function is intended for format conversion only. The name of the
  //   game maps file of Wolf3D version 1.0 differs from the one in other
  //   Wolf3D versions. This function changes this name by setting the new
  //   name in the local name slot.
  //   At this moment we only do this for the shareware version, since we
  //   don't know if the same holds true for the commercial version.
  //
  if (CurrentVersion == cShareware)
  {
    switch (NewFormat)
    {
      case cFormat10:
        strcpy (GameMapsName, s10GameMaps);
        break;
      case cFormat11:
        strcpy (GameMapsName, s11GameMaps);
        break;
    }
  }

  //
  //   Return Ok to indicate success.
  //
  return errOk;
}

int MapGlobalRec::Close ()
{
  int Error = errOk;

  //
  //   Close the maps file, if it is open.
  //
  if (MapsHandle != -1) close (MapsHandle);

  //
  //   Close the maps work file, if it is open. Then process the files.
  //
  if (WorkMapsHandle != -1)
  {
    close (WorkMapsHandle);

    //
    //   The maps work file is closed. Now create, save and close the offsets
    //   work file.
    //
    int Handle = _creat (WorkMapHead, 0);
    if (Handle != -1)
    {
      long Pos;

      if (Error == errOk) Error = WriteData (Handle, &Pos, &MagicValue, 2);
      if (Error == errOk) Error = WriteData (Handle, &Pos, Offsets, NrMaps * sizeof 
(long));

      close (Handle);
    }
    else
    {
      Error = errCreate;
    }

    //
    //   Now process the work files.
    //
    if (Error == errOk) Error = CopyWorkFiles (GameMapsName, MapHeadName);

    //
    //   During the processing of the work files an error has occured. We
    //   will simply discard any changes in this case by deleting the work
    //   files.
    //
    if (Error != errOk)
    {
      unlink (WorkGameMaps);
      unlink (WorkMapHead);
    }
  }

  //
  //   Free any stored game maps in the maps store and free the store itself.
  //
  if (MapStore != NULL)
  {
    unsigned Map = 0;
    while (Map < NrMaps)
    {
      if (MapStore [Map] != NULL) delete MapStore [Map];
      Map++;
    }

    free (MapStore);
  }

  //
  //   Deallocate the memory, if allocated.
  //
  if (Offsets != NULL) free (Offsets);

  //
  //   Initialize all fields to their default values.
  //
  Offsets        = NULL;
  MapStore       = NULL;
  MapsHandle     = -1;
  WorkMapsHandle = -1;
  CurrentVersion = cUndetermined;
  MagicValue     = 0x0000;
  NrMaps         = 0;
  NrMapsStored   = 0;

  //
  //   If an error occured, process it. Then return the error status.
  //
  if (Error != errOk) SetError (Error);
  return Error;
}

int MapGlobalRec::Load (GameMapRec *Map, unsigned MapNr)
{
  //
  //   Load the map using the open file handle and the Load member function
  //   of the GameMap, but only if the map is actually in the file.
  //
  int Error = MapAvailable (MapNr) ? Map->Load (MapsHandle, Offsets [MapNr]) : errMapNotPresent;


  //
  //   If an error occured, process it. Then return the error status.
  //
  if (Error != errOk) SetError (Error);
  return Error;
}

int MapGlobalRec::Save (GameMapRec *Map, unsigned MapNr)
{
  //
  //   Save the map using the open file handle and the Load member function
  //   of the GameMap, adjusting the offset of map header in the process.
  //
  int Error = MapPossible (MapNr) ? Map->Save (WorkMapsHandle, &Offsets [MapNr]) 
: errMapNotPresent;

  //
  //   If an error occured, process it. Then return the error status.
  //
  if (Error != errOk) SetError (Error);
  return Error;
}

int MapGlobalRec::Compress (GameMapRec *Map, unsigned NewFormat)
{
  //
  //   Determine current format if not done so already.
  //
  int      Error     = Map->Format () == cUndetermined ? Map->DetermineFormat () 
: errOk;
  unsigned OldFormat = Map->Format ();

  //
  //   Convert to the requested format. Since v1.1 format compression is done
  //   over v1.0 compressed data, we use a while loop to cover each stage.
  //
  while (Error == errOk && NewFormat != OldFormat)
  {
    if (NewFormat < OldFormat)
    {
      //
      //   Decompression is needed.
      //
      if (OldFormat == cFormat11) Error = Map->DecompressFormat11 ();
      if (OldFormat == cFormat10) Error = Map->DecompressFormat10 (MagicValue);

      if (Error == errOk) OldFormat--;
    }
    else
    {
      //
      //   Compression is needed.
      //
      if (OldFormat == cFormat10)     Error = Map->CompressFormat11 ();
      if (OldFormat == cDecompressed) Error = Map->CompressFormat10 (MagicValue);


      if (Error == errOk) OldFormat++;
    }

    //
    //   If no error occured in this stage, set the new format in the GameMap.
    //
    if (Error == errOk) Map->SetFormat (OldFormat);
  }

  //
  //   If an error occured, process it. Then return the error status.
  //
  if (Error != errOk) SetError (Error);
  return Error;
}

int MapGlobalRec::Add (GameMapRec *Map, unsigned MapNr)
{
  int Error = errOk;

  //
  //   Store the requested map. If another one is present, deallocate that
  //   one.
  //
  if ( MapPossible (MapNr) )
  {
    //
    //   First make sure we have a new, empty GameMapRec allocated.
    //
    if (MapStore [MapNr] != NULL)
    {
      MapStore [MapNr]->Close ();
      NrMapsStored--;
    }
    else
    {
      MapStore [MapNr] = new GameMapRec;
      if (MapStore [MapNr] == NULL) Error = errNoMemory;
    }

    //
    //   When the allocation is successfull, move the contents of the given
    //   source map to the newly created one.
    //
    if (Error == errOk)
    {
      Error = MapStore [MapNr]->Copy (Map);
      if (Error == errOk) NrMapsStored++;
    }
  }
  else
  {
    Error = errMapNotPresent;
  }

  //
  //   If an error occured, process it. Then return the error status.
  //
  if (Error != errOk) SetError (Error);
  return Error;
}

int MapGlobalRec::InStore (unsigned MapNr)
{
  return MapPossible (MapNr) && MapStore [MapNr] != NULL;
}

int MapGlobalRec::Copy (GameMapRec *Map, unsigned MapNr)
{
  int Error = errOk;

  //
  //   Deallocate the requested map if it is indeed stored.
  //
  if ( MapPossible (MapNr) )
  {
    if (MapStore [MapNr] != NULL)
    {
      Error = Map->Copy (MapStore [MapNr]);
    }
  }
  else
  {
    Error = errMapNotPresent;
  }

  //
  //   If an error occured, process it. Then return the error status.
  //
  if (Error != errOk) SetError (Error);
  return Error;
}

int MapGlobalRec::Delete (unsigned MapNr)
{
  int Error = errOk;

  //
  //   Deallocate the requested map if it is indeed stored.
  //
  if ( MapPossible (MapNr) )
  {
    if (MapStore [MapNr] != NULL)
    {
      delete MapStore [MapNr];
      MapStore [MapNr] = NULL;
      NrMapsStored--;
    }
  }
  else
  {
    Error = errMapNotPresent;
  }

  //
  //   If an error occured, process it. Then return the error status.
  //
  if (Error != errOk) SetError (Error);
  return Error;
}

int MapGlobalRec::DisplayHeaders (FILE *Stream, unsigned Columns)
{
  //
  //   Initialize the various pointers and counters.
  //
  long     *Ofs     = Offsets;
  unsigned  MapNr   = 0;
  unsigned  Count   = 0;
  unsigned  Printed = 0;
  int       Error   = errOk;

  //
  //   First, determine how many maps are actually present.
  //
  while (MapNr++ < NrMaps)
  {
    if (*(Ofs++) != 0) Count++;
  }

  //
  //   Reinitialize the pointers.
  //
  Ofs   = Offsets;
  MapNr = 0;

  //
  //   Simply display a message when no maps are present.
  //
  if (Count == 0)
  {
    fprintf (Stream, "Sorry, there are no maps present in this version.\n");
  }
  else
  {
    switch (Columns)
    {
      //
      //   Display the header information in one column.
      //
      case cOneColumn:
        //
        //   Display column banner.
        //
        fprintf (Stream, "Map #   Title              Size\n");
        fprintf (Stream, "=====   ================   =======\n\n");

        //
        //   Walk every map and display information on present maps.
        //
        while (Error == errOk && MapNr < NrMaps)
        {
          if (*Ofs != 0)
          {
            MapHeaderRec Hdr;

            Error = ReadData (MapsHandle, *Ofs, &Hdr, sizeof (MapHeaderRec) );

            if (Error == errOk) fprintf (Stream, "%5u   %-16Fs   [%02u,%02u]\n", 
MapNr, Hdr.Title, Hdr.SizeX, Hdr.SizeY);
          }

          Ofs++;
          MapNr++;
        }

        break;

      //
      //   Display the header information in two columns.
      //
      case cTwoColumns:
        //
        //   Display column banners.
        //
        fprintf (Stream, "Map #   Title              Size         Map #   Title  
            Size\n");
        fprintf (Stream, "=====   ================   =======      =====   ================ 
  =======\n\n");

        //
        //   Walk every map and display information on present maps.
        //
        while (Error == errOk && MapNr < NrMaps)
        {
          if (*Ofs != 0)
          {
            MapHeaderRec Hdr;

            Error = ReadData (MapsHandle, *Ofs, &Hdr, sizeof (MapHeaderRec) );

            if (Error == errOk)
            {
              if ( (Printed & 1) == 0 )
              {
                fprintf (Stream, "%5u   %-16Fs   [%02u,%02u]      ", MapNr, Hdr.Title, 
Hdr.SizeX, Hdr.SizeY);
              }
              else
              {
                fprintf (Stream, "%5u   %-16Fs   [%02u,%02u]\n", MapNr, Hdr.Title, 
Hdr.SizeX, Hdr.SizeY);
              }
            }

            Printed++;
          }

          Ofs++;
          MapNr++;
        }

        //
        //   Force a new line if not done so already.
        //
        if ( (Printed & 1) != 0 ) fprintf (Stream, "\n");

        break;

      //
      //   Display short header information in three columns.
      //
      case cThreeColumns:
        //
        //   Display column banners.
        //
        fprintf (Stream, "Map #  Title               Map #  Title               Map 
#  Title\n");
        fprintf (Stream, "=====  ================    =====  ================    ===== 
 ================\n\n");

        //
        //   Walk every map and display information on present maps.
        //
        while (Error == errOk && MapNr < NrMaps)
        {
          if (*Ofs != 0)
          {
            MapHeaderRec Hdr;

            Error = ReadData (MapsHandle, *Ofs, &Hdr, sizeof (MapHeaderRec) );

            if (Error == errOk)
            {
              if ( (Printed % 3) != 2 )
              {
                fprintf (Stream, "%5u  %-16Fs    ", MapNr, Hdr.Title);
              }
              else
              {
                fprintf (Stream, "%5u  %-16Fs\n", MapNr, Hdr.Title);
              }
            }

            Printed++;
          }

          //
          //   Advance to next map.
          //
          Ofs++;
          MapNr++;
        }

        //
        //   Force a new line if not done so already.
        //
        if ( (Printed % 3) != 0 ) fprintf (Stream, "\n");

        break;
    }
  }

  //
  //   Return Ok to indicate success.
  //
  return errOk;
}
