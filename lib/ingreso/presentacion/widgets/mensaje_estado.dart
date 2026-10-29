import 'package:flutter/material.dart';

import '../../../capas/estilos/colores_app.dart';
import '../../../capas/estilos/estilos_texto.dart';
import '../../../capas/variables/variables_app.dart';

class MensajeEstado extends StatelessWidget {
  const MensajeEstado({this.error, this.aviso, super.key});

  final String? error;
  final String? aviso;

  @override
  Widget build(BuildContext context) {
    final texto = error ?? aviso;
    if (texto == null || texto.isEmpty) {
      return const SizedBox.shrink();
    }
    final esError = error != null;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: VariablesApp.espacioM),
      padding: const EdgeInsets.symmetric(
        horizontal: VariablesApp.espacioM,
        vertical: VariablesApp.espacioS,
      ),
      decoration: BoxDecoration(
        color: esError ? ColoresApp.errorSuave : ColoresApp.marinoSuave,
        borderRadius: const BorderRadius.all(
          Radius.circular(VariablesApp.radioAviso),
        ),
      ),
      child: Text(
        texto,
        style: EstilosTexto.aviso.copyWith(
          color: esError ? ColoresApp.error : ColoresApp.marinoProfundo,
        ),
      ),
    );
  }
}
