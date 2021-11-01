import nivel.*
import tuberiaCurva.*
import tuberiaRecta.*
import tuberiaIO.*
import tuberiaT.*
import tuberiaCruz.*
import wollok.game.*
import orientaciones.*

object managerDeNiveles {
	

	method configurarNiveles() {
		const nivel1 = new Nivel(tuberias = [
			new TuberiaInicial(posicion = game.at(0,2), puntoCardinal = este),
			new TuberiaRecta(posicion = game.at(1,2), puntoCardinal = norte),
			new TuberiaRecta(posicion = game.at(2,2), puntoCardinal = este),
			new TuberiaCurva(posicion = game.at(3,2), puntoCardinal = sur),
			new TuberiaRecta(posicion = game.at(3,3), puntoCardinal = norte),
			new TuberiaCurva(posicion = game.at(3,4), puntoCardinal = sur),
			new TuberiaT(posicion = game.at(4,4), puntoCardinal = oeste),
			new TuberiaCurva(posicion = game.at(4,5), puntoCardinal = sur),
			new TuberiaRecta(posicion = game.at(5,4), puntoCardinal = norte),
			new TuberiaRecta(posicion = game.at(5,5), puntoCardinal = este),
			new TuberiaFinal(posicion = game.at(6,4), puntoCardinal = este),
			new TuberiaFinal(posicion = game.at(6,5), puntoCardinal = este)
		])
		
		nivel1.configuracionInicial()
	}
	
}
