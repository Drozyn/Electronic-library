unit Unit9;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm9 }

  TForm9 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form9: TForm9;

implementation
uses
  unit5;
{$R *.lfm}

{ TForm9 }

procedure TForm9.Button2Click(Sender: TObject);
begin
  Form9.Close;
end;

procedure TForm9.Button1Click(Sender: TObject);
var
  tekst:string;
  kryterium:integer;
begin
 kryterium:=0;
  if RadioButton1.Checked=True then kryterium:=1
  else if RadioButton2.Checked=True then kryterium:=2
  else if RadioButton3.Checked=True then kryterium:=3;
  tekst:=Form9.Edit1.Text;
  obiekt_ksiazki_nauka.szukaj(kryterium,tekst);
  Form9.Close;
end;

end.

