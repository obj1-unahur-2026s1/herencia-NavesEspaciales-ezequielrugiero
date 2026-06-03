class Nave{
    var velocidad = 0
    var direccion = 0
    var combustible = 0

    
    method cargarCombutible (unValor){
        combustible += unValor
    }
    method descargarCombustible(unValor){
        combustible = combustible + unValor
    }
    method acelerar(cuanto){
        velocidad = velocidad + cuanto
    }
    method desacelerar(cuanto){
       velocidad = velocidad - cuanto 
    }

    method irHaciaElSol(){
        direccion = 10
    }

    method escaparDelSol(){
        direccion = -10
    }

    method ponerseParleloAlSol(){
        direccion = 0
    }
    method acercarseUnPocoAlSol(){
        direccion = (direccion +1).min(10)
    }
    method alejarseUnPocoDelSol(){
        direccion = (direccion -1).max(-10)
    }
    method preparaViaje(){
        self.cargarCombutible(30000)
        self.acelerar(5000)
    }
    method estaTranquila(){
        return 
        combustible > 4000 && velocidad <= 12000 && self.condicionAdicionl()

    }

    method condicionAdicionl()

    method recibirAmenazas(){
         self.escapar() &&  self.avisar()
    }
    method escapar()
    method avisar()

    method estaDeRelajo() {
        return self.estaTranquila() 
        && self.tienePocaAdtividad() 
      
    }

    method tienePocaAdtividad(){
        return true
    }
   

}
// con la palabra inherits hace que una clase herede los metodos de otra clase nombra despues de la palabra
class NaveBaliza inherits Nave{
   var baliza 
   var cambiarDeColor = false 
   method cambiarColorBaliza(unColor){
        baliza = unColor
        cambiarDeColor = true
   }
   method baliza()= baliza   
   // con el override se sobre escribe el metodo
   // con el super() la clase hija hace primero lo que hace la clase padre 
   override method preparaViaje(){
       super() 
       self.cambiarColorBaliza("Verde")
       self.ponerseParleloAlSol()
    }
   override method condicionAdicionl()
        {return baliza != "rojo"}
   
   override method escapar() 
        {self.irHaciaElSol()}
   override method avisar() {
        self.cambiarColorBaliza("rojo")
    }
    override method tienePocaAdtividad() = cambiarDeColor
     
        
}

class NavePasajeros inherits Nave{
    var pasajeros
    var comida
    var bebida
    var cantidadRacionesComidaServidas = 0

    method cargarComida(unValor){
        comida += unValor
    }
    method cargaBebida(unValor){
        bebida += unValor
    }
    method descargaComida(unValor){
        comida = (comida - unValor).max(0)
        cantidadRacionesComidaServidas += unValor
    }
    method descargarBebida(unValor){
        bebida =(bebida - unValor).max(0)

    }
    override method preparaViaje(){
        super()
        self.cargarComida(4 * pasajeros)
        self.cargaBebida(6 * pasajeros)
        self.acercarseUnPocoAlSol()
    }

    override method condicionAdicionl() = true

    override method escapar() 
        {self.acelerar(velocidad)}
    override method avisar() {
        self.descargaComida(1 * pasajeros)

    }
    override method tienePocaAdtividad(){
        return cantidadRacionesComidaServidas < 50
    }       


}

class NaveDeCombate inherits Nave{
    var estaVisible = true
    var misilesDesplegados = false
    const mensajes = []
    method ponerseVisible(){
        estaVisible = true
    }
    method ponerseInvisible(){
        estaVisible = false
    }


    method desplegarMisiles(){misilesDesplegados = true}
    method misilesDesplegados() = misilesDesplegados
    method emitirMensajes(unMesajes){mensajes.add(unMesajes)}
    method primerMensajesEmitido()= mensajes.first()
    method ultimoMensajesEmitido()= mensajes.last()
    method esEscueta() = !mensajes.any({m=>m.leght()> 30})
    override method preparaViaje(){
        super()
        self.ponerseVisible()
        self.desplegarMisiles()
        self.acelerar(15000)
        self.emitirMensajes("Saliendo en mision")

    }
    override method condicionAdicionl() = !misilesDesplegados

     override method escapar() 
        {
            self.acercarseUnPocoAlSol()
            self.acercarseUnPocoAlSol()
          }
    override method avisar() {
        self.emitirMensajes("Amenaza Recibida")
    }

}

class NaveHospital inherits NavePasajeros{
    var tienePreparadoQuirofanos = false
    method tienePreparadoQuirofanos() = tienePreparadoQuirofanos

    method prepararQuirofano(){tienePreparadoQuirofanos= true}
    method inhabilitarQuirofano(){tienePreparadoQuirofanos= false}
    override method condicionAdicionl()
        {return 
          ! self.tienePreparadoQuirofanos()   
        }
    override method recibirAmenazas(){
        super() 
        self.prepararQuirofano()   
        }    

}
// los metodos se puede sobre escribir, pero los atributos no se puede sobre escribir.-
class NaveDeCombateSigilosa inherits NaveDeCombate{
    override method condicionAdicionl()
        {return 
         super() && estaVisible
        
        }
    override method escapar(){
        super()
        self.desplegarMisiles()
        self.ponerseInvisible()

    }    

    
}