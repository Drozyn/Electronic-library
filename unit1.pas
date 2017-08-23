unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, sqlite3conn, FileUtil, Forms, Controls,
  Graphics, Dialogs, Menus, Grids, DBGrids, unit2, unit3, unit4, unit5, unit6,
  unit7, unit8, unit9, unit10, unit11, unit12, unit13, unit14, unit15, unit16;

type

  { TForm1 }

  TForm1 = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    SQLite3Connection1: TSQLite3Connection;
    SQLite3Connection2: TSQLite3Connection;
    SQLQuery1: TSQLQuery;
    SQLQuery2: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    SQLTransaction2: TSQLTransaction;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

type
  dane = record
   tytul,autor, wydawnictwo, rok, gatunek, recenzja, przeczytana, opinia, isbn, pozyczona, foto:string;
   ocena:integer;
   data_przeczytania:TDate;
  end;
type
  Tinfo=array of dane;
type
  ksiazka =class
    info:Tinfo;
    constructor create();
    destructor destroy(); override;
    procedure dodaj();
    procedure przypisz_dane();
    procedure szukaj(kryterium:integer;czego_szukam:string);
    procedure wyswietl_rekord(identyfikator:integer);
    procedure edytuj_wpis(identyfikator:integer);
    procedure wypozycz(identyfikator:integer);
    procedure oddaj(identyfikator:integer);
    procedure wyswietl_historie(identyfikator:integer);
    procedure dostosuj_obraz(identyfikator:integer);
  end;
procedure wyswietl();
procedure wyswietl_film();
procedure wyswietl_gry();
procedure wyswietl_ksiazki_nauka();

var
  Form1: TForm1;
var
  obiekt_ksiazka:ksiazka;
  wybrana_baza:integer;

implementation

{$R *.lfm}

{ TForm1 }
procedure wyswietl();
begin
  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.SQL.Text:= 'select id, tytul, autor, wydawnictwo, rok, gatunek, przeczytana, ocena, pozyczona from ksiazki';
  Form1.SQLite3Connection1.Connected:= True;
  Form1.SQLTransaction1.Active:= True;
  Form1.SQLQuery1.Open;
end;
procedure wyswietl_przeczytane();
begin
 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, autor, wydawnictwo, rok, gatunek, przeczytana, ocena, pozyczona from ksiazki where przeczytana = "Tak"';
 Form1.SQLite3Connection1.Connected:= True;
 Form1.SQLTransaction1.Active:= True;
 Form1.SQLQuery1.Open;
end;
procedure wyswietl_pozyczone();
begin
 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, autor, wydawnictwo, rok, gatunek, przeczytana, ocena, pozyczona from ksiazki where pozyczona = "Tak"';
 Form1.SQLite3Connection1.Connected:= True;
 Form1.SQLTransaction1.Active:= True;
 Form1.SQLQuery1.Open;
end;
procedure wyswietl_nieprzeczytane();
begin
 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, autor, wydawnictwo, rok, gatunek, przeczytana, ocena, pozyczona from ksiazki where przeczytana = "Nie"';
 Form1.SQLite3Connection1.Connected:= True;
 Form1.SQLTransaction1.Active:= True;
 Form1.SQLQuery1.Open;
end;
procedure wyswietl_film();
begin
  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.SQL.Text:='select id, tytul, gatunek, plyta, wersja, jakosc, premiera, obejrzany, ocena, pozyczona from filmy';
  Form1.SQLTransaction1.Active:=True;
  Form1.SQLQuery1.Open;
end;

procedure wyswietl_gry();
begin
  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.SQL.Text:='select id, tytul, gatunek, wydawca, rok, ukonczona, ocena, nosnik, pozyczona from gry';
  Form1.SQLTransaction1.Active:=True;
  Form1.SQLQuery1.Open;
end;

procedure wyswietl_ksiazki_nauka();
begin
  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.SQL.Text:='select id, tytul, autor, wydawnictwo, rok, pozyczona from ksiazki_nauka';
  Form1.SQLTransaction1.Active:=True;
  Form1.SQLQuery1.Open;
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
    wybrana_baza:=1;
    Form1.MenuItem6.Checked:=True;
    Form1.MenuItem7.Checked:=False;
    Form1.MenuItem8.Checked:=False;
    Form1.MenuItem9.Checked:=False;
    Form1.DBGrid1.Visible:=True;
    Form1.MenuItem4.Visible:=True;
    Form1.MenuItem3.Visible:=True;
    Form1.MenuItem2.Visible:=True;
    Form1.MenuItem10.Visible:=True;
    Form1.MenuItem11.Visible:=True;
    Form1.MenuItem12.Visible:=True;
    Form1.MenuItem13.Visible:=True;
    Form1.MenuItem10.Caption:='Przeczytane';
    Form1.MenuItem11.Caption:='Nieprzeczytane';
    Form1.MenuItem12.Caption:='Wszystkie';
    Form1.MenuItem13.Caption:='Pożyczone';
    wyswietl();
