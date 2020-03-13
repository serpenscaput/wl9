/*

---------------------------------------------------------------------------
| Graph class                  |    (c) Oct 1992 Sysma Automatisering     |
---------------------------------------------------------------------------
| Version 1.0         12/10/92 | First implementation.                    |
|                              | J.P. Dijkstra, M.Sc.                     |
| Version 1.01        15/10/92 | Updated the editor so that when the      |
|                              | mouse cursor is moved out and back in    |
|                              | the map area during drawing (ie. button  |
|                              | pressed), the drawing state remains      |
|                              | active.                                  |
|                              | J.P. Dijkstra, M.Sc.                     |
|--------------------------------------------------------------------------
| The Graph class contains the entire graphical map viewer/editor. The    |
| display look is based upon the MapEdit program, written by Bill Kirby.  |
| The implementation, however, is entirely revamped to take full          |
| of the other classes already implemented in the WolfMap program. This   |
| class, however, still uses the same format for the definition files as  |
| the MapEdit program does.
---------------------------------------------------------------------------

*/

#include "wolfmap.h"
#include "stdio.h"
#include "alloc.h"
#include "string.h"
#include "graphics.h"
#include "bios.h"

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

//
//   General purpose local definitions.
//
const int cSolid      = 0;
const int cCheckered  = 1;
const int cHorizontal = cTrue;
const int cVertical   = cFalse;

//
//   Coordinates of various display areas during editing.
//
const int Offset   = 5;
const int CellSize = 7;

const int StartMazeX   = 0;
const int StartMazeY   = 0;
const int EndMazeX     = StartMazeX + 64*CellSize + 2*Offset - 1;
const int EndMazeY     = StartMazeY + 64*CellSize + 2*Offset - 1;
const int StartLegendX = 462;
const int StartLegendY = 0;
const int EndLegendX   = 639;
const int EndLegendY   = 408;
const int StartMapX    = StartLegendX + 2;
const int EndMapX      = StartLegendX + 44;
const int StartObjX    = StartLegendX + 47;
const int EndObjX      = StartLegendX + 84;
const int StartUpX     = StartLegendX + 87;
const int EndUpX       = StartLegendX + 114;
const int StartDownX   = StartLegendX + 117;
const int EndDownX     = EndLegendX   - 2;
const int StartChoiseY = 2;
const int EndChoiseY   = 25;
const int StartChoiseX = StartLegendX + 2;
const int EndChoiseX   = EndLegendX   - 2;
const int StartCommY   = EndLegendY   - 25;
const int EndCommY     = EndLegendY   - 2;
const int StartLevelX  = StartLegendX + 2;
const int EndLevelX    = EndLegendX   - 2;
const int StartLevelY  = EndLegendY   + 1;
const int EndLevelY    = EndMazeY     - 2;

/*

---------------------------------------------------------------------------
| Local functions to implement elementary operations.                     |
---------------------------------------------------------------------------
| Function name               | Description.                              |
---------------------------------------------------------------------------

*/

static int MouseReset ()
{
  //
  //   Reset the mouse and return the number of buttons. After the reset,
  //   the mouse cursor is hidden.
  //
  asm xor ax, ax;
  asm int 0x33;

  return _AX != 0 ? _BX : 0;
}

static void MouseShow ()
{
  //
  //   Show the mouse cursor.
  //
  asm mov ax, 1;
  asm int 0x33;
}

static void MouseHide ()
{
  //
  //   Hide the mouse cursor.
  //
  asm mov ax, 2;
  asm int 0x33;
}

static void MousePos (int *PosX, int *PosY, unsigned *Buttons)
{
  //
  //   Determine and return the current mouse position and button states.
  //
  int      StoreX;
  int      StoreY;
  unsigned StoreButtons;

  asm mov ax, 3;
  asm int 0x33;
  asm mov StoreX, cx;
  asm mov StoreY, dx;
  asm mov StoreButtons, bx;

  *PosX    = StoreX;
  *PosY    = StoreY;
  *Buttons = StoreButtons;
}

static int HexValue (char Value)
{
  //
  //   Convert the character to it's hex value equivalent.
  //
  if (Value >= '0' && Value <= '9') return Value - '0';
  if (Value >= 'a' && Value <= 'f') return Value - 'a' + 10;
  if (Value >= 'A' && Value <= 'F') return Value - 'A' + 10;

  return 0;
}

static int InRange (int x, int y, int x1, int y1, int x2, int y2)
{
  //
  //   Return true if the given (x,y) coordinates are within the specified
  //   area, false otherwise.
  //
  if (x < x1 || x > x2) return cFalse;
  if (y < y1 || y > y2) return cFalse;

  return cTrue;
}

