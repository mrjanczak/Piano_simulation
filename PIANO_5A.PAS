program piano_5a;
{$N+}
uses Dos,Crt,Graph,Objects,Drivers,Dane_5a,Graf_5a;
{-----------------------------------------------------------------------}
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
procedure y_kon(i : integer);
var j,st_k : integer;
yy,y,d,v1,v2,F,alf,bet,gam,zw : Double;
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
          KO[i].y:=-abs(y-K[i].rk);
      if((y-K[i].rk<0)and(st_k>0)) then
        begin
          yy:=abs(y-K[i].rk);
          KO[i].y:=yy;
          KO[i].b[1]:=bet;
          KO[i].b[2]:=nor_k(bet+pi);
        end;

            if(i=10)then
              begin
                et1:=KO[i].y;
                et2:=d;
              end;

end;
{-----------------------------------------------------------------------}
procedure Row_ruchu;
var i,j,cg,pg,nk : integer;
Omm,dr,k6_0 : double;
begin
    Obl_pkt(1);
    Mom_spr;
    y_kon(6);
    k6_0:=KO[6].y;

    GetMouseEvent(Event);
    Mouse:=MouseWhere;

        AL0[6]:=AL[6];

        AL[6]:=(Mouse.y)*-11e-4;
        InOut;
        OM0[6]:=OM[6];
        OM[6]:=(AL[6]-AL0[6])/dt;
        EP[6]:=OM[6]-OM0[6];

    for i:=1 to l_cial-1 do
      begin
        AL0[i]:=AL[i];
        OM0[i]:=OM[i];
        ST[i].MO:=ST[i].Q*ST[i].S[1].w.x +MSp[i]-OM[i]*8e-5;
        OM[i]:=OM[i]+ST[i].MO/ST[i].I*dt;
      end;

  for i:=1 to l_styk do
    begin
          nk:=STY[i].kon;
          y_kon(nk);
      if(STY[i].str=1) then
        begin
          cg:=K[nk].c1;
          pg:=K[nk].p11;
        end;
      if(STY[i].str=2) then
        begin
          cg:=K[nk].c2;
          pg:=K[nk].p_r;
        end;

      if (KO[nk].y>0) then
        begin
          j:=0;
          if(nk<>12) then
            repeat
              j:=j+1;
              AL[cg]:=AL[cg]+ STY[i].zw * 1e-3{KO[nk].y/P[cg,pg].rb};
              PO[cg,pg].x:=PO[cg,1].x+cos(P[cg,pg].ab+AL[cg])*P[cg,pg].rb;
              PO[cg,pg].y:=PO[cg,1].y+sin(P[cg,pg].ab+AL[cg])*P[cg,pg].rb;
              y_kon(nk);
              Obl_pkt(1);
            until ((KO[nk].y<0.5e-3)or(j>100));

          if(cg<>4) then
              OM[cg]:=0;
        end;
    end;
          if( ((KO[7].y>0)or(KO[6].y>0)) and (OM[4]>0)) then
            OM[4]:=0;

          if((KO[6].y>0)and(k6_0>0)) then
            begin
              Omm:=11*OM[6];
              if((Omm<0)and(Omm<OM[4])) then
                OM[4]:=OM[4]+(Omm-OM[4])*0.7;
              if(OM[4]<om_max) then
                OM[4]:=om_max;
            end;

          if(KO[11].y>0) then
            OM[4]:=abs(OM[4]);
          if(KO[12].y>0) then
            OM[4]:=0;



    for i:=1 to l_cial-1 do
      begin
        EP[i]:=(AL[i]-AL0[i])-OM0[i];
        AL[i]:=AL[i]+OM[i]*dt;                {ruch swobodny}
      end;

    ST[6].MO:=0;
    if(KO[15].y>0) then
      ST[6].MO:=ST[6].MO+(-ST[5].Q*ST[5].S[1].w.x
                          +10*EP[5]*ST[5].I)/P[5,14].rb*P[6,7].rb;
    if(KO[1].y>0) then
      begin
        ST[6].MO:=ST[6].MO+(-(ST[1].Q+ST[2].Q+ST[3].Q)*ST[1].S[1].w.x
                            +10*EP[1]*ST[1].I)/P[1,5].rb*P[6,15].rb;
        if((KO[6].y>0)or(KO[7].y>0)) then
          ST[6].MO:=ST[6].MO+(+ST[4].Q*ST[4].S[1].w.x
                          -10*EP[4]*ST[4].I)/P[4,19].rb*P[1,23].rb/P[1,5].rb*P[6,15].rb;
      end;
    if(ST[6].MO>0) then
      Reak:=ST[6].MO/0.21
    else
      Reak:=0;
    if(AL[6]<-0.01) then
      Reak:=Reak+2;

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
      KO[i].y:=0;
    end;

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
         Row_ruchu;
         Opoznienie;
       end;
until (klaw='q');
close(F_in);
close(Fout);
closeGraph;
end.