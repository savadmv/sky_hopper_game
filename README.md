# sky_hopper_game

A reusable Flutter game package that provides the core logic, assets, and widgets for the Sky Hopper mini-game. Drop it into any Flutter app to embed a fully working game view and score tracking.

[![pub version](https://img.shields.io/pub/v/sky_hopper_game.svg)](https://pub.dev/packages/sky_hopper_game)

## Features

- `GameView` widget that renders the Sky Hopper game canvas
- Built-in audio and sound effect management
- Provider-based state management for score, lives, etc.
- Easily customize sprite assets and sound files
- Example app showing basic integration

## Installation

1. In your app’s `pubspec.yaml`, add:

   ```yaml
   dependencies:
     sky_hopper_game: ^0.1.0
   ```

2. Run:
   ```bash
   flutter pub get
   ```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:sky_hopper_game/sky_hopper_game.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Sky Hopper Demo')),
        body: const Center(child: GameView()),
      ),
    );
  }
}
```

Assets (images, audio) are automatically packaged with the module; no additional setup is required for consuming apps.

## API Reference

- `GameView`: The main widget that renders Sky Hopper.  
 
