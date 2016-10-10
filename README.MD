#BorderRecognition

###Projekt maj¹cy na celu znajdowaæ "ramkê" obrazu rozproszeniowego Mie'go.

"Ramka" jest rysowana funkcj¹ BorderCreation
f(PkX,PkY,PkZ,CCDX,CCDY,CCDZ): R^6 -> R^2
funkcja ta nie jest znan¹ funkcj¹ analityczn¹ i ko¿ysta z ray tracingu

Wstêpna wersja projektu zak³ada rêczne zaznaczenie punktów na brzegu obrazu rozproszeniowego. Po wprowadzeniu tych punktów zostanie zminimalizowana odleg³oœæ punktów od ramki powstaj¹cej za pomoc¹ funkcji f (minimalizacja sumy kwadratów odleg³oœci*1) i zostan¹ uzyskane argumenty funkcji daj¹ce ramkê danego obrazu rozproszeniowego. Argumenty te opisuj¹ po³o¿enie kropli zawieszonejw pu³apce oraz po³o¿enie matrycy CCD wzglêdem œrodka pu³apki.






*1) Do zbadania, czy tak bêdzie wystarczaj¹co dobrze.