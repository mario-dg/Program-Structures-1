{ Christopher Ploog, Mario da Graca        25.01.2019
  Aufgaben aus alten Klausuren
}

// Alte Klausuraufgaben.
program Aufgabe10;

{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.SysUtils,
  Windows;

// Konstanten zum An- und Ausschalten der Tests
const
  TESTE_TEILER_MENGE = true;
  TESTE_GEMEINSAME_TEILER = true; // benötigt TeilerMenge!
  TESTE_IST_PRIMZAHL = true; // benötigt TeilerMenge!
  TESTE_INIT = true;
  TESTE_ERSETZUNGEN = true;
  TESTE_ELEMENT_ANHAENGEN = true;
  TESTE_SUCHE_KENNZEICHEN = true; // benötigt ElementAnhaengen!

  // SS18, Aufgabe 2
  // Gegeben ist die folgende korrekte Typdeklaration eines Mengentyps:
type
  TZahlmenge = set of byte;
  // Deklarieren Sie eine Funktion TeilerMenge, die ausgehend von einer Zahl des
  // Typs byte alle ganzzahligen Teiler dieser Zahl ermittelt und in einer Menge
  // des Typs TZahlmenge als Funktionsergebnis liefert. Die Zahl 1 und die Zahl
  // selbst sollen nicht in der Ergebnismenge enthalten sein:
{$IF TESTE_TEILER_MENGE}

  // @param
  // Zahl - Einzugebene Zahl, dessen Teiler bestimmt werden sollen
  // @return
  // TeilerMenge - Menge aller Zahlen, die Teiler von "Zahl" sind
function TeilerMenge(Zahl: byte): TZahlmenge;
var
  temp: TZahlmenge;
  i: byte;
begin
  temp := [];
  // Durchlauf nur bis zur Hälfte der eingegebenen Zahl, da größere kein Teiler der Zahl
  for i := 2 to (Zahl div 2) do
  begin
    if (Zahl mod i) = 0 then
      temp := temp + [i];
  end;
  TeilerMenge := temp;
end;
{$ENDIF}
// Deklarieren Sie eine Funktion GemeinsameTeiler, die für zwei Zahlen des Typs
// byte die ganzzahligen Teiler ermittelt, die sowohl für die eine als auch für
// die andere Zahl ganzzahlige Teiler sind. Diese Teiler sollen in einer Menge
// des Typs TZahlmenge als Funktionsergebnis geliefert werden. Nutzen Sie zur
// Ermittlung der Teiler der Zahlen die Funktion TeilerMenge:
{$IF TESTE_GEMEINSAME_TEILER}

// @param
// Zahl1,Zahl2- Zahlen dessen Gemeinsame Teile bestimmt werden sollen
// @return
// GemeinsamerTeiler - Menge der Gemeinsamen Teiler von "Zahl1" und "Zahl2"
function GemeinsameTeiler(Zahl1, Zahl2: byte): TZahlmenge;
begin
  GemeinsameTeiler := TeilerMenge(Zahl1) * TeilerMenge(Zahl2);
end;
{$ENDIF}

// Deklarieren Sie eine boolesche Funktion IstPrimzahl, die ausgehend von einer
// Zahl des Typs byte ermittelt, ob diese eine Primzahl ist (Ergebniswert true)
// oder nicht (Ergebniswert false). Nutzen Sie zur Realisierung der Funktion die
// Funktion TeilerMenge:
{$IF TESTE_IST_PRIMZAHL}

// @param
// Zahl - Zu prüfende Zahl, ob diese eine Primzahl ist
// @return
// IstPrimzahl - Rückgabewert, ob "Zahl" eine Primzahl ist oder nicht
function IstPrimZahl(Zahl: byte): boolean;
begin
  IstPrimZahl := TeilerMenge(Zahl) = [];
end;
{$ENDIF}

// SS18, Aufgabe 3
// Gegeben sind die folgenden Typdeklarationen:
type
  TWortpaar = record
    Altwort: string;
    Neuwort: string;
  end;

  TErsetzungen = array [byte] of TWortpaar;
  // Deklarieren Sie eine Prozedur Init, die in einem übergebenen Wert des Typs
  // TErsetzungen alle String-Werte auf den leeren String setzt.
{$IF TESTE_INIT}

  // @param
  // Referenzparameter Wert - Zu veränderndes Array
  // @out
  // Array, dessen Record mit Leeren Strings gefüllt ist
procedure Init(var Wert: TErsetzungen);
var
  i: byte;
begin
  for i := Low(byte) to High(byte) do
  begin
    Wert[i].Altwort := '';
    Wert[i].Neuwort := '';
  end;
end;
{$ENDIF}
// Gegeben ist der folgende Funktionskopf:
{$IF TESTE_ERSETZUNGEN}

// @param
// Eingabe - String, dessen Altwörter durch die Neuwörter ersetzt werden
// Eretzungsliste - Array mit den Ersetzungswörtern
// @return
// Ersetzungen - String mit den ersetzten Wörtern
function Ersetzungen(Eingabe: string; Ersetzungsliste: TErsetzungen): string;
// Deklarieren Sie ausgehend von diesem Funktionskopf die Funktion Ersetzungen.
// Die Funktion soll für jedes Element des Arrays Ersetzungsliste den String-Wert
// von Altwort an allen Stellen seines Vorkommens in Eingabe durch den
// zugehörigen String-Wert von Neuwort ersetzen. Das Array Ersetzungsliste muss
// dabei nicht vollständig mit Wortpaaren gefüllt sein, der im Array genutzte
// Bereich endet beim ersten Array-Element, dessen Altwort-Wert der leere String
// ist.
// HINWEIS: Die Funktion soll die durch die Ersetzungen geänderte Eingabe
// als Funktionsergebnis zurückgeben.
// Es ist sichergestellt, daß kein Altwort in einem Neuwort enthalten
// ist (dann könnten Endlosersetzungen auftreten).
// Groß-/Kleinschreibung soll nicht beachtet werden.
var
  i: word;
  Position: integer;
  temp: String;
begin
  // Groß-/Kleinschreibung soll nicht beachtet werden.
  temp := lowercase(Eingabe);
  i := 0;
  // Array wird nur so lange durchgegangen, solange ein Altwort vorhanden ist
  While (Ersetzungsliste[i].Altwort <> '') and (i <= high(byte)) do
  begin
    Repeat
      // Wörter die mehrmals auftreten, werden immer ersetzt
      Position := Pos(lowercase(Ersetzungsliste[i].Altwort), temp);
      if Position <> 0 then
      begin
        Delete(temp, Position, length(Ersetzungsliste[i].Altwort));
        Insert(Ersetzungsliste[i].Neuwort, temp, Position);
      end;
    until Position = 0;
    inc(i);
  end;
  Ersetzungen := temp;
end;
{$ENDIF}

// SS18, Aufgabe 4
// Gegeben sind die folgenden Typdeklarationen zur Speicherung von
// KFZ-Kennzeichen in einem Array:
type
  TKennzeichen = record
    Stadt: string[3];
    Buchstaben: string[2];
    Nummer: word;
  end;

  TAlleKennzeichen = array [word] of TKennzeichen;
  // Deklarieren Sie die notwendigen Datentypen, damit Daten des Typs TKennzeichen
  // in den Info-Komponenten einer einfach verketteten dynamischen Liste
  // gespeichert werden können. Der notwendige Zeigertyp soll den Bezeichner TListe
  // tragen.
{$IF TESTE_ELEMENT_ANHAENGEN}
  TListe = ^TKennzeichenListe;

  TKennzeichenListe = record
    Info: TKennzeichen;
    Naechster: TListe;
  end;

  // Deklarieren Sie eine Prozedur ElementAnhaengen, die ausgehend von einem
  // Einstiegszeiger des Typs TListe ein zusätzliches Listenelement an die
  // zugreifbare Liste hinten anhängt. In dem Listenelement sollen übergebene Daten
  // des Typs TKennzeichen gespeichert werden.
  // @param
  // First - Liste, an die Element angehängt werden soll
  // Daten - Anzuhängenden Daten
  // @out
  // Liste, mit hinzugefügtem Element
procedure ElementAnhaengen(var First: TListe; Daten: TKennzeichen);
var
  temp, run: TListe;
begin
  // Neues Element wird erstellt
  new(temp);
  temp^.Naechster := nil;
  temp^.Info := Daten;
  run := First;
  // Bei leerer Liste, wird sie erzeugt
  if run = nil then
    First := temp
  else
  begin
    // Element ans Ende der Liste hängen
    while run^.Naechster <> nil do
      run := run^.Naechster;
    run^.Naechster := temp;
  end;

end;
{$ENDIF}
// Gegeben ist der folgende Funktionskopf:
{$IF TESTE_SUCHE_KENNZEICHEN}

// @param
// Kennzeichen - Arrays mit allen vorgegebenen Kennzeichen
// Suchdaten - Abzugleichende kennzeichen
// @out
// SucheKennzeichen - Zeiger der auf die Liste mit den gesuchten Kennzeichen zeigt
function SucheKennzeichen(Kennzeichen: TAlleKennzeichen;
  Suchdaten: TKennzeichen): TListe;
// Deklarieren Sie ausgehend vom angegebenen Funktionskopf die Funktion
// SucheKennzeichen. Die Funktion soll als Ergebnis den Einstiegszeiger in eine
// dynamische Liste mit dem Zeigertyp TListe liefern, in deren Elementen Daten
// des Typs TKennzeichen gespeichert sind. In der Liste sollen alle die
// Kennzeichendaten enthalten sein, die mit den übergebenen Suchdaten eine
// Übereinstimmung aufweisen. Die Übereinstimmung ist wie folgt zu prüfen:

// - Wenn für Stadt in Suchdaten der leere String angegeben ist, dann ist die
// Stadt als Auswahlkriterium irrelevant. Ansonsten müssen die Kennzeichendaten,
// die in die Ergebnisliste übernommen werden, den in Suchdaten angegebenen
// String-Wert für Stadt aufweisen.

// - Wenn für Buchstaben in Suchdaten der leere String angegeben ist, dann sind
// die Buchstaben als Auswahlkriterium irrelevant. Ansonsten müssen die
// Kennzeichendaten, die in die Ergebnisliste übernommen werden, den in
// Suchdaten angegebenen String-Wert für Buchstaben aufweisen.

// - Wenn für Nummer in den Suchdaten eine Null angegeben ist, dann ist die
// Nummer als Auswahlkriterium irrelevant. Ansonsten müssen die in die
// Ergebnisliste übernommenen Kennzeichendaten den in Suchdaten angegebenen
// Zahlwert für Nummer aufweisen.

// Verwenden Sie in der Funktion SucheKennzeichen die Prozedur ElementAnhaengen,
// um die Liste der gefundenen Kennzeichen jeweils zu verlängern.
// HINWEIS: "aufweisen" soll hier jeweils so gedeutet werden, daß die Werte
// gleich sind und nicht nur enthalten. Es sollen weiterhin alle die
// Kennzeichen in der Liste enthalten sein, die bei ALLEN Kriterien
// eine Übereinstimmung aufweisen, nicht nur bei einem davon.
var
  i: word;
  Stadt, Bs, Nummer: boolean;
  First: TListe;
begin
  First := nil;
  for i := Low(word) to High(word) do
  begin
    // Prüfen, ob Bedingungen zustimmen
    if Suchdaten.Stadt <> '' then
    begin
      // wenn ja, prüfen, ob Wert in irgendeinem Kennzeichen vorkommt
      Stadt := Suchdaten.Stadt = Kennzeichen[i].Stadt;
    end
    else
      Stadt := true;
    if Suchdaten.Buchstaben <> '' then
    begin
      Bs := Suchdaten.Buchstaben = Kennzeichen[i].Buchstaben;
    end
    else
      Bs := true;
    if Suchdaten.Nummer <> 0 then
    begin
      Nummer := Suchdaten.Nummer = Kennzeichen[i].Nummer;
    end
    else
      Nummer := true;

    // Wenn alles zu suchende Werte in Kennzeichen gefunden wurden, wird es hinzugefügt
    if Stadt and Bs and Nummer then
      ElementAnhaengen(First, Kennzeichen[i]);
  end;
  SucheKennzeichen := First;

end;
{$ENDIF}
// Hauptprogamm

// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!AB HIER NICHTS MEHR AENDERN!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

type
  TTextColor = word;
  TTestfallTM = byte;
  TErwartetTM = string;

  TTestfallGT = record
    Zahl1, Zahl2: byte;
  end;

  TErwartetGT = string;
  TTestfallIP = byte;
  TErwartetIP = boolean;

  TTestfallER = record
    Eingabe: string;
    EL: TErsetzungen;
  end;

  TErwartetER = string;

  TTestfallEA = record
    Stadt: string[3];
    Buchstaben: string[2];
    Nummer: word;
  end;

  TErwartetEA = string;

  TTestfallSK = record
    Stadt: string[3];
    Buchstaben: string[2];
    Nummer: word;
  end;

  TErwartetSK = string;

const
  TEXT_COLOR_NORMAL = 7;
  TEXT_COLOR_OK = 10;
  TEXT_COLOR_DOH = 12;
  ANZ_TESTS_TM = 6;
  ANZ_TESTS_GT = 7;
  ANZ_TESTS_IP = 6;
  ANZ_TESTS_ER = 2;
  ANZ_TESTS_EA = 4;
  ANZ_TESTS_SK = 5;

  TESTFAELLE_TM: array [1 .. ANZ_TESTS_TM] of TTestfallTM = (0, 1, 6,
    12, 23, 24);

  TESTFAELLE_GT: array [1 .. ANZ_TESTS_GT] of TTestfallGT = ((Zahl1: 0;
    Zahl2: 0), (Zahl1: 0; Zahl2: 1), (Zahl1: 0; Zahl2: 6), (Zahl1: 6; Zahl2: 0),
    (Zahl1: 6; Zahl2: 12), (Zahl1: 12; Zahl2: 13), (Zahl1: 12; Zahl2: 24));

  TESTFAELLE_IP: array [1 .. ANZ_TESTS_IP] of TTestfallIP = (0, 1, 2, 4,
    251, 255);

  TESTFAELLE_ER: array [1 .. ANZ_TESTS_ER] of TTestfallER =
    ((Eingabe: 'Professor Doktor Doktor Doktor honoris causa';
    EL: ((Altwort: 'Professor'; Neuwort: 'Prof.'), (Altwort: 'Doktor';
    Neuwort: 'Dr.'), (Altwort: 'honoris causa'; Neuwort: 'h.c.'), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: ''; Neuwort: ''))),
    (Eingabe: 'Wenn Fliegen hinter Fliegen fliegen, fliegen Fliegen Fliegen hinterher';
    EL: ((Altwort: 'Mücken'; Neuwort: 'sind doof'), (Altwort: 'Fliegen';
    Neuwort: 'Nudeln'), (Altwort: 'Wenn'; Neuwort: 'Lecker'), (Altwort: '';
    Neuwort: ''), (Altwort: 'hinterher'; Neuwort: 'wird nix'), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: '';
    Neuwort: ''), (Altwort: ''; Neuwort: ''), (Altwort: ''; Neuwort: ''))));

  TESTFAELLE_EA: array [1 .. ANZ_TESTS_EA] of TTestfallEA = ((Stadt: 'PI';
    Buchstaben: 'FH'; Nummer: 143), (Stadt: 'HH'; Buchstaben: 'EH'; Nummer: 1),
    (Stadt: 'B'; Buchstaben: 'UH'; Nummer: 0), (Stadt: 'KI'; Buchstaben: 'LL';
    Nummer: 666));

  TESTFAELLE_SK: array [1 .. ANZ_TESTS_SK] of TTestfallSK = ((Stadt: 'PI';
    Buchstaben: 'FH'; Nummer: 143), (Stadt: ''; Buchstaben: 'EH'; Nummer: 1),
    (Stadt: 'B'; Buchstaben: ''; Nummer: 10), (Stadt: 'KI'; Buchstaben: 'LL';
    Nummer: 0), (Stadt: 'HEI'; Buchstaben: 'DE'; Nummer: 1));

  ERWARTET_TM: array [1 .. ANZ_TESTS_TM] of TErwartetTM = ('[]', '[]', '[2,3]',
    '[2,3,4,6]', '[]', '[2,3,4,6,8,12]');

  ERWARTET_GT: array [1 .. ANZ_TESTS_GT] of TErwartetGT = ('[]', '[]', '[]',
    '[]', '[2,3]', '[]', '[2,3,4,6]');

  ERWARTET_IP: array [1 .. ANZ_TESTS_IP] of TErwartetIP = (true, true, true,
    false, true, false);

  ERWARTET_ER: array [1 .. ANZ_TESTS_ER] of TErwartetER =
    ('Prof. Dr. Dr. Dr. h.c.',
    'Lecker Nudeln hinter Nudeln Nudeln, Nudeln Nudeln Nudeln hinterher');

  ERWARTET_EA: array [1 .. ANZ_TESTS_EA] of TErwartetEA = ('PI-FH 143 -> nil',
    'PI-FH 143 -> HH-EH 1 -> nil', 'PI-FH 143 -> HH-EH 1 -> B-UH 0 -> nil',
    'PI-FH 143 -> HH-EH 1 -> B-UH 0 -> KI-LL 666 -> nil');

  ERWARTET_SK: array [1 .. ANZ_TESTS_SK] of TErwartetSK = ('PI-FH 143 -> nil',
    'SE-EH 1 -> nil', 'B-LA 10 -> nil', 'KI-LL 123 -> nil', ' -> nil');

