import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../capas/estilos/estilos_texto.dart';
import '../../../capas/textos/textos_app.dart';
import '../../../capas/variables/variables_app.dart';
import '../bloc/ingreso_bloc.dart';
import '../bloc/ingreso_estado.dart';
import '../bloc/ingreso_evento.dart';
import '../widgets/boton_principal.dart';
import '../widgets/cajas_codigo.dart';
import '../widgets/mensaje_estado.dart';

class VistaCodigo extends StatefulWidget {
  const VistaCodigo({super.key});

  @override
  State<VistaCodigo> createState() => _VistaCodigoState();
}

class _VistaCodigoState extends State<VistaCodigo> {
  String _codigo = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IngresoBloc, IngresoEstado>(
      listenWhen: (anterior, actual) =>
          anterior.generacion != actual.generacion,
      listener: (context, estado) => setState(() => _codigo = ''),
      builder: (context, estado) {
        final reloj = VariablesApp.reloj(estado.segundosRestantes);
        return ListView(
          padding: const EdgeInsets.fromLTRB(
            VariablesApp.espacioL,
            VariablesApp.espacioS,
            VariablesApp.espacioL,
            VariablesApp.espacioL,
          ),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: estado.ocupado
                    ? null
                    : () => context.read<IngresoBloc>().add(
                        const OtroCorreoPedido(),
                      ),
                child: const Text(
                  TextosApp.otroCorreo,
                  style: EstilosTexto.enlace,
                ),
              ),
            ),
            const SizedBox(height: VariablesApp.espacioL),
            const Text(TextosApp.tituloCodigo, style: EstilosTexto.titulo),
            const SizedBox(height: VariablesApp.espacioS),
            const Text(
              TextosApp.subtituloCodigo,
              style: EstilosTexto.subtitulo,
            ),
            const SizedBox(height: VariablesApp.espacioXs),
            Text(
              TextosApp.enviadoA(estado.correo),
              style: EstilosTexto.etiqueta,
            ),
            const SizedBox(height: VariablesApp.espacioXl),
            MensajeEstado(error: estado.error, aviso: estado.aviso),
            CajasCodigo(
              key: ValueKey(estado.generacion),
              activo: estado.codigoVigente && !estado.ocupado,
              alCambiar: (valor) => setState(() => _codigo = valor),
            ),
            const SizedBox(height: VariablesApp.espacioM),
            Text(
              estado.codigoVigente
                  ? TextosApp.venceEn(reloj)
                  : TextosApp.codigoVencido,
              style: EstilosTexto.reloj,
            ),
            const SizedBox(height: VariablesApp.espacioL),
            BotonPrincipal(
              etiqueta: TextosApp.entrar,
              ocupado: estado.ocupado,
              alPulsar: estado.codigoVigente ? () => _entrar(context) : null,
            ),
            const SizedBox(height: VariablesApp.espacioS),
            TextButton(
              onPressed: estado.ocupado
                  ? null
                  : () => context.read<IngresoBloc>().add(
                      CodigoSolicitado(estado.correo),
                    ),
              child: const Text(TextosApp.reenviar, style: EstilosTexto.enlace),
            ),
          ],
        );
      },
    );
  }

  void _entrar(BuildContext context) {
    context.read<IngresoBloc>().add(CodigoConfirmado(_codigo));
  }
}
