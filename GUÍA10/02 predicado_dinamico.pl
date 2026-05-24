/* ******************  HECHOS ****************** */
% Personas
persona(ana, 13, femenino).
persona(joshua, 21, masculino).
persona(luis, 22, masculino).
persona(jorge, 25, masculino).
persona(isaac, 14, masculino).
persona(eva, 17, femenino).
persona(cecil, 16, femenino).
persona(david, 21, masculino).
persona(rocio, 19, femenino).
persona(juan, 12, masculino).
persona(pilar, 16, femenino).

/* ******* HECHOS GENERADOS DINÁMICAMENTE ****** */
% -- Declarar un predicado dinámico
:- dynamic menor_edad/3.

% Agregar personas cuya edad es menor a 18 al predicado dinámico menor_edad/3
agregar_menor_edad :-
    % -- Limpiar el predicado dinámico
    retractall(menor_edad(_, _, _)),
    % -- Agregar personas al predicado dinámico
    persona(Nombre, Edad, Genero),
    Edad < 18,
    % -- Agregar persona al inicio del predicado "menor_edad"
    asserta(menor_edad(Nombre, Edad, Genero)),
    % -- Para continuar con la siguiente persona, forzar una unificación no válida
    fail.
agregar_menor_edad.

/* ******************  REGLAS ****************** */
% menor de edad masculino
menor_edad_masculino(Nombre, Edad) :- menor_edad(Nombre, Edad, masculino).
% menor de edad femenino
menor_edad_femenino(Nombre, Edad) :- menor_edad(Nombre, Edad, femenino).










