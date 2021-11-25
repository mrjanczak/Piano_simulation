Unit grafika5;

Interface
Uses Dos,Crt,Graph,Objects,Drivers,Dane_5;

procedure ViewPorty(n : integer);
procedure Schemat(pp : char);
procedure Wykresy(n0,n1 : integer);
procedure Poprawki(n0 : integer);
procedure Help_(n0 : integer);
procedure Ekran(n0,n1 : integer);
procedure Wpisz_dane;
function _01(a : boolean) : integer;
procedure Rysuj(f1,f2 : char);

Implementation

procedure ViewPorty(n : integer);
begin
  setViewPort(Win[n].x1,Win[n].y1,Win[n].x2,Win[n].y2,true);
end;

procedure Schemat(pp : char);
var i,j,x,zw : integer;
alf:double;
l : okna;
begin
      ViewPorty(5);
      ClearViewPort;
      for i:=0 to l_cial do
        begin
          if (ST[i].l_st=1) then       {symbole osi gˆ¢wne}
            begin
              setcolor(5);
              l.x1:=Ekr.x+round(Ekr.s*PO[i,1].x);
              l.y1:=Ekr.y-round(Ekr.s*PO[i,1].y);
              line(l.x1-5,l.y1+10,l.x1+5,l.y1+10);
              line(l.x1,l.y1,l.x1+5,l.y1+10);
              line(l.x1,l.y1,l.x1-5,l.y1+10);
            end;
          if (ST[i].l_st>1) then        {symbole osi II stopnia}
            begin
              setcolor(5);
              l.x1:=Ekr.x+round(Ekr.s*PO[i,1].x);
              l.y1:=Ekr.y-round(Ekr.s*PO[i,1].y);
              line(l.x1-2,l.y1+4,l.x1+2,l.y1+4);
              line(l.x1,l.y1,l.x1+2,l.y1+4);
              line(l.x1,l.y1,l.x1-2,l.y1+4);
            end;
        for j:=1 to ST[i].l_p do
          if (P[i,j].r_=1) then         {kontury}
            begin
              setcolor(3);
              l.x1:=Ekr.x+round(Ekr.s*PO[P[i,j].pc,P[i,j].pp].x);
              l.y1:=Ekr.y-round(Ekr.s*PO[P[i,j].pc,P[i,j].pp].y);
              l.x2:=Ekr.x+round(Ekr.s*PO[i,j].x);
              l.y2:=Ekr.y-round(Ekr.s*PO[i,j].y);
              line(l.x1,l.y1,l.x2,l.y2);
            end;
              SetLineStyle(0,1,1);
        end;
      for i:=1 to l_kon do              {kontakty}
        begin
          setcolor(green);
          l.x1:=Ekr.x+round(Ekr.s*PO[K[i].c2,K[i].p2].x);
          l.y1:=Ekr.y-round(Ekr.s*PO[K[i].c2,K[i].p2].y);
          ellipse(l.x1,l.y1,0,360,round(Ekr.s*K[i].rk),round(Ekr.s*K[i].rk));
          if(KO[i].y>0) then
            begin
              setcolor(red);
              ellipse(l.x1,l.y1,0,360,2,2);
            end;
        end;

    if (pp='c') then                    {etykiety ciaˆ}
      begin
          setcolor(white);
          l.x1:=Ekr.x+round(Ekr.s*PO[n_cial,2].x);
          l.y1:=Ekr.y-round(Ekr.s*PO[n_cial,2].y);
          line(l.x1,l.y1,l.x1+2,l.y1-5);
          line(l.x1,l.y1,l.x1+5,l.y1-2);
          line(l.x1,l.y1,l.x1+10,l.y1-10);
          outtextxy(l.x1+20,l.y1-10,ST[n_cial].tx);
          setcolor(3);
          outtextxy(500,60,ST[n_cial].tx);
          setcolor(white);
        for j:=1 to l_etyk do
          begin
            str(et_c[j].x:6:4,s1);
            outtextxy(500,(j+7)*10,et_c[j].t+s1);
          end;
      end;
    if (pp='k') then                    {etykiety kontakt¢w}
      begin
        setcolor(white);
        l.x1:=Ekr.x+round(Ekr.s*PO[K[n_kon].c2,K[n_kon].p_r].x);
        l.y1:=Ekr.y-round(Ekr.s*PO[K[n_kon].c2,K[n_kon].p_r].y);
        line(l.x1,l.y1,l.x1+2,l.y1-5);
        line(l.x1,l.y1,l.x1+5,l.y1-2);
        line(l.x1,l.y1,l.x1+10,l.y1-10);
        if(KO[n_kon].y>0) then setcolor(red)
        else setcolor(green);
        outtextxy(l.x1+20,l.y1-10,K[n_kon].tx);
        outtextxy(500,70,K[n_kon].tx);
        setcolor(3);
        outtextxy(500,60,ST[n_cial].tx);
        setcolor(white);
        for j:=1 to l_etyk do
          begin
            str(et_k[j].x:6:4,s1);
            outtextxy(500,(j+7)*10,et_k[j].t+s1);
          end;
       end;
    if (pp=' ') then                    {etykiety kontakt¢w++}
      begin
        if(KO[n_kon].y>0) then setcolor(red)
        else setcolor(green);
        outtextxy(500,70,K[n_kon].tx);
        setcolor(3);
        outtextxy(500,60,ST[n_cial].tx);
        setcolor(white);
        for j:=1 to l_etyk do
          begin
            str(et_[j].x:6:4,s1);
            outtextxy(500,(j+7)*10,et_[j].t+s1);
          end;
      end;

        setcolor(white);
          if (pauza) then
            outtextxy(500,10,'PAUZA');
          str(t0:5:3,s1);
          outtextxy(500,20,'czas [s]  '+s1);
          if(t_r>0) then
            str((1-t0/t_r)*100:5:2,s1);
          outtextxy(500,30,'op¢«.[%]  '+s1);
          str(dt*1000:8:5,s1);
          outtextxy(500,40,'dt [ms]    '+s1);

  j:=0;
  for i:=1 to l_kon do
    if(KO[i].y>0) then
      begin
        j:=j+1;
        outtextxy(350,(j*10),K[i].tx);
      end;