{$IF TESTE_TEILER_MENGE or TESTE_GEMEINSAME_TEILER or TESTE_IST_PRIMZAHL or
     TESTE_INIT or TESTE_ERSETZUNGEN or TESTE_ELEMENT_ANHAENGEN or
     TESTE_SUCHE_KENNZEICHEN}

var
  color: byte;
  i: word;
  ok, abbruch: boolean;
  scrBufferInfo: _CONSOLE_SCREEN_BUFFER_INFO;
{$ENDIF}
{$IF TESTE_INIT}
  ers: TErsetzungen;
  sSoll: string;
{$ENDIF}
{$IF TESTE_ELEMENT_ANHAENGEN}
  liste: TListe;
  kennz: TKennzeichen;
{$ENDIF}
{$IF TESTE_SUCHE_KENNZEICHEN}
  ak: TAlleKennzeichen;

const
  K: array [0 .. 6] of TKennzeichen = ((Stadt: 'API'; Buchstaben: 'FH';
    Nummer: 143), (Stadt: 'PI'; Buchstaben: 'F'; Nummer: 143), (Stadt: 'PI';
    Buchstaben: 'FH'; Nummer: 14), (Stadt: 'PI'; Buchstaben: 'FH'; Nummer: 143),
    (Stadt: 'SE'; Buchstaben: 'EH'; Nummer: 1), (Stadt: 'B'; Buchstaben: 'LA';
    Nummer: 10), (Stadt: 'KI'; Buchstaben: 'LL'; Nummer: 123));
{$ENDIF}

