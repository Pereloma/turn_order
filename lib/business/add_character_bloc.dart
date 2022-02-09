import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:turn_order/model/character.dart';
import 'package:turn_order/model/character_valid/character_comment_valid.dart';
import 'package:turn_order/model/character_valid/character_dexterity_valid.dart';
import 'package:turn_order/model/character_valid/character_hp_valid.dart';
import 'package:turn_order/model/character_valid/character_initiative_valid.dart';
import 'package:turn_order/model/character_valid/character_name_valid.dart';
import 'package:turn_order/repository/icons_repository.dart';

part 'add_character_event.dart';

part 'add_character_state.dart';

class AddCharacterBloc extends Bloc<AddCharacterEvent, AddCharacterState> {
  AddCharacterBloc()
      : super(const AddCharacterState()) {
    _onEvent();
  }
  AddCharacterBloc.character(Character character)
      : super(AddCharacterState.stateFromCharacter(character)) {
    _onEvent();
  }
  void _onEvent (){
    on<CharacterNameChanged>(_onCharacterNameChanged);
    on<CharacterInitiativeChanged>(_onCharacterInitiativeChanged);
    on<CharacterDexterityChanged>(_onCharacterDexterityChanged);
    on<CharacterHPChanged>(_onCharacterHPChanged);
    on<CharacterCommentChanged>(_onCharacterCommentChanged);

    on<CharacterSubmitted>(_onCharacterSubmitted);

    on<ColorAndIconChanged>(_onColorAndIconChanged);
  }


  void _onCharacterNameChanged(
    CharacterNameChanged event,
    Emitter<AddCharacterState> emit,
  ) {
    final name = CharacterNameValid.dirty(event.name);
    emit(state.copyWith(
      name: name,
      status: Formz.validate(
          [name, state.initiative, state.dexterity, state.hp, state.comment]),
    ));
  }

  void _onCharacterInitiativeChanged(
    CharacterInitiativeChanged event,
    Emitter<AddCharacterState> emit,
  ) {
    final initiative = CharacterInitiativeValid.dirty(event.initiative);
    emit(state.copyWith(
      initiative: initiative,
      status: Formz.validate(
          [state.name, initiative, state.dexterity, state.hp, state.comment]),
    ));
  }

  void _onCharacterDexterityChanged(
    CharacterDexterityChanged event,
    Emitter<AddCharacterState> emit,
  ) {
    final dexterity = CharacterDexterityValid.dirty(event.dexterity);
    emit(state.copyWith(
      dexterity: dexterity,
      status: Formz.validate(
          [state.name, state.initiative, dexterity, state.hp, state.comment]),
    ));
  }

  void _onCharacterHPChanged(
    CharacterHPChanged event,
    Emitter<AddCharacterState> emit,
  ) {
    final hp = CharacterHPValid.dirty(event.hp);
    emit(state.copyWith(
      hp: hp,
      status: Formz.validate(
          [state.name, state.initiative, state.dexterity, hp, state.comment]),
    ));
  }

  void _onCharacterCommentChanged(
    CharacterCommentChanged event,
    Emitter<AddCharacterState> emit,
  ) {
    final comment = CharacterCommentValid.dirty(event.comment);
    emit(state.copyWith(
      comment: comment,
      status: Formz.validate(
          [state.name, state.initiative, state.dexterity, state.hp, comment]),
    ));
  }

  void _onCharacterSubmitted(
    CharacterSubmitted event,
    Emitter<AddCharacterState> emit,
  ) {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    Character character = Character(
        name: state.name.value,
        initiative: int.parse(state.initiative.value),
        dexterity: int.tryParse(state.dexterity.value) ?? 0,
        hp: int.tryParse(state.hp.value),
        comment: state.comment.value,

        iconsName: state.iconsName,
      color: state.color,
    );

    //event.context.read<TurnBloc>().add(AddCharacterInTurnEvent(character));
    Navigator.of(event.context).pop(character);
  }

  void _onColorAndIconChanged(
      ColorAndIconChanged event,
      Emitter<AddCharacterState> emit,
      ) {
    emit(state.copyWith(color: event.color,iconsName: event.iconsName));
  }
}
