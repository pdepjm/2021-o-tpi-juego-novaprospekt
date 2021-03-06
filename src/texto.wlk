import wollok.game.*

// ¡Los visuales también pueden ser texto!
// Hay que definir la posición en la que debe aparecer
// Y el texto que se debe mostrar. Para eso debe implementar el método text()
// el cual debe devolver un string
// Por defecto el color es azul, pero se puede modificar
// Para ello debe entender el mensaje textColor()
// El método debe devolver un string que represente el color
// Debe ser en un formato particular: tiene que ser un valor RGBA en hexa "rrggbbaa"
// Les dejamos algunos ejemplos
// ¡También se puede combinar con las imágenes!

object monitor {
	const posiMonitorX = 4
	const posiMonitorY = 0
	const monitor = new Texto(posicion = game.at(posiMonitorX, posiMonitorY), texto = "")
	const monitor2 = new Texto(posicion = game.at(posiMonitorX, posiMonitorY), texto = "")
	
	method inicializar() {
		game.addVisual(monitor)
		game.addVisual(monitor2)
	}
	
	method imprimir(texto, otroTexto) {
		const texto2 = "\n" + otroTexto
		monitor.agregarTexto(texto)
		monitor2.agregarTexto(texto2)
	}
}

class Texto {
	var texto
	var posicion
	
	method position() = posicion
	
	method text() = texto
	
	method agregarTexto(nuevoTexto) {
		texto = nuevoTexto
	}
	
	method textColor() = paleta.blanco()
}

object paleta {
	method verde() = "00FF00FF"
	method rojo() = "FF0000FF"
	method blanco() = "FFFFFFFF"
}
