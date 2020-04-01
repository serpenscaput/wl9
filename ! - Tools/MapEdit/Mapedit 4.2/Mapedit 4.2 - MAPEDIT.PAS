{
     MapEdit 4.2 written 9/93 by Ralf Seidel
     Original Code by Bill Kirby
     Version 4.2
}
{$A+,B-,D-,E-,F-,G+,I+,L-,N-,O-,R-,S-,V+,X-}
{$M $8000,0,655360}
program mapedit;

uses crt, dos, graph, objects, M_Ed_Objects, M_Ed_Misc, mouse;

const
  BUTTON_LOC   : TPoint = (x: BUTTON_START_X; y: 355);
  GAMEPATH     : string = '.\';
  HEADFILENAME : string = 'maphead';
  MAPFILENAME  : string = 'maptemp';
  LEVELS       : word   = 10;
  BGI_PATH     = '\tp\bgi';
  TEXT_COLOR   = WHITE;
  BK_COLOR     = BLACK;
  MAX_LEVELS   = 60;
  FIELDS_X     = 64;
  FIELDS_Y     = 64;
  GAME_VERSION : real   = 1.0;

type data_block = record
       size : word;
       data : pointer;
     end;

     level_type = record
       map,
       objects,
       other           : data_block;
       width,
       height          : word;
       name            : string[16];
     end;


var
  loadbutton,
  savebutton,
  rectbutton,
  quitbutton,
  objbutton,
  floorbutton,
  fillbutton,
  clearbutton,
  legendbutton,
  upbutton,
  downbutton,
  firstbutton,
  lastbutton,
  backbutton  : TButton;
  legend      : TLegend;
  map         : TMap;
  mloc: TPoint;
  maploc: TPoint;
  maps         : array[1..MAX_LEVELS] of level_type;

    themouse  : resetrec;
    mouseloc  : locrec;


{$L VGABGI.OBJ}
procedure VGA_BgiDriver; external;


procedure read_levels;
var headfile,
    mapfile  : file;
    s, o,
    size     : word;
    idsig    : string[4];
    level    : integer;
    levelptr : longint;
    tempstr  : string[16];
    map_pointer,
    object_pointer,
    other_pointer    : longint;

begin
  idsig:= '    ';
  tempstr:= '                ';
  assign(headfile,GAMEPATH+HEADFILENAME);
  {$I-}
  reset(headfile,1);
  {$I+}
  if ioresult<>0 then
    begin
      writeln('error opening ',HEADFILENAME);
      halt(1);
    end;
  assign(mapfile,GAMEPATH+MAPFILENAME);
  {$I-}
  reset(mapfile,1);
  {$I+}
  if ioresult<>0 then
    begin
      writeln('error opening ',MAPFILENAME);
      halt(1);
    end;

  for level:= 1 to LEVELS do
    begin
      seek(headfile,2+(level-1)*4);
      blockread(headfile,levelptr,4);
      seek(mapfile,levelptr);
      with maps[level] do
        begin
          blockread(mapfile,map_pointer,4);
          blockread(mapfile,object_pointer,4);
          blockread(mapfile,other_pointer,4);
          blockread(mapfile,map.size,2);
          blockread(mapfile,objects.size,2);
          blockread(mapfile,other.size,2);
          blockread(mapfile,width,2);
          blockread(mapfile,height,2);
          name[0]:=#16;
          blockread(mapfile,name[1],16);
          if GAME_VERSION = 1.1 then
            blockread(mapfile,idsig[1],4);

          seek(mapfile,map_pointer);
          getmem(map.data,map.size);
          s:= seg(map.data^);
          o:= ofs(map.data^);
          blockread(mapfile,mem[s:o],map.size);

          seek(mapfile,object_pointer);
          getmem(objects.data,objects.size);
          s:= seg(objects.data^);
          o:= ofs(objects.data^);
          blockread(mapfile,mem[s:o],objects.size);

          seek(mapfile,other_pointer);
          getmem(other.data,other.size);
          s:= seg(other.data^);
          o:= ofs(other.data^);
          blockread(mapfile,mem[s:o],other.size);
          if GAME_VERSION = 1.0 then
            blockread(mapfile,idsig[1],4);
        end;
    end;
  close(mapfile);
  close(headfile);
end;

procedure write_levels;
var headfile,
    mapfile    : file;
    abcd,
    s,o,
    size     : word;
    idsig    : string[4];
    level    : integer;
    levelptr : longint;
    tempstr  : string[16];
    map_pointer,
    object_pointer,
    other_pointer    : longint;

