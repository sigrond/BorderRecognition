#BorderRecognition

###Projekt maj¹cy na celu znajdowaæ "ramkê" obrazu rozproszeniowego Mie'go.

"Ramka" jest rysowana funkcj¹ BorderCreation
f(PkX,PkY,PkZ,CCDX,CCDY,CCDZ): R^6 -> R^2^n
funkcja ta nie jest znan¹ funkcj¹ analityczn¹ i ko¿ysta z ray tracingu

Wstêpna wersja projektu zak³ada³a rêczne zaznaczenie punktów na brzegu obrazu rozproszeniowego. 
Po wprowadzeniu tych punktów zostanie zminimalizowana odleg³oœæ punktów od ramki powstaj¹cej za pomoc¹ funkcji 
f (minimalizacja sumy kwadratów odleg³oœci) i zostan¹ uzyskane argumenty funkcji daj¹ce ramkê danego obrazu rozproszeniowego. 
Argumenty te opisuj¹ po³o¿enie kropli zawieszonej w pu³apce oraz po³o¿enie matrycy CCD wzglêdem œrodka pu³apki.




##Atomatyzacja znajdowania szukanych zmiennych

Wstêpnie znajdujê ramkê (szukane zmienne) przez maksymalizacjê puntów jasnych wewn¹trz ramki (aktualne parametry)
i ciemnych na zewn¹trz ramki. Realizujê to za pomoc¹ fminsearch i funkcji celu BrightnesScalarization.
W celu wybrania progu miêdzy wartoœciami ciemnymi i jasnymi za pomoc¹ wyszukiwania binarnego szukam takiej wartoœci
progowej przy której zadana czêœæ punktów jest jasna (~30%). Realizuje to funkcja ThresholdValue.
Wad¹ tego rozwi¹zania jest ignorowanie faktycznego po³o¿enia przez wybieranie progu na podstawie stosunku jasnych
pixeli do ciemnych, co nie oddaje natury brzegu rozproszeniowego.

W nastêpnym kroku automatyzacji zanajdowania szukanych zmiennych zamierzam w okolicy wczeœniej znalezionego brzegu szukaæ
punktów, które z wiêksz¹ pewnoœci¹ bêd¹ brzegowe. Maj¹c punkty brzegowe wyko¿ystam wczeœniej napisan¹ funkcjê celu
MeanSquaredDistance.
Brzeg jest wynikiem dyfrakcji fali kulistej (œwiat³a) z przes³on¹. Zatem brzeg (granica miêdzy œwiat³em, a cieniem)
jest ukryty pod wzorem dyfrakcyjnym i wyznaczenie go wymaga znalezienia ostatniego minimum i maximum dyfrakcyjnego,
a nastêpnie geometrycznego wyznaczenia granicy swiat³a i cienia.
http://hyperphysics.phy-astr.gsu.edu/hbase/phyopt/difopa.html#c1
Dane s¹ wybrane punkty ramki (indexy), wyznaczam prost¹ przechodz¹c¹ przez lewego i prawego s¹siada (styczna do ramki), 
znajdujê prost¹ prostopad³¹ do stycznej przechodz¹c¹ przez zadany punkt. Na tej prostej w pewnym otoczeniu (~30px) 
spodziewam siê znaleŸæ wzór dyfrakcyjny. W celu znalezienia pixeli na tej prostej zamierzam sko¿ystaæ z algorytmu 
Bresenhama. Znajdê najwiêksze maximum i minimum (lewo i prwostronna pochodna zerowa, aby pomin¹æ wartoœæ na brzegu odcinka).
Maximum dyfrakcyjne jest w geometrycznym œrodku miêdzy minimum dyfrakcyjnym, a szukan¹ granic¹ œwiat³a i cienia.

##Zale¿noœci i u¿yte toolboxy Matlaba
license('inuse')
image_toolbox
matlab

[f,p]=matlab.codetools.requiredFilesAndProducts('BorderRecognition.m')

f = 

  Columns 1 through 3

    'D:\Moje dokumenty…'     'D:\Moje dokumenty…'     'D:\Moje dokumenty…' 

  Columns 4 through 6

    'D:\Moje dokumenty…'     'D:\Moje dokumenty…'     'D:\Moje dokumenty…' 

  Columns 7 through 8

    'D:\Moje dokumenty…'     'D:\Moje dokumenty…' 


p = 

1x2 struct array with fields:

    Name
    Version
    ProductNumber
    Certain
	
	
'MATLAB'	'8.6'	1	true
'Image Processing Toolbox'	'9.3'	17	true



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