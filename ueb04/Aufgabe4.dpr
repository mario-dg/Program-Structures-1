{ ----------------------------------------------------------------------------- }
{ Christopher Ploog, Mario da Graca      23.11.2018 }
{ Ein Pogramm zum Anzeigen von Eigenschaften von zahlen }
{ ----------------------------------------------------------------------------- }
program Aufgabe4;

{$APPTYPE CONSOLE}
{$R+,Q+,X-}

uses
  System.SysUtils;

const
  LOWER_BORDER = 1;
  UPPER_BORDER = 10;

var
  even, Primcheck: boolean;
  i, Number, Teiler, AnzTeiler, SPrim, BPrim, Pruefzahl, Counter: word;
  Low, High: byte;

begin
  // VERARBEITUNG
  for i := LOWER_BORDER to UPPER_BORDER do
  begin
    // GERADE UNGERADE
    even := i mod 2 = 0;

    // KLEINSTE UND GRÖßTE ZIFFER
    Number := i;
    Low := 9;
    High := 0;
    Repeat
    begin
      if (Number mod 10) < Low then
        Low := Number mod 10
      else;
      if (Number mod 10) > High then
        High := Number mod 10
      else;
      Number := Number div 10;
    end;
    Until (Number mod 10) = 0;

    // NÄCHSTKLEINE PRIMZAHL

    Counter := 1;
    Primcheck := false;
    Repeat
      Teiler := 1;
      AnzTeiler := 0;
      Pruefzahl := i - Counter;
      // writeln('PrZ: ', Pruefzahl, ' Counter: ', Counter);
      if (Pruefzahl = 0) then
      begin
        SPrim := 0;
        Primcheck := True
      end
      else
      begin
        while Teiler <= Pruefzahl do
        begin
          if (Pruefzahl mod Teiler) = 0 then
            AnzTeiler := AnzTeiler + 1;

          Teiler := Teiler + 1;
        end;

        if AnzTeiler <= 2 then
        begin
          Primcheck := True;
          SPrim := Pruefzahl;
        end
      end;
      Counter := Counter + 1;
    Until Primcheck;

    // NÄCHSTGRÖßTE PRIMZAHL
    Counter := 1;
    Primcheck := false;
    Repeat
      Teiler := 1;
      AnzTeiler := 0;
      Pruefzahl := i + Counter;
      // writeln('PrZ: ', Pruefzahl, ' Counter: ', Counter);
      while Teiler <= Pruefzahl do
      begin
        if (Pruefzahl mod Teiler) = 0 then
          AnzTeiler := AnzTeiler + 1;

        Teiler := Teiler + 1;
      end;

      if AnzTeiler = 2 then
      begin
        BPrim := Pruefzahl;
        Primcheck := True;
      end;

      Counter := Counter + 1;
    Until Primcheck;

    // AUSGABE
    if SPrim = 0 then
    begin
      writeln(i:3, ' Gerade: ', even:5, ' Größte Ziffer: ', High:1,
        ' Kleinste Ziffer: ', Low:1, ' <Prim: ', '-':2, ' >Prim: ', BPrim:2);
    end
    else
      writeln(i:3, ' Gerade: ', even:5, ' Größte Ziffer: ', High:1,
        ' Kleinste Ziffer: ', Low:1, ' <Prim: ', SPrim:2, ' >Prim: ', BPrim:2);
    writeln;
  end;
  readln;

end.
