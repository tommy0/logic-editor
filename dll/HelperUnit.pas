unit HelperUnit;

//Для компиляции библиотеки

//==============================================================================
interface

type
  pole = Record
    inf, r, u, l, d: Integer;
  end;
  PoleAr50_50 = array [0..49, 0..49] of pole;
  PPoleAr50_50 = ^PoleAr50_50;
  bool = array [0..49, 0..49] of boolean;

//Пока ошибок не найдено, но надо еще тестить..
procedure recurs(pa: PPoleAr50_50; i, j, ruld: Integer); overload;
procedure start(pa: PPoleAr50_50; i, j, ruld: Integer); overload;

//==============================================================================



implementation

const
  RULD_ONE   = 1;
  RULD_TWO   = 2;
  RULD_THREE = 3;
  RULD_FOUR  = 4;
  n = 50;//размерность сетки

var
  a: PPoleAr50_50; //видна всюду в implementation
  //будет хранить адрес переданного массива (pa)
  flag: bool;
  k, p: integer;

procedure recurs(i, j, ruld: Integer); overload; forward;

procedure recurs(pa: PPoleAr50_50; i, j, ruld: Integer);
begin
  a := pa;  //сохраняем адрес массива
  recurs(i, j, ruld);
end;

procedure start(pa: PPoleAr50_50; i, j, ruld: Integer); overload;
begin
  recurs(i, j + 1, 1);
  //flag[i, j] := true;
end;

function isBottomToRight(inf: Integer): Boolean;//Снизу-направо
begin
  Result := ((inf = 19) or (inf = 20) );
end;

procedure recurs_ruld_one(i, j, ruld: Integer);//j-1(слева)
begin
  a[i, j].l := a[i, j - 1].r;
  if((a [i, j - 1].inf = 1) or (a[i, j - 1].inf = 2)) then 
  begin
    for k := 0 to 49 do
      for p := 0 to 49 do
        flag[k][p] := true;
  end;
  if (((a[i, j].inf = 3) or (a[i, j].inf = 4))) then  //лампочка работает!
  begin
    if (a[i, j].l = 0) then a[i, j].inf := 4;
    if (a[i, j].l = 1) then a[i, j].inf := 3;
  end;
  
  if ((a[i, j].inf = 9)) then  //отрицание работает
  begin
    if (a[i, j].l = 0) then a[i, j].r := 1;
    if (a[i, j].l = 1) then a[i, j].r := 0;
    if (j + 1 < n) then recurs(i, j + 1, 1);
  end;
  
  
  if(((a [i, j].inf = 21) or (a[i, j].inf = 22))) then  //право-вниз работает
  begin
    a[i, j].d := a[i, j].l;
    if(a [i, j].l = 0) then a[i, j].inf := 21;
    if(a [i, j].l = 1) then a[i, j].inf := 22;
    if((a [i + 1][j].u <> a[i, j].d) and (i + 1 < n)) then recurs(i + 1, j, 4);
  end;
  
  if(((a [i, j].inf = 23) or (a[i, j].inf = 24))) then  //право-вверх работает
  begin
    
    a[i, j].u := a[i, j].l;
    if(a [i, j].l = 0) then a[i, j].inf := 23;
    if(a [i, j].l = 1) then a[i, j].inf := 24;
    if((a [i - 1][j].d <> a[i, j].u) and (i - 1 >= 0)) then  recurs(i - 1, j, 2);
  end;
  
  if(((a [i, j].inf = 35) or (a[i, j].inf = 36))) then  //горизонтальная работает
  begin
    a[i, j].r := a[i, j].l;
    if(a [i, j].l = 0) then a[i, j].inf := 35;
    if(a [i, j].l = 1) then a[i, j].inf := 36;
    if((a [i][j + 1].l <> a[i, j].r) and (j + 1 < n)) then recurs(i, j + 1, 1);
  end;
end;

