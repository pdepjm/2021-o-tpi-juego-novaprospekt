import texto.*
import wollok.game.*

class Temporizador {
	var tiempoFuera = false
	const texto = new Texto(texto = "Tiempo:", posicion = game.at(0, 9))

	method empezarConteo(tiempo) {
		pantalla.iniciarDigitos()
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
	
	const posiUni = game.at(3,9)
	const posiDec = game.at(2,9)
	const posiCen = game.at(1,9)
	
	const digitosPantalla = [new Digito(digito = "0", posicion = posiCen), new Digito(digito = "0", posicion = posiDec), new Digito(digito = "0", posicion = posiUni)]
	
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