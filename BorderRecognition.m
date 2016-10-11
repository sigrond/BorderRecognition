function [ Pk, PCCD ] = BorderRecognition( Frame )
%BORDERRECOGNITION Summary of this function goes here
%   Detailed explanation goes here
hf = imtool( Frame./(max(max(max(Frame)))/20) );
set(hf,'name','Select Border Points!')
ha = get(hf,'CurrentAxes');
hold(ha,'on');
h = impoly(ha);
position = wait(h);
delete(h);

tic;
hs=scatter(ha,position(:,1),position(:,2),'filled');

Position=position;

[X Y]=BorderFunction(0,0,0,0,0,82);
hp=plot(ha,X,Y,'r');

function stop = myoutfun(x, optimValues, state)
stop = false;
[X Y]=BorderFunction(x(1),x(2),x(3),x(4),x(5),x(6));
delete(hp);
hp=plot(ha,X,Y,'r');
drawnow
end

options = optimset('Display','iter','OutputFcn',@myoutfun,'MaxIter',50);

[Args, f,exitflag,output]=fminsearch(@(x)MeanSquaredDistance(Position,x),[0,0,0,0,0,82],options);
[X Y]=BorderFunction(Args(1),Args(2),Args(3),Args(4),Args(5),Args(6));
delete(hp);
hp=plot(ha,X,Y,'r');

Pk=[Args(1),Args(2),Args(3)];
PCCD=[Args(4),Args(5),Args(6)];
toc
end

