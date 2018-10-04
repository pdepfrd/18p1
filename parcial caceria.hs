import Text.Show.Functions

data Monstruo = UnMonstruo {
	tamanio :: Float,
	peligrosidad :: Float,
	caracteristicas :: [String]
} deriving Show

godzilla = UnMonstruo {
	tamanio = 100,
	peligrosidad = 5,
	caracteristicas = ["terreste","colmillos","coraza"]
} 

sullivan = UnMonstruo 	{
	tamanio = 50,
	peligrosidad = 1,
	caracteristicas = ["pelos","simpatico"]
}

caracTerribles = ["colmillos","garras","coraza","aguijon"]

type Especialidad = Monstruo -> Bool

data Cazador = UnCazador {
	nombre :: String,
	medallas :: Int,
	puntos :: Float,
	especialidad :: Especialidad
--	especialidad :: Monstruo -> Bool
} deriving Show

hunter = UnCazador {
	nombre = "Hunter",
	medallas = 1,
	puntos = 100,
	especialidad = acuatico
}

chasseur = UnCazador {
	nombre = "Chasseur",
	medallas = 0,
	puntos = 5000,
	especialidad = todoTerreno 50
}

aquaman = UnCazador {
	nombre = "Aquaman",
	medallas = 0,
	puntos = 0,
	especialidad = acuatico
}

posee:: String->Monstruo->Bool
posee caracteristica monstruo = elem caracteristica (caracteristicas monstruo)
--posee caracteristica = elem caracteristica.caracteristicas

--acuatico:: Monstruo -> Bool
acuatico:: Especialidad
acuatico monstruo = posee "acuatico" monstruo
--acuatico = posee "acuatico"

--peliplumifero:: Monstruo -> Bool
peliplumifero::Especialidad
peliplumifero monstruo = posee "pelos" monstruo || posee "plumas" monstruo

--todoTerreno:: Float -> Monstruo -> Bool
todoTerreno:: Float -> Especialidad
todoTerreno valor monstruo = tamanio monstruo > valor && between 3 6 (peligrosidad monstruo)

between:: Ord a => a -> a -> a -> Bool
between minimo maximo valor = valor >= minimo && valor <= maximo

--1
puntaje :: Monstruo -> Float
puntaje monstruo = tamanio monstruo * 0.2 * peligrosidad monstruo * 2 + adicional monstruo

adicional:: Monstruo -> Float
adicional monstruo 
	| esTerrible monstruo = 10 
	| otherwise = 0

esTerrible:: Monstruo -> Bool
esTerrible monstruo = any caracteristicaTerrible (caracteristicas monstruo)

caracteristicaTerrible:: String -> Bool 
caracteristicaTerrible carac = elem carac caracTerribles

--b
puntajeCaceria::Cazador -> [Monstruo] -> Float
puntajeCaceria cazador monstruos = (sum. map puntaje . cazadosPor cazador) monstruos
--puntajeCaceria cazador = sum . map puntaje . cazadosPor cazador

cazadosPor:: Cazador -> [Monstruo] -> [Monstruo] 
cazadosPor cazador monstruos = filter (especialidad cazador) monstruos

--c
otorgarMedalla:: Cazador -> Cazador
otorgarMedalla cazador  = (puntuar 100 . darUnaMedalla) cazador
--otorgarMedalla = puntuar 100 . darUnaMedalla 

darUnaMedalla:: Cazador -> Cazador
darUnaMedalla cazador = cazador {medallas = medallas cazador + 1}
                                   
--d
caceria::Cazador -> [Monstruo] -> Cazador
caceria cazador monstruos = (puntuar (puntajeCaceria cazador monstruos).premiar monstruos) cazador

puntuar::Float -> Cazador -> Cazador
puntuar puntaje cazador = cazador{puntos = puntos cazador + puntaje}

premiar:: [Monstruo] -> Cazador -> Cazador
premiar monstruos cazador 
	| length (cazadosPor cazador monstruos) > 2 = otorgarMedalla cazador
	| otherwise = cazador

--e
cambiarEspecialidad:: Especialidad-> Cazador -> Cazador
--cambiarEspecialidad:: (Monstruo->Bool) -> Cazador -> Cazador
cambiarEspecialidad nueva cazador = cazador {especialidad = nueva}