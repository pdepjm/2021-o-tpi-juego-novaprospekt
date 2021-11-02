import wollok.game.*

object izquierda {
	method proximaPosicion(posicionActual) {
		if (posicionActual.x() > 0) return posicionActual.left(1) else return posicionActual
	}
	method opuesto() = derecha
}

object derecha {
	method proximaPosicion(posicionActual) {
		if (posicionActual.x() < 9) return posicionActual.right(1) else return posicionActual
	}
	method opuesto() = izquierda
}

object arriba {
	method proximaPosicion(posicionActual) {
		if (posicionActual.y() < 9) return posicionActual.up(1) else return posicionActual
	}
	method opuesto() = abajo
}

object abajo {
	method proximaPosicion(posicionActual) {
		if (posicionActual.y() > 0) return posicionActual.down(1) else return posicionActual
	}
	method opuesto() = arriba
}
