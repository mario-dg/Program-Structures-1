{ -----------------------------------------------------------------------------
  Christopher Ploog, Mario da Graca     18.01.2019
  Einstieg und erste einfache Aufgaben mit Zeigern
  -----------------------------------------------------------------------------
}
{$APPTYPE CONSOLE}
{$R+,Q+,X-}
program Aufgabe9a;

uses
  System.SysUtils;

type
  // 1)  Legt einen Typ fuer einen Zeiger auf eine Bytevariable an.
  PByte = ^Byte;

  // 7)  Legt nun einen Typ fuer einen Record mit 3 Bytewerten an.
  TByteRecord = record
    ByteValue1, ByteValue2, ByteValue3: Byte;
  end;

  // 11) Legt einen weiteren Typ fuer einen Record mit 3 Integerwerten sowie einen Typ
  // Zeiger auf integer an.
  PInteger = ^Integer;

  TIntegerRecord = record
    IntValue1, IntValue2, IntValue3: Integer;
  end;

  // 16a) Zeiger koennen auf alles moegliche zeigen - auch auf einen Record.
  // Z.B. auch auf einen Record, der einen Bytewert und einen Zeiger vom Typ
  // Zeiger auf diesen Record beinhaltet. Legt Euch einen passenden Typ dazu an!
  // Der Typ Zeiger auf diesen Record muss dazu natuerlich vorab deklariert werden.
  PRecord = ^Liste;

  Liste = record
    Value: Byte;
    Next: PRecord;
  end;

var
  // 2)  Deklariert eine Variable vom Typ byte und 2 Variablen vom Typ Zeiger auf byte.
  ByteZahl: Byte;
  ByteZeiger1, ByteZeiger2: PByte;

  // 8)  Deklariert Euch eine Variable von diesem Recordtyp und drei weitere Variablen vom Typ
  // Zeiger auf Byte.
  ByteRecord: TByteRecord;
  ByteValue1Zeiger, ByteValue2Zeiger, ByteValue3Zeiger: PByte;

  // 12) Deklariert Euch eine Variable vom neuen Recordtyp und drei weitere Variablen vom Typ
  // Zeiger auf integer.
  IntegerRecord: TIntegerRecord;
  IntegerValue1Zeiger, IntegerValue2Zeiger, IntegerValue3Zeiger: PInteger;

  // 15a) Legt ueber dem Hauptprogramm drei kleine Prozeduren mal2_a, mal2_b und mal2_c an, die jeweils
  // einen Parameter haben, dessen Wert im Rumpf mal 2 genommen wird.
  // Die erste Prozedur soll dabei einen Bytewert als Wertparameter bekommen,
  TestByte: Byte;
  TestBytezeiger: PByte;

  // 16b)Deklariert folgend zwei Variablen vom Typ Zeiger auf den Record.
  Liste1, Liste2: PRecord;

procedure mal2_a(Zahl: Byte);
begin
  Zahl := Zahl * 2;
end;

// die zweite Prozedur einen Bytewert als Referenzparameter
procedure mal2_b(var Zahl: Byte);
begin
  Zahl := Zahl * 2;
end;

// und die dritte Prozedur einen Zeiger auf einen Bytewert.
procedure mal2_c(Bytezeiger: PByte);
begin
  Bytezeiger^ := Bytezeiger^ * 2;
end;

