import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../capas/textos/textos_app.dart';
import '../../../capas/variables/variables_app.dart';
import '../../../nucleo/error/fallo.dart';
import '../../dominio/casos_de_uso/confirmar_codigo.dart';
import '../../dominio/casos_de_uso/pedir_codigo.dart';
import 'ingreso_estado.dart';
import 'ingreso_evento.dart';

/// Dos pasos: pedir el código al correo y confirmarlo antes de 5 minutos.
class IngresoBloc extends Bloc<IngresoEvento, IngresoEstado> {
  IngresoBloc({required this.pedirCodigo, required this.confirmarCodigo})
    : super(const IngresoEstado()) {
    on<CodigoSolicitado>(_alPedir);
    on<CodigoConfirmado>(_alConfirmar);
    on<SegundoTranscurrido>(_alSegundo);
    on<OtroCorreoPedido>(_alVolver);
    on<GooglePresionado>(_alGoogle);
    on<SesionCerrada>(_alCerrar);
  }

  final PedirCodigo pedirCodigo;
  final ConfirmarCodigo confirmarCodigo;
  Timer? _reloj;

  Future<void> _alPedir(
    CodigoSolicitado evento,
    Emitter<IngresoEstado> emit,
  ) async {
    final correo = evento.correo.trim().toLowerCase();
    if (!_correoValido(correo)) {
      emit(
        state.copiar(
          error: TextosApp.correoInvalido,
          borrarAviso: true,
          ocupado: false,
        ),
      );
      return;
    }
    emit(
      state.copiar(
        correo: correo,
        ocupado: true,
        borrarError: true,
        borrarAviso: true,
      ),
    );
    try {
      await pedirCodigo.llamar(correo);
      _iniciarReloj();
      emit(
        state.copiar(
          paso: PasoIngreso.codigo,
          ocupado: false,
          segundosRestantes: VariablesApp.segundosCodigo,
          generacion: state.generacion + 1,
          borrarError: true,
          borrarAviso: true,
        ),
      );
    } on Fallo catch (fallo) {
      emit(state.copiar(ocupado: false, error: fallo.mensaje));
    }
  }

  Future<void> _alConfirmar(
    CodigoConfirmado evento,
    Emitter<IngresoEstado> emit,
  ) async {
    final codigo = evento.codigo.trim();
    if (!state.codigoVigente) {
      emit(
        state.copiar(
          aviso: TextosApp.codigoVencido,
          borrarError: true,
          ocupado: false,
        ),
      );
      return;
    }
    if (codigo.length != VariablesApp.digitosCodigo) {
      emit(state.copiar(error: TextosApp.codigoIncompleto, borrarAviso: true));
      return;
    }
    emit(state.copiar(ocupado: true, borrarError: true, borrarAviso: true));
    try {
      final sesion = await confirmarCodigo.llamar(codigo);
      _reloj?.cancel();
      emit(
        state.copiar(
          paso: PasoIngreso.sesion,
          ocupado: false,
          sesion: sesion,
          borrarError: true,
          borrarAviso: true,
        ),
      );
    } on Fallo catch (fallo) {
      emit(state.copiar(ocupado: false, error: fallo.mensaje));
    }
  }

  void _alSegundo(SegundoTranscurrido evento, Emitter<IngresoEstado> emit) {
    if (state.paso != PasoIngreso.codigo) {
      return;
    }
    if (state.segundosRestantes <= 1) {
      _reloj?.cancel();
      emit(
        state.copiar(
          segundosRestantes: 0,
          aviso: TextosApp.codigoVencido,
          borrarError: true,
        ),
      );
      return;
    }
    emit(state.copiar(segundosRestantes: state.segundosRestantes - 1));
  }

  void _alVolver(OtroCorreoPedido evento, Emitter<IngresoEstado> emit) {
    _reloj?.cancel();
    emit(const IngresoEstado());
  }

  void _alGoogle(GooglePresionado evento, Emitter<IngresoEstado> emit) {
    emit(state.copiar(aviso: TextosApp.googlePendiente, borrarError: true));
  }

  void _alCerrar(SesionCerrada evento, Emitter<IngresoEstado> emit) {
    _reloj?.cancel();
    emit(const IngresoEstado());
  }

  void _iniciarReloj() {
    _reloj?.cancel();
    _reloj = Timer.periodic(const Duration(seconds: 1), (_) {
      add(const SegundoTranscurrido());
    });
  }

  bool _correoValido(String correo) {
    final partes = correo.split('@');
    return partes.length == 2 &&
        partes[0].isNotEmpty &&
        partes[1].contains('.') &&
        !correo.contains(' ');
  }

  @override
  Future<void> close() {
    _reloj?.cancel();
    return super.close();
  }
}
