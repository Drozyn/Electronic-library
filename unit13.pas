unit Unit13;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqlite3conn, sqldb, db, FileUtil, Forms, Controls,
  Graphics, Dialogs, DBGrids, StdCtrls;

type

  { TForm13 }

  TForm13 = class(TForm)
    Button1: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    SQLite3Connection1: TSQLite3Connection;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form13: TForm13;

implementation
uses
  unit1, unit11,unit3, unit14, unit4, unit15, unit5, unit16;

{$R *.lfm}

{ TForm13 }

procedure TForm13.Button1Click(Sender: TObject);
begin
  Form13.Close;
end;

procedure TForm13.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Form13.SQLQuery1.Close;
  Form13.SQLTransaction1.Active:=False;
  FOrm13.SQLite3Connection1.Connected:=False;
  if zrodlo_pozyczania=1 then
  wyswietl() else
  if zrodlo_pozyczania=2 then
  obiekt_film.wyswietl_wszystkie();
end;

procedure TForm13.FormShow(Sender: TObject);
begin
  if zrodlo_pozyczania=1 then
  obiekt_ksiazka.wyswietl_historie(identyfikator) else
  if zrodlo_pozyczania=2 then
  obiekt_film.wyswietl_historie(identyfikator_film) else
  if zrodlo_pozyczania=3 then
  obiekt_gry.wyswietl_historie(identyfikator_gry) else
  if zrodlo_pozyczania=4 then
  obiekt_ksiazki_nauka.wyswietl_historie(identyfikator_kn);

end;

end.

