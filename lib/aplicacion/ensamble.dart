import '../ingreso/datos/fuentes/fuente_ingreso_remota.dart';
import '../ingreso/datos/repositorios/repositorio_ingreso_impl.dart';
import '../ingreso/dominio/casos_de_uso/confirmar_codigo.dart';
import '../ingreso/dominio/casos_de_uso/pedir_codigo.dart';
import '../ingreso/presentacion/bloc/ingreso_bloc.dart';
import '../nucleo/red/cliente_api.dart';

/// Arma las capas de afuera hacia adentro. Las pantallas no crean el cliente.
class Ensamble {
  Ensamble._(this._pedirCodigo, this._confirmarCodigo);

  factory Ensamble.local() {
    final fuente = FuenteIngresoRemota(ClienteApi());
    final repositorio = RepositorioIngresoImpl(fuente);
    return Ensamble._(PedirCodigo(repositorio), ConfirmarCodigo(repositorio));
  }

  final PedirCodigo _pedirCodigo;
  final ConfirmarCodigo _confirmarCodigo;

  IngresoBloc ingresoBloc() {
    return IngresoBloc(
      pedirCodigo: _pedirCodigo,
      confirmarCodigo: _confirmarCodigo,
    );
  }
}
