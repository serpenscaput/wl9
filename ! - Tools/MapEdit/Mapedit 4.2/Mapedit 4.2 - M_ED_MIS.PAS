{$A+,B-,D-,E-,F-,G-,I+,L-,N-,O-,R-,S-,V+,X-}
{$M 1048,0,1024}
unit M_Ed_Misc;
interface
type
  HexWordStr = string[sizeof(word)*2];
  HexByteStr = string[sizeof(byte)*2];
procedure WaitForKey;
procedure GetKey(var key: char; var extended: boolean);
function upper(s: string): string;
function Bytes2HexStr (var x; Size: byte): string;
function Word2HexWordStr (i: word): HexWordStr;
function Byte2HexByteStr( i: word ): HexByteStr;
function HexWordStr2Word( str: HexWordStr): word;
function HexByteStr2Byte( str: HexByteStr): byte;
function HexChar2Byte( c: char): byte;
procedure FillWord( var x; count: integer; value: word );

implementation
uses Crt;

procedure WaitForKey;
var key: char;
begin
  key:= readkey;
  if key=#0 then key:= readkey;
end;

procedure GetKey(var key: char; var extended: boolean);
begin
  key:= readkey;
  if key=#0 then
    begin
      extended:= true;
      key:= readkey;
    end
  else
    extended:= FALSE;
end;

function upper(s: string): string;
var i: integer;
begin
  upper[0]:= chr(length(s));
  for i:= 1 to length(s) do
    upper[i]:=upcase(s[i]);;
end;


function Bytes2HexStr (var x; Size: byte): string;
var
  BytePtr : ^byte;
  i : byte;
  c : char;
begin
Bytes2HexStr[0]:= chr(Size * 2);
BytePtr:= @x;
inc(BytePtr, Size);
for i:= 1 to Size do
  begin
  dec(BytePtr);
  c:= chr(BytePtr^ shr 4);
  if ord(c) <= 9
  then
    inc(c, ord('0'))
  else
    inc(c, ord('a')-10);
  Bytes2HexStr[i * 2 - 1]:= c;
  c:= chr(BytePtr^ and $0f);
  if ord(c) <= 9
  then
    inc(c, ord('0'))
  else
    inc(c, ord('a')-10);
  Bytes2HexStr[i * 2]:= c;
  end;
end;

function Word2HexWordStr( i: word ):HexWordStr;
begin
Word2HexWordStr:= Bytes2HexStr( i, sizeof(word));
end;

function Byte2HexByteStr( i: word ): HexByteStr;
begin
Byte2HexByteStr:= Bytes2HexStr( i, sizeof(word));
end;

function HexChar2Byte( c: char ): byte;
begin
case c of
  '0'..'9': HexChar2Byte:= ord(c) - ord('0');
  'a'..'f': HexChar2Byte:= ord(c) - ord('a') + 10;
  'A'..'F': HexChar2Byte:= ord(c) - ord('A') + 10;
  else HexChar2Byte:= 0;
  end; { of case }
end;

function HexWordStr2Word( str: HexWordStr): word;
var
  c  : char;
  i  : byte;
  ret: word;
begin
ret:= 0;
HexWordStr2Word:= 0;
for i:= 1 to sizeof(word) * 2 do
  begin
  ret:= ret * 16;
  c:= str[i];
  case c of
    '0'..'9': inc(ret ,ord(c) - ord('0'));
    'a'..'f': inc(ret, ord(c) - ord('a') + 10);
    'A'..'F': inc(ret, ord(c) - ord('A') + 10);
    else begin HexWordStr2Word:= 0; exit; end;
    end; { of case }
  end; { of for }
HexWordStr2Word:= ret;
end;
function HexByteStr2Byte( str: HexByteStr): byte;
var
  c  : char;
  i  : byte;
  ret: byte;
begin
HexByteStr2Byte:= 0;
for i:= 1 to sizeof(byte) * 2 do
  begin
  ret:= ret * 16;
  c:= str[i];
  case c of
    '0'..'9': inc(ret ,ord(c) - ord('0'));
    'a'..'f': inc(ret, ord(c) - ord('a') + 10);
    'A'..'F': inc(ret, ord(c) - ord('A') + 10);
    else begin HexByteStr2Byte:= 0; exit; end;
    end; { of case }
  end; { of for }
HexByteStr2Byte:= ret;
end;

procedure FillWord( var x; count: integer; value: word );assembler;
asm
   les  di,[x]
   mov  cx,[count]
   mov  ax,value
   rep  stosw
end;


end.