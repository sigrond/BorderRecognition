function [ Pk, PCCD ] = BorderRecognition( Frame )
%BORDERRECOGNITION Summary of this function goes here
%   Detailed explanation goes here
hf = imtool( Frame./(max(max(max(Frame)))/20) );
set(hf,'name','Select Border Points!')
ha = get(hf,'CurrentAxes');
hold(ha,'on');
h = impoly(ha);
position = wait(h);




% \todo funkcja licz�ca sum� kwadrat�w najmniejszych odleg�o�ci punkt�w od
%ramki
%fminsearch
Position=position;
options = optimset('Display','iter');
[Args, f,exitflag,output]=fminsearch(@(x)MeanSquaredDistance(Position,x),[0,0,0,0,0,85],options);
[X Y]=BorderFunction(Args(1),Args(2),Args(3),Args(4),Args(5),Args(6));
plot(ha,X,Y,'r');

Pk=[Args(1),Args(2),Args(3)];
PCCD=[Args(4),Args(5),Args(6)];

end

