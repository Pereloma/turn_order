import 'package:formz/formz.dart';

enum CharacterNameValidError { empty }

class CharacterNameValid extends FormzInput<String, CharacterNameValidError>{
  const CharacterNameValid.pure() : super.pure('');
  const CharacterNameValid.dirty([String value = '']) : super.dirty(value);

  @override
  CharacterNameValidError? validator(String value) {
    return value.isNotEmpty == true ? null : CharacterNameValidError.empty;
  }
  
}