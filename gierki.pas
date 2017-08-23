unit gierki;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics;
type
  dane_gry = record
  tytul, wydawca, gatunek, ukonczona, recenzja, nosnik, pozyczona:string;
  rok:TDate;
  ocena:integer;
  end;
type
  TInfo=array of dane_gry;
  type gry = class
    info:TInfo;
    constructor create();
    destructor destroy(); override;
    procedure dodaj();
    procedure przypisz_dane();
    procedure wyswietl_wszystkie();
    procedure wyswietl_nieukonczone();
    procedure wyswietl_ukonczone();
    procedure wyswietl_pozyczone();
    procedure szukaj(kryterium:integer;czego_szukam:string);
    procedure wyswietl_rekord(identyfikator:integer);
    procedure edytuj_wpis(identyfikator:integer);
    procedure wypozycz(identyfikator:integer);
    procedure oddaj(identyfikator:integer);
    procedure wyswietl_historie(identyfikator:integer);
    procedure dostosuj_obraz(identyfikator:integer);
  end;

implementation
uses
  unit1, unit4, unit15, unit12, unit13, unit2;

constructor gry.create();
begin
  inherited create();
  SetLength(info,0);
end;
destructor gry.destroy();
begin
  SetLength(info,0);
  inherited Destroy;
end;

procedure gry.dodaj();
begin
 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='insert into gry(tytul,wydawca,gatunek,ukonczona,recenzja,nosnik,pozyczona,rok,ocena) values (:tytul,:wydawca,:gatunek,:ukonczona,:recenzja,:nosnik,:pozyczona,:rok,:ocena)';
 Form1.SQLQuery1.Params[0].AsString:=info[0].tytul;
 Form1.SQLQuery1.Params[1].AsString:=info[0].wydawca;
 Form1.SQLQuery1.Params[2].AsString:=info[0].gatunek;
 Form1.SQLQuery1.Params[3].AsString:=info[0].ukonczona;
 Form1.SQLQuery1.Params[4].AsString:=info[0].recenzja;
 Form1.SQLQuery1.Params[5].AsString:=info[0].nosnik;
 Form1.SQLQuery1.Params[6].AsString:=info[0].pozyczona;
 Form1.SQLQuery1.Params[7].AsDate:=info[0].rok;
 if info[0].ocena = 0 then Form1.SQLQuery1.Params[8].Value := null;
 Form1.SQLQuery1.Params[8].AsInteger:=info[0].ocena;
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.ExecSQL;
 Form1.SQLTransaction1.Commit;
 SetLength(info,0);
end;
procedure gry.przypisz_dane();
begin
 SetLength(info,length(info)+1);
 info[0].tytul:=Form4.Edit1.Text;
 info[0].wydawca:=Form4.Edit2.Text;
 info[0].gatunek:=Form4.Edit3.Text;
 info[0].rok:=strtodate(Form4.DateEdit1.Text);
 info[0].nosnik:=Form4.Edit5.Text;
 info[0].ukonczona:=Form4.ComboBox1.Text;
 if Form4.ComboBox2.Caption='' then info[0].ocena:=0 else
 info[0].ocena:=strtoint(Form4.ComboBox2.Text);
 info[0].recenzja:=Form4.Memo1.Text;
 info[0].pozyczona:='Nie';
end;

procedure gry.wyswietl_wszystkie();
begin
 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, gatunek, wydawca, rok, ukonczona, ocena, nosnik, pozyczona from gry';
 Form1.SQLite3Connection1.Connected:= True;
 Form1.SQLTransaction1.Active:= True;
 Form1.SQLQuery1.Open;
end;

procedure gry.wyswietl_pozyczone();
begin
 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, gatunek, wydawca, rok, ukonczona, ocena, nosnik, pozyczona from gry where pozyczona = "Tak"';
 Form1.SQLite3Connection1.Connected:= True;
 Form1.SQLTransaction1.Active:= True;
 Form1.SQLQuery1.Open;
end;

procedure gry.wyswietl_ukonczone();
begin
  Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, gatunek, wydawca, rok, ukonczona, ocena, nosnik, pozyczona from gry where ukonczona = "Tak"';
 Form1.SQLite3Connection1.Connected:= True;
 Form1.SQLTransaction1.Active:= True;
 Form1.SQLQuery1.Open;
