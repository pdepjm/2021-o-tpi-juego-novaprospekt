import wollok.game.*
import cursor.*
import direcciones.*

class Nivel {
	
	const segundosEnLlenar = 0.2
	var segundosEnSalir = 30 // Default
	var tuberias
	var entradas
	var salidas
	
	method configuracionInicial(){
		tuberias.forEach({tuberia => game.addVisual(tuberia)})
		entradas.forEach({entrada => game.addVisual(entrada)})
		salidas.forEach({salida => game.addVisual(salida)})
		
		//Agrego el cursor de juego
		game.addVisual(cursor)
		self.configurarTeclas()
		self.empezarNivel()
	}
	
	//Configuro las teclas para moverse y para interactuar
	method configurarTeclas(){
		//Utiliza un metodo del cursor para moverlo
		keyboard.left().onPressDo({ cursor.moverPara(izquierda) })
		keyboard.right().onPressDo({ cursor.moverPara(derecha) })
		keyboard.up().onPressDo({ cursor.moverPara(arriba) })
		keyboard.down().onPressDo({ cursor.moverPara(abajo) })
		
		//Utiliza un metodo del cursor para interactuar con las tuberias
		keyboard.space().onPressDo({cursor.usar()})
		
	}
	
	//Comienzo el nivel con la tuberia especificada como la primera (la que ya tiene agua)
	method empezarNivel(){
		game.schedule((segundosEnSalir * 1000), { entradas.forEach({ valvula => valvula.accionar()/*recibirAgua(self.tiempoLlenado())*/}) })
	}
	
	method removerTuberias() {
		game.clear()
	}
	
	method segundosEnLlenarTuberia() = segundosEnLlenar * 1000 
	
	method entradas() = entradas

	method salidasCompletadas() = salidas.all({ salida => salida.tieneAgua() })
}