begin
  abcd:= $abcd;
  idsig:= '!ID!';
  tempstr:= 'TED5v1.0';
  assign(headfile,GAMEPATH+HEADFILENAME);
  rewrite(headfile,1);
  assign(mapfile,GAMEPATH+MAPFILENAME);
  rewrite(mapfile,1);

  blockwrite(headfile,abcd,2);
  blockwrite(mapfile,tempstr[1],8);
  levelptr:= 8;

  for level:= 1 to LEVELS do
    begin
      with maps[level] do
        begin
          if GAME_VERSION = 1.1 then
            begin
              map_pointer:= levelptr;
              s:= seg(map.data^);
              o:= ofs(map.data^);
              blockwrite(mapfile,mem[s:o],map.size);
              inc(levelptr,map.size);

              object_pointer:= levelptr;
              s:= seg(objects.data^);
              o:= ofs(objects.data^);
              blockwrite(mapfile,mem[s:o],objects.size);
              inc(levelptr,objects.size);

              other_pointer:= levelptr;
              s:= seg(other.data^);
              o:= ofs(other.data^);
              blockwrite(mapfile,mem[s:o],other.size);
              inc(levelptr,other.size);

              blockwrite(headfile,levelptr,4);

              blockwrite(mapfile,map_pointer,4);
              blockwrite(mapfile,object_pointer,4);
              blockwrite(mapfile,other_pointer,4);
              blockwrite(mapfile,map.size,2);
              blockwrite(mapfile,objects.size,2);
              blockwrite(mapfile,other.size,2);
              blockwrite(mapfile,width,2);
              blockwrite(mapfile,height,2);
              name[0]:=#16;
              blockwrite(mapfile,name[1],16);
              inc(levelptr,38);
            end
          else
            begin
              blockwrite(headfile,levelptr,4);
              map_pointer:= levelptr+38;
              object_pointer:= map_pointer+map.size;
              other_pointer:= object_pointer+objects.size;

              blockwrite(mapfile,map_pointer,4);
              blockwrite(mapfile,object_pointer,4);
              blockwrite(mapfile,other_pointer,4);
              blockwrite(mapfile,map.size,2);
              blockwrite(mapfile,objects.size,2);
              blockwrite(mapfile,other.size,2);
              blockwrite(mapfile,width,2);
              blockwrite(mapfile,height,2);
              name[0]:=#16;
              blockwrite(mapfile,name[1],16);

              s:= seg(map.data^);
              o:= ofs(map.data^);
              blockwrite(mapfile,mem[s:o],map.size);
              s:= seg(objects.data^);
              o:= ofs(objects.data^);
              blockwrite(mapfile,mem[s:o],objects.size);
              s:= seg(other.data^);
              o:= ofs(other.data^);
              blockwrite(mapfile,mem[s:o],other.size);
              inc(levelptr,map.size+objects.size+other.size+38);
            end;
          blockwrite(mapfile,idsig[1],4);
          inc(levelptr,4);
        end;
    end;
  close(mapfile);
  close(headfile);
end;

procedure a7a8_expand(src: data_block; var dest: data_block);
var s,o,
    s2,o2,
    index,
    index2,
    size,
    length,
    data,
    newsize  : word;
    goback1  : byte;
    goback2  : word;
    i        : integer;

begin
  s:=seg(src.data^);
  o:=ofs(src.data^);
  index:=0;
  move(mem[s:o+index],dest.size,2); inc(index,2);
  getmem(dest.data,dest.size);
  s2:=seg(dest.data^);
  o2:=ofs(dest.data^);
  index2:=0;

  repeat
    move(mem[s:o+index],data,2); inc(index,2);
    case hi(data) of
      $a7: begin
             length:=lo(data);
             move(mem[s:o+index],goback1,1); inc(index,1);
             move(mem[s2:o2+index2-goback1*2],mem[s2:o2+index2],length*2);
             inc(index2,length*2);
           end;
      $a8: begin
             length:=lo(data);
             move(mem[s:o+index],goback2,2); inc(index,2);
             move(mem[s2:o2+goback2*2],mem[s2:o2+index2],length*2);
             inc(index2,length*2);
           end;
      else begin
             move(data,mem[s2:o2+index2],2);
             inc(index2,2);
           end;
    end;
  until index=src.size;
end;

procedure expand(d: data_block; var g: TLevelGrid);
var i,x,y : integer;
    s,o,
    data,
    count : word;
    temp  : data_block;
