program piano_5;
{$N+}
uses Dos,Crt,Graph,Objects,Drivers,Dane_5,Grafika5;
{-----------------------------------------------------------------------}
procedure Obl_pkt(zak : integer);
var i,j,k,pp,cc : integer;
alf,r:Double;
pPO : pkt;
begin
  for i:=1 to l_cial do
    for j:=1 to ST[i].l_p do
      begin
        if (P[i,j].k>=zak) then
          begin
                pPO:=PO[P[i,1].pc,P[i,1].pp];
            if(j=1) then
                PO[i,j]:=pPO
            else
              begin
                PO[i,j].x:=pPO.x+cos(P[i,j].ab+AL[i])*P[i,j].rb;
                PO[i,j].y:=pPO.y+sin(P[i,j].ab+AL[i])*P[i,j].rb;
              end;
          end;

        if (P[i,j].k=1) then
          begin
                alf:=P[i,j].ab+AL[i];
                r:=P[i,j].rb;
                VE[i,j].w.x:=-sin(alf)*r*OM[i];
                VE[i,j].w.y:= cos(alf)*r*OM[i];
            for k:=2 to ST[i].l_st do
              begin
                alf:=ST[i].S[k].a+AL[ST[i].S[k].c];
                r:=ST[i].S[k].r;
                cc:=ST[i].S[k].c;
                VE[i,j].w.x:=VE[i,j].w.x-sin(alf)*r*OM[cc];
                VE[i,j].w.y:=VE[i,j].w.y+cos(alf)*r*OM[cc];
              end;
                VE[i,j].m:=dl_wek(p00,VE[i,j].w);
                VE[i,j].a:=k_wek(p00,VE[i,j].w);
          end;
      end;

  for i:=1 to l_cial do
    for j:=1 to ST[i].l_st do
        begin
          ST[i].S[j].w.x:=ST[i].S[j].r*cos(ST[i].S[j].a+AL[ST[i].S[j].c]);
          ST[i].S[j].w.y:=ST[i].S[j].r*sin(ST[i].S[j].a+AL[ST[i].S[j].c]);
        end;
  for i:=1 to l_cial do
    for j:=1 to ST[i].l_k do
        begin
          ST[i].K[j].w.x:=ST[i].K[j].r*cos(ST[i].K[j].a+AL[i]);
          ST[i].K[j].w.y:=ST[i].K[j].r*sin(ST[i].K[j].a+AL[i]);
        end;
end;
{-----------------------------------------------------------------------}
procedure Mom_spr;
var i : integer;
begin
  for i:=1 to l_cial do
    begin
      if Sp[i].pc>=0 then
        MSp[i]:=Sp[i].m0+Sp[i].m*nor_k(AL[i]-AL[Sp[i].pc])
      else MSp[i]:=0;
    end;
