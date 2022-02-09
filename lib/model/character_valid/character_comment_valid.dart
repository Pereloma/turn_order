import 'package:formz/formz.dart';

enum CharacterCommentValidError { error }

class CharacterCommentValid extends FormzInput<String, CharacterCommentValidError>{
  const CharacterCommentValid.pure() : super.pure('');
  const CharacterCommentValid.dirty([String value = '']) : super.dirty(value);

  @override
  CharacterCommentValidError? validator(String value) {
    return null;
  }

}