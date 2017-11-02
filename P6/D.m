function action = D(y,delta)

L = 100;
H = 100;

K = 0.01; %Multiplica a y
Kd = 0.6; %Multiplica a delta


error = K * y;
rate = Kd * delta;

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
        action = (L*(K*y - Kd*delta )) / ( 2 * (2 * L - (K * abs(y))));

    case{3,4,7,8}
        action = (L*(K*y - Kd*delta )) / ( 2 * (2 * L - (Kd * abs(delta))));
        
    case{9,10}
        action = (L - Kd * delta) / 2;
    
    case{11,12}
        action = (-L + K * y) / 2;
    
    case{13,14}
        action = (-L - Kd * delta) / 2;
        
    case{15,16}
        action = (L + K * y) / 2;
        
    case{18}
        action = -L;
        
    case{20}
        action = L;
        
    otherwise
        action = 0;
        
end
        