static unsigned Min (unsigned First, unsigned Second)
{
  return First <= Second ? First : Second;
}

static void Dot (int DotSize, int x, int y, int Color)
{
  x = x * CellSize + StartMazeX + Offset;
  y = y * CellSize + StartMazeY + Offset;
  setfillstyle (SOLID_FILL, Color);

  //
  //   Place a dot of the requested size.
  //
  switch (DotSize)
  {
    case 1:
      putpixel (x + 3, y + 3, Color);
      break;
    case 2:
      bar (x + 2, y + 2, x + 4, y + 4);
      break;
    case 3:
      bar (x + 1, y + 1, x + 5, y + 5);
      break;
    case 4:
      bar (x, y, x + 6, y + 6);
      break;
  }
}

static void Box (int FillType, int x, int y, int Color)
{
  x = x * CellSize + StartMazeX + Offset;
  y = y * CellSize + StartMazeY + Offset;

  //
  //   Draw a box in the cell, using the specified style.
  //
  setfillstyle (FillType == cSolid ? SOLID_FILL : INTERLEAVE_FILL, Color);
  bar (x, y, x + 6, y + 6);
}

static void SplitBox (int x, int y, int UpperColor, int LowerColor)
{
  x = x * CellSize + StartMazeX + Offset;
  y = y * CellSize + StartMazeY + Offset;

  //
  //   Draw the upper part of the box in the cell.
  //
  setfillstyle (SOLID_FILL, UpperColor);
  bar (x, y, x + 6, y + 3);

  //
  //   Now draw the lower part of the box in the cell.
  //
  setfillstyle (SOLID_FILL, LowerColor);
  bar (x, y + 4, x + 6, y + 6);
}

static void Circle (int x, int y, int OuterColor, int InnerColor)
{
  x = x * CellSize + StartMazeX + Offset;
  y = y * CellSize + StartMazeY + Offset;
  setcolor (OuterColor);
  setfillstyle (SOLID_FILL, OuterColor);

  //
  //   Draw a solid circle. Since it is a small cell we are talking about,
  //   we draw the circle as a series of lines in the cell.
  //
  line (x + 2, y,     x + 4, y);
  line (x + 1, y + 1, x + 5, y + 1);
  bar  (x    , y + 2, x + 6, y + 4);
  line (x + 1, y + 5, x + 5, y + 5);
  line (x + 2, y + 6, x + 4, y + 6);

  //
  //   If we need an inner circle, draw it also as a series of lines.
  //
  if (OuterColor != InnerColor)
  {
    setcolor (InnerColor);
    putpixel (x + 3, y + 2, InnerColor);
    line     (x + 2, y + 3, x + 4, y + 3);
    putpixel (x + 3, y + 4, InnerColor);
  }
}

static void Door (int Horizontal, int x, int y, int Color)
{
  x = x * CellSize + StartMazeX + Offset;
  y = y * CellSize + StartMazeY + Offset;
  setfillstyle (SOLID_FILL, Color);

  //
  //   Draw a horizontal or vertical door.
  //
  if (Horizontal)
  {
    bar (x, y + 2, x + 6, y + 4);
  }
  else
  {
    bar (x + 2, y, x + 4, y + 6);
  }
}

static void Cross (int x, int y, int Color)
{
  x = x * CellSize + StartMazeX + Offset;
  y = y * CellSize + StartMazeY + Offset;
  setcolor (Color);

  //
  //   Draw two crossed lines in the given color.
  //
  line (x + 1, y + 1, x + 5, y + 5);
  line (x + 5, y + 1, x + 1, y + 5);
}

static void Rectangle (int x, int y, int Color)
{
  x = x * CellSize + StartMazeX + Offset;
  y = y * CellSize + StartMazeY + Offset;
  setcolor (Color);

  //
  //   Draw a rectangle around the edges of the cell in the given color.
  //
  rectangle (x, y, x + 6, y + 6);
}

