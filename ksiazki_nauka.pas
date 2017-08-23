unit ksiazki_nauka;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics;
type
    dane_ksiazki = record
    tytul, autor, wydawnictwo, isbn, pozyczona, rok:string;
end;
type
    TInfo=array of dane_ksiazki;
type
      ksiazki_naukowe = class
      info:TInfo;
      constructor create();
      destructor destroy(); override;
      procedure dodaj();
      procedure przypisz_dane();
      procedure szukaj(kryterium:integer;czego_szukam:string);
      procedure wyswietl_wszystkie();
      procedure wyswietl_pozyczone();
      procedure wyswietl_rekord(identyfikator:integer);
      procedure edytuj_wpis(identyfikator:integer);
      procedure wypozycz(identyfikator:integer);
      procedure oddaj(identyfikator:integer);
      procedure wyswietl_historie(identyfikator:integer);
      procedure dostosuj_obraz(identyfikator:integer);
end;

implementation
uses
  unit5,unit1, unit16, unit12, unit13, unit2;

constructor ksiazki_naukowe.create;
begin
 inherited create;
 SetLength(info,0);
end;

destructor ksiazki_naukowe.destroy;
begin
 SetLength(info,0);
 inherited destroy;
end;

procedure ksiazki_naukowe.dodaj;
begin
  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.SQL.Text:='insert into ksiazki_nauka(tytul,autor,wydawnictwo,rok,isbn, pozyczona) values (:tytul,:autor,:wydawnictwo,:rok,:isbn,:pozyczona)';
  Form1.SQLQuery1.Params[0].AsString:=info[0].tytul;
  Form1.SQLQuery1.Params[1].AsString:=info[0].autor;
  Form1.SQLQuery1.Params[2].AsString:=info[0].wydawnictwo;
  Form1.SQLQuery1.Params[3].AsString:=info[0].rok;
  Form1.SQLQuery1.Params[4].AsString:=info[0].isbn;
  Form1.SQLQuery1.Params[5].AsString:='Nie';
  Form1.SQLTransaction1.Active:=True;
  Form1.SQLQuery1.ExecSQL;
  Form1.SQLTransaction1.Commit;
  SetLength(info,0);
end;

procedure ksiazki_naukowe.przypisz_dane;
begin
 SetLength(info,length(info)+1);
 info[0].tytul:=Form5.Edit1.Text;
 info[0].autor:=Form5.Edit2.Text;
 info[0].wydawnictwo:=Form5.Edit3.Text;
 info[0].rok:=Form5.Edit4.Text;
 info[0].isbn:=Form5.Edit5.Text;

end;
procedure ksiazki_naukowe.szukaj(kryterium:integer;czego_szukam:string);
begin
 Form1.SQLQuery1.Close;
 if kryterium=1 then
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, autor, wydawnictwo, rok, pozyczona from ksiazki_nauka where tytul like :param'
 else if kryterium=2 then
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, autor, wydawnictwo, rok, pozyczona from ksiazki_nauka where autor like :param'
 else if kryterium=3 then
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, autor, wydawnictwo, rok, pozyczona from ksiazki_nauka where isbn like :param';
 Form1.SQLQuery1.Params[0].AsString:='%'+czego_szukam+'%';
 Form1.SQLite3Connection1.Connected:= True;
 Form1.SQLTransaction1.Active:= True;
 Form1.SQLQuery1.Open;
end;
procedure ksiazki_naukowe.wyswietl_pozyczone();
begin
 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, autor, wydawnictwo, rok, pozyczona from ksiazki_nauka where pozyczona = "Tak"';
 Form1.SQLite3Connection1.Connected:= True;
 Form1.SQLTransaction1.Active:= True;
 Form1.SQLQuery1.Open;
end;

procedure ksiazki_naukowe.wyswietl_wszystkie();
begin
 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, autor, wydawnictwo, rok, pozyczona from ksiazki_nauka';
 Form1.SQLite3Connection1.Connected:= True;
 Form1.SQLTransaction1.Active:= True;
 Form1.SQLQuery1.Open;
end;
procedure ksiazki_naukowe.wyswietl_rekord(identyfikator:integer);
var
  sciezka:string;
begin
  SetLength(info,length(info)+1);
  Form1.SQLQuery1.Close;
  Form1.SQLTransaction1.Active:=False;
  Form1.SQLite3Connection1.Connected:=False;

  Form1.SQLQuery2.Close;
  Form1.SQLQuery2.SQL.Text:= 'select * from ksiazki_nauka where id = :param';
  Form1.SQLQuery2.Params[0].AsInteger:=identyfikator;
  Form1.SQLite3Connection1.Connected:= True;
  Form1.SQLTransaction2.Active:= True;
  Form1.SQLQuery2.Open;
  Form16.Edit1.Text:=Form1.SQLQuery2.Fields[1].AsString;
  Form16.Edit2.Text:=Form1.SQLQuery2.Fields[2].AsString;
  Form16.Edit3.Text:=Form1.SQLQuery2.Fields[3].AsString;
  Form16.Edit4.Text:=Form1.SQLQuery2.Fields[4].AsString;
  Form16.Edit5.Text:=Form1.SQLQuery2.Fields[5].AsString;
  info[0].pozyczona:=Form1.SQLQuery2.Fields[6].AsString;
  sciezka:='image/s'+inttostr(identyfikator)+'.jpg';
  Form16.Image1.Picture.LoadFromFile(sciezka);

  Form1.SQLQuery2.Close;
  Form1.SQLTransaction2.Active:=False;
  Form1.SQLite3Connection2.Connected:=False;

  wyswietl_wszystkie();
