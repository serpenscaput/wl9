{$A+,B-,D-,E-,F-,G-,I+,L-,N-,O-,R-,S-,V+,X-}
{$M 16384,0,655360}
program mapedit;

uses crt,graph,mouse;

const MAP_X = 5;
      MAP_Y = 5;
      TEXTLOC = 460;

type level_type = record
       map_size,
       object_size,
       end_size        : word;
       width,
       height          : word;
       name            : array[0..15] of byte;
       map_data,
       object_data,
       end_data        : pointer;
     end;

     grid = array[0..63,0..63] of word;

     filltype = (solid,check);
     doortype = (horiz,vert);


var levelmap,
    objectmap    : grid;
    levels       : array[1..10] of level_type;

    show_objects,
    show_floor   : boolean;

    mapgraph,
    objgraph     : array[0..255] of string[4];
    mapnames,
    objnames     : array[0..255] of string[20];

    themouse  : resetrec;
    mouseloc  : locrec;

procedure waitforkey;
var key: char;
begin
  repeat until keypressed;
  key:= readkey;
  if key=#0 then key:= readkey;
end;

procedure getkey(var key: char; var control: boolean);
begin
  control:= false;
  key:= readkey;
  if key=#0 then
    begin
      control:= true;
      key:= readkey;
    end;
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
  until (j=-1) or keypressed;
end;

procedure read_levels;
var head,map : file;
    s,o,
    size     : word;
    idsig    : string[4];
    level    : integer;
    levelptr : longint;
    tempstr  : string[16];
    map_pointer,
    object_pointer,
    end_pointer    : longint;

begin
  idsig:= '    ';
  tempstr:= '                ';
  assign(head,'maphead.wl1');
  {$I-}
  reset(head,1);
  {$I+}
  if ioresult<>0 then
    begin
      writeln('error opening MAPHEAD.WL1');
      halt(1);
    end;
  assign(map,'maptemp.wl1');
  {$I-}
  reset(map,1);
  {$I+}
  if ioresult<>0 then
    begin
      writeln('error opening MAPTEMP.WL1');
      halt(1);
    end;

  for level:= 1 to 10 do
    begin
      seek(head,2+(level-1)*4);
      blockread(head,levelptr,4);
      seek(map,levelptr);
      with levels[level] do
        begin
          blockread(map,map_pointer,4);
          blockread(map,object_pointer,4);
          blockread(map,end_pointer,4);
          blockread(map,map_size,2);
          blockread(map,object_size,2);
          blockread(map,end_size,2);
          blockread(map,width,2);
          blockread(map,height,2);
          blockread(map,name,16);
          getmem(map_data,map_size);
          s:= seg(map_data^);
          o:= ofs(map_data^);
          blockread(map,mem[s:o],map_size);
          getmem(object_data,object_size);
          s:= seg(object_data^);
          o:= ofs(object_data^);
          blockread(map,mem[s:o],object_size);
          getmem(end_data,end_size);
          s:= seg(end_data^);
          o:= ofs(end_data^);
          blockread(map,mem[s:o],end_size);
          blockread(map,idsig[1],4);
        end;
    end;
  close(map);
  close(head);
end;

procedure write_levels;
var head,map : file;
    abcd,
    s,o,
    size     : word;
    idsig    : string[4];
    level    : integer;
    levelptr : longint;
    tempstr  : string[16];
    map_pointer,
    object_pointer,
    end_pointer    : longint;

begin
  abcd:= $abcd;
  idsig:= '!ID!';
  tempstr:= 'TED5v1.0';
  assign(head,'maphead.wl1');
  rewrite(head,1);
  assign(map,'maptemp.wl1');
  rewrite(map,1);

  blockwrite(head,abcd,2);
  blockwrite(map,tempstr[1],8);
  levelptr:= 8;

  for level:= 1 to 10 do
    begin
      blockwrite(head,levelptr,4);
      with levels[level] do
        begin
          map_pointer:= levelptr+38;
          object_pointer:= map_pointer+map_size;
          end_pointer:= object_pointer+object_size;
          levelptr:= end_pointer+end_size+4;
          blockwrite(map,map_pointer,4);
          blockwrite(map,object_pointer,4);
          blockwrite(map,end_pointer,4);
          blockwrite(map,map_size,2);
          blockwrite(map,object_size,2);
          blockwrite(map,end_size,2);
          blockwrite(map,width,2);
          blockwrite(map,height,2);
          blockwrite(map,name,16);
          s:= seg(map_data^);
          o:= ofs(map_data^);
          blockwrite(map,mem[s:o],map_size);
          s:= seg(object_data^);
          o:= ofs(object_data^);
          blockwrite(map,mem[s:o],object_size);
          s:= seg(end_data^);
          o:= ofs(end_data^);
          blockwrite(map,mem[s:o],end_size);
          blockwrite(map,idsig[1],4);
        end;
    end;
  close(map);
  close(head);
