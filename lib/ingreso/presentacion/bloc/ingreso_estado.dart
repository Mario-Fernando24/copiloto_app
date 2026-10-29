import '../../dominio/entidades/sesion.dart';

enum PasoIngreso { correo, codigo, sesion }

/// Estado único de las tres pantallas del ingreso.
class IngresoEstado {
  const IngresoEstado({
    this.paso = PasoIngreso.correo,
    this.correo = '',
    this.ocupado = false,
    this.error,
    this.aviso,
    this.segundosRestantes = 0,
    this.generacion = 0,
    this.sesion,
  });

  final PasoIngreso paso;
  final String correo;
  final bool ocupado;
  final String? error;
  final String? aviso;
  final int segundosRestantes;
  final int generacion;
  final Sesion? sesion;

  bool get codigoVigente => segundosRestantes > 0;

  IngresoEstado copiar({
    PasoIngreso? paso,
    String? correo,
    bool? ocupado,
    String? error,
    bool borrarError = false,
    String? aviso,
    bool borrarAviso = false,
    int? segundosRestantes,
    int? generacion,
    Sesion? sesion,
    bool borrarSesion = false,
  }) {
    return IngresoEstado(
      paso: paso ?? this.paso,
      correo: correo ?? this.correo,
      ocupado: ocupado ?? this.ocupado,
      error: borrarError ? null : error ?? this.error,
      aviso: borrarAviso ? null : aviso ?? this.aviso,
      segundosRestantes: segundosRestantes ?? this.segundosRestantes,
      generacion: generacion ?? this.generacion,
      sesion: borrarSesion ? null : sesion ?? this.sesion,
    );
  }
}
