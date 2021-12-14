import wollok.game.*
import cursor.*
import direcciones.*
import orientaciones.*
import menu.*
import tuberia.*
import tuberiaRecta.*
import tuberiaCruz.*
import tuberiaCurva.*
import tuberiaIO.*
import tuberiaT.*
import managerDeNiveles.*

object tuboRecto {
	method nombre() = "Recta"
	method siguienteTipo() = tuboCurvo
	method crearElemento(unaPosicion, unaOrientacion) = new TuberiaRecta(posicion = unaPosicion, puntoCardinal = unaOrientacion)
}

object tuboCurvo {
	method nombre() = "Curva"
	method siguienteTipo() = tuboCruz
	method crearElemento(unaPosicion, unaOrientacion) = new TuberiaCurva(posicion = unaPosicion, puntoCardinal = unaOrientacion)
}

object tuboCruz {
	method nombre() = "Cruz"
	method siguienteTipo() = tuboT
	method crearElemento(unaPosicion, unaOrientacion) = new TuberiaCruz(posicion = unaPosicion, puntoCardinal = unaOrientacion)
}

object tuboT {
	method nombre() = "T"
	method siguienteTipo() = tuboInicial
	method crearElemento(unaPosicion, unaOrientacion) = new TuberiaT(posicion = unaPosicion, puntoCardinal = unaOrientacion)
}

object tuboInicial {
	method nombre() = "Inicial"
	method siguienteTipo() = tuboFinal
	method crearElemento(unaPosicion, unaOrientacion) = new TuberiaInicial(posicion = unaPosicion, puntoCardinal = unaOrientacion)
}

object tuboFinal {
	method nombre() = "Final"
	method siguienteTipo() = tuboAdorno
	method crearElemento(unaPosicion, unaOrientacion) = new TuberiaFinal(posicion = unaPosicion, puntoCardinal = unaOrientacion)
}

object tuboAdorno {
	method nombre() = "Adorno"
	method siguienteTipo() = vacio
	method crearElemento(posicion, orientacion) = 5 // TODO
}

object vacio {
	method nombre() = "vacio"
	method siguienteTipo() = tuboRecto
	method crearElemento(posicion, orientacion) = false
}


class TuberiaReferencia inherits Tuberia {
	var tipoActual
	var elementoReferencia
	
	method siguienteTipo() {
		tipoActual = tipoActual.siguienteTipo()
	}
	
	method crearTuberia() {
		if (tipoActual.nombre() == "vacio") {
			throw new DomainException(message = "NO HAY TUBERIA SELECCIONADA")
		}
		
		return tipoActual.crearElemento(elementoReferencia.position(), self.puntoCardinal())	
	}
	
	override method image() = if (self.tipoTuberia() == "vacio") "vacio.png" else super()
	
	override method position() = elementoReferencia.position()
	
	override method tipoTuberia() = tipoActual.nombre()
	
	override method ubicacionPuertos() = []
}

object editorDeNiveles {
	//const listaElementos = elementos.generarElementos()
	const cursor = new Cursor()
	const elemento = new TuberiaReferencia(posicion = cursor.position(), puntoCardinal = norte, tipoActual = vacio, elementoReferencia = cursor)
	
	var entradas = []
	var salidas = []
	var tuberias = []
	
	
	method editarNivel() {
		
	}
	
	method configurarTeclas(){
		keyboard.left().onPressDo({ cursor.moverPara(izquierda) })
		keyboard.right().onPressDo({ cursor.moverPara(derecha) })
		keyboard.up().onPressDo({ cursor.moverPara(arriba) })
		keyboard.down().onPressDo({ cursor.moverPara(abajo) })
		
		keyboard.space().onPressDo({ self.rotarElemento() })
		keyboard.q().onPressDo({ self.siguienteElemento() })
		keyboard.e().onPressDo({ self.colocarElemento() })
		keyboard.r().onPressDo({ self.quitarElemento() })
		
		keyboard.enter().onPressDo({ self.probarNivel() })
		
		keyboard.backspace().onPressDo({ self.volverAlMenu() })
	}
	
	method rotarElemento() {
		elemento.siguientePuntoCardinal()
	}
	
	method siguienteElemento() {
		elemento.siguienteTipo()
	}
	
	method colocarElemento() {
		const objetos = game.colliders(cursor)
		
		if (not objetos.isEmpty()) {
			// MOSTRARLO EN EL MONITOR - YA EXISTE UNA TUBERIA EN ESTA POSICION 
		} else {
			try {
				const tuberia = elemento.crearTuberia()
				game.addVisual(tuberia)
				self.guardarTuberia(tuberia)
			} catch e : DomainException {
				// MOSTRARLO EN EL MONITOR - NINGUNA TUBERIA SELECCIONADA
			}
		}
	}
	
	method quitarElemento() {
		const unasTuberias = game.colliders(cursor)
		
		if (unasTuberias.isEmpty()) {
			// NO EXISTE UNA TUBERIA EN ESTA POSICION - MOSTRARLO EN EL MONITOR
		} else {
			game.removeVisual(unasTuberias.first())
			self.quitarTuberia(unasTuberias.first())
		}
	}
	
	method probarNivel() {
		
	}
	
	method volverAlMenu() {
		game.clear()
		menu.mostrar()
	}
	
	// Repeticion de logica
	method quitarTuberia(tuberia) {
		if (tuberia.tipoTuberia() == "Inicial") {
			entradas.remove(tuberia)
		} else if (tuberia.tipoTuberia() == "Final") {
			salidas.remove(tuberia)
		} else {
			tuberias.remove(tuberia)
		}
	}
	
	// Repeticion de logica
	method guardarTuberia(tuberia) {
		if (tuberia.tipoTuberia() == "Inicial") {
			entradas.add(tuberia)
		} else if (tuberia.tipoTuberia() == "Final") {
			salidas.add(tuberia)
		} else {
			tuberias.add(tuberia)
		}
	}
}
