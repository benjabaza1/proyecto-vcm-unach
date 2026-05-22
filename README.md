# Proyecto VCM - Video del Jueves UNACH

Aplicación móvil desarrollada en Flutter para la Evaluación N°2 de la asignatura Desarrollo Móvil Multiplataforma.

## Descripción

La aplicación presenta contenido audiovisual académico relacionado con proyectos de Vinculación con el Medio (VCM) de la Universidad Adventista de Chile. Además, permite registrar usuarios mediante correo institucional, visualizar un video, responder una encuesta y recibir una retroalimentación final mediante una insignia motivacional.

## Funcionalidades principales

- Pantalla splash institucional.
- Registro e inicio de sesión con correo `@alu.unach.cl`.
- Pantalla de inicio con descripción del proyecto.
- Reproducción de video académico.
- Carga automática del video luego de 10 segundos.
- Controles básicos de reproducción.
- Encuesta con tres campos de texto.
- Registro de respuestas en Firebase Firestore.
- Almacenamiento de:
    - correo del usuario,
    - respuestas de la encuesta,
    - modelo del dispositivo,
    - sistema operativo,
    - fecha y hora del envío.
- Pantalla final con mensaje de felicitación e insignia.

## Tecnologías utilizadas

- Flutter
- Dart
- Firebase Authentication
- Cloud Firestore
- Firebase Core
- Device Info Plus
- Video Player
- Google Fonts

## Requisitos
- Flutter instalado.
- Android Studio.
- Emulador Android o dispositivo físico.
- Firebase configurado.
- Conexión a internet.



## Estructura del proyecto

```text
lib/
 ├── constants/
 ├── models/
 ├── screens/
 ├── services/
 ├── widgets/
 ├── app.dart
 ├── firebase_options.dart
 └── main.dart

## Instalación y ejecución

### Clonar el repositorio

```bash
git clone URL_DEL_REPOSITORIO
```

### Entrar al proyecto

```bash
cd ProyectoVCM
```

### Instalar dependencias

```bash
flutter pub get
```

### Ejecutar la aplicación

```bash
flutter run
```

---

## Capturas de pantalla

CAPTURAS EN CARPETA SCRENSHOTS:

- Splash screen
- Login
- Registro
- Inicio
- Video
- Encuesta
- Pantalla final


---

## Autor

Benjamín Baza  
Universidad Adventista de Chile  
Facultad de Ingeniería y Negocios
