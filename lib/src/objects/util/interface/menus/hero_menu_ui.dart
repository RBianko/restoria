import 'dart:math';

import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/drag_target.dart' as s;
import 'package:restoria/src/objects/playerHero/player_hero_controller.dart';
import 'package:restoria/src/objects/skills/skills.dart';
import 'package:restoria/src/objects/util/interface/menus/hero_menu_controller.dart';

class HeroMenu extends StatefulWidget {
  const HeroMenu({Key? key}) : super(key: key);

  @override
  State<HeroMenu> createState() => _HeroMenuState();
}

class _HeroMenuState extends State<HeroMenu> {
  late PlayerHeroController heroController;

  @override
  void initState() {
    // heroController.skills = [];
    // heroController.skills.add(Skill(level: 2, id: SkillsId.fireball));
    // heroController.skills.add(Skill(level: 1, id: SkillsId.iceLance));
    // heroController.skills.add(Skill(level: 3, id: SkillsId.iceLance));
    // heroController.skills.add(Skill(level: 1, id: SkillsId.fireball));
    // heroController.skills.add(Skill.none());
    // heroController.skills.add(Skill.none());
    // heroController.skills.add(Skill.none());
    // heroController.skills.add(Skill.none());
    // heroController.skills.add(Skill.none());
    // heroController.skills.add(Skill.none());
    // heroController.skills.add(Skill(level: 2, id: SkillsId.iceLance));
    // heroController.skills.add(Skill.none());
    // heroController.skills.add(Skill.none());
    // heroController.skills.add(Skill.none());
    // heroController.skills.add(Skill.none());
    super.initState();
    heroController = BonfireInjector().get<PlayerHeroController>();
  }

  @override
  Widget build(BuildContext context) {
    /// SKILLS SLOT UI
    Widget slotContent(Skill slot) => Container(
          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(5)), color: slot.iconBackground),
          child: Material(
            type: MaterialType.transparency,
            child: Stack(
              children: [
                Positioned(
                  bottom: -3,
                  child: Container(
                    width: 50,
                    child: Text(
                      '★' * slot.level,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black45),
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: Center(
                    child: Text(
                      slot.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12, color: Colors.black45),
                    ),
                  ),
                )
              ],
            ),
          ),
        );

    /// SKILLS MOVEMENT
    void moveSlots(Skill source, Skill target) {
      if (source.id == 'None') return;
      int sI = heroController.skills.indexOf(source);
      int tI = heroController.skills.indexOf(target);
      setState(() {
        heroController.skills.replaceRange(sI, sI + 1, [target]);
        heroController.skills.replaceRange(tI, tI + 1, [source]);
      });
    }

    Widget wrapWithDragTarget(child, Skill slot) => DragTarget(onAccept: (Skill data) {
          moveSlots(data, slot);
        }, builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          return Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                border: Border.all(color: accepted.isEmpty ? Colors.transparent : Colors.grey, width: 2, strokeAlign: StrokeAlign.outside),
              ),
              child: child);
        });

    Widget buildDraggableSlot(Skill slot) {
      return s.Draggable<Skill>(
        data: slot,
        feedback: slotContent(slot),
        child: wrapWithDragTarget(slotContent(slot), slot),
      );
    }

    /// SKILLS COMBINE
    Future combine(Skill skill, int index) async {
      await Future.delayed(const Duration(milliseconds: 200));
      List toEmpty = [];

      for (Skill otherSkill in heroController.skills) {
        if (skill.id == otherSkill.id && skill.level == otherSkill.level) {
          toEmpty.add(heroController.skills.indexOf(otherSkill));
        }
      }
      for (int skillToEmpty in toEmpty) {
        heroController.skills.replaceRange(skillToEmpty, skillToEmpty + 1, [Skill.none()]);
      }

      setState(() {
        heroController.skills[index] = (Skill(id: skill.id, level: min(3, ++skill.level)));
      });
    }

    Future checkForCombine() async {
      Skill? combineSkill;
      int? index;

      for (Skill skill in heroController.skills) {
        if (skill.id == 'None') continue;
        int consequences = 1;

        for (Skill otherSkill in heroController.skills.skip(heroController.skills.indexOf(skill) + 1)) {
          if (otherSkill.id == 'None') continue;
          if (skill.level < 3 && skill.id == otherSkill.id && skill.level == otherSkill.level) consequences++;
          if (consequences == 3) {
            index = heroController.skills.indexOf(skill);
            combineSkill = skill;
            break;
          }
        }
      }

      if (combineSkill != null) await combine(combineSkill, index!);
    }

    checkForCombine();

    return Material(
      type: MaterialType.transparency,
      child: StateControllerConsumer<HeroMenuController>(
        builder: (context, controller) {
          if (controller.show || (controller.isVisible && controller.show)) {
            controller.isVisible = true;
            return Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                  width: 400,
                  height: 230,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/ui/menu.png',
                          filterQuality: FilterQuality.none,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 55,
                        left: 10,
                        child: ElevatedButton(
                          onPressed: () => setState(() {
                            Skill emptySlot = heroController.skills.firstWhere((slot) => slot.id == 'None');
                            int emptySlotIndex = heroController.skills.indexOf(emptySlot);
                            heroController.skills.replaceRange(emptySlotIndex, emptySlotIndex + 1, [Skill(id: SkillsId.fireball, level: 1)]);
                          }),
                          child: Icon(Icons.add),
                        ),
                      ),
                      Positioned(
                        top: 55,
                        left: 70,
                        child: ElevatedButton(
                          onPressed: () => setState(() {
                            Skill emptySlot = heroController.skills.firstWhere((slot) => slot.id == 'None');
                            int emptySlotIndex = heroController.skills.indexOf(emptySlot);
                            heroController.skills.replaceRange(emptySlotIndex, emptySlotIndex + 1, [Skill(id: SkillsId.hurricane, level: 1)]);
                          }),
                          child: Icon(Icons.add),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(23, 10, 15, 15),
                          child: Wrap(
                            spacing: 27,
                            children: [
                              ...heroController.skills.take(5).map((Skill slot) => buildDraggableSlot(slot)).toList(),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15, 33, 15, 0),
                                child: Wrap(
                                  spacing: 17,
                                  runSpacing: 17,
                                  children: [...heroController.skills.skip(5).map((Skill slot) => buildDraggableSlot(slot)).toList()],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          if (!controller.show && controller.isVisible) {
            controller.isVisible = false;
            return Container();
          } else {
            controller.isVisible = false;
            return Container();
          }
        },
      ),
    );
  }
}
