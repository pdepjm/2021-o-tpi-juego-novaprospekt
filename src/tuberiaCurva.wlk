import wollok.game.*
import tuberia.*


class TuberiaCurva inherits Tuberia{
	
	//Metodo para rotar, distinto del de la otra tuberia
	method rotar() {
		if (self.tieneAgua().negate()){
			if (orientacion == "AbajoDerecha") orientacion = "AbajoIzquierda" else
			if (orientacion == "AbajoIzquierda") orientacion = "ArribaIzquierda" else
			if (orientacion == "ArribaIzquierda") orientacion = "ArribaDerecha" else orientacion = "AbajoDerecha"
		}
	}
	
	//Chequea si puede recibir agua de una direccion especifica, cambia segun el tipo de tuberia
	method puedeRecibirDe(direccion){
		if(
			(orientacion.equals("AbajoDerecha") && (direccion.equals("Abajo") || direccion.equals("Derecha")))
			||
			(orientacion.equals("AbajoIzquierda") && (direccion.equals("Abajo") || direccion.equals("Izquierda")))
			||
			(orientacion.equals("ArribaIzquierda") && (direccion.equals("Arriba") || direccion.equals("Izquierda")))
			||
			(orientacion.equals("ArribaDerecha") && (direccion.equals("Arriba") || direccion.equals("Derecha")))
		){
			return !(self.tieneAgua())
		} else return false
		
	}
	
	// Llena con agua, si puede, a una tuberia adyacente. Caso contrario, GAME OVER
	// MEJORAR LOGICA EN LO POSIBLE
	override method llenarProximaTuberia() {
		//Si la orientacion es abajo+derecha por ejemplo, chequea si las tuberias de abajo/derecha pueden recibir agua por los lados contrarios (son adyacentes)
		//De ser este el caso, pasa el agua y la siguiente tuberia pasa a ser la encargada de pasar el agua
		if (orientacion == "AbajoDerecha"){
			const abajo = game.getObjectsIn(posicion.down(1))
			const derecha = game.getObjectsIn(posicion.right(1))
			if(abajo.isEmpty().negate() && abajo.head().puedeRecibirDe("Arriba")){
				abajo.head().pasarAgua()
			}else if(derecha.isEmpty().negate() && derecha.head().puedeRecibirDe("Izquierda")){
				derecha.head().pasarAgua()
			}else
			//gameover
			game.say(self, "GAMEOVER")
		}else if (orientacion == "AbajoIzquierda"){
			const abajo = game.getObjectsIn(posicion.down(1))
			const izquierda = game.getObjectsIn(posicion.left(1))
			if(abajo.isEmpty().negate() && abajo.head().puedeRecibirDe("Arriba")){
				abajo.head().pasarAgua()
			}else if(izquierda.isEmpty().negate() && izquierda.head().puedeRecibirDe("Derecha")){
				izquierda.head().pasarAgua()
			}else
			//gameover
			game.say(self, "GAMEOVER")
		}else if (orientacion == "ArribaIzquierda"){
			const arriba = game.getObjectsIn(posicion.up(1))
			const izquierda = game.getObjectsIn(posicion.left(1))
			if(arriba.isEmpty().negate() && arriba.head().puedeRecibirDe("Abajo")){
				arriba.head().pasarAgua()
			}else if(izquierda.isEmpty().negate() && izquierda.head().puedeRecibirDe("Derecha")){
				izquierda.head().pasarAgua()
			}else
			//gameover
			game.say(self, "GAMEOVER")
		}else if (orientacion == "ArribaDerecha"){
			const arriba = game.getObjectsIn(posicion.up(1))
			const derecha = game.getObjectsIn(posicion.right(1))
			if(arriba.isEmpty().negate() && arriba.head().puedeRecibirDe("Abajo")){
				arriba.head().pasarAgua()
			}else if(derecha.isEmpty().negate() && derecha.head().puedeRecibirDe("Izquierda")){
				derecha.head().pasarAgua()
			}else
			//gameover
			game.say(self, "GAMEOVER")
		}
	}
}
