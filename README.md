# Hand-Controlled Audio Effects
Acest proiect utilizează recunoașterea gesturilor mâinilor pentru a controla efecte audio în timp real. Folosind Python, MediaPipe și OSC în Max/MSP, distanța și unghiurile dintre degete influențează parametri audio precum reverb și filtre.

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

Mâna Stângă: controlează Reverb
/left/distance1 → controlează wet/dry
/left/rotation1 → controlează decay
/left/distance2 → eventual predelay sau dimensiune cameră
/left/rotation2 → damping sau tonul reverbului

Mâna Dreaptă: controlează un Filtru
/right/distance1 → cutoff (200–8000 Hz)
/right/rotation1 → rezonanță (Q)
/right/distance2 → eventual panoramare sau mix dry/wet pentru filtrul aplicat
/right/rotation2 → tipul filtrului (cu un [selector] între LP/HP/BP etc.)

## (Istoric)

(14.05) ...

(3.06) ...

(X.06) ...

## (Link-uri)
(https://www.youtube.com/watch?v=KRrFFGOX6Sc&pp=ygUdY29udHJvbCBhYmxldG9uIGxpdmUgd2l0aCBtYXg%3D)

# Dezvoltarea proiectului

Inițial am găsit pe YouTube un video în care cineva controlează Ableton Live folosind MediaPipe și OSC. Acesta a creat un plugin care controlează semnalul audio folosind gesturi ale mâinilor. Am preluat codul său și am încercat să-l adaptez astfel încât să-l integrez cu Max/MSP. Am reușit să îl fac să funcționeze și acum intenționez să modific codul original pentru a elimina interfața grafică inițială și să fac direct în Max citirea camerei și afișarea video.  

https://www.youtube.com/watch?v=KRrFFGOX6Sc&pp=ygUdY29udHJvbCBhYmxldG9uIGxpdmUgd2l0aCBtYXg%3D

Mâna Stângă: controlează Reverb
/left/distance1 → controlează wet/dry
/left/rotation1 → controlează decay
/left/distance2 → eventual predelay sau dimensiune cameră
/left/rotation2 → damping sau tonul reverbului

Mâna Dreaptă: controlează un Filtru
/right/distance1 → cutoff (200–8000 Hz)
/right/rotation1 → rezonanță (Q)
/right/distance2 → eventual panoramare sau mix dry/wet pentru filtrul aplicat
/right/rotation2 → tipul filtrului (cu un [selector] între LP/HP/BP etc.)

## Elemente obligatorii

Fișierul Python   - hand_tracking.py 

Conține codul cu MediaPipe + OSC

Patch-ul Max/MSP  - hand_effects.maxpat



1. Acest readme completat. Titlu, descriere, mod de utilizare, istoric, link-uri utile.

   Poți include și imagini și chiar [gif-uri animate](https://www.screentogif.com/), sau link-uri către materiale audio/video.
   
   Vezi [aici](https://charlesmartin.com.au/blog/2020/08/09/student-project-repository) mai multe sugestii.

2. [Declarația de originalitate](statement-of-originality.yml) completată. Tot ce nu este inclus acolo va fi considerat 100% contribuție proprie.

    *(formatul este adaptat de [aici](https://gitlab.cecs.anu.edu.au/comp1720/2018/comp1720-2018-major-project/-/blob/master/statement-of-originality.yml). Da, este un pic ironic să refolosim un doc [de altundeva](https://cs.anu.edu.au/courses/comp1720/resources/faq/#how-do-i-fill-out-my-statement-of-originality), dar menționăm sursa deci nu este plagiat!)*

3. Proiectul în sine. Tot codul trebuie să fie prezent, proiectul trebuie să poată rula conform instrucțiunilor din readme. Dacă e nevoie de asset-uri mari (sunete, video etc), [folosește Git LFS](https://git-lfs.github.com/) sau include link de download în instrucțiunile de instalare.

