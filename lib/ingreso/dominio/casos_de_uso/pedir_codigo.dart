import '../repositorios/repositorio_ingreso.dart';

/// Pide el código de 6 dígitos para un correo.
class PedirCodigo {
  const PedirCodigo(this._repositorio);

  final RepositorioIngreso _repositorio;

  Future<void> llamar(String correo) {
    return _repositorio.pedirCodigo(correo);
  }
}
