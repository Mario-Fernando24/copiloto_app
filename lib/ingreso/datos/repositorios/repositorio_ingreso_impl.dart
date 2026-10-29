import '../../dominio/entidades/sesion.dart';
import '../../dominio/repositorios/repositorio_ingreso.dart';
import '../fuentes/fuente_ingreso_remota.dart';

class RepositorioIngresoImpl implements RepositorioIngreso {
  const RepositorioIngresoImpl(this._fuente);

  final FuenteIngresoRemota _fuente;

  @override
  Future<void> pedirCodigo(String correo) {
    return _fuente.pedirCodigo(correo);
  }

  @override
  Future<Sesion> confirmarCodigo(String codigo) {
    return _fuente.confirmarCodigo(codigo);
  }
}
