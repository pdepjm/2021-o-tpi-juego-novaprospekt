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
	
	method llenar(){
		tieneAgua = true
	}
}
