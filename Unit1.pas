unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus, ExtDlgs, Buttons;

type
  TMainForm = class(TForm)
    PaintBox: TPaintBox;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Edit1: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    Exit1: TMenuItem;
    Panel1: TPanel;
    SB_OR: TSpeedButton;
    SB_AND: TSpeedButton;
    SB_NOT: TSpeedButton;
    SB_SwitchInput: TSpeedButton;
    SB_Output: TSpeedButton;
    SB_Rubber: TSpeedButton;
    SbTurn: TSpeedButton;
    SbLine: TSpeedButton;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    Check1: TMenuItem;
    Editscheme1: TMenuItem;
    ClearAll1: TMenuItem;
    procedure PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure SB_Click(Sender: TObject);
    procedure SbTurnClick(Sender: TObject);
    procedure SbLineClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure SaveDialog1CanClose(Sender: TObject; var CanClose: Boolean);
    procedure Save1Click(Sender: TObject);
    procedure OpenDialog1CanClose(Sender: TObject; var CanClose: Boolean);
    procedure Open1Click(Sender: TObject);
    procedure Check1Click(Sender: TObject);
    procedure Editscheme1Click(Sender: TObject);
    procedure ClearAll1Click(Sender: TObject);
    private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses unit2;

const
  EL_CNT = 48; //всего элементов
  DIM    = 50; //размерность сетки

var
  element: elements_pics_array;
  x0, y0, h0, x1, y1, pero: Integer;
  mdown, mbLeftDown, Check: Boolean;
  pic: TBitmap;
  PoleArray: PoleAr50_50;

{$R *.dfm}

procedure Paint;
var
  i,j: Integer;
begin
  pic.Canvas.Brush.Color:=RGB(255,255,255);
  pic.Canvas.FillRect(Rect(0,0,pic.Width,pic.Height));
  pic.Canvas.Brush.Color:=RGB(0,0,0);
  for i:=0 to DIM-1 do
    for j:=0 to DIM-1 do
    begin
      if (Check = false) then
      begin
        pic.Canvas.Pen.Color:=RGB(200,200,200);
        pic.Canvas.Brush.Color:=RGB(255,255,255);
        pic.Canvas.Rectangle(Rect(x0+j*h0-1,y0+i*h0-1,x0+(j+1)*h0,y0+(i+1)*h0));
      end;
      if ( (PoleArray[i][j].inf > 0) and (PoleArray[i][j].inf <= EL_CNT ) ) then
        pic.Canvas.Draw(x0+j*h0,y0+i*h0,element[PoleArray[i][j].inf]);
    end;
  MainForm.PaintBox.Canvas.Draw(0,0,pic);
end;

procedure CheckProc;
var
  i,j: integer;
begin
  for i:=0 to DIM - 1 do
          for j:=0 to DIM - 1 do
           begin
            if (PoleArray[i,j].inf =35 ) or (PoleArray[i,j].inf = 36)then
              begin
               if(PoleArray[i][j].inf = 36 ) then  PoleArray[i][j].r:= 1;
                if(PoleArray[i][j].inf = 35 ) then  PoleArray[i][j].r:= 0;
                  recurs(@PoleArray,i,j+1,1);
              end;
          end;

  for i:=0 to DIM - 1 do
    for j:=0 to DIM - 1 do
    begin
      if (PoleArray[i,j].inf =1 ) or (PoleArray[i,j].inf = 2)then
      begin
        if(PoleArray[i][j].inf = 1 ) then  PoleArray[i][j].r:= 1;
        if(PoleArray[i][j].inf = 2 ) then  PoleArray[i][j].r:= 0;
        recurs(@PoleArray,i,j+1,1);
      end;
    end;
  Unit1.Paint;
end;


procedure TMainForm.PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  mdown:= False;
  mbLeftDown:= False;
  PaintBox.Cursor:=crDefault;
end;

