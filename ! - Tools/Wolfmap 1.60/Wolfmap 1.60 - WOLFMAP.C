/*

---------------------------------------------------------------------------
| WolfMap Processing           |    (c) Oct 1992 Sysma Automatisering     |
---------------------------------------------------------------------------
| Version 1.0         06/10/92 | First implementation.                    |
|                              | J.P. Dijkstra, M.Sc.                     |
| Version 1.01        07/10/92 | Added automatic renaming of the game     |
|                              | maps file during format conversions.     |
|                              | J.P. Dijkstra, M.Sc.                     |
| Version 1.5         12/10/92 | Added a graphical, interactive map       |
|                              | viewer/editor.                           |
|                              | J.P. Dijkstra, M.Sc.                     |
| Version 1.6         20/10/92 | The editor will now create a specified   |
|                              | version of the map files, if it doesn't  |
|                              | exist.                                   |
|                              | Adjusted the naming of newly created     |
|                              | maps to be in sync with the origional    |
|                              | map names.                               |
|                              | J.P. Dijkstra, M.Sc.                     |
---------------------------------------------------------------------------
| This program processes the Wolf-3D map files in various ways. It can    |
| show the map names, the number of maps stored, convert from version 1.0 |
| to 1.1 format and vice versa, print out any map in ASCII format to      |
| stdout (to allow redirection) or a file.                                |
|                                                                         |
| The maze / objects data is stored in a compressed format, wordwize. The |
| first word is the number of bytes the decompressed data will occupy in  |
| memory. The compressed data follows immediately.                        |
| The start of the level headers in the GAMEMAPS file are stores in the   |
| MAPHEAD file. The first word in this file is the magic word preceding a |
| repeat count in the compressed data in the GAMEMAPS file. This word is  |
| followed by a sequence of long words, one for each level.               |
---------------------------------------------------------------------------

*/

#include "wolfmap.H"
#include "stdio.h"

/*

---------------------------------------------------------------------------
| Local data structures and constants                                     |
---------------------------------------------------------------------------
| FlagsRec                    | Contains the processed command line flags |
|   Version                   | Contains the maps file version to use.    |
|                             | For import and export specifies the       |
|                             | target and source respectively.           |
|   Format                    | Contains the compression format to use.   |
|                             | For import and export specifies the new   |
|                             | format to convert the maps to. For the    |
|                             | other commands this field overrides the   |
|                             | autodetection of the maps format. Use     |
|                             | with care !!!!                            |
|   Output                    | Contains the output target to print data  |
|                             | to.                                       |
|   Columns                   | Specifies the number of columns to use    |
|                             | when displaying information on stdout.    |
|   Legend                    | Specifies whether or not to print the map |
|                             | legend. Only relevant for single file     |
|                             | output.                                   |
|   MapNrGiven                | Specifies whether a map number was given  |
|                             | on the command line.                      |
|   MapChosen                 | Each bit specifies whether or not the     |
|                             | accompanying map number was specified.    |
|   LowestMap                 | Holds the first map number specified.     |
---------------------------------------------------------------------------

*/

const int cMaxMaps  = 400;
const int cMaxBytes = (cMaxMaps + 7) >> 3;

char *cCopyright = "Copyright (c) 1992 Sysma Automatisering     All rights reserved.";

char *cVersion   = "WolfMap v1.6";

struct FlagsRec
{
  unsigned Version    :3;
  unsigned Format     :2;
  unsigned Output     :2;
  unsigned Columns    :2;
  unsigned Legend     :1;
  unsigned MapNrGiven :1;
  char     MapChosen  [ cMaxBytes ];
  unsigned LowestMap;
};

const int cNoCommand     = 0;
const int cHelp          = 1;
const int cExportMaps    = 2;
const int cImportMaps    = 3;
const int cConvert10     = 4;
const int cConvert11     = 5;
const int cPrintMaps     = 6;
const int cPrintMapStats = 7;
const int cPrintLegend   = 8;
const int cDisplayTitles = 9;
const int cDisplayStats  = 10;
const int cModify        = 11;

/*

---------------------------------------------------------------------------
| Local functions to implement elementary operations.                     |
---------------------------------------------------------------------------
| SetMapNr                    | Marks the given map number as chosen.     |
| MapChosen                   | Returns true if the given map number is   |
|                             | indeed chosen.                            |
| ResetAllMaps                | Resets the mark for all map numbers.      |
| SetAllMaps                  | Sets the chosen mark for all map numbers. |
| Message                     | Writes an error message to stderr for the |
|                             | given error code.                         |
| ProcessParameters           | Scans the command line and sets the       |
|                             | appropriate values for flags, commands    |
|                             | map numbers.                              |
| ShowHelp                    | Displays generic information about this   |
|                             | program.                                  |
| ShowCommands                | Displays the correct program usage,       |
|                             | including possible flags and commands.    |
| Export                      | Copies the chosen maps from the given     |
|                             | maps file version to the intermediate     |
|                             | maps file.                                |
| Import                      | Copies the chosen maps from the local (or |
|                             | intermediate) maps file to the given maps |
|                             | file.                                     |
| ConvertFormat               | Converts ALL maps in the given maps file  |
|                             | to the specified compression format.      |
| PrintMaps                   | Prints the chosen maps to the specified   |
|                             | output stream, separated by form feeds.   |
| PrintMapStatistics          | Prints statistics from the chosen maps to |
|                             | the specified output stream, two map      |
|                             | statistics per page, separated by form    |
|                             | feeds.                                    |
| PrintLegend                 | Prints the legend of the symbols, used in |
|                             | the prints of a map, to a separate file   |
|                             | or to the given output stream.            |
| DisplayTitles               | Displays the titles of all the maps in    |
|                             | given version.                            |
| DisplayStatistics           | Displays statistics about the maps in the |
|                             | given version.                            |
| main                        | The actual program.                       |
---------------------------------------------------------------------------

*/