end;
procedure ksiazki_naukowe.edytuj_wpis(identyfikator:integer);
begin
 SetLength(info,length(info)+1);
 info[0].tytul:=Form16.Edit1.Text;
 info[0].rok:=Form16.Edit4.Text;
 info[0].wydawnictwo:=(Form16.Edit3.Text);
 info[0].autor:=Form16.Edit2.Text;
 info[0].isbn:=Form16.Edit5.Text;

 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='update ksiazki_nauka set tytul = :tytul, autor = :autor, wydawnictwo = :wydawnictwo, rok = :rok, isbn = :isbn where id = :identyfikator';
 Form1.SQLQuery1.Params[0].AsString:=info[0].tytul;
 Form1.SQLQuery1.Params[1].AsString:=info[0].autor;
 Form1.SQLQuery1.Params[2].AsString:=info[0].wydawnictwo;
 Form1.SQLQuery1.Params[3].AsString:=info[0].rok;
 Form1.SQLQuery1.Params[4].AsString:=info[0].isbn;
 Form1.SQLQuery1.Params[5].AsInteger:=identyfikator;
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.ExecSQL;
 Form1.SQLTransaction1.Commit;
 SetLength(info,0);
 wyswietl_wszystkie();
end;
procedure ksiazki_naukowe.wypozycz(identyfikator:integer);
var
  numer:integer;
begin
  Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='insert into dluznik (rodzaj, imie, nazwisko, kiedy_pozyczyl, identyfikator) values ("nauka", :imie, :nazwisko, :kiedy, :identyfikator)';
 Form1.SQLQuery1.Params[0].AsString:=Form12.Edit1.Text;
 Form1.SQLQuery1.Params[1].AsString:=Form12.Edit2.Text;
 Form1.SQLQuery1.Params[2].AsDate:=Form12.DateEdit1.Date;
 Form1.SQLQuery1.Params[3].AsInteger:=identyfikator;
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.ExecSQL;
 Form1.SQLTransaction1.Commit;


 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='select * from dluznik where id = (select max(id) from ksiazki_nauka) and rodzaj="nauka"';
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.Open;
 numer:= Form1.SQLQuery1.Fields[0].AsInteger;

 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='update ksiazki_nauka set pozyczona = "Tak", komu = :id where id = :numer';
 Form1.SQLQuery1.Params[0].AsInteger:=numer;
 Form1.SQLQuery1.Params[1].AsInteger:=identyfikator;
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.ExecSQL;
 Form1.SQLTransaction1.Commit;
 wyswietl_wszystkie();
end;
procedure ksiazki_naukowe.oddaj(identyfikator:integer);
var
 numer:Integer;
begin
  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.SQL.Text:='update ksiazki_nauka set pozyczona = "Nie", komu = NULL where id = :id';
  Form1.SQLQuery1.Params[0].AsInteger:=identyfikator;
  Form1.SQLTransaction1.Active:=True;
  Form1.SQLQuery1.ExecSQL;
  Form1.SQLTransaction1.Commit;

  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.SQL.Text:='select * from dluznik where identyfikator = :id AND kiedy_oddal IS NULL and rodzaj="nauka"';
  Form1.SQLQuery1.Params[0].AsInteger:=identyfikator;
  Form1.SQLTransaction1.Active:=True;
  Form1.SQLQuery1.Open;
  numer:= Form1.SQLQuery1.Fields[0].AsInteger;

  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.SQL.Text:='update dluznik set kiedy_oddal = :data where id = :id and rodzaj="nauka"';
  Form1.SQLQuery1.Params[0].AsDate:=Now();
  Form1.SQLQuery1.Params[1].AsInteger:=numer;
  Form1.SQLTransaction1.Active:=True;
  Form1.SQLQuery1.ExecSQL;
  Form1.SQLTransaction1.Commit;
  wyswietl_wszystkie();
end;
procedure ksiazki_naukowe.wyswietl_historie(identyfikator:integer);
begin
 Form1.SQLQuery1.Close;
 Form1.SQLTransaction1.Active:=False;
 Form1.SQLite3Connection1.Connected:=False;

 Form13.SQLQuery1.Close;
 Form13.SQLQuery1.SQL.Text:='select imie, nazwisko, kiedy_pozyczyl, kiedy_oddal from dluznik where identyfikator = :identyfikator and rodzaj="nauka"';
 Form13.SQLQuery1.Params[0].AsInteger:=identyfikator;
 Form13.SQLite3Connection1.Connected:=True;
 Form13.SQLTransaction1.Active:=True;
 Form13.SQLQuery1.Open;
end;
procedure ksiazki_naukowe.dostosuj_obraz(identyfikator:integer);
var
  bmp:TBitmap;
  nowy_bmp:TBitmap;
  jpg:TJPEGImage;
  scale: Double;
  sciezka:string;
begin
 if Form2.OpenDialog1.Execute then
 begin
   jpg := TJPEGImage.Create;
   try
     jpg.LoadFromFile(Form2.OpenDialog1.FileName);
     bmp := TBitmap.Create;
     nowy_bmp :=TBitmap.Create;
     bmp.Assign(jpg);
     try
       nowy_bmp.Width:=240;
       nowy_bmp.Height:=320;
       nowy_bmp.Canvas.StretchDraw(Rect(0,0,240,320),bmp);
       jpg.Assign(nowy_bmp);
       //jpg.SaveToFile(ChangeFileExt(Form2.opendialog1.filename,'_thumb.JPG'));
       sciezka := 'image/s' +inttostr(identyfikator) +'.jpg';
       jpg.SaveToFile(sciezka);
     finally
       bmp.free;
       nowy_bmp.free;
     end;
   finally
     jpg.free;
   end;
 end;
end;
end.