end;

procedure Wykresy(n0,n1 : integer);
var x,y : longint;
var i,j : integer;
begin
  for i:=n0 to n1 do
    begin
      GraphDefaults;
      ViewPorty(i);
      setcolor(3);
      x:=round(Wyk[i].x);
      y:=Wyk[i].y0-round(Wyk[i].y*Wyk[i].s);
      for j:=0 to 1 do
        begin
          SetActivePage(j);
          line(Wyk[i].xx,Wyk[i].yy,x,y);
        end;
      Wyk[i].xx:=x;
      Wyk[i].yy:=y;
    end;
end;

procedure Poprawki(n0 : integer);
var i,j,x,y : integer;
begin

      GraphDefaults;
      ViewPorty(n0);
      ClearViewPort;
      case klaw of
      #72 : begin
              n_pop:=n_pop-1;
              if(n_pop<=2) then
                n_pop:=l_pop;
              klaw:=' ';
            end;
      #80 : begin
              n_pop:=n_pop+1;
              if(n_pop>l_pop) then
                n_pop:=3;
              klaw:=' ';
            end;
      #75 : begin
              POP[n_pop].pop:=POP[n_pop].pop-POP[n_pop].j;
              klaw:=' ';
            end;
      #77 : begin
              POP[n_pop].pop:=POP[n_pop].pop+POP[n_pop].j;
              klaw:=' ';
            end;
      #60 : begin
              Assign(Fpop,File_pop);
              Rewrite(Fpop);
              SetActivePage(1);
              SetVisualPage(1);
              for i:=1 to l_pop do
                Write(Fpop,POP[i]);
              if(filesize(Fpop)=l_pop) then
                OutTextXY(20,130,'Plik zapisany pomy˜lnie')
              else
                OutTextXY(20,130,'Plik niezapisany!');
              delay(1000);
              close(Fpop);
              klaw:=' ';
            end;
      #61 : begin
              Assign(Fpop,File_pop);
              Reset(Fpop);
              SetActivePage(1);
              SetVisualPage(1);
              if ((IOResult=0)and(filesize(Fpop)=l_pop)) then
                begin
                  for i:=1 to l_pop do
                    Read(Fpop,POP[i]);
                  OutTextXY(20,130,'Plik zaˆadowany pomy˜lnie')
                end
              else
                OutTextXY(20,130,'Plik niezaˆadowany!');
              delay(1000);
              close(Fpop);
              klaw:=' ';
            end;
      end;

      for i:=0 to 1 do
        begin
          SetActivePage(i);
          for j:=1 to l_pop do
            begin
              if(j=n_pop) then
                setcolor(white)
              else
                setcolor(7);
              str(POP[j].c:2,s1);
              str(POP[j].p:2,s2);
              str(POP[j].pop:6:4,s3);
              if(POP[j].ob='  ') then
                begin s1:=' ';s2:=' ';s3:=' ';end;
              if(j<=12) then begin x:=0; y:=0; end
              else begin x:=300; y:=100; end;
              OutTextXY(20+x,j*10-y,POP[j].tyt+' '+POP[j].ob+' '+POP[j].po+' '+s1+' '+s2+' '+s3);
            end;
          OutTextXY(20,140,'F2 - Zapis; F3 - Odczyt;')
        end;
