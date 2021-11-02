import tuberia.*
import wollok.game.*
import direcciones.*

class TuberiaCruz inherits Tuberia {
	
	override method tipoTuberia() = "Cruz"
	
	override method image() = "tuberiaCruz_" + tieneAgua.toString() + ".png"
	
	override method ubicacionPuertos() = [arriba, abajo, izquierda, derecha]
	
	override method accionar() {
		// No hacer nada
	}
}