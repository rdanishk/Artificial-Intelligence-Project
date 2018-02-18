run :- 
	write('This program will guess a solar system object.'),nl,
	hypothesize(Object),
  write('The object in question is '),
  write(Object),nl, undo.
/* hypotheses to be tested */
hypothesize("The Sun") :- sun, !.
hypothesize("Mercury") :- mercury, !.
hypothesize("Venus") :- venus, !.
hypothesize("Earth") :- earth, !.
hypothesize("Earth's Moon") :- moon, !.
hypothesize("Mars") :- mars, !.
hypothesize("Phobos") :- phobos, !.
hypothesize("Deimos") :- deimos, !.
hypothesize("Ceres") :- ceres, !.
hypothesize("Asteroid Belt Object") :- asteroid, !.
hypothesize("Kuiper Belt Object") :- kuiper_belt_object, !.
hypothesize("Comet") :- comet, !.
hypothesize("Jupiter") :- jupiter, !.
hypothesize("Europa") :- europa, !.
hypothesize("Ganymede") :- ganymede, !.
hypothesize("Saturn") :- saturn, !.
hypothesize("Titan") :- titan, !.
hypothesize("Uranus") :- uranus, !.
hypothesize("Neptune") :- neptune, !.
hypothesize("Pluto") :- pluto, !.
hypothesize("Not found."). /* no diagnosis */


/* identification rules */
sun :- star. 
mercury :- planet, verify(terrestrial), verify("smallest planet").
venus :- planet, verify(terrestrial), verify("has spin opposite to all other planets").
earth :- planet, verify(terrestrial), verify("has life"). 
mars :- planet, verify(terrestrial), verify("is red").
jupiter :- planet, verify("largest planet").
saturn :- planet, verify(has_rings).
uranus :- planet, verify(is_ice_giant), verify("tilted axis").
neptune :- planet, verify(is_ice_giant).
pluto :- planet, dwarf, verify("farthest from the sun.").
ceres :- planet, dwarf, verify("lies in the asteroid belt").

asteroid :- small_body, verify("resides in the asteroid belt").
kuiper_belt_object :- small_body, verify("resides in the kuiper belt").
comet :- small_body.

ganymede :- satellite, verify(orbits_jupiter), verify("heaviest moon").
europa :- satellite, verify(orbits_jupiter), verify("is icy").
moon :- satellite, verify("orbits earth").
phobos :- satellite, verify("orbits mars"), verify("largest moon of mars").
deimos :- satellite, verify("orbits mars").
titan :- satellite, verify(orbits_saturn), verify("largest moon").

/* classification rules */
star :- verify("is a star").

satellite :- verify("is a moon").

small_body :- verify("is a small body").

planet :- verify("is a planet").

dwarf :- verify("is a dwarf-planet").



ask(Question) :-
      write('Does your object possess this property?'),nl,
      write(Question), write('? '),
       read(Response), nl,
       ( (Response == yes ; Response == y)
       -> assert(yes(Question)) ;
       assert(no(Question)), fail).
:- dynamic yes/1,no/1.

verify(S) :- (yes(S) -> true ; (no(S) -> fail ; ask(S))).

undo :- retract(yes(_)),fail.
undo :- retract(no(_)),fail.
undo.