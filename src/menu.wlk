import wollok.game.*
import direcciones.*
import managerDeNiveles.*
import editorDeNiveles.*
import texto.*

object menu {
	const opciones = [empezarPartida, crearNivel]
	
	method mostrar() {	
		game.clear()
		
		opciones.forEach({ opcion => game.addVisual(opcion) })
		
		game.addVisual(selector)
		selector.asignarOpcion(opciones.first())
		
		keyboard.up().onPressDo({ selector.siguienteOpcion() })
		keyboard.down().onPressDo({ selector.siguienteOpcion() })
		
		keyboard.enter().onPressDo({selector.seleccionar()})
	}
}

object selector {
	const posicion = game.at(3,5)
	var opcionActual
	
	method position() = posicion
	
	method asignarOpcion(opcion) {
		opcionActual = opcion
		opcionActual.marcar()
	} 
	
	method siguienteOpcion() {
		opcionActual.desmarcar()
		opcionActual = opcionActual.proximaOpcion()
		opcionActual.marcar()
	}
	
	method seleccionar() {
		opcionActual.elegir()
	}
}

object empezarPartida {
	const posicion = game.at(3,5)
	var estaSeleccionado = false
	
	method position() = posicion
	
	method image() = "opcionJugar_" + estaSeleccionado.toString() + ".png"
	
	method proximaOpcion() = crearNivel
	
	method marcar() {
		estaSeleccionado = true
	}
	
	method desmarcar() {
		estaSeleccionado = false
	}
	
	method elegir() {
		game.clear()
		partidaPrincipal.inicializar()
	}
}

object crearNivel {
	const posicion = game.at(3,3)
	var estaSeleccionado = false
	
	method position() = posicion
	
	method proximaOpcion() = empezarPartida
	
	method image() = "opcionCrear_" + estaSeleccionado.toString() + ".png"
	
	method marcar() {
		estaSeleccionado = true
	}
	
	method desmarcar() {
		estaSeleccionado = false
	}
	
	method elegir() {
		const texto = new Texto(texto = "En desarrollo...", posicion = game.at(5,0))
		texto.mostrar()
		//game.clear()
		//editorDeNiveles.editarNivel()
	}
}