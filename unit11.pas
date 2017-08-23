unit Unit11;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  EditBtn, ExtCtrls;

type

  { TForm11 }

  TForm11 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    DateEdit1: TDateEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit8: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
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
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form11: TForm11;
var
  identyfikator:integer;
  zrodlo_pozyczania:integer;

implementation
uses
  unit1, unit12, unit13;

{$R *.lfm}

{ TForm11 }

procedure TForm11.Button2Click(Sender: TObject);
begin
  Form11.Close;
end;

procedure TForm11.Button3Click(Sender: TObject);
begin
  zrodlo_pozyczania:=1;
  Form12.Show;
end;

procedure TForm11.Button4Click(Sender: TObject);
begin
  obiekt_ksiazka.oddaj(identyfikator);
end;

procedure TForm11.Button5Click(Sender: TObject);
begin
  zrodlo_pozyczania:=1;
  Form13.Show;
end;


procedure TForm11.FormShow(Sender: TObject);
begin
 identyfikator:=(Form1.DBGrid1.DataSource.DataSet.Fields[0].Value);
 obiekt_ksiazka.wyswietl_rekord(identyfikator);
 if obiekt_ksiazka.info[0].pozyczona='Nie' then
 begin
 Form11.Button3.Visible:=True;
 Form11.Button4.Visible:=False;
 end
 else
 if obiekt_ksiazka.info[0].pozyczona='Tak' then
 begin
 Form11.Button3.Visible:=False;
 Form11.Button4.Visible:=True;
 end;
end;


procedure TForm11.Button1Click(Sender: TObject);
begin
  obiekt_ksiazka.edytuj_wpis(identyfikator);
  Form11.Close;
end;

end.

