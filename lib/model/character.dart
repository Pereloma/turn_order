import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:turn_order/repository/icons_repository.dart';

class Character extends Equatable{
  final String name;
  final int? hp;
  final int initiative;
  final int dexterity;
  final int? queue;
  final String? comment;

  final IconsName iconsName;
  final Color color;

  const Character({
    required this.name,
    this.hp,
    required this.initiative,
    this.dexterity = 0,
    this.queue,
    this.comment,
    this.iconsName = IconsName.weapon_30,
    this.color = Colors.black
  });

  Character copyWith({
    String? name,
    int? hp,
    int? initiative,
    int? dexterity,
    int? queue,
    String? comment,
    IconsName? iconsName,
    Color? color
  }) {
    return Character(
      name: name ?? this.name,
      hp: hp ?? this.hp,
      initiative: initiative ?? this.initiative,
      dexterity: dexterity ?? this.dexterity,
      queue: queue ?? this.queue,
      comment: comment ?? this.comment,
      iconsName: iconsName ?? this.iconsName,
      color: color?? this.color
    );
  }

  @override
  List<Object?> get props => [name, initiative, dexterity, queue, hp, iconsName, color];

}