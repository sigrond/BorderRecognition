function [ distance ] = MeanSquaredDistance( Position, Args )
%MEANSQUAREDDISTANCE Ta funkcja ma byæ minimalizowan¹ funkcj¹ celu
%   Detailed explanation goes here
Px=Args(1);
Py=Args(2);
Pz=Args(3);
ShX=Args(4);
ShY=Args(5);
lCCD=Args(6);

distance=0;

for i=1:length(Position(:,1))
    [X Y]=BorderFunction(Px,Py,Pz,ShX,ShY,lCCD);
    distance=distance+(BorderDistance(X,Y,Position(i,1),Position(i,2)))^2;
end

distance=distance/length(Position(:,1));

end

