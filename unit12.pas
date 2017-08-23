unit Unit12;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  EditBtn, unit14, unit15, unit16;

type

  { TForm12 }

  TForm12 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DateEdit1: TDateEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form12: TForm12;

implementation
uses
  unit1, unit11, unit4, unit5;
{$R *.lfm}

{ TForm12 }

procedure TForm12.Button2Click(Sender: TObject);
begin
  Form12.Close;
end;

procedure TForm12.Button1Click(Sender: TObject);
begin
  if zrodlo_pozyczania=1 then
  begin
  obiekt_ksiazka.wypozycz(identyfikator);
  Form11.Button3.Visible:=False;
  Form11.Button4.Visible:=True;
  end
  else
  if zrodlo_pozyczania=2 then
  begin
  obiekt_film.wypozycz(identyfikator_film);
  Form14.Button2.Visible:=False;
  Form14.Button3.Visible:=True;
  end
  else
  if zrodlo_pozyczania=3 then
  begin
  obiekt_gry.wypozycz(identyfikator_gry);
  Form15.Button2.Visible:=False;
  Form15.Button3.Visible:=True;
  end
  else
  if zrodlo_pozyczania=4 then
  begin
  obiekt_ksiazki_nauka.wypozycz(identyfikator_kn);
  Form16.Button2.Visible:=False;
  Form16.Button3.Visible:=True;
  end;
  Form12.Close;
end;

end.

