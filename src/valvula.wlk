class Valvula {
	
	var estaAbierto = false
	const posicion
	
	method image() = "valvula_" + estaAbierto.toString() + ".png"
	
	method position() = posicion
}
