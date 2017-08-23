unit Unit14;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  EditBtn, ExtCtrls, filmy;

type

  { TForm14 }

  TForm14 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
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
  Form14: TForm14;
var
  identyfikator_film:integer;
  obiekt_film:film;

implementation
 uses
   unit3, unit1, unit11, unit12, unit13;
{$R *.lfm}

{ TForm14 }

procedure TForm14.FormShow(Sender: TObject);
begin
 obiekt_film:=film.create();
 identyfikator_film:=(Form1.DBGrid1.DataSource.DataSet.Fields[0].Value);
 obiekt_film.wyswietl_rekord(identyfikator_film);
 if obiekt_film.info[0].pozyczona='Nie' then
 begin
 Form14.Button2.Visible:=True;
 Form14.Button3.Visible:=False;
 end
 else
 if obiekt_film.info[0].pozyczona='Tak' then
 begin
 Form14.Button2.Visible:=False;
 Form14.Button3.Visible:=True;
 end;
end;

procedure TForm14.Button4Click(Sender: TObject);
begin
 obiekt_film.Free;
  Form14.Close;
end;

procedure TForm14.Button5Click(Sender: TObject);
begin
  zrodlo_pozyczania:=2;
  Form13.Show;
end;

procedure TForm14.Button2Click(Sender: TObject);
begin
  zrodlo_pozyczania:=2;
  Form12.Show;
end;

procedure TForm14.Button3Click(Sender: TObject);
begin
  obiekt_film.oddaj(identyfikator_film);
  Form14.Button3.Visible:=False;
  Form14.Button2.Visible:=True;
end;

procedure TForm14.Button1Click(Sender: TObject);
begin
  obiekt_film.edytuj_wpis(identyfikator_film);
  Form14.Close;
end;

end.