end;
{-----------------------------------------------------------------------}
procedure Sil_kon;
var i,j,st_k : integer;
yy,y,d,v1,v2,F,alf,bet,gam,zw : Double;
begin
  for i:=1 to l_kon do
    begin
      d:=dl_wek(PO[K[i].c2,K[i].p2],PO[K[i].c1,K[i].p11]);
      bet:=k_wek(PO[K[i].c2,K[i].p2],PO[K[i].c1,K[i].p11]);
      alf:=K[i].ak+AL[K[i].c1];
      gam:=nor_k(pi+bet-alf);
      y:=d;
      st_k:=0; {0-poza zakresem; 1- kon. z odc.; 2- kon. z pkt.}
      if(K[i].z>0) then
        if((0<gam)and(gam<K[i].z)) then
          if(abs(gam)<pip) then
            begin
              st_k:=1;
              bet:=nor_k(alf - pip);
            end
          else st_k:=2;
      if(K[i].z<0) then
        if((K[i].z<gam)and(gam<0)) then
          if(abs(gam)<pip) then
            begin
              st_k:=1;
              bet:=nor_k(alf + pip);
            end
          else st_k:=2;
      if(K[i].z=0) then
        st_k:=2;

      if(st_k=1)then
        begin
          y:=abs(d*sin(abs(gam)));
          if((d>K[i].dk)and not(pauza))  then  {coby sprawdza† pocz¥tkowe penet.}
            st_k:=0;
        end;

      if((st_k=0)or((y-K[i].rk>=0)and(st_k>0))) then
        begin
          KO[i].N:=0;
          KO[i].y:=-abs(y-K[i].rk);
          KO[i].v[1].y:=0;
          KO[i].v[2].y:=0;
        end;
      if((y-K[i].rk<0)and(st_k>0)) then
        begin
          yy:=abs(y-K[i].rk);
          v1:=cos(VE[K[i].c1,K[i].p11].a-bet+pi)*VE[K[i].c1,K[i].p11].m;
          v2:=cos(VE[K[i].c2,K[i].p2 ].a-bet   )*VE[K[i].c2,K[i].p2 ].m;
          KO[i].v[1].y:=v2+v1;
          KO[i].v[2].y:=v2+v1;
          KO[i].y:=yy;
          KO[i].N:=1000*KO[i].y;
          KO[i].b[1]:=bet;
          KO[i].b[2]:=nor_k(bet+pi);
        end;

    for j:=1 to 2 do
      begin
        KO[i].w[j].x:=KO[i].N*cos(KO[i].b[j]);
        KO[i].w[j].y:=KO[i].N*sin(KO[i].b[j]);
      end;
  end;

    for i:=1 to l_cial do
      begin
        ST[i].MO:=ST[i].Q*ST[i].S[1].w.x;
        ST[i].KO:=p00;
        for j:=1 to ST[i].l_k do
          begin
            ST[i].MO:=ST[i].MO+il_wek(ST[i].K[j].w,KO[ST[i].K[j].nK].w[ST[i].K[j].z]);
            ST[i].KO.x:=ST[i].KO.x+KO[ST[i].K[j].nK].w[ST[i].K[j].z].x;
            ST[i].KO.y:=ST[i].KO.y+KO[ST[i].K[j].nK].w[ST[i].K[j].z].y;
          end;
        for j:=1 to l_cial do
            ST[i].MO:=ST[i].MO+ST[i].M[j]*MSp[j];
      end;
