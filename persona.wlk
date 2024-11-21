import tiempo.*

class Persona {
  var property efectivo
  var property salario
  var property saldo = 0
  var formaDePagoPreferida
  var property formasDePago = []
  var compras = []
  
  method compras() = compras
  
  method formaDePagoPreferida() = formaDePagoPreferida
  
  method cambiarFormaDePagoPreferida() {
    formaDePagoPreferida = formasDePago.anyOne()
  }
  
  method cambiarFormaDePagoPreferida(formaDePago) {
    try {
      if (!formasDePago.contains(formaDePago)) {
        throw new Exception(
          message = "La forma de pago a la que intenta cambiar, no pertenece a la lista de formas de pago!"
        )
      }
      
      formaDePagoPreferida = formaDePago
    } catch e : Exception {
      console.error(e.message())
    }
  }
  
  method realizarCompra(producto) {
    if (formaDePagoPreferida.realizarPago(producto.precio(), self)) {
      compras.add(producto)
      return true
    }
    return false
  }
  
  method cobrarSalario() {
    saldo += salario
    formaDePagoPreferida.pagarDeudas(self)
    efectivo += saldo
  }
}

class CompradorCompulsivo inherits Persona {
  override method realizarCompra(producto) {
        return formasDePago.any({f => f.realizarCompra(producto.precio(), self)})
  }
}

class Producto {
  var property precio
}
