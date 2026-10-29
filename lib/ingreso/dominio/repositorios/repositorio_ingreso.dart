import '../entidades/sesion.dart';

/// Contrato del ingreso. El dominio no sabe si hay HTTP detrás.
abstract class RepositorioIngreso {
  Future<void> pedirCodigo(String correo);

  Future<Sesion> confirmarCodigo(String codigo);
}
