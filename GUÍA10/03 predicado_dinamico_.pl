:- dynamic persona/1.

% Definimos algunas cláusulas iniciales para el predicado persona/1
persona(juan).
persona(maria).
persona(pedro).

% Ejemplo con assert/1
ejemplo_assert :-
    assert(persona(eva)), % Agrega la cláusula al final de la base de conocimientos
    write('Base de conocimientos con assert/1: '), nl,
    listing(persona).

% Ejemplo con asserta/1
ejemplo_asserta :-
    asserta(persona(laura)), % Agrega la cláusula al principio de la base de conocimientos
    write('Base de conocimientos con asserta/1: '), nl,
    listing(persona).
