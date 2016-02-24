library Recurs_and_Res_DLL;

uses
  HelperUnit in 'HelperUnit.pas', Graphics;

{$R *.res}  {$R 'Проект ресурсов\elements.RES'}
//файл ресурсов с картинками элементов

type
  elements_pics_array = Array[1..48] of TBitmap;

procedure LoadPicsOfElements(out EP: elements_pics_array);
var
  i: Integer;
begin
  for i := 1 to 48 do EP[i].LoadFromResourceID(hInstance, i);
end;

exports
  recurs(pa: PPoleAr50_50; i,j,ruld: Integer),
  start(pa: PPoleAr50_50; i,j,ruld: Integer),
  LoadPicsOfElements;
begin
end.
