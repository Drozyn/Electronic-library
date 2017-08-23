unit filmy;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Graphics;

type
  dane_film = record
    tytul, wersja, jakosc, obejrzany, opinia, gatunek, pozyczona, foto, recenzja:string;
    premiera, data_obejrzenia:TDate;
    plyta, ocena:integer;
  end;
  type Tinfo=array of dane_film;
    type film = class
      info:Tinfo;
      constructor create();
      destructor destroy(); override;
      procedure dodaj();
      procedure przypisz_dane();
      procedure szukaj(kryterium:integer;czego_szukam:string);
      procedure wyswietl_wszystkie();
      procedure wyswietl_nieobejrzane();
      procedure wyswietl_obejrzane();
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
  unit1, unit3, unit14, unit2, unit12, unit13;

constructor film.create();
begin
  inherited create;
  setlength(info,0);
end;
destructor film.destroy();
begin
  SetLength(info,0);
  inherited Destroy;
end;
procedure film.dodaj();
begin
 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='insert into filmy(tytul, premiera,plyta,wersja,jakosc,obejrzany,ocena,opinia,gatunek,data_obejrzenia,recenzja, pozyczona) values (:tytul, :premiera,:plyta,:wersja,:jakosc,:obejrzany,:ocena,:opinia,:gatunek,:data_obejrzenia,:recenzja, :pozyczona)';
 Form1.SQLQuery1.Params[0].AsString:=info[0].tytul;
 Form1.SQLQuery1.Params[1].AsDate:=info[0].premiera;
 Form1.SQLQuery1.Params[2].AsInteger:=info[0].plyta;
 Form1.SQLQuery1.Params[3].AsString:=info[0].wersja;
 Form1.SQLQuery1.Params[4].AsString:=info[0].jakosc;
 Form1.SQLQuery1.Params[5].AsString:=info[0].obejrzany;
 Form1.SQLQuery1.Params[6].AsInteger:=info[0].ocena;
 Form1.SQLQuery1.Params[7].AsString:=info[0].opinia;
 Form1.SQLQuery1.Params[8].AsString:=info[0].gatunek;
 Form1.SQLQuery1.Params[9].AsDate:=info[0].data_obejrzenia;
 Form1.SQLQuery1.Params[10].AsString:=info[0].recenzja;
 Form1.SQLQuery1.Params[11].AsString:=info[0].pozyczona;
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.ExecSQL;
 Form1.SQLTransaction1.Commit;
 SetLength(info,0);

end;
procedure film.przypisz_dane();
begin
 SetLength(info,length(info)+1);
 info[0].tytul:=Form3.Edit1.Text;
 info[0].gatunek:=Form3.Edit2.Text;
 info[0].premiera:=Form3.DateEdit2.Date;
 info[0].obejrzany:=Form3.ComboBox1.Text;
 info[0].ocena:=strtoint(Form3.ComboBox2.Text);
 info[0].recenzja:=Form3.Memo1.Text;
 info[0].plyta:=strtoint(Form3.Edit6.Text);
 info[0].wersja:=Form3.Edit7.Text;
 info[0].jakosc:=Form3.Edit8.Text;
 info[0].opinia:=Form3.Memo2.Text;
 info[0].data_obejrzenia:=StrToDate(Form3.DateEdit1.Text);
 info[0].pozyczona:='Nie';
end;
procedure film.szukaj(kryterium:integer;czego_szukam:string);
begin
 Form1.SQLQuery1.Close;
 if kryterium=1 then
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, gatunek, plyta, wersja, jakosc, premiera, obejrzany, ocena, pozyczona from filmy where tytul like :param'
 else if kryterium=2 then
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, gatunek, plyta, wersja, jakosc, premiera, obejrzany, ocena, pozyczona from filmy where gatunek like :param'
 else if kryterium=3 then
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, gatunek, plyta, wersja, jakosc, premiera, obejrzany, ocena, pozyczona from filmy where plyta like :param'
 else if kryterium=4 then
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, gatunek, plyta, wersja, jakosc, premiera, obejrzany, ocena, pozyczona from filmy where wersja like :param';
 Form1.SQLQuery1.Params[0].AsString:='%'+czego_szukam+'%';
 Form1.SQLite3Connection1.Connected:= True;
 Form1.SQLTransaction1.Active:= True;
 Form1.SQLQuery1.Open;
end;

procedure film.wyswietl_wszystkie();
begin
 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, gatunek, plyta, wersja, jakosc, premiera, obejrzany, ocena, pozyczona from filmy';
 Form1.SQLite3Connection1.Connected:= True;
 Form1.SQLTransaction1.Active:= True;
 Form1.SQLQuery1.Open;
