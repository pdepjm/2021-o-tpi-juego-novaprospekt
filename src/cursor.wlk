import direcciones.*
import wollok.game.*

object cursor {
	//Arranca en el centro
	var posicion = game.center()

	method image() = "cursor.png"
	
	method position() = posicion
	
	method posicion(unaPosicion) {
		posicion = unaPosicion
	}
	
	//Mueve el cursor hacia una de las 4 direcciones, es utilizado por keyboard
	method moverPara(direccion) {
		posicion = direccion.proximaPosicion(posicion) 
	}
	
	//Este metodo activa el metodo de rotar de la tuberia que se encuentre debajo del cursor
	method usar() {
		const tuberia = game.colliders(self)
		
		// Si existe una tuberia en la posicion del cursor, lo rota
		if (not tuberia.isEmpty()) {
			tuberia.first().accionar()
		}
	}
}
