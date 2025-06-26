import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Joystick extends JoystickComponent {
  Joystick()
      : super(
          knob: CircleComponent(radius: 20, paint: Paint()..color = Colors.white70),
          background: CircleComponent(radius: 50, paint: Paint()..color = Colors.white24),
          margin: const EdgeInsets.only(left: 40, bottom: 40),
        );
}
