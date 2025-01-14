/*
 * Los sabores
 */
object frutilla { }
object chocolate { }
object vainilla { }
object naranja { }
object limon { }


/*
 * Golosinas
 */
 class Golosina {
 	var sabor
 	method sabor() = sabor
 	method libreDeGluten() = true
 }
 
class Bombon inherits Golosina {
	var peso = 15
	
	method initialize() {
		sabor = chocolate
	}
	
	method precio() { return 5 }
	method peso() { return peso }
	method mordisco() { peso = peso * 0.8 - 1 }
	method libreGluten() { return true }
}

class BombonDuro inherits Bombon {
	
	method initialize() {
		super()
	}
		
	override method mordisco() { peso -= 1 }
	method dureza() {
		if (peso > 12) return 3
		else if (peso.between(8, 12)) return 2
		else return 0
	}
}

class Alfajor inherits Golosina{
	var peso = 15
	
	method precio() { return 12 }
	method peso() { return peso }
	method mordisco() { peso = peso * 0.8 }
	method libreGluten() { return false }
}

class Caramelo inherits Golosina {
	var peso = 5

	method precio() { return 12 }
	method peso() { return peso }
	method mordisco() { peso = peso - 1 }
	method libreGluten() { return true }
}

class CarameloRelleno inherits Caramelo {
	override method mordisco() {
		super()
		sabor = chocolate
	}
}

class Chupetin inherits Golosina {
	var peso = 7
	
	method precio() { return 2 }
	method peso() { return peso }
	method mordisco() { 
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}
	method libreGluten() { return true }
}

class Oblea inherits Golosina {
	var peso = 250
	
	method precio() { return 5 }
	method peso() { return peso }
	method mordisco() {
		if (peso >= 70) {
			// el peso pasa a ser la mitad
			peso = peso * 0.5
		} else { 
			// pierde el 25% del peso
			peso = peso - (peso * 0.25)
		}
	}
	method libreGluten() { return false }
}

class ObleaCrujiente inherits Oblea {
	var cantidadMordiscos = 0
	
	method estaDebil() = cantidadMordiscos > 3
	
	override method mordisco() {
		super()
		if (!self.estaDebil()) peso -= 3
		cantidadMordiscos += 1
	}
}

class Chocolatin inherits Golosina {
	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var pesoInicial
	var comido = 0
	
	method initialize() {
		sabor = chocolate
	}
	
	method pesoInicial(unPeso) { pesoInicial = unPeso }
	method precio() { return pesoInicial * 0.50 }
	method peso() { return (pesoInicial - comido).max(0) }
	method mordisco() { comido = comido + 2 }
	method libreGluten() { return false }

}

class ChocolatinVIP inherits Chocolatin {
	var humedad
	method humedad() = humedad
	method peso() = (pesoInicial - comido) * (1 + humedad)
}

class ChocolatinPremium inherits ChocolatinVIP {
	override method humedad() = humedad / 2
}

class GolosinaBaniada {
	var golosinaInterior
	var pesoBanio = 4
	
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	method precio() { return golosinaInterior.precio() + 2 }
	method peso() { return golosinaInterior.peso() + pesoBanio }
	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
	method sabor() { return golosinaInterior.sabor() }
	method libreGluten() { return golosinaInterior.libreGluten() }	
}

class Tuttifrutti inherits Golosina {
	var libreDeGluten
	var saborActual = 0
	
	method mordisco() { saborActual += 1 }	
	method sabor() { return sabor.get(saborActual % 3) }	

	method precio() { return (if(self.libreGluten()) 7 else 10) }
	method peso() { return 5 }
	method libreGluten() { return libreDeGluten }	
	method libreGluten(valor) { libreDeGluten = valor }
}
