import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../capas/estilos/colores_app.dart';
import '../../../capas/estilos/estilos_texto.dart';
import '../../../capas/textos/textos_app.dart';
import '../../../capas/variables/variables_app.dart';
import '../bloc/ingreso_bloc.dart';
import '../bloc/ingreso_estado.dart';
import '../bloc/ingreso_evento.dart';
import '../widgets/boton_principal.dart';
import '../widgets/marca_app.dart';
import '../widgets/mensaje_estado.dart';

class VistaCorreo extends StatefulWidget {
  const VistaCorreo({super.key});

  @override
  State<VistaCorreo> createState() => _VistaCorreoState();
}

class _VistaCorreoState extends State<VistaCorreo> {
  final TextEditingController _correo = TextEditingController();

  @override
  void dispose() {
    _correo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IngresoBloc, IngresoEstado>(
      builder: (context, estado) {
        return ListView(
          padding: const EdgeInsets.fromLTRB(
            VariablesApp.espacioL,
            VariablesApp.espacioXl,
            VariablesApp.espacioL,
            VariablesApp.espacioL,
          ),
          children: [
            const MarcaApp(),
            const SizedBox(height: VariablesApp.espacioL),
            const Text(TextosApp.tituloCorreo, style: EstilosTexto.titulo),
            const SizedBox(height: VariablesApp.espacioS),
            const Text(
              TextosApp.subtituloCorreo,
              style: EstilosTexto.subtitulo,
            ),
            const SizedBox(height: VariablesApp.espacioXl),
            MensajeEstado(error: estado.error, aviso: estado.aviso),
            TextField(
              controller: _correo,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              autocorrect: false,
              enableSuggestions: false,
              style: EstilosTexto.campo,
              decoration: const InputDecoration(
                labelText: TextosApp.etiquetaCorreo,
                hintText: TextosApp.pistaCorreo,
              ),
              onSubmitted: (_) => _enviar(context),
            ),
            const SizedBox(height: VariablesApp.espacioM),
            BotonPrincipal(
              etiqueta: TextosApp.enviarCodigo,
              ocupado: estado.ocupado,
              alPulsar: () => _enviar(context),
            ),
            const SizedBox(height: VariablesApp.espacioL),
            const Row(
              children: [
                Expanded(child: Divider(color: ColoresApp.linea, height: 1)),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: VariablesApp.espacioS,
                  ),
                  child: Text(TextosApp.oContinuar, style: EstilosTexto.pista),
                ),
                Expanded(child: Divider(color: ColoresApp.linea, height: 1)),
              ],
            ),
            const SizedBox(height: VariablesApp.espacioL),
            SizedBox(
              width: double.infinity,
              height: VariablesApp.altoBoton,
              child: OutlinedButton(
                onPressed: estado.ocupado
                    ? null
                    : () => context.read<IngresoBloc>().add(
                        const GooglePresionado(),
                      ),
                child: const Text(TextosApp.continuarGoogle),
              ),
            ),
          ],
        );
      },
    );
  }

  void _enviar(BuildContext context) {
    context.read<IngresoBloc>().add(CodigoSolicitado(_correo.text));
  }
}