void SetMapNr (FlagsRec *Flags, unsigned MapNr)
{
  if (MapNr < cMaxMaps)
  {
    unsigned Bit  = 0x01 << (MapNr & 0x07);
    unsigned Byte = MapNr >> 3;
    Flags->MapChosen [Byte] |= Bit;
    if (Flags->MapNrGiven == cFalse || MapNr < Flags->LowestMap)
    {
      Flags->LowestMap  = MapNr;
      Flags->MapNrGiven = cTrue;
    }
  }
}

int MapChosen (FlagsRec *Flags, unsigned MapNr)
{
  if (MapNr < cMaxMaps)
  {
    unsigned Bit  = 0x01 << (MapNr & 0x07);
    unsigned Byte = MapNr >> 3;
    return (Flags->MapChosen [Byte] & Bit) != 0 ? cTrue : cFalse;
  }

  return cFalse;
}

void ResetAllMaps (FlagsRec *Flags)
{
  unsigned Byte = 0;
  while (Byte < cMaxBytes)
  {
    Flags->MapChosen [Byte++] = 0x00;
  }
  Flags->MapNrGiven = cFalse;
  Flags->LowestMap  = 0;
}

void SetAllMaps (FlagsRec *Flags)
{
  unsigned Byte = 0;
  while (Byte < cMaxBytes)
  {
    Flags->MapChosen [Byte++] = 0xFF;
  }
}

#pragma argsused
void Message (unsigned ErrCode, unsigned MapNr, int IgnoreChange)
{
  fprintf (stderr, "WolfMap: ");

  switch (ErrCode)
  {
    case errNoMemory:
      fprintf (stderr, "Not enough memory left.\n");
      break;
    case errMemoryCorrupted:
      fprintf (stderr, "Fatal error. Memory corrupted.\n");
      break;
    case errSeek:
      fprintf (stderr, "Error locating the correct position in the files.\n");
      break;
    case errRead:
      fprintf (stderr, "Error reading from file.\n");
      break;
    case errWrite:
      fprintf (stderr, "Error writing to the work file.\n");
      break;
    case errLeaderTooLarge:
      fprintf (stderr, "Non-map part of the maps file > 64K.\n");
      break;
    case errNoSuchFile:
      fprintf (stderr, "Requested version does not exist.\n");
      break;
    case errNoMapHeadFile:
      fprintf (stderr, "Requested version is not in the correct format.\n");
      break;
    case errNoSuchVersion:
      fprintf (stderr, "Requested an unknown version.\n");
      break;
    case errDelete:
      fprintf (stderr, "Error deleting the previous backup files.\n");
      break;
    case errBackup:
      fprintf (stderr, "Error backing up the origional files.\n");
      break;
    case errCopy:
      fprintf (stderr, "Error copying the work files to the origionals.\n");
      break;
    case errCreate:
      fprintf (stderr, "Error creating the work files.\n");
      break;
    case errNotOpen:
      fprintf (stderr, "Attempt to read or write from a closed file.\n");
      break;
    case errLocalIsTarget:
      fprintf (stderr, "Local version may not be specified for this command.\n");

      break;
    case errMapNotPresent:
      fprintf (stderr, "Attempt to load or save a non existing map.\n");
      break;
    case errNotAllocated:
      fprintf (stderr, "Attempt to use a non allocated memory block.\n");
      break;
    case errCreateOutput:
      fprintf (stderr, "Error creating the output file.\n");
      break;
    case errNoDefFile:
      fprintf (stderr, "Error opening the legend definition files.\n");
      break;
    case errIllegalLegend:
      fprintf (stderr, "Syntax error reading legend definition line.\n");
      break;
    case errIllegalMaze:
      fprintf (stderr, "Illegal map sizes specified when creating a new map.\n");

      break;
    case errInitializeGraph:
      fprintf (stderr, "Error loading the VGA graphics driver.\n");
      break;
  }

  if ( IgnoreChange )
  {
    fprintf (stderr, "         Changes will NOT be written.\n");
  }
}