end;

procedure expand(p: pointer; var g: grid);
var i,x,y : integer;
    s,o,
    data,
    count : word;
begin
  x:= 0;
  y:= 0;
  s:= seg(p^);
  o:= ofs(p^);
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
end;

procedure compress(g: grid; var p: pointer; var size: word);
var temp     : pointer;
    abcd,
    s,o,
    olddata,
    data,
    nextdata,
    count    : word;
    x,y,i    : integer;

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
  getmem(p,size);
  move(mem[seg(temp^):ofs(temp^)],mem[seg(p^):ofs(p^)],size);
  freemem(temp,8194);
end;

procedure clear_level(n: integer);
var x,y: integer;
begin
   mhide;
   for x:= 0 to 63 do
     for y:= 0 to 63 do
       begin
         levelmap[x,y]:= $8c;
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
  bar(64*7+MAP_X+13,5,639-5,380-30);
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

var gd,gm,
    i,j,x,y   : integer;
    infile    : text;
    level     : word;
    oldx,oldy : integer;
    done      : boolean;
    outstr,
    tempstr   : string;

    hexstr    : string[4];
    graphstr  : string[4];
    name      : string[20];
    junk      : char;

    legendpos : integer;
    legendtype: integer;
    newj        : integer;
    currenttype,
    currentval: integer;

    oldj,oldi : integer;

    key       : char;
    control   : boolean;

