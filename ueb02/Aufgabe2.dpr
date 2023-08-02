{------------------------------------------------------------------------------}
{Christopher Philipp Ploog                                           09.11.2018}
{Mario Jose De Jesus Da Graca                                                  }
{Informationen des Eierkaufes des Kunden angeben (Aufgabe2)                    }
{------------------------------------------------------------------------------}
program Aufgabe2;

{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.SysUtils, System.Math;

const
  KARTON_GROESSE = 6;
  F_EI = 'Freilandeier';
  B_EI = 'Bioeier';
  K_EI = 'Käfigeier';

var
  BioEier, FlEier, KEier, EiGes, AnzKartons, EiRest: byte;

begin
////////////////////////////////////////////////////////////////////////////////
////EINGABE/////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  // Abfrage der Kundeninformationen
  write('Wie viele ');
  write(B_EI);
  write(' sollen verpackt werden? ');
  readln(BioEier);
  write('Wie viele ');
  write(F_EI);
  write(' sollen verpackt werden? ');
  readln(FlEier);
  write('Wie viele ');
  write(K_EI);
  write(' sollen verpackt werden? ');
  readln(KEier);
  writeln;

////////////////////////////////////////////////////////////////////////////////
////VERARBEITUNG////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  EiGes := BioEier + FlEier + KEier;

  AnzKartons := EiGes div KARTON_GROESSE +
    byte(not((EiGes mod KARTON_GROESSE) = 0));
  // Berechnung der Karton Anzahl, auch bei 1-5 Eiern wird ein Karton benötigt

  EiRest := EiGes mod KARTON_GROESSE +
    (byte((EiGes mod KARTON_GROESSE) = 0)) * 6;
  // Berechnung der Eier im letzten Kartion, auch wenn der letzte Karton perfekt
  // gefüllt wird, wird die volle anzahl angezeigt

////////////////////////////////////////////////////////////////////////////////
////AUSGABE/////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  write('Es werden insgesamt ');
  write(AnzKartons);
  write(' Eierkarton/s der Größe ');
  write(KARTON_GROESSE);
  writeln(' benötigt.');
  writeln;

  write('Im letzten Karton befinden sich ');
  write(EiRest);
  writeln(' Ei/er.');
  writeln;

  write('Insgesamt wurden ');
  write(EiGes);
  writeln(' Eier gekauft.');
  writeln;

  write('Die maximale Anzahl ist ');
  write(max(max(BioEier, FlEier), KEier));
  write(', die minimale ist ');
  writeln(min(min(BioEier, FlEier), KEier));
  writeln;

  write(B_EI);
  write('wurden am meisten gekauft: ');
  writeln((max(max(BioEier, FlEier), KEier) = BioEier));
  write(F_EI);
  write('wurden am meisten gekauft: ');
  writeln((max(max(BioEier, FlEier), KEier) = FlEier));
  write(K_EI);
  write('wurden am meisten gekauft: ');
  writeln((max(max(BioEier, FlEier), KEier) = KEier));
  write(B_EI);
  write('wurden am wenigsten gekauft: ');
  writeln((min(min(BioEier, FlEier), KEier) = BioEier));
  write(F_EI);
  write('wurden am wenigsten gekauft: ');
  writeln((min(min(BioEier, FlEier), KEier) = FlEier));
  write(K_EI);
  write('wurden am wenigsten gekauft: ');
  writeln((min(min(BioEier, FlEier), KEier) = KEier));
  writeln;

  write('Jede Sorte wurde gekauft: ');
  write((min(min(BioEier, FlEier), KEier) <> 0));
  writeln;

  write('Es gibt eine eindeutige Lieblingssorte: ');
  write(((byte(max(max(BioEier, FlEier), KEier) = BioEier) +
    byte(max(max(BioEier, FlEier), KEier) = FlEier)) +
    byte(max(max(BioEier, FlEier), KEier) = KEier)) = 1);
  readln;

end.
