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
import temporizador.*

// managerDeNiveles.configurarNiveles()
// managerDeNiveles.comprobarNivelActual()
// managerDeNiveles.finalizarNivelActual()
// managerDeNiveles.siguienteNivel()
// managerDeNiveles.terminarConteo()

object partidaPrincipal {
	const temporizador = new Temporizador()
	
	method inicializar() {
		self.prepararInterfaz()
		self.configurarTeclas()
		temporizador.inicializar()
		managerDeNiveles.prepararNiveles(self.obtenerNiveles())
	}
	
	method prepararInterfaz() {
		game.addVisual(barraSuperior)
		game.addVisual(baseMonitoreo)
		game.addVisual(luzRoja)
		game.addVisual(luzVerde)
		game.addVisual(pj)
		
		monitor.inicializar()
	}
	
	method configurarTeclas() {
		keyboard.backspace().onPressDo({ self.mostrarMenuPrincipal() })
	}
	
	method mostrarMenuPrincipal() {
		monitor.imprimir("", "")
		game.clear()
		menu.mostrar()
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
	
	method terminarPartida(nivelesCompletados) {
		var texto
		var texto2
		
		if (nivelesCompletados) {
			texto = "BIEN HECHO - PUNTOS: 5"
			texto2 = "ENTER: Volver al menu"
		} else {
			texto = "GAME OVER - PUNTOS: 0"
			texto2 = "ENTER: Volver al menu"
		}
		
		monitor.imprimir(texto, texto2)
		keyboard.enter().onPressDo({ self.mostrarMenuPrincipal() })
	}
	
	method empezarConteo(tiempo) {
		temporizador.empezarConteo(tiempo)
	}
	
	method terminarConteo() {
		temporizador.terminarConteo()
	}
	
	method reiniciarConteo() {
		temporizador.reiniciar()
	}
}

object managerDeNiveles {
	var niveles
	var nivelActual
	var estanCompletados
	
	method prepararNiveles(nuevosNiveles) {
		estanCompletados = false
		niveles = nuevosNiveles
		self.iniciarNivel()
	}
	
	method iniciarNivel() {
		partidaPrincipal.reiniciarConteo()
		nivelActual = niveles.first()
		nivelActual.configuracionInicial()
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
			estanCompletados = false
			partidaPrincipal.terminarPartida(estanCompletados)
		}
	}
	
	method siguienteNivel() {
		niveles.remove(nivelActual)
		
		if (niveles.isEmpty()) {
			estanCompletados = true
			partidaPrincipal.terminarPartida(estanCompletados)
		} else {
			nivelActual.removerTuberias()
			self.iniciarNivel()
		}
	}
	
	method segundosParaLlenar() = nivelActual.segundosEnLlenarTuberia()
	
	method terminarConteo() {
		partidaPrincipal.terminarConteo()
		nivelActual.removerCursor()
	}
	
	method empezarConteo(tiempo) {
		partidaPrincipal.empezarConteo(tiempo)
	}
}
