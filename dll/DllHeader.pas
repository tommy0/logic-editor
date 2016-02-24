//Заголовочный файл для библиотеки

unit DllHeader;

interface

uses Graphics;

type
  pole = Record
    inf, r, u, l, d: Integer;
  end;
  PoleAr50_50 = array [0..49, 0..49] of pole;
  PPoleAr50_50 = ^PoleAr50_50;
  elements_pics_array = Array[1..48] of TBitmap;

procedure recurs(pa: PPoleAr50_50; i,j,ruld: Integer);
external 'Dll\Recurs_and_Res_DLL';

//Загрузка картинок-символов логич. элементов
//в массив EP. Элементы массива должны быть созданы и
//уничтожены в вызывающей программе.
procedure LoadPicsOfElements(out EP: elements_pics_array);
external 'Dll\Recurs_and_Res_DLL';

implementation

end.