static void Arrow (int Direction, int x, int y, int Color)
{
  x = x * CellSize + StartMazeX + Offset;
  y = y * CellSize + StartMazeY + Offset;
  setcolor (Color);

  //
  //   Draw the arrow as a series of three lines.
  //
  switch (Direction)
  {
    case 0:
      line (x + 3, y + 6, x + 3, y);
      line (x + 3, y,     x,     y + 3);
      line (x + 3, y,     x + 6, y + 3);
      break;
    case 1:
      line (x,     y + 6, x + 6, y);
      line (x + 6, y,     x + 3, y);
      line (x + 6, y,     x + 6, y + 3);
      break;
    case 2:
      line (x,     y + 3, x + 6, y + 3);
      line (x + 6, y + 3, x + 3, y);
      line (x + 6, y + 3, x + 3, y + 6);
      break;
    case 3:
      line (x,     y,     x + 6, y + 6);
      line (x + 6, y + 6, x + 3, y + 6);
      line (x + 6, y + 6, x + 6, y + 3);
      break;
    case 4:
      line (x + 3, y,     x + 3, y + 6);
      line (x + 3, y + 6, x,     y + 3);
      line (x + 3, y + 6, x + 6, y + 3);
      break;
    case 5:
      line (x + 6, y,     x,     y + 6);
      line (x,     y + 6, x + 3, y + 6);
      line (x,     y + 6, x,     y + 3);
      break;
    case 6:
      line (x + 6, y + 3, x,     y + 3);
      line (x,     y + 3, x + 3, y);
      line (x,     y + 3, x + 3, y + 6);
      break;
    case 7:
      line (x + 6, y + 6, x,     y);
      line (x,     y,     x + 3, y);
      line (x,     y,     x,     y + 3);
      break;
  }
}

static void Text (int x, int y, int Color, char *Text)
{
  x = x * CellSize + StartMazeX + Offset;
  y = y * CellSize + StartMazeY + Offset;
  setcolor (Color);

  //
  //   Display the text in the cell.
  //
  outtextxy (x, y, Text);
}

static void Cell (int x, int y, LegendRec *Legend)
{
  //
  //   If no legend entry is specified, output a black box.
  //
  if (Legend == NULL)
  {
    Box (cSolid, x, y, 0);
    return;
  }

  //
  //   At this point a representation is specified. Now figure out how to
  //   draw the cell and do it.
  //
  int OuterColor = HexValue (Legend->Representation [0]);
  int InnerColor = HexValue (Legend->Representation [1]);

  switch (Legend->Representation [2])
  {
    case '0':
      Text (x, y, OuterColor, Legend->Representation+3);
      break;
    case '1':
      Box (cSolid, x, y, OuterColor);
      break;
    case '2':
      Box (cCheckered, x, y, OuterColor);
      break;
    case '3':
      Box (cSolid, x, y, OuterColor);
      Dot (2, x, y, InnerColor);
      break;
    case '4':
      Box (cCheckered, x, y, OuterColor);
      Dot (2, x, y, InnerColor);
      break;
    case '5':
      Circle (x, y, OuterColor, InnerColor);
      break;
    case '6':
      Door (cHorizontal, x, y, OuterColor);
      break;
    case '7':
      Door (cVertical, x, y, OuterColor);
      break;
    case '8':
      SplitBox (x, y, OuterColor, InnerColor);
      break;
    case '9':
      Dot (1, x, y, OuterColor);
      break;
    case 'a':
      Dot (2, x, y, OuterColor);
      break;
    case 'b':
      Dot (3, x, y, OuterColor);
      break;
    case 'c':
      Dot (4, x, y, OuterColor);
      break;
    case 'd':
      Cross (x, y, OuterColor);
      break;
    case 'e':
      Rectangle (x, y, OuterColor);
      break;
    case 'f':
//      Arrow (HexValue (Legend->Representation [3]), x, y, OuterColor);
      Arrow (InnerColor, x, y, OuterColor);
      break;
  }
}

static void ClearLine (int Line)
{
  setfillstyle (SOLID_FILL, 0);
  bar (StartMazeX + Offset, Line, EndMazeX - Offset, Line + 7);
}

static void LegendLine (int y, LegendRec **LegendList, unsigned Value)
{
  char Buffer [30];

  //
  //   Place the legend and determine the legend text. When a NULL pointer
  //   has been supplied, make a default text.
  //
  if (LegendList [Value] == NULL)
  {
    sprintf (Buffer, " - Unknown %04X", Value);
  }
  else
  {
    sprintf (Buffer, " - %s", LegendList [Value]->Name);
    Cell (66, y, LegendList [Value]);
  }

  //
  //   Place the legend text.
  //
  Text (67, y, 15, Buffer);
}

static void DisplayLegend (LegendRec **LegendList, unsigned First, unsigned Last)

