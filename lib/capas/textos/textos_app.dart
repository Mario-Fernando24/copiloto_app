/// Nombres de todo lo que la persona lee. Las pantallas no escriben frases sueltas.
class TextosApp {
  const TextosApp._();

  static const String nombreApp = 'VíaSense';
  static const String marca = 'V';

  static const String tituloCorreo = 'Entra a tu cuenta';
  static const String subtituloCorreo =
      'Sin contraseña. Te enviamos un código de 6 dígitos y vence en 5 minutos.';
  static const String etiquetaCorreo = 'Correo';
  static const String pistaCorreo = 'tu@correo.com';
  static const String enviarCodigo = 'Enviar código';
  static const String oContinuar = 'o';
  static const String continuarGoogle = 'Continuar con Google';
  static const String googlePendiente =
      'Google se activa cuando la app tenga su cliente configurado.';

  static const String tituloCodigo = 'Revisa tu correo';
  static const String subtituloCodigo =
      'Escribe los 6 dígitos que te enviamos.';
  static const String entrar = 'Entrar';
  static const String reenviar = 'Reenviar código';
  static const String otroCorreo = 'Usar otro correo';
  static const String codigoVencido = 'El código venció. Pide otro.';
  static const String codigoIncompleto = 'El código tiene 6 dígitos.';
  static const String correoInvalido = 'Escribe un correo válido.';

  static const String tituloSesion = 'Sesión abierta';
  static const String subtituloSesion =
      'Ya puedes usar tu cuenta en este dispositivo.';
  static const String cerrarSesion = 'Cerrar sesión';
  static const String proveedorCorreo = 'Correo';
  static const String proveedorGoogle = 'Google';

  static const String sinConexion = 'No hay conexión con el servicio.';
  static const String respuestaInvalida =
      'El servicio respondió de una forma inesperada.';
  static const String noSePudoEntrar = 'No se pudo abrir la sesión.';

  static String enviadoA(String correo) => 'Enviado a $correo';

  static String venceEn(String reloj) => 'Vence en $reloj';

  static String proveedor(String valor) {
    if (valor == 'google') {
      return proveedorGoogle;
    }
    return proveedorCorreo;
  }
}