end;

procedure TForm1.MenuItem10Click(Sender: TObject);
begin
  Form1.MenuItem10.Checked:=True;
  Form1.MenuItem11.Checked:=False;
  Form1.MenuItem12.Checked:=False;
  Form1.MenuItem13.Checked:=False;
  if Form1.MenuItem6.Checked=True then wyswietl_przeczytane()
  else if Form1.MenuItem7.Checked=True then obiekt_film.wyswietl_obejrzane()
  else if Form1.MenuItem8.Checked=True then obiekt_gry.wyswietl_ukonczone();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  obiekt_ksiazka:=ksiazka.create;
  Form1.DBGrid1.Visible:=False;
  Form1.MenuItem2.Visible:=False;
  Form1.MenuItem3.Visible:=False;
  Form1.MenuItem4.Visible:=False;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  obiekt_ksiazka.Free;
end;

procedure TForm1.DBGrid1DblClick(Sender: TObject);
begin
  if Form1.MenuItem6.Checked=True then Form11.Show else
    if Form1.MenuItem7.Checked=True then Form14.Show else
      if Form1.MenuItem8.Checked=True then Form15.Show else
        if Form1.MenuItem9.Checked=True then Form16.Show;
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
begin
  Form1.MenuItem10.Checked:=False;
  Form1.MenuItem11.Checked:=True;
  Form1.MenuItem12.Checked:=False;
  Form1.MenuItem13.Checked:=False;
    if Form1.MenuItem6.Checked=True then wyswietl_nieprzeczytane()
  else if Form1.MenuItem7.Checked=True then obiekt_film.wyswietl_nieobejrzane()
  else if Form1.MenuItem8.Checked=True then obiekt_gry.wyswietl_nieukonczone();
end;

procedure TForm1.MenuItem12Click(Sender: TObject);
begin
  Form1.MenuItem10.Checked:=False;
  Form1.MenuItem11.Checked:=False;
  Form1.MenuItem12.Checked:=True;
  Form1.MenuItem13.Checked:=False;
      if Form1.MenuItem6.Checked=True then wyswietl()
  else if Form1.MenuItem7.Checked=True then obiekt_film.wyswietl_wszystkie()
  else if Form1.MenuItem8.Checked=True then obiekt_gry.wyswietl_wszystkie()
  else if Form1.MenuItem9.Checked=True then obiekt_ksiazki_nauka.wyswietl_wszystkie();
end;

