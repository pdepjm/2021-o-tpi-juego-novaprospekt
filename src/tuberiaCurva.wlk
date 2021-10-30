import wollok.game.*
import tuberia.*
import orientaciones.*
import direcciones.*

class TuberiaCurva inherits Tuberia {
	
	override method tipoTuberia() = "Curva"
	
	override method ubicacionPuertos() {
		if (self.puntoCardinalActual(norte)) {
			return [arriba, derecha]
		} else if (self.puntoCardinalActual(este)) {
			return [derecha, abajo]
		} else if (self.puntoCardinalActual(sur)) {
			return [abajo, izquierda]
		} else {
			return [izquierda, arriba]
		}
	}
}
