unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Button2: TButton;
    Button1: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function ReplaceStr(const s, Srch, Replace: string): string;
var
 i: integer;
 Source: string;
begin
 Source:=s;
 Result:='';
 repeat
  i:=Pos(Srch, Source);
  if i>0
  then
   begin
    Result:=Result+Copy(Source, 1, i-1)+Replace;
    Source:=Copy(Source, i+Length(Srch), MaxInt);
   end
  else Result:=Result+Source;
 until i<=0;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
 s: string;
begin
 if OpenDialog1.Execute // заменяет символы конца строки на пробелы
 then Edit1.Text:=ReplaceStr(OpenDialog1.Files.GetText, #13#10,' ');
end;

procedure TForm1.Button2Click(Sender: TObject);
var
 s,ss: string;
 PChTmp: PChar; // командная строка
 si: STARTUPINFO;
 pi: PROCESS_INFORMATION;
begin
 Edit2.Text:='';
 SaveDialog1.Filter:='Cab архив|*.cab';
 if SaveDialog1.Execute
 then
  begin
   Edit2.Text:=SaveDialog1.FileName+'.cab';
   // командная строка
   s:=Edit2.Text;
   ss:=Edit1.Text;
   PChTmp:=PChar('cabarc n '+s+' '+ss);
   ZeroMemory(@si, sizeof(si));
   si.cb:=SizeOf(si);
   if not CreateProcess(nil, PChTmp, nil, nil, false, 0, nil, nil, si, pi)
   then MessageDlg('Ошибка!'+#13+'Не могу запустить программу', mtError, [mbOk], 0);
   CloseHandle(pi.hProcess);
   CloseHandle(pi.hThread);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
 s,ss: string;
 PChTmp: PChar; // командная строка
 si: STARTUPINFO;
 pi: PROCESS_INFORMATION;
begin
 Edit2.Text:='';
 SaveDialog1.Filter:='Arj архив|*.arj';
 if SaveDialog1.Execute
 then
  begin
   Edit2.Text:=SaveDialog1.FileName+'.arj';
   // командная строка
   s:=Edit2.Text;
   ss:=Edit1.Text;
   PChTmp:=PChar('arj a -r -y '+s+' '+ss);
   ZeroMemory(@si, sizeof(si));
   si.cb:=SizeOf(si);
   if not CreateProcess(nil, PChTmp, nil, nil, false, 0, nil, nil, si, pi)
   then MessageDlg('Ошибка!'+#13+'Не могу запустить программу', mtError, [mbOk], 0);
   CloseHandle(pi.hProcess);
   CloseHandle(pi.hThread);
  end;   
end;

end.

