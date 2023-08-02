{Christopher Ploog, Mario da Graca         11.01.2019
 Ein Programm zum Arbeiten mit Prozeduren und Funktionen, welche alle mit
 Strings arbeiten
}

program Aufgabe8;

{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.SysUtils;

type
  TChar = set of AnsiChar;

  // FUNKTIONEN

  // Zählt die Wörter in einem string
  // @param
  // Satz - auszugebener String
  // @return
  // Gezählte Wörter
function CountWords(Satz: string): integer;
var
  AnzWort: integer;
begin
  AnzWort := 0;
  Repeat
    if Pos(' ', Satz) <> 0 then
    begin
      AnzWort := AnzWort + 1;
      Delete(Satz, Pos(' ', Satz), 1);
    end
    else
      CountWords := 0;
  until Pos(' ', Satz) = 0;

  if length(Satz) <> 0 then
    AnzWort := AnzWort + 1;
  // Hinter dem Letzten Wort ist kein LZ, muss trotzdem mitgezählt werden
  CountWords := AnzWort;
end;

// Zählt die Buchstaben in einem String
// @param
// Satz - einzugebener String
// @return
// Gezählte Buchstaben
function CountChars(Satz: string): integer;
var
  AnzChar, i: integer;
begin
  AnzChar := 0;
  if length(Satz) <> 0 then
    for i := 1 to length(Satz) do
    begin
      case Satz[i] of
        'a' .. 'z':
          AnzChar := AnzChar + 1;
        'A' .. 'Z':
          AnzChar := AnzChar + 1;
      end;
    end;
  CountChars := AnzChar;
end;

// Löscht alle Wörter, die mit einem Großbuchstaben beginnen
// @param
// Satz - einzugebener String
// @ out String ohne Nomen
procedure deleteNouns(var Satz: string);
var
  i, k: integer;
begin
  i := 1;
  if length(Satz) <> 0 then
  begin
    Satz := ' ' + Satz;
    while i <= length(Satz) do
    begin
      if (Satz[i] = ' ') then
      begin

        case Satz[i + 1] of
          'A' .. 'Z':
            begin
              k := 1;
              while not(i + k > length(Satz)) and (Satz[i + k] <> ' ') do
                inc(k);

              Delete(Satz, i, k);
              i := 1;
            end;

        end;
      end;
      inc(i);
    end;

    if (length(Satz) <> 0) and (Satz[1] = ' ') then
      Delete(Satz, 1, 1);
  end;
end;

// Zählt die Wörter in einem String, in dem alle Nomen gelöscht wurden
//@param
// Satz- einzugebener string
//@return
//Gezählte Wörter ohne Nomen
function countWordsWithoutNouns(Satz: string): integer;
begin
  deleteNouns(Satz);
  countWordsWithoutNouns := CountWords(Satz);
end;

// Zählt die Buchstaben aller Nomen in dem String
//@param
//Satz - einzugebener String
//@return
//Gezählte Buchstaben nur in den Nomen
function countCharsInNouns(Satz: string): integer;
var
  charcount: integer;
begin
  charcount := CountChars(Satz);
  deleteNouns(Satz);
  countCharsInNouns := charcount - CountChars(Satz);
end;

// Zählt wieviele verschiedene Buchstaben in dem String vorkommen
//@param
//Satz - einzugebener String
function countDifferentChars(Satz: string):integer;
var
  GrossB, KleinB: TChar;
  i: integer;
  k: AnsiChar;
  CounterA, Counterb: integer;
begin
  CounterA := 0;
  Counterb := 0;
  GrossB := [];
  KleinB := [];
  if length(Satz) <> 0 then
  begin
    for i := 1 to length(Satz) do
      case Satz[i] of
        'A' .. 'Z':
          GrossB := GrossB + [Satz[i]];
        'a' .. 'z':
          KleinB := KleinB + [Satz[i]];
      end;
  end;

  for k in GrossB do
  begin
    CounterA := CounterA + 1;
  end;
  //writeln('Es sind ', CounterA,' verschiedene Buchstaben in dem Satz mit Nomen enthalten');

  for k in KleinB do
  begin
    Counterb := Counterb + 1;
  end;
  //writeln('Es sind ', Counterb,' verschiedene Buchstaben in dem Satz ohne Nomen enthalten');
  countDifferentChars := CounterA + CounterB;
end;



var
  Satz: String;
  penis: integer;

begin
  readln;
end.
