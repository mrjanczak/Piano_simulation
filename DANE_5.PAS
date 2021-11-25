Unit Dane_5;

Interface
uses Dos,Crt,Graph,Objects,Drivers;
const
met_uk_row=3;
met_cal=2;

l_cial  = 6;
l_pkt   = 30;
l_kon   = 17;
l_LM    = 113;
l_kon_c = 5;
l_stop  = 2;
n_mac   = 3;
l_mat   = 5;
l_p_mat = 14;
l_pop   = 22;
l_help  = 15;
l_etyk  = 5;
l_out   = 4;
l_styk  = 11;

File_pop= 'pop5.dat';
File_geo= 'geo5.dat';
File_map= 'map5.dat';
File_kon= 'kon5.dat';
File_mat= 'mat5.dat';
File_input='input_5.dat';
File_output='output5.dat';

pi = 3.1415926535897932385;
pip= pi/2;
r_s= 180/pi;
s_r= pi/180;
g  = -9.81;
f_graf = 3;   {czestosc odswiezania wyk. wzg. dt}
dt    = 0.001;{czas pr¢bkowania poˆo¾enia klawisza i zapisu danych}
t_max=1;      {czas zapisu}

eps_k=1e-5;   {dop. bˆ¥d w obliczaniu k¥ta}
sk_czasu = 300;
sk_penet = 1e6;
sk_klawisza=1.3;

type
  vec=array[1..l_cial] of Double;
  matrix=array[1..l_cial,1..l_cial] of Double;
  vector=array[1..2*l_cial] of Double;
  pkt=record
    x,y : Double; end;
  pred=record
    w : pkt; m,a : Double; end;
  geom=record
    k,LM,pc,pp,r_ : integer;
    da,dr,dx,dy,ab,rb,a,r : Double;
    end;
  kontakty=record
    c1,p11,p12 : integer;  z : Double;
    c2,p2,p_r  : integer; rk : Double;
    tx:string[20];
    tar        : integer;mat : integer;
    ak,dk,a1,r1,a2,r2 : Double;  end;
  _kontakty=record
    nK,p,z : integer; w : pkt; a,r : Double; end;
  _stopnie=record
    c,p : integer; w : pkt; a,r : Double; end;
  hierarchia=record
    Mas,I : Double;
    tx : string[8];
    zak,Q : Double;
    S : array[1..l_stop] of _stopnie;
    K : array[1..l_kon_c] of _kontakty;
    KO : pkt;
    M : array[1..l_cial] of integer;
    MO : Double;
    l_p,l_k,l_st : integer;
  end;
  _mat=record
    x,yob,aob,yod,aod : double; end;
  material=record
    naz: string[8]; v0_N,m_s,m_d,v0_T,dF: Double;
    T : array[0..l_p_mat] of _mat; end;
  __kontakty=record
    N,y : Double;
    b,T,bT: array[1..2] of Double;
    v,w,wT : array[1..2] of pkt; end;
  Ekran=record
    x,y : integer; s : Double; end;
  sprez=record
    pc : integer; m0,m,dm0,dm : Double; end;
  time=record
    h,m,s,ms : word; end;
  time_=record
    h,m,s,ms : Longint ; end;
  okna = record
    x1,y1,x2,y2 : integer; end;
  wykres = record
    y0,xx,yy : integer;
    x,y,s : Double; t,j : string[25]; end;
  etykiety = record
    x,s : Double; t : string[5]; end;
  poprawki = record
    tyt : string[25]; ob,po : string[2];
    c,p : integer; j,pop : Double; end;
  out_data = record
    tx : string[8]; _0,dat : double; end;
  styki = record
    kon,str : integer; end;
const

Win : array[0..8] of okna=
 ((x1:0;   y1:0;   x2:640; y2:350),
  (x1:4;   y1:13;  x2:318; y2:93),
  (x1:4;   y1:97;  x2:318; y2:177),
  (x1:322; y1:13;  x2:636; y2:93),
  (x1:322; y1:97;  x2:636; y2:177),
  (x1:4;   y1:181; x2:636; y2:346),
  (x1:4;   y1:13;  x2:318; y2:177),
  (x1:322; y1:13;  x2:636; y2:177),
  (x1:4;   y1:13;  x2:636; y2:177));

ST0   : array[0..l_cial] of hierarchia=
  ((),
   (Mas:0.011;  I:3.4e-5; tx:'figura'; zak:15),
   (Mas:5.8e-3; I:1.0e-5;  tx:'d«w.rep';zak:-15),
   (Mas:3.2e-3; I:2.5e-6;  tx:'bijnik'; zak:-15),
   (Mas:9.2e-3; I:8.9e-5;  tx:'mˆotek'; zak:-50),
   (Mas:3.1e-2; I:3.5e-4;  tx:'tˆumik'; zak:20),
   (Mas:0.112;  I:5.4e-3;  tx:'klawisz';zak:-4 ));

SP0   : array[0..l_cial] of sprez= {pc:-1 - wyˆ¥czeie spr©¾yny}
  ((),
   (pc:-1),
   (pc:1; m0:0.05; m:-0.01),
   (pc:1; m0:0.005; m:-0.005),
   (pc:-1),
   (pc:-1),
   (pc:-1));

p00   : pkt=(x:0; y:0);

STY : array[1..l_styk] of styki=
 ((kon:1;  str:1),
  (kon:8;  str:2),
  (kon:10; str:2),
  (kon:2;  str:2),
  (kon:3;  str:2),
  (kon:5;  str:2),
  (kon:6;  str:2),
  (kon:11; str:2),
  (kon:12; str:2),
  (kon:13; str:2),
  (kon:15; str:2));

