import wollok.game.*
import nivel1.*

class Tuberia {
	// Defino las variables que van a tener todas las tuberias
	var orientacion
	var tieneAgua = false
	const posicion
	
	//La imagen cambia segun la orientacion y si tiene agua o no
	method image(){
		return "tuberia" + orientacion + tieneAgua.toString() + ".png"
	}
	
	method position() {
		return posicion
	}
	
	method tieneAgua(){
		return tieneAgua
	}
	
	// Llena la tuberia de agua y luego de cierto tiempo le pasa el agua a la tuberia adyacente, cambia segun el tipo de tuberia
	method pasarAgua() {
		tieneAgua = true
		return game.schedule(nivel1.tiempoLlenado(), { self.llenarProximaTuberia() })
	}
	
	/*
	method llenar(){
		tieneAgua = true
	}*/
	
	method llenarProximaTuberia()
}