begin
  if GAME_VERSION = 1.1 then
    a7a8_expand(d,temp)
  else
    temp:=d;

  x:= 0;
  y:= 0;
  s:= seg(temp.data^);
  o:= ofs(temp.data^);
  inc(o,2);
  while (y<64) do
    begin
      move(mem[s:o],data,2); inc(o,2);
      if data=$abcd then
        begin
          move(mem[s:o],count,2); inc(o,2);
          move(mem[s:o],data,2); inc(o,2);
          for i:= 1 to count do
            begin
              g[x,y]:= data;
              inc(x);
              if x=64 then
                begin
                  x:= 0;
                  inc(y);
                end;
            end;
        end
      else
        begin
          g[x,y]:= data;
          inc(x);
          if x=64 then
            begin
              x:= 0;
              inc(y);
            end;
        end;
    end;
  if GAME_VERSION=1.1 then
    freemem(temp.data,temp.size);
end;

procedure compress(g: TLevelGrid; var d: data_block);
var temp     : pointer;
    size: word;
    abcd,
    s,o,
    olddata,
    data,
    nextdata,
    count    : word;
    x,y,i    : integer;
    temp2    : pointer;

begin
  abcd:= $abcd;
  x:= 0;
  y:= 0;
  getmem(temp,8194);
  s:= seg(temp^);
  o:= ofs(temp^);
  data:= $2000;
  move(data,mem[s:o],2);

  size:= 2;
  data:= g[0,0];
  while (y < 64) do
    begin
      count:= 1;
      repeat
        inc(x);
        if x = 64 then
          begin
            x:=0;
            inc(y);
          end;
        if y < 64 then
          nextdata:= g[x,y];
        inc(count);
      until (nextdata <> data) or (y=64);
      dec(count);
      if count<3 then
        begin
          for i:= 1 to count do
            begin
              move(data,mem[s:o+size],2);
              inc(size,2);
            end;
        end
      else
        begin
          move(abcd,mem[s:o+size],2);
          inc(size,2);
          move(count,mem[s:o+size],2);
          inc(size,2);
          move(data,mem[s:o+size],2);
          inc(size,2);
        end;
      data:= nextdata;
    end;
  getmem(temp2,size);
  move(temp^,temp2^,size);
  freemem(temp,8194);
  if GAME_VERSION = 1.1 then
    begin
      getmem(temp,size+2);
      s:= seg(temp^);
      o:= ofs(temp^);
      move(size,mem[s:o],2);
      move(temp2^,mem[s:o+2],size);
      d.data:=temp;
      d.size:= size+2;
      freemem(temp2,size);
    end
  else
    begin
      d.data:= temp2;
      d.size:= size;
    end;
end;

procedure wait_for_mouserelease;
begin
  repeat
    mpos(mouseloc);
  until mouseloc.buttonstatus=0;
end;

procedure initialize;
var i, dummy: integer;
    infile: text;

    path : pathstr;
    dir  : dirstr;
    name : namestr;
    ext  : extstr;
    filename  : string;
    hexstr    : string[4];
    graphstr  : string[4];
    name20    : string[20];
    junk      : char;
    search    : searchrec;

begin
map.level:= 1;
if paramcount > 0 then
  begin
  val( paramstr(paramcount), map.level, dummy);
  if dummy <> 0
  then map.level:= 1
  else inc(map.level);
  end;
filename:= GAMEPATH + HEADFILENAME + '.*';
findfirst(filename,$ff,search);
if doserror <> 0 then
  begin
    CloseGraph;
    writeln('Error opening ',HEADFILENAME,' file.');
    writeln;
    writeln('Be sure that you installed MAPEDIT in the directory where');
    writeln('Wolfenstein 3-D is installed.');
    halt(0);
  end
else
  begin
    filename:= search.name;
    fsplit(filename,dir,name,ext);
    HEADFILENAME:= upper(HEADFILENAME+ext);
    if upper(ext)='.WL1' then
      begin
        LEVELS:=10;
        GAME_VERSION:=1.0;
        MAPFILENAME:='MAPTEMP'+ext;
        filename:=GAMEPATH+'MAPTEMP'+ext;
        findfirst(filename,$ff,search);
        if doserror<>0 then
          begin
            GAME_VERSION:=1.1;
            MAPFILENAME:='GAMEMAPS'+ext;
            filename:=GAMEPATH+'GAMEMAPS'+ext;
            findfirst(filename,$ff,search);
            if doserror<>0 then
              begin
              CloseGraph;
              writeln('Error opening GAMEMAPS or MAPTEMP file.');
              halt(0);
              end;
          end;
      end;
    if (upper(ext)='.WL3') or (upper(ext)='.WL6') then
      begin
        GAME_VERSION:=1.1;
        if upper(ext)='.WL3' then
          LEVELS:= 30
        else
          LEVELS:= MAX_LEVELS;
        MAPFILENAME:='GAMEMAPS'+ext;
        filename:=GAMEPATH+'GAMEMAPS'+ext;
        findfirst(filename,$ff,search);
        if doserror<>0 then
          begin
          CloseGraph;
          writeln('Error opening GAMEMAPS file.');
          halt(0);
          end;
      end;
  end;