end;

procedure film.wyswietl_nieobejrzane();
begin
 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, gatunek, plyta, wersja, jakosc, premiera, obejrzany, ocena, pozyczona from filmy where obejrzany = "Nie"';
 Form1.SQLite3Connection1.Connected:= True;
 Form1.SQLTransaction1.Active:= True;
 Form1.SQLQuery1.Open;
end;

procedure film.wyswietl_obejrzane();
begin
 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, gatunek, plyta, wersja, jakosc, premiera, obejrzany, ocena, pozyczona from filmy where obejrzany = "Tak"';
 Form1.SQLite3Connection1.Connected:= True;
 Form1.SQLTransaction1.Active:= True;
 Form1.SQLQuery1.Open;
end;

procedure film.wyswietl_pozyczone();
begin
 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, gatunek, plyta, wersja, jakosc, premiera, obejrzany, ocena, pozyczona from filmy where pozyczona = "Tak"';
 Form1.SQLite3Connection1.Connected:= True;
 Form1.SQLTransaction1.Active:= True;
 Form1.SQLQuery1.Open;
end;

procedure film.wyswietl_rekord(identyfikator:integer);
var
  sciezka:string;
begin
  SetLength(info,length(info)+1);
  Form1.SQLQuery1.Close;
  Form1.SQLTransaction1.Active:=False;
  Form1.SQLite3Connection1.Connected:=False;

  Form1.SQLQuery2.Close;
  Form1.SQLQuery2.SQL.Text:= 'select * from filmy where id = :param';
  Form1.SQLQuery2.Params[0].AsInteger:=identyfikator;
  Form1.SQLite3Connection1.Connected:= True;
  Form1.SQLTransaction2.Active:= True;
  Form1.SQLQuery2.Open;
  Form14.Edit1.Text:=Form1.SQLQuery2.Fields[1].AsString;
  Form14.DateEdit1.Date:=StrToDate(Form1.SQLQuery2.Fields[2].AsString);
  Form14.Edit2.Text:=Form1.SQLQuery2.Fields[3].AsString;
  Form14.Edit3.Text:=Form1.SQLQuery2.Fields[4].AsString;
  Form14.Edit4.Text:=Form1.SQLQuery2.Fields[5].AsString;
  Form14.ComboBox1.Text:=Form1.SQLQuery2.Fields[6].AsString;
  Form14.ComboBox2.Text:=Form1.SQLQuery2.Fields[7].AsString;
  Form14.Edit5.Text:=Form1.SQLQuery2.Fields[9].AsString;
  Form14.DateEdit2.Date:=(Form1.SQLQuery2.Fields[10].AsDateTime);
  Form14.Memo1.Text:=Form1.SQLQuery2.Fields[13].AsString;
  Form14.Memo2.Text:=Form1.SQLQuery2.Fields[8].AsString;
  info[0].pozyczona:=Form1.SQLQuery2.Fields[11].AsString;
  sciezka:='image/m'+inttostr(identyfikator)+'.jpg';
  Form14.Image1.Picture.LoadFromFile(sciezka);

  Form1.SQLQuery2.Close;
  Form1.SQLTransaction2.Active:=False;
  Form1.SQLite3Connection2.Connected:=False;

  obiekt_film.wyswietl_wszystkie();
end;
procedure film.edytuj_wpis(identyfikator:integer);
begin
 SetLength(info,length(info)+1);
 info[0].tytul:=Form14.Edit1.Text;
 info[0].premiera:=Form14.DateEdit1.Date;
 info[0].plyta:=strtoint(Form14.Edit2.Text);
 info[0].wersja:=Form14.Edit3.Text;
 info[0].jakosc:=Form14.Edit4.Text;
 info[0].recenzja:=Form14.Memo1.Text;
 info[0].obejrzany:=Form14.ComboBox1.Caption;
 info[0].ocena:=strtoint(Form14.ComboBox2.Caption);
 info[0].gatunek:=Form14.Edit5.Text;
 info[0].opinia:=Form14.Memo2.Text;
 info[0].data_obejrzenia:=(Form14.DateEdit2.Date);

 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='update filmy set tytul = :tytul, premiera = :premiera, plyta = :plyta, wersja = :wersja, gatunek = :gatunek, obejrzany = :obejrzany, ocena = :ocena, jakosc = :jakosc, data_obejrzenia = :data, recenzja = :recenzja, opinia = :opinia where id =  :identyfikator';
 Form1.SQLQuery1.Params[0].AsString:=info[0].tytul;
 Form1.SQLQuery1.Params[1].AsDate:=info[0].premiera;
 Form1.SQLQuery1.Params[2].AsInteger:=info[0].plyta;
 Form1.SQLQuery1.Params[3].AsString:=info[0].wersja;
 Form1.SQLQuery1.Params[4].AsString:=info[0].gatunek;
 Form1.SQLQuery1.Params[5].AsString:=info[0].obejrzany;
 Form1.SQLQuery1.Params[6].AsInteger:=info[0].ocena;
 Form1.SQLQuery1.Params[7].AsString:=info[0].jakosc;
 Form1.SQLQuery1.Params[8].AsDate:=info[0].data_obejrzenia;
 Form1.SQLQuery1.Params[9].AsString:=info[0].recenzja;
 Form1.SQLQuery1.Params[10].AsString:=info[0].opinia;
 Form1.SQLQuery1.Params[11].AsInteger:=identyfikator;
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.ExecSQL;
 Form1.SQLTransaction1.Commit;
 SetLength(info,0);
 wyswietl_wszystkie();
