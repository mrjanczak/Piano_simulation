{$A+,B-,D+,E-,F-,G+,I+,L+,N+,O-,P-,Q+,R+,S+,T-,V+,X+,Y+}
{$M 16384,0,655360}
Program Geom_5;
Uses Dane_5a;

const

MAT0   : array[1..l_mat] of material=
 ((naz:'filc'; v0_N:-0.01; m_s:0.7; m_d:0.57; v0_T:0.01; dF:0.01;
    T:((x:        0; yob:     0; aob:     0; yod:     0; aod:     0),
       (x:   0.0002; yob:     2; aob: 10000; yod:     0; aod:     0),
       (x:   0.0004; yob:     4; aob: 10000; yod:     0; aod:     0),
       (x:   0.0006; yob:     7; aob: 15000; yod:     1; aod:  5000),
       (x:   0.0008; yob:    11; aob: 20000; yod:     2; aod:  5000),
       (x:   0.001 ; yob:    18; aob: 35000; yod:     3; aod:  5000),
       (x:   0.0012; yob:    27; aob: 45000; yod:     5; aod: 10000),
       (x:   0.0014; yob:    40; aob: 65000; yod:     7; aod: 10000),
       (x:   0.0016; yob:    55; aob: 75000; yod:     9; aod: 10000),
       (x:   0.0018; yob:    85; aob:150000; yod:    11; aod: 10000),

       (x:   0.002 ; yob:   140; aob:275000; yod:    13; aod: 10000),
       (x:   0.0022; yob:   225; aob:425000; yod:    15; aod: 10000),
       (x:   0.0024; yob:   370; aob:725000; yod:    17; aod: 10000),
       (x:   0.0026; yob:   370; aob:     0; yod:    17; aod:     0),
       (x:   0.0028; yob:   370; aob:     0; yod:    17; aod:     0))),

   (naz:'stopka'; v0_N:-0.01; m_s:0.26; m_d:0.21; v0_T:0.01; dF:0.01;
    T:((x: 0        ; yob:           0; aob:           0; yod:           0; aod:           0),
       (x: 0.0001   ; yob:           3; aob:       30000; yod:           0; aod:           0),
       (x: 0.0002   ; yob:           5; aob:       20000; yod:           0; aod:           0),
       (x: 0.0003   ; yob:           8; aob:       30000; yod:           0; aod:           0),
       (x: 0.0004   ; yob:          12; aob:       40000; yod:           1; aod:       10000),
       (x: 0.0005   ; yob:          16; aob:       40000; yod:           2; aod:       10000),
       (x: 0.0006   ; yob:          22; aob:       60000; yod:           3; aod:       10000),
       (x: 0.0007   ; yob:          30; aob:       80000; yod:           4; aod:       10000),
       (x: 0.0008   ; yob:          40; aob:      100000; yod:           5; aod:       10000),
       (x: 0.0009   ; yob:          55; aob:      150000; yod:           6; aod:       10000),

       (x: 0.001    ; yob:          73; aob:      180000; yod:           7; aod:       10000),
       (x: 0.0011   ; yob:          94; aob:      210000; yod:           8; aod:       10000),
       (x: 0.0012   ; yob:         116; aob:      220000; yod:          10; aod:       20000),
       (x: 0.0013   ; yob:         145; aob:      290000; yod:          12; aod:       20000),
       (x: 0.0014   ; yob:         145; aob:           0; yod:          12; aod:           0))),

   (naz:'baryˆka'; v0_N:-0.01; m_s:0.7; m_d:0.57; v0_T:0.01; dF:0.01;
    T:((x: 0        ; yob:      0; aob:        0; yod:     0; aod:        0),
       (x: 0.0001   ; yob:      2; aob:    20000; yod:     0; aod:        0),
       (x: 0.0002   ; yob:      6; aob:    40000; yod:     0; aod:        0),
       (x: 0.0003   ; yob:      9; aob:    30000; yod:     0; aod:        0),
       (x: 0.0004   ; yob:     14; aob:    50000; yod:     1; aod:    10000),
       (x: 0.0005   ; yob:     20; aob:    60000; yod:     2; aod:    10000),
       (x: 0.0006   ; yob:     28; aob:    80000; yod:     6; aod:    40000),
       (x: 0.0007   ; yob:     40; aob:   120000; yod:    11; aod:    50000),
       (x: 0.0008   ; yob:     52; aob:   120000; yod:    17; aod:    60000),
       (x: 0.0009   ; yob:     70; aob:   180000; yod:    23; aod:    60000),

       (x: 0.001    ; yob:     95; aob:   250000; yod:    29; aod:    60000),
       (x: 0.0011   ; yob:    125; aob:   300000; yod:    35; aod:    60000),
       (x: 0.0012   ; yob:    165; aob:   400000; yod:    43; aod:    80000),
       (x: 0.0013   ; yob:    202; aob:   370000; yod:    54; aod:   110000),
       (x: 0.0014   ; yob:    245; aob:        0; yod:    66; aod:        0))),

   (naz:'mˆotek'; v0_N:-0.01; m_s:0.7; m_d:0.57; v0_T:0.01; dF:0.01;
    T:((x: 0        ; yob:      0; aob:        0; yod:     0; aod:        0),
       (x: 0.0001   ; yob: 0.325 ; aob:     3250; yod: 0.325; aod:     3250),
       (x: 0.0002   ; yob: 0.65  ; aob:     3250; yod: 0.65 ; aod:     3250),
       (x: 0.0003   ; yob: 0.975 ; aob:     3250; yod: 0.975; aod:     3250),
       (x: 0.0004   ; yob: 1.3   ; aob:     3250; yod: 1.3  ; aod:     3250),
       (x: 0.0005   ; yob: 1.625 ; aob:     3250; yod: 1.625; aod:     3250),
       (x: 0.0006   ; yob: 1.95  ; aob:     3250; yod: 1.95 ; aod:     3250),
       (x: 0.0007   ; yob: 2.275 ; aob:     3250; yod: 2.275; aod:     3250),
       (x: 0.0008   ; yob: 2.6   ; aob:     3250; yod: 2.6  ; aod:     3250),
       (x: 0.0009   ; yob: 2.925 ; aob:     3250; yod: 2.925; aod:     3250),

       (x: 0.001    ; yob: 3.25  ; aob:     3250; yod: 3.25 ; aod:     3250),
       (x: 0.0011   ; yob: 3.575 ; aob:     3250; yod: 3.575; aod:     3250),
       (x: 0.0012   ; yob: 3.9   ; aob:     3250; yod: 3.9  ; aod:     3250),
       (x: 0.0013   ; yob: 4.225 ; aob:     3250; yod: 4.225; aod:     3250),
       (x: 0.0014   ; yob: 4.55  ; aob:        0; yod: 4.55 ; aod:        0))),

   (naz:'chwytnik'; v0_N:-0.01; m_s:0.7; m_d:0.57; v0_T:0.01; dF:0.01;
    T:((x: 0        ; yob:      0; aob:        0; yod:     0; aod:        0),
       (x: 0.0001   ; yob: 0.325 ; aob:     3250; yod: 0.325; aod:     3250),
       (x: 0.0002   ; yob: 0.65  ; aob:     3250; yod: 0.65 ; aod:     3250),
       (x: 0.0003   ; yob: 0.975 ; aob:     3250; yod: 0.975; aod:     3250),
       (x: 0.0004   ; yob: 1.3   ; aob:     3250; yod: 1.3  ; aod:     3250),
       (x: 0.0005   ; yob: 1.625 ; aob:     3250; yod: 1.625; aod:     3250),
       (x: 0.0006   ; yob: 1.95  ; aob:     3250; yod: 1.95 ; aod:     3250),
       (x: 0.0007   ; yob: 2.275 ; aob:     3250; yod: 2.275; aod:     3250),
       (x: 0.0008   ; yob: 2.6   ; aob:     3250; yod: 2.6  ; aod:     3250),
       (x: 0.0009   ; yob: 2.925 ; aob:     3250; yod: 2.925; aod:     3250),
       (x: 0.001    ; yob: 3.25  ; aob:     3250; yod: 3.25 ; aod:     3250),
       (x: 0.0011   ; yob: 3.575 ; aob:     3250; yod: 3.575; aod:     3250),
       (x: 0.0012   ; yob: 3.9   ; aob:     3250; yod: 3.9  ; aod:     3250),
       (x: 0.0013   ; yob: 4.225 ; aob:     3250; yod: 4.225; aod:     3250),
       (x: 0.0014   ; yob: 4.55  ; aob:     3250; yod: 4.55 ; aod:     3250))));