procedure TMainForm.PaintBoxMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  k,l:integer;
begin
  if mbLeftDown then
  begin
    k:=(Y-y0) div h0;
    l:=(X-x0) div h0;
    if PoleArray[k,l].inf <> pero then
    begin
      PoleArray[k,l].inf:= pero;
      Unit1.Paint;
    end;
  end;

  if mdown then
  begin
    x0:=x0+X-x1;
    y0:=y0+Y-y1;
    x1:=X;
    y1:=Y;
    Unit1.Paint;
  end
  else
  if Check = False then
  begin
    if ( (pero > 0) and (pero <= EL_CNT) and (X > x0) and (Y > y0)
      and (X-x0 < pic.Width) and (Y-y0 < pic.Height) ) then
    begin
      PaintBox.Canvas.Draw(0,0,pic);
      PaintBox.Canvas.Draw(x0+(X-x0) div h0*h0,y0+(Y-y0) div h0*h0,
        element[pero]);
    end;
  end;
end;


procedure TMainForm.PaintBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 i,j, k, l: Integer;
begin
  x1:= X;
  y1:= Y;
  if (Button = mbRight) then
  begin
    mdown:= True;
    PaintBox.Cursor:= crHandPoint;
  end;

  if (Button = mbLeft) and (Check = False) then
  begin
    mbLeftDown:= True;
    k:= (Y-y0) div h0;
    l:= (X-x0) div h0;
    PoleArray[k,l].inf:= pero;
  end;

  if Check then
  begin
    k:= (Y-y0)div h0;
    l:= (X-x0) div h0;

    if (k >= 0) and (k < DIM) and (l >= 0) and (l < DIM)  then
    begin

      if (PoleArray[k,l].inf = 1) then
      begin
        PoleArray[k,l].inf:= 2;
        PoleArray[k,l].r:= 0;
        recurs(@PoleArray,k,l+1,1);
        for i:=0 to DIM - 1 do
          for j:=0 to DIM - 1 do
           begin
            if (PoleArray[i,j].inf =35 ) or (PoleArray[i,j].inf = 36)then
              begin
               if(PoleArray[i][j].inf = 36 ) then  PoleArray[i][j].r:= 1;
                if(PoleArray[i][j].inf = 35 ) then  PoleArray[i][j].r:= 0;
                  recurs(@PoleArray,i,j+1,1);
              end;
          end;

      end
      else
      if PoleArray[k,l].inf = 2 then
        begin
          PoleArray[k,l].inf:= 1;
          PoleArray[k,l].r:= 1;

          recurs(@PoleArray,k, l+1, 1);
          for i:=0 to DIM - 1 do
          for j:=0 to DIM - 1 do
           begin
            if (PoleArray[i,j].inf =35 ) or (PoleArray[i,j].inf = 36)then
              begin
               if(PoleArray[i][j].inf = 36 ) then  PoleArray[i][j].r:= 1;
                if(PoleArray[i][j].inf = 35 ) then  PoleArray[i][j].r:= 0;
                  recurs(@PoleArray,i,j+1,1);
              end;
          end;

        end;
      end;
    end;

  Unit1.Paint;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  i,j: Integer;
begin
  mdown:= False;
  mbLeftDown:= False;
  pic:= TBitmap.Create;

  Check:= False;
  pero:= 2;
  x0:= 0;
  y0:= 0;
  h0:= 32;

  for i := 0 to DIM - 1 do
  for j := 0 to DIM - 1 do
  begin
    PoleArray[i,j].inf:= 0;
    PoleArray[i,j].r:= 0;
    PoleArray[i,j].u:= 0;
    PoleArray[i,j].l:= 0;
    PoleArray[i,j].d:= 0;
  end;

  for i := 1 to EL_CNT do element[i]:= TBitmap.Create;

  LoadPicsOfElements(element);

  pic.Width:= DIM*h0;
  pic.Height:= DIM*h0;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: Integer;
begin
  pic.Free;
  for i := 1 to EL_CNT do element[i].Free;
end;

