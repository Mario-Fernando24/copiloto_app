import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../capas/estilos/colores_app.dart';
import '../../../capas/estilos/estilos_texto.dart';
import '../../../capas/textos/textos_app.dart';
import '../../../capas/variables/variables_app.dart';
import '../bloc/ingreso_bloc.dart';
import '../bloc/ingreso_estado.dart';
import '../bloc/ingreso_evento.dart';

class VistaSesion extends StatelessWidget {
  const VistaSesion({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IngresoBloc, IngresoEstado>(
      builder: (context, estado) {
        final usuario = estado.sesion?.usuario;
        return ListView(
          padding: const EdgeInsets.fromLTRB(
            VariablesApp.espacioL,
            VariablesApp.espacioXl,
            VariablesApp.espacioL,
            VariablesApp.espacioL,
          ),
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: ColoresApp.okSuave,
                  borderRadius: BorderRadius.all(
                    Radius.circular(VariablesApp.radioMarca),
                  ),
                ),
                child: SizedBox(
                  width: VariablesApp.ladoMarca,
                  height: VariablesApp.ladoMarca,
                  child: Icon(
                    Icons.check_rounded,
                    color: ColoresApp.ok,
                    size: 32,
                  ),
                ),
              ),
            ),
            const SizedBox(height: VariablesApp.espacioL),
            const Text(TextosApp.tituloSesion, style: EstilosTexto.titulo),
            const SizedBox(height: VariablesApp.espacioS),
            const Text(
              TextosApp.subtituloSesion,
              style: EstilosTexto.subtitulo,
            ),
            const SizedBox(height: VariablesApp.espacioXl),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(VariablesApp.espacioL),
              decoration: const BoxDecoration(
                color: ColoresApp.tarjeta,
                borderRadius: BorderRadius.all(
                  Radius.circular(VariablesApp.radioCampo),
                ),
                border: Border.fromBorderSide(
                  BorderSide(color: ColoresApp.linea),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    usuario?.correo ?? estado.correo,
                    style: EstilosTexto.etiqueta,
                  ),
                  const SizedBox(height: VariablesApp.espacioXs),
                  Text(
                    TextosApp.proveedor(usuario?.proveedor ?? ''),
                    style: EstilosTexto.pista,
                  ),
                ],
              ),
            ),
            const SizedBox(height: VariablesApp.espacioL),
            TextButton(
              onPressed: () =>
                  context.read<IngresoBloc>().add(const SesionCerrada()),
              child: const Text(
                TextosApp.cerrarSesion,
                style: EstilosTexto.enlace,
              ),
            ),
          ],
        );
      },
    );
  }
}
