import tuberia.*
import tuberiaRecta.*
import wollok.game.*
import direcciones.*
import orientaciones.*
import texto.*
import managerDeNiveles.*

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
	
	override method ubicacionPuertos() = [puntoCardinal.direccionAsociada()]
	
	override method accionar() {
		if (not self.tieneAgua()) {
			self.recibirAgua(managerDeNiveles.segundosParaLlenar())
			managerDeNiveles.terminarConteo()
		}
		
		
	}
}

class TuberiaFinal inherits TuberiaRecta {
	
	override method image() {
		return "tuberiaFinal" + puntoCardinal.nombre() + ".png"
	}
	
	override method recibirAgua(tiempo) {
		tieneAgua = true
		managerDeNiveles.comprobarNivelActual() // Comprueba si el nivel fue completado
	}
	
	override method accionar() {
		// No hacer nada
	}
}
