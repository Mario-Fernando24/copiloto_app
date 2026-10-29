# copiloto_app

App Flutter de VíaSense. Esta primera parte es el ingreso: la persona escribe su correo, recibe un código de 6 dígitos y con ese código abre la sesión. El código lo emite el servicio de `detectores_backend` y vence a los 5 minutos.

## Cómo está armada

Arquitectura limpia con BLoC. Cada capa solo habla con la de al lado.

```text
pantalla  ->  BLoC  ->  caso de uso  ->  repositorio  ->  fuente HTTP
                |                              ^
                |                              |
           textos, estilos                contrato del dominio
           y variables
```

| Capa | Carpeta | Qué hace |
|---|---|---|
| Dominio | `lib/ingreso/dominio` | Entidades, contrato del repositorio y casos de uso. No conoce Flutter ni HTTP. |
| Datos | `lib/ingreso/datos` | Llama a `POST /api/auth/correo` y `POST /api/auth/enlace` y traduce el JSON. |
| Presentación | `lib/ingreso/presentacion` | `IngresoBloc` decide la pantalla. Las vistas solo muestran y avisan. |
| Textos | `lib/capas/textos` | Nombres de todo lo que se lee. |
| Estilos | `lib/capas/estilos` | Colores, estilos de texto y tema. |
| Variables | `lib/capas/variables` | Medidas, 6 dígitos, 5 minutos, URL y rutas. |
| Ensamble | `lib/aplicacion/ensamble.dart` | Crea el cliente, el repositorio y el BLoC. |

`lib/main.dart` arranca el ensamble y no construye pantallas ni llamadas.

## El ingreso

1. La pantalla de correo dispara `CodigoSolicitado`.
2. El BLoC revisa el correo y llama a `PedirCodigo`.
3. Si el servicio responde bien, pasa a las seis casillas y empieza un reloj de 5 minutos.
4. `CodigoConfirmado` llama a `ConfirmarCodigo`. Si el código sigue vigente, la pantalla muestra la sesión.
5. A los 5 minutos el reloj deja el código vencido y el botón de entrar se apaga. Reenviar pide otro.

Google está en la pantalla como segunda puerta. Todavía no abre sesión: falta el cliente de Google en la app. El botón lo dice.

## Dónde se cambia cada cosa

- Una frase: `lib/capas/textos/textos_app.dart`
- Un color o un estilo de letra: `lib/capas/estilos/`
- El tamaño de un botón, los dígitos o la URL: `lib/capas/variables/variables_app.dart`

La app llama al servicio en `http://192.168.0.25:8000`, la IP del Wi-Fi de esta máquina. El teléfono y la computadora tienen que estar en la misma red. Si la IP cambia, se actualiza `urlBase` en `lib/capas/variables/variables_app.dart`.

## Arranque

El servicio de cuenta tiene que estar corriendo. En otra terminal, desde `detectores_backend`:

```bash
source .venv/bin/activate
python3 main.py
```

Después, en `copiloto_app`:

```bash
flutter pub get
flutter run
```
# copiloto_app
