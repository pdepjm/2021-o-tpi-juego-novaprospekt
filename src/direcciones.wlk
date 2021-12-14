import wollok.game.*

const limiteMinY = 0
const limiteMaxY = 13

const limiteMinX = 0
const limiteMaxX = 11

object izquierda {
	method proximaPosicion(posicionActual) {
		if (posicionActual.x() > limiteMinX) return posicionActual.left(1) else return posicionActual
	}
	method opuesto() = derecha
}

object derecha {
	method proximaPosicion(posicionActual) {
		if (posicionActual.x() < limiteMaxX) return posicionActual.right(1) else return posicionActual
	}
	method opuesto() = izquierda
}

object arriba {
	method proximaPosicion(posicionActual) {
		if (posicionActual.y() < limiteMaxY) return posicionActual.up(1) else return posicionActual
	}
	method opuesto() = abajo
}

object abajo {
	method proximaPosicion(posicionActual) {
		if (posicionActual.y() > limiteMinY) return posicionActual.down(1) else return posicionActual
	}
	method opuesto() = arriba
}
