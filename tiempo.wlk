object tiempo {
    var mesActual = 1

    method mesActual() = mesActual

    method siguienteMes(mes) = if (mes == 12) 1 else (mes + 1 )

    method nuevoMes() {
        mesActual = self.siguienteMes(mesActual)
    }
}
