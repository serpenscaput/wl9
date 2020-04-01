{$A+,B-,D-,E-,F-,G+,I+,L-,N-,O-,R-,S-,V+,X-}
{$M 16384,0,655360}
unit M_Ed_Objects;
interface
uses Objects, Crt, Graph, M_Ed_Misc;
const
  MAX_OBJ       = $103;
  LEGEND_ENTRYS = 25;
  TEXT_HEIGHT   = 8;
  CELL_SIZE_X   = 7;
  CELL_SIZE_Y   = 7;
  FIELDS_X      = 64;
  FIELDS_Y      = 64;
  CACHE_SIZE    = 4;
  LEGEND_START_X= 460;
  LEGEND_START_Y= 0;
  BUTTON_START_X= LEGEND_START_X;
  CACHE_START_X = LEGEND_START_X;

const
  LEVEL_FILENAME: string[12] = 'LEVEL_?.MAP';
  LEVEL_CHAR_POS = 7;

var
  changed: boolean; { TRUE if anything was changed by user }

type
  TEditMode = (obj_mode, map_mode);
  TElem = ( elem_obj, elem_map );
  TMapElemName = string[20];
  TRect = object (Objects.TRect)
      BkColor,         { Color of button background (default = GetBkColor) }
      Color: word;     { Color of button border (default = GetColor) }
      { overwritten methods }
      procedure Assign( x1, y1, x2, y2: integer);
      { New methods }
      procedure Show( DrawFrame: boolean);
      procedure Clear;
      { Inherited methods :
        Contains    Copy
        Empty       Equals      Grow
        Intersect   Move        Union
      }
    private
    end; { of object( InfoLine ); }
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  TTextRect = object( TRect )
      TextColor: word;        { Color of button text (default = GetColor) }
      TextPos  : TPoint;
      Str: string;
      { overwritten methods }
      procedure Assign( x1, y1, x2, y2: integer; NewTxtPos: TPoint; NewStr: string );
      procedure Show( DrawFrame: boolean);
      procedure Copy( button: TTextRect );
      { New methods }
      function Width: integer;
      function Height: integer;
      { Inherited methods :
        Contains	Empty		Equals		Grow
        Intersect	Move		Union
      }
    private
      TextSettings: TextSettingsType;

    end; { of object TTextRect ); }
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  TButton = object( TTextRect  )
      { Inherited variables
        TextColor: word;
        Str: string;
        private
        TextPos: TPoint;
        TextSettings: TextSettingsType;
      }
      { overwritten methods }
      procedure Assign( x1, y1, x2, y2: integer; NewStr: string );
      { New methods }
      procedure Action;
      procedure ActionIfContains( P: TPoint );
      { Inherited methods :
        Assing		Copy		Contains	Empty
        Equals		Grow		Intersect	Move
        Union    	Width		Height		Show
      }
  end; { of object TButton }

  TCacheEntry = record
    elemtype: TElem;
    elem    : word;
    end; { of record TSelectCacheEntry }
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  TSelectCache = object (TRect)
    { public }
      procedure Init( StartMode: TEditMode );
      procedure Show;
      procedure GetElem( phys: TPoint; var elemtype: TElem; var elem:word );
      procedure AddElem( elemtype: TElem; elem: word );
      { Inherited methods :
        Assing		Copy		Contains	Empty
        Equals		Grow		Intersect	Move
        Union    	Width		Height          Clear
      }
    private
      entry     : array[0..CACHE_SIZE  - 1] of TCacheEntry;
      pos       : word;
      FrameDist : word;
      LineDist  : word;
      Lines     : word;
    end; { of object TLegend }

  TLevelGrid = array[0..FIELDS_X - 1, 0..FIELDS_Y - 1] of word;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  TMapElem = object
      pri_color,
      sec_color,
      graph_t  : byte;
      character: char;
      Number   : word;
      name     : TMapElemName;
      TextColor: word;

      { methods }
      procedure Assign( ElemNumberStr, ElemTypeStr: HexWordStr;
                        ElemName:TMapElemName );
      procedure Show( x, y: integer );
      procedure ShowName( x, y: integer);
      procedure ShowDescription( x, y: integer);
      end; { of object TMapElem }
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  TMap = object( TRect )
    { public }
      Level      : integer;
      MapName    : TTextRect;
      InfoRect   : TRect;
      LevelMap   : TLevelGrid;
      LevelObj   : TLevelGrid;
      EditMode   : TEditMode;
      EditVal    : word;
      ShowFloor  : Boolean;
      ShowObjects: Boolean;
      StopDraw   : Boolean;
      SelectCache: TSelectCache;
      procedure Init;
      procedure Delete;
      procedure ClearField( P: TPoint );
      procedure ResetInfo;
      procedure ClearInfo;
      procedure Show;
      procedure ShowField( P: TPoint );
      procedure ShowInfo( phys: TPoint );
      procedure SetElem( P: TPoint );
      function Contains( P: TPoint): boolean;
      procedure GetCell( var Cell: TPoint; physP: TPoint );
      function GetElem( P: TPoint; elemtype: TElem ): word;
      procedure SetEditVal( NewEdMode: TEditMode; NewElem: word );
      procedure GetEditVal( var NewEdMode: TEditMode; var NewElem: word );
      procedure ToggleFloor;
      procedure ToggleObjects;
      procedure Save( c: char);
      procedure Load( c: char);
    private
      InfoClear: boolean;
      LocInfo: TTextRect;
      LastLoc: TPoint;
      ObjInfo: TTextRect;
      LastObj: word;
      MapInfo: TTextRect;
      LastMap: word;
      FrameDist: word;
    end; { of object TMap }
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}

  TLegend = object( TRect )
    { public }
      procedure Init( StartMode: TEditMode );
      procedure Clear;
      procedure Show;
      procedure Up;
      procedure Down;
      procedure First;
      procedure Last;
      procedure Restore;
      procedure SetMode( NewMode: TEditMode );
      function GetMode: TEditMode;
      function Contains( P: TPoint): boolean;
      function GetElem( phys: TPoint ): word;
    private
      pos       : integer;
      LastPos   : integer;
      Lastmappos: integer;  { Variables to save the last selected }
      Lastobjpos: integer;  { postions when switching the legend }
      LegendMode: TEditMode;
      FrameDist : word;
      LineDist  : word;
      Lines     : word;
    end; { of object TLegend }


