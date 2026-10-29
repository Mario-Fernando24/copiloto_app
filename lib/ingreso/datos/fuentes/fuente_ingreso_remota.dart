import '../../../capas/textos/textos_app.dart';
import '../../../capas/variables/variables_app.dart';
import '../../../nucleo/error/fallo.dart';
import '../../../nucleo/red/cliente_api.dart';
import '../../dominio/entidades/sesion.dart';
import '../modelos/sesion_modelo.dart';

/// Llama a `/api/auth/correo` y `/api/auth/enlace`.
class FuenteIngresoRemota {
  const FuenteIngresoRemota(this._cliente);

  final ClienteApi _cliente;

  Future<void> pedirCodigo(String correo) async {
    final cuerpo = await _cliente.post(VariablesApp.rutaCorreo, {
      'correo': correo,
    });
    _exigirExitosa(cuerpo);
  }

  Future<Sesion> confirmarCodigo(String codigo) async {
    final cuerpo = await _cliente.post(VariablesApp.rutaEnlace, {
      'token': codigo,
    });
    _exigirExitosa(cuerpo);
    final objeto = cuerpo['objeto'];
    if (objeto is! List || objeto.isEmpty || objeto.first is! Map) {
      throw const Fallo(TextosApp.respuestaInvalida);
    }
    return SesionModelo.desdeMapa(
      Map<String, dynamic>.from(objeto.first as Map),
    );
  }

  void _exigirExitosa(Map<String, dynamic> cuerpo) {
    if (cuerpo['exitosa'] == true) {
      return;
    }
    final excepcion = cuerpo['descripcionExcepcion'];
    if (excepcion is String && excepcion.isNotEmpty) {
      throw Fallo(excepcion);
    }
    throw const Fallo(TextosApp.noSePudoEntrar);
  }
}
