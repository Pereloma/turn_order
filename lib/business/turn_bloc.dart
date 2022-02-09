import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:turn_order/model/character.dart';

part 'turn_event.dart';

part 'turn_state.dart';

class TurnBloc extends Bloc<TurnEvent, TurnState> {
  TurnBloc() : super(TurnInitial()) {
    on<AddCharacterInTurnEvent>(_onAddCharacterInTurnEvent);
    on<NextCharacterTurnEvent>(_onNextCharacterTurnEvent);
    on<DismissibleCharacterTurnEvent>(_onDismissibleCharacterTurnEvent);
    on<EditCharacterTurnEvent>(_onEditCharacterTurnEvent);
    on<BackStateTurnEvent>(_onBackStateTurnEvent);
  }

  void _onAddCharacterInTurnEvent(
    AddCharacterInTurnEvent event,
    Emitter<TurnState> emit,
  ) {
    TurnState newState;
    if (state.move == 0) {
      newState = state.copyWith(
          characters: _sortCharacters(
              <Character>[...state.characters, event.character]));
    } else {
      newState = state
          .copyWith(waitCharacters: [...state.waitCharacters, event.character]);
    }
    emit(newState);
  }

  void _onNextCharacterTurnEvent(
    NextCharacterTurnEvent event,
    Emitter<TurnState> emit,
  ) {
    final int move;
    final int lap;
    if (state.move + 1 >= state.characters.length) {
      move = 0;
      lap = state.lap + 1;

      emit(state.copyWith(
          move: move,
          lap: lap,
          characters:
              _sortCharacters([...state.characters, ...state.waitCharacters]),
          waitCharacters: []));
    } else {
      move = state.move + 1;

      emit(state.copyWith(
          move: move, characters: _nextCharacters(state.characters)));
    }
  }

  void _onDismissibleCharacterTurnEvent(
    DismissibleCharacterTurnEvent event,
    Emitter<TurnState> emit,
  ) {
    emit(state.copyWith(
        waitCharacters: [...state.waitCharacters]..remove(event.character),
        characters: [...state.characters]..remove(event.character)));
  }

  void _onEditCharacterTurnEvent(
    EditCharacterTurnEvent event,
    Emitter<TurnState> emit,
  ) {
    TurnState newState;
    if (state.move == 0) {
      newState = state.copyWith(
          characters: _sortCharacters(<Character>[
        ...state.characters
          ..remove(event.oldCharacter)
          ..add(event.newCharacter)
      ]));
    }
    else {
      int index = state.waitCharacters.indexOf(event.oldCharacter);
      if (index >= 0) {
        newState = state.copyWith(
            waitCharacters: _replaceCharacters(state.waitCharacters,event.newCharacter,index)
        );
      }
      index  = state.characters.indexOf(event.oldCharacter);
      if (index >= 0) {
        newState = state.copyWith(
            characters: _replaceCharacters(state.characters,event.newCharacter,index)
        );
      }else{
        newState = state.copyWith();
      }
    }
    emit(newState);
  }

  void _onBackStateTurnEvent(
      BackStateTurnEvent event,
      Emitter<TurnState> emit,
      ) {
    if(state.previousState != null){
      emit(state.previousState!);
    }
  }
}

List<Character> _sortCharacters(List<Character> characters) {
  characters.sort((a, b) {
    if (a.initiative > b.initiative) {
      return -1;
    } else if (a.initiative > b.initiative) {
      return 1;
    } else {
      if (a.dexterity > b.dexterity) {
        return -1;
      } else {
        return 1;
      }
    }
  });

  List<Character> result = [];
  for (int i = 0; i < characters.length; i++) {
    result.add(characters[i].copyWith(queue: i + 1));
  }

  return result;
}

List<Character> _nextCharacters(List<Character> characters) {
  Character character = characters.removeAt(0);
  characters.add(character);
  return characters;
}

List<Character> _replaceCharacters(List<Character> characters,Character character,int index) {
  List<Character> result = [];
  for (int i = 0; i < characters.length; i++) {
    if(index == i){
      result.add(character);
    }
    else{
      result.add(characters[i]);
    }
  }
  return result;
}