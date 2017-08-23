unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Calendar, ExtDlgs, EditBtn;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    DateEdit2: TDateEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
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
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;

implementation
uses
  unit1;

{$R *.lfm}

{ TForm2 }

procedure TForm2.FormCreate(Sender: TObject);
begin
  Form2.Memo1.Clear;
  Form2.Memo2.Clear;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  Form2.Close;
end;

procedure TForm2.Button3Click(Sender: TObject);
var
  numer:integer;
begin
Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='select * from ksiazki where id = (select max(id) from ksiazki)';
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.Open;
 numer:= Form1.SQLQuery1.Fields[0].AsInteger +1;
  obiekt_ksiazka.dostosuj_obraz(numer);
  wyswietl();
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  tekst:string;
begin
  obiekt_ksiazka.przypisz_dane();
  obiekt_ksiazka.dodaj;
  Form2.Close;
end;

end.

