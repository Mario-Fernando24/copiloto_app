import 'package:flutter/material.dart';

import '../variables/variables_app.dart';
import 'colores_app.dart';
import 'estilos_texto.dart';

/// Tema de Material. Junta colores, estilos de texto y medidas.
class TemaApp {
  const TemaApp._();

  static ThemeData claro() {
    const borde = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(VariablesApp.radioCampo)),
      borderSide: BorderSide(color: ColoresApp.linea),
    );
    const bordeActivo = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(VariablesApp.radioCampo)),
      borderSide: BorderSide(color: ColoresApp.marino, width: 1.6),
    );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: ColoresApp.papel,
      textTheme: EstilosTexto.tema(),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: ColoresApp.marino,
        onPrimary: ColoresApp.blanco,
        secondary: ColoresApp.marinoSuave,
        onSecondary: ColoresApp.tinta,
        error: ColoresApp.error,
        onError: ColoresApp.blanco,
        surface: ColoresApp.tarjeta,
        onSurface: ColoresApp.tinta,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: ColoresApp.tarjeta,
        hintStyle: EstilosTexto.pista,
        labelStyle: EstilosTexto.etiqueta,
        contentPadding: EdgeInsets.symmetric(
          horizontal: VariablesApp.espacioM,
          vertical: VariablesApp.espacioM,
        ),
        border: borde,
        enabledBorder: borde,
        focusedBorder: bordeActivo,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: ColoresApp.marino,
          foregroundColor: ColoresApp.blanco,
          disabledBackgroundColor: ColoresApp.marinoApagado,
          disabledForegroundColor: ColoresApp.blanco,
          textStyle: EstilosTexto.boton,
          elevation: 0,
          minimumSize: const Size.fromHeight(VariablesApp.altoBoton),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(VariablesApp.radioBoton),
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ColoresApp.tinta,
          backgroundColor: ColoresApp.tarjeta,
          textStyle: EstilosTexto.boton,
          side: const BorderSide(color: ColoresApp.linea),
          minimumSize: const Size.fromHeight(VariablesApp.altoBoton),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(VariablesApp.radioBoton),
            ),
          ),
        ),
      ),
    );
  }
}