POP0 : array[1..l_pop] of poprawki=
((tyt:'Plik parametr¢w - ver.4.0'; ob:'  '),
 (tyt:'-------------------------'; ob:'  '),
 (tyt:'pochyl.chwytnika'; ob:'P '; po:'a '; c:6; p:10;j:0.001; pop:0.015),
 (tyt:'dno klaw.       '; ob:'P '; po:'y '; c:0; p:15;j:0.0001;pop:0.0),
 (tyt:'wys.pilota      '; ob:'P '; po:'r '; c:6; p:14;j:0.0001;pop:0.0005),

 (tyt:'ogr.d«w.rep.    '; ob:'P '; po:'y '; c:0; p:10;j:0.0001;pop:-0.0005),
 (tyt:'ogr.gorne d«w.  '; ob:'P '; po:'r '; c:1; p:25;j:0.0001;pop:0.0001),
 (tyt:'spr©¾.d«w.      '; ob:'SP'; po:'m0'; c:2; p:0; j:0.0001;pop:0.0),

 (tyt:'ogr.lewe bij.   '; ob:'P '; po:'r '; c:3; p:12;j:0.0001;pop:0.0012),
 (tyt:'dl. bijnika     '; ob:'P '; po:'r '; c:3; p:4; j:0.0001;pop:0.0005),
 (tyt:'spr©¾.bij.      '; ob:'SP'; po:'m0'; c:3; p:0; j:0.005; pop:0),
 (tyt:'wys.pupki       '; ob:'P '; po:'y '; c:0; p:7; j:0.0001;pop:0.0085),

 (tyt:'odl.chwytnika   '; ob:'P '; po:'r '; c:6; p:6; j:0.0001;pop:0.0015),

 (tyt:'poˆ.ˆy¾eczki    '; ob:'P '; po:'y '; c:5; p:14;j:0.0001;pop:-0.0022),
 (tyt:'dl.pr©tu tlum.  '; ob:'P '; po:'y '; c:5; p:8; j:0.0001;pop:-0.0099),
 (tyt:'--------------------------'; ob:'  '),
 (tyt:'obr¢t figury    '; ob:'P '; po:'a '; c:1; p:2; j:0.001; pop:0),
 (tyt:'obr¢t d«w.rep.  '; ob:'P '; po:'a '; c:2; p:2; j:0.001; pop:0),
 (tyt:'obr¢t bijnika   '; ob:'P '; po:'a '; c:3; p:2; j:0.001; pop:0),
 (tyt:'obr¢t mˆotka    '; ob:'P '; po:'a '; c:4; p:2; j:0.001; pop:0),
 (tyt:'obr¢t tˆumika   '; ob:'P '; po:'a '; c:5; p:2; j:0.001; pop:0),
 (tyt:'obr¢t klawisza  '; ob:'P '; po:'a '; c:6; p:2; j:0.001; pop:-0.001));

var
i,j,n : integer;
p_:pkt;
ch : char;
popp : poprawki;
POP : array[1..l_pop] of poprawki;
begin

Assign(Fmat,File_mat);
rewrite(Fmat);
writeln('Materialy');
for i:=1 to l_mat do
  begin
    write(Fmat,MAT0[i]);
    writeln('Material ',i);
  end;
writeln('Liczba rekord¢w : ',filesize(Fmat));
close(Fmat);

for i:=1 to l_pop do
  POP[i]:=POP0[i];
writeln('Zmienic wartosci poprawek? (t/n)');
readln(ch);
if (ch='n') then
  begin
    Assign(Fpop,File_pop);
    Reset(Fpop);
    for i:=1 to l_pop do
      begin
        read(Fpop,popp);
        POP[i].pop:=popp.pop;
      end;
    close(Fpop);
  end;

Assign(Fpop,File_pop);
Rewrite(Fpop);
Writeln('Parametry');
for i:=1 to l_pop do
  begin
    Write(Fpop,POP[i]);
    writeln('Parametr ',i);
  end;
writeln('Liczba rekord¢w : ',filesize(Fpop));
close(Fpop);
readln;
end.