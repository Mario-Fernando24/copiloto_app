import 'package:flutter/material.dart';

import '../../../capas/estilos/colores_app.dart';
import '../../../capas/variables/variables_app.dart';

class BotonPrincipal extends StatelessWidget {
  const BotonPrincipal({
    required this.etiqueta,
    required this.alPulsar,
    this.ocupado = false,
    super.key,
  });

  final String etiqueta;
  final VoidCallback? alPulsar;
  final bool ocupado;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: VariablesApp.altoBoton,
      child: FilledButton(
        onPressed: ocupado ? null : alPulsar,
        child: ocupado
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  color: ColoresApp.blanco,
                ),
              )
            : Text(etiqueta),
      ),
    );
  }
}