end;
{-----------------------------------------------------------------------}
procedure Sil_tar;
var v,v1,v2,alf,bet,sig,w,T,T_s,T_d,T_gr,F,dF : Double;
m : array[1..l_kon_c] of Double;
i,j,nK,zw : integer;
begin
  for i:=1 to l_cial do
    begin
      sig:=0;
      for j:=1 to ST[i].l_k do
        begin                       {rozkˆad siˆy czynnej}
          nK:=ST[i].K[j].nK;
          zw:=ST[i].K[j].z;
          alf:=ST[i].K[j].a;
          m[j]:=K[nK].tar*KO[nK].N*Mat[K[nK].mat].m_d*abs(cos(KO[nK].b[zw]-alf));
          sig:=sig+m[j];
        end;

      if (sig>1e-5) then
        for j:=1 to ST[i].l_k do
          if (m[j]>1e-5) then
            begin
              nK:=ST[i].K[j].nK;
              zw:=ST[i].K[j].z;
              bet:=KO[nK].b[zw];
              alf:=ST[i].K[j].a;
              v1:=cos(VE[K[nK].c1,K[nK].p11].a-bet+pip)*VE[K[nK].c1,K[nK].p11].m;
              v2:=cos(VE[K[nK].c2,K[nK].p_r].a-bet+pip)*VE[K[nK].c2,K[nK].p_r].m;
              case (zw) of
                1 : KO[nK].v[zw].x:=(v1-v2);     {Pr. odc. wzg okr.w kier. bet}
                2 : KO[nK].v[zw].x:=(v2-v1);
              end;
              if(abs(KO[nK].v[zw].x)<Mat[K[nK].mat].v0_T) then
                w:=abs(KO[nK].v[zw].x/Mat[K[nK].mat].v0_T)
              else w:=1;

              T_d :=Mat[K[nK].mat].m_d*KO[nK].N;
              T_gr:=Mat[K[nK].mat].m_s*KO[nK].N;
              dF:=Mat[K[nK].mat].dF;
              F:=m[j]/sig* ST[i].MO/ST[i].K[j].r* cos(alf-bet+pi);
              if(abs(F)<T_gr) then
                T_s:=abs(F);
              if((T_gr<=abs(F))and(abs(F)<T_gr+dF)) then
                T_s:=(abs(F)-T_gr)*(T_d-T_gr)/dF+T_gr;
              if(abs(F)>=T_gr+dF) then
                T_s:=T_d;
              T:=-w*T_d*sign(KO[nK].v[zw].x) - (1-w)*T_s*sign(F);
              if(T<=0) then
                KO[nK].bT[zw]:=nor_k(bet+pip);
              if(T>0) then
                KO[nK].bT[zw]:=nor_k(bet-pip);
              KO[nK].T[zw]:=abs(T);

            end;
      if (sig<=1e-5) then
        for j:=1 to ST[i].l_k do
          begin
            nK:=ST[i].K[j].nK;
            zw:=ST[i].K[j].z;
            KO[nK].T [zw]:=0;
            KO[nK].bT[zw]:=0;
            KO[nK].v [zw].x:=0;
          end;
    end;

    for i:=1 to l_cial do
      for j:=1 to ST[i].l_k do
        begin
          nK:=ST[i].K[j].nK;
          zw:=ST[i].K[j].z;
          KO[nK].wT[zw].x:=KO[nK].T[zw]*cos(KO[nK].bT[zw]);
          KO[nK].wT[zw].y:=KO[nK].T[zw]*sin(KO[nK].bT[zw]);
        end;

    for i:=1 to l_cial do
      for j:=1 to ST[i].l_k do
        begin
          ST[i].MO:=ST[i].MO+il_wek(ST[i].K[j].w,KO[ST[i].K[j].nK].wT[ST[i].K[j].z]);
          ST[i].KO.x:=ST[i].KO.x+KO[ST[i].K[j].nK].wT[ST[i].K[j].z].x;
          ST[i].KO.y:=ST[i].KO.y+KO[ST[i].K[j].nK].wT[ST[i].K[j].z].y;
        end;