{
  //
  //   Erase the legend list.
  //
  setfillstyle (SOLID_FILL, 0);
  bar (StartLegendX + 2, EndChoiseY + 3, EndLegendX - 2, StartCommY - 3);

  //
  //   Display the legend, one line at a time.
  //
  unsigned Line = 4;

  while (First <= Last)
  {
    LegendLine (Line, LegendList, First);
    First++;
    Line += 2;
  }
}

static void DisplayChoise (LegendRec **LegendList, unsigned Value)
{
  //
  //   Erase any previous legend.
  //
  setfillstyle (SOLID_FILL, 0);
  bar (StartChoiseX, StartChoiseY, EndChoiseX, EndChoiseY);

  //
  //   Place the legend in the choise area.
  //
  LegendLine (1, LegendList, Value);
}

static void CellPosition (int Line, int x, int y)
{
  //
  //   Erase the old position information.
  //
  setfillstyle (SOLID_FILL, 0);
  bar (StartMazeX + Offset, Line, StartMazeX + Offset + 49, Line + 7);

  //
  //   Write the new position information.
  //
  char Buffer [30];
  setcolor (15);
  sprintf (Buffer, "(%02d,%02d)", x, y);
  outtextxy (StartMazeX + Offset, Line, Buffer);
}

static void LegendInfo (int Line, unsigned Value, LegendRec *Legend, char *Leader)

{
  //
  //   Erase the old legend information.
  //
  setfillstyle (SOLID_FILL, 0);
  bar (StartMazeX + Offset + 80, Line, EndMazeX - Offset, Line + 7);

  //
  //   Write the new legend information.
  //
  char Buffer [50];
  setcolor (15);
  sprintf (Buffer, "%s %04X - %s", Leader, Value, Legend == NULL ? "Unknown" : Legend->Name);

  outtextxy (StartMazeX + Offset + 80, Line, Buffer);
}

static int LoadLegend (char *DefFile, unsigned MaxLegends, LegendRec **Legends)
{
  //
  //   Try opening the specified definition file. Return an error
  //   immediately upon failure.
  //
  FILE *Stream = fopen (DefFile, "r");
  if (Stream == NULL) return errNoDefFile;

  char     Name [25];
  char     Repr [5];
  unsigned Value;
  int      Error  = errOk;

  //
  //   Read every line from the file, one line at a time.
  //
  while (Error == errOk && !feof (Stream) )
  {
    char Buffer [80];

    //
    //   Read and process the line if the line is not empty.
    //
    if (fgets (Buffer, 79, Stream) != NULL && *Buffer != '\0')
    {
      int Result = sscanf (Buffer, "%4x %4s %24[ -9A-Za-z]", &Value, &Repr, &Name);


      //
      //   Store the result if the line contained the correct components.
      //
      if (Result == 3 && Value < MaxLegends)
      {
        Legends [Value] = (LegendRec *) malloc ( sizeof (LegendRec) );
        if (Legends [Value] != NULL)
        {
          strcpy (Legends [Value]->Representation, Repr);
          strcpy (Legends [Value]->Name, Name);
        }
        else
        {
          Error = errNoMemory;
        }
      }
      else
      {
        Error = errIllegalLegend;
      }
    }
  }

  //
  //   Close the definition file and return the error state.
  //
  fclose (Stream);
  return Error;
}

/*

---------------------------------------------------------------------------
| Public functions to implement the desired API.                          |
---------------------------------------------------------------------------
| Function name               | Description.                              |
---------------------------------------------------------------------------

*/

GraphRec::GraphRec ()
{
  //
  //   Initialize the private fields.
  //
  Maze         = NULL;
  Objects      = NULL;
  MazeChoise   = 0;
  ObjectChoise = 0;
  Legend       = cMazeLegend;
  ChoiseLegend = cMazeLegend;
  MazeFirst    = 0;
  ObjectsFirst = 0;
  ShowFloors   = cFalse;
  ShowObjects  = cTrue;
  SizeX        = 0;
  SizeY        = 0;
  StartTextY   = 0;
}

GraphRec::~GraphRec ()
{
  Close ();
}

