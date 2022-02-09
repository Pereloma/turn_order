part of 'turn_bloc.dart';

abstract class TurnEvent extends Equatable {}

class AddCharacterInTurnEvent extends TurnEvent {
  final Character character;
  AddCharacterInTurnEvent(this.character);

  @override
  List<Object?> get props => [character];
}

class NextCharacterTurnEvent extends TurnEvent {
  NextCharacterTurnEvent();

  @override
  List<Object?> get props => [];
}

class DismissibleCharacterTurnEvent extends TurnEvent {
  final Character character;
  DismissibleCharacterTurnEvent(this.character);

  @override
  List<Object?> get props => [character];
}

class TabCharacterTurnEvent extends TurnEvent {
  final Character character;
  TabCharacterTurnEvent(this.character);

  @override
  List<Object?> get props => [character];
}

class EditCharacterTurnEvent extends TurnEvent {
  final Character oldCharacter;
  final Character newCharacter;
  EditCharacterTurnEvent(this.oldCharacter, this.newCharacter);

  @override
  List<Object?> get props => [oldCharacter, newCharacter];
}

class BackStateTurnEvent extends TurnEvent {
  BackStateTurnEvent();

  @override
  List<Object?> get props => [];
}