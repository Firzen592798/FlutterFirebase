# flutter_login

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application that follows the
[simple app state management
tutorial](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple).

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).

## Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)

# Firebase

npm install -g firebase-tools
dart pub global activate flutterfire_cli
Adicionar C:\Users\USER\AppData\Local\Pub\Cache\bin nas variaveis de ambiente
Verifica que tá ok com os dois comandos abaixo
firebase -V
flutterfire -v
 
firebase login
flutterfire configure
Caso não dê certo, dar um firebase logout

Instalar as dependências do firebase: firebase_core é obrigatória. firebase_database para realtime database e firebase_auth para a autenticação e firebase_messaging para o FCM

# Keystore certificado

Usar o comando abaixo para ver o fingerprint e add no 
keytool -list -v -keystore C:\Users\USER\.android\debug.keystore -alias androiddebugkey

No ícone da engrenagem ao lado de Visão Gerao do projeto, verificar onde tem a config do aplicativo para cada um dos ambientes(android, ios e web) e adicionar o SHA correspondente

# Autenticação

Para habilitar a autenticação, lembrar de ir em Authentication e habilitar os sign-in method desejados

# Firebase Cloud Messaging