int ProcessParameters (int argc, char **argv, FlagsRec *Flags)
{
  //
  //   This function processes the parameters passed to the program and
  //   sets any global variables accordingly.
  //
  int Arg     = 0;
  int Command = cNoCommand;

  ResetAllMaps (Flags);
  Flags->Format  = cUndetermined;
  Flags->Version = cUndetermined;
  Flags->Output  = cSingle;
  Flags->Legend  = cFalse;
  Flags->Columns = cOneColumn;

  //
  //   Scan every command line parameter to figure out what it is. In the
  //   switch blocks the continue statement is used whenever a paremeter is
  //   recognized. This is done to enable error processing for nested
  //   switch statements.
  //
  while (++Arg < argc)
  {
    if (**(++argv) == '-' || **argv == '/')
    {
      //
      //   Possible flag detected. Figure out which one.
      //
      switch ( (*argv) [1] )
      {
        //   Actually help command.
        case '?':
          return cHelp;

        //   Actually help command.
        case 'h':
          return cHelp;

        //   Compression format specifier.
        case 'f':
          switch ( (*argv) [2] )
          {
            case '0':
              Flags->Format = cFormat10;
              continue;
            case '1':
              Flags->Format = cFormat11;
              continue;
            case '2':
              Flags->Format = cFormat11;
              continue;
            case '\0':
              Flags->Format = cUndetermined;
              continue;
          }
          break;

        //   Output file specifiers.
        case 'o':
          switch ( (*argv) [2] )
          {
            case 'u':
              Flags->Output = cSeparate;
              continue;
            case 's':
              Flags->Output = cSingle;
              continue;
            case 'o':
              Flags->Output = cStdout;
              continue;
            case '\0':
              Flags->Output = cSingle;
              continue;
            case 'l':
              Flags->Legend = cTrue;
              continue;
          }
          break;

        //   File version.
        case 's':
          Flags->Version = cShareware;
          continue;
        case 'c':
          Flags->Version = cComplete;
          continue;
        case 'l':
          Flags->Version = cLocal;
          continue;

        //   Number of columns.
        case 'w':
          Flags->Columns = cThreeColumns;
          continue;
        case '2':
          Flags->Columns = cTwoColumns;
          continue;
        case '1':
          Flags->Columns = cOneColumn;
          continue;
      }

      //
      //   At this point not legal flag could be recognized. Therefore the
      //   offending flag will be printed and NoCommand will returned
      //   immediately.
      //
      fprintf (stderr, "WolfMap: Unknown flag '%s'\n", (*argv)+1);
      fprintf (stderr, "         Type 'wolfmap -h' for a complete list of flags.\n");

      return cNoCommand;
    }

    //
    //   At this point the current parameter cannot be a flag. Two other
    //   possibilities remain, either a map number or a command. Here we
    //   check for a map number.
    //
    if (**argv >= '0' && **argv <= '9')
    {
      unsigned MapNr = 0;

      //
      //   Process digits into a map number.
      //
      char *Str = *argv;
      while (*Str >= '0' && *Str <= '9')
      {
        MapNr = MapNr * 10 + (*(Str++) - '0');
      }

      //
      //   If the digits are terminated correctly, process the number and
      //   continue with the next parameter.
      //
      if (*Str == '\0')
      {
        SetMapNr (Flags, MapNr);
        continue;
      }

      //
      //   If the next non digit character is a minus sign, we have
      //   encountered a range of map numbers. Note that this cannot be
      //   a space character, since in that case the startup code would have
      //   interpreted this as a parameter separator.
      //
      if (*(Str++) == '-')
      {
        unsigned SecondNr = 0;

        //
        //   Process the digits into the second map number for the upper
        //   limit of the range.
        //
        while (*Str >= '0' && *Str <= '9')
        {
          SecondNr = SecondNr * 10 + (*(Str++) - '0');
        }

        //
        //   The range is legal only when the second sequence of digits is
        //   terminated correctly.
        //
        if (*Str == '\0')
        {
          //
          //   Process the range, but only if the first number is not
          //   greater than the second one.
          //
          if (MapNr <= SecondNr)
          {
            while (MapNr <= SecondNr)
            {
              SetMapNr (Flags, MapNr++);
            }
            continue;
          }

          //
          //   At this point the range is given incorrectly. Currently we
          //   consider this a fatal error.
          //
          fprintf (stderr, "WolfMap: Range [%s] is specified incorrectly.\n", *argv);

          return cNoCommand;
        }
      }

      //
      //   At this point not legal number could be recognized. Therefore the
      //   offending parameter will be printed and NoCommand will returned
      //   immediately.
      //
      fprintf (stderr, "WolfMap: [%s] is not a legal map number.'\n", *argv);
      return cNoCommand;
    }

    //
    //   At this point the decision has been made that the parameter is
    //   not a flag or a map number. Now figure out if it is a command. Only
    //   the first command given is taken, others will be ignored. This is
    //   done because flags can appear anywhere in the command line and this
    //   method saves scanning the command line twice.
    //
    if (Command == cNoCommand)
    {
      switch (**argv)
      {
        //   Conversion command. Figure out to which format.
        case 'c':
          switch ( (*argv) [1] )
          {
            case '0':
              Command = cConvert10;
              continue;
            case '1':
              Command = cConvert11;
              continue;
            case '2':
              Command = cConvert11;
              continue;
          }
          break;

        //   Print commands.
        case 'p':
          switch ( (*argv) [1] )
          {
            case 'm':
              Command = cPrintMaps;
              continue;
            case 's':
              Command = cPrintMapStats;
              continue;
            case 'l':
              Command = cPrintLegend;
              continue;
            case '\0':
              Command = cPrintMaps;
              continue;
          }
          break;

        //   Display commands.
        case 'd':
          switch ( (*argv) [1] )
          {
            case 't':
              Command = cDisplayTitles;
              continue;
            case 's':
              Command = cDisplayStats;
              continue;
            case '\0':
              Command = cDisplayTitles;
              continue;
          }
          break;

        //   Export map command.
        case 'e':
          Command = cExportMaps;
          continue;

        //   Import map command.
        case 'i':
          Command = cImportMaps;
          continue;

        //   Modify (edit) map command.
        case 'm':
          Command = cModify;
          continue;

        //   Help command.
        case 'h':
          Command = cHelp;
          continue;
        case '?':
          Command = cHelp;
          continue;
      }

      //
      //   At this point an unknown command was encountered, so print an
      //   error message and return NoCommand immediately.
      //
      fprintf (stderr, "WolfMap: Unknown command %s.\n", *argv);
      fprintf (stderr, "         Type 'wolfmap -h' for a complete list of commands.\n");

      return cNoCommand;
    }
  }

  //
  //   Return the command recognized, if any.
  //
  if (Command == cNoCommand)
  {
    fprintf (stderr, "WolfMap: No command has been issued.\n");
    fprintf (stderr, "         Type 'wolfmap -h' for a complete list of commands.\n");

  }

  if (Flags->MapNrGiven == cFalse) SetAllMaps (Flags);

  return Command;
}

