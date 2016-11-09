function [ distance ] = MeanSquaredDistance( PositionR, PositionB, Args )
%MEANSQUAREDDISTANCE Ta funkcja ma byæ minimalizowan¹ funkcj¹ celu
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

for i=1:length(PositionR(:,1))
    [X Y]=BorderFunction(Px,Py,Pz,ShX,ShY,lCCD,r);
    distance=distance+(BorderDistance(X,Y,PositionR(i,1),PositionR(i,2)))^2;
end

for i=1:length(PositionB(:,1))
    [X Y]=BorderFunction(Px,Py,Pz,ShX,ShY,lCCD,b);
    distance=distance+(BorderDistance(X,Y,PositionB(i,1),PositionB(i,2)))^2;
end

distance=distance/((length(PositionR(:,1))+length(PositionB(:,1)))^2);

if(distance==NaN || distance==Inf)
    distance=1280;
end

end

