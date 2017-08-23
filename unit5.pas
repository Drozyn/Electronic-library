unit Unit5;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, ksiazki_nauka;

type

  { TForm5 }

  TForm5 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form5: TForm5;
var
  obiekt_ksiazki_nauka:ksiazki_naukowe;

implementation
uses
  unit1;
{$R *.lfm}

{ TForm5 }

procedure TForm5.Button2Click(Sender: TObject);
begin
  Form5.Close;
end;

procedure TForm5.Button3Click(Sender: TObject);
var
  numer:integer;
begin
      Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='select * from ksiazki_nauka where id = (select max(id) from ksiazki_nauka)';
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.Open;
 numer:= Form1.SQLQuery1.Fields[0].AsInteger +1;
  obiekt_ksiazki_nauka.dostosuj_obraz(numer);
  obiekt_ksiazki_nauka.wyswietl_wszystkie();
end;

procedure TForm5.Button1Click(Sender: TObject);
begin
  obiekt_ksiazki_nauka.przypisz_dane();
  obiekt_ksiazki_nauka.dodaj();
  wyswietl_ksiazki_nauka();
  Form5.Close;
end;

procedure TForm5.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
//obiekt_ksiazki_nauka.Free;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
obiekt_ksiazki_nauka:=ksiazki_naukowe.create();
end;

end.

