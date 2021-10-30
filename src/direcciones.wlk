import wollok.game.*

object izquierda {
	method proximaPosicion(posicionActual) = posicionActual.left(1)
	method opuesto() = derecha
}

object derecha {
	method proximaPosicion(posicionActual) = posicionActual.right(1)
	method opuesto() = izquierda
}

object arriba {
	method proximaPosicion(posicionActual) = posicionActual.up(1)
	method opuesto() = abajo
}

object abajo {
	method proximaPosicion(posicionActual) = posicionActual.down(1)
	method opuesto() = arriba
}