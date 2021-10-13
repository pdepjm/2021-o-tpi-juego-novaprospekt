import wollok.game.*
import tuberia.*


class TuberiaRecta inherits Tuberia{
	
	//Metodo para rotar, distinto del de la otra tuberia
	method rotar() {
		if (self.tieneAgua().negate()){
			if (orientacion == "Vertical") orientacion = "Horizontal" else orientacion = "Vertical"
		}
	}
	
	//Chequea si puede recibir agua de una direccion especifica, cambia segun el tipo de tuberia
	method puedeRecibirDe(direccion){
		if(
			((direccion.equals("Arriba") || direccion.equals("Abajo")) && orientacion.equals("Vertical"))
			||
			(direccion.equals("Izquierda") || direccion.equals("Derecha")) && orientacion.equals("Horizontal")
		){
			return !(self.tieneAgua())
		} else return false
		
	}
	
	// Llena con agua, si puede, a una tuberia adyacente. Caso contrario, GAME OVER
	// MEJORAR LOGICA EN LO POSIBLE
	override method llenarProximaTuberia() {
		//Si la orientacion es izquierda+derecha por ejemplo, chequea si las tuberias de izquierda/derecha pueden recibir agua por los lados contrarios (son adyacentes)
		//De ser este el caso, pasa el agua y la siguiente tuberia pasa a ser la encargada de pasar el agua
		
		if (orientacion == "Vertical") {
			const arriba = game.getObjectsIn(posicion.up(1))
			const abajo = game.getObjectsIn(posicion.down(1))
			
			if (abajo.isEmpty().negate() && abajo.head().puedeRecibirDe("Arriba")) {
				abajo.head().pasarAgua()
			} else if (arriba.isEmpty().negate() && arriba.head().puedeRecibirDe("Abajo")) {
				arriba.head().pasarAgua()
			} else {
				//gameover
				game.say(self, "GAMEOVER")
			}
		} else {
			const izquierda = game.getObjectsIn(posicion.left(1))
			const derecha = game.getObjectsIn(posicion.right(1))
			
			if (izquierda.isEmpty().negate() && izquierda.head().puedeRecibirDe("Derecha")) {
				izquierda.head().pasarAgua()
			} else if (derecha.isEmpty().negate() && derecha.head().puedeRecibirDe("Izquierda")) {
				derecha.head().pasarAgua()
			}else {
				//gameover
				game.say(self, "GAMEOVER")
			}
		}
	}
}
