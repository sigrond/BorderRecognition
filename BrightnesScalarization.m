function [ score ] = BrightnesScalarization( Frame, Args )
%BrightnesScalarization funkcja skalaryzujaca jasno�� na zewn�trz i
%wewn�trz
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
[Br, Dr]=BrightInDimOut(Frame(:,:,1),X,Y);

[X Y]=BorderFunction(Px,Py,Pz,ShX,ShY,lCCD,b);
[Bb, Db]=BrightInDimOut(Frame(:,:,3),X,Y);

a=2;
b=1;
score=-(a*(Br+Bb)+b*(Dr+Db));

end