end;
{-----------------------------------------------------------------------}
procedure Row_ruchu;
var i,j,cc,pp : integer;
Omm,dx : double;
begin
    Obl_pkt(1);
    Mom_spr;
    Sil_kon;
    {Sil_tar;}
   GetMouseEvent(Event);
   Mouse:=MouseWhere;
   AL[6]:=(Mouse.y)*-11e-4;

    for i:=1 to l_cial do
        OM0[i]:=OM[i];
    OM[6]:=AL[6]-AL0[6];
    for i:=1 to l_cial do
        AL0[i]:=AL[i];
    for i:=1 to l_kon do
        K0[i]:=KO[i].y;

  if not(STY[2].s) then     {"dziaˆanie spr©¾ynek"}
        AL[2]:=AL[1];
  if(not(STY[3].s) and not(STY[4].s)) then
        AL[3]:=AL[1];
  if ( ((KO[6].y<0)and(KO[7].y<0)and(KO[12].y<0)and(OM[4]>=0)) or
       (OM[4]<0) ) then

    begin
      ST[4].MO:=ST[4].Q*ST[4].S[1].w.x-OM[4]*8e-4;
      OM[4]:=OM[4]+ST[4].MO/ST[4].I*dt;
    end;

  for i:=1 to l_styk do
    begin
      if(STY[i].str=1) then
        begin
          cc:=K[STY[i].kon].c1;
          pp:=K[STY[i].kon].p11;
        end;
      if(STY[i].str=2) then
        begin
          cc:=K[STY[i].kon].c2;
          pp:=K[STY[i].kon].p_r;
        end;

      if(STY[i].skl=1)then
        begin
          if (not(STY[i].s)and(KO[STY[i].kon].y>0)) then
            begin
              STY[i].s:=true;
              STY[i].a0:=AL[cc];
            end;
          if( ((STY[i].zw=-1)and(AL[cc]>STY[i].a0)) or ((STY[i].zw=1)and(AL[cc]<STY[i].a0)) ) then
            STY[i].s:=false;

          if(STY[i].s) then
            OM[cc]:=STY[i].zw*arctan(KO[STY[i].kon].y/P[cc,pp].rb)/dt;
        end;
      if((STY[i].skl=0)and(KO[STY[i].kon].y>0)) then
        begin
          Omm:=STY[i].zw*arctan(KO[STY[i].kon].y/P[cc,pp].rb)/dt;
          if(abs(Omm)>abs(OM[cc])) then
            OM[cc]:=Omm;
        end;
        et1:=_01(STY[1].s);
        et2:=_01(STY[2].s);
        et3:=_01(STY[3].s);
        et4:=_01(STY[4].s);
    end;

    if(KO[5].y>0) then
      repeat
        AL[3]:=AL[3]-0.005;
        PO[3,4].x:=PO[3,1].x+cos(P[3,4].ab+AL[3])*P[3,4].rb;
        PO[3,4].y:=PO[3,1].y+sin(P[3,4].ab+AL[3])*P[3,4].rb;
        dx:=PO[3,4].x-sqrt(sqr(K[5].rk)-sqr(PO[3,4].y-PO[4,18].y))+PO[4,18].x;
      until(dx>0);
        et5:=dx;


    if(KO[11].y>0) then
      OM[4]:=abs(OM[4]);

    for i:=1 to l_cial do
      EP[i]:=OM[i]-OM0[i];

    for i:=1 to l_cial do
      begin
        AL[i]:=AL[i]+OM[i]*dt;
        if (i<>4) then
          OM[i]:=0;
      end;

    if ( (((KO[6].y>0)or(KO[7].y>0)) and (OM[4]>0)) or     {opadanie na figur©}
         (KO[12].y>0) or                                   {chwytnik}
         ((OM0[4]>0)and(OM[4]<0)and(KO[11].y<0)) ) then    {odbicie niespr©¾yste}
          OM[4]:=0;

    ST[6].MO:=0;
    if(STY[6].s) then
      ST[6].MO:=ST[6].MO+(-ST[5].Q*ST[5].S[1].w.x
                          +10*EP[5]*ST[5].I)/P[5,14].rb*P[6,7].rb;
    if(STY[1].s) then
      ST[6].MO:=ST[6].MO+(-(ST[1].Q+ST[2].Q+ST[3].Q)*ST[1].S[1].w.x
                          +10*EP[1]*ST[1].I)/P[1,5].rb*P[6,15].rb;
    if((STY[5].s)or(STY[4].s)) then
      ST[6].MO:=ST[6].MO+(+ST[4].Q*ST[4].S[1].w.x
                          -10*EP[4]*ST[4].I)/P[4,19].rb*P[1,23].rb/P[1,5].rb*P[6,15].rb;

    if(ST[6].MO>0) then
      Reak:=ST[6].MO/0.21
    else
      Reak:=0;
