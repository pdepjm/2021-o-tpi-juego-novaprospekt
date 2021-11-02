import wollok.game.*
import nivel.*
import orientaciones.*
import direcciones.*
import managerDeNiveles.*


// Mensajes principales:
// Tuberia.rotar()
// Tuberia.recibirAgua()

class Tuberia {
	const posicion
	var puntoCardinal
	var tieneAgua = false
	
	method image(){
		return "tuberia" + self.tipoTuberia() + puntoCardinal.nombre() + "_" + tieneAgua.toString() + ".png"
	}
	
	method position() = posicion
	
	// ROTAR TUBERIA
	method accionar() {
		if (not tieneAgua) {
			self.siguientePuntoCardinal()
		}
	}
	
	// Con este metodo empieza todo el trabajo
	method recibirAgua(tiempo) {
		tieneAgua = true
		game.schedule(tiempo, { self.pasarAgua(tiempo) })
	}
	
	// Para que una tuberia pueda pasar agua sin problemas se tiene que cumplir que:
	// - Para todos los puertos de una tuberia, debe existir una tuberia adyacente
	// - Para todas las tuberias adyacentes en cada puerto, todas deben estar alineadas al puerto para recibir el agua
	// - Por lo menos una tuberia alineada a un puerto pueda recibir el agua sin problemas:
	// 		Aqui asumimos que los puertos restantes que no pueden recibir agua son porque tienen agua,
	//		y muy probablemente estas tuberias son las que llenaron la tuberia original en algun momento
	//
	// En caso de no cumplir con las tres condiciones, el juego termina
	method pasarAgua(tiempo) {
		// Intentar pasar agua a otras tuberias
		try {
			const tuberias = self.tuberiasDisponibles()
			
			// Si no hay ninguna tuberia disponible, fin del juego
			if (tuberias.isEmpty()) {
				managerDeNiveles.finalizarNivelActual()
			} else {
				// En otro caso, las tuberias disponibles deben recibir el agua
				tuberias.forEach({ tuberia => tuberia.recibirAgua(tiempo) })
			}
		} catch e : DomainException {
			// En caso de que por alguna razon no se pudo obtener las tuberias disponibles
			managerDeNiveles.finalizarNivelActual()
		}
	}
	
	method tuberiasDisponibles() {
		const puertosDisponibles = self.ubicacionPuertos().filter({ puerto => self.puedePasarAgua(puerto) })
		
		return puertosDisponibles.map({ puerto => self.obtenerTuberia(puerto) })
	}
		// Comprobar si para cada puerto, existe una tuberia
		// Si existe una tuberia adyacente, esta debe estar alineada
		// Si se cumplen los casos, devolver solo las que puedan pasar agua (que son las que no tienen agua xd)
		
	method puedePasarAgua(direccion) = self.obtenerTuberia(direccion).puedeRecibirDesde(direccion.opuesto())
	
	method puedeRecibirDesde(direccion) = if (self.existeUnPuertoEn(direccion)) (not tieneAgua) else false
	
	method obtenerTuberia(direccion) {
		var tuberia
		
		try { // Mejorar esta parte. getObjetsIn(posicion) obtiene una lista de objetos, por lo que puede que una tuberia no sea el primer objeto de esa lista
			tuberia = game.getObjectsIn(direccion.proximaPosicion(posicion)).first()
		} catch e: Exception { // En caso de no se encuentre un objeto, detallamos el error
			throw new DomainException(message = "No se pudo encontrar una tuberia en esa posicion")
		}
		
		return tuberia
	}
	
	method existeUnPuertoEn(direccion) = self.ubicacionPuertos().contains(direccion)
	
		
	method tipoTuberia()
	
	method ubicacionPuertos()
	
	method tieneAgua() = tieneAgua
	
	method puntoCardinalActual(otraOrientacion) = puntoCardinal == otraOrientacion
	
	method siguientePuntoCardinal() {
		puntoCardinal = puntoCardinal.siguiente()
	}
	
	method cambiarPuntoCardinal(nuevoPuntoCardinal) {
		puntoCardinal = nuevoPuntoCardinal
	}
}

