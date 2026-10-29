import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../capas/variables/variables_app.dart';
import '../bloc/ingreso_bloc.dart';
import '../bloc/ingreso_estado.dart';
import 'vista_codigo.dart';
import 'vista_correo.dart';
import 'vista_sesion.dart';

/// Elige la pantalla según el paso que dejó el BLoC.
class PaginaIngreso extends StatelessWidget {
  const PaginaIngreso({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: VariablesApp.anchoContenido,
            ),
            child: BlocBuilder<IngresoBloc, IngresoEstado>(
              buildWhen: (anterior, actual) => anterior.paso != actual.paso,
              builder: (context, estado) {
                return AnimatedSwitcher(
                  duration: VariablesApp.duracionCambio,
                  child: switch (estado.paso) {
                    PasoIngreso.correo => const VistaCorreo(
                      key: ValueKey('correo'),
                    ),
                    PasoIngreso.codigo => const VistaCodigo(
                      key: ValueKey('codigo'),
                    ),
                    PasoIngreso.sesion => const VistaSesion(
                      key: ValueKey('sesion'),
                    ),
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
