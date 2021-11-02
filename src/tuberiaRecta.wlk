import wollok.game.*
import tuberia.*
import orientaciones.*
import direcciones.*

class TuberiaRecta inherits Tuberia {
	
	override method tipoTuberia() = "Recta"
	
	override method ubicacionPuertos() {
		if (self.puntoCardinalActual(norte)) return [arriba, abajo] else return [izquierda, derecha]
	}
	
	override method accionar() {
		if (not self.tieneAgua()) {
			if (self.puntoCardinalActual(norte)) {
				self.siguientePuntoCardinal()
			} else {
				self.cambiarPuntoCardinal(norte)
			}
		}
	}
}