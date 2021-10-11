uses Crt,Dos,Graph,bgidrega;
{$I initgraf.pas}
type mass=array[0..11,0..11]of byte;
const dx=24;dy=16;lx=640;ly=350;
var i,j,Flag,m,k,Flnach,Flkor,Flkor0,Ncom,Nmy,butt,butt1,xod,myxod,V,i0,j0,
Kd,Ku,Id2,Iu2,Jd2,Ju2,Nob,Sx:byte;Nkyb:array[1..2]of byte;
x,y,xn1,yn1,xk1,yk1,xn2,yn2,xk2,yk2,xnn,xnk,xkn,xkk,ynn,ynk,ykn,ykk:integer;
tz:longint;tz1,zad:word;Pk:array[1..3]of Pointer;Reg:Registers;
Mvisible:boolean;napr2:Char;Nko:array[0..4]of byte;
Ko:array[1..2,0..4]of byte;b:mass;a:array[1..2]of mass;

FUNCTION Timer:longint;begin timer:=MemL[0:$046C]*55 end;
Function Initmouse:boolean;begin with Reg do begin
ax:=$0;Intr($33,Reg);ax:=$1D;bl:=$0;bh:=$0;Intr($33,Reg)end end;
Procedure Mouse(var b:byte;var x,y:integer);begin with Reg do begin
ax:=$3;Intr($33,Reg);b:=bx;X:=cx;Y:=dx;ax:=$4;Intr($33,Reg)end end;
Procedure ShowMouse;begin if not MVisible then with Reg do begin
ax:=1;Intr($33,Reg);MVisible:=True end end;
Procedure HideMouse;begin if MVisible then with Reg do begin
ax:=2;Intr($33,Reg);MVisible:=False end end;

Procedure Kor;var c:byte;
begin for i:=1 to 3 do begin Getmem(Pk[i],ImageSize(25,25,23+dx,23+dy));
case i of 1:c:=15;2:c:=14;3:c:=1 end;SetFillStyle(1,c);Bar(25,25,23+dx,23+dy);
if i=2 then begin SetlineStyle(0,0,3);SetColor(4);line(25,25,23+dx,23+dy);
line(25,23+dy,23+dx,25)end;if i=3 then outtextxy(33,29,'*');
Getimage(25,25,23+dx,23+dy,Pk[i]^);Putimage(25,25,Pk[i]^,1)end end;

Procedure Rxyn(n:byte;var xn,yn:integer);begin
if n=1 then begin xn:=xn1;yn:=yn1 end else begin xn:=xn2;yn:=yn2 end end;
Procedure Rij(n,x,y:integer;var i,j:byte);var xn,yn:integer;begin
Rxyn(n,xn,yn);i:=(y-yn) div dy+1;j:=(x-xn)div dx+1 end;
Procedure Rxy(n,i,j:byte;var x,y:integer);var xn,yn:integer;begin
Rxyn(n,xn,yn);x:=(j-1)*dx+xn+1;y:=(i-1)*dy+yn+1 end;

PROCEDURE Variant;begin if butt<>1 then exit;
if(x>=xnn)and(x<=xnk)and(y>=ynn)and(y<=ynk)then Flag:=1;
if(x>=xkn)and(x<=xkk)and(y>=ykn)and(y<=ykk)then Flag:=2 end;