end;
procedure film.wypozycz(identyfikator:integer);
var
  numer:integer;
  plyta:integer;
begin
  Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='insert into dluznik (rodzaj, imie, nazwisko, kiedy_pozyczyl, identyfikator) values ("film", :imie, :nazwisko, :kiedy, :identyfikator)';
 Form1.SQLQuery1.Params[0].AsString:=Form12.Edit1.Text;
 Form1.SQLQuery1.Params[1].AsString:=Form12.Edit2.Text;
 Form1.SQLQuery1.Params[2].AsDate:=Form12.DateEdit1.Date;
 Form1.SQLQuery1.Params[3].AsInteger:=identyfikator;
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.ExecSQL;
 Form1.SQLTransaction1.Commit;

 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='select plyta from filmy where id = :id';
 Form1.SQLQuery1.Params[0].AsInteger:=identyfikator;
 FOrm1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.Open;
 plyta:=Form1.SQLQuery1.Fields[0].AsInteger;



 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='select * from dluznik where id = (select max(id) from filmy) and rodzaj="film"';
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.Open;
 numer:= Form1.SQLQuery1.Fields[0].AsInteger;

 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='update filmy set pozyczona = "Tak", komu = :id where plyta = :numer';
 Form1.SQLQuery1.Params[0].AsInteger:=numer;
 Form1.SQLQuery1.Params[1].AsInteger:=plyta;
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.ExecSQL;
 Form1.SQLTransaction1.Commit;
 wyswietl_wszystkie();
end;
procedure film.oddaj(identyfikator:integer);
var
 numer:Integer;
begin
  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.SQL.Text:='update filmy set pozyczona = "Nie", komu = NULL where id = :id';
  Form1.SQLQuery1.Params[0].AsInteger:=identyfikator;
  Form1.SQLTransaction1.Active:=True;
  Form1.SQLQuery1.ExecSQL;
  Form1.SQLTransaction1.Commit;

  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.SQL.Text:='select * from dluznik where identyfikator = :id AND kiedy_oddal IS NULL and rodzaj="film"';
  Form1.SQLQuery1.Params[0].AsInteger:=identyfikator;
  Form1.SQLTransaction1.Active:=True;
  Form1.SQLQuery1.Open;
  numer:= Form1.SQLQuery1.Fields[0].AsInteger;

  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.SQL.Text:='update dluznik set kiedy_oddal = :data where id = :id and rodzaj="film"';
  Form1.SQLQuery1.Params[0].AsDate:=Now();
  Form1.SQLQuery1.Params[1].AsInteger:=numer;
  Form1.SQLTransaction1.Active:=True;
  Form1.SQLQuery1.ExecSQL;
  Form1.SQLTransaction1.Commit;
  wyswietl_wszystkie();
end;

procedure film.wyswietl_historie(identyfikator:integer);
begin
 Form1.SQLQuery1.Close;
 Form1.SQLTransaction1.Active:=False;
 Form1.SQLite3Connection1.Connected:=False;

 Form13.SQLQuery1.Close;
 Form13.SQLQuery1.SQL.Text:='select imie, nazwisko, kiedy_pozyczyl, kiedy_oddal from dluznik where identyfikator = :identyfikator and rodzaj="film"';
 Form13.SQLQuery1.Params[0].AsInteger:=identyfikator;
 Form13.SQLite3Connection1.Connected:=True;
 Form13.SQLTransaction1.Active:=True;
 Form13.SQLQuery1.Open;
end;
procedure film.dostosuj_obraz(identyfikator:integer);
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
       sciezka := 'image/m' +inttostr(identyfikator) +'.jpg';
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

