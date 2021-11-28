import texto.*
import wollok.game.*

//
class Temporizador {
	var tiempoFuera = false
	const texto = new Texto(texto = "\nTIEMPO:", posicion = game.at(1, 14))

	method empezarConteo(tiempo) {
		pantalla.iniciarDigitos()
		game.addVisual(texto)
		self.contabilizar(tiempo)
	}
	
	method contabilizar(tiempo) {
		if (tiempo == 0 || tiempoFuera) {
			self.terminarConteo()
		} else {
			pantalla.calcularDigitos(tiempo)
			game.schedule(1000, { self.contabilizar(tiempo - 1) })
		}
	}
	
	method terminarConteo() {
		tiempoFuera = true
		pantalla.tiempoFuera()
	}
}


object pantalla {
	// Para cambiar la posicion de la pantalla modificar estos datos
	const x = 3
	const y = 14
	
	const digitosPantalla = [new Digito(digito = "0", posicion = game.at(x,y)), new Digito(digito = "0", posicion = game.at(x+1,y)), new Digito(digito = "0", posicion = game.at(x+2,y))]
	
	method iniciarDigitos() {
		digitosPantalla.forEach({ digito => game.addVisual(digito) })
	}
	
	method tiempoFuera() {
		self.mostrarDigitos(["0", "u", "t"])
	}
	
	method mostrarDigitos(nuevosDigitos) {
		digitosPantalla.forEach({ digito => self.modificarDigito(digito, nuevosDigitos)})
	}
	
	method modificarDigito(digito, nuevosDigitos) {
		if (nuevosDigitos.isEmpty()) {
			digito.cambiarDigito("0")
		} else {
			const nuevoDigito = nuevosDigitos.first()
			digito.cambiarDigito(nuevoDigito)
			nuevosDigitos.remove(nuevoDigito)
		}
	}
	
	// :( Cambiar logica lo antes posible
	method calcularDigitos(tiempo) {
		const cen = (tiempo.div(100) % 10).toString()
		const dec = (tiempo.div(10) % 10).toString()
		const uni = (tiempo % 10).toString()
		
		self.mostrarDigitos([cen, dec, uni])
	}
}

class Digito {
	const posicion
	var digito
	
	method image() = digito + ".png"
	
	method position() = posicion
	
	method cambiarDigito(nuevoDigito) {
		digito = nuevoDigito
	}
}