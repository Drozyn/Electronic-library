unit Unit15;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  EditBtn, ExtCtrls;

type

  { TForm15 }

  TForm15 = class(TForm)
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
    Image1: TImage;
    Label1: TLabel;
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
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form15: TForm15;
var
identyfikator_gry:integer;

implementation
uses
  unit4, unit1, unit11,unit12, unit13;


{$R *.lfm}

{ TForm15 }

procedure TForm15.Button4Click(Sender: TObject);
begin
  Form15.Close;
end;

procedure TForm15.Button5Click(Sender: TObject);
begin
  zrodlo_pozyczania:=3;
  Form13.Show;
end;

procedure TForm15.FormShow(Sender: TObject);
begin
 identyfikator_gry:=(Form1.DBGrid1.DataSource.DataSet.Fields[0].Value);
 obiekt_gry.wyswietl_rekord(identyfikator_gry);
 if obiekt_gry.info[0].pozyczona='Nie' then
 begin
 Form15.Button2.Visible:=True;
 Form15.Button3.Visible:=False;
 end
 else
 if obiekt_gry.info[0].pozyczona='Tak' then
 begin
 Form15.Button2.Visible:=False;
 Form15.Button3.Visible:=True;
 end;
end;

procedure TForm15.Button1Click(Sender: TObject);
begin
  obiekt_gry.edytuj_wpis(identyfikator_gry);
  Form15.Close;
end;

procedure TForm15.Button2Click(Sender: TObject);
begin
  zrodlo_pozyczania:=3;
  Form12.Show;
end;

procedure TForm15.Button3Click(Sender: TObject);
begin
  obiekt_gry.oddaj(identyfikator_gry);
  Form15.Button3.Visible:=False;
  Form15.Button2.Visible:=True;
end;

end.