end;
{-----------------------------------------------------------------------}
{-----------------------------------------------------------------------}
{-----------------------------------------------------------------------}
{-----------------------------------------------------------------------}
procedure Zerowanie;
var i,j : integer;
pPO : pkt;
begin
  for i:=0 to l_cial do
    for j:=1 to l_pkt do
      begin
        PO[i,j]:=p00; VE[i,j].w:=p00;
      end;
  for i:=1 to l_cial do
    begin
      AL[i]:=0;
      OM[i]:=0;
      EP[i]:=0;
      MSp[i]:=0;
    end;
      AL[0]:=0;
  for i:=1 to l_kon do
      KO[i].N:=0;
  for i:=1 to l_cial do
    begin
      for j:=1 to l_stop do
          ST[i].S[j].c:=0;
      for j:=1 to ST[i].l_k do
          ST[i].K[j].nK:=0;
      for j:=1 to l_cial do
          ST[i].M[j]:=0;
    end;
    et1:=0; et2:=0; et3:=0; et4:=0;
                          {ustawienia wykres¢w}
  for i:=1 to 7 do
    begin
      Wyk[i].y0:=Win[i].y2-Win[i].y1-10;  Wyk[i].y:=0;
      Wyk[i].xx:=0; Wyk[i].yy:=Wyk[i].y0;
    end;

  for i:=1 to l_out do
    OUT[i].dat:=0;

  for i:=1 to l_styk do
    begin
      STY[i]:=STY0[i];
      STY[i].s:=false;
    end;
end;

procedure Przepisz_zlicz;
var i,j : integer;
pPO : pkt;
begin
  for i:=0 to l_cial do
    begin
      ST[i]:=ST0[i];
      SP[i]:=SP0[i];
    end;

      Assign(Fgeo,file_geo);
      reset(Fgeo);
      if((IOResult=0)and(filesize(Fgeo)=(l_cial+1)*l_pkt)) then
        begin
          for i:=0 to l_cial do
            for j:=1 to l_pkt do
              begin
                Seek(Fgeo,i*l_pkt+j-1);
                read(Fgeo,P[i,j]);
              end;
            close(Fgeo);
        end
      else
        begin writeln('Plik '+file_geo+' niezaˆadowany');
              readln; end;

      Assign(Fkon,file_kon);
      reset(Fkon);
      if((IOResult=0)and(filesize(Fkon)=l_kon)) then
        begin
          for i:=1 to l_kon do
            begin
              Seek(Fkon,i-1);
              read(Fkon,K[i]);
            end;
          close(Fkon);
        end
      else
        begin writeln('Plik '+file_kon+' niezaˆadowany');
              readln; end;

      Assign(Fmat,file_mat);
      reset(Fmat);
      if((IOResult=0)and(filesize(Fmat)=l_mat)) then
        begin
          for i:=1 to l_mat do
            begin
              Seek(Fmat,i-1);
              read(Fmat,MAT[i]);
            end;
          close(Fmat);
        end
      else
        begin writeln('Plik '+file_mat+' niezaˆadowany');
              readln; end;

     for i:=0 to l_cial do   {zliczanie pkt-¢w}
       begin
         ST[i].l_p:=l_pkt;
         for j:=l_pkt downto 1 do
           if(P[i,j].k<0) then
             ST[i].l_p:=j-1;
       end;

end;