begin
  for i:= 0 to 255 do
    begin
      mapnames[i]:= 'unknown '+hex(i);
      objnames[i]:= 'unknown '+hex(i);
      mapgraph[i]:= '0010';
      objgraph[i]:= '0000';
    end;
  assign(infile,'mapdata.def');
  reset(infile);
  while not eof(infile) do
    begin
      readln(infile,hexstr,junk,graphstr,junk,name);
      mapnames[str_to_hex(hexstr)]:= name;
      mapgraph[str_to_hex(hexstr)]:= graphstr;
    end;
  close(infile);

  assign(infile,'objdata.def');
  reset(infile);
  while not eof(infile) do
    begin
      readln(infile,hexstr,junk,graphstr,junk,name);
      objnames[str_to_hex(hexstr)]:= name;
      objgraph[str_to_hex(hexstr)]:= graphstr;
    end;
  close(infile);


  directvideo:=false;
  read_levels;

  gd:= vga;
  gm:= vgahi;
  initgraph(gd,gm,'');

  settextstyle(0,0,1);
  mreset(themouse);

  show_objects:= true;
  show_floor:= false;

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


  legendpos:= 0;
  legendtype:= 0;
  currenttype:= 0;
  currentval:= 1;
  setfillstyle(1,0);
  bar(66*7+MAP_X,60*7+MAP_Y,637,61*7+MAP_Y);
  if currenttype=0 then
    begin
      output(66,60,mapgraph[currentval]);
      outtext(67,60,15,' - '+mapnames[currentval]);
    end
  else
    begin
      output(66,60,objgraph[currentval]);
      outtext(67,60,15,' - '+objnames[currentval]);
    end;


  showlegend(legendtype,legendpos,25);

  x:= port[$3da];
  port[$3c0]:= 32;
  mshow;
  level:=1;
  done:= false;
  repeat
    mhide;
    setfillstyle(1,0);
    bar(0,TEXTLOC,64*7-1+MAP_X,479);
    setcolor(15);
    str(level:2,tempstr);
    outtextxy(0,TEXTLOC,'Level: '+tempstr);
    expand(levels[level].map_data,levelmap);
    expand(levels[level].object_data,objectmap);
    display_map;
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
              mhide;
              repeat
                i:= (x - MAP_X) div 7;
                j:= (y - MAP_Y) div 7;
                if currenttype=0 then
                  levelmap[i,j]:= currentval
                else
                  objectmap[i,j]:= currentval;
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
            end;
          if inside(464,355,506,378,x,y) then
            begin
              wait_for_mouserelease;
              legendpos:= 0;
              legendtype:= 0;
              showlegend(legendtype,legendpos,25);
            end;
          if inside(509,355,546,378,x,y) then
            begin
              wait_for_mouserelease;
              legendpos:= 0;
              legendtype:= 1;
              showlegend(legendtype,legendpos,25);
            end;
          if inside(549,355,576,378,x,y) then
            begin
              wait_for_mouserelease;
              dec(legendpos,25);
              if legendpos<0 then legendpos:= 0;
              showlegend(legendtype,legendpos,25);
            end;
          if inside(579,355,637,378,x,y) then
            begin
              wait_for_mouserelease;
              inc(legendpos,25);
              if (legendpos+25)>255 then legendpos:= 255-25;
              showlegend(legendtype,legendpos,25);
            end;
        end;
      if inside(464,2,637,350,x,y) then
        begin
          mhide;
          j:= (y-2) div 14;
          setcolor(15);
          rectangle(465,j*14+2+1,636,j*14+2+12);
          repeat
            mpos(mouseloc);
            newj:= (mouseloc.row-2) div 14;
            if mouseloc.buttonstatus<>0 then
              begin
                currenttype:= legendtype;
                currentval:= legendpos+j;
                setfillstyle(1,0);
                bar(66*7+MAP_X,60*7+MAP_Y,637,61*7+MAP_Y);
                if currenttype=0 then
                  begin
                    output(66,60,mapgraph[currentval]);
                    outtext(67,60,15,' - '+mapnames[currentval]);
                  end
                else
                  begin
                    output(66,60,objgraph[currentval]);
                    outtext(67,60,15,' - '+objnames[currentval]);
                  end;
              end;
          until (newj<>j) or (mouseloc.column<464) or keypressed;
          setcolor(0);
          rectangle(465,j*14+2+1,636,j*14+2+12);
          mshow;
        end;

      if inside(MAP_X,MAP_Y,64*7+MAP_X-1,64*7+MAP_Y-1,x,y) then
        begin
          i:= (x - MAP_X) div 7;
          j:= (y - MAP_Y) div 7;
          if (oldj<>j) or (oldi<>i) then
            begin
              outstr:= '(';
              str(i:2,tempstr);
              outstr:= outstr+tempstr+',';
              str(j:2,tempstr);
              outstr:= outstr+tempstr+')    map: '+hex(levelmap[i,j]);
              outstr:= outstr+' - '+mapnames[levelmap[i,j]];
              setfillstyle(1,0);
              setcolor(15);
              bar(100,TEXTLOC,64*7+MAP_X-1,479);
              outtextxy(100,TEXTLOC,outstr);
              outstr:= '        object: '+hex(objectmap[i,j])+' - '+objnames[objectmap[i,j]];
              outtextxy(100,TEXTLOC+10,outstr);
              oldj:= j;
              oldi:= i;
            end;
        end
      else
        begin
          mhide;
          setfillstyle(1,0);
          bar(100,TEXTLOC,360,479);
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
                  freemem(levels[level].map_data,levels[level].map_size);
                  freemem(levels[level].object_data,levels[level].object_size);
                  compress(levelmap,levels[level].map_data,levels[level].map_size);
                  compress(objectmap,levels[level].object_data,levels[level].object_size);
                  inc(level);
                end;
              'P':
                begin
                  freemem(levels[level].map_data,levels[level].map_size);
                  freemem(levels[level].object_data,levels[level].object_size);
                  compress(levelmap,levels[level].map_data,levels[level].map_size);
                  compress(objectmap,levels[level].object_data,levels[level].object_size);
                  dec(level);
                end;
            end
          else
            case key of
              'q','Q':
                   begin
                     done:= true;
                     freemem(levels[level].map_data,levels[level].map_size);
                     freemem(levels[level].object_data,levels[level].object_size);
                     compress(levelmap,levels[level].map_data,levels[level].map_size);
                     compress(objectmap,levels[level].object_data,levels[level].object_size);
                   end;
              'H': begin
                     freemem(levels[level].map_data,levels[level].map_size);
                     freemem(levels[level].object_data,levels[level].object_size);
                     compress(levelmap,levels[level].map_data,levels[level].map_size);
                     compress(objectmap,levels[level].object_data,levels[level].object_size);
                     inc(level);
                   end;
              'P': begin
                     freemem(levels[level].map_data,levels[level].map_size);
                     freemem(levels[level].object_data,levels[level].object_size);
                     compress(levelmap,levels[level].map_data,levels[level].map_size);
                     compress(objectmap,levels[level].object_data,levels[level].object_size);
                     dec(level);
                   end;
              'c','C': clear_level(level);
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
            end;
        end;
    until done or (key in ['P','H']);
    if level=0 then level:=10;
    if level=11 then level:=1;
  until done;

  setfillstyle(1,0);
  bar(0,TEXTLOC,639,479);
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
end.