function [ Pk, PCCD ] = BorderRecognition( Frame )
%BORDERRECOGNITION Summary of this function goes here
%   Detailed explanation goes here
hf = imtool( Frame./(max(max(max(Frame)))/10) );
set(hf,'name','Select Border Points!')
ha = get(hf,'CurrentAxes');
hold(ha,'on');
h = impoly(ha);
position = wait(h);

% \todo funkcja licz¹ca sumê kwadratów najmniejszych odleg³oœci punktów od
%ramki
%fminsearch

Pk=[0 0 0];
PCCD=[0 0 0];

end

