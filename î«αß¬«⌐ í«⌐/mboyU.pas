unit mboyU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, MPlayer;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Timer1: TTimer;
    Panel1: TPanel;
    Image1: TImage;
    Label4: TLabel;
    MediaPlayer1: TMediaPlayer;
    Timer2: TTimer;
    Timer3: TTimer;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    RadioGroup1: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure Label2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label3Click(Sender: TObject);
    procedure Label3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label3MouseLeave(Sender: TObject);
    procedure Label2MouseLeave(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure Label2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Delay(msecs : Longint);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{ $R Cursor.res}
type mass=array[0..11,0..11]of byte;
const dx=24;dy=24;
So='Осталось ';
Sk=' корабл';
Skm:array[0..10]of string[2]=('ей','ь','я','я','я','ей','ей','ей','ей','ей','ей');
var m,Status,Flkor,Flkor0,Ncom,Nmy,myxod,
Kd,Ku,Id2,Iu2,Jd2,Ju2,Nog,xod:byte;Nkyb,Nkop,i0,j0,i1,j1:array[1..2]of byte;
xn1,yn1,xk1,yk1,xn2,yn2,xk2,yk2,dxm:integer;
napr2:Char;
Nko:array[0..4]of shortint;
Ko:array[1..2,0..4]of shortint;
b:mass;
a,w:array[1..2]of mass;
V:array[1..2]of byte;

Procedure StirMope(N:byte);
begin
 WITH Form1.Image1.Canvas do begin
  pen.Color:=Form1.Panel1.Color;
  brush.Color:=Form1.Panel1.Color;
  Rectangle(xn1+N*dxm,yn1,xk1+N*dxm,yk1);
 end;
end;

Procedure Mope(N:byte);
var i:byte;
begin
 WITH Form1.Image1.Canvas do begin
  pen.Color:=clblue;brush.Color:=clblue;
  Rectangle(xn1+N*dxm,yn1,xk1+N*dxm,yk1);
  pen.Color:=clwhite;pen.Width:=1;
  For i:=0 to 10 do begin
   Moveto(xn1+N*dxm,yn1+dy*i);
   lineto(xk1+N*dxm,yn1+dy*i);
   Moveto(xn1+N*dxm+dx*i,yn1);
   lineto(xn1+N*dxm+dx*i,yk1);
  end;
 end;
end;

Procedure Granica(No:byte);
var i,j:byte;
begin
 FillChar(b,Sizeof(b),0);
 for i:=0 to 11 do for j:=0 to 11 do if i*j mod 11=0 then a[No,i,j]:=10
end;

Procedure iniGame;
var i:byte;
begin
 FillChar(b,Sizeof(b)*3,0);for i:=1 to 4 do begin ko[2,i]:=0;ko[1,i]:=5-i end;
 for i:=1 to 2 do begin V[i]:=0;Nkop[i]:=10 end;
 Nkyb[1]:=0;Nkyb[2]:=0;Status:=0;Flkor0:=0;StirMope(0);Mope(1);
 with Form1 do begin
  Label1.Visible:=False;Label2.Visible:=True;Label3.Visible:=True;
  Label3.Font.Color:=clBlack;Timer1.Enabled:=False;Label5.Visible:=True;
  Label6.Visible:=False;Label7.Visible:=False;Form1.RadioGroup1.Enabled:=True;
 end;
end;

Procedure Rxyn(n:byte;var xn,yn:integer);
begin
 if n=1 then xn:=xn1 else xn:=xn2;yn:=yn1;
end;

Procedure Rij(No:byte;x,y:integer;var i,j:byte);
var xn,yn:integer;
begin
 Rxyn(No,xn,yn);i:=((y-yn) div dy)+1;j:=((x-xn) div dx)+1
end;

Procedure Rxy(No,i,j:byte;var x,y:integer);
var xn,yn:integer;
begin
 Rxyn(No,xn,yn);x:=(j-1)*dx+xn;y:=(i-1)*dy+yn
end;

var ng:array[1..4]of byte;
       // Определение направления корабля и границ части подбитого корабля
Procedure Scan(No,i,j:byte;var napr:char;var niz,verx,n:byte;k2:byte);
var p,q,l:byte;
begin
 fillchar(ng,4,0);
 if(a[No,i,j]=10)and(k2=10)then begin i:=i0[No];j:=j0[No]end;
 p:=i;q:=j;n:=1;
           {Вертикаль}
 while(p>1)and(a[No,p-1,j]>k2)do dec(p);niz:=p;
 if k2=10 then begin l:=p;While a[No,l-1,j]<10 do dec (l);ng[2]:=l end;
 while(p<10)and(a[No,p+1,j]>k2)do begin inc(p);inc(n)end;verx:=p;
 if k2=10 then begin l:=p;While a[No,l+1,j]<10 do inc(l);ng[4]:=l end;
 napr:='v';
          {Горизонталь}
 if p=niz then
  napr:='g';
  while(q>1)and(a[No,i,q-1]>k2)do dec(q);if napr='g'then niz:=q;
  if k2=10 then begin l:=q;While a[No,i,l-1]<10 do dec (l);ng[1]:=l end;
  while(q<10)and(a[No,i,q+1]>k2)do begin inc(q);inc(n)end;if napr='g'then verx:=q;
  if k2=10 then begin l:=q;While a[No,i,l+1]<10 do inc(l);ng[3]:=l end;
end;

Procedure PutKor(N,i,j,k2:byte);
const dy3=4;dx5=5;dx2=2;dy2=2;
var x,y,yc,xc,xh,yh,x1,y1,x2,y2:integer;
napr:char;

Procedure Scan(i,j:byte;var nap:char);
var p,niz:byte;
begin
 p:=i;
           {Вертикаль}
 while(p>1)and((a[N,p-1,j]>k2)or((Status=2)and(a[N,p-1,j]>0)))and(a[N,p-1,j]<>10)do dec(p);niz:=p;
 while(p<10)and((a[N,p+1,j]>k2)or((Status=2)and(a[N,p+1,j]>0)))and(a[N,p+1,j]<>10)do inc(p);
          {Горизонталь}
 if p=niz then nap:='g' else nap:='v';
end;

Procedure dyga(m:shortint;nap:char);
var x11,x21,y11,y21,x3,y3,x4,y4:integer;
begin
 if nap='g'then begin
  y11:=y+yc-yh;y21:=y+yc+yh;x11:=x1;x21:=x2;
  if m=-1 then begin y3:=y11;y4:=y21 end
  else begin y3:=y21;y4:=y11 end;
  x3:=x+xc+m*xh;x4:=x3
 end else begin
  x11:=x+xc-xh;x21:=x+xc+xh;y11:=y1;y21:=y2;
  if m=-1 then begin x3:=x21;x4:=x11 end
  else begin x3:=x11;x4:=x21 end;
  y3:=y+yc+m*yh;y4:=y3;
 end;
// x1:=x+2;y1:=y+2;x2:=x+dx-1;y2:=y+dy-1;
 with Form1.Image1.Canvas do begin
  pen.Color:=clOlive;brush.Color:=clOlive;Pie(x11,y11,x21,y21,x3,y3,x4,y4)
 end
end;

begin
Rxy(N,i,j,x,y);with Form1.Image1.Canvas do begin
  pen.Color:=clblue;brush.Color:=clblue;
  x1:=x+2;y1:=y+2;x2:=x+dx-1;y2:=y+dy-1;
  Rectangle(x1,y1,x2,y2);
  if(a[N,i,j]in[0,10])then exit;
  yc:=dy div 2+1;xc:=dx div 2+1;xh:=xc div 2+1;yh:=yc div 2+1;
  pen.Color:=clOlive;brush.Color:=clOlive;
  Scan(i,j,napr);
    // Рисование законченного корабля
  if((Status=1)and(w[N,i,j]=0))or(N=2)or(Status=2)then
  if(napr='g')then begin
   if(a[N,i,j-1]=k2)or((a[N,i,j-1]=0)and((N=2)or(Status=2)))then
   begin
    dyga(-1,napr);
    Rectangle(x+xc-xh+2,y+yc-yh,x+xc,y+yc+yh)
   end
   else Rectangle(x1,y+yc-yh,x+xc,y+yc+yh);
   if(a[N,i,j+1]=k2)or((a[N,i,j+1]=0)and((N=2)or(Status=2)))then begin
   Rectangle(x+xc,y+yc-yh,x+xc+xh-2,y+yc+yh);
   dyga(1,napr)end
   else Rectangle(x+xc,y+yc-yh,x2,y+yc+yh);
  end
  else begin
   if(a[N,i-1,j]=k2)or((a[N,i-1,j]=0)and((N=2)or(Status=2)))then begin dyga(-1,napr);
    Rectangle(x+xc-xh,y+yc-yh+2,x+xc+xh,y+yc)
   end
   else Rectangle(x+xc-xh,y1,x+xc+xh,y+yc);
   if(a[N,i+1,j]=k2)or((a[N,i+1,j]=0)and((N=2)or(Status=2)))then begin
   Rectangle(x+xc-xh,y+yc,x+xc+xh,y+yc+yh-2);
   dyga(1,napr)
   end
   else Rectangle(x+xc-xh,y+yc,x+xc+xh,y2);
  end
     // Рисование незаконченного корабля
  else Rectangle(x+2,y+2,x+dx-1,y+dy-1);
  if(napr='g')then begin
   pen.Color:=clwhite;moveto(X+dx5,y+yc);lineto(X+dx5+3,y+yc-dy3);
   lineto(x+dx-1-dx5-3,y+yc-dy3);pen.Color:=clblack;lineto(x+dx-1-dx5,y+yc);
   lineto(x+dx-1-dx5-3,y+yc+dy3);lineto(x+dx5+3,y+yc+dy3);lineto(x+dx5,y+yc);
   Moveto(x+xc+dx2,y+yc-dy3);Lineto(x+xc+dx2,y+2+dy3);
   Moveto(x+xc+dx2,y+yc+dy3);Lineto(x+xc+dx2,y+dy-1-dy3);
   Lineto(x+xc-1,y+dy-1-dy3);pen.Color:=clwhite;
   Moveto(x+xc-1,y+yc-dy3);Lineto(x+xc-1,y+2+dy3);
   Lineto(x+xc+dx2,y+2+dy3);Moveto(x+xc-1,y+yc+dy3);
   Lineto(x+xc-1,y+dy-1-dy3);
  end else begin
   pen.Color:=clwhite;
   moveto(x+xc,y+2+dy3);lineto(x+xc-dx5+1,y+dy3+3+2);
   lineto(x+xc-dx5+1,y+dy-1-dy3-3);pen.Color:=clblack;
   lineto(x+xc,y+dy-1-dy3);lineto(x+xc+dx5-1,y+dy-1-dy3-3);
   lineto(x+xc+dx5-1,y+dy3+3);lineto(x+xc,y+dy3);Moveto(x+xc-dx5+1,y+yc+dy2);
   Lineto(x+2+dx5-1,y+yc+dy2);Moveto(x+xc+dx5-1,y+yc+dy2);
   Lineto(x+dx-1-dx5+1,y+yc+dy2);Lineto(x+dx-1-dx5+1,y+yc-1);
   pen.Color:=clwhite;Moveto(x+yc-dx5+1,y+yc-1);
   Lineto(x+2+dx5-1,y+yc-1);Lineto(x+2+dx5-1,y+yc+dy2);
   Moveto(x+xc+dx5-1,y+yc-1);Lineto(x+dx-1-dx5+1,y+yc-1);
  end;
end;
end;
               // Рисование кораблей
Procedure PrKop(N,k2:byte);
var i,j:byte;
begin
 For i:=1 to 10 do for j:=1 to 10 do if a[N,i,j]in[1..4]then
 PutKor(N,i,j,k2)
end;

Procedure Play(S:string);
begin
 with Form1.MediaPlayer1 do begin
  FileName:=S;Open;Play
 end
end;

const
dx1:array[1..7]of byte=(5,7,9,11,13,15,18);
dy1:array[1..7]of byte=(4,11,8,17,10,5,13);
dx2:array[1..7]of byte=(3,4,4,4,3,5,3);
dy2:array[1..7]of byte=(7,8,5,4,6,8,4);
dyo:array[1..7,0..1]of byte=((0,2),(3,0),(4,0),(0,4),(0,3),(3,0),(0,3));
          // Горение подбитого корабля
Procedure PutOgon(var Nog:byte);
var i,j,k,o:byte;x,y:integer;
begin
 Nog:=1-Nog;
 with Form1.Image1.Canvas do begin
  for o:=1 to 2 do for i:=1 to 10 do for j:=1 to 10 do if a[o,i,j]>10 then begin
  Rxy(o,i,j,x,y);
  Putkor(o,i,j,10);
  pen.Color:=clRed;
  brush.Color:=clRed;
  for k:=1 to 7 do
  ellipse(x+dx1[k],y+dy1[k]-dyo[k,Nog],x+dx1[k]+dx2[k],y+dy1[k]+dy2[k]);
 end;
 end;
end;

Procedure Coob(Ncom,Nmy:byte);
begin
 xod:=2;Status:=2;
 with Form1.Label1 do begin
  Visible:=True;
  if Ncom=0 then begin Color:=clLime;Caption:='Миссия выполнена!';
   Form1.Delay(1000);
   Play('yes.wav');
  end
  else begin
   PrKop(1,10);
   Color:=clRed;Caption:='Операция провалена';
   Form1.Delay(1000);
   Play('ricochet.wav');Form1.Delay(1000);
   Screen.Cursor:=crdefault;
  end;
 end;
end;

Procedure Opr(var p,q:byte);
var k:integer;
begin
 k:=Random(100)+1;
 p:=(k-1)div 10+1;q:=(k-1)mod 10+1
end;
      // авторасстановка кораблей
Procedure KorabliKi(No:byte);
var i,j,k,h,l,p,q,s,Fl,o,r:byte;
Procedure Pole(k,p,q:byte;var l,h:byte);
var n,o,r,c,d:byte;
Procedure Pole1(var p,q:byte;e:shortint);
var t,u:byte;
begin
 if k=0 then begin t:=q;u:=p+e end
        else begin t:=p+e;u:=q end;
 while(n<j)and(p>-e)and(p<11-e)and(b[t,u]=0)do begin
  p:=p+e;
  if k=0 then u:=u+e
  else t:=t+e;inc(n)
 end
end;
    {Pole}
begin
 n:=1;if k=1 then begin c:=p;d:=q end else begin c:=q;d:=p end;
 h:=c;Pole1(c,d,-1);l:=c;
 if n<j then begin c:=h;Pole1(c,d,1);h:=c end;
 if n=j then For o:=l-1 to h+1 do begin
  For r:=d-1 to d+1 do if k=0 then b[r,o]:=1 else b[o,r]:=1;
  if o in[l..h]then if k=0 then a[No,d,o]:=j else a[No,o,d]:=j
 end
end;
{k=1-Вертикаль;k=0-Горизонталь}
begin   // j - количество палуб на корабле i - Количество кораблей
 for j:=4 downto 1 do for i:=1 to 5-j do
 repeat
   // Поиск первой координаты p и q корабля не соприкасаемых с другими кораблями
   // l и h последние координаты
  repeat
   Opr(p,q);
   Fl:=0;For o:=p-1 to p+1 do For r:=q-1 to q+1 do
   if(Fl=0)and(o in[1..10])and(r in[1..10])then Fl:=a[No,o,r];
  until Fl=0;
  k:=Random(2);s:=0;
  repeat
   inc(s);
   Pole(k,p,q,l,h);k:=1-k
  until(s=2)or(1+h-l=j)
 until 1+h-l=j
end;

     // Сканирование при ручной расстановке кораблей
Procedure ScanPole(d,c:byte;var Nk:byte);
var i,j,niz,verx,Nt:byte;

Procedure Scan1(i,j:byte;var Nt:byte);
var p,q,niz,verx,No,k:byte;
begin
 p:=i;q:=j;nt:=1;No:=2;b[i,j]:=1;
           {Вертикаль}
 while(p>1)and(a[No,p-1,j]>0)
 do begin dec(p);b[p,j]:=1 end;niz:=p;
 while(p<10)and(a[No,p+1,j]>0)do begin inc(p);b[p,j]:=1;inc(nt)end;
 verx:=p;if p>niz then for k:=niz to verx do a[2,k,j]:=Nt;
          {Горизонталь}
 if p=niz then begin
  while(q>1)and(a[No,i,q-1]>0)do begin dec(q);b[i,q]:=1 end;niz:=q;
  while(q<10)and(a[No,i,q+1]>0)do begin inc(q);b[i,q]:=1;inc(nt)end;
  verx:=q;for k:=niz to verx do a[2,i,k]:=Nt;
 end
end;

var napr:char;
begin
 Scan(2,d,c,napr,niz,verx,Nk,0);if Nk>4 then exit;
 for i:=1 to 4 do ko[2,i]:=0;fillchar(b,sizeof(b),0);
 i:=1;While i<=10 do begin
 j:=1;
  While j<=10 do begin
   While(a[2,i,j]=0)and(j<10)do
    inc(j);
    if(a[2,i,j]>0)and(b[i,j]=0)then begin
     Scan1(i,j,Nt);
     inc(Ko[2,Nt]);
    end;
   inc(j);
  end;
 inc(i);
 end;
end;

   // Ручная установка
Procedure Korablimy(x,y:integer);
var Nk,i,j,Nm:byte;
begin
 if(x<xn2)or(x>xk2)or(y<yn2)or(y>yk2)then exit;
 Rij(2,x,y,i,j);
 if a[2,i-1,j-1]+a[2,i-1,j+1]+a[2,i+1,j-1]+a[2,i+1,j+1]>0 then exit;
 Nm:=5;if a[2,i,j]=0 then begin
 a[2,i,j]:=1;ScanPole(i,j,Nk);if Nk>4 then begin a[2,i,j]:=0;exit end;
 if(ko[2,4]>=1)then Nm:=Nm-ko[2,4];
 if(ko[2,4]=2)and(ko[2,3]=1)then dec(Nm);
 if(ko[2,3]+ko[2,4]=4)then dec(Nm);
 if(ko[2,4]=1)and(ko[2,3]=3)then dec(Nm);
 if(Nk>0)and(Nk<=Nm)then
   begin a[2,i,j]:=Nk;Prkop(2,0)end else a[2,i,j]:=0
 end else begin a[2,i,j]:=0;ScanPole(i,j,Nk);Putkor(2,i,j,0);Prkop(2,0)
 end;
end;

Procedure PutKrect(No,i,j,N:byte);
const dk=6;
var x,y:integer;
Procedure Put(x,y:integer);
begin
 with Form1.Image1.Canvas do begin
  if(N=0)then begin pen.Color:=clwhite;{pen.Width:=1} end
  else begin pen.Color:=cllime;{pen.Width:=3} end;
  Moveto(x+dk,y+dk);Lineto(x+dx-dk+1,y+dy-dk+1);
  Moveto(x+dk,y+dy-dk);Lineto(x+dx-dk+1,y+dk-1);
  if(N>0)then begin Brush.Color:=clRed;pen.Color:=clRed;
  Ellipse(x+8,y+8,x+16,y+16)end
 end;
end;
begin
 Rxy(No,i,j,x,y);
 Put(x,y);
 if(i1[No]*j1[No]>0)then begin
  N:=0;Rxy(No,i1[No],j1[No],x,y);
  a[No,i1[No],j1[No]]:=10;
  Putkor(No,i1[No],j1[No],10);
  Put(x,y);
 end;i1[No]:=i;j1[No]:=j;
end;

FUNCTION fnmax(a,b:byte):byte;
begin
 if a>b then fnmax:=a else fnmax:=b
end;

Procedure Fix(No,Id,Jd,Iu,Ju,i,j:byte;nap:char);
var S,S1:string;l,k:byte;
 begin
  dec(ko[No,Nkyb[No]]);V[No]:=0;Dec(Nkop[No]);
  if Nkop[No]>1 then S1:=So else S1:='Остался ';
  if Nkop[No]>0 then S:=S1+inttostr(Nkop[No])+Sk+Skm[Nkop[No]]
  else S:='Не осталось кораблей';
  if No=1 then Form1.Label6.Caption:=S else Form1.Label7.Caption:=S;
   //необходимо поставить кресты на торцах корабля
   // Если корабль многопалубный
  if Nkyb[No]>1 then begin
       if(Id*Jd>0)then begin PutKrect(No,Id,Jd,0);a[No,Id,Jd]:=10 end;
       if(Iu<11)and(Ju<11)then begin PutKrect(No,Iu,Ju,0);a[No,Iu,Ju]:=10 end;
   if nap='v' then
   for k:=Id+1 to Iu-1 do begin
   w[No,k,j]:=0;if No=1 then Putkor(No,k,j,10)
   end
   else
   for l:=Jd+1 to Ju-1 do begin
   w[No,i,l]:=0;if No=1 then Putkor(No,i,l,10)
   end
    //   Если корабль однопалубный
  end else begin
      if Status=1 then begin
       if(i>1 )then PutKrect(No,i-1,j,0);
       if(j>1 )then PutKrect(No,i,j-1,0);
       if(i<10)then PutKrect(No,i+1,j,0);
       if(j<10)then PutKrect(No,i,j+1,0);
      end;
//      for l:=i-1 to i+1 do for k:=j-1 to j+1 do if (l<>i)and(k<>j)then a[No,l,k]:=10;
      w[No,i,j]:=0;if No=1 then Putkor(No,i,j,10)
  end;
 end;

Procedure Position(No,i,j:byte);
var fl,fl1,h,Id,Iu,Jd,Ju,niz,verx,ngm:byte;napr:Char;
begin
 if(a[No,i,j]=10)then begin
  i:=i0[No];j:=j0[No];
 end;
 Scan(No,i,j,napr,niz,verx,Nkyb[No],10);
   // Определение типа корабля методом исключения
 Ngm:=fnmax(ng[3]-ng[1],ng[4]-ng[2])+1;
 fl:=0;if Nkyb[No]>1 then begin
  if napr='v'
  then begin Id:=niz-1;Jd:=j;Iu:=verx+1;Ju:=j end
  else begin Id:=i;Jd:=niz-1;Iu:=i;Ju:=verx+1 end
 end;
 if(Form1.Radiogroup1.ItemIndex=1)then begin
 if(Nkyb[No]=V[No])then
 fl:=1 end else begin
 if(Nkyb[No]=4)
 or((Nkyb[No]=3)and(ko[No,4]=0))
 or((Nkyb[No]=2)and( (ko[No,3]+ko[No,4]=0)or( (Ngm=3)and(ko[No,3]=0) ) ))
 or((Nkyb[No]=1)and( (ko[No,2]+ko[No,3]+ko[No,4]=0)
                   or((ko[No,2]+ko[No,3]=0)and(Ngm=3))
                   or((Ngm=2)and(ko[No,2]=0)) ))
 then
 fl:=1
 else
    // Определение типа корабля по наличию крестов(выстрелов) на торцах корабля
 begin
  if Nkyb[No]>1 then begin
   if(a[No,Id,Jd]=10)then Kd:=1 else Kd:=0;
   if(a[No,Iu,Ju]=10)then Ku:=1 else Ku:=0;
   if(Kd+Ku=2)then fl:=1
  end else begin
   fl1:=0;for h:=0 to 1 do
   if a[No,i-1+2*h,j]=10 then
   inc(fl1);
   for h:=0 to 1 do
   if a[No,i,j-1+2*h]=10 then
   inc(fl1);
   if fl1=4 then fl:=1
  end;
 end;
 end;
   // Если определено, что корабль подбит полностью, {fl=1} то это фиксируется
 if fl=1 then
 Fix(No,Id,Jd,Iu,Ju,i,j,napr);
 if(No=2)and(Nkyb[No]>1)then begin
  if napr='v'then begin inc(Id);dec(Iu)end
             else begin inc(Jd);dec(Ju);end;
  Id2:=Id;Iu2:=Iu;Jd2:=Jd;Ju2:=Ju;napr2:=napr
 end
end;

Procedure Vskmy(No,i,j:byte;var N:byte);
var f,h:shortint;Fl,p,q:byte;
begin
 if a[No,i,j]>9 then exit;
 if No=1 then V[No]:=a[No,i,j];
 inc(a[No,i,j],10);//Play('Pushka1.wav');//Form1.Delay(165);
 if a[No,i,j]=10 then begin
  Play('VodaVzr.wav');
  xod:=1-xod;if xod=myxod then Screen.Cursor:=crCross else
  Screen.Cursor:=crnone;
  Putkrect(No,i,j,1);
 end else begin
  w[No,i,j]:=1;if No=1 then Putkor(No,i,j,10);dec(N);Play('Vzr.wav');
  For p:=0 to 1 do for q:=0 to 1 do begin
   f:=i+p*2-1;h:=j+q*2-1;
   if(f*h>0)and(f<11)and(h<11)and(a[No,f,h]=0)then begin
    inc(a[No,f,h],10);PutKrect(No,f,h,0)
   end
  end
 end;
 Fl:=0;
 if(a[No,i,j]=10)then for p:=i-1 to i+1 do for q:=j-1 to j+1 do
 if((p<>i)or(q<>j))and(w[No,p,q]=1)then begin Fl:=1;i0[No]:=p;j0[No]:=q end;
 if(Fl=1)or(a[No,i,j]>10)then begin
  Position(No,i,j);
  if(No=1)and(Form1.RadioGroup1.ItemIndex=0)then for p:=1 to 10 do for q:=1 to 10 do
  if(p<>i)and(q<>j)and(w[No,p,q]=1)then Position(No,p,q);
 end;
 if(Nmy*Ncom=0)then begin
 if Ncom=0 then No:=2 else No:=1;
 Status:=2;if Form1.Radiogroup1.ItemIndex=0 then
 for p:=1 to 10 do for q:=1 to 10 do
 if(a[No,p,q]=11)and(w[No,p,q]=1)then Fix(No,p,q,p,q,p,q,'g');
 Coob(Ncom,Nmy) end
end;

Procedure Debut(var i,j:byte);
var k:shortint;
napr:char;niz,verx,Ngm:byte;
begin
 repeat
  Opr(i,j);
  if(a[2,i,j]<10)then begin
   k:=(i+j-m)mod 4;
   Scan(2,i,j,napr,niz,verx,Nkyb[2],10);
   Ngm:=fnmax(ng[4]-ng[2],ng[3]-ng[1])+1;
  end;
 until(a[2,i,j]<10)and not
 (((Ngm<4)and(ko[2,1]+ko[2,2]=0)and(ko[2,4]=1))or((Ngm<3)and(ko[2,1]+ko[2,2]=0)and(ko[2,3]>0)))
 and((ko[2,2]+ko[2,3]+ko[2,4]=0)or(k+ko[2,4]=0)or(k=2))
end;

Procedure Mozgi;
var k,k1,k2,fl,i,j:byte;
setK:set of byte;
begin
 if V[2]=0 then begin
  Kd:=0;Ku:=0;napr2:=#0;
   Debut(i,j);
   V[2]:=a[2,i,j];if V[2]>0 then begin
   i0[2]:=i;j0[2]:=j end;
   Vskmy(2,i,j,nmy);
 if V[2]=0 then exit;
 end;
 repeat
  if(xod=myxod)or(Nmy=0)then exit;
  if Nkyb[2]=1 then begin
  fl:=0;setK:=[];
  repeat
   inc(fl);
   repeat k:=Random(4)until not(k in setK);
   setK:=setK+[k];
   if odd(k)then k1:=1 else k1:=0;
   i:=i0[2]+(k-2)*k1;j:=j0[2]+(k-1)*(1-k1)
  until((a[2,i,j]<10)and(i in[1..10])and(j in[1..10]))or(fl=4)
  end
  else begin
   if napr2='v'then k1:=1 else k1:=0;
   k2:=1; // Движение к концу
   if Ku=1 then inc(k2);  // Движение к началу
   if Kd+Ku=0 then k2:=1+Random(2);
   if k2=1 then begin
    i:=Id2+Nkyb[2]*k1;j:=Jd2+Nkyb[2]*(1-k1);
    if(a[2,i,j]>9)and(a[2,Id2-k1,Jd2-1+k1]<10)then begin i:=Id2-k1;j:=Jd2-1+k1 end
   end else begin
    i:=Iu2-Nkyb[2]*k1;j:=Ju2-Nkyb[2]*(1-k1);
    if(a[2,i,j]>9)and(a[2,Iu2+k1,Ju2+1-k1]<10)then begin i:=Iu2+k1;j:=Ju2+1-k1 end
   end
  end;
  if(a[2,i,j]<10)then begin
   Vskmy(2,i,j,Nmy);
  end else V[2]:=0
 until V[2]=0
end;

           // Автоматическая установка кораблей
Procedure AutoVariantKop(N:byte);
var i:byte;
begin
 if(Status>0)then Exit;
  FillChar(b,Sizeof(b),0);
  FillChar(a[N],Sizeof(a[N]),0);
  Mope(N-1);
  Randomize;
  KorabliKi(N);
  for i:=1 to 4 do ko[N,i]:=5-i;
  if N=2 then
  PrKop(N,0);
  Flkor0:=1
end;
var FMozgi:byte;
Flcoob:byte=0;

Procedure Igra;
var i:byte;
begin
 FlCoob:=0;
 for i:=1 to 4 do if(ko[2,i]<>5-i)then begin
 Play('ninini.wav');
 ShowMessage('Количество типов кораблей не соответствуют заданному.');
 exit end;
 AutoVariantKop(1);
 Mope(0);
 Fillchar(i1,4,0);
 Randomize;
 myxod:=Random(2);
 m:=random(4);xod:=0;
 Ncom:=20;Nmy:=20;Flkor:=1;Status:=1;Form1.Timer2.Interval:=4015;
 Prkop(2,0);
// Prkop(1,0,1); // для отладки
 for i:=1 to 2 do Granica(i);
 with Form1 do begin
 Label2.Visible:=False;
 Label3.Visible:=False;
 Timer1.Enabled:=True;
 Label5.Visible:=False;
 Label6.Visible:=True;
 Label7.Visible:=True;
 Label6.Caption:=So+inttostr(10)+Sk+Skm[10];
 Label7.Caption:=So+inttostr(10)+Sk+Skm[10];
 RadioGroup1.Enabled:=False;
 end;
 fillchar(w,sizeof(w),0);
end;

var Xo,Yo:integer;
Procedure Vsk1(x,y:integer);
var i,j:byte;
begin
 if(x>xn1)and(x<xk1)and(y>yn1)and(y<yk1)then begin
  Rij(1,x,y,i,j);
  Vskmy(1,i,j,Ncom);Screen.Cursor:=crCross;
  //if Ncom=0 then Coob(Ncom,Nmy);
 end
end;

procedure TForm1.FormCreate(Sender: TObject);
var
S:string;
i:byte;
begin
for i:=1 to 4 do Nko[5-i]:=i;xn1:=4;yn1:=4;dxm:=250;
xk1:=xn1+10*dx;xn2:=xn1+dxm;xk2:=xn2+10*dx;yn2:=yn1;yk1:=yn1+10*dy;yk2:=yk1;
IniGame;Timer2.Interval:=4015;
S:='Расставьте корабли мышкой:'#13'1 - 4-х палубный,'#13'2 - 3-х палубных,'#13'3 - 2-х палубных'#13'и 4 - однопалубных'#13;
S:=S+'или жмите на'#13'"автоматическая установка кораблей"';
Label5.Caption:=S;
//Screen.Cursors[1]:=LoadCursor(HInstance,'KRES');
//Screen.Cursors[1]:=LoadCursor(HInstance,'KREST');
end;

procedure TForm1.Label2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 if Status=0 then Label2.Font.Color:=clFuchsia
end;

procedure TForm1.Label3Click(Sender: TObject);
begin
 Igra
end;

procedure TForm1.Label3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if Status=0 then Label3.Font.Color:=clFuchsia
end;

procedure TForm1.Label3MouseLeave(Sender: TObject);
begin
if Status=0 then Label3.Font.Color:=clblack
end;

procedure TForm1.Label2MouseLeave(Sender: TObject);
begin
if Status=0 then Label2.Font.Color:=clBlack
end;

var Flagim,FlVsk1:byte;
procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if Status=0 then Korablimy(x,y)else if xod=myxod then Vsk1(x,y);
end;

procedure TForm1.Label2Click(Sender: TObject);
begin
AutoVariantKop(2);
end;

procedure TForm1.Label4Click(Sender: TObject);
begin
IniGame
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
 PutOgon(Nog);
end;

var Np:byte;
procedure TForm1.Timer2Timer(Sender: TObject);
begin
if(Status=0)or(Form1.MediaPlayer1.Mode<>mpPlaying)then
Play('More.wav');
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
if(xod=1-myxod)and(Status=1)then begin
Screen.Cursor:=crnone;
Mozgi;
end
end;

procedure TForm1.Delay(msecs : Longint);
var FirstTick,Nexttick: longint;
begin
FirstTick:=GetTickCount;
repeat
//Application.ProcessMessages; //для того чтобы не " завесить"  Windows
Nexttick:=GetTickCount;
until(Nexttick-FirstTick)>=msecs;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 if(Status=1)and(x>xn1)and(X<xk1)and(y>yn1)and(y<yk1)then Screen.Cursor:=crCross else
 Screen.Cursor:=0;
end;

end.