procedure WYP_PKT;
var i,j : integer;
pPO,MAP : pkt;
begin
   for i:=1 to l_kon do
     begin
      P[K[i].c1,K[i].p11].k:=1;                   {aktywacja pkt-¢w kontakt¢w}
      P[K[i].c1,K[i].p12].k:=1;                   {dla nich liczona pr©dko˜†}
      P[K[i].c2,K[i].p2].k:=1;                    { i poˆo¾enia}
      P[K[i].c2,K[i].p_r].k:=1;
     end;
  for i:=1 to l_cial do
    begin
      P[i,2].k:=1;
      P[P[i,1].pc,P[i,1].pp].k:=1;
    end;

   Assign(Fmap,file_map);
   reset(Fmap);
  for i:=0 to l_cial do   {wypeˆnia tab. punkt¢w}
    for j:=1 to ST[i].l_p do
        begin
          if (P[i,j].pp=0) then
            begin
              Seek(Fmap,P[i,j].LM-1);
              read(Fmap,MAP);
              P[i,j].a:=k_wek(p00,MAP);
              P[i,j].r:=dl_wek(p00,MAP);
              PO[i,j].x:=p00.x+P[i,j].r*cos(P[i,j].a);
              PO[i,j].y:=p00.y+P[i,j].r*sin(P[i,j].a);
            end
          else
            begin
              Seek(Fmap,P[i,j].LM-1);
              read(Fmap,MAP);
              pPO:=PO[P[i,j].pc,P[i,j].pp];
              P[i,j].a:=k_wek(pPO,MAP);
              P[i,j].r:=dl_wek(pPO,MAP);
              PO[i,j].x:=pPO.x+P[i,j].r*cos(P[i,j].a+AL[i]);
              PO[i,j].y:=pPO.y+P[i,j].r*sin(P[i,j].a+AL[i]);
            end;
        end;
  close(Fmap);

  for i:=0 to l_cial do   {uwzgl©dnia poprawki}
    for j:=1 to l_pkt do
        begin
          if (P[i,j].pp=0) then
            begin
              P[i,j].a:=P[i,j].a+P[i,j].da;
              P[i,j].r:=P[i,j].r+P[i,j].dr;
              P[i,j].ab:=P[i,j].a;
              P[i,j].rb:=P[i,j].r;
              PO[i,j].x:=p00.x+P[i,j].r*cos(P[i,j].a)+P[i,j].dx;
              PO[i,j].y:=p00.y+P[i,j].r*sin(P[i,j].a)+P[i,j].dy;
            end
          else
            begin
              pPO:=PO[P[i,j].pc,P[i,j].pp];
              P[i,j].da:=P[i,j].da+P[P[i,j].pc,P[i,j].pp].da;
              P[i,j].a:=P[i,j].a+P[i,j].da;
              P[i,j].r:=P[i,j].r+P[i,j].dr;
              PO[i,j].x:=pPO.x+P[i,j].r*cos(P[i,j].a+AL[i])+P[i,j].dx;
              PO[i,j].y:=pPO.y+P[i,j].r*sin(P[i,j].a+AL[i])+P[i,j].dy;
              P[i,j].ab:=k_wek(PO[i,1],PO[i,j]);
              P[i,j].rb:=dl_wek(PO[i,1],PO[i,j]);
            end;
        end;
end;

procedure WYP_STRUK;
var i,j,pk,pc,pp : integer;
begin
  for i:=1 to l_cial do  {wypeˆnia tab.hierarchii }
    begin
      ST[i].l_st:=1;           {  . stopnie hierarchii}
      ST[i].S[1].c:=i;
      ST[i].S[1].p:=2;
      ST[i].S[1].r:=dl_wek(PO[i,1],PO[i,2]);
      ST[i].S[1].a:=k_wek (PO[i,1],PO[i,2]);
      ST[i].M[i]:=1;
      pc:=P[i,1].pc;
      pp:=P[i,1].pp;
      for j:=2 to l_stop do
        if pc>0 then
          begin
            ST[i].l_st:=ST[i].l_st+1;
            ST[i].S[j].c:=pc;
            ST[i].S[j].p:=pp;
            ST[i].S[j].r:=dl_wek(PO[pc,1],PO[pc,pp]);
            ST[i].S[j].a:=k_wek (PO[pc,1],PO[pc,pp]);
            ST[pc].M[i]:=-1;
            pc:=P[pc,1].pc;
            pp:=P[pc,1].pp;
          end;

      ST[i].l_k:=0;
      for j:=1 to l_kon do    {  . kontakty}
        if ((K[j].c1=i)or(K[j].c2=i)) then
              begin
                ST[i].l_k:=ST[i].l_k+1;
                ST[i].K[ST[i].l_k].nK:=j;
                if(K[j].c1=i)then
                  begin ST[i].K[ST[i].l_k].z:=1;
                        pK:=K[j].p11; end
                else
                  begin ST[i].K[ST[i].l_k].z:=2;
                        pK:=K[j].p_r; end;
                ST[i].K[ST[i].l_k].a:=k_wek (PO[i,1],PO[i,pK]);
                ST[i].K[ST[i].l_k].r:=dl_wek(PO[i,1],PO[i,pK]);
                ST[i].K[ST[i].l_k].p:=pK;
              end;

      ST[i].Q:=ST[i].Mas*g;       {obliczanie Q }
    end;
