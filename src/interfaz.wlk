import wollok.game.*

object pj {
	method position() = game.at(10, 0)
	method image() = "pj.png"
}

object baseMonitoreo {
	method position() = game.at(0,0)
	method image() = "plantilla.png"
}

object barraSuperior {
	method position() = game.at(0,14)
	
	method image() = "barraSuperior.png"
}

object luzRoja {
	method position() = game.at(0,0)
	
	method image() = "luzRoja_true.png"
}

object luzVerde {
	method position() = game.at(0,1)
	
	method image() = "luzVerde_true.png"
}