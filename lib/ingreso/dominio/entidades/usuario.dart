/// Persona que ya tiene fila en la cuenta.
class Usuario {
  const Usuario({
    required this.id,
    required this.correo,
    required this.proveedor,
    required this.esAdministrador,
  });

  final String id;
  final String correo;
  final String proveedor;
  final bool esAdministrador;
}