procedure recurs_ruld_two(i, j, ruld: Integer);//i+1(снизу)
begin
  a[i, j].d := a[i + 1][j].u;
  if((a [i, j].inf = 5) and flag[i, j]) then //И
  begin
    flag[i, j] := false;
    if(a [i, j].u = 1) and (a[i, j].d = 1) then a[i, j].r := 1
    else a[i, j].r := 0;
    if((j + 1 < n) and (a[i][j - 1].r <> -1))
      then recurs(i, j + 1, 1);
  end;
  if((a [i, j].inf = 6) and flag[i, j]) then //ИЛИ
  begin
    flag[i, j] := false;
    if((a [i, j].u = 0) and (a[i, j].d = 0)) then a[i, j].r := 0
    else if(a [i, j].d <> -1) then a[i, j].r := 1;
    if((a [i][j + 1].l <> a[i, j].r) and (j + 1 < n)
        and (a[i, j].r <> -1)) then 
      recurs(i, j + 1, 1);
  end;
  
  if (isBottomToRight(a[i, j].inf)) then  //Снизу-направо
  begin
    a[i, j].r := a[i, j].d;
    if (a[i, j].d = 1) then a[i, j].inf := 20;
    if (a[i, j].d = 0) then a[i, j].inf := 19;
    if ((a[i, j].r <> a[i][j + 1].l) and (j + 1 < n) ) then recurs(i, j + 1, 1);
  end;
  
  if(((a [i, j].inf = 45) or (a[i, j].inf = 46))) then //вверх-влево
  begin
    a[i, j].l := a[i, j].d;
    if(a [i, j].d = 1) then a[i, j].inf := 46;
    if(a [i, j].d = 0) then a[i, j].inf := 45;
    if((a [i, j].l <> a[i][j - 1].r) and (j - 1 >= 0)) then recurs(i, j - 1, 3);
  end;
  if(((a [i, j].inf = 37) or (a[i, j].inf = 38))) then
  begin
    a[i, j].u := a[i, j].d;
    if(a [i, j].d = 1) then a[i, j].inf := 38;
    if(a [i, j].d = 0) then a[i, j].inf := 37;
    if((a [i, j].u <> a[i - 1][j].d) and (i - 1 >= 0)) then recurs(i - 1, j, 2);
  end;
end;

procedure recurs_ruld_three(i, j, ruld: Integer);//j+1(справа)
begin
  a[i, j].r := a[i][j + 1].l;
  
  
  if (((a[i, j].inf = 43) or (a[i, j].inf = 44))) then 
  begin
    a[i, j].d := a[i, j].r;
    if (a[i, j].r = 0) then a[i, j].inf := 43;
    if (a[i, j].r = 1) then a[i, j].inf := 44;
    if ((a[i, j].d <> a[i + 1][j].u) and (i + 1 < n) ) then recurs(i + 1, j, 4);
  end;
  
  if (((a[i, j].inf = 41) or (a[i, j].inf = 42))) then
  begin
    a[i, j].u := a[i, j].r;
    if (a[i, j].r = 0) then a[i, j].inf := 41;
    if (a[i, j].r = 1) then a[i, j].inf := 42;
    if ((a[i, j].u <> a[i - 1][j].d) and (i - 1 >= 0) ) then recurs(i - 1, j, 2);
  end;
  
  
  
  if(((a [i, j].inf = 39) or (a[i, j].inf = 40))) then
  begin
    a[i, j].l := a[i, j].r;
    if(a [i, j].r = 0) then a[i, j].inf := 39;
    if(a [i, j].r = 1) then a[i, j].inf := 40;
    if((a [i, j].l <> a[i][j - 1].r) and (j - 1 >= 0)) then recurs(i, j - 1, 3);
  end;
end;

procedure recurs_ruld_four(i, j, ruld: Integer);//i-1(сверху)
begin
  a[i, j].u := a[i - 1][j].d;
  if((a [i, j].inf = 5) and flag[i, j]) then   // И
  begin
    flag[i, j] := false;
    if((a [i, j].u = 1) and (a[i, j].d = 1)) then a[i, j].r := 1
    else a[i, j].r := 0;
    if((j + 1 < n) ) then recurs(i, j + 1, 1);
  end;
  if((a [i, j].inf = 6) and flag[i, j]) then //ИЛИ
  begin
    flag[i, j] := false;
    if((a [i, j].u = 0) and (a[i, j].d = 0)) then a[i, j].r := 0 else a[i, j].r := 1;
    if((a [i][j + 1].l <> a[i, j].r) and (j + 1 < n) and (a[i, j].r <> -1)) then
      recurs(i, j + 1, 1);
  end;
  if(((a [i, j].inf = 37) or (a[i, j].inf = 38))) then
  begin
    a[i, j].d := a[i, j].u;
    if(a [i, j].u = 0) then a[i, j].inf := 37;
    if(a [i, j].u = 1) then a[i, j].inf := 38;
    if((a [i, j].d <> a[i + 1][j].u) and (i + 1 < n)) then recurs(i + 1, j, 4);
  end;
  if (((a[i, j].inf = 47) or (a[i, j].inf = 48))) then 
  begin
    a[i, j].l := a[i, j].u;
    if (a[i, j].u = 0) then a[i, j].inf := 47;
    if (a[i, j].u = 1) then a[i, j].inf := 48;
    if ((a[i, j].l <> a[i][j - 1].r) and (j - 1 <= n) ) then recurs(i, j - 1, 3);
  end;    
end;

procedure recurs(i, j, ruld: Integer);
begin
  case ruld of
    RULD_ONE:   recurs_ruld_one(i, j, ruld);   //j-1(слева)
    RULD_TWO:   recurs_ruld_two(i, j, ruld);   //i+1(снизу)
    RULD_THREE: recurs_ruld_three(i, j, ruld); //j+1(справа)
    RULD_FOUR:  recurs_ruld_four(i, j, ruld);  //i-1(сверху)
  end;
end;

end.