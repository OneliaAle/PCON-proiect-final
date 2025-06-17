# Hand-Controlled Reverb

Acest proiect utilizează recunoașterea gesturilor mâinilor pentru a controla un efect audio de tip **reverb** în timp real. Folosind Python, MediaPipe și OSC în Max/MSP, gesturile influențează parametrii principali ai reverbului și ai unui filtru low-pass aplicat pe semnalul reverberat.


## Instalare
### Cerințe:
- Python 3.x
- OpenCV (`cv2`)
- MediaPipe
- python-osc
- Max/MSP

### Instalare biblioteci Python:

pip install opencv-python mediapipe python-osc

Max/MSP
Instalează Max de pe Cycling74.

## Utilizare
Deschide terminalul și rulează osc2.py pentru a începe trimiterea datelor OSC.

Deschide patch-ul orsc_1.maxpat în Max/MSP.

Activează camera și fă gesturi cu mâna stângă și mâna dreaptă pentru a controla efectele.

Control prin gesturi

**Mâna Stângă – Controlează:**
/left/distance2 → dimensiune camera (room size)
/left/rotation2 → mix dry/wet reverb

**Mâna Dreaptă: Controlează**
/right/distance1 → predelay
/right/rotation1 → cutoff pentru filtru LP


## Istoric

(21.05) – Adaptare cod hand tracking pentru funcționare exclusivă cu Max; adăugare colorare linii

(22.05) – Reglare problemă porturi OSC

(23.05) – Normalizare valori pentru control coerent

(15.06) – Creare patch complet de reverb în Max

(16.06) – Rezolvare bug-uri reverb

(17.06) – Creare interfață grafică în Max (mod de prezentare)

## Link-uri
https://ccrma.stanford.edu/~jos/pasp/Schroeder_Reverberators.html
https://ccrma.stanford.edu/~jos/pasp/Feedback_Comb_Filters.html
https://www.youtube.com/watch?v=KRrFFGOX6Sc&pp=ygUdY29udHJvbCBhYmxldG9uIGxpdmUgd2l0aCBtYXg%3D


# Dezvoltarea proiectului

Inițial am găsit pe YouTube un video în care cineva controlează Ableton Live folosind MediaPipe și OSC. Acesta a creat un plugin care controlează semnalul audio folosind gesturi ale mâinilor. Am preluat codul său și am încercat să-l adaptez astfel încât să-l integrez cu Max/MSP. Codul original includea o interfață grafică, dar am eliminat-o pentru a muta întreaga parte de afișare și control în Max. 

https://www.youtube.com/watch?v=KRrFFGOX6Sc&pp=ygUdY29udHJvbCBhYmxldG9uIGxpdmUgd2l0aCBtYXg%3D

Am implementat reverb-ul folosind obiecte gen~, inspirat din formulele Schroeder și filtre comb, după cum sunt descrise în documentația CCRMA (Stanford).
https://ccrma.stanford.edu/~jos/pasp/Schroeder_Reverberators.html
https://ccrma.stanford.edu/~jos/pasp/Feedback_Comb_Filters.html

# Fișiere proiect

osc2.py – Script Python care detectează gesturile mâinii folosind MediaPipe și trimite mesaje OSC către Max.

osc_1.maxpat – Patch Max/MSP care primește datele OSC și controlează efectul de reverb + filtrul LP. Include o interfață intuitivă în modul de prezentare.

README.md – Acest fișier de documentație.

statement-of-originality.yml – Declarația de originalitate completată.


## Elemente obligatorii

Fișierul Python   - osc2.py 
- Python funcțional pentru detecția mâinii și trimiterea datelor OSC

Patch-ul Max/MSP  - orsc_1.maxpat
- Patch Max care primește OSC și aplică efecte audio
- Interfață grafică clară în Presentation Mode