procedure TForm1.MenuItem13Click(Sender: TObject);
begin
    Form1.MenuItem10.Checked:=False;
  Form1.MenuItem11.Checked:=False;
  Form1.MenuItem13.Checked:=True;
  Form1.MenuItem12.Checked:=False;
        if Form1.MenuItem6.Checked=True then wyswietl_pozyczone()
  else if Form1.MenuItem7.Checked=True then obiekt_film.wyswietl_pozyczone()
  else if Form1.MenuItem8.Checked=True then obiekt_gry.wyswietl_pozyczone()
  else if Form1.MenuItem9.Checked=True then obiekt_ksiazki_nauka.wyswietl_pozyczone();
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  if Form1.MenuItem6.Checked=True then Form2.Show else
    if Form1.MenuItem7.Checked=True then Form3.Show else
      if Form1.MenuItem8.Checked=True then Form4.Show else
        if Form1.MenuItem9.Checked=True then Form5.Show;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  if Form1.MenuItem6.Checked=True then Form6.Show else
    if Form1.MenuItem7.Checked=True then Form7.Show else
      if Form1.MenuItem8.Checked=True then Form8.Show else
        if Form1.MenuItem9.Checked=True then Form9.Show;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  Form10.Show;
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
    wybrana_baza:=2;
     Form1.MenuItem6.Checked:=False;
     Form1.MenuItem7.Checked:=True;
     Form1.MenuItem8.Checked:=False;
     Form1.MenuItem9.Checked:=False;
     Form1.DBGrid1.Visible:=True;
     Form1.MenuItem4.Visible:=True;
    Form1.MenuItem3.Visible:=True;
    Form1.MenuItem2.Visible:=True;
    Form1.MenuItem10.Visible:=True;
    Form1.MenuItem11.Visible:=True;
    Form1.MenuItem12.Visible:=True;
    Form1.MenuItem13.Visible:=True;
    Form1.MenuItem10.Caption:='Obejrzane';
    Form1.MenuItem11.Caption:='Nieobejrzane';
    Form1.MenuItem12.Caption:='Wszystkie';
    Form1.MenuItem13.Caption:='Pożyczone';
     wyswietl_film();
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin
    wybrana_baza:=3;
    Form1.MenuItem6.Checked:=False;
    Form1.MenuItem7.Checked:=False;
    Form1.MenuItem8.Checked:=True;
    Form1.MenuItem9.Checked:=False;
    Form1.DBGrid1.Visible:=True;
    Form1.MenuItem4.Visible:=True;
    Form1.MenuItem3.Visible:=True;
    Form1.MenuItem2.Visible:=True;
    Form1.MenuItem10.Visible:=True;
    Form1.MenuItem11.Visible:=True;
    Form1.MenuItem12.Visible:=True;
    Form1.MenuItem13.Visible:=True;
    Form1.MenuItem10.Caption:='Ukończone';
    Form1.MenuItem11.Caption:='Nieukończone';
    Form1.MenuItem12.Caption:='Wszystkie';
    Form1.MenuItem13.Caption:='Pożyczone';
    wyswietl_gry();
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin
    wybrana_baza:=4;
    Form1.MenuItem6.Checked:=False;
    Form1.MenuItem7.Checked:=False;
    Form1.MenuItem8.Checked:=False;
    Form1.MenuItem9.Checked:=True;
    Form1.DBGrid1.Visible:=True;
    Form1.MenuItem4.Visible:=True;
    Form1.MenuItem3.Visible:=True;
    Form1.MenuItem2.Visible:=True;
    Form1.MenuItem10.Visible:=False;
    Form1.MenuItem11.Visible:=False;
    Form1.MenuItem12.Visible:=True;
    Form1.MenuItem13.Visible:=True;
    Form1.MenuItem12.Caption:='Wszystkie';
    Form1.MenuItem13.Caption:='Pożyczone';
    wyswietl_ksiazki_nauka();
end;

constructor ksiazka.create();
begin
    inherited create;
    SetLength(info,0);
end;

destructor ksiazka.destroy();
begin
    SetLength(info,0);
    inherited Destroy;
end;



procedure ksiazka.dodaj();
begin
 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='insert into ksiazki(tytul,autor,wydawnictwo,rok,gatunek,przeczytana,ocena,isbn,data_przeczytania,recenzja,opinia, pozyczona) values (:tytul,:autor,:wydawnictwo,:rok,:gatunek,:przeczytana,:ocena,:isbn,:data_przeczytania,:recenzja,:opinia, :pozyczona)';
 Form1.SQLQuery1.Params[0].AsString:=info[0].tytul;
 Form1.SQLQuery1.Params[1].AsString:=info[0].autor;
 Form1.SQLQuery1.Params[2].AsString:=info[0].wydawnictwo;
 Form1.SQLQuery1.Params[3].AsString:=info[0].rok;
 Form1.SQLQuery1.Params[4].AsString:=info[0].gatunek;
 Form1.SQLQuery1.Params[5].AsString:=info[0].przeczytana;
 if info[0].ocena = 0 then Form1.SQLQuery1.Params[6].Value := null;
 Form1.SQLQuery1.Params[6].AsInteger:=info[0].ocena;
 Form1.SQLQuery1.Params[7].AsString:=info[0].isbn;
 Form1.SQLQuery1.Params[8].AsDate:=info[0].data_przeczytania;
 Form1.SQLQuery1.Params[9].AsString:=info[0].recenzja;
 Form1.SQLQuery1.Params[10].AsString:=info[0].opinia;
 Form1.SQLQuery1.Params[11].AsString:=info[0].pozyczona;
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.ExecSQL;
 Form1.SQLTransaction1.Commit;
 SetLength(info,0);
 wyswietl();

end;

procedure ksiazka.przypisz_dane();
begin
 SetLength(info,length(info)+1);
 info[0].tytul:=Form2.Edit1.Text;
 info[0].autor:=Form2.Edit2.Text;
 info[0].wydawnictwo:=Form2.Edit3.Text;
 info[0].rok:=Form2.Edit4.Text;
 info[0].gatunek:=Form2.Edit5.Text;
 info[0].recenzja:=Form2.Memo1.Text;
 info[0].przeczytana:=Form2.ComboBox2.Caption;
 if Form2.ComboBox1.Caption='' then info[0].ocena:=0 else
 info[0].ocena:=strtoint(Form2.ComboBox1.Caption);
 info[0].isbn:=Form2.Edit8.Text;
 info[0].opinia:=Form2.Memo2.Text;
 info[0].data_przeczytania:=(Form2.DateEdit2.Date);
 info[0].pozyczona:='Nie';