end;

procedure gry.wyswietl_nieukonczone();
begin
   Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, gatunek, wydawca, rok, ukonczona, ocena, nosnik, pozyczona from gry where ukonczona = "Nie"';
 Form1.SQLite3Connection1.Connected:= True;
 Form1.SQLTransaction1.Active:= True;
 Form1.SQLQuery1.Open;
end;
procedure gry.szukaj(kryterium:integer;czego_szukam:string);
begin
 Form1.SQLQuery1.Close;
 if kryterium=1 then
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, gatunek, wydawca, rok, ukonczona, ocena, nosnik, pozyczona from gry where tytul like :param'
 else if kryterium=2 then
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, gatunek, wydawca, rok, ukonczona, ocena, nosnik, pozyczona from gry where gatunek like :param'
 else if kryterium=3 then
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, gatunek, wydawca, rok, ukonczona, ocena, nosnik, pozyczona from gry where nosnik like :param'
 else if kryterium=4 then
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, gatunek, wydawca, rok, ukonczona, ocena, nosnik, pozyczona from gry where wydawca like :param';
 Form1.SQLQuery1.Params[0].AsString:='%'+czego_szukam+'%';
 Form1.SQLite3Connection1.Connected:= True;
 Form1.SQLTransaction1.Active:= True;
 Form1.SQLQuery1.Open;
end;
procedure gry.wyswietl_rekord(identyfikator:integer);
var
  sciezka:string;
begin
  SetLength(info,length(info)+1);
  Form1.SQLQuery1.Close;
  Form1.SQLTransaction1.Active:=False;
  Form1.SQLite3Connection1.Connected:=False;

  Form1.SQLQuery2.Close;
  Form1.SQLQuery2.SQL.Text:= 'select * from gry where id = :param';
  Form1.SQLQuery2.Params[0].AsInteger:=identyfikator;
  Form1.SQLite3Connection1.Connected:= True;
  Form1.SQLTransaction2.Active:= True;
  Form1.SQLQuery2.Open;
  Form15.Edit1.Text:=Form1.SQLQuery2.Fields[1].AsString;
  Form15.DateEdit1.Date:=StrToDate(Form1.SQLQuery2.Fields[4].AsString);
  Form15.Edit2.Text:=Form1.SQLQuery2.Fields[2].AsString;
  Form15.Edit3.Text:=Form1.SQLQuery2.Fields[3].AsString;
  Form15.Edit4.Text:=Form1.SQLQuery2.Fields[8].AsString;
  Form15.ComboBox1.Text:=Form1.SQLQuery2.Fields[5].AsString;
  Form15.ComboBox2.Text:=Form1.SQLQuery2.Fields[6].AsString;
  Form15.Memo1.Text:=Form1.SQLQuery2.Fields[7].AsString;
  info[0].pozyczona:=Form1.SQLQuery2.Fields[9].AsString;
  sciezka:='image/g'+inttostr(identyfikator)+'.jpg';
  Form15.Image1.Picture.LoadFromFile(sciezka);

  Form1.SQLQuery2.Close;
  Form1.SQLTransaction2.Active:=False;
  Form1.SQLite3Connection2.Connected:=False;

  obiekt_gry.wyswietl_wszystkie();
end;
procedure gry.edytuj_wpis(identyfikator:integer);
begin
 SetLength(info,length(info)+1);
 info[0].tytul:=Form15.Edit1.Text;
 info[0].rok:=Form15.DateEdit1.Date;
 info[0].wydawca:=(Form15.Edit2.Text);
 info[0].gatunek:=Form15.Edit3.Text;
 info[0].nosnik:=Form15.Edit4.Text;
 info[0].recenzja:=Form15.Memo1.Text;
 info[0].ukonczona:=Form15.ComboBox1.Caption;
 if Form15.ComboBox2.Caption='' then info[0].ocena:=0 else
 info[0].ocena:=strtoint(Form15.ComboBox2.Caption);

 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='update gry set tytul = :tytul, rok = :premiera, wydawca = :plyta, gatunek = :wersja, nosnik = :gatunek, ukonczona = :obejrzany, ocena = :ocena, recenzja = :jakosc where id =  :identyfikator';
 Form1.SQLQuery1.Params[0].AsString:=info[0].tytul;
 Form1.SQLQuery1.Params[1].AsDate:=info[0].rok;
 Form1.SQLQuery1.Params[2].AsString:=info[0].wydawca;
 Form1.SQLQuery1.Params[3].AsString:=info[0].gatunek;
 Form1.SQLQuery1.Params[4].AsString:=info[0].nosnik;
 Form1.SQLQuery1.Params[5].AsString:=info[0].ukonczona;
 if info[0].ocena = 0 then Form1.SQLQuery1.Params[6].Value:=null else
 Form1.SQLQuery1.Params[6].AsInteger:=info[0].ocena;
 Form1.SQLQuery1.Params[7].AsString:=info[0].recenzja;
 Form1.SQLQuery1.Params[8].AsInteger:=identyfikator;
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.ExecSQL;
 Form1.SQLTransaction1.Commit;
 SetLength(info,0);
 wyswietl_wszystkie();
