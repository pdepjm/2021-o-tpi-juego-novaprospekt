import tuberia.*
import tuberiaRecta.*
import wollok.game.*
import direcciones.*
import orientaciones.*
import texto.*

class TuberiaInicial inherits Tuberia {
	
	override method tipoTuberia() = "Inicial"
	
	override method image() {
		if (self.tieneAgua()) {
			if (self.puntoCardinalActual(norte) || self.puntoCardinalActual(sur)) {
				return "tuberiaInicialNorte_true.png"
			} else {
				return "tuberiaInicialEste_true.png"
			}
		} else {
			return super()
		}
	}
	
	override method ubicacionPuertos() {
		// Secuencia de if :(
		if (self.puntoCardinalActual(norte)) {
			return [arriba]
		} else if (self.puntoCardinalActual(este)) {
			return [derecha]
		} else if (self.puntoCardinalActual(sur)) {
			return [abajo]
		} else {
			return [izquierda]
		}
	}
	
	override method rotar() {
		// No hacer nada
	}
}

class TuberiaFinal inherits TuberiaRecta {
	
	override method image() {
		return "tuberiaFinal" + puntoCardinal.nombre() + ".png"
	}
	
	override method recibirAgua(tiempo) {
		tieneAgua = true
		texto.agregarTexto("Partida terminada")
		game.addVisual(texto)
	}
	
	override method rotar() {
		// No hacer nada
	}
}