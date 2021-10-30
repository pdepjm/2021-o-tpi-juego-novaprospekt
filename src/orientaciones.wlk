// Sentido de giro horario

import tuberia.*

object norte {
	method nombreOrientacion() = "Norte"
	method siguiente() = este
}

object este{
	method nombreOrientacion() = "Este"
	method siguiente() = sur
}

object sur {
	method nombreOrientacion() = "Sur"
	method siguiente() = oeste
}

object oeste {
	method nombreOrientacion() = "Oeste"
	method siguiente() = norte
}







/*

object recta {
	method config(x, y, orien) {
		return new TuberiaRecta(posicion = game.at(x,y),orientacion = orien)
	} 

object curva {
	method config(x, y, orien) {
		return new TuberiaCurva(posicion = game.at(x,y),orientacion = orien)
	} 

object triple {
	method config(x, y, orien) {
		return new TuberiaTriple(posicion = game.at(x,y),orientacion = orien)
	} 








	method empezar() {
		
		const nivel1 = new Nivel(tuberias = [
			recta.config(1,2,arriba),
			recta.config(1,2,derecha),
			curva.config(1,2,arriba), 
			recta.config(1,2,abajo),
			recta.config(1,2,arriba)])
	}
}

*/




















