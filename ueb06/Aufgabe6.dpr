{ ------------------------------------------------------------------------------
  Christopher Ploog, Mario da Graca                                   07.12.18

  Ein Programm zum Arbeiten mit 1-Dimensionalen und 2-Dimensionalen Arrays,
  anhand eines 2D Arrays, in dem eine zufällige Landschaft erstellt wird,
  welche sich anhand gegebener Regeln "entwickelt". In einem 1D Array, wird
  die Anzahl der verschiedenen Kästchen im gesamten 2D Array gezählt und
  ausgegeben.
  ---------------------------------------------------------------------------- }
program Arrays;

{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.SysUtils,
  Windows;

const
  FELD_BREITE = 20;
  FELD_HOEHE = 20;

type
  TFeldBreite = 1 .. FELD_BREITE;
  TFeldHoehe = 1 .. FELD_HOEHE;
  TFarbe = (clDunkelrot, clHellRot, clGelb, clHellgrün, clGrün, clBlau,
    clHellblau, clMagenta);
  TFeld = array [TFeldBreite, TFeldHoehe] of TFarbe;
  TZaehlerArray = array [TFarbe] of word;

var
  Farbe: TFarbe;
  Feld, KopieFeld: TFeld;
  CounterArray: TZaehlerArray;
  FeldBreite: TFeldBreite;
  FeldHoehe: TFeldHoehe;
  NeueOrdZahl, AnzWerte, GesOrdWerte: byte;
  xK, yK: integer;
  Eingabe: shortstring;
  Check, ErsterDurchlauf: boolean;

  // Setzt die Textfarbe der Konsole auf den übergebenen Wert.
  // 0 = schwarz, 1 = dunkelblau, 2 = dunkelgrün, 3 = türkis, 4 = rot, 5 = lila,
  // 6 = gelbbraun, 7 = hellgrau, 8 = dunkelgrau, 9 = blau, 10 = hellgrün,
  // 11 = hellblau, 12 = hellrot, 13 = magenta, 14 = gelb, 15 = weiß
procedure setzeTextFarbe(color: word);
begin
  if SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), color) then;
end;

// Setzt die Ausgabeposition der Konsole auf die angegebene Koordinate.
// 0/0 ist oben links.
procedure konsolePositionieren(x, y: byte);
var
  koord: _COORD;
begin
  koord.x := x;
  koord.y := y;
  if SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), koord) then;
end;

