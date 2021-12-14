import direcciones.*
import wollok.game.*

// cursor.moverPara(direccion)
// cursor.usar()

class Cursor {
	var posicion = game.center()
	var desactivado = false

	method image() = "cursor.png"
	
	method position() = posicion
	
	method posicion(unaPosicion) {
		posicion = unaPosicion
	}
	
	method moverPara(direccion) {
		if (not desactivado)
			posicion = direccion.proximaPosicion(posicion) 
	}
	
	method usar() {
		if (not desactivado) {
			const tuberias = game.colliders(self)
		
			if (not tuberias.isEmpty()) {
				tuberias.first().accionar()
			}
		}
	}
	
	method mostrarse() {
		desactivado = false
		game.addVisual(self)
	}
	
	method eliminarse() {
		if (not desactivado) {
			desactivado = true
			game.removeVisual(self)
		}
	}
}