Procedure Mope;begin HideMouse;SetFillStyle(1,1);Bar(xn1,yn1,xk1,yk1);
Bar(xn2,yn2,xk2,yk2);Setcolor(15);SetlineStyle(0,0,1);For i:=0 to 10 do begin
line(xn1,yn1+dy*i,xk1,yn1+dy*i);line(xn2,yn2+dy*i,xk2,yn2+dy*i)end;
For j:=0 to 10 do begin line(xn1+dx*j,yn1,xn1+dx*j,yk1);
line(xn2+dx*j,yn2,xn2+dx*j,yk2)end;ShowMouse end;
Procedure Zastabka;begin SetFillStyle(1,15);Bar(xnn,ynn,xnk,ynk);
Bar(xkn,ykn,xkk,ykk);Setcolor(0);outtextxy(xn1+4*dx,16,'€—€‹Ž ');
outtextxy(xn2+4*dx,16,' ŠŽ…– ')end;
Procedure Coob(Ncom,Nmy:byte);begin Setcolor(14);HideMouse;
if Ncom=0 then outtextxy(100,316,'•  - • ')else begin for i:=1 to 10 do
for j:=1 to 10 do if a[1,i,j]in[1..4]then begin Rxy(1,i,j,x,y);
Putimage(x,y,Pk[1]^,1)end;outtextxy(100,316,'—¥àâ ¯®¡¥à¨')end;ShowMouse end;
Procedure Opr(var p,q:byte);var k:byte;begin k:=1+Random(100);
p:=(k-1)div 10+1;q:=(k-1)mod 10+1 end;
Procedure KorabliK(No:byte);var i,j,k,h,l,p,q,s,Fl,o,r:byte;
Procedure Pole(k,p,q:byte;var l,h:byte);var n,o,r,c,d:byte;
Procedure Pole1(var p,q:byte;e:shortint);var t,u:byte;begin
if k=0 then begin t:=q;u:=p+e end else begin t:=p+e;u:=q end;
while(n<j)and(p>-e)and(p<11-e)and(b[t,u]=0)do begin
p:=p+e;if k=0 then u:=u+e else t:=t+e;inc(n)end end;
begin n:=1;if k=1 then begin c:=p;d:=q end else begin c:=q;d:=p end;
h:=c;Pole1(c,d,-1);l:=c;if n<j then begin c:=h;Pole1(c,d,1);h:=c end;
if n=j then For o:=l-1 to h+1 do begin
For r:=d-1 to d+1 do if k=0 then begin b[r,o]:=1{;Print1(no,r,o,3)}end else
begin b[o,r]:=1{;Print1(No,o,r,3)}end;
if o in[l..h]then if k=0 then begin a[No,d,o]:=j{;Print1(No,d,o,2)}end else
begin a[No,o,d]:=j{;Print1(No,o,d,2)}end end end;
{k=1-‚¥àâ¨ª «ì;k=0-ƒ®à¨§®­â «ì}
begin for j:=4 downto 1 do for i:=1 to 5-j do repeat repeat Opr(p,q);
Fl:=0;For o:=p-1 to p+1 do For r:=q-1 to q+1 do if Fl=0 then Fl:=a[No,o,r]
until Fl=0;k:=Random(2);s:=0;repeat inc(s);Pole(k,p,q,l,h);k:=1-k
until(s=2)or(1+h-l=j)until 1+h-l=j end;

Procedure Scan(No:byte;var napr:char;var niz,verx,n:byte;k2:byte);var p,q,m:byte;
begin if(No=2)and(a[2,i,j]=10)and(k2=10)then begin
{for m:=0 to 1 do
if(a[2,i-1+2*m,j]>10)and(abs(i-1+2*m-i0)<abs(i-i0))then i:=i-1+2*m;for m:=0
to 1 do if(a[2,i,j-1+2*m]>10)and(abs(j-1+2*m-j0)<abs(j-j0))then j:=j-1+2*m}
i:=i0;j:=j0 end;
p:=i;q:=j;n:=1;if a[No,i,j]=0 then a[No,i,j]:=10;
           {‚¥àâ¨ª «ì}
while(p>1)and(a[No,p-1,j]>k2)do dec(p);niz:=p;
while(p<10)and(a[No,p+1,j]>k2)do begin inc(p);inc(n)end;napr:='v';verx:=p;
          {ƒ®à¨§®­â «ì}
if p=niz then begin napr:='g';while(q>1)and(a[No,i,q-1]>k2)do dec(q);niz:=q;
while(q<10)and(a[No,i,q+1]>k2)do begin inc(q);inc(n)end;verx:=q end end;

