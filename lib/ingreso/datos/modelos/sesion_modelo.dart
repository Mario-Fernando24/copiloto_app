import '../../../capas/textos/textos_app.dart';
import '../../../nucleo/error/fallo.dart';
import '../../dominio/entidades/sesion.dart';
import '../../dominio/entidades/usuario.dart';

/// Traduce `objeto[0]` del login a la entidad [Sesion].
class SesionModelo {
  const SesionModelo._();

  static Sesion desdeMapa(Map<String, dynamic> mapa) {
    final crudo = mapa['usuario'];
    if (crudo is! Map) {
      throw const Fallo(TextosApp.respuestaInvalida);
    }
    final usuario = Map<String, dynamic>.from(crudo);
    final token = mapa['token'];
    final refresco = mapa['refresco'];
    if (token is! String ||
        token.isEmpty ||
        refresco is! String ||
        refresco.isEmpty) {
      throw const Fallo(TextosApp.respuestaInvalida);
    }
    return Sesion(
      token: token,
      refresco: refresco,
      fechaExpiracion: mapa['fecha_expiracion'] is String
          ? mapa['fecha_expiracion'] as String
          : '',
      usuario: Usuario(
        id: usuario['id'] is String ? usuario['id'] as String : '',
        correo: usuario['correo'] is String ? usuario['correo'] as String : '',
        proveedor: usuario['proveedor'] is String
            ? usuario['proveedor'] as String
            : '',
        esAdministrador: usuario['es_administrador'] == true,
      ),
    );
  }
}