int GraphRec::Open ()
{
  //
  //   Allocate memory for the pointers to the individual legend records.
  //
  Maze    = (LegendRec **) calloc (cMaxMazeLegends, sizeof (LegendRec) );
  Objects = (LegendRec **) calloc (cMaxObjectLegends, sizeof (LegendRec) );

  int Error = Maze != NULL && Objects != NULL ? errOk : errNoMemory;

  //
  //   Try loading the legends from the definition files.
  //
  if (Error == errOk) Error = LoadLegend ("mapdata.def", cMaxMazeLegends, Maze);

  if (Error == errOk) Error = LoadLegend ("objdata.def", cMaxObjectLegends, Objects);


  //
  //   For display or editing we use the VGA 640x480 screen mode. Normally,
  //   this should not cause any problems, since Wolf3D itself also requires
  //   a VGA system.
  //
  if (Error == errOk)
  {
    int GraphDevice = VGA;
    int GraphMode   = VGAHI;

    initgraph (&GraphDevice, &GraphMode, "");
    if (GraphDevice != VGA) Error = errInitializeGraph;
  }

  //
  //   If the graphics device has been opened, draw the legend on the
  //   screen.
  //
  if (Error == errOk)
  {
    //
    //   Initialize the mouse and place the button texts.
    //
    MouseReset ();
    setcolor (15);
    settextstyle (DEFAULT_FONT, HORIZ_DIR, 1);
    outtextxy (StartMapX + 12, StartCommY + 9, "MAP  OBJ  UP  DOWN");

    //
    //   Draw the borders around the legend and the buttons.
    //
    setcolor (7);
    rectangle (StartLegendX, StartLegendY, EndLegendX, EndLegendY);
    rectangle (StartLegendX + 1, StartLegendY + 1, EndLegendX - 1, EndLegendY - 1);

    line (StartLegendX + 2, StartCommY - 2, EndLegendX - 2, StartCommY - 2);
    line (StartLegendX + 2, StartCommY - 1, EndLegendX - 2, StartCommY - 1);
    line (StartLegendX + 2, EndChoiseY + 1, EndLegendX - 2, EndChoiseY + 1);
    line (StartLegendX + 2, EndChoiseY + 2, EndLegendX - 2, EndChoiseY + 2);

    line (EndMapX    + 1, StartCommY, EndMapX    + 1, EndCommY);
    line (StartObjX  - 1, StartCommY, StartObjX  - 1, EndCommY);
    line (EndObjX    + 1, StartCommY, EndObjX    + 1, EndCommY);
    line (StartUpX   - 1, StartCommY, StartUpX   - 1, EndCommY);
    line (EndUpX     + 1, StartCommY, EndUpX     + 1, EndCommY);
    line (StartDownX - 1, StartCommY, StartDownX - 1, EndCommY);

    //
    //   Now place the initial legend list and choise in the proper boxes.
    //
    DisplayMazeLegend ();
    DisplayChoise (Maze, MazeChoise);
  }

  //
  //   Return the error state.
  //
  return Error;
}

int GraphRec::Close ()
{
  //
  //   Close the graphics screen and restore the origional screen mode.
  //
  closegraph ();

  //
  //   Deallocate any maze legends.
  //
  if (Maze != NULL)
  {
    int Count = 0;
    while (Count < cMaxMazeLegends)
    {
      if (Maze [Count] != NULL) free (Maze [Count]);
      Count++;
    }

    free (Maze);
    Maze = NULL;
  }

  //
  //   Deallocate any object legends.
  //
  if (Objects != NULL)
  {
    int Count = 0;
    while (Count < cMaxObjectLegends)
    {
      if (Objects [Count] != NULL) free (Objects [Count]);
      Count++;
    }

    free (Objects);
    Objects = NULL;
  }

  //
  //   Return Ok to indicate success.
  //
  return errOk;
}

void GraphRec::DisplayCell (int x, int y, unsigned MazeValue, unsigned ObjectValue)

{
  //
  //   Output the maze representation of this cell.
  //
  if (MazeValue != 0 && (ShowFloors || DetermineMaze (MazeValue) != mFloor))
  {
    Cell (x, y, Maze [MazeValue]);
  }

  //
  //   Output the object representation of this cell.
  //
  if (ObjectValue != 0 && (ShowObjects || DetermineObject (ObjectValue) == oSecretDoor))

  {
    Cell (x, y, Objects [ObjectValue]);
  }
}

void GraphRec::DisplayMap (GameMapRec *Map)
{
  //
  //   Erase the old map.
  //
  int InnerStartX = StartMazeX + 2;
  int InnerStartY = StartMazeY + 2;
  int InnerEndX   = StartMazeX + SizeX*CellSize + 2*Offset - 3;
  int InnerEndY   = StartMazeY + SizeY*CellSize + 2*Offset - 3;

  setfillstyle (SOLID_FILL, 0);
  bar (InnerStartX, InnerStartY, InnerEndX, InnerEndY);

  //
  //   Initialize the pointers.
  //
  unsigned *MazePtr   = Map->MazeBlock ();
  unsigned *ObjectPtr = Map->ObjectsBlock ();
  unsigned  PosY      = 0;

  //
  //   Walk the entire maze, one row at a time.
  //
  while (PosY < SizeY)
  {
    //
    //   Walk every cell in a row, one cell at a time.
    //
    unsigned PosX = 0;

    while (PosX < SizeX)
    {
      DisplayCell (PosX++, PosY, *(MazePtr++), *(ObjectPtr++));
    }

    //
    //   Advance to the next row.
    //
    PosY++;
  }
}

