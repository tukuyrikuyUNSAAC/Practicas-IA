/*
SISTEMA EXPERTO DE DIAGNÓSTICO MÉDICO
*/
/*
Base de conocimientos:
Hechos: Enfermedad, lista de síntomas.
*/

conocimiento('covid',
    ['pérdida del gusto o del olfato',
     'dificultad para respirar o falta de aire',
     'tos',
     'fiebre',
     'cansancio',
     'dolores musculares',
     'dolor de garganta y/o cabeza'
    ]).

conocimiento('viruela del mono',
    ['sarpullido con apariencia de granos o ampollas',
     'inflamación de los ganglios',
     'fiebre',
     'dolores musculares',
     'agotamiento',
     'escalofríos'
    ]).

conocimiento('gripe',
    ['malestar en todo el cuerpo',
     'fiebre',
     'dolor de cabeza'
    ]).

conocimiento('influenza',
    ['dolor en las articulaciones',
     'mucho estornudo',
     'dolor de cabeza'
    ]).

conocimiento('sarampion',
    ['cubierto el cuerpo de puntos',
     'los ojos rojos',
     'tos seca',
     'fiebre'
    ]).

conocimiento('malaria',
    ['temblor violento',
     'dolor en las articulaciones',
     'escalofrios',
     'fiebre'
    ]).

conocimiento('tifoidea',
    ['dolor abdominal',
     'falta de apetito',
     'diarrea',
     'fiebre',
     'dolor de cabeza'
    ]).

conocimiento('enfermedad desconocida',[]).

/*
Reglas de la base de conocimientos.
*/

/* Fase 0: Inicializar variables dinámicas */
:- dynamic respuestas_afirmativas/1.
:- dynamic respuestas_negativas/1.

mensajes_previos :-
    write('***************************************'),nl,
    write('Por favor responda las siguientes preguntas'),nl,
    write('con <si> <no> o <porque>'),nl,
    write('***************************************'),nl.

/* Fase 1: Recuperar enfermedad y síntomas*/
sintomas(Diagnosis, Sintomas) :-
    conocimiento(Diagnosis, Sintomas).

/* Fase 2: Efectuar preguntas al paciente*/

/* Registrar que el síntoma ya fue contestado */
procesar_rpta(_,Sintoma, Rpta) :-
    Rpta == si,
    asserta(respuestas_afirmativas(Sintoma)).

procesar_rpta(_,Sintoma, Rpta) :-
    Rpta == no,
    asserta(respuestas_negativas(Sintoma)),
    fail. % -- No continuar con los demás síntomas de una enfermedad

/* Justificar si el paciente desea saber el porque de la pregunta */
procesar_rpta(Diagnosis,Sintoma, Rpta) :-
    Rpta == porque,
    write('---------------------------------------'),nl,
    write('Se está analizando la hipotesis '),nl,
    write('que el paciente pueda tener: '),
    write(Diagnosis), write('.'), nl,
    write('Por tanto, necesito saber si el paciente tiene '),nl,
    write(Sintoma), write('.'), nl,
    write('---------------------------------------'),nl,
    write('Entonces, por favor responda'), nl,
    pregunta_a_paciente(Diagnosis, Sintoma).

/* Efectuar pregunta sobre el síntoma y procesar respuesta */
pregunta_a_paciente(Diagnosis,Sintoma):-
    write('El paciente tiene '),
    write(Sintoma),
    write('? '),
    read(Rpta),
    procesar_rpta(Diagnosis,Sintoma,Rpta).

/* Si la pregunta sobre el síntoma ya fue contestada
   afirmativamente o negativamente, ya no efectuar
   la pregunta */
pregunta(_, Sintoma) :-
    respuestas_afirmativas(Sintoma).

pregunta(_, Sintoma) :-
    respuestas_negativas(Sintoma),
    fail.

/* Si no se respondió con anterioridad sobre el síntoma,
   efectuar pregunta sobre el síntoma */
pregunta(Diagnosis, Sintoma) :-
    pregunta_a_paciente(Diagnosis, Sintoma).

/* Termina de efectuar preguntas cuando la lista está vacía*/
preguntar(_,[]).
/* Efectúa el proceso de preguntar de manera recursiva */
preguntar(Diagnosis,[Elemento|SubLista]) :-
    pregunta(Diagnosis, Elemento), /* Procesa primera pregunta de la lista */
    preguntar(Diagnosis, SubLista). /* Procesa recursivamente el resto de preguntas */

/* Fase 3: Efectuar el diagnóstico respectivo */
mostrar_sintomas([]).
mostrar_sintomas([Elemento|SubLista]) :-
    write('- '),write(Elemento),nl,
    mostrar_sintomas(SubLista).

diagnostico(Diagnosis, Sintomas) :-
    write('***************************************'),nl,
    write('El paciente tiene '),
    write(Diagnosis),nl,
    write('porque presenta los siguientes síntomas:'),nl,
    mostrar_sintomas(Sintomas).

/* ************* MÓDULO PRINCIPAL  *************** */
consultar() :-
    /* Fase 0: Inicializar variables dinámicas y mensajes previos */
    retractall(respuestas_afirmativas(_)),
    retractall(respuestas_negativas(_)),
    mensajes_previos,
    /* Fase 1: Recuperar enfermedad y síntomas*/
    sintomas(Diagnosis, Sintomas),
    /* Fase 2: Efectuar preguntas al paciente*/
    preguntar(Diagnosis, Sintomas),
    /* Fase 3: Efectuar el diagnóstico respectivo */
    diagnostico(Diagnosis, Sintomas).













