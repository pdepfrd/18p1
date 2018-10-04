
monstruo(godzilla,100,5).
monstruo(sullivan,50,1).

caracteristica(godzilla,terrestre).
caracteristica(godzilla,colmillos).
caracteristica(godzilla,coraza).
caracteristica(sullivan,pelos).
caracteristica(sullivan,simpatico).

caracteristicaTerrible(colmillos).
caracteristicaTerrible(garras).
caracteristicaTerrible(aguijon).
caracteristicaTerrible(coraza).

cazador(hunter, 1 , 100, acuatico).
cazador(chasseur, 0, 5000, todoTerreno(50)).
cazador(aquaman, 0, 300, acuatico).
cazador(chasseur2, 0, 5000, todoTerreno(5)).

puntaje(Monstruo,Puntaje):-
	monstruo(Monstruo, Tamanio, Peligrosidad),
        adicional(Monstruo,Adicional),
	Puntaje is Tamanio * 0.2 * Peligrosidad * 2 + Adicional.

adicional(Monstruo,10):-terrible(Monstruo).
adicional(Monstruo,0):-not(terrible(Monstruo)).

terrible(Monstruo):-
    caracteristica(Monstruo,Caracteristica),
    caracteristicaTerrible(Caracteristica).


hayEquipo(Lider, Asistente, CantPerros):-
	cazador(Lider, MedallasL, PuntajeL, EspecialidadL),
	cazador(Asistente, MedallasA, PuntajeA, EspecialidadA),
        TotalMedallas is MedallasL + MedallasA,
	perrosSuficientes(CantPerros,TotalMedallas),
	PuntajeL > PuntajeA,
	not(mismaEspecialidad(EspecialidadL, EspecialidadA)).

perrosSuficientes(Perros, Medallas):-
	Minimo is 3 * Medallas,
	Maximo is 5 * Medallas,
	between(Minimo, Maximo, Perros).

mismaEspecialidad(Especialidad, Especialidad).
mismaEspecialidad(todoTerreno(_), todoTerreno(_)).

liderIndispensable(Cazador):-
	cazador(Cazador,_,_,_),
	forall(hayEquipo(Lider,_,_),Lider == Cazador).

cazadorInutil(Cazador):-
	cazador(Cazador,_,_,_),
	not(hayEquipo(Cazador,_,_)),
	not(hayEquipo(_,Cazador,_)).









