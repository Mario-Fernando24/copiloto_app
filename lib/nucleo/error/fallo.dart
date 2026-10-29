/// Error que ya tiene una frase lista para mostrar.
class Fallo implements Exception {
  const Fallo(this.mensaje);

  final String mensaje;
}
