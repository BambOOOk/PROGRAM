unit lable1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TAFuncSeries, TASeries, Forms, Controls,
  Graphics, Dialogs, StdCtrls, CheckLst, ExtCtrls, Synaser;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button3: TButton;
    CheckListBox1: TCheckListBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);



    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  ser: TBlockSerial;
  x:string;
  pack: string;
  data: string;
  incr: integer;
  lv:integer;
  f:text;
  step:integer;
  per:integer;


implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);

begin
  ser:= TBlockSerial.Create;
  ser.RaiseExcept := True;
  ser.LinuxLock := False; // это требуется для Linux. Если это не установить, то не удастся открыть порт.

  ser.Connect('/dev/ttyUSB0'); // открытие порта
  ser.Config(9600, 8, 'N', 0, false, false); // указываем параметры передачи данных
  writeln('Device'+ser.Device+ 'Status:'+ser.LastErrorDesc+''+Inttostr(ser.LastError));
  Sleep(500);
  incr:=StrToInt(Edit1.Text);
  lv:=StrToInt(Edit2.Text);
  step:=StrToInt(Edit3.Text);
  per:=StrToInt(Edit4.Text);

    while incr <= lv do
        begin

             ser.SendString('U' + IntToStr(incr) + #10); // отправляем буфер в порт
             Sleep(per);
             ser.SendString('U?' + #10);
             x:=ser.RecvBufferStr(8,500);
             incr:= incr + step;
             CheckListBox1.Items.Add(x);
        end;
    ser.free;
    end;
end.