read_levels;

assign(infile,'mapdata.def');
reset(infile);
while not eof(infile) do
  begin
  readln(infile,hexstr,junk,graphstr,junk,name20);
  MapElem[HexWordStr2Word(hexstr)].Assign(hexstr, graphstr, name20);
  end;
close(infile);

assign(infile,'objdata.def');
reset(infile);
while not eof(infile) do
  begin
    readln(infile, hexstr, junk, graphstr, junk, name20);
    ObjElem[HexWordStr2Word(hexstr)].Assign(hexstr, graphstr, name20);
  end;
close(infile);
expand(maps[map.level].map,map.LevelMap);
expand(maps[map.level].objects,map.LevelObj);
map.MapName.Str:= maps[map.level].name;
end;


procedure SetNewLevel( newlevel: integer );
begin
freemem(maps[map.level].map.data,maps[map.level].map.size);
freemem(maps[map.level].objects.data,maps[map.level].objects.size);
compress(map.levelmap,maps[map.level].map);
compress(map.levelobj,maps[map.level].objects);
if (newlevel) > LEVELS then dec(newlevel, LEVELS);
if (newlevel) < 1 then inc(newlevel,LEVELS);
map.level:= newlevel;
expand(maps[map.level].map,map.LevelMap);
expand(maps[map.level].objects,map.LevelObj);
map.MapName.Str:= maps[map.level].name;
mhide;
map.show;
mshow;
end;

procedure Fill( Start: TPoint );
var
  NewFloor, OldFloor: word;

  procedure FillLine( start_x, start_y: integer );
  var
    P: Tpoint;
    first,
    last: integer;
  begin
  P.X:= start_x;
  P.y:= start_y;
  while (P.X < FIELDS_X) and (map.LevelMap[P.X, P.y] = OldFloor)  do
    begin
    map.SetElem( P );
    inc(P.X);
    end;
  last:= P.X - 1;
  P.X:= start_x - 1;
  while  (P.X >= 0) and (map.LevelMap[P.X, P.y] = OldFloor) do
    begin
    map.SetElem( P );
    dec(P.X);
    end;
  first:= P.X + 1;
  if start_y > 0 then
    begin
    P.y:= start_y - 1;
    for P.X:= first to last do
      if map.LevelMap[P.X, P.y] = OldFloor then FillLine(P.X, P.y);
    end;
  if start_y < FIELDS_Y - 1 then
    begin
    P.y:= start_y + 1;
    for P.X:= first to last do
      if map.LevelMap[P.X, P.y] = OldFloor then FillLine(P.X, P.y);
    end;
  end;
begin
if Map.EditMode = map_mode then
  begin
  NewFloor:= map.EditVal;
  OldFloor:= map.LevelMap[Start.x, Start.y];
  if NewFloor <> OldFloor then
    FillLine( Start.x, Start.y );
  end;
end;

    
procedure InitScreen;
var
  gd, gm, gr: integer;
  i         : integer;
begin
directvideo:= false;
{ To link the EGAVGA BGI driver you have to use:
  binobj EGAVGA.BGI VGABGI VGA_BgiDriver
  The BGI File has to be placed in the current directory }
if RegisterBgiDriver(@VGA_BgiDriver) < 0 then
  begin
  WriteLn('Error registering driver: ', GraphErrorMsg(GraphResult));
  Halt(1);
  end;
gd:= vga;
gm:= vgahi;
InitGraph(gd, gm, BGI_PATH);
gr:= GraphResult;
if gr <> grOk then
  begin
  writeln( 'Error using InitGraph');
  writeln( GraphErrorMsg( gr ));
  halt(1);
  end;
