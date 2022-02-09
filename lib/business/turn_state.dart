part of 'turn_bloc.dart';

class TurnState extends Equatable {
  final List<Character> characters;
  final List<Character> waitCharacters;
  final int lap;
  final int move;
  final TurnState? previousState;

  const TurnState._(
      {required this.characters,
      required this.waitCharacters,
      required this.lap,
      required this.move,
      this.previousState
      });

  TurnState copyWith({
    List<Character>? characters,
    List<Character>? waitCharacters,
    int? lap,
    int? move
  }) {
    return TurnState._(
      characters: characters ?? this.characters,
      waitCharacters: waitCharacters ?? this.waitCharacters,
      lap: lap ?? this.lap,
      move: move ?? this.move,
      previousState: copyWithNonPreviousState(),
    );
  }

  TurnState copyWithNonPreviousState({
    List<Character>? characters,
    List<Character>? waitCharacters,
    int? lap,
    int? move,
  }) {
    return TurnState._(
      characters: characters ?? this.characters,
      waitCharacters: waitCharacters ?? this.waitCharacters,
      lap: lap ?? this.lap,
      move: move ?? this.move,
      previousState: null,
    );
  }

  @override
  List<Object?> get props => [characters, waitCharacters, lap, move];
}

class TurnInitial extends TurnState {
  TurnInitial() : super._(characters: [], waitCharacters: [], lap: 0, move: 0);
}
