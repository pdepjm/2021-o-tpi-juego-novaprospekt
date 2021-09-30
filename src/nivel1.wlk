import wollok.game.*
import tuberiaRecta.*
import cursor.*
import direcciones.*

object nivel1 {
	method configuracionInicial(){
		//Agrego una tuberia de prueba
		const tuberia1 = new TuberiaRecta(posicion = game.at(0,3))
		game.addVisual(tuberia1)
		const tuberia2 = new TuberiaRecta(posicion = game.at(0,4))
		game.addVisual(tuberia2)
		const tuberia3 = new TuberiaRecta(posicion = game.at(1,4))
		game.addVisual(tuberia3)
		game.addVisual(cursor)
		self.configurarTeclas()
		
		
		
	}
	
	method configurarTeclas(){
		keyboard.left().onPressDo({ cursor.moverPara(izquierda) })
		keyboard.right().onPressDo({ cursor.moverPara(derecha) })
		keyboard.up().onPressDo({ cursor.moverPara(arriba) })
		keyboard.down().onPressDo({ cursor.moverPara(abajo) })
		
		//Agrego controles basicos para rotar
		keyboard.space().onPressDo({cursor.rotar()})
		
	}
	
}
