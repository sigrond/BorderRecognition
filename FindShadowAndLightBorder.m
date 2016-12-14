function [ point ] = FindShadowAndLightBorder( line )
%FindShadowAndLightBorder Summary of this function goes here
%   Detailed explanation goes here
%dl=grad(line);

%znajdowanie extremów
k=0;
extremum=zeros(80,3);
for i=2:length(dl)-1
    if line(i-1)>line(i) && line(i+1)>line(i) %minimum
        k=k+1;
        extremum(k,1)=line(i);
        extremum(k,2)=-1;
        extremum(k,3)=i;
    elseif line(i-1)<line(i) && line(i+1)<line(i) %maximum
        k=k+1;
        extremum(k,1)=line(i);
        extremum(k,2)=1;
        extremum(k,3)=i;
    end
end

%znajdowanie najwy¿szej "amplitudy"
maxDifference=0;
minDiffInd=0;
maxDiffInd=0;
for i=2:k
    difference=abs(extremum(i-1,1)-extremum(i,1));
    if difference>maxDifference
        maxDifference=difference;
        if extremum(i,2)==1
            maxDiffInd=extremum(i,3);
            minDiffInd=extremum(i-1,3);
        else
            maxDiffInd=extremum(i-1,3);
            minDiffInd=extremum(i,3);
        end
    end
end

%P=(a+b)/2
%2*P=a+b
%2*P-b=a

point=2*maxDiffInd-minDiffInd;

end