Help : array[1..l_help] of string=
(('s - Start'),
 ('q - Koniec'),
 ('p - Pauza'),
 ('F1 - Help'),
 ('x,t - Zmiana wykres¢w'),
 ('o - Od˜wie¾anie wykres¢w'),
 ('e - Etykiety przy ciaˆach lub kontaktach'),
 ('PgUp/PgDn - Zmiana pokazywanego kontaktu '),
 ('Home/End  - Zmiana pokazywanego ciaˆa '),
 ('+/-;4,6,8,2 - Zoom; Przewijanie'),
 ('d - Poprawki dr, da, dx, dy'),
 ('    F2 - Zapis poprawek  ('+File_pop+')'),
 ('    F3 - Odczyt poprawek ('+File_pop+')'),
 ('    ^ , v - Wyb¢r parametru'),
 ('    < , > - Korekta parametru'));

var  {tab. daych}
P                         : array[0..l_cial,1..l_pkt]     of geom;
K                         : array[1..l_kon]               of kontakty;
SP                        : array[0..l_cial]              of sprez;
POP                       : array[1..l_pop]               of poprawki;
MAT                       : array[1..l_mat]               of material;
     {zmienne}
PO,AC                     : array[0..l_cial,1..l_pkt]     of pkt;
VE                        : array[0..l_cial,1..l_pkt]     of pred;
et_k,et_c,et_             : array[1..l_etyk]              of etykiety;
KO                        : array[1..l_kon]               of __kontakty;
K0                        : array[1..l_kon]               of double;
EP,MSp                    : vec;
AL,OM,AL0,OM0             : array[0..l_cial]              of Double;
ST                        : array[0..l_cial]              of hierarchia;
OUT                       : array[0..l_out]               of out_data;
t                         : array[1..2] of time;
t_                        : array[1..2] of time_;
Wyk                       : array[1..7] of Wykres;
VPort                     : ViewPortType;
Ekr                       : Ekran;
GraphDriver,GraphMode     : integer;
Vpg                       : integer;
n_pop,i_kon,n_kon,n_cial  : integer;
t0,t1,t_r,t_wyk,t_in,Reak : Double;
fl,czysc_,pauza,start     : Boolean;
et1,et2,et3,et4,et5       : double;
s1,s2,s3                  : string;
klaw,f1,ff1,f2,ff2        : char;
Event                     : TEvent;
Mouse                     : TPoint;
Fpop                      : file of poprawki;
Fmap                      : file of pkt;
Fgeo                      : file of geom;
Fkon                      : file of kontakty;
Fmat                      : file of material;
F_in,Fout                 : text;

function sign(x : Double) : integer;
function nor_w(w : vec) : Double;
function nor_k(kat : Double) : Double;
function dl_wek(P1,P2 : pkt) : Double;
function k_wek(P1,P2 : pkt) : Double;
function il_wek(P1,P2 : pkt) : Double;
function il_sk(W1,W2 : pkt) : Double;
procedure popraw;

Implementation

function sign(x : Double) : integer;
begin
  if (x<0) then sign:=-1
  else sign:=1;
end;

function nor_w(w : vec) : Double;
var i : integer;
m : Double;
begin
  m:=abs(w[1]);
  for i:=2 to l_cial do
    if (abs(w[i])>m) then
      m:=abs(w[i]);
  nor_w:=m;
end;

function nor_k(kat : Double) : Double;
var st_ : integer;
begin
  repeat
    st_:=0;
    if (kat>pi) then
      begin
        st_:=1;
        kat:=kat-2*pi;
      end;
    if (kat<=-pi) then
      begin
        st_:=1;
        kat:=kat+2*pi;
      end;
  until(st_=0);
  nor_k:=kat;
end;

function dl_wek(P1,P2 : pkt) : Double;
begin
  dl_wek:=sqrt(sqr(P2.x-P1.x)+sqr(P2.y-P1.y));
end;

function k_wek(P1,P2 : pkt) : Double;
var kat,dx,dy : Double;
begin
  dx:=P2.x-P1.x;
  dy:=P2.y-P1.y;
  if(abs(dx)>eps_k) then
    kat:=arctan(dy/abs(dx))
  else kat:=sign(dy)*pip;
  if(dx<0) then
    kat:=sign(kat)*pi-kat;
  kat:=nor_k(kat);
  k_wek:=kat;
end;

function il_sk(W1,W2 : pkt) : Double;
begin
  il_sk:= W1.x*W2.x + W1.y*W2.y;
end;

function il_wek(P1,P2 : pkt) : Double;
begin
  il_wek:=P1.x*P2.y-P1.y*P2.x;
end;

procedure popraw;
var i :integer;
begin
    for i:=1 to l_pop do
      begin
          if(POP[i].ob='P ') then
            begin
              if(POP[i].po='a ') then
                P[POP[i].c,POP[i].p].da:=POP[i].pop;
              if(POP[i].po='r ') then
                P[POP[i].c,POP[i].p].dr:=POP[i].pop;
              if(POP[i].po='x ') then
                P[POP[i].c,POP[i].p].dx:=POP[i].pop;
              if(POP[i].po='y ') then
                P[POP[i].c,POP[i].p].dy:=POP[i].pop;

              if((POP[i].c=3)and(POP[i].p=4)and(POP[i].po='r ')) then
                P[3,6].dr:=P[3,4].dr;        {dˆ. bijnika}

            end;
          if(POP[i].ob='SP') then
            begin
              if(POP[i].po='m0') then
                SP[POP[i].c].dm0:=POP[i].pop;
              if(POP[i].po='m ') then
                SP[POP[i].c].dm:=POP[i].pop;
            end;
      end;
end;

end.