end;

procedure ksiazka.szukaj(kryterium:integer;czego_szukam:string);
begin
 Form1.SQLQuery1.Close;
 if kryterium=1 then
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, autor, wydawnictwo, rok, gatunek, przeczytana, ocena, pozyczona from ksiazki where tytul like :param'
 else if kryterium=2 then
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, autor, wydawnictwo, rok, gatunek, przeczytana, ocena, pozyczona from ksiazki where autor like :param'
 else if kryterium=3 then
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, autor, wydawnictwo, rok, gatunek, przeczytana, ocena, pozyczona from ksiazki where gatunek like :param'
 else if kryterium=4 then
 Form1.SQLQuery1.SQL.Text:= 'select id, tytul, autor, wydawnictwo, rok, gatunek, przeczytana, ocena, pozyczona from ksiazki where isbn like :param';
 Form1.SQLQuery1.Params[0].AsString:='%'+czego_szukam+'%';
 Form1.SQLite3Connection1.Connected:= True;
 Form1.SQLTransaction1.Active:= True;
 Form1.SQLQuery1.Open;
end;
procedure ksiazka.wyswietl_rekord(identyfikator:integer);
var
  sciezka:string;
begin
  SetLength(info,Length(info)+1);
  Form1.SQLQuery1.Close;
  Form1.SQLTransaction1.Active:=False;
  Form1.SQLite3Connection1.Connected:=False;

  Form1.SQLQuery2.Close;
  Form1.SQLQuery2.SQL.Text:= 'select * from ksiazki where id = :param';
  Form1.SQLQuery2.Params[0].AsInteger:=identyfikator;
  Form1.SQLite3Connection1.Connected:= True;
  Form1.SQLTransaction2.Active:= True;
  Form1.SQLQuery2.Open;
  Form11.Edit1.Text:=Form1.SQLQuery2.Fields[1].AsString;
  Form11.Edit2.Text:=Form1.SQLQuery2.Fields[2].AsString;
  Form11.Edit3.Text:=Form1.SQLQuery2.Fields[3].AsString;
  Form11.Edit4.Text:=Form1.SQLQuery2.Fields[4].AsString;
  Form11.Edit5.Text:=Form1.SQLQuery2.Fields[5].AsString;
  Form11.ComboBox1.Text:=Form1.SQLQuery2.Fields[7].AsString;
  Form11.ComboBox2.Text:=Form1.SQLQuery2.Fields[8].AsString;
  Form11.Edit8.Text:=Form1.SQLQuery2.Fields[10].AsString;
  Form11.DateEdit1.Date:=(Form1.SQLQuery2.Fields[11].AsDateTime);
  Form11.Memo1.Text:=Form1.SQLQuery2.Fields[6].AsString;
  Form11.Memo2.Text:=Form1.SQLQuery2.Fields[9].AsString;
  info[0].pozyczona:=Form1.SQLQuery2.Fields[12].AsString;
  sciezka:='image/b'+inttostr(identyfikator)+'.jpg';
  Form11.Image1.Picture.LoadFromFile(sciezka);

  Form1.SQLQuery2.Close;
  Form1.SQLTransaction2.Active:=False;
  Form1.SQLite3Connection2.Connected:=False;

  wyswietl();
end;

