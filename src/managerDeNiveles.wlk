import nivel.*
import tuberiaCurva.*
import tuberiaRecta.*
import tuberiaIO.*
import tuberiaT.*
import tuberiaCruz.*
import wollok.game.*
import orientaciones.*
import texto.*
import cursor.*

// managerDeNiveles.configurarNiveles()
// managerDeNiveles.comprobarNivelActual()
// managerDeNiveles.finalizarNivelActual()
// managerDeNiveles.siguienteNivel()
// managerDeNiveles.terminarConteo()

object managerDeNiveles {
	
	var nivelActual
	var niveles = []
	
	method configurarNiveles() {
		const nivel1 = new Nivel(segundosEnSalir = 120,tuberias = [
			new TuberiaRecta(posicion = game.at(1,2), puntoCardinal = norte),
			new TuberiaRecta(posicion = game.at(2,2), puntoCardinal = este),
			new TuberiaCurva(posicion = game.at(3,2), puntoCardinal = sur),
			new TuberiaRecta(posicion = game.at(3,3), puntoCardinal = norte),
			new TuberiaCurva(posicion = game.at(3,4), puntoCardinal = sur),
			new TuberiaCurva(posicion = game.at(4,4), puntoCardinal = norte),
			new TuberiaCurva(posicion = game.at(4,5), puntoCardinal = sur),
			new TuberiaRecta(posicion = game.at(5,5), puntoCardinal = norte),
			new TuberiaCurva(posicion = game.at(6,5), puntoCardinal = oeste),
			new TuberiaRecta(posicion = game.at(6,6), puntoCardinal = norte),
			new TuberiaRecta(posicion = game.at(6,7), puntoCardinal = este),
			new TuberiaCurva(posicion = game.at(6,8), puntoCardinal = sur),
			new TuberiaCurva(posicion = game.at(7,8), puntoCardinal = sur),
			new TuberiaRecta(posicion = game.at(7,7), puntoCardinal = norte),
			new TuberiaRecta(posicion = game.at(7,6), puntoCardinal = este),
			new TuberiaRecta(posicion = game.at(7,5), puntoCardinal = norte),
			new TuberiaCurva(posicion = game.at(7,4), puntoCardinal = sur),
			new TuberiaRecta(posicion = game.at(8,4), puntoCardinal = este)
		], entradas = [
			new TuberiaInicial(posicion = game.at(0,2), puntoCardinal = este)
		], salidas = [
			new TuberiaFinal(posicion = game.at(9,4), puntoCardinal = este)
		])
		
		const nivel2 = new Nivel(segundosEnSalir = 20, tuberias = [
			new TuberiaRecta(posicion = game.at(1,2), puntoCardinal = norte),
			new TuberiaRecta(posicion = game.at(2,2), puntoCardinal = este),
			new TuberiaCurva(posicion = game.at(3,2), puntoCardinal = sur),
			new TuberiaRecta(posicion = game.at(3,3), puntoCardinal = norte),
			new TuberiaCurva(posicion = game.at(3,4), puntoCardinal = sur),
			new TuberiaT(posicion = game.at(4,4), puntoCardinal = oeste),
			new TuberiaCurva(posicion = game.at(4,5), puntoCardinal = sur),
			new TuberiaRecta(posicion = game.at(5,4), puntoCardinal = norte),
			new TuberiaRecta(posicion = game.at(5,5), puntoCardinal = este)
		], entradas = [
			new TuberiaInicial(posicion = game.at(0,2), puntoCardinal = este)
		], salidas = [
			new TuberiaFinal(posicion = game.at(6,4), puntoCardinal = este),
			new TuberiaFinal(posicion = game.at(6,5), puntoCardinal = este)
		])
		 
		
		niveles = [nivel1, nivel2] // Agrego los niveles creados
		nivelActual = niveles.first() // Obtengo el primero
		
		nivelActual.configuracionInicial() // Lo inicio
		
		const sonidoFondo = game.sound("background.mp3")
		sonidoFondo.volume(0.25)
		game.schedule(500, { sonidoFondo.play() })
	}
	
	// Comprueba si el nivel fue completado
	method comprobarNivelActual() {
		if (nivelActual.salidasCompletadas()) {
			self.finalizarNivelActual()
		}
	}
	
	// Finaliza el nivel, sin importar el estado del mismo
	method finalizarNivelActual() {
		if (nivelActual.salidasCompletadas()) {
			self.siguienteNivel()
		} else { // FINALIZAR JUEGO
			const texto = new Texto(texto = "GAME OVER", posicion = game.at(5,0))
			texto.mostrar()
		}
	}
	
	method siguienteNivel() {
		nivelActual.removerTuberias()
		
		niveles.remove(nivelActual)
		
		// Si ya no hay mas niveles
		if (niveles.isEmpty()) {
			const texto = new Texto(texto = "¡Felicidades!\nHas completado el juego", posicion = game.at(5,0)) // IMPLEMENTARLO DE UNA MEJOR MANERA
			texto.mostrar()
			
			//const felicidades = game.sound("felicidades.mp3") // BORRARLO QUE NOS COME EL COPYRIGHT
			//felicidades.volume(0.1)
			//felicidades.play()
			
		} else {
			nivelActual = niveles.first()
			nivelActual.configuracionInicial()
		}
	}
	
	method segundosParaLlenar() = nivelActual.segundosEnLlenarTuberia()
	
	method terminarConteo() {
		nivelActual.terminarConteo()
	}

}
