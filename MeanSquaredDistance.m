function [ distance ] = MeanSquaredDistance( PositionR, PositionB, Args )
%MEANSQUAREDDISTANCE Ta funkcja ma by� minimalizowan� funkcj� celu
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

distance=0;
notused=0;

for i=1:length(PositionR(:,1))
    [X Y]=BorderFunction(Px,Py,Pz,ShX,ShY,lCCD,r);
    tmp=(BorderDistance(X,Y,PositionR(i,1),PositionR(i,2)))^2;
    if(tmp==NaN || tmp==Inf || isnan(tmp) || isinf(tmp))
        tmp=1;
        notused=notused-1;
    end
    distance=distance+tmp;
end

for i=1:length(PositionB(:,1))
    [X Y]=BorderFunction(Px,Py,Pz,ShX,ShY,lCCD,b);
    tmp=(BorderDistance(X,Y,PositionB(i,1),PositionB(i,2)))^2;
    if(tmp==NaN || tmp==Inf || isnan(tmp) || isinf(tmp))
        tmp=1;
        notused=notused-1;
    end
    distance=distance+tmp;
end

distance=distance/((length(PositionR(:,1))+length(PositionB(:,1))-notused)^2);

if(distance==NaN || distance==Inf || isnan(distance) || isinf(distance))
    distance=10000;
end

end

