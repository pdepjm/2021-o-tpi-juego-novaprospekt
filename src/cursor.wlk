import direcciones.*
import wollok.game.*

// cursor.moverPara(direccion)
// cursor.usar()

class Cursor {
	var posicion = game.center()

	method image() = "cursor.png"
	
	method position() = posicion
	
	method posicion(unaPosicion) {
		posicion = unaPosicion
	}
	
	method moverPara(direccion) {
		posicion = direccion.proximaPosicion(posicion) 
	}
	
	method usar() {
		const tuberias = game.colliders(self)
		
		if (not tuberias.isEmpty()) {
			tuberias.first().accionar()
		}
	}
}
