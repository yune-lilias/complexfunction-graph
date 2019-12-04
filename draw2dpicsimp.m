function draw2dpicsimp(g,x1,x2,y1,y2)
xai = 1001;
yai = 1001;
tepm = zeros(yai,3);
graph1 = zeros(xai,yai,3);
value = complex(zeros(xai,yai));
gvalue = zeros(xai,yai);
absz = zeros(xai,yai);
argz = zeros(xai,yai);
huez = zeros(xai,yai);
lightz = zeros(xai,yai);
pz = zeros(xai,yai);
qz = zeros(xai,yai);
hh = zeros(xai,yai);
hh1 = zeros(xai,yai);
syms q;
syms a b c;
tic

 %gvalue(5,4) = g(5,4)

stepx = (x2-x1)./(xai-1);
stepy = (y2-y1)./(yai-1);
h=waitbar(0,'processing 0%');
for yaa = 1:yai
  xaa = 1:xai;
  strin =['processing ',num2str(100*yaa/yai),'%']; 
   waitbar(yaa/yai,h,strin);
        xtmp = x1+(xaa-1)*stepx;
        ytmp = y2 - (yaa-1)*stepy;
   %     value(xaa,yaa) = xtmp+j*ytmp;
   try
        gvalue(yaa,xaa) = g(xtmp,ytmp);
   catch
       for xaa1 = 1:xai
           xtmp1 = x1+(xaa1-1)*stepx;
           try
               gvalue(yaa,xaa1) = g(xtmp1,ytmp);
           end
        end
       argz(yaa,xaa) =   pi + angle(gvalue(yaa,xaa));  
   end
      %  huet = @(q) hue2huenewinsi(q);
     %   hh = arrayfun(huet,double(argz));
end

close(h)
t1=toc

argz
gvalue
%gvalue = g(real(value),imag(value));
s = 1;

%argz =  pi + angle(gvalue);
hh = (double(argz)/(2*pi))*4;
hh1 = floor(hh);
%test0 = hh1==0
%test1 = hh1==1;


hh = ((hh1==0).*hh*60)+...
    ((hh1==1).*(2*(hh)-1))*60+...
    ((hh1==2).*(60*(hh+1)))+...
    ((hh1==3).*(120*(hh-1)));

 t0=toc
 

%Abandoned data: use arrayfun and switch each element cost much more time than xor.
%huet = @(q) hue2huenewinsi(q);
%hh = arrayfun(huet,double(argz));

 t2=toc
     lightz = (1 - 2.^(-abs(gvalue)));
     lightz = double(lightz);
     qz = (lightz>=1/2).*(lightz+s-lightz.*s)+(lightz<1/2).*(lightz.*(1+s));
     pz = 2.*lightz - qz;
     
 t3=toc

 %graph1(:,:,1) = 
%{
Abandoned data: use arrayfun and switch each element cost much more time than xor. 
opt = @(a,b,c)hue2rgbinsi(a,b,c);
graph1(:,:,1) = arrayfun(opt,pz,qz,hh+1/3);
graph1(:,:,2) = arrayfun(opt,pz,qz,hh);
graph1(:,:,3) = arrayfun(opt,pz,qz,hh-1/3);
%}

%{
     for i1 = 1:xai
    for j1 = 1:yai
   %     huez1 = hue2huenew(argz(i1,j1));
   %     hh = vpa(huez1./360,3);
        p = pz(i1,j1);
        q = qz(i1,j1);
        j1
     graph1(i1,j1,1) = hue2rgb(p,q,hh+1/3);
     graph1(i1,j1,2) = hue2rgb(p,q,hh);
     graph1(i1,j1,3) = hue2rgb(p,q,hh-1/3);
    end
    i1
     end
 %}
wa=waitbar(0,'wait');
    for iz=1:xai
        for jz=1:yai
            s=1;   
            l=lightz(iz,jz);         
            if s~=0
                htemp=hh(iz,jz);      
                hk=htemp/360;
                tR=hk+1/3;
                tG=hk;
                tB=hk-1/3;
                graph1(iz,jz,1)=hue2rgbinsi(tR,pz(iz,jz),qz(iz,jz));
                graph1(iz,jz,2)=hue2rgbinsi(tG,pz(iz,jz),qz(iz,jz));
                graph1(iz,jz,3)=hue2rgbinsi(tB,pz(iz,jz),qz(iz,jz));
            else
                graph1(iz,jz,1)=l;
                graph1(iz,jz,2)=l;
                graph1(iz,jz,3)=l;
            end
        end
        waitbar(iz/xai);
    end
    close(wa);
  
t4=toc

    
graph1 = graph1*255;
figure,imshow(uint8(graph1));


t5=toc
end







function q = hue2huenewinsi(q)
q = q/(2*pi)*4;
t = floor(q);
h = 0;
switch t
    case 0
     h = 60 * q;
    case 1
     h = 60*(2*q - 1);
    case 2
     h = 60*(q + 1);
    case 3
     h = 120*(q - 1);
end
end


function hue2 = hue2rgbinsi(t1,p,q)
t = t1;
if t<0 
    t=t+1; 
end
if t>1
    t=t-1; 
end
if t<1/6 c=p+6*t*(q-p);
elseif t<1/2 c=q;
elseif t<2/3 c=p+6*(q-p)*(2/3-t);
else c=p;
end
hue2 = c;
end