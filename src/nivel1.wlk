import wollok.game.*
import tuberiaRecta.*
import tuberiaCurva.*
import cursor.*
import direcciones.*
import valvula.*

object nivel1 {
	const segundosEnLlenar = 2
	
	method configuracionInicial(){
		//Agrego unas tuberias de prueba
		const tuberia1 = new TuberiaRecta(posicion = game.at(0,5),orientacion = "Horizontal")
		game.addVisual(tuberia1)
		const tuberia2 = new TuberiaRecta(posicion = game.at(1,5),orientacion = "Horizontal")
		game.addVisual(tuberia2)
		const tuberia3 = new TuberiaRecta(posicion = game.at(2,5),orientacion = "Vertical")
		game.addVisual(tuberia3)
		const tuberia4 = new TuberiaCurva(posicion = game.at(3,5),orientacion = "AbajoDerecha")
		game.addVisual(tuberia4)
		const tuberia5 = new TuberiaCurva(posicion = game.at(3,6),orientacion = "ArribaDerecha")
		game.addVisual(tuberia5)
		const tuberia6 = new TuberiaRecta(posicion = game.at(4,6),orientacion = "Horizontal")
		game.addVisual(tuberia6)
		const tuberia7 = new TuberiaCurva(posicion = game.at(5,6),orientacion = "AbajoDerecha")
		game.addVisual(tuberia7)
		const tuberia8 = new TuberiaCurva(posicion = game.at(5,7),orientacion = "AbajoDerecha")
		game.addVisual(tuberia8)
		
		//const valvula = new Valvula(posicion = game.at(6,8))
		//game.addVisual(valvula)
		
		//Agrego el cursor de juego
		game.addVisual(cursor)
		self.configurarTeclas()
		self.empezarNivel(tuberia1)
		
		
	}
	
	//Configuro las teclas para moverse y para interactuar
	method configurarTeclas(){
		//Utiliza un metodo del cursor para moverlo
		keyboard.left().onPressDo({ cursor.moverPara(izquierda) })
		keyboard.right().onPressDo({ cursor.moverPara(derecha) })
		keyboard.up().onPressDo({ cursor.moverPara(arriba) })
		keyboard.down().onPressDo({ cursor.moverPara(abajo) })
		
		//Utiliza un metodo del cursor para interactuar con las tuberias
		keyboard.space().onPressDo({cursor.rotar()})
		
	}
	
	//Comienzo el nivel con la tuberia especificada como la primera (la que ya tiene agua)
	method empezarNivel(primeraTuberia){
		primeraTuberia.pasarAgua()
	}
	
	method tiempoLlenado() = return segundosEnLlenar * 1000
	
}
