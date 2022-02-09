import 'package:formz/formz.dart';

enum CharacterInitiativeValidError { empty, error, tooSmall}

class CharacterInitiativeValid extends FormzInput<String, CharacterInitiativeValidError>{
  const CharacterInitiativeValid.pure() : super.pure('');
  const CharacterInitiativeValid.dirty([String value = '']) : super.dirty(value);

  @override
  CharacterInitiativeValidError? validator(String value) {
    if(value.isEmpty){
      return CharacterInitiativeValidError.empty;
    }
    int? intValue = int.tryParse(value);
    if(intValue == null){
      return CharacterInitiativeValidError.error;
    }
    else if(intValue < 1){
      return CharacterInitiativeValidError.tooSmall;
    }

    return null;
  }

}