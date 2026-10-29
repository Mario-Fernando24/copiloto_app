import 'dart:convert';

import 'package:dio/dio.dart';

import '../../capas/textos/textos_app.dart';
import '../../capas/variables/variables_app.dart';
import '../error/fallo.dart';

/// POST JSON contra el servicio de cuenta. Devuelve el sobre completo.
class ClienteApi {
  ClienteApi({Dio? cliente, String? urlBase})
    : _cliente = cliente ?? Dio(),
      _urlBase = urlBase ?? VariablesApp.urlBase {
    _cliente.options.connectTimeout ??= VariablesApp.esperaRed;
  }

  final Dio _cliente;
  final String _urlBase;

  Future<Map<String, dynamic>> post(
    String ruta,
    Map<String, dynamic> cuerpo,
  ) async {
    try {
      final respuesta = await _cliente.post<dynamic>(
        '$_urlBase$ruta',
        data: cuerpo,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: const {Headers.acceptHeader: Headers.jsonContentType},
          responseType: ResponseType.json,
          sendTimeout: VariablesApp.esperaRed,
          receiveTimeout: VariablesApp.esperaRed,
          validateStatus: (estado) => estado != null,
        ),
      );
      return _mapa(respuesta.data);
    } on Fallo {
      rethrow;
    } on DioException catch (error) {
      final cuerpoError = error.response?.data;
      if (cuerpoError != null) {
        try {
          return _mapa(cuerpoError);
        } on Fallo {
          rethrow;
        } catch (_) {
          throw const Fallo(TextosApp.sinConexion);
        }
      }
      throw const Fallo(TextosApp.sinConexion);
    } catch (_) {
      throw const Fallo(TextosApp.sinConexion);
    }
  }

  Map<String, dynamic> _mapa(Object? datos) {
    if (datos is String) {
      datos = jsonDecode(datos);
    }
    if (datos is! Map) {
      throw const Fallo(TextosApp.respuestaInvalida);
    }
    return Map<String, dynamic>.from(datos);
  }
}
