import tuberia.*
import wollok.game.*
import direcciones.*
import orientaciones.*

class TuberiaT inherits Tuberia {
	
	override method tipoTuberia() = "T"
	
	override method ubicacionPuertos() = [puntoCardinal.direccionAsociada(), puntoCardinal.direccionAntiHorario(), puntoCardinal.direccionHorario()]
}