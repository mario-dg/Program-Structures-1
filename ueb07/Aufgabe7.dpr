{ ------------------------------------------------------------------------------
  Christopher Ploog, Mario da Graca                                   14.12.18

  Ein Programm zum Arbeiten mit Mengen und Records. Ziel des Programms ist es,
  Weihnachtsmärkte aufzulisten, mit ihren verschiedenen,
  Eigenschaften, um dem Benutzer einen Überblick zu verschaffen, damit ihm
  die Entscheidung leichet fällt, welchen er besuchen möchte.
  ---------------------------------------------------------------------------- }
program WeihnachtsmarktProgramm;

{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.SysUtils;

  // KONSANTEN /////////////////////////////////////////////////////////////////
const
  NOOF_CHRISTMAS_FAIRS = 5;

  // TYPEN /////////////////////////////////////////////////////////////////////
type
  // Attraktionen
  TAttraction = (atBratapfel, atBratwurst, atGlühwein, atRäuchermännchen,
    atWeihnachtsmann);
  TAttractionSet = set of TAttraction;

  // Anzahl der Buden
  TAnzahlBuden = 1 .. 200;

  // Weihnachtsmarkt Record
  TWeihnachtsmarkt = record
    Stadt: string;
    AnzBuden: TAnzahlBuden;
    Baum: boolean;
    Attraktion: TAttractionSet;
  end;

  // Weihnachtsmarkt Array
  TAnzWM = 0 .. NOOF_CHRISTMAS_FAIRS;

  TWeihnachtsmaerkte = Array [TAnzWM] of TWeihnachtsmarkt;

  // VARIABLEN /////////////////////////////////////////////////////////////////
var
  // Attraktionen String-Array für Ausgabe
  ATTRACTION_NAMES: array [TAttraction] of string = (
    'Bratapfel',
    'Bratwurst',
    'Glühwein',
    'Räuchermännchen',
    'Weihnachtsmann'
  );

  // Einzelner Weihnachtsmarkt - Record
  Weihnachtsmarkt: TWeihnachtsmarkt;

  Eingabe: string;

  AnzWM: TAnzWM;

  Fehler, AnzahlBuden, PassendeWM, Zaehler1, Zaehler2: integer;

  Laufwert: TAttraction;

  AttractionSet, UnbenutzteAttraktionen, ZwischenSchnittmenge,
    MehrfacheAttraktionen: TAttractionSet;

  // Alle Weihnachtsmärkte - Array
  Weihnachtsmaerkte: TWeihnachtsmaerkte;

  Abbruch: boolean;

  // HAUPTPROGRAMM /////////////////////////////////////////////////////////////
begin
  UnbenutzteAttraktionen := [Low(TAttraction) .. high(TAttraction)];
  MehrfacheAttraktionen := [];
  ZwischenSchnittmenge := [];
  PassendeWM := 0;
  Abbruch := False;

  // Array vom Basistyp des Records mit den Weihnachtsmärkten befüllen
  for AnzWM := Low(TAnzWM) to High(TAnzWM) do
  begin
    // Eingabe des Ortes - Mindestens 4 Buchstaben
    if not Abbruch then
    Begin
      Repeat
        write('Stadt eingeben (Mind. 4 Buchstaben): ');
        readln(Eingabe);
        if Eingabe = 'x' then
          Abbruch := True
        else if length(Eingabe) < 4 then
          writeln('Falsche Eingabe der Stadt. Bitte wiederholen!');

      Until ((length(Eingabe) >= 4) or (Abbruch));

      // Eingabe der Anzahl der Buden - 1 Bude bis 200 Buden
      if not Abbruch then
      begin
        Weihnachtsmarkt.Stadt := Eingabe;
        Repeat
          write('Anzahl der Buden eingeben (1-200 Stück): ');
          readln(Eingabe);
          if Eingabe = 'x' then
            Abbruch := True
          else
            val(Eingabe, AnzahlBuden, Fehler);
          if ((AnzahlBuden < Low(TAnzahlBuden)) or
            (AnzahlBuden > High(TAnzahlBuden))) then
          begin
            writeln('Falsche Eingabe Buden. Bitte wiederholen!');
            Fehler := 1;
          end
          else if Fehler <> 0 then
            writeln('Falsche Eingabe Buden. Bitte wiederholen!');
        Until ((Fehler = 0) or Abbruch);
      end;

      // Eingabe, ob ein Weihnachtsbaum aufgestellt ist
      if not Abbruch then
      begin
        Weihnachtsmarkt.AnzBuden := AnzahlBuden;

        Repeat
          write('Weihnachtsbaum vorhanden? (ja/nein): ');
          readln(Eingabe);
          if Eingabe = 'x' then
            Abbruch := True
          else if Eingabe = 'ja' then
            Weihnachtsmarkt.Baum := True
          else if Eingabe = 'nein' then
            Weihnachtsmarkt.Baum := False
          else
            writeln('Falsche Eingabe. Bitte Wiederholen!');
        Until (((Eingabe = 'ja') or (Eingabe = 'nein')) or (Abbruch));
      end;

      // Auswahl der vorgegeben Attraktionen
      // Bei ungültiger Eingabe von Attraktionen oder mehrfacher Eingabe
      // derselben Attraktion, geschieht nichts. Wenn keine Attraktion
      // hinzugefügt wurde oder nur Werte, die nicht in die Menge passen,
      // bietet der Weihnachtsmarkt keine Attraktionen an. Es kommt zu keiner
      // Fehlermeldung und das Programm stürzt auch nicht ab.
      if not Abbruch then
      begin
        writeln('Anttraktionen eingeben (+/-Attraktion)), Beenden mit x: ');
        writeln('(Möglich: Bratapfel, Bratwurst, Glühwein, Räuchermännchen, Weihnachtsmann):');
        AttractionSet := [];
        Repeat
          readln(Eingabe);

          //Bei +Attraltion, wird die Attraktion in dem Weihnachtsmarkt angeboten
          if Copy(Eingabe, 1, 1) = '+' then
          begin
            Delete(Eingabe, 1, 1);
            for Laufwert := Low(TAttraction) to High(TAttraction) do
            begin
              if Eingabe = ATTRACTION_NAMES[Laufwert] then
                AttractionSet := AttractionSet + [Laufwert];
            end;
          end;

          //Bei -Attraktion, kann die Attraktion wieder entfernt werden
          if Copy(Eingabe, 1, 1) = '-' then
          begin
            Delete(Eingabe, 1, 1);
            for Laufwert := Low(TAttraction) to High(TAttraction) do
            begin
              if Eingabe = ATTRACTION_NAMES[Laufwert] then
                AttractionSet := AttractionSet - [Laufwert];
            end;
          end;

          // Ausgabe der angebotenen Weihnachtsmärkte, damit der Benutzer weiß,
          // falls er eine falsche Eingabe getätigt hat und es nicht mitbekommen
          // hat, dass diese Attraktion nicht angeboten wird, obwohl er sie
          // eigentlich hinzufügen wollte
          writeln('Es werden folgende Attraktionen in diesem Weihnachtsmarkt angeboten: ');
          for Laufwert in AttractionSet do
          begin
            write(ATTRACTION_NAMES[Laufwert], ' ');
          end;
          writeln;
        Until Eingabe = 'x';
        Weihnachtsmarkt.Attraktion := AttractionSet;

        // Nur wenn der Weihnachtsmarkt mit gültigen Werten und komplett befüllt
        // wurde, wird der Markt ins Array übernommen
        Weihnachtsmaerkte[AnzWM] := Weihnachtsmarkt;

        writeln;
        inc(PassendeWM);
      end

      // Bei unvollständigen Record Eingaben oder bei Eingabe der Abbruch
      // Bedingung 'x', wird der Weihnachtsmarkt nicht in das Array übernommen
      else
      begin
        writeln('Eingabe nicht vollständig oder zu früh beendet.');
        writeln('Weihnachtsmarkt wird nicht übernommen!');
      end;

      // Bestimmung der Attraktionen, die nicht angeboten werden
      UnbenutzteAttraktionen := UnbenutzteAttraktionen - AttractionSet;

      writeln;
    end;

  end;

  // Ausgabe des gesamten Arrays mit allen Record-Werten
  for AnzWM := Low(TAnzWM) to PassendeWM - 1 do
  begin
    writeln(AnzWM + 1, '.Weihnachtsmarkt eingebeben:');
    writeln('Stadt: ', Weihnachtsmaerkte[AnzWM].Stadt);
    writeln('Anzahl Buden: ', Weihnachtsmaerkte[AnzWM].AnzBuden);
    writeln('Weihnachtsbaum vorhanden?: ', Weihnachtsmaerkte[AnzWM].Baum);
    write('Attraktionen: ');
    for Laufwert in Weihnachtsmaerkte[AnzWM].Attraktion do
    begin
      write(ATTRACTION_NAMES[Laufwert], ' ');
    end;
    writeln;
    writeln;
  end;

  // Bestimmung und Ausgabe der Attraktionen die nicht vorkommen, bei mehr als
  // einem Weihnachtsmarkt
  if PassendeWM >= 2 then
  begin
    write('Attraktionen, die nicht angeboten werden: ');
    for Laufwert in UnbenutzteAttraktionen do
      write(ATTRACTION_NAMES[Laufwert], ' ');
  end;
  writeln;

  // Bestimmung der Attraktionen die in mindestens einem Weihnachtsmarkt
  // angeboten werden (A)
  for Zaehler1 := Low(AnzWM) to High(AnzWM) - 1 do
  begin
    for Zaehler2 := (Zaehler1 + 1) to High(AnzWM) do
    begin
      ZwischenSchnittmenge := Weihnachtsmaerkte[Zaehler1].Attraktion *
        Weihnachtsmaerkte[Zaehler2].Attraktion;
      MehrfacheAttraktionen := ZwischenSchnittmenge + MehrfacheAttraktionen;
    end;
  end;

  // Ausgabe dieser Attraktionen (A)
  write('Attraktionen, die mehrfach angeboten werden: ');
  for Laufwert in MehrfacheAttraktionen do
  begin
    write(ATTRACTION_NAMES[Laufwert], ' ');
  end;

  readln;

end.
