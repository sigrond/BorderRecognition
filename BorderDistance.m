function [ distance ] = BorderDistance( X,Y,Px,Py )
%BORDERDISTANCE funkcja ma zwracaæ odleg³oœæ punktu od ramki
%   X,Y -punkty ramki
%   Px,Py -wybrany punkt
dX=(X-Px).^2;
dY=(Y-Py).^2;
Distances=(dX+dY).^(0.5);
distance=min(Distances);

end

