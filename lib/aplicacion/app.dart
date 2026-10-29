import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../capas/estilos/tema_app.dart';
import '../capas/textos/textos_app.dart';
import '../ingreso/presentacion/bloc/ingreso_bloc.dart';
import '../ingreso/presentacion/paginas/pagina_ingreso.dart';

class CopilotoApp extends StatelessWidget {
  const CopilotoApp({required this.bloc, super.key});

  final IngresoBloc bloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: MaterialApp(
        title: TextosApp.nombreApp,
        debugShowCheckedModeBanner: false,
        theme: TemaApp.claro(),
        home: const PaginaIngreso(),
      ),
    );
  }
}