begin
  ErsterDurchlauf := true;
  Randomize;
  Repeat
    if not ErsterDurchlauf
    then readln(Eingabe);

    Check := false;
    ErsterDurchlauf := false;
    // Füllt das Array mit zufälligen Werten aus unserem DatenTyp TFarbe
    konsolePositionieren(0, 0);
    for FeldBreite := Low(FeldBreite) to High(FeldBreite) do
    begin
      for FeldHoehe := Low(FeldHoehe) to High(FeldHoehe) do
      begin
        // anstelle von Werten füllen wir das Array mit dem Zeichen '█' und
        // färben dies in der entsprechenden, oben zufällig gewählten Farbe
        Feld[FeldBreite, FeldHoehe] := TFarbe(random(ord(High(TFarbe)) + 1));
        case Feld[FeldBreite, FeldHoehe] of
          clDunkelrot:
            setzeTextFarbe(4);
          clHellRot:
            setzeTextFarbe(12);
          clGelb:
            setzeTextFarbe(14);
          clHellgrün:
            setzeTextFarbe(10);
          clGrün:
            setzeTextFarbe(2);
          clBlau:
            setzeTextFarbe(9);
          clHellblau:
            setzeTextFarbe(11);
          clMagenta:
            setzeTextFarbe(13);
        end;
        write('█');
      end;
      writeln;
    end;

    // Zählt die Anzahl der Kästchen jeder Farbe
    for Farbe := Low(Farbe) to High(Farbe) do
    begin
      CounterArray[Farbe] := 0;
      for FeldBreite := Low(FeldBreite) to High(FeldBreite) do
      begin
        for FeldHoehe := Low(FeldHoehe) to High(FeldHoehe) do
        begin
          if (Feld[FeldBreite, FeldHoehe]) = (TFarbe(Farbe)) then
            CounterArray[Farbe] := CounterArray[Farbe] + 1;
        end;
      end;
      // Ausgabe der Zählung in der entsprechenden Farbe
      case TFarbe(Farbe) of
        clDunkelrot:
          setzeTextFarbe(4);
        clHellRot:
          setzeTextFarbe(12);
        clGelb:
          setzeTextFarbe(14);
        clHellgrün:
          setzeTextFarbe(10);
        clGrün:
          setzeTextFarbe(2);
        clBlau:
          setzeTextFarbe(9);
        clHellblau:
          setzeTextFarbe(11);
        clMagenta:
          setzeTextFarbe(13);
      end;
      write(CounterArray[Farbe], '  ');
    end;
    writeln;


    Repeat
      readln(Eingabe);
      if not Check then
      begin
        // Entwickelt jedes Kästchen weiter, sodass sich bei jedem Enter-Befehl
        // das Array verändert. Abhängig von den umliegenden Kästchen
        for FeldBreite := Low(TFeldBreite) to High(TFeldBreite) do
        begin
          for FeldHoehe := Low(TFeldHoehe) to High(TFeldHoehe) do
          begin
            AnzWerte := 0;
            GesOrdWerte := 0;
            for xK := FeldBreite - 1 to FeldBreite + 1 do
            begin
              for yK := FeldHoehe - 1 to FeldHoehe + 1 do
              begin
                if (((xK >= Low(FeldBreite)) and (yK >= Low(FeldHoehe))) and
                  ((xK <= High(FeldBreite)) and (yK <= High(FeldHoehe)))) then
                begin
                  GesOrdWerte := GesOrdWerte + ord(Feld[xK, yK]);
                  AnzWerte := AnzWerte + 1;
                  //inc(AnzWerte);
                end;
              end;
            end;
            // Sonderfall(Wenn ein Kästchen keine Nachbarn hat): Sollte
            // eigentlich nicht eintreten, falls doch, wird der alte Wert
            // Übernommen
            if (AnzWerte = 0) then
              KopieFeld[FeldBreite, FeldHoehe] := Feld[FeldBreite, FeldHoehe]
            else
            begin
              NeueOrdZahl := Round(GesOrdWerte / AnzWerte);
              KopieFeld[FeldBreite, FeldHoehe] := TFarbe(NeueOrdZahl);
            end;
          end;
        end;

        // Jedes Feld aus dem neuen Array wird mit dem zugehörigen Feld aus
        // dem alten Array verglichen. Es wird solange weiterentwickelt, bis
        // beide Arrays identisch sind. Sind beide identisch, wird ein neues
        // zufälliges Array ausgegben
        Check := true;
        for FeldBreite := Low(FeldBreite) to High(FeldBreite) do
        begin
          for FeldHoehe := Low(FeldHoehe) to High(FeldHoehe) do
          begin
            if KopieFeld[FeldBreite, FeldHoehe] <> Feld[FeldBreite, FeldHoehe]
            then
              Check := false
          end;
        end;

        Feld := KopieFeld;
        konsolePositionieren(0, 0);

        // Ausgabe des neuen Feldes
        for FeldBreite := Low(TFeldBreite) to High(TFeldBreite) do
        begin
          for FeldHoehe := Low(TFeldHoehe) to High(TFeldHoehe) do
          begin
            case Feld[FeldBreite, FeldHoehe] of
              clDunkelrot:
                setzeTextFarbe(4);
              clHellRot:
                setzeTextFarbe(12);
              clGelb:
                setzeTextFarbe(14);
              clHellgrün:
                setzeTextFarbe(10);
              clGrün:
                setzeTextFarbe(2);
              clBlau:
                setzeTextFarbe(9);
              clHellblau:
                setzeTextFarbe(11);
              clMagenta:
                setzeTextFarbe(13);
            end;
            write('█');
          end;
          writeln;
        end;

        // Zählt die Anzahl der Kästchen jeder Farbe
        for Farbe := Low(Farbe) to High(Farbe) do
        begin
          CounterArray[Farbe] := 0;
          for FeldBreite := Low(FeldBreite) to High(FeldBreite) do
          begin
            for FeldHoehe := Low(FeldHoehe) to High(FeldHoehe) do
            begin
              if (Feld[FeldBreite, FeldHoehe]) = (TFarbe(Farbe)) then
                CounterArray[Farbe] := CounterArray[Farbe] + 1;
            end;
          end;
          // Ausgabe der Zählung in der entsürechenden Farbe
          case TFarbe(Farbe) of
            clDunkelrot:
              setzeTextFarbe(4);
            clHellRot:
              setzeTextFarbe(12);
            clGelb:
              setzeTextFarbe(14);
            clHellgrün:
              setzeTextFarbe(10);
            clGrün:
              setzeTextFarbe(2);
            clBlau:
              setzeTextFarbe(9);
            clHellblau:
              setzeTextFarbe(11);
            clMagenta:
              setzeTextFarbe(13);
          end;
          write(CounterArray[Farbe], '  ');
        end;
        writeln;
      end;

    Until ((Eingabe <> '') or (Check = true));

  Until Eingabe <> '';

end.
