# Hand-Controlled Reverb
Acest proiect utilizează recunoașterea gesturilor mâinilor pentru a controla un efect audio de reverb în timp real. Folosind Python, MediaPipe și OSC în Max/MSP, distanța și unghiurile dintre degete influențează parametrii audio ai unui reverb.

## Instalare
Cerințe:

Python 3.x
OpenCV
MediaPipe
python-osc
Max/MSP

   Instalarea bibliotecilor Python:
pip install opencv-python mediapipe python-osc

   Max/MSP
Instalează Max de pe Cycling74.

## Utilizare
Efecte implementate

**Mâna Stângă – Controlează:**
/left/distance2 → dimensiune camera
/left/rotation2 → mix dry/wet reverb

**Mâna Dreaptă: Controlează**
/right/distance1 → predelay
/right/rotation1 → filtru LP (aplicat reverberatiei)


## (Istoric)

(14.05) ...

(3.06) ...

(X.06) ...

## Link-uri
https://ccrma.stanford.edu/~jos/pasp/Schroeder_Reverberators.html
https://ccrma.stanford.edu/~jos/pasp/Feedback_Comb_Filters.html
https://www.youtube.com/watch?v=KRrFFGOX6Sc&pp=ygUdY29udHJvbCBhYmxldG9uIGxpdmUgd2l0aCBtYXg%3D


# Dezvoltarea proiectului

Inițial am găsit pe YouTube un video în care cineva controlează Ableton Live folosind MediaPipe și OSC. Acesta a creat un plugin care controlează semnalul audio folosind gesturi ale mâinilor. Am preluat codul său și am încercat să-l adaptez astfel încât să-l integrez cu Max/MSP. Am reușit să îl fac să funcționeze și acum intenționez să modific codul original pentru a elimina interfața grafică inițială și să fac direct în Max citirea camerei și afișarea video.  

https://www.youtube.com/watch?v=KRrFFGOX6Sc&pp=ygUdY29udHJvbCBhYmxldG9uIGxpdmUgd2l0aCBtYXg%3D

Am implementat reverbul dupa aceste formule in MaxDSP, folosindu-ma de obiectele gen din max penturu a putea aplica cele de mai jos
https://ccrma.stanford.edu/~jos/pasp/Schroeder_Reverberators.html
https://ccrma.stanford.edu/~jos/pasp/Feedback_Comb_Filters.html


time_continue=87&v=i6rQfjmQHc0&embeds_referring_euri=https%3A%2F%2Fwww.bing.com%2F&embeds_referring_origin=https%3A%2F%2Fwww.bing.com&source_ve_path=MTM5MTE3LDI4NjYzLDI4NjY2


**Mâna Stângă – Controlează:**
/left/distance2 → dimensiune camera
/left/rotation2 → mix dry/wet reverb

**Mâna Dreaptă: Controlează**
/right/distance1 → predelay
/right/rotation1 → filtru LP (aplicat reverberatiei)


## Elemente obligatorii

Fișierul Python   - osc2.py 
Conține codul cu MediaPipe + OSC

Patch-ul Max/MSP  - orsc_1.maxpat
Contine implementarea reverbului, in mod de prezentare este o interfata intuitiva 