Procedure Granica;var m,i,j:byte;begin FillChar(b,Sizeof(b),0);
for m:=1 to 2 do for i:=0 to 11 do for j:=0 to 11 do if i*j mod 11=0 then
begin a[m,i,j]:=10;{b[i,j]:=1} end end;

Procedure StirMyKop(c:byte);begin SetFillStyle(1,c);Bar(xn2,50,xk2,90)end;

Procedure Korablimy;var m,fl,k1,h,Nk,niz,verx:byte;k,x1,y1:integer;
napr:Char;begin Rij(2,x,y,i,j);
if a[2,i-1,j-1]+a[2,i-1,j+1]+a[2,i+1,j-1]+a[2,i+1,j+1]>0 then exit;
Scan(2,napr,niz,verx,Nk,0);
if((Nk<5)and((ko[2,Nk]<Nko[Nk])or((Nk=3)and(ko[2,4]<Nko[4]))
or((Nk=2)and(ko[2,3]+ko[2,4]<3))or((Nk=1)and(ko[2,2]+ko[2,3]+ko[2,4]<6))))
or(a[2,i,j]<>10)then begin if a[2,i,j]=10 then begin k:=1;a[2,i,j]:=Nk end
else  begin a[2,i,j]:=0;k:=-1 end;if napr='v' then h:=i else h:=j;
 ko[2,0]:=2;ko[2,Nk]:=ko[2,Nk]+k;ko[2,h-niz]:=ko[2,h-niz]-k;
 ko[2,verx-h]:=ko[2,verx-h]-k;fl:=0;for m:=1 to 4 do if ko[2,m]=Nko[m] then
 inc(fl); if fl=4 then begin Flkor0:=1 end;Rxy(2,i,j,x1,y1);HideMouse;
 Putimage(x1,y1,Pk[1]^,1);Showmouse end else a[2,i,j]:=0 end;

Procedure Print(No,i,j,Nk:byte);begin if a[No,i,j]=10 then exit;
a[No,i,j]:=10;Rxy(No,i,j,x,y);Putimage(x,y,Pk[Nk]^,0)end;

Procedure Position(No:byte);var fl,fl1,fl2,fl10,h,Id,Iu,Jd,Ju,niz,verx,f,
g,m:byte;napr:Char;begin f:=i;g:=j;repeat fl10:=0;
if(No=1)and(a[1,f,g]=10)then begin for m:=0 to 1 do
if(a[1,f-1+2*m,g]>10)and(b[f-1+2*m,g]=0)then begin i:=f-1+2*m;b[i,j]:=1;
fl10:=1 end;
if fl10=0 then for m:=0 to 1 do
if(a[1,f,g-1+2*m]>10)and(b[f,g-1+2*m]=0)then begin j:=g-1+2*m;b[i,j]:=1;
fl10:=1 end;if fl10=0 then begin FillChar(b,Sizeof(b),0);exit end end;
Scan(No,napr,niz,verx,Nkyb[No],10);fl2:=0;
if(Nkyb[No]=4)or((Nkyb[No]=3)and(ko[No,4]=0))
or((Nkyb[No]=2)and(ko[No,3]+ko[No,4]=0))
or((Nkyb[No]=1)and(ko[No,2]+ko[No,3]+ko[No,4]=0))then fl2:=1;fl:=fl2;
if Nkyb[No]>1 then if napr='v'
then begin Id:=niz-1;Jd:=j;Iu:=verx+1;Ju:=j end
else begin Id:=i;Jd:=niz-1;Iu:=i;Ju:=verx+1 end;
if Nkyb[No]>1 then begin if(niz=1)or(a[No,Id,Jd]=10)then
Kd:=1 else Kd:=0;
if(verx=10)or(a[No,Iu,Ju]=10)then Ku:=1 else Ku:=0;
if(Kd+Ku=2)then fl:=1 end else begin fl1:=0;
for h:=0 to 1 do if(a[No,i-1+2*h,j]=10)then inc(fl1);
for h:=0 to 1 do if a[No,i,j-1+2*h]=10then inc(fl1);
if fl1=4 then fl:=1 end;
if fl=1 then begin
 dec(ko[No,Nkyb[No]]);if No=2 then
 V:=0;
 if fl2=1 then if Nkyb[No]>1 then begin
  if Id*Jd>0 then Print(No,Id,Jd,3);
  if (Iu<11)and(Ju<11)then Print(No,Iu,Ju,3);
 end else begin
  if(i>1)then Print(No,i-1,j,3);if(j>1)then Print(No,i,j-1,3);
  if(i<10)then Print(No,i+1,j,3);if(j<10)then Print(No,i,j+1,3)end end;
