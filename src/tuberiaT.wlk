import tuberia.*
import wollok.game.*
import direcciones.*
import orientaciones.*

class TuberiaT inherits Tuberia {
	
	override method tipoTuberia() = "T"
	
	override method ubicacionPuertos() {
		if (self.puntoCardinalActual(norte)) {
			return [arriba, izquierda, derecha]
		} else if (self.puntoCardinalActual(este)) {
			return [arriba, derecha, abajo]
		} else if (self.puntoCardinalActual(sur)) {
			return [izquierda, abajo, derecha]
		} else {
			return [abajo, izquierda, arriba]
		}
	}
}