import wollok.game.*

class TuberiaRecta {
	var orientacion = "Vertical"
	var tieneAgua = false
	var posicion
	
	method image(){
		return "tuberia" + orientacion + ".png"
	}
	
	method position() {
		return posicion
	}
	
	method rotar() {
		if (orientacion == "Vertical") orientacion = "Horizontal" else orientacion = "Vertical"
	}
	
	method cambiarPosicion(posicionX, posicionY) {
		posicion = game.at(posicionX, posicionY)
	}
	
	method pasarAgua(){
		tieneAgua = true
	}
	
}
