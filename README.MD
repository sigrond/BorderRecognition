#BorderRecognition

###Projekt mający na celu znajdować "ramkę" obrazu rozproszeniowego Mie'go.

"Ramka" jest rysowana funkcją BorderCreation
f(PkX,PkY,PkZ,CCDX,CCDY,CCDZ): R^6 -> R^2^n
funkcja ta nie jest znaną funkcją analityczną i kożysta z ray tracingu

Wstępna wersja projektu zakładała ręczne zaznaczenie punktów na brzegu obrazu rozproszeniowego. 
Po wprowadzeniu tych punktów zostanie zminimalizowana odległość punktów od ramki powstającej za pomocą funkcji 
f (minimalizacja sumy kwadratów odległości) i zostaną uzyskane argumenty funkcji dające ramkę danego obrazu rozproszeniowego. 
Argumenty te opisują położenie kropli zawieszonej w pułapce oraz położenie matrycy CCD względem środka pułapki.




##Atomatyzacja znajdowania szukanych zmiennych

Wstępnie znajduję ramkę (szukane zmienne) przez maksymalizację puntów jasnych wewnątrz ramki (aktualne parametry)
i ciemnych na zewnątrz ramki. Realizuję to za pomocą fminsearch i funkcji celu BrightnesScalarization.
W celu wybrania progu między wartościami ciemnymi i jasnymi za pomocą wyszukiwania binarnego szukam takiej wartości
progowej przy której zadana część punktów jest jasna (~30%). Realizuje to funkcja ThresholdValue.
Wadą tego rozwiązania jest ignorowanie faktycznego położenia przez wybieranie progu na podstawie stosunku jasnych
pixeli do ciemnych, co nie oddaje natury brzegu rozproszeniowego.

W następnym kroku automatyzacji zanajdowania szukanych zmiennych zamierzam w okolicy wcześniej znalezionego brzegu szukać
punktów, które z większą pewnością będą brzegowe. Mając punkty brzegowe wykożystam wcześniej napisaną funkcję celu
MeanSquaredDistance.
Brzeg jest wynikiem dyfrakcji fali płaskiej (światła) z przesłoną. Zatem brzeg (granica między światłem, a cieniem)
jest ukryty pod wzorem dyfrakcyjnym i wyznaczenie go wymaga znalezienia ostatniego minimum i maximum dyfrakcyjnego,
a następnie geometrycznego wyznaczenia granicy swiatła i cienia.
http://hyperphysics.phy-astr.gsu.edu/hbase/phyopt/difopa.html#c1
Dane są wybrane punkty ramki (indexy), wyznaczam prostą przechodzącą przez lewego i prawego sąsiada (styczna do ramki), 
znajduję prostą prostopadłą do stycznej przechodzącą przez zadany punkt. Na tej prostej w pewnym otoczeniu (~30px) 
spodziewam się znaleźć wzór dyfrakcyjny. W celu znalezienia pixeli na tej prostej zamierzam skożystać z algorytmu 
Bresenhama. Znajdę największe maximum i minimum (lewo i prwostronna pochodna zerowa, aby pominąć wartość na brzegu odcinka).
Maximum dyfrakcyjne jest w geometrycznym środku między minimum dyfrakcyjnym, a szukaną granicą światła i cienia.

##Zależności i użyte toolboxy Matlaba
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



##Wywołanie demonstracji w Matlabie
```Matlab
%załadować klatkę z filmu
load('Frame.mat');
%wywołać funkcje z argumentami
[ Pk, PCCD ]=BorderRecognition(Frame)

%następnie w wyświetlonym okienku zaznaczyć punkty na brzegu
%obrazu rozproszeniowego (zakończenie zaznaczanie przez
%zamknięcie wielokątu podwójnym kliknięciem).
%w trakcie wykonania można obserwować postępy algorytmu, w
%okienku z klatką wyświetlane są wybrane punkty oraz ramka na
%obecnym etapie optymalizacji.
%po zakończeniu minimalizacji zostanie wyświetlona ostatecza
% wersja ramki, a jej parametry są zwracane w Pk i PCCD.
```

##Do zrobienia:
- [ ] Mapy Wartości i gradientów
- [ ] Wyniki z profilera
- [ ] Kolory na obrazie jasnych punktów dla kanałów
