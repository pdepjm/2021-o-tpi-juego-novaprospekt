import wollok.game.*
import cursor.*
import direcciones.*
import temporizador.*
import menu.*
import soundProducer.*
import texto.*

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
	var conteo
	var tuberias
	var entradas
	var salidas
	const temporizador = new Temporizador()
	const cursor = new Cursor()
	
	method configuracionInicial(){
		self.agregarObjetos()
		self.configurarCursor()
		self.empezarNivel()
	}
	
	method agregarObjetos() {
		tuberias.forEach({tuberia => game.addVisual(tuberia)})
		entradas.forEach({entrada => game.addVisual(entrada)})
		salidas.forEach({salida => game.addVisual(salida)})
		game.addVisual(cursor)
	}
	
	method empezarNivel(){
		temporizador.empezarConteo(conteo)
		game.schedule((conteo * 1000), { self.abrirValvulas() })
	}
	
	method abrirValvulas() {
		entradas.forEach({ valvula => valvula.accionar() })
		temporizador.terminarConteo()
	}
	
	method removerTuberias() {
		tuberias.forEach({tuberia => game.removeVisual(tuberia)})
		entradas.forEach({entrada => game.removeVisual(entrada)})
		salidas.forEach({salida => game.removeVisual(salida)})
	}
	
	method configurarCursor(){
		keyboard.left().onPressDo({ cursor.moverPara(izquierda) })
		keyboard.right().onPressDo({ cursor.moverPara(derecha) })
		keyboard.up().onPressDo({ cursor.moverPara(arriba) })
		keyboard.down().onPressDo({ cursor.moverPara(abajo) })
		keyboard.space().onPressDo({cursor.usar()})
	}
	
	method segundosEnLlenarTuberia() = segundosEnLlenar * 1000 
	
	method entradas() = entradas
	
	method terminarConteo() = temporizador.terminarConteo()

	method salidasCompletadas() = salidas.all({ salida => salida.tieneAgua() })
}
