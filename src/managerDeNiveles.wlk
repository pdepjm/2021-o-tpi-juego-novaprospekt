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

object managerDeNiveles {
	
	var nivelActual
	var niveles = []
	
	method configurarNiveles() {
		const nivel1 = new Nivel(segundosEnSalir = 15,tuberias = [
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
		
		const nivel2 = new Nivel(segundosEnSalir = 8, tuberias = [
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
		} else { // REINICIAR NIVEL.
			texto.agregarTexto("GAME OVER") // IMPLEMENTARLO DE MEJOR MANERA
			game.addVisual(texto) // IMPLEMENTARLO DE MEJOR MANERA
		}
	}
	
	method siguienteNivel() {
		nivelActual.removerTuberias()
		
		niveles.remove(nivelActual)
		
		// Si ya no hay mas niveles
		if (niveles.isEmpty()) {
			texto.agregarTexto("¡Felicidades Has Completado El juego") // IMPLEMENTARLO DE MEJOR MANERA
			game.addVisual(texto) // IMPLEMENTARLO DE MEJOR MANERA
			
			const felicidades = game.sound("felicidades.mp3") // BORRARLO QUE NOS COME EL COPYRIGHT
			felicidades.volume(0.2)
			felicidades.play()
			
		} else {
			nivelActual = niveles.first()
			nivelActual.configuracionInicial()
		}
	}
	
	method segundosParaLlenar() = nivelActual.segundosEnLlenarTuberia()
}
