import wollok.game.*
import cursor.*
import direcciones.*
import temporizador.*

// Mensaje principal
// Nivel.configuracionInicial()

// Mensajes secundarios
// Nivel.agregarObjetos()
// Nivel.configurarTeclas()
// Nivel.empezarNivel()
// Nivel.abrirValvulas()
// Nivel.removerTuberias()
// Nivel.terminarConteo()
// Nivel.salidasCompletadas()

class Nivel {
	
	const segundosEnLlenar = 0.2
	var segundosEnSalir = 30 // Default
	var tuberias
	var entradas
	var salidas
	const temporizador = new Temporizador()
	
	method configuracionInicial(){
		self.agregarObjetos()
		self.configurarTeclas()
		self.empezarNivel()
	}
	
	method agregarObjetos() {
		tuberias.forEach({tuberia => game.addVisual(tuberia)})
		entradas.forEach({entrada => game.addVisual(entrada)})
		salidas.forEach({salida => game.addVisual(salida)})
		
		game.addVisual(cursor)
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
		temporizador.empezarConteo(segundosEnSalir)
		game.schedule((segundosEnSalir * 1000), { self.abrirValvulas() })
	}
	
	method abrirValvulas() {
		entradas.forEach({ valvula => valvula.accionar() })
		temporizador.terminarConteo()
	}
	
	method removerTuberias() {
		game.clear()
	}
	
	method segundosEnLlenarTuberia() = segundosEnLlenar * 1000 
	
	method entradas() = entradas
	
	method terminarConteo() = temporizador.terminarConteo()

	method salidasCompletadas() = salidas.all({ salida => salida.tieneAgua() })
}
