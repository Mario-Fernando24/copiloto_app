import 'package:flutter/material.dart';

import '../../../capas/estilos/colores_app.dart';
import '../../../capas/estilos/estilos_texto.dart';
import '../../../capas/textos/textos_app.dart';
import '../../../capas/variables/variables_app.dart';

class MarcaApp extends StatelessWidget {
  const MarcaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerLeft,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: ColoresApp.marino,
          borderRadius: BorderRadius.all(
            Radius.circular(VariablesApp.radioMarca),
          ),
        ),
        child: SizedBox(
          width: VariablesApp.ladoMarca,
          height: VariablesApp.ladoMarca,
          child: Center(
            child: Text(TextosApp.marca, style: EstilosTexto.marca),
          ),
        ),
      ),
    );
  }
}
