program Aufgabe3;

{$APPTYPE CONSOLE}
{$R+,X-,Q+}

uses
  System.SysUtils;

var
  ifValidIf, ifValidCase, ifValidAlloc: boolean;
  Month, Day, Hour, Minute: byte;
  Year: word;

begin
  // EINGABE
  writeln('Welches Jahr haben wir?');
  readln(Year);
  writeln('Welchen Monate haben wir?');
  readln(Month);
  writeln('Welchen Tag haben wir?');
  readln(Day);
  writeln('Wie ist die Uhrzeit (Stunden)?');
  readln(Hour);
  writeln('Wie ist die Uhrzeit (Minuten)?');
  readln(Minute);

  // VERARBEITUNG
  writeln('Eingegebenes Datum: ', Day, '.', Month, '.', Year, ' ', Hour,
    ':', Minute);

  // IF ANWEISUNG
  if (Year >= 2000) and (Year <= 2099) then

    // MONATE MIT 31 TAGEN
    if (Month = 1) or (Month = 3) or (Month = 5) or (Month = 7) or (Month = 8)
      or (Month = 10) or (Month = 12) then
      if (Day >= 1) and (Day <= 31) then
        ifValidIf := True
      else
        ifValidIf := False

        // MONATE MIT 30 TAGEN
    else if (Month = 4) or (Month = 6) or (Month = 9) or (Month = 11) then
      if (Day >= 1) and (Day <= 30) then
        ifValidIf := True
      else
        ifValidIf := False

        // MONATE MIT 29 TAGEN
    else if (Month = 2) then
      if (Day >= 1) and (Day <= 29) then
        ifValidIf := True
      else
        ifValidIf := False;

  writeln('Das angegebene Datum entpsricht dem genormten Format: ', ifValidIf);
  readln;

end.
