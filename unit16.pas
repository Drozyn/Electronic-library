unit Unit16;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ksiazki_nauka;

type

  { TForm16 }

  TForm16 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
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
  Form16: TForm16;
var
  identyfikator_kn:integer;

implementation
uses
  unit5, unit1, unit11, unit12, unit13;

{$R *.lfm}

{ TForm16 }

procedure TForm16.Button4Click(Sender: TObject);
begin
  Form16.Close;
end;

procedure TForm16.Button5Click(Sender: TObject);
begin
  zrodlo_pozyczania:=4;
  Form13.Show;
end;

procedure TForm16.Button1Click(Sender: TObject);
begin
  obiekt_ksiazki_nauka.edytuj_wpis(identyfikator_kn);
  Form16.Close;
end;

procedure TForm16.Button2Click(Sender: TObject);
begin
  zrodlo_pozyczania:=4;
  Form12.Show;
end;

procedure TForm16.Button3Click(Sender: TObject);
begin
  obiekt_ksiazki_nauka.oddaj(identyfikator_kn);
  Form16.Button3.Visible:=False;
  Form16.Button2.Visible:=True;
end;

procedure TForm16.FormShow(Sender: TObject);
begin
 identyfikator_kn:=(Form1.DBGrid1.DataSource.DataSet.Fields[0].Value);
 obiekt_ksiazki_nauka.wyswietl_rekord(identyfikator_kn);
 if obiekt_ksiazki_nauka.info[0].pozyczona='Nie' then
 begin
 Form16.Button2.Visible:=True;
 Form16.Button3.Visible:=False;
 end
 else
 if obiekt_ksiazki_nauka.info[0].pozyczona='Tak' then
 begin
 Form16.Button2.Visible:=False;
 Form16.Button3.Visible:=True;
 end;
end;

end.

