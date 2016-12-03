function [ output_args ] = FindBorderPoints( Frame, Args )
%FindBorderPoints znajdowanie brzegu obrazu rozproszeniowego zgodnie z
%teori¹ na podstawie przybli¿onych parametrów ramki
%   Detailed explanation goes here
Px=Args(1);
Py=Args(2);
Pz=Args(3);
ShX=Args(4);
ShY=Args(5);
lCCD=Args(6);

[X Y]=BorderFunction(Px,Py,Pz,ShX,ShY,lCCD,r);

for i=2:4:28%wybrane indeksy punktów na ramce w pobli¿u których szukamy brzegu
    j=0;
    d=30;%odleg³oœæ od zadanego punktu do brzegu otoczenia
    a1=(Y(i-1)-Y(i+1))/(X(i-1)-X(i+1));%wpó³czynnik kierunkowy stycznej do ramki w punkcie
    a=tand(atand(a1)+90);%wsp kierunkowy prostej prostopad³ej do stycznej do ramki w punkcie
    b=Y(i)-a*X(i);%prosta na której szukamy wartoœci jest w postaci y=ax+b
    %do znalezienia pixeli na odcinku pos³u¿y algorytm Bresenhama
    delta=(2*a*b)^2-4*(1+a^2)*(b^2-d^2);
    x1=(-(2*a*b)-(delta)^0.5)/(2*(1+a^2));
    y1=a*x1+b;
    x2=(-(2*a*b)+(delta)^0.5)/(2*(1+a^2));
    y2=a*x2+b;
    x1=round(x1);
    y1=round(y1);
    x2=round(x2);
    y2=round(y2);
    x=x1;
    y=y1;
    % ustalenie kierunku rysowania
    if x1<x2
        xi=1;
        dx=x2-x1;
    else
        xi=-1;
        dx=x1-x2;
    end
    % ustalenie kierunku rysowania
    if y1<y2
        yi=1;
        dy=y2-y1;
    else
        yi=-1;
        dy=y1-y2;
    end
    % pierwszy piksel
    j=j+1;
    v(j,1)=x;
    v(j,2)=y;
    % oœ wiod¹ca OX
    if dx>dy
        ai=(dy-dx)*2;
        bi=dy*2;
        d=bi-dx;
        % pêtla po kolejnych x
        while x~=x2
            % test wspó³czynnika
            if d>=0
                x=x+xi;
                y=y+yi;
                d=d+a1;
            else
                d=d+bi;
                x=x+xi;
            end
            j=j+1;
            v(j,1)=x;
            v(j,2)=y;
        end
    % oœ wiod¹ca OY
    else
        ai=(dx-dy)*2;
        bi=dx*2;
        d=bi-dy;
        % pêtla po kolejnych y
        while y~=y2
            % test wspó³czynnika
            if d>=0
                x=x+xi;
                y=y+yi;
                d=d+a1;
            else
                d=d+bi;
                y=y+yi;
            end
            j=j+1;
            v(j,1)=x;
            v(j,2)=y;
        end
    end
    
end

end

