import wollok.game.*
import nivel.*
import orientaciones.*
import direcciones.*
import managerDeNiveles.*


// Mensajes principales:
// Tuberia.accionar()
// Tuberia.recibirAgua(tiempo)

class Tuberia {
	const posicion
	var puntoCardinal
	var tieneAgua = false
	
	// Metodos abstractos
	method tipoTuberia()
	method ubicacionPuertos()
	
	// Metodos
	method image(){
		return "tuberia" + self.tipoTuberia() + puntoCardinal.nombre() + "_" + tieneAgua.toString() + ".png"
	}
	
	method position() = posicion
	
	method accionar() {
		if (not tieneAgua) {
			self.siguientePuntoCardinal()
		}
	}
	
	method recibirAgua(tiempo) {
		tieneAgua = true
		game.schedule(tiempo, { self.pasarAgua(tiempo) })
	}
	
	method pasarAgua(tiempo) {
		try {
			self.verificarPuertosConectados()
			
			const tuberias = self.tuberiasDisponibles()
			
			if (tuberias.isEmpty()) {
				managerDeNiveles.finalizarNivelActual()
			} else {
				tuberias.forEach({ tuberia => tuberia.recibirAgua(tiempo) })
			}
		} catch e : DomainException {
			managerDeNiveles.finalizarNivelActual()
		}
	}
	
	method tuberiasDisponibles() {
		const puertosDisponibles = self.ubicacionPuertos().filter({ puerto => self.puedePasarAgua(puerto) })
		
		return puertosDisponibles.map({ puerto => self.obtenerTuberia(puerto) })
	}
		
	method puedePasarAgua(direccion) = self.obtenerTuberia(direccion).puedeRecibirDesde(direccion.opuesto())
	
	method puedeRecibirDesde(direccion) = if (self.existeUnPuertoEn(direccion)) (not tieneAgua) else false
	
	method obtenerTuberia(direccion) {
		const tuberia = game.getObjectsIn(direccion.proximaPosicion(posicion))
		
		if (tuberia.isEmpty()) {
			throw new DomainException(message = "No se pudo encontrar una tuberia en esa posicion")
		}
		
		return tuberia.first()
	}
	
	method existeUnPuertoEn(direccion) = self.ubicacionPuertos().contains(direccion)
	
	method verificarPuertosConectados() {
		if (self.algunPuertoNoEstaConectado()) {
			throw new DomainException(message = "Un puerto no esta conectado. ¡Fuga inminente!")
		}
	}
	
	method algunPuertoNoEstaConectado() = self.ubicacionPuertos().any({ puerto => not self.estaConectado(puerto) })
	
	method estaConectado(puerto) = self.obtenerTuberia(puerto).existeUnPuertoEn(puerto.opuesto())
	
	method tieneAgua() = tieneAgua
	
	method puntoCardinalActual(otraOrientacion) = puntoCardinal == otraOrientacion
	
	method siguientePuntoCardinal() {
		puntoCardinal = puntoCardinal.siguiente()
	}
	
	method cambiarPuntoCardinal(nuevoPuntoCardinal) {
		puntoCardinal = nuevoPuntoCardinal
	}
	
	method puntoCardinal() = puntoCardinal
}

