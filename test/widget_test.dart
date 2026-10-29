import 'package:copiloto_app/capas/estilos/tema_app.dart';
import 'package:copiloto_app/capas/textos/textos_app.dart';
import 'package:copiloto_app/capas/variables/variables_app.dart';
import 'package:copiloto_app/ingreso/dominio/casos_de_uso/confirmar_codigo.dart';
import 'package:copiloto_app/ingreso/dominio/casos_de_uso/pedir_codigo.dart';
import 'package:copiloto_app/ingreso/dominio/entidades/sesion.dart';
import 'package:copiloto_app/ingreso/dominio/entidades/usuario.dart';
import 'package:copiloto_app/ingreso/dominio/repositorios/repositorio_ingreso.dart';
import 'package:copiloto_app/ingreso/presentacion/bloc/ingreso_bloc.dart';
import 'package:copiloto_app/ingreso/presentacion/bloc/ingreso_estado.dart';
import 'package:copiloto_app/ingreso/presentacion/bloc/ingreso_evento.dart';
import 'package:copiloto_app/ingreso/presentacion/paginas/pagina_ingreso.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('muestra el ingreso por correo', (tester) async {
    await tester.pumpWidget(_app());

    expect(find.text(TextosApp.tituloCorreo), findsOneWidget);
    expect(find.text(TextosApp.enviarCodigo), findsOneWidget);
    expect(find.text(TextosApp.continuarGoogle), findsOneWidget);
  });

  testWidgets('al enviar el correo pasa a las seis casillas', (tester) async {
    await tester.pumpWidget(_app());
    await tester.enterText(find.byType(TextField), 'ana@casa.test');
    await tester.tap(find.text(TextosApp.enviarCodigo));
    await tester.pump();
    await tester.pump();

    expect(find.text(TextosApp.tituloCodigo), findsOneWidget);
    expect(find.text(TextosApp.enviadoA('ana@casa.test')), findsOneWidget);
    expect(find.text(TextosApp.venceEn('5:00')), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
  });

  test('un correo invalido no pide el codigo', () async {
    final bloc = _bloc();
    bloc.add(const CodigoSolicitado('sin-arroba'));
    await bloc.stream.first;
    expect(bloc.state.paso, PasoIngreso.correo);
    expect(bloc.state.error, TextosApp.correoInvalido);
    await bloc.close();
  });

  test('el codigo pedido vence a los 5 minutos', () async {
    final bloc = _bloc();
    bloc.add(const CodigoSolicitado('ana@casa.test'));
    final estado = await bloc.stream.firstWhere(
      (actual) => actual.paso == PasoIngreso.codigo,
    );
    expect(estado.segundosRestantes, VariablesApp.segundosCodigo);
    await bloc.close();
  });
}

IngresoBloc _bloc() {
  final repositorio = _RepositorioFalso();
  return IngresoBloc(
    pedirCodigo: PedirCodigo(repositorio),
    confirmarCodigo: ConfirmarCodigo(repositorio),
  );
}

Widget _app() {
  return BlocProvider(
    create: (_) => _bloc(),
    child: MaterialApp(theme: TemaApp.claro(), home: const PaginaIngreso()),
  );
}

class _RepositorioFalso implements RepositorioIngreso {
  @override
  Future<void> pedirCodigo(String correo) async {}

  @override
  Future<Sesion> confirmarCodigo(String codigo) async {
    return Sesion(
      token: 'acceso',
      refresco: 'refresco',
      fechaExpiracion: '2026-10-25T00:00:00Z',
      usuario: Usuario(
        id: '1',
        correo: correoDePrueba,
        proveedor: 'correo',
        esAdministrador: false,
      ),
    );
  }
}

const correoDePrueba = 'ana@casa.test';