int ShowBanner ()
{
  //
  //   Display banner on the screen.
  //
  fprintf (stderr, "%s   -   Processes Wolfenstein-3D maps.\n%s\n\n", cVersion, cCopyright);


  return cOk;
}

int ShowHelp ()
{
  fprintf (stderr, "WolfMap processes the level maps of Wolf-3D versions 1.0, 1.1 
and 1.2\n");
  fprintf (stderr, "It can show essential level information, print out a map of any 
level,\n");
  fprintf (stderr, "reveiling doors, guards, secret rooms and much more. Also, it 
is able\n");
  fprintf (stderr, "to convert the map formats from one Wolf-3D version 1.0 to another.\n");

  fprintf (stderr, "Finally, WolfMap contains an interactive, graphical map editor.\n\n");

  fprintf (stderr, "Use WolfMap -h for a detailed list of commands.\n");
  return cOk;
}

int ShowCommands ()
{
  fprintf (stderr, "Syntax: Wolfmap [flags] [command] [mapnr | mapnr-mapnr]\n\n");

  fprintf (stderr, "Allowable flags are:              Allowable commands are:\n\n");

  fprintf (stderr, "-h   Show this information.       h   Show this information.\n");

  fprintf (stderr, "-?   Same as -h.                  ?   Same as h.\n");
  fprintf (stderr, "-f0  Use v1.0 format.             c0  Convert to v1.0 format.\n");

  fprintf (stderr, "-f1  Use v1.1 format.             c1  Convert to v1.1 format.\n");

  fprintf (stderr, "-f2  Use v1.2 format.             c2  Convert to v1.2 format.\n");

  fprintf (stderr, "-s   Use shareware version.       e   Export maps to local version.\n");

  fprintf (stderr, "-c   Use complete version.        i   Import maps from local 
version.\n");
  fprintf (stderr, "-l   Use local version.           m   Modify (edit) maps.\n");

  fprintf (stderr, "-w   Use wide display.            dt  Display map titles.\n");

  fprintf (stderr, "-2   Use two column display.      ds  Display map statistics.\n");

  fprintf (stderr, "-ou  Print to unique files.       pm  Print maps.\n");
  fprintf (stderr, "-os  Print to single file.        ps  Print map statistics.\n");

  fprintf (stderr, "-oo  Print to stdout.             pl  Print the legend of map 
symbols.\n");
  fprintf (stderr, "-ol  Print legend of maps.\n");
  return cOk;
}

int Export (FlagsRec *Flags)
{
  MapGlobalRec FromGlobals;
  MapGlobalRec ToGlobals;

  //
  //   Try opening the requested maps version and open the local version for
  //   writing.
  //
  int Error = Flags->Version == cLocal ? errLocalIsTarget : errOk;

  if (Error == errOk) Error = FromGlobals.Open (Flags->Version);
  if (Error == errOk) Error = ToGlobals.Create (cLocal);

  //
  //   Process all requested maps, one at a time.
  //
  unsigned MapNr    = 0;
  unsigned Exported = 0;

  while (Error == errOk && MapNr < FromGlobals.MapCount () )
  {
    //
    //   Check if this map is requested for exporting. Check only real,
    //   available maps.
    //
    if (FromGlobals.MapAvailable (MapNr) && MapChosen (Flags, MapNr) )
    {
      //
      //   This map was requested, so process it.
      //
      GameMapRec Map;

      //
      //   First, read the map from the requested version and determine the
      //   target format.
      //
      if (Error == errOk) Error = FromGlobals.Load    (&Map, MapNr);
      if (Error == errOk) Error = Map.DetermineFormat ();

      unsigned Format = Flags->Format == cUndetermined ? Map.Format () : Flags->Format;


      //
      //   Now, convert the map to the target format and save it.
      //
      if (Error == errOk) Error = FromGlobals.Compress (&Map, cDecompressed);
      if (Error == errOk) Error = ToGlobals.Compress   (&Map, Format);
      if (Error == errOk) Error = ToGlobals.Save       (&Map, MapNr);

      Exported++;
    }

    //
    //   Advance to the next map, but only if no errors occured.
    //
    if (Error == errOk) MapNr++;
  }

  //
  //   Close the maps and the local maps.
  //
  if (Error == errOk) Error = ToGlobals.Close ();
  if (Error == errOk) Error = FromGlobals.Close ();

  //
  //   Display the number of maps exported if no errors occured. Otherwise,
  //   display the correct error message.
  //
  if (Error == errOk)
  {
    fprintf (stderr, "Exported %d %s to the intermediate version.\n",
             Exported, Exported == 1 ? "map" : "maps"
            );
    return cOk;
  }
  else
  {
    Message (Error, MapNr, cTrue);
    return cError;
  }
}

int Import (FlagsRec *Flags)
{
  MapGlobalRec FromGlobals;
  MapGlobalRec ToGlobals;

  //
  //   Try opening the requested maps version for writing / updating and open
  //   the local version for reading.
  //
  int Error = Flags->Version == cLocal ? errLocalIsTarget : errOk;

  if (Error == errOk) Error = FromGlobals.Open (cLocal);
  if (Error == errOk)
  {
    Error = ToGlobals.Open (Flags->Version);

    if (Error == errOk)
    {
      Error = ToGlobals.OpenWork ();
    }
    else if (Error == errNoSuchVersion)
    {
      Error = ToGlobals.Create (Flags->Version);
    }
  }

  //
  //   Process all requested maps, one at a time.
  //
  unsigned MapNr    = 0;
  unsigned Imported = 0;

  while (Error == errOk && MapNr < FromGlobals.MapCount () )
  {
    //
    //   Since this is importing, every map must be processed.
    //
    GameMapRec Map;

    //
    //   Determine if the current map is to imported, or (in case it is not)
    //   if the current map is available in the target maps file.
    //
    if (FromGlobals.MapAvailable (MapNr) && MapChosen (Flags, MapNr) )
    {
      if (Error == errOk) Error = FromGlobals.Load    (&Map, MapNr);
      if (Error == errOk) Error = Map.DetermineFormat ();

      unsigned Format = Flags->Format == cUndetermined ? Map.Format () : Flags->Format;


      //
      //   Now, convert the map to the target format and save it.
      //
      if (Error == errOk) Error = FromGlobals.Compress (&Map, cDecompressed);
      if (Error == errOk) Error = ToGlobals.Compress   (&Map, Format);
      if (Error == errOk) Error = ToGlobals.Save       (&Map, MapNr);

      Imported++;
    }
    else
    {
      if (ToGlobals.MapAvailable (MapNr))
      {
        //
        //   The current map is not imported, but is present. Therefore we
        //   transfer it to the work file.
        //
        if (Error == errOk) Error = ToGlobals.Load (&Map, MapNr);

        if (Error == errOk && Flags->Format != cUndetermined)
        {
          Error = ToGlobals.Compress (&Map, Flags->Format);
        }

        if (Error == errOk) Error = ToGlobals.Save (&Map, MapNr);
      }
    }

    //
    //   Advance to the next map, but only if no errors occured.
    //
    if (Error == errOk) MapNr++;
  }

  //
  //   Close the maps and the local maps.
  //
  if (Error == errOk) Error = ToGlobals.Close ();
  if (Error == errOk) Error = FromGlobals.Close ();

  //
  //   Display the number of maps exported if no errors occured. Otherwise,
  //   display the correct error message.
  //
  if (Error == errOk)
  {
    fprintf (stderr, "Imported %d %s from the intermediate version.\n",
             Imported, Imported == 1 ? "map" : "maps"
            );
    return cOk;
  }
  else
  {
    Message (Error, MapNr, cTrue);
    return cError;
  }
}

int ConvertFormat (FlagsRec *Flags, unsigned NewFormat)
{
  MapGlobalRec Globals;

  //
  //   Try opening the requested maps version.
  //
  int                 Error = Globals.Open (Flags->Version);
  if (Error == errOk) Error = Globals.OpenWork ();

  //
  //   Walk every map in the maps file.
  //
  unsigned MapNr     = 0;
  unsigned Converted = 0;

  while (Error == errOk && MapNr < Globals.MapCount () )
  {
    //
    //   Convert the current map to the new format, but only if it is
    //   actually present in the maps file.
    //
    if ( Globals.MapAvailable (MapNr) )
    {
      //
      //   Process to current map.
      //
      GameMapRec Map;
      Map.SetFormat (Flags->Format);

      if (Error == errOk) Error = Globals.Load     (&Map, MapNr);
      if (Error == errOk) Error = Globals.Compress (&Map, NewFormat);
      if (Error == errOk) Error = Globals.Save     (&Map, MapNr);

      Converted++;
    }

    //
    //   Advance to the next map, but only if no errors occured.
    //
    if (Error == errOk) MapNr++;
  }

  //
  //   Close the maps and convert the game maps filename if necessary.
  //
  if (Error == errOk) Error = Globals.ConvertName (NewFormat);
  if (Error == errOk) Error = Globals.Close ();

  //
  //   Display the number of maps converted if no errors occured. Otherwise,
  //   display the correct error message.
  //
  if (Error == errOk)
  {
    fprintf (stderr, "Converted %d %s to v1.%d format.\n",
             Converted, Converted == 1 ? "map" : "maps",
             NewFormat == cFormat10 ? 0 : 1
            );
    return cOk;
  }
  else
  {
    Message (Error, MapNr, cTrue);
    return cError;
  }
}

int PrintMaps (FlagsRec *Flags, FILE *Stream)
{
  MapGlobalRec Globals;

  //
  //   Try opening the requested maps version.
  //
  int Error = Globals.Open (Flags->Version);

  //
  //   Open the single output file, if requested.
  //
  if (Flags->Output == cSingle)
  {
    Stream = fopen ("LEVELS.MAP", "wt");
    if (Stream == NULL) Error = errCreateOutput;
  }

  //
  //   Process all requested maps, one at a time.
  //
  unsigned MapNr   = 0;
  unsigned Printed = 0;

  while (Error == errOk && MapNr < Globals.MapCount () )
  {
    //
    //   Check if this map is requested for printing. Check only real,
    //   available maps.
    //
    if (Globals.MapAvailable (MapNr) && MapChosen (Flags, MapNr) )
    {
      //
      //   This map was requested, so process it.
      //
      GameMapRec Map;
      Map.SetFormat (Flags->Format);

      //
      //   If output goes to unique files, open a unique output file for
      //   this map.
      //
      if (Flags->Output == cSeparate)
      {
        char LevelName [13];
        sprintf (LevelName, "LEVEL%03d.MAP", MapNr);
        Stream = fopen (LevelName, "wt");
        if (Stream == NULL) Error = errCreateOutput;
      }

      //
      //   Print the current map, if the output stream is opened.
      //
      if (Error == errOk) Error = Globals.Load     (&Map, MapNr);
      if (Error == errOk) Error = Globals.Compress (&Map, cDecompressed);
      if (Error == errOk) Error = Map.Print        (Stream, MapNr);
      if (Error == errOk) fprintf (Stream, "\f");

      //
      //   If a separate output file is open, close it.
      //
      if (Flags->Output == cSeparate) fclose (Stream);

      Printed++;
    }

    //
    //   Advance to the next map, but only if no errors occured.
    //
    if (Error == errOk) MapNr++;
  }

  //
  //   Close the maps.
  //
  if (Error == errOk) Error = Globals.Close ();

  //
  //   Print a legend to the (possible separate) output stream if requested.
  //   legend to the file if one was requested.
  //
  if (Flags->Legend)
  {
    //
    //   Open a legend file if separate files are requested.
    //
    if (Flags->Output == cSeparate)
    {
      Stream = fopen ("LEGEND.MAP", "wt");
      if (Stream == NULL) Error = errCreateOutput;
    }

    //
    //   Print the legend, followed by a form feed.
    //
    if (Error == errOk) Error = PrintLegend (Stream);
    if (Error == errOk) fprintf (Stream, "\f");

    //
    //   If a separate legend file is open, close it.
    //
    if (Flags->Output == cSeparate) fclose (Stream);
  }

  //
  //   Close the output stream if the single output file was open.
  //
  if (Flags->Output == cSingle) fclose (Stream);

  //
  //   Display the number of maps printed if no errors occured. Otherwise,
  //   display the correct error message.
  //
  if (Error == errOk)
  {
    fprintf (stderr, "Printed %d %s.\n",
             Printed, Printed == 1 ? "map" : "maps"
            );
    return cOk;
  }
  else
  {
    Message (Error, MapNr, cFalse);
    return cError;
  }
}

int PrintMapStatistics (FlagsRec *Flags, FILE *Stream)
{
  MapGlobalRec Globals;

  //
  //   Try opening the requested maps version.
  //
  int Error = Globals.Open (Flags->Version);

  //
  //   Open the single output file, if requested.
  //
  if (Flags->Output == cSingle)
  {
    Stream = fopen ("LEVELS.STA", "wt");
    if (Stream == NULL) Error = errCreateOutput;
  }

  //
  //   Process all requested maps, one at a time.
  //
  unsigned MapNr   = 0;
  unsigned Printed = 0;

  while (Error == errOk && MapNr < Globals.MapCount () )
  {
    //
    //   Check if this map is requested for printing. Check only real,
    //   available maps.
    //
    if (Globals.MapAvailable (MapNr) && MapChosen (Flags, MapNr) )
    {
      //
      //   This map was requested, so process it.
      //
      GameMapRec Map;
      Map.SetFormat (Flags->Format);

      //
      //   Open a unique output file for this map, if requested.
      //
      if (Flags->Output == cSeparate)
      {
        char LevelName [13];
        sprintf (LevelName, "LEVEL%03d.STA", MapNr);
        Stream = fopen (LevelName, "wt");
        if (Stream == NULL) Error = errCreateOutput;
      }

      if (Error == errOk) Error = Globals.Load        (&Map, MapNr);
      if (Error == errOk) Error = Globals.Compress    (&Map, cDecompressed);
      if (Error == errOk) Error = Map.Statistics      ();
      if (Error == errOk) Error = Map.PrintStatistics (Stream, MapNr);
      if (Error == errOk) fprintf (Stream, "\n\n\n\n");

      Printed++;

      //
      //   Print a copyright notice on the bottom of every page.
      //
      if (Flags->Output == cSeparate || (Printed & 1) == 0)
      {
        if (Error == errOk) fprintf (Stream, "Printed with %s.\n%s\n\f", cVersion, 
cCopyright);
      }

      //
      //   Close the output stream if output goes to separate files.
      //
      if (Flags->Output == cSeparate) fclose (Stream);
    }

    //
    //   Advance to the next map, but only if no errors occured.
    //
    if (Error == errOk) MapNr++;
  }

  //
  //   Close the maps.
  //
  if (Error == errOk) Error = Globals.Close ();

  //
  //   Close the output stream if the single output file was open.
  //
  if (Flags->Output == cSingle)
  {
    fclose (Stream);
  }

  //
  //   Display the number of maps printed if no errors occured. Otherwise,
  //   display the correct error message.
  //
  if (Error == errOk)
  {
    fprintf (stderr, "Printed statistics of %d %s.\n",
             Printed, Printed == 1 ? "map" : "maps"
            );
    return cOk;
  }
  else
  {
    Message (Error, MapNr, cFalse);
    return cError;
  }
}

int PrintLegend (FlagsRec *Flags, FILE *Stream)
{
  int Error = errOk;

  //
  //   Open the single output file, if requested.
  //
  if (Flags->Output == cSingle || Flags->Output == cSeparate)
  {
    Stream = fopen ("LEGEND.MAP", "wt");
    if (Stream == NULL) Error = errCreateOutput;
  }

  if (Error == errOk) Error = PrintLegend (Stream);
  if (Error == errOk) fprintf (Stream, "\f");

  if (Flags->Output == cSingle || Flags->Output == cSeparate)
  {
    fclose (Stream);
  }

  //
  //   Display a message indicating sucecss if no errors occured. Otherwise,
  //   display the correct error message.
  //
  if (Error == errOk)
  {
    fprintf (stderr, "Printed the legend of the maps.\n");
    return cOk;
  }
  else
  {
    Message (Error, 0, cFalse);
    return cError;
  }
}

int DisplayTitles (FlagsRec *Flags)
{
  MapGlobalRec Globals;

  //
  //   Open the requested version, display the titles and close the version
  //   again.
  //
  int                 Error = Globals.Open (Flags->Version);
  if (Error == errOk) Error = Globals.DisplayHeaders (stdout, Flags->Columns);
  if (Error == errOk) Error = Globals.Close ();

  //
  //   If an error occured, display the correct error message.
  //
  if (Error != errOk)
  {
    Message (Error, 0, cFalse);
    return cError;
  }

  //
  //   No errors, so return Ok.
  //
  return cOk;
}

int DisplayStatistics (FlagsRec *Flags)
{
  MapGlobalRec Globals;

  //
  //   Open the requested version.
  //
  int Error = Globals.Open (Flags->Version);

  unsigned MapNr = 0;
  unsigned Count = 0;

  //
  //   Determine the number of maps actually present.
  //
  while (MapNr < Globals.MapCount () )
  {
    if (Globals.MapAvailable (MapNr) ) Count++;
    MapNr++;
  }

  //
  //   Display a message if no maps are available. Otherwise, display the
  //   column headers.
  //
  if (Error == errOk)
  {
    if (Count == 0)
    {
      fprintf (stdout, "Sorry, there are no maps present in this version.\n");
    }
    else
    {
      fprintf (stdout, "Map #   Title              Door Lock Secr Elev Trea Lvl1 
Lvl3 Lvl4 Huge\n");
      fprintf (stdout, "=====   ================   ==== ==== ==== ==== ==== ==== 
==== ==== ====\n\n");
    }
  }

  MapNr = 0;

  //
  //   Walk every map. If the current map is available, read and decompress
  //   it and display a line with statistics about this map.
  //
  while (Error == errOk && MapNr < Globals.MapCount () )
  {
    if (Globals.MapAvailable (MapNr) )
    {
      GameMapRec Map;
      Map.SetFormat (Flags->Format);

      if (Error == errOk) Error = Globals.Load     (&Map, MapNr);
      if (Error == errOk) Error = Globals.Compress (&Map, cDecompressed);
      if (Error == errOk) Error = Map.Statistics   ();
      if (Error == errOk)
      {
        //
        //   Determine the totals of the actors in the map.
        //
        unsigned sActors1 = Map.Actors (oGuard1) + Map.Actors (oOfficer1) + Map.Actors 
(oSS1) + Map.Actors (oUndead1);
        unsigned mActors1 = Map.Actors (omGuard1)+ Map.Actors (omOfficer1)+ Map.Actors 
(omSS1)+ Map.Actors (omUndead1)+ Map.Actors (oDog1);
        unsigned sActors3 = Map.Actors (oGuard3) + Map.Actors (oOfficer3) + Map.Actors 
(oSS3) + Map.Actors (oUndead3);
        unsigned mActors3 = Map.Actors (omGuard3)+ Map.Actors (omOfficer3)+ Map.Actors 
(omSS3)+ Map.Actors (omUndead3)+ Map.Actors (oDog3);
        unsigned sActors4 = Map.Actors (oGuard4) + Map.Actors (oOfficer4) + Map.Actors 
(oSS4) + Map.Actors (oUndead4);
        unsigned mActors4 = Map.Actors (omGuard4)+ Map.Actors (omOfficer4)+ Map.Actors 
(omSS4)+ Map.Actors (omUndead4)+ Map.Actors (oDog4);

        //
        //   Display one line of information.
        //
        fprintf (stdout, "%5u   %-16s   %4u %4u %4u %4u %4u %4u %4u %4u %4u\n",
                 MapNr,
                 Map.Title (),
                 Map.Doors (),
                 Map.LockedDoors (),
                 Map.SecretDoors (),
                 Map.Elevators (),
                 Map.Treasures (),
                 sActors1 + mActors1,
                 sActors1 + mActors1 + sActors3 + mActors3,
                 sActors1 + mActors1 + sActors3 + mActors3 + sActors4 + mActors4,

                 Map.HugeActors ()
                );
      }
    }

    if (Error == errOk) MapNr++;
  }

  //
  //   Close the opened version.
  //
  if (Error == errOk) Error = Globals.Close ();

  //
  //   If an error occured, display the correct error message.
  //
  if (Error != errOk)
  {
    Message (Error, MapNr, cFalse);
    return cError;
  }

  //
  //   No errors, so return Ok.
  //
  return cOk;
}

int ModifyMaps (FlagsRec *Flags)
{
  MapGlobalRec Globals;
  GraphRec     Editor;

  int Error    = errOk;
  int Changed  = cFalse;
  int Command  = cNone;
  int MapNr    = 0;
  int Episode  = 0;
  int Finished = cFalse;
  int Modified = 0;
  int Created  = cFalse;

  //
  //   Open the requested version of the maps files and the graphics editor.
  //   If a specific version is given but non existing, it will be created.
  //
  Error = Globals.Open (Flags->Version);

  if (Error == errNoSuchVersion)
  {
    Error   = Globals.Create (Flags->Version);
    Created = cTrue;
  }

  if (Error == errOk) Error = Editor.Open ();

  //
  //   Display / Edit one map and execute the resulting command.
  //
  while (Error == errOk && !Finished)
  {
    GameMapRec Map;
    unsigned   Format = Flags->Format;

    //
    //   Get the requested map in the local GameMap class instance. First,
    //   check if a modified copy already exists in the store. If not, check
    //   if the map is in the file. If not, create a new one from scratch.
    //
    if (Globals.InStore (Episode*10 + MapNr) )
    {
      Error  = Globals.Copy (&Map, Episode*10 + MapNr);
      Format = Map.Format ();
    }
    else
    {
      if (Globals.MapAvailable (Episode*10 + MapNr) )
      {
        Error = Globals.Load (&Map, Episode*10 + MapNr);
        if (Error == errOk)          Error  = Map.DetermineFormat ();
        if (Format == cUndetermined) Format = Map.Format ();
      }
      else
      {
        if (Globals.MapPossible (Episode*10 + MapNr) )
        {
          char Title [16];
          if (MapNr == 9) sprintf (Title, "Wolf%d Secret", Episode+1);
          if (MapNr == 8) sprintf (Title, "Wolf%d Boss", Episode+1);
          if (MapNr <= 7) sprintf (Title, "Wolf%d Map%d", Episode+1, MapNr+1);

          Error = Map.Create (64, 64, Title);
          if (Format == cUndetermined) Format = cFormat11;
        }
      }
    }

    //
    //   Show the map, modify it and catch the resulting command.
    //
    Changed = cFalse;
    Command = cNone;

    if (Error == errOk) Error = Globals.Compress (&Map, cDecompressed);
    if (Error == errOk) Error = Editor.Display (&Map, Episode, MapNr);
    if (Error == errOk) Error = Editor.Modify (&Map, &Changed, &Command);

    //
    //   Process the resulting command.
    //
    int NewEpisode = Episode;
    int NewMapNr   = MapNr;

    switch (Command)
    {
      case cMap0:        NewMapNr   = 0; break;
      case cMap1:        NewMapNr   = 1; break;
      case cMap2:        NewMapNr   = 2; break;
      case cMap3:        NewMapNr   = 3; break;
      case cMap4:        NewMapNr   = 4; break;
      case cMap5:        NewMapNr   = 5; break;
      case cMap6:        NewMapNr   = 6; break;
      case cMap7:        NewMapNr   = 7; break;
      case cMap8:        NewMapNr   = 8; break;
      case cMap9:        NewMapNr   = 9; break;
      case cNextMap:     NewMapNr   = MapNr == 9 ? 0 : MapNr + 1; break;
      case cPrevMap:     NewMapNr   = MapNr == 0 ? 9 : MapNr - 1; break;
      case cNextEpisode: NewEpisode = Episode == 5 ? 0 : Episode + 1; NewMapNr = 
0; break;
      case cPrevEpisode: NewEpisode = Episode == 0 ? 5 : Episode - 1; NewMapNr = 
0; break;
      case cBreak:
        Changed  = cFalse;
        Finished = cTrue;
        Modified = 0;
        break;
      case cExit:
        Finished = cTrue;
        break;
      case cEscape:
        Changed = cFalse;
        break;
      case cDiscard:
        Error   = Globals.Delete (Episode*10 + MapNr);
        Changed = cFalse;
        break;
    }

    //
    //   If the current map has been modified, compress it again and store it.
    //
    if (Changed)
    {
      if (Error == errOk) Error = Globals.Compress (&Map, Format);
      if (Error == errOk) Error = Globals.Add (&Map, Episode*10 + MapNr);
      Modified = Globals.MapsStored ();
    }

    //
    //   Advance to the selected map / episode.
    //
    Episode = NewEpisode;
    MapNr   = NewMapNr;
  }

  //
  //   Close the editor and redisplay the banner.
  //
  if (Error != errInitializeGraph)
  {
    Editor.Close ();
    ShowBanner ();
  }

  //
  //   Write any changed maps back into the maps files.
  //
  if (Modified != 0)
  {
    //
    //   Open the work files.
    //
    if (Error == errOk && !Created) Error = Globals.OpenWork ();

    MapNr = 0;
    while (Error == errOk && MapNr < Globals.MapCount () )
    {
      GameMapRec Map;

      //
      //   Save and delete the map in the store, if one is available.
      //   Otherwise, copy the map from the origional file unchanged.
      //
      if ( Globals.InStore (MapNr) )
      {
        if (Error == errOk) Error = Globals.Copy (&Map, MapNr);
        if (Error == errOk) Error = Globals.Save (&Map, MapNr);
        if (Error == errOk) Error = Globals.Delete (MapNr);
      }
      else if ( Globals.MapAvailable (MapNr) )
      {
        if (Error == errOk) Error = Globals.Load (&Map, MapNr);
        if (Error == errOk) Error = Globals.Save (&Map, MapNr);
      }

      //
      //   Advance to the next map.
      //
      MapNr++;
    }
  }

  //
  //   Close the maps file.
  //
  if (Error == errOk) Error = Globals.Close ();

  //
  //   Display the number of maps modified if no errors occured. Otherwise,
  //   display the correct error message.
  //
  if (Error == errOk)
  {
    fprintf (stderr, "Modified and saved %d %s.\n", Modified, Modified == 1 ? "map" 
: "maps");
    return cOk;
  }
  else
  {
    Message (Error, 0, cFalse);
    return cError;
  }
}

int main (int argc, char **argv)
{
  //
  //   Display banner on the screen.
  //
  ShowBanner ();

  //
  //   If no arguments are passed on the command line, show a complete
  //   description of this program and exit.
  //
  if (argc == 1)
  {
    ShowHelp ();
    return cNoCommands;
  }

  //
  //   Process the arguments. If an error has been detected, show the
  //   correct usage on the screen and exit.
  //
  FlagsRec Flags;
  int      Command = ProcessParameters (argc, argv, &Flags);

  //
  //   The command line has been processed. Now process the given command.
  //
  switch (Command)
  {
    case cHelp:          return ShowCommands       ();
    case cConvert10:     return ConvertFormat      (&Flags, cFormat10);
    case cConvert11:     return ConvertFormat      (&Flags, cFormat11);
    case cPrintMaps:     return PrintMaps          (&Flags, stdout);
    case cPrintMapStats: return PrintMapStatistics (&Flags, stdout);
    case cPrintLegend:   return PrintLegend        (&Flags, stdout);
    case cDisplayTitles: return DisplayTitles      (&Flags);
    case cDisplayStats:  return DisplayStatistics  (&Flags);
    case cModify:        return ModifyMaps         (&Flags);
    case cExportMaps:    return Export             (&Flags);
    case cImportMaps:    return Import             (&Flags);
    default:             return cIllegalCommand;
  }
}

