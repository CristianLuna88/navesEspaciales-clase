class NaveEspacial {

	var property velocidad = 0
	var property direccion = 0
	var combustible = 0

	method acelerar(cuanto) {
		velocidad = (velocidad + cuanto).min(100000)
	}

	method desacelerar(cuanto) {
		velocidad = (velocidad - cuanto).min(100000)
	}

	method irHaciaElSol() {
		direccion = 10
	}

	method escaparDelSol() {
		direccion = -10
	}

	method ponerseParaleloAlSol() {
		direccion = 0
	}

	method acercarseUnPocoAlSol() {
		direccion += 1
	}

	method alejarseUnPocoDelSol() {
		direccion -= 1
	}

	method prepararViaje() {
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}

	method combustibleDisponible() {
		return combustible
	}

	method cargarCombustible(cantidad) {
		combustible += cantidad
	}

	method descargarCombustible(cantidad) {
		combustible = (combustible - cantidad).max(0)
	}

	method estaTranquila() {
		return combustible >= 4000 and velocidad <= 12000
	}

	method recibirAmenaza() {
		self.escapar()
		self.avisar()
	}

	method escapar()

	method avisar()

	method estaDeRelajo() {
		return self.estaTranquila() and self.tienePocaActividad()
	}

	method tienePocaActividad()

}

class NaveBaliza inherits NaveEspacial {

	var color = "azul"
	const property cambiosDeColor = []

	method color() {
		return color
	}

	method cambiarColorDeBaliza(colorNuevo) {
		color = colorNuevo
		cambiosDeColor.add(colorNuevo)
	}

	override method prepararViaje() {
		super()
		self.cambiarColorDeBaliza("verde")
		self.ponerseParaleloAlSol()
	}

	override method estaTranquila() {
		return super() and color != "rojo"
	}

	override method escapar() {
		self.irHaciaElSol()
	}

	override method avisar() {
		self.cambiarColorDeBaliza("rojo")
	}

	override method tienePocaActividad() {
		return cambiosDeColor.isEmpty()
	}

}

class NaveDePasajeros inherits NaveEspacial {

	var property pasajeros = 0
	var racionDeComida = 0
	var racionDeBebidas = 0
	var racionesDeComidaServida = 0

	method racionesDeComida() {
		return racionDeComida
	}

	method cargarRacionDeComida(cantidad) {
		racionDeComida += cantidad
	}

	method racionesDeBebida() {
		return racionDeBebidas
	}

	method cargarRacionDeBebidad(cantidad) {
		racionDeBebidas += cantidad
	}

	method descargarRacionDeComida(cantidad) {
		racionDeComida = (racionDeComida - cantidad).max(0)
		racionesDeComidaServida += cantidad
	}

	method descargarRacionDeBebida(cantidad) {
		racionDeBebidas = (racionDeBebidas - cantidad).max(0)
	}

	override method prepararViaje() {
		super()
		self.cargarRacionDeComida(pasajeros * 4)
		self.cargarRacionDeBebidad(pasajeros * 6)
		self.acercarseUnPocoAlSol()
	}

	override method escapar() {
		velocidad *= 2
	}

	override method avisar() {
		self.descargarRacionDeComida(pasajeros)
		self.descargarRacionDeBebida(pasajeros * 2)
	}

	override method tienePocaActividad() {
		return racionesDeComidaServida < 50
	}

}

class NaveDeCombate inherits NaveEspacial {

	var estaInvisible = false
	var misilesDesplegados = false
	const mensajesEmitidos = []

	method estaInvisible() {
		return estaInvisible
	}

	method ponerseVisible() {
		estaInvisible = true
	}

	method ponerseInvisible() {
		estaInvisible = false
	}

	method desplegarMisiles() {
		misilesDesplegados = true
	}

	method replegarMisiles() {
		misilesDesplegados = false
	}

	method misilesDesplegados() {
		return misilesDesplegados
	}

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}

	method mensajesEmitidos() {
		return mensajesEmitidos
	}

	method primerMensajeEmitido() {
		mensajesEmitidos.first()
	}

	method ultimoMensajeEmitido() {
		mensajesEmitidos.last()
	}

	method esEscueta() {
		return mensajesEmitidos.all{ mensaje => mensaje.size() <= 30 }
	}

	method emitioMensaje(mensaje) {
		mensajesEmitidos.contains(mensaje)
	}

	override method prepararViaje() {
		self.replegarMisiles()
		super()
		self.acelerar(15000)
		self.emitirMensaje("Saliendo en mision")
	}

	override method estaTranquila() {
		return super() and misilesDesplegados == false // no me gusta, ver  
	}

	override method escapar() {
		self.acercarseUnPocoAlSol()
		self.acercarseUnPocoAlSol()
	}

	override method avisar() {
		self.emitirMensaje("Amenaza recibida")
	}

	override method tienePocaActividad() {
		return self.esEscueta()
	}

}

class NaveHospital inherits NaveDePasajeros {

	var property quirofanosPreparados = false

	override method estaTranquila() {
		return super() and quirofanosPreparados == false
	}

	method prepararQuirofanos() {
		quirofanosPreparados = true
	}

	override method recibirAmenaza() {
		super()
		self.prepararQuirofanos()
	}

}

class NaveDeCombateSigilosa inherits NaveDeCombate {

	override method estaTranquila() {
		return super() and estaInvisible == false
	}

	override method recibirAmenaza() {
		super()
		self.desplegarMisiles()
		self.ponerseVisible()
	}

}

