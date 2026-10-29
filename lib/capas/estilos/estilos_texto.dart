import 'package:flutter/material.dart';

import 'colores_app.dart';

/// Estilos de texto. Las pantallas los nombran, no arman un [TextStyle] propio.
class EstilosTexto {
  const EstilosTexto._();

  static const TextStyle marca = TextStyle(
    color: ColoresApp.blanco,
    fontSize: 26,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.4,
  );

  static const TextStyle titulo = TextStyle(
    color: ColoresApp.tinta,
    fontSize: 30,
    height: 1.15,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.6,
  );

  static const TextStyle subtitulo = TextStyle(
    color: ColoresApp.textoSuave,
    fontSize: 16,
    height: 1.45,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle etiqueta = TextStyle(
    color: ColoresApp.tinta,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle pista = TextStyle(
    color: ColoresApp.textoSuave,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle campo = TextStyle(
    color: ColoresApp.tinta,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle boton = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  static const TextStyle enlace = TextStyle(
    color: ColoresApp.marino,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle aviso = TextStyle(
    color: ColoresApp.tinta,
    fontSize: 14,
    height: 1.35,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle digito = TextStyle(
    color: ColoresApp.tinta,
    fontSize: 22,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle reloj = TextStyle(
    color: ColoresApp.marino,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );

  static TextTheme tema() {
    return const TextTheme(
      headlineMedium: titulo,
      bodyLarge: subtitulo,
      bodyMedium: pista,
      labelLarge: boton,
    );
  }
}
