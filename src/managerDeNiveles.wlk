import nivel.*
import tuberiaCurva.*
import tuberiaRecta.*
import wollok.game.*
import orientaciones.*

object managerDeNiveles {
	

	method configurarNiveles() {
		const nivel1 = new Nivel(tuberias = [
			new TuberiaRecta(posicion = game.at(0,2), puntoCardinal = este),
			new TuberiaRecta(posicion = game.at(1,2), puntoCardinal = norte),
			new TuberiaRecta(posicion = game.at(2,2), puntoCardinal = este),
			new TuberiaCurva(posicion = game.at(3,2), puntoCardinal = sur),
			new TuberiaRecta(posicion = game.at(3,3), puntoCardinal = norte),
			new TuberiaCurva(posicion = game.at(3,4), puntoCardinal = sur)
		])
		
		nivel1.configuracionInicial()
	}
	
}