end;

procedure Help_(n0 : integer);
var i,j : integer;
begin
      GraphDefaults;
      ViewPorty(n0);
      setcolor(white);
      for i:=0 to 1 do
        begin
          SetActivePage(i);
          for j:=1 to l_help do
            OutTextXY(20,j*10,help[j]);
        end;
end;

procedure Ekran(n0,n1 : integer);
var i : integer;
begin
 SetColor(yellow);
 SetFillStyle(1,14);
 Bar(1,1,639,10);
 SetLineStyle(0,1,1);
 Rectangle(1,1,639,349);
 SetColor(blue);
 OutTextXY(10,2,'Symulacja Mechaniki Fortepianu ver.5.0');
 for i:=n0 to n1 do
   begin
     SetColor(yellow);
     SetLineStyle(0,1,1);
     Rectangle(Win[i].x1-1,Win[i].y1-1,Win[i].x2+1,Win[i].y2+1);
     SetLineStyle(3,1,1);
     if(i<8) then
       begin
         SetColor(7);
         line(Win[i].x1,Wyk[i].y0+Win[i].y1,Win[i].x2,Wyk[i].y0+Win[i].y1);
         str(70/Wyk[i].s:5:3,s1);
         s2:=s1+Wyk[i].j;
         SetColor(2);
         OutTextXY(Win[i].x1+1,Win[i].y1+1,s2);
         OutTextXY(Win[i].x1+100,Win[i].y1+1,Wyk[i].t);
       end;
     if(f2='t') then begin
       str(t_wyk:5:3,s1);
       str(t_wyk+314/sk_czasu:5:3,s2);
       s3:='Czas '+s1+' - '+s2+' s';
       SetColor(2);
       OutTextXY(Win[i].x1+30,Win[i].y2-8,s3); end;
     if(f2='x') then begin
       str(314/sk_penet*1000:5:3,s1);
       s2:='Penetracja 0 - '+s1+' mm';
       SetColor(2);
       OutTextXY(Win[i].x1+30,Win[i].y2-8,s2); end;
   end;
     SetColor(yellow);
     SetLineStyle(0,1,1);
     Rectangle(Win[5].x1-1,Win[5].y1-1,Win[5].x2+1,Win[5].y2+1);
end;

procedure Wpisz_dane;
var i :integer;
begin
          OUT[1].dat:=t0;        OUT[1].tx:='czas     ';
          OUT[2].dat:=Reak;      OUT[2].tx:='Reakcja ';
          OUT[3].dat:=AL[4];     OUT[3].tx:='alf mlot ';
          OUT[4].dat:=OM[4];     OUT[4].tx:='om mlot  ';
end;

function _01(a : boolean) : integer;
begin
case a of
  true : _01:=1;
  false: _01:=0;
end; end;