end;
procedure gry.wypozycz(identyfikator:integer);
var
  numer:integer;
begin
  Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='insert into dluznik (rodzaj, imie, nazwisko, kiedy_pozyczyl, identyfikator) values ("gra", :imie, :nazwisko, :kiedy, :identyfikator)';
 Form1.SQLQuery1.Params[0].AsString:=Form12.Edit1.Text;
 Form1.SQLQuery1.Params[1].AsString:=Form12.Edit2.Text;
 Form1.SQLQuery1.Params[2].AsDate:=Form12.DateEdit1.Date;
 Form1.SQLQuery1.Params[3].AsInteger:=identyfikator;
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.ExecSQL;
 Form1.SQLTransaction1.Commit;


 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='select * from dluznik where id = (select max(id) from filmy) and rodzaj="gra"';
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.Open;
 numer:= Form1.SQLQuery1.Fields[0].AsInteger;

 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='update gry set pozyczona = "Tak", komu = :id where id = :numer';
 Form1.SQLQuery1.Params[0].AsInteger:=numer;
 Form1.SQLQuery1.Params[1].AsInteger:=identyfikator;
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.ExecSQL;
 Form1.SQLTransaction1.Commit;
 wyswietl_wszystkie();
end;
procedure gry.oddaj(identyfikator:integer);
var
 numer:Integer;
begin
  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.SQL.Text:='update gry set pozyczona = "Nie", komu = NULL where id = :id';
  Form1.SQLQuery1.Params[0].AsInteger:=identyfikator;
  Form1.SQLTransaction1.Active:=True;
  Form1.SQLQuery1.ExecSQL;
  Form1.SQLTransaction1.Commit;

  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.SQL.Text:='select * from dluznik where identyfikator = :id AND kiedy_oddal IS NULL and rodzaj="gra"';
  Form1.SQLQuery1.Params[0].AsInteger:=identyfikator;
  Form1.SQLTransaction1.Active:=True;
  Form1.SQLQuery1.Open;
  numer:= Form1.SQLQuery1.Fields[0].AsInteger;

  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.SQL.Text:='update dluznik set kiedy_oddal = :data where id = :id and rodzaj="gra"';
  Form1.SQLQuery1.Params[0].AsDate:=Now();
  Form1.SQLQuery1.Params[1].AsInteger:=numer;
  Form1.SQLTransaction1.Active:=True;
  Form1.SQLQuery1.ExecSQL;
  Form1.SQLTransaction1.Commit;
  wyswietl_wszystkie();
end;
procedure gry.wyswietl_historie(identyfikator:integer);
begin
 Form1.SQLQuery1.Close;
 Form1.SQLTransaction1.Active:=False;
 Form1.SQLite3Connection1.Connected:=False;

 Form13.SQLQuery1.Close;
 Form13.SQLQuery1.SQL.Text:='select imie, nazwisko, kiedy_pozyczyl, kiedy_oddal from dluznik where identyfikator = :identyfikator and rodzaj="gra"';
 Form13.SQLQuery1.Params[0].AsInteger:=identyfikator;
 Form13.SQLite3Connection1.Connected:=True;
 Form13.SQLTransaction1.Active:=True;
 Form13.SQLQuery1.Open;
end;
procedure gry.dostosuj_obraz(identyfikator:integer);
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
       sciezka := 'image/g' +inttostr(identyfikator) +'.jpg';
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

