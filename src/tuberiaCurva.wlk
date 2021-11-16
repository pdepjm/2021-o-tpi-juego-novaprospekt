import wollok.game.*
import tuberia.*
import orientaciones.*
import direcciones.*

class TuberiaCurva inherits Tuberia {
	
	override method tipoTuberia() = "Curva"
	
	override method ubicacionPuertos() = [puntoCardinal.direccionAsociada(), puntoCardinal.direccionHorario()]
}
