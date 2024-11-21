import tiempo.*

object efectivo {
  method realizarPago(monto, persona) {
    try {
      if (persona.efectivo() < monto) {
        throw new Exception(
          message = "Saldo insuficiente para realizar la transaccion!"
        )
      }
      
      const nuevoEfectivo = persona.efectivo() - monto
      
      persona.efectivo(nuevoEfectivo)
      
      return true
    } catch e : Exception {
      console.error(e.message())
      return false
    }
  }
}

class TarjetaDeDebito {
  var property saldo
  
  method realizarPago(monto, persona) {
    try {
      if (saldo < monto) {
        throw new Exception(
          message = "Saldo insuficiente en la cuenta bancaria para realizar la transaccion!"
        )
      }
      
      saldo -= monto
      
      return true
    } catch e : Exception {
      console.error(e.message())
      return false
    }
  }
}

class Deuda {
  var property mes
  var property monto
  
  method agregarAMonto(_monto) {
    monto += _monto
  }
  
  method pagarDeuda(persona) {
    try {
      if (persona.saldo() < monto) {
        throw new Exception(
          message = "No tiene el dinero suficiente para pagar la deuda"
        )
      }
      persona.saldo(persona.saldo() - monto)
      monto = 0
    } catch e : Exception {
      console.println(e.message())
    }
  }
}

class TarjetaDeCredito {
  var deudas = (1 .. 12).asList().map({ m => new Deuda(mes = m, monto = 0) })
  var cantidadDeCuotas
  var interes
  var limite
  
  method deudas() = deudas
  
  method montoTotalDeDeudas() = deudas.filter(
    { m => m.mes() <= tiempo.mesActual() }
  ).sum({ m => m.monto() })
  
  method nuevaDeuda(cuota) {
    var it = tiempo.mesActual() - 1
    
    (1 .. cantidadDeCuotas).asList().forEach(
      { i =>
        it += 1
        return deudas.get(it).agregarAMonto(cuota)
      }
    )
  }
  
  method pagarDeudas(persona) {
    const deudasVencidas = deudas.filter({ m => m.mes() <= tiempo.mesActual() })
    deudasVencidas.forEach({ d => d.pagarDeuda(persona) })
  }
  
  method realizarPago(monto, persona) {
    try {
      const nuevoMonto = monto * interes
      
      if (nuevoMonto > limite) {
        throw new Exception(
          message = "No se puede realizar el pago porque el monto supera el limite"
        )
      }
      
      const cuota = nuevoMonto / cantidadDeCuotas
      
      self.nuevaDeuda(cuota)
      
      return true
    } catch e : Exception {
      console.error(e.message())
      return false
    }
  }
}
