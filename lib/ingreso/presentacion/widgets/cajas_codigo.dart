import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../capas/estilos/colores_app.dart';
import '../../../capas/estilos/estilos_texto.dart';
import '../../../capas/variables/variables_app.dart';

/// Seis casillas. Un solo campo recibe el teclado y el pegado.
class CajasCodigo extends StatefulWidget {
  const CajasCodigo({required this.alCambiar, this.activo = true, super.key});

  final ValueChanged<String> alCambiar;
  final bool activo;

  @override
  State<CajasCodigo> createState() => _CajasCodigoState();
}

class _CajasCodigoState extends State<CajasCodigo> {
  final TextEditingController _control = TextEditingController();
  final FocusNode _foco = FocusNode();

  @override
  void dispose() {
    _control.dispose();
    _foco.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final codigo = _control.text;
    return GestureDetector(
      onTap: widget.activo ? () => _foco.requestFocus() : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final hueco = VariablesApp.espacioXs;
              final ancho =
                  (constraints.maxWidth -
                      hueco * (VariablesApp.digitosCodigo - 1)) /
                  VariablesApp.digitosCodigo;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(VariablesApp.digitosCodigo, (indice) {
                  final llena = indice < codigo.length;
                  final activa = widget.activo && indice == codigo.length;
                  return Container(
                    width: ancho,
                    height: VariablesApp.altoCaja,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColoresApp.tarjeta,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(VariablesApp.radioCampo),
                      ),
                      border: Border.all(
                        color: activa ? ColoresApp.marino : ColoresApp.linea,
                        width: activa ? 1.6 : 1,
                      ),
                    ),
                    child: Text(
                      llena ? codigo[indice] : '',
                      style: EstilosTexto.digito,
                    ),
                  );
                }),
              );
            },
          ),
          Positioned.fill(
            child: TextField(
              controller: _control,
              focusNode: _foco,
              enabled: widget.activo,
              autofocus: true,
              keyboardType: TextInputType.number,
              showCursor: false,
              enableSuggestions: false,
              autocorrect: false,
              style: const TextStyle(
                color: ColoresApp.transparente,
                fontSize: 1,
              ),
              decoration: const InputDecoration(
                counterText: '',
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(VariablesApp.digitosCodigo),
              ],
              onChanged: widget.alCambiar,
            ),
          ),
        ],
      ),
    );
  }
}