void GraphRec::DisplayMazeLegend ()
{
  DisplayLegend (Maze, MazeFirst, Min (MazeFirst+cMaxDisplayLegend, cMaxMazeLegends)-1);

}

void GraphRec::DisplayObjectLegend ()
{
  DisplayLegend (Objects, ObjectsFirst, Min (ObjectsFirst+cMaxDisplayLegend, cMaxObjectLegends)-1);

}

int GraphRec::DetermineArea (int x, int y, int *ResultX, int *ResultY)
{
  //
  //   Determine if the area is one of the four buttons.
  //
  if ( InRange (x, y, StartMapX,  StartCommY, EndMapX,  EndCommY) ) return aMapButton;

  if ( InRange (x, y, StartObjX,  StartCommY, EndObjX,  EndCommY) ) return aObjectButton;

  if ( InRange (x, y, StartUpX,   StartCommY, EndUpX,   EndCommY) ) return aUpButton;

  if ( InRange (x, y, StartDownX, StartCommY, EndDownX, EndCommY) ) return aDownButton;


  //
  //   Determine if the area is the map itself. If so, calculate the cell
  //   coordinates.
  //
  int x1 = StartMazeX + Offset;
  int y1 = StartMazeY + Offset;
  int x2 = x1 + SizeX * CellSize - 1;
  int y2 = y1 + SizeY * CellSize - 1;

  if ( InRange (x, y, x1, y1, x2, y2) )
  {
    *ResultX = (x - x1) / CellSize;
    *ResultY = (y - y1) / CellSize;
    return aMap;
  }

  //
  //   Determine if the area is the legend list. If so, calculate the line
  //   number.
  //
  x1 = StartLegendX + 2;
  y1 = EndChoiseY   + 3;
  x2 = EndLegendX   - 2;
  y2 = StartCommY   - 3;

  if ( InRange (x, y, x1, y1, x2, y2) )
  {
    int Line = (y - (StartMazeY+Offset)) / CellSize;

    if (Line >= 4 && (Line & 1) == 0)
    {
      *ResultY = (Line - 4) >> 1;
      return aLegend;
    }
  }

  //
  //  At this point no legal area has been recognized, so return None.
  //
  return aNone;
}

int GraphRec::Display (GameMapRec *Map, int EpisodeNr, int MapNr)
{
  //
  //   If the sizes are different from the stored sizes, we have to (re)draw
  //   our map border.
  //
  if (Map->MazeSizeX () != SizeX || Map->MazeSizeY () == SizeY)
  {
    setfillstyle (SOLID_FILL, 0);
    setcolor (7);

    //
    //   Calculate the new map area and use these figures to draw the
    //   rectangle and to erase any surplus areas.
    //
    int InnerStartX = StartMazeX + 2;
    int InnerStartY = StartMazeY + 2;
    int InnerEndX   = StartMazeX + Map->MazeSizeX ()*CellSize + 2*Offset - 3;
    int InnerEndY   = StartMazeY + Map->MazeSizeY ()*CellSize + 2*Offset - 3;

    //
    //   First draw the new border.
    //
    rectangle (InnerStartX - 2, InnerStartY - 2, InnerEndX + 2, InnerEndY + 2);
    rectangle (InnerStartX - 1, InnerStartY - 1, InnerEndX + 1, InnerEndY + 1);

    //
    //   Next, check if we have some erasing to do. This is the case if the
    //   old sizes were larger than the new ones.
    //
    if (SizeX < Map->MazeSizeX () )
    {
      bar (InnerEndX + 3, StartMazeY, EndMazeX, EndMazeY);
    }

    if (SizeY < Map->MazeSizeY () )
    {
      bar (StartMazeX, InnerEndY + 3, EndMazeX, EndMazeY);
    }

    //
    //   Finally, store the new sizes for future use.
    //
    SizeX      = Map->MazeSizeX ();
    SizeY      = Map->MazeSizeY ();
    StartTextY = StartMazeY + SizeY*CellSize + 2*Offset + 2;
  }

  //
  //   Display the current episode and map numbers, and the map title.
  //
  char Buffer [30];
  setfillstyle (SOLID_FILL, 0);
  bar (StartLevelX, StartLevelY, EndLevelX, EndLevelY);

  sprintf (Buffer, "Episode: %d", EpisodeNr+1);
  Text (66, 59, 15, Buffer);

  sprintf (Buffer, "Level:   %d", MapNr);
  Text (66, 61, 15, Buffer);

  Text (66, 63, 15, Map->Title () );

  //
  //   Now display the map itself.
  //
  DisplayMap (Map);

  //
  //   Return Ok to indicate success.
  //
  return errOk;
}

