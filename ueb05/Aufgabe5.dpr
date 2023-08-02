{ --------------------------------------------------------------------- }
{ Christopher Ploog, Mario da Graca                          30.11.2018 }
{ Ein Programm, um Berechnungen und Veränderungen an einem eingegebenen }
{ Satz vorzunehmen. }
{ --------------------------------------------------------------------- }

program Aufgabe5;

{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.SysUtils;

var
  BEingabe, Speicher: char;
  Satz, SatzD, Wort: string;
  AnzVok, AnzKon, Ort: word;
  i, k, m: integer;

begin
  // EINGABE
  Repeat
    // Anzeige des Menüs
    writeln('A) Satz eingeben');
    writeln('B) Anzahl Vokale und Konsonanten (getrennt) bestimmen');
    writeln('C) Ziffern durch die passenden Zahlwörter ersetzen');
    writeln('D) Satz wortweise sortieren');
    writeln('X) Ende');
    readln(BEingabe);

    // VERARBEITUNG
    case upcase(BEingabe) of
      // Eingabe des Satzes
      'A':
        begin
          writeln('Bitte geben Sie einen Satz ein:');
          readln(Satz);
        end;
      // Zählung der Konsonanten und Vokalen
      'B':
        begin
          if Satz <> '' then
          begin
            AnzVok := 0;
            AnzKon := 0;
            for i := 1 to length(Satz) do
            begin
              case upcase(Satz[i]) of
                'A', 'E', 'I', 'O', 'U':
                  AnzVok := AnzVok + 1;
                'B' .. 'D', 'F' .. 'H', 'J' .. 'N', 'P' .. 'T', 'V' .. 'Z':
                  AnzKon := AnzKon + 1;
              end;
            end;
            writeln;
            writeln(AnzVok, ' Vokale, ', AnzKon,
              ' Konsonanten im Satz gefunden');
            writeln;
          end
          else
            writeln('Bitte geben Sie zuerst einen Satz ein!');
          writeln;
        end;
      // Ersetzen von Ziffern durch ihre ausgeschriebene Form
      'C':
        begin
          if Satz <> '' then
          begin
            i := 1;
            While (i <= length(Satz)) do
            begin
              case Satz[i] of
                '0':
                  begin
                    Ort := Pos('0', Satz);
                    Delete(Satz, Ort, 1);
                    Insert('null', Satz, Ort);
                  end;
                '1':
                  begin
                    Ort := Pos('1', Satz);
                    Delete(Satz, Ort, 1);
                    Insert('eins', Satz, Ort);
                  end;
                '2':
                  begin
                    Ort := Pos('2', Satz);
                    Delete(Satz, Ort, 1);
                    Insert('zwei', Satz, Ort);
                  end;
                '3':
                  begin
                    Ort := Pos('3', Satz);
                    Delete(Satz, Ort, 1);
                    Insert('drei', Satz, Ort);
                  end;
                '4':
                  begin
                    Ort := Pos('4', Satz);
                    Delete(Satz, Ort, 1);
                    Insert('vier', Satz, Ort);
                  end;
                '5':
                  begin
                    Ort := Pos('5', Satz);
                    Delete(Satz, Ort, 1);
                    Insert('fünf', Satz, Ort);
                  end;
                '6':
                  begin
                    Ort := Pos('6', Satz);
                    Delete(Satz, Ort, 1);
                    Insert('sechs', Satz, Ort);
                  end;
                '7':
                  begin
                    Ort := Pos('7', Satz);
                    Delete(Satz, Ort, 1);
                    Insert('sieben', Satz, Ort);
                  end;
                '8':
                  begin
                    Ort := Pos('8', Satz);
                    Delete(Satz, Ort, 1);
                    Insert('acht', Satz, Ort);
                  end;
                '9':
                  begin
                    Ort := Pos('9', Satz);
                    Delete(Satz, Ort, 1);
                    Insert('neun', Satz, Ort);
                  end;
              end;
              i := i + 1;
            end;
            writeln(Satz);
          end
          else
            writeln('Bitte geben Sie zuerst einen Satz ein!');
          writeln;
        end;
      // Sortieren der Buchstaben innerhalb eines Wortes
      'D':
        begin
          if Satz <> '' then
          begin
            SatzD := Satz + ' ';

            While length(SatzD) > 0 do
            begin
              Wort := copy(SatzD, 1, Pos(' ', SatzD) - 1);
              Delete(SatzD, 1, Pos(' ', SatzD));
              for k := 1 to length(Wort) - 1 do
              begin
                for m := k + 1 to length(Wort) do
                begin
                  if Wort[k] > Wort[m] then
                  begin
                    Speicher := Wort[m];
                    Wort[m] := Wort[k];
                    Wort[k] := Speicher;
                  end;
                end;
              end;
              write(Wort + ' ');
            end;
            writeln;
          end
          else
            writeln('Bitte geben Sie zuerst einen Satz ein!');
          writeln;
        end;

    end;

  Until (BEingabe = 'X') or (BEingabe = 'x');

end.
