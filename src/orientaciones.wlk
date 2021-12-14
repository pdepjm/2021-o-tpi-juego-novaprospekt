// Sentido de giro horario

import direcciones.*

object norte {
	method nombre() = "Norte"
	method siguiente() = este
	
	method direccionAsociada() = arriba
	method direccionHorario() = derecha
	method direccionAntiHorario() = izquierda
	
}

object este{
	method nombre() = "Este"
	method siguiente() = sur
	
	method direccionAsociada() = derecha
	method direccionHorario() = abajo
	method direccionAntiHorario() = arriba
}

object sur {
	method nombre() = "Sur"
	method siguiente() = oeste
	
	method direccionAsociada() = abajo
	method direccionHorario() = izquierda
	method direccionAntiHorario() = derecha
}

object oeste {
	method nombre() = "Oeste"
	method siguiente() = norte
	
	method direccionAsociada() = izquierda
	method direccionHorario() = arriba
	method direccionAntiHorario() = abajo
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




