procedure setTextColor(color: TTextColor);
begin
  if SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), color) then;
end;

function ZahlmengeZuString(zm: TZahlmenge): string;
var
  s: string;
  i: byte;
begin
  s := '[';

  for i in zm do
    s := s + inttostr(i) + ',';

  // Letztes , ggf. löschen, wenn nicht die leere Menge
  if zm <> [] then
    s := copy(s, 1, length(s) - 1);

  ZahlmengeZuString := s + ']';
end;

function ErsetzungenZuString(ers: TErsetzungen): string;
var
  i: byte;
  s: string;
begin
  s := '';

  for i := low(byte) to high(byte) do
    s := s + ers[i].Altwort + '->' + ers[i].Neuwort + ',';

  // Letztes , löschen vor der Rückgabe
  ErsetzungenZuString := copy(s, 1, length(s) - 1);
end;

{$IF TESTE_ELEMENT_ANHAENGEN}

function ListeZuString(liste: TListe): string;
var
  s: string;
begin
  s := '';
  while liste <> nil do
  begin
    s := s + string(liste^.Info.Stadt) + '-' + string(liste^.Info.Buchstaben) +
      ' ' + inttostr(liste^.Info.Nummer);
    if liste^.Naechster <> nil then
      s := s + ' -> ';

    liste := liste^.Naechster;
  end;

  ListeZuString := s + ' -> nil';