SetGraphMode( gm );
SetColor( WHITE );
for i:= 0 to MAX_OBJ do
  begin
  MapElem[i].Assign( Word2HexWordStr(i), 'f010', 'unknown '+ Word2HexWordStr(i)) ;
  ObjElem[i].Assign( Word2HexWordStr(i), 'f010', 'unknown '+ Word2HexWordStr(i)) ;
  end;
SetTextStyle( DefaultFont, HorizDir , 1);
SetColor( TEXT_COLOR );
SetBkColor( BK_COLOR );
map.Init;
legend.Init( map.editmode );
{ Set button positions }
if legend.GetMode = obj_mode then
  legendbutton.Assign( BUTTON_LOC.X, BUTTON_LOC.Y, 0, 0, 'Obj' )
else
  legendbutton.Assign( BUTTON_LOC.X, BUTTON_LOC.Y, 0, 0, 'Map' );
upbutton.Assign( legendbutton.B.X + 1, BUTTON_LOC.Y, 0, 0, '' );
downbutton.Assign( upbutton.B.X + 1,  BUTTON_LOC.Y, 0, 0, '');
firstbutton.Assign( downbutton.B.X + 1, BUTTON_LOC.Y, 0, 0, '' );
lastbutton.Assign( firstbutton.B.X + 1, BUTTON_LOC.Y, 0, 0, '' );
backbutton.Assign( lastbutton.B.X + 1, BUTTON_LOC.Y, 0, 0, '' );
quitbutton.Assign( backbutton.B.X + 1, BUTTON_LOC.Y , 0, 0, 'Quit' );
objbutton.Assign( BUTTON_LOC.X, backbutton.B.Y + 1, 0, 0, 'Object' );
if not map.showobjects then
  objbutton.textcolor:= LightGray;
floorbutton.Assign( objbutton.B.X + 1, objbutton.A.Y ,0, 0, 'Floor' );
if not map.showfloor then
  floorbutton.textcolor:= LightGray;
savebutton.Assign( floorbutton.B.X + 1, floorbutton.A.Y, 0, 0, 'Put');
loadbutton.Assign( savebutton.B.X + 1, savebutton.A.Y, 0, 0, 'Get');
fillbutton.Assign( BUTTON_LOC.X, objbutton.B.Y + 1, 0, 0, 'Fill');
rectbutton.Assign( fillbutton.B.X + 1, fillbutton.A.Y, 0, 0, 'Rect');
clearbutton.Assign( rectbutton.B.X + 1, rectbutton.A.Y, 0, 0, 'Clear');
if legend.GetMode = obj_mode then
  fillbutton.TextColor:= LightGray
else
  fillbutton.TextColor:= White;
mreset(themouse);
if not themouse.exists then
  begin
  CloseGraph;
  writeln( 'No mouse driver installed');
  halt(1);
  end;
mshow;
end;

procedure ShowScreen;
var
  dummy: integer;
begin
mhide;
dummy:= port[$3da];
port[$3c0]:= 0;
legendbutton.Show( TRUE );
upbutton.Show( TRUE );
downbutton.Show( TRUE );
firstbutton.Show( TRUE );
lastbutton.Show( TRUE );
backbutton.Show( TRUE );
objbutton.Show( TRUE );
floorbutton.Show( TRUE );
quitbutton.Show( TRUE );
clearbutton.Show( TRUE );
fillbutton.Show( TRUE );
rectbutton.Show( TRUE );
savebutton.Show( TRUE );
loadbutton.Show( TRUE );
legend.Show;
map.selectcache.Show;
map.Show;
dummy:= port[$3da];
port[$3c0]:= 32;
mshow;
end;


var 
    done      : boolean;
    tmptype   : TElem;
    tmpelem   : word;
    P1, P2,
    oldloc    : TPoint;
    key       : char;
    ext_key   : boolean;
begin
InitScreen;
Initialize;
ShowScreen;
changed:= false;
done:= false;
with oldloc do
  begin x:= 0; y:= 0; end;
