import '../entidades/sesion.dart';
import '../repositorios/repositorio_ingreso.dart';

/// Canjea el código y abre la sesión.
class ConfirmarCodigo {
  const ConfirmarCodigo(this._repositorio);

  final RepositorioIngreso _repositorio;

  Future<Sesion> llamar(String codigo) {
    return _repositorio.confirmarCodigo(codigo);
  }
}
