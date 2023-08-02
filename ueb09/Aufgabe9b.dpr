{ -----------------------------------------------------------------------------
  Christopher Ploog, Mario da Graca     18.01.2019
  Weiterführung von Zeigern und Listen
  -----------------------------------------------------------------------------
}
program Aufgab9b;

{$APPTYPE CONSOLE}
{$R+,Q+,x-}

uses
  System.SysUtils;

// TYPES
type
  PRecord = ^TIntegerRecord;

  TIntegerRecord = record
    Value: Integer;
    Next: PRecord;
  end;

  // PROCEDURES/FUNCTIONS

  // Fügt Element mit Value an Anfang der Liste hinzu
  // @param
  // First - Liste vor die das Element hinzugefügt wird
  // Wert - Von User in Listenelement als Value hinzufügen
procedure add(var First: PRecord; Wert: Integer);
var
  temp: PRecord;
begin
  new(temp);
  temp^.Value := Wert;
  temp^.Next := First;
  First := temp;
end;

// Prüft, ob Wert schon in Liste vorhanden
// @param
// First - Liste, in der geprüft wird, ob Wert vorhanden
// Wert - zu prüfender Wert
// @out
// Wert ist enthalten oder nicht : Boolean
function IsIn(var First: PRecord; Wert: Integer): Boolean;
var
  temp: PRecord;
begin
  IsIn := False;
  temp := First;
  while (temp <> nil) and (temp^.Value <> Wert) do
    temp := temp^.Next;
  IsIn := temp <> nil;
end;

// Gibt die gesamte Liste aus
// @param
// First - Liste, die ausgegebene werden soll
procedure print(First: PRecord);
var
  temp: PRecord;
begin
  temp := First;
  writeln('Die Liste enthält folgende Werte:');
  while temp <> nil do
  begin
    write(temp^.Value, ' ');
    temp := temp^.Next;
  end;
  writeln;
end;

// Berechnet den Mittelwert der Liste
// @param
// First - Liste, von der der Mittelwert berechnet werden soll
// @out
// Mittelwert der Liste
function calcAverage(First: PRecord): double;
var
  Addition, Counter: Integer;
  temp: PRecord;
begin
  temp := First;
  Counter := 0;
  Addition := 0;

  While temp <> nil do
  begin
    Addition := Addition + temp^.Value;
    inc(Counter);
    temp := temp^.Next;
  end;
  if Counter <> 0 then
    calcAverage := Addition / Counter
  else
    calcAverage := 0;
end;

// Liste wird freigegeben
// @param
// First - freizugebene Liste
procedure free(First: PRecord);
var
  temp: PRecord;
begin
  while First <> nil do
  begin
    temp := First;
    First := temp^.Next;
    Dispose(temp);
  end;
end;

// VARIABLES
var
  Eingabe: String;
  GanzeZahl, Code: Integer;
  IntegerListe: PRecord;
//MAIN PROGRAM
begin
  IntegerListe := nil;
  Repeat
    writeln('Bitte geben Sie eine ganze Zahl ein. (x zum Abbrechen)');
    readln(Eingabe);
    val(Eingabe, GanzeZahl, Code);
    // Prüfen, ob Eingabe ganzeZahl
    if Code = 0 then
    begin
      // Prüfen, ob Zahl schon in Liste
      if not(IsIn(IntegerListe, GanzeZahl)) then
      begin
        add(IntegerListe, GanzeZahl);
      end
      else
      begin
        writeln('Fehler! Zahl bereits in Liste.');
        writeln;
      end;
    end
    else if Eingabe <> 'x' then
    begin
      writeln('Fehler! Falsche Eingabe.');
      writeln;
    end
    else
    begin
      writeln('Eingabe abgebrochen.');
      writeln;
    end
    Until (Eingabe = 'x');
    // Gibt Liste aus
    print(IntegerListe);
    writeln;
    // Berechnet Mittelwert
    writeln('Der Mittelwert der Liste beträgt: ',
      calcAverage(IntegerListe):0:2);
      writeln;
    // Befreit Liste
    writeln('Drücken Sie Enter, um die Liste freizugeben: ');
    readln;
    free(IntegerListe);

end.
