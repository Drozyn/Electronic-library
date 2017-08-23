unit Unit4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  EditBtn, gierki;

type

  { TForm4 }

  TForm4 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    DateEdit1: TDateEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit5: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Memo1: TMemo;
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
  Form4: TForm4;
var
  obiekt_gry:gry;
implementation
uses
  unit1;

{$R *.lfm}

{ TForm4 }

procedure TForm4.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
//obiekt_gry.Free;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  Form4.Close;
end;

procedure TForm4.Button3Click(Sender: TObject);
var
  numer:integer;
begin
    Form1.SQLQuery1.Close;
 Form1.SQLQuery1.SQL.Text:='select * from gry where id = (select max(id) from gry)';
 Form1.SQLTransaction1.Active:=True;
 Form1.SQLQuery1.Open;
 numer:= Form1.SQLQuery1.Fields[0].AsInteger +1;
  obiekt_gry.dostosuj_obraz(numer);
  obiekt_gry.wyswietl_wszystkie();
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
  obiekt_gry.przypisz_dane();
  obiekt_gry.dodaj();
  wyswietl_gry();
  Form4.Close;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
Form4.Memo1.Clear;
obiekt_gry:= gry.create();
end;

end.

