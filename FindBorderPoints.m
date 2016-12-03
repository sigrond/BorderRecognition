function [ output_args ] = FindBorderPoints( Frame, Args )
%FindBorderPoints znajdowanie brzegu obrazu rozproszeniowego zgodnie z
%teori� na podstawie przybli�onych parametr�w ramki
%   Detailed explanation goes here
r=658;
g=532;
b=458;
Px=Args(1);
Py=Args(2);
Pz=Args(3);
ShX=Args(4);
ShY=Args(5);
lCCD=Args(6);

[X Y]=BorderFunction(Px,Py,Pz,ShX,ShY,lCCD,r);

v=zeros(80,2);
line=zeros(80);

for i=2:4:80%wybrane indeksy punkt�w na ramce w pobli�u kt�rych szukamy brzegu
    j=0;
    d=30;%odleg�o�� od zadanego punktu do brzegu otoczenia
    a1=(Y(i-1)-Y(i+1))/(X(i-1)-X(i+1));%wp�czynnik kierunkowy stycznej do ramki w punkcie
    if atand(a1)>0
        a=tand(atand(a1)-90);%wsp kierunkowy prostej prostopad�ej do stycznej do ramki w punkcie
    else
        a=tand(atand(a1)+90);%wsp kierunkowy prostej prostopad�ej do stycznej do ramki w punkcie
    end
    b0=Y(i)-a*X(i);%prosta na kt�rej szukamy warto�ci jest w postaci y=ax+b
    b=b0;
    %y=a*X(i)+b0
    %Y(i)
    %b=b0-Y(i);%przesuniecie uk�adu wsp
    %do znalezienia pixeli na odcinku pos�u�y algorytm Bresenhama
    %delta=(2*a*b)^2-4*(1+a^2)*(b^2-d^2);
    delta=(((a^2)+2*a*b-2*X(i)-2*Y(i)*a)^2)-4*(1+(a^2))*((b^2)+(X(i)^2)+(Y(i)^2)-2*Y(i)*b-(d^2));
    if delta>0
        %x1=(-(2*a*b)-(delta)^0.5)/(2*(1+a^2))+X(i);
        %y1=a*x1+b0;
        %x2=(-(2*a*b)+(delta)^0.5)/(2*(1+a^2))+X(i);
        %y2=a*x2+b0;
        x1=(-(a^2+2*a*b-2*X(i)-2*Y(i)*a)-delta^0.5)/(2*(1+a^2));
        y1=a*x1+b;
        x2=2*X(i)-x1;
        y2=2*Y(i)-y1;
    else
        %b=b0-X(i)*a;
        %delta=(-2*b/a^2)^2-4*(1+1/a^2)*(b^2/a^2-d^2);
        %y1=(2*b/a^2-(delta)^0.5)/(2*(1+1/a^2))+Y(i);
        %x1=(y1-b0)/a;
        %y2=(2*b/a^2+(delta)^0.5)/(2*(1+1/a^2))+Y(i);
        %x2=(y2-b0)/a;
        delta=((-2*b)/(a^2)-2*Y(i))^2-4*(1+1/a^2)*((b^2)/(a^2)+Y(i)^2-d^2);
        if delta>0
            y1=(-((-2*b)/(a^2)-2*Y(i))-delta^0.5)/(2*(1+(1/(a^2))));
            x1=(y1-b)/a;
            x2=2*X(i)-x1;
            y2=2*Y(i)-y1;
        else
            x1=(Y(i)+d-b)/a;
            y1=a*x1+b;
            x2=2*X(i)-x1;
            y2=2*Y(i)-y1;
        end
    end
    %y=a*x1+b0
    %y1
    %y=a*x2+b0
    %y2
    ((X(i)-x1)^2+(Y(i)-y1)^2)^0.5
    ((X(i)-x2)^2+(Y(i)-y2)^2)^0.5
    
    %x1=int32(round(x1));
    %y1=int32(round(y1));
    %x2=int32(round(x2));
    %y2=int32(round(y2));
    x=int32(round(x1));
    y=int32(round(y1));
    % ustalenie kierunku rysowania

    if x1<x2
        xi=int32(1);
        dx=int32(x2-x1);
    else
        xi=int32(-1);
        dx=int32(x1-x2);
    end
    % ustalenie kierunku rysowania
    if y1<y2
        yi=int32(1);
        dy=int32(y2-y1);
    else
        yi=int32(-1);
        dy=int32(y1-y2);
    end
    % pierwszy piksel
    j=j+1;
    v(j,1)=x;%+X(i);
    v(j,2)=y;%+Y(i);
    %j
    line(j)=Frame(v(j,2),v(j,1),1);
    % o� wiod�ca OX
    if dx>dy
        ai=(dy-dx)*2;
        bi=dy*2;
        d=bi-dx;
        % p�tla po kolejnych x
        while x~=int32(round(x2))
            % test wsp�czynnika
            if d>=0
                x=x+xi;
                y=y+yi;
                d=d+ai;
            else
                d=d+bi;
                x=x+xi;
            end
            j=j+1;
            v(j,1)=x;%+X(i);
            v(j,2)=y;%+Y(i);
            line(j)=Frame(v(j,2),v(j,1),1);
        end
    % o� wiod�ca OY
    else
        ai=(dx-dy)*2;
        bi=dx*2;
        d=bi-dy;
        % p�tla po kolejnych y
        while y~=int32(round(y2))
            % test wsp�czynnika
            if d>=0
                x=x+xi;
                y=y+yi;
                d=d+ai;
            else
                d=d+bi;
                y=y+yi;
            end
            j=j+1;
            v(j,1)=x;%+X(i);
            v(j,2)=y;%+Y(i);
            line(j)=Frame(v(j,2),v(j,1),1);
        end
    end
    plot(line(1:j))
    %max(line)
    hf = imtool( Frame./(max(max(max(Frame)))/20) );
    ha = get(hf,'CurrentAxes');
    hold(ha,'on');
    hp=plot(ha,X,Y,'-xr');
    hs=scatter(ha,v(1:j,1),v(1:j,2),'filled','MarkerFaceColor','m');
    hs=scatter(ha,X(i),Y(i),'filled','MarkerFaceColor','b');
    hs=scatter(ha,x1,y1,'filled','MarkerFaceColor','r');
    hs=scatter(ha,x2,y2,'filled','MarkerFaceColor','c');
end

end