until(No=2)or(fl10=0);
if No=2 then begin
if napr='v'then begin inc(Id);dec(Iu)end
           else begin inc(Jd);dec(Ju)end;
Id2:=Id;Iu2:=Iu;Jd2:=Jd;Ju2:=Ju;napr2:=napr end end;

Procedure Vskmy(No:byte;var N:byte);var p,q,f,h:shortint;x1,y1:integer;
begin if a[No,i,j]>4 then exit;HideMouse;Rxy(No,i,j,x1,y1);inc(a[No,i,j],10);
if a[No,i,j]=10 then begin if xod=myxod then inc(Sx);xod:=1-xod;
Putimage(x1,y1,Pk[3]^,0)end else begin
Putimage(x1,y1,Pk[2]^,0);dec(N);
For p:=0 to 1 do for q:=0 to 1 do begin
f:=i-1+p*2;h:=j-1+q*2;if(f*h>0)and(f<11)and(h<11)and(a[No,f,h]=0)then begin
Rxy(No,f,h,x1,y1);inc(a[No,f,h],10);Putimage(x1,y1,Pk[3]^,0)end end end;
if((No=2)and(V>0))or((No=1)and(Ncom<20))then Position(No);ShowMouse end;
{m:=(i-1)mod 3+1;if odd(m)then m:=0 else m:=1;}
{((i+m+j)mod 4=0)or((not odd(i+m))and(not odd(j)))and(a[2,i,j]<5)}

(* Procedure Debut(var i,j:byte);var l,h:byte;n,p,q:integer;m:array[0..23]of byte;
begin
{repeat Opr(i,j);until(not (odd(i)xor odd(j)))and(a[2,i,j]<5)}
if(Sx<6)or(Sx mod 2=0)then begin repeat Opr(i,j)until a[2,i,j]<5;exit end;
n:=0;p:=0;q:=0;for l:=1 to 10 do for h:=1 to 10 do if a[2,l,h]>9 then begin
inc(n);p:=p+l;q:=q+h end;Nob:=n;
i:=11-p div n;j:=11-q div n;if a[2,i,j]>9 then begin
for p:=0 to 23 do m[p]:=0;n:=0;p:=i;q:=j;while(a[2,p,q]>9)and(n<24)do
begin k:=Random(24);if m[k]=0 then begin m[k]:=1;inc(n)end;
case k of 8..12:p:=i-2;0..2,13,23:p:=i-1;3,7,14,22:p:=i;4..6,15,21:p:=i+1 else
p:=i+2 end;
case k of 8,20..23:q:=j-2;0,6,7,9,19:q:=j-1;1,5,10,18:q:=j;2..4,11,17:q:=j+1 else
q:=j+2 end end;i:=p;j:=q;if a[2,i,j]>9 then repeat Opr(i,j)Until a[2,i,j]<5
end;
end;*)
Procedure Debut(var i,j:byte);var k:shortint;
begin repeat k:=1;Opr(i,j);if(a[2,i,j]<5)then k:=(i+j-m)mod 4 until
((ko[2,2]+ko[2,3]+ko[2,4]=0)or(k+ko[2,4]=0)or(k=2))and(a[2,i,j]<5) end;