int GraphRec::Modify (GameMapRec *Map, int *Changed, int *Command)
{
  //
  //   Initialize tracking information.
  //
  unsigned OldObject = 0;
  unsigned OldMaze   = 0;
  int      OldX      = 0;
  int      OldY      = 0;
  int      OldArea   = aNone;
  int      Drawing   = cFalse;

  //
  //   Reset the change indicator.
  //
  *Changed = cFalse;
  *Command = cNone;

  //
  //   Process mouse actions and key strokes until the editing of this map
  //   is finished.
  //
  MouseShow ();
  while (*Command == cNone)
  {
    //
    //   Process mouse actions.
    //
    unsigned Buttons;
    int      PosX;
    int      PosY;
    MousePos (&PosX, &PosY, &Buttons);

    //
    //   Determine the current area the mouse is in and calculate the
    //   logical coordinates within that area, if needed.
    //
    int ResultX;
    int ResultY;
    int Area = DetermineArea (PosX, PosY, &ResultX, &ResultY);

    //
    //   Display cell information, if the mouse is inside the maze display.
    //   Otherwise, remove the cell information.
    //
    if (Area == aMap)
    {
      //
      //   Retrieve the maze/object values for the current cell.
      //
      unsigned MazeValue   = Map->MazeBlock ()    [ResultY*SizeX + ResultX];
      unsigned ObjectValue = Map->ObjectsBlock () [ResultY*SizeX + ResultX];

      //
      //   Only process if there are changes.
      //
      if (Area != OldArea || ResultX != OldX || ResultY != OldY || MazeValue != OldMaze 
|| ObjectValue != OldObject)
      {
        MouseHide ();

        //
        //   Show current position.
        //
        if (Area != OldArea || ResultX != OldX || ResultY != OldY)
        {
          CellPosition (StartTextY, ResultX, ResultY);
          OldX = ResultX;
          OldY = ResultY;
        }

        //
        //   Show maze legend of current cell.
        //
        if (Area != OldArea || OldMaze != MazeValue)
        {
          LegendInfo (StartTextY, MazeValue, Maze [MazeValue], "Map:   ");
          OldMaze = MazeValue;
        }

        //
        //   Show object legend of current cell.
        //
        if (Area != OldArea || OldObject != ObjectValue)
        {
          LegendInfo (StartTextY + 10, ObjectValue, Objects [ObjectValue], "Object:");

          OldObject = ObjectValue;
        }

        MouseShow ();
      }
    }
    else
    {
      //
      //   Since the mouse is outside the maze area, hide the information.
      //
      if (OldArea == aMap)
      {
        MouseHide ();
        ClearLine (StartTextY);
        ClearLine (StartTextY + 10);
        MouseShow ();
      }
    }
    OldArea = Area;

    //
    //   Process the area if a mouse button has been pressed.
    //
    if (Buttons != 0 && !Drawing)
    {
      //
      //   First wait the buttons to get released, but only if we don't have
      //   a button press inside the map area. This enables drag and fill.
      //
      if (Area != aMap && !Drawing)
      {
        while (Buttons != 0) MousePos (&PosX, &PosY, &Buttons);
      }

      //
      //   Now process the area, which can be interpreted as a command.
      //
      if (Area != aNone)
      {
        switch (Area)
        {
          case aMapButton:
            if (Legend != cMazeLegend)
            {
              MouseHide ();
              DisplayMazeLegend ();
              Legend = cMazeLegend;
              MouseShow ();
            }
            break;

          case aObjectButton:
            if (Legend != cObjectLegend)
            {
              MouseHide ();
              DisplayObjectLegend ();
              Legend = cObjectLegend;
              MouseShow ();
            }
            break;

          case aUpButton:
            MouseHide ();
            if (Legend == cMazeLegend)
            {
              if (MazeFirst > 0)
              {
                MazeFirst -= cMaxDisplayLegend;
                DisplayMazeLegend ();
              }
            }
            else
            {
              if (ObjectsFirst > 0)
              {
                ObjectsFirst -= cMaxDisplayLegend;
                DisplayObjectLegend ();
              }
            }
            MouseShow ();
            break;

          case aDownButton:
            MouseHide ();
            if (Legend == cMazeLegend)
            {
              if (MazeFirst+cMaxDisplayLegend < cMaxMazeLegends)
              {
                MazeFirst += cMaxDisplayLegend;
                DisplayMazeLegend ();
              }
            }
            else
            {
              if (ObjectsFirst+cMaxDisplayLegend < cMaxObjectLegends)
              {
                ObjectsFirst += cMaxDisplayLegend;
                DisplayObjectLegend ();
              }
            }
            MouseShow ();
            break;

          case aLegend:
            MouseHide ();
            if (Legend == cMazeLegend)
            {
              MazeChoise   = ResultY + MazeFirst;
              ChoiseLegend = cMazeLegend;
              DisplayChoise (Maze, MazeChoise);
            }
            else
            {
              ObjectChoise = ResultY + ObjectsFirst;
              ChoiseLegend = cObjectLegend;
              DisplayChoise (Objects, ObjectChoise);
            }
            MouseShow ();
            break;

          case aMap:
            Drawing = cTrue;
            break;
        }
      }
    }

    //
    //   Cancel the drawing state when the mouse buttons are released.
    //
    if (Buttons == 0)
    {
      Drawing = cFalse;
    }

    //
    //   If we are drawing inside the map area, update the current cell to
    //   the selected legend value.
    //
    if (Drawing && Area == aMap)
    {
      //
      //   Determine the pointers to the current maze / object value in the
      //   current cell.
      //
      unsigned *MazePtr = Map->MazeBlock ()    + ResultY*SizeX + ResultX;
      unsigned *ObjPtr  = Map->ObjectsBlock () + ResultY*SizeX + ResultX;

      //
      //   If a maze legend value is selected, update the maze. Otherwise
      //   update the object value of the current cell.
      //
      if (ChoiseLegend == cMazeLegend)
      {
        if (*MazePtr != MazeChoise)
        {
          MouseHide ();
          *MazePtr = MazeChoise;
          Box (cSolid, ResultX, ResultY, 0);
          DisplayCell (ResultX, ResultY, *MazePtr, *ObjPtr);
          *Changed = cTrue;
          MouseShow ();
        }
      }
      else
      {
        if (*ObjPtr != ObjectChoise)
        {
          MouseHide ();
          *ObjPtr = ObjectChoise;
          Box (cSolid, ResultX, ResultY, 0);
          DisplayCell (ResultX, ResultY, *MazePtr, *ObjPtr);
          *Changed = cTrue;
          MouseShow ();
        }
      }
    }

    //
    //   Process key strokes.
    //
    int Key = bioskey (1);
    if (Key != 0 && Key != -1)
    {
      Key = bioskey (0);
      switch (Key & 0x00FF)
      {
        case '0': *Command = cMap0; break;
        case '1': *Command = cMap1; break;
        case '2': *Command = cMap2; break;
        case '3': *Command = cMap3; break;
        case '4': *Command = cMap4; break;
        case '5': *Command = cMap5; break;
        case '6': *Command = cMap6; break;
        case '7': *Command = cMap7; break;
        case '8': *Command = cMap8; break;
        case '9': *Command = cMap9; break;
        case 'D': *Command = cDiscard; break;
        case 'S': *Command = cStore; break;
        case 'e': *Command = cExit; break;
        case 'q': *Command = cBreak; break;
        case 27:  *Command = cEscape; break;
        case 'f':
          ShowFloors = !ShowFloors;
          MouseHide ();
          DisplayMap (Map);
          MouseShow ();
          break;
        case 'o':
          ShowObjects = !ShowObjects;
          MouseHide ();
          DisplayMap (Map);
          MouseShow ();
          break;
        case 'C':
          Map->Clear ();
          *Changed = cTrue;
          MouseHide ();
          DisplayMap (Map);
          MouseShow ();
          break;
        case 0:
          switch (Key >> 8)
          {
            case 77: *Command = cNextMap; break;
            case 75: *Command = cPrevMap; break;
            case 73: *Command = cNextEpisode; break;
            case 81: *Command = cPrevEpisode; break;
          }
          break;
      }
    }
    else
    {
      if (Key == -1) *Command = cBreak;
    }
  }
  MouseHide ();
  ClearLine (StartTextY);
  ClearLine (StartTextY + 10);

  //
  //   Return Ok to indicate success.
  //
  return errOk;
}

