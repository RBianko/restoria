import 'package:bonfire/bonfire.dart';
import 'package:flutter/services.dart';
import 'package:restoria/src/objects/playerHero/player_hero.dart';
import 'package:restoria/src/objects/skills/skills.dart';

/// credits to Rafaelbarbosatec

class PlayerHeroController extends StateController<PlayerHero> {
  double stamina = 100;
  double attack = 50;
  int attackSpeed = 950;
  bool canShowEmote = true;
  bool showedDialog = false;
  double radAngleRangeAttack = 0;
  List<Skill> skills = List.generate(15, (index) => Skill.none());

  @override
  void update(double dt, PlayerHero component) {
    for (Skill skill in skills.getRange(0, 5)) {
      if (skill.id == 'None') continue;
      bool checkSkillInterval = component.checkInterval(
        '${skill.id}-${skill.uKey}',
        skill.skillStat.interval,
        dt,
      );
      if (checkSkillInterval) {
        component.executeSkill(skill);
      }
    }

    _verifyStamina(dt);
  }

  void handleJoystickAction(JoystickActionEvent event) {
    if (event.event == ActionEvent.DOWN) {
      if (event.id == LogicalKeyboardKey.space.keyId || event.id == HeroAttackType.attackMelee) {
        if (stamina > 15) {
          _decrementStamina(15);
          component?.execMeleeAttack(attack);
        }
      }
    }
  }

  void _verifyStamina(double dt) {
    if (stamina < 100 && component?.checkInterval('INCREMENT_STAMINA', 100, dt) == true) {
      stamina += 2;
      if (stamina > 100) {
        stamina = 100;
      }
    }
    component?.updateStamina(stamina);
  }

  void _decrementStamina(int i) {
    stamina -= i;
    if (stamina < 0) {
      stamina = 0;
    }
    component?.updateStamina(stamina);
  }

  void onReceiveDamage(double damage) {
    component?.execShowDamage(damage);
  }
}
