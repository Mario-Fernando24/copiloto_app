/// Medidas, tiempos y rutas. No hay colores ni frases de la pantalla.
///
/// La pantalla y el BLoC leen de aquí para no repetir números sueltos.
class VariablesApp {
  const VariablesApp._();

  static const double espacioXs = 8;
  static const double espacioS = 12;
  static const double espacioM = 16;
  static const double espacioL = 24;
  static const double espacioXl = 48;

  static const double radioCampo = 14;
  static const double radioBoton = 14;
  static const double radioMarca = 18;
  static const double radioAviso = 12;

  static const double altoBoton = 54;
  static const double ladoMarca = 56;
  static const double anchoContenido = 440;
  static const double altoCaja = 58;

  static const int digitosCodigo = 6;
  static const int minutosCodigo = 5;
  static const int segundosCodigo = minutosCodigo * 60;

  static const Duration esperaRed = Duration(seconds: 20);
  static const Duration duracionCambio = Duration(milliseconds: 240);

  /// Servicio de cuenta en la IP del Wi-Fi de esta máquina.
  static const String urlBase = 'http://192.168.0.25:8000';
  static const String rutaCorreo = '/api/auth/correo';
  static const String rutaEnlace = '/api/auth/enlace';

  static String reloj(int segundos) {
    final minutos = segundos ~/ 60;
    final resto = segundos % 60;
    final textoResto = resto.toString().padLeft(2, '0');
    return '$minutos:$textoResto';
  }
}
