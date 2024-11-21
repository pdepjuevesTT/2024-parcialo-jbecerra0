import tiempo.*

class Persona {
    var property efectivo
    var property salario
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
            if (!formasDePago.contains(formaDePago))
            {
                throw new Exception(message = "La forma de pago a la que intenta cambiar, no pertenece a la lista de formas de pago!")
            }

            formaDePagoPreferida = formasDePago
        } catch e : Exception {
            console.error(e.message())
        }
        
    }

    method realizarCompra(producto) {
        if (formaDePagoPreferida.realizarPago(producto.precio(), self)) {
            compras.add(producto)
            return
        }
        return
    }

    method pagarDeudas() {
        formaDePagoPreferida.pagarDeudas()


    }

    method cobrarSalario() {
        efectivo += salario

    }

}

class Producto {
    var property precio
}