Procedure ScanPole(var i,j:byte);var p,q:array[1..4]of byte;n:byte;begin
if ko[2,2]>0 then begin
 FillChar(b,Sizeof(b),0);n:=0;i:=1;j:=1;repeat
  while((b[i,j]=1)or(a[2,i,j]>9))and(i<11)do begin inc(j);if j>10 then begin
  inc(i);j:=1 end end;
  if a[2,i+1,j]<5 then begin inc(n);p[n]:=i;q[n]:=j;b[i,j]:=1;b[i+1,j]:=1 end;
  if(a[2,i,j+1]<5)and(j<10)then begin
  if b[i,j]=0 then begin inc(n);p[n]:=i;q[n]:=j;b[i,j]:=1 end;b[i,j+1]:=1 end;
  if(n<=ko[2,2])or(b[i,j+1]=1)then begin inc(j);if j>10 then begin
  inc(i);j:=1 end
 end
 until(n>ko[2,2])or(i=11);if i=11 then dec(i);i:=p[n];j:=q[n] end
else repeat Opr(i,j)until a[2,i,j]<5 end;
{if V=0 then begin repeat repeat Opr(i,j)until a[2,i,j]<5;i0:=i;j0:=j;Kd:=0;
Ku:=0;napr2:=#0;V:=a[2,i,j];Vskmy(2,nmy)until(V>0)or(Nmy=0)or(xod=myxod)end;}

Procedure Mozgi;var k,k1,k2,p,q:byte;x,y:integer;begin HideMouse;
if V=0 then begin Kd:=0;Ku:=0;napr2:=#0;repeat
{if ko[2,4]+ko[2,3]=0 then ScanPole(i,j)else} Debut(i,j);
V:=a[2,i,j];if V>0 then begin i0:=i;j0:=j end;
if(i>10)or(j>10)then
napr2:=readkey;
Vskmy(2,nmy)until(V>0)or(Nmy=0)or(xod=myxod)
end;
repeat if(xod=myxod)or(Nmy=0)then begin ShowMouse; exit end;if Nkyb[2]=1 then
repeat k:=Random(4);if odd(k)then k1:=1 else k1:=0;
i:=i0+(k-2)*k1;j:=j0+(k-1)*(1-k1)
until(a[2,i,j]<5)and(i*j>0)and(i<11)and(j<11) else begin
if napr2='v'then k1:=1 else k1:=0;k2:=1;if Ku=1 then inc(k2);
if Kd+Ku=0 then k2:=1+Random(2);
if k2=1 then begin i:=Id2+Nkyb[2]*k1;j:=Jd2+Nkyb[2]*(1-k1)end else begin
i:=Iu2-Nkyb[2]*k1;j:=Ju2-Nkyb[2]*(1-k1)end end;
ShowMouse;Vskmy(2,Nmy)
until V=0 end;
var x1,x2,x1k,x2k:integer;

Procedure PrIgra(c:byte);begin SetFillStyle(1,15-c);Setcolor(c);
Bar(xk1,24,xk1+48,44);outtextxy(xk1+8,32,'ˆ£à ')end;

Procedure ZvariantMyKopIgra;var xc:integer;begin
xc:=(xk2+xn2)div 2;x1:=xn2+4;x2:=xc+4;x1k:=xc-4;x2k:=xk2-4;HideMouse;
StirMyKop(12);Setcolor(1);outtextxy(xn2,54,' ‚ à¨ ­â à ááâ ­®¢ª¨ ª®à ¡«¥©');
SetFillStyle(1,15);Bar(x1,64,x1k,84);Bar(x2,64,x2k,84);
outtextxy(x1+1,72,'€¢â®¬ â¨ç¥áª¨©    ãç­®©');PrIgra(0);ShowMouse end;

Procedure PrKop;begin HideMouse;
For i:=1 to 10 do for j:=1 to 10 do if a[2,i,j]>0 then begin
Rxy(2,i,j,x,y);Putimage(x,y,Pk[1]^,1)end;ShowMouse end;

Procedure VariantMyKop;begin if(Flnach=1)or(FlKor=0)then Exit;

if(butt=1)and(x>x1)and(x<x1k)and(y>64)and(y<84)then begin
if butt1<>1 then begin tz:=timer;tz1:=zad end else tz1:=timer-tz;
if tz1<zad then exit;
FillChar(b,Sizeof(b),0);PrKop;FillChar(a[2],Sizeof(a[2]),0);KorabliK(2);
for i:=1 to 4 do ko[2,i]:=5-i;PrKop;Flkor0:=1 end;
if(butt=1)and(x>x2)and(x<x2k)and(y>64)and(y<84)then begin Flkor:=0;
Setcolor(14);outtextxy(360,270,'ãç­ ï à ááâ ­®¢ª  ª®à ¡«¥©')end end;

Procedure Igra;begin if Flkor0=0 then exit;
if(butt=1)and(x>xk1)and(x<xk1+48)and(y>24)and(y<44)then
begin Flnach:=1;Flkor:=1;HideMouse;StirMyKop(0);Granica;PrIgra(1);Setcolor(0);
outtextxy(360,270,'ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ');ShowMouse end end;

Procedure Vsk1;begin if(x>xn1)and(x<xk1)and(y>yn1)and(y<yk1)then begin
Rij(1,x,y,i,j);Vskmy(1,Ncom)end end;

Procedure Korabli2;begin if(x>xn2)and(x<xk2)and(y>yn2)and(y<yk2)then begin
if butt1<>1 then begin tz:=timer;tz1:=zad end else tz1:=timer-tz;
if tz1>=zad then Korablimy end end;

begin Nko[1]:=4;Nko[2]:=3;Nko[3]:=2;Nko[4]:=1;zad:=500;MVisible:=False;Grinit;
Kor;xn1:=(lx-22*dx)div 2;yn1:=(ly-10*dy)div 2;xk1:=xn1+10*dx;xn2:=xk1+2*dx;
xk2:=xn2+10*dx;yn2:=yn1;yk1:=yn1+10*dy;yk2:=yk1;xnn:=xn1+3*dx;xnk:=xn1+7*dx;
xkn:=xn2+3*dx;xkk:=xn2+7*dx;ynn:=4;ynk:=36;ykn:=ynn;ykk:=ynk;zad:=500;
if(not InitMouse)then begin closegraph;exit end;Zastabka;ShowMouse;
repeat Flag:=0;butt:=0;FillChar(b,Sizeof(b)*3,0);for i:=1 to 4 do begin
ko[2,i]:=0;ko[1,i]:=5-i end;V:=0;Nkyb[1]:=0;Nkyb[2]:=0;
repeat Mouse(butt,x,y);Variant until Flag>0;
if Flag=2 then begin closegraph;exit end;HideMouse;
Setcolor(0);outtextxy(100,316,'ÛÛÛÛÛÛÛÛÛÛÛ');Flnach:=0;Flkor0:=0;Flag:=0;Sx:=0;
outtextxy(360,270,'ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ');Randomize;myxod:=Random(2);
m:=random(4);
xod:=0;Ncom:=20;Nmy:=20;Flkor:=1;Mope;KorabliK(1);ShowMouse;
ZvariantMyKopIgra;
{For i:=1 to 10 do for j:=1 to 10 do if a[1,i,j]>0 then begin
Rxy(1,i,j,x,y);Putimage(x,y,Pk[1]^,1)end;}

repeat if MVisible=True then begin MVisible:=False;ShowMouse end;
Mouse(butt,x,y);if butt=1 then begin VariantMyKop;Igra;Variant;
if(Flkor=0)then Korabli2;if(Flnach=1)and(xod=myxod)then Vsk1 end;butt1:=butt;
if(xod=1-myxod)and(Flnach=1) then Mozgi until(Ncom=0)or(Nmy=0)or(Flag>0);
if Flag=0 then Coob(Ncom,Nmy)until Flag=2;Closegraph end.