var
  MapElem,
  ObjElem : array[0..MAX_OBJ] of TMapElem;

{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
implementation
const
  DEFAULT_FLOOR : word = $8C;
  DEFAULT_WALL  : word = $01;
  DEFAULT_OBJ   : word = $00;

type
  filltype = ( solid , check );
  doortype = ( horiz, vert );

{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
{ functions and procedures used by this unit }

procedure DrawWall( x, y  : integer;
                    c1, c2: word;
                    fill: filltype; dec: boolean);
var i: integer;
{ Draw a Box with pattern fill and decortion if dec = true }
{ If color two is different to color1 draw a cross inside the box of color 2 }
begin
  if fill = solid then
    SetFillstyle( SolidFill, c1 )
  else
    SetFillStyle( InterleaveFill, c1 );
  bar(x, y, x + CELL_SIZE_X - 1, y + CELL_SIZE_Y - 1);
  if dec then
    begin
    SetFillStyle(SolidFill, c2);
    bar(x + 2, y + 2, x + CELL_SIZE_X - 3, y + CELL_SIZE_Y - 3);
    end
  else if (c2 <> c1) then
    PutPixel(x + CELL_SIZE_X div 2, y + CELL_SIZE_Y div 2, c2);

end;

procedure DrawCircle(x, y, c1, c2: integer);
{ Draw a circle a postion (x, y) with inner color c2 and outer color c1 }
const
  HEIGHT_CIRCLE = CELL_SIZE_X;
  WIDTH_CIRCLE = CELL_SIZE_Y;
  sprite : array[0..WIDTH_CIRCLE - 1, 0..HEIGHT_CIRCLE - 1] of byte =
    ((0,0,1,1,1,0,0),
     (0,1,1,1,1,1,0),
     (1,1,1,2,1,1,1),
     (1,1,2,2,2,1,1),
     (1,1,1,2,1,1,1),
     (0,1,1,1,1,1,0),
     (0,0,1,1,1,0,0));
var
  i, j, c: integer;
begin
{  for i:= 0 to 6 do
    begin
    _y:= y;
    for j:= 0 to 6 do
      begin
        case sprite[i,j] of
          1: putpixel( x, _y, c1 );
          2: putpixel( x, _y, c2 );
        end;
        inc( _y );
      end;
      inc( x );
    end;              }
  asm
        mov     bx, [x];
        mov     dx, [y];
        mov     ax, ds
        mov     es, ax
        mov     ax, seg(sprite);
        mov     ds, ax;
        sub     ax, ax;
        mov     si, offset(sprite);
        mov     cx, HEIGHT_CIRCLE;
        cld
    @@loop1:
        push    cx;
        mov     cx, WIDTH_CIRCLE;
        push    dx
    @@loop2:
        push    cx
        lodsb
        or      al,al
        jz      @@dontputpixel
        pusha
        push    ds
        push    es
        push    es
        pop     ds
        push    bx
        push    dx
        cmp     al,2
        jne     @@color1
        push    [c2]
        jmp     @@doput
    @@color1:
        push    [c1]
    @@doput:
        call    putpixel
        pop     es
        pop     ds
        popa
    @@dontputpixel:
        inc     dx
        pop     cx;
        loop    @@loop2;
        pop     dx
        inc     bx
        pop     cx;
        loop    @@loop1;
    end;
end;

procedure DrawDoor(x, y, color: integer; dtype: doortype);
begin
  setfillstyle(1,color);
  case dtype of
    vert : bar(x + 2, y, x + CELL_SIZE_X - 3, y + CELL_SIZE_Y - 1);
    horiz: bar(x, y + 2, x + CELL_SIZE_X - 1 ,y + CELL_SIZE_Y - 3 );
  end;
end;

{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
{ methods of TMapElem }

procedure TMapElem.Assign( ElemNumberStr, ElemTypeStr: HexWordStr;
                           ElemName:TMapElemName );
begin
Number:= HexWordStr2Word( ElemNumberStr );
pri_color:= HexChar2Byte( ElemTypeStr[1] );
sec_color:= HexChar2Byte( ElemTypeStr[2] );
TextColor:= GetColor;
graph_t:= HexChar2Byte( ElemTypeStr[3] );
character:= ElemTypeStr[4];
Name:= ElemName;
end;

procedure TMapElem.Show( x, y: integer);
var
  size  : integer;
  i     : word;
begin
if (pri_color = 0) and (sec_color = 0) then exit;
case graph_t of
   0: begin
      SetColor( pri_color);
      OutTextXY(x, y, character);
      end;
   1: DrawWall(x, y, pri_color, sec_color, solid, false);
   2: DrawWall(x, y, pri_color, sec_color, check, false);
   3: DrawWall(x, y, pri_color, sec_color, solid, true);
   4: DrawWall(x, y, pri_color, sec_color, check, true);
   5: DrawCircle (x,y, pri_color, sec_color);
   6: DrawDoor(x, y, pri_color, horiz);
   7: DrawDoor(x, y, pri_color, vert);
   8: begin
      setfillstyle(SolidFill, pri_color);
      bar(x, y, x + CELL_SIZE_X - 1, y + 3);
      setfillstyle(SolidFill, sec_color);
      bar(x, y + 4, x + CELL_SIZE_X - 1, y + CELL_SIZE_Y - 1);
      end;
   9: putpixel(x + CELL_SIZE_X div 2, y + CELL_SIZE_Y div 2, pri_color);
  10: begin
      setfillstyle(SolidFill, pri_color);
      bar(x + 2,y + 1, x + CELL_SIZE_X - 3, y + CELL_SIZE_Y - 2 );
      end;
  11: begin
      setfillstyle(SolidFill, pri_color);
      bar(x + 2, y + 2, x + CELL_SIZE_X - 3 , y + CELL_SIZE_Y - 3 );
      end;
  12: begin
      setfillstyle( 1, pri_color );
      bar(x + 1, y + 1, x + CELL_SIZE_X - 2 , y + CELL_SIZE_Y - 2 );
      end;
  13: begin
      setcolor( pri_color );
      SetLineStyle( SolidLn, 0 , NormWidth );
      line(x + 1, y + 1, x + CELL_SIZE_X - 2, y + CELL_SIZE_Y - 2);
      line(x + CELL_SIZE_X - 2, y + 1, x + 1, y + CELL_SIZE_Y - 2);
      end;
  14: begin
      SetColor( pri_color );
      SetLineStyle( SolidLn, 0 , NormWidth );
      Rectangle( x, y, x + CELL_SIZE_X - 1, y + CELL_SIZE_Y - 1);
      end;
  15: begin
      SetColor( pri_color );
      SetLineStyle( SolidLn, 0 , NormWidth );
      case sec_color of
        2: begin {east}
           line(x, y + 3, x + 6,y + 3);
           line(x+6,y+3,x+3,y);
           line(x+6,y+3,x+3,y+6);
          end;
        0: begin {north}
             setcolor(pri_color);
             line(x+3,y+6,x+3,y);
             line(x+3,y,x,y+3);
             line(x+3,y,x+6,y+3);
           end;
        6: begin {west}
             setcolor(pri_color);
             line(x+6,y+3,x,y+3);
             line(x,y+3,x+3,y);
             line(x,y+3,x+3,y+6);
           end;
        4: begin {south}
             setcolor(pri_color);
             line(x+3,y,x+3,y+6);
             line(x+3,y+6,x,y+3);
             line(x+3,y+6,x+6,y+3);
           end;
        1: begin {northeast}
             setcolor(pri_color);
             line(x,y+6,x+6,y);
             line(x+6,y,x+3,y);
             line(x+6,y,x+6,y+3);
           end;
        7: begin {northwest}
             setcolor(pri_color);
             line(x+6,y+6,x,y);
             line(x,y,x+3,y);
             line(x,y,x,y+3);
           end;
        3: begin {southeast}
             setcolor(pri_color);
             line(x,y,x+6,y+6);
             line(x+6,y+6,x+3,y+6);
             line(x+6,y+6,x+6,y+3);
           end;
        5: begin {southwest}
           setcolor(pri_color);
           line(x+6,y,x,y+6);
           line(x,y+6,x+3,y+6);
           line(x,y+6,x,y+3);
           end;
        end; { of case of seccolor }
      end; { of case graph_t = 15 }
  end; { of case of graph_t }
end;

procedure TMapElem.ShowName( x, y: integer);
begin
SetColor( TextColor );
OutTextXY( x, y, Name );
end;

procedure TMapElem.ShowDescription( x, y: integer);
begin
Show( x, y );
inc(x, CELL_SIZE_X * 2);
ShowName( x, y );
end;

{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
{ methods of TRect }
procedure TRect.Assign( x1, y1, x2, y2: integer);
begin
Objects.TRect.Assign( x1, y1, x2, y2 );
Color:= GetColor;
BkColor:= GetBkColor;
end;

procedure TRect.Clear;
begin
SetFillStyle( SolidFill, BkColor );
bar(A.X, A.Y, B.X, B.Y);
end;

procedure TRect.Show( DrawFrame: boolean );
var
  i: word;
begin
if not empty then
  begin
  Clear;
  if DrawFrame then
    begin
    SetColor( Color );
    Rectangle( A.X, A.Y, B.X, B.Y );
    end;
  end;
end;

{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
{ methods of TTextRect }

procedure TTextRect.Assign( x1, y1, x2, y2: integer; NewTxtPos: TPoint; NewStr: string );
begin
Str:= NewStr;
TextColor:= GetColor;
GetTextSettings( TextSettings );
TRect.Assign( x1, y1, x2, y2 );
with TextPos do
  begin
  X:= NewTxtPos.X;
  Y:= NewTxtPos.Y;
  if X < 0 then x:= 0;
  if Y < 0 then y:= 0;
  end;
end;

procedure TTextRect.Copy( button: TTextRect );
begin
TRect.Copy( button );
button.Str:= Str;
end;

function TTextRect.Width: integer;
begin
width:= B.X - A.X + 1;
end;

function TTextRect.Height: integer;
begin
height:= B.Y - A.Y + 1;
end;


procedure TTextRect.Show( DrawFrame: boolean );
begin
TRect.Show( DrawFrame );
SetColor( TextColor );
With TextSettings do
  SetTextStyle( Font, Direction, CharSize );
OutTextXY(A.X + TextPos.X, A.Y + TextPos.Y, Str );
end;

{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
{ methods of TButton }

procedure TButton.Assign( x1, y1, x2, y2: integer; NewStr: string );
var
  TxtPos: TPoint;
begin
Str:= NewStr;
if x2 <= x1 then
  x2:= x1 + TextWidth(Str) + 8;
if y2 <= y1 then
  y2:= y1 + TextHeight(Str) + 10;
with TxtPos do
  begin
  X:= (x2 - x1 - TextWidth(Str)) div 2 + 1;
  Y:= (y2 - y1 - TextHeight(Str)) div 2 + 1;
  if X < 0 then x:= 0;
  if Y < 0 then y:= 0;
  end;
TTextRect.Assign( x1, y1, x2, y2, TxtPos, Str );
end;
procedure TButton.Action;
begin
end;

procedure TButton.ActionIfContains( P: TPoint );
begin
if Contains( P ) then Action;
end;

{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
{ methods of TMap }

procedure TMap.Init;
const
  DummyTxt = '(XX,XX)';
  NullLoc: TPoint = (X:0; Y:0);
var
  width: word;
begin
Color:= GetColor;
BkColor:= GetBkColor;
FrameDist:= 4;
ShowFloor:= FALSE;
ShowObjects:= TRUE;
InfoClear:= TRUE;
LastLoc.X:= -1;
LastLoc.Y:= -1;
LastObj:= $FFFF;
LastMap:= $FFFF;
EditMode:= Obj_Mode;
if EditMode = Obj_Mode then
  EditVal:= DEFAULT_OBJ
else
  EditVal:= DEFAULT_FLOOR;
Assign( 0, 0, FIELDS_X * CELL_SIZE_X + FrameDist * 2 - 1,
        FIELDS_Y * CELL_SIZE_Y + FrameDist * 2 - 1);
InfoRect.Assign( 120, B.Y + 4, B.X, GetMaxY );
width:= TextWidth( DummyTxt );
MapName.Assign(FrameDist, B.Y + 4, 104, B.Y + 12, NullLoc, '');
LocInfo.Assign(120, B.Y + 4, 120 + width, B.Y + 12, NullLoc, '');
ObjInfo.Assign(120 + width + 10, B.Y + 4, B.X - FrameDist, B.Y + 12, NullLoc, '');
MapInfo.Assign(120 + width + 10, B.Y + 14, B.X - FrameDist, B.Y + 22, NullLoc, '');
SelectCache.Init(EditMode);
end;

procedure TMap.Show;
var
  i, j: word;
  Last_Map,
  Last_Obj: word;
  index: word;
  x, y: integer;
  xsav: integer;
begin
TRect.Clear;
MapName.Show( FALSE );
Last_Map:= $FFFF;
Last_Obj:= $FFFF;
xsav:= A.X + FrameDist;
y:= A.Y + FrameDist + (FIELDS_Y * CELL_SIZE_Y);
StopDraw:= FALSE;
for j:= FIELDS_Y - 1 downto 0 do
  begin
  dec(y, CELL_SIZE_Y);
  x:= xsav;
  if keypressed or StopDraw then exit;
  for i:= 0 to FIELDS_X - 1 do
    begin
    index:= LevelMap[i,j];
    if not (index in [$6a..$8f]) or ShowFloor then
      MapElem[index].Show(x, y);
    index:= LevelObj[i,j];
    if (index <> 0) and ShowObjects then
      ObjElem[index].Show(x, y);
    inc(x, CELL_SIZE_X);
    end; { of for i }
  end; { of for j }
end; { of proc TMap.Show }

procedure TMap.ShowField( P: TPoint );
var
  x, y: integer;
begin
x:= A.X + FrameDist + P.X * CELL_SIZE_X;
y:= A.Y + FrameDist + P.Y * CELL_SIZE_Y;
if ShowFloor then
  MapElem[LevelMap[P.X, P.Y]].Show(x, y)
else if not (levelmap[P.X, P.Y] in [$6a..$8f]) then
  MapElem[LevelMap[P.X, P.Y]].Show(x, y);
if ShowObjects then
  ObjElem[LevelObj[P.X, P.Y]].Show(x, y);
end; { of proc TMap.ShowField }

procedure TMap.ClearInfo;
begin
InfoRect.Clear;
end;

procedure TMap.ShowInfo( phys: TPoint );
var
  NewObj,
  NewMap: word;
  XStr: string[2];
  YStr: string[2];
  maploc: TPoint;
begin
GetCell( maploc, phys );
NewObj:= GetElem(maploc, elem_obj);
NewMap:= GetElem(maploc, elem_map);
InfoClear:= FALSE;
if (maploc.X <> LastLoc.X) or (maploc.Y <> LastLoc.Y) then
  begin
  LastLoc:= maploc;
  Str(maploc.X:2, XStr);
  Str(maploc.Y:2, YStr);
  LocInfo.Str:= '(' + XStr + ',' + YStr + ')';
  LocInfo.Show( FALSE ) ;
  end;
if (NewObj <> LastObj) then
  begin
  LastObj:= NewObj;
  ObjInfo.Str:= 'obj: ' + Word2HexWordStr( NewObj ) + ' - ' + ObjElem[NewObj].Name;
  ObjInfo.Show( FALSE );
  end;
if (NewMap <> LastMap) then
  begin
  LastMap:= NewMap;
  MapInfo.Str:= 'map: ' + Word2HexWordStr( NewMap ) + ' - ' + MapElem[NewMap].Name;
  MapInfo.Show( FALSE );
  end;
end;


procedure TMap.ClearField( P: TPoint);
var
  x, y: integer;
begin
x:= A.X + FrameDist + P.X * CELL_SIZE_X;
y:= A.Y + FrameDist + P.Y * CELL_SIZE_Y;
setfillstyle(1,0);
bar(x, y, x + CELL_SIZE_X - 1, y + CELL_SIZE_Y - 1 );
end; { of proc TMap.ClearField }

procedure TMap.Delete;
var
  x, y: integer;
begin
{
for x:= 0 to FIELDS_X - 2 do
  begin
  for y:= 1 to FIELDS_Y - 2 do
    begin
    levelmap[x,y]:= DEFAULT_FLOOR;
    levelobj[x,y]:= DEFAULT_OBJ;
    end;
  dec(y);
  levelmap[x,0]:= DEFAULT_WALL;
  levelmap[x,FIELDS_Y - 1]:= DEFAULT_WALL;
  levelmap[0,x]:= DEFAULT_WALL;
  levelmap[FIELDS_X - 1, x]:= DEFAULT_WALL;
  end;
}
fillword(LevelMap[0,0], FIELDS_X * FIELDS_Y, DEFAULT_FLOOR );
fillword(LevelObj[0,0], FIELDS_X * FIELDS_Y, DEFAULT_OBJ);
fillword(LevelMap[0,0], FIELDS_Y , DEFAULT_WALL);
fillword(LevelMap[FIELDS_X - 1,0], FIELDS_Y, DEFAULT_WALL );
for x:= 1 to FIELDS_X - 2 do
  begin
  levelmap[x,0]:= DEFAULT_WALL;
  levelmap[x,FIELDS_Y - 1]:= DEFAULT_WALL;
  end;
ResetInfo;
Show;
end; { of TMap.Delete }

procedure TMap.ResetInfo;
begin
if not InfoClear then
  begin
  InfoClear:= TRUE;
  InfoRect.Clear;
  LastLoc.X:= -1;
  LastLoc.Y:= -1;
  LastObj:= $FFFF;
  LastMap:= $FFFF;
  end;
end;

procedure TMap.SetElem( P: TPoint );
begin
if GetElem( P, TElem(EditMode) ) <> EditVal then
  begin
  changed:= TRUE;
  if EditMode = Obj_Mode then
     levelobj[P.x, P.y]:= EditVal
  else
     levelmap[P.x, P.y]:= EditVal;
  ClearField( P );
  ShowField( P );
  end;
end;


function TMap.Contains( P: TPoint ): boolean;
begin
Contains:= (P.X >= A.X + framedist) and (P.X < B.X - framedist) and
           (P.Y >= A.Y + framedist) and (P.Y < B.Y - framedist);
end;

procedure TMap.GetCell( var Cell: TPoint; physP: TPoint );
begin
if Contains( physP ) then
  begin
  Cell.X:= (physP.X - A.X - FrameDist) div CELL_SIZE_X;
  Cell.Y:= (physP.Y - A.Y - FrameDist) div CELL_SIZE_Y;
  end
else
  begin
  Cell.X:= -1;
  Cell.Y:= -1;
  end;
end;

function TMap.GetElem( P: TPoint; elemtype: TElem ): word;
begin
if elemtype = elem_obj then
  GetElem:= LevelObj[P.X, P.Y]
else
  GetElem:= LevelMap[P.X, P.Y]
end;

procedure TMap.SetEditVal( NewEdMode: TEditMode; NewElem: word );
begin
EditMode:= NewEdMode;
EditVal:= NewElem;
SelectCache.AddElem(TElem(EditMode), NewElem);
end;

procedure TMap.GetEditVal( var NewEdMode: TEditMode; var NewElem: word );
begin
NewElem:= EditVal;
NewEdMode:= EditMode;
end;

procedure TMap.ToggleFloor;
begin
showfloor:= not showfloor;
show
end;

procedure TMap.ToggleObjects;
begin
showobjects:= not showobjects;
show
end;


procedure TMap.Save( c: char );
var
  x: integer;
  f: file;
begin
LEVEL_FILENAME[LEVEL_CHAR_POS]:= c;
system.assign(f, LEVEL_FILENAME);
{$I-}
rewrite(f, sizeof(word));
if ioresult <> 0 then exit;
{$I+}
if ioresult <> 0 then exit;
blockwrite(f, LevelMap[0, 0], FIELDS_X * FIELDS_Y);
blockwrite(f, LevelObj[0, 0], FIELDS_X * FIELDS_Y);
close(f);
end;

procedure TMap.Load( c: char );
var
  x: integer;
  f: file;
begin
LEVEL_FILENAME[LEVEL_CHAR_POS]:= c;
system.assign(f, LEVEL_FILENAME);
{$I-}
reset(f, sizeof(word));
if ioresult <> 0 then exit;
{$I+}
changed:= true;
blockread(f, LevelMap[0, 0], FIELDS_X * FIELDS_Y);
blockread(f, LevelObj[0, 0], FIELDS_X * FIELDS_Y);
close(f);
ResetInfo;
Show;
end;


{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
{ methods of TLegend }

procedure TLegend.Init( StartMode: TEditMode );
begin
Color:= GetColor;
BkColor:= GetBkColor;
LegendMode:= StartMode;
FrameDist:= 4;
LineDist:= 14;
Lines:= LEGEND_ENTRYS;
Assign( LEGEND_START_X, LEGEND_START_Y,
        GetMaxX,  Lines * LineDist + FrameDist * 2 - LineDist + TEXT_HEIGHT);
LastPos:= 0;
LastMapPos:= 0;
LastObjPos:= 0;
LegendMode:= obj_mode;
pos:= 0;
end;

procedure TLegend.Clear;
begin
SetFillStyle( SolidFill, BkColor);
bar( A.X + FrameDist, A.Y + FrameDist, B.X - FrameDist, B.Y - FrameDist );
end;

procedure TLegend.Show;
var
  i: word;
  x, y: integer;
begin
TRect.Show( TRUE );
x:= A.X + FrameDist;
y:= A.Y + FrameDist;

if LegendMode = obj_mode then
  begin
  for i:= 0 to  Lines - 1 do
    begin
    ObjElem[pos + i].ShowDescription(x, y);
    inc(y, LineDist);
    end;
  end
else
  for i:= 0 to  Lines - 1 do
    begin
    MapElem[pos + i].ShowDescription(x, y);
    inc(y, LineDist);
    end;
end;

procedure TLegend.Up;
begin
if pos > 0 then
  begin
  dec( pos, Lines );
  if pos < 0 then pos:= 0;
  Show;
  end;
end;

procedure TLegend.Down;
begin
if pos < MAX_OBJ - Lines + 1 then
  begin
  inc( pos, Lines );
  if pos > MAX_OBJ - Lines + 1 then pos:= MAX_OBJ - Lines + 1;
  Show;
  end;
end;

procedure TLegend.First;
begin
if pos > 0 then
  begin
  LastPos:= pos;
  pos:= 0;
  Show;
  end;
end;

procedure TLegend.Last;
begin
if pos < MAX_OBJ - Lines + 1 then
  begin
  LastPos:= pos;
  pos:= MAX_OBJ - Lines + 1;
  Show;
  end;
end;

procedure TLegend.Restore;
var
  dummy: integer;
begin
if pos <> LastPos then
  begin
  dummy:= pos;
  pos:= LastPos;
  LastPos:= dummy;
  Show;
  end;
end;

procedure TLegend.SetMode( NewMode: TEditMode );
begin
if NewMode <> LegendMode then
  begin
  if LegendMode = obj_mode
  then begin LastObjPos:= pos; pos:= LastMapPos; end
  else begin LastMapPos:= pos; pos:= LastObjPos; end;
  LegendMode:= NewMode;
  Show;
  end;
end;

function TLegend.GetMode: TEditMode;
begin
GetMode:= LegendMode;
end;

function TLegend.Contains( P: TPoint): boolean;
begin
Contains:= (P.X >= A.X + framedist) and (P.X <= B.X - framedist - 1) and
           (P.Y >= A.Y - framedist) and (P.Y <= B.Y - framedist - 1);
end;

function TLegend.GetElem( phys: TPoint ): word;
begin
if Contains( phys )
then GetElem:= pos + (phys.Y - A.Y ) div LineDist
else GetElem:= 0;
end;

{ methods of TSelectCache }

procedure TSelectCache.Init( StartMode: TEditMode );
var
  i: integer;
begin
Lines:= CACHE_SIZE;
LineDist:= 14;
FrameDist:= 4;
pos:= 0;
Assign( CACHE_START_X, GetMaxY - Lines * LineDist - 1, GetMaxX,  GetMaxY);
if StartMode = obj_mode then
  for i:= 0 to Lines - 1 do
    begin
    entry[i].elemtype:= elem_obj;
    entry[i].elem:= DEFAULT_OBJ;
    end
else
  for i:= 1 to 4 do
    begin
    entry[i].elemtype:= elem_map;
    entry[i].elem:= DEFAULT_FLOOR;
    end;
end;

procedure TSelectCache.Show;
var
  i: word;
  x, y: integer;
begin
x:= A.X + Framedist;
y:= A.Y + Framedist;
Clear;
for i:= 0 to Lines - 1 do
  begin
  if entry[i].elemtype = elem_obj then
    ObjElem[entry[i].elem].ShowDescription(x, y)
  else
    MapElem[entry[i].elem].ShowDescription(x, y);
  inc(y, LineDist);
  end;
y:= A.Y + pos * Linedist;
Rectangle(A.X, y, B.X, y + TEXT_HEIGHT + FrameDist * 2 - 1);
end;

procedure TSelectCache.GetElem( phys: TPoint; var elemtype: TElem; var elem:word );
var
  i: word;
begin
if Contains( phys ) then
  begin
  i:= (phys.Y - A.Y - FrameDist) div LineDist;
  elemtype:= entry[i].elemtype;
  elem:= entry[i].elem;
  end
else
  begin
  end
end;

procedure TSelectCache.AddElem( elemtype: TElem; elem: word );
var
  i : integer;
  f : boolean;
begin
f:= FALSE;
i:= 0;
while not f and (i < CACHE_SIZE) do
  begin
  f:= (elemtype = entry[i].elemtype) and (elem = entry[i].elem);
  inc(i);
  end;
if f then
  begin
  if pos <> i - 1 then
    begin
    pos:= i - 1;
    show;
    end
  end
else
  begin
  for i:= CACHE_SIZE -  1 downto 1 do
    begin
    entry[i].elemtype:= entry[i - 1].elemtype;
    entry[i].elem:= entry[i - 1].elem;
    end;
  entry[0].elemtype:= elemtype;
  entry[0].elem:= elem;
  pos:= 0;
  Show;
  end;
end;


end.