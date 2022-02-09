part of 'add_character_bloc.dart';

@immutable
abstract class AddCharacterEvent extends Equatable {
  const AddCharacterEvent();

  @override
  List<Object> get props => [];
}

class CharacterNameChanged extends AddCharacterEvent {
  const CharacterNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}
class CharacterInitiativeChanged extends AddCharacterEvent {
  const CharacterInitiativeChanged(this.initiative);

  final String initiative;

  @override
  List<Object> get props => [initiative];
}
class CharacterDexterityChanged extends AddCharacterEvent {
  const CharacterDexterityChanged(this.dexterity);

  final String dexterity;

  @override
  List<Object> get props => [dexterity];
}
class CharacterHPChanged extends AddCharacterEvent {
  const CharacterHPChanged(this.hp);

  final String hp;

  @override
  List<Object> get props => [hp];
}
class CharacterCommentChanged extends AddCharacterEvent {
  const CharacterCommentChanged(this.comment);

  final String comment;

  @override
  List<Object> get props => [comment];
}

class CharacterSubmitted extends AddCharacterEvent {
  const CharacterSubmitted(this.context);
  final BuildContext context;
}

class ColorAndIconChanged extends AddCharacterEvent {
  const ColorAndIconChanged({required this.iconsName, required this.color});
  final IconsName iconsName;
  final Color color;
}