procedure ksiazka.edytuj_wpis(identyfikator:integer);
begin
 SetLength(info,length(info)+1);
 info[0].tytul:=Form11.Edit1.Text;
 info[0].autor:=Form11.Edit2.Text;
 info[0].wydawnictwo:=Form11.Edit3.Text;
 info[0].rok:=Form11.Edit4.Text;
 info[0].gatunek:=Form11.Edit5.Text;
 info[0].recenzja:=Form11.Memo1.Text;
 info[0].przeczytana:=Form11.ComboBox1.Caption;
 if Form11.ComboBox2.Caption='' then info[0].ocena:=0 else
 info[0].ocena:=strtoint(Form11.ComboBox2.Caption);
 info[0].isbn:=Form11.Edit8.Text;
 info[0].opinia:=Form11.Memo2.Text;
 info[0].data_przeczytania:=(Form11.DateEdit1.Date);

 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='update ksiazki set tytul = :tytul, autor = :autor, wydawnictwo = :wydawnictwo, rok = :rok, gatunek = :gatunek, przeczytana = :przeczytana, ocena = :ocena, isbn = :isbn, data_przeczytania = :data, recenzja = :recenzja, opinia = :opinia where id =  :identyfikator';
 Form1.SQLQuery1.Params[0].AsString:=info[0].tytul;
 Form1.SQLQuery1.Params[1].AsString:=info[0].autor;
 Form1.SQLQuery1.Params[2].AsString:=info[0].wydawnictwo;
 Form1.SQLQuery1.Params[3].AsString:=info[0].rok;
 Form1.SQLQuery1.Params[4].AsString:=info[0].gatunek;
 Form1.SQLQuery1.Params[5].AsString:=info[0].przeczytana;
 if info[0].ocena=0 then Form1.SQLQuery1.Params[6].Value:=null else
 Form1.SQLQuery1.Params[6].AsInteger:=info[0].ocena;
 Form1.SQLQuery1.Params[7].AsString:=info[0].isbn;
 Form1.SQLQuery1.Params[8].AsDate:=info[0].data_przeczytania;
 Form1.SQLQuery1.Params[9].AsString:=info[0].recenzja;
 Form1.SQLQuery1.Params[10].AsString:=info[0].opinia;
 Form1.SQLQuery1.Params[11].AsInteger:=identyfikator;
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.ExecSQL;
 Form1.SQLTransaction1.Commit;
 SetLength(info,0);
 wyswietl();
end;

procedure ksiazka.wypozycz(identyfikator:integer);
var
  numer:integer;
begin
  Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='insert into dluznik (rodzaj, imie, nazwisko, kiedy_pozyczyl, identyfikator) values ("ksiazka", :imie, :nazwisko, :kiedy, :identyfikator)';
 Form1.SQLQuery1.Params[0].AsString:=Form12.Edit1.Text;
 Form1.SQLQuery1.Params[1].AsString:=Form12.Edit2.Text;
 Form1.SQLQuery1.Params[2].AsDate:=Form12.DateEdit1.Date;
 Form1.SQLQuery1.Params[3].AsInteger:=identyfikator;
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.ExecSQL;
 Form1.SQLTransaction1.Commit;

 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='select * from dluznik where id = (select max(id) from ksiazki)';
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.Open;
 numer:= Form1.SQLQuery1.Fields[0].AsInteger;

 Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='update ksiazki set pozyczona = "Tak", komu = :id where id = :numer';
 Form1.SQLQuery1.Params[0].AsInteger:=numer;
 Form1.SQLQuery1.Params[1].AsInteger:=identyfikator;
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.ExecSQL;
 Form1.SQLTransaction1.Commit;
 wyswietl();
end;
procedure ksiazka.oddaj(identyfikator:integer);
var
  numer:Integer;
begin
  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.SQL.Text:='update ksiazki set pozyczona = "Nie", komu = NULL where id = :id';
  Form1.SQLQuery1.Params[0].AsInteger:=identyfikator;
  Form1.SQLTransaction1.Active:=True;
  Form1.SQLQuery1.ExecSQL;
  Form1.SQLTransaction1.Commit;

  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.SQL.Text:='select * from dluznik where identyfikator = :id AND kiedy_oddal IS NULL';
  Form1.SQLQuery1.Params[0].AsInteger:=identyfikator;
  Form1.SQLTransaction1.Active:=True;
  Form1.SQLQuery1.Open;
  numer:= Form1.SQLQuery1.Fields[0].AsInteger;

  Form1.SQLQuery1.Close;
  Form1.SQLQuery1.SQL.Text:='update dluznik set kiedy_oddal = :data where id = :id';
  Form1.SQLQuery1.Params[0].AsDate:=Now();
  Form1.SQLQuery1.Params[1].AsInteger:=numer;
  Form1.SQLTransaction1.Active:=True;
  Form1.SQLQuery1.ExecSQL;
  Form1.SQLTransaction1.Commit;
  wyswietl();
end;
procedure ksiazka.wyswietl_historie(identyfikator:integer);
begin
 Form1.SQLQuery1.Close;
 Form1.SQLTransaction1.Active:=False;
 Form1.SQLite3Connection1.Connected:=False;

 Form13.SQLQuery1.Close;
 Form13.SQLQuery1.SQL.Text:='select imie, nazwisko, kiedy_pozyczyl, kiedy_oddal from dluznik where identyfikator = :identyfikator and rodzaj="ksiazka"';
 Form13.SQLQuery1.Params[0].AsInteger:=identyfikator;
 Form13.SQLite3Connection1.Connected:=True;
 Form13.SQLTransaction1.Active:=True;
 Form13.SQLQuery1.Open;
end;
procedure ksiazka.dostosuj_obraz(identyfikator:integer);
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
       sciezka := 'image/b' +inttostr(identyfikator) +'.jpg';
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