end;

procedure LoescheListe(var liste: TListe);
var
  tmp: TListe;
begin
  while liste <> nil do
  begin
    tmp := liste;
    liste := liste^.Naechster;
    dispose(tmp);
  end;
  liste := nil;
end;
{$ENDIF}

function KennzeichenZuString(ak: TAlleKennzeichen): string;
var
  s: string;
  i: cardinal;
begin
  s := '';
  i := low(word);

  while (i <= high(word)) and ((ak[i].Stadt <> '') or (ak[i].Buchstaben <> '')
    or (ak[i].Nummer <> 0)) do
  begin
    if ak[i].Stadt = '' then
      s := s + ''''''
    else
      s := s + string(ak[i].Stadt);
    s := s + '-';
    if ak[i].Buchstaben = '' then
      s := s + ''''''
    else
      s := s + string(ak[i].Buchstaben);

    s := s + ' ' + inttostr(ak[i].Nummer) + '   ';
    inc(i);
  end;

  KennzeichenZuString := s + '[...]';
end;

begin
  randomize;

{$IF TESTE_TEILER_MENGE or TESTE_GEMEINSAME_TEILER or TESTE_IST_PRIMZAHL or
       TESTE_INIT or TESTE_ERSETZUNGEN or TESTE_ELEMENT_ANHAENGEN or
       TESTE_SUCHE_KENNZEICHEN}
  ok := true;
{$ENDIF}
  setTextColor(TEXT_COLOR_NORMAL);

  // Tests fuer TeilerMenge
{$IF TESTE_TEILER_MENGE}
  writeln('TEILER_MENGE:');
  for i := 1 to ANZ_TESTS_TM do
  begin
    writeln('Aufruf: TeilerMenge(', TESTFAELLE_TM[i], ')');
    writeln('Erwartet: ', ERWARTET_TM[i]);
    write('Bekommen: ');

    if (ZahlmengeZuString(TeilerMenge(TESTFAELLE_TM[i])) = ERWARTET_TM[i]) then
      setTextColor(TEXT_COLOR_OK)
    else
    begin
      setTextColor(TEXT_COLOR_DOH);
      ok := false;
    end;
    writeln(ZahlmengeZuString(TeilerMenge(TESTFAELLE_TM[i])));
    setTextColor(TEXT_COLOR_NORMAL);
    writeln('');
  end;
  writeln('');
  writeln('');
{$ENDIF}

  // Tests fuer GemeinsameTeiler
{$IF TESTE_GEMEINSAME_TEILER}
  writeln('GEMEINSAME_TEILER:');
  for i := 1 to ANZ_TESTS_GT do
  begin
    writeln('Aufruf: GemeinsameTeiler(', TESTFAELLE_GT[i].Zahl1, ', ',
      TESTFAELLE_GT[i].Zahl2, ')');
    writeln('Erwartet: ', ERWARTET_GT[i]);
    write('Bekommen: ');

    if (ZahlmengeZuString(GemeinsameTeiler(TESTFAELLE_GT[i].Zahl1,
      TESTFAELLE_GT[i].Zahl2)) = ERWARTET_GT[i]) then
      setTextColor(TEXT_COLOR_OK)
    else
    begin
      setTextColor(TEXT_COLOR_DOH);
      ok := false;
    end;
    writeln(ZahlmengeZuString(GemeinsameTeiler(TESTFAELLE_GT[i].Zahl1,
      TESTFAELLE_GT[i].Zahl2)));
    setTextColor(TEXT_COLOR_NORMAL);
    writeln('');
  end;
  writeln('');
  writeln('');
{$ENDIF}

  // Tests fuer IstPrimzahl
{$IF TESTE_IST_PRIMZAHL}
  writeln('IST_PRIMZAHL:');
  for i := 1 to ANZ_TESTS_IP do
  begin
    writeln('Aufruf: IstPrimzahl(', TESTFAELLE_IP[i], ')');
    writeln('Erwartet: ', ERWARTET_IP[i]);
    write('Bekommen: ');

    if (IstPrimZahl(TESTFAELLE_IP[i]) = ERWARTET_IP[i]) then
      setTextColor(TEXT_COLOR_OK)
    else
    begin
      setTextColor(TEXT_COLOR_DOH);
      ok := false;
    end;
    writeln(IstPrimZahl(TESTFAELLE_IP[i]));
    setTextColor(TEXT_COLOR_NORMAL);
    writeln('');
  end;
  writeln('');
  writeln('');
{$ENDIF}

  // Tests fuer Init
{$IF TESTE_INIT}
  for i := low(byte) to high(byte) do
  begin
    ers[i].Altwort := inttostr(random(256));
    ers[i].Neuwort := inttostr(random(256));
  end;

  writeln('INIT:');
  writeln('Aufruf: Init(', ErsetzungenZuString(ers), ')');
  write('Erwartet: ');
  sSoll := '';
  for i := low(byte) to high(byte) - 1 do
    sSoll := sSoll + '->,';
  sSoll := sSoll + '->';
  writeln(sSoll);
  write('Bekommen: ');

  Init(ers);
  if (ErsetzungenZuString(ers) = sSoll) then
    setTextColor(TEXT_COLOR_OK)
  else
  begin
    setTextColor(TEXT_COLOR_DOH);
    ok := false;
  end;
  writeln(ErsetzungenZuString(ers));
  setTextColor(TEXT_COLOR_NORMAL);
  writeln('');
  writeln('');
{$ENDIF}

  // Tests fuer Ersetzungen
{$IF TESTE_ERSETZUNGEN}
  writeln('ERSETZUNGEN:');
  for i := 1 to ANZ_TESTS_ER do
  begin
    writeln('Aufruf: Ersetzungen(', TESTFAELLE_ER[i].Eingabe, ', ',
      ErsetzungenZuString(TESTFAELLE_ER[i].EL), ')');
    writeln('Erwartet: ', ERWARTET_ER[i]);
    write('Bekommen: ');

    if (Ersetzungen(TESTFAELLE_ER[i].Eingabe, TESTFAELLE_ER[i].EL)
      = ERWARTET_ER[i]) then
      setTextColor(TEXT_COLOR_OK)
    else
    begin
      setTextColor(TEXT_COLOR_DOH);
      ok := false;
    end;
    writeln(Ersetzungen(TESTFAELLE_ER[i].Eingabe, TESTFAELLE_ER[i].EL));
    setTextColor(TEXT_COLOR_NORMAL);
    writeln('');
  end;
  writeln('');
  writeln('');
{$ENDIF}

  // Tests fuer ElementAnhaengen
{$IF TESTE_ELEMENT_ANHAENGEN}
  writeln('ELEMENT_ANHAENGEN:');
  liste := nil;
  for i := 1 to ANZ_TESTS_EA do
  begin
    kennz.Stadt := TESTFAELLE_EA[i].Stadt;
    kennz.Buchstaben := TESTFAELLE_EA[i].Buchstaben;
    kennz.Nummer := TESTFAELLE_EA[i].Nummer;
    writeln('Aufruf: ElementAnhaengen(', ListeZuString(liste), ', [',
      kennz.Stadt, ', ', kennz.Buchstaben, ', ', kennz.Nummer, '])');
    writeln('Erwartet: ', ERWARTET_EA[i]);
    write('Bekommen: ');

    ElementAnhaengen(liste, kennz);
    if (ListeZuString(liste) = ERWARTET_EA[i]) then
      setTextColor(TEXT_COLOR_OK)
    else
    begin
      setTextColor(TEXT_COLOR_DOH);
      ok := false;
    end;
    writeln(ListeZuString(liste));
    setTextColor(TEXT_COLOR_NORMAL);
    writeln('');
  end;
  LoescheListe(liste);
  writeln('');
  writeln('');
{$ENDIF}

  // Tests fuer SucheKennzeichen
{$IF TESTE_SUCHE_KENNZEICHEN}
  writeln('SUCHE_KENNZEICHEN:');
  // Array mit Testeinträgen aufbauen
  liste := nil;
  for i := low(word) to high(word) do
    if i < 7 then
      ak[i] := K[i]
    else
    begin
      ak[i].Stadt := '';
      ak[i].Buchstaben := '';
      ak[i].Nummer := 0;
    end;

  for i := 1 to ANZ_TESTS_SK do
  begin
    kennz.Stadt := TESTFAELLE_SK[i].Stadt;
    kennz.Buchstaben := TESTFAELLE_SK[i].Buchstaben;
    kennz.Nummer := TESTFAELLE_SK[i].Nummer;

    liste := SucheKennzeichen(ak, kennz);

    if kennz.Stadt = '' then
      kennz.Stadt := '''''';
    if kennz.Buchstaben = '' then
      kennz.Buchstaben := '''''';

    writeln('Aufruf: SucheKennzeichen(', KennzeichenZuString(ak), ', [',
      kennz.Stadt, ', ', kennz.Buchstaben, ', ', kennz.Nummer, '])');
    writeln('Erwartet: ', ERWARTET_SK[i]);
    write('Bekommen: ');

    if (ListeZuString(liste) = ERWARTET_SK[i]) then
      setTextColor(TEXT_COLOR_OK)
    else
    begin
      setTextColor(TEXT_COLOR_DOH);
      ok := false;
    end;
    writeln(ListeZuString(liste));
    LoescheListe(liste);
    setTextColor(TEXT_COLOR_NORMAL);
    writeln('');
  end;
  writeln('');
  writeln('');
{$ENDIF}


  // Gesamt-Erfolgsmeldung blinkend ausgeben
{$IF TESTE_TEILER_MENGE or TESTE_GEMEINSAME_TEILER or TESTE_IST_PRIMZAHL or
       TESTE_INIT or TESTE_ERSETZUNGEN or TESTE_ELEMENT_ANHAENGEN or
       TESTE_SUCHE_KENNZEICHEN}
  writeln('');
  color := TEXT_COLOR_NORMAL;
  // Position merken
  if GetConsoleScreenBufferInfo(GetStdHandle(STD_OUTPUT_HANDLE), scrBufferInfo)
  then
  begin
    repeat
      if SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),
        scrBufferInfo.dwCursorPosition) then
      begin
        // Farbe abwechselnd setzen
        if (color <> TEXT_COLOR_NORMAL) then
          color := TEXT_COLOR_NORMAL
        else if ok then
          color := TEXT_COLOR_OK
        else
          color := TEXT_COLOR_DOH;
        setTextColor(color);

        if ok then
          writeln('Alle Tests bestanden, Gl'#252'ckwunsch! :-)')
        else
          writeln('Da treten leider noch Fehler auf :-(');

        writeln('');
        setTextColor(TEXT_COLOR_NORMAL);
        writeln('Programm mit Return beenden...');

        sleep(500);
      end;

      abbruch := GetAsyncKeyState(VK_RETURN) <> 0;
    until abbruch;
  end;
{$ELSE}
  writeln('Es wurden keine Tests durchgef'#252'hrt.');
  readln;
{$ENDIF}

end.