end;

procedure Inicjuj(inic : integer);
var i,j,pk,pc,pp : integer;
r : double;
f : vector;
pPO : pkt;
begin
  if (inic=0) then
    begin
      czysc_:=false;
      n_cial:=4;
      i_kon:=3; n_kon:=7;
      f1:='c';  ff1:='c';
      f2:='t';  ff2:='p';
      n_pop:=3;
      pauza:=false;
      start:=true;
      Ekr.x:=100; Ekr.y:=150; Ekr.s:=800;

      Assign(Fpop,file_pop);
      reset(Fpop);
      if((IOResult=0)and(filesize(Fpop)=l_pop)) then
        begin
          for i:=1 to l_pop do
            begin
              Seek(Fpop,i-1);
              read(Fpop,POP[i]);
            end;
          close(Fpop);
        end
      else
        begin writeln('Plik '+file_pop+' niezaˆadowany');
              readln; end;

      Assign(Fmap,file_map);
      reset(Fmap);
      if not((IOResult=0)and(filesize(Fmap)=l_LM)) then
        begin writeln('Plik '+file_map+' niezaˆadowany');
              readln; end;

      Assign(F_in,File_input);
      reset(F_in);
      if not(IOResult=0) then
        begin writeln('Plik '+file_input+' niezaˆadowany');
              readln; end;
      close(F_in);

      GraphDriver := VGA;
      GraphMode := VGAMed;
      InitGraph(GraphDriver,GraphMode,'c:\tp\bgi');
      InitEvents;
    end;
{-----------------za kazdym razem---------------------------------------}

      Zerowanie;
      Przepisz_zlicz;
      Wpisz_dane;

  Assign(F_in,File_input);
  reset(F_in);
  Assign(Fout,File_output);
  rewrite(Fout);
  for i:=1 to l_out do
    write(Fout,OUT[i].tx);
    writeln(Fout);

  t_in:=0;
  t0:=0;
  t1:=0;
  t_wyk:=0;
  GetTime(t[1].h,t[1].m,t[1].s,t[1].ms);
  fl:=true;
  Vpg:=1;

  POPRAW;                {aktualizacja poprawek}
  WYP_PKT;
  WYP_STRUK;

  for i:=1 to l_kon do
    begin
      K[i].ak:= k_wek(PO[K[i].c1,K[i].p11],PO[K[i].c1,K[i].p12]);
      K[i].dk:=dl_wek(PO[K[i].c1,K[i].p11],PO[K[i].c1,K[i].p12]);
      K[i].rk:=dl_wek(PO[K[i].c2,K[i].p2],PO[K[i].c2,K[i].p_r]);
      K[i].a1:= k_wek(PO[K[i].c1,2],PO[K[i].c1,K[i].p11]);
      K[i].r1:=dl_wek(PO[K[i].c1,2],PO[K[i].c1,K[i].p11]);
      K[i].a2:= k_wek(PO[K[i].c1,2],PO[K[i].c2,K[i].p_r]);
      K[i].r2:=dl_wek(PO[K[i].c1,2],PO[K[i].c2,K[i].p_r]);
    end;

  Sil_kon;

  for i:=1 to l_cial do
    begin
      SP[i].m0:=SP[i].m0+SP[i].dm0;
      SP[i].m0:=SP[i].m0+SP[i].dm0;
    end;

end;

