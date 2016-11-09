function [ Pk, PCCD ] = BorderRecognition( Frame, initial_point )
%BORDERRECOGNITION Procedura dobierania parametrów ramki do filmu
%   Detailed explanation goes here

if(exist('initial_point','var'))
    if(length(initial_point)~=6)
        initial_point=[0,0,0,0,0,82];
    end
else
    initial_point=[0,0,0,0,0,82];
end

%hf = imtool( Frame./(max(max(max(Frame)))/20) );
hf = imtool( Frame(:,:,1) );
set(hf,'name','Select Border Points for red color!')
ha = get(hf,'CurrentAxes');
hold(ha,'on');
h = impoly(ha);
positionr = wait(h);
delete(h);

delete(hf);
hf = imtool( Frame(:,:,3) );
ha = get(hf,'CurrentAxes');
hold(ha,'on');

hs=scatter(ha,positionr(:,1),positionr(:,2),'filled','MarkerFaceColor','m');

set(hf,'name','Select Border Points for blue color!')
hb = impoly(ha);
positionb = wait(hb);
delete(hb);

delete(hf);
hf = imtool( Frame./(max(max(max(Frame)))/20) );
ha = get(hf,'CurrentAxes');
hold(ha,'on');
hs=scatter(ha,positionr(:,1),positionr(:,2),'filled','MarkerFaceColor','m');

hs=scatter(ha,positionb(:,1),positionb(:,2),'filled','MarkerFaceColor','c');

tic;

%Position=position;

r=658;
g=532;
b=458;

[X Y]=BorderFunction(0,0,0,0,0,82,r);
hp=plot(ha,X,Y,'-xr');
[X Y]=BorderFunction(0,0,0,0,0,82,b);
hpb=plot(ha,X,Y,'-xb');

function stop = myoutfun(x, optimValues, state)
stop = false;
[X Y]=BorderFunction(x(1),x(2),x(3),x(4),x(5),x(6),r);
delete(hp);
hp=plot(ha,X,Y,'-xr');
[X Y]=BorderFunction(x(1),x(2),x(3),x(4),x(5),x(6),b);
delete(hpb);
hpb=plot(ha,X,Y,'-xb');
set(hf,'name',sprintf('%f %f %f %f %f %f',x(1),x(2),x(3),x(4),x(5),x(6)))
drawnow
end

if 0
options = optimset('Display','iter','OutputFcn',@myoutfun,'MaxIter',1200,'TolFun',1e-9,'TolX',1e-9);

[Args, f,exitflag,output]=fminsearch(@(x)MeanSquaredDistance(positionr,positionb,x),initial_point,options);

else
    options = optimset('Display','iter','OutputFcn',@myoutfun,'Diagnostics','on');
    [Args, f,exitflag,output]=fminunc(@(x)MeanSquaredDistance(positionr,positionb,x),initial_point,options);
end

[X Y]=BorderFunction(Args(1),Args(2),Args(3),Args(4),Args(5),Args(6),r);
delete(hp);
hp=plot(ha,X,Y,'-xr');
[X Y]=BorderFunction(Args(1),Args(2),Args(3),Args(4),Args(5),Args(6),b);
delete(hpb);
hpb=plot(ha,X,Y,'-xb');

Pk=[Args(1),Args(2),Args(3)];
PCCD=[Args(4),Args(5),Args(6)];
toc
end

