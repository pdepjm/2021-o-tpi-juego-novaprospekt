import wollok.game.*
import cursor.*
import direcciones.*

class Nivel {
	
	const segundosEnLlenar = 5
	var tuberias
	
	method configuracionInicial(){
		tuberias.forEach({tuberia => game.addVisual(tuberia)})
		
		//Agrego el cursor de juego
		game.addVisual(cursor)
		self.configurarTeclas()
		self.empezarNivel(tuberias.first())
		
		
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
		primeraTuberia.recibirAgua(self.tiempoLlenado())
	}
	
	method tiempoLlenado() = segundosEnLlenar * 1000
}