procedure klawiatura;
var i,j : integer;
begin
   if (keypressed) then klaw:=readkey;
   case klaw of
   'p': begin pauza:=not(pauza); klaw:=' '; end;
   's': begin
          start:=true;
          Inicjuj(1);
          klaw:=' ';
        end;
   'o': begin
          czysc_:=not(czysc_);
          klaw:=' ';
        end;
   '4' : begin Ekr.x:=Ekr.x+100; klaw:=' '; end;
   '6' : begin Ekr.x:=Ekr.x-100; klaw:=' '; end;
   '8' : begin Ekr.y:=Ekr.y+100; klaw:=' '; end;
   '2' : begin Ekr.y:=Ekr.y-100; klaw:=' '; end;
   '+' : begin Ekr.s:=Ekr.s*2;   klaw:=' '; end;
   '-' : begin Ekr.s:=Ekr.s/2;   klaw:=' '; end;
   'e' : begin
                 ff1:=f1;
                 case f1 of
                   ' ' : f1:='c';
                   'c' : f1:='k';
                   'k' : f1:=' ';
                 end;
                 klaw:=' ';
                 end;
   'x','t','d',#59 : begin
                       ff2:=f2;
                       f2:=klaw;
                       klaw:=' ';
                     end;

   #81 :begin
           i_kon:=i_kon-1;
           if(i_kon=0) then
             i_kon:=ST[n_cial].l_k;
           if(i_kon>ST[n_cial].l_k) then
             i_kon:=1;
           n_kon:=ST[n_cial].K[i_kon].nK;
           klaw:=' ';
        end;
   #73 :begin
           i_kon:=i_kon+1;
           if(i_kon>ST[n_cial].l_k) then
             i_kon:=1;
           n_kon:=ST[n_cial].K[i_kon].nK;
           klaw:=' ';
        end;

   #79 :begin
           n_cial:=n_cial-1;
           if(n_cial=0) then
             n_cial:=l_cial;
           if(i_kon>ST[n_cial].l_k) then
             i_kon:=1;
           n_kon:=ST[n_cial].K[i_kon].nK;
           klaw:=' ';
        end;
   #71 :begin
            n_cial:=n_cial+1;
            if(n_cial>l_cial) then
              n_cial:=1;
            if(i_kon>ST[n_cial].l_k) then
              i_kon:=1;
            n_kon:=ST[n_cial].K[i_kon].nK;
            klaw:=' ';
        end;
   end;
end;

procedure Opoznienie;
var i,j : integer;
begin
   GetTime(t[2].h,t[2].m,t[2].s,t[2].ms);
   for i:=1 to 2 do
     begin
       t_[i].h:=t[i].h; t_[i].m:=t[i].m; t_[i].s:=t[i].s; t_[i].ms:=t[i].ms;
     end;
   t_r:=((t_[2].h-t_[1].h)*3600+(t_[2].m-t_[1].m)*60+(t_[2].s-t_[1].s)+(t_[2].ms-t_[1].ms)/100);
   if (t_r<t0) then
     delay(round(t0-t_r)*100);
end;

procedure InOut;
var i,code: integer;
s1,s2                   : string[8];
begin
      Wpisz_dane;
      while ((t0>=t_in)and not(Eof(F_in))) do
        begin
          read(F_in,s1);
          readln(F_in,s2);
          for i:=1 to 8 do
            if(s1[i]=' ') then
              delete(s1,i,8);
          for i:=1 to 8 do
            if(s2[i]=' ') then
              delete(s2,i,8);
          val(s1,t_in,code);
          val(s2,AL[6],code);
                 AL[6]:=AL[6]*sk_klawisza;
        end;

      if(t0<=t_max) then
        for i:=1 to l_out do
          write(Fout,OUT[i].dat:8:4);
          writeln(Fout);
end;

{-----------------------------------------------------------------------}
var l:integer;
begin
Inicjuj(0);
repeat
   Klawiatura;
   Obl_pkt(0);
   Rysuj(f1,f2);
   if not(pauza) then
     for l:=1 to f_graf do
       begin
         t0:=t0+dt;
         InOut;
         Row_ruchu;
         Opoznienie;
       end;
until (klaw='q');
close(F_in);
close(Fout);
closeGraph;
end.