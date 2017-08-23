unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  EditBtn, filmy;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
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
  Form3: TForm3;
var
  obiekt_film:film;

implementation
uses
  unit1;
{$R *.lfm}

{ TForm3 }

procedure TForm3.FormCreate(Sender: TObject);
begin
   Form3.Memo1.Clear;
   Form3.Memo2.Clear;
   obiekt_film:=film.create();
end;

procedure TForm3.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  //obiekt_film.destroy();
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  obiekt_film.przypisz_dane();
  obiekt_film.dodaj();
  wyswietl_film();
  Form3.Close;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  Form3.Close;
end;

procedure TForm3.Button3Click(Sender: TObject);
var numer:integer;
begin
  Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='select * from filmy where id = (select max(id) from filmy)';
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.Open;
 numer:= Form1.SQLQuery1.Fields[0].AsInteger +1;
  obiekt_film.dostosuj_obraz(numer);
  obiekt_film.wyswietl_wszystkie();
end;

end.

