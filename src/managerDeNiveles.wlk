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
import soundProducer.*
import menu.*
import direcciones.*
import interfaz.*

// managerDeNiveles.configurarNiveles()
// managerDeNiveles.comprobarNivelActual()
// managerDeNiveles.finalizarNivelActual()
// managerDeNiveles.siguienteNivel()
// managerDeNiveles.terminarConteo()

object partidaPrincipal {
	method iniciar() {
		managerDeNiveles.prepararNiveles(self.obtenerNiveles())
	}
	
	method obtenerNiveles() {
		const movX = 1
		const movY = 4
		
		const nivel1 = new Nivel(conteo = 120,tuberias = [
			new TuberiaRecta(posicion = game.at(1+ movX,2+ movY), puntoCardinal = norte),
			new TuberiaRecta(posicion = game.at(2+ movX,2+ movY), puntoCardinal = este),
			new TuberiaCurva(posicion = game.at(3+ movX,2+ movY), puntoCardinal = sur),
			new TuberiaRecta(posicion = game.at(3+ movX,3+ movY), puntoCardinal = norte),
			new TuberiaCurva(posicion = game.at(3+ movX,4+ movY), puntoCardinal = sur),
			new TuberiaCurva(posicion = game.at(4+ movX,4+ movY), puntoCardinal = norte),
			new TuberiaCurva(posicion = game.at(4+ movX,5+ movY), puntoCardinal = sur),
			new TuberiaRecta(posicion = game.at(5+ movX,5+ movY), puntoCardinal = norte),
			new TuberiaCurva(posicion = game.at(6+ movX,5+ movY), puntoCardinal = oeste),
			new TuberiaRecta(posicion = game.at(6+ movX,6+ movY), puntoCardinal = norte),
			new TuberiaRecta(posicion = game.at(6+ movX,7+ movY), puntoCardinal = este),
			new TuberiaCurva(posicion = game.at(6+ movX,8+ movY), puntoCardinal = sur),
			new TuberiaCurva(posicion = game.at(7+ movX,8+ movY), puntoCardinal = sur),
			new TuberiaRecta(posicion = game.at(7+ movX,7+ movY), puntoCardinal = norte),
			new TuberiaRecta(posicion = game.at(7+ movX,6+ movY), puntoCardinal = este),
			new TuberiaRecta(posicion = game.at(7+ movX,5+ movY), puntoCardinal = norte),
			new TuberiaCurva(posicion = game.at(7+ movX,4+ movY), puntoCardinal = sur),
			new TuberiaRecta(posicion = game.at(8+ movX,4+ movY), puntoCardinal = este)
		], entradas = [
			new TuberiaInicial(posicion = game.at(0+ movX,2+ movY), puntoCardinal = este)
		], salidas = [
			new TuberiaFinal(posicion = game.at(9+ movX,4+ movY), puntoCardinal = este)
		])
		
		const nivel2 = new Nivel(conteo = 20, tuberias = [
			new TuberiaRecta(posicion = game.at(movX + 1,movY + 2), puntoCardinal = norte),
			new TuberiaRecta(posicion = game.at(movX + 2,movY + 2), puntoCardinal = este),
			new TuberiaCurva(posicion = game.at(movX + 3,movY + 2), puntoCardinal = sur),
			new TuberiaRecta(posicion = game.at(movX + 3,movY + 3), puntoCardinal = norte),
			new TuberiaCurva(posicion = game.at(movX + 3,movY + 4), puntoCardinal = sur),
			new TuberiaT(posicion = game.at(movX + 4,movY + 4), puntoCardinal = oeste),
			new TuberiaCurva(posicion = game.at(movX + 4,movY + 5), puntoCardinal = sur),
			new TuberiaRecta(posicion = game.at(movX + 5,movY + 4), puntoCardinal = norte),
			new TuberiaRecta(posicion = game.at(movX + 5,movY + 5), puntoCardinal = este)
		], entradas = [
			new TuberiaInicial(posicion = game.at(movX + 0,movY + 2), puntoCardinal = este)
		], salidas = [
			new TuberiaFinal(posicion = game.at(movX + 6,movY + 4), puntoCardinal = este),
			new TuberiaFinal(posicion = game.at(movX + 6,movY + 5), puntoCardinal = este)
		])
		 
		return [nivel1, nivel2]
	}
}

object managerDeNiveles {
	var niveles
	var nivelActual
	var partidaGanada
	
	method prepararNiveles(nuevosNiveles) {
		self.prepararInterfaz()
		self.configurarTeclas()
		
		partidaGanada = false
		niveles = nuevosNiveles
		nivelActual = niveles.first()
		nivelActual.configuracionInicial()
	}
	
	method prepararInterfaz() {
		game.addVisual(barraSuperior)
		game.addVisual(baseMonitoreo)
		game.addVisual(luzRoja)
		game.addVisual(luzVerde)
		game.addVisual(pj)
		
		monitor.inicializar()
	}
	
	method comprobarNivelActual() {
		if (nivelActual.salidasCompletadas()) {
			self.finalizarNivelActual()
		}
	}
	
	method finalizarNivelActual() {
		if (nivelActual.salidasCompletadas()) {
			self.siguienteNivel()
		} else {
			partidaGanada = false
			self.terminarPartida()
		}
	}
	
	method siguienteNivel() {
		niveles.remove(nivelActual)
		
		if (niveles.isEmpty()) {
			partidaGanada = true
			self.terminarPartida()
		} else {
			nivelActual.removerTuberias()
			nivelActual = niveles.first()
			nivelActual.configuracionInicial()
		}
	}
	
	method terminarPartida() {
		var texto
		if (partidaGanada) texto = "ENHORABUENA \nENTER: Volver al menu" else texto = "GAME OVER\nENTER: Volver al menu" 
		
		monitor.imprimir(texto)
		keyboard.enter().onPressDo({ self.mostrarMenuPrincipal() })
	}
	
	method segundosParaLlenar() = nivelActual.segundosEnLlenarTuberia()
	
	method terminarConteo() {
		nivelActual.terminarConteo()
	}
	
	method configurarTeclas() {
		keyboard.backspace().onPressDo({ self.mostrarMenuPrincipal() })
	}
	
	method mostrarMenuPrincipal() {
		monitor.imprimir("")
		game.clear()
		menu.mostrar()
	}
}