begin
  // 3)  Belegt die Bytevariable mit dem Wert 3 und lasst beide Zeiger auf diese Variable zeigen.
  ByteZahl := 3;
  ByteZeiger1 := @ByteZahl;
  ByteZeiger2 := @ByteZahl;

  // 4)  Gebt mit writeln die Bytevariable, die dereferenzierten Zeigervariablen sowie die Adressen,
  // auf die die Zeigervariablen zeigen durch Leerzeichen getrennt aus (insg. also 5 Werte).
  writeln('Bytevariable: ', ByteZahl);
  writeln('Dereferenzierte Zeigervariable 1: ', ByteZeiger1^);
  writeln('Dereferenzierte Zeigervariable 2: ', ByteZeiger2^);
  writeln('Adresse Zeiger1: ', Integer(ByteZeiger1));
  writeln('Adresse Zeiger2: ', Integer(ByteZeiger2));
  writeln;

  // 5)  Setzt jetzt den Wert, auf den die erste Zeigervariable zeigt, von 3 auf 5.
  ByteZeiger1^ := 5;

  // 6)  Wiederholt dieselbe Ausgabe der 5 Werte wie in Schritt 4.
  writeln('Bytevariable: ', ByteZahl);
  writeln('Dereferenzierte Zeigervariable 1: ', ByteZeiger1^);
  writeln('Dereferenzierte Zeigervariable 2: ', ByteZeiger2^);
  writeln('Adresse Zeiger1: ', Integer(ByteZeiger1));
  writeln('Adresse Zeiger2: ', Integer(ByteZeiger2));
  writeln;
  // FRAGE: Was hat sich in der Ausgabe geaendert?
  // ANTWORT: Alle 3 Variablen bekommen den Wert 5, Adressen bleiben gleich
  // FRAGE: Warum haben sich genau diese Werte geaendert?
  // ANTWORT: Alle 3 Variablen, zeigen auf dieselbe Stelle im Speicher. Sobald man eine ver‰ndert, ver‰ndern sich die anderen automatisch mit. Die Adressen ver‰ndern sich logischerweise nicht.

  // 9)  Lasst die drei neuen Zeiger jetzt jeweils auf einen der drei Bytewerte aus dem Record zeigen.
  ByteValue1Zeiger := @ByteRecord.ByteValue1;
  ByteValue2Zeiger := @ByteRecord.ByteValue2;
  ByteValue3Zeiger := @ByteRecord.ByteValue3;

  // 10) Lasst Euch die Adressen und die Inhalte der drei Zeiger jeweils durch Leerzeichen getrennt
  // ausgeben (also insg. 6 Werte).
  writeln('Adresse 1: ', Integer(ByteValue1Zeiger), ' Value 1: ',
    ByteValue1Zeiger^);
  writeln('Adresse 2: ', Integer(ByteValue2Zeiger), ' Value 2: ',
    ByteValue2Zeiger^);
  writeln('Adresse 3: ', Integer(ByteValue3Zeiger), ' Value 3: ',
    ByteValue3Zeiger^);
  writeln;
  // FRAGE: Was faellt bei den Adressen auf?
  // ANTWORT: Sie folgen aufeinander
  // FRAGE: Welche Inhalte werden ausgegeben? Warum genau diese?
  // ANTWORT: Alle 3 Values = 0. Die Record Eintr‰ge haben keinen Wert zugewiesen bekommen, deswegen ist der Standardwert 0

  // 13) Lasst dann die drei neuen Zeiger jeweils auf einen der drei Integerwerte aus dem Record zeigen.
  IntegerValue1Zeiger := @IntegerRecord.IntValue1;
  IntegerValue2Zeiger := @IntegerRecord.IntValue2;
  IntegerValue3Zeiger := @IntegerRecord.IntValue3;

  // 14) Lasst Euch die Adressen, auf die die drei Integer-Zeiger zeigen jeweils durch Leerzeichen getrennt ausgeben
  // (also insg. 3 Werte).
  writeln(Integer(IntegerValue1Zeiger), ' ', Integer(IntegerValue2Zeiger), ' ',
    Integer(IntegerValue3Zeiger));
  writeln;
  // FRAGE: Was faellt bei den Adressen diesmal auf, auch im Vergleich zu vorher?
  // ANTWORT: Die Adressen sind in Reihe, jedoch mit 4 Abstand. Nicht 1 wie bei byte. Integer ist grˆﬂer, benˆtigt mehr Speicherplatz

  // 15b) Ergaenzt danach dreimal nacheinander folgenden Code:
  // - das Setzen einer Bytevariable auf den Wert 3
  // - einen Aufruf einer der Prozeduren mit diesem Bytewert (jede 1x)
  // - eine Ausgabe des Bytewertes nach dem Aufruf mit writeln
  TestByte := 3;
  mal2_a(TestByte);
  writeln('mal2_a: ', TestByte);

  TestByte := 3;
  mal2_b(TestByte);
  writeln('mal2_b: ', TestByte);

  TestByte := 3;
  TestBytezeiger := @TestByte;
  mal2_c(TestBytezeiger);
  writeln('mal2_c: ', TestByte);
  writeln;
  // FRAGE: Welche Erkenntnis kann man aus den ausgegebenen Werten ziehen?
  // A: Es gibt keinen R¸ckgabewert. Die zahl wird in der Prozedur multipliziert, aber dies ist nicht nach Auﬂen sichtbar
  // B: Referenzparameter => Eingegebene Zahl wird multilpiziert und wirkt sich nach Auﬂen aus.
  // C: Durch den Zeiger, zeigen quasi 2 Variablen auf denselben Wert. Der Zeiger ver‰ndert den Wert und das TestByte ver‰ndert sich dadurch mit.

  // 16c) Holt Euch dann mit der Funktion new(...) jeweils Speicher fuer den Record, auf den die Zeiger zeigen.
  new(Liste1);
  new(Liste2);
  // Belegt bei beiden Zeigern auf die Records den Bytewert mit einer beliebigen (aber verschiedenen) Zahl.
  Liste1^.Value := 5;
  Liste2^.Value := 3;
  // Lasst dann den im Record enthaltenen Zeiger der ersten Variable auf den zweiten Record zeigen und
  Liste1^.Next := Liste2;
  // den Zeiger der zweiten Variable auf nil. Schon haben wir unsere erste kleine Liste gebaut!
  Liste2^.Next := nil;

  // 17) Lasst Euch mit writeln die beiden Bytewerte ausgeben. Ihr duerft dabei allerdings nur den ersten Zeiger
  // benutzen!!
  writeln('Value 1: ', Liste1^.Value);
  writeln('Value 2: ', Liste1^.Next^.Value);
  // FRAGE: Koennte man auch beide Bytewerte ausgeben, wenn man nur den zweiten Zeiger benutzen duerfte?
  // Falls ja: Wie? Falls nein: Warum nicht?
  // ANTWORT: Nein, der 2. Zeiger hat kein nachfolgendes Element (Auch nicht wie in einem Kreislauf das 1. Listenelement anch sich.)
  Dispose(Liste1);
  Dispose(Liste2);
  readln;

end.