procedure Rysuj(f1,f2 : char);
var n0,n1 : integer;
var i,j,zw : integer;
czysc : boolean;
begin
          zw:=ST[n_cial].K[i_kon].z;
          et_k[1].x:=KO[1].y*1000;   et_k[1].t:='ko 1 ';
          et_k[2].x:=KO[8].y*1000;   et_k[2].t:='ko 8 ';
          et_k[3].x:=KO[2].y*1000;   et_k[3].t:='ko 2 ';
          et_k[4].x:=KO[6].y*1000;   et_k[4].t:='ko 6 ';
          et_k[5].x:=KO[10].y*1000;  et_k[5].t:='ko10 ';

          et_[1].x:=et1;                  et_[1].t:='st 1 ';
          et_[2].x:=et2;                  et_[2].t:='st 2 ';
          et_[3].x:=et3;                  et_[3].t:='st 3 ';
          et_[4].x:=et4;                  et_[4].t:='st 4 ';
          et_[5].x:=et5;                  et_[5].t:='dx   ';

          et_c[1].x:=MSp[n_cial];         et_c[1].t:='MSp';
          et_c[2].x:=ST[n_cial].MO;       et_c[2].t:='MO ';
          et_c[3].x:=AL[n_cial];          et_c[3].t:='AL ';
          et_c[4].x:=OM[n_cial];          et_c[4].t:='OM ';
          et_c[5].x:=EP[n_cial];          et_c[5].t:='EP ';

      czysc:=false;
      if(czysc_) then
        if((t0-t_wyk)*sk_czasu>314) then
          begin
            t_wyk:=t0;
            for i:=1 to 4 do
              Wyk[i].xx:=0;
            czysc:=true;
          end;
      for i:=1 to 4 do
          Wyk[i].x:=(t0-t_wyk)*sk_czasu;
          if(Wyk[i].x>1000) then
            Wyk[i].x:=1000;
      case f1 of
        'c' : begin
          Wyk[1].y:=Reak;         Wyk[1].s:=30;           Wyk[1].t:='Reakcja';             Wyk[1].j:='N';
   j:=11; Wyk[2].y:=KO[j].N;      Wyk[2].s:=30;           Wyk[2].t:='Nacisk '+K[j].tx;     Wyk[2].j:='N';
   j:=6;  Wyk[3].y:=AL[j]*r_s;    Wyk[3].s:=70/ST[j].zak; Wyk[3].t:='Poˆo¾. '+ST[j].tx;    Wyk[3].j:='st';
   j:=4;  Wyk[4].y:=AL[j]*r_s;    Wyk[4].s:=70/ST[j].zak; Wyk[4].t:='Poˆo¾. '+ST[j].tx;    Wyk[4].j:='st';
        end;
        ' ' : begin
   j:=6; Wyk[1].y:=EP[j];      Wyk[1].s:=1e3; Wyk[1].t:='EP '+ST[j].tx; Wyk[1].j:='1/s2';
   j:=1; Wyk[2].y:=EP[j];      Wyk[2].s:=30;  Wyk[2].t:='EP '+ST[j].tx; Wyk[2].j:='1/s2';
   j:=4; Wyk[3].y:=EP[j];      Wyk[3].s:=30;  Wyk[3].t:='EP '+ST[j].tx; Wyk[3].j:='1/s2';
   j:=5; Wyk[4].y:=EP[j];      Wyk[4].s:=30;  Wyk[4].t:='EP '+ST[j].tx; Wyk[4].j:='1/s2';
        end;
        'k' : begin
   j:=1; Wyk[1].y:=KO[j].y;     Wyk[1].s:=30;  Wyk[1].t:='kon '+K[STY[j].kon].tx; Wyk[1].j:='m';
   j:=2; Wyk[2].y:=KO[j].y;     Wyk[2].s:=30;  Wyk[2].t:='kon '+K[STY[j].kon].tx; Wyk[2].j:='m';
   j:=5; Wyk[3].y:=KO[j].y;     Wyk[3].s:=30;  Wyk[3].t:='kon '+K[STY[j].kon].tx; Wyk[3].j:='m';
   j:=6; Wyk[4].y:=KO[j].y;     Wyk[4].s:=30;  Wyk[4].t:='kon '+K[STY[j].kon].tx; Wyk[4].j:='m';
        end;
      end;

  j:=1;   Wyk[6].x:=KO[j].y*sk_penet;
          Wyk[6].y:=KO[j].N; Wyk[6].s:=10;  Wyk[6].t:='Histereza '++K[j].tx; Wyk[6].j:='N';
          Wyk[7].x:=KO[n_kon].y*sk_penet;
          Wyk[7].y:=KO[n_kon].N; Wyk[7].s:=10;  Wyk[7].t:='Histereza '+K[n_kon].tx; Wyk[7].j:='N';

      case f2 of
      't'     : begin n0:=1; n1:=4; end;
      'x'     : begin n0:=6; n1:=7; end;
      'd',#59 : begin n0:=8; n1:=8; end;
      else      begin n0:=8; n1:=8; end;
      end;
      if ((start)or(f2<>ff2)or(f1<>ff1)or((f2='t')and(czysc))) then
        for i:=0 to 1 do
          begin
            GraphDefaults;
            SetActivePage(i);
            ViewPorty(0);
            ClearViewPort;
            Ekran(n0,n1);
            ff2:=f2;
            ff1:=f1;
            start:=false;
            for j:=6 to 7 do
              Wyk[j].x:=0;
          end;
      SetActivePage(1-Vpg);
      GraphDefaults;
      Schemat(f1);

      GraphDefaults;
      case f2 of
        't','x' : Wykresy(n0,n1);
        'd'     : Poprawki(n0);
        #59     : Help_(n0);
        end;
      Vpg:=1-Vpg;
      SetVisualPage(Vpg);
end;

end.