
 {
  MapEdit 6.1     Wolfenstein Map Editor

  ver 6.1 (Matt Gruson - 5/93 Contact on CompuServe  (at)  72360,2432 or
                                                      73766,347
                                         Prodigy     (at)  PTJT50A
                                         GEnie       (at)  M.GRUSON

            - COMMENTED MY CODE!
            - Allowed right mouse button to have it's own value.
            - Allowed sepperate tracking of MAP and OBJ mode values for
              the different mouse buttons.
            - Holding down shift key while clicking on the map loads values.
            - Spacebar toggles between MAP and OBJECT modes.
            - Allowed PAGEUP and PAGEDOWN to scroll the legend display.
            - Removed unused code for clarity.

  ver 6.0 (Dave Huntooon - 5/93)
            - Added help display
                switches between help display and Bryan Baker's
                status display
            - Added Copy, Paste and Exchange procedures
            - Added Write and Read procedures that will allow
                exporting and importing floors via a file named
                FLOOR.OUT
            - Changed the Clear procedure to fill using the
                currently selected map value
            - minor fixes

  ver 5.0 (Bryan Baker - 4/93)
            - Added display of critical map statistics to edit window:
                Static Objects
                Total Guards
                Doors

                Level 1 Guards
                Level 3 Guards
                Level 4 Guards
                Super   Guards

                Secret Doors
                Treasure & Extra Lives

  ver 4.1a (Dave Huntoon)
            - Adds ability to open Spear of Destiny (SOD) maps.
            - Allows access to objects > 00FE.  Needed for SOD
              objects.
            - minor fix to completely clear text area below
              the map display when the mouse is moved outisde
              of the map area.

  ver 4.1  Copyright (c) 1992  Bill Kirby


}

{$A+,B-,D+,E-,F-,I+,L-,N-,O-,R-,S-,V-}
{$M 16384,0,655360}
program mapedit;

uses crt,dos,graph,mouse;

const MAP_X = 6;
      MAP_Y = 6;
      TEXTLOC = 458;

      GAMEPATH        : string = '';
      HEADFILENAME    : string = 'maphead';
      MAPFILENAME     : string = 'maptemp';
      LEVELS          : word   = 10;
      GAME_VERSION    : real   = 1.0;

      VERSION         : string = '6.1';

      KEYSTATADDR     = $417;
      LEFTSHIFTMASK   = $01;
      RIGHTSHIFTMASK  = $02;

      {Rev 6.1}
      KEY_PGUP        = chr(73);
      KEY_PGDN        = chr(81); {These should be CHARs, but since Borland
                                  Pascal 7 can't evaluate CHAR constants in
                                  case statements I had to do it the ugly way}


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

     grid = array[0..63,0..63] of word;

     filltype = (solid,check);
     doortype = (horiz,vert);


var levelmap,
    objectmap    : grid;
    maps         : array[1..60] of level_type;

    show_objects,
    show_floor   : boolean;

    mapgraph,
    objgraph     : array[0..511] of string[4];
    mapnames,
    objnames     : array[0..511] of string[20];

    themouse     : resetrec;
    mouseloc     : locrec;

    stats,
    xfer,
    copy,
    excng        : boolean;
    tempobj,
    tempmap      : grid;

procedure waitforkey;
var key: char;
begin
  repeat until keypressed;
  key:= readkey;
  if key=#0 then key:= readkey;
end;


procedure decorate(x,y,c: integer);
var i,j: integer;
begin
  setfillstyle(1,c);
  bar(x*7+MAP_X+2,y*7+MAP_Y+2,x*7+MAP_X+4,y*7+MAP_Y+4);
end;

procedure box(fill: filltype; x,y,c1,c2: integer; dec: boolean);
begin
  if fill=solid then
    setfillstyle(1,c1)
  else
    setfillstyle(9,c1);

  bar(x*7+MAP_X,y*7+MAP_Y,x*7+6+MAP_X,y*7+6+MAP_Y);
  if dec then decorate(x,y,c2);
end;

procedure outtext(x,y,color: integer; s: string);
begin
  setcolor(color);
  outtextxy(x*7+MAP_X,y*7+MAP_Y,s);
end;

function hex(x: word): string;
const digit : string[16] = '0123456789ABCDEF';
var temp : string[4];
    i    : integer;
begin
  temp:= '    ';
  for i:= 4 downto 1 do
    begin
      temp[i]:= digit[(x and $000f)+1];
      x:= x div 16;
    end;
  hex:= temp;
end;

function hexbyte(x: byte): string;
const digit : string[16] = '0123456789ABCDEF';
var temp : string[4];
    i    : integer;
begin
  temp:= '  ';
  for i:= 2 downto 1 do
    begin
      temp[i]:= digit[(x and $000f)+1];
      x:= x div 16;
    end;
  hexbyte:= temp;
end;

procedure doline(x,y,x2,y2: integer);
begin
  line(x+MAP_X,y+MAP_Y,x2+MAP_X,y2+MAP_Y);
end;

procedure dobar(x,y,x2,y2: integer);
begin
  bar(x+MAP_Y,y+MAP_Y,x2+MAP_X,y2+MAP_Y);
end;

procedure circle(x,y,c1,c2: integer);
const sprite : array[0..6,0..6] of byte =
                   ((0,0,1,1,1,0,0),
                    (0,1,1,1,1,1,0),
                    (1,1,1,2,1,1,1),
                    (1,1,2,2,2,1,1),
                    (1,1,1,2,1,1,1),
                    (0,1,1,1,1,1,0),
                    (0,0,1,1,1,0,0));
var i,j,c: integer;
begin
  for i:= 0 to 6 do
    for j:= 0 to 6 do
      begin
        case sprite[i,j] of
          0: c:=0;
          1: c:=c1;
          2: c:=c2;
        end;
        putpixel(x*7+MAP_X+i,y*7+MAP_Y+j,c);
      end;
end;

procedure door(dtype: doortype; x,y,color: integer);
begin
  case dtype of
    vert: begin
            setfillstyle(1,color);
            dobar(x*7+2,y*7,x*7+4,y*7+6);
          end;
    horiz : begin
              setfillstyle(1,color);
              dobar(x*7,y*7+2,x*7+6,y*7+4);
          end;
  end;
end;

function hexnibble(c: char): byte;
begin
  case c of
    '0'..'9': hexnibble:= ord(c)-ord('0');
    'a'..'f': hexnibble:= ord(c)-ord('a')+10;
    'A'..'F': hexnibble:= ord(c)-ord('A')+10;
    else hexnibble:= 0;
  end;
end;

procedure output(x,y: integer; data: string);
var size  : integer;
    temp  : string[4];
    c1,c2 : byte;
begin
  if data<>'0000' then
    begin
      temp:= data;
      c1:= hexnibble(temp[1]);
      c2:= hexnibble(temp[2]);
      case temp[3] of
        '0': outtext(x,y,c1,temp[4]);
        '1': box(solid,x,y,c1,c2,false);
        '2': box(check,x,y,c1,c2,false);
        '3': box(solid,x,y,c1,c2,true);
        '4': box(check,x,y,c1,c2,true);
        '5': circle(x,y,c1,c2);
        '6': door(horiz,x,y,c1);
        '7': door(vert,x,y,c1);
        '8': begin
               setfillstyle(1,c1);
               dobar(x*7,y*7,x*7+6,y*7+3);
               setfillstyle(1,c2);
               dobar(x*7,y*7+4,x*7+6,y*7+6);
              end;
        '9': putpixel(x*7+MAP_X+3,y*7+MAP_Y+3,c1);
        'a': begin setfillstyle(1,c1); dobar(x*7+2,y*7+1,x*7+4,y*7+5); end;
        'b': begin setfillstyle(1,c1); dobar(x*7+2,y*7+2,x*7+4,y*7+4); end;
        'c': begin setfillstyle(1,c1); dobar(x*7+1,y*7+1,x*7+5,y*7+5); end;
        'd': begin
               setcolor(c1);
               doline(x*7+1,y*7+1,x*7+5,y*7+5);
               doline(x*7+5,y*7+1,x*7+1,y*7+5);
             end;
        'e': begin
               setcolor(c1);
               rectangle(x*7+MAP_X,y*7+MAP_Y,x*7+MAP_X+6,y*7+MAP_Y+6);
             end;
        'f': case c2 of
              2: begin {east}
                   setcolor(c1);
                   doline(x*7,y*7+3,x*7+6,y*7+3);
                   doline(x*7+6,y*7+3,x*7+3,y*7);
                   doline(x*7+6,y*7+3,x*7+3,y*7+6);
                end;
              0: begin {north}
                   setcolor(c1);
                   doline(x*7+3,y*7+6,x*7+3,y*7);
                   doline(x*7+3,y*7,x*7,y*7+3);
                   doline(x*7+3,y*7,x*7+6,y*7+3);
                 end;
              6: begin {west}
                   setcolor(c1);
                   doline(x*7+6,y*7+3,x*7,y*7+3);
                   doline(x*7,y*7+3,x*7+3,y*7);
                   doline(x*7,y*7+3,x*7+3,y*7+6);
                 end;
              4: begin {south}
                   setcolor(c1);
                   doline(x*7+3,y*7,x*7+3,y*7+6);
                   doline(x*7+3,y*7+6,x*7,y*7+3);
                   doline(x*7+3,y*7+6,x*7+6,y*7+3);
                 end;
              1: begin {northeast}
                   setcolor(c1);
                   doline(x*7,y*7+6,x*7+6,y*7);
                   doline(x*7+6,y*7,x*7+3,y*7);
                   doline(x*7+6,y*7,x*7+6,y*7+3);
                 end;
              7: begin {northwest}
                   setcolor(c1);
                   doline(x*7+6,y*7+6,x*7,y*7);
                   doline(x*7,y*7,x*7+3,y*7);
                   doline(x*7,y*7,x*7,y*7+3);
                 end;
              3: begin {southeast}
                   setcolor(c1);
                   doline(x*7,y*7,x*7+6,y*7+6);
                   doline(x*7+6,y*7+6,x*7+3,y*7+6);
                   doline(x*7+6,y*7+6,x*7+6,y*7+3);
                 end;
              5: begin {southwest}
                   setcolor(c1);
                   doline(x*7+6,y*7,x*7,y*7+6);
                   doline(x*7,y*7+6,x*7+3,y*7+6);
                   doline(x*7,y*7+6,x*7,y*7+3);
                 end;

             end;
      end;
    end;
end;

procedure display_map;
var i,j: integer;
begin
  j:= 63;
  i:= 0;
  repeat
    setfillstyle(1,0);
    dobar(i*7,j*7,i*7+6,j*7+6);
    if show_floor then
      output(i,j,mapgraph[levelmap[i,j]])
    else
      if not (levelmap[i,j] in [$6a..$8f]) then
        output(i,j,mapgraph[levelmap[i,j]]);
    if show_objects then
      output(i,j,objgraph[objectmap[i,j]]);
    inc(i);
    if i=64 then
      begin
        i:= 0;
        dec(j);
      end;
  until (j<0) or keypressed;
end;

procedure read_levels;
var headfile,
    mapfile  : file;
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

procedure expand(d: data_block; var g: grid);
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

procedure compress(g: grid; var d: data_block);
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
  while (y<64) do
    begin
      count:= 1;
      repeat
        inc(x);
        if x=64 then
          begin
            x:=0;
            inc(y);
          end;
        if y<64 then
          nextdata:= g[x,y];
        inc(count);
      until (nextdata<>data) or (y=64);
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



procedure copy_level; { DGH 5/93 }

var   i, j     : integer;

begin
   tempobj := objectmap;
   tempmap := levelmap;
end;


procedure paste_level; { DGH 5/93 }

var   i, j     : integer;

begin
       objectmap := tempobj;
       levelmap  := tempmap;
end;


procedure exchange; { DGH 5/93 }

var   i, j      : integer;
      tempobj1,
      tempmap1  : word;

begin
   for i:=0 to 63 do
    for j:=0 to 63 do
      begin
         tempobj1  := objectmap[i,j];
         tempmap1  := levelmap[i,j];
         objectmap[i,j] := tempobj[i,j];
         levelmap[i,j]  := tempmap[i,j];
         tempobj[i,j]   := tempobj1;
         tempmap[i,j]   := tempmap1;
      end;

end;


procedure print_help;   {DGH 5/93 }

var   StartX   : integer;
      StartY   : integer;
      DeltaY   : integer;

begin
   StartX := 462+MAP_X;
   StartY := 380+MAP_Y;
   DeltaY := 9;

   setcolor(15);
   setfillstyle(1,0);
   bar(StartX, StartY, 639, 479);
   outtextxy(StartX, StartY,'O = Toggle Objects');
   StartY := StartY + DeltaY;
   outtextxy(StartX, StartY,'F = Toggle Floor');
   StartY := StartY + DeltaY;
   outtextxy(StartX, StartY,'C = Clear Floor');
   StartY := StartY + DeltaY;
   outtextxy(StartX, StartY,'S = Toggle Stats/Help');
   StartY := StartY + DeltaY;
   if copy then setcolor(14) else setcolor(15);
   outtextxy(StartX, StartY,'M = Memorize Level');
   StartY := StartY + DeltaY;
   if (excng and copy) then setcolor(14);
   if (excng and not copy) then setcolor (12);
   if not excng then setcolor(15);
   outtextxy(StartX, StartY,'E = Exchange Level');
   setcolor(15);
   if (not copy and xfer) then setcolor(12);
   if (copy and xfer) then setcolor(14);
   StartY := StartY + DeltaY;
   outtextxy(StartX, StartY,'T = Transfer Level');
   setcolor(15);
   StartY := StartY + DeltaY;
   outtextxy(startx, starty, 'R = Read Floor.out');
   StartY := StartY + DeltaY;
   outtextxy(startx, starty, 'W = Write Floor.out');
   StartY := StartY + DeltaY;
   outtextxy(startx, starty, 'SPACE = Toggle mode');
   StartY := StartY + DeltaY;
   outtextxy(StartX, StartY,'Q = Quit');
   delay(200);
end;


procedure print_version; { DGH 5/93 }

begin
  setfillstyle(1,0);
  bar(180,TEXTLOC,461,479);
  setcolor(12);
  outtextxy(188,TEXTLOC,'Mapedit v'+VERSION);
end;



procedure error_read; { DGH 5/93 }

begin
  setfillstyle(1,0);
  bar(180,TEXTLOC,461,479);
  setcolor(15);
  outtextxy(180,TEXTLOC,'ERROR Reading FLOOR.OUT');
  delay(1000);
end;


procedure error_write; { DGH 5/93 }

begin
  setfillstyle(1,0);
  bar(180,TEXTLOC,461,479);
  setcolor(15);
  outtextxy(180,TEXTLOC,'ERROR Writing FLOOR.OUT');
  delay(1000);
end;


procedure read_floor; { DGH 5/93 }

var i, j       : integer;
    floor_file : file;
    floor_name : string;
    numread1   : word;
    numread2   : word;
    size       : word;

begin
  size := sizeof(tempmap);
  floor_name := 'FLOOR.OUT';
  Assign(floor_file, floor_name); {Open FIle}
{$I-}
  reset(floor_file,1);
{$I+}
  if ioresult <> 0 then
    begin
      error_read;
    end else
    begin
      blockread(floor_file,tempmap,sizeof(tempmap),numread1);
      blockread(floor_file,tempobj,sizeof(tempmap),numread2);
      if (numread1 <> size) or (numread2 <> size) then error_read else
       begin
        copy := true;
        print_help;
       end;
      close(floor_file);
    end;
end;


procedure write_floor; { DGH 5/93 }

var i, j       : integer;
    floor_file : file;
    floor_name : string;
    numwrite1  : word;
    numwrite2  : word;
    size       : word;

begin
  floor_name := 'FLOOR.OUT';
  size := sizeof(tempmap);
  Assign(floor_file, floor_name); {Open FIle}
{$I-}
  rewrite(floor_file,1);
{$I+}
  if ioresult <> 0 then
  begin
    error_write;
  end else
  blockwrite(floor_file,levelmap,sizeof(levelmap),numwrite1);
  blockwrite(floor_file,objectmap,sizeof(objectmap),numwrite2);
  if (numwrite1 <> size) or (numwrite2 <> size) then error_write;
  close(floor_file);
end;



procedure print_stats;       { BDB 4/93 }
var   i, j     : integer;
      Tempstr  : string;
      Statics  : integer;
      L1Guards : integer;
      L3Guards : integer;
      L4Guards : integer;
      SGuards  : integer;
      TGuards  : integer;
      Treasure : integer;
      Doors    : integer;
      SecDoors : integer;
      StartX   : integer;
      StartY   : integer;
      DeltaY   : integer;
begin
 if stats then
  begin
   Statics  := 0;
   L1Guards := 0;
   L3Guards := 0;
   L4Guards := 0;
   SGuards  := 0;
   TGuards  := 0;
   Treasure := 0;
   Doors    := 0;
   SecDoors := 0;
   StartX   := 462+MAP_X;
   StartY   := 380+MAP_Y;
   DeltaY   := 9;

   for i:=0 to 63 do
    for j:=0 to 63 do
      begin
       if objectmap[i,j] in [$17..$4a]   then Statics  := Statics  + 1;
       if objectmap[i,j] in [$6c..$7c]   then L1Guards := L1Guards + 1;
       if objectmap[i,j] in [$7e..$85]   then L1Guards := L1Guards + 1;
       if objectmap[i,j] in [$8a..$8d]   then L1Guards := L1Guards + 1;
       if objectmap[i,j] in [$d8..$df]   then L1Guards := L1Guards + 1;
       if objectmap[i,j] in [$90..$9f]   then L3Guards := L3Guards + 1;
       if objectmap[i,j] in [$a2..$a9]   then L3Guards := L3Guards + 1;
       if objectmap[i,j] in [$ae..$b1]   then L3Guards := L3Guards + 1;
       if objectmap[i,j] in [$ea..$f1]   then L3Guards := L3Guards + 1;
       if objectmap[i,j] in [$b4..$c3]   then L4Guards := L4Guards + 1;
       if objectmap[i,j] in [$c6..$cd]   then L4Guards := L4Guards + 1;
       if objectmap[i,j] in [$d2..$d5]   then L4Guards := L4Guards + 1;
       if (objectmap[i,j]>$fc) and (objectmap[i,j]<$104)
                                         then L4Guards := L4Guards + 1;
       if objectmap[i,j] in [$c4..$c5]   then SGuards  := SGuards + 1;
       if objectmap[i,j] in [$d6..$d7]   then SGuards  := SGuards + 1;
       if objectmap[i,j] in [$e0..$e3]   then SGuards  := SGuards + 1;
       if objectmap[i,j] in [$6a..$6b]   then SGuards  := SGuards + 1;
       if objectmap[i,j] in [$8e..$8f]   then SGuards  := SGuards + 1;
       if objectmap[i,j] in [$a0..$a1]   then SGuards  := SGuards + 1;
       if objectmap[i,j] in [$b2..$b3]   then SGuards  := SGuards + 1;
       if objectmap[i,j] = $7d           then SGuards  := SGuards + 1;
       if objectmap[i,j] in [$34..$38]   then Treasure := Treasure + 1;
       if objectmap[i,j] = $62           then SecDoors := SecDoors + 1;
       if levelmap[i, j] in [$5a..$5f]   then Doors    := Doors    + 1;
       if levelmap[i, j] in [$64..$65]   then Doors    := Doors    + 1;
      end;
  TGuards := L1Guards + L3Guards + L4Guards + SGuards;
  setcolor(15);
  setfillstyle(1,0);
  bar(StartX, StartY, 639, 479);

  if Statics<400 then setcolor(15) else setcolor(12);
  str(Statics:4, Tempstr);
  outtextxy(StartX, StartY,Tempstr+'  Static Objects');

  if TGuards<150 then setcolor(15) else setcolor(12);
  StartY := StartY + DeltaY;
  str(TGuards:4, Tempstr);
  outtextxy(StartX, StartY,Tempstr+'  Total Guards  ');

  if Doors<65 then setcolor(15) else setcolor(12);
  StartY := StartY + DeltaY;
  str(Doors:4, Tempstr);
  outtextxy(StartX, StartY,Tempstr+'  Doors         ');

  setcolor(7);
  StartY := StartY + DeltaY + 4;
  str(L1Guards:4, Tempstr);
  outtextxy(StartX, StartY,Tempstr+'  Level 1 Guards');

  StartY := StartY + DeltaY;
  str(L3Guards:4, Tempstr);
  outtextxy(StartX, StartY,Tempstr+'  Level 3 Guards');

  StartY := StartY + DeltaY;
  str(L4Guards:4, Tempstr);
  outtextxy(StartX, StartY,Tempstr+'  Level 4 Guards');

  StartY := StartY + DeltaY;
  str(SGuards:4, Tempstr);
  outtextxy(StartX, StartY,Tempstr+'  Super   Guards');

  StartY := StartY + DeltaY + 4;
  str(SecDoors:4, Tempstr);
  outtextxy(StartX, StartY,Tempstr+'  Secret Doors  ');

  StartY := StartY + DeltaY;
  str(Treasure:4, Tempstr);
  outtextxy(StartX, StartY,Tempstr+'  $$$ / One-ups ');
 end;
end;


procedure clear_level(n: integer);
var x,y: integer;
begin
   mhide;
   for x:= 0 to 63 do
     for y:= 0 to 63 do
       begin
         levelmap[x,y]:= n;
         objectmap[x,y]:= 0;
       end;
   for x:= 0 to 63 do
     begin
       levelmap[x,0]:= 1;
       levelmap[x,63]:= 1;
       levelmap[0,x]:= 1;
       levelmap[63,x]:= 1;
     end;
   display_map;
   print_stats;
   mshow;
end;

function str_to_hex(s: string): word;
var temp : word;
    i    : integer;
begin
  temp:= 0;
  for i:= 1 to length(s) do
    begin
      temp:= temp * 16;
      case s[i] of
        '0'..'9': temp:= temp + ord(s[i])-ord('0');
        'a'..'f': temp:= temp + ord(s[i])-ord('a')+10;
        'A'..'F': temp:= temp + ord(s[i])-ord('A')+10;
      end;
    end;
  str_to_hex:= temp;
end;

procedure showlegend(which,start,n: integer);
var i,x,y: integer;
    save: boolean;
begin
  mhide;
  save:= show_objects;
  show_objects:= true;
  setfillstyle(1,0);
  bar(64*7+MAP_X+13,4,639-5,380-30);
  x:= 66;
  y:= 0;
  for i:= start to start+n-1 do
    begin
      if which=0 then
        begin
          output(x,y,mapgraph[i]);
          outtext(x+2,y,15,mapnames[i]);
        end
      else
        begin
          output(x,y,objgraph[i]);
          outtext(x+2,y,15,objnames[i]);
        end;
      inc(y,2);
    end;
  show_objects:= save;
  mshow;
end;

function inside(x1,y1,x2,y2,x,y: integer): boolean;
begin
  inside:= (x>=x1) and (x<=x2) and
           (y>=y1) and (y<=y2);
end;

procedure wait_for_mouserelease;
begin
  repeat
    mpos(mouseloc);
  until mouseloc.buttonstatus=0;
end;

procedure bevel(x1,y1,x2,y2,c1,c2,c3: integer);
begin
  setfillstyle(1,c1);
  bar(x1,y1,x2,y2);
  setcolor(c2);
  line(x1,y1,x2,y1);
  line(x1+1,y1+1,x2-1,y1+1);
  line(x2,y1,x2,y2);
  line(x2-1,y1,x2-1,y2-1);
  setcolor(c3);
  line(x1,y1+1,x1,y2);
  line(x1+1,y1+2,x1+1,y2);
  line(x1,y2,x2-1,y2);
  line(x1+1,y2-1,x2-2,y2-1);
end;

function upper(s: string): string;
var i: integer;
begin
  for i:=1 to length(s) do
    if s[i] in ['a'..'z'] then
      s[i]:=chr(ord(s[i])-ord('a')+ord('A'));
  upper:=s;
end;



procedure initialize;
var i: integer;
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
  filename:= GAMEPATH + HEADFILENAME + '.*';
  writeln('MapEdit  Copyright (c) 1992  Bill Kirby');
  writeln('Version '+version);
  writeln('Modifications by   Dave Huntoon');
  writeln('                   Bryan Baker');
  writeln('                   Matt Gruson');
  writeln('searching for ',filename);
  findfirst(filename,$ff,search);
  if doserror<>0 then
    begin
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
      if upper(ext)='.SOD' then
          LEVELS:=21;
      if upper(ext)='.WL1' then
          LEVELS:=10;
      if (upper(ext)='.WL1') or (upper(ext)='.SOD') then
        begin
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
            LEVELS:= 60;
          MAPFILENAME:='GAMEMAPS'+ext;
          filename:=GAMEPATH+'GAMEMAPS'+ext;
          findfirst(filename,$ff,search);
          if doserror<>0 then
            begin
              writeln('Error opening GAMEMAPS file.');
              halt(0);
            end;
        end;
    end;

  for i:= 0 to 511 do
    begin
      mapnames[i]:= 'unknown '+hex(i);
      objnames[i]:= 'unknown '+hex(i);
      mapgraph[i]:= 'f010';
      objgraph[i]:= 'f010';
    end;
  assign(infile,'mapdata.def');
  reset(infile);
  while not eof(infile) do
    begin
      readln(infile,hexstr,junk,graphstr,junk,name20);
      mapnames[str_to_hex(hexstr)]:= name20;
      mapgraph[str_to_hex(hexstr)]:= graphstr;
    end;
  close(infile);

  assign(infile,'objdata.def');
  reset(infile);
  while not eof(infile) do
    begin
      readln(infile,hexstr,junk,graphstr,junk,name20);
      objnames[str_to_hex(hexstr)]:= name20;
      objgraph[str_to_hex(hexstr)]:= graphstr;
    end;
  close(infile);

end;




{VARs for procedure MAIN and associated procedures}

var gd,gm,
    i,j,x,y     : integer;
    infile      : text;
    level       : word;
    oldx,oldy   : integer;
    done        : boolean;
    outstr,
    tempstr     : string;

    legendpos   : integer;
    legendtype  : integer;
    newj        : integer;

    mode        : (map,obj);
    leftmapval  : integer;  {Value inserted by left button press  - MAP mode}
    rightmapval : integer;  {Value inserted by right button press - MAP mode}
    leftobjval  : integer;  {Value inserted by left button press  - OBJ mode}
    rightobjval : integer;  {Value inserted by right button press - OBJ mode}

    oldj,oldi   : integer;

    key         : char;
    control     : boolean;


procedure showcurrentselection;
          {
          Removed from inside code body for 6.1 to allow use in
          several places.  Writes the little 'currently selected
          attribute' note in the lower-left corner of the screen.
          }
          begin
          setfillstyle(1,0);
          bar(0, TEXTLOC+10, 64*7+MAP_X,479);
          if mode=map then
            begin
              output(0,66,mapgraph[leftmapval]);
              outtext(1,66,15,' '+mapnames[leftmapval]+' (MAP)');
            end
          else
            begin
              output(0,66,objgraph[leftmapval]);
              outtext(1,66,15,' '+objnames[leftobjval]+' (OBJ)');
            end;
          end;

procedure process_buttons;
          {
          Added for 6.1 to facilitate easier handling of new functions.
          Use of DONE label added for clarity (nesting conditionals too
          deep is only considered 'structured' by academics, practioners
          know better).
          }
          label done;
          begin

          if (mem[0:keystataddr] and leftshiftmask>0) or
             (mem[0:keystataddr] and rightshiftmask>0) then
             {User is holding down a shift key while clicking,
              so let him/her load an atttribute from the map}

             begin
             if mouseloc.buttonstatus=leftbutton then
                {Load if left button}
                if mode=map then
                  begin
                  leftmapval:=levelmap[i,j];
                  showcurrentselection;
                  end
                else
                  begin
                  leftobjval:=objectmap[i,j];
                  showcurrentselection;
                  end

             else  {Load if right button}
                if mode=map then
                   rightmapval:=levelmap[i,j]
                else
                   leftobjval:=objectmap[i,j];
             goto done;
             end;

          {Falls through to here is no shift key held down}
          if mouseloc.buttonstatus=leftbutton then
             {Draw if left button}
             if mode=map then
               levelmap[i,j]:= leftmapval
             else
               objectmap[i,j]:= leftobjval

          else  {Draw if right button}
             if mode=map then
                levelmap[i,j]:=rightmapval
             else
                objectmap[i,j]:=rightobjval;

done:     end;

procedure set_map_mode;
          {
          Broken out from code body for Rev 6.1
          }
          begin;
          wait_for_mouserelease;
          legendpos:=0;
          legendtype:=0;
          mode:=map;
          showlegend(legendtype,legendpos,25);
          showcurrentselection;
          end;


procedure set_object_mode;
          {
          Broken out from code body for Rev 6.1
          }
          begin
          wait_for_mouserelease;
          legendpos:=0;
          legendtype:=1;
          mode:=obj;
          showlegend(legendtype,legendpos,25);
          showcurrentselection;
          end;

procedure legend_up;
          {
          Broken out from code body for Rev 6.1
          }
          begin
          wait_for_mouserelease;
          dec(legendpos,25);
          if legendpos<0 then legendpos:= 0;
          showlegend(legendtype,legendpos,25);
          end;

procedure legend_down;
          {
          Broken out from code body for Rev 6.1
          }
          begin
          wait_for_mouserelease;
          inc(legendpos,25);
          if (legendpos+25)>279 then legendpos:= 279-25;
          showlegend(legendtype,legendpos,25);
          end;


begin
  clrscr;
  initialize;
  directvideo:=false;
  read_levels;

  gd:= vga;
  gm:= vgahi;
  initgraph(gd,gm,'');

  settextstyle(0,0,1);
  mreset(themouse);

  show_objects:= true;
  show_floor:= false;
  stats :=false;
  copy  :=false;
  excng :=false;
  xfer  :=false;


  x:= port[$3da];
  port[$3c0]:= 0;

  setfillstyle(1,7);
  bar(0,0,64*7+MAP_X+4,64*7+MAP_Y+4);
  bar(64*7+MAP_X+9,0,639,380);
  setfillstyle(1,0);
  bar(2,2,64*7+MAP_X+2,64*7+MAP_Y+2);
  bar(64*7+MAP_X+11,2,637,380-28);
  bar(64*7+MAP_X+11,380-25,637,378);
  setcolor(15);
  outtextxy(64*7+MAP_X+15,380-16,' MAP  OBJ  UP  DOWN');
  setfillstyle(1,7);
  bar(64*7+MAP_X+11+043,380-25,64*7+MAP_X+11+044,378);
  bar(64*7+MAP_X+11+083,380-25,64*7+MAP_X+11+084,378);
  bar(64*7+MAP_X+11+113,380-25,64*7+MAP_X+11+114,378);

  legendpos:=0;
  legendtype:=0;
  mode:=map;

  {Rev 6.1}
  leftmapval:=1;   {Default values for buttons}
  rightmapval:=0;
  leftobjval:=1;
  rightobjval:=0;

  setfillstyle(1,0);

  bar(0,TEXTLOC+10,64*7+MAP_X,479);
  if mode=map then
    begin
      output(0,66,mapgraph[leftmapval]);
      outtext(1,66,15,' '+mapnames[leftmapval]);
    end
  else
    begin
      output(0,66,objgraph[leftmapval]);
      outtext(1,66,15,' '+objnames[leftmapval]);
    end;

  showlegend(legendtype,legendpos,25);

  x:= port[$3da];
  port[$3c0]:= 32;
  mshow;
  level:=1;
  done:= false;

  setfillstyle(1,0);
  setcolor(15);
  print_help;
  print_version;
  showcurrentselection;
  repeat
    mhide;
    setfillstyle(1,0);
    bar(0,TEXTLOC,64*2+MAP_X,TEXTLOC+9);
    setcolor(14);
    outtextxy(5,TEXTLOC,maps[level].name);
    setcolor(15);
    expand(maps[level].map,levelmap);
    expand(maps[level].objects,objectmap);
    display_map;
    print_stats;
    mshow;
    oldx:= 0;
    oldy:= 0;
    key:= #0;
    repeat
      repeat
        mpos(mouseloc);
        x:= mouseloc.column;
        y:= mouseloc.row;
      until (oldx<>x) or (oldy<>y) or keypressed or (mouseloc.buttonstatus<>0);
      oldx:= x;
      oldy:= y;
      if (mouseloc.buttonstatus<>0) then
        begin
          if inside(MAP_X,MAP_Y,64*7+MAP_X-1,64*7+MAP_Y-1,x,y) then
            begin
              {If inside the map display}
              mhide;
              repeat
                i:= (x - MAP_X) div 7;
                j:= (y - MAP_Y) div 7;

                process_buttons; {Rev 6.1}

                setfillstyle(1,0);
                dobar(i*7,j*7,i*7+6,j*7+6);
                if show_floor then
                  output(i,j,mapgraph[levelmap[i,j]])
                else
                  if not (levelmap[i,j] in [$6a..$8f]) then
                    output(i,j,mapgraph[levelmap[i,j]]);
                if show_objects then
                  output(i,j,objgraph[objectmap[i,j]]);
                mpos(mouseloc);
                x:= mouseloc.column;
                y:= mouseloc.row;
              until (not inside(MAP_X,MAP_Y,64*7+MAP_X-1,64*7+MAP_Y-1,x,y)) or
                    (mouseloc.buttonstatus=0);
              mshow;
              print_stats;
            end;
          if inside(464,355,506,378,x,y) then  {Inside MAP command box}
             set_map_mode;
          if inside(509,355,546,378,x,y) then  {Inside OBJECT command box}
             set_object_mode;
          if inside(549,355,576,378,x,y) then  {Inside UP command box}
             legend_up;
          if inside(579,355,637,378,x,y) then  {Inside DOWN command box}
             legend_down;
        end;
      if inside(464,2,637,350,x,y) then
        {If inside the legend box}
        begin
          mhide;
          j:= (y-2) div 14;
          setcolor(15);
          rectangle(465,j*14+2+1,636,j*14+2+12); {Magic numbers, BLECH!}
          repeat
            mpos(mouseloc);
            newj:= (mouseloc.row-2) div 14;
            if mouseloc.buttonstatus<>0 then
              begin

                {Rev 6.1:  Set current value based on button pressed}
                if mode=map then
                   if mouseloc.buttonstatus=leftbutton then
                      leftmapval:=legendpos+j
                   else
                      rightmapval:=legendpos+j
                else
                   if mouseloc.buttonstatus=leftbutton then
                      leftobjval:=legendpos+j
                   else
                      rightobjval:=legendpos+j;

                showcurrentselection;

              end;
          until (newj<>j) or (mouseloc.column<464) or keypressed;
          setcolor(0);
          rectangle(465,j*14+2+1,636,j*14+2+12);
          mshow;
        end;

      if inside(MAP_X,MAP_Y,64*7+MAP_X-1,64*7+MAP_Y-1,x,y) then
        begin
          {If inside the map display or the legend display}
          i:= (x - MAP_X) div 7;
          j:= (y - MAP_Y) div 7;
          if (oldj<>j) or (oldi<>i) then
            begin
              outstr:= '(';
              str(i:2,tempstr);
              outstr:= outstr+tempstr+',';
              str(j:2,tempstr);
              outstr:= outstr+tempstr+') MAP: '+mapnames[levelmap[i,j]];
              setfillstyle(1,0);
              setcolor(15);
              bar(188,TEXTLOC,64*7+MAP_X,479);
              outtextxy(188,TEXTLOC,outstr);
              outstr:= '        OBJ: '+objnames[objectmap[i,j]];
              outtextxy(188,TEXTLOC+10,outstr);
              oldj:= j;
              oldi:= i;
            end;
        end
      else
        begin
          mhide;
          setfillstyle(1,0);
	  bar(188,TEXTLOC,64*7+MAP_X,479);
          mshow;
        end;

      if keypressed then
        begin
          control:= false;
          key:= readkey;
          if key=#0 then
            begin
              control:= true;
              key:= readkey;
            end;
          if control then
            case key of
              'H':
                begin
                  freemem(maps[level].map.data,maps[level].map.size);
                  freemem(maps[level].objects.data,maps[level].objects.size);
                  compress(levelmap,maps[level].map);
                  compress(objectmap,maps[level].objects);
                  inc(level);
                end;
              'P':
                begin
                  freemem(maps[level].map.data,maps[level].map.size);
                  freemem(maps[level].objects.data,maps[level].objects.size);
                  compress(levelmap,maps[level].map);
                  compress(objectmap,maps[level].objects);
                  dec(level);
                end;

              {keyboard support added Rev 6.1}
              key_pgup : legend_up;
              key_pgdn : legend_down;

            end
          else
            case key of
              'q','Q':
                   begin
                     done:= true;
                     freemem(maps[level].map.data,maps[level].map.size);
                     freemem(maps[level].objects.data,maps[level].objects.size);

                     compress(levelmap,maps[level].map);
                     compress(objectmap,maps[level].objects);
                   end;
              'c','C': begin
                         if mode=map then
                          begin
                           clear_level(leftmapval);
                          end else
                          begin
                           clear_level($8c)  ;
                          end;
                       end;
              'o','O': begin
                         mhide;
                         show_objects:= not show_objects;
                         display_map;
                         mshow;
                       end;
              'f','F': begin
                         mhide;
                         show_floor:= not show_floor;
                         display_map;
                         if legendtype=0 then
                           showlegend(legendtype,legendpos,25);
                         mshow;
                       end;
             's','S': begin
                         stats := not stats;
                         if stats then print_stats
                         else print_help;
                      end;
             'm','M': begin
                         copy  := true;
                         print_help;
                         copy_level;
                         if stats then print_stats;
                      end;
             'e','E': begin
                         mhide;
                         excng := true;
                         print_help;
                         if copy then
                          begin
                            exchange;
                            display_map;
                          end;
                         excng := false;
                         print_help;
                         if stats then print_stats;
                         mshow;
                      end;
             't','T': begin
                         mhide;
                         xfer := true;
                         print_help;
                         if copy then
                          begin
                            paste_level ;
                            display_map;
                          end;
                         xfer := false;
                         print_help;
                         delay(200);
                         if stats then print_stats;
                         mshow;
                      end;
            'r','R': begin
                        setfillstyle(1,0);
                        bar(180,TEXTLOC,461,479);
                        setcolor(15);
                        outtextxy(180,TEXTLOC,'Reading FLOOR.OUT');
                        read_floor;
                        bar(180,TEXTLOC,461,479);
                        if stats then print_stats;
                     end;
            'w','W': begin
                        setfillstyle(1,0);
                        bar(180,TEXTLOC,461,479);
                        setcolor(15);
                        outtextxy(180,TEXTLOC,'Writing FLOOR.OUT');
                        write_floor;
                        bar(180,TEXTLOC,461,479);
                     end;
            'v','V': begin
                        print_version;
                     end;

            ' '    : if mode=map then {Rev 6.1 Toggles modes MAP<->OBJ}
                        set_object_mode
                     else
                        set_map_mode;


            end;
        end;
    until done or (key in ['P','H']);
    if level=0 then level:=LEVELS;
    if level=(LEVELS+1) then level:=1;
  until done;

  setfillstyle(1,0);
  bar(0,TEXTLOC,462,479);
  setcolor(15);
  outtextxy(0,TEXTLOC,' Save the current levels to disk? (Y/N) ');

  repeat
    repeat until keypressed;
    key:= readkey;
    if key=#0 then
      begin
        key:= readkey;
        key:= #0;
      end;
  until key in ['y','Y','n','N'];

  if key in ['y','Y'] then write_levels;
  textmode(co80);
  writeln('MapEdit 4.1                 Copyright (c) 1992  Bill Kirby');
  writeln;
  writeln('   Ver. '+VERSION+' (Dave Huntoon Modification)');
  writeln;
  writeln('This program is intended to be for your personal use only.');
  writeln('Distribution of any modified maps may be construed as a ');
  writeln('copyright violation by Apogee/ID.');
  writeln;
end.
