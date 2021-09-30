import direcciones.*
import wollok.game.*

object cursor {
	var posicion = game.center()

	method image() = "cursor.png"
	
	method position() {
		return posicion
	} 
	
	method posicion(unaPosicion) {
		posicion = unaPosicion
	}
	method moverPara(direccion) {
		posicion = direccion.proximaPosicion(posicion) 
	}
	method rotar() {
		game.colliders(self).first().rotar()
	}
	
}
