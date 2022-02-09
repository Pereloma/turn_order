import 'package:formz/formz.dart';

enum CharacterHPValidError { error }

class CharacterHPValid extends FormzInput<String, CharacterHPValidError>{
  const CharacterHPValid.pure() : super.pure('');
  const CharacterHPValid.dirty([String value = '']) : super.dirty(value);

  @override
  CharacterHPValidError? validator(String value) {
    if(value.isEmpty){
      return null;
    }
    int? intValue = int.tryParse(value);
    if(intValue == null){
      return CharacterHPValidError.error;
    }

    return null;
  }

}