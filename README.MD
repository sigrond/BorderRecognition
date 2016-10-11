#BorderRecognition

###Projekt maj¹cy na celu znajdowaæ "ramkê" obrazu rozproszeniowego Mie'go.

"Ramka" jest rysowana funkcj¹ BorderCreation
f(PkX,PkY,PkZ,CCDX,CCDY,CCDZ): R^6 -> R^2^n
funkcja ta nie jest znan¹ funkcj¹ analityczn¹ i ko¿ysta z ray tracingu

Wstêpna wersja projektu zak³ada rêczne zaznaczenie punktów na brzegu obrazu rozproszeniowego. Po wprowadzeniu tych punktów zostanie zminimalizowana odleg³oœæ punktów od ramki powstaj¹cej za pomoc¹ funkcji f (minimalizacja sumy kwadratów odleg³oœci*1) i zostan¹ uzyskane argumenty funkcji daj¹ce ramkê danego obrazu rozproszeniowego. Argumenty te opisuj¹ po³o¿enie kropli zawieszonej w pu³apce oraz po³o¿enie matrycy CCD wzglêdem œrodka pu³apki.





*1) Do zbadania, czy tak bêdzie wystarczaj¹co dobrze.

##Wywo³anie demonstracji w Matlabie
```Matlab
%za³adowaæ klatkê z filmu
load('Frame.mat');
%wywo³aæ funkcje z argumentami
[ Pk, PCCD ]=BorderRecognition(Frame)

%nastêpnie w wyœwietlonym okienku zaznaczyæ punkty na brzegu
%obrazu rozproszeniowego (zakoñczenie zaznaczanie przez
%zamkniêcie wielok¹tu podwójnym klikniêciem).
%w trakcie wykonania mo¿na obserwowaæ postêpy algorytmu, w
%okienku z klatk¹ wyœwietlane s¹ wybrane punkty oraz ramka na
%obecnym etapie optymalizacji.
%po zakoñczeniu minimalizacji zostanie wyœwietlona ostatecza
% wersja ramki, a jej parametry s¹ zwracane w Pk i PCCD.
```