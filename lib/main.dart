import 'package:flutter/material.dart';

import 'aplicacion/app.dart';
import 'aplicacion/ensamble.dart';

void main() {
  final ensamble = Ensamble.local();
  runApp(CopilotoApp(bloc: ensamble.ingresoBloc()));
}
