function action = PI(ep,ev)

L = 100;
H = 100;
%Ge = 200;
%Gr = 150;

Ki = 0.2;
Kp = 13;

error = ep * Ki;
rate = ev * Kp;

ic = 0; %Región IC0

%%%%%%%Condiciones del primer cuadrante (error y derivada positiva)%%%%%%%
if(rate >=0 && error >= 0)
   if(error < L && rate >= L)
       ic = 11;
   elseif(error >= L && rate >= L)
       ic = 17;
   elseif(error < rate && error < L)
       ic = 3;
   elseif(error >= rate && error < L)
       ic = 2;
   else
       ic = 10;      
   end

%%%%%%%Condiciones del segundo cuadrante (error positivo y derivada negativa)%%%%%%%
elseif(rate < 0 && error >= 0)
   if(error > - rate && error < L && rate < L)
       ic = 1;
   elseif(error <= -rate  && error < L && rate < L)
       ic = 8;
   elseif(error >= L && -L < rate)
       ic = 9;
   elseif(error < L && rate < - L)
       ic = 16;
   else
       ic = 20;      
   end
   
%%%%%%%Condiciones del tercer cuadrante, error negativo y derivada positiva%%%%%%%
elseif(rate >= 0 && error < 0)
   if(- L < error && rate >= L)
       ic = 12;
   elseif(error <= -L && rate >= L)
       ic = 18;
   elseif(-error <= rate && error > -L && rate < L)
       ic = 4;
   elseif(-error > rate && error > -L && rate < L)
       ic = 5;
   else
       ic = 13;      
   end

   %%%%%%%Condiciones del cuarto cuadrante, error y rate negativos%%%%%%%
else
   if(-error > -rate && error > -L && rate > -L)
       ic = 6;
   elseif(-error < -rate && error > -L && rate > -L)
       ic = 7;
   elseif(error <= -L && -L < rate)
       ic = 14;
   elseif(error <= -L && rate < -L)
       ic = 19;
   else
       ic = 15;      
   end
end

%Operación a aplicar según la región
switch(ic)
    
    case{1,2,5,6}
        action = (L*(Ki*ep + Kp*ev )) / ( 2 * (2 * L - (Ki * abs(ep))));

    case{3,4,7,8}
        action = (L*(Ki*ep + Kp*ev )) / ( 2 * (2 * L - (Kp * abs(ev))));
        
    case{9,10}
        action = (L + Kp * ev) / 2;
    
    case{11,12}
        action = (L + Ki * ep) / 2;
    
    case{13,14}
        action = (-L + Kp * ev) / 2;
        
    case{15,16}
        action = (-L + Ki * ep) / 2;
        
    case{17}
        action = L;
        
    case{19}
        action = -L;
        
    otherwise
        action = 0;
        
end
        



