import 'package:flutter/material.dart';

class SkillButtons extends StatefulWidget {
  final void Function(String skill) onSkillTap;
  const SkillButtons({super.key, required this.onSkillTap});

  @override
  State<SkillButtons> createState() => _SkillButtonsState();
}

class _SkillButtonsState extends State<SkillButtons> {
  Map<String, bool> cooldown = {
    'fireball': false,
    'dash': false,
    'shield': false,
  };

  void triggerSkill(String skill, Duration duration) {
    if (!cooldown[skill]!) {
      widget.onSkillTap(skill);
      setState(() => cooldown[skill] = true);
      Future.delayed(duration, () {
        setState(() => cooldown[skill] = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 20,
      child: Column(
        children: [
          _skillButton('🔥', 'fireball', const Duration(seconds: 4)),
          _skillButton('⚡', 'dash', const Duration(seconds: 3)),
          _skillButton('🛡️', 'shield', const Duration(seconds: 6)),
        ],
      ),
    );
  }

  Widget _skillButton(String icon, String skill, Duration cd) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () => triggerSkill(skill, cd),
        child: Opacity(
          opacity: cooldown[skill]! ? 0.5 : 1,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black45,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white),
            ),
            child: Text(icon, style: const TextStyle(fontSize: 24)),
          ),
        ),
      ),
    );
  }
}
