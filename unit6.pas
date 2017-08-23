unit Unit6;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm6 }

  TForm6 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form6: TForm6;

implementation
uses
  unit1;

{$R *.lfm}

{ TForm6 }

procedure TForm6.Button2Click(Sender: TObject);
begin
  Form6.Close;
end;

procedure TForm6.Button1Click(Sender: TObject);
var
  tekst:string;
  kryterium:integer;
begin
  kryterium:=0;
  if RadioButton1.Checked=True then kryterium:=1
  else if RadioButton2.Checked=True then kryterium:=2
  else if RadioButton3.Checked=True then kryterium:=3
  else if RadioButton4.Checked=True then kryterium:=4;
  tekst:=Form6.Edit1.Text;
  obiekt_ksiazka.szukaj(kryterium,tekst);
  Form6.Close;
end;

end.

