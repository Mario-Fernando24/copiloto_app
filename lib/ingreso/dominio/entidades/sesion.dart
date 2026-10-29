import 'usuario.dart';

/// Token corto, refresco y la persona dueña de esa sesión.
class Sesion {
  const Sesion({
    required this.token,
    required this.refresco,
    required this.fechaExpiracion,
    required this.usuario,
  });

  final String token;
  final String refresco;
  final String fechaExpiracion;
  final Usuario usuario;
}