procedure TMainForm.FormPaint(Sender: TObject);
begin
  Unit1.Paint;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  PaintBox.Width:= ClientWidth - PaintBox.Left;
  PaintBox.Height:= ClientHeight - PaintBox.Top;
end;

procedure TMainForm.SB_Click(Sender: TObject);
begin
  pero:= (Sender as TSpeedButton).tag;
end;

procedure TMainForm.SbTurnClick(Sender: TObject);
begin
    sbTurn.Tag:=sbTurn.Tag+2;
    if(SbTurn.Tag=25) then SbTurn.Tag:=41;
    if(SbTurn.Tag>47) then SbTurn.Tag:=17;
    pero:= (Sender as TSpeedButton).tag;
end;

procedure TMainForm.SbLineClick(Sender: TObject);
begin
    sbLine.Tag:=sbLine.Tag+2;
    if(SbLine.Tag>39) then SbLine.Tag:=35;
    pero:= (Sender as TSpeedButton).tag;
end;

procedure TMainForm.Exit1Click(Sender: TObject);
begin
close;
end;

procedure TMainForm.SaveDialog1CanClose(Sender: TObject;
  var CanClose: Boolean);
var
  str, tmp: String;
  i: Integer;
  j: Integer;
  OutputFile: File of Integer;
begin
  str:= SaveDialog1.FileName;
  if (str <> '') then
  begin
    if ( length(str)> 3) then tmp:= copy(str, length(str)-2, 3);
    if ( tmp <> '.ls') then  str:= str + '.ls';
    AssignFile(OutputFile, str);
    Rewrite(OutputFile);
    for i := 0 to DIM - 1 do
      for j := 0 to DIM - 1 do
        Write(OutputFile, PoleArray[i,j].inf);
    CloseFile(OutputFile);
  end;
end;

procedure TMainForm.Save1Click(Sender: TObject);
begin
  SaveDialog1.Execute;
end;

procedure TMainForm.OpenDialog1CanClose(Sender: TObject;
  var CanClose: Boolean);
var
  str: String;
  i: Integer;
  j: Integer;
  InputFile: File of Integer;
begin
  str:= OpenDialog1.FileName;
  if str <> '' then
  begin
    AssignFile(InputFile,str);
    Reset(InputFile);
    for i := 0 to DIM - 1 do
      for j := 0 to DIM - 1 do
      begin
        PoleArray[i,j].inf:= 0;
        PoleArray[i,j].r:= 0;
        PoleArray[i,j].u:= 0;
        PoleArray[i,j].l:= 0;
        PoleArray[i,j].d:= 0;
        Read(InputFile, PoleArray[i,j].inf);
      end;
    CloseFile(InputFile);
  end;
    Unit1.Paint;
end;

procedure TMainForm.Open1Click(Sender: TObject);
begin
  OpenDialog1.Execute;
end;



procedure TMainForm.Check1Click(Sender: TObject);
var
  i: Integer;
  j: Integer;
begin
  Check:= true;
  ClearAll1.Visible:= False;
  for i := 0 to DIM - 1 do
    for j := 0 to DIM - 1 do
    begin
      PoleArray[i,j].r:= 0;
      PoleArray[i,j].u:= 0;
      PoleArray[i,j].l:= 0;
      PoleArray[i,j].d:= 0;
    end;
  CheckProc;
end;

procedure TMainForm.Editscheme1Click(Sender: TObject);
var
  i,j:integer;
begin
  Check:= False;
  ClearAll1.Visible:= True;
  Unit1.Paint;

end;

procedure TMainForm.ClearAll1Click(Sender: TObject);
var
  i: Integer;
  j: Integer;
begin
  for i := 0 to DIM - 1 do
    for j := 0 to DIM - 1 do
    begin
      PoleArray[i][j].inf:=0;
      PoleArray[i][j].r:=-1;
      PoleArray[i][j].u:=-1;
      PoleArray[i][j].l:=-1;
      PoleArray[i][j].d:=-1;
    end;
    Unit1.Paint;
end;


end.
