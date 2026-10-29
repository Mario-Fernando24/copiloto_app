/// Lo que la pantalla le pide al ingreso.
sealed class IngresoEvento {
  const IngresoEvento();
}

class CodigoSolicitado extends IngresoEvento {
  const CodigoSolicitado(this.correo);

  final String correo;
}

class CodigoConfirmado extends IngresoEvento {
  const CodigoConfirmado(this.codigo);

  final String codigo;
}

class SegundoTranscurrido extends IngresoEvento {
  const SegundoTranscurrido();
}

class OtroCorreoPedido extends IngresoEvento {
  const OtroCorreoPedido();
}

class GooglePresionado extends IngresoEvento {
  const GooglePresionado();
}

class SesionCerrada extends IngresoEvento {
  const SesionCerrada();
}