key:= #0;
repeat
  if map.contains(mloc) then
    begin
    map.GetCell(maploc, mloc);
    mhide;
    map.ShowInfo(mloc);
    mshow;
    end
  else
    begin
    mhide;
    map.ResetInfo;
    mshow;
    end;
  repeat
    mpos(mouseloc);
    with mloc do
      begin
      x:= mouseloc.column;
      y:= mouseloc.row;
      end;
  until (oldloc.x <> mloc.x) or (oldloc.y <> mloc.y) or
        keypressed or (mouseloc.buttonstatus<>0);
  oldloc:= mloc;
  case mouseloc.buttonstatus of
    0: begin
       if keypressed then
         begin
           GetKey(key, ext_key);
           if ext_key then
             case key of
               'H': SetNewLevel( map.level + 1 );
               'P': SetNewLevel( map.level - 1 );
               'I': Legend.Up;
               'Q': Legend.Down;
               #132: legend.first;
               'v': legend.last;
             end
           else
             case key of
               ' ': begin
                    if legend.GetMode = obj_mode then
                      begin
                      legend.SetMode( map_mode );
                      legendbutton.str:= 'Map';
                      fillbutton.TextColor:= White;
                      end
                    else
                      begin
                      legend.SetMode( obj_mode );
                      legendbutton.str:= 'Obj';
                      fillbutton.TextColor:= LightGray;
                      end;
                    mhide;
                    legendbutton.show(TRUE);
                    fillbutton.Show(TRUE);
                    mshow;
                    end;
               'q', 'Q', #27: done:= TRUE;
               'c','C': begin
                        mhide;
                        map.ClearInfo;
                        SetColor( WHITE );
                        MoveTo( map.InfoRect.A.X, map.InfoRect.A.Y );
                        outtext( 'Clear map - really  (Y/N/Esc)? ');
                        SetFillStyle( EmptyFill, Black );
                        repeat
                          getkey( key, ext_key );
                          bar(GetX, GetY, GetX + 7, GetY + 7);
                          OutTextXY( GetX, GetY, key );
                          key:= UpCase(key);
                        until (key in ['Y', 'N', #27]) and not ext_key;
                        if (key = 'Y') then
                          map.Delete;
                        mshow;
                        end;
               'o','O': begin
                          mhide;
                          map.ToggleObjects;
                          if not map.showobjects then
                            objbutton.textcolor:= LightGray
                          else
                            objbutton.textcolor:= WHITE;
                          objbutton.Show( TRUE );
                          mshow;
                        end;
               'f','F': begin
                          mhide;
                          map.ToggleFloor;
                          if not map.showfloor then
                            floorbutton.textcolor:= LightGray
                          else
                            floorbutton.textcolor:= WHITE;
                          floorbutton.Show( TRUE );
                          mshow;
                        end;
             end; { of case of key }
         end;
       end; { end of case 0 }
    1: begin
       if map.contains(mloc) then
         begin
         repeat
           map.GetCell(maploc, mloc);
           mhide;
           map.SetElem(maploc);
           mshow;
           mpos(mouseloc);
           with mloc do
             with mouseloc do
               begin x:= column; y:= row; end;
         until (not map.contains(mloc)) or (mouseloc.buttonstatus <> 1);
         mshow;
         end; { inside rectl_map }
       if legendbutton.contains( mloc )  then
         begin
         wait_for_mouserelease;
         if legend.GetMode = obj_mode then
           begin
           legend.SetMode( map_mode );
           legendbutton.str:= 'Map';
           fillbutton.TextColor:= White;
           end
         else
           begin
           legend.SetMode( obj_mode );
           legendbutton.str:= 'Obj';
           fillbutton.TextColor:= LightGray;
           end;
         mhide;
         legendbutton.show(TRUE);
         fillbutton.Show(TRUE);
         mshow;
         end; { if legendbutton.contains( mloc ) }
       if upbutton.contains( mloc ) then
         begin
         wait_for_mouserelease;
         legend.up;
         end; { inside rectl_upbutton }
       if downbutton.contains( mloc ) then
         begin
         wait_for_mouserelease;
         legend.down;
         end; { inside rectl_downbutton }
       if firstbutton.contains( mloc ) then
         begin
         wait_for_mouserelease;
         legend.first;
         end; { inside rectl_downbutton }
       if lastbutton.contains( mloc ) then
         begin
         wait_for_mouserelease;
         legend.last;
         end; { inside rectl_downbutton }
       if backbutton.contains( mloc ) then
         begin
         wait_for_mouserelease;
         legend.restore;
         end; { }
       if quitbutton.contains( mloc ) then
         done:= TRUE;
       if legend.contains( mloc ) then
         map.SetEditVal(legend.GetMode, legend.GetElem(mloc));
       if objbutton.contains( mloc ) then
         begin
         mhide;
         map.ToggleObjects;
         if not map.showobjects then
           objbutton.textcolor:= LightGray
         else
           objbutton.textcolor:= WHITE;
         objbutton.Show( TRUE );
         mshow;
       end;
       if floorbutton.contains( mloc ) then
         begin
         mhide;
         map.ToggleFloor;
         if not map.showfloor then
           floorbutton.textcolor:= LightGray
         else
           floorbutton.textcolor:= WHITE;
         floorbutton.Show( TRUE );
         mshow;
       end;
       if fillbutton.contains( mloc ) and (map.EditMode = map_mode )then
         begin
         wait_for_mouserelease;
         map.ResetInfo;
         SetColor( WHITE );
         OutTextXY( map.InfoRect.A.X, map.InfoRect.A.Y, 'Select position to start fill');
         repeat
           mpos(mouseloc);
         until keypressed or (mouseloc.buttonstatus <> 0);
         mloc.x:= mouseloc.column;
         mloc.y:= mouseloc.row;
         if map.Contains( mloc ) then
           begin
           map.GetCell( maploc, mloc );
           mhide;
           Fill(maploc);
           map.ResetInfo;
           mshow;
           end; { if map.contains( mloc ) }
         end; { if fillbutton.contains( mloc ) }
       if rectbutton.Contains( mloc ) then
         begin
         wait_for_mouserelease;
         mhide;
         map.ResetInfo;
         SetColor( WHITE );
         OutTextXY( map.InfoRect.A.X, map.InfoRect.A.Y, 'Select first corner');
         mshow;
         repeat
           mpos(mouseloc);
         until keypressed or (mouseloc.buttonstatus <> 0);
         P1.x:= mouseloc.column;
         P1.y:= mouseloc.row;
         if map.Contains( P1 ) then
           begin
           mhide;
           OutTextXY( map.InfoRect.A.X, map.InfoRect.A.Y + 12, 'Select second corner');
           wait_for_mouserelease;
           mshow;
           SetLineStyle( SolidLn, 0, 1 );
           SetWriteMode( XORPut );
           SetColor( White );
           oldloc:= P1;
           rectangle( P1.X, P1.Y, oldloc.X, oldloc.Y );
           repeat
             mpos(mouseloc);
             if (mouseloc.column <> oldloc.X) or (mouseloc.row <> oldloc.Y) then
               begin
               mhide;
               rectangle( P1.X, P1.Y, oldloc.X, oldloc.Y );
               oldloc.X:= mouseloc.column;
               oldloc.Y:= mouseloc.row;
               rectangle( P1.X, P1.Y, oldloc.X, oldloc.Y );
               mshow;
               end;
           until keypressed or (mouseloc.buttonstatus <> 0);
           rectangle( P1.X, P1.Y, oldloc.X, oldloc.Y );
           SetWriteMode( NormalPut );
           map.ResetInfo;
           P2.x:= mouseloc.column;
           P2.y:= mouseloc.row;
           map.GetCell(maploc, P1);
           map.GetCell(P1, P2);
           P2:= maploc;
           maploc.x:= mouseloc.column;
           maploc.y:= mouseloc.row;
           if map.Contains( maploc ) and ((P1.X <> P2.X) or (P1.Y <> P2.Y )) then
             begin
             changed:= TRUE;
             mhide;
             if P1.X < P2.X then
               begin
               for maploc.x:= P1.X to P2.X do
                 begin
                 maploc.y:= P1.Y;
                 map.SetElem( maploc );
                 maploc.y:= P2.Y;
                 map.SetElem( maploc );
                 end;
               end
             else
               begin
               for maploc.x:= P2.X to P1.X do
                 begin
                 maploc.y:= P1.Y;
                 map.SetElem( maploc );
                 maploc.y:= P2.Y;
                 map.SetElem( maploc );
                 end;
               end;
             if P1.Y < P2.Y then
               begin
               for maploc.y:= P1.Y + 1 to P2.Y - 1 do
                 begin
                 maploc.x:= P1.x;
                 map.SetElem( maploc );
                 maploc.x:= P2.x;
                 map.SetElem( maploc );
                 end;
               end
             else
               begin
               for maploc.y:= P2.Y + 1 to P1.Y - 1 do
                 begin
                 maploc.x:= P1.x;
                 map.SetElem( maploc );
                 maploc.x:= P2.x;
                 map.SetElem( maploc );
                 end;
               end;
             mshow;
             end;
           end; { if map.contains( P2 ) }
         end;
       if clearbutton.Contains( mloc) then
         begin
         mhide;
         map.ClearInfo;
         SetColor( WHITE );
         MoveTo( map.InfoRect.A.X, map.InfoRect.A.Y );
         outtext( 'Clear map - really  (Y/N/Esc)? ');
         SetFillStyle( EmptyFill, Black );
         repeat
           getkey( key, ext_key );
           bar(GetX, GetY, GetX + 7, GetY + 7);
           OutTextXY( GetX, GetY, key );
           key:= UpCase(key);
         until (key in ['Y', 'N', #27]) and not ext_key;
         if (key = 'Y') then
           Map.Delete;
         mshow;
         end; { if clearbutton.contain( mloc ) }
       if loadbutton.Contains( mloc ) then
         begin
         wait_for_mouserelease;
         mhide;
         map.ResetInfo;
         SetColor( WHITE );
         MoveTo( map.InfoRect.A.X, map.InfoRect.A.Y );
         OutText( 'Enter Character to specify the map ' );
         GetKey( key, ext_key );
         OutText( key );
         OutTextXY( map.InfoRect.A.X, map.InfoRect.A.Y + 14 , 'Loading - please wait' );
         if key <> #27 then map.Load( key );
         map.ClearInfo;
         mshow;
         end; { if loadbutton.Contains( mloc ) }
       if savebutton.Contains( mloc ) then
         begin
         wait_for_mouserelease;
         mhide;
         map.ClearInfo;
         SetColor( WHITE );
         MoveTo( map.InfoRect.A.X, map.InfoRect.A.Y );
         OutText( 'Enter Character to specify the map ' );
         GetKey( key, ext_key );
         OutText( key );
         OutTextXY( map.InfoRect.A.X, map.InfoRect.A.Y + 14, 'Saveing - please wait');
         if key <> #27 then map.Save( key );
         map.ClearInfo;
         mshow;
         end; { if savebutton.Contains( mloc ) }
       if map.SelectCache.contains( mloc ) then
         begin
         map.SelectCache.GetElem( mloc, tmptype, tmpelem );
         mhide;
         map.SetEditVal(TEditMode(tmptype), tmpelem );
         mshow;
         end;
       end; { of case 1 }
    2: begin
       if map.contains(mloc) then
         begin
         wait_for_mouserelease;
         map.GetCell(maploc, mloc);
         mhide;
         map.SetEditVal(legend.GetMode, map.GetElem(maploc, TElem(legend.GetMode)));
         mshow;
         end; { map.contains( mloc ) }
       if upbutton.contains( mloc ) then
         begin
         wait_for_mouserelease;
         SetNewLevel(map.level + 1);
         end; { if upbutton.contains( mloc ) }
       if downbutton.contains( mloc ) then
         begin
         wait_for_mouserelease;
         SetNewLevel(map.level - 1);
         end; { downbutton.contains( mloc ) }
       if firstbutton.contains( mloc ) then
         begin
         wait_for_mouserelease;
         SetNewLevel(map.level + 10);
         end; { inside rectl_downbutton }
       if lastbutton.contains( mloc ) then
         begin
         wait_for_mouserelease;
         SetNewLevel(map.level - 10);
         end; { inside rectl_downbutton }
       if quitbutton.contains( mloc ) then
         begin done:= TRUE; changed:= FALSE; end;
       end; { of case 2 }
    end; { of case of mousebutton }
   if done and changed then
     begin
     mhide;
     map.ClearInfo;
     SetColor( WHITE );
     MoveTo( map.InfoRect.A.X, map.InfoRect.A.Y );
     outtext( 'Save current levels to disk (Y/N/Esc)? ');
     SetFillStyle( EmptyFill, Black );
     repeat
       getkey( key, ext_key );
       bar(GetX, GetY, GetX + 7, GetY + 7);
       OutTextXY( GetX, GetY, key );
       key:= UpCase(key);
     until (key in ['Y', 'N', #27]) and not ext_key;
     if (key = 'Y') and not ext_key then
       begin
       OutTextXY( map.InfoRect.A.X, map.InfoRect.A.Y + 14, 'Saveing - please wait');
       freemem(maps[map.level].map.data,maps[map.level].map.size);
       freemem(maps[map.level].objects.data,maps[map.level].objects.size);
       compress(map.levelmap,maps[map.level].map);
       compress(map.levelobj,maps[map.level].objects);
       write_levels;
       end
     else
       begin
       done:= key <> #27;
       map.ClearInfo;
       end;
     mshow;
     end;
until done;
RestoreCrtMode;
CloseGraph;
writeln('MapEdit 4.2 - (c) General Fettgesicht');
writeln;
writeln('This program is intended to be for your personal use only.');
writeln('Distribution of any modified maps may be construed as a ');
writeln('copyright violation by Apogee/ID.');
writeln;
